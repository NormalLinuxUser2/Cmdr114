--[[
    Purple Material Chams with Glow Animation
    LocalPlayer Only
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Settings
local baseColor = Color3.fromRGB(170, 0, 255)
local glowSpeed = 2       -- animation speed
local glowIntensity = 0.7 -- max brightness

-- Function to apply cham material
local function applyCham(part)
    if part:IsA("BasePart") then
        part.Material = Enum.Material.Neon
        part.Color = baseColor
    end
end

-- Animate the glow
local t = 0
RunService.RenderStepped:Connect(function(dt)
    t = t + dt * glowSpeed
    local pulse = (math.sin(t) * 0.5 + 0.5) * glowIntensity
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.Material == Enum.Material.Neon then
            local r = baseColor.R + pulse * (1 - baseColor.R)
            local g = baseColor.G + pulse * (1 - baseColor.G)
            local b = baseColor.B + pulse * (1 - baseColor.B)
            part.Color = Color3.new(r, g, b)
        end
    end
end)

-- Apply to all current parts
for _, part in ipairs(character:GetDescendants()) do
    applyCham(part)
end

-- Apply to new parts dynamically
character.DescendantAdded:Connect(function(part)
    applyCham(part)
end)
