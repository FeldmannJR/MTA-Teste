DB = {}

PlayerStruct = {
    money = {type = "INTEGER", default = "NOT NULL DEFAULT 0"},
    vehicles = {type = "TEXT", default = "{}"},
    location = {type ="VARCHAR(255)",default = "NULL",
        loadFunction = fromJSON,
        updateFunction = toJSON},
    skin = {type = "INTEGER",default = "NOT NULL DEFAULT 36"}
}

playerCache = {}
function DB.init()
    DB.connect();
end

function DB.connect()
    DB.conn = dbConnect("mysql","host="..get("dbHost")..";charset=utf8;unix_socket=/var/run/mysqld/mysqld.sock;dbname="..get("dbName"),get("dbUser"),get("dbPassword"),"autoReconnect=1");
    if(DB.conn) then
        DB.conn:exec("CREATE TABLE IF NOT EXISTS players (id INTEGER AUTO_INCREMENT PRIMARY KEY, name VARCHAR(32) CHARACTER SET utf8 COLLATE utf8_bin, password VARCHAR(60) CHARACTER SET utf8 COLLATE utf8_bin,token VARCHAR(60) CHARACTER SET utf8 COLLATE utf8_bin,tokenmac VARCHAR(60) )")
        DB:alterTables()
    end
end

function DB.alterTables()
    local colunas = DB.getColumns("players");
    for k,v in pairs(PlayerStruct) do
        if not hasValue(colunas,k) then 
            DB.conn:exec("ALTER TABLE `players` ADD COLUMN `"..k.."` "..v.type.."  "..v.default)
        end
    end

end

function DB.savePlayerData(data,...)
    if #arg == 0 then return end
    local nome = data.user
    local x = 0
    local query = "UPDATE players SET "
    pData = {}
    for k,v in ipairs(arg) do
        if x ~= 0 then 
            query = query..", " 
        end
        table.insert(pData,PlayerStruct[v].updateFunction(data[v]))
        query = query..v.."=?"
        x = x+1
    end
    table.insert(pData,nome)
    query = query.." WHERE name = ?"
    print(toJSON(pData))
    dbExec(DB.conn,query,unpack(pData))

end

function DB.getPlayerData(client)
    local data = sessions[client]
    if data==nil then return nil end
    nome = data.user
    if playerCache[nome] ~= nil then return playerCache[nome] end
    qh =  DB.conn:query("SELECT * FROM players WHERE `name` = ?",nome)
    local rs = dbPoll(qh,-1)
    if #rs<=0 then
        return nil
    end 
    row = rs[1]
    local pData = {}
    pData.user = nome
    for k,v in pairs(PlayerStruct) do
        if v.loadFunction ~= nil then
            pData[k] = v.loadFunction(row[k])
        else
            pData[k] = row[k]
        end
    end
    playerCache[nome] = pData
    return pData
end


function DB.logIn(client,user,password,generateToken)
    dbQuery(function(qh) 
        local rs = dbPoll(qh,0);
        for rid,row in ipairs(rs) do
            if passwordVerify(password,row.password) then
                local mac = getPlayerSerial(client)
                if mac and generateToken then
                    local tok = randomString(60)
                    DB.conn:exec("UPDATE `players` SET `token` = ?, `tokenmac` = ? where `name` = ?",tok,mac,user)
                    triggerClientEvent(client, "receiveLogin" ,client,"success",tok)
                else
                    triggerClientEvent(client, "receiveLogin" ,client,"success")
                end
                DB.loga(client,user,row.password)   
            else
                triggerClientEvent(client, "receiveLogin" ,client,"error","Senha inválida!");
            end
            return
        end
        triggerClientEvent(client, "receiveLogin" ,client,"error","Usuário não cadastrado!");
    end,DB.conn,"SELECT password FROM `players` WHERE `name` = ?",user);
end

function DB.loga(client,user,password)
    sessions[client] = {}
    sessions[client].user = user
    sessions[client].logintime = getRealTime().timestamp
    logOut(client)
    setAccountPassword(getAccount(user),password)
    logIn(client,getAccount(user),password)
    for i=1,20 do
        outputChatBox(" ",client)
    end
    triggerEvent("playerLoggedinEvent",getRootElement(),client,user)

end

function DB.autoLogin(client,user,tok)
    dbQuery(function(qh) 
        local mac = getPlayerSerial(client)
        local rs = dbPoll(qh,0);
        for rid,row in ipairs(rs) do
            if mac == row.tokenmac and tok==row.token then
                triggerClientEvent(client, "receiveAutoLogin" ,client,"success")
                DB.loga(client,user,row.password)
                return
            end
            triggerClientEvent(client, "receiveAutoLogin" ,client,"invalid");
            return
        end
        triggerClientEvent(client, "receiveAutoLogin" ,client,"invalid");
    end,DB.conn,"SELECT token,tokenmac,password FROM `players` WHERE `name` = ?",user);
end


function DB.register(client,user,password)
    password = passwordHash(password,"bcrypt",{})
    dbQuery(function(qh) 
        local rs = dbPoll(qh,0);
        if #rs > 0 then
            triggerClientEvent(client,"receiveRegister",client,"error","Usuário já cadastrado!")
            return
        end
        addAccount(user,password)
        DB.conn:exec("INSERT INTO players (`name`,`password`) VALUES(?,?)",user,password)
        triggerClientEvent(client,"receiveRegister",client,"success")
    end,DB.conn,"SELECT 1 FROM `players` WHERE `name` = ?",user);
end

function DB.getColumns(tabela)
    local query = DB.conn:query("SHOW COLUMNS from `"..tabela.."`")
    local rs = query:poll(-1)
    local columns = {}
    for rid, row in ipairs (rs) do 
        columns[#columns+1] = row["Field"]
    end
    return columns;
end

charsetR = {}  do -- [0-9a-zA-Z]
    for c = 48, 57  do table.insert(charsetR, string.char(c)) end
    for c = 65, 90  do table.insert(charsetR, string.char(c)) end
    for c = 97, 122 do table.insert(charsetR, string.char(c)) end
end

function randomString(length)
    if not length or length <= 0 then return '' end
    return randomString(length - 1) .. charsetR[math.random(1, #charsetR)]
end





