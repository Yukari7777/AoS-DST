name = "[DST]Tales of Seed"
author = "doftksxk@naver.com"
version = "1.0.22" 
description = "[DST] 셋이 함깨라면 더이상 두렵지 않죠!\n\n 뿔뿔이 흩어졌던 Seed의 맴버가 한자리에 모였습니다.\n 센디, 티스, 아난과 함깨 DST 월드를 탐험하세요! \n---------------------------------------------\n센디의 레벨업 시스템이 아난, 티스에게도 도입!\n몬스터를 토벌해 시드를 수집하고,\n전용 오븐음식을 먹고 더욱 강해지세요! \n---------------------------------------------\n아난- 사냥꾼의 육포 레시피와, 강력한 데미지!\n티스- 강력한 독 데미지와, 저렴한 다트 레시피!\n센디- 강력한 불마법과,  기동기! [V / Sh+V]\n---------------------------------------------\n Version : "..version.." "
forumthread = ""
api_version = 10

dst_compatible = true

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

folder_name = folder_name or ""
if not folder_name:find("workshop-") then
    name = name.." - Test"
end

server_filter_tags = {
    "character",
}

local Keys = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "PERIOD", "SLASH", "SEMICOLON", "TILDE", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "INSERT", "DELETE", "HOME", "END", "PAGEUP", "PAGEDOWN", "MINUS", "EQUALS", "BACKSPACE", "CAPSLOCK", "SCROLLOCK", "BACKSLASH"}

local KeyOptions = {}
for i = 1, #Keys do KeyOptions[i] = { description = ""..Keys[i].."", data = "KEY_"..Keys[i] } end

configuration_options = {
    {
        name = "language",
        label = "언어(Language)",
        hover = "언어설정\nSet Language",
        options = {
            { description = "자동(Auto)", data = "AUTO" },
            { description = "한국어", data = "" },
            { description = "English", data = "_en" },
            --{ description = "中文", data = "_ch" },
            --{ description = "русский", data = "_ru" },
        },
        default = "AUTO",
    },
 
    {
        name = "skill_1",
        label = "Ignia Run Key",
        hover = "어떤 키로 [이그니아 런]을 사용할지 설정합니다.\nSet [Ignia Run] Keybind",
        options = KeyOptions,
        default = "KEY_V",
    },
    {
        name = "skin",
        label = "Skin Change Key",
        hover = "어떤 키로 스케릭터 스킨을 바꿀지 설정합니다.\nSet which key to change charater's skin.",
        options = KeyOptions,
        default = "KEY_P",
    },
    {
        name = "skinoverride",
        label = "Skin Overriding",
        hover = "스킨을 장비위에 강제로 적용할지 여부를 설정합니다.\nSet whether to force override the character's skin over equipment.",
        options = {
            { description = "Normal Skin", data = 1 },
            { description = "No Armor Skin ", data = 2 },
            { description = "Only Sendi Items Skin", data = 3 },
        },
        default = 1,
    },
    {
        name = "statuskey",
        label = "Show Status Key",
        hover = "무슨 키로 스탯을 보여줄지 설정합니다.",
        options = KeyOptions,
        default = "KEY_K",
    },
}