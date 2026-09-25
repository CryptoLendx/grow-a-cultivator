--!strict
-- DIHASILKAN oleh tools/sheet2luau.py dari assets/sheet.example.json — JANGAN diedit manual.
-- Katalog lapisan hero (potret 192x256 & sprite 48x64 x12 frame per lapisan); tint false = tanpa tint. Format: docs/sheet_format.md. assetId 0 = PNG belum di-upload ke grup Roblox.

export type Animation = { first: number, count: number, fps: number, loop: boolean }
export type Size = { w: number, h: number }
export type Point = { x: number, y: number }
export type Slot = { depth: number, tint: string | false, required: boolean }
export type Layer = {
	slot: string,
	rigs: { string },
	tint: string | false,
	portraitAssetId: number,
	spriteAssetId: number,
}
export type AppearanceData = {
	canvas: { portrait: Size, sprite: { w: number, h: number, frames: number } },
	anchor: Point,
	animations: { [string]: Animation },
	rigs: { string },
	slots: { [string]: Slot },
	layers: { [string]: Layer },
	palettes: { [string]: { string } },
}

local AppearanceData: AppearanceData = {
	anchor = {
		x = 24,
		y = 62,
	},
	animations = {
		attack = {
			count = 4,
			first = 9,
			fps = 10,
			loop = false,
		},
		idle = {
			count = 4,
			first = 1,
			fps = 6,
			loop = true,
		},
		walk = {
			count = 4,
			first = 5,
			fps = 8,
			loop = true,
		},
	},
	canvas = {
		portrait = {
			h = 256,
			w = 192,
		},
		sprite = {
			frames = 12,
			h = 64,
			w = 48,
		},
	},
	layers = {
		aura_star3 = {
			portraitAssetId = 0,
			rigs = {
				"f",
				"m",
			},
			slot = "aura",
			spriteAssetId = 0,
			tint = false,
		},
		clothes_robe01 = {
			portraitAssetId = 0,
			rigs = {
				"f",
				"m",
			},
			slot = "clothes",
			spriteAssetId = 0,
			tint = "primary",
		},
		clothes_robe01_trim = {
			portraitAssetId = 0,
			rigs = {
				"f",
				"m",
			},
			slot = "clothes",
			spriteAssetId = 0,
			tint = "secondary",
		},
		eyes_01 = {
			portraitAssetId = 0,
			rigs = {
				"f",
				"m",
			},
			slot = "eyes",
			spriteAssetId = 0,
			tint = false,
		},
		face_01 = {
			portraitAssetId = 0,
			rigs = {
				"f",
				"m",
			},
			slot = "face",
			spriteAssetId = 0,
			tint = false,
		},
		hairBack_01 = {
			portraitAssetId = 0,
			rigs = {
				"f",
				"m",
			},
			slot = "hairBack",
			spriteAssetId = 0,
			tint = "hair",
		},
		hairFront_01 = {
			portraitAssetId = 0,
			rigs = {
				"f",
				"m",
			},
			slot = "hairFront",
			spriteAssetId = 0,
			tint = "hair",
		},
		skin_f01 = {
			portraitAssetId = 0,
			rigs = {
				"f",
			},
			slot = "skin",
			spriteAssetId = 0,
			tint = "skin",
		},
		skin_m01 = {
			portraitAssetId = 0,
			rigs = {
				"m",
			},
			slot = "skin",
			spriteAssetId = 0,
			tint = "skin",
		},
		weapon_sword01 = {
			portraitAssetId = 0,
			rigs = {
				"f",
				"m",
			},
			slot = "weapon",
			spriteAssetId = 0,
			tint = false,
		},
	},
	palettes = {
		accent = {
			"B22222",
			"228B22",
		},
		hair = {
			"1B1B1B",
			"4B3621",
			"A0522D",
		},
		primary = {
			"2F4F4F",
			"8B0000",
			"F5F5DC",
		},
		secondary = {
			"DAA520",
			"C0C0C0",
		},
		skin = {
			"F1C27D",
			"E0AC69",
			"C68642",
			"8D5524",
		},
	},
	rigs = {
		"f",
		"m",
	},
	slots = {
		accessory = {
			depth = 700,
			required = false,
			tint = "accent",
		},
		aura = {
			depth = 10,
			required = false,
			tint = false,
		},
		clothes = {
			depth = 300,
			required = true,
			tint = "primary",
		},
		eyes = {
			depth = 500,
			required = true,
			tint = false,
		},
		face = {
			depth = 400,
			required = true,
			tint = false,
		},
		hairBack = {
			depth = 100,
			required = false,
			tint = "hair",
		},
		hairFront = {
			depth = 600,
			required = true,
			tint = "hair",
		},
		skin = {
			depth = 200,
			required = true,
			tint = "skin",
		},
		weapon = {
			depth = 800,
			required = false,
			tint = false,
		},
	},
}

return AppearanceData
