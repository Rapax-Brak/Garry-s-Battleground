GM.Rounds = {}

function GM.Rounds:StartRound()
	if (GAMEMODE.Utilities:GetAliveCount() >= #player.GetAll() && #player.GetAll() > 1) then
		roundStatus = true
	end

	print("Round Started: " .. tostring(roundStatus))
	self:CheckRoundStatus()
end

function GM.Rounds:CheckRoundStatus()
	print("Round Active: " .. tostring(roundStatus))

	if (!roundStatus) then return end

	timer.Create("CheckRoundTimer", 1, 1, function()
		for k, v in pairs(player.GetAll()) do
			if (GAMEMODE.Utilities:GetAliveCount() <= 1 and v:Alive()) then
				self:EndRound(v:Nick())
			end
		end
	end)
end

function GM.Rounds:EndRound(winner)
	print(winner .. " won the round!")

	timer.Create("CleanUpTimer", 3, 1, function()
		for k, v in pairs(player.GetAll()) do
			v:Respawn()
		end

		roundStatus = false
		print("Round Ended: " .. tostring(!roundStatus))
	end)
end
