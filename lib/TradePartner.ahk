#SingleInstance Force
#NoEnv
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
Gui Show, AutoSize,% TPTitle

SetTimer,check,10
Gosub KeepColW
;Gosub init
Return

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

init:
{
    if BuyerInfo.ID[1]
    {
        waiting := BuyerInfo.ID.Length()
        Loop, waiting
            LV_Add(,A_Index . " ",BuyerInfo.ID[A_Index],BuyerInfo.Item[A_Index],BuyerInfo.Slashtab[A_Index] . "`n" . BuyerInfo.Pos[A_Index],BuyerInfo.Price[A_Index],"邀請","X")
    }
    Return
}

PartnerClose:
GuiControl Main:Enable ,交易夥伴`n(已開啟)
GuiControl Main:Text ,交易夥伴`n(已開啟),交易夥伴
Gui Partner:Destroy

Return