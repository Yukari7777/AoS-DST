local AoSLevel = Class(function(self, inst)
	self.inst = inst

	self.level = 0
	self.exp = 0
end)

function AoSLevel:GetMaxExp() 
	return 10 + self.level * 47 + math.ceil(1.375 ^ self.level) --레벨 당 경험치통 공식
end

function AoSLevel:AddExp(amount)
   if self.level < 24 then
        if amount >= self:GetMaxExp() then
        --amount[얻은경험치]가 맥스 경험치보다 같거나 크다면 
            local leftover = amount - (self:GetMaxExp() - self.exp)
        --남은 경험치 - (맥스최대경험치 - 가진경험치)
            self:LevelUp()
        --레벨업
            return self:AddExp(leftover)
        --리턴 exp
        end
   else
       amount = 0
   end
   
    self.exp = self.exp + amount
   --가진 exp는 가진 exp+ 얻은경험치량
   
    if self.exp >= self:GetMaxExp() then --M,G 추가본
      local leftover = amount - (self:GetMaxExp() - self.exp)
      self:LevelUp()
      return self:AddExp(leftover)
   end
end

function AoSLevel:LevelUp()
	if self.level < 34 then
	   self.exp = 0
	   self.level = self.level + 1
	   self.inst.components.talker:Say(GetString(self.inst, "DESCRIBE_LEVELUP"))
	   self:ApplyStatus()
	end
end

function AoSLevel:GetValue(key)
    return TUNING[string.upper(self.inst.prefab)][key] -- 케릭터 고유 값 불러오기
end

function AoSLevel:ApplyStatus()
	local inst = self.inst
	local hunger_percent = inst.components.hunger:GetPercent()
	local health_percent = inst.components.health:GetPercent()
	local sanity_percent = inst.components.sanity:GetPercent()
	local ignoresanity = inst.components.sanity.ignore
	inst.components.sanity.ignore = false

	inst.components.health.maxhealth = self:GetValue("DEFAULT_HEALTH") + self.level * self:GetValue("HEALTH_MODIFIER")
	inst.components.hunger.max = self:GetValue("DEFAULT_HUNGER") + self.level * self:GetValue("HUNGER_MODIFIER")
	inst.components.sanity.max = self:GetValue("DEFAULT_SANITY") + self.level * self:GetValue("SANITY_MODIFIER")
	inst.components.aosmana.max = self:GetValue("DEFAULT_MANA") + self.level * self:GetValue("MANA_MODIFIER")
	
	---[[ 미쉘추가본, 아난의 레벨업에따른 공격력 배수 변환 / 아난일경우에만 아래의 함수로 데미지증가를 지정함. / 아난이 허기에따라 변화할땐 기본공격력대신, inst.damagemult 변수를 기반으로 변화한다.
	if string.upper(self.inst.prefab) == "ANAN" then
	inst.damagemult = self:GetValue("DEFAULT_DAMAGEMULTIPLIER") + self.level * self:GetValue("DAMAGE_MODIFIER")
	else
	inst.components.combat.damagemultiplier = self:GetValue("DEFAULT_DAMAGEMULTIPLIER") + self.level * self:GetValue("DAMAGE_MODIFIER")
	end
	--]]
	inst.components.health:SetPercent(health_percent)
	inst.components.hunger:SetPercent(hunger_percent)
	inst.components.sanity:SetPercent(sanity_percent)
	inst.components.sanity.ignore = ignoresanity

end

function AoSLevel:OnSave()
    return {
      level = self.level,
        exp = self.exp,
   }
end

function AoSLevel:OnLoad(data)
   if data ~= nil then
      --eater.level = data.level or 0 -- 빅시드 30제한에필요한코드 추가
      self.level = data.level or 0
      self.exp = data.exp or 0
        self:ApplyStatus()
   end
end

return AoSLevel