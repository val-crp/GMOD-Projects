include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

net.Receive("OpenImagePanel", function() -- Sending private or public messages goes onto the next function, defined seperately to have more readable code.
    local frame = vgui.Create("DFrame")
    frame:SetSize(800, 800)
    frame:Center()
    frame:SetTitle("")  
    frame:ShowCloseButton(false) 
    frame:SetDraggable(false) 
    frame:MakePopup()
    frame:SetSizable(false) 


    function frame:Paint(w, h)

    end

    local imagePanel = vgui.Create("DPanel", frame)
    imagePanel:Dock(FILL)


    local backgroundMat = Material("materials/background.png")


    function imagePanel:Paint(w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(backgroundMat)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    local buttonMat = Material("materials/Bouton_ferme.png")


    local closeButton = vgui.Create("DButton", imagePanel)
    closeButton:SetSize(32, 32)  
    closeButton:SetPos(imagePanel:GetWide() - 32, 10)  
    closeButton:SetText("")  

    function closeButton:Paint(w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(buttonMat)
        surface.DrawTexturedRect(0, 0, w, h)
    end


    closeButton.DoClick = function()
        frame:Close()
    end


    local prvbuttonMat = Material("materials/Bouton_Envoyer.png")

    local sendprvButton = vgui.Create("DButton", imagePanel)
    sendprvButton:SetSize(160.125, 49.125)  
    sendprvButton:SetPos(imagePanel:GetWide() / 2, imagePanel:GetTall() / 2)
    sendprvButton:SetText("")

    function sendprvButton:Paint(w,h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(prvbuttonMat)
        surface.DrawTexturedRect(0, 0, w, h)
    end 

    sendprvButton.DoClick = function()
        frame:Close()
        OpenPlayerListFrame() 
    end

    local pblbuttonMat = Material("materials/Bouton_Envoyer.png")

    local sendpblButton = vgui.Create("DButton", imagePanel)
    sendpblButton:SetSize(160.125, 49.125)  
    sendpblButton:SetPos(imagePanel:GetWide() / 2, imagePanel:GetTall() / 2)
    sendpblButton:SetText("")

    function sendpblButton:Paint(w,h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(pblbuttonMat)
        surface.DrawTexturedRect(0, 0, w, h)
    end 

    sendpblButton.DoClick = function()
        OpenMissiveFramePublic()
        frame:Close()
    end 

    function imagePanel:PerformLayout()
        closeButton:SetPos(self:GetWide() - 34 , 10)
        sendprvButton:SetPos(self:GetWide() / 2 + 25, self:GetTall() / 2 - 15)
        sendpblButton:SetPos(self:GetWide() / 2 + 25, self:GetTall() / 2 + 50)
    end
end)

function OpenPlayerListFrame() -- Gets the list of all players, simply shows them in a list.
    local frame2 = vgui.Create("DFrame")
    frame2:SetSize(800, 800)
    frame2:Center()
    frame2:SetTitle("")  
    frame2:ShowCloseButton(false) 
    frame2:SetDraggable(false) 
    frame2:MakePopup()
    frame2:SetSizable(false) 

    function frame2:Paint(w, h)
    end

    local imagePanel2 = vgui.Create("DPanel", frame2)
    imagePanel2:Dock(FILL)

    local background2Mat = Material("materials/Background2.png")

    function imagePanel2:Paint(w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(background2Mat)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    local buttonMat = Material("materials/Bouton_ferme.png")

    local closeButton2 = vgui.Create("DButton", imagePanel2)
    closeButton2:SetSize(32, 32)
    closeButton2:SetPos(imagePanel2:GetWide() + 692, 10)
    closeButton2:SetText("")

    function closeButton2:Paint(w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(buttonMat)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    closeButton2.DoClick = function()
        frame2:Close()
    end

    local playerList = vgui.Create("DPanelList", imagePanel2)
    playerList:SetSize(400, 400)  
    playerList:SetPos(200, 350) 
    playerList:EnableVerticalScrollbar(true)
    playerList:SetSpacing(20)

    local players = player.GetAll()

    for _, ply in ipairs(players) do
        local playerButton = vgui.Create("DButton")
        playerButton:SetText(ply:Name())
        playerButton:SetFont("DermaLarge")
        playerButton:SetTextColor(Color(255, 215, 0))
        playerButton:SizeToContents()
        function playerButton:Paint(w, h)
            
        end
        playerButton.DoClick = function()
            frame2:Close()
            OpenMissiveFrame(ply:Name(), ply)
        end
        playerList:AddItem(playerButton)
    end
end

function OpenMissiveFrame(playerName, ply) 
    local frame3 = vgui.Create("DFrame")
    frame3:SetSize(1600, 900)
    frame3:Center()
    frame3:SetTitle("")  
    frame3:ShowCloseButton(false) 
    frame3:SetDraggable(false) 
    frame3:MakePopup()
    frame3:SetSizable(false) 

    function frame3:Paint(w, h)
    end

    local imagePanel3 = vgui.Create("DPanel", frame3)
    imagePanel3:Dock(FILL)

    local background3Mat = Material("materials/e_missive.png")

    function imagePanel3:Paint(w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(background3Mat)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    
    local buttonMat = Material("materials/Bouton_ferme.png")


    local closeButton3 = vgui.Create("DButton", imagePanel3)
    closeButton3:SetSize(32, 32)
    closeButton3:SetPos(imagePanel3:GetWide() + 1480, 10)
    closeButton3:SetText("")

    function closeButton3:Paint(w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(buttonMat)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    closeButton3.DoClick = function()
        frame3:Close()
    end

    local destLabel = vgui.Create("DLabel", imagePanel3)
    destLabel:SetText("Destinataire: " .. playerName)
    destLabel:SetFont("Warsuck")
    destLabel:SetTextColor(Color(0, 0, 0))
    destLabel:SizeToContents()
    destLabel:SetPos(260, 100)

    local textEntry = vgui.Create("DTextEntry", imagePanel3)
    textEntry:SetSize(1200, 500)
    textEntry:SetPos(220, 200)
    textEntry:SetMultiline(true)
    textEntry:SetFont("Warsuck")

    function textEntry:Paint(w, h)
        self:DrawTextEntryText(self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor())
    end 

    local buttonMat = Material("materials/Bouton_Envoyer.png")

    local sendButton = vgui.Create("DButton", imagePanel3)
    sendButton:SetSize(320.25, 98.25)
    sendButton:SetPos(imagePanel3:GetWide() / 2 + 600 , imagePanel3:GetTall() + 700)
    sendButton:SetText("")

    function sendButton:Paint(w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(buttonMat)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    sendButton.DoClick = function()
        local text = textEntry:GetValue()
        net.Start("SendMissive")
        net.WriteEntity(ply)
        net.WriteString(text)
        net.SendToServer()
        frame3:Close()
    end
end


function OpenMissiveFramePublic()
    local frame3 = vgui.Create("DFrame")
    frame3:SetSize(1600, 900)
    frame3:Center()
    frame3:SetTitle("")  
    frame3:ShowCloseButton(false) 
    frame3:SetDraggable(false) 
    frame3:MakePopup()
    frame3:SetSizable(false) 

    function frame3:Paint(w, h)
    end

    local imagePanel3 = vgui.Create("DPanel", frame3)
    imagePanel3:Dock(FILL)

    local background3Mat = Material("materials/e_missive.png")

    function imagePanel3:Paint(w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(background3Mat)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    
    local buttonMat = Material("materials/Bouton_ferme.png")


    local closeButton3 = vgui.Create("DButton", imagePanel3)
    closeButton3:SetSize(32, 32)
    closeButton3:SetPos(imagePanel3:GetWide() + 1480, 10)
    closeButton3:SetText("")

    function closeButton3:Paint(w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(buttonMat)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    closeButton3.DoClick = function()
        frame3:Close()
    end

    local destLabel = vgui.Create("DLabel", imagePanel3)
    destLabel:SetText("Destinataire: Tous")
    destLabel:SetFont("Warsuck")
    destLabel:SetTextColor(Color(0, 0, 0))
    destLabel:SizeToContents()
    destLabel:SetPos(260, 100)

    local textEntry = vgui.Create("DTextEntry", imagePanel3)
    textEntry:SetSize(1200, 500)
    textEntry:SetPos(220, 200)
    textEntry:SetMultiline(true)
    textEntry:SetFont("Warsuck")

    function textEntry:Paint(w, h)
        self:DrawTextEntryText(self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor())
    end 

    local buttonMat = Material("materials/Bouton_Envoyer.png")

    local sendButton = vgui.Create("DButton", imagePanel3)
    sendButton:SetSize(320.25, 98.25)
    sendButton:SetPos(imagePanel3:GetWide() / 2 + 600 , imagePanel3:GetTall() + 700)
    sendButton:SetText("")

    function sendButton:Paint(w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(buttonMat)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    sendButton.DoClick = function()
        local text = textEntry:GetValue()
        net.Start("SendMissivePublic")
        net.WriteString(text)
        net.SendToServer()
        frame3:Close()
    end
end




net.Receive("ReceiveMissiveprv", function()
    local senderName = net.ReadString()
    local message = net.ReadString()
    local ply = LocalPlayer()
    local frame = vgui.Create("DFrame")
    frame:SetSize(300, 300)  -- Small frame to hold the button
    frame:SetPos(10, 10)  -- Top left corner
    frame:SetTitle("")  
    frame:ShowCloseButton(false) 
    frame:SetDraggable(false) 
    frame:SetKeyboardInputEnabled(false) 
    frame:SetMouseInputEnabled(true)
    frame:SetSizable(false) 
    frame:DockPadding(0, 0, 0, 0)
    
    function frame:Paint(w, h)
        -- Transparent frame
    end

    local buttonMat = Material("materials/accepte_missive.png")

    local acceptButton = vgui.Create("DButton", frame)
    acceptButton:Dock(FILL)  -- Make the button fill the entire frame
    acceptButton:SetText("")

    function acceptButton:Paint(w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(buttonMat)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    timer.Create("RemoveFrame", 15, 1, function()
        frame:Close()
        timer.Remove("RemoveFrame")    
    end)

    acceptButton.DoClick = function()
        frame:Close()
        if timer.Exists("RemoveFrame") then timer.Remove("RemoveFrame") end 
        net.Start("ixGiveMissiveItemprv")
        net.WriteString(message)
        net.WriteString(senderName)
        net.SendToServer()
    end
    
end)


net.Receive("ReceiveMissivepbl", function()
    local senderName = net.ReadString()
    local message = net.ReadString()
    local ply = LocalPlayer()
    local frame = vgui.Create("DFrame")
    frame:SetSize(300, 300)  -- Small frame to hold the button
    frame:SetPos(10, 10)  -- Top left corner
    frame:SetTitle("")  
    frame:ShowCloseButton(false) 
    frame:SetDraggable(false) 
    frame:SetKeyboardInputEnabled(false) 
    frame:SetMouseInputEnabled(true)
    frame:SetSizable(false) 
    frame:DockPadding(0, 0, 0, 0)
    
    function frame:Paint(w, h)
        -- Transparent frame
    end

    local buttonMat = Material("materials/accepte_missive.png")

    local acceptButton = vgui.Create("DButton", frame)
    acceptButton:Dock(FILL)  -- Make the button fill the entire frame
    acceptButton:SetText("")

    function acceptButton:Paint(w, h)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(buttonMat)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    timer.Create("RemoveFrame", 15, 1, function()
        frame:Close()
        timer.Remove("RemoveFrame")    
    end)

    acceptButton.DoClick = function()
        frame:Close()
        if timer.Exists("RemoveFrame") then timer.Remove("RemoveFrame") end 
        net.Start("ixGiveMissiveItempbl")
        net.WriteString(message)
        net.WriteString(senderName)
        net.SendToServer()
    end
    
end)