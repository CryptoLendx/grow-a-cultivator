--!strict
-- Autonomy/Traits (tugas §B 2.2): roll sifat/goal/idiosinkrasi/tag saat summon (DESAIN_AI_NPC_V0 §1.2–1.4, §4.6),
-- drift sifat per peristiwa (§1.2), encode→decode ke field hemat byte hero.npc (§1.6).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local Rng = require(ReplicatedStorage.Shared.Rng)
local NpcData = require(ServerStorage.Data.NpcData)
local IdioData = require(ServerStorage.Data.IdioData)
local Traits = require(ServerScriptService.Autonomy.Traits)

local N = 10000
local GIFTS = 12 -- ukuran katalog GiftData dummy (GiftData asli: M1 5.1)
local PROFILE = 4242 -- profileSeed dummy

local function opts(i: number): Traits.RollOpts
	return { origin = 1 + i % 3, batch = 1 + i // 10, giftCount = GIFTS }
end

-- Statistik per dimensi atas N roll pada ★ tertentu.
local function stats(star: number, seed: number): ({ [string]: number }, { [string]: number }, number)
	local rng = Rng.new(seed)
	local sum, sq = {}, {}
	local extreme = 0
	for _, d in NpcData.traits.dims do
		sum[d], sq[d] = 0, 0
	end
	for i = 1, N do
		local t = Traits.roll(rng, star, opts(i))
		for _, d in NpcData.traits.dims do
			local v = t.dims[d]
			sum[d] += v
			sq[d] += v * v
			if v < 10 or v > 90 then
				extreme += 1
			end
		end
	end
	local mean, sd = {}, {}
	for _, d in NpcData.traits.dims do
		mean[d] = sum[d] / N
		sd[d] = math.sqrt(sq[d] / N - mean[d] ^ 2)
	end
	return mean, sd, extreme / (N * #NpcData.traits.dims)
end

local function deepEqual(a: any, b: any): boolean
	if type(a) ~= type(b) then
		return false
	end
	if type(a) ~= "table" then
		return a == b
	end
	for k, v in a do
		if not deepEqual(v, b[k]) then
			return false
		end
	end
	for k in b do
		if a[k] == nil then
			return false
		end
	end
	return true
end

return function()
	describe("Autonomy/Traits", function()
		it("10.000 roll per ★ → mean 50±2 & σ 15±2; C μ per ★ = data; ekstrem <10/>90 ≤ 2,5 %", function()
			for _, star in { 1, 2, 3, 5 } do
				local mean, sd, extremeRate = stats(star, 1000 + star)
				local cIdx = math.min(star, #NpcData.traits.cMeanByStar)
				for _, d in NpcData.traits.dims do
					local mu = if d == "C" then NpcData.traits.cMeanByStar[cIdx] else NpcData.traits.mean
					expect(mean[d]).to.be.near(mu, 2)
					expect(sd[d]).to.be.near(NpcData.traits.sd, 2)
				end
				expect(extremeRate <= 0.025).to.equal(true)
			end
		end)

		it("cou TIDAK berkorelasi dengan ★ (§1.2): mean cou 1★ vs 3★ selisih < 1", function()
			local m1 = stats(1, 77)
			local m3 = stats(3, 77)
			expect(math.abs(m1.cou - m3.cou) < 1).to.equal(true)
		end)

		it("seed sama → roll identik; nilai bulat dalam 0–100", function()
			local a, b = Rng.new(9), Rng.new(9)
			for i = 1, 200 do
				local ta, tb = Traits.roll(a, 2, opts(i)), Traits.roll(b, 2, opts(i))
				expect(deepEqual(ta, tb)).to.equal(true)
				for _, d in NpcData.traits.dims do
					local v = ta.dims[d]
					expect(v >= 0 and v <= 100 and v == math.floor(v)).to.equal(true)
				end
			end
		end)

		it("1–2 goal: kedua ≠ pertama, goal kedua ≈ 40 %; goal pertama mengikuti bobot sifat §1.3", function()
			-- bobot di titik uji = rumus docs (terkuat ∝ C + (100−A)/2, dst.)
			local w = Traits.goalWeights({ H = 20, E = 60, X = 40, A = 30, C = 70, O = 50, cou = 50 })
			expect(w.strongest).to.equal(70 + 35)
			expect(w.protect).to.equal(30 + 20)
			expect(w.recognized).to.equal(80 + 20)
			expect(w.calm).to.equal(30 + 30)
			expect(w.prove).to.equal(70 + 30)
			expect(w.serve).to.equal(20 + 15)
			local rng = Rng.new(5)
			local two = 0
			local observed: { [string]: number } = {}
			local expected: { [string]: number } = {}
			for _, g in IdioData.goals.order do
				observed[g], expected[g] = 0, 0
			end
			for i = 1, N do
				local t = Traits.roll(rng, 1 + i % 3, opts(i))
				expect(#t.goals >= 1 and #t.goals <= 2).to.equal(true)
				if #t.goals == 2 then
					two += 1
					expect(t.goals[1] ~= t.goals[2]).to.equal(true)
				end
				observed[t.goals[1]] += 1
				local wt = Traits.goalWeights(t.dims)
				local total = 0
				for _, v in wt do
					total += v
				end
				for g, v in wt do
					expected[g] += v / total
				end
			end
			expect(two / N).to.be.near(IdioData.goals.secondChance, 0.02)
			-- frekuensi goal pertama = Σ peluang per hero (±4σ binomial)
			for g, e in expected do
				local sigma = math.sqrt(e * (1 - e / N))
				expect(observed[g]).to.be.near(e, 4 * sigma)
			end
		end)

		it("idiosinkrasi per kategori (Q1): jumlah sesuai IdioData.counts, tanpa duplikat, fav ≠ benci", function()
			local rng = Rng.new(11)
			local c = IdioData.counts
			local withAv, minItems, maxItems = 0, math.huge, 0
			for i = 1, N do
				local id = Traits.roll(rng, 2, opts(i)).idio
				expect(#id.giftFav >= c.giftFav.min and #id.giftFav <= c.giftFav.max).to.equal(true)
				expect(id.giftHated ~= nil).to.equal(true) -- gd tunggal (§1.6), counts.giftHated = 1
				local seen: { [number]: boolean } = {}
				for _, g in id.giftFav do
					expect(seen[g]).to.equal(nil)
					seen[g] = true
				end
				expect(seen[id.giftHated :: number]).to.equal(nil)
				expect(table.find(IdioData.foods, id.foodFav) ~= nil).to.equal(true)
				expect(table.find(IdioData.foods, id.foodHated) ~= nil).to.equal(true)
				expect(id.foodFav ~= id.foodHated).to.equal(true)
				expect(table.find(IdioData.hobbies, id.hobby) ~= nil).to.equal(true)
				expect(table.find(IdioData.habits, id.habit) ~= nil).to.equal(true)
				local items = #id.giftFav + 1 + 4
				if id.aversion then
					withAv += 1
					items += 1
				end
				minItems = math.min(minItems, items)
				maxItems = math.max(maxItems, items)
			end
			expect(withAv > 0 and withAv < N).to.equal(true)
			-- 6 kategori: gift 2–3 + makanan 2 + hobi 1 + kebiasaan 1 + keengganan 0–1 = 6–8 item (lihat laporan, Q)
			expect(minItems).to.equal(6)
			expect(maxItems).to.equal(8)
		end)

		it("tanpa katalog gift (sebelum GiftData M1 5.1) → gift kosong, kategori lain tetap", function()
			local t = Traits.roll(Rng.new(3), 1, { origin = 1, batch = 1 })
			expect(#t.idio.giftFav).to.equal(0)
			expect(t.idio.giftHated).to.equal(nil)
			expect(t.idio.hobby ~= nil).to.equal(true)
		end)

		it("2 tag identitas (§4.6) = asal & angkatan dari input summon", function()
			local t = Traits.roll(Rng.new(4), 3, { origin = 2, batch = 17, giftCount = GIFTS })
			expect(t.tags.origin).to.equal(2)
			expect(t.tags.batch).to.equal(17)
		end)

		it("encode→decode identik (10.000 hero); tr = 14 hex; field pendek §1.6", function()
			local rng = Rng.new(21)
			for i = 1, N do
				local t = Traits.roll(rng, 1 + i % 5, opts(i))
				local f = Traits.encode(t)
				expect(#f.tr).to.equal(14)
				expect(string.match(f.tr, "^[0-9a-f]+$") ~= nil).to.equal(true)
				expect(deepEqual(Traits.decode(f), t)).to.equal(true)
			end
		end)

		it("decode menolak data rusak", function()
			local f = Traits.encode(Traits.roll(Rng.new(1), 1, opts(1)))
			local bad = table.clone(f)
			bad.tr = "zz"
			expect(function()
				Traits.decode(bad)
			end).to.throw("tr")
			local bad2 = table.clone(f)
			bad2.tr = "65" .. string.sub(f.tr, 3) -- 0x65 = 101 > 100
			expect(function()
				Traits.decode(bad2)
			end).to.throw("tr")
			local bad3 = table.clone(f)
			bad3.gl = { 99 }
			expect(function()
				Traits.decode(bad3)
			end).to.throw("gl")
		end)

		it("drift maks 5 poin per peristiwa per dimensi; tetap 0–100; hero tidak-plastis tidak bergeser", function()
			local rng = Rng.new(31)
			local plastic, heroes = 0, 2000
			for i = 1, heroes do
				local t = Traits.roll(rng, 2, opts(i))
				-- paksa sebagian hero ke tepi skala agar clamp teruji
				if i % 4 == 0 then
					for _, d in NpcData.traits.dims do
						t.dims[d] = if i % 8 == 0 then 0 else 100
					end
				end
				local moved = false
				for _, kind: Traits.DriftKind in Traits.BIG_EVENTS do
					local after, events = Traits.drift(t, { profileSeed = PROFILE, heroId = "h" .. i }, kind, rng)
					for _, d in NpcData.traits.dims do
						local delta = after.dims[d] - t.dims[d]
						expect(math.abs(delta) <= NpcData.drift.maxShift).to.equal(true)
						expect(after.dims[d] >= 0 and after.dims[d] <= 100).to.equal(true)
						moved = moved or delta ~= 0
					end
					for _, e in events do
						expect(e.kind).to.equal("traitDrift")
						expect(e.heroId).to.equal("h" .. i)
					end
					expect(after ~= t).to.equal(true) -- state baru, input tidak dimutasi
				end
				if Traits.isPlastic(PROFILE, "h" .. i) then
					plastic += 1
				else
					expect(moved).to.equal(false)
				end
			end
			expect(plastic / heroes).to.be.near(1 - NpcData.drift.pNoShift, 0.05)
		end)

		it("drift menerapkan Δ docs §1.2 pada hero plastis", function()
			local id = "h1"
			local k = 1
			while not Traits.isPlastic(PROFILE, id) do
				k += 1
				id = "h" .. k
			end
			local t = Traits.roll(Rng.new(2), 2, opts(1))
			for _, d in NpcData.traits.dims do
				t.dims[d] = 50
			end
			local rng = Rng.new(8)
			local ctx = { profileSeed = PROFILE, heroId = id }
			local any = { profileSeed = PROFILE, heroId = "any" }
			local a = Traits.drift(t, ctx, "intimateDeath", rng)
			expect(a.dims.E).to.equal(53)
			expect(a.dims.X).to.equal(48)
			local p = Traits.drift(t, ctx, "punished", rng)
			expect(p.dims.A).to.equal(47)
			local m = Traits.drift(t, ctx, "mentor", rng)
			expect(m.dims.A).to.equal(52)
			expect(m.dims.C).to.equal(52)
			local seenH, seenA = false, false
			for _ = 1, 50 do
				local s = Traits.drift(t, ctx, "synthesisWitnessed", rng)
				seenH = seenH or (s.dims.H == 48 and s.dims.A == 50)
				seenA = seenA or (s.dims.A == 48 and s.dims.H == 50)
				expect((s.dims.H == 48) ~= (s.dims.A == 48)).to.equal(true) -- H −2 ATAU A −2
			end
			expect(seenH and seenA).to.equal(true)
			-- erosi isolasi & stagnasi berlaku untuk semua hero (bukan peristiwa besar)
			local iso = Traits.drift(t, any, "isolation30", rng)
			expect(iso.dims.E).to.equal(51)
			expect(Traits.drift(t, any, "isolation60", rng).dims.O).to.equal(49)
			expect(Traits.drift(t, any, "stagnationWeek", rng).dims.C).to.equal(49)
		end)

		it("jenis peristiwa asing → error", function()
			local t = Traits.roll(Rng.new(2), 2, opts(1))
			expect(function()
				Traits.drift(t, { profileSeed = PROFILE, heroId = "h1" }, "notAnEvent" :: any, Rng.new(1))
			end).to.throw("notAnEvent")
		end)
	end)
end
