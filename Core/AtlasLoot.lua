--[[
Atlasloot Enhanced
Author Daviesh
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)
]]

_G = _G or getfenv(0)

local PAGE_REFRESH_TIMEOUT = 2

-- Bindings
BINDING_HEADER_ATLASLOOT_TITLE = "AtlasLoot Bindings"
BINDING_NAME_ATLASLOOT_TOGGLE = "Toggle AtlasLoot"
BINDING_NAME_ATLASLOOT_OPTIONS = "Toggle Options"
BINDING_NAME_ATLASLOOT_WISHLIST = "WishList"

local L = AtlasLoot.L

-- Establish version number and compatible version of Atlas
local ver = string.gsub(GetAddOnMetadata("AtlasLoot", "Version"), "%.", "0")
_, _, ver = string.find(ver, "(%d+)")
ATLASLOOT_VERSION = "|cffFF8400AtlasLoot TW Edition v"..GetAddOnMetadata("AtlasLoot", "Version").."|r"

-- Compatibility with old EquipCompare/EQCompare
ATLASLOOT_OPTIONS_EQUIPCOMPARE = L["Use EquipCompare"]
ATLASLOOT_OPTIONS_EQUIPCOMPARE_DISABLED = L["|cff9d9d9dUse EquipCompare|r"]

-- Make the Hewdrop menu in the standalone loot browser accessible here
AtlasLoot.Hewdrop = AceLibrary("Hewdrop-2.0")

AtlasLoot.Anchor_Default = { "TOPLEFT", "AtlasLootDefaultFrame", "TOPLEFT", 45, -110 }
AtlasLoot.Anchor_Atlas = { "TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84 }
-- local Anchor_AlphaMap = { "TOPLEFT", "AlphaMapAlphaMapFrame", "TOPLEFT", 0, 0 }
AtlasLoot.AnchorPoint = AtlasLoot.Anchor_Default

AtlasLootCharDB = {}

-- Popup Box for first time users
StaticPopupDialogs["ATLASLOOT_SETUP"] = {
    text = L["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."],
    button1 = L["Setup"],
    OnAccept = function()
        AtlasLoot.Options_Toggle()
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
AtlasLoot.BackdropBorderColor = { 0, 0, 0, 1 }
-- AtlasLoot.BackdropBorderColor = { 1, 0.82, 0, 1 }

-- Table for all data to be inserted into.
AtlasLoot_Data = {}
AtlasLoot_Data["AtlasLootFallback"] = {
    EmptyInstance = {}
}

AtlasLoot.ContainerButtons = {}

SLASH_ATLASLOOT1 = "/atlasloot"
SLASH_ATLASLOOT2 = "/al"
SlashCmdList["ATLASLOOT"] = function(msg)
    if msg == L["reset"] then
        AtlasLoot.Options_ResetPosition()
    elseif msg == L["default"] then
        AtlasLoot.Options_DefaultSettings()
    elseif msg == L["options"] then
        AtlasLoot.Options_Toggle()
    else
        AtlasLootDefaultFrame:Show()
    end
end

local wipe = AtlasLoot.wipe
local tcontains = AtlasLoot.tcontains

--[[
AtlasLoot.ItemsFrame_OnLoad:
Performs inital setup of the mod and registers it for further setup when
the required resources are in place
]]
function AtlasLoot.ItemsFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.refresh = {}
    self.queue = {}
end

--[[
AtlasLoot.ItemsFrame_OnEvent(event):
event - Name of the event, passed from the API
Invoked whenever a relevant event is detected by the engine.  The function then
decides what action to take depending on the event.
]]
function AtlasLoot.ItemsFrame_OnEvent(self, event)
    -- Addons all loaded
    if event == "PLAYER_ENTERING_WORLD" then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        if not AtlasLootCharDB then AtlasLootCharDB = {} end
        if not AtlasLootCharDB["WishList"] then AtlasLootCharDB["WishList"] = {} end
        if not AtlasLootCharDB["SearchResult"] then AtlasLootCharDB["SearchResult"] = {} end
        if not AtlasLootCharDB["Bookmarks"] then AtlasLootCharDB["Bookmarks"] = {} end
        -- Add the loot browser to the special frames tables to enable closing wih the ESC key
        table.insert(UISpecialFrames, "AtlasLootDefaultFrame")
        table.insert(UISpecialFrames, "AtlasLootOptionsFrame")
        -- Set up options frame
        AtlasLoot.Options_OnLoad()
        -- Legacy code for those using the ultimately failed attempt at making Atlas load on demand
        if AtlasButton_LoadAtlas then
            AtlasButton_LoadAtlas()
        end
        if AtlasFrame then
            AtlasLoot.Hooks.Atlas_Refresh = Atlas_Refresh
            AtlasLoot.Hooks.Atlas_OnShow = Atlas_OnShow
            AtlasLoot.Hooks.AtlasScrollBar_Update = AtlasScrollBar_Update
            Atlas_Refresh = AtlasLoot.Atlas_Refresh
            Atlas_OnShow = AtlasLoot.Atlas_OnShow
            AtlasScrollBar_Update = AtlasLoot.AtlasScrollBar_Update
        end
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
            end
            local modulo = math.mod(k, 30)
            local buttonIndex = modulo > 0 and modulo or 30
            if table.getn(v) < 6 then
                table.insert(AtlasLootCharDB["WishList"][k], 1, buttonIndex)
            else
                AtlasLootCharDB["WishList"][k][1] = buttonIndex
            end
        end
        for k, v in pairs(AtlasLootCharDB["SearchResult"]) do
            local modulo = math.mod(k, 30)
            local buttonIndex = modulo > 0 and modulo or 30
            if table.getn(v) < 6 then
                table.insert(AtlasLootCharDB["SearchResult"][k], 1, buttonIndex)
            else
                AtlasLootCharDB["SearchResult"][k][1] = buttonIndex
            end
        end
        -- Adds an AtlasLoot button to the Feature Frame in Cosmos
        if EarthFeature_AddButton then
            EarthFeature_AddButton({
                id = string.sub(ATLASLOOT_VERSION, 11, 28),
                name = string.sub(ATLASLOOT_VERSION, 11, 28),
                subtext = string.sub(ATLASLOOT_VERSION, 30, 39),
                tooltip = "",
                icon = "Interface\\Icons\\INV_Box_01",
                callback = AtlasLoot_ShowMenu,
                test = nil,
            })
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
        AtlasLoot.HewdropRegister()
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

        AtlasLoot.MinimapButton_Toggle()
    end
end

--[[
AtlasLoot.DefaultFrame_OnShow:
Called whenever the loot browser is shown and sets up buttons and loot tables
]]
function AtlasLoot.DefaultFrame_OnShow()
    AtlasLoot.SetupForDefault()
    -- Having the Atlas and loot browser frames shown at the same time would
    -- cause conflicts, so I hide the Atlas frame when the loot browser appears
    if AtlasFrame then
        AtlasFrame:Hide()
    end
    -- Remove the selection of a loot table in Atlas
    AtlasLootItemsFrame.activeBoss = nil
    if AtlasLootItemsFrame.refresh[1] then
        AtlasLoot.ShowItemsFrame(AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3])
    else
        AtlasLoot.ShowItemsFrame(AtlasLootCharDB.LastBoss)
    end
end

--[[
AtlasLoot.DefaultFrame_Toggle:
Simple function to toggle the visibility of the AtlasLoot frame.
]]
function AtlasLoot.DefaultFrame_Toggle()
    if AtlasLootDefaultFrame:IsVisible() then
        HideUIPanel(AtlasLootDefaultFrame)
    else
        ShowUIPanel(AtlasLootDefaultFrame)
    end
end

--[[
AtlasLoot_ShowMenu:
Legacy function used in Cosmos integration to open the loot browser
]]
function AtlasLoot_ShowMenu()
    AtlasLootDefaultFrame:Show()
end

function AtlasLoot.ItemsFrame_OnUpdate(self, elapsed)
    if not self.refreshTime then return end
    self.refreshTime = self.refreshTime - elapsed
    local done = true
    for item in pairs(self.queue) do
        if not GetItemInfo(item) then
            done = false
            break
        end
    end
    if done or self.refreshTime <= 0 then
        self.refreshTime = nil
        wipe(self.queue)
        if self.refresh and self.refresh[1] and self.refresh[2] and self.refresh[3] then
            AtlasLoot.ShowItemsFrame(self.refresh[1], self.refresh[2], self.refresh[3])
        end
    end
end

function AtlasLoot.ItemsFrame_OnHide(self)
    -- Set no loot table as currently selected
    AtlasLootItemsFrame.activeBoss = nil
    -- Fix the boss buttons so the correct icons are displayed
    if AtlasFrame and AtlasFrame:IsVisible() then
        for i = 1, ATLAS_NUM_LINES do
            local entry = _G["AtlasEntry"..i]
            if entry and entry._Selected and entry._Selected:IsShown() then
                entry._Selected:Hide()
                entry._Loot:Show()
            end
        end
    end
    AtlasLoot.UpdateBookmarkButtons()
end

-- It is the workhorse of the mod and allows the loot tables to be displayed any way anywhere in any mod.
---@param dataID       string    loot table key
---@param parentID?    string    parent table key where dataID lives
---@param title?       string    text string to use as a title for the loot page
function AtlasLoot.ShowItemsFrame(dataID, parentID, title)
    if not dataID then return end

    AtlasLootItemsFrame.refreshTime = nil
    wipe(AtlasLootItemsFrame.queue)

    local isDifferentPage = dataID ~= AtlasLootItemsFrame.refresh[1]
    if AtlasLootItemsFrameContainer:IsShown() and isDifferentPage then
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
            data, maxPages = AtlasLoot.GetSearchResultPage(page)
            title = string.format((L["Search Result: %s"]), AtlasLootCharDB.LastSearchedText or "")
            parentID = "SearchResult"
        elseif isWishList then
            data, maxPages = AtlasLoot.GetWishListPage(page)
            title = L["WishList"]
            parentID = "WishList"
        end
        -- Make page number reasonable
        if page < 1 then page = 1 end
        if page > maxPages then page = maxPages end
    else
        data = AtlasLoot_Data[parentID] and AtlasLoot_Data[parentID][dataID]
    end

    if not data then return end

    AtlasLootCharDB.LastBoss = dataID

    -- Get AtlasQuest out of the way
    if AtlasQuestInsideFrame then
        AtlasQuestInsideFrame:Hide()
    end

    -- Store data about the state of the items frame to allow minor tweaks or a recall of the current loot page
    AtlasLootItemsFrame.refresh[1] = dataID
    AtlasLootItemsFrame.refresh[2] = parentID
    AtlasLootItemsFrame.refresh[3] = title
    AtlasLootItemsFrame.refresh[4] = AtlasLoot.AnchorPoint

    if isDifferentPage then
        for i = 1, 30 do
            local button = _G["AtlasLootItem_"..i]
            if UIFrameIsFading(button) or UIFrameIsFlashing(button) then
                UIFrameFadeRemoveFrame(button)
                UIFrameFlashRemoveFrame(button)
                button:SetAlpha(1)
                button.flashTimer = nil
            end
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
    end

    for i = 1, table.getn(data) do
        local buttonIndex = data[i][1]
        local button = _G["AtlasLootItem_"..buttonIndex]
        if button then
            local icon = button._Icon
            local name = button._Name
            local extra = button._Extra
            local quantity = button._Quantity
            local iconBorder = button._IconBorder
            local containerBorder = button._ContainerBorder
            local containerHighlight = button._ContainerBorderHighlight

            local mainData = data[i][2] or ""
            local iconData = data[i][3] or ""
            local textData = AtlasLoot.DecompressText(data[i][4])
            local subTextData = AtlasLoot.DecompressText(data[i][5])
            local droprateData = data[i][6]
            local pricesData = data[i][7]
            local containerData = data[i][8]
            local quantityData = data[i][9]

            local r, g, b = 1, 1, 1
            local color
            local isItem, isEnchant, isSpell, isMenuItem
            local prefix = string.sub(mainData, 1, 1)

            if prefix == "s" then
                isSpell = true
            elseif prefix == "e" then
                isEnchant = true
            elseif tonumber(mainData) then
                isItem = true
            else
                isMenuItem = true
            end

            if isItem then
                local itemID = tonumber(mainData)
                local itemName, _, itemQuality, _, _, _, _, _, itemTexture = GetItemInfo(itemID)
                -- If the client has the name of the item in cache, use that instead.
                if itemName then
                    r, g, b, color = GetItemQualityColor(itemQuality)
                    textData = color..itemName.."|r"
                    iconData = itemTexture
                elseif itemID and itemID ~= 0 then
                    AtlasLootCacheTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
                    AtlasLootCacheTooltip:SetHyperlink("item:"..itemID)
                    AtlasLootItemsFrame.refreshTime = PAGE_REFRESH_TIMEOUT
                    AtlasLootItemsFrame.queue[itemID] = true
                    r, g, b = 1, 0, 0
                end
                button.dressingroomID = itemID
            elseif isEnchant then
                local spellName
                local spellID = tonumber(string.sub(mainData, 2))
                local craftItem = tonumber(GetSpellInfoAtlasLootDB["enchants"][spellID]["item"])
                if SpellInfo then
                    spellName = SpellInfo(spellID)
                else
                    if spellID and spellID ~= 0 then
                        AtlasLootCacheTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
                        AtlasLootCacheTooltip:SetHyperlink("enchant:"..spellID)
                        spellName = AtlasLootCacheTooltipTextLeft1:GetText()
                    end
                    if not spellName or spellName == "" then
                        spellName = GetSpellInfoAtlasLootDB["enchants"][spellID]["name"]
                    end
                end
                if craftItem then
                    local itemName, _, itemQuality, _, _, _, _, _, itemTexture = GetItemInfo(craftItem)
                    if itemName then
                        r, g, b, color = GetItemQualityColor(itemQuality)
                        textData = color..spellName.."|r"
                        iconData = itemTexture
                    elseif craftItem ~= 0 then
                        AtlasLootCacheTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
                        AtlasLootCacheTooltip:SetHyperlink("item:"..craftItem)
                        AtlasLootItemsFrame.refreshTime = PAGE_REFRESH_TIMEOUT
                        AtlasLootItemsFrame.queue[craftItem] = true
                        textData = spellName
                    end
                    button.dressingroomID = craftItem
                else
                    textData = spellName
                end
            elseif isSpell then
                local spellName
                local spellID = tonumber(string.sub(mainData, 2))
                local craftItem = tonumber(GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftItem"])
                local reagents = GetSpellInfoAtlasLootDB["craftspells"][spellID]["reagents"]
                if type(reagents) == "table" then
                    for j = 1, table.getn(reagents) do
                        local reagent = GetSpellInfoAtlasLootDB["craftspells"][spellID]["reagents"][j]
                        AtlasLoot.CacheItem(reagent[1])
                    end
                end
                if SpellInfo then
                    spellName = SpellInfo(spellID)
                else
                    spellName = GetSpellInfoAtlasLootDB["craftspells"][spellID]["name"]
                end
                if craftItem then
                    local itemName, _, itemQuality, _, _, _, _, _, itemTexture = GetItemInfo(craftItem)
                    if itemName then
                        r, g, b, color = GetItemQualityColor(itemQuality)
                        textData = color..spellName.."|r"
                        iconData = itemTexture
                    elseif craftItem ~= 0 then
                        AtlasLootCacheTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
                        AtlasLootCacheTooltip:SetHyperlink("item:"..craftItem)
                        AtlasLootItemsFrame.refreshTime = PAGE_REFRESH_TIMEOUT
                        AtlasLootItemsFrame.queue[craftItem] = true
                        textData = spellName
                    end
                    button.dressingroomID = craftItem
                else
                    textData = spellName
                end
                local qtyMin = GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftQuantityMin"]
                local qtyMax = GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftQuantityMax"]
                if qtyMin then
                    quantityData = qtyMax and qtyMin.."-"..qtyMax or qtyMin
                else
                    quantityData = ""
                end
            elseif isMenuItem then
                button.lootpage = mainData
            end

            name:SetText(textData)
            extra:SetText(subTextData)
            quantity:SetText(quantityData)

            if type(pricesData) == "table" then
                local priceIndex = 1
                for j = 1, table.getn(pricesData), 2 do
                    local priceText = button["_PriceText"..priceIndex]
                    local priceIcon = button["_PriceIcon"..priceIndex]
                    if pricesData[j] and pricesData[j + 1] and pricesData[j] ~= "" and pricesData[j + 1] ~= "" then
                        priceText:SetText(pricesData[j])
                        priceIcon:SetTexture(AtlasLoot.DecompressText(pricesData[j + 1]))
                        priceText:Show()
                        priceIcon:Show()
                    end
                    priceIndex = priceIndex + 1
                end
            end

            if string.sub(iconData, 1, 1) == "$" then
                iconData = "Interface\\AddOns\\AtlasLoot\\Images\\"..string.sub(iconData, 2)
            elseif iconData ~= "" and not string.find(iconData, "Interface\\Icons\\", 1, true) then
                iconData = "Interface\\Icons\\"..iconData
            end
            icon:SetTexture(iconData)
            if icon:GetTexture() == nil or iconData == "" then
                icon:Hide()
                iconBorder:Hide()
                button._Highlight:Hide()
                name:SetPoint("TOPLEFT", icon, "TOPLEFT", 3, 0)
                if not subTextData or subTextData == "" then
                    name:SetPoint("TOPLEFT", icon, "TOPLEFT", 3, -8)
                end
            else
                icon:Show()
                iconBorder:Show()
                button._Highlight:Show()
                name:SetPoint("TOPLEFT", icon, "TOPRIGHT", 3, 0)
            end

            iconBorder:SetVertexColor(r, g, b)

            if type(containerData) == "table" then
                button.container = containerData
                for row = 1, table.getn(containerData) do
                    for item = 1, table.getn(containerData[row]) do
                        AtlasLoot.CacheItem(containerData[row][item][1])
                    end
                end
                containerBorder:Show()
                containerHighlight:Show()
            else
                button.lootpage = isMenuItem and mainData or nil
                containerBorder:Hide()
                containerHighlight:Hide()
            end

            button.itemID = not isMenuItem and mainData or nil
            button.itemIDName = textData
            button.itemIDExtra = subTextData

            if isWishList or isSearchResult then
                button.sourcePage = droprateData
            elseif droprateData and string.find(droprateData, "%", 1, true) then
                button.droprate = droprateData
            end

            button:Show()
            if GetMouseFocus() == button then
                AtlasLoot.ItemButton_OnEnter(button)
            end
        end
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
        local info = AtlasLoot_ButtonRegistry[dataID]
        if info.Next_Page then
            AtlasLootItemsFrame_NEXT:Show()
            AtlasLootItemsFrame_NEXT.lootpage = info.Next_Page
        end
        if info.Prev_Page then
            AtlasLootItemsFrame_PREV:Show()
            AtlasLootItemsFrame_PREV.lootpage = info.Prev_Page
        end
        if info.Back_Page then
            AtlasLootItemsFrame_BACK:Show()
            AtlasLootItemsFrame_BACK.lootpage = info.Back_Page
        end
    end

    -- For Alphamap and Atlas integration, show a 'close' button to hide the loot table and restore the map view
    if AtlasLoot.AnchorPoint ~= AtlasLoot.Anchor_Default then
        AtlasLootItemsFrame_CloseButton:Show()
    else
        AtlasLootItemsFrame_CloseButton:Hide()
    end

    -- Update selected category and subcategory
    local subMenu = nil
    local bossName = ""
    for k in pairs(AtlasLoot_HewdropDown_SubTables) do
        if subMenu then break end
        for _, n in pairs(AtlasLoot_HewdropDown_SubTables[k]) do
            if n[2] == dataID then
                subMenu = AtlasLoot_HewdropDown_SubTables[k]
                bossName = n[1]
                break
            end
        end
    end
    if subMenu then
        AtlasLoot.HewdropSubMenuRegister(subMenu)
        AtlasLootDefaultFrame_SubMenu:Enable()
        AtlasLootDefaultFrame_SelectedTable:SetText(bossName)
    else
        AtlasLootDefaultFrame_SubMenu:Disable()
        AtlasLootDefaultFrame_SelectedTable:SetText("")
    end
    local category = AtlasLoot_TableNames[dataID] and AtlasLoot_TableNames[dataID][3] or ""
    AtlasLootDefaultFrame_SelectedCategory:SetText(category)

    if isWishList or isSearchResult then
        AtlasLootDefaultFrameBookmarkPageButton:Hide()
    else
        AtlasLootDefaultFrameBookmarkPageButton:Show()
        AtlasLootDefaultFrameBookmarkPageButton:SetChecked(tcontains(AtlasLootCharDB["Bookmarks"], dataID))
    end

    -- Anchor the item frame where it is supposed to be
    if AtlasLootItemsFrame:GetParent() ~= _G[AtlasLoot.AnchorPoint[2]] then
        AtlasLootItemsFrame:SetParent(_G[AtlasLoot.AnchorPoint[2]])
        AtlasLootItemsFrame:ClearAllPoints()
        AtlasLootItemsFrame:SetPoint(AtlasLoot.AnchorPoint[1], AtlasLoot.AnchorPoint[2], AtlasLoot.AnchorPoint[3], AtlasLoot.AnchorPoint[4], AtlasLoot.AnchorPoint[5])
    end
    AtlasLootItemsFrame:Show()

    AtlasLoot.UpdateBookmarkButtons()
end

--[[
AtlasLoot.HewdropClick(tablename):
dataID - Name of the loot table in the database
Called when a button in AtlasLoot_Hewdrop is clicked
]]
function AtlasLoot.HewdropClick(dataID)
    AtlasLoot.ShowItemsFrame(dataID)
    AtlasLoot.Hewdrop:Close(1)
end

--[[
AtlasLoot.HewdropSubMenuRegister(loottable):
loottable - Table defining the sub menu
Generates the sub menu needed by passing a table of loot tables and titles
]]
function AtlasLoot.HewdropSubMenuRegister(loottable)
    AtlasLoot.Hewdrop:Register(AtlasLootDefaultFrame_SubMenu,
        'point', function(parent)
            return "TOP", "BOTTOM"
        end,
        'children', function(level, value)
            if level == 1 then
                for k, v in pairs(loottable) do
                    AtlasLoot.Hewdrop:AddLine(
                        'text', v[1],
                        'func', AtlasLoot.HewdropClick,
                        'arg1', v[2],
                        'notCheckable', true
                    )
                end
            end
        end,
        'dontHook', true
    )
end

--[[
AtlasLoot.HewdropRegister:
Constructs the main category menu from a tiered table
]]
function AtlasLoot.HewdropRegister()
    AtlasLoot.Hewdrop:Register(AtlasLootDefaultFrame_Menu,
        'point', function(parent)
            return "TOP", "BOTTOM"
        end,
        'children', function(level, value)
            if level == 1 then
                for k, v in ipairs(AtlasLoot_HewdropDown) do
                    -- If a link to show a submenu
                    if type(v[1]) == "table" and type(v[1][1]) == "string" then
                        if v[1][3] == "Submenu" then
                            AtlasLoot.Hewdrop:AddLine(
                                'text', v[1][1],
                                'textR', 1,
                                'textG', 0.82,
                                'textB', 0,
                                'func', AtlasLoot.HewdropClick,
                                'arg1', v[1][2],
                                'notCheckable', true
                            )
                        end
                    else
                        local lock = 0
                        -- If an entry linked to a subtable
                        for i, j in pairs(v) do
                            if lock == 0 then
                                AtlasLoot.Hewdrop:AddLine(
                                    'text', AtlasLoot_TableNames[i] and AtlasLoot_TableNames[i][1],
                                    'textR', 1,
                                    'textG', 0.82,
                                    'textB', 0,
                                    'hasArrow', true,
                                    'value', j,
                                    'func', AtlasLoot.HewdropClick,
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
                                    AtlasLoot.Hewdrop:AddLine(
                                        'text', v[1][1],
                                        'textR', 1,
                                        'textG', 0.82,
                                        'textB', 0,
                                        'func', AtlasLoot.HewdropClick,
                                        'arg1', v[1][2],
                                        'notCheckable', true
                                    )
                                    -- An entry to show a specific loot page
                                else
                                    AtlasLoot.Hewdrop:AddLine(
                                        'text', v[1][1],
                                        'textR', 1,
                                        'textG', 0.82,
                                        'textB', 0,
                                        'func', AtlasLoot.HewdropClick,
                                        'arg1', v[1][2],
                                        'notCheckable', true
                                    )
                                end
                            else
                                local lock = 0
                                -- Entry to link to a sub table
                                for i, j in pairs(v) do
                                    if lock == 0 then
                                        AtlasLoot.Hewdrop:AddLine(
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
                                AtlasLoot.Hewdrop:AddLine(
                                    'text', v[1],
                                    'textR', 1,
                                    'textG', 0.82,
                                    'textB', 0,
                                    'func', AtlasLoot.HewdropClick,
                                    'arg1', v[2],
                                    'notCheckable', true
                                )
                            else
                                AtlasLoot.Hewdrop:AddLine(
                                    'text', v[1],
                                    'textR', 1,
                                    'textG', 0.82,
                                    'textB', 0,
                                    'func', AtlasLoot.HewdropClick,
                                    'arg1', v[2],
                                    'notCheckable', true
                                )
                            end
                        elseif type(v) == "table" then
                            AtlasLoot.Hewdrop:AddLine(
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

--[[
AtlasLoot.NavigationButton_OnClick:
Called when <-, -> or 'Back' are pressed and calls up the appropriate loot page
]]
function AtlasLoot.NavigationButton_OnClick(self)
    AtlasLoot.Hewdrop:Close(1)
    AtlasLoot.ShowItemsFrame(self.lootpage)
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
        AtlasLoot.ShowItemsFrame(dataID, nil, boss)
    end
end

function AtlasLoot.ItemButton_OnLoad(self)
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

local stringArgs = {}
function AtlasLoot.ItemButton_OnEnter(self)
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
                    AtlasLootTooltip:AddLine(L["ItemID:"].." "..self.itemID)
                end
                if self.droprate then
                    AtlasLootTooltip:AddLine(L["Drop Rate: "]..self.droprate, 1, 1, 0)
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
                    AtlasLootTooltip:AddLine(L["ItemID:"].." "..self.itemID)
                end
                if self.droprate then
                    AtlasLootTooltip:AddLine(L["Drop Rate: "]..self.droprate, 1, 1, 0, 1)
                end
                AtlasLootTooltip:Show()
            end
            -- Item Sync tooltips
        elseif AtlasLootCharDB.ItemSyncTT then
            ItemSync:ButtonEnter()
            if AtlasLootCharDB.ItemIDs then
                GameTooltip:AddLine(L["ItemID:"].." "..self.itemID)
            end
            if self.droprate then
                GameTooltip:AddLine(L["Drop Rate: "]..self.droprate, 1, 1, 0)
            end
            GameTooltip:Show()
            -- Default game tooltips
        else
            AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 24)
            if GetItemInfo(self.itemID) then
                AtlasLootTooltip:SetHyperlink("item:"..self.itemID..":0:0:0")
            else
                AtlasLootTooltip:SetText(L["Retrieving item information"], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
            end
            if AtlasLootCharDB.ItemIDs then
                AtlasLootTooltip:AddLine(L["ItemID:"].." "..self.itemID)
            end
            if self.droprate then
                AtlasLootTooltip:AddLine(L["Drop Rate: "]..self.droprate, 1, 1, 0)
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
                longCooldown = format(L.DAYS_COOLDOWN, longCooldown)
            else
                longCooldown = format(L.DAYS_COOLDOWN_1, longCooldown)
            end
            AtlasLootTooltipTextRight2:SetText(longCooldown)
        end
        if AtlasLootCharDB.ItemIDs then
            AtlasLootTooltip:AddLine(L["SpellID:"].." "..spellID)
        end
        AtlasLootTooltip:Show()
        local item = tonumber(GetSpellInfoAtlasLootDB["enchants"][spellID]["item"])
        local extra = GetSpellInfoAtlasLootDB["enchants"][spellID]["extra"]
        if item and item ~= 0 then
            AtlasLootTooltip2:SetOwner(self, "ANCHOR_NONE")
            AtlasLootTooltip2:SetPoint("TOPLEFT", AtlasLootTooltip, "BOTTOMLEFT", 0, 0)
            if not AtlasLoot.CacheItem(item) then
                AtlasLootTooltip2:SetText(L["Retrieving item information"], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
            else
                AtlasLootTooltip2:SetHyperlink("item:"..item)
                if extra then
                    AtlasLootTooltip2:AddLine(extra, 1, 1, 1, 1)
                end
            end
            if AtlasLootCharDB.ItemIDs then
                AtlasLootTooltip2:AddLine(L["ItemID:"].." "..item)
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
                    longCooldown = format(L.DAYS_COOLDOWN, longCooldown)
                else
                    longCooldown = format(L.DAYS_COOLDOWN_1, longCooldown)
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
                    cooldown = format(L.DAYS_COOLDOWN_1, cooldown / 60 / 60 / 24)
                else
                    cooldown = format(L.DAYS_COOLDOWN, cooldown / 60 / 60 / 24)
                end
                AtlasLootTooltip:AddDoubleLine(castTime, cooldown, 1, 1, 1, 1, 1, 1)
            else
                AtlasLootTooltip:AddLine(castTime, 1, 1, 1)
            end
            if type(tools) == "table" then
                wipe(stringArgs)
                for j = 1, table.getn(tools) do
                    if not AtlasLoot.CacheItem(tools[j]) then
                        AtlasLootItemsFrame.refreshTime = PAGE_REFRESH_TIMEOUT
                        AtlasLootItemsFrame.queue[tools[j]] = true
                    end
                    table.insert(stringArgs, (GetItemInfo(tools[j]) or ""))
                    table.insert(stringArgs, AtlasLoot.CheckBagsForReagent(tools[j]))
                end
                AtlasLootTooltip:AddLine(SPELL_TOTEMS..BuildColoredListString(unpack(stringArgs)), 1, 1, 1, false)
            end
            if type(reagents) == "table" then
                wipe(stringArgs)
                for j = 1, table.getn(reagents) do
                    if reagents[j][2] and reagents[j][2] > 1 then
                        if not AtlasLoot.CacheItem(reagents[j][1]) then
                            AtlasLootItemsFrame.refreshTime = PAGE_REFRESH_TIMEOUT
                            AtlasLootItemsFrame.queue[reagents[j][1]] = true
                        end
                        table.insert(stringArgs, ((GetItemInfo(reagents[j][1])) or "").." ("..reagents[j][2]..")")
                    else
                        table.insert(stringArgs, ((GetItemInfo(reagents[j][1])) or ""))
                    end
                    table.insert(stringArgs, AtlasLoot.CheckBagsForReagent(reagents[j][1], reagents[j][2]))
                end
                AtlasLootTooltip:AddLine(SPELL_REAGENTS..BuildColoredListString(unpack(stringArgs)), 1, 1, 1, true)
            end
            if text then
                AtlasLootTooltip:AddLine(text, 1, 0.82, 0, true)
            end
        end
        if AtlasLootCharDB.ItemIDs then
            AtlasLootTooltip:AddLine(L["SpellID:"].." "..spellID)
        end
        AtlasLootTooltip:Show()
        local craftItem = tonumber(GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftItem"])
        local extra = GetSpellInfoAtlasLootDB["craftspells"][spellID]["extra"]
        if craftItem and craftItem ~= 0 then
            AtlasLootTooltip2:SetOwner(self, "ANCHOR_NONE")
            AtlasLootTooltip2:SetPoint("TOPLEFT", AtlasLootTooltip, "BOTTOMLEFT", 0, 0)
            AtlasLootTooltip2:ClearLines()
            if not AtlasLoot.CacheItem(craftItem) then
                AtlasLootTooltip2:SetText(L["Retrieving item information"], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
            else
                AtlasLootTooltip2:SetHyperlink("item:"..craftItem)
                if extra then
                    AtlasLootTooltip2:AddLine(extra, 1, 1, 1, 1)
                end
            end
            if AtlasLootCharDB.ItemIDs then
                AtlasLootTooltip2:AddLine(L["ItemID:"].." "..craftItem)
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

function AtlasLoot.ItemButton_OnLeave(self)
    AtlasLootTooltip:Hide()
    AtlasLootTooltip2:Hide()
    GameTooltip:Hide()
    ShoppingTooltip1:Hide()
    ShoppingTooltip2:Hide()
end

function AtlasLoot.ItemButton_OnClick(self, button)
    AtlasLoot.Hewdrop:Close(1)
    if self.container then
        AtlasLoot.ShowContainerFrame(self)
        return
    elseif self.lootpage then
        AtlasLoot.ShowItemsFrame(self.lootpage)
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
    local link = ""
    local chatEditBox = WIM_EditBoxInFocus or ChatFrameEditBox
    if isItem then
        local itemName = GetItemInfo(self.itemID)
        link = string.format("%s|Hitem:%d:0:0:0|h[%s]|h|r", color, self.itemID, itemName)
    elseif isEnchant then
        local spellID = tonumber(string.sub(self.itemID, 2))
        link = string.format("%s|Henchant:%d|h[%s]|h|r", color, spellID, name)
    elseif isSpell then
        local spellID = tonumber(string.sub(self.itemID, 2))
        local craftItemID = tonumber(GetSpellInfoAtlasLootDB["craftspells"][spellID]["craftItem"])
        local craftItemName = GetItemInfo(craftItemID or 0)
        if craftItemID and craftItemID ~= 0 and craftItemName then
            link = string.format("%s|Hitem:%d:0:0:0|h[%s]|h|r", color, craftItemID, craftItemName)
        else
            link = string.format("%s|Henchant:%d|h[%s]|h|r", color, spellID, name)
        end
    end
    if IsShiftKeyDown() then
        if chatEditBox and chatEditBox:IsVisible() then
            chatEditBox:Insert(link)
        else
            AtlasLoot.SayItemReagents(self.itemID, color, name)
        end
    elseif IsAltKeyDown() then
        if dataSource == "WishList" then
            AtlasLoot.DeleteFromWishList(self.itemID)
        elseif dataSource == "SearchResult" then
            AtlasLoot.AddToWishlist(AtlasLoot.GetOriginalDataFromSearchResult(self.itemID))
        else
            AtlasLoot.AddToWishlist(self.itemID, texture, self.itemIDName, self.itemIDExtra, dataID.."|"..dataSource)
        end
    elseif IsControlKeyDown() then
        if self.dressingroomID and self.dressingroomID ~= 0 then
            DressUpItemLink(self.dressingroomID)
        end
    elseif (dataSource == "SearchResult" or dataSource == "WishList") and self.sourcePage then
        _, _, dataID, dataSource = string.find(self.sourcePage, "(.+)|(.+)")
        if dataID and dataSource then
            local id = self.itemID
            AtlasLoot.ShowItemsFrame(dataID, dataSource)
            local parentButton, isInsideContainer = AtlasLoot.GetParentButton(id)
            if parentButton then
                if isInsideContainer then
                    AtlasLoot.ShowContainerFrame(parentButton)
                    for _, frame in pairs(AtlasLoot.ContainerButtons) do
                        if frame.itemID == id then
                            UIFrameFlash(frame, 0.25, 0.25, 1.1, true, 0.1, 0.1)
                            break
                        end
                    end
                else
                    UIFrameFlash(parentButton, 0.25, 0.25, 1.1, true, 0.1, 0.1)
                end
            end
        end
    end
end

local lastSelectedButton
function AtlasLoot.ShowContainerFrame(self)
    local data = self.container
    if not data then return end

    if self ~= lastSelectedButton then
        AtlasLootItemsFrameContainer:Show()
        lastSelectedButton = self
        for _, button in pairs(AtlasLoot.ContainerButtons) do
            if UIFrameIsFading(button) or UIFrameIsFlashing(button) then
                UIFrameFadeRemoveFrame(button)
                UIFrameFlashRemoveFrame(button)
                button:SetAlpha(1)
                button.flashTimer = nil
            end
            button:Hide()
        end
    elseif AtlasLootItemsFrameContainer:IsVisible() then
        AtlasLootItemsFrameContainer:Hide()
        lastSelectedButton = nil
        return
    end

    if not AtlasLootItemsFrameContainer:IsVisible() and lastSelectedButton == self then
        AtlasLootItemsFrameContainer:Show()
    end

    local row = 0
    local col = 0
    local buttonIndex = 1
    local maxCols = 1

    for i = 1, table.getn(data) do
        col = 0
        for j = 1, table.getn(data[i]) do
            local itemButton = AtlasLoot.ContainerButtons[buttonIndex]
            if not itemButton then
                itemButton = CreateFrame("Button", "AtlasLootContainerItem"..buttonIndex, AtlasLootItemsFrameContainer, "AtlasLootContainerItemTemplate")
                itemButton:SetID(buttonIndex)
                AtlasLoot.ContainerButtons[buttonIndex] = itemButton
            end
            local itemID = data[i][j][1]
            AtlasLoot.CacheItem(itemID)
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

function AtlasLoot.ContainerItem_OnEnter(self)
    local itemID = self.itemID
    if not itemID then return end

    AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 4), -(self:GetHeight() / 4))
    AtlasLootTooltip:SetHyperlink("item:"..itemID)
    AtlasLootTooltip.itemID = itemID
    if AtlasLootCharDB.ItemIDs then
        AtlasLootTooltip:AddLine(L["ItemID:"].." "..itemID)
    end
    AtlasLootTooltip:Show()
end

function AtlasLoot.ContainerItem_OnLeave(self)
    AtlasLootTooltip:Hide()
    AtlasLootTooltip.itemID = nil
end

function AtlasLoot.ContainerItem_OnClick(self, button)
    local itemID = self.itemID
    local name, link, quality, _, _, _, _, _, tex = GetItemInfo(itemID or 0)
    if not name then return end

    local _, _, _, color = GetItemQualityColor(quality)
    tex = string.gsub(tex, "Interface\\Icons\\", "")
    local dataID = AtlasLootItemsFrame.refresh[1]
    local dataSource = AtlasLootItemsFrame.refresh[2]
    if IsShiftKeyDown() and button == "LeftButton" then
        if WIM_EditBoxInFocus then
            WIM_EditBoxInFocus:Insert(color.."|Hitem:"..itemID..":0:0:0|h["..name.."]|h|r")
        elseif ChatFrameEditBox:IsVisible() then
            ChatFrameEditBox:Insert(color.."|Hitem:"..itemID..":0:0:0|h["..name.."]|h|r")
        end
    elseif IsControlKeyDown() and link then
        DressUpItemLink(link)
    elseif IsAltKeyDown() and itemID ~= 0 and dataID and dataSource then
        if dataSource == "WishList" then
            AtlasLoot.DeleteFromWishList(itemID)
        elseif dataSource == "SearchResult" then
            AtlasLoot.AddToWishlist(AtlasLoot.GetOriginalDataFromSearchResult(itemID))
        else
            AtlasLoot.AddToWishlist(itemID, tex, name, self.itemIDExtra, dataID.."|"..dataSource)
        end
    end
end

function AtlasLoot.SayItemReagents(id, color, name, safe)
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
            SendChatMessage(L["To craft "]..craftnumber..AtlasLoot.GetItemLink(craftItem)..L[" the following reagents are needed:"], channel, nil, chatnumber)
            local reagents = GetSpellInfoAtlasLootDB["craftspells"][spellID]["reagents"]
            if type(reagents) == "table" then
                for j = 1, table.getn(reagents) do
                    local tempnumber = reagents[j][2]
                    if not tempnumber or tempnumber == nil or tempnumber == "" then
                        tempnumber = 1
                    end
                    chatline = chatline..tempnumber.."x"..AtlasLoot.GetItemLink(reagents[j][1]).." "
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
            SendChatMessage(L["To cast "]..NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r"..L[" the following items are needed:"], channel, nil, chatnumber)
            if type(reagents) == "table" then
                for j = 1, table.getn(reagents) do
                    local tempnumber = reagents[j][2]
                    if not tempnumber or tempnumber == nil or tempnumber == "" then
                        tempnumber = 1
                    end
                    chatline = chatline..tempnumber.."x"..AtlasLoot.GetItemLink(reagents[j][1]).." "
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
                SendChatMessage(L["To craft "]..AtlasLoot.GetItemLink(item)..L[" you need this: "]..NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber)
            end
        elseif ChatFrameEditBox:IsVisible() then
            if not item then
                ChatFrameEditBox:Insert(NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r")
            else
                ChatFrameEditBox:Insert(L["To craft "]..AtlasLoot.GetItemLink(item)..L[" you need this: "]..NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r")
            end
        else
            if not item then
                SendChatMessage(color.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber)
            else
                SendChatMessage(L["To craft "]..AtlasLoot.GetItemLink(item)..L[" you need this: "]..NORMAL_FONT_COLOR_CODE.."|Henchant:"..spellID.."|h["..name.."]|h|r", channel, nil, chatnumber)
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
