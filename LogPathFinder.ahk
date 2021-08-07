LogPath(){
    OnMessage(0x40044, "OnMsgBox")
    MsgBox 0x1, LogPathFinder, 目前選取路徑:%LogPath%`n若與遊戲安裝位置不同，請重新選取
    OnMessage(0x40044, "")

    IfMsgBox OK, {
        SetBatchLines, -1
        FileSelectFolder , folderPath , , 0,請選擇含有log檔案的資料夾(通常選擇POE安裝位置即可)
        Loop ,%folderPath%\*.* , 1 ,1
        {
            Loop, Parse, A_LoopFileName
            {
                poeexe = %A_LoopFileName%
                if poeexe = Client.txt 
                {
                    Gui MsgBox:+OwnDialogs
                    MsgBox 0x0, LogPathFinder - Successed!, %A_LoopFileFullPath%`n路徑已儲存
                    LogPath = %A_LoopFileFullPath%
                    Return
                }
            }
            
        }
        Gui MsgBox:+OwnDialogs
        MsgBox 0x10, LogPathFinder - Failed!, 未成功儲存，或是選取的路徑中找不到Log檔
            
    }Else IfMsgBox Cancel, {
        MsgBox 0x10, LogPathFinder - Canceled!, 取消操作
        Return
    }
}