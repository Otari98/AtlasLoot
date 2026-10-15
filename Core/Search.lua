local L = AtlasLoot.L

local GREY = "|cff999999"
local RED = RED_FONT_COLOR_CODE
local WHITE = "|cffFFFFFF"
local GREEN = GREEN_FONT_COLOR_CODE
local PURPLE = "|cff9F3FFF"
local BLUE = "|cff0070dd"
local ORANGE = "|cffFF8400"

local currentPage = 1
AtlasLoot.SearchResult = nil

function AtlasLoot.ShowSearchResult()
    AtlasLoot.Hewdrop:Close(1)
    AtlasLoot.ShowItemsFrame("SearchResultPage"..currentPage)
end

local function contains(itemID)
    if not itemID then return false end
    for k, v in pairs(AtlasLootCharDB["SearchResult"]) do
        if v[2] == itemID then return true end
    end
    return false
end

function AtlasLoot.Search(text)
    if not text then return end
    text = AtlasLoot.strtrim(text)
    if text == "" then return end
    text = string.lower(text)

    AtlasLootCharDB["SearchResult"] = {}
    AtlasLootCharDB.LastSearchedText = text

    local partial = AtlasLootCharDB.PartialMatching

    for dataSource, data in pairs(AtlasLoot_Data) do
        for dataID, record in pairs(data) do
            if type(record) == "table" then
                for _, value in ipairs(record) do
                    local mainData = value[2]
                    if not contains(mainData) then
                        local found = false
                        local iconData = value[3]
                        local textData = value[4]
                        local subTextData = value[5]
                        -- item
                        if type(mainData) == "number" and mainData > 0 then
                            local itemName, link, quality = GetItemInfo(mainData)
                            if not itemName then
                                itemName = string.gsub(textData, "=q%d+=", "")
                                local _, _, q = string.find(textData, "=q(%d+)=")
                                quality = q
                            end
                            if partial then
                                found = string.find(string.lower(itemName), text, 1, true)
                            else
                                found = string.lower(itemName) == text
                            end
                            if found then
                                if quality then itemName = "=q"..quality.."="..itemName end
                                table.insert(AtlasLootCharDB["SearchResult"], { 0, mainData, iconData, itemName, subTextData, dataID.."|"..dataSource })
                            end
                            -- enchant or spell
                        elseif type(mainData) == "string" and (string.sub(mainData, 1, 1) == "e" or string.sub(mainData, 1, 1) == "s") then
                            local spellName = string.gsub(textData, "=ds=", "")
                            spellName = string.gsub(textData, "=q%d=", "")
                            if partial then
                                found = string.find(string.lower(spellName), text, 1, true)
                            else
                                found = string.lower(spellName) == text
                            end
                            if found then
                                spellName = string.sub(textData, 1, 4)..spellName
                                table.insert(AtlasLootCharDB["SearchResult"], { 0, mainData, iconData, spellName, subTextData, dataID.."|"..dataSource })
                            end
                        end
                    end
                end
            end
        end
    end

    if getn(AtlasLootCharDB["SearchResult"]) == 0 then
        DEFAULT_CHAT_FRAME:AddMessage("["..ORANGE..L["AtlasLoot"].."|r] "..L["No match found for"].." \""..text.."\".")
    else
        currentPage = 1
        AtlasLoot.SearchResult = AtlasLoot.CategorizeWishList(AtlasLootCharDB["SearchResult"])
        AtlasLoot.ShowItemsFrame("SearchResultPage1")
    end
end

function AtlasLoot.ShowSearchOptions(self)
    if AtlasLoot.Hewdrop:IsOpen(self) then
        AtlasLoot.Hewdrop:Close(1)
        return
    end
    AtlasLoot.Hewdrop:Open(self,
        'point', function(parent)
            return "BOTTOMLEFT", "BOTTOMRIGHT"
        end,
        "children", function()
            AtlasLoot.Hewdrop:AddLine(
                "text", L["Search options"],
                "isTitle", true,
                "notCheckable", true
            )
            AtlasLoot.Hewdrop:AddLine(
                "text", L["Partial matching"],
                "checked", AtlasLootCharDB.PartialMatching,
                "tooltipTitle", L["Partial matching"],
                "tooltipText", L["If checked, AtlasLoot searches item names for a partial match."],
                "func", function() AtlasLootCharDB.PartialMatching = not AtlasLootCharDB.PartialMatching end
            )
        end
    )
end

function AtlasLoot.GetOriginalDataFromSearchResult(itemID)
    for i, v in ipairs(AtlasLootCharDB["SearchResult"]) do
        if v[2] == itemID then return v[2], v[3], v[4], v[5], v[6] end
    end
end

local SearchResultSlice = {}
-- Copied and modified from AtlasLoot.GetWishListPage
function AtlasLoot.GetSearchResultPage(page)
    if not AtlasLoot.SearchResult then AtlasLoot.SearchResult = AtlasLoot.CategorizeWishList(AtlasLootCharDB["SearchResult"]) end

    -- Calc for maximal pages
    local pageMax = math.ceil(getn(AtlasLoot.SearchResult) / 30)
    if page < 1 then page = 1 end
    if page > pageMax then page = pageMax end
    currentPage = page

    -- Table copy
    local result = AtlasLoot.wipe(SearchResultSlice)
    local start = (page - 1) * 30 + 1
    for i = start, start + 29 do
        if not AtlasLoot.SearchResult[i] then break end
        table.insert(result, AtlasLoot.SearchResult[i])
    end

    return result, pageMax
end
