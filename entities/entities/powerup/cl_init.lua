include("shared.lua")

function ENT:Draw()
	-- delay time to be visable so that the block can fall from the sky and land before being seen
	local r = math.random(1,255)
    local g = math.random(1,255)
    local b = math.random(1,255)
	
	self:SetColor(Color(r,g,b))

	self:DrawModel()
end