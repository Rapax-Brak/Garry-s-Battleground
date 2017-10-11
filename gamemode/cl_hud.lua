net.Receive("displaytimerforhud", function()
  local t = net.ReadInt(32)

  print(t)
end)

function GM:HUDPaint()
    draw.SimpleText(player.GetAllAlive(), "DermaLarge", 25, 25, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end
