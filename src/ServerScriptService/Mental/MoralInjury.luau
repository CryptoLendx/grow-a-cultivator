--!strict
-- M0 luka moral (DESAIN_AI_NPC_V0 §3.4): terpisah dari takut [PSI §5 Shay/Litz].
-- Pemicu: (a) rekan yang ia sayangi (a ≥ 8) disintesis, (b) melawan humanoid bagi A ≥ 65,
-- (c) perintah master yang melanggar nilai (compound paksa), (d) meninggalkan rekan (wipe dengan penyintas).
-- Efek: guilt +15…+30, likeability ke master −10, penarikan diri (aksi sosial ×0,5) 14 hari, stres +10
-- (sumber `moralInjury` di Stress.Day — dipasang pemanggil dari event `moralInjury`).
-- Guilt TIDAK pulih lewat istirahat: hanya penebusan (−20), penerimaan rekan (dihibur oleh t ≥ 9, −5),
-- pengakuan & ritual (besar Δ belum ada di docs → belum dibangun, lihat laporan).
-- Fungsi murni: menerima state & mengembalikan state baru + event; input tidak dimutasi.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)
local Rng = require(ReplicatedStorage.Shared.Rng)

local MI = NpcData.moralInjury

-- `g` = guilt 0–100; `wd` = sisa hari penarikan diri.
export type State = { g: number, wd: number }
export type Cause = "synthesis" | "humanoid" | "forced" | "abandoned"
export type Ctx = {
	heroId: string,
	dims: { [string]: number }, -- sifat (§1.2); A untuk pemicu (b)
	aToVictim: number?, -- pemicu (a): a(hero → korban sintesis)
}
export type MoralEvent = {
	kind: "moralInjury",
	heroId: string,
	cause: Cause,
	like: number, -- Δ likeability ke master (dipasang ke Likeability oleh pemanggil)
	stress: number, -- jumlah kejadian untuk Stress.Day.moralInjury
}

local MoralInjury = {}

function MoralInjury.initial(): State
	return { g = 0, wd = 0 }
end

-- Apakah peristiwa `cause` melukai moral hero ini (syarat per pemicu §3.4).
function MoralInjury.triggers(ctx: Ctx, cause: Cause): boolean
	if cause == "synthesis" then
		return (ctx.aToVictim or -math.huge) >= MI.synthesisMinA
	elseif cause == "humanoid" then
		return ctx.dims.A >= MI.humanoidMinA
	end
	-- (c) compound paksa & (d) wipe dengan penyintas: pemanggil sudah menyaring siapa yang terkena
	-- (§6.1 p_tolak sebelum pengali ≥ 0,3; penyintas wipe).
	return cause == "forced" or cause == "abandoned"
end

-- Terapkan satu peristiwa. Guilt di-roll seragam bulat [guiltMin, guiltMax] (ASUMSI: sebaran dalam rentang
-- "+15…+30" tidak disebut docs). Tidak memicu → state tetap, tanpa event, RNG tidak dipakai.
function MoralInjury.apply(m: State, ctx: Ctx, cause: Cause, rng: Rng.Rng): (State, { MoralEvent })
	if not MoralInjury.triggers(ctx, cause) then
		return { g = m.g, wd = m.wd }, {}
	end
	local gain = rng:NextInteger(MI.guiltMin, MI.guiltMax)
	local out = { g = math.min(MI.guiltCap, m.g + gain), wd = MI.withdrawalDays }
	local ev: MoralEvent =
		{ kind = "moralInjury", heroId = ctx.heroId, cause = cause, like = MI.likeMaster, stress = 1 }
	return out, { ev }
end

-- Penambah guilt dari aturan lain (survivor guilt §6.10, utang §4.3, kontribusi rendah §8.2) — tanpa efek luka moral.
function MoralInjury.addGuilt(m: State, amount: number): State
	return { g = math.clamp(m.g + amount, 0, MI.guiltCap), wd = m.wd }
end

-- Penebusan: menyelamatkan rekan → guilt −20.
function MoralInjury.redeem(m: State): State
	return MoralInjury.addGuilt(m, MI.redemption)
end

-- Penerimaan rekan: dihibur oleh rekan dengan t ≥ 9 → guilt −5 (§6.7). ASUMSI: penghibur t < 9 tidak menurunkan guilt
-- (§3.4 menyebut "dihibur oleh t ≥ 9"; efek stres penghiburan tetap di Stress/§6.7).
function MoralInjury.comforted(m: State, comforterT: number): State
	if comforterT < MI.comfortMinT then
		return { g = m.g, wd = m.wd }
	end
	return MoralInjury.addGuilt(m, NpcData.social.comfortGuilt)
end

-- Pengali skor aksi sosial (§5.2): ×0,5 selama penarikan diri.
function MoralInjury.socialMult(m: State): number
	return if m.wd > 0 then MI.withdrawalSocialMult else 1
end

-- Akhir hari in-game: penarikan diri berkurang 1 hari; guilt TIDAK meluruh sendiri (bukan lewat istirahat).
function MoralInjury.endDay(m: State): State
	return { g = m.g, wd = math.max(0, m.wd - 1) }
end

return table.freeze(MoralInjury)
