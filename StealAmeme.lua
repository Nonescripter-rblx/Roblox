--[[
  Made by NoneScripter
  Steal A Meme (by InterLocked Productions)
  Instant Lock
  You can use it on your video as showcase, or anything. Just leave a credit.
]]--

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local currentTeleportLoopThread = nil

local function startTeleportation(targetPart, baseNum)
    if currentTeleportLoopThread then
        task.cancel(currentTeleportLoopThread)
        currentTeleportLoopThread = nil
    end

    local attachmentsDeleted = 0
    for _, child in ipairs(targetPart:GetChildren()) do
        if child:IsA("Attachment") then
            child:Destroy()
            attachmentsDeleted = attachmentsDeleted + 1
        end
    end

    targetPart.CanCollide = false
    targetPart.Transparency = 1

    currentTeleportLoopThread = task.spawn(function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        while task.wait(0.2) do
            if not targetPart.Parent or not humanoidRootPart.Parent then
                break
            end
            
            targetPart.Size = humanoidRootPart.Size
            targetPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 2, 0)
        end
    end)
end

local function findClosestBaseAndLockButton()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local playerPosition = character:WaitForChild("HumanoidRootPart").Position

    local closestBaseNum = nil
    local closestLockButton = nil
    local minDistance = math.huge

    local basesFolder = Workspace:FindFirstChild("Bases")
    if not basesFolder then
        return nil, nil
    end

    for _, baseChild in ipairs(basesFolder:GetChildren()) do
        local baseName = baseChild.Name
        if baseName:len() > 4 and baseName:sub(1, 4) == "Base" then
            local numString = baseName:sub(5)
            local baseNum = tonumber(numString)

            if baseNum then
                local componentsFolder = baseChild:FindFirstChild("Components")
                if componentsFolder then
                    local lockButton = componentsFolder:FindFirstChild("LockButton")
                    if lockButton and lockButton:IsA("BasePart") then
                        local distance = (lockButton.Position - playerPosition).Magnitude

                        if distance < minDistance then
                            minDistance = distance
                            closestBaseNum = baseNum
                            closestLockButton = lockButton
                        end
                    end
                end
            end
        end
    end

    if closestBaseNum then
        return closestBaseNum, closestLockButton
    else
        return nil, nil
    end
end

local function initializeTeleportation()
    local baseNum, lockButton = findClosestBaseAndLockButton()
    if lockButton and baseNum then
        startTeleportation(lockButton, baseNum)
    else
    end
end

LocalPlayer.CharacterAdded:Connect(function(character)
    initializeTeleportation()
end)

if LocalPlayer.Character then
    initializeTeleportation()
end
