-- Ensure TWA table is initialized
TWA = TWA or {}

-- Function to create a simple blank frame
function TWA.CreateBlankFrame()
    -- Create the blank frame
    local blankFrame = CreateFrame("Frame", "TWA_BlankFrame", UIParent)
    blankFrame:SetWidth(300)
    blankFrame:SetHeight(200)
    blankFrame:SetPoint("CENTER", UIParent, "CENTER")
    blankFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = false,
        tileSize = 0,
        edgeSize = 16,
        insets = { left = 2, right = 2, top = 3, bottom = 3 }
    })
    blankFrame:SetMovable(true)
    blankFrame:EnableMouse(true)
    blankFrame:RegisterForDrag("LeftButton")
    blankFrame:SetScript("OnDragStart", blankFrame.StartMoving)
    blankFrame:SetScript("OnDragStop", blankFrame.StopMovingOrSizing)

    -- Create the close button
    local closeButton = CreateFrame("Button", nil, blankFrame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", blankFrame, "TOPRIGHT", -5, -5)

    return blankFrame
end

-- Function to show the blank frame
function TWA.ShowBlankFrame()
    if not TWA_BlankFrame then
        TWA_BlankFrame = TWA.CreateBlankFrame()
    end
    TWA_BlankFrame:Show()
end

-- Function to toggle the visibility of the main frame
function toggle_TWA_Main()
    if TWA_Main and TWA_Main:IsShown() then
        TWA_Main:Hide()
    else
        if not TWA_Main then
            TWA_Main = TWA.CreateBlankFrame()
        end
        TWA_Main:Show()
    end
end

-- Simple command to verify the file is loaded
SLASH_TWATEST1 = '/twatest'
SlashCmdList["TWATEST"] = function()
    print("TWAssignmentsFrame.lua is loaded!")
end

-- Example usage: Create and show the blank frame
SLASH_TWASHOWBLANKFRAME1 = '/showblankframe'
SlashCmdList["TWASHOWBLANKFRAME"] = function()
    TWA.ShowBlankFrame()
end

-- Example usage: Toggle the main frame
SLASH_TWATOGGLEMAIN1 = '/togglemain'
SlashCmdList["TWATOGGLEMAIN"] = function()
    toggle_TWA_Main()
end