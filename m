Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C88864E6EB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 06:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLPFa4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 00:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPFay (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 00:30:54 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB54D11C3B
        for <linux-wireless@vger.kernel.org>; Thu, 15 Dec 2022 21:30:51 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BG5TruP6024382, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BG5TruP6024382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 16 Dec 2022 13:29:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 16 Dec 2022 13:30:43 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 16 Dec
 2022 13:30:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] wifi: rtw89: 8852c: rfk: refine AGC tuning flow of DPK for irregular PA
Date:   Fri, 16 Dec 2022 13:29:39 +0800
Message-ID: <20221216052939.9991-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/16/2022 05:12:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzE2IKRXpMggMDE6Mjk6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

Some hardware modules don't have good RF characteristic as regular.
It could have RF PA characteristic that current code doesn't handle
properly, and it runs into wrong DPK flow that doesn't complete DPK
resulting in bad EVM.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: change subject title, because original is the same as previous patch.
---
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 38 +++++++++++++++----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index b0ea23d9f81fb..3c5fa3bb2a8f4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -26,7 +26,7 @@ static const u32 rtw8852c_backup_bb_regs[] = {
 };
 
 static const u32 rtw8852c_backup_rf_regs[] = {
-	0xdf, 0x8f, 0x97, 0xa3, 0x5, 0x10005
+	0xdf, 0x5f, 0x8f, 0x97, 0xa3, 0x5, 0x10005
 };
 
 #define BACKUP_BB_REGS_NR ARRAY_SIZE(rtw8852c_backup_bb_regs)
@@ -1757,7 +1757,7 @@ u8 _rx_dck_channel_calc(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan)
 }
 
 #define RTW8852C_RF_REL_VERSION 34
-#define RTW8852C_DPK_VER 0x10
+#define RTW8852C_DPK_VER 0xf
 #define RTW8852C_DPK_TH_AVG_NUM 4
 #define RTW8852C_DPK_RF_PATH 2
 #define RTW8852C_DPK_KIP_REG_NUM 5
@@ -1797,6 +1797,12 @@ enum dpk_agc_step {
 	DPK_AGC_STEP_SET_TX_GAIN,
 };
 
+enum dpk_pas_result {
+	DPK_PAS_NOR,
+	DPK_PAS_GT,
+	DPK_PAS_LT,
+};
+
 static void _rf_direct_cntrl(struct rtw89_dev *rtwdev,
 			     enum rtw89_rf_path path, bool is_bybb)
 {
@@ -2206,9 +2212,10 @@ static u8 _dpk_gainloss(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	return _dpk_gainloss_read(rtwdev);
 }
 
-static bool _dpk_pas_read(struct rtw89_dev *rtwdev, bool is_check)
+static enum dpk_pas_result _dpk_pas_read(struct rtw89_dev *rtwdev, bool is_check)
 {
 	u32 val1_i = 0, val1_q = 0, val2_i = 0, val2_q = 0;
+	u32 val1_sqrt_sum, val2_sqrt_sum;
 	u8 i;
 
 	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, MASKBYTE2, 0x06);
@@ -2239,15 +2246,25 @@ static bool _dpk_pas_read(struct rtw89_dev *rtwdev, bool is_check)
 		}
 	}
 
-	if (val1_i * val1_i + val1_q * val1_q >= (val2_i * val2_i + val2_q * val2_q) * 8 / 5)
-		return true;
+	val1_sqrt_sum = val1_i * val1_i + val1_q * val1_q;
+	val2_sqrt_sum = val2_i * val2_i + val2_q * val2_q;
+
+	if (val1_sqrt_sum < val2_sqrt_sum)
+		return DPK_PAS_LT;
+	else if (val1_sqrt_sum >= val2_sqrt_sum * 8 / 5)
+		return DPK_PAS_GT;
 	else
-		return false;
+		return DPK_PAS_NOR;
 }
 
 static bool _dpk_kip_set_rxagc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			       enum rtw89_rf_path path, u8 kidx)
 {
+	_dpk_kip_control_rfc(rtwdev, path, false);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_MOD, B_KIP_MOD,
+			       rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK));
+	_dpk_kip_control_rfc(rtwdev, path, true);
+
 	_dpk_one_shot(rtwdev, phy, path, D_RXAGC);
 
 	return _dpk_sync_check(rtwdev, path, kidx);
@@ -2285,6 +2302,7 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u8 tmp_dbm = init_xdbm, tmp_gl_idx = 0;
 	u8 tmp_rxbb;
 	u8 goout = 0, agc_cnt = 0;
+	enum dpk_pas_result pas;
 	u16 dgain = 0;
 	bool is_fail = false;
 	int limit = 200;
@@ -2320,9 +2338,13 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 
 		case DPK_AGC_STEP_GAIN_LOSS_IDX:
 			tmp_gl_idx = _dpk_gainloss(rtwdev, phy, path, kidx);
+			pas = _dpk_pas_read(rtwdev, true);
 
-			if ((tmp_gl_idx == 0 && _dpk_pas_read(rtwdev, true)) ||
-			    tmp_gl_idx >= 7)
+			if (pas == DPK_PAS_LT && tmp_gl_idx > 0)
+				step = DPK_AGC_STEP_GL_LT_CRITERION;
+			else if (pas == DPK_PAS_GT && tmp_gl_idx == 0)
+				step = DPK_AGC_STEP_GL_GT_CRITERION;
+			else if (tmp_gl_idx >= 7)
 				step = DPK_AGC_STEP_GL_GT_CRITERION;
 			else if (tmp_gl_idx == 0)
 				step = DPK_AGC_STEP_GL_LT_CRITERION;
-- 
2.25.1

