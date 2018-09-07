function resourceStartNotify ( resourcename )
	if ( resourcename == getThisResource() ) then
        init()
    end
end

function init()

end

function joinMessage()
    local name = getPlayerName(source);
    msg("#FF0000"..name.." entrou no servidor!")
    source:msg("Teste")
    debugPlayer()
end

function debugPlayer()
    for key,value in pairs(Player) do
        outputConsole("found member " .. key .. " - "..type(value));
    end
end

addEventHandler("onPlayerJoin",getRootElement(),joinMessage)
addEventHandler( "onResourceStart", getRootElement(), resourceStartNotify )
  