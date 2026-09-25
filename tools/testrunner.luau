--[[
	Runner test headless (tanpa Roblox Studio) untuk CLI/CI: `lune run tools/testrunner.luau`.

	Membangun pohon Instance tiruan dari default.project.json (hanya node `$path`/`$className`),
	lalu menjalankan semua ModuleScript `*.spec` di ServerStorage.Tests dengan subset API TestEZ
	(describe/it/expect). Kode game tetap memakai `require(script.Parent.X)` dan
	`game:GetService(...)` biasa. Yang didukung hanya yang dipakai modul pure-Luau:
	Name/Parent/ClassName, FindFirstChild, WaitForChild, GetChildren, GetDescendants,
	GetFullName, IsA, dan HttpService:JSONEncode (pendekatan; ukuran byte final diverifikasi di Studio).

	Runner resmi tetap tests/run.server.luau (TestEZ asli via run-in-roblox / Studio).
]]

local fs = require("@lune/fs")
local luau = require("@lune/luau")
local process = require("@lune/process")
local serde = require("@lune/serde")

local ROOT = string.gsub(process.cwd, "/$", "")
local realEnv = getfenv(1)

---------------------------------------------------------------- pohon Instance tiruan

type Node = {
	Name: string,
	ClassName: string,
	Parent: Node?,
	children: { Node },
	file: string?,
}

local proxies: { [Node]: any } = {}
local nodeOf: { [any]: Node } = {}
local wrap: (Node) -> any

local function newNode(name: string, className: string, parent: Node?, file: string?): Node
	local node: Node = { Name = name, ClassName = className, Parent = parent, children = {}, file = file }
	if parent then
		table.insert(parent.children, node)
	end
	return node
end

local function findChild(node: Node, name: string): Node?
	for _, child in node.children do
		if child.Name == name then
			return child
		end
	end
	return nil
end

local function fullName(node: Node): string
	if node.Parent == nil or node.Parent.ClassName == "DataModel" then
		return node.Name
	end
	return fullName(node.Parent) .. "." .. node.Name
end

local function addDescendants(node: Node, out: { any })
	for _, child in node.children do
		table.insert(out, wrap(child))
		addDescendants(child, out)
	end
end

local methods = {}
function methods.FindFirstChild(self, name: string)
	local child = findChild(nodeOf[self], name)
	return child and wrap(child)
end
function methods.WaitForChild(self, name: string)
	local child = findChild(nodeOf[self], name)
	if not child then
		error(`Infinite yield: {name} tidak ada di {fullName(nodeOf[self])}`, 2)
	end
	return wrap(child)
end
function methods.GetChildren(self)
	local out = {}
	for _, child in nodeOf[self].children do
		table.insert(out, wrap(child))
	end
	return out
end
function methods.GetDescendants(self)
	local out = {}
	addDescendants(nodeOf[self], out)
	return out
end
function methods.GetFullName(self)
	return fullName(nodeOf[self])
end
function methods.IsA(self, className: string)
	return nodeOf[self].ClassName == className
end
function methods.GetService(self, name: string)
	return methods.WaitForChild(self, name)
end

local InstanceMeta = {}
function InstanceMeta.__index(self, key: string)
	local node = nodeOf[self]
	if key == "Name" or key == "ClassName" then
		return node[key]
	elseif key == "Parent" then
		return node.Parent and wrap(node.Parent)
	elseif methods[key] then
		return methods[key]
	end
	local child = findChild(node, key)
	if child then
		return wrap(child)
	end
	error(`{key} is not a valid member of {node.ClassName} "{fullName(node)}"`, 2)
end
function InstanceMeta.__tostring(self)
	return nodeOf[self].Name
end

wrap = function(node: Node): any
	local proxy = proxies[node]
	if not proxy then
		proxy = setmetatable({}, InstanceMeta)
		proxies[node] = proxy
		nodeOf[proxy] = node
	end
	return proxy
end

-- Pemetaan berkas → Instance mengikuti aturan Rojo untuk .luau.
local function mapDir(dirPath: string, node: Node)
	local entries = fs.readDir(dirPath)
	table.sort(entries)
	for _, entry in entries do
		local path = dirPath .. "/" .. entry
		if fs.isDir(path) then
			mapDir(path, newNode(entry, "Folder", node))
		else
			local base = string.match(entry, "^(.+)%.luau$")
			if base then
				local name, kind = string.match(base, "^(.+)%.(server)$")
				if not name then
					name, kind = string.match(base, "^(.+)%.(client)$")
				end
				local className = if kind == "server"
					then "Script"
					elseif kind == "client" then "LocalScript"
					else "ModuleScript"
				newNode(name or base, className, node, path)
			end
		end
	end
end

local function mapTree(tree: { [string]: any }, node: Node)
	local path = tree["$path"]
	if type(path) == "table" then
		path = path.optional -- {"optional": "Packages"}: boleh tidak ada
	end
	if path then
		local full = ROOT .. "/" .. path
		if fs.isDir(full) then
			mapDir(full, node)
		end
	end
	for key, value in tree do
		if string.sub(key, 1, 1) ~= "$" then
			local className = value["$className"] or "Folder"
			mapTree(value, newNode(key, className, node))
		end
	end
end

local project = serde.decode("json", fs.readFile(ROOT .. "/default.project.json"))
local gameNode = newNode("Game", "DataModel", nil)
mapTree(project.tree, gameNode)

---------------------------------------------------------------- HttpService tiruan

local function jsonEncode(value: any): string
	local t = typeof(value)
	if t == "nil" then
		return "null"
	elseif t == "boolean" then
		return tostring(value)
	elseif t == "number" then
		if value == math.floor(value) and math.abs(value) < 2 ^ 53 then
			return string.format("%d", value)
		end
		return tostring(value)
	elseif t == "string" then
		local escaped = string.gsub(value, '[%c"\\]', function(c)
			local map = { ['"'] = '\\"', ["\\"] = "\\\\", ["\n"] = "\\n", ["\r"] = "\\r", ["\t"] = "\\t" }
			return map[c] or string.format("\\u%04x", string.byte(c))
		end)
		return '"' .. escaped .. '"'
	elseif t == "table" then
		local n = #value
		local count = 0
		for _ in value do
			count += 1
		end
		local parts = {}
		if count == n and n > 0 then
			for i = 1, n do
				parts[i] = jsonEncode(value[i])
			end
			return "[" .. table.concat(parts, ",") .. "]"
		end
		for k, v in value do
			table.insert(parts, jsonEncode(tostring(k)) .. ":" .. jsonEncode(v))
		end
		if #parts == 0 then
			return "[]" -- Roblox meng-encode tabel kosong sebagai []
		end
		return "{" .. table.concat(parts, ",") .. "}"
	end
	error("JSONEncode: tipe tidak didukung " .. t)
end

local HttpService = newNode("HttpService", "HttpService", gameNode)
local game = wrap(gameNode)

-- HttpService tiruan: node kosong + metode JSONEncode.
local httpProxy = wrap(HttpService)
methods.JSONEncode = function(self, value)
	assert(self == httpProxy, "JSONEncode hanya di HttpService")
	return jsonEncode(value)
end
methods.JSONDecode = function(self, text)
	assert(self == httpProxy, "JSONDecode hanya di HttpService")
	return serde.decode("json", text)
end

---------------------------------------------------------------- require

local cache: { [Node]: any } = {}
local loading: { [Node]: boolean } = {}

local function makeEnv(scriptProxy: any, extra: { [string]: any }?)
	local env = {
		script = scriptProxy,
		game = game,
		require = nil :: any,
	}
	if extra then
		for k, v in extra do
			env[k] = v
		end
	end
	return setmetatable(env, { __index = realEnv })
end

local function requireModule(target: any)
	local node = nodeOf[target]
	assert(node and node.ClassName == "ModuleScript", "require: bukan ModuleScript")
	if cache[node] ~= nil then
		return cache[node]
	end
	assert(not loading[node], "require melingkar: " .. fullName(node))
	loading[node] = true
	local env = makeEnv(target)
	env.require = requireModule
	local chunk = luau.load(fs.readFile(node.file :: string), { debugName = node.file, environment = env })
	local result = chunk()
	loading[node] = nil
	cache[node] = result
	return result
end

---------------------------------------------------------------- subset TestEZ

local function fmt(v: any): string
	if type(v) == "string" then
		return string.format("%q", v)
	end
	return tostring(v)
end

local function makeExpect(actual: any)
	local negated = false
	local api = {}
	local function check(ok: boolean, msg: string)
		if negated then
			ok = not ok
			msg = "NOT " .. msg
		end
		if not ok then
			error(msg, 3)
		end
	end
	function api.equal(expected)
		check(actual == expected, `expected {fmt(expected)}, got {fmt(actual)}`)
	end
	function api.ok()
		check(actual ~= nil and actual ~= false, `expected truthy, got {fmt(actual)}`)
	end
	function api.near(expected, limit)
		limit = limit or 1e-7
		check(math.abs(actual - expected) <= limit, `expected {fmt(expected)} ±{limit}, got {fmt(actual)}`)
	end
	function api.a(typeName)
		check(typeof(actual) == typeName, `expected type {typeName}, got {typeof(actual)}`)
	end
	api.an = api.a
	function api.throw(substring)
		local ok, err = pcall(actual)
		local matched = not ok and (substring == nil or string.find(tostring(err), substring, 1, true) ~= nil)
		check(
			matched,
			`expected throw{substring and (" containing " .. fmt(substring)) or ""}, got {ok and "no error" or tostring(
				err
			)}`
		)
	end
	local proxy
	proxy = setmetatable({}, {
		__index = function(_, key)
			if key == "to" or key == "be" or key == "been" or key == "have" or key == "was" or key == "at" then
				return proxy
			elseif key == "never" then
				negated = not negated
				return proxy
			end
			return api[key] or error("expect: matcher tidak didukung: " .. tostring(key), 2)
		end,
	})
	return proxy
end

local passed, failed = 0, 0
local failures = {}
local prefix = {}

local function describe(name: string, fn: () -> ())
	table.insert(prefix, name)
	fn()
	table.remove(prefix)
end

local function it(name: string, fn: () -> ())
	local label = table.concat(prefix, " > ") .. " > " .. name
	local t0 = os.clock()
	local ok, err = pcall(fn)
	local ms = (os.clock() - t0) * 1000
	if ok then
		passed += 1
		print(string.format("  [OK]   %s (%.0f ms)", label, ms))
	else
		failed += 1
		print(string.format("  [GAGAL] %s\n         %s", label, tostring(err)))
		table.insert(failures, label)
	end
end

---------------------------------------------------------------- jalankan

local testsRoot = nodeOf[game:GetService("ServerStorage").Tests]
local filter = process.args[1]

local specs = {}
for _, inst in wrap(testsRoot):GetDescendants() do
	local node = nodeOf[inst]
	if node.ClassName == "ModuleScript" and string.match(node.Name, "%.spec$") then
		if filter == nil or string.find(node.Name, filter, 1, true) then
			table.insert(specs, node)
		end
	end
end
table.sort(specs, function(a, b)
	return (a.file :: string) < (b.file :: string)
end)

for _, node in specs do
	print(fullName(node))
	local env = makeEnv(wrap(node), { describe = describe, it = it, expect = makeExpect })
	env.require = requireModule
	local ok, err = pcall(function()
		local specFn = luau.load(fs.readFile(node.file :: string), { debugName = node.file, environment = env })()
		specFn()
	end)
	if not ok then
		failed += 1
		print("  [ERROR] " .. tostring(err))
		table.insert(failures, fullName(node) .. " (error saat memuat)")
	end
end

for _, label in failures do
	print("GAGAL: " .. label)
end
print(string.format("\n%d lulus, %d gagal, %d spec", passed, failed, #specs))
process.exit(if failed == 0 and #specs > 0 then 0 else 1)
