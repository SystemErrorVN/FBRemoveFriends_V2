#include <util\Utilities.au3>

#include <FRF\FRFLogin.au3>
#include <FRF\FRFGetFriends.au3>
#include <FRF\FRFRemove.au3>
#include <FRF\FRFForm.au3>

#include <model\Account.au3>
#include <model\Friend.au3>



Global Const $__STRING_APPNAME = "FBRemoveFriends", _ ;
		$__STRING_SLOGAN = "Filter non-interactive friends!", _ ;
		$__STRING_VERSION = "2.0.0", _     ;
		$__STRING_AUTHORNAME = "ThienDepTraii", _ ;
		$__STRING_APPCREATED = "@2020" ;


Global $_oAccount = Null, _ ;
		$_aFriends = Null, _ ;
		$_oFRFForm = Null ;


_Main_Nov3Mber_() ;

Func _Main_Nov3Mber_()

	Local $__aArgsFRFForm = [ _
			$__STRING_APPNAME, _
			$__STRING_SLOGAN, _
			$__STRING_VERSION, _
			$__STRING_AUTHORNAME, _
			$__STRING_APPCREATED _
			] ;
	$_oFRFForm = _New_FRFForm($__aArgsFRFForm) ;

	$_oFRFForm._init() ;
	$_oFRFForm._show() ;

	While 1
		$__nMsg = GUIGetMsg() ;
		Switch $__nMsg
			Case $GUI_EVENT_CLOSE
				Exit ;
			Case $_oFRFForm._hBtnLogin
				__Main_Login() ;
			Case $_oFRFForm._hBtnRemove
				__Main_Remove() ;
			Case $_oFRFForm._hBtnContact
				__Main_Contact() ;
		EndSwitch
	WEnd

EndFunc   ;==>_Main_Nov3Mber_



Func __Main_Login()
	;check form
	$__sCookie = _Util_Trim(_Util_CtrlRead($_oFRFForm._hInpCookie)) ;
	If $__sCookie == "" Then
		_Util_MsgboxWarning("Cookie is Empty?") ;
		Return ;
	EndIf
	$_oFRFForm._setEnables(False) ;
	_Util_Tooltip("Loging...", "Please wait a moment...", _Util_WinGetPos($_oFRFForm)) ;
	;
	$_oAccount = _New_Account() ;
	$_oAccount._sCookie = $__sCookie ;
	;
	$__oFRFLogin = _New_FRFLogin() ;
	$__oFRFLogin._oAccount = $_oAccount ;
	;
	If $__oFRFLogin._login() == False Then
		$__sError = $__oFRFLogin._getError() ;
		_Util_ResetTooltip() ;
		_Util_MsgboxError("Login Fail!" & @CRLF & $__sError) ;
		Return ;
	EndIf
	;
	_Util_Tooltip("Get friends...", "Please wait a moment...", _Util_WinGetPos($_oFRFForm)) ;
	;
	$_oAccount = $__oFRFLogin._oAccount ;
	;
	$__oFRFGetFriends = _New_FRFGetFriends() ;
	$__oFRFGetFriends._oAccount = $_oAccount ;
	;
	If $__oFRFGetFriends._build() == False Then
		$__sError = $__oFRFGetFriends._getError() ;
		_Util_ResetTooltip() ;
		_Util_MsgboxError("Login Fail!" & @CRLF & $__sError) ;
		Return ;
	EndIf
	;
	$_aFriends = $__oFRFGetFriends._aFriends ;
	;
	$_oFRFForm._setEnables(True) ;
	_Util_Tooltip("Login success!", "Hello: " & $_oAccount._sName & ", You have " & UBound($_aFriends) & " friends.", _Util_WinGetPos($_oFRFForm)) ;
EndFunc   ;==>__Main_Login


Func __Main_Remove()
	$__nScoreReact = _Util_Trim(_Util_CtrlRead($_oFRFForm._hInpScoreReact)) ;
	$__nScoreCmt = _Util_Trim(_Util_CtrlRead($_oFRFForm._hInpScoreCmt)) ;
	$__nScoreOut = _Util_Trim(_Util_CtrlRead($_oFRFForm._hInpScoreOut)) ;
	$__nGenderRemove = _Util_StringGenderToNumber(_Util_Trim(_Util_CtrlRead($_oFRFForm._hCbbGenderRemove))) ;
	;
	If $__nScoreReact < 1 Then
		_Util_MsgboxWarning("Score react < 1?") ;
		Return ;
	EndIf
	;
	If $__nScoreCmt < 1 Then
		_Util_MsgboxWarning("Score comment < 1?") ;
		Return ;
	EndIf
	;
	If $__nScoreOut < 1 Then
		_Util_MsgboxWarning("Score out < 1?") ;
	EndIf
	;
	_Util_Tooltip("Set remove...", "Please wait a moment...", _Util_WinGetPos($_oFRFForm)) ;
	$_oFRFForm._setEnables(False) ;
	;
	Local $__aArgsFRFRemove = [ _
			$_oAccount, _
			$_aFriends, _
			$__nScoreReact, _
			$__nScoreCmt, _
			$__nScoreOut, _
			$__nGenderRemove _
			] ;
	$__oFRFRemove = _New_FRFRemove($__aArgsFRFRemove) ;
	;
	If $__oFRFRemove._setRemove() == False Then
		$__sError = $__oFRFRemove._getError() ;
		_Util_ResetTooltip() ;
		_Util_MsgboxError("setRemove Fail!" & @CRLF & $__sError) ;
		Return ;
	EndIf
	;
	_Util_Tooltip("Removing...", "Please wait a moment...", _Util_WinGetPos($_oFRFForm)) ;
	;
	If $__oFRFRemove._remove() == False Then
		$__sError = $__oFRFRemove._getError() ;
		_Util_ResetTooltip() ;
		_Util_MsgboxError("Remove Fail!" & @CRLF & $__sError) ;
		Return ;
	EndIf
	;
	_Util_ResetTooltip() ;
	_Util_MsgboxSuccess("Removed Done!") ;
	$_oFRFForm._setEnables(True) ;
EndFunc   ;==>__Main_Remove



Func __Main_Contact()
	_Util_OpenTabBrowswer() ;
EndFunc   ;==>__Main_Contact







