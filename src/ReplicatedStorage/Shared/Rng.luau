--!strict
-- RNG berseed deterministik untuk SEMUA keacakan game (CLAUDE.md: tanpa math.random langsung).
-- Algoritma: xoshiro128** pure Luau (bit32), bukan `Random.new`, agar urutan identik di Studio,
-- server, dan harness headless, serta tetap sama lintas versi engine (replay = seed + input).
-- API meniru `Random`: `NextNumber(min?, max?)`, `NextInteger(min, max)`.
-- `Rng.derive(seed, ...parts)` → sub-seed stabil, mis. `(profileSeed, heroId, dayIndex, slot)`.

local band, bxor, lshift, rshift, lrotate = bit32.band, bit32.bxor, bit32.lshift, bit32.rshift, bit32.lrotate

local TWO32 = 4294967296
local TWO53 = 9007199254740992

-- Perkalian modulo 2^32 tanpa kehilangan presisi double.
local function mul32(a: number, b: number): number
	local aLo = band(a, 0xFFFF)
	local aHi = rshift(a, 16)
	return band(aLo * b + ((aHi * b) % 65536) * 65536, 0xFFFFFFFF)
end

-- Finalizer murmur3 (fmix32): mengaduk 32 bit.
local function mix32(h: number): number
	h = bxor(h, rshift(h, 16))
	h = mul32(h, 0x85EBCA6B)
	h = bxor(h, rshift(h, 13))
	h = mul32(h, 0xC2B2AE35)
	return bxor(h, rshift(h, 16))
end

local function assertSeed(seed: number)
	if type(seed) ~= "number" or seed ~= math.floor(seed) or math.abs(seed) >= TWO53 then
		error("Rng: seed harus bilangan bulat |seed| < 2^53, dapat " .. tostring(seed), 3)
	end
end

local Rng = {}
Rng.__index = Rng

export type Rng = typeof(setmetatable({} :: { s0: number, s1: number, s2: number, s3: number }, Rng))

function Rng.new(seed: number): Rng
	assertSeed(seed)
	local lo = seed % TWO32
	local hi = math.floor(seed / TWO32) % TWO32
	-- Isi 4 kata state lewat splitmix-like dari (lo, hi).
	local s = table.create(4, 0)
	local x = lo
	for i = 1, 4 do
		x = band(x + 0x9E3779B9, 0xFFFFFFFF)
		s[i] = mix32(bxor(x, mix32(bxor(hi, i))))
	end
	if s[1] == 0 and s[2] == 0 and s[3] == 0 and s[4] == 0 then
		s[1] = 1 -- xoshiro tidak boleh berstate nol semua
	end
	return setmetatable({ s0 = s[1], s1 = s[2], s2 = s[3], s3 = s[4] }, Rng)
end

-- 32 bit acak berikutnya (0 .. 2^32-1).
function Rng.NextUInt32(self: Rng): number
	local s0, s1, s2, s3 = self.s0, self.s1, self.s2, self.s3
	local result = band(lrotate(band(s1 * 5, 0xFFFFFFFF), 7) * 9, 0xFFFFFFFF)
	local t = lshift(s1, 9)
	s2 = bxor(s2, s0)
	s3 = bxor(s3, s1)
	s1 = bxor(s1, s2)
	s0 = bxor(s0, s3)
	s2 = bxor(s2, t)
	s3 = lrotate(s3, 11)
	self.s0, self.s1, self.s2, self.s3 = s0, s1, s2, s3
	return result
end

-- Bilangan real seragam di [min, max); default [0, 1). Presisi 53 bit.
function Rng.NextNumber(self: Rng, min: number?, max: number?): number
	local a = rshift(self:NextUInt32(), 5) -- 27 bit
	local b = rshift(self:NextUInt32(), 6) -- 26 bit
	local u = (a * 67108864 + b) / TWO53
	if min == nil then
		return u
	end
	local hiBound = max :: number
	return min + (hiBound - min) * u
end

-- Bilangan bulat seragam di [min, max] (inklusif).
function Rng.NextInteger(self: Rng, min: number, max: number): number
	assert(min == math.floor(min) and max == math.floor(max) and min <= max, "Rng.NextInteger: rentang tidak valid")
	return min + math.floor(self:NextNumber() * (max - min + 1))
end

-- FNV-1a 32 bit dengan offset basis tertentu, lalu fmix32.
local function hash32(str: string, basis: number): number
	local h = basis
	for i = 1, #str do
		h = mul32(bxor(h, string.byte(str, i)), 16777619)
	end
	return mix32(h)
end

-- Sub-seed stabil (bilangan bulat 0 .. 2^52-1) dari seed + bagian (angka/string).
-- Contoh: Rng.new(Rng.derive(profileSeed, heroId, dayIndex, slot)).
function Rng.derive(seed: number, ...: number | string): number
	assertSeed(seed)
	local parts = table.create(select("#", ...) + 1, "")
	parts[1] = tostring(seed)
	for i = 1, select("#", ...) do
		parts[i + 1] = tostring((select(i, ...)))
	end
	local key = table.concat(parts, "\31") -- pemisah unit: "12","3" ≠ "1","23"
	local lo = hash32(key, 0x811C9DC5)
	local hi = band(hash32(key, 0x050C5D1F), 0xFFFFF)
	return hi * TWO32 + lo
end

return Rng
