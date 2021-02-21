 -- on player spawn give them god mode, take it away if they shoot or 5 seconds are up
hook.Add( "PlayerSpawn", "Give player invincibitly on spawn", function(ply)
	hook.Remove("KeyPress", "Check_if_shooting")
	hook.Remove("Think","get_rid_of_god")

	ply:GodEnable()

	timer.Create( "god_timer", 5, 1, function()
		if ply:IsValid() then
			ply:GodDisable()				
		end
	end )

	-- wait .5 secs because some people click to respawn and that would trigger this
	timer.Create( "respawn_delay", .5, 1, function()
		hook.Add("KeyPress", "check_if_shooting", function(ply, key)
		  	if key == IN_ATTACK or key == IN_ATTACK2 then
				if ply:IsValid() then
					ply:GodDisable()
					hook.Remove("KeyPress", "check_if_shooting")
				end
			end
		end)
	end)
end)
