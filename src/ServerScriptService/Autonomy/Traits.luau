--!strict
-- M0 sifat hero (DESAIN_AI_NPC_V0 §1.2–1.4, §1.6, §4.6): roll saat summon, drift per peristiwa besar,
-- encode/decode ke field pendek hero.npc (`tr`, `gl`, `id`, `tg`). Fungsi murni: tanpa Instance, tanpa state global.
-- Semua angka dari ServerStorage/Data (NpcData, IdioData); semua keacakan lewat Shared/Rng.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Rng = require(ReplicatedStorage.Shared.Rng)
local NpcData = require(ServerStorage.Data.NpcData)
local IdioData = require(ServerStorage.Data.IdioData)

type Rng = Rng.Rng

export type Dims = { [string]: number } -- H E X A C O cou, bilangan bulat 0–100
export type Idio = {
	giftFav: { number }, -- indeks GiftData (M1 5.1); kosong bila katalog belum ada
	giftHated: number?, -- indeks GiftData
	foodFav: string, -- id IdioData.foods
	foodHated: string,
	hobby: string, -- id IdioData.hobbies
	habit: string, -- id IdioData.habits
	aversion: string?, -- id IdioData.aversions
}
export type Traits = {
	dims: Dims,
	goals: { string }, -- 1–2 id IdioData.goals.order
	idio: Idio,
	tags: { origin: number, batch: number }, -- §4.6 asal (HeroData) & angkatan summon
}
export type RollOpts = {
	origin: number, -- indeks asal/ras dari HeroData (M1 5.1)
	batch: number, -- nomor sesi summon (hero dalam 1 summon ×10 berbagi angkatan)
	giftCount: number?, -- ukuran katalog GiftData; nil = gift belum di-roll
}
-- Field tersimpan (§1.6); semua id disimpan sebagai indeks 1-based ke daftar Data (urutan daftar = format simpan).
export type Encoded = {
	tr: string,
	gl: { number },
	id: { gf: { number }, gd: number?, fd: { number }, hb: number, hab: number, av: number? },
	tg: { number },
}
export type DriftKind =
	"intimateDeath"
	| "synthesisWitnessed"
	| "mvpRepeat"
	| "mentor"
	| "punished"
	| "isolation30"
	| "isolation60"
	| "stagnationWeek"
export type DriftCtx = { profileSeed: number, heroId: string }
export type DriftEvent = { kind: "traitDrift", heroId: string, cause: DriftKind, delta: { [string]: number } }

local T = NpcData.traits
local D = NpcData.drift
local DIMS = T.dims

local Traits = {}

-- Peristiwa besar §1.2 (tunduk pada roll "tidak bergeser sama sekali"); isolasi & stagnasi berlaku untuk semua hero.
local BIG_EVENTS: { DriftKind } = { "intimateDeath", "synthesisWitnessed", "mvpRepeat", "mentor", "punished" }
Traits.BIG_EVENTS = table.freeze(BIG_EVENTS)

local function clampDim(v: number): number
	return math.clamp(v, T.min, T.max)
end

-- N(mean, sd) Box–Muller; 1 − u agar log tidak menerima 0.
local function normal(rng: Rng, mean: number, sd: number): number
	local u1 = 1 - rng:NextNumber()
	local u2 = rng:NextNumber()
	return mean + sd * math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)
end

local function linear(form: { [string]: number }, vars: Dims): number
	local v = form.k or 0
	for key, coef in form do
		if key ~= "k" then
			v += coef * (vars[key] or error("Traits: variabel tidak dikenal " .. key))
		end
	end
	return v
end

-- Pilih satu id dari `ids` dengan bobot ≥ 0; semua 0 → seragam.
local function pickWeighted(rng: Rng, ids: { string }, weights: { number }): number
	local total = 0
	for _, w in weights do
		total += w
	end
	if total <= 0 then
		return rng:NextInteger(1, #ids)
	end
	local x = rng:NextNumber() * total
	for i, w in weights do
		x -= w
		if x < 0 then
			return i
		end
	end
	return #ids
end

-- k indeks berbeda dari 1..n yang tidak ada di `taken`.
local function pickDistinct(rng: Rng, n: number, k: number, taken: { [number]: boolean }): { number }
	local out = {}
	while #out < k do
		local i = rng:NextInteger(1, n)
		if not taken[i] then
			taken[i] = true
			table.insert(out, i)
		end
	end
	return out
end

local function countRoll(rng: Rng, c: { min: number, max: number }): number
	return rng:NextInteger(c.min, c.max)
end

-- §1.3 bobot roll goal dari sifat (★ tidak dipakai); bobot negatif → 0.
function Traits.goalWeights(dims: Dims): { [string]: number }
	local w = {}
	for g, form in IdioData.goals.weights do
		w[g] = math.max(0, linear(form, dims))
	end
	return w
end

local function rollGoals(rng: Rng, dims: Dims): { string }
	local order = IdioData.goals.order
	local byId = Traits.goalWeights(dims)
	local weights = {}
	for i, g in order do
		weights[i] = byId[g]
	end
	local first = pickWeighted(rng, order, weights)
	local goals = { order[first] }
	if rng:NextNumber() < IdioData.goals.secondChance then
		weights[first] = 0
		table.insert(goals, order[pickWeighted(rng, order, weights)])
	end
	return goals
end

local function rollIdio(rng: Rng, giftCount: number?): Idio
	local c = IdioData.counts
	local giftFav, giftHated = {}, nil
	if giftCount then
		assert(giftCount >= c.giftFav.max + c.giftHated.max, "Traits: katalog gift terlalu kecil")
		local taken = {}
		giftFav = pickDistinct(rng, giftCount, countRoll(rng, c.giftFav), taken)
		giftHated = pickDistinct(rng, giftCount, countRoll(rng, c.giftHated), taken)[1]
	end
	local foods = pickDistinct(rng, #IdioData.foods, 2, {})
	local aversion = nil
	if countRoll(rng, c.aversion) > 0 then
		aversion = IdioData.aversions[rng:NextInteger(1, #IdioData.aversions)].id
	end
	return {
		giftFav = giftFav,
		giftHated = giftHated,
		foodFav = IdioData.foods[foods[1]],
		foodHated = IdioData.foods[foods[2]],
		hobby = IdioData.hobbies[rng:NextInteger(1, #IdioData.hobbies)],
		habit = IdioData.habits[rng:NextInteger(1, #IdioData.habits)],
		aversion = aversion,
	}
end

-- §1.2 roll "genetik": clamp(round(N(μ, σ))) per dimensi; hanya μ C bergantung ★ (seleksi asal [N] ch.10).
function Traits.roll(rng: Rng, star: number, opts: RollOpts): Traits
	local dims: Dims = {}
	local cMean = T.cMeanByStar[math.clamp(star, 1, #T.cMeanByStar)]
	for _, d in DIMS do
		local mu = if d == "C" then cMean else T.mean
		dims[d] = clampDim(math.round(normal(rng, mu, T.sd)))
	end
	return {
		dims = dims,
		goals = rollGoals(rng, dims),
		idio = rollIdio(rng, opts.giftCount),
		tags = { origin = opts.origin, batch = opts.batch },
	}
end

-- 50 % hero tidak bergeser sama sekali (§1.2): tetap per hero, diturunkan dari (profileSeed, heroId).
function Traits.isPlastic(profileSeed: number, heroId: string): boolean
	return Rng.new(Rng.derive(profileSeed, heroId, "plastic")):NextNumber() >= D.pNoShift
end

local function deltaFor(kind: DriftKind, rng: Rng): { [string]: number }
	if kind == "intimateDeath" then
		return D.intimateDeath
	elseif kind == "synthesisWitnessed" then
		local opts = D.synthesisWitnessedOptions
		return opts[rng:NextInteger(1, #opts)]
	elseif kind == "mvpRepeat" then
		return D.mvpRepeat
	elseif kind == "mentor" then
		return D.mentor
	elseif kind == "punished" then
		return D.punished
	elseif kind == "isolation30" then
		return { E = D.isolationEPer30 }
	elseif kind == "isolation60" then
		return { O = D.isolationOPer60 }
	elseif kind == "stagnationWeek" then
		return { C = D.stagnationCPerWeek }
	end
	error("Traits.drift: peristiwa tidak dikenal " .. tostring(kind))
end

-- §1.2 plastisitas lambat. Mengembalikan Traits baru (input tidak dimutasi) + event `traitDrift`.
-- Δ per dimensi dibatasi ±maxShift per peristiwa; hasil di-clamp 0–100.
function Traits.drift(traits: Traits, ctx: DriftCtx, kind: DriftKind, rng: Rng): (Traits, { DriftEvent })
	local delta = deltaFor(kind, rng)
	local out = table.clone(traits)
	out.dims = table.clone(traits.dims)
	local isBig = table.find(Traits.BIG_EVENTS, kind) ~= nil
	if isBig and not Traits.isPlastic(ctx.profileSeed, ctx.heroId) then
		return out, {}
	end
	local applied = {}
	local any = false
	for d, dv in delta do
		local before = out.dims[d] or error("Traits.drift: dimensi tidak dikenal " .. d)
		local after = clampDim(before + math.clamp(dv, -D.maxShift, D.maxShift))
		if after ~= before then
			out.dims[d] = after
			applied[d] = after - before
			any = true
		end
	end
	if not any then
		return out, {}
	end
	return out, { { kind = "traitDrift", heroId = ctx.heroId, cause = kind, delta = applied } }
end

---------------------------------------------------------------- encode / decode (§1.6)

local function indexOf(list: { string }, v: string, field: string): number
	return table.find(list, v) or error("Traits.encode: id tidak dikenal di " .. field .. ": " .. v)
end

local function at(list: { string }, i: any, field: string): string
	if type(i) ~= "number" or list[i] == nil then
		error("Traits.decode: indeks tidak valid di " .. field .. ": " .. tostring(i))
	end
	return list[i]
end

local AVERSION_IDS = {}
for i, av in IdioData.aversions do
	AVERSION_IDS[i] = av.id
end

function Traits.encode(t: Traits): Encoded
	local tr = table.create(#DIMS, "")
	for i, d in DIMS do
		tr[i] = string.format("%02x", t.dims[d])
	end
	local gl = {}
	for i, g in t.goals do
		gl[i] = indexOf(IdioData.goals.order, g, "gl")
	end
	local id = t.idio
	return {
		tr = table.concat(tr),
		gl = gl,
		id = {
			gf = table.clone(id.giftFav),
			gd = id.giftHated,
			fd = { indexOf(IdioData.foods, id.foodFav, "fd"), indexOf(IdioData.foods, id.foodHated, "fd") },
			hb = indexOf(IdioData.hobbies, id.hobby, "hb"),
			hab = indexOf(IdioData.habits, id.habit, "hab"),
			av = if id.aversion then indexOf(AVERSION_IDS, id.aversion, "av") else nil,
		},
		tg = { t.tags.origin, t.tags.batch },
	}
end

function Traits.decode(e: Encoded): Traits
	if type(e.tr) ~= "string" or #e.tr ~= 2 * #DIMS or not string.match(e.tr, "^[0-9a-f]+$") then
		error("Traits.decode: tr harus " .. 2 * #DIMS .. " hex, dapat " .. tostring(e.tr))
	end
	local dims: Dims = {}
	for i, d in DIMS do
		local v = tonumber(string.sub(e.tr, 2 * i - 1, 2 * i), 16) :: number
		if v < T.min or v > T.max then
			error("Traits.decode: tr di luar 0–100 pada " .. d)
		end
		dims[d] = v
	end
	local goals = {}
	for i, g in e.gl do
		goals[i] = at(IdioData.goals.order, g, "gl")
	end
	local id = e.id
	return {
		dims = dims,
		goals = goals,
		idio = {
			giftFav = table.clone(id.gf),
			giftHated = id.gd,
			foodFav = at(IdioData.foods, id.fd[1], "fd"),
			foodHated = at(IdioData.foods, id.fd[2], "fd"),
			hobby = at(IdioData.hobbies, id.hb, "hb"),
			habit = at(IdioData.habits, id.hab, "hab"),
			aversion = if id.av then at(AVERSION_IDS, id.av, "av") else nil,
		},
		tags = { origin = e.tg[1], batch = e.tg[2] },
	}
end

return table.freeze(Traits)
