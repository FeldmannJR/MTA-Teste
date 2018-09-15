local screenW, screenH = guiGetScreenSize()

function drawVehicleHud()
    local veh = getPedOccupiedVehicle(getLocalPlayer())
    if veh then
        local fuel 
        local vehid = getElementModel(veh)       
        if getVehicleFuelData(vehid).maxFuel > 0 then
            fuel = getElementData(veh,"fuel")
            if not fuel then
                fuel = 0
            end
            if fuel<=0 then
                fuel = "#840606Sem gasosa"
            else
                fuel = tostring(math.ceil(fuel))
            end
        else
            fuel = "#66C600Não possuí"
        end
        local fuelC = fuel
        fuel = string.gsub(fuel, "#%x%x%x%x%x%x", "")
        local life = tostring(math.floor(getElementHealth(veh)/10)).."%"
        local speed = tostring(math.floor(getElementSpeed(veh,1))).."km/h"
        local carname = getCarName(vehid)
        if not carname then
           carname =  getVehicleNameFromModel(vehid)
        end
        local cr,cg,cb = getVehicleColor(veh,true)
        local bri = getColorBrightness(cr,cg,cb)
        if bri < 0.2 then
            cr,cg,cb = changeColorBrightness(cr,cg,cb,0.4)
        end
        local nameColor = tocolor(cr,cg,cb,255)
    
        -- https://forum.mtasa.com/topic/18758-rel-gui-editor-313/ Esse cara ai é pica
        dxDrawLine((screenW * 0.0255) - 1, (screenH * 0.6417) - 1, (screenW * 0.0255) - 1, screenH * 0.7472, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.1979, (screenH * 0.6417) - 1, (screenW * 0.0255) - 1, (screenH * 0.6417) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.0255) - 1, screenH * 0.7472, screenW * 0.1979, screenH * 0.7472, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.1979, screenH * 0.7472, screenW * 0.1979, (screenH * 0.6417) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.0255, screenH * 0.6417, screenW * 0.1724, screenH * 0.1056, tocolor(165,165,165, 226), false)
        dxDrawText(carname, (screenW * 0.0255) - 1, (screenH * 0.6509) - 1, (screenW * 0.1979) - 1, (screenH * 0.6778) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(carname, (screenW * 0.0255) + 1, (screenH * 0.6509) - 1, (screenW * 0.1979) + 1, (screenH * 0.6778) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(carname, (screenW * 0.0255) - 1, (screenH * 0.6509) + 1, (screenW * 0.1979) - 1, (screenH * 0.6778) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(carname, (screenW * 0.0255) + 1, (screenH * 0.6509) + 1, (screenW * 0.1979) + 1, (screenH * 0.6778) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(carname, screenW * 0.0255, screenH * 0.6509, screenW * 0.1979, screenH * 0.6778, nameColor, 1.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText("Gasosa", (screenW * 0.0255) - 1, (screenH * 0.6778) - 1, (screenW * 0.0828) - 1, (screenH * 0.6991) - 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Gasosa", (screenW * 0.0255) + 1, (screenH * 0.6778) - 1, (screenW * 0.0828) + 1, (screenH * 0.6991) - 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Gasosa", (screenW * 0.0255) - 1, (screenH * 0.6778) + 1, (screenW * 0.0828) - 1, (screenH * 0.6991) + 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Gasosa", (screenW * 0.0255) + 1, (screenH * 0.6778) + 1, (screenW * 0.0828) + 1, (screenH * 0.6991) + 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Gasosa", screenW * 0.0255, screenH * 0.6778, screenW * 0.0828, screenH * 0.6991, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(fuel, (screenW * 0.0255) - 1, (screenH * 0.7028) - 1, (screenW * 0.0828) - 1, (screenH * 0.7222) - 1, tocolor(0, 0, 0, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText(fuel, (screenW * 0.0255) + 1, (screenH * 0.7028) - 1, (screenW * 0.0828) + 1, (screenH * 0.7222) - 1, tocolor(0, 0, 0, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText(fuel, (screenW * 0.0255) - 1, (screenH * 0.7028) + 1, (screenW * 0.0828) - 1, (screenH * 0.7222) + 1, tocolor(0, 0, 0, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText(fuel, (screenW * 0.0255) + 1, (screenH * 0.7028) + 1, (screenW * 0.0828) + 1, (screenH * 0.7222) + 1, tocolor(0, 0, 0, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText(fuelC, screenW * 0.0255, screenH * 0.7028, screenW * 0.0828, screenH * 0.7222, tocolor(255, 255, 255, 255), 1.20, "sans", "center", "center", false, false, false, true, false)
        dxDrawText(life, (screenW * 0.0828) - 1, (screenH * 0.7028) - 1, (screenW * 0.1401) - 1, (screenH * 0.7222) - 1, tocolor(0, 0, 0, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText(life, (screenW * 0.0828) + 1, (screenH * 0.7028) - 1, (screenW * 0.1401) + 1, (screenH * 0.7222) - 1, tocolor(0, 0, 0, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText(life, (screenW * 0.0828) - 1, (screenH * 0.7028) + 1, (screenW * 0.1401) - 1, (screenH * 0.7222) + 1, tocolor(0, 0, 0, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText(life, (screenW * 0.0828) + 1, (screenH * 0.7028) + 1, (screenW * 0.1401) + 1, (screenH * 0.7222) + 1, tocolor(0, 0, 0, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText(life, screenW * 0.0828, screenH * 0.7028, screenW * 0.1401, screenH * 0.7222, tocolor(255, 255, 255, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText("Vida", (screenW * 0.0828) - 1, (screenH * 0.6778) - 1, (screenW * 0.1401) - 1, (screenH * 0.6991) - 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Vida", (screenW * 0.0828) + 1, (screenH * 0.6778) - 1, (screenW * 0.1401) + 1, (screenH * 0.6991) - 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Vida", (screenW * 0.0828) - 1, (screenH * 0.6778) + 1, (screenW * 0.1401) - 1, (screenH * 0.6991) + 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Vida", (screenW * 0.0828) + 1, (screenH * 0.6778) + 1, (screenW * 0.1401) + 1, (screenH * 0.6991) + 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Vida", screenW * 0.0828, screenH * 0.6778, screenW * 0.1401, screenH * 0.6991, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Velocidade", (screenW * 0.1401) - 1, (screenH * 0.6778) - 1, (screenW * 0.1974) - 1, (screenH * 0.6991) - 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Velocidade", (screenW * 0.1401) + 1, (screenH * 0.6778) - 1, (screenW * 0.1974) + 1, (screenH * 0.6991) - 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Velocidade", (screenW * 0.1401) - 1, (screenH * 0.6778) + 1, (screenW * 0.1974) - 1, (screenH * 0.6991) + 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Velocidade", (screenW * 0.1401) + 1, (screenH * 0.6778) + 1, (screenW * 0.1974) + 1, (screenH * 0.6991) + 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Velocidade", screenW * 0.1401, screenH * 0.6778, screenW * 0.1974, screenH * 0.6991, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(speed, (screenW * 0.1406) - 1, (screenH * 0.7028) - 1, (screenW * 0.1979) - 1, (screenH * 0.7222) - 1, tocolor(0, 0, 0, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText(speed, (screenW * 0.1406) + 1, (screenH * 0.7028) - 1, (screenW * 0.1979) + 1, (screenH * 0.7222) - 1, tocolor(0, 0, 0, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText(speed, (screenW * 0.1406) - 1, (screenH * 0.7028) + 1, (screenW * 0.1979) - 1, (screenH * 0.7222) + 1, tocolor(0, 0, 0, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText(speed, (screenW * 0.1406) + 1, (screenH * 0.7028) + 1, (screenW * 0.1979) + 1, (screenH * 0.7222) + 1, tocolor(0, 0, 0, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
        dxDrawText(speed, screenW * 0.1406, screenH * 0.7028, screenW * 0.1979, screenH * 0.7222, tocolor(255, 255, 255, 255), 1.20, "sans", "center", "center", false, false, false, false, false)
    end
end



addEventHandler("onClientRender",root,drawVehicleHud)