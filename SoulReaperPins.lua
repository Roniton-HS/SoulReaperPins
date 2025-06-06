local SoulReaperPins = {}
SoulReaperPins.name = "SoulReaperPins"

local LMP = LibMapPins
local PIN_TYPE = "SoulReaperPinsPin"

-- Pins für verschiedene Zonen
local zoneData = {
    ["eastmarch"] = {
        {0.306, 0.575},
        {0.532, 0.62},
        {0.724, 0.651},
        {0.626, 0.599},
        {0.588, 0.579},
        {0.52, 0.365},
        {0.43, 0.317},
        {0.359, 0.314},
        {0.588, 0.579},
    },
    ["therift"] = {
        {0.768, 0.684},
        {0.626, 0.592},
        {0.16, 0.271},
    },
    ["stonefalls"] = {
        {0.118, 0.445},
        {0.158, 0.561},
        {0.341, 0.682},
        {0.377, 0.728},
        {0.439, 0.743},
        {0.475, 0.605},
        {0.926, 0.446},
        {0.811, 0.383},
        {0.761, 0.37},
    },
    ["deshaan"] = {
        {0.137, 0.506},
        {0.122, 0.52},
        {0.131, 0.467},
        {0.229, 0.496},
        {0.261, 0.546},
        {0.228, 0.605},
        {0.449, 0.409},
        {0.603, 0.492},
        {0.619, 0.494},
        {0.632, 0.534},
        {0.63, 0.548},
        {0.701, 0.528},
        {0.751, 0.614},
        {0.779, 0.578},
        {0.793, 0.546},
        {0.825, 0.392},
    },
    ["shadowfen"] = {

    },
}

local pinLayout = {
    level = 100,
    size = 25,
    texture = "/esoui/art/icons/poi/poi_portal_incomplete.dds",
}

local function RefreshPins()
    LMP:RemoveCustomPin(PIN_TYPE)
    local zoneId, subzoneId = LMP:GetZoneAndSubzone()

    if subzoneId ~= zoneId .. "_base" then
        return -- ignore subzones
    end

    local currentZoneData = zoneData[zoneId]
    if currentZoneData then
        for i, data in ipairs(currentZoneData) do
            LMP:CreatePin(PIN_TYPE, zoneId .. i, data[1], data[2])
        end
    end

end

local function OnMapChanged()
    RefreshPins()
end

function SoulReaperPins.Initialize()
    LMP:AddPinType(PIN_TYPE, RefreshPins, nil, pinLayout, nil)
    LMP:Enable(PIN_TYPE)

    EVENT_MANAGER:RegisterForEvent(SoulReaperPins.name, EVENT_MAP_CHANGED, OnMapChanged)
end

local function OnAddOnLoaded(_, addonName)
    if addonName ~= SoulReaperPins.name then return end
    SoulReaperPins.Initialize()
end

EVENT_MANAGER:RegisterForEvent(SoulReaperPins.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)