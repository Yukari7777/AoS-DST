--토끼수인이 고기를 들어도 공격하지않게만들려면  해당 장비 루아의 OnEquip에 [owner:RemoveTag("ignoreMeat")] OnUnequip에  [owner:RemoveTag("ignoreMeat")] 를 추가하세요.

PrefabFiles = {
---[[센디 전용 아이템등을 추가
    "aos_classified",
    "sendi",
    "sendi_none",
    --------캐릭터요소---------
    "sendipack", 
    --------기타---------
    "sendisedmask", --센디마스크
    "sendi_hat_crown", -- 군주의 왕관
    "sendi_hat_goggles", -- 프랜드 고글
    "sendi_hat_spider", -- 스파이더 헬멧
    --------모자----------
    "sendi_rapier_wood", --우드 레이피어
    "sendi_rapier", --레이피어
    "sendi_rapier_ignia", --이그니아레이피어
    --------레이피어-----------
    "sendi_armor_01", --센디의 니트 갑옷
    "sendi_armor_02", --센디의 여름용 갑옷

    --"sendi_amulet",    --sendi_amulet
    --------갑옷--------------
    "sendi_oven", -- 센디 오븐
    "sendi_ovenfire_fx", -- 센디 오븐의 불꽃이펙트
    "sendiobject_hut", -- 센디 오두막
    "sendiobject_warehouse", -- 센디 창고
    -------오브젝트[오븐]-------
    "aos_seed",
    -------시드---------------
    
    "sendi_food",
    
    --------음식------------
--]]
---[[ 아난
    "anan",
    "anan_none",
    ---
    "anan_dagger_wolf",
    "anan_dagger_hard",
    "anan_dagger", 
--]]
---[[ 티스
    "tees",
    "tees_none",
--]]
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/sendi.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/sendi.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/sendi.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/sendi.xml" ),
    
    Asset( "IMAGE", "images/selectscreen_portraits/sendi_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/sendi_silho.xml" ),

    Asset( "IMAGE", "bigportraits/sendi.tex" ),
    Asset( "ATLAS", "bigportraits/sendi.xml" ),
    
    Asset( "IMAGE", "images/map_icons/sendi.tex" ),
    Asset( "ATLAS", "images/map_icons/sendi.xml" ),
    
    Asset( "IMAGE", "images/avatars/avatar_sendi.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_sendi.xml" ),
    
    Asset( "IMAGE", "images/avatars/avatar_ghost_sendi.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_sendi.xml" ),
    
    Asset( "IMAGE", "images/avatars/self_inspect_sendi.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_sendi.xml" ),
    
    Asset( "IMAGE", "images/names_sendi.tex" ),
    Asset( "ATLAS", "images/names_sendi.xml" ),
    
    Asset( "IMAGE", "images/names_gold_sendi.tex" ),
    Asset( "ATLAS", "images/names_gold_sendi.xml" ),
    
    Asset( "IMAGE", "bigportraits/sendi_none.tex" ),
    Asset( "ATLAS", "bigportraits/sendi_none.xml" ),
    
    Asset( "IMAGE", "images/inventoryimages/senditab.tex" ),
    Asset( "ATLAS", "images/inventoryimages/senditab.xml" ),
    
    -----------아이템을 추가 합니다. 
    Asset( "IMAGE", "images/inventoryimages/sendipack.tex"),
    Asset( "ATLAS", "images/inventoryimages/sendipack.xml"),
    ------- 센디의 책가방
    Asset( "IMAGE", "images/inventoryimages/sendisedmask.tex"),
    Asset( "ATLAS", "images/inventoryimages/sendisedmask.xml"),
    ------- 센디의 눈물 마스크 
    Asset( "IMAGE", "images/inventoryimages/sendi_hat_crown.tex"),
    Asset( "ATLAS", "images/inventoryimages/sendi_hat_crown.xml"),
    ------- 프랜드 폭시 헬멧
    Asset( "IMAGE", "images/inventoryimages/sendi_hat_goggles.tex"),
    Asset( "ATLAS", "images/inventoryimages/sendi_hat_goggles.xml"),
    ------- 군주의 고글    
    Asset( "IMAGE", "images/inventoryimages/sendi_hat_spider.tex"),
    Asset( "ATLAS", "images/inventoryimages/sendi_hat_spider.xml"),
    ------- 스파이더 헬멧
    Asset( "IMAGE", "images/inventoryimages/sendi_armor_01.tex"),
    Asset( "ATLAS", "images/inventoryimages/sendi_armor_01.xml"),
    -------센디의 니트갑옷 [임의 지정]
    Asset( "IMAGE", "images/inventoryimages/sendi_armor_02.tex"),
    Asset( "ATLAS", "images/inventoryimages/sendi_armor_02.xml"),
    --------라이프 아머    
    
    -- Asset( "IMAGE", "images/inventoryimages/sendi_amulet.tex"),
    -- Asset( "ATLAS", "images/inventoryimages/sendi_amulet.xml"),    
    
    
    Asset( "IMAGE", "images/inventoryimages/sendi_rapier_wood.tex"),
    Asset( "ATLAS", "images/inventoryimages/sendi_rapier_wood.xml"),
    --------연습용 목재 레이피어
    Asset( "IMAGE", "images/inventoryimages/sendi_rapier.tex"),
    Asset( "ATLAS", "images/inventoryimages/sendi_rapier.xml"),
    --------센디의 레이피어
    Asset( "IMAGE", "images/inventoryimages/sendi_rapier_ignia.tex"),
    Asset( "ATLAS", "images/inventoryimages/sendi_rapier_ignia.xml"),
    --------이그니아 레이피어
    Asset("ANIM", "anim/sendi_oven.zip"),
    Asset("ANIM", "anim/sendi_oven_open.zip"),
    Asset("ANIM", "anim/sendi_oven_fire.zip"),
    Asset("ANIM", "anim/sendi_oven_fire_cold.zip"),
    Asset("ATLAS", "images/inventoryimages/sendi_oven.xml"),
    --------센디오븐
    Asset( "IMAGE", "images/inventoryimages/sendiobject_hut.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendiobject_hut.xml"),
    --------센디의 오두막
    Asset( "IMAGE", "images/inventoryimages/sendiobject_warehouse.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendiobject_warehouse.xml"),
    --------센디의 창고
    --Asset("ANIM", "anim/csmana.zip"),
    Asset("ANIM", "anim/mana_sendi.zip"),
    Asset("ANIM", "anim/mana_anan.zip"),
    Asset("ANIM", "anim/mana_tees.zip"),
    Asset("ANIM", "anim/sendi_ui_chest_4x4.zip"),
    --------------------- ui
    Asset( "IMAGE", "images/inventoryimages/aos_seed.tex"), 
    Asset( "ATLAS", "images/inventoryimages/aos_seed.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/aos_seed_purple.tex"), 
    Asset( "ATLAS", "images/inventoryimages/aos_seed_purple.xml"),
        
    Asset( "IMAGE", "images/inventoryimages/aos_seed_black.tex"), 
    Asset( "ATLAS", "images/inventoryimages/aos_seed_black.xml"),
    --------------------- 제작시드
    Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_black.tex"), 
    Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_black.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_orange.tex"), 
    Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_orange.xml"),
        
    Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_red.tex"), 
    Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_red.xml"),
        
    Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_sky.tex"), 
    Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_sky.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_white.tex"), 
    Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_white.xml"),
        
    Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_autumn.tex"), 
    Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_autumn.xml"),
        
    Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_green.tex"), 
    Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_green.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_yellow.tex"), 
    Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_yellow.xml"),
                
    Asset( "IMAGE", "images/inventoryimages/aos_seed_middle.tex"), 
    Asset( "ATLAS", "images/inventoryimages/aos_seed_middle.xml"),
    --------------------- 드롭시드
    Asset( "IMAGE", "images/inventoryimages/sendi_food_cocoapowder.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_cocoapowder.xml"),
        
    Asset( "IMAGE", "images/inventoryimages/sendi_food_cocoa_cup.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_cocoa_cup.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_cocoa.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_cocoa.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_wolfsteak.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_wolfsteak.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_wolfsteak_cooked.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_wolfsteak_cooked.xml"),    

    --2차 추가 음식들 
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_ricewheat.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_ricewheat.xml"),
        
    Asset( "IMAGE", "images/inventoryimages/sendi_food_bread.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_bread.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_salad_banana.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_salad_banana.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_juice_light_berry.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_juice_light_berry.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_pie_light_berry.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_pie_light_berry.xml"),    
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_pie_light_berry_cooked.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_pie_light_berry_cooked.xml"),
        
    Asset( "IMAGE", "images/inventoryimages/sendi_food_cake_banana.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_cake_banana.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_cake_banana_cooked.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_cake_banana_cooked.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_pudding_light_berrybanana.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_pudding_light_berrybanana.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_pudding_light_berrybanana_cooked.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_pudding_light_berrybanana_cooked.xml"),    
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_rice_eel.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_rice_eel.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_rice_eel_cooked.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_rice_eel_cooked.xml"),    
    --3차 전용음식
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_bread_sausage.tex"), --소세지팡
    Asset( "ATLAS", "images/inventoryimages/sendi_food_bread_sausage.xml"),
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_bread_muffin.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_bread_muffin.xml"),--머핀
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_bread_muffin_cooked.tex"), --완성머핀
    Asset( "ATLAS", "images/inventoryimages/sendi_food_bread_muffin_cooked.xml"),    
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_rice_tuna.tex"), --참치밥 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_rice_tuna.xml"),    
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_rice_tuna_cooked.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_rice_tuna_cooked.xml"),--참치비빔
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_bread_but.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_bread_but.xml"),    --식빵
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_bread_but_cooked.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_bread_but_cooked.xml"),        --식빵완성
    
    --4차 전용음식
    Asset( "IMAGE", "images/inventoryimages/sendi_food_milk_strong.tex"), --튼튼밀크
    Asset( "ATLAS", "images/inventoryimages/sendi_food_milk_strong.xml"),        
    --5차 전용음식
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_chicken.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_chicken.xml"),--치킨
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_chicken_cooked.tex"), --치킨완성
    Asset( "ATLAS", "images/inventoryimages/sendi_food_chicken_cooked.xml"),    
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_pie_berry.tex"), --파이 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_pie_berry.xml"),    
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_pie_berry_cooked.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_pie_berry_cooked.xml"),--파이완성
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_dumpling.tex"), 
    Asset( "ATLAS", "images/inventoryimages/sendi_food_dumpling.xml"),    --만두
    
    Asset( "IMAGE", "images/inventoryimages/sendi_food_dumpling_cooked.tex"), --만두완성
    Asset( "ATLAS", "images/inventoryimages/sendi_food_dumpling_cooked.xml"),    
    
    --------------------- 전용 음식    
    
    
    Asset( "ATLAS", "images/inventoryimages/sendi_icon_iced.xml"),    
    
    --------------------- 아이콘
    
---[[ 아난
    Asset( "IMAGE", "images/saveslot_portraits/anan.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/anan.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/anan.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/anan.xml" ),
    
    Asset( "IMAGE", "images/selectscreen_portraits/anan_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/anan_silho.xml" ),

    Asset( "IMAGE", "bigportraits/anan.tex" ),
    Asset( "ATLAS", "bigportraits/anan.xml" ),
    
    Asset( "IMAGE", "images/map_icons/anan.tex" ),
    Asset( "ATLAS", "images/map_icons/anan.xml" ),
    
    Asset( "IMAGE", "images/avatars/avatar_anan.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_anan.xml" ),
    
    Asset( "IMAGE", "images/avatars/avatar_ghost_anan.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_anan.xml" ),
    
    Asset( "IMAGE", "images/avatars/self_inspect_anan.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_anan.xml" ),
    
    Asset( "IMAGE", "images/names_anan.tex" ),
    Asset( "ATLAS", "images/names_anan.xml" ),
    
    Asset( "IMAGE", "images/names_gold_anan.tex" ),
    Asset( "ATLAS", "images/names_gold_anan.xml" ),
    
    Asset( "IMAGE", "bigportraits/anan_none.tex" ),
    Asset( "ATLAS", "bigportraits/anan_none.xml" ),
    ---
    Asset( "IMAGE", "images/inventoryimages/anantab.tex"),
    Asset( "ATLAS", "images/inventoryimages/anantab.xml"),
    --
    Asset( "IMAGE", "images/inventoryimages/anan_dagger.tex"),
    Asset( "ATLAS", "images/inventoryimages/anan_dagger.xml"),
    --부러진 아난 대거 anan_dagger
    Asset( "IMAGE", "images/inventoryimages/anan_dagger_hard.tex"),
    Asset( "ATLAS", "images/inventoryimages/anan_dagger_hard.xml"),    
    --아난대거
    Asset( "IMAGE", "images/inventoryimages/anan_dagger_wolf.tex"),
    Asset( "ATLAS", "images/inventoryimages/anan_dagger_wolf.xml"),
    --북쪽늑대 대거 anan_dagger_wolf
--]]
---[[ 티스
    Asset( "IMAGE", "images/saveslot_portraits/tees.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/tees.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/tees.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/tees.xml" ),
    
    Asset( "IMAGE", "images/selectscreen_portraits/tees_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/tees_silho.xml" ),

    Asset( "IMAGE", "bigportraits/tees.tex" ),
    Asset( "ATLAS", "bigportraits/tees.xml" ),
    
    Asset( "IMAGE", "images/map_icons/tees.tex" ),
    Asset( "ATLAS", "images/map_icons/tees.xml" ),
    
    Asset( "IMAGE", "images/avatars/avatar_tees.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_tees.xml" ),
    
    Asset( "IMAGE", "images/avatars/avatar_ghost_tees.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_tees.xml" ),
    
    Asset( "IMAGE", "images/avatars/self_inspect_tees.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_tees.xml" ),
    
    Asset( "IMAGE", "images/names_tees.tex" ),
    Asset( "ATLAS", "images/names_tees.xml" ),
    
    Asset( "IMAGE", "images/names_gold_tees.tex" ),
    Asset( "ATLAS", "images/names_gold_tees.xml" ),
    
    Asset( "IMAGE", "bigportraits/tees_none.tex" ),
    Asset( "ATLAS", "bigportraits/tees_none.xml" ),
    
    
    ---장비추가


--]]
}
AddMinimapAtlas("images/map_icons/sendi.xml")
AddMinimapAtlas("images/map_icons/anan.xml")
AddMinimapAtlas("images/map_icons/tees.xml")
---------------- 라이브러리, 함수 오버라이드
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Language =  GetModConfigData("language")
--
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local resolvefilepath = GLOBAL.resolvefilepath
local Recipe = GLOBAL.Recipe
require "util"

local containers = require("containers")
local IsServer = GLOBAL.TheNet:GetIsServer()
--
GLOBAL.SendiForceOverrideSkin = GetModConfigData("skinoverride")

modimport "scripts/tunings_sendi.lua" -- 튜닝 파일 로드

GLOBAL.SENDI_LANGUAGE_SUFFIX = "_en" -- 언어 설정관련
if Language == "AUTO" then
    local KnownModIndex = GLOBAL.KnownModIndex
    for _, moddir in ipairs(KnownModIndex:GetModsToLoad()) do
        local modname = KnownModIndex:GetModInfo(moddir).name
        if modname == "한글 모드 서버 버전" or modname == "한글 모드 클라이언트 버전" then 
            GLOBAL.SENDI_LANGUAGE_SUFFIX = "" -- 한국어
--        elseif modname == "Chinese Language Pack" or modname == "Chinese Plus" or modname == "[DST]雪儿的外置汉化模组" or language == "中文语言包"then
--            GLOBAL.SENDI_LANGUAGE_SUFFIX = "_ch"
--        elseif modname == "Russian Language Pack" or modname == "Russification Pack for DST" or modname == "Russian For Mods (Client)" then
--            GLOBAL.SENDI_LANGUAGE_SUFFIX = "_ru"
        end 
    end 
else
    GLOBAL.SENDI_LANGUAGE_SUFFIX = Language
end
STRINGS.CHARACTERS.SENDI = require("speech_sendi"..GLOBAL.SENDI_LANGUAGE_SUFFIX ) -- 대사 파일 로드
-- modimport("scripts/strings_sendi"..GLOBAL.SENDI_LANGUAGE_SUFFIX..".lua") -- 언어 파일 로드
modimport("scripts/strings_sendi.lua") -- string 파일 로드
STRINGS.CHARACTERS.ANAN = require "speech_anan"
STRINGS.CHARACTERS.TEES = require "speech_tees"

local Cookable = require "components/cookable"  -- sendi_oven 관련
function Cookable:GetProduct()
    local prefab = nil 
    if self.product ~= nil then 
        prefab = self.product
        if type(self.product) == "function" then
            prefab = self.product(self.inst)
        end
    end 
    return prefab
end 

--티스 무시
local Combat = require "components/combat"
local _TryRetarget = Combat.TryRetarget
function Combat.TryRetarget(self) 
    if self.targetfn ~= nil then
        local newtarget = self.targetfn(self.inst)
        if newtarget ~= nil and not (self.inst:HasTag("shadowcreature") or self.inst:HasTag("shadow")) and newtarget:HasTag("sneakysnake") then return end
    end

    return _TryRetarget(self)
end

--아난 디버프
local _GetAttacked = Combat.GetAttacked
function Combat.GetAttacked(self, attacker, damage, ...)
	if self.inst:HasTag("frostbitten") then
		damage = damage * TUNING.AOS_GENERAL.DEBUFF_FROSTBITE_BREAK
	end

	return _GetAttacked(self, attacker, damage, ...)
end

-- 미트무시
local function is_meat(item)
    return item.components.edible ~= nil  and item.components.edible.foodtype == GLOBAL.FOODTYPE.MEAT 
end

local function IgnoreMeatFn(inst)
    return GLOBAL.FindEntity(inst, TUNING.PIG_TARGET_DIST,  
        function(guy)
            return inst.components.combat:CanTarget(guy)
                and (
                    guy:HasTag("monster") or (
                        not guy:HasTag("ignoreMeat") and    --우선순위를 몬스터 상태인지를 판단 후, 고기 라벨이 무시되는 여부를 판단해, 공격하지 않는 상태로 만듭니다.
                        guy.components.inventory ~= nil and 
                        guy:IsNear(inst, TUNING.BUNNYMAN_SEE_MEAT_DIST) and
                        guy.components.inventory:FindItem(is_meat) ~= nil
                    )
                )
        end,
        { "_combat", "_health" },
        nil,
        { "monster", "player" })
end

local function IgnoreMeat(combatcmp, target)
    local strtbl =
        target ~= nil and
        not target:HasTag("ignoreMeat") and --- 고기라벨을 무시하고 공격이 없는지를 결정하는 조건을 추가합니다.
        target.components.inventory ~= nil and
        target.components.inventory:FindItem(is_meat) ~= nil and
        "RABBIT_MEAT_BATTLECRY" or
        "RABBIT_BATTLECRY"
    return strtbl, math.random(#STRINGS[strtbl])
end
-- 고기 무시 ]]

local function ForceRecipeUpdate(inst) -- run this on client because HUD doesn't exist in server.
    if inst._parent.HUD == nil then return end 
    inst._parent.HUD.controls.crafttabs:UpdateRecipes()
end

local function RegisterModNetListeners(inst)
    if GLOBAL.TheWorld and GLOBAL.TheWorld.ismastersim then
        inst._parent = inst.entity:GetParent()
    end
    
    inst:ListenForEvent("sendibuilderupdatedirty", ForceRecipeUpdate) -- Patch both client and server, because it should be synced.
end

AddPrefabPostInit("player_classified", function(inst)
    inst.forcerecipeupdate = GLOBAL.net_bool(inst.GUID, "sendibuilderupdate", "sendibuilderupdatedirty")
    inst.forcerecipeupdate:set(false)
    
    inst:DoTaskInTime(2 * GLOBAL.FRAMES, RegisterModNetListeners) 
end)


local function SayInfo(inst)--센디레벨업
    local str = STRINGS.LEVEL.." : "..(inst.components.aoslevel.level + 1).."\n"..STRINGS.EXP.." : "..inst.components.aoslevel.exp.." / "..inst.components.aoslevel:GetMaxExp()
    
    inst.components.talker:Say(str)
end
AddModRPCHandler("sendi", "status", SayInfo)

--드롭 exp
function TESTFUNCAAA(inst)
   print (inst.name)
end

local mammalia = {"pigman", "bunnyman", "deerclops", "bearger", "klaus", "krampus", "minotaur", "deer_red", "deer_blue", "hound", "firehound", "icehound", "wage", "koalefant_winter", "koalefant_summer", "walrus", "beefalo", "monkey", "lightninggoat", "spat", "rabbit", "catcoon", "bat", "deer"} -- 포유류인 경우 리스트

local function AddChanceLoot(inst, loots)
    if inst.components.health ~= nil and inst.components.lootdropper ~= nil then
        for i = 1, #loots, 2 do
            inst.components.lootdropper:AddChanceLoot(loots[i], loots[i+1])
        end

        if table.contains(mammalia, inst.prefab) then
            for i = 0, 2 do
                if inst.components.health.maxhealth >= 1000 * i then
                    inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
                    inst.components.lootdropper:AddChanceLoot("bat", 0.3) --박쥐를 스폰시킨다.
                end
            end
        end
    end
end

local ExcludeList = {}
local function AddPrefabPostInitAndExclude(prefab, fn)
    AddPrefabPostInit(prefab, function(inst)
        if not GLOBAL.TheWorld.ismastersim then return end
        fn(inst)
    end)
    table.insert(ExcludeList, prefab)
end    

--보스 시드 드랍
AddPrefabPostInitAndExclude("deerclops",  --[[대상 몬스터 스폰명]] function(inst)
   AddChanceLoot(inst, {"aos_seed_boss_white", 0.5, "aos_seed_boss_sky", 1}) -- (아이템 스폰명), (확률) 순으로 적으면 됨
end)
AddPrefabPostInitAndExclude("dragonfly", function(inst)--드래곤파리
   AddChanceLoot(inst, {"aos_seed_boss_red", 1, "aos_seed_boss_white", 0.5})
end)
AddPrefabPostInitAndExclude("bearger", function(inst)--베어거
   AddChanceLoot(inst, {"aos_seed_boss_autumn", 1, "aos_seed_boss_white", 0.5})
end)
AddPrefabPostInitAndExclude("moose", function(inst)--무스구스
   AddChanceLoot(inst, {"aos_seed_boss_green", 1, "aos_seed_boss_white", 0.5})
end)
AddPrefabPostInitAndExclude("moose", function(inst)--무스구스
   AddChanceLoot(inst, {"aos_seed_boss_green", 1, "aos_seed_boss_white", 0.5})
end)
AddPrefabPostInitAndExclude("antlion", function(inst)--개미사자
   AddChanceLoot(inst, {"aos_seed_boss_orange", 1, "aos_seed_boss_white", 0.5})
end)
AddPrefabPostInitAndExclude("beequeen", function(inst)--비-퀸
   AddChanceLoot(inst, {"aos_seed_boss_yellow", 1, "aos_seed_boss_white", 0.5})
end)
AddPrefabPostInitAndExclude("stalker_atrium", function(inst)--퓨얼위버
   AddChanceLoot(inst, {"aos_seed_boss_black", 2, "aos_seed_boss_white", 0.5})
end)
AddPrefabPostInitAndExclude("toadstool", function(inst)--토드스툴 
   AddChanceLoot(inst, {"aos_seed_boss_black", 1, "aos_seed_boss_white", 0.5})
end)
AddPrefabPostInitAndExclude("toadstool_dark", function(inst)--비참한 토드스툴  
   AddChanceLoot(inst, {"aos_seed_boss_black", 1, "aos_seed_boss_white", 0.5})
end)
AddPrefabPostInitAndExclude("klaus", function(inst)--비참한 토드스툴  
   AddChanceLoot(inst, {"aos_seed_boss_white", 1, "aos_seed_boss_white", 0.5})
end)
AddPrefabPostInitAndExclude("klaus", function(inst)--클라우스
   AddChanceLoot(inst, {"aos_seed_boss_white", 1, "aos_seed_boss_white", 0.5})
end)
--중보스 시드 드랍 
AddPrefabPostInitAndExclude("minotaur", function(inst)--미노타우르스
   AddChanceLoot(inst, {"aos_seed_middle", 1, "aos_seed_middle", 0.5})
end)
AddPrefabPostInitAndExclude("spiderqueen", function(inst)--거미여왕
   AddChanceLoot(inst, {"aos_seed_middle", 1, "aos_seed_middle", 0.5})
end)
AddPrefabPostInitAndExclude("leif", function(inst)--트리가드
   AddChanceLoot(inst, {"aos_seed_middle", 1, "aos_seed_middle", 0.5})
end)
AddPrefabPostInitAndExclude("deer_red", function(inst)--사슴보석
   AddChanceLoot(inst, {"aos_seed_middle", 1, "aos_seed_middle", 0.5})
end)
AddPrefabPostInitAndExclude("deer_blue", function(inst)--사슴보석2
   AddChanceLoot(inst, {"aos_seed_middle", 1, "aos_seed_middle", 0.5})
end)
AddPrefabPostInitAndExclude("mossling", function(inst)--모슬링
   AddChanceLoot(inst, {"aos_seed_middle", 1})
end)
AddPrefabPostInitAndExclude("lavae", function(inst)--용암이
   AddChanceLoot(inst, {"aos_seed_middle", 0.2})
end)
--오염된 시드 드랍
AddPrefabPostInitAndExclude("batcave", function(inst)--박쥐집
   AddChanceLoot(inst, {"aos_seed_purple", 1})
end)
AddPrefabPostInitAndExclude("ghost", function(inst)--귀신
   AddChanceLoot(inst, {"aos_seed_purple", 1})
end)
AddPrefabPostInitAndExclude("spiderden", function(inst)--거미집
   AddChanceLoot(inst, {"aos_seed_purple", 1})
end)
AddPrefabPostInitAndExclude("spiderden_2", function(inst)--거미집2
   AddChanceLoot(inst, {"aos_seed_purple", 1})
end)
AddPrefabPostInitAndExclude("pigguard", function(inst)--미친 피그맨 
   AddChanceLoot(inst, {"aos_seed_purple", 1})
end)
AddPrefabPostInitAndExclude("tentacle", function(inst)--텐타클
   AddChanceLoot(inst, {"aos_seed_purple", 1})
end)
AddPrefabPostInitAndExclude("worm", function(inst)--동굴지렁이
   AddChanceLoot(inst, {"aos_seed_purple", 1})
end)
AddPrefabPostInitAndExclude("firehound", function(inst)--레드하운드 
   AddChanceLoot(inst, {"aos_seed_purple", 1})
end)
AddPrefabPostInitAndExclude("icehound", function(inst)--블루하운드 
   AddChanceLoot(inst, {"aos_seed_purple", 1})
end)
--매우 오염된 시드 드랍
AddPrefabPostInitAndExclude("batcave", function(inst)--박쥐집 
   AddChanceLoot(inst, {"aos_seed_black", 1})
end)
AddPrefabPostInitAndExclude("houndmound", function(inst)--박쥐집 
   AddChanceLoot(inst, {"aos_seed_black", 1})
end)
AddPrefabPostInitAndExclude("slurtlehole", function(inst)--박쥐집 
   AddChanceLoot(inst, {"aos_seed_black", 1})
end)
AddPrefabPostInitAndExclude("spiderden_3", function(inst)--박쥐집 
   AddChanceLoot(inst, {"aos_seed_black", 1})
end)
AddPrefabPostInitAndExclude("terrorbeak", function(inst)--박쥐집 
   AddChanceLoot(inst, {"aos_seed_black", 1})
end)
AddPrefabPostInitAndExclude("warg", function(inst)--박쥐집 
   AddChanceLoot(inst, {"aos_seed_black", 1, "aos_seed_black", 1, "aos_seed_black", 1, "aos_seed_black", 1})
end)
AddPrefabPostInitAndExclude("koalefant_winter", function(inst)--코알라펀트 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1, "aos_seed", 1, "aos_seed", 1, "aos_seed", 1, 
    "sendi_food_milk_strong", 1, "sendi_food_milk_strong", 1})
 end)
 AddPrefabPostInitAndExclude("koalefant_summer", function(inst)--코알라펀트 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1, "aos_seed", 1, "aos_seed", 1, "aos_seed", 1, 
    "sendi_food_milk_strong", 1, "sendi_food_milk_strong", 1})
 end)
 AddPrefabPostInitAndExclude("walrus", function(inst)--맥터스크 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1, "aos_seed", 1,
    "sendi_food_milk_strong", 1})
 end)
 AddPrefabPostInitAndExclude("beefalo", function(inst)--비팔로 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1, "aos_seed", 1,
    "sendi_food_milk_strong", 1})
 end)
 AddPrefabPostInitAndExclude("monkey", function(inst)--원숭이 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1, "aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("lightninggoat", function(inst)--염소 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("rabbit", function(inst)--토끼 
    AddChanceLoot(inst, {"aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("catcoon", function(inst)--캣쿤 
    AddChanceLoot(inst, {"aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("bat", function(inst)--박쥐 
    AddChanceLoot(inst, {"aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("deer", function(inst)--눈없는 사슴  
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("deerantler", function(inst)--눈없는 사슴  2
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("hound", function(inst)--하운드
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1,})
 end)
 
 --우유있는애들
 AddPrefabPostInitAndExclude("perd", function(inst)--칠면조 
    AddChanceLoot(inst, {"aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("bishiop", function(inst)--비숍 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1, "aos_seed", 1, "aos_seed", 1, "aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("knight", function(inst)--나이트 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1, "aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("rook", function(inst)--룩 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1, "aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("spider_warrior", function(inst)--병정거미 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1, "aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("crawlinghorror", function(inst)--크로킹호러 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1, "aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("tallbird", function(inst)--톨버드 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1, "aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("teenbird", function(inst)--톨버드 2
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("smallbird", function(inst)--톨버드 3
    AddChanceLoot(inst, {"aos_seed", 1})
 end)
 AddPrefabPostInitAndExclude("penguin", function(inst)--팽귄 
    AddChanceLoot(inst, {"aos_seed", 1, "aos_seed", 1})
 end)
 
 AddPrefabPostInitAndExclude("killerbee", function(inst)--말벌 
    AddChanceLoot(inst, {"aos_seed", 0.3})
 end)
 AddPrefabPostInitAndExclude("bee", function(inst)--벌 
    AddChanceLoot(inst, {"aos_seed", 0.3})
 end)
 AddPrefabPostInitAndExclude("beeguard", function(inst)--빡친벌 
    AddChanceLoot(inst, {"aos_seed", 0.3})
 end)
 AddPrefabPostInitAndExclude("bunnyman", function(inst)
    inst.components.combat:SetRetargetFunction(3, IgnoreMeatFn)
    inst.components.combat.GetBattleCryString = IgnoreMeat
end)

AddPrefabPostInitAny(function(inst)
   if inst.components.health and inst.components.lootdropper and not table.contains(ExcludeList, inst.prefab) then
        AddChanceLoot(inst, {"aos_seed", 1, "bat", 0.3})
    end
end)
--]]

--드롭 exp
function ChangeSkin(inst)
    inst:ChangeSkin()
    --]] -- 태그제거 
end
AddModRPCHandler("sendi", "skin", ChangeSkin)
--센디스킨

STRINGS.NAMES.SENDI = "sendi"
STRINGS.NAMES.ANAN = "anan"
STRINGS.NAMES.TEES = "tees"
modimport "scripts/aosmana_init.lua"
modimport "scripts/skills_sendi.lua"
modimport "scripts/recipes_sendi.lua"

AddModCharacter("sendi", "FEMALE") --캐릭터를 마지막에 추가한다.
AddModCharacter("anan", "MALE") -- 아난
AddModCharacter("tees", "MALE") --티스