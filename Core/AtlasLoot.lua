--[[
Atlasloot Enhanced
Author Daviesh
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)
]]

local _G = _G or getfenv(0)
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
	-- Remove the selection of a loot table in Atlas
	AtlasLootItemsFrame.activeBoss = nil
	-- Set the item table to the loot table
	-- AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorPoint)
	-- Show the last displayed loot table
	if AtlasLootCharDB.LastBoss == "WishList" then
		AtlasLoot_ShowWishList()
		return
	elseif AtlasLootCharDB.LastBoss == "SearchResult" then
		AtlasLoot:ShowSearchResult()
		return
	end
	if AtlasLootItemsFrame.refresh then
		AtlasLoot_ShowBossLoot(AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[3])
	else
		AtlasLoot_ShowBossLoot(AtlasLootCharDB.LastBoss, AtlasLootCharDB.LastBossText)
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
		AtlasLoot_OnVariablesLoaded()
	end
end

--[[
AtlasLoot_OnVariablesLoaded:
Invoked by the VARIABLES_LOADED event.  Now that we are sure all the assets
the addon needs are in place, we can properly set up the mod
]]
function AtlasLoot_OnVariablesLoaded()
	if not AtlasLootCharDB then AtlasLootCharDB = {} end
	if not AtlasLootCharDB["WishList"] then AtlasLootCharDB["WishList"] = {} end
	if not AtlasLootCharDB["QuickLooks"] then AtlasLootCharDB["QuickLooks"] = {} end
	if not AtlasLootCharDB["SearchResult"] then AtlasLootCharDB["SearchResult"] = {} end
	-- Add the loot browser to the special frames tables to enable closing wih the ESC key
	tinsert(UISpecialFrames, "AtlasLootDefaultFrame")
	tinsert(UISpecialFrames, "AtlasLootOptionsFrame")
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
		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 1)
	else
		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0.65)
	end
	-- If Atlas is installed, set up for Atlas
	if Original_Atlas_Refresh then
		AtlasLoot_SetupForAtlas()
		-- If a first time user, set up options
		if AtlasLootCharDB.FirstTime == nil or AtlasLootCharDB.FirstTime == true then
			StaticPopup_Show("ATLASLOOT_SETUP")
			AtlasLootCharDB.FirstTime = false
		end
		Original_Atlas_Refresh()
	else
		-- If we are not using Atlas, keep the items frame out of the way
		AtlasLootItemsFrame:Hide()
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
	AtlasLootMinimapButtonFrame:SetPoint(
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
	AtlasLootItemsFrame.queue = {}
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
AtlasLootDefaultFrame_OnHide:
When we close the loot browser, re-bind the item table to Atlas
and close all Hewdrop menus
]]
function AtlasLootDefaultFrame_OnHide()
	if AtlasFrame then
		AtlasLoot_SetupForAtlas()
	end
	AtlasLoot_Hewdrop:Close(1)
	AtlasLoot_HewdropSubMenu:Close(1)
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
			local _, _, boss = string.find(_G[name.."_Text"]:GetText(), "|c%x%x%x%x%x%x%x%x%s*[%dX']*[%) ]*(.*[^%,])[%,]?$")
			AtlasLoot_ShowBossLoot(AtlasLootBossButtons[zoneID][id], boss)
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
	local dataID = AtlasLootItemsFrame.refresh[1]

	if dataID == 'WishList' then
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
		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 1)
	else
		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0.65)
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

function AtlasLootItemsFrame_OnUpdate()
	if not this.refreshTime then
		return
	end
	this.refreshTime = (this.refreshTime or refreshTimeout) - arg1
	local done = true
	for item in pairs(this.queue) do
		if not GetItemInfo(item) then
			done = false
			break
		end
	end
	if done or this.refreshTime <= 0 then
		this.refreshTime = nil
		for k in pairs(this.queue) do
			this.queue[k] = nil
		end
		if this.refresh and this.refresh[1] and this.refresh[2] and this.refresh[3] then
			AtlasLoot_ShowItemsFrame(this.refresh[1], this.refresh[2], this.refresh[3])
		end
	end
end

--[[
AtlasLoot_ShowItemsFrame(dataID, dataSource, title):
dataID - Name of the loot table
dataSource - Table in the database where the loot table is stored
title - Text string to use as a title for the loot page
This fuction is not normally called directly, it is usually invoked by AtlasLoot_ShowBossLoot.
It is the workhorse of the mod and allows the loot tables to be displayed any way anywhere in any mod.
]]
function AtlasLoot_ShowItemsFrame(dataID, dataSource, title)
	AtlasLootItemsFrame.refreshTime = nil
	if AtlasLootItemsFrameContainer:IsShown() and AtlasLootItemsFrame.refresh and dataID ~= AtlasLootItemsFrame.refresh[1] then
		AtlasLootItemsFrameContainer:Hide()
	end
	if not dataID then return end
	if not dataSource then
		dataSource = AtlasLoot_TableNames[dataID] and AtlasLoot_TableNames[dataID][2] or "AtlasLootFallback"
	end
	if not title then
		if AtlasLoot_TableNames[dataID] and AtlasLoot_TableNames[dataID][1] then
			title = AtlasLoot_TableNames[dataID][1]
		else
			title = ""
		end
	end
	-- Set up local variables needed for GetItemInfo, etc
	local iconFrame, nameFrame, extraFrame, itemButton
	local text, extra
	local wlPage, wlPageMax = 1, 1
	local isItem, isEnchant, isSpell
	local spellName, spellIcon
	local dataSourceStr = dataSource
	if dataID == "SearchResult" or dataID == "WishList" then
		dataSource = {}
		-- Match the page number to display
		wlPage = tonumber(string.sub(dataSourceStr, string.find(dataSourceStr, "%d"), string.len(dataSourceStr)))
		-- Aquiring items of the page
		if dataID == "SearchResult" then
			dataSource[dataID], wlPageMax = AtlasLoot:GetSearchResultPage(wlPage)
			title = string.format((AL["Search Result: %s"]), AtlasLootCharDB.LastSearchedText or "")
		elseif dataID == "WishList" then
			dataSource[dataID], wlPageMax = AtlasLoot_GetWishListPage(wlPage)
			title = AL["WishList"]
		end
		-- Make page number reasonable
		if wlPage < 1 then wlPage = 1 end
		if wlPage > wlPageMax then wlPage = wlPageMax end
	else
		dataSource = AtlasLoot_Data[dataSourceStr]
	end
	AtlasLootCharDB.LastBossText = title
	AtlasLootCharDB.LastBoss = dataID
	-- Get AtlasQuest out of the way
	if AtlasQuestInsideFrame then
		AtlasQuestInsideFrame:Hide()
	end
	-- Store data about the state of the items frame to allow minor tweaks or a recall of the current loot page
	AtlasLootItemsFrame.refresh = { dataID, dataSourceStr, title, AtlasLoot_AnchorPoint }

	if dataSourceStr == "MENUS" then
		local data = AtlasLoot_Data.MENUS[dataID]
		for i = 1, 30 do
			_G["AtlasLootItem_"..i]:Hide()
			local menuItem = _G["AtlasLootMenuItem_"..i]
			menuItem:Hide()
			menuItem.isheader = false
			menuItem.container = nil
			menuItem.dataSource = nil
			_G["AtlasLootMenuItem_"..i.."_Icon"]:SetTexCoord(0, 1, 0, 1)
			_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 1, 1)
		end
		for i = 1, getn(data) do
			local buttonIndex = data[i][1]
			local lootPage = data[i][2]
			local container = data[i][6]
			local icon = data[i][3]
			_G["AtlasLootMenuItem_"..buttonIndex.."_Name"]:SetText(data[i][4])
			_G["AtlasLootMenuItem_"..buttonIndex.."_Extra"]:SetText(data[i][5])
			if type(container) == "table" then
				_G["AtlasLootMenuItem_"..buttonIndex].container = container
				_G["AtlasLootMenuItem_"..buttonIndex.."_IconBorder"]:SetVertexColor(1, 0.82, 0)
				for row = 1, getn(container) do
					for item = 1, getn(container[row]) do
						AtlasLoot_CacheItem(container[row][item][1])
					end
				end
			else
				_G["AtlasLootMenuItem_"..buttonIndex].lootpage = lootPage
				_G["AtlasLootMenuItem_"..buttonIndex.."_IconBorder"]:SetVertexColor(1, 1, 1)
			end
			_G["AtlasLootMenuItem_"..buttonIndex].isheader = not lootPage and not container
			if strsub(icon, 1, 5) == "CLASS" then
				_G["AtlasLootMenuItem_"..buttonIndex.."_Icon"]:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\"..strsub(icon, 6))
			else
				_G["AtlasLootMenuItem_"..buttonIndex.."_Icon"]:SetTexture("Interface\\Icons\\"..icon)
			end
			_G["AtlasLootMenuItem_"..buttonIndex]:Show()
		end
	else
		-- Iterate through each item object and set its properties
		for i = 1, 30, 1 do
			-- Hide the menu objects.  These are not required for a loot table
			_G["AtlasLootMenuItem_"..i]:Hide()
			-- Check for a valid object (that it exists, and that it has a name)
			if dataSource[dataID][i] and dataSource[dataID][i][3] ~= "" then
				-- Use shortcuts for easier reference to parts of the item button
				itemButton       = _G["AtlasLootItem_"..i]
				iconFrame        = _G["AtlasLootItem_"..i.."_Icon"]
				nameFrame        = _G["AtlasLootItem_"..i.."_Name"]
				extraFrame       = _G["AtlasLootItem_"..i.."_Extra"]
				local quantity   = _G["AtlasLootItem_"..i.."_Quantity"]
				local iconBorder = _G["AtlasLootItem_"..i.."_IconBorder"]
				local containerBorder = _G["AtlasLootItem_"..i.."_ContainerBorder"]
				local containerHighlight = _G["AtlasLootItem_"..i.."_ContainerBorderHighlight"]
				iconBorder:SetVertexColor(1, 1, 1)
				if string.sub(dataSource[dataID][i][1], 1, 1) == "s" then
					isItem = false
					isEnchant = false
					isSpell = true
				elseif string.sub(dataSource[dataID][i][1], 1, 1) == "e" then
					isItem = false
					isEnchant = true
					isSpell = false
				else
					isItem = true
					isEnchant = false
					isSpell = false
				end
				if isItem then
					local itemID = tonumber(dataSource[dataID][i][1])
					local itemName, _, itemQuality = GetItemInfo(itemID)
					-- If the client has the name of the item in cache, use that instead.
					-- This is poor man's localisation, English is replaced be whatever is needed
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
						text = AtlasLoot_FixText(dataSource[dataID][i][3])
					end
					quantity:SetText(dataSource[dataID][i][8])
					itemButton.dressingroomID = dataSource[dataID][i][1]
				elseif isEnchant then
					local spellID = tonumber(string.sub(dataSource[dataID][i][1], 2))
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
					spellIcon = dataSource[dataID][i][2]
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
						itemButton.dressingroomID = craftItem
					else
						text = spellName
						itemButton.dressingroomID = nil
					end
					quantity:SetText("")
				elseif isSpell then
					local spellID = tonumber(string.sub(dataSource[dataID][i][1], 2))
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
					spellIcon = dataSource[dataID][i][2]
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
						itemButton.dressingroomID = craftItem
					else
						text = spellName
						itemButton.dressingroomID = nil
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
				-- Insert the item description
				extra = AtlasLoot_FixText(dataSource[dataID][i][4])
				local iconData = dataSource[dataID][i][2] or ""
				-- If there is no data on the texture an item should have, show a big red question mark
				if strsub(iconData, 1, 5) == "CLASS" then
					iconFrame:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\"..strsub(iconData, 6))
				elseif isItem and type(dataSource[dataID][i][1]) == "number" then
					local _, _, _, _, _, _, _, _, texture = GetItemInfo(dataSource[dataID][i][1])
					if not texture and type(iconData) == "string" then
						texture = "Interface\\Icons\\"..iconData
					end
					iconFrame:SetTexture(texture)
				elseif not isItem and spellIcon then
					if type(iconData) == "number" then
						local _, _, _, _, _, _, _, _, texture = GetItemInfo(iconData)
						iconFrame:SetTexture(texture)
					elseif type(iconData) == "string" then
						iconFrame:SetTexture("Interface\\Icons\\"..iconData)
					else
						iconFrame:SetTexture(spellIcon)
					end
				else
					iconFrame:SetTexture("Interface\\Icons\\"..iconData)
				end
				if iconFrame:GetTexture() == nil then
					iconFrame:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
				end
				-- Set the name and description of the item
				nameFrame:SetText(text)
				extraFrame:SetText(extra)
				extraFrame:Show()
				-- Set prices for items, up to 5 different currencies can be used in combination
				for j = 1, 5 do
					_G["AtlasLootItem_"..i.."_PriceText"..j]:Hide()
					_G["AtlasLootItem_"..i.."_PriceIcon"..j]:Hide()
				end
				local index = 1
				local prices = dataSource[dataID][i][6]
				if type(prices) == "table" then
					for j = 1, getn(prices), 2 do
						local pricetext = _G["AtlasLootItem_"..i.."_PriceText"..index]
						local priceicon = _G["AtlasLootItem_"..i.."_PriceIcon"..index]
						if prices[j] and prices[j + 1] and prices[j] ~= "" and prices[j + 1] ~= "" then
							pricetext:SetText(prices[j])
							priceicon:SetTexture(AtlasLoot_FixText(prices[j + 1]))
							pricetext:Show()
							priceicon:Show()
						end
						index = index + 1
					end
				end
				if (dataID == "SearchResult" or dataID == "WishList") and dataSource[dataID][i][5] then
					local _, _, wishDataID, wishDataSource = strfind(dataSource[dataID][i][5], "(.+)|(.+)")
					if wishDataSource == "AtlasLootRepItems" then
						if wishDataID then
							for _, v in ipairs(AtlasLoot_Data[wishDataSource][wishDataID]) do
								if dataSource[dataID][i][1] == v[1] then
									index = 1
									for j = 6, 14, 2 do
										local pricetext = _G["AtlasLootItem_"..i.."_PriceText"..index]
										local priceicon = _G["AtlasLootItem_"..i.."_PriceIcon"..index]
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
								if dataSource[dataID][i][1] == v[1] then
									local boss = AtlasLoot_GetWishListSubheadingBoss(wishDataID)
									if boss then
										extraFrame:SetText(extra.." - "..boss)
									end
								end
							end
						end
					end
				end
				-- For convenience, we store information about the objects in the objects so that it can be easily accessed later
				itemButton.itemID = dataSource[dataID][i][1]
				itemButton.itemIDName = dataSource[dataID][i][3]
				itemButton.itemIDExtra = dataSource[dataID][i][4]
				itemButton.container = dataSource[dataID][i][7]
				if type(itemButton.container) == "table" then
					containerBorder:Show()
					containerHighlight:Show()
					for row = 1, getn(itemButton.container) do
						for item = 1, getn(itemButton.container[row]) do
							AtlasLoot_CacheItem(itemButton.container[row][item][1])
						end
					end
				else
					containerHighlight:Hide()
					containerBorder:Hide()
				end
				itemButton.droprate = nil
				if dataID == "SearchResult" or dataID == "WishList" then
					itemButton.sourcePage = dataSource[dataID][i][5]
				else
					local droprate = dataSource[dataID][i][5]
					if droprate and string.find(droprate, "%%") then
						itemButton.droprate = droprate
					end
				end
				itemButton:Show()
				if GetMouseFocus() == itemButton then
					itemButton:Hide()
					itemButton:Show()
				end
			else
				_G["AtlasLootItem_"..i]:Hide()
			end
		end
	end
	-- This is a valid QuickLook, so show the UI objects
	if dataID ~= "SearchResult" and dataID ~= "WishList" then
		AtlasLoot_QuickLooks:Show()
		AtlasLootQuickLooksButton:Show()
	else
		AtlasLoot_QuickLooks:Hide()
		AtlasLootQuickLooksButton:Hide()
	end
	-- Hide navigation buttons by default, only show what we need
	AtlasLootItemsFrame_BACK:Hide()
	AtlasLootItemsFrame_NEXT:Hide()
	AtlasLootItemsFrame_PREV:Hide()
	AtlasLoot_BossName:SetText(title)
	-- Consult the button registry to determine what nav buttons are required
	if dataID == "SearchResult" or dataID == "WishList" then
		if wlPage < wlPageMax then
			AtlasLootItemsFrame_NEXT:Show()
			AtlasLootItemsFrame_NEXT.lootpage = dataID.."Page"..(wlPage + 1)
		end
		if wlPage > 1 then
			AtlasLootItemsFrame_PREV:Show()
			AtlasLootItemsFrame_PREV.lootpage = dataID.."Page"..(wlPage - 1)
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
	-- Definition of where I want the loot table to be shown
	AtlasLoot_AnchorPoint = Anchor_Default

	-- If the button clicked was linked to a loot table
	if tabletype == "Table" then
		-- Show the loot table
		AtlasLoot_ShowBossLoot(dataID, text)
		-- Purge the text label for the submenu and disable the submenu
		AtlasLootDefaultFrame_SubMenu:Disable()
		AtlasLootDefaultFrame_SelectedTable:SetText("")
		-- If the button links to a sub menu definition
	else
		-- Enable the submenu button
		AtlasLootDefaultFrame_SubMenu:Enable()
		-- Show the first loot table associated with the submenu
		AtlasLoot_ShowBossLoot(AtlasLoot_HewdropDown_SubTables[dataID][1][2], AtlasLoot_HewdropDown_SubTables[dataID][1][1])
		-- Load the correct submenu and associated with the button
		AtlasLoot_HewdropSubMenu:Unregister(AtlasLootDefaultFrame_SubMenu)
		AtlasLoot_HewdropSubMenuRegister(AtlasLoot_HewdropDown_SubTables[dataID])
		-- Show a text label of what has been selected
		AtlasLootDefaultFrame_SelectedTable:SetText(AtlasLoot_HewdropDown_SubTables[dataID][1][1])
	end
	-- Show the category that has been selected
	-- AtlasLootDefaultFrame_SelectedCategory:SetText(text)
	AtlasLoot_Hewdrop:Close(1)
end

--[[
AtlasLoot_HewdropSubMenuClick(tablename, text):
tablename - Name of the loot table in the database
text - Heading for the loot table
Called when a button in AtlasLoot_HewdropSubMenu is clicked
]]
function AtlasLoot_HewdropSubMenuClick(tablename, text)
	-- Definition of where I want the loot table to be shown
	AtlasLoot_AnchorPoint = Anchor_Default
	-- Show the select loot table
	AtlasLoot_ShowBossLoot(tablename, text)
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
									'text', i,
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

function AtlasLoot_OpenMenu(menuName)
	AtlasLootDefaultFrame_SelectedCategory:SetText(menuName)
	AtlasLootDefaultFrame_SubMenu:Disable()
	AtlasLootDefaultFrame_SelectedTable:SetText("")
	AtlasLootDefaultFrame_SelectedTable:Show()
	if menuName == AL["Crafting"] then
		AtlasLoot_ShowItemsFrame("CRAFTINGMENU")
	elseif menuName == AL["PvP Rewards"] then
		AtlasLoot_ShowItemsFrame("PVPMENU")
	elseif menuName == AL["World Events"] then
		AtlasLoot_ShowItemsFrame("WORLDEVENTMENU")
	elseif menuName == AL["Collections"] then
		AtlasLoot_ShowItemsFrame("SETMENU")
	elseif menuName == AL["Factions"] then
		AtlasLoot_ShowItemsFrame("REPMENU")
	elseif menuName == AL["World Bosses"] then
		AtlasLoot_ShowItemsFrame("WORLDBOSSMENU")
	elseif menuName == AL["Dungeons & Raids"] then
		AtlasLoot_ShowItemsFrame("DUNGEONSMENU1")
	end
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
AtlasLootMenuItem_OnClick:
Requests the relevant loot page from a menu screen
]]
function AtlasLootMenuItem_OnClick()
	if this.container then
		AtlasLoot_ShowContainerFrame()
		return
	end
	if this.isheader then return end
	CloseDropDownMenus()
	AtlasLoot_ShowBossLoot(this.lootpage)
end

--[[
AtlasLoot_NavButton_OnClick:
Called when <-, -> or 'Back' are pressed and calls up the appropriate loot page
]]
function AtlasLoot_NavButton_OnClick()
	if not this.lootpage then return end
	if string.sub(this.lootpage, 1, 16) == "SearchResultPage" then
		AtlasLoot_ShowItemsFrame("SearchResult", this.lootpage)
	elseif string.sub(this.lootpage, 1, 12) == "WishListPage" then
		AtlasLoot_ShowItemsFrame("WishList", this.lootpage)
	else
		AtlasLoot_ShowItemsFrame(this.lootpage)
	end
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
AtlasLoot_ClearQuickLookButton()
Clears a quicklook button.
]]
function AtlasLoot_ClearQuickLookButton(button)
	if not button then return end
	AtlasLootCharDB["QuickLooks"][button] = nil
	AtlasLoot_RefreshQuickLookButtons()
	DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..WHITE..AL["QuickLook"].." "..button.." "..AL["has been reset!"])
end

--[[
AtlasLoot_ShowBossLoot(dataID, boss, pFrame):
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
		-- Use the original WoW instance data by default
		local dataSource = AtlasLoot_TableNames[dataID][2]
		-- Set selected table and call AtlasLoot_ShowItemsFrame
		AtlasLootItemsFrame.externalBoss = dataID
		AtlasLoot_ShowItemsFrame(dataID, dataSource, boss)
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
	end
end

--[[
AtlasLootMinimapButton_Init:
Show/hide minimap button.
]]
function AtlasLootMinimapButton_Init()
	if AtlasLootCharDB.MinimapButton == true then
		AtlasLootMinimapButtonFrame:Show()
	else
		AtlasLootMinimapButtonFrame:Hide()
	end
end

--[[
AtlasLootMinimapButton_OnEnter:
Show tooltip when mouse is over minimap button.
]]
function AtlasLootMinimapButton_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_LEFT")
	GameTooltip:SetText(AL["AtlasLoot Enhanced"])
	GameTooltipTextLeft1:SetTextColor(1, 1, 1)
	GameTooltip:AddLine(AL["Left-click to open AtlasLoot.\nMiddle-click for AtlasLoot options.\nRight-click and drag to move this button."])
	GameTooltip:Show()
end

--[[
AtlasLootButton_UpdatePosition:
Function to move the minimap button around the minimap.
]]
function AtlasLootMinimapButton_UpdatePosition()
	AtlasLootMinimapButtonFrame:SetPoint(
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
	-- AtlasLootCharDB.SafeLinks = false
	-- AtlasLootCharDB.AllLinks = true
	AtlasLootCharDB.DefaultTT = true
	AtlasLootCharDB.LootlinkTT = false
	AtlasLootCharDB.ItemSyncTT = false
	AtlasLootCharDB.ShowSource = true
	AtlasLootCharDB.EquipCompare = false
	AtlasLootCharDB.Opaque = false
	AtlasLootCharDB.ItemIDs = false
	-- AtlasLootCharDB.ItemSpam = true
	AtlasLootCharDB.MinimapButton = true
	AtlasLootCharDB.HidePanel = false
	-- AtlasLootCharDB.AutoQuery = false
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
	if v < 0 then
		v = v + 360
	end
	AtlasLootCharDB.MinimapButtonPosition = v
	AtlasLootMinimapButton_UpdatePosition()
end

--------------------------------------------------------------------------------
-- Item OnEnter
-- Called when a loot item is moused over
--------------------------------------------------------------------------------
local stringArgs = {}
local messageShown = false
function AtlasLootItem_OnEnter()
	local isItem, isEnchant, isSpell
	local buttonID = this:GetID()
	AtlasLootTooltip:ClearLines()
	for i = 1, 30, 1 do
		if _G["AtlasLootTooltipTextRight"..i] then
			_G["AtlasLootTooltipTextRight"..i]:SetText("")
		end
	end
	if not (this.itemID and this.itemID ~= 0) then
		return
	end
	if string.sub(this.itemID, 1, 1) == "s" then
		isItem = false
		isEnchant = false
		isSpell = true
	elseif string.sub(this.itemID, 1, 1) == "e" then
		isItem = false
		isEnchant = true
		isSpell = false
	else
		isItem = true
		isEnchant = false
		isSpell = false
	end
	if isItem then
		local name, link, quality = GetItemInfo(this.itemID)
		local _, _, _, color = GetItemQualityColor(quality or 1)
		-- local color = strsub(_G["AtlasLootItem_"..buttonID.."_Name"]:GetText(), 3, 10)
		-- local name = strsub(_G["AtlasLootItem_"..buttonID.."_Name"]:GetText(), 11)
		-- Lootlink tooltips
		if AtlasLootCharDB.LootlinkTT then
			-- If we have seen the item, use the game tooltip to minimise same name item problems
			if name then
				AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24)
				AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0")
				if AtlasLootCharDB.ItemIDs then
					AtlasLootTooltip:AddLine(AL["ItemID:"].." "..this.itemID)
				end
				if this.droprate then
					AtlasLootTooltip:AddLine(AL["Drop Rate: "]..this.droprate, 1, 1, 0)
				end
				AtlasLootTooltip:Show()
				if LootLink_AddItem then
					LootLink_AddItem(name, this.itemID..":0:0:0", color)
				end
			else
				AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24)
				if LootLink_Database and LootLink_Database[this.itemID] then
					LootLink_SetTooltip(AtlasLootTooltip, LootLink_Database[this.itemID][1], 1)
				else
					LootLink_SetTooltip(AtlasLootTooltip, name, 1)
				end
				if AtlasLootCharDB.ItemIDs then
					AtlasLootTooltip:AddLine(AL["ItemID:"].." "..this.itemID)
				end
				if this.droprate then
					AtlasLootTooltip:AddLine(AL["Drop Rate: "]..this.droprate, 1, 1, 0, 1)
				end
				AtlasLootTooltip:Show()
			end
			-- Item Sync tooltips
		elseif AtlasLootCharDB.ItemSyncTT then
			ItemSync:ButtonEnter()
			if AtlasLootCharDB.ItemIDs then
				GameTooltip:AddLine(AL["ItemID:"].." "..this.itemID)
			end
			if this.droprate then
				GameTooltip:AddLine(AL["Drop Rate: "]..this.droprate, 1, 1, 0)
			end
			GameTooltip:Show()
			-- Default game tooltips
		else
			AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24)
			if GetItemInfo(this.itemID) then
				AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0")
			else
				AtlasLootTooltip:SetText(AL["Retrieving item information"], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
			end
			if AtlasLootCharDB.ItemIDs then
				AtlasLootTooltip:AddLine(AL["ItemID:"].." "..this.itemID)
			end
			if this.droprate then
				AtlasLootTooltip:AddLine(AL["Drop Rate: "]..this.droprate, 1, 1, 0)
			end
			AtlasLootTooltip:Show()
		end
	elseif isEnchant then
		local spellID = tonumber(string.sub(this.itemID, 2))
		AtlasLootTooltip:SetOwner(this, "ANCHOR_NONE")
		AtlasLootTooltip:SetPoint("BOTTOMLEFT", this, "TOPRIGHT", -(this:GetWidth() / 2), 24)
		AtlasLootTooltip:ClearLines()
		if SetAutoloot == nil or (SUPERWOW_VERSION and (tonumber(SUPERWOW_VERSION)) >= 1.2) then
			AtlasLootTooltip:SetHyperlink("enchant:"..spellID)
		else
			AtlasLootTooltip:SetHyperlink("spell:"..spellID)
			if not messageShown then
				DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..WHITE.."Old version of SuperWoW detected, please download the latest version from https://github.com/balakethelock/SuperWoW/releases/tag/Release")
				messageShown = true
			end
		end
		local _, _, longCooldown = strfind(AtlasLootTooltipTextRight2:GetText() or "", gsub(SPELL_RECAST_TIME_MIN, "%%%.3g", "(.+)"))
		if longCooldown and strfind(longCooldown, "e%+") then
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
		if not (item and item ~= 0) then
			return
		end
		AtlasLootTooltip2:SetOwner(this, "ANCHOR_NONE")
		AtlasLootTooltip2:SetPoint("TOPLEFT", AtlasLootTooltip, "BOTTOMLEFT", 0, 0)
		AtlasLootTooltip2:ClearLines()
		if not GetItemInfo(item) then
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
		-- Reposition if tooltips overlap
		local bottom = AtlasLootTooltip:GetBottom()
		local top = AtlasLootTooltip2:GetTop()
		if top and bottom and bottom < top then
			AtlasLootTooltip2:ClearAllPoints()
			AtlasLootTooltip2:SetPoint("TOPLEFT", this, "TOPRIGHT", -(this:GetWidth() / 2), 24)
			AtlasLootTooltip:ClearAllPoints()
			AtlasLootTooltip:SetPoint("BOTTOMLEFT", AtlasLootTooltip2, "TOPLEFT", 0, 0)
		end
	elseif isSpell then
		local spellID = tonumber(string.sub(this.itemID, 2))
		AtlasLootTooltip:SetOwner(this, "ANCHOR_NONE")
		AtlasLootTooltip:SetPoint("BOTTOMLEFT", this, "TOPRIGHT", -(this:GetWidth() / 2), 24)
		AtlasLootTooltip:ClearLines()
		if SpellInfo then
			AtlasLootTooltip:SetHyperlink("enchant:"..spellID)
			local _, _, longCooldown = strfind(AtlasLootTooltipTextRight2:GetText() or "", gsub(SPELL_RECAST_TIME_MIN, "%%%.3g", "(.+)"))
			if longCooldown and strfind(longCooldown, "e%+") then
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
				for i = getn(stringArgs), 1, -1 do
					tremove(stringArgs, i)
				end
				for j = 1, getn(tools) do
					if AtlasLoot_CacheItem(tools[j]) == false then
						AtlasLootItemsFrame.refreshTime = refreshTimeout
						AtlasLootItemsFrame.queue[tools[j]] = true
					end
					tinsert(stringArgs, (GetItemInfo(tools[j]) or ""))
					tinsert(stringArgs, AtlasLoot_CheckBagsForItems(tools[j]))
				end
				AtlasLootTooltip:AddLine(SPELL_TOTEMS..BuildColoredListString(unpack(stringArgs)), 1, 1, 1, false)
			end
			if type(reagents) == "table" then
				for i = getn(stringArgs), 1, -1 do
					tremove(stringArgs, i)
				end
				for j = 1, getn(reagents) do
					if reagents[j][2] and reagents[j][2] > 1 then
						if AtlasLoot_CacheItem(reagents[j][1]) == false then
							AtlasLootItemsFrame.refreshTime = refreshTimeout
							AtlasLootItemsFrame.queue[reagents[j][1]] = true
						end
						tinsert(stringArgs, ((GetItemInfo(reagents[j][1])) or "").." ("..reagents[j][2]..")")
					else
						tinsert(stringArgs, ((GetItemInfo(reagents[j][1])) or ""))
					end
					tinsert(stringArgs, AtlasLoot_CheckBagsForItems(reagents[j][1], reagents[j][2]))
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
		if not (craftItem and craftItem ~= 0) then
			return
		end
		AtlasLootTooltip2:SetOwner(this, "ANCHOR_NONE")
		AtlasLootTooltip2:SetPoint("TOPLEFT", AtlasLootTooltip, "BOTTOMLEFT", 0, 0)
		AtlasLootTooltip2:ClearLines()
		if not GetItemInfo(craftItem) then
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
		-- Reposition if tooltips overlap
		local bottom = AtlasLootTooltip:GetBottom()
		local top = AtlasLootTooltip2:GetTop()
		if bottom and top and bottom < top then
			AtlasLootTooltip2:ClearAllPoints()
			AtlasLootTooltip2:SetPoint("TOPLEFT", this, "TOPRIGHT", -(this:GetWidth() / 2), 24)
			AtlasLootTooltip:ClearAllPoints()
			AtlasLootTooltip:SetPoint("BOTTOMLEFT", AtlasLootTooltip2, "TOPLEFT", 0, 0)
		end
	end
end

--------------------------------------------------------------------------------
-- Item OnLeave
-- Called when the mouse cursor leaves a loot item
--------------------------------------------------------------------------------
function AtlasLootItem_OnLeave()
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
function AtlasLootItem_OnClick()
	local isItem, isEnchant, isSpell
	local name = _G["AtlasLootItem_"..this:GetID().."_Name"]:GetText()
	local _, _, color = strfind(name, "(|cff%x%x%x%x%x%x)")
	color = color or NORMAL_FONT_COLOR_CODE
	name = gsub(name, "|cff%x%x%x%x%x%x", "")
	name = gsub(name, "|r", "")
	local id = this:GetID()
	local _, _, texture = strfind(_G["AtlasLootItem_"..this:GetID().."_Icon"]:GetTexture() or "", ".+\\(.+)$")
	texture = texture or "INV_Misc_QuestionMark"
	local dataID = AtlasLootItemsFrame.refresh[1]
	local dataSource = AtlasLootItemsFrame.refresh[2]
	local bossName = AtlasLootItemsFrame.refresh[3]
	if string.sub(this.itemID, 1, 1) == "s" then
		isItem = false
		isEnchant = false
		isSpell = true
	elseif string.sub(this.itemID, 1, 1) == "e" then
		isItem = false
		isEnchant = true
		isSpell = false
	else
		isItem = true
		isEnchant = false
		isSpell = false
	end
	if isItem then
		local itemName, itemLink = GetItemInfo(this.itemID)
		-- If shift-clicked, link in the chat window
		if itemName and IsShiftKeyDown() and this.itemID ~= 0 then
			if WIM_EditBoxInFocus then
				WIM_EditBoxInFocus:Insert(color.."|Hitem:"..this.itemID..":0:0:0|h["..itemName.."]|h|r")
			elseif ChatFrameEditBox:IsVisible() then
				ChatFrameEditBox:Insert(color.."|Hitem:"..this.itemID..":0:0:0|h["..itemName.."]|h|r")
			else
				AtlasLoot_SayItemReagents(this.itemID, color, itemName)
			end
			-- If control-clicked, use the dressing room
		elseif IsControlKeyDown() and itemLink then
			DressUpItemLink(itemLink)
		elseif IsAltKeyDown() and this.itemID ~= 0 then
			if dataID == "WishList" then
				AtlasLoot_DeleteFromWishList(this.itemID)
			elseif dataID == "SearchResult" then
				AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(this.itemID))
			else
				AtlasLoot_AddToWishlist(this.itemID, texture, this.itemIDName, this.itemIDExtra, dataID.."|"..dataSource)
			end
		elseif (dataID == "SearchResult" or dataID == "WishList") and this.sourcePage then
			local _, _, dataID, dataSource = strfind(this.sourcePage, "(.+)|(.+)")
			if dataID and dataSource then
				AtlasLoot_ShowItemsFrame(dataID, dataSource)
			end
		elseif this.container then
			AtlasLoot_ShowContainerFrame()
		end
	elseif isEnchant then
		if IsShiftKeyDown() then
			AtlasLoot_SayItemReagents(this.itemID, color, name)
		elseif IsAltKeyDown() and this.itemID ~= 0 then
			if dataID == "WishList" then
				AtlasLoot_DeleteFromWishList(this.itemID)
			elseif dataID == "SearchResult" then
				AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(this.itemID))
			else
				AtlasLoot_AddToWishlist(this.itemID, texture, this.itemIDName, this.itemIDExtra, dataID.."|"..dataSource)
			end
		elseif IsControlKeyDown() and this.dressingroomID then
			DressUpItemLink("item:"..this.dressingroomID..":0:0:0")
		elseif (dataID == "SearchResult" or dataID == "WishList") and this.sourcePage then
			local _, _, dataID, dataSource = strfind(this.sourcePage, "(.+)|(.+)")
			if dataID and dataSource then
				AtlasLoot_ShowItemsFrame(dataID, dataSource)
			end
		end
	elseif isSpell then
		if IsShiftKeyDown() then
			local spellID = tonumber(string.sub(this.itemID, 2))
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
				AtlasLoot_SayItemReagents(this.itemID, color, name)
			end
		elseif IsAltKeyDown() and this.itemID ~= 0 then
			if dataID == "WishList" then
				AtlasLoot_DeleteFromWishList(this.itemID)
			elseif dataID == "SearchResult" then
				AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(this.itemID))
			else
				AtlasLoot_AddToWishlist(this.itemID, texture, this.itemIDName, this.itemIDExtra, dataID.."|"..dataSource)
			end
		elseif IsControlKeyDown() and this.dressingroomID then
			DressUpItemLink("item:"..this.dressingroomID..":0:0:0")
		elseif (dataID == "SearchResult" or dataID == "WishList") and this.sourcePage then
			local _, _, dataID, dataSource = strfind(this.sourcePage, "(.+)|(.+)")
			if dataID and dataSource then
				AtlasLoot_ShowItemsFrame(dataID, dataSource)
			end
		end
	end
end

-- retun true if item is cached, false if argument is a valid link or id, but its not cahced yet, nil otherwise
function AtlasLoot_CacheItem(linkOrID)
	if not linkOrID or linkOrID == 0 then
		return nil
	end
	if (tonumber(linkOrID)) then
		if GetItemInfo(linkOrID) then
			return true
		else
			AtlasLootCacheTooltip:SetHyperlink("item:"..linkOrID)
			return false
		end
	else
		if type(linkOrID) ~= "string" then
			return nil
		end
		local _, _, item = strfind(linkOrID, "(item:%d+:%d+:%d+:%d+)")
		if item then
			if GetItemInfo(item) then
				return true
			else
				AtlasLootCacheTooltip:SetHyperlink(item)
				return false
			end
		end
	end
end

local containerItemFrames = {}
local lastSelectedButton
function AtlasLoot_ShowContainerFrame()
	local containerTable = this.container
	if not containerTable then
		return
	end
	if this ~= lastSelectedButton then
		AtlasLootItemsFrameContainer:Show()
		lastSelectedButton = this
	elseif AtlasLootItemsFrameContainer:IsVisible() then
		AtlasLootItemsFrameContainer:Hide()
		lastSelectedButton = nil
		return
	end
	if not AtlasLootItemsFrameContainer:IsVisible() and lastSelectedButton == this then
		AtlasLootItemsFrameContainer:Show()
	end
	for i = 1, getn(containerItemFrames) do
		_G["AtlasLootContainerItem"..i]:Hide()
	end
	local row = 0
	local col = 0
	local buttonIndex = 1
	local maxCols = 1

	for i = 1, getn(containerTable) do
		col = 0
		for j = 1, getn(containerTable[i]) do
			if not containerItemFrames[buttonIndex] then
				containerItemFrames[buttonIndex] = CreateFrame("Button", "AtlasLootContainerItem"..buttonIndex, AtlasLootItemsFrameContainer, "AtlasLootContainerItemTemplate")
			end
			local itemButton = _G["AtlasLootContainerItem"..buttonIndex]
			local itemID = containerTable[i][j][1]
			AtlasLoot_CacheItem(itemID)
			itemButton.extraInfo = containerTable[i][j][2]
			itemButton.dressingroomID = itemID
			local _, _, quality, _, _, _, _, _, tex = GetItemInfo(itemID)
			local icon = _G["AtlasLootContainerItem"..buttonIndex.."Icon"]
			local r, g, b = 1, 1, 1
			if quality then
				r, g, b = GetItemQualityColor(quality)
			end
			if not tex then
				tex = "Interface\\Icons\\INV_Misc_QuestionMark"
			end
			itemButton:SetPoint("TOPLEFT", AtlasLootItemsFrameContainer, (col * 35) + 5, -(row * 35) - 5)
			itemButton:SetBackdropBorderColor(r, g, b)
			itemButton:SetID(itemID)
			itemButton:Show()
			icon:SetTexture(tex)
			col = col + 1
			if col > maxCols then
				maxCols = col
			end
			buttonIndex = buttonIndex + 1
		end
		row = row + 1
	end
	AtlasLootItemsFrameContainer:SetPoint("TOPLEFT", this, "BOTTOMLEFT", -2, 2)
	AtlasLootItemsFrameContainer:SetWidth(16 + (maxCols * 35))
	AtlasLootItemsFrameContainer:SetHeight(16 + (row * 35))
end

function AtlasLoot_ContainerItem_OnEnter()
	local itemID = this:GetID()
	if not itemID then
		return
	end
	AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 4), -(this:GetHeight() / 4))
	AtlasLootTooltip:SetHyperlink("item:"..tostring(itemID))
	AtlasLootTooltip.itemID = itemID
	local numLines = AtlasLootTooltip:NumLines()
	if AtlasLootCharDB.ItemIDs then
		if numLines and numLines > 0 then
			local lastLine = _G["AtlasLootTooltipTextLeft"..numLines]
			if lastLine:GetText() then
				lastLine:SetText(lastLine:GetText().."\n\n"..DEFAULT..AL["ItemID:"].." "..itemID)
			end
		end
	end
	AtlasLootTooltip:Show()
	local icon = _G[this:GetName().."Icon"]
	if icon:GetTexture() == "Interface\\Icons\\INV_Misc_QuestionMark" then
		local _, _, quality, _, _, _, _, _, tex = GetItemInfo(itemID)
		if tex and quality then
			local r, g, b = GetItemQualityColor(quality)
			icon:SetTexture(tex)
			this:SetBackdropBorderColor(r, g, b)
		end
	end
end

function AtlasLoot_ContainerItem_OnLeave()
	AtlasLootTooltip:Hide()
	AtlasLootTooltip.itemID = nil
end

function AtlasLoot_ContainerItem_OnClick(arg1)
	local itemID = this:GetID()
	local name, link, quality, _, _, _, _, _, tex = GetItemInfo(itemID or 0)
	if not name then
		return
	end
	local _, _, _, color = GetItemQualityColor(quality)
	tex = string.gsub(tex, "Interface\\Icons\\", "")
	local extra = this.extraInfo
	local lootpage, dataSource
	if lastSelectedButton then
		lootpage = lastSelectedButton.lootpage
		dataSource = lastSelectedButton.dataSource
	end
	if IsShiftKeyDown() and arg1 == "LeftButton" then
		if WIM_EditBoxInFocus then
			WIM_EditBoxInFocus:Insert(color.."|Hitem:"..itemID..":0:0:0|h["..name.."]|h|r")
		elseif ChatFrameEditBox:IsVisible() then
			ChatFrameEditBox:Insert(color.."|Hitem:"..itemID..":0:0:0|h["..name.."]|h|r")
		end
	elseif IsControlKeyDown() and link then
		DressUpItemLink(link)
	elseif IsAltKeyDown() and itemID ~= 0 then
		if lootpage and dataSource then
			AtlasLoot_AddToWishlist(itemID, tex, name, extra, lootpage.."|"..dataSource)
		elseif AtlasLootItemsFrame.refresh then
			local dataID = AtlasLootItemsFrame.refresh[1]
			local dataSource = AtlasLootItemsFrame.refresh[2]
			if dataID == "WishList" then
				AtlasLoot_DeleteFromWishList(this.itemID)
			elseif dataID == "SearchResult" then
				AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(itemID))
			else
				AtlasLoot_AddToWishlist(itemID, tex, name, extra, dataID.."|"..dataSource)
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
	name = gsub(name, "|cff%x%x%x%x%x%x", "")
	name = gsub(name, "|r", "")
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

function AtlasLoot_QuickLook_OnClick(id)
	if IsAltKeyDown() then
		AtlasLoot_ClearQuickLookButton(id)
		return
	end
	if this:GetParent() == AtlasLootPanel then
		if AtlasLootPanel:GetParent() == AtlasFrame then
			AtlasLoot_AnchorPoint = Anchor_Atlas
		elseif AtlasLootPanel:GetParent() == AlphaMapAlphaMapFrame then
			AtlasLoot_AnchorPoint = Anchor_AlphaMap
		end
	else
		AtlasLoot_AnchorPoint = Anchor_Default
	end
	AtlasLoot_ShowItemsFrame(AtlasLootCharDB["QuickLooks"][id][1], AtlasLootCharDB["QuickLooks"][id][2], AtlasLootCharDB["QuickLooks"][id][3])
end

function AtlasLoot_QuickLook_OnShow(id)
	this:SetText(AL["QuickLook"].." "..id)
	this:SetFrameLevel(this:GetParent():GetFrameLevel() + 1)
	if not AtlasLootCharDB["QuickLooks"][id] or not AtlasLootCharDB["QuickLooks"][id][1] then
		this:Disable()
	end
end

function AtlasLoot_QuickLook_OnEnter(id)
	if this:IsEnabled() then
		GameTooltip:ClearLines()
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 5)
		GameTooltip:AddLine(WHITE..AtlasLootCharDB["QuickLooks"][id][3].."|r")
		GameTooltip:AddLine(AL["ALT+Click to clear"])
		GameTooltip:Show()
	end
end
