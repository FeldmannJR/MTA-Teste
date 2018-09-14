function addVehicle(player,modelID,vehicleColor)
    data = getPlayerData(player);
    if not data then return end
    table.insert(data.vehicles,
    {
        id = modelID,
        condition = 100.0,
        fuel = getVehicleData().maxFuel,
        color = vehicleColor,
        plate = randomPlate()
        
    })
    DB.savePlayerData(data,"vehicles")
end





