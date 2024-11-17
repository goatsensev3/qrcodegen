birchregion = nil
movebirch = true
newbirch = game.Workspace
newplank = game.Workspace
mainuser = "shatty_dev"
tosawmill = {}

for _, sawmill in ipairs(workspace.PlayerModels:GetChildren()) do
    if sawmill.Name == "Sawmill" or sawmill.Name == "Model" then
        if sawmill:FindFirstChild("Owner") then
            if tostring(sawmill:FindFirstChild("Owner").Value) == game.Players.LocalPlayer.Name then
                if sawmill.ItemName.Value == "Sawmill" then
                    selectedsawmill = sawmill
                    break
                end
            end
        end
    end
end
print(selectedsawmill)

function newpart(part)
    if part.Name == "Loose_Birch" then
        if tostring(part:WaitForChild("Owner").Value) == game.Players.LocalPlayer.Name then
            print("new part - " .. part.Name)
            newbirch = part
            if movebirch == true then
                local count = 0
                for _, i in ipairs(part:GetChildren()) do
                    if i.Name == "WoodSection" then
                        count += 1
                    end
                end
                if count == 1 then
                    table.insert(tosawmill, part)
                end
            end
        end
    end
    if part.Name == "Plank" then
        if tostring(part:WaitForChild("Owner").Value) == game.Players.LocalPlayer.Name then
            newplank = part
        end
    end
end

game.Workspace:WaitForChild("LogModels").ChildAdded:Connect(newpart)




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


function chop1x1(wood)
    local best = getBestAxeNoRequire()

    local args = {
        [1] = wood.CutEvent,
        [2] = {
            ["tool"] = best[1],
            ["faceVector"] = Vector3.new(-1, 0, 0),
            ["height"] = 1,
            ["sectionId"] = 1,
            ["hitPoints"] = best[3],
            ["cooldown"] = best[2],
            ["cuttingClass"] = "Axe"
        }
    }
    while not wood:FindFirstChild("Cut") do
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(wood:FindFirstChild("WoodSection").Position)*CFrame.new(0, 4, 4)
        game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(unpack(args))
        task.wait(0.01)
    end
    while wood:FindFirstChild("Cut") do
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(wood:FindFirstChild("WoodSection").Position)*CFrame.new(0, 4, 4)
        game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(unpack(args))
        task.wait(0.01)
    end
    return wood
end

function getwood()
    for _, tree in ipairs(birchregion:GetChildren()) do
        if tree:FindFirstChild("TreeClass") then
            if tree:FindFirstChild("TreeClass").Value == "Birch" then
                if #tree:GetChildren() >= 8 then
                    for _, section in tree:GetChildren() do
                        if section.Name == "WoodSection" then
                            if section.ID.Value == 1 then
                                local humanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
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
end
function getplank()
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
    end

    for _, part in pairs(tosawmill) do
        print("-- " .. part.Name)
        print(part.Parent)
    end
    for _, part in pairs(tosawmill) do
        print(part.Name)
        part:FindFirstChild("WoodSection").Color = Color3.fromRGB(0, 255, 0) 
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(part:FindFirstChild("WoodSection").Position) * CFrame.new(5, 4, 0)
        for i = 1,50 do
            task.wait()
            game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(part)
            part:FindFirstChild("WoodSection").CFrame = selectedsawmill.Particles.CFrame + Vector3.new(0, .5, 0)
        end
        task.wait(0.25)
        print("moved")
    end
    tosawmill = {}
    task.wait(0.25)
    tree:FindFirstChild("WoodSection").Color = Color3.fromRGB(0, 255, 0) 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(tree:FindFirstChild("WoodSection").Position) * CFrame.new(5, 4, 0)
    for i = 1,50 do
        task.wait()
        game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(tree)
        tree:FindFirstChild("WoodSection").CFrame = selectedsawmill.Particles.CFrame + Vector3.new(0, .5, 0)
    end
    task.wait(0.1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = selectedsawmill.PrimaryPart.CFrame*CFrame.new(0,10,0)

end

function find1x1()
    for _, wood in ipairs(workspace.PlayerModels:GetChildren()) do
        if wood.Name == "Plank" then
            if wood:FindFirstChild("Owner") then
                if tostring(wood:FindFirstChild("Owner").Value) == game.Players.LocalPlayer.Name then
                    if wood:FindFirstChild("TreeClass") then
                        if wood:FindFirstChild("TreeClass").Value == "Birch" then
                            if wood.WoodSection.Size.Y >= 1 and wood.WoodSection.Size.Y < 2 then
                                return wood
                            end
                            if wood.WoodSection.Size.Y >= 2 then
                                print("chop chop")
                                return chop1x1(wood)
                            end
                        end
                    end
                end
            end
        end
    end
    getplank()
    return find1x1()
end

function fill1()
    for _, i in ipairs(game.Workspace:WaitForChild("PlayerModels"):GetChildren()) do
        if i.Name == "Post" then
            if i.BuildDependentWood.Color ~= Color3.fromRGB(205, 205, 205) then
                if tostring(i:WaitForChild("Owner").Value) == mainuser then
                    plank = find1x1()
                    if plank == nil then
                        print("uh nul")
                    else
                        print(plank.Name)
                        print(plank.WoodSection.Size.Y)
                        plank:FindFirstChild("WoodSection").Color = Color3.fromRGB(0, 0, 255) 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(plank:FindFirstChild("WoodSection").Position) * CFrame.new(0, 4, 4)
                        for v = 1,50 do
                            task.wait()
                            game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(plank)
                            if i:FindFirstChild("BuildDependentWood") and plank:FindFirstChild("WoodSection") then
                                plank:FindFirstChild("WoodSection").CFrame = i.BuildDependentWood.CFrame
                            end
                        end
                    end
                    break
                end
            end
        end
    end
end

while true do
    fill1()
    task.wait(0.05)
end
