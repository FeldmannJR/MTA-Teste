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
end


addEventHandler("onPlayerJoin",getRootElement(),joinMessage)
addEventHandler( "onResourceStart", getRootElement(), resourceStartNotify )
  