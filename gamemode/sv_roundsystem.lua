GBRounds = {}

/*
  Variables
*/

GBRounds.PrepTime = 5
GBRounds.TimeLeft = GM.GBRounds.PrepTime
GBRounds.RoundState = "idle"

function GBRounds:Start()
  print("Round started!")
end

function GBRounds:End(winner)
  print("Round ended! Next round begins in " .. GBRounds.PrepTime .. " seconds.")
end

util.AddNetworkString("displaytimerforhud")
function GBRounds:Logic()
  if (player.GetAllAlive() > 1) then
    print(GBRounds.TimeLeft)
    for k, v in pairs(player.GetAll()) do
      net.Start("displaytimerforhud")
        net.WriteInt(GBRounds.TimeLeft, 32)
      net.Send(v)
    end
    GBRounds.TimeLeft = GBRounds.TimeLeft - 1
  end
end
timer.Create("GBRounds.Logic", 1, 0, function() GBRounds:Logic() end)
