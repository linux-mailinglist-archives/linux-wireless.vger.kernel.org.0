Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC72173198C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 15:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbjFONFi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 09:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbjFONFg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 09:05:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A4E269A
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 06:05:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35FD57arC032339, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35FD57arC032339
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 15 Jun 2023 21:05:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 15 Jun 2023 21:05:26 +0800
Received: from [127.0.1.1] (172.16.16.227) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 15 Jun
 2023 21:05:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: 8851b: rfk: update IQK to version 0x8
Date:   Thu, 15 Jun 2023 21:04:41 +0800
Message-ID: <20230615130442.18116-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615130442.18116-1-pkshih@realtek.com>
References: <20230615130442.18116-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.227]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The main change is to adjust RX calibration groups from {0,1,2,3} to {0,2}
in 5 GHz, so reduce elements from 4 to 2, and use index to iterate them.
Meanwhile, always do RX narrowband calibration (ID_NBRXK) for each group.
NCTL is used to assist IQK, so also update NCTL to 0x6 along with internal
tag HALRF_029_00_103.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 115 ++++++++++--------
 .../wireless/realtek/rtw89/rtw8851b_table.c   |   2 +-
 2 files changed, 63 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 25dda3ee27a6a..a221f94627f5b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -17,6 +17,7 @@
 #define DPK_RF_REG_NUM_8851B 4
 #define DPK_KSET_NUM 4
 #define RTW8851B_RXK_GROUP_NR 4
+#define RTW8851B_RXK_GROUP_IDX_NR 2
 #define RTW8851B_TXK_GROUP_NR 1
 #define RTW8851B_IQK_VER 0x2a
 #define RTW8851B_IQK_SS 1
@@ -95,9 +96,9 @@ static const u32 _tssi_de_mcs_10m[RF_PATH_NUM_8851B] = {0x5830};
 static const u32 g_idxrxgain[RTW8851B_RXK_GROUP_NR] = {0x10e, 0x116, 0x28e, 0x296};
 static const u32 g_idxattc2[RTW8851B_RXK_GROUP_NR] = {0x0, 0xf, 0x0, 0xf};
 static const u32 g_idxrxagc[RTW8851B_RXK_GROUP_NR] = {0x0, 0x1, 0x2, 0x3};
-static const u32 a_idxrxgain[RTW8851B_RXK_GROUP_NR] = {0x10C, 0x112, 0x28c, 0x292};
-static const u32 a_idxattc2[RTW8851B_RXK_GROUP_NR] = {0xf, 0xf, 0xf, 0xf};
-static const u32 a_idxrxagc[RTW8851B_RXK_GROUP_NR] = {0x4, 0x5, 0x6, 0x7};
+static const u32 a_idxrxgain[RTW8851B_RXK_GROUP_IDX_NR] = {0x10C, 0x28c};
+static const u32 a_idxattc2[RTW8851B_RXK_GROUP_IDX_NR] = {0xf, 0xf};
+static const u32 a_idxrxagc[RTW8851B_RXK_GROUP_IDX_NR] = {0x4, 0x6};
 static const u32 a_power_range[RTW8851B_TXK_GROUP_NR] = {0x0};
 static const u32 a_track_range[RTW8851B_TXK_GROUP_NR] = {0x6};
 static const u32 a_gain_bb[RTW8851B_TXK_GROUP_NR] = {0x0a};
@@ -107,7 +108,7 @@ static const u32 g_track_range[RTW8851B_TXK_GROUP_NR] = {0x6};
 static const u32 g_gain_bb[RTW8851B_TXK_GROUP_NR] = {0x10};
 static const u32 g_itqt[RTW8851B_TXK_GROUP_NR] = {0x12};
 
-static const u32 rtw8851b_backup_bb_regs[] = {0xc0ec, 0xc0e8};
+static const u32 rtw8851b_backup_bb_regs[] = {0xc0d4, 0xc0d8, 0xc0c4, 0xc0ec, 0xc0e8};
 static const u32 rtw8851b_backup_rf_regs[] = {
 	0xef, 0xde, 0x0, 0x1e, 0x2, 0x85, 0x90, 0x5};
 
@@ -120,6 +121,17 @@ static const u32 dpk_rf_reg[DPK_RF_REG_NUM_8851B] = {0xde, 0x8f, 0x5, 0x10005};
 
 static void _set_ch(struct rtw89_dev *rtwdev, u32 val);
 
+static u8 _rxk_5ghz_group_from_idx(u8 idx)
+{
+	/* There are four RXK groups (RTW8851B_RXK_GROUP_NR), but only group 0
+	 * and 2 are used in 5 GHz band, so reduce elements to 2.
+	 */
+	if (idx < RTW8851B_RXK_GROUP_IDX_NR)
+		return idx * 2;
+
+	return 0;
+}
+
 static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	return RF_A;
@@ -786,17 +798,11 @@ static bool _rxk_2g_group_sel(struct rtw89_dev *rtwdev,
 			    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD),
 			    rtw89_read_rf(rtwdev, path, RR_MOD, 0x003e0));
 
-		if (gp == 0x3) {
-			rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
-			rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
-			notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
-			iqk_info->nb_rxcfir[path] =
-				rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD) | 0x2;
-
-			rtw89_debug(rtwdev, RTW89_DBG_RFK,
-				    "[IQK]S%x, NBRXK 0x8008 = 0x%x\n", path,
-				    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
-		}
+		rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
+		iqk_info->nb_rxcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD) | 0x2;
 
 		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXK);
 
@@ -834,15 +840,18 @@ static bool _rxk_5g_group_sel(struct rtw89_dev *rtwdev,
 	bool kfail = false;
 	bool notready;
 	u32 rf_0;
+	u8 idx;
 	u8 gp;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
 
-	for (gp = 0; gp < RTW8851B_RXK_GROUP_NR; gp++) {
+	for (idx = 0; idx < RTW8851B_RXK_GROUP_IDX_NR; idx++) {
+		gp = _rxk_5ghz_group_from_idx(idx);
+
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, gp = %x\n", path, gp);
 
-		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, 0x03ff0, a_idxrxgain[gp]);
-		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[gp]);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_RGM, a_idxrxgain[idx]);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[idx]);
 
 		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x0);
@@ -852,7 +861,7 @@ static bool _rxk_5g_group_sel(struct rtw89_dev *rtwdev,
 		fsleep(100);
 		rf_0 = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
 		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF2, B_IQK_DIF2_RXPI, rf_0);
-		rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[gp]);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[idx]);
 		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
 		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXAGC);
 
@@ -861,17 +870,15 @@ static bool _rxk_5g_group_sel(struct rtw89_dev *rtwdev,
 			    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD),
 			    rtw89_read_rf(rtwdev, path, RR_MOD, RR_MOD_RXB));
 
-		if (gp == 0x3) {
-			rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
-			rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
-			notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
-			iqk_info->nb_rxcfir[path] =
-				rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD) | 0x2;
+		rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
+		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
+		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
+		iqk_info->nb_rxcfir[path] =
+			rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD) | 0x2;
 
-			rtw89_debug(rtwdev, RTW89_DBG_RFK,
-				    "[IQK]S%x, NBRXK 0x8008 = 0x%x\n", path,
-				    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
-		}
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[IQK]S%x, NBRXK 0x8008 = 0x%x\n", path,
+			    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
 
 		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXK);
 
@@ -908,14 +915,17 @@ static bool _iqk_5g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	bool kfail = false;
 	bool notready;
-	u8 gp = 0x3;
+	u8 idx = 0x1;
 	u32 rf_0;
+	u8 gp;
+
+	gp = _rxk_5ghz_group_from_idx(idx);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, gp = %x\n", path, gp);
 
-	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_RGM, a_idxrxgain[gp]);
-	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[gp]);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_RGM, a_idxrxgain[idx]);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RXA2, RR_RXA2_ATT, a_idxattc2[idx]);
 
 	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_SEL, 0x1);
 	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT, B_CFIR_LUT_G3, 0x0);
@@ -925,7 +935,7 @@ static bool _iqk_5g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	fsleep(100);
 	rf_0 = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
 	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF2, B_IQK_DIF2_RXPI, rf_0);
-	rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[gp]);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_RXA, B_IQK_RXAGC, a_idxrxagc[idx]);
 	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
 	notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXAGC);
 
@@ -934,17 +944,15 @@ static bool _iqk_5g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 		    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD),
 		    rtw89_read_rf(rtwdev, path, RR_MOD, 0x003e0));
 
-	if (gp == 0x3) {
-		rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
-		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
-		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
-		iqk_info->nb_rxcfir[path] =
-			rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD) | 0x2;
+	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
+	notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
+	iqk_info->nb_rxcfir[path] =
+		rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD) | 0x2;
 
-		rtw89_debug(rtwdev, RTW89_DBG_RFK,
-			    "[IQK]S%x, NBRXK 0x8008 = 0x%x\n", path,
-			    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
-	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, NBRXK 0x8008 = 0x%x\n", path,
+		    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, WBRXK 0x8008 = 0x%x\n",
 		    path, rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
@@ -998,17 +1006,15 @@ static bool _iqk_2g_nbrxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 		    path, rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD),
 		    rtw89_read_rf(rtwdev, path, RR_MOD, 0x003e0));
 
-	if (gp == 0x3) {
-		rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
-		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
-		notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
-		iqk_info->nb_rxcfir[path] =
-			rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD) | 0x2;
+	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_OFF, 0x13);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x011);
+	notready = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
+	iqk_info->nb_rxcfir[path] =
+		rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD) | 0x2;
 
-		rtw89_debug(rtwdev, RTW89_DBG_RFK,
-			    "[IQK]S%x, NBRXK 0x8008 = 0x%x\n", path,
-			    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
-	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[IQK]S%x, NBRXK 0x8008 = 0x%x\n", path,
+		    rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%x, WBRXK 0x8008 = 0x%x\n",
 		    path, rtw89_phy_read32_mask(rtwdev, R_NCTL_RPT, MASKDWORD));
@@ -1516,6 +1522,9 @@ static void _iqk_restore(struct rtw89_dev *rtwdev, u8 path)
 	fail = _iqk_check_cal(rtwdev, path);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] restore fail=%d\n", fail);
 
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RR_LUTWE_LOK, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTDBG, RR_LUTDBG_TIA, 0x0);
+
 	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP, 0x00);
 	rtw89_phy_write32_mask(rtwdev, R_NCTL_RPT, MASKDWORD, 0x00000000);
 	rtw89_phy_write32_mask(rtwdev, R_KIP_SYSCFG, MASKDWORD, 0x80000000);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
index bda68dbc8b7b4..828beb0e5f7e6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
@@ -2322,7 +2322,7 @@ static const struct rtw89_reg2_def rtw89_8851b_phy_nctl_regs[] = {
 	{0x8144, 0x0b040b03},
 	{0x8148, 0x07020b04},
 	{0x814c, 0x07020b04},
-	{0x8150, 0xe4e40000},
+	{0x8150, 0xa0a00000},
 	{0x8158, 0xffffffff},
 	{0x815c, 0xffffffff},
 	{0x8160, 0xffffffff},
-- 
2.25.1

