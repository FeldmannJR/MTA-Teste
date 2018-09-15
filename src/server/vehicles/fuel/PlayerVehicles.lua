playerVehicles = {}

function addVehicle(thePlayer,modelID,vehicleColor)
    local dataT = DB.getPlayerData(thePlayer);
    if dataT == nil then return end
    if not dataT.vehicles then dataT.vehicles = {} end
    table.insert(dataT.vehicles,
    {
        id = (#dataT.vehicles)+1,
        model = modelID,
        condition = 1000.0,
        fuel = getVehicleFuelData(modelID).maxFuel/2,
        color = vehicleColor,
        plate = randomPlate()
        
    })
    DB.savePlayerData(dataT,"vehicles")
end

function alternatePlayerVehicle(thePlayer,id)
    local data = getPlayerSpawnedVehicles(thePlayer)
    if data[id] then
        despawnPlayerVehicle(thePlayer,id)
    else
        spawnPlayerVehicle(thePlayer,id)
    end
end

function despawnPlayerVehicle(thePlayer,id)
    local veh = findVehicleById(thePlayer,id)
    if veh then
        local data = getPlayerSpawnedVehicles(thePlayer)
        if data[id] then
            local veh = data[id]
            local vehData= findVehicleById(thePlayer,id)
            updateVehicle(veh,vehData)
            DB.savePlayerData(DB.getPlayerData(thePlayer),"vehicles")
            data[id] = nil
            playerVehicles[thePlayer] = data
            destroyElement(veh)
        end
    end
end

function onExplodeVeh()
    for k,v in pairs(playerVehicles) do
        for vehID,veh in pairs(v) do
              if veh == source then
                despawnPlayerVehicle(k,vehID)
                return
            end
        end
    end
end
function despawnVehicles(thePlayer)
    if playerVehicles[thePlayer] ~= nil then
        for vehID,veh in pairs(playerVehicles[thePlayer]) do
            if veh == source then
                despawnPlayerVehicle(thePlayer,vehID)
            end
        end
    end
end

function updateVehicle(veh,vehData)
    vehData.fuel = getFuel(veh)
    vehData.condition = getElementHealth(veh)
end

function spawnPlayerVehicle(thePlayer,id)
    local veh = findVehicleById(thePlayer,id)
    if veh then
        local data = getPlayerSpawnedVehicles(thePlayer)
        if data[id] then return end
        if veh.condition<250 then return thePlayer:msg("#FF0000Carro explodiu não pode spawnar outro!") end
        local x,y,z = getElementPosition(thePlayer)
        local rx,ry,rz = getElementRotation(thePlayer)
        local spawned = createVehicle(veh.model,x,y,z,rx,ry,rz,veh.plate)
        setVehicleColor(spawned,veh.color.r,veh.color.g,veh.color.b)
        setFuel(spawned,veh.fuel)
        setElementHealth(spawned,veh.condition)
        warpPedIntoVehicle(thePlayer,spawned)
        data[id] = spawned
        playerVehicles[thePlayer] = data
        
    end
end

function fixVehicles(thePlayer,cmd)
    for k,v in pairs(getPlayerVehicles(thePlayer)) do
        v.condition = 1000
    end
    DB.savePlayerData(DB.getPlayerData(thePlayer),"vehicles")
end


function getPlayerVehicles(thePlayer)
    local dataT = DB.getPlayerData(thePlayer)
    if dataT == nil then return {} end
    if not dataT.vehicles then return {} end
    return dataT.vehicles
end

function getPlayerSpawnedVehicles(thePlayer)
    local data = playerVehicles[thePlayer]
    if data then return data end
    return {}
end

function findVehicleById(thePlayer,id)
    local dataT = DB.getPlayerData(thePlayer)
    if dataT == nil then return end
    if not dataT.vehicles then return false end
    for k,v in pairs(dataT.vehicles) do
        if v.id == id then return v end
    end
    return false
end
addEventHandler("onPlayerQuit",getRootElement(),function()
    despawnVehicles(source)
end)
addEventHandler("onResourceStop",resourceRoot,function()
    for _,pl in pairs(getElementsByType("player")) do
        despawnVehicles(pl)
    end
end)
addEventHandler("onVehicleExplode",getRootElement(),onExplodeVeh)
addCommandHandler("fix",fixVehicles)

