local QBCore = exports['qb-core']:GetCoreObject()

local prefix = "bot:"

local function toNumber(value)
    return tonumber(value) or 0
end

local function giveItemToUser(userId, itemName, quantity)
    local source = vRP.getUserSource(userId)
    if not source then
        return
    end

    vRP.giveInventoryItem(userId, itemName, quantity)
    local displayName = vRP.itemNameList(itemName)
    TriggerClientEvent("itensNotify", source, "usar", "Pegou x" .. quantity, displayName)
end

local events = {
    ["item"] = function(id, item, qtd)
        local playerSrc = Player.PlayerData.source
        local quantity = toNumber(qtd)
        -- Se for sempre dinheiro, fica igual ao evento "dinheiro".
        -- Se quiser outro item, é só ajustar 'dinheiro' para outro nome de item.
        giveItemToUser(userId, item, quantity)
    end
}

-- Loop para registrar cada evento de uma só vez
for eventSuffix, callback in pairs(events) do
    AddEventHandler(prefix .. eventSuffix, callback)
end
