;-----MainWindow--START---;
window:
{
    ReadSettings( Obj_DefaultSetting )
    WindowTitle = POE小幫手-131
    CustomColor =  White 
    opacity = 255
    opacityPercent = 50

    
    Gui Main:Default
    Gui +LastFound +OwnDialogs +LabelMain
    WinSet, Transparent,%opacity% 
    Gui Color, %CustomColor%
    Gui Font, s9, Segoe UI
    Gui Add, GroupBox, x7 y3 w424 h394 +Center, %WindowTitle%
    Gui Add, Button, gReply         x21  y25  w130 h36, 自動回覆：稍等
    Gui Add, Button, gInvite        x21  y71  w130 h36, 邀請組隊
    Gui Add, Button, gHideout       x21  y117 w130 h36, 回藏身處
    Gui Add, Button, gAfk           x21  y163 w130 h36, AFK
    Gui Add, Button, gTrade         x21  y209 w130 h36, 交易
    Gui Add, Button, gThanks        x21  y255 w130 h36, 自動回覆：感謝
    Gui Add, Button, gFastLogOut    x21  y301 w130 h36, 快速登出
    Gui Add, Button, gOosCommand    x21  y347 w130 h36, OOS
    Gui Add, Button, gTradePartner  x310 y25  w100 h36, 交易夥伴
    Gui Add, Button, gEditWindow    x310 y255 w100 h36 , 編輯熱鍵
    Gui Add, Button, gEditLogPath    x310 y209 w100 h36 , 編輯Log路徑
    Gui Add, Text, x310 y325 w100 h36, 調整視窗透明度
    Gui Add, Slider, vSldr gopacity x300 y352 w120 h32, %opacity%
    Gui Add, Text, x155 y35  w70 h21 Center ,%Key_ReplyWait%
    Gui Add, Text, x155 y81  w70 h21 Center ,%Key_Invite%
    Gui Add, Text, x155 y127 w70 h21 Center ,%Key_Hideout%
    Gui Add, Text, x155 y177 w70 h21 Center ,%Key_AFK%
    Gui Add, Text, x155 y220 w70 h21 Center ,%Key_Tradewith%
    Gui Add, Text, x155 y264 w70 h21 Center ,%Key_ReplyThank%
    Gui Add, Text, x155 y312 w70 h21 Center ,%Key_Logout%
    Gui Add, Text, x155 y356 w70 h21 Center ,%Key_OOS%
    Gui Show, w439 h409, %WindowTitle%
    Return
    
    MainClose:
    ReadSettings( Obj_DefaultSetting )
    ExitApp

;-----MainWindow END-----;
}

;-----編輯視窗--START---;
EditWindow:
{
    TurnOffHotKey()
    Gui +Disabled
    Gui,EditGui:+OwnerMain -SysMenu +AlwaysOnTop +OwnDialogs
    Gui EditGui:Font, s9 w500, Segoe UI
    Gui EditGui:Add, Text,x21  y34  w130 h36, 自動回覆：稍等
    Gui EditGui:Add, Text,x21  y80  w130 h36, 邀請組隊
    Gui EditGui:Add, Text,x21  y127 w130 h36, 回藏身處
    Gui EditGui:Add, Text,x21  y173 w130 h36, AFK
    Gui EditGui:Add, Text,x21  y219 w130 h36, 交易
    Gui EditGui:Add, Text,x21  y265 w130 h36, 自動回覆：感謝
    Gui EditGui:Add, Text,x21  y311 w130 h36, 快速登出
    Gui EditGui:Add, Text,x21  y356 w130 h36, OOS
    Gui EditGui:Add, Button,x310 y301 w100 h36 gSave , 儲存
    Gui EditGui:Add, Hotkey, x174 y31  w70 h21 vKey_ReplyWait,% Key_ReplyWait
    Gui EditGui:Add, Hotkey, x174 y77  w70 h21 vKey_Invite,% Key_Invite
    Gui EditGui:Add, Hotkey, x174 y123 w70 h21 vKey_Hideout,% Key_Hideout
    Gui EditGui:Add, Hotkey, x174 y169 w70 h21 vKey_AFK,% Key_AFK
    Gui EditGui:Add, Hotkey, x174 y215 w70 h21 vKey_Tradewith,% Key_Tradewith
    Gui EditGui:Add, Hotkey, x174 y261 w70 h21 vKey_ReplyThank,% Key_ReplyThank
    Gui EditGui:Add, Hotkey, x174 y307 w70 h21 vKey_Logout,% Key_Logout
    Gui EditGui:Add, Hotkey, x174 y353 w70 h21 vKey_OOS,% Key_OOS
    Gui EditGui:Add, Edit,Limit x260 y31 w150 h21 vStr_Wait,% Str_Wait
    Gui EditGui:Add, Edit,Limit x260 y261 w150 h21 vStr_Thank,% Str_Thank
    Gui,EditGui:show,w439 h409,Edithotkey
    Return 
}
;-----編輯視窗--END---;

;-----交易夥伴--START---;
TradePartner:
{
    GuiControl Text, 交易夥伴, 交易夥伴`n(已開啟)
    GuiControl Disable , 交易夥伴`n(已開啟)
    #Include %A_ScriptDir%\\lib\TradePartner.ahk
    Return
}
;-----交易夥伴--END---;

;-----透明度調整--START---;
opacity:
{
    opacity := round(((sldr*255)/100))+30
    Winset Transparent, %opacity%
    Return
}
;-----透明度調整--END---;
;-----功能--START---;
Save:
{
    save()
    Return
}
Reply:
{
    Reply()
    Return
}

Invite:
{
    Invite()
    Return
}
Hideout:
{
    Hideout()
    Return
}
Afk:
{
    Afk()
    Return
}
Trade:
{
    Trade()
    Return
}

Thanks:
{
    Thanks()
    Return
}

FastLogOut:
{
    FastLogOut()
    Return
}

OosCommand:
{
    OosCommand()
    Return
}

EditLogPath:
{
    LogPathFinder()
    Return
}

;-----功能--END---;
