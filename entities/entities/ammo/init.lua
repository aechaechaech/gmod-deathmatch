AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

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

function ENT:Use(a, c) 
	if ( a:IsPlayer() ) then
		plyWeapon = a:GetActiveWeapon()
		ammoAmt = plyWeapon:GetMaxClip1() * 2
		a:GiveAmmo( ammoAmt, plyWeapon:GetPrimaryAmmoType() )
		self:Remove()
	end
end