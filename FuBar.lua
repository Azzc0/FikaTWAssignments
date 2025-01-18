local AceAddon = AceLibrary("AceAddon-2.0")
local AceDB = AceLibrary("AceDB-2.0")
local AceEvent = AceLibrary("AceEvent-2.0")
local tablet = AceLibrary("Tablet-2.0")

-- Create FuBar plugin
TWAssignment = AceAddon:new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0")

-- Configure plugin
TWAssignment.name = "TWAssignment"
TWAssignment.hasIcon = "Interface\\Icons\\Spell_Holy_Heal02"
TWAssignment.cannotAttachToMinimap = false  -- Allow minimap attachment
TWAssignment.defaultPosition = "CENTER"
TWAssignment.hideWithoutStandby = false

function TWAssignment:OnEnable()
    self.iconFrame:SetWidth(16)
    self.iconFrame:SetHeight(16)
    self:CreateButtons()
    self:SetText("No template loaded")
end

function TWAssignment:CreateButtons()
    -- Previous button with more space
    self.prevButton = CreateFrame("Button", nil, self.frame)
    self.prevButton:SetPoint("RIGHT", self.frame, "RIGHT", -45, 0)  -- More space from right
    self.prevButton:SetWidth(16)
    self.prevButton:SetHeight(16)
    self.prevButton:SetNormalTexture("Interface\\Glues\\Common\\Glue-LeftArrow-Button-Up")
    self.prevButton:SetScript("OnClick", function() 
        TWA:SwitchTemplate("previous")
    end)
    
    -- Next button with more space
    self.nextButton = CreateFrame("Button", nil, self.frame)
    self.nextButton:SetPoint("RIGHT", self.frame, "RIGHT", -25, 0)  -- More space between buttons
    self.nextButton:SetWidth(16)
    self.nextButton:SetHeight(16)
    self.nextButton:SetNormalTexture("Interface\\Glues\\Common\\Glue-RightArrow-Button-Up")
    self.nextButton:SetScript("OnClick", function()
        TWA:SwitchTemplate("next")
    end)

    -- Initial frame setup with better defaults
    self.frame:SetWidth(200)  -- Reasonable default width
    self.textFrame:SetWidth(120)  -- Set text area width
    self.textFrame:SetPoint("RIGHT", self.prevButton, "LEFT", -5, 0)
    self.textFrame:SetJustifyH("LEFT")
end

function TWAssignment:UpdateFrameWidth()
    local text = self:OnTextUpdate()
    
    -- More precise width calculation
    local textWidth = self.textFrame:GetStringWidth() or 100
    local buttonSpace = 40  -- Reduced from 50 (16px per button + spacing)
    local padding = 45     -- Reduced from 60
    local minWidth = 80   -- Minimum width to prevent text cutoff
    local maxWidth = 300   -- Maximum width to prevent oversizing
    
    local newWidth = math.min(maxWidth, math.max(minWidth, textWidth + buttonSpace + padding))
    self.frame:SetWidth(newWidth)
end

function TWAssignment:OnTextUpdate()
    return TWA.loadedTemplate or "No template loaded"
end

function TWA.FuBarTextUpdate()
    TWAssignment:SetText(TWA.loadedTemplate or "No template loaded")
    TWAssignment:UpdateFrameWidth()
    TWAssignment.frame:Show()
end

function TWAssignment:OnClick(button)
    toggle_TWA_Main()
end

TWAssignment.OnMenuRequest = {
    type = "group",
    args = {
        show = {
            type = "execute",
            name = "Show/Hide Window",
            desc = "Toggle the main window",
            func = function() toggle_TWA_Main() end,
            order = 1
        },
        raidMenu = {
            type = "group",
            name = "Select raid",
            desc = "Change active raid templates",
            args = {},
            order = 2
        }
    }
}

-- Populate raid menu with toggle buttons
for i, raid in ipairs(TWA.raidMenu) do
    local raidName = raid[1]
    TWAssignment.OnMenuRequest.args.raidMenu.args[tostring(i)] = {
        type = "toggle",
        name = raidName,
        desc = "Changes template subset to " .. raidName,
        get = function() return false end,
        set = function() TWA.ChangeRaid(raidName) UpdateFuBarTemplates() end,
        order = i
    }
end

-- Add templates to main menu
for i, template in ipairs(TWA.templatesMenu) do
    TWAssignment.OnMenuRequest.args["template" .. i] = {
        type = "execute",
        name = template[1],
        desc = "Loads template" .. template[1],
        func = function() TWA.loadTemplate(name)  end,
        order = i + 10  -- Start after other menu items
    }
end

-- Add update function
function UpdateFuBarTemplates()
    -- Clear existing template menu items
    for k in pairs(TWAssignment.OnMenuRequest.args) do
        if string.find(k, "template") then
            TWAssignment.OnMenuRequest.args[k] = nil
        end
    end
    
    -- Add new templates
    for i, template in ipairs(TWA.templatesMenu) do
        TWAssignment.OnMenuRequest.args["template" .. i] = {
            type = "execute",
            name = template[1],
            desc = "Load " .. template[1],
            func = function() TWA.loadTemplate(template[1]) end,
            order = i + 10
        }
    end
end

function TWAssignment:OnTooltipUpdate()
    UpdateFuBarTemplates() 
    if not tablet then return end
    
    -- Template info category with spanning header
    local cat = tablet:AddCategory(
        'columns', 1,
        'justify', 'CENTER',
        'hideBlankLine', true
    )
    
    cat:AddLine(
        'text', (TWA.loadedTemplate or "None")
    )
    local cat = tablet:AddCategory(
        'columns', 6,
        'justify', 'LEFT',
        'hideBlankLine', true
    )

    -- Add header
    cat:AddLine(
        'text', "|cff69ccf0Target|r",
        'text2', "|cff69ccf0MT|r",
        'text3', "|cff69ccf0OT|r",
        'text4', "|cff69ccf0Utility|r",
        'text5', "|cff69ccf0Heal|r",
        'text6', "|cff69ccf0Heal|r",
        'justify', 'LEFT',
        'justify2', 'LEFT',
        'justify3', 'LEFT',
        'justify4', 'LEFT',
        'justify5', 'LEFT',
        'justify6', 'LEFT'
    )
    -- Add first 5 rows of data
    for i = 1, 7 do
        if TWA_DATA[i] then
            cat:AddLine(
                'text', TWA_DATA[i][1] or "",
                'text2', TWA_DATA[i][2] or "",
                'text3', TWA_DATA[i][3] or "",
                'text4', TWA_DATA[i][4] or "",
                'text5', TWA_DATA[i][5] or "",
                'text6', TWA_DATA[i][6] or ""
            )
        end
    end
end

-- Remove OnRightClick as it's handled by FuBar menu system

-- Remove UpdateDisplay and CHAT_MSG_ADDON registration
-- FuBar will handle text updates through OnTextUpdate