AddCSLuaFile("cl_init.lua")
AddCSLuaFile("client/cl_leaderboard.lua")
AddCSLuaFile("client/cl_loadout.lua")
AddCSLuaFile("client/cl_admin_panel.lua")
AddCSLuaFile("client/cl_wall_overlay.lua")
AddCSLuaFile("client/cl_hud.lua")

AddCSLuaFile("shared.lua")
include("shared.lua")

include("server/sv_invincibilty_on_spawn.lua")
include("server/sv_loadout.lua")
include("server/sv_general_rules.lua")
include("server/sv_admin_panel.lua")
include("server/sv_walls_manager.lua")
include("server/sv_dropper.lua")

function GM:PlayerLoadout( ply )
	return true
end

function GM:PlayerSetModel( ply )
	ply:SetModel("models/player/puggamaximus.mdl")
end
