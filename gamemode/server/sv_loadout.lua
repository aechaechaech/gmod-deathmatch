util.AddNetworkString( "give_player_guns" )
util.AddNetworkString( "player_spawned" )

hook.Add( "PlayerSpawn", "Player Spawned", function (ply) 
    net.Start("player_spawned")
    net.Send(ply)
end)

net.Receive("give_player_guns", function (len, ply)
    local gun = net.ReadString()
    ply:Give( gun, False )
end)