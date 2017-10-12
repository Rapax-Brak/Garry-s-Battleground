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

function GM:PlayerDeath(ply, weapon, attacker)
end
