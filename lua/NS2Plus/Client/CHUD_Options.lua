local function CHUDRestartScripts(scripts)

	for _, currentScript in pairs(scripts) do
		local script = ClientUI.GetScript(currentScript)
		if script then
			script:Uninitialize()
			script:Initialize()
		end
	end
	
end

CHUDOptions =
{
			mingui = {
				name    = "CHUD_MinGUI",
				label   = "Minimal GUI",
				tooltip = "Removes backgrounds/scanlines from all UI elements.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				applyFunction = function() CHUDRestartScripts({
					"Hud/Marine/GUIMarineHUD",
					"GUIAlienHUD",
					}) end,
				sort = "A1",
			},
			wps = {
				name    = "CHUD_Waypoints",
				label   = "Waypoints",
				tooltip = "Disables or enables all waypoints except Attack orders (waypoints can still be seen on minimap).",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "func",
				valueType = "bool",
				sort = "A2",
			},
			autowps = { 
				name    = "CHUD_AutoWPs",
				label   = "Automatic waypoints",
				tooltip = "Enables or disables automatic waypoints (not given by the commander).",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "func",
				valueType = "bool",
				sort = "A3",
			},
			minwps = {
				name    = "CHUD_MinWaypoints",
				label   = "Minimal waypoints",
				tooltip = "Toggles all text/backgrounds and only leaves the waypoint icon.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "A4",
			},
			minnps = {
				name    = "CHUD_MinNameplates",
				label   = "Minimal nameplates",
				tooltip = "Toggles building names and health/armor bars with a simple %.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "A5",
			},
			smallnps = {
				name    = "CHUD_SmallNameplates",
				label   = "Small nameplates",
				tooltip = "Makes fonts in the nameplates smaller.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "A6",
			},
			dmgscale = {
				name    = "CHUD_DMGScale",
				label   = "Damage numbers scale",
				tooltip = "Lets you scale down the damage numbers.",
				type    = "slider",
				sliderCallback = CHUDDMGScaleSlider,
				defaultValue = 1,
				minValue = 0.5,
				maxValue = 1,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				sort = "A7",
			}, 
			av = {
				name    = "CHUD_AV",
				label   = "Alien vision",
				tooltip = "Lets you choose between different Alien Vision types.",
				type    = "select",
				values  = { "Default", "Huze's Old AV", "Huze's Minimal AV", "Uke's AV" },
				valueTable = {
					"shaders/DarkVision.screenfx",
					"shaders/HuzeOldAV.screenfx",
					"shaders/HuzeMinAV.screenfx",
					"shaders/UkeAV.screenfx",
				},
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "func",
				valueType = "int",
				applyFunction = function() CHUDRestartScripts({	"GUIAlienHUD" }) end,
				sort = "B1",
			},
			avstate = { 
				name    = "CHUD_AVState",
				label   = "Default AV state",
				tooltip = "Sets the state the alien vision will be in when you respawn.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "B2",
			},
			hpbar = {
				name    = "CHUD_HPBar",
				label   = "Marine health bars",
				tooltip = "Enables or disables the health bars from the marine HUD.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "func",
				valueType = "bool",
				applyFunction = function() CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" }) end,
				sort = "C1",
			},
			alienbars = {
				name    = "CHUD_AlienBars",
				label   = "Alien bars",
				tooltip = "Lets you choose between different alien bars.",
				type    = "select",
				values  = { "Default", "Oma", "Rantology" },
				valueTable  = { "ui/alien_hud_health.dds", "ui/oma_alien_hud_health.dds", "ui/rant_alien_hud_health.dds" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "func",
				valueType = "int",
				applyFunction = function() CHUDRestartScripts({	"GUIAlienHUD" }) end,
				sort = "C2",
			}, 
			instantalienhealth = {
				name    = "CHUD_InstantAlienHealth",
				label   = "Instant Alien Health Bar",
				tooltip = "Update alien health bar instantly instead of animating.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "C3"
			},
			motiontracking = {
				name    = "CHUD_MotionTracking",
				label   = "Motion tracking circle",
				tooltip = "Lets you choose between default scan circles and a minimal one.",
				type    = "select",
				values  = { "Default", "Minimal" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "func",
				valueType = "int",
				sort = "C4"
			},
			dmgcolor_m = {
				name    = "CHUD_DMGColorM",
				label   = "Marine damage numbers color",
				tooltip = "Changes the color of the marine damage numbers.",
				type    = "select",
				values  = { "Default", "Red", "Green", "Blue", "Yellow", "Magenta", "Cyan", "Orange", "Black", "White" },
				valueTable = { 0x4DDBFF, 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0xFF00FF, 0x00FFFF, 0xFFA500, 0x000000, 0xFFFFFF },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "func",
				valueType = "int",
				sort = "D1",
			},
			dmgcolor_a = {
				name    = "CHUD_DMGColorA",
				label   = "Alien damage numbers color",
				tooltip = "Changes the color of the alien damage numbers.",
				type    = "select",
				values  = { "Default", "Red", "Green", "Blue", "Yellow", "Magenta", "Cyan", "Orange", "Black", "White" },
				valueTable = { 0xFFCA3A, 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0xFF00FF, 0x00FFFF, 0xFFA500, 0x000000, 0xFFFFFF },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "func",
				valueType = "int",
				sort = "D2",
			},
			blur = {
				name    = "CHUD_Blur",
				label   = "Blur",
				tooltip = "Removes the background blur from menus/minimap.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "func",
				valueType = "bool",
				sort = "E1"
			},
			particles = {
				name    = "CHUD_Particles",
				label   = "Minimal particles",
				tooltip = "Toggles between default and less vision obscuring particles.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				applyFunction = SetCHUDCinematics,
				applyOnLoadComplete = true,
				sort = "E2"
			}, 
			tracers = {
				name    = "CHUD_Tracers",
				label   = "Weapon tracers",
				tooltip = "Enables or disables weapon tracers.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "func",
				valueType = "bool",
				sort = "E3",
			},
			maxdecallifetime = {
				name    = "CHUD_MaxDecalLifeTime",
				label   = "Max decal lifetime (minutes)",
				tooltip = "Changes the maximum decal lifetime, you still have to set the slidebar to your liking in the vanilla options.",
				type    = "slider",
				sliderCallback = CHUDDecalSlider,
				defaultValue = 1,
				minValue = 0,
				maxValue = 100,
				multiplier = 1,
				category = "func",
				valueType = "float",
				sort = "E4",
			},
			
			
			score = {
				name    = "CHUD_ScorePopup",
				label   = "Score popup",
				tooltip = "Disables or enables score popup (+5).",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "A1",
			},
			scorecolor = {
				name    = "CHUD_ScorePopupColor",
				label   = "Score popup color",
				tooltip = "Changes the color of the score popup.",
				type    = "select",
				values  = { "Default", "Red", "Green", "Blue", "Yellow", "Magenta", "Cyan", "Orange", "Black", "White" },
				valueTable = { 0x19FF19, 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0xFF00FF, 0x00FFFF, 0xFFA500, 0x000000, 0xFFFFFF },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "hud",
				valueType = "int",
				applyFunction = function()
					GUINotifications.kScoreDisplayKillTextColor = ColorIntToColor(CHUDGetOptionAssocVal("scorecolor"))
				end,
				sort = "A2",
			},
			assists = {
				name    = "CHUD_Assists",
				label   = "Assist score popup",
				tooltip = "Disables or enables the assists score popup.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "A3",
			},
			assistscolor = {
				name    = "CHUD_AssistsPopupColor",
				label   = "Assists popup color",
				tooltip = "Changes the color of the assists popup.",
				type    = "select",
				values  = { "Default", "Red", "Green", "Blue", "Yellow", "Magenta", "Cyan", "Orange", "Black", "White" },
				valueTable = { 0xBFBF19, 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0xFF00FF, 0x00FFFF, 0xFFA500, 0x000000, 0xFFFFFF },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "hud",
				valueType = "int",
				applyFunction = function()
					GUINotifications.kScoreDisplayTextColor = ColorIntToColor(CHUDGetOptionAssocVal("assistscolor"))
				end,
				sort = "A4",
			},
			banners = {
				name    = "CHUD_Banners",
				label   = "Objective banners",
				tooltip = "Removes the banners in the center of the screen (\"Commander needed\", \"Power node under attack\", \"Evolution lost\", etc.).",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "B1",
			},
			unlocks = {
				name    = "CHUD_Unlocks",
				label   = "Research notifications",
				tooltip = "Removes the research completed notifications on the right side of the screen.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "B2",
			}, 
			minimap = {
				name    = "CHUD_Minimap",
				label   = "Marine minimap",
				tooltip = "Toggles the minimap and location name.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "C1",
				applyFunction = function() CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" }) end,
			},
			showcomm = {
				name    = "CHUD_CommName",
				label   = "Comm name/Team res",
				tooltip = "Enables or disables showing the commander name and team resources.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "C2",
				applyFunction = function() CHUDRestartScripts({
					"Hud/Marine/GUIMarineHUD",
					"GUIAlienHUD",
					}) end,
			}, 
			gametime = {
				name    = "CHUD_Gametime",
				label   = "Game time",
				tooltip = "Adds or removes the game time on the top left.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "hud",
				valueType = "bool",
				sort = "C3",
				applyFunction = function() CHUDRestartScripts({
					"Hud/Marine/GUIMarineHUD",
					"GUIAlienHUD",
					}) end,
			},
			commactions = {
				name    = "CHUD_CommActions",
				label   = "Marine comm actions",
				tooltip = "Shows or hides the last commander actions.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "C4",
				applyFunction = function() CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" }) end,
			}, 
			uniqueshotgunhits = {
				name    = "CHUD_UniqueShotgunHits",
				label   = "Shotgun damage numbers",
				tooltip = "Optionally show unique damage numbers for each shotgun shot",
				type    = "select",
				values  = { "Default", "Per shot" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "hud",
				valueType = "bool",
				sort = "C5",
			},
			fasterdamagenumbers = {
				name    = "CHUD_FasterDamageNumbers",
				label   = "Faster damage numbers",
				tooltip = "Makes damage numbers accumulate faster",
				type    = "select",
				values  = { "Default", "Faster", "Instant" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "hud",
				valueType = "int",
				applyFunction = 
					function() 
						local speeds = { [0] = 220, [1] = 800, [2] = 9001 }
						kWorldDamageNumberAnimationSpeed = speeds[CHUDGetOption("fasterdamagenumbers")]
					end,
				sort = "C6",
			},
			overkilldamagenumbers = {
				name    = "CHUD_OverkillDamageNumbers",
				label   = "Overkill damage numbers",
				tooltip = "Makes damage numbers show all damage, including overkill",
				type    = "select",
				values  = { "Disabled", "Enabled" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "hud",
				valueType = "bool",
				applyFunction = function()
					local message = { }
					message.overkill = CHUDGetOption("overkilldamagenumbers")
					Client.SendNetworkMessage("SetCHUDOverkill", message)
				end,
				sort = "C6b",
			},
			damagenumbertime = 
			{
				name    = "CHUD_DamageNumberTime",
				label   = "Damage number fade time",
				tooltip = "Controls how long damage numbers are on screen.",
				type    = "slider",
				sliderCallback = CHUDDMGTimeSlider,
				defaultValue = kWorldMessageLifeTime,
				minValue = 0,
				maxValue = 3,
				category = "hud",
				valueType = "float",
				sort = "C6c"
			},
			hitindicator = { 
				name    = "CHUD_HitIndicator",
				label   = "Hit indicator fade time",
				tooltip = "Controls the speed of the crosshair hit indicator.",
				type    = "slider",
				sliderCallback = CHUDHitIndicatorSlider,
				defaultValue = 1,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function() Player.kShowGiveDamageTime = CHUDGetOption("hitindicator") end,
				applyOnLoadComplete = true,
				sort = "C7"
			},
			minimapalpha = { 
				name    = "CHUD_MinimapAlpha",
				label   = "Overview transparency",
				tooltip = "Sets the trasparency of the map overview.",
				type    = "slider",
				sliderCallback = CHUDMinimapSlider,
				defaultValue = 0.85,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function()
					local minimapScript = ClientUI.GetScript("GUIMinimapFrame")
					minimapScript:GetMinimapItem():SetColor(Color(1,1,1,CHUDGetOption("minimapalpha")))
				end,
				sort = "C8",
			},
			locationalpha = { 
				name    = "CHUD_LocationAlpha",
				label   = "Location transparency",
				tooltip = "Sets the trasparency of the location text on the minimap.",
				type    = "slider",
				sliderCallback = CHUDLocationSlider,
				defaultValue = 0.65,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function()
					OnCommandSetMapLocationColor("255", "255", "255", tostring(tonumber(CHUDGetOption("locationalpha"))*255))
				end,
				sort = "C9",
			},
			minimaparrowcolor = { 
				name    = "CHUD_MinimapArrowColor",
				label   = "Minimap arrow color",
				tooltip = "Sets the color of the arrow indicating your position in the minimap.",
				type    = "select",
				values  = { "Default", "Red", "Green", "Blue", "Yellow", "Magenta", "Cyan", "Orange", "Black", "White" },
				valueTable = { 0x0, 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0xFF00FF, 0x00FFFF, 0xFFA500, 0x000000, 0xFFFFFF },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "hud",
				valueType = "int",
				applyFunction = function()
					local minimapScript = ClientUI.GetScript("GUIMinimapFrame")
					local playerIconColor = nil
					if CHUDGetOption("minimaparrowcolor") > 0 then
						playerIconColor = ColorIntToColor(CHUDGetOptionAssocVal("minimaparrowcolor"))
					end
					minimapScript:SetPlayerIconColor(playerIconColor)
					CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" })
				end,
				sort = "C9b",
			},
			playercolor_m = { 
				name    = "CHUD_PlayerColor_M",
				label   = "Marine minimap player color",
				tooltip = "Sets the color of marine players in the minimap different from the structures.",
				type    = "select",
				values  = { "Default", "Blue", "Green", "Light Green", "Yellow" },
				valueTable = { 0x0, 0x0000FF, 0x00FF00, 0xA0FFA0, 0xFFFF00 },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "hud",
				valueType = "int",
				sort = "C9c",
			},
			playercolor_a = { 
				name    = "CHUD_PlayerColor_A",
				label   = "Alien minimap player color",
				tooltip = "Sets the color of alien players in the minimap different from the structures.",
				type    = "select",
				values  = { "Default", "Light Orange", "Light Red", "Magenta", "Pink" },
				valueTable = { 0x0, 0xFFDDAC, 0xFF6A6A, 0xFF00FF, 0xFFA0FF },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "hud",
				valueType = "int",
				sort = "C9d",
			},
			pglines = { 
				name    = "CHUD_MapConnectorLines",
				label   = "Phase Gate Lines",
				tooltip = "Cutomizes the look of the PG lines in the minimap.",
				type    = "select",
				values  = { "Solid line", "Static arrows", "Animated lines", "Animated arrows" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 3,
				category = "hud",
				valueType = "int",
				sort = "D1",
			},
			classicammo = {
				name    = "CHUD_ClassicAmmo",
				label   = "Classic ammo counter",
				tooltip = "Toggles a classic ammo counter on the bottom right of the HUD.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "hud",
				valueType = "bool",
                sort = "D2",
			},
			friends = {
				name    = "CHUD_Friends",
				label   = "Friends highlighting",
				tooltip = "Enables or disables the friend highlighting in the scoreboard/nameplates.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				applyFunction = function() 	local friends = CHUDGetOption("friends")
					ReplaceLocals(PlayerUI_GetStaticMapBlips, { kMinimapBlipTeamFriendAlien =
						ConditionalValue(friends, kMinimapBlipTeam.FriendAlien, kMinimapBlipTeam.Alien) } )
					ReplaceLocals(PlayerUI_GetStaticMapBlips, { kMinimapBlipTeamFriendMarine =
						ConditionalValue(friends, kMinimapBlipTeam.FriendMarine, kMinimapBlipTeam.Marine) } )
				end,
                sort = "D3",
			}, 
			kda = {
				name    = "CHUD_KDA",
				label   = "KDA/KAD",
				tooltip = "Switches the scoreboard between KAD and KDA.",
				type    = "select",
				values  = { "KAD", "KDA" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "hud",
				valueType = "bool",
				applyFunction = function() CHUDRestartScripts({ "GUIScoreboard" }) end,
                sort = "D4",
			},
			rtcount = {
				name    = "CHUD_RTcount",
				label   = "RT count dots",
				tooltip = "Toggles the RT count dots at the bottom and replaces them with a number.",
				type    = "select",
				values  = { "Number", "Dots" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
                sort = "D5",
			},
			uplvl = {
				name    = "CHUD_UpgradeLevel",
				label   = "Upgrade level UI",
				tooltip = "Changes between disabled, default or old icons for marine upgrades.",
				type    = "select",
				values  = { "Disabled", "Default", "NS2 Beta" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 1,
				category = "hud",
				valueType = "int",
				applyFunction = function() local script = ClientUI.GetScript("Hud/Marine/GUIMarineHUD")
					if script then
						script:ShowNewWeaponLevel(PlayerUI_GetWeaponLevel())
						script:ShowNewArmorLevel(PlayerUI_GetArmorLevel())
					end
				end,
				sort = "D6",
			},
			killfeedscale = {
				name    = "CHUD_KillFeedScale",
				label   = "Killfeed scale",
				tooltip = "Lets you scale the killfeed.",
				type    = "slider",
				sliderCallback = CHUDKillFeedScaleSlider,
				defaultValue = 1,
				minValue = 1,
				maxValue = 2,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function()
					CHUDRestartScripts({ "GUIDeathMessages" })
				end,
				sort = "D7",
			},
			killfeediconscale = {
				name    = "CHUD_KillFeedIconScale",
				label   = "Killfeed icon scale",
				tooltip = "Lets you scale the size of the icons in the killfeed.",
				type    = "slider",
				sliderCallback = CHUDKillFeedIconScaleSlider,
				defaultValue = 1,
				minValue = 1,
				maxValue = 2,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function()
					CHUDRestartScripts({ "GUIDeathMessages" })
				end,
				sort = "D8",
			},
			killfeedhighlight = {
				name    = "CHUD_KillFeedHighlight",
				label   = "Killfeed highlight",
				tooltip = "Highlights your player kills in the killfeed.",
				type    = "select",
				values  = { "Disabled", "Enabled" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 1,
				category = "hud",
				valueType = "int",
				applyFunction = function()
					CHUDRestartScripts({ "GUIDeathMessages" })
				end,
				sort = "D9a",
			},
			killfeedcolor = {
				name    = "CHUD_KillFeedHighlightColor",
				label   = "Killfeed highlight color",
				tooltip = "Chooses the color of the highlight border for your kills in the killfeed.",
				type    = "select",
				values  = { "Default", "Red", "Green", "Blue", "Yellow", "Magenta", "Cyan", "Orange", "Black", "White" },
				valueTable = { 0x000000, 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0xFF00FF, 0x00FFFF, 0xFFA500, 0x000000, 0xFFFFFF },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "hud",
				valueType = "int",
				applyFunction = function()
					CHUDRestartScripts({ "GUIDeathMessages" })
				end,
				sort = "D9b",
			},
			lowammowarning = {
				name    = "CHUD_LowAmmoWarning",
				label   = "Low ammo warning",
				tooltip = "Enables or disables the low ammo warning in the weapon displays.",
				type    = "select",
				values  = { "Disabled", "Enabled" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "E1",
			},
			customhud_m = {
				name    = "CHUD_CustomHUD_M",
				label   = "HUD bars (Marine)",
				tooltip = "HL2 Style displays health/armor and ammo next to the crosshair. NS1 Style puts big bars at the bottom on each side.",
				type    = "select",
				values  = { "Disabled", "HL2 Style", "NS1 Style" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "hud",
				valueType = "int",
				applyFunction = function()
					local classicammoScript = "NS2Plus/Client/CHUDGUI_ClassicAmmo"
					local customhudScript = "NS2Plus/Client/CHUDGUI_CustomHUD"
					if GetGUIManager():GetGUIScriptSingle(customhudScript) then
						GetGUIManager():DestroyGUIScriptSingle(customhudScript)
					end
					if GetGUIManager():GetGUIScriptSingle(classicammoScript) then
						GetGUIManager():DestroyGUIScriptSingle(classicammoScript)
					end
					CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" })
					CHUDEvaluateGUIVis()
				end,
				sort = "E2",
			},
			customhud_a = {
				name    = "CHUD_CustomHUD_A",
				label   = "HUD bars (Alien)",
				tooltip = "HL2 Style displays health/armor and ammo next to the crosshair. NS1 Style puts big bars at the bottom on each side.",
				type    = "select",
				values  = { "Disabled", "HL2 Style", "NS1 Style" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "hud",
				valueType = "int",
				applyFunction = function()
					local customhudScript = "NS2Plus/Client/CHUDGUI_CustomHUD"
					if GetGUIManager():GetGUIScriptSingle(customhudScript) then
						GetGUIManager():DestroyGUIScriptSingle(customhudScript)
					end
					CHUDRestartScripts({ "GUIAlienHUD" })
					CHUDEvaluateGUIVis()
				end,
				sort = "E3",
			},
			
			
			hitsounds = {
				name    = "CHUD_Hitsounds",
				label   = "Hitsounds",
				tooltip = "Chooses between different server confirmed hitsounds.",
				type    = "select",
				values  = { "Vanilla", "Quake 3", "Quake 4", "Dystopia" },
				valueTable = { "null",
					"sound/hitsounds.fev/hitsounds/q3",
					"sound/hitsounds.fev/hitsounds/q4",
					"sound/hitsounds.fev/hitsounds/dys",
				},
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "comp",
				valueType = "int",
				sort = "A1",
			},
			hitsounds_pitch = { 
				name    = "CHUD_HitsoundsPitch",
				label   = "Hitsounds pitch modifier",
				tooltip = "Sets the pitch for high damage hits on variable damage weapons. This setting has no effect for vanilla hitsounds.",
				type    = "select",
				values  = { "Low pitch", "High pitch" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "comp",
				valueType = "int",
				sort = "A2",
			},
			ambient = {
				name    = "CHUD_Ambient",
				label   = "Ambient sounds",
				tooltip = "Enables or disables map ambient sounds.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "comp",
				valueType = "bool",
				applyFunction = SetCHUDAmbients,
				applyOnLoadComplete = true,
				sort = "B1",
			}, 
			mapparticles = {
				name    = "CHUD_MapParticles",
				label   = "Map particles",
				tooltip = "Enables or disables particles, holograms and other map specific effects.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "comp",
				valueType = "bool",
				applyFunction = SetCHUDCinematics,
				applyOnLoadComplete = true,
				sort = "B2",
			}, 
			nsllights = {
				name    = "lowLights",
				label   = "NSL Low lights",
				tooltip = "Replaces the low quality option lights with the lights from the NSL maps.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				applyFunction = function()
					lowLightsSwitched = false
					CHUDLoadLights()
				end,
				sort = "B3",
			}, 
			flashatmos = { 
				name    = "CHUD_FlashAtmos",
				label   = "Flashlight atmospherics",
				tooltip = "Sets the atmospheric density of flashlights.",
				type    = "slider",
				sliderCallback = CHUDFlashAtmosSlider,
				defaultValue = 1,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "comp",
				valueType = "float",
				sort = "C1",
			},
			mapatmos = { 
				name    = "CHUD_MapAtmos",
				label   = "Map atmospherics",
				tooltip = "Sets the atmospheric density of the map lights.",
				type    = "slider",
				sliderCallback = CHUDMapAtmosSlider,
				defaultValue = 1,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "comp",
				valueType = "float",
				sort = "C2",
				applyFunction = function()
					if Client.lightList then
						for index, light in ipairs(Client.lightList) do
							if light.originalAtmosphericDensity then
								light:SetAtmosphericDensity(light.originalAtmosphericDensity * CHUDGetOption("mapatmos"))
							end
						end
					end
				end,
			},
			deathstats = { 
				name    = "CHUD_DeathStats",
				label   = "Stats UI",
				tooltip = "Enables or disables the stats you get after you die and at the end of the round. Also visible on voiceover menu (default: X).",
				type    = "select",
				values  = { "Fully disabled", "Only voiceover menu", "Enabled" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 2,
				disabledValue = 0,
				category = "comp",
				valueType = "int",
				sort = "D1",
			},
			autopickup = { 
				name    = "CHUD_AutoPickup",
				label   = "Weapon autopickup",
				tooltip = "Picks up weapons automatically as long as the slot they belong to is empty.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				sort = "E1",
				applyFunction = function()
					local message = { }
					message.autoPickup = CHUDGetOption("autopickup")
					message.autoPickupBetter = CHUDGetOption("autopickupbetter")
					Client.SendNetworkMessage("SetCHUDAutopickup", message)
				end,
			},
			autopickupbetter = { 
				name    = "CHUD_AutoPickupBetter",
				label   = "Autopickup better weapon",
				tooltip = "Picks up better weapons in the primary slot automatically.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				sort = "E2",
				applyFunction = function()
					local message = { }
					message.autoPickup = CHUDGetOption("autopickup")
					message.autoPickupBetter = CHUDGetOption("autopickupbetter")
					Client.SendNetworkMessage("SetCHUDAutopickup", message)
				end,
			},
			pickupexpire = { 
				name    = "CHUD_PickupExpire",
				label   = "Pickup expiration bar",
				tooltip = "Adds a bar indicating the time left for the pickupable to disappear.",
				type    = "select",
				values  = { "Disabled", "Equipment Only", "All pickupables" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 2,
				category = "comp",
				valueType = "int",
				sort = "E3",
				resetSettingInBuild = 191,
			},
			pickupexpirecolor = { 
				name    = "CHUD_PickupExpireBarColor",
				label   = "Dynamically colored expiration bar",
				tooltip = "Makes the expire bar colored depending on time left.",
				type    = "select",
				values  = { "Disabled", "Enabled" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "comp",
				valueType = "int",
				sort = "E4",
			},
			instantdissolve = { 
				name    = "CHUD_InstantDissolve",
				label   = "Ragdoll instant dissolve effect",
				tooltip = "Makes the ragdoll start to disappear immediatly after kill.",
				type    = "select",
				values  = { "Disabled", "Enabled" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				sort = "E5",
			},
			minimaptoggle = { 
				name    = "CHUD_MinimapToggle",
				label   = "Minimap key behavior",
				tooltip = "Lets you make the minimap key a toggle instead of holding.",
				type    = "select",
				values  = { "Hold", "Toggle" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "comp",
				valueType = "int",
				sort = "F1",
			},
			marinecommselect = { 
				name    = "CHUD_MarineCommSelect",
				label   = "(Comm) Marine Click Selection",
				tooltip = "Lets you disable click selecting for Marines.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "comp",
				valueType = "bool",
				sort = "F2",
			},
			commqueue = { 
				name    = "CHUD_CommQueue",
				label   = "(Comm) Spacebar Alert Queue",
				tooltip = "Allows the spacebar alert queue to prioritize player requests.",
				type    = "select",
				values  = { "Default", "Prioritize Player Alerts" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				sort = "F3",
			},
}