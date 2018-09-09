vehicles = {
    kadett = 415
}

function loadVehicles()
    for k,v in pairs(vehicles) do
        engineImportTXD(engineLoadTXD("vehicles/"..k..".txd"))
        engineReplaceModel(engineLoadDFF("vehicles/"..v..".txd"))
        msg("loaded "..k)
    end
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),loadVehicles)