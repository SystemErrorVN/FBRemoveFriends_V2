#include <GUIConstantsEx.au3>
#include <GUIListView.au3>


#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
    Local $aItem, $sText, $idListview

    GUICreate("ListView Get Item Text Array", 400, 300)

    $idListview = GUICtrlCreateListView("col1|col2|col3", 2, 2, 394, 268)
    GUICtrlCreateListViewItem("line1|data1|more1", $idListview)
    GUICtrlCreateListViewItem("line2|data2|more2", $idListview)
    GUICtrlCreateListViewItem("line3|data3|more3", $idListview)
    GUICtrlCreateListViewItem("line4|data4|more4", $idListview)
    GUICtrlCreateListViewItem("line5|data5|more5", $idListview)

    GUISetState(@SW_SHOW)

    ; Get item 2 text
    $aItem = _GUICtrlListView_GetItemTextArray($idListview, 1)
	_GUICtrlListView_GetItemCount
    For $i = 1 To $aItem[0]
        $sText &= StringFormat("Column[%2d] %s", $i, $aItem[$i]) & @CRLF
    Next

    MsgBox($MB_SYSTEMMODAL, "Information", "Item 2 (All Columns) Text: " & @CRLF & @CRLF & $sText)

    ; Loop until the user exits.
    Do
    Until GUIGetMsg() = $GUI_EVENT_CLOSE
    GUIDelete()
EndFunc   ;==>Example


Func Exam1()
	$hGUI = GUICreate("Test", 500, 500)

	$cListView = GUICtrlCreateListView("Column1|Column2|Column3", 10, 10, 480, 250, -1, $LVS_EX_CHECKBOXES)

;~ $cStart = GUICtrlCreateDummy()
	For $i = 0 To 9
		GUICtrlCreateListViewItem("Item view|" & "Item " & $i & "|xxxx" & "", $cListView)
		$__nRand = Random(0, 1, 1) == 1 ? True : False ;
		_GUICtrlListView_SetItemChecked($cListView, $i, $__nRand) ;
;~ 	_GUICtrlListView_SetColumnWidth($cListView, 0, 20)
	Next
;~ $cEnd = GUICtrlCreateDummy()

	GUISetState()

	While 1
		Sleep(1000) ;
;~     $iMsg = GUIGetMsg()
;~     Switch $iMsg
;~         Case $GUI_EVENT_CLOSE
;~             Exit
;~         Case $cStart + 1 To $cEnd - 1
;~             ; Which item was clicked - possibly on checkbox?
;~             $iIndex = $iMsg - ($cStart + 1)
;~             ; Is this item clicked?
;~             If _GUICtrlListView_GetItemChecked($cListView, $iIndex) Then
;~                 ; Delete all checks
;~                 For $i = 0 To _GUICtrlListView_GetItemCount($cListView) - 1
;~                     ; Except the one just made
;~                     If $i <> $iIndex Then
;~                         _GUICtrlListView_SetItemChecked($cListView, $i, False)
;~                     EndIf
;~                 Next
;~             EndIf
;~     EndSwitch

	WEnd
EndFunc   ;==>Exam1
