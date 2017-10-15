include("shared.lua")

/*
	PlayerInitialSpawn
*/

function GM:PlayerInitialSpawn(ply)
end

/*
	PlayerSpawn
*/

function GM:PlayerSpawn(ply)
	ply:SetModel(table.Random(GAMEMODE.GBConfig.PlayerModelList))
	ply:SetupHands()

	ply:UnSpectate()
	ply:StripWeapons()
	ply:SetFrags(0)
end

/*
	GetFallDamage
*/

function GM:GetFallDamage(ply, velocity)
	velocity = velocity - 580
	return velocity * (100 / (1024 - 580))
end

/*
	PlayerDeath
*/

function GM:PlayerDeath(victim, weapon, killer)
	local wep = victim:GetActiveWeapon()
	if (IsValid(wep)) then victim:DropWeapon(wep) end

	if (!killer:IsPlayer() or killer == victim) then
		victim:Spectate(OBS_MODE_CHASE)
		victim:SpectateEntity(table.Random(player.GetAll()))
		victim:StripWeapons()
	else

		victim:Spectate(OBS_MODE_CHASE)
		victim:SpectateEntity(killer)
		victim:StripWeapons()
	end
end