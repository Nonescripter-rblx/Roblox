--[[
  Made by NoneScripter
  Find the Difficulty Faces
  You can use it on your video as showcase, or anything. Just leave a credit.
]]--


local difficulties = workspace:FindFirstChild("Difficulties")

if difficulties then
  for _, part in ipairs(difficulties:GetChildren()) do
    if part:IsA("BasePart") then
      for _, gui in ipairs(part:GetChildren()) do
        if gui:IsA("BillboardGui") then
          gui.AlwaysOnTop = true
        end
      end
    end
    wait(0.02)
  end
end
