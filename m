Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC37C5005EB
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 08:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbiDNGXw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 02:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbiDNGXl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 02:23:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC3B4A3D7
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 23:21:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23E6L9U40001390, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23E6L9U40001390
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Apr 2022 14:21:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 14:21:08 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 14 Apr
 2022 14:21:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 10/12] rtw89: 8852c: set channel of MAC part
Date:   Thu, 14 Apr 2022 14:20:24 +0800
Message-ID: <20220414062027.62638-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414062027.62638-1-pkshih@realtek.com>
References: <20220414062027.62638-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/14/2022 06:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMTQgpFekyCAwMzo1OTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

Configure channel and bandwidth of MAC registers to work properly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  4 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 71 +++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index d666c6e2a9dec..44a2d984ebe19 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1802,6 +1802,10 @@
 #define R_AX_WMAC_RFMOD 0xC010
 #define R_AX_WMAC_RFMOD_C1 0xE010
 #define B_AX_WMAC_RFMOD_MASK GENMASK(1, 0)
+#define AX_WMAC_RFMOD_20M 0
+#define AX_WMAC_RFMOD_40M 1
+#define AX_WMAC_RFMOD_80M 2
+#define AX_WMAC_RFMOD_160M 3
 
 #define R_AX_GID_POSITION0 0xC070
 #define R_AX_GID_POSITION0_C1 0xE070
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8be3cb22eb110..07ff3bd50f62b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -562,6 +562,77 @@ static void rtw8852c_power_trim(struct rtw89_dev *rtwdev)
 	rtw8852c_pa_bias_trim(rtwdev);
 }
 
+static void rtw8852c_set_channel_mac(struct rtw89_dev *rtwdev,
+				     struct rtw89_channel_params *param,
+				     u8 mac_idx)
+{
+	u32 rf_mod = rtw89_mac_reg_by_idx(R_AX_WMAC_RFMOD, mac_idx);
+	u32 sub_carr = rtw89_mac_reg_by_idx(R_AX_TX_SUB_CARRIER_VALUE,
+					     mac_idx);
+	u32 chk_rate = rtw89_mac_reg_by_idx(R_AX_TXRATE_CHK, mac_idx);
+	u8 txsc20 = 0, txsc40 = 0, txsc80 = 0;
+	u8 rf_mod_val = 0, chk_rate_mask = 0;
+	u32 txsc;
+
+	switch (param->bandwidth) {
+	case RTW89_CHANNEL_WIDTH_160:
+		txsc80 = rtw89_phy_get_txsc(rtwdev, param,
+					    RTW89_CHANNEL_WIDTH_80);
+		fallthrough;
+	case RTW89_CHANNEL_WIDTH_80:
+		txsc40 = rtw89_phy_get_txsc(rtwdev, param,
+					    RTW89_CHANNEL_WIDTH_40);
+		fallthrough;
+	case RTW89_CHANNEL_WIDTH_40:
+		txsc20 = rtw89_phy_get_txsc(rtwdev, param,
+					    RTW89_CHANNEL_WIDTH_20);
+		break;
+	default:
+		break;
+	}
+
+	switch (param->bandwidth) {
+	case RTW89_CHANNEL_WIDTH_160:
+		rf_mod_val = AX_WMAC_RFMOD_160M;
+		txsc = FIELD_PREP(B_AX_TXSC_20M_MASK, txsc20) |
+		       FIELD_PREP(B_AX_TXSC_40M_MASK, txsc40) |
+		       FIELD_PREP(B_AX_TXSC_80M_MASK, txsc80);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rf_mod_val = AX_WMAC_RFMOD_80M;
+		txsc = FIELD_PREP(B_AX_TXSC_20M_MASK, txsc20) |
+		       FIELD_PREP(B_AX_TXSC_40M_MASK, txsc40);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rf_mod_val = AX_WMAC_RFMOD_40M;
+		txsc = FIELD_PREP(B_AX_TXSC_20M_MASK, txsc20);
+		break;
+	case RTW89_CHANNEL_WIDTH_20:
+	default:
+		rf_mod_val = AX_WMAC_RFMOD_20M;
+		txsc = 0;
+		break;
+	}
+	rtw89_write8_mask(rtwdev, rf_mod, B_AX_WMAC_RFMOD_MASK, rf_mod_val);
+	rtw89_write32(rtwdev, sub_carr, txsc);
+
+	switch (param->band_type) {
+	case RTW89_BAND_2G:
+		chk_rate_mask = B_AX_BAND_MODE;
+		break;
+	case RTW89_BAND_5G:
+	case RTW89_BAND_6G:
+		chk_rate_mask = B_AX_CHECK_CCK_EN | B_AX_RTS_LIMIT_IN_OFDM6;
+		break;
+	default:
+		rtw89_warn(rtwdev, "Invalid band_type:%d\n", param->band_type);
+		return;
+	}
+	rtw89_write8_clr(rtwdev, chk_rate, B_AX_BAND_MODE | B_AX_CHECK_CCK_EN |
+					   B_AX_RTS_LIMIT_IN_OFDM6);
+	rtw89_write8_set(rtwdev, chk_rate, chk_rate_mask);
+}
+
 struct rtw8852c_bb_gain {
 	u32 gain_g[BB_PATH_NUM_8852C];
 	u32 gain_a[BB_PATH_NUM_8852C];
-- 
2.25.1

