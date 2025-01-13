-- Ensure TWA table is initialized
TWA = TWA or {}

-- Function to create the main frame
function TWA.CreateMainFrame()
    local mainFrame = CreateFrame("Frame", "TWA_Main", UIParent)
    mainFrame:SetWidth(300)
    mainFrame:SetHeight(400)
    mainFrame:SetPoint("CENTER", UIParent, "CENTER")
    mainFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = false,
        tileSize = 0,
        edgeSize = 16,
        insets = { left = 2, right = 2, top = 3, bottom = 3 }
    })
    mainFrame:SetMovable(true)
    mainFrame:EnableMouse(true)
    mainFrame:RegisterForDrag("LeftButton")
    mainFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    mainFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

    local closeButton = CreateFrame("Button", nil, mainFrame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -5, -5)

    return mainFrame
end

-- Function to create the special frame
function TWA.CreateSpecialFrame()
    local specialFrame = CreateFrame("Frame", "TWA_SpecialFrame", UIParent)
    specialFrame:SetWidth(300)
    specialFrame:SetHeight(200)
    specialFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 10, -10)
    specialFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = false,
        tileSize = 0,
        edgeSize = 16,
        insets = { left = 2, right = 2, top = 3, bottom = 3 }
    })
    specialFrame:SetMovable(true)
    specialFrame:EnableMouse(true)
    specialFrame:RegisterForDrag("LeftButton")
    specialFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    specialFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

    return specialFrame
end

-- Example usage: Create and show the main frame
SLASH_TWACREATEMAINFRAME1 = '/createmainframe'
SlashCmdList["TWACREATEMAINFRAME"] = function()
    if not TWA_Main then
        TWA_Main = TWA.CreateMainFrame()
    end
    if not TWA_SpecialFrame then
        TWA_SpecialFrame = TWA.CreateSpecialFrame()
    end
    TWA_Main:Show()
    TWA_SpecialFrame:Show()
end

-- Simple command to verify the file is loaded
SLASH_TWATEST1 = '/twatest'
SlashCmdList["TWATEST"] = function()
    print("TWAssignmentsFrame.lua is loaded!")
end