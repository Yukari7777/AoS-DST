local MakePlayerCharacter = require "prefabs/player_common"
local CONST = TUNING.TEES

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
    Asset("ANIM", "anim/tees_skin_christmas.zip"), --ver.이그니아 금발
}
local prefabs = {
}

local start_inv = {--시작 인벤토리
    "tees_pickaxe",
    "taffy",
    "taffy",
    "taffy",
    "taffy",
    "taffy",
    "sleepbomb",
    "sleepbomb",
    "aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed",
    "aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed",
    "aos_seed","aos_seed","aos_seed","aos_seed","aos_seed"
}

local function TeesOnSetOwner(inst)
    if TheWorld.ismastersim then
        inst.aos_classified.Network:SetClassifiedTarget(inst)
    end
end

local function AttachClassified(inst, classified)
    inst.aos_classified = classified
    inst.ondetachteesclassified = function() inst:DetachTeesClassified() end
    inst:ListenForEvent("onremove", inst.ondetachteesclassified, classified)
end

local function DetachClassified(inst)
    inst.aos_classified = nil
    inst.ondetachteesclassified = nil
end

local function OverrideOnRemoveEntity(inst)
    inst.OnRemoveTees = inst.OnRemoveEntity
    function inst.OnRemoveEntity(inst)
        if inst.jointask ~= nil then
            inst.jointask:Cancel()
        end

        if inst.aos_classified ~= nil then
            if TheWorld.ismastersim then
                inst.aos_classified:Remove()
                inst.aos_classified = nil
            else
                inst:RemoveEventCallback("onremove", inst.ondetachteesclassified, inst.aos_classified)
                inst:DetachTeesClassified()
            end
        end
        return inst:OnRemoveTees()
    end
end

local function onbecamehuman(inst)
    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "tees_speed_mod", 1.15) --죽었다 살아난 후의 스피드. [스폰 시점인지는 알수없음.]
end

local function onbecameghost(inst)
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "tees_speed_mod", 2.0)
end

local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end
    
local function CalcSanityAura(inst, observer)--정신
    if observer:HasTag("character") then--발견한자의 이름 [오라를 받을사람]
        return TUNING.SANITYAURA_MED
    end    
    return 0
end

local function onattackother(inst, data)-- 33초에 거쳐 딜을입힘.
    if data.target and data.target.components.health and not data.target.components.health:IsDead() then
        local target = data.target

        if not target:HasTag("player") then --플레이어에게 딜이 들어가지않음.
            AoSAddBuff(target, "poison", 5)
        end
    end
end

local skins = {
    "DEFAULT", "christmas",
}

local function common_postinit (inst) --정신
    inst:AddTag("sneakysnake") -- 그림자 몹을 제외한 모든 몹에게서 선공당하지 않음
    inst:AddTag("aosplayer")
    inst:AddTag("tees")
    
    inst.MiniMapEntity:SetIcon( "tees.tex" )--발견한 자신의 미니맵 이름 

    OverrideOnRemoveEntity(inst)
    inst.AttachAoSClassified = AttachClassified
    inst.DetachTeesClassified = DetachClassified
end

local master_postinit = function(inst)
    inst.aos_classified = SpawnPrefab("aos_classified")
    inst:AddChild(inst.aos_classified)
    
    inst.soundsname = "warly"
    inst:AddTag("bookbuilder")-- 위커바컴의 책을 제조합니다.
    inst:AddTag("poisonous") --독 속성태그 추가
    
    inst.components.combat.poisonous = true--독 속성태그 추가 진실값
    
	inst:AddComponent("aoslevel")--레벨업
	inst:AddComponent("aosbuff")
    inst:AddComponent("aosmana")
	inst:AddComponent("lootdropper")--레벨당 드롭 컴포넌트
	inst:AddComponent("teesskill")

    inst:AddComponent("aosgeneral")
    inst.components.aosgeneral:SetSkins(skins)
    inst.components.aosgeneral:Patch()
    
    inst:AddComponent("sanityaura") --센티넬 아우라
    inst.components.sanityaura.aurafn = CalcSanityAura

	inst.components.temperature.maxtemp = 70 --체온이 이 이상 올라가지않음.
	inst.components.temperature:SetOverheatHurtRate(0.0000000000001)--체온이 71도이상일때 입는 대미지
	inst.components.temperature:SetFreezingHurtRate(2)--내손얼일때 입는 데미지
	
    -- Stats    
    inst.components.health:SetMaxHealth(CONST.DEFAULT_HEALTH) -- 피
    inst.components.hunger:SetMax(CONST.DEFAULT_HUNGER) -- 배고팡
    inst.components.sanity:SetMax(CONST.DEFAULT_SANITY) -- 정신
    
    inst.components.health.fire_damage_scale = 1.3 --불 데미지 배수 
    inst.components.combat.damagemultiplier = CONST.DEFAULT_DAMAGEMULTIPLIER    --데미지 배수 
    
    inst.components.hunger.hungerrate = 1.2 * TUNING.WILSON_HUNGER_RATE --허기수치
    inst.components.combat.min_attack_period = 0.2--공격속도
    --inst.components.health:StartRegen(0.3, 0.8)   --체력 회복
    
    --잠금해제
    inst:DoTaskInTime(0, function(inst)
        inst.components.builder:AddRecipe("sleepbomb")--선잠주머니
        inst.components.builder:AddRecipe("blowdart_sleep")--수면다트
        inst.components.builder:AddRecipe("blowdart_fire")--화염다트
        inst:PushEvent("unlockrecipe", { recipe = "sleepbomb" })
        inst:PushEvent("unlockrecipe", { recipe = "blowdart_fire" })
        inst:PushEvent("unlockrecipe", { recipe = "blowdart_sleep" })
    end)

    inst:ListenForEvent("onattackother", onattackother) --독뎀 태그
    -- inst:ListenForEvent("hungerdelta", OnHungerDelta)-- 허기에따른 변화 마침코드
    -- inst:ListenForEvent("Hungeranimal", OnHungeranimal)-- 허기에따른 변화 마침코드2
    -- inst:ListenForEvent("tees_force_proc", OnHungeranimal)-- 허기에따른 변화 마침코드2

    inst.OnLoad = onload
    inst.OnNewSpawn = onload
end


return MakePlayerCharacter("tees", prefabs, assets, common_postinit, master_postinit, start_inv)
