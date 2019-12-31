local CONST = TUNING.AOS_GENERAL

local BUFF_TYPE = {
    test = { -- 디버프 이름
        isdebuff = true,
        interval = 1,
        maxcount = 10,
        extendmult = 1/2, -- 버프 연장 효율

        onstart = function(inst)-- TODO : 디버프 아이콘
            inst.AnimState:SetMultColour(0.8, 0.5, 0.5, 1)
        end,

        fn = function(inst)
            if inst.components.health ~= nil then
                inst.components.health:DoDelta(1, nil, nil, true)
            end
            inst.components.talker:Say(tostring(inst.components.aosbuff.buff.test.arg[2]))
        end,

        onfinish = function(inst)
            inst.AnimState:SetMultColour(1, 1, 1, 1)
        end,
    },

    flame = {
        isdebuff = true,
        interval = CONST.DEBUFF_FLAME_INTERVAL,
        maxtime = CONST.DEBUFF_FLAME_MAX_TIME,
        extendmult = CONST.DEBUFF_FLAME_EXTEND_MULT,

        onstart = function(inst)
            inst.AnimState:SetMultColour(0.8, 0.5, 0.5, 1)
        end,

        fn = function(inst)
            if inst.components.health ~= nil then
                inst.components.health:DoDelta(-CONST.DEBUFF_FLAME_DAMAGE, true, "flame")
            end
        end,

        onfinish = function(inst)
            inst.AnimState:SetMultColour(1, 1, 1, 1)
        end,
    },

    poison = {
        isdebuff = true,
        interval = CONST.DEBUFF_POISON_INTERVAL,
        maxtime = CONST.DEBUFF_POISON_MAX_TIME,
        extendmult = CONST.DEBUFF_POISON_EXTEND_MULT,

        onstart = function(inst)
            inst.AnimState:SetMultColour(0.8, 0.3, 0.8, 1)
            inst:AddTag("teespoison")
        end,

        fn = function(inst)
            if inst.components.health ~= nil and not inst.components.health:IsDead() then
                local hp = inst.components.health.currenthealth
                local delta = CONST.DEBUFF_POISON_DAMAGE
                delta = delta >= hp and hp - 1 or delta

                inst.components.health:DoDelta(-delta, nil)
            end
        end,
        
        onfinish = function(inst)
            inst.AnimState:SetMultColour(1, 1, 1, 1)
            inst:RemoveTag("teespoison")
        end,
    },

    venom = {
        isdebuff = true,
        interval = CONST.DEBUFF_VENOM_INTERVAL,
        maxtime = CONST.DEBUFF_VENOM_MAX_TIME,
        extendmult = CONST.DEBUFF_VENOM_EXTEND_MULT,

        onstart = function(inst)
            inst.AnimState:SetMultColour(0.9, 0.2, 0.9, 1)
            inst:AddTag("teesvenom")
        end,

        fn = function(inst)
            if inst.components.health ~= nil and not inst.components.health:IsDead() then
                local hp = inst.components.health.currenthealth
                local delta = CONST.DEBUFF_VENOM_DAMAGE
                delta = delta >= hp and hp - 1 or delta

                inst.components.health:DoDelta(-delta, nil)
            end
        end,

        onfinish = function(inst)
            inst.AnimState:SetMultColour(1, 1, 1, 1)
            inst:RemoveTag("teesvenom")
        end,
    },

    frostbite = {
        isdebuff = true,
        interval = CONST.DEBUFF_FROSTBITE_INTERVAL,
        maxtime = CONST.DEBUFF_FROSTBITE_MAX_TIME,
        extendmult = CONST.DEBUFF_FROSTBITE_EXTEND_MULT,

        onstart = function(inst)
            inst.AnimState:SetMultColour(0.5, 0.8, 0.5, 1)
        end,

        fn = function(inst)
            if inst.components.health ~= nil then
                inst.components.health:DoDelta(-CONST.DEBUFF_FROSTBITE_DAMAGE)
            end
            
            if math.random() > DEBUFF_FROSTBITE_FREEZE_CHANCE then
                if target.components.freezable ~= nil then
                    target.components.freezable:AddColdness(1)
                    target.components.freezable:SpawnShatterFX()
                end
            end

            if inst.components.aosbuff.buff.frostbite.arg[2] >= 10 then
                inst:AddTag("frostbitten")
            else
                inst:RemoveTag("frostbitten")
            end
        end,
        
        onfinish = function(inst)
            inst.AnimState:SetMultColour(1, 1, 1, 1)
        end,
    },
}

local AoSBuff = Class(function(self, inst)
    self.inst = inst
    self.buff = {}
    self.bufftask = nil
end)

function AoSBuff:PeriodicFunction(type)
    local Arg = self.buff[type].arg
    if Arg[2] > 0 then 
        BUFF_TYPE[type].fn(self.inst)
        Arg[2] = Arg[2] - 1
    else
        self:OnTimeOut(type)
    end
end

function AoSBuff:OnTimeOut(type)
    BUFF_TYPE[type].onfinish(self.inst)
    self.buff[type]:Cancel()
    self.buff[type] = nil
end

function AoSBuff:HasBuff(type)
    return self.buff[type] ~= nil
end

function AoSBuff:RemoveBuff(type, nofinish)
    if nofinish then
        self.buff[type]:Cancel()
        self.buff[type] = nil
    else
        self:OnTimeOut(type)
    end
end

function AoSBuff:AddBuff(type, duration, initialdelay)
    local interval = BUFF_TYPE[type].interval
    local count = math.floor(duration / interval)

    if self.buff[type] ~= nil then
        local LeftCount = self.buff[type].arg[2]
        local FinalCount = LeftCount + (BUFF_TYPE[type].extendmult or 1) * count >= BUFF_TYPE[type].maxtime / interval and BUFF_TYPE[type].maxtime / interval or LeftCount + (BUFF_TYPE[type].extendmult or 1) * count
        self.buff[type].arg[2] = FinalCount
    else
        BUFF_TYPE[type].onstart(self.inst)
        self.buff[type] = self.inst:DoPeriodicTask(interval, function() self:PeriodicFunction(type) end, initialdelay, count)
    end
end

function AoSBuff:OnRemoveFromEntity()
    for _, v in pairs(self.buff) do
        v:Cancel()
        v = nil
    end
end

return AoSBuff