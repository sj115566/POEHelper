#SingleInstance Force
#NoEnv
FileGetSize presize, %LogPath%
TPTitle:="交易小幫手 - c09y-001"
VarEvent:=""
waiting :=0
IsFold := False
VFB := "摺疊"
ColWidth := [20,150,205,95,75,42,42]
;BuyerInfo := ["一二三四七八九十一二三四五六","覺醒˙進佔物理傷害輔助 (L21Q20)","[具4] 左11 上22","300 崇高實"]

Gui Partner:+LabelPartner +AlwaysOnTop +OwnDialogs
Gui Partner:Default

/*  include this section for separate debug
#Include %A_ScriptDir%\\lib\LV_EX.ahk
*/
Gui , Add, Button, x470 y10 w40 h25 gDebugAddData, add
Gui , Add, Button, x520 y10 w40 h25 gDebugDel, DDDD



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
SetTimer, check,10
Gosub KeepColW
Return

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
    Loop, % ColWidth.MaxIndex()
    {
        LV_ModifyCol(A_Index,ColWidth[A_Index])   
        LV_ModifyCol(A_Index,"Center")   
    }
    LV_EX_RedrawRows(HLV)
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
            /*
                if ColumnClicked = 2
                {
                    Clipboard := BuyerInfo.ID
                    copysuc := BuyerInfo.ID
                    ToolTip, 已複製密語格式: @%copysuc% ,
                }
                */
                if ColumnClicked = 6
                {
                    MsgBox,,,invite # %RowChosen%
                    VarEvent:=""
                    ControlGet, ischecked, Checked,,,ahk_id %check%
                    if ischecked
                    {
                        delRow:=RowChosen
                        Gosub DelData
                    }
                }
                if ColumnClicked = 7
                {
                    MsgBox,,,delete # %RowChosen%
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

check:
{
    Gui Partner:Default
    if CheckLogChange(LogPath,presize){
        Gosub TPAddData
    }
    Return
}

TPAddData:
{
    SetTimer,check,off
    waiting+=1
    GuiControl , Text, lwaiting, %waiting% 筆交易待處理
    LV_Add(,waiting . " ",BuyerInfo.ID,BuyerInfo.Item,BuyerInfo.Slashtab . " " . BuyerInfo.Pos,BuyerInfo.Price,"邀請","X")
    SetTimer,check,10
    Return
}
DebugAddData:
{    
    waiting+=1
    GuiControl , Text, lwaiting, %waiting% 筆交易待處理
    LV_Add(,waiting . " ",BuyerInfo.ID,BuyerInfo.Item,BuyerInfo.Slashtab . " " . BuyerInfo.Pos,BuyerInfo.Price,"邀請","X")
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
    SetTimer,check,off
    LV_GetText(deletable,1)
    if deletable {
        waiting-=1
        GuiControl Text, lwaiting, %waiting% 筆交易待處理
        LV_Delete(delRow)
        Loop %waiting%
            LV_Modify(A_Index,,A_Index)
    }
    SetTimer,check,10
    Return
}

PartnerClose:
GuiControl Main:Enable ,交易夥伴`n(已開啟)
GuiControl Main:Text ,交易夥伴`n(已開啟),交易夥伴
Gui Partner:Destroy

Return