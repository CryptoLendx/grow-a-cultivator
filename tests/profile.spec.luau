--!strict
local ServerScriptService = game:GetService("ServerScriptService")
local Profile = require(ServerScriptService.Core.Profile)
local Migrate = require(ServerScriptService.Core.Migrate)

-- Hero dummy mendekati kasus terberat: stat, 8 skill, record tampilan, hero.npc lengkap
-- (DESAIN_AI_NPC §1.6: 8 relasi + 10 memori). Nama field di luar `npc` hanya sementara untuk
-- mengukur byte; skema hero final dibuat di M1 5.3.
local function dummyHero(): { [string]: any }
	local rl = {}
	for i = 1, 8 do
		rl[i] = { id = "h" .. (1000 + i), p = 60000000 + i }
	end
	local mm = {}
	for i = 1, 10 do
		mm[i] = { d = 300 + i, k = 12, o = "h" .. (1000 + i), v = -2 }
	end
	local skills = {}
	for i = 1, 8 do
		skills[i] = { id = "sk" .. i, t = 1, lv = 10 }
	end
	return {
		id = "h1234",
		name = "Mu Qingyun",
		st = 3,
		lv = 40,
		exp = 399,
		cls = "Warrior",
		stat = { 45, 10, 41, 39, 45, 10, 41, 39 },
		sk = skills,
		fav = true,
		pos = "leader",
		fl = 2,
		app = {
			rig = "war_m",
			layers = {
				skin = "s1",
				face = "f12",
				brow = "b3",
				hairB = "hb7",
				hairF = "hf7",
				cloth = "c20",
				weap = "w4",
				aura = "a3",
				acc = "x2",
			},
			tints = { skin = 3, hair = 11, primary = 25, secondary = 7, accent = 14 },
		},
		npc = {
			tr = "32404b2d3c5a28",
			xp = 40,
			gl = { 1, 3 },
			id = { gf = { 4, 9 }, gd = 2, fd = 5, hb = 3, hab = 6, av = 1 },
			nd = "504b3c2d1e",
			st = 23,
			ld = 5,
			gr = { t = "h1001", d = 290, tr = 2 },
			rl = rl,
			mm = mm,
			tg = { 1, 12 },
			ls = 365,
		},
	}
end

return function()
	describe("Core/Profile", function()
		it("key terpecah: core/heroes_N/archive_N/replays/mail, semua ≤50 karakter", function()
			local uid = 9999999999
			expect(Profile.keyFor("core", uid)).to.equal("u9999999999_core")
			expect(Profile.keyFor("heroes", uid, 3)).to.equal("u9999999999_heroes_3")
			expect(Profile.keyFor("archive", uid, 1)).to.equal("u9999999999_archive_1")
			expect(Profile.keyFor("replays", uid)).to.equal("u9999999999_replays")
			expect(Profile.keyFor("mail", uid)).to.equal("u9999999999_mail")
			expect(#Profile.keyFor("heroes", uid, 999) <= 50).to.equal(true)
			expect(function()
				Profile.keyFor("heroes", uid)
			end).to.throw("shard")
			expect(function()
				Profile.keyFor("inventory" :: any, uid)
			end).to.throw("jenis key")
		end)

		it("template tiap jenis key punya schemaVersion terkini", function()
			for _, kind: Profile.Kind in Profile.KINDS do
				local t = Profile.template(kind)
				expect(t.schemaVersion).to.equal(Migrate.current(kind))
			end
			-- template adalah salinan baru, bukan tabel bersama
			expect(Profile.template("core")).never.to.equal(Profile.template("core"))
		end)

		it("shard hero: isi shard pertama yang belum penuh (≤1.000/key), lalu buat shard baru", function()
			expect(Profile.shardForNewHero({})).to.equal(1)
			expect(Profile.shardForNewHero({ 999 })).to.equal(1)
			expect(Profile.shardForNewHero({ 1000 })).to.equal(2)
			expect(Profile.shardForNewHero({ 1000, 1000, 5 })).to.equal(3)
			expect(Profile.shardForNewHero({ 1000, 400 })).to.equal(2)
			expect(Profile.shardForNewArchive({ 1999 })).to.equal(1)
			expect(Profile.shardForNewArchive({ 2000 })).to.equal(2)
		end)

		it("JSONEncode hero dummy ≤ 900 byte (layout cadangan DESAIN_AI_NPC §1.6: rl+mm di social_N)", function()
			local hero = dummyHero()
			local full = Profile.heroBytes(hero)
			hero.npc.rl = nil
			hero.npc.mm = nil
			local lean = Profile.heroBytes(hero)
			-- Data untuk keputusan M1 5.3 (DESAIN_AI_NPC §10.2 #2); npc lengkap tidak di-assert di sini.
			print(string.format("         hero dummy: npc lengkap = %d byte; tanpa rl+mm = %d byte", full, lean))
			expect(Profile.MAX_HERO_BYTES).to.equal(900)
			expect(lean <= Profile.MAX_HERO_BYTES).to.equal(true)
		end)
	end)

	describe("Core/Migrate", function()
		it("profil core v1 → v2 tanpa kehilangan field", function()
			local v1 = {
				schemaVersion = 1,
				gold = 123456,
				gems = 500,
				heroShards = 2,
				archiveShards = 1,
				nested = { a = 1, b = { 2, 3 } },
			}
			local migrated, applied = Migrate.run("core", v1)
			expect(applied).to.equal(1)
			expect(migrated.schemaVersion).to.equal(2)
			expect(migrated.lastSeen).to.equal(0)
			expect(migrated.gold).to.equal(123456)
			expect(migrated.gems).to.equal(500)
			expect(migrated.heroShards).to.equal(2)
			expect(migrated.archiveShards).to.equal(1)
			expect(migrated.nested.a).to.equal(1)
			expect(migrated.nested.b[2]).to.equal(3)
		end)

		it("data yang sudah terkini tidak diubah; versi lebih baru dari kode ditolak", function()
			local current = Profile.template("core")
			current.gold = 7
			local same, applied = Migrate.run("core", current)
			expect(applied).to.equal(0)
			expect(same.gold).to.equal(7)
			expect(function()
				Migrate.run("core", { schemaVersion = 99 })
			end).to.throw("lebih baru")
		end)

		it("data tanpa schemaVersion dianggap v1", function()
			local migrated = Migrate.run("core", { gold = 1 })
			expect(migrated.schemaVersion).to.equal(Migrate.current("core"))
			expect(migrated.gold).to.equal(1)
		end)
	end)
end
