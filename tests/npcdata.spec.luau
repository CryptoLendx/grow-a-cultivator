--!strict
-- Data/NpcData + Data/IdioData (tugas §B 2.1): tabel murni, lengkap, dan angka cocok DESAIN_AI_NPC_V0.
-- Bentuk `Linear` = k + Σ koef·variabel; diuji di titik ujung yang disebut docs agar transkripsi rumus terjaga.
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)
local IdioData = require(ServerStorage.Data.IdioData)

type Linear = NpcData.Linear
type Product = NpcData.Product

-- Nama variabel yang boleh muncul di `Linear` (sifat, keadaan, relasi, turunan).
local VARS = {
	k = true,
	H = true,
	E = true,
	X = true,
	A = true,
	C = true,
	O = true,
	cou = true,
	couEff = true,
	xp = true,
	ld = true,
	vul = true,
	st = true,
	a = true,
	t = true,
	f = true,
	I = true,
	star = true,
	level = true,
	rReceived = true,
}

local function lin(form: Linear, vars: { [string]: number }): number
	local v = form.k or 0
	for key, coef in form do
		if key ~= "k" then
			v += coef * (vars[key] or error("variabel tidak diisi: " .. key))
		end
	end
	return v
end

local function prod(form: Product, vars: { [string]: number }): number
	local v = form.base
	for _, factor in form.factors do
		v *= lin(factor, vars)
	end
	return v
end

local function near(actual: number, expected: number)
	if math.abs(actual - expected) > 1e-9 then
		error(string.format("diharapkan %s, didapat %s", tostring(expected), tostring(actual)), 2)
	end
end

-- Menelusuri seluruh tabel: hanya table/number/string/boolean; angka terbatas; kunci Linear dikenal.
local function walk(node: any, path: string, visit: (string, any) -> ())
	visit(path, node)
	if type(node) == "table" then
		for key, value in node do
			walk(value, path .. "." .. tostring(key), visit)
		end
	end
end

return function()
	describe("Data/NpcData + Data/IdioData", function()
		it("hanya tabel murni: tanpa fungsi, angka terbatas", function()
			local count = 0
			local roots: { [string]: any } = { NpcData = NpcData, IdioData = IdioData }
			for name, root in roots do
				walk(root, name, function(path, value)
					local kind = type(value)
					if kind ~= "table" and kind ~= "number" and kind ~= "string" and kind ~= "boolean" then
						error(path .. " bertipe " .. kind)
					end
					if kind == "number" then
						count += 1
						if value ~= value or value == math.huge or value == -math.huge then
							error(path .. " tidak terbatas")
						end
					end
				end)
			end
			print(string.format("         %d angka", count))
			expect(count > 300).to.equal(true)
		end)

		it("setiap bentuk Linear/Product hanya memakai variabel yang dikenal", function()
			local forms = 0
			walk(NpcData, "NpcData", function(path, value)
				if type(value) == "table" and value.k ~= nil and type(value.k) == "number" then
					forms += 1
					for key in value do
						if not VARS[key] then
							error(path .. ": variabel tidak dikenal " .. tostring(key))
						end
					end
				end
			end)
			walk(IdioData, "IdioData", function(path, value)
				if type(value) == "table" and value.k ~= nil then
					forms += 1
					for key in value do
						if not VARS[key] then
							error(path .. ": variabel tidak dikenal " .. tostring(key))
						end
					end
				end
			end)
			expect(forms >= 20).to.equal(true)
		end)

		it("§1.2 roll sifat & §1.2a xp / cou_eff", function()
			local tr = NpcData.traits
			expect(table.concat(tr.dims, ",")).to.equal("H,E,X,A,C,O,cou")
			expect(tr.mean).to.equal(50)
			expect(tr.sd).to.equal(15)
			expect(tr.min).to.equal(0)
			expect(tr.max).to.equal(100)
			expect(table.concat(tr.cMeanByStar, ",")).to.equal("45,50,55")
			local xp = NpcData.xp
			expect(table.concat(xp.seedByStar, ",")).to.equal("0,15,40")
			expect(xp.habituation).to.equal(2)
			expect(xp.habituationCritical).to.equal(4)
			expect(xp.sensitization).to.equal(-3)
			expect(xp.sensitizationComradeDied).to.equal(-6)
			expect(xp.susceptibleEMin).to.equal(65)
			expect(xp.susceptibleMult).to.equal(1.5)
			expect(xp.mentorPerWeek).to.equal(1)
			near(lin(xp.cap, { cou = 0 }), 40)
			near(lin(xp.cap, { cou = 100 }), 100)
			near(lin(NpcData.couEff, { cou = 50, xp = 40, ld = 10 }), 50 + 12 - 2)
			expect(NpcData.drift.maxShift).to.equal(5)
		end)

		it("§1.3 bobot goal dari sifat (bukan ★), goal kedua 40 %", function()
			local g = IdioData.goals
			expect(#g.order).to.equal(6)
			expect(g.secondChance).to.equal(0.4)
			local lo = { H = 0, E = 0, X = 0, A = 0, C = 0, O = 0 }
			local hi = { H = 100, E = 100, X = 100, A = 100, C = 100, O = 100 }
			near(lin(g.weights.strongest, lo), 50) -- C + (100−A)/2
			near(lin(g.weights.strongest, { H = 0, E = 0, X = 0, A = 0, C = 100, O = 0 }), 150)
			near(lin(g.weights.protect, hi), 150) -- A + X/2
			near(lin(g.weights.recognized, lo), 100) -- (100−H) + X/2
			near(lin(g.weights.calm, lo), 100) -- (100−C) + E/2
			near(lin(g.weights.prove, lo), 100) -- (100−A) + E/2
			near(lin(g.weights.serve, hi), 150) -- H + A/2
			for _, id in g.order do
				expect(g.weights[id] ~= nil).to.equal(true)
				expect(g.weights[id].star).to.equal(nil)
			end
		end)

		it("§1.4 katalog idiosinkrasi & §1.5 memori", function()
			expect(#IdioData.hobbies).to.equal(8)
			expect(#IdioData.habits).to.equal(6)
			expect(#IdioData.aversions).to.equal(4)
			for _, av in IdioData.aversions do
				expect(#av.targets > 0).to.equal(true)
			end
			for _, c in IdioData.counts do
				expect(c.min <= c.max).to.equal(true)
			end
			local mem = NpcData.memory
			expect(mem.capacity).to.equal(10)
			expect(mem.valenceMin).to.equal(-2)
			expect(mem.valenceMax).to.equal(2)
			expect(#mem.kinds).to.equal(14)
		end)

		it("§2.2 laju kebutuhan & kontinum sosial", function()
			local n = NpcData.needs
			expect(table.concat(n.ids, ",")).to.equal("rest,food,aut,cmp,rel")
			expect(n.rest.decay).to.equal(-8)
			expect(n.rest.mission).to.equal(-25)
			expect(n.food.decay).to.equal(-20)
			expect(n.food.meal).to.equal(30)
			expect(n.food.mealFloor1NoRestaurant).to.equal(18)
			expect(n.aut.forced).to.equal(-15)
			expect(n.aut.requestDenied).to.equal(-5)
			expect(n.cmp.mvp).to.equal(25)
			expect(n.rel.intimateFloor).to.equal(40)
			near(lin(n.aut.decayMult, { O = 100 }), 2)
			near(lin(n.cmp.decayMult, { H = 0 }), 1.2) -- gila hormat turun lebih cepat
			near(lin(n.cmp.decayMult, { H = 100 }), 0.6)
			near(lin(n.rel.decayMult, { X = 0 }), 0.4)
			near(lin(n.rel.decayMult, { X = 100 }), 1.4)
			near(lin(n.rel.target, { X = 0 }), 40)
			near(lin(n.rel.target, { X = 100 }), 100)
			near(lin(n.rest.crowd, { X = 0 }), -2)
			near(lin(n.rest.crowd, { X = 100 }), 0)
		end)

		it("§3.2–§3.6 stres, vul, ld, sudden death, likeability", function()
			local s = NpcData.stress
			near(lin(s.vul, { E = 100, cou = 0, C = 0 }), 100)
			near(lin(s.vul, { E = 0, cou = 100, C = 100 }), 0)
			near(lin(s.breakThreshold, { vul = 0, ld = 0 }), 90)
			near(lin(s.breakThreshold, { vul = 100, ld = 0 }), 60)
			near(prod(s.recoverBase, { vul = 0, xp = 0 }), 5.6)
			near(prod(s.recoverBase, { vul = 100, xp = 100 }), 2.4 * 1.2)
			expect(s.ld.riseAtSt).to.equal(60)
			expect(s.ld.fallBelowSt).to.equal(40)
			expect(s.ld.fallAfterDays).to.equal(7)
			expect(s.sources.mission).to.equal(10)
			expect(s.sources.combatStreakMult[1].days).to.equal(4)
			expect(s.sources.combatStreakMult[2].mult).to.equal(2.5)
			expect(s.reducers.giftMatchMaxSt).to.equal(70)
			local sd = NpcData.suddenDeath
			expect(sd.relBelow).to.equal(30)
			expect(sd.protectT).to.equal(9)
			expect(sd.protectA).to.equal(8)
			expect(sd.lossWithinDays).to.equal(30)
			expect(sd.warnMargin).to.equal(15)
			near(prod(sd.p, { vul = 0, ld = 0 }), 0.03)
			near(prod(sd.p, { vul = 100, ld = 100 }), 0.12)
			expect(NpcData.likeability.up.giftMatch).to.equal(8)
			expect(NpcData.likeability.initial).to.equal(50)
			expect(NpcData.likeability.down.greatlyDisappointed).to.equal(-20)
			expect(NpcData.moralInjury.guiltMin).to.equal(15)
			expect(NpcData.moralInjury.guiltMax).to.equal(30)
		end)

		it("§4 relasi, fokus sosial, mentor, SIMCA", function()
			local r = NpcData.relations
			expect(r.dims.a.min).to.equal(-7)
			expect(r.dims.t.max).to.equal(15)
			expect(r.dims.env.max).to.equal(2)
			expect(r.neutral.t).to.equal(4)
			expect(r.fWeights.mission).to.equal(5)
			expect(r.fWeights.survivedWipe).to.equal(10)
			expect(r.tIntegrity).to.equal(-6)
			expect(r.tIntegrityRecoveryMult).to.equal(0.3)
			expect(r.slots).to.equal(8)
			near(lin(r.focus, { X = 0 }), 0.8)
			near(lin(r.focus, { X = 100 }), 0.4)
			expect(NpcData.mentor.skillMultMax).to.equal(10)
			expect(NpcData.groups.factionGrvMin).to.equal(60)
			expect(NpcData.groups.leaderFloorPercentile).to.equal(80)
			near(lin(NpcData.groups.leaderScore, { X = 100, star = 1, level = 1, rReceived = 0 }), 40 + 4.5 + 0.3)
		end)

		it("§5.2 utilitas: 17 aksi (16 utama + makan bersama ringan), bobot & noise", function()
			local u = NpcData.utility
			expect(u.noise).to.equal(8)
			expect(u.weights.food).to.equal(1.2)
			expect(u.weights.rel).to.equal(0.7)
			expect(#u.order).to.equal(17)
			for _, id in u.order do
				local act = u.actions[id]
				expect(act ~= nil).to.equal(true)
			end
			near(lin(u.actions.rest.bias, { C = 0 }), 10) -- (50−C)·0,2
			near(lin(u.actions.provoke.bias, { A = 0, H = 0, X = 0 }), 80)
			near(lin(u.actions.duel.bias, { couEff = 100, A = 0 }), 80)
			near(lin(u.actions.steal.bias, { H = 0 }), 15) -- (30−H)·0,5
		end)

		it("§6 probabilitas event & §6.10 duka", function()
			local c = NpcData.command
			expect(c.base).to.equal(0.02)
			expect(c.max).to.equal(0.6)
			near(lin(c.traitMult, { A = 0 }), 1.3)
			near(lin(c.traitMult, { A = 100 }), 0.7)
			expect(c.compound.sameConcessionRepeat).to.equal(3)
			expect(c.compound.repeatMult).to.equal(0.5)
			expect(c.compound.forcedMinP).to.equal(0.3)
			near(prod(NpcData.duel.pDispute, { couEff = 100, A = 0 }), 0.08)
			near(lin(NpcData.social.befriendP, { X = 0 }), 0.03)
			near(lin(NpcData.social.comfortP, { X = 100, A = 100 }), 0.2)
			expect(NpcData.social.oathP).to.equal(0.05)
			expect(NpcData.theft.caught).to.equal(0.5)
			expect(NpcData.theft.extortRepeatFloorGrv).to.equal(5)
			local g = NpcData.grief
			near(prod(g.intensity, { a = 7, f = 15, E = 40 }), 1)
			near(prod(g.duration, { I = 1, vul = 40 }), 56)
			expect(g.mentionPStart).to.equal(0.3)
			expect(g.mentionPEnd).to.equal(0.05)
			expect(g.lossModePStart).to.equal(0.7)
			expect(g.lossModePEnd).to.equal(0.3)
		end)

		it("§8.2 nilai tersembunyi untuk engine", function()
			local h = NpcData.hidden
			near(lin(h.fearResistance, { couEff = 100, E = 0, vul = 0, st = 0 }), 1)
			near(lin(h.fearResistance, { couEff = 0, E = 100, vul = 100, st = 100 }), -0.05)
			near(lin(h.hesitation, { A = 100 }), 0.3)
			expect(h.hesitationMinA).to.equal(65)
			near(lin(h.compatibility, { a = 7, t = 15 }), 2)
			expect(table.concat(h.stressBandAt, ",")).to.equal("40,70")
		end)
	end)
end
