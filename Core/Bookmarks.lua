local L = AtlasLoot.L

local wipe = AtlasLoot.wipe
local tcontains = AtlasLoot.tcontains

local MovingIndex = nil
local ChosenIndex = nil
local BOOKMARKS_PER_ROW = 5
local NUM_ROWS = 2
local VISIBLE_BOOKMARKS = BOOKMARKS_PER_ROW * NUM_ROWS

AtlasLoot.BookmarkFrames = {}

function AtlasLoot.AddBookmark(dataID)
    if not tcontains(AtlasLootCharDB["Bookmarks"], dataID) then
        table.insert(AtlasLootCharDB["Bookmarks"], dataID)
    end
end

function AtlasLoot.RemoveBookmark(dataID)
    local index = tcontains(AtlasLootCharDB["Bookmarks"], dataID)
    if index then
        table.remove(AtlasLootCharDB["Bookmarks"], index)
    end
end

function AtlasLoot.ClearBookmarks()
    wipe(AtlasLootCharDB["Bookmarks"])
end

function AtlasLoot.UpdateBookmarkButtons()
    local width = 95
    if table.getn(AtlasLootCharDB["Bookmarks"]) > VISIBLE_BOOKMARKS then
        AtlasLootMoreBookmarksButton:Show()
    else
        AtlasLootMoreBookmarksButton:Hide()
        width = width + 5
    end
    for i = 1, VISIBLE_BOOKMARKS do
        local button = AtlasLoot.BookmarkFrames[i]
        if not button then break end
        local dataID = AtlasLootCharDB["Bookmarks"][i]
        local current = AtlasLootItemsFrame.refresh[1]
        button:UnlockHighlight()
        if math.floor(button:GetWidth()) ~= width then
            PanelTemplates_TabResize(0, button, width, width)
        end
        if dataID then
            local info = AtlasLoot_TableNames[dataID]
            button:Enable()
            button:SetActive(true)
            button:SetText(info and info[1] or "")
            button.arg1 = i
            button.dataID = dataID
            button.subText = info and info[3]
            if current == dataID and AtlasLootItemsFrame:IsShown() then
                button:LockHighlight()
            end
        else
            button:Disable()
            button:SetActive(false)
            button:SetText("")
            button.dataID = nil
            button.subText = nil
        end
    end
    if AtlasLoot.Hewdrop:IsOpen(AtlasLootMoreBookmarksButton) then
        AtlasLoot.Hewdrop:Refresh(1)
        if Hewdrop20Level1.buttons and table.getn(Hewdrop20Level1.buttons) == 0 then
            AtlasLoot.Hewdrop:Close(1)
        end
    end
end

function AtlasLoot.BookmarkButton_OnLoad(self)
    local name = self:GetName()
    local id = self:GetID()
    local width = self:GetWidth()
    PanelTemplates_TabResize(0, self, width, width)
    self.Left = _G[name.."Left"]
    self.Right = _G[name.."Right"]
    self.Middle = _G[name.."Middle"]
    self.Text = _G[name.."Text"]
    self.Highlight = self:GetHighlightTexture()
    self.Left:SetVertexColor(0, 0, 0, 1)
    self.Right:SetVertexColor(0, 0, 0, 1)
    self.Middle:SetVertexColor(0, 0, 0, 1)
    self.SetActive = function(self, active)
        self.Left:SetAlpha(active and 1 or 0.5)
        self.Right:SetAlpha(active and 1 or 0.5)
        self.Middle:SetAlpha(active and 1 or 0.5)
        self.isActive = active
    end
    if id == 0 then -- floating one
        self:SetActive(true)
        self:Enable()
    else
        self:SetActive(false)
        self:Disable()
    end
    self:RegisterForDrag("LeftButton")
    self.Highlight:SetAlpha(0.65)
    AtlasLoot.BookmarkFrames[id] = self
end

function AtlasLoot.BookmarkButton_OnClick(self, button)
    if IsAltKeyDown() then
        AtlasLoot.RemoveBookmark(self.dataID)
        AtlasLoot.ShowItemsFrame(AtlasLootItemsFrame.refresh[1])
    else
        AtlasLoot.ShowItemsFrame(self.dataID)
        AtlasLoot.Hewdrop:Close()
    end
end

function AtlasLoot.BookmarkButton_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), -12)
    GameTooltip:SetText((self.arg1..". "..self:GetText()) or "", 1, 1, 1, 1, false)
    if self.subText then
        GameTooltip:AddLine(self.subText, nil, nil, nil, true)
    end
    GameTooltip:AddLine(L["ALT+Click to remove bookmark"], nil, nil, nil, true)
    GameTooltip:Show()
end

function AtlasLoot.BookmarkPageButton_OnClick(self)
    local dataID = AtlasLootItemsFrame.refresh[1]
    local added = false
    if self:GetChecked() then
        AtlasLoot.AddBookmark(dataID)
        added = true
    else
        AtlasLoot.RemoveBookmark(dataID)
    end
    AtlasLoot.UpdateBookmarkButtons()
    if added and AtlasLootMoreBookmarksButton:IsShown() then
        ButtonPulse_StopPulse(AtlasLootMoreBookmarksButton)
        SetButtonPulse(AtlasLootMoreBookmarksButton, 1.3, 0.2)
    end
end

function AtlasLoot.StopMovingBookmark(abort)
    AtlasLootDefaultFrameFloatingBookmarkButton:StopMovingOrSizing()
    AtlasLootDefaultFrameFloatingBookmarkButton:Hide()
    -- print(string.format("moving:%s chosen:%s", tostring(MovingIndex), tostring(ChosenIndex)))
    if not abort and ChosenIndex and MovingIndex and ChosenIndex ~= MovingIndex then
        local bookmarks = AtlasLootCharDB["Bookmarks"]
        if ChosenIndex > 0 and ChosenIndex <= table.getn(bookmarks) then
            bookmarks[ChosenIndex], bookmarks[MovingIndex] = bookmarks[MovingIndex], bookmarks[ChosenIndex]
        end
    end
    MovingIndex = nil
    ChosenIndex = nil
    AtlasLoot.UpdateBookmarkButtons()
end

function AtlasLoot.StartMovingBookmark(self)
    MovingIndex = self.arg1
    AtlasLootDefaultFrameFloatingBookmarkButton:Show()
    AtlasLootDefaultFrameFloatingBookmarkButton:SetText(self.text and self.text:GetText() or self:GetText() or "")
    AtlasLootDefaultFrameFloatingBookmarkButton:StartMoving()
end

local function OnDragStart()
    AtlasLoot.StartMovingBookmark(this)
end

local function OnDragStop()
    AtlasLoot.StopMovingBookmark()
end

function AtlasLoot.MoreBookmarksButton_OnClick(self, button)
    if AtlasLoot.Hewdrop:IsOpen(self) then
        AtlasLoot.Hewdrop:Close(1)
        return
    end
    if table.getn(AtlasLootCharDB["Bookmarks"]) <= VISIBLE_BOOKMARKS then
        return
    end
    AtlasLoot.Hewdrop:Open(self,
        "point", function(parent)
            if AtlasLoot.AnchorPoint == AtlasLoot.Anchor_Atlas then
                return "BOTTOMRIGHT", "TOPRIGHT"
            else
                return "TOPRIGHT", "BOTTOMRIGHT"
            end
        end,
        "children", function()
            local first, last, step = 0, 0, 0
            local numBookmarks = table.getn(AtlasLootCharDB["Bookmarks"])
            if AtlasLoot.AnchorPoint == AtlasLoot.Anchor_Atlas then
                first, last, step = numBookmarks, VISIBLE_BOOKMARKS+1, -1
            else
                first, last, step = VISIBLE_BOOKMARKS+1, numBookmarks, 1
            end
            for i = first, last, step do
                local dataID = AtlasLootCharDB["Bookmarks"][i]
                local info = AtlasLoot_TableNames[dataID]
                local title = info and info[1] or ""
                local subText = info and info[3] or ""
                AtlasLoot.Hewdrop:AddLine(
                    "checked", dataID == AtlasLootItemsFrame.refresh[1],
                    "text", title,
                    "isRadio", true,
                    "tooltipFunc", function(text, line1, line2)
                        GameTooltip_SetDefaultAnchor(GameTooltip, this)
                        GameTooltip:SetText(text, 1, 1, 1)
                        GameTooltip:AddLine(line1)
                        GameTooltip:AddLine(line2)
                        GameTooltip:Show()
                    end,
                    "tooltipArg1", i..". "..title,
                    "tooltipArg2", subText,
                    "tooltipArg3", L["ALT+Click to remove bookmark"],
                    "arg1", i,
                    "func", function()
                        if IsAltKeyDown() then
                            AtlasLoot.RemoveBookmark(dataID)
                            AtlasLoot.ShowItemsFrame(AtlasLootItemsFrame.refresh[1])
                        else
                            AtlasLoot.ShowItemsFrame(dataID)
                            AtlasLoot.Hewdrop:Close(1)
                        end
                    end
                )
            end
        end
    )
    if Hewdrop20Level1.buttons then
        for _, button in ipairs(Hewdrop20Level1.buttons) do
            local script = button:GetScript("OnDragStart")
            if button and script ~= OnDragStart then
                button:RegisterForDrag("LeftButton")
                button:SetScript("OnDragStart", OnDragStart)
                button:SetScript("OnDragStop", OnDragStop)
            end
        end
    end
end

function AtlasLoot.FloatingBookmark_OnUpdate(self, elapsed)
    if not MovingIndex then return end
    local cursorX, cursorY = GetCursorPosition()
    local scale = UIParent:GetScale()
    cursorX = cursorX / scale
    cursorY = cursorY / scale
    AtlasLootDefaultFrameFloatingBookmarkButton:ClearAllPoints()
    AtlasLootDefaultFrameFloatingBookmarkButton:SetPoint("LEFT", nil, "BOTTOMLEFT", cursorX - 40, cursorY + 2)
    ChosenIndex = nil
    for _, button in pairs(AtlasLoot.BookmarkFrames) do
        button:UnlockHighlight()
    end
    for id, button in pairs(AtlasLoot.BookmarkFrames) do
        if MouseIsOver(button, -5, 0, 0, 0) then
            ChosenIndex = id
            if button.isActive then button:LockHighlight() end
            break
        end
    end
    local dropdownOpen = AtlasLoot.Hewdrop:IsOpen(AtlasLootMoreBookmarksButton)
    if dropdownOpen and Hewdrop20Level1.buttons then
        for _, button in ipairs(Hewdrop20Level1.buttons) do
            button.highlight:Hide()
        end
        Hewdrop20Level1.count = nil -- stops it from hiding on timeout
        for _, button in ipairs(Hewdrop20Level1.buttons) do
            if MouseIsOver(button) then
                ChosenIndex = button.arg1
                button.highlight:Show()
                break
            end
        end
    end
    local parent = _G[AtlasLoot.AnchorPoint[2]]
    if not (parent and parent:IsVisible()) then
        AtlasLoot.StopMovingBookmark(true)
    end
    if MouseIsOver(AtlasLootMoreBookmarksButton) and not dropdownOpen then
        AtlasLoot.MoreBookmarksButton_OnClick(AtlasLootMoreBookmarksButton)
    end
end
