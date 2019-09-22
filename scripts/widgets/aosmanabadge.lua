local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local AosManaBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "health", owner)
    self.owner = owner
    self.anim:GetAnimState():SetBuild("mana_"..self.owner.prefab)

    self.manaarrow = self.underNumber:AddChild(UIAnim())
    self.manaarrow:SetPosition(0, -1, 0)
    self.manaarrow:GetAnimState():SetBank("sanity_arrow")
    self.manaarrow:GetAnimState():SetBuild("sanity_arrow")
    self.manaarrow:GetAnimState():PlayAnimation("neutral")
    self.manaarrow:SetClickable(false)

    self:StartUpdating()
end)

function AosManaBadge:OnGainFocus()
    Badge._base:OnGainFocus(self)
    if self.combinedmod then
        self.maxnum:Show()
    else
        self.num:Show()
    end
end
    
function AosManaBadge:OnLoseFocus()
    Badge._base:OnLoseFocus(self)
    if self.combinedmod then
        self.maxnum:Hide()
        self.num:Show()
    else
        self.num:Hide()
    end
end

local RATE_SCALE_ANIM = {
    [RATE_SCALE.INCREASE_HIGH] = "arrow_loop_increase_most",
    [RATE_SCALE.INCREASE_MED] = "arrow_loop_increase_more",
    [RATE_SCALE.INCREASE_LOW] = "arrow_loop_increase",
    [RATE_SCALE.DECREASE_HIGH] = "arrow_loop_decrease_most",
    [RATE_SCALE.DECREASE_MED] = "arrow_loop_decrease_more",
    [RATE_SCALE.DECREASE_LOW] = "arrow_loop_decrease",
}

function AosManaBadge:OnUpdate(dt)
    local ratescale = self.owner.replica.aosmana:GetRateScale()
    local anim = RATE_SCALE_ANIM[ratescale] or "neutral"

    if self.arrowdir ~= anim then    
        self.arrowdir = anim
        self.manaarrow:GetAnimState():PlayAnimation(anim, true)
    end
    
    if self.owner ~= nil and self.owner.aos_classified ~= nil and self.owner.replica.aosmana ~= nil then
        self.num:SetString(tostring(math.floor(self.owner.replica.aosmana:GetCurrent())))
        if self.combinedmod then
            local maxtxt = self.showmaxonnumbers and "Max:\n" or ""

            self.maxnum:SetString(maxtxt..tostring(math.floor( self.owner.replica.aosmana:Max() )))
        end
        self:SetPercent(self.owner.replica.aosmana:GetPercent(), self.owner.replica.aosmana:Max())
    end

end

return AosManaBadge