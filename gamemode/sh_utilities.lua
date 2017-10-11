/*
	GetAllAlive
*/

function player.GetAllAlive()
	local count = 0

	for k, v in pairs(player.GetAll()) do
		if (v:Alive()) then
			count = count + 1
		end
	end

	return count
end
