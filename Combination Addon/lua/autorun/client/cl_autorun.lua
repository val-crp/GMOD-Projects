if CLIENT then
    local frameCreated = false
    local frame2Created = false 
    hook.Add("Think", "GUIEditThink", function()
        if input.IsKeyDown(KEY_PERIOD) and not frameCreated then -- If the player presses ., open the config
            frameCreated = true

            local frame = vgui.Create("DFrame")
            frame:Center()
            frame:SetSize(400, 300)
            frame:SetTitle("Combination edits")
            frame:SetMouseInputEnabled(true)
            frame:SetKeyboardInputEnabled(true)
            local listView = vgui.Create("DListView", frame)
            listView:Dock(FILL)
            listView:SetMultiSelect(false)
            listView:AddColumn("Combination")  

            local filePath = "combinations.txt"
            if file.Exists(filePath, "DATA") then
                local fileData = file.Read(filePath, "DATA")
                local lines = string.Split(fileData, "\n")
                for _, line in ipairs(lines) do
                    line = string.Trim(line)
                    if line ~= "" then
                        listView:AddLine(line)
                    end
                end
            else
                listView:AddLine("File not found.")
            end

            frame.OnClose = function()
                frameCreated = false
            end
        elseif input.IsKeyDown(KEY_SLASH) and not frame2Created then  -- If the player presses /, open the combination adding menu.
            frame2Created = true 

            local editFrame = vgui.Create("DFrame")
            editFrame:Center()
            editFrame:SetSize(300, 150)
            editFrame:SetTitle("Add Combination")
            editFrame:SetDraggable(true)
            editFrame:SetSizable(true)
            editFrame:SetMouseInputEnabled(true)
            editFrame:SetKeyboardInputEnabled(true)

            local npc1Entry = vgui.Create("DTextEntry", editFrame)
            npc1Entry:SetPos(10, 40)
            npc1Entry:SetSize(80, 20)
            npc1Entry:SetPlaceholderText("NPC 1")

            local plusLabel = vgui.Create("DLabel", editFrame)
            plusLabel:SetText("+")
            plusLabel:SetPos(95, 40)
            plusLabel:SizeToContents()

            local npc2Entry = vgui.Create("DTextEntry", editFrame)
            npc2Entry:SetPos(110, 40)
            npc2Entry:SetSize(80, 20)
            npc2Entry:SetPlaceholderText("NPC 2")

            local equalsLabel = vgui.Create("DLabel", editFrame)
            equalsLabel:SetText("=")
            equalsLabel:SetPos(195, 40)
            equalsLabel:SizeToContents()

            local resultEntry = vgui.Create("DTextEntry", editFrame)
            resultEntry:SetPos(210, 40)
            resultEntry:SetSize(80, 20)
            resultEntry:SetPlaceholderText("Result")

            npc1Entry:SetMouseInputEnabled(true)
            npc2Entry:SetMouseInputEnabled(true)
            resultEntry:SetMouseInputEnabled(true)

            local confirmButton = vgui.Create("DButton", editFrame)
            confirmButton:SetText("Confirm")
            confirmButton:SetPos(10, 80)
            confirmButton:SetSize(260, 30)
            confirmButton.DoClick = function()
                local npc1 = npc1Entry:GetValue()
                local npc2 = npc2Entry:GetValue()
                local result = resultEntry:GetValue()

                if npc1 ~= "" and npc2 ~= "" and result ~= "" then
                    local newLine =  "\n" .. npc1 .. "+" .. npc2 .. "=" .. result .. "\n"
                    file.Append("combinations.txt", newLine)
                    print("Added combination:", newLine)

                    if listView then
                        listView:AddLine(newLine)
                    end
                end

                editFrame:Close()
            end

            editFrame.OnClose = function()
                frame2Created = false
            end

            editFrame.OnMousePressed = function(_, code)
                if code == MOUSE_LEFT then
                    editFrame:MakePopup()
                end
            end

        end
    end)
end