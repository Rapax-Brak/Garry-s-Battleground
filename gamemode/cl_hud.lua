/*
	Hide the default HUD
*/

local elements = {
	["CHudHealth"] 				= true,
	["CHudBattery"] 			= true,
	["CHudAmmo"] 					= true,
	["CHudSecondaryAmmo"] = true
}

local function HideDefaultHUD(name)
	if (elements[name]) then return false end
end
hook.Add("HUDShouldDraw", "HideDefaultHUD", HideDefaultHUD)

/*
	Create some fonts
*/

surface.CreateFont("AliveCount", {
	font = "DermaLarge",
	size = ScreenScale(21),
	weight = 600
})

surface.CreateFont("PrimaryAmmo", {
	font = "DermaLarge",
	size = ScreenScale(18),
	weight = 500
})

surface.CreateFont("PrimaryAmmoReserve", {
	font = "DermaLarge",
	size = ScreenScale(15),
	weight = 500
})

/*
	Display the time left for preperation
*/

local TimeLeft = 0
net.Receive("BroadcastTimer", function()
	TimeLeft = net.ReadInt(32)
end)

local function HUD_PrepTime()
  if (TimeLeft > 0) then
		surface.SetFont("DermaLarge")
		local text = "MATCH BEGINS IN " .. TimeLeft
		local w, h = surface.GetTextSize(text)
		local width, height = w + 20, h + 10

		draw.RoundedBox(0, (ScrW() / 2) - (width / 2), (ScrH() * 0.1) - (height / 2), width, height, Color(255, 255, 255, 150))
    draw.SimpleText(text, "DermaLarge", ScrW() / 2, ScrH() * 0.1, Color(0, 0, 0, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  end
end

/*
	Display the winner of the round
*/

local Winner = nil
net.Receive("BroadcastWinner", function()
	Winner = net.ReadString()
end)

local function HUD_DisplayWinner()
	if (Winner != nil) then
		surface.SetFont("DermaLarge")
		local text = string.upper(Winner) .. " HAS WON THE ROUND"
		local w, h = surface.GetTextSize(text)
		local width, height = w + 20, h + 10

		draw.RoundedBox(0, (ScrW() / 2) - (width / 2), (ScrH() * 0.1) - (height / 2), width, height, Color(255, 255, 255, 150))
    draw.SimpleText(text, "DermaLarge", ScrW() / 2, ScrH() * 0.1, Color(0, 0, 0, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

/*
	Display how many players are alive
*/

local function HUD_AliveCount()
  local w, h = ScrW() * 0.125, ScrH() * 0.06
  local padding = 25

  draw.RoundedBox(0, ScrW() - (w + padding), padding, h, h, Color(0, 0, 0, 200))
  draw.RoundedBox(0, ScrW() - ((w - h) + padding), padding, w - h, h, Color(255, 255, 255, 150))
  draw.SimpleText(player.GetAllAlive(), "AliveCount", ScrW() - ((w + padding) - (h / 2)), (h / 2) + padding, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  draw.SimpleText("ALIVE", "AliveCount", ScrW() - (((w - h) / 2) + padding), (h / 2) + padding, Color(0, 0, 0, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

/*
	Display Health, Armor, Ammo, etc.
*/

local BulletMat = Material("vgui/flaticons/bulletAmmo.png")
local function HUD_ClientStats()
	local client = LocalPlayer()
	if (!client:Alive()) then return end

	local w, h = ScrW() * 0.25, ScrH() * 0.04
	local padding = 25

	// Health
	local HealthColor = color_white

	if (client:Health() < 50) then
		HealthColor = Color(255, 100, 100, 255)
	else
		HealthColor = color_white
	end

	draw.RoundedBox(0, (ScrW() / 2) - (w / 2), ScrH() - (h + padding), w, h, Color(0, 0, 0, 200))
	surface.SetDrawColor(color_white)
	surface.DrawOutlinedRect((ScrW() / 2) - (w / 2), ScrH() - (h + padding), w, h)

	draw.RoundedBox(0, (ScrW() / 2) - (w / 2), ScrH() - (h + padding), w * (client:Health() / client:GetMaxHealth()), h, HealthColor)

	// Ammo
	local wep = client:GetActiveWeapon()
	if (!IsValid(wep)) then return end

	if (wep:Clip1() != -1) then
		draw.SimpleText(wep:Clip1(), "PrimaryAmmo", (ScrW() / 2) - 15, ScrH() - ((h + padding) + 5), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

		local size = ScreenScale(15)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(BulletMat)
 		surface.DrawTexturedRect((ScrW() / 2) - (size / 2), ScrH() - ((h + padding + 5) + size), size, size)
		draw.SimpleText(client:GetAmmoCount(wep:GetPrimaryAmmoType()), "PrimaryAmmoReserve", (ScrW() / 2) + 15, ScrH() - ((h + padding) + 5), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
	end
end

/*
	Display the Radar
*/

local function HUD_RadarCamera()
	local w, h = ScrW() * 0.15, ScrW() * 0.15
	local padding = 25

	local Camera = {}
	Camera.angles = Angle(90, LocalPlayer():EyeAngles().yaw, 0)
	Camera.origin = LocalPlayer():GetPos() + Vector(0, 0, 5000)
	Camera.x = ScrW() - (w + padding)
	Camera.y = ScrH() - (h + padding)
	Camera.w = w
	Camera.h = h
	Camera.drawviewmodel = false
	Camera.drawhud = false
	Camera.fov = 75
	render.RenderView(Camera)

	surface.SetDrawColor(color_white)
	surface.DrawOutlinedRect(ScrW() - (w + padding), ScrH() - (h + padding), w, h)
end

function GM:HUDPaint()
  HUD_PrepTime()
  HUD_AliveCount()
	HUD_ClientStats()
	HUD_RadarCamera()
	HUD_DisplayWinner()
end
