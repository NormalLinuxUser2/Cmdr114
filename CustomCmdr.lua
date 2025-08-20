-- True Surface Chams (Crash-Proof)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
character:WaitForChild("HumanoidRootPart")

local baseColor = Color3.fromRGB(170, 0, 255)
local glowSpeed = 2

-- Cache valid parts
local chamParts = {}
for _, part in ipairs(character:GetDescendants()) do
    if part:IsA("BasePart") then
        part.Material = Enum.Material.Neon
        part.Color = baseColor
        for _, child in ipairs(part:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                child:Destroy()
            end
        end
        table.insert(chamParts, part)
    end
end

-- Handle new parts dynamically
character.DescendantAdded:Connect(function(part)
