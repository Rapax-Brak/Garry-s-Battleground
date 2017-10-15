local CircleOrigin = Vector(0, 0, 0)
local CircleRadius = GM.GBConfig.CircleStartingRadius
local RoundActive = false

net.Receive("SendCircleInformation", function()
	CircleOrigin, RoundActive = net.ReadVector(), net.ReadBool()
end)

if (SERVER) then

end

if (CLIENT) then
	local CircleMat = Material("models/props_combine/portalball001_sheet")
	local CircleSmooth, SafeZoneSmooth, Delay = 0, 0, 0

	function GM:PostDrawTranslucentRenderables()
		if (!RoundActive) then return end
		
		SafeZoneSmooth = Lerp(0.1 * FrameTime(), SafeZoneSmooth, CircleRadius - (CircleRadius * .25))
		render.SetColorMaterial()
		render.DrawSphere(CircleOrigin, SafeZoneSmooth, 30, 30, Color(255, 0, 0, 125))

		CircleSmooth = Lerp(0.1 * FrameTime(), CircleSmooth, CircleRadius)
		render.SetMaterial(CircleMat)
		render.DrawSphere(CircleOrigin, CircleSmooth, 30, 30, color_white)

		if (CurTime() < Delay) then return end
		CircleRadius = CircleRadius - (CircleRadius * .25)
		Delay = CurTime() + self.GBConfig.CircleDecreaseDelay
	end
end