function loginPlayer(user,password)
    msg(getPlayerName(client).." pediu pra logar!")
    triggerClientEvent(client,"receiveLogin",client,"success")
end


addEvent("submitLogin",true)
addEventHandler("submitLogin",getRootElement(),loginPlayer)