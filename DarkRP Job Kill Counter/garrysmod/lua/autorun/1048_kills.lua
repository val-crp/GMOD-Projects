hook.Add( "PlayerDeath", "1048kill", function( victim, inflictor, attacker ) -- Counts the player's kills, resets at 10
    if team.GetName(attacker:Team()) == "SCP-1048 'Builder Bear'" then 
        attacker:SetNWInt("1048kills", attacker:GetNWInt("1048kills", 0) + 1)
    end 
    if victim == attacker and team.GetName(attacker:Team()) == "SCP-1048 'Builder Bear'" then 
        attacker:SetNWInt("1048kills", 0)
    end 
    if team.GetName(attacker:Team()) == "SCP-1048 'Builder Bear'" and attacker:GetNWInt("1048kills", 0) == 9 then
        victim:SetTeam(TEAM_1048A)
        attacker:SetNWInt("1048kills", 0)
    end  
end )



hook.Add( "PlayerSay", "killcount", function( ply, text )
	if text == "/kills" then 
        ply:ChatPrint(tostring(ply:GetNWInt("1048kills", 0)))
        return ""
    end 
end )

ply = LocalPlayer()

--[[ hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
     if not(team.GetName(ply:Team()) == "SCP-1048 'Builder Bear'") then return end 
    if ply:GetNWBool("switched") then return end 
	draw.WordBox( 8, ScrW() - 920, ScrH() - 98, "KillCount: "..ply:GetNWInt("1048kills"),"ScoreboardText",Color(200,0,0,0),Color(255,255,255,255))
end 

hook.Add( "PlayerChangedTeam", "stophud", function( ply, oldTeam, newTeam )
	if oldTeam:GetName(ply:Team()) == "SCP-1048 'Builder Bear'" then 
        ply:SetNWBool("switched", True)
    end 
    if newTeam:GetName(ply:Team()) == "SCP-1048 'Builder Bear'" and ply:GetNWBool("switched") == false then 
        ply:SetNWBool("switched", False)
    end 
end ))--]]