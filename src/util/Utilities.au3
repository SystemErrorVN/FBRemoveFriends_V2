#cs ----------------------------------------------------------------------------
 Author:         	ThienDepTrai
 Class:				Utilities
#ce ----------------------------------------------------------------------------
#include-once

Func _Util_StringGenderToNumber($__sGender)
	Switch $__sGender
		Case "All"
			Return 0 ;
		Case "Male"
			Return 1 ;
		Case "Female"
			Return -1 ;
	EndSwitch
EndFunc   ;==>__Main_StringGenderToNumber



Func _Util_WinGetPos($__oFRFForm)
	Return WinGetPos($__oFRFForm._sName & " - v" & $__oFRFForm._sVersion) ;
EndFunc   ;==>__Main_WinGetPos



Func _Util_MsgboxError($__sContent)
	Return MsgBox(16, "Error!", $__sContent);
EndFunc



Func _Util_MsgBoxSuccess($__sContent)
	Return MsgBox(64, "Success!", $__sContent);
EndFunc



Func _Util_MsgBoxWarning($__sContent)
	Return MsgBox(32, "Warning!", $__sContent);
EndFunc



Func _Util_Trim($__sInput)
	Return StringStripWS($__sInput, 3);
EndFunc



Func _Util_CtrlRead($__gControlId)
	Return GUICtrlRead($__gControlId) ;
EndFunc   ;==>_Util_gRead



Func _Util_MsgError($__sMsg)
	MsgBox(16, "Lỗi", $__sMsg) ;
EndFunc   ;==>_Util_MsgError



Func _Util_MsgSuccess($__sMsg) ;
	MsgBox(64, "Thành công", $__sMsg) ;
EndFunc   ;==>_Util_MsgSuccess



Func _Util_ResetTooltip()
	ToolTip("")    ;
EndFunc   ;==>_Util_ResetTooltip



Func _Util_Tooltip($__sTitle, $__sContent, $__aPosition)
;~ 	$__aPosition = WinGetPos($guiMain) ;
	ToolTip($__sContent, $__aPosition[0], $__aPosition[1], $__sTitle, 1, 1) ;
EndFunc   ;==>_Util_Tooltip



Func _Util_Debug($__sText)
	ConsoleWrite($__sText & @CRLF) ;
EndFunc   ;==>_Util_Debug



Func _Util_OpenTabBrowswer($__sUrlContact = "https://facebook.com/ThienDz.SystemError")
	;
	Dim $__aPathBrowser = [ _
			"C:\Users\" & @UserName & "\AppData\Local\CocCoc\Browser\Application\browser.exe", _ ;CocCoc
			"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe", _
			"C:\Program Files\Internet Explorer\iexplore.exe" _
			] ;
	$__sCommandSell = $__sUrlContact & " --new-tab --full-screen" ;
	;
	For $i = 0 To UBound($__aPathBrowser) - 1
		$__nResult = ShellExecuteWait($__aPathBrowser[$i], $__sCommandSell) ;
		If $__nResult <> 0 Then
			Return True ;
		EndIf
	Next
	;
	Return False ;
EndFunc   ;==>_Util_OpenTabBrowswer



Func _Util_Random($__nType = 7, $__nLength = 25, $__sAdd = "")
	$__sAlphaLower = "qwertyuiopasdfghjklzxcvbnm" ;
	$__sAlphaUpper = "QWERTYUIOPASDFGHJKLZXCVBNM" ;
	$__sAlphaNumber = "1234567890" ;
	$__sRandom = $__sAdd ;
	Switch $__nType
		Case 1
			$__sRandom &= $__sAlphaLower ;
		Case 2
			$__sRandom &= $__sAlphaUpper ;
		Case 3
			$__sRandom &= $__sAlphaLower & $__sAlphaUpper ;
		Case 4
			$__sRandom &= $__sAlphaNumber ;
		Case 5
			$__sRandom &= $__sAlphaNumber & $__sAlphaLower ;
		Case 6
			$__sRandom &= $__sAlphaNumber & $__sAlphaUpper ;
		Case Else
			$__sRandom &= $__sAlphaNumber & $__sAlphaLower & $__sAlphaUpper ;
	EndSwitch
	$__sResult = "" ;
	$__aRandom = StringSplit($__sRandom, "", 2) ;
	$__nLengthARandom = UBound($__aRandom) ;
	For $i = 1 To $__nLength
		$__sResult &= $__aRandom[Random(0, $__nLengthARandom - 1)] ;
	Next
	Return $__sResult ;
EndFunc   ;==>_Util_Random
