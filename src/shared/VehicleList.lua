defaultFuel = {maxFuel = 50 , fuelPerSecond = 0.05}

vehicleList = {
    [415] = {name = "kadett",   maxFuel = 70,   fuelPerSecond = 0.09,load = true},
    [436] = {name = "golg2", maxFuel = 50, fuelPerSecond = 0.4,load = true},
    [509] = {maxFuel = 0},
    [510] = {maxFuel = 0},
    [481] = {maxFuel = 0}
}

function randomPlate()
    local plate = ""
    for i=1,3 do
        plate = plate..string.char(math.random(97,122))
    end
    plate = plate .. "-"

    for i=1,4 do
        plate = plate..string.char(math.random(48,57))
    end
    
    return plate
end

function getCarName(id)
    for k,v in pairs(vehicleList) do
        if (k == id) then
            return v.name
        end
    end
    return false
end

function getVehicleFuelData(vehId)
    if vehicleList[vehId] then
        return vehicleList[vehId]
    end
    return defaultFuel
end

function getCarId(name)
    for k,v in pairs(vehicleList) do
        if (v.name == name) then
            return k
        end
    end
    return false
end