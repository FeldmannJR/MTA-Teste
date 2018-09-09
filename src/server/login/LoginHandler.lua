function loginPlayer(user,password)
    msg(getPlayerName(client).." "..user.." - "..password)
end


addEvent("onLoginEnter",true)
addEventHandler("onLoginEnter",resourceRoot,loginPlayer)