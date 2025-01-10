local npcCombinations = {} -- Initialize the NPC Combinations

local function LoadNPCCombinations() -- Function to read the text file and place all the combinations into the table
    local filePath = "combinations.txt"
    if file.Exists(filePath, "DATA") then -- Make sure it exists
        local fileData = file.Read(filePath, "DATA")
        if fileData then
            local lines = string.Split(fileData, "\n")
            for _, line in ipairs(lines) do
                line = string.Trim(line)
                if line ~= "" then
                    -- Split the line into parts: npc1 + npc2 = result
                    local parts = string.Split(line, "=")
                    if #parts == 2 then
                        local npcs = string.Trim(parts[1])
                        local resultClass = string.Trim(parts[2])
                        local npcPair = string.Split(npcs, "+")
                        if #npcPair == 2 then
                            local npc1 = string.Trim(npcPair[1])
                            local npc2 = string.Trim(npcPair[2])
                            -- Store the combination in the npcCombinations table, essentially loading the combinations to check later.
                            npcCombinations[npc1 .. "+" .. npc2] = resultClass
                        end
                    end
                end
            end
        else
            print("Failed to read file data.")
        end
    else
        print("File not found in garrysmod/data:", filePath)
    end
end

LoadNPCCombinations()



local function CheckNPCProximity() -- Checks happen every 4 seconds, to ensure preformance isnt affected.
    local npcs = {}
    for _,ent in ents.Iterator() do 
        table.insert(npcs,ent)

    end 
    
    

    for i = 1, #npcs do     -- Loop through all NPCs to check for proximity
        local npc1 = npcs[i]
        
        for j = i + 1, #npcs do
            local npc2 = npcs[j]
            if not npc1:GetClass() or not npc2:GetClass() then return end 

            if IsValid(npc1) and IsValid(npc2) then             -- Check if both entities are valid 
                local distance = npc1:GetPos():Distance(npc2:GetPos())
                
                local touchDistance = 10 -- Can be modified if need be
                
                if distance < touchDistance then
                    local key1 = npc1:GetClass() .. "+" .. npc2:GetClass()
                    local key2 = npc2:GetClass() .. "+" .. npc1:GetClass()
                    local resultClass = npcCombinations[key1] or npcCombinations[key2]

                    if resultClass then
                        local spawnPos = npc2:GetPos()
                        if SERVER then
                            local effectData = EffectData() -- Spawn an explosion effect, removing the NPCs.
                            effectData:SetOrigin(spawnPos)
                            util.Effect("Explosion", effectData)
                            npc1:Remove()
                            npc2:Remove()
                            timer.Simple(0.1, function() 
                                local newEnt = ents.Create(resultClass)
                                if IsValid(newEnt) then
                                    newEnt:SetPos(spawnPos + Vector(10, 0, 10))
                                    newEnt:Spawn()
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
end
timer.Create("CheckNPCProximityTimer", 4, 0, CheckNPCProximity)


