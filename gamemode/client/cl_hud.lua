hook.Add("HUDPaint", "wallCounter", function()
    -- see if anyone has the god power up, if yes and we dont have it
    -- make countdown text red
    local outlineColor = Color(0, 0, 0, 255)
    for k, ply in pairs ( player.GetAll() ) do
        if ply:GetMaxArmor() == 101 and ply ~= LocalPlayer() then
            outlineColor = Color(255, 0, 0, 255)
            break
        end
    end

    -- get time and round to two decimal places
    local time = GetConVar( "timeUntilWalls" ):GetFloat()
    time = math.floor(time * 100)/100

    -- draw time to screen
    local textToDraw =  "Time until walls: " .. time
    draw.SimpleTextOutlined(textToDraw, "Default", 4, 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, outlineColor)

    -- draw god box
    if LocalPlayer():HasGodMode() then
        draw.RoundedBox(10,ScrW()-50,0,50,50,Color(0,255,0))
    end
end)