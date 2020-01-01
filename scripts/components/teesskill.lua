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
        AoSAddBuff(attacker, "poison", 3)
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

    return tovenom
end

function TeesSkill:GetViperbiteTarget()
    local targets = _G.GetSkillTargetsInRadius(self.inst, CONST.SKILL_VIPERBITE_TARGET_RADIUS) -- defined in skills_aos.lua
    if targets ~= nil then
		return targets[1]
	end
end

function TeesSkill:Viperbite(target)
    if not target or target.components.health ~= nil and target.components.health:IsDead() then return end

    local inst = self.inst
    if inst.components.aosmana ~= nil then
		--inst.components.aosmana:DoDelta( -CONST.SKILL_EVERGUARD_MANACOST )
    end
    
    -- 티스가 스킬로 맞춘 적이 너무 가까이에 있을경우 어그로 끌림
    local targets = _G.GetSkillTargetsInRadius(inst, CONST.SKILL_VIPERBITE_AGGRO_RADIUS) --어그로범위 = 6
    local shouldtarget = false
    if targets ~= nil then 
        for k, v in pairs(targets) do
            if v == target then
                shouldtarget = true
                break
            end
        end
    end

    if _G.IsPreemptiveEnemy(inst, target) then
        target.components.combat:GetAttacked(shouldtarget and inst or nil, CONST.SKILL_VIPERVITE_DAMAGE)
        AoSAddBuff(target, "venom", 5)
    end
end

function TeesSkill:VenomSpread()
    local inst = self.inst
    local targets = self:GetVenomspreadTarget() or {}
    local spreadtarget = {}

    for k, v in pairs(targets) do
        if _G.IsPreemptiveEnemy(inst, target) then
            target.components.combat:GetAttacked(nil, CONST.SKILL_VENOMSPREAD_DAMAGE)
        end

        local tospread = _G.GetSkillTargetsInRadius(CONST.SKILL_VENOMSPREAD_SPREAD_RADIUS) or {}
        for k2, v2 in pairs(tospread) do
            _G.PutTarget(spreadtarget, v2)
        end
    end

    for k, v in pairs(spreadtarget) do
        if _G.IsPreemptiveEnemy(inst, v) then
            AoSAddBuff(v, "poison", 5)
        end
    end
end

return TeesSkill