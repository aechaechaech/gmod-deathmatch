pastTime = CurTime()
wallLength = 7
delayBetweenWalls = 45 + wallLength

hook.Add("Think","wallManager", function()
    GetConVar( "timeUntilWalls" ):SetFloat( (pastTime + delayBetweenWalls) - CurTime()  )
    if CurTime() > pastTime + delayBetweenWalls then
        for k, ply in pairs( player.GetAll() ) do  
            net.Start("wallOverlay")
            net.WriteInt(wallLength, 32)
            net.Send(ply)
        end

        pastTime = CurTime()
    end
end)