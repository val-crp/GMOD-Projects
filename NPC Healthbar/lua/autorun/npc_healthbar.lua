if CLIENT then 


local healthBarIcon = Material("heart2.png")

hook.Add("HUDPaint", "DrawNPCHealthBar", function()
    local ply = LocalPlayer()
    local tr = ply:GetEyeTrace()

    if IsValid(tr.Entity) and tr.Entity:Health() > 0 then
        -- If the player is looking at an NPC, draw the health bar
        local npc = tr.Entity
        local npcHealth = npc:Health()
        local npcMaxHealth = npc:GetMaxHealth()

        -- Calculate the dimensions we're gonna be using
        local barWidth = 300
        local barHeight = 50
        local barX = ScrW() / 2 - barWidth / 2
        local barY = ScrH() - 100

        -- Draw the health bar background
        draw.RoundedBox(4, barX - 1, barY, barWidth, barHeight, Color(0, 0, 0, 0))

        -- Calculate the width of the health bar fill based on NPC's health
        local healthFraction = math.Clamp(npcHealth / npcMaxHealth, 0, 1)
        local fillWidth = healthFraction * barWidth
        local healthColor 

        if healthFraction > 0.5 then  -- Colored the health based off how much you have left
            healthColor = Color(0,255,0)
        elseif healthFraction < 0.5 and healthFraction > 0.25 then 
            healthColor = Color(255,174,76)
        else 
            healthColor = Color(255,0,0)

        end 

        -- Draw the health bar fill
        draw.RoundedBox(24, barX - 20, barY, fillWidth + 20, barHeight, healthColor)

        local iconSize = 32  -- Size of the icon
        surface.SetMaterial(healthBarIcon)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(barX - iconSize - 60, barY + barHeight / 2 - iconSize / 2 - 30, 426, 101)
    end
end)
end