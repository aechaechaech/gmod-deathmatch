include("blacklist.lua")

-- entity blacklist but for entire prefixes
function GM:PlayerSpawnSENT(ply, class)
  for k,v in pairs(blacklist_entity_prefix) do
    if string.StartWith(class, v) then
      return false
    end
  end

  for k,v in pairs(blacklist_entities) do
    if class == v then
      return false
    end
  end
  return true
end

-- weapon blacklist
function GM:PlayerCanPickupWeapon( ply, wep )
  for k, v in pairs(blacklist_weapons) do
    if v == wep:GetClass() then
      return false
    end
    end
  return true
end
