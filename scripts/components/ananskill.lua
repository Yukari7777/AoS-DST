local CONST = TUNING.ANAN

local AnanSkill = Class(function(self, inst)
    self.inst = inst

	self.angle = 0
    self.tick = 0
end)

function AnanSkill:SnowWind(inst)
    local targets, buffed = _G.GetSkillTargetsInRadius(self.inst, CONST.SKILL_SNOWWIND_TARGET_RADIUS)
    
    if targets ~= nil then
        if inst.components.aosmana ~= nil then
            inst.components.aosmana:DoDelta( -CONST.SKILL_SNOWWIND_TOTAL_MANACOST / 3 )
        end
        
        for k, target in pairs(targets) do
            if math.random() < 0.16 and target.components.freezable ~= nil then
                target.components.freezable:AddColdness(1 + math.ceil(math.random() * 2))
                target.components.freezable:SpawnShatterFX()
            end
        
            if target.components.health ~= nil then
                target.components.health:DoDelta(-CONST.SKILL_SNOWWIND_DAMAGE)
            end
        end

        for k, target in pairs(buffed) do
            if target:HasTag("character") then
                _G.AoSAddBuff(target, "speedup", CONST.SKILL_SNOWWIND_TOTAL_SPEEDBOOST_TIME / 3)
            end
        end
    end

    print(targets, buffed)
end

function AnanSkill:Stealth(inst)
    AoSAddBuff(inst, "stealth", 10)
    SpawnPrefab("small_puff").Transform:SetPosition(inst.Transform:GetWorldPosition())

    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 20)
    for k,v in pairs(ents) do
        if v.components.combat ~= nil and v.components.combat.target == inst then
            v.components.combat.target = nil
        end
    end
end

return AnanSkill