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

AtlasLoot = AceLibrary("AceAddon-2.0"):new("AceDB-2.0")

-- Instance required libraries
local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

-- Establish version number and compatible version of Atlas
local ver = string.gsub(GetAddOnMetadata("AtlasLoot", "Version"), "%.", "0")
_,_, ver = string.find(ver, "(%d+)")
local version = tonumber(ver)
ATLASLOOT_VERSION = "|cffFF8400AtlasLoot TW Edition v"..GetAddOnMetadata("AtlasLoot", "Version").."|r";

-- Compatibility with old EquipCompare/EQCompare
ATLASLOOT_OPTIONS_EQUIPCOMPARE = AL["Use EquipCompare"];
ATLASLOOT_OPTIONS_EQUIPCOMPARE_DISABLED = AL["|cff9d9d9dUse EquipCompare|r"];

-- Make the Hewdrop menu in the standalone loot browser accessible here
AtlasLoot_Hewdrop = AceLibrary("Hewdrop-2.0");
AtlasLoot_HewdropSubMenu = AceLibrary("Hewdrop-2.0");

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";
local DEFAULT = "|cffFFd200";

-- Establish number of boss lines in the Atlas frame for scrolling
local ATLAS_LOOT_BOSS_LINES	= 24;

local Anchor_Atlas = { "TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84 }
local Anchor_AlphaMap = { "TOPLEFT", "AlphaMapAlphaMapFrame", "TOPLEFT", 0, 0 }
local Anchor_Default = { "TOPLEFT", "AtlasLootDefaultFrame_LootBackground", "TOPLEFT", 2, -2 }

-- Variables to hold hooked Atlas functions
Hooked_Atlas_Refresh = nil;
Hooked_Atlas_OnShow = nil;
Hooked_AtlasScrollBar_Update = nil;

AtlasLootCharDB = {};

AtlasLoot:RegisterDB("AtlasLootDB");

-- Popup Box for first time users
StaticPopupDialogs["ATLASLOOT_SETUP"] = {
	text = AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."],
	button1 = AL["Setup"],
	OnAccept = function()
		AtlasLootOptions_Toggle();
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

AtlasLoot_Data["AtlasLootFallback"] = {
	EmptyInstance = {};
};

AtlasLoot_MenuList = {
	["DUNGEONSMENU1"] = "AtlasLoot_DungeonsMenu1",
	["DUNGEONSMENU2"] = "AtlasLoot_DungeonsMenu2",
	["PVPMENU"] = "AtlasLootPvPMenu",
	["ABRepMenu"] = "AtlasLootABRepMenu",
	["AVRepMenu"] = "AtlasLootAVRepMenu",
	["WSGRepMenu"] = "AtlasLootWSGRepMenu",
	["BRRepMenu"] = "AtlasLootBRRepMenu",
	["PVPSET"] = "AtlasLootPVPSetMenu",
	["SETMENU"] = "AtlasLootSetMenu",
	["AQ20SET"] = "AtlasLootAQ20SetMenu",
	["AQ40SET"] = "AtlasLootAQ40SetMenu",
	["KARASET"] = "AtlasLoot_Kara40SetMenu",
	["PRE60SET"] = "AtlasLootPRE60SetMenu",
	["ZGSET"] = "AtlasLootZGSetMenu",
	["T3SET"] = "AtlasLootT3SetMenu",
	["T2SET"] = "AtlasLootT2SetMenu",
	["T1SET"] = "AtlasLootT1SetMenu",
	["T0SET"] = "AtlasLootT0SetMenu",
	["REPMENU"] = "AtlasLootRepMenu",
	["WORLDEVENTMENU"] = "AtlasLootWorldEventMenu",
	["ALCHEMYMENU"] = "AtlasLoot_AlchemyMenu",
	["CRAFTINGMENU"] = "AtlasLoot_CraftingMenu",
	["SMITHINGMENU"] = "AtlasLoot_SmithingMenu",
	["ENCHANTINGMENU"] = "AtlasLoot_EnchantingMenu",
	["ENGINEERINGMENU"] = "AtlasLoot_EngineeringMenu",
	["LEATHERWORKINGMENU"] = "AtlasLoot_LeatherworkingMenu",
	["TAILORINGMENU"] = "AtlasLoot_TailoringMenu",
	["JEWELCRAFTMENU"] = "AtlasLoot_JewelcraftingMenu",
	["CRAFTSET"] = "AtlasLootCraftedSetMenu",
	["WORLDBOSSMENU"] = "AtlasLoot_WorldBossMenu",
};

--[[
AtlasLootDefaultFrame_OnShow:
Called whenever the loot browser is shown and sets up buttons and loot tables
]]
function AtlasLootDefaultFrame_OnShow()
	-- Definition of where I want the loot table to be shown
	AtlasLoot_AnchorPoint = Anchor_Default;
	-- Having the Atlas and loot browser frames shown at the same time would
	-- cause conflicts, so I hide the Atlas frame when the loot browser appears
	if ( AtlasFrame ) then
		AtlasFrame:Hide();
	end
	-- Remove the selection of a loot table in Atlas
	AtlasLootItemsFrame.activeBoss = nil;
	-- Set the item table to the loot table
	-- AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorPoint);
	-- Show the last displayed loot table
    if ( AtlasLootCharDB.LastBoss == "WishList" ) then
        AtlasLoot_ShowWishList()
        return
    elseif ( AtlasLootCharDB.LastBoss == "SearchResult" ) then
        AtlasLoot:ShowSearchResult()
        return
    end
	if ( AtlasLootItemsFrame.refresh ) then
		AtlasLoot_ShowBossLoot(AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[3], AtlasLoot_AnchorPoint)
	else
		AtlasLoot_ShowBossLoot(AtlasLootCharDB.LastBoss, AtlasLootCharDB.LastBossText, AtlasLoot_AnchorPoint);
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
	if ( event == "ADDON_LOADED" and arg1 == "AtlasLoot" ) then
		this:UnregisterEvent("ADDON_LOADED")
		AtlasLoot_OnVariablesLoaded();
	end
end

--[[
AtlasLoot_OnVariablesLoaded:
Invoked by the VARIABLES_LOADED event.  Now that we are sure all the assets
the addon needs are in place, we can properly set up the mod
]]
function AtlasLoot_OnVariablesLoaded()
	if ( not AtlasLootCharDB ) then AtlasLootCharDB = {} end
	if ( not AtlasLootCharDB["WishList"] ) then AtlasLootCharDB["WishList"] = {} end
	if ( not AtlasLootCharDB["QuickLooks"] ) then AtlasLootCharDB["QuickLooks"] = {} end
	if ( not AtlasLootCharDB["SearchResult"] ) then AtlasLootCharDB["SearchResult"] = {} end
	-- Add the loot browser to the special frames tables to enable closing wih the ESC key
	tinsert(UISpecialFrames, "AtlasLootDefaultFrame");
	tinsert(UISpecialFrames, "AtlasLootOptionsFrame")
	-- Set up options frame
	AtlasLootOptions_OnLoad();
	-- Legacy code for those using the ultimately failed attempt at making Atlas load on demand
	if ( AtlasButton_LoadAtlas ) then
		AtlasButton_LoadAtlas();
	end
	-- Hook the necessary Atlas functions
	Hooked_Atlas_Refresh = Atlas_Refresh;
	Atlas_Refresh = AtlasLoot_Refresh;
	Hooked_Atlas_OnShow = Atlas_OnShow;
	Atlas_OnShow = AtlasLoot_Atlas_OnShow;
	-- Instead of hooking, replace the scrollbar driver function
	Hooked_AtlasScrollBar_Update = AtlasScrollBar_Update;
	AtlasScrollBar_Update = AtlasLoot_AtlasScrollBar_Update;
	-- Disable options that don't have the supporting mods
	if ( not LootLink_SetTooltip and (AtlasLootCharDB.LootlinkTT == true ) ) then
		AtlasLootCharDB.LootlinkTT = false;
		AtlasLootCharDB.DefaultTT = true;
	end
	if ( not ItemSync and (AtlasLootCharDB.ItemSyncTT == true) ) then
		AtlasLootCharDB.ItemSyncTT = false;
		AtlasLootCharDB.DefaultTT = true;
	end
	if ( (not IsAddOnLoaded("EQCompare") and not IsAddOnLoaded("EquipCompare")) and (AtlasLootCharDB.EquipCompare == true) ) then
		AtlasLootCharDB.EquipCompare = false;
	end
	-- If using an opaque items frame, change the alpha value of the backing texture
	if ( AtlasLootCharDB.Opaque ) then
		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 1);
	else
		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0.65);
	end
	-- If Atlas is installed, set up for Atlas
	if ( Hooked_Atlas_Refresh ) then
		AtlasLoot_SetupForAtlas();
		-- If a first time user, set up options
		if ( AtlasLootCharDB.FirstTime == nil or AtlasLootCharDB.FirstTime == true ) then
			StaticPopup_Show ("ATLASLOOT_SETUP");
			AtlasLootCharDB.FirstTime = false;
		end
		-- If an older version
		if ( AtlasLootCharDB.FirstTime == nil and version < 40500 ) then
			AtlasLootCharDB.SafeLinks = true;
			AtlasLootCharDB.AllLinks = false;
			StaticPopup_Show ("ATLASLOOT_SETUP");
			AtlasLootCharDB.FirstTime = false;
		end
		Hooked_Atlas_Refresh();
	else
		-- If we are not using Atlas, keep the items frame out of the way
		AtlasLootItemsFrame:Hide();
	end

    for k, v in pairs(AtlasLootCharDB["WishList"]) do
        if ( type(v[2]) == "table" ) then
            v[2] = v[2][3] or "INV_Misc_QuestionMark"
            break
        end
    end
	-- Adds an AtlasLoot button to the Feature Frame in Cosmos
	if ( EarthFeature_AddButton ) then
		EarthFeature_AddButton(
			{
				id = string.sub(ATLASLOOT_VERSION, 11, 28);
				name = string.sub(ATLASLOOT_VERSION, 11, 28);
				subtext = string.sub(ATLASLOOT_VERSION, 30, 39);
				tooltip = "";
				icon = "Interface\\Icons\\INV_Box_01";
				callback = AtlasLoot_ShowMenu;
				test = nil;
			}
	);
	-- Adds AtlasLoot to old style Cosmos installations
	elseif ( Cosmos_RegisterButton ) then
		Cosmos_RegisterButton(
			string.sub(ATLASLOOT_VERSION, 11, 28),
			string.sub(ATLASLOOT_VERSION, 11, 28),
			"",
			"Interface\\Icons\\INV_Box_01",
			AtlasLoot_ShowMenu
		);
	end
	-- Set up the menu in the loot browser
	AtlasLoot_HewdropRegister();
	-- Enable or disable AtlasLootFu based on seleced options
	-- If EquipCompare is available, use it
	if ( IsAddOnLoaded("EquipCompare") and AtlasLootCharDB.EquipCompare == true ) then
		EquipCompare_RegisterTooltip(AtlasLootTooltip);
		EquipCompare_RegisterTooltip(AtlasLootTooltip2);
	end
	if ( IsAddOnLoaded("EQCompare") and (AtlasLootCharDB.EquipCompare == true) ) then
		EQCompare:RegisterTooltip(AtlasLootTooltip);
		EQCompare:RegisterTooltip(AtlasLootTooltip2);
	end
	-- Position relevant UI objects for loot browser and set up menu
	AtlasLootDefaultFrame_SelectedCategory:SetPoint("TOP", "AtlasLootDefaultFrame_Menu", "BOTTOM", 0, -4);
	AtlasLootDefaultFrame_SelectedTable:SetPoint("TOP", "AtlasLootDefaultFrame_SubMenu", "BOTTOM", 0, -4);
	AtlasLootDefaultFrame_SelectedCategory:SetText(AtlasLootCharDB.LastBossText);
	AtlasLootDefaultFrame_SelectedTable:SetText("");
	AtlasLootDefaultFrame_SelectedCategory:Show();
	AtlasLootDefaultFrame_SelectedTable:Show();
	AtlasLootDefaultFrame_SubMenu:Disable();
end

--[[
AtlasLootOptions_OnLoad:
Function is loaded when the addon is loaded
]]
function AtlasLootOptions_OnLoad()
	-- Disable checkboxes of missing addons
	if ( not LootLink_SetTooltip ) then
		AtlasLootOptionsFrameLootlinkTT:Disable();
		AtlasLootOptionsFrameLootlinkTTText:SetText(AL["|cff9d9d9dLootlink Tooltips|r"]);
	end
	if ( not ItemSync ) then
		AtlasLootOptionsFrameItemSyncTT:Disable();
		AtlasLootOptionsFrameItemSyncTTText:SetText(AL["|cff9d9d9dItemSync Tooltips|r"]);
	end
	if ( not IsAddOnLoaded("EQCompare") and not IsAddOnLoaded("EquipCompare") ) then
		AtlasLootOptionsFrameEquipCompare:Disable();
		AtlasLootOptionsFrameEquipCompareText:SetText(AL["|cff9d9d9dUse EquipCompare|r"]);
	end
	AtlasLootOptions_Init();
	UIPanelWindows['AtlasLootOptionsFrame'] = {area = 'center', pushable = 0};
end

--[[
AtlasLootOptions_Init:
Initiates the options.
]]
function AtlasLootOptions_Init()
	-- clear saved vars for a new version (or a new install!)
	if ( AtlasLootCharDB.FirstTime == nil ) then
		AtlasLootOptions_Fresh();
	end
	-- Initialise all the check boxes on the options frame
	AtlasLootOptionsFrameSafeLinks:SetChecked(AtlasLootCharDB.SafeLinks);
	AtlasLootOptionsFrameAllLinks:SetChecked(AtlasLootCharDB.AllLinks);
	AtlasLootOptionsFrameDefaultTT:SetChecked(AtlasLootCharDB.DefaultTT);
	AtlasLootOptionsFrameLootlinkTT:SetChecked(AtlasLootCharDB.LootlinkTT);
	AtlasLootOptionsFrameItemSyncTT:SetChecked(AtlasLootCharDB.ItemSyncTT);
	AtlasLootOptionsFrameShowSource:SetChecked(AtlasLootCharDB.ShowSource);
	AtlasLootOptionsFrameWishlistGroupedByDungeon:SetChecked(AtlasLootCharDB.WishlistGroupedByDungeon);
	AtlasLootOptionsFrameEquipCompare:SetChecked(AtlasLootCharDB.EquipCompare);
	AtlasLootOptionsFrameOpaque:SetChecked(AtlasLootCharDB.Opaque);
	AtlasLootOptionsFrameItemID:SetChecked(AtlasLootCharDB.ItemIDs);
	AtlasLootOptionsFrameItemSpam:SetChecked(AtlasLootCharDB.ItemSpam);
	AtlasLootOptionsFrameHidePanel:SetChecked(AtlasLootCharDB.HidePanel);
	AtlasLootOptionsFrameMinimap:SetChecked(AtlasLootCharDB.MinimapButton);
	AtlasLootOptionsFrameSliderButtonPos:SetValue(AtlasLootCharDB.MinimapButtonPosition);
	AtlasLootOptionsFrameSliderButtonRad:SetValue(AtlasLootCharDB.MinimapButtonRadius);
	AtlasLootMinimapButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (AtlasLootCharDB.MinimapButtonRadius * cos(AtlasLootCharDB.MinimapButtonPosition)),
		(AtlasLootCharDB.MinimapButtonRadius * sin(AtlasLootCharDB.MinimapButtonPosition)) - 55
	);
end

--[[
Atlas_FreshOptions:
Sets default options on a fresh start.
]]
function AtlasLootOptions_Fresh()
	AtlasLootCharDB.SafeLinks = false;
	AtlasLootCharDB.AllLinks = true;
	AtlasLootCharDB.DefaultTT = true;
	AtlasLootCharDB.LootlinkTT = false;
	AtlasLootCharDB.ItemSyncTT = false;
	AtlasLootCharDB.ShowSource = true;
	AtlasLootCharDB.WishlistGroupedByDungeon = true;
	AtlasLootCharDB.EquipCompare = false;
	AtlasLootCharDB.Opaque = false;
	AtlasLootCharDB.ItemIDs = false;
	AtlasLootCharDB.FirstTime = true;
	AtlasLootCharDB.ItemSpam = true;
	AtlasLootCharDB.MinimapButton = true;
	AtlasLootCharDB.MinimapButtonPosition = 315;
	AtlasLootCharDB.MinimapButtonRadius = 78;
	AtlasLootCharDB.HidePanel = false;
	AtlasLootCharDB.LastBoss = "DUNGEONSMENU1";
	AtlasLootCharDB.LastBossText = AL["Dungeons & Raids"];
	-- AtlasLootCharDB.AutoQuery = false;
	AtlasLootCharDB.PartialMatching = true;
end

--[[
AtlasLoot_OnLoad:
Performs inital setup of the mod and registers it for further setup when
the required resources are in place
]]
function AtlasLoot_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	-- Enable the use of /al or /atlasloot to open the loot browser
	SLASH_ATLASLOOT1 = "/atlasloot";
	SLASH_ATLASLOOT2 = "/al";
	SlashCmdList["ATLASLOOT"] = function(msg)
		AtlasLoot_SlashCommand(msg);
	end
	AtlasLootItemsFrame.queue = {}
end

--[[
AtlasLoot_SlashCommand(msg):
msg - takes the argument for the /atlasloot command so that the appropriate action can be performed
If someone types /atlasloot, bring up the options box
]]
function AtlasLoot_SlashCommand(msg)
	if ( msg == AL["reset"] ) then
		AtlasLootOptions_ResetPosition();
	elseif ( msg == AL["default"] ) then
		AtlasLootOptions_DefaultSettings();
	elseif ( msg == AL["options"] ) then
		AtlasLootOptions_Toggle();
	else
		AtlasLootDefaultFrame:Show();
	end
end

--[[
AtlasLootDefaultFrame_OnHide:
When we close the loot browser, re-bind the item table to Atlas
and close all Hewdrop menus
]]
function AtlasLootDefaultFrame_OnHide()
	if ( AtlasFrame ) then
		AtlasLoot_SetupForAtlas();
	end
	AtlasLoot_Hewdrop:Close(1);
	AtlasLoot_HewdropSubMenu:Close(1);
	if ( AtlasLootItemsFrame.refresh ) then
		AtlasLootCharDB.LastBoss = AtlasLootItemsFrame.refresh[1]
		AtlasLootCharDB.LastBossText = AtlasLootItemsFrame.refresh[3]
	end
end
--[[
AtlasLoot_SetupForAtlas:
This function sets up the Atlas specific XML objects
]]
function AtlasLoot_SetupForAtlas()
	-- Poisition the frame with the AtlasLoot version details in the Atlas frame
	AtlasLootInfo:ClearAllPoints();
	AtlasLootInfo:SetParent(AtlasFrame);
	AtlasLootInfo:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 546, -3);
	-- Anchor the bottom panel to the Atlas frame
	AtlasLootPanel:ClearAllPoints();
	AtlasLootPanel:SetParent(AtlasFrame);
	AtlasLootPanel:SetPoint("TOP", "AtlasFrame", "BOTTOM", 0, 9);
    AtlasLoot_AnchorPoint = Anchor_Atlas
	AtlasLootItemsFrame:Hide();
end

--[[
AtlasLoot_SetItemInfoFrame(pFrame):
pFrame - Data structure with anchor info.  Format: {Anchor Point, Relative Frame, Relative Point, X Offset, Y Offset }
This function anchors the item frame where appropriate.  The main Atlas frame can be passed instead of a custom pFrame.
If no pFrame is specified, the Atlas Frame is used if Atlas is installed.
]]
-- function AtlasLoot_SetItemInfoFrame(pFrame)
-- 	if ( pFrame ) then
-- 		-- If a pFrame is specified, use it
-- 		if ( pFrame == AtlasFrame and AtlasFrame ) then
-- 			AtlasLootItemsFrame:ClearAllPoints();
-- 			AtlasLootItemsFrame:SetParent(AtlasFrame);
-- 			AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
-- 		else
-- 			AtlasLootItemsFrame:ClearAllPoints();
-- 			AtlasLootItemsFrame:SetParent(pFrame[2]);
-- 			AtlasLootItemsFrame:SetPoint(pFrame[1], pFrame[2], pFrame[3], pFrame[4], pFrame[5]);
-- 		end
-- 	elseif ( AtlasFrame ) then
-- 		-- If no pFrame is specified and Atlas is installed, anchor in Atlas
-- 		AtlasLootItemsFrame:ClearAllPoints();
-- 		AtlasLootItemsFrame:SetParent(AtlasFrame);
-- 		AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
-- 	elseif ( AtlasLootDefaultFrame ) then
-- 		AtlasLootItemsFrame:ClearAllPoints();
-- 		AtlasLootItemsFrame:SetParent(AtlasLootDefaultFrame);
-- 		AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasLootDefaultFrame", "TOPLEFT", 0, 0);
-- 	end
-- 	AtlasLootItemsFrame:Show();
-- end

--[[
AtlasLoot_AtlasScrollBar_Update:
Hooks the Atlas scroll frame.
Required as the Atlas function cannot deal with the AtlasLoot button template or the added Atlasloot entries
]]
function AtlasLoot_AtlasScrollBar_Update()
	local lineplusoffset;
	if ( not AtlasBossLine1_Text ) then
		return
	end
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	-- Update the contents of the Atlas scroll frame
	FauxScrollFrame_Update(AtlasScrollBar, ATLAS_CUR_LINES, ATLAS_LOOT_BOSS_LINES, 15);
	-- Make note of how far in the scroll frame we are
	for line = 1, ATLAS_NUM_LINES do
		lineplusoffset = line + FauxScrollFrame_GetOffset(AtlasScrollBar);
		local bossLine = _G["AtlasBossLine" .. line]
		if ( lineplusoffset <= ATLAS_CUR_LINES ) then
			local loot = _G["AtlasBossLine" .. line .. "_Loot"]
			local selected = _G["AtlasBossLine" .. line .. "_Selected"]
			_G["AtlasBossLine" .. line .. "_Text"]:SetText(ATLAS_SCROLL_LIST[lineplusoffset]);
			if ( AtlasLootItemsFrame.activeBoss == lineplusoffset ) then
				bossLine:Enable();
				loot:Hide();
				selected:Show();
			elseif ( (AtlasLootBossButtons[zoneID] and AtlasLootBossButtons[zoneID][lineplusoffset] and AtlasLootBossButtons[zoneID][lineplusoffset] ~= "") ) then
				bossLine:Enable();
				loot:Show();
				selected:Hide();
			elseif ( (AtlasLootWBBossButtons[zoneID] and AtlasLootWBBossButtons[zoneID][lineplusoffset] and AtlasLootWBBossButtons[zoneID][lineplusoffset] ~= "") ) then
				bossLine:Enable();
				loot:Show();
				selected:Hide();
			elseif ( (AtlasLootBattlegrounds[zoneID] and AtlasLootBattlegrounds[zoneID][lineplusoffset] and AtlasLootBattlegrounds[zoneID][lineplusoffset] ~= "") ) then
				bossLine:Enable();
				loot:Show();
				selected:Hide();
			else
				bossLine:Disable();
				loot:Hide();
				selected:Hide();
			end
			bossLine.idnum = lineplusoffset;
			bossLine:Show();
		elseif ( bossLine ) then
			-- Hide lines that are not needed
			bossLine:Hide();
		end
	end
end

--[[
AtlasLoot_Refresh:
Replacement for Atlas_Refresh, required as the template for the boss buttons in Atlas is insufficient
Called whenever the state of Atlas changes
]]
function AtlasLoot_Refresh()
	-- Reset which loot page is 'current'
	AtlasLootItemsFrame.activeBoss = nil;
	-- Get map selection info from Atlas
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	local data = AtlasMaps;
	local base = {};
	-- Get boss name information
	for k,v in pairs(data[zoneID]) do
		base[k] = v;
	end
	-- Display the newly selected texture
	AtlasMap:ClearAllPoints();
	AtlasMap:SetWidth(512);
	AtlasMap:SetHeight(512);
	AtlasMap:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
	local builtIn = AtlasMap:SetTexture("Interface\\AddOns\\Atlas\\Images\\Maps\\"..zoneID);
	-- If texture was not found in the core Atlas mod, check plugins
	if ( not builtIn ) then
		for k,v in pairs(ATLAS_PLUGINS) do
			if ( AtlasMap:SetTexture("Interface\\AddOns\\"..v.."\\Images\\"..zoneID) ) then
				break;
			end
		end
	end
	-- Setup info panel above boss listing
	local tName = base.ZoneName[1];
	if ( AtlasOptions.AtlasAcronyms and base.Acronym ) then
		local _RED = "|cffcc6666";
		tName = tName.._RED.." ["..base.Acronym.."]";
	end
	AtlasText_ZoneName_Text:SetText(tName);
	local tLoc = "";
	local tLR = "";
	local tML = "";
	local tPL = "";
	if ( base.Location[1] ) then
		tLoc = ATLAS_STRING_LOCATION..": "..base.Location[1];
	end
	if ( base.LevelRange ) then
		tLR = ATLAS_STRING_LEVELRANGE..": "..base.LevelRange;
	end
	if ( base.MinLevel ) then
		tML = ATLAS_STRING_MINLEVEL..": "..base.MinLevel;
	end
	if ( base.PlayerLimit ) then
		tPL = ATLAS_STRING_PLAYERLIMIT..": "..base.PlayerLimit;
	end
	AtlasText_Location_Text:SetText(tLoc);
	AtlasText_LevelRange_Text:SetText(tLR);
	AtlasText_MinLevel_Text:SetText(tML);
	AtlasText_PlayerLimit_Text:SetText(tPL);
	Atlastextbase = base;
	-- Get the size of the Atlas text to append stuff to the bottom.  Looks for empty lines
	local i = 1;
	local j = 2;
	while ( (Atlastextbase[i] and Atlastextbase[i] ~= "") or (Atlastextbase[j] and Atlastextbase[j] ~= "")) do
		i = i + 1;
		j = i + 1;
	end
	-- Hide any Atlas objects lurking around that have now been replaced
	for i = 1,ATLAS_CUR_LINES do
		if ( _G["AtlasEntry"..i] ) then
			_G["AtlasEntry"..i]:Hide();
		end
	end
	ATLAS_DATA = Atlastextbase;
	ATLAS_SEARCH_METHOD = data.Search;
	-- Deal with Atlas's search function
	if ( data.Search == nil ) then
		ATLAS_SEARCH_METHOD = AtlasSimpleSearch;
	end
	if ( data.Search ~= false ) then
		AtlasSearchEditBox:Show();
		AtlasNoSearch:Hide();
	else
		AtlasSearchEditBox:Hide();
		AtlasNoSearch:Show();
		ATLAS_SEARCH_METHOD = nil;
	end
	-- populate the scroll frame entries list, the update func will do the rest
	Atlas_Search("");
	AtlasSearchEditBox:SetText("");
	AtlasSearchEditBox:ClearFocus();
	-- create and align any new entry buttons that we need
	for i = 1,ATLAS_CUR_LINES do
		local f;
		if ( not _G["AtlasBossLine"..i] ) then
			f = CreateFrame("Button", "AtlasBossLine"..i, AtlasFrame, "AtlasLootNewBossLineTemplate");
			f:SetFrameStrata("HIGH");
			if ( i == 1 ) then
				f:SetPoint("TOPLEFT", "AtlasScrollBar", "TOPLEFT", 16, -3);
			else
				f:SetPoint("TOPLEFT", "AtlasBossLine"..(i-1), "BOTTOMLEFT");
			end
		else
			_G["AtlasBossLine"..i.."_Loot"]:Hide();
			_G["AtlasBossLine"..i.."_Selected"]:Hide();
		end
	end
	-- Hide the loot frame now that a pristine Atlas instance is created
	AtlasLootItemsFrame:Hide();
	Atlas_Search("");
	-- Make sure the scroll bar is correctly offset
	AtlasLoot_AtlasScrollBar_Update();
	-- see if we should display the entrance/instance button or not, and decide what it should say
	local matchFound = {nil};
	local sayEntrance = nil;
	for k,v in pairs(Atlas_EntToInstMatches) do
		if ( k == zoneID ) then
			matchFound = v;
			sayEntrance = false;
		end
	end
	if ( not matchFound[1] ) then
		for k,v in pairs(Atlas_InstToEntMatches) do
			if ( k == zoneID ) then
				matchFound = v;
				sayEntrance = true;
			end
		end
	end
	-- set the button's text, populate the dropdown menu, and show or hide the button
	if ( matchFound[1] ) then
		ATLAS_INST_ENT_DROPDOWN = {};
		for k,v in pairs(matchFound) do
			table.insert(ATLAS_INST_ENT_DROPDOWN, v);
		end
		table.sort(ATLAS_INST_ENT_DROPDOWN, AtlasSwitchDD_Sort);
		if ( sayEntrance ) then
			AtlasSwitchButton:SetText(ATLAS_ENTRANCE_BUTTON);
		else
			AtlasSwitchButton:SetText(ATLAS_INSTANCE_BUTTON);
		end
		AtlasSwitchButton:Show();
		UIDropDownMenu_Initialize(AtlasSwitchDD, AtlasSwitchDD_OnLoad);
	else
		AtlasSwitchButton:Hide();
	end
	if ( TitanPanelButton_UpdateButton ) then
		TitanPanelButton_UpdateButton("Atlas");
	end
end

--[[
AtlasLoot_Atlas_OnShow:
Hooks Atlas_OnShow() to add extra setup routines that AtlasLoot needs for
integration purposes.
]]
function AtlasLoot_Atlas_OnShow()
	Atlas_Refresh();
	-- We don't want Atlas and the Loot Browser open at the same time, so the Loot Browser is close
	if ( AtlasLootDefaultFrame ) then
		AtlasLootDefaultFrame:Hide();
		AtlasLoot_SetupForAtlas();
	end
	-- Call the Atlas function
	Hooked_Atlas_OnShow();
	-- If we were looking at a loot table earlier in the session, it is still
	-- saved on the item frame, so restore it in Atlas
	if ( AtlasLootItemsFrame.activeBoss ) then
		AtlasLootItemsFrame:Show();
	else
		-- If no loot table is selected, set up icons next to boss names
		for i = 1,ATLAS_CUR_LINES do
			if ( _G["AtlasEntry"..i.."_Selected"] and _G["AtlasEntry"..i.."_Selected"]:IsVisible() ) then
				_G["AtlasEntry"..i.."_Loot"]:Show();
				_G["AtlasEntry"..i.."_Selected"]:Hide();
			end
		end
	end
	-- Consult the saved variable table to see whether to show the bottom panel
	if ( AtlasLootCharDB.HidePanel == true ) then
		AtlasLootPanel:Hide();
	else
		AtlasLootPanel:Show();
	end
end

--[[
AtlasLoot_Toggle:
Simple function to toggle the visibility of the AtlasLoot frame.
]]
function AtlasLoot_Toggle()
	if ( AtlasLootDefaultFrame:IsVisible() ) then
		HideUIPanel(AtlasLootDefaultFrame);
	else
		ShowUIPanel(AtlasLootDefaultFrame);
	end
end

--[[
AtlasLootBoss_OnClick:
Invoked whenever a boss line in Atlas is clicked
Shows a loot page if one is associated with the button
]]
function AtlasLootBoss_OnClick(name)
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
	local id = this.idnum;
	-- If the loot table was already shown and boss clicked again, hide the loot table and fix boss list icons
	if ( _G[name.."_Selected"]:IsVisible() ) then
		_G[name.."_Selected"]:Hide();
		_G[name.."_Loot"]:Show();
		AtlasLootItemsFrame:Hide();
		AtlasLootItemsFrame.activeBoss = nil;
	else
		-- If an loot table is associated with the button, show it.  Note multiple tables need to be checked due to the database structure
		if ( AtlasLootBossButtons[zoneID] and AtlasLootBossButtons[zoneID][id] and AtlasLootBossButtons[zoneID][id] ~= "" ) then
			if ( AtlasLoot_IsLootTableAvailable(AtlasLootBossButtons[zoneID][id]) ) then
				_G[name.."_Selected"]:Show();
				_G[name.."_Loot"]:Hide();
				local _,_,boss = string.find(_G[name.."_Text"]:GetText(), "|c%x%x%x%x%x%x%x%x%s*[%dX']*[%) ]*(.*[^%,])[%,]?$");
				AtlasLoot_ShowBossLoot(AtlasLootBossButtons[zoneID][id], boss, AtlasFrame);
				AtlasLootItemsFrame.activeBoss = id;
				AtlasLoot_AtlasScrollBar_Update();
				AtlasLootCharDB.LastBoss = AtlasLootBossButtons[zoneID][id]
				 -- dont show navigation buttons if its not rep or set
				local match = string.find(boss, AL["Reputation"]) or string.find(boss, AL["Set"])
				if ( not match ) then
					AtlasLootItemsFrame_BACK:Hide();
					AtlasLootItemsFrame_NEXT:Hide();
					AtlasLootItemsFrame_PREV:Hide();
				end
			end
		elseif ( AtlasLootWBBossButtons[zoneID] and AtlasLootWBBossButtons[zoneID][id] and AtlasLootWBBossButtons[zoneID][id] ~= "" ) then
			if ( AtlasLoot_IsLootTableAvailable(AtlasLootWBBossButtons[zoneID][id]) ) then
				_G[name.."_Selected"]:Show();
				_G[name.."_Loot"]:Hide();
				local _,_,boss = string.find(_G[name.."_Text"]:GetText(), "|c%x%x%x%x%x%x%x%x%s*[%dX]*[%) ]*(.*[^%,])[%,]?$");
				AtlasLoot_ShowBossLoot(AtlasLootWBBossButtons[zoneID][id], boss, AtlasFrame);
				AtlasLootItemsFrame.activeBoss = id;
				AtlasLoot_AtlasScrollBar_Update();
				AtlasLootCharDB.LastBoss = AtlasLootWBBossButtons[zoneID][id]
				-- dont show navigation buttons
				AtlasLootItemsFrame_BACK:Hide();
				AtlasLootItemsFrame_NEXT:Hide();
				AtlasLootItemsFrame_PREV:Hide();
			end
		elseif ( AtlasLootBattlegrounds[zoneID] and AtlasLootBattlegrounds[zoneID][id] and AtlasLootBattlegrounds[zoneID][id] ~= "" ) then
			if ( AtlasLoot_IsLootTableAvailable(AtlasLootBattlegrounds[zoneID][id]) ) then
				_G[name.."_Selected"]:Show();
				_G[name.."_Loot"]:Hide();
				local _,_,boss = string.find(_G[name.."_Text"]:GetText(), "|c%x%x%x%x%x%x%x%x%s*[%wX]*[%) ]*(.*[^%,])[%,]?$");
				AtlasLoot_ShowBossLoot(AtlasLootBattlegrounds[zoneID][id], boss, AtlasFrame);
				AtlasLootItemsFrame.activeBoss = id;
				AtlasLoot_AtlasScrollBar_Update();
				AtlasLootCharDB.LastBoss = AtlasLootBattlegrounds[zoneID][id]
			end
		end
	end
	-- This has been invoked from Atlas, so we remove any claim external mods have on the loot table
	AtlasLootItemsFrame.externalBoss = nil;
	-- Hide the AtlasQuest frame if present so that the AtlasLoot items frame is not stuck under it
	if ( AtlasQuestInsideFrame ) then
		HideUIPanel(AtlasQuestInsideFrame);
	end
end

--[[
AtlasLoot_ShowMenu:
Legacy function used in Cosmos integration to open the loot browser
]]
function AtlasLoot_ShowMenu()
	AtlasLootDefaultFrame:Show();
end

--[[
AtlasLootOptions_SafeLinksToggle:
Toggles SafeLinks. Items uncached will be linked as their names.
]]
function AtlasLootOptions_SafeLinksToggle()
	if ( AtlasLootCharDB.SafeLinks ) then
		AtlasLootCharDB.SafeLinks = false;
	else
		AtlasLootCharDB.SafeLinks = true;
		AtlasLootCharDB.AllLinks = false;
	end
	AtlasLootOptions_Init();
end

--[[
AtlasLootOptions_AllLinksToggle:
Toggles AllLinks. All items will be linked.
]]
function AtlasLootOptions_AllLinksToggle()
	if ( AtlasLootCharDB.AllLinks ) then
		AtlasLootCharDB.AllLinks = false;
	else
		AtlasLootCharDB.AllLinks = true;
		AtlasLootCharDB.SafeLinks = false;
	end
	AtlasLootOptions_Init();
end

--[[
AtlasLootOptions_DefaultTTToggle:
Toggles DefaultTooltips. Uses default tooltips.
]]
function AtlasLootOptions_DefaultTTToggle()
	AtlasLootCharDB.DefaultTT = true;
	AtlasLootCharDB.LootlinkTT = false;
	AtlasLootCharDB.ItemSyncTT = false;
	AtlasLootOptions_Init();
end

--[[
AtlasLootOptions_LootlinkTTToggle:
Toggles Lootlink tooltips instead of the default ones.
]]
function AtlasLootOptions_LootlinkTTToggle()
	AtlasLootCharDB.DefaultTT = false;
	AtlasLootCharDB.LootlinkTT = true;
	AtlasLootCharDB.ItemSyncTT = false;
	AtlasLootOptions_Init();
end

--[[
AtlasLootOptions_ItemSyncTTToggle:
Toggles ItemSync tooltips instead of the default ones.
]]
function AtlasLootOptions_ItemSyncTTToggle()
	AtlasLootCharDB.DefaultTT = false;
	AtlasLootCharDB.LootlinkTT = false;
	AtlasLootCharDB.ItemSyncTT = true;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_ShowSourceToggle()
	if ( AtlasLootCharDB.ShowSource ) then
		AtlasLootCharDB.ShowSource = false;
	else
		AtlasLootCharDB.ShowSource = true;
	end
	AtlasLootOptions_Init();
end

function AtlasLootOptions_WishlistGroupedByDungeonToggle()
	if ( AtlasLootCharDB.WishlistGroupedByDungeon ) then
		AtlasLootCharDB.WishlistGroupedByDungeon = false;
	else
		AtlasLootCharDB.WishlistGroupedByDungeon = true;
	end
	AtlasLootOptions_Init();
	AtlasLoot_WishList = AtlasLoot_CategorizeWishList(AtlasLootCharDB["WishList"]);
	local dataID = AtlasLootItemsFrame.refresh[1];

	if ( dataID == 'WishList' ) then
		AtlasLoot_ShowWishList();
	end
end

--[[
AtlasLootOptions_EquipCompareToggle:
Toggles EquipCompare. Adds a tooltip with the equipped item (if it's the case) next to the default one.
]]
function AtlasLootOptions_EquipCompareToggle()
	if ( AtlasLootCharDB.EquipCompare ) then
		AtlasLootCharDB.EquipCompare = false;
		if ( IsAddOnLoaded("EquipCompare") ) then
			EquipCompare_UnregisterTooltip(AtlasLootTooltip);
			EquipCompare_UnregisterTooltip(AtlasLootTooltip2);
		end
		if ( IsAddOnLoaded("EQCompare") ) then
			EQCompare:UnRegisterTooltip(AtlasLootTooltip);
			EQCompare:UnRegisterTooltip(AtlasLootTooltip2);
		end
	else
		AtlasLootCharDB.EquipCompare = true;
		if ( IsAddOnLoaded("EquipCompare") ) then
			EquipCompare_RegisterTooltip(AtlasLootTooltip);
			EquipCompare_RegisterTooltip(AtlasLootTooltip2);
		end
		if ( IsAddOnLoaded("EQCompare") ) then
			EQCompare:RegisterTooltip(AtlasLootTooltip);
			EQCompare:RegisterTooltip(AtlasLootTooltip2);
		end
	end
	AtlasLootOptions_Init();
end

--[[
AtlasLootOptions_OpaqueToggle:
Toggles opacity of the items frame.
]]
function AtlasLootOptions_OpaqueToggle()
	AtlasLootCharDB.Opaque = AtlasLootOptionsFrameOpaque:GetChecked();
	if ( AtlasLootCharDB.Opaque ) then
		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 1);
	else
		AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0.65);
	end
	AtlasLootOptions_Init();
end

--[[
AtlasLootOptions_ItemIDToggle:
Toggles items ID.
]]
function AtlasLootOptions_ItemIDToggle()
	if ( AtlasLootCharDB.ItemIDs ) then
		AtlasLootCharDB.ItemIDs = false;
	else
		AtlasLootCharDB.ItemIDs = true;
	end
	AtlasLootOptions_Init();
end

--[[
AtlasLootOptions_ItemSpam:
Toggles item query spam.
]]
function AtlasLootOptions_ItemSpam()
	if ( AtlasLootCharDB.ItemSpam ) then
		AtlasLootCharDB.ItemSpam = false;
	else
		AtlasLootCharDB.ItemSpam = true;
	end
	AtlasLootOptions_Init();
end

--[[
AtlasLootOptions_Toggle:
Toggle on/off the options window
]]
function AtlasLootOptions_Toggle()
	if ( AtlasLootOptionsFrame:IsVisible() ) then
		-- Hide the options frame if already shown
		AtlasLootOptionsFrame:Hide();
	else
		AtlasLootOptionsFrame:Show();
		-- Workaround for a weird quirk where tooltip settings so not immediately take effect
		if ( AtlasLootCharDB.DefaultTT == true ) then
			AtlasLootOptions_DefaultTTToggle();
		elseif ( AtlasLootCharDB.LootlinkTT == true ) then
			AtlasLootOptions_LootlinkTTToggle();
		elseif ( AtlasLootCharDB.ItemSyncTT == true ) then
			AtlasLootOptions_ItemSyncTTToggle();
		end
	end
end

function AtlasLootItemsFrame_OnUpdate()
	if ( not this.refreshTime ) then
		return
	end
	this.refreshTime = (this.refreshTime or refreshTimeout) - arg1
	local done = true
	for item in pairs(this.queue) do
		if not GetItemInfo(item) then
			done = false
		end
	end
	if ( done or this.refreshTime <= 0 ) then
		this.refreshTime = nil
		for k in pairs(this.queue) do
			this.queue[k] = nil
		end
		if ( this.refresh and this.refresh[1] and this.refresh[2] and this.refresh[3] and this.refresh[4] ) then
			AtlasLoot_ShowItemsFrame(this.refresh[1], this.refresh[2], this.refresh[3], this.refresh[4])
		end
	end
end

--[[
AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame):
dataID - Name of the loot table
dataSource - Table in the database where the loot table is stored
boss - Text string to use as a title for the loot page
pFrame - Data structure describing how and where to anchor the item frame (more details, see the function AtlasLoot_SetItemInfoFrame)
This fuction is not normally called directly, it is usually invoked by AtlasLoot_ShowBossLoot.
It is the workhorse of the mod and allows the loot tables to be displayed any way anywhere in any mod.
]]
function AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame)
	AtlasLootItemsFrame.refreshTime = nil
	if ( AtlasLootItemsFrameContainer:IsShown() and AtlasLootItemsFrame.refresh and dataID ~= AtlasLootItemsFrame.refresh[1] ) then
		AtlasLootItemsFrameContainer:Hide()
	end
	-- Set up local variables needed for GetItemInfo, etc
	local iconFrame, nameFrame, extraFrame, itemButton;
	local text, extra;
	local wlPage, wlPageMax = 1, 1;
	local isItem, isEnchant, isSpell;
	local spellName, spellIcon;
	if ( dataID == "SearchResult" and dataID == "WishList" ) then
		AtlasLoot_IsLootTableAvailable(dataID);
	end
	-- If the data source has not been passed, throw up a debugging statement
	if ( dataSource == nil ) then
		DEFAULT_CHAT_FRAME:AddMessage("No dataSource!");
	end
	-- If the loot table name has not been passed, throw up a debugging statement
	if ( dataID == nil ) then
		DEFAULT_CHAT_FRAME:AddMessage("No dataID!");
	end
	local dataSource_backup = dataSource;
	if ( dataSource ~= "dummy" ) then
		if ( dataID == "SearchResult" or dataID == "WishList" ) then
			dataSource = {};
			-- Match the page number to display
			wlPage = tonumber(string.sub(dataSource_backup, string.find(dataSource_backup, "%d"), string.len(dataSource_backup)));
			-- Aquiring items of the page
			if ( dataID == "SearchResult" ) then
				dataSource[dataID], wlPageMax = AtlasLoot:GetSearchResultPage(wlPage);
			elseif ( dataID == "WishList" ) then
				dataSource[dataID], wlPageMax = AtlasLoot_GetWishListPage(wlPage);
			end
			-- Make page number reasonable
			if ( wlPage < 1 ) then wlPage = 1 end
			if ( wlPage > wlPageMax ) then wlPage = wlPageMax end
		else
			dataSource = AtlasLoot_Data[dataSource_backup];
		end
	end
	-- Get AtlasQuest out of the way
	if ( AtlasQuestInsideFrame ) then
		HideUIPanel(AtlasQuestInsideFrame);
	end
	-- Ditch the Quicklook selector
	AtlasLoot_QuickLooks:Hide();
	AtlasLootQuickLooksButton:Hide();
	AtlasLootServerQueryButton:Hide();
	-- Hide the menu objects.  These are not required for a loot table
	for i = 1, 30, 1 do
		_G["AtlasLootMenuItem_"..i]:Hide();
	end
	-- Store data about the state of the items frame to allow minor tweaks or a recall of the current loot page
	AtlasLootItemsFrame.refresh = { dataID, dataSource_backup, boss, pFrame };
	-- Escape out of this function if creating a menu, this function only handles loot tables.
	-- Inserting escapes in this way allows consistant calling of data whether it is a loot table or a menu.
	if ( AtlasLoot_MenuList[dataID] ) then
		_G[AtlasLoot_MenuList[dataID]]()
	else
		-- Iterate through each item object and set its properties
		for i = 1, 30, 1 do
			-- Check for a valid object (that it exists, and that it has a name)
			if ( dataSource[dataID][i] and dataSource[dataID][i][3] ~= "" ) then
				if ( string.sub(dataSource[dataID][i][1], 1, 1) == "s" ) then
					isItem = false;
					isEnchant = false;
					isSpell = true;
				elseif ( string.sub(dataSource[dataID][i][1], 1, 1) == "e" ) then
					isItem = false;
					isEnchant = true;
					isSpell = false;
				else
					isItem = true;
					isEnchant = false;
					isSpell = false;
				end
				if ( isItem ) then
					local itemID = tonumber(dataSource[dataID][i][1])
					local itemName, _, itemQuality = GetItemInfo(itemID);
					-- If the client has the name of the item in cache, use that instead.
					-- This is poor man's localisation, English is replaced be whatever is needed
					if ( itemName ) then
						local _, _, _, itemColor = GetItemQualityColor(itemQuality);
						text = itemColor..itemName;
					else
						if ( itemID and itemID ~= 0 ) then
							GameTooltip:SetHyperlink("item:"..itemID)
							AtlasLootItemsFrame.refreshTime = refreshTimeout
							AtlasLootItemsFrame.queue[itemID] = true
						end
						text = AtlasLoot_FixText(dataSource[dataID][i][3]);
					end
					_G["AtlasLootItem_"..i.."_Quantity"]:SetText("")
				elseif ( isEnchant ) then
					local spellID = tonumber(string.sub(dataSource[dataID][i][1], 2))
					local craftItem = tonumber(GetSpellInfoAtlasLootDB["enchants"][spellID]["item"])
					if ( SpellInfo ) then
						spellName = SpellInfo(spellID)
					else
						if ( spellID and spellID ~= 0 ) then
							GameTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
							GameTooltip:SetHyperlink("enchant:"..spellID)
							spellName = GameTooltipTextLeft1:GetText()
							GameTooltip:Hide()
						end
						if ( not (spellName and spellName ~= "") ) then
							spellName = GetSpellInfoAtlasLootDB["enchants"][spellID]["name"]
						end
					end
					spellIcon = dataSource[dataID][i][2]
					if ( craftItem ) then
						local color, quality
						text, _, quality = GetItemInfo(craftItem)
						if ( not text ) then
							if ( craftItem and craftItem ~= 0 ) then
								GameTooltip:SetHyperlink("item:"..craftItem)
								AtlasLootItemsFrame.refreshTime = refreshTimeout
								AtlasLootItemsFrame.queue[craftItem] = true
							end
							text = AtlasLoot_FixText(spellName);
						end
						if ( quality ) then
							_, _, _, color = GetItemQualityColor(quality)
							text = color..(text or "")
						end
					else
						text = spellName
					end
					_G["AtlasLootItem_"..i.."_Quantity"]:SetText("")
				elseif ( isSpell ) then
					local spellID = tonumber(string.sub(dataSource[dataID][i][1], 2))
					local craftItem = tonumber(GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftItem"])
					if ( SpellInfo ) then
						spellName = SpellInfo(spellID)
					else
						spellName = GetSpellInfoAtlasLootDB["craftspells"][spellID]["name"]
					end
					spellIcon = dataSource[dataID][i][2]
					if ( craftItem ) then
						local color, quality
						text, _, quality = GetItemInfo(craftItem)
						if ( not text ) then
							if ( craftItem ~= 0 ) then
								GameTooltip:SetHyperlink("item:"..craftItem)
								text = AtlasLoot_FixText(spellName);
								AtlasLootItemsFrame.refreshTime = refreshTimeout
								AtlasLootItemsFrame.queue[craftItem] = true
							end
						end
						if ( quality ) then
							_, _, _, color = GetItemQualityColor(quality)
							text = color..(text or "")
						end
					else
						text = spellName
					end
					local qtyMin = GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftQuantityMin"];
					local qtyMax = GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftQuantityMax"];
					if ( qtyMin and qtyMin ~= "" ) then
						if ( qtyMax and qtyMax ~= "" ) then
							_G["AtlasLootItem_"..i.."_Quantity"]:SetText(qtyMin.. "-"..qtyMax)
						else
							_G["AtlasLootItem_"..i.."_Quantity"]:SetText(qtyMin)
						end
					else
						_G["AtlasLootItem_"..i.."_Quantity"]:SetText("")
					end
				end
				-- This is a valid QuickLook, so show the UI objects
				if ( dataID ~= "SearchResult" and dataID ~= "WishList" ) then
					AtlasLoot_QuickLooks:Show();
					AtlasLootQuickLooksButton:Show();
					AtlasLootServerQueryButton:Hide();
				end
				-- Insert the item description
				extra = dataSource[dataID][i][4];
				extra = AtlasLoot_FixText(extra);
				-- Use shortcuts for easier reference to parts of the item button
				itemButton = _G["AtlasLootItem_"..i];
				iconFrame  = _G["AtlasLootItem_"..i.."_Icon"];
				nameFrame  = _G["AtlasLootItem_"..i.."_Name"];
				extraFrame = _G["AtlasLootItem_"..i.."_Extra"];
				local border = _G["AtlasLootItem_"..i.."Border"]
				local iconData = dataSource[dataID][i][2]
				-- If there is no data on the texture an item should have, show a big red question mark
				if ( strsub(iconData, 1, 5) == "CLASS" ) then
					iconFrame:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\"..strsub(iconData, 6))
				elseif ( isItem and type(dataSource[dataID][i][1]) == "number" ) then
					local _, _, _, _, _, _, _, _, texture = GetItemInfo(dataSource[dataID][i][1])
					if ( not texture and type(iconData) == "string" ) then
						texture = "Interface\\Icons\\"..iconData
					end
					iconFrame:SetTexture(texture);
				elseif ( not isItem and spellIcon ) then
					if ( type(iconData) == "number" ) then
						local _, _, _, _, _, _, _, _, texture = GetItemInfo(iconData)
						iconFrame:SetTexture(texture);
					elseif ( type(iconData) == "string" ) then
						iconFrame:SetTexture("Interface\\Icons\\"..iconData);
					else
						iconFrame:SetTexture(spellIcon);
					end
				else
					iconFrame:SetTexture("Interface\\Icons\\"..iconData);
				end
				if ( iconFrame:GetTexture() == nil ) then
					iconFrame:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
				end
				-- Set the name and description of the item
				nameFrame:SetText(text);
				extraFrame:SetText(extra);
				extraFrame:Show();
				for j = 1, 5 do
					_G["AtlasLootItem_"..i.."_PriceText"..j]:Hide();
					_G["AtlasLootItem_"..i.."_PriceIcon"..j]:Hide();
				end
				local index = 1
				for j = 6, 14, 2 do
					local pricetext = _G["AtlasLootItem_"..i.."_PriceText"..index]
					local priceicon = _G["AtlasLootItem_"..i.."_PriceIcon"..index]
					if ( dataSource[dataID][i][j] and dataSource[dataID][i][j] ~= "" ) then
						pricetext:SetText(dataSource[dataID][i][j])
						priceicon:SetTexture(AtlasLoot_FixText(dataSource[dataID][i][j + 1]))
						pricetext:Show()
						priceicon:Show()
					end
					index = index + 1
				end
				-- Set prices for items, up to 5 different currencies can be used in combination
				if ( (dataID == "SearchResult" or dataID == "WishList") and dataSource[dataID][i][5] ) then
					local _, _, wishDataID, wishDataSource = strfind(dataSource[dataID][i][5], "(.+)|(.+)")
					if ( wishDataSource == "AtlasLootRepItems" ) then
						if ( wishDataID and AtlasLoot_IsLootTableAvailable(wishDataID) ) then
							for _, v in ipairs(AtlasLoot_Data[wishDataSource][wishDataID]) do
								if ( dataSource[dataID][i][1] == v[1] ) then
									index = 1
									for j = 6, 14, 2 do
										local pricetext = _G["AtlasLootItem_"..i.."_PriceText"..index]
										local priceicon = _G["AtlasLootItem_"..i.."_PriceIcon"..index]
										if ( v[j] and v[j] ~= "" ) then
											pricetext:SetText(v[j])
											priceicon:SetTexture(AtlasLoot_FixText(v[j + 1]))
											pricetext:Show()
											priceicon:Show()
										end
										index = index + 1
									end
									break;
								end
							end
						end
					end

					if ( wishDataSource == "AtlasLootItems" and AtlasLootCharDB.WishlistGroupedByDungeon ) then
						-- Set boss
						if ( wishDataID and AtlasLoot_IsLootTableAvailable(wishDataID) ) then
							for _, v in ipairs(AtlasLoot_Data[wishDataSource][wishDataID]) do
								if ( dataSource[dataID][i][1] == v[1] ) then
									local boss = AtlasLoot_GetWishListSubheadingBoss(wishDataID)

									if ( boss ) then
										extraFrame:SetText(extra .. " - "..boss)
									end
								end
							end
						end
					end
				end

				-- For convenience, we store information about the objects in the objects so that it can be easily accessed later
				itemButton.itemID = dataSource[dataID][i][1];
				itemButton.itemIDName = dataSource[dataID][i][3];
				itemButton.itemIDExtra = dataSource[dataID][i][4];
				itemButton.container = dataSource[dataID][i][16]
				if ( type(itemButton.container) == "table" ) then
					border:Show()
					for row = 1, getn(itemButton.container) do
						for item = 1, getn(itemButton.container[row]) do
							AtlasLoot_CacheItem(itemButton.container[row][item][1])
						end
					end
				else
					border:Hide()
				end

				if ( isItem ) then
					itemButton.dressingroomID = dataSource[dataID][i][1];
				elseif ( isEnchant ) then
					local spellID = tonumber(string.sub(dataSource[dataID][i][1], 2));
					local craftItem = GetSpellInfoAtlasLootDB["enchants"][spellID]["item"]
					if ( craftItem and craftItem ~= "" ) then
						itemButton.dressingroomID = craftItem;
					else
						itemButton.dressingroomID = spellID;
					end
				elseif ( isSpell ) then
					local spellID = tonumber(string.sub(dataSource[dataID][i][1], 2));
					local craftItem = GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftItem"]
					itemButton.dressingroomID = craftItem;
					local reagents = GetSpellInfoAtlasLootDB["craftspells"][spellID]["reagents"]
					if ( type(reagents) == "table" ) then
						for j = 1, table.getn(reagents) do
							local reagent = GetSpellInfoAtlasLootDB["craftspells"][spellID]["reagents"][j]
							if ( not GetItemInfo(reagent[1]) ) then
								GameTooltip:SetHyperlink("item:"..reagent[1]);
							end
						end
					end
				end
				itemButton.droprate = nil;
				if ( dataID == "SearchResult" or dataID == "WishList" ) then
					itemButton.sourcePage = dataSource[dataID][i][5];
				else
					local droprate = dataSource[dataID][i][5];
					if ( droprate and string.find(droprate, "%%") ) then
						itemButton.droprate = droprate
					end
				end
				itemButton:Show();
				if ( GetMouseFocus() == itemButton ) then
					itemButton:Hide()
					itemButton:Show()
				end
			else
				_G["AtlasLootItem_"..i]:Hide();
			end
		end
		-- Hide navigation buttons by default, only show what we need
		AtlasLootItemsFrame_BACK:Hide();
		AtlasLootItemsFrame_NEXT:Hide();
		AtlasLootItemsFrame_PREV:Hide();
		AtlasLoot_BossName:SetText(boss);
		-- Consult the button registry to determine what nav buttons are required
		if ( dataID == "SearchResult" or dataID == "WishList" ) then
			if ( wlPage < wlPageMax ) then
				AtlasLootItemsFrame_NEXT:Show();
				AtlasLootItemsFrame_NEXT.lootpage = dataID.."Page"..(wlPage + 1);
			end
			if ( wlPage > 1 ) then
				AtlasLootItemsFrame_PREV:Show();
				AtlasLootItemsFrame_PREV.lootpage = dataID.."Page"..(wlPage - 1);
			end
		elseif ( AtlasLoot_ButtonRegistry[dataID] ) then
			local tablebase = AtlasLoot_ButtonRegistry[dataID];
			AtlasLoot_BossName:SetText(tablebase.Title);
			if ( tablebase.Next_Page ) then
				AtlasLootItemsFrame_NEXT:Show();
				AtlasLootItemsFrame_NEXT.lootpage = tablebase.Next_Page;
				if ( AtlasLoot_ButtonRegistry[tablebase.Next_Page] ) then
					AtlasLootItemsFrame_NEXT.title = AtlasLoot_ButtonRegistry[tablebase.Next_Page].Title;
				end
			end
			if ( tablebase.Prev_Page ) then
				AtlasLootItemsFrame_PREV:Show();
				AtlasLootItemsFrame_PREV.lootpage = tablebase.Prev_Page;
				if ( AtlasLoot_ButtonRegistry[tablebase.Prev_Page] ) then
					AtlasLootItemsFrame_PREV.title = AtlasLoot_ButtonRegistry[tablebase.Prev_Page].Title;
				end
			end
			if ( tablebase.Back_Page ) then
				AtlasLootItemsFrame_BACK:Show();
				AtlasLootItemsFrame_BACK.lootpage = tablebase.Back_Page;
				if ( AtlasLoot_ButtonRegistry[tablebase.Back_Page] ) then
					AtlasLootItemsFrame_BACK.title = AtlasLoot_ButtonRegistry[tablebase.Back_Page].Title;
				end
				-- Hide navigation buttons if we click Quicklooks in Atlas
				if ( AtlasFrame and AtlasFrame:IsVisible() ) then
					local sourceKey
					for k, v in pairs(AtlasLoot_Data) do
						if ( v == dataSource ) then
							sourceKey = k
						end
					end
					if ( sourceKey == "AtlasLootItems" ) then
						AtlasLootItemsFrame_BACK:Hide()
						AtlasLootItemsFrame_NEXT:Hide()
						AtlasLootItemsFrame_PREV:Hide()
					end
					for i = 1, 4 do
						if ( AtlasLootCharDB["QuickLooks"][i] and dataID == AtlasLootCharDB["QuickLooks"][i][1] ) then
							AtlasLootItemsFrame_BACK:Hide();
							AtlasLootItemsFrame_NEXT:Hide();
							AtlasLootItemsFrame_PREV:Hide();
						end
					end
				end
			end
		end
	end
	-- For Alphamap and Atlas integration, show a 'close' button to hide the loot table and restore the map view
    AtlasLootItemsFrame_CloseButton:Hide();
	if ( AtlasFrame and AtlasFrame:IsShown() or AlphaMapAlphaMapFrame and AlphaMapAlphaMapFrame:IsShown() ) then
        AtlasLootItemsFrame_CloseButton:Show();
    end
	local subMenu = nil
	local bossName = ""
	for k in pairs(AtlasLoot_HewdropDown_SubTables) do
		if ( subMenu ) then
			break
		end
		for _, n in pairs(AtlasLoot_HewdropDown_SubTables[k]) do
			if ( n[2] == dataID ) then
				subMenu = AtlasLoot_HewdropDown_SubTables[k]
				bossName = n[1]
				break
			end
		end
	end
	if ( subMenu ) then
		AtlasLoot_HewdropSubMenuRegister(subMenu)
		AtlasLootDefaultFrame_SubMenu:Enable()
		AtlasLootDefaultFrame_SelectedTable:SetText(bossName)
		AtlasLootDefaultFrame_SelectedTable:Show()
	else
		AtlasLootDefaultFrame_SubMenu:Disable()
		AtlasLootDefaultFrame_SelectedTable:Hide()
	end
	-- Anchor the item frame where it is supposed to be
    if ( pFrame ) then
		-- If a pFrame is specified, use it
		if ( pFrame == AtlasFrame and AtlasFrame ) then
			AtlasLootItemsFrame:ClearAllPoints();
			AtlasLootItemsFrame:SetParent(AtlasFrame);
			AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
		else
			AtlasLootItemsFrame:ClearAllPoints();
			AtlasLootItemsFrame:SetParent(pFrame[2]);
			AtlasLootItemsFrame:SetPoint(pFrame[1], pFrame[2], pFrame[3], pFrame[4], pFrame[5]);
		end
	elseif ( AtlasFrame ) then
		-- If no pFrame is specified and Atlas is installed, anchor in Atlas
		AtlasLootItemsFrame:ClearAllPoints();
		AtlasLootItemsFrame:SetParent(AtlasFrame);
		AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
	elseif ( AtlasLootDefaultFrame ) then
		AtlasLootItemsFrame:ClearAllPoints();
		AtlasLootItemsFrame:SetParent(AtlasLootDefaultFrame);
		AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasLootDefaultFrame", "TOPLEFT", 0, 0);
	end
	AtlasLootItemsFrame:Show();
end

--[[
AtlasLoot_HewdropClick(tablename, text, tabletype):
tablename - Name of the loot table in the database
text - Heading for the loot table
tabletype - Whether the tablename indexes an actual table or needs to generate a submenu
Called when a button in AtlasLoot_Hewdrop is clicked
]]
function AtlasLoot_HewdropClick(tablename, text, tabletype)
	-- AtlasLootCharDB.LastMenu = { tablename, text, tabletype }
	-- Definition of where I want the loot table to be shown
	AtlasLoot_AnchorPoint = Anchor_Default

	-- If the button clicked was linked to a loot table
	if ( tabletype == "Table" ) then
		-- Show the loot table
		AtlasLoot_ShowBossLoot(tablename, text, AtlasLoot_AnchorPoint);
		-- Save needed info for fuure re-display of the table
		AtlasLootCharDB.LastBoss = tablename;
		AtlasLootCharDB.LastBossText = text;
		-- Purge the text label for the submenu and disable the submenu
		AtlasLootDefaultFrame_SubMenu:Disable();
		AtlasLootDefaultFrame_SelectedTable:SetText("");
		AtlasLootDefaultFrame_SelectedTable:Show();
	-- If the button links to a sub menu definition
	else
		-- Enable the submenu button
		AtlasLootDefaultFrame_SubMenu:Enable();
		-- Show the first loot table associated with the submenu
		AtlasLoot_ShowBossLoot(AtlasLoot_HewdropDown_SubTables[tablename][1][2], AtlasLoot_HewdropDown_SubTables[tablename][1][1], AtlasLoot_AnchorPoint);
		-- Save needed info for fuure re-display of the table
		AtlasLootCharDB.LastBoss = AtlasLoot_HewdropDown_SubTables[tablename][1][2];
		AtlasLootCharDB.LastBossText = AtlasLoot_HewdropDown_SubTables[tablename][1][1];
		-- Load the correct submenu and associated with the button
		AtlasLoot_HewdropSubMenu:Unregister(AtlasLootDefaultFrame_SubMenu);
		AtlasLoot_HewdropSubMenuRegister(AtlasLoot_HewdropDown_SubTables[tablename]);
		-- Show a text label of what has been selected
		AtlasLootDefaultFrame_SelectedTable:SetText(AtlasLoot_HewdropDown_SubTables[tablename][1][1]);
		AtlasLootDefaultFrame_SelectedTable:Show();
	end
	-- Show the category that has been selected
	AtlasLootDefaultFrame_SelectedCategory:SetText(text);
	AtlasLootDefaultFrame_SelectedCategory:Show();
	AtlasLoot_Hewdrop:Close(1);
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
	AtlasLoot_ShowBossLoot(tablename, text, AtlasLoot_AnchorPoint);
	-- Save needed info for fuure re-display of the table
	AtlasLootCharDB.LastBoss = tablename;
	AtlasLootCharDB.LastBossText = text;
	-- Show the table that has been selected
	AtlasLootDefaultFrame_SelectedTable:SetText(text);
	AtlasLootDefaultFrame_SelectedTable:Show();
	AtlasLoot_HewdropSubMenu:Close(1);
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
			if ( level == 1 ) then
				for k,v in pairs(loottable) do
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
			if ( level == 1 ) then
				if ( AtlasLoot_HewdropDown ) then
					for k,v in ipairs(AtlasLoot_HewdropDown) do
						-- If a link to show a submenu
						if ( type(v[1]) == "table" and type(v[1][1]) == "string" ) then
							if ( v[1][3] == "Submenu" ) then
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
							local lock = 0;
							-- If an entry linked to a subtable
							for i,j in pairs(v) do
								if ( lock == 0 ) then
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
									lock = 1;
								end
							end
						end
					end
				end
			elseif ( level == 2 ) then
				if ( value ) then
					for k,v in ipairs(value) do
						if ( type(v) == "table" ) then
							if ( type(v[1]) == "table" and type(v[1][1]) == "string" ) then
								-- If an entry to show a submenu
								if ( v[1][3] == "Submenu" ) then
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
								local lock = 0;
								-- Entry to link to a sub table
								for i,j in pairs(v) do
									if ( lock == 0 ) then
										AtlasLoot_Hewdrop:AddLine(
											'text', i,
											'textR', 1,
											'textG', 0.82,
											'textB', 0,
											'hasArrow', true,
											'value', j,
											'notCheckable', true
										)
										lock = 1;
									end
								end
							end
						end
					end
				end
			elseif ( level == 3 ) then
				-- Essentially the same as level == 2
				if ( value ) then
					for k,v in pairs(value) do
						if ( type(v[1]) == "string" ) then
							if ( v[3] == "Submenu" ) then
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
						elseif ( type(v) == "table" ) then
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
	AtlasLoot_QuickLooks:Hide();
	AtlasLootQuickLooksButton:Hide();
	AtlasLootServerQueryButton:Hide();
	AtlasLootDefaultFrame_SelectedCategory:SetText(menuName)
	AtlasLootDefaultFrame_SubMenu:Disable();
	AtlasLootDefaultFrame_SelectedTable:SetText("");
	AtlasLootDefaultFrame_SelectedTable:Show();
	AtlasLootCharDB.LastBoss = this.lootpage;
	AtlasLootCharDB.LastBossText = menuName;
	if ( menuName == AL["Crafting"] ) then
		AtlasLoot_ShowItemsFrame("CRAFTINGMENU", "dummy", "dummy", AtlasLoot_AnchorPoint)
	elseif ( menuName == AL["PvP Rewards"] ) then
		AtlasLoot_ShowItemsFrame("PVPMENU", "dummy", "dummy", AtlasLoot_AnchorPoint)
	elseif ( menuName == AL["World Events"] ) then
		AtlasLoot_ShowItemsFrame("WORLDEVENTMENU", "dummy", "dummy", AtlasLoot_AnchorPoint)
	elseif ( menuName == AL["Collections"] ) then
		AtlasLoot_ShowItemsFrame("SETMENU", "dummy", "dummy", AtlasLoot_AnchorPoint)
	elseif ( menuName == AL["Factions"] ) then
		AtlasLoot_ShowItemsFrame("REPMENU", "dummy", "dummy", AtlasLoot_AnchorPoint)
	elseif ( menuName == AL["World Bosses"] ) then
		AtlasLoot_ShowItemsFrame("WORLDBOSSMENU", "dummy", "dummy", AtlasLoot_AnchorPoint)
	elseif ( menuName == AL["Dungeons & Raids"] ) then
		AtlasLoot_ShowItemsFrame("DUNGEONSMENU1", "dummy", "dummy", AtlasLoot_AnchorPoint)
	end
	CloseDropDownMenus()
end

--[[
AtlasLootItemsFrame_OnCloseButton:
Called when the close button on the item frame is clicked
]]
function AtlasLootItemsFrame_OnCloseButton()
	-- Set no loot table as currently selected
	AtlasLootItemsFrame.activeBoss = nil;
	-- Fix the boss buttons so the correct icons are displayed
	if ( AtlasFrame and AtlasFrame:IsVisible() ) then
		if ( ATLAS_CUR_LINES ) then
			for i = 1,ATLAS_CUR_LINES do
				if ( _G["AtlasBossLine"..i.."_Selected"]:IsVisible() ) then
					_G["AtlasBossLine"..i.."_Selected"]:Hide();
					_G["AtlasBossLine"..i.."_Loot"]:Show();
				end
			end
		end
	end
	-- Hide the item frame
	AtlasLootItemsFrame:Hide();
end

--[[
AtlasLootMenuItem_OnClick:
Requests the relevant loot page from a menu screen
]]
function AtlasLootMenuItem_OnClick()
	if ( this.container ) then
		AtlasLoot_ShowContainerFrame()
		return
	end
	if ( this.isheader == nil or this.isheader == false ) then
		local pagename = _G[this:GetName().."_Name"]:GetText()
		for k,v in ipairs(AtlasLoot_HewdropDown) do
			if ( not (type(v[1]) == "table") ) then
				for k2, v2 in pairs(v) do
					for k3, v3 in pairs(v2) do
						for k4, v4 in pairs(v3) do
							if ( not (type(v4[1]) == "table") ) then
								if ( v4[1] == pagename and v4[3] ~= "Table" ) then
									AtlasLoot_HewdropClick(v4[2],v4[1],v4[3])
								end
							else
								for k5,v5 in pairs(v4) do
									if ( v5[1] == pagename ) then
										AtlasLoot_HewdropClick(v5[2],v5[1],v5[3])
									end
								end
							end
						end
					end
				end
			end
		end
		CloseDropDownMenus()
		AtlasLootCharDB.LastBoss = this.lootpage;
		AtlasLootCharDB.LastBossText = pagename;
		AtlasLoot_ShowBossLoot(this.lootpage, pagename, AtlasLoot_AnchorPoint);
		AtlasLootDefaultFrame_SelectedCategory:SetText(pagename);
		AtlasLootDefaultFrame_SelectedCategory:Show();
	end
end

--[[
AtlasLoot_NavButton_OnClick:
Called when <-, -> or 'Back' are pressed and calls up the appropriate loot page
]]
function AtlasLoot_NavButton_OnClick()
	if ( AtlasLootItemsFrame.refresh and AtlasLootItemsFrame.refresh[1] and AtlasLootItemsFrame.refresh[2] and AtlasLootItemsFrame.refresh[4] ) then
		if ( AtlasLootItemsFrame.refresh[1] == "DUNGEONSMENU1" ) then
			AtlasLootItemsFrame.refresh[1] = "DUNGEONSMENU2"
			AtlasLoot_DungeonsMenu2()
			AtlasLootDefaultFrame_SubMenu:Disable();
			return
		elseif ( AtlasLootItemsFrame.refresh[1] == "DUNGEONSMENU2" ) then
			AtlasLootItemsFrame.refresh[1] = "DUNGEONSMENU1"
			AtlasLoot_DungeonsMenu1()
			AtlasLootDefaultFrame_SubMenu:Disable();
			return
		end
		if ( string.sub(this.lootpage, 1, 16) == "SearchResultPage" ) then
			AtlasLoot_ShowItemsFrame("SearchResult", this.lootpage, string.format((AL["Search Result: %s"]), AtlasLootCharDB.LastSearchedText or ""), AtlasLootItemsFrame.refresh[4]);
		elseif ( string.sub(this.lootpage, 1, 12) == "WishListPage" ) then
			AtlasLoot_ShowItemsFrame("WishList", this.lootpage, AL["WishList"], AtlasLootItemsFrame.refresh[4]);
		else
			AtlasLootCharDB.LastBoss = this.lootpage;
			AtlasLootCharDB.LastBossText = this.title;
			AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootItemsFrame.refresh[2], this.title, AtlasLoot_AnchorPoint);
			if ( AtlasLootDefaultFrame_SelectedTable:GetText() ) then
				AtlasLootDefaultFrame_SelectedTable:SetText(AtlasLoot_BossName:GetText())
			else
				AtlasLootDefaultFrame_SelectedCategory:SetText(AtlasLoot_BossName:GetText())
			end
		end
	elseif ( AtlasLootItemsFrame.refresh and AtlasLootItemsFrame.refresh[2] ) then
		AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootItemsFrame.refresh[2], this.title, AtlasLoot_AnchorPoint);
	else
		-- Fallback for if the requested loot page is a menu and does not have a .refresh instance
		AtlasLoot_ShowItemsFrame(this.lootpage, "dummy", this.title, AtlasLoot_AnchorPoint);
	end
	for k in pairs(AtlasLoot_MenuList) do
		if ( this.lootpage == k ) then
			AtlasLootDefaultFrame_SubMenu:Disable();
			AtlasLootDefaultFrame_SelectedCategory:SetText(AtlasLootCharDB.LastBossText)
			AtlasLootDefaultFrame_SelectedTable:SetText()
		end
	end
end

--[[
AtlasLoot_IsLootTableAvailable(dataID):
Checks if a loot table is in memory and attempts to load the correct LoD module if it isn't
dataID: Loot table dataID
]]
function AtlasLoot_IsLootTableAvailable(dataID)
	if ( not dataID ) then return false end

	local menu_check = false;

	for k in pairs(AtlasLoot_MenuList) do
		if ( k == dataID ) then
			menu_check = true;
		end
	end

	if ( menu_check ) then
		return true;
	else
		if ( not AtlasLoot_TableNames[dataID] ) then
			DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot Error!"].." "..WHITE..dataID..AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"]);
			return false;
		end

		local dataSource = AtlasLoot_TableNames[dataID][2];

		if ( AtlasLoot_Data[dataSource] ) then
			if ( AtlasLoot_Data[dataSource][dataID] ) then
				return true;
			end
		end
	end
end

--[[
AtlasLoot_ShowQuickLooks(button)
button: Identity of the button pressed to trigger the function
Shows the GUI for setting Quicklooks
]]
function AtlasLoot_ShowQuickLooks(button)
	local Hewdrop = AceLibrary("Hewdrop-2.0");
	if ( Hewdrop:IsOpen(button) ) then
		Hewdrop:Close(1);
	else
		local setOptions = function()
			Hewdrop:AddLine(
				"text", AL["QuickLook"].." 1",
				"tooltipTitle", AL["QuickLook"].." 1",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 1",
				"func", function()
					AtlasLootCharDB["QuickLooks"][1] = {AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]};
					AtlasLoot_RefreshQuickLookButtons();
					Hewdrop:Close(1);
				end
			);
			Hewdrop:AddLine(
				"text", AL["QuickLook"].." 2",
				"tooltipTitle", AL["QuickLook"].." 2",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 2",
				"func", function()
					AtlasLootCharDB["QuickLooks"][2] = {AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]};
					AtlasLoot_RefreshQuickLookButtons();
					Hewdrop:Close(1);
				end
			);
			Hewdrop:AddLine(
				"text", AL["QuickLook"].." 3",
				"tooltipTitle", AL["QuickLook"].." 3",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 3",
				"func", function()
					AtlasLootCharDB["QuickLooks"][3] = {AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]};
					AtlasLoot_RefreshQuickLookButtons();
					Hewdrop:Close(1);
				end
			);
			Hewdrop:AddLine(
				"text", AL["QuickLook"].." 4",
				"tooltipTitle", AL["QuickLook"].." 4",
				"tooltipText", AL["Assign this loot table\n to QuickLook"].." 4",
				"func", function()
					AtlasLootCharDB["QuickLooks"][4] = {AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]};
					AtlasLoot_RefreshQuickLookButtons();
					Hewdrop:Close(1);
				end
			);
		end;
		Hewdrop:Open(button,
			'point', function(parent)
				return "BOTTOMLEFT", "BOTTOMRIGHT";
			end,
			"children", setOptions
		);
	end
end

--[[
AtlasLoot_RefreshQuickLookButtons()
Enables/disables the quicklook buttons depending on what is assigned
]]
function AtlasLoot_RefreshQuickLookButtons()
	for i = 1, 4 do
		if ( not AtlasLootCharDB["QuickLooks"][i] or not AtlasLootCharDB["QuickLooks"][i][1] ) then
			_G["AtlasLootPanel_Preset"..i]:Disable();
			_G["AtlasLootDefaultFrame_Preset"..i]:Disable();
		else
			_G["AtlasLootPanel_Preset"..i]:Enable();
			_G["AtlasLootDefaultFrame_Preset"..i]:Enable();
		end
	end
end

--[[
AtlasLoot_ClearQuickLookButton()
Clears a quicklook button.
]]
function AtlasLoot_ClearQuickLookButton(button)
	if ( not button ) then return end
	AtlasLootCharDB["QuickLooks"][button] = nil
	AtlasLoot_RefreshQuickLookButtons()
	DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..WHITE..AL["QuickLook"].." "..button.." "..AL["has been reset!"]);
end

--[[
AtlasLoot_ShowBossLoot(dataID, boss, pFrame):
dataID - Name of the loot table
boss - Text string to be used as the title for the loot page
pFrame - Data structure describing how and where to anchor the item frame (more details, see the function AtlasLoot_SetItemInfoFrame)
This is the intended API for external mods to use for displaying loot pages.
This function figures out where the loot table is stored, then sends the relevant info to AtlasLoot_ShowItemsFrame
]]
function AtlasLoot_ShowBossLoot(dataID, boss, pFrame)
	local tableavailable = AtlasLoot_IsLootTableAvailable(dataID);
	if ( tableavailable ) then
		AtlasLootItemsFrame:Hide();
		-- If the loot table is already being displayed, it is hidden and the current table selection cancelled
		if ( dataID == AtlasLootItemsFrame.externalBoss and AtlasLootItemsFrame:GetParent() ~= AtlasFrame and AtlasLootItemsFrame:GetParent() ~= AtlasLootDefaultFrame_LootBackground ) then
			AtlasLootItemsFrame.externalBoss = nil;
		else
			-- Use the original WoW instance data by default
			local dataSource = AtlasLoot_TableNames[dataID][2];
			-- Set selected table and call AtlasLoot_ShowItemsFrame
			AtlasLootItemsFrame.externalBoss = dataID;
			AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame);
		end
	end
end

function AtlasLootOptions_SetupSlider(text, mymin, mymax, step)
	_G[this:GetName().."Text"]:SetText(text.." ("..this:GetValue()..")");
	this:SetMinMaxValues(mymin, mymax);
	_G[this:GetName().."Low"]:SetText(mymin);
	_G[this:GetName().."High"]:SetText(mymax);
	this:SetValueStep(step);
end

--[[
AtlasLootMinimapButton_OnClick:
Function to show/hide AtlasLoot when click on minimap button.
]]
function AtlasLootMinimapButton_OnClick(arg1)
	if ( arg1 == "LeftButton" ) then
		AtlasLoot_Toggle();
	end
end

--[[
AtlasLootMinimapButton_Init:
Show/hide minimap button.
]]
function AtlasLootMinimapButton_Init()
	if ( AtlasLootCharDB.MinimapButton == true ) then
		AtlasLootMinimapButtonFrame:Show();
	else
		AtlasLootMinimapButtonFrame:Hide();
	end
end

--[[
AtlasLootMinimapButton_OnEnter:
Show tooltip when mouse is over minimap button.
]]
function AtlasLootMinimapButton_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	GameTooltip:SetText(AL["AtlasLoot Enhanced"]);
	GameTooltipTextLeft1:SetTextColor(1, 1, 1);
	GameTooltip:AddLine(AL["Left-click to open AtlasLoot.\nMiddle-click for AtlasLoot options.\nRight-click and drag to move this button."]);
	GameTooltip:Show();
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
	);
	AtlasLootOptions_Init()
end

local function around(num, idp)
	local mult = 10 ^ (idp or 0);
	return math.floor(num * mult + 0.5) / mult;
end

function AtlasLootOptions_UpdateSlider(text)
	_G[this:GetName().."Text"]:SetText(text.." ("..around(this:GetValue(),2)..")");
end

function AtlasLootOptions_ResetPosition()
	AtlasLootCharDB.MinimapButtonPosition = 315;
	AtlasLootCharDB.MinimapButtonRadius = 78;
	AtlasLootMinimapButton_UpdatePosition();
	DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["Minimap button has been reset!"]);
end

function AtlasLootOptions_DefaultSettings()
	AtlasLootCharDB.SafeLinks = false;
	AtlasLootCharDB.AllLinks = true;
	AtlasLootCharDB.DefaultTT = true;
	AtlasLootCharDB.LootlinkTT = false;
	AtlasLootCharDB.ItemSyncTT = false;
	AtlasLootCharDB.ShowSource = true;
	AtlasLootCharDB.EquipCompare = false;
	AtlasLootCharDB.Opaque = false;
	AtlasLootCharDB.ItemIDs = false;
	AtlasLootCharDB.ItemSpam = true;
	AtlasLootCharDB.MinimapButton = true;
	AtlasLootCharDB.HidePanel = false;
	-- AtlasLootCharDB.AutoQuery = false;
	AtlasLootCharDB.PartialMatching = true;
	AtlasLootCharDB.LastBoss = "DUNGEONSMENU1";
	AtlasLootCharDB.LastBossText = AL["Dungeons & Raids"];
	AtlasLootDefaultFrame:ClearAllPoints();
	AtlasLootDefaultFrame:SetPoint("TOP", "UIParent", "TOP", 0, -30);
	AtlasLootOptionsFrame:ClearAllPoints();
	AtlasLootOptionsFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 100);
	AtlasLootCharDB["QuickLooks"] = {};
	AtlasLootCharDB["WishList"] = {};
	AtlasLoot_RefreshQuickLookButtons();
	AtlasLootOptions_Init();
	DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["Default settings applied!"]);
end

--[[
AtlasLootButton_BeingDragged:
Function to move the minimap button around the minimap.
]]
function AtlasLootMinimapButton_BeingDragged()
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()
	xpos = xmin-xpos/UIParent:GetScale()+70
	ypos = ypos/UIParent:GetScale()-ymin-70
	AtlasLootMinimapButton_SetPosition(math.deg(math.atan2(ypos,xpos)));
end

--[[
AtlasLootButton_SetPosition:
Function to save the position of the minimap button.
]]
function AtlasLootMinimapButton_SetPosition(v)
	if ( v < 0 ) then
		v = v + 360;
	end
	AtlasLootCharDB.MinimapButtonPosition = v;
	AtlasLootMinimapButton_UpdatePosition();
end

-- This is a multi-layer table defining the main loot listing.
-- Entries have the text to display, loot table or sub table to link to and if the link is to a loot table or sub table
AtlasLoot_HewdropDown = {
	{[AL["Dungeons & Raids"]] = {
			{{ AL["[13-18] Ragefire Chasm"], "RagefireChasm", "Submenu" },},
			{{ AL["[17-24] Wailing Caverns"], "WailingCaverns", "Submenu" },},
			{{ AL["[17-24] The Deadmines"], "Deadmines", "Submenu" },},
			{{ AL["[22-30] Shadowfang Keep"], "ShadowfangKeep", "Submenu" },},
			{{ AL["[23-32] Blackfathom Deeps"], "BlackfathomDeeps", "Submenu" },},
			{{ AL["[22-30] The Stockade"], "TheStockade", "Submenu" },},
			{{ AL["[26-35] Dragonmaw Retreat"], "DragonmawRetreat", "Submenu" },},
			{{ AL["[29-38] Gnomeregan"], "Gnomeregan", "Submenu" },},
			{{ AL["[29-38] Razorfen Kraul"], "RazorfenKraul", "Submenu" },},
			{{ AL["[32-38] The Crescent Grove"], "TheCrescentGrove", "Submenu" },},
			{[ AL["[27-45] Scarlet Monastery"]] = {
					{ AL["[27-36] Scarlet Monastery (Graveyard)"], "SMGraveyard", "Submenu" },
					{ AL["[28-39] Scarlet Monastery (Library)"], "SMLibrary", "Submenu" },
					{ AL["[32-41] Scarlet Monastery (Armory)"], "SMArmory", "Submenu" },
					{ AL["[35-45] Scarlet Monastery (Cathedral)"], "SMCathedral", "Submenu" },
				},},
			{{ AL["[32-44] Stormwrought Ruins"], "StormwroughtRuins", "Submenu" },},
			{{ AL["[36-46] Razorfen Downs"], "RazorfenDowns", "Submenu" },},
			{{ AL["[40-51] Uldaman"], "Uldaman", "Submenu" },},
			{{ AL["[42-50] Gilneas City"], "GilneasCity", "Submenu" },},
			{{ AL["[45-55] Maraudon"], "Maraudon", "Submenu" },},
			{{ AL["[44-54] Zul'Farrak"], "ZulFarrak", "Submenu" },},
			{{ AL["[50-60] The Sunken Temple"], "SunkenTemple", "Submenu" },},
			{{ AL["[50-60] Hateforge Quarry"], "HateforgeQuarry", "Submenu" },},
			{{ AL["[52-60] Blackrock Depths"], "BlackrockDepths", "Submenu" },},
			{[AL["[55-60] Dire Maul"]] = {
					{ AL["[55-60] Dire Maul (East)"], "DireMaulEast", "Submenu" },
					{ AL["[57-60] Dire Maul (West)"], "DireMaulWest", "Submenu" },
					{ AL["[57-60] Dire Maul (North)"], "DireMaulNorth", "Submenu" },
				},},
			{{ AL["[58-60] Scholomance"], "Scholomance", "Submenu" },},
			{{ AL["[58-60] Stratholme"], "Stratholme", "Submenu" },},
			{{ AL["[55-60] Lower Blackrock Spire"], "LowerBlackrock", "Submenu" },},
			{{ AL["[58-60] Upper Blackrock Spire"], "UpperBlackrock", "Submenu" },},
			{{ AL["[58-60] Karazhan Crypt"], "KarazhanCrypt", "Submenu" },},
			{{ AL["[60] Caverns of Time: Black Morass"], "CavernsOfTimeBlackMorass", "Submenu" },},
			{{ AL["[60] Stormwind Vault"], "StormwindVault", "Submenu" },},
			{{ AL["[RAID] Zul'Gurub"], "ZulGurub", "Submenu" },},
			{{ AL["[RAID] Ruins of Ahn'Qiraj"], "RuinsofAQ", "Submenu" },},
			{{ AL["[RAID] Molten Core"], "MoltenCore", "Submenu" },},
			{{ AL["[RAID] Onyxia's Lair"], "Onyxia", "Submenu" },},
			{{ AL["[RAID] Lower Karazhan Halls"], "LowerKara", "Submenu" },},
			{{ AL["[RAID] Blackwing Lair"], "BlackwingLair", "Submenu" },},
			{{ AL["[RAID] Emerald Sanctum"], "EmeraldSanctum", "Submenu" },},
			{{ AL["[RAID] Temple of Ahn'Qiraj"], "TempleofAQ", "Submenu" },},
			{{ AL["[RAID] Naxxramas"], "Naxxramas", "Submenu" },},
            {{ AL["[RAID] Upper Karazhan Halls"], "UpperKara", "Submenu" },},
		},
	},
	{[AL["World Bosses"]] = {
		{{AL["Azuregos"], "AAzuregos", "Table" },},
		{{AL["Emeriss"], "DEmeriss", "Table" },},
		{{AL["Lethon"], "DLethon", "Table" },},
		{{AL["Taerar"], "DTaerar", "Table" },},
		{{AL["Ysondre"], "DYsondre", "Table" },},
		{{AL["Lord Kazzak"], "KKazzak", "Table" },},
		{{AL["Nerubian Overseer"], "Nerubian", "Table" },},
		{{AL["Dark Reaver of Karazhan"], "Reaver", "Table" },},
		{{AL["Ostarius"], "Ostarius", "Table" },},
		{{AL["Concavius"], "Concavius", "Table" },},
		{{AL["Moo"], "CowKing", "Table" },},
		{{AL["Cla'ckora"], "Clackora", "Table"},},
		},
	},
	{[AL["PvP Rewards"]] = {
		{{ AL["PvP Armor Sets"], "PVPSET", "Table" },},
		{{ AL["PvP Accessories"], "PvP60Accessories1", "Table" },},
		{{ AL["Rank 14 Weapons"], "PVPWeapons1", "Table" },},
		{{ AL["PvP Mounts"], "PvPMountsPvP", "Table" },},
		{{ AL["Blood Ring"], "BRRepMenu", "Table" },},
		{{ AL["Alterac Valley"], "AVRepMenu", "Table" },},
		{{ AL["Arathi Basin"], "ABRepMenu", "Table" },},
		{{ AL["Warsong Gulch"], "WSGRepMenu", "Table" },},
		},
	},
	{[AL["Collections"]] = {
			{{ AL["Sets"], "PRE60SET", "Table" },},
			{{ AL["Zul'Gurub Sets"], "ZGSET", "Table" },},
			{{ AL["Ruins of Ahn'Qiraj Sets"], "AQ20SET", "Table" },},
			{{ AL["Temple of Ahn'Qiraj Sets"], "AQ40SET", "Table" },},
			{{ AL["Karazhan Sets"], "KARASET", "Table" },},
			{{ AL["Dungeon 1/2 Sets"], "T0SET", "Table" },},
			{{ AL["Tier 1 Sets"], "T1SET", "Table" },},
			{{ AL["Tier 2 Sets"], "T2SET", "Table" },},
			{{ AL["Tier 3 Sets"], "T3SET", "Table" },},
			{{ AL["Legendary Items"], "Legendaries", "Table" },},
			{{ AL["World Epics"], "WorldEpics1", "Table" },},
			{{ AL["Rare Pets"], "RarePets1", "Table" },},
			{{ AL["Rare Mounts"], "RareMounts", "Table" },},
			{{ AL["Tabards"], "Tabards", "Table" },},
			},
		},
	{[AL["Factions"]] = {
			{{ AL["Argent Dawn"], "Argent1" , "Table" },},
			{{ AL["Bloodsail Buccaneers"], "Bloodsail1", "Table" },},
			{{ AL["Brood of Nozdormu"], "AQBroodRings", "Table" },},
			{{ AL["Cenarion Circle"], "Cenarion1", "Table" }},
			{{ AL["Dalaran"], "Dalaran", "Table" },},
			{{ AL["Darkmoon Faire"], "Darkmoon", "Table" },},
			{{ AL["Darkspear Trolls"], "DarkspearTrolls", "Table" },},
			{{ AL["Darnassus"], "Darnassus", "Table" },},
			{{ AL["Durotar Labor Union"], "DurotarLaborUnion", "Table" },},
			{{ AL["Frostwolf Clan"], "Frostwolf1", "Table" },},
			{{ AL["Gelkis Clan Centaur"], "GelkisClan1", "Table" },},
			{{ AL["Gnomeregan Exiles"], "GnomereganExiles", "Table" },},
			{{ AL["Hydraxian Waterlords"], "WaterLords1", "Table" },},
			{{ AL["Ironforge"], "Ironforge", "Table" },},
			{{ AL["Magram Clan Centaur"], "MagramClan1", "Table" },},
			{{ AL["Orgrimmar"], "Orgrimmar", "Table" },},
			{{ AL["Revantusk Trolls"], "Revantusk", "Table" },},
			{{ AL["Silvermoon Remnant"], "Helf", "Table" },},
			{{ AL["Stormpike Guard"], "Stormpike1", "Table" },},
			{{ AL["Stormwind"], "Stormwind", "Table" },},
			{{ AL["Thorium Brotherhood"], "Thorium1", "Table" },},
			{{ AL["Thunder Bluff"], "ThunderBluff", "Table" },},
			{{ AL["Timbermaw Hold"], "Timbermaw", "Table" },},
			{{ AL["Undercity"], "Undercity", "Table" },},
			{{ AL["Wardens of Time"], "Wardens1", "Table" },},
			{{ AL["Wildhammer Clan"], "Wildhammer", "Table" },},
			{{ AL["Wintersaber Trainers"], "Wintersaber1", "Table" },},
			{{ AL["Zandalar Tribe"], "Zandalar1", "Table" },},
		 	},
		},
	{[AL["World Events"]] = {
			{{ AL["Abyssal Council"], "AbyssalTemplars", "Table" },},
			{{ AL["Children's Week"], "ChildrensWeek", "Table" },},
			{{ AL["Elemental Invasion"], "ElementalInvasion", "Table" },},
			{{ AL["Feast of Winter Veil"], "Winterviel1", "Table" },},
			{{ AL["Gurubashi Arena"], "GurubashiArena", "Table" },},
			{{ AL["Hallow's End"], "Halloween1", "Table" },},
			{{ AL["Harvest Festival"], "HarvestFestival", "Table" },},
			{{ AL["Love is in the Air"], "Valentineday", "Table" },},
			{{ AL["Lunar Festival"], "LunarFestival1", "Table" },},
			{{ AL["Midsummer Fire Festival"], "MidsummerFestival", "Table" },},
			{{ AL["Noblegarden"], "Noblegarden", "Table" },},
			{{ AL["Scourge Invasion"], "ScourgeInvasionEvent1", "Table" },},
			{{ AL["Stranglethorn Fishing Extravaganza"], "FishingExtravaganza", "Table" },},
			},
		},
	{[AL["Crafting"]] = {
			{ { AL["Alchemy"], "ALCHEMYMENU", "Table" }, },
			{ { AL["Blacksmithing"], "SMITHINGMENU", "Table" }, },
			{ { AL["Enchanting"], "ENCHANTINGMENU", "Table" }, },
			{ { AL["Engineering"], "ENGINEERINGMENU", "Table" }, },
			{ { AL["Herbalism"], "Herbalism1", "Table" }, },
			{ { AL["Leatherworking"], "LEATHERWORKINGMENU", "Table" }, },
			{ { AL["Jewelcrafting"], "JEWELCRAFTMENU", "Table" }, },
			{ { AL["Mining"], "Mining1", "Table" }, },
			{ { AL["Tailoring"], "TAILORINGMENU", "Table" }, },
			{ { AL["Cooking"], "CookingApprentice1", "Table" }, },
			{ { AL["First Aid"], "FirstAid1", "Table" }, },
			{ { AL["Survival"], "Survival1", "Table" }, },
			{ { AL["Gardening"], "Survival2", "Table" }, },
			{ { AL["Poisons"], "Poisons1", "Table" }, },
			{ { AL["Crafted Sets"], "CRAFTSET", "Table" },},
			{ { AL["Crafted Epic Weapons"], "CraftedWeapons1", "Table" }, },
		},
	},
	{{ "Rare Spawns", "RareSpawns", "Submenu" },},
};

-- This table defines all the subtables needed for the full menu
-- Each sub table entry contains the text entry and the loot table that goes wih it
AtlasLoot_HewdropDown_SubTables = {
	["HateforgeQuarry"] = {
		{ AL["High Foreman Bargul Blackhammer"], "HQHighForemanBargulBlackhammer" },
		{ AL["Engineer Figgles"], "HQEngineerFiggles" },
		{ AL["Corrosis"], "HQCorrosis" },
		{ AL["Hatereaver Annihilator"], "HQHatereaverAnnihilator" },
		{ AL["Har'gesh Doomcaller"], "HQHargeshDoomcaller" },
		{ AL["Trash Mobs"], "HQTrash" },
	},
	["BlackrockDepths"] = {
		{ AL["Lord Roccor"], "BRDLordRoccor" },
		{ AL["High Interrogator Gerstahn"], "BRDHighInterrogatorGerstahn" },
		{ AL["Anub'shiah"], "BRDAnubshiah" },
		{ AL["Eviscerator"], "BRDEviscerator" },
		{ AL["Gorosh the Dervish"], "BRDGorosh" },
		{ AL["Grizzle"], "BRDGrizzle" },
		{ AL["Hedrum the Creeper"], "BRDHedrum" },
		{ AL["Ok'thor the Breaker"], "BRDOkthor" },
		{ AL["Theldren"], "BRDTheldren" },
		{ AL["Houndmaster Grebmar"], "BRDHoundmaster" },
		{ AL["Pyromancer Loregrain"].." ("..AL["Rare"]..")", "BRDPyromancerLoregrain" },
		{ AL["The Vault"], "BRDTheVault" },
		{ AL["Warder Stilgiss"].." ("..AL["Rare"]..")", "BRDWarderStilgiss" },
		{ AL["Verek"].." ("..AL["Rare"]..")", "BRDVerek" },
		{ AL["Fineous Darkvire"], "BRDFineousDarkvire" },
		{ AL["Lord Incendius"], "BRDLordIncendius" },
		{ AL["Bael'Gar"], "BRDBaelGar" },
		{ AL["General Angerforge"], "BRDGeneralAngerforge" },
		{ AL["Golem Lord Argelmach"], "BRDGolemLordArgelmach" },
		{ AL["The Grim Guzzler"], "BRDGuzzler" },
		{ AL["Ambassador Flamelash"], "BRDFlamelash" },
		{ AL["Panzor the Invincible"].." ("..AL["Rare"]..")", "BRDPanzor" },
		{ AL["Summoner's Tomb"], "BRDTomb" },
		{ AL["Magmus"], "BRDMagmus" },
		{ AL["Princess Moira Bronzebeard"], "BRDPrincess" },
		{ AL["Emperor Dagran Thaurissan"], "BRDEmperorDagranThaurissan" },
		{ AL["Trash Mobs"], "BRDTrash" },
	},
	["LowerBlackrock"] = {
		{ AL["Spirestone Butcher"].." ("..AL["Rare"]..")", "LBRSSpirestoneButcher" },
		{ AL["Spirestone Battle Lord"].." ("..AL["Rare"]..")", "LBRSSpirestoneBattleLord" },
		{ AL["Spirestone Lord Magus"].." ("..AL["Rare"]..")", "LBRSSpirestoneLordMagus" },
		{ AL["Highlord Omokk"], "LBRSOmokk" },
		{ AL["Shadow Hunter Vosh'gajin"], "LBRSVosh" },
		{ AL["War Master Voone"], "LBRSVoone" },
		{ AL["Burning Felguard"].." ("..AL["Rare"]..")", "LBRSFelguard" },
		{ AL["Mor Grayhoof"], "LBRSGrayhoof" },
		{ AL["Bannok Grimaxe"].." ("..AL["Rare"]..")", "LBRSGrimaxe" },
		{ AL["Mother Smolderweb"], "LBRSSmolderweb" },
		{ AL["Crystal Fang"].." ("..AL["Rare"]..")", "LBRSCrystalFang" },
		{ AL["Urok Doomhowl"], "LBRSDoomhowl" },
		{ AL["Quartermaster Zigris"], "LBRSZigris" },
		{ AL["Halycon"], "LBRSHalycon" },
		{ AL["Gizrul the Slavener"], "LBRSSlavener" },
		{ AL["Ghok Bashguud"].." ("..AL["Rare"]..")", "LBRSBashguud" },
		{ AL["Overlord Wyrmthalak"], "LBRSWyrmthalak" },
		{ AL["Trash Mobs"], "LBRSTrash" },
	},
	["UpperBlackrock"] = {
		{ AL["Pyroguard Emberseer"], "UBRSEmberseer" },
		{ AL["Solakar Flamewreath"], "UBRSSolakar" },
		{ AL["Father Flame"], "UBRSFlame" },
		{ AL["Jed Runewatcher"].." ("..AL["Rare"]..")", "UBRSRunewatcher" },
		{ AL["Goraluk Anvilcrack"].." ("..AL["Rare"]..")", "UBRSAnvilcrack" },
		{ AL["Warchief Rend Blackhand"], "UBRSRend" },
		{ AL["Gyth"], "UBRSGyth" },
		{ AL["The Beast"], "UBRSBeast" },
		{ AL["Lord Valthalak"], "UBRSValthalak" },
		{ AL["General Drakkisath"], "UBRSDrakkisath" },
		{ AL["Trash Mobs"], "UBRSTrash" },
	},
	["KarazhanCrypt"] = {
		{ AL["Marrowspike"], "KCMarrowspike" },
		{ AL["Hivaxxis"], "KCHivaxxis" },
		{ AL["Corpsemuncher"], "KCCorpsemuncher" },
		{ AL["Guard Captain Gort"], "KCGuardCaptainGort" },
		{ AL["Archlich Enkhraz"], "KCArchlichEnkhraz" },
		{ AL["Commander Andreon"], "KCCommanderAndreon" },
		{ AL["Alarus"], "KCAlarus" },
		{ AL["Half-Buried Treasure Chest"], "KCTreasure" },
		{ AL["Trash Mobs"], "KCTrash" },
	},
	["CavernsOfTimeBlackMorass"] = {
		{ AL["Chronar"], "COTBMChronar" },
		{ AL["Epidamu"], "COTBMEpidamu" },
		{ AL["Drifting Avatar of Sand"], "COTBMDriftingAvatar" },
		{ AL["Time-Lord Epochronos"], "COTBMTimeLordEpochronos" },
		{ AL["Mossheart"], "COTBMMossheart" },
		{ AL["Rotmaw"], "COTBMRotmaw" },
		{ AL["Antnormi"], "COTBMAntnormi" },
		{ AL["Trash Mobs"], "COTTrash" },
		-- { AL["Infinite Chromie"], "COTBMInfiniteChromie" },
	},
	["StormwindVault"] = {
		{ AL["Aszosh Grimflame"], "SWVAszoshGrimflame" },
		{ AL["Tham'Grarr"], "SWVThamGrarr" },
		{ AL["Black Bride"], "SWVBlackBride" },
		{ AL["Damian"], "SWVDamian" },
		{ AL["Volkan Cruelblade"], "SWVVolkanCruelblade" },
		{ AL["Arc'tiras"], "SWVVaultArmoryEquipment" },
		{ AL["Trash Mobs"], "SWVTrash" },
	},
	["BlackwingLair"] = {
		{ AL["Razorgore the Untamed"], "BWLRazorgore" },
		{ AL["Vaelastrasz the Corrupt"], "BWLVaelastrasz" },
		{ AL["Broodlord Lashlayer"], "BWLLashlayer" },
		{ AL["Firemaw"], "BWLFiremaw" },
		{ AL["Ebonroc"], "BWLEbonroc" },
		{ AL["Flamegor"], "BWLFlamegor" },
		{ AL["Chromaggus"], "BWLChromaggus" },
		{ AL["Nefarian"], "BWLNefarian" },
		{ AL["Trash Mobs"], "BWLTrashMobs" },
	},
	["Deadmines"] = {
        { AL["Jared Voss"], "DMJaredVoss" },
		{ AL["Rhahk'Zor"], "DMRhahkZor" },
		{ AL["Miner Johnson"].." ("..AL["Rare"]..")", "DMMinerJohnson" },
		{ AL["Sneed"], "DMSneed" },
		{ AL["Sneed's Shredder"], "DMSneedsShredder" },
		{ AL["Gilnid"], "DMGilnid" },
        { AL["Masterpiece Harvester"], "DMHarvester" },
		{ AL["Mr. Smite"], "DMMrSmite" },
		{ AL["Cookie"], "DMCookie" },
		{ AL["Captain Greenskin"], "DMCaptainGreenskin" },
		{ AL["Edwin VanCleef"], "DMVanCleef" },
		{ AL["Trash Mobs"], "DMTrash" },
	},
	["TheCrescentGrove"] = {
		{ AL["Grovetender Engryss"], "TCGGrovetenderEngryss" },
		{ AL["Keeper Ranathos"], "TCGKeeperRanathos" },
		{ AL["High Priestess A'lathea"], "TCGHighPriestessAlathea" },
		{ AL["Fenektis the Deceiver"], "TCGFenektistheDeceiver" },
		{ AL["Master Raxxieth"], "TCGMasterRaxxieth" },
		{ AL["Trash Mobs"], "TCGTrash" },
	},
	["Gnomeregan"] = {
		{ AL["Grubbis"], "GnGrubbis" },
		{ AL["Viscous Fallout"], "GnViscousFallout" },
		{ AL["Electrocutioner 6000"], "GnElectrocutioner6000" },
		{ AL["Crowd Pummeler 9-60"], "GnCrowdPummeler960" },
		{ AL["Dark Iron Ambassador"], "GnDIAmbassador" },
		{ AL["Mekgineer Thermaplugg"], "GnMekgineerThermaplugg" },
		{ AL["Trash Mobs"], "GnTrash" },
	},
	["MoltenCore"] = {
		{ AL["Incindis"], "MCIncindis" },
		{ AL["Lucifron"], "MCLucifron" },
		{ AL["Magmadar"], "MCMagmadar" },
		-- { AL["Gehennas"], "MCGehennas" },
		{ AL["Garr"], "MCGarr" },
		{ AL["Shazzrah"], "MCShazzrah" },
		{ AL["Baron Geddon"], "MCGeddon" },
		{ AL["Golemagg the Incinerator"], "MCGolemagg" },
		{ AL["Basalthar & Smoldaris"], "MCTwins" },
		{ AL["Sorcerer-Thane Thaurissan"], "MCThaurissan" },
		{ AL["Sulfuron Harbinger"], "MCSulfuron" },
		{ AL["Majordomo Executus"], "MCMajordomo" },
		{ AL["Ragnaros"], "MCRagnaros" },
		{ AL["Trash Mobs"], "MCTrashMobs" },
		{ AL["Random Boss Loot"], "MCRANDOMBOSSDROPS" },
	},
	["Naxxramas"] = {
		{ AL["Patchwerk"], "NAXPatchwerk" },
		{ AL["Grobbulus"], "NAXGrobbulus" },
		{ AL["Gluth"], "NAXGluth" },
		{ AL["Thaddius"], "NAXThaddius" },
		{ AL["Anub'Rekhan"], "NAXAnubRekhan" },
		{ AL["Grand Widow Faerlina"], "NAXGrandWidowFaerlina" },
		{ AL["Maexxna"], "NAXMaexxna" },
		{ AL["Noth the Plaguebringer"], "NAXNoththePlaguebringer" },
		{ AL["Heigan the Unclean"], "NAXHeigantheUnclean" },
		{ AL["Loatheb"], "NAXLoatheb" },
		{ AL["Instructor Razuvious"], "NAXInstructorRazuvious" },
		{ AL["Gothik the Harvester"], "NAXGothiktheHarvester" },
		{ AL["The Four Horsemen"], "NAXTheFourHorsemen" },
		{ AL["Sapphiron"], "NAXSapphiron" },
		{ AL["Kel'Thuzad"], "NAXKelThuzard" },
		{ AL["Trash Mobs"], "NAXTrash" },
	},
	["SMGraveyard"] = {
		{ AL["Interrogator Vishas"], "SMVishas" },
        { AL["Duke Dreadmoore"], "SMDukeDreadmoore" },
		{ AL["Scorn"].." ("..AL["Scourge Invasion"]..")", "SMScorn" },
		{ AL["Ironspine"].." ("..AL["Rare"]..")", "SMIronspine" },
		{ AL["Azshir the Sleepless"].." ("..AL["Rare"]..")", "SMAzshir" },
		{ AL["Fallen Champion"].." ("..AL["Rare"]..")", "SMFallenChampion" },
		{ AL["Bloodmage Thalnos"], "SMBloodmageThalnos" },
		{ AL["Trash Mobs"], "SMGTrash" },
	},
	["SMLibrary"] = {
		{ AL["Houndmaster Loksey"], "SMHoundmasterLoksey" },
        { AL["Brother Wystan"], "SMBrotherWystan" },
		{ AL["Arcanist Doan"], "SMDoan" },
		{ AL["Trash Mobs"], "SMLTrash" },
	},
	["SMArmory"] = {
		{ AL["Herod"], "SMHerod" },
        { AL["Armory Quartermaster Daghelm"], "SMQuartermaster" },
		{ AL["Trash Mobs"], "SMATrash" },
	},
	["SMCathedral"] = {
		{ AL["High Inquisitor Fairbanks"], "SMFairbanks" },
		{ AL["Scarlet Commander Mograine"], "SMMograine" },
		{ AL["High Inquisitor Whitemane"], "SMWhitemane" },
		{ AL["Trash Mobs"], "SMCTrash" },
	},
	["Scholomance"] = {
		-- { AL["Blood Steward of Kirtonos"], "SCHOLOBlood" },
		{ AL["Kirtonos the Herald"], "SCHOLOKirtonostheHerald" },
		{ AL["Jandice Barov"], "SCHOLOJandiceBarov" },
		{ AL["Lord Blackwood"].." ("..AL["Scourge Invasion"]..")", "SCHOLOLordBlackwood" },
		{ AL["Rattlegore"], "SCHOLORattlegore" },
		{ AL["Death Knight Darkreaver"], "SCHOLODeathKnight" },
		{ AL["Marduk Blackpool"], "SCHOLOMarduk" },
		{ AL["Vectus"], "SCHOLOVectus" },
		{ AL["Ras Frostwhisper"], "SCHOLORasFrostwhisper" },
		{ AL["Kormok"], "SCHOLOKormok" },
		{ AL["Instructor Malicia"], "SCHOLOInstructorMalicia" },
		{ AL["Doctor Theolen Krastinov"], "SCHOLODoctorTheolenKrastinov" },
		{ AL["Lorekeeper Polkelt"], "SCHOLOLorekeeperPolkelt" },
		{ AL["The Ravenian"], "SCHOLOTheRavenian" },
		{ AL["Lord Alexei Barov"], "SCHOLOLordAlexeiBarov" },
		{ AL["Lady Illucia Barov"], "SCHOLOLadyIlluciaBarov" },
		{ AL["Darkmaster Gandling"], "SCHOLODarkmasterGandling" },
		{ AL["Trash Mobs"], "SCHOLOTrash" },
	},
	["ShadowfangKeep"] = {
		{ AL["Rethilgore"], "SFKRethilgore" },
		{ AL["Fel Steed"], "SFKFelSteed" },
		{ AL["Razorclaw the Butcher"], "SFKRazorclawtheButcher" },
		{ AL["Baron Silverlaine"], "SFKSilverlaine" },
		{ AL["Commander Springvale"], "SFKSpringvale" },
		{ AL["Sever"].." ("..AL["Scourge Invasion"]..")", "SFKSever" },
		{ AL["Odo the Blindwatcher"], "SFKOdotheBlindwatcher" },
		{ AL["Deathsworn Captain"].." ("..AL["Rare"]..")", "SFKDeathswornCaptain" },
		{ AL["Fenrus the Devourer"], "SFKFenrustheDevourer" },
		{ AL["Arugal's Voidwalker"], "SFKArugalsVoidwalker" },
		{ AL["Wolf Master Nandos"], "SFKWolfMasterNandos" },
		{ AL["Archmage Arugal"], "SFKArchmageArugal" },
        { AL["Prelate Ironmane"], "SFKPrelate"},
		{ AL["Trash Mobs"], "SFKTrash" },
	},
	["TheStockade"] = {
		{ AL["Targorr the Dread"], "SWStTargorr" },
		{ AL["Kam Deepfury"], "SWStKamDeepfury" },
		{ AL["Hamhock"], "SWStHamhock" },
		{ AL["Dextren Ward"], "SWStDextren" },
		{ AL["Bazil Thredd"], "SWStBazil" },
		{ AL["Bruegal Ironknuckle"].." ("..AL["Rare"]..")", "SWStBruegalIronknuckle" },
		{ AL["Trash Mobs"], "SWStTrash" },
	},
	["Stratholme"] = {
		{ AL["Skul"].." ("..AL["Rare"]..")", "STRATSkull" },
		{ AL["Stratholme Courier"], "STRATStratholmeCourier" },
		{ AL["Postmaster Malown"], "STRATPostmaster" },
		{ AL["Fras Siabi"], "STRATFrasSiabi" },
		{ AL["Atiesh"], "STRATAtiesh" },
		{ AL["Balzaphon"].." ("..AL["Scourge Invasion"]..")", "STRATBalzaphon" },
		{ AL["Hearthsinger Forresten"].." ("..AL["Rare"]..")", "STRATHearthsingerForresten" },
		{ AL["The Unforgiven"], "STRATTheUnforgiven" },
		{ AL["Timmy the Cruel"], "STRATTimmytheCruel" },
		{ AL["Malor the Zealous"], "STRATMalor" },
		{ AL["Malor's Strongbox"], "STRATMalorsStrongbox" },
		{ AL["Crimson Hammersmith"], "STRATCrimsonHammersmith" },
		{ AL["Cannon Master Willey"], "STRATCannonMasterWilley" },
		{ AL["Archivist Galford"], "STRATArchivistGalford" },
		{ AL["Balnazzar"], "STRATBalnazzar" },
		{ AL["Sothos"].." & "..AL["Jarien"], "STRATSothosJarien" },
		{ AL["Stonespine"].." ("..AL["Rare"]..")", "STRATStonespine" },
		{ AL["Baroness Anastari"], "STRATBaronessAnastari" },
		{ AL["Black Guard Swordsmith"], "STRATBlackGuardSwordsmith" },
		{ AL["Nerub'enkan"], "STRATNerubenkan" },
		{ AL["Maleki the Pallid"], "STRATMalekithePallid" },
		{ AL["Magistrate Barthilas"], "STRATMagistrateBarthilas" },
		{ AL["Ramstein the Gorger"], "STRATRamsteintheGorger" },
		{ AL["Baron Rivendare"], "STRATBaronRivendare" },
		{ AL["Trash Mobs"], "STRATTrash" },
	},
	["SunkenTemple"] = {
		{ AL["Balcony Minibosses"], "STBalconyMinibosses" },
		{ AL["Atal'alarion"], "STAtalalarion" },
		{ AL["Spawn of Hakkar"], "STSpawnOfHakkar" },
		{ AL["Avatar of Hakkar"], "STAvatarofHakkar" },
		{ AL["Jammal'an the Prophet"], "STJammalan" },
		{ AL["Ogom the Wretched"], "STOgom" },
		{ AL["Dreamscythe"], "STDreamscythe" },
		{ AL["Weaver"], "STWeaver"},
		{ AL["Morphaz"], "STMorphaz" },
		{ AL["Hazzas"], "STHazzas" },
		{ AL["Shade of Eranikus"], "STEranikus" },
		{ AL["Trash Mobs"], "STTrash" },
	},
	["Uldaman"] = {
		{ AL["Baelog"], "UldBaelog" },
		{ AL["Olaf"], "UldOlaf" },
		{ AL["Eric 'The Swift'"], "UldEric" },
		{ AL["Revelosh"], "UldRevelosh" },
		{ AL["Ironaya"], "UldIronaya" },
		{ AL["Ancient Stone Keeper"], "UldAncientStoneKeeper" },
		{ AL["Galgann Firehammer"], "UldGalgannFirehammer" },
		{ AL["Grimlok"], "UldGrimlok" },
		{ AL["Archaedas"], "UldArchaedas" },
		{ AL["Trash Mobs"], "UldTrash" },
	},
	["GilneasCity"] = {
		{ AL["Matthias Holtz"], "GCMatthiasHoltz" },
		{ AL["Packmaster Ragetooth"], "GCPackmasterRagetooth" },
		{ AL["Judge Sutherland"], "GCJudgeSutherland" },
		{ AL["Dustivan Blackcowl"], "GCDustivanBlackcowl" },
		{ AL["Marshal Magnus Greystone"], "GCMarshalMagnusGreystone" },
		{ AL["Horsemaster Levvin"], "GCHorsemasterLevvin" },
		{ AL["Harlow Family Chest"], "GCHarlowFamilyChest" },
		{ AL["Genn Greymane"], "GCGennGreymane" },
		{ AL["Trash Mobs"], "GCTrash" },
	},
	["ZulGurub"] = {
		{ AL["High Priestess Jeklik"], "ZGJeklik" },
		{ AL["High Priest Venoxis"], "ZGVenoxis" },
		{ AL["High Priestess Mar'li"], "ZGMarli" },
		{ AL["Bloodlord Mandokir"], "ZGMandokir" },
		{ AL["Gri'lek"], "ZGGrilek" },
		{ AL["Hazza'rah"], "ZGHazzarah" },
		{ AL["Renataki"], "ZGRenataki" },
		{ AL["Wushoolay"], "ZGWushoolay" },
		{ AL["Gahz'ranka"], "ZGGahzranka" },
		{ AL["High Priest Thekal"], "ZGThekal" },
		{ AL["High Priestess Arlokk"], "ZGArlokk" },
		{ AL["Jin'do the Hexxer"], "ZGJindo" },
		{ AL["Hakkar"], "ZGHakkar" },
		{ AL["Random Boss Loot"], "ZGShared" },
		{ AL["Trash Mobs"], "ZGTrash1" },
		{ AL["ZG Enchants"], "ZGEnchants" },
	},
	["BlackfathomDeeps"] = {
		{ AL["Ghamoo-ra"], "BFDGhamoora" },
		{ AL["Lady Sarevess"], "BFDLadySarevess" },
		{ AL["Gelihast"], "BFDGelihast" },
		{ AL["Baron Aquanis"], "BFDBaronAquanis" },
		{ AL["Velthelaxx the Defiler"], "BFDVelthelaxx"},
		{ AL["Twilight Lord Kelris"], "BFDTwilightLordKelris" },
		{ AL["Old Serra'kis"], "BFDOldSerrakis" },
		{ AL["Aku'mai"], "BFDAkumai" },
		{ AL["Trash Mobs"], "BFDTrash" },
	},
	["DireMaulEast"] = {
		{ AL["Pusillin"], "DMEPusillin" },
		{ AL["Zevrim Thornhoof"], "DMEZevrimThornhoof" },
		{ AL["Hydrospawn"], "DMEHydro" },
		{ AL["Lethtendris"], "DMELethtendris" },
		{ AL["Pimgib"], "DMEPimgib" },
		{ AL["Isalien"], "DMEIsalien" },
		{ AL["Alzzin the Wildshaper"], "DMEAlzzin" },
		{ AL["Trash Mobs"], "DMETrash" },
		{ AL["Dire Maul Books"], "DMEBooks" },
	},
	["DireMaulWest"] = {
		{ AL["Tendris Warpwood"], "DMWTendrisWarpwood" },
		{ AL["Illyanna Ravenoak"], "DMWIllyannaRavenoak" },
		{ AL["Magister Kalendris"], "DMWMagisterKalendris" },
		{ AL["Tsu'zee"].." ("..AL["Rare"]..")", "DMWTsuzee" },
		{ AL["Revanchion"].." ("..AL["Scourge Invasion"]..")", "DMWRevanchion" },
		{ AL["Immol'thar"], "DMWImmolthar" },
		{ AL["Lord Hel'nurath"].." ("..AL["Rare"]..")", "DMWHelnurath" },
		{ AL["Prince Tortheldrin"], "DMWPrinceTortheldrin" },
		{ AL["Trash Mobs"], "DMWTrash" },
		{ AL["Dire Maul Books"], "DMWBooks" },
	},
	["DireMaulNorth"] = {
		{ AL["Guard Mol'dar"], "DMNGuardMoldar" },
		{ AL["Stomper Kreeg"], "DMNStomperKreeg" },
		{ AL["Guard Fengus"], "DMNGuardFengus" },
		{ AL["Knot Thimblejack"], "DMNThimblejack" },
		{ AL["Guard Slip'kik"], "DMNGuardSlipkik" },
		{ AL["Captain Kromcrush"], "DMNCaptainKromcrush" },
		{ AL["Cho'Rush the Observer"], "DMNChoRush" },
		{ AL["King Gordok"], "DMNKingGordok" },
		{ AL["Tribute Run"], "DMNTRIBUTERUN" },
		{ AL["Trash Mobs"], "DMNTrash" },
		{ AL["Dire Maul Books"], "DMNBooks" },
	},
	["Maraudon"] = {
		{ AL["Noxxion"], "MaraNoxxion" },
		{ AL["Razorlash"], "MaraRazorlash" },
		{ AL["Lord Vyletongue"], "MaraLordVyletongue" },
		{ AL["Meshlok the Harvester"].." ("..AL["Rare"]..")", "MaraMeshlok" },
		{ AL["Celebras the Cursed"], "MaraCelebras" },
		{ AL["Landslide"], "MaraLandslide" },
		{ AL["Tinkerer Gizlock"], "MaraTinkererGizlock" },
		{ AL["Rotgrip"], "MaraRotgrip" },
		{ AL["Princess Theradras"], "MaraPrincessTheradras" },
		{ AL["Trash Mobs"], "MaraTrash" },
	},
	["Onyxia"] = {
		{ AL["Onyxia"], "Onyxia" },
	},
	["RagefireChasm"] = {
		{ AL["Taragaman the Hungerer"], "RFCTaragaman" },
		{ AL["Oggleflint"], "RFCOggleflint" },
		{ AL["Jergosh the Invoker"], "RFCJergosh" },
		{ AL["Bazzalan"], "RFCBazzalan" },
	},
	["RazorfenDowns"] = {
		{ AL["Tuten'kash"], "RFDTutenkash" },
		{ AL["Lady Falther'ess"].." ("..AL["Scourge Invasion"]..")", "RFDLadyF" },
		{ AL["Plaguemaw the Rotting"], "RFDPlaguemaw" },
		{ AL["Mordresh Fire Eye"], "RFDMordreshFireEye" },
		{ AL["Glutton"], "RFDGlutton" },
		{ AL["Death Prophet Rakameg"], "RFDDeathProphet" },
		{ AL["Ragglesnout"].." ("..AL["Rare"]..")", "RFDRagglesnout" },
		{ AL["Amnennar the Coldbringer"], "RFDAmnennar" },
		{ AL["Trash Mobs"], "RFDTrash" },
	},
	["RazorfenKraul"] = {
		{ AL["Aggem Thorncurse"], "RFKAggem" },
		{ AL["Death Speaker Jargba"], "RFKDeathSpeakerJargba" },
		{ AL["Overlord Ramtusk"], "RFKOverlordRamtusk" },
		{ AL["Razorfen Spearhide"].." ("..AL["Rare"]..")", "RFKRazorfenSpearhide" },
		{ AL["Agathelos the Raging"], "RFKAgathelos" },
		{ AL["Blind Hunter"].." ("..AL["Rare"]..")", "RFKBlindHunter" },
		{ AL["Charlga Razorflank"], "RFKCharlgaRazorflank" },
		{ AL["Earthcaller Halmgar"].." ("..AL["Rare"]..")", "RFKEarthcallerHalmgar" },
		{ AL["Rotthorn"], "RFKRotthorn" },
		{ AL["Trash Mobs"], "RFKTrash" },
	},
	["RuinsofAQ"] = {
		{ AL["Kurinnaxx"], "AQ20Kurinnaxx" },
		{ AL["Lieutenant General Andorov"], "AQ20Andorov" },
		{ AL["Rajaxx's Captains"], "AQ20CAPTAIN" },
		{ AL["General Rajaxx"], "AQ20Rajaxx" },
		{ AL["Moam"], "AQ20Moam" },
		{ AL["Buru the Gorger"], "AQ20Buru" },
		{ AL["Ayamiss the Hunter"], "AQ20Ayamiss" },
		{ AL["Ossirian the Unscarred"], "AQ20Ossirian" },
		{ AL["Trash Mobs"], "AQ20Trash" },
		{ AL["Class Books"], "AQ20ClassBooks" },
		{ AL["AQ Enchants"], "AQ20Enchants" },
	},
	["TempleofAQ"] = {
		{ AL["The Prophet Skeram"], "AQ40Skeram" },
		{ AL["The Bug Family"], "AQ40Trio" },
		{ AL["Battleguard Sartura"], "AQ40Sartura" },
		{ AL["Fankriss the Unyielding"], "AQ40Fankriss" },
		{ AL["Viscidus"], "AQ40Viscidus" },
		{ AL["Princess Huhuran"], "AQ40Huhuran" },
		{ AL["The Twin Emperors"], "AQ40Emperors" },
		{ AL["Ouro"], "AQ40Ouro" },
		{ AL["C'Thun"], "AQ40CThun" },
		{ AL["Trash Mobs"], "AQ40Trash1" },
		{ AL["Trash Mobs"], "AQ40Trash2" },
		{ AL["AQ Enchants"], "AQEnchants" },
		{ AL["AQ Opening Quest Chain"], "AQOpening" },
	},
	["WailingCaverns"] = {
		{ AL["Lord Cobrahn"], "WCLordCobrahn" },
		{ AL["Lady Anacondra"], "WCLadyAnacondra" },
		{ AL["Kresh"], "WCKresh" },
		{ AL["Deviate Faerie Dragon"].." ("..AL["Rare"]..")", "WCDeviateFaerieDragon" },
        { AL["Zandara Windhoof"], "WCZandara" },
		{ AL["Lord Pythas"], "WCLordPythas" },
		{ AL["Skum"], "WCSkum" },
        { AL["Vangros"], "WCVangros" },
		{ AL["Lord Serpentis"], "WCLordSerpentis" },
		{ AL["Verdan the Everliving"], "WCVerdan" },
		{ AL["Mutanus the Devourer"], "WCMutanus" },
		{ AL["Trash Mobs"], "WCTrash" },
	},
	["ZulFarrak"] = {
		{ AL["Antu'sul"], "ZFAntusul" },
		{ AL["Witch Doctor Zum'rah"], "ZFWitchDoctorZumrah" },
		{ AL["Shadowpriest Sezz'ziz"], "ZFSezzziz" },
		{ AL["Dustwraith"].." ("..AL["Rare"]..")", "ZFDustwraith" },
		{ AL["Zerillis"].." ("..AL["Rare"]..")", "ZFZerillis" },
		{ AL["Gahz'rilla"], "ZFGahzrilla" },
		{ AL["Chief Ukorz Sandscalp"], "ZFChiefUkorzSandscalp" },
		{ AL["Zel'jeb the Ancient"], "ZFZeljeb" },
		{ AL["Champion Razjal the Quick"], "ZFChampion" },
		{ AL["Trash Mobs"], "ZFTrash" },
	},
	["EmeraldSanctum"] = {
		{ AL["Erennius"], "ESErennius" },
		{ AL["Solnius the Awakener"], "ESSolnius1" },
		{ AL["Favor of Erennius (ES Hard Mode)"], "ESHardMode" },
		{ AL["Trash Mobs"], "ESTrash" },
	},
	["LowerKara"] = {
		{ AL["Master Blacksmith Rolfen"], "LKHRolfen" },
		{ AL["Brood Queen Araxxna"], "LKHBroodQueenAraxxna" },
		{ AL["Grizikil"], "LKHGrizikil" },
		{ AL["Clawlord Howlfang"], "LKHClawlordHowlfang" },
		{ AL["Lord Blackwald II"], "LKHLordBlackwaldII" },
		{ AL["Moroes"], "LKHMoroes" },
		{ AL["Trash Mobs"], "LKHTrash" },
		{ AL["LKH Enchants"], "LKHEnchants" },
	},
    ["UpperKara"] = {
		{ AL["Keeper Gnarlmoon"], "UKHGnarlmoon" },
		{ AL["Ley-Watcher Incantagos"], "UKHIncantagos" },
		{ AL["Anomalus"], "UKHAnomalus" },
		{ AL["Echo of Medivh"], "UKHEcho" },
		{ AL["King (Chess fight)"], "UKHKing" },
		{ AL["Sanv Tas'dal"], "UKHSanvTasdal" },
		{ AL["Kruul"], "UKHKruul" },
		{ AL["Rupturan the Broken"], "UKHRupturan" },
		{ AL["Mephistroth"], "UKHMephistroth" },
		{ AL["Trash Mobs"], "UKHTrash" },
	},
	["WorldBosses"] = {
		{ AL["Azuregos"], "AAzuregos" },
		{ AL["Emeriss"], "DEmeriss" },
		{ AL["Lethon"], "DLethon"},
		{ AL["Taerar"], "DTaerar" },
		{ AL["Ysondre"], "DYsondre" },
		{ AL["Lord Kazzak"], "KKazzak"},
		{ AL["Nerubian Overseer"], "Nerubian" },
		{ AL["Dark Reaver of Karazhan"], "Reaver" },
		{ AL["Ostarius"], "Ostarius" },
		{ AL["Concavius"], "Concavius" },
		{ AL["Moo"], "CowKing" },
		{ AL["Cla'ckora"], "Clackora" },
	},
	["RareSpawns"] = {
        { WHITE.."[17]"..DEFAULT.." "..AL["Earthcaller Rezengal"]   .." "..WHITE.."("..AL["Stonetalon Mountains"]..")", "EarthcallerRezengal" },
        { WHITE.."[17]"..DEFAULT.." "..AL["Shade Mage"]             .." "..WHITE.."("..AL["Tirisfal Glades"]     ..")", "ShadeMage" },
        { WHITE.."[18]"..DEFAULT.." "..AL["Graypaw Alpha"]          .." "..WHITE.."("..AL["Tirisfal Glades"]     ..")", "GraypawAlpha" },
        { WHITE.."[24]"..DEFAULT.." "..AL["Blazespark"]             .." "..WHITE.."("..AL["Stonetalon Mountains"]..")", "Blazespark" },
        { WHITE.."[35]"..DEFAULT.." "..AL["Witch Doctor Tan'zo"]    .." "..WHITE.."("..AL["Arathi Highlands"]    ..")", "WitchDoctorTanzo" },
        { WHITE.."[40]"..DEFAULT.." "..AL["Widow of the Woods"]     .." "..WHITE.."("..AL["Gilneas"]             ..")", "WidowoftheWoods" },
        { WHITE.."[40]"..DEFAULT.." "..AL["Dawnhowl"]               .." "..WHITE.."("..AL["Gilneas"]             ..")", "Dawnhowl" },
        { WHITE.."[43]"..DEFAULT.." "..AL["Maltimor's Prototype"]   .." "..WHITE.."("..AL["Gilneas"]             ..")", "MaltimorsPrototype" },
        { WHITE.."[44]"..DEFAULT.." "..AL["Bonecruncher"]           .." "..WHITE.."("..AL["Gilneas"]             ..")", "Bonecruncher" },
        { WHITE.."[44]"..DEFAULT.." "..AL["Duskskitter"]            .." "..WHITE.."("..AL["Gilneas"]             ..")", "Duskskitter" },
        { WHITE.."[45]"..DEFAULT.." "..AL["Baron Perenolde"]        .." "..WHITE.."("..AL["Gilneas"]             ..")", "BaronPerenolde" },
        { WHITE.."[45]"..DEFAULT.." "..AL["Kin'Tozo"]               .." "..WHITE.."("..AL["Stranglethorn Vale"]  ..")", "KinTozo" },
        { WHITE.."[47]"..DEFAULT.." "..AL["Grug'thok the Seer"]     .." "..WHITE.."("..AL["Feralas"]             ..")", "Grugthok" },
        { WHITE.."[47]"..DEFAULT.." "..AL["M-0L1Y"]                 .." "..WHITE.."("..AL["Dun Morogh"]          ..")", "M0L1Y" },
        { WHITE.."[49]"..DEFAULT.." "..AL["Explorer Ashbeard"]      .." "..WHITE.."("..AL["Searing Gorge"]       ..")", "Ashbeard" },
        { WHITE.."[50]"..DEFAULT.." "..AL["Jal'akar"]               .." "..WHITE.."("..AL["Hinterlands"]         ..")", "Jalakar" },
        { WHITE.."[51]"..DEFAULT.." "..AL["Embereye"]               .." "..WHITE.."("..AL["Gilijim Isle"]        ..")", "Embereye" },
        { WHITE.."[51]"..DEFAULT.." "..AL["Ruk'thok the Pyromancer"].." "..WHITE.."("..AL["Lapidis Isle"]        ..")", "Rukthok" },
        { WHITE.."[51]"..DEFAULT.." "..AL["Tarangos"]               .." "..WHITE.."("..AL["Azshara"]             ..")", "Tarangos" },
        { WHITE.."[51]"..DEFAULT.." "..AL["Ripjaw"]                 .." "..WHITE.."("..AL["Lapidis Isle"]        ..")", "Ripjaw" },
        { WHITE.."[53]"..DEFAULT.." "..AL["Xalvic Blackclaw"]       .." "..WHITE.."("..AL["Felwood"]             ..")", "Xalvic" },
        { WHITE.."[54]"..DEFAULT.." "..AL["Aquitus"]                .." "..WHITE.."("..AL["Gilijim Isle"]        ..")", "Aquitus" },
        { WHITE.."[55]"..DEFAULT.." "..AL["Firstborn of Arugal"]    .." "..WHITE.."("..AL["Gilneas"]             ..")", "FirstbornofArugal" },
        { WHITE.."[55]"..DEFAULT.." "..AL["Letashaz"]               .." "..WHITE.."("..AL["Gilijim Isle"]        ..")", "Letashaz" },
        { WHITE.."[55]"..DEFAULT.." "..AL["Margon the Mighty"]      .." "..WHITE.."("..AL["Lapidis Isle"]        ..")", "MargontheMighty" },
        { WHITE.."[55]"..DEFAULT.." "..AL["The Wandering Knight"]   .." "..WHITE.."("..AL["Western Plaguelands"] ..")", "WanderingKnight" },
        { WHITE.."[56]"..DEFAULT.." "..AL["Stoneshell"]             .." "..WHITE.."("..AL["Tel'abim"]            ..")", "Stoneshell" },
        { WHITE.."[57]"..DEFAULT.." "..AL["Zareth Terrorblade"]     .." "..WHITE.."("..AL["Blasted Lands"]       ..")", "Zareth" },
        { WHITE.."[58]"..DEFAULT.." "..AL["Highvale Silverback"]    .." "..WHITE.."("..AL["Tel'abim"]            ..")", "HighvaleSilverback" },
        { WHITE.."[58]"..DEFAULT.." "..AL["Mallon The Moontouched"] .." "..WHITE.."("..AL["Winterspring"]        ..")", "Mallon" },
        { WHITE.."[59]"..DEFAULT.." "..AL["Blademaster Kargron"]    .." "..WHITE.."("..AL["Burning Steppes"]     ..")", "Kargron" },
        { WHITE.."[59]"..DEFAULT.." "..AL["Professor Lysander"]     .." "..WHITE.."("..AL["Eastern Plaguelands"] ..")", "ProfessorLysander" },
        { WHITE.."[60]"..DEFAULT.." "..AL["Admiral Barean Westwind"].." "..WHITE.."("..AL["Scarlet Enclave"]     ..")", "AdmiralBareanWestwind" },
        { WHITE.."[60]"..DEFAULT.." "..AL["Azurebeak"]              .." "..WHITE.."("..AL["Hyjal"]               ..")", "Azurebeak" },
        { WHITE.."[60]"..DEFAULT.." "..AL["Barkskin Fisher"]        .." "..WHITE.."("..AL["Hyjal"]               ..")", "BarkskinFisher" },
        { WHITE.."[61]"..DEFAULT.." "..AL["Crusader Larsarius"]     .." "..WHITE.."("..AL["Eastern Plaguelands"] ..")", "CrusaderLarsarius" },
        { WHITE.."[61]"..DEFAULT.." "..AL["Shadeflayer Goliath"]    .." "..WHITE.."("..AL["Hyjal"]               ..")", "ShadeflayerGoliath" },
	},
	["DragonmawRetreat"] = {
		{ AL["Gowlfang"], "DMRGowlfang" },
		{ AL["Cavernweb Broodmother"], "DMRBroodmother" },
		{ AL["Web Master Torkon"], "DMRWebMaster" },
		{ AL["Garlok Flamekeeper"], "DMRGarlok" },
		{ AL["Halgan Redbrand"], "DMRHalgan" },
		{ AL["Slagfist Destroyer"],"DMRSlagfist" },
		{ AL["Overlord Blackheart"], "DMROverlord" },
		{ AL["Elder Hollowblood"], "DMRElderHollowblood" },
		{ AL["Searistrasz"], "DMRSearistrasz" },
		{ AL["Zuluhed the Whacked"], "DMRZuluhed" },
		{ AL["Trash Mobs"], "DMRTrash" },
	},
	["StormwroughtRuins"] = {
		{ AL["Oronok Torn-Heart"], "SWROronok" },
		{ AL["Dagar the Glutton"], "SWRDagar" },
		{ AL["Duke Balor the IV"], "SWRDukeBalor" },
		{ AL["Librarian Theodorus"], "SWRLibrarian" },
		{ AL["Chieftain Stormsong"], "SWRChieftain" },
		{ AL["Deathlord Tidebane"], "SWRDeathlord" },
		{ AL["Subjugator Halthas Shadecrest"], "SWRSubjugator" },
		{ AL["Mycellakos"], "SWRMycellakos" },
		{ AL["Eldermaw the Primordial"], "SWREldermaw" },
		{ AL["Lady Drazare"], "SWRLadyDrazare" },
		{ AL["Remains of the Innocent"], "SWRRemains" },
		{ AL["Mergothid"], "SWRMergothid" },
		{ AL["Trash Mobs"], "SWRTrash" },
	},
};

--------------------------------------------------------------------------------
-- Item OnEnter
-- Called when a loot item is moused over
--------------------------------------------------------------------------------
local stringArgs = {}
local messageShown = false
function AtlasLootItem_OnEnter()
	local isItem, isEnchant, isSpell;
	local buttonID = this:GetID()
	AtlasLootTooltip:ClearLines();
	for i = 1, 30, 1 do
		if ( _G["AtlasLootTooltipTextRight"..i] ) then
			_G["AtlasLootTooltipTextRight"..i]:SetText("");
		end
	end
	if ( not ( this.itemID and this.itemID ~= 0 ) ) then
		return
	end
	if ( string.sub(this.itemID, 1, 1) == "s" ) then
		isItem = false;
		isEnchant = false;
		isSpell = true;
	elseif ( string.sub(this.itemID, 1, 1) == "e" ) then
		isItem = false;
		isEnchant = true;
		isSpell = false;
	else
		isItem = true;
		isEnchant = false;
		isSpell = false;
	end
	if ( isItem ) then
		local color = strsub(_G["AtlasLootItem_"..buttonID.."_Name"]:GetText(), 3, 10);
		local name = strsub(_G["AtlasLootItem_"..buttonID.."_Name"]:GetText(), 11);
		-- Lootlink tooltips
		if ( AtlasLootCharDB.LootlinkTT ) then
			-- If we have seen the item, use the game tooltip to minimise same name item problems
			if ( GetItemInfo(this.itemID) ) then
				_G[this:GetName().."_Unsafe"]:Hide();
				AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
				AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0");
				if ( AtlasLootCharDB.ItemIDs ) then
					AtlasLootTooltip:AddLine(AL["ItemID:"].." "..this.itemID, nil, nil, nil, 1);
				end
				if ( this.droprate ) then
					AtlasLootTooltip:AddLine(AL["Drop Rate: "]..this.droprate, 1, 1, 0);
				end
				AtlasLootTooltip:Show();
				if ( LootLink_AddItem ) then
					LootLink_AddItem(name, this.itemID..":0:0:0", color);
				end
			else
				AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
				if ( LootLink_Database and LootLink_Database[this.itemID] ) then
					LootLink_SetTooltip(AtlasLootTooltip, LootLink_Database[this.itemID][1], 1);
				else
					LootLink_SetTooltip(AtlasLootTooltip,strsub(_G["AtlasLootItem_"..buttonID.."_Name"]:GetText(), 11), 1);
				end
				if ( AtlasLootCharDB.ItemIDs ) then
					AtlasLootTooltip:AddLine(AL["ItemID:"].." "..this.itemID, nil, nil, nil, 1);
				end
				if ( this.droprate ) then
					AtlasLootTooltip:AddLine(AL["Drop Rate: "]..this.droprate, 1, 1, 0, 1);
				end
				AtlasLootTooltip:AddLine(" ");
				AtlasLootTooltip:AddLine(AL["You can right-click to attempt to query the server.  You may be disconnected."], nil, nil, nil, 1);
				AtlasLootTooltip:Show();
			end
		-- Item Sync tooltips
		elseif ( AtlasLootCharDB.ItemSyncTT ) then
			if ( GetItemInfo(this.itemID) ) then
				_G[this:GetName().."_Unsafe"]:Hide();
			end
			ItemSync:ButtonEnter();
			if ( AtlasLootCharDB.ItemIDs ) then
				GameTooltip:AddLine(AL["ItemID:"].." "..this.itemID, nil, nil, nil, 1);
			end
			if ( this.droprate ) then
				GameTooltip:AddLine(AL["Drop Rate: "]..this.droprate, 1, 1, 0);
			end
			GameTooltip:Show();
		-- Default game tooltips
		else
			if ( not this.itemID ) then
				return
			end
			AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
			if ( GetItemInfo(this.itemID) ) then
				_G[this:GetName().."_Unsafe"]:Hide();
				AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0");
			else
				-- AtlasLoot_QueryLootPage()
				AtlasLootTooltip:SetText(AL["Retrieving item information"], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
				_G["AtlasLootItem_"..buttonID.."_Unsafe"]:Hide();
			end
			if ( AtlasLootCharDB.ItemIDs ) then
				AtlasLootTooltip:AddLine(AL["ItemID:"].." "..this.itemID, nil, nil, nil, 1);
			end
			if ( this.droprate ) then
				AtlasLootTooltip:AddLine(AL["Drop Rate: "]..this.droprate, 1, 1, 0);
			end
			AtlasLootTooltip:Show();
		end
	elseif ( isEnchant ) then
		local spellID = tonumber(string.sub(this.itemID, 2));
		AtlasLootTooltip:SetOwner(this, "ANCHOR_NONE");
		AtlasLootTooltip:SetPoint("BOTTOMLEFT", this, "TOPRIGHT", -(this:GetWidth() / 2), 24)
		AtlasLootTooltip:ClearLines();
		if ( SetAutoloot == nil or (SUPERWOW_VERSION and (tonumber(SUPERWOW_VERSION)) >= 1.2) ) then
			AtlasLootTooltip:SetHyperlink("enchant:"..spellID)
		else
			AtlasLootTooltip:SetHyperlink("spell:"..spellID);
			if ( not messageShown ) then
				DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..WHITE.."Old version of SuperWoW detected, please download the latest version from https://github.com/balakethelock/SuperWoW/releases/tag/Release")
				messageShown = true
			end
		end
		local _, _, longCooldown = strfind(AtlasLootTooltipTextRight2:GetText() or "", gsub(SPELL_RECAST_TIME_MIN, "%%%.3g", "(.+)"))
		if ( longCooldown and strfind(longCooldown, "e%+") ) then
			longCooldown = tonumber(longCooldown) / 60 / 24
			if ( longCooldown > 1 ) then
				longCooldown = format(AL.DAYS_COOLDOWN, longCooldown)
			else
				longCooldown = format(AL.DAYS_COOLDOWN_1, longCooldown)
			end
			AtlasLootTooltipTextRight2:SetText(longCooldown)
		end
		if ( AtlasLootCharDB.ItemIDs ) then
			AtlasLootTooltip:AddLine(AL["SpellID:"].." "..spellID, nil, nil, nil, 1);
		end
		AtlasLootTooltip:Show();
		local item = tonumber(GetSpellInfoAtlasLootDB["enchants"][spellID]["item"])
		local extra = GetSpellInfoAtlasLootDB["enchants"][spellID]["extra"]
		if ( not ( item and item ~= 0 ) ) then
			return
		end
		AtlasLootTooltip2:SetOwner(this, "ANCHOR_NONE");
		AtlasLootTooltip2:SetPoint("TOPLEFT", AtlasLootTooltip, "BOTTOMLEFT", 0, 0)
		AtlasLootTooltip2:ClearLines();
		if ( not GetItemInfo(item) ) then
			AtlasLootTooltip2:SetText(AL["Retrieving item information"], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
		else
			AtlasLootTooltip2:SetHyperlink("item:"..item);
			if ( extra ) then
				AtlasLootTooltip2:AddLine(extra, 1, 1, 1, 1);
			end
		end
		if ( AtlasLootCharDB.ItemIDs ) then
			AtlasLootTooltip2:AddLine(AL["ItemID:"].." "..item, nil, nil, nil, 1);
		end
		AtlasLootTooltip2:Show();
		-- Reposition if tooltips overlap
		local bottom = AtlasLootTooltip:GetBottom()
		local top = AtlasLootTooltip2:GetTop()
		if ( top and bottom and bottom < top ) then
			AtlasLootTooltip2:ClearAllPoints()
			AtlasLootTooltip2:SetPoint("TOPLEFT", this, "TOPRIGHT", -(this:GetWidth() / 2), 24)
			AtlasLootTooltip:ClearAllPoints()
			AtlasLootTooltip:SetPoint("BOTTOMLEFT", AtlasLootTooltip2, "TOPLEFT", 0, 0)
		end
	elseif ( isSpell ) then
		local spellID = tonumber(string.sub(this.itemID, 2));
		AtlasLootTooltip:SetOwner(this, "ANCHOR_NONE");
		AtlasLootTooltip:SetPoint("BOTTOMLEFT", this, "TOPRIGHT", -(this:GetWidth() / 2), 24)
		AtlasLootTooltip:ClearLines();
		if ( SpellInfo ) then
			AtlasLootTooltip:SetHyperlink("enchant:"..spellID)
			local _, _, longCooldown = strfind(AtlasLootTooltipTextRight2:GetText() or "", gsub(SPELL_RECAST_TIME_MIN, "%%%.3g", "(.+)"))
			if ( longCooldown and strfind(longCooldown, "e%+") ) then
				longCooldown = tonumber(longCooldown) / 60 / 24
				if ( longCooldown > 1 ) then
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
			if ( castTime < 60 ) then
				castTime = format(SPELL_CAST_TIME_SEC, castTime)
			else
				castTime = format(SPELL_CAST_TIME_MIN, castTime / 60)
			end
			if ( cooldown ) then
				if ( cooldown < 86400 ) then
					if ( cooldown < 60 ) then
						cooldown = format(SPELL_RECAST_TIME_SEC, cooldown)
					else
						cooldown = format(SPELL_RECAST_TIME_MIN, cooldown / 60)
					end
				elseif ( cooldown / 60 / 60 / 24 == 1 ) then
					cooldown = format(AL.DAYS_COOLDOWN_1, cooldown / 60 / 60 / 24)
				else
					cooldown = format(AL.DAYS_COOLDOWN, cooldown / 60 / 60 / 24)
				end
				AtlasLootTooltip:AddDoubleLine(castTime, cooldown, 1, 1, 1, 1, 1, 1)
			else
				AtlasLootTooltip:AddLine(castTime, 1, 1, 1)
			end
			if ( type(tools) == "table" ) then
				for i = getn(stringArgs), 1, -1 do
					tremove(stringArgs, i)
				end
				for j = 1, getn(tools) do
					if ( AtlasLoot_CacheItem(tools[j]) == false ) then
						AtlasLootItemsFrame.refreshTime = refreshTimeout
						AtlasLootItemsFrame.queue[tools[j]] = true
					end
					tinsert(stringArgs, (GetItemInfo(tools[j]) or ""))
					tinsert(stringArgs, AtlasLoot_CheckBagsForItems(tools[j]))
				end
				AtlasLootTooltip:AddLine(SPELL_TOTEMS..BuildColoredListString(unpack(stringArgs)), 1, 1, 1, false)
			end
			if ( type(reagents) == "table" ) then
				for i = getn(stringArgs), 1, -1 do
					tremove(stringArgs, i)
				end
				for j = 1, getn(reagents) do
					if ( reagents[j][2] and reagents[j][2] > 1 ) then
						if ( AtlasLoot_CacheItem(reagents[j][1]) == false ) then
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
			if ( text ) then
				AtlasLootTooltip:AddLine(text, 1, 0.82, 0, true)
			end
		end
		if ( AtlasLootCharDB.ItemIDs ) then
			AtlasLootTooltip:AddLine(AL["SpellID:"].." "..spellID, nil, nil, nil, 1);
		end
		AtlasLootTooltip:Show();
		local craftItem = tonumber(GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftItem"])
		local extra = GetSpellInfoAtlasLootDB["craftspells"][spellID]["extra"]
		if ( not ( craftItem and craftItem ~= 0 ) ) then
			return
		end
		AtlasLootTooltip2:SetOwner(this, "ANCHOR_NONE");
		AtlasLootTooltip2:SetPoint("TOPLEFT", AtlasLootTooltip, "BOTTOMLEFT", 0, 0)
		AtlasLootTooltip2:ClearLines();
		if ( not GetItemInfo(craftItem) ) then
			AtlasLootTooltip2:SetText(AL["Retrieving item information"], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
		else
			AtlasLootTooltip2:SetHyperlink("item:"..craftItem);
			if ( extra ) then
				AtlasLootTooltip2:AddLine(extra, 1, 1, 1, 1);
			end
		end
		if ( AtlasLootCharDB.ItemIDs ) then
			AtlasLootTooltip2:AddLine(AL["ItemID:"].." "..craftItem, nil, nil, nil, 1);
		end
		AtlasLootTooltip2:Show();
		-- Reposition if tooltips overlap
		local bottom = AtlasLootTooltip:GetBottom()
		local top = AtlasLootTooltip2:GetTop()
		if ( bottom and top and bottom < top ) then
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
	AtlasLootTooltip:Hide();
	AtlasLootTooltip2:Hide();
	GameTooltip:Hide();
	ShoppingTooltip1:Hide();
	ShoppingTooltip2:Hide();
end

--------------------------------------------------------------------------------
-- Item OnClick
-- Called when a loot item is clicked on
--------------------------------------------------------------------------------
function AtlasLootItem_OnClick(arg1)
	local isItem, isEnchant, isSpell;
	local _, _, color = strfind(_G["AtlasLootItem_"..this:GetID().."_Name"]:GetText(), "(|cff%x%x%x%x%x%x)");
	color = color or NORMAL_FONT_COLOR_CODE
	local id = this:GetID();
	local name = _G["AtlasLootItem_"..this:GetID().."_Name"]:GetText();
	local _, _, texture = strfind(_G["AtlasLootItem_"..this:GetID().."_Icon"]:GetTexture() or "", ".+\\(.+)$")
    texture = texture or "INV_Misc_QuestionMark"
	local dataID = AtlasLootItemsFrame.refresh[1]
	local dataSource = AtlasLootItemsFrame.refresh[2]
	local bossName = AtlasLootItemsFrame.refresh[3]
	local framePoint = AtlasLootItemsFrame.refresh[4]
	if ( string.sub(this.itemID, 1, 1) == "s" ) then
		isItem = false;
		isEnchant = false;
		isSpell = true;
	elseif ( string.sub(this.itemID, 1, 1) == "e" ) then
		isItem = false;
		isEnchant = true;
		isSpell = false;
	else
		isItem = true;
		isEnchant = false;
		isSpell = false;
	end
	if ( isItem ) then
		local itemName, itemLink = GetItemInfo(this.itemID);
		-- If shift-clicked, link in the chat window
		if ( AtlasFrame and AtlasFrame:IsVisible() and arg1 == "RightButton" ) then
			_G["AtlasLootItem_"..id.."_Unsafe"]:Hide();
		elseif ( arg1 == "RightButton" and not itemName and this.itemID ~= 0 ) then
			AtlasLootTooltip:SetHyperlink("item:"..this.itemID);
			if ( not AtlasLootCharDB.ItemSpam ) then
				DEFAULT_CHAT_FRAME:AddMessage(AL["Server queried for "]..color.."["..name.."]".."|r"..AL[".  Right click on any other item to refresh the loot page."]);
			end
			AtlasLootItemsFrame:Hide();
			AtlasLoot_ShowItemsFrame(dataID, dataSource, bossName, framePoint);
		elseif ( arg1 == "RightButton" and itemName ) then
			AtlasLootItemsFrame:Hide();
			AtlasLoot_ShowItemsFrame(dataID, dataSource, bossName, framePoint);
			if ( not AtlasLootCharDB.ItemSpam ) then
				DEFAULT_CHAT_FRAME:AddMessage(itemName..AL[" is safe."]);
				DEFAULT_CHAT_FRAME:AddMessage(AtlasLootItemsFrame.activeBoss)
			end
		elseif ( IsShiftKeyDown() and not itemName and this.itemID ~= 0 ) then
			if ( AtlasLootCharDB.SafeLinks ) then
				if ( WIM_EditBoxInFocus ) then
					WIM_EditBoxInFocus:Insert("["..name.."]");
				elseif ( ChatFrameEditBox:IsVisible() ) then
					ChatFrameEditBox:Insert("["..name.."]");
				else
					AtlasLoot_SayItemReagents(this.itemID, nil, name, true)
				end
			elseif ( AtlasLootCharDB.AllLinks ) then
				if ( WIM_EditBoxInFocus ) then
					WIM_EditBoxInFocus:Insert(color.."|Hitem:"..this.itemID.."|h["..name.."]|h|r");
				elseif ( ChatFrameEditBox:IsVisible() ) then
					ChatFrameEditBox:Insert(color.."|Hitem:"..this.itemID.."|h["..name.."]|h|r");
				else
					AtlasLoot_SayItemReagents(this.itemID, color, name)
				end
			end
		elseif ( (itemName and IsShiftKeyDown()) and this.itemID ~= 0 ) then
			if ( WIM_EditBoxInFocus ) then
				WIM_EditBoxInFocus:Insert(color.."|Hitem:"..this.itemID..":0:0:0|h["..name.."]|h|r");
			elseif ( ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:Insert(color.."|Hitem:"..this.itemID..":0:0:0|h["..name.."]|h|r");
			end
		elseif ( IsShiftKeyDown() and itemName and this.itemID ~= 0 ) then
			AtlasLoot_SayItemReagents(this.itemID, color, name);
		-- If control-clicked, use the dressing room
		elseif ( IsControlKeyDown() and itemName ) then
			DressUpItemLink(itemLink);
		elseif ( IsAltKeyDown() and (this.itemID ~= 0) ) then
			if ( dataID == "WishList" ) then
				AtlasLoot_DeleteFromWishList(this.itemID);
			elseif ( dataID == "SearchResult" ) then
				AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(this.itemID));
			else
				AtlasLoot_AddToWishlist(this.itemID, texture, this.itemIDName, this.itemIDExtra, dataID.."|"..dataSource);
			end
		elseif ( (dataID == "SearchResult" or dataID == "WishList") and this.sourcePage ) then
			local _, _, dataID, dataSource = strfind(this.sourcePage, "(.+)|(.+)");
			if ( dataID and dataSource and AtlasLoot_IsLootTableAvailable(dataID) ) then
				AtlasLoot_ShowItemsFrame(dataID, dataSource, AtlasLoot_TableNames[dataID][1], framePoint);
			end
		elseif ( this.container and arg1 == "LeftButton" ) then
			AtlasLoot_ShowContainerFrame()
		end
	elseif ( isEnchant ) then
		if ( IsShiftKeyDown() ) then
			AtlasLoot_SayItemReagents(this.itemID, color, name)
		elseif ( IsAltKeyDown() and (this.itemID ~= 0) ) then
			if ( dataID == "WishList" ) then
				AtlasLoot_DeleteFromWishList(this.itemID);
			elseif ( dataID == "SearchResult" ) then
				AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(this.itemID));
			else
				AtlasLoot_AddToWishlist(this.itemID, texture, this.itemIDName, this.itemIDExtra, dataID.."|"..dataSource);
			end
		elseif ( IsControlKeyDown() ) then
			DressUpItemLink("item:"..this.dressingroomID..":0:0:0");
		elseif ( (dataID == "SearchResult" or dataID == "WishList") and this.sourcePage ) then
			local _, _, dataID, dataSource = strfind(this.sourcePage, "(.+)|(.+)");
			if ( dataID and dataSource and AtlasLoot_IsLootTableAvailable(dataID) ) then
				AtlasLoot_ShowItemsFrame(dataID, dataSource, bossName, framePoint);
			end
		end
	elseif ( isSpell ) then
		if ( IsShiftKeyDown() ) then
			local spellID = tonumber(string.sub(this.itemID, 2))
			local craftitem = tonumber(GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftItem"])
			local craftname = GetItemInfo(craftitem or 0)
			if ( WIM_EditBoxInFocus ) then
				if ( craftitem and craftitem ~= 0 ) then
					WIM_EditBoxInFocus:Insert(color.."|Hitem:"..craftitem..":0:0:0|h["..craftname.."]|h|r");
				else
					WIM_EditBoxInFocus:Insert(color.."|Henchant:"..spellID.."|h["..name.."]|h|r");
				end
			elseif ( ChatFrameEditBox:IsVisible() ) then
				if ( craftitem and craftitem ~= 0 ) then
					ChatFrameEditBox:Insert(color.."|Hitem:"..craftitem..":0:0:0|h["..craftname.."]|h|r"); -- Fix for Gurky's discord chat bot
				else
					ChatFrameEditBox:Insert(color.."|Henchant:"..spellID.."|h["..name.."]|h|r");
				end
			else
				AtlasLoot_SayItemReagents(this.itemID, color, name)
			end
		elseif ( IsAltKeyDown() and (this.itemID ~= 0) ) then
			if ( dataID == "WishList" ) then
				AtlasLoot_DeleteFromWishList(this.itemID);
			elseif ( dataID == "SearchResult" ) then
				AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(this.itemID));
			else
				AtlasLoot_AddToWishlist(this.itemID, texture, this.itemIDName, this.itemIDExtra, dataID.."|"..dataSource);
			end
		elseif ( IsControlKeyDown() ) then
			DressUpItemLink("item:"..this.dressingroomID..":0:0:0");
		elseif ( (dataID == "SearchResult" or dataID == "WishList") and this.sourcePage ) then
			local _, _, dataID, dataSource = strfind(this.sourcePage, "(.+)|(.+)");
			if ( dataID and dataSource and AtlasLoot_IsLootTableAvailable(dataID) ) then
				AtlasLoot_ShowItemsFrame(dataID, dataSource, bossName, framePoint);
			end
		end
	end
end

-- retun true if item is cached, false if argument is a valid link or id, but its not cahced yet, nil otherwise
function AtlasLoot_CacheItem(linkOrID)
	if ( not linkOrID or linkOrID == 0 ) then
		return nil
	end
	if ( tonumber(linkOrID )) then
		if GetItemInfo(linkOrID) then
			return true
		else
			GameTooltip:SetHyperlink("item:"..linkOrID)
			return false
		end
	else
		if ( type(linkOrID) ~= "string" ) then
			return nil
		end
		local _, _, item = strfind(linkOrID, "(item:%d+:%d+:%d+:%d+)")
		if ( item ) then
			if ( GetItemInfo(item) ) then
				return true
			else
				GameTooltip:SetHyperlink(item)
				return false
			end
		end
	end
end

local containerItemFrames = {}
local lastSelectedButton
function AtlasLoot_ShowContainerFrame()
	local containerTable = this.container
	if ( not containerTable ) then
		return
	end
	if ( this ~= lastSelectedButton ) then
		AtlasLootItemsFrameContainer:Show()
		lastSelectedButton = this
	elseif ( AtlasLootItemsFrameContainer:IsVisible() ) then
		AtlasLootItemsFrameContainer:Hide()
		lastSelectedButton = nil
		return
	end
	if ( not AtlasLootItemsFrameContainer:IsVisible() and lastSelectedButton == this ) then
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
			if ( not containerItemFrames[buttonIndex] ) then
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
			if ( quality ) then
				r, g, b  = GetItemQualityColor(quality)
			end
			if ( not tex ) then
				tex = "Interface\\Icons\\INV_Misc_QuestionMark"
			end
			itemButton:SetPoint("TOPLEFT", AtlasLootItemsFrameContainer, (col * 35) + 5, -(row * 35) - 5)
			itemButton:SetBackdropBorderColor(r, g, b)
			itemButton:SetID(itemID)
			itemButton:Show()
			icon:SetTexture(tex)
			AtlasLoot_AddContainerItemTooltip(itemButton, itemID)
			col = col + 1
			if ( col > maxCols ) then
				maxCols = col
			end
			buttonIndex = buttonIndex + 1
		end
		row = row + 1
	end
	AtlasLootItemsFrameContainer:SetPoint("TOPLEFT", this , "BOTTOMLEFT", -2, 2)
	AtlasLootItemsFrameContainer:SetWidth(16 + (maxCols * 35))
	AtlasLootItemsFrameContainer:SetHeight(16 + (row * 35))
end

function AtlasLoot_AddContainerItemTooltip(frame ,itemID)
	frame:SetScript("OnEnter", function()
        AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 4), -(this:GetHeight() / 4))
        AtlasLootTooltip:SetHyperlink("item:"..tostring(itemID))
        AtlasLootTooltip.itemID = itemID
        local numLines = AtlasLootTooltip:NumLines()
		if ( AtlasLootCharDB.ItemIDs ) then
			if ( numLines and numLines > 0 ) then
				local lastLine = _G["AtlasLootTooltipTextLeft"..numLines]
				if ( lastLine:GetText() ) then
					lastLine:SetText(lastLine:GetText().."\n\n"..DEFAULT..AL["ItemID:"].." "..itemID)
				end
			end
		end
        AtlasLootTooltip:Show()
		local icon = _G[this:GetName().."Icon"]
		if ( icon:GetTexture() == "Interface\\Icons\\INV_Misc_QuestionMark" ) then
			local _, _, quality, _, _, _, _, _, tex = GetItemInfo(itemID)
			if ( tex and quality ) then
				local r, g, b  = GetItemQualityColor(quality)
				icon:SetTexture(tex)
				this:SetBackdropBorderColor(r, g, b)
			end
		end
    end)
    frame:SetScript("OnLeave", function()
        AtlasLootTooltip:Hide()
        AtlasLootTooltip.itemID = nil
    end)
end

function AtlasLoot_ContainerItem_OnClick(arg1)
	local itemID = this:GetID()
	local name, link, quality, _, _, _, _, _, tex = GetItemInfo(itemID)
	local _, _, _, color = GetItemQualityColor(quality)
	tex = string.gsub(tex, "Interface\\Icons\\", "")
	local extra = this.extraInfo
	local lootpage, dataSource
	if ( lastSelectedButton ) then
		lootpage = lastSelectedButton.lootpage
		dataSource = lastSelectedButton.dataSource
	end
	if ( IsShiftKeyDown() and arg1 == "LeftButton" ) then
		if ( AtlasLootCharDB.AllLinks ) then
			if ( WIM_EditBoxInFocus ) then
				WIM_EditBoxInFocus:Insert(color.."|Hitem:"..itemID.."|h["..name.."]|h|r");
			elseif ( ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:Insert(color.."|Hitem:"..itemID.."|h["..name.."]|h|r");
			end
		end
	elseif ( IsControlKeyDown() and name ) then
		DressUpItemLink(link);
	elseif ( IsAltKeyDown() and itemID ~= 0 ) then
		if ( lootpage ) then
			AtlasLoot_AddToWishlist(itemID, tex, name, extra, lootpage.."|"..dataSource)
		elseif ( AtlasLootItemsFrame.refresh ) then
			local dataID = AtlasLootItemsFrame.refresh[1]
			local dataSource = AtlasLootItemsFrame.refresh[2]
			if ( dataID == "WishList" ) then
				AtlasLoot_DeleteFromWishList(this.itemID);
			elseif ( dataID == "SearchResult" ) then
				AtlasLoot_AddToWishlist(AtlasLoot:GetOriginalDataFromSearchResult(itemID));
			else
				AtlasLoot_AddToWishlist(itemID, tex, name, extra, dataID.."|"..dataSource);
			end
		end
	end
end

--[[
AtlasLoot_QueryLootPage()
Querys all valid items on the current loot page.
]]
function AtlasLoot_QueryLootPage()
	for i = 1, 30 do
		local button = _G["AtlasLootItem_"..i];
		local queryitem = button.itemID;
		if ( (queryitem) and (queryitem ~= "") and (queryitem ~= 0) and
			(string.sub(queryitem, 1, 1) ~= "s") and (string.sub(queryitem, 1, 1) ~= "e") ) then
			if ( not GetItemInfo(queryitem) ) then
				GameTooltip:SetHyperlink("item:"..queryitem..":0:0:0");
			end
		end
	end
end

local function idFromLink(itemlink)
	if ( itemlink ) then
		local _,_,id = string.find(itemlink, "|Hitem:([^:]+)%:")
		return tonumber(id)
	end
	return nil
end

function AtlasLoot_CheckBagsForItems(id, qty)
	if ( not id ) then DEFAULT_CHAT_FRAME:AddMessage("AtlasLoot_CheckBagsForItems: no ID specified!") return end
	if ( not qty ) then qty = 1 end
	local itemsfound = 0;
	local itemName = GetItemInfo(id);
	if ( not itemName ) then return nil end
	for i = 0, NUM_BAG_FRAMES do
		for j = 1, GetContainerNumSlots(i) do
			local itemLink = GetContainerItemLink(i, j)
			if ( itemLink and idFromLink(itemLink) == tonumber(id) ) then
				local _, stackCount = GetContainerItemInfo(i, j)
				itemsfound = itemsfound + stackCount
			end
		end
	end
	if ( itemsfound < qty ) then
		return nil
	else
		return 1
	end
end

function AtlasLoot_SayItemReagents(id, color, name, safe)
	if ( not id ) then return end
	local chatline = "";
	local itemCount = 0;
	name = gsub(name, "|cff%x%x%x%x%x%x", "")
	color = color or NORMAL_FONT_COLOR_CODE
	local tListActivity = {}
	local tCount = 0

	if ( WIM_IconItems and WIM_Icon_SortByActivity ) then
		for key in pairs(WIM_IconItems) do
			table.insert(tListActivity, key)
			tCount = tCount + 1
		end

		table.sort(tListActivity, WIM_Icon_SortByActivity)
	end
	local channel, chatnumber
	if ( tListActivity[1] and WIM_Windows and WIM_Windows[tListActivity[1]].is_visible ) then
		channel = "WHISPER";
		chatnumber = tListActivity[1];
	else
		channel = ChatFrameEditBox.chatType;
		if ( channel == "WHISPER" ) then
			chatnumber = ChatFrameEditBox.tellTarget
		elseif ( channel == "CHANNEL" ) then
			chatnumber = ChatFrameEditBox.channelTarget
		end
	end
	if ( string.sub(id, 1, 1) == "s" ) then
		local spellID = tonumber(string.sub(id, 2))
		local craftItem = tonumber(GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftItem"])
		if ( craftItem and craftItem ~= 0 ) then
			local craftnumber = "";
			local qtyMin = GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftQuantityMin"];
			local qtyMax = GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftQuantityMax"];
			if ( qtyMin and qtyMin ~= "" ) then
				if ( qtyMax and qtyMax ~= "" ) then
					craftnumber = craftnumber..qtyMin.. "-"..qtyMax.."x"
				else
					craftnumber = craftnumber..qtyMin.."x"
				end
			end
			SendChatMessage(AL["To craft "]..craftnumber..AtlasLoot_GetChatLink(craftItem)..AL[" the following reagents are needed:"], channel, nil, chatnumber);
			local reagents = GetSpellInfoAtlasLootDB["craftspells"][spellID]["reagents"]
			if ( type(reagents) == "table" ) then
				for j = 1, table.getn(reagents) do
					local tempnumber = reagents[j][2]
					if ( not tempnumber or tempnumber == nil or tempnumber == "" ) then
						tempnumber = 1;
					end
					chatline = chatline..tempnumber.."x"..AtlasLoot_GetChatLink(reagents[j][1]).." ";
					itemCount = itemCount + 1;
					if ( itemCount == 4 ) then
						SendChatMessage(chatline, channel, nil, chatnumber);
						chatline = "";
						itemCount = 0;
					end
				end
			end
			if ( itemCount > 0 ) then
				SendChatMessage(chatline, channel, nil, chatnumber);
			end
		else
			local reagents = GetSpellInfoAtlasLootDB["craftspells"][spellID]["reagents"]
			SendChatMessage(AL["To cast "]..NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r"..AL[" the following items are needed:"], channel, nil, chatnumber);
			if ( type(reagents) == "table" ) then
				for j = 1, table.getn(reagents) do
					local tempnumber = reagents[j][2]
					if ( not tempnumber or tempnumber == nil or tempnumber == "" ) then
						tempnumber = 1;
					end
					chatline = chatline..tempnumber.."x"..AtlasLoot_GetChatLink(reagents[j][1]).." ";
					itemCount = itemCount + 1;
					if ( itemCount == 4 ) then
						SendChatMessage(chatline, channel, nil, chatnumber);
						chatline = "";
						itemCount = 0;
					end
				end
			end
			if ( itemCount > 0 ) then
				SendChatMessage(chatline, channel, nil, chatnumber);
			end
		end
	elseif ( string.sub(id, 1, 1) == "e" ) then
		local spellID = tonumber(string.sub(id, 2))
		local item = tonumber(GetSpellInfoAtlasLootDB["enchants"][spellID]["item"])
		if ( tListActivity[1] and WIM_Windows[tListActivity[1]].is_visible ) then
			if ( not item ) then
				SendChatMessage(NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber);
			else
				SendChatMessage(AL["To craft "]..AtlasLoot_GetChatLink(item)..AL[" you need this: "]..NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber);
			end
		elseif ( ChatFrameEditBox:IsVisible() ) then
			if ( not item ) then
				ChatFrameEditBox:Insert(NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber);
			else
				ChatFrameEditBox:Insert(AL["To craft "]..AtlasLoot_GetChatLink(item)..AL[" you need this: "]..NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber);
			end
		else
			if ( not item ) then
				SendChatMessage(color.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber);
			else
				SendChatMessage(AL["To craft "]..AtlasLoot_GetChatLink(item)..AL[" you need this: "]..NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber);
			end
		end
	else
		if ( safe ) then
			SendChatMessage("["..name.."]", channel, nil, chatnumber);
		else
			SendChatMessage(color.."|Hitem:"..id..":0:0:0|h["..name.."]|h|r", channel, nil, chatnumber);
		end
	end
end

function AtlasLoot_GetChatLink(id)
	local itemName, itemLink, quality = GetItemInfo(tonumber(id))
	local _, _, _, color = GetItemQualityColor(quality)
	return color.."|H"..itemLink.."|h["..itemName.."]|h|r"
end

function AtlasLoot_QuickLook_OnClick(id)
    if ( IsAltKeyDown() ) then
        AtlasLoot_ClearQuickLookButton(id)
        return
    end
    if ( this:GetParent() == AtlasLootPanel ) then
        if ( AtlasLootPanel:GetParent() == AtlasFrame ) then
            AtlasLoot_AnchorPoint = Anchor_Atlas
        elseif ( AtlasLootPanel:GetParent() == AlphaMapAlphaMapFrame ) then
            AtlasLoot_AnchorPoint = Anchor_AlphaMap
        end
    else
        AtlasLoot_AnchorPoint = Anchor_Default
    end
    AtlasLoot_ShowItemsFrame(AtlasLootCharDB["QuickLooks"][id][1], AtlasLootCharDB["QuickLooks"][id][2], AtlasLootCharDB["QuickLooks"][id][3], AtlasLoot_AnchorPoint);
end

function AtlasLoot_QuickLook_OnShow(id)
    this:SetText(AL["QuickLook"].." "..id)
    this:SetFrameLevel(this:GetParent():GetFrameLevel() + 1)
    if ( not AtlasLootCharDB["QuickLooks"][id] or not AtlasLootCharDB["QuickLooks"][id][1] ) then
        this:Disable()
    end
end

function AtlasLoot_QuickLook_OnEnter(id)
    if ( this:IsEnabled() ) then
        GameTooltip:ClearLines()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 5)
        GameTooltip:AddLine(WHITE..AtlasLootCharDB["QuickLooks"][id][3].."|r")
        GameTooltip:AddLine(AL["ALT+Click to clear"])
        GameTooltip:Show()
    end
end
