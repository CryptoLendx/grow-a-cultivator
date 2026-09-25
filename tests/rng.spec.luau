--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rng = require(ReplicatedStorage.Shared.Rng)

return function()
	describe("Shared/Rng", function()
		it("2 run seed sama → 1.000 angka identik", function()
			local a, b = Rng.new(42), Rng.new(42)
			for _ = 1, 1000 do
				expect(a:NextNumber()).to.equal(b:NextNumber())
				expect(a:NextInteger(1, 100)).to.equal(b:NextInteger(1, 100))
			end
		end)

		it("seed berbeda → urutan berbeda", function()
			local a, b = Rng.new(42), Rng.new(43)
			local same = 0
			for _ = 1, 1000 do
				if a:NextNumber() == b:NextNumber() then
					same += 1
				end
			end
			expect(same).to.equal(0)
		end)

		it("NextNumber di [0,1) dan rata-rata ≈ 0,5; NextInteger inklusif di rentang", function()
			local r = Rng.new(7)
			local sum, seenMin, seenMax = 0, false, false
			for _ = 1, 10000 do
				local x = r:NextNumber()
				expect(x >= 0 and x < 1).to.equal(true)
				sum += x
				local k = r:NextInteger(-2, 2)
				expect(k >= -2 and k <= 2 and k == math.floor(k)).to.equal(true)
				seenMin = seenMin or k == -2
				seenMax = seenMax or k == 2
			end
			expect(sum / 10000).to.be.near(0.5, 0.02)
			expect(seenMin and seenMax).to.equal(true)
			local y = r:NextNumber(10, 20)
			expect(y >= 10 and y < 20).to.equal(true)
		end)

		it("seed besar, negatif, dan 0 tetap deterministik", function()
			for _, seed in { 0, -1, 2 ^ 52 + 12345, -(2 ^ 40) } do
				expect(Rng.new(seed):NextNumber()).to.equal(Rng.new(seed):NextNumber())
			end
			expect(function()
				Rng.new(1.5)
			end).to.throw("seed")
		end)

		it("derive stabil, peka urutan & batas bagian", function()
			expect(Rng.derive(1, "hero7", 3, 2)).to.equal(Rng.derive(1, "hero7", 3, 2))
			expect(Rng.derive(1, 2, 3)).never.to.equal(Rng.derive(1, 3, 2))
			expect(Rng.derive(1, "12", "3")).never.to.equal(Rng.derive(1, "1", "23"))
			expect(Rng.derive(1, 5)).never.to.equal(Rng.derive(2, 5))
			local sub = Rng.derive(99, "a")
			expect(sub == math.floor(sub) and sub >= 0 and sub < 2 ^ 53).to.equal(true)
		end)

		it("sub-seed (profile, hero, day, slot) tidak bertabrakan pada 100.000 sampel", function()
			local seen: { [number]: boolean } = {}
			local n, collisions = 0, 0
			for hero = 1, 100 do
				for day = 1, 100 do
					for slot = 1, 10 do
						local s = Rng.derive(123456789, hero, day, slot)
						if seen[s] then
							collisions += 1
						end
						seen[s] = true
						n += 1
					end
				end
			end
			expect(n).to.equal(100000)
			expect(collisions).to.equal(0)
		end)

		it("urutan terkunci (regresi replay): seed 1 menghasilkan angka yang sama selamanya", function()
			local r = Rng.new(1)
			local got = {}
			for i = 1, 5 do
				got[i] = r:NextInteger(0, 999999)
			end
			expect(table.concat(got, ",")).to.equal("320745,250181,596261,212680,268854")
		end)
	end)
end
