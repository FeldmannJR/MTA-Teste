defaultFuel = {maxFuel = 50, fuelPerSecond = 0.5}

vehicleList = {
    [415] = {name = "kadett",   maxFuel = 50,   fuelPerSecond = 0.5,load = true},
    [514] = {name = "golg2", maxFuel = 50, fuelPerSecond = 0.4,load = true}
}

function randomPlate()
    local plate = ""
    
    for 1,3 do
        plate = plate..string.char(math.random(97,122))
    end
    plate = plate .. "-"
    
    for 1,4 do
        plate = plate..string.char(math.random(48,57))
    end
    
    return plate
end