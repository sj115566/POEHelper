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

CheckRemaining(){
    IfWinExist Path of Exile
    {
        WinActivate Path of Exile
        Send {Enter}
        Send % Copy("Rem")
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
;-----For some features--END--;
;---------------------------------------------------------;
;-----For App function--START--;

save(){
    if HotkeyNoConflict()
    {
        MsgBox, 270336 , 儲存, 儲存成功!`n即將自動重載...,0.75
        Gui, Submit, NoHide
        Reload
    }Else if (!HotkeyNoConflict()){
        MsgBox, 270352 , 儲存, 儲存失敗!`n有熱鍵尚未設定
    }Else{
        MsgBox, 270352 , 儲存, 儲存失敗!
    }
    Return
}

HotkeyNoConflict(){
    For k,v in NewKeyList
    {
        if v{
            Return True
        }Else{
            Return False
        }
    }
}

TurnOffHotKey(){
    loop % KeyList.Length()
        Hotkey ,% KeyList[A_Index],Off
    Return
}

;-----For App function--END--;
;---------------------------------------------------------;
;----------------For Trade Partner --BELOW-------------;
;-----For TP function--START--;
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
;-----For TP function--END--;
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

CheckLogChange(LogFile,ByRef PreviousSize:=0){
    FileEncoding, UTF-8
    FileGetSize nowsize, %LogFile%
    If(nowsize != PreviousSize){
;#For debug        MsgBox update from %PreviousSize% to %nowsize% .!
        PreviousSize := nowsize
        If (Data := GetLogData(LogFile)){
            Global BuyerInfo
            BuyerInfo.Date.Push(Data.Date)
            BuyerInfo.Time.Push(Data.Time)
            BuyerInfo.ID.Push(Data.ID)
            BuyerInfo.Item.Push(Data.Item)
            BuyerInfo.Slashtab.Push(Data.Slashtab)
            BuyerInfo.Pos.Push(Data.Pos)
            BuyerInfo.Price.Push(Data.Price)
            For k,v in BuyerInfo
                Loop v.Length()
                    if v[A_Index]
                        v.RemoveAt[A_Index]
            Return True
        } 
    } Else{
        Return False
    }
    Sleep 5
}

GetLogData(POElog,Idlog:="",Itemlog:="",Tablog:="",Poslog:="",Pricelog:="",Infolog:=""){
    FileEncoding, UTF-8
    Loop, read, %POElog% 
    last_line := A_LoopReadLine     
    if( findAt := InStr(last_line, "@")){               ;如果讀最後一行找到@表示密語才執行
;#For debug            MsgBox 是密語
        PMContent := SubStr(last_line, findAt)          ;私訊內容PMContent := @開始往後的文字
        InfoContent := SubStr(last_line, 1 , 19)        ;時間資訊InfoContent := 從1~19的字元
        Array_PMSplit := StrSplit(PMContent, A_Space)   ;將私訊內容以空白作為分隔存到Array_PMSplit
        MatchCount := 0                                 ;計數符合格式的數量
        Loop, % Array_PMSplit.MaxIndex()        
        {
            var := % Array_PMSplit[A_Index]             ;暫存函數var 循環依序列舉出Array_PMSplit的東西
;#For debug                MsgBox % var
            if var in %OfficialText%                    ;判斷var是否與OfficialText中的string相符 (以,分隔)
            {
                MatchCount += 1                         ;有符合的話 +1
;#For debug                    MsgBox % "符合 " . MatchCount . " 項"
                if (MatchCount = OfficialTextList.MaxIndex() ){ ;若全部符合
                    Timeinfo := GetTimecode(InfoContent)
                    PlayerID := GetPlayerID(PMContent)
                    ItemText := GetItem(PMContent)
                    TabText := GetTab(PMContent)
                    PosInTabText := GetPosInTab(PMContent)
                    Price := GetPrice(PMContent)
                    MatchCount := 0         ;符合項目計數歸0
                    Return {Date:Timeinfo.Date, Time:Timeinfo.Time, ID:PlayerID, Item:ItemText, Slashtab:TabText, Pos:PosInTabText, Price:Price }
;                        Timeinfo "" PlayerID "`n" ItemText "`n" TabText "`n" PosInTabText "`n" Price
                }
            }
        }
    }
}

GetTimecode(content,log:=""){
    Date := SubStr(content,1,10)
    Time := SubStr(content,11)
    FileAppend, Date: %Date% `, Time: %Time%`n , %log%
;    Return, "日期: "Date . "`n" . "時間: "Time
    Return, {Date:Date,Time:Time }
}

GetPlayerID(content,log:=""){
    findColon := InStr(content, ":")
    if( findGuild := InStr(content, ">")){
        findSpace := InStr(content, " ", , , 2)
        tempidcontent := SubStr(content, 1, findColon-1)
        StringRight, PlayerID, tempidcontent, findColon-findSpace-1
    }Else{
        findSpace := InStr(content, " ")
        tempidcontent := SubStr(content, 1, findColon-1)
        StringRight, PlayerID, tempidcontent, findColon-findSpace-1
    }
    FileAppend, %PlayerID%`n , %log%
;    Return "玩家ID: "PlayerID
    Return, PlayerID
}

GetItem(content,log:=""){
    officialBuyText := OfficialTextList[1]
    officialPriceText := OfficialTextList[2]
    findBuyStart := InStr(content, officialBuyText)+StrLen(officialBuyText)+1
    findBuyEnd := InStr(content, officialPriceText,,findBuyStart)-1
    ItemContent := SubStr(content,findBuyStart,findBuyEnd-findBuyStart)
    FileAppend, %ItemContent%`n , %log%
;    Return "物品名稱: "ItemContent
    Return, ItemContent
}

GetTab(content,log:=""){
    officialTabText := OfficialTextList[3]
    findTabStart := InStr(content, officialTabText)+StrLen(officialTabText)+2
    findTabEnd := InStr(content,";",,findTabStart)-1
    StashTabContent := SubStr(content, findTabStart, findTabEnd-findTabStart)
    FileAppend, %StashTabContent%`n , %log%
;    Return "位於倉庫頁: "StashTabContent
    Return, StashTabContent
}

GetPosInTab(content,log:=""){
    officialPosText := OfficialTextList[4]
    findPosStart := InStr(content, officialPosText)+StrLen(officialPosText)+1
    findPosEnd := InStr(content,")",,findPosStart)
    PosInTabContent := SubStr(content, findPosStart, findPosEnd-findPosStart)
    FileAppend, %PosInTabContent%`n , %log%
;    Return "位置: "PosInTabContent
    Return, PosInTabContent
}

GetPrice(content,log:=""){
    officialPriceText := OfficialTextList[2]
    findPriceStart := InStr(content, officialPriceText)+StrLen(officialPriceText)+1
    findPriceEnd := InStr(content, " ", , findPriceStart, 2)
    PriceContent := SubStr(content, findPriceStart, findPriceEnd-findPriceStart)
    FileAppend, %PriceContent%`n , %log%
;    Return "標價: "PriceContent
    Return, PriceContent
}
;-----For TradePartner Data--START--;
;----------------For Trade Partner --ABOVE-------------;
;---------------------------------------------------------;