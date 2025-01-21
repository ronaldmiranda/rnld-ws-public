local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local prefix = "bot:"

local serverCommands = {
    ["item"] = function(data)
        local id = tonumber(data.id) or 0
        local item = tostring(data.item or "")
        local qtd = tonumber(data.qtd) or 0

        return ("Item %s (%d) dado ao jogador %d"):format(item, qtd, id)
    end,

    -- "renomear" só um exemplo
    ["renomear"] = function(data)
        local id = tonumber(data.id) or 0
        local nome = data.nome or "SemNome"
        local sobrenome = data.sobrenome or "SemSobrenome"
        local idade = tonumber(data.idade) or 0
        local teste = {
            a = 'b'
        }
        return ("Renomeado ID %d para %s %s (%d anos)"):format(id, nome, sobrenome, idade)
    end,
}
AddEventHandler(prefix .. "executeCommand", function(requestId, commandName, data)
    local src = source
    local handler = serverCommands[commandName]
    local result = nil

    if handler then
        local status, res = pcall(handler, data)
        if status then
            result = res
        else
            result = "Erro no handler: " .. tostring(res)
        end
    else
        result = ("Comando '%s' não existente"):format(commandName)
    end
    TriggerEvent(prefix .. "commandResult", requestId, result)
end)
