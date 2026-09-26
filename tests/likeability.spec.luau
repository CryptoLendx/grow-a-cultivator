--!strict
-- Mental/Likeability (tugas §B 2.3): likeability hero ke master 0–100 — DESAIN_AI_NPC_V0 §3.6.
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)
local Likeability = require(ServerScriptService.Mental.Likeability)

local L = NpcData.likeability
local CALM = { st = 20, H = 50 }

return function()
	describe("Mental/Likeability", function()
		it("nilai awal saat summon = 50 (LAPORAN 2026-09-25 Q4)", function()
			expect(Likeability.initial()).to.equal(50)
			expect(L.initial).to.equal(50)
		end)

		it(
			"naik: gift cocok +8, mogok diterima +10, request dikabulkan +4, kesejahteraan +0,3/hari, cheering +2, ritual +5",
			function()
				expect(Likeability.step(50, CALM, { giftMatch = 1 })).to.equal(58)
				expect(Likeability.step(50, CALM, { strikeAccepted = 1 })).to.equal(60)
				expect(Likeability.step(50, CALM, { requestGranted = 2 })).to.equal(58)
				expect(Likeability.step(50, CALM, { welfare = true })).to.be.near(50.3, 1e-9)
				expect(Likeability.step(50, CALM, { cheering = 1 })).to.equal(52)
				expect(Likeability.step(50, CALM, { ritualAttended = 1 })).to.equal(55)
			end
		)

		it(
			"turun: gift dibenci −12 (−20 bila H < 40), request ditolak −3, sintesis −6, hukuman −15, luka moral −10, lantai 1 tanpa fasilitas −0,3/hari",
			function()
				expect(Likeability.step(50, CALM, { giftHated = 1 })).to.equal(38)
				expect(Likeability.step(50, { st = 20, H = 39 }, { giftHated = 1 })).to.equal(30)
				expect(Likeability.step(50, { st = 20, H = 40 }, { giftHated = 1 })).to.equal(38)
				expect(Likeability.step(50, CALM, { requestDenied = 1 })).to.equal(47)
				expect(Likeability.step(50, CALM, { synthesisWitnessed = 1 })).to.equal(44)
				expect(Likeability.step(50, CALM, { punishment = 1 })).to.equal(35)
				expect(Likeability.step(50, CALM, { moralInjury = 1 })).to.equal(40)
				expect(Likeability.step(50, CALM, { floor1NoFacility = true })).to.be.near(49.7, 1e-9)
			end
		)

		it("gift cocok tidak bekerja saat st ≥ 70 ([K] ch.284 'no change')", function()
			expect(Likeability.step(50, { st = 70, H = 50 }, { giftMatch = 1 })).to.equal(50)
			expect(Likeability.step(50, { st = 69, H = 50 }, { giftMatch = 1 })).to.equal(58)
		end)

		it("tetap 0–100", function()
			expect(Likeability.step(95, CALM, { strikeAccepted = 1 })).to.equal(100)
			expect(Likeability.step(5, CALM, { punishment = 1 })).to.equal(0)
		end)
	end)
end
