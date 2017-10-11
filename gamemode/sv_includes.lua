/*
	Clientside
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_includes.lua")
AddCSLuaFile("cl_hud.lua")

/*
	Shared
*/

AddCSLuaFile("shared.lua")
AddCSLuaFile("sh_config.lua")
AddCSLuaFile("sh_deathcircle.lua")
AddCSLuaFile("sh_utilities.lua")

include("sh_config.lua")
include("sh_deathcircle.lua")
include("sh_utilities.lua")

/*
	Serverside
*/

include("sv_config.lua")
include("sv_roundsystem.lua")