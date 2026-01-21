-- modules/misc.lua - TP, Scanner, Attack Underground, Codes, Remove UI

local module = {}

function module.Setup(Window)
    local tab = Window:CreateTab("Misc OP", 4483341098)

    -- Teleports
    tab:CreateButton({
        Name = "TP Spawn",
        Callback = function()
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = CFrame.new(0, 10, 0) end
        end
    })

    tab:CreateButton({
        Name = "TP World 4 / Crimson Abyss",
        Callback = function()
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = CFrame.new(200, 20, -150) end  -- Aprox. pos World 4
        end
    })

    tab:CreateButton({
        Name = "TP Raid Zone",
        Callback = function()
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = CFrame.new(500, 30, 500) end  -- Aprox.
        end
    })

    -- Area Scanner (check enemies → kill → next)
    local ScannerConn
    tab:CreateToggle({
        Name = "Area Scanner (Auto Progress)",
        CurrentValue = false,
        Callback = function(v)
            if ScannerConn then ScannerConn:Disconnect() end
            if v then
                ScannerConn = RunService.Heartbeat:Connect(function()
                    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    local hasEnemy = false
                    for _, e in ipairs(workspace:GetChildren()) do
                        if e:GetAttribute("hadEntrance") and e:FindFirstChild("Humanoid") and (hrp.Position - e.PrimaryPart.Position).Magnitude < 60 then
                            hasEnemy = true
                            break
                        end
                    end
                    if hasEnemy then
                        -- Ativa kill aura por 5s
                        pcall(function()
                            game.ReplicatedStorage.remotes.useAbility:FireServer("tornado")
                        end)
                        task.wait(5)
                    else
                        -- TP next exit
                        for _, z in ipairs(workspace:GetChildren()) do
                            if z:FindFirstChild("ExitZone") then
                                hrp.CFrame = z.ExitZone.CFrame
                                break
                            end
                        end
                    end
                    task.wait(2)
                end)
            end
        end
    })

    -- Attack Underground
    local AttackUndergroundConn
    tab:CreateToggle({
        Name = "Auto Attack Underground (Mouse1 Spam)",
        CurrentValue = false,
        Callback = function(v)
            if AttackUndergroundConn then AttackUndergroundConn:Disconnect() end
            if v then
                AttackUndergroundConn = RunService.Heartbeat:Connect(function()
                    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    for _, enemy in ipairs(workspace:GetChildren()) do
                        if enemy:GetAttribute("hadEntrance") and enemy:FindFirstChild("HumanoidRootPart") then
                            local dist = (hrp.Position - enemy.HumanoidRootPart.Position).Magnitude
                            if dist < 25 then
                                hrp.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, -6, 0)
                                VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
                                task.wait(0.05)
                                VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,0)
                            end
                        end
                    end
                    task.wait(0.2)
                end)
            end
        end
    })

    -- Redeem Codes
    tab:CreateButton({
        Name = "Redeem All Active Codes",
        Callback = function()
            local codes = {"600K", "575K", "CrimsonNightmare", "goldentooth", "World4", "FREEWISH", "MerryMerry", "kori", "Rings", "525K", "500K", "475K", "FBG"}
            for _, code in ipairs(codes) do
                pcall(function()
                    game.ReplicatedStorage.remotes.RedeemCode:FireServer(code)
                end)
                task.wait(0.6)
            end
            Rayfield:Notify({Title = "Códigos Resgatados", Content = "Wishes, Rings, Potions, Chests!"})
        end
    })

    -- Remove Blurs/UI
    tab:CreateButton({
        Name = "Remove Blurs & UI Game",
        Callback = function()
            pcall(function()
                game.Lighting:FindFirstChild("deathBlur"):Destroy()
                game.Lighting:FindFirstChild("screenBlur"):Destroy()
                LocalPlayer.PlayerGui.gameUI.upgradeFrame.Visible = false
            end)
        end
    })
end

return module
