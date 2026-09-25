# RISET BATAS TEKNIS ROBLOX UNTUK VERSI ENDGAME (Tower 100, rift, guild, PvP, 5–10 tahun) [TERVERIFIKASI + INFERENSI ditandai]

Terakhir diperbarui: 24 September 2026, 13:10 WIB

Pertanyaan pemilik: apakah game ini pada tahap endgame/update terakhir masih muat di Roblox (batas data dsb.), supaya rencana tidak buntu di tengah jalan. **Jawaban singkat: MUAT, dengan 5 aturan arsitektur yang harus dipatuhi sejak M1 (§4).** Yang membatasi bukan jumlah lantai/konten (itu hanya baris data + prefab), melainkan **ukuran data per pemain per key** dan **laju tulis per key**.

## 1. BATAS RESMI ROBLOX [TERVERIFIKASI — create.roblox.com/docs/cloud-services/data-stores/error-codes-and-limits, dibaca 24/9/2026]
| Batas | Nilai |
|---|---|
| Ukuran nilai per key | **4.194.304 karakter** (JSON terserialisasi, diukur dengan `HttpService:JSONEncode`) |
| Nama data store / key / scope | 50 karakter |
| Penyimpanan total per experience | **500 MB + 1 MB × jumlah pemain seumur hidup** (diukur dari ukuran TERKOMPRESI versi terbaru tiap key; Roblox mengompresi sendiri — jangan pra-kompresi) |
| Throughput per key (semua server) | **Baca 25 MB/menit · Tulis 4 MB/menit**, dibulatkan ke KB per request |
| Budget request per experience (dibagi semua server + Open Cloud) | Standard: baca 300 + 40×CCU /menit · tulis 300 + 20×CCU /menit · list 300 + 2×CCU · remove 300 + 40×CCU. Ordered (leaderboard): baca 300 + 40×CCU · tulis 300 + 20×CCU · list (GetSorted) 300 + 2×CCU |
| Budget per server (default, bisa diatur) | Standard baca/tulis 60 + 40×pemain /menit; ordered tulis 30 + 5×pemain; list 5 + 2×pemain |
| Antrean per tipe request | 30 request; lebih dari itu request dibuang (error 301–306) |
| Metadata per key | 300 karakter total |
| `UpdateAsync` | memakai budget baca DAN tulis sekaligus |

Perubahan 2026 yang relevan: budget berpindah dari per-server ke **per-experience** (semua server + Open Cloud berbagi satu kuota), dan baseline penyimpanan naik 100 MB → 500 MB per 29 Juli 2026. Bila penyimpanan kurang, ada tier berbayar "Extended Services" [sumber sekunder: bloxbot.ai, gmmarket.me — belum saya verifikasi di halaman resmi].

## 2. UKURAN DATA KITA — HITUNGAN
Estimasi ukuran JSON satu hero hidup (nama, ★, Lv, exp, class, 8 angka stat, ±8 skill × {id, tier, lv}, ±6 nilai tersembunyi, ±5 slot equipment, status effect, flag bond/enmity/kompatibilitas, jabatan, lantai waiting room): **±600–900 byte** [INFERENSI, diverifikasi saat M1 dengan `JSONEncode`]. Hero mati di archive: ±250 byte (ringkasan + barang peninggalan).

| Skenario pemain | Hero hidup | Hero di archive | JSON | Status vs 4 MB/key |
|---|---|---|---|---|
| V0 launch (kapasitas Accommodation 20) | 20 | 100 | ±40 KB | aman ×100 |
| Menengah (1 tahun) | 300 | 2.000 | ±0,8 MB | aman |
| Berat (endgame, kapasitas fasilitas maksimal kita) | 2.000 | 10.000 | ±4,3 MB | **melampaui bila satu key** → wajib dipecah (§4.1) |
| Kanon ekstrem (Loki: ±15.000 hero aktif, ch.312) | 15.000 | — | ±12 MB | hanya mungkin dengan sharding; bukan target desain kita |

Penyimpanan total: rata-rata pemain (mayoritas kasual, <200 hero) jauh di bawah 1 MB terkompresi; pemain berat 1–2 MB terkompresi. Kuota 500 MB + 1 MB/pemain seumur hidup **cukup** karena rata-rata, bukan maksimum, yang dihitung.

## 3. YANG PALING MUDAH DILANGGAR TANPA SADAR
1. **Laju tulis per key 4 MB/menit.** ProfileService default autosave tiap 30 detik → profil 1 MB × 2 tulis/menit = 2 MB/menit (aman), tetapi profil 2,5 MB → 5 MB/menit = **KeyThrottled**. Solusi: profil aktif dijaga kecil (§4.1) dan interval autosave dinaikkan untuk pemain berat.
2. **Rekaman misi.** Log event tekstual 1 misi lantai 30 dengan 25 hero bisa 50–200 KB; menyimpan ratusan rekaman = melampaui key. Solusi §4.3: simpan **seed + input** (±2–5 KB), putar ulang dengan engine deterministik — inilah alasan tambahan syarat "deterministik per seed" di BRIEF_SCRIPTER §2.
3. **Catch-up offline.** Simulasi 7 hari × 2.000 hero saat login bisa memakan detik CPU server. Solusi: batas Δt 7 hari (sudah di RENCANA §3) + simulasi per hari dengan agregasi (bukan per menit) + jalankan di coroutine agar tidak membekukan server 8 pemain.
4. **Leaderboard/ranking lantai** memakai OrderedDataStore: tulis hanya saat rekor naik (bukan tiap misi), GetSorted 1× per beberapa menit per server → jauh di bawah 300 + 2×CCU.

## 4. LIMA ATURAN ARSITEKTUR (berlaku sejak M1; semua kompatibel dengan kanon)
1. **Pecah profil per pemain menjadi beberapa key sejak awal**: `core` (mata uang, fasilitas, research, jabatan, setting — kecil, autosave sering) · `heroes_N` (hero hidup, ≤1.000 hero per key, dibuat bertahap) · `archive_N` (hero mati, ≤2.000 per key, tulis jarang) · `replays` (indeks seed/input) · `mail`. Satu "ProfileService profile" per key atau pakai modul sharding (contoh terbuka: Lyra by Paradoxum). Menambah key = menambah kapasitas tanpa migrasi data.
2. **Kapasitas hero = angka data** (`FacilityData` Accommodation), plafon teknis 2.000 hero hidup per pemain di V1+ (kanon tidak memaksa 15.000; itu ranker #5 setelah bertahun-tahun). Bila kelak ingin lebih: tambah shard, bukan ubah skema.
3. **Rekaman misi = seed + `MissionRequest`**, bukan log; replay = jalankan ulang engine. Log tekstual hanya untuk sesi berjalan.
4. **Tidak ada state dunia yang bergantung pada server hidup**: semua waktu (daily 11 jam, exploration 48 jam, research, konstruksi, catch-up) dihitung dari timestamp UTC — konsisten dengan keputusan catch-up saat login.
5. **Konten = data + prefab**: lantai 31–100, boss, rift, event tidak menyentuh skema penyimpanan; skema hero/party/fasilitas diberi `schemaVersion` + fungsi migrasi sejak M1 supaya update 5–10 tahun tidak merusak save lama.

## 5. SISTEM V1+ YANG BUTUH LAYANAN LAIN (verifikasi saat masuk desain, bukan sekarang)
- **Guild, trading board, chat lintas-server, PvP invasi**: MemoryStoreService (state cepat lintas-server) + MessagingService (siaran lintas-server). Keduanya punya kuota per experience dan batas ukuran pesan [INFERENSI — belum diverifikasi di chat ini; verifikasi sebelum desain V1+ modul terkait].
- **Hall of Fame/ending, migrasi & kompensasi pemain ke game berikutnya** (KONSEP §11): Open Cloud DataStore API memungkinkan membaca data pemain dari luar game dan menulis ke experience lain — memakai budget per-experience yang sama (§1), jadi migrasi massal dijadwalkan bertahap.
- **Server 8 pemain + arena instanced**: batas memori/instance tidak menjadi kendala karena hero yang dirender di hub dibatasi (mis. 20–50 model terlihat per room, sisanya hanya data); combat arena merender ≤25 hero + musuh. Angka batas memori server tidak dipublikasikan resmi → tidak saya klaim.

## 6. KESIMPULAN UNTUK RENCANA
Rencana C+ tidak berubah. Yang bertambah: aturan §4 masuk RENCANA_Build_Hibrida §3 sebagai hal yang dikunci minggu 1 (skema key terpecah + `schemaVersion`), dan BRIEF_SCRIPTER sudah memuat syarat deterministik yang membuat §4.3 mungkin.
