#include <..\lib\AutoItObject.au3>
#include <..\lib\_HttpRequest.au3>
#include <..\util\ConstructArgs.au3>
#include <..\util\Utilities.au3>

Func _New_FRFRemove($__aArgs = Null)
	;
	$__object = IDispatch() ;
	$__object.__name = "FRFRemove" ;
	$__object.__des = "" ;
	$__object.__status = 1 ;
	;
	$__oArgs = _New_ConstructArgs($__aArgs) ;

	$__object._oAccount = $__oArgs.arg() ;
	$__object._aFriends = $__oArgs.arg() ;

	$__object._nScoreReact = $__oArgs.arg(1) ;
	$__object._nScoreComment = $__oArgs.arg(1) ;
	$__object._nScoreOut = $__oArgs.arg(1) ;
	$__object._nGenderRemove = $__oArgs.arg(0) ;

	$__object._bUseSetRemove = False ;
	$__object._bUseRemove = False ;

	$__object._nRemoveDone = 0 ;
	$__object._nRemoveFail = 0 ;
	;
	$__object.__defineGetter("_toString", _FRFRemove_toString) ;
	$__object.__defineGetter("_getError", _FRFRemove_getError) ;
	$__object.__defineGetter("_setRemove", _FRFRemove_setRemove) ;
	$__object.__defineGetter("_remove", _FRFRemove_Remove) ;
	;........
	;
	$__object.__lock() ;
	;
	Return $__object ;
EndFunc   ;==>_New_FRFRemove

Func _FRFRemove_Remove($__oSelf)
	$__oParent = $__oSelf.parent ;
	;
	If $__oParent._bUseRemove == True Then
		Return False ;
	EndIf
	$__oSelf.parent._bUseRemove = True ;
	;
	$__oParent._setRemove() ;
	;
	$__aResultRemove = _FRFRemove_RemoveFriends($__oParent._oAccount, $__oParent._aFriends) ;
	$__oSelf.parent._nRemoveDone = $__aResultRemove[1] ;
	$__oSelf.parent._nRemoveFail = $__aResultRemove[2] ;
	;
	Return True ;
EndFunc   ;==>_FRFRemove_Remove


Func _FRFRemove_setRemove($__oSelf)
	$__oParent = $__oSelf.parent ;
	;
	If $__oParent._bUseSetRemove == True Then
		Return False ;
	EndIf
	$__oSelf.parent._bUseSetRemove = True ;
	;
	If $__oParent.oAccounts == Null Then
		$__oSelf.parent.__status = 0 ;
		Return False ;
	EndIf
	;
	If $__oParent.aFriends == Null Then
		$__oSelf.parent.__status = -1 ;
		Return False ;
	EndIf
	;
	$__aFriends = __FRFRemove_SetScore($__oParent._oAccount, $__oParent._aFriends) ;
	If $__aFriends == False Then
		$__oSelf.parent.__status = -2 ;
		Return False ;
	EndIf
	;
	If $__oParent._nScoreReact < 0 Then
		$__oParent._nScoreReact = 0 ;
	EndIf
	If $__oParent._nScoreComment < 0 Then
		$__oParent._nScoreComment = 0 ;
	EndIf
	If $__oParent._nScoreOut < 0 Then
		$__oParent._nScoreOut = 0 ;
	EndIf
	If $__oParent._nGenderRemove < -1 Or $__oParent._nGenderRemove > 1 Then
		$__oParent._nGenderRemove = 0 ;
	EndIf
	$__aFriends = __FRFRemove_SetRemove($__oParent._aFriends, $__oParent._nScoreReact, $__oParent._nScoreComment, $__oParent._nScoreOut, $__oParent._nGenderRemove) ;
	;
	$__oSelf.parent._aFriends = $__aFriends ;
	;
	Return True ;
EndFunc   ;==>_FRFRemove_setRemove


Func _FRFRemove_getError($__oSelf)
	$__oParent = $__oSelf.parent ;
	Switch $__oParent.__status
		Case 1
			Return "Success" ;
		Case 0
			Return "$_oAccount is null!" ;
		Case -1
			Return "$_aFriends is Null" ;
		Case -2
			Return "set score for $_aFriends Error!" ;
	EndSwitch
EndFunc   ;==>_FRFRemove_getError


Func _FRFRemove_toString($__oSelf)
	$__oParent = $__oSelf.parent ;
	Dim $__a = [$__oParent._oAccount._toString(), "$_aFriends_Len=" & UBound($__oParent._aFriends)] ; list object here...
	Return _AutoItObject_ArrayToString($__oParent.__name, $__a) ;
EndFunc   ;==>_FRFRemove_toString










Func _FRFRemove_RemoveFriends($__oAccount, $__aFriends)
	$__nDone = 0 ;
	$__nFail = 0 ;
	For $i = 0 To UBound($__aFriends) - 1
		$__bCheckRemove = $__aFriends[$i]._bRemove ;
		If $__bCheckRemove Then
			If __FRFRemove_RemoveFriend($__oAccount, $__aFriends[$i]._sId) Then
				$__nDone += 1 ;
			Else
				$__nFail += 1 ;
			EndIf
			Sleep(1000) ;
		EndIf
	Next
	Dim $__aResult[3] ;
	$__aResult[0] = $__nDone + $__nFail ;
	$__aResult[1] = $__nDone ;
	$__aResult[2] = $__nFail ;
	Return $__aResult ;
EndFunc   ;==>_FRFRemove_RemoveFriends


Func __FRFRemove_RemoveFriend($__oAccount, $__sUidRemove)
	$__sUrlRemove = "https://m.facebook.com/a/removefriend.php?friend_id=" & $__sUidRemove ;
	$__sParamPost = _
			"m_sess=" & _
			"&fb_dtsg=" & $__oAccount._sFb_dtsg & _
			"&jazoest=" & _Util_Random(4, 5) & _
			"&__csr=" & _
			"&__req=" & _Util_Random(5, 1) & _
			"&__user=" & $__oAccount._sId ;
	$sHtmlResp = _HttpRequest(2, $__sUrlRemove, _Data2SendEncode($__sParamPost), $__oAccount._sCookie) ;
	Return True ;
EndFunc   ;==>__FRFRemove_RemoveFriend


Func __FRFRemove_SetRemove($__aFriends, $__nScoreReact, $__nScoreComment, $__nScoreOut, $__nGender)
	For $i = 0 To UBound($__aFriends) - 1
		$__nValueReact = $__aFriends[$i]._nCountReact ;
		$__nValueCmt = $__aFriends[$i]._nCountComment ;
		$__sGender = $__aFriends[$i]._sGender ;

		$__nTotalScore = $__nValueReact * $__nScoreReact + $__nValueCmt * $__nScoreComment ;
		$__bCheckGender = $__nGender == 0 Or $__nGender == __FRFRemove_StringToNumberFromGender($__sGender) ;

		If $__nTotalScore < $__nScoreOut And $__bCheckGender Then
			$__aFriends[$i]._bRemove = True ;
		EndIf
	Next
	Return $__aFriends ;
EndFunc   ;==>__FRFRemove_SetRemove


Func __FRFRemove_SetScore($__oAccount, $__aFriends) ;
	$__sUrlAPI = "https://www.facebook.com/api/graphql/" ;
	$__sParamPost = _
			"fb_dtsg=" & $__oAccount._sFb_dtsg & _
			"&q=" & _URIEncode("node(" & $__oAccount._sId & "){timeline_feed_units.first(500).after(){page_info,edges{node{id,creation_time,feedback{reactors{nodes{id}},commenters{nodes{id}}}}}}}") ;
	;
	$__sBody = _HttpRequest(2, $__sUrlAPI, _Data2SendEncode($__sParamPost), $__oAccount._sCookie) ;
	$__oJsonResp = __FRFRemove_BodyToJson($__sBody) ;
	;
	If IsObj($__oJsonResp) Then
		;
		$__oJsonNodeFeed = $__oJsonResp.get($__oAccount._sId & ".timeline_feed_units.edges") ;
		If IsObj($__oJsonNodeFeed) Then
			;
			For $i = 0 To $__oJsonNodeFeed.length() - 1
				;
				$__oJsonNodesReact = $__oJsonNodeFeed.index($i).node.feedback.reactors.nodes ;
				For $j = 0 To $__oJsonNodesReact.length() - 1 ;
					$__sKey = $__oJsonNodesReact.index($j).id ;
					$__nIndex = __FRFRemove_getIndex($__sKey, $__aFriends) ;
					If $__nIndex <> False Then
						$__aFriends[$__nIndex]._nCountReact += 1 ;
					EndIf
				Next
				;
				$__oJsonNodesCmt = $__oJsonNodeFeed.index($i).node.feedback.commenters.nodes ;
				For $j = 0 To $__oJsonNodesCmt.length() - 1 ;
					$__sKey = $__oJsonNodesCmt.index($j).id ;
					$__nIndex = __FRFRemove_getIndex($__sKey, $__aFriends) ;
					If $__nIndex <> False Then
						$__aFriends[$__nIndex]._nCountComment += 1 ;
					EndIf
				Next
			Next
			Return $__aFriends ;
		EndIf
	EndIf
	_Util_Debug("! FRF_UDF->__FRF_SetScore->Error!") ;
	Return False ;
EndFunc   ;==>__FRFRemove_SetScore


Func __FRFRemove_BodyToJson($__sBody)
	$__sBody = StringReplace($__sBody, "for (;;);", "") ;
	$__oJson = _HttpRequest_ParseJson($__sBody) ;
	If IsObj($__oJson) Then
		Return $__oJson ;
	EndIf
	_Util_Debug("! FRF_UDF->__FRF_BodyToJson->Error!") ;
	Return False ;
EndFunc   ;==>__FRFRemove_BodyToJson


Func __FRFRemove_StringToNumberFromGender($__sGender)
	Switch $__sGender
		Case "male"
			Return 1 ;
		Case "female"
			Return -1 ;
		Case Else
			Return 0 ;
	EndSwitch
EndFunc   ;==>__FRFRemove_StringToNumberFromGender


Func __FRFRemove_getIndex($__sId, $__aFriends)
	For $i = 0 To UBound($__aFriends) - 1
		If $__aFriends[$i]._sId == $__sId Then
			Return $i ;
		EndIf
	Next
	Return False ;
EndFunc   ;==>__FRFRemove_getIndex
