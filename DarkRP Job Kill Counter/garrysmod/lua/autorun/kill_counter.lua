
--Note: In this case, the team used for the kill counter will be called "AttackerTeam"
--This script can also be used for when it's needed to reset the kill counter

hook.Add( "PlayerDeath", "killcounter", function( victim, inflictor, attacker ) -- Counts the player's kills, resets upon death.
    if team.GetName(attacker:Team()) == "AttackerTeam'" then 
        attacker:SetNWInt("kills", attacker:GetNWInt("kills", 0) + 1)
    end 
    if victim == attacker and team.GetName(attacker:Team()) == "AttackerTeam'" then 
        attacker:SetNWInt("kills", 0)
end )

ply = LocalPlayer() -- Local player, may return errors if used on an empty server.

hook.Add( "PlayerSay", "killcount", function( ply, text )
	if text == "/resetkills" then 
        ply:SetNWInt("kills", 0)
        return ""
    end 
end )


hook.Add( "HUDPaint", "killcounting", function() -- Hud Painting function, generates text displaying your kills. Modifiable position.
     if not(team.GetName(ply:Team()) == "AttackerTeam") then return end 
     if ply:GetNWBool("switched") then return end 
     draw.DrawText( "Kills: "..tostring(ply:GetNWInt("kills"), 0), "CloseCaption_Normal", ScrW() * 0.035, ScrH() * 0.79, color_white, TEXT_ALIGN_LEFT)
end )

hook.Add( "PlayerChangedTeam", "stophud", function( ply, oldTeam, newTeam ) -- If the player switches their job, the kill counter stops displaying.
	if oldTeam:GetName(ply:Team()) == "AttackerTeam" then 
        ply:SetNWBool("switched", True)
    end 
    if newTeam:GetName(ply:Team()) == "AttackerTeam" and ply:GetNWBool("switched") == false then 
        ply:SetNWBool("switched", False)
    end 
end )