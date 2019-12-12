require "prefabutil"

local assets = {
	Asset("ANIM", "anim/sendiobject_icebox.zip"),
	Asset("ANIM", "anim/ui_chester_shadow_3x4.zip"),
	Asset("ATLAS", "images/inventoryimages/sendiobject_icebox.xml"),
}

local prefabs = {
	"collapse_small"
}

local containers = require "containers"	
containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, 16)
local slotpos = {}
for y = 2.5, -0.5, -1 do
    for x = 0, 2 do
        table.insert(slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

local sendiobject_icebox = {
    widget = {
        slotpos = slotpos,
		animbank = "ui_chester_shadow_3x4",
		animbuild = "ui_chester_shadow_3x4",
        pos = Vector3(0, 180, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

local _widgetsetup = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)
	if container.inst.prefab == "sendiobject_icebox" or prefab == "sendiobject_icebox" then
		data = sendiobject_icebox
		
		for k,v in pairs(sendiobject_icebox) do
			container[k] = v
		end
		container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
		return
	else
		return _widgetsetup(container, prefab, data, ...)
	end
end

local function onopen(inst) 
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("open")
		--inst.AnimState:PlayAnimation("close")
		inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	end
	for i = 0 , 16 do
        local item = inst.components.container:GetItemInSlot(i)
        if item and item.components.perishable then
			item.components.perishable.localPerishMultiplyer = 0.5
        end
    end
end

local function onclose(inst) 
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("close")
		inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
	end  
	for i = 0 , 16 do
        local item = inst.components.container:GetItemInSlot(i)
        if item and item.components.perishable then
			item.components.perishable.localPerishMultiplyer = 0.5
        end
    end  
end

local function onhammered(inst, worker)
	if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
		inst.components.burnable:Extinguish()
	end
	inst.components.lootdropper:DropLoot()
	if inst.components.container ~= nil then
		inst.components.container:DropEverything()
	end
	local fx = SpawnPrefab("collapse_small")
	fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
	fx:SetMaterial("wood")
	inst:Remove()
end

local function onhit(inst, worker)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("hit")
		inst.AnimState:PushAnimation("closed", false)
		if inst.components.container ~= nil then
			inst.components.container:DropEverything()
			inst.components.container:Close()
		end
	end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed", false)
	inst.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
end

local function onsave(inst, data)
	if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
		data.burnt = true
	end
end

local function onload(inst, data)
	if data ~= nil and data.burnt then
		inst.components.burnable.onburnt(inst)
	end
	if inst.prefab == "sendiobject_icebox" then
		for i = 0 , 16 do
			local item = inst.components.container:GetItemInSlot(i)
			if item and item.components.perishable then
				item.components.perishable.localPerishMultiplyer = 0.5
			end
		end
	end
end

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()

	
	---[[
	--MakeObstaclePhysics(inst, .8) --오브젝트자리
	
	-- inst.entity:AddPhysics() -- minimal setup to move thing. no collision
	-- inst.Physics:SetMass(1)
	-- inst.Physics:SetCapsule(0, 1)
	--]]
	inst.MiniMapEntity:SetIcon("sendiobject_icebox.tex")
	
	inst.AnimState:SetBank("sendiobject_icebox")
	inst.AnimState:SetBuild("sendiobject_icebox")
	inst.AnimState:PlayAnimation("closed")
	
	inst:AddTag("fridge")--냉장고기능
	inst:AddTag("chest")
	inst:AddTag("structure")

	MakeSnowCoveredPristine(inst)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("sendiobject_icebox", sendiobject_icebox)
	inst.components.container.onopenfn = onopen
	inst.components.container.onclosefn = onclose

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(15)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)
   
    inst:AddTag("wood")

	AddHauntableDropItemOrWork(inst)

	inst:ListenForEvent("onbuilt", onbuilt)
	
	MakeSnowCovered(inst)--스노우커버

	inst.OnSave = onsave 
	inst.OnLoad = onload
	
	inst:ListenForEvent("burntup", onhammered) --태워버린다.
	MakeMediumBurnable(inst, nil, nil, true)--태워버린다.
	
	return inst
end

return Prefab("common/sendiobject_icebox", fn, assets, prefabs),
MakePlacer("common/sendiobject_icebox_placer", "sendiobject_icebox", "sendiobject_icebox", "closed")