--[[ Made by NoneScripter
     Press V to get Virus, Press C to get Cure.
  ]]

local UIS = game:GetService("UserInputService")
game:GetService("Workspace").AntiWeaponZone:Destroy()
game:GetService("Workspace").HumanOnlyDoor:Destroy()
Game:GetService("ReplicatedStorage").Events.MessageClient:fireServer("Removed AntiWeaponZone and HumanOnlyDoor!")

local function onKeyPress(i, e)
    if not e then
        if i.KeyCode == Enum.KeyCode.V then
            game:GetService("ReplicatedStorage").Events.GiveVirus:FireServer()
        end
        else if i.KeyCode == Enum.KeyCode.C then
            game:GetService("ReplicatedStorage").Events.GiveCure:FireServer()
        end
    end
end

UIS.InputBegan:Connect(onKeyPress)
Game:GetService("ReplicatedStorage").Events.MessageClient:fireServer("Press V to get Virus, Press C to get Cure")
