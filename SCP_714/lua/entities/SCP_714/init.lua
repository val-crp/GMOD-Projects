AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize() -- Set Model and Physics
    self:SetModel("models/mishka/models/scp714.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    local phys = self:GetPhysicsObject()

    if(phys:IsValid()) then 
        phys:Wake()
    end 
end

function ENT:Use(activator, caller) 
    if not activator:GetNWBool("Wearing714") then -- Small check, doesn't run code if wearing 714.
        self:Remove()
        activator:EmitSound("mysound/SFX_Interact_PickItem3.wav")
        activator:SetNWBool("Wearing714", true)
        net.Start("714Msg")
        net.WriteString("You are now wearing SCP-714.")
        net.Send(activator)                                 
        timer.Create("event1", 15, 1, function() -- Event 1 reduces the walking and running speed.
            net.Start("714Msg")
            net.WriteString("You start feeling a little drowsy..")
            net.Send(activator)
            activator:SetWalkSpeed(activator:GetWalkSpeed() - 100)
            activator:SetRunSpeed(activator:GetRunSpeed() - 100)
            activator.Event1Finished = true
            timer.Remove("event1")
        end)
        timer.Create("event2", 30, 1, function() -- Event 2 slows the player down even more, jumping is disabled.
            net.Start("714Msg")
            net.WriteString("You're getting real tired, you can barely walk. Can't even think about jumping at this point.")
            net.Send(activator)
            activator:SetWalkSpeed(activator:GetWalkSpeed() - 150)
            activator:SetRunSpeed(activator:GetRunSpeed() - 150)
            activator:SetJumpPower(0)
            timer.Remove( "event2")
        end)
        timer.Create("event3", 45, 1, function() -- Event 3 makes it so that the player can no longer walk.
            net.Start("714Msg")
            net.WriteString("You lay down.. You seriously need some rest. Just a few minutes of sleep..")
            net.Send(activator)
            activator:SetWalkSpeed(activator:GetWalkSpeed() - 150)
            activator:SetRunSpeed(activator:GetRunSpeed() - 150)
            activator:ConCommand( "+duck" )
            timer.Remove( "event3")
        end)
        timer.Create("event4", 60, 1, function() -- Event 4 kills the player.
            net.Start("714Msg")
            net.WriteString("You go to sleep.. To never wake up again.")
            net.Send(activator)
            activator:ConCommand( "-duck" )
            activator:Kill()
            timer.Remove( "event4")
        end)

    end 
end




local function Drop714(ply, normal)  -- A function that runs with the chat command, console and on death when wearing the SCP.
    if ply:GetNWBool("Wearing714") then
        net.Start("Drop714")
        net.WriteBool(normal)
        net.Send(ply)
        local ent = ents.Create("scp_714")
        if not ent:IsValid() then return end
        ent:SetPos(ply:GetPos() + Vector(0, 0, 0))  -- Entity gets placed almost where the player is, random rotation.
        ent:SetAngles(Angle(0, math.random(0, 359)))
        ent:Spawn()
        ent:Activate()
        ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        ply:SetNWBool("Wearing714", false)
        ply:EmitSound("mysound/drop.ogg")
        net.Start("714Msg")
        net.WriteString("You have dropped SCP-714.")
        net.Send(ply)
        ply:SetWalkSpeed(250)
        ply:SetRunSpeed(500)
        ply:SetJumpPower(200)
        timer.Pause( "event1")  
        timer.Pause( "event2" )
        timer.Pause( "event3" )
        timer.Pause( "event4" )

    end
end

net.Receive("Drop714", function(len, ply) 
    Drop714(ply, true)
end)

hook.Add("PlayerSay", "SCP714ChatCommand", function(ply, str)  -- Chat command for dropping the SCP.
    if str == "!drop714" then
        Drop714(ply, true)
        return
    end
end)