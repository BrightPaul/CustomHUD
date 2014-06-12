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
	amount = "float",
	overkill = "float",
}


local kCHUDDamageStatMessage =
{
	posx = string.format("float (%d to %d by 0.05)", -kHitEffectMaxPosition, kHitEffectMaxPosition),
	posy = string.format("float (%d to %d by 0.05)", -kHitEffectMaxPosition, kHitEffectMaxPosition),
	posz = string.format("float (%d to %d by 0.05)", -kHitEffectMaxPosition, kHitEffectMaxPosition),
	targetId = "entityid",
	amount = "float",
	overkill = "float",	
	isPlayer = "boolean",
	weapon = "enum kTechId",
	hitcount = "integer (1 to 32)",
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

function BuildCHUDDamageStatMessage( target, amount, hitpos, overkill, weapon )
	local t = BuildCHUDDamageMessage( target, amount, hitpos, overkill )
	t.isPlayer = target:isa("Player")
	t.weapon = weapon
	t.hitcount = 1	
	return t
end

Shared.RegisterNetworkMessage( "CHUDDamage", kCHUDDamageMessage )
Shared.RegisterNetworkMessage( "CHUDDamageStat", kCHUDDamageStatMessage )
Shared.RegisterNetworkMessage( "CHUDOption", kCHUDOptionMessage )
Shared.RegisterNetworkMessage( "SetCHUDAutopickup", kCHUDAutopickupMessage)

Script.Load("lua/CHUD/Shared/CHUD_Utility.lua")
Script.Load("lua/CHUD/Shared/CHUD_Autopickup.lua")
Script.Load("lua/CHUD/Shared/CHUD_CommanderSelection.lua")
Script.Load("lua/CHUD/Shared/CHUD_LayMines.lua")
Script.Load("lua/CHUD/Shared/CHUD_AmmoPack.lua")
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
