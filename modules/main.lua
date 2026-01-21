-- Pixel Blade Hub | Loader principal

local BASE_URL = "https://raw.githubusercontent.com/lucas0conhecimento/pixel-blade-hub/main/"

-- UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Pixel Blade Hub | Lukas",
    LoadingTitle = "Pixel Blade Hub",
    LoadingSubtitle = "Loading modules...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PixelBladeHub",
        FileName = "Config"
    },
    KeySystem = false
})

-- Load modules via HTTP (SEM require)
local Combat   = loadstring(game:HttpGet(BASE_URL .. "modules/combat.lua"))()
local Farm     = loadstring(game:HttpGet(BASE_URL .. "modules/farm.lua"))()
local Movement = loadstring(game:HttpGet(BASE_URL .. "modules/movement.lua"))()
local Visuals  = loadstring(game:HttpGet(BASE_URL .. "modules/visuals.lua"))()
local Misc     = loadstring(game:HttpGet(BASE_URL .. "modules/misc.lua"))()

-- Setup
if Combat and Combat.Setup then Combat.Setup(Window) end
if Farm and Farm.Setup then Farm.Setup(Window) end
if Movement and Movement.Setup then Movement.Setup(Window) end
if Visuals and Visuals.Setup then Visuals.Setup(Window) end
if Misc and Misc.Setup then Misc.Setup(Window) end

Rayfield:Notify({
    Title = "Pixel Blade Hub",
    Content = "Módulos carregados com sucesso.",
    Duration = 6
})

print("[Pixel Blade Hub] Carregado com sucesso via GitHub")
