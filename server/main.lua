
RegisterServerEvent('cynio:item')
AddEventHandler('cynio:item', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
	local random = math.random(1,2) -- here you can edit how much items you will get randomly (Default 1-2 of some item, e.g. 2 bandages)
    if xPlayer.canCarryItem(item, random) then
        xPlayer.addInventoryItem(item, random)
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = ('You have found '   ..   random  .. ' ' .. item)}) -- here you can edit message for your language
    else
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = ('You cannot take that, your inventory is full!')}) -- here you can edit message for your language
    end
end)

RegisterServerEvent('cynio:money')
AddEventHandler('cynio:money', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local random = math.random(50, 500) -- here you can edit how much dollars you can find
    xPlayer.addMoney(random)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = ('You have found ' .. random .. ' Dollars')}) -- here you can edit message for your language
end)