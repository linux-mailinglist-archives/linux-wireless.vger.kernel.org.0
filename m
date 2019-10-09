Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD0D0EC7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 14:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfJIMc3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 08:32:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfJIMc3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 08:32:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0709718C4285;
        Wed,  9 Oct 2019 12:32:29 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-32.ams2.redhat.com [10.36.117.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D1CA1001E91;
        Wed,  9 Oct 2019 12:32:25 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Denis Efremov <efremov@linux.com>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 1/5] staging: rtl8723bs: Remove phy_Config*With*ParaFile() calls
Date:   Wed,  9 Oct 2019 14:32:19 +0200
Message-Id: <20191009123223.163241-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Wed, 09 Oct 2019 12:32:29 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The rtl8723bs driver tries to load various parameters from disk,
circumventing the standard firmware loader mechanism and using DIY
code for this.

No devices which run the mainline kernel ship with these files and even
if these files were present then they still would not be loaded without
additional module parameters. To be precise the following 3 conditions
must all 3 be true for on disk parameters to be used:

1) The rtw_load_phy_file modparam must contain the mask for the type, this
   defaults to(LOAD_BB_PG_PARA_FILE | LOAD_RF_TXPWR_LMT_PARA_FILE) so with
   the default settings this condition is only true for:
   phy_ConfigBBWithPgParaFile()
   PHY_ConfigRFWithPowerLimitTableParaFile(); and
2) rtw_phy_file_path modparam must be set to say "/lib/firmware/"; and
3) Store a /lib/firmware/rtl8723b/XXX file in the expected format.

In practice all 3 being true never happens, so the
phy_Config*With*ParaFile() calls are nops, remove them.

The actual code implementing them will be removed in a separate patch.

Note the ODM_ConfigRFWithHeaderFile() and ODM_ConfigBBWithHeaderFile()
functions always return HAL_STATUS_SUCCESS, this patch makes use of this
to simplify the new code without the phy_Config*With*ParaFile() calls.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 77 +++----------------
 .../staging/rtl8723bs/hal/rtl8723b_rf6052.c   | 41 +---------
 2 files changed, 13 insertions(+), 105 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 6df2b58bdc67..cf23414d7224 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -362,24 +362,10 @@ void PHY_SetRFReg_8723B(
  */
 s32 PHY_MACConfig8723B(struct adapter *Adapter)
 {
-	int rtStatus = _SUCCESS;
 	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
-	s8 *pszMACRegFile;
-	s8 sz8723MACRegFile[] = RTL8723B_PHY_MACREG;
-
-
-	pszMACRegFile = sz8723MACRegFile;
-
-	/*  */
-	/*  Config MAC */
-	/*  */
-	rtStatus = phy_ConfigMACWithParaFile(Adapter, pszMACRegFile);
-	if (rtStatus == _FAIL) {
-		ODM_ReadAndConfig_MP_8723B_MAC_REG(&pHalData->odmpriv);
-		rtStatus = _SUCCESS;
-	}
 
-	return rtStatus;
+	ODM_ReadAndConfig_MP_8723B_MAC_REG(&pHalData->odmpriv);
+	return _SUCCESS;
 }
 
 /**
@@ -427,17 +413,6 @@ static void phy_InitBBRFRegisterDefinition(struct adapter *Adapter)
 static int phy_BB8723b_Config_ParaFile(struct adapter *Adapter)
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
-	int rtStatus = _SUCCESS;
-	u8 sz8723BBRegFile[] = RTL8723B_PHY_REG;
-	u8 sz8723AGCTableFile[] = RTL8723B_AGC_TAB;
-	u8 sz8723BBBRegPgFile[] = RTL8723B_PHY_REG_PG;
-	u8 sz8723BRFTxPwrLmtFile[] = RTL8723B_TXPWR_LMT;
-	u8 *pszBBRegFile = NULL, *pszAGCTableFile = NULL, *pszBBRegPgFile = NULL, *pszRFTxPwrLmtFile = NULL;
-
-	pszBBRegFile = sz8723BBRegFile;
-	pszAGCTableFile = sz8723AGCTableFile;
-	pszBBRegPgFile = sz8723BBBRegPgFile;
-	pszRFTxPwrLmtFile = sz8723BRFTxPwrLmtFile;
 
 	/*  Read Tx Power Limit File */
 	PHY_InitTxPowerLimit(Adapter);
@@ -445,30 +420,14 @@ static int phy_BB8723b_Config_ParaFile(struct adapter *Adapter)
 		Adapter->registrypriv.RegEnableTxPowerLimit == 1 ||
 		(Adapter->registrypriv.RegEnableTxPowerLimit == 2 && pHalData->EEPROMRegulatory == 1)
 	) {
-		if (PHY_ConfigRFWithPowerLimitTableParaFile(Adapter, pszRFTxPwrLmtFile) == _FAIL) {
-			if (HAL_STATUS_SUCCESS != ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv, CONFIG_RF_TXPWR_LMT, (ODM_RF_RADIO_PATH_E)0))
-				rtStatus = _FAIL;
-		}
-
-		if (rtStatus != _SUCCESS) {
-			DBG_871X("%s():Read Tx power limit fail\n", __func__);
-			goto phy_BB8190_Config_ParaFile_Fail;
-		}
+		ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv,
+					   CONFIG_RF_TXPWR_LMT, 0);
 	}
 
 	/*  */
 	/*  1. Read PHY_REG.TXT BB INIT!! */
 	/*  */
-	if (phy_ConfigBBWithParaFile(Adapter, pszBBRegFile, CONFIG_BB_PHY_REG) ==
-		_FAIL) {
-		if (HAL_STATUS_SUCCESS != ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv, CONFIG_BB_PHY_REG))
-			rtStatus = _FAIL;
-	}
-
-	if (rtStatus != _SUCCESS) {
-		DBG_8192C("%s():Write BB Reg Fail!!", __func__);
-		goto phy_BB8190_Config_ParaFile_Fail;
-	}
+	ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv, CONFIG_BB_PHY_REG);
 
 	/*  If EEPROM or EFUSE autoload OK, We must config by PHY_REG_PG.txt */
 	PHY_InitTxPowerByRate(Adapter);
@@ -476,11 +435,8 @@ static int phy_BB8723b_Config_ParaFile(struct adapter *Adapter)
 		Adapter->registrypriv.RegEnableTxPowerByRate == 1 ||
 		(Adapter->registrypriv.RegEnableTxPowerByRate == 2 && pHalData->EEPROMRegulatory != 2)
 	) {
-		if (phy_ConfigBBWithPgParaFile(Adapter, pszBBRegPgFile) ==
-			_FAIL) {
-			if (HAL_STATUS_SUCCESS != ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv, CONFIG_BB_PHY_REG_PG))
-				rtStatus = _FAIL;
-		}
+		ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv,
+					   CONFIG_BB_PHY_REG_PG);
 
 		if (pHalData->odmpriv.PhyRegPgValueType == PHY_REG_PG_EXACT_VALUE)
 			PHY_TxPowerByRateConfiguration(Adapter);
@@ -490,29 +446,14 @@ static int phy_BB8723b_Config_ParaFile(struct adapter *Adapter)
 			(Adapter->registrypriv.RegEnableTxPowerLimit == 2 && pHalData->EEPROMRegulatory == 1)
 		)
 			PHY_ConvertTxPowerLimitToPowerIndex(Adapter);
-
-		if (rtStatus != _SUCCESS) {
-			DBG_8192C("%s():BB_PG Reg Fail!!\n", __func__);
-		}
 	}
 
 	/*  */
 	/*  2. Read BB AGC table Initialization */
 	/*  */
-	if (phy_ConfigBBWithParaFile(Adapter, pszAGCTableFile,
-				     CONFIG_BB_AGC_TAB) == _FAIL) {
-		if (HAL_STATUS_SUCCESS != ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv, CONFIG_BB_AGC_TAB))
-			rtStatus = _FAIL;
-	}
-
-	if (rtStatus != _SUCCESS) {
-		DBG_8192C("%s():AGC Table Fail\n", __func__);
-		goto phy_BB8190_Config_ParaFile_Fail;
-	}
-
-phy_BB8190_Config_ParaFile_Fail:
+	ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv, CONFIG_BB_AGC_TAB);
 
-	return rtStatus;
+	return _SUCCESS;
 }
 
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
index d0ffe0af5339..aafceaf9b139 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
@@ -85,19 +85,8 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 	u32 u4RegValue = 0;
 	u8 eRFPath;
 	struct bb_register_def *pPhyReg;
-
-	int rtStatus = _SUCCESS;
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	static char sz8723RadioAFile[] = RTL8723B_PHY_RADIO_A;
-	static char sz8723RadioBFile[] = RTL8723B_PHY_RADIO_B;
-	static s8 sz8723BTxPwrTrackFile[] = RTL8723B_TXPWR_TRACK;
-	char *pszRadioAFile, *pszRadioBFile, *pszTxPwrTrackFile;
-
-	pszRadioAFile = sz8723RadioAFile;
-	pszRadioBFile = sz8723RadioBFile;
-	pszTxPwrTrackFile = sz8723BTxPwrTrackFile;
-
 	/* 3----------------------------------------------------------------- */
 	/* 3 <2> Initialize RF */
 	/* 3----------------------------------------------------------------- */
@@ -136,21 +125,11 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 		/*----Initialize RF fom connfiguration file----*/
 		switch (eRFPath) {
 		case RF_PATH_A:
-			if (PHY_ConfigRFWithParaFile(Adapter, pszRadioAFile,
-						     eRFPath) == _FAIL) {
-				if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv, CONFIG_RF_RADIO, (ODM_RF_RADIO_PATH_E)eRFPath))
-					rtStatus = _FAIL;
-			}
-			break;
 		case RF_PATH_B:
-			if (PHY_ConfigRFWithParaFile(Adapter, pszRadioBFile,
-						     eRFPath) == _FAIL) {
-				if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv, CONFIG_RF_RADIO, (ODM_RF_RADIO_PATH_E)eRFPath))
-					rtStatus = _FAIL;
-			}
+			ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv,
+						   CONFIG_RF_RADIO, eRFPath);
 			break;
 		case RF_PATH_C:
-			break;
 		case RF_PATH_D:
 			break;
 		}
@@ -166,28 +145,16 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 			PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV << 16, u4RegValue);
 			break;
 		}
-
-		if (rtStatus != _SUCCESS) {
-			/* RT_TRACE(COMP_FPGA, DBG_LOUD, ("phy_RF6052_Config_ParaFile():Radio[%d] Fail!!", eRFPath)); */
-			goto phy_RF6052_Config_ParaFile_Fail;
-		}
-
 	}
 
 	/* 3 ----------------------------------------------------------------- */
 	/* 3 Configuration of Tx Power Tracking */
 	/* 3 ----------------------------------------------------------------- */
 
-	if (PHY_ConfigRFWithTxPwrTrackParaFile(Adapter, pszTxPwrTrackFile) ==
-		_FAIL) {
-		ODM_ConfigRFWithTxPwrTrackHeaderFile(&pHalData->odmpriv);
-	}
+	ODM_ConfigRFWithTxPwrTrackHeaderFile(&pHalData->odmpriv);
 
 	/* RT_TRACE(COMP_INIT, DBG_LOUD, ("<---phy_RF6052_Config_ParaFile()\n")); */
-	return rtStatus;
-
-phy_RF6052_Config_ParaFile_Fail:
-	return rtStatus;
+	return _SUCCESS;
 }
 
 
-- 
2.23.0

