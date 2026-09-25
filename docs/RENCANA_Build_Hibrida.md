# RENCANA BUILD HIBRIDA (RUTE C+) — pekerjaan pemilik dengan AI, paralel dengan scripter M2+M3 & artist 2D M9

Terakhir diperbarui: 25 September 2026, 01:24 WIB

Alokasi pemilik: **12 jam/minggu**. Jam pemilik total 340–490 (KALIBRASI §5 C+) → **28–41 minggu**; jadwal di §4 memakai titik tengah (faktor AI 0,6 × buffer 1,15 ≈ 0,69 dari jam scripting+UI KALIBRASI §1) dan berakhir minggu 39 (selisih ±10 jam penyaji 2D diserap buffer minggu 38–39). [TERBUKA] opsi mempercepat: KONSEP §8 (a) ≥18 jam/minggu, (b) M8 UI diserahkan, (c) terima jadwal ini. Arah visual: 2D landscape tampak 3/4 isometrik, sprite & potret berlapis (RISET_Game_Referensi_HUD §4–§5, FINAL). Tahap 0 (minggu 1–6, sampai 5 Nov 2026) dikerjakan dengan Claude Code menurut CLAUDE_CODE_Brief_Tahap0 §B; tabel §4 di bawah adalah rencana penuh 39 minggu.

## 1. TOOLING
- **Rojo** (sinkron file ↔ Studio) + **Git/GitHub** (repo privat; scripter bekerja lewat branch/PR) + **Claude Code / Cursor** untuk menulis Luau + **Selene/StyLua** (lint/format) + **TestEZ** untuk unit test modul data + **run-in-roblox** (opsional) untuk menjalankan simulasi headless dari CLI.
- **ProfileService** (atau ProfileStore) untuk save; **Wally** untuk dependensi.
- Satu place `.rbxl` di grup Roblox pemilik; aset (spritesheet PNG) masuk lewat Asset Manager ke grup (bukan akun pribadi vendor); ID aset dicatat di `AppearanceData`/`SpriteData`.
- **Aseprite** (atau Krita) untuk membuka/memeriksa file sumber artist; skrip kecil (Python/Node) untuk membaca `sheet.json` → menghasilkan tabel Luau ID aset + offset frame.

## 2. STRUKTUR REPO ROJO
```
raise-a-cultivator/
  default.project.json          # peta folder → DataModel
  wally.toml                    # ProfileService, TestEZ, dst.
  selene.toml · stylua.toml
  CLAUDE.md                     # isi: CLAUDE_CODE_Brief_Tahap0 §A
  src/
    ReplicatedStorage/
      Data/                     # SATU folder ModuleScript data tuning — hanya tabel, tanpa logika
        CombatConstants.luau    # (scripter) semua konstanta engine
        TowerData.luau          # (scripter) 30 baris FloorRow
        EnemyData.luau · TerrainData.luau · BattleShopData.luau · TacticsData.luau · CheeringData.luau   # (scripter)
        SummonData.luau         # odds, harga, label grade, tiket
        HeroData.luau           # cap level, exp 10×Lv, growth band, status effect %, generator nama
        AppearanceData.luau     # katalog lapisan potret/sprite hero per slot (layerId → asset id, frame), palet tint, rig; dihasilkan dari sheet.json artist
        SpriteData.luau         # spritesheet musuh/boss/NPC/bangunan/VFX: asset id, ukuran frame, urutan animasi, jangkar
        SkillData.luau          # katalog 26 skill kanon, tier, evolusi, laju latihan
        FacilityData.luau       # tabel fasilitas berlevel, annex, merge, kapasitas, footprint tile & sprite per level
        ResearchData.luau · JobData.luau
        ItemData.luau · RecipeData.luau · EquipmentData.luau · GiftData.luau
        NpcData.luau            # M0: semua koefisien DESAIN_AI_NPC_V0 (sifat, kebutuhan, stres/vul/ld, relasi, SIMCA, utilitas, event, duka) — tiap baris `-- TERBUKA`
        IdioData.luau           # M0: katalog idiosinkrasi (hobi, makanan, kebiasaan, keengganan) & tujuan pribadi
        MentalData.luau         # (digabung ke NpcData bila tumpang tindih) likeability, mogok, gift
        DungeonData.luau        # daily 3 lokasi, exploration, dowry, loot
        MonetizationData.luau   # 6 gamepass id, dev product id, paket gems/gold
        Strings.luau            # SEMUA pesan sistem verbatim (EN); string non-kanon berkomentar -- NONKANON
      Shared/                   # tipe Luau (HeroInput, MissionRequest, MissionResult, Appearance), util RNG berseed (Rng.luau)
      Remotes/                  # RemoteEvent/Function; klien tidak pernah menghitung reward
    ServerScriptService/
      Core/                     # bootstrap, ProfileService (key terpecah), loader data, migrasi schemaVersion
      Combat/                   # (scripter) M2 engine — pure Luau, tanpa Instance saat mode headless; posisi unit = koordinat 2D
      Tower/                    # (scripter) M3 loader, multi-party, tactics, shop, cheering
      Summon/ Hero/             # M1 (roll sifat/tujuan/idiosinkrasi via Autonomy/Traits + record tampilan {rig, layerId, tint×5} saat summon)
      Autonomy/                 # M0: Traits, Needs, Roles, Utility, Actions, Events, TickDay, CatchUp, Output
      Social/                   # M0: Relations (6 dimensi berarah), Groups (tag, grievance, klik, faksi SIMCA), Mentor, Memory, Grief
      Mental/                   # M0/M7: Stress (vul/st/ld), MoralInjury, SuddenDeath, likeability, gift, hukuman
      Dungeon/                  # M4 (daily/exploration; memanggil Combat via MissionRequest)
      Facility/ Research/ Org/ Party/ Duel/   # M5
      Promotion/ Synthesis/ Item/ Craft/ Skill/  # M6
      Education/ Archive/                       # M7 (Archive = memorial + kartu memorial dari Social/Grief)
      Monetization/ AntiExploit/                # M10
    StarterPlayer/StarterPlayerScripts/
      UI/                       # M8 — framework state-binding, satu controller per layar
      Render/                   # M8 — penyaji 2D: LayeredSprite (ImageLabel bertumpuk + ImageColor3 tint + ImageRectOffset animasi), IsoMap (peta 3/4 geser/zoom; satu cakram bundar berzona per lantai — referensi manhwa), Arena (unit sprite dari event runtime M2)
      Onboarding/
    StarterGui/                 # ScreenGui kosong; layar & peta dibangun kode
  sim/                          # harness simulasi headless: combat (scripter) + npc_sim (M0) → CSV
  tests/                        # TestEZ: roll 10.000 summon, 100 sintesis item, catch-up offline, migrasi skema, rakit 1.000 appearance, npc.spec (24 metrik DESAIN_AI_NPC §9)
  assets/                       # sumber .aseprite/.psd + sheet.json + DAFTAR_ASET_LISENSI.csv (M9)
  docs/                         # salinan berkas Project (CLAUDE_CODE_Brief_Tahap0 §C) + STATUS.md + npc_calibration.md + "cara menambah lantai/musuh/fasilitas/skill/lapisan sprite"
```
Aturan: (1) tidak ada angka tuning di luar `Data/`; (2) nilai tersembunyi hero (sifat, kebutuhan, stres, relasi, memori) tidak pernah lewat Remotes; (3) semua RNG memakai util berseed di `Shared/` supaya simulasi & uji reproducible; (4) scripter hanya menyentuh `Combat/`, `Tower/`, `sim/combat_*`, dan file data miliknya; (5) tidak ada gambar hero gabungan disimpan — hanya record tampilan (±40 byte) di profil; (6) simulasi NPC (`Autonomy/`, `Social/`, `Mental/`) = fungsi murni tanpa Instance, dapat dijalankan headless.

## 3. HAL YANG DIKUNCI DI MINGGU 1 (sebelum scripter menulis kode)
1. **Kontrak antarmuka M1↔M2** = BRIEF_SCRIPTER_M2_M3 §3, ditulis sebagai tipe Luau di `Shared/Types.luau` dan disepakati tertulis dengan scripter (boleh revisi kecil di T1).
2. **Arsitektur autonomous action offline — keputusan: CATCH-UP SAAT LOGIN** [FINAL, disetujui pemilik 24/9], bukan server persisten. Alasan teknis: server Roblox berhenti saat kosong, sehingga "server persisten" per pemain tidak tersedia tanpa penjadwal eksternal dan biaya operasional. Alasan kanon (KANON_PMU_01 §3.2, 04 §4.5; manhwa ch.7 "as this is an idle game, the submaster… will do fine on his own"): saat master offline hero bertindak otonom dan master hanya menerima pesan sistem saat login (dowry 10.000 G otomatis, ch.218; long-term mission "status will continue to be updated even if you log out… view the video of the mission you missed in the menu", ch.194). Cara: saat logout simpan `lastSeen`; saat login hitung Δt, jalankan `Autonomy/TickDay` hari-per-hari dengan RNG berseed `(profileSeed, heroId, hari, slot)` memakai `NpcData` (DESAIN_AI_NPC_V0 §8.1), hasilkan pesan mailbox verbatim + entri log/replay; daily 11 jam & exploration 48 jam dihitung dari timestamp UTC. Simulasi berjalan di coroutine agar tidak membekukan server. Batas maksimum Δt — default 7 hari Bumi = 21 hari in-game; sisanya dianggap istirahat (duka tetap berjalan). **Sudden death (DESAIN_AI_NPC §3.5) tetap berjalan selama catch-up, termasuk di 21 hari in-game yang disimulasikan saat login** [FINAL, disetujui pemilik 24 Sep 23:55, DESAIN_AI_NPC §8.1] — roll tidak dibekukan hanya karena pemain offline; hero bisa mati sebelum pemain sempat login lagi, dan pesan warning [K] ch.284 tetap ditulis ke `mail` dengan tanggal in-game-nya sehingga urutan warning → kematian tetap terlihat saat pemain kembali (setia kanon Mormont ch.7: master tidak tahu apa-apa sampai login).
3. **Skema penyimpanan terpecah + `schemaVersion`** (RISET_Batas_Teknis_Endgame §4): key per pemain `core` / `heroes_N` (≤1.000 hero hidup per key) / `archive_N` (≤2.000 hero mati per key) / `replays` (seed + MissionRequest, bukan log) / `mail`; plafon teknis 2.000 hero hidup per pemain di V1+ (kapasitas Accommodation tetap angka data); fungsi migrasi skema + test-nya ada sejak M1; ukuran JSON hero diverifikasi dengan `JSONEncode` (target ≤900 byte, termasuk record tampilan dan `hero.npc` ≈300 byte — bila melampaui, relasi + memori pindah ke key `social_N`, DESAIN_AI_NPC §1.6).
4. Repo + `default.project.json` + Wally + lint berjalan; place di grup Roblox; scripter & artist mendapat akses berperan terbatas.
5. `Strings.luau` dimulai dari daftar pesan verbatim DESAIN_SISTEM_V0 + DESAIN_AI_NPC §7.3 (semua modul menambahkan ke sini, tidak hardcode).
6. Uji berbayar kecil scripter (lantai dummy + 100 run CSV) sudah dinilai → kontrak T0. Uji berbayar kecil artist (1 musuh + 1 wajah & rambut berlapis) dinilai dengan `LayeredSprite` placeholder.
7. **Format `sheet.json` & daftar nama lapisan** (slot, ukuran kanvas 192×256 / 48×64, jangkar kaki, urutan animasi 12 frame) dikirim ke artist sebelum T1.

## 4. URUTAN & TARGET MINGGUAN PEMILIK (12 jam/minggu)
Urutan: **M0 → M1 → M5 → M6 → M4 (setelah M2 T1 diterima) → M7 → M8 → M10** → integrasi. Jam = jam pemilik dengan AI (titik tengah). Minggu 1–6 = Tahap 0 (rincian sesi: CLAUDE_CODE_Brief_Tahap0 §B).

| Minggu | Modul | Jam | Target selesai | Verifikasi |
|---|---|---|---|---|
| 1 | Minggu 1 (§3) | 12 | Repo, tipe antarmuka, Rng berseed, keputusan catch-up, skema key terpecah, Strings awal, format sheet.json, akses tim | Rojo sync + lint lulus; scripter menandatangani §3 |
| 2–4 | **M0** | ±36 | Simulasi NPC headless lengkap (DESAIN_AI_NPC_V0 §1–§8): sifat/tujuan/idiosinkrasi/memori, 5 kebutuhan, stres 2 lapis + luka moral + sudden death berkombinasi, relasi 6 dimensi + kelompok/faksi SIMCA + mentor, 16 aksi, event, duka, keluaran (log, balon, kartu memorial, report); `NpcData` + `IdioData`; harness `sim/npc_sim` | 24 metrik §9 dalam rentang pada ≥15/20 seed di skenario A/B/C; determinisme byte-per-byte; 2.000 hero × 21 hari < 1,5 s; `docs/npc_calibration.md` |
| 5–6 | M1 | ±24 (+±17 diserap M5 minggu 7) | Summon 2 jenis + tiket + odds dari data; `Hero.new()` memanggil roll M0 + record tampilan `{rig, layerId, tint×5}`; status window; ProfileService key terpecah + schemaVersion; catch-up online + scheduler; placeholder UI (summon, daftar hero, feed, prompt Yes/No) | TestEZ 10.000 roll ±0,5 %; 1.000 appearance tanpa layer hilang; `JSONEncode(hero)` ≤900 byte termasuk `npc`; kill server saat roll → tanpa data-loss; catch-up Δt 24 jam & 7 hari tanpa freeze; pemain bisa summon → logout → login → membaca feed & ≥1 request |
| 7–10 | M5 | ±72 (termasuk sisa M1) | Fasilitas build/annex/merge/upgrade + kapasitas + footprint tile; waiting room bertingkat (cakram per lantai); research 3 cabang; jabatan + sub-master report (isi dari M0); party drag-drop; duel (resolver → M2 T1); mock battle; peri; Archive/memorial dasar (kartu dari M0) | Tambah 1 fasilitas = 1 baris data + sprite 3 level; laporan sub-master muncul harian; kartu memorial muncul saat hero mati |
| 11–16 | M6 | ±69 | Promosi 1★→3★ (ilustrasi berubah = aura ★ & lapisan pakaian naik); sintesis hero (dengan keadaan penyangkalan pra-sintesis & luka moral penonton dari M0); conversion; sintesis item + puzzle; crafting 3 metode; equipment E→B + arsenal acak + gear hilang saat mati; skill system; consumable; warehouse/mailbox/gift shop | 100 sintesis item 87 % → 82–92 %; skill Lv.10 → evolusi |
| 17–20 | M4 | ±43 | Daily 3 lokasi rotasi + 11 jam; exploration 48 jam + dowry; aksi otonom daily/eksplorasi dari utilitas M0; semua request hero = prompt Yes/No; replay = seed + MissionRequest | Uji catch-up dengan misi: log aksi sesuai sifat & memori; dungeon utama tidak dimasuki tanpa master |
| 21–24 | M7 | ±45 | Gift/likeability + reaksi; refusal/strike 3 opsi + compound command (gate M0 §6.1–6.2); hukuman (kurung/sintesis/ampun); vacation; pendidikan (latihan mandiri offline, instruktur ×gap★ via Social/Mentor, awakening, record reading); Archive/memorial lengkap (nisan bernama, memento dipilih pemain) di key `archive_N` | Bot-play 7 hari skenario C: ≥1 warning stres & sudden death hanya pada hero tanpa relasi dekat; gift salah terlihat di log; ritual Archive menurunkan stres yang berduka |
| 25–34 | M8 | ±134 | Framework state-binding; **Render/**: LayeredSprite, IsoMap markas 3/4 geser+zoom dengan hero berjalan & balon bicara (aksi hari ini dari M0), Arena tampak 3/4 dari event runtime M2/M3; ±20 layar landscape 16:9 & 19,5:9 dengan HUD pojok ala CoC, roster panel dengan indikator kontribusi per hero (manhwa ch.5), kartu ★, peta node tower, memorial, feed log berpotret 3–5 varian teks; bind event runtime (header, prompt, battle shop, tactics, cheering, clear/wipe); onboarding kanon 10 langkah; leaderboard lantai (OrderedDataStore, tulis hanya saat rekor naik) | 3 penguji awam tuntas onboarding tanpa penjelasan; uji "terasa hidup" DESAIN_AI_NPC §9 lulus; tanpa UI terpotong; 60 fps di ponsel menengah dengan 50 sprite hero berjalan di markas |
| 35–37 | M10 | ±28 | 6 gamepass + dev product gems/gold; receipt idempoten; audit semua Remotes | Fire remote manual → tanpa currency ilegal |
| 38–39 | Integrasi & rilis | ±24 | Gabung M2/M3 final (T3 scripter) + aset M9 final; kalibrasi (TERBUKA) dari CSV combat & npc; RELEASE | Playtest 30 lantai end-to-end; checklist BRIEF §2 DoD semua ✔ |

Catatan jadwal: M0 didahulukan karena `Hero.new()` (M1) memanggil roll sifat M0 dan karena M0 adalah nilai orisinal produk yang harus terbukti di harness sebelum modul lain dibangun di atasnya; total jam tidak berubah (M0 ±36 diambil dari alokasi lama M4 autonomy + M7 mental yang kini tinggal integrasi). Layar UI tiap modul dibuat **placeholder fungsional saat modulnya dikerjakan** (supaya bisa diuji), lalu dirapikan di M8; `LayeredSprite` placeholder (kotak berwarna per slot) sudah ada sejak M1 supaya record tampilan bisa dilihat. Jadwal scripter (BRIEF_SCRIPTER §4, ±20 jam/minggu): T1 M2 minggu 5–6 → M5 mock battle & M4 memakainya; T2 M3 minggu 11–12; T3 simulasi & tuning minggu 14–16 → kalibrasi angka (TERBUKA) bisa dimulai jauh sebelum integrasi minggu 38. Artist (BRIEF_ASET §4): T1 minggu 1–3 (hero berlapis + musuh + 1 arena) sudah cukup untuk uji scripter dan M1.

## 5. KEBIASAAN KERJA
- Satu sesi = satu sub-modul dengan kriteria verifikasi dari tabel §4 / CLAUDE_CODE_Brief §B; tulis test dulu bila ada angka (roll, rate, catch-up).
- Setiap akhir minggu: commit + tag `wk-NN`, perbarui `docs/STATUS.md`, salin ke Project Knowledge, catat di 00_Riwayat_Update_Log.
- Angka (TERBUKA) tidak didesain ulang: isi default kanon/DESAIN §10 & DESAIN_AI_NPC §10, tandai di `Data/` dengan komentar `-- TERBUKA`, kalibrasi dari CSV scripter & `npc_sim`.
- Tidak menyentuh `Combat/`, `Tower/`, `sim/combat_*` — perubahan di sana lewat scripter (atau CR setelah T4).
