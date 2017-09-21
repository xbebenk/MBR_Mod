; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design Child Bot - Profiles Switch Account
; Description ...:
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

; SwitchAcc_Demen
Global $lblProfileNo[8], $lblProfileName[8], $cmbAccountNo[8], $cmbProfileType[8]
<<<<<<< HEAD
Global $chkSwitchAcc = 0, $chkSwitchAccShared_pref = 0, $cmbTotalAccount = 0, $radNormalSwitch = 0, $radSmartSwitch = 0, $chkUseTrainingClose = 0, $radCloseCoC = 0, $radCloseAndroid = 0, $cmbLocateAcc = 0, $g_hCmbTrainTimeToSkip = 0
=======
Global $cmbTotalAccount = 0, $radNormalSwitch = 0, $radSmartSwitch = 0, $chkUseTrainingClose = 0, $radCloseCoC = 0, $radCloseAndroid = 0, $cmbLocateAcc = 0, $g_hCmbTrainTimeToSkip = 0
>>>>>>> 73f3ae0... New SwitchAcc
Global $g_hChkForceSwitch = 0, $g_txtForceSwitch = 0, $g_lblForceSwitch = 0, $g_hChkForceStayDonate = 0

; New
Global $g_hChkSwitchAcc = 0, $g_hCmbTotalAccount = 0, $g_hChkSmartSwitch = 0
Global $g_ahChkAccount[8], $g_ahCmbProfile[8], $g_ahChkDonate[8]
Global $g_hTxtSALog

Func CreateBotSwitchAcc()

	Local $sTxtTip = ""
	Local $x = 20, $y = 110

	GUICtrlCreateGroup("Switch Account", $x - 10, $y - 20, 225, 335)

		$g_hChkSwitchAcc = GUICtrlCreateCheckbox("Enable SwitchAccount", $x, $y, -1, -1)
		GUICtrlSetOnEvent(-1, "chkSwitchAcc")

		$g_hChkSmartSwitch = GUICtrlCreateCheckbox("Smart switch", $x + 135, $y, 75, -1)
		GUICtrlSetTip(-1, "Switch to account with the shortest remain training time")
		GUICtrlSetState(-1, $GUI_UNCHECKED)
;~ 		GUICtrlSetOnEvent(-1, "chkSmartSwitch")

		$y += 26
		GUICtrlCreateLabel("Skip switch if train time < ", $x + 15, $y, -1, -1)
		$g_hCmbTrainTimeToSkip = GUICtrlCreateCombo("", $x + 135, $y - 4, 60, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "0 min|1 min|2 mins|3 mins|4 mins|5 mins|6 mins|7 mins|8 mins|9 mins", "1 min")

		$y += 25
		GUICtrlCreateLabel("Total CoC Account:", $x + 15, $y, -1, -1)
		$g_hCmbTotalAccount = GUICtrlCreateCombo("", $x + 135, $y - 4, 60, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "2 Acc|3 Acc|4 Acc|5 Acc|6 Acc|7 Acc|8 Acc", "2 Acc")
		GUICtrlSetOnEvent(-1, "cmbTotalAcc")

		$y += 30
		GUICtrlCreateLabel("Account", $x - 10, $y, 60, -1, $SS_CENTER)
		GUICtrlCreateLabel("Profile name", $x + 70, $y, 70, -1, $SS_CENTER)
		GUICtrlCreateLabel("Donate only", $x + 150, $y, 60, -1, $SS_CENTER)

		$y += 20
		GUICtrlCreateGraphic($x, $y, 205, 1, $SS_GRAYRECT)

		$y += 8
		For $i = 0 To 7
			$g_ahChkAccount[$i] = GUICtrlCreateCheckbox("Acc. " & $i + 1 & ".", $x, $y + ($i) * 25, -1, -1)
			GUICtrlSetOnEvent(-1, "chkAccount" & $i)
			$g_ahCmbProfile[$i] = GUICtrlCreateCombo("", $x + 65, $y + ($i) * 25, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, _GUICtrlComboBox_GetList($g_hCmbProfile))
			$g_ahChkDonate[$i] = GUICtrlCreateCheckbox("", $x + 190, $y + ($i) * 25 - 3, -1, 25)
		Next

	GUICtrlCreateGroup("", -99, -99, 1, 1)

<<<<<<< HEAD
	; Profiles & Account matching
	Local $x = 235, $y = 120
	
	;xbenk
	GUICtrlCreateGroup(GetTranslated(109, 37, "Profiles"), $x - 20, $y - 20, 225, 295)
	$chkSwitchAccShared_pref = GUICtrlCreateCheckbox(GetTranslated("sam m0d", 37, "Enable Shared_Pref Switch"), $x + 15, $y - 45, -1, -1)
	$sTxtTip = GetTranslated("sam m0d", 38, "Enable Sam Mod Shared Prefs Switching Method")
	GUICtrlSetTip(-1, $sTxtTip)
	
	GUICtrlCreateGroup(GetTranslated(109, 37, "Profiles"), $x - 20, $y - 20, 225, 295)
	GUICtrlCreateButton(GetTranslated(109, 38, "Update Profiles"), $x + 40, $y - 5, -1, 25)
	GUICtrlSetOnEvent(-1, "g_btnUpdateProfile")
	GUICtrlCreateButton(GetTranslated(109, 39, "Clear Profiles"), $x + 130, $y - 5, -1, 25)
	GUICtrlSetOnEvent(-1, "btnClearProfile")

	$y += 35
	GUICtrlCreateLabel(GetTranslated(109, 40, "No."), $x - 10, $y, 15, -1, $SS_CENTER)
	GUICtrlCreateLabel(GetTranslated(109, 41, "Profile Name"), $x + 10, $y, 90, -1, $SS_CENTER)
	GUICtrlCreateLabel(GetTranslated(109, 42, "Acc."), $x + 105, $y, 30, -1, $SS_CENTER)
	GUICtrlCreateLabel(GetTranslated(109, 43, "Bot Type"), $x + 140, $y, 60, -1, $SS_CENTER)

	$y += 20
	GUICtrlCreateGraphic($x - 10, $y, 205, 1, $SS_GRAYRECT)
	GUICtrlCreateGraphic($x + 10, $y - 25, 1, 40, $SS_GRAYRECT)

	$g_SecondHideSwitchAcc = GUICtrlCreateDummy()
	$y += 10
	For $i = 0 To 7
		$lblProfileNo[$i] = GUICtrlCreateLabel($i + 1 & ".", $x - 10, $y + 4 + ($i) * 25, 15, 18, $SS_CENTER)
		GUICtrlCreateGraphic($x + 10, $y + ($i) * 25, 1, 25, $SS_GRAYRECT)

		$lblProfileName[$i] = GUICtrlCreateLabel(GetTranslated(109, 44, "Village Name"), $x + 10, $y + 4 + ($i) * 25, 90, 18, $SS_CENTER)
		If $i <= $nTotalProfile - 1 Then GUICtrlSetData(-1, $ProfileList[$i + 1])
		$cmbAccountNo[$i] = GUICtrlCreateCombo("", $x + 105, $y + ($i) * 25, 30, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		$sTxtTip = GetTranslated(109, 45, "Select the index of CoC Account to match with this Profile")
		GUICtrlSetData(-1, "1" & "|" & "2" & "|" & "3" & "|" & "4" & "|" & "5" & "|" & "6" & "|" & "7" & "|" & "8")
		GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlSetOnEvent(-1, "cmbMatchProfileAcc" & $i + 1)
		$cmbProfileType[$i] = GUICtrlCreateCombo("", $x + 140, $y + ($i) * 25, 60, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		$sTxtTip = GetTranslated(109, 46, "Define the botting type of this profile")
		GUICtrlSetData(-1, GetTranslated(109, 47, "Active") & "|" & GetTranslated(109, 48, "Donate") & "|" & GetTranslated(109, 49, "Idle"))
		GUICtrlSetTip(-1, $sTxtTip)
		If $i > $nTotalProfile - 1 Then
			For $j = $lblProfileNo[$i] To $cmbProfileType[$i]
				GUICtrlSetState($j, $GUI_HIDE)
			Next
		EndIf
	Next
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$g_EndHideSwitchAcc = GUICtrlCreateDummy()

=======
>>>>>>> 73f3ae0... New SwitchAcc
EndFunc   ;==>CreateBotSwitchAcc

Func CreateBotSwitchAccLog()
	Local $x = 0, $y = 0

	Local $activeHWnD1 = WinGetHandle("") ; RichEdit Controls tamper with active window

	$g_hTxtSALog = _GUICtrlRichEdit_Create($g_hGUI_LOG_SA, "", $x, $y, 203, 330, BitOR($ES_MULTILINE, $ES_READONLY, $WS_VSCROLL, $WS_HSCROLL, $ES_UPPERCASE, $ES_AUTOHSCROLL, $ES_AUTOVSCROLL, $ES_NUMBER, 0x200), $WS_EX_STATICEDGE)

	WinActivate($activeHWnD1) ; restore current active window
EndFunc



