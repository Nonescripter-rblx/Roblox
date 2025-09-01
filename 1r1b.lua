--[[
  Made by NoneScripter
  1 robucc = 1 blocc
  Block Spawner
]]--

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "1 robucc = 1 blocc",
    LoadingTitle = "Load.",
    LoadingSubtitle = "Nonescripter",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = nil
    },
    Discord = {
        Enabled = false,
        Invite = nil,
        RememberJoins = false
    },
    KeySystem = false
})

local Tab = Window:CreateTab("Main", 4483362458)

local repeatCount = 1

Tab:CreateInput({
    Name = "Repeat Count",
    PlaceholderText = "Enter number",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local value = tonumber(Text)
        if value then
            repeatCount = value
            if value > 500 then
                Rayfield:Notify({
                    Title = "OMG WTF",
                    Content = "Bro thats Wild ☠️",
                    Duration = 3,
                    Image = 4483362458
                })
            end
        end
    end,
})

Tab:CreateButton({
    Name = "Blast!",
    Callback = function()
        local freePads = {}
        
        local function findFreePads(parent)
            for _, child in pairs(parent:GetChildren()) do
                if child.Name == "FreePad" then
                    table.insert(freePads, child)
                end
                
                findFreePads(child)
            end
        end
        
        findFreePads(game.Workspace)
        
        Rayfield:Notify({
            Title = "Found Part",
            Content = "Total of " .. #freePads .. "Parts.",
            Duration = 3,
            Image = 4483362458
        })
        
        local totalSuccessCount = 0
        
        for i = 1, repeatCount do
            local successCount = 0
            for _, pad in ipairs(freePads) do
                local spawnRequest = pad:FindFirstChild("F2PSpawnRequest")
                if spawnRequest then
                    spawnRequest:FireServer()
                    successCount = successCount + 1
                else
                    local success, result = pcall(function()
                        local request = pad:WaitForChild("F2PSpawnRequest", 2)
                        if request then
                            request:FireServer()
                            return true
                        end
                        return false
                    end)
                    
                    if success and result then
                        successCount = successCount + 1
                    end
                end
            end
            
            totalSuccessCount = totalSuccessCount + successCount
        
            if i < repeatCount then
                wait(0.01)
            end
        end
        
        Rayfield:Notify({
            Title = "Done!",
            Content = "Done " .. repeatCount .. " times and sent " .. totalSuccessCount .. "signal.",
            Duration = 5,
            Image = 4483362458
        })
    end,
})

Tab:CreateSection("Help")
Tab:CreateParagraph({
    Title = "How to use",
    Content = "1. Enter Repeat Count.\n2. Click on 'Blast!'.\n3. Boom!"
})

-- this one is best script