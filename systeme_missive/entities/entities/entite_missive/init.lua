AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

resource.AddFile("resource/fonts/Warsuck.ttf")


function ENT:Initialize()
    self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )  -- PLACEHOLDER MODEL
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS ) 
    local phys = self:GetPhysicsObject() -- To make sure it can be moved etc.
    if phys:IsValid() then  
        phys:Wake()
    end
end

util.AddNetworkString("OpenImagePanel")

function ENT:Use(activator, caller)
    if caller:IsPlayer() then 
        net.Start("OpenImagePanel")
        net.Send(caller)
    end
end

util.AddNetworkString("SendMissive")
util.AddNetworkString("SendMissivePublic")
util.AddNetworkString("ReceiveMissiveprv")

util.AddNetworkString("ReceiveMissivepbl")


net.Receive("SendMissive", function(len, sender) -- Our send function, started a net message that then gives the player an option to accept.
    local targetPlayer = net.ReadEntity()
    local message = net.ReadString()

    if IsValid(targetPlayer) and targetPlayer:IsPlayer() then
        net.Start("ReceiveMissiveprv")
        net.WriteString(sender:Name())
        net.WriteString(message)
        net.Send(targetPlayer)
    end
end)


net.Receive("SendMissivePublic", function(len, ply)
    local message = net.ReadString()

    for _, targetPlayer in pairs(player.GetAll()) do
        net.Start("ReceiveMissivepbl")
        net.WriteString(ply:Name())
        net.WriteString(message)
        net.Send(targetPlayer)
    end
end)

util.AddNetworkString("ixGiveMissiveItemprv")

util.AddNetworkString("ixGiveMissiveItempbl")

net.Receive("ixGiveMissiveItemprv", function(len, ply) -- If accepted, put the item in their inventory along w/ data
    local message = net.ReadString()
    local senderName = net.ReadString()

    ply:GetCharacter():GetInventory():Add("missiveprv",1,{["message"] = message, ["sender"] = senderName,})
end)

net.Receive("ixGiveMissiveItempbl", function(len, ply)
    local message = net.ReadString()
    local senderName = net.ReadString()

    ply:GetCharacter():GetInventory():Add("missivepbl",1,{["message"] = message, ["sender"] = senderName,})
end)
