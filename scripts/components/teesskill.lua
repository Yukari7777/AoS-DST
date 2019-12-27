local CONST = TUNING.TEES

local TeesSkill = Class(function(self, inst)
    self.inst = inst
    self.ishardening = false

	self.angle = 0
    self.tick = 0
end)

local PICKUP_DURATION = 11
local function Hardening(inst)
    local self = inst.components.teesskill
    local c = self.ishardening and math.max(0.33,  1 - self.tick / PICKUP_DURATION) or math.max(0.33, self.tick / PICKUP_DURATION)
    inst.AnimState:SetMultColour(c, c, c, 1)

    self.tick = self.tick + 1
end

local function Reflect(inst, data)
    if data.attacker ~= nil and data.attacker.components.combat ~= nil then
        local attacker = data.attacker
        local combat = attacker.components.combat

        combat:GetAttacked(inst, (combat.defaultdamage or 10) * CONST.SKILL_EVERGUARD_BACKFIRE_MULT)
        if attacker.components.aosbuff == nil then
            attacker:AddComponent("aosbuff")
        end
        attacker.components.aosbuff:AddBuff("poison", 3)
    end
end

function TeesSkill:OnStartEverguard(inst)
    if inst.components.aosmana ~= nil then
		inst.components.aosmana:DoDelta( -CONST.SKILL_EVERGUARD_MANACOST )
    end

    if inst.SkillTask == nil then 
        inst.SkillTask = inst:DoPeriodicTask(0, Hardening)  -- 0초마다 반복 = 1프레임(0.033초)마다 반복
        self.ishardening = true

        if math.random() < 0.88 then -- 스킬을 쓸 때 88퍼 확률로 대사를 말함
            inst.components.talker:Say(GetString(inst.prefab, "SKILL_EVERGUARD"))
        end

        inst:ListenForEvent("blocked", Reflect)
        inst.components.health:SetInvincible(true)
	end
end

function TeesSkill:Dehard(inst)
    self.tick = 0
    self.ishardening = false
end

function TeesSkill:OnFinishEverguard(inst)
    self.tick = 0
    inst.components.health:SetInvincible(false)
    inst:RemoveEventCallback("blocked", Reflect)

	if inst.SkillTask ~= nil then 
		inst.SkillTask:Cancel()
		inst.SkillTask = nil
	end
end

function TeesSkill:FindVenomed(t)
    local targets = {}

    for k, v in pairs(targets) do
        if v:HasTag("teesvenom") then
            table.insert(targets, v)
        end
    end

    return next(targets) ~= nil and targets or nil
end

function TeesSkill:GetVenomspreadTarget()
    local targets = _G.GetSkillTargetsInRadius(self.inst, CONST.SKILL_VENOMSPREAD_TARGET_RADIUS) -- defined in skills_aos.lua
    local tovenom = self:FindVenomed(targets)
    local closest = tovenom ~= nil and tovenom[1] or nil

    return closest, tovenom
end

function TeesSkill:GetViperbiteTarget()
    local targets = _G.GetSkillTargetsInRadius(self.inst, CONST.SKILL_VIPERBITE_TARGET_RADIUS) -- defined in skills_aos.lua
    if targets ~= nil then
		return targets[1]
	end
end

return TeesSkill