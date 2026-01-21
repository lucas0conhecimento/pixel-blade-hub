-- main.lua - Carrega tudo (UI Rayfield + módulos)

local repo = "https://raw.githubusercontent.com/SEU_USUARIO_AQUI/Lukas-PixelBlade-Hub/main/"

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Pixel Blade OP Hub | Lukas v3.2",
    LoadingTitle = "Carregando Tudo OP...",
    LoadingSubtitle = "NIGHTMARE + World 4 - Jan 2026",
    ConfigurationSaving = {Enabled = true, FolderName = "LukasPB", FileName = "Config"},
    KeySystem = false
})

-- Carrega módulos
local Combat  = loadstring(game:HttpGet(repo .. "modules/combat.lua"))()
local Farm    = loadstring(game:HttpGet(repo .. "modules/farm.lua"))()
local Movement = loadstring(game:HttpGet(repo .. "modules/movement.lua"))()
local Visuals = loadstring(game:HttpGet(repo .. "modules/visuals.lua"))()
local Misc    = loadstring(game:HttpGet(repo .. "modules/misc.lua"))()

-- Setup cada módulo passando a Window
Combat.Setup(Window)
Farm.Setup(Window)
Movement.Setup(Window)
Visuals.Setup(Window)
Misc.Setup(Window)

Rayfield:Notify({
    Title = "Hub v3.2 Carregado!",
    Content = "Tudo OP ativado - Hitbox invisível gigante, Auto Raid 60+ waves, Press K para abrir. ALT account!",
    Duration = 10
})

print("[Lukas Cascavel] Hub v3.2 FULL carregado via GitHub")
