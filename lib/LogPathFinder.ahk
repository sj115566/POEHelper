LogPathFinder(){
    if FileExist(LogPath){
        MsgBox 0x0, LogPathFinder, 已經指定到正確位置，無須重新選擇`n目前路徑 %LogPath%
        Return
    }else{
        Gui +OwnDialogs
        MsgBox 0x30, LogPathFinder, 在目前路徑 %LogPath% 中未找到Log檔!`n請重新選取路徑
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
                        IniWrite, LogPath, %A_ScriptDir%\\setting.ini, Settings
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
}