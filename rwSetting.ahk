Obj_DefaultSetting:={   Key_ReplyWait   : "F2"
                      , Key_Invite      : "F3"
                      , Key_Hideout     : "F6"
                      , Key_AFK         : "F11"
                      , Key_Tradewith   : "F5"
                      , Key_ReplyThank  : "F4"
                      , Key_Logout      : "F7"
                      , Key_OOS         : "F12"
                      , LogPath         : "C:\Program Files (x86)\Garena\32808"              
                      , Str_Wait        : "稍等喔~"
                      , Str_Thank       : "謝謝~" }
                      
ReadSettings(obj_default = "") {
	static iniFile := SubStr(A_ScriptFullPath, 1, -StrLen(A_ScriptName)) "setting.ini"
	static obj_keyList := {}
	global
	local data, pos, k, v

	; =================================
	;		脚本退出时自动保存 ini
	; =================================
	static _ := { base: {__Delete: "ReadSettings"} }
	If !_ {
		Gui, Submit, NoHide

		For k, v in obj_keyList
			data .= k "=" %k% "`r`n"

		If data
            IniWrite, % data, % iniFile, Settings
		Return
	}

	; =================================
	;		读取 ini
	; =================================
	For k, v in obj_default
		%k% := v, obj_keyList[k] := ""

	If FileExist(iniFile) {
		IniRead, data, % iniFile, Settings
		If data {
			Loop, Parse, data, `n , `r
				If (  pos := InStr(A_LoopField, "=")  )
					k := SubStr(A_LoopField, 1, pos-1)
				,	v := SubStr(A_LoopField, pos+1)
				,	obj_keyList[k] := "", %k% := v
		}
	}
    ; =================================
	;		自訂按鍵綁定功能
	; =================================     
    if Key_ReplyWait
        Hotkey, % Key_ReplyWait, Reply
    if Key_Invite
        Hotkey, % Key_Invite, Invite
    if Key_Hideout
        Hotkey, % Key_Hideout, Hideout
    if Key_AFK
        Hotkey, % Key_AFK, Afk
    if Key_Tradewith
        Hotkey, % Key_Tradewith, Trade
    if Key_ReplyThank
        Hotkey, % Key_ReplyThank, Thanks
    if Key_Logout
        Hotkey, % Key_Logout, FastLogOut
    if Key_OOS
        Hotkey, % Key_OOS, OosCommand

}