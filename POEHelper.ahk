#Include %A_ScriptDir%\\function.ahk
#Include %A_ScriptDir%\\rwSetting.ahk
#Include %A_ScriptDir%\\GUI.ahk
#Include %A_ScriptDir%\\LogPathFinder.ahk
#Include %A_ScriptDir%\\lib\LV_EX.ahk
#SingleInstance Force
#NoEnv

Global Key_ReplyWait
Global Key_Invite
Global Key_Hideout
Global Key_AFK
Global Key_Tradewith
Global Key_ReplyThank
Global Key_Logout
Global Key_OOS
Global sldr
Global LogPath
Global Str_Wait
Global Str_Thank

Gosub window
Return
