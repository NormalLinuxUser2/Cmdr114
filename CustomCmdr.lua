-- === Executor-safe load of CustomCmdr.lua ===
local url = "https://raw.githubusercontent.com/NormalLinuxUser2/Cmdr114/main/CustomCmdr.lua"
local success, err = pcall(function()
    local scriptText = game:HttpGetAsync(url)
    local f = loadstring or load
    if f then
        f(scriptText)()
    else
        warn("Executor does not support loadstring/load.")
    end
end)
if not success then
    warn("Failed to load CustomCmdr.lua:", err)
end

-- === True Surface Chams (Crash-Proof) ===
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Wait until character is fully loaded
local character = player.Character or player.CharacterAdded:Wait()
character:WaitForChild("HumanoidRootPart")

local baseColor = Color3.fromRGB(170, 0, 255)
local glowSpeed = 2
local chamParts = {}

-- Function to apply chams to a part
local function applySurfaceCham(part)
    if part:IsA("BasePart") and part.Parent then
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

-- Apply to all existing parts
for _, part in ipairs(character:GetDescendants()) do
    applySurfaceCham(part)
end

-- Apply to new parts dynamically
character.DescendantAdded:Connect(function(part)
    applySurfaceCham(part)
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
