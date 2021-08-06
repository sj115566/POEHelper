;-----function--START--;
getstr(i){
    Array :={"Tra": "/交易 ", "Log": "/exit", "Oos": "/oos", "Afk": "/afk", "Hid": "/hideout", "Rem": "/剩餘怪物", "Inv": "/邀請 ", "Thx": str_Thank, "Wait": str_Wait}
    Return % Array[i]
}

Copy(y){
    BlockInput On
    temp := clipboard
    clipboard:=
    clipboard:= % getstr(y)
    ClipWait,1
    Send ^v
    Send {Enter}
    BlockInput Off
    Sleep 50
    clipboard = %temp%
    ClipWait,1
    Return
}

Thanks(){
    WinActivate Path of Exile
    Send ^{Enter}
    Send % Copy("Thx")
    Return
}

Trade(){
    WinActivate Path of Exile
    Send ^{Enter}
    Send {Home}
    Send {Delete}
    Send % Copy("Tra")
    return
}

Invite(){
    WinActivate Path of Exile
    Send ^{Enter}
    Send {Home}
    Send {Delete}
    Send % Copy("Inv")
    return
}

Reply(){
    WinActivate Path of Exile
    Send ^{Enter}
    Send % Copy("Wait")
    return
}

Afk(){
    WinActivate Path of Exile
    Send {Enter}        
    Sleep 2
    Send % Copy("Afk")
    return
}

Hideout(){
    WinActivate Path of Exile
    Send {Enter}
    Sleep 2
    Send % Copy("Hid")
    return
}

OosCommand(){
    WinActivate Path of Exile
    Send {Enter}
    Send % Copy("Oos")
    return
}

FastLogOut(){
    WinActivate Path of Exile
    Send {Enter}
    Sleep 2
    Send % Copy("Log")
    return
}

CheckRemaining(){
    WinActivate Path of Exile
    Send {Enter}
    Sleep 2
    Send % Copy("Rem")
    return
}
;-----function--END---;
save(){
    MsgBox, 270336 , 儲存, 工作完成。,0.5
    Gui, Submit, NoHide
    Gui Destroy
    Reload
    Return
}
