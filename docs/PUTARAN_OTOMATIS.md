# PUTARAN OTOMATIS — instruksi lengkap (dibaca scheduled task tiap jam)

Terakhir diperbarui: 26 September 2026, 22:58 WIB

Berkas ini diubah hanya oleh Cowork/pemilik di `main`. Prompt scheduled task cukup menyuruh membaca berkas ini, sehingga perubahan aturan tidak perlu ditempel ulang ke scheduled task. Putaran otomatis TIDAK mengubah berkas ini.

Tidak ada pemilik yang menunggu: jangan bertanya, jangan menunggu jawaban.

## Batas izin
Putaran boleh: membuat branch kerja `auto/<YYYY-MM-DD-HHMM>` (waktu UTC) dan push ke branch itu; me-merge `origin/main` dan branch `auto/*` putaran sebelumnya KE DALAM branch kerja sendiri; membuat/mengubah judul/menandai ready PR milik putaran ini bila GitHub API ada. Putaran TIDAK push ke `main`, TIDAK me-merge ke `main`, TIDAK menghapus branch — pengaman izin sesi menolaknya ("Merge Without Review") dan proxy memblokir hapus branch. Pekerjaan masuk `main` lewat "sinkron" Cowork/pemilik. Aksi yang ditolak pengaman izin: jangan cari jalan pintas; selesaikan sisanya, lalu kirim notifikasi ke pemilik.

## Akses GitHub (git murni; API absen BUKAN alasan berhenti)
- Ambil semua: `git fetch origin main '+refs/heads/auto/*:refs/remotes/origin/auto/*'`.
- Golongkan tiap `origin/auto/*` yang head-nya BELUM ada di `origin/main` (`git merge-base --is-ancestor <head> origin/main` gagal). L = commit terakhir di branch itu yang pesannya diawali `auto: kunci`.
  - **SELESAI**: `git log L..origin/<b> -- docs/laporan/` tidak kosong.
  - **BERJALAN**: bukan SELESAI dan umur (dari nama branch, UTC) < 3 jam.
  - **MACET**: bukan SELESAI dan umur ≥ 3 jam → abaikan; bila berisi commit kerja selain kunci, catat sekali di `docs/PERTANYAAN_PEMILIK.md` (TERBUKA) bila belum tercatat.
- Ujung rantai = branch SELESAI dengan nama terbaru; tidak ada → `origin/main`.

## Urutan
0. **Rem** (paling awal, tanpa membaca dokumen lain). Berhenti dengan satu kalimat alasan, tanpa commit, bila: ada `docs/AUTO_PAUSE` (di ujung rantai atau `origin/main`); ada branch BERJALAN; ≥ 6 branch SELESAI belum ada di `main`; `docs/PERTANYAAN_PEMILIK.md` di ujung rantai punya ≥ 5 pertanyaan TERBUKA; semua tugas §B minggu 1–6 selesai.
1. Buat branch kerja dari ujung rantai, commit kosong `auto: kunci putaran <waktu UTC>`, push (= kunci). Lalu `git merge origin/main` ke branch kerja. Konflik → batalkan merge, catat di `docs/PERTANYAAN_PEMILIK.md` (TERBUKA), commit, push, berhenti.
2. Pasang lune 0.8.9 dari rilis GitHub bila belum ada; jalankan `lune run tools/testrunner.luau`. Ada yang gagal → catat di `docs/PERTANYAAN_PEMILIK.md`, commit, push, berhenti.
3. Baca `CLAUDE.md`, `docs/ALUR_SYNC.md` bagian "Mode otomatis", `docs/PERTANYAAN_PEMILIK.md` (SEMUA bagian) dan `docs/KEPUTUSAN.md`. Ikuti "Mode otomatis" langkah 1, 2, 4, 5 dan semua larangannya: catat semua jawaban DIJAWAB ke KEPUTUSAN lalu hapus dari PERTANYAAN_PEMILIK; klasifikasi Qn laporan putaran sebelumnya yang belum diklasifikasi (MEKANIS → KEPUTUSAN sumber "auto (rekomendasi)"; DESAIN → PERTANYAAN_PEMILIK TERBUKA); kerjakan paling banyak SATU tugas brief §B berikutnya (`docs/CLAUDE_CODE_Brief_Tahap0.md`), baca hanya bagian dokumen yang dirujuk tugas itu. Tugas 4.4 hanya bila `docs/DESAIN_AI_NPC_V0.md` memuat label [PSI-angka].
4. Akhir: laporan 7 bagian di `docs/laporan/`, `docs/STATUS.md`, commit, push branch kerja. Bila API ada: judul PR `[auto] wkN X.Y …`, ready, TIDAK di-merge.
5. Pesan penutup satu baris: tautan PR atau tautan compare `https://github.com/CryptoLendx/grow-a-cultivator/compare/main...auto/<nama>?expand=1` + jumlah branch SELESAI yang belum di-merge + jumlah pertanyaan TERBUKA.
