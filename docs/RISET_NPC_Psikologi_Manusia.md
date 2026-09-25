# RISET NPC — ILMU MANUSIA UNTUK SIMULASI HERO YANG TERASA HIDUP

Terakhir diperbarui: 25 September 2026, 02:36 WIB

Tujuan: mengisi celah yang kanon PMU tidak jelaskan (angka, laju, proporsi, bentuk kurva) dengan psikologi/sosiologi/antropologi yang terverifikasi; setiap temuan dicocokkan ke bukti kanon di `claude/RISET_NPC_Bukti_Perilaku_Kanon.md` sebelum dipakai di `claude/DESAIN_AI_NPC_V0.md`. Bukan mekanik game. 55 sumber di bagian akhir (§1–§7); §8 menambah 9 sumber baru (56–64).


Ruang lingkup: psikologi, sosiologi, antropologi — bukan mekanik game. Tujuan: bahan mentah untuk mensimulasikan hero-NPC dalam game manajemen dengan permadeath, sehingga kematian hero terasa sebagai kehilangan bagi pemain.

Kode status tiap klaim:
- **[KONSENSUS]** — didukung banyak studi/meta-analisis, jarang dibantah.
- **[DIBANTAH]** — populer tapi bukti empirisnya lemah atau menolak.
- **[PERDEBATAN]** — masih diperdebatkan atau bukti campuran.
- **[INFERENSI]** — penarikan saya dari literatur, bukan temuan langsung; perlakukan sebagai hipotesis desain.

---

## 1. Struktur Kepribadian

### Ringkasan
Model dominan adalah **Big Five** (Openness, Conscientiousness, Extraversion, Agreeableness, Neuroticism), masing-masing terbagi ke facet yang lebih spesifik (mis. dalam NEO-PI-R: 6 facet per trait — Neuroticism → anxiety, angry hostility, depression, self-consciousness, impulsiveness, vulnerability). **[KONSENSUS]** bahwa lima faktor ini muncul konsisten lintas budaya, meski struktur facet dan jumlah faktor "ideal" masih **[PERDEBATAN]**. **HEXACO** (Ashton & Lee) menambahkan faktor keenam, **Honesty–Humility** (ketulusan, keadilan, tidak tamak, rendah hati), yang secara empiris memprediksi perilaku eksploitatif, korupsi, dan pengkhianatan lebih baik daripada Agreeableness Big Five; HEXACO juga memindahkan komponen "marah/pendendam" dari Neuroticism ke (low) Agreeableness dan "sentimental/takut" ke Emotionality. Temperamen (mis. model Rothbart/Cloninger: novelty seeking, harm avoidance, reward dependence) adalah lapisan lebih dasar dan biologis; dalam praktik, sebagian besar variansnya tumpang-tindih dengan Big Five.

Soal **stabilitas vs perubahan**: meta-analisis Bleidorn dkk. (2022, 189 sampel, ~178.000 orang) menunjukkan stabilitas rank-order tinggi tetapi tidak sempurna (koefisien ~0,6–0,7 per dekade pada orang dewasa, lebih rendah pada remaja), dengan perubahan mean-level yang perlahan dan searah ("maturity principle": Conscientiousness dan Agreeableness naik, Neuroticism turun seiring usia). Meta-analisis Bühler dkk. (2024, 44 studi, 121.187 peserta, 519 effect size) menemukan **efek peristiwa hidup terhadap sifat kepribadian nyata tetapi kecil**; peristiwa domain kerja (lulus, pekerjaan pertama) lebih konsisten efeknya daripada domain relasi; self-esteem dan kepuasan hidup lebih responsif daripada Big Five. Specht dkk. (2011) menemukan peristiwa spesifik memberi efek spesifik (mis. kematian pasangan → sebagian orang turun Extraversion). Jadi: **peristiwa besar mengubah suasana/kondisi cukup kuat, tetapi mengubah sifat dasar hanya sedikit dan lambat.**

### Untuk simulasi
- **Variabel sifat**: 5 (Big Five) atau 6 (HEXACO) dimensi, nilai 0–100, distribusi normal (mean 50, SD ~15–20). Facet opsional 2–3 per trait yang relevan mekanik (mis. Neuroticism → anxiety, anger, vulnerability; Extraversion → sociability, assertiveness; Conscientiousness → discipline, orderliness).
- **Honesty–Humility** sebagai variabel terpisah untuk peluang pengkhianatan/korupsi/mencuri jatah — ini nilai tambah HEXACO yang paling berguna dibanding Big Five.
- **Laju perubahan sifat**: sangat lambat. Pedoman dari literatur: peristiwa besar → geser sifat 0,1–0,3 SD (≈2–5 poin pada skala 0–100), dan sebagian orang malah tidak bergeser sama sekali. Yang bergeser cepat adalah **state** (mood, stres, keyakinan) bukan **trait**.
- **Variasi antar individu**: normal ± 2 SD mencakup ~95 % populasi; kalau SD = 15 pada skala 0–100, rentang 20–80 adalah "wajar", ekstrem <10 atau >90 harus langka (<2,5 %).
- **[INFERENSI]** Trait sebagai *prior* yang membentuk laju reaksi state: Neuroticism tinggi → stres naik lebih cepat, turun lebih lambat; Extraversion tinggi → kebutuhan sosial tumbuh lebih cepat; Conscientiousness tinggi → toleransi kebosanan lebih tinggi pada tugas rutin.

### Sumber
Daftar sumber no. 1, 2, 3, 4, 5.

---

## 2. Kebutuhan & Motivasi

### Ringkasan
**Self-Determination Theory (SDT; Ryan & Deci)** **[KONSENSUS]** adalah kerangka kebutuhan psikologis yang paling didukung empiris saat ini: tiga kebutuhan dasar — **autonomy** (merasa memilih sendiri), **competence** (merasa mampu/berkembang), **relatedness** (merasa terhubung dan berarti bagi orang lain). Kepuasan ketiganya memprediksi vitalitas, motivasi intrinsik, dan kesehatan mental; frustrasi salah satunya (bukan hanya ketiadaan) memprediksi burnout, kepatuhan semu, dan perilaku defensif. SDT juga menjelaskan bahwa hadiah eksternal yang mengontrol dapat **mengikis** motivasi intrinsik (undermining effect).

**Maslow** (fisiologis → keamanan → cinta → penghargaan → aktualisasi) **[DIBANTAH sebagai hierarki kaku]**: ulasan Wahba & Bridwell (1976) menemukan sedikit dukungan untuk urutan bertingkat; studi Tay & Diener (2011, 123 negara, >60.000 responden) menemukan kebutuhan-kebutuhan itu memang **universal** dan masing-masing berkontribusi ke kesejahteraan **secara independen**, tetapi orang bisa memenuhi kebutuhan "atas" (dihormati, punya makna) sambil kebutuhan dasar belum terpenuhi. Kebutuhan akan **status/pengakuan** kuat dan lintas budaya (Anderson dkk. 2015 menyimpulkan status adalah kebutuhan fundamental). **Kebosanan** menurut Eastwood dkk. (2012) adalah keadaan "ingin tetapi tidak bisa terlibat dalam aktivitas yang memuaskan" — bukan sekadar kurang stimulasi, melainkan gagal mengarahkan atensi ke sesuatu yang bermakna; orang dengan trait boredom-proneness tinggi lebih cepat bosan pada tugas berulang. **Burnout** (Maslach) punya tiga dimensi: **kelelahan emosional**, **sinisme/depersonalisasi**, dan **rasa tidak efektif**; model Job Demands–Resources (Demerouti, Bakker) menunjukkan burnout muncul ketika tuntutan tinggi tanpa sumber daya (kontrol, dukungan, penghargaan, keadilan) — jadi burnout adalah fenomena relasi orang–situasi, bukan kelemahan individu.

### Untuk simulasi
- **Tiga meter kebutuhan (SDT)**: Autonomy, Competence, Relatedness, masing-masing 0–100 dengan laju decay per hari. Kepuasan: autonomy naik saat NPC memilih tugas/menolak; competence naik saat berhasil pada tugas yang menantang (bukan yang terlalu mudah); relatedness naik saat interaksi berkualitas dengan orang yang disukai.
- **Frustrasi ≠ ketiadaan**: dipaksa (autonomy frustration) menghasilkan efek negatif lebih besar daripada sekadar tidak ada pilihan. Beri penalti ekstra saat pemain memaksa NPC melakukan yang ia tolak.
- **Undermining effect [PERDEBATAN pada magnitud]**: hadiah eksternal yang bersifat mengontrol untuk aktivitas yang tadinya disukai menurunkan motivasi intrinsik jangka panjang.
- **Kebutuhan tidak hierarkis**: NPC yang lapar masih bisa tersinggung harga dirinya; NPC yang aman-nyaman bisa gelisah karena tak dihormati. Jangan blokir kebutuhan atas hanya karena bawah belum penuh.
- **Status**: variabel relatif (peringkat dalam kelompok), bukan absolut. Penurunan peringkat lebih menyakitkan daripada peringkat rendah yang stabil (lihat §4).
- **Kebosanan**: naik pada tugas berulang tanpa variasi; laju tergantung Openness/sensation seeking; turun dengan variasi tugas, hobi, tantangan baru.
- **Burnout** sebagai tiga sub-meter: kelelahan (naik dari beban kerja, pulih dengan istirahat), sinisme (naik saat merasa usaha tidak dihargai/tidak adil, pulih lambat), inefficacy (naik saat berulang gagal). Sinisme adalah yang paling sulit pulih dan paling mengancam loyalitas.

### Sumber
Daftar sumber no. 6, 7, 8, 9, 10.

---

## 3. Ikatan Sosial yang Kompleks

### Ringkasan
Pertemanan terbentuk lewat beberapa mekanisme yang terdokumentasi kuat: **propinquity** (Festinger, Schachter & Back 1950 — di asrama Westgate, peluang berteman turun tajam tiap penambahan jarak pintu; tetangga sebelah ~41 %, dua pintu ~22 %, ujung lorong ~10 %); **homophily** (McPherson dkk. 2001 — kesamaan usia, nilai, status, aktivitas memprediksi ikatan); **reciprocity** dan **self-disclosure bertahap** (Altman & Taylor, social penetration theory — dari topik dangkal ke pribadi; membuka diri terlalu cepat justru dinilai aneh); dan **shared adversity** — riset identity fusion (Whitehouse dkk. 2017; Swann dkk.) menunjukkan pengalaman **dysphoric** (menyakitkan) yang dialami bersama menghasilkan ikatan "seperti keluarga" yang lebih kuat daripada pengalaman menyenangkan bersama, sampai rela berkorban nyawa untuk kelompok; pada pejuang Libya, 45 % frontline fighters lebih terfusi dengan batalionnya daripada dengan keluarga sendiri. Namun Bautista dkk. (2026) menemukan efek fusi dari pengalaman dysphoric **meluruh** kalau tidak dipelihara — "not forever".

Soal **waktu**: Hall (2019) memperkirakan ~50 jam kebersamaan untuk menjadi teman biasa, ~90 jam untuk teman, >200 jam untuk teman dekat; kualitas waktu (ngobrol, bercanda, aktivitas bersama) lebih berpengaruh daripada sekadar bekerja berdampingan. **Dunbar layers** **[KONSENSUS dengan catatan]**: ~5 (intim), ~15 (sahabat/simpati), ~50 (teman baik), ~150 (kenalan bermakna), rasio antar-lapisan ≈3; data telepon (Mac Carron, Kaski & Dunbar 2016) menghasilkan lapisan kumulatif 4,1 / 11 / 30 / 129 — sedikit lebih kecil, rasio ~3,3. Kritik Lindenfors dkk. (2021) menyatakan angka 150 dari otak primata punya interval keyakinan sangat lebar (2–520), jadi "150" bukan konstanta keras, tetapi **struktur berlapis dan alokasi waktu** (≈40 % waktu sosial untuk 5 orang terdekat, ≈60 % untuk 15) cukup konsisten. **Variasi**: sebagian orang menaruh porsi lebih besar ke lapisan dalam (sedikit teman, sangat dekat), yang lain menyebar (banyak kenalan, tak ada yang sangat dekat) — Dunbar & Spoors dan studi 2025 (PMC11896044) menyebut ini perbedaan alokasi energi sosial yang sebagian dijelaskan Extraversion dan gender.

**Rivalitas vs permusuhan**: kompetisi sehat memicu **benign envy** (van de Ven dkk. 2009, 2011 — "aku ingin sepertinya", mendorong usaha diri; muncul saat keunggulan lawan dinilai **layak/deserved** dan bisa dikejar), sedangkan **malicious envy** ("aku ingin dia jatuh") muncul saat keunggulan dinilai tidak layak atau mustahil dikejar; **admiration** muncul saat jaraknya terlalu jauh sehingga tak relevan sebagai pembanding — dan admiration justru **tidak** memotivasi usaha sebesar benign envy. **Hormat/otoritas & mentor–murid**: Cheng, Tracy & Henrich (2013) — dua jalur ke pengaruh: **prestige** (dihormati karena kompetensi; orang mendekat, meniru) dan **dominance** (ditakuti karena mampu memaksa; orang menghindar tapi patuh); keduanya "berhasil" mendapat pengaruh, tapi hanya prestige yang menghasilkan kesukaan. **Utang budi**: norma reciprocity (Gouldner 1960) universal; gratitude (hangat, ingin membalas sukarela) berbeda dari indebtedness (tertekan, harus membalas) — bantuan yang disertai tuntutan balas menghasilkan indebtedness, bukan loyalitas. **Pengkhianatan & pemulihan**: Kim, Ferrin, Cooper & Dirks (2004) menemukan pelanggaran **integritas** (bohong, curang) jauh lebih sulit dipulihkan daripada pelanggaran **kompetensi** (gagal karena tak mampu); untuk pelanggaran kompetensi, **minta maaf** lebih efektif; untuk pelanggaran integritas yang belum terbukti, **menyangkal** lebih efektif — dan sekali integritas terbukti dilanggar, kepercayaan hampir tidak kembali ke baseline. **Penyendiri**: variasi ini normal — introversi (Big Five) berarti kebutuhan stimulasi sosial lebih rendah, bukan ketidakmampuan; gaya lekat **avoidant** (Hazan & Shaver 1987: ~25 % dewasa avoidant, ~19 % anxious, ~56 % secure) berarti menjaga jarak emosional sebagai strategi, tetap ingin diterima tapi tak menunjukkan. Keduanya membuat sebagian NPC memang **tidak** berkelompok dan tetap sehat.

### Untuk simulasi
- **Model relasi berarah per pasangan** (A→B bisa ≠ B→A): affinity (−100..+100), trust (0–100), familiarity/jam bersama (akumulatif), debt (siapa berutang budi), respect (untuk hierarki), envy_type (none/benign/malicious).
- **Pembentukan**: peluang interaksi ∝ propinquity (satu barak/ruang, satu regu tugas) × homophily (kesamaan sifat/asal/nilai, bonus kecil, jangan dominan); familiarity naik per jam bersama, dengan bobot: kerja berdampingan ×1, ngobrol/santai ×2–3, adversity bersama (pertempuran, kekalahan, kelaparan) ×5–10.
- **Ambang tahap** (dari Hall): kenalan <50 jam, teman biasa 50–90, teman ~90–200, sahabat >200 jam — sesuaikan skala waktu game, tapi jaga rasio.
- **Kapasitas berlapis**: tiap NPC punya slot ~5 intim / ~15 dekat; kalau pemain menambah orang baru yang cepat dekat, seseorang di lapisan dalam terdorong keluar (Dunbar: waktu sosial adalah anggaran tetap). Beri variasi individu: `social_budget_focus` — sebagian NPC menaruh 60–70 % ke 2–3 orang, sebagian menyebar tipis.
- **Fusi karena penderitaan bersama**: bonus besar tetapi **meluruh** kalau tidak ada pengalaman/ritual bersama berikutnya (Bautista 2026).
- **Rivalitas**: bila selisih kompetensi kecil + keunggulan dinilai layak → benign envy → NPC berusaha lebih (bonus latihan); bila selisih dinilai tak adil (favoritisme pemain) → malicious envy → sabotase pasif, gosip, turun affinity. Selisih sangat besar → admiration/hormat, tanpa dorongan.
- **Otoritas**: NPC dengan kompetensi tinggi + Agreeableness/Honesty tinggi → prestige (diikuti dengan senang); kompetensi/kekuatan tinggi + Agreeableness rendah → dominance (dipatuhi, dihindari, affinity turun). Mentor–murid: hubungan asimetris yang menaikkan competence murid dan relatedness keduanya.
- **Utang budi**: `debt` naik saat ditolong; menolong balik menurunkannya; utang lama yang tak dibayar menaikkan rasa bersalah pada yang berutang. Pertolongan yang "ditagih" mengubah gratitude menjadi indebtedness (affinity tidak naik).
- **Pengkhianatan**: dua jenis. Kompetensi (gagal melindungi) → trust turun sedang, pulih dengan maaf + bukti perbaikan. Integritas (mencuri, berbohong, meninggalkan rekan) → trust turun besar, pemulihan sangat lambat, mungkin tidak pernah penuh; Honesty–Humility rendah menaikkan peluang jenis kedua.
- **Penyendiri**: ~25–35 % NPC (introvert kuat dan/atau avoidant) punya kebutuhan relatedness dengan decay lebih lambat dan target lebih rendah; mereka tidak "sakit" karena sendiri, justru bisa terkuras oleh keramaian.

### Sumber
Daftar sumber no. 11–20, 41, 42, 43.

---

## 4. Kelompok, Faksi, Protes

### Ringkasan
**Social Identity Theory** (Tajfel & Turner 1979) **[KONSENSUS]**: manusia mengkategorikan diri ke dalam kelompok bahkan atas dasar sepele (minimal group paradigm — pembagian acak berdasar "lebih suka Klee atau Kandinsky" sudah memicu favoritisme in-group), lalu menaikkan harga diri lewat perbandingan yang menguntungkan kelompoknya. Klik/faksi terbentuk paling cepat ketika ada (a) penanda kategori yang jelas (asal, senioritas, spesialisasi), (b) kompetisi sumber daya, dan (c) perlakuan berbeda dari otoritas. **Relative deprivation** (Runciman; Smith dkk. 2012 meta-analisis) — bukan kemiskinan absolut yang memicu protes melainkan **merasa dirugikan dibanding acuan yang dianggap setara**, terutama bila dinilai **tidak adil** dan **kelompok**-nya (bukan hanya diri) yang dirugikan. Model **SIMCA** (van Zomeren, Postmes & Spears 2008, meta-analisis 182 efek) merangkum tiga pemicu aksi kolektif: **ketidakadilan yang dirasakan** (terutama komponen emosional/marah, r≈.35), **efikasi kelompok** ("kita bisa mengubah") dan **identitas kelompok yang kuat** — identitas menjadi jembatan yang memperkuat dua lainnya. **Equity theory** (Adams 1965): orang membandingkan rasio input/hasil dengan orang lain; under-reward → marah, turunkan usaha, tuntut; over-reward → rasa bersalah ringan (lebih cepat dirasionalisasi). **Free-rider** (Olson 1965): makin besar kelompok makin besar godaan menumpang; diatasi oleh pengawasan, sanksi rekan, dan identitas.

Siapa yang diam? **Bystander effect** (Darley & Latané 1968) **[KONSENSUS dengan revisi penting]**: dalam eksperimen klasik, 70 % menolong saat sendiri vs 40 % saat ada orang lain yang pasif; **pluralistic ignorance** (semua diam karena mengira orang lain tidak menganggap ini masalah) dan diffusion of responsibility jadi mekanismenya. Tetapi meta-analisis Fischer dkk. (2011) menemukan efek ini **melemah atau hilang saat situasi jelas berbahaya**, dan studi CCTV Philpot dkk. (2020) menemukan di konflik jalanan nyata **>90 % kasus ada yang turun tangan**, dan makin banyak orang justru makin besar peluang seseorang bertindak. **Leader emergence**: pemimpin informal muncul dari yang paling banyak bicara/berinisiatif (babble effect) dan dari yang kompeten-dihormati (prestige) atau ditakuti (dominance); Extraversion adalah prediktor kepribadian terkuat untuk munculnya pemimpin (Judge dkk. 2002 meta-analisis, ρ≈.33), lalu Conscientiousness dan Openness.

### Untuk simulasi
- **Kategori identitas** per NPC: 2–3 tag (asal, angkatan, spesialisasi). Favoritisme in-group: bonus affinity awal kecil (+5–10) antar anggota tag sama, bias penilaian saat konflik.
- **Faksi** muncul bila: ≥3 NPC dengan tag sama + affinity antar mereka tinggi + salah satu punya `grievance` (keluhan) → grievance menyebar lewat percakapan.
- **Grievance/relative deprivation**: hitung per NPC = (hasil yang diterima orang setara − hasil sendiri) × persepsi ketidakadilan. Contoh acuan: gaji/makanan/kamar/perlakuan pemain. Grievance individu yang dibagikan menjadi **grievance kelompok** — ini yang memicu protes, bukan yang individu.
- **Ambang protes (SIMCA)**: protes kolektif terjadi bila grievance_kelompok × efikasi (ada pemimpin + jumlah cukup) × identitas > ambang. Tanpa pemimpin/efikasi → grievance berubah menjadi sinisme, kerja lambat, keluar diam-diam.
- **Proporsi peran** [INFERENSI dari literatur bystander + free-rider]: dalam kelompok yang punya keluhan bersama, kira-kira 10–20 % ringleader/aktif, 30–50 % ikut bila ada yang memulai, 30–50 % diam (bystander, takut, atau puas). Pluralistic ignorance: NPC diam bila belum melihat orang lain menyatakan keluhan yang sama — sekali seseorang bersuara, ambang orang lain turun (cascade).
- **Free-rider**: kelompok >8–10 tanpa pengawasan → peluang malas naik; sanksi rekan (gosip, dijauhi) menurunkan.
- **Equity**: NPC membandingkan diri dengan 1–3 acuan (rekan setingkat), bukan seluruh populasi. Over-reward memberi rasa bersalah kecil yang cepat hilang; under-reward memberi marah yang bertahan lama. Reaksi terhadap **penurunan** status lebih kuat daripada status rendah stabil.
- **Pemimpin informal**: skor = Extraversion×0,4 + kompetensi×0,3 + respect_dari_orang_lain×0,3; yang tertinggi dalam faksi menjadi juru bicara.

### Sumber
Daftar sumber no. 19, 21, 22, 23, 44, 45.

---

## 5. Stres & Kesehatan Mental (untuk mekanik, bukan diagnosis)

### Ringkasan
**Model diatesis–stres** **[KONSENSUS]**: gangguan muncul dari interaksi kerentanan bawaan (diatesis: genetik, temperamen, riwayat) dengan tekanan lingkungan; orang dengan kerentanan rendah bisa menahan stres besar, orang dengan kerentanan tinggi bisa runtuh oleh stres sedang. Varian modernnya, **differential susceptibility**, menambahkan bahwa orang yang "rentan" juga lebih diuntungkan oleh lingkungan baik. **Allostatic load** (McEwen 1998) — stres yang berulang/kronis tanpa pemulihan mengakumulasi "keausan" fisiologis; stres akut sesekali dengan pemulihan justru adaptif. **Faktor pelindung** yang paling kuat buktinya: **dukungan sosial** (Cohen & Wills 1985 buffering hypothesis — dukungan yang *dirasakan tersedia* menyangga efek stres), **tidur** (kurang tidur menurunkan regulasi emosi dan menaikkan reaktivitas stres), **makna/tujuan** (Frankl; meaning in life berkorelasi dengan resiliensi), **aktivitas rekreatif/hobi** (recovery experiences: detachment psikologis, relaksasi, mastery, kontrol — Sonnentag & Fritz 2007), dan **pengalaman berhasil mengatasi stres sebelumnya** (stress inoculation).

**Kelelahan tempur**: literatur militer PD II (Swank & Marchand 1946, *Combat Neuroses: Development of Combat Exhaustion*) menggambarkan kurva efisiensi: periode awal "hijau" ~7–10 hari, puncak efektivitas ~hari 10–30(–90 menurut sumber lain), kemudian penurunan bertahap (hyper-reactive stage) dan kolaps; klaim yang sering dikutip — "setelah 60 hari pertempuran intens berkelanjutan, 98 % yang selamat menjadi kasus psikiatris" dan "2 % sisanya berciri aggressive psychopathic" — berasal dari studi Normandia mereka, tetapi **angka 98 %/2 % ini dipopulerkan oleh Grossman (*On Killing*) dan diperlakukan hati-hati oleh sejarawan** [PERDEBATAN pada magnitud; konsensus pada bentuk kurvanya]. Wikipedia *Combat stress reaction* merangkum rentang 60–240 hari tergantung intensitas, dan rasio korban stres : korban tempur bisa 1:1 pada pertempuran intens hingga 1:10 pada konflik rendah. Doktrin militer modern menyimpulkan: rotasi/istirahat berkala dan kohesi unit adalah pencegah utama. **Moral injury** (Shay; Litz dkk. 2009) berbeda dari PTSD berbasis takut: luka dari **melakukan, gagal mencegah, atau menyaksikan** perbuatan yang melanggar keyakinan moral mendalam, atau **dikhianati oleh otoritas yang sah** (Shay); gejalanya rasa bersalah, malu, marah, kehilangan kepercayaan, penarikan diri — bukan kilas balik ketakutan.

**Risiko bunuh diri (tingkat populasi, tanpa metode)**: faktor risiko yang konsisten dalam literatur (WHO, CDC, SPRC): depresi dan putus asa, isolasi/kehilangan koneksi, kehilangan besar (orang, status, pekerjaan), rasa terjebak, penyalahgunaan alkohol, percobaan sebelumnya, paparan bunuh diri orang dekat. Faktor pelindung: **keterhubungan** (connectedness — keluarga, komunitas, unit), rasa punya tanggung jawab pada orang lain, akses ke dukungan/perawatan, keterampilan mengatasi masalah, keyakinan yang memberi makna. Teori interpersonal (Joiner) merangkum dua penggerak: **thwarted belongingness** dan **perceived burdensomeness** — merasa tak punya tempat dan merasa jadi beban.

### Untuk simulasi
- **Dua lapis**: `vulnerability` (trait, dari Neuroticism + riwayat; 0–100) dan `stress` (state harian). Ambang gangguan = f(vulnerability): NPC rentan "patah" pada stres 60, NPC tangguh pada 90.
- **Allostatic load**: akumulator terpisah yang naik hanya bila stres tinggi **berhari-hari tanpa pulih**; load tinggi menurunkan ambang patah secara permanen-ish (pulih sangat lambat, berbulan-bulan).
- **Pemulihan**: stres turun per hari istirahat; pengali dari tidur cukup (×1,5), dukungan sosial dari orang yang dipercaya (×1,3–1,5), hobi/aktivitas bermakna (×1,2), makna/tujuan pribadi tercapai (×1,2). Pengalaman "berhasil melewati" menurunkan vulnerability sedikit (inokulasi).
- **Kurva tempur** (satuan: hari tempur berturut tanpa rotasi): hari 1–7 efektivitas 70 % (hijau), hari 8–30 100 % (puncak), hari 31–60 turun linear ke ~60 % + reaktivitas naik, >60 hari risiko kolaps eksponensial. Rotasi 3–7 hari di belakang garis mengembalikan sebagian; total kumulatif >200–240 hari tempur dalam karier → risiko permanen. Gunakan **bentuk kurva**, bukan angka 98 %.
- **Rasio korban stres**: dalam pertempuran intens, tiap 1 hero terluka fisik, ~1 hero lain mengalami reaksi stres akut (menolak bertugas, gemetar, membeku); di operasi ringan 1:10.
- **Moral injury**: pemicu terpisah dari bahaya — membunuh yang tak bersenjata, meninggalkan rekan, perintah pemain yang melanggar nilai NPC (Honesty/Agreeableness tinggi lebih rentan), pengkhianatan oleh pemimpin. Efek: guilt/shame meter, trust ke otoritas turun, penarikan diri; pemulihan lewat pengakuan, penebusan (tindakan perbaikan), penerimaan komunitas — bukan lewat istirahat.
- **Risiko fatal non-tempur**: hanya pada kombinasi: depresi berkepanjangan + isolasi (0 hubungan dekat) + kehilangan besar baru + merasa jadi beban (gagal berulang/cacat) + tak ada yang bergantung padanya. Faktor pelindung yang menurunkan drastis: ≥1 hubungan dekat, tanggung jawab pada orang lain (murid, anak), akses ke penyembuh. Tampilkan sebagai risiko yang bisa dicegah pemain, tanpa penggambaran metode.

### Sumber
Daftar sumber no. 24–29, 46, 47, 48, 49.

### 5.1 [PSI] Habituasi vs sensitisasi pada paparan stres berulang — verifikasi untuk DESAIN §1.2a

**Konteks pengecekan:** DESAIN_AI_NPC_V0.md §1.2a memakai pasangan **habituasi** (paparan berulang yang *selamat* → reaktivitas takut turun, `xp` naik +2/+4) vs **sensitisasi** (paparan berulang yang *kewalahan* tanpa pemulihan → reaktivitas takut naik, `xp` turun −3/−6), dimodulasi oleh **differential susceptibility** (`E ≥ 65` → pengali ×1,5 dua arah). Riset ini mengejar cabang [PSI-cek] tersebut sampai ke sumber primer, sesuai metode riset bertingkat.

**(a) Habituasi & sensitisasi sebagai teori dasar — [KONSENSUS, well-established].** Groves & Thompson (1970), *dual-process theory of habituation*, adalah kerangka standar dalam psikologi/neurosains pembelajaran non-asosiatif: paparan stimulus berulang memicu **dua proses paralel** yang bersaing — proses habituasi (penurunan respons, jalur netral/S-R langsung) dan proses sensitisasi (peningkatan respons, jalur "keadaan" yang lebih terpusat/arousal-driven) — hasil akhirnya adalah **jumlah** kedua proses tersebut, bukan salah satu meniadakan yang lain. Ini konsisten sebagai model umum di seluruh sistem saraf (dari refleks sederhana invertebrata sampai reaktivitas rasa takut mamalia), dan direplikasi ulang dalam neurosains ketakutan modern: studi 2025 (Kregar dkk., *Stress*, tandfonline) mengonfirmasi paparan berulang terhadap ancaman visual memang memicu **habituasi rasa takut bawaan**, tetapi laju dan besarnya habituasi **dimodulasi oleh riwayat ancaman sebelumnya dan tingkat stres akut** — paparan yang terjadi saat stres tinggi justru bisa memperlambat/membalik habituasi menjadi sensitisasi. Ini pas dengan struktur DESAIN §1.2a: hasil paparan bergantung pada apakah ada pemulihan (habituasi) atau tidak (sensitisasi), bukan paparan itu sendiri.

**(b) Stress-Enhanced Fear Learning (SEFL) — [PERDEBATAN, bukti utama dari hewan pengerat].** SEFL adalah model laboratorium yang menunjukkan satu episode stres berat (mis. shock tak terkendali) membuat pembelajaran rasa takut *berikutnya* jauh lebih kuat dan resisten terhadap extinction/habituasi — analog dengan "sensitisasi −6 setelah rekan mati di sisinya" di DESAIN. Namun **mayoritas bukti SEFL berasal dari studi tikus/rodent** (rangkaian penelitian Rau & Fanselow, direplikasi dalam meta-analisis sistematis 2026 pada model rodent PTSD); generalisasi ke manusia bersifat **model/inferensi**, bukan replikasi langsung — belum ada RCT manusia yang mengisolasi mekanisme SEFL sebagaimana pada tikus. Ini berarti *arah* efeknya (stres berat tak terpulihkan → sensitisasi rasa takut berikutnya) punya dasar mekanistik kuat, tetapi *angka* atau *kekuatan* efek pada manusia tidak bisa diklaim setara dengan literatur rodent.

**(c) Stress inoculation (sisi "habituasi yang menguatkan") — [KONSENSUS pada prinsip, PERDEBATAN pada bukti terapan spesifik].** Meichenbaum (1985) *Stress Inoculation Training* adalah kerangka klinis mapan: paparan bertahap terhadap stresor **pada dosis yang bisa diatasi** (cukup untuk melatih koping, tidak sampai membanjiri) membangun resiliensi terhadap stresor berikutnya — analog dengan mekanisme vaksin. RAND Corporation (*Stress Inoculation Training for Battlefield Airmen*, 2016) mengonfirmasi prinsip ini dipakai dalam pelatihan militer AS, dengan syarat eksplisit: intensitas stresor dinaikkan **hanya setelah keberhasilan pada level sebelumnya**, dan ditegaskan **"exposure to chronic stress [tanpa pemulihan] will result in sustained high arousal, which can interfere with adaptation"** — persis prinsip pemulihan 3 hari di DESAIN. Namun laporan RAND sendiri mengakui **bukti empiris spesifik untuk stres tempur berulang masih terbatas** (effect size performance-under-stress dari sedikit studi, n=9 relationship), dan tidak membahas rinci perbedaan individu (trait) dalam merespons — jadi prinsipnya solid, tapi kekuatan buktinya moderat, bukan kuat.

**(d) Differential susceptibility (Belsky & Ellis) — [KONSENSUS dengan catatan, mendukung pemilihan `E` sebagai modulator].** Teori "for better and for worse": individu dengan **negative emotionality tinggi** dan/atau reaktivitas fisiologis tinggi (jalur otonom/adrenokortikal) bukan sekadar "lebih rentan" pada lingkungan buruk — mereka **lebih responsif secara simetris** terhadap lingkungan baik maupun buruk dibanding individu ber-reaktivitas rendah. Bukti pendukung: anak bertemperamen sulit paling diuntungkan oleh pengasuhan berkualitas tinggi, tetapi juga paling dirugikan oleh pengasuhan berkualitas rendah — pola simetris ini didukung studi eksperimental (bukan hanya korelasional) pada beberapa domain (childcare, parenting intervention, gaya wawancara). **Ini secara langsung membenarkan** pemilihan dimensi `E` (Emotionality, padanan Neuroticism HEXACO) sebagai penanda `≥65` di DESAIN §1.2a untuk pengali ×1,5 dua arah — bukan pilihan sembarang, melainkan variabel yang literatur differential susceptibility memang gunakan sebagai marker utama. Catatan: mayoritas bukti korelasional, sebagian kecil eksperimental; simetri "for better and for worse" didukung tapi belum bisa diklaim berlaku identik pada domain rasa-takut-tempur (belum ada studi yang menguji differential susceptibility spesifik untuk habituasi/sensitisasi rasa takut akibat pertempuran).

**Kesimpulan verifikasi:**
- Arah mekanisme di §1.2a (dua proses bersaing, hasil bergantung pemulihan, dimodulasi reaktivitas individu) **konsisten dengan 4 badan literatur independen** (dual-process habituation, SEFL, stress inoculation, differential susceptibility) — cukup kuat untuk **naik status dari [PSI-cek] ke [PSI]** dengan syarat: label kekuatan bukti per komponen tetap dibedakan (habituasi/stress-inoculation = KONSENSUS prinsip; sensitisasi/SEFL akut = PERDEBATAN karena basis rodent; differential susceptibility via `E` = KONSENSUS dengan catatan korelasional).
- **Tidak ditemukan** bukti yang membantah arah DESAIN §1.2a — tidak perlu revisi arah rumus.
- **Batasan yang perlu dicatat di DESAIN** (rekomendasi, bukan perubahan otomatis — keputusan tetap di pemilik sesuai A6 #29): angka spesifik (+2/+4, −3/−6, ×1,5, plafon 40+0,6·cou) tetap (TERBUKA)/[ESTIMASI] desain game, bukan derivasi langsung dari angka penelitian manapun — tidak ada studi yang memberi angka "+2 xp per misi selamat" secara harfiah; yang terverifikasi adalah **arah dan bentuk mekanismenya**, bukan magnitudonya. Ini sudah sesuai prinsip §10.2 #1 (semua koefisien dikalibrasi §9, bukan final).

### Sumber tambahan (§5.1)
56. Groves & Thompson 1970 (dual-process theory of habituation) — https://psycnet.apa.org/record/1971-02046-001
57. Kregar dkk. 2025, habituasi rasa takut bawaan pada ancaman visual berulang, dimodulasi stres akut & riwayat ancaman — https://www.tandfonline.com/doi/full/10.1080/10253890.2025.2489942
58. Rau & Fanselow (Stress-Enhanced Fear Learning, rodent model) ringkasan — https://www.jove.com/t/58306/stress-enhanced-fear-learning-robust-rodent-model-post-traumatic
59. Meta-analisis sistematis SEFL pada rodent 2026 — https://pmc.ncbi.nlm.nih.gov/articles/PMC13406739/
60. Meichenbaum 1985, Stress Inoculation Training — https://journals.sagepub.com/doi/10.1177/0011000088161005
61. RAND Corporation 2016, *Stress Inoculation Training for Battlefield Airmen* (RR-750) — https://www.rand.org/content/dam/rand/pubs/research_reports/RR700/RR750/RAND_RR750.pdf
62. Belsky & Pluess 2007, "For Better and For Worse: Differential Susceptibility to Environmental Influences" — https://journals.sagepub.com/doi/10.1111/j.1467-8721.2007.00525.x
63. Ellis dkk. 2011, Differential Susceptibility to the Environment: neurodevelopmental theory — https://www.marinusvanijzendoorn.nl/wp-content/uploads/2012/07/Ellisetal2011.pdf
64. Belsky Wiley major reference (ringkasan DST & marker temperamen) — https://onlinelibrary.wiley.com/doi/abs/10.1002/9781119125556.devpsy202

---

## 6. Duka & Kematian Rekan

### Ringkasan
**Lima tahap Kübler-Ross** (denial–anger–bargaining–depression–acceptance) **[DIBANTAH]**: berasal dari wawancara pasien terminal (1969), bukan orang yang berduka; tidak pernah dimaksudkan sebagai urutan; studi longitudinal (Maciejewski dkk. 2007, JAMA, n=233) menemukan **acceptance** justru indikator yang paling tinggi sejak awal dan **yearning** (kerinduan) — bukan denial atau anger — indikator negatif yang dominan, memuncak sekitar bulan ke-4 dan sebagian besar indikator negatif mulai turun setelah ~6 bulan. Yang didukung empiris: **Dual Process Model** (Stroebe & Schut 1999) — orang yang berduka **berosilasi** antara *loss-oriented coping* (menangis, mengenang, merindukan) dan *restoration-oriented coping* (mengurus hidup, peran baru, mengalihkan perhatian); osilasi ini sehat, terjebak di satu sisi saja bermasalah. **Continuing bonds** (Klass, Silverman & Nickman 1996): hubungan dengan yang mati **tidak diputus** melainkan diubah — berbicara pada almarhum, menyimpan barang, meneruskan kebiasaannya, merasa "diawasi" — dan ini normal serta sering adaptif, bertentangan dengan pandangan lama "harus melepaskan".

**Trajektori** (Bonanno dkk. 2002, 205 janda/duda, diukur pra-kehilangan hingga 18 bulan): **resilient 45,9 %** (tidak ada peningkatan distres berarti), **common/recovery grief 10,7 %** (distres di 6 bulan, pulih di 18), **chronic grief 15,6 %**, **chronic depression 7,8 %** (sudah depresi sebelum kehilangan), **depressed-improved 10,2 %** (membaik setelah kehilangan — biasanya pengasuh yang lelah atau hubungan buruk). Studi lain Bonanno menghasilkan resilient 50–60 %. Meta-analisis Lundorff dkk. (2017, 14 studi) → **prolonged grief disorder ~9,8 %** dari orang dewasa berduka (kehilangan alami); lebih tinggi untuk kematian mendadak/kekerasan dan kehilangan anak/pasangan. DSM-5-TR (2022) mensyaratkan ≥12 bulan sesudah kematian untuk diagnosis prolonged grief (ICD-11: 6 bulan) — implikasinya duka "biasa" yang intens hingga 6–12 bulan adalah normal. **Unit militer/tim**: berduka lewat **ritual** (upacara, menyebut nama, "roll call" dengan kursi kosong, menyimpan barang almarhum, tato/lencana), **humor gelap** (Moran & Massam 1997; humor gallows pada responden darurat berfungsi menjaga jarak emosional dan kohesi — sehat sebagai koping jangka pendek, berbahaya bila menjadi satu-satunya koping), **penarikan diri sementara**, dan **penundaan** duka sampai operasi selesai (delayed grief); rasa bersalah penyintas (survivor guilt) sangat umum. Kematian rekan memperkuat identity fusion pada yang tersisa tetapi juga memicu keinginan balas dendam/impulsif.

**Mengapa pemain/penonton ikut sedih**: (1) **attachment/parasocial relationship** (Horton & Wohl 1956; Cohen 2004) — orang membentuk ikatan satu arah dengan tokoh, dan "parasocial breakup" menghasilkan reaksi duka nyata yang intensitasnya ∝ intensitas hubungan dan gaya lekat cemas; studi 2025 (Acta Psychologica) pada pemain game menemukan 60 % duka parasosial berlangsung <1 hari, sebagian berminggu-minggu, lebih lama pada yang kesepian/neurotik/introvert, dan dukungan sosial memoderasi. (2) **Investasi & waktu bersama** — sesuai Hall, jam yang dihabiskan bersama tokoh membentuk keakraban; (3) **narasi kecil yang dikenang** — memori spesifik dan idiosinkratik (bukan statistik) adalah bahan continuing bonds; (4) **Bukti dari game**: liputan Dwarf Fortress (*Boatmurdered*) dan RimWorld menunjukkan pemain menulis eulogi dan kisah untuk karakter prosedural yang hanya punya sifat, hubungan, dan riwayat kejadian sederhana — indikasi bahwa **riwayat relasional + peristiwa unik** cukup untuk memicu attachment, bukan grafis atau dialog.

### Untuk simulasi
- **Hapus tahapan linear**; gunakan **osilasi** dua mode per NPC yang berduka: `loss_mode` (mengenang, produktivitas turun, mencari barang/tempat almarhum) dan `restoration_mode` (kerja, mengurus urusan almarhum, mengambil peran almarhum); perbandingan bergeser dari 70:30 ke 30:70 selama beberapa bulan game.
- **Intensitas duka awal** ∝ affinity × familiarity (jam bersama) × ketergantungan (mentor/murid/pasangan) × mendadak/kekerasan (×1,5) × Neuroticism.
- **Trajektori** diambil acak berbobot per NPC saat kehilangan: ~50 % resilient (sedih 1–3 minggu, fungsi hampir normal), ~10–15 % recovery (terganggu jelas ~6 bulan, pulih), ~10–15 % chronic (>12 bulan, butuh intervensi), ~10 % "membaik" (bila hubungan buruk/beban), sisanya sudah bermasalah sebelumnya. Bobot geser oleh: kedekatan (menaikkan chronic), dukungan sosial (menurunkan), kematian mendadak/menyaksikan (menaikkan), riwayat kehilangan beruntun (menaikkan).
- **Puncak & durasi**: indikator negatif memuncak ~bulan 1–4, mulai turun setelah ~6 bulan; ambang "complicated" di 12 bulan.
- **Continuing bonds**: NPC menyebut almarhum dalam dialog, mengunjungi makam, memakai/menyimpan barangnya, meniru kebiasaannya, merayakan hari kematian. Frekuensi turun perlahan tapi tidak ke nol — ini yang membuat dunia "mengingat".
- **Ritual unit**: upacara kolektif menurunkan stres semua yang hadir dan menaikkan kohesi; tanpa ritual (kematian diabaikan pemain) → grievance kolektif + duka lebih lama. Humor gelap: NPC dengan Extraversion tinggi/Neuroticism rendah lebih sering, menurunkan stres kelompok kecil tapi menyinggung NPC yang paling dekat dengan almarhum.
- **Survivor guilt**: NPC yang hadir saat rekan mati mendapat guilt; lebih besar bila ia "bisa" menolong; pulih lewat penebusan atau pengakuan.
- **Untuk pemain**: pastikan tiap hero mengakumulasi **3–5 momen spesifik yang dicatat** (dialog, kejadian unik, hubungan bernama) sebelum ia berisiko mati — karena itulah bahan duka parasosial; berikan pemain **ritual** (menamai makam, memilih barang peninggalan) karena ritual adalah cara nyata manusia memproses.

### Sumber
Daftar sumber no. 30–36, 40, 50, 51, 52, 53.

---

## 7. Sifat yang Membuat Karakter Terasa "Hidup" bagi Pengamat

### Ringkasan
**Mind perception** (Gray, Gray & Wegner 2007, *Science*, n≈2.400) menemukan orang menilai "pikiran" pada dua dimensi terpisah: **Agency** (mampu merencanakan, mengontrol diri, bermoral, mengingat) dan **Experience** (mampu merasa lapar, takut, sakit, senang, punya kepribadian). Robot dinilai tinggi agency–rendah experience; bayi sebaliknya; manusia dewasa tinggi keduanya. Yang menentukan **kepedulian moral dan empati** (apakah kita sedih bila ia menderita) terutama **Experience**, bukan agency — jadi karakter yang cerdas tapi tanpa tanda merasa tidak membuat sedih. Malle (2019) memperluas ke 3 dimensi (affect, moral & mental regulation, reality interaction) **[PERDEBATAN pada jumlah dimensi, KONSENSUS pada pemisahan agency/experience]**. **Teori tiga faktor antropomorfisme** (Epley, Waytz & Cacioppo 2007): kita memanusiakan sesuatu lebih kuat bila (1) pengetahuan manusiawi mudah diakses (bentuk/perilaku mirip manusia), (2) **motivasi efektansi** — kita ingin memprediksi/memahami perilakunya, terutama bila perilakunya **tidak sepenuhnya bisa diprediksi tapi tampak beralasan**, dan (3) **motivasi sosialitas** — kita kesepian atau butuh koneksi. Waytz dkk. menunjukkan ketidakpastian yang "masuk akal" meningkatkan atribusi pikiran — perilaku yang 100 % dapat diprediksi terasa mesin, perilaku acak terasa rusak; ruang tengahnya terasa "hidup".

Temuan lain yang relevan: **narrative identity** (McAdams) — manusia memahami orang lain lewat cerita hidup yang berkesinambungan; rujukan pada masa lalu bersama adalah tanda pikiran yang mengingat. **Idiosinkrasi** — preferensi kecil, kebiasaan, keengganan yang tidak fungsional (tak suka makanan tertentu, takut pada sesuatu yang sepele, ritual pribadi) adalah **sinyal individualitas** yang tidak bisa dijelaskan dari peran/fungsi; dalam persepsi orang, itulah yang membedakan "orang" dari "petugas". Riset tentang **empati terhadap penderitaan** (Batson) dan **identifiable victim effect** (Small & Loewenstein 2003): satu individu dengan nama dan detail memicu empati jauh lebih besar daripada statistik — semakin spesifik dan personal detailnya, semakin kuat.

### Untuk simulasi
- **Tampilkan Experience, bukan hanya Agency**: sinyal lapar, takut, sakit, lega, malu, rindu, bosan (ekspresi, dialog, penolakan). Ini yang memicu empati, bukan kecerdasan taktis.
- **Keteraturan yang tidak sempurna**: perilaku dijelaskan oleh trait+state (bisa dipahami pengamat), tetapi dengan noise 10–20 % dan pengaruh mood yang membuat prediksi tidak pasti. Pengamat harus bisa menjelaskan *sesudahnya* ("oh, dia menolak karena kemarin temannya mati") tapi tidak bisa memprediksi *sebelumnya* dengan pasti.
- **Memori episodik kecil**: tiap NPC menyimpan 5–10 kejadian bermakna (dengan siapa, apa, valensi) dan **merujuknya** dalam dialog/keputusan ("aku tak mau ke rawa itu lagi"). Memori bersama antar-NPC → dialog yang merujuk satu sama lain.
- **Tujuan pribadi**: 1–2 goal jangka panjang per NPC (menjadi yang terkuat, pulang kampung, membalas dendam, menabung untuk saudara) yang kadang **bertentangan** dengan tujuan pemain; NPC menolak/menunda tugas yang melawan goal-nya.
- **Keengganan & preferensi kecil**: 2–4 idiosinkrasi non-fungsional per NPC (fobia sepele, makanan favorit/benci, ritual sebelum tempur, kebiasaan tidur, humor tertentu). Biaya implementasi rendah, efek persepsi tinggi.
- **Kebiasaan**: rutinitas harian yang dapat diamati (duduk di tempat yang sama, mengunjungi seseorang) — dan **perubahannya** setelah kejadian (berhenti mengunjungi makam, mulai minum) adalah sinyal state yang kuat.
- **Nama, wajah, detail spesifik** > statistik: satu kalimat riwayat unik per hero lebih bernilai daripada seluruh angka stat-nya untuk memicu duka.

### Sumber
Daftar sumber no. 37, 38, 39, 54, 55.

---

## Daftar sumber (gabungan, ≥20)

1. Bleidorn dkk. 2022 — https://pubmed.ncbi.nlm.nih.gov/35834197/
2. Bühler dkk. 2024 — https://journals.sagepub.com/doi/10.1177/08902070231190219
3. Specht dkk. 2011 — https://pubmed.ncbi.nlm.nih.gov/21859226/
4. Ashton & Lee 2007 (HEXACO) — https://journals.sagepub.com/doi/10.1177/1088868306294907
5. Ashton, Lee & de Vries 2014 — https://journals.sagepub.com/doi/10.1177/1088868314523838
6. Ryan & Deci 2000 (SDT) — https://selfdeterminationtheory.org/SDT/documents/2000_RyanDeci_SDT.pdf
7. Wahba & Bridwell 1976 — https://www.sciencedirect.com/science/article/abs/pii/0030507376900386
8. Tay & Diener 2011 — https://www.apa.org/pubs/journals/releases/psp-101-2-354.pdf
9. Eastwood dkk. 2012 — https://journals.sagepub.com/doi/abs/10.1177/1745691612456044
10. Maslach & Leiter 2016 — https://onlinelibrary.wiley.com/doi/10.1002/wps.20311
11. McPherson dkk. 2001 — https://www.annualreviews.org/content/journals/10.1146/annurev.soc.27.1.415
12. Hall 2019 — https://journals.sagepub.com/doi/10.1177/0265407518761225
13. Mac Carron, Kaski & Dunbar 2016 — https://www.sciencedirect.com/science/article/pii/S0378873316301095
14. Dunbar's number & kritik Lindenfors 2021 — https://en.wikipedia.org/wiki/Dunbar's_number
15. Whitehouse dkk. 2017 — https://www.nature.com/articles/srep44292
16. Whitehouse dkk. 2014 (Libya) — https://www.pnas.org/doi/full/10.1073/pnas.1416284111
17. Bautista dkk. 2026 — https://bpspsychub.onlinelibrary.wiley.com/doi/10.1111/bjso.70026
18. van de Ven dkk. 2011 — https://doi.org/10.1177/0146167211400421
19. Cheng, Tracy & Henrich 2013 — https://pubmed.ncbi.nlm.nih.gov/23163747/
20. Kim, Ferrin, Cooper & Dirks 2004 — https://pubmed.ncbi.nlm.nih.gov/14769123/
21. van Zomeren dkk. 2008 (SIMCA) — https://pubmed.ncbi.nlm.nih.gov/18605818/
22. Bystander effect / Fischer 2011 / Philpot 2020 — https://en.wikipedia.org/wiki/Bystander_effect
23. Equity theory — https://thedecisionlab.com/reference-guide/management/equity-theory
24. McEwen 1998 (allostatic load) — https://en.wikipedia.org/wiki/Allostatic_load
25. Cohen & Wills 1985 — https://lchc.ucsd.edu/mca/Mail/xmcamail.2012_11.dir/pdfYukILvXsL0.pdf
26. Swank & Marchand 1946 — https://www.semanticscholar.org/paper/83abb80ab8ad6248f646e65a815e22e0da5fa15e
27. Combat stress reaction — https://en.wikipedia.org/wiki/Combat_stress_reaction
28. Litz, *Moral injury: State of the science* — https://sites.bu.edu/litzlab/files/2025/01/Litz-moral-injury-state-of-science.pdf
29. SPRC risk & protective factors — https://sprc.org/risk-and-protective-factors/
30. Maciejewski dkk. 2007 — https://pubmed.ncbi.nlm.nih.gov/17312291/
31. Bonanno dkk. 2002 — https://sites.bu.edu/deborahcarr/files/2020/09/bonanno-et-al-2002.pdf
32. Lundorff dkk. 2017 — https://pubmed.ncbi.nlm.nih.gov/28167398/
33. Klass, Silverman & Nickman 1996 — https://en.wikipedia.org/wiki/Continuing_bonds
34. Moran & Massam 1997 — https://pubmed.ncbi.nlm.nih.gov/12882095/
35. Cohen 2004 (parasocial breakup) — https://journals.sagepub.com/doi/abs/10.1177/0265407504041374
36. Parasocial grief in games 2025 — https://www.sciencedirect.com/science/article/pii/S0001691825011114
37. Gray, Gray & Wegner 2007 — https://www.science.org/doi/10.1126/science.1134475
38. Epley, Waytz & Cacioppo 2007 — https://www.semanticscholar.org/paper/05e0f92d03b7c15d888a2160b20c69f0964da725
39. Malle 2019 — https://research.clps.brown.edu/SocCogSci/Publications/Pubs/Malle_2019_How_Many_Dimensions.pdf
40. Boatmurdered (bukti persepsi pemain) — https://en.wikipedia.org/wiki/Boatmurdered ; Game Developer — https://www.gamedeveloper.com/design/rimworld-dwarf-fortress-and-procedurally-generated-story-telling
41. Festinger, Schachter & Back 1950 / propinquity — https://en.wikipedia.org/wiki/Propinquity
42. *Reflecting on Dunbar's numbers: individual differences* 2025 — https://pmc.ncbi.nlm.nih.gov/articles/PMC11896044/
43. Hazan & Shaver 1987 distribusi gaya lekat — https://courses.lumenlearning.com/suny-lifespandevelopment/chapter/attachment-in-young-adulthood/
44. Tajfel & Turner 1979 ringkasan — https://www.simplypsychology.org/social-identity-theory.html ; minimal group — https://en.wikipedia.org/wiki/Minimal_group_paradigm
45. Ulasan bystander effect (PMC) — https://pmc.ncbi.nlm.nih.gov/articles/PMC6099971/
46. Marlowe (RAND) bab 7, kurva sustainment — https://www.gulflink.osd.mil/library/randrep/marlowe_paper/mr1018_11_ch7.html
47. Warfare History Network, laporan "Combat Exhaustion" 1946 — https://warfarehistorynetwork.com/combat-fatigue-how-stress-in-battle-was-felt-and-treated-in-wwii/
48. Shay 2012, *Moral Injury* — https://oralhistoryreview.org/wp-content/uploads/2019/04/Shay-Jonathan-Moral-Injury-Intertexts-Lubbock-16-1-Spring-2012-57-6685-86-2012-.pdf
49. Lancet Public Health 2024, faktor risiko bunuh diri tingkat masyarakat — https://www.thelancet.com/journals/lanpub/article/PIIS2468-2667(24)00158-0/fulltext
50. Ulasan model duka (Dual Process, dll.) — https://courses.lumenlearning.com/suny-lifespandevelopment/chapter/models-of-grief/
51. Frontiers 2021, *Stages of Grief Portrayed on the Internet* — https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2021.772696/full
52. Bonanno, Wortman & Nesse 2004 — https://www.stonybrook.edu/commcms/psychology/_pdfs/social_health/_camille_wortman/Bonanno%20Wortman%20and%20Nesse%202004%20article.pdf
53. Prolonged grief disorder: course & diagnosis — https://psychiatryonline.org/doi/10.1176/appi.focus.20200052
54. Epley dkk. 2008, *When we need a human* — https://guilfordjournals.com/doi/10.1521/soco.2008.26.2.143
55. Waytz, Cacioppo & Epley 2010, *Who Sees Human?* — https://journals.sagepub.com/doi/abs/10.1177/1745691610369336

Sumber tambahan §5.1 (56–64) tercantum di bagian 5.1 di atas.

---

## Yang tidak ketemu / masih diperdebatkan

- **Angka 98 % / 2 % Swank & Marchand**: teks asli 1946 tidak dapat diakses (berbayar). Angka ini tersebar luas lewat Grossman (*On Killing*) dan laporan populer; sumber militer yang saya baca (RAND/Marlowe) hanya mengonfirmasi **bentuk kurva** menuju 100 % korban psikiatris pada pertempuran intens berkelanjutan, bukan angka spesifik. Perlakukan sebagai ilustrasi, bukan konstanta.
- **Jumlah dimensi Big Five vs HEXACO**: HEXACO memprediksi perilaku tidak jujur lebih baik, tetapi mayoritas literatur perubahan kepribadian memakai Big Five; belum ada meta-analisis stabilitas Honesty–Humility sebanding Bleidorn 2022.
- **Besaran undermining effect (SDT)**: konsensus ada efeknya untuk hadiah yang mengontrol; besaran dan kondisi batasnya masih diperdebatkan (Cameron & Pierce vs Deci, Koestner & Ryan 1999).
- **Dunbar 150**: struktur berlapis dan rasio ~3 cukup kokoh; angka absolut 150 dipertanyakan (Lindenfors 2021 CI 2–520).
- **Bystander effect di dunia nyata**: eksperimen lab vs CCTV memberi arah berlawanan soal efek jumlah orang; yang aman untuk simulasi: efek pasif terjadi pada situasi **ambigu/tidak berbahaya**, hilang pada bahaya jelas.
- **Proporsi ringleader/pengikut/diam** dalam protes kelompok kecil: tidak saya temukan angka empiris langsung; proporsi 10–20 / 30–50 / 30–50 % adalah inferensi dari literatur bystander, free-rider, dan difusi inovasi.
- **Durasi "wajar" duka antar-budaya**: kriteria 6 bulan (ICD-11) vs 12 bulan (DSM-5-TR) masih diperdebatkan; studi 2025 menyatakan prevalensi PGD kemungkinan **dilebih-lebihkan** (PubMed 40586701).
- **Grief pada unit militer**: kebanyakan literatur bersifat kualitatif/etnografis (ritual, humor, penundaan duka); angka proporsi trajektori duka khusus prajurit setelah kematian rekan tidak saya temukan — angka Bonanno berasal dari janda/duda lansia, jadi transfer ke prajurit muda adalah inferensi.
- **Efek jangka panjang identity fusion**: Bautista 2026 menunjukkan meluruh; laju peluruhannya belum terkuantifikasi dengan baik.
- **"The Sims effect"**: bukan istilah ilmiah yang saya temukan dalam literatur peer-review; bukti untuk duka pemain atas karakter prosedural bersifat anekdot/jurnalistik (Boatmurdered, liputan RimWorld) plus studi parasocial grief 2025 yang bersifat survei kecil (n=123).
- **[BARU §5.1] Stress-Enhanced Fear Learning (SEFL) pada manusia**: mekanisme mapan pada rodent, tetapi belum ada studi manusia yang mereplikasi langsung (bukan hanya menganalogikan ke PTSD manusia via mekanisme yang diasumsikan sama). Generalisasi ke manusia = inferensi berbasis kesamaan mekanisme neurobiologis dasar, bukan replikasi.
- **[BARU §5.1] Angka spesifik habituasi/sensitisasi `xp`**: tidak ada studi yang memberi angka literal untuk "+2 per misi selamat" atau "−3 per panic episode" — ini tetap keputusan desain game (TERBUKA/ESTIMASI), hanya arah dan bentuk mekanismenya yang terverifikasi ke literatur.
