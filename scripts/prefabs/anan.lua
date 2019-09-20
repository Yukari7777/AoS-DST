local MakePlayerCharacter = require "prefabs/player_common"
local CONST = TUNING.ANAN

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

local start_inv = {--시작 인벤토리
	
	"anan_dagger",
	"meat_dried",
	"meat_dried",
	"meat_dried",
	"meat_dried",
	"meat_dried",
	"healingsalve",
	"healingsalve",
}
--키

--키

local function onbecamehuman(inst)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "anan_speed_mod", 1.1) --죽었다 살아날때의 스피드. [스폰 시점인지는 알수없음.]
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

	--	캐릭터 능력 관련 펑션들

	
	
local function CalcSanityAura(inst, observer)--정신
	if observer:HasTag("tees") then --발견한자의 이름 [오라를 받을사람]
		return TUNING.SANITYAURA_MED

		
	end	
	return 0
end
	
	
local function common_postinit (inst) --정신
	--inst:AddTag("valkyrie")--위그장비 제작 가능
	inst:AddTag("anan")--자신의 태그 
	inst:AddTag("anancraft")--전용탭추가
	inst.MiniMapEntity:SetIcon( "anan.tex" )--발견한 자신의 미니맵 이름 
	inst:AddComponent("sanityaura")
	inst.components.sanityaura.aurafn = CalcSanityAura
	
	
	inst:AddTag("masterchef")--왈리 
    inst:AddTag("professionalchef")--왈리
    inst:AddTag("expertchef")--왈리

	return inst

end
	
		local function anan_OnHungerDelta(inst, data)-- 허기에따른 스피드와 공격력 변화
			if inst.components.combat ~= nil then
				local percent = data.newpercent
					inst.components.locomotor:SetExternalSpeedMultiplier(inst, "anan_speed_mod", 1 + percent * 0.5)
					inst.components.combat.damagemultiplier = CONST.DEFAULT_DAMAGEMULTIPLIER + percent * 1.25 --딜

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
			
			if inst.components.hunger.current < 50 then
				inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1)
			else
			if inst.components.hunger.current > 50 then
				inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 3)
			end
				inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 3)
			end
		end
					



local master_postinit = function(inst)

	
	inst.soundsname = "wilson"
    -- inst:AddComponent("inspectable")
    -- inst:AddComponent("instrument")
    -- inst.components.instrument.range = TUNING.HOUNDWHISTLE_RANGE
    -- inst.components.instrument:SetOnHeardFn(HearHoundWhistle)
	
	inst:AddComponent("ananlevel")--레벨업

	-- Stats	
	inst.components.health:SetMaxHealth(CONST.DEFAULT_HEALTH) -- 피
	inst.components.hunger:SetMax(CONST.DEFAULT_HUNGER) -- 배고팡
	inst.components.sanity:SetMax(CONST.DEFAULT_SANITY) -- 정신

	-- Hunger rate (optional)
	inst.components.combat.min_attack_period = 0.15--공격속도
	inst.components.health.fire_damage_scale = 1.5 --불 데미지 배수 
	--inst.components.combat.damagemultiplier = CONST.DEFAULT_DAMAGEMULTIPLIER	--데미지 배수 
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)--허기수치
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload

		--잠금해제
	inst:DoTaskInTime(0, function(inst)
		inst.components.builder:AddRecipe("birdtrap")--트랩들
		inst:PushEvent("unlockrecipe", { recipe = "birdtrap" })
	end)	
	inst:DoTaskInTime(0, function(inst)
		inst.components.builder:AddRecipe("trap_teeth")--트랩들
		inst:PushEvent("unlockrecipe", { recipe = "trap_teeth" })
	end)		

	
	
	inst:ListenForEvent("hungerdelta", anan_OnHungerDelta)-- 허기에따른 변화 마침코드/ hp에따라 변경하고싶을시 앞의 글자를 healthdelta로 변경
	inst:ListenForEvent("hungerdelta", anan_OnSanitychange)--정신에따른 캐릭터 속성 및 능력 테그/ hp에따라 변경하고싶을시 앞의 글자를 healthdelta로 변경
	inst:ListenForEvent("hungerdelta", anan_Onhungrypuppy)--30배고픔이하이면 배고픔수치 감소/ hp에따라 변경하고싶을시 앞의 글자를 healthdelta로 변경
	-- inst:ListenForEvent("sanitydelta", anan_sanitydown)--30배고픔이하이면 배고픔수치 감소/ hp에따라 변경하고싶을시 앞의 글자를 healthdelta로 변경
	
	


end

return MakePlayerCharacter("anan", prefabs, assets, common_postinit, master_postinit, start_inv)