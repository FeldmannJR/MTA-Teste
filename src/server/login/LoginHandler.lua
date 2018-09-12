sessions = {}

function loginPlayer(user,password)
     if not validate(user,password,"receiveLogin") then return end
     DB.logIn(client,user,password)
end


function registerPlayer(user,password)
    if not validate(user,password,"receiveRegister") then return end
    DB.register(client,user,password)        
end

function validate(user,password,event)
    if not user or not password then
        triggerClientEvent(client,event,client,"error","Ocorreu um erro inesperado!")
        return false
    end
    if #user < 3 or #user > 32 then
        triggerClientEvent(client,event,client,"error","O usuario precisa ter de 3 a 32 caracteres!")
        return false
    end
    if #password < 6 or #password > 32 then
        triggerClientEvent(client,event,client,"error","Senha precisa ter no minimo 6 caracters e no max 32")
        return false
    end
    return true
end

-- https://wiki.multitheftauto.com/wiki/Resource:Editor/EDF
function playerLogged(client,user)
    print(toJSON(sessions))
    DB.getPlayerData(client,function(c,data)
        print(toJSON(data))
        if data == nil then return end
        local x,y,z,r = getDefaultSpawn()
        print(tostring(x).." "..tostring(y).." "..tostring(z))
        spawnPlayer(client,x,y,z,r,data.skin)
        fadeCamera(client,true)
        setCameraTarget(client,client)
      end)
end

function downloadedResource()
    triggerClientEvent(client,"openLogin",client)
end

addEvent("playerLoggedinEvent")
addEventHandler("playerLoggedinEvent",getRootElement(),playerLogged)

addEvent("submitLogin",true)
addEventHandler("submitLogin",getRootElement(),loginPlayer)

addEvent("submitRegister",true)
addEventHandler("submitRegister",getRootElement(),registerPlayer)

addEvent("playerDownloadedResource",true)
addEventHandler("playerDownloadedResource",getRootElement(),downloadedResource)
