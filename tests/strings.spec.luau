--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StringsData = require(ReplicatedStorage.Data.Strings)
local Strings = require(ReplicatedStorage.Shared.Strings)

return function()
	describe("Data/Strings + Shared/Strings.format", function()
		it("Data/Strings hanya tabel id → string", function()
			local count = 0
			for id, text in StringsData do
				expect(typeof(id)).to.equal("string")
				expect(typeof(text)).to.equal("string")
				count += 1
			end
			print(string.format("         %d string", count))
			expect(count > 0).to.equal(true)
		end)

		it("setiap id punya placeholder yang bisa diisi", function()
			for id in StringsData do
				local args: { [string]: string } = {}
				for _, key in Strings.placeholders(id) do
					args[key] = "<" .. key .. ">"
				end
				local out = Strings.format(id, args)
				expect((string.find(out, "{", 1, true))).to.equal(nil)
				expect((string.find(out, "}", 1, true))).to.equal(nil)
				for key in args do
					expect(string.find(out, "<" .. key .. ">", 1, true) ~= nil).to.equal(true)
				end
			end
		end)

		it("tidak ada string duplikat", function()
			local seen: { [string]: string } = {}
			for id, text in StringsData do
				if seen[text] then
					error(string.format("duplikat: %s = %s", id, seen[text]))
				end
				seen[text] = id
			end
		end)

		it("format mengisi {name} {stars} {party}; argumen kurang / id asing → error", function()
			expect(Strings.format("REFUSED", { name = "Han", stars = "★" })).to.equal(
				"['Han (★)' refused to participate!]"
			)
			expect(Strings.format("PARTY_UNCTRL", { party = "Party 1" })).to.equal(
				"['Party 1' has become uncontrollable.]"
			)
			expect(Strings.format("MASS_STRIKE")).to.equal("[Mass strike!]\n[Heroes are rioting!]")
			expect(Strings.format("REFUSED", { name = "Han", stars = 3 })).to.equal(
				"['Han (3)' refused to participate!]"
			)
			expect(function()
				Strings.format("REFUSED", { name = "Han" })
			end).to.throw("stars")
			expect(function()
				Strings.format("NOT_AN_ID", {})
			end).to.throw("NOT_AN_ID")
		end)

		it("string contoh DESAIN_AI_NPC §7.3 tersedia verbatim", function()
			expect(Strings.format("SUDDEN_DEATH", { name = "Mormont", stars = "★★" })).to.equal(
				"['Mormont (★★)' has returned to the arms of the goddess. His fighting spirit will be remembered forever.]\n[Sudden death!]\n[Cause – Suicide due to stress]"
			)
			expect(Strings.format("STRESS_WARN", { name = "Han", stars = "★★" })).to.equal(
				"[Warning!]\n[Hero 'Han (★★)'s stress level is dangerous!]"
			)
		end)
	end)
end
