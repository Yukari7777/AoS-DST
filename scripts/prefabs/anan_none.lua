local assets =
{
	Asset( "ANIM", "anim/anan.zip" ),
	Asset( "ANIM", "anim/ghost_anan_build.zip" ),
}

local skins =
{
	normal_skin = "anan",
	ghost_skin = "ghost_anan_build",
}

return CreatePrefabSkin("anan_none",
{
	base_prefab = "anan",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"ANAN", "CHARACTER", "BASE"},
	build_name = "anan",
	rarity = "Common",
})