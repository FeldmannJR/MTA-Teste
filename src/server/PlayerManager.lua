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
    spawnPlayer(c,x,y,z,r,randomSkin())
    fadeCamera(c,true)
    setCameraTarget(c,c)  
    bindKeys(c)
    createBlipAttachedTo(c,0,2,0,255,0)
    if not data.vehicles or #data.vehicles==0 then
        addVehicle(c,getCarId("kadett"),{r=math.random(0,255),g=math.random(0,255),b=math.random(0,255)})    
    end 
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
    bindKey(pl,"z","up",function(thePlayer)
       alternatePlayerVehicle(thePlayer,1)
    end)
end


addEventHandler("onPlayerWasted",getRootElement(), function()
    setTimer( spawnPlayer, 2000, 1, source, getDefaultSpawn())
end)

addEventHandler("onResourceStop",resourceRoot,onDisable)
addEventHandler("onPlayerQuit",getRootElement(),playerQuit)
addEventHandler("playerLoggedinEvent",getRootElement(),playerLogged)
