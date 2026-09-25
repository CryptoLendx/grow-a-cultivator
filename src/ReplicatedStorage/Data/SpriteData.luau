--!strict
-- DIHASILKAN oleh tools/sheet2luau.py dari assets/sheet.example.json — JANGAN diedit manual.
-- Spritesheet musuh/boss/NPC/bangunan/VFX. Format: docs/sheet_format.md. assetId 0 = PNG belum di-upload ke grup Roblox.

export type Animation = { first: number, count: number, fps: number, loop: boolean }
export type Sprite = {
	category: string,
	assetId: number,
	frame: { w: number, h: number },
	columns: number,
	frames: number,
	anchor: { x: number, y: number },
	animations: { [string]: Animation },
}

local SpriteData: { [string]: Sprite } = {
	goblin = {
		anchor = {
			x = 24,
			y = 62,
		},
		animations = {
			attack = {
				count = 4,
				first = 5,
				fps = 10,
				loop = false,
			},
			idle = {
				count = 4,
				first = 1,
				fps = 6,
				loop = true,
			},
		},
		assetId = 0,
		category = "enemy",
		columns = 8,
		frame = {
			h = 64,
			w = 48,
		},
		frames = 8,
	},
	training_center_lv1 = {
		anchor = {
			x = 96,
			y = 150,
		},
		animations = {
			idle = {
				count = 1,
				first = 1,
				fps = 1,
				loop = true,
			},
		},
		assetId = 0,
		category = "building",
		columns = 1,
		frame = {
			h = 160,
			w = 192,
		},
		frames = 1,
	},
}

return SpriteData
