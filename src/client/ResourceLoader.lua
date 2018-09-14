skins = {
    [1] = "Lula",
    [9] = "Dilma",
    [36] = "Bolsonaro"
}

weapons = {
    [336] = "pixuleco"
}
anims = {}

function loadTxts(data,pasta)
    for k,v in pairs(data) do
        id = k
        txd = engineLoadTXD("resources/"..pasta.."/"..v..".txd")
        print(tostring(k) .. " - "..v)
        engineImportTXD(txd,id)
        dff = engineLoadDFF("resources/"..pasta.."/"..v..".dff", id)
        engineReplaceModel(dff,id)
    end
    outputDebugString("Cars loaded")

end

function loadAnims()
    for k,v in ipairs(anims) do
        engineLoadIFP(v..".ifp",v)
    end
    outputDebugString("Anims loaded")

end
function convertVehicles()
    listV = {}
    for k,v in vehicleList do
        if v.load then 
            listV[k] = v.nome
        end
    end
    return listV
end

function load()
    loadTxts(convertVehicles(),"vehicles")
    loadTxts(skins,"skins")
    loadTxts(weapons,"weapons")
   -- loadAnims()
end

addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), load)
