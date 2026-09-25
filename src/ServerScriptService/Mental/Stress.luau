--!strict
-- M0 stres (DESAIN_AI_NPC_V0 §3.2–3.3): diatesis–stres + allostatic load.
--   vul (turunan, 0–100) = 0,5·E + 0,3·(100−cou) + 0,2·(100−C) + 3/kehilangan ikatan intim (cou GENETIK)
--   ambang patah = 90 − 0,3·vul − 0,2·ld
--   st (harian) += (Σsumber + tarikan kebutuhan)·(1 + ld/200) − Σpenurun − pulih_dasar
--   ld +1/hari saat st ≥ 60 (setelah ≥1 hari), −1/hari setelah ≥7 hari berturut st < 40
-- Fungsi murni: menerima state & mengembalikan state baru + event; input tidak dimutasi.
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)
local Formula = require(ServerScriptService.Autonomy.Formula)
local Needs = require(ServerScriptService.Autonomy.Needs)

local S = NpcData.stress
local SRC = S.sources
local RED = S.reducers

-- `hi`/`lo` = hari berturut st ≥ ld.riseAtSt / st < ld.fallBelowSt; `cd` = hari tempur berturut (kurva combat fatigue).
export type State = { st: number, ld: number, hi: number, lo: number, cd: number }
export type Ctx = {
	heroId: string,
	dims: { [string]: number }, -- sifat (§1.2)
	xp: number, -- §1.2a (pemulihan dasar)
	intimateLosses: number, -- jumlah kehilangan ikatan intim seumur hidup (riwayat vul)
	goals: { string }, -- §1.3 (goal "calm" kebal "tidak dilibatkan")
	aversion: string?, -- §1.4 id keengganan
	needs: Needs.Needs, -- kebutuhan akhir hari (Needs.step lebih dulu)
}
-- Peristiwa satu hari in-game (§3.3); jumlah = kali kejadian hari itu.
export type Day = {
	missions: number?,
	humanoidMissions: number?, -- bagian dari `missions` yang melawan EnemyData.isHumanoid
	comradeDiedBeside: number?,
	intimateDiedBeside: number?, -- rekan ikatan intim mati di sisinya (×2)
	roomDeaths: number?, -- rekan lain di room mati
	synthesisWitnessed: number?,
	synthesisWitnessedClose: number?, -- yang disintesis rekan dekat
	synthesisThreat: number?,
	trainingSessions: number?,
	researchHours: number?,
	notInvolvedDays: number?, -- hari berturut tidak dilibatkan (termasuk hari ini)
	position: boolean?, -- beban jabatan
	demoted: number?, -- diturunkan lantai/party; digantikan
	punished: number?,
	moralInjury: number?, -- pemicu luka moral §3.4 (guilt di tugas 2.4)
	rest: boolean?, -- aksi istirahat
	sleepWell: boolean?, -- tidur cukup (pengali aksi istirahat)
	trustedSupport: boolean?, -- dukungan rekan t ≥ 9 (pengali pemulihan)
	hobby: boolean?,
	vacation: boolean?,
	giftMatch: boolean?, -- hanya bila st awal hari < 70
	cheering: number?,
	eatTogether: boolean?,
	floorUpOrMvp: number?,
	comfortItem: boolean?,
	griefRitual: boolean?,
	goalAchieved: boolean?,
}
export type StressEvent = { kind: "stressBreak", heroId: string }

local Stress = {}

function Stress.initial(): State
	return { st = S.initialSt, ld = S.initialLd, hi = 0, lo = 0, cd = 0 }
end

function Stress.vul(dims: { [string]: number }, intimateLosses: number): number
	return math.clamp(Formula.linear(S.vul, dims) + S.vulPerIntimateLoss * intimateLosses, 0, 100)
end

function Stress.breakThreshold(vul: number, ld: number): number
	return Formula.linear(S.breakThreshold, { vul = vul, ld = ld })
end

function Stress.recoverBase(vul: number, xp: number): number
	return Formula.product(S.recoverBase, { vul = vul, xp = xp })
end

-- Pengali misi dari hari tempur berturut: ambil langkah terbesar yang sudah tercapai.
local function streakMult(combatDays: number): number
	local m = 1
	for _, step in SRC.combatStreakMult do
		if combatDays >= step.days then
			m = step.mult
		end
	end
	return m
end

-- Misi vs humanoid: +min bila satu faktor (keengganan "humanoid" ATAU A tinggi), +max bila keduanya.
local function humanoidRise(ctx: Ctx): number
	local factors = (if ctx.aversion == "humanoid" then 1 else 0)
		+ (if ctx.dims.A >= NpcData.moralInjury.humanoidMinA then 1 else 0)
	return if factors >= 2 then SRC.humanoid.max elseif factors == 1 then SRC.humanoid.min else 0
end

local function sources(ctx: Ctx, day: Day, combatDays: number): number
	local r = SRC.mission * (day.missions or 0) * streakMult(combatDays)
	r += humanoidRise(ctx) * (day.humanoidMissions or 0)
	r += SRC.comradeDiedBeside * (day.comradeDiedBeside or 0)
	r += SRC.comradeDiedBeside * SRC.intimateMult * (day.intimateDiedBeside or 0)
	r += SRC.roomDeath * (day.roomDeaths or 0)
	r += SRC.synthesisWitnessed * (day.synthesisWitnessed or 0)
	r += SRC.synthesisWitnessedClose * (day.synthesisWitnessedClose or 0)
	r += SRC.synthesisThreat * (day.synthesisThreat or 0)
	r += SRC.trainingPerExtraSession * math.max(0, (day.trainingSessions or 0) - SRC.trainingSessionsFree)
	r += SRC.researchPerExtraHour * math.max(0, (day.researchHours or 0) - SRC.researchHoursFree)
	if (day.notInvolvedDays or 0) >= SRC.notInvolvedDays and not table.find(ctx.goals, "calm") then
		r += SRC.notInvolvedPerDay
	end
	if day.position then
		r += SRC.positionPerDay
	end
	r += SRC.demoted * (day.demoted or 0)
	r += SRC.punished * (day.punished or 0)
	r += SRC.moralInjury * (day.moralInjury or 0)
	return r
end

-- Σ penurun (nilai data negatif) → besaran positif.
local function reducers(day: Day, st0: number): number
	local r = 0
	if day.rest then
		r += RED.rest * (if day.sleepWell then RED.sleepMult else 1)
	end
	if day.hobby then
		r += RED.hobby
	end
	if day.vacation then
		r += RED.vacationPerDay
	end
	if day.giftMatch and st0 < RED.giftMatchMaxSt then
		r += RED.giftMatch
	end
	r += RED.cheering * (day.cheering or 0)
	if day.eatTogether then
		r += RED.eatTogether
	end
	r += RED.floorUpOrMvp * (day.floorUpOrMvp or 0)
	if day.comfortItem then
		r += RED.comfortItemPerDay
	end
	if day.griefRitual then
		r += RED.griefRitual
	end
	if day.goalAchieved then
		r += RED.goalAchieved
	end
	return -r
end

local function needPull(n: Needs.Needs): number
	local p = 0
	for k, coef in S.needPull do
		p += coef * (100 - (n :: any)[k])
	end
	return p
end

-- Satu hari in-game. Urutan: Needs.step → Stress.step (tarikan memakai kebutuhan akhir hari).
function Stress.step(s: State, ctx: Ctx, day: Day): (State, { StressEvent })
	local vul = Stress.vul(ctx.dims, ctx.intimateLosses)
	local cd = if (day.missions or 0) > 0 then s.cd + 1 else 0

	local rise = (sources(ctx, day, cd) + needPull(ctx.needs)) * Formula.linear(S.riseMult, { ld = s.ld })
	local recover = Stress.recoverBase(vul, ctx.xp)
		* (if day.hobby then RED.hobbyMult else 1)
		* (if day.trustedSupport then RED.trustedSupportMult else 1)
	local st = math.clamp(s.st + rise - reducers(day, s.st) - recover, 0, 100)

	local L = S.ld
	local hi = if st >= L.riseAtSt then s.hi + 1 else 0
	local lo = if st < L.fallBelowSt then s.lo + 1 else 0
	local ld = s.ld
	if hi >= L.riseAfterDays then
		ld += 1
	end
	if lo >= L.fallAfterDays then
		ld -= 1
	end
	ld = math.clamp(ld, 0, 100)

	local events: { StressEvent } = {}
	if st >= Stress.breakThreshold(vul, ld) and s.st < Stress.breakThreshold(vul, s.ld) then
		local ev: StressEvent = { kind = "stressBreak", heroId = ctx.heroId }
		table.insert(events, ev)
	end
	return { st = st, ld = ld, hi = hi, lo = lo, cd = cd }, events
end

return table.freeze(Stress)
