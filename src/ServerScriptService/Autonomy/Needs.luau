--!strict
-- M0 kebutuhan hero (DESAIN_AI_NPC_V0 §2): 5 kebutuhan non-hierarkis (rest, food, aut, cmp, rel), 0–100.
-- Laju harian §2.2 per hari in-game; frustrasi ≠ ketiadaan (dipaksa aut −15 ≫ decay −1).
-- Kebutuhan sosial kontinum: target rel = 40 + 0,6·X; tanpa kontak, rel hanya meluruh sampai
-- "lantai sendiri" = 100 − target (defisit = target − kontak; penyendiri tidak sakit karena sendiri).
-- Kehilangan (`relLoss`) boleh menembus lantai itu; ikatan intim hidup → rel ≥ 40.
-- Fungsi murni: keadaan tersembunyi saja, tanpa event (log lahir di TickDay, tugas 3.4).
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)
local Formula = require(ServerScriptService.Autonomy.Formula)

local ND = NpcData.needs

export type Needs = { rest: number, food: number, aut: number, cmp: number, rel: number }
export type Dims = { [string]: number }
-- Situasi satu hari in-game (§2.2 kolom "Situasi"); semua opsional, jumlah = kali kejadian hari itu.
export type Day = {
	training: boolean?, -- berlatih: decay rest ×(1 + 0,3·C/100)
	missions: number?, -- misi −25 rest per misi
	position: boolean?, -- memegang jabatan −3 rest
	crowd: boolean?, -- keramaian (party 5 + plaza penuh) −2·(1 − X/100) rest
	meal: ("normal" | "floor1")?, -- makan tersedia +30; lantai 1 tanpa Restaurant +18
	chefMatch: boolean?, -- Chef cocok +10
	forced: number?, -- dipaksa (misi yang ditolak tetap dikirim, jam riset dipaksa, compound command)
	requestDenied: number?,
	requestGranted: number?,
	ownChoice: boolean?, -- memilih aksi sendiri
	mvp: number?,
	floorUp: number?,
	duelLost: number?,
	monotoneDays: number?, -- hari berturut tugas monoton (termasuk hari ini)
	fixedParty: boolean?,
	eatTogether: boolean?,
	comforted: boolean?,
	relLoss: number?, -- Δ ≤ 0 karena kehilangan (ikatan putus, rekan mati, dipindah party); menembus lantai sendiri
	intimate: boolean?, -- punya ikatan intim yang masih hidup
}

local Needs = {}

local function clampNeed(v: number): number
	return math.clamp(v, ND.min, ND.max)
end

function Needs.relTarget(dims: Dims): number
	return Formula.linear(ND.rel.target, dims)
end

-- Nilai rel bila hero sama sekali tanpa kontak: 100 − target (X 0 → 60, X 100 → 0).
function Needs.relSoloFloor(dims: Dims): number
	return clampNeed(ND.max - Needs.relTarget(dims))
end

function Needs.initial(dims: Dims): Needs
	local v = ND.initial
	return { rest = v, food = v, aut = v, cmp = v, rel = math.max(v, Needs.relSoloFloor(dims)) }
end

-- Satu hari in-game: decay dasar × pengali sifat, lalu Δ situasi; hasil di-clamp 0–100. Input tidak dimutasi.
function Needs.step(n: Needs, dims: Dims, day: Day): Needs
	local R, F, A, C, L = ND.rest, ND.food, ND.aut, ND.cmp, ND.rel

	local rest = n.rest + R.decay * (if day.training then Formula.linear(R.trainingMult, dims) else 1)
	rest += R.mission * (day.missions or 0)
	if day.position then
		rest += R.position
	end
	if day.crowd then
		rest += Formula.linear(R.crowd, dims)
	end

	local food = n.food + F.decay
	if day.meal == "normal" then
		food += F.meal
	elseif day.meal == "floor1" then
		food += F.mealFloor1NoRestaurant
	end
	if day.chefMatch then
		food += F.chefMatch
	end

	local aut = n.aut + A.decay * Formula.linear(A.decayMult, dims)
	aut += A.forced * (day.forced or 0)
	aut += A.requestDenied * (day.requestDenied or 0)
	aut += A.requestGranted * (day.requestGranted or 0)
	if day.ownChoice then
		aut += A.ownChoice
	end

	local cmp = n.cmp + C.decay * Formula.linear(C.decayMult, dims)
	cmp += C.mvp * (day.mvp or 0) + C.floorUp * (day.floorUp or 0) + C.duelLost * (day.duelLost or 0)
	if (day.monotoneDays or 0) >= C.monotoneDays then
		cmp += C.monotonePerDay * (if dims.O >= C.monotoneHighO then C.monotoneHighOMult else 1)
	end

	-- rel: decay hanya selama di atas lantai sendiri (tidak mendorong ke bawahnya), lalu Δ sosial.
	local floor = Needs.relSoloFloor(dims)
	local rel = n.rel
	if rel > floor then
		rel = math.max(floor, rel + L.decay * Formula.linear(L.decayMult, dims))
	end
	if day.fixedParty then
		rel += L.fixedParty
	end
	if day.eatTogether then
		rel += L.eatTogether
	end
	if day.comforted then
		rel += L.comforted
	end
	rel += math.min(0, day.relLoss or 0)
	rel = clampNeed(rel)
	if day.intimate then
		rel = math.max(rel, L.intimateFloor)
	end

	return { rest = clampNeed(rest), food = clampNeed(food), aut = clampNeed(aut), cmp = clampNeed(cmp), rel = rel }
end

-- Δ kebutuhan dari aksi terpilih (§5.2 kolom gain; dipakai Actions, tugas 3.4).
function Needs.apply(n: Needs, gains: { [string]: number }): Needs
	local out = table.clone(n)
	for k, dv in gains do
		local v = (out :: any)[k]
		if type(v) ~= "number" then
			error("Needs.apply: kebutuhan tidak dikenal " .. k)
		end
		(out :: any)[k] = clampNeed(v + dv)
	end
	return out
end

---------------------------------------------------------------- encode / decode (§1.6 `nd` = 10 hex)

function Needs.encode(n: Needs): string
	local parts = table.create(#ND.ids, "")
	for i, k in ND.ids do
		parts[i] = string.format("%02x", math.round(clampNeed((n :: any)[k])))
	end
	return table.concat(parts)
end

function Needs.decode(s: string): Needs
	if type(s) ~= "string" or #s ~= 2 * #ND.ids or not string.match(s, "^[0-9a-f]+$") then
		error("Needs.decode: nd harus " .. 2 * #ND.ids .. " hex, dapat " .. tostring(s))
	end
	local out: any = {}
	for i, k in ND.ids do
		local v = tonumber(string.sub(s, 2 * i - 1, 2 * i), 16) :: number
		if v < ND.min or v > ND.max then
			error("Needs.decode: nd di luar 0–100 pada " .. k)
		end
		out[k] = v
	end
	return out
end

return table.freeze(Needs)
