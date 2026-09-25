--!strict
-- M0 katalog tujuan pribadi (DESAIN_AI_NPC_V0 §1.3) & idiosinkrasi (§1.4). Tabel murni, tanpa logika.
-- Semua angka (TERBUKA) — dikalibrasi §9; label [K]/[N]/[INF] = dasar kanon item katalog.
-- `Linear` = k + Σ koef·sifat (sifat 0–100); ★ TIDAK pernah menjadi variabel (prinsip populasi §0).
-- FORMAT SIMPAN: hero.npc menyimpan INDEKS ke daftar di bawah (goals.order, foods, hobbies, habits, aversions;
-- Autonomy/Traits.encode) → item baru hanya boleh ditambah di AKHIR daftar; jangan mengurutkan ulang/menghapus tanpa migrasi.

export type Linear = { [string]: number }
export type Count = { min: number, max: number }
export type Aversion = {
	id: string, -- id pendek (disimpan di hero.npc.id.av)
	targets: { string }, -- ASUMSI: tag TerrainData/tipe misi/EnemyData yang memicu (id final menunggu data scripter)
}
export type IdioConfig = {
	goals: {
		order: { string },
		weights: { [string]: Linear },
		secondChance: number,
	},
	counts: { [string]: Count },
	giftSource: string,
	foods: { string },
	hobbies: { string },
	habits: { string },
	aversions: { Aversion },
}

local IdioData: IdioConfig = {
	-- §1.3 tujuan pribadi: 1 goal + goal kedua dengan peluang `secondChance`; bobot roll ∝ Linear sifat.
	goals = {
		order = { "strongest", "protect", "recognized", "calm", "prove", "serve" },
		weights = {
			strongest = { k = 50, C = 1, A = -0.5 }, -- TERBUKA: C + (100−A)/2 — menjadi terkuat
			protect = { k = 0, A = 1, X = 0.5 }, -- TERBUKA: A + X/2 — melindungi rekan
			recognized = { k = 100, H = -1, X = 0.5 }, -- TERBUKA: (100−H) + X/2 — diakui / naik lantai
			calm = { k = 100, C = -1, E = 0.5 }, -- TERBUKA: (100−C) + E/2 — hidup tenang / pulang
			prove = { k = 100, A = -1, E = 0.5 }, -- TERBUKA: (100−A) + E/2 — membalas / membuktikan diri
			serve = { k = 0, H = 1, A = 0.5 }, -- TERBUKA: H + A/2 — mengabdi (pada master/leader)
		},
		secondChance = 0.4, -- TERBUKA: goal kedua di-roll 40 %
	},

	-- §1.4 jumlah item per kategori (id = {gf={..}, gd, fd={fav,hated}, hb, hab, av?}, §1.6); kategori tetap (LAPORAN 2026-09-25 Q1).
	counts = {
		giftFav = { min = 1, max = 2 }, -- TERBUKA: gift favorit ×1–2 [K] ch.51
		giftHated = { min = 1, max = 1 }, -- TERBUKA: gift dibenci ×1 [K] ch.107, 135
		foodFav = { min = 1, max = 1 }, -- TERBUKA: makanan favorit ×1 [K] ch.64
		foodHated = { min = 1, max = 1 }, -- TERBUKA: makanan dibenci ×1 [K] ch.16 (fd = {fav, hated}, Q2)
		hobby = { min = 1, max = 1 }, -- TERBUKA: hobi ×1
		habit = { min = 1, max = 1 }, -- TERBUKA: kebiasaan ×1 [INF]
		aversion = { min = 0, max = 1 }, -- TERBUKA: keengganan ×0–1
	},
	giftSource = "GiftData", -- gift favorit/dibenci di-roll dari katalog GiftData (M1 5.1)

	-- Makanan: hanya yang disebut kanon "[Possible food types: meat, potato, fruit....]" [K] ch.64; sisanya dari data Restaurant (TERBUKA).
	foods = { "meat", "potato", "fruit" },

	-- Hobi ×1 (§1.4): koleksi · membaca · memasak · berkebun · permainan papan · musik · menulis diary · merawat senjata.
	-- Dasar kanon yang disebut §1.4: [N] ch.273, 134, 369, 358, 284, 166 (6 sitasi untuk 8 hobi; pemetaan per item tidak dirinci).
	hobbies = { "collect", "read", "cook", "garden", "boardGames", "music", "diary", "weaponCare" },

	-- Kebiasaan ×1 [INF] (§1.4): bangun paling awal · makan sendiri · duduk di tempat yang sama di plaza ·
	-- memeriksa gerbang tiap malam · berdoa sebelum misi · menyapa peri.
	habits = { "wakeEarliest", "eatAlone", "samePlazaSpot", "checkGateNightly", "prayBeforeMission", "greetFairy" },

	-- Keengganan ×0–1 (§1.4), dipetakan ke TerrainData/tipe misi/EnemyData.
	aversions = {
		{ id = "labyrinth", targets = { "labyrinth" } }, -- [N] ch.78 tidak suka labirin
		{ id = "water", targets = { "water" } }, -- [N] ch.139 takut air
		{ id = "humanoid", targets = { "isHumanoid" } }, -- [N] ch.57 tidak mau melawan manusia (EnemyData.isHumanoid)
		{ id = "heat", targets = { "desert" } }, -- [N] ch.108 tidak tahan panas (gurun)
	},
}

return IdioData
