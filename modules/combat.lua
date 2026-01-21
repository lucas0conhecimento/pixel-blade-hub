-- modules/combat.lua - Kill Aura, Parry, Ability, Godmode

local module = {}

function module.Setup(Window)
    local tab = Window:CreateTab("Combat OP", 4483341098)

    local KillAuraConn
    tab:CreateToggle({
        Name = "Kill Aura (Tornado + Inf Dmg/Stun)",
        CurrentValue = false,
        Callback = function(v)
            if KillAuraConn then KillAuraConn:Disconnect() end
            if v then
                KillAuraConn = RunService.Heartbeat:Connect(function()
                    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    for _, enemy in ipairs(workspace:GetChildren()) do
                        if enemy:GetAttribute("hadEntrance") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            local root = enemy:FindFirstChild("HumanoidRootPart")
                            if root and (hrp.Position - root.Position).Magnitude <= 60 then
                                pcall(function()
                                    game.ReplicatedStorage.remotes.useAbility:FireServer("tornado")
                                    game.ReplicatedStorage.remotes.abilityHit:FireServer(enemy.Humanoid, math.huge, {stun = {dur = math.huge}})
                                end)
                            end
                        end
                    end
                    task.wait(0.15)
                end)
            end
        end
    })

    tab:CreateToggle({
        Name = "Auto Parry Spam",
        CurrentValue = false,
        Callback = function(v)
            -- Spam parry a cada 0.1s quando ativo
            spawn(function()
                while v do
                    pcall(function()
                        game.ReplicatedStorage.remotes.useAbility:FireServer("parry")
                    end)
                    task.wait(0.1)
                end
            end)
        end
    })

    tab:CreateToggle({
        Name = "Auto Ability Spam (Tornado)",
        CurrentValue = false,
        Callback = function(v)
            spawn(function()
                while v do
                    pcall(function()
                        game.ReplicatedStorage.remotes.useAbility:FireServer("tornado")
                    end)
                    task.wait(0.15)
                end
            end)
        end
    })

    tab:CreateToggle({
        Name = "Godmode (Infinite HP)",
        CurrentValue = false,
        Callback = function(v)
            spawn(function()
                while v do
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.Health = math.huge
                    end
                    task.wait(0.3)
                end
            end)
        end
    })
end

return module
