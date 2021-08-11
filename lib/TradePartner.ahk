#SingleInstance Force
#NoEnv
TPTitle:="交易小幫手 - c09y-001"
VarEvent:=""
waiting :=0
IsFold := False
VFB := "摺疊"
ColWidth := [20,150,205,95,75,42,42]
BuyerInfo := ["一二三四七八九十一二三四五六","覺醒˙進佔物理傷害輔助 (L21Q20)","[具4] 左11 上22","300 崇高實"]

Gui Partner:+OwnerMain +LabelPartner -AlwaysOnTop +Border +hwndHPartner +OwnDialogs
/*  include this section for separate debug
#Include %A_ScriptDir%\\lib\LV_EX.ahk
Gui , Add, Button, x470 y10 w40 h25 gDebugAddData, add
Gui , Add, Button, x520 y10 w40 h25 gDebugDel, DDDD
*/
Gui Partner:Add, GroupBox, x0 y0 w658 h40
Gui Partner:Font, s14 w700 , Norm
Gui Partner:Add, Text, x10 y15 w225 h20 vlwaiting, %waiting% 筆交易待處理
Gui Partner:Font, s9 w400
Gui Partner:Add, CheckBox, x250 yp w100 h20 hwndcheck, 邀請後自動刪除
Gui Partner:Add, Button, x380 y10 w60 h25 ghide&show vVFB, %VFB%

Gui Partner:Add, GroupBox, x0 y40 w658 h200 hwndPLV
Gui Partner:Add, ListView, xp+5 yp+5 w650 R10 Count10 +VScroll +Grid -LV0x10 -Multi +NoSortHdr +AltSubmit hwndHLV ggevent, #|購買者|物品|倉庫頁及位置|價格|組隊|刪除|
LV_SetImageList( DllCall( "ImageList_Create",Int,1, Int,30, Int,0x18, Int,1, Int,1 ), 1 )
Gui Partner:Show, AutoSize,% TPTitle
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
    Return
}

gevent:
{
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
                if ColumnClicked = 6
                {
                    MsgBox,,,invite # %RowChosen%
                    VarEvent:=""
                    ControlGet, ischecked, Checked,,,ahk_id %check%
                    if ischecked
                    {
                        r:=RowChosen
                        Gosub DelData
                    }
                }
                if ColumnClicked = 7
                {
                    MsgBox,,,delete # %RowChosen%
                    VarEvent:=""
                    r:=RowChosen
                    Gosub DelData
                }
            }
        }
    }
    Gosub KeepColW
    Return
}

DebugAddData:
{    
    waiting+=1
    GuiControl , Text, lwaiting, %waiting% 筆交易待處理
    LV_Add(,waiting . " ",BuyerInfo[1],BuyerInfo[2],BuyerInfo[3],BuyerInfo[4],"邀請","X")
    Return
}

DebugDel:
{
    LV_GetText(dable,1)
    if dable
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
    LV_GetText(dable,1,2)
    if dable
    {
        waiting-=1
        LV_Delete(r)
        GuiControl Text, lwaiting, %waiting% 筆交易待處理
        Loop %waiting%
            LV_Modify(A_Index,,A_Index)
    }
    Return
}

PartnerClose:
GuiControl Main:Enable ,交易夥伴`n(已開啟)
GuiControl Main:Text ,交易夥伴`n(已開啟),交易夥伴
Gui Partner:Destroy
Return

    /*密語格式
    /*編年史
    @從零開始的探險 清渭東流劍閣深，去住彼此無消息。您好，我想買在 探險聯盟 的  毒蛇打擊 (等級1) 價格 105 混沌石 [倉庫:~價格 105 chaos 位置: 左1, 上 1]
    /*透視鏡
    @高衩美腿春丸丸 你好，我想買 (毒蛇打擊 (Lv19q0))  位於 (G) 頁 (右2下12) 聯盟 (探險標準)
    /*官方交易市集
    @貪吃的小胖 你好，我想購買 等級 1 6% 毒蛇打擊 標價 1 chaos 在 探險聯盟 (倉庫頁 "寶石"; 位置: 左 2, 上 1)
    */