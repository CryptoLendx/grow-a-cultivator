# PERTANYAAN PEMILIK — antrean keputusan

Terakhir diperbarui: 26 September 2026, 16:40 WIB

Diisi putaran otomatis (pertanyaan DESAIN) dan Cowork/pemilik (jawaban). Aturan: `docs/ALUR_SYNC.md` "Mode otomatis". Status: TERBUKA · DIJAWAB (menunggu dicatat ke KEPUTUSAN oleh putaran berikut). Butir yang sudah dicatat ke `docs/KEPUTUSAN.md` dihapus dari berkas ini.

## DIJAWAB (terapkan ke `docs/KEPUTUSAN.md`)
| # | Tanggal | Rujukan | Jawaban | Sumber |
|---|---|---|---|---|
| J1 | 2026-09-26 | LAPORAN 2026-09-26b Q1 | A — lantai sendiri `rel` = 100 − target; Brief 2.3 penyendiri X≤33, "semua need <30" untuk X>50 (docs sudah dikoreksi 26 Sep 15:15) | Cowork |
| J2 | 2026-09-26 | LAPORAN 2026-09-26b Q2 | A — nilai awal kebutuhan 50 (TERBUKA, kalibrasi 4.4) | Cowork |
| J3 | 2026-09-26 | LAPORAN 2026-09-26b Q3 | A — `sk`/`cd`/`xe` masuk DESAIN §1.6; byte diputuskan di 5.3 | Cowork |
| J4 | 2026-09-26 | LAPORAN 2026-09-26b Q4 | A — Brief 2.3: 1★ 15 misi → selisih cou_eff ≤3 ke 3★ segar (bukan plafon) | Cowork |
| J5 | 2026-09-26 | P1 (tugas 3.4) | A — latihan terarah ke lantai berikutnya; spesifikasi di DESAIN §5.2 & Brief 3.4 (26 Sep 16:40) | pemilik |
| J6 | 2026-09-26 | P2 (M7/M8) | A — peri = kotak rekomendasi Yes/No; DESAIN §7.2 #6; tidak dibangun di Tahap 0 | pemilik |
| J7 | 2026-09-26 | P3 (tugas 3.4) | "Pura-pura latihan" TIDAK dibangun kecuali ditemukan dasar kanonnya (belum ketemu di ekstraksi; pemilik ingat ada — bila chapter ditemukan, dibuka ulang) | pemilik |

## TERBUKA (menunggu pemilik)
| # | Tanggal | Rujukan / tugas terdampak | Pertanyaan | Opsi | Default sementara |
|---|---|---|---|---|---|

## DIJAWAB — tambahan Cowork 26 Sep 18:55 WIB (ditulis di `main` saat PR #6 masih terbuka; putaran berikut: catat ke `docs/KEPUTUSAN.md` lalu hapus bagian ini)
| # | Tanggal | Rujukan | Jawaban | Sumber |
|---|---|---|---|---|
| J8 | 2026-09-26 | LAPORAN 2026-09-26c Q2 | **A** — roll sudden death hanya bila warning episode ini berumur ≥ `warnWindow.min` (3) hari. Alasan pemilik: kematian = ujung efek bola salju, bukan lonjakan sehari; hero bermental kuat mengatasi stresnya sendiri, yang lemah bisa minta rehat dari petualangan (§5.2/§6.9) — jendela itu harus ada | pemilik (18:23 WIB) |
| J9 | 2026-09-26 | LAPORAN 2026-09-26c Q5 | Δ guilt "pengakuan" (master menerima tuntutan) dan "ritual" (§6.10) TIDAK dikarang: angkanya diambil dari `docs/RISET_NPC_Kalibrasi_Empiris.md` (riset kalibrasi empiris Cowork, sedang berjalan) dan dimasukkan ke DESAIN §3.4 sebagai default [PSI-angka]. Sampai berkas itu ada di `main`: default sementara = opsi A laporan (tidak ada efek, tidak dibangun); jangan pakai opsi B (−20) | pemilik + Cowork |
| J10 | 2026-09-26 | RISET_NPC_Kalibrasi_Empiris §1/§8 | Pemilik menyetujui SEMUA usulan (Blok A + P-K1 A, P-K2 A, P-K3 C, P-K4 A, P-K5 A, P-K6 A, P-K7 A, P-K8 A, P-K9 A, P-K10 A, P-K11 B). DOCS BERUBAH: `docs/DESAIN_AI_NPC_V0.md` 26 Sep 2026 19:38 WIB (label [PSI-angka] di §1.2a, §2.2, §3.2–3.5, §4.3, §5.2, §6.7, §6.9, §6.10, §9, §10.2), `docs/Data_Strings_NONKANON.md` §12 `REQUEST_REST`, Brief 4.2 (resilien 55–70 %). Kode 2.2/2.4 yang memakai angka lama (cou_eff 0,3·xp; sensitisasi −3/−6 & jendela 3 hari; E≥65; vul 0,5/0,3/0,2; tarikan kebutuhan; ld; vacation; guilt +15…+30 & like −10; comfort ×1,4) disesuaikan di `NpcData` pada tugas berikut yang menyentuh modul itu atau paling lambat 4.4 — angka tuning hanya di Data, bukan logika | pemilik + Cowork |
| J11 | 2026-09-26 | J4 / Brief 2.3 × [PSI-angka] cou_eff 0,4·xp | **A** — kriteria J4 diganti: 1★ selisih cou_eff ke 3★ segar **≤4 setelah 15 misi, ≤2 setelah 20 misi** (= 0,4·(40 − xp)); ≤3 lama hanya berlaku untuk 0,3·xp. `experience.spec` disesuaikan bersamaan dengan penyesuaian `NpcData` (J10) — bukan melonggarkan test demi lulus. DOCS BERUBAH: Brief 26 Sep 2026 20:20 WIB (baris 2.3 ikut [PSI-angka]: −5/−10, jendela 5 hari, E≥58, 0,4·xp; baris 3.4 noise ±10) | pemilik (20:15) |
| J12 | 2026-09-26 | DESAIN §3.6 × §3.4 | **A** — Δlike TIDAK ditumpuk: a≥8 ke korban sintesis → −15 menggantikan −6; pengakuan +15/+8 menggantikan +10 tuntutan mogok bagi hero yang luka moralnya diakui; "luka moral −10" §3.6 = pemicu (c) saja. DOCS BERUBAH: DESAIN 26 Sep 2026 20:20 WIB (§3.6, §1.6a noise ±10, §8.2 cek pemulihan 5 hari) | pemilik (20:15) |
| J13 | 2026-09-26 | Pelengkap J10 (MEKANIS, Cowork) | Daftar lengkap penyesuaian kode 2.2–2.4 terhadap DESAIN 20:20, dikerjakan pada tugas yang menyentuh modulnya atau paling lambat 4.4, angka hanya di `NpcData`: Experience (0,4·xp; −5/−10; jendela 5 hari; E≥58) · Stress (vul 0,45/0,30/0,25; tarikan hanya <40 maks 8/hari; pulih ×0,6 bila rest<30; reaktivitas ×(1+vul/200); ld −0,5/hari, lantai 10, +8/episode patah maks 5; vacation −12/−4; dukungan ×1,5) · MoralInjury (guilt per kelas a +8…+16 & like −15, b +10…+20, c +10…+20 & like −10, d +15…+30; pengali A/C clamp 0,5–1,8; dihibur −5 maks 3×/episode; pengakuan −8/+15 ≤60 hari lalu 0/+8; ritual −3) · SuddenDeath (pengali ×2 hari 1–7 sejak kehilangan). Tugas 3.4 langsung memakai noise ±10 | Cowork |
