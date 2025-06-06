local SoulReaperPins = {}
SoulReaperPins.name = "SoulReaperPins"

local LMP = LibMapPins
local PIN_TYPE = "SoulReaperPinsPin"

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
        {0.33, 0.186},
        {0.379, 0.225},
        {0.542, 0.231},
        {0.582, 0.242},
        {0.603, 0.255},
        {0.123, 0.693},
        {0.11, 0.765},
        {0.19, 0.826},
        {0.701, 0.812},
        {0.684, 0.521},
    },
    ["glenumbra"] = {
        {0.718, 0.145},
        {0.636, 0.383},
        {0.423, 0.365},
        {0.33, 0.337},
        {0.406, 0.56},
        {0.246, 0.596},
        {0.313, 0.658},
    },
    ["rivenspire"] = {
        {0.669, 0.672},
        {0.578, 0.501},
        {0.623, 0.492},
        {0.653, 0.434},
        {0.744, 0.299},
        {0.714, 0.197},
        {0.609, 0.201},
        {0.525, 0.246},
        {0.197, 0.634},
        {0.3, 0.645},
        {0.332, 0.635},
        {0.346, 0.533},
        {0.424, 0.627},
    },
    ["stormhaven"] = {
        {0.858, 0.486},
        {0.802, 0.497},
        {0.763, 0.48},
        {0.705, 0.476},
        {0.724, 0.424},
        {0.478, 0.594},
        {0.351, 0.576},
        {0.406, 0.498},
        {0.426, 0.48},
        {0.425, 0.477},
        {0.481, 0.397},
        {0.251, 0.282},
        {0.226, 0.279},
    },
    ["bangkorai"] = {
        {0.646, 0.16},
        {0.668, 0.203},
        {0.374, 0.255},
        {0.494, 0.399},
        {0.527, 0.444},
        {0.49, 0.499},
        {0.33, 0.553},
        {0.525, 0.546},
        {0.331, 0.651},
        {0.352, 0.849},
        {0.279, 0.877},
    },
    ["alikrdesert"] = {
        {0.105, 0.518},
        {0.246, 0.53},
        {0.426, 0.633},
        {0.569, 0.613},
        {0.718, 0.563},
        {0.723, 0.417},
        {0.704, 0.399},
        {0.514, 0.393},
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