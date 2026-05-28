local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local prefix = "bot:"

-- Para exemplificar, uma tabela de comandos "server-side".
local serverCommands = {
    -- exemplo de comando "kick" usado em conjunto com o rnld_api
    ["kick"] = function(data)
        local token = data.token
        local reason = data.reason or "Sem Motivo"
        local plysrc = exports['rnld_api']:getSourceByToken(token)

        if plysrc then
            DropPlayer(plysrc, reason)
            return ("Jogador %s kickado. Motivo: %s"):format(token, reason)
        else
            return ("Jogador com token %s não encontrado"):format(token)
        end
    end,

    -- Comando "item" executado inteiramente no servidor
    ["item"] = function(data)
        local id = tonumber(data.id) or 0
        local item = tostring(data.item or "")
        local qtd = tonumber(data.qtd) or 0

        -- Exemplo de lógica
        -- (Ajuste conforme seu framework)
        -- local Player = QBCore.Functions.GetPlayer(id)
        -- if Player then
        --   Player.Functions.AddItem(item, qtd)
        -- end

        -- Retorne algo que queira mandar de volta
        return ("Item %s (%d) dado ao jogador %d"):format(item, qtd, id)
    end,

    -- "renomear" só um exemplo
    ["renomear"] = function(data)
        local id = tonumber(data.id) or 0
        local nome = data.nome or "SemNome"
        local sobrenome = data.sobrenome or "SemSobrenome"
        local idade = tonumber(data.idade) or 0

        -- Faz alguma lógica de renomear
        return ("Renomeado ID %d para %s %s (%d anos)"):format(id, nome, sobrenome, idade)
    end,

    -- Exemplo de comando que retorna um JSON (tabela) dentro do campo "result".
    -- A mensagem de retorno é personalizada conforme o campo "success" do JSON.
    ["pagar"] = function(data)
        local id = tonumber(data.id) or 0
        local valor = tonumber(data.valor) or 0

        -- Simulação da lógica de pagamento. Em produção, troque por algo como:
        -- local Player = QBCore.Functions.GetPlayer(id)
        -- local ok = Player and Player.Functions.AddMoney("bank", valor)
        local resultado = {
            id = id,
            valor = valor,
        }

        if id > 0 and valor > 0 then
            resultado.success = true
            resultado.saldo = 1000 + valor
        else
            resultado.success = false
            resultado.erro = id <= 0 and "player_not_found" or "valor_invalido"
        end

        -- Personaliza a mensagem de acordo com o campo "success" do result.
        if resultado.success then
            resultado.mensagem = ("Pagamento de $%d realizado ao jogador %d (saldo: $%d)")
                :format(resultado.valor, resultado.id, resultado.saldo)
        else
            resultado.mensagem = ("Falha ao pagar o jogador %d: %s")
                :format(resultado.id, resultado.erro)
        end

        return resultado
    end,

    -- Exemplo de comando que faz um UPDATE numa tabela do banco e retorna
    -- o resultado bruto do MySQL no campo "result". A mensagem é
    -- personalizada conforme os campos "affectedRows" / "changedRows".
    ["banir"] = function(data)
        local id = tonumber(data.id) or 0
        local motivo = tostring(data.motivo or "Sem motivo")

        -- Executa o UPDATE de forma síncrona via promise (oxmysql).
        local p = promise.new()
        exports.oxmysql:update(
            "UPDATE users SET banned = 1, ban_reason = ? WHERE id = ?",
            { motivo, id },
            function(queryResult)
                p:resolve(queryResult)
            end
        )

        -- "result" é o objeto retornado pelo MySQL, ex:
        -- { affectedRows = 1, changedRows = 0, insertId = 0,
        --   info = "Rows matched: 1  Changed: 0  Warnings: 0", ... }
        local result = Citizen.Await(p) or {}

        local affected = tonumber(result.affectedRows) or 0
        local changed = tonumber(result.changedRows) or 0

        -- Personaliza a mensagem conforme o resultado do UPDATE.
        if affected == 0 then
            result.success = false
            result.mensagem = ("Nenhum jogador encontrado com id %d"):format(id)
        elseif changed == 0 then
            result.success = true
            result.mensagem = ("Jogador %d já estava banido (nenhuma linha alterada)"):format(id)
        else
            result.success = true
            result.mensagem = ("Jogador %d banido com sucesso"):format(id)
        end

        return result
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
