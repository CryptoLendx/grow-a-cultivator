Terakhir diperbarui: 25 September 2026, 20:40 WIB

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
| 9 | `FAIL_LAST_CHANCE` | `[If you fail this time, all heroes belonging to '{party}' will be destroyed...]` | "…belonging to '1st party' will be destroyed..." | [K] ch.167 | **[INFERENSI]** Id terpotong "1st party…" di laporan Claude Code diduga mengacu ke string ini — Claude Code wajib mencocokkan dengan konteks asal di DESAIN_SISTEM sebelum memakai. "..." ada di sumber kanon. Didahului `[※Caution!]` `[This is your last chance.]` (ch.167) |

**String lain yang juga terpotong di sumber kanon** (tidak termasuk 9 di atas, dicatat supaya tidak dicari ulang): `[Tips/If there are many heroes dissatisfied with the cooking...]` [K] ch.16; `[Tips/After completing the in-depth dungeon research, the hero's stay time will incr…]` [K] ch.67. Keduanya dipakai apa adanya.

**Id terkait NONKANON:** id final `MENTIONS_DECEASED` (bukan `MENTIONS_DEAD`); teks 10 id NONKANON ada di `Data_Strings_NONKANON.md`.
