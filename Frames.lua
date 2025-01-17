-- Create dropdown frames
local templatesMenuDropdown = CreateFrame("Frame", "TWRAtemplatesMenuDropdown", UIParent, "UIDropDownMenuTemplate")
local raidMenuDropdown = CreateFrame("Frame", "TWRAraidMenuDropdown", UIParent, "UIDropDownMenuTemplate")


-- Add selected raid variable
local selectedRaid = nil

-- Click handler function
local function HandleClick(name)
    print("Selected:", name)
end

-- Defaults Templates menu
local templatesMenu = {
    { "General 1", false },
    { "General 2", false },
    { "General 3", false },
    { "General 4", false },
    { "General 5", false },
    { "General 6", false },
}


-- Define raid menu items
local raidMenu = {
    { "Molten Core", true },
    { "Blackwing Lair", true },
    { "Temple of Ahn'Qiraj", true },
    { "Emerald Sanctum", true },
    { "Naxxramas", true },
    { "Arachnid Quarter", false },
    { "Plague Quarter", false},
    { "Abomination Quarter", false},
    { "Deathknight Quarter", false},
}

-- Define templates for raids
local raidTemplates = {
    ["Molten Core"] = {
        { "Lucifron", true },
        { "Magmadar", true },
        { "Gehennas", true },
        { "Garr", true },
        { "Baron Geddon", true },
        { "Shazzrah", true },
        { "Sulfuron", true },
        { "Golemagg", true },
        { "Majordomo", true },
        { "Ragnaros", true }
    },
    ["Blackwing Lair"] = {
        { "Razorgore", true },
        { "Vaelastrasz", true },
        { "Deathtalon", false },
        { "Suppresion Room", false },
        { "Broodlord", true },
        { "Lab Packs", false },
        { "Firemaw", true },
        { "Overseer Trio", false },
        { "Wyrmguard Packs", false },
        { "Ebonroc", true },
        { "Flamegor", true },
        { "Chromaggus", true },
        { "Nefarian", true }
    },
    ["Temple of Ahn'Qiraj"] = {
        { "Anubisath Sentinels", false},
        { "The Prophet Skeram", true },
        { "Qiraji Brainwasher", false },
        { "Vekniss Warriors", false },
        { "Bug Family", true },
        { "Vekniss Guardian", false },
        { "Battleguard Sartura", true },
        { "Fankriss the Unyielding", true },
        { "Viscidus", true },
        { "Vekniss Wasps (Qiraji Lasher)", false },
        { "Princess Huhuran", true },
        { "Anubisath Defenders", false },
        { "Twin Emperors", true },
        { "Ouro", true },
        { "C'Thun", true }
    },
    {"Emerald Sanctum"} = {
        { "Trash", false },
        { "Erennius", true },
        { "Solnius", true }
    },
    ["Naxxramas"] = {
        { "Anub'Rekhan", true },
        { "Grand Widow Faerlina", true },
        { "Maexxna", true }
    },
    ["Arachnid Quarter"] = {
        { "Venom Stalkers", false },
        { "Anub'Rekhan", true },
        { "Carrion Spinners", false },
        { "Acolytes & Cultists", false },
        { "Grand Widow Faerlina", true },
        { "Maexxna", true }
    },
    ["Plague Quarter"] = {
        { "Noth the Plaguebringer", true },
        { "Heigan the Unclean", true },
        { "Loatheb", true }
    },
    ["Abomination Quarter"] = {
        { "Patchwerk", true },
        { "Grobbulus", true },
        { "Gluth", true },
        { "Thaddius", true }
    },
    ["Deathknight Quarter"] = {
        { "Instructor Razuvious", true },
        { "Gothik the Harvester", true },
        { "The Four Horsemen", true }
    }
}

local function ChangeRaid(name)
    print("Changing raid to:", name)
    templatesMenu = raidTemplates[name]
end

local function buildTemplatesDropdown(self, level)
    local info = {}
    for _, item in ipairs(templatesMenu) do
        info.text = item[1]  -- Name is first value
        info.notCheckable = item[2]
        info.func = function() HandleClick(item[1]) end
        UIDropDownMenu_AddButton(info)
    end
end

local function buildRaidDropdown(self, level)
    for _, item in ipairs(raidMenu) do
        local info = {}
        info.text = tostring(item[1])  -- Ensure it's a string
        info.notCheckable = item[2]
        info.func = function() ChangeRaid(info.text) end
        UIDropDownMenu_AddButton(info)
    end
end



-- Initialize both dropdowns
UIDropDownMenu_Initialize(templatesMenuDropdown, buildTemplatesDropdown)
UIDropDownMenu_Initialize(raidMenuDropdown, buildRaidDropdown)

-- Update function name and add to TWA namespace
TWA.SelectRaid_OnClick = function()
    print("Debug: Raid button clicked")
    local button = getglobal("TWARaidsButton")
    if not button then
        print("Debug: Raid button not found")
        return
    end
    
    print("Debug: Showing raid menu at button position")
    ToggleDropDownMenu(1, nil, raidMenuDropdown, button, 0, 0, "TOPLEFT", "BOTTOMLEFT")
end

function TWA.SelectTemplate_OnClick()
    ToggleDropDownMenu(1, nil, templatesMenuDropdown, selectTemplate, 0, 0, "TOPLEFT", "BOTTOMLEFT")
end
