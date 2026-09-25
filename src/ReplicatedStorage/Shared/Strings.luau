--!strict
-- Util pesan sistem: `Strings.format(id, args)` mengisi placeholder `{key}` dari Data/Strings.
-- Semua modul memakai ini, tidak meng-hardcode teks.

local StringsData = require(script.Parent.Parent.Data.Strings)

export type Args = { [string]: any } -- nilai placeholder (string/angka), di-tostring

local Strings = {}

-- Teks mentah untuk `id`; error bila id tidak ada.
function Strings.get(id: string): string
	local text = StringsData[id]
	if text == nil then
		error("Strings: id tidak dikenal " .. tostring(id), 2)
	end
	return text
end

-- Nama placeholder unik di teks `id`, urut kemunculan.
function Strings.placeholders(id: string): { string }
	local keys, seen = {}, {}
	for key in string.gmatch(Strings.get(id), "{(%w+)}") do
		if not seen[key] then
			seen[key] = true
			table.insert(keys, key)
		end
	end
	return keys
end

-- Teks `id` dengan semua `{key}` diganti `args[key]`; error bila ada placeholder tanpa nilai.
function Strings.format(id: string, args: Args?): string
	local text = Strings.get(id)
	local result = string.gsub(text, "{(%w+)}", function(key: string): string
		local value = args and args[key]
		if value == nil then
			error(string.format("Strings.format(%s): placeholder {%s} tidak diisi", id, key), 3)
		end
		return tostring(value)
	end)
	return result
end

return Strings
