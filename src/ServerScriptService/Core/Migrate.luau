--!strict
-- Migrasi `schemaVersion` per jenis key profil (RISET_Batas_Teknis §4.5).
-- Menambah versi: naikkan CURRENT[kind] lalu tambahkan STEPS[kind][versiLama] (v → v+1) + test-nya.

export type Kind = "core" | "heroes" | "archive" | "replays" | "mail"
export type Data = { [string]: any }

local Migrate = {}

local CURRENT: { [Kind]: number } = {
	core = 2,
	heroes = 1,
	archive = 1,
	replays = 1,
	mail = 1,
}

-- Versi skema terkini untuk satu jenis key.
function Migrate.current(kind: Kind): number
	local version = CURRENT[kind]
	assert(version ~= nil, "Migrate: jenis key tidak dikenal " .. tostring(kind))
	return version
end

-- STEPS[kind][v] mengubah data versi v menjadi v+1 (in-place).
local STEPS: { [Kind]: { [number]: (Data) -> () } } = {
	core = {
		-- DUMMY v1→v2 (tugas 1.4): menguji jalur migrasi. `lastSeen` = detik UTC logout terakhir,
		-- dipakai catch-up saat login (RENCANA §3.2).
		[1] = function(data: Data)
			if data.lastSeen == nil then
				data.lastSeen = 0
			end
		end,
	},
	heroes = {},
	archive = {},
	replays = {},
	mail = {},
}

-- Membawa `data` ke CURRENT[kind]. Data tanpa `schemaVersion` dianggap v1.
-- Mengembalikan data yang sama (dimutasi) dan jumlah langkah yang dijalankan.
function Migrate.run(kind: Kind, data: Data): (Data, number)
	local current = Migrate.current(kind)
	local version = data.schemaVersion or 1
	if version > current then
		error(string.format("Migrate: %s v%d lebih baru dari kode (v%d)", kind, version, current), 2)
	end
	local applied = 0
	while version < current do
		local step = STEPS[kind][version]
		assert(step ~= nil, string.format("Migrate: langkah %s v%d→v%d tidak ada", kind, version, version + 1))
		step(data)
		version += 1
		applied += 1
	end
	data.schemaVersion = version
	return data, applied
end

return Migrate
