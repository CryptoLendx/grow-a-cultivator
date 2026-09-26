--!strict
-- Mental/Stress (tugas §B 2.3): vul, st, ld, ambang patah = f(vul, ld), sumber/penurun §3.3 — DESAIN_AI_NPC_V0 §3.2–3.3.
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)
local Stress = require(ServerScriptService.Mental.Stress)

local S = NpcData.stress
local FULL = { rest = 100, food = 100, aut = 100, cmp = 100, rel = 100 }

local function dims(over: { [string]: number }?): { [string]: number }
	local d = { H = 50, E = 50, X = 50, A = 50, C = 50, O = 50, cou = 50 }
	if over then
		for k, v in over do
			d[k] = v
		end
	end
	return d
end

local function ctx(over: { [string]: any }?): Stress.Ctx
	local c: any = {
		heroId = "h1",
		dims = dims(),
		xp = 0,
		intimateLosses = 0,
		goals = { "strongest" },
		aversion = nil,
		needs = FULL,
	}
	if over then
		for k, v in over do
			c[k] = v
		end
	end
	return c
end

local function state(st: number, ld: number?): Stress.State
	local s = Stress.initial()
	s.st = st
	s.ld = ld or 0
	return s
end

-- Δst satu hari dengan pemulihan dasar dihapus (hanya sumber/penurun yang diuji).
local function delta(c: Stress.Ctx, day: Stress.Day, st0: number?): number
	local s0 = state(st0 or 50)
	local s1 = Stress.step(s0, c, day)
	local base = Stress.recoverBase(Stress.vul(c.dims, c.intimateLosses), c.xp)
	return s1.st - s0.st + base
end

return function()
	describe("Mental/Stress", function()
		it("vul = 0,5·E + 0,3·(100−cou) + 0,2·(100−C) + 3/kehilangan intim; clamp 0–100", function()
			expect(Stress.vul(dims({ E = 100, cou = 0, C = 0 }), 0)).to.equal(100)
			expect(Stress.vul(dims({ E = 0, cou = 100, C = 100 }), 0)).to.equal(0)
			expect(Stress.vul(dims(), 0)).to.equal(50)
			expect(Stress.vul(dims(), 2)).to.equal(56)
			expect(Stress.vul(dims({ E = 100, cou = 0, C = 0 }), 5)).to.equal(100)
		end)

		it("ambang patah = 90 − 0,3·vul − 0,2·ld: rapuh ~70, tangguh ~90; ld menurunkannya", function()
			expect(Stress.breakThreshold(0, 0)).to.equal(90)
			expect(Stress.breakThreshold(100, 0)).to.equal(60)
			expect(Stress.breakThreshold(67, 0)).to.be.near(69.9, 1e-9)
			expect(Stress.breakThreshold(50, 50)).to.equal(65)
		end)

		it("pulih_dasar = 4·(0,6 + (100−vul)/100·0,8)·(1 + 0,2·xp/100)", function()
			expect(Stress.recoverBase(0, 0)).to.be.near(5.6, 1e-9)
			expect(Stress.recoverBase(100, 0)).to.be.near(2.4, 1e-9)
			expect(Stress.recoverBase(100, 100)).to.be.near(2.88, 1e-9)
			-- hari tanpa peristiwa, kebutuhan penuh: st turun sebesar pulih_dasar
			local c = ctx()
			local s = Stress.step(state(50), c, {})
			expect(50 - s.st).to.be.near(Stress.recoverBase(50, 0), 1e-9)
		end)

		it("tarikan kebutuhan: +0,1·(100−rest) + 0,05·(100−aut/cmp/rel), ×(1 + ld/200)", function()
			local empty = { rest = 0, food = 0, aut = 0, cmp = 0, rel = 0 }
			expect(delta(ctx({ needs = empty }), {}, 0)).to.be.near(25, 1e-9)
			local s0 = state(0, 100)
			local s1 = Stress.step(s0, ctx({ needs = empty }), {})
			expect(s1.st + Stress.recoverBase(50, 0)).to.be.near(25 * 1.5, 1e-9)
		end)

		it("ld naik hanya setelah ≥1 hari st ≥ 60 (lonjakan yang pulih di hari sama tidak dihitung)", function()
			local c = ctx()
			-- hari berakhir st < 60 meski ada sumber besar di siang hari
			local s = Stress.step(state(55), c, { punished = 1, vacation = true })
			expect(s.st < 60).to.equal(true)
			expect(s.ld).to.equal(0)
			-- hari berakhir st ≥ 60 → ld +1; tiap hari berikutnya st ≥ 60 → +1
			s = Stress.step(state(55), c, { punished = 1 })
			expect(s.st >= 60).to.equal(true)
			expect(s.ld).to.equal(1)
			s = Stress.step(s, c, { punished = 1 })
			expect(s.ld).to.equal(2)
		end)

		it("ld turun hanya setelah 7 hari berturut st < 40; terputus → hitung ulang", function()
			local c = ctx()
			local s = state(10, 20)
			for _ = 1, 6 do
				s = Stress.step(s, c, {})
				expect(s.ld).to.equal(20)
			end
			s = Stress.step(s, c, {})
			expect(s.ld).to.equal(19)
			s = Stress.step(s, c, {})
			expect(s.ld).to.equal(18)
			-- satu hari st ≥ 40 memutus hitungan
			s = Stress.step(s, c, { punished = 3 })
			expect(s.st >= 40).to.equal(true)
			local ldAfter = s.ld
			s.st = 0
			for _ = 1, 6 do
				s = Stress.step(s, c, {})
			end
			expect(s.ld).to.equal(ldAfter)
			s = Stress.step(s, c, {})
			expect(s.ld).to.equal(ldAfter - 1)
		end)

		it("ld menaikkan laju naik stres ×(1 + ld/200)", function()
			local c = ctx()
			local a = Stress.step(state(0, 0), c, { punished = 1 })
			local b = Stress.step(state(0, 100), c, { punished = 1 })
			expect(b.st - a.st).to.be.near(15 * 0.5, 1e-9)
		end)

		it("misi +10 dengan kurva combat fatigue: hari tempur ke-≥4 ×1,5, ke-≥8 ×2,5", function()
			local c = ctx()
			local s = state(0)
			local rises = {}
			for day = 1, 9 do
				s.st = 0
				s = Stress.step(s, c, { missions = 1 })
				rises[day] = s.st + Stress.recoverBase(50, 0)
			end
			expect(rises[3]).to.be.near(10, 1e-9)
			expect(rises[4]).to.be.near(15, 1e-9)
			expect(rises[7]).to.be.near(15, 1e-9)
			expect(rises[8]).to.be.near(25, 1e-9)
			-- hari tanpa misi memutus beruntun
			s = Stress.step(s, c, {})
			s.st = 0
			s = Stress.step(s, c, { missions = 1 })
			expect(s.st + Stress.recoverBase(50, 0)).to.be.near(10, 1e-9)
		end)

		it(
			"sumber §3.3: humanoid, rekan mati, sintesis, latihan, riset, tidak dilibatkan, jabatan, demosi, hukuman, luka moral",
			function()
				-- humanoid +5 (keengganan ATAU A ≥ 65), +10 (keduanya), 0 bila tidak ada
				expect(delta(ctx(), { humanoidMissions = 1 })).to.be.near(0, 1e-9)
				expect(delta(ctx({ dims = dims({ A = 65 }) }), { humanoidMissions = 1 })).to.be.near(5, 1e-9)
				expect(delta(ctx({ aversion = "humanoid" }), { humanoidMissions = 1 })).to.be.near(5, 1e-9)
				expect(delta(ctx({ aversion = "humanoid", dims = dims({ A = 80 }) }), { humanoidMissions = 1 })).to.be.near(
					10,
					1e-9
				)
				expect(delta(ctx(), { comradeDiedBeside = 1 })).to.be.near(20, 1e-9)
				expect(delta(ctx(), { intimateDiedBeside = 1 })).to.be.near(40, 1e-9)
				expect(delta(ctx(), { roomDeaths = 2 })).to.be.near(8, 1e-9)
				expect(delta(ctx(), { synthesisWitnessed = 1 })).to.be.near(8, 1e-9)
				expect(delta(ctx(), { synthesisWitnessedClose = 1 })).to.be.near(15, 1e-9)
				expect(delta(ctx(), { synthesisThreat = 1 })).to.be.near(15, 1e-9)
				expect(delta(ctx(), { trainingSessions = 2 })).to.be.near(0, 1e-9)
				expect(delta(ctx(), { trainingSessions = 4 })).to.be.near(8, 1e-9)
				expect(delta(ctx(), { researchHours = 3 })).to.be.near(0, 1e-9)
				expect(delta(ctx(), { researchHours = 5 })).to.be.near(6, 1e-9)
				expect(delta(ctx(), { notInvolvedDays = 6 })).to.be.near(0, 1e-9)
				expect(delta(ctx(), { notInvolvedDays = 7 })).to.be.near(2, 1e-9)
				expect(delta(ctx({ goals = { "calm" } }), { notInvolvedDays = 30 })).to.be.near(0, 1e-9)
				expect(delta(ctx({ goals = { "strongest", "calm" } }), { notInvolvedDays = 30 })).to.be.near(0, 1e-9)
				expect(delta(ctx(), { position = true })).to.be.near(2, 1e-9)
				expect(delta(ctx(), { demoted = 1 })).to.be.near(12, 1e-9)
				expect(delta(ctx(), { punished = 1 })).to.be.near(15, 1e-9)
				expect(delta(ctx(), { moralInjury = 1 })).to.be.near(10, 1e-9)
			end
		)

		it(
			"penurun §3.3: istirahat, tidur cukup, hobi, vacation, gift (st < 70), cheering, makan bersama, MVP, comfort, ritual, goal",
			function()
				expect(delta(ctx(), { rest = true })).to.be.near(-8, 1e-9)
				expect(delta(ctx(), { rest = true, sleepWell = true })).to.be.near(-12, 1e-9)
				expect(delta(ctx(), { vacation = true })).to.be.near(-20, 1e-9)
				expect(delta(ctx(), { giftMatch = true }, 69)).to.be.near(-10, 1e-9)
				expect(delta(ctx(), { giftMatch = true }, 70)).to.be.near(0, 1e-9) -- [K] ch.284 "no change"
				expect(delta(ctx(), { cheering = 1 })).to.be.near(-5, 1e-9)
				expect(delta(ctx(), { eatTogether = true })).to.be.near(-2, 1e-9)
				expect(delta(ctx(), { floorUpOrMvp = 1 })).to.be.near(-8, 1e-9)
				expect(delta(ctx(), { comfortItem = true })).to.be.near(-1, 1e-9)
				expect(delta(ctx(), { griefRitual = true })).to.be.near(-6, 1e-9)
				expect(delta(ctx(), { goalAchieved = true })).to.be.near(-15, 1e-9)
				-- hobi −5 dan pemulihan dasar ×1,2; dukungan rekan dipercaya: pemulihan dasar ×1,4
				local base = Stress.recoverBase(50, 0)
				local h = Stress.step(state(50), ctx(), { hobby = true })
				expect(50 - h.st).to.be.near(5 + base * 1.2, 1e-9)
				local t = Stress.step(state(50), ctx(), { trustedSupport = true })
				expect(50 - t.st).to.be.near(base * 1.4, 1e-9)
			end
		)

		it("st tetap 0–100; event stressBreak hanya saat melewati ambang patah dari bawah", function()
			local c = ctx()
			local s, ev = Stress.step(state(50), c, { punished = 9 })
			expect(s.st).to.equal(100)
			expect(#ev).to.equal(1)
			expect(ev[1].kind).to.equal("stressBreak")
			expect(ev[1].heroId).to.equal("h1")
			local _, ev2 = Stress.step(s, c, { punished = 1 })
			expect(#ev2).to.equal(0)
			local s3 = Stress.step(state(5), c, { vacation = true })
			expect(s3.st).to.equal(0)
		end)

		it("fungsi murni: state input tidak dimutasi; seed/urutan sama → hasil sama", function()
			local c = ctx()
			local s0 = state(40, 3)
			local copy = table.clone(s0)
			local a = Stress.step(s0, c, { missions = 1, punished = 1 })
			local b = Stress.step(s0, c, { missions = 1, punished = 1 })
			for k, v in copy do
				expect((s0 :: any)[k]).to.equal(v)
			end
			expect(a.st).to.equal(b.st)
			expect(S.ld.riseAtSt).to.equal(60)
		end)
	end)
end
