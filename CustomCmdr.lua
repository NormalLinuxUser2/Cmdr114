-- === Load Custom Cmdr safely ===
local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NormalLinuxUser2/Cmdr114/main/CustomCmdr.lua"))()
end)
if not success then
    warn("Failed to load CustomCmdr.lua:", err)
end

-- === True Surface Chams (Stable) ===
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Wait until character exists
local function getCharacter()
    if player.Character and player.Character.Parent then
        return player.Character
    else
        return player.CharacterAdded:Wait()
    end
end

local character = getCharacter()

local baseColor = Color3.fromRGB(170, 0, 255)
local glowSpeed = 3
local chamParts = {}

-- Apply chams to a part
local function applySurfaceCham(part)
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

-- Apply to existing parts
for _, part in ipairs(character:GetDescendants()) do
    applySurfaceCham(part)
end

-- Apply to new parts dynamically
character.DescendantAdded:Connect(function(part)
    applySurfaceCham(part)
end)

-- Animate only cached parts
local t = 0
RunService.RenderStepped:Connect(function(dt)
    t = t + dt * glowSpeed
    local pulse = math.sin(t) * 0.5 + 0.5
    for _, part in ipairs(chamParts) do
        if part and part.Parent then
            local r = baseColor.R * pulse + (1 - pulse) * 0.2
            local g = baseColor.G * pulse + (1 - pulse) * 0.2
            local b = baseColor.B * pulse + (1 - pulse) * 0.2
            part.Color = Color3.new(r, g, b)
        end
    end
end)
