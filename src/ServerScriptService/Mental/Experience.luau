--!strict
-- M0 pengalaman tempur `xp` (lingkungan) & nyali efektif `cou_eff` (DESAIN_AI_NPC_V0 §1.2a).
-- Habituasi: misi selamat tanpa panic → xp naik sampai plafon 40 + 0,6·cou (genetik membatasi lingkungan).
-- Sensitisasi: episode panic/despair yang TIDAK diikuti ≥3 hari pemulihan (st < 50) → xp turun;
-- bila pulih → tidak turun (stress inoculation). E ≥ 65 → ×1,5 pada kedua arah (differential susceptibility).
-- Fungsi murni: tanpa Instance, tanpa state global; input tidak dimutasi.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)
local Types = require(ReplicatedStorage.Shared.Types)
local Formula = require(ServerScriptService.Autonomy.Formula)

local XP = NpcData.xp

-- Episode sensitisasi yang menunggu: `age` = hari selesai sejak episode (hari episode = 1, tidak dihitung pulih),
-- `ok` = hari pulih (st < recoveryStBelow) sesudahnya, `amt` = Δxp (negatif, sudah dikali pengali E).
export type Pending = { age: number, ok: number, amt: number }
export type Exp = { xp: number, pend: { Pending } }
export type Ctx = { heroId: string, cou: number, E: number } -- cou genetik (plafon), E (pengali)
export type Outcome = {
	survived: boolean,
	episode: boolean, -- masuk panic/despair (fear saja tidak, NpcData.xp.fearCountsAsEpisode)
	critical: boolean, -- minHpPct < 30 atau rekan party mati
	comradeDiedBeside: boolean, -- episode berujung rekan mati di sisinya
}
export type XpEvent = { kind: "xpHabituated" | "xpSensitized", heroId: string }

local Experience = {}

function Experience.seed(star: number): Exp
	return { xp = XP.seedByStar[math.clamp(star, 1, #XP.seedByStar)], pend = {} }
end

function Experience.cap(cou: number): number
	return math.clamp(Formula.linear(XP.cap, { cou = cou }), XP.min, XP.max)
end

-- Dipakai SEMUA rumus reaksi/turunan (bukan `cou` mentah); `vul` tetap memakai `cou` genetik (§3.2).
function Experience.couEff(cou: number, xp: number, ld: number): number
	return math.clamp(Formula.linear(NpcData.couEff, { cou = cou, xp = xp, ld = ld }), 0, 100)
end

local function mult(ctx: Ctx): number
	return if ctx.E >= XP.susceptibleEMin then XP.susceptibleMult else 1
end

-- Ringkasan per hero dari kontrak MissionResult (Types.HeroResult). `comradeDied` = rekan party mati di misi ini;
-- `comradeDiedBeside` = rekan mati di sisinya (penentu sensitisasi −6; ditentukan pemanggil dari log misi).
function Experience.outcome(hr: Types.HeroResult, comradeDied: boolean, comradeDiedBeside: boolean): Outcome
	local episode = false
	for _, pe in hr.panicEvents do
		if pe.kind == "panic" or pe.kind == "despair" or (pe.kind == "fear" and XP.fearCountsAsEpisode) then
			episode = true
		end
	end
	return {
		survived = hr.alive,
		episode = episode,
		critical = hr.minHpPct < XP.criticalHpPct or comradeDied,
		comradeDiedBeside = comradeDiedBeside,
	}
end

-- Setelah satu misi: habituasi langsung, atau episode dicatat menunggu hasil pemulihan (endDay).
function Experience.onMission(x: Exp, ctx: Ctx, o: Outcome): (Exp, { XpEvent })
	local out = { xp = x.xp, pend = table.clone(x.pend) }
	if not o.survived then
		return out, {}
	end
	if o.episode then
		local amt = if o.comradeDiedBeside then XP.sensitizationComradeDied else XP.sensitization
		table.insert(out.pend, { age = 0, ok = 0, amt = amt * mult(ctx) })
		return out, {}
	end
	local cap = Experience.cap(ctx.cou)
	if out.xp >= cap then
		return out, {}
	end
	local gain = (if o.critical then XP.habituationCritical else XP.habituation) * mult(ctx)
	out.xp = math.min(cap, out.xp + gain)
	local ev: XpEvent = { kind = "xpHabituated", heroId = ctx.heroId }
	return out, { ev }
end

-- Akhir hari in-game dengan stres akhir hari `st`: majukan episode yang menunggu; setelah `recoveryDays`
-- hari sesudah episode, kurang dari `recoveryDays` hari pulih → sensitisasi.
function Experience.endDay(x: Exp, ctx: Ctx, st: number): (Exp, { XpEvent })
	local out = { xp = x.xp, pend = {} }
	local events: { XpEvent } = {}
	for _, p in x.pend do
		local age = p.age + 1
		local ok = p.ok + (if age > 1 and st < XP.recoveryStBelow then 1 else 0)
		if age <= XP.recoveryDays then
			table.insert(out.pend, { age = age, ok = ok, amt = p.amt })
		elseif ok < XP.recoveryDays then
			out.xp = math.max(XP.min, out.xp + p.amt)
			local ev: XpEvent = { kind = "xpSensitized", heroId = ctx.heroId }
			table.insert(events, ev)
		end
	end
	return out, events
end

return table.freeze(Experience)
