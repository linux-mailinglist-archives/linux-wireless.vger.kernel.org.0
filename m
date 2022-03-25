Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404AC4E6E0E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358420AbiCYGEE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358417AbiCYGEB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:04:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F397C6821
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P62Jv24011178, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P62Jv24011178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 14:02:19 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 16/16] rtw89: update ptcl_init
Date:   Fri, 25 Mar 2022 14:00:55 +0800
Message-ID: <20220325060055.58482-17-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325060055.58482-1-pkshih@realtek.com>
References: <20220325060055.58482-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/25/2022 05:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjUgpFekyCAwNDo0ODowMA==?=
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

ptcl_init, standing for protocol initialization, is updated to the latest
version.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 20 +++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/reg.h | 24 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 1103b261b9ab4..a0ba7bb6fbc13 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2141,6 +2141,8 @@ static int ptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 		val = rtw89_read32(rtwdev, reg);
 		val = u32_replace_bits(val, S_AX_CTS2S_TH_1K,
 				       B_AX_HW_CTS2SELF_PKT_LEN_TH_MASK);
+		val = u32_replace_bits(val, S_AX_CTS2S_TH_SEC_256B,
+				       B_AX_HW_CTS2SELF_PKT_LEN_TH_TWW_MASK);
 		val |= B_AX_HW_CTS2SELF_EN;
 		rtw89_write32(rtwdev, reg, val);
 
@@ -2151,11 +2153,19 @@ static int ptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 		rtw89_write32(rtwdev, reg, val);
 	}
 
-	reg = rtw89_mac_reg_by_idx(R_AX_SIFS_SETTING, mac_idx);
-	val = rtw89_read32(rtwdev, reg);
-	val = u32_replace_bits(val, S_AX_CTS2S_TH_SEC_256B, B_AX_HW_CTS2SELF_PKT_LEN_TH_TWW_MASK);
-	val |= B_AX_HW_CTS2SELF_EN;
-	rtw89_write32(rtwdev, reg, val);
+	if (mac_idx == RTW89_MAC_0) {
+		rtw89_write8_set(rtwdev, R_AX_PTCL_COMMON_SETTING_0,
+				 B_AX_CMAC_TX_MODE_0 | B_AX_CMAC_TX_MODE_1);
+		rtw89_write8_clr(rtwdev, R_AX_PTCL_COMMON_SETTING_0,
+				 B_AX_PTCL_TRIGGER_SS_EN_0 |
+				 B_AX_PTCL_TRIGGER_SS_EN_1 |
+				 B_AX_PTCL_TRIGGER_SS_EN_UL);
+		rtw89_write8_mask(rtwdev, R_AX_PTCLRPT_FULL_HDL,
+				  B_AX_SPE_RPT_PATH_MASK, FWD_TO_WLCPU);
+	} else if (mac_idx == RTW89_MAC_1) {
+		rtw89_write8_mask(rtwdev, R_AX_PTCLRPT_FULL_HDL_C1,
+				  B_AX_SPE_RPT_PATH_MASK, FWD_TO_WLCPU);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 3822cf0daef0a..a0c60528b5780 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1248,6 +1248,18 @@
 #define R_AX_PORT_HGQ_WINDOW_CFG 0xC5A0
 #define R_AX_PORT_HGQ_WINDOW_CFG_C1 0xE5A0
 
+#define R_AX_PTCL_COMMON_SETTING_0 0xC600
+#define R_AX_PTCL_COMMON_SETTING_0_C1 0xE600
+#define B_AX_PCIE_MODE_MASK GENMASK(15, 14)
+#define B_AX_CPUMGQ_LIFETIME_EN BIT(8)
+#define B_AX_MGQ_LIFETIME_EN BIT(7)
+#define B_AX_LIFETIME_EN BIT(6)
+#define B_AX_PTCL_TRIGGER_SS_EN_UL BIT(4)
+#define B_AX_PTCL_TRIGGER_SS_EN_1 BIT(3)
+#define B_AX_PTCL_TRIGGER_SS_EN_0 BIT(2)
+#define B_AX_CMAC_TX_MODE_1 BIT(1)
+#define B_AX_CMAC_TX_MODE_0 BIT(0)
+
 #define R_AX_AMPDU_AGG_LIMIT 0xC610
 #define B_AX_AMPDU_MAX_TIME_MASK GENMASK(31, 24)
 #define B_AX_RA_TRY_RATE_AGG_LMT_MASK GENMASK(23, 16)
@@ -1292,6 +1304,18 @@
 #define B_AX_PORT_DROP_4_0_MASK GENMASK(20, 16)
 #define B_AX_MBSSID_DROP_15_0_MASK GENMASK(15, 0)
 
+#define R_AX_PTCLRPT_FULL_HDL 0xC660
+#define R_AX_PTCLRPT_FULL_HDL_C1 0xE660
+#define B_AX_RPT_LATCH_PHY_TIME_MASK GENMASK(15, 12)
+#define B_AX_F2PCMD_FWWD_RLS_MODE BIT(9)
+#define B_AX_F2PCMD_RPT_EN BIT(8)
+#define B_AX_BCN_RPT_PATH_MASK GENMASK(7, 6)
+#define B_AX_SPE_RPT_PATH_MASK GENMASK(5, 4)
+#define FWD_TO_WLCPU 1
+#define B_AX_TX_RPT_PATH_MASK GENMASK(3, 2)
+#define B_AX_F2PCMDRPT_FULL_DROP BIT(1)
+#define B_AX_NON_F2PCMDRPT_FULL_DROP BIT(0)
+
 #define R_AX_BT_PLT 0xC67C
 #define R_AX_BT_PLT_C1 0xE67C
 #define B_AX_BT_PLT_PKT_CNT_MASK GENMASK(31, 16)
-- 
2.25.1

