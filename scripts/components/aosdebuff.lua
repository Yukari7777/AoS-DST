local CONST = TUNING.AOS_GENERAL

local DEBUFF_TYPE = {
    test = { -- 디버프 이름
        interval = 0.5,

        onstart = function(inst)-- TODO : 디버프 아이콘
            inst.AnimState:SetMultColour(0.8, 0.5, 0.5, 1)
        end,

        fn = function(inst)
            if inst.components.health ~= nil then
                inst.components.health:DoDelta(-5)
            end
        end,

        onfinish = function(inst)
            inst.AnimState:SetMultColour(1, 1, 1, 1)
        end,
    }
}

local AoSDebuff = Class(function(self, inst)
    self.inst = inst
    self.debuff = {}
    self.debufftask = nil
end)

function AoSDebuff:AddDebuff(type, duration, initialdelay)
    local PeriodicTask = self.inst:DoPeriodicTask(DEBUFF_TYPE[type].interval, DEBUFF_TYPE[type].fn, initialdelay)
    local TimeoutTask = self.inst:DoTaskInTime(duration, DEBUFF_TYPE[type].onfinish)

    self.debuff[type] = PeriodicTask
    
end

function AoSDebuff:OnRemoveFromEntity()
    for _, v in pairs(self.debuff) do
        v:Cancel()
        v = nil
    end
end