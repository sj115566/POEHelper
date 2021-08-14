;---------------------------------------------------------;
;-----For some features--START--;
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
    clipboard := temp
    ClipWait,1
    Return
}
IDCopy(i){
    clipboard := i
    ClipWait,1
    Return i
}
TPPM(i){
    PM := "@" . i . " "
    clipboard := PM
    ClipWait,1
    Return i
}

TPInvite(n){
    IfWinExist Path of Exile
    {
        WinActivate Path of Exile
        tempclipboard := Clipboard
        cmd := getstr("Inv") IDCopy(n)
        Clipboard := cmd
        ClipWait,1
        Send {Enter}
        Send ^a
        Send ^v
        Send {Enter}
        Sleep 50
        Clipboard := tempclipboard
        ClipWait,1
        Return
    }
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
;-----For some features--END--;
;---------------------------------------------------------;
;-----For App function--START--;
save(){
    MsgBox, 270336 , 儲存, 儲存成功!`n即將自動重載...,0.75
    Gui, Submit, NoHide
    Reload
    Return
}

TurnOffHotKey(){
    loop % KeyList.Length()
        Hotkey ,% KeyList[A_Index],Off
    Return
}

;-----For App function--END--;
;---------------------------------------------------------;
;-----For Set Log Path--START--;
LogPathFinder(){
    if FileExist(LogPath){
        OnMessage(0x44, "Reselect")
        Gui +OwnDialogs
        MsgBox 0x1, LogPathFinder, 已經指定到正確位置，無須重新選擇`n目前路徑 %LogPath%
        OnMessage(0x44, "")
        IfMsgBox OK, {
            if (FindLog()<2){
                Return
            }Else {
                MsgBox 0x10, LogPathFinder - failed!, 在選取路徑中找不到 Log
            }
        }Else IfMsgBox Cancel, {
            Return
        }     
    }else{
        MsgBox 0x30, LogPathFinder, 在目前路徑 %LogPath% 中未找到Log檔!`n請重新選取路徑
        IfMsgBox OK, {
            if (FindLog()<2){
                Return
            }Else {
                MsgBox 0x10, LogPathFinder - failed!, 在選取路徑中找不到 Log
            }
        }Else IfMsgBox Cancel, {
            MsgBox 0x10, LogPathFinder - Canceled!, 取消操作
            Return
        }
    }
}
Reselect(){
    DetectHiddenWindows, On
    Process, Exist
    If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
        ControlSetText Button1, 重新選擇
        ControlSetText Button2, 確定
    }
}
FindLog(){
    SetBatchLines, -1
    FileSelectFolder , folderPath , , 0,請選擇含有log檔案的資料夾(通常選擇POE安裝位置即可)
    if (ErrorLevel != 1){
        Loop ,%folderPath%\*.* , 1 ,1
        {
            Loop, Parse, A_LoopFileName
            {
                poeexe = %A_LoopFileName%
                if poeexe = Client.txt 
                {
                    Gui MsgBox:+OwnDialogs
                    MsgBox 0x0, LogPathFinder - Successed!, %A_LoopFileFullPath%`n路徑已儲存
                    global LogPath
                    LogPath := A_LoopFileFullPath
                    save()
                    Return 1
                }
            }
        }
        Return 2
    }Else{
        Gui MsgBox:+OwnDialogs
        MsgBox 0x10, LogPathFinder - Canceled!, 取消操作
        Return 0
    }
}
;-----For Set Log Path--END--;
;---------------------------------------------------------;
;-----For TradePartner Data--START--;
Global officialText := "你好，我想購買,標價,(倉庫頁,位置:"        ;自己抓出官方交易市集的密語格式(當定位點的字串)
Global OfficialTextList := StrSplit(OfficialText, ",")            ;把上面那串字以逗號分隔成 一個array

;-----For TradePartner Data--START--;
;---------------------------------------------------------;