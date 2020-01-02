local next = GLOBAL.next

GLOBAL.AoSAddBuff = function(inst, buffname, duration) --버프 이름, 초
    if inst.components.aosbuff == nil then
        inst:AddComponent("aosbuff")
    end
    inst.components.aosbuff:AddBuff(buffname, duration)
end

GLOBAL.MakePysicalInvincible = function(inst, invincible)
    inst.components.combat.externaldamagetakenmultipliers:SetModifier(inst, invincible and 0 or 1, "aosinvincible")
end

GLOBAL.IsPreemptiveEnemy = function(inst, target)
    -- 트리가드를 제외한 몬스터
    -- PVP가 켜져있을경우 플레이어 아닐경우 제외
    -- 친구가 제외
    -- 자기자신이 제외
    -- 날 공격하려 하는(타겟으로 삼은) 경우 무조건
    return (target.components.combat ~= nil and target.components.health ~= nil and not target.components.health:IsDead()) 
       and (target:HasTag("monster") or (target:HasTag("epic") and not target:HasTag("leif")))
       and not (target:HasTag("companion") and (TheNet:GetPtargetPEnabled() or not target:HasTag("player")))
    or target.components.combat.target == inst and target ~= inst
 end
 
 GLOBAL.PutTarget = function(t, v)
    if not table.contains(t, v) then
       table.insert(t, v)
    end
 end

 local PutTarget = GLOBAL.PutTarget
 GLOBAL.GetSkillTargetsInRadius = function(inst, radius)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, radius, { "_combat" } ) -- See entityreplica.lua (for _combat tag usage)
   local targets = {}
 
	for k, v in pairs(ents) do
	   -- 적 타겟순서
	   -- 1) 가장 가까운 보스(단, 트리가드 제외)
	   -- 2) 나를 타겟한 적.
      -- 3) 선공 할만한 적
      if not (v == inst and v.components.health ~= nil and v.components.health:IsDead()) then 
         if v:HasTag("epic") and not v:HasTag("leif") then
            PutTarget(targets, v)
         elseif v.components.combat ~= nil and v.components.combat.target == inst then
            PutTarget(targets, v)
         elseif inst:HasTag("player") and GLOBAL.IsPreemptiveEnemy(inst, v) then
            PutTarget(targets, v)
         end
      end
   end
   
	return next(targets) ~= nil and targets or nil
end