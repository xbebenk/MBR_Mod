; #FUNCTION# ====================================================================================================================
; Name ..........: ExtendedAttackBarCheck (part of AttackBarCheck($Remaining))
; Description ...: Drag Attack Bar for more troops/spells beyond the Slot 11
; Syntax ........:
; Parameters ....:
; Return values .:
; Author ........: Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func ExtendedAttackBarCheck($aTroop1stPage, $Remaining = False)

	Local $x = 40, $y = 659, $x1 = 853, $y1 = 698
	Static Local $CheckSlotwHero2 = False

	If Not $Remaining Then $CheckSlotwHero2 = False

	; Setup arrays, including default return values for $return
	Local $aResult[1][6], $aCoordArray[1][2], $aCoords, $aCoordsSplit, $aValue
	Local $redLines = "FV"
	Local $directory = @ScriptDir & "\imgxml\AttackBar"
	If $g_bRunState = False Then Return
	; Capture the screen for comparison
	_CaptureRegion2($x, $y, $x1, $y1)

	Local $strinToReturn = ""
	; Perform the search
	Local $res = DllCallMyBot("SearchMultipleTilesBetweenLevels", "handle", $g_hHBitmap2, "str", $directory, "str", "FV", "Int", 0, "str", $redLines, "Int", 0, "Int", 1000)

	If IsArray($res) Then
		If $res[0] = "0" Or $res[0] = "" Then
			SetLog("Imgloc|AttackBarCheck not found!", $COLOR_RED)
		ElseIf StringLeft($res[0], 2) = "-1" Then
			SetLog("DLL Error: " & $res[0] & ", AttackBarCheck", $COLOR_RED)
		Else
			; Get the keys for the dictionary item.
			If $g_iDebugSetlog = 1 Then Setlog("$res[0] = " & $res[0])
			Local $aKeys = StringSplit($res[0], "|", $STR_NOCOUNT)

			; Redimension the result array to allow for the new entries
			ReDim $aResult[UBound($aKeys)][6]

			; Loop through the array
			For $i = 0 To UBound($aKeys) - 1
				If $g_bRunState = False Then Return
				; Get the property values
				$aResult[$i][0] = RetrieveImglocProperty($aKeys[$i], "objectname")
				; Get the coords property
				$aValue = RetrieveImglocProperty($aKeys[$i], "objectpoints")
				$aCoords = StringSplit($aValue, "|", $STR_NOCOUNT)
				$aCoordsSplit = StringSplit($aCoords[0], ",", $STR_NOCOUNT)
				If UBound($aCoordsSplit) = 2 Then
					; Store the coords into a two dimensional array
					$aCoordArray[0][0] = $aCoordsSplit[0] ; X coord.
					$aCoordArray[0][1] = $aCoordsSplit[1] ; Y coord.
				Else
					$aCoordArray[0][0] = -1
					$aCoordArray[0][1] = -1
				EndIf
				If $g_iDebugSetlog = 1 Then Setlog($aResult[$i][0] & " | $aCoordArray: " & $aCoordArray[0][0] & "-" & $aCoordArray[0][1])
				;;;;;;;; If exist Castle Spell ;;;;;;;
				If UBound($aCoords) > 1 And StringInStr($aResult[$i][0], "Spell") <> 0 Then
					If $g_iDebugSetlog = 1 Then Setlog($aResult[$i][0] & " detected twice!")
					Local $aCoordsSplit2 = StringSplit($aCoords[1], ",", $STR_NOCOUNT)
					If UBound($aCoordsSplit2) = 2 Then
						; Store the coords into a two dimensional array
						If $aCoordsSplit2[0] < $aCoordsSplit[0] Then
							$aCoordArray[0][0] = $aCoordsSplit2[0] ; X coord.
							$aCoordArray[0][1] = $aCoordsSplit2[1] ; Y coord.
							If $g_iDebugSetlog = 1 Then Setlog($aResult[$i][0] & " | $aCoordArray: " & $aCoordArray[0][0] & "-" & $aCoordArray[0][1], $COLOR_RED)
						EndIf
					Else
						$aCoordArray[0][0] = -1
						$aCoordArray[0][1] = -1
					EndIf
				EndIf
				; Store the coords array as a sub-array
				$aResult[$i][1] = Number($aCoordArray[0][0])
				$aResult[$i][2] = Number($aCoordArray[0][1])
			Next

			_ArraySort($aResult, 0, 0, 0, 1) ; Sort By X position , will be the Slot 0 to $i

			If Not $Remaining Then
				For $i = 0 To UBound($aResult) - 1
					If $aResult[$i][0] = "King" Or $aResult[$i][0] = "Queen" Or $aResult[$i][0] = "Warden" Then
						$CheckSlotwHero2 = True
					EndIf
				Next
			EndIf

			For $i = UBound($aResult) - 1 To 0 Step -1
				Local $Slottemp
				If $aResult[$i][1] > 0 Then
					If $g_iDebugSetlog = 1 Then SetLog("SLOT : " & $i, $COLOR_DEBUG) ;Debug
					If $g_iDebugSetlog = 1 Then SetLog("Detection : " & $aResult[$i][0] & "|x" & $aResult[$i][1] & "|y" & $aResult[$i][2], $COLOR_DEBUG) ;Debug
					$Slottemp = SlotAttack(Number($aResult[$i][1]), False, False) + 18
					If $CheckSlotwHero2 And StringInStr($aResult[$i][0], "Spell") = 0 Then $Slottemp -= 14
					If $g_bRunState = False Then Return ; Stop function
					If _Sleep(20) Then Return ; Pause function
					If UBound($Slottemp) = 2 Then
						If $g_iDebugSetlog = 1 Then SetLog("OCR : " & $Slottemp[0] & "|SLOT: " & $Slottemp[1], $COLOR_DEBUG) ;Debug
						If $aResult[$i][0] = "Castle" Or $aResult[$i][0] = "King" Or $aResult[$i][0] = "Queen" Or $aResult[$i][0] = "Warden" Then
							$aResult[$i][3] = 1
							$aResult[$i][4] = 21 - $Slottemp[1] ; reverse slot from 11 to 21
						Else
							$aResult[$i][3] = Number(getTroopCountBig(Number($Slottemp[0]), 636)) ; For Bigg Numbers , when the troops is selected
							$aResult[$i][4] = 21 - $Slottemp[1] ; reverse slot
							If $aResult[$i][3] = "" Or $aResult[$i][3] = 0 Then
								$aResult[$i][3] = Number(getTroopCountSmall(Number($Slottemp[0]), 641)) ; For small Numbers
								$aResult[$i][4] = 21 - $Slottemp[1] ; reverse slot
							EndIf
						EndIf
					Else
						Setlog("Problem with Attack bar detection!", $COLOR_RED)
						SetLog("Detection : " & $aResult[$i][0] & "|x" & $aResult[$i][1] & "|y" & $aResult[$i][2], $COLOR_DEBUG)
						$aResult[$i][3] = -1
						$aResult[$i][4] = -1
					EndIf

					If IsArray($aTroop1stPage) Then
						If _ArraySearch($aTroop1stPage, $aResult[$i][0]) = -1 Then
							$strinToReturn &= "|" & TroopIndexLookup($aResult[$i][0]) & "#" & $aResult[$i][4] & "#" & $aResult[$i][3]
						Else
							If $g_iDebugSetlog = 1 Then Setlog($aResult[$i][0] & " is already found in 1st page at Slot: " & _ArraySearch($aTroop1stPage, $aResult[$i][0]))
						EndIf
					EndIf
				EndIf
			Next
		EndIf
	EndIf

	Setlog("Extended String: " & $strinToReturn)
	Return $strinToReturn

EndFunc   ;==>AttackBarCheck