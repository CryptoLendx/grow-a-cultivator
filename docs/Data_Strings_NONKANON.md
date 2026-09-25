# DATA STRINGS NONKANON — TEKS §7.2, VARIAN, KARTU MEMORIAL

Terakhir diperbarui: 25 September 2026, 22:50 WIB

## 0. Cakupan dan aturan penulisan

Berkas ini mengisi §10.3 butir 1 `DESAIN_AI_NPC_V0.md`: 10 id string NONKANON yang disebut di §7.2 (`STEAL, EXTORT, PROVOKE, WENT_ALONE, DECLINED_POSITION, GRIEF_VISIT, MENTIONS_DECEASED, BOND_NAMED, WILL_WRITTEN, MEMORIAL_CARD`), tiap id dengan 3–5 varian teks, plus template kartu memorial. Konten ini **LLM offline** (ditulis sekali, disimpan di `Data/Strings.luau`, tidak pernah dipanggil LLM saat runtime — sesuai aturan §0 DESAIN).

**Gaya wajib (disamakan dengan [K] verbatim di §7.3):**
- Bracket ganda `[...]` di sekeliling tiap baris pesan sistem, sama seperti `S.STRESS_WARN`, `S.REFUSED`, dst.
- Nama hero selalu `'{name} ({stars})'`; nama hero lain yang direferensikan `'{other}'` atau `'{other} ({os})'` bila bintangnya relevan.
- Present/past tense pendek, tanpa basa-basi naratif — meniru ringkasnya string kanon ("['X' is dissatisfied with the cooking.]"), bukan gaya cerita.
- Placeholder mengikuti pola `{name}` `{stars}` `{party}` yang sudah ada di §7.3, ditambah placeholder baru yang dibutuhkan tiap id (didaftar per id di bawah).

**Variasi & determinisme (implementasi, bukan isi teks):** sesuai §7.2, pemilihan varian dari `variantIndex = hash(heroId, kind, idiosinkrasi.hb) mod n` — bukan acak murni. Ini membuat tiap hero konsisten memakai varian yang sama untuk `kind` yang sama sepanjang masa hidupnya (Han selalu varian #2 untuk `MENTIONS_DECEASED`, misalnya), sehingga terbaca sebagai "suara" pribadi, bukan template acak. Varian juga **wajib** menyisipkan nama relasi atau idiosinkrasi hero saat placeholder itu tersedia (`{other}`, `{item}`, `{hobby}`) — bukan hanya nama korban/target — sesuai instruksi §7.2.

---

## 1. STEAL — mencuri ketahuan (§6.5)

Dipicu saat aksi `mencuri` (§5.2) ketahuan (p 0,5 dasar). Placeholder: `{name}` `{stars}` `{item}` `{other}` (korban, bila diketahui pelaku).

```
S.STEAL_1 = "['{name} ({stars})' was caught taking '{item}' without permission.]"
S.STEAL_2 = "['{name} ({stars})' took '{item}' from the storage. The theft has been discovered.]"
S.STEAL_3 = "[Missing item reported: '{item}'. Investigation points to '{name} ({stars})'.]"
S.STEAL_4 = "['{name} ({stars})' quietly pocketed '{item}' belonging to '{other}'.]"
S.STEAL_5 = "['{other}' noticed that '{item}' was missing. '{name} ({stars})' is the likely culprit.]"
```

## 2. EXTORT — pemerasan (§6.5, kanon ch.158)

Dipicu saat aksi `memeras`; korban tahu pelaku tanpa roll ketahuan. Placeholder: `{name}` (pelaku) `{stars}` `{other}` (korban) `{os}` `{item}` (opsional, bila memeras barang, bukan hanya gold).

```
S.EXTORT_1 = "['{name} ({stars})' took '{item}' from '{other} ({os})' by force.]"
S.EXTORT_2 = "['{name} ({stars})' demanded payment from '{other} ({os})'. The demand was not refused.]"
S.EXTORT_3 = "['{other} ({os})' has been extorted by '{name} ({stars})'.]"
S.EXTORT_4 = "['{name} ({stars})' pressured '{other} ({os})' into handing over '{item}'.]"
```
(Catatan: `S.EXTORT` di §7.3 DESAIN adalah bentuk contoh tanpa bintang; varian di atas adalah bentuk lengkapnya.)

## 3. PROVOKE — provokasi (§6.5)

Dipicu saat aksi `provokasi`; mendahului Enmity [K] ch.49 bila berujung `a ≤ −5`. Placeholder: `{name}` `{stars}` `{other}` `{os}`.

```
S.PROVOKE_1 = "['{name} ({stars})' provoked '{other} ({os})' during training.]"
S.PROVOKE_2 = "['{name} ({stars})' and '{other} ({os})' exchanged sharp words.]"
S.PROVOKE_3 = "['{name} ({stars})' openly mocked '{other} ({os})' in front of the party.]"
S.PROVOKE_4 = "[Tension is rising between '{name} ({stars})' and '{other} ({os})'.]"
```

## 4. WENT_ALONE — inisiatif/eksplorasi otonom pergi sendiri (§5.2, §6.2, §6.3, kanon Belquist ch.218)

Dipicu saat eksplorasi otonom sukarela ATAU ringleader faksi yang diabaikan 30 hari pergi sendiri (§6.2). Placeholder: `{name}` `{stars}` `{hobby}`/`{goal}` (opsional, alasan tersirat).

```
S.WENT_ALONE_1 = "['{name} ({stars})' went out alone. No one saw which direction.]"
S.WENT_ALONE_2 = "['{name} ({stars})' left the waiting room without a word.]"
S.WENT_ALONE_3 = "['{name} ({stars})' has not been seen since yesterday. Some believe it was intentional.]"
S.WENT_ALONE_4 = "[Master hero '{name} ({stars})' departed on their own initiative.]"
```

## 5. DECLINED_POSITION — menolak jabatan (§6.11, kanon Aaron ch.347)

Dipicu saat hero ditawari jabatan tetapi goal terkuat & `aut` tinggi menolak. Placeholder: `{name}` `{stars}` `{position}`.

```
S.DECLINED_POSITION_1 = "['{name} ({stars})' declined the offer to become '{position}'.]"
S.DECLINED_POSITION_2 = "['{name} ({stars})' asked to remain a frontline fighter instead of taking '{position}'.]"
S.DECLINED_POSITION_3 = "[The position of '{position}' was offered to '{name} ({stars})' and turned down.]"
```

## 6. GRIEF_VISIT — mengunjungi Archive/memento saat berduka (§6.10, §5.2 aksi "mengenang")

Dipicu saat `loss_mode` aktif dan aksi `mengenang` dipilih. Placeholder: `{name}` `{stars}` `{deceased}` `{item}` (memento, opsional).

```
S.GRIEF_VISIT_1 = "['{name}' spent the evening at the archive, in front of '{deceased}'s belongings.]"
S.GRIEF_VISIT_2 = "['{name}' sat alone near '{deceased}'s memorial for a long while.]"
S.GRIEF_VISIT_3 = "['{name}' visited the archive again today.]"
S.GRIEF_VISIT_4 = "['{name}' held '{item}' and said nothing.]"
S.GRIEF_VISIT_5 = "['{name}' returned to the place where '{deceased}' was last seen.]"
```

## 7. MENTIONS_DECEASED — menyebut korban (§6.10, continuing bonds)

Dipicu berulang dengan p menurun (0,3 → 0,05, tidak pernah nol) selama & setelah trajektori duka. Placeholder: `{name}` `{deceased}`. Id final `MENTIONS_DECEASED` (keputusan pemilik 25 Sep 2026).

```
S.MENTIONS_DECEASED_1 = "['{name}' mentioned '{deceased}' again today.]"
S.MENTIONS_DECEASED_2 = "['{name}' brought up '{deceased}' during a quiet moment.]"
S.MENTIONS_DECEASED_3 = "['{name}' still speaks of '{deceased}' from time to time.]"
S.MENTIONS_DECEASED_4 = "[Something reminded '{name}' of '{deceased}' today.]"
```

## 8. BOND_NAMED — penamaan Bond non-summon (§6.6, sebelum flag Bond resmi §4.2)

Dipicu saat ambang Hall "dekat" (f 9–11) terlewati menuju "intim" (f ≥ 12) dan Bond terbentuk; nama Bond digenerasi dari tag/peristiwa, string ini mengumumkan penamaan itu sebagai pelengkap `S.BOND_CREATED` kanon di §7.3. Placeholder: `{a}` `{b}` `{bond}`.

```
S.BOND_NAMED_1 = "['{a}' and '{b}' have started calling their bond '{bond}'.]"
S.BOND_NAMED_2 = "[The bond between '{a}' and '{b}' is now known as '{bond}'.]"
S.BOND_NAMED_3 = "['{a}' and '{b}' have grown close enough to be remembered as '{bond}'.]"
```

## 9. WILL_WRITTEN — menulis wasiat (§6.3, kanon "hero menulis wasiat sebelum L20" ch.80)

Dipicu saat hero berflag idiosinkrasi diary & misi boss besok terjadwal. Placeholder: `{name}` `{stars}`.

```
S.WILL_WRITTEN_1 = "['{name} ({stars})' wrote something in their diary before tomorrow's mission.]"
S.WILL_WRITTEN_2 = "['{name} ({stars})' left a letter, just in case.]"
S.WILL_WRITTEN_3 = "['{name} ({stars})' spent the night writing, and said it was nothing important.]"
```
(Bila hero mati pada misi berikutnya, entri ini otomatis menjadi memento §6.10 — lihat checklist implementasi, bukan string tambahan.)

## 10. MEMORIAL_CARD — pembuka kartu memorial (§7.2 poin 4, Archive)

String pembuka singkat yang menyertai kartu memorial saat pertama kali dibuka (isi kartu sendiri = struktur §11 di bawah, bukan satu baris). Placeholder: `{name}` `{stars}`.

```
S.MEMORIAL_CARD_1 = "[A memorial card for '{name} ({stars})' has been prepared.]"
S.MEMORIAL_CARD_2 = "['{name} ({stars})' is remembered here.]"
S.MEMORIAL_CARD_3 = "[The archive now holds the record of '{name} ({stars})'.]"
```

---

## 11. Template kartu memorial (§7.2 poin 4)

Struktur (bukan satu string, tapi kumpulan field yang dirangkai UI M8 dari data hero saat mati):

```
MemorialCard = {
  name        = string,           -- nama hero
  stars       = number,           -- ★ saat mati
  serviceDays = number,           -- umur layanan (hari sejak summon s.d. mati)
  memories    = { {kind, otherName?, day}, ... },  -- 3–5 memori valensi tertinggi dari mm (§1.5), dengan siapa
  idiosyncrasy = { hobby?, food?, habit? },          -- dari IdioData (§1.4)
  namedRelations = { {name, kind}, ... },            -- relasi bernama: sahabat/Bond, murid/guru, Ikatan Sumpah
  memento     = string?,          -- barang peninggalan bila ada di storage (§6.10; kosong bila tidak disimpan)
}
```

Aturan pengisian:
- `memories`: ambil dari `mm` hero (≤10 tersimpan, §1.5), urutkan valensi tertinggi (positif dan bertanda kunci diprioritaskan), ambil 3–5. Tampilkan sebagai baris pendek, bukan angka valensi (angka tersembunyi, §0 aturan rekayasa 1).
- `namedRelations`: hanya relasi berflag (Bond/Sumpah/mentor→murid/murid→mentor), sertakan nama Bond/Sumpah bila ada (`BOND_NAMED`/`S.BOND_CREATED`).
- `memento`: kosong jika hero lantai rendah tanpa barang di storage — ini SENGAJA dipertahankan sebagai kesedihan kanon (§6.10: "hero lantai rendah tanpa barang = mati dua kali"), bukan bug yang perlu ditambal.

### Contoh 1 — hero dengan Bond, memento, kematian dini

```
[A memorial card for 'Rensa (★★)' has been prepared.]

Rensa (★★) — layanan 47 hari
- MVP bersama 'Doyle' saat misi lantai 4 (hari 22)
- Selamat dari wipe party bersama 'Doyle' dan 'Kessa' (hari 30)
- Dihibur oleh 'Doyle' setelah kalah duel (hari 41)
- Rekan mati di sisinya: 'Kessa' (hari 45)

Kebiasaan: mengumpulkan bunga kering dari tiap misi; makan sendiri di sudut plaza
Ikatan bernama: Bond "Dua Penyintas Lantai 4" dengan 'Doyle'
Peninggalan: seikat bunga kering yang tersimpan di Archive
```

### Contoh 2 — hero lantai rendah, tanpa barang tersimpan (kesedihan kanon)

```
[A memorial card for 'Torin (★)' has been prepared.]

Torin (★) — layanan 9 hari
- Selamat dari misi pertama tanpa panik (hari 3)
- Makan bersama party (hari 6)
- Rekan mati di sisinya: 'Fen' (hari 9)

Kebiasaan: bangun paling awal
Ikatan bernama: (tidak ada — belum sempat terbentuk)
Peninggalan: (tidak ada barang yang disimpan)
```

### Contoh 3 — hero senior, mentor, Ikatan Sumpah

```
[A memorial card for 'Amsari (★★★★)' has been prepared.]

Amsari (★★★★) — layanan 312 hari
- Menjadi instruktur bagi 'Padma' selama 5 bulan (hari 120–270)
- MVP berulang 6× di lantai 8–10
- Ikatan Sumpah dengan 'Reihan' dan 'Cael' (hari 88)
- Menerima gift favorit dari master saat naik lantai (hari 200)

Hobi: merawat senjata; makanan favorit: sup jahe
Ikatan bernama: Ikatan Sumpah "Saudara Seperguruan Lantai 8" dengan 'Reihan', 'Cael'; murid: 'Padma'
Peninggalan: pedang latihan pertama, disimpan oleh 'Padma'
```

---

## 12. Checklist implementasi (untuk sesi Claude Code yang memasukkan ini ke `Data/Strings.luau`)

1. Semua `S.<ID>_<n>` di atas masuk `Data/Strings.luau` dengan komentar `-- NONKANON` per baris (bukan per blok).
2. `Strings.format(id, tbl)` (`Shared/Strings.luau`, tugas 1.5 Brief Tahap 0) harus bisa mengisi semua placeholder baru di atas: `{item}` `{other}` `{os}` `{hobby}` `{goal}` `{position}` `{deceased}` `{a}` `{b}` `{bond}` — sebagian sudah ada dari §7.3, sisanya baru.
3. `variantIndex = hash(heroId, kind, idiosinkrasi.hb) mod n` — `n` = jumlah varian per id (3–5, tabel di atas mencantumkan jumlah pastinya per id).
4. `MemorialCard` dirakit oleh `Autonomy/Output.luau` (§7) saat event kematian (`alive=false` di `MissionResult`, atau sudden death §3.5) — bukan string tetap, tapi struct yang dirender UI M8 (Archive, §5.2 DESAIN_SISTEM_V0).
5. Uji verifikasi (Brief Tahap 0 tugas 4.2): kartu memorial tidak boleh memuat key tersembunyi (`tr/nd/st/ld/rl/mm` mentah) — hanya turunan yang sudah diolah (nama, kind memori, nama relasi).
