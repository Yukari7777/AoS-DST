local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local Recipe = GLOBAL.Recipe
CHARACTER_INGREDIENT = GLOBAL.CHARACTER_INGREDIENT

local SENDITAB = AddRecipeTab(GLOBAL.STRINGS.SENDITABNAME, 777, "images/inventoryimages/senditab.xml", "senditab.tex", "sendi")

local ANANTAB = AddRecipeTab(GLOBAL.STRINGS.ANANTABNAME, 777, "images/inventoryimages/anantab.xml", "anantab.tex", "anan")

local TEESTAB = AddRecipeTab(GLOBAL.STRINGS.TEESTABNAME, 777, "images/inventoryimages/teestab.xml", "teestab.tex", "tees")

local AOSTAB = AddRecipeTab(GLOBAL.STRINGS.AOSTABNAME, 775, "images/inventoryimages/aostab.xml", "aostab.tex", "aosplayer")

local OVENTAB = AddRecipeTab(GLOBAL.STRINGS.OVENTABNAME, 776, "images/inventoryimages/oventab.xml", "oventab.tex", "aosplayer")
-- 전용 레시피탭을 추가.

---------------------------------------------------------------------------------------------------------------------------------
local aos_seed_boss_sky = Ingredient("aos_seed_boss_sky", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
local aos_seed_boss_sky2 = Ingredient( "aos_seed_boss_sky", 2) 
for k, v in pairs({aos_seed_boss_sky, aos_seed_boss_sky2}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_sky.xml"
end --스카이

local aos_seed_boss_red = Ingredient("aos_seed_boss_red", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
local aos_seed_boss_red2 = Ingredient( "aos_seed_boss_red", 2) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.

for k, v in pairs({aos_seed_boss_red, aos_seed_boss_red2}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_red.xml"
end--레드

local aos_seed_boss_autumn = Ingredient("aos_seed_boss_autumn", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
local aos_seed_boss_autumn2 = Ingredient( "aos_seed_boss_autumn", 2) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
for k, v in pairs({aos_seed_boss_autumn, aos_seed_boss_autumn2}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_autumn.xml"
end--가을

local aos_seed_boss_green = Ingredient("aos_seed_boss_green", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
local aos_seed_boss_green2 = Ingredient( "aos_seed_boss_green", 2) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
for k, v in pairs({aos_seed_boss_green, aos_seed_boss_green2}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_green.xml"
end--봄

local aos_seed_boss_orange = Ingredient("aos_seed_boss_orange", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
local aos_seed_boss_orange2 = Ingredient( "aos_seed_boss_orange", 2) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
for k, v in pairs({aos_seed_boss_orange, aos_seed_boss_orange2}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_orange.xml"
end--태양

local aos_seed_boss_white = Ingredient("aos_seed_boss_white", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
local aos_seed_boss_white2 = Ingredient( "aos_seed_boss_white", 2) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
for k, v in pairs({aos_seed_boss_white, aos_seed_boss_white2}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_white.xml"
end--탐욕

local aos_seed_boss_black = Ingredient("aos_seed_boss_black", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
local aos_seed_boss_black2 = Ingredient( "aos_seed_boss_black", 2) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
for k, v in pairs({aos_seed_boss_black, aos_seed_boss_black2}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_black.xml"
end--블랙

local aos_seed_boss_yellow = Ingredient("aos_seed_boss_yellow", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
local aos_seed_boss_yellow2 = Ingredient( "aos_seed_boss_yellow", 2) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
local aos_seed_boss_yellow2 = Ingredient( "aos_seed_boss_yellow", 3)
for k, v in pairs({aos_seed_boss_yellow, aos_seed_boss_yellow2, aos_seed_boss_yellow3}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_yellow.xml"
end--행복[꿀]

local aos_seed_middle12 = Ingredient("aos_seed_middle", 12) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
local aos_seed_middle6 = Ingredient("aos_seed_middle", 6) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 
local aos_seed_middle3 = Ingredient("aos_seed_middle", 3) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 

for k, v in pairs({aos_seed_middle12, aos_seed_middle6, aos_seed_middle3}) do 
    v.atlas = "images/inventoryimages/aos_seed_middle.xml"
end

--------------------------------------------- 보스시드 아틀란티스

AddRecipe("aos_seed", --크리에이시드   
{Ingredient(CHARACTER_INGREDIENT.SANITY, 20)}, 
AOSTAB, TECH.NONE, nil, nil, nil, 2, "aosplayer", "images/inventoryimages/aos_seed.xml", "aos_seed.tex")

local aos_seed = Ingredient("aos_seed", 1)
local aos_seed2 = Ingredient("aos_seed", 2)
local aos_seed10 = Ingredient("aos_seed", 10)
local aos_seed20 = Ingredient("aos_seed", 20)
local aos_seed50 = Ingredient("aos_seed", 50)
local aos_seed100 = Ingredient("aos_seed", 100)
local aos_seed150 = Ingredient("aos_seed", 150)
local aos_seed200 = Ingredient("aos_seed", 200)
local aos_seed250 = Ingredient("aos_seed", 250)

for k, v in pairs({aos_seed, aos_seed2, aos_seed10, aos_seed20, aos_seed50, aos_seed100, aos_seed150, aos_seed200, aos_seed250}) do 
    v.atlas = "images/inventoryimages/aos_seed.xml"
end

-----------------------------

AddRecipe("aos_seed_black", --크리에이시드 블랙
{Ingredient("nightmarefuel", 6)}, 
AOSTAB, TECH.NONE, nil, nil, nil, 1, "aosplayer", "images/inventoryimages/aos_seed_black.xml", "aos_seed_black.tex")

local aos_seed_black = Ingredient("aos_seed_black", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
local aos_seed_black10 = Ingredient("aos_seed_black", 10) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.

for k, v in pairs({aos_seed_black, aos_seed_black10}) do 
    v.atlas = "images/inventoryimages/aos_seed_black.xml"
end


AddRecipe("aos_seed_purple", --크리에이시드 퍼플
{Ingredient("silk", 3), Ingredient("spidergland", 3)}, 
AOSTAB, TECH.NONE, nil, nil, nil, 1, "aosplayer", "images/inventoryimages/aos_seed_purple.xml", "aos_seed_purple.tex")

local aos_seed_purple = Ingredient("aos_seed_purple", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.

for k, v in pairs({aos_seed_purple}) do 
    v.atlas = "images/inventoryimages/aos_seed_purple.xml"
end

AddRecipe("aos_seed_middle", --크리에이시드 미들제작  2
{aos_seed20}, 
AOSTAB, TECH.NONE, nil, nil, nil, 1, "aosplayer", "images/inventoryimages/aos_seed_middle.xml", "aos_seed_middle.tex")

AddRecipe("aos_seed_boss_yellow", --옐로우 보스 제작 2
{aos_seed_middle12}, 
AOSTAB, TECH.NONE, nil, nil, nil, 1, "aosplayer", "images/inventoryimages/aos_seed_boss_yellow.xml", "aos_seed_boss_yellow.tex")
----------------음식---------------

---[[
AddRecipe("sendi_food_milk_strong", --튼튼밀크
{Ingredient("ice", 3), aos_seed}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_milk_strong.xml", "sendi_food_milk_strong.tex")
--]]

local sendi_food_milk_strong = Ingredient("sendi_food_milk_strong", 1)
local sendi_food_milk_strong2 = Ingredient("sendi_food_milk_strong", 2)
for k, v in pairs({sendi_food_milk_strong, sendi_food_milk_strong2}) do 
    v.atlas = "images/inventoryimages/sendi_food_milk_strong.xml"
end --밀크


AddRecipe("sendi_food_ricewheat", --벼리밀
{Ingredient("cutgrass", 2), Ingredient("seeds_cooked", 1)}, 
OVENTAB, TECH.NONE, nil, nil, true, 2, "character", "images/inventoryimages/sendi_food_ricewheat.xml", "sendi_food_ricewheat.tex")

local sendi_food_ricewheat = Ingredient("sendi_food_ricewheat", 1)
local sendi_food_ricewheat2 = Ingredient("sendi_food_ricewheat", 2)
local sendi_food_ricewheat3 = Ingredient("sendi_food_ricewheat", 3)
local sendi_food_ricewheat4 = Ingredient("sendi_food_ricewheat", 4)
local sendi_food_ricewheat5 = Ingredient("sendi_food_ricewheat", 5)
for k, v in pairs({sendi_food_ricewheat, sendi_food_ricewheat2, sendi_food_ricewheat3, sendi_food_ricewheat4,sendi_food_ricewheat5}) do 
    v.atlas = "images/inventoryimages/sendi_food_ricewheat.xml"
end

local sendi_food_cocoapowder = Ingredient("sendi_food_cocoapowder", 1)--코코아파우더 
local sendi_food_cocoapowder2 = Ingredient("sendi_food_cocoapowder", 2)
local sendi_food_cocoapowder3 = Ingredient("sendi_food_cocoapowder", 3)
local sendi_food_cocoapowder4 = Ingredient("sendi_food_cocoapowder", 4)
for k, v in pairs({sendi_food_cocoapowder, sendi_food_cocoapowder2, sendi_food_cocoapowder3, sendi_food_cocoapowder4}) do 
    v.atlas = "images/inventoryimages/sendi_food_cocoapowder.xml"
end



AddRecipe("sendi_food_cocoa_cup", --조리 되기전의 컵
{sendi_food_cocoapowder, sendi_food_milk_strong, Ingredient("honey", 2)}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "character", "images/inventoryimages/sendi_food_cocoa_cup.xml", "sendi_food_cocoa_cup.tex")

local sendi_food_cocoa_cup = Ingredient("sendi_food_cocoa_cup", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendi_food_cocoa_cup.atlas = "images/inventoryimages/sendi_food_cocoa_cup.xml"

AddRecipe("sendi_food_wolfsteak", --스테이크
{sendi_food_cocoapowder2, Ingredient("cookedmonstermeat", 2), sendi_food_milk_strong}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_wolfsteak.xml", "sendi_food_wolfsteak.tex")

local sendi_food_wolfsteak = Ingredient("sendi_food_wolfsteak", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendi_food_wolfsteak.atlas = "images/inventoryimages/sendi_food_wolfsteak.xml"

--2차 추가 음식들



AddRecipe("sendi_food_bread", --빵
{sendi_food_ricewheat3, sendi_food_milk_strong}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "character", "images/inventoryimages/sendi_food_bread.xml", "sendi_food_bread.tex")

local sendi_food_bread = Ingredient("sendi_food_bread", 1)
local sendi_food_bread2 = Ingredient("sendi_food_bread", 2)

for k, v in pairs({sendi_food_bread, sendi_food_bread2}) do 
    v.atlas = "images/inventoryimages/sendi_food_bread.xml"
end
AddRecipe("sendi_food_pudding_light_berrybanana", --바나나 푸딩
{Ingredient("bird_egg", 2), sendi_food_milk_strong2, Ingredient("honey", 1)}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_pudding_light_berrybanana.xml", "sendi_food_pudding_light_berrybanana.tex")
---3차 추가음식
AddRecipe("sendi_food_bread_sausage", --소세지빵
{sendi_food_bread, Ingredient("cookedmeat", 2)}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_bread_sausage.xml", "sendi_food_bread_sausage.tex")

AddRecipe("sendi_food_bread_muffin", --머핀반죽
{sendi_food_ricewheat3, Ingredient("butterflywings", 2), sendi_food_milk_strong}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_bread_muffin.xml", "sendi_food_bread_muffin.tex")

AddRecipe("sendi_food_bread_but", --식빵반죽
{sendi_food_bread2, Ingredient("seeds_cooked", 3), Ingredient("acorn", 2)}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_bread_but.xml", "sendi_food_bread_but.tex")

AddRecipe("sendi_food_rice_tuna", --참치밥
{sendi_food_ricewheat3, Ingredient("fishmeat_small", 2), Ingredient("carrot", 2)}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_rice_tuna.xml", "sendi_food_rice_tuna.tex")
--5차음식 
AddRecipe("sendi_food_chicken", --치킨
{sendi_food_ricewheat5, sendi_food_milk_strong, Ingredient("drumstick_cooked", 4)}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_chicken.xml", "sendi_food_chicken.tex")

AddRecipe("sendi_food_pie_berry", --파이
{sendi_food_ricewheat5, sendi_food_milk_strong, Ingredient("berries_cooked", 2)}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_pie_berry.xml", "sendi_food_pie_berry.tex")

AddRecipe("sendi_food_dumpling", --만두 
{sendi_food_ricewheat3, Ingredient("cookedsmallmeat", 2), Ingredient("carrot", 2)}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_dumpling.xml", "sendi_food_dumpling.tex")
--6차음식

AddRecipe("sendi_food_tanghuru_berry", --베리탕후루 
{Ingredient("stinger", 1), Ingredient("honey", 2), Ingredient("berries_cooked", 2)}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_tanghuru_berry.xml", "sendi_food_tanghuru_berry.tex")

AddRecipe("sendi_food_stew_beep", --비프스튜
{sendi_food_milk_strong, Ingredient("cookedmeat", 2), Ingredient("carrot_cooked", 2)}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_stew_beep.xml", "sendi_food_stew_beep.tex")

--지하음식
AddRecipe("sendi_food_salad_banana", --이끼바나나 샐러드
{Ingredient("cutlichen", 2), Ingredient("cave_banana", 2), sendi_food_cocoapowder2}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "character", "images/inventoryimages/sendi_food_salad_banana.xml", "sendi_food_salad_banana.tex")

AddRecipe("sendi_food_juice_light_berry", --빛나는 베리 주스
{sendi_food_cocoapowder2, Ingredient("wormlight_lesser", 2),sendi_food_milk_strong}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "character", "images/inventoryimages/sendi_food_juice_light_berry.xml", "sendi_food_juice_light_berry.tex")

AddRecipe("sendi_food_pie_light_berry", --푸른파이반죽
{Ingredient("wormlight_lesser", 2), sendi_food_ricewheat5, sendi_food_milk_strong}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_pie_light_berry.xml", "sendi_food_pie_light_berry.tex")

AddRecipe("sendi_food_cake_banana", --달콤한 바나나 반죽
{sendi_food_ricewheat3, Ingredient("cave_banana", 1), sendi_food_cocoapowder2}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_cake_banana.xml", "sendi_food_cake_banana.tex")

AddRecipe("sendi_food_rice_eel", --장어와 밥
{sendi_food_ricewheat3, Ingredient("eel_cooked", 2), sendi_food_cocoapowder2}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_rice_eel.xml", "sendi_food_rice_eel.tex")


-- 엽기적인 음식
AddRecipe("sendi_food_maratang_frog", --개구리 접시 
{sendi_food_milk_strong2, Ingredient("froglegs_cooked", 4), sendi_food_cocoapowder2}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_maratang_frog.xml", "sendi_food_maratang_frog.tex")

AddRecipe("sendi_food_maratang_bat", --박쥐 접시 
{sendi_food_milk_strong2 , Ingredient("batwing_cooked", 4), sendi_food_cocoapowder2}, 
OVENTAB, TECH.NONE, nil, nil, true, 1, "sendichef", "images/inventoryimages/sendi_food_maratang_bat.xml", "sendi_food_maratang_bat.tex")



-----------------음식---------------
AddRecipe("sendicampfire",--모닥불
{aos_seed2}, 
AOSTAB, TECH.NONE, "campfire_placer", nil, nil, nil, "sendi", nil, nil, nil, "campfire") 



AddRecipe("senditorch", --횃불 
{aos_seed}, --twigs
AOSTAB, TECH.NONE, nil, nil, nil, nil, "sendi", nil, nil, nil, "torch" ) 

AddRecipe("charcoal", --목탄 
{Ingredient("log", 2), aos_seed},  --체력 HEALTH/ 정신 SANITY / log   
AOSTAB, TECH.NONE, nil, nil, nil, nil, "sendi" ) 

AddRecipe("twigs", --나무가지 
{Ingredient("log", 1), Ingredient(CHARACTER_INGREDIENT.SANITY, 10)},  --체력 HEALTH/ 정신 SANITY / 허기
AOSTAB, TECH.NONE, nil, nil, nil, 2, "sendi" ) 

AddRecipe("sendi_book_tentacles", --촉수이야기 
{Ingredient("papyrus", 2), Ingredient("tentaclespots", 1)},  
AOSTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", nil, nil, nil, "book_tentacles")
----





AddRecipe("sendipack", 
{Ingredient("gears", 2), Ingredient("bedroll_furry", 2), aos_seed_boss_autumn}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendipack.xml", "sendipack.tex")
-- "sendi" 전용태그(이 태그가 있는사람만 제작가능)
-- 이름, 재료, 탭, 기술 수준, 설치자, min_spacing, nounlock, 제작 시 주는 갯수, [ 재료란 builder_tag, atlas, image, testfn, product]
-----------------------------------센디 백팩
AddRecipe("sendisedmask", 
{Ingredient("footballhat", 1), Ingredient("marble", 20), aos_seed_boss_white}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendisedmask.xml", "sendisedmask.tex")   

local sendisedmask = Ingredient( "sendisedmask", 1) 
sendisedmask.atlas ="images/inventoryimages/sendisedmask.xml"
---------------------------------- 센디 마스크
AddRecipe("sendi_hat_crown", 
{aos_seed_boss_green2, Ingredient("pigskin", 40), Ingredient("beefalohat", 1)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_hat_crown.xml", "sendi_hat_crown.tex")   

local MonarchCrown = Ingredient( "sendi_hat_crown", 1) 
MonarchCrown.atlas ="images/inventoryimages/sendi_hat_crown.xml"
---------------------------------- 프랜드 헬멧
AddRecipe("sendi_hat_spider", 
{Ingredient("spidereggsack", 3),Ingredient("spiderhat", 2), aos_seed_boss_yellow2}, --hivehat[여왕벌]
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_hat_spider.xml", "sendi_hat_spider.tex")   

local SendiHatspider = Ingredient( "sendi_hat_spider", 1) 
SendiHatspider.atlas ="images/inventoryimages/sendi_hat_spider.xml"

---------------------------------- 스파이더 헬멧

AddRecipe("sendi_hat_goggles", 
{MonarchCrown, SendiHatspider, aos_seed_boss_white2}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_hat_goggles.xml", "sendi_hat_goggles.tex")   

local frandgoggles = Ingredient( "sendi_hat_goggles", 1) 
frandgoggles.atlas ="images/inventoryimages/sendi_hat_goggles.xml"

---------------------------------- 프랜드 고글



AddRecipe("sendi_armor_01", 
{Ingredient("silk", 6), Ingredient("rabbit", 1), aos_seed50}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_armor_01.xml", "sendi_armor_01.tex")

local sendiarmor = Ingredient( "sendi_armor_01", 1) 
sendiarmor.atlas ="images/inventoryimages/sendi_armor_01.xml"
---------------------------------- 머플러 아머
AddRecipe("sendi_armor_02", 
{sendiarmor, Ingredient("greengem", 6), aos_seed_boss_sky2}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_armor_02.xml", "sendi_armor_02.tex")

local lifearmor = Ingredient( "sendi_armor_02", 1) 
lifearmor.atlas ="images/inventoryimages/sendi_armor_02.xml"
---------------------------------- 라이프아머


-- AddRecipe("sendi_amulet", 
-- {Ingredient("silk", 6), Ingredient("rabbit", 1), Ingredient("heatrock", 1)}, 
-- SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_amulet.xml", "sendi_amulet.tex")

-- local sendiarmor = Ingredient( "sendi_amulet", 1) 
-- sendiarmor.atlas ="images/inventoryimages/sendi_amulet.xml"
---------------------------------- 아뮬렛 sendi_amulet    



AddRecipe("sendi_rapier_wood", 
{Ingredient("spear", 1), Ingredient("log", 20), Ingredient("rope", 2)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_rapier_wood.xml", "sendi_rapier_wood.tex")

local sendirapierwood = Ingredient( "sendi_rapier_wood", 1)  
sendirapierwood.atlas = "images/inventoryimages/sendi_rapier_wood.xml"
---------------------------------- 목재 레이피어 ㄹ
AddRecipe("sendi_rapier", 
{sendirapierwood, Ingredient("tentaclespike", 1), aos_seed_middle6}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_rapier.xml", "sendi_rapier.tex")

local sendirapier = Ingredient( "sendi_rapier", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendirapier.atlas = "images/inventoryimages/sendi_rapier.xml"
----------------------------------  센디레이피어 
AddRecipe("sendi_rapier_ignia", 
{sendirapier, aos_seed_boss_red2, Ingredient("dragon_scales", 2)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_rapier_ignia.xml", "sendi_rapier_ignia.tex")

local igniarapier = Ingredient( "sendi_rapier_ignia", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
igniarapier.atlas = "images/inventoryimages/sendi_rapier_ignia.xml"
---------------------------------- 이그니아 레이피어






AddRecipe("sendi_oven",
{Ingredient("boards", 5), Ingredient("cutstone", 5), aos_seed20}, 
AOSTAB, TECH.SCIENCE_TWO, "sendi_oven_placer", nil, nil, nil, "aosplayer", "images/inventoryimages/sendi_oven.xml", "sendi_oven.tex" ) 
-- local sendi_oven = Ingredient( "sendi_oven", 1), Ingredient( "aos_seed", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
-- sendi_oven.atlas = "images/inventoryimages/sendi_oven.xml"
---------------------------------- 센디 오븐

AddRecipe("sendiobject_hut", 
{Ingredient("turf_meteor", 10), Ingredient("hammer", 1), aos_seed_boss_green}, 
AOSTAB, TECH.SCIENCE_TWO, "sendiobject_hut_placer", nil, nil, nil, "aosplayer", "images/inventoryimages/sendiobject_hut.xml", "sendiobject_hut.tex" ) 
---------------------------------- 센디 오두막
AddRecipe("sendiobject_warehouse", 
{Ingredient("wall_stone_item", 18), Ingredient("hammer", 1), aos_seed_boss_autumn}, 
AOSTAB, TECH.SCIENCE_TWO, "sendiobject_warehouse_placer", nil, nil, nil, "aosplayer", "images/inventoryimages/sendiobject_warehouse.xml", "sendiobject_warehouse.tex" ) 
---------------------------------- 센디 창고
AddRecipe("sendiobject_icebox", 
{Ingredient("gears", 1), Ingredient("cutstone", 2), aos_seed_middle}, 
AOSTAB, TECH.SCIENCE_TWO, "sendiobject_icebox_placer", nil, nil, nil, "aosplayer", "images/inventoryimages/sendiobject_icebox.xml", "sendiobject_icebox.tex" ) 

AddRecipe("sendiobject_saltbox", 
{Ingredient("saltrock", 15), Ingredient("bluegem", 1), aos_seed_middle3}, 
AOSTAB, TECH.SCIENCE_TWO, "sendiobject_saltbox_placer", nil, nil, nil, "aosplayer", "images/inventoryimages/sendiobject_saltbox.xml", "sendiobject_saltbox.tex" ) 
---------------------------------- 냉장고들
--일반 소모품

---[[ 아난
AddRecipe("anan_dagger",--아난대거1
{ Ingredient("houndstooth", 20), Ingredient("rope", 2), Ingredient("bluegem", 5) },
ANANTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "anancraft", "images/inventoryimages/anan_dagger.xml", "anan_dagger.tex")    
AddRecipe("anan_dagger_hard", --아난대거2
{ Ingredient("anan_dagger", 1, "images/inventoryimages/anan_dagger.xml"), Ingredient("houndstooth", 20), Ingredient("aos_seed_middle", 6, "images/inventoryimages/aos_seed_middle.xml") }, 
ANANTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "anancraft", "images/inventoryimages/anan_dagger_hard.xml", "anan_dagger_hard.tex")    
AddRecipe("anan_dagger_wolf", --아난대거3
{ Ingredient("anan_dagger_hard", 1, "images/inventoryimages/anan_dagger_hard.xml"), Ingredient("aos_seed_boss_sky", 1, "images/inventoryimages/aos_seed_boss_sky.xml"), Ingredient("bluegem", 10) }, 
ANANTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "anancraft", "images/inventoryimages/anan_dagger_wolf.xml", "anan_dagger_wolf.tex")    

AddRecipe("anan_meat_dried", --육포
{ Ingredient("meat", 1), Ingredient("monstermeat", 1), Ingredient("aos_seed", 1, "images/inventoryimages/aos_seed.xml") }, --큰육포
ANANTAB, TECH.NONE, nil, nil, nil, nil, "anancraft", nil, nil, nil, "meat_dried")
AddRecipe("anan_smallmeat_dried",--작은육포
{ Ingredient("smallmeat", 2), Ingredient("aos_seed", 1, "images/inventoryimages/aos_seed.xml") },
ANANTAB, TECH.NONE, nil, nil, nil, nil, "anancraft", nil, nil, nil, "smallmeat_dried")    
AddRecipe("anan_smallmeat", --작은고기
{ Ingredient("beefalowool", 4), Ingredient("aos_seed", 1, "images/inventoryimages/aos_seed.xml") },
ANANTAB, TECH.NONE, nil, nil, nil, 2, "anancraft", nil, nil, nil, "smallmeat")    
AddRecipe("anan_meat", --큰고기
{ Ingredient("horn", 1), Ingredient("aos_seed", 1, "images/inventoryimages/aos_seed.xml") }, 
ANANTAB, TECH.NONE, nil, nil, nil, 2, "anancraft", nil, nil, nil, "meat")    

AddRecipe("anan_redgem", 
{ Ingredient("bluegem", 1), Ingredient("aos_seed_purple", 2, "images/inventoryimages/aos_seed_purple.xml") }, --레드젬
AOSTAB, TECH.NONE, nil, nil, nil, nil, "anancraft", nil, nil, nil, "redgem")    
AddRecipe("anan_bluegem", 
{ Ingredient("redgem", 1), Ingredient("aos_seed_purple", 2, "images/inventoryimages/aos_seed_purple.xml") }, 
AOSTAB, TECH.NONE, nil, nil, nil, nil, "anancraft", nil, nil, nil, "bluegem")    
AddRecipe("anan_greengem", 
{ Ingredient("bluegem", 1), Ingredient("yellowgem", 1), Ingredient("aos_seed_black", 1, "images/inventoryimages/aos_seed_black.xml") }, 
AOSTAB, TECH.NONE, nil, nil, nil, nil, "anancraft", nil, nil, nil, "greengem")    
AddRecipe("anan_purplegem", 
{ Ingredient("redgem", 1), Ingredient("bluegem", 1), Ingredient("aos_seed_black", 2, "images/inventoryimages/aos_seed_black.xml") }, 
AOSTAB, TECH.NONE, nil, nil, nil, nil, "anancraft", nil, nil, nil, "purplegem")    
--]]
---[[ 티스
AddRecipe("tees_sleepbomb", 
{Ingredient("froglegs", 2), Ingredient("monstermeat_dried", 2), Ingredient("aos_seed", 2, "images/inventoryimages/aos_seed.xml")}, 
TEESTAB, TECH.NONE, nil, nil, nil, nil, "tees", nil, nil, nil, "sleepbomb")    
AddRecipe("tees_blowdart_pipe",
{Ingredient("cutreeds", 2), Ingredient("red_cap", 2), Ingredient("aos_seed", 2, "images/inventoryimages/aos_seed.xml")}, 
TEESTAB, TECH.NONE, nil, nil, nil, nil, "tees", nil, nil, nil, "blowdart_pipe")    
AddRecipe("tees_blowdart_fire",
{Ingredient("cutreeds", 2), Ingredient("green_cap", 2), Ingredient("aos_seed", 2, "images/inventoryimages/aos_seed.xml")}, 
TEESTAB, TECH.NONE, nil, nil, nil, nil, "tees", nil, nil, nil, "blowdart_fire")
AddRecipe("tees_blowdart_sleep",
{Ingredient("cutreeds", 2), Ingredient("blue_cap", 2), Ingredient("aos_seed", 2, "images/inventoryimages/aos_seed.xml")}, 
TEESTAB, TECH.NONE, nil, nil, nil, nil, "tees", nil, nil, nil, "blowdart_sleep")

AddRecipe("tees_pickaxe",--티스낫1
{ Ingredient("moonglass", 20), Ingredient("rope", 2), Ingredient("greengem", 2) },
TEESTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "tees", "images/inventoryimages/tees_pickaxe.xml", "tees_pickaxe.tex")  
  
AddRecipe("tees_pickaxe2", --티스낫2
{ Ingredient("tees_pickaxe", 1, "images/inventoryimages/tees_pickaxe.xml"), Ingredient("goldnugget", 20), Ingredient("tentaclespike", 1), Ingredient("aos_seed_middle", 6, "images/inventoryimages/aos_seed_middle.xml") }, 
TEESTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "tees", "images/inventoryimages/tees_pickaxe2.xml", "tees_pickaxe2.tex")

AddRecipe("tees_pickaxe3", --티스낫3
{ Ingredient("tees_pickaxe2", 1, "images/inventoryimages/tees_pickaxe2.xml"), Ingredient("aos_seed_boss_yellow", 1, "images/inventoryimages/aos_seed_boss_yellow.xml"), Ingredient("purplegem", 3) }, 
TEESTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "tees", "images/inventoryimages/tees_pickaxe3.xml", "tees_pickaxe3.tex")    
--]]





---[[달제단 RECIPETABS.MOON_ALTAR
AddRecipe("aos_sendipack", 
{Ingredient("gears", 2), Ingredient("bedroll_furry", 2), aos_seed_boss_autumn}, 
AOSTAB, TECH.NONE, nil, nil, true, 1, "aosproducer", "images/inventoryimages/sendipack.xml", "sendipack.tex", nil, "sendipack")
-- "sendi" 전용태그(이 태그가 있는사람만 제작가능)
-- 이름, 재료, 탭, 기술 수준, 설치자, min_spacing, nounlock, 제작 시 주는 갯수, [ 재료란 builder_tag, atlas, image, testfn, product]
-----------------------------------센디 백팩
AddRecipe("aos_sendi_hat_crown", 
{aos_seed_boss_green2, Ingredient("pigskin", 40), Ingredient("beefalohat", 1)}, 
AOSTAB, TECH.NONE, nil, nil, true, 1, "aosproducer", "images/inventoryimages/sendi_hat_crown.xml", "sendi_hat_crown.tex", nil, "sendi_hat_crown")   
---------------------------------- 프랜드 헬멧
AddRecipe("aos_sendi_armor_01", 
{Ingredient("silk", 6), Ingredient("rabbit", 1), aos_seed50},
AOSTAB, TECH.NONE, nil, nil, true, 1, "aosproducer", "images/inventoryimages/sendi_armor_01.xml", "sendi_armor_01.tex", nil, "sendi_armor_01")
---------------------------------- 머플러 아머
---아난
AddRecipe("aos_anan_dagger_hard",--아난대거2
{ Ingredient("orangestaff", 1), Ingredient("aos_seed_boss_sky", 1, "images/inventoryimages/aos_seed_boss_sky.xml") },
AOSTAB, TECH.NONE, nil, nil, true, 1, "aosproducer", "images/inventoryimages/anan_dagger_hard.xml", "anan_dagger_hard.tex", nil, "anan_dagger_hard")   
-- ---티스
AddRecipe("aos_tees_pickaxe2", --티스낫2
{ Ingredient("multitool_axe_pickaxe", 1), Ingredient("aos_seed_boss_white", 1, "images/inventoryimages/aos_seed_boss_white.xml") }, 
AOSTAB, TECH.NONE, nil, nil, true, 1, "aosproducer", "images/inventoryimages/tees_pickaxe2.xml", "tees_pickaxe2.tex", nil, "tees_pickaxe2")    


--]]