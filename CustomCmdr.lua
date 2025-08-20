--[[
    Purple Chams with Animation for Local Player
    Load with: loadstring(game:HttpGet("YOUR_GITHUB_RAW_LINK"))()
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Settings
local chamColor = Color3.fromRGB(170, 0, 255) -- Purple
local chamTransparency = 0.5
local animationSpeed = 2 -- Speed of glow animation

-- Function to create chams for a part
local function createCham(part)
    local cham = Instance.new("BoxHandleAdornment")
    cham.Adornee = part
    cham.AlwaysOnTop = true
    cham.ZIndex = 2
    cham.Size = part.Size
    cham.Transparency = chamTransparency
    cham.Color3 = chamColor
    cham.Parent = part
    return cham
end

-- Animate cham color
local function animateCham(cham)
    local t = 0
    RunService.RenderStepped:Connect(function(dt)
        t = t + dt * animationSpeed
        local offset = math.sin(t) * 0.3 + 0.7
        cham.Color3 = chamColor:Lerp(Color3.new(1, 1, 1), offset)
    end)
end

-- Apply chams to all character parts
for _, part in ipairs(character:GetDescendants()) do
    if part:IsA("BasePart") then
        local cham = createCham(part)
        animateCham(cham)
    end
end

-- Optional: Reapply chams if new parts are added (e.g., accessories)
character.DescendantAdded:Connect(function(part)
    if part:IsA("BasePart") then
        local cham = createCham(part)
        animateCham(cham)
    end
end)
