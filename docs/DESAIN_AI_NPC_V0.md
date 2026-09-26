# DESAIN AI NPC V0 — "M0 KEHENDAK BEBAS NPC": HERO SEBAGAI MAKHLUK HIDUP (TANPA LLM RUNTIME)

Terakhir diperbarui: 26 September 2026, 19:55 WIB

## 0. TUJUAN, SUMBER, CARA MEMBACA

**Tujuan M0 [FINAL, dari pemilik]:** hero terasa benar-benar hidup seperti di novel/manhwa *Pick Me Up* — pemain tidak merasa "ini AI", dan sedih (sampai menangis) saat hero-nya mati. Ukuran keberhasilan ada di §9.

**Urutan perancangan yang dipakai (aturan pemilik):** (1) kanon dulu → `claude/RISET_NPC_Bukti_Perilaku_Kanon.md` (novel) dan `claude/RISET_Manhwa_Screenshot_Observasi.md` (manhwa, data primer pemilik [T-gambar]) (236 baris bukti perilaku hero ch.1–400, peta relasi, kematian & duka, kehendak bebas, sifat per hero); (2) ilmu manusia untuk celah yang kanon tidak jelaskan → `claude/RISET_NPC_Psikologi_Manusia.md` (55 sumber, tiap klaim berlabel KONSENSUS/DIBANTAH/PERDEBATAN); (3) tiap temuan psikologi dicocokkan ke bukti kanon — yang tidak cocok dibuang; (4) baru rumus. Game lain (Sims/RimWorld/DF/CK) **tidak** dipakai sebagai sumber isi; hanya bukti bahwa "riwayat relasional + peristiwa unik" cukup memicu duka pemain (Boatmurdered, liputan RimWorld — RISET_Psikologi §6).

**Prinsip populasi [FINAL, dari pemilik 24 Sep 23:55]:** tidak ada kategori psikologis yang di-roll langsung sebagai label ("25 % penyendiri", "10 % ringleader"). Watak = **genetik** (roll sifat saat summon) × **lingkungan** (pengalaman yang mengubah keadaan dan, perlahan, sifat). Proporsi populasi apa pun harus **muncul sendiri** dari distribusi sifat + riwayat; angka proporsi di berkas ini hanya *hasil yang diharapkan* untuk verifikasi §9, bukan parameter. ★ mewakili **pengalaman awal** (1★ warga sipil, 3★ sudah tahu harus bertarung [N] ch.10), bukan watak — watak tidak berkorelasi dengan ★.

**Keputusan final lain (tidak dibuka ulang):** 100 % kanon PMU; permadeath tanpa revive; TANPA LLM saat runtime (LLM hanya offline untuk menulis teks); catch-up saat login (RENCANA §3.2) **termasuk sudden death saat pemain offline** (setia kanon ch.7, keputusan pemilik 24 Sep 23:55 — lihat §8.1); skema key terpecah + `schemaVersion`; "cinta" dibangun sebagai **Ikatan Sumpah** non-romantis (§6.8 — deskriptor "romantic themes" Roblox hanya ada di label Restricted 17/18+; kanon PMU memakai sebutan keluarga "older brother/sister" ch.387, 396, bukan romansa); ikut campur duel = dibunuh (ch.29) **OFF final untuk V0** (§6.4).

**Label:** [K] teks sistem verbatim · [N] narasi kanon · [INF] inferensi dari kanon · [PSI] temuan psikologi (sumber di RISET_Psikologi, nomor rujukan disebut) · (TERBUKA) angka default untuk simulasi, dikalibrasi §9 — bukan kanon. **Semua angka di berkas ini (TERBUKA) kecuali berlabel [K]/[N].** Rujukan bukti: `BK-1/2/3 #n` = baris ke-n tabel A pada RISET_NPC_Bukti_Perilaku_Kanon bagian 1/2/3.

**Empat aturan rekayasa (mengikat implementasi):** (1) semua nilai NPC tersembunyi — tidak pernah tampil sebagai angka, tidak pernah lewat Remotes; yang tampil hanya pesan sistem kanon + entri log (§7); (2) semua RNG lewat `Shared/Rng.luau` berseed `(profileSeed, heroId, dayIndex, slot)`; (3) pure Luau tanpa Instance/Player — jalan headless & di server (coroutine); (4) semua angka di `NpcData.luau`/`IdioData.luau` dengan komentar `-- TERBUKA`, diletakkan di **ServerStorage** (bukan ReplicatedStorage) agar koefisien tidak ter-replikasi ke klien dan tidak bisa di-datamine (keputusan pemilik 26 Sep, LAPORAN 2026-09-25 Q8); logika di `Autonomy/`, `Mental/`, `Social/`.

**Batas skala:** ≤2.000 hero hidup/pemain (RISET_Batas_Teknis §4); hero ≤900 byte JSON (RENCANA §3.3). Ukuran `npc` terukur jauh di atas estimasi awal (lihat §1.6: hero dengan `npc` lengkap 1.368 byte); bila hero melampaui 900 byte, relasi + memori pindah ke key `social_N` (TERBUKA, putuskan di M1 5.3).

---

## 1. SIFAT (TRAIT): SIAPA HERO INI

### 1.1 Apa yang kanon tunjukkan
Hero "demand, assert, refuse, or obey orders independently" [K] ch.1; ada stat tersembunyi yang tidak tampil (Fear Resistance) [K] ch.4; hero bintang sama berperilaku beda: Jenna stabil dan tidak pernah mogok sendiri (BK-1 #E), Belquist nekat mengambil peluang 2 % dan pergi sendiri (BK-2 #39–40), Aaron menahan diri saat sparring dan menolak jabatan (BK-1 #43; BK-3 #38), Han kolektor sentimental yang tetap pragmatis-kejam (BK-1 #8, #11, #34), hero tanpa nama berbohong dan mencuri (BK-1 #12, #60), Katio marah dan pilih-pilih (BK-1 #64, #68). Sifat **hampir tidak berubah** oleh peristiwa: Han tetap kolektor dari 2★ (ch.51) sampai 7★ (ch.301); yang berubah adalah keadaannya ("no change" saat stres ch.284).

### 1.2 Model yang dipakai: 6 dimensi HEXACO + 1 kanon
[PSI §1] HEXACO dipilih di atas Big Five karena dimensi **Honesty-Humility** memprediksi mencuri/berbohong/mengkhianati lebih baik — dan kanon memang punya hero yang mencuri suplai, berbohong saat weeding out, memeras (BK-1 #12, #60, #80). Dimensi ketujuh adalah **nyali** = Fear Resistance kanon [K] ch.4, karena kanon memisahkannya dari emosionalitas umum (1★ panik di battle pertama, 3★+ tenang [N] ch.10).

| # | Dimensi (kode) | Rendah ↔ tinggi | Perilaku kanon yang dijelaskan | Sitasi |
|---|---|---|---|---|
| 1 | **Jujur-rendah hati** (`H`) | licik, tamak, gila hormat ↔ tulus, adil, rendah hati | mencuri suplai; berbohong; memeras; vs Han menolak bantuan 1 juta gems demi aturan | [N] ch.113, 17, 158, 95 |
| 2 | **Emosionalitas** (`E`) | dingin, tak gentar ↔ cemas, sentimental, butuh dukungan | Nerissa kewalahan; Han koleksi patung sebagai penenang; Katio indignant; vs Jenna "eksekutor solo" tanpa emosi terekstrak | [N] ch.162, 273; [K] ch.127; BK-2 #E2 |
| 3 | **Ekstraversi** (`X`) | pendiam, penyendiri ↔ suka bergaul, vokal, memimpin | Edith persuasif & pemimpin lapisan kedua; Han vokal mengusulkan; vs Katio scout sendiri, Nerissa jalur admin | [N] ch.105, 219; [K] ch.30, 110; BK-2 §B |
| 4 | **Keramahan** (`A`) | pemarah, pendendam, kritis ↔ pemaaf, lembut, sabar | Mazel–Tasir–Stein saling memusuhi begitu disummon; Aaron "menahan diri" & tanpa dendam saat didemosi; Muden "arogan-jujur" | [K] ch.49; [N] ch.72–73, 348 |
| 5 | **Kesungguhan** (`C`) | malas, impulsif ↔ disiplin, tekun, teratur | Han menetapkan latihan wajib; Iolka 20 jam/hari; Aaron "genius for hard work"; intensitas latihan sukarela bervariasi | [N] ch.22, 140, 351, 63 |
| 6 | **Keterbukaan** (`O`) | konvensional, bosan lambat ↔ ingin tahu, kreatif, cepat bosan | Iolka "starts reading"; Yurnet menulis buku masak; Han mengusulkan mock battle untuk melatih master; hero Valhalla bosan di era damai | [K] ch.134, 369, 166; [N] ch.326 |
| 7 | **Nyali** (`cou`) | penakut ↔ pemberani | Fear Resistance tersembunyi; fear diatasi dengan tekad; Berserk mengusir fear | [K] ch.4; [N] ch.14, 42 |

**Roll saat summon (TERBUKA) = "genetik":** tiap dimensi `clamp(round(N(50, 15)), 0, 100)` — SD 15 sesuai [PSI §1] (rentang 20–80 "wajar", ekstrem <10/>90 langka <2,5 %). **Tidak ada dimensi yang berkorelasi dengan ★** — bintang ≠ watak (Lydigion 2★→6★ [N] ch.96; prinsip populasi §0). Perbedaan 1★ vs 3★ di battle pertama ([N] ch.10) **bukan** dari `cou` yang berbeda, melainkan dari **pengalaman awal** `xp` (§1.2a): 1★ warga sipil belum pernah bertarung, 3★ "sudah ada informasi di otaknya bahwa ia harus bertarung". Pengecualian kecil yang tetap kanon: `C` μ = 45/50/55 untuk 1★/2★/3★+ (tentara bayaran & prajurit terlatih memang tersaring lebih disiplin [N] ch.10) — ini seleksi asal, bukan efek ★.

### 1.2a Genetik × lingkungan: pengalaman tempur (`xp`) dan nyali efektif
Kanon: Han 1★ takut→panik→"out of panic" di battle pertama (ch.3–4) lalu "free from fear" (ch.10); Calmness naik +2 level sekaligus di ambang mati (ch.20); berserk mengusir fear (ch.42); 3★+ tenang sejak battle pertama (ch.10); tetapi hero yang bertarung beruntun tanpa pemulihan justru makin rapuh (ch.70 "erosion", ch.284 stres dangerous setelah koma >1 tahun). Jadi kanon menunjukkan **dua arah**: pengalaman bisa menguatkan *atau* melemahkan, tergantung ada pemulihan.
[PSI §5] jangkar yang sudah terverifikasi: **stress inoculation** (pengalaman berhasil mengatasi stres = pelindung), **differential susceptibility** (yang rentan lebih rusak oleh lingkungan buruk *dan* lebih diuntungkan lingkungan baik), **allostatic load** (stres berulang tanpa pemulihan mengakumulasi keausan). **[PSI, diverifikasi §5.1 RISET_NPC_Psikologi_Manusia]** pasangan **habituasi** (paparan berulang yang *selamat* menurunkan reaktivitas takut) vs **sensitisasi** (paparan berulang yang *kewalahan* menaikkannya) — konsisten dengan dual-process theory of habituation (Groves & Thompson 1970) dan literatur SEFL/stress inoculation/differential susceptibility; catatan: kekuatan bukti berbeda per komponen (habituasi & stress-inoculation kuat [KONSENSUS]; sensitisasi/SEFL lebih lemah [PERDEBATAN] karena basis studi rodent, belum direplikasi langsung pada manusia) — lihat RISET_NPC_Psikologi_Manusia.md §5.1 untuk detail verifikasi per komponen.

- `xp` (0–100, tersembunyi): seed saat summon **0 / 15 / 40** untuk 1★ / 2★ / 3★+ [N] ch.10 (TERBUKA).
- **Habituasi**: +2 per misi selamat **tanpa** panic; +4 bila selamat dari situasi kritis (HP <30 % atau rekan mati) tanpa panic (kanon "Skill Awakening" ch.20 = lonjakan justru di krisis). Batas atas per hero `xp_max = 40 + 0,6·cou` — hero bernyali rendah tetap bisa belajar, tetapi plafonnya lebih rendah (genetik membatasi lingkungan).
- **Sensitisasi**: −5 per episode panic/despair yang **tidak** diikuti ≥5 hari pemulihan (`st < 50`); −10 bila episode itu berujung rekan mati di sisinya [PSI-angka: tiap tipe trauma tambahan OR 1,19 tanpa saturasi; CSR berulang 57→67→83 %; puncak sensitisasi hari 4–7 — RISET_Kalibrasi #16]. Bila diikuti pemulihan → tidak turun (stress inoculation: yang menyakitkan tapi pulih justru menguatkan).
- **Nyali efektif** yang dipakai semua rumus: `cou_eff = clamp(cou + 0,4·xp − 0,2·ld, 0, 100)` [PSI-angka: xp 40 → +16 ≈ 1,07 SD = SIT d 1,08 — RISET_Kalibrasi #15]. Yang disimpan tetap `cou` (genetik); `xp` dan `ld` (§3.2) adalah lingkungan.
- **Differential susceptibility** [PSI §5]: hero `E ≥ 58` (≈30 % teratas, kelas "orchid" [PSI-angka RISET_Kalibrasi #17]) mendapat pengali ×1,5 pada **kedua** arah (habituasi dan sensitisasi) — mereka yang paling rusak oleh master ceroboh dan paling berkembang oleh master yang menjaga pemulihan. Ini yang membuat dua hero dengan roll sama berakhir berbeda tergantung lingkungan (kanon: latihan identik → pertumbuhan beda [K] ch.1).
- Akibat yang **muncul sendiri** (bukan diatur): 1★ yang selamat 10–15 misi dengan pemulihan akan setenang 3★ segar; 3★ yang dipaksa beruntun bisa jatuh di bawah 1★ yang dirawat. Metrik §9 memverifikasi ini.

**Perubahan sifat (plastisitas lambat):** [PSI §1, Bühler 2024] efek peristiwa hidup pada trait "nyata tapi kecil": geser **0,1–0,3 SD ≈ 2–5 poin**, dan hanya untuk peristiwa besar; sebagian hero tidak bergeser sama sekali (roll 50 % **per hero**, tetap seumur hidup, diturunkan dari `profileSeed`+`heroId` tanpa byte tambahan — bukan roll per peristiwa; LAPORAN 2026-09-26 Q2). Kanon: Thragin/Muden belajar "patience, humility and equanimity" selama 60 tahun (BK-3 #52) — perubahan ada, lambat. Peristiwa yang boleh menggeser: kematian ikatan intim (E +3, X −2), sintesis rekan disaksikan (H −2 atau A −2), MVP berulang ≥5× (X +2), menjadi instruktur/mentor 90 hari (A +2, C +2), dihukum (A −3). **Erosi karena isolasi** (kanon Aaron ch.352–353: memori & komitmen "mendingin", identitas terkikis tanpa interaksi): hero tanpa interaksi ternotasi ≥60 hari → E +1 per 30 hari, memori tertua non-kunci terhapus 2× lebih cepat, `O` −1 per 60 hari; pulih hanya lewat interaksi (§4.3). Erosi isolasi ini dan stagnasi (§6.11) berlaku untuk **semua** hero, tidak tunduk pada roll plastisitas di atas (isolasi mengikis siapa pun, kanon Aaron; LAPORAN 2026-09-26 Q3). Yang berubah cepat = **keadaan** (§2–§3), bukan sifat.

### 1.3 Tujuan pribadi (1–2 per hero, di-roll, tersembunyi)
[PSI §7] karakter terasa hidup bila punya goal jangka panjang yang **kadang bertentangan** dengan pemain. Kanon: Aaron "[I have a purpose to be strong.]" demi keluarga (BK-3 #54); Han ingin pulang ke Bumi (BK-3 #3); Belquist ingin lebih kuat sampai pergi sendiri (BK-2 #40); Nerissa memakai Twilight Brand yang memotong umur demi kekuatan (BK-2 #2); trainee Niflheim sukarela meski 80 % mati demi residensi (BK-1 #52); 8.429 hero memilih pulang saat perang usai (BK-3 #26).

| Tujuan (`goal`) | Yang memuaskannya | Yang melukainya | Dampak pada aksi |
|---|---|---|---|
| **menjadi terkuat** | MVP, naik ★, duel menang, latihan | didemosi, digantikan hero baru (Aaron–Belquist BK-3 #39) | latihan +, duel kursi +, envy terhadap rival |
| **melindungi rekan** | rekan selamat, menghibur, menjadi leader | rekan mati saat ia hadir (survivor guilt) | menghibur +, request retreat + |
| **diakui / naik lantai** | naik lantai, jabatan, gift cocok | reward rata, lantai 1 lama | grievance +, request + |
| **hidup tenang / pulang** | hari tanpa misi, hobi, vacation | misi beruntun | refusal pada misi berbahaya +, discharge bila ada [V1+] |
| **membalas / membuktikan diri** | mengalahkan yang pernah mengalahkannya | dihina, kalah lagi | duel +, latihan + |
| **mengabdi** (pada master/leader) | perintah dijalankan, dipercaya | master mengabaikan request-nya | patuh +, request masuk akal + |
Distribusi awal (TERBUKA): bobot roll goal **diturunkan dari sifat**, bukan dari ★: terkuat ∝ C + (100−A)/2; melindungi ∝ A + X/2; diakui ∝ (100−H) + X/2; tenang/pulang ∝ (100−C) + E/2; membalas ∝ (100−A) + E/2; mengabdi ∝ H + A/2. ★ tidak dipakai (prinsip §0); kecenderungan kanon "1★ ingin tenang, 3★ ingin kuat" [INF] ch.10, 90 diharapkan muncul dari `C` μ yang sedikit berbeda, bukan dipaksa. Goal kedua di-roll 40 %.

### 1.4 Idiosinkrasi (6–8 item per hero dari 6 kategori di bawah, tersembunyi, muncul di log)
[PSI §7] preferensi kecil non-fungsional adalah sinyal individualitas terkuat bagi pengamat; [PSI §7 identifiable victim] satu detail personal > seluruh stat untuk memicu duka. Kanon: patung kuda (Han), membaca (Iolka), buku masak (Yurnet), headband dipakai hanya saat master online (Cadia BK-2 #54), diary bertanggal (Han BK-2 #9), tidur 3 jam saat latihan (ch.139), diet kentang (ch.34), menamai party "Bring a ticket!" (ch.177), canda "sister… mean" (ch.396).

Katalog `IdioData` (id pendek): gift favorit ×1–2 & dibenci ×1 (dari GiftData — reaksi berbeda per hero [K] ch.51/107/135); makanan favorit/benci ×1 [K] ch.64, 16; hobi ×1 (koleksi · membaca · memasak · berkebun · permainan papan · musik · menulis diary · merawat senjata) [N] ch.273, 134, 369, 358, 284, 166; kebiasaan ×1 (bangun paling awal · makan sendiri · duduk di tempat yang sama di plaza · memeriksa gerbang tiap malam · berdoa sebelum misi · menyapa peri) [INF]; keengganan ×0–1, peluang punya 1 = 50 % (TERBUKA, kalibrasi 4.4; LAPORAN 2026-09-26 Q4) (tidak suka labirin · takut air · tidak mau melawan manusia · tidak tahan panas) — dipetakan ke `TerrainData`/tipe misi [N] ch.57 (humanoid → stres), ch.78 (labirin), ch.139 (air), ch.108 (gurun). Setiap idiosinkrasi menghasilkan: bias kecil di utilitas (§5), baris log berulang yang **dikenali pemain** (§7), dan bahan ritual duka (§6.10).

### 1.5 Memori episodik (5–10 per hero)
[PSI §7] merujuk masa lalu = tanda pikiran yang mengingat; [PSI §6] memori spesifik = bahan continuing bonds. Kanon: hero mengingat "three years without you" (BK-2 #56), memutar arsip rekan yang mati (ch.146), menulis diary (BK-2 #9), Amkena "They were all alive" (BK-3 #86).
`mem = {day, kind, otherId?, valence(−2..+2)}`; kind ∈ {selamat-bersama, rekan-mati-di-sisiku, MVP, kalah-duel, menang-duel, dihukum, tuntutan-diterima, gift-berkesan, diselamatkan-oleh, menyelamatkan, dikhianati, naik-lantai, turun-lantai, disintesis-rekanku}. Kapasitas 10; yang dibuang = valensi terkecil & tertua, kecuali bertanda kunci (kematian ikatan intim). Memori dirujuk oleh: utilitas (§5: "aku tak mau ke labirin lagi"), event (§6: dendam/duka), log & balon bicara (§7).

### 1.6a Kesadaran status sendiri (Hero Reactivity Lv.1, kanon ch.53–56)
Kanon [K]/[N] ch.53, 54, 56: riset "Hero Reactivity" Lv.1 (Research §5.3 DESAIN_SISTEM) membuka kemampuan hero **melihat status window sendiri** (4 stat + skill) dan **objektif misi**; sebelum itu hero tidak melihat angkanya sendiri sama sekali (§3.1 DESAIN_SISTEM, ch.14). Di DESAIN_SISTEM_V0 ini baru tercatat sebagai fitur UI/riset; di sini ditambahkan efeknya pada **keputusan** hero (M0), karena kanon menyiratkan kesadaran diri baru muncul setelah riset ini — sebelum itu hero bertindak dari perasaan (kebutuhan/stres/relasi), bukan dari perbandingan angka.

- Flag `awr` (boolean, di `NpcData`/profil `core`, bukan per hero — riset berlaku seluruh waiting room begitu Lv.1 tercapai): `false` sebelum Hero Reactivity Lv.1, `true` sesudahnya.
- **Efek saat `awr = false`** (default V0 awal game): bias sifat & tujuan di §5.2 berjalan seperti biasa TANPA komponen pembanding stat; noise §5.2 tetap ±8 (tidak berubah) — hero bertindak murni dari dorongan internal, konsisten kanon awal game (ch.7–14) sebelum riset dibuka.
- **Efek saat `awr = true`**: dua bias baru ditambahkan ke §5.2, HANYA untuk hero dengan flag ini aktif:
  1. **Latih jadi lebih terarah** (kanon: "latihan terarah" ch.53): bias `latih` +0,3·(1 − rank_percentile(stat_utama_class, party)) — hero yang tahu dirinya lemah di party (persentil rendah pada stat kelasnya) mendapat dorongan tambahan berlatih; hero yang tahu dirinya sudah kuat relatif TIDAK mendapat bonus ini (sudah puas, bukan dipaksa berhenti — hanya kehilangan dorongan ekstra).
  2. **Envy jadi berbasis angka, bukan cuma hasil** (§4.3): sebelum `awr`, evaluasi iri hanya dari peristiwa terlihat (MVP, promosi, gift — sudah ada). Sesudah `awr`, hero **tahu** bila stat mitra setingkat lebih tinggi meski belum pernah menang MVP — ambang evaluasi iri (§4.3) diperlonggar dari "mitra naik ★/MVP" menjadi juga terpicu oleh selisih stat kelas ≥15 poin pada mitra `★` sama, dengan bobot lebih kecil (×0,5 dari pemicu peristiwa) karena angka mentah kurang emosional dibanding kejadian sosial [PSI §4: perbandingan sosial berbasis kejadian > berbasis angka statis].
- **Tidak** dijadikan input sudden death/stres/relasi — kanon tidak menyiratkan melihat status sendiri itu menyakitkan atau menenangkan; ini murni kanal informasi untuk arah latihan & envy, bukan sumber emosi baru.
- Penyimpanan: `awr` disimpan sekali di `core` (bukan per hero, ≈1 bit), diperiksa saat §5.2 dijalankan; tidak menambah byte per hero (§1.6).

### 1.6 Penyimpanan
```
hero.npc = {
  tr = "..14 hex..",     -- 7 dimensi × 1 byte (0–100) — genetik, hampir tetap
  xp = 12,               -- pengalaman tempur (§1.2a) — lingkungan
  gl = {g1, g2?},        -- tujuan (id)
  id = {gf={..}, gd, fd={fav,hated}, hb, hab, av?},   -- idiosinkrasi (id pendek); fd = makanan favorit & dibenci
  nd = "..10 hex..",     -- 5 kebutuhan (§2)
  st = 23, ld = 5,       -- stres, allostatic load (§3)
  gr = {tId, day, tr}?,  -- duka aktif: siapa, sejak, trajektori (§6.10)
  rl = { {id, p}, ... }, -- ≤8 relasi ternotasi packed (§4.4)
  mm = { {d,k,o,v}, ...},-- ≤10 memori
  tg = {asal, angkatan}, -- tag identitas (§4.6)
  sk = {hi, lo},         -- hari berturut st≥60 / st<40 (untuk ld, §3.2)
  cd = 0,                -- hari tempur berturut (kurva combat fatigue §3.3)
  xe = {..},             -- episode panic/despair yang menunggu cek pemulihan 3 hari (§1.2a)
  ls = dayIndex,
}
```
Penanda runtime `sk`/`cd`/`xe` wajib disimpan agar `ld`, kurva combat fatigue, dan sensitisasi tidak ter-reset saat catch-up (LAPORAN 2026-09-26b Q3); bentuk & byte final diputuskan bersama `rl`/`mm` di M1 5.3.

**Ukuran terukur** (repo, tugas §B 1.4, 25 Sep 2026; dikonfirmasi dengan `HttpService:JSONEncode` asli di Roblox Studio pada 26 Sep 2026 — angka identik dengan runner Lune): hero dummy dengan `npc` lengkap (8 `rl` + 10 `mm`) = **1.368 byte** (> 900); tanpa `rl`+`mm` = 770 byte (≤ 900). Blok `rl` ≈225 byte dan `mm` ≈361 byte dalam format objek; format array ≈153 / 201 byte. Keputusan `rl`+`mm` tetap di `heroes_N` (dengan format array) vs pindah ke key `social_N` diambil di M1 5.3 (TERBUKA). [INFERENSI] 1.000 hero × 1.368 byte ≈ 1,37 MB per key `heroes_N` — masih di bawah larangan >2 MB, tetapi hitungan endgame RISET_Batas_Teknis (asumsi 600–900 byte/hero) perlu dihitung ulang di M1 5.3.

---

## 2. KEBUTUHAN: APA YANG HERO INGINKAN HARI INI

### 2.1 Kanon → model
Kanon menunjukkan lima jenis kekurangan yang memicu perilaku: **lelah** ("Continuous battles tire the hero" [K] ch.8; rest dipaksakan ch.230), **lapar/makanan** (dissatisfied with cooking [K] ch.16; jatah kentang lantai 1 ch.156; kelaparan di labirin ch.78), **tidak dilibatkan** → tidak stabil (ch.159) dan **bosan tanpa tujuan** (ch.326), **tidak diakui** (reward rata → mogok ch.65; Han kecewa gift saat pulang juara ch.107), dan **dipaksa** (perintah tak masuk akal → refused ch.47; jam riset berlebih → dissatisfaction ch.53).
[PSI §2] Maslow sebagai hierarki DIBANTAH — kebutuhan **tidak bertingkat** (hero lapar tetap bisa tersinggung harga dirinya; hero nyaman tetap gelisah bila tak dihormati — kanon: kemewahan berlebih → stagnasi ch.156). SDT (KONSENSUS): autonomy, competence, relatedness; **frustrasi ≠ ketiadaan** — dipaksa lebih merusak daripada tidak diberi.

| Kebutuhan (kode) | Turun karena | Naik karena | Kanon | PSI |
|---|---|---|---|---|
| **istirahat** (`rest`) | misi, latihan, jam riset, shift jabatan | tidur/istirahat; Bathhouse/Lounge; vacation | [K] ch.8, 53; [N] ch.134, 230 | allostatic load §5 |
| **makan** (`food`) | tiap hari; masakan tidak sesuai; jatah lantai 1 | Restaurant + Chef cocok; makanan favorit | [K] ch.16, 64; [N] ch.156 | — |
| **otonomi** (`aut`) | dipaksa (misi yang ia tolak dikirim juga; jam riset dipaksa; request ditolak berulang; compound command) | request dikabulkan; usulan diterima; memilih aksi sendiri; autonomous action ON | [K] ch.47–52, 53, 30; [N] ch.276 | SDT autonomy; undermining effect |
| **kompeten & diakui** (`cmp`) | reward rata; didemosi; digantikan; kalah duel; tugas terlalu mudah berulang (bosan) | MVP; naik lantai/★; jabatan; menang duel; latihan yang menantang; gift cocok | [N] ch.65, 160, 347; [K] ch.51 | SDT competence; status = kebutuhan fundamental (Anderson 2015); kebosanan (Eastwood) |
| **terhubung** (`rel`) | tidak dilibatkan; ikatan putus; rekan mati; dipindah party; sendirian (bagi X tinggi) | makan bersama; party tetap; menghibur/dihibur; hobi bersama; bond | [N] ch.159, 22; [K] ch.27, 222 | SDT relatedness; buffering hypothesis |

### 2.2 Laju harian (TERBUKA, poin/hari in-game; 1 hari Bumi = 3 hari in-game)
| Kebutuhan | Dasar | Pengali sifat | Situasi |
|---|---|---|---|
| rest | −8 | ×(1 + 0,3·C/100) bila berlatih | misi −25; jabatan −3 |
| food | −20 | — | makan tersedia +30; Chef cocok +10; lantai 1 tanpa Restaurant hanya +18 |
| aut | −1 | ×(1 + O/100) | dipaksa −8 **dan `st` +6** [PSI-angka: frustrasi masuk kanal stres; reaktansi d 0,41 — RISET_Kalibrasi #35]; request ditolak −5; dikabulkan +8; memilih aksi sendiri +3 |
| cmp | −3 | ×(0,6 + (100−H)/100·0,6) — gila hormat turun lebih cepat | MVP +25; naik lantai +20; kalah duel −10; tugas monoton ≥5 hari −2/hari (O tinggi ×1,5) |
| rel | −3 | ×(0,4 + X/100) — penyendiri turun lambat | party tetap +2; makan bersama +3; dihibur +6; ikatan intim ada: floor 40 (tidak pernah di bawah 40) |
**Kebutuhan sosial sebagai kontinum, bukan kategori** (prinsip §0): target `rel` tiap hero = `40 + 0,6·X` (X 0 → 40, X 100 → 100) dan decay ×(0,4 + X/100) di atas — sehingga hero `X` rendah **tidak** sakit karena sendiri, dan tidak ada roll "avoidant" terpisah. **Lantai sendiri:** tanpa kontak, `rel` hanya meluruh sampai `100 − target` (X 0 → 60, X 50 → 30, X 100 → 0); kehilangan boleh menembus lantai ini, dan ikatan intim hidup tetap memberi floor 40 (LAPORAN 2026-09-26b Q1, tafsiran Claude Code disetujui: defisit = target − kontak). Akibatnya hero `X ≤ 33` tidak pernah `rel < 40` tanpa kehilangan. **Nilai awal** kelima kebutuhan saat summon = 50 [PSI-angka: dipertahankan; hero pasif stabil setelah tarikan §3.2 dinolkan di atas 40; `rel` awal = max(50, lantai sendiri); LAPORAN 2026-09-26b Q2). Pengali X hanya pada **decay**, tidak pada gain — introvert dan ekstrovert memperoleh manfaat kontak yang sama [PSI-angka RISET_Kalibrasi #37]. Keramaian (party 5 + plaza penuh) menguras `rest` −2·(1 − X/100) tambahan (introvert lelah oleh keramaian, ekstrovert tidak). Dengan roll N(50, 15), proporsi hero `X ≤ 35` ≈ 16 % dan `X ≤ 45` ≈ 37 % — ini **hasil**, bukan target; [PSI §3] "25–35 % penyendiri" hanya dipakai sebagai rentang pembanding di §9. Kanon: Katio bekerja sendiri sebagai scout (BK-2 #7), Nerissa jalur admin, Muden 300 tahun berkebun sendiri (BK-3 §B).

---

## 3. STRES, DAYA TAHAN, LUKA MORAL

### 3.1 Struktur kanon
Nilai tersembunyi, naik/turun [N] ch.70; **3 ambang**: warning "[Hero 'X's stress level is dangerous!]" [K] ch.284 → sudden death "[Cause – Suicide due to stress]" [K] ch.7 → Broken heart (5★, [V1+]) [N] ch.212. Sumber & penurun kanon: KANON_05 §1.3, §1.5. Tidak ada angka kanon → semua (TERBUKA), tetapi **bentuknya** diambil dari ilmu manusia.

### 3.2 Dua lapis + akumulator [PSI §5: diatesis–stres, allostatic load]
- `vul` (kerentanan, trait turunan, 0–100) = `0,45·E + 0,30·(100−cou) + 0,25·(100−C)` [PSI-angka: N d ≈1,65 vs C rendah d ≈1,0 — RISET_Kalibrasi #8] + riwayat (tiap kehilangan ikatan intim +3, permanen-ish). Ambang "patah" = `90 − 0,3·vul` → hero rapuh patah di ~70, tangguh di ~90 (bentuk [PSI], angka TERBUKA). `vul` memakai `cou` genetik (kerentanan dasar), sedangkan reaksi takut di misi memakai `cou_eff` (§1.2a) — genetik menentukan seberapa dalam jatuhnya, pengalaman menentukan seberapa sering.
- `st` (stres, state harian 0–100): `st += Σsumber − Σpenurun − pulih_dasar`; `pulih_dasar = 4·(0,6 + (100−vul)/100·0,8)·(1 + 0,2·xp/100)` — hero berpengalaman pulih sedikit lebih cepat (stress inoculation [PSI §5]); tarikan kebutuhan `+0,08·max(0, 40−rest) + 0,05·max(0, 40−aut) + 0,03·max(0, 40−cmp) + 0,04·max(0, 40−rel)` — nol bila kebutuhan ≥ 40, maks 8/hari [PSI-angka RISET_Kalibrasi #1: bobot dari ρ burnout aut −,60 > rel −,39 > cmp −,30; menggantikan rumus lama yang membuat hero pasif naik +12,5/hari]. Pulih ×0,6 bila `rest < 30` [PSI-angka #2: restriksi tidur kronis → cemas SMD +0,6]. **Reaktivitas**: semua sumber stres akut (§3.3) dikalikan `(1 + vul/200)` [PSI-angka #6/P-K2: neurotisisme bekerja lewat reaktivitas, bukan hanya ambang]. Bentuk pulih tetap konstan untuk V0 (P-K1 = A; bentuk proporsional `0,13·st` dicatat sebagai kandidat kalibrasi 4.4).
- `ld` (allostatic load, 0–100): +1/hari bila `st ≥ 60`; **−0,5/hari** bila `st < 40` selama ≥7 hari berturut; **lantai 10 permanen** setelah `ld` pernah ≥ 50; **tiap episode patah** (`st ≥ ambang`) → `ld` +8 seketika (dihitung maks 5 episode seumur hidup) [PSI-angka #10/P-K4: exhaustion disorder pulih 6–12 bulan dengan toleransi tetap turun; kindling Kendler 2000; CSR berulang 57→83 % — RISET_Kalibrasi]; `ld` menurunkan ambang patah `−0,2·ld`, menaikkan laju naik stres ×(1 + ld/200), dan menurunkan `cou_eff` (§1.2a). Kanon: "overtraining → erosion" ch.70; "tubuh asli koma >1 tahun, stres dangerous" ch.284.

### 3.3 Sumber & penurun (angka TERBUKA; bentuk kurva [PSI §5])
| Sumber (+) | Δ | Kanon | Penurun (−) | Δ | Kanon |
|---|---|---|---|---|---|
| Misi (per misi) | +10 (hari tempur beruntun ke-≥4: ×1,5; ke-≥8: ×2,5 — kurva combat fatigue) | [K] ch.8 | Aksi istirahat | −8 (tidur cukup ×1,5) | [N] ch.7 |
| Misi vs humanoid (bila keengganan/`A` tinggi) | +5…+10 | [N] ch.57 | Dukungan rekan yang **dipercaya** (t ≥ 9) | pengali pulih ×1,5 [PSI-angka #5: dukungan ↔ PTSD r −,27…−,40; OR 0,37] | [K] ch.222; [PSI buffering] |
| Rekan mati di sisinya | +20 (ikatan intim ×2) | [N] ch.42 | Hobi dijalankan | −5 (×1,2 pengali pulih) | [N] ch.383, 273 |
| Rekan lain di room mati | +4 | [N] ch.42 | Vacation | −12/hari hari 1–5, −4/hari sesudahnya; `ld` tidak berubah [PSI-angka #4: efek liburan d 0,43, hilang 1–4 minggu] | [N] ch.134 |
| Menyaksikan sintesis hero | +8; +15 bila rekan dekat | [N] ch.48, 64 | Gift cocok (hanya bila `st < 70`) | −10 | [K] ch.284 "no change" |
| Ancaman sintesis | +15 | [N] ch.48 | Cheering master saat misi | −5 | [N] ch.120 |
| Latihan >2 sesi/hari | +4/sesi | [N] ch.70 | Makan bersama | −2 | [N] ch.22 |
| Jam riset >3 | +3/jam | [K] ch.53 | Naik lantai / MVP | −8 | [N] ch.156 |
| Tidak dilibatkan ≥7 hari (bagi goal ≠ "hidup tenang") | +2/hari | [N] ch.159 | Comfort item milik hero | −1/hari | [N] ch.166 |
| Beban jabatan | +2/hari | [N] ch.162 | Ritual duka kolektif (§6.10) | −6 semua yang hadir | [K] ch.79 |
| Diturunkan lantai/party; digantikan | +12 | [N] ch.160, 347 | Tujuan pribadi tercapai | −15 | [N] ch.355 |
| Dihukum | +15 | [N] ch.113 | | | |
| **Luka moral** (§3.4) | +10 + guilt | [N] ch.29, 64 | | | |

### 3.4 Luka moral (moral injury) — terpisah dari takut [PSI §5 Shay/Litz]
Kanon: hero sadar mereka "expendable" dan "respond better to masters who treat them as individuals" (ch.234); sintesis massal pemogok merusak morale semua (ch.48, 66); membunuh manusia menambah stres (ch.57); tiga hero ikut campur duel dibunuh rekannya sendiri (ch.29). Pemicu & besaran [PSI-angka #19, RISET_Kalibrasi §4 — perpetrasi memberi guilt terkuat, pengkhianatan memberi hilang-percaya terkuat, menyaksikan paling sering tapi guilt terlemah]: (a) disintesis-rekanku (semua yang a ≥ 8 ke korban) = kelas **pengkhianatan** → guilt +8…+16 dan like −15; (b) melawan humanoid bagi hero `A ≥ 65` = kelas **perpetrasi** → guilt +10…+20; (c) perintah master yang melanggar nilai (mengirim party yang sudah menolak = compound paksa) → guilt +10…+20 dan like −10; (d) meninggalkan rekan (party wipe dengan penyintas) → guilt +15…+30. Semua Δguilt dikalikan `clamp(1 + 0,3·(A−50)/15 + 0,3·(C−50)/15, 0,5, 1,8)` [PSI-angka #20: guilt-proneness ↔ A r ,30–,33, C r ,24–,37]. Roll seragam bilangan bulat dalam rentang (LAPORAN wk2c Q4). Efek lain: penarikan diri (aksi sosial −50 % selama 14 hari [INFERENSI, durasi empiris TIDAK KETEMU]); `guilt` **tidak meluruh** [PSI-angka #22: MI stabil r ,67–,80 setahun; duka rekan tempur tak berubah 1–25 tahun]. Pulih **bukan** lewat istirahat: **pengakuan** (master menerima tuntutan mogok/faksi) → guilt −8 dan like +15 bila ≤ 60 hari sejak luka, sesudahnya guilt 0 dan like +8 [PSI-angka #24: keadilan restoratif d −1,17 pada balas dendam, PTSS d 0,3, hanya efektif dini]; **penebusan** (menyelamatkan rekan) → guilt −20 [#23]; **ritual** (§6.10) → guilt −3 [#25]; **penerimaan rekan** (dihibur oleh t ≥ 9) → guilt −5, maks 3× per episode luka [#26].

**Hesitasi mid-combat vs humanoid (pemicu b, diperluas):** kanon ch.55–57 hanya menyatakan efek pasca-misi ("stres naik"); tidak ada detail perilaku *selama* pertarungan di ekstraksi kami saat ini (keterbatasan pencarian — belum ditemukan di novel ch.1–400 maupun 16 screenshot manhwa yang ada; bukan berarti tidak ada di sumber aslinya). Karena engine M2 (BRIEF_SCRIPTER §3) sudah menerima `fearResistance` per hero sebagai probabilitas panik, hesitasi terhadap lawan manusia dirancang sebagai **perluasan mekanisme yang sama** (bukan sistem baru): hero `A ≥ 65` menghadapi `EnemyData` bertanda `isHumanoid = true` (field di data musuh milik scripter, TERBUKA per baris) mendapat `hesitation` (§8.2) — probabilitas tambahan delay 1 tick sebelum menyerang target itu, terpisah dari fear/panic biasa. Ini [INF]/[USUL] saya sebagai desain, bukan kanon literal — ditandai TERBUKA sampai ada bukti kanon yang lebih spesifik (chapter yang menunjukkan keraguan *saat* bertarung, bukan cuma sesudahnya).

### 3.5 Sudden death — hanya pada kombinasi faktor [PSI §5 Joiner; kanon Mormont]
Kanon Mormont: 2★ baru, hari-hari pertama, belum punya relasi, wipe pertama 9 dari 11 (BK-1 #4–6) — cocok persis dengan teori interpersonal: **thwarted belongingness + perceived burdensomeness**. Kanon ch.42: "depresi karena kematian teman dekat = penyebab utama sudden death" — jadi hero yang *baru kehilangan* ikatannya justru paling berisiko. Roll harian **hanya** bila SEMUA: `st ≥ ambang patah` DAN `rel < 30` DAN (tidak ada relasi **ke hero yang masih hidup** dengan t ≥ 9 atau a ≥ 8 — relasi ke hero yang sudah mati **tidak** melindungi; ia masuk faktor "kehilangan besar") DAN (kehilangan besar ≤30 hari ATAU gagal berulang ≥3 misi tanpa kontribusi). `p = 0,03·(1 + vul/100)·(1 + ld/100)` per hari (angka permainan, bukan PSI), dikalikan pengali waktu sejak kehilangan besar: hari 1–7 ×2,0; 8–30 ×1,0 [PSI-angka #11: OR bunuh diri minggu 1 3,43 vs bulan 1 1,77]; jendela kehilangan tetap ≤30 hari (P-K11 = B). Roll hanya bila warning episode ini sudah berumur ≥ 3 hari (`warnWindow.min`; pemilik 26 Sep, J8: kematian = ujung bola salju). Faktor pelindung yang mematikan roll: ≥1 ikatan hidup t ≥ 9; jabatan/murid yang bergantung padanya; dihibur dalam 3 hari terakhir. Keluaran [K] ch.7: "['X (★★)' has returned to the arms of the goddess. His fighting spirit will be remembered forever.]" → "[Sudden death!]" → "[Cause – Suicide due to stress]". **Warning** [K] ch.284 dikirim saat `st ≥ ambang − 15` (1× per episode) — supaya pemain punya jendela 3–10 hari untuk bertindak (gift tidak bekerja saat `st ≥ 70` [K] ch.284 → yang bekerja: vacation, menghibur lewat rekan, mengurangi beban). Roll **tetap berjalan saat pemain offline** (§8.1) — kanon Mormont mati saat master tidak login.

### 3.6 Likeability ke master (0–100, tersembunyi)
Nilai awal saat summon: **50** (netral, TERBUKA; LAPORAN 2026-09-25 Q4). Naik: gift cocok +8 (saat `st < 70`); tuntutan mogok diterima +10; request dikabulkan +4; kesejahteraan (Restaurant + Bathhouse) +0,3/hari; cheering +2; master menghadiri ritual duka +5. Turun: gift dibenci −12 ("greatly disappointed" −20 bila `H < 40`); request ditolak −3; sintesis disaksikan −6; hukuman −15; luka moral −10; lantai 1 tanpa fasilitas −0,3/hari. [K]/[N] ch.51–301, 157, 48. Dipakai di §6.3 (refusal) & §6.9 (request). Bentuk hubungan hero–master kanon: konflik → negosiasi → simbol → kemitraan (BK-1 §B Han↔Amkena).

---

## 4. RELASI: IKATAN YANG KOMPLEKS, BUKAN SATU ANGKA

### 4.1 Kanon
Jenis ikatan yang narasi tunjukkan (RISET_Bukti §B semua bagian): dua penyintas yang jadi inti (Han–Jenna), senior–junior tanpa dendam (Han–Aaron), leader–anggota yang dilatih keras (Han–Iolka), rival kursi yang jadi rekan (Belquist–Nerissa), enmity bawaan (Mazel–Tasir–Stein), cemburu (Iolka→Katio), tawanan yang diredakan (Katio–Han), bond summon (Maned Wolf; beastfolk; kembar), guru–murid bersyarat (Muden–Aaron), utang budi ke master (Han minta patung), kesetiaan ke persona bukan orang (Niflheim: "only Loki, not Israt"), sebutan keluarga ("older brother", "sister" ch.387, 396), protektif sampai mati (Edith), rasa bersalah leader atas slot kosong (Siris ch.375). Ikatan tumbuh dari **peristiwa bersama** dan rusak oleh **kematian atau pilihan**; tidak semua hero berikatan kuat (Dica, Chloe, Roderick tipis).

### 4.2 Enam dimensi berarah per pasangan [PSI §3]
A→B disimpan terpisah dari B→A.
| Dimensi | Rentang | Kanon | Sumber psikologi |
|---|---|---|---|
| **kasih** (`a`) | −7..+7 (negatif = tidak suka) | comfort teman; makan bersama; "sister" | affinity |
| **percaya** (`t`) | 0..15 | bond → power lebih besar; "closeness bonus" | trust; Kim 2004 pelanggaran integritas vs kompetensi |
| **akrab** (`f`) | 0..15 (jam bersama, log-skala) | trio Han–Jenna–Belquist selalu satu daftar | Hall 2019: 50/90/200 jam |
| **hormat** (`r`) | 0..15 | "if you're strong you go up"; Aaron mengakui Muden "Master" | prestige vs dominance (Cheng 2013) |
| **utang** (`d`) | −7..+7 (+ = aku berutang padanya) | Han minta patung berulang pada master yang menyelamatkannya; Katio diredakan Han | reciprocity; gratitude vs indebtedness |
| **iri** (`env`) | 0 none · 1 benign · 2 malicious | Iolka cemburu Katio; Aaron vs Belkist "much less time"; Sraagin menantang Lidigion puluhan kali | van de Ven: benign bila layak & terkejar, malicious bila tak adil |
Netral = (0, 4, 0, 4, 0, 0). **Enmity** kanon [K] ch.49 = `a ≤ −5` dua arah (flag); manhwa ch.16 menampilkan enmity antara **satu hero dan satu TIM bond** ("Hostility has been formed between Han and the Pulverizing Wolves team") [T-gambar] → bila lawan berflag Bond/Sumpah, semua anggota kelompoknya mendapat a −5 ke penantang (enmity kelompok). **Bond** kanon [K] ch.27 = `t ≥ 12 & a ≥ 5` (flag). **Ikatan Sumpah** (§6.8) = `a ≥ 6 & t ≥ 12 & f ≥ 12` dua arah (flag).

### 4.3 Bagaimana ikatan tumbuh (propinquity × peristiwa × kesamaan) [PSI §3]
- **Kesempatan interaksi** ∝ kedekatan fisik: rekan party sama (tiap hari), lantai sama (1 acak/hari), fasilitas sama (rekan kerja Chef/Researcher/Manager), plaza (1 acak seluruh room/3 hari). Kanon: Festinger-like — party 1 inti dari tinggal & bertarung bersama (ch.73–143).
- **Akrab** `f` naik per hari bersama dengan bobot: kerja berdampingan/latihan ×1, makan bersama/hobi bersama ×2, **misi bersama ×5**, **selamat dari wipe/kehilangan bersama ×10** — hanya bila hero berdistres sesudahnya (`st ≥ 60`), selain itu ×5 [PSI-angka #47: fusi naik hanya pada yang berafek negatif & merefleksi] (shared dysphoria → fusi, Whitehouse 2017; kanon: Han–Jenna dua penyintas dari 11). Ambang tahap (Hall, dikonversi: 1 "jam" ≈ 1 hari in-game bersama): kenalan f<5 (≈<50), teman 5–8 (≈50–90), dekat 9–11 (≈90–200), intim ≥12 (≈>200).
- **Kasih** `a` naik +1 saat interaksi positif bila kesamaan (homophily: selisih |C|,|O| < 25 atau tag sama) ATAU pengalaman positif bersama; turun saat provokasi/dicuri/dikalahkan dengan tidak hormat.
- **Percaya** `t`: nilai awal antar hero selantai **3/15** [PSI-angka #43: trust game ≈50 % endowment ke orang asing]; naik +1 saat mitra menepati (menyelamatkan, menghibur, berbagi loot); turun −2 untuk pelanggaran kompetensi (gagal melindungi), **−6 untuk pelanggaran integritas** (mencuri dari dia, memeras, berbohong, meninggalkan) dan pulih ×0,3 lebih lambat [PSI Kim 2004]; setelah pelanggaran integritas, plafon `t` = 70 % puncak sebelumnya; pelanggaran saat `f < 5` dihitung ×2 [PSI-angka #42: tipu → defisit permanen −0,37; pelanggaran dini d 0,75]. Kanon: Edith keluar bond setelah Han membunuh rekan bond-nya (ch.29) = putus permanen.
- **Hormat** `r`: +1 saat mitra ★/level lebih tinggi menang/melindungi (prestige); +1 pada leader yang usulannya berhasil; −1 bila leader gagal berulang; **dominance** (kuat + `A` rendah) → r naik tapi a turun (dipatuhi, dihindari).
- **Utang** `d`: +2 saat ditolong (diselamatkan di misi, dihibur, dibela); −2 saat membalas; utang penerima meluruh −1 per 40 hari; utang ≥5 yang tak dibayar 60 hari → `a`(pemberi→penerima) −1 (resentimen pemberi, bukan guilt penerima) [PSI-angka #44/P-K8: kewajiban terasa turun ~30 %/30 hari; nilai bantuan turun di penerima & naik di pemberi]. Pertolongan yang "ditagih" (master memaksa balas) → d turun tapi a tidak naik (indebtedness, bukan gratitude).
- **Iri**: dievaluasi saat mitra setingkat (selisih ★ ≤ 1) naik (MVP, promosi, masuk party utama): bila kenaikan itu **layak** (mitra latihan lebih banyak / kontribusi tinggi) → roll 65 % benign / 35 % malicious; bila **tidak layak** (gift/favoritisme master: mitra dapat gift ≥3× lebih banyak, atau naik lantai tanpa MVP) → roll 45 % benign / 55 % malicious [PSI-angka #45/P-K6: ketidaklayakan menggandakan iri malicious 1,43→2,56, benign turun ~10 %]. Benign → latihan hero ini +10 % selama 14 hari [#46: benign envy ↔ performa r ≈,2–,3]; malicious (a −2, provokasi +, gosip = grievance menyebar §4.6). Selisih ★ ≥ 2 → hormat, bukan iri (admiration tidak memotivasi). Kanon: Iolka cemburu Katio 4★ rampasan yang langsung masuk P1 (ch.127, 133) = tidak layak → malicious; Aaron vs Belkist = layak tapi menyakitkan → benign yang berubah rendah diri (BK-3 #55).
- **Fusi meluruh** [PSI Bautista 2026]: `f` dari misi bersama turun −1/30 hari tanpa peristiwa baru bersama.
- **Decay umum** [PSI-angka #40–41/P-K5]: decay mulai hanya setelah jeda interaksi melebihi interval lapisan — intim 7 · dekat 30 · teman 90 · kenalan 180 hari — lalu `a`, `t`, `r` bergerak 1 ke arah netral per 30 hari; `f` tidak turun di bawah 70 % puncaknya untuk ikatan yang pernah mencapai tahap teman; ikatan yang belum mencapai teman dalam 60 hari boleh hilang total (kedekatan teman turun hanya 0,62/10 dalam 18 bulan pada kontak berkurang; dormant strong ties menyimpan 93 % trust; ikatan transien mati < 60 hari).

### 4.4 Anggaran sosial & penyimpanan hemat (≤2.000 hero) [PSI §3 Dunbar]
- Tiap hero punya **anggaran sosial** tetap: ≤8 slot relasi ternotasi ≈ lapisan intim (≤5) + dekat. Variasi individu `focus` **diturunkan kontinu dari X** (bukan dua kategori): porsi interaksi yang diarahkan ke 2–3 orang terdekat = `0,8 − 0,4·X/100` (X 0 → 80 % ke lingkaran dalam; X 100 → 40 %, menyebar tipis) — sesuai [PSI §3] alokasi energi sosial yang sebagian dijelaskan Extraversion. Bila slot penuh dan relasi baru menguat, slot terlemah `max(|a|, t−4, |r−4|, f/2)` terdorong keluar — kecuali berflag Bond/Enmity/Sumpah/kunci.
- **Relasi implisit** (tidak disimpan) untuk pasangan tanpa slot: party sama → (a+1, t+2, f+2); lantai sama → (t+1); tag sama → (a+1); faksi sama → (a+1, t+2); enmity faksi → (a−2). Ini menghindari N².
- **Sampling per hari per hero ≤ 4 interaksi** (rekan party deterministik + 1 lantai + 1 room acak berseed). 2.000 hero × 21 hari ≈ 170.000 interaksi → target < 1,5 s CPU (§9).
- Packing: `p = (a+7) + t·16 + f·256 + r·4096 + (d+7)·65536 + env·1048576 + flags·4194304` (flags: 1 Bond, 2 Enmity, 4 Sumpah, 8 kunci, 16 mentor→murid, 32 murid→mentor) → ≤ 28 bit (nilai maksimum < 2²⁸), aman di double Luau. Slot ≈ 14 byte JSON.

### 4.5 Guru–murid (mentor) — kanon kuat, dibangun sebagai relasi berflag
Kanon: Aaron instruktur pendatang baru (ch.73); Muden mengajar dengan **syarat** dan menyebutnya "one-sided loss" (BK-3 #43, #47); Han "difference between having a teacher is huge" (ch.100); murid mengakui "Master" setelah bertahun-tahun (BK-3 #58); tukang bisa mengajar teknik (ch.29). Aturan: hero dengan jabatan Instructor atau ★ ≥ trainee+1 & `r(murid→guru) ≥ 8` & `A(guru) ≥ 40` → flag mentor; efek: laju skill murid ×(1 + gap★) (DESAIN §6.8, maks 10×), `cmp` guru +2/hari, `f` ×2, murid `d` +1/minggu; guru boleh **menolak** murid bila `H` murid < 30 ("resolve the contradiction") atau `C` murid < 30. Murid yang melampaui guru → r guru→murid +3, guru `cmp` +10 (kebanggaan) bila `A ≥ 50`, malicious envy bila `A < 40`. Kematian salah satu = duka intim (§6.10). Guru juga mentransfer **pengalaman**: murid berflag mentor mendapat `xp` +1/minggu (§1.2a; kanon Han dilatih Lydigion 4 bulan → tenang di kelas berikutnya ch.96–100).

### 4.6 Identitas kelompok, keluhan, dan **kapan** faksi muncul [PSI §4 SIT, SIMCA, equity]
Kanon: gang Sitan = **10 dari ~25** hero lantai 1 (ch.65) — bukan semua; pemicunya *perubahan* dari reward rata ke hierarki lantai (relative deprivation, bukan kemiskinan); bond kelompok summon (ch.27, 104); party tetap sebagai klik (ch.30); "no discrimination by origin" sebagai prinsip Loki (ch.127) menyiratkan asal = kategori yang biasa memecah.
- **Tag identitas** per hero (2): `asal` (dunia/ras: manusia · beastfolk · dsb. dari HeroData) dan `angkatan` (batch summon: hero yang disummon dalam 1 sesi ×10 berbagi tag — kanon bond summon). Favoritisme in-group: a +1 awal antar tag sama; bias penilaian saat konflik.
- **Keluhan** (`grv`, per hero, 0–100) = relative deprivation: dibandingkan dengan 1–3 acuan setara (hero setingkat ★ di lantai lain / party utama): selisih (makanan, lantai, gift diterima, jabatan) × persepsi ketidakadilan (naik bila perubahan **turun** — kehilangan lebih menyakitkan daripada rendah stabil). `grv` menyebar lewat interaksi: hero yang `grv ≥ 50` dan `X ≥ 50` "menyuarakan" → mitra dengan tag/lantai sama `grv` +3 (pluralistic ignorance runtuh saat ada yang bersuara pertama).
- **Kelompok/klik** = komponen terhubung `t ≥ 9 & a ≥ 3` dua arah (slot ternotasi) dengan ≥3 anggota — ini **hanya struktur**, bukan faksi. Sebagian besar klik tidak pernah jadi faksi (trio Han–Jenna–Belquist = klik yang setia).
- **Faksi (gang)** terbentuk **hanya** bila SIMCA terpenuhi: rata-rata `grv` klik ≥ 60 (ketidakadilan) × ada leader: anggota dengan skor efikasi tertinggi di klik (`0,4·X + 0,3·(★·15+level) + 0,3·Σr diterima`) **dan** skornya ≥ persentil 80 skor efikasi seluruh hero di lantai yang sama (TERBUKA, dikalibrasi 4.4; [USUL] Cowork 26 Sep — ambang relatif agar cabang "tanpa leader → sinisme" tetap bisa terjadi) × ≥50 % anggota berbagi tag/lantai (identitas). Tanpa leader → grievance jadi **sinisme**: kerja lambat (latihan −30 %), request pindah party, `aut` turun — bukan mogok. Peran saat faksi bertindak **tidak di-roll sebagai kategori** (prinsip §0): tiap anggota memutuskan sendiri dari `grv` × `cou_eff` × `X` × a ke ringleader; proporsi ringleader / ikut / diam yang [PSI] sebut (10–20 / 30–50 / 30–50 %) dan kanon 10/25 ≈ 40 % hanya rentang pembanding §9.
- **Bubar**: ringleader dihukum (kanon: sintesis Sitan ch.66) → faksi diam tetapi `grv` semua anggota +10, luka moral pada yang a ≥ 5 ke ringleader, likeability −15; tuntutan diterima → `grv` −40 semua, likeability +10; anggota naik lantai → keluar faksi.
- Free-rider: kelompok >8 tanpa Manager fasilitas → aksi `menganggur` +10 % (kanon: "jarang sintesis → hero malas" adalah pandangan master ch.63; kanon Han memilih motivasi non-takut ch.64 — keduanya dipertahankan sebagai dua strategi pemain dengan konsekuensi berbeda).

---

## 5. TICK HARIAN: DARI KEADAAN KE TINDAKAN

### 5.1 Urutan per hari in-game
1. **Kewajiban**: hasil misi master (§8.2), latihan wajib party leader (anggota `C < 30 & A < 40` boleh skip → a −1 ke leader), jam riset, shift jabatan.
2. **Decay** kebutuhan (§2.2) & update `ld`, `xp` (§1.2a).
3. **Pilih aksi** per hero (§5.2); hero mati/misi/kurung/absen dilewati.
4. **Resolusi** aksi + interaksi berpasangan (§4.3).
5. **Event** (§6) urutan tetap: penilaian perintah → mogok/faksi → duel → pencurian/pemerasan → provokasi/iri → sosial (berteman, menghibur, mentor) → Ikatan Sumpah → duka (osilasi).
6. **Stres** (§3) → warning → luka moral → roll sudden death.
7. **Evaluasi kelompok/faksi** (hari kelipatan 7).
8. **Memori** (§1.5) & **keluaran** (§7).

### 5.2 Skor utilitas
`U(aksi) = Σ_k w_k·(100−need_k)·gain_k + bias_sifat + bias_tujuan + bias_memori + bias_idiosinkrasi + noise(−10..+10)`; aksi U tertinggi dipilih; syarat harus terpenuhi. Noise ±10 dari 100 [PSI-angka #38: 40–55 % varians afek intra-individu] ≈ **10–20 % ketidakpastian** [PSI §7: perilaku 100 % terprediksi terasa mesin, acak terasa rusak; yang "hidup" = dapat dijelaskan sesudahnya]. Satu aksi utama + satu aksi ringan (makan bersama/hobi) bila `rest ≥ 30`. `w = {rest 1,0; food 1,2; aut 0,8; cmp 0,8; rel 0,7}` (TERBUKA); hero `st ≥ 70`: w.rest & w.aut ×2, aksi sosial −50 % [K] ch.284. Semua bias "nyali" memakai `cou_eff` (§1.2a).

| Aksi | Syarat | gain | bias sifat / tujuan / memori | Efek lain | Kanon |
|---|---|---|---|---|---|
| **latih** | TC ada; bukan hari misi | cmp +3 (menantang: mitra lebih kuat +6) | +0,5·C; goal terkuat +10; benign envy +8; memori kalah-duel +5 | rest −8; skill (DESAIN §6.8); stres +4 sesi ≥3 | [K] ch.243; [N] ch.9, 22 |
| **istirahat** | — | rest +25 (Bathhouse +35) | +(50−C)·0,2; `st ≥ 60` +15 | stres −8 | [K] ch.8 |
| **hobi** | item hobi ada | rel +3, aut +4, rest +10 | +0,3·O; idiosinkrasi hobi +12 | stres −5; log berulang khas hero | [N] ch.134, 273, 369, 383 |
| **daily dungeon** (sukarela) | lantai ≥5; jendela; autonomous ON; 1×/hari | cmp +5, food +5 | +0,3·cou_eff +0,3·C; goal terkuat +5; keengganan medan −15 | request bila master online; risiko mati (TERBUKA 1 %) | [K] ch.24; [N] ch.25 |
| **eksplorasi otonom** | akun ≥ L10; autonomous ON; `cou_eff ≥ 60 & aut ≤ 40` atau goal terkuat + memori digantikan | aut +20, cmp +15 | +0,4·cou_eff +0,3·O | dowry 10.000 G; absen 48 jam; risiko (TERBUKA 3 %); [K] ch.218 | Belquist BK-2 #40 |
| **makan bersama** (ringan) | Restaurant | food, rel +3 | +0,3·X | a +1 rekan meja | [N] ch.22 |
| **berteman** (§6.6) | mitra sampling a ≥ 0 | rel +6 | +0,5·X +0,2·A | f, a, t naik | [K] ch.222 |
| **menghibur** (§6.7) | rekan `st ≥ 60`/berduka & a ≥ 3 | rel +4 | +0,6·X +0,4·A; goal melindungi +10 | target stres −6, guilt −5 | [K] ch.222 |
| **mengajar** (§4.5) | flag mentor | cmp +4, rel +2 | +0,3·A +0,3·C | murid skill ×; f ×2 | [N] ch.73, 351 |
| **provokasi** (§6.5) | target a ≤ −3 atau malicious envy | cmp +4 | +0,5·(100−A) +0,3·(100−H) −0,3·X | target rel −5; a dua arah −2 | [K] ch.49 |
| **duel** (§6.4) | sengketa a ≤ −5 atau kursi party | cmp +10 | +0,4·cou_eff +0,4·(100−A); goal terkuat/membuktikan +10 | luka; r berubah | [K] ch.28, 71 |
| **mencuri** (§6.5) | `H ≤ 25` & (food ≤ 30 atau cmp ≤ 30) | food +20 / cmp +5 | +(30−H)·0,5 | item hilang; t korban −6 bila ketahuan | [N] ch.113 |
| **memeras** (§6.5) | `H ≤ 25 & X ≥ 50` & ada target `r(target→pelaku) ≥ 8` & target lebih lemah | food +15 / cmp +8 | +(30−H)·0,5 +0,2·X | target aut −10, grv +10; t korban −6 | [N] ch.158 |
| **menyuarakan keluhan** | `grv ≥ 50 & X ≥ 50` | aut +5, cmp +3 | +0,3·X | grv menyebar (§4.6) | [N] ch.65 |
| **request ke master** (§6.9) | master online / antrean mail | aut +5 (bila dikabulkan +8) | +0,3·X +0,2·O; goal diakui +5 | prompt Yes/No | [K] ch.128, 244, 110 |
| **mengenang** (§6.10) | duka aktif, loss_mode | rel +2 | trajektori | mengunjungi Archive/memento; log | [K] ch.79, 146 |
| **menganggur** | default | rest +10 | — | stres +1 bila ≥7 hari tanpa keterlibatan (goal ≠ tenang) | [N] ch.159 |

**Latihan terarah ke lantai berikutnya** [disetujui pemilik 26 Sep 2026; USUL Cowork dari kanon ch.9, 22, 34–35, 54, 67, 74–76, 110, 138–139]: bila lantai target party berikutnya diketahui (lantai tertinggi + 1, atau request misi leader §6.9) dan `TerrainData`/`EnemyData` lantai itu bertag bahaya, **party leader** dengan `C ≥ 60` atau goal terkuat/melindungi menetapkan latihan terarah pada hari non-misi — juga saat master offline (kanon ch.9: latihan jalan tanpa master). Bentuk kanon per tag: api/panas → brazier (Fire Resistance ch.35, 74) · nyeri/pendarahan → melukai diri + potion (Pain Resistance ch.34) · proyektil → dihujani panah (ch.75) · humanoid/koordinasi → sparring & formation training (ch.67, 76) · air → renang/tahan napas (ch.138–139); tag tanpa padanan → `latih` generik. Anggota ikut seperti latihan wajib §5.1 (anggota `C < 30 & A < 40` boleh skip → a −1 ke leader). Efek M0: menggantikan `latih` generik hari itu (gain & stres sama; bentuk nyeri +2 stres per sesi, TERBUKA); menambah penghitung hari latihan per tag per hero yang dipakai sistem skill M1/M5 — ambang perolehan skill resistansi TERBUKA (kanon 2–4 hari ch.74–75), disimpan bersama data skill, bukan di `npc`. Log berpotret menyebut leader & bentuk latihan.

---

## 6. EVENT: PEMICU, PROBABILITAS, KELUARAN

Konvensi: `p` per hari per hero yang memenuhi syarat; semua koefisien (TERBUKA). Pesan → §7.

### 6.1 Penilaian perintah misi (gate sebelum `MissionRequest`)
Kanon: penolakan **selalu** didahului bahaya yang dinilai tak masuk akal (ch.47) atau ketidakadilan (ch.65) — **bukan kelelahan** (RISET_Bukti bagian 1 §D pola). Seiring ★ & kepercayaan, bentuknya bergeser: 1–2★ "refused to participate" → 4–5★ **request** (retreat ch.235, potion ch.200) dan **inisiatif** (auto-dispatch ch.262) (bagian 2 §D pola [INF]).
- Tiap hero menghitung `bahaya` = estimasi kesulitan lantai vs kekuatan party (dari CSV M3; TERBUKA) dan `adil` = (100 − grv)/100.
- `p_tolak = clamp(0,02 + 0,30·(bahaya−0,5)₊ + 0,20·(1−adil) + 0,10·(1−like/100) + 0,10·(1−aut/100) − 0,15·(t rata-rata ke leader/15), 0, 0,6)` × pengali sifat `(1,3 − 0,6·A/100)` × pengali bentuk: bila `★ ≥ 3 & like ≥ 60` → 70 % kasus menjadi **request** ("[Master hero 'X' requests to retreat…]"/usul ganti lantai) alih-alih refusal.
- Sub-master/deputy: p_tolak = 0 [N] ch.48 — tetapi ini hanya untuk *refusal*; kanon sub-master justru paling banyak **berinisiatif** (Yurnet memaksa master logout ch.289; Han mengusulkan misi ch.285) → sub-master mendapat pengali ×2 pada request/usulan §6.9 dan inisiatif §6.3.
- **Compound command [FINAL 24 Sep 23:55]** — kanon [N] ch.48 "tidak bisa ditolak", format kanon tidak dijelaskan → format V0: perintah misi + ≥1 **konsesi berbiaya nyata** yang dipilih master saat mengirim: istirahat ≥3 hari sesudahnya · vacation · gift dari daftar (gold) · naik lantai. p_tolak = 0. Anti-eksploitasi (agar tidak jadi tombol "paksa gratis"): konsesi yang **sama** dipakai ≥3× berturut pada party yang sama → p_tolak hanya ×0,5 (bukan 0); dan setiap compound tetap dihitung "dipaksa" bagi hero yang p_tolak-nya sebelum pengali ≥0,3 → `aut` −15 (§2.2), luka moral bila §3.4(c). Kanon: dipaksa merusak walau dipatuhi (ch.48 morale).
- Keluaran refusal: "['X (★)' refused to participate!]" → bila ≥1: "['Party N' has become uncontrollable.]" + Tips [K] ch.47–48 → 3 opsi master (§6.2). Solidaritas: rekan dengan a ≥ 4 ke penolak ikut menolak dengan p 0,5 (kanon Aaron/Jenna/Iolka ikut Han ch.48).

### 6.2 Mogok, faksi, mass strike (§4.6)
| | |
|---|---|
| Refusal → uncontrollable | §6.1; tuntutan = kebutuhan/keluhan terendah penolak (istirahat N hari · ganti target lantai · naik lantai · fasilitas · hentikan sintesis) |
| Opsi master [K] ch.48 | **terima** → "['Party N' has become operational.]" "[Excellent Master. The hero has changed his mind!]" [K] ch.52; grv −40, like +10, aut +15 · **hukum ringleader** (sintesis/kurung) → patuh seketika tetapi luka moral pada semua a ≥ 5 ke ringleader, like −15, `grv` +10, A ringleader… (mati) · **kirim party lain** [N] ch.48 → penolak tetap uncontrollable 7 hari, aut +5 (dihormati) |
| Mass strike | faksi bertindak (§4.6 SIMCA) atau ≥40 % hero satu lantai menolak dalam 1 hari → "[Mass strike!]" "[Heroes are rioting!]" + "['Party N' has become inoperable.]" [K] ch.65; tidak ada mekanik kerusakan (kanon); latihan & daily tetap [N] ch.48 |
| Diabaikan [FINAL 24 Sep 23:55] | `grv` +3/hari; setelah 14 hari, anggota dengan `cou_eff < 50` mundur ke sinisme (§4.6) satu per satu; ringleader tetap sampai dihukum/diterima; setelah 30 hari, ringleader dengan `cou_eff ≥ 60 & autonomous ON` → **eksplorasi otonom** (pergi sendiri, pola kanon Belquist ch.218; log NONKANON `WENT_ALONE`), faksi kehilangan leader → sinisme |

### 6.3 Inisiatif tanpa perintah (kanon inti "autonomous action" [K] ch.12)
Han–Jenna–Belquist berangkat sendiri membalas invasi (ch.262); Belquist pergi menguasai imprint (ch.218); hero mengganti peran mid-fight (ch.225); Edith menghibur saat dikepung (ch.222); hero menulis wasiat sebelum L20 (ch.80). Diwujudkan sebagai: eksplorasi otonom (§5.2), auto-dispatch ke daily untuk membalas kematian rekan (memori rekan-mati-di-sisiku + goal membalas → p 0,1/hari selama 14 hari; hero absen 1 hari; log "['X' went out alone."—NONKANON), dan "menulis wasiat" (idiosinkrasi diary + misi boss besok → log; bila mati, wasiat = memento otomatis §6.10).

### 6.4 Duel tak disuruh
Pemicu: (a) sengketa `a ≤ −5` dua arah; (b) kursi party: hero goal terkuat/membuktikan, bukan party utama, vs anggota terlemah party utama dengan `r → ≤ 2`; (c) malicious envy ≥ 30 hari. `p = 0,04·cou_eff/100·(1 + (100−A)/100)` (a); `0,02·(goal? 1,5 : 1)` (b). Alur [K] ch.28: challenge → diterima bila `cou_eff ≥ 40 || H ≤ 40` (gengsi) → syarat: kursi (b) / tanpa syarat (a) / **"Synthesis" hanya bila salah satu `A ≤ 20 & H ≤ 30`** → master menyetujui → engine M2 headless 1v1 (`TerrainData.sparring`, recovery OFF) → "['A' won the duel!]". Akibat: kalah r +3 ke pemenang (prestige) bila kalah terhormat, a −2 bila dipermalukan (pemenang `A ≤ 30`); memori menang/kalah; kursi ditukar bila (b) [N] ch.71–73. **Ikut campur (kanon ch.29: dibunuh) = OFF [FINAL V0, 24 Sep 23:55]**; bila V1+ mengaktifkan, eksekutor = peri wujud gelap (manhwa ch.17 [T-gambar]), bukan hero membunuh hero.

### 6.5 Pencurian, pemerasan, provokasi, permusuhan
- **Mencuri**: aksi §5.2; ketahuan `0,5` (+0,2 bila ada Manager) → log NONKANON + prompt master 3 opsi kanon: kurung 7 hari (`st` +15, aut −20) / sintesis / ampun (like +5; `H` pelaku −0 tetapi t korban→pelaku −6 permanen-ish [PSI integritas]) [N] ch.113, 157.
- **Memeras** (kanon ch.158: hero memeras 100.000 dari sesama hero; aturan Taoni: membunuh/mencuri/merusak = hukuman mati [N] ch.158): aksi §5.2, varian *terbuka* dari mencuri untuk hero `H ≤ 25 & X ≥ 50` — korban tahu siapa pelakunya (tidak ada roll ketahuan), t korban→pelaku −6 seketika, korban `grv` +10 & `aut` −10; korban dengan `cou_eff ≥ 50` boleh menantang duel (§6.4a) atau melapor (request ke master §6.9, p 0,3) → prompt master 3 opsi sama dengan mencuri. Pemerasan berulang ≥3× pada lantai yang sama → `grv` lantai +5 (keluhan menyebar).
- **Provokasi**: aksi §5.2 → a dua arah −2; bila `a ≤ −5` dua arah → **Enmity** "['A' shows hostility towards 'B'!] [Enmity has been established!…]" [K] ch.49 → kompatibilitas party negatif (§8.2), kandidat duel. Enmity bawaan saat summon (kanon ch.49): 1 pasangan per 10 summon berturut dengan p (TERBUKA 5 %).
- **Rekonsiliasi** (kanon Katio diredakan Han ch.128): hero `A ≥ 60 & X ≥ 50` boleh "meredakan" mitra bermusuhan: p 0,05/hari → a +2 dua arah bila mitra `A ≥ 30`; gift dari master ke keduanya +1 lagi.

### 6.6 Berteman & klik
Interaksi sampling dengan a ≥ 0: `p = 0,10·(0,3 + X/100)` → f +1 (×bobot §4.3), a +1 (homophily), t +1 bila ada tindakan tepercaya. Ambang Hall (§4.3) menghasilkan log berbeda: "mulai sering terlihat bersama" (teman) → "menyebut X sahabatnya" (dekat) → **Bond** non-summon "[A bond '…' has been created!]" [K] ch.27 (nama bond digenerasi dari tag/peristiwa: "Dua Penyintas Lantai 5"). **Bond non-summon = bonus tempur sama dengan bond summon [FINAL 24 Sep 23:55, INF]** — kanon ch.27 hanya menyebut "stronger fighting power when in the same party" tanpa membedakan asal bond; dipilih sama demi kesederhanaan (A6 #30). Klik ≥3 (§4.6) → party leader cenderung mengusulkan fixed party berisi kliknya [K] ch.30.

### 6.7 Menghibur & dukungan
Kanon [K] ch.222; Han meredakan Katio ch.128; ritual rest ch.230. Pemicu: B `st ≥ 60` atau berduka; A dengan `X ≥ 40 & A ≥ 40 & a(A→B) ≥ 3`; `p = 0,20·(X+A)/200`. Efek: B st −6, guilt −5 (hanya penghibur t ≥ 9, maks 3× per episode luka; LAPORAN wk2c Q3 + PSI-angka #26), a dua arah +2, d(B→A) +1; **hanya rekan dengan t ≥ 9 memberi pengali pulih ×1,5** (dukungan yang *dirasakan tersedia* [PSI Cohen & Wills]). Di misi: string [K] ch.222 lewat `MissionResult` hook.

### 6.8 Ikatan Sumpah (menggantikan "cinta")
Kanon: sebutan keluarga "older brother"/"sister" antar rekan party (ch.387, 396); "energi terhubung" (ch.387); trio yang selalu bersama; bond bubar bila anggota keluar (ch.29). Syarat: `a ≥ 6 & t ≥ 12 & f ≥ 12` dua arah, `p = 0,05/hari`; nama Sumpah digenerasi (saudara seperguruan/saudara sumpah — kulit wuxia). Efek: = Bond tempur; kematian salah satu → duka intim (§6.10) dengan trajektori bergeser ke kronis; yang hidup mewarisi 1 memento otomatis. Cemburu/segitiga tidak dibangun. Kebijakan Roblox: §0.

### 6.9 Request & usulan ke master (kanon paling kaya)
Semua string [K] KANON_04 §4.5.2. Pemicu & p (TERBUKA): gift favorit (cmp ≤ 40 & hobi koleksi: "['X' wants 'Y X n'…]" ch.128) 0,05; fasilitas (rest ≤ 30 tanpa Bathhouse / C ≥ 70 tanpa TC: ch.244) 0,1; join party ("['X' wants to join…]" ch.16: rel ≤ 40 & ada klik di party itu) 0,08; fixed party (leader `X ≥ 60` & klik ≥3: ch.30) 0,05; misi ("[Request – Go to the Nth floor]" ch.110: leader goal terkuat & party kuat) 0,08; rekaman (C ≥ 60 & Playstone: ch.108) 0,05; mock battle (O ≥ 60 & like ≥ 70: ch.148) 0,02; retreat (§6.1); menolak jabatan (ditawari & goal terkuat & `aut` tinggi: Aaron ch.347) 100 % bila syarat; melapor pemerasan (§6.5); **rehat/vacation** [pemilik 26 Sep 18:23: "yang lemah bisa minta rehat dari petualangan"; kanon terdekat request fasilitas ch.244 & retreat ch.235; besaran PSI-angka #48/P-K10]: `st ≥ ambang − 15` (warning aktif) & `cou_eff < 50` → p 0,3/hari, string NONKANON `REQUEST_REST` (Data_Strings_NONKANON §12); dikabulkan = vacation §3.3 + aut +8; hero `cou_eff ≥ 60` tidak meminta, mengatasi sendiri lewat istirahat/hobi (§5.2 w.rest ×2 saat `st ≥ 70`). Sub-master ×2 (§6.1). Request dikabulkan: aut +8, like +4, d(hero→master) +1; ditolak: aut −5, like −3; ditolak ≥3 berturut: memori "dikhianati" valensi −1.

### 6.10 Kematian & duka — osilasi, trajektori, continuing bonds
Kanon: bentuk duka = keluar bond (Edith ch.29), berserk/soul turbulent saat rekan sekarat (Han ch.144), Archive + mementos (ch.79), patung berkabung hasil sintesis (ch.146), replay arsip (ch.146), jeda >1 bulan (ch.147), rest dipaksakan (ch.230), amber ring (ch.230), comfort item (ch.166), storage terbatas: barang hero rendah tidak disimpan (ch.230), 5 hero tanpa kenang-kenangan (ch.146), slot kosong yang dipikul leader (ch.375). Menangis/upacara eksplisit TIDAK KETEMU di ekstraksi.
[PSI §6] Kübler-Ross DIBANTAH → tidak dipakai. **Dual Process** (osilasi loss/restoration), **trajektori Bonanno** (≈46–60 % resilien, 10–15 % pulih ~6 bulan, 10–15 % kronis), **continuing bonds**, ritual unit, survivor guilt, humor gelap.

| Komponen | Aturan |
|---|---|
| **Siapa berduka** | semua hero dengan slot ternotasi ke korban (a ≥ 3 atau t ≥ 9 atau flag) + rekan party saat kematian + guru/murid; intensitas awal `I = (a+7)/14 × f/15 × (flag intim? 2 : 1) × (mendadak/di sisinya? 1,5 : 1) × (0,6 + E/100)` |
| **Trajektori** (prinsip §0: **bukan** roll kategori, tetapi turunan keadaan) | durasi dasar `D = 14 hari × (1 + 3·I)` lalu dimodulasi: `× (0,6 + vul/100)` (rapuh lebih lama) `× (dukungan t ≥ 9 ada? 0,9 : 1)` `× (mendadak / di sisinya? 1,25 : 1)` `× (kehilangan beruntun ≤60 hari? 1,3 : 1)` `× (st ≥ 60 sebelum? 1,5 : 1)`; bila a ≤ −3 → "membaik" (beban lepas, D = 3 hari). Hasilnya diharapkan menyebar seperti meta trajektori (resilien ≤21 hari 55–70 %, pulih ≈180 hari 15–25 %, kronis >360 hari 5–12 %; late-onset 0–9 % boleh muncul) [PSI-angka #28–30: Galatzer-Levy 2018 65,7/20,8/10,6 %; dukungan menurunkan beban depresi tanpa mempersingkat duka → dipindah ke amplitudo (P-K9); ketidaksiapan OR 3,58] — rentang itu **pembanding §9**, bukan bobot roll. Intim/Sumpah/mentor: D ×1,5 |
| **Osilasi harian** | `loss_mode` p mulai 0,7 → 0,3 selama trajektori: aksi "mengenang" (Archive/memento), produktivitas −30 %, `rel` −2; `restoration_mode`: mengambil peran korban (party leader kosong, jabatan), latihan normal. Puncak indikator negatif bulan 1–4 (Maciejewski) → kurva stres duka: +I·20 hari 1 (×0,75 bila ada dukungan t ≥ 9), meluruh ke 0 di akhir trajektori dengan plateau kecil 0,3·I hari 90–150; tanpa lonjakan 12 bulan (hanya aksi mengenang) [PSI-angka #31: kerinduan puncak bulan 4–6; reaksi tanggal hanya ≤6 bulan] |
| **Continuing bonds** (kanon: patung, arsip, comfort item) | hero mewarisi 1 memento bila barang korban ada di storage (kanon: hanya bila barang disimpan ch.79/230 — hero lantai rendah tanpa barang = "mati dua kali", sengaja dipertahankan sebagai kesedihan kanon); memento = comfort item −1 stres/hari; log berulang "menyebut X" p turun 0,3 → 0,05 tetapi **tidak ke nol**; hari peringatan kematian → aksi mengenang wajib |
| **Ritual unit** | Archive dibangun & barang dienshrinekan [K] ch.79 → semua yang berduka st −6, guilt −3, `f` antar yang hadir +1 (kohesi); D **tidak** dipersingkat [PSI-angka #25/#32]; master hadir (membuka Archive/replay) like +5; kematian diabaikan (tidak ada Archive, barang tidak disimpan) → `grv` kolektif +10, durasi duka ×1,3 |
| **Survivor guilt** | rekan party yang hidup saat korban mati: guilt +15 (+15 lagi bila "bisa menolong": HP >50 % saat itu); leader +10 (kanon Siris ch.375); pulih lewat penebusan/ritual (§3.4). Penyintas tunggal (Kishasha ch.159): guilt +40, D ×1,5 |
| **Humor gelap** | hero `X ≥ 60 & E ≤ 40`: aksi ringan "melucu" p 0,1 saat duka kolektif → st −3 untuk klik-nya, a −1 dari yang paling dekat dengan korban (menyinggung) |
| **Efek pada sifat** | §1.2: ikatan intim mati → E +3, X −2 (50 % hero); memori kunci "rekan-mati-di-sisiku"; `xp` −6 bila rekan mati di sisinya tanpa pemulihan (§1.2a) |
| **Bond/Sumpah bubar** | "[The relationship '…' will be disbanded.]" [K] ch.29 |
| **Untuk pemain** | §7.3: kartu memorial otomatis merangkum 3–5 memori spesifik korban + idiosinkrasi + relasi bernama — bahan duka parasosial [PSI §6 identifiable victim] |

### 6.11 Event lain (ringkas)
| Event | Pemicu | Keluaran |
|---|---|---|
| Komplain masakan | food ≤ 40 & pref tidak cocok, p 0,3 | "['X' is dissatisfied with the cooking.]" [K] ch.16; ≥30 % → Tips |
| Komplain riset | jam > 3 | "['X' expresses dissatisfaction!]" [K] ch.53 |
| Stagnasi (kemewahan) | lantai ≥3 & semua need ≥ 90 selama 30 hari & goal ≠ terkuat | C −1/minggu (drift; berlaku semua hero, tidak tunduk roll plastisitas §1.2) [N] ch.156; hero Valhalla bosan ch.326 |
| Kebosanan tugas | tugas sama ≥5 hari (O ≥ 60 ×1,5) | cmp −2/hari; request variasi |
| Menolak jabatan | ditawari; goal terkuat & aut ≥ 60 | log NONKANON [N] ch.347; tidak ada sanksi kanon |
| Menilai master | like ≤ 30 selama 30 hari | request berkurang 50 %, inisiatif sendiri naik (kanon: hero "menilai master" BK-3 #42; hero Unity pasif vs Taoni berinisiatif ch.153) |
| Emosi menular di party | 1 hero fear/panic di misi (M2) | M2 memakai `fearResistance`; di waiting room: rekan a ≥ 3 dari hero `st ≥ 70` → st +2/hari |
| Rekonsiliasi | §6.5 | a naik |
| Stress warning | §3.5 | [K] ch.284 |
| **Penyangkalan pra-sintesis/hukuman** | hero dijadwalkan sintesis/kurung (master menaruhnya di antrean) | manhwa ch.5 [T-gambar]: hero berteriak "You're sending me home, right?! I'm going back home!" → keadaan `denial` 1–3 hari: balon bicara & log NONKANON bertingkat (berharap pulang → tawar-menawar → diam); hero `E ≥ 60` teriak, `E ≤ 40` diam; rekan a ≥ 3 yang menyaksikan: luka moral §3.4 (+guilt), aksi menghibur +; bila master membatalkan → like +10, memori "diselamatkan-oleh master" |

---

## 7. KELUARAN: PESAN, LOG, BALON, MEMORIAL, REPORT

### 7.1 Prinsip [PSI §7 mind perception; manhwa ch.8]
Kanon manhwa: hero punya percakapan & kehidupan penuh yang **tidak** sampai ke master — "He can't hear our voices… it's going to get filtered and reduced before being relayed to the master" [T-gambar ch.8]; yang sampai hanya pesan ringkas per hero ("Jenna(★) is discontent about the food"). Feed kita = saringan itu; hero **sadar** disaring, sehingga yang ingin didengar harus bertindak (request/mogok/duel) — dasar kanon untuk §6. Yang memicu empati pemain = tanda **Experience** (lapar, takut, rindu, lega, malu, bosan) — bukan kecerdasan taktis. Karena itu setiap aksi/event menghasilkan **entri log berpotret** yang menunjukkan perasaan, dan **balon bicara** hero di markas 2D menampilkan `kind` aksi hari ini (RISET_HUD §4). Tidak ada angka.

### 7.2 Empat saluran
1. **Pesan sistem verbatim** `Data/Strings.luau` — semua [K] dari KANON_04/05 & §6 (contoh §7.4); teks utuh string [K] yang terpotong di DESAIN_SISTEM ada di `Data_Strings_K_Lengkap.md`. String tambahan berlabel `-- NONKANON`, ditulis LLM **offline** dalam gaya sistem, id ditentukan di sini: `STEAL, EXTORT, PROVOKE, WENT_ALONE, DECLINED_POSITION, GRIEF_VISIT, MENTIONS_DECEASED, BOND_NAMED, WILL_WRITTEN, MEMORIAL_CARD` (teks di `Data_Strings_NONKANON.md`).
2. **Log/feed** `{day, heroId, kind, targetId?, payload}` — tanpa nilai tersembunyi; payload hanya id string + nama; ditampilkan sebagai feed berpotret dengan 3–5 varian teks per kind (LLM offline). **Pemilihan varian deterministik per hero**, bukan acak: `variantIndex = hash(heroId, kind, idiosinkrasi.hb) mod n` — sehingga tiap hero punya "suara" tetap untuk kind yang sama (Han selalu diberitakan dengan kalimat yang sama saat mengenang; Iolka dengan kalimat lain). Alasan: dengan 20+ hero × 30 hari, varian acak membuat pola template terlihat dan merusak uji §9 butir (d); varian tetap per hero justru terbaca sebagai kepribadian [PSI §7 idiosinkrasi]. Varian juga menyisipkan nama relasi dan idiosinkrasi hero (bukan hanya nama korban/target).
3. **Balon bicara** di markas: satu ikon/teks pendek per hero = aksi hari ini (latih/istirahat/hobi X/mengenang Y/kesal/senang).
4. **Kartu memorial** (Archive, DESAIN §5.2): saat hero mati, sistem merangkai kartu dari: nama & ★ & umur layanan; 3–5 memori valensi tertinggi (dengan siapa); idiosinkrasi (hobi, makanan, kebiasaan); relasi bernama (sahabat, murid, sumpah); barang peninggalan (bila ada). Ini bahan duka pemain; pemain boleh memberi nama nisan & memilih memento (ritual [PSI §6]).
5. **Business report sub-master** [K] ch.268: ringkasan mingguan tanpa angka tersembunyi: siapa stres (nama), siapa berduka, keluhan lantai, klik yang terbentuk, usulan (bangun Bathhouse; naikkan X; beri libur party N).
6. **Kotak rekomendasi peri** (M7/M8) [disetujui pemilik 26 Sep 2026; INF kanon ch.24, 67, 138, 204, 268]: semua request hero (§6.9), usulan party leader (komposisi, lantai, latihan terarah §5.2), laporan & usulan sub-master (butir 5), dan rekomendasi sistem (mis. fasilitas kurang, hero ber-warning stres) dihimpun jadi satu antrean Yes/No yang disampaikan peri; pemain cukup menekan Yes/No. Peri tidak memutuskan sendiri (kanon ch.24 "But I can't"); bila ada sub-master, usulan dispatch/komposisi datang lewat sub-master (ch.204). Tanpa angka tersembunyi.

### 7.3 Format string (contoh)
```
S.STRESS_WARN   = "[Warning!]\n[Hero '{name} ({stars})'s stress level is dangerous!]"           -- [K] ch.284
S.SUDDEN_DEATH  = "['{name} ({stars})' has returned to the arms of the goddess. His fighting spirit will be remembered forever.]\n[Sudden death!]\n[Cause – Suicide due to stress]"  -- [K] ch.7
S.REFUSED       = "['{name} ({stars})' refused to participate!]"                                   -- [K] ch.47
S.PARTY_UNCTRL  = "['{party}' has become uncontrollable.]"                                          -- [K] ch.48
S.STRIKE_TIPS   = "[Tips/Heroes sometimes strike. You can resolve this by accepting their demands or punishing the ringleader.]" -- [K] ch.48
S.MASS_STRIKE   = "[Mass strike!]\n[Heroes are rioting!]"                                            -- [K] ch.65
S.DUEL_CHALL    = "['{a} ({sa})' challenges '{b} ({sb})' to a duel!]"                                -- [K] ch.28
S.ENMITY        = "['{a}' shows hostility towards '{b}'!]\n[Enmity has been established! Observe carefully between the heroes!]" -- [K] ch.49
S.BOND_CREATED  = "[A bond '{bond}' has been created!]"                                              -- [K] ch.27
S.BOND_DISBAND  = "[The relationship '{bond}' will be disbanded.]"                                   -- [K] ch.29
S.COMFORT       = "[Hero '{a} ({sa})' comforts her teammates!]\n[The morale of the raid team is rising!]" -- [K] ch.222
S.AUTO_EXPLORE  = "[Autonomous action is activated!]\n[Master hero '{name} ({stars})' starts exploring!]\n[The dowry is automatically distributed to the hero. 10000G consumed.]" -- [K] ch.218
S.WANTS_GIFT    = "['{name} ({stars})' wants '{item} X {n}'. Do you want to gift it?]"              -- [K] ch.128
S.REQ_FACILITY  = "[Master hero '{name} ({stars})' requests the '{facility}' facility!]"            -- [K] ch.244
S.REQ_RETREAT   = "[Master hero '{name} ({stars})' requests to retreat from the field!]"            -- [K] ch.235
S.ARCHIVE_DONE  = "[The archive is complete! You can look back on the heroes who left in the arms of the goddess.]" -- [K] ch.79
S.GRIEF_VISIT   = "['{name}' spent the evening at the archive, in front of '{deceased}'s belongings.]" -- NONKANON
S.MENTIONS_DECEASED = "['{name}' mentioned '{deceased}' again today.]"                               -- NONKANON
S.EXTORT        = "['{a}' took '{item}' from '{b}' by force.]"                                       -- NONKANON
```

---

## 8. INTEGRASI

### 8.1 Catch-up saat login (RENCANA §3.2)
`Autonomy.catchUp(profile, nowUtc)`: Δhari = (now − lastSeen) × 3, maks 21 hari in-game (sisa = "istirahat": need → 80, st −3/hari, duka tetap berjalan, tanpa event lain). Loop `Npc.tickDay(state, day, rng)` di coroutine, `task.wait()` tiap 200 hero; pesan → `mail`, log → `replays`, memori → hero. Online: tick tiap 8 jam Bumi. **Sudden death selama catch-up [FINAL 24 Sep 23:55, setia kanon]:** roll §3.5 tetap berjalan di 21 hari pertama absen — hero bisa mati saat pemain tidak login (kanon Mormont ch.7: master tidak tahu apa-apa; hero hidup mandiri ch.207). Warning [K] ch.284 tetap masuk `mail` dengan tanggal in-game-nya, sehingga pemain yang kembali melihat urutan: warning → (bila terlambat) kematian. Ini disengaja untuk tujuan M0 (kematian yang bisa dicegah tetapi terlewat = duka yang nyata), bukan bug.

### 8.2 Kontrak combat engine (BRIEF_SCRIPTER §3 — `hesitation`, `panicEvents`, `minHpPct`, `EnemyData.isHumanoid` sudah masuk draf kontrak sebelum scripter direkrut; disepakati tertulis di T0)
| `HeroInput.hidden` | Sumber M0 |
|---|---|
| `fearResistance` 0..1 | `0,15 + 0,55·cou_eff/100 + 0,15·(100−E)/100 + 0,15·(100−vul)/100 − 0,2·st/100`, clamp — `cou_eff` (§1.2a) membawa genetik + pengalaman + keausan |
| `stressBand` 0..3 | 0: st<40 · 1: 40–69 · 2: 70–ambang · 3: ≥ambang |
| `bondWith` | flag Bond/Sumpah/mentor |
| `enmityWith` | flag Enmity atau a ≤ −5 |
| `compatibility {id: n}` | `(a/7 + (t−4)/11 − (env==2 ? 0,5 : 0))` untuk anggota party sama, rentang −1,5..+2 |
| `hesitation` 0..1 (TERBUKA/USUL, §3.4) | `clamp(0,3·(A−50)/50, 0, 1)` bila `A ≥ 65`, else 0 — dipakai engine hanya untuk target `EnemyData.isHumanoid = true`; tidak memengaruhi target non-humanoid. Sudah tercantum di draf kontrak BRIEF_SCRIPTER §3 (tanpa biaya change request karena scripter belum direkrut); tetap berstatus usulan desain (§10.2 #6) |
**Sebelum kirim:** gate §6.1; party uncontrollable ditolak. **Setelah `MissionResult`:** `alive=false` → §6.10 untuk semua yang berduka; `mvpHeroId` → cmp +25, st −8, memori MVP; rekan setingkat MVP → evaluasi iri (§4.3); vs humanoid → §3.4 bagi A ≥ 65; `awakeningEvents` → cmp +5; `damageTaken` tinggi → memori; semua: rest −25, st +10 (kurva §3.3), f rekan party ×5; `contribution` rendah ≥3 misi → cmp −5, guilt (jadi beban) +5; party wipe dengan penyintas → survivor guilt; **`panicEvents` per hero → `xp` (§1.2a): kosong (selamat tanpa panic) → +2, atau +4 bila kritis (`minHpPct < 30` atau ada rekan party `alive=false`); episode `panic`/`despair` dicatat untuk cek pemulihan 3 hari berikutnya** (`fear` saja tidak dihitung sebagai episode sensitisasi — TERBUKA).

### 8.3 Modul lain
M1: `Traits.roll` + `xp` seed + goal + idiosinkrasi + tag di `Hero.new()`; Bond/Enmity summon → slot. M5: lantai/jabatan/fasilitas → §2.2, §4.5; duel → M2 headless; Archive → §6.10. M7: gift/likeability, warning/sudden death, 3 opsi mogok, hukuman, vacation, compound command UI (§6.1). M8: feed berpotret, balon, kartu memorial, prompt Yes/No.

---

## 9. RENCANA TEST HEADLESS (TestEZ `tests/npc.spec.luau`, harness `sim/npc_sim.luau`)

**Skenario A (pasif):** 100 hero (60×1★, 30×2★, 10×3★; 4 party tetap; 20 di lantai 2 dengan Restaurant+Bathhouse, 80 di lantai 1 tanpa), 365 hari in-game, master tidak bertindak, seed 1..20. **B (aktif):** misi tiap 3 hari dari CSV M3 L1–10, 1 gift/minggu acak, semua prompt "Yes", Archive dibangun. **C (keras):** misi tiap 2 hari, 2 kematian/bulan disuntikkan, prompt diabaikan, tanpa Archive. Test gagal bila metrik di luar rentang pada ≥15/20 seed. **Semua proporsi di bawah adalah hasil emergen yang diverifikasi, bukan parameter (prinsip §0).**

| Metrik | A | B | C | Dasar |
|---|---|---|---|---|
| Hero dengan ≥1 relasi t ≥ 9 pada hari 365 | 55–75 % | 65–85 % | 50–70 % | Dunbar/penyendiri 25–35 % [PSI §3] |
| Hero tanpa relasi ternotasi sama sekali | 10–30 % | 5–20 % | 10–30 % | penyendiri sehat (emergen dari X); Dica/Chloe/Roderick kanon |
| Klik ≥3 | 3–10 | 4–12 | 3–10 | trio/party inti kanon |
| **Faksi/gang** (SIMCA) | 1–4, pertama hari 60–150 | 0–1 | 2–5 | ch.65: 10/25 lantai 1 setelah hierarki |
| Proporsi anggota lantai 1 yang ikut mass strike | 25–55 % | — | 30–60 % | kanon ~40 %; [PSI] 30–50 ikut (emergen) |
| Refusal individu per perintah | — | 3–15 % | 10–30 % | kanon: hanya saat bahaya/ketidakadilan |
| Refusal yang berbentuk request (bukan mogok) pada hero ★≥3 like ≥60 | — | ≥60 % | ≥40 % | pola BK-2 §D |
| **Fear/panic di misi: 1★ segar vs 3★ segar (misi 1–3)** | — | 1★ ≥2× lebih sering | sama | [N] ch.10 (xp seed) |
| **Fear/panic: 1★ setelah 12 misi dengan pemulihan vs 3★ segar** | — | ≤1,2× (setara) | — | habituasi §1.2a; kanon Han ch.10 |
| **Fear/panic: 3★ dipaksa 8 misi beruntun vs 1★ dirawat** | — | — | 3★ ≥1,5× lebih sering | sensitisasi + ld §1.2a; kanon ch.70, 284 |
| Duel tak disuruh | 3–20 | 3–15 | 5–25 | ch.28, 71 |
| Enmity baru | 2–12 | 1–8 | 3–15 | ch.49 |
| Ikatan Sumpah | 1–8 | 3–12 | 1–8 | §6.8 |
| Mentor–murid aktif | 2–10 | 3–12 | 1–8 | ch.73, 351 |
| Pencurian + pemerasan (hanya H ≤ 25) | 1–10 | 0–6 | 2–12 | ch.113, 158 |
| Malicious envy aktif | 2–15 | 3–20 (gift acak = tidak adil) | 2–15 | Iolka–Katio |
| **Sudden death** | **0–2** | **0–2** | **3–12** | Mormont; Joiner: hanya kombinasi faktor |
| Sudden death pada hero dengan ≥1 relasi hidup t ≥ 9 | 0 | 0 | ≤1 | faktor pelindung |
| Sudden death dalam 30 hari setelah kehilangan ikatan intim (C) | — | — | ≥1 dari tiap 6 kasus | kanon ch.42 (B1) |
| Warning stres : sudden death | ≥3:1 | ≥3:1 | ≥3:1 | jendela pemain |
| Trajektori duka (C) resilien/pulih/kronis | — | — | 55–70 / 15–25 / 5–12 % | meta trajektori [PSI-angka #28] (emergen dari D §6.10) |
| Hero berduka yang masih "menyebut" korban hari 180 | — | ≥50 % | ≥50 % | continuing bonds |
| Rata-rata memori per hero hari 365 | 6–10 | 7–10 | 7–10 | §1.5 |
| Idiosinkrasi muncul di log per hero per 30 hari | ≥4 | ≥4 | ≥3 | §1.4 |
| Determinisme | identik byte-per-byte | | | aturan 2 |
| Kinerja | 2.000 hero × 21 hari < 1,5 s CPU | | | RISET_Batas |
| Byte | `JSONEncode(hero)` ≤ 900 | | | RENCANA §3.3 |

**Uji "terasa hidup" (manual, Tahap 0 akhir):** 3 penguji awam membaca feed 30 hari 20 hero tanpa melihat angka → tiap penguji harus bisa (a) menamai 3 hero dari kebiasaannya, (b) menebak siapa berteman dengan siapa, (c) menjelaskan *sesudahnya* mengapa satu hero menolak/pergi — tetapi (d) tidak memprediksi tepat sebelum kejadian [PSI §7]. Lulus bila ≥2/3 penguji memenuhi a–c dan tidak ada yang memenuhi d pada ≥80 % kasus.

---

## 10. STATUS KEPUTUSAN M0 (diperbarui 25 Sep 2026, 20:40 WIB)

### 10.1 [FINAL] — diputuskan pemilik 24 Sep 23:55, tidak dibuka ulang
1. **Prinsip populasi** (§0): tidak ada kategori psikologis yang di-roll; proporsi = hasil emergen; ★ = pengalaman awal (`xp`), bukan watak.
2. **Compound command** (§6.1): perintah + ≥1 konsesi berbiaya nyata; anti-eksploitasi ×0,5 setelah 3× konsesi sama; tetap "dipaksa" bagi yang keberatan.
3. **Ikut campur duel** (§6.4): OFF untuk V0; V1+ eksekutor peri (manhwa ch.17).
4. **Bond non-summon** (§6.6): bonus tempur sama dengan bond summon [INF].
5. **Mogok diabaikan** (§6.2): sinisme bertahap; ringleader bernyali pergi sendiri setelah 30 hari.
6. **Sudden death saat offline** (§8.1): tetap berjalan, setia kanon.
7. **Sudden death & kehilangan** (§3.5): relasi ke hero mati tidak melindungi (kanon ch.42).
8. **Varian log deterministik per hero** (§7.2).
9. **Pemerasan** sebagai aksi (§6.5, kanon ch.158).
10. **Discharge** = [V1+]; di V0 goal "hidup tenang/pulang" hanya memengaruhi refusal & request vacation.
11. **Id string `MENTIONS_DECEASED`** (§7.2–7.3) — bukan `MENTIONS_DEAD` (pemilik, 25 Sep 2026).
12. **Data `panicEvents` + `minHpPct` dari engine** (§8.2) sebagai sumber `xp` — masuk draf kontrak BRIEF_SCRIPTER §3 (pemilik, 25 Sep 2026).
13. **Plastisitas sifat per hero** (§1.2): 50 % hero tidak pernah bergeser, ditetapkan per hero seumur hidup; erosi isolasi & stagnasi berlaku untuk semua hero (LAPORAN 2026-09-26 Q2/Q3).
14. **Latihan terarah ke lantai berikutnya** (§5.2) dan **kotak rekomendasi peri** (§7.2 #6) — pemilik, 26 Sep 2026. "Pura-pura latihan" TIDAK dibangun kecuali ditemukan dasar kanonnya (pemilik: "kalau tidak ada di kanon, tidak usah").

### 10.2 (TERBUKA — tunggu implementasi/simulasi, bukan PR desain)
1. Semua koefisien §1.2/§1.2a roll, drift, `xp`, §2.2 laju, §3.2–3.5 (ambang, `vul`, `ld`, p sudden death), §3.6, §4.3 Δ & bobot f, §4.6 SIMCA, §5.2 bobot/bias/noise, §6 probabilitas, §6.10 durasi D — dikalibrasi §9 setelah harness jalan (M0 minggu 4). Angka berlabel **[PSI-angka]** (26 Sep 2026, disetujui pemilik; dasar di `RISET_NPC_Kalibrasi_Empiris.md` §1) adalah default awal kalibrasi 4.4 — boleh digeser oleh harness, tetapi arah & rasio antar-angka (mis. −5/−10, ×2 hari 1–7) dipertahankan. Ditolak pemilik untuk V0: peluruhan `xp` & bekas panik (P-K3 = C, kanon Han ch.10), jendela kehilangan 180 hari (P-K11 = B).
2. `rl`+`mm` di `heroes_N` vs `social_N` — diputuskan di M1 5.3; data terukur di §1.6 (npc lengkap 1.368 byte > 900).
3. Estimasi `bahaya` lantai (§6.1) — dari CSV M3 T3.
4. **[PSI]** habituasi/sensitisasi (§1.2a) — status label naik final dari [PSI-cek] ke [PSI] (25 Sep 2026, disetujui pemilik): diverifikasi via RISET_NPC_Psikologi_Manusia.md §5.1, arah & bentuk mekanisme konsisten dengan literatur (Groves & Thompson 1970, SEFL, stress inoculation, differential susceptibility). Kekuatan bukti berbeda per komponen (dicatat di §1.2a): habituasi & stress inoculation [KONSENSUS]; sensitisasi/SEFL [PERDEBATAN] (basis studi rodent). Angka spesifik (+2/+4/−3/−6/×1,5) tetap TERBUKA/ESTIMASI — bukan derivasi literal dari studi manapun, hanya arah & bentuk mekanisme yang terverifikasi.
5. **Kesadaran status sendiri `awr`** (§1.6a) — dasar kanon kuat (ch.53–56, Hero Reactivity Lv.1), tapi efeknya pada bias latih & envy adalah **usulan saya** (belum ada kanon yang menjelaskan efek perilaku spesifik dari kesadaran ini) — koefisien 0,3/0,5 TERBUKA, perlu dikalibrasi §9 seperti koefisien lain.
6. **`hesitation` mid-combat vs humanoid** (§3.4/§8.2) — **seluruhnya usulan saya [USUL]**, bukan derivasi kanon literal: kanon ch.55–57 hanya menyebut efek pasca-misi (stres naik), belum ditemukan bukti kanon untuk perilaku *selama* pertarungan (pencarian kami terbatas pada novel ch.1–400 yang sudah diekstrak + 16 screenshot manhwa ch.4–17 — adegan spesifik yang disebut pemilik dari manhwa ch.44–45 belum bisa diverifikasi, sumber pembaca manhwa online tidak bisa diakses untuk ekstraksi dan wiki fandom tidak memuat ringkasan chapter itu). Field `hesitation` dan `EnemyData.isHumanoid` sudah masuk draf kontrak BRIEF_SCRIPTER §3 sebelum scripter direkrut (tanpa biaya change request); disepakati tertulis di T0. Bila pemilik nanti mendapat screenshot/sumber terverifikasi ch.44–45, rancangan ini WAJIB ditinjau ulang terhadap bukti itu.
7. **Episode `fear`** (tanpa eskalasi ke panic) dihitung sebagai sensitisasi atau tidak (§8.2) — default: tidak; dikalibrasi §9.

### 10.3 [PENDING — tugas terpisah, bukan keputusan]
(Kosong — butir 1, teks NONKANON + kartu memorial, telah diselesaikan; lihat `claude/Data_Strings_NONKANON.md`.)
