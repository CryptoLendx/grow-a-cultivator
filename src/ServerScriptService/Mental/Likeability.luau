--!strict
-- M0 likeability hero ke master (DESAIN_AI_NPC_V0 §3.6): 0–100, tersembunyi, awal 50.
-- Dipakai §6.3 (refusal) & §6.9 (request). Fungsi murni.
local ServerStorage = game:GetService("ServerStorage")
local NpcData = require(ServerStorage.Data.NpcData)

local L = NpcData.likeability

export type Ctx = { st: number, H: number } -- st awal hari (gift tidak bekerja saat st ≥ 70); H (greatly disappointed)
-- Peristiwa satu hari in-game; jumlah = kali kejadian hari itu.
export type Day = {
	giftMatch: number?,
	strikeAccepted: number?,
	requestGranted: number?,
	welfare: boolean?, -- Restaurant + Bathhouse tersedia
	cheering: number?,
	ritualAttended: number?, -- master menghadiri ritual duka
	giftHated: number?,
	requestDenied: number?,
	synthesisWitnessed: number?,
	punishment: number?,
	moralInjury: number?,
	floor1NoFacility: boolean?, -- lantai 1 tanpa fasilitas
}

local Likeability = {}

function Likeability.initial(): number
	return L.initial
end

function Likeability.step(like: number, ctx: Ctx, day: Day): number
	local up, down = L.up, L.down
	local v = like
	if ctx.st < L.giftMaxSt then
		v += up.giftMatch * (day.giftMatch or 0)
	end
	v += up.strikeAccepted * (day.strikeAccepted or 0)
	v += up.requestGranted * (day.requestGranted or 0)
	if day.welfare then
		v += up.welfarePerDay
	end
	v += up.cheering * (day.cheering or 0)
	v += up.ritualAttended * (day.ritualAttended or 0)
	local hated = if ctx.H < L.greatlyDisappointedMaxH then down.greatlyDisappointed else down.giftHated
	v += hated * (day.giftHated or 0)
	v += down.requestDenied * (day.requestDenied or 0)
	v += down.synthesisWitnessed * (day.synthesisWitnessed or 0)
	v += down.punishment * (day.punishment or 0)
	v += down.moralInjury * (day.moralInjury or 0)
	if day.floor1NoFacility then
		v += down.floor1NoFacilityPerDay
	end
	return math.clamp(v, L.min, L.max)
end

return table.freeze(Likeability)
