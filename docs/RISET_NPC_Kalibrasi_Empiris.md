Terakhir diperbarui: 26 September 2026, 19:55 WIB

# RISET NPC — KALIBRASI EMPIRIS: dari angka (TERBUKA) ke default [PSI-angka]

Status: [V0 — **disetujui pemilik 26 Sep 2026 19:32**: Blok A seluruhnya + P-K1 A · P-K2 A · P-K3 C · P-K4 A · P-K5 A · P-K6 A · P-K7 A · P-K8 A · P-K9 A · P-K10 A · P-K11 B; sudah dimasukkan ke DESAIN_AI_NPC_V0 sebagai [PSI-angka]]. Melengkapi `RISET_NPC_Psikologi_Manusia.md` (sumber #1–64; **tidak diulang** di sini — berkas ini menambah **besaran**, bukan bentuk). Sumber baru bernomor **#65 dst.** di §10. Dipakai oleh Brief §B 4.4 (kalibrasi harness) dan oleh putaran otomatis untuk mengisi `NpcData`.

## 0. Prinsip, cara membaca, asumsi konversi

**Prinsip pemilik (26 Sep 2026, 18:23):** hero = manusia utuh berkehendak bebas, persis PMU. **APA** yang hero lakukan dan bisa lakukan ikut kanon PMU; **BESARAN** dan aspek perilakunya diambil dari studi neurosains/psikologi. Berkas ini hanya menyentuh besaran. Bila bukti menunjukkan **bentuk** rumus perlu berubah, itu ditulis sebagai pertanyaan di §8 — tidak diubah diam-diam.

**Label:** [KONSENSUS] = ≥2 meta-analisis/kohort besar searah · [PERDEBATAN] = arah disepakati, besaran diperdebatkan/heterogen · [STUDI-TUNGGAL] · [INFERENSI] = konversi/turunan saya · [RECALL] = angka lazim di literatur yang tidak berhasil dibaca ulang sesi ini (PubMed/PMC/Wiley/T&F terblokir dari lingkungan riset) — boleh dipakai sebagai default, dicek ulang sebelum [FINAL]. **[PSI-angka]** = usulan default baru.

**Asumsi konversi global [INFERENSI] — berlaku untuk semua angka di bawah:**
- **K1 (waktu):** 1 hari in-game = 1 hari kehidupan hero (waktu psikologis). Durasi klinis dipetakan 1:1 ke hari in-game (6 bulan = 180 hari in-game = 60 hari Bumi). Pemetaan 1 hari Bumi = 3 hari in-game hanya soal catch-up, bukan kompresi psikologi.
- **K2 (skala):** semua nilai tersembunyi 0–100 dibaca sebagai skala populasi: 50 = rata-rata, **15 poin = 1 SD** (mengikuti roll sifat N(50, 15)).
- **K3 (effect size → poin):** r → d = 2r/√(1−r²); **1 d = 15 poin**. OR pada probabilitas kecil ≈ pengali langsung pada p.
- **K4 (sesi ↔ peristiwa):** 1 "sesi" terapi/latihan ≈ 1 peristiwa game (misi selamat, dihibur, ritual).
- **K5 (bentuk kurva tetap):** bila DESAIN memakai konstanta per hari, saya mengkalibrasi konstanta itu; bentuk (linear/eksponensial) dibahas hanya di §8.
- **K6 (kanon menang):** angka yang berasal dari kanon (mis. gift tidak bekerja saat `st ≥ 70` ch.284) tidak diubah oleh riset; riset hanya mengisi yang (TERBUKA).

---

## 1. RINGKASAN USULAN — tabel master

Kolom "Keputusan": **A** = angka saja (bisa langsung jadi default bila pemilik setuju blok ini) · **B** = menyentuh bentuk/mekanisme → pertanyaan §8.

| # | Parameter (DESAIN §) | Default sekarang | Usulan [PSI-angka] | Bukti inti | Kekuatan | Kep. |
|---|---|---|---|---|---|---|
| 1 | Tarikan kebutuhan ke stres (§3.2) | `+0,1·(100−rest)+0,05·(100−aut)+0,05·(100−cmp)+0,05·(100−rel)` → +12,5/hari pada kebutuhan 50 (> pulih 4 → hero pasif naik terus; Temuan STATUS #2) | **`+0,08·max(0,40−rest)+0,05·max(0,40−aut)+0,03·max(0,40−cmp)+0,04·max(0,40−rel)`** — nol bila kebutuhan ≥ 40; maks 8/hari saat semua 0 | frustrasi kebutuhan ↔ afek negatif r −,30…−,46; otonomi paling kuat pada burnout ρ −,60 vs kompetensi −,30, relasi −,39 (#85, #86) | KONSENSUS (bobot relatif); ambang 40 INFERENSI | A |
| 2 | Pulih dasar (§3.2) | `4·(0,6+(100−vul)/100·0,8)·(1+0,2·xp/100)` | **tetap**; tambah: `rest < 30` → pulih ×0,6 | stres harian pulih dalam ≈1 hari (#65, #66); kurang tidur kronis → cemas SMD +0,6 (#69) | KONSENSUS arah; ×0,6 INFERENSI | A |
| 3 | Bentuk pulih: konstan vs proporsional | konstan 4/hari | (lihat §8 P-K1) | pemulihan afek/strain berbentuk eksponensial: efek liburan habis dalam 1–4 minggu (#67, #68) | KONSENSUS bentuk | **B** |
| 4 | Vacation (§3.3) | −20/hari | **−12/hari hari 1–5, −4/hari sesudahnya; `ld` tidak berubah** | efek liburan d 0,43 (≈6,5 poin), hilang d −0,38 dalam 1–4 minggu (#67, #68) | KONSENSUS | A |
| 5 | Dukungan rekan dipercaya t ≥ 9 (§3.3, §6.7) | pengali pulih ×1,4 | **×1,5** | dukungan sosial ↔ PTSD r −,25…−,40; OR 0,37 pasca-tugas; kohesi unit menyangga (#70–#73) | KONSENSUS | A |
| 6 | Misi (§3.3) | +10; beruntun ≥4 ×1,5, ≥8 ×2,5 | **tetap**; tambah pengali reaktivitas `×(1 + vul/200)` pada semua sumber stres akut | neurotisisme = reaktivitas (⅔) + paparan (⅓) (#79, #80); prevalensi PTSD naik linear dengan jumlah kontak tembak 4,5→9,3→12,7→19,3 % (#74) | KONSENSUS | **B** (pengali baru) |
| 7 | Rekan mati di sisinya (§3.3) | +20 (intim ×2) | **tetap** | menyaksikan luka/tewas OR 3,12 — faktor peri-trauma terbesar setelah menembak (#75) | KONSENSUS | A |
| 8 | `vul` (§3.2) | `0,5·E+0,3·(100−cou)+0,2·(100−C)` | **`0,45·E+0,30·(100−cou)+0,25·(100−C)`** | neurotisisme d ≈1,65 vs kesadaran rendah d ≈1,0 lintas gangguan (#78) | KONSENSUS rasio E:C; cou INFERENSI | A |
| 9 | Ambang patah (§3.2) | `90 − 0,3·vul` (60–90) | **tetap** | resilien ≈ 65 % populasi setelah peristiwa berat (#90) → mayoritas hero tidak patah pada beban normal | KONSENSUS | A |
| 10 | `ld` naik/turun (§3.2) | +1/hari `st ≥ 60`; −1/hari setelah ≥7 hari `st < 40` | **+1/hari tetap; turun −0,5/hari; lantai 10 permanen setelah `ld` pernah ≥ 50; tiap episode patah (`st ≥ ambang`) → `ld` +8 (dihitung maks 5 episode)** | exhaustion disorder: paparan ≥6 bulan, pulih 6–12 bulan, mayoritas toleransi stres tetap turun (#81); kindling: asosiasi stresor→episode menurun tiap episode, plateau ±episode 9 (#82, #83); CSR berulang 57→67→83 % (#101) | KONSENSUS arah; PERDEBATAN mekanisme kindling; angka INFERENSI | **B** (lantai & +8/episode = mekanisme baru) |
| 11 | Sudden death p (§3.5) | `0,03·(1+vul/100)·(1+ld/100)` | **tetap** (angka permainan, bukan PSI); tambah pengali waktu sejak kehilangan besar: **hari 1–7 ×2,0; 8–30 ×1,0; 31–180 ×0,5 (masih memenuhi syarat)** | OR bunuh diri setelah kehilangan: minggu 1 3,43; bulan 1 1,77; 6 bulan 1,27; n.s. sesudahnya (#84); minggu 1 SMR 19–34× duda/janda (#85a) | KONSENSUS | A (pengali) / **B** (jendela 180 hari) |
| 12 | Jendela warning ≥ 3 hari (Q2 = A) | 3 hari | **tetap 3** | tindakan biasanya menit setelah pemicu, tetapi *keadaan* (isolasi, kehilangan, beban) mendahului berhari-hari (#87, #88); gerbang 3 hari = keputusan desain, bukan konstanta empiris | KONSENSUS (keadaan mendahului) | A |
| 13 | Pelindung sudden death (§3.5) | blok keras | **tetap blok keras** | anak/tanggungan protektif OR ≈0,6–0,7 [RECALL] (#89); kohesi unit → ideasi B −0,32 (#72) — bukti "melemahkan", game memakai "mematikan" demi kejelasan pemain | KONSENSUS arah | A |
| 14 | `xp` habituasi (§1.2a) | +2 misi selamat; +4 kritis; plafon `40+0,6·cou` | **tetap** | PE: 50 % penurunan gejala ≈ sesi ke-7, dekat lantai sesi 12–15 (#91); SIT d 0,77 cemas pada 4–5 sesi (#93) | KONSENSUS | A |
| 15 | Bobot `xp` di `cou_eff` (§1.2a) | 0,3·xp | **0,4·xp** (xp 40 → +16 ≈ 1,07 SD = SIT performance-anxiety d 1,08) | #93 | KONSENSUS | A |
| 16 | Sensitisasi (§1.2a) | −3 / −6 per episode tanpa pemulihan | **−5 / −10**; jendela pemulihan **5 hari** (bukan 3) | tiap tipe trauma tambahan OR 1,19 tanpa saturasi (#95); CSR ulang 57→83 % (#101); sensitisasi rodent puncak hari 4–7 (#102) | KONSENSUS arah; PERDEBATAN besaran & jendela | A |
| 17 | Differential susceptibility (§1.2a) | `E ≥ 65` ×1,5 | **`E ≥ 58`** (≈30 % teratas = "orchid") **×1,5** | kelas sensitivitas 30/40/30 % (#97); temperamen sulit ≈1,5–2× efek lingkungan [RECALL] (#98); bukti gen tunggal lemah (#99, #100) | KONSENSUS kelas; PERDEBATAN genetik | A |
| 18 | Peluruhan `xp` saat lama tidak bertempur | tidak ada | (§8 P-K3): −1/15 hari tanpa misi, lantai 50 % puncak | return of fear 19–62 % (#92); pemulihan spontan parsial (#92a) | PERDEBATAN | **B** |
| 19 | Pemicu guilt (§3.4) | semua +15…+30 | **(a) menyaksikan rekan disintesis: guilt +8…+16 & like −15** (kelas pengkhianatan, bukan pelaku); **(b) humanoid, `A ≥ 65`: +10…+20; (c) dipaksa melanggar nilai: +10…+20 & like −10; (d) meninggalkan rekan: +15…+30** | perpetrasi → guilt/ideasi terkuat; pengkhianatan → percobaan bunuh diri OR 1,99 & hilang percaya; menyaksikan → paling sering tapi guilt terlemah (#105, #106); guilt trauma ↔ PTSD r ,38, perang r ,44 (#104) | KONSENSUS arah; PERDEBATAN besaran per tipe | A |
| 20 | Pengali sifat pada guilt (§3.4) | hanya gerbang `A ≥ 65` | **guilt × (1 + 0,3·(A−50)/15 + 0,3·(C−50)/15)**, dibatasi 0,5–1,8 | guilt-proneness ↔ A r ,30–,33, C r ,24–,37, N r ,05 (#111); shame-withdrawal ↔ N r ,23 | KONSENSUS | A |
| 21 | Survivor guilt (§6.10) | +15 (+15 bisa menolong); leader +10; tunggal +40 | **tetap** | 90 % penyintas peristiwa fatal melaporkan survivor guilt; guilt ↔ PTSD ρ ,45 (#107); leader/penyintas tunggal: TIDAK KETEMU angka | STUDI-TUNGGAL (90 %) | A |
| 22 | Peluruhan guilt | tidak meluruh | **tetap tidak meluruh** | MI stabil test-retest r ,67–,80 setahun (#106a); duka rekan tempur tidak berubah 1–25 tahun (#108); guilt sehari-hari median 24 jam hanya untuk peristiwa kecil (#109) | KONSENSUS | A |
| 23 | Penebusan (§3.4) | −20 | **tetap −20** | terapi MI d 0,4–0,8 within-person pada PTSD; skala MI sendiri bergerak lebih sedikit (#110, #110a) | PERDEBATAN | A |
| 24 | **Pengakuan** master menerima tuntutan (Q5) | belum ada | **guilt −8 dan like +15 bila ≤ 60 hari sejak luka; sesudahnya guilt 0, like +8** | RJ: keinginan balas dendam 45→9 % (d −1,17), PTSS d ≈0,3 (#112); pengakuan sosial menolong hanya bila datang dini ≤2 bulan (#113); pengakuan pelaku → maaf r ,42 (#114) | KONSENSUS (korban); guilt-spesifik INFERENSI | A |
| 25 | **Ritual duka** → guilt (Q5) | belum ada (st −6 ada) | **guilt −3**; st −6 tetap; **D duka tidak dipersingkat** | ritual → duka d 0,33–0,7 sesaat (#115, co-author Gino; Brooks 2016 DITARIK); longitudinal N=552: ritual tidak memprediksi perubahan duka β ,04–,05 n.s. (#116) | PERDEBATAN | A |
| 26 | Dihibur t ≥ 9 → guilt (§3.4, §6.7) | −5 tiap kali | **−5, maks 3× per episode luka (total −15)** | dukungan sosial efek kecil pada guilt; disapproval sosial memperburuk (#108, #117) | INFERENSI | A |
| 27 | Penarikan diri 14 hari (§3.4) | 14 hari, sosial −50 % | **tetap** (TIDAK KETEMU durasi empiris) | shame → withdraw, guilt → repair (#111) | INFERENSI | A |
| 28 | Trajektori duka — pembanding §9 | resilien 40–60 / pulih 8–20 / kronis 8–20 % | **resilien 55–70 / pulih (sedang) 15–25 / kronis 5–12 %; late-onset 0–9 % boleh muncul** | meta 67 kasus: 65,7/20,8/10,6/8,9 %; kehilangan: 64,4/14,5/12,2/0 (#90); janda/duda N=857: 64,4/20,4/8,4/6,8 (#118); Denmark N=1.735 (#119) | KONSENSUS | A |
| 29 | Duka: mendadak/di sisinya (§6.10) | D ×1,2 (menyaksikan) | **×1,25 untuk "mendadak/di sisinya"** (bukan hanya menyaksikan) | ketidaksiapan OR 3,58 untuk PGD (#121); kematian tak wajar ESr 0,12 setelah kontrol (#120); PGD 49 % setelah kehilangan tak wajar vs ~10 % (#122) | PERDEBATAN | A |
| 30 | Duka: dukungan t ≥ 9 (§6.10) | D ×0,7 | **D ×0,9; amplitudo kurva stres duka ×0,75** | dukungan sosial: efek utama pada depresi, TANPA efek penyangga pada duka (#123 [RECALL]); prediktor kuat = duka/depresi pra-kehilangan, kedekatan (#120) | PERDEBATAN | **B** (memindah efek dari D ke amplitudo) |
| 31 | Puncak kedua duka (§6.10) | kecil, hari 90–120 | **plateau kecil 0,3×I hari 90–150; tanpa lonjakan 12 bulan (hanya aksi mengenang)** | kerinduan puncak bulan 4, depresi bulan 6 (kematian wajar) (#30 lama); reaksi tanggal hanya ≤6 bulan, nihil 18 bulan (#124) | PERDEBATAN | A |
| 32 | Kematian diabaikan (§6.10) | D ×1,3, grv +10 | **tetap** | disacknowledgment sosial memprediksi duka & PTSD puluhan tahun kemudian (#108); funeral buruk r +,27 vs nyaman r −,33 (#125) | KONSENSUS arah | A |
| 33 | `vul` pada duka (§6.10) | ×(0,6+vul/100) | **tetap** | kecemasan lekat ↔ duka r ,28 (#126); kedekatan (anak ESr ,26) >> kepribadian | KONSENSUS | A |
| 34 | Continuing bonds (§6.10) | p sebut 0,3 → 0,05 | **tetap** | 20 tahun pasca: memikirkan tiap 1–2 minggu [RECALL] (#127) | KONSENSUS arah | A |
| 35 | Dipaksa (§2.2) | aut −15 | **aut −8 dan st +6** (frustrasi masuk kanal ill-being) | thwarting → burnout r ,56 vs kepuasan −,46; dalam model terkontrol kepuasan → depresi n.s. (#86); reaktansi r ,20 ≈ d 0,41 ≈ 6 poin (#128) | PERDEBATAN | **B** (memecah ke dua kanal) |
| 36 | Request ditolak / dikabulkan / memilih sendiri (§2.2) | −5 / +8 / +3 | **tetap** | kesendirian yang *dipilih* meniadakan biaya (#129) | STUDI-TUNGGAL | A |
| 37 | Decay `rel` ×(0,4+X/100) (§2.2) | pada decay saja | **tetap pada decay; JANGAN diskalakan pada gain** | introvert & ekstrovert sama-sama untung dari kontak (β ,59 kebahagiaan/jam kontak; d 1,18 bertindak ekstrovert, trait tidak memoderasi) (#130, #131) | KONSENSUS | A |
| 38 | Noise utilitas (§5.2) | ±8 | **±10** | 40–55 % varians afek intra-individu (#132) | KONSENSUS | A |
| 39 | Nilai awal kebutuhan (§2.2) | 50 | **tetap 50** (bersama #1, hero pasif kini stabil) | — | INFERENSI | A |
| 40 | Decay relasi (§4.3) | tanpa interaksi 30 hari → a/t/r −1 | (§8 P-K5) mulai setelah interval > lapisan: intim 7 · dekat 30 · teman 90 · kenalan 180 hari; lalu −1/30 hari | kedekatan teman turun 0,62/10 dalam 18 bulan pada kontak berkurang (#133); frekuensi kontak per lapisan mingguan/bulanan/tahunan (#134) | KONSENSUS bentuk | **B** |
| 41 | Lantai `f` (§4.3) | 60 % puncak | **70 % untuk ikatan yang pernah ≥ teman; ikatan < teman dan < 60 hari boleh hilang total** | dormant strong ties menyimpan 93 % trust setelah ≥3 tahun (#135); ikatan transien mati < 60 hari (#136) | STUDI-TUNGGAL (#135); KONSENSUS arah | A |
| 42 | Pelanggaran kepercayaan (§4.3) | −2 kompetensi / −6 integritas; pulih ×0,3 | **tetap**; tambah **plafon `t` = 70 % puncak sebelumnya setelah pelanggaran integritas**; pelanggaran saat `f < 5` ×2 | asimetri negatif 2,7× (#137); pelanggaran dini d 0,75 lebih merusak (#138); tipu → defisit permanen −0,37 (#139) | KONSENSUS | A (plafon: mekanisme kecil) |
| 43 | `t` awal antar hero selantai (§4.2) | 0 | **3/15** | trust game: dikirim ≈50 % endowment ke orang asing (#140) | KONSENSUS | A |
| 44 | Utang (§4.3) | +2/−2; ≥5 tak dibayar 60 hari → guilt +5 penerima | **utang penerima meluruh −1/40 hari; pada 60 hari tak dibayar: `a` pemberi → penerima −1 (bukan guilt penerima)** | kewajiban terasa turun ~30 % tiap 30 hari (#141); nilai bantuan turun di penerima, naik di pemberi (#142) | STUDI-TUNGGAL besar (#141) | **B** |
| 45 | Iri layak/tidak (§4.3) | deterministik | (§8 P-K6) probabilistik: layak → 65 % benign; tidak layak → 55 % malicious | tidak layak menggandakan iri malicious 1,43→2,56, benign turun ~10 % (#143) | KONSENSUS | **B** |
| 46 | Benign envy → latihan (§4.3) | +20 % 14 hari | **+10 %** | benign envy ↔ performa r ≈,2–,3 [RECALL] (#144) | KONSENSUS arah | A |
| 47 | Bobot `f` misi ×5 / wipe ×10 (§4.3) | ×5 / ×10 | **tetap**; wipe ×10 hanya bila hero berdistres (`st ≥ 60`) sesudahnya, else ×5 | 45 menit keterbukaan ≈ 30 % ikatan terdekat (d 0,88) (#145); fusi naik hanya pada yang berafek negatif & merefleksi (#147) | KONSENSUS | A |
| 48 | Hero minta rehat saat stres (§6.9, prinsip pemilik) | hanya goal "hidup tenang" | **pemicu baru: `st ≥ ambang − 15` & `cou_eff < 50` → request "rehat/vacation" p 0,3/hari; `cou_eff ≥ 60` → tidak meminta, memilih istirahat/hobi sendiri (§5.2 w.rest ×2 sudah ada)** — butuh string NONKANON | pemilik (APA); besaran INFERENSI dari SIT/CSR (yang berpengalaman pulih sendiri) | INFERENSI | **B** (mekanisme baru: kanon terdekat ch.244 request fasilitas; ch.235 retreat) |

---

## 2. Klaster (a) — stres, pemulihan, ambang, allostatic load, sudden death

### 2.1 Bukti baru (ringkas; angka lengkap di §10)
- **Pulih harian.** Diari NSDE/MIDUS: afek negatif akibat stresor harian umumnya kembali ke baseline dalam ≈1 hari; residu ke hari berikutnya kecil, terkonsentrasi pada individu neurotis, tetapi meramalkan penyakit kronis 10 tahun kemudian (#65, #66) [KONSENSUS arah, besaran TIDAK KETEMU]. → Misi +10 dengan pulih 4/hari tersisa 2–3 hari: wajar bila "misi" = stresor besar, bukan hassle.
- **Liburan.** Meta 7 studi: d +0,43 saat/tepat setelah liburan, d −0,38 kembali (fade-out hampir penuh) (#67); 2 minggu liburan → manfaat habis dalam 4 minggu (#68); 3 minggu (Westman & Eden) [KONSENSUS]. → vacation −20/hari (100→0 dalam 5 hari) ≈ 15× lebih kuat dari bukti pekerja; untuk prajurit R&R memang lebih besar (kurva Marlowe lama) → kompromi #4.
- **Tidur.** Meta 154 studi: kurang tidur → cemas SMD +0,57…+0,63, afek positif −0,27…−1,14; restriksi parsial kronis lebih merusak daripada satu malam total; subjektif mendatar sementara objektif terus turun (#69; Van Dongen lama) [KONSENSUS] → penalti `rest < 30` (#2), bukan hanya bonus tidur.
- **Dukungan sosial.** Meta 176 studi: dukungan ↔ PTSD r −,27 (lebih besar pada veteran) (#70); kurang dukungan r ,40 = prediktor terbesar (#71 [RECALL, rentang ,23–,40 diverifikasi lewat #71a]); dukungan pasca-tugas OR 0,37 (#73); kohesi unit horizontal → PTSD B −0,11, → ideasi bunuh diri B −0,32 (#72) [KONSENSUS] → ×1,5 masih konservatif; gerbang "tanpa ikatan hidup" didukung.
- **Dosis tempur.** PTSD naik linear dengan jumlah kontak tembak 4,5 → 9,3 → 12,7 → 19,3 % (#74); menyaksikan luka/tewas OR 3,12; menembak OR 4,32; ≥2 penugasan OR 1,24 (#75). Psikiatri garis depan: 85–90 % kembali bertugas dalam 72 jam bila dirawat dekat unit dengan ekspektasi kembali (#76); 20 tahun kemudian: PTSD 25 % (3 prinsip PIE) vs 47,9 % (tanpa) (#77) [KONSENSUS] → spike +10/+20 harus bisa hilang dalam ≈3 hari bila istirahat dekat rekan: pulih 4 + istirahat 8 (+dukungan ×1,5) = 12–18/hari ✔; tetapi 25–40 % yang "patah" perlu bekas permanen → #10.
- **Strain kronis & kindling.** Exhaustion disorder: paparan ≥6 bulan; pulih 6–12 bulan; 7–10 tahun kemudian mayoritas melapor toleransi stres tetap turun (#81). Kendler 2000 (97.515 orang-bulan): asosiasi stresor→episode depresi turun tajam tiap episode hingga ≈9 lalu plateau (#82); mekanisme sensitisasi vs otonomi diperdebatkan (#83) [KONSENSUS arah] → `ld` +1/hari (180 hari ke 60 %) cocok; turun −1/hari (6 bulan) terlalu cepat vs 6–12 bulan + bekas → #10.
- **Neurotisisme.** Meta 175 studi: N d ≈1,65 lintas gangguan (PTSD 1,23–3,56), C rendah d ≈1,0, E rendah pada PTSD/depresi d 0,66–2,13 (#78); jalur N = reaktivitas (½–⅔) + paparan (#79, #80) [KONSENSUS] → #6 (pengali reaktivitas), #8.
- **Bunuh diri (tingkat populasi, tanpa metode).** Swedia case-crossover 31.059 kasus: OR minggu 1 3,43; bulan 1 1,77; paruh tahun 1 1,27; n.s. paruh kedua; pasangan bulan 1 OR 3,64 (#84); Swiss: minggu 1 SMR 34× pria, 19× wanita (#85a); Denmark 50+: 15× tepat setelah kehilangan (#85b); mortalitas semua sebab <6 bulan RR 1,41 (#85c) [KONSENSUS]. Durasi krisis: 47,6 % dari pikiran ke tindakan ≤10 menit (#87); tanda 24 jam sebelumnya: penarikan diri, konflik, rasa beban (#88). Chu 2017 (122 sampel): TB×PB signifikan tetapi "modest" (#89a). Base rate militer AS 23–28/100.000/tahun (#89b) → p 0,03/hari adalah hazard **bersyarat** di dalam gerbang; gerbang harus cukup jarang → target §9 (0–2 / 100 hero / tahun skenario A) tetap sebagai kendali.

### 2.2 Konversi → usulan (lihat tabel master #1–#13)
- **#1** [INFERENSI]: kesetimbangan hero pasif harus ada. Dengan usulan, kebutuhan 50 → tarikan 0; kebutuhan 25 → 1,2+0,75+0,45+0,6 = 3,0/hari < pulih 4 → stabil rendah; kebutuhan 0 → 8/hari > 4 → naik (hero lapar-lelah-terisolasi memang harus naik). Bobot relatif dari ρ burnout (#86): aut > rel > cmp.
- **#4**: −12/hari × 5 hari = −60 (+ pulih dasar 20) ≈ menghapus 80 poin dalam 5 hari → cukup untuk menjawab warning (`st ≈ 60–75` → < 40 dalam 2–3 hari) tanpa "tombol reset"; bukti fade-out otomatis muncul karena beban berlanjut menaikkan `st` lagi.
- **#10** [INFERENSI dari #81, #82, #101]: −0,5/hari → 180 poin butuh 12 bulan; lantai 10 = "toleransi tetap turun"; +8/episode patah ≈ OR 1,5/episode (#101) ≈ d 0,22 ≈ 3,3 poin cou_eff lewat `−0,2·ld` … dibulatkan ke 8 `ld` agar terasa (ambang −1,6, cou_eff −1,6, laju ×1,04 per episode).
- **#11**: pengali ×2 hari 1–7 mengikuti OR 3,43/1,77 ≈ 1,9; ×0,5 hari 31–180 mengikuti 1,27/1,77 ≈ 0,7 dibulatkan ke bawah karena gerbang lain (rel < 30, tanpa ikatan) sudah menyaring.

---

## 3. Klaster (b) — habituasi/sensitisasi, `xp`

- **Kurva pemaparan.** PE PTSD: rata-rata 6,8–7,2 sesi ke penurunan gejala 50 %; ≈45 % turun pada sesi 10 (#91); fobia spesifik: satu sesi panjang ≈ multi-sesi (#91a); habituasi antar-sesi (bukan dalam sesi) yang meramalkan hasil (#91b [RECALL]) [KONSENSUS]. → +2/misi: 12–15 misi = 24–30; +4 kritis → 40 (= 3★ segar) dalam ≈12 misi ✔ (#14).
- **Return of fear** 19–62 % pada tindak lanjut (#92); pemulihan spontan hampir selalu parsial (#92a); renewal konteks r ,35 (#92b) [PERDEBATAN besaran] → P-K3 (peluruhan `xp`).
- **SIT.** Meta 37 studi N=1.837: performance anxiety r ,509 (d 1,08), state anxiety r ,373 (d 0,77), performa r ,296 (d 0,61); cemas mencapai rata-rata pada 4–7 sesi, performa tanpa dose-response (#93) [KONSENSUS] → #15 (0,4·xp).
- **Paparan sebelumnya: melindungi ATAU mensensitisasi.** Xue: trauma sebelumnya OR 1,13; ≥2 penugasan OR 1,24 (#75); building-block: tiap tipe trauma tambahan OR 1,19 (1,13–1,26) tanpa saturasi, remisi spontan OR 0,92/tipe (#95); Seery: kurva U — hasil terbaik pada ≈2–4 peristiwa buruk seumur hidup (#96) [PERDEBATAN Seery]; Solomon: tempur sebelumnya *tanpa* CSR menurunkan CSR berikutnya, CSR sebelumnya menaikkannya; intensitas tinggi memperkuat keduanya; CSR ulang 57 → 67 → 83 % (#101) [KONSENSUS arah]. → dua arah §1.2a **ditegaskan**; sensitisasi −5/−10 (#16).
- **Jendela pemulihan.** Meta SEFL 25 studi: g 1,71; puncak sensitisasi hari 4–7 (g 2,86), 15–30 hari g 2,35, >30 hari g 0,93 (#102); tidur setelah trauma-film g −0,26 intrusi (#103) [PERDEBATAN] → jendela 5 hari (#16). Tidak ada studi manusia yang menguji "≥3 hari".
- **Sensitivitas diferensial.** Kelas 30/40/30 % (#97); temperamen sulit ≈1,5–2× (#98 [RECALL]); 5-HTTLPR: Karg 2011 signifikan vs Culverhouse 2018 (N=38.802) nihil (#99, #100) → ×1,5 dibenarkan lewat temperamen, bukan gen (#17).
- **Bekas CSR** meski pulih: kelompok CSR-lalu-coping tetap lebih tinggi PTSD (#101a, N kecil) → opsi: episode panik yang pulih penuh → `xp` tidak turun **tetapi** `vul` +1 permanen (maks +5) — mekanisme baru → P-K3b.
- **Perubahan sifat** akibat trauma: N naik ≤0,3 SD (#79a [RECALL]); sampel tua: tidak berubah (#79b) [KONSENSUS kecil] → arsitektur "keadaan (`ld`, `xp`) bukan sifat" sudah benar.
- **Ketakutan berdasarkan pengalaman.** Dollard 1943: 74 % takut di aksi pertama; 64 % makin tidak takut dengan pengulangan, 14 % makin takut (#94) [STUDI-TUNGGAL] — rasio "elite panik ≥2× lebih jarang" tidak punya angka langsung; SIT d 0,6–1,1 menggeser ekor distribusi ≈½ pada daerah 10–20 % → target §9 tetap. **Rasio tembak Marshall 15–25 % tidak boleh dipakai** — datanya tidak pernah ada (#94a, #94b).

---

## 4. Klaster (c) — guilt & moral injury

- **Besaran hasil.** PMIE → PTSD r ,30; depresi ,23; suicidality ,14 (k=13, N=6.373) (#105); guilt trauma ↔ PTSD r ,38, perang ,44, longitudinal ,21 (k=157, N=30.389) (#104); MI-gejala ↔ PTSD r ,63, depresi ,59 (N=88.802); **test-retest MI r ,67–,80 sampai setahun tanpa terapi** (#106a) [KONSENSUS]. Prevalensi PMIE veteran 41,8–44,7 %: transgresi diri 10,8–14 %, oleh orang lain 25,5 %, pengkhianatan 25,5 %; MI penuh 5,9 % (#105a, #105b). Transgresi diri → ideasi OR 1,67; **pengkhianatan → percobaan bunuh diri OR 1,99** (#105a).
- **Tipe.** Perpetrasi → guilt/malu terkuat; pengkhianatan → hilang percaya & marah; menyaksikan → paling sering, guilt terlemah (#105, #106) [PERDEBATAN, tanpa pooled per tipe] → #19: menyaksikan sintesis = kelas pengkhianatan → kanal **like/percaya** (like −15), guilt lebih kecil kecuali merasa terlibat ("bisa menolong", A/C tinggi).
- **Survivor guilt.** 90 % penyintas peristiwa fatal; ρ ,45 dengan PTSD; bukan "selamat sendirian"-nya, melainkan guilt-nya yang menaikkan PTSD (#107); duka rekan tempur **tidak berubah** setelah 1–25 tahun; disapproval keluarga/komunitas → PTSD (R² ,39) & duka (#108) [KONSENSUS durabilitas] → #21, #22, #32.
- **Jalur pulih.** Terapi MI: Adaptive Disclosure d 0,79 PTSD (open trial), RCT AD-E vs PCT d 0,39, efek beda tak bertahan 3–6 bulan; skala MI sendiri sering **tidak berubah** (#110, #110a) → penebusan −20 = batas atas yang wajar (#23). Pengakuan/keadilan restoratif (10 RCT, N=1.879): keinginan balas dendam 45 → 9 % (d −1,17), 14 → 3 % (d −0,92); kepuasan korban d 0,33–0,93; PTSS d 0,31–0,34 pada 0 & 6 bulan (#112); pengakuan sosial menurunkan PTSD 6 bulan kemudian **hanya** bila peristiwa ≤2 bulan (#113); permintaan maaf ↔ maaf r ,42 (k=23, N=4.009) (#114) [KONSENSUS] → #24. Pengakuan penuh > sebagian > tidak (N=4.167) (#114a). Efek "cleansing" (Macbeth) hampir nol setelah koreksi bias — **jangan dimodelkan** (#114b [RECALL]). Ritual: d 0,33 (kenangan) / 0,7 (lab) tetapi longitudinal β n.s. (#115, #116); Brooks 2016 ditarik → #25. Menulis ekspresif: r ,075 (#110b [RECALL]) → tidak dipakai.
- **Peluruhan.** Median durasi guilt sehari-hari 24 jam, sedih 120 jam; durasi ∝ pentingnya peristiwa r ≈,57 & ruminasi (#109); fading affect bias hanya untuk memori biasa, hilang pada distres (#109a) → guilt besar tidak meluruh (#22).
- **Sifat.** GASP: guilt-NBE ↔ A ,33, C ,24 (Big Five); C ,37, A ,30 (HEXACO); N ,05; shame-withdraw ↔ N ,23 (#111) → #20. Honesty-Humility: TIDAK KETEMU (tabel tidak terakses).
- **Jawaban Q5 (LAPORAN 2026-09-26c):** pengakuan guilt −8 (≤60 hari) / 0 (sesudahnya) + like +15/+8; ritual guilt −3; penghiburan −5 maks 3×. Kekuatan: KONSENSUS untuk arah & kanal like; besaran guilt INFERENSI (tidak ada RCT dengan guilt sebagai hasil primer).

---

## 5. Klaster (d) — duka & trajektori

- **Proporsi.** Meta 54 studi/67 kasus: resilien 65,7 %, pulih 20,8 %, kronis 10,6 %, tertunda 8,9 %; subset kehilangan (n=3): 64,4/14,5/12,2/0; militer resilien tertinggi 77,5 %; desain prospektif memberi resilien 73,7 % (#90); janda/duda N=857 PG-13 2/6/11 bulan: 64,4/20,4/8,4/6,8 (#118); Denmark N=1.735 pra-kehilangan–3 tahun: rendah 45, sedang-turun 29, tinggi-turun 18, tinggi-menetap 6, late-onset 9 %; kelas menetap HR mortalitas 1,88 (#119) [KONSENSUS] → #28.
- **Kurva.** Kelas "pulih" kehilangan 36 % skor PG-13 antara bulan 2–11; depresi kasus 40 → 24 → 15 → 7 % (1/2/12/24 bulan) ≈ half-life kasus ≈ 9–10 bulan (#118, #118a) — half-life intensitas ICG/TRIG TIDAK KETEMU.
- **Mendadak/tak wajar.** PGD 49 % setelah kehilangan tak wajar (#122); setelah kontrol, tak wajar ESr 0,12, tak terduga 0,09 (#120); **ketidaksiapan subjektif** OR 3,58 (#121) [PERDEBATAN] → #29 ×1,25 pada "mendadak/di sisinya".
- **Rekan tempur.** 59,4 % veteran PTSD kehilangan rekan; 61 % menyebutnya kehilangan paling berat (di atas keluarga) (#108a); grief 21 % prajurit pasca-Irak (#108b [RECALL]); tanpa perubahan 1–25 tahun (#108) → durasi kronis pada ikatan intim rekan tempur wajar lebih tinggi dari populasi umum; intim/Sumpah ×1,5 konservatif (boleh ×2, TERBUKA).
- **Dukungan.** Tübingen: dukungan sosial efek utama pada depresi, **tanpa** efek penyangga pada duka (#123 [RECALL]); prediktor terkuat: duka pra-kehilangan ESr ,39, depresi pra ,30, anak ,26, pasangan ,19, kecemasan lekat ,17; neurotisisme n.s. (k=3) (#120) → #30.
- **Ritual.** #115/#116 (§4) → st −6 sesaat tetap; D tidak dipersingkat; funeral buruk r +,27, nyaman r −,33 (#125) → asimetri "diabaikan ×1,3" lebih kuat buktinya daripada bonus ritual (#32).
- **Tanggal peringatan.** CLOC prospektif: distres naik sekitar ulang tahun/anniversary **hanya dalam 6 bulan pertama**, nihil pada 18 bulan (#124) [PERDEBATAN] → #31.
- **Fungsi.** Gangguan fungsi 27 % pada 6 bulan, 19 % pada 3 tahun (#125a) → produktivitas −30 % di loss_mode ≈ wajar.
- **Kerentanan.** Kecemasan lekat r ,28 (k=15) (#126) → ×(0,6…1,6) wajar (#33).

---

## 6. Klaster (e) — laju kebutuhan & frustrasi

- **Kepuasan vs frustrasi.** Kepuasan ↔ afek positif r ,39–,45, ↔ afek negatif r −,30…−,33 (#85); kerja: burnout ρ aut −,60 / cmp −,30 / rel −,39; strain −,42/−,38/−,36 (#86); Bartholomew: thwarting → burnout r ,56 vs kepuasan −,46; dalam model, kepuasan → depresi **n.s.**, thwarting β ,46 (#86a); diari: thwarting → NA β ,17, kepuasan → PA β ,22 (#86a) [KONSENSUS dua kanal; PERDEBATAN rasio] → #1 (bobot), #35.
- **Reaktansi.** Meta 2025: ancaman kebebasan → marah r ,21, reaktansi gabungan r ,20 ≈ d 0,41 (#128) → "dipaksa" st +6.
- **Diari harian.** Reis 2000 (N=67×14 hari): kompetensi harian → PA B ,25, → NA −,23; relasi → PA ,15; relasi paling ditentukan "merasa dipahami" (#129a) [STUDI-TUNGGAL kanonik]. Kesendirian yang dipilih meniadakan biaya kesepian/kepuasan hari (#129) → #36.
- **Kontak & kepribadian.** Jam bersama orang → kebahagiaan β ,59, keterhubungan β 1,08; introvert = ekstrovert (#130); bertindak ekstrovert d 1,18, trait tidak memoderasi (#131) [KONSENSUS] → #37.
- **Isolasi.** Kurungan isolasi: sindrom akut "dalam beberapa hari" (#132a, deskriptif); Antartika: fenomena kuartal ketiga **tidak** terdukung meta; ayunan mood ≈8 poin/100 (#132b) [PERDEBATAN] → rel −3/hari sendiri wajar; lantai sendiri §2.2 mencegah "runtuh" pada yang berteman.
- **Tidur/lelah.** Satu malam 10 jam memulihkan ≈80–85 % lapse setelah 5 malam restriksi; sisanya butuh malam berikut (#69a); "kerja mental turun 25 % tiap 24 jam terjaga" (#69b) → istirahat +25 (dari 100) wajar; `rest` tak pernah pulih 100 % dalam sehari sudah emergen dari decay −8.
- **Lapar.** Lapar → mudah tersinggung b ,16 dalam-orang (N=64, 9.142 observasi) (#148); efek pada afek negatif terutama saat konteks aversif (#148a [RECALL]); kelaparan Minnesota: efek psikologis skala minggu (#148b) → food −20/hari = skala "kelaparan" bukan "lapar" — dibiarkan (kanon: makan harian), tarikan stres nonlinear (#1: hanya < 40).
- **Noise.** 40–55 % varians afek intra-individu (#132) → ±10 (#38).
- **Monotoni ≥5 hari −2/hari:** TIDAK KETEMU data longitudinal hari→bosan (hanya vigilance decrement 15–30 menit) → tetap [INFERENSI].

---

## 7. Klaster (f) — relasi: Hall, kepercayaan, iri, decay

- **Decay.** 18 bulan transisi sekolah→universitas (N=25, 1.291 alter): kedekatan teman −0,62/10, kerabat +0,27; hanya 48,6 % teman lapisan dalam bertahan (#133); lapisan 5/15/50/150 dikontak mingguan/bulanan/≤bulanan/tahunan (#134) [KONSENSUS bentuk] → "1 langkah/30 hari" ≈ 10× lebih cepat dari data kontak-berkurang; benar hanya untuk kontak nol → P-K5. Dormant strong ties menyimpan 93 % trust setelah ≥3 tahun (#135) → lantai 70 % (#41). Ikatan transien mati < 60 hari (#136).
- **Asimetri negatif.** Slovic: peristiwa negatif dinilai berdampak 2,7× (#137); Gottman 5:1 hanya untuk percakapan konflik (#137a); pelanggaran dini vs akhir d 0,75 (#138); tipu → defisit permanen p −0,37, pemulihan lewat janji + konsistensi ≈5 putaran (#139) [KONSENSUS] → −2/−6, ×0,3 didukung; tambah plafon 70 % & ×2 bila `f < 5` (#42).
- **Awal & pertumbuhan trust.** Meta 162 replikasi trust game: dikirim ≈50 % (#140); trust naik hingga putaran ±5 lalu plateau (#140a) → `t` awal 3/15, +1/kejadian dengan saturasi alami (#43).
- **Utang.** Natural experiment N=18.515: tiap +30 hari jarak bantuan→permintaan memangkas donasi ≈30 % (#141); nilai bantuan turun di penerima & naik di pemberi (#142) → #44.
- **Iri.** Tidak layak: malicious 1,43 → 2,56, benign 3,41 → 3,06 (η²p ,10; replikasi N=399/389) (#143); benign → target lebih tinggi → performa (#144) → P-K6, #46.
- **Pembentukan.** Fast Friends 45 menit: d 0,88, ≈30 % ikatan terdekat (#145); shared pain → kooperasi d 0,50 (#146); fusi ∝ keparahan (β ,34) + refleksi, hanya pada yang berafek negatif (#147) → #47.
- **Hormat.** Dominansi → pengaruh r ,45 lewat *persepsi* kompetensi, bukan akurasi nyata (#149) → `r` naik pada kemenangan terlihat ✔ (tanpa perubahan).

---

## 8. PERTANYAAN UNTUK PEMILIK — hanya yang menyentuh BENTUK (balas `P-Kn: A/B/…`)

- **P-K1 — bentuk pulih stres.** Bukti: pemulihan afek/strain berbentuk eksponensial (cepat saat tinggi, lambat saat rendah; efek liburan hilang dalam 1–4 minggu). **A:** tetap konstan 4/hari (sederhana, sudah ditest 99/99). **B:** proporsional `pulih = 0,13·st` (half-life ≈5 hari; st 75 → 10/hari, st 20 → 2,6/hari) dengan minimum 2/hari. Rekomendasi: **A untuk V0**, B dicatat sebagai kandidat kalibrasi 4.4 bila harness menunjukkan hero "macet" di st tinggi.
- **P-K2 — pengali reaktivitas** `×(1 + vul/200)` pada semua sumber stres akut (#6). Bukti: neurotisisme bekerja lewat reaktivitas, bukan hanya ambang. **A:** tambahkan. **B:** tidak (ambang saja). Rekomendasi: A (satu pengali, tanpa byte baru).
- **P-K3 — peluruhan `xp`** saat lama tak bertempur (−1/15 hari, lantai 50 % puncak) dan **P-K3b** bekas panik yang pulih (`vul` +1, maks +5). Bukti: return of fear 19–62 %; bekas CSR. **A:** kedua-duanya. **B:** hanya P-K3. **C:** tidak (kanon: Han "free from fear" permanen ch.10). Rekomendasi: **C untuk V0** — kanon lebih kuat dari bukti klinis parsial; buka lagi bila harness menunjukkan 1★ berpengalaman "kebal" tak wajar.
- **P-K4 — `ld`: lantai 10 permanen & +8 per episode patah** (#10). **A:** terapkan. **B:** hanya −0,5/hari, tanpa lantai/kindling. Rekomendasi: A (bukti kindling & bekas kuat; menjadikan "kematian = ujung bola salju" mekanis).
- **P-K5 — decay relasi per lapisan** (#40): mulai setelah interval > 7/30/90/180 hari (intim/dekat/teman/kenalan), lalu −1/30 hari. **A:** per lapisan. **B:** tetap 30 hari untuk semua. Rekomendasi: A (menghindari sahabat lama "dingin" dalam sebulan; 0 byte baru bila tahap dihitung dari `f`).
- **P-K6 — iri probabilistik** (#45). **A:** layak → 65 % benign; tidak layak → 55 % malicious. **B:** tetap deterministik. Rekomendasi: A (keduanya ada bersamaan pada manusia; noise sudah ada di §5.2).
- **P-K7 — dipaksa: dua kanal** (#35): aut −8 & st +6 (bukan aut −15). **A/B.** Rekomendasi: A.
- **P-K8 — utang: resentimen pemberi** (#44): pada 60 hari `a` pemberi → penerima −1, bukan guilt penerima +5. **A/B.** Rekomendasi: A.
- **P-K9 — dukungan pada duka** (#30): pindahkan dari D ×0,7 ke amplitudo stres duka ×0,75 (D ×0,9). **A/B.** Rekomendasi: A.
- **P-K10 — hero minta rehat saat stres** (#48; prinsip pemilik "yang lemah bisa minta rehat"): pemicu `st ≥ ambang−15 & cou_eff < 50`, p 0,3/hari, string NONKANON baru; hero `cou_eff ≥ 60` mengatasi sendiri (istirahat/hobi). **A:** bangun di 3.4/4.1 (TickDay/request). **B:** cukup request fasilitas ch.244 yang sudah ada. Rekomendasi: A — ini yang membuat "jendela pemain" terlihat sebagai perilaku, bukan hanya pesan sistem.
- **P-K11 — jendela sudden death 180 hari** (#11): kehilangan besar tetap memenuhi syarat sampai hari 180 dengan ×0,5 (kini ≤30). **A/B.** Rekomendasi: B untuk V0 (jaga sudden death tetap jarang; §9 target 0–2), A dicatat.

**Blok A (angka saja, #1, 2, 4, 5, 7–9, 12–17, 19–29, 31–34, 36–39, 41–43, 46, 47)** bisa disetujui sekaligus dengan satu kalimat "Blok A disetujui" (atau sebut nomor yang dikecualikan).

---

## 9. Yang TIDAK KETEMU / keterbatasan pencarian (bukan "datanya tidak ada")
- Besaran residu afek hari-berikutnya (NSDE) — hanya arah.
- Half-life intensitas duka (ICG/TRIG) per bulan; pooled OR "menyaksikan kematian" pada PGD; kehilangan berulang.
- Angka guilt pemimpin & penyintas tunggal; durasi hari penarikan diri; RCT dengan guilt/MI sebagai hasil primer; H-Humility ↔ guilt.
- Kurva "hari kerja monoton → bosan"; jarak 1 vs 3 hari istirahat pasca-misi (militer); studi manusia jendela ≥3 hari mencegah sensitisasi.
- Tabel Stouffer takut vs bulan tempur; PTSD non-CSR per tahun (Solomon 2006).
- Angka [RECALL] yang perlu dibaca ulang saat akses pulih: Brewin ,40 · Ozer ,28 · Qin OR anak · Slagt r per temperamen · Löckenhoff d · Stroebe 2005 · Toblin 2012 · Carnelley 2006 · Ernst g 0,27 · Lange & Crusius r.
Bantuan pemilik yang berguna: akses PMC/Wiley dari PC (unduh PDF Brewin 2000 tabel 1, Slagt 2016, Stroebe 2005) bila angka [RECALL] ingin dinaikkan ke [FINAL].

---

## 10. Sumber baru (#65 dst.; #1–64 di RISET_NPC_Psikologi_Manusia.md)
65. Leger, Charles & Almeida 2018 (Psychol Sci; ringkasan) — https://www.sciencedaily.com/releases/2018/04/180409161315.htm
66. NSDE, Affective Science 2020 — https://link.springer.com/article/10.1007/s42761-019-00001-w
67. de Bloom dkk. 2009 meta liburan — https://academic.oup.com/joh/article/51/1/13/7270123
68. Kühnel & Sonnentag 2011 (ringkasan APS) — https://www.psychologicalscience.org/news/minds-business/want-to-excel-at-work-take-a-vacation.html ; Westman & Eden 1997 (ringkasan) — https://qz.com/work/1660743/going-on-vacation-wont-cure-job-burnout ; Steed dkk. 2021 — https://journals.sagepub.com/doi/10.1177/0149206319864153
69. Palmer/Tomaso dkk. 2023 meta tidur–emosi — https://www.apa.org/pubs/journals/releases/bul-bul0000410.pdf ; Pilcher & Huffcutt 1996 — https://pubmed.ncbi.nlm.nih.gov/8776790/ ; Van Dongen 2003 — https://scispace.com/papers/the-cumulative-cost-of-additional-wakefulness-dose-response-3yfrcni48x
69a. Banks dkk. 2010 recovery sleep — https://fatiguemanagersnetwork.org/wp-content/uploads/Banks-et-al.2010_Neurobehavioral-Dynamics-Following-Chronic-Sleep-Restriction.pdf
69b. Belenky 1997 (doktrin) — https://isme.tamu.edu/JSCOPE97/Belenky97/Belenky97.htm
70. Zalta dkk. 2021 meta dukungan–PTSD — https://scholarworks.wmich.edu/library_pubs/44/
71. Brewin, Andrews & Valentine 2000 [RECALL] — https://www.semanticscholar.org/paper/0376fedb10b4fbf1f786f2eca716556e6d8151ff ; 71a. Trickey dkk. 2012 (postprint, memuat rentang Brewin) — https://rmeiserstedman.wordpress.com/wp-content/uploads/2016/02/trickey-et-al-2012-cpr-postprint.pdf
72. Campbell-Sills dkk. 2020/22 kohesi unit — https://www.cambridge.org/core/journals/psychological-medicine/article/abs/unit-cohesion-during-deployment-and-postdeployment-mental-health-is-cohesion-an-individual-or-unitlevel-buffer-for-combatexposed-soldiers/397805871370C237724B94B5A75ED073
73. Xue dkk. 2015 meta faktor risiko PTSD tempur — https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0120270
74. Hoge dkk. 2004 NEJM — https://onceawarrior.com/wp-content/uploads/2012/01/NEJM20004Article.pdf
75. = #73 (menyaksikan OR 3,12; menembak 4,32)
76. Combat stress reaction, forward psychiatry RTD — https://en.wikipedia.org/wiki/Combat_stress_reaction
77. Solomon dkk. 2005 AJP 20 tahun PIE — https://psychiatryonline.org/doi/full/10.1176/appi.ajp.162.12.2309
78. Kotov dkk. 2010 meta kepribadian–gangguan — https://static1.squarespace.com/static/5692fe4a4bf1182ee6045530/t/5820d216e58c62bd0992476a/1478545945761/KotovGamezSchmidtWatson%282010%29.pdf.pdf
79. Bolger & Schilling 1991; 80. Bolger & Zuckerman 1995 [RECALL]; 79a. Löckenhoff 2009 [RECALL]; 79b. Ogle, Rubin & Siegler 2014 — https://dukespace.lib.duke.edu/server/api/core/bitstreams/35d2ae2f-f4b7-424d-b3af-d34abcd23632/content
81. Exhaustion disorder (kriteria, prognosis) — https://en.wikipedia.org/wiki/Exhaustion_disorder
82. Kendler, Thornton & Gardner 2000 AJP (PMID 10910786); 83. Monroe & Harkness 2005; Kendler 2001 — https://www.cambridge.org/core/journals/psychological-medicine/article/depressive-vulnerability-stressful-life-events-and-episode-onset-of-major-depression-a-longitudinal-model/338216708F5F115571760CC2C174884C
84. Rostila dkk. 2016 PLOS One bunuh diri pasca-kehilangan — https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0164274
85. Stanley, Schutte & Phillips 2021 meta kebutuhan — https://rune.une.edu.au/server/api/core/bitstreams/b3714725-52c2-49fa-80ac-f9dae8e67cc7/content
85a. Ajdacic-Gross dkk. 2008 — https://www.cambridge.org/core/journals/psychological-medicine/article/abs/suicide-after-bereavement-an-overlooked-problem/3BE20DB2A61340E6B820A2EC69A0382D ; 85b. Erlangsen dkk. 2004 — https://academic.oup.com/ageing/article-abstract/33/4/378/18189 ; 85c. Moon dkk. 2011 meta — https://journals.plos.org/plosone/article/file?type=printable&id=10.1371/journal.pone.0023465
86. Van den Broeck dkk. 2016 meta kerja — https://selfdeterminationtheory.org/wp-content/uploads/2024/01/2016_VandenbroeckFerrisEtAl_a-review-of-self-determination-theory.pdf ; 86a. Bartholomew dkk. 2011 PSPB — https://selfdeterminationtheory.org/SDT/documents/2011_BartholomewNtoumanisetal_PSPB.pdf ; Howard, Slemp & Wang 2024 — https://selfdeterminationtheory.org/wp-content/uploads/2024/02/2024_HowardSlempWang_Meta.pdf ; Slemp dkk. 2024 JPSP — https://selfdeterminationtheory.org/wp-content/uploads/2024/02/2024_SlempFieldRyanEtAl_Interpersonal.pdf
87. Deisenhammer dkk. 2009 — https://www.saferhomescollaborative.org/wp-content/uploads/2019/06/Deisenhammer-2009-Duration-of-suicidal-process61420.pdf ; Simon 2005 (Harvard Means Matter) — https://hsph.harvard.edu/research/means-matter/means-matter-basics/duration-of-suicidal-crises
88. PECARN 24-jam warning signs — https://pecarn.org/pecarn_news/24-hour-warning-sign-for-suicide-attemp/
89. Qin, Agerbo & Mortensen 2003 [RECALL OR] — https://psychiatryonline.org/doi/10.1176/appi.ajp.160.4.765 ; 89a. Chu dkk. 2017 — https://scispace.com/papers/the-interpersonal-theory-of-suicide-a-systematic-review-and-1vmz2tr0wy ; 89b. DoD CY2024 — https://www.dspo.mil/Portals/113/2026_CY/documents/DSPO_ReportonSuicide_CY24_20260317_508c.pdf
90. Galatzer-Levy, Huang & Bonanno 2018 — https://www.tc.columbia.edu/media/centers-amp-labs/lte-lab/peered-review-journals/2018_Galtzaer_Levy-Huang--Bonanno_REVIEW.pdf
91. van Minnen & Foa 2006 — https://www.med.upenn.edu/ctsa/assets/user-content/documents/VanMinnenFoa_DurationExposure_2006.pdf ; 91a. meta satu-sesi vs multi-sesi 2022 — https://www.sciencedirect.com/science/article/abs/pii/S0005796722001747 ; 91b. Rupp dkk. 2017 [RECALL]
92. Return of fear 19–62 % (BRT 2016) — https://www.sciencedirect.com/science/article/abs/pii/S0005791616300908 ; 92a. spontaneous recovery review 2026 — https://www.frontiersin.org/journals/behavioral-neuroscience/articles/10.3389/fnbeh.2026.1820847/full ; 92b. renewal meta 2024 — https://www.sciencedirect.com/science/article/pii/S0149763424000757
93. Saunders, Driskell, Hall & Salas 1996 (DTIC) — https://apps.dtic.mil/sti/pdfs/ADA309082.pdf
94. Dollard 1943 (ringkasan) — https://time.com/archive/6789396/army-navy-whos-afraid/ ; 94a. Spiller 1988 — https://gwern.net/doc/history/s-l-a-marshall/1988-spiller.pdf ; 94b. Engen 2011 — https://queensu.scholaris.ca/items/edd09d8c-78a6-4a39-9a52-0f001aa839d6
95. Kolassa dkk. 2010 building block — https://kops.uni-konstanz.de/server/api/core/bitstreams/b74a13e1-b8a9-492b-acb6-774ce694bd73/content
96. Seery, Holman & Silver 2010 — https://escholarship.org/content/qt4b6787gk/qt4b6787gk.pdf
97. Lionetti dkk. 2018 — https://www.nature.com/articles/s41398-017-0090-6 ; 98. Slagt dkk. 2016 [RECALL]; 99. Karg dkk. 2011 — https://moffittcaspi.trinity.duke.edu/sites/moffittcaspi.trinity.duke.edu/files/file-attachments/Karg_AGP_2011.pdf ; 100. Culverhouse dkk. 2018 — https://www.nature.com/articles/mp201744
101. Solomon 1987 — https://www.cambridge.org/core/journals/psychological-medicine/article/abs/exposure-to-recurrent-combat-stress-combat-stress-reactions-among-israeli-soldiers-in-the-lebanon-war/3D2DFD6D49B860A2B0D90F9ABB31CBE1 ; ulasan Front Psychiatry 2020 (angka 57/67/83 %, PTSD 54/47/38/27 %) — https://www.frontiersin.org/journals/psychiatry/articles/10.3389/fpsyt.2020.589391/full ; 101a. Solomon 1990 — https://www.sciencedirect.com/science/article/abs/pii/088761859090005T
102. Meta SEFL 2026 — https://www.mdpi.com/2076-3425/16/7/691 ; 103. tidur pasca-trauma-film meta 2023 — https://academic.oup.com/sleep/article/46/2/zsac280/6844013 ; Porcheret 2019 — https://www.nature.com/articles/s41398-019-0403-z
104. Kip dkk. 2022 meta guilt–PTSD — https://www.cambridge.org/core/journals/psychological-medicine/article/relationship-of-traumarelated-guilt-with-ptsd-symptoms-in-adult-trauma-survivors-a-metaanalysis/D0C6E223BA3C0B04A81DB818767EDE25
105. Williamson, Stevelink & Greenberg 2018 meta — https://www.cambridge.org/core/journals/the-british-journal-of-psychiatry/article/occupational-moral-injury-and-mental-health-systematic-review-and-metaanalysis/5DC1F4B8FFF97DA27940940FE87CB527 ; 105a. Wisco 2017 via VA RQ — https://www.ptsd.va.gov/publications/rq_docs/V33N1.pdf ; 105b. NHRVS 2023/2025 — https://www.sciencedirect.com/science/article/pii/S0022395625004297
106. McEwen, Alisic & Jobson 2021 (abstrak) — https://research.monash.edu/en/publications/moral-injury-and-mental-health-a-systematic-review-and-meta-analy/ ; 106a. meta ukuran MI (VA) — https://www.ptsd.va.gov/professional/articles/article-pdf/id1644723.pdf
107. Murray dkk. (Oxford) survivor guilt — https://ora.ox.ac.uk/objects/uuid:f54a4e52-3987-4fb1-8bb6-043f76dbef1a/files/mb20086d515b0dcb9bc77123964ddab22 ; Murray 2021 — https://www.cambridge.org/core/journals/the-cognitive-behaviour-therapist/article/survivor-guilt-a-cognitive-approach/19F993611E0BDE9C219F16BE0E6BD622
108. Yehene, Martin & Goldzweig 2025 — https://journals.sagepub.com/doi/10.1177/00302228221113616 ; 108a. Simon dkk. 2018 — https://reachfamilies.umn.edu/sites/default/files/rdoc/Simon_2018.pdf ; 108b. Toblin dkk. 2012 [RECALL]
109. Verduyn & Lavrijsen 2015 — https://ppw.kuleuven.be/okp/_pdf/Verduyn2015WELLA.pdf ; 109a. fading affect bias (Ritchie/Gibbons 2011; Walker 2003 [RECALL])
110. Litz dkk. 2024 AD-E RCT — https://sites.bu.edu/litzlab/files/2024/07/Litz-et-al-2024-ADE.pdf ; 110a. = #106a (skala MI sering tak berubah); 110b. Frattaroli 2006 [RECALL]
111. Cohen, Wolf, Panter & Insko 2011 GASP — https://www.trieft.org/wp-content/uploads/2015/01/Guilt_or_Shame_Panter.pdf
112. Strang dkk. 2013 Campbell RJ — https://www.crim.cam.ac.uk/system/files/documents/rj_strang_review.pdf
113. van der Velden dkk. 2019 — https://www.sciencedirect.com/science/article/abs/pii/S0165178119305906
114. Fehr, Gelfand & Nag 2010 — https://ggsc.berkeley.edu/images/uploads/Fehr_et_al_2010_The_road_to_forgiveness-_A_meta-analytic_synthesis_of_its_situational_and_dispositional_correlates.pdf ; 114a. Peer, Acquisti & Shalvi 2014 — https://www.sciencedaily.com/releases/2014/01/140123075711.htm ; 114b. Siev & Zuckerman 2018 [RECALL]
115. Norton & Gino 2014 — https://www.hbs.edu/ris/Publication%20Files/norton%20gino%202014_e44eb177-f8f4-4f0d-a458-625c1268b391.pdf
116. Mitima-Verloop, Mooren & Boelen 2021 (Death Studies, UU repository)
117. Cândea & Szentagotai-Tătar 2018 — https://pubmed.ncbi.nlm.nih.gov/30075356/
118. Lundorff, Bonanno dkk. 2020 — https://www.tc.columbia.edu/media/centers-amp-labs/lte-lab/monographs-and-journalism/2020_Lundorf_Bonanno-et-al_gender-and-grief-trajectories.pdf ; 118a. Zisook & Shuchter via Psychiatric Times — https://www.psychiatrictimes.com/view/bereavement-related-depression
119. Nielsen dkk. 2019 / Front Public Health 2025 — https://www.frontiersin.org/journals/public-health/articles/10.3389/fpubh.2025.1619730/full
120. Stelzer dkk. 2023 meta faktor risiko PG — https://www.sciencedirect.com/science/article/pii/S0272735823001332
121. Front Psychiatry 2022 (N=811) — https://www.frontiersin.org/journals/psychiatry/articles/10.3389/fpsyt.2022.853698/full
122. Djelantik dkk. 2020 — https://www.sciencedirect.com/science/article/abs/pii/S0165032719315083
123. Stroebe dkk. 2005 [RECALL]; Burke & Neimeyer 2013 [RECALL]
124. Carr, Sonnega, Nesse & House 2014 — https://academic.oup.com/psychsocgerontology/article/69B/1/113/542336
125. Front Psychiatry 2022 (N=232, funeral) — https://www.frontiersin.org/journals/psychiatry/articles/10.3389/fpsyt.2022.878818/full ; 125a. Front Psychiatry 2020 (N=1.622) — https://www.frontiersin.org/journals/psychiatry/articles/10.3389/fpsyt.2020.537674/full
126. meta lekat–duka 2023 — https://www.sciencedirect.com/science/article/pii/S0191886923002386
127. Carnelley dkk. 2006 [RECALL]
128. meta reaktansi 2025 HCR — https://academic.oup.com/hcr/article/52/1/38/8178818 ; Rains 2013 via Front Comm 2019 — https://www.frontiersin.org/journals/communication/articles/10.3389/fcomm.2019.00056/full ; Deci, Koestner & Ryan 1999 — https://home.ubalt.edu/tmitch/642/articles%20syllabus/Deci%20Koestner%20Ryan%20meta%20IM%20psy%20bull%2099.pdf
129. Sci Rep 2023 kesendirian — https://www.nature.com/articles/s41598-023-44507-7 ; 129a. Reis dkk. 2000 — https://qualaxia.org/wp-content/uploads/reis-etal-2000.pdf
130. Sun, Harris & Vazire 2020 — https://jessiesun.me/publication/sun-2020b/sun-2020b.pdf
131. Collabra 2021 enacted extraversion — https://online.ucpress.edu/collabra/article/7/1/29931/119109
132. Scott dkk. 2020 (MIDUS) — https://midus.wisc.edu/wp-content/uploads/2024/04/1894.pdf ; 132a. Haney 2018 — https://unlocktheboxcampaign.org/wp-content/uploads/2021/02/Haney-ThePsychologicalEffectsofSolitaryConfinement-ASystematicCritique2018.pdf ; 132b. meta Antartika (Polar Record) — https://www.cambridge.org/core/journals/polar-record/article/abs/timedependent-mood-fluctuations-in-antarctic-personnel-a-metaanalysis/C821DE633ED36CEEC2FD8FFE96024E9F
133. Roberts & Dunbar 2015 — https://link.springer.com/article/10.1007/s12110-015-9242-7
134. Hill & Dunbar 2003 — https://www.bebr.ufl.edu/sites/default/files/Social%20network%20size%20in%20humans.pdf ; Sutcliffe dkk. 2012 (abstrak)
135. Levin, Walter & Murnighan 2011 — https://business.gwu.edu/sites/g/files/zaxdzs5326/files/15_FP.SP_Walter.J_15levin_2011a.pdf
136. Bhattacharya/Dunbar dkk. 2023 R Soc Open Sci (ikatan transien); Burt 2000 (abstrak) — https://www.sciencedirect.com/science/article/abs/pii/S0378873399000155
137. Slovic 1993 — https://scispace.com/pdf/perceived-risk-trust-and-democracy-54i9b1xvnt.pdf ; 137a. Gottman 1993 — https://www.johngottman.net/wp-content/uploads/2011/05/A-theory-of-marital-dissolution-and-stability.pdf
138. Lount dkk. 2008 — https://www-2.rotman.utoronto.ca/facbios/file/Wrong_Foot_2008_PSPB.pdf
139. Schweitzer, Hershey & Bradlow 2006 — https://faculty.wharton.upenn.edu/wp-content/uploads/2014/06/Promises-and-Lies.pdf
140. Johnson & Mislin 2011 — https://www.sciencedirect.com/science/article/abs/pii/S0167487011000869 ; 140a. Cochard dkk. 2004 (abstrak)
141. Chuan, Kessler & Milkman 2018 PNAS — https://faculty.wharton.upenn.edu/wp-content/uploads/2017/10/2018_PNAS.pdf
142. Flynn 2003 — https://www.sciencedirect.com/science/article/abs/pii/S074959780200523X
143. replikasi van de Ven 2012, Front Psychol 2020 — doi 10.3389/fpsyg.2020.513495
144. Lange & Crusius 2015 — https://journals.sagepub.com/doi/abs/10.1177/0146167214564959
145. Aron dkk. 1997 — https://psychodramaaustralia.edu.au/sites/default/files/falling_in_love-aron.pdf
146. Qi dkk. 2020 (replikasi Bastian 2014)
147. Jong, Whitehouse, Kavanagh & Lane 2015 — https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0145611
148. Swami dkk. 2022 PLOS One — https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0269629 ; 148a. MacCormack & Lindquist 2019 [RECALL]; 148b. Minnesota Starvation (ulasan) — https://www.researchgate.net/publication/324507398
149. Anderson & Kilduff 2009 — https://web-docs.stern.nyu.edu/pa/traitdominance_kilduff.pdf
