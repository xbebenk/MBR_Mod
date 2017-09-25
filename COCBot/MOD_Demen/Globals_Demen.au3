; #FUNCTION# ====================================================================================================================
; Name ..........: MBR Global Variables for Demen Mod
; Description ...: This file Includes several files in the current script and all Declared variables, constant, or create an array.
; Syntax ........: #include , Global
; Parameters ....: None
; Return values .: None
; Author ........: Demen
; Modified ......: Everyone all the time  :)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

<<<<<<< HEAD
; Fix drop on edge from DocOc - Demen
#CS
Global Const $g_aaiTopLeftDropPoints[5][2] = [[62, 306], [156, 238], [221, 188], [288, 142], [383, 76]]
Global Const $g_aaiTopRightDropPoints[5][2] = [[486, 59], [586, 134], [652, 184], [720, 231], [817, 308]]
Global Const $g_aaiBottomLeftDropPoints[5][2] = [[20, 373], [101, 430], [171, 481], [244, 535], [346, 615]]
Global Const $g_aaiBottomRightDropPoints[5][2] = [[530, 615], [632, 535], [704, 481], [781, 430], [848, 373]]
Global Const $g_aaiEdgeDropPoints[4] = [$g_aaiBottomRightDropPoints, $g_aaiTopLeftDropPoints, $g_aaiBottomLeftDropPoints, $g_aaiTopRightDropPoints]
#CE - Fix in 7.2.4 Original

; SwitchAcc_Demen_Style
Global $profile = $g_sProfilePath & "\Profile.ini"
Global $ichkSwitchAcc = 0, $ichkSwitchAccShared_pref = 0, $icmbTotalCoCAcc, $nTotalCoCAcc = 8, $ichkSmartSwitch, $ichkCloseTraining
Global Enum $eNull, $eActive, $eDonate, $eIdle, $eStay, $eContinuous ; Enum for Profile Type & Switch Case & ForceSwitch
Global $ichkForceSwitch, $iForceSwitch, $eForceSwitch = 0, $iProfileBeforeForceSwitch
Global $ichkForceStayDonate
Global $nTotalProfile = 1, $nCurProfile = 1, $nNextProfile
Global $ProfileList
Global $aProfileType[8] ; Type of the all Profiles, 1 = active, 2 = donate, 3 = idle
Global $aMatchProfileAcc[8] ; Accounts match with All Profiles
Global $aDonateProfile, $aActiveProfile
Global $aAttackedCountSwitch[8], $ActiveSwitchCounter = 0, $DonateSwitchCounter = 0
Global $bReMatchAcc = False
Global $aTimerStart[8], $aTimerEnd[8]
Global $aRemainTrainTime[8], $aUpdateRemainTrainTime[8], $nMinRemainTrain
Global $aLocateAccConfig[8], $aAccPosY[8]
=======
; SwitchAcc - Demen_SA_#9001
Global $g_bChkSwitchAcc, $g_bChkSmartSwitch, $g_bReMatchAcc
Global $g_iTotalAcc, $g_iNextAccount, $g_iCurAccount
>>>>>>> 73f3ae0... New SwitchAcc
Global $g_iTrainTimeToSkip = 0
Global $g_abAccountNo[8], $g_aiProfileNo[8], $g_abDonateOnly[8]
Global $g_aiAttackedCountSwitch[8], $g_iActiveSwitchCounter = 0, $g_iDonateSwitchCounter = 0
Global $g_aiRemainTrainTime[8], $g_aiTimerStart[8]
Global $g_oTxtSALogInitText = ObjCreate("Scripting.Dictionary")
Global $g_hSwitchLogFile = 0
Global $g_aiGoldTotalAcc[8], $g_aiElixirTotalAcc[8], $g_aiDarkTotalAcc[8], $g_aiTrophyLootAcc[8], $g_aiAttackedCountAcc[8], $g_aiSkippedVillageCountAcc[8] ; Total Gain
Global $g_aiGoldCurrentAcc[8], $g_aiElixirCurrentAcc[8], $g_aiDarkCurrentAcc[8], $g_aiTrophyCurrentAcc[8], $g_aiGemAmountAcc[8], $g_aiFreeBuilderCountAcc[8], $g_aiTotalBuilderCountAcc[8] ; village report

; SmartTrain - Demen_ST_#9002
Global $ichkSmartTrain, $ichkPreciseTroops, $ichkFillArcher, $iFillArcher, $ichkFillEQ
Global $g_bWaitForCCTroopSpell = False	; ForceSwitch while waiting for CC troops - Demen
Global Enum $g_eFull, $g_eRemained, $g_eNoTrain
Global $g_abRCheckWrongTroops[2] = [False, False] ; Result of checking wrong troops & spells
Global $g_aiQueueTroops[$eTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_aiQueueSpells[$eSpellCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

; ExtendedAttackBar - Demen_S11_#9003
Global $g_hChkExtendedAttackBarLB, $g_hChkExtendedAttackBarDB, $g_abChkExtendedAttackBar[2]
Global $g_iTotalAttackSlot = 10, $g_bDraggedAttackBar = False ; flag if AttackBar is dragged or not

; CheckCC Troops - Demen_CC_#9004
Global $g_aiCCTroops[$eTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_aiCCTroopsExpected[$eTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
<<<<<<< HEAD
Global $g_bChkCC, $g_bChkCCTroops, $g_aiCmbCCTroopsExpect[3], $g_aiQtyCCTroopsExpect[3]
Global $g_iCmbCastleCap
=======
Global $g_aiCCSpellsExpected[$eSpellCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_bChkCC, $g_bChkCCTroops
Global $g_aiCmbCCSlot[5], $g_aiTxtCCSlot[5]
Global $g_iCmbCastleCapacityT, $g_iCmbCastleCapacityS

; Hero & Lab Status - Demen_HL_#9005
Global $g_bNeedLocateLab = True, $g_bLabReady[9]
Global $g_aLabTimeAcc[8], $g_aLabTime[4] = [0, 0, 0, 0] ; day | hour | minute | time in minutes
Global $g_aLabTimerStart[8], $g_aLabTimerEnd[8]

; QuickTrainCombo (Checkbox) - Demen_QT_#9006
Global $g_bQuickTrainArmy[3] = [True, False, False]
Global $g_bChkMultiClick, $g_iMultiClick = 1

; Classic FourFinger - Demen_FF_#9007
; Enable/Disable GUI - Demen_EG_#9008

>>>>>>> 73f3ae0... New SwitchAcc
