Script.Load("lua/GUIAnimatedScript.lua")

class 'CHUDGUI_EndStats' (GUIAnimatedScript)

CHUDEndStatsVisible = false

local gStatsUI
local lastStatsMsg = 0
local appendTime = 2.5
local shownTime = 0
local displayTime = 20
local hasText = false

local kTitleFontName = "fonts/AgencyFB_medium.fnt"
local kStatsFontName = "fonts/AgencyFB_small.fnt"
local kTopOffset = GUIScale(32)
local kFontScale = GUIScale(Vector(1, 1, 0))
local kTitleBackgroundTexture = "ui/objective_banner_marine.dds"
local kTitleBackgroundSize = GUIScale(Vector(210, 45, 0))

function CHUDGUI_EndStats:Initialize()

	GUIAnimatedScript.Initialize(self)

	self.titleBackground = self:CreateAnimatedGraphicItem()
	self.titleBackground:SetTexture(kTitleBackgroundTexture)
	self.titleBackground:SetIsScaling(false)
	self.titleBackground:SetColor(Color(1, 1, 1, 0))
	self.titleBackground:SetAnchor(GUIItem.Middle, GUIItem.Top)
	self.titleBackground:SetPosition(Vector(-kTitleBackgroundSize.x/2, kTopOffset, 0))
	self.titleBackground:SetSize(kTitleBackgroundSize)
	self.titleBackground:SetLayer(kGUILayerPlayerHUD)
	
	self.titleShadow = GetGUIManager():CreateTextItem()
	self.titleShadow:SetFontName(kTitleFontName)
	self.titleShadow:SetAnchor(GUIItem.Middle, GUIItem.Middle)
	self.titleShadow:SetTextAlignmentX(GUIItem.Align_Center)
	self.titleShadow:SetTextAlignmentY(GUIItem.Align_Center)
	self.titleShadow:SetPosition(GUIScale(Vector(0, 3, 0)))
	self.titleShadow:SetText("Last round stats")
	self.titleShadow:SetColor(Color(0, 0, 0, 1))
	self.titleShadow:SetScale(kFontScale)
	self.titleShadow:SetInheritsParentAlpha(true)
	self.titleBackground:AddChild(self.titleShadow)
	
	self.titleText = GetGUIManager():CreateTextItem()
	self.titleText:SetFontName(kTitleFontName)
	self.titleText:SetTextAlignmentX(GUIItem.Align_Center)
	self.titleText:SetTextAlignmentY(GUIItem.Align_Center)
	self.titleText:SetPosition(GUIScale(Vector(-2, -2, 0)))
	self.titleText:SetText("Last round stats")
	self.titleText:SetScale(kFontScale)
	self.titleText:SetInheritsParentAlpha(true)
	self.titleShadow:AddChild(self.titleText)
	
	self.stringsTable = {}
	self.commStringsTable = {}
	
	self.actionIconGUI = GetGUIManager():CreateGUIScript("GUIActionIcon")
	self.actionIconGUI:SetColor(kWhite)
	self.actionIconGUI.pickupIcon:SetLayer(kGUILayerPlayerHUD)
	
	self.showing = false
	self.fading = false
	
	gStatsUI = self
end

function CHUDGUI_EndStats:Reset()

	GUIAnimatedScript.Reset(self)

end

local function AddString(self, string, isComm)
	
	if Shared.GetTime() > lastStatsMsg + appendTime then
		for _, textItem in pairs(self.stringsTable) do
			GUI.DestroyItem(textItem)
		end
		
		for _, stringUI in pairs(self.commStringsTable) do
			GUI.DestroyItem(textItem)
		end
		
		self.stringsTable = {}
		self.commStringsTable = {}
	end
	
	local stringUI = GetGUIManager():CreateTextItem()
	stringUI:SetFontName(kStatsFontName)
	stringUI:SetAnchor(GUIItem.Center, GUIItem.Top)
	stringUI:SetTextAlignmentX(GUIItem.Align_Center)
	stringUI:SetScale(kFontScale)
	stringUI:SetInheritsParentAlpha(true)
	stringUI:SetText(string)
	self.titleBackground:AddChild(stringUI)
	
	table.insert(ConditionalValue(isComm, self.commStringsTable, self.stringsTable), stringUI)
	
	// Reposition everything on new strings
	local yCoord = kTitleBackgroundSize.y + GUIScale(5)
	if isComm then
		local totalSize = 0
		for _, textItem in pairs(self.commStringsTable) do
			totalSize = totalSize + textItem:GetTextWidth(textItem:GetText())
		end
		
		local pos = 0
		local xSpacing = GUIScale(10)
		totalSize = totalSize + (xSpacing * #self.commStringsTable)
		
		for _, textItem in ipairs(self.commStringsTable) do
			local textItemSize = textItem:GetTextWidth(textItem:GetText())
			local xCoord = -(totalSize/2) + (textItemSize/2) + pos
			pos = pos + textItemSize/2 + xSpacing
			totalSize = totalSize - textItemSize
			textItem:SetPosition(Vector(xCoord, yCoord, 0))
		end
	else
		local biggest = 0
		for _, textItem in pairs(self.commStringsTable) do
			local textItemSize = textItem:GetTextHeight(textItem:GetText())
			if textItemSize > biggest then biggest = textItemSize end
		end
		
		yCoord = yCoord + biggest + GUIScale(5)
		
		for i, textItem in ipairs(self.stringsTable) do
			textItem:SetPosition(Vector(0, yCoord, 0))
			yCoord = yCoord + textItem:GetTextHeight(textItem:GetText())
		end
	end
	
	lastStatsMsg = Shared.GetTime()
	gStatsUI.showing = false
end

function CHUDGUI_EndStats:Update(deltaTime)

	GUIAnimatedScript.Update(self, deltaTime)
	
	hasText = #self.stringsTable > 0 or #self.commStringsTable > 0
	
	if PlayerUI_GetHasGameStarted() then
		self.titleBackground:SetIsVisible(false)
		self.actionIconGUI:Hide()
	end
	
	if self.titleBackground:GetColor().a > 0 and hasText then
		CHUDEndStatsVisible = true
	else
		CHUDEndStatsVisible = false
	end
	
	if not PlayerUI_GetHasGameStarted() and hasText and self.showing == false and CHUDGetOption("deathstats") > 1 then
		self.showing = true
		shownTime = Shared.GetTime()
		self.titleBackground:SetIsVisible(true)
		self.titleBackground:FadeIn(2, "CHUD_ENDSTATS")
		self.actionIconGUI:ShowIcon(BindingsUI_GetInputValue("RequestMenu"), nil, "Last round stats", nil)
		self.fading = false
	elseif Shared.GetTime() - shownTime > displayTime and not self.fading then
		self.fading = true
		self.actionIconGUI:Hide()
		self.titleBackground:FadeOut(2, "CHUD_ENDSTATS")
	end

end

function CHUDGUI_EndStats:SendKeyEvent(key, down)

	// Force show when request menu is open
	if GetIsBinding(key, "RequestMenu") and CHUDGetOption("deathstats") > 0 and (not PlayerUI_GetHasGameStarted() or Client.GetLocalPlayer():GetTeamNumber() == kTeamReadyRoom) then
		self.titleBackground:SetIsVisible(down)
		self.titleBackground:SetColor(Color(1, 1, 1, ConditionalValue(down and hasText, 1, 0)))
	end
	
end

function CHUDGUI_EndStats:Uninitialize()

	GUIAnimatedScript.Uninitialize(self)

	GUI.DestroyItem(self.titleBackground)
	self.titleBackground = nil
	
	GetGUIManager():DestroyGUIScript(self.actionIconGUI)
	self.actionIconGUI = nil
	
	self.stringsTable = {}
	self.commStringsTable = {}
	
end

local function CHUDSetAccuracyString(message)
	
	local weaponName
	
	local wTechId = message.wTechId

	if message.wTechId > 1 then
		local techdataName = LookupTechData(wTechId, kTechDataMapName) or string.lower(LookupTechData(wTechId, kTechDataDisplayName))
		weaponName = techdataName:gsub("^%l", string.upper)
	else
		weaponName = "Others"
	end
	
	// Lerk's bite is called "Bite", just like the skulk bite, so clarify this
	if wTechId == kTechId.LerkBite then
		weaponName = "Lerk Bite"
	// This shows up as "Swipe Blink", just "Swipe"
	elseif wTechId == kTechId.Swipe then
		weaponName = "Swipe"
	// Use spaces!
	elseif rawget( kTechId, "HeavyMachineGun" ) and wTechId == kTechId.HeavyMachineGun then
		weaponName = "Heavy Machine Gun"
	end

	local accuracyString = string.format("%s accuracy: %.2f%%", weaponName, message.accuracy)
	
	if message.accuracyOnos > -1 then
		accuracyString = accuracyString .. string.format(" / Without Onos hits: %.2f%%", message.accuracyOnos)
	end

	AddString(gStatsUI, accuracyString)
end

local function CHUDSetOverallString(message)
	
	if message.medpackAccuracy then
		
		if message.medpackResUsed + message.medpackResExpired > 0 then
			local finalStatsString = string.format("Medpack accuracy: %.2f%%", message.medpackAccuracy)
			finalStatsString = finalStatsString .. string.format("\nAmount healed: %d", message.medpackRefill)
			finalStatsString = finalStatsString .. string.format("\nRes spent on used medpacks: %d", message.medpackResUsed)
			finalStatsString = finalStatsString .. string.format("\nRes spent on expired medpacks: %d", message.medpackResExpired)
			finalStatsString = finalStatsString .. string.format("\nRes efficiency: %.2f%%", message.medpackEfficiency)
			
			AddString(gStatsUI, finalStatsString, true)
		end
		
		if message.ammopackResUsed + message.ammopackResExpired > 0 then
			local finalStatsString = string.format("Ammo refilled: %d", message.ammopackRefill)
			finalStatsString = finalStatsString .. string.format("\nRes spent on used ammopacks: %d", message.ammopackResUsed)
			finalStatsString = finalStatsString .. string.format("\nRes spent on expired ammopacks: %d", message.ammopackResExpired)
			finalStatsString = finalStatsString .. string.format("\nRes efficiency: %.2f%%", message.ammopackEfficiency)
			
			AddString(gStatsUI, finalStatsString, true)
		end
		
		if message.catpackResUsed + message.catpackResExpired > 0 then
			local finalStatsString = string.format("Res spent on used catpacks: %d", message.catpackResUsed)
			finalStatsString = finalStatsString .. string.format("\nRes spent on expired catpacks: %d", message.catpackResExpired)
			finalStatsString = finalStatsString .. string.format("\nRes efficiency: %.2f%%", message.catpackEfficiency)
			
			AddString(gStatsUI, finalStatsString, true)
		end
		
	elseif message.accuracy then
		
		local finalStatsString = string.format("\nOverall accuracy: %.2f%%", message.accuracy)
		
		if message.accuracyOnos > -1 then
			finalStatsString = finalStatsString .. string.format("\nWithout Onos hits: %.2f%%", message.accuracyOnos)
		end
		
		finalStatsString = finalStatsString .. string.format("\nPlayer damage: %.2f\nStructure damage: %.2f", message.pdmg, message.sdmg)
		
		AddString(gStatsUI, finalStatsString)

	end

end

Client.HookNetworkMessage("CHUDEndStatsWeapon", CHUDSetAccuracyString)
Client.HookNetworkMessage("CHUDEndStatsOverall", CHUDSetOverallString)
Client.HookNetworkMessage("CHUDMarineCommStats", CHUDSetOverallString)