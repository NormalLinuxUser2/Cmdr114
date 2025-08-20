-- === Executor-safe GitHub loadstring with R6 chams ===
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Force fresh fetch from GitHub to bypass cache
local url = "https://raw.githubusercontent.com/NormalLinuxUser2/Cmdr114/main/CustomCmdr.lua?t="..tostring(tick())

local success, err = pcall(function()
    local scriptText = game:HttpGetAsync(url)
    print("Loaded CustomCmdr.lua length:", #scriptText) -- sanity check
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

-- === R6 True Surface Chams ===
local character = player.Character or player.CharacterAdded:Wait()
character:WaitForChild("HumanoidRootPart")

local baseColor = Color3.fromRGB(170, 0, 255)
local glowSpeed = 2
local chamParts = {}

-- Only R6 BaseParts
local r6Parts = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}

-- Apply cham to BasePart or MeshPart
local function applyCham(part)
    if (part:IsA("BasePart") or part:IsA("MeshPart")) and part.Parent then
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

-- Apply to R6 body parts
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

-- Animate cached parts
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
