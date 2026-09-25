--!strict
-- Data/AppearanceData & Data/SpriteData (hasil tools/sheet2luau.py) termuat dan konsisten.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AppearanceData = require(ReplicatedStorage.Data.AppearanceData)
local SpriteData = require(ReplicatedStorage.Data.SpriteData)

return function()
	describe("Data/AppearanceData + Data/SpriteData", function()
		it("kanvas 192x256 / 48x64 dan animasi hero menutup 12 frame", function()
			expect(AppearanceData.canvas.portrait.w).to.equal(192)
			expect(AppearanceData.canvas.portrait.h).to.equal(256)
			expect(AppearanceData.canvas.sprite.w).to.equal(48)
			expect(AppearanceData.canvas.sprite.h).to.equal(64)
			local total = 0
			for _, anim in AppearanceData.animations do
				total += anim.count
			end
			expect(total).to.equal(AppearanceData.canvas.sprite.frames)
		end)

		it("setiap lapisan menunjuk slot yang ada; slot wajib punya lapisan per rig", function()
			for _, layer in AppearanceData.layers do
				expect(AppearanceData.slots[layer.slot] ~= nil).to.equal(true)
			end
			for slotId, slot in AppearanceData.slots do
				if slot.required then
					for _, rig in AppearanceData.rigs do
						local found = false
						for _, layer in AppearanceData.layers do
							if layer.slot == slotId and table.find(layer.rigs, rig) then
								found = true
							end
						end
						expect(found).to.equal(true)
					end
				end
			end
		end)

		it("palet 5 kanal tint terisi", function()
			for _, channel in { "skin", "hair", "primary", "secondary", "accent" } do
				expect(#AppearanceData.palettes[channel] > 0).to.equal(true)
			end
		end)

		it("sprite punya frame, jangkar di dalam frame, animasi dalam rentang", function()
			for _, sprite in SpriteData do
				expect(sprite.anchor.x < sprite.frame.w and sprite.anchor.y < sprite.frame.h).to.equal(true)
				for _, anim in sprite.animations do
					expect(anim.first + anim.count - 1 <= sprite.frames).to.equal(true)
				end
			end
		end)
	end)
end
