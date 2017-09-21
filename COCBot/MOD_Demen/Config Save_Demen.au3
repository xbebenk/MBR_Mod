; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...: Saves all of the GUI values to the config.ini and building.ini files
; Syntax ........: saveConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........: Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SaveConfig_Mod()
	; 	QuickTrainCombo (Checkbox) - Demen_QT_#9006
	ApplyConfig_Mod("Save")
	_Ini_Add("other", "ChkUseQTrain", $g_bQuickTrainEnable ? 1 : 0)
	_Ini_Add("other", "ChkMultiClick", $g_bChkMultiClick ? 1 : 0)
	_Ini_Add("troop", "QuickTrainArmy1", $g_bQuickTrainArmy[0] ? 1 : 0)
	_Ini_Add("troop", "QuickTrainArmy2", $g_bQuickTrainArmy[1] ? 1 : 0)
	_Ini_Add("troop", "QuickTrainArmy3", $g_bQuickTrainArmy[2] ? 1 : 0)

	; SmartTrain - Demen_ST_#9002
	_Ini_Add("SmartTrain", "Enable", $ichkSmartTrain)
	_Ini_Add("SmartTrain", "PreciseTroops", $ichkPreciseTroops)
	_Ini_Add("SmartTrain", "ChkFillArcher", $ichkFillArcher)
	_Ini_Add("SmartTrain", "FillArcher", $iFillArcher)
	_Ini_Add("SmartTrain", "FillEQ", $ichkFillEQ)

	; ExtendedAttackBar - Demen_S11+_#9003
	_Ini_Add("attack", "ExtendedAttackBarDB", $g_abChkExtendedAttackBar[$DB] ? 1 : 0)
	_Ini_Add("attack", "ExtendedAttackBarLB", $g_abChkExtendedAttackBar[$LB] ? 1 : 0)

	; CheckCCTroops - Demen_CC_#9004
	_Ini_Add("CheckCC", "Enable", $g_bChkCC ? 1 : 0)
	_Ini_Add("CheckCC", "Troop Capacity", $g_iCmbCastleCapacityT)
	_Ini_Add("CheckCC", "Spell Capacity", $g_iCmbCastleCapacityS)
	For $i = 0 To 4
		_Ini_Add("CheckCC", "ExpectSlot" & $i, $g_aiCmbCCSlot[$i])
		_Ini_Add("CheckCC", "ExpectQty" & $i, $g_aiTxtCCSlot[$i])
	Next

EndFunc   ;==>SaveConfig_Mod

; Demen_SA_#9001
Func SaveConfig_SwitchAcc()
	ApplyConfig_SwitchAcc("Save")

	IniWriteS($g_sProfilePath & "\Profile.ini", "SwitchAcc", "Enable", $g_bChkSwitchAcc)
	IniWriteS($g_sProfilePath & "\Profile.ini", "SwitchAcc", "SmartSwitch", $g_bChkSmartSwitch)
	IniWriteS($g_sProfilePath & "\Profile.ini", "SwitchAcc", "Total Coc Account", $g_iTotalAcc)
	For $i = 0 To 7
		IniWriteS($g_sProfilePath & "\Profile.ini", "SwitchAcc", "AccountNo." & $i, $g_abAccountNo[$i])
		IniWriteS($g_sProfilePath & "\Profile.ini", "SwitchAcc", "ProfileNo." & $i, $g_aiProfileNo[$i])
		IniWriteS($g_sProfilePath & "\Profile.ini", "SwitchAcc", "DonateOnly." & $i, $g_abDonateOnly[$i])
	Next
	IniWriteS($g_sProfilePath & "\Profile.ini", "SwitchAcc", "Train Time To Skip", $g_iTrainTimeToSkip)

EndFunc   ;==>SaveConfig_SwitchAcc

