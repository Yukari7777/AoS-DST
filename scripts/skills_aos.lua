local Profile = GLOBAL.Profile
local TimeEvent = GLOBAL.TimeEvent
local ACTIONS = GLOBAL.ACTIONS
local State = GLOBAL.State
local GetString = GLOBAL.GetString
local BufferedAction = GLOBAL.BufferedAction
local ActionHandler = GLOBAL.ActionHandler
local EventHandler = GLOBAL.EventHandler
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local FRAMES = GLOBAL.FRAMES
local next = GLOBAL.next
local PutTarget = GLOBAL.PutTarget
local MakePysicalInvincible = GLOBAL.MakePysicalInvincible

local function ForceStopHeavyLifting(inst) 
    if inst.components.inventory:IsHeavyLifting() then
        inst.components.inventory:DropItem(inst.components.inventory:Unequip(EQUIPSLOTS.BODY), true, true)
    end
end

local function OnStartSkillGeneral(inst, shouldstop)
   inst:AddTag("inskill")
   inst.components.locomotor:Stop()
   inst.components.locomotor:Clear()
   inst:ClearBufferedAction()
   ForceStopHeavyLifting(inst)
   if shouldstop ~= false and inst.components.playercontroller ~= nil then
      inst.components.playercontroller:RemotePausePrediction()
      inst.components.playercontroller:Enable(false)
   end
   inst:PerformBufferedAction()
end

local function OnFinishSkillGeneral(inst)
   inst:RemoveTag("inskill")
   if inst.components.playercontroller ~= nil then   
      inst.components.playercontroller:Enable(true)
   end
end

local function nullfn()  -- AddAction's third argument type must be function. And I won't use action.fn at all.
   return true 
end

local function RegisterSkill(skillname, character, Stategraph, manacost, customHandler)
   -- This is a constructor to make key-press-to-action.
   -- Does Anyone want to use this function, feel free to use it
   -- and don't forget to rename ModRPCHandler's namespace and copy nullfn.
   local upperskillname = skillname:upper()

   AddAction(upperskillname, skillname, nullfn)
   AddModRPCHandler(character, skillname, function(inst)
      if customHandler ~= nil then 
         customHandler(inst)
      else
         if manacost ~= nil and inst.components.aosmana ~= nil and inst.components.aosmana.current >= manacost or manacost == nil then
            inst:PushEvent("on"..skillname) -- See aos_classified how to excute actions via PushEvent.
         else
            inst.components.talker:Say(GetString(inst.prefab, "DESCRIBE_NOMANA"))
         end
      end
   end)

   AddStategraphState("wilson", Stategraph) -- Server Stategraph
   AddStategraphActionHandler("wilson", ActionHandler(ACTIONS[upperskillname], skillname))
   AddPrefabPostInit(character, function(inst)
      inst:ListenForEvent("on"..skillname, function()
         inst.components.playercontroller:DoAction(BufferedAction(inst, nil, ACTIONS[upperskillname]))
      end)
   end)
end



--------------------------------------------------------------------------------------------------------------------
local rapier_Sg = State { 
   name = "rapier",
   tags = { "busy", "doing", "skill", "pausepredict", "aoe", "nointerrupt", "nomorph" },

   onenter = function(inst)
      OnStartSkillGeneral(inst)
      local x, y, z = inst.components.sendiskill:GetRapierTarget()
      if x ~= nil then inst:ForceFacePoint(x, y, z) end
      inst.sg:SetTimeout(12 * FRAMES)
      inst.AnimState:PlayAnimation("whip_pre") -- YUKARI : TODO. 커스텀 애니메이션. 프레임 수 7
      inst.AnimState:PushAnimation("whip", false)

      inst.sg.statemem.angle = inst.Transform:GetRotation() -- 가까이에 적이 있을경우 적에게, 없으면 바라보던 방향으로 돌진
      inst.components.sendiskill:OnStartRapier(inst, inst.sg.statemem.angle)
   end,

   timeline =
   {
      TimeEvent(4 * FRAMES, function(inst)
         inst.components.sendiskill:Explode(inst)
         inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/swipe") -- 좀더 날카롭게 찌르는 소리 같은거 없나?
      end),
   },
   
   events = {
        EventHandler("animover", function(inst)
         if inst.AnimState:AnimDone() then
            inst.sg:GoToState("idle", true)
         end
      end),
    },
   
   ontimeout = function(inst)
      inst.components.sendiskill:OnFinishCharge(inst)
      OnFinishSkillGeneral(inst)
   end,
   
   onexit = function(inst)   
      inst.components.sendiskill:OnFinishCharge(inst)
      OnFinishSkillGeneral(inst)
   end,
}

RegisterSkill("rapier", "sendi", rapier_Sg, TUNING.SENDI.SKILL_RAPIER_MANACOST)


local igniarun_Sg = State { 
   name = "igniarun",
   tags = { "busy", "doing", "skill", "pausepredict", "nomorph" },

   onenter = function(inst)
      OnStartSkillGeneral(inst)
      inst.sg:SetTimeout(13 * FRAMES)
      inst.AnimState:PlayAnimation("jumpout")

      inst.components.sendiskill:OnStartIgniaRun(inst)
   end,

   timeline =
   {
      TimeEvent(9 * FRAMES, function(inst) --점프무적
         MakePysicalInvincible(inst, false)
      end),
      TimeEvent(13 * FRAMES, function(inst)
         inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
      end),
      
   },
   
   events = {
        EventHandler("animover", function(inst)
         if inst.AnimState:AnimDone() then
            inst.sg:GoToState("idle", true)
         end
      end),
    },
   
   ontimeout = function(inst)
      inst.components.sendiskill:OnFinishCharge(inst)
      OnFinishSkillGeneral(inst)
   end,
   
   onexit = function(inst)   
      inst.components.sendiskill:OnFinishCharge(inst)
      OnFinishSkillGeneral(inst)
   end,
}

RegisterSkill("igniarun", "sendi", igniarun_Sg, TUNING.SENDI.SKILL_IGNIARUN_MANACOST)

local spiderpath = "dontstarve/creatures/spider/"
local everguard_Sg = State {
   name = "everguard",
   tags = { "busy", "doing", "skill", "pausepredict", "nointerrupt", "nomorph", },

   onenter = function(inst)
      OnStartSkillGeneral(inst)
      inst.AnimState:PlayAnimation("pickup")
      inst.AnimState:PushAnimation("pickup_lag", true)

      inst.sg:SetTimeout(60 * FRAMES)
      inst.SoundEmitter:PlaySound(spiderpath.."fallAsleep")
      inst.components.teesskill:OnStartEverguard(inst)
   end,

   timeline =
   {
      TimeEvent(12 * FRAMES, function(inst)
         inst.AnimState:Pause()
      end),

      TimeEvent(44 * FRAMES, function(inst)
         inst.AnimState:Resume()
         inst.AnimState:PushAnimation("pickup_pst", false)
         inst.SoundEmitter:PlaySound(spiderpath.."wakeup")
         inst.components.teesskill:Dehard(inst)
      end),
   },

   events = {
      EventHandler("animover", function(inst)
         if inst.AnimState:AnimDone() then
            inst.components.teesskill:OnFinishEverguard(inst)
            inst.AnimState:Resume()
            inst.sg:GoToState("idle", true)
         end
      end),
   },
 
   ontimeout = function(inst)
      inst.components.teesskill:OnFinishEverguard(inst)
      inst.AnimState:Resume()
      inst.sg:GoToState("idle", true)
      OnFinishSkillGeneral(inst)
   end,
   
   onexit = function(inst)   
      inst.components.teesskill:OnFinishEverguard(inst)
      inst.AnimState:Resume()
      if inst.bufferedaction == inst.sg.statemem.action then
         inst:ClearBufferedAction()
      end
      OnFinishSkillGeneral(inst)
   end,
}

RegisterSkill("everguard", "tees", everguard_Sg, TUNING.TEES.SKILL_EVERGUARD_MANACOST)

local viperbite_Sg = State {
   name = "viperbite",
   tags = { "busy", "doing", "skill", "pausepredict", "nomorph" },

   onenter = function(inst)
      OnStartSkillGeneral(inst)
      local target = inst.components.teesskill:GetViperbiteTarget()
      inst.sg:SetTimeout(18 * FRAMES)

      if target ~= nil and target:IsValid() then
         local x, y, z = target.Transform:GetWorldPosition()
         inst:ForceFacePoint(x, y, z)
         inst.sg.statemem.attacktarget = target
      end

      inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot", nil, nil, true)
      inst.AnimState:PlayAnimation("dart", false) -- 모션을 바라보는 방향을 클라이언트와 동기화 시키는것 보류
   end,

   timeline = {
      TimeEvent(8 * FRAMES, function(inst)
         local target = inst.sg.statemem.attacktarget
         inst.components.teesskill:Viperbite(target)
      end),
   },

   events = {
      EventHandler("animover", function(inst)
         if inst.AnimState:AnimDone() then
            inst.sg:GoToState("idle", true)
         end
      end),
   },

   ontimeout = function(inst)
      OnFinishSkillGeneral(inst)
   end,

   onexit = function(inst)   
      OnFinishSkillGeneral(inst)
   end,
}

local venomspread_Sg = State {
   name = "venomspread",
   tags = { "busy", "doing", "skill", "pausepredict", "aoe", "nointerrupt", "nomorph" },

   onenter = function(inst)
      OnStartSkillGeneral(inst)
      inst.sg:SetTimeout(42 * FRAMES)
      inst.AnimState:PlayAnimation("staff", false)
      inst.SoundEmitter:PlaySound(spiderpath.."scream")
   end,

   timeline = {
      TimeEvent(36 * FRAMES, function(inst)
         inst.AnimState:PlayAnimation("atk", false)
         inst.SoundEmitter:PlaySound(spiderpath.."Attack")
         inst.components.teesskill:VenomSpread()
      end),
   },

   events = {
      EventHandler("animover", function(inst)
         if inst.AnimState:AnimDone() then
            inst.sg:GoToState("idle", true)
            inst.AnimState:Resume()
         end
      end),
   },

   ontimeout = function(inst)
      OnFinishSkillGeneral(inst)
      inst.AnimState:Resume()
   end,

   onexit = function(inst)   
      OnFinishSkillGeneral(inst)
      inst.AnimState:Resume()
   end,
}

viperbite_CH = function(inst)
   local target = inst.components.teesskill:GetVenomspreadTarget()
   if target ~= nil then
      inst:PushEvent("onvenomspread")
   else
      if inst.components.aosmana ~= nil and inst.components.aosmana.current >= TUNING.TEES.SKILL_VIPERVITE_MANACOST then
         inst:PushEvent("onviperbite")
      else
         inst.components.talker:Say(GetString(inst.prefab, "DESCRIBE_NOMANA"))
      end
   end
end

RegisterSkill("viperbite", "tees", viperbite_Sg, TUNING.TEES.SKILL_VIPERVITE_MANACOST, viperbite_CH)
RegisterSkill("venomspread", "tees", venomspread_Sg)

local snowwind_Sg = State {
   name = "snowwind",
   tags = { "busy", "doing", "skill", "pausepredict", "nointerrupt", "nomorph", },

   onenter = function(inst)
      OnStartSkillGeneral(inst)
      inst.AnimState:PlayAnimation("pickup")
      inst.AnimState:PushAnimation("pickup_lag", true)

      inst.sg:SetTimeout(60 * FRAMES)
      if math.random() < 0.88 then -- 스킬을 쓸 때 88퍼 확률로 대사를 말함
         inst.components.talker:Say(GetString(inst.prefab, "SKILL_SNOWWIND"))
      end
      --inst.SoundEmitter:PlaySound("얼어붙는 소리") 
   end,

   timeline =
   {
      TimeEvent(12 * FRAMES, function(inst)
         inst.AnimState:Pause()
         inst.components.ananskill:SnowWind(inst)
      end),

      TimeEvent(22 * FRAMES, function(inst)
         inst.components.ananskill:SnowWind(inst)
      end),

      TimeEvent(32 * FRAMES, function(inst)
         inst.components.ananskill:SnowWind(inst)
      end),

      TimeEvent(44 * FRAMES, function(inst)
         inst.AnimState:Resume()
         inst.AnimState:PushAnimation("pickup_pst", false)
      end),
   },

   events = {
      EventHandler("animover", function(inst)
         if inst.AnimState:AnimDone() then
            inst.AnimState:Resume()
            inst.sg:GoToState("idle", true)
         end
      end),
   },
 
   ontimeout = function(inst)
      inst.AnimState:Resume()
      inst.sg:GoToState("idle", true)
      OnFinishSkillGeneral(inst)
   end,
   
   onexit = function(inst)   
      inst.AnimState:Resume()
      if inst.bufferedaction == inst.sg.statemem.action then
         inst:ClearBufferedAction()
      end
      OnFinishSkillGeneral(inst)
   end,
}

RegisterSkill("snowwind", "anan", snowwind_Sg, TUNING.ANAN.SKILL_SNOWWIND_TOTAL_MANACOST)

local ananstealth_Sg = State {
   name = "ananstealth",
   tags = { "busy", "doing", "skill", "pausepredict", "nointerrupt", "nomorph", },

   onenter = function(inst)
      OnStartSkillGeneral(inst)
      inst.AnimState:PlayAnimation("whip_pre")
      inst.AnimState:PushAnimation("whip", false)

      inst.sg:SetTimeout(14 * FRAMES)
   end,

   timeline =
   {
      TimeEvent(12 * FRAMES, function(inst)
         inst.components.ananskill:Stealth(inst)
      end),
   },

   events = {
      EventHandler("animover", function(inst)
         if inst.AnimState:AnimDone() then
            inst.AnimState:Resume()
            inst.sg:GoToState("idle", true)
         end
      end),
   },
 
   ontimeout = function(inst)
      inst.AnimState:Resume()
      inst.sg:GoToState("idle", true)
      OnFinishSkillGeneral(inst)
   end,
   
   onexit = function(inst)   
      inst.AnimState:Resume()
      if inst.bufferedaction == inst.sg.statemem.action then
         inst:ClearBufferedAction()
      end
      OnFinishSkillGeneral(inst)
   end,
}

RegisterSkill("ananstealth", "anan", ananstealth_Sg, TUNING.ANAN.SKILL_ANANSTEALTH_MANACOST)