util.AddNetworkString( "reset_leaderboard" )
util.AddNetworkString( "change_noclip_state" )

local can_noclip = false

net.Receive( "reset_leaderboard", function(len, ply)
    for k, ply in pairs( player.GetAll() ) do
        ply:SetDeaths(0)
        ply:SetFrags(0)
    end
end )

net.Receive( "change_noclip_state", function(len, ply)
    can_noclip = !can_noclip
    print("Noclip state changed to: "..tostring(can_noclip))
end )

hook.Add( "PlayerNoClip", "FeelFreeToTurnItOff", function( ply, desiredState )
    if ( desiredState == false ) then
        return true
    else
        return can_noclip
    end
end )