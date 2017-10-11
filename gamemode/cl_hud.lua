surface.CreateFont("AliveCount", {
	font = "DermaLarge",
	size = ScreenScale(22),
	weight = 600
})

local TimeLeft = 0
net.Receive("DisplayTimer", function()
  TimeLeft = net.ReadInt(32)
end)

local function HUD_PrepTime()
  if (TimeLeft > 0) then
    draw.SimpleTextOutlined("MATCH BEGINS IN " .. TimeLeft, "DermaLarge", ScrW() / 2, ScrH() * 0.1, Color(80, 210, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(30, 80, 120, 255))
  end
end

local function HUD_AliveCount()
  local width, height = ScrW() * 0.125, ScrH() * 0.06
  local padding = 25

  draw.RoundedBox(0, ScrW() - (width + padding), padding, height, height, Color(0, 0, 0, 200))
  draw.RoundedBox(0, ScrW() - ((width - height) + padding), padding, width - height, height, Color(255, 255, 255, 150))
  draw.SimpleText(player.GetAllAlive(), "AliveCount", ScrW() - ((width + padding) - (height / 2)), (height / 2) + padding, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  draw.SimpleText("ALIVE", "AliveCount", ScrW() - (((width - height) / 2) + padding), (height / 2) + padding, Color(0, 0, 0, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function GM:HUDPaint()
  HUD_PrepTime()
  HUD_AliveCount()
end
