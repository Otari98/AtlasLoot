local L = AtlasLoot.L

function AtlasLoot.MinimapButton_Toggle()
    if AtlasLootCharDB.MinimapButton then
        AtlasLootMinimapButton:Show()
    else
        AtlasLootMinimapButton:Hide()
    end
end

function AtlasLoot.MinimapButton_OnClick(self, button)
    if button == "LeftButton" then
        AtlasLoot.DefaultFrame_Toggle()
    elseif button == "RightButton" then
        AtlasLoot.Options_Toggle()
    end
end

function AtlasLoot.MinimapButton_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText(L["AtlasLoot Enhanced"], 1, 1, 1)
    GameTooltip:AddLine(L["Left-click to open AtlasLoot."])
    GameTooltip:AddLine(L["Right-click for AtlasLoot options."])
    GameTooltip:AddLine(L["Drag to move this button."])
    GameTooltip:Show()
end

function AtlasLoot.MinimapButton_UpdatePosition()
    local radius, angle = AtlasLootCharDB.MinimapButtonRadius, AtlasLootCharDB.MinimapButtonPosition
    local x = 54 - (radius * cos(angle))
    local y = (radius * sin(angle)) - 55
    AtlasLootMinimapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", x, y)
end

function AtlasLoot.MinimapButton_OnUpdate(self, elapsed)
    if not self.aldragme then return end
    local scale = UIParent:GetScale()
    local xpos, ypos = GetCursorPosition()
    local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom()
    xpos = xmin - xpos / scale + 70
    ypos = ypos / scale - ymin - 70
    local angle = math.deg(math.atan2(ypos, xpos))
    if angle < 0 then angle = angle + 360 end
    AtlasLootCharDB.MinimapButtonPosition = angle
    AtlasLoot.MinimapButton_UpdatePosition()
end
