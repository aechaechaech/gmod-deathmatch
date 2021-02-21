AddCSLuaFile()

SWEP.PrintName = "Ammo Finder"
SWEP.Spawnable = true
SWEP.Category = "ⓗ's Deathmatch"

SWEP.Author = "ⓗⓗⓗ"
SWEP.Purpose = "Locate ammo drops by holding down the left mouse button"

SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.delayTime = 5
SWEP.LastTimeRelease = CurTime()

function SWEP:PrimaryAttack() end

function SWEP:SecondaryAttack() end

function SWEP:Think()
	if self.Owner:KeyDown (IN_ATTACK) then
		if self.LastTimeRelease + self.delayTime < CurTime() then
			if CLIENT then
				hook.Add( "HUDPaint", "ammoOverlay", function()
					for k, v in pairs ( ents.FindByClass( "ammo" ) ) do
						local plyPos = v:GetPos()
						local plyinfopos = ( plyPos + Vector( 0, 0, 90 )):ToScreen()
						
						halo.Add({v}, Color(255, 255, 255), 1, 1, 1, true, true)
						-- draw info on powerup
						draw.SimpleTextOutlined( "Ammo Drop", "TargetID", plyinfopos.x, plyinfopos.y, Color(255, 255, 255), 1, 1, 1, Color( 0, 0, 0 ) )
					end
				end)
			end
		end
	else
		self.LastTimeRelease = CurTime()
		hook.Remove("HUDPaint", "ammoOverlay")
	end
end