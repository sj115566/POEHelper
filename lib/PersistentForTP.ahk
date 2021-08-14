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
    Return, {Date:Date,Time:Time}
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