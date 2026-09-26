--!strict
-- Evaluator bentuk rumus NpcData (tabel murni): Linear = k + Σ koef·variabel; Product = base × Π Linear.
-- Variabel yang tidak ada di `vars` → error (salah ketik di data tertangkap saat dipakai).
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)

export type Vars = { [string]: number }

local Formula = {}

function Formula.linear(form: NpcData.Linear, vars: Vars): number
	local v = form.k or 0
	for key, coef in form do
		if key ~= "k" then
			v += coef * (vars[key] or error("Formula: variabel tidak dikenal " .. key))
		end
	end
	return v
end

function Formula.product(p: NpcData.Product, vars: Vars): number
	local v = p.base
	for _, f in p.factors do
		v *= Formula.linear(f, vars)
	end
	return v
end

return table.freeze(Formula)
