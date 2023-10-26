ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "SCP-714"
ENT.Instructions = "Put it on ;)"
ENT.Spawnable = true

ENT.Author = "Vi"
ENT.Purpose = "Bit of a learning experience. :)"
if CLIENT then
	net.Receive( "714Msg", function()
		chat.AddText( Color( 255, 0, 0 ), net.ReadString() )
	end )
end