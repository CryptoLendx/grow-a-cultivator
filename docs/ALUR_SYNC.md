# ALUR SINKRON — Claude Code ↔ Claude Cowork

Terakhir diperbarui: 25 September 2026 (disetujui pemilik)

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
