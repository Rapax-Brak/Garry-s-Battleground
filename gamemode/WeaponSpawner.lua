SpawnPoints = {
	Vector(0,0,0),
	Vector(10,0,0),
	Vector(20,0,0)
}

Weapons = {
	"weapon_frag",
	"weapon_crowbar",
	"weapon_smg",
}

Delay = 1 // Seconds
-------------------------------
sw_cooldown = CurTime()
function SpawnWeapons()
	if sw_cooldown < CurTime() then
		for k,v in pairs(SpawnPoints) do
			local wep = ents.Create(table.Random(Weapons))
			wep:SetPos(v)
			wep:Spawn()
		end
		sw_cooldown = CurTime() + Delay
	end
end
