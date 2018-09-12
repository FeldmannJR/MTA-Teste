function resourceStartNotify ( resourcename )
	if ( resourcename == getThisResource() ) then
        init()
    end
end

function init()
    DB.init()
    addBikes()
end

function joinMessage()
    local name = getPlayerName(source);
    msg("#FF0000"..name.." entrou no servidor!")
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



addEventHandler("onPlayerJoin",getRootElement(),joinMessage)
addEventHandler( "onResourceStart", getRootElement(), resourceStartNotify )
setDevelopmentMode(true)