itemreturn = false
detectorEnabled = false
detectorCommandRan = false
ESX = nil
withinRange = false
listOfNotifs = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj 
        end)
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
        PlayerData = ESX.GetPlayerData()
		Citizen.Wait(0)
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(250)
        TriggerServerEvent('esx_radardetector:getItemAmount', 'radar_detector')
    end
end)
Citizen.CreateThread(function()
    TriggerServerEvent('esx_radardetector:getItemAmount', 'radar_detector')
    coords = Config.allRadarLocations
    num = 0
    while true do
        playerped = GetPlayerPed(-1)
        playercoords = GetEntityCoords(playerped)
        if detectorEnabled then
            for k in pairs(coords) do
                local dist = Vdist(playercoords.x, playercoords.y, playercoords.z, coords[k].x, coords[k].y, coords[k].z)
                if dist <=  100 then
                    if IsPedInAnyVehicle(playerped) then
                        withinRange = true
                        notification('~r~Warning! Speed camera ahead!')
                    end
                end
            end
        end 
        Citizen.Wait(100)
    end
end)
Citizen.CreateThread(function()


end)
RegisterNetEvent('esx_radardetector:detectorCheck')
AddEventHandler('esx_radardetector:detectorCheck', function()
    if itemreturn == true and IsPedInAnyVehicle(playerped) then
        detectorEnabled = not detectorEnabled
        if detectorEnabled == false then
            if itemreturn == true then
                TriggerEvent("pNotify:SendNotification", {text = "Disabled radar detector.", type = "success", timeout = 5000, layout = "centerLeft"})
            else
                TriggerEvent("pNotify:SendNotification", {text = "You do not have the Radar Detector. Pick it up from your local Ammunation.", type = "error", timeout = 5000, layout = "centerLeft"})
            end
        else
            if itemreturn == true then
                if IsPedInAnyVehicle(playerped) then
                    TriggerEvent("pNotify:SendNotification", {text = "Enabled radar detector.", type = "success", timeout = 5000, layout = "centerLeft"})
                else 
                    TriggerEvent("pNotify:SendNotification", {text = "Enabled radar detector. Get in a car for it to start working.", type = "success", timeout = 5000, layout = "centerLeft"})
                end
            else
                TriggerEvent("pNotify:SendNotification", {text = "You do not have the Radar Detector. Pick it up from your local Ammunation.", type = "error", timeout = 5000, layout = "centerLeft"})
            end
        end
    else
        TriggerEvent("pNotify:SendNotification", {text = "You need to be in a vehicle to use the radar detector...", type = "error", timeout = 5000, layout = "centerLeft"})
    end
end)
Citizen.CreateThread(function()
    while true do
        if not IsPedInAnyVehicle(playerped) and detectorEnabled then
            detectorEnabled = false
        end
        Citizen.Wait(2500)
    end
end)
Citizen.CreateThread(function()
    while true do
        if IsPedInAnyVehicle(playerped) and detectorCommandRan == false and itemreturn == true then
            if detectorEnabled == true then
                DrawMyBoy('Enabled')
            else
                DrawMyBoy('Disabled')
            end
        end
        Citizen.Wait(5)
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if IsPedInAnyVehicle(playerped) then
            if itemreturn == true then
                if detectorEnabled == true  then
                    DrawTxt(1.160, 0.550, 1.0,1.0,0.55,"~r~Radar Detector~w~: Enabled", 255,0,0,255)
                else
                    DrawTxt(1.160, 0.550, 1.0,1.0,0.55,"~r~Radar Detector~w~: Disabled", 255,0,0,255)
                end
            end
        end
    end
end)
RegisterNetEvent('esx_radardetector:startRadar')
AddEventHandler('esx_radardetector:startRadar', function()
    itemreturn = true
end)
RegisterNetEvent('esx_radardetector:falseRadar')
AddEventHandler('esx_radardetector:falseRadar', function()
    itemreturn = false
end)
function DrawMyBoy(disoren)
    DrawTxt(1.160, 0.550, 1.0,1.0,0.55,"~r~Radar Detector~w~: "..disoren, 255,0,0,255)
end
RegisterCommand("detector", function()
    detectorCommandRan = true
    TriggerServerEvent('esx_radardetector:getItemAmount', 'radar_detector')
    TriggerServerEvent('esx_radardetector:getItemAmount', 'radar_detector')
    TriggerEvent('esx_radardetector:detectorCheck')
end)
function notification(msg)
	SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(msg)
    local Notification = DrawNotification(false, false)
    Citizen.Wait(300.5)
    RemoveNotification(Notification)
end
function DrawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
