include("shared.lua")

local models = {
	"models/player/zelpa/female_01.mdl",
	"models/player/zelpa/female_02.mdl",
	"models/player/zelpa/female_03.mdl",
	"models/player/zelpa/female_04.mdl",
	"models/player/zelpa/female_06.mdl",
	"models/player/zelpa/female_07.mdl",
	"models/player/zelpa/male_01.mdl",
	"models/player/zelpa/male_02.mdl",
	"models/player/zelpa/male_03.mdl",
	"models/player/zelpa/male_04.mdl",
	"models/player/zelpa/male_05.mdl",
	"models/player/zelpa/male_06.mdl",
	"models/player/zelpa/male_07.mdl",
	"models/player/zelpa/male_08.mdl",
	"models/player/zelpa/male_09.mdl",
	"models/player/zelpa/male_10.mdl",
	"models/player/zelpa/male_11.mdl"
}

roundStatus = false

function GM:PlayerSpawn(ply)
	ply:SetModel(table.Random(models))
	ply:SetupHands()

	if (roundStatus) then
		ply:KillSilent()
		return
	else
		GAMEMODE.Rounds:StartRound()
	end
end

function GM:GetFallDamage(ply, velocity)
	velocity = velocity - 580
	return velocity * (100 / (1024 - 580))
end

function GM:PlayerDeath(victim, inflictor, attacker)
	victim:Spectate(OBS_MODE_CHASE)
	victim:SpectateEntity(attacker)
	victim:StripWeapons()
end

function GM:PlayerDeathThink(ply)
	if (!roundActive) then
		ply:Spawn()
		return true
	else
		return false
	end
end

function GM:PlayerCanHearPlayersVoice(ply, receiver)
	if (ply:GetPos():Distance(receiver:GetPos()) > 500) then
		return false
	end

	return true
end