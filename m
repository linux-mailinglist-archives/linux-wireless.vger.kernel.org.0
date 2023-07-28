Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF30D7664B9
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 09:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjG1HEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 03:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjG1HEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 03:04:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3028C210B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 00:04:04 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36S73iZJ2031498, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36S73iZJ2031498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 28 Jul 2023 15:03:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 28 Jul 2023 15:03:36 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 28 Jul
 2023 15:03:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 10/10] wifi: rtw89: get data rate mode/NSS/MCS v1 from RX descriptor
Date:   Fri, 28 Jul 2023 15:02:52 +0800
Message-ID: <20230728070252.66525-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728070252.66525-1-pkshih@realtek.com>
References: <20230728070252.66525-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

The data rate from RX descriptor also uses hardware rate v1 for WiFi 7
chips. The rate code contains three parts -- mode, NSS and MCS. For
CCK/OFDM/HT rates, NSS/MCS parts are the same as before. VHT/HE/EHT rates
are changed and listed as below:

     mode    NSS    MCS
V0   [8:7]   [6:4]  [3:0]
V1   [10:8]  [7:5]  [4:0]

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 24 ++++++------
 drivers/net/wireless/realtek/rtw89/phy.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/txrx.h | 47 ++++++++++++++++++++---
 3 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 69b181fa29667..ec244849e5014 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1456,16 +1456,16 @@ static bool rtw89_core_rx_ppdu_match(struct rtw89_dev *rtwdev,
 	bool ret;
 
 	data_rate = desc_info->data_rate;
-	data_rate_mode = GET_DATA_RATE_MODE(data_rate);
+	data_rate_mode = rtw89_get_data_rate_mode(rtwdev, data_rate);
 	if (data_rate_mode == DATA_RATE_MODE_NON_HT) {
-		rate_idx = GET_DATA_RATE_NOT_HT_IDX(data_rate);
+		rate_idx = rtw89_get_data_not_ht_idx(rtwdev, data_rate);
 		/* rate_idx is still hardware value here */
 	} else if (data_rate_mode == DATA_RATE_MODE_HT) {
-		rate_idx = GET_DATA_RATE_HT_IDX(data_rate);
+		rate_idx = rtw89_get_data_ht_mcs(rtwdev, data_rate);
 	} else if (data_rate_mode == DATA_RATE_MODE_VHT) {
-		rate_idx = GET_DATA_RATE_VHT_HE_IDX(data_rate);
+		rate_idx = rtw89_get_data_mcs(rtwdev, data_rate);
 	} else if (data_rate_mode == DATA_RATE_MODE_HE) {
-		rate_idx = GET_DATA_RATE_VHT_HE_IDX(data_rate);
+		rate_idx = rtw89_get_data_mcs(rtwdev, data_rate);
 	} else {
 		rtw89_warn(rtwdev, "invalid RX rate mode %d\n", data_rate_mode);
 	}
@@ -1929,26 +1929,26 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 	rx_status->bw = rtw89_hw_to_rate_info_bw(desc_info->bw);
 
 	data_rate = desc_info->data_rate;
-	data_rate_mode = GET_DATA_RATE_MODE(data_rate);
+	data_rate_mode = rtw89_get_data_rate_mode(rtwdev, data_rate);
 	if (data_rate_mode == DATA_RATE_MODE_NON_HT) {
 		rx_status->encoding = RX_ENC_LEGACY;
-		rx_status->rate_idx = GET_DATA_RATE_NOT_HT_IDX(data_rate);
+		rx_status->rate_idx = rtw89_get_data_not_ht_idx(rtwdev, data_rate);
 		/* convert rate_idx after we get the correct band */
 	} else if (data_rate_mode == DATA_RATE_MODE_HT) {
 		rx_status->encoding = RX_ENC_HT;
-		rx_status->rate_idx = GET_DATA_RATE_HT_IDX(data_rate);
+		rx_status->rate_idx = rtw89_get_data_ht_mcs(rtwdev, data_rate);
 		if (desc_info->gi_ltf)
 			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 	} else if (data_rate_mode == DATA_RATE_MODE_VHT) {
 		rx_status->encoding = RX_ENC_VHT;
-		rx_status->rate_idx = GET_DATA_RATE_VHT_HE_IDX(data_rate);
-		rx_status->nss = GET_DATA_RATE_NSS(data_rate) + 1;
+		rx_status->rate_idx = rtw89_get_data_mcs(rtwdev, data_rate);
+		rx_status->nss = rtw89_get_data_nss(rtwdev, data_rate) + 1;
 		if (desc_info->gi_ltf)
 			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 	} else if (data_rate_mode == DATA_RATE_MODE_HE) {
 		rx_status->encoding = RX_ENC_HE;
-		rx_status->rate_idx = GET_DATA_RATE_VHT_HE_IDX(data_rate);
-		rx_status->nss = GET_DATA_RATE_NSS(data_rate) + 1;
+		rx_status->rate_idx = rtw89_get_data_mcs(rtwdev, data_rate);
+		rx_status->nss = rtw89_get_data_nss(rtwdev, data_rate) + 1;
 	} else {
 		rtw89_warn(rtwdev, "invalid RX rate mode %d\n", data_rate_mode);
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 1940f4457677c..abe0f5179a382 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3014,7 +3014,7 @@ static void rtw89_phy_antdiv_sts_instance_add(struct rtw89_dev *rtwdev,
 					      struct rtw89_rx_phy_ppdu *phy_ppdu,
 					      struct rtw89_antdiv_stats *stats)
 {
-	if (GET_DATA_RATE_MODE(phy_ppdu->rate) == DATA_RATE_MODE_NON_HT) {
+	if (rtw89_get_data_rate_mode(rtwdev, phy_ppdu->rate) == DATA_RATE_MODE_NON_HT) {
 		if (phy_ppdu->rate < RTW89_HW_RATE_OFDM6) {
 			ewma_rssi_add(&stats->cck_rssi_avg, phy_ppdu->rssi_avg);
 			stats->pkt_cnt_cck++;
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index ec96da36eacc6..02cff0f7d86b9 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -8,19 +8,56 @@
 #include "debug.h"
 
 #define DATA_RATE_MODE_CTRL_MASK	GENMASK(8, 7)
+#define DATA_RATE_MODE_CTRL_MASK_V1	GENMASK(10, 8)
 #define DATA_RATE_NOT_HT_IDX_MASK	GENMASK(3, 0)
 #define DATA_RATE_MODE_NON_HT		0x0
 #define DATA_RATE_HT_IDX_MASK		GENMASK(4, 0)
+#define DATA_RATE_HT_IDX_MASK_V1	GENMASK(4, 0)
 #define DATA_RATE_MODE_HT		0x1
 #define DATA_RATE_VHT_HE_NSS_MASK	GENMASK(6, 4)
 #define DATA_RATE_VHT_HE_IDX_MASK	GENMASK(3, 0)
+#define DATA_RATE_NSS_MASK_V1		GENMASK(7, 5)
+#define DATA_RATE_MCS_MASK_V1		GENMASK(4, 0)
 #define DATA_RATE_MODE_VHT		0x2
 #define DATA_RATE_MODE_HE		0x3
-#define GET_DATA_RATE_MODE(r)		FIELD_GET(DATA_RATE_MODE_CTRL_MASK, r)
-#define GET_DATA_RATE_NOT_HT_IDX(r)	FIELD_GET(DATA_RATE_NOT_HT_IDX_MASK, r)
-#define GET_DATA_RATE_HT_IDX(r)		FIELD_GET(DATA_RATE_HT_IDX_MASK, r)
-#define GET_DATA_RATE_VHT_HE_IDX(r)	FIELD_GET(DATA_RATE_VHT_HE_IDX_MASK, r)
-#define GET_DATA_RATE_NSS(r)		FIELD_GET(DATA_RATE_VHT_HE_NSS_MASK, r)
+#define DATA_RATE_MODE_EHT		0x4
+
+static inline u8 rtw89_get_data_rate_mode(struct rtw89_dev *rtwdev, u16 hw_rate)
+{
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
+		return u16_get_bits(hw_rate, DATA_RATE_MODE_CTRL_MASK_V1);
+
+	return u16_get_bits(hw_rate, DATA_RATE_MODE_CTRL_MASK);
+}
+
+static inline u8 rtw89_get_data_not_ht_idx(struct rtw89_dev *rtwdev, u16 hw_rate)
+{
+	return u16_get_bits(hw_rate, DATA_RATE_NOT_HT_IDX_MASK);
+}
+
+static inline u8 rtw89_get_data_ht_mcs(struct rtw89_dev *rtwdev, u16 hw_rate)
+{
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
+		return u16_get_bits(hw_rate, DATA_RATE_HT_IDX_MASK_V1);
+
+	return u16_get_bits(hw_rate, DATA_RATE_HT_IDX_MASK);
+}
+
+static inline u8 rtw89_get_data_mcs(struct rtw89_dev *rtwdev, u16 hw_rate)
+{
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
+		return u16_get_bits(hw_rate, DATA_RATE_MCS_MASK_V1);
+
+	return u16_get_bits(hw_rate, DATA_RATE_VHT_HE_IDX_MASK);
+}
+
+static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
+{
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
+		return u16_get_bits(hw_rate, DATA_RATE_NSS_MASK_V1);
+
+	return u16_get_bits(hw_rate, DATA_RATE_VHT_HE_NSS_MASK);
+}
 
 /* TX WD BODY DWORD 0 */
 #define RTW89_TXWD_BODY0_WP_OFFSET GENMASK(31, 24)
-- 
2.25.1

