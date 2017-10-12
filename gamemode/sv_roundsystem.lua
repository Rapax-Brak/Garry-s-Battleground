GBRounds = {}

/*
  Variables
*/

GBRounds.PrepTime = 5
GBRounds.TimeLeft = GBRounds.PrepTime
GBRounds.RoundActive = false

function GBRounds.Start()
  GBRounds.RoundActive = true

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

function GBRounds.Think()
  if (GBRounds.RoundActive) then
    for k, v in pairs(player.GetAll()) do
      if (player.GetAllAlive() < 2 and v:Alive()) then
        GBRounds.End(v)
        timer.Simple(10, function()
          GBRounds.RoundActive = false
        end)
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
