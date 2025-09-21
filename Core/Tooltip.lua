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

local WrappingLines = {
	["^Set:"] = gsub("^"..ITEM_SET_BONUS, "%%s", ""),
	["^%(%d%) Set:"] = gsub(gsub(ITEM_SET_BONUS_GRAY, "%(%%d%)", "^%%(%%d%%)"), "%%s", ""),
	["^Effect:"] = gsub("^"..ITEM_SPELL_EFFECT, "%%s", ""),
	["^Equip:"] = "^"..ITEM_SPELL_TRIGGER_ONEQUIP,
	["^Chance on hit:"] = "^"..ITEM_SPELL_TRIGGER_ONPROC,
	["^Use:"] = "^"..ITEM_SPELL_TRIGGER_ONUSE,
	["^\nRequires"] = "^\n"..gsub(ITEM_REQ_SKILL, "%%s", "")
}

local lines = {}
for i = 1, 30 do
	lines[i] = {}
end

local function AddSourceLine(tooltip, sourceStr)
	local name = tooltip:GetName()
	local numLines = tooltip:NumLines()
	local left, right
	local leftText, rightText
	local leftR, leftG, leftB
	local rightR, rightG, rightB
	local wrap

	for i in pairs(lines) do
		for j in pairs(lines[i]) do
			lines[i][j] = nil
		end
	end

	for i = 1, numLines do
		left = _G[name .. "TextLeft" .. i]
		right = _G[name .. "TextRight" .. i]
		leftText = left:GetText()
		rightText = right:IsShown() and right:GetText()
		leftR, leftG, leftB = left:GetTextColor()
		rightR, rightG, rightB = right:GetTextColor()
		lines[i][1] = leftText
		lines[i][2] = rightText
		lines[i][3] = leftR
		lines[i][4] = leftG
		lines[i][5] = leftB
		lines[i][6] = rightR
		lines[i][7] = rightG
		lines[i][8] = rightB
	end

	if not lines[1][1] then
		return
	end

	tooltip:SetText(lines[1][1], lines[1][3], lines[1][4], lines[1][5], 1, false)

	if numLines < 28 then
		tooltip:AddLine(sourceStr)
	elseif lines[2][1] then
		lines[2][1] = sourceStr .. "\n" .. lines[2][1]
	end

	for i = 2, getn(lines) do
		if lines[i][2] then
			tooltip:AddDoubleLine(lines[i][1], lines[i][2], lines[i][3], lines[i][4], lines[i][5], lines[i][6], lines[i][7], lines[i][8])
		else
			wrap = false
			if strsub(lines[i][1] or "", 1, 1) == "\"" then
				wrap = true
			else
				for _, pattern in pairs(WrappingLines) do
					if strfind(lines[i][1] or "", pattern) then
						wrap = true
						break
					end
				end
			end
			tooltip:AddLine(lines[i][1], lines[i][3], lines[i][4], lines[i][5], wrap)
		end
	end
end

local lastItemID, lastSourceStr
local function ExtendTooltip(tooltip)
	if AtlasLootCharDB.ShowSource then
		local itemID = tonumber(tooltip.itemID)
		if itemID and itemID ~= 51217 then -- 51217 Fashion Coin
			if itemID ~= lastItemID then
				lastItemID = itemID
				lastSourceStr = nil
				local source = AtlasLoot_Data["AtlasLootSources"][itemID]
				if source then
					local str = GREY .. source .. "|r"
					lastSourceStr = str
				end
			end
			if lastSourceStr then
				AddSourceLine(tooltip, lastSourceStr)
				tooltip:Show()
			end
		end
	end
	if tooltipMoney > 0 then
		original_SetTooltipMoney(tooltip, tooltipMoney)
		tooltip:Show()
	end
end

local lastSearchName
local lastSearchID

local function GetItemIDByName(name)
	if not name then return nil end
	if name ~= lastSearchName then
		for itemID = 1, 99999 do
			local itemName = GetItemInfo(itemID)
			if itemName and itemName == name then
				lastSearchID = itemID
				break
			end
		end
		lastSearchName = name
	end
	return lastSearchID
end

local function HookTooltip(tooltip)
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
		local _, _, id = strfind(GetLootRollItemLink(rollID) or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
	end

	function tooltip.SetLootItem(self, slot)
		insideHook = true
		original_SetLootItem(self, slot)
		insideHook = false
		local _, _, id = strfind(GetLootSlotLink(slot) or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
	end

	function tooltip.SetMerchantItem(self, merchantIndex)
		insideHook = true
		original_SetMerchantItem(self, merchantIndex)
		insideHook = false
		local _, _, id = strfind(GetMerchantItemLink(merchantIndex) or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
	end

	function tooltip.SetQuestLogItem(self, itemType, index)
		insideHook = true
		original_SetQuestLogItem(self, itemType, index)
		insideHook = false
		local _, _, id = strfind(GetQuestLogItemLink(itemType, index) or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
	end

	function tooltip.SetQuestItem(self, itemType, index)
		insideHook = true
		original_SetQuestItem(self, itemType, index)
		insideHook = false
		local _, _, id = strfind(GetQuestItemLink(itemType, index) or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
	end

	function tooltip.SetHyperlink(self, arg1)
		insideHook = true
		original_SetHyperlink(self, arg1)
		insideHook = false
		local _, _, id = strfind(arg1 or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
	end

	function tooltip.SetBagItem(self, container, slot)
		insideHook = true
		local hasCooldown, repairCost = original_SetBagItem(self, container, slot)
		insideHook = false
		local _, _, id = strfind(GetContainerItemLink(container, slot) or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
		return hasCooldown, repairCost
	end

	function tooltip.SetInboxItem(self, mailID, attachmentIndex)
		insideHook = true
		original_SetInboxItem(self, mailID, attachmentIndex)
		insideHook = false
		local itemName = GetInboxItem(mailID)
		self.itemID = GetItemIDByName(itemName)
		ExtendTooltip(self)
	end

	function tooltip.SetInventoryItem(self, unit, slot)
		insideHook = true
		local hasItem, hasCooldown, repairCost = original_SetInventoryItem(self, unit, slot)
		insideHook = false
		local _, _, id = strfind(GetInventoryItemLink(unit, slot) or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
		return hasItem, hasCooldown, repairCost
	end

	function tooltip.SetCraftItem(self, skill, slot)
		insideHook = true
		original_SetCraftItem(self, skill, slot)
		insideHook = false
		local _, _, id = strfind(GetCraftReagentItemLink(skill, slot) or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
	end

	function tooltip.SetCraftSpell(self, slot)
		insideHook = true
		original_SetCraftSpell(self, slot)
		insideHook = false
		local _, _, id = strfind(GetCraftItemLink(slot) or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
	end

	function tooltip.SetTradeSkillItem(self, skillIndex, reagentIndex)
		insideHook = true
		original_SetTradeSkillItem(self, skillIndex, reagentIndex)
		insideHook = false
		if reagentIndex then
			local _, _, id = strfind(GetTradeSkillReagentItemLink(skillIndex, reagentIndex) or "", "item:(%d+)")
			self.itemID = tonumber(id)
		else
			local _, _, id = strfind(GetTradeSkillItemLink(skillIndex) or "", "item:(%d+)")
			self.itemID = tonumber(id)
		end
		ExtendTooltip(self)
	end

	function tooltip.SetAuctionItem(self, atype, index)
		insideHook = true
		original_SetAuctionItem(self, atype, index)
		insideHook = false
		local _, _, id = strfind(GetAuctionItemLink(atype, index) or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
	end

	function tooltip.SetAuctionSellItem(self)
		insideHook = true
		original_SetAuctionSellItem(self)
		insideHook = false
		self.itemID = tonumber(GetItemIDByName(GetAuctionSellItemInfo()))
		ExtendTooltip(self)
	end

	function tooltip.SetTradePlayerItem(self, index)
		insideHook = true
		original_SetTradePlayerItem(self, index)
		insideHook = false
		local _, _, id = strfind(GetTradePlayerItemLink(index) or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
	end

	function tooltip.SetTradeTargetItem(self, index)
		insideHook = true
		original_SetTradeTargetItem(self, index)
		insideHook = false
		local _, _, id = strfind(GetTradeTargetItemLink(index) or "", "item:(%d+)")
		self.itemID = tonumber(id)
		ExtendTooltip(self)
	end
end

local original_SetItemRef = SetItemRef
function SetItemRef(link, text, button)
	local item, _, id = string.find(link, "item:(%d+)")
	ItemRefTooltip.itemID = id
	original_SetItemRef(link, text, button)
	if not IsShiftKeyDown() and not IsControlKeyDown() and item then
		ExtendTooltip(ItemRefTooltip)
	end
end

local original_OnHide = ItemRefTooltip:GetScript("OnHide")
ItemRefTooltip:SetScript("OnHide", function()
	original_OnHide()
	ItemRefTooltip.itemID = nil
end)

AtlasLootTip:SetScript("OnShow", function()
	if aux_frame and aux_frame:IsShown() then
		if GetMouseFocus() and GetMouseFocus():GetParent() and GetMouseFocus():GetParent().row and GetMouseFocus():GetParent().row.record then
			GameTooltip.itemID = GetMouseFocus():GetParent().row.record.item_id
			ExtendTooltip(GameTooltip)
		end
	end
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
