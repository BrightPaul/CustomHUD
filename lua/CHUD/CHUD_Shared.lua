kCHUDElixerVersion = 1.72
Script.Load("lua/CHUD/Elixer_Utility.lua")
Elixer.UseVersion( kCHUDElixerVersion ) 


kCHUDStatsTrackAccLookup =
	set {
		kTechId.Pistol, kTechId.Rifle, kTechId.Minigun, kTechId.Railgun, kTechId.Shotgun,
		kTechId.Axe, kTechId.Bite, kTechId.Parasite, kTechId.Spit, kTechId.Swipe, kTechId.Gore,
		kTechId.LerkBite, kTechId.Spikes, kTechId.Stab
	}

// CompMod v3 compat.
if rawget( kTechId, "HeavyMachineGun" ) then
	kCHUDStatsTrackAccLookup[kTechId.HeavyMachineGun] = true
end


local kCHUDDamageMessage =
{
	posx = string.format("float (%d to %d by 0.05)", -kHitEffectMaxPosition, kHitEffectMaxPosition),
	posy = string.format("float (%d to %d by 0.05)", -kHitEffectMaxPosition, kHitEffectMaxPosition),
	posz = string.format("float (%d to %d by 0.05)", -kHitEffectMaxPosition, kHitEffectMaxPosition),
	targetId = "entityid",
	amount = "integer (1 to 1000)",
	overkill = "integer (1 to 1000)",
}


kHitsoundMode = enum { 'Hitcount', 'Overkill' }
kCHUDDamage2MessageMaxHitCount = 13
local kCHUDDamage2Message =
{
	posx = string.format("float (%d to %d by 0.05)", -kHitEffectMaxPosition, kHitEffectMaxPosition),
	posy = string.format("float (%d to %d by 0.05)", -kHitEffectMaxPosition, kHitEffectMaxPosition),
	posz = string.format("float (%d to %d by 0.05)", -kHitEffectMaxPosition, kHitEffectMaxPosition),
	targetId = "entityid",
	amount = "integer (1 to 1000)",
	overkill = "integer (1 to 1000)",
	hitcount = string.format( "integer (1 to %d)", kCHUDDamage2MessageMaxHitCount ),
	mode = "enum kHitsoundMode"
}	
	

local kCHUDDeathStatsMessage =
{
	lastAcc = "integer (0 to 100)",
	currentAcc = "integer (0 to 100)",
	pdmg = "float (0 to 500000 by 0.01)",
	sdmg = "float (0 to 500000 by 0.01)",
}

local kCHUDOptionMessage =
{
	disabledOption = "string (32)"
}

local kCHUDAutopickupMessage =
{
	autoPickup = "boolean",
	autoPickupBetter = "boolean",
}

function BuildCHUDDamageMessage( target, amount, hitpos, overkill )
	local t = BuildDamageMessage( target, amount, hitpos )
	t.overkill = overkill
	return t
end

function BuildCHUDDamage2Message( target, amount, hitpos, overkill, weapon )
	local t = BuildCHUDDamageMessage( target, amount, hitpos, overkill )
	t.hitcount = 1	
	if weapon == kTechId.Railgun then
		t.mode = kHitsoundMode.Overkill
	else
		t.mode = kHitsoundMode.Hitcount
	end
	return t
end

Shared.RegisterNetworkMessage( "CHUDDamage", kCHUDDamageMessage )
Shared.RegisterNetworkMessage( "CHUDDamage2", kCHUDDamage2Message )
Shared.RegisterNetworkMessage( "CHUDOption", kCHUDOptionMessage )
Shared.RegisterNetworkMessage( "SetCHUDAutopickup", kCHUDAutopickupMessage)
Shared.RegisterNetworkMessage( "CHUDDeathStats", kCHUDDeathStatsMessage)

Script.Load("lua/CHUD/Shared/CHUD_Utility.lua")
Script.Load("lua/CHUD/Shared/CHUD_Autopickup.lua")
Script.Load("lua/CHUD/Shared/CHUD_CommanderSelection.lua")
Script.Load("lua/CHUD/Shared/CHUD_LayMines.lua")
Script.Load("lua/CHUD/Shared/CHUD_Grenade.lua")
Script.Load("lua/CHUD/Shared/CHUD_BoneWall.lua")
Script.Load("lua/CHUD/Shared/CHUD_LerkBite.lua")

CHUDTagBitmask = {
	mcr = 0x1,
	ambient = 0x2,
	mapparticles = 0x4,
	nsllights = 0x8,
	deathstats = 0x0,
}

local embryoNetworkVars =
{
	evolvePercentage = "float",
}

local pickupableNetworkVars =
{
	expireTime = "time (by 0.1)",
}

local catpackNetworkVars =
{
	catpackboost = "boolean",
}

Class_Reload("Embryo", embryoNetworkVars)
Class_Reload("Weapon", pickupableNetworkVars)
Class_Reload("DropPack", pickupableNetworkVars)
Class_Reload("Marine", catpackNetworkVars)
Class_Reload("Exo", catpackNetworkVars)
