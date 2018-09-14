vehiclesWithoutFuel = {
    509,481,510
}

vehiclesData = {}

function fuelTick() 
    for k,v in ipairs(getElementsByType("vehicle")) do 
        checkVehicle(v)
    end

end

function checkVehicle(veh)
    if getVehicleEngineState(veh) then
        local vehId = getElementModel(veh)
        if hasValue(vehiclesWithoutFuel,vehId) then return end
        local consumo = getVehicleFuelData(vehId)
        local data = getVehicleData(veh)
        local lastCheck = data.lastCheck    
        if data.fuel <= 0 then
            setVehicleEngineState(veh,false)
            sendMessageInVehicle(veh,"#FF0000Acabou a gasolina do carro! Va em um posto abastecer!")
        end
        if (not lastCheck) or ((lastCheck+1500)<getTickCount()) then 
            data.lastCheck = getTickCount()
            setFuel(veh, data.fuel-consumo.fuelPerSecond)
            sendMessageInVehicle(veh,tostring(data.fuel))
        end
    end
end

function getVehicleData(veh)
    local data = {}
    if vehiclesData[veh] then
        return vehiclesData[veh]
    else
        local vehId = getElementModel(veh)
        local consumo = getVehicleFuelData(vehId)
        return {fuel = consumo.maxFuel}
    end
  
end

function getVehicleFuelData(vehId)
    if vehicleList[vehId] then
        return vehicleList[vehId]
    end
    return defaultFuel
end


function setFuel(veh,fuel)
    local data = getVehicleData(veh)
    data.fuel = fuel
    setElementData(veh,"fuel",fuel)
    vehiclesData[veh] = data
end


function turnEngine(thePlayer)
    local veh =  getPedOccupiedVehicle(thePlayer)
    if veh then
        local slot =  getPedOccupiedVehicleSeat(thePlayer)
        if slot and slot == 0 then
            local data = getVehicleData(veh)
            if data.fuel > 0 then
                local newValue = not getVehicleEngineState(veh)
                setVehicleEngineState(veh,not getVehicleEngineState(veh))
                if newValue then
                    thePlayer:msg("#00FF00Motor ligado!")
                else
                    thePlayer:msg("#FF0000Motor desligado!")
                end
            else
                thePlayer:msg("#FF0000O veiculo não possui combustivel!")
            end
        end
    end
end

setTimer(fuelTick,500,0)