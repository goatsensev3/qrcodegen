birchregion = nil
movebirch = true
newbirch = game.Workspace
mainuser = "not_pyalt"
function newpart(part)
    if part.Name == "Loose_Birch" then
        if tostring(part:WaitForChild("Owner").Value) == game.Players.LocalPlayer.Name then
            print("new part - " .. part.Name)
            newbirch = part
            if movebirch == true then
                if #part:GetChildren() == 6 then
                    for i = 1,50 do
                        task.wait()
                        game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(part)
                    end
                    part:FindFirstChild("WoodSection").CFrame = selectedsawmill.Particles.CFrame
                else
                    print(#part:GetChildren())
                end
            end
        end
    end
end

game.Workspace:WaitForChild("LogModels").ChildAdded:Connect(newpart)


for _, sawmill in ipairs(workspace.PlayerModels:GetChildren()) do
    if sawmill.Name == "Model" then
        if sawmill:FindFirstChild("Owner") then
            if tostring(sawmill:FindFirstChild("Owner").Value) == game.Players.LocalPlayer.Name then
                if sawmill.ItemName.Value == "Sawmill" then
                    selectedsawmill = sawmill
                end
            end
        end
    end
end

for _, region in ipairs(workspace:GetChildren()) do
    if region.Name == "TreeRegion" then
        for _, tree in ipairs(region:GetChildren()) do
            if tree:FindFirstChild("TreeClass") then
                if tree:FindFirstChild("TreeClass").Value == "Birch" then
                    birchregion = region
                    break
                end
            end
        end
    end
end
function getBestAxeNoRequire(hasAxe)
    Player = game.Players.LocalPlayer
    BestCooldown, BestAxe, BestValue = 0, nil, 0

    local Hitpoints = { ["BasicHatchet"] = 0.2, ["EndTimesAxe"] = 1.58, ["IceAxe"] = 0.36, ["CandyCornAxe"] = 1.75, ["CaveAxe"] = 0.4, ["RustyAxe"] = 0.55, ["AxeTwitter"] = 1.65, ["ManyAxe"] = 10.2, ["GingerbreadAxe"] = 1.2, ["AxeAmber"] = 3.39,  ["Beesaxe"] = 1.4, ['Axe1'] = 0.55, ['Axe2'] = 0.93, ['Axe3'] = 1.45, ["CandyCaneAxe"] = 0, ["AxeChicken"] = 0.9, ["AxeSwamp"] = 0.8, ["SilverAxe"] = 1.6,  ["FireAxe"] = 0.6, ["AxeBetaTesters"] = 1.45, ["Rukiryaxe"] = 1.68, ["AxeAlphaTesters"] = 1.5, ["BluesteelAxe"] = 2.8,}

    local Axes = {"BasicHatchet", "EndTimesAxe", "IceAxe", "CandyCornAxe", "CaveAxe", "RustyAxe", "AxeTwitter", "ManyAxe", "GingerbreadAxe", "AxeAmber", "Beesaxe", "Axe1", "Axe2", "Axe3", "CandyCaneAxe", "AxeChicken", "AxeSwamp", "SilverAxe", "FireAxe", "AxeBetaTesters", "Rukiryaxe", "AxeAlphaTesters", "BluesteelAxe", }

    local Cooldown = { ["BasicHatchet"] = 0.65, ["EndTimesAxe"] = 0.4, ["CandyCornAxe"] = 0.6, ["IceAxe"] = 0.4, ["CaveAxe"] = 0.4, ["RustyAxe"] = 0.4, ["AxeTwitter"] = 0.4, ["ManyAxe"] = 1.9, ["GingerbreadAxe"] = 0.5, ["AxeAmber"] = 1, ["Beesaxe"] = 0.5, ['Axe1'] = 0.55, ['Axe2'] = 0.93, ['Axe3'] = 1.45, ["CandyCaneAxe"] = 0.7, ["AxeChicken"] = 0.3, ["AxeSwamp"] = 0.55, ["SilverAxe"] = 0.48, ["FireAxe"] = 0.55, ["AxeBetaTesters"] = 0.54, ["Rukiryaxe"] = 0.4, ["AxeAlphaTesters"] = 0.5, ["BluesteelAxe"] = 0.8, }

    local foundAxe = false

    for i, v in pairs(Player.Backpack:GetChildren()) do
        if v:FindFirstChild("ToolName") and table.find(Axes, tostring(v.ToolName.Value)) then
            foundAxe = true
            if Hitpoints[tostring(v.ToolName.Value)] > BestValue then
                BestValue = Hitpoints[tostring(v.ToolName.Value)]
                BestAxe = v
                BestCooldown = Cooldown[tostring(v.ToolName.Value)]
            end
        end
    end

    if Player.Character:FindFirstChildOfClass("Tool") then
        local axe = Player.Character:FindFirstChildOfClass("Tool")
        if axe:FindFirstChild("ToolName") and table.find(Axes, tostring(axe.ToolName.Value)) then
            foundAxe = true
            if Hitpoints[tostring(axe.ToolName.Value)] > BestValue then
                BestValue = Hitpoints[tostring(axe.ToolName.Value)]
                BestAxe = axe
                BestCooldown = Cooldown[tostring(axe.ToolName.Value)]
            end
        end
    end
    if hasAxe then
        if Player.Character:FindFirstChild("Tool") then
            Player.Character.Humanoid:UnequipTools()
        end
        for i, v in pairs(Player.Backpack:GetChildren()) do
            if v:FindFirstChild("ToolName") and v.ToolName.Value == hasAxe then
                return true
            end
        end
    end

    return { BestAxe, BestCooldown, BestValue }
end


function getwood()
    for _, tree in ipairs(birchregion:GetChildren()) do
        if tree:FindFirstChild("TreeClass").Value == "Birch" then
            if #tree:GetChildren() >= 8 then
                for _, section in tree:GetChildren() do
                    if section.Name == "WoodSection" then
                        if section.ID.Value == 1 then
                            local humanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if not humanoidRootPart then
                                -- Handle missing HumanoidRootPart error
                                return nil
                            end
                            humanoidRootPart.CFrame = CFrame.new(section.Position) * CFrame.new(5, 0, 0)
                            break
                        end
                    end
                end

                -- Ensure we have a valid axe
                local best = getBestAxeNoRequire()

                -- Ensure CutEvent exists
                if not tree:FindFirstChild("CutEvent") then
                    print("no event cuzzy")
                    return nil
                end

                -- Prepare arguments for the action
                local args = {
                    [1] = tree.CutEvent,
                    [2] = {
                        ["tool"] = best[1],
                        ["faceVector"] = Vector3.new(-1, 0, 0),
                        ["height"] = 0.7449536323547363,
                        ["sectionId"] = 1,
                        ["hitPoints"] = best[3],
                        ["cooldown"] = best[2],
                        ["cuttingClass"] = "Axe"
                    }
                }

                local timeout = tick() + 30  -- 10-second timeout
                while not tree:FindFirstChild("InnerWood") do
                    if tick() > timeout then
                        return tree
                    end
                    game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(unpack(args))
                    task.wait(0.01)
                end
                task.wait(0.1)
                return newbirch
            end
        end
    end
end
function get1x1()
    tree = getwood()
    if tree == nil then
        print("nil")
    else
        print("tree found!" .. tree.Name)
    end

    -- Iterate over sections in the tree
    function collectParts(model)
        local partsList = {}
        for _, child in ipairs(model:GetChildren()) do
            local idValue = child:FindFirstChild("ID")
            local childIDsValue = child:FindFirstChild("ChildIDs")
            if child.Name == "WoodSection" then
                if childIDsValue then
                    if #childIDsValue:GetChildren() ~= 0 then
                        table.insert(partsList, {part = child, id = idValue.Value})
                    end
                end
            end
        end
        table.sort(partsList, function(a, b) return a.id > b.id end)
        -- Return only the parts, not wrapped in an additional table
        local sortedParts = {}
        for _, item in ipairs(partsList) do
            table.insert(sortedParts, item.part)
        end
        return sortedParts
    end
    for _, section in ipairs(collectParts(tree)) do
        startcolour = section.Color
        print(section.Name .. section.ID.Value)
        section.Color = Color3.fromRGB(0, 255, 0) 
        local best = getBestAxeNoRequire()
        print(section.Size.Y)
        args = {
            [1] = section.Parent.CutEvent,
            [2] = {
                ["tool"] = best[1],
                ["faceVector"] = Vector3.new(-1, 0, 0),
                ["height"] = section.Size.Y,
                ["sectionId"] = section.ID.Value,
                ["hitPoints"] = best[3],
                ["cooldown"] = best[2],
                ["cuttingClass"] = "Axe"
            }
        }
        oldbirch = newbirch
        while oldbirch == newbirch do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(section.Position) * CFrame.new(5, 4, 0)
            game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(unpack(args))
            task.wait(0.001)
        end
        section.Color = startcolour
        task.wait(0.1)
    end
end
get1x1()



