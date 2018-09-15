vehiclesData = {}

function fuelTick() 
    for k,v in ipairs(getElementsByType("vehicle")) do 
        checkVehicle(v)
    end

end

function checkVehicle(veh)
    if getVehicleEngineState(veh) then
        local vehId = getElementModel(veh)
        local consumo = getVehicleFuelData(vehId)
        if consumo.maxFuel == 0 then return end
        local data = getVehicleData(veh)
        local lastCheck = data.lastCheck    
        if data.fuel <= 0 then
            setVehicleEngineState(veh,false)
            sendMessageInVehicle(veh,"#FF0000Acabou a gasolina do carro! Va em um posto abastecer!")
        end
        if (not lastCheck) or ((lastCheck+1500)<getTickCount()) then 
            data.lastCheck = getTickCount()
            local speed = getElementSpeed(veh,1)
            local gasto = (consumo.fuelPerSecond/2)
            if speed <= 1 then
                gasto = 0.005
            end
            
            setFuel(veh, data.fuel-gasto)
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


function getMaxFuel(vehId)
    return getVehicleFuelData(vehId).maxFuel
end

function setFuel(veh,fuel)
    local data = getVehicleData(veh)
    data.fuel = fuel
    setElementData(veh,"fuel",fuel)
    vehiclesData[veh] = data
end

function getFuel(veh)
   return getElementData(veh,"fuel")
end


function turnEngine(thePlayer)
    local veh =  getPedOccupiedVehicle(thePlayer)
    if veh then
        if getMaxFuel(getElementModel(veh)) == 0 then
            thePlayer:msg("#FF0000Este veiculo não tem tanque de combustivel!")
            return
        end
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

function encheVehicle(thePlayer)
    local veh =  getPedOccupiedVehicle(thePlayer)
    if veh then
        setFuel(veh,getMaxFuel(getModelId))
        thePlayer:msg("#FF00FF Enchi o tanque chefia!!")
    end
end

addCommandHandler("fuel",encheVehicle)
setTimer(fuelTick,500,0)