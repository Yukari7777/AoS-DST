local assets =
{
    Asset("ANIM", "anim/sendi_armor_02.zip"),
    Asset("ATLAS", "images/inventoryimages/sendi_armor_02.xml"),
    Asset("IMAGE", "images/inventoryimages/sendi_armor_02.tex"),
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "sendi_armor_02", "swap_body")
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
end

--분기점에따라 바뀌는 코드
local slotpos = {}

for y = 0, 3 do
	table.insert(slotpos, Vector3(-162, -y*75 + 114 ,0))
	table.insert(slotpos, Vector3(-162 +75, -y*75 + 114 ,0))
end


local function ChangeInsulation(inst, temperature)
	if temperature < 5 then -- 추워하는 화면 이펙트가 생기는 것의 분기점
		inst.components.insulator:SetWinter()
	else
		inst.components.insulator:SetSummer()
	end
end

--분기점에따라 바뀌는 코드 닫기


local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sendi_armor_02")
    inst.AnimState:SetBuild("sendi_armor_02")
    inst.AnimState:PlayAnimation("anim")
	
		inst:AddTag("sleevefix") -- YUKARI 센디 스킨옵션 관련 
		inst:AddTag("sendis")-- YUKARI 센디 스킨옵션 관련 

    if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine()

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sendi_armor_02"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendi_armor_02.xml"

	
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	
	--주요 능력치
    inst.components.equippable.walkspeedmult = 1.2 --이동속도 : 케인
	inst.components.equippable.dapperness = 0.4 --초당 정신력 회복 
	
	inst:AddComponent("armor")
	inst.components.armor:InitIndestructible(0.65) -- YUKARI : 무한 내구도
	
	inst:AddComponent("insulator")--보온율
    inst.components.insulator:SetInsulation(200) 
	
	inst.components.inventoryitem.keepondeath = true--죽어도 떨어뜨리지 않음
	
	MakeHauntableLaunch(inst)

	ChangeInsulation(inst, TheWorld.state.temperature) 
	inst:WatchWorldState("temperature", ChangeInsulation) --YUKARI : 기온에 따라 바뀌게 함수 개선


    return inst
end

return Prefab("common/inventory/sendi_armor_02", fn, assets)