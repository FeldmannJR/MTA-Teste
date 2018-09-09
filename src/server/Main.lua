function resourceStartNotify ( resourcename )
	if ( resourcename == getThisResource() ) then
        init()
    end
end

function init()
    DB.init()
end

function joinMessage()
    local name = getPlayerName(source);
    msg("#FF0000"..name.." entrou no servidor!")
end



function fortnite(source,cmd)
    source:setAnimation("Fortnite_1","baile 1",7000,true,false,false,false)
    source:setAnimation("Fortnite_2","baile 1",7000,true,false,false,false)
    source:setAnimation("Fortnite_3","baile 1",7000,true,false,false,false)
    source:msg("Era pra ter setado")
end

addCommandHandler("fortnite",fortnite)
addEventHandler("onPlayerJoin",getRootElement(),joinMessage)
addEventHandler( "onResourceStart", getRootElement(), resourceStartNotify )
  