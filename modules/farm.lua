-- modules/farm.lua - Auto Farm, Auto Raid, Max Upgrades, Open Chests
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

local module = {}

function module.Setup(Window)
    local tab = Window:CreateTab("Farm OP", 4483362458)

    local AutoFarmConn
    tab:CreateToggle({
        Name = "Auto Farm Rooms (Prompts + Exits)",
        CurrentValue = false,
        Callback = function(v)
            if AutoFarmConn then AutoFarmConn:Disconnect() end
            if v then
                AutoFarmConn = RunService.Heartbeat:Connect(function()
                    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("ProximityPrompt") and obj.Enabled then
                            hrp.CFrame = obj.Parent.CFrame + Vector3.new(0, 3, 0)
                            fireproximityprompt(obj)
                        end
                    end
                    for _, zone in ipairs(workspace:GetChildren()) do
                        if zone:FindFirstChild("ExitZone") then
                            hrp.CFrame = zone.ExitZone.CFrame
                        end
                    end
                    task.wait(0.3)
                end)
            end
        end
    })

    tab:CreateToggle({
        Name = "Auto Raid (Waves + Rings Farm)",
        CurrentValue = false,
        Callback = function(v)
            spawn(function()
                while v do
                    pcall(function()
                        game.ReplicatedStorage.remotes.StartRaid:FireServer()
                    end)
                    task.wait(8) -- Tempo médio por wave
                end
            end)
        end
    })

    tab:CreateToggle({
        Name = "Max Upgrades Spam",
        CurrentValue = false,
        Callback = function(v)
            if v then
                spawn(function()
                    while v do
                        pcall(function()
                            local rem = game.ReplicatedStorage.remotes.BuyUpgrade
                            rem:FireServer("Damage")
                            rem:FireServer("HP")
                            rem:FireServer("Speed")
                        end)
                        task.wait(0.4)
                    end
                end)
            end
        end
    })

    tab:CreateToggle({
        Name = "Auto Open Chests",
        CurrentValue = false,
        Callback = function(v)
            spawn(function()
                while v do
                    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for _, chest in ipairs(workspace:GetChildren()) do
                            if chest.Name:find("Chest") or chest.Name:find("Drop") then
                                hrp.CFrame = chest.CFrame
                                firetouchinterest(hrp, chest, 0)
                                task.wait(0.1)
                                firetouchinterest(hrp, chest, 1)
                            end
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    })
end

return module
