-- modules/movement.lua - Fly, Noclip, Speed, Infinite Jump
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer


local module = {}

function module.Setup(Window)
    local tab = Window:CreateTab("Movement OP", 4483361414)

    tab:CreateSlider({
        Name = "Walk Speed",
        Range = {16, 400},
        Increment = 8,
        CurrentValue = 16,
        Callback = function(v)
            local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = v end
        end
    })

    local FlyConn, FlyBV
    tab:CreateToggle({
        Name = "Fly (WASD + Space/Shift)",
        CurrentValue = false,
        Callback = function(v)
            if FlyConn then FlyConn:Disconnect() end
            if v then
                local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    FlyBV = Instance.new("BodyVelocity", hrp)
                    FlyBV.MaxForce = Vector3.new(1e6,1e6,1e6)
                    FlyConn = RunService.Heartbeat:Connect(function()
                        local cam = workspace.CurrentCamera.CFrame
                        local vel = Vector3.new()
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel += cam.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel -= cam.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel -= cam.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel += cam.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0,1,0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel -= Vector3.new(0,1,0) end
                        FlyBV.Velocity = vel.Unit * 60
                    end)
                end
            else
                if FlyBV then FlyBV:Destroy() end
            end
        end
    })

    local NoclipConn
    tab:CreateToggle({
        Name = "Noclip",
        CurrentValue = false,
        Callback = function(v)
            if NoclipConn then NoclipConn:Disconnect() end
            if v then
                NoclipConn = RunService.Stepped:Connect(function()
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        for _, part in ipairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then part.CanCollide = false end
                        end
                    end
                end)
            end
        end
    })

    tab:CreateToggle({
        Name = "Infinite Jump",
        CurrentValue = false,
        Callback = function(v)
            if v then
                UserInputService.JumpRequest:Connect(function()
                    local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                    if hum then hum:ChangeState("Jumping") end
                end)
            end
        end
    })
end

return module
