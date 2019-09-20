local CONST = TUNING.AOS_GENERAL

local AosMana = Class(function(self, inst)
    self.inst = inst

	if TheWorld.ismastersim then
        self.classified = inst.aos_classified
    elseif self.classified == nil and inst.aos_classified ~= nil then
        self:AttachClassified(inst.aos_classified)
    end
end)

--------------------------------------------------------------------------

function AosMana:OnRemoveFromEntity()
    if self.classified ~= nil then
        if TheWorld.ismastersim then
            self.classified = nil
        else
            self.inst:RemoveEventCallback("onremove", self.ondetachclassified, self.classified)
            self:DetachClassified()
        end
    end
end

AosMana.OnRemoveEntity = AosMana.OnRemoveFromEntity

function AosMana:AttachClassified(classified)
    self.classified = classified
    self.ondetachclassified = function() self:DetachClassified() end
    self.inst:ListenForEvent("onremove", self.ondetachclassified, classified)
end

function AosMana:DetachClassified()
    self.classified = nil
    self.ondetachclassified = nil
end

--------------------------------------------------------------------------

function AosMana:SetMaxAosMana(max)
	self.classified.maxaosmana:set(max)
end

function AosMana:SetCurrent(current)
	self.classified.currentaosmana:set(current)
end

function AosMana:Max()
    if self.inst.components.aosmana ~= nil then
        return self.inst.components.aosmana.max
    elseif self.classified ~= nil then
        return self.classified.maxaosmana:value()
    else
        return CONST.MANA_MAX_DEFAULT
    end
end

function AosMana:GetCurrent()
    if self.inst.components.aosmana ~= nil then
        return self.inst.components.aosmana.current
    elseif self.classified ~= nil then
        return self.classified.currentaosmana:value()
    else
        return CONST.MANA_CURRENT_DEFAULT
    end
end

function AosMana:GetPercent()
    if self.inst.components.aosmana ~= nil then
        return self.inst.components.aosmana:GetPercent()
    end
    return self:GetPercentNetworked()
end

function AosMana:GetPercentNetworked()
    --Use networked value whether we are server or client
    return self.classified ~= nil and self.classified.maxaosmana ~= nil and  self.classified.currentaosmana ~= nil and self.classified.currentaosmana:value() / self.classified.maxaosmana:value() or 1
end

function AosMana:SetRateScale(ratescale)
    if self.classified ~= nil then
        self.classified.aosmanaratescale:set(ratescale)
    end
end

function AosMana:GetRateScale()
    if self.inst.components.aosmana ~= nil then
        return self.inst.components.aosmana:GetRateScale()
    elseif self.classified ~= nil then
        return self.classified.aosmanaratescale:value()
    else
        return RATE_SCALE.NEUTRAL
    end
end

return AosMana