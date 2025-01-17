TWA.templatesMenu = {}
TWA.raidMenu = {}
TWA.raidTemplates = {}
TWA.templates = {}
TWA.twa_templates = {}  -- Add missing table

-- Create dropdown frames
local templatesMenuDropdown = CreateFrame("Frame", "TWRAtemplatesMenuDropdown", UIParent, "UIDropDownMenuTemplate")
local raidMenuDropdown = CreateFrame("Frame", "TWRAraidMenuDropdown", UIParent, "UIDropDownMenuTemplate")

-- Add selected raid variable
local selectedRaid = nil

-- Click handler function
local function HandleClick(name)
    print("Selected:", name)
end

local function ChangeRaid(name)
    -- Update button text
    local raidButton = getglobal("selectRaid")
    raidButton:SetText(name)
    TWA.templatesMenu = TWA.raidTemplates[name]
end

local function ChangeTemplate(name)

    local templateButton = getglobal("selectTemplate")
    templateButton:SetText(tostring(name))
    TWA.loadTemplate(name, load)

end
local function buildTemplatesDropdown(self, level)
    for _, item in ipairs(TWA.templatesMenu) do
        local info = {}
        local templateName = item[1]
        info.text = templateName
        info.notCheckable = item[2]
        info.func = function() 
            ChangeTemplate(templateName) 
        end
        UIDropDownMenu_AddButton(info)
    end
end

local function buildRaidDropdown(self, level)
    for _, item in ipairs(TWA.raidMenu) do
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

function SelectRaid_OnClick()
    ToggleDropDownMenu(1, nil, raidMenuDropdown, selectRaid, 0, 0, "TOPLEFT", "BOTTOMLEFT")
end

function SelectTemplate_OnClick()
    ToggleDropDownMenu(1, nil, templatesMenuDropdown, selectTemplate, 0, 0, "TOPLEFT", "BOTTOMLEFT")
end

function buildTemplatesDropdown()
    if UIDROPDOWNMENU_MENU_LEVEL == 1 then
        local Title = {}
        Title.text = "Templates"
        Title.isTitle = true
        UIDropDownMenu_AddButton(Title, UIDROPDOWNMENU_MENU_LEVEL);

        local separator = {};
        separator.text = ""
        separator.disabled = true
        UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

        local Trash = {}
        Trash.text = "Trash"
        Trash.notCheckable = true
        Trash.hasArrow = true
        Trash.value = {
            ['key'] = 'trash'
        }
        UIDropDownMenu_AddButton(Trash, UIDROPDOWNMENU_MENU_LEVEL);

        local separator = {};
        separator.text = ""
        separator.disabled = true
        UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

        local Raids = {}
        Raids.text = "Molten Core"
        Raids.notCheckable = true
        Raids.hasArrow = true
        Raids.value = {
            ['key'] = 'mc'
        }
        UIDropDownMenu_AddButton(Raids, UIDROPDOWNMENU_MENU_LEVEL);

        Raids = {}
        Raids.text = "Blackwing Lair"
        Raids.notCheckable = true
        Raids.hasArrow = true
        Raids.value = {
            ['key'] = 'bwl'
        }
        UIDropDownMenu_AddButton(Raids, UIDROPDOWNMENU_MENU_LEVEL);

        Raids = {}
        Raids.text = "Ahn\'Quiraj"
        Raids.notCheckable = true
        Raids.hasArrow = true
        Raids.value = {
            ['key'] = 'aq40'
        }
        UIDropDownMenu_AddButton(Raids, UIDROPDOWNMENU_MENU_LEVEL);

        Raids = {}
        Raids.text = "Naxxramas"
        Raids.notCheckable = true
        Raids.hasArrow = true
        Raids.value = {
            ['key'] = 'naxx'
        }
        UIDropDownMenu_AddButton(Raids, UIDROPDOWNMENU_MENU_LEVEL);
    end

    if UIDROPDOWNMENU_MENU_LEVEL == 2 then
        if UIDROPDOWNMENU_MENU_VALUE["key"] == 'trash' then
            for i = 1, 5 do
                local dropdownItem = {}
                dropdownItem.text = "Trash #" .. i
                dropdownItem.func = TWA.loadTemplate
                dropdownItem.arg1 = 'trash' .. i
                dropdownItem.arg2 = false
                UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            end
        end

        if UIDROPDOWNMENU_MENU_VALUE["key"] == 'mc' then
            local dropdownItem = {}
            dropdownItem.text = "Gaar"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'gaar'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Majordomo"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'domo'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Ragnaros"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'rag'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil
        end

        if UIDROPDOWNMENU_MENU_VALUE["key"] == 'bwl' then
            local dropdownItem = {}
            dropdownItem.text = "Razorgore"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'razorgore'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Vaelastrasz"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'vael'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Lashlayer"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'lashlayer'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Chromaggus"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'chromaggus'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Nefarian"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'nef'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil
        end

        if UIDROPDOWNMENU_MENU_VALUE["key"] == 'aq40' then
            local dropdownItem = {}
            dropdownItem.text = "The Prophet Skeram"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'skeram'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Bug Trio"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'bugtrio'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Battleguard Sartura"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'sartura'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Fankriss"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'fankriss'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Huhuran"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'huhu'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Twin Emps"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'twins'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil
        end

        if UIDROPDOWNMENU_MENU_VALUE["key"] == 'naxx' then
            local dropdownItem = {}
            dropdownItem.text = "Anub'rekhan"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'anub'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Faerlina"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'faerlina'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Maexxna"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'maexxna'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            local separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            dropdownItem = {}
            dropdownItem.text = "Noth"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'noth'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Heigan"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'heigan'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            dropdownItem = {}
            dropdownItem.text = "Razuvious"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'raz'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Gothik"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'gothik'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Four Horsemen"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = '4h'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            dropdownItem = {}
            dropdownItem.text = "Patchwerk"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'patchwerk'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Grobbulus"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'grobulus'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Gluth"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'gluth'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Thaddius"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'thaddius'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            dropdownItem = {}
            dropdownItem.text = "Sapphiron"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'saph'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Kel'Thusad"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'kt'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil
        end
    end
end

-- Defaults Templates menu
TWA.templatesMenu = {
    { "General", false },
    { "General 2", false },
    { "General 3", false },
    { "General 4", false },
    { "General 5", false },
    { "General 6", false },
}


-- Define raid menu items
TWA.raidMenu = {
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

-- Define templates for different raids
TWA.raidTemplates = {
    ["Molten Core"] = {
        { "General", false },
        { "Lucifron", true },
        { "Magmadar", true },
        { "Gehennas", true },
        { "Garr", true },
        { "Lava packs", false },
        { "Baron Geddon", true },
        { "Shazzrah", true },
        { "Sulfuron Harbinger", true },
        { "Golemagg", true },
        { "Majordomo", true },
        { "Ragnaros", true }
    },
    ["Blackwing Lair"] = {
        { "General", false },
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
        { "General", false },
        { "Anubisath Sentinels", false},
        { "The Prophet Skeram", true },
        { "Qiraji Brainwasher", false },
        { "Vekniss Warriors", false },
        { "Bug Family", true },
        { "Vekniss Guardian", false },
        { "Battleguard Sartura", true },
        { "Fankriss the Unyielding", true },
        { "Viscidus", true },
        { "Vekniss Wasps", false },
        { "Princess Huhuran", true },
        { "Anubisath Defenders", false },
        { "Twin Emperors", true },
        { "Ouro", true },
        { "C'Thun", true }
    },
    ["Emerald Sanctum"] = {
        { "General", false },
        { "Emerald Sanctum", false },
        { "Erennius", true },
        { "Solnius", true }
    },
    ["Naxxramas"] = {
        { "General", false },
        { "Sapphiron", true },
        { "Kel'Thuzad", true }
    },
    ["Arachnid Quarter"] = {
        { "General", false },
        { "Venom Stalkers", false },
        { "Anub'Rekhan", true },
        { "Carrion Spinners", false },
        { "Acolytes & Cultists", false },
        { "Grand Widow Faerlina", true },
        { "Maexxna", true }
    },
    ["Plague Quarter"] = {
        { "General", false },
        { "Noth the Plaguebringer", true },
        { "Heigan the Unclean", true },
        { "Loatheb", true }
    },
    ["Abomination Quarter"] = {
        { "General", false },
        { "Patchwerk", true },
        { "Grobbulus", true },
        { "Gluth", true },
        { "Thaddius", true }
    },
    ["Deathknight Quarter"] = {
        { "General", false },
        { "Instructor Razuvious", true },
        { "Gothik the Harvester", true },
        { "The Four Horsemen", true }
    }
}

TWA.twa_templates = {
    ["General"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["General 2"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["General 3"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["General 4"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["General 5"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["General 6"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Lucifron"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Magmadar"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Gehennas"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Garr"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Lava Pack"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Baron Geddon"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Shazzrah"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Sulfuron Harbinger"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Golemagg"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Majordomo"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Ragnaros"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Razorgore"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Vaelastrasz"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Deathtalon"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Suppression Room"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Broodlord"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Lab Packs"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Firemaw"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Overseer Trio"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Wyrmguard Packs"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Ebonroc"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Flamegor"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Chromaggus"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Nefarian"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Anubisath Sentinels"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["The Prophet Skerm"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Qiraji Brainwasher"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Veknis Warriors"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Bug Family"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Vekniss Guardian"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Battleguard Sartura"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Fankriss the Unyielding"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Viscidous"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Vekniss Wasps"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Princess Huhuran"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Anubisath Defenders"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Twin Emperors"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["C'Thun"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Emerald Sanctum"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Erennius"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Solnius"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Venom Stalkers"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Anub'Rekhan"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Carrion Spinnes"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Acolutes & Cultists"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Grand Widow Faerlina"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Maexxna"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Noth the Plaguebringer"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Heigan the Unclean"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Loatheb"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Patchwerk"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Grobbulus"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Gluth"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Thaddius"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Instructor Razuvious"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Gothik the Harvester"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["The Four Horsemen"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Sapphiron"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    },
    ["Kel'Thuzad"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "-", "-", "-", "-", "-", "-", "-" },
        [10] = { "-", "-", "-", "-", "-", "-", "-" },
    }
}

--[[

TWA.twa_templates = {
    ["trash1"] = {
        [1] = { "Skull", "MT1", "-", "-", "Heal1", "-", "-" },
        [2] = { "Cross", "MT2", "-", "-", "Heal2", "-", "-" },
        [3] = { "Square", "MT3", "-", "-", "Heal3", "-", "-" },
        [4] = { "Moon", "MT4", "-", "-", "Heal4", "-", "-" },
        [5] = { "Triangle", "MT5", "-", "-", "Heal5", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
    },
    ['trash2'] = {
        [1] = { "Skull", "-", "-", "-", "-", "-", "-" },
        [2] = { "Cross", "-", "-", "-", "-", "-", "-" },
        [3] = { "Square", "-", "-", "-", "-", "-", "-" },
        [4] = { "Moon", "-", "-", "-", "-", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
    },
    ['trash3'] = {
        [1] = { "Skull", "-", "-", "-", "-", "-", "-" },
        [2] = { "Cross", "-", "-", "-", "-", "-", "-" },
        [3] = { "Square", "-", "-", "-", "-", "-", "-" },
        [4] = { "Moon", "-", "-", "-", "-", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
    },
    ['trash4'] = {
        [1] = { "Skull", "-", "-", "-", "-", "-", "-" },
        [2] = { "Cross", "-", "-", "-", "-", "-", "-" },
        [3] = { "Square", "-", "-", "-", "-", "-", "-" },
        [4] = { "Moon", "-", "-", "-", "-", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
    },
    ['trash5'] = {
        [1] = { "Skull", "-", "-", "-", "-", "-", "-" },
        [2] = { "Cross", "-", "-", "-", "-", "-", "-" },
        [3] = { "Square", "-", "-", "-", "-", "-", "-" },
        [4] = { "Moon", "-", "-", "-", "-", "-", "-" },
        [5] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
    },
    ['gaar'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Skull", "-", "-", "-", "-", "-", "-" },
        [3] = { "Cross", "-", "-", "-", "-", "-", "-" },
        [4] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [5] = { "Square", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "Moon", "-", "-", "-", "-", "-", "-" }
    },
    ['domo'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Skull", "-", "-", "-", "-", "-", "-" },
        [3] = { "Cross", "-", "-", "-", "-", "-", "-" },
        [4] = { "Triangle", "-", "-", "-", "-", "-", "-" },
        [5] = { "Square", "-", "-", "-", "-", "-", "-" },
        [6] = { "Diamond", "-", "-", "-", "-", "-", "-" },
        [7] = { "Circle", "-", "-", "-", "-", "-", "-" },
        [8] = { "Star", "-", "-", "-", "-", "-", "-" },
        [9] = { "Moon", "-", "-", "-", "-", "-", "-" }
    },
    ['rag'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Melee", "-", "-", "-", "-", "-", "-" },
        [3] = { "Ranged", "-", "-", "-", "-", "-", "-" },
    },
    ['razorgore'] = {
        [1] = { "Left", "-", "-", "-", "-", "-", "-" },
        [2] = { "Left", "-", "-", "-", "-", "-", "-" },
        [3] = { "Left", "-", "-", "-", "-", "-", "-" },
        [4] = { "Right", "-", "-", "-", "-", "-", "-" },
        [5] = { "Right", "-", "-", "-", "-", "-", "-" },
        [6] = { "Right", "-", "-", "-", "-", "-", "-" },
    },
    ['vael'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Group 1", "-", "-", "-", "-", "-", "-" },
        [3] = { "Group 2", "-", "-", "-", "-", "-", "-" },
        [4] = { "Group 3", "-", "-", "-", "-", "-", "-" },
        [5] = { "Group 4", "-", "-", "-", "-", "-", "-" },
        [6] = { "Group 5", "-", "-", "-", "-", "-", "-" },
        [7] = { "Group 6", "-", "-", "-", "-", "-", "-" },
        [8] = { "Group 7", "-", "-", "-", "-", "-", "-" },
        [9] = { "Group 8", "-", "-", "-", "-", "-", "-" },
    },
    ['lashlayer'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [3] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [4] = { "BOSS", "-", "-", "-", "-", "-", "-" },
    },
    ['chromaggus'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Dispels", "-", "-", "-", "-", "-", "-" },
        [3] = { "Dispels", "-", "-", "-", "-", "-", "-" },
        [4] = { "Enrage", "-", "-", "-", "-", "-", "-" },
    },
    ['nef'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Left", "-", "-", "-", "-", "-", "-" },
        [3] = { "Left", "-", "-", "-", "-", "-", "-" },
        [4] = { "Right", "-", "-", "-", "-", "-", "-" },
        [5] = { "Right", "-", "-", "-", "-", "-", "-" },
    },
    ['skeram'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Left", "-", "-", "-", "-", "-", "-" },
        [3] = { "Right", "-", "-", "-", "-", "-", "-" },
        [4] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [5] = { "Left", "-", "-", "-", "-", "-", "-" },
        [6] = { "Right", "-", "-", "-", "-", "-", "-" },
    },
    ['bugtrio'] = {
        [1] = { "Skull", "-", "-", "-", "-", "-", "-" },
        [2] = { "Cross", "-", "-", "-", "-", "-", "-" },
        [3] = { "Diamond", "-", "-", "-", "-", "-", "-" },
    },
    ['sartura'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Skull", "-", "-", "-", "-", "-", "-" },
        [3] = { "Cross", "-", "-", "-", "-", "-", "-" },
        [4] = { "Square", "-", "-", "-", "-", "-", "-" },
    },
    ['fankriss'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "North", "-", "-", "-", "-", "-", "-" },
        [3] = { "East", "-", "-", "-", "-", "-", "-" },
        [4] = { "West", "-", "-", "-", "-", "-", "-" },
    },
    ['huhu'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [3] = { "Melee", "-", "-", "-", "-", "-", "-" },
        [4] = { "Melee", "-", "-", "-", "-", "-", "-" },
    },
    ['twins'] = {
        [1] = { "Left", "-", "-", "-", "-", "-", "-" },
        [2] = { "Left", "-", "-", "-", "-", "-", "-" },
        [3] = { "Right", "-", "-", "-", "-", "-", "-" },
        [4] = { "Right", "-", "-", "-", "-", "-", "-" },
        [5] = { "Adds", "-", "-", "-", "-", "-", "-" },
        [6] = { "Adds", "-", "-", "-", "-", "-", "-" },
    },
    ['anub'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Skull", "-", "-", "-", "-", "-", "-" },
        [3] = { "Cross", "-", "-", "-", "-", "-", "-" },
        [4] = { "Raid", "-", "-", "-", "-", "-", "-" },
    },
    ['faerlina'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [3] = { "Adds", "-", "-", "-", "-", "-", "-" },
        [4] = { "Skull", "-", "-", "-", "-", "-", "-" },
        [5] = { "Cross", "-", "-", "-", "-", "-", "-" },
    },
    ['maexxna'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [3] = { "Wall", "-", "-", "-", "-", "-", "-" },
        [4] = { "Wall", "-", "-", "-", "-", "-", "-" },
    },
    ['noth'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "NorthWest", "-", "-", "-", "-", "-", "-" },
        [3] = { "SouthWest", "-", "-", "-", "-", "-", "-" },
        [4] = { "NorthEast", "-", "-", "-", "-", "-", "-" },
    },
    ['heigan'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Melee", "-", "-", "-", "-", "-", "-" },
        [3] = { "Dispels", "-", "-", "-", "-", "-", "-" },
    },
    ['raz'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Skull", "-", "-", "-", "-", "-", "-" },
        [3] = { "Cross", "-", "-", "-", "-", "-", "-" },
        [4] = { "Moon", "-", "-", "-", "-", "-", "-" },
        [5] = { "Square", "-", "-", "-", "-", "-", "-" },
    },
    ['gothik'] = {
        [1] = { "Living", "-", "-", "-", "-", "-", "-" },
        [2] = { "Living", "-", "-", "-", "-", "-", "-" },
        [3] = { "Dead", "-", "-", "-", "-", "-", "-" },
        [4] = { "Dead", "-", "-", "-", "-", "-", "-" },
    },
    ['4h'] = {
        [1] = { "Skull", "-", "-", "-", "-", "-", "-" },
        [2] = { "Cross", "-", "-", "-", "-", "-", "-" },
        [3] = { "Moon", "-", "-", "-", "-", "-", "-" },
        [4] = { "Square", "-", "-", "-", "-", "-", "-" },
    },
    ['patchwerk'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Soaker", "-", "-", "-", "-", "-", "-" },
        [3] = { "Soaker", "-", "-", "-", "-", "-", "-" },
        [4] = { "Soaker", "-", "-", "-", "-", "-", "-" },
    },
    ['grobulus'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Melee", "-", "-", "-", "-", "-", "-" },
        [3] = { "Dispells", "-", "-", "-", "-", "-", "-" },
    },
    ['gluth'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Adds", "-", "-", "-", "-", "-", "-" },
    },
    ['thaddius'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Left", "-", "-", "-", "-", "-", "-" },
        [3] = { "Left", "-", "-", "-", "-", "-", "-" },
        [4] = { "Right", "-", "-", "-", "-", "-", "-" },
        [5] = { "Right", "-", "-", "-", "-", "-", "-" },
    },
    ['saph'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [3] = { "Group 1", "-", "-", "-", "-", "-", "-" },
        [4] = { "Group 2", "-", "-", "-", "-", "-", "-" },
        [5] = { "Group 3", "-", "-", "-", "-", "-", "-" },
        [6] = { "Group 4", "-", "-", "-", "-", "-", "-" },
        [7] = { "Group 5", "-", "-", "-", "-", "-", "-" },
        [8] = { "Group 6", "-", "-", "-", "-", "-", "-" },
        [9] = { "Group 7", "-", "-", "-", "-", "-", "-" },
        [10] = { "Group 8", "-", "-", "-", "-", "-", "-" },
    },
    ['kt'] = {
        [1] = { "BOSS", "-", "-", "-", "-", "-", "-" },
        [2] = { "Raid", "-", "-", "-", "-", "-", "-" },
    },
}
    ]]--