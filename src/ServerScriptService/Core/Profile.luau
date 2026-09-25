--!strict
-- Profil pemain terpecah per key (RISET_Batas_Teknis §4.1, RENCANA §3.3):
--   u<userId>_core · u<userId>_heroes_<N> (≤1.000 hero hidup) · u<userId>_archive_<N> (≤2.000 hero mati)
--   · u<userId>_replays (seed + MissionRequest) · u<userId>_mail
-- Tiap key = satu profil ProfileStore (session lock sendiri) dengan `schemaVersion` (Core/Migrate).
-- Batas di bawah adalah aturan arsitektur [FINAL], bukan angka tuning.

local HttpService = game:GetService("HttpService")
local ServerScriptService = game:GetService("ServerScriptService")

local Migrate = require(script.Parent.Migrate)

export type Kind = Migrate.Kind
export type Data = Migrate.Data

local Profile = {}

local KINDS: { Kind } = { "core", "heroes", "archive", "replays", "mail" }
Profile.KINDS = KINDS
Profile.STORE_NAME = "PlayerData"
Profile.MAX_HERO_BYTES = 900 -- JSONEncode(hero) termasuk hero.npc (RENCANA §3.3)
Profile.MAX_HEROES_PER_KEY = 1000 -- hero hidup per key heroes_N (RISET_Batas_Teknis §4.1)
Profile.MAX_ARCHIVE_PER_KEY = 2000 -- hero mati per key archive_N (RISET_Batas_Teknis §4.1)

local SHARDED: { [Kind]: boolean } = { core = false, heroes = true, archive = true, replays = false, mail = false }

local TEMPLATES: { [Kind]: () -> Data } = {
	core = function()
		return { heroShards = 1, archiveShards = 0, lastSeen = 0 }
	end,
	heroes = function()
		return { heroes = {} } -- heroId → hero
	end,
	archive = function()
		return { heroes = {} } -- heroId → ringkasan hero mati
	end,
	replays = function()
		return { entries = {} } -- seed + MissionRequest, bukan log
	end,
	mail = function()
		return { messages = {} }
	end,
}

-- Nama key DataStore untuk satu jenis profil; `shard` wajib untuk heroes/archive (mulai 1).
function Profile.keyFor(kind: Kind, userId: number, shard: number?): string
	local sharded = SHARDED[kind]
	if sharded == nil then
		error("Profile: jenis key tidak dikenal " .. tostring(kind), 2)
	end
	if sharded then
		if shard == nil or shard < 1 or shard ~= math.floor(shard) then
			error("Profile: " .. kind .. " butuh nomor shard ≥1", 2)
		end
		return string.format("u%d_%s_%d", userId, kind, shard)
	end
	return string.format("u%d_%s", userId, kind)
end

-- Data awal (salinan baru) untuk key baru, sudah di versi skema terkini.
function Profile.template(kind: Kind): Data
	local data = TEMPLATES[kind]()
	data.schemaVersion = Migrate.current(kind)
	return data
end

-- Ukuran JSON satu hero (byte), diukur seperti DataStore mengukurnya.
function Profile.heroBytes(hero: Data): number
	return #HttpService:JSONEncode(hero)
end

local function firstShardWithRoom(counts: { number }, limit: number): number
	for i, count in counts do
		if count < limit then
			return i
		end
	end
	return #counts + 1
end

-- Shard heroes_N untuk hero baru; `counts[i]` = jumlah hero di heroes_i.
function Profile.shardForNewHero(counts: { number }): number
	return firstShardWithRoom(counts, Profile.MAX_HEROES_PER_KEY)
end

-- Shard archive_N untuk hero yang baru mati.
function Profile.shardForNewArchive(counts: { number }): number
	return firstShardWithRoom(counts, Profile.MAX_ARCHIVE_PER_KEY)
end

local store: any = nil

-- ProfileStore dimuat saat pertama dipakai agar modul ini tetap bisa diuji headless.
local function getStore(): any
	if store == nil then
		local packages = ServerScriptService:WaitForChild("ServerPackages")
		local ProfileStore = require(packages:WaitForChild("ProfileStore") :: ModuleScript) :: any
		store = ProfileStore.New(Profile.STORE_NAME)
	end
	return store
end

-- Membuka satu key dengan session lock; mengisi template bila baru, lalu migrasi skema.
-- Mengembalikan profil ProfileStore (data di `.Data`) atau nil bila gagal/dibatalkan.
-- BELUM diuji di Studio (ProfileStore tidak bisa dipasang di sesi pembuatan); uji kill-server = tugas 5.4.
function Profile.open(kind: Kind, userId: number, shard: number?, cancel: (() -> boolean)?): any
	local profile = getStore():StartSessionAsync(Profile.keyFor(kind, userId, shard), { Cancel = cancel })
	if profile == nil then
		return nil
	end
	profile:AddUserId(userId)
	if next(profile.Data) == nil then
		for key, value in Profile.template(kind) do
			profile.Data[key] = value
		end
	end
	Migrate.run(kind, profile.Data)
	return profile
end

return Profile
