-- extra info on GameTooltip and ItemRefTooltip
local AtlasLootTip = CreateFrame("Frame", "AtlasLootTip", GameTooltip)
local strfind = string.find
local GetItemInfo = GetItemInfo
local GREY = "|cff999999"

local lastSearchName
local lastSearchID

local function GetItemIDByName(name)
    if not name then return nil end
    if name ~= lastSearchName then
        for itemID = 1, 99999 do
            local itemName = GetItemInfo(itemID)
            if (itemName and itemName == name) then
                lastSearchID = itemID
                break
            end
        end
        lastSearchName = name
    end
    return lastSearchID
end

local function HookTooltip(tooltip)
    local original_SetLootRollItem    = tooltip.SetLootRollItem
    local original_SetLootItem        = tooltip.SetLootItem
    local original_SetMerchantItem    = tooltip.SetMerchantItem
    local original_SetQuestLogItem    = tooltip.SetQuestLogItem
    local original_SetQuestItem       = tooltip.SetQuestItem
    local original_SetHyperlink       = tooltip.SetHyperlink
    local original_SetBagItem         = tooltip.SetBagItem
    local original_SetInboxItem       = tooltip.SetInboxItem
    local original_SetInventoryItem   = tooltip.SetInventoryItem
    local original_SetCraftItem       = tooltip.SetCraftItem
    local original_SetCraftSpell      = tooltip.SetCraftSpell
    local original_SetTradeSkillItem  = tooltip.SetTradeSkillItem
    local original_SetAuctionItem     = tooltip.SetAuctionItem
    local original_SetAuctionSellItem = tooltip.SetAuctionSellItem
    local original_SetTradePlayerItem = tooltip.SetTradePlayerItem
    local original_SetTradeTargetItem = tooltip.SetTradeTargetItem

    local original_OnHide = tooltip:GetScript("OnHide")

    tooltip:SetScript("OnHide", function()
        if original_OnHide then original_OnHide() end
        this.itemID = nil
    end)

    function tooltip.SetLootRollItem(self, rollID)
        original_SetLootRollItem(self, rollID)
        local _, _, id = strfind(GetLootRollItemLink(rollID) or "", "item:(%d+)")
        self.itemID = tonumber(id)
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetLootItem(self, slot)
        original_SetLootItem(self, slot)
        local _, _, id = strfind(GetLootSlotLink(slot) or "", "item:(%d+)")
        self.itemID = tonumber(id)
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetMerchantItem(self, merchantIndex)
        original_SetMerchantItem(self, merchantIndex)
        local _, _, id = strfind(GetMerchantItemLink(merchantIndex) or "", "item:(%d+)")
        self.itemID = tonumber(id)
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetQuestLogItem(self, itemType, index)
        original_SetQuestLogItem(self, itemType, index)
        local _, _, id = strfind(GetQuestLogItemLink(itemType, index) or "", "item:(%d+)")
        self.itemID = tonumber(id)
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetQuestItem(self, itemType, index)
        original_SetQuestItem(self, itemType, index)
        local _, _, id = strfind(GetQuestItemLink(itemType, index) or "", "item:(%d+)")
        self.itemID = tonumber(id)
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetHyperlink(self, arg1)
        original_SetHyperlink(self, arg1)
        local _, _, id = strfind(arg1 or "", "item:(%d+)")
        self.itemID = tonumber(id)
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetBagItem(self, container, slot)
        local hasCooldown, repairCost = original_SetBagItem(self, container, slot)
        local _, _, id = strfind(GetContainerItemLink(container, slot) or "", "item:(%d+)")
        self.itemID = tonumber(id)
        AtlasLootTip.extendTooltip(self)
        return hasCooldown, repairCost
    end

    function tooltip.SetInboxItem(self, mailID, attachmentIndex)
        original_SetInboxItem(self, mailID, attachmentIndex)
        local itemName = GetInboxItem(mailID)
        self.itemID = GetItemIDByName(itemName)
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetInventoryItem(self, unit, slot)
        local hasItem, hasCooldown, repairCost = original_SetInventoryItem(self, unit, slot)
        local _, _, id = strfind(GetInventoryItemLink(unit, slot) or "", "item:(%d+)")
        self.itemID = tonumber(id)
        AtlasLootTip.extendTooltip(self)
        return hasItem, hasCooldown, repairCost
    end

    function tooltip.SetCraftItem(self, skill, slot)
        original_SetCraftItem(self, skill, slot)
        local _, _, id = strfind(GetCraftReagentItemLink(skill, slot) or "", "item:(%d+)")
        self.itemID = tonumber(id)
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetCraftSpell(self, slot)
        original_SetCraftSpell(self, slot)
        local _, _, id = strfind(GetCraftItemLink(slot) or "", "item:(%d+)")
        self.itemID = tonumber(id)
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetTradeSkillItem(self, skillIndex, reagentIndex)
        original_SetTradeSkillItem(self, skillIndex, reagentIndex)
        if reagentIndex then
            local _, _, id = strfind(GetTradeSkillReagentItemLink(skillIndex, reagentIndex) or "", "item:(%d+)")
            self.itemID = tonumber(id)
        else
            local _, _, id = strfind(GetTradeSkillItemLink(skillIndex) or "", "item:(%d+)")
            self.itemID = tonumber(id)
        end
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetAuctionItem(self, atype, index)
        original_SetAuctionItem(self, atype, index)
        local itemName = GetAuctionItemInfo(atype, index)
        self.itemID = GetItemIDByName(itemName)
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetAuctionSellItem(self)
        original_SetAuctionSellItem(self)
        local itemName = GetAuctionSellItemInfo()
        self.itemID = GetItemIDByName(itemName)
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetTradePlayerItem(self, index)
        original_SetTradePlayerItem(self, index)
        local _, _, id = strfind(GetTradePlayerItemLink(index) or "", "item:(%d+)")
        self.itemID = tonumber(id)
        AtlasLootTip.extendTooltip(self)
    end

    function tooltip.SetTradeTargetItem(self, index)
        original_SetTradeTargetItem(self, index)
        local _, _, id = strfind(GetTradeTargetItemLink(index) or "", "item:(%d+)")
        self.itemID = tonumber(id)
        AtlasLootTip.extendTooltip(self)
    end
end

local sets = {
    ["SpiritofEskhandar"] = true,
    ["HakkariBlades"] = true,
    ["PrimalBlessing"] = true,
    ["ShardOfGods"] = true,
    ["DalRend"] = true,
    ["SpiderKiss"] = true,
    ["UnobMounts"] = true,
    ["Legendaries"] = true,
    ["Artifacts"] = true,
    ["ZGRings"] = true,
    ["Tabards"] = true,
}

local function SetContains(set, key)
	if not set or not key then
		return false
	end
	return set[key] ~= nil
end

local lastItemID, lastSourceStr, lastDropRate
function AtlasLootTip.extendTooltip(tooltip)
	if not AtlasLootCharDB.ShowSource then
		return
	end
	local tooltipName = tooltip:GetName()
    local itemName = getglobal(tooltipName .. "TextLeft1"):GetText()
	local line2 = getglobal(tooltipName .. "TextLeft2")
	local craftSpell, source, sourceStr, dropRate
	local isCraft, isWBLoot, isPvP, isRepReward, isSetPiece, isWorldEvent = false, false, false, false, false, false
	local itemID = tonumber(tooltip.itemID)
	if itemName and itemID and itemID ~= 51217 then -- 51217 Fashion Coin
		if itemID ~= lastItemID then
			for row = 1, tooltip:NumLines() do
                local rowtext = getglobal(tooltipName.."TextLeft"..row):GetText()
                -- skip items that state which rep they require
				if strfind(rowtext or "", "—", 1, true) then
					return
				end
			end
			-- first check if its craftable item
			for k,v in pairs(GetSpellInfoAtlasLootDB["craftspells"]) do
				if v["craftItem"] == itemID then
					craftSpell = "s"..tostring(k)
					break
				end
			end
			for k, v in pairs(GetSpellInfoAtlasLootDB["enchants"]) do
				if v["item"] and v["item"] == itemID then
					craftSpell = "e"..tostring(k)
					break
				end
			end
			for k1, v1 in pairs(AtlasLoot_Data["AtlasLootCrafting"]) do
				if source then
					break
				end
				for k2, v2 in pairs(AtlasLoot_Data["AtlasLootCrafting"][k1]) do
					if v2[1] ~= 0 and v2[1] ~= "" --[[and string.sub(v2[1], 1, 1) ~= "e"]] then
						if (v2[1] == craftSpell or v2[1] == itemID) and
							(strfind(k1, "Apprentice", 1, true) or
								strfind(k1, "Journeyman", 1, true) or
								strfind(k1, "Expert", 1, true) or
								strfind(k1, "Artisan", 1, true) or
								strfind(k1, "Goblin", 1, true) or
								strfind(k1, "Gnomish", 1, true) or
								strfind(k1, "Survival", 1, true) or
								strfind(k1, "Herbalism", 1, true) or
								strfind(k1, "FirstAid", 1, true) or
								strfind(k1, "Poisons", 1, true) or
								strfind(k1, "Mining", 1, true) or
								strfind(k1, "Smelting", 1, true) or
								strfind(k1, "Elemental", 1, true) or
								strfind(k1, "Tribal", 1, true) or
								strfind(k1, "Dragonscale", 1, true) or
								strfind(k1, "Weaponsmith", 1, true) or
								strfind(k1, "Axesmith", 1, true) or
								strfind(k1, "Hammersmith", 1, true) or
								strfind(k1, "Swordsmith", 1, true) or
								strfind(k1, "Armorsmith", 1, true) or
								strfind(k1, "Gemology", 1, true) or
								strfind(k1, "Goldsmithing", 1, true))
						then
							source = k1
							isCraft = true
							lastDropRate = nil
							-- if strfind(k1, "Apprentice", 1, true) then
							-- 	dropRate = "1-75"
							-- 	lastDropRate = dropRate
							-- elseif strfind(k1, "Journeyman", 1, true) then
							-- 	dropRate = "75-150"
							-- 	lastDropRate = dropRate
							-- elseif strfind(k1, "Expert", 1, true) then
							-- 	dropRate = "150-225"
							-- 	lastDropRate = dropRate
							-- elseif strfind(k1, "Artisan", 1, true) then
							-- 	dropRate = "225-300"
							-- 	lastDropRate = dropRate
							-- end
							break
						end
					end
				end
			end
			-- check if its world boss loot
			if not isCraft then
                for k1,v1 in pairs(AtlasLoot_Data["AtlasLootWBItems"]) do
					if source then
						break
					end
					for k2,v2 in pairs(AtlasLoot_Data["AtlasLootWBItems"][k1]) do
						if v2[1] == itemID then
							source = k1
							isWBLoot = true
                            if v2[5] and v2[5] ~= "" then
                                dropRate = v2[5]
                                lastDropRate = dropRate
                            else
                                lastDropRate = nil
                            end
							break
						end
					end
				end
			end
            -- check if its a pvp reward
            if not isCraft and not isWBLoot then
                for k1,v1 in pairs(AtlasLoot_Data["AtlasLootGeneralPvPItems"]) do
					if source then
						break
					end
					for k2,v2 in pairs(AtlasLoot_Data["AtlasLootGeneralPvPItems"][k1]) do
						if v2[1] == itemID then
							source = k1
							isPvP = true
                            lastDropRate = nil
							break
						end
					end
				end
            end
            -- check if its a rep reward
			-- bgs
            if not isCraft and not isWBLoot and not isPvP then
                for k1,v1 in pairs(AtlasLoot_Data["AtlasLootBGItems"]) do
					if source then
						break
					end
					for k2,v2 in pairs(AtlasLoot_Data["AtlasLootBGItems"][k1]) do
						if v2[1] == itemID then
							source = k1
							isRepReward = true
							if v2[5] and v2[5] ~= "" then
								dropRate = v2[5]
								lastDropRate = dropRate
							else
								lastDropRate = nil
							end
							break
						end
					end
				end
				-- factions
                for k1,v1 in pairs(AtlasLoot_Data["AtlasLootRepItems"]) do
					if source then
						break
					end
					for k2,v2 in pairs(AtlasLoot_Data["AtlasLootRepItems"][k1]) do
						if v2[1] == itemID then
							source = k1
							isRepReward = true
							if v2[5] and v2[5] ~= "" --[[and source ~= "Darkmoon" and not strfind(source, "Cenarion",1,true)]] then
								dropRate = v2[5]
								lastDropRate = dropRate
							else
								lastDropRate = nil
							end
							break
						end
					end
				end
            end
            -- check if its a set piece
			if not isCraft and not isWBLoot and not isPvP and not isRepReward then
				for k1,v1 in pairs(AtlasLoot_Data["AtlasLootSetItems"]) do
					if source then
						break
					end
					for k2,v2 in pairs(AtlasLoot_Data["AtlasLootSetItems"][k1]) do
						if v2[1] == itemID then
							source = k1
							isSetPiece = true
							if (SetContains(sets, source) or strfind(source, "WorldEpics",1,true)) then
								source = nil
								isSetPiece = false
							end
							lastDropRate = nil
							break
						end
					end
				end
			end
			-- check world events
			if not isCraft and not isWBLoot and not isPvP and not isRepReward and not isSetPiece then
				for k1,v1 in pairs(AtlasLoot_Data["AtlasLootWorldEvents"]) do
					if source then
						break
					end
					for k2,v2 in pairs(AtlasLoot_Data["AtlasLootWorldEvents"][k1]) do
						if v2[1] == itemID then
							source = k1
							isWorldEvent = true
							if v2[5] and v2[5] ~= "" then
								dropRate = v2[5]
								lastDropRate = dropRate
							else
								lastDropRate = nil
							end
							break
						end
					end
				end
			end
            -- check if its a dungeon/raid loot
			if not isCraft and not isWBLoot and not isPvP and not isRepReward and not isWorldEvent and not isSetPiece then
				for k1,v1 in pairs(AtlasLoot_Data["AtlasLootItems"]) do
					if source then
						break
					end
					for k2,v2 in pairs(AtlasLoot_Data["AtlasLootItems"][k1]) do
						if v2[1] == itemID then
							if k1 ~= "VanillaKeys" then
								source = k1
							end
							if v2[5] and v2[5] ~= "" then
								dropRate = v2[5]
								lastDropRate = dropRate
							else
								lastDropRate = nil
							end
							break
						end
					end
				end
				-- check containers
				for k1,v1 in pairs(AtlasLoot_Data["AtlasLootItems"]) do
					if source then
						break
					end
					for k2,v2 in pairs(AtlasLoot_Data["AtlasLootItems"][k1]) do
						if source then
							break
						end
						if v2[16] then
							for i, n in pairs(v2[16]) do
								if source then
									break
								end
								for i2, n2 in pairs(v2[16][i]) do
									if v2[16][i][i2][1] == itemID then
										source = k1
										break
									end
								end
							end
						end
					end
				end
			end
			lastItemID = itemID
			if not source then
				lastSourceStr = nil
                return
			end
			for k,v in pairs(AtlasLoot_TableNames) do
				if k == source then
					sourceStr = AtlasLoot_TableNames[k][1]
					lastSourceStr = sourceStr
					break
				end
			end
			
			if not sourceStr then
				return
			end

			if line2 and line2:GetText() then
				if dropRate then
					line2:SetText(GREY..sourceStr.." ("..dropRate..")|r\n"..line2:GetText())
				else
					line2:SetText(GREY..sourceStr.."|r\n"..line2:GetText())
				end
			else
				if dropRate then
					tooltip:AddLine(GREY..sourceStr.." ("..dropRate..")|r")
				else
					tooltip:AddLine(GREY..sourceStr.."|r")
				end
			end
		elseif itemID == lastItemID then
			if lastSourceStr then
				if line2:GetText() then
					if lastDropRate then
						line2:SetText(GREY..lastSourceStr.." ("..lastDropRate..")|r\n"..line2:GetText())
					else
						line2:SetText(GREY..lastSourceStr.."|r\n"..line2:GetText())
					end
				else
					if lastDropRate then
						tooltip:AddLine(GREY..lastSourceStr.." ("..lastDropRate..")|r")
					else
						tooltip:AddLine(GREY..lastSourceStr.."|r")
					end
				end
			end
		end
	end
	tooltip:Show()
end

HookTooltip(GameTooltip)
HookTooltip(ItemRefTooltip)

AtlasLootTip:SetScript("OnShow", function()
	if aux_frame and aux_frame:IsVisible() then
        if GetMouseFocus():GetParent() then
            if GetMouseFocus():GetParent().row then
                if GetMouseFocus():GetParent().row.record.item_id then
                    GameTooltip.itemID = GetMouseFocus():GetParent().row.record.item_id
                end
            end
        end
        AtlasLootTip.extendTooltip(GameTooltip)
    end
end)

-- adapted from http://shagu.org/ShaguTweaks/
AtlasLootTip.HookAddonOrVariable = function(addon, func)
    local lurker = CreateFrame("Frame", nil)
    lurker.func = func
    lurker:RegisterEvent("ADDON_LOADED")
    lurker:RegisterEvent("VARIABLES_LOADED")
    lurker:RegisterEvent("PLAYER_ENTERING_WORLD")
    lurker:SetScript("OnEvent",function()
		if IsAddOnLoaded(addon) or getglobal(addon) then
			this:func()
			this:UnregisterAllEvents()
		end
    end)
end

AtlasLootTip.HookAddonOrVariable("Tmog", function()
    HookTooltip(TmogTooltip)
end)
