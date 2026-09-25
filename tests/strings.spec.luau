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

		it("9 string [K] Data_Strings_K_Lengkap tersedia verbatim", function()
			local ids = {
				"FACILITY_BUILT",
				"FACILITY_MANAGER",
				"FOOD_TYPES",
				"BUSINESS_REPORT",
				"PARTY_INSUFFICIENT",
				"REQ_MOCK_BATTLE",
				"GIFT_GREATLY_DISAPPOINTED",
				"TIPS_REST",
				"FAIL_LAST_CHANCE",
			}
			for _, id in ids do
				expect(StringsData[id] ~= nil).to.equal(true)
			end
			expect(
				Strings.format(
					"GIFT_GREATLY_DISAPPOINTED",
					{ name = "Han", stars = "★★★", item = "White Horse Statue" }
				)
			).to.equal("['Han (★★★)' is greatly disappointed after receiving the 'White Horse Statue'.]")
			expect(Strings.format("FAIL_LAST_CHANCE", { party = "1st party" })).to.equal(
				"[If you fail this time, all heroes belonging to '1st party' will be destroyed...]"
			)
		end)

		it("4 string [K] ch.65 Data_Strings_K_Lengkap #10–#13 verbatim", function()
			expect(Strings.format("FLOOR_ASSIGN_PARTY", { party = "1st party", floor = "2nd" })).to.equal(
				"[1st party is all on the 2nd floor...]"
			)
			expect(
				Strings.format("FLOOR_ASSIGN_NAMES", { names = "Chloe Enoch Alter Patrick Amarin", floor = "second" })
			).to.equal("[Chloe Enoch Alter Patrick Amarin. You guys are also on the second floor.]")
			expect(Strings.format("FLOOR_ASSIGN_REST", { floor = "first" })).to.equal(
				"[Everything else is on the first floor.]"
			)
			expect(Strings.format("ROOM_HEADCOUNT", { n = 35 })).to.equal(
				"[Currently, there are 35 people in the waiting room... Master's instructions are...]"
			)
		end)

		it("varian NONKANON lengkap _1.._n sesuai Data_Strings_NONKANON.md", function()
			local counts: { [string]: number } = {
				STEAL = 5,
				EXTORT = 4,
				PROVOKE = 4,
				WENT_ALONE = 4,
				DECLINED_POSITION = 3,
				GRIEF_VISIT = 5,
				MENTIONS_DECEASED = 4,
				BOND_NAMED = 3,
				WILL_WRITTEN = 3,
				MEMORIAL_CARD = 3,
			}
			local total = 0
			for base, n in counts do
				for i = 1, n do
					expect(StringsData[base .. "_" .. i] ~= nil).to.equal(true)
				end
				expect(StringsData[base .. "_" .. (n + 1)]).to.equal(nil)
				total += n
			end
			expect(total).to.equal(38)
			expect(Strings.format("MENTIONS_DECEASED_1", { name = "Han", deceased = "Mormont" })).to.equal(
				"['Han' mentioned 'Mormont' again today.]"
			)
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
