FileEncoding, UTF-8
#SingleInstance Force
#NoEnv

Global MainWin_X
Global MainWin_Y
Global TPWin_X
Global TPWin_Y
Global KeyList
Global NewKeyList
Global FeatureList
Global Key_ReplyWait
Global Key_Invite
Global Key_Hideout
Global Key_AFK
Global Key_Tradewith
Global Key_ReplyThank
Global Key_Logout
Global Key_OOS
Global Key_CheckRemain
Global sldr
Global LogPath
Global Str_Wait
Global Str_Thank
Global BuyerInfo:={Date:[],Time:[],ID:[],Item:[],Slashtab:[],Pos:[],Price:[]}

#Include %A_ScriptDir%\\lib\function.ahk
#Include %A_ScriptDir%\\lib\LV_EX.ahk
#Include %A_ScriptDir%\\lib\rwSetting.ahk
#Include %A_ScriptDir%\\lib\GUI.ahk

Return