# STATUS — Tahap 0

Satu baris per commit (CLAUDE.md "Cara kerja per sesi" #4). Pemilik menyalin berkas ini ke Project Knowledge.

Lingkungan verifikasi (sesi cloud, tanpa Roblox Studio): rojo 7.4.4 · selene 0.28.0 · stylua 2.0.2 · luau-lsp 1.53.0 · lune 0.8.9. `run-in-roblox` tidak bisa jalan tanpa Studio → test dijalankan headless dengan `lune run tools/testrunner.luau` (subset API TestEZ, pohon Instance tiruan dari `default.project.json`). `wally install` TIDAK bisa diverifikasi di sesi ini (api.wally.run diblokir jaringan); nama paket dicek manual di wally-index.

| Tugas | Commit | Ringkasan hasil & angka |
|---|---|---|
| 1.1 | wk1: repo | `default.project.json` (src/ReplicatedStorage, src/ServerScriptService, tests→ServerStorage.Tests, Packages/DevPackages/ServerPackages opsional), `wally.toml` (ProfileStore 1.0.3, TestEZ 0.4.1), selene/stylua, `.gitignore`, `CLAUDE.md` = §A verbatim, `tests/run.server.luau`, runner headless `tools/testrunner.luau`. `rojo build -o build/test.rbxl` sukses; `selene src tests` 0 error 0 warning; `stylua --check` bersih; test kosong 1/1 lulus; kontrol negatif (spec sengaja gagal) → exit 1. |
