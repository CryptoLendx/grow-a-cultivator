# DESAIN SISTEM V0 — SPESIFIKASI DATA 100% KANON "PICK ME UP" [base tunggal: kanon; tanpa fitur orisinal]

Terakhir diperbarui: 24 September 2026, 09:40 WIB

## 0. CARA MEMBACA BERKAS INI

**Prinsip pemilik [FINAL, jangan dibuka ulang]:** semua sistem = mekanik kanon novel *Pick Me Up* (ensiklopedia `claude/KANON_PMU_00_Indeks.md` + bab 01–07). Tidak ada fitur orisinal, tidak ada adjustment sadar. Tema wuxia hanya kulit nama/visual → kolom **"nama tampil"**. Konsep D, permadeath murni, monetisasi 6 gamepass (menjual gems & gold), visi endgame (KONSEP §11) tetap.

**Label per angka/aturan:** [K] teks sistem verbatim · [N] narasi/dialog · [INF] inferensi (dasar disebut) · [ch.N] sitasi chapter. Default desain = [K] > [N] > [INF].

**Tag lingkup:** [V0] = kanon membukanya sebelum akun Lv.20 / lantai 30 → dibangun untuk launch · [V1+] = kanon membukanya di Lv.20+/F30+ (rift, cafe, PvP, airship, guild, ruins, imprint/advent 4★+, promosi 5★+) → strukturnya dicatat, tidak dibangun.

**(TERBUKA)** = kanon tidak menyebut angkanya → diisi lewat playtest/simulasi saat build, BUKAN dikarang sebagai kanon. **(TERBUKA: C#)** = konflik kanon C1–C8 (Indeks); default yang dipakai = versi [K]/dominan, pemilik boleh menukar.

**Pemetaan lingkup V0 per account level (kanon: account level = lantai tertinggi, [K] ch.88):**
| Lantai | Yang kanon buka | Lingkup |
|---|---|---|
| 5 | daily dungeon | [V0] |
| 10 | exploration dungeon (Advent Stone), nama waiting room dikunci, promosi terbuka, Advent Dungeon | [V0] (imprint/advent 4★+ = [V1+]) |
| 20 | rift, Dimensional Cafe, Trading Board, exploration dungeon ke-2, fasilitas tambahan, cadet Niflheim | [V1+] |
| 30 | "full-fledged master", daily dungeon baru, exploration ke-3, sektor berubah, Ruins | [V1+] (tower V0 berhenti di 30) |
| 40 | death protection berakhir, promosi 4★, airship, Ruin tier 40 | [V1+] |

---

## 1. AKUN, WAKTU, MATA UANG (rujukan: KANON_PMU_01)

### 1.1 Identitas & premis (kulit)
| Kanon | Nilai kanon | Nama tampil (wuxia) | Label | Sitasi |
|---|---|---|---|---|
| Master | pemain; mengendalikan dari "control window", tidak bertarung | Patriarch / Guru Besar sekte | [N] | ch.155, 157 |
| Hero | manusia asli dari dunia lain, berpikir & merasa otonom (Quantum AI), mati permanen (Hardcore Mode) | Murid | [K]/[N] | ch.1, 12 |
| Waiting room ("room") | tempat hero berkumpul; 1 akun = 1 room + 1 tower + 1 fairy | Paviliun Sekte | [K]/[N] | ch.3, 335, 43 |
| Fairy (Isel) | pemandu per akun; menindak hero yang membangkang perintah pertama / menyerang master | Roh Penjaga Paviliun | [N] | ch.8, 66, 126 |
| Tower 100 lantai | struktur progres utama | Menara Langit | [N] | ch.259 |
| Goddess | hero mati "returned to the arms of the goddess" | "kembali ke pangkuan Dewi" | [K] | ch.7, 16 |

### 1.2 Pembuatan akun & tutorial [V0] — urutan kanon dipertahankan
| Langkah | Isi kanon | Angka | Label | Sitasi |
|---|---|---|---|---|
| 1 | Nama master unik ("Available name. Do you want to use it?") | — | [K] | ch.335 |
| 2 | Prolog teks 7 baris (Niflheim dikuasai hantu → "Climb the tower if you want to save the world!") | 7 baris | [K] | ch.335 |
| 3 | Tutorial Quest 1: kalahkan goblin yang menyerang desa; pertarungan otomatis | — | [K] | ch.3 |
| 4 | Tips "Heroes sometimes panic" + tawaran anti-fear potion | 50 gems, gratis 1× | [K] | ch.3 |
| 5 | "Stage cleared! Rewards → mailbox"; MVP ditampilkan | — | [K] | ch.4 |
| 6 | Tutorial sintesis: drag-drop hero tumbal ke target; tips favorit mencegah salah sintesis | — | [K] | ch.4–5 |
| 7 | Tutorial summon: tombol [Summon] / [Advanced Summon] | 10.000 G / 500 gems | [K] | ch.6 |
| 8 | Free 10-draw | 10 hero | [K]/[N] | ch.6, 17 |
| 9 | Tutorial party: drag-drop, "Open the space-time!" | — | [K] | ch.7 |
| 10 | Reward tutorial | 500 gems | [N] | ch.7 |
| 11 | Tawaran bangun fasilitas pertama (Training Center) | 500 gems; patch: fasilitas pertama GRATIS | [K] | ch.8, 244 |
| 12 | Tips istirahat, tips autonomous action | — | [K] | ch.8, 12 |
| 13 | Setelah lantai 4: pop-up rekrut + 2 Advanced Summon Ticket gratis (patch newbie) | 2 tiket; summon berikutnya 500 gems | [K] | ch.243–244 |
| — | Reroll akun / hapus akun sukarela | TIDAK KETEMU ch.1–400 | (TERBUKA) | — |

Konvensi UI kanon: dialog Yes/No dengan opsi default ditandai "(optional)" [K] ch.3, 243.

### 1.3 Login, logout, offline [V0]
| Aturan | Nilai | Label | Sitasi |
|---|---|---|---|
| Layar login | "Welcome to Pick Me Up!" → "Loading has finished." → "TOUCH!" → waiting room; fairy muncul | [K] | ch.9, 127 |
| Logout | konfirmasi "terminate the connection to the master?" → "Then, goodbye!" | [K] | ch.5 |
| Saat offline | waktu in-game berjalan; hero bertindak otonom; daily dungeon bisa dimasuki hero sukarela; main dungeon (tower) TERKUNCI tanpa master | [N] | ch.12, 25, 48, 207 |
| Rekaman misi | otomatis ("Recording the mission…"); video misi terlewat bisa ditonton di menu; hero bisa meminta lihat rekaman | [K] | ch.110, 194, 108 |
| Screenshot/galeri | tombol kamera, galeri | [K] | ch.50, 63 |
| Rasio waktu Bumi : in-game | **default 1 : 3** (5 sitasi) · alternatif 1 : 36 (ch.248) | [N] | (TERBUKA: C1) ch.9, 23, 50, 137, 213 |
| Rasio waiting room : dungeon | misi ≈3× lebih cepat dari waiting room | [N] | ch.137 |
| Hero menua | tidak menua di waiting room | [N] | ch.90 |

### 1.4 Account level & unlock [V0 s.d. lantai 30]
Account level = lantai tertinggi yang dicapai [K] ch.88 (default; alternatif "master level ≠ lantai" ch.178/221 → (TERBUKA: C2)). Tabel lingkup di §0. Nama waiting room dikunci saat lantai 10 [K] ch.25.

### 1.5 Mata uang [V0]
| Mata uang kanon | Nama tampil | Sumber kanon | Kegunaan kanon | Label | Sitasi |
|---|---|---|---|---|---|
| **Gold (G)** | Tael Perak | reward stage, daily dungeon, kompensasi, mail, paket | summon biasa, gift shop, dekor, bekal eksplorasi, mock battle | [K]/[N] | ch.6, 11, 16, 128 |
| **Gems** | Batu Roh Langit | tutorial 500, kompensasi, paket cash (→ gamepass/dev product), gem gratis ≈1.000 per 10 hari (langka) | advanced summon, fasilitas, riset, battle shop, skill book | [K]/[N] | ch.7, 15, 46, 53 |
| Gift certificate | Surat Berharga | paket cash | ditukar gems/gold; bisa dihadiahkan | [K] | ch.46, 49 |
| Soul stone (Low/Intermediate/Advanced) | Batu Jiwa | Conversion Station (hero mati/hidup), mail | promosi 3★+, sintesis upgrade stone | [K] | ch.86, 107, 126 |
| Upgrade stone (Low/Intermediate/Advanced) | Batu Penempaan | sintesis attribute + soul stone; mail | promosi bintang | [K] | ch.86, 107 |
| Attribute stone | Batu Elemen | drop daily dungeon | sintesis, promosi | [K] | ch.24, 41 |
| Advent Stone (Lesser→…) | Batu Kedatangan | exploration dungeon (Lv.10) | Advent Dungeon (imprint) | [K]/[N] | ch.41 |
| Advanced Summon Ticket | Tiket Pemanggilan | event newbie (2×) | summon gratis | [K] | ch.241, 244 |
| Research point | Poin Kajian | personel lab 10/jam | naik level riset | [K] | ch.53, 64 |
| Jewel, Interference power, Karma, event points | — | Ruins/PvP/Festa/endgame | — | — | [V1+] |

### 1.6 Harga in-game kanon [V0] (default; nilai relatif dipertahankan)
| Item | Harga | Label | Sitasi |
|---|---|---|---|
| Summon biasa ×1 / ×10 | 10.000 G / 100.000 G | [K] | ch.6 |
| Advanced Summon ×1/×3/×5/×10 | 500 / 1.500 / 2.500 / 5.000 gems (tanpa diskon) | [K] | ch.6, 26, 48 |
| Anti-fear potion | 50 gems | [K] | ch.3 |
| Training Center · Blacksmith | 500 gems masing-masing | [K] | ch.8, 12 |
| Riset | 10 gems/jam (default 3 jam/hari = 30 gems) | [K] | ch.53, 64 |
| Skill Book (battle shop) | 500 gems | [K] | ch.40 |
| Emergency recovery potion (battle shop) | 500 gems, 1×/misi | [K] | ch.200 |
| Cheering stick / high-quality / dragon glow | 50 / 100 / 100 gems per pakai | [K] | ch.120, 143, 201 |
| Bekal eksplorasi | rekomendasi 3.000 G/orang | [K] | ch.67 |
| Gift (lihat §6): Warring Horse Statue 5.000 G · White Horse 8.000 G · Wreath 3.000 G · Flower Necklace 1.000 G · Rabbit Headband ×3 30.000 G · majalah 7.000 G | — | [K]/[N] | ch.51, 107, 146, 245, 128 |
| Dekor: grandfather clock 3.000 G · pocket watch 100.000 G | — | [N] | ch.16, 164 |
| Mock battle | 1 Warring Horse Statue (5.000 G)/papan | [K] | ch.166 |
| Gold per lantai (contoh kanon L1–L30) | L1 7.000 · L4 10.000 · L5 30.000 · L8 20.000 · L10 70.000 · L11 30.000 · L12 3.500 · L15 100.000 · L16 50.000 · L20 150.000 · L25 200.000 · L26 50.000 · L30 300.000 (TIDAK monoton); ulang lantai → reward turun (7.000 → 1.000) | [K] | ch.11 dst. (tabel per lantai §7) |

### 1.7 Paket cash kanon (rujukan monetisasi — konversi ke Robux di KONSEP §5)
| Paket kanon | Isi | Harga kanon | Batas | Label | Sitasi |
|---|---|---|---|---|---|
| Newbie jackpot package | 5.000 gems + 300.000 G | 65.000 won | 1× | [K] | ch.15 |
| Gold Triple Package | 3× sertifikat 5.000 gems (=15.000 gems) | 90.000 won (≈6 won/gem) | — | [K] | ch.49 |
| Monthly Package | 150 gems + 10.000 G/hari × 30 hari | 50.000 won | 1× | [K] | ch.122 |
| Kompensasi error server | 500 gems + 50.000 G + semua dungeon terbuka 3 hari | — | — | [K]/[N] | ch.46 |
Kurs won → Robux: (TERBUKA — keputusan monetisasi, KONSEP §5). Tidak ada daily login/attendance reward di kanon (TIDAK KETEMU) → tidak dibuat.

### 1.8 Mailbox [V0]
Reward stage, produk pembelian, kompensasi masuk mailbox [K] ch.4, 15, 46. Attachment berstatus "Bound" [K] ch.107. Business report sub-master (§5) [K] ch.268. Kapasitas/kedaluwarsa (TERBUKA).

### 1.9 Komunitas — [V1+] (Lv.20+): Dimensional Cafe, Trading Board, dispatch board, channel chat, guild, friend/whisper, MuTube, mock battle antar akun, port call/trade 1.500 gems. Yang [V0]: ranking server-wide berdasarkan lantai tertinggi [N] ch.1, 213 → leaderboard lantai.

## 2. MOEBIUS SUMMON & HERO (rujukan: KANON_PMU_02 §A)

### 2.1 Jenis summon [V0]
| Jenis kanon | Nama tampil | Harga | Isi kanon | Label | Sitasi |
|---|---|---|---|---|---|
| Summon ×1 | Pemanggilan Biasa | 10.000 G | praktis 1★ Common; sesekali 2★ | [K] harga · [N] isi | ch.6, 66 |
| Summon ×10 | Pemanggilan Biasa ×10 | 100.000 G | 10 hero; sampel: 1×2★ + 9×1★ | [K] | ch.6, 28 |
| Advanced Summon ×1 | Pemanggilan Agung | 500 gems | peluang 3★+; sampel dominan 3★, sesekali 4★ | [K] | ch.6, 26, 104 |
| Advanced ×3 / ×5 / ×10 | — | 1.500 / 2.500 / 5.000 gems | tanpa diskon (N × harga) | [K] | ch.26, 48 |
| Advanced Summon Ticket | Tiket Pemanggilan Agung | gratis | 2 tiket untuk akun baru (patch) | [K] | ch.241, 244 |
| 5★ guaranteed ticket | — | hadiah Festa | — | [N] | [V1+] ch.178 |

### 2.2 Odds — angka kanon + (TERBUKA)
| ★ | Label grade kanon | Odds kanon | Label | Sitasi |
|---|---|---|---|---|
| 1★ | Common | tidak disebut; free draw "praktis semua 1★" | (TERBUKA) | ch.6, 66 |
| 2★ | Uncommon | tidak disebut | (TERBUKA) | — |
| 3★ | Rare | tidak disebut; Advanced 500 gems "3★+ jarang", sampel 16/17 pull Advanced = 3★ | (TERBUKA) | ch.26, 31, 48, 104 |
| 4★ | Super Rare | < 1 % | [N] | ch.2 |
| 5★ | Hyper Rare | 0,1 % | [N] | ch.2 |
| 6★ | Ultra Rare | TIDAK bisa disummon ("This grade cannot be summoned!") — hanya promosi | [K] | ch.398, 263 |
| 7★ | G.O.D Rare | tidak bisa disummon; ≤5 ada di game | [K]/[N] | [V1+] ch.398, 94 |
Pity/guarantee: TIDAK KETEMU → tidak ada pity. Tabel odds lengkap 1★–3★ untuk kedua jenis summon = (TERBUKA, simulasi ekonomi saat build, dengan 4★ <1 % dan 5★ 0,1 % sebagai konstanta kanon). Rank awal ditetapkan sistem dari kemampuan fisik + weapon skill terdaftar [N] ch.96, 346.

### 2.3 UI & alur summon [V0] — urutan teks kanon
1. "[Summon a hero!]" → pilih [Summon]/[Advanced Summon] → konfirmasi jumlah [K] ch.6, 48.
2. "[Master Advanced Summoning begins…]" → efek roulette ("Talkak dururu") → "[Follow me!]" [K] ch.9, 26, 6.
3. Label grade: [Common!] / [Uncommon!] / [Rare!] / [!!Super!!Rare!!] / [Hyper Rare!] [K] ch.6, 31, 104.
4. "[Master 'X' has acquired the hero 'Nama (★★★)']" [K] ch.48.
5. Bond bila terjadi: "[I feel a strong connection among the five summoned people.]" → "[A bond '…' has been created!]" [K] ch.27, 104.
Hero muncul secara fisik di **Summoning Station** (gerbang di plaza waiting room) [N] ch.31, 66. Setiap summon dicatat di system log [N] ch.104.

### 2.4 Bond, kompatibilitas, enmity [V0]
| Mekanik | Aturan kanon | Angka | Label | Sitasi |
|---|---|---|---|---|
| Bond | consecutive draw → "very low chance" hero saling terhubung; satu party → "stronger fighting power" | peluang & bonus (TERBUKA) | [K] | ch.27 |
| Bond bubar | anggota keluar → "[The relationship '…' will be disbanded.]" | — | [K] | ch.29 |
| Enmity | saat summon: "['A' shows hostility towards 'B'!] [Enmity has been established!]" | efek (TERBUKA) | [K] | ch.49 |
| Compatibility | bonus stat bila cocok / penalti bila tidak; elemen wind+cold cocok, fire berisiko friendly damage | angka (TERBUKA) | [N] | ch.49, 158 |

### 2.5 Apa yang dibawa hero per ★ (default data hero saat summon)
| ★ | Latar | Stat Lv.1 (STR/INT/STA/AGI) | Skill bawaan | Class | Label | Sitasi |
|---|---|---|---|---|---|---|
| 1★ | sipil tanpa pengalaman tempur, bisa job non-tempur (Carpenter/Cook/Driver/Blacksmith/Tanner) | 10/10/10/10 (total 40) | kadang "[Skill: None]" | Novice | [K]/[N] | ch.7, 15 |
| 2★ | tipe tentara bayaran | contoh 14/10/12/12 (48) | 1 weapon skill Lesser Lv.1 | Novice | [K] | ch.7 |
| 3★ | terlatih, tenang | contoh 13/10/14/17 (54); Magician 7/31/8/7 (53) | beberapa skill Lv.3 atau Intermediate Lv.2 | Thief/Warrior/Magician | [K] | ch.27, 32 |
| 4★ | punya seal/unique skill | contoh Lv.28: 8/113/21/13 | ~7 skill (termasuk non-tempur) | Mage dll. | [K] | ch.106, 129 |
| 5★ | 2 slot imprint terisi; skill Advanced/Divine Lv.1 | 36/10/38/41 (125) | Advanced weapon skill | — | [K] | ch.211 |
Nama hero: nama lengkap dari sistem (generator nama = kulit wuxia; cek tabrakan nama PMU). Ilustrasi diperbarui saat promosi [K] ch.45. Equipment: TIDAK ada gear bawaan — hero mengambil gear ACAK dari Arsenal sebelum dungeon; gear hilang saat hero mati; grade awal E/E+ [K]/[N] ch.7, 10. Kapasitas hero = level Accommodation (awal 20) [N] ch.10.

### 2.6 Sumber hero non-gacha: rekrut dari waiting room lain, transfer afiliasi (1.500–5.000 gems), dispatch antar master (~1 minggu), detained→appeased = semua [V1+] (butuh rift Lv.20) [K]/[N] ch.88, 91, 104, 128.

---

## 3. STATUS WINDOW, STAT, EXP, CLASS, SKILL, STATUS EFFECT (rujukan: KANON_PMU_02 §B–G)

### 3.1 Status window [V0] — format kanon verbatim
```
[Nama Lengkap (★★) Lv. 1(Exp 0/10)]
[Class: Novice]
[Strength: 14/14] [Intelligence: 10/10] [Stamina: 12/12] [Agility: 12/12]
[Possessed Skill: Lesser Swordsmanship (Lv.1)]
```
[K] ch.7. Dengan modifier aktif: `cur/base ± mod` ("Strength: 28/23 + 5") [K] ch.28. Pasca-patch: skill menampilkan `[Rating: B+] [Type: Unique]` [K] ch.147. Status emosi ditampilkan sistem ("is indignant!", "refused to participate") [K] ch.47, 127. Hanya master yang melihat status window; hero melihat miliknya sendiri setelah riset Hero Reactivity Lv.1 [N]/[K] ch.14, 53. Nama tampil stat: Strength=Tenaga · Intelligence=Cipta · Stamina=Daya Tahan · Agility=Kelincahan (kulit saja).

### 3.2 Empat stat & growth
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Stat | 4: STR, INT, STA, AGI; format `current/max`; max = cap di level ini | [K] | ch.7, 129 |
| Hidden stat | Fear Resistance, Potential, Talent, Constitution — TIDAK pernah ditampilkan numerik | [K]/[N] | ch.4, 9, 96 |
| Base 1★ Lv.1 | 10/10/10/10 | [N] | ch.7 |
| Base total Lv.1 per ★ (sampel tunggal) | 1★ 40 · 2★ 48 · 3★ 53–54 · 5★ 125 · 4★ (TERBUKA, interpolasi) | [INF] | ch.7, 27, 32, 211 |
| Growth per level | ACAK/tidak merata; stat bisa TURUN saat level up; baseline 1★ ≈ 4 poin total/level; 2★ ≈ 5–6; 3★ ≈ 6; 4★ ≈ 7 (rata-rata deret Han) | [N]/[INF] | ch.13, 22, 47; tabel C.2 |
| Growth ditentukan | metode pengasuhan × potensi tersembunyi ("AI determines unique growth values") — potensi TIDAK ditampilkan | [N] | ch.1, 6 |
| Cap efektif | 100 per stat "batas dasar"; efisiensi turun tajam di atasnya (bisa dilewati) | [N] | ch.261 |
| Deret rujukan Han (kalibrasi) | Lv.5 15/15/15/15 · Lv.11 (2★) 27/10/25/25 · Lv.20 (3★) 45/10/41/39 · Lv.40 (4★) 90/10/83/81 | [K] | ch.9, 47, 100, 193 |
| HP/Stamina/Mana | resource terpisah (bar, tanpa angka tampil): "HP decreases" vs "Stamina decreases"; wizard konsumsi mana | [K]/[N] | ch.20, 41, 35 |
| Angka HP/Stamina/Mana | TIDAK KETEMU | (TERBUKA — internal engine, tidak ditampilkan) | — |
| Waiting room "Continuous Recovery" | luka & anggota tubuh putus pulih; tidak berlaku di sparring/arena/PvP | [K]/[N] | ch.21, 67, 125 |

### 3.3 Exp & level
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Exp-to-next | **default 10 × Lv** (7 sampel cocok: Lv.1=10, 5=50, 11=110, 28=280, 34=340, 40=400, 55=550) · alternatif 40/50/60/70/120/160 di Lv.5–29 (7 sampel) | [K] data · [INF] rumus | (TERBUKA: C3) tabel D.1 |
| Sumber exp | stage clear (hanya kontributor); MVP bonus (besaran TERBUKA); sintesis hero (exp ∝ rarity/level bahan); berburu daily/exploration | [K]/[N] | ch.4, 11, 12, 54 |
| Exp saat cap | tetap terakumulasi; "[Party is the limit level, so you won't grow!]" | [N]/[K] | ch.25, 271 |
| Level musuh | ≈ nomor lantai | [N] | ch.46 |

**Level cap per ★ (dasar promosi):**
| ★ | Cap | Label | Sitasi | Lingkup |
|---|---|---|---|---|
| 1★ | Lv.10 | [N] | ch.36, 55 | [V0] |
| 2★ | ~Lv.20 | [INF] | ch.57, 86, 100 | [V0] |
| 3★ | Lv.40 | [N] | ch.161, 171 | [V0] (cap tercapai, promosi 4★ = [V1+] lantai 40) |
| 4★ | Lv.55 | [N] | ch.246 | [V1+] |
| 5★ | Lv.70 | [N] | ch.261 | [V1+] |
| 6★ | Lv.99 | [N] | ch.3, 94 | [V1+] |
Cap per lantai: ≈10 level hero per 10 lantai (lantai 1–50) [N] ch.261 → V0 (30 lantai) ≈ hero Lv.30-an.

### 3.4 Class & job change [V0]
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Class awal | Novice (semua 1★/2★); 3★ sudah ber-class (Thief/Warrior/Magician) | [K] | ch.7, 27, 32 |
| Dua job dasar | Warrior (senjata selain bow/dagger) & Thief (bow/dagger); Wizard hanya dari Advanced summon | [N] | ch.91, 32 |
| Job change | via fasilitas/kursus; syarat belum job change; memberi kualifikasi evolusi weapon skill Lesser Lv.10 → Intermediate; MENGHAPUS skill class lama | [N] | ch.86, 95, 100 |
| Class berubah otomatis | mengikuti promosi/imprint (Warrior → Fighter → Dragonian) | [N]/[INF] | ch.193, 247 |
| 4 kategori job | Combat, Production, Gathering, Management; job non-tempur: Carpenter, Cook, Driver, Blacksmith, Tanner, Researcher, Instructor, Sub-master | [N] | ch.157, 15–18, 53 |
| Nama tampil | Novice=Murid Luar · Warrior=Pendekar · Thief=Pengintai · Magician=Ahli Formasi · Fighter=Petarung · Archer=Pemanah | kulit | — |

### 3.5 Skill [V0]
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Level skill | maks Lv.10 → "When special conditions are met, evolution to a higher skill is possible!" | [K] | ch.98, 111 |
| Tier | Lesser → Intermediate → Advanced (Advanced umumnya di 5★) | [N] | ch.80, 211 |
| Cara dapat (9 jalur) | (a) latihan berulang di waiting room (Shield Skill dari 3 hari latihan) · (b) Skill Awakening di krisis/tempur (Pain Resistance dari terluka) · (c) sintesis hero · (d) Skill Book battle shop 500 gems, hanya skill bantu · (e) achievement · (f) equipment · (g) dispatch [V1+] · (h) diajar senior/instruktur · (i) aksi master (deletion/attachment) [V1+] | [K]/[N] | ch.9, 29, 11, 20, 12, 40, 87, 130, 17, 73 |
| Naik level | lewat penggunaan/latihan; Skill Awakening bisa +2/+3 level sekaligus; statistik limit-break 77 % combat, 17 % training | [K]/[N] | ch.9, 20, 140, 144 |
| Laju latihan | mandiri ≈ 1 level skill / 10 hari · dengan instruktur 6★ ≈ 1 level / hari (10×) | [N] | ch.98 (lihat §6 pendidikan) |
| Evolusi Lv.10 | contoh kanon: Pain Resistance → Battle Continuation (A-class) · Composure → Combat Logic (S-class) · Lesser Swordsmanship + job change → Intermediate; syarat "special conditions" tidak dijabarkan | [K] · (TERBUKA syarat) | ch.145, 11, 100 |
| Rating & Type | huruf (B+, B-…); Type Unique / Unique Link Double | [K] | ch.147 |
| Eksklusivitas | **default: Berserk vs Calmness saling eksklusif** (ch.11, 21) · alternatif keduanya bisa ada (ch.28) | [N] | (TERBUKA: C7) |
| Skill hilang | job change hapus skill class lama | [N] | ch.100 |

**Katalog skill V0 (yang kanon tunjukkan pada hero ≤3★ / ≤Lv.40) — default data:**
| Skill kanon | Nama tampil | Tier/Grade | Efek kanon | Cara dapat | Sitasi |
|---|---|---|---|---|---|
| Lesser Swordsmanship | Ilmu Pedang Dasar | Lesser, Lv.1–10 | weapon skill pedang | bawaan 2★+/latihan | ch.7, 9–98 |
| Intermediate Swordsmanship | Ilmu Pedang Madya | Intermediate | evolusi Lesser Lv.10 + job change | evolusi | ch.100 |
| Lesser Shield Skill | Ilmu Perisai Dasar | Lesser | — | 3 hari latihan | ch.9 |
| Lesser Archery | Ilmu Panah Dasar | Lesser | — | bawaan/latihan | ch.9, 27 |
| Lesser Dagger Skills | Ilmu Belati Dasar | Lesser | — | bawaan 3★ Thief Lv.3 | ch.27 |
| Lesser Spearmanship | Ilmu Tombak Dasar | Lesser | — | bawaan/latihan | ch.17, 35 |
| Pain Resistance | Tahan Derita | — → Battle Continuation (A) di Lv.10 | tahan nyeri | awakening dari terluka | ch.11, 145 |
| Calmness/Composure | Hening Batin | — → Combat Logic (S) di Lv.10 | ketenangan (anti-fear) | sintesis/latihan | ch.12, 144 |
| Berserk/Ferociousness | Amuk Darah | — | Lv.1: STR/STA/AGI +5, INT −10; mengusir fear | krisis | ch.28, 140 |
| Throwing Defense | Tangkis Proyektil | — | tahan proyektil ("sulit didapat") | awakening dihujani panah | ch.47 |
| Fire Resistance | Kebal Api | — | tahan api | paparan/4 hari latihan | ch.35, 47 |
| Equestrian Art | Seni Berkuda | auxiliary | berkuda | Skill Book 500 gems | ch.40 |
| Insight/Mind's Eye | Mata Batin | — | bedakan ilusi, nilai lawan, dark vision | awakening latihan | ch.54 |
| Secret Movement | Langkah Bayangan | thief | deteksi berkurang | awakening tempur | ch.62 |
| Strike | Hantam | — | — | awakening tempur | ch.111 |
| Hawk Eye · Quick Movement · Forest Hunter · Weapon Switching · Rapid Fire · Weakness Spotting | (pemanah/pengintai) | — | Forest Hunter: bonus berburu di hutan | sintesis/awakening daily dungeon | ch.12, 20, 24, 35, 54 |
| Trap Release · Trap Setting · Stealth | (Thief) | — | — | sintesis/eksklusif Thief | ch.29, 60 |
| Intermediate Flame Magic · Telekinesis · Multi/High-speed/Silent chanting | (Magician) | Intermediate | area luas; friendly damage; casting 1 menit | bawaan 3★ Magician | ch.32, 39, 80 |
| Wild/Feral | Liar | pasif, <1 % | ubah fear/anger jadi kekuatan | sintesis 2 hero | ch.66 |
| Cooking · Herbalist · gathering | (non-tempur) | — | naik peluang drop stone | job | ch.16, 25 |
Skill 4★+ (Exceed, Sword Soul, Dragon Slaughter, imprint-linked, Divine) = [V1+]. Skill Database >10.000 [N] ch.346 → katalog V0 di atas = subset; skill lain (TERBUKA: hanya bila playtest butuh, diambil dari tabel F.2 bab 02).

### 3.6 Status effect [V0] — angka kanon
| Status | Efek | Angka | Pemicu / penawar | Label | Sitasi |
|---|---|---|---|---|---|
| Fear | all stats −30 % | −30 % | Fear Resistance rendah; lepas via tekad/Berserk/anti-fear potion 50 gems | [K] | ch.3, 4 |
| Panic | all stats −50 % | −50 % | eskalasi fear; 1★ panik di battle pertama | [K] | ch.3, 41 |
| Despair | all stats −80 % | −80 % | — | [K] | ch.2, 8 |
| Exhausted | all stats −90 % → Indomitable aktif bila ada | −90 % | kelelahan ekstrem | [K] | ch.145 |
| Bleeding | HP/Stamina turun periodik | tick (TERBUKA) | luka; stack dengan fear | [K] | ch.20, 41 |
| Poisoned | HP/Stamina turun periodik, memburuk | tick (TERBUKA) | racun; low potion TIDAK menyembuhkan; antidote | [K] | ch.59, 62 |
| Paralysis | bagian tubuh nonaktif | — | racun paralisis | [K] | ch.71 |
| Dying state | HP kritis | — | — | [K] | ch.2, 41 |
| Berserk state | +5 STR/STA/AGI, −10 INT (Lv.1) | — | skill Berserk | [K] | ch.28 |
| Sudden death | mati permanen "[Cause – Suicide due to stress]" | — | stres di luar battle (§6) | [K] | ch.7, 29 |
| Refused / Strike | "['X' refused to participate!]" / "[Party 1 has become uncontrollable]" / "[Mass strike!]" | — | tuntutan hero (§6) | [K] | ch.47, 48, 65 |
| Level cap | 0 exp | — | cap ★ | [K] | ch.271 |
| Durasi Fear/Panic/Despair | TIDAK KETEMU | (TERBUKA) | — | — | — |
Eskalasi Fear < Panic < Despair < Exhausted [INF]. Consumable dibawa hero & dipakai otomatis "when appropriate"; bisa pecah [K] ch.36, 57. Contaminated, Exceed, Broken heart (stres 5★), Magical state, Death protection = [V1+] (4★+/PvP).

### 3.7 Imprint / Advent Dungeon — [V1+]
Slot imprint terbuka di 4★ (promosi 4★ terbuka lantai 40) [K]/[N] ch.161, 175. Yang [V0]: **Advent Stone bisa dikumpulkan** dari exploration dungeon sejak lantai 10 [K] ch.41 (disimpan di warehouse, dipakai V1+). Data V1+: slot 4★=1 · 5★=2 · 6★=3; success rate 93 % (cocok) vs 2 % (tak cocok); gagal = contaminated; grade C+ → A → S → SS- (defense +10/+20 %) [K] ch.189–217.

## 4. PROMOSI, SINTESIS, KONVERSI, ITEM, CRAFTING, TOKO (rujukan: KANON_PMU_03)

### 4.1 Promosi (naik ★) — fitur TERPISAH dari sintesis [V0 s.d. 3★]
| Dari → Ke | Syarat level | Bahan kanon | Peluang gagal | Tempat | Label | Sitasi | Lingkup |
|---|---|---|---|---|---|---|---|
| 1★ → 2★ | Lv.10 (cap 1★) | **default: 1 Lesser Property Stone** = sintesis Lesser Fire+Water+Wind attribute stone @87 % (ch.55) · alternatif "2 attribute stone (lower)" (ch.25) | 0 (tips: gagal mulai 4★) | Promotion Station | [K]/[N] | ch.36, 55, 25, 172 | [V0] |
| 2★ → 3★ | ~Lv.20 | Intermediate Upgrade Stone = sintesis Lesser attribute stone + Lesser soul stone (Synthetic Center); jumlah stone (TERBUKA, default 1) | 0 | Promotion Station | [K] | ch.86, 88 | [V0] |
| 3★ → 4★ | Lv.40 + master clear lantai 40 | Advanced Upgrade Stone = Fire+Water+Wind attribute + Intermediate upgrade + Intermediate soul stone @54 % | "<1 %" (ch.172); gagal = **Contaminated** (permanen) | Promotion Station Lv.2 | [K]/[N] | ch.161, 171, 172 | [V1+] |
| 4★ → 5★ | Lv.55 | tidak disebut | ada | — | [N] | ch.246 | [V1+] |
| 5★ → 6★ | Lv.70 | tes di external upgrade center | — | Dimension City | [K] | ch.261, 263 | [V1+] |
| 6★ → 7★ | interference threshold | Book of Reversal (SS) | — | — | [N] | ch.284 | [V1+] |

**Alur sukses (verbatim, urutan):** "[Bara Bam!]" → "[Congratulations, Master!]" → "[Forgotten memories of the hero are awakened.]" → "['X(★★)' promotion complete! It has become 2 stars.]" → "[Illustration is updated.]" → "[Level and skill thresholds increase.]" [K] ch.45. Notifikasi login: "[A hero that can be promoted – 'X(★★)']" [K] ch.41, 86. Efek: memori pulih, ilustrasi baru, cap level & skill naik, exp yang terakumulasi tidak hilang [K]/[N] ch.45, 25. Biaya gold/gems promosi: TIDAK KETEMU → 0 (bahan saja).

**Hirarki batu [V0]:**
| Batu | Tier | Sumber | Label | Sitasi |
|---|---|---|---|---|
| Attribute stone (Fire/Water/Wind…) | Lesser (D-) → tanpa tier | drop monster daily dungeon; reward lantai 10 (Lesser Fire) | [K] | ch.24, 41, 55 |
| Lesser Property Stone | — | sintesis 3 Lesser attribute (87 %) | [K] | ch.55 |
| Soul stone | Low → Intermediate → Advanced | Conversion Station (hero → Low Soul Stone) | [K] | ch.86 |
| Upgrade stone | Low → Intermediate → Advanced | Synthetic Center | [K] | ch.86, 171 |

### 4.2 Sintesis hero (tumbal → exp) [V0]
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| UI | tab Synthesis → "[Drag and drop the hero to be sacrificed to the hero you want to synthesize! You can get experience points. The sacrificed hero will disappear.]" → "[Are you sure you want to synthesize?]" → "[Synthesis complete!]" → "['X' becomes light and disappears.]" → "['Y' level up! Acquisition of 'skill' skill!]" | [K] | ch.5, 12 |
| Favorit | "[Add 'X' to Favorites]" mencegah salah sintesis | [K] | ch.5, 12 |
| Hasil | bahan lenyap permanen; target dapat EXP; bisa level up + skill instan (hawk eye, Calmness, Trap Release, Wild) | [K] | ch.12, 29, 66 |
| Gap level | level target jauh di atas bahan → hanya EXP | [N] | ch.66 |
| Preseden | 1★ → 1★ Lv.5: +2 level (Lv.7) + skill; 2× 1★ → 2★: level up + skill Wild; 1★ → 2★ Lv.11+: hanya EXP | [K]/[N] | ch.12–13, 66 |
| Rumus EXP per bahan | TIDAK KETEMU | (TERBUKA — default: exp ∝ level×★ bahan, kalibrasi ke preseden di atas) | — |
| Peluang skill dari sintesis | TIDAK KETEMU | (TERBUKA) | — |
| Info hilang | ≥90 % (rata-rata >95 %) — flavor | [N] | ch.97 |
| Otoritas | hanya master; sub-master TIDAK bisa sintesis | [N] | ch.98, 157 |
| Fungsi sosial | hukuman ringleader mogok = sintesis; syarat duel "Synthesis" bagi yang kalah (master menyetujui); hero sadar mereka expendable; jarang sintesis → dipandang "hero malas" (pandangan umum master) | [K]/[N] | ch.48, 28, 234, 63 |
Efek mental pada hero yang menyaksikan sintesis → §6 (stres/likeability, kanon tanpa angka).

### 4.3 Conversion Station (hero → soul stone) [V0]
Build via menu fasilitas → "[The conversion station is complete!]" → tab Conversion → hero (mati/hidup) → "[You have acquired the 'Low Soul Stone'!]" [K] ch.86. Biaya build, tier soul stone per ★ bahan: TIDAK KETEMU → (TERBUKA; default build 500 gems seperti fasilitas lain; 1★–2★ → Low; 3★ → Intermediate [INF] ch.86, 107).

### 4.4 Sintesis item [V0]
Jendela: "[Start item synthesis!]" → "[Optional Material – …]" → "[Complete Item – …]" → "[Success Rate – NN %]" → "[Synthesis Method – Automatic/Manual]" → "[Synthesize?]" → "[Good!] [Synthesis completed!]" ATAU "[Fail!] [Material disappears.]" [K] ch.55, 171. Manual = puzzle (§4.6) → "[! Super Success!]" [K] ch.189. Tempat: Alchemy (annex Training Center) / Synthetic Center / Gift shop (sintesis gift) [K] ch.34, 86, 146.
| Resep kanon [V0] | Hasil | Rate | Sitasi |
|---|---|---|---|
| Lesser Fire + Water + Wind Property Stone | Lesser Property Stone | 87 % | ch.55 |
| Lesser attribute stone + Lesser soul stone | Intermediate Upgrade Stone | (TERBUKA) | ch.86 |
| Warhorse statue + wreath + flower necklace | Mourning Warhorse Statue (gift) | "Unknown" | ch.146 |
| Fire+Water+Wind attribute + Intermediate upgrade + Intermediate soul stone | Advanced Upgrade Stone | 54 % | [V1+] ch.171 |

### 4.5 Equipment [V0]
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Grade | E → D → C → B → A → S → SS → U, varian −/+ (E+, C-, C, C+, B-…) | [K]/[N] | ch.7, 15, 100 |
| Grade V0 | hero awal E/E+; craft awal C (iron sword); Equipment Workshop upgrade E→D; solo craft maks B | [K]/[N] | ch.7, 14, 18, 101 |
| Arsenal | hero ambil gear ACAK sebelum dungeon; terisi ulang hari berikutnya; gear hilang saat hero mati | [K]/[N] | ch.7, 10 |
| Exclusive equipment | "[Register 'Heavy Steel Sword (-C)' to 'X' exclusive equipment.]" — per hero, tidak bisa transfer; Arsenal tidak menyimpannya | [K]/[N] | ch.15 |
| Item hero mati | masuk storage/archive; Storage Lv.1 → Archive (ilustrasi hero mati hanya bila barang peninggalan disimpan) | [K]/[N] | ch.79, 146 |
| Material bergrade | Leather/Iron Ore/Plank (C→B→A), Wolf Skin, Queen's Blood, dst. (drop lantai — tabel §7) | [K] | ch.11, 21 |
| Angka stat per grade equipment | TIDAK KETEMU | (TERBUKA — internal engine) | — |
| Durabilitas | ada (aus, retak, patah); angka TIDAK KETEMU | [N] · (TERBUKA) | ch.84, 100 |
| Nama tampil grade | E=Besi Kasar · D=Besi Tempa · C=Baja · B=Baja Roh · A=Pusaka · S=Pusaka Langit | kulit | — |

### 4.6 Crafting [V0]
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Fasilitas | Blacksmith (annex Arsenal, 500 gems, "Blacksmithing Lv.1"), Tannery, Carpentry, Equipment Workshop, Alchemy | [K]/[N] | ch.12, 14, 18, 26, 34 |
| 3 metode | "[Start equipment production!]" → Reinforcement / Casting / Consignment | [K] | ch.14 |
| Penalti | tanpa fasilitas cukup / tanpa artisan / tanpa blueprint → masing-masing "A penalty will be granted" (stack; bobot TERBUKA) | [K] | ch.14 |
| Auto vs manual | auto production bila syarat terpenuhi (~10 gagal awal); manual = puzzle | [N]/[INF] | ch.18, 14 |
| Puzzle | pilih difficulty ("higher reward for higher difficulty"); 13 jenis, yang dinamai: grid putar 15×15, Cube 27×27 timer 30 dtk, Rhythm, Tetris, Jigsaw, Pinball Tetris, Finding Wrong Picture, Square Logic Crossword; skor (waktu, match rate, combo) → grade output; "[! Super Success!]" | [K]/[N] | ch.14, 102 |
| V0 default puzzle | 1 jenis (grid putar tutorial, ch.14) — jenis lain (TERBUKA, tambah bila anggaran) | [INF] | — |
| Tingkat kesulitan | 8 tingkat; nama yang muncul: Super Novice, Hell, Super Hell, Super God (tersembunyi); nama 4 lain (TERBUKA) | [K]/[N] | ch.101, 102 |
| Resep | iron sword = 2 iron ore + 1 leather + 1 plank; resep lain TIDAK KETEMU | [N] · (TERBUKA) | ch.14 |
| Pengolahan bahan | branches → boards, torn leather → tanned leather, iron ore → ingots | [N] | ch.47 |
| Asisten | maks 2 per fasilitas; "Closeness bonus" (kedekatan hero saat crafting) | [N]/[K] | ch.30, 14 |
| Puzzle dimainkan | master ATAU hero | [N] | ch.14, 102 |

### 4.7 Alchemy & potion [V0]
| Item | Efek kanon | Harga | Label | Sitasi |
|---|---|---|---|---|
| Anti-fear potion | hapus Fear/Panic | 50 gems | [K] | ch.3 |
| Low Life Potion | pulih HP; TIDAK sembuhkan status abnormal; bisa pecah saat dibawa | craft | [K] | ch.36, 57 |
| Stamina potion | pulih stamina | craft | [N] | ch.38 |
| Magic potion | pulih mana, "one sip per shot" | craft | [N] | ch.38 |
| Emergency recovery potion | request hero mid-mission | 500 gems, 1×/misi | [K] | ch.200 |
| Health potion | sembuh tapi sakit (latih Pain Resistance) | craft | [N] | ch.34 |
Hero membawa consumable yang ditugaskan: "[Have 'X' carry the 'Low Life Potion'!]" → dipakai otomatis "when appropriate"; kapasitas 2–3/orang, leather pouch menambah [K]/[N] ch.36, 57, 81. Jumlah HP pulih, resep, harga craft: (TERBUKA).

### 4.8 Mount — [V1+] (Stable = fasilitas lantai 4 mansion; Equestrian Art via Skill Book 500 gems [V0] hanya sebagai skill).

### 4.9 Item kontrol [V0]
| Item | Fungsi kanon | Sumber | Label | Sitasi |
|---|---|---|---|---|
| Regeneration Stone / Playstone | drag-drop ke hero → hero menonton rekaman lantai → "['X' has learned the experience of the 25th floor.]" (mission experience, tanpa XP); stone habis | "low probability" di Lesser Isralta Mine (exploration), naik bila gathering skill | [K] | ch.69, 108, 109 |
| Skill Book (Equipment) | skill bantu instan | battle shop 500 gems | [K] | ch.40 |
| Advent Stone | buka Advent Dungeon (imprint [V1+]) | exploration dungeon Lv.10 | [K] | ch.41 |
| Pocket watch | timer misi | 100.000 G | [N] | ch.164 |
| Gift certificate | tukar gems/gold | paket | [K] | ch.46 |
Dimension Summoning Stone, dimensional stone, Goddess Statue, Sailboat Statue, Book of Reversal = [V1+] (lantai 34+).

### 4.10 Toko [V0]
**Battle shop (mid-mission):** "[The battle shop is open.]" hanya saat kondisi tertentu (boss) atau hero "requests" [K] ch.40, 120, 200.
| Item | Harga | Batas | Interaksi | Sitasi |
|---|---|---|---|---|
| Skill Book (Equipment) | 500 gems | — | Yes/No | ch.40 |
| Cheering stick | 50 gems/pakai | — | "[Slide the screen left and right!]" (goyang layar) | ch.120 |
| High-quality fluorescent stick | 100 gems/pakai | — | — | ch.143 |
| Dragon glow stick | 100 gems/pakai | — | goyang layar | ch.201 |
| Emergency recovery potion | 500 gems | 1×/misi | Yes/No | ch.200 |
Master tidak bisa intervensi langsung di battle — hanya lewat battle shop/cheering/tactics [N] ch.40.

**Gift shop:** Administration tab → ikon gift → "[Purchase 'X' with N gold.]" → "[Give 'X' as a gift to 'Hero'!]" → reaksi (§6) [K] ch.51, 107. Beli ×N; hero bisa "wants X ×10" [K] ch.253, 128. Katalog kanon: Warring Horse Statue 5.000 G · White Horse Statue 8.000 G · Wreath 3.000 G · Flower Necklace 1.000 G · Lumagini (majalah) 7.000 G · Rabbit Headband 10.000 G/buah · Mourning Warhorse Statue (sintesis); tanpa harga: fluorescent rods, fine plates, pottery, grinding stones, board games, fur coats [K]/[N] ch.51–284. Nama tampil: patung kuda perang → "Patung Kuda Perang Giok", dst. (kulit).

**Dekorasi:** grandfather clock 3.000 G (dorm) [N] ch.16; katalog lain (TERBUKA).

### 4.11 Warehouse & loot [V0]
Loot daily dungeon: "['X' has collected 'Y'.]" … "[Mission complete!] [The hero returns to the waiting room.] [List of obtained items]" [K] ch.24. Item non-terdaftar lenyap; harus dikumpulkan sebelum portal [N] ch.24–25. Warehouse auto-stack; hero mengambil bahan ("['X' took iron ore (C) X 6 …]") [K] ch.13. Reward stage → mailbox [K] ch.4. Tidak ada fitur "sell" di kanon (TIDAK KETEMU) → tidak dibuat. Kapasitas (TERBUKA).

## 5. WAITING ROOM, FASILITAS, RESEARCH, ORGANISASI, AUTONOMOUS ACTION, PARTY, DUEL (rujukan: KANON_PMU_04)

### 5.1 Waiting room [V0]
| Aturan | Nilai kanon | Nama tampil | Label | Sitasi |
|---|---|---|---|---|
| Layar utama | waiting room ("room"); menu tab (Synthesis, Facility, Administration, Settings, Mail, Help) | Paviliun Sekte | [K] | ch.2, 4, 86 |
| Struktur bawaan akun baru | Plaza (hub, titik kumpul) · Summoning Station (gerbang di plaza) · Accommodation (kapasitas hero **20**) · Arsenal · Warehouse · Synthesis Lab · Space-time gap (pintu dungeon) | Halaman Pusat · Altar Pemanggilan · Asrama · Gudang Senjata · Gudang · Balai Peleburan · Gerbang Ruang-Waktu | [N] | ch.3, 7, 9, 10, 13, 66 |
| Pintu dungeon | "[Open the space-time!]" → "[The door will open in 10 seconds. Get ready!]" (selalu 10 dtk); party dikumpulkan ke plaza dulu; daily dungeon lewat cermin ("Just go inside the mirror!") | — | [K] | ch.7, 8, 25, 56 |
| Continuous Recovery | luka & anggota tubuh putus pulih otomatis di waiting room; TIDAK berlaku di sparring/arena/PvP | — | [K]/[N] | ch.21, 67, 125, 296 |
| Kapasitas hero | awal 20; naik via level Accommodation (angka per level TERBUKA) | — | [N] | ch.10 |
| Nama waiting room | dikunci otomatis saat lantai 10: "[Waiting room's name is fixed to 'X'.]" (tanpa prompt input di kanon; sumber nama TERBUKA — default: nama diambil dari nama master) | — | [K]/[INF] | ch.41 |
| Proteksi Lv.1 | waiting room tidak bisa diinvasi; dicabut hanya bila membuka rift (Lv.20+) | — | [K] | ch.87 |
| Lantai waiting room | 1 lantai awal; "[Waiting room evolves to level 2! The number of floors increases.]" via Research Facility Scalability Lv.1; lantai 2 ≈ 30 orang; penempatan per lantai diperintahkan master ("[1st party is all on the 2nd floor…]"); merit-based: hero baru lantai 1 (jatah dasar), party utama lantai 2 (Restaurant Lv.2, Bathhouse, Lounge), lantai 3 residensi posisi tempur + party camps, lantai 4 Mansion + Training room + upacara promosi, lantai 5 akomodasi eksklusif | Tingkat Paviliun | [K]/[N] | ch.64–66, 105, 156, 191, 267 |
| V0 lantai | 1 → 2 (Facility Scalability Lv.1) → 3 (syarat kanon TERBUKA; default: Facility Scalability Lv.2) | — | [K]/[INF] | ch.64 |
| Fasilitas tambahan terbuka | tiap kelipatan 10 lantai: "[Additional facilities have been opened.]" (isi per milestone TERBUKA) | — | [K] | ch.85, 123 |
| Waktu | 1 hari Bumi ≈ 3 hari in-game (TERBUKA: C1) | — | [N] | ch.9 |

### 5.2 Fasilitas [V0] — tabel data
UI build: Facility tab → "[Build the facility. Please touch the type of facility you want.]" → "[You have selected 'X'. Would you like to build? 500 gems are consumed for construction.]" → "[The X has been completed…]" [K] ch.8. Annex menempel ke induk; 3 annex bisa merge jadi fasilitas baru [K] ch.12, 34. Konstruksi memindahkan semua hero ke warehouse [K] ch.64. Upgrade level = material + craftsman + waktu konstruksi + Gold Blueprint [N] ch.8, 255. Level maks tampil "Lv.Max" [N] ch.100. Hero bisa me-request fasilitas [K] ch.244. Fasilitas pertama GRATIS (event new master) [K] ch.244. Maks 2 asisten per fasilitas [N] ch.30.

| Fasilitas kanon | Nama tampil | Harga kanon | Induk/annex | Fungsi kanon | Level V0 | Label | Sitasi |
|---|---|---|---|---|---|---|---|
| Plaza | Halaman Pusat | bawaan | — | hub, titik kumpul party | — | [N] | ch.3 |
| Summoning Station | Altar Pemanggilan | bawaan | plaza | hero muncul | — | [N] | ch.31 |
| Accommodation | Asrama | bawaan Lv.1 | — | kapasitas hero (20); manager 2 orang ("[Manager in charge: …]"); jenis makanan ("[Possible food types: meat, potato, fruit…]") | Lv.1–3 (kapasitas per level TERBUKA) | [K]/[N] | ch.10, 64 |
| Restaurant | Dapur Sekte | (TERBUKA; default 500 gems) | annex Accommodation | makan bersama; jabatan Chef via rekomendasi | Lv.1–2 | [K] | ch.16, 64 |
| Bathhouse · Lounge | Pemandian · Pendopo | (TERBUKA; default 500 gems) | annex Accommodation | istirahat | Lv.1 | [K] | ch.64 |
| Arsenal | Gudang Senjata | bawaan Lv.1 | — | gear acak sebelum dungeon; terisi ulang harian | Lv.1 | [K]/[N] | ch.7, 10 |
| Blacksmith | Bengkel Tempa | 500 gems | annex Arsenal | crafting 3 metode; "Blacksmithing Lv.1" | Lv.1 | [K] | ch.12, 14 |
| Equipment Workshop | Balai Kerajinan | (TERBUKA; default 500 gems) | — (sub: Carpentry, Tannery, Workshop) | upgrade armor E→D; auto production; training doll | Lv.1 | [K]/[N] | ch.18, 35 |
| Warehouse | Gudang | bawaan | — | material auto-stack; consumable | — | [K] | ch.13, 36 |
| Training Center | Balai Latih | 500 gems (pertama gratis) | — | hero berlatih mandiri via AI; orang-orangan, senjata kayu; Instructor; time adjustment | Lv.1 | [K] | ch.8, 9, 243 |
| Sparring ground | Arena Tanding | bagian Training Center | TC | duel/seleksi; recovery dimatikan | — | [N] | ch.67 |
| Magic Lab | Ruang Kajian | (TERBUKA; default 500 gems) | annex TC | "[Research is open.]" | — | [K] | ch.24, 34 |
| Alchemy | Ruang Ramuan | (TERBUKA; default 500 gems) | annex TC | sintesis item/consumable | — | [K] | ch.34, 36 |
| Library | Perpustakaan | (TERBUKA; default 500 gems) | annex TC | wizard belajar mandiri | — | [K] | ch.34 |
| Magic Hall | Aula Formasi | hasil merge 3 annex | — | research + crafting consumable | — | [K] | ch.34 |
| Synthesis Lab | Balai Peleburan | bawaan | — | sintesis hero | — | [K] | ch.4 |
| Synthetic Center | (bagian Balai Peleburan) | (TERBUKA) | — | sintesis batu promosi | — | [K] | ch.86 |
| Conversion Station | Altar Jiwa | (TERBUKA; default 500 gems) | — | hero → soul stone | — | [K] | ch.86 |
| Promotion Station | Altar Kenaikan | (TERBUKA; default 500 gems) | — | promosi ★ | Lv.1 (Lv.2 = [V1+]) | [K] | ch.55, 86 |
| Storage → Archive | Balai Kenangan | (TERBUKA; default 500 gems) | — | "[You can look back on the heroes who left…]"; album hero mati bila barang peninggalan disimpan; replay arsip | Lv.1 | [K] | ch.79, 146 |
| Tactical Post | Menara Siasat | (TERBUKA; default 500 gems) | annex | tab Tactics; instruksi taktis in-mission (§7.7); level → fungsi bertambah | Lv.1 | [K] | ch.36, 148 |
| Gift Shop | Kedai Hadiah | bawaan (Administration tab) | — | beli gift (gold) | — | [K] | ch.51 |
| Dekor | — | grandfather clock 3.000 G; display stand | — | interior | — | [N] | ch.16, 146 |
| Dimensional Gap/Rift, Stable, Alarm facility, Watchtower/Barrier/Trap, External Upgrade Center, Office, Strategy Cafe | — | rift gratis Lv.20+ | — | — | — | — | [V1+] |
Efek numerik per fasilitas/level: TIDAK KETEMU → (TERBUKA, playtest).

### 5.3 Research [V0]
| Parameter | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Syarat buka | Magic Lab dibangun | [K] | ch.34 |
| 3 cabang | 1. Hero Reactivity · 2. Facility Scalability · 3. Dungeon Advanced (semua Lv.0 awal) | [K] | ch.53 |
| Personel | appoint Researcher dari "[Researcher recommendation list!]" (wizard/hero cerdas) | [K] | ch.53 |
| Kecepatan & biaya | 10 poin/jam; 10 gems/jam; master set jam riset (default kanon 3 jam/hari = 30 poin & 30 gems/hari) | [K] | ch.53 |
| Efek samping | jam riset berlebih → "['X' expresses dissatisfaction!]" | [K] | ch.53 |
| Biaya Lv.0→1 | 150 research point (≈5 hari pada 3 jam/hari) | [K] | ch.64 |
| Biaya Lv.2+ | TIDAK KETEMU | (TERBUKA; default kelipatan 150) | — |
| Hero Reactivity Lv.1 | hero bisa lihat status window sendiri + objektif misi | [N] | ch.53, 54 |
| Facility Scalability Lv.1 | facility customization + "[Waiting room evolves to level 2!]" | [K] | ch.64 |
| Dungeon Advanced Lv.1 | waktu tinggal di exploration dungeon bertambah (baseline 48 jam; tambahan TERBUKA) | [K] | ch.67 |
| Notifikasi | "[Research 'Hero Reactivity' has become Lv.1.]" | [K] | ch.53 |
Nama tampil: Hero Reactivity = Kajian Batin Murid · Facility Scalability = Kajian Tata Paviliun · Dungeon Advanced = Kajian Alam Rahasia.

### 5.4 Organisasi & jabatan [V0]
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| 4 kategori kerja | Combat · Production · Gathering · Management | [N] | ch.157 |
| Jabatan V0 | Chef (Restaurant) · Researcher (Lab) · Manager fasilitas (2/fasilitas) · Artisan (Blacksmith/Tanner/Carpenter — dari job bawaan) · Instructor (Training Center) · Party leader · Sub-master | [K]/[N] | ch.16, 53, 64, 14, 73, 30, 156 |
| Penunjukan | via "[List of recommended X!]" → "[Do you want to appoint 'Y' as …?]" → posisi lama dibatalkan otomatis; 1 Chef aktif | [K] | ch.16, 17 |
| Asisten | maks 2 per fasilitas | [N] | ch.30 |
| Efek numerik jabatan | TIDAK KETEMU | (TERBUKA) | — |
| Sub-master | hero ditunjuk master untuk mengelola saat master absen; wewenang: usulkan komposisi, tunjuk party leader, logistik, business report harian ("[A business report has been received from Submaster 'X'…]": pangan/kayu/bijih, usulan kebijakan, tren pertumbuhan hero); TIDAK bisa sintesis; tidak bisa diberikan ke pemain lain | [K]/[N] | ch.156, 157, 268, 98, 240 |
| Hukum formal | membunuh/mencuri/merusak properti = hukuman mati (aturan Taoni); mencuri suplai = kurungan/sintesis; ikut campur duel = dibunuh; ringleader mogok = sintesis (Tips) | [N]/[K] | ch.158, 113, 29, 48 |
| Hak hero | vacation sebagai reward; hobi/hiburan; istirahat setelah battle berat; bekal eksplorasi ("[Recommended – 3000G per person]") | [N] | ch.134, 230, 67 |
| Nama tampil | Chef=Juru Masak · Researcher=Cendekia · Instructor=Tetua Pelatih · Sub-master=Wakil Patriarch · Party leader=Ketua Regu | kulit | — |

### 5.5 Autonomous action [V0] — "core feature"
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Toggle | ON/OFF di Settings tab ("[If you want to stop unruly heroes, turn off the 'autonomous action' function!]") | [K] | ch.218, 262 |
| Saat master offline | hero bertindak otonom; daily dungeon bisa dimasuki sukarela; main dungeon terkunci | [N] | ch.12, 25 |
| Hasil | tergantung watak hero | [N] | ch.12 |
| Biaya | "[Autonomous action is activated!] [Master hero 'X' starts exploring!] [The dowry is automatically distributed to the hero. 10000G consumed.]" | [K] | ch.218 |
| Risiko | hero pergi ke dungeon berbahaya sendiri (2 minggu), bisa mati; master hanya bisa memutus via toggle | [N] | ch.218 |
| Usulan/request hero (semua V0) | join party ("['X' wants to join 'Party 3'. Do you allow it?]") · fixed party ("[Hero 'X' proposes a fixed party!]") · misi ("[Request – Go to the 25th floor] [Purpose – …] [Do you accept?]") · view records · Skill Book/potion/cheering (battle shop) · item ekspedisi ("asks for a 'leather backpack'") · modifikasi equipment · request fasilitas · request dungeon ("wants to go to the Forest dungeon") | [K] | ch.16, 30, 110, 108, 40, 78, 138, 244, 24 |
| Perintah majemuk (compound) | tidak bisa ditolak hero (§6) | [N] | ch.48 |
| Consumable | dipakai otomatis "when appropriate" | [N] | ch.36 |
| Aksi otonom in-mission | "[Hero 'X' comforts her teammates!] [The morale of the raid team is rising!]" | [K] | ch.222 |

### 5.6 Peri (fairy) [V0]
Satu peri per akun; pemandu tutorial & tips; menyampaikan instruksi master ("[The Master told me to come to the plaza when I log in!]"); "Fairy Power" saat sintesis item (efek numerik TERBUKA); tidak boleh menyentuh hero kecuali (1) hero menolak perintah pertama master, (2) hero menyerang dengan niat membunuh; tidak bisa mengabulkan request hero tanpa master [K]/[N] ch.4, 23, 55, 126, 24. Nama tampil: Roh Penjaga.

### 5.7 Party [V0]
| Parameter | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| UI | "[Form a party.]" → "[Drag and drop heroes!]" → "['X' joins 'Party 1'!]"; keluarkan "[Exclude 'X' from 'Party 4']"; party bisa dinamai bebas | [K] | ch.7, 24, 133, 177 |
| Maks anggota | **default 5** (dominan) · alternatif 6 (ch.2) | [N] | (TERBUKA: C4) ch.9, 17, 30 |
| Minimum | ada ("did not even fill the required number"); 4 boleh berangkat "tanpa memenuhi kuota"; angka pasti TERBUKA (default 3) | [K]/[N] | ch.14, 26, 245 |
| Jumlah party | tidak terbatas (Party 1–5+) | [N] | ch.16, 65 |
| Ukuran misi | 1 party (standar) · Medium = 2–3 party · Large = 5 party (25 hero) · Raid small = 5 party; "[If the number of party members is insufficient, use paid summons or free summons…]" | [K]/[N] | ch.36, 81, 114, 167 |
| Party leader | ditunjuk; leader mengusulkan komposisi ("['X' proposes a party composition!] ['Party 1' plan] […] ['Y' is excluded from 'Party 1'!]"); master accept/reject ("Accepting it is a master's ability") | [K] | ch.30, 73 |
| Temporary party | "['Temporary Party (Han Jenna)' has entered the Daily Dungeon]" | [K] | ch.25 |
| Ganti anggota | hapus dulu (kapasitas tetap); komposisi terkunci selama misi tertentu | [N] | ch.49, 132 |
| Tidak bisa dikirim | party mogok ("has become uncontrollable/inoperable"); hero detained; hero dengan "condition/thread" | [K] | ch.48, 128, 212 |
| Cap | "['Party 1' is the limit level, so you won't grow!]" | [K] | ch.271 |
| Nama tampil | Party = Regu | kulit | — |

### 5.8 Duel & mock battle [V0]
| Mekanik | Aturan kanon | Label | Sitasi |
|---|---|---|---|
| Duel hero vs hero | "['A' challenges 'B' to a duel!]" "[Tips/Duels are one of the means of resolving disputes between heroes. Depending on the agreement of both sides, special conditions can be imposed.]" → "['B' has accepted the duel.]" → "[The duel condition suggested by each hero is 'Synthesis'. Do you agree?]" (master menyetujui) → "['A' won the duel!]" | [K] | ch.28, 71 |
| Aturan | kedua pihak sepakat; selesai bila menyerah/jatuh; ikut campur = dibunuh; arena tanpa recovery; ~1 menit | [N] | ch.29, 71, 75 |
| Taruhan kanon | sintesis (kalah = disintesis); kursi party (kalah turun ke party 2) | [N] | ch.28, 71–73 |
| Mock battle (master vs AI) | "[Master 'X' proposes a mock battle…] [Type – 1 VS 1: Confrontation with AI] … [60 seconds until the game starts!]"; biaya 1 Warring Horse Statue (5.000 G)/papan; Hero lindungi base vs Monster hancurkan base; AI kendalikan unit, master beri strategi pra-game; melatih taktik master | [K]/[N] | ch.148, 166 |
| Mock battle antar akun | [V1+] | — | ch.166 |

## 6. MENTAL: STRES, LIKEABILITY, GIFT, MOGOK, PENDIDIKAN, TALENTA (rujukan: KANON_PMU_05)

### 6.1 Stres [V0] — nilai tersembunyi, hanya ambang yang tampil
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Sifat | nilai tersembunyi per hero, naik/turun; TIDAK pernah ditampilkan sebagai angka | [N] | ch.70 |
| Yang ditampilkan | (1) Tips "[Heroes get tired, depressed, or panic. Reduce your stress level!]" · (2) warning "[Hero 'X's stress level is dangerous!]" · (3) akibat "[Sudden death!] [Cause – Suicide due to stress]" | [K] | ch.7, 284 |
| 3 ambang | dangerous (warning) → sudden death (mati permanen di waiting room) · stress limit → Broken heart (5★; ability/skill/imprint turun, tidak bisa dikirim misi; sembuh via combat) | [K]/[N] | ch.284, 7, 212 |
| Angka ambang, laju naik/turun | TIDAK KETEMU | (TERBUKA — playtest; hanya struktur 3 ambang yang kanon) | — |
| Sumber stres (kanon, tanpa angka) | battle beruntun tanpa istirahat ("[Continuous battles tire the hero. You need to take proper rest…]") · menyaksikan kematian teman · melawan musuh humanoid · sintesis paksa/ancaman · jam riset berlebih · overtraining · tidak dilibatkan · beban administratif | [K]/[N] | ch.8, 42, 57, 48, 53, 70, 159, 162 |
| Penurun stres (kanon, tanpa angka) | istirahat/fasilitas istirahat (Bathhouse, Lounge) · gift · vacation · comfort item · hobi/hiburan · hero comfort teman ("[The morale of the raid team is rising!]") · cheering master · kesejahteraan/hak | [K]/[N] | ch.7, 48, 134, 166, 383, 222, 120, 157 |
| Pesan mati (sama dengan mati di battle) | "['X (★★)' has returned to the arms of the goddess. His fighting spirit will be remembered forever.]" | [K] | ch.7 |
| Ketidakpuasan | "['X' expresses dissatisfaction!]" (riset berlebih, masakan: "['X' is dissatisfied with the cooking.]" + Tips konsekuensi kolektif bila banyak yang tidak puas) | [K] | ch.53, 16 |
Status mental in-battle (Fear −30 % / Panic −50 % / Despair −80 % / Exhausted −90 %) → §3.6. Broken heart = [V1+] (5★).

### 6.2 Morale, makanan, asrama [V0]
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Morale | atribut party/raid; turun karena sintesis paksa; naik karena hero comfort/cheering; memengaruhi performa; angka TIDAK ada | [K]/[N] | ch.48, 222, 117 |
| Cheering | battle shop (§4.10): 50/100/100 gems; efek numerik (TERBUKA) | [K] | ch.120, 143, 201 |
| Makanan | Restaurant + Chef (rekomendasi); jenis makanan dari annex Accommodation; hierarki jatah per lantai (lantai 1 = kentang + air) sebagai alat kendali; makan malam 6:45 PM | [K]/[N] | ch.16, 64, 156 |
| Misi panjang | party bisa kelaparan → hero request backpack (canteen, firewood, tent, sleeping bag) | [K]/[N] | ch.78 |
| Asrama | kapasitas 20 awal; interior; storage barang hero terbatas; kemewahan berlebih → stagnasi | [N] | ch.10, 230, 156 |

### 6.3 Likeability [V0] — nilai tersembunyi, hanya reaksi yang tampil
| Reaksi kanon | Pesan | Sitasi |
|---|---|---|
| Naik | "['X' is delighted to receive the 'Y'.]" → "[Likeability has risen!]" | [K] ch.51, 121 |
| Turun | "['X' is disappointed to receive the 'Y'.]" → "[Lowered favorability!]" | [K] ch.107, 135 |
| Turun tajam | "['X' is greatly disappointed…" → "[Likeness has drastically decreased!]" | [K] ch.107 |
| Tidak berubah | "['X' has no change.]" (saat stres "dangerous") | [K] ch.284 |
| Hero minta | "['X' wants 'Y X 10'. Do you want to gift it?] [50000 gold will be consumed]" | [K] ch.128 |
Aturan: gift cocok → naik; tidak cocok → turun; cocok tapi stres tinggi → no change; gift berulang item yang diinginkan tetap naik (TIDAK ada diminishing di kanon); preferensi hero tidak ditampilkan (trial & error / hero "wants") [K]/[N]/[INF] ch.51–301. Efek mekanis likeability (bonus stat dsb.): TIDAK KETEMU → tidak dibuat; likeability tampak lewat perilaku (usulan, request, kepatuhan) (TERBUKA: hubungan likeability → peluang refusal). Skala numerik (TERBUKA, internal).

### 6.4 Gift shop [V0] — tabel kanon
| Gift kanon | Nama tampil | Harga | Reaksi terekam | Sitasi |
|---|---|---|---|---|
| Warring Horse Statue | Patung Kuda Perang | 5.000 G | delighted (berulang, ratusan kali); disappointed 1× (ch.107); no change saat stres | ch.51, 107, 121, 128, 253, 284 |
| White Horse Statue | Patung Kuda Putih | 8.000 G | greatly disappointed → drastis turun | ch.107 |
| Wreath | Karangan Bunga | 3.000 G | bahan sintesis | ch.146 |
| Flower Necklace | Kalung Bunga | 1.000 G | bahan sintesis | ch.146 |
| Mourning Warhorse Statue | Patung Kuda Berkabung | sintesis (3 di atas) | gift untuk hero berduka | ch.146 |
| Rabbit Headband | Bando Kelinci | 10.000 G | menyenangkan; kosmetik dipakai saat master online | ch.245 |
| Lumagini magazine | Kitab Bergambar | 7.000 G | appease hero detained | ch.128 |
| fluorescent rods, fine plates, pottery, grinding stones, board games, fur coats | — | (TERBUKA) | daftar katalog | ch.284 |
Preferensi per hero: (TERBUKA — internal per hero, tidak ditampilkan; default: tiap hero punya 1–2 gift favorit & 1 gift dibenci, di-roll tersembunyi saat summon — struktur [INF] dari reaksi kanon yang berbeda per hero pada item sama). Gift = objek fisik (bisa dihancurkan, dipajang di Display Stand, biaya mock battle) [N]/[K] ch.51, 146, 166.

### 6.5 Penolakan, mogok, riot [V0]
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Pesan | "['X' refused to participate!]" → "['Party 1' has become uncontrollable.]" · "[Mass strike!]" / "[Heroes are rioting!]" · "['Party 4' has become inoperable.]" · pulih: "['Party 1' has become operational.]" / "[Excellent Master. The hero has changed his mind!]" | [K] | ch.47, 48, 52, 65 |
| Tips 3 opsi | "[Tips/Heroes sometimes strike. You can resolve this by accepting their demands or punishing the ringleader.]" + opsi narasi: kirim party lain | [K]/[N] | ch.48 |
| Pemicu kanon | perintah misi dinilai tidak masuk akal/berbahaya · hierarki tidak adil (reward rata → hierarki lantai) · penolakan jabatan | [N] | ch.47, 65, 347 |
| Probabilitas/pemicu numerik | TIDAK KETEMU | (TERBUKA — fungsi stres/likeability/selisih kekuatan misi; playtest) | — |
| Batasan saat mogok | party tidak bisa dikirim misi; tetap konsumsi fasilitas; daily dungeon sukarela & latihan tetap jalan | [K]/[N]/[INF] | ch.48 |
| Compound command | perintah majemuk tidak bisa ditolak; format TIDAK dijelaskan | [N] · (TERBUKA) | ch.48 |
| Deputy/sub-master | tidak bisa menolak | [N] | ch.48 |
| Hukum ringleader | sintesis (praktik); ampun juga preseden | [N] | ch.66, 157 |
| Riot | label bersama mass strike; tidak ada mekanik kerusakan terpisah | [K]/[N] | ch.65 |
| Hero request retreat | "[Master hero 'X' requests to retreat from the field!]" (Yes/No) | [K] | ch.235 |
Nama tampil: refuse = "menolak titah" · strike = "mogok" · uncontrollable = "Regu membangkang".

### 6.6 Preseden pengganggu ketertiban (alat kanon yang tersedia untuk master) [V0]
(a) duel dengan syarat (§5.8) · (b) sintesis (ancaman & eksekusi) · (c) confinement (mekanik TERBUKA; hanya disebut) · (d) hukuman mati untuk kejahatan berat (aturan Taoni) · (e) demosi lantai/party · (f) toggle autonomous action. [K]/[N]/[INF] ch.28, 48, 113, 158, 160, 218.

### 6.7 Detained / appeased — [V1+] (hero rampasan, butuh rift).

### 6.8 Pendidikan & latihan [V0]
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Latihan mandiri | hero berlatih sendiri via AI di Training Center, berjalan saat master offline & terlepas dari misi | [K]/[N] | ch.243, 9, 48 |
| Hasil terukur mandiri | 3 hari in-game di TC Lv.1: Han 1★ stat 10→15 semua (+4 level) + Lesser Shield Skill Lv.1 baru; Jenna Archery Lv.1→2 | [K]/[N] | ch.9 |
| Laju skill | **mandiri ≈ 1 level weapon skill / 10 hari** · **dengan instruktur 6★ ≈ 1 level / hari** (10×) — satu-satunya rasio eksplisit | [N] | ch.98, 100 |
| Laju dengan instruktur ★ lebih rendah | TIDAK KETEMU | (TERBUKA — default interpolasi: instruktur ★ ≥ trainee + gap ★ menentukan pengali 1×–10×) | — |
| Stat dari latihan | stat naik dari latihan tanpa level (porsi tidak dipisahkan) | [N] | ch.9 |
| Instructor | jabatan di Training Center (Aaron → pendatang baru lantai 1; hero boleh menolak); kualitas instruksi bergantung rarity hero ("elementary vs college"); mekanik slot/bonus TIDAK diverbatimkan | [N] · (TERBUKA) | ch.73, 347, 211 |
| Skill Awakening | pesan "[Heroes' souls awaken in critical situations!] [Skill Awakening!]"; hasil: +1 level / +2–3 level / skill baru / evolusi; statistik 77 % combat, 17 % training, 5 % lain | [K]/[N] | ch.20, 140 |
| Latihan khusus kanon | Fire resistance (brazier, 4 hari) · Pain tolerance (melukai diri + health potion) · Throwing resistance (dihujani 21 panah, 2 hari) · sandbag/beban (10/30/50 kg) · sparring berpasangan (recovery off, bisa dying state) · formation training (1 minggu) · membaca (Library) · record viewing (Playstone) · renang 30 menit · tahan napas | [K]/[N] | ch.35, 34, 75, 22, 67, 76, 134, 108, 138 |
| Master mengarahkan | "training instructions" di training ground; menugaskan hero ke daily dungeon untuk leveling; setup sparring match; jadwal latihan harian (leader) | [N] | ch.132, 107, 75, 22 |
| Overtraining | latihan adiktif → "erosion"; battle + latihan tanpa istirahat → depresi; ambang jam TIDAK KETEMU | [N] · (TERBUKA) | ch.70, 42 |
| Pewarisan mekanis (sistem) | sintesis (skill warisan bawah sadar) · record reading · Skill Book · dispatch effect [V1+] · pengajaran senior/tukang (skill non-tempur) | [K]/[N] | ch.97, 108, 40, 156, 29 |
| Guru→murid (Muden→Aaron) | naratif: cara berpikir, pemicu dormant, jabatan+badge+nama keluarga, equipment; syarat & harga puluhan tahun realm — TIDAK ada mekanik sistem bernama → tidak dibuat sebagai mekanik ber-angka; ekspresinya di game = jabatan Instructor + pewarisan equipment (exclusive equipment hero mati masuk storage) | [N]/[INF] | ch.348–374, 313 |
| Niflheim Education | [V1+] (dispatch Lv.20+): 100 slot, 500 gems, 10 hari (iklan) vs ~1 bulan aktual (TERBUKA: C6), top 3 residensi, reward ranking 1 = U-grade | [N]/[K] | ch.86–107 |

### 6.9 Talenta — apa yang dibangun [V0]
| Fakta kanon | Konsekuensi desain | Label | Sitasi |
|---|---|---|---|
| Tidak ada satu pun jendela sistem yang menampilkan talent/potential/aptitude/constitution | TIDAK ADA UI talenta, TIDAK ADA grade tampil | [K] | status window ch.7–247 |
| "AI determines unique growth values despite identical training"; potensi tidak ditampilkan → master mengamati | ada nilai tersembunyi per hero yang memengaruhi laju growth; bentuk (TERBUKA, internal); master hanya melihat hasil | [N] | ch.1, 6 |
| Sistem menghitung kecocokan tersembunyi (imprint 93 % vs 2 %); aptitude imprint bawaan, tidak bisa dilatih | parameter bawaan dipakai rumus internal | [K]/[N] | ch.217, 218 ([V1+] untuk imprint) |
| Bintang awal ≠ talenta (2★ → 6★ Lydigion; rating dari fisik + skill terdaftar) | ★ = titik awal versi sistem yang bisa salah | [N] | ch.96, 346 |
| Latihan menjamin hasil sampai batas bakat lalu plateau; bakat rendah maju hanya lewat risiko nyawa | kurva growth per hero dengan asimtot tersembunyi (TERBUKA: bentuk kurva) | [N]/[INF] | ch.348, 353, 360 |
| Jalur non-tempur resmi bagi bakat tempur rendah | job Production/Gathering/Management + Instructor | [N] | ch.15, 157, 356 |
| Fear Resistance tersembunyi | ada; tidak tampil | [K] | ch.4 |
Yang TIDAK dibangun karena bukan kanon: Hidden Potential F–S ber-odds, Courage 1–10, Awakening di level tertentu, Pewarisan Sejati ber-angka.

## 7. MAIN DUNGEON / TOWER — 30 LANTAI LAUNCH (rujukan: KANON_PMU_06)

### 7.1 Struktur [V0]
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Layar utama | "[Climb the tower and save the world!]" + "[Main dungeon: Current number of floors to climb – N]" (N = lantai tertinggi clear, awal 0) | [K] | ch.8, 21 |
| Total | 100 nominal; terimplementasi 89–90 (TERBUKA: C8) → **V0 = lantai 1–30**; 31+ = update bertahap (KONSEP §11) | [N] | ch.259, 335 |
| Boss stage | tiap kelipatan 5 (5, 10, 15, 20, 25, 30); lonjakan kesulitan; boss stage tidak bisa diulang | [K]/[N] | ch.17, 243, 31 |
| Milestone konten | tiap kelipatan 10 (lihat §0) | [N] | ch.123 |
| Checkpoint | lantai 15/20/25/30 disebut "checkpoint"; efek TIDAK KETEMU selain regresi loop 36–40 ([V1+]) → V0 tanpa regresi | [N] | ch.76, 140, 167 |
| Level musuh | ≈ nomor lantai; level hero ≈ lantai (10 level per 10 lantai) | [N] | ch.46, 261 |
| Tempo | stage 1–15 ≈ 10 menit tempur; 16+ = labirin eksplorasi berhari-hari (in-game) | [N] | ch.77 |
| Waktu misi | ≈ 3× lebih cepat dari waiting room | [N] | ch.137 |
| Kesulitan per akun | bervariasi (random stage, luck) | [N] | ch.44 |
| Account level | = lantai tertinggi | [K] | ch.88 |

### 7.2 Header misi (format universal) [V0]
1. "[Floor N.]" → 2. "[Mission Type – X]" → 3. "[Goal/Objective – …!]" → 4. opsional "[Special Objective – Survival of NPC '…']" → 5. daftar musuh "[Nama Lv.N] X jumlah" (jumlah/level bisa "???") → 6. opsional timer "[30:00]" → 7. "[Warning!]" ×1–5 / "[Danger!]" → 8. boss: "[Title]" lalu "[Nama Lv.N]" [K] ch.8–295.

### 7.3 Tipe misi yang muncul ≤ lantai 30 [V0] — SATU engine, banyak objective
| Tipe (header) | Objective verbatim | Aturan clear | Lantai kanon | Nama tampil | Sitasi |
|---|---|---|---|---|---|
| Subjugation | "[Goal – Exterminate/Annihilate/Destroy the enemy!]" | semua musuh mati → exit terbuka | 1, 2, 4, 7, 8, 11, 12, 20, 30 (setelah berubah) | Penumpasan | ch.8, 11, 14, 26, 31, 32, 46, 56, 82, 116 |
| Survival | "[Goal – Survive from the incoming enemies!]" | timer "[30:00]"→"[00:00]" = clear; tidak boleh sembunyi di bangunan/keluar batas kota | 5 | Bertahan | ch.18–21 |
| Search | "[Objective – Search an unfamiliar place / the designated place!]" / "[Objective – ???]" | labirin, cari pintu keluar; objective bisa "???"; dinding transparan saat scouting | 6, 16, 30 | Penjelajahan | ch.26, 76, 115 |
| Defense | "[Objective – Stop the fall of the city!]" / "[Objective – Give the refugees time to escape.]" | objek pertahanan (Twin Goddess Statue) hancur = gagal = **semua hero mati seketika** | 10, 25 sub-quest | Pertahanan | ch.36–37, 111 |
| Escort | "[Objective – Protect designated person.]" | target NPC harus hidup; NPC tidak bertarung | 15, 26 | Pengawalan | ch.58–61, 113 |
| Escape | "[Goal – Get out of the city with the escort target!]" | keluar lewat gerbang; menghapus syarat subjugation | 15 (setelah berubah) | Pelarian | ch.59, 61 |
| Perubahan tipe mid-misi | "[Mission type has been changed.]" + header baru; Special Objective NPC tetap | Escort→Escape (15), Search→Subjugation (30) | — | — | ch.59, 116 |
| Sub-quest | branch di lantai; hero leader mengusulkan "[…suggests performing a sub-quest. Do you accept?]"; masuk "[There is a sub-quest you haven't completed.] [The mission will start from the moment the branch appears.]"; "[Quest cleared!]"; reward exp/gold/bonus stage | 25 | Tugas Sampingan | ch.109–112 |
| Bonus stage | "[Special reward!] [Bonus stage is open.] [The bonus stage can be challenged at the 'Gap of Time and Space'.] [Limit – Limited to 1 person per opportunity]"; labirin murni tanpa musuh; "[Reward – 5000G]"; berisi info lantai berikutnya | 25 | Alam Rahasia | ch.112 |
| Linked quest | rantai lantai mengunci re-entry: "[warning! Re-entry to that dungeon is not possible.]" | 6→7; 25–29 | — | ch.31, 113 |
Heist, Pursuit, Siege, Exploration, Conquest, Complex, Hunting, hidden stage, long-term mission, personal mission = [V1+] (lantai 33+).

### 7.4 TABEL PER LANTAI 1–30 [V0] — struktur & musuh kanon; sel "(TERBUKA)" = kanon tidak menyebut, diisi mengikuti pola blok
Blok: 1–10 goblin/hutan/kota · 11–15 skeleton & human soldier (humanoid mulai 12) · 16–19 labirin linked · 20 boss naga · 21–24 (TERBUKA, pola blok 20–25: human soldier) · 25–29 gurun lizardman (linked, tidak bisa diulang) · 30 boss patung kuno. Nama tampil musuh = kulit wuxia (kolom terakhir).
| Lt | Tipe | Objective verbatim | Musuh (nama+Lv+jumlah) | Medan | Timer | Party | Reward verbatim (gold + material) | Catatan kanon | Nama tampil musuh | Sitasi |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Subjugation | "[Goal – Exterminate the enemy!]" | "[Goblin Lv.3] X 4" (varian retry: Lv.2 ×3, Lv.4 ×2) | padang rumput; engage 10 m | — | 1 party | 7.000 G + Leather (C) ×1 + Iron Ore (C) ×1; retry ke-2: 1.000 G | tutorial: 1★ Lv.1 tenang bisa lewat; Fear/Panic menimpa 1★; percobaan pertama Amkena WIPE ("['Party 1' has been wiped out.] [You Lose!]") | Goblin → Setan Hutan Kecil | ch.7, 8, 11 |
| 2 | Subjugation | "[Goal – Exterminate the enemy!]" | "[Goblin Lv.3] X 2" + "[Plain Wolf Lv.4] X 2" | plains | — | 1 party | (TERBUKA) | semua kena fear −30 % | Serigala Padang | ch.10 |
| 3 | (TERBUKA: Subjugation) | — | goblin (TERBUKA) | — | — | 1 party | (TERBUKA) | hanya "MC di lantai 3" | — | ch.12 |
| 4 | Subjugation | "[Goal – Exterminate the enemy!]" | "[Goblin Lv.4 X 3]" "[Harpy Lv.6 X 2]" | hutan | — | 1 party (4 boleh) | 10.000 G + Leather (C) ×3 + Iron Ore (C) ×2 | ulang = musuh identik | Harpy → Burung Iblis | ch.14, 18 |
| **5 BOSS** | **Survival** | "[Goal – Survive from the incoming enemies!]" | "[Goblin Lv.? X 1846]" (gelombang, ~10 tembus barikade) | kota berbarikade; tidak boleh masuk bangunan/keluar kota | **[30:00]** → 00:00 clear | 1 party | 30.000 G + Iron Ore (B) ×3 + Leather (B) ×2 + Plank (B) ×2 | "Hero Grinder", "9 % chance of party surviving"; 2 dari 5 mati (Amkena); Skill Awakening; unlock daily dungeon | Gelombang Setan Hutan | ch.18–21 |
| 6 | Search | "[Objective – Search an unfamiliar place!]" | "[Goblin Lv.8 X 3]" (koloni puluhan tersembunyi) | rumput tinggi | — | 1 party (4) | (TERBUKA) | linked ke 7: re-entry tidak bisa | — | ch.26, 31 |
| 7 | Subjugation | "[Goal – Exterminate the enemy!]" | "[Goblin Lv.8 X 13]" | — | — | 1 party (3) | (TERBUKA) | — | — | ch.31 |
| 8 | Subjugation | "[Goal – Annihilate the enemy!]" | "[Goblin Rider Lv.9 X 27]" (+27 serigala) | — | — | 1 party (4) | 20.000 G + Iron Ore (B) ×3 + Wolf Skin ×5; retry: 3.000 G + Wolf Skin | ~20 tewas oleh 1 spell (cast 1 menit) | Penunggang Serigala | ch.32–33, 52 |
| 9 | (TERBUKA: Subjugation) | — | ~50 goblin | — | — | "butuh ≥2 party" (narasi) | (TERBUKA) | — | — | ch.34–35 |
| **10 BOSS** | **Defense** | "[Objective – Stop the fall of the city!]" | "[Goblin Lv.??? X 2213]" (utara) + "X 899" (timur) → "[Goblin Lv.9 X 19]" "[Ogre Lv.23]" "[Black Priest Lv.15]" "[Living Corpse Lv.??? X 2436]"; sekutu NPC "[Human Cavalry Lv.??? X 458]" "[Human Soldier Lv.??? X 353]" | kota berdinding (tembok luar→dalam→patung), 2 gerbang, hujan | — | **Medium: 2 party (10 hero)** | 70.000 G + Lesser Fire attribute stone | objek: Twin Goddess Statue (hancur = semua mati seketika); battle shop Skill Book 500 gems; 1 mati; unlock nama room, exploration dungeon, promosi | Ogre → Raksasa Gunung · Black Priest → Pendeta Hitam · Living Corpse → Mayat Hidup | ch.36–41 |
| 11 | Subjugation | "[Goal – Annihilate the enemy!]" | "[Skeleton Lv.11 X 14]" | — | — | 1 party (4) | 30.000 G + iron ore (C) ×3 + fine bone powder | strike pertama ("refused to participate") | Kerangka | ch.46–48 |
| 12 | Subjugation | "[Goal – Exterminate the enemy!]" | "[Human Soldier Lv.11 X 13]" (brainwashed) | — | — | 1 party (5) | 3.500 G + Leather (C) ×1 | musuh humanoid mulai; stres naik | Prajurit Sesat | ch.49, 55–56 |
| 13 | (TERBUKA: Subjugation) | — | (TERBUKA; pola: Human Soldier Lv.12–13) | — | — | 1 party | (TERBUKA) | "13–14 mudah" | — | ch.57 |
| 14 | (TERBUKA: Subjugation) | — | (TERBUKA) | — | — | 1 party | (TERBUKA) | party 2 "lulus" di 14 | — | ch.57, 76 |
| **15 BOSS** | **Escort → Escape** | "[Mission Type – Escort]" → "[Mission Success!] [Mission type has been changed.] [Mission Type – Escape] [Goal – Get out of the city with the escort target!]" | "[Human Soldier Lv.11] X 21" "[Human Knight Lv.21]"; 30+ prajurit | Silver Hall ~20 m, kota, gerbang kastil = exit | ~3 menit (escort) / ≤1 jam (escape) | 1 party (5) | 100.000 G + Iron Ore (A) ×3 | "[Special NPC 'Priasis All Ragna' joins the party!]"; poison; "[Party on the verge of extinction!]" tanpa korban | Human Knight → Ksatria Sesat | ch.58–63 |
| 16 | Search | "[Objective – Search the designated place!]" | "[Human Soldier Lv.14] X 18" "[Human Knight Lv.17] X 5" | labirin bercabang, pintu tersegel, linked multi-lantai | ~setengah hari | 1 party (5) | 50.000 G | puzzle dinding transparan; <5 menit tempur | — | ch.76–77 |
| 17 | Search (labirin lanjutan) | (TERBUKA) | (TERBUKA) | labirin, siang/malam, kelaparan | ≤3 hari | 1 party | (TERBUKA) | hero request leather backpack (canteen, firewood, tent, sleeping bag) | — | ch.78 |
| 18 | Search (labirin) | (TERBUKA) | (TERBUKA) | labirin | — | 1 party | (TERBUKA) | anggota tidak boleh berpencar (trap) | — | ch.79 |
| 19 | Search (labirin) | (TERBUKA) | (TERBUKA) | labirin | — | 1 party | (TERBUKA) | pola labirin berulang lintas lantai | — | ch.79 |
| **20 BOSS** | **Subjugation (medium)** | "[This mission is a medium-sized mission that requires three parties.] [This mission can sortie by dividing the advance party and the second party.]" | "[Half-Black Dragon Halgiraf Lv.42]" (Unique; "[This monster is immune to physical damage!]" "[…immune to magic!]"); "[Corrupted Shadow Lv.14] X???"; "[Human Soldier Lv.18] X 18→43→115"; "[Human Knight Lv.20] X 5→6→32" (wave) | altar 10 m, tower ballista, zona barrier | — | **Medium: 3 party (15 hero)** | 150.000 G + Dragon Heart (lower) + Black Dragon Scales (C) ×5 + Black Dragon Bone (C) | "['Party 2' occupied the altar.]" → Goddess' blessing (boss kena fisik); direbut → canceled; tim kedua & ketiga via "[Field configuration complete!]"; 2 mati, "15 masuk 8 kembali" | Halgiraf → Naga Hitam Setengah Jadi · Corrupted Shadow → Bayangan Ternoda | ch.81–85 |
| 21 | (TERBUKA) | — | (TERBUKA; pola blok: Human Soldier/Knight Lv.19–22) | — | — | 1 party | (TERBUKA) | party 2 aktif; 2 tewas di 21–24 | — | ch.104 |
| 22 | (TERBUKA) | — | (TERBUKA) | — | — | 1 party | (TERBUKA) | — | — | ch.104 |
| 23 | (TERBUKA) | — | (TERBUKA) | — | — | 1 party | (TERBUKA) | — | — | ch.104 |
| 24 | (TERBUKA) | — | (TERBUKA) | — | — | 1 party | (TERBUKA) | — | — | ch.104 |
| **25 BOSS** | Subjugation-like (tipe tidak dikutip) + **sub-quest Defense** + **bonus stage** | main: — · sub-quest: "[Floor 25. Sub-quest] [Mission Type – Defense] [Objective – Give the refugees time to escape.] [Special Goal – Survival of NPC 'Priasis All Ragna']" · bonus: labirin 1 orang | main: "[Lizardman Lv.21] X 355→415" "[Human Soldier Lv.18] X 103" "[Enmity Encounters!] [Lizardman VS Human Soldiers]" · sub: ~100 Lizardman, "[Lizardman Chief Lv.28]", "[Lizardman Lv.22] X 31" | gurun 35 °C+ (heat repellent 10 menit), desa 50 m | sub-quest timer "[00:04:38]" | 1 party (5) | main: 200.000 G · sub: 100.000 G + "[Bonus stage is open.]" · bonus: 5.000 G | "[Tips/Sometimes enemies collide with each other on missions…]"; rekaman mulai lantai 25; linked 25–29 tidak bisa diulang | Lizardman → Manusia Kadal · Chief → Kepala Suku | ch.108–112 |
| 26 | Escort | "[Objective – Protect designated person.]" | "[Lizardman Lv.24] X 15" | gurun (exhaustion/heatstroke) | <3 menit | 1 party (5) | 50.000 G + Essence of the Desert | — | — | ch.113 |
| 27 | Linked quest (TERBUKA: Subjugation) | — | (TERBUKA; lizardman Lv.25–27) | gurun | — | 3 party (15) | (TERBUKA) | linked 25–29 | — | ch.113 |
| 28 | Linked quest (TERBUKA) | — | (TERBUKA; lizardman) | gurun | — | 3 party | (TERBUKA) | **bisa diraid berulang untuk leveling** (pengecualian) | — | ch.113 |
| 29 | Linked quest (TERBUKA) | — | (TERBUKA; lizardman) | gurun | — | 3 party | (TERBUKA) | linked | — | ch.113 |
| **30 BOSS** | **Search → Subjugation (large)** | "[Mission Type – Search] [Objective – ???] [Special Objective – Survival of NPC 'Priasis All Ragna']" → "[Mission type has been changed.] [Mission type – Subjugation] [Goal – Destroy the enemy!]" | "[Ancient Stone Statue Lv.???]" (~300 m, self-defense 6 tahap); "[Monster Wave!] [Round 4–6]": Lizardman Lv.23 / Rider Lv.25 / Magician Lv.26 ("[Sorry! Too many numbers!]"); "[Lizardman Lv.25] X 37"; "[Lizardman Fighter Lv.30]"; "[X/Y/Z Sorcery Golem Lv.33–35]" → "[Combined!] [XYZ Super Magic Ultimate Golem Lv.46]"; "[Elite Lizardman Fighter Lv.32]"; "[Magic seeker Kurushak Lv.35]" | gurun, badai pasir, patung raksasa (interior = room of trials), extraction exit 5 menit | — | **Large: 5 party (25 hero)** — "If the number of party members is insufficient, use paid summons or free summons to recruit heroes!" | 300.000 G + magic parts (lower) ×3 + Mercury (C) ×5 | "[Configuring the field.]" saat boss; battle shop cheering stick 50 gems; raid leader usul ganti party leader; advance party musnah <5 menit; 2 mati; "[Congratulations on clearing the 30th floor of Master!]" | Ancient Stone Statue → Arca Kuno Penjaga · Golem → Golem Sihir | ch.114–121 |
Aturan pengisian (TERBUKA): musuh & reward lantai kosong diinterpolasi dari lantai tetangga di blok yang sama; reward TIDAK harus monoton (kanon: L12 3.500 G < L11 30.000 G). Skala party per lantai: 1 party default; 2 party (10); 3 party (20, 27–29); 5 party (30) [K]/[N].

### 7.5 Alur masuk misi [V0] — urutan pesan kanon
1. Form party (drag-drop) → 2. "[Collect to the 1st party plaza!]" → 3. peringatan skala bila multi-party ("[※Caution!] [This mission is a medium-sized mission that requires two parties…]") → 4. tips consumable ("[Have 'X' carry the 'Low Life Potion'!]") → 5. "[Select 'Party 1'… Do you agree?]" → 6. "[Open the space-time!]" → 7. "[The main dungeon's current challenging floor is N.]" → 8. "[The door will open in 10 seconds. Get ready!]" → 9. (lantai ≥25) "[Recording the mission. Your play record will be preserved.]" → 10. (Tactical Post ada) "[The tactic center is in operation. You can use the tactics tab.]" → 11. header misi (§7.2); boss: "[Warning!]" + "[Configuring the field.]" → 12. hero muncul di starting area [K] ch.7–167. Retry: "[Selected floor number N. Do you want to try again?] [Yes / No]" [K] ch.11. Hero mengusulkan misi (§5.5). Main dungeon TERKUNCI saat master offline [N] ch.25.

### 7.6 Raid multi-party & tim susulan [V0]
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Skala | 1 party (default) · Medium 2 party (L10) · Medium 3 party (L20) · Large 5 party (L30) | [K] | ch.36, 81, 114 |
| Advance/second party | "[This mission can sortie by dividing the advance party and the second party.]" (L20) | [K] | ch.81 |
| Pemicu tim susulan | HANYA setelah "[Field configuration complete!] [Masters can now be deployed.] [Reach a helping hand to heroes in crisis!] [Selection of the second team.] [Designated parties – '1st party (participating)' '2nd party'…] [Do you want to send them to the mission?]"; status party "(participating)"/"(in combat)"; tim ketiga bisa menyusul; hero susulan muncul di starting area | [K] | ch.82, 83, 168 |
| Tanpa pemicu | tidak bisa memanggil party tambahan | [N] | ch.137 |
| Raid leader | ditetapkan saat compose ("[Raid Leader – 'X']"); dapat mengusulkan ganti party leader mid-mission ("[The raid leader 'X' proposes to change the party leader.] […] [Are you sure you accept?]") | [K] | ch.167, 117 |
| Anggota buruk | bisa dicabut mid-misi (raid) | [N] | ch.168 |
| Komunikasi | hero→master private channel; hero antar party via earpiece/telepati | [K]/[N] | ch.115, 222 |

### 7.7 Clear, keluar, wipe, retry, reward [V0]
| Aturan | Nilai kanon | Label | Sitasi |
|---|---|---|---|
| Urutan clear | "[Stage cleared!]" → "['X' level up!]" (semua yang bertahan & berkontribusi) → "[Reward – …]" → "[MVP – 'X']" → (boss) "[Congratulations on clearing the Nth floor of Master!]" → "[Go back to the square. I'm going to close the door.]" → "[The hero returns to the waiting room.]"; survivor pulih via white light; time freeze saat reward | [K]/[N] | ch.4–229 |
| Keluar sebelum selesai | **TIDAK ADA**: tidak ada jalan keluar selain pintu awal; "Escape diblokir sampai objective selesai"; "No retreat during active mission"; (prompt "[Are you going to leave?]" hanya L44 — [V1+]) | [N]/[K] | ch.25, 117, 228, 200 |
| Gagal | Defense: objek hancur = **semua hero mati seketika di mana pun berada**; Survival: mati = gagal; party wipe: "['Party 1' has been wiped out.] [You Lose!]"; peringatan "[Party on the verge of extinction!] [The state of the master party is in danger!]" | [K]/[N] | ch.37, 7, 62 |
| Kematian | "['X (★★)' has returned to the arms of the goddess. His fighting spirit will be remembered forever.]"; permanen; gear yang dipakai hilang; item hero mati → storage/archive | [K]/[N] | ch.7, 10, 146 |
| Death protection di tower | TIDAK ADA (hanya PvP <40 & event = [V1+]) | [K]/[N] | ch.7–41, 125 |
| Retry | lantai yang sudah clear bisa dipilih ulang; musuh identik; reward turun (7.000 → 1.000 G; 20.000 → 3.000 G); boss stage & linked quest (25–29) tidak bisa diulang; pengecualian L28 bisa diraid berulang; retry ke-3+ (TERBUKA) | [K]/[N] | ch.11, 18, 52, 113 |
| Exp | hanya kontributor; MVP bonus exp (besaran TERBUKA); efisiensi exp turun di lantai rendah | [K]/[N] | ch.11, 85, 56 |
| MVP | 1 per stage clear; ditentukan performa (kriteria TERBUKA; default: kontribusi damage/kill/objective) | [K]/[N] | ch.4, 11 |
| Long-term mission | [V1+] (L34+) | — | ch.138 |
| Loop chances & regresi | [V1+] (L36–40) | — | ch.163–167 |
| Time limit antar-lantai | [V1+] (L45→50) | — | ch.203 |

### 7.8 Alat master dalam misi [V0]
| Alat | Aturan kanon | Angka | Label | Sitasi |
|---|---|---|---|---|
| Tactics (Tactical Post) | "[Tips/Tactics can be used in a limited way within missions.] [You can use it freely at the beginning of the mission, and a penalty will be added when the mission starts in earnest.] [As the level of the tactical post increases, more diverse functions are added.]"; tactical tool = panah waypoint, "[Touch and drag to give tactical instructions to the heroes.]"; hero tetap otonom (tidak 100 % patuh); tanpa target → AI | penalti & durasi per level (TERBUKA) | [K]/[N] | ch.148, 200, 221, 276 |
| Battle shop | terbuka saat boss / hero request; 5 item (§4.10) | 50/100/100/500/500 gems | [K] | ch.40–201 |
| Cheering | "[Slide the screen left and right!] [Hero Show the master's support!]" (goyang layar/HP); hero merespons ("expresses himself!") | efek (TERBUKA) | [K] | ch.120, 202 |
| Weapon summon | "[The master party is in crisis! Weapon summoning is recommended.] [A magician is required…]"; 3× per misi | — | [K]/[N] | ch.102, 138 ([V1+] butuh senjata bernama) |
| Manual control langsung | kanon bertentangan (ch.34/159 "bisa" vs ch.163 "hanya menonton dari balik barrier") → **default V0: master TIDAK mengontrol langsung**; hanya tactics/battle shop/cheering | — | [N] · (TERBUKA) | ch.34, 159, 163 |
| Peta misi | lingkaran merah = radius deteksi boss; titik hitam = base item; ikon = posisi | — | [K] | ch.137 ([V1+] L34) |
| Rekaman | "[Recording the mission…]" mulai L25; "[Recording complete!] [Video saving has been completed…]"; screenshot | — | [K] | ch.110, 63, 50 |
| Hero request in-mission | Skill Book / potion / cheering / retreat (Yes/No) | — | [K] | ch.40, 200, 201, 235 |
| Consumable bawaan | "[Have 'X' carry the 'Low Life Potion'!]"; 2–3 potion/orang; bisa pecah | — | [K] | ch.36, 57 |
| Item medan | Goddess Statue, Dimension Summoning Stone, Sailboat, Tears of mermaid, Key = [V1+] (L30+/L34) — kecuali altar L20 (occupy → blessing) & Twin Goddess Statue L10 (objek defense) | — | [K] | ch.83, 37 |

### 7.9 Luka, status, time limit [V0]
Luka sembuh di waiting room (Continuous Recovery); di misi: potion (§4.7), istirahat 5 menit; status in-mission: Bleeding, Poisoned, Paralysis, Fear/Panic/Despair/Exhausted (§3.6); kelaparan di labirin L16+ [K]/[N] ch.8, 21, 78. Timer: Survival 30:00 (L5); Escort ~3 menit + Escape ≤1 jam (L15); sub-quest Defense 04:38 (L25); pintu 10 detik [K] ch.19, 58, 111.

### 7.10 Combat engine — apa yang kanon tentukan [V0]
| Elemen | Kanon | Label | Sitasi |
|---|---|---|---|
| Otomatis | "[The battle proceeds automatically. Enjoy high-level battles by hero's internal AI!]"; hero memilih taktik/formasi sendiri | [K]/[N] | ch.3, 1 |
| Input stat | 4 stat (STR/INT/STA/AGI) + skill level/tier + status effect % + kompatibilitas/bond + equipment grade | [K]/[N] | ch.7, 210, 49 |
| Resource | HP, Stamina, Mana terpisah (bar) | [K]/[N] | ch.20, 35 |
| Kematian | HP 0 = mati permanen (tidak ada roll gugur terpisah); "dying state" sebelum mati | [K]/[N] | ch.41, 7 |
| Casting | sihir area cast ~1 menit, wizard tidak bisa bertahan saat cast; friendly damage api | [N] | ch.33, 158 |
| Rumus damage/HP | TIDAK KETEMU | (TERBUKA — internal engine; kalibrasi via simulasi headless saat build: win-rate, death-rate, wipe-rate per lantai) | — |

## 8. DAILY DUNGEON & EXPLORATION DUNGEON (rujukan: KANON_PMU_07 §7.1–7.2) [V0]

### 8.1 Daily dungeon (unlock lantai 5)
| Aturan | Nilai kanon | Nama tampil | Label | Sitasi |
|---|---|---|---|---|
| Menu | "[Dungeon feast that changes every day!]" → "[Dungeon of the week: Singmirel Plateau (11 hours)]" "[Collect various rare materials!]" | Alam Rahasia Harian | [K] | ch.8, 25 |
| Jadwal | Senin–Selasa **Isralta Mine** (iron ore, upgrade stones, Regeneration Stone prob. rendah; cave snake) · Rabu–Kamis **Kandert Forest** (Queen's Blood, Queen's Horn, deer hide, boar meat, twig, Lower wind attribute stone D-; forest deer, Queen of the Forest Lv.10 rare spawn) · Jumat–Sabtu **Singmirel Plateau** (Highland Chaser Leather, Sharp Fang, Life Herb, Plateau Water, lower attribute stones; Highland Chaser Lv.10) · Minggu ketiganya terbuka | Tambang Isralta · Hutan Kandert · Dataran Singmirel | [K]/[N] | ch.23–25, 108 |
| Durasi | 11 jam (in-game); timer sisa tampil | — | [K] | ch.25 |
| Entri | 1 hero = 1× per hari; masuk lewat cermin ("[The aisle is open. Just go inside the mirror!]"); "['Temporary Party (X Y)' has entered the Daily Dungeon]" | — | [N]/[K] | ch.24, 25 |
| Otonomi | satu-satunya dungeon yang hero boleh masuki sukarela tanpa master; hero request "['X' wants to go to the Forest dungeon.]"; peri tidak bisa mengabulkan tanpa master | — | [N]/[K] | ch.25, 48, 24 |
| Master mengarahkan | kirim party & tentukan jenis item yang dikumpulkan | — | [N] | ch.24, 67 |
| Komposisi rekomendasi | 4 gatherer + 1 escort; gathering butuh skill (Herbalist) tapi bisa dilewati bila nama item tervisualisasi | — | [N] | ch.25 |
| Pesan | "['X' has collected 'Queen's Blood'.]" … "[Mission complete!] [The hero returns to the waiting room.] [List of obtained items]" | — | [K] | ch.24 |
| Portal | bahan dikumpulkan sebelum portal; mundur lewat portal = kehilangan portal; item tak terdaftar lenyap; auto-return saat timer habis | — | [N] | ch.23–25 |
| Reward contoh | "[Reward – 3000G Wolf Skin]" | — | [K] | ch.52 |
| Skill Awakening | bisa terjadi ("['Jenna' has acquired the 'Forest Hunter' skill!]") | — | [K] | ch.24 |
| Risiko | hero bisa mati (Queen of the Forest Lv.10) | — | [N]/[INF] | ch.24 |
| Drop rate, level monster per tier, jumlah party/hari | TIDAK KETEMU | — | (TERBUKA) | — |
| Tier baru | "[Low Dungeon of the Week]" lantai 20; "[A new daily dungeon]" lantai 30 | — | [K] | [V1+] ch.85, 123 |
Fungsi ekonomi: sumber attribute stone (promosi), bahan consumable (Alchemy), bahan crafting, Regeneration Stone [K]/[N] ch.36, 55, 108.

### 8.2 Exploration dungeon (unlock lantai 10)
| Aturan | Nilai kanon | Nama tampil | Label | Sitasi |
|---|---|---|---|---|
| Menu | "[Exploration Dungeon: Explorable (Heim Peninsula)]" "[Collect various rare materials!]" → "['1st party' starts exploring!]" "[Exploration location – Heim Peninsula]" "[Remaining time until return – 48:00:00]" | Perjalanan Jauh: Semenanjung Heim | [K] | ch.67 |
| Unlock pesan | "[Exploration dungeon has been opened. Gather rare materials including Advent Stones!]" | — | [K] | ch.41 |
| Durasi | 48 jam timer waiting room (hero melihat "expected return time – 45 hours"); Research Dungeon Advanced memperpanjang (angka TERBUKA) | — | [K] | ch.67, 69 |
| Dowry | "[Give the dowry to the Master Hero! The exploration of the heroes will be easier.] [Can you give the hero gold?] [Recommended – 3000G per person]"; 1 koin emas = 1.000 G; otonom = 10.000 G otomatis | Bekal Perjalanan | [K]/[N] | ch.67, 218 |
| Hasil | Advent Stone, attribute stone, item eksklusif, Regeneration Stone; "reward tak terduga"; tanpa objektif jelas | — | [N] | ch.41, 68 |
| Risiko | hero bisa mati (lebih rendah dari main); dinding transparan membatasi; "mess around" → tidak bisa kembali | — | [N] | ch.67–69 |
| Lokasi | 1. Heim Peninsula (L10) · 2. Halseah (L20) [V1+] · 3. Kaia (L30) [V1+] | — | [K] | ch.41, 85, 123 |
| Efek dowry numerik, tabel hasil, cooldown | TIDAK KETEMU | — | (TERBUKA) | — |

### 8.3 Advent Dungeon — [V1+] (butuh slot imprint 4★). Yang [V0]: Advent Stone terkumpul; Advent Dungeon pernah terbuka tanpa stone saat notif promosi ("[Advent dungeon opens!] Difficulty – Superb", ch.42) → (TERBUKA: apakah dibuka di V0 sebagai konten "coba & mundur"; default: TIDAK, disimpan V1+).

---

## 9. KONTEN [V1+] — STRUKTUR KANON DICATAT, TIDAK DIBANGUN DI V0 (rujukan: KANON_PMU_07 §7.3–7.13)
| Konten | Syarat kanon | Inti mekanik kanon (ringkas) | Sitasi |
|---|---|---|---|
| Dimensional Rift | akun Lv.20, gratis, irreversible; mencabut proteksi Lv.1; konfirmasi ganda | menu Dispatch/Expedition/Event; koordinat & sektor | ch.87–88 |
| Dimensional Cafe, Trading Board, channel chat, whisper, friend | Lv.20 | tulis/baca ≥Lv.20; channel per sektor | ch.123 |
| PvP invasi | rift terbuka | airship menyerang saat master offline; alarm facility; security system; loot log "[※Loss Information]"; death protection s.d. Lv.40 (TERBUKA: C5); hero rampasan detained → appeased; fasilitas rusak turun level | ch.124–129, 88, 125 |
| Airship | Lv.40 operasi (event); blueprint + dimensional core + engine + 4 part + magician | port call, trade 1.500 gems, leap, fasilitas onboard, manual minigame (tilt/gas/rem/boost), shield, "[This mission requires an airship!]" L49 | ch.88, 89, 137–139, 221 |
| Dispatch & Niflheim Education | Lv.20+, belum job change, 500 gems | ~1 minggu; dispatch effect; 100 slot, 10 hari vs 1 bulan (TERBUKA: C6) | ch.86–107, 150 |
| Guild | satu sektor | leader/temporary/formal member; guild chat; hostile | ch.204–208 |
| Ruins & occupation war | lantai 30 (sektor grade 8) | jewels → gems; menduduki objek = menang; 5 hero/user | ch.123, 204–210 |
| Imprint / Advent Dungeon | 4★ (lantai 40) | slot 1/2/3; success 93 % vs 2 %; contaminated; grade C+ → SS- | ch.175–218 |
| Promosi 4★+ | Lv.40 + lantai 40; 5★ Lv.55; 6★ Lv.70 external center | peluang gagal → contaminated | ch.161–263 |
| Festa / Dimensional City / World Raid | event | Battle Royale, turnamen, 3v3, Airship Racing; 5★ ticket | ch.177–188 |
| Tower 31–100 | progres | laut 31–35, loop chances 36–40 (regresi ke 31), Order Army 40–50, airship 49–50, Wailing Wall 80, Demon Wall 90 | KANON_06 |
| Long-term mission, personal mission, hidden stage | L34+ | update saat logout; 1 orang | ch.136–198 |
| Sub-master laporan bisnis | (V0 bila ada hero ditunjuk — lihat §5.4) | "[A business report has been received…]" | ch.268 |
| Broken heart, Exceed, magical state, contaminated | 4★–6★ | — | KANON_02/05 |
| Hall of Fame, ending, 7★, Book of Reversal | clear semua | KONSEP §11 | ch.214–215, 291 |

---

## 10. YANG MASIH (TERBUKA) — DAFTAR KONSOLIDASI UNTUK PLAYTEST/SIMULASI SAAT BUILD
Semua di bawah = kanon TIDAK memberi angka; wajib diisi lewat simulasi headless/playtest, bukan dikarang sebagai kanon. Konstanta kanon yang SUDAH terkunci (0,1 % 5★, 10 × Lv exp, Fear −30 %, 500 gems, 10.000 G, 10 detik pintu, 11 jam daily, 48 jam exploration, 87 %/54 % sintesis, 10 gems/jam riset, 150 poin, 1 level skill/10 hari vs 1/hari, cap 10/20/40, party 5, 30:00 survival, reward gold L1–L30) TIDAK boleh diubah oleh playtest.
1. Odds 1★/2★/3★ summon biasa & advanced (konstanta 4★ <1 %, 5★ 0,1 %).
2. Rumus damage/HP/Stamina/Mana internal engine; growth per level per ★ (arah kanon: 1★ ≈4, 2★ ≈5–6, 3★ ≈6, acak, bisa turun).
3. Nilai tersembunyi growth per hero (bentuk & rentang) + asimtot bakat.
4. Rumus exp sintesis per bahan; peluang skill dari sintesis.
5. Stres: angka 3 ambang, laju naik/turun per sumber kanon.
6. Likeability: skala internal, preferensi gift per hero, hubungan ke refusal.
7. Probabilitas refusal/strike; format compound command.
8. Bonus Bond / Compatibility / Enmity.
9. Harga fasilitas selain 500 gems; efek per level fasilitas; kapasitas Accommodation per level; biaya riset Lv.2+.
10. Efek numerik jabatan (Chef/Instructor/Manager), Fairy Power, cheering, MVP bonus exp, penalti tactics per level.
11. Musuh & reward lantai kosong (3, 9, 13–14, 17–19, 21–24, 27–29) mengikuti pola blok; retry ke-3+; kriteria MVP.
12. Drop rate daily/exploration; efek dowry; perpanjangan stay per level riset.
13. Katalog: puzzle crafting selain grid putar; resep selain iron sword; potion (HP pulih, resep); gift tanpa harga; dekor.
14. Konflik kanon C1–C8: default sudah dipilih di berkas ini (C1 1:3 · C2 = lantai · C3 10×Lv · C4 5 · C5 [V1+] · C6 [V1+] · C7 eksklusif · C8 30 lantai launch/89 total) — pemilik boleh menukar.
15. Kurs won → Robux untuk gems/gold (KONSEP §5).
16. Reroll/hapus akun; kapasitas warehouse/mailbox; sumber nama waiting room.
