# LAPORAN SESI — 26 Sep 2026 (WIB) — keputusan Q1–Q11 + tugas 2.2

Branch `claude/charming-goodall-6bpd8i` (dari `main` 87ef8d0) · PR belum dibuat · alur sinkron: `docs/ALUR_SYNC.md`

## 1. Ringkasan
- Balasan LAPORAN 2026-09-25 Q1–Q11 sudah dicatat ke `docs/KEPUTUSAN.md`.
- Keputusan yang berdampak pada kode sudah diterapkan: Q8 (pindah ke ServerStorage), Q4 (likeability awal), Q3 (persentil leader), Q11 (4 string [K]), serta komentar untuk Q1, Q2, dan Q6.
- Tugas 2.2 `Autonomy/Traits.luau` selesai. Total 5 commit di sesi ini, semua sudah di-push.
- Sesi berhenti di batas 2.2, karena tugas 2.3 perlu membaca DESAIN_AI_NPC §2–§3 (aturan batas sesi).

## 2. Langkah 0 — tanggal dokumen
Ketiga dokumen yang disebut cocok dengan `main` 87ef8d0:
- DESAIN_AI_NPC_V0: 26 Sep, 00:46 WIB.
- CLAUDE_CODE_Brief_Tahap0: 26 Sep, 01:00 WIB.
- Data_Strings_K_Lengkap: 26 Sep, 00:46 WIB.

CLAUDE.md identik dengan §A brief.

## 3. Hasil per butir
- **KEPUTUSAN:** 11 baris baru (Q1–Q11) dengan tanggal 2026-09-26.
- **Q8:**
  - `NpcData` dan `IdioData` kini berada di `src/ServerStorage/Data/`. `default.project.json` → ServerStorage `$path: src/ServerStorage` + `Tests`.
  - `rojo sourcemap` mengonfirmasi keduanya tidak lagi ada di ReplicatedStorage.
  - Spec diperbarui ke `ServerStorage.Data`.
- **Q4 / Q3:**
  - `likeability.initial = 50` (TERBUKA).
  - `groups.leaderFloorPercentile = 80` (TERBUKA, kalibrasi 4.4).
  - Keduanya diuji di `npcdata.spec`.
- **Q11:** 4 string [K] ch.65 ditambahkan secara verbatim: `ROOM_HEADCOUNT`, `FLOOR_ASSIGN_PARTY`, `FLOOR_ASSIGN_NAMES`, `FLOOR_ASSIGN_REST`. Diuji dengan contoh kanon persis. Total string sekarang 116.
- **2.2 `Traits`:**
  - `roll(rng, star, {origin, batch, giftCount?})` menghasilkan:
    - 7 dimensi dengan rumus `clamp(round(N(μ,15)), 0, 100)`. μ = 50, kecuali μ C = 45/50/55 per ★. `cou` tidak bergantung ★ (§1.2).
    - 1–2 goal dengan bobot sifat §1.3 (`goalWeights`).
    - Idiosinkrasi per kategori dari `IdioData.counts`.
    - 2 tag.
  - `drift(traits, {profileSeed, heroId}, kind, rng)` mengembalikan state baru dan event `traitDrift`, dengan Δ ≤ ±5 dan clamp 0–100.
  - `encode`/`decode` ke field pendek §1.6.
- **IdioData:** komentar "urutan daftar = format simpan; tambah hanya di akhir". Alasannya, `encode` menyimpan indeks.
- **ASUMSI** (dikerjakan dari docs, dicatat di sini):
  1. `tg` = `{origin, batch}` diambil dari input summon (HeroData/sesi summon di M1 5.1), bukan di-roll.
  2. GiftData belum ada (M1 5.1). Katalog gift masuk lewat `giftCount`. Bila tidak ada katalog, gift dibiarkan kosong.
  3. Semua id disimpan sebagai indeks 1-based. `gd` disimpan sebagai angka tunggal, `fd = {favIdx, hatedIdx}`.
  4. `xp` seed per ★ tidak di-roll di `Traits`, melainkan di tugas 2.3 (brief 2.3 memuatnya).
  5. Fixture `tests/profile.spec.luau` masih memakai `fd = 5` (bentuk lama). Fixture ini tidak diubah karena di luar tugas; perlu disesuaikan di M1 5.3 saat byte dihitung ulang.

## 4. Angka test (runner Lune, belum Studio)
- **Seluruh suite:** 51 lulus, 0 gagal (8 spec). `traits.spec` 12/12.
- **Statistik roll** (10.000 roll per ★, untuk ★ 1/2/3/5):
  - Mean 49,68–50,31. Mean C per ★: 44,88 / 50,10 / 55,19 / 54,88.
  - σ 14,75–15,32.
  - Nilai ekstrem <10 atau >90: 0,68–0,80 % (batas 2,5 %).
- **Goal:** goal kedua muncul 40 % ± 2. Frekuensi goal pertama sama dengan Σ peluang bobot (dalam ±4σ).
- **Encode/decode:** encode→decode identik 10.000/10.000. Ukuran `tr+gl+id+tg` = 94–108 byte JSON.
- **Drift:** diuji pada 2.000 hero × 5 peristiwa. |Δ| ≤ 5, hero tidak-plastis tidak bergeser sama sekali, porsi plastis 50 % ± 5.
- **Kinerja:** 10.000 roll ≈ 242 ms.
- **Kontrol negatif:** 7/7 tertangkap (μ C, σ, batas drift, `fd` tertukar, plastisitas, goal ganda, bobot goal). Kontrol tipe luau-lsp 1/1.
- **Alat:** luau-lsp strict 0 error · selene 0/0 · StyLua bersih · `rojo build` sukses.

## 5. Temuan
- **F1 — jumlah idiosinkrasi:** setelah Q2 (`fd` = 2 item), total per hero menjadi **6–8**: gift 2–3 + makanan 2 + hobi 1 + kebiasaan 1 + keengganan 0–1. DESAIN §1.4 menulis "5–7". Lihat Q1.
- **F2 — lint di cloud:** biner resmi selene kembali menolak CA proxy saat `generate-roblox-std`. Kali ini selene 0.28.0 dikompilasi dari crate dengan fitur `ureq/native-certs` hanya untuk membuat `roblox.yml`. Lint tetap dijalankan dengan biner resmi.
- **F3 — tipe:** luau-lsp 1.53.0 melebarkan elemen `table.freeze({...})` bertipe union literal menjadi `string` di modul pemanggil. Karena itu test memakai anotasi `kind: Traits.DriftKind`. Tidak berdampak pada runtime.

## 6. Pertanyaan (balas dengan format `Qn: A/B/…` atau `Qn: setuju default`)
| # | Pertanyaan | Opsi | Rekomendasi |
|---|---|---|---|
| Q1 | F1: total idiosinkrasi per hero sekarang 6–8, sedangkan docs §1.4 menulis "5–7 item". | A: koreksi docs menjadi "6–8 item" · B: gift favorit tetap ×1 supaya total 5–7 | **A** (mengikuti katalog §1.4 dan keputusan Q1/Q2 sebelumnya) |
| Q2 | "50 % hero tidak bergeser sama sekali" (§1.2). Saya menerapkannya **per hero** (tetap seumur hidup, diturunkan dari `profileSeed`+`heroId`, 0 byte), bukan per peristiwa. | A: per hero · B: roll 50 % setiap peristiwa | **A** (kata "sama sekali"; RISET Bühler: sebagian orang tidak berubah) |
| Q3 | Apakah erosi isolasi (E +1/30 hari, O −1/60 hari) dan stagnasi (C −1/minggu, §6.11) juga tunduk pada roll plastisitas itu? Saat ini tidak: keduanya berlaku untuk semua hero. | A: berlaku untuk semua hero · B: ikut plastisitas | **A** (kanon Aaron: isolasi mengikis siapa pun) |
| Q4 | Keengganan "×0–1": peluang hero punya 1 keengganan tidak disebut. Saat ini 50 % (hitungan seragam 0–1), TERBUKA. | A: 50 %, kalibrasi 4.4 · B: pemilik isi angka lain | **A** |

## 7. Belum diverifikasi / langkah berikutnya
- TestEZ di Studio belum dijalankan untuk commit sesi ini (`tests/run.server.luau`, lalu tempel output ke PR). `Profile.open` masih ditunda ke 5.4.
- PR belum dibuat. Buat PR dari `claude/charming-goodall-6bpd8i` bila pemilik setuju.
- Berikutnya: tugas 2.3 `Autonomy/Needs.luau` + `Mental/Stress.luau` (+ `xp`/`cou_eff`).

```
PROMPT SESI BERIKUTNYA
Mulai sesi baru dari main (setelah PR sesi 26 Sep di-merge; bila belum, dari branch claude/charming-goodall-6bpd8i).
Langkah 0: cocokkan "Terakhir diperbarui" — DESAIN_AI_NPC_V0.md (26 Sep 2026, 00:46 WIB atau lebih baru bila Q1 dikoreksi),
CLAUDE_CODE_Brief_Tahap0.md (26 Sep 2026, 01:00 WIB). Bila tidak cocok: laporkan dan berhenti.
Catat balasan Qn di bawah ke docs/KEPUTUSAN.md sebelum mulai.
Tugas: brief §B 2.3 — Autonomy/Needs.luau + Mental/Stress.luau (vul, st, ld, ambang patah, sumber/penurun §3.3,
likeability §3.6, xp §1.2a + cou_eff); baca DESAIN_AI_NPC §1.2a, §2, §3 saja. Test dulu sesuai kolom Verifikasi 2.3.
Akhir sesi: STATUS + laporan 7 bagian + push.

Balasan LAPORAN 2026-09-26 (tempel di sini):
Q1: …
Q2: …
Q3: …
Q4: …
```
