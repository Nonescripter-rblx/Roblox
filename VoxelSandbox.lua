--[[
  Made by NoneScripter
  Voxel Sandbox
  Trolling menu (Place Nuker)
  You can use it on your video as showcase, or anything. Just leave a credit.
]]--

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")

local BlockService = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services")
    :WaitForChild("BlockService"):WaitForChild("RF"):WaitForChild("PlaceBlock")

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local isToggled = false
local isUnderFootToggled = false
local blockPlaceCount = 1

local Window = Rayfield:CreateWindow({
    Name = "Voxel Sandbox",
    LoadingTitle = "Load.",
    LoadingSubtitle = "Nonescripter",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NS_VoxelSandbox",
        FileName = "Config"
    }
})

local MainTab = Window:CreateTab("Main", 4483362458)

local Toggle = MainTab:CreateToggle({
    Name = "Block Placer (Put Red Neon in hand)",
    CurrentValue = false,
    Flag = "BlockToggle",
    Callback = function(Value)
        isToggled = Value
    end,
})

local UnderFootToggle = MainTab:CreateToggle({
    Name = "Scaffold (also Red Neon in hand)",
    CurrentValue = false,
    Flag = "SFToggle",
    Callback = function(Value)
        isUnderFootToggled = Value
    end,
})

local BlockCountSlider = MainTab:CreateSlider({
    Name = "Blocks Per Placement (btw its broken)",
    Range = {1, 20},
    Increment = 1,
    Suffix = "blocks",
    CurrentValue = 1,
    Flag = "BlockCountSlider",
    Callback = function(Value)
        blockPlaceCount = Value
    end,
})

local RejoinButton = MainTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end,
})

task.spawn(function()
    while true do
        if isToggled then
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.CharacterAdded:Wait()
                repeat task.wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            end

            local character = LocalPlayer.Character
            local rootPart = character:FindFirstChild("HumanoidRootPart")

            if rootPart then
                local playerPos = rootPart.Position
                
                for i = 1, blockPlaceCount do
                    local randomOffsetX = math.random(-10, 10)
                    local randomOffsetY = math.random(-3, 3)
                    local randomOffsetZ = math.random(-10, 10)
                    local randomPosition = playerPos + vector.create(randomOffsetX, randomOffsetY, randomOffsetZ)
                    
                    BlockService:InvokeServer("Red Neon", randomPosition)
                end
            end
        end
        task.wait(0.001)
    end
end)

task.spawn(function()
    while true do
        if isUnderFootToggled then
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.CharacterAdded:Wait()
                repeat task.wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            end

            local character = LocalPlayer.Character
            local rootPart = character:FindFirstChild("HumanoidRootPart")

            if rootPart then
                local playerPos = rootPart.Position
                
                for i = 1, blockPlaceCount do
                    local underFootPosition = playerPos - vector.create(0, 3, 0)
                    BlockService:InvokeServer("Red Neon", underFootPosition)
                end
            end
        end
        task.wait(0.001)
    end
end)
