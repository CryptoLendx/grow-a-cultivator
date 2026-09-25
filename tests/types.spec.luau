--!strict
-- Contoh nilai lengkap yang harus lolos type-check --!strict (luau-lsp analyze).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Types = require(ReplicatedStorage.Shared.Types)

type HeroInput = Types.HeroInput
type MissionRequest = Types.MissionRequest
type MissionResult = Types.MissionResult

return function()
	describe("Shared/Types", function()
		it("contoh MissionRequest & MissionResult sesuai kontrak", function()
			local hero: HeroInput = {
				heroId = "h1",
				star = 1,
				level = 1,
				class = "Novice",
				stats = { STR = 10, INT = 10, STA = 10, AGI = 10 },
				skills = { { skillId = "LesserSwordsmanship", tier = "Lesser", level = 1 } },
				equipment = { { slot = "weapon", grade = "E" } },
				statusEffects = {},
				consumables = { { itemId = "LowLifePotion", qty = 1 } },
				hidden = {
					fearResistance = 0.5,
					stressBand = 0,
					bondWith = {},
					enmityWith = {},
					compatibility = { h2 = 0.5 },
				},
				appearance = {
					rig = "warrior_m",
					layers = { face = "face_01", hairBack = "hb_01" },
					tints = { skin = 1, hair = 2, primary = 3, secondary = 4, accent = 5 },
				},
			}
			local request: MissionRequest = {
				seed = 12345,
				floor = {
					missionType = "annihilation",
					objective = "Defeat all goblins",
					enemies = { { enemyId = "goblin", level = 1, count = 5, wave = 1 } },
					terrainId = "plain",
					timerSec = nil,
					partyScale = 1,
					rewardGold = 7000,
					rewardMaterials = {},
					retryCount = 0,
				},
				parties = { { partyId = "p1", leaderHeroId = "h1", heroes = { hero }, role = "advance" } },
				tactics = { waypoints = { { partyId = "p1", point = { x = 1, y = 2 } } } },
				tacticalPostLevel = 0,
				battleShopBudget = 0,
				cheeringEnabled = false,
				mode = "headless",
			}
			local result: MissionResult = {
				outcome = "clear",
				durationSec = 60,
				objectiveFinal = request.floor.objective,
				heroes = {
					h1 = {
						alive = true,
						damageDealt = 10,
						damageTaken = 3,
						contribution = 1,
						statusEffectsEnd = {},
						consumablesUsed = { LowLifePotion = 1 },
						equipmentLost = false,
						skillUses = { LesserSwordsmanship = 4 },
						awakeningEvents = {},
					},
				},
				mvpHeroId = "h1",
				expEligibleHeroIds = { "h1" },
				rewardGold = 7000,
				rewardMaterials = { { itemId = "iron_ore", qty = 2 } },
				battleShopSpent = 0,
				log = { { timeSec = 0, kind = "MissionStarted" } },
			}
			expect(result.heroes.h1.alive).to.equal(true)
			expect(#request.parties[1].heroes).to.equal(1)
		end)
	end)
end
