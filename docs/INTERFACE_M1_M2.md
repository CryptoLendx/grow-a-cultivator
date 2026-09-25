Terakhir diperbarui: 25 September 2026, 20:40 WIB

# INTERFACE M1 ↔ M2/M3 — salinan BRIEF_SCRIPTER_M2_M3 §3 (untuk repo `docs/`)

Sumber: `BRIEF_SCRIPTER_M2_M3.md` §3 di Project Knowledge. Berkas ini hanya salinan; bila berbeda, BRIEF_SCRIPTER yang berlaku. Field baru 25 Sep 2026: `HeroInput.hidden.hesitation`, `MissionResult.heroes[id].panicEvents`, `MissionResult.heroes[id].minHpPct`, `EnemyData.isHumanoid`.

## 3. KONTRAK ANTARMUKA DATA M1 ↔ M2/M3 [dikunci minggu 1, sebelum kode ditulis]
Prinsip: engine **tidak menyentuh penyimpanan** (ProfileStore) dan **tidak pernah mengirim nilai tersembunyi ke klien**. Klien memberi input tabel murni, engine mengembalikan hasil tabel murni; modul klien yang menerapkan hasil ke data hero. Nama field di bawah final; tipe boleh Anda perketat dengan type annotation Luau. Draf tipe Luau lengkap (`Shared/Types.luau`) sudah ada di repo klien; nama/struktur bertanda `-- ASUMSI` di sana adalah usulan klien untuk disepakati di T0. Semua RNG engine lewat `Shared/Rng.luau` klien (xoshiro128** pure Luau berseed); tidak ada `math.random` atau `Random.new` langsung.

**Input `MissionRequest`** (dari klien):
- `seed: number` — wajib; hasil identik untuk seed + input identik.
- `floor: FloorRow` — satu baris dari `TowerData` (tipe, objective, daftar `EnemySpawn {enemyId, level, count, wave}`, `terrainId`, `timerSec?`, `partyScale (1|2|3|5)`, `rewardGold`, `rewardMaterials[]`, `objectiveChange? {trigger, newObjective}`, `subQuest?`, `bonusStage?`, `retryCount`).
- `parties: {PartyInput}` — 1–5 party; `PartyInput {partyId, leaderHeroId, heroes: {HeroInput}, role: "advance"|"second"|"reserve"}`.
- `HeroInput` — `heroId, star, level, class, stats {STR,INT,STA,AGI} (cur), skills: {skillId, tier, level}, equipment: {slot, grade}, statusEffects: {effectId}, consumables: {itemId, qty}, hidden: {fearResistance, stressBand (0..3), bondWith: {heroId}, enmityWith: {heroId}, compatibility: {heroId: number}, hesitation: number (0..1)}, appearance?: Appearance` — `appearance` = record tampilan `{rig, layers: {slot: layerId}, tints: {skin, hair, primary, secondary, accent}}`, **hanya diteruskan apa adanya ke snapshot live** (engine tidak membacanya; headless mengabaikannya).
  - `hesitation` (0..1, TERBUKA): peluang tambahan hero menunda serangan 1 tick sebelum menyerang target yang `EnemyData.isHumanoid = true`; terpisah dari fear/panic; **tidak berlaku** untuk target non-humanoid. Bentuk efek & besarnya dari `CombatConstants` (TERBUKA, dikalibrasi T3).
- `tactics?: {waypoints: {partyId, {x,y}}}` dan `tacticalPostLevel: number`.
- `battleShopBudget: number` (gold master yang boleh dipakai), `cheeringEnabled: boolean`.
- `mode: "live" | "headless"` — headless melewatkan semua snapshot/animasi/tween.

**Output `MissionResult`** (ke klien, setelah misi selesai):
- `outcome: "clear" | "wipe"`, `durationSec`, `objectiveFinal`.
- `heroes: {heroId → {alive: boolean, deathCause?: string, damageDealt, damageTaken, contribution: number, statusEffectsEnd: {effectId}, consumablesUsed: {itemId: qty}, equipmentLost: boolean, skillUses: {skillId: count}, awakeningEvents: {skillId}, panicEvents: {{kind: "fear"|"panic"|"despair", timeSec: number}}, minHpPct: number}}`.
  - `panicEvents`: setiap kali hero **masuk** status fear/panic/despair selama misi (bukan hanya status di akhir misi), urut waktu; kosong bila tidak pernah. Dipakai klien untuk menghitung pengalaman tempur hero (habituasi/sensitisasi, DESAIN_AI_NPC §1.2a/§8.2).
  - `minHpPct`: HP terendah hero selama misi dalam persen 0–100 (dipakai klien untuk menandai "selamat dari situasi kritis", ambang <30 %).
- `mvpHeroId?`, `expEligibleHeroIds` (hanya kontributor), `rewardGold`, `rewardMaterials` (dihitung dari `FloorRow` + retry, **server-side**), `battleShopSpent`, `subQuestCleared?`, `bonusStageResult?`.
- `log: {EventLine}` — urutan event terformat untuk rekaman/replay & pesan sistem verbatim (kematian, wipe, perubahan objective, tim susulan masuk, request hero). Log **tidak** memuat nilai tersembunyi.

**Event runtime** (untuk M8 UI klien, hanya mode live): `MissionStarted {terrainId, units: {UnitState + appearance?}}`, `Tick {units: {UnitState}, damageNumbers: {unitId, amount, crit}, skillCasts: {unitId, skillId}}` (laju tick dari data, default 10/detik), `HeaderUpdated`, `HeroRequest {type, heroId, options}` → balasan `HeroRequestAnswer {yes|no}`, `BattleShopOpened {items}` → `BattleShopBuy {itemId}`, `FieldConfigurationComplete {availableParties}` → `SendReinforcement {partyId}`, `CheeringWindow {durationSec}` → `CheeringInput {intensity}`, `ObjectiveChanged`, `HeroDied`, `MissionEnded {MissionResult}`.

`UnitState {unitId, x, y, facing, anim: "idle"|"walk"|"attack"|"hit"|"death"|"cast", hp%, stamina%, mana%, statusEffects}` (BRIEF_SCRIPTER §2 M2).

**Data modul yang diserahkan scripter** (semua di folder data klien, lihat RENCANA_Build_Hibrida §2): `CombatConstants` (semua konstanta engine), `TowerData` (30 baris), `EnemyData` (stat & perilaku, termasuk `isHumanoid: boolean` per musuh; sprite-nya di `SpriteData` klien), `TerrainData` (grid 2D + titik spawn/exit/objek), `BattleShopData`, `TacticsData`, `CheeringData`. Menambah baris = menambah konten tanpa menyentuh kode.
