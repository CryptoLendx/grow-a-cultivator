# Raise a Cultivator — Roblox (Rojo) — CLAUDE.md

## Apa proyek ini
Game Roblox gacha-simulation tema wuxia, 100 % mekanik kanon novel "Pick Me Up". 2D landscape tampak 3/4 isometrik (sprite berlapis), mobile-first. Pemain = Master; hero = NPC otonom dengan sifat/kebutuhan/relasi (simulasi, TANPA LLM runtime); permadeath tanpa revive. Spesifikasi lengkap ada di `docs/` — BACA `docs/DESAIN_SISTEM_V0.md` §3, §5, §6 dan `docs/DESAIN_AI_NPC_V0.md` sebelum menyentuh modul terkait. Jangan mendesain ulang: angka bertanda (TERBUKA) diisi default dari docs + komentar `-- TERBUKA`, bukan dikarang.

## Keputusan final (jangan ditawar)
- Tanpa LLM runtime, tanpa HttpService ke API AI.
- Catch-up saat login (bukan server persisten): `Autonomy.catchUp(profile, nowUtc)`; Δt maks 7 hari Bumi; 1 hari Bumi = 3 hari in-game.
- Penyimpanan terpecah: key `core` / `heroes_N` (≤1.000 hero/key) / `archive_N` / `replays` / `mail`, semua dengan `schemaVersion`; migrasi skema + test sejak M1; hero ≤900 byte JSON.
- Nilai tersembunyi (sifat, kebutuhan, stres, relasi, likeability, talenta) TIDAK pernah lewat Remotes atau tampil sebagai angka.
- Semua RNG lewat `Shared/Rng.luau` berseed; tidak ada `math.random` langsung.
- Semua angka tuning hanya di `ReplicatedStorage/Data/*.luau` (tabel murni, tanpa logika). Pesan sistem hanya di `Data/Strings.luau` (verbatim EN kanon; string non-kanon diberi komentar `-- NONKANON`).
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

## Jangan
- Jangan menyimpan gambar hero gabungan; hanya record `{rig, layers, tints}`.
- Jangan autosave < 60 detik atau menulis key >2 MB.
- Jangan membuat UI final; placeholder fungsional saja (M8 nanti).
