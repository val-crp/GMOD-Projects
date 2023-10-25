-- Add any Team name you wish. You could either do it as ["Job Name"] or use TEAM_NAME.
local TeamList = {
    ["TeamAttacker'"] = true,
    }
-- If you want to remove an item that a certain job can equip, remove the relevant line, if you want to add one just follow the following format [weapon_name] = true,
local items = {
    ["weapon_ciga_cheap"] = true, 
}


hook.Add( "PlayerCanPickupWeapon", "RestrictedWeapons", function( ply, weapon )
    if TeamList[team.GetName( ply:Team() )] then
        if items[weapon:GetClass()] then
          return true
        else
          return false
        end
    end
end )