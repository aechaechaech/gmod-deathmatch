surface.CreateFont( "hudFont", {
	font = "DebugFixed",
	size = 12,
	weight = 500,
} )

hook.Add( "HUDPaint", "powerupOverlay", function()

    for k, v in pairs ( ents.FindByClass( "powerup" ) ) do
        local boxinfopos = ( v:GetPos() + Vector( 0, 0, 90 )):ToScreen()
        
        -- draw halo and text on box
        halo.Add({v}, Color(255, 255, 255), 1, 1, 1, true, true)
        draw.SimpleTextOutlined( "Power Up", "TargetID", boxinfopos.x, boxinfopos.y, Color(255, 255, 255), 1, 1, 1, Color( 0, 0, 0 ) )
    end
end)


local function start_walls()
    wallsLength = net.ReadInt(32)

    hook.Add( "HUDPaint", "wallsOverlay", function()
        for k, v in pairs ( player.GetAll() ) do
            local plyinfopos = (v:GetPos() + Vector( 0, 0, 90 )):ToScreen()

            -- draw halo and info on player
            halo.Add({v}, team.GetColor(v:Team()), 1, 1, 1, true, true)

            draw.SimpleTextOutlined(v:Nick(), "TargetID", plyinfopos.x, plyinfopos.y - 50, team.GetColor(v:Team()), 1, 1, 1, Color( 0, 0, 0 ))
            local plyDistance = "Distance: "..math.Round(((LocalPlayer():GetPos():Distance(v:GetPos()))))
            draw.SimpleTextOutlined(plyDistance, "hudFont", plyinfopos.x, plyinfopos.y - 40, team.GetColor(v:Team()), 1, 1, 1, Color( 0, 0, 0 ))
            local plyHP = "HP: " .. v:Health()
            draw.SimpleTextOutlined(plyHP, "hudFont", plyinfopos.x, plyinfopos.y - 20, Color( 255, 0, 0 ), 1, 1, 1, Color( 0, 0, 0 ))
            local plyARMOR = "Armor: " .. v:Armor()
            draw.SimpleTextOutlined(plyARMOR, "hudFont", plyinfopos.x, plyinfopos.y - 10, Color( 0, 255, 155 ), 1, 1, 1, Color( 0, 0, 0 ))
        end
    end)

    timer.Create( "disableWalls", wallsLength, 1, function()
		hook.Remove("HUDPaint", "wallsOverlay")
	end)
end

net.Receive("wallOverlay", start_walls)