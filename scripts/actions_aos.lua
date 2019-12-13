local STRINGS = GLOBAL.STRINGS
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local ACTIONS = GLOBAL.ACTIONS
local ActionHandler = GLOBAL.ActionHandler

----------------------------------------------------------------------------------------------------
local MILK = AddAction("AOSMILK", STRINGS.ACTIONS.AOSMILK, function(act)
    if act.target ~= nil and act.target:HasTag("beefalo") then
        return act.target.components.aos_milkable:Milk(act.doer)
    end
end)
MILK.priority = -1

AddStategraphActionHandler("wilson", ActionHandler(MILK, "dolongaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(MILK, "dolongaction"))

local function milk_scene(inst, doer, actions)
    if doer:HasTag("aosplayer") and inst:HasTag("amilkable") and not inst:HasTag("sleeping") then
        table.insert(actions, ACTIONS.AOSMILK)
    end
end

AddComponentAction("SCENE", "aos_milkable", milk_scene)