-- File containing functions related to the wish list.
local L = AtlasLoot.L

AtlasLoot.WishList = nil
local currentPage = 1

-- Colours stored for code readability
local GREY = "|cff999999"
local RED = RED_FONT_COLOR_CODE
local WHITE = "|cffFFFFFF"
local GREEN = GREEN_FONT_COLOR_CODE
local PURPLE = "|cff9F3FFF"
local BLUE = "|cff0070dd"
local ORANGE = "|cffFF8400"

function AtlasLoot.ShowWishList()
    AtlasLoot.Hewdrop:Close(1)
    AtlasLoot.ShowItemsFrame("WishListPage"..currentPage)
end

function AtlasLoot.AddToWishlist(itemID, itemTexture, itemName, extraText, sourcePage)
    -- print(itemID, itemTexture, itemName, extraText, sourcePage)
    for _, v in ipairs(AtlasLootCharDB["WishList"]) do
        if v[2] == itemID then
            DEFAULT_CHAT_FRAME:AddMessage("["..ORANGE..L["AtlasLoot"].."|r] "..AtlasLoot.DecompressText(itemName)..RED..L[" already in the WishList!"])
            return
        end
    end
    table.insert(AtlasLootCharDB["WishList"], { 0, itemID, itemTexture, itemName, extraText, sourcePage })
    DEFAULT_CHAT_FRAME:AddMessage("["..ORANGE..L["AtlasLoot"].."|r] "..AtlasLoot.DecompressText(itemName)..L[" added to the WishList."])
    AtlasLoot.WishList = AtlasLoot.CategorizeWishList(AtlasLootCharDB["WishList"])
end

function AtlasLoot.DeleteFromWishList(itemID)
    if itemID and itemID == 0 then return end
    for i, v in ipairs(AtlasLootCharDB["WishList"]) do
        if v[2] == itemID then
            DEFAULT_CHAT_FRAME:AddMessage("["..ORANGE..L["AtlasLoot"].."|r] "..AtlasLoot.DecompressText(v[4])..L[" deleted from the WishList."])
            table.remove(AtlasLootCharDB["WishList"], i)
            break
        end
    end
    AtlasLoot.WishList = AtlasLoot.CategorizeWishList(AtlasLootCharDB["WishList"])
    AtlasLoot.ShowItemsFrame("WishListPage"..currentPage)
end

--[[
Sorts by rarity (higher quality first), then alphabetically (from A to Z).
returns true if `a` should come before `b`
]]
function AtlasLoot.WishListSortCheck(a, b)
    local nameA, nameB = a[4], b[4]
    local _, _, qualityA = string.find(nameA, "^=q(%d)=")
    local _, _, qualityB = string.find(nameB, "^=q(%d)=")
    qualityA, qualityB = tonumber(qualityA) or 0, tonumber(qualityB) or 0
    if qualityA == qualityB then
        return nameA < nameB
    else
        return qualityA > qualityB
    end
end

do
    local cache = {}
    -- A recursive function iterate AtlasLoot_HewdropDown table for the zone name
    local function RecursiveSearchZoneName(dataTable, zoneID)
        if (dataTable[2] == zoneID) then
            cache[zoneID] = dataTable[1]
            return dataTable[1]
        end
        for _, v in pairs(dataTable) do
            if type(v) == "table" then
                local result = RecursiveSearchZoneName(v, zoneID)
                if result then
                    cache[zoneID] = result
                    return result
                end
            end
        end
    end
    -- Iterating through dropdown data tables to search backward for zone name with specified dataID
    function AtlasLoot.GetWishListSubheading(dataID)
        if cache[dataID] then return cache[dataID] end
        local zoneID
        for subKey, subTable in pairs(AtlasLoot_HewdropDown_SubTables) do
            for _, t in ipairs(subTable) do
                if t[2] == dataID then
                    zoneID = subKey
                    break
                end
            end
            if zoneID then break end
        end
        return RecursiveSearchZoneName(AtlasLoot_HewdropDown, zoneID or dataID)
    end
end

function AtlasLoot.GetWishListSubheadingBoss(dataID)
    local bossName = AtlasLoot_TableNames[dataID] and AtlasLoot_TableNames[dataID][1]
    return bossName
end

-- TODO: this is not translated
function AtlasLoot.GetLootTableParentName(dataID)
    if not dataID then return end
    local name
    for i, v in pairs(AtlasLoot_TableNamesBoss) do
        for j, k in pairs(v) do
            if dataID == j then
                name = i
                break
            end
        end
    end
    return name
end

--[[
Group items with zone/event name etc, and format them by adding subheadings and empty lines
This function returns a single table with all items, use AtlasLoot_GetWishListPage to split it
]]
---@param info table AtlasLootCharDB["WishList"] or AtlasLootCharDB["SearchResult"]
function AtlasLoot.CategorizeWishList(info)
    local subheadings, categories, result = {}, {}, {}

    for k, v in pairs(info) do
        -- placeholder button indexes
        if table.getn(v) < 6 then
            table.insert(info[k], 1, 0)
        else
            info[k][1] = 0
        end
        local sourcePage = v[6]
        if sourcePage and sourcePage ~= "" then
            local dataID = string.gsub(sourcePage, "^(.+)|.+$", "%1", 1)
            -- Build subheading table
            if not subheadings[dataID] then
                if AtlasLootCharDB.WishlistGroupedByDungeon then
                    subheadings[dataID] = AtlasLoot.GetLootTableParentName(dataID) or (AtlasLoot_TableNames[dataID] and AtlasLoot_TableNames[dataID][1])
                else
                    subheadings[dataID] = AtlasLoot.GetWishListSubheadingBoss(dataID)
                end
                -- If still cant find it, mark it with Unknown
                if not subheadings[dataID] then subheadings[dataID] = L["Unknown"] end
            end
            -- Build category tables
            if not categories[subheadings[dataID]] then categories[subheadings[dataID]] = {} end
            table.insert(categories[subheadings[dataID]], v)
        end
    end

    -- Sort and flatten categories
    for text, data in pairs(categories) do
        -- Add a empty line between categories when in a same column
        if table.getn(result) > 1 and (table.getn(result) - math.floor(table.getn(result) / 15) * 15) > 0 then table.insert(result, { 0, 0, "", "", "", "" }) end
        -- If a subheading is on the last row of a column, push it to next column
        if ((table.getn(result) + 1) - math.floor((table.getn(result) + 1) / 15) * 15) == 0 then table.insert(result, { 0, 0, "", "", "", "" }) end

        local sourcePage = data[1][6] or ""
        local dataID = string.gsub(sourcePage, "^(.+)|.+$", "%1", 1)
        -- local dataSource = string.gsub(sourcePage, "^.+|(.+)$", "%1", 1)
        -- print(string.format("text: %s sourcePage: %s", tostring(text), tostring(sourcePage)))
        if AtlasLootCharDB.WishlistGroupedByDungeon then
            table.insert(result, { 0, 0, "", "=q6="..text, "" })
        else
            local subtext = AtlasLoot.GetLootTableParentName(dataID) or L["Unknown"]
            table.insert(result, { 0, 0, "", "=q6="..text, "=q0="..subtext })
        end

        table.sort(data, AtlasLoot.WishListSortCheck)
        for i = 1, table.getn(data) do
            if AtlasLootCharDB.WishlistGroupedByDungeon then
                sourcePage = data[i][6]
                dataID = string.gsub(sourcePage, "^(.+)|.+$", "%1", 1)
                -- dataSource = string.gsub(sourcePage, "^.+|(.+)$", "%1", 1)
                local bossName = AtlasLoot.GetWishListSubheadingBoss(dataID)
                if bossName then data[i][5] = bossName end
            end
            table.insert(result, data[i])
        end
    end

    -- set correct button indexes
    local buttonIndex = 1
    for i = 1, table.getn(result) do
        result[i][1] = buttonIndex
        buttonIndex = buttonIndex + (buttonIndex < 30 and 1 or -29)
    end

    return result
end

local WishListSlice = {}
--[[
Return partial data of WishList/SearchResult table
]]
---@param page number the page number needed
function AtlasLoot.GetWishListPage(page)
    if not AtlasLoot.WishList then AtlasLoot.WishList = AtlasLoot.CategorizeWishList(AtlasLootCharDB["WishList"]) end

    -- Calc for maximal pages
    local pageMax = math.ceil(table.getn(AtlasLoot.WishList) / 30)
    if page < 1 then page = 1 end
    if page > pageMax then page = pageMax end
    currentPage = page

    AtlasLoot.wipe(WishListSlice)
    local start = (page - 1) * 30 + 1
    for i = start, start + 29 do
        if not AtlasLoot.WishList[i] then break end
        table.insert(WishListSlice, AtlasLoot.WishList[i])
    end

    return WishListSlice, pageMax
end
