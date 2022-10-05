Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578DD5F50E3
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 10:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJEIdS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 04:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJEIdH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 04:33:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2922C7333E
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 01:32:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2958W88I0010386, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2958W88I0010386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Oct 2022 16:32:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 5 Oct 2022 16:32:36 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 5 Oct 2022
 16:32:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <echuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: make generic functions to convert subband gain index
Date:   Wed, 5 Oct 2022 16:32:11 +0800
Message-ID: <20221005083212.45683-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005083212.45683-1-pkshih@realtek.com>
References: <20221005083212.45683-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/05/2022 03:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzUgpFekyCAwMjo1OTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The gain tables use different domain index, so we need to convert the index
from subband of chandef. Since these conversion functions can share with
8852b, make generic functions for further use.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.h      | 44 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 46 +------------------
 2 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 030a7c904a28d..1129d462bfbdb 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -374,6 +374,50 @@ static inline u32 rtw89_phy_read32_mask(struct rtw89_dev *rtwdev,
 	return rtw89_read32_mask(rtwdev, addr | RTW89_PHY_ADDR_OFFSET, mask);
 }
 
+static inline
+enum rtw89_gain_offset rtw89_subband_to_gain_offset_band_of_ofdm(enum rtw89_subband subband)
+{
+	switch (subband) {
+	default:
+	case RTW89_CH_2G:
+		return RTW89_GAIN_OFFSET_2G_OFDM;
+	case RTW89_CH_5G_BAND_1:
+		return RTW89_GAIN_OFFSET_5G_LOW;
+	case RTW89_CH_5G_BAND_3:
+		return RTW89_GAIN_OFFSET_5G_MID;
+	case RTW89_CH_5G_BAND_4:
+		return RTW89_GAIN_OFFSET_5G_HIGH;
+	}
+}
+
+static inline
+enum rtw89_phy_bb_gain_band rtw89_subband_to_bb_gain_band(enum rtw89_subband subband)
+{
+	switch (subband) {
+	default:
+	case RTW89_CH_2G:
+		return RTW89_BB_GAIN_BAND_2G;
+	case RTW89_CH_5G_BAND_1:
+		return RTW89_BB_GAIN_BAND_5G_L;
+	case RTW89_CH_5G_BAND_3:
+		return RTW89_BB_GAIN_BAND_5G_M;
+	case RTW89_CH_5G_BAND_4:
+		return RTW89_BB_GAIN_BAND_5G_H;
+	case RTW89_CH_6G_BAND_IDX0:
+	case RTW89_CH_6G_BAND_IDX1:
+		return RTW89_BB_GAIN_BAND_6G_L;
+	case RTW89_CH_6G_BAND_IDX2:
+	case RTW89_CH_6G_BAND_IDX3:
+		return RTW89_BB_GAIN_BAND_6G_M;
+	case RTW89_CH_6G_BAND_IDX4:
+	case RTW89_CH_6G_BAND_IDX5:
+		return RTW89_BB_GAIN_BAND_6G_H;
+	case RTW89_CH_6G_BAND_IDX6:
+	case RTW89_CH_6G_BAND_IDX7:
+		return RTW89_BB_GAIN_BAND_6G_UH;
+	}
+}
+
 enum rtw89_rfk_flag {
 	RTW89_RFK_F_WRF = 0,
 	RTW89_RFK_F_WM = 1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 00f564be29e8d..f6bcac8268166 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -788,40 +788,12 @@ static const struct rtw8852c_bb_gain_op1db bb_gain_op1db_a = {
 	.mask_tia0_lna6 = 0xff000000,
 };
 
-static enum rtw89_phy_bb_gain_band
-rtw8852c_mapping_gain_band(enum rtw89_subband subband)
-{
-	switch (subband) {
-	default:
-	case RTW89_CH_2G:
-		return RTW89_BB_GAIN_BAND_2G;
-	case RTW89_CH_5G_BAND_1:
-		return RTW89_BB_GAIN_BAND_5G_L;
-	case RTW89_CH_5G_BAND_3:
-		return RTW89_BB_GAIN_BAND_5G_M;
-	case RTW89_CH_5G_BAND_4:
-		return RTW89_BB_GAIN_BAND_5G_H;
-	case RTW89_CH_6G_BAND_IDX0:
-	case RTW89_CH_6G_BAND_IDX1:
-		return RTW89_BB_GAIN_BAND_6G_L;
-	case RTW89_CH_6G_BAND_IDX2:
-	case RTW89_CH_6G_BAND_IDX3:
-		return RTW89_BB_GAIN_BAND_6G_M;
-	case RTW89_CH_6G_BAND_IDX4:
-	case RTW89_CH_6G_BAND_IDX5:
-		return RTW89_BB_GAIN_BAND_6G_H;
-	case RTW89_CH_6G_BAND_IDX6:
-	case RTW89_CH_6G_BAND_IDX7:
-		return RTW89_BB_GAIN_BAND_6G_UH;
-	}
-}
-
 static void rtw8852c_set_gain_error(struct rtw89_dev *rtwdev,
 				    enum rtw89_subband subband,
 				    enum rtw89_rf_path path)
 {
 	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
-	u8 gain_band = rtw8852c_mapping_gain_band(subband);
+	u8 gain_band = rtw89_subband_to_bb_gain_band(subband);
 	s32 val;
 	u32 reg;
 	u32 mask;
@@ -979,21 +951,7 @@ static void rtw8852c_set_gain_offset(struct rtw89_dev *rtwdev,
 		rtw89_phy_write32_mask(rtwdev, R_RPL_OFST, B_RPL_OFST_MASK, tmp & 0x7f);
 	}
 
-	switch (chan->subband_type) {
-	default:
-	case RTW89_CH_2G:
-		gain_band = RTW89_GAIN_OFFSET_2G_OFDM;
-		break;
-	case RTW89_CH_5G_BAND_1:
-		gain_band = RTW89_GAIN_OFFSET_5G_LOW;
-		break;
-	case RTW89_CH_5G_BAND_3:
-		gain_band = RTW89_GAIN_OFFSET_5G_MID;
-		break;
-	case RTW89_CH_5G_BAND_4:
-		gain_band = RTW89_GAIN_OFFSET_5G_HIGH;
-		break;
-	}
+	gain_band = rtw89_subband_to_gain_offset_band_of_ofdm(chan->subband_type);
 
 	offset_q0 = -efuse_gain->offset[path][gain_band];
 	offset_base_q4 = efuse_gain->offset_base[phy_idx];
-- 
2.25.1

