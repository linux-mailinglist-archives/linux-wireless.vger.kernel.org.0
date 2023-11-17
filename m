Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CE67EEB29
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 03:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjKQClh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 21:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjKQClh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 21:41:37 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE452CE
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 18:41:32 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AH2fPRU12818740, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AH2fPRU12818740
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 10:41:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Nov 2023 10:41:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 17 Nov
 2023 10:41:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: 8852c: read RX gain offset from efuse for 6GHz channels
Date:   Fri, 17 Nov 2023 10:40:27 +0800
Message-ID: <20231117024029.113845-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117024029.113845-1-pkshih@realtek.com>
References: <20231117024029.113845-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Read calibration values of RX gain offset from efuse, and set them to
registers to normalize RX gain for all hardware modules. Then, PHY dynamic
mechanism can get expected values to adjust hardware parameters to yield
expected performance.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  8 +++++++
 drivers/net/wireless/realtek/rtw89/phy.h      | 16 +++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 24 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.h | 20 ++++++++++++++--
 4 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 9983fb38b3a5..571db6fe07f9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -104,6 +104,14 @@ enum rtw89_gain_offset {
 	RTW89_GAIN_OFFSET_5G_LOW,
 	RTW89_GAIN_OFFSET_5G_MID,
 	RTW89_GAIN_OFFSET_5G_HIGH,
+	RTW89_GAIN_OFFSET_6G_L0,
+	RTW89_GAIN_OFFSET_6G_L1,
+	RTW89_GAIN_OFFSET_6G_M0,
+	RTW89_GAIN_OFFSET_6G_M1,
+	RTW89_GAIN_OFFSET_6G_H0,
+	RTW89_GAIN_OFFSET_6G_H1,
+	RTW89_GAIN_OFFSET_6G_UH0,
+	RTW89_GAIN_OFFSET_6G_UH1,
 
 	RTW89_GAIN_OFFSET_NR,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 5c85122e7bb5..2d9cf5c02b92 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -591,6 +591,22 @@ enum rtw89_gain_offset rtw89_subband_to_gain_offset_band_of_ofdm(enum rtw89_subb
 		return RTW89_GAIN_OFFSET_5G_MID;
 	case RTW89_CH_5G_BAND_4:
 		return RTW89_GAIN_OFFSET_5G_HIGH;
+	case RTW89_CH_6G_BAND_IDX0:
+		return RTW89_GAIN_OFFSET_6G_L0;
+	case RTW89_CH_6G_BAND_IDX1:
+		return RTW89_GAIN_OFFSET_6G_L1;
+	case RTW89_CH_6G_BAND_IDX2:
+		return RTW89_GAIN_OFFSET_6G_M0;
+	case RTW89_CH_6G_BAND_IDX3:
+		return RTW89_GAIN_OFFSET_6G_M1;
+	case RTW89_CH_6G_BAND_IDX4:
+		return RTW89_GAIN_OFFSET_6G_H0;
+	case RTW89_CH_6G_BAND_IDX5:
+		return RTW89_GAIN_OFFSET_6G_H1;
+	case RTW89_CH_6G_BAND_IDX6:
+		return RTW89_GAIN_OFFSET_6G_UH0;
+	case RTW89_CH_6G_BAND_IDX7:
+		return RTW89_GAIN_OFFSET_6G_UH1;
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 1d655ce1fd5f..ea152a4613f2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -426,6 +426,30 @@ static void rtw8852c_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
 	valid |= _decode_efuse_gain(map->rx_gain_5g_high,
 				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_HIGH],
 				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_HIGH]);
+	valid |= _decode_efuse_gain(map->rx_gain_6g_l0,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_L0],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_L0]);
+	valid |= _decode_efuse_gain(map->rx_gain_6g_l1,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_L1],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_L1]);
+	valid |= _decode_efuse_gain(map->rx_gain_6g_m0,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_M0],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_M0]);
+	valid |= _decode_efuse_gain(map->rx_gain_6g_m1,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_M1],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_M1]);
+	valid |= _decode_efuse_gain(map->rx_gain_6g_h0,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_H0],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_H0]);
+	valid |= _decode_efuse_gain(map->rx_gain_6g_h1,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_H1],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_H1]);
+	valid |= _decode_efuse_gain(map->rx_gain_6g_uh0,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_UH0],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_UH0]);
+	valid |= _decode_efuse_gain(map->rx_gain_6g_uh1,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_UH1],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_UH1]);
 
 	gain->offset_valid = valid;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
index ac642808a81f..77b05daedd10 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
@@ -73,9 +73,25 @@ struct rtw8852c_efuse {
 	u8 bw40_1s_tssi_6g_a[TSSI_MCS_6G_CH_GROUP_NUM];
 	u8 rsvd14[10];
 	u8 bw40_1s_tssi_6g_b[TSSI_MCS_6G_CH_GROUP_NUM];
-	u8 rsvd15[110];
+	u8 rsvd15[94];
+	u8 rx_gain_6g_l0;
+	u8 rsvd16;
+	u8 rx_gain_6g_l1;
+	u8 rsvd17;
+	u8 rx_gain_6g_m0;
+	u8 rsvd18;
+	u8 rx_gain_6g_m1;
+	u8 rsvd19;
+	u8 rx_gain_6g_h0;
+	u8 rsvd20;
+	u8 rx_gain_6g_h1;
+	u8 rsvd21;
+	u8 rx_gain_6g_uh0;
+	u8 rsvd22;
+	u8 rx_gain_6g_uh1;
+	u8 rsvd23;
 	u8 channel_plan_6g;
-	u8 rsvd16[71];
+	u8 rsvd24[71];
 	union {
 		struct rtw8852c_u_efuse u;
 		struct rtw8852c_e_efuse e;
-- 
2.25.1

