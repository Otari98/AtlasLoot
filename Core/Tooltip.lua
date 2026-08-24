-- extra info on GameTooltip and ItemRefTooltip
local AtlasLootTip = CreateFrame("Frame", "AtlasLootTip", GameTooltip)
local strfind = string.find
local GetItemInfo = GetItemInfo
local GREY = "|cff999999"
local _G = _G or getfenv(0)

local insideHook = false
local tooltipMoney = 0
local original_SetTooltipMoney = SetTooltipMoney
function SetTooltipMoney(frame, money)
	if insideHook then
		tooltipMoney = money or 0
	else
		original_SetTooltipMoney(frame, money)
	end
end

local lastItemID, lastSourceStr
local function ExtendTooltip(tooltip)
	if not AtlasLootCharDB.ShowSource then return end
	local itemID = tonumber(tooltip.itemID)
	if not itemID then return end
	if itemID ~= lastItemID then
		lastItemID = itemID
		lastSourceStr = nil
		local source = AtlasLoot_Data["AtlasLootSources"][itemID]
		if source then
			local str = GREY..source.."|r"
			lastSourceStr = str
		end
	end
	if lastSourceStr then
		tooltip:AddLine(lastSourceStr)
		tooltip:Show()
	end
	if tooltipMoney > 0 then
		original_SetTooltipMoney(tooltip, tooltipMoney)
		tooltip:Show()
	end
end

local IDCache = {}

local function GetItemIDByName(name)
	if not name then return nil end
	if IDCache[name] then return IDCache[name] ~= 0 and IDCache[name] or nil end
	for itemID = 1, 99999 do
		if GetItemInfo(itemID) == name then
			IDCache[name] = itemID
			return itemID
		end
	end
	IDCache[name] = 0
	return nil
end

local function IDFromLink(link)
	if not link then return nil end
	local _, _, id = strfind(link, "item:(%d+)")
	return tonumber(id)
end

local function HookTooltip(tooltip)
	if not tooltip then return end

	if tooltip.HookScript then
		tooltip:HookScript("OnHide", function(self)
			self.itemID = nil
			tooltipMoney = 0
		end)
		tooltip:HookScript("OnTooltipSetItem", function(self)
			local itemName, itemLink, itemID = self:GetItem()
			self.itemID = itemID or IDFromLink(itemLink)
			ExtendTooltip(self)
		end)
		return
	end

	local original_SetLootRollItem = tooltip.SetLootRollItem
	local original_SetLootItem = tooltip.SetLootItem
	local original_SetMerchantItem = tooltip.SetMerchantItem
	local original_SetQuestLogItem = tooltip.SetQuestLogItem
	local original_SetQuestItem = tooltip.SetQuestItem
	local original_SetHyperlink = tooltip.SetHyperlink
	local original_SetBagItem = tooltip.SetBagItem
	local original_SetInboxItem = tooltip.SetInboxItem
	local original_SetInventoryItem = tooltip.SetInventoryItem
	local original_SetCraftItem = tooltip.SetCraftItem
	local original_SetCraftSpell = tooltip.SetCraftSpell
	local original_SetTradeSkillItem = tooltip.SetTradeSkillItem
	local original_SetAuctionItem = tooltip.SetAuctionItem
	local original_SetAuctionSellItem = tooltip.SetAuctionSellItem
	local original_SetTradePlayerItem = tooltip.SetTradePlayerItem
	local original_SetTradeTargetItem = tooltip.SetTradeTargetItem

	local original_OnHide = tooltip:GetScript("OnHide")

	tooltip:SetScript("OnHide", function()
		if original_OnHide then original_OnHide() end
		this.itemID = nil
		tooltipMoney = 0
	end)

	function tooltip.SetLootRollItem(self, rollID)
		insideHook = true
		original_SetLootRollItem(self, rollID)
		insideHook = false
		self.itemID = IDFromLink(GetLootRollItemLink(rollID))
		ExtendTooltip(self)
	end

	function tooltip.SetLootItem(self, slot)
		insideHook = true
		original_SetLootItem(self, slot)
		insideHook = false
		self.itemID = IDFromLink(GetLootSlotLink(slot))
		ExtendTooltip(self)
	end

	function tooltip.SetMerchantItem(self, merchantIndex)
		insideHook = true
		original_SetMerchantItem(self, merchantIndex)
		insideHook = false
		self.itemID = IDFromLink(GetMerchantItemLink(merchantIndex))
		ExtendTooltip(self)
	end

	function tooltip.SetQuestLogItem(self, itemType, index)
		insideHook = true
		original_SetQuestLogItem(self, itemType, index)
		insideHook = false
		self.itemID = IDFromLink(GetQuestLogItemLink(itemType, index))
		ExtendTooltip(self)
	end

	function tooltip.SetQuestItem(self, itemType, index)
		insideHook = true
		original_SetQuestItem(self, itemType, index)
		insideHook = false
		self.itemID = IDFromLink(GetQuestItemLink(itemType, index))
		ExtendTooltip(self)
	end

	function tooltip.SetHyperlink(self, arg1)
		insideHook = true
		original_SetHyperlink(self, arg1)
		insideHook = false
		self.itemID = IDFromLink(arg1)
		ExtendTooltip(self)
	end

	function tooltip.SetBagItem(self, container, slot)
		insideHook = true
		local hasCooldown, repairCost = original_SetBagItem(self, container, slot)
		insideHook = false
		self.itemID = IDFromLink(GetContainerItemLink(container, slot))
		ExtendTooltip(self)
		return hasCooldown, repairCost
	end

	function tooltip.SetInboxItem(self, mailID, attachmentIndex)
		insideHook = true
		original_SetInboxItem(self, mailID, attachmentIndex)
		insideHook = false
		if GetInboxItemLink then
			self.itemID = IDFromLink(GetInboxItemLink(mailID, attachmentIndex))
		else
			self.itemID = GetItemIDByName(GetInboxItem(mailID, attachmentIndex))
		end
		ExtendTooltip(self)
	end

	function tooltip.SetInventoryItem(self, unit, slot)
		insideHook = true
		local hasItem, hasCooldown, repairCost = original_SetInventoryItem(self, unit, slot)
		insideHook = false
		self.itemID = IDFromLink(GetInventoryItemLink(unit, slot))
		ExtendTooltip(self)
		return hasItem, hasCooldown, repairCost
	end

	function tooltip.SetCraftItem(self, skill, slot)
		insideHook = true
		original_SetCraftItem(self, skill, slot)
		insideHook = false
		self.itemID = IDFromLink(GetCraftReagentItemLink(skill, slot))
		ExtendTooltip(self)
	end

	function tooltip.SetCraftSpell(self, slot)
		insideHook = true
		original_SetCraftSpell(self, slot)
		insideHook = false
		self.itemID = IDFromLink(GetCraftItemLink(slot))
		ExtendTooltip(self)
	end

	function tooltip.SetTradeSkillItem(self, skillIndex, reagentIndex)
		insideHook = true
		original_SetTradeSkillItem(self, skillIndex, reagentIndex)
		insideHook = false
		if reagentIndex then
			self.itemID = IDFromLink(GetTradeSkillReagentItemLink(skillIndex, reagentIndex))
		else
			self.itemID = IDFromLink(GetTradeSkillItemLink(skillIndex))
		end
		ExtendTooltip(self)
	end

	function tooltip.SetAuctionItem(self, atype, index)
		insideHook = true
		original_SetAuctionItem(self, atype, index)
		insideHook = false
		self.itemID = IDFromLink(GetAuctionItemLink(atype, index))
		ExtendTooltip(self)
	end

	function tooltip.SetAuctionSellItem(self)
		insideHook = true
		original_SetAuctionSellItem(self)
		insideHook = false
		local name, texture, count, quality, canUse, price, maxStack, itemLink = GetAuctionSellItemInfo()
		if itemLink then
			self.itemID = IDFromLink(itemLink)
		else
			self.itemID = tonumber(GetItemIDByName(name))
		end
		ExtendTooltip(self)
	end

	function tooltip.SetTradePlayerItem(self, index)
		insideHook = true
		original_SetTradePlayerItem(self, index)
		insideHook = false
		self.itemID = IDFromLink(GetTradePlayerItemLink(index))
		ExtendTooltip(self)
	end

	function tooltip.SetTradeTargetItem(self, index)
		insideHook = true
		original_SetTradeTargetItem(self, index)
		insideHook = false
		self.itemID = IDFromLink(GetTradeTargetItemLink(index))
		ExtendTooltip(self)
	end
end

AtlasLootTip:SetScript("OnShow", function()
	if not (aux_frame and aux_frame:IsShown()) then return end
	local focus = GetMouseFocus()
	if not focus then return end
	local parent = focus:GetParent()
	if not (parent and parent.row and parent.row.record) then return end
	GameTooltip.itemID = tonumber(parent.row.record.item_id)
	ExtendTooltip(GameTooltip)
end)

-- adapted from http://shagu.org/ShaguTweaks/
AtlasLootTip.HookAddonOrVariable = function(addon, func)
	local lurker = CreateFrame("Frame", nil)
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

AtlasLootTip.HookAddonOrVariable("Tmog", function()
	HookTooltip(TmogTooltip)
end)

HookTooltip(GameTooltip)
HookTooltip(ItemRefTooltip)
