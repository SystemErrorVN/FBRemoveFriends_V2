#include-once
#include <..\lib\AutoItObject.au3>
#include <..\util\ConstructArgs.au3>


Func _New_Friend($__aArgs = Null)
	$__oFriend = IDispatch() ;
	$__oFriend.__name = "Friend" ;
	$__oFriend.__des = "" ;
	;
	$__oArgs = _New_ConstructArgs($__aArgs) ;
	$__oFriend._sId = $__oArgs.arg() ;
	$__oFriend._sName = $__oArgs.arg() ;
	$__oFriend._sGender = $__oArgs.arg() ;
	$__oFriend._nCountReact = $__oArgs.arg(0) ;
	$__oFriend._nCountComment = $__oArgs.arg(0) ;
	$__oFriend._bRemove = $__oArgs.arg(False) ;
	;
	$__oFriend.__defineGetter("_toString", _Friend_toString) ;
	;
	$__oFriend.__lock() ;
	;
	Return $__oFriend ;
EndFunc   ;==>_New_Friend


Func _Friend_toString($__oSelf)
	$__oObj = $__oSelf.parent ;
	Dim $__aObj = [$__oObj._sId, $__oObj._sName, $__oObj._sGender, $__oObj._nCountReact, $__oObj._nCountComment, $__oObj._bRemove] ;
	Return _AutoItObject_ArrayToString($__oObj.__name, $__aObj) ;
EndFunc   ;==>_toString
