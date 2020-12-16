#cs ----------------------------------------------------------------------------
 Author:         ThienDepTrai
#ce ----------------------------------------------------------------------------

#include-once
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#include <..\lib\AutoItObject.au3>
#include <..\util\ConstructArgs.au3>


Func _New_FRFFormMain($__aArgs = Null)
	;
	$__object = IDispatch() ;
	$__object.__name = "FRFFormMain" ;
	$__object.__des = "" ;
	$__object.__status = 1 ;
	;
	$__oArgs = _New_ConstructArgs($__aArgs) ;
	$__object._sName = $__oArgs.arg() ;
	$__object._sSlogan = $__oArgs.arg() ;
	$__object._sVersion = $__oArgs.arg() ;
	$__object._sAuthorName = $__oArgs.arg() ;
	$__object._sAppCreated = $__oArgs.arg() ;

	$__object._hGUI = Null ;
	$__object._hInpCookie = Null ;
	$__object._hBtnLogin = Null ;
	$__object._hInpScoreReact = Null ;
	$__object._hInpScoreCmt = Null ;
	$__object._hInpScoreOut = Null ;
	$__object._hCbbGenderRemove = Null ;
	$__object._hBtnRemove = Null ;
	$__object._hBtnContact = Null ;
	;
	$__object.__defineGetter("_toString", _FRFFormMain_toString) ;
	$__object.__defineGetter("_getError", _FRFFormMain_getError) ;
	$__object.__defineGetter("_init", _FRFFormMain_Init) ;
	$__object.__defineGetter("_show", _FRFFormMain_Show) ;
	$__object.__defineGetter("_hide", _FRFFormMain_Hide) ;
	$__object.__defineGetter("_setEnables", _FRFFormMain_SetEnables) ;
	;
	$__object.__lock() ;
	;
	Return $__object ;
EndFunc   ;==>_New_FRFFormMain




Func _FRFFormMain_Init($_oSelf)
	$__oParent = $_oSelf.parent ;
	$_oSelf.parent._hGUI = GUICreate($__oParent._sName & " - v" & $__oParent._sVersion, 419, 289) ;
	GUISetBkColor(0xffffff) ;
	GUICtrlCreateLabel($__oParent._sName & " - v" & $__oParent._sVersion, 8, 8, 405, 35, $SS_CENTER) ;
	GUICtrlSetFont(-1, 20, 800, 0, "Trebuchet MS") ;
	GUICtrlCreateLabel($__oParent._sSlogan, 8, 48, 402, 22, $SS_CENTER) ;
	GUICtrlSetFont(-1, 16, 400, 0, "Terminal") ;
	$_oSelf.parent._hBtnLogin = GUICtrlCreateButton("Login", 320, 96, 83, 25) ;
	GUICtrlCreateGroup("Login With Cookie:", 8, 80, 401, 49) ;
	$_oSelf.parent._hInpCookie = GUICtrlCreateInput("", 16, 96, 289, 21) ;
	GUICtrlCreateGroup("Config", 8, 136, 401, 105) ;
	GUICtrlCreateLabel("Score Rect: ", 16, 160, 64, 17) ;
	$_oSelf.parent._hInpScoreReact = GUICtrlCreateInput("1", 80, 152, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER)) ;
	GUICtrlSetState(-1, $GUI_DISABLE) ;
	GUICtrlCreateLabel("Score Cmt:", 16, 184, 56, 17)
	$_oSelf.parent._hInpScoreCmt = GUICtrlCreateInput("1", 80, 176, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER)) ;
	GUICtrlSetState(-1, $GUI_DISABLE) ;
	GUICtrlCreateLabel("Score Out:", 224, 160, 55, 17) ;
	$_oSelf.parent._hInpScoreOut = GUICtrlCreateInput("1", 280, 152, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER)) ;
	GUICtrlSetState(-1, $GUI_DISABLE) ;
	GUICtrlCreateLabel("Gender: ", 224, 184, 45, 17) ;
	$_oSelf.parent._hCbbGenderRemove = GUICtrlCreateCombo("All", 280, 176, 121, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL)) ;
	GUICtrlSetData(-1, "Male|Female") ;
	GUICtrlSetState(-1, $GUI_DISABLE) ;
	$_oSelf.parent._hBtnRemove = GUICtrlCreateButton("Filter And Remove", 128, 208, 155, 25) ;
	GUICtrlSetState(-1, $GUI_DISABLE) ;
	GUICtrlCreateGroup("Contact", 8, 240, 401, 41) ;
	GUICtrlCreateLabel($__oParent._sName & " - v" & $__oParent._sVersion & " - " & $__oParent._sAppCreated & " by " & $__oParent._sAuthorName, 16, 256, 282, 17) ;
	$_oSelf.parent._hBtnContact = GUICtrlCreateButton("Contact", 304, 256, 99, 17) ;
EndFunc   ;==>_FRFFormMain_Init



Func _FRFFormMain_Show($_oSelf)
	GUISetState(@SW_SHOW, $_oSelf.parent._hGUI) ;
EndFunc   ;==>_FRFFormMain_Show



Func _FRFFormMain_Hide($_oSelf)
	GUISetState(@SW_HIDE, $_oSelf.parent._hGUI) ;
EndFunc   ;==>_FRFFormMain_Hide



Func _FRFFormMain_SetEnables($_oSelf)
	If $_oSelf.arguments.length == 0 Then
		Return ;
	EndIf
	$__oParent = $_oSelf.parent ;
	$__bEnbled = $_oSelf.arguments.values[0] ;
	if $__bEnbled  Then
		$__bEnbled = $GUI_ENABLE;
	Else
		$__bEnbled = $GUI_DISABLE;
	EndIf
	GUICtrlSetState($_oSelf.parent._hBtnLogin, $__bEnbled) ;
	GUICtrlSetState($_oSelf.parent._hInpCookie, $__bEnbled) ;
	GUICtrlSetState($_oSelf.parent._hInpScoreReact, $__bEnbled) ;
	GUICtrlSetState($_oSelf.parent._hInpScoreCmt, $__bEnbled) ;
	GUICtrlSetState($_oSelf.parent._hInpScoreOut, $__bEnbled) ;
	GUICtrlSetState($_oSelf.parent._hCbbGenderRemove, $__bEnbled) ;
	GUICtrlSetState($_oSelf.parent._hBtnRemove, $__bEnbled) ;
	GUICtrlSetState($_oSelf.parent._hBtnContact, $__bEnbled) ;
EndFunc   ;==>_FRFFormMain_SetEnables




Func _FRFFormMain_getError($_oSelf)
	$__oParent = $_oSelf.parent ;
	Switch $__oParent.__status
		Case 1
			Return "Success" ;
	EndSwitch
EndFunc   ;==>_FRFFormMain_getError




Func _FRFFormMain_toString($_oSelf)
	$__oParent = $_oSelf.parent ;
	Dim $__a = [] ;
	Return _AutoItObject_ArrayToString($__oParent.__name, $__a) ;
EndFunc   ;==>_FRFFormMain_toString
