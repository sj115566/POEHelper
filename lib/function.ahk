;-----function--START--;
getstr(i){
    Array :={"Tra": "/交易 ", "Log": "/exit", "Oos": "/oos", "Afk": "/afk", "Hid": "/hideout", "Rem": "/剩餘怪物", "Inv": "/邀請 ", "Thx": Str_Thank, "Wait": Str_Wait}
    Return % Array[i]
}

Copy(y){
    Critical
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
    IfWinExist Path of Exile
    {
        WinActivate Path of Exile
        Send ^{Enter}
        Send % Copy("Thx")
    }
    Return
}

Trade(){
    IfWinExist Path of Exile
    {
        WinActivate Path of Exile
        Send ^{Enter}
        Send {Home}
        Send {Delete}
        Send % Copy("Tra")
    }
    Return
}

Invite(){
    IfWinExist Path of Exile
    {
        WinActivate Path of Exile
        Send ^{Enter}
        Send {Home}
        Send {Delete}
        Send % Copy("Inv")
    }
    Return
}

Reply(){
    IfWinExist Path of Exile
    {
        WinActivate Path of Exile
        Send ^{Enter}
        Send % Copy("Wait")
    }
    Return
}

Afk(){
    IfWinExist Path of Exile
    {
        WinActivate Path of Exile
        Send {Enter}        
        Sleep 2
        Send % Copy("Afk")
    }
    Return
}

Hideout(){
    IfWinExist Path of Exile
    {
        WinActivate Path of Exile
        Send {Enter}
        Sleep 2
        Send % Copy("Hid")
    }
    Return
}

OosCommand(){
    IfWinExist Path of Exile
    {
        WinActivate Path of Exile
        Send {Enter}
        Send % Copy("Oos")
    }
    Return
}

FastLogOut(){
    IfWinExist Path of Exile
    {
        WinActivate Path of Exile
        Send {Enter}
        Sleep 2
        Send % Copy("Log")
    }
    Return
}

CheckRemaining(){
    IfWinExist Path of Exile
    {
        WinActivate Path of Exile
        Send {Enter}
        Sleep 2
        Send % Copy("Rem")
    }
    Return
}

save(){
    MsgBox, 270336 , 儲存熱鍵, 儲存成功!`n即將自動重載...,0.75
    Gui, Submit, NoHide
;    Gui Destroy
    Reload
    Return
}

TurnOffHotKey(){
    loop % KeyList.Length()
        Hotkey ,% KeyList[A_Index],Off
    Return
}

;-----function--END---;