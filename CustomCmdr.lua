-- === R6 True Surface Chams ===
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Wait for character to load
local character = player.Character or player.CharacterAdded:Wait()
character:WaitForChild("HumanoidRootPart")

local baseColor = Color3.fromRGB(170, 0, 255)
local glowSpeed = 2
local chamParts = {}

-- Only R6 BaseParts
local r6Parts = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}

-- Apply chams to a part
local function applyCham(part)
    if part:IsA("BasePart") or part:IsA("MeshPart") then
        part.Material = Enum.Material.Neon
        part.Color = baseColor
        -- Remove decals/textures
        for _, child in ipairs(part:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                child:Destroy()
            end
        end
        table.insert(chamParts, part)
    end
end

-- Apply chams to R6 BaseParts
for _, partName in ipairs(r6Parts) do
    local part = character:FindFirstChild(partName)
    if part then
        applyCham(part)
    end
end

-- Handle dynamic MeshPart accessories
character.DescendantAdded:Connect(function(part)
    if part:IsA("MeshPart") then
        applyCham(part)
    end
end)

-- Animate cached parts (pulse effect)
local t = 0
RunService.Heartbeat:Connect(function(dt)
    t = t + dt * glowSpeed
    local pulse = math.sin(t) * 0.5 + 0.5
    for i = 1, #chamParts do
        local part = chamParts[i]
        if part and part.Parent then
            local r = baseColor.R * pulse + (1 - pulse) * 0.2
            local g = baseColor.G * pulse + (1 - pulse) * 0.2
            local b = baseColor.B * pulse + (1 - pulse) * 0.2
            part.Color = Color3.new(r, g, b)
        end
    end
end)
