local MakePlayerCharacter = require "prefabs/player_common"
local CONST = TUNING.ANAN

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	---
	
	Asset("ANIM", "anim/anan_skin_christmas.zip"), -- 크리스마스 사이드테일
    -- Asset("ANIM", "anim/sendi_skin_christmas_b.zip"),  --크리스마스 롱테일 
    -- Asset("ANIM", "anim/sendi_skin_ignia.zip"), --ver.이그니아 
    -- Asset("ANIM", "anim/sendi_skin_ignias.zip"), --ver.이그니아 금발
}
local prefabs = {}

local start_inv = {--시작 인벤토리--

    "anan_dagger",
    "meat_dried",
    "meat_dried",
    "meat_dried",
    "meat_dried",
    "meat_dried",
    "healingsalve",
    "healingsalve",
    
    "aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed",
    "aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed","aos_seed",
    "aos_seed","aos_seed","aos_seed","aos_seed","aos_seed"
    
}

local function AnanOnSetOwner(inst)
   if TheWorld.ismastersim then
        inst.aos_classified.Network:SetClassifiedTarget(inst)
    end
end

local function AttachClassified(inst, classified)
   inst.aos_classified = classified
    inst.ondetachananclassified = function() inst:DetachAnanClassified() end
    inst:ListenForEvent("onremove", inst.ondetachananclassified, classified)
end

local function DetachClassified(inst)
   inst.aos_classified = nil
    inst.ondetachananclassified = nil
end

local function OverrideOnRemoveEntity(inst)
   inst.OnRemoveAnan = inst.OnRemoveEntity
   function inst.OnRemoveEntity(inst)
      if inst.jointask ~= nil then
         inst.jointask:Cancel()
      end

      if inst.aos_classified ~= nil then
         if TheWorld.ismastersim then
            inst.aos_classified:Remove()
            inst.aos_classified = nil
         else
            inst:RemoveEventCallback("onremove", inst.ondetachananclassified, inst.aos_classified)
            inst:DetachAnanClassified()
         end
      end
      return inst:OnRemoveAnan()
   end
end

local function onbecamehuman(inst)
   inst.components.locomotor:SetExternalSpeedMultiplier(inst, "anan_speed_mod", 1) --죽었다 살아날때의 스피드. [스폰 시점인지는 알수없음.]
end

local function onbecameghost(inst)

   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "anan_speed_mod", 2.0)
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

--   캐릭터 능력 관련 펑션들
local function CalcSanityAura(inst, observer)--정신
    if observer:HasTag("aosplayer") then --발견한자의 이름 [오라를 받을사람]
        return TUNING.SANITYAURA_SMALL
    end
    return 0
end
   
local function anan_OnHungerDelta(inst, data)-- 허기에따른 스피드와 공격력 변화
    if inst.components.combat ~= nil then
        local percent = data.newpercent
            inst.components.locomotor:SetExternalSpeedMultiplier(inst, "anan_speed_mod", 1 + percent * 0.5)
            inst.components.combat.damagemultiplier = inst.damagemult + percent * 1.25 --딜

    end
end

local function anan_OnSanitychange(inst) --정신력이 30 이하이면 몬스터태그, 캐릭터태그로, 하운드 태그로 바뀐다.
    if inst.components.sanity.current < 30 then
            --정신력이 30 이하이면
            --태그를 지운다.
            inst:RemoveTag("character")
            inst:RemoveTag("houndfriend")
            inst:RemoveTag("hound")
            inst:RemoveTag("warg")--animal
            inst:RemoveTag("animal")
            inst:RemoveTag("pig")
            inst:RemoveTag("werepig")
            --태그를만든다.
            inst:AddTag("monster")--성질테그

            --정신력이 30 이하이면몬스터, 캐릭터 태그로 변경된다.
        else
    if inst.components.sanity.current >=30 then   
            --정신력이 30 이상이면 
            --태그를 지운다.
            inst:RemoveTag("monster")--몬스터태그를 지움.
        
            --태그를만든다.
            inst:AddTag("character")
            inst:AddTag("houndfriend")--성질테그
            inst:AddTag("hound")
            inst:AddTag("animal")   
            inst:AddTag("warg")--바그
            inst:AddTag("pig")
            inst:AddTag("werepig")
        end
    end
end

local function anan_Onhungrypuppy(inst) --배고픈강아지 허기수치가 30 미만이면 허기수치가 1로 바뀐다. 
    if inst.components.hunger.current < 40 then
        inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1)
   
    elseif inst.components.hunger.current > 50 then
        inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 2)

    elseif inst.components.hunger.current > 100 then
        inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 3)
        
        inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 3)
    end
end
    

--스킨추가

local skins = { -- "anan_skin_" [스킨] 뒤에 나오는 이름
    "DEFAULT", "christmas",
}

local function OnChangeSkin(inst) -- YUKARI 스킨관련
    inst.skinindex = inst.skinindex >= #skins and 1 or inst.skinindex + 1
    SetSkinBuild(inst)
    -- TODO : 감정표현 추가
end

----------스킨 끝

local function common_postinit (inst) --정신
    
    inst:AddTag("anan")--자신의 태그 
    inst:AddTag("anancraft")--전용탭추가
    inst:AddTag("aosplayer")
    inst.MiniMapEntity:SetIcon( "anan.tex" )--발견한 자신의 미니맵 이름 
    inst:AddTag("expertchef")--왈리[빠른쿠킹]
	
	--inst:AddTag("valkyrie")--위그장비 제작 가능
    --inst:AddTag("masterchef")--왈리 
    --inst:AddTag("professionalchef")--왈리
	
    OverrideOnRemoveEntity(inst)
    inst.AttachAoSClassified = AttachClassified
    inst.DetachAnanClassified = DetachClassified
end

local master_postinit = function(inst)
    inst.aos_classified = SpawnPrefab("aos_classified")
    inst:AddChild(inst.aos_classified)
    
    inst.soundsname = "wortox"
    inst.skinindex = 1

    inst:AddComponent("aoslevel")--레벨업
    inst:AddComponent("aosbuff")
	inst:AddComponent("ananskill")
    inst:AddComponent("aosmana")
	inst:AddComponent("lootdropper")--레벨당 드롭 컴포넌트
	
    inst:AddComponent("sanityaura")--센티넬아우라 
    inst.components.sanityaura.aurafn = CalcSanityAura
	
    ---[[추위에 강하며 열에약함 

	inst.components.temperature.mintemp = 0 --체온이 이 이상 내려가지않음.
	inst.components.temperature:SetFreezingHurtRate(0.0000000000001)--체온이 71도이상일때 입는 대미지
	inst.components.temperature:SetOverheatHurtRate(2)--너무더워 입는 데미지
	--inst.components.`ㅊ:SetResistance(80) --더위저항
	--]]
	
    -- Stats   
    inst.components.health:SetMaxHealth(CONST.DEFAULT_HEALTH) -- 피
    inst.components.hunger:SetMax(CONST.DEFAULT_HUNGER) -- 배고팡
    inst.components.sanity:SetMax(CONST.DEFAULT_SANITY) -- 정신

    -- Hunger rate (optional)
    inst.components.combat.min_attack_period = 0.15--공격속도
    inst.components.health.fire_damage_scale = 1.5 --불 데미지 배수 
    inst.components.combat.damagemultiplier = CONST.DEFAULT_DAMAGEMULTIPLIER   --데미지 배수 
    ---[[ 데미지변환[aos 레벨업에서 추가변화있음] 
    inst.damagemult = CONST.DEFAULT_DAMAGEMULTIPLIER --데미지를 지정 [M]
    --]]
    inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)--허기수치

    inst.OnLoad = onload
    inst.OnNewSpawn = onload
    inst.ChangeSkin = OnChangeSkin
    inst.Skins = skins
	
    --잠금해제
    inst:DoTaskInTime(0, function(inst)
        inst.components.builder:AddRecipe("birdtrap")
        inst.components.builder:AddRecipe("trap_teeth")
        inst:PushEvent("unlockrecipe", { recipe = "birdtrap" })
        inst:PushEvent("unlockrecipe", { recipe = "trap_teeth" })
    end)
    
    inst:ListenForEvent("hungerdelta", anan_OnHungerDelta)-- 허기에따른 변화 마침코드/ hp에따라 변경하고싶을시 앞의 글자를 healthdelta로 변경
    inst:ListenForEvent("sanitydelta", anan_OnSanitychange)--정신에따른 캐릭터 속성 및 능력 테그/ hp에따라 변경하고싶을시 앞의 글자를 healthdelta로 변경
    inst:ListenForEvent("hungerdelta", anan_Onhungrypuppy)--30배고픔이하이면 배고픔수치 감소/ hp에따라 변경하고싶을시 앞의 글자를 healthdelta로 변경

end

return MakePlayerCharacter("anan", prefabs, assets, common_postinit, master_postinit, start_inv)