TUNING.AOS_GENERAL = {
    MANA_MAX_DEFAULT = 50,        -- 마나 최대치 기본값
    MANA_CURRENT_DEFAULT = 50,    -- 마나 수치 기본값
    MANA_CURRENT_ONRESPAWN = 0, -- 부활했을 때 마나 수치

    MANA_RESTORE_FULL = 999999, -- 마나를 모두 채워줄 때의 수치
    MANA_RESTORE_FROM_FOOD_MULTIPLIER = 0.5, -- 음식 먹을 때 오르는 정신력으로부터 마나가 회복되는 비율

    ARMOR1_CONDITION = 1000, -- 센디 아머1 내구도 
    ARMOR1_EFFICIENCY = 0.50, -- 방어율
    
    ARMOR2_CONDITION = 2000, -- 센디 아머1 내구도 
    ARMOR2_EFFICIENCY = 0.70, -- 방어율
    
    ARMOR3_CONDITION = 3000, -- 센디 아머1 내구도 
    ARMOR3_EFFICIENCY = 0.80, -- 방어율

    INTERNAL_TYPE_ZERO = 0, -- ??? lol

    DEBUFF_FLAME_DAMAGE = 3, -- 불 디버프 데미지
    DEBUFF_FLAME_INTERVAL = 0.2, -- 뎀지 간격
    DEBUFF_FLAME_MAX_TIME = 3, -- 최대 디버프 시간(초)
    DEBUFF_FLAME_EXTEND_MULT = 1/3, -- 디버프 연장 효율

	DEBUFF_POISON_DAMAGE = 7,--포이즌
	DEBUFF_POISON_INTERVAL = 1,
	DEBUFF_POISON_MAX_TIME = 15,
    DEBUFF_POISON_EXTEND_MULT = 2/3,
    
    DEBUFF_VENOM_DAMAGE = 5, -- 베놈(티스 스킬1번)
	DEBUFF_VENOM_INTERVAL = 0.5,
	DEBUFF_VENOM_MAX_TIME = 10,
	DEBUFF_VENOM_EXTEND_MULT = 1,

	DEBUFF_FROSTBITE_DAMAGE = 2.5,--프로스트바이트
	DEBUFF_FROSTBITE_INTERVAL = 0.5,
	DEBUFF_FROSTBITE_MAX_TIME = 7,
	DEBUFF_FROSTBITE_EXTEND_MULT = 0.5,
	DEBUFF_FROSTBITE_FREEZE_CHANCE = 0.5,
	DEBUFF_FROSTBITE_BREAK = 1.1, -- 추가 데미지 비율

    MILK_COOLTIME = 1200, -- 우유짜기 쿨타임
    MILK_KICKCHANCE = 0.10, -- 발차기 할 확률
    MILK_MINAMOUNT = 3, -- 우유 주는 갯수
    MILK_MAXAMOUNT = 5,
}

TUNING.SENDI = {
    DEFAULT_HEALTH = 70, --체력
    DEFAULT_HUNGER = 80, --허기
    DEFAULT_SANITY = 90, --정신력
    DEFAULT_MANA = 50, -- 마나
    DEFAULT_DAMAGEMULTIPLIER = 0.5, --데미지 배수

    HEALTH_MODIFIER = 4, -- 레벨당 올라가는 체력 계수
    HUNGER_MODIFIER = 3, -- 배고픔 계수
    SANITY_MODIFIER = 4,
    MANA_MODIFIER = 5,
    DAMAGE_MODIFIER = 0.05, -- 공격력 계수

    SKILL_RAPIER_DAMAGE_1 = 20, -- 돌진할 때 데미지    
    SKILL_RAPIER_DAMAGE_2 = 55, -- 터질 때 데미지
    SKILL_RAPIER_TARGET_RADIUS = 12, -- 적 인식 범위
    SKILL_RAPIER_MANACOST = 15, -- 이그니아 런 배고픔 코스트

    SKILL_IGNIARUN_MANACOST = 2, -- 이그니아 점프 배고픔 코스트
}

TUNING.ANAN = {--아난
    DEFAULT_HEALTH = 80, --체력
    DEFAULT_HUNGER = 150, --허기
    DEFAULT_SANITY = 60, --정신력
    DEFAULT_MANA = 50, -- 마나

    DEFAULT_DAMAGEMULTIPLIER = 0.5,

    HEALTH_MODIFIER = 4, -- 레벨당 올라가는 체력 계수
    HUNGER_MODIFIER = 0.8, -- 배고픔 계수
    SANITY_MODIFIER = 2, -- 정신 올라가는거 
    MANA_MODIFIER = 5,
    DAMAGE_MODIFIER = 0.03, -- 공격력 계수

    
}

TUNING.TEES = {--티스
    DEFAULT_HEALTH = 60, --체력
    DEFAULT_HUNGER = 100, --허기
    DEFAULT_SANITY = 110, --정신력
    DEFAULT_MANA = 50, -- 마나

    DEFAULT_DAMAGEMULTIPLIER = 0.5,

    HEALTH_MODIFIER = 3.5, -- 레벨당 올라가는 체력 계수
    HUNGER_MODIFIER = 2, -- 배고픔 계수
    SANITY_MODIFIER = 5, --정신 
    MANA_MODIFIER = 5,
    DAMAGE_MODIFIER = 0.04, -- 공격력 계수

    SKILL_EVERGUARD_MANACOST = 25,
    SKILL_EVERGUARD_BACKFIRE_MULT = 0.5, -- 데미지 반사 계수

    SKILL_VIPERVITE_MANACOST = 10, --마나코스트
    SKILL_VIPERVITE_DAMAGE = 50, --데미지
    SKILL_VIPERVITE_POISON_RADIUS = 6, -- 타겟 주변에 독이 퍼지는 범위
    SKILL_VIPERBITE_TARGET_RADIUS = 12, --스킬 인식범위
    SKILL_VIPERBITE_AGGRO_RADIUS = 3, -- 가까이에서 맞은 적이 티스를 어그로로 설정하는 범위

    SKILL_VENOMSPREAD_TARGET_RADIUS = 16, -- 인식범위
    SKILL_VENOMSPREAD_DAMAGE = 100, --폭발 데미지
    SKILL_VENOMSPREAD_SPREAD_CHANCE = 0.8, -- 독이 주변으로 퍼질 확률
    SKILL_VENOMSPREAD_SPREAD_RADIUS = 6, -- 주변으로 독이 퍼지는 범위
}