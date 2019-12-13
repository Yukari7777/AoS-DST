local CONST = TUNING.AOS_GENERAL

local function OnTaskTick(inst, self, period)
    self:DoDec(period)
end

local function InspectTweak(inst, self)
    inst.components.inspectable.getspecialdescription = function(inst, viewer)
        local timedescribe = self.timemilkleft > 0 and STRINGS.DESCRIBE_MILK_LEFT..self.timemilkleft or STRINGS.DESCRIBE_CANMILK
        local text = string.format(GetDescription(viewer, inst).."\n"..timedescribe)
        
        return string.format(text)
    end
end

local AOS_Milkable= Class(function(self, inst)
    self.inst = inst
    self.timemilkleft = 0

    local period = 1
    self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
    self.inst:DoTaskInTime(0, InspectTweak, self)
end)

function AOS_Milkable:DoDec(dt)
    if self.timemilkleft > 0 then
        self.timemilkleft = self.timemilkleft - 1
    elseif not self.inst:HasTag("amilkable") then
        self.inst:AddTag("amilkable")
    end
end

function AOS_Milkable:LongUpdate(dt)
    self:DoDec(dt, true)
end

function AOS_Milkable:OnSave()
    return {
        timemilkleft = self.timemilkleft,
    }
end

function AOS_Milkable:OnLoad(data)
    if data ~= nil then
        if data.timemilkleft and data.timemilkleft > 0 then
            self.timemilkleft = data.timemilkleft
        else
            self.timemilkleft = 0
            self.inst:AddTag("amilkable")
        end
    end
end

function AOS_Milkable:CanMilk()
    return self.inst:HasTag("amilkable") -- 추가 조건
end

function AOS_Milkable:Milk(worker) 
    if self.timemilkleft > 0 or not self:CanMilk() then -- 우유짜기 추가 조건
        return false
    end

    if self.inst:HasTag("beefalo") and math.random() < CONST.MILK_KICKCHANCE and worker.components.combat ~= nil then
        worker.components.combat:GetAttacked(self.inst, TUNING.BEEFALO_KICK_DAMAGE)
        self.inst.sg:GoToState("attack")
        worker:PushEvent("kick")
    elseif worker ~= nil and worker.components.inventory ~= nil then
        local product = SpawnPrefab("sendi_food_milk_strong")
        product.components.stackable:SetStackSize(math.random(CONST.MILK_MINAMOUNT, CONST.MILK_MAXAMOUNT)) -- 3개에서 5개 랜덤으로 줌
        worker:PushEvent("picksomething", { object = self.inst, loot = product })
        worker.components.inventory:GiveItem(product, nil, self.inst:GetPosition())

        if self.inst:HasTag("beefalo") then
            self.inst.sg:GoToState("bellow")
        end
    else 
        return false
    end

    self.timemilkleft = CONST.MILK_COOLTIME
    self.inst:RemoveTag("amilkable")

    return true
end

return AOS_Milkable