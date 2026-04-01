local QBCore = exports['qb-core']:GetCoreObject()

local prefix = "bot:"

local serverCommands = {
    ["acunban"] = function(data)
        local banId = data.banId

        if banId then
            exports['nome-do-teu-ac']:UnbanId(banId)
            return ("Jogador Desbanido: %s"):format(banId)
        else
            return ("banId precisa ser especificado"):format(banId)
        end
    end,

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

        -- Faz alguma lógica de renomear
        return ("Renomeado ID %d para %s %s (%d anos)"):format(id, nome, sobrenome, idade)
    end,


    -- Comandos qbcore

    -- Local: [qb]/qb-ambulancejob/server/main.lua:349
    -- Descrição: Relatório EMS
    ["911e"] = function(data)
        -- message: Mensagem a enviar
        local message = tonumber(data.message) or 0

        -- Executar o comando real via console
        ExecuteCommand(("911e %s"):format(message))

        return ("Comando 911e: message=%s"):format(message)
    end,

    -- Local: [qb]/qb-policejob/server/commands.lua:348
    -- Descrição: Relatório Policial
    ["911p"] = function(data)
        -- message: Mensagem a ser enviada
        local message = tonumber(data.message) or 0

        -- Executar o comando real via console
        ExecuteCommand(("911p %s"):format(message))

        return ("Comando 911p: message=%s"):format(message)
    end,

    -- Local: [qb]/qb-vehiclekeys/server/main.lua:149
    -- Descrição: Adiciona chaves a um veículo para alguém.
    ["addkeys"] = function(data)
        -- id: ID do jogador
        local id = tonumber(data.id) or 0
        -- plate: Placa
        local plate = tostring(data.plate or "")

        -- Executar o comando real via console
        ExecuteCommand(("addkeys %d %s"):format(id, plate))

        return ("Comando addkeys: id=%d, plate=%s"):format(id, plate)
    end,

    -- Local: [qb]/qb-core/server/commands.lua:130
    -- Descrição: Dê permissões ao jogador (Só Deus)
    ["addpermission"] = function(data)
        -- id: ID do jogador
        local id = tonumber(data.id) or 0
        -- permissão: Nível de permissão
        local permissão = tostring(data.permissão or "")

        -- Executar o comando real via console
        ExecuteCommand(("addpermission %d %s"):format(id, permissão))

        return ("Comando addpermission: id=%d, permissão=%s"):format(id, permissão)
    end,

    -- Local: [qb]/qb-ambulancejob/server/main.lua:435
    -- Descrição: Cure um jogador ou você mesmo(Somente admin)
    ["aheal"] = function(data)
        -- id: ID do Jogador (Pode estar vazio)
        local id = tonumber(data.id) or 0

        -- Executar o comando real via console
        ExecuteCommand(("aheal %d"):format(id))

        return ("Comando aheal: id=%d"):format(id)
    end,

    -- Local: [qb]/qb-adminmenu/server/server.lua:335
    -- Descrição: Fazer um Anúncio (Apenas para Admins)
    ["announce"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("announce")

        return "Comando announce executado (Desc: Fazer um Anúncio (Apenas para Admins))"
    end,

    -- Local: [qb]/qb-weathersync/server/server.lua:240
    -- Descrição: Ative o modo de blecaute.
    ["blackout"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("blackout")

        return "Comando blackout executado (Desc: Ative o modo de blecaute.)"
    end,

    -- Local: [qb]/qb-garbagejob/server/main.lua:130
    -- Descrição: Removes garbo routes for user (admin only)
    ["cleargarbroutes"] = function(data)
        -- id: Player ID (may be empty)
        local id = tonumber(data.id) or 0

        -- Executar o comando real via console
        ExecuteCommand(("cleargarbroutes %d"):format(id))

        return ("Comando cleargarbroutes: id=%d"):format(id)
    end,

    -- Local: [qb]/qb-inventory/server/commands.lua:85
    -- Descrição: Clear Inventory (Admin Only)
    ["clearinv"] = function(data)
        -- id: (optional) The id of a player
        local id = tonumber(data.id) or 0

        -- Executar o comando real via console
        ExecuteCommand(("clearinv %d"):format(id))

        return ("Comando clearinv: id=%d"):format(id)
    end,

    -- Local: [qb]/qb-core/server/commands.lua:165
    -- Descrição: Feche o servidor para pessoas sem permissões (somente administrador)
    ["closeserver"] = function(data)
        -- motivo: Motivo do fechamento (opcional)
        local motivo = tostring(data.motivo or "")

        -- Executar o comando real via console
        ExecuteCommand(("closeserver %s"):format(motivo))

        return ("Comando closeserver: motivo=%s"):format(motivo)
    end,

    -- Local: [qb]/qb-multicharacter/server/main.lua:209
    -- Descrição: Exclui o personagem de outro jogador
    ["deletechar"] = function(data)
        -- citizenid: O ID do cidadão do personagem que você deseja excluir
        local citizenid = tonumber(data.citizenid) or 0

        -- Executar o comando real via console
        ExecuteCommand(("deletechar %d"):format(citizenid))

        return ("Comando deletechar: citizenid=%d"):format(citizenid)
    end,

    -- Local: [qb]/qb-drugs/server/deliveries.lua:181
    -- Descrição: Excluir um traficante (Apenas Admin)
    ["deletedealer"] = function(data)
        -- nome: Nome do traficante
        local nome = tostring(data.nome or "")

        -- Executar o comando real via console
        ExecuteCommand(("deletedealer %s"):format(nome))

        return ("Comando deletedealer: nome=%s"):format(nome)
    end,

    -- Local: [qb]/qb-adminmenu/server/server.lua:422
    -- Descrição: Excluir avisos de jogador (Apenas para Admins)
    ["delwarn"] = function(data)
        -- id: (required) The id of the player
        local id = tonumber(data.id) or 0
        -- warning: Number of warning, (1, 2 or 3 etc..)
        local warning = tostring(data.warning or "")

        -- Executar o comando real via console
        ExecuteCommand(("delwarn %d %s"):format(id, warning))

        return ("Comando delwarn: id=%d, warning=%s"):format(id, warning)
    end,

    -- Local: [qb]/qb-cityhall/server/main.lua:144
    -- Descrição: Give a drivers license to someone
    ["drivinglicense"] = function(data)
        -- id: (required) The id of the player
        local id = tonumber(data.id) or 0

        -- Executar o comando real via console
        ExecuteCommand(("drivinglicense %d"):format(id))

        return ("Comando drivinglicense: id=%d"):format(id)
    end,

    -- Local: [qb]/qb-core/server/commands.lua:195
    -- Descrição: Deletar todos os veículos
    ["dvall"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("dvall")

        return "Comando dvall executado (Desc: Deletar todos os veículos)"
    end,

    -- Local: [qb]/qb-core/server/commands.lua:213
    -- Descrição: Deletar todos os objetos
    ["dvo"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("dvo")

        return "Comando dvo executado (Desc: Deletar todos os objetos)"
    end,

    -- Local: [qb]/qb-core/server/commands.lua:204
    -- Descrição: Deletar todos os peds
    ["dvp"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("dvp")

        return "Comando dvp executado (Desc: Deletar todos os peds)"
    end,

    -- Local: [qb]/qb-weathersync/server/server.lua:260
    -- Descrição: Defina o horário para 18:00
    ["evening"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("evening")

        return "Comando evening executado (Desc: Defina o horário para 18:00)"
    end,

    -- Local: [qb]/qb-weathersync/server/server.lua:210
    -- Descrição: Congele / descongele o tempo.
    ["freezetime"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("freezetime")

        return "Comando freezetime executado (Desc: Congele / descongele o tempo.)"
    end,

    -- Local: [qb]/qb-weathersync/server/server.lua:220
    -- Descrição: Ative / desative as mudanças dinâmicas de clima.
    ["freezeweather"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("freezeweather")

        return "Comando freezeweather executado (Desc: Ative / desative as mudanças dinâmicas de clima.)"
    end,

    -- Local: [qb]/qb-banking/server.lua:493
    -- Descrição: Give Cash
    ["givecash"] = function(data)
        -- id: Player ID
        local id = tonumber(data.id) or 0
        -- amount: Amount
        local amount = tonumber(data.amount) or 0

        -- Executar o comando real via console
        ExecuteCommand(("givecash %d %d"):format(id, amount))

        return ("Comando givecash: id=%d, amount=%d"):format(id, amount)
    end,

    -- Local: [qb]/qb-inventory/server/commands.lua:3
    -- Descrição: Give An Item (Admin Only)
    ["giveitem"] = function(data)
        -- id: Player ID
        local id = tonumber(data.id) or 0
        -- item: Name of the item (not a label)
        local item = tostring(data.item or "")
        -- amount: Amount of items
        local amount = tonumber(data.amount) or 0

        -- Executar o comando real via console
        ExecuteCommand(("giveitem %d %s %d"):format(id, item, amount))

        return ("Comando giveitem: id=%d, item=%s, amount=%d"):format(id, item, amount)
    end,

    -- Local: [qb]/qb-core/server/commands.lua:222
    -- Descrição: Dar dinheiro a um jogador (somente administrador)
    ["givemoney"] = function(data)
        -- id: ID do jogador
        local id = tonumber(data.id) or 0
        -- tipo_dinheiro: Tipo de dinheiro (cash, bank, crypto)
        local tipo_dinheiro = tostring(data.tipo_dinheiro or "")
        -- quantia: Quantia de dinheiro
        local quantia = tostring(data.quantia or "")

        -- Executar o comando real via console
        ExecuteCommand(("givemoney %d %s %s"):format(id, tipo_dinheiro, quantia))

        return ("Comando givemoney: id=%d, tipo_dinheiro=%s, quantia=%s"):format(id, tipo_dinheiro, quantia)
    end,

    -- Local: [qb]/qb-adminmenu/server/server.lua:379
    -- Descrição: Dar o foco NUI a um jogador (Apenas para Admins)
    ["givenuifocus"] = function(data)
        -- id: (required) The id of the player
        local id = tonumber(data.id) or 0
        -- focus: Set focus on/off
        local focus = tostring(data.focus or "")
        -- mouse: Set mouse on/off
        local mouse = tostring(data.mouse or "")

        -- Executar o comando real via console
        ExecuteCommand(("givenuifocus %d %s %s"):format(id, focus, mouse))

        return ("Comando givenuifocus: id=%d, focus=%s, mouse=%s"):format(id, focus, mouse)
    end,

    -- Local: [qb]/qb-adminmenu/server/server.lua:493
    -- Descrição: Expulsar todos os jogadores
    ["kickall"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("kickall")

        return "Comando kickall executado (Desc: Expulsar todos os jogadores)"
    end,

    -- Local: [qb]/qb-ambulancejob/server/main.lua:421
    -- Descrição: Mate um jogador ou você mesmo(Somente admin)
    ["kill"] = function(data)
        -- id: ID do Jogador (Pode estar vazio)
        local id = tonumber(data.id) or 0

        -- Executar o comando real via console
        ExecuteCommand(("kill %d"):format(id))

        return ("Comando kill: id=%d"):format(id)
    end,

    -- Local: [qb]/qb-weathersync/server/server.lua:250
    -- Descrição: Defina o horário para 09:00
    ["morning"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("morning")

        return "Comando morning executado (Desc: Defina o horário para 09:00)"
    end,

    -- Local: [qb]/qb-weathersync/server/server.lua:265
    -- Descrição: Defina o horário para 23:00
    ["night"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("night")

        return "Comando night executado (Desc: Defina o horário para 23:00)"
    end,

    -- Local: [qb]/qb-weathersync/server/server.lua:255
    -- Descrição: Defina o horário para 12:00
    ["noon"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("noon")

        return "Comando noon executado (Desc: Defina o horário para 12:00)"
    end,

    -- Local: [qb]/qb-towjob/server/main.lua:79
    -- Descrição: Alternar Trabalho de NPC
    ["npc"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("npc")

        return "Comando npc executado (Desc: Alternar Trabalho de NPC)"
    end,

    -- Local: [qb]/qb-core/server/commands.lua:273
    -- Descrição: Mensagem de bate-papo OOC
    ["ooc"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("ooc")

        return "Comando ooc executado (Desc: Mensagem de bate-papo OOC)"
    end,

    -- Local: [qb]/qb-core/server/commands.lua:152
    -- Descrição: Abra o servidor para todos (somente administrador)
    ["openserver"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("openserver")

        return "Comando openserver executado (Desc: Abra o servidor para todos (somente administrador))"
    end,

    -- Local: [qb]/qb-vehiclekeys/server/main.lua:158
    -- Descrição: Remove as chaves de um veículo para alguém.
    ["removekeys"] = function(data)
        -- id: ID do jogador
        local id = tonumber(data.id) or 0
        -- plate: Placa
        local plate = tostring(data.plate or "")

        -- Executar o comando real via console
        ExecuteCommand(("removekeys %d %s"):format(id, plate))

        return ("Comando removekeys: id=%d, plate=%s"):format(id, plate)
    end,

    -- Local: [qb]/qb-core/server/commands.lua:140
    -- Descrição: Remover permissões do jogador (Só Deus)
    ["removepermission"] = function(data)
        -- id: ID do jogador
        local id = tonumber(data.id) or 0
        -- permissão: Nível de permissão
        local permissão = tostring(data.permissão or "")

        -- Executar o comando real via console
        ExecuteCommand(("removepermission %d %s"):format(id, permissão))

        return ("Comando removepermission: id=%d, permissão=%s"):format(id, permissão)
    end,

    -- Local: [qb]/qb-ambulancejob/server/main.lua:393
    -- Descrição: Reviva um jogador ou você mesmo(Somente admin)
    ["revive"] = function(data)
        -- id: ID do Jogador (Pode estar vazio)
        local id = tonumber(data.id) or 0

        -- Executar o comando real via console
        ExecuteCommand(("revive %d"):format(id))

        return ("Comando revive: id=%d"):format(id)
    end,

    -- Local: [qb]/qb-ambulancejob/server/main.lua:383
    -- Descrição: Reviver um jogador
    ["revivep"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("revivep")

        return "Comando revivep executado (Desc: Reviver um jogador)"
    end,

    -- Local: [qb]/qb-crypto/server/main.lua:115
    -- Descrição: Set crypto value
    ["setcryptoworth"] = function(data)
        -- crypto: Name of the crypto currency
        local crypto = tostring(data.crypto or "")
        -- value: New value of the crypto currency
        local value = tostring(data.value or "")

        -- Executar o comando real via console
        ExecuteCommand(("setcryptoworth %s %s"):format(crypto, value))

        return ("Comando setcryptoworth: crypto=%s, value=%s"):format(crypto, value)
    end,

    -- Local: [qb]/qb-core/server/commands.lua:263
    -- Descrição: Definir a gangue do jogador (somente administrador)
    ["setgang"] = function(data)
        -- id: ID do jogador
        local id = tonumber(data.id) or 0
        -- gangue: Nome da gangue
        local gangue = tostring(data.gangue or "")
        -- grau: Grau da gangue
        local grau = tostring(data.grau or "")

        -- Executar o comando real via console
        ExecuteCommand(("setgang %d %s %s"):format(id, gangue, grau))

        return ("Comando setgang: id=%d, gangue=%s, grau=%s"):format(id, gangue, grau)
    end,

    -- Local: [qb]/qb-core/server/commands.lua:247
    -- Descrição: Definir o trabalho do jogador (somente administrador)
    ["setjob"] = function(data)
        -- id: ID do jogador
        local id = tonumber(data.id) or 0
        -- trabalho: Nome do trabalho
        local trabalho = tostring(data.trabalho or "")
        -- grau: Grau do trabalho
        local grau = tostring(data.grau or "")

        -- Executar o comando real via console
        ExecuteCommand(("setjob %d %s %s"):format(id, trabalho, grau))

        return ("Comando setjob: id=%d, trabalho=%s, grau=%s"):format(id, trabalho, grau)
    end,

    -- Local: [qb]/qb-adminmenu/server/server.lua:455
    -- Descrição: Mudar o modelo do ped (Apenas para Admins)
    ["setmodel"] = function(data)
        -- model: (required) The ped model to change to
        local model = tostring(data.model or "")
        -- id: (required) The id of the player whos ped model is being changed
        local id = tonumber(data.id) or 0

        -- Executar o comando real via console
        ExecuteCommand(("setmodel %s %d"):format(model, id))

        return ("Comando setmodel: model=%s, id=%d"):format(model, id)
    end,

    -- Local: [qb]/qb-core/server/commands.lua:231
    -- Descrição: Definir a quantidade de dinheiro do jogador (somente administrador)
    ["setmoney"] = function(data)
        -- id: ID do jogador
        local id = tonumber(data.id) or 0
        -- tipo_dinheiro: Tipo de dinheiro (cash, bank, crypto)
        local tipo_dinheiro = tostring(data.tipo_dinheiro or "")
        -- quantia: Quantia de dinheiro
        local quantia = tostring(data.quantia or "")

        -- Executar o comando real via console
        ExecuteCommand(("setmoney %d %s %s"):format(id, tipo_dinheiro, quantia))

        return ("Comando setmoney: id=%d, tipo_dinheiro=%s, quantia=%s"):format(id, tipo_dinheiro, quantia)
    end,

    -- Local: [qb]/qb-ambulancejob/server/main.lua:407
    -- Descrição: Defina o nível de dor de você mesmou ou de um jogador(Somente admin)
    ["setpain"] = function(data)
        -- id: ID do Jogador (Pode estar vazio)
        local id = tonumber(data.id) or 0

        -- Executar o comando real via console
        ExecuteCommand(("setpain %d"):format(id))

        return ("Comando setpain: id=%d"):format(id)
    end,

    -- Local: [qb]/qb-adminmenu/server/server.lua:357
    -- Descrição: Enviar uma mensagem para toda a equipe (Apenas para Admins)
    ["staffchat"] = function(data)
        -- message: (required) The message to send
        local message = tonumber(data.message) or 0

        -- Executar o comando real via console
        ExecuteCommand(("staffchat %d"):format(message))

        return ("Comando staffchat: message=%d"):format(message)
    end,

    -- Local: [qb]/qb-smallresources/server/logs.lua:146
    -- Descrição: Test Your Discord Webhook For Logs (God Only)
    ["testwebhook"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("testwebhook")

        return "Comando testwebhook executado (Desc: Test Your Discord Webhook For Logs (God Only))"
    end,

    -- Local: [qb]/qb-weathersync/server/server.lua:270
    -- Descrição: Mude o horário.
    ["time"] = function(data)
        -- horas: Um número entre 0 - 23
        local horas = tostring(data.horas or "")
        -- minutos: Um número entre 0 - 59
        local minutos = tostring(data.minutos or "")

        -- Executar o comando real via console
        ExecuteCommand(("time %s %s"):format(horas, minutos))

        return ("Comando time: horas=%s, minutos=%s"):format(horas, minutos)
    end,

    -- Local: [qb]/qb-core/server/commands.lua:123
    -- Descrição: Alternar PVP no servidor (Somente administrador)
    ["togglepvp"] = function(data)
        -- Sem argumentos definidos

        -- Executar o comando real via console
        ExecuteCommand("togglepvp")

        return "Comando togglepvp executado (Desc: Alternar PVP no servidor (Somente administrador))"
    end,

    -- Local: [qb]/qb-vehicleshop/server.lua:477
    -- Descrição: Presenteie ou venda seu veículo
    ["transfervehicle"] = function(data)
        -- buyerId: ID do comprador
        local buyerId = tonumber(data.buyerId) or 0
        -- sellAmount: Valor da venda (opcional)
        local sellAmount = tonumber(data.sellAmount) or 0

        -- Executar o comando real via console
        ExecuteCommand(("transfervehicle %d %d"):format(buyerId, sellAmount))

        return ("Comando transfervehicle: buyerId=%d, sellAmount=%d"):format(buyerId, sellAmount)
    end,

    -- Local: [qb]/qb-adminmenu/server/server.lua:386
    -- Descrição: Avisar um jogador (Apenas para Admins)
    ["warn"] = function(data)
        -- id: (required) The id of the player being warned
        local id = tonumber(data.id) or 0
        -- reason: (required) The reason for giving a warning
        local reason = tostring(data.reason or "")

        -- Executar o comando real via console
        ExecuteCommand(("warn %d %s"):format(id, reason))

        return ("Comando warn: id=%d, reason=%s"):format(id, reason)
    end,

    -- Local: [qb]/qb-weathersync/server/server.lua:230
    -- Descrição: Mude o clima.
    ["weather"] = function(data)
        -- tipodeclima: Tipos disponíveis: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas e halloween
        local tipodeclima = tostring(data.tipodeclima or "")

        -- Executar o comando real via console
        ExecuteCommand(("weather %s"):format(tipodeclima))

        return ("Comando weather: tipodeclima=%s"):format(tipodeclima)
    end,
}

AddEventHandler(prefix .. "executeCommand", function(requestId, commandName, data)
    local src = source

    local handler = serverCommands[commandName]
    local result = nil

    if handler then
        -- Executa a função e captura o retorno
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
