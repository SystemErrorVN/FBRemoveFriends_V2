#include-once
#include <..\lib\AutoItObject.au3>
#include <..\util\ConstructArgs.au3>

Func _new_Account($__aArgs = Null)
	$__oAccount = IDispatch() ;
	$__oAccount.__name = "Account" ;
	$__oAccount.__des = "" ;
	;
	$__oArgs = _New_ConstructArgs($__aArgs) ;
	$__oAccount._sCookie = $__oArgs.arg() ;
	$__oAccount._sToken = $__oArgs.arg() ;
	$__oAccount._sFb_dtsg = $__oArgs.arg() ;
	$__oAccount._sName = $__oArgs.arg() ;
	$__oAccount._sId = $__oArgs.arg() ;
	;
	$__oAccount.__defineGetter("_toString", _Account_toString) ;
	;
	$__oAccount.__lock() ;
	;
	Return $__oAccount ;
EndFunc   ;==>_new_Account


Func _Account_toString($__oSelf)
	$__oParent = $__oSelf.parent ;
	Dim $__a = [$__oParent._sCookie, $__oParent._sToken, $__oParent._sFb_dtsg, $__oParent._sName, $__oParent._sId] ;
	Return _AutoItObject_ArrayToString($__oParent.__name, $__a) ;
EndFunc   ;==>_Account_toString


