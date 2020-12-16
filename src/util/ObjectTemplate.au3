#include-once
#include <..\lib\AutoItObject.au3>
#include <ConstructArgs.au3>

Func _New_ObjectName($__aArgs = Null)
	;
	$__object = IDispatch() ;
	$__object.__name = "ObjectName" ;
	$__object.__des = "" ;
	$__object.__status = 1 ;
	;
	$__oArgs = _New_ConstructArgs($__aArgs) ;
	;$__object._variable = $__oArgs.arg()
	;
	$__object.__defineGetter("_toString", __ObjectName_toString) ;
	$__object.__defineGetter("_getError", __ObjectName_getError) ;
	;
	$__object.__lock() ;
	;
	Return $__object ;
EndFunc   ;==>_New_ObjectName


Func __ObjectName_getError($_oSelf)
	$__oParent = $_oSelf.parent ;
	Switch $__oParent.__status
		Case 1
			Return "Success" ;
	EndSwitch
EndFunc   ;==>_ObjectName_errToString


Func __ObjectName_toString($_oSelf)
	$__oParent = $_oSelf.parent ;
	Dim $__a = [] ; list object here...
	Return _AutoItObject_ArrayToString($__oParent.__name, $__a) ;
EndFunc   ;==>_ObjectName_toString





