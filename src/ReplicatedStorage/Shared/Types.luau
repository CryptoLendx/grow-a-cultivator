--!strict
-- Kontrak antarmuka data M1 ↔ M2/M3 (docs/INTERFACE_M1_M2.md = BRIEF_SCRIPTER_M2_M3 §3).
-- Nama field final. Baris bertanda `-- ASUMSI` = nama/struktur tidak disebut eksplisit di §3,
-- dipilih minimal di sini dan WAJIB dikonfirmasi tertulis dengan scripter (RENCANA §3.1).
-- Engine tidak menyentuh penyimpanan dan tidak pernah mengirim `hidden` ke klien.

export type HeroId = string -- ASUMSI: id hero berupa string (kunci map JSON selalu string)
export type PartyId = string -- ASUMSI: id party berupa string

-- Record tampilan hero (VISUAL_2D §5); engine hanya meneruskannya ke snapshot live.
export type Appearance = {
	rig: string, -- id rig (kombinasi kelas × gender) di AppearanceData
	layers: { [string]: string }, -- slot → layerId di AppearanceData
	tints: {
		skin: number, -- ASUMSI: indeks palet tint kulit di AppearanceData
		hair: number, -- ASUMSI: indeks palet tint rambut
		primary: number, -- ASUMSI: indeks palet warna utama pakaian
		secondary: number, -- ASUMSI: indeks palet warna kedua pakaian
		accent: number, -- ASUMSI: indeks palet warna aksen
	},
}

export type EnemySpawn = {
	enemyId: string, -- id baris EnemyData
	level: number, -- level musuh (≈ nomor lantai, DESAIN §3.3)
	count: number, -- jumlah unit musuh ini
	wave: number, -- gelombang ke-berapa unit ini muncul
}

export type MaterialReward = {
	itemId: string, -- ASUMSI: id material
	qty: number, -- ASUMSI: jumlah
}

-- Satu baris TowerData (milik scripter).
export type FloorRow = {
	missionType: string, -- ASUMSI (§3: "tipe"): tipe misi lantai
	objective: string, -- objective awal misi
	enemies: { EnemySpawn }, -- ASUMSI (§3: "daftar EnemySpawn"): semua spawn musuh
	terrainId: string, -- id baris TerrainData
	timerSec: number?, -- batas waktu misi (detik), bila ada
	partyScale: number, -- jumlah party misi: 1 | 2 | 3 | 5
	rewardGold: number, -- gold dasar clear pertama
	rewardMaterials: { MaterialReward }, -- material reward dasar
	objectiveChange: { trigger: string, newObjective: string }?, -- perubahan objective di tengah misi
	subQuest: { [string]: any }?, -- ASUMSI: struktur ditentukan scripter di TowerData
	bonusStage: { [string]: any }?, -- ASUMSI: struktur ditentukan scripter di TowerData
	retryCount: number, -- berapa kali lantai ini sudah diulang (reward turun)
}

export type SkillInput = {
	skillId: string, -- id SkillData
	tier: string, -- Lesser | Intermediate | Advanced
	level: number, -- level skill 1–10
}

export type EquipmentInput = {
	slot: string, -- slot equipment
	grade: string, -- grade kanon (E, E+, D-, …)
}

export type ConsumableInput = {
	itemId: string, -- id consumable
	qty: number, -- jumlah dibawa
}

-- Nilai turunan M0 (DESAIN_AI_NPC §8.2). Hanya server → engine; TIDAK pernah ke klien.
export type HiddenInput = {
	fearResistance: number, -- 0..1
	stressBand: number, -- 0..3
	bondWith: { HeroId }, -- hero yang berflag Bond/Sumpah/mentor dengannya
	enmityWith: { HeroId }, -- hero yang berflag Enmity dengannya
	compatibility: { [HeroId]: number }, -- kompatibilitas ke anggota party sama
}

export type HeroInput = {
	heroId: HeroId, -- id hero
	star: number, -- ★ saat ini
	level: number, -- level hero
	class: string, -- class kanon (Novice, Warrior, …)
	stats: { STR: number, INT: number, STA: number, AGI: number }, -- stat current
	skills: { SkillInput }, -- skill dimiliki
	equipment: { EquipmentInput }, -- gear yang dibawa ke misi
	statusEffects: { string }, -- effectId aktif saat berangkat
	consumables: { ConsumableInput }, -- consumable yang dibawa
	hidden: HiddenInput, -- nilai tersembunyi turunan M0
	appearance: Appearance?, -- diteruskan apa adanya ke snapshot live; headless mengabaikan
}

export type PartyInput = {
	partyId: PartyId, -- id party
	leaderHeroId: HeroId, -- party leader
	heroes: { HeroInput }, -- anggota (≤5)
	role: "advance" | "second" | "reserve", -- peran di misi multi-party
}

export type Point2 = { x: number, y: number } -- koordinat 2D arena

export type Waypoint = {
	partyId: PartyId, -- party yang diberi titik
	point: Point2, -- ASUMSI (§3: "{partyId, {x,y}}"): nama field `point`
}

export type MissionRequest = {
	seed: number, -- wajib; seed + input identik → hasil identik
	floor: FloorRow, -- baris TowerData lantai ini
	parties: { PartyInput }, -- 1–5 party
	tactics: { waypoints: { Waypoint } }?, -- instruksi taktis (Tactical Post)
	tacticalPostLevel: number, -- level Tactical Post master
	battleShopBudget: number, -- gold master yang boleh dipakai battle shop
	cheeringEnabled: boolean, -- cheering boleh dipakai
	mode: "live" | "headless", -- headless melewatkan snapshot/animasi/tween
}

-- Satu baris log misi (rekaman/replay & pesan sistem). Tanpa nilai tersembunyi.
-- ASUMSI: seluruh struktur EventLine — §3 hanya menyebut isinya, bukan field-nya.
export type EventLine = {
	timeSec: number, -- detik sejak misi mulai
	kind: string, -- jenis event (kematian, wipe, perubahan objective, tim susulan, request hero, …)
	stringId: string?, -- id pesan di Data/Strings (pesan verbatim diformat klien)
	args: { [string]: string | number }?, -- nilai placeholder pesan ({name}, {stars}, {party}, …)
	heroId: HeroId?, -- hero yang terlibat, bila ada
}

export type HeroResult = {
	alive: boolean, -- hidup di akhir misi
	deathCause: string?, -- sebab mati, bila mati
	damageDealt: number, -- total damage diberikan
	damageTaken: number, -- total damage diterima
	contribution: number, -- skor kontribusi (dasar exp & MVP)
	statusEffectsEnd: { string }, -- effectId aktif di akhir misi
	consumablesUsed: { [string]: number }, -- itemId → qty dipakai
	equipmentLost: boolean, -- gear hilang (hero mati)
	skillUses: { [string]: number }, -- skillId → jumlah pakai
	awakeningEvents: { string }, -- skillId yang mengalami Skill Awakening
}

export type MissionResult = {
	outcome: "clear" | "wipe", -- hasil misi
	durationSec: number, -- durasi misi (detik)
	objectiveFinal: string, -- objective terakhir yang berlaku
	heroes: { [HeroId]: HeroResult }, -- hasil per hero
	mvpHeroId: HeroId?, -- MVP, bila ada
	expEligibleHeroIds: { HeroId }, -- hanya kontributor
	rewardGold: number, -- dihitung server-side dari FloorRow + retry
	rewardMaterials: { MaterialReward }, -- dihitung server-side
	battleShopSpent: number, -- gold terpakai di battle shop
	subQuestCleared: boolean?, -- sub-quest selesai, bila ada
	bonusStageResult: { [string]: any }?, -- ASUMSI: struktur ditentukan scripter
	log: { EventLine }, -- urutan event terformat
}

return {}
