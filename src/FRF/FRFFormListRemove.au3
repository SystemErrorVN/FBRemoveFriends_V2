#include-once

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>

#include <..\lib\AutoItObject.au3>
#include <..\util\ConstructArgs.au3>

#include <..\model\Friend.au3>



Func _New_FRFFormListRemove($__aArgs = Null)
	;
	$__object = IDispatch() ;
	$__object.__name = "FRFFormListRemove" ;
	$__object.__des = "" ;
	$__object.__status = 1 ;
	;
	$__oArgs = _New_ConstructArgs($__aArgs) ;
	$__object._aFriends = $__oArgs.arg() ;
	;
	$__object._hGUI = Null ;
	$__object._hLvFriend = Null ;
	$__object._hBtnRemove = Null ;
	$__object._hBtnClose = Null ;
	;
	$__object.__defineGetter("_toString", __FRFFormListRemove_toString) ;
	$__object.__defineGetter("_getError", __FRFFormListRemove_getError) ;
	$__object.__defineGetter("_init", __FRFFormListRemove_Init) ;
	$__object.__defineGetter("_update", __FRFFormListRemove_Update) ;
	$__object.__defineGetter("_show", __FRFFormListRemove_Show) ;
	$__object.__defineGetter("_hide", __FRFFormListRemove_Hide) ;
	$__object.__defineGetter("_waitResult", __FRFFormListRemove_WaitResult) ;
	;
	$__object.__lock() ;
	;
	Return $__object ;
EndFunc   ;==>_New_FRFFormListRemove



Func __FRFFormListRemove_Init($__oSelf)
	$__sLvColumn = "ID|Name|UID|Gender|React|Cmt" ;
	$__oSelf.parent._hGUI = GUICreate("Friends list will cancel making friends.", 475, 332) ;
	$__oSelf.parent._hLvFriend = GUICtrlCreateListView($__sLvColumn, 8, 8, 458, 286, -1, $LVS_EX_CHECKBOXES + $LVS_EX_FULLROWSELECT) ;
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 60) ;
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 130) ;
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 110) ;
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 55) ;
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 50) ;
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 5, 50) ;
	$__oSelf.parent._hBtnRemove = GUICtrlCreateButton("Remove", 256, 296, 99, 25)
	$__oSelf.parent._hBtnClose = GUICtrlCreateButton("Close", 368, 296, 99, 25)
EndFunc   ;==>__FRFFormListRemove_Init


Func __FRFFormListRemove_show($__oSelf)
	GUISetState(@SW_SHOW, $__oSelf.parent._hGUI) ;
EndFunc   ;==>__FRFFormListRemove_show


Func __FRFFormListRemove_Hide($__oSelf)
	GUISetState(@SW_HIDE, $__oSelf.parent._hGUI) ;
EndFunc   ;==>__FRFFormListRemove_Hide


Func __FRFFormListRemove_Update($__oSelf)
	$__oParent = $__oSelf.parent ;
	;
	If $__oParent._aFriends == Null Or UBound($__oParent._aFriends) == 0 Then
		$__oSelf._parent.__status = 0 ;
		Return False ;
	EndIf ;
	;
	_GUICtrlListView_DeleteAllItems($__oSelf.parent._hLvFriend) ;
	;
	$__aFriends = $__oParent._aFriends ;
	$__sSepa = "|" ;
	;
	For $__i = 0 To UBound($__aFriends) - 1

		$__sName = $__aFriends[$__i]._sName ;
		$__sId = $__aFriends[$__i]._sId ;
		$__sGender = $__aFriends[$__i]._sGender ;
		$__nCountReact = $__aFriends[$__i]._nCountReact ;
		$__nCountComment = $__aFriends[$__i]._nCountComment ;
		$__bRemove = $__aFriends[$__i]._bRemove ;

		$__sItem = "#" & $__i+1 & $__sSepa & $__sName & $__sSepa & $__sId & $__sSepa & $__sGender & $__sSepa & $__nCountReact & $__sSepa & $__nCountComment ;

		GUICtrlCreateListViewItem($__sItem, $__oSelf.parent._hLvFriend) ;
		_GUICtrlListView_SetItemChecked($__oSelf.parent._hLvFriend, $__i, $__bRemove) ;
	Next
	Return True ;
EndFunc   ;==>__FRFFormListRemove_Update


Func __FRFFormListRemove_WaitResult($__oSelf)
	$__oParent = $__oSelf.parent ;
	While 1
		$__nMsg = GUIGetMsg() ;
		Switch $__nMsg
			Case $__oParent._hBtnClose
				$__oSelf.parent.__status = -1;
				Return True ;
			Case $__oParent._hBtnRemove
				$__oSelf.parent.__status = -2;
				$__oSelf.parent._aFriends = __FRFFormListRemove_parseFriends($__oParent._hLvFriend) ;
				Return True ;
		EndSwitch
	WEnd
EndFunc   ;==>__FRFFormListRemove_WaitResult



Func __FRFFormListRemove_getError($_oSelf)
	$__oParent = $_oSelf.parent ;
	Switch $__oParent.__status
		Case 1
			Return "Success" ;
		Case 0
			Return "_aFriends is Null!";
		Case -1
			Return "Close button";
		Case -2
			Return "Remove button";
	EndSwitch
EndFunc   ;==>__FRFFormListRemove_getError


Func __FRFFormListRemove_toString($_oSelf)
	$__oParent = $_oSelf.parent ;
	Dim $__a = [] ; list object here...
	Return _AutoItObject_ArrayToString($__oParent.__name, $__a) ;
EndFunc   ;==>__FRFFormListRemove_toString







Func __FRFFormListRemove_parseFriends($__hLvFriend)
	$__nLvCount = _GUICtrlListView_GetItemCount($__hLvFriend) ;
	$__nCountRemove = 0 ;
	;check count remove
	For $__i = 0 To $__nLvCount - 1
		$__bChecked = _GUICtrlListView_GetItemChecked($__hLvFriend, $__i) ;
		$__nCountRemove += ($__bChecked == True ? 1 : 0) ;
	Next
	;
	Local $__aFriends[$__nCountRemove] ;
	$__j = 0 ;
	For $__i = 0 To $__nLvCount - 1
		$__aDataItem = _GUICtrlListView_GetItemTextArray($__hLvFriend, $__i) ;
		$__bChecked = _GUICtrlListView_GetItemChecked($__hLvFriend, $__i) ;
		If $__bChecked Then
			Local $__aArgsFriend = [ _
					$__aDataItem[3], _
					$__aDataItem[2], _
					$__aDataItem[4], _
					$__aDataItem[5], _
					$__aDataItem[6], _
					$__bChecked _
					] ;
			$__aFriends[$__j] = _New_Friend($__aArgsFriend) ;
			$__j+=1;
		EndIf
	Next
	Return $__aFriends ;
EndFunc   ;==>__FRFFormListRemove_parseFriends