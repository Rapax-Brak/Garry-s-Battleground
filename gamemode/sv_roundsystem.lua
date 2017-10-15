GBRounds = {}

/*
  Variables
*/

GBRounds.PrepTime = 5
GBRounds.TimeLeft = GBRounds.PrepTime
GBRounds.RoundActive = false

util.AddNetworkString("SendCircleInformation")
function GBRounds.Start()
	GBRounds.RoundActive = true

	local CircleOrigin = table.Random(GAMEMODE.GBConfig.OriginPoints)
	local CircleRadius = GAMEMODE.GBConfig.CircleStartingRadius
	net.Start("SendCircleInformation")
		net.WriteVector(CircleOrigin)
		net.WriteBool(GBRounds.RoundActive)
	net.Broadcast()

	for k, v in pairs(player.GetAll()) do
		v:Spawn()
	end

	print("Round started!")
end

util.AddNetworkString("BroadcastWinner")
function GBRounds.End(winner)
	GBRounds.TimeLeft = GBRounds.PrepTime

	net.Start("BroadcastWinner")
		net.WriteString(tostring(winner:Nick()))
	net.Broadcast()

	print(winner:Nick() .. " has won the game!")
	print("Round ended! Next round begins in " .. GBRounds.PrepTime .. " seconds.")
end

local t = false
function GBRounds.Think()
  if (GBRounds.RoundActive) then
    for k, v in pairs(player.GetAll()) do
    	if (!t) then
			if (player.GetAllAlive() < 2 and v:Alive()) then
				GBRounds.End(v)
				t = true
				timer.Simple(10, function()
					GBRounds.RoundActive = false
					net.Start("SendCircleInformation")
						net.WriteBool(GBRounds.RoundActive)
					net.Broadcast()
					t = false
					for _, p in pairs(player.GetAll()) do
						game.CleanUpMap(false, {})

						p:UnSpectate()
						p:Spawn()
					end
				end)
			end
		end
    end
  end
end
hook.Add("Think", "GBRounds.Think", GBRounds.Think)

util.AddNetworkString("BroadcastTimer")
function GBRounds.Logic()
	if (player.GetAllAlive() > 1 and !GBRounds.RoundActive) then
		print(GBRounds.TimeLeft)

		net.Start("BroadcastTimer")
		  net.WriteInt(GBRounds.TimeLeft, 32)
		net.Broadcast()

		if (GBRounds.TimeLeft <= 0) then
			GBRounds.Start()
			return
		end

		GBRounds.TimeLeft = GBRounds.TimeLeft - 1
	end
end
timer.Create("GBRounds.Logic", 1, 0, function() GBRounds.Logic() end)
