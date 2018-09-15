skins = {
    [13] = "Itachi",
    [14] = "Jiraiya"

}

function findSkin(name)
    for k,v in pairs(skin) do
        if string.upper(v) == string.upper(name) then return k end
    end
    return false
end

function randomSkin()
    local skinIds = {}
    for k,v in pairs(skins) do
        table.insert(skinIds,k)
    end
    return skinIds[math.random(1,#skinIds)]
end