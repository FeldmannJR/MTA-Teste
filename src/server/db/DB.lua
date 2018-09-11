DB = {}

PlayerStruct = {
    money = {type = "INTEGER", default = "NOT NULL DEFAULT 0"},
    carro = {type = "TEXT", default = "NULL"},
}

function DB.init()
    DB.connect();
end

function DB.connect()
    DB.conn = dbConnect("mysql","host="..get("dbHost")..";charset=utf8;unix_socket=/var/run/mysqld/mysqld.sock;dbname="..get("dbName"),get("dbUser"),get("dbPassword"),"autoReconnect=1");
    if(DB.conn) then
        DB.conn:exec("CREATE TABLE IF NOT EXISTS players (id INTEGER AUTO_INCREMENT PRIMARY KEY, name VARCHAR(32), password VARCHAR(60))")
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

function DB.logIn(client,user,password)
    dbQuery(function(qh) 
        local rs = dbPoll(qh,0);
        for rid,row in ipairs(rs) do
            if passwordVerify(password,row.password) then
                sessions[client] = {}
                sessions[client].user = user
                sessions[client].logintime = getRealTime().timestamp
                logIn(client,getAccount(user),row.password)
                triggerClientEvent(client, "receiveLogin" ,client,"success")
            else
                triggerClientEvent(client, "receiveLogin" ,client,"error","Senha inválida!");
            end
            return
        end
        triggerClientEvent(client, "receiveLogin" ,client,"error","Usuário não cadastrado!");
    end,DB.conn,"SELECT password FROM `players` WHERE `name` = ?",user);
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
        print(toJSON(row))
        columns[#columns+1] = row["Field"]
    end
    return columns;
end








