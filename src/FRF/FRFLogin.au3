#include-once
#include <..\lib\AutoItObject.au3>
#include <..\lib\_HttpRequest.au3>
#include <..\util\ConstructArgs.au3>
#include <..\util\Utilities.au3>




Func _New_FRFLogin($__aArgs = Null)
	$__object = IDispatch() ;
	$__object.__name = "FRFLogin" ;
	$__object.__des = "" ;
	$__object.__status = 1 ;
	;
	$__oArgs = _New_ConstructArgs($__aArgs) ;
	$__object._oAccount = $__oArgs.arg() ;
	;
	$__object.__defineGetter("_toString", _FRFLogin_toString) ;
	$__object.__defineGetter("_getError", _FRFLogin_getError) ;
	$__object.__defineGetter("_login", _FRFLogin_Login) ;
	;
	$__object.__lock() ;
	;
	Return $__object ;
EndFunc   ;==>_New_FRFLogin


Func _FRFLogin_Login($__oSelf)
	$__oThis = $__oSelf.parent ;
	If Not IsObj($__oThis._oAccount) Then
		$__oSelf.parent.__status = 0;
		Return False ;
	EndIf
	;
	$__oAccount = __FRF_CheckCookie($__oThis._oAccount) ;
	If $__oAccount == False Then
		$__oSelf.parent.__status = -1;
		Return False ;
	EndIf
	;
	$__oSelf.parent._oAccount = $__oAccount ;
	;
	Return True ;
EndFunc   ;==>_FRFLogin_Login


Func _FRFLogin_toString($__oSelf)
	$__oParent = $__oSelf.parent ;
	Dim $__a = [$__oParent._oAccount._toString()] ;
	Return _AutoItObject_ArrayToString($__oParent.__name, $__a) ;
EndFunc   ;==>_FRFLogin_toString


Func _FRFLogin_getError($__oSelf)
	$__oParent = $__oSelf.parent ;
	Switch $__oParent.__status
		Case 1
			Return "Success" ;
		Case 0
			return "$_oAccount is null!";
		Case -1
			Return "Cookie expired!";
	EndSwitch
EndFunc   ;==>_FRFLogin_errToString



Func __FRF_CheckCookie($__oAccount)
	$__sBody = _HttpRequest(2, "https://mbasic.facebook.com/profile.php", "", $__oAccount._sCookie) ;
	$__sName = StringRegExp($__sBody, "\<title\>(.+?)\<\/title\>", 3)     ;
	$__sFbDtsg = StringRegExp($__sBody, 'name\=\"fb\_dtsg\"\svalue\=\"(.+?)\"', 3)     ;
	$__sUidMe = StringRegExp($__sBody, 'name\=\"target\"\svalue\=\"([0-9]+?)\"', 3)     ;
	;
	If $__sName <> 1 And $__sFbDtsg <> 1 And $__sUidMe <> 1 Then
		$__oAccount._sToken = __FRF_GetTokenFromCookie($__oAccount._sCookie) ;
		$__oAccount._sName = $__sName[0] ;
		$__oAccount._sFb_dtsg = $__sFbDtsg[0] ;
		$__oAccount._sId = $__sUidMe[0] ;
		Return $__oAccount ;
	EndIf
	;
	_Util_Debug("! FRFLogin->__FRF_CheckCookie->Cookie expired!") ;
	Return False ;
EndFunc   ;==>__FRF_CheckCookie

Func __FRF_GetTokenFromCookie($__sCookie)
	$__sUrlGetToken = "https://m.facebook.com/composer/ocelot/async_loader/?publisher=feed" ;
	$__sHeader = "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36" ;
	$__sReferer = "https://facebook.com/" ;
	;
	$__sBody = _HttpRequest(2, $__sUrlGetToken, "", $__sCookie, $__sReferer, $__sHeader) ;
	;
	$__aToken = StringRegExp($__sBody, '(EAAAA.+?ZD)', 3) ;
	;
	If $__aToken <> 1 Then
		Return $__aToken[0] ;
	EndIf
	_Util_Debug("! FRFLogin->__FRF_GetTokenFromCookie->not Token!") ;
	Return False ;
EndFunc   ;==>__FRF_GetTokenFromCookie

