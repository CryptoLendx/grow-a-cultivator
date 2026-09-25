--!strict
-- Mental/Experience (tugas §B 2.3): pengalaman tempur `xp` & nyali efektif `cou_eff` — DESAIN_AI_NPC_V0 §1.2a.
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)
local Experience = require(ServerScriptService.Mental.Experience)

local XP = NpcData.xp
local SAFE: Experience.Outcome = { survived = true, episode = false, critical = false, comradeDiedBeside = false }
local PANIC: Experience.Outcome = { survived = true, episode = true, critical = false, comradeDiedBeside = false }

local function ctx(cou: number, e: number?): Experience.Ctx
	return { heroId = "h1", cou = cou, E = e or 50 }
end

-- n misi selamat tanpa panic, tiap misi diikuti 3 hari pemulihan (st 20).
local function missions(x: Experience.Exp, c: Experience.Ctx, n: number, o: Experience.Outcome?): Experience.Exp
	for _ = 1, n do
		x = Experience.onMission(x, c, o or SAFE)
		for _ = 1, 3 do
			x = Experience.endDay(x, c, 20)
		end
	end
	return x
end

-- Satu episode panic lalu `days` hari dengan st tertentu.
local function episode(c: Experience.Ctx, st: number, o: Experience.Outcome?): (Experience.Exp, { any })
	local x = Experience.onMission(Experience.seed(2), c, o or PANIC)
	local all = {}
	for day = 0, XP.recoveryDays do
		local ev
		x, ev = Experience.endDay(x, c, if day == 0 then 90 else st) -- hari episode sendiri tidak dihitung
		table.move(ev, 1, #ev, #all + 1, all)
	end
	return x, all
end

return function()
	describe("Mental/Experience", function()
		it("seed xp 0 / 15 / 40 untuk 1★ / 2★ / 3★+", function()
			expect(Experience.seed(1).xp).to.equal(0)
			expect(Experience.seed(2).xp).to.equal(15)
			expect(Experience.seed(3).xp).to.equal(40)
			expect(Experience.seed(7).xp).to.equal(40)
		end)

		it(
			"cou_eff = clamp(cou + 0,3·xp − 0,2·ld, 0, 100); 1★ segar vs 3★ segar (cou sama) → 3★ lebih tinggi di hari 1",
			function()
				expect(Experience.couEff(50, 40, 0)).to.be.near(62, 1e-9)
				expect(Experience.couEff(50, 0, 50)).to.be.near(40, 1e-9)
				expect(Experience.couEff(95, 100, 0)).to.equal(100)
				expect(Experience.couEff(5, 0, 100)).to.equal(0)
				for _, cou in { 10, 50, 88 } do -- cou ≤ 88: 3★ segar belum terpotong clamp 100
					local e1 = Experience.couEff(cou, Experience.seed(1).xp, 0)
					local e3 = Experience.couEff(cou, Experience.seed(3).xp, 0)
					expect(e3 - e1).to.be.near(12, 1e-9)
				end
			end
		)

		it(
			"habituasi +2 per misi selamat tanpa panic, +4 bila kritis; plafon 40 + 0,6·cou tidak pernah dilewati",
			function()
				local c = ctx(50)
				local x = Experience.onMission(Experience.seed(1), c, SAFE)
				expect(x.xp).to.equal(2)
				x = Experience.onMission(
					x,
					c,
					{ survived = true, episode = false, critical = true, comradeDiedBeside = false }
				)
				expect(x.xp).to.equal(6)
				expect(Experience.cap(50)).to.equal(70)
				expect(Experience.cap(0)).to.equal(40)
				for _, cou in { 0, 30, 50, 100 } do
					local cc = ctx(cou)
					local y = Experience.seed(1)
					for _ = 1, 200 do
						y = Experience.onMission(y, cc, SAFE)
						expect(y.xp <= Experience.cap(cou) + 1e-9).to.equal(true)
					end
					expect(y.xp).to.be.near(Experience.cap(cou), 1e-9)
				end
				-- langkah ×1,5 (E ≥ 65) tidak boleh melewati plafon (69 + 3 → 70, bukan 72)
				local z = { xp = 69, pend = {} }
				z = Experience.onMission(z, ctx(50, 80), SAFE)
				expect(z.xp).to.equal(70)
				-- mati → tidak ada perubahan; fear saja bukan episode (NpcData.xp.fearCountsAsEpisode)
				expect(
					Experience.onMission(
						Experience.seed(1),
						c,
						{ survived = false, episode = false, critical = true, comradeDiedBeside = false }
					).xp
				).to.equal(0)
			end
		)

		it(
			"1★ setelah 10–15 misi selamat tanpa panic → xp naik menuju plafon; cou_eff mendekati 3★ segar",
			function()
				for _, cou in { 20, 50, 80 } do
					local c = ctx(cou)
					local fresh3 = Experience.couEff(cou, Experience.seed(3).xp, 0)
					local x10 = missions(Experience.seed(1), c, 10)
					local x15 = missions(Experience.seed(1), c, 15)
					expect(x10.xp).to.equal(20)
					expect(x15.xp).to.equal(30)
					local gap0 = fresh3 - Experience.couEff(cou, 0, 0)
					local gap15 = fresh3 - Experience.couEff(cou, x15.xp, 0)
					expect(gap15 <= 3 + 1e-9).to.equal(true) -- ≥75 % selisih awal (12) tertutup
					expect(gap15 < gap0).to.equal(true)
				end
			end
		)

		it(
			"sensitisasi: panic tanpa 3 hari pemulihan (st ≥ 60) → xp −3; rekan mati di sisi → −6; dengan pemulihan → tetap",
			function()
				local c = ctx(50)
				local xs, ev = episode(c, 65)
				expect(xs.xp).to.equal(15 - 3)
				expect(#ev).to.equal(1)
				expect(ev[1].kind).to.equal("xpSensitized")
				local xd =
					episode(c, 65, { survived = true, episode = true, critical = true, comradeDiedBeside = true })
				expect(xd.xp).to.equal(15 - 6)
				local xr, evr = episode(c, 45)
				expect(xr.xp).to.equal(15)
				expect(#evr).to.equal(0)
				expect(#xr.pend).to.equal(0)
				-- 2 dari 3 hari pulih belum cukup
				local x = Experience.onMission(Experience.seed(2), c, PANIC)
				for _, st in { 90, 40, 40, 55 } do
					x = Experience.endDay(x, c, st)
				end
				expect(x.xp).to.equal(12)
				-- hari episode sendiri tidak dihitung pulih meski st-nya rendah
				local y = Experience.onMission(Experience.seed(2), c, PANIC)
				for _, st in { 20, 40, 40, 55 } do
					y = Experience.endDay(y, c, st)
				end
				expect(y.xp).to.equal(12)
				-- xp tidak pernah < 0
				local z = Experience.onMission(Experience.seed(1), c, PANIC)
				for _ = 0, XP.recoveryDays do
					z = Experience.endDay(z, c, 80)
				end
				expect(z.xp).to.equal(0)
			end
		)

		it("differential susceptibility: E ≥ 65 ×1,5 pada kedua arah (input identik)", function()
			local lo, hi = ctx(50, 64), ctx(50, 65)
			expect(Experience.onMission(Experience.seed(1), lo, SAFE).xp).to.equal(2)
			expect(Experience.onMission(Experience.seed(1), hi, SAFE).xp).to.equal(3)
			expect(episode(lo, 65).xp).to.equal(15 - 3)
			expect(episode(hi, 65).xp).to.equal(15 - 4.5)
			expect(missions(Experience.seed(1), hi, 10).xp).to.equal(30)
		end)

		it(
			"outcome() dari HeroResult: panic/despair = episode, fear tidak; kritis = minHpPct < 30 atau rekan party mati",
			function()
				local function hr(kinds: { string }, minHp: number, alive: boolean?): any
					local pe = {}
					for i, k in kinds do
						pe[i] = { kind = k, timeSec = i }
					end
					return { alive = alive ~= false, panicEvents = pe, minHpPct = minHp }
				end
				local o = Experience.outcome(hr({ "fear" }, 80), false, false)
				expect(o.episode).to.equal(false)
				expect(o.critical).to.equal(false)
				expect(Experience.outcome(hr({ "fear", "panic" }, 80), false, false).episode).to.equal(true)
				expect(Experience.outcome(hr({ "despair" }, 80), false, false).episode).to.equal(true)
				expect(Experience.outcome(hr({}, 29), false, false).critical).to.equal(true)
				expect(Experience.outcome(hr({}, 30), false, false).critical).to.equal(false)
				expect(Experience.outcome(hr({}, 90), true, false).critical).to.equal(true)
				expect(Experience.outcome(hr({}, 0, false), false, false).survived).to.equal(false)
				local b = Experience.outcome(hr({ "panic" }, 50), true, true)
				expect(b.comradeDiedBeside).to.equal(true)
			end
		)

		it(
			"3★ yang dipaksa beruntun tanpa pemulihan bisa jatuh di bawah 1★ yang dirawat (§1.2a, emergen)",
			function()
				local c = ctx(50)
				local forced = Experience.seed(3)
				for _ = 1, 12 do
					forced = Experience.onMission(forced, c, PANIC)
					forced = Experience.endDay(forced, c, 80)
				end
				for _ = 1, XP.recoveryDays do
					forced = Experience.endDay(forced, c, 80)
				end
				local cared = missions(Experience.seed(1), c, 12)
				expect(forced.xp < cared.xp).to.equal(true)
				expect(Experience.couEff(50, forced.xp, 20) < Experience.couEff(50, cared.xp, 0)).to.equal(true)
			end
		)

		it("fungsi murni: input tidak dimutasi", function()
			local c = ctx(50)
			local x = Experience.onMission(Experience.seed(2), c, PANIC)
			local n = #x.pend
			local xp = x.xp
			Experience.endDay(x, c, 80)
			Experience.onMission(x, c, SAFE)
			expect(#x.pend).to.equal(n)
			expect(x.xp).to.equal(xp)
			expect(x.pend[1].age).to.equal(0)
		end)
	end)
end
