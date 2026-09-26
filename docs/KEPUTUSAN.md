# KEPUTUSAN PEMILIK — log (terbaru di bawah)

Dicatat oleh Claude Code dari balasan pemilik/Cowork. Keputusan di sini tidak ditanyakan ulang. Alur: `docs/ALUR_SYNC.md`.

| Tanggal | Rujukan | Keputusan | Sumber |
|---|---|---|---|
| 2026-09-25 | Laporan wk1 #1 | RNG xoshiro128** pure Luau (tidak membungkus `Random.new`) — DISETUJUI | pemilik |
| 2026-09-25 | Laporan wk1 #2 | ProfileStore — DISETUJUI | pemilik |
| 2026-09-25 | Laporan wk1 #3 | `Strings.format` di `Shared/` — DISETUJUI | pemilik |
| 2026-09-25 | Laporan wk1 #4 | `rl`+`mm` di `heroes_N` vs `social_N` diputuskan di tugas 5.3 | pemilik |
| 2026-09-25 | Laporan wk1 #5 | `panicEvents` + `minHpPct` + `hidden.hesitation` masuk kontrak (INTERFACE) | pemilik |
| 2026-09-25 | Laporan wk1 #6 | Penanda `-- ASUMSI` di Types.luau = draf kontrak, dibiarkan | pemilik |
| 2026-09-25 | Laporan wk1 #7 | Teks string: Data_Strings_K_Lengkap.md + Data_Strings_NONKANON.md | pemilik |
| 2026-09-25 | Laporan wk1 #8 | Id final `MENTIONS_DECEASED` | pemilik |
| 2026-09-25 | Laporan wk1 #9 | `assets/sheet.example.json` hanya bahan uji, jangan diubah | pemilik |
| 2026-09-25 | Laporan wk1 #10 | Paket Wally tidak di-vendor; di cloud pakai runner Lune | pemilik |
| 2026-09-25 | Laporan wk1 #11 | Nama proyek "Grow a Cultivator" | pemilik |
| 2026-09-25 | Alur kerja | Laporan di `docs/laporan/`, pertanyaan format Qn, log ini, alur `docs/ALUR_SYNC.md` | pemilik |
| 2026-09-26 | LAPORAN 2026-09-25 Q1 | Idiosinkrasi: kategori tetap; angka "2–4" dihapus dari docs (DESAIN §1.4 kini "5–7 item dari 6 kategori") | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-25 Q2 | `fd = {fav, hated}` (makanan favorit & dibenci) | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-25 Q3 | Opsi C: leader = skor efikasi tertinggi di klik, faksi hanya bila skor itu ≥ persentil 80 skor efikasi seluruh hero di lantai yang sama (TERBUKA, kalibrasi 4.4) — agar cabang "tanpa leader → sinisme" §4.6 bisa terjadi | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-25 Q4 | Likeability awal saat summon = 50 (netral, TERBUKA) | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-25 Q5 | Besar puncak duka kedua (§6.10) ditunda ke tugas 4.2/kalibrasi | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-25 Q6 | Makan bersama: food +3 dan rel +3 (bacaan harfiah tabel) | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-25 Q7 | Koefisien §5.1, §8.1, §8.2 tetap di NpcData | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-25 Q8 | Opsi B: `NpcData` & `IdioData` dipindah ke `ServerStorage/Data` (tidak ter-replikasi ke klien; cegah datamine rumus refusal/sudden death) | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-25 Q9 | Packing relasi: docs dikoreksi menjadi "≤28 bit" | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-25 Q10 | Brief 2.3 dikoreksi mengikuti DESAIN §2.2 (kontinum `40 + 0,6·X`) | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-25 Q11 | 4 string [K] ch.65 ditambahkan ke Data_Strings_K_Lengkap #10–#13 (FLOOR_ASSIGN_PARTY, FLOOR_ASSIGN_NAMES, FLOOR_ASSIGN_REST, ROOM_HEADCOUNT); catatan #9 dikoreksi | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-26 Q1 | A: jumlah idiosinkrasi per hero = 6–8 item; docs §1.4 dikoreksi (gift fav ×1–2 + dibenci ×1 + makanan 2 + hobi + kebiasaan + keengganan ×0–1) | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-26 Q2 | A: "tidak bergeser sama sekali" (§1.2) = roll 50 % **per hero**, tetap seumur hidup, dari `profileSeed`+`heroId` (0 byte) | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-26 Q3 | A: erosi isolasi (E +1/30 hari, O −1/60 hari) dan stagnasi §6.11 berlaku untuk **semua** hero, tidak tunduk roll plastisitas | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-26 Q4 | A: peluang punya 1 keengganan = 50 % (TERBUKA, kalibrasi 4.4) | Cowork/pemilik |
| 2026-09-26 | Docs berubah | `docs/DESAIN_AI_NPC_V0.md` — 26 Sep 2026, 01:16 WIB (§1.4 6–8 item + keengganan 50 % TERBUKA; §1.2 plastisitas per hero seumur hidup, erosi isolasi semua hero; §6.11 stagnasi semua hero; §10.1 #13). Q1–Q4 = default yang sudah diterapkan sesi 26 Sep; `Traits.luau` diverifikasi sesuai, tanpa perubahan kode | Cowork/pemilik |
| 2026-09-26 | LAPORAN 2026-09-26b Q1 | A: lantai sendiri `rel` = 100 − target; Brief 2.3 penyendiri X≤33, "semua need <30" untuk X>50 (docs dikoreksi 26 Sep 15:15). Kode 2.3 sudah sesuai, tanpa perubahan | Cowork |
| 2026-09-26 | LAPORAN 2026-09-26b Q2 | A: nilai awal kebutuhan 50 (TERBUKA, kalibrasi 4.4). Sudah di `NpcData.needs.initial` | Cowork |
| 2026-09-26 | LAPORAN 2026-09-26b Q3 | A: `sk`/`cd`/`xe` masuk DESAIN §1.6; byte diputuskan di 5.3 | Cowork |
| 2026-09-26 | LAPORAN 2026-09-26b Q4 | A: Brief 2.3 — 1★ 15 misi → selisih cou_eff ≤3 ke 3★ segar (bukan plafon). Test `experience.spec` sudah meng-assert ≤3 | Cowork |
| 2026-09-26 | P1 (tugas 3.4) | A: latihan terarah ke lantai berikutnya; spesifikasi DESAIN §5.2 & Brief 3.4 (26 Sep 16:40) | pemilik |
| 2026-09-26 | P2 (M7/M8) | A: peri = kotak rekomendasi Yes/No; DESAIN §7.2 #6; tidak dibangun di Tahap 0 | pemilik |
| 2026-09-26 | P3 (tugas 3.4) | "Pura-pura latihan" TIDAK dibangun kecuali ditemukan dasar kanonnya (bila chapter ditemukan, dibuka ulang) | pemilik |
| 2026-09-26 | J8 (LAPORAN 2026-09-26c Q2) | A — roll sudden death hanya bila warning episode ini berumur ≥ `warnWindow.min` (3) hari. Kematian = ujung efek bola salju, bukan lonjakan sehari; hero bermental kuat mengatasi stres sendiri, yang lemah minta rehat (§5.2/§6.9) | pemilik (18:23 WIB) |
| 2026-09-26 | J9 (LAPORAN 2026-09-26c Q5) | Δ guilt "pengakuan"/"ritual" (§6.10) tidak dikarang — angkanya diambil dari `docs/RISET_NPC_Kalibrasi_Empiris.md`. Digantikan J10 (riset sudah disetujui & masuk DESAIN) | pemilik + Cowork |
| 2026-09-26 | J10 (RISET_NPC_Kalibrasi_Empiris §1/§8) | Pemilik menyetujui SEMUA usulan kalibrasi (Blok A + P-K1 A, P-K2 A, P-K3 C, P-K4 A, P-K5 A, P-K6 A, P-K7 A, P-K8 A, P-K9 A, P-K10 A, P-K11 B). DOCS BERUBAH: `DESAIN_AI_NPC_V0.md` 26 Sep 19:38 WIB (label [PSI-angka] §1.2a, §2.2, §3.2–3.5, §4.3, §5.2, §6.7, §6.9, §6.10, §9, §10.2), `Data_Strings_NONKANON.md` §12 `REQUEST_REST`, Brief 4.2 (resilien 55–70 %). **BELUM DITERAPKAN DI KODE** (`NpcData.luau` per 27 Sep masih couEff xp=0,3 / sensitisasi −3/−6 / vul 0,5·E−0,3·cou−0,2·C — angka lama): penyesuaian ke [PSI-angka] pada tugas yang menyentuh modul itu, paling lambat 4.4 | pemilik + Cowork |
| 2026-09-26 | J11 (J4 / Brief 2.3 × [PSI-angka] cou_eff 0,4·xp) | A — kriteria J4 diganti: 1★ selisih cou_eff ke 3★ segar ≤4 setelah 15 misi, ≤2 setelah 20 misi (= 0,4·(40−xp)); ≤3 lama hanya berlaku untuk 0,3·xp. `experience.spec` disesuaikan bersamaan dengan `NpcData` (J10). DOCS BERUBAH: Brief 26 Sep 20:20 WIB. **Menunggu penerapan kode bersama J10/J13** | pemilik (20:15) |
| 2026-09-26 | J12 (DESAIN §3.6 × §3.4) | A — Δlike TIDAK ditumpuk: a≥8 ke korban sintesis → −15 menggantikan −6; pengakuan +15/+8 menggantikan +10; "luka moral −10" §3.6 = pemicu (c) saja. DOCS BERUBAH: DESAIN 26 Sep 20:20 WIB (§3.6, §1.6a noise ±10, §8.2 cek pemulihan 5 hari) | pemilik (20:15) |
| 2026-09-26 | J13 (pelengkap J10, MEKANIS, Cowork) | Daftar lengkap penyesuaian kode 2.2–2.4 terhadap DESAIN 20:20, angka hanya di `NpcData`: Experience (0,4·xp; −5/−10; jendela 5 hari; E≥58) · Stress (vul 0,45/0,30/0,25; tarikan hanya <40 maks 8/hari; pulih ×0,6 bila rest<30; reaktivitas ×(1+vul/200); ld −0,5/hari lantai 10 +8/episode patah maks 5; vacation −12/−4; dukungan ×1,5) · MoralInjury (guilt kelas a +8…+16 & like −15, b +10…+20, c +10…+20 & like −10, d +15…+30; pengali A/C clamp 0,5–1,8; dihibur −5 maks 3×; pengakuan −8/+15 ≤60 hari lalu 0/+8; ritual −3) · SuddenDeath (pengali ×2 hari 1–7). **Dikerjakan pada tugas yang menyentuh modulnya atau paling lambat 4.4** — belum diterapkan per 27 Sep | Cowork |
