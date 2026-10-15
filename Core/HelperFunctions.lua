AtlasLoot.wipe = table.wipe or function(t)
    local value = t and type(t) or "no value"
    if value ~= "table" then
        error(string.format("bad argument #1 to `wipe' (table expected, got %s)", value))
        return
    end
    for k in pairs(t) do rawset(t, k, nil) end
    table.setn(t, 0)
    return t
end

AtlasLoot.tcontains = function(t, value)
    if not (t and type(t) == "table") then return nil end
    for k, v in pairs(t) do
        if v == value then return k end
    end
    return nil
end

function AtlasLoot.strtrim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function AtlasLoot.GetIDFromItemLink(itemlink)
    if itemlink then
        local _, _, id = string.find(itemlink, "item:(%d+)")
        return tonumber(id)
    end
    return nil
end

function AtlasLoot.GetItemLink(itemID)
    if not itemID then return "" end
    local itemName, itemString, quality = GetItemInfo(itemID)
    if not itemName then return "" end
    local _, _, _, color = GetItemQualityColor(quality)
    return color.."|H"..itemString.."|h["..itemName.."]|h|r"
end

function AtlasLoot.CheckBagsForReagent(reagentID, numRequired)
    if not reagentID then return end
    if not numRequired then numRequired = 1 end
    if not GetItemInfo(reagentID) then return false end
    local numFound = 0
    for i = BANK_CONTAINER, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
        for j = 1, GetContainerNumSlots(i) do
            local itemLink = GetContainerItemLink(i, j)
            if itemLink and AtlasLoot.GetIDFromItemLink(itemLink) == tonumber(reagentID) then
                local _, count = GetContainerItemInfo(i, j)
                numFound = numFound + count
            end
        end
    end
    return numFound >= numRequired
end

---@return Button|nil  -- AtlasLootItem_# frame
---@return boolean|nil -- isInsideContainer flag
function AtlasLoot.GetParentButton(itemID)
    if not itemID then return nil end
    for i = 1, 30 do
        local button = _G["AtlasLootItem_"..i]
        if button.itemID == itemID then return button, false end
        if button.container then
            for k, v in pairs(button.container) do
                for k2, v2 in pairs(v) do
                    if v2[1] == itemID then return button, true end
                end
            end
        end
    end
    return nil
end

function AtlasLoot.CacheItem(linkOrID)
    if not linkOrID or tonumber(linkOrID) == 0 then return false end
    if tonumber(linkOrID) then
        if GetItemInfo(linkOrID) then return true end
        AtlasLootCacheTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
        AtlasLootCacheTooltip:SetHyperlink("item:"..linkOrID)
        return false
    else
        if type(linkOrID) ~= "string" then return false end
        local _, _, item = string.find(linkOrID, "(item:%d+:%d+:%d+:%d+)")
        if not item then return false end
        if GetItemInfo(item) then return true end
        AtlasLootCacheTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
        AtlasLootCacheTooltip:SetHyperlink(item)
        return false
    end
end

local mem = {}
function AtlasLoot.GetItemIDByName(name)
    if not name then return nil end
    if mem[name] then return mem[name] ~= 0 and mem[name] or nil end
    for itemID = 1, 99999 do
        if GetItemInfo(itemID) == name then
            mem[name] = itemID
            return itemID
        end
    end
    mem[name] = 0
    return nil
end

-- from http://shagu.org/ShaguTweaks/
function AtlasLoot.HookAddonOrVariable(addon, func)
    local lurker = CreateFrame("Frame")
    lurker.func = func
    lurker:RegisterEvent("ADDON_LOADED")
    lurker:RegisterEvent("VARIABLES_LOADED")
    lurker:RegisterEvent("PLAYER_ENTERING_WORLD")
    lurker:SetScript("OnEvent", function()
        if IsAddOnLoaded(addon) or _G[addon] then
            this:func()
            this:UnregisterAllEvents()
        end
    end)
end
