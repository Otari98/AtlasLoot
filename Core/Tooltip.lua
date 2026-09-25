-- extra info on GameTooltip and ItemRefTooltip
local strfind = string.find
local GetItemInfo = GetItemInfo
local GREY = "|cff999999"
local _G = _G or getfenv(0)

local original_SetTooltipMoney = SetTooltipMoney
function SetTooltipMoney(frame, money)
	if frame.insideHook then
		frame.tooltipMoney = tonumber(money) or 0
	else
		original_SetTooltipMoney(frame, money)
	end
end

local function ExtendTooltip(tooltip)
	if AtlasLootCharDB.ShowSource then
		local itemID = tonumber(tooltip.itemID)
		if itemID then
			local str
			local source = AtlasLoot_Data["AtlasLootSources"][itemID]
			if source then
				str = GREY..source.."|r"
			end
			if str then
				tooltip:AddLine(str)
				tooltip.atlasLootLine = str
				tooltip:Show()
			end
		end
	end
	local money = tonumber(tooltip.tooltipMoney) or 0
	if money > 0 then
		original_SetTooltipMoney(tooltip, money)
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
	if not (tooltip and type(tooltip.GetFrameType) == "function" and tooltip:GetFrameType() == "GameTooltip") then
		return
	end

	if type(tooltip.HookScript) == "function" then
		tooltip:HookScript("OnTooltipSetItem", function(self)
			local itemName, itemLink, itemID = self:GetItem()
			self.itemID = itemID or IDFromLink(itemLink)
		end)
		tooltip:HookScript("OnTooltipCleared", function(self)
			self.itemID = nil
			self.atlasLootLine = nil
			self.tooltipMoney = 0
		end)
		for _, method in pairs({
			"SetBagItem","SetInventoryItem","SetLootRollItem","SetLootItem","SetMerchantItem","SetQuestLogItem",
			"SetQuestItem","SetHyperlink","SetInboxItem","SetCraftItem","SetCraftSpell","SetTradeSkillItem",
			"SetAuctionItem","SetAuctionSellItem","SetTradePlayerItem","SetTradeTargetItem","SetAction","SetBuybackItem"
		}) do
			hooksecurefunc(tooltip, method, ExtendTooltip)
		end
		return
	end

	local original_SetBagItem = tooltip.SetBagItem
	function tooltip.SetBagItem(self, container, slot)
		self.insideHook = true
		local hasCooldown, repairCost = original_SetBagItem(self, container, slot)
		self.insideHook = nil
		self.itemID = IDFromLink(GetContainerItemLink(container, slot))
		ExtendTooltip(self)
		return hasCooldown, repairCost
	end

	local original_SetInventoryItem = tooltip.SetInventoryItem
	function tooltip.SetInventoryItem(self, unit, slot, nameOnly)
		self.insideHook = true
		local hasItem, hasCooldown, repairCost = original_SetInventoryItem(self, unit, slot, nameOnly)
		self.insideHook = nil
		self.itemID = IDFromLink(GetInventoryItemLink(unit, slot))
		ExtendTooltip(self)
		return hasItem, hasCooldown, repairCost
	end

	local original_SetLootRollItem = tooltip.SetLootRollItem
	function tooltip.SetLootRollItem(self, rollID)
		self.insideHook = true
		original_SetLootRollItem(self, rollID)
		self.insideHook = nil
		self.itemID = IDFromLink(GetLootRollItemLink(rollID))
		ExtendTooltip(self)
	end

	local original_SetLootItem = tooltip.SetLootItem
	function tooltip.SetLootItem(self, slot)
		self.insideHook = true
		original_SetLootItem(self, slot)
		self.insideHook = nil
		self.itemID = IDFromLink(GetLootSlotLink(slot))
		ExtendTooltip(self)
	end

	local original_SetMerchantItem = tooltip.SetMerchantItem
	function tooltip.SetMerchantItem(self, merchantIndex)
		self.insideHook = true
		original_SetMerchantItem(self, merchantIndex)
		self.insideHook = nil
		self.itemID = IDFromLink(GetMerchantItemLink(merchantIndex))
		ExtendTooltip(self)
	end

	local original_SetQuestLogItem = tooltip.SetQuestLogItem
	function tooltip.SetQuestLogItem(self, itemType, index)
		self.insideHook = true
		original_SetQuestLogItem(self, itemType, index)
		self.insideHook = nil
		self.itemID = IDFromLink(GetQuestLogItemLink(itemType, index))
		ExtendTooltip(self)
	end

	local original_SetQuestItem = tooltip.SetQuestItem
	function tooltip.SetQuestItem(self, itemType, index)
		self.insideHook = true
		original_SetQuestItem(self, itemType, index)
		self.insideHook = nil
		self.itemID = IDFromLink(GetQuestItemLink(itemType, index))
		ExtendTooltip(self)
	end

	local original_SetHyperlink = tooltip.SetHyperlink
	function tooltip.SetHyperlink(self, arg1)
		self.insideHook = true
		original_SetHyperlink(self, arg1)
		self.insideHook = nil
		self.itemID = IDFromLink(arg1)
		ExtendTooltip(self)
	end

	local original_SetInboxItem = tooltip.SetInboxItem
	function tooltip.SetInboxItem(self, mailID, attachmentIndex)
		self.insideHook = true
		original_SetInboxItem(self, mailID, attachmentIndex)
		self.insideHook = nil
		if GetInboxItemLink then
			self.itemID = IDFromLink(GetInboxItemLink(mailID, attachmentIndex))
		else
			self.itemID = GetItemIDByName(GetInboxItem(mailID, attachmentIndex))
		end
		ExtendTooltip(self)
	end

	local original_SetCraftItem = tooltip.SetCraftItem
	function tooltip.SetCraftItem(self, skill, slot)
		self.insideHook = true
		original_SetCraftItem(self, skill, slot)
		self.insideHook = nil
		self.itemID = IDFromLink(GetCraftReagentItemLink(skill, slot))
		ExtendTooltip(self)
	end

	local original_SetCraftSpell = tooltip.SetCraftSpell
	function tooltip.SetCraftSpell(self, slot)
		self.insideHook = true
		original_SetCraftSpell(self, slot)
		self.insideHook = nil
		self.itemID = IDFromLink(GetCraftItemLink(slot))
		ExtendTooltip(self)
	end

	local original_SetTradeSkillItem = tooltip.SetTradeSkillItem
	function tooltip.SetTradeSkillItem(self, skillIndex, reagentIndex)
		self.insideHook = true
		original_SetTradeSkillItem(self, skillIndex, reagentIndex)
		self.insideHook = nil
		if reagentIndex then
			self.itemID = IDFromLink(GetTradeSkillReagentItemLink(skillIndex, reagentIndex))
		else
			self.itemID = IDFromLink(GetTradeSkillItemLink(skillIndex))
		end
		ExtendTooltip(self)
	end

	local original_SetAuctionItem = tooltip.SetAuctionItem
	function tooltip.SetAuctionItem(self, atype, index)
		self.insideHook = true
		original_SetAuctionItem(self, atype, index)
		self.insideHook = nil
		self.itemID = IDFromLink(GetAuctionItemLink(atype, index))
		ExtendTooltip(self)
	end

	local original_SetAuctionSellItem = tooltip.SetAuctionSellItem
	function tooltip.SetAuctionSellItem(self)
		self.insideHook = true
		original_SetAuctionSellItem(self)
		self.insideHook = nil
		local name, texture, count, quality, canUse, price, maxStack, itemLink = GetAuctionSellItemInfo()
		if itemLink then
			self.itemID = IDFromLink(itemLink)
		else
			self.itemID = tonumber(GetItemIDByName(name))
		end
		ExtendTooltip(self)
	end

	local original_SetTradePlayerItem = tooltip.SetTradePlayerItem
	function tooltip.SetTradePlayerItem(self, index)
		self.insideHook = true
		original_SetTradePlayerItem(self, index)
		self.insideHook = nil
		self.itemID = IDFromLink(GetTradePlayerItemLink(index))
		ExtendTooltip(self)
	end

	local original_SetTradeTargetItem = tooltip.SetTradeTargetItem
	function tooltip.SetTradeTargetItem(self, index)
		self.insideHook = true
		original_SetTradeTargetItem(self, index)
		self.insideHook = nil
		self.itemID = IDFromLink(GetTradeTargetItemLink(index))
		ExtendTooltip(self)
	end

	local original_OnHide = tooltip:GetScript("OnHide")
	tooltip:SetScript("OnHide", function()
		if original_OnHide then original_OnHide(tooltip) end
		tooltip.itemID = nil
		tooltip.atlasLootLine = nil
		tooltip.tooltipMoney = 0
	end)
end

local AtlasLootTip = CreateFrame("Frame", "AtlasLootTip", GameTooltip)
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
local function HookAddonOrVariable(addon, func)
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

HookAddonOrVariable("Tmog", function()
	HookTooltip(TmogTooltip)
end)

HookTooltip(GameTooltip)
HookTooltip(ItemRefTooltip)
