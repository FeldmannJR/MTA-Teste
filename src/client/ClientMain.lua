triggerServerEvent("playerDownloadedResource",getRootElement())
setDevelopmentMode(true)

function disableHud()
    local disable = {"ammo","area_name","armour","breath","clock","health","money","vehicle_name","weapon","radio","wanted"}
    for _,v in ipairs(disable) do
        setPlayerHudComponentVisible(v,false)
    end


end