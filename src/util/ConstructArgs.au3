#include-once
#include <..\lib\AutoItObject.au3>


Func _New_ConstructArgs($__aArgs)
	$__oConstructArgs = IDispatch() ;
	$__oConstructArgs.__iPos = -1 ;
	$__oConstructArgs.__aArgs = $__aArgs ;

	$__oConstructArgs.__defineGetter("arg", __ConstructArgs_Arg) ;
	Return $__oConstructArgs ;
EndFunc   ;==>_New_ConstructArgs


Func __ConstructArgs_Arg($__oSelf)
	$__nLenArgs = UBound($__oSelf.parent.__aArgs) ;
	$__oSelf.parent.__iPos += 1 ;
	If $__oSelf.parent.__iPos < $__nLenArgs Then
		Return $__oSelf.parent.__aArgs[$__oSelf.parent.__iPos] ;
	EndIf
	$__nLenArgs = $__oSelf.arguments.length;
	$__oResult = $__nLenArgs == 0 ? Null : $__oSelf.arguments.values[0] ;
	Return $__oResult;
EndFunc   ;==>arg
