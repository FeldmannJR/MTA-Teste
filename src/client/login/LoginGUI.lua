waiting = false
logado = false

function startLoginGUI()
    loginbg = guiCreateStaticImage(0,0,1,1,"resources/imgs/login/bg.jpg",true)
    window = guiCreateWindow(0.4,0.2,0.25,0.5,"Contas",true)
    tabPanel = guiCreateTabPanel(0,0.05,1,1,true,window)
    guiSetAlpha(window,1)
    guiWindowSetSizable(window,false)
    guiWindowSetMovable(window,false)

    --Login tab
    login_gui = guiCreateTab("Login",tabPanel)
    tamX = 0.8
    tamY = 0.1
    espaco = 0.1
    startY = 0.2
    restoX = (1-tamX)/2
    --Login label
    login_label = guiCreateLabel(restoX,0.05,tamX,0.05,"Digite seus dados para logar",true,login_gui)
    guiLabelSetHorizontalAlign(login_label,"center")
    guiLabelSetVerticalAlign(login_label,"center")
    Y = startY
    -- Username input
    user = guiCreateEdit(restoX, startY, tamX, tamY ,"",true,login_gui)
    user_label = guiCreateLabel(restoX+0.01,startY-0.05,tamX,0.05,"Usuario",true,login_gui)
    guiLabelSetHorizontalAlign(user_label,"left")
    guiLabelSetVerticalAlign(user_label,"center")
    Y = Y + tamY
    --Password input
    pass_label = guiCreateLabel(restoX+0.01,Y+espaco-0.05,tamX,0.05,"Senha",true,login_gui)
    guiLabelSetHorizontalAlign(pass_label,"left")
    guiLabelSetVerticalAlign(pass_label,"center")
    password = guiCreateEdit(restoX,Y+espaco ,tamX, tamY,"",true,login_gui)
    Y= Y + tamY + espaco
    guiEditSetMaxLength(user, 32)
    guiEditSetMaxLength(password, 32)
    guiEditSetMasked(password, true)
    
    -- Remember
    remember = guiCreateCheckBox(0.37,Y+0.03,0.25,0.05,"Lembrar senha",false,true,login_gui)
    
    --Login error
    login_error = guiCreateLabel(restoX,0.6,tamX,0.05,"",true,login_gui)
    guiLabelSetHorizontalAlign(login_error,"center")
    guiLabelSetVerticalAlign(login_error,"center")

    -- AUto login button
    autologin_button = guiCreateButton(0.1,0.7,0.8,0.1,"Auto Login",true,login_gui)
    guiSetVisible(autologin_button,false)

    --Login button
    login_button = guiCreateButton(0.1,0.85,0.8,0.1,"LOGIN",true,login_gui)


    

    --Register tab
    register_gui = guiCreateTab("Registrar",tabPanel)
    register_label = guiCreateLabel(restoX,0.05,tamX,0.1,"Para cadastrar preencha os campos e clique em cadastrar",true,register_gui)
    guiLabelSetHorizontalAlign(register_label,"center")
    guiLabelSetVerticalAlign(register_label,"center")
    --Usuario
    register_user = guiCreateEdit(restoX, 0.2, tamX, tamY ,"",true,register_gui)
    register_user_label = guiCreateLabel(restoX+0.01,0.15,tamX,0.05,"Usuario",true,register_gui)
    guiLabelSetHorizontalAlign(register_user_label,"left")
    guiLabelSetVerticalAlign(register_user_label,"center")
    --Senha 1
    register_password = guiCreateEdit(restoX, 0.4, tamX, tamY ,"",true,register_gui)
    register_password_label = guiCreateLabel(restoX+0.01,0.35,tamX,0.05,"Senha",true,register_gui)
    guiLabelSetHorizontalAlign(register_user_label,"left")
    guiLabelSetVerticalAlign(register_user_label,"center")
     --Senha 2
    register_cpassword = guiCreateEdit(restoX, 0.6, tamX, tamY ,"",true,register_gui)
    register_cpassword_label = guiCreateLabel(restoX+0.01,0.55,tamX,0.05,"Confirmar Senha",true,register_gui)
    guiLabelSetHorizontalAlign(register_user_label,"left")
    guiLabelSetVerticalAlign(register_user_label,"center")
    -- Error label
    register_error = guiCreateLabel(restoX,0.75,tamX,0.05,"",true,register_gui)
    guiLabelSetColor(register_error,255,0,0)
    guiLabelSetHorizontalAlign(register_error,"center")
    guiLabelSetVerticalAlign(register_error,"center")

    guiEditSetMaxLength(register_user, 32)
    guiEditSetMaxLength(register_password, 32)
    guiEditSetMaxLength(register_cpassword, 32)
    guiEditSetMasked(register_cpassword, true)
    guiEditSetMasked(register_password, true)

    register_button = guiCreateButton(restoX,0.85,tamX,0.1,"Registrar",true,register_gui)

    guiSetVisible(window,false); 
    guiSetVisible(loginbg,false)

    addEventHandler("onClientGUIClick",autologin_button,clickAutoLoginButton,false)
    addEventHandler("onClientGUIClick",login_button,clickLoginButton,false)
    addEventHandler("onClientGUIClick",register_button,clickRegisterButton,false)

end


function clickRegisterButton(button,state)
    if waiting then return end
    if button == "left" and state == "up" then
        local i_user = guiGetText(register_user)
        local i_password = guiGetText(register_password)
        local i_cpassword = guiGetText(register_cpassword)
        if i_user and i_password and i_cpassword then
            if i_password ~= i_cpassword then
                errorRegister("Senhas não conferem!")
                return
            end
            triggerServerEvent("submitRegister",getRootElement(),i_user,i_password)
            guiEditSetReadOnly(register_user, true);
            guiEditSetReadOnly(register_password, true);
            guiEditSetReadOnly(register_cpassword, true);
            waiting = true
        end
    end
end

function clickLoginButton(button,state)
    if waiting then return end
    if button == "left" and state == "up" then
        local i_user = guiGetText(user)
        local i_password = guiGetText(password)
        if i_user and i_password then
            triggerServerEvent("submitLogin",getRootElement(),i_user,i_password,guiCheckBoxGetSelected(remember))
            guiEditSetReadOnly(user, true);
            guiEditSetReadOnly(password, true);
            waiting = true
        end
    end
end

function clickAutoLoginButton(button,state)
    if waiting then return end
    if button == "left" and state == "up" then
        local i_user,i_token = getAutoLogin()
        if i_user and i_token then
            triggerServerEvent("submitAutoLogin",getRootElement(),i_user,i_token)
            guiEditSetReadOnly(user, true);
            guiEditSetReadOnly(password, true);
            waiting = true
        end
    end
end


function loginError(erro)
    guiEditSetReadOnly(user, false)
    guiEditSetReadOnly(password, false)
    guiSetText(login_error,erro)
    guiLabelSetColor(login_error,255,0,0)
    waiting = false
end

function errorRegister(msg)
    guiSetText(register_error,msg)
end

function loginSuccess()
    showCursor(false)
    guiSetVisible(window,false)
    guiSetVisible(loginbg,false)
    guiSetInputEnabled(false)
    logado = true
    stopSound(loginSound)
    disableHud()
end

function getAutoLogin()
    local tokfile = fileOpen("logintoken.txt")
    if tokfile then 
        local cont = fileRead(tokfile,120);
        if cont then
            local spl = split(cont,";")
            if #spl == 2 then
                autologin_user = spl[1]
                autologin_token = spl[2]
                fileClose(tokfile)
                return autologin_user,autologin_token
            end
        end
        fileClose(tokfile)
   
    end
    return nil
end

function open()
    loginSound = playSound("resources/sounds/login.mp3",true)
    guiSetVisible(loginbg,true)
    guiSetVisible(window,true);    
    guiSetInputEnabled(true)
    showCursor(true)
    userAuto = getAutoLogin()
    if userAuto then
        guiSetText(autologin_button,"Entrar como "..userAuto)
        guiSetVisible(autologin_button,true)
    end
end

function handleLoginCallback(tipo,msg)
    if tipo == "success" then
        loginSuccess()
        if msg then
            local file = fileCreate("logintoken.txt")
            fileWrite(file,guiGetText(user)..";"..msg)
            fileClose(file)
        end
    elseif tipo == "error" then
        loginError(msg)
    end
end

function handleRegisterCallback(tipo,msg)
    if tipo == "success" then
       guiSetSelectedTab(tabPanel,login_gui)
       guiSetText(login_error,"Conta registrada com sucesso! Agora logue!")
       guiLabelSetColor(login_error,0,255,0)
       waiting = false
    elseif tipo == "error" then
        guiEditSetReadOnly(register_user, false)
        guiEditSetReadOnly(register_password, false)
        guiEditSetReadOnly(register_cpassword, false)
        errorRegister(msg)
        waiting = false
    end
end
function handleAutoLogin(res)
    if res =="invalid" then
        loginError("Chave de autenticação inválida!")
        guiSetVisible(autologin_button,false)
        fileDelete("logintoken.txt")
        return
    end
    if res == "success" then
        loginSuccess()
    end        
end



startLoginGUI()

addEvent("receiveLogin",true);
addEventHandler("receiveLogin",localPlayer,handleLoginCallback)

addEvent("receiveAutoLogin",true);
addEventHandler("receiveAutoLogin",localPlayer,handleAutoLogin)


addEvent("receiveRegister",true);
addEventHandler("receiveRegister",localPlayer,handleRegisterCallback)


addEvent("openLogin",true)
addEventHandler("openLogin",localPlayer,open)
