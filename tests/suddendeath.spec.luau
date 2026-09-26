--!strict
-- Mental/SuddenDeath (tugas §B 2.4): roll hanya pada kombinasi faktor, warning 1×/episode, p memakai cou_eff —
-- DESAIN_AI_NPC_V0 §3.5, §1.2a.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)
local Rng = require(ReplicatedStorage.Shared.Rng)
local Needs = require(ServerScriptService.Autonomy.Needs)
local Stress = require(ServerScriptService.Mental.Stress)
local Experience = require(ServerScriptService.Mental.Experience)
local SuddenDeath = require(ServerScriptService.Mental.SuddenDeath)

local SD = NpcData.suddenDeath

local function dims(over: { [string]: number }?): { [string]: number }
	local d = { H = 50, E = 50, X = 50, A = 50, C = 50, O = 50, cou = 50 }
	if over then
		for k, v in over do
			d[k] = v
		end
	end
	return d
end

-- Konteks yang memenuhi SEMUA faktor §3.5 (st 95 ≥ ambang, rel 10, tanpa relasi, kehilangan hari ini).
local function risky(over: { [string]: any }?): SuddenDeath.Ctx
	local c: any = {
		heroId = "h1",
		dims = dims(),
		intimateLosses = 0,
		xp = 0,
		st = 95,
		ld = 0,
		rel = 10,
		ties = {},
		lossDaysAgo = 0,
	}
	if over then
		for k, v in over do
			c[k] = v
		end
	end
	return c
end

-- Mormont (BK-1 #4–6): 2★ baru, tanpa relasi, wipe pertama (8 rekan mati di sisinya); lalu tanpa aksi.
type Run = { death: number?, warn: number?, warns: number }
local function mormont(seed: number, days: number): Run
	local d = dims({ E = 60, X = 60, cou = 40 })
	local rng = Rng.new(Rng.derive(seed, "mormont"))
	local needs = Needs.initial(d)
	local st = Stress.initial()
	local sd = SuddenDeath.initial()
	local xp = Experience.seed(2).xp
	local run: Run = { warns = 0 }
	for day = 1, days do
		local wipe = day == 1
		needs = Needs.step(needs, d, if wipe then { missions = 1, relLoss = -10 } else {})
		st = Stress.step(st, {
			heroId = "m",
			dims = d,
			xp = xp,
			intimateLosses = 0,
			goals = { "strongest" },
			needs = needs,
		}, if wipe then { missions = 1, comradeDiedBeside = 8 } else {})
		local ev
		sd, ev = SuddenDeath.step(sd, {
			heroId = "m",
			dims = d,
			intimateLosses = 0,
			xp = xp,
			st = st.st,
			ld = st.ld,
			rel = needs.rel,
			ties = {},
			lossDaysAgo = day - 1,
		}, rng)
		for _, e in ev do
			if e.kind == "stressWarning" then
				run.warns += 1
				run.warn = day
			elseif e.kind == "suddenDeath" then
				run.death = day
				return run
			end
		end
	end
	return run
end

return function()
	describe("Mental/SuddenDeath", function()
		it("p = 0,03·(1 + vul_eff/100)·(1 + ld/100); vul_eff memakai cou_eff, ambang memakai vul genetik", function()
			local c = risky({ ld = 20, xp = 30 })
			local couEff = Experience.couEff(50, 30, 20) -- 50 + 9 − 4 = 55
			expect(couEff).to.equal(55)
			local vulEff = 0.5 * 50 + 0.3 * (100 - couEff) + 0.2 * 50
			expect(SuddenDeath.vulEff(c)).to.be.near(vulEff, 1e-9)
			expect(SuddenDeath.p(c)).to.be.near(0.03 * (1 + vulEff / 100) * 1.2, 1e-12)
			expect(SuddenDeath.threshold(c)).to.be.near(90 - 0.3 * 50 - 0.2 * 20, 1e-9)
		end)

		it("tiap faktor yang hilang → p = 0; relasi ke hero mati tidak melindungi", function()
			expect(SuddenDeath.p(risky()) > 0).to.equal(true)
			local thr = SuddenDeath.threshold(risky())
			expect(SuddenDeath.p(risky({ st = thr - 0.01 }))).to.equal(0)
			expect(SuddenDeath.p(risky({ st = thr })) > 0).to.equal(true)
			expect(SuddenDeath.p(risky({ rel = 30 }))).to.equal(0)
			expect(SuddenDeath.p(risky({ ties = { { t = 9, a = 0, alive = true } } }))).to.equal(0)
			expect(SuddenDeath.p(risky({ ties = { { t = 0, a = 8, alive = true } } }))).to.equal(0)
			expect(SuddenDeath.p(risky({ ties = { { t = 8, a = 7, alive = true } } })) > 0).to.equal(true)
			expect(SuddenDeath.p(risky({ ties = { { t = 15, a = 7, alive = false } } })) > 0).to.equal(true)
			expect(SuddenDeath.p(risky({ dependents = true }))).to.equal(0)
			expect(SuddenDeath.p(risky({ comfortedDaysAgo = 3 }))).to.equal(0)
			expect(SuddenDeath.p(risky({ comfortedDaysAgo = 4 })) > 0).to.equal(true)
			expect(SuddenDeath.p(risky({ lossDaysAgo = 30 })) > 0).to.equal(true)
			expect(SuddenDeath.p(risky({ lossDaysAgo = 31 }))).to.equal(0)
			local noLoss2, noLoss3 = risky({ failedMissions = 2 }), risky({ failedMissions = 3 })
			noLoss2.lossDaysAgo, noLoss3.lossDaysAgo = nil, nil
			expect(SuddenDeath.p(noLoss2)).to.equal(0)
			expect(SuddenDeath.p(noLoss3) > 0).to.equal(true)
		end)

		it("hero st 95 dengan 1 relasi hidup t ≥ 9 → tidak pernah mati (365 hari × 20 seed)", function()
			local deaths = 0
			for seed = 1, 20 do
				local rng = Rng.new(Rng.derive(seed, "protected"))
				local s = SuddenDeath.initial()
				local c = risky({ ties = { { t = 9, a = 0, alive = true }, { t = 15, a = 7, alive = false } } })
				for _ = 1, 365 do
					local ev
					s, ev = SuddenDeath.step(s, c, rng)
					for _, e in ev do
						if e.kind == "suddenDeath" then
							deaths += 1
						end
					end
				end
			end
			expect(deaths).to.equal(0)
		end)

		it(
			"Mormont (2★ baru, tanpa relasi, wipe) → mati dalam 60 hari pada ≥10/20 seed; warning ≥3 hari sebelumnya",
			function()
				local died, gaps = 0, {}
				for seed = 1, 20 do
					local r = mormont(seed, 60)
					if r.death then
						died += 1
						expect(r.warn ~= nil).to.equal(true)
						local gap = r.death - (r.warn :: number)
						expect(gap >= SD.warnWindow.min).to.equal(true)
						table.insert(gaps, gap)
					end
				end
				print(
					string.format(
						"  [angka] Mormont: %d/20 seed mati ≤60 hari; jarak warning→kematian %s hari",
						died,
						table.concat(gaps, ",")
					)
				)
				expect(died >= 10).to.equal(true)
			end
		)

		it("warning 1× per episode; episode baru setelah st turun di bawah ambang − 15", function()
			local c = risky({ rel = 50 }) -- tanpa roll (rel ≥ 30): hanya warning
			local thr = SuddenDeath.threshold(c)
			local s, n = SuddenDeath.initial(), 0
			local rng = Rng.new(1)
			local function day(st: number)
				local cc = table.clone(c)
				cc.st = st
				local ev
				s, ev = SuddenDeath.step(s, cc, rng)
				for _, e in ev do
					if e.kind == "stressWarning" then
						n += 1
					end
				end
			end
			for _ = 1, 20 do
				day(thr - 15)
			end
			expect(n).to.equal(1)
			day(thr - 15.01)
			day(thr + 5)
			expect(n).to.equal(2)
		end)

		it(
			"lonjakan st sehari (semua faktor terpenuhi sejak hari 1) → kematian tidak sebelum warning + 3 hari (500 seed)",
			function()
				local earliest = math.huge
				for seed = 1, 500 do
					local rng = Rng.new(Rng.derive(seed, "spike"))
					local s = SuddenDeath.initial()
					for d = 1, 10 do
						local ev
						s, ev = SuddenDeath.step(s, risky(), rng)
						for _, e in ev do
							if e.kind == "suddenDeath" then
								earliest = math.min(earliest, d)
							end
						end
					end
				end
				expect(earliest).to.equal(1 + SD.warnWindow.min) -- warning hari 1 → roll pertama hari 4
			end
		)

		it(
			"cou genetik sama, xp/ld beda → p beda sesuai cou_eff; log seed sama: hero cou_eff rendah mati ≤ hari hero cou_eff tinggi",
			function()
				local lowEff = risky({ xp = 0, ld = 0 }) -- cou_eff 50
				local highEff = risky({ xp = 40, ld = 0 }) -- cou_eff 62
				local ldHigh = risky({ xp = 0, ld = 30 }) -- cou_eff 44, ld 30
				expect(Experience.couEff(50, 0, 0)).to.equal(50)
				expect(Experience.couEff(50, 40, 0)).to.equal(62)
				expect(SuddenDeath.threshold(lowEff)).to.equal(SuddenDeath.threshold(highEff)) -- ambang: vul genetik
				local pLow, pHigh, pLd = SuddenDeath.p(lowEff), SuddenDeath.p(highEff), SuddenDeath.p(ldHigh)
				expect(pLow > pHigh).to.equal(true)
				expect(pLd > pLow).to.equal(true)
				-- log seed sama: cou 50 genetik, (xp 0, ld 30 → cou_eff 44) vs (xp 40, ld 0 → cou_eff 62)
				local log, dLow, dHigh, earlier = {}, 0, 0, 0
				for seed = 1, 20 do
					local function firstDeath(c: SuddenDeath.Ctx): number
						local rng = Rng.new(Rng.derive(seed, "coueff"))
						local s = { ws = SD.warnWindow.min } -- warning sudah lewat: roll aktif sejak hari 1
						for day = 1, 60 do
							local ev
							s, ev = SuddenDeath.step(s, c, rng)
							for _, e in ev do
								if e.kind == "suddenDeath" then
									return day
								end
							end
						end
						return math.huge
					end
					local a, b = firstDeath(ldHigh), firstDeath(highEff)
					expect(a <= b).to.equal(true)
					if a < math.huge then
						dLow += 1
					end
					if b < math.huge then
						dHigh += 1
					end
					if a < b then
						earlier += 1
					end
					table.insert(log, string.format("%d:%s/%s", seed, tostring(a), tostring(b)))
				end
				print(
					string.format(
						"  [angka] p/hari cou_eff 50 = %.5f, cou_eff 62 = %.5f, ld 30 = %.5f",
						pLow,
						pHigh,
						pLd
					)
				)
				print(
					string.format(
						"  [angka] mati ≤60 hari: cou_eff 44 %d/20, cou_eff 62 %d/20, lebih awal %d",
						dLow,
						dHigh,
						earlier
					)
				)
				print(
					"  [angka] hari kematian pertama seed:(xp 0, ld 30)/(xp 40, ld 0) (inf = hidup 60 hari) "
						.. table.concat(log, " ")
				)
				expect(earlier >= 1).to.equal(true)
			end
		)
	end)
end
