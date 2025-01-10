ITEM.name = "Missive Publique"
ITEM.description = ""
ITEM.category = "Other"
ITEM.model = "models/props_c17/paper01.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.returnItems = {}

ITEM.functions.Use = { -- Read function, starts a net message that reads the content and shows the GUI.
	name = "Lire",
	OnRun = function(item)
		local client = item.player
		local character = client:GetCharacter()
        net.Start("ixReadMissivepbl")
        net.WriteString(item:GetData("message", "none"))
        net.WriteString(item:GetData("sender","none"))
		net.Send(client)
        return false 
    end,
}

ITEM.functions.Bruler = { -- Destroys item after use.
	name = "Bruler",
	OnRun = function(item)
		local client = item.player
		local character = client:GetCharacter()
        return true 
    end,
}


if SERVER then
	util.AddNetworkString("ixReadMissivepbl") -- Make sure the NetworkString is defined, else error
end

if CLIENT then
    local isReadingMissive = false
    local closeButton
    local backgroundMat = Material("materials/e_missive.png")
    local message = ""
    local sender = ""
    net.Receive("ixReadMissivepbl", function()
        local client = LocalPlayer()
        message = net.ReadString()
        sender = net.ReadString()
        isReadingMissive = true

        if frame then frame:Remove() end -- If somehow frame exists, close it so it doesnt error

        frame = vgui.Create("DFrame")
        frame:SetSize(1600, 900)
        frame:Center()
        frame:SetTitle("")
        frame:ShowCloseButton(false)
        frame:SetDraggable(false)
        frame:MakePopup()
        frame:SetSizable(false)

        function frame:Paint(w, h)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(backgroundMat)
            surface.DrawTexturedRect(0, 0, w, h)
        end

        
        local buttonMat = Material("materials/Bouton_ferme.png")

        local closeButton = vgui.Create("DButton", frame)
        closeButton:SetSize(32, 32)
        closeButton:SetPos(frame:GetWide() - 42, 10) 
        closeButton:SetText("")

        function closeButton:Paint(w, h)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(buttonMat)
            surface.DrawTexturedRect(0, 0, w, h)
        end

        closeButton.DoClick = function()
            frame:Close()
        end

        local senderLabel = vgui.Create("DLabel", frame)
        senderLabel:SetPos(260, 150)
        senderLabel:SetSize(1500, 40)
        senderLabel:SetFont("Warsuck")
        senderLabel:SetText("Expediteur: " .. sender)
        senderLabel:SetTextColor(color_black)
        senderLabel:SetContentAlignment(4)  
        senderLabel:SizeToContents()

        local messageLabel = vgui.Create("DLabel", frame)
        messageLabel:SetPos(250, 250)
        messageLabel:SetSize(1200, 500)
        messageLabel:SetFont("Warsuck")
        messageLabel:SetText(message)
        messageLabel:SetWrap(true)
        messageLabel:SetTextColor(color_black)
        messageLabel:SetContentAlignment(7)
        messageLabel:SizeToContentsY()
    end)
end
