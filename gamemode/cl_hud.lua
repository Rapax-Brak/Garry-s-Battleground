AddCSLuaFile()

/*---------------------------------------------------------------------------
	Hide Default HUD Elements
---------------------------------------------------------------------------*/

local elements = {
	["CHudHealth"]				= true,
	["CHudBattery"]				= true,
	["CHudSuitPower"]			= true
}

local function HideDefaultHUD(name)
	if (elements[name]) then return false end
end
hook.Add("HUDShouldDraw", "HideElements", HideDefaultHUD)

function GM:HUDDrawTargetID()
end

function GM:HUDPaint()
end