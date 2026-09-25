## 3. KONTRAK ANTARMUKA DATA M1 ↔ M2/M3 [dikunci minggu 1, sebelum kode ditulis]
Prinsip: engine **tidak menyentuh penyimpanan** (ProfileService) dan **tidak pernah mengirim nilai tersembunyi ke klien**. Klien memberi input tabel murni, engine mengembalikan hasil tabel murni; modul klien yang menerapkan hasil ke data hero. Nama field di bawah final; tipe boleh Anda perketat dengan type annotation Luau.

**Input `MissionRequest`** (dari klien):
- `seed: number` — wajib; hasil identik untuk seed + input identik.
- `floor: FloorRow` — satu baris dari `TowerData` (tipe, objective, daftar `EnemySpawn {enemyId, level, count, wave}`, `terrainId`, `timerSec?`, `partyScale (1|2|3|5)`, `rewardGold`, `rewardMaterials[]`, `objectiveChange? {trigger, newObjective}`, `subQuest?`, `bonusStage?`, `retryCount`).
- `parties: {PartyInput}` — 1–5 party; `PartyInput {partyId, leaderHeroId, heroes: {HeroInput}, role: "advance"|"second"|"reserve"}`.
- `HeroInput` — `heroId, star, level, class, stats {STR,INT,STA,AGI} (cur), skills: {skillId, tier, level}, equipment: {slot, grade}, statusEffects: {effectId}, consumables: {itemId, qty}, hidden: {fearResistance, stressBand (0..3), bondWith: {heroId}, enmityWith: {heroId}, compatibility: {heroId: number}}, appearance?: Appearance` — `appearance` = record tampilan `{rig, layers: {slot: layerId}, tints: {skin, hair, primary, secondary, accent}}`, **hanya diteruskan apa adanya ke snapshot live** (engine tidak membacanya; headless mengabaikannya).
- `tactics?: {waypoints: {partyId, {x,y}}}` dan `tacticalPostLevel: number`.
- `battleShopBudget: number` (gold master yang boleh dipakai), `cheeringEnabled: boolean`.
- `mode: "live" | "headless"` — headless melewatkan semua snapshot/animasi/tween.

**Output `MissionResult`** (ke klien, setelah misi selesai):
- `outcome: "clear" | "wipe"`, `durationSec`, `objectiveFinal`.
- `heroes: {heroId → {alive: boolean, deathCause?: string, damageDealt, damageTaken, contribution: number, statusEffectsEnd: {effectId}, consumablesUsed: {itemId: qty}, equipmentLost: boolean, skillUses: {skillId: count}, awakeningEvents: {skillId}}}`.
- `mvpHeroId?`, `expEligibleHeroIds` (hanya kontributor), `rewardGold`, `rewardMaterials` (dihitung dari `FloorRow` + retry, **server-side**), `battleShopSpent`, `subQuestCleared?`, `bonusStageResult?`.
- `log: {EventLine}` — urutan event terformat untuk rekaman/replay & pesan sistem verbatim (kematian, wipe, perubahan objective, tim susulan masuk, request hero). Log **tidak** memuat nilai tersembunyi.

**Event runtime** (untuk M8 UI klien, hanya mode live): `MissionStarted {terrainId, units: {UnitState + appearance?}}`, `Tick {units: {UnitState}, damageNumbers: {unitId, amount, crit}, skillCasts: {unitId, skillId}}` (laju tick dari data, default 10/detik), `HeaderUpdated`, `HeroRequest {type, heroId, options}` → balasan `HeroRequestAnswer {yes|no}`, `BattleShopOpened {items}` → `BattleShopBuy {itemId}`, `FieldConfigurationComplete {availableParties}` → `SendReinforcement {partyId}`, `CheeringWindow {durationSec}` → `CheeringInput {intensity}`, `ObjectiveChanged`, `HeroDied`, `MissionEnded {MissionResult}`.

**Data modul yang Anda buat & serahkan** (semua di folder data klien, lihat RENCANA_Build_Hibrida §2): `CombatConstants` (semua konstanta engine), `TowerData` (30 baris), `EnemyData` (stat & perilaku; sprite-nya di `SpriteData` klien), `TerrainData` (grid 2D + titik spawn/exit/objek), `BattleShopData`, `TacticsData`, `CheeringData`. Menambah baris = menambah konten tanpa menyentuh kode.
