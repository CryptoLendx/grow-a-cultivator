-- Menjalankan semua *.spec di ServerStorage.Tests dengan TestEZ.
-- Pemakaian: run-in-roblox --place build/test.rbxl --script tests/run.server.luau
-- (atau tempel ke command bar Studio). Headless tanpa Studio: `lune run tools/testrunner.luau`.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local TestEZ = require(ReplicatedStorage.DevPackages.TestEZ)

local results = TestEZ.TestBootstrap:run({ ServerStorage.Tests })

if results.failureCount > 0 or #results.errors > 0 then
	error(string.format("TEST GAGAL: %d gagal, %d error", results.failureCount, #results.errors))
end
