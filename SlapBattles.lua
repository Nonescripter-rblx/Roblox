local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
    Title = "SB",
    Text = "Loaded.",
    Duration = 5,
})

local player = game.Players.LocalPlayer

local function runToolScript(tool)
    if not tool then return end
    
    spawn(function()
        while tool and tool.Parent do
            local localscript = tool:FindFirstChildOfClass("LocalScript")
            if localscript then
                local localscriptclone = localscript:Clone()
                localscript:Destroy()
                localscriptclone.Parent = tool
            end
            wait(0.1)
        end
    end)
end

local function handleCharacter(character)
    if not character then return end
    
    local tool = character:FindFirstChildOfClass("Tool")
    if tool then
        runToolScript(tool)
    end
    
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        tool = backpack:FindFirstChildOfClass("Tool")
        if tool then
            runToolScript(tool)
        end
        
        backpack.ChildAdded:Connect(function(item)
            if item:IsA("Tool") then
                runToolScript(item)
            end
        end)
    end
    
    character.ChildAdded:Connect(function(item)
        if item:IsA("Tool") then
            runToolScript(item)
        end
    end)
end

if player.Character then
    handleCharacter(player.Character)
end

player.CharacterAdded:Connect(handleCharacter)