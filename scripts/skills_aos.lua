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

GLOBAL.IsPreemptiveEnemy = function(inst, target)
   -- 트리가드를 제외한 몬스터
   -- PVP가 켜져있을경우 플레이어 아닐경우 제외
   -- 친구가 제외
   -- 자기자신이 제외
   -- 날 공격하려 하는(타겟으로 삼은) 경우 무조건
   return (target:HasTag("monster") or (target:HasTag("epic") and not target:HasTag("leif"))) and not (target:HasTag("companion") and (TheNet:GetPtargetPEnabled() or not target:HasTag("player"))) or (target.components.combat ~= nil and target.components.combat.target == inst) and target ~= inst
end

local function PutTarget(t, v)
   if not table.contains(t, v) then
      table.insert(t, v)
   end
end

GLOBAL.GetSkillTargetsInRadius = function(inst, radius)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, radius, { "_combat" } ) -- See entityreplica.lua (for _combat tag usage)
   local targets = {}
 
	for k, v in pairs(ents) do
	   -- 적 타겟순서
	   -- 1) 가장 가까운 보스(단, 트리가드 제외)
	   -- 2) 나를 타겟한 적.
      -- 3) 선공 할만한 적
      if not (v.components.health ~= nil and v.components.health:IsDead()) then 
         if v:HasTag("epic") and not v:HasTag("leif") then
            PutTarget(targets, v)
         elseif v ~= inst and v.components.combat ~= nil and v.components.combat.target == inst then
            PutTarget(targets, v)
         elseif GLOBAL.IsPreemptiveEnemy(inst, v) then
            PutTarget(targets, v)
         end
      end
   end
   
	return next(targets) ~= nil and targets or nil
end

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

local function OnStartSkillGeneralClient(inst)
   inst.components.locomotor:Stop()
   inst.components.locomotor:Clear()
   inst.entity:FlattenMovementPrediction()
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

local function AddCommonSkill(skillname, character, SgS, SgC, manacost)
   -- This is a constructor to make key-press-to-action.
   -- Does Anyone want to use this function, feel free to use it
   -- and don't forget to rename ModRPCHandler's namespace and copy nullfn.
   local upperskillname = skillname:upper()

   AddAction(upperskillname, skillname, nullfn)
   AddModRPCHandler(character, skillname, function(inst)
      if manacost ~= nil and inst.components.aosmana ~= nil and inst.components.aosmana.current >= manacost or manacost == nil then
         inst:PushEvent("on"..skillname) -- See aos_classified how to excute actions via PushEvent.
      else
         inst.components.talker:Say(GetString(inst.prefab, "DESCRIBE_NOMANA"))
      end
   end)

   AddStategraphState("wilson", SgS) -- Client Stategraph
   AddStategraphState("wilson_client", SgC) -- Server Stategraph
   AddStategraphActionHandler("wilson", ActionHandler(ACTIONS[upperskillname], skillname))
   AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS[upperskillname], skillname))
end

--------------------------------------------------------------------------------------------------------------------
local rapier_SgS = State { 
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

local rapier_SgC = State {
   name = "rapier",
   tags = { "doing", "attack", "skill" },

   onenter = function(inst)
      OnStartSkillGeneralClient(inst)
      inst.AnimState:PlayAnimation("whip_pre")
      inst.AnimState:PushAnimation("whip", false)
      inst:PerformPreviewBufferedAction()
      inst.sg:SetTimeout(11 * FRAMES)
   end,
   
   onupdate = function(inst)
      if inst.bufferedaction == nil then
         inst.sg:GoToState("idle", true)
      end
   end,

   ontimeout = function(inst)
      inst:ClearBufferedAction()
      inst.sg:GoToState("idle", inst.entity:FlattenMovementPrediction() and "noanim" or nil)
   end,
   
   onexit = function(inst)   
      inst.entity:SetIsPredictingMovement(true)
   end,
}

AddCommonSkill("rapier", "sendi", rapier_SgS, rapier_SgC, TUNING.SENDI.SKILL_RAPIER_MANACOST)


local igniarun_SgS = State { 
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
         inst.components.health:SetInvincible(false)
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

local igniarun_SgC = State {
   name = "igniarun",
   tags = { "doing", "skill" },

   onenter = function(inst)
      OnStartSkillGeneralClient(inst)
      inst.AnimState:PlayAnimation("jumpout")

      inst:PerformPreviewBufferedAction()
      inst.sg:SetTimeout(11 * FRAMES)
   end,
   
   onupdate = function(inst)
      if inst.bufferedaction == nil then
         inst.sg:GoToState("idle", true)
      end
   end,

   ontimeout = function(inst)
      inst:ClearBufferedAction()
      inst.sg:GoToState("idle", inst.entity:FlattenMovementPrediction() and "noanim" or nil)
   end,
   
   onexit = function(inst)   
      inst.entity:SetIsPredictingMovement(true)
   end,
}

AddCommonSkill("igniarun", "sendi", igniarun_SgS, igniarun_SgC, TUNING.SENDI.SKILL_IGNIARUN_MANACOST)

local everguard_SgS = State {
   name = "everguard",
   tags = { "busy", "doing", "skill", "pausepredict", "nointerrupt", "nomorph", },

   onenter = function(inst)
      OnStartSkillGeneral(inst)
      inst.AnimState:PlayAnimation("pickup")
      inst.AnimState:PushAnimation("pickup_lag", true)

      inst.sg:SetTimeout(60 * FRAMES)
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

local everguard_SgC = State {
   name = "everguard",
   tags = { "doing", "skill" },

   onenter = function(inst)
      OnStartSkillGeneralClient(inst)
      inst.AnimState:PlayAnimation("pickup")
      inst.AnimState:PushAnimation("pickup_lag", true)

      inst:PerformPreviewBufferedAction()
      inst.sg:SetTimeout(120 * FRAMES)
   end,

   onupdate = function(inst)
      if inst.bufferedaction == nil then
         inst.sg:GoToState("idle", true)
      end
   end,

   ontimeout = function(inst)
      inst:ClearBufferedAction()
      inst.sg:GoToState("idle", inst.entity:FlattenMovementPrediction() and "noanim" or nil)
   end,
   
   onexit = function(inst)   
      inst.entity:SetIsPredictingMovement(true)
   end,
}

AddCommonSkill("everguard", "tees", everguard_SgS, everguard_SgC, TUNING.TEES.SKILL_EVERGUARD_MANACOST)

local viperbite_SgS = State {
   name = "viperbite",
   tags = { "busy", "doing", "skill", "pausepredict", },

   onenter = function(inst)
      OnStartSkillGeneral(inst)
      local target = inst.components.teesskill:GetViperbiteTarget()
      inst.AnimState:PlayAnimation("dart_pre")
      inst.AnimState:PushAnimation("dart", false)
      inst.sg:SetTimeout(18 * FRAMES)

      if target ~= nil and target:IsValid() then
         inst:FacePoint(target.Transform:GetWorldPosition())
         inst.sg.statemem.attacktarget = target
      end
   end,

   timeline = {
      TimeEvent(8 * FRAMES, function(inst)
         local target = inst.sg.statemem.attacktarget
         --inst.components.teesskill:Viperbite(target)
      end),
   },

   onupdate = function(inst)
      if inst.bufferedaction == nil then
         inst.sg:GoToState("idle", true)
      end
   end,

   ontimeout = function(inst)
      OnFinishSkillGeneral(inst)
   end,

   onexit = function(inst)   
      OnFinishSkillGeneral(inst)
   end,
}

local viperbite_SgC = State {
   name = "viperbite",
   tags = { "doing", "skill", "notalking" },

   onenter = function(inst)
      OnStartSkillGeneralClient(inst)
      inst.AnimState:PlayAnimation("dart_pre")
      inst.AnimState:PushAnimation("dart", false)
      inst:PerformPreviewBufferedAction()
      inst.sg:SetTimeout(18 * FRAMES)
   end,

   timeline = {
      TimeEvent(8 * FRAMES, function(inst)
         --inst.sg:RemoveStateTag("abouttoattack")
      end),
   },

   events = {
      EventHandler("animqueueover", function(inst)
         if inst.AnimState:AnimDone() then
            inst.sg:GoToState("idle")
         end
      end),
   },

   onexit = function(inst)
      inst.entity:SetIsPredictingMovement(true)
   end,
}

local venomspread_SgS = nil


AddAction("VIPERBITE", "viperbite", nullfn)
AddAction("VENOMSPREAD", "venomspread", nullfn)
AddStategraphState("wilson", viperbite_SgS) -- Client Stategraph
AddStategraphState("wilson_client", viperbite_SgC) -- Server Stategraph
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS["VIPERBITE"], "viperbite"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS["VIPERBITE"], "viperbite"))

AddModRPCHandler("tees", "viperbite", function(inst)
   local target = inst.components.teesskill:GetVenomspreadTarget()
   if target ~= nil and target:IsAlive() then
      inst:PushEvent("onvenomspread")
   else
      if inst.components.aosmana ~= nil and inst.components.aosmana.current >= TUNING.TEES.SKILL_VIPERVITE_MANACOST then
         inst:PushEvent("onviperbite")
      else
         inst.components.talker:Say(GetString(inst.prefab, "DESCRIBE_NOMANA"))
      end
   end
end)