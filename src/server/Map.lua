bikesColliders = {}
motos = {}

function addBikes()
    local bikes = getElementsByType("bike")
	for key, value in pairs(bikes) do
        local x = getElementData(value, "posX")
	    local y = getElementData(value, "posY")
        local z = getElementData(value, "posZ")
        createMarker(x,y,z,"cylinder",4,255,255,255,128)
        local col = createColTube(x,y,z,1,1)
        bikesColliders[#bikesColliders+1] = col
        setElementData(col,"type","bikespawner")
        addEventHandler("onColShapeHit",col,hitBike)
    end
end

function hitBike(thePlayer,m)
    if getElementType(thePlayer) ~= "player" then return end
    if getPedOccupiedVehicle(thePlayer) then return end
    if motos[thePlayer] ~= nil then
        destroyElement(motos[thePlayer])
    end
    local x,y,z = getElementPosition(thePlayer)
    y = y + 0.01
    local rx,ry,rz = getElementRotation(thePlayer)
    moto = createVehicle(463,x,y,z,rx,ry,rz,"DEUSEGAY")
    motos[thePlayer] = moto
    warpPedIntoVehicle(thePlayer,moto)
end


function getDefaultSpawn()
	local spawn = getElementsByType("spawnpoint")
	local x,y,z,r
	for key, value in pairs(spawn) do
		x = getElementData(value, "posX")
		y = getElementData(value, "posY")
		z = getElementData(value, "posZ")
		r = getElementData(value, "rot")
    end
	return x,y,z,r
end

function addSpawn()
    local x,y,z = getDefaultSpawn()
    createMarker(x,y,z,"corona",0.5,138, 255, 109)
    createBlip(x,y,z,56,2,0,0,0,1,1,200)
end


function initMap()
    addBikes()
    addSpawn()
end