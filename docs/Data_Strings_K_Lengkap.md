Terakhir diperbarui: 26 September 2026, 00:46 WIB

# DATA STRINGS [K] — TEKS UTUH UNTUK 9 STRING YANG TERPOTONG DI DESAIN_SISTEM_V0

Pelengkap `Data/Strings.luau` (tugas §B 1.5). Di DESAIN_SISTEM_V0, sembilan string [K] ditulis terpotong ("…"), sehingga Claude Code tidak memasukkannya (LAPORAN minggu 1 §4.1 butir 7). Teks utuh di bawah diambil dari KANON_PMU_01/04/05 dan KANON_PMU_RAW_1/2 (sumber primer project). Placeholder `{…}` menggantikan nama/angka contoh dari kanon.

**Catatan penting:** 4 dari 9 string berakhir dengan "..." **di teks kanonnya sendiri** — novel memotongnya, bukan hasil ekstraksi kita. Untuk string itu, "..." bagian dari teks verbatim dan tetap ditulis apa adanya. Kelanjutan teksnya **tidak ditemukan** di ekstraksi novel ch.1–400 (keterbatasan sumber, bukan bukti bahwa kelanjutannya tidak ada).

| # | Id usulan | Teks verbatim (dengan placeholder) | Contoh asli di kanon | Label & sitasi | Catatan |
|---|---|---|---|---|---|
| 1 | `FACILITY_BUILT` | `[The {facility} has been completed!]` | "[The Magic Lab has been completed! Research is open.]" (ch.24); "[The training center has been completed...]" (ch.8) | [K] ch.24 (bentuk utuh); ch.8 terpotong di sumber | [ASUMSI] pola ch.24 dipakai sebagai template. Kalimat lanjutan per fasilitas (mis. "Research is open.") dimasukkan sebagai string terpisah per fasilitas bila dibutuhkan |
| 2 | `FACILITY_MANAGER` | `[Manager in charge: {names}]` | "[Manager in charge: 'Chloe(★)' 'Amarin(★)']" | [K] ch.64 | `{names}` = daftar `'{name}({stars})'` dipisah spasi, maks 2 (asisten maks 2/fasilitas [N] ch.30) |
| 3 | `FOOD_TYPES` | `[Possible food types: {foods}....]` | "[Possible food types: meat, potato, fruit....]" | [K] ch.64 | "...." (empat titik) ada di sumber kanon; [ASUMSI] dipertahankan sebagai bagian teks |
| 4 | `BUSINESS_REPORT` | `[A business report has been received from Submaster '{name}({stars})'. Do you want to check?]` diikuti `[Yes (optional) / No]` | "…from Submaster 'Han(★★★★★)'…" | [K] ch.268 | Isi laporan (pangan, kayu, bijih, usulan, tren) = [N] ch.268; format isi → DESAIN_AI_NPC §7.2 butir 5 |
| 5 | `PARTY_INSUFFICIENT` | `[If the number of party members is insufficient, use paid summons or free summons to recruit heroes!]` | sama | [K] ch.114, 274 | tanpa placeholder |
| 6 | `REQ_MOCK_BATTLE` | `[Master '{name}({stars})' proposes a mock battle. Do you accept it?]` | "[Master 'Han(★★★)' proposes a mock battle. Do you accept it?]" | [K] ch.148, 166 | "Master" = gelar hero di kanon, bukan pemain |
| 7 | `GIFT_GREATLY_DISAPPOINTED` | `['{name} ({stars})' is greatly disappointed after receiving the '{item}'.]` diikuti `[Likeness has drastically decreased!]` | "['Han (★★★)' is greatly disappointed after receiving the 'White Horse Statue'.]" | [K] ch.107 | Spasi sebelum "(★)" mengikuti sumber |
| 8 | `TIPS_REST` | `[Tips/Continuous battles tire the hero. You need to take proper rest...]` | sama | [K] ch.8 | "..." ada di sumber kanon; kelanjutan tidak ditemukan |
| 9 | `FAIL_LAST_CHANCE` | `[If you fail this time, all heroes belonging to '{party}' will be destroyed...]` | "…belonging to '1st party' will be destroyed..." | [K] ch.167 | String ini tetap dipakai (teks [K] sah). Dugaan awal bahwa potongan "1st party…" di DESAIN_SISTEM mengacu ke string ini **keliru** (dicek Claude Code 25 Sep) — potongan itu adalah pengumuman penempatan lantai ch.65, lihat #10–#12. "..." ada di sumber kanon. Didahului `[※Caution!]` `[This is your last chance.]` (ch.167) |
| 10 | `FLOOR_ASSIGN_PARTY` | `[{party} is all on the {floor} floor...]` | "[1st party is all on the 2nd floor...]" | [K] ch.65 (KANON_PMU_RAW_1) | Pengumuman master saat hierarki lantai dibuat (pemicu mass strike ch.65). "..." ada di teks sumber; kelanjutan tidak ditemukan. [ASUMSI] `{party}` & `{floor}` diisi bentuk ordinal Inggris ("1st party", "2nd") |
| 11 | `FLOOR_ASSIGN_NAMES` | `[{names}. You guys are also on the {floor} floor.]` | "[Chloe Enoch Alter Patrick Amarin. You guys are also on the second floor.]" | [K] ch.65 | `{names}` = nama dipisah spasi tanpa bintang (sesuai sumber); sumber memakai "second" (kata), bukan "2nd" — [ASUMSI] `{floor}` bebas bentuk |
| 12 | `FLOOR_ASSIGN_REST` | `[Everything else is on the {floor} floor.]` | "[Everything else is on the first floor.]" | [K] ch.65 | — |
| 13 | `ROOM_HEADCOUNT` | `[Currently, there are {n} people in the waiting room... Master's instructions are...]` | "[Currently, there are 35 people in the waiting room... Master's instructions are...]" | [K] ch.65 | Pembuka pengumuman #10–#12; "..." ada di sumber |

**String lain yang juga terpotong di sumber kanon** (tidak termasuk 9 di atas, dicatat supaya tidak dicari ulang): `[Tips/If there are many heroes dissatisfied with the cooking...]` [K] ch.16; `[Tips/After completing the in-depth dungeon research, the hero's stay time will incr…]` [K] ch.67. Keduanya dipakai apa adanya.

**Id terkait NONKANON:** id final `MENTIONS_DECEASED` (bukan `MENTIONS_DEAD`); teks 10 id NONKANON ada di `Data_Strings_NONKANON.md`.
