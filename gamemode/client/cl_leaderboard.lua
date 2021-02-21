scoreboard = scoreboard or {}

surface.CreateFont( "Default", {
	font = "Tahoma", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function scoreboard:show()
  hook.Add( "HUDPaint", "KD_Box", function()
		nicks={}
    for k, ply in pairs(player.GetAll()) do
      surface.SetFont("Default")
      nicks[k]=surface.GetTextSize(tostring(ply:Nick()))
    end
    table.sort(nicks)

		kills={}
    for k, ply in pairs(player.GetAll()) do
      surface.SetFont("Default")
      kills[k]=surface.GetTextSize(tostring("  Kill's: "..ply:Frags()))
    end
    table.sort(kills)

		deaths={}
    for k, ply in pairs(player.GetAll()) do
      surface.SetFont("Default")
      deaths[k]=surface.GetTextSize(tostring("  Deaths's: "..ply:Deaths()))
    end
    table.sort(deaths)

		kds={}
    for k, ply in pairs(player.GetAll()) do
      surface.SetFont("Default")
      kds[k]=surface.GetTextSize(tostring("  K/D: "..round(ply:Frags()/ply:Deaths(), 3)))
    end
    table.sort(kds)

    width=nicks[table.getn(nicks)]+kills[table.getn(kills)]+deaths[table.getn(deaths)]+kds[table.getn(kds)]+ScrH()*0.016
    height=player.GetCount()*27
    x=(ScrW()/2)-(width/2)
    y=(ScrH()/2)-(height/2)

		nick_x=x*1.013
		kills_x=nick_x+nicks[table.getn(nicks)]
		deaths_x=kills_x+kills[table.getn(kills)]
		kd_x=deaths_x+deaths[table.getn(deaths)]

		players=player.GetAll()
		table.sort( players, function( a, b ) return round(a:Frags()/a:Deaths(), 3) > round(b:Frags()/b:Deaths(), 3) end )

  	draw.RoundedBox(10,x,y,width,height,Color(255,255,255))
    for k, ply in pairs(players) do
  	   draw.SimpleText(tostring(ply:Nick()),"Default",nick_x,y+((k-1)*27),Color(0, 0, 0),0,0)
			 draw.RoundedBox(0,kills_x+surface.GetTextSize("  ")/2,y+((k-1)*27)+1,2,27,Color(0,0,0))
			 draw.SimpleText(tostring("  Kill's: "..ply:Frags()),"Default",kills_x,y+((k-1)*27),Color(0, 0, 0),0,0)
			 draw.RoundedBox(0,deaths_x+surface.GetTextSize("  ")/2,y+((k-1)*27)+1,2,27,Color(0,0,0))
			 draw.SimpleText(tostring("  Deaths's: "..ply:Deaths()),"Default",deaths_x,y+((k-1)*27),Color(0, 0, 0),0,0)
			 draw.RoundedBox(0,kd_x+surface.GetTextSize("  ")/2,y+((k-1)*27)+1,2,27,Color(0,0,0))
			 draw.SimpleText(tostring("  K/D: "..round(ply:Frags()/ply:Deaths(), 3)),"Default",kd_x,y+((k-1)*27),Color(0, 0, 0),0,0)
    end
  end )

	function scoreboard:hide()
    hook.Remove("HUDPaint","KD_Box")
	end
end

function GM:ScoreboardShow()
	scoreboard:show()
end

function GM:ScoreboardHide()
	scoreboard:hide()
end
