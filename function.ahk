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
    BlockInput On
    Send ^{Enter}
    Send {Home}
    Send {Delete}
    Send % Copy("Tra")
    BlockInput Off
    return
}

Invite(){
    WinActivate Path of Exile
    BlockInput On
    Send ^{Enter}
    Send {Home}
    Send {Delete}
    Send % Copy("Inv")
    BlockInput Off
    return
}

Reply(){
    WinActivate Path of Exile
    BlockInput On
    Send ^{Enter}
    Send % Copy("Wait")
    BlockInput Off
    return
}

Afk(){
    WinActivate Path of Exile
    BlockInput On
    Send {Enter}        
    Sleep 2
    Send % Copy("Afk")
    BlockInput Off
    return
}

Hideout(){
    WinActivate Path of Exile
    BlockInput On
    Send {Enter}
    Sleep 2
    Send % Copy("Hid")
    BlockInput Off
    return
}

OosCommand(){
    WinActivate Path of Exile
    BlockInput On
    Send {Enter}
    Send % Copy("Oos")
    BlockInput Off
    return
}

FastLogOut(){
    WinActivate Path of Exile
    BlockInput On
    Send {Enter}
    Sleep 2
    Send % Copy("Log")
    BlockInput Off
    return
}

CheckRemaining(){
    WinActivate Path of Exile
    BlockInput On
    Send {Enter}
    Sleep 2
    Send % Copy("Rem")
    BlockInput Off
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