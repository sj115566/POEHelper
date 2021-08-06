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
    if re
        Hotkey, % re, Reply
    if i
        Hotkey, % i, Invite
    if h
        Hotkey, % h, Hideout
    if a
        Hotkey, % a, Afk
    if tr
        Hotkey, % tr, Trade
    if th
        Hotkey, % th, Thanks
    if l
        Hotkey, % l, FastLogOut
    if o
        Hotkey, % o, OosCommand

}