-- https://wiki.multitheftauto.com/wiki/Resource:Editor/EDF
function playerLogged(c,user)
    local data = DB.getPlayerData(c)
    if data == nil then return end
    local x,y,z,r = getDefaultSpawn()
    local loc = data.location
    if loc then
        if loc.x then
            x = loc.x
            y = loc.y
            z = loc.z
        end
    end
    spawnPlayer(c,x,y,z,r,data.skin)
    fadeCamera(c,true)
    setCameraTarget(c,c)  
    bindKeys(c)
end

function savePlayerLoc(source)
    local data = DB.getPlayerData(source)
    if data == nil then return end
    local loc = {}
    loc.x,loc.y,loc.z = getElementPosition(source)
    data.location = loc
    DB.savePlayerData(data,"location")
end

function playerQuit(type)
  savePlayerLoc(source)
end


function onDisable(re)
    for k,player in ipairs(getElementsByType("player")) do
        savePlayerLoc(player)
    end
end

function bindKeys(pl)
    bindKey(pl,"x","up",turnEngine)
end

addEventHandler("onResourceStop",resourceRoot,onDisable)
addEventHandler("onPlayerQuit",getRootElement(),playerQuit)
addEventHandler("playerLoggedinEvent",getRootElement(),playerLogged)
