local GBScoreboard = nil
function GM:ScoreboardShow()
  local PlayerList = nil

  if (!IsValid(GBScoreboard)) then
    GBScoreboard = vgui.Create("DFrame")
    GBScoreboard:SetSize(ScrW() * 0.3, ScrH() * 0.35)
    GBScoreboard:SetPos(25, 25)
    GBScoreboard:SetTitle("")
    GBScoreboard:SetDraggable(false)
    GBScoreboard:ShowCloseButton(false)
    GBScoreboard:SetDeleteOnClose(true)
    GBScoreboard.Paint = function(self, w, h)
      draw.RoundedBox(0, 0, 0, w, 40, Color(0, 0, 0, 200))
      draw.SimpleText("Garry's Battlegrounds", "DermaLarge", w / 2, 40 / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local GBScrollPanel = vgui.Create("DScrollPanel", GBScoreboard)
    GBScrollPanel:SetSize(GBScoreboard:GetWide(), GBScoreboard:GetTall() - 40)
    GBScrollPanel:SetPos(0, 40)

    local PaintScroll = GBScrollPanel:GetVBar()
    function PaintScroll:Paint(w, h)
    	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
    end
    function PaintScroll.btnUp:Paint(w, h)
    	draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 125))
    end
    function PaintScroll.btnDown:Paint(w, h)
    	draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 125))
    end
    function PaintScroll.btnGrip:Paint(w, h)
    	draw.RoundedBox(0, 0, 0, w, h, color_white)
    end

    GBPlayerList = vgui.Create("DListLayout", GBScrollPanel)
    GBPlayerList:SetSize(GBScrollPanel:GetWide(), GBScrollPanel:GetTall())
    GBPlayerList:SetPos(0, 0)
  end

  if (IsValid(GBScoreboard)) then
    GBPlayerList:Clear()

    for k, v in pairs(player.GetAll()) do
      surface.SetFont("DermaLarge")
      local nameWidth, nameHeight = surface.GetTextSize(v:Nick())

      local GBPlayerPanel = vgui.Create("DPanel", GBPlayerList)
      GBPlayerPanel:SetSize(GBPlayerList:GetWide(), 40)
      GBPlayerPanel:SetPos(0, 0)
      GBPlayerPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, v:Alive() and Color(255, 255, 255, 150) or Color(255, 180, 180, 150))
        draw.SimpleText(v:Nick(), "DermaLarge", 45, h / 2, Color(0, 0, 0, 225), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Kills: " .. v:Frags(), "DermaLarge", w - 20, h / 2, Color(0, 0, 0, 225), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
      end

      local GBAvatar = vgui.Create("AvatarImage", GBPlayerPanel)
      GBAvatar:SetSize(38, 38)
      GBAvatar:SetPos(1, (GBPlayerPanel:GetTall() / 2) - (38 / 2))
      GBAvatar:SetPlayer(v, 38)
    end

    GBScoreboard:Show()
    GBScoreboard:MakePopup()
    GBScoreboard:SetKeyboardInputEnabled(false)
  end
end

function GM:ScoreboardHide()
  if (IsValid(GBScoreboard)) then
    GBScoreboard:Hide()
  end
end
