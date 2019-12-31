GLOBAL.AoSAddBuff = function(inst, buffname, duration) --버프 이름, 초
    if inst.components.aosbuff == nil then
        inst:AddComponent("aosbuff")
    end
    inst.components.aosbuff:AddBuff(buffname, duration)
end