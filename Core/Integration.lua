-- Atlas inegration
local L = AtlasLoot.L
AtlasLoot.Hooks = {} -- original Atlas functions

--[[
AtlasLoot_SetupForAtlas:
This function sets up the Atlas specific XML objects
]]
function AtlasLoot.SetupForAtlas()
	if not AtlasFrame then return end

	AtlasLoot.StopMovingBookmark(true)

	AtlasLoot.AnchorPoint = AtlasLoot.Anchor_Atlas

	local panel = AtlasLootPanel
	if not panel then
		panel = CreateFrame("Frame", "AtlasLootPanel", AtlasFrame)
		panel:SetWidth(533)
		panel:SetHeight(95)
		panel:SetPoint("TOPLEFT", AtlasFrame, "BOTTOMLEFT", 6, 6)
		panel:Show()
		panel:EnableMouse(true)
		panel:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			edgeSize = 32,
			insets = { left = 11, right = 12, top = 12, bottom = 11 },
		})
		panel._Title = panel:CreateTexture("$parent_Title", "ARTWORK")
		panel._Title:SetWidth(275)
		panel._Title:SetHeight(59)
		panel._Title:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
		panel._Title:SetPoint("BOTTOM", 0, -32)
		panel._TitleText = panel:CreateFontString("$parent_TitleText", "ARTWORK", "GameFontNormal")
		panel._TitleText:SetPoint("BOTTOM", panel._Title, "BOTTOM", 0, 35)
		panel._TitleText:SetText(L["AtlasLoot"])

		local button = CreateFrame("Button", "AtlasFrameAtlasLootButton", AtlasFrame, "UIPanelButtonTemplate2")
		button:SetWidth(90)
		button:SetHeight(20)
		button:SetPoint("TOPRIGHT", AtlasFrame, -250, -60)
		button:SetText("AtlasLoot")
		button:SetScript("OnClick", function()
			HideUIPanel(AtlasFrame)
			ShowUIPanel(AtlasLootDefaultFrame)
		end)
	end

	AtlasLoot.BookmarkFrames[1]:SetPoint("TOPLEFT", panel, "TOPLEFT", 22, -3)
	AtlasLoot.BookmarkFrames[1]:SetParent(panel)
	for i = 0, table.getn(AtlasLoot.BookmarkFrames) do
		local bookmark = AtlasLoot.BookmarkFrames[i]
		if i > 0 then
			bookmark:SetParent(panel)
			bookmark:Show()
			bookmark.DockRegion:SetFrameLevel(bookmark:GetFrameLevel() + 2)
		end
		bookmark.Left:SetTexCoord(0, 0.25, 1, 0)
		bookmark.Middle:SetTexCoord(0.25, 0.75, 1, 0)
		bookmark.Right:SetTexCoord(0.75, 1.0, 1, 0)
		bookmark.Left:SetPoint("TOPLEFT", 0, -10)
		bookmark.Text:SetPoint("LEFT", bookmark.Left, "RIGHT", 0, 6)
		bookmark.Highlight = bookmark:GetHighlightTexture()
		bookmark.Highlight:SetTexCoord(0, 1, 1, 0)
		bookmark.Highlight:SetPoint("TOPLEFT", bookmark.Left, 0, 6)
		bookmark.Highlight:SetPoint("BOTTOMRIGHT", bookmark.Right, 0, 6)
	end
	AtlasLootMoreBookmarksButton:SetParent(panel)
	AtlasLootWishListButton:SetParent(panel)
	AtlasLootWishListButton:ClearAllPoints()
	AtlasLootWishListButton:SetPoint("LEFT", panel, 23, -5)
	AtlasLootSearchBox:SetParent(panel)

	AtlasLootMoreBookmarksButton:Show()
	AtlasLootSearchBox:Show()
	AtlasLootWishListButton:Show()

	AtlasLootItemsFrame:SetBackdrop(nil)
	AtlasLootItemsFrame_Background:Show()
end

function AtlasLoot.SetupForDefault()
	AtlasLoot.StopMovingBookmark(true)

	AtlasLoot.AnchorPoint = AtlasLoot.Anchor_Default

	AtlasLoot.BookmarkFrames[1]:SetPoint("TOPLEFT", AtlasLootDefaultFrame, "TOPLEFT", 55, -80)
	AtlasLoot.BookmarkFrames[1]:SetParent(AtlasLootDefaultFrame)
	for i = 0, table.getn(AtlasLoot.BookmarkFrames) do
		local bookmark = AtlasLoot.BookmarkFrames[i]
		if i > 0 then
			bookmark:SetParent(AtlasLootDefaultFrame)
			bookmark:Show()
			bookmark.DockRegion:SetFrameLevel(bookmark:GetFrameLevel() + 2)
		end
		bookmark.Left:SetTexCoord(0, 0.25, 0, 1)
		bookmark.Middle:SetTexCoord(0.25, 0.75, 0, 1)
		bookmark.Right:SetTexCoord(0.75, 1.0, 0, 1)
		bookmark.Left:SetPoint("TOPLEFT", 0, 0)
		bookmark.Text:SetPoint("LEFT", bookmark.Left, "RIGHT", 0, -6)
		bookmark.Highlight = bookmark:GetHighlightTexture()
		bookmark.Highlight:SetTexCoord(0, 1, 0, 1)
		bookmark.Highlight:SetPoint("TOPLEFT", bookmark.Left, 0, -6)
		bookmark.Highlight:SetPoint("BOTTOMRIGHT", bookmark.Right, 0, -6)
	end
	AtlasLootMoreBookmarksButton:SetParent(AtlasLootDefaultFrame)
	AtlasLootWishListButton:SetParent(AtlasLootDefaultFrame)
	AtlasLootWishListButton:ClearAllPoints()
	AtlasLootWishListButton:SetPoint("BOTTOMLEFT", AtlasLootDefaultFrame, 56, 35)
	AtlasLootSearchBox:SetParent(AtlasLootDefaultFrame)

	AtlasLootMoreBookmarksButton:Show()
	AtlasLootSearchBox:Show()
	AtlasLootWishListButton:Show()

	AtlasLootItemsFrame:SetBackdrop(AtlasLoot.Backdrop)
	AtlasLootItemsFrame:SetBackdropColor(unpack(AtlasLoot.BackdropColor))
	AtlasLootItemsFrame:SetBackdropBorderColor(unpack(AtlasLoot.BackdropBorderColor))
	AtlasLootItemsFrame_Background:Hide()
end

--[[
AtlasLoot.AtlasEntry_OnClick:
Invoked whenever a boss line in Atlas is clicked
Shows a loot page if one is associated with the button
]]
function AtlasLoot.AtlasEntry_OnClick()
    local self = this
	local id = self.idnum
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone]
	-- If the loot table was already shown and boss clicked again, hide the loot table and fix boss list icons
	if self._Selected:IsVisible() then
		self._Selected:Hide()
		self._Loot:Show()
		AtlasLootItemsFrame:Hide()
		AtlasLootItemsFrame.activeBoss = nil
	else
		-- If an loot table is associated with the button, show it.  Note multiple tables need to be checked due to the database structure
		if AtlasLootBossButtons[zoneID] and AtlasLootBossButtons[zoneID][id] then
			self._Selected:Show()
			self._Loot:Hide()
			AtlasLoot.ShowItemsFrame(AtlasLootBossButtons[zoneID][id])
			AtlasLootItemsFrame.activeBoss = id
			AtlasLoot.AtlasScrollBar_Update()
		end
	end
	-- This has been invoked from Atlas, so we remove any claim external mods have on the loot table
	AtlasLootItemsFrame.externalBoss = nil
	-- Hide the AtlasQuest frame if present so that the AtlasLoot items frame is not stuck under it
	if AtlasQuestInsideFrame then
		AtlasQuestInsideFrame:Hide()
	end
end

--[[
AtlasLoot_Refresh:
Replacement for Atlas_Refresh, required as the template for the boss buttons in Atlas is insufficient
Called whenever the state of Atlas changes
]]
function AtlasLoot.Atlas_Refresh(keepSelection)
	-- Call original function
	AtlasLoot.Hooks.Atlas_Refresh()

	-- Reset which loot page is 'current'
	if not keepSelection then
		AtlasLootItemsFrame.activeBoss = nil
	end
	if AtlasLootItemsFrame.activeBoss then
		AtlasLootItemsFrame:Show()
	else
		AtlasLootItemsFrame:Hide()
	end

	for i = 1, ATLAS_NUM_LINES do
		local entry = _G["AtlasEntry"..i]
		if entry and not entry._Loot then
			-- Add deselected icon
			local loot = entry:CreateTexture("$parent_Loot", "OVERLAY")
			loot:SetWidth(16)
			loot:SetHeight(16)
			loot:SetPoint("RIGHT", entry, 0, 0)
			loot:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\looticon")
			loot:Show()
            entry._Loot = loot
			-- Add selected icon
			local selected = entry:CreateTexture("$parent_Selected", "OVERLAY")
			selected:SetWidth(16)
			selected:SetHeight(16)
			selected:SetPoint("RIGHT", entry, 0, 0)
			selected:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\gold")
			selected:Hide()
            entry._Selected = selected
			-- Add OnClick function
			entry:SetScript("OnClick", AtlasLoot.AtlasEntry_OnClick)
			entry:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		end
	end
end


--[[
AtlasLoot_Atlas_OnShow:
Hooks Atlas_OnShow() to add extra setup routines that AtlasLoot needs for
integration purposes.
]]
function AtlasLoot.Atlas_OnShow()
	AtlasLoot.SetupForAtlas()
	AtlasLootDefaultFrame:Hide()
	AtlasLootItemsFrame:Hide()
	AtlasLoot.Atlas_Refresh(true)
	-- Call the Atlas function
	AtlasLoot.Hooks.Atlas_OnShow()
	-- If we were looking at a loot table earlier in the session, it is still
	-- saved on the item frame, so restore it in Atlas
	if AtlasLootItemsFrame.activeBoss then
		AtlasLootItemsFrame:Show()
	else
		AtlasLootItemsFrame:Hide()
	end
	-- Consult the saved variable table to see whether to show the bottom panel
	if AtlasLootCharDB.HidePanel then
		AtlasLootPanel:Hide()
	else
		AtlasLootPanel:Show()
	end
	AtlasLoot.AtlasScrollBar_Update()
	AtlasLoot.UpdateBookmarkButtons()
end

--[[
AtlasLoot_AtlasScrollBar_Update:
Hooks the Atlas scroll frame.
Required as the Atlas function cannot deal with the AtlasLoot button template or the added Atlasloot entries
]]
function AtlasLoot.AtlasScrollBar_Update()
	AtlasLoot.Hooks.AtlasScrollBar_Update()
	local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone]
	-- Make note of how far in the scroll frame we are
	local offset = FauxScrollFrame_GetOffset(AtlasScrollBar)
	for line = 1, ATLAS_NUM_LINES do
		local id = line + offset
		local entry = _G["AtlasEntry"..line]
		local loot = entry._Loot
		local selected = entry._Selected
		if loot and id <= ATLAS_CUR_LINES then
			local showIcon = AtlasLootBossButtons[zoneID] and AtlasLootBossButtons[zoneID][id]
			if AtlasLootItemsFrame.activeBoss == id then
				entry:Enable()
				loot:Hide()
				selected:Show()
			elseif showIcon then
				entry:Enable()
				loot:Show()
				selected:Hide()
			else
				entry:Disable()
				loot:Hide()
				selected:Hide()
			end
			entry.idnum = id
		end
	end
end
