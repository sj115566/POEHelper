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
    Gui Add, Slider, Center NoTicks AltSubmit vSldr gopacity x300 y352 w120 h32, %opacity%
    Gui Add, Hotkey, x174 y31  w70 h21 vDisplayKey_ReplyWait ,% Key_ReplyWait
    Gui Add, Hotkey, x174 y77  w70 h21 vDisplayKey_Invite ,% Key_Invite
    Gui Add, Hotkey, x174 y123 w70 h21 vDisplayKey_Hideout ,% Key_Hideout
    Gui Add, Hotkey, x174 y169 w70 h21 vDisplayKey_AFK ,% Key_AFK
    Gui Add, Hotkey, x174 y215 w70 h21 vDisplayKey_Tradewith ,% Key_Tradewith
    Gui Add, Hotkey, x174 y261 w70 h21 vDisplayKey_ReplyThank ,% Key_ReplyThank
    Gui Add, Hotkey, x174 y307 w70 h21 vDisplayKey_Logout ,% Key_Logout
    Gui Add, Hotkey, x174 y353 w70 h21 vDisplayKey_OOS ,% Key_OOS
    GuiControl Disable, DisplayKey_ReplyWait
    GuiControl Disable, DisplayKey_Invite
    GuiControl Disable, DisplayKey_Hideout
    GuiControl Disable, DisplayKey_AFK
    GuiControl Disable, DisplayKey_Tradewith
    GuiControl Disable, DisplayKey_ReplyThank
    GuiControl Disable, DisplayKey_Logout
    GuiControl Disable, DisplayKey_OOS
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
    NewKeyList := KeyList
    Gui +Disabled
    Gui,EditGui:+OwnerMain -SysMenu +AlwaysOnTop +OwnDialogs
    Gui EditGui:Font, s9 w500, Segoe UI
    Gui EditGui:Add, Text,x21 y34  w130 h36, 自動回覆：稍等
    Gui EditGui:Add, Text,x21 y80  w130 h36, 邀請組隊
    Gui EditGui:Add, Text,x21 y127 w130 h36, 回藏身處
    Gui EditGui:Add, Text,x21 y173 w130 h36, AFK
    Gui EditGui:Add, Text,x21 y219 w130 h36, 交易
    Gui EditGui:Add, Text,x21 y265 w130 h36, 自動回覆：感謝
    Gui EditGui:Add, Text,x21 y311 w130 h36, 快速登出
    Gui EditGui:Add, Text,x21 y356 w130 h36, OOS 
    Gui EditGui:Add, Button,x131 y30 w40 h23 gDefaultReplyWait , 預設
    Gui EditGui:Add, Button,x131 y76 w40 h23 gDefaultInvite , 預設
    Gui EditGui:Add, Button,x131 y122 w40 h23 gDefaultHideout , 預設
    Gui EditGui:Add, Button,x131 y168 w40 h23 gDefaultAFK , 預設
    Gui EditGui:Add, Button,x131 y214 w40 h23 gDefaultTradewith , 預設
    Gui EditGui:Add, Button,x131 y260 w40 h23 gDefaultReplyThank , 預設
    Gui EditGui:Add, Button,x131 y306 w40 h23 gDefaultLogout , 預設
    Gui EditGui:Add, Button,x131 y352 w40 h23 gDefaultOOS , 預設
    Gui EditGui:Add, Button,x310 y329 w100 h45 gSave , 儲存
    Gui EditGui:Add, Hotkey, x174 y31  w70 h21 vNewKey_ReplyWait gCheckHotkeyReplyWait,% Key_ReplyWait
    Gui EditGui:Add, Hotkey, x174 y77  w70 h21 vNewKey_Invite gCheckHotkeyInvite,% Key_Invite
    Gui EditGui:Add, Hotkey, x174 y123 w70 h21 vNewKey_Hideout gCheckHotkeyHideout,% Key_Hideout
    Gui EditGui:Add, Hotkey, x174 y169 w70 h21 vNewKey_AFK gCheckHotkeyAFK,% Key_AFK
    Gui EditGui:Add, Hotkey, x174 y215 w70 h21 vNewKey_Tradewith gCheckHotkeyTradewith,% Key_Tradewith
    Gui EditGui:Add, Hotkey, x174 y261 w70 h21 vNewKey_ReplyThank gCheckHotkeyReplyThank,% Key_ReplyThank
    Gui EditGui:Add, Hotkey, x174 y307 w70 h21 vNewKey_Logout gCheckHotkeyLogout,% Key_Logout
    Gui EditGui:Add, Hotkey, x174 y353 w70 h21 vNewKey_OOS gCheckHotkeyOOS,% Key_OOS
    Gui EditGui:Add, Edit,Limit x260 y31 w150 h21 vStr_Wait,% Str_Wait
    Gui EditGui:Add, Edit,Limit x260 y261 w150 h21 vStr_Thank,% Str_Thank
    Gui,EditGui:show,w439 h409,Edithotkey
    Return 
}
;-----編輯視窗--END---;
;-----透明度調整--START---;
opacity:
{
    opacity := round(((sldr*255)/100))+30
    Winset Transparent, %opacity%
    Return
}
;-----透明度調整--END---;
;-----熱鍵檢查功能--START---;
Save:
{
    save()
    Return
}
CheckHotkeyReplyWait:
{
    NewKeyList[1] := NewKey_ReplyWait
    For k,v in NewKeyList
        if (A_Index = 1){
            Continue
        }Else if(v = NewKey_ReplyWait){ 
            CoordMode ToolTip,Window
            ToolTip % NewKey_ReplyWait " 與 " FeatureList[k]" 衝突!請重新設定",174 ,31
            GuiControl,,NewKey_ReplyWait
            NewKeyList[1] := ""
            SetTimer, RemoveToolTip, -1000
        }Else {
            Key_ReplyWait := NewKey_ReplyWait
        }
    Return
}
CheckHotkeyInvite:
{
    NewKeyList[2] := NewKey_Invite
    For k,v in NewKeyList
        if (A_Index = 2){
            Continue
        }Else if(v = NewKey_Invite){ 
            CoordMode ToolTip,Window
            ToolTip,%NewKey_Invite% 衝突!請重新設定,174 ,77
            GuiControl,,NewKey_Invite
            NewKeyList[2] := ""
            SetTimer, RemoveToolTip, -1000
        }Else {
            Key_Invite := NewKey_Invite
        }
    Return
}
CheckHotkeyHideout:
{
    NewKeyList[3] := NewKey_Hideout
    For k,v in NewKeyList
        if (A_Index = 3){
            Continue
        }Else if(v = NewKey_Hideout){ 
            CoordMode ToolTip,Window
            ToolTip,%NewKey_Hideout% 衝突!請重新設定,174 ,123
            GuiControl,,NewKey_Hideout
            NewKeyList[3] := ""
            SetTimer, RemoveToolTip, -1000
        }Else {
            Key_Hideout := NewKey_Hideout
        }
    Return
}
CheckHotkeyAFK:
{
    NewKeyList[4] := NewKey_AFK
    For k,v in NewKeyList
        if (A_Index = 4){
            Continue
        }Else if(v = NewKey_AFK){ 
            CoordMode ToolTip,Window
            ToolTip,%NewKey_AFK% 衝突!請重新設定,174 ,169
            GuiControl,,NewKey_AFK
            NewKeyList[4] := ""
            SetTimer, RemoveToolTip, -1000
        }Else {
            Key_AFK := NewKey_AFK
        }
    Return
}
CheckHotkeyTradewith:
{
    NewKeyList[5] := NewKey_Tradewith
    For k,v in NewKeyList
        if (A_Index = 5){
            Continue
        }Else if(v = NewKey_Tradewith){ 
            CoordMode ToolTip,Window
            ToolTip,%NewKey_Tradewith% 衝突!請重新設定,174 ,215
            GuiControl,,NewKey_Tradewith
            NewKeyList[5] := ""
            SetTimer, RemoveToolTip, -1000
        }Else {
            Key_Tradewith := NewKey_Tradewith
        }
    Return
}
CheckHotkeyReplyThank:
{
    NewKeyList[6] := NewKey_ReplyThank
    For k,v in NewKeyList
        if (A_Index = 6){
            Continue
        }Else if(v = NewKey_ReplyThank){ 
            CoordMode ToolTip,Window
            ToolTip,%NewKey_ReplyThank% 衝突!請重新設定,174 ,261
            GuiControl,,NewKey_ReplyThank
            NewKeyList[6] := ""
            SetTimer, RemoveToolTip, -1000
        }Else {
            Key_ReplyThank := NewKey_ReplyThank
        }
    Return
}
CheckHotkeyLogout:
{
    NewKeyList[7] := NewKey_Logout
    For k,v in NewKeyList
        if (A_Index = 7){
            Continue
        }Else if(v = NewKey_Logout){ 
            CoordMode ToolTip,Window
            ToolTip,%NewKey_Logout% 衝突!請重新設定,174 ,307
            GuiControl,,NewKey_Logout
            NewKeyList[7] := ""
            SetTimer, RemoveToolTip, -1000
        }Else {
            Key_Logout := NewKey_Logout
        }
    Return
}
CheckHotkeyOOS:
{
    NewKeyList[8] := NewKey_OOS
    For k,v in NewKeyList
        if (A_Index = 8){
            Continue
        }Else if(v = NewKey_OOS){ 
            CoordMode ToolTip,Window
            ToolTip,%NewKey_OOS% 衝突!請重新設定,174 ,353
            GuiControl,,NewKey_OOS
            NewKeyList[8] := ""
            SetTimer, RemoveToolTip, -1000
        }Else {
            Key_OOS := NewKey_OOS
        }
    Return
}
;-----熱鍵檢查功能--END---;
;-----回復預設熱鍵--START---;
DefaultReplyWait:
{
    GuiControl,,NewKey_ReplyWait,F2
    Key_ReplyWait := "F2"
    GuiControlGet, outputvar,,NewKey_ReplyWait
    NewKeyList[1]:=outputvar
    Return
}
DefaultInvite:
{
    GuiControl,,NewKey_Invite,F3
    Key_Invite := "F3"
    GuiControlGet, outputvar,,NewKey_Invite
    NewKeyList[2]:=outputvar
    Return
}
DefaultHideout:
{
    GuiControl,,NewKey_Hideout,F6
    Key_Hideout := "F6"
    GuiControlGet, outputvar,,NewKey_Hideout
    NewKeyList[3]:=outputvar
    Return
}
DefaultAFK:
{
    GuiControl,,NewKey_AFK,F11
    Key_AFK := "F11"
    GuiControlGet, outputvar,,NewKey_AFK
    NewKeyList[4]:=outputvar
    Return
}
DefaultTradewith:
{
    GuiControl,,NewKey_Tradewith,F5
    Key_Tradewith := "F5"
    GuiControlGet, outputvar,,NewKey_Tradewith
    NewKeyList[5]:=outputvar
    Return
}
DefaultReplyThank:
{
    GuiControl,,NewKey_ReplyThank,F4
    Key_ReplyThank := "F4"
    GuiControlGet, outputvar,,NewKey_ReplyThank
    NewKeyList[6]:=outputvar
    Return
}
DefaultLogout:
{
    GuiControl,,NewKey_Logout,F7
    Key_Logout := "F7"
    GuiControlGet, outputvar,,NewKey_Logout
    NewKeyList[7]:=outputvar
    Return
}
DefaultOOS:
{
    GuiControl,,NewKey_OOS,F12
    Key_OOS := "F12"
    GuiControlGet, outputvar,,NewKey_OOS
    NewKeyList[8]:=outputvar
    Return
}
;-----回復預設熱鍵--END---;
;-----功能--START---;
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
;-----交易夥伴--START---;
TradePartner:
{
    GuiControl Text, 交易夥伴, 交易夥伴`n(已開啟)
    GuiControl Disable , 交易夥伴`n(已開啟)
    
    FileGetSize presize, %LogPath%
    TPTitle:="交易小幫手 - c09y-001"
    VarEvent:=""
    waiting :=0
    IsFold := False
    VFB := "摺疊"
    ColWidth := [20,145,205,100,75,42,42]
    ;BuyerInfo := ["一二三四七八九十一二三四五六","覺醒˙進佔物理傷害輔助 (L21Q20)","[具4] 左11 上22","300 崇高實"]

    Gui Partner:+LabelPartner +AlwaysOnTop +OwnDialogs
    Gui Partner:Default

    /*  include this section for separate debug
    #Include %A_ScriptDir%\\lib\LV_EX.ahk

    Gui , Add, Button, x470 y10 w40 h25 gDebugAddData, add
    Gui , Add, Button, x520 y10 w40 h25 gDebugDel, DDDD
    Gui , Add, Button, x600 y10 w40 h25 gtest, test
    */
    Gui Add, GroupBox, x0 y0 w658 h40
    Gui Font, s14 w700 , Norm
    Gui Add, Text, x10 y15 w225 h20 vlwaiting, %waiting% 筆交易待處理
    Gui Font, s9 w400
    Gui Add, CheckBox, x250 yp w100 h20 hwndcheck, 邀請後自動刪除
    Gui Add, Button, x380 y10 w60 h25 ghide&show vVFB, %VFB%
    Gui Add, GroupBox, x0 y40 w658 h200 hwndPLV
    Gui Add, ListView, xp+5 yp+5 w650 R10 Count10 +VScroll +Grid -LV0x10 -Multi +NoSortHdr +AltSubmit hwndHLV ggevent, #|購買者|物品|倉庫頁及位置|價格|組隊|刪除|
    LV_SetImageList( DllCall( "ImageList_Create",Int,1, Int,30, Int,0x18, Int,1, Int,1 ), 1 )

    SetTimer,check,10
    Gosub KeepColW
    Gosub TPinit
    Gui Partner:Show, AutoSize,% TPTitle
    Gui Main:Default
    Return
    
}

test:
{
    For k, v in BuyerInfo
        MsgBox % k "=" v.Length()
    Return
}

hide&show:
{
    if IsFold
    {
        Control Show,,, ahk_id %HLV%
        Control Show,,, ahk_id %PLV%
        VFB := "摺疊"
        IsFold := False
    }Else{
        Control Hide,,, ahk_id %HLV%
        Control Hide,,, ahk_id %PLV%
        VFB := "展開"
        IsFold := True
    }
    GuiControl ,,VFB, % VFB
    Gosub KeepColW
    Gui , Show, AutoSize
    Return
}

KeepColW:
{
    GuiControl, -Redraw, HLV
    Loop, % ColWidth.MaxIndex()
    {
        LV_ModifyCol(A_Index,ColWidth[A_Index])   
        LV_ModifyCol(A_Index,"Center")   
    }
    GuiControl, +Redraw, HLV
    Return
}

gevent:
{
    Gui Partner:Default
    Critical
    VarEvent = %VarEvent%%A_GuiEvent%
    ColumnClicked := LV_EX_SubItemHitTest(HLV, -1,-1)
    if InStr(VarEvent, "Normal", true)
    {
        RowChosen := A_EventInfo
        if InStr(VarEvent, "C", true)
        {
            if LV_EX_IsRowSelected(HLV,RowChosen)
            {
                if ColumnClicked = 2
                {
                    VarEvent:=""
                    copysuc := TPPM(BuyerInfo.ID[RowChosen])
                    ToolTip,已複製密語格式: @%copysuc%
                    SetTimer, RemoveToolTip, -2000
                }
                if ColumnClicked = 6
                {
;                    MsgBox,,,invite # %RowChosen%,1
                    VarEvent:=""
                    TPInvite(BuyerInfo.ID[RowChosen])
                    ControlGet, ischecked, Checked,,,ahk_id %check%
                    if ischecked
                    {
                        delRow:=RowChosen
                        Gosub DelData
                    }

                }
                if ColumnClicked = 7
                {
;                    MsgBox,,,delete # %RowChosen%,1
                    VarEvent:=""
                    delRow:=RowChosen
                    Gosub DelData
                }
            }
        }
    }
    Gosub KeepColW
    Return
}
RemoveTooltip:
{
    ToolTip
    Return
}

check:
{
    Gui Partner:Default
    if CheckLogChange(LogPath,presize){
        Gosub TPAddData
        Gui Flash
    }
    Return
}

TPAddData:
{
    SetTimer,check,off
    waiting+=1
    GuiControl , Text, lwaiting, %waiting% 筆交易待處理
    LV_Add(,waiting . " ",BuyerInfo.ID[BuyerInfo.ID.MaxIndex()],BuyerInfo.Item[BuyerInfo.Item.MaxIndex()],BuyerInfo.Slashtab[BuyerInfo.Slashtab.MaxIndex()] . "`n" . BuyerInfo.Pos[BuyerInfo.Pos.MaxIndex()],BuyerInfo.Price[BuyerInfo.Price.MaxIndex()],"邀請","X")
    SetTimer,check,on
    Return
}
DebugAddData:
{    
    waiting+=1
    GuiControl , Text, lwaiting, %waiting% 筆交易待處理
    LV_Add(,waiting . " ",BuyerInfo.ID.1,BuyerInfo.Item.1,BuyerInfo.Slashtab.1 . "`n" . BuyerInfo.Pos.1,BuyerInfo.Price.1,"邀請","X")
    Return
}

DebugDel:
{
    LV_GetText(deletable,1)
    if deletable
    {
        LV_Delete(1)
        waiting-=1
        GuiControl , Text, lwaiting, %waiting% 筆交易待處理
        Loop %waiting%
            LV_Modify(A_Index,,A_Index)
    }
    Return
}

DelData:
{
    GuiControl, -Redraw, HLV
    SetTimer,check,off
    LV_GetText(deletable,1)
    if deletable {
        waiting-=1
        GuiControl Text, lwaiting, %waiting% 筆交易待處理
        LV_Delete(delRow)
        For k,v in BuyerInfo
            v.RemoveAt(delRow)
        Loop %waiting%
            LV_Modify(A_Index,,A_Index,BuyerInfo.ID[A_Index],BuyerInfo.Item[A_Index],BuyerInfo.Slashtab[A_Index] . "`n" . BuyerInfo.Pos[A_Index],BuyerInfo.Price[A_Index],"邀請","X")
    }
    SetTimer,check,on
    GuiControl, +Redraw, HLV
    Return
}

TPinit:
{
    if BuyerInfo.ID[1]
    {
        waiting := BuyerInfo.ID.Length()
        GuiControl Text, lwaiting, %waiting% 筆交易待處理
        Loop, %waiting%
            LV_Add(,A_Index,BuyerInfo.ID[A_Index],BuyerInfo.Item[A_Index],BuyerInfo.Slashtab[A_Index] . "`n" . BuyerInfo.Pos[A_Index],BuyerInfo.Price[A_Index],"邀請","X")
    }
    Return
}

PartnerClose:
GuiControl Main:Enable ,交易夥伴`n(已開啟)
GuiControl Main:Text ,交易夥伴`n(已開啟),交易夥伴
Gui Partner:Destroy
;-----交易夥伴--END---;