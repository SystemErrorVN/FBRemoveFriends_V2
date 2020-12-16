#include <..\lib\AutoItObject.au3>
#include <..\lib\_HttpRequest.au3>
#include <..\util\ConstructArgs.au3>
#include <..\util\Utilities.au3>
#include <..\model\Friend.au3>
#include <Array.au3>


Func _New_FRFGetFriends($__aArgs = Null)
	;
	$__object = IDispatch() ;
	$__object.__name = "FRFGetFriends" ;
	$__object.__des = "" ;
	$__object.__status = 1 ;
	;
	$__oArgs = _New_ConstructArgs($__aArgs) ;
	$__object._oAccount = $__oArgs.arg() ;
	$__object._aFriends = $__oArgs.arg() ;
	;........
	;
	$__object.__defineGetter("_toString", _FRFGetFriends_toString) ;
	$__object.__defineGetter("_getError", _FRFGetFriends_getError) ;
	$__object.__defineGetter("_build", _FRFGetFriends_getFriends) ;
	;........
	;
	$__object.__lock() ;
	;
	Return $__object ;
EndFunc   ;==>_New_FRFGetFriends


Func _FRFGetFriends_getFriends($_oSelf)
	$_oParent = $_oSelf.parent ;
	;
	If $_oParent._oAccount == Null Then
		$_oSelf.parent.__status = 0 ;
		Return False ;
	EndIf
	;
	If $_oParent._oAccount._sToken == Null Then
		$_oSelf.parent.__status = -1 ;
		Return False ;
	EndIf
	;
	$__aFriends = __FRFGetFriends_GetListFriends($_oParent._oAccount._sToken) ;
	If $__aFriends == False Then
		$_oSelf.parent.__status = -2 ;
		Return False ;
	EndIf
	$_oSelf.parent._aFriends = $__aFriends ;
	;
	Return True ;
EndFunc   ;==>_FRFGetFriends_getFriends


Func _FRFGetFriends_getError($__oSelf)
	$__oParent = $__oSelf.parent ;
	Switch $__oParent.__status
		Case 1
			Return "Success" ;
		Case 0
			Return "$_oAccount is null!" ;
		Case -1
			Return "$_oAccount._sToken is null!" ;
		Case -2
			Return "get friends error!" ;
	EndSwitch
EndFunc   ;==>_FRFGetFriends_getError


Func _FRFGetFriends_toString($__oSelf)
	$__oParent = $__oSelf.parent ;
	Dim $__a = [$__oParent._oAccount._toString(), "$_aFriends_Len=" & (UBound($__oParent._aFriends))] ; list object here...
	Return _AutoItObject_ArrayToString($__oParent.__name, $__a) ;
EndFunc   ;==>_FRFGetFriends_toString






Func __FRFGetFriends_GetListFriends($__sToken)
	$__sUrlAPI = "https://graph.facebook.com/me/friends?fields=gender,name&limit=5000&access_token=" & $__sToken ;
	$__sBody = _HttpRequest(2, $__sUrlAPI) ;
	$__oJson = _HttpRequest_ParseJson($__sBody) ;
	If IsObj($__oJson) And IsObj($__oJson.data) Then
		$__nLenDataFriend = $__oJson.data.length() ;
		Dim $__oFriend[$__nLenDataFriend] ;
		For $i = 0 To $__nLenDataFriend - 1
			Dim $__aArgsFriend = [ _
					$__oJson.data.index($i).id, _
					$__oJson.data.index($i).name, _
					$__oJson.data.index($i).gender _
					] ;
			$__oFriend[$i] = _New_Friend($__aArgsFriend) ;
			_Util_Debug($__oFriend[$i]._toString());
		Next
		Return $__oFriend ;
	EndIf
	_Util_Debug("! FRF_UDF->__FRF_GetFriends->Error!") ;
	Return False ;
EndFunc   ;==>__FRFGetFriends_GetListFriends
