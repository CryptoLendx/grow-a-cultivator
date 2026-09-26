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
