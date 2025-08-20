-- Purple Chams with Texture Replacement
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Cham settings
local baseColor = Color3.fromRGB(170, 0, 255)
local glowSpeed = 2

-- Function to apply cham texture via SurfaceAppearance
local function applyCham(part)
    if part:IsA("BasePart") then
        -- Remove existing SurfaceAppearance
        for _, sa in ipairs(part:GetChildren()) do
            if sa:IsA("SurfaceAppearance") then
                sa:Destroy()
            end
        end

        local surfaceAppearance = Instance.new("SurfaceAppearance")
        surfaceAppearance.Parent = part
        surfaceAppearance.ColorMap = nil -- optional custom texture
        surfaceAppearance.Metalness = 0
        surfaceAppearance.Roughness = 0.2
        surfaceAppearance.StudsPerTileU = 1
        surfaceAppearance.StudsPerTileV = 1
        part.Color = baseColor
        part.Material = Enum.Material.Neon
    end
end

-- Animate glow
local t = 0
RunService.RenderStepped:Connect(function(dt)
    t = t + dt * glowSpeed
    local pulse = math.sin(t) * 0.3 + 0.7
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.Material == Enum.Material.Neon then
            local r = baseColor.R * pulse
            local g = baseColor.G * pulse
            local b = baseColor.B * pulse
            part.Color = Color3.new(r, g, b)
        end
    end
end)

-- Apply to all existing parts
for _, part in ipairs(character:GetDescendants()) do
    applyCham(part)
end

-- Apply to new parts
character.DescendantAdded:Connect(function(part)
    applyCham(part)
end)
