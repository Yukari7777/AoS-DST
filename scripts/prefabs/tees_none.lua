local assets =
{
	Asset( "ANIM", "anim/tees.zip" ),
	Asset( "ANIM", "anim/ghost_tees_build.zip" ),
}

local skins =
{
	normal_skin = "tees",
	ghost_skin = "ghost_tees_build",
}

return CreatePrefabSkin("tees_none",
{
	base_prefab = "tees",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"TEES", "CHARACTER", "BASE"},
	build_name = "tees",
	rarity = "Common",
})