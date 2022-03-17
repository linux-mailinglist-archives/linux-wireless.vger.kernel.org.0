Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2B54DBF2A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 07:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiCQGSw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 02:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiCQGSD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 02:18:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2B72C69C6
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 22:56:47 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22H5ufMiB009694, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22H5ufMiB009694
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Mar 2022 13:56:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 17 Mar 2022 13:56:40 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 13:56:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH v2 03/12] rtw89: 8852c: add setting of TB UL TX power offset
Date:   Thu, 17 Mar 2022 13:55:34 +0800
Message-ID: <20220317055543.40514-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317055543.40514-1-pkshih@realtek.com>
References: <20220317055543.40514-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/17/2022 05:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTcgpFekyCAwMzoyNjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yuan-Han Zhang <yuanhan1020@realtek.com>

Configure this TX power to indicate TX power offset that uses to transmit
TB (trigger base) uplink frames.
Also, shrink the unit of TX power offset changes to suitable type s8.

Signed-off-by: Yuan-Han Zhang <yuanhan1020@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  8 ++---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 36 +++++++++++++++++++
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 51c99e50b0ed9..af73347c40b16 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2065,7 +2065,7 @@ struct rtw89_chip_ops {
 			   struct ieee80211_rx_status *status);
 	void (*bb_ctrl_btc_preagc)(struct rtw89_dev *rtwdev, bool bt_en);
 	void (*set_txpwr_ul_tb_offset)(struct rtw89_dev *rtwdev,
-				       s16 pw_ofst, enum rtw89_mac_idx mac_idx);
+				       s8 pw_ofst, enum rtw89_mac_idx mac_idx);
 	int (*pwr_on_func)(struct rtw89_dev *rtwdev);
 	int (*pwr_off_func)(struct rtw89_dev *rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index a239bf017ac76..09bf3afd6d9f5 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1525,8 +1525,10 @@
 #define B_AX_PWR_UL_TB_CTRL_EN BIT(31)
 #define R_AX_PWR_UL_TB_1T 0xD28C
 #define B_AX_PWR_UL_TB_1T_MASK GENMASK(4, 0)
+#define B_AX_PWR_UL_TB_1T_V1_MASK GENMASK(7, 0)
 #define R_AX_PWR_UL_TB_2T 0xD290
 #define B_AX_PWR_UL_TB_2T_MASK GENMASK(4, 0)
+#define B_AX_PWR_UL_TB_2T_V1_MASK GENMASK(7, 0)
 #define R_AX_PWR_BY_RATE_TABLE0 0xD2C0
 #define R_AX_PWR_BY_RATE_TABLE10 0xD2E8
 #define R_AX_PWR_BY_RATE R_AX_PWR_BY_RATE_TABLE0
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 392f6e6e0a132..c6986c6498138 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1275,10 +1275,10 @@ static u32 rtw8852a_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
 
 static
 void rtw8852a_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
-				     s16 pw_ofst, enum rtw89_mac_idx mac_idx)
+				     s8 pw_ofst, enum rtw89_mac_idx mac_idx)
 {
-	s32 val_1t = 0;
-	s32 val_2t = 0;
+	s8 val_1t = 0;
+	s8 val_2t = 0;
 	u32 reg;
 
 	if (pw_ofst < -16 || pw_ofst > 15) {
@@ -1288,7 +1288,7 @@ void rtw8852a_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 	}
 	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_CTRL, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_AX_PWR_UL_TB_CTRL_EN);
-	val_1t = (s32)pw_ofst;
+	val_1t = pw_ofst;
 	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_1T, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_1T_MASK, val_1t);
 	val_2t = max(val_1t - 3, -16);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index f37acfe7679e1..c74dedea511a4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -445,10 +445,46 @@ static void rtw8852c_power_trim(struct rtw89_dev *rtwdev)
 	rtw8852c_pa_bias_trim(rtwdev);
 }
 
+static
+void rtw8852c_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
+				     s8 pw_ofst, enum rtw89_mac_idx mac_idx)
+{
+	s8 pw_ofst_2tx;
+	s8 val_1t;
+	s8 val_2t;
+	u32 reg;
+	u8 i;
+
+	if (pw_ofst < -32 || pw_ofst > 31) {
+		rtw89_warn(rtwdev, "[ULTB] Err pwr_offset=%d\n", pw_ofst);
+		return;
+	}
+	val_1t = pw_ofst << 2;
+	pw_ofst_2tx = max(pw_ofst - 3, -32);
+	val_2t = pw_ofst_2tx << 2;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[ULTB] val_1tx=0x%x\n", val_1t);
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[ULTB] val_2tx=0x%x\n", val_2t);
+
+	for (i = 0; i < 4; i++) {
+		/* 1TX */
+		reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_1T, mac_idx);
+		rtw89_write32_mask(rtwdev, reg,
+				   B_AX_PWR_UL_TB_1T_V1_MASK << (8 * i),
+				   val_1t);
+		/* 2TX */
+		reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_2T, mac_idx);
+		rtw89_write32_mask(rtwdev, reg,
+				   B_AX_PWR_UL_TB_2T_V1_MASK << (8 * i),
+				   val_2t);
+	}
+}
+
 static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.read_efuse		= rtw8852c_read_efuse,
 	.read_phycap		= rtw8852c_read_phycap,
 	.power_trim		= rtw8852c_power_trim,
+	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8852c_pwr_on_func,
 	.pwr_off_func		= rtw8852c_pwr_off_func,
 };
-- 
2.25.1

