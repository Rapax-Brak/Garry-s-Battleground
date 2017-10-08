if (CLIENT) then
	local on = false

	local function toggle()
		on = !on
	end

	hook.Add("ShouldDrawLocalPlayer", "ThirdPersonDrawPlayer", function()
		if on and LocalPlayer():Alive() then
			return true
		end
	end)

	hook.Add("CalcView", "ThirdPersonView", function(ply, pos, angles)
		if (!on || !IsValid(ply) || !ply:Alive() || ply:InVehicle() || ply:GetViewEntity() != ply) then return end
			local view = {};
			local dist = 100;
			local campos = angles:Forward() * 50 + angles:Right() * -15
			local trace = util.TraceHull({
				start = pos,
				endpos = pos - campos,
				filter = { ply:GetActiveWeapon(), ply },
				mins = Vector(-4, -4, -4),
				maxs = Vector(4, 4, 4),
			})

			if (trace.Hit) then
			
				pos = trace.HitPos
			
			else pos = pos - campos
			
			end

			return {
				origin = pos,
				angles = angles,
				drawviewer = true
			}
	end)

	concommand.Add("thirdperson_toggle", toggle)
end

if (SERVER) then
	function GM:ShowSpare1()
		ply:ConCommand("thirdperson_toggle")
	end
end