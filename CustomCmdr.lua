-- CustomCmdr.lua
-- This script adds a client-only command to Cmdr

local Players = game:GetService("Players")

-- Wait for Cmdr to load
local Cmdr = getgenv().Cmdr or Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr")
if not Cmdr or not Cmdr.Registry then
    warn("Cmdr not ready yet.")
    return
end

-- Add a client-only command
Cmdr.Registry:RegisterCommand({
    Name = "hello", -- command name
    Aliases = {"hi"}, -- optional aliases
    Description = "Prints a local hello message", -- description
    Group = "User", -- metadata, purely client-side
    Func = function(args)
        -- Local effect: print and flash screen
        print("Hello, world! Args:", table.concat(args, ", "))

        -- Optional visual effect
        local gui = Instance.new("ScreenGui")
        gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        frame.BackgroundTransparency = 0.8
        frame.Parent = gui
        task.delay(0.5, function() gui:Destroy() end)
    end
})

print("Custom Cmdr command 'hello' successfully added!")
