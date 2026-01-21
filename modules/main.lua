local function LoadModule(path, name)
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(path))()
    end)

    if not ok then
        warn("[ERRO AO BAIXAR] " .. name, result)
        return
    end

    if type(result) ~= "table" then
        warn("[ERRO] " .. name .. " não retornou module")
        return
    end

    if type(result.Setup) ~= "function" then
        warn("[ERRO] " .. name .. " não tem Setup(Window)")
        return
    end

    local ok2, err = pcall(function()
        result.Setup(Window)
    end)

    if ok2 then
        print("[OK] Módulo carregado:", name)
    else
        warn("[ERRO AO EXECUTAR] " .. name, err)
    end
end

LoadModule(BASE_URL .. "modules/combat.lua", "Combat")
LoadModule(BASE_URL .. "modules/farm.lua", "Farm")
LoadModule(BASE_URL .. "modules/movement.lua", "Movement")
LoadModule(BASE_URL .. "modules/visuals.lua", "Visuals")
LoadModule(BASE_URL .. "modules/misc.lua", "Misc")
