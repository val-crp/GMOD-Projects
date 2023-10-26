concommand.Add("drop714", function( ply )
	if ply:GetNWBool("Wearing714") then
		net.Start("Drop714")
		net.SendToServer()
	end
end)
