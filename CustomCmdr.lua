-- CustomCmdr.lua
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Get the running Cmdr client
local Cmdr = getgenv().Cmdr or lp:WaitForChild("PlayerGui"):FindFirstChild("Cmdr")
if not Cmdr or not Cmdr.Registry then
    warn("Cmdr not found or Registry not ready")
    return
end

-- Add a client-only command dynamically
Cmdr.Registry:RegisterCommand({
    Name = "hello",
    Aliases = {"hi"},
    Description = "Prints a local hello message",
    Group = "User",
    Func = function(args)
        print("Hello, world! Args:", table.concat(args, ", "))
        -- Optional local effect
        local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(1,0,1,0)
        frame.BackgroundColor3 = Color3.fromRGB(255,255,0)
        frame.BackgroundTransparency = 0.8
        task.delay(0.5, function() gui:Destroy() end)
    end
})

print("Custom Cmdr command 'hello' added dynamically!")
