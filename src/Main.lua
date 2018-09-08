function resourceStartNotify ( resourcename )
	if ( resourcename == getThisResource() ) then
        init()
    end
end

function init()
    print(get("dbUrl"))
    DB.init()
end

function joinMessage()
    local name = getPlayerName(source);
    msg("#FF0000"..name.." entrou no servidor!")
    source:msg("Teste")
    debug(DB.conn)
end

function debug(elem)
    for key,value in pairs(elem) do
        outputConsole("found member " .. key .. " - "..type(value));
    end
end

addEventHandler("onPlayerJoin",getRootElement(),joinMessage)
addEventHandler( "onResourceStart", getRootElement(), resourceStartNotify )
  