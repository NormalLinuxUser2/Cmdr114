--[[
    Custom Cmdr + True Surface Chams
    Load with: loadstring(game:HttpGet("YOUR_RAW_GITHUB_LINK"))()
--]]

-- === Load Custom Cmdr ===
loadstring(game:HttpGet("https://raw.githubusercontent.com/NormalLinuxUser2/Cmdr114/main/CustomCmdr.lua"))()

-- === True Surface Chams ===
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Cham settings
local baseColor = Color3.fromRGB(170, 0, 255)
local glowSpeed = 3

-- Function to apply chams to a part surface
local function applySurfaceCham(part)
    if part:IsA("BasePart") then
        -- Replace material with Neon for true surface glow
        part.Material = Enum.Material.Neon
        part.Color = baseColor
        -- Remove decals/textures to ensure purple cham shows
        for _, child in ipairs(part:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                child:Destroy()
            end
        end
    end
end

-- Apply chams to all current character parts
for _, part in ipairs(character:GetDescendants()) do
    applySurfaceCham(part)
end

-- Apply chams to new parts dynamically
character.DescendantAdded:Connect(function(part)
    applySurfaceCham(part)
end)

-- Animate the surface color for a moving cham effect
local t = 0
RunService.RenderStepped:Connect(function(dt)
    t = t + dt * glowSpeed
    local pulse = math.sin(t) * 0.5 + 0.5 -- 0 to 1
    local r = baseColor.R * pulse + (1 - pulse) * 0.2
    local g = baseColor.G * pulse + (1 - pulse) * 0.2
    local b = baseColor.B * pulse + (1 - pulse) * 0.2
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.Material == Enum.Material.Neon then
            part.Color = Color3.new(r, g, b)
        end
    end
end)
