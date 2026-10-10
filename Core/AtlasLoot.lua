--[[
Atlasloot Enhanced
Author Daviesh
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)
]]

_G = _G or getfenv(0)
local refreshTimeout = 2

-- Bindings
BINDING_HEADER_ATLASLOOT_TITLE = "AtlasLoot Bindings"
BINDING_NAME_ATLASLOOT_TOGGLE = "Toggle AtlasLoot"
BINDING_NAME_ATLASLOOT_OPTIONS = "Toggle Options"
BINDING_NAME_ATLASLOOT_QL1 = "QuickLook 1"
BINDING_NAME_ATLASLOOT_QL2 = "QuickLook 2"
BINDING_NAME_ATLASLOOT_QL3 = "QuickLook 3"
BINDING_NAME_ATLASLOOT_QL4 = "QuickLook 4"
BINDING_NAME_ATLASLOOT_WISHLIST = "WishList"

local AL = AtlasLoot.L

-- Establish version number and compatible version of Atlas
local ver = string.gsub(GetAddOnMetadata("AtlasLoot", "Version"), "%.", "0")
_, _, ver = string.find(ver, "(%d+)")
ATLASLOOT_VERSION = "|cffFF8400AtlasLoot TW Edition v"..GetAddOnMetadata("AtlasLoot", "Version").."|r"

-- Compatibility with old EquipCompare/EQCompare
ATLASLOOT_OPTIONS_EQUIPCOMPARE = AL["Use EquipCompare"]
ATLASLOOT_OPTIONS_EQUIPCOMPARE_DISABLED = AL["|cff9d9d9dUse EquipCompare|r"]

-- Make the Hewdrop menu in the standalone loot browser accessible here
AtlasLoot_Hewdrop = AceLibrary("Hewdrop-2.0")
AtlasLoot_HewdropSubMenu = AceLibrary("Hewdrop-2.0")

-- Colours stored for code readability
local GREY = "|cff999999"
local RED = "|cffff0000"
local WHITE = "|cffFFFFFF"
local GREEN = "|cff1eff00"
local PURPLE = "|cff9F3FFF"
local BLUE = "|cff0070dd"
local ORANGE = "|cffFF8400"
local DEFAULT = "|cffFFd200"

local Anchor_Default = { "TOPLEFT", "AtlasLootDefaultFrame", "TOPLEFT", 45, -85 }
local Anchor_Atlas = { "TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84 }
local Anchor_AlphaMap = { "TOPLEFT", "AlphaMapAlphaMapFrame", "TOPLEFT", 0, 0 }
AtlasLoot_AnchorPoint = Anchor_Default

-- Variables to hold hooked Atlas functions
local Original_Atlas_Refresh
local Original_Atlas_OnShow
local Original_AtlasScrollBar_Update

AtlasLootCharDB = {}

AtlasLoot:RegisterDB("AtlasLootDB")

-- Popup Box for first time users
StaticPopupDialogs["ATLASLOOT_SETUP"] = {
	text = AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."],
	button1 = AL["Setup"],
	OnAccept = function()
		AtlasLootOptions_Toggle()
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}

AtlasLoot.Backdrop = {
	bgFile = "Interface\\Buttons\\WHITE8x8",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	edgeSize = 22,
	insets = { left = 5, right = 5, top = 5, bottom = 5 },
}
AtlasLoot.BackdropColor = { 0, 0, 0, 0.65 }
-- AtlasLoot.BackdropBorderColor = { 1, 0.82, 0, 1 }
AtlasLoot.BackdropBorderColor = { 0, 0, 0, 1 }

-- Table for all data to be inserted into.
AtlasLoot_Data = {}
AtlasLoot_Data["AtlasLootFallback"] = {
	EmptyInstance = {}
}

--[[
AtlasLootDefaultFrame_OnShow:
Called whenever the loot browser is shown and sets up buttons and loot tables
]]
function AtlasLootDefaultFrame_OnShow()
	-- Definition of where I want the loot table to be shown
	AtlasLoot_AnchorPoint = Anchor_Default
	-- Having the Atlas and loot browser frames shown at the same time would
	-- cause conflicts, so I hide the Atlas frame when the loot browser appears
	if AtlasFrame then
		AtlasFrame:Hide()
	end
	AtlasLootItemsFrame:SetBackdrop(AtlasLoot.Backdrop)
	AtlasLootItemsFrame:SetBackdropColor(unpack(AtlasLoot.BackdropColor))
	AtlasLootItemsFrame:SetBackdropBorderColor(unpack(AtlasLoot.BackdropBorderColor))
	AtlasLootItemsFrame_Background:Hide()
	-- Remove the selection of a loot table in Atlas
	AtlasLootItemsFrame.activeBoss = nil
	if AtlasLootItemsFrame.refresh[1] then
		AtlasLoot_ShowItemsFrame(AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3])
	else
		AtlasLoot_ShowItemsFrame(AtlasLootCharDB.LastBoss, nil, AtlasLootCharDB.LastBossText)
	end
end

--[[
AtlasLoot_OnEvent(event):
event - Name of the event, passed from the API
Invoked whenever a relevant event is detected by the engine.  The function then
decides what action to take depending on the event.
]]
function AtlasLoot_OnEvent()
	-- Addons all loaded
	if event == "ADDON_LOADED" and arg1 == "AtlasLoot" then
		this:UnregisterEvent("ADDON_LOADED")
		if not AtlasLootCharDB then AtlasLootCharDB = {} end
		if not AtlasLootCharDB["WishList"] then AtlasLootCharDB["WishList"] = {} end
		if not AtlasLootCharDB["QuickLooks"] then AtlasLootCharDB["QuickLooks"] = {} end
		if not AtlasLootCharDB["SearchResult"] then AtlasLootCharDB["SearchResult"] = {} end
		-- Add the loot browser to the special frames tables to enable closing wih the ESC key
		table.insert(UISpecialFrames, "AtlasLootDefaultFrame")
		table.insert(UISpecialFrames, "AtlasLootOptionsFrame")
		-- Set up options frame
		AtlasLootOptions_OnLoad()
		-- Legacy code for those using the ultimately failed attempt at making Atlas load on demand
		if AtlasButton_LoadAtlas then
			AtlasButton_LoadAtlas()
		end
		-- Hook the necessary Atlas functions
		Original_Atlas_Refresh = Atlas_Refresh
		Atlas_Refresh = AtlasLoot_Refresh
		Original_Atlas_OnShow = Atlas_OnShow
		Atlas_OnShow = AtlasLoot_Atlas_OnShow
		-- Instead of hooking, replace the scrollbar driver function
		Original_AtlasScrollBar_Update = AtlasScrollBar_Update
		AtlasScrollBar_Update = AtlasLoot_AtlasScrollBar_Update
		-- Disable options that don't have the supporting mods
		if not LootLink_SetTooltip and (AtlasLootCharDB.LootlinkTT == true) then
			AtlasLootCharDB.LootlinkTT = false
			AtlasLootCharDB.DefaultTT = true
		end
		if not ItemSync and (AtlasLootCharDB.ItemSyncTT == true) then
			AtlasLootCharDB.ItemSyncTT = false
			AtlasLootCharDB.DefaultTT = true
		end
		if (not IsAddOnLoaded("EQCompare") and not IsAddOnLoaded("EquipCompare")) and (AtlasLootCharDB.EquipCompare == true) then
			AtlasLootCharDB.EquipCompare = false
		end
		-- If using an opaque items frame, change the alpha value of the backing texture
		if AtlasLootCharDB.Opaque then
			AtlasLootItemsFrame_Background:SetTexture(0, 0, 0, 1)
			AtlasLootItemsFrame:SetBackdropColor(0, 0, 0, 1)
			AtlasLoot.BackdropColor[4] = 1
		else
			AtlasLootItemsFrame_Background:SetTexture(0, 0, 0, 0.65)
			AtlasLootItemsFrame:SetBackdropColor(0, 0, 0, 0.65)
			AtlasLoot.BackdropColor[4] = 0.65
		end

		if AtlasLootCharDB.FirstTime == nil or AtlasLootCharDB.FirstTime == true then
			StaticPopup_Show("ATLASLOOT_SETUP")
			AtlasLootCharDB.FirstTime = false
		end

		for k, v in pairs(AtlasLootCharDB["WishList"]) do
			if type(v[2]) == "table" then
				v[2] = v[2][3] or "INV_Misc_QuestionMark"
				break
			end
		end
		-- Adds an AtlasLoot button to the Feature Frame in Cosmos
		if EarthFeature_AddButton then
			EarthFeature_AddButton(
				{
					id = string.sub(ATLASLOOT_VERSION, 11, 28),
					name = string.sub(ATLASLOOT_VERSION, 11, 28),
					subtext = string.sub(ATLASLOOT_VERSION, 30, 39),
					tooltip = "",
					icon = "Interface\\Icons\\INV_Box_01",
					callback = AtlasLoot_ShowMenu,
					test = nil,
				}
			)
			-- Adds AtlasLoot to old style Cosmos installations
		elseif Cosmos_RegisterButton then
			Cosmos_RegisterButton(
				string.sub(ATLASLOOT_VERSION, 11, 28),
				string.sub(ATLASLOOT_VERSION, 11, 28),
				"",
				"Interface\\Icons\\INV_Box_01",
				AtlasLoot_ShowMenu
			)
		end
		-- Set up the menu in the loot browser
		AtlasLoot_HewdropRegister()
		-- Enable or disable AtlasLootFu based on seleced options
		-- If EquipCompare is available, use it
		if IsAddOnLoaded("EquipCompare") and AtlasLootCharDB.EquipCompare == true then
			EquipCompare_RegisterTooltip(AtlasLootTooltip)
			EquipCompare_RegisterTooltip(AtlasLootTooltip2)
		end
		if IsAddOnLoaded("EQCompare") and (AtlasLootCharDB.EquipCompare == true) then
			EQCompare:RegisterTooltip(AtlasLootTooltip)
			EQCompare:RegisterTooltip(AtlasLootTooltip2)
		end
		-- Position relevant UI objects for loot browser and set up menu
		AtlasLootDefaultFrame_SelectedCategory:SetPoint("TOP", "AtlasLootDefaultFrame_Menu", "BOTTOM", 0, -4)
		AtlasLootDefaultFrame_SelectedCategory:SetText("")
		AtlasLootDefaultFrame_SelectedTable:SetPoint("TOP", "AtlasLootDefaultFrame_SubMenu", "BOTTOM", 0, -4)
		AtlasLootDefaultFrame_SelectedTable:SetText("")
		AtlasLootDefaultFrame_SelectedTable:Show()
		AtlasLootDefaultFrame_SubMenu:Disable()

		AtlasLootMinimapButton_Init()
	end
end

--[[
AtlasLootOptions_OnLoad:
Function is loaded when the addon is loaded
]]
function AtlasLootOptions_OnLoad()
	-- Disable checkboxes of missing addons
	if not LootLink_SetTooltip then
		AtlasLootOptionsFrameLootlinkTT:Disable()
		AtlasLootOptionsFrameLootlinkTTText:SetText(AL["|cff9d9d9dLootlink Tooltips|r"])
	end
	if not ItemSync then
		AtlasLootOptionsFrameItemSyncTT:Disable()
		AtlasLootOptionsFrameItemSyncTTText:SetText(AL["|cff9d9d9dItemSync Tooltips|r"])
	end
	if not IsAddOnLoaded("EQCompare") and not IsAddOnLoaded("EquipCompare") then
		AtlasLootOptionsFrameEquipCompare:Disable()
		AtlasLootOptionsFrameEquipCompareText:SetText(AL["|cff9d9d9dUse EquipCompare|r"])
	end
	AtlasLootOptions_Init()
end

--[[
AtlasLootOptions_Init:
Initiates the options.
]]
function AtlasLootOptions_Init()
	-- clear saved vars for a new version (or a new install!)
	if AtlasLootCharDB.FirstTime == nil then
		AtlasLootOptions_Fresh()
	end
	-- Initialise all the check boxes on the options frame
	AtlasLootOptionsFrameDefaultTT:SetChecked(AtlasLootCharDB.DefaultTT)
	AtlasLootOptionsFrameLootlinkTT:SetChecked(AtlasLootCharDB.LootlinkTT)
	AtlasLootOptionsFrameItemSyncTT:SetChecked(AtlasLootCharDB.ItemSyncTT)
	AtlasLootOptionsFrameShowSource:SetChecked(AtlasLootCharDB.ShowSource)
	AtlasLootOptionsFrameWishlistGroupedByDungeon:SetChecked(AtlasLootCharDB.WishlistGroupedByDungeon)
	AtlasLootOptionsFrameEquipCompare:SetChecked(AtlasLootCharDB.EquipCompare)
	AtlasLootOptionsFrameOpaque:SetChecked(AtlasLootCharDB.Opaque)
	AtlasLootOptionsFrameItemID:SetChecked(AtlasLootCharDB.ItemIDs)
	AtlasLootOptionsFrameHidePanel:SetChecked(AtlasLootCharDB.HidePanel)
	AtlasLootOptionsFrameMinimap:SetChecked(AtlasLootCharDB.MinimapButton)
	AtlasLootOptionsFrameSliderButtonPos:SetValue(AtlasLootCharDB.MinimapButtonPosition)
	AtlasLootOptionsFrameSliderButtonRad:SetValue(AtlasLootCharDB.MinimapButtonRadius)
	AtlasLootMinimapButton:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (AtlasLootCharDB.MinimapButtonRadius * cos(AtlasLootCharDB.MinimapButtonPosition)),
		(AtlasLootCharDB.MinimapButtonRadius * sin(AtlasLootCharDB.MinimapButtonPosition)) - 55
	)
end

--[[
Atlas_FreshOptions:
Sets default options on a fresh start.
]]
function AtlasLootOptions_Fresh()
	AtlasLootCharDB.DefaultTT = true
	AtlasLootCharDB.LootlinkTT = false
	AtlasLootCharDB.ItemSyncTT = false
	AtlasLootCharDB.ShowSource = true
	AtlasLootCharDB.WishlistGroupedByDungeon = true
	AtlasLootCharDB.EquipCompare = false
	AtlasLootCharDB.Opaque = false
	AtlasLootCharDB.ItemIDs = false
	AtlasLootCharDB.FirstTime = true
	AtlasLootCharDB.MinimapButton = true
	AtlasLootCharDB.MinimapButtonPosition = 315
	AtlasLootCharDB.MinimapButtonRadius = 78
	AtlasLootCharDB.HidePanel = false
	AtlasLootCharDB.LastBoss = "DUNGEONSMENU1"
	AtlasLootCharDB.LastBossText = AL["Dungeons & Raids"]
	AtlasLootCharDB.PartialMatching = true
end

--[[
AtlasLoot_OnLoad:
Performs inital setup of the mod and registers it for further setup when
the required resources are in place
]]
function AtlasLoot_OnLoad()
	this:RegisterEvent("ADDON_LOADED")
	-- Enable the use of /al or /atlasloot to open the loot browser
	SLASH_ATLASLOOT1 = "/atlasloot"
	SLASH_ATLASLOOT2 = "/al"
	SlashCmdList["ATLASLOOT"] = function(msg)
		AtlasLoot_SlashCommand(msg)
	end
	AtlasLootItemsFrame.refresh = {}
	AtlasLootItemsFrame.queue = {}
	AtlasLootItemsFrame_BACK:SetText(AL["Back"])
	AtlasLootItemsFrame_QuickLooks:SetText(AL["Add to QuickLooks:"])
end

--[[
AtlasLoot_SlashCommand(msg):
msg - takes the argument for the /atlasloot command so that the appropriate action can be performed
If someone types /atlasloot, bring up the options box
]]
function AtlasLoot_SlashCommand(msg)
	if msg == AL["reset"] then
		AtlasLootOptions_ResetPosition()
	elseif msg == AL["default"] then
		AtlasLootOptions_DefaultSettings()
	elseif msg == AL["options"] then
		AtlasLootOptions_Toggle()
	else
		AtlasLootDefaultFrame:Show()
	end
end

--[[
AtlasLoot_SetupForAtlas:
This function sets up the Atlas specific XML objects
]]
function AtlasLoot_SetupForAtlas()
	-- Poisition the frame with the AtlasLoot version details in the Atlas frame
	AtlasLootInfo:ClearAllPoints()
	AtlasLootInfo:SetParent(AtlasFrame)
	AtlasLootInfo:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 546, -3)
	AtlasLootInfo:SetFrameLevel(AtlasFrame:GetFrameLevel() + 1)
	AtlasLootInfo:Show()
	-- Anchor the bottom panel to the Atlas frame
	AtlasLootPanel:ClearAllPoints()
	AtlasLootPanel:SetParent(AtlasFrame)
	AtlasLootPanel:SetPoint("TOP", "AtlasFrame", "BOTTOM", 0, 9)
	AtlasLootPanel:SetFrameLevel(AtlasFrame:GetFrameLevel() + 1)
	AtlasLootPanel:Show()
	AtlasLoot_AnchorPoint = Anchor_Atlas
	AtlasLootItemsFrame:Hide()
end

--[[
AtlasLoot_AtlasScrollBar_Update:
Hooks the Atlas scroll frame.
Required as the Atlas function cannot deal with the AtlasLoot button template or the added Atlasloot entries
]]
function AtlasLoot_AtlasScrollBar_Update()
	Original_AtlasScrollBar_Update()
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone]
	-- Make note of how far in the scroll frame we are
	for line = 1, ATLAS_NUM_LINES do
		local lineplusoffset = line + FauxScrollFrame_GetOffset(AtlasScrollBar)
		local entry = _G["AtlasEntry"..line]
		local loot = _G["AtlasEntry"..line.."_Loot"]
		local selected = _G["AtlasEntry"..line.."_Selected"]
		if loot and lineplusoffset <= ATLAS_CUR_LINES then
			local showIcon = AtlasLootBossButtons[zoneID] and AtlasLootBossButtons[zoneID][lineplusoffset]
			if AtlasLootItemsFrame.activeBoss == lineplusoffset then
				entry:Enable()
				loot:Hide()
				selected:Show()
			elseif showIcon then
				entry:Enable()
				loot:Show()
				selected:Hide()
			else
				entry:Disable()
				loot:Hide()
				selected:Hide()
			end
			entry.idnum = lineplusoffset
		end
	end
end

--[[
AtlasLoot_Refresh:
Replacement for Atlas_Refresh, required as the template for the boss buttons in Atlas is insufficient
Called whenever the state of Atlas changes
]]
function AtlasLoot_Refresh(keepSelection)
	-- Reset which loot page is 'current'
	if not keepSelection then
		AtlasLootItemsFrame.activeBoss = nil
	end
	if AtlasLootItemsFrame.activeBoss then
		AtlasLootItemsFrame:Show()
	else
		AtlasLootItemsFrame:Hide()
	end
	-- Call original function
	Original_Atlas_Refresh()

	for i = 1, ATLAS_NUM_LINES do
		local entry = _G["AtlasEntry"..i]
		if entry and not _G["AtlasEntry"..i.."_Loot"] then
			-- Add deselected icon
			local loot = entry:CreateTexture("$parent_Loot", "OVERLAY")
			loot:SetWidth(16)
			loot:SetHeight(16)
			loot:SetPoint("RIGHT", entry, 0, 0)
			loot:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\looticon")
			loot:Show()
			-- Add selected icon
			local selected = entry:CreateTexture("$parent_Selected", "OVERLAY")
			selected:SetWidth(16)
			selected:SetHeight(16)
			selected:SetPoint("RIGHT", entry, 0, 0)
			selected:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\gold")
			selected:Hide()
			-- Add OnClick function
			entry:SetScript("OnClick", AtlasLootBoss_OnClick)
			entry:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		end
	end
end

--[[
AtlasLoot_Atlas_OnShow:
Hooks Atlas_OnShow() to add extra setup routines that AtlasLoot needs for
integration purposes.
]]
function AtlasLoot_Atlas_OnShow()
	AtlasLoot_Refresh(true)
	-- We don't want Atlas and the Loot Browser open at the same time, so the Loot Browser is close
	if AtlasLootDefaultFrame then
		AtlasLootDefaultFrame:Hide()
		AtlasLoot_SetupForAtlas()
	end
	-- Call the Atlas function
	Original_Atlas_OnShow()
	-- If we were looking at a loot table earlier in the session, it is still
	-- saved on the item frame, so restore it in Atlas
	if AtlasLootItemsFrame.activeBoss then
		AtlasLootItemsFrame:Show()
	else
		AtlasLootItemsFrame:Hide()
	end
	-- Consult the saved variable table to see whether to show the bottom panel
	if AtlasLootCharDB.HidePanel == true then
		AtlasLootPanel:Hide()
	else
		AtlasLootPanel:Show()
	end
	AtlasLoot_AtlasScrollBar_Update()
	AtlasLootItemsFrame_Background:Show()
	AtlasLootItemsFrame:SetBackdrop(nil)
end

--[[
AtlasLoot_Toggle:
Simple function to toggle the visibility of the AtlasLoot frame.
]]
function AtlasLoot_Toggle()
	if AtlasLootDefaultFrame:IsVisible() then
		HideUIPanel(AtlasLootDefaultFrame)
	else
		ShowUIPanel(AtlasLootDefaultFrame)
	end
end

--[[
AtlasLootBoss_OnClick:
Invoked whenever a boss line in Atlas is clicked
Shows a loot page if one is associated with the button
]]
function AtlasLootBoss_OnClick()
	local name = this:GetName()
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone]
	local id = this.idnum
	-- If the loot table was already shown and boss clicked again, hide the loot table and fix boss list icons
	if _G[name.."_Selected"]:IsVisible() then
		_G[name.."_Selected"]:Hide()
		_G[name.."_Loot"]:Show()
		AtlasLootItemsFrame:Hide()
		AtlasLootItemsFrame.activeBoss = nil
	else
		-- If an loot table is associated with the button, show it.  Note multiple tables need to be checked due to the database structure
		if AtlasLootBossButtons[zoneID] and AtlasLootBossButtons[zoneID][id] then
			_G[name.."_Selected"]:Show()
			_G[name.."_Loot"]:Hide()
			AtlasLoot_ShowItemsFrame(AtlasLootBossButtons[zoneID][id])
			AtlasLootItemsFrame.activeBoss = id
			AtlasLoot_AtlasScrollBar_Update()
		end
	end
	-- This has been invoked from Atlas, so we remove any claim external mods have on the loot table
	AtlasLootItemsFrame.externalBoss = nil
	-- Hide the AtlasQuest frame if present so that the AtlasLoot items frame is not stuck under it
	if AtlasQuestInsideFrame then
		AtlasQuestInsideFrame:Hide()
	end
end

--[[
AtlasLoot_ShowMenu:
Legacy function used in Cosmos integration to open the loot browser
]]
function AtlasLoot_ShowMenu()
	AtlasLootDefaultFrame:Show()
end

--[[
AtlasLootOptions_DefaultTTToggle:
Toggles DefaultTooltips. Uses default tooltips.
]]
function AtlasLootOptions_DefaultTTToggle()
	AtlasLootCharDB.DefaultTT = true
	AtlasLootCharDB.LootlinkTT = false
	AtlasLootCharDB.ItemSyncTT = false
	AtlasLootOptions_Init()
end

--[[
AtlasLootOptions_LootlinkTTToggle:
Toggles Lootlink tooltips instead of the default ones.
]]
function AtlasLootOptions_LootlinkTTToggle()
	AtlasLootCharDB.DefaultTT = false
	AtlasLootCharDB.LootlinkTT = true
	AtlasLootCharDB.ItemSyncTT = false
	AtlasLootOptions_Init()
end

--[[
AtlasLootOptions_ItemSyncTTToggle:
Toggles ItemSync tooltips instead of the default ones.
]]
function AtlasLootOptions_ItemSyncTTToggle()
	AtlasLootCharDB.DefaultTT = false
	AtlasLootCharDB.LootlinkTT = false
	AtlasLootCharDB.ItemSyncTT = true
	AtlasLootOptions_Init()
end

function AtlasLootOptions_ShowSourceToggle()
	if AtlasLootCharDB.ShowSource then
		AtlasLootCharDB.ShowSource = false
	else
		AtlasLootCharDB.ShowSource = true
	end
	AtlasLootOptions_Init()
end

function AtlasLootOptions_WishlistGroupedByDungeonToggle()
	if AtlasLootCharDB.WishlistGroupedByDungeon then
		AtlasLootCharDB.WishlistGroupedByDungeon = false
	else
		AtlasLootCharDB.WishlistGroupedByDungeon = true
	end
	AtlasLootOptions_Init()
	AtlasLoot_WishList = AtlasLoot_CategorizeWishList(AtlasLootCharDB["WishList"])
	if AtlasLootItemsFrame.refresh[2] == "WishList" then
		AtlasLoot_ShowWishList()
	end
end

--[[
AtlasLootOptions_EquipCompareToggle:
Toggles EquipCompare. Adds a tooltip with the equipped item (if it's the case) next to the default one.
]]
function AtlasLootOptions_EquipCompareToggle()
	if AtlasLootCharDB.EquipCompare then
		AtlasLootCharDB.EquipCompare = false
		if IsAddOnLoaded("EquipCompare") then
			EquipCompare_UnregisterTooltip(AtlasLootTooltip)
			EquipCompare_UnregisterTooltip(AtlasLootTooltip2)
		end
		if IsAddOnLoaded("EQCompare") then
			EQCompare:UnRegisterTooltip(AtlasLootTooltip)
			EQCompare:UnRegisterTooltip(AtlasLootTooltip2)
		end
	else
		AtlasLootCharDB.EquipCompare = true
		if IsAddOnLoaded("EquipCompare") then
			EquipCompare_RegisterTooltip(AtlasLootTooltip)
			EquipCompare_RegisterTooltip(AtlasLootTooltip2)
		end
		if IsAddOnLoaded("EQCompare") then
			EQCompare:RegisterTooltip(AtlasLootTooltip)
			EQCompare:RegisterTooltip(AtlasLootTooltip2)
		end
	end
	AtlasLootOptions_Init()
end

--[[
AtlasLootOptions_OpaqueToggle:
Toggles opacity of the items frame.
]]
function AtlasLootOptions_OpaqueToggle()
	AtlasLootCharDB.Opaque = AtlasLootOptionsFrameOpaque:GetChecked()
	if AtlasLootCharDB.Opaque then
		AtlasLootItemsFrame_Background:SetTexture(0, 0, 0, 1)
		AtlasLootItemsFrame:SetBackdropColor(0, 0, 0, 1)
		AtlasLoot.BackdropColor[4] = 1
	else
		AtlasLootItemsFrame_Background:SetTexture(0, 0, 0, 0.65)
		AtlasLootItemsFrame:SetBackdropColor(0, 0, 0, 0.65)
		AtlasLoot.BackdropColor[4] = 0.65
	end
	AtlasLootOptions_Init()
end

--[[
AtlasLootOptions_ItemIDToggle:
Toggles items ID.
]]
function AtlasLootOptions_ItemIDToggle()
	if AtlasLootCharDB.ItemIDs then
		AtlasLootCharDB.ItemIDs = false
	else
		AtlasLootCharDB.ItemIDs = true
	end
	AtlasLootOptions_Init()
end

--[[
AtlasLootOptions_Toggle:
Toggle on/off the options window
]]
function AtlasLootOptions_Toggle()
	if AtlasLootOptionsFrame:IsVisible() then
		-- Hide the options frame if already shown
		AtlasLootOptionsFrame:Hide()
	else
		AtlasLootOptionsFrame:Show()
		-- Workaround for a weird quirk where tooltip settings so not immediately take effect
		if AtlasLootCharDB.DefaultTT == true then
			AtlasLootOptions_DefaultTTToggle()
		elseif AtlasLootCharDB.LootlinkTT == true then
			AtlasLootOptions_LootlinkTTToggle()
		elseif AtlasLootCharDB.ItemSyncTT == true then
			AtlasLootOptions_ItemSyncTTToggle()
		end
	end
end

function AtlasLootItemsFrame_OnUpdate(self, elapsed)
	if not self.refreshTime then return end
	self.refreshTime = self.refreshTime - elapsed
	local done = true
	for item in pairs(self.queue) do
		if not GetItemInfo(item) then done = false break end
	end
	if done or self.refreshTime <= 0 then
		self.refreshTime = nil
		for k in pairs(self.queue) do self.queue[k] = nil end
		if self.refresh and self.refresh[1] and self.refresh[2] and self.refresh[3] then
			AtlasLoot_ShowItemsFrame(self.refresh[1], self.refresh[2], self.refresh[3])
		end
	end
end

-- It is the workhorse of the mod and allows the loot tables to be displayed any way anywhere in any mod.
---@param dataID       string    loot table key
---@param parentID?    string    parent table key where dataID lives
---@param title?       string    text string to use as a title for the loot page
function AtlasLoot_ShowItemsFrame(dataID, parentID, title)
	if not dataID then return end

	AtlasLootItemsFrame.refreshTime = nil
	for itemID in pairs(AtlasLootItemsFrame.queue) do AtlasLootItemsFrame.queue[itemID] = nil end

	if AtlasLootItemsFrameContainer:IsShown() and dataID ~= AtlasLootItemsFrame.refresh[1] then
		AtlasLootItemsFrameContainer:Hide()
	end

	if not parentID then
		parentID = AtlasLoot_TableNames[dataID] and AtlasLoot_TableNames[dataID][2] or "AtlasLootFallback"
	end
	if not title then
		title = AtlasLoot_TableNames[dataID] and AtlasLoot_TableNames[dataID][1] or ""
	end

	local data
	local page, maxPages = 1, 1
	local isWishList = string.sub(dataID, 1, 8) == "WishList"
	local isSearchResult = string.sub(dataID, 1, 12) == "SearchResult"

	if isWishList or isSearchResult then
		page = tonumber((string.gsub(dataID, ".+Page(%d+)", "%1", 1)))
		-- Aquiring items of the page
		if isSearchResult then
			data, maxPages = AtlasLoot:GetSearchResultPage(page)
			title = string.format((AL["Search Result: %s"]), AtlasLootCharDB.LastSearchedText or "")
			parentID = "SearchResult"
		elseif isWishList then
			data, maxPages = AtlasLoot_GetWishListPage(page)
			title = AL["WishList"]
			parentID = "WishList"
		end
		-- Make page number reasonable
		if page < 1 then page = 1 end
		if page > maxPages then page = maxPages end
	else
		data = AtlasLoot_Data[parentID] and AtlasLoot_Data[parentID][dataID]
	end

	if not data then return end

	AtlasLootCharDB.LastBossText = title
	AtlasLootCharDB.LastBoss = dataID

	-- Get AtlasQuest out of the way
	if AtlasQuestInsideFrame then
		AtlasQuestInsideFrame:Hide()
	end

	-- Store data about the state of the items frame to allow minor tweaks or a recall of the current loot page
	AtlasLootItemsFrame.refresh[1] = dataID
	AtlasLootItemsFrame.refresh[2] = parentID
	AtlasLootItemsFrame.refresh[3] = title
	AtlasLootItemsFrame.refresh[4] = AtlasLoot_AnchorPoint

	for i = 1, 30 do
		local button = _G["AtlasLootItem_"..i]
		button:Hide()
		button.itemID = nil
		button.itemIDExtra = nil
		button.itemIDName = nil
		button.dressingroomID = nil
		button.droprate = nil
		button.container = nil
		button.lootpage = nil
		button.sourcePage = nil
		button.dataSource = nil
		button._IconBorder:SetVertexColor(1, 1, 1)
		button._Quantity:SetText("")
		for j = 1, 5 do
			button["_PriceText"..j]:Hide()
			button["_PriceIcon"..j]:Hide()
		end
	end

	-- TODO: get rid of menus special case (?)
	if parentID == "MENUS" then
		for i = 1, table.getn(data) do
			local buttonIndex = data[i][1]
			local button = _G["AtlasLootItem_"..buttonIndex]
			if button then
				local buttonIcon = button._Icon
				local buttonName = button._Name
				local buttonExtra = button._Extra
				local quantity = button._Quantity
				local iconBorder = button._IconBorder
				local containerBorder = button._ContainerBorder
				local containerHighlight = button._ContainerBorderHighlight
				local lootPage = data[i][2]
				local iconData = data[i][3] or ""
				local container = data[i][6]
				local text = data[i][4]
				local extra = data[i][5]
				buttonName:SetText(text)
				buttonExtra:SetText(extra)
				if type(container) == "table" then
					button.container = container
					for row = 1, table.getn(container) do
						for item = 1, table.getn(container[row]) do
							AtlasLoot_CacheItem(container[row][item][1])
						end
					end
					containerBorder:Show()
					containerHighlight:Show()
				else
					button.lootpage = lootPage
					containerBorder:Hide()
					containerHighlight:Hide()
				end
				
				if string.sub(iconData, 1, 1) == "$" then
					buttonIcon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\"..string.sub(iconData, 2))
				else
					buttonIcon:SetTexture("Interface\\Icons\\"..iconData)
				end
				if buttonIcon:GetTexture() == nil or iconData == "" then
					buttonIcon:Hide()
					iconBorder:Hide()
					buttonName:SetPoint("TOPLEFT", buttonIcon, "TOPLEFT", 3, 0)
					if not extra or extra == "" then
						buttonName:SetPoint("TOPLEFT", buttonIcon, "TOPLEFT", 3, -8)
					end
					button._Highlight:Hide()
				else
					buttonIcon:Show()
					iconBorder:Show()
					buttonName:SetPoint("TOPLEFT", buttonIcon, "TOPRIGHT", 3, 0)
					button._Highlight:Show()
				end
				button:Show()
			end
		end
	else
		-- Iterate through each item object and set its properties
		for i = 1, 30 do
			-- Check for a valid object (that it exists, and that it has a name)
			local button = _G["AtlasLootItem_"..i]
			if data[i] and data[i][3] ~= "" then
				-- Use shortcuts for easier reference to parts of the item button
				local buttonIcon = button._Icon
				local buttonName = button._Name
				local buttonExtra = button._Extra
				local quantity = button._Quantity
				local iconBorder = button._IconBorder
				local containerBorder = button._ContainerBorder
				local containerHighlight = button._ContainerBorderHighlight
				local isItem, isEnchant, isSpell
				local prefix = string.sub(data[i][1], 1, 1)
				local text = AtlasLoot_FixText(data[i][3])
				local extra = AtlasLoot_FixText(data[i][4])
				local iconData = data[i][2] or ""
				local spellIcon
				if prefix == "s" then
					isSpell = true
				elseif prefix == "e" then
					isEnchant = true
				else
					isItem = true
				end
				if isItem then
					local itemID = tonumber(data[i][1])
					local itemName, _, itemQuality = GetItemInfo(itemID)
					-- If the client has the name of the item in cache, use that instead.
					if itemName then
						local r, g, b, itemColor = GetItemQualityColor(itemQuality)
						text = itemColor..itemName
						iconBorder:SetVertexColor(r, g, b)
					else
						if itemID and itemID ~= 0 then
							AtlasLootCacheTooltip:SetHyperlink("item:"..itemID)
							AtlasLootItemsFrame.refreshTime = refreshTimeout
							AtlasLootItemsFrame.queue[itemID] = true
							iconBorder:SetVertexColor(1, 0, 0)
						end
					end
					quantity:SetText(data[i][8])
					button.dressingroomID = itemID
				elseif isEnchant then
					local spellName
					local spellID = tonumber(string.sub(data[i][1], 2))
					local craftItem = tonumber(GetSpellInfoAtlasLootDB["enchants"][spellID]["item"])
					if SpellInfo then
						spellName = SpellInfo(spellID)
					else
						if spellID and spellID ~= 0 then
							AtlasLootCacheTooltip:SetHyperlink("enchant:"..spellID)
							spellName = AtlasLootCacheTooltipTextLeft1:GetText()
						end
						if not (spellName and spellName ~= "") then
							spellName = GetSpellInfoAtlasLootDB["enchants"][spellID]["name"]
						end
					end
					spellIcon = data[i][2]
					if craftItem then
						local r, g, b, color, quality
						text, _, quality = GetItemInfo(craftItem)
						if not text then
							if craftItem and craftItem ~= 0 then
								AtlasLootCacheTooltip:SetHyperlink("item:"..craftItem)
								AtlasLootItemsFrame.refreshTime = refreshTimeout
								AtlasLootItemsFrame.queue[craftItem] = true
							end
							text = AtlasLoot_FixText(spellName)
						end
						if quality then
							r, g, b, color = GetItemQualityColor(quality)
							text = color..(text or "")
							iconBorder:SetVertexColor(r, g, b)
						end
						button.dressingroomID = craftItem
					else
						text = spellName
					end
					quantity:SetText("")
				elseif isSpell then
					local spellName
					local spellID = tonumber(string.sub(data[i][1], 2))
					local craftItem = tonumber(GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftItem"])
					local reagents = GetSpellInfoAtlasLootDB["craftspells"][spellID]["reagents"]
					if type(reagents) == "table" then
						for j = 1, table.getn(reagents) do
							local reagent = GetSpellInfoAtlasLootDB["craftspells"][spellID]["reagents"][j]
							if not GetItemInfo(reagent[1]) then
								AtlasLootCacheTooltip:SetHyperlink("item:"..reagent[1])
							end
						end
					end
					if SpellInfo then
						spellName = SpellInfo(spellID)
					else
						spellName = GetSpellInfoAtlasLootDB["craftspells"][spellID]["name"]
					end
					spellIcon = data[i][2]
					if craftItem then
						local r, g, b, color, quality
						text, _, quality = GetItemInfo(craftItem)
						if not text then
							if craftItem ~= 0 then
								AtlasLootCacheTooltip:SetHyperlink("item:"..craftItem)
								text = AtlasLoot_FixText(spellName)
								AtlasLootItemsFrame.refreshTime = refreshTimeout
								AtlasLootItemsFrame.queue[craftItem] = true
							end
						end
						if quality then
							r, g, b, color = GetItemQualityColor(quality)
							text = color..(text or "")
							iconBorder:SetVertexColor(r, g, b)
						end
						button.dressingroomID = craftItem
					else
						text = spellName
					end
					local qtyMin = GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftQuantityMin"]
					local qtyMax = GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftQuantityMax"]
					if qtyMin then
						if qtyMax then
							quantity:SetText(qtyMin.."-"..qtyMax)
						else
							quantity:SetText(qtyMin)
						end
					else
						quantity:SetText("")
					end
				end
				-- If there is no data on the texture an item should have, show a big red question mark
				if string.sub(iconData, 1, 1) == "$" then
					buttonIcon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\"..string.sub(iconData, 2))
				elseif isItem and type(data[i][1]) == "number" then
					local _, _, _, _, _, _, _, _, texture = GetItemInfo(data[i][1])
					if not texture and type(iconData) == "string" then
						texture = "Interface\\Icons\\"..iconData
					end
					buttonIcon:SetTexture(texture)
				elseif not isItem and spellIcon then
					if type(iconData) == "number" then
						local _, _, _, _, _, _, _, _, texture = GetItemInfo(iconData)
						buttonIcon:SetTexture(texture)
					elseif type(iconData) == "string" then
						buttonIcon:SetTexture("Interface\\Icons\\"..iconData)
					else
						buttonIcon:SetTexture(spellIcon)
					end
				else
					buttonIcon:SetTexture("Interface\\Icons\\"..iconData)
				end
				if buttonIcon:GetTexture() == nil or iconData == "" then
					buttonIcon:Hide()
					iconBorder:Hide()
					buttonName:SetPoint("TOPLEFT", buttonIcon, "TOPLEFT", 3, 0)
					if not extra or extra == "" then
						buttonName:SetPoint("TOPLEFT", buttonIcon, "TOPLEFT", 3, -8)
					end
					button._Highlight:Hide()
				else
					buttonIcon:Show()
					iconBorder:Show()
					buttonName:SetPoint("TOPLEFT", buttonIcon, "TOPRIGHT", 3, 0)
					button._Highlight:Show()
				end
				-- Set the name and description of the item
				buttonName:SetText(text)
				buttonExtra:SetText(extra)
				-- Set prices for items, up to 5 different currencies can be used in combination
				local index = 1
				local prices = data[i][6]
				if type(prices) == "table" then
					for j = 1, table.getn(prices), 2 do
						local pricetext = button["_PriceText"..index]
						local priceicon = button["_PriceIcon"..index]
						if prices[j] and prices[j + 1] and prices[j] ~= "" and prices[j + 1] ~= "" then
							pricetext:SetText(prices[j])
							priceicon:SetTexture(AtlasLoot_FixText(prices[j + 1]))
							pricetext:Show()
							priceicon:Show()
						end
						index = index + 1
					end
				end
				if (isWishList or isSearchResult) and data[i][5] then
					local _, _, wishDataID, wishDataSource = string.find(data[i][5], "(.+)|(.+)")
					if wishDataSource == "AtlasLootRepItems" then
						if wishDataID then
							for _, v in ipairs(AtlasLoot_Data[wishDataSource][wishDataID]) do
								if data[i][1] == v[1] then
									index = 1
									for j = 6, 14, 2 do
										local pricetext = button["_PriceText"..index]
										local priceicon = button["_PriceIcon"..index]
										if v[j] and v[j] ~= "" then
											pricetext:SetText(v[j])
											priceicon:SetTexture(AtlasLoot_FixText(v[j + 1]))
											pricetext:Show()
											priceicon:Show()
										end
										index = index + 1
									end
									break
								end
							end
						end
					end
					if wishDataSource == "AtlasLootItems" and AtlasLootCharDB.WishlistGroupedByDungeon then
						-- Set boss
						if wishDataID then
							for _, v in ipairs(AtlasLoot_Data[wishDataSource][wishDataID]) do
								if data[i][1] == v[1] then
									local boss = AtlasLoot_GetWishListSubheadingBoss(wishDataID)
									if boss then
										buttonExtra:SetText(extra.." - "..boss)
									end
								end
							end
						end
					end
				end
				-- For convenience, we store information about the objects in the objects so that it can be easily accessed later
				button.itemID = data[i][1]
				button.itemIDName = data[i][3]
				button.itemIDExtra = data[i][4]
				button.container = data[i][7]
				if type(button.container) == "table" then
					containerBorder:Show()
					containerHighlight:Show()
					for row = 1, table.getn(button.container) do
						for item = 1, table.getn(button.container[row]) do
							AtlasLoot_CacheItem(button.container[row][item][1])
						end
					end
				else
					containerHighlight:Hide()
					containerBorder:Hide()
				end
				if isWishList or isSearchResult then
					button.sourcePage = data[i][5]
				else
					local droprate = data[i][5]
					if droprate and string.find(droprate, "%", 1, true) then
						button.droprate = droprate
					end
				end
				button:Show()
				if GetMouseFocus() == button then
					AtlasLootItem_OnEnter(button)
				end
			else
				button:Hide()
			end
		end
	end
	if not (isWishList or isSearchResult) then
		-- This is a valid QuickLook, so show the UI objects
		AtlasLootItemsFrame_QuickLooks:Show()
		AtlasLootQuickLooksButton:Show()
	else
		AtlasLootItemsFrame_QuickLooks:Hide()
		AtlasLootQuickLooksButton:Hide()
	end
	-- Hide navigation buttons by default, only show what we need
	AtlasLootItemsFrame_BACK:Hide()
	AtlasLootItemsFrame_NEXT:Hide()
	AtlasLootItemsFrame_PREV:Hide()
	AtlasLootItemsFrame_BossName:SetText(title)
	-- Consult the button registry to determine what nav buttons are required
	if isWishList or isSearchResult then
		if page < maxPages then
			AtlasLootItemsFrame_NEXT:Show()
			AtlasLootItemsFrame_NEXT.lootpage = string.gsub(dataID, "%d+", (page + 1))
		end
		if page > 1 then
			AtlasLootItemsFrame_PREV:Show()
			AtlasLootItemsFrame_PREV.lootpage = string.gsub(dataID, "%d+", (page - 1))
		end
	elseif AtlasLoot_ButtonRegistry[dataID] then
		local tablebase = AtlasLoot_ButtonRegistry[dataID]
		if tablebase.Next_Page then
			AtlasLootItemsFrame_NEXT:Show()
			AtlasLootItemsFrame_NEXT.lootpage = tablebase.Next_Page
		end
		if tablebase.Prev_Page then
			AtlasLootItemsFrame_PREV:Show()
			AtlasLootItemsFrame_PREV.lootpage = tablebase.Prev_Page
		end
		if tablebase.Back_Page then
			AtlasLootItemsFrame_BACK:Show()
			AtlasLootItemsFrame_BACK.lootpage = tablebase.Back_Page
		end
	end

	-- For Alphamap and Atlas integration, show a 'close' button to hide the loot table and restore the map view
	if AtlasLoot_AnchorPoint ~= Anchor_Default then
		AtlasLootItemsFrame_CloseButton:Show()
	else
		AtlasLootItemsFrame_CloseButton:Hide()
	end

	-- Update selected category and subcategory
	local subMenu = nil
	local bossName = ""
	for k in pairs(AtlasLoot_HewdropDown_SubTables) do
		if subMenu then
			break
		end
		for _, n in pairs(AtlasLoot_HewdropDown_SubTables[k]) do
			if n[2] == dataID then
				subMenu = AtlasLoot_HewdropDown_SubTables[k]
				bossName = n[1]
				break
			end
		end
	end
	if subMenu then
		AtlasLoot_HewdropSubMenuRegister(subMenu)
		AtlasLootDefaultFrame_SubMenu:Enable()
		AtlasLootDefaultFrame_SelectedTable:SetText(bossName)
	else
		AtlasLootDefaultFrame_SubMenu:Disable()
		AtlasLootDefaultFrame_SelectedTable:SetText("")
	end
	local category = AtlasLoot_TableNames[dataID] and AtlasLoot_TableNames[dataID][3] or ""
	AtlasLootDefaultFrame_SelectedCategory:SetText(category)

	-- Anchor the item frame where it is supposed to be
	AtlasLootItemsFrame:SetParent(_G[AtlasLoot_AnchorPoint[2]])
	AtlasLootItemsFrame:ClearAllPoints()
	AtlasLootItemsFrame:SetPoint(AtlasLoot_AnchorPoint[1], AtlasLoot_AnchorPoint[2], AtlasLoot_AnchorPoint[3], AtlasLoot_AnchorPoint[4], AtlasLoot_AnchorPoint[5])
	AtlasLootItemsFrame:Show()
end

--[[
AtlasLoot_HewdropClick(tablename, text, tabletype):
dataID - Name of the loot table in the database
text - Heading for the loot table
tabletype - Whether the tablename indexes an actual table or needs to generate a submenu
Called when a button in AtlasLoot_Hewdrop is clicked
]]
function AtlasLoot_HewdropClick(dataID, text, tabletype)
	-- If the button clicked was linked to a loot table
	if tabletype == "Table" then
		-- Show the loot table
		AtlasLoot_ShowItemsFrame(dataID)
		-- Purge the text label for the submenu and disable the submenu
		AtlasLootDefaultFrame_SubMenu:Disable()
		AtlasLootDefaultFrame_SelectedTable:SetText("")
		-- If the button links to a sub menu definition
	else
		-- Enable the submenu button
		AtlasLootDefaultFrame_SubMenu:Enable()
		-- Show the first loot table associated with the submenu
		AtlasLoot_ShowItemsFrame(AtlasLoot_HewdropDown_SubTables[dataID][1][2])
		-- Load the correct submenu and associated with the button
		AtlasLoot_HewdropSubMenu:Unregister(AtlasLootDefaultFrame_SubMenu)
		AtlasLoot_HewdropSubMenuRegister(AtlasLoot_HewdropDown_SubTables[dataID])
		-- Show a text label of what has been selected
		AtlasLootDefaultFrame_SelectedTable:SetText(AtlasLoot_HewdropDown_SubTables[dataID][1][1])
	end
	AtlasLoot_Hewdrop:Close(1)
end

--[[
AtlasLoot_HewdropSubMenuClick(tablename, text):
tablename - Name of the loot table in the database
text - Heading for the loot table
Called when a button in AtlasLoot_HewdropSubMenu is clicked
]]
function AtlasLoot_HewdropSubMenuClick(tablename, text)
	-- Show the select loot table
	AtlasLoot_ShowItemsFrame(tablename)
	-- Show the table that has been selected
	AtlasLootDefaultFrame_SelectedTable:SetText(text)
	AtlasLootDefaultFrame_SelectedTable:Show()
	AtlasLoot_HewdropSubMenu:Close(1)
end

--[[
AtlasLoot_HewdropSubMenuRegister(loottable):
loottable - Table defining the sub menu
Generates the sub menu needed by passing a table of loot tables and titles
]]
function AtlasLoot_HewdropSubMenuRegister(loottable)
	AtlasLoot_HewdropSubMenu:Register(AtlasLootDefaultFrame_SubMenu,
		'point', function(parent)
			return "TOP", "BOTTOM"
		end,
		'children', function(level, value)
			if level == 1 then
				for k, v in pairs(loottable) do
					AtlasLoot_HewdropSubMenu:AddLine(
						'text', v[1],
						'func', AtlasLoot_HewdropSubMenuClick,
						'arg1', v[2],
						'arg2', v[1],
						'notCheckable', true
					)
				end
			end
		end,
		'dontHook', true
	)
end

--[[
AtlasLoot_HewdropRegister:
Constructs the main category menu from a tiered table
]]
function AtlasLoot_HewdropRegister()
	AtlasLoot_Hewdrop:Register(AtlasLootDefaultFrame_Menu,
		'point', function(parent)
			return "TOP", "BOTTOM"
		end,
		'children', function(level, value)
			if level == 1 then
				for k, v in ipairs(AtlasLoot_HewdropDown) do
					-- If a link to show a submenu
					if type(v[1]) == "table" and type(v[1][1]) == "string" then
						if v[1][3] == "Submenu" then
							AtlasLoot_Hewdrop:AddLine(
								'text', v[1][1],
								'textR', 1,
								'textG', 0.82,
								'textB', 0,
								'func', AtlasLoot_HewdropClick,
								'arg1', v[1][2],
								'arg2', v[1][1],
								'arg3', v[1][3],
								'notCheckable', true
							)
						end
					else
						local lock = 0
						-- If an entry linked to a subtable
						for i, j in pairs(v) do
							if lock == 0 then
								AtlasLoot_Hewdrop:AddLine(
									'text', AtlasLoot_TableNames[i] and AtlasLoot_TableNames[i][1],
									'textR', 1,
									'textG', 0.82,
									'textB', 0,
									'hasArrow', true,
									'value', j,
									'func', AtlasLoot_OpenMenu,
									'arg1', i,
									'notCheckable', true
								)
								lock = 1
							end
						end
					end
				end
			elseif level == 2 then
				if value then
					for k, v in ipairs(value) do
						if type(v) == "table" then
							if type(v[1]) == "table" and type(v[1][1]) == "string" then
								-- If an entry to show a submenu
								if v[1][3] == "Submenu" then
									AtlasLoot_Hewdrop:AddLine(
										'text', v[1][1],
										'textR', 1,
										'textG', 0.82,
										'textB', 0,
										'func', AtlasLoot_HewdropClick,
										'arg1', v[1][2],
										'arg2', v[1][1],
										'arg3', v[1][3],
										'notCheckable', true
									)
									-- An entry to show a specific loot page
								else
									AtlasLoot_Hewdrop:AddLine(
										'text', v[1][1],
										'textR', 1,
										'textG', 0.82,
										'textB', 0,
										'func', AtlasLoot_HewdropClick,
										'arg1', v[1][2],
										'arg2', v[1][1],
										'arg3', v[1][3],
										'notCheckable', true
									)
								end
							else
								local lock = 0
								-- Entry to link to a sub table
								for i, j in pairs(v) do
									if lock == 0 then
										AtlasLoot_Hewdrop:AddLine(
											'text', i,
											'textR', 1,
											'textG', 0.82,
											'textB', 0,
											'hasArrow', true,
											'value', j,
											'notCheckable', true
										)
										lock = 1
									end
								end
							end
						end
					end
				end
			elseif level == 3 then
				-- Essentially the same as level == 2
				if value then
					for k, v in pairs(value) do
						if type(v[1]) == "string" then
							if v[3] == "Submenu" then
								AtlasLoot_Hewdrop:AddLine(
									'text', v[1],
									'textR', 1,
									'textG', 0.82,
									'textB', 0,
									'func', AtlasLoot_HewdropClick,
									'arg1', v[2],
									'arg2', v[1],
									'arg3', v[3],
									'notCheckable', true
								)
							else
								AtlasLoot_Hewdrop:AddLine(
									'text', v[1],
									'textR', 1,
									'textG', 0.82,
									'textB', 0,
									'func', AtlasLoot_HewdropClick,
									'arg1', v[2],
									'arg2', v[1],
									'arg3', v[3],
									'notCheckable', true
								)
							end
						elseif type(v) == "table" then
							AtlasLoot_Hewdrop:AddLine(
								'text', k,
								'textR', 1,
								'textG', 0.82,
								'textB', 0,
								'hasArrow', true,
								'value', v,
								'notCheckable', true
							)
						end
					end
				end
			end
		end,
		'dontHook', true
	)
end

function AtlasLoot_OpenMenu(dataID)
	AtlasLoot_ShowItemsFrame(dataID)
	CloseDropDownMenus()
end

--[[
AtlasLootItemsFrame_OnCloseButton:
Called when the close button on the item frame is clicked
]]
function AtlasLootItemsFrame_OnCloseButton()
	-- Set no loot table as currently selected
	AtlasLootItemsFrame.activeBoss = nil
	-- Fix the boss buttons so the correct icons are displayed
	if AtlasFrame and AtlasFrame:IsVisible() then
		for i = 1, ATLAS_NUM_LINES do
			if _G["AtlasEntry"..i.."_Selected"] and _G["AtlasEntry"..i.."_Selected"]:IsShown() then
				_G["AtlasEntry"..i.."_Selected"]:Hide()
				_G["AtlasEntry"..i.."_Loot"]:Show()
			end
		end
	end
	-- Hide the item frame
	AtlasLootItemsFrame:Hide()
end

--[[
AtlasLoot_NavButton_OnClick:
Called when <-, -> or 'Back' are pressed and calls up the appropriate loot page
]]
function AtlasLoot_NavButton_OnClick(self)
	CloseDropDownMenus()
	AtlasLoot_ShowItemsFrame(self.lootpage)
end

--[[
AtlasLoot_ShowQuickLooks(button)
button: Identity of the button pressed to trigger the function
Shows the GUI for setting Quicklooks
]]
function AtlasLoot_ShowQuickLooks(button)
	local Hewdrop = AceLibrary("Hewdrop-2.0")
	if Hewdrop:IsOpen(button) then
		Hewdrop:Close(1)
	else
		local setOptions = function()
			Hewdrop:AddLine(
				"text", AL["QuickLook"].." 1",
				"tooltipTitle", AL["QuickLook"].." 1",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 1",
				"func", function()
					AtlasLootCharDB["QuickLooks"][1] = { AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3] }
					AtlasLoot_RefreshQuickLookButtons()
					Hewdrop:Close(1)
				end
			)
			Hewdrop:AddLine(
				"text", AL["QuickLook"].." 2",
				"tooltipTitle", AL["QuickLook"].." 2",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 2",
				"func", function()
					AtlasLootCharDB["QuickLooks"][2] = { AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3] }
					AtlasLoot_RefreshQuickLookButtons()
					Hewdrop:Close(1)
				end
			)
			Hewdrop:AddLine(
				"text", AL["QuickLook"].." 3",
				"tooltipTitle", AL["QuickLook"].." 3",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 3",
				"func", function()
					AtlasLootCharDB["QuickLooks"][3] = { AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3] }
					AtlasLoot_RefreshQuickLookButtons()
					Hewdrop:Close(1)
				end
			)
			Hewdrop:AddLine(
				"text", AL["QuickLook"].." 4",
				"tooltipTitle", AL["QuickLook"].." 4",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 4",
				"func", function()
					AtlasLootCharDB["QuickLooks"][4] = { AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3] }
					AtlasLoot_RefreshQuickLookButtons()
					Hewdrop:Close(1)
				end
			)
		end
		Hewdrop:Open(button,
			'point', function(parent)
				return "BOTTOMLEFT", "BOTTOMRIGHT"
			end,
			"children", setOptions
		)
	end
end

--[[
AtlasLoot_RefreshQuickLookButtons()
Enables/disables the quicklook buttons depending on what is assigned
]]
function AtlasLoot_RefreshQuickLookButtons()
	for i = 1, 4 do
		if not AtlasLootCharDB["QuickLooks"][i] or not AtlasLootCharDB["QuickLooks"][i][1] then
			_G["AtlasLootPanel_Preset"..i]:Disable()
			_G["AtlasLootDefaultFrame_Preset"..i]:Disable()
		else
			_G["AtlasLootPanel_Preset"..i]:Enable()
			_G["AtlasLootDefaultFrame_Preset"..i]:Enable()
		end
	end
end

--[[
AtlasLoot_ShowBossLoot(dataID, boss):
dataID - Name of the loot table
boss - Text string to be used as the title for the loot page
This is the intended API for external mods to use for displaying loot pages.
This function figures out where the loot table is stored, then sends the relevant info to AtlasLoot_ShowItemsFrame
]]
function AtlasLoot_ShowBossLoot(dataID, boss)
	AtlasLootItemsFrame:Hide()
	-- If the loot table is already being displayed, it is hidden and the current table selection cancelled
	if dataID == AtlasLootItemsFrame.externalBoss and AtlasLootItemsFrame:GetParent() ~= AtlasFrame and AtlasLootItemsFrame:GetParent() ~= AtlasLootDefaultFrame then
		AtlasLootItemsFrame.externalBoss = nil
	else
		AtlasLootItemsFrame.externalBoss = dataID
		AtlasLoot_ShowItemsFrame(dataID, nil, boss)
	end
end

function AtlasLootOptions_SetupSlider(text, mymin, mymax, step)
	_G[this:GetName().."Text"]:SetText(text.." ("..this:GetValue()..")")
	this:SetMinMaxValues(mymin, mymax)
	_G[this:GetName().."Low"]:SetText(mymin)
	_G[this:GetName().."High"]:SetText(mymax)
	this:SetValueStep(step)
end

--[[
AtlasLootMinimapButton_OnClick:
Function to show/hide AtlasLoot when click on minimap button.
]]
function AtlasLootMinimapButton_OnClick(arg1)
	if arg1 == "LeftButton" then
		AtlasLoot_Toggle()
	elseif arg1 == "MiddleButton" then
		AtlasLootOptions_Toggle()
	end
end

--[[
AtlasLootMinimapButton_Init:
Show/hide minimap button.
]]
function AtlasLootMinimapButton_Init()
	if AtlasLootCharDB.MinimapButton then
		AtlasLootMinimapButton:Show()
	else
		AtlasLootMinimapButton:Hide()
	end
end

--[[
AtlasLootMinimapButton_OnEnter:
Show tooltip when mouse is over minimap button.
]]
function AtlasLootMinimapButton_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_LEFT")
	GameTooltip:SetText(AL["AtlasLoot Enhanced"], 1, 1, 1)
	GameTooltip:AddLine(AL["Left-click to open AtlasLoot.\nMiddle-click for AtlasLoot options.\nRight-click and drag to move this button."])
	GameTooltip:Show()
end

--[[
AtlasLootButton_UpdatePosition:
Function to move the minimap button around the minimap.
]]
function AtlasLootMinimapButton_UpdatePosition()
	AtlasLootMinimapButton:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (AtlasLootCharDB.MinimapButtonRadius * cos(AtlasLootCharDB.MinimapButtonPosition)),
		(AtlasLootCharDB.MinimapButtonRadius * sin(AtlasLootCharDB.MinimapButtonPosition)) - 55
	)
	AtlasLootOptions_Init()
end

local function around(num, idp)
	local mult = 10 ^ (idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

function AtlasLootOptions_UpdateSlider(text)
	_G[this:GetName().."Text"]:SetText(text.." ("..around(this:GetValue(), 2)..")")
end

function AtlasLootOptions_ResetPosition()
	AtlasLootCharDB.MinimapButtonPosition = 315
	AtlasLootCharDB.MinimapButtonRadius = 78
	AtlasLootMinimapButton_UpdatePosition()
	DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["Minimap button has been reset!"])
end

function AtlasLootOptions_DefaultSettings()
	AtlasLootCharDB.DefaultTT = true
	AtlasLootCharDB.LootlinkTT = false
	AtlasLootCharDB.ItemSyncTT = false
	AtlasLootCharDB.ShowSource = true
	AtlasLootCharDB.EquipCompare = false
	AtlasLootCharDB.Opaque = false
	AtlasLootCharDB.ItemIDs = false
	AtlasLootCharDB.MinimapButton = true
	AtlasLootCharDB.HidePanel = false
	AtlasLootCharDB.PartialMatching = true
	AtlasLootCharDB.LastBoss = "DUNGEONSMENU1"
	AtlasLootCharDB.LastBossText = AL["Dungeons & Raids"]
	AtlasLootDefaultFrame:ClearAllPoints()
	AtlasLootDefaultFrame:SetPoint("TOP", "UIParent", "TOP", 0, -30)
	AtlasLootOptionsFrame:ClearAllPoints()
	AtlasLootOptionsFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 100)
	AtlasLootCharDB["QuickLooks"] = {}
	AtlasLootCharDB["WishList"] = {}
	AtlasLoot_RefreshQuickLookButtons()
	AtlasLootOptions_Init()
	DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["Default settings applied!"])
end

--[[
AtlasLootButton_BeingDragged:
Function to move the minimap button around the minimap.
]]
function AtlasLootMinimapButton_BeingDragged()
	local xpos, ypos = GetCursorPosition()
	local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom()
	xpos = xmin - xpos / UIParent:GetScale() + 70
	ypos = ypos / UIParent:GetScale() - ymin - 70
	AtlasLootMinimapButton_SetPosition(math.deg(math.atan2(ypos, xpos)))
end

--[[
AtlasLootButton_SetPosition:
Function to save the position of the minimap button.
]]
function AtlasLootMinimapButton_SetPosition(v)
	if v < 0 then v = v + 360 end
	AtlasLootCharDB.MinimapButtonPosition = v
	AtlasLootMinimapButton_UpdatePosition()
end

function AtlasLootItem_OnLoad(self)
	self:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	local name = self:GetName()
	self._Icon = _G[name.."_Icon"]
	self._IconBorder = _G[name.."_IconBorder"]
	self._Quantity = _G[name.."_Quantity"]
	self._Name = _G[name.."_Name"]
	self._Extra = _G[name.."_Extra"]
	self._Highlight = _G[name.."_Highlight"]
	for i = 1, 5 do
		self["_PriceText"..i] = _G[name.."_PriceText"..i]
		self["_PriceIcon"..i] = _G[name.."_PriceIcon"..i]
	end
	self._ContainerBorder = _G[name.."_ContainerBorder"]
	self._ContainerBorderHighlight = _G[name.."_ContainerBorderHighlight"]
end

--------------------------------------------------------------------------------
-- Item OnEnter
-- Called when a loot item is moused over
--------------------------------------------------------------------------------
local stringArgs = {}
function AtlasLootItem_OnEnter(self)
	if not (self.itemID and self.itemID ~= 0) then
		return
	end
	local isItem, isEnchant, isSpell
	local prefix = string.sub(self.itemID, 1, 1)
	if prefix == "s" then
		isSpell = true
	elseif prefix == "e" then
		isEnchant = true
	else
		isItem = true
	end
	if isItem then
		local name, link, quality = GetItemInfo(self.itemID)
		local _, _, _, color = GetItemQualityColor(quality or 1)
		-- Lootlink tooltips
		if AtlasLootCharDB.LootlinkTT then
			-- If we have seen the item, use the game tooltip to minimise same name item problems
			if name then
				AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 24)
				AtlasLootTooltip:SetHyperlink("item:"..self.itemID..":0:0:0")
				if AtlasLootCharDB.ItemIDs then
					AtlasLootTooltip:AddLine(AL["ItemID:"].." "..self.itemID)
				end
				if self.droprate then
					AtlasLootTooltip:AddLine(AL["Drop Rate: "]..self.droprate, 1, 1, 0)
				end
				AtlasLootTooltip:Show()
				if LootLink_AddItem then
					LootLink_AddItem(name, self.itemID..":0:0:0", color)
				end
			else
				AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 24)
				if LootLink_Database and LootLink_Database[self.itemID] then
					LootLink_SetTooltip(AtlasLootTooltip, LootLink_Database[self.itemID][1], 1)
				else
					LootLink_SetTooltip(AtlasLootTooltip, name, 1)
				end
				if AtlasLootCharDB.ItemIDs then
					AtlasLootTooltip:AddLine(AL["ItemID:"].." "..self.itemID)
				end
				if self.droprate then
					AtlasLootTooltip:AddLine(AL["Drop Rate: "]..self.droprate, 1, 1, 0, 1)
				end
				AtlasLootTooltip:Show()
			end
			-- Item Sync tooltips
		elseif AtlasLootCharDB.ItemSyncTT then
			ItemSync:ButtonEnter()
			if AtlasLootCharDB.ItemIDs then
				GameTooltip:AddLine(AL["ItemID:"].." "..self.itemID)
			end
			if self.droprate then
				GameTooltip:AddLine(AL["Drop Rate: "]..self.droprate, 1, 1, 0)
			end
			GameTooltip:Show()
			-- Default game tooltips
		else
			AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 24)
			if GetItemInfo(self.itemID) then
				AtlasLootTooltip:SetHyperlink("item:"..self.itemID..":0:0:0")
			else
				AtlasLootTooltip:SetText(AL["Retrieving item information"], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
			end
			if AtlasLootCharDB.ItemIDs then
				AtlasLootTooltip:AddLine(AL["ItemID:"].." "..self.itemID)
			end
			if self.droprate then
				AtlasLootTooltip:AddLine(AL["Drop Rate: "]..self.droprate, 1, 1, 0)
			end
			AtlasLootTooltip:Show()
		end
	elseif isEnchant then
		local spellID = tonumber(string.sub(self.itemID, 2))
		AtlasLootTooltip:SetOwner(self, "ANCHOR_NONE")
		AtlasLootTooltip:SetPoint("BOTTOMLEFT", self, "TOPRIGHT", -(self:GetWidth() / 2), 24)
		AtlasLootTooltip:SetHyperlink("enchant:"..spellID)
		local _, _, longCooldown = string.find(AtlasLootTooltipTextRight2:GetText() or "", string.gsub(SPELL_RECAST_TIME_MIN, "%%%.3g", "(.+)"))
		if longCooldown and string.find(longCooldown, "e+", 1, true) then
			longCooldown = tonumber(longCooldown) / 60 / 24
			if longCooldown > 1 then
				longCooldown = format(AL.DAYS_COOLDOWN, longCooldown)
			else
				longCooldown = format(AL.DAYS_COOLDOWN_1, longCooldown)
			end
			AtlasLootTooltipTextRight2:SetText(longCooldown)
		end
		if AtlasLootCharDB.ItemIDs then
			AtlasLootTooltip:AddLine(AL["SpellID:"].." "..spellID)
		end
		AtlasLootTooltip:Show()
		local item = tonumber(GetSpellInfoAtlasLootDB["enchants"][spellID]["item"])
		local extra = GetSpellInfoAtlasLootDB["enchants"][spellID]["extra"]
		if item and item ~= 0 then
			AtlasLootTooltip2:SetOwner(self, "ANCHOR_NONE")
			AtlasLootTooltip2:SetPoint("TOPLEFT", AtlasLootTooltip, "BOTTOMLEFT", 0, 0)
			if not AtlasLoot_CacheItem(item) then
				AtlasLootTooltip2:SetText(AL["Retrieving item information"], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
			else
				AtlasLootTooltip2:SetHyperlink("item:"..item)
				if extra then
					AtlasLootTooltip2:AddLine(extra, 1, 1, 1, 1)
				end
			end
			if AtlasLootCharDB.ItemIDs then
				AtlasLootTooltip2:AddLine(AL["ItemID:"].." "..item)
			end
			AtlasLootTooltip2:Show()
		end
	elseif isSpell then
		local spellID = tonumber(string.sub(self.itemID, 2))
		AtlasLootTooltip:SetOwner(self, "ANCHOR_NONE")
		AtlasLootTooltip:SetPoint("BOTTOMLEFT", self, "TOPRIGHT", -(self:GetWidth() / 2), 24)
		if SpellInfo then
			AtlasLootTooltip:SetHyperlink("enchant:"..spellID)
			local _, _, longCooldown = string.find(AtlasLootTooltipTextRight2:GetText() or "", string.gsub(SPELL_RECAST_TIME_MIN, "%%%.3g", "(.+)"))
			if longCooldown and string.find(longCooldown, "e%+") then
				longCooldown = tonumber(longCooldown) / 60 / 24
				if longCooldown > 1 then
					longCooldown = format(AL.DAYS_COOLDOWN, longCooldown)
				else
					longCooldown = format(AL.DAYS_COOLDOWN_1, longCooldown)
				end
				AtlasLootTooltipTextRight2:SetText(longCooldown)
			end
		else
			local name = GetSpellInfoAtlasLootDB["craftspells"][spellID]["name"]
			local castTime = GetSpellInfoAtlasLootDB["craftspells"][spellID]["castTime"]
			local cooldown = GetSpellInfoAtlasLootDB["craftspells"][spellID]["cooldown"]
			local tools = GetSpellInfoAtlasLootDB["craftspells"][spellID]["tools"]
			local reagents = GetSpellInfoAtlasLootDB["craftspells"][spellID]["reagents"]
			local text = GetSpellInfoAtlasLootDB["craftspells"][spellID]["text"]
			AtlasLootTooltip:SetText(name, 1, 1, 1, 1, false)
			if castTime < 60 then
				castTime = format(SPELL_CAST_TIME_SEC, castTime)
			else
				castTime = format(SPELL_CAST_TIME_MIN, castTime / 60)
			end
			if cooldown then
				if cooldown < 86400 then
					if cooldown < 60 then
						cooldown = format(SPELL_RECAST_TIME_SEC, cooldown)
					else
						cooldown = format(SPELL_RECAST_TIME_MIN, cooldown / 60)
					end
				elseif cooldown / 60 / 60 / 24 == 1 then
					cooldown = format(AL.DAYS_COOLDOWN_1, cooldown / 60 / 60 / 24)
				else
					cooldown = format(AL.DAYS_COOLDOWN, cooldown / 60 / 60 / 24)
				end
				AtlasLootTooltip:AddDoubleLine(castTime, cooldown, 1, 1, 1, 1, 1, 1)
			else
				AtlasLootTooltip:AddLine(castTime, 1, 1, 1)
			end
			if type(tools) == "table" then
				for i = table.getn(stringArgs), 1, -1 do table.remove(stringArgs, i) end
				for j = 1, table.getn(tools) do
					if not AtlasLoot_CacheItem(tools[j]) then
						AtlasLootItemsFrame.refreshTime = refreshTimeout
						AtlasLootItemsFrame.queue[tools[j]] = true
					end
					table.insert(stringArgs, (GetItemInfo(tools[j]) or ""))
					table.insert(stringArgs, AtlasLoot_CheckBagsForItems(tools[j]))
				end
				AtlasLootTooltip:AddLine(SPELL_TOTEMS..BuildColoredListString(unpack(stringArgs)), 1, 1, 1, false)
			end
			if type(reagents) == "table" then
				for i = table.getn(stringArgs), 1, -1 do table.remove(stringArgs, i) end
				for j = 1, table.getn(reagents) do
					if reagents[j][2] and reagents[j][2] > 1 then
						if not AtlasLoot_CacheItem(reagents[j][1]) then
							AtlasLootItemsFrame.refreshTime = refreshTimeout
							AtlasLootItemsFrame.queue[reagents[j][1]] = true
						end
						table.insert(stringArgs, ((GetItemInfo(reagents[j][1])) or "").." ("..reagents[j][2]..")")
					else
						table.insert(stringArgs, ((GetItemInfo(reagents[j][1])) or ""))
					end
					table.insert(stringArgs, AtlasLoot_CheckBagsForItems(reagents[j][1], reagents[j][2]))
				end
				AtlasLootTooltip:AddLine(SPELL_REAGENTS..BuildColoredListString(unpack(stringArgs)), 1, 1, 1, true)
			end
			if text then
				AtlasLootTooltip:AddLine(text, 1, 0.82, 0, true)
			end
		end
		if AtlasLootCharDB.ItemIDs then
			AtlasLootTooltip:AddLine(AL["SpellID:"].." "..spellID)
		end
		AtlasLootTooltip:Show()
		local craftItem = tonumber(GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftItem"])
		local extra = GetSpellInfoAtlasLootDB["craftspells"][spellID]["extra"]
		if craftItem and craftItem ~= 0 then
			AtlasLootTooltip2:SetOwner(self, "ANCHOR_NONE")
			AtlasLootTooltip2:SetPoint("TOPLEFT", AtlasLootTooltip, "BOTTOMLEFT", 0, 0)
			AtlasLootTooltip2:ClearLines()
			if not AtlasLoot_CacheItem(craftItem) then
				AtlasLootTooltip2:SetText(AL["Retrieving item information"], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
			else
				AtlasLootTooltip2:SetHyperlink("item:"..craftItem)
				if extra then
					AtlasLootTooltip2:AddLine(extra, 1, 1, 1, 1)
				end
			end
			if AtlasLootCharDB.ItemIDs then
				AtlasLootTooltip2:AddLine(AL["ItemID:"].." "..craftItem)
			end
			AtlasLootTooltip2:Show()
		end
	end
	-- Reposition tooltips if they overlap
	if AtlasLootTooltip:IsOwned(self) and AtlasLootTooltip2:IsOwned(self) then
		local bottom = AtlasLootTooltip:GetBottom()
		local top = AtlasLootTooltip2:GetTop()
		if top and bottom and bottom < top then
			AtlasLootTooltip2:ClearAllPoints()
			AtlasLootTooltip2:SetPoint("TOPLEFT", self, "TOPRIGHT", -(self:GetWidth() / 2), 24)
			AtlasLootTooltip:ClearAllPoints()
			AtlasLootTooltip:SetPoint("BOTTOMLEFT", AtlasLootTooltip2, "TOPLEFT", 0, 0)
		end
	end
end

--------------------------------------------------------------------------------
-- Item OnLeave
-- Called when the mouse cursor leaves a loot item
--------------------------------------------------------------------------------
function AtlasLootItem_OnLeave(self)
	AtlasLootTooltip:Hide()
	AtlasLootTooltip2:Hide()
	GameTooltip:Hide()
	ShoppingTooltip1:Hide()
	ShoppingTooltip2:Hide()
end

--------------------------------------------------------------------------------
-- Item OnClick
-- Called when a loot item is clicked on
--------------------------------------------------------------------------------
function AtlasLootItem_OnClick(self, button)
	CloseDropDownMenus()
	if self.container then
		AtlasLoot_ShowContainerFrame(self)
		return
	elseif self.lootpage then
		AtlasLoot_ShowItemsFrame(self.lootpage)
		return
	end
	if not (self.itemID and self.itemID ~= 0) then
		return
	end
	local name = self._Name:GetText()
	local _, _, color = string.find(name, "(|c%x%x%x%x%x%x%x%x)")
	color = color or NORMAL_FONT_COLOR_CODE
	name = string.gsub(name, "|c%x%x%x%x%x%x%x%x", "")
	name = string.gsub(name, "|r", "")
	local _, _, texture = string.find(self._Icon:GetTexture() or "", ".+\\(.+)$")
	texture = texture or "INV_Misc_QuestionMark"
	local dataID = AtlasLootItemsFrame.refresh[1]
	local dataSource = AtlasLootItemsFrame.refresh[2]
	local prefix = string.sub(self.itemID, 1, 1)
	local isItem, isEnchant, isSpell
	if prefix == "s" then
		isSpell = true
	elseif prefix == "e" then
		isEnchant = true
	else
		isItem = true
	end
	if isItem then
		local itemName, itemLink = GetItemInfo(self.itemID)
		-- If shift-clicked, link in the chat window
		if itemName and IsShiftKeyDown() and self.itemID ~= 0 then
			if WIM_EditBoxInFocus then
				WIM_EditBoxInFocus:Insert(color.."|Hitem:"..self.itemID..":0:0:0|h["..itemName.."]|h|r")
			elseif ChatFrameEditBox:IsVisible() then
				ChatFrameEditBox:Insert(color.."|Hitem:"..self.itemID..":0:0:0|h["..itemName.."]|h|r")
			else
				AtlasLoot_SayItemReagents(self.itemID, color, itemName)
			end
			-- If control-clicked, use the dressing room
		elseif IsControlKeyDown() and itemLink then
			DressUpItemLink(itemLink)
		elseif IsAltKeyDown() and self.itemID ~= 0 then
			if dataSource == "WishList" then
				AtlasLoot_DeleteFromWishList(self.itemID)
			elseif dataSource == "SearchResult" then
				AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(self.itemID))
			else
				AtlasLoot_AddToWishlist(self.itemID, texture, self.itemIDName, self.itemIDExtra, dataID.."|"..dataSource)
			end
		elseif (dataSource == "SearchResult" or dataSource == "WishList") and self.sourcePage then
			local _, _, dataID, dataSource = string.find(self.sourcePage, "(.+)|(.+)")
			if dataID and dataSource then
				AtlasLoot_ShowItemsFrame(dataID, dataSource)
			end
		elseif self.container then
			AtlasLoot_ShowContainerFrame(self)
		end
	elseif isEnchant then
		if IsShiftKeyDown() then
			AtlasLoot_SayItemReagents(self.itemID, color, name)
		elseif IsAltKeyDown() and self.itemID ~= 0 then
			if dataSource == "WishList" then
				AtlasLoot_DeleteFromWishList(self.itemID)
			elseif dataSource == "SearchResult" then
				AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(self.itemID))
			else
				AtlasLoot_AddToWishlist(self.itemID, texture, self.itemIDName, self.itemIDExtra, dataID.."|"..dataSource)
			end
		elseif IsControlKeyDown() and self.dressingroomID then
			DressUpItemLink("item:"..self.dressingroomID..":0:0:0")
		elseif (dataSource == "SearchResult" or dataSource == "WishList") and self.sourcePage then
			local _, _, dataID, dataSource = string.find(self.sourcePage, "(.+)|(.+)")
			if dataID and dataSource then
				AtlasLoot_ShowItemsFrame(dataID, dataSource)
			end
		end
	elseif isSpell then
		if IsShiftKeyDown() then
			local spellID = tonumber(string.sub(self.itemID, 2))
			local craftitem = tonumber(GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftItem"])
			local craftname = GetItemInfo(craftitem or 0)
			if WIM_EditBoxInFocus then
				if craftitem and craftitem ~= 0 and craftname then
					WIM_EditBoxInFocus:Insert(color.."|Hitem:"..craftitem..":0:0:0|h["..craftname.."]|h|r")
				else
					WIM_EditBoxInFocus:Insert(color.."|Henchant:"..spellID.."|h["..name.."]|h|r")
				end
			elseif ChatFrameEditBox:IsVisible() then
				if craftitem and craftitem ~= 0 and craftname then
					ChatFrameEditBox:Insert(color.."|Hitem:"..craftitem..":0:0:0|h["..craftname.."]|h|r")
				else
					ChatFrameEditBox:Insert(color.."|Henchant:"..spellID.."|h["..name.."]|h|r")
				end
			else
				AtlasLoot_SayItemReagents(self.itemID, color, name)
			end
		elseif IsAltKeyDown() and self.itemID ~= 0 then
			if dataSource == "WishList" then
				AtlasLoot_DeleteFromWishList(self.itemID)
			elseif dataSource == "SearchResult" then
				AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(self.itemID))
			else
				AtlasLoot_AddToWishlist(self.itemID, texture, self.itemIDName, self.itemIDExtra, dataID.."|"..dataSource)
			end
		elseif IsControlKeyDown() and self.dressingroomID then
			DressUpItemLink("item:"..self.dressingroomID..":0:0:0")
		elseif (dataSource == "SearchResult" or dataSource == "WishList") and self.sourcePage then
			local _, _, dataID, dataSource = string.find(self.sourcePage, "(.+)|(.+)")
			if dataID and dataSource then
				AtlasLoot_ShowItemsFrame(dataID, dataSource)
			end
		end
	end
end

function AtlasLoot_CacheItem(linkOrID)
	if not linkOrID or linkOrID == 0 or linkOrID == "0" then return false end
	if tonumber(linkOrID) then
		if GetItemInfo(linkOrID) then return true end
		AtlasLootCacheTooltip:SetHyperlink("item:"..linkOrID)
		return false
	else
		if type(linkOrID) ~= "string" then return false end
		local _, _, item = string.find(linkOrID, "(item:%d+:%d+:%d+:%d+)")
		if not item then return false end
		if GetItemInfo(item) then return true end
		AtlasLootCacheTooltip:SetHyperlink(item)
		return false
	end
end

local ContainerItemFrames = {}
local lastSelectedButton
function AtlasLoot_ShowContainerFrame(self)
	local data = self.container
	if not data then return end

	if self ~= lastSelectedButton then
		AtlasLootItemsFrameContainer:Show()
		lastSelectedButton = self
	elseif AtlasLootItemsFrameContainer:IsVisible() then
		AtlasLootItemsFrameContainer:Hide()
		lastSelectedButton = nil
		return
	end

	if not AtlasLootItemsFrameContainer:IsVisible() and lastSelectedButton == self then
		AtlasLootItemsFrameContainer:Show()
	end

	for i = 1, table.getn(ContainerItemFrames) do
		ContainerItemFrames[i]:Hide()
	end

	local row = 0
	local col = 0
	local buttonIndex = 1
	local maxCols = 1

	for i = 1, table.getn(data) do
		col = 0
		for j = 1, table.getn(data[i]) do
			local itemButton = ContainerItemFrames[buttonIndex]
			if not itemButton then
				itemButton = CreateFrame("Button", "AtlasLootContainerItem"..buttonIndex, AtlasLootItemsFrameContainer, "AtlasLootContainerItemTemplate")
				ContainerItemFrames[buttonIndex] = itemButton
			end
			local itemID = data[i][j][1]
			AtlasLoot_CacheItem(itemID)
			itemButton.itemID = itemID
			itemButton.itemIDExtra = data[i][j][2]
			itemButton.dressingroomID = itemID
			local _, _, quality, _, _, _, _, _, tex = GetItemInfo(itemID)
			local r, g, b = 1, 1, 1
			if quality then
				r, g, b = GetItemQualityColor(quality)
			end
			if not tex then
				tex = "Interface\\Icons\\INV_Misc_QuestionMark"
			end
			itemButton:SetPoint("TOPLEFT", AtlasLootItemsFrameContainer, (col * 35) + 5, -(row * 35) - 5)
			itemButton:SetBackdropBorderColor(r, g, b)
			itemButton:Show()
			_G["AtlasLootContainerItem"..buttonIndex.."Icon"]:SetTexture(tex)
			col = col + 1
			if col > maxCols then
				maxCols = col
			end
			buttonIndex = buttonIndex + 1
		end
		row = row + 1
	end
	AtlasLootItemsFrameContainer:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -2, 2)
	AtlasLootItemsFrameContainer:SetWidth(16 + (maxCols * 35))
	AtlasLootItemsFrameContainer:SetHeight(16 + (row * 35))
end

function AtlasLoot_ContainerItem_OnEnter(self)
	local itemID = self.itemID
	if not itemID then return end

	AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 4), -(self:GetHeight() / 4))
	AtlasLootTooltip:SetHyperlink("item:"..itemID)
	AtlasLootTooltip.itemID = itemID
	if AtlasLootCharDB.ItemIDs then
		AtlasLootTooltip:AddLine(AL["ItemID:"].." "..itemID)
	end
	AtlasLootTooltip:Show()
end

function AtlasLoot_ContainerItem_OnLeave(self)
	AtlasLootTooltip:Hide()
	AtlasLootTooltip.itemID = nil
end

function AtlasLoot_ContainerItem_OnClick(self, button)
	local itemID = self.itemID
	local name, link, quality, _, _, _, _, _, tex = GetItemInfo(itemID or 0)
	if not name then return end

	local _, _, _, color = GetItemQualityColor(quality)
	tex = string.gsub(tex, "Interface\\Icons\\", "")
	local lootpage, dataSource
	if lastSelectedButton then
		lootpage = lastSelectedButton.lootpage
		dataSource = lastSelectedButton.dataSource
	end
	if IsShiftKeyDown() and button == "LeftButton" then
		if WIM_EditBoxInFocus then
			WIM_EditBoxInFocus:Insert(color.."|Hitem:"..itemID..":0:0:0|h["..name.."]|h|r")
		elseif ChatFrameEditBox:IsVisible() then
			ChatFrameEditBox:Insert(color.."|Hitem:"..itemID..":0:0:0|h["..name.."]|h|r")
		end
	elseif IsControlKeyDown() and link then
		DressUpItemLink(link)
	elseif IsAltKeyDown() and itemID ~= 0 then
		if lootpage and dataSource then
			AtlasLoot_AddToWishlist(itemID, tex, name, self.itemIDExtra, lootpage.."|"..dataSource)
		elseif AtlasLootItemsFrame.refresh[1] then
			local dataID = AtlasLootItemsFrame.refresh[1]
			local dataSource = AtlasLootItemsFrame.refresh[2]
			if dataSource == "WishList" then
				AtlasLoot_DeleteFromWishList(itemID)
			elseif dataSource == "SearchResult" then
				AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(itemID))
			else
				AtlasLoot_AddToWishlist(itemID, tex, name, self.itemIDExtra, dataID.."|"..dataSource)
			end
		end
	end
end

local function idFromLink(itemlink)
	if itemlink then
		local _, _, id = string.find(itemlink, "|Hitem:([^:]+)%:")
		return tonumber(id)
	end
	return nil
end

function AtlasLoot_CheckBagsForItems(id, qty)
	if not id then
		DEFAULT_CHAT_FRAME:AddMessage("AtlasLoot_CheckBagsForItems: no ID specified!")
		return
	end
	if not qty then qty = 1 end
	local itemsfound = 0
	local itemName = GetItemInfo(id)
	if not itemName then return nil end
	for i = 0, NUM_BAG_FRAMES do
		for j = 1, GetContainerNumSlots(i) do
			local itemLink = GetContainerItemLink(i, j)
			if itemLink and idFromLink(itemLink) == tonumber(id) then
				local _, stackCount = GetContainerItemInfo(i, j)
				itemsfound = itemsfound + stackCount
			end
		end
	end
	if itemsfound < qty then
		return nil
	else
		return 1
	end
end

function AtlasLoot_SayItemReagents(id, color, name, safe)
	if not id then return end
	local chatline = ""
	local itemCount = 0
	name = string.gsub(name, "|c%x%x%x%x%x%x%x%x", "")
	name = string.gsub(name, "|r", "")
	color = color or NORMAL_FONT_COLOR_CODE
	local tListActivity = {}
	local tCount = 0

	if WIM_IconItems and WIM_Icon_SortByActivity then
		for key in pairs(WIM_IconItems) do
			table.insert(tListActivity, key)
			tCount = tCount + 1
		end

		table.sort(tListActivity, WIM_Icon_SortByActivity)
	end
	local channel, chatnumber
	if tListActivity[1] and WIM_Windows and WIM_Windows[tListActivity[1]].is_visible then
		channel = "WHISPER"
		chatnumber = tListActivity[1]
	else
		channel = ChatFrameEditBox.chatType
		if channel == "WHISPER" then
			chatnumber = ChatFrameEditBox.tellTarget
		elseif channel == "CHANNEL" then
			chatnumber = ChatFrameEditBox.channelTarget
		end
	end
	if string.sub(id, 1, 1) == "s" then
		local spellID = tonumber(string.sub(id, 2))
		local craftItem = tonumber(GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftItem"])
		if craftItem and craftItem ~= 0 then
			local craftnumber = ""
			local qtyMin = GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftQuantityMin"]
			local qtyMax = GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftQuantityMax"]
			if qtyMin then
				if qtyMax then
					craftnumber = craftnumber..qtyMin.."-"..qtyMax.."x"
				else
					craftnumber = craftnumber..qtyMin.."x"
				end
			end
			SendChatMessage(AL["To craft "]..craftnumber..AtlasLoot_GetChatLink(craftItem)..AL[" the following reagents are needed:"], channel, nil, chatnumber)
			local reagents = GetSpellInfoAtlasLootDB["craftspells"][spellID]["reagents"]
			if type(reagents) == "table" then
				for j = 1, table.getn(reagents) do
					local tempnumber = reagents[j][2]
					if not tempnumber or tempnumber == nil or tempnumber == "" then
						tempnumber = 1
					end
					chatline = chatline..tempnumber.."x"..AtlasLoot_GetChatLink(reagents[j][1]).." "
					itemCount = itemCount + 1
					if itemCount == 4 then
						SendChatMessage(chatline, channel, nil, chatnumber)
						chatline = ""
						itemCount = 0
					end
				end
			end
			if itemCount > 0 then
				SendChatMessage(chatline, channel, nil, chatnumber)
			end
		else
			local reagents = GetSpellInfoAtlasLootDB["craftspells"][spellID]["reagents"]
			SendChatMessage(AL["To cast "]..NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r"..AL[" the following items are needed:"], channel, nil, chatnumber)
			if type(reagents) == "table" then
				for j = 1, table.getn(reagents) do
					local tempnumber = reagents[j][2]
					if not tempnumber or tempnumber == nil or tempnumber == "" then
						tempnumber = 1
					end
					chatline = chatline..tempnumber.."x"..AtlasLoot_GetChatLink(reagents[j][1]).." "
					itemCount = itemCount + 1
					if itemCount == 4 then
						SendChatMessage(chatline, channel, nil, chatnumber)
						chatline = ""
						itemCount = 0
					end
				end
			end
			if itemCount > 0 then
				SendChatMessage(chatline, channel, nil, chatnumber)
			end
		end
	elseif string.sub(id, 1, 1) == "e" then
		local spellID = tonumber(string.sub(id, 2))
		local item = tonumber(GetSpellInfoAtlasLootDB["enchants"][spellID]["item"])
		if tListActivity[1] and WIM_Windows[tListActivity[1]].is_visible then
			if not item then
				SendChatMessage(NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber)
			else
				SendChatMessage(AL["To craft "]..AtlasLoot_GetChatLink(item)..AL[" you need this: "]..NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber)
			end
		elseif ChatFrameEditBox:IsVisible() then
			if not item then
				ChatFrameEditBox:Insert(NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber)
			else
				ChatFrameEditBox:Insert(AL["To craft "]..AtlasLoot_GetChatLink(item)..AL[" you need this: "]..NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber)
			end
		else
			if not item then
				SendChatMessage(color.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber)
			else
				SendChatMessage(AL["To craft "]..AtlasLoot_GetChatLink(item)..AL[" you need this: "]..NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber)
			end
		end
	else
		if safe then
			SendChatMessage("["..name.."]", channel, nil, chatnumber)
		else
			SendChatMessage(color.."|Hitem:"..id..":0:0:0|h["..name.."]|h|r", channel, nil, chatnumber)
		end
	end
end

function AtlasLoot_GetChatLink(id)
	local itemName, itemLink, quality = GetItemInfo(tonumber(id))
	local _, _, _, color = GetItemQualityColor(quality)
	return color.."|H"..itemLink.."|h["..itemName.."]|h|r"
end

function AtlasLoot_QuickLook_OnClick(self)
	local id = self:GetID()
	ShowUIPanel(_G[AtlasLoot_AnchorPoint[2]])
	if IsAltKeyDown() then
		AtlasLootCharDB["QuickLooks"][id] = nil
		AtlasLoot_RefreshQuickLookButtons()
		DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..":|r "..AL["QuickLook"].." "..id.." "..AL["has been reset!"])
	else
		AtlasLoot_ShowItemsFrame(AtlasLootCharDB["QuickLooks"][id][1], AtlasLootCharDB["QuickLooks"][id][2], AtlasLootCharDB["QuickLooks"][id][3])
	end
end

function AtlasLoot_QuickLook_OnShow(self)
	local id = self:GetID()
	self:SetText(AL["QuickLook"].." "..id)
	self:SetFrameLevel(self:GetParent():GetFrameLevel() + 1)
	if not AtlasLootCharDB["QuickLooks"][id] or not AtlasLootCharDB["QuickLooks"][id][1] then
		self:Disable()
	end
end

function AtlasLoot_QuickLook_OnEnter(self)
	local id = self:GetID()
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 5)
	GameTooltip:AddLine(AtlasLootCharDB["QuickLooks"][id][3], 1, 1, 1)
	GameTooltip:AddLine(AL["ALT+Click to clear"])
	GameTooltip:Show()
end
