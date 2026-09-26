# ALUR SINKRON — Claude Code ↔ Claude Cowork

Terakhir diperbarui: 26 September 2026, 22:46 WIB (disetujui pemilik)

Tujuan: Claude Code (repo) dan Claude Cowork (Project Knowledge + konektor GitHub repo ini) tetap selaras. Peran pemilik cukup meneruskan pesan pendek dan mengoreksi bila ada yang melenceng.

## Peran
| Pihak | Menulis | Membaca |
|---|---|---|
| Claude Code | kode, `docs/STATUS.md`, `docs/laporan/LAPORAN_SESI_*.md`, `docs/KEPUTUSAN.md` | semua `docs/` |
| Claude Cowork | dokumen desain di Project Knowledge; balasan keputusan `Qn: …` | repo lewat konektor GitHub (laporan, STATUS, KEPUTUSAN, kode) |
| Pemilik | meneruskan balasan Cowork ke Claude Code; menyinkronkan `docs/` bila dokumen desain berubah; memutuskan bila tidak setuju | — |

## Siklus per sesi
1. **Claude Code, awal sesi:** membaca `docs/KEPUTUSAN.md` lalu memeriksa tanggal "Terakhir diperbarui" dokumen yang disebut di prompt (Langkah 0). Dokumen yang tidak cocok dilaporkan, dan pekerjaan berhenti.
2. **Claude Code, akhir sesi:**
   - Menulis `docs/laporan/LAPORAN_SESI_<YYYY-MM-DD>_wkN.md` (7 bagian tetap: ringkasan · langkah 0 · hasil per butir · angka test · temuan · pertanyaan Q · belum diverifikasi/berikutnya).
   - Commit dan push ke branch PR sesi itu.
   - Memberi pemilik tautan laporan dan satu prompt pendek untuk Cowork.
3. **Cowork:**
   - Membaca laporan dari repo, termasuk dari branch PR bila belum di-merge.
   - Menjawab setiap Q dalam satu blok siap-tempel: `Q1: A` … `Qn: setuju default`, plus alasan singkat bila menyimpang dari rekomendasi.
   - Menyebutkan dokumen `docs/` mana yang ikut berubah (nama berkas + tanggal baru), bila ada.
4. **Pemilik:** menempel blok itu ke Claude Code, bersama prompt tugas berikutnya.
5. **Claude Code:** mencatat keputusan ke `docs/KEPUTUSAN.md` (tanggal, Qn, keputusan, sumber) sebelum mengerjakan tugas baru.

## Aturan pertanyaan (Claude Code)
- Hanya keputusan desain/kanon/prioritas milik pemilik yang ditanyakan. Hal yang sudah jelas dari docs langsung dikerjakan dan dicatat sebagai **ASUMSI** di laporan.
- Setiap pertanyaan diberi nomor `Qn`, opsi A/B/…, dan satu rekomendasi default beserta alasan singkat.
- Nomor Q berlaku per laporan. Rujukan lintas sesi memakai `LAPORAN <tanggal> Qn`.
- Keputusan yang sudah ada di `docs/KEPUTUSAN.md` tidak ditanyakan ulang.

## Batas sesi & hemat token
Siklus normal: **Code → Cowork → Code**. Riwayat chat bukan tempat menyimpan konteks; repo yang menyimpannya.
- **Claude Code:** satu sesi = satu siklus. Setelah laporan ditulis, sesi selesai. Siklus berikutnya = sesi BARU dari `main` (membaca CLAUDE.md, `docs/KEPUTUSAN.md`, `docs/STATUS.md`, laporan terakhir). Melanjutkan sesi lama hanya bila sesi itu pendek dan belum pernah auto-compact.
- **Claude Code memperingatkan & berhenti** di batas butir yang bersih bila: konteks pernah dipadatkan otomatis, sudah membaca ≥3 dokumen besar `docs/` penuh, atau butir berikutnya butuh baca ulang dokumen besar. Sisanya masuk laporan sebagai langkah berikutnya.
- **Laporan bagian 7** wajib memuat blok `PROMPT SESI BERIKUTNYA` siap-tempel: tugas berikut, Langkah 0 (tanggal docs), dan tempat menempel balasan `Qn` dari Cowork. Pemilik cukup menempel: prompt itu + blok Q dari Cowork.
- **Cowork:** satu chat boleh melayani beberapa siklus; Cowork memberi tahu saat chat panjang dan menyertakan prompt chat baru (Project Knowledge `PROMPT_Chat_Berikutnya_Tahap0.md`). Tiap chat baru menyambung ulang repo ini.
- **Baca hemat:** baca bagian docs yang dirujuk tugas, bukan seluruh dokumen, kecuali tugas menuntut.

## Mode otomatis (scheduled task tiap jam) [disetujui pemilik 26 Sep 2026]
Tiap putaran = sesi Claude Code BARU dari `main`, tanpa pemilik. Satu putaran = satu tugas brief §B. Koordinasi dengan Cowork hanya lewat repo:
- `docs/PERTANYAAN_PEMILIK.md` = antrean keputusan milik pemilik. Cowork/pemilik menulis jawaban di sana (status DIJAWAB); putaran otomatis memindahkannya ke `docs/KEPUTUSAN.md` (sumber "pemilik/Cowork") lalu menghapusnya dari antrean.
- Cowork meng-commit koreksi `docs/` langsung ke `main` dan menyinkronkan Project Knowledge saat pemilik membuka chat ("sinkron").

### Urutan tiap putaran
0. **Kunci & rem.** Berhenti tanpa mengerjakan apa pun bila: ada berkas `docs/AUTO_PAUSE`; ada PR terbuka berjudul `[WIP auto]` yang dibuat < 3 jam lalu (putaran lain masih jalan — yang ≥ 3 jam dianggap macet: tutup dengan komentar lalu lanjut). **Tanpa GitHub API** kunci = branch `auto/<YYYY-MM-DD-HHMM>` (waktu UTC) yang belum ada di `main`: SELESAI (ada commit `docs/laporan/` sesudah commit `auto: kunci` terakhirnya) = bukan kunci; tanpa laporan & <3 jam = BERJALAN → berhenti; tanpa laporan & ≥3 jam = MACET → diabaikan (hapus branch diblokir proxy; dicatat sekali bila berisi commit kerja). **Rantai:** ≥6 branch SELESAI yang belum di-merge ke `main` → berhenti (menunggu sinkron) (Cowork 26 Sep 22:46); `docs/PERTANYAAN_PEMILIK.md` punya ≥ 5 pertanyaan TERBUKA; semua tugas §B minggu 1–6 selesai. Setelah lolos, langsung buat branch + draft PR `[WIP auto] …` sebagai kunci.
1. **Terapkan jawaban** berstatus DIJAWAB di `docs/PERTANYAAN_PEMILIK.md` → `docs/KEPUTUSAN.md` (+ ubah kode bila perlu).
2. **Review PR sebelumnya** (PR terbuka tertua dari sesi manual atau `[auto]`): baca bagian 6 laporannya; tiap Qn diklasifikasi:
   - **MEKANIS** (kriteria/angka tes yang disesuaikan dengan rumus docs, penamaan, format simpan, penanda runtime, ASUMSI teknis) → jawab = rekomendasi laporan, catat di `docs/KEPUTUSAN.md` dengan sumber "auto (rekomendasi)"; koreksi teks Brief §B bila perlu (naikkan "Terakhir diperbarui").
   - **DESAIN** (mengubah keputusan FINAL / DESAIN §10.1, menambah atau mengubah perilaku hero yang dirasakan pemain, angka TERBUKA di luar default docs, tafsir kanon) → JANGAN diputuskan: tulis ke `docs/PERTANYAAN_PEMILIK.md` (TERBUKA, opsi, default sementara); kode tetap memakai default rekomendasi yang sudah bertanda ASUMSI.
3. **Tanpa merge ke `main`** (pengaman izin sesi menolak push merge ke main, 26 Sep 21:04/22:04). Putaran bekerja **bertumpuk**: branch kerja dibuat dari ujung rantai = branch SELESAI terbaru yang belum ada di `main` (tidak ada → `origin/main`), lalu `git merge origin/main` ke branch kerja (membawa koreksi docs Cowork); suite harus lulus sebelum tugas dimulai; konflik/gagal → catat di `docs/PERTANYAAN_PEMILIK.md` di branch kerja, push, berhenti. Rantai di-merge ke `main` oleh Cowork/pemilik saat "sinkron" setelah audit.
4. **Kerjakan tugas berikutnya** (urutan brief §B). Tugas yang bergantung pada pertanyaan DESAIN TERBUKA tanpa default di docs → lewati ke tugas independen berikutnya; tidak ada → berhenti. Yang butuh PC/Studio (TestEZ Studio, `Profile.open`) dicatat, tidak ditunggu.
5. **Akhir:** STATUS + laporan 7 bagian → ubah judul PR menjadi `[auto] wkN X.Y …`, tandai ready, **jangan merge** (di-merge Cowork/pemilik saat "sinkron").

### Larangan mode otomatis
- Mengubah angka TERBUKA hanya supaya metrik §9/test lulus — laporkan saja.
- Mengubah keputusan di `docs/KEPUTUSAN.md`, §0/§10.1 DESAIN, atau isi `DESAIN_*` selain koreksi MEKANIS.
- Menyentuh `Combat/`, `Tower/`, `sim/combat_*`.
- Lebih dari satu tugas §B per putaran.

### Perawatan (sekali)
- Bila `roblox.yml` (std selene) belum ada di repo: generate sekali, commit, dan pakai itu — jangan membangun ulang selene tiap sesi.
