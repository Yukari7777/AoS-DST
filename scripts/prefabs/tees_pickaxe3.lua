
--  tees_pickaxe3


-- 그래픽 자원 설정. 예시엔 드랍 이미지, 장착 이미지, 인벤토리 이미지, 인벤토리 이미지 xml이 설정됨.
--MH: 미쉘이추가한 코드. 미쉘 추가한거 바로 보시려면 컨 + F MH검색.

local assets ={
    Asset("ANIM", "anim/tees_pickaxe3.zip"),
    Asset("ANIM", "anim/swap_tees_pickaxe3.zip"), --<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< swap파일을 로드 하지 않았습니다. 쥐님.
   
	Asset("ATLAS", "images/inventoryimages/tees_pickaxe3.xml"),
	Asset("IMAGE", "images/inventoryimages/tees_pickaxe3.tex"),
}


local function UpdateDamage(inst)
    if inst.components.perishable and inst.components.weapon then
        local dmg = TUNING.HAMBAT_DAMAGE * inst.components.perishable:GetPercent()
        dmg = Remap(dmg, 0, TUNING.HAMBAT_DAMAGE, TUNING.HAMBAT_MIN_DAMAGE_MODIFIER*TUNING.HAMBAT_DAMAGE, TUNING.HAMBAT_DAMAGE)
        inst.components.weapon:SetDamage(dmg)
    end
end

local function OnLoad(inst, data)
   -- UpdateDamage(inst)
end
            --onunequip
local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_tees_pickaxe3", "swap")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
	inst.Light:Enable(true)
	-- 장착 시 설정.
	-- owner.AnimState:OverrideSymbol("애니메이션 뱅크명", "빌드명", "빌드 폴더명")
	-- 그 아래 2줄은 물건을 들고 있는 팔 모습을 활성화하고, 빈 팔 모습을 비활성화.
end

local function onunequip(inst, owner)
    --UpdateDamage(inst)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
	inst.Light:Enable(false)
  --  local skin_build = inst:GetSkinBuild()
   -- if skin_build ~= nil then
   --     owner:PushEvent("unequipskinneditem", inst:GetSkinName())
   -- end
end


local function ontakefuel(inst)
   local afterrepair = inst.components.finiteuses:GetUses() + 20
   if afterrepair >= 200 then
      inst.components.finiteuses:SetUses(200)
   else
      inst.components.finiteuses:SetUses(afterrepair)
   end
 end--내구도 수리 
 
local function fn()

	local inst = CreateEntity()  
	-- local trans = inst.entity:AddTransform() <<<<<<<<<< YK : 이거와 같은 경우에, trans라는 변수가 더이상 쓰이지 않을것 같을땐 변수로 할당하지 않는 습관을 들여주세요.(메모리 낭비됨)
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("tees_pickaxe3.tex")	
	
    MakeInventoryPhysics(inst)

	inst.entity:AddLight()
	inst.Light:SetRadius(.2)
	inst.Light:SetFalloff(.8)
	inst.Light:SetIntensity(.5)
	inst.Light:SetColour(0.9, 0.3, 0.3)
	inst.Light:Enable(false)

    inst.AnimState:SetBank("tees_pickaxe3")
    inst.AnimState:SetBuild("tees_pickaxe3")
    inst.AnimState:PlayAnimation("idle") --떨군 이미지추가 
   
    inst:AddTag("sharp") -- 태그 설정, 이 두 태그는 없어도 됨(실행 확인)
    inst:AddTag("pointy") 
	
    if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine()
   
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(60) 
	-- 무기로 설정. 아래는 피해 설정
	inst.components.weapon:SetRange(1) --공격범위

	---[[도끼및 곡괭이
	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.MINE, 2.5)--곡괭이
	inst.components.tool:SetAction(ACTIONS.CHOP, 2.5)--도끼
    --]]
	
	inst:AddComponent("finiteuses") --내구도 부문 
    inst.components.finiteuses:SetMaxUses(200)--최대 내구도 설정
	inst.components.finiteuses:SetUses(200) -- 현재 내구도  설정
	inst.components.finiteuses:SetConsumption(ACTIONS.CHOP, 1.25)--도끼내구도 감소율
	inst.components.finiteuses:SetConsumption(ACTIONS.MINE, 1.25)--도끼내구도	감소율
	inst.components.finiteuses:SetOnFinished(inst.Remove)--내구도가 다하면 fn을 실행함.

    inst:AddComponent("fueled") --연료가 있는.
    inst.components.fueled.fueltype = "BURNABLE"
    inst.components.fueled:InitializeFuelLevel(1)
	inst.components.fueled.accepting = true
	inst.components.fueled:SetTakeFuelFn(ontakefuel)
	inst.components.fueled:StopConsuming()
	
    inst:AddComponent("inspectable") --조사 가능하도록 설정
	
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "tees_pickaxe3"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/tees_pickaxe3.xml" --인벤토리 아이템으로 설정됨
	
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	
	
	MakeHauntableLaunchAndPerish(inst)
	
	inst.OnLoad = OnLoad
	--YK : OnLoad, OnSave, OnPreLoad 함수들은 마지막에 입력해주세요. 
	inst.components.inventoryitem.keepondeath = true
    return inst
end

return Prefab("tees_pickaxe3", fn, assets, prefabs) --YK : prefab 어규먼트

