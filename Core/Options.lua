local L = AtlasLoot.L

local GREY = "|cff999999"
local RED = RED_FONT_COLOR_CODE
local WHITE = "|cffFFFFFF"
local GREEN = GREEN_FONT_COLOR_CODE
local PURPLE = "|cff9F3FFF"
local BLUE = "|cff0070dd"
local ORANGE = "|cffFF8400"

function AtlasLoot.Options_OnLoad()
    -- Disable checkboxes of missing addons
    if not LootLink_SetTooltip then
        AtlasLootOptionsFrameLootlinkTT:Disable()
        AtlasLootOptionsFrameLootlinkTTText:SetText(L["|cff9d9d9dLootlink Tooltips|r"])
    end
    if not ItemSync then
        AtlasLootOptionsFrameItemSyncTT:Disable()
        AtlasLootOptionsFrameItemSyncTTText:SetText(L["|cff9d9d9dItemSync Tooltips|r"])
    end
    if not IsAddOnLoaded("EQCompare") and not IsAddOnLoaded("EquipCompare") then
        AtlasLootOptionsFrameEquipCompare:Disable()
        AtlasLootOptionsFrameEquipCompareText:SetText(L["|cff9d9d9dUse EquipCompare|r"])
    end
    AtlasLoot.Options_Update()
end

function AtlasLoot.Options_Update()
    -- clear saved vars for a new version (or a new install!)
    if AtlasLootCharDB.FirstTime == nil then
        AtlasLoot.ResetCharDB()
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
    AtlasLoot.MinimapButton_UpdatePosition()
end

function AtlasLoot.ResetCharDB()
    AtlasLootCharDB = {}
    AtlasLootCharDB["WishList"] = {}
    AtlasLootCharDB["Bookmarks"] = {}
    AtlasLootCharDB["SearchResult"] = {}
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
    AtlasLootCharDB.LastBoss = "MAINMENU"
    AtlasLootCharDB.PartialMatching = true
end

function AtlasLoot.Options_ResetPosition()
    AtlasLootCharDB.MinimapButtonPosition = 315
    AtlasLootCharDB.MinimapButtonRadius = 78
    AtlasLoot.MinimapButton_UpdatePosition()
    DEFAULT_CHAT_FRAME:AddMessage("["..ORANGE..L["AtlasLoot"].."|r] "..L["Minimap button has been reset!"])
end

function AtlasLoot.Options_DefaultSettings()
    AtlasLoot.ResetCharDB()
    AtlasLootDefaultFrame:ClearAllPoints()
    AtlasLootDefaultFrame:SetPoint("TOP", "UIParent", "TOP", 0, -30)
    AtlasLootOptionsFrame:ClearAllPoints()
    AtlasLootOptionsFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 100)
    AtlasLoot.Options_Update()
    AtlasLoot.ShowItemsFrame("MAINMENU")
    DEFAULT_CHAT_FRAME:AddMessage("["..ORANGE..L["AtlasLoot"].."|r] "..L["Default settings applied!"])
end

function AtlasLoot.Options_DefaultTTToggle()
    AtlasLootCharDB.DefaultTT = true
    AtlasLootCharDB.LootlinkTT = false
    AtlasLootCharDB.ItemSyncTT = false
    AtlasLoot.Options_Update()
end

function AtlasLoot.Options_LootlinkTTToggle()
    AtlasLootCharDB.DefaultTT = false
    AtlasLootCharDB.LootlinkTT = true
    AtlasLootCharDB.ItemSyncTT = false
    AtlasLoot.Options_Update()
end

function AtlasLoot.Options_ItemSyncTTToggle()
    AtlasLootCharDB.DefaultTT = false
    AtlasLootCharDB.LootlinkTT = false
    AtlasLootCharDB.ItemSyncTT = true
    AtlasLoot.Options_Update()
end

function AtlasLoot.Options_ShowSourceToggle()
    AtlasLootCharDB.ShowSource = not AtlasLootCharDB.ShowSource
    AtlasLoot.Options_Update()
end

function AtlasLoot.Options_WishlistGroupedByDungeonToggle()
    AtlasLootCharDB.WishlistGroupedByDungeon = not AtlasLootCharDB.WishlistGroupedByDungeon
    AtlasLoot.Options_Update()
    if AtlasLootItemsFrame.refresh[2] == "WishList" then
        AtlasLoot.WishList = AtlasLoot.CategorizeWishList(AtlasLootCharDB["WishList"])
        AtlasLoot.ShowWishList()
    elseif AtlasLootItemsFrame.refresh[2] == "SearchResult" then
        AtlasLoot.SearchResult = AtlasLoot.CategorizeWishList(AtlasLootCharDB["SearchResult"])
        AtlasLoot.ShowSearchResult()
    end
end

function AtlasLoot.Options_EquipCompareToggle()
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
    AtlasLoot.Options_Update()
end

function AtlasLoot.Options_OpaqueToggle()
    AtlasLootCharDB.Opaque = AtlasLootOptionsFrameOpaque:GetChecked() and true or false
    if AtlasLootCharDB.Opaque then
        AtlasLootItemsFrame_Background:SetTexture(0, 0, 0, 1)
        AtlasLootItemsFrame:SetBackdropColor(0, 0, 0, 1)
        AtlasLoot.BackdropColor[4] = 1
    else
        AtlasLootItemsFrame_Background:SetTexture(0, 0, 0, 0.65)
        AtlasLootItemsFrame:SetBackdropColor(0, 0, 0, 0.65)
        AtlasLoot.BackdropColor[4] = 0.65
    end
    AtlasLoot.Options_Update()
end

function AtlasLoot.Options_ItemIDToggle()
    AtlasLootCharDB.ItemIDs = not AtlasLootCharDB.ItemIDs
    AtlasLoot.Options_Update()
end

function AtlasLoot.Options_Toggle()
    if AtlasLootOptionsFrame:IsVisible() then
        -- Hide the options frame if already shown
        AtlasLootOptionsFrame:Hide()
    else
        AtlasLootOptionsFrame:Show()
        -- Workaround for a weird quirk where tooltip settings so not immediately take effect
        if AtlasLootCharDB.DefaultTT then
            AtlasLoot.Options_DefaultTTToggle()
        elseif AtlasLootCharDB.LootlinkTT then
            AtlasLoot.Options_LootlinkTTToggle()
        elseif AtlasLootCharDB.ItemSyncTT then
            AtlasLoot.Options_ItemSyncTTToggle()
        end
    end
end

function AtlasLoot.Options_SetupSlider(self, var, text, low, high, step)
    local name = self:GetName()
    self.Text = _G[name.."Text"]
    self.Low = _G[name.."Low"]
    self.High = _G[name.."High"]
    self.Text:SetText(text.." ("..self:GetValue()..")")
    self.Low:SetText(low)
    self.High:SetText(high)
    self.var = var
    self:SetMinMaxValues(low, high)
    self:SetValueStep(step)
end

function AtlasLoot.Options_UpdateSlider(self)
    local value = math.floor(self:GetValue())
    self.Text:SetText(string.gsub(self.Text:GetText(), "%d+", value, 1))
    AtlasLootCharDB[self.var] = value
    AtlasLoot.MinimapButton_UpdatePosition()
end
