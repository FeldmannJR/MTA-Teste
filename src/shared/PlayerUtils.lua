function Player:msg(mesage)
    outputChatBox(mesage,self,255,255,255,true)
 end
 
 function msg(mesage)
     outputChatBox(mesage,getRootElement(),255,255,255,true)
 end
 
 function sendMessageInVehicle(veh,msg)
    for k,occ in pairs(getVehicleOccupants(veh)) do
        occ:msg(msg)
    end   
 end