--!strict
-- Mental/MoralInjury (tugas §B 2.4): guilt & luka moral — DESAIN_AI_NPC_V0 §3.4.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)
local Rng = require(ReplicatedStorage.Shared.Rng)
local MoralInjury = require(ServerScriptService.Mental.MoralInjury)

local MI = NpcData.moralInjury

local function ctx(A: number?, aToVictim: number?): MoralInjury.Ctx
	return {
		heroId = "h1",
		dims = { H = 50, E = 50, X = 50, A = A or 50, C = 50, O = 50, cou = 50 },
		aToVictim = aToVictim,
	}
end

return function()
	describe("Mental/MoralInjury", function()
		it(
			"pemicu §3.4: (a) a ≥ 8 ke korban sintesis, (b) humanoid bagi A ≥ 65, (c) compound paksa, (d) meninggalkan rekan",
			function()
				expect(MoralInjury.triggers(ctx(50, 8), "synthesis")).to.equal(true)
				expect(MoralInjury.triggers(ctx(50, 7), "synthesis")).to.equal(false)
				expect(MoralInjury.triggers(ctx(50, nil), "synthesis")).to.equal(false)
				expect(MoralInjury.triggers(ctx(65), "humanoid")).to.equal(true)
				expect(MoralInjury.triggers(ctx(64), "humanoid")).to.equal(false)
				expect(MoralInjury.triggers(ctx(), "forced")).to.equal(true)
				expect(MoralInjury.triggers(ctx(), "abandoned")).to.equal(true)
			end
		)

		it(
			"efek: guilt +15…+30 (kedua ujung tercapai), like −10, stres 1 kejadian, penarikan diri 14 hari; cap 100",
			function()
				local rng = Rng.new(21)
				local lo, hi = math.huge, -math.huge
				for _ = 1, 1000 do
					local m, ev = MoralInjury.apply(MoralInjury.initial(), ctx(70), "humanoid", rng)
					lo, hi = math.min(lo, m.g), math.max(hi, m.g)
					expect(m.g == math.floor(m.g)).to.equal(true)
					expect(m.wd).to.equal(MI.withdrawalDays)
					expect(#ev).to.equal(1)
					expect(ev[1].kind).to.equal("moralInjury")
					expect(ev[1].cause).to.equal("humanoid")
					expect(ev[1].like).to.equal(-10)
					expect(ev[1].stress).to.equal(1)
				end
				expect(lo).to.equal(15)
				expect(hi).to.equal(30)
				local m = { g = 95, wd = 0 }
				m = MoralInjury.apply(m, ctx(), "forced", rng)
				expect(m.g).to.equal(100)
			end
		)

		it("tidak memicu → state sama, tanpa event, RNG tidak dipakai", function()
			local a, b = Rng.new(3), Rng.new(3)
			local m, ev = MoralInjury.apply({ g = 10, wd = 2 }, ctx(40), "humanoid", a)
			expect(m.g).to.equal(10)
			expect(m.wd).to.equal(2)
			expect(#ev).to.equal(0)
			expect(a:NextUInt32()).to.equal(b:NextUInt32())
		end)

		it("penarikan diri: aksi sosial ×0,5 selama 14 hari, lalu kembali ×1", function()
			local m = MoralInjury.apply(MoralInjury.initial(), ctx(), "abandoned", Rng.new(1))
			for _ = 1, 14 do
				expect(MoralInjury.socialMult(m)).to.equal(0.5)
				m = MoralInjury.endDay(m)
			end
			expect(MoralInjury.socialMult(m)).to.equal(1)
		end)

		it("guilt tidak pulih lewat waktu/istirahat; hanya penebusan −20 dan dihibur rekan t ≥ 9 (−5)", function()
			local m = { g = 40, wd = 0 }
			for _ = 1, 365 do
				m = MoralInjury.endDay(m)
			end
			expect(m.g).to.equal(40)
			expect(MoralInjury.redeem(m).g).to.equal(20)
			expect(MoralInjury.comforted(m, 9).g).to.equal(35)
			expect(MoralInjury.comforted(m, 8).g).to.equal(40)
			expect(MoralInjury.redeem({ g = 5, wd = 0 }).g).to.equal(0)
			expect(MoralInjury.addGuilt({ g = 90, wd = 0 }, 40).g).to.equal(100)
		end)
	end)
end
