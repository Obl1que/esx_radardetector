ESX = nil
zoinks = false
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj 
end)
RegisterServerEvent('esx_radardetector:getItemAmount')
AddEventHandler('esx_radardetector:getItemAmount', function(item)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        local xItem = xPlayer.getInventoryItem(item)
        if xItem.count > 0 then
            zoinks = true
            TriggerClientEvent('esx_radardetector:startRadar', _source)
        else
            zoinks = false
            TriggerClientEvent('esx_radardetector:falseRadar', _source)
        end
    end
end)
ESX.RegisterUsableItem('radar_detector', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_radardetector:detectorCheck', source)
end)
