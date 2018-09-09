login_gui = guiCreateWindow(0.4,0.2,0.25,0.5,"Login",true)
guiWindowSetSizable(login_gui,false)
guiWindowSetMovable(login_gui,false)
tamX = 0.8
tamY = 0.1
espaco = 0.1
startY = 0.3
restoX = (1-tamX)/2
login_label = guiCreateLabel(restoX,0.1,tamX,0.2,"Eh us guri",true,login_gui)
guiLabelSetHorizontalAlign(login_label,"center")
guiLabelSetVerticalAlign(login_label,"center")

Y = startY
user = guiCreateEdit(restoX, startY, tamX, tamY ,"",true,login_gui)
user_label = guiCreateLabel(restoX,startY-0.05,tamX,0.05,"Usuario",true,login_gui)
guiLabelSetHorizontalAlign(user_label,"left")
guiLabelSetVerticalAlign(user_label,"center")

Y = Y + tamY
password = guiCreateEdit(restoX,Y+espaco ,tamX, tamY,"",true,login_gui)
Y= Y + tamY + espaco
guiEditSetMaxLength(user, 50)
guiEditSetMaxLength(password, 50)
guiEditSetMasked(password, true)
button = guiCreateButton(0.1,0.7,0.8,0.2,"LOGIN",true,login_gui)
guiSetVisible(login_gui,false);  
addEventHandler("onClientGUIClick",button,clickButton,false)


function clickButton(button,state)
    if button == "left" and state == "up" then
        local i_user = guiGetText(user)
        local i_password = guiGetText(password)

        triggerServerEvent("onLoginEnter",resourceRoot,i_user,i_password)
        showCursor(false)
        guiSetVisible(login_gui,false)
        guiSetInputEnabled(false)

    end
end

function open()
    guiSetVisible(login_gui,true);    
    guiSetInputEnabled(true)
    showCursor(true)
end

addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), open)

