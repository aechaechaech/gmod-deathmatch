include("shared.lua")

function ENT:Draw()
	-- delay time to be visable so that the block can fall from the sky and land before being seen
	self:DrawModel()
end