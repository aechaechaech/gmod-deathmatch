AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("wallOverlay")

local wallPowerLength = 10

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl") 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	local phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
end

local function ammoPowerup(ply)
	ply:PrintMessage(HUD_PRINTTALK, "Ammo")

	for index, weapon in pairs( ply:GetWeapons() ) do
		ammoAmt = weapon:GetMaxClip1() * 3
		ply:GiveAmmo( ammoAmt, weapon:GetPrimaryAmmoType() )
	end
end

local function healthyPowerup(ply)
	ply:PrintMessage(HUD_PRINTTALK, "Healthy")

	ply:SetHealth(120)
	ply:SetArmor(150)
end

local function speedPowerup(ply)
	ply:PrintMessage(HUD_PRINTTALK, "Speedy")

	ply:SetRunSpeed(1200)

	timer.Create( "disableSpeedPowerTimer", 10, 1, function()
		if ply:IsValid() then
			ply:SetRunSpeed(600)		
		end
	end )
end

local function godPowerup(ply)
	ply:PrintMessage(HUD_PRINTTALK, "God")

	hook.Remove("Think","get_rid_of_god")
	ply:GodEnable()

	timer.Create( "disableGodPowerTimer", 10, 1, function()
		if ply:IsValid() then
			ply:GodDisable()
		end
	end )
end

local function wallsPowerup(ply)
	ply:PrintMessage(HUD_PRINTTALK, "Walls")

	net.Start("wallOverlay")
	net.WriteInt(wallPowerLength, 32)
  	net.Send(ply)

	-- players max armors are set to 101 when they get the wall power up
	-- as a way to track which players do and dont have it easliy
	-- yes i know my incomptency is showing
	-- if you know a better way to do this please tell me 
	ply:SetMaxArmor(101)
	timer.Create( "revertGodTracker", 10, 1, function()
		ply:SetMaxArmor(100)
	end )
end

function ENT:Use(a, c) 
	if ( a:IsPlayer() ) then
		randomChoice = math.random( 0, 4 )

		if randomChoice == 0 then
			ammoPowerup(a)
		elseif randomChoice == 1 then
			healthyPowerup(a)
		elseif randomChoice == 2 then
			speedPowerup(a)
		elseif randomChoice == 3 then
			godPowerup(a)
		elseif randomChoice == 4 then
			wallsPowerup(a)
		end


		self:Remove()
	end
end