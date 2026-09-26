# CLAUDE CODE — BRIEF TAHAP 0 (minggu 1–6, kredit habis 5 Nov 2026)

Terakhir diperbarui: 26 September 2026, 19:20 WIB

Berkas ini berisi (A) isi `CLAUDE.md` untuk repo, (B) urutan tugas Claude Code per minggu dengan kriteria verifikasi, (C) daftar berkas Project yang disalin ke `docs/`. Sumber: TAHAPAN_Build_AI_First §2–§3, RENCANA_Build_Hibrida §2–§4, DESAIN_AI_NPC_V0, BRIEF_SCRIPTER_M2_M3 §3, RISET_Batas_Teknis_Endgame §4. Status pengerjaan per minggu dicatat di `STATUS_Tahap0.md`.

Waktu tersedia: 24 Sep → 5 Nov 2026 = **6 minggu**; alokasi pemilik 12 jam/minggu (RENCANA) → ±72 jam pemilik + sesi Claude Code. Target Tahap 0 (TAHAPAN §3): minggu 1 (repo, tipe, skema key, catch-up, sheet.json) → **M0 simulasi NPC headless + test** → **M1** (summon, hero, record tampilan, ProfileStore) → mulai M5. RENCANA §4 mengalokasikan M1 di minggu 2–4; M0 disisipkan sebelum M1 karena hero.npc di-roll di `Hero.new()` (DESAIN_AI_NPC §8.3) — urutan di §B menyesuaikan.

---

## A. ISI `CLAUDE.md` (salin apa adanya ke root repo)

```markdown
# Grow a Cultivator — Roblox (Rojo) — CLAUDE.md

## Apa proyek ini
Game Roblox gacha-simulation tema wuxia, 100 % mekanik kanon novel "Pick Me Up". 2D landscape tampak 3/4 isometrik (sprite berlapis), mobile-first. Pemain = Master; hero = NPC otonom dengan sifat/kebutuhan/relasi (simulasi, TANPA LLM runtime); permadeath tanpa revive. Spesifikasi lengkap ada di `docs/` — BACA `docs/DESAIN_SISTEM_V0.md` §3, §5, §6 dan `docs/DESAIN_AI_NPC_V0.md` sebelum menyentuh modul terkait. Jangan mendesain ulang: angka bertanda (TERBUKA) diisi default dari docs + komentar `-- TERBUKA`, bukan dikarang.

## Keputusan final (jangan ditawar)
- Tanpa LLM runtime, tanpa HttpService ke API AI.
- Catch-up saat login (bukan server persisten): `Autonomy.catchUp(profile, nowUtc)`; Δt maks 7 hari Bumi; 1 hari Bumi = 3 hari in-game.
- Penyimpanan terpecah: key `core` / `heroes_N` (≤1.000 hero/key) / `archive_N` / `replays` / `mail`, semua dengan `schemaVersion`; migrasi skema + test sejak M1; hero ≤900 byte JSON.
- Nilai tersembunyi (sifat, kebutuhan, stres, relasi, likeability, talenta) TIDAK pernah lewat Remotes atau tampil sebagai angka.
- Semua RNG lewat `Shared/Rng.luau` berseed; tidak ada `math.random` langsung.
- Semua angka tuning hanya di `ReplicatedStorage/Data/*.luau` (tabel murni, tanpa logika); data yang hanya dipakai server dan tidak boleh terlihat klien (`NpcData`, `IdioData`) di `ServerStorage/Data/*.luau`. Pesan sistem hanya di `Data/Strings.luau` (verbatim EN kanon; string non-kanon diberi komentar `-- NONKANON`).
- Simulasi NPC dibangun dari `docs/DESAIN_AI_NPC_V0.md`; bila ragu maksud sebuah rumus, baca dasarnya di `docs/RISET_NPC_Bukti_Perilaku_Kanon.md` (kode BK-n #m) dan `docs/RISET_NPC_Psikologi_Manusia.md` — jangan mengganti dengan pola game lain.
- Folder `Combat/`, `Tower/`, `sim/combat_*` milik scripter eksternal — jangan diubah; panggil lewat `Shared/Types.luau` (`MissionRequest`/`MissionResult`).
- Combat & simulasi NPC = pure Luau, tanpa Instance/Workspace/Player (harus jalan headless).

## Struktur
Lihat `docs/RENCANA_Build_Hibrida.md` §2 (peta folder). `Data/AutonomyData.luau` di peta itu bernama `Data/NpcData.luau` di implementasi; folder `ServerScriptService/Social/` (relasi, kelompok, memori, duka) ditambahkan di sebelah `Autonomy/` dan `Mental/`.

## Alat & perintah
- Sinkron: `rojo serve default.project.json`
- Lint/format: `selene src` · `stylua src tests sim`
- Test: `run-in-roblox --place build/test.rbxl --script tests/run.server.luau` (TestEZ). Bila `run-in-roblox` tidak tersedia, jalankan `tests/run.server.luau` dari command bar Studio dan tempel output ke PR.
- Build place: `rojo build -o build/test.rbxl`

## Gaya kode
- Luau strict (`--!strict`) untuk `Shared/`, `Data/`, `Autonomy/`, `Mental/`, `Core/`.
- Satu modul = satu tanggung jawab; fungsi murni menerima state & mengembalikan state baru + daftar event (`{kind, heroId, ...}`) — tidak ada side effect global di simulasi.
- Nama field pendek di data profil (`tr`, `gl`, `id`, `nd`, `st`, `ld`, `gr`, `rl`, `mm`, `tg`) sesuai `docs/DESAIN_AI_NPC_V0.md` §1.6 karena anggaran byte.
- Tidak menambah dependensi Wally tanpa alasan tertulis di PR.

## Cara kerja per sesi
1. Baca tugas minggu ini di `docs/CLAUDE_CODE_Brief_Tahap0.md` §B.
2. Tulis test dulu bila ada angka (roll, rate, catch-up, byte).
3. Implementasi minimal → jalankan test → commit dengan pesan `wkN: <modul>: <apa>`.
4. Tulis 3–6 baris ringkasan hasil + angka test ke `docs/STATUS.md` (satu baris per commit; pemilik menyalin ke Project Knowledge).
5. Jangan menyentuh berkas di luar tugas; jangan "merapikan" kode lama.

## Sinkron dengan Claude Cowork (`docs/ALUR_SYNC.md`)
- Awal sesi: baca `docs/KEPUTUSAN.md`; keputusan di sana tidak ditanyakan ulang.
- Akhir sesi: tulis `docs/laporan/LAPORAN_SESI_<YYYY-MM-DD>_wkN.md` (7 bagian), commit + push, lalu beri pemilik tautan laporan + satu prompt pendek untuk Cowork.
- Pertanyaan hanya untuk keputusan milik pemilik, format `Qn` + opsi + rekomendasi default; hal yang jelas dari docs dikerjakan dan dicatat sebagai ASUMSI.
- Balasan `Qn: …` dari pemilik/Cowork dicatat ke `docs/KEPUTUSAN.md` sebelum tugas baru dimulai.
- Mode otomatis (scheduled task tiap jam): ikuti `docs/ALUR_SYNC.md` bagian "Mode otomatis"; antrean keputusan pemilik = `docs/PERTANYAAN_PEMILIK.md`.
- Batas sesi: satu sesi Claude Code = satu siklus (kerjakan tugas → laporan). Sesi berikutnya dimulai sebagai sesi BARU dari `main`; konteks dibawa oleh repo (CLAUDE.md, `docs/KEPUTUSAN.md`, `docs/STATUS.md`, laporan), bukan oleh riwayat chat. Beri tahu pemilik dan berhenti di batas butir yang bersih bila: konteks pernah dipadatkan otomatis (auto-compact), sudah membaca ≥3 dokumen besar docs/ penuh, atau tugas berikutnya butuh baca ulang docs besar. Bagian 7 laporan WAJIB memuat blok "PROMPT SESI BERIKUTNYA" siap-tempel (tugas berikut + Langkah 0 tanggal docs + tempat menempel balasan Qn).

## Jangan
- Jangan menyimpan gambar hero gabungan; hanya record `{rig, layers, tints}`.
- Jangan autosave < 60 detik atau menulis key >2 MB.
- Jangan membuat UI final; placeholder fungsional saja (M8 nanti).
```

---

## B. URUTAN TUGAS CLAUDE CODE — MINGGU 1–6

Setiap baris = satu sesi Claude Code yang bisa selesai dalam 1–3 jam. "Verifikasi" = kriteria lulus yang harus dilaporkan di `docs/STATUS.md`.

### Minggu 1 — repo, tipe, skema (RENCANA §3)
| # | Tugas | Verifikasi |
|---|---|---|
| 1.1 | Inisialisasi repo: `default.project.json` sesuai RENCANA §2, `wally.toml` (ProfileStore, TestEZ), `selene.toml`, `stylua.toml`, `.gitignore`, `CLAUDE.md` (§A), `docs/` (§C), `tests/run.server.luau` | `rojo build` sukses; `selene` 0 error; test kosong lulus |
| 1.2 | `Shared/Types.luau`: `HeroInput`, `PartyInput`, `FloorRow`, `MissionRequest`, `MissionResult`, `EventLine`, `Appearance` — persis BRIEF_SCRIPTER §3 (field final) | type-check `--!strict` lulus; dokumentasi 1 baris per field |
| 1.3 | `Shared/Rng.luau`: RNG berseed deterministik xoshiro128** pure Luau dengan API ala `Random` (`NextNumber`, `NextInteger`, `NextUInt32`) — tidak membungkus `Random.new` agar stabil lintas versi engine & jalan headless; `derive(seed, ...parts)` → sub-seed stabil (hash string) | test: 2 run seed sama → 1.000 angka identik; sub-seed `(profile, hero, day, slot)` tidak bertabrakan pada 100.000 sampel |
| 1.4 | `Core/Profile.luau`: ProfileStore key terpecah `core`/`heroes_N`/`archive_N`/`replays`/`mail`, `schemaVersion`, `Core/Migrate.luau` dengan tabel migrasi v1→v2 dummy | test migrasi: profil v1 → v2 tanpa kehilangan field; `JSONEncode` hero dummy ≤900 byte |
| 1.5 | `Data/Strings.luau` awal (tabel murni): semua string [K] dari DESAIN_SISTEM_V0 §5–§6 dan DESAIN_AI_NPC §7.2 (teks utuh string yang terpotong: `docs/Data_Strings_K_Lengkap.md`; teks NONKANON: `docs/Data_Strings_NONKANON.md`), dengan placeholder `{name}` `{stars}` `{party}`; util `Strings.format(id, tbl)` di `Shared/Strings.luau` (Data wajib tanpa logika) | test: setiap id punya placeholder yang bisa diisi; tidak ada string duplikat |
| 1.6 | `docs/sheet_format.md` + `tools/sheet2luau.py`: format `sheet.json` artist (slot, kanvas 192×256 / 48×64, jangkar, 12 frame) → menghasilkan `Data/AppearanceData.luau` & `SpriteData.luau` dari contoh dummy | skrip jalan pada contoh; output Luau valid |

### Minggu 2 — M0 inti: data, sifat, kebutuhan, stres (DESAIN_AI_NPC §1–§2)
| # | Tugas | Verifikasi |
|---|---|---|
| 2.1 | `Data/NpcData.luau` + `Data/IdioData.luau`: semua koefisien DESAIN_AI_NPC §1.2 roll & drift, §1.3 goal, §1.4 katalog idiosinkrasi, §2.2 laju, §3.2–3.6, §4.3 bobot f & Δ, §4.6 SIMCA, §5.2 bobot/bias/noise, §6 probabilitas, §6.10 trajektori — setiap baris `-- TERBUKA` | modul hanya tabel; type `NpcConfig` |
| 2.2 | `Autonomy/Traits.luau`: `roll(rng, star)` → 7 dimensi (HEXACO + nyali), 1–2 goal, 2–4 idiosinkrasi, 2 tag identitas (§1.2–1.4, §4.6); `drift(hero, event)` (§1.2) | test: 10.000 roll → mean 50±2 & σ 15±2 (cou/C per ★ sesuai data); ekstrem <10/>90 ≤ 2,5 %; drift maks 5 poin per peristiwa; encode→decode identik |
| 2.3 | `Autonomy/Needs.luau`: 5 kebutuhan non-hierarkis (rest, food, aut, cmp, rel), decay §2.2, frustrasi ≠ ketiadaan, kebutuhan sosial kontinum (target `rel` = 40 + 0,6·X, decay ×(0,4 + X/100), DESAIN §2.2); `Mental/Stress.luau`: `vul`, `st`, `ld`, ambang patah = f(vul, ld), sumber/penurun §3.3, likeability §3.6. **`xp` (§1.2a)**: seed 0/15/40 per ★, habituasi +2/+4 per misi selamat tanpa panic, sensitisasi −3/−6 per panic tanpa pemulihan 3 hari, plafon `40+0,6·cou`, differential susceptibility `E≥65` ×1,5 dua arah; **`cou_eff = clamp(cou + 0,3·xp − 0,2·ld, 0, 100)`** dipakai di semua rumus turunan (bukan `cou` mentah) | test: hero X > 50 tanpa aksi 30 hari in-game (nilai awal 50) → semua need <30 (X ≤ 50: `rel` berhenti di lantai sendiri `100 − target`, DESAIN §2.2); dipaksa (aut −15) > tidak dipenuhi; penyendiri X≤33 tidak pernah rel<40 tanpa kehilangan; ld naik hanya setelah ≥1 hari st≥60 dan turun setelah 7 hari st<40. **`xp`/`cou_eff`**: 1★ segar `xp=0` vs 3★ segar `xp=40` → `cou_eff` 3★ lebih tinggi pada hari 1; 1★ setelah 10–15 misi selamat tanpa panic → `xp` 20–30 (plafon `40+0,6·cou` tidak terlampaui; baru tercapai ±35 misi), `cou_eff` mendekati 3★ segar (selisih ≤3 setelah 15 misi); hero `st≥60` tanpa pemulihan 3 hari setelah panic → `xp` turun (sensitisasi); `E≥65` menunjukkan pengali ×1,5 pada kedua arah dibanding `E<65` pada input identik |
| 2.4 | `Mental/MoralInjury.luau` + `Mental/SuddenDeath.luau`: guilt & luka moral (§3.4); warning 1×/episode; roll sudden death HANYA pada kombinasi faktor §3.5 (st≥ambang & rel<30 & tak ada t≥9 & kehilangan/gagal berulang); **roll memakai `cou_eff`, bukan `cou` genetik** (§1.2a — `vul` tetap memakai `cou` genetik, hanya reaksi/roll harian yang memakai `cou_eff`) | test: hero st 95 tapi punya 1 relasi t≥9 → p=0 selama 365 hari × 20 seed; hero Mormont-like (baru, tanpa relasi, wipe) → ≥1 kematian dalam 60 hari pada ≥10/20 seed; warning selalu mendahului kematian ≥3 hari; **dua hero dengan `cou` genetik identik tapi `xp`/`ld` berbeda → `p` sudden death berbeda sesuai `cou_eff`, dibuktikan lewat log run seed sama** |

### Minggu 3 — M0 relasi, faksi, jabatan, tick harian (§3–§5)
| # | Tugas | Verifikasi |
|---|---|---|
| 3.1 | `Social/Relations.luau`: 6 dimensi berarah (a, t, f, r, d, env) §4.2; tumbuh per propinquity × bobot peristiwa (misi ×5, wipe bersama ×10) §4.3; ambang Hall; pelanggaran integritas vs kompetensi; iri benign/malicious; slot ≤8 + anggaran sosial `focus`; relasi implisit §4.4; packing ≤28 bit; fusi meluruh & decay | test: pack→unpack identik semua kombinasi & flag; 2 hero selamat wipe bersama → f≥9 dalam 30 hari; pelanggaran integritas pulih ≥3× lebih lambat dari kompetensi; slot ke-9 mendorong yang terlemah, Bond/Sumpah/Enmity tidak pernah terdorong |
| 3.2 | `Social/Groups.luau`: tag identitas & favoritisme in-group; `grv` = relative deprivation vs 1–3 acuan + penyebaran lewat suara (pluralistic ignorance); klik = komponen `t≥9 & a≥3`; faksi HANYA bila SIMCA (grv≥60 × leader × identitas); sinisme bila tanpa leader; bubar & efek hukum ringleader (§4.6) | test: 25 hero lantai 1, 20 di lantai 2 dengan fasilitas → faksi ≤1 dan hanya setelah grv≥60; anggota yang ikut mass strike 25–55 % dari lantai 1; klik tanpa grievance TIDAK jadi faksi dalam 365 hari |
| 3.3 | `Autonomy/Roles.luau` + `Social/Mentor.luau`: efek jabatan (sub-master/deputy p_tolak=0, party leader latihan wajib, chef, researcher, manager); mentor–murid berflag dengan syarat guru & laju skill ×gap★ (§4.5); **mentor mentransfer `xp` +1/minggu ke murid (§1.2a, §4.5)** | test: sub-master p_tolak = 0; chef pref cocok → food +10; guru H murid<30 menolak; murid melampaui guru → r naik & cmp guru +10 bila A≥50; **murid berflag mentor ≥4 minggu → `xp` murid naik ≥4 dibanding murid tanpa mentor pada input identik** |
| 3.4 | `Autonomy/Utility.luau` + `Autonomy/Actions.luau`: 16 aksi §5.2 dengan bias sifat/goal/memori/idiosinkrasi + noise ±8 (semua bias "nyali" memakai `cou_eff`, §1.2a/§5.2); `Social/Memory.luau` (≤10 memori, kunci, valensi) §1.5; `Autonomy/TickDay.luau` urutan 8 langkah §5.1 (fungsi murni → `state, events`) | test: hero C 90 & TC → `latih` 50–75 % hari (tidak 100 % — noise); hero rest 10 → `istirahat`; hero dengan memori "labirin" valensi −2 menghindari misi labirin; memori ke-11 membuang valensi terkecil tertua, memori kunci tidak dibuang; **latihan terarah (DESAIN §5.2)**: leader C≥60 + lantai berikut bertag api → party memakai bentuk brazier pada hari non-misi (juga saat catch-up offline), anggota C<30 & A<40 boleh skip (a −1 ke leader), tag tanpa padanan → `latih` generik |

### Minggu 4 — M0 event, keluaran, test integrasi, harness (§6–§7, §9)
| # | Tugas | Verifikasi |
|---|---|---|
| 4.1 | `Autonomy/Events.luau`: gate penilaian perintah §6.1 (bahaya × adil × like × aut; bentuk request pada ★≥3); **compound command (§6.1 [FINAL 24 Sep 23:55]: perintah + ≥1 konsesi berbiaya nyata → p_tolak=0; anti-eksploitasi: konsesi sama ≥3× berturut pada party sama → p_tolak ×0,5 bukan 0; tetap dihitung "dipaksa" bila p_tolak sebelum pengali ≥0,3 → aut −15, luka moral bila §3.4(c))**; mogok/faksi/3 opsi §6.2, inisiatif §6.3, duel (stub `DuelResolver` → M2 headless) §6.4; pencurian/**pemerasan** (§6.5, kanon ch.158: syarat `H≤25 & X≥50` + target `r(target→pelaku)≥8` + target lebih lemah; korban tahu pelaku tanpa roll ketahuan, t korban→pelaku −6 seketika, korban grv +10 & aut −10; pemerasan berulang ≥3× lantai sama → grv lantai +5)/provokasi/Enmity/rekonsiliasi §6.5, berteman/Bond §6.6, menghibur §6.7, Ikatan Sumpah §6.8, request §6.9, event lain §6.11 | test per event: syarat & p=1 → muncul, p=0 → tidak; string [K] persis; refusal p=0 pada compound & sub-master; hero ★3 like 80 menolak → ≥60 % berbentuk request. **Compound command**: p_tolak=0 pada pengiriman compound pertama; konsesi identik ke-4× berturut pada party sama → p_tolak turun ke ×0,5 dari nilai dasar (bukan 0); hero dengan p_tolak dasar ≥0,3 sebelum compound → `aut` tercatat turun 15 di log event meski misi tetap terkirim. **Pemerasan**: hero `H≤25 & X≥50` dengan target valid → aksi `EXTORT` muncul di log tanpa roll ketahuan; t korban→pelaku turun 6 pada tick yang sama; pemerasan ke-3 pada lantai sama dalam window uji → grv lantai naik 5 |
| 4.2 | `Social/Grief.luau` (§6.10): siapa berduka, trajektori berbobot, osilasi loss/restoration, continuing bonds (memento, menyebut, hari peringatan), ritual Archive, survivor guilt, humor gelap; `Autonomy/Output.luau` (§7): pesan sistem, log `{day, heroId, kind, targetId?, payload}` tanpa nilai tersembunyi, balon bicara, **kartu memorial** (3–5 memori + idiosinkrasi + relasi bernama), business report | test: kematian ikatan intim → ≥50 % hero berduka masih "menyebut" pada hari 180; trajektori resilien 40–60 % pada 1.000 roll; log & kartu tidak memuat key `tr/nd/st/ld/rl/mm`; kartu memorial selalu punya ≥3 memori bila hero hidup ≥30 hari |
| 4.3 | `sim/npc_sim.luau` + `tests/npc.spec.luau`: skenario A/B/C §9 (100 hero × 365 hari × 20 seed) → CSV `seed,day,kind,count` + ringkasan relasi/faksi/duka; `docs/npc_calibration.md`; ekspor 30 hari feed 20 hero untuk uji "terasa hidup" manual | semua 24 metrik §9 dalam rentang pada ≥15/20 seed; determinisme byte-per-byte; 2.000 hero × 21 hari < 1,5 s |
| 4.4 | Kalibrasi putaran 1: ubah HANYA `NpcData` sampai §9 lulus; catat nilai akhir di `docs/npc_calibration.md` **[PRASYARAT, pemilik 26 Sep]:** kalibrasi memakai angka [PSI-angka] yang **sudah dimasukkan pemilik/Cowork ke `docs/DESAIN_AI_NPC_V0.md`** (cari label `[PSI-angka]` di DESAIN; dasar & alasan tiap angka di `docs/RISET_NPC_Kalibrasi_Empiris.md` §1); bila DESAIN belum memuat label `[PSI-angka]`, lewati 4.4 dan kerjakan 5.1 dst., kembali ke 4.4 setelah label itu ada. Berkas riset saja (tanpa label di DESAIN) BELUM cukup — usulan di dalamnya belum disetujui | tabel sebelum/sesudah per koefisien yang diubah |

**Catatan compound command UI:** prompt konsesi (pilihan istirahat/vacation/gift/naik lantai yang ditampilkan ke master saat mengirim compound command) adalah item **M7** (DESAIN_AI_NPC §8.3: "M7: ... compound command UI (§6.1)"), bukan bagian minggu 2–4 — logika gate compound (p_tolak, anti-eksploitasi) sudah tercakup di tugas 4.1 di atas; UI-nya menyusul di brief M7 (di luar cakupan Tahap 0 minggu 1–6 ini, lihat RENCANA §4 baris M7 minggu 21–24).

### Minggu 5 — M1: summon, hero, profil (RENCANA §4 M1)
| # | Tugas | Verifikasi |
|---|---|---|
| 5.1 | `Data/SummonData.luau`, `Data/HeroData.luau` (cap 10/20/40, exp 10×Lv, growth band, status effect %, generator nama wuxia), `Data/GiftData.luau` minimal | tabel murni; nilai kanon bertanda [K]/[N] di komentar |
| 5.2 | `Summon/Summon.luau`: 2 jenis + tiket, odds dari data (4★ <1 %, 5★ 0,1 %), label grade, Bond/Enmity summon → slot kanon (Relations) | test 10.000 roll ±0,5 % per ★; bond terjadi pada consecutive draw dengan p data |
| 5.3 | `Hero/Hero.luau`: `Hero.new(rng, star)` memanggil `Traits.roll` + roll record tampilan `{rig, layers, tints×5}`; status window kanon; `Hero/Appearance.luau` | test: 1.000 appearance dirakit dari `AppearanceData` dummy tanpa layer hilang; `JSONEncode(hero)` ≤900 byte **termasuk `npc`** — bila gagal, pindahkan `rl` (dan bila perlu `mm`) ke key `social_N` (DESAIN_AI_NPC §1.6, §10.2 #2) dan catat; hitung juga penanda runtime `sk`/`cd`/`xe` (§1.6) |
| 5.4 | `Core/Save.luau`: simpan/muat hero ke `heroes_N`, autosave ≥60 s, penulisan `mail` & `replays`; uji kill-server | test: matikan sesi saat roll → tanpa data-loss (session lock ProfileStore) |

### Minggu 6 — M1 catch-up + M4 inti + placeholder UI (RENCANA §3.2, §4 M4)
| # | Tugas | Verifikasi |
|---|---|---|
| 6.1 | `Autonomy/CatchUp.luau`: `lastSeen` → Δhari (×3, maks 21 hari in-game), loop `TickDay` di coroutine (`task.wait` tiap 200 hero), tulis pesan ke `mail`, log ke `replays`. **Sudden death tetap berjalan selama catch-up** (DESAIN_AI_NPC §8.1 [FINAL 24 Sep 23:55], RENCANA §3.2): roll §3.5 tidak dibekukan saat pemain offline — hero bisa mati sebelum pemain login lagi; warning [K] ch.284 tetap ditulis ke `mail` dengan tanggal in-game-nya, sehingga urutan warning → kematian tetap terlihat saat pemain kembali | test Δ 24 jam & 7 hari: jumlah hari benar; tanpa freeze (>1 frame) pada 2.000 hero; daily 11 jam & exploration 48 jam dari timestamp UTC. **Sudden death saat catch-up**: hero Mormont-like (tanpa relasi t≥9, `st` di atas ambang) yang di-inject pada awal window catch-up 21 hari → sudden death dapat terjadi SEBELUM `CatchUp` selesai pada ≥1 dari 20 seed, dan pesan warning muncul di `mail` dengan hari in-game sebelum pesan kematian |
| 6.2 | Scheduler online: tick 1 hari in-game tiap 8 jam Bumi saat pemain online; `DuelResolver` & `daily dungeon` memakai stub hasil (sampai M2 T1 diterima) | test: hero online 24 jam → 3 tick |
| 6.3 | Placeholder UI minimal (StarterGui, kode): tombol Summon, daftar hero (nama, ★, aksi hari ini dari log), feed pesan sistem, prompt Yes/No generik untuk request hero — hanya untuk menguji alur, bukan desain final | pemain bisa: summon 10 → logout → login besok → membaca feed aksi & ≥1 request hero |
| 6.4 | `docs/STATUS.md` final Tahap 0 + `docs/npc_calibration.md` + daftar (TERBUKA) yang berubah → pemilik menyalin ke Project Knowledge (KALIBRASI ulang jam nyata, TAHAPAN §Tahap 1) | semua test hijau di `tests/`; tag `wk-06` |

**Bila waktu kurang:** prioritas absolut = 1.1–1.5, 2.1–2.4, 3.1–3.4, 4.1–4.3 (M0 lengkap & teruji). M1 5.1–5.3 berikutnya. 5.4, 6.x boleh dilanjutkan dengan Studio Assistant setelah kredit habis (TAHAPAN §2).

**Prompt pembuka tiap sesi Claude Code (salin):**
```
Baca CLAUDE.md, lalu docs/CLAUDE_CODE_Brief_Tahap0.md §B baris <N.N>, lalu bagian docs yang dirujuk baris itu. Kerjakan HANYA tugas itu: tulis test dulu, implementasi minimal, jalankan test, laporkan angka verifikasi. Jangan ubah berkas di luar tugas. Angka (TERBUKA) ambil dari docs, beri komentar -- TERBUKA. Akhiri dengan 3–6 baris ringkasan untuk docs/STATUS.md.
```

---

## C. BERKAS PROJECT YANG DISALIN KE `docs/` (Markdown apa adanya, nama sama)
Wajib (dibaca Claude Code):
1. `DESAIN_AI_NPC_V0.md`
1a. `RISET_NPC_Bukti_Perilaku_Kanon.md` (rujukan BK-n #m yang dipakai DESAIN_AI_NPC)
1b. `RISET_NPC_Psikologi_Manusia.md` (dasar rumus; baca bagian "Untuk simulasi" saja bila waktu terbatas)
1c. `Data_Strings_NONKANON.md` (teks 10 id NONKANON + template kartu memorial untuk `Data/Strings.luau`)
1d. `Data_Strings_K_Lengkap.md` (teks utuh 9 string [K] yang terpotong di DESAIN_SISTEM)
2. `DESAIN_SISTEM_V0.md` (§0–§6 wajib; §7–§10 rujukan)
3. `RENCANA_Build_Hibrida.md` (§2–§3)
4. `BRIEF_SCRIPTER_M2_M3.md` (§3 kontrak antarmuka saja — salin §3 ke `docs/INTERFACE_M1_M2.md`)
5. `RISET_Batas_Teknis_Endgame.md` (§4 aturan arsitektur)
6. `CLAUDE_CODE_Brief_Tahap0.md` (berkas ini)
7. `RISET_Game_Referensi_HUD.md` §4–§5 (untuk record tampilan & format sheet.json) — salin dua seksi itu ke `docs/VISUAL_2D.md`

Tidak disalin: KANON_PMU_* (terlalu besar; DESAIN & RISET_NPC_Bukti sudah memuat sitasi), KONSEP, KALIBRASI, BRIEF_VENDOR, BRIEF_ASET, FORM, TAHAPAN, log.

**Sinkron `docs/`:** setiap kali berkas di daftar ini berubah di Project Knowledge, chat Cowork menyebutkan berkas mana yang harus diganti di `docs/` (daftar terkini di `STATUS_Tahap0.md` bagian "Sinkron docs/").

Berkas keluaran repo yang harus dibawa balik ke Project Knowledge oleh pemilik (aturan A1): `docs/STATUS.md` (tiap minggu), `docs/npc_calibration.md` (setelah 4.4), `Data/NpcData.luau` (sebagai teks, setelah kalibrasi).
