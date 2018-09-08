DB = {}

PlayerStruct = {
    money = "INTEGER",
    carro = "TEXT",
}

function DB.init()
    DB.connect();
end

function DB.connect()
    DB.conn = dbConnect("mysql","host="..get("dbHost")..";charset=utf8;unix_socket=/var/run/mysqld/mysqld.sock;dbname="..get("dbName"),get("dbUser"),get("dbPassword"),"autoReconnect=1");
    if(DB.conn) then
        DB.conn:exec("CREATE TABLE IF NOT EXISTS players (id INTEGER AUTO_INCREMENT PRIMARY KEY, name VARCHAR(36), password TEXT)")
        DB:alterTables()
    end
end

function DB.alterTables()
    local colunas = DB.getColumns("player");
    

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








