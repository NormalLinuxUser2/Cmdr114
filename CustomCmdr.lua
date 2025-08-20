-- === True Surface Chams for ALL character parts ===
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Wait until character is fully loaded
local character = player.Character or player.CharacterAdded:Wait()
character:WaitForChild("HumanoidRootPart")

local baseColor = Color3.fromRGB(170, 0, 255)
local glowSpeed = 2
local chamParts = {}

-- Function to apply cham to BasePart or MeshPart
local function applyChamToPart(part)
    if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Parent then
        part.Material = Enum.Material.Neon
        part.Color = baseColor
        -- Remove decals/textures to ensure pure cham
        for _, child in ipairs(part:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                child:Destroy()
            end
        end
        table.insert(chamParts, part)
    end
end

-- Apply chams to all current descendants
for _, part in ipairs(character:GetDescendants()) do
    applyChamToPart(part)
end

-- Apply chams to new parts added dynamically
character.DescendantAdded:Connect(function(part)
    applyChamToPart(part)
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
