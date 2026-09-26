--!strict
-- Autonomy/Needs (tugas §B 2.3): 5 kebutuhan non-hierarkis, laju harian §2.2, frustrasi ≠ ketiadaan,
-- kebutuhan sosial kontinum (target rel = 40 + 0,6·X, decay ×(0,4 + X/100)) — DESAIN_AI_NPC_V0 §2.
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)
local Needs = require(ServerScriptService.Autonomy.Needs)

local ND = NpcData.needs

local function dims(over: { [string]: number }?): { [string]: number }
	local d = { H = 50, E = 50, X = 50, A = 50, C = 50, O = 50, cou = 50 }
	if over then
		for k, v in over do
			d[k] = v
		end
	end
	return d
end

local function run(n: Needs.Needs, d: { [string]: number }, days: number, day: Needs.Day?): (Needs.Needs, number)
	local minRel = n.rel
	for _ = 1, days do
		n = Needs.step(n, d, day or {})
		minRel = math.min(minRel, n.rel)
	end
	return n, minRel
end

return function()
	describe("Autonomy/Needs", function()
		it("target rel = 40 + 0,6·X; lantai sendiri = 100 − target (X 0 → 60, X 100 → 0)", function()
			expect(Needs.relTarget(dims({ X = 0 }))).to.equal(40)
			expect(Needs.relTarget(dims({ X = 100 }))).to.equal(100)
			expect(Needs.relSoloFloor(dims({ X = 0 }))).to.equal(60)
			expect(Needs.relSoloFloor(dims({ X = 100 }))).to.equal(0)
			local n0 = Needs.initial(dims({ X = 0 }))
			expect(n0.rest).to.equal(ND.initial)
			expect(n0.rel).to.equal(60) -- rel awal = max(initial, lantai sendiri)
			expect(Needs.initial(dims({ X = 90 })).rel).to.equal(ND.initial)
		end)

		it(
			"hero tanpa aksi 30 hari → semua need < 30 (X 51–100); X ≤ 50 rel berhenti di lantai sendiri ≥ 30",
			function()
				for _, x in { 51, 60, 70, 100 } do
					local d = dims({ X = x, O = 0, H = 100 }) -- laju aut & cmp paling lambat
					local n = run(Needs.initial(d), d, 30)
					for _, k in ND.ids do
						expect((n :: any)[k] < 30).to.equal(true)
					end
				end
				-- hero rata-rata (X 50): rest/food/aut/cmp < 30; rel = lantai sendiri 30 (batas, lihat laporan Q1)
				local d = dims()
				local n = run(Needs.initial(d), d, 30)
				expect(n.rest < 30 and n.food < 30 and n.aut < 30 and n.cmp < 30).to.equal(true)
				expect(n.rel).to.be.near(30, 1e-9)
			end
		)

		it("dipaksa (aut −15) lebih merusak daripada tidak dipenuhi: 1 hari dipaksa > 7 hari diabaikan", function()
			for _, o in { 0, 50, 100 } do
				local d = dims({ O = o })
				local start = Needs.initial(d)
				local forced = Needs.step(start, d, { forced = 1 })
				local neglected = run(start, d, 7)
				local dForced = start.aut - forced.aut
				local dNeglected = start.aut - neglected.aut
				expect(dForced > dNeglected).to.equal(true)
				expect(dForced).to.be.near(15 + 1 + o / 100, 1e-9)
			end
		end)

		it("penyendiri X ≤ 33 tidak pernah rel < 40 tanpa kehilangan (365 hari, dengan & tanpa interaksi)", function()
			for x = 0, 33 do
				local d = dims({ X = x })
				local _, minA = run(Needs.initial(d), d, 365)
				local _, minB = run(Needs.initial(d), d, 365, { fixedParty = true })
				expect(minA >= 40 and minB >= 40).to.equal(true)
			end
			-- batas: semua X tidak pernah turun di bawah lantai sendiri tanpa kehilangan (X 34–35 → 39,6 / 39)
			for x = 0, 100 do
				local d = dims({ X = x })
				local _, minRel = run(Needs.initial(d), d, 365)
				expect(minRel >= Needs.relSoloFloor(d) - 1e-9).to.equal(true)
			end
		end)

		it("kehilangan boleh menembus lantai sendiri; ikatan intim hidup → rel tidak pernah < 40", function()
			local d = dims({ X = 0 })
			local n = Needs.step(Needs.initial(d), d, { relLoss = -45 })
			expect(n.rel < 40).to.equal(true)
			local after = run(n, d, 30)
			expect(after.rel).to.equal(n.rel) -- di bawah lantai: decay tidak mendorong lebih jauh
			local hi = dims({ X = 100 })
			local m = Needs.initial(hi)
			for _ = 1, 60 do
				m = Needs.step(m, hi, { intimate = true, relLoss = -10 })
				expect(m.rel >= ND.rel.intimateFloor).to.equal(true)
			end
		end)

		it("decay rel ×(0,4 + X/100): X 0 → −1,2/hari, X 100 → −4,2/hari (di atas lantai)", function()
			local base = { rest = 100, food = 100, aut = 100, cmp = 100, rel = 100 }
			expect(100 - Needs.step(base, dims({ X = 0 }), {}).rel).to.be.near(1.2, 1e-9)
			expect(100 - Needs.step(base, dims({ X = 100 }), {}).rel).to.be.near(4.2, 1e-9)
			local g = Needs.step(base, dims({ X = 50 }), { fixedParty = true, eatTogether = true, comforted = true })
			expect(g.rel).to.equal(100) -- clamp 100
			local low = { rest = 50, food = 50, aut = 50, cmp = 50, rel = 50 }
			local g2 = Needs.step(low, dims({ X = 100 }), { fixedParty = true, eatTogether = true, comforted = true })
			expect(g2.rel).to.be.near(50 - 4.2 + 2 + 3 + 6, 1e-9)
		end)

		it("rest/food/cmp mengikuti tabel §2.2", function()
			local base = { rest = 100, food = 50, aut = 100, cmp = 100, rel = 100 }
			local d = dims({ C = 100, X = 0 })
			-- latihan ×(1 + 0,3·C/100); misi −25; jabatan −3; keramaian −2·(1 − X/100)
			local r = Needs.step(base, d, { training = true, missions = 2, position = true, crowd = true })
			expect(100 - r.rest).to.be.near(8 * 1.3 + 50 + 3 + 2, 1e-9)
			expect(100 - Needs.step(base, dims({ X = 100 }), { crowd = true }).rest).to.be.near(8, 1e-9)
			-- makan +30, Chef cocok +10, lantai 1 tanpa Restaurant hanya +18
			expect(Needs.step(base, d, { meal = "normal" }).food).to.equal(50 - 20 + 30)
			expect(Needs.step(base, d, { meal = "normal", chefMatch = true }).food).to.equal(50 - 20 + 40)
			expect(Needs.step(base, d, { meal = "floor1" }).food).to.equal(50 - 20 + 18)
			-- cmp ×(0,6 + (100−H)/100·0,6): H 100 → −1,8; H 0 → −3,6
			expect(100 - Needs.step(base, dims({ H = 100 }), {}).cmp).to.be.near(1.8, 1e-9)
			expect(100 - Needs.step(base, dims({ H = 0 }), {}).cmp).to.be.near(3.6, 1e-9)
			local mid = { rest = 50, food = 50, aut = 50, cmp = 50, rel = 50 }
			local c = Needs.step(mid, dims({ H = 100 }), { mvp = 1, floorUp = 1, duelLost = 1 })
			expect(c.cmp).to.be.near(50 - 1.8 + 25 + 20 - 10, 1e-9)
			-- tugas monoton ≥5 hari −2/hari; O ≥ 60 ×1,5
			local m4 = Needs.step(mid, dims({ H = 100 }), { monotoneDays = 4 })
			local m5 = Needs.step(mid, dims({ H = 100 }), { monotoneDays = 5 })
			local m5o = Needs.step(mid, dims({ H = 100, O = 60 }), { monotoneDays = 5 })
			expect(m4.cmp - m5.cmp).to.be.near(2, 1e-9)
			expect(m4.cmp - m5o.cmp).to.be.near(3, 1e-9)
			-- aut: ditolak −5, dikabulkan +8, memilih sendiri +3
			local a = Needs.step(mid, dims({ O = 0 }), { requestDenied = 1, requestGranted = 1, ownChoice = true })
			expect(a.aut).to.be.near(50 - 1 - 5 + 8 + 3, 1e-9)
		end)

		it("semua kebutuhan tetap 0–100; apply() untuk gain aksi di-clamp", function()
			local d = dims()
			local n = Needs.step(Needs.initial(d), d, { missions = 9, forced = 9, duelLost = 9, relLoss = -500 })
			for _, k in ND.ids do
				local v = (n :: any)[k]
				expect(v >= 0 and v <= 100).to.equal(true)
			end
			local g = Needs.apply(n, { rest = 250, food = -500 })
			expect(g.rest).to.equal(100)
			expect(g.food).to.equal(0)
			expect(function()
				Needs.apply(n, { hunger = 3 })
			end).to.throw("tidak dikenal")
		end)

		it("fungsi murni: input tidak dimutasi", function()
			local d = dims()
			local n = Needs.initial(d)
			local copy = table.clone(n)
			Needs.step(n, d, { missions = 1, forced = 1 })
			for k, v in copy do
				expect((n :: any)[k]).to.equal(v)
			end
		end)

		it("encode → nd 10 hex (bulat 0–100); decode identik; data rusak ditolak", function()
			local n = { rest = 12.4, food = 0, aut = 99.6, cmp = 50, rel = 100 }
			local s = Needs.encode(n)
			expect(#s).to.equal(10)
			expect(string.match(s, "^[0-9a-f]+$") ~= nil).to.equal(true)
			local back = Needs.decode(s)
			expect(back.rest).to.equal(12)
			expect(back.aut).to.equal(100)
			expect(Needs.encode(back)).to.equal(s)
			expect(function()
				Needs.decode("zz")
			end).to.throw("nd")
			expect(function()
				Needs.decode("ff00000000")
			end).to.throw("nd")
		end)
	end)
end
