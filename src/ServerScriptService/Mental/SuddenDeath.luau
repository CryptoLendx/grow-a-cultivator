--!strict
-- M0 sudden death (DESAIN_AI_NPC_V0 §3.5) [PSI §5 Joiner; kanon Mormont ch.7, ch.42]: hanya pada KOMBINASI faktor.
-- Roll harian hanya bila SEMUA: st ≥ ambang patah (§3.2) · rel < 30 · tanpa relasi ke hero HIDUP dengan t ≥ 9 atau
-- a ≥ 8 (relasi ke hero mati tidak melindungi) · (kehilangan besar ≤ 30 hari ATAU gagal ≥ 3 misi tanpa kontribusi).
-- Pelindung yang mematikan roll: ikatan hidup di atas; jabatan/murid yang bergantung padanya; dihibur ≤ 3 hari terakhir.
-- p = 0,03·(1 + vul_eff/100)·(1 + ld/100) per hari; vul_eff = rumus vul §3.2 dengan cou_eff (§1.2a) menggantikan cou
-- genetik (brief 2.4: "roll memakai cou_eff"; ambang patah tetap memakai vul genetik).
-- Warning [K] ch.284 saat st ≥ ambang − 15, 1× per episode (episode berakhir saat st turun di bawah titik itu).
-- ASUMSI (brief 2.4 "warning selalu mendahului kematian ≥3 hari"): roll hanya setelah warning episode ini berumur
-- ≥ warnWindow.min hari. Roll tetap berjalan saat pemain offline (§8.1) — modul ini dipanggil juga oleh catch-up.
-- Fungsi murni: menerima state & mengembalikan state baru + event; input tidak dimutasi.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)
local Rng = require(ReplicatedStorage.Shared.Rng)
local Formula = require(ServerScriptService.Autonomy.Formula)
local Stress = require(ServerScriptService.Mental.Stress)
local Experience = require(ServerScriptService.Mental.Experience)

local SD = NpcData.suddenDeath

-- `ws` = umur warning episode ini dalam hari (−1 = belum ada warning / di luar episode).
export type State = { ws: number }
export type Tie = { t: number, a: number, alive: boolean } -- relasi keluar hero ini (§4.2)
export type Ctx = {
	heroId: string,
	dims: { [string]: number }, -- sifat genetik (§1.2)
	intimateLosses: number, -- riwayat vul (§3.2)
	xp: number, -- §1.2a
	st: number, -- stres akhir hari (Stress.step lebih dulu)
	ld: number,
	rel: number, -- kebutuhan sosial akhir hari (Needs.step lebih dulu)
	ties: { Tie },
	dependents: boolean?, -- memegang jabatan / punya murid yang bergantung padanya
	comfortedDaysAgo: number?, -- hari sejak terakhir dihibur (nil = belum pernah)
	lossDaysAgo: number?, -- hari sejak kehilangan besar terakhir (nil = belum pernah)
	failedMissions: number?, -- misi beruntun gagal tanpa kontribusi
}
export type DeathEvent = { kind: "stressWarning" | "suddenDeath", heroId: string }

local SuddenDeath = {}

function SuddenDeath.initial(): State
	return { ws = -1 }
end

-- vul dengan cou_eff (hanya untuk p roll).
function SuddenDeath.vulEff(ctx: Ctx): number
	local d = table.clone(ctx.dims)
	d.cou = Experience.couEff(ctx.dims.cou, ctx.xp, ctx.ld)
	return Stress.vul(d, ctx.intimateLosses)
end

function SuddenDeath.threshold(ctx: Ctx): number
	return Stress.breakThreshold(Stress.vul(ctx.dims, ctx.intimateLosses), ctx.ld)
end

local function protected(ctx: Ctx): boolean
	for _, tie in ctx.ties do
		if tie.alive and (tie.t >= SD.protectT or tie.a >= SD.protectA) then
			return true
		end
	end
	if ctx.dependents then
		return true
	end
	return ctx.comfortedDaysAgo ~= nil and ctx.comfortedDaysAgo <= SD.comfortedWithinDays
end

-- Kombinasi faktor §3.5 (tanpa syarat umur warning).
function SuddenDeath.eligible(ctx: Ctx): boolean
	if ctx.st < SuddenDeath.threshold(ctx) or ctx.rel >= SD.relBelow or protected(ctx) then
		return false
	end
	local loss = ctx.lossDaysAgo ~= nil and ctx.lossDaysAgo <= SD.lossWithinDays
	return loss or (ctx.failedMissions or 0) >= SD.failedMissions
end

-- Peluang harian (0 bila kombinasi tidak lengkap).
function SuddenDeath.p(ctx: Ctx): number
	if not SuddenDeath.eligible(ctx) then
		return 0
	end
	return Formula.product(SD.p, { vul = SuddenDeath.vulEff(ctx), ld = ctx.ld })
end

-- Satu hari in-game (sesudah Needs.step & Stress.step). RNG hanya dipakai bila roll aktif.
function SuddenDeath.step(s: State, ctx: Ctx, rng: Rng.Rng): (State, { DeathEvent })
	local events: { DeathEvent } = {}
	if ctx.st < SuddenDeath.threshold(ctx) - SD.warnMargin then
		return { ws = -1 }, events -- di luar episode: warning berikutnya boleh dikirim lagi
	end
	local ws = s.ws + 1
	if s.ws < 0 then
		ws = 0
		local ev: DeathEvent = { kind = "stressWarning", heroId = ctx.heroId }
		table.insert(events, ev)
	end
	if ws >= SD.warnWindow.min then
		local p = SuddenDeath.p(ctx)
		if p > 0 and rng:NextNumber() < p then
			local ev: DeathEvent = { kind = "suddenDeath", heroId = ctx.heroId }
			table.insert(events, ev)
		end
	end
	return { ws = ws }, events
end

return table.freeze(SuddenDeath)
