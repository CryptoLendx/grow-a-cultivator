# FORMAT `sheet.json` (artist → repo) — v1

Terakhir diperbarui: 25 September 2026 (tugas 1.6, CLAUDE_CODE_Brief_Tahap0 §B)

Dasar: VISUAL_2D §5 (record hero `{rig, layerId per slot, tint ×5}`, potret & sprite dari token yang sama, tint lewat `ImageColor3` pada lapisan grayscale, animasi lewat `ImageRectOffset`) dan RENCANA §3.7 (slot, kanvas 192×256 / 48×64, jangkar kaki, 12 frame). Contoh lengkap: `assets/sheet.example.json`.

**Label:** [FINAL] = sudah diputuskan di dokumen desain, ditegakkan skrip. (TERBUKA) = nilai contoh/usulan; artist & pemilik boleh mengubahnya di `sheet.json` tanpa mengubah kode.

## 1. Alur
1. Artist menyerahkan PNG + satu `sheet.json` (format ini) ke `assets/`.
2. Pemilik meng-upload PNG ke grup Roblox (Asset Manager) lalu mengisi `portraitAssetId` / `spriteAssetId` / `assetId` (0 = belum di-upload).
3. `python3 tools/sheet2luau.py assets/sheet.json --out src/ReplicatedStorage/Data` → menulis `AppearanceData.luau` & `SpriteData.luau` (jangan diedit manual). Bila `sheet.json` tidak valid, skrip menolak dan mencetak semua kesalahan.

## 2. Aturan gambar
| Aturan | Nilai | Label |
|---|---|---|
| Potret per lapisan hero | 1 PNG 192×256, semua lapisan sejajar di kanvas yang sama | [FINAL] |
| Sprite per lapisan hero | 1 PNG spritesheet, frame 48×64, **12 frame** dalam 1 baris (576×64), urutan frame = urutan animasi | [FINAL] |
| Lapisan yang diberi tint | **grayscale**; warna datang dari palet (`ImageColor3`) | [FINAL] |
| Jangkar hero | satu titik kaki `{x, y}` (piksel dari kiri-atas frame 48×64) dipakai semua lapisan | [FINAL] ada jangkar kaki · (TERBUKA) nilainya (contoh 24, 62) |
| Gambar hero gabungan | TIDAK dibuat/disimpan; hanya lapisan | [FINAL] CLAUDE.md |

## 3. Struktur `sheet.json`
```
{
  "formatVersion": 1,
  "hero":    { canvas, anchor, animations[], rigs[], slots[], layers[], palettes{} },
  "sprites": [ { id, category, file, assetId, frame, columns, frames, anchor, animations[] } ]
}
```

### 3.1 `hero`
| Field | Isi | Label |
|---|---|---|
| `canvas.portrait` | `{ "w": 192, "h": 256 }` | [FINAL] |
| `canvas.sprite` | `{ "w": 48, "h": 64, "frames": 12 }` | [FINAL] |
| `anchor` | `{ "x", "y" }` di dalam frame 48×64 | (TERBUKA) nilai |
| `animations[]` | `{ id, first, count, fps, loop }`; frame 1-based; harus menutup **tepat** frame 1–12 tanpa tumpang tindih. Contoh: idle 1–4, walk 5–8, attack 9–12 | (TERBUKA) pembagian & fps |
| `rigs[]` | id rig (huruf/angka/_), mis. `"m"`, `"f"` | (TERBUKA) daftar rig |
| `slots[]` | `{ id, depth, tint, required }` — `depth` makin besar makin di depan; `tint` = kanal default (`skin`/`hair`/`primary`/`secondary`/`accent`) atau `null`; `required` = setiap hero wajib punya lapisan di slot ini | (TERBUKA) urutan & kanal |
| `layers[]` | `{ id, slot, rigs?, tint?, portrait, sprite, portraitAssetId, spriteAssetId }` — `rigs` dihilangkan = cocok untuk semua rig; `tint` menimpa kanal slot (mis. list pakaian = `secondary`) | — |
| `palettes` | 5 kanal wajib, masing-masing daftar warna `"RRGGBB"` (hex tanpa `#`) | (TERBUKA) isi palet |

Slot contoh (VISUAL_2D §5: kulit · wajah · alis/mata · rambut-belakang · rambut-depan · pakaian · senjata · aura ★ · aksesori): `skin`, `face`, `eyes`, `hairBack`, `hairFront`, `clothes`, `weapon`, `aura`, `accessory`. Nama id slot/lapisan: huruf/angka/_ (contoh `hairFront_03`, `clothes_robe01_trim`).

### 3.2 `sprites[]` (musuh/boss/NPC/bangunan/VFX → `SpriteData`)
| Field | Isi |
|---|---|
| `id` | id unik (huruf/angka/_) — dipakai `EnemyData`/`FacilityData` dst. |
| `category` | `enemy` · `boss` · `npc` · `building` · `vfx` |
| `file`, `assetId` | nama PNG; asset id Roblox (0 = belum di-upload) |
| `frame` | `{ w, h }` ukuran satu frame (bebas per sprite) |
| `columns`, `frames` | jumlah kolom per baris di sheet; jumlah frame total |
| `anchor` | titik kaki/pijak di dalam frame |
| `animations[]` | seperti hero, tetapi tidak wajib menutup semua frame |

## 4. Validasi oleh `tools/sheet2luau.py`
Ditolak bila: `formatVersion` ≠ 1 · kanvas hero ≠ 192×256 / 48×64 / 12 frame · animasi hero tidak menutup tepat 1–12 atau tumpang tindih · jangkar di luar frame · id kosong/duplikat/bukan huruf-angka-_ · slot tidak dikenal · kanal tint tidak dikenal · slot `required` tanpa lapisan untuk salah satu rig · nama berkas bukan `.png` · assetId bukan bilangan bulat ≥ 0 · palet kosong atau warna bukan `RRGGBB` · kategori sprite tidak dikenal · animasi sprite di luar jumlah frame. Test: `python3 -m unittest tools/test_sheet2luau.py`.

## 5. Keluaran
- `Data/AppearanceData.luau`: `canvas`, `anchor`, `animations`, `rigs`, `slots`, `layers` (layerId → `{slot, rigs, tint, portraitAssetId, spriteAssetId}`), `palettes` — dipakai `Hero.new()`/`Hero/Appearance` (M1 5.3) untuk me-roll record `{rig, layers, tints}` (tint = indeks palet per kanal) dan oleh `Render/LayeredSprite` (M8). `tint = false` berarti lapisan tidak diwarnai.
- `Data/SpriteData.luau`: spriteId → `{category, assetId, frame, columns, frames, anchor, animations}`.
- Keluaran deterministik (kunci diurutkan), `--!strict` bertipe, lolos StyLua.
