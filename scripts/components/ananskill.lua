local CONST = TUNING.ANAN

local AnanSkill = Class(function(self, inst)
    self.inst = inst

	self.angle = 0
    self.tick = 0
end)

function AnanSkill:SnowWind(inst)
    local targets = _G.GetSkillTargetsInRadius(self.inst, CONST.SKILL_SNOWWIND_TARGET_RADIUS)
    
    if targets ~= nil then
        if inst.components.aosmana ~= nil then
            --inst.components.aosmana:DoDelta( -CONST.SKILL_SNOWWIND_TOTAL_MANACOST / 3 )
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
    end
end

return AnanSkill