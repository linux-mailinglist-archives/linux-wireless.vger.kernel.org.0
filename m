Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3D4525B13
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 07:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377103AbiEMFm6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 01:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359219AbiEMFmy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 01:42:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448E31D8B57
        for <linux-wireless@vger.kernel.org>; Thu, 12 May 2022 22:42:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24D5gilE7005712, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24D5gilE7005712
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 May 2022 13:42:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 13 May 2022 13:42:44 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 13 May
 2022 13:42:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 5/6] rtw89: convert rtw89_band to nl80211_band precisely
Date:   Fri, 13 May 2022 13:42:23 +0800
Message-ID: <20220513054224.16902-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513054224.16902-1-pkshih@realtek.com>
References: <20220513054224.16902-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 05/13/2022 05:24:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMTIgpFWkyCAxMDo1OTowMA==?=
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Before 6G band was supported, i.e. only 2G and 5G, they were the same
from the numerical point of view. However, after 6G band support, we
need to do this conversion logically.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 11 +++++++----
 drivers/net/wireless/realtek/rtw89/core.h | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c   |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c  | 13 +++++++------
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e3317deafa1d0..a6a90572e74bf 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1608,10 +1608,13 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 
 	if (rtwdev->scanning &&
 	    RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
-		rx_status->freq =
-			ieee80211_channel_to_frequency(hal->current_channel,
-						       hal->current_band_type);
-		rx_status->band = rtwdev->hal.current_band_type;
+		u8 chan = hal->current_channel;
+		u8 band = hal->current_band_type;
+		enum nl80211_band nl_band;
+
+		nl_band = rtw89_hw_to_nl80211_band(band);
+		rx_status->freq = ieee80211_channel_to_frequency(chan, nl_band);
+		rx_status->band = nl_band;
 	}
 
 	if (desc_info->icv_err || desc_info->crc32_err)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2921814842ffa..e8a77225a90ff 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3480,6 +3480,20 @@ static inline u8 rtw89_hw_to_rate_info_bw(enum rtw89_bandwidth hw_bw)
 		return RATE_INFO_BW_20;
 }
 
+static inline
+enum nl80211_band rtw89_hw_to_nl80211_band(enum rtw89_band hw_band)
+{
+	switch (hw_band) {
+	default:
+	case RTW89_BAND_2G:
+		return NL80211_BAND_2GHZ;
+	case RTW89_BAND_5G:
+		return NL80211_BAND_5GHZ;
+	case RTW89_BAND_6G:
+		return NL80211_BAND_6GHZ;
+	}
+}
+
 static inline
 enum rtw89_bandwidth nl_to_rtw89_bandwidth(enum nl80211_chan_width width)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index e4be785709d10..4718aced1428a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2068,7 +2068,7 @@ static void rtw89_release_pkt_list(struct rtw89_dev *rtwdev)
 	struct rtw89_pktofld_info *info, *tmp;
 	u8 idx;
 
-	for (idx = RTW89_BAND_2G; idx < NUM_NL80211_BANDS; idx++) {
+	for (idx = NL80211_BAND_2GHZ; idx < NUM_NL80211_BANDS; idx++) {
 		if (!(rtwdev->chip->support_bands & BIT(idx)))
 			continue;
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 79e4c28495c80..762cdba9d3cfd 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -429,27 +429,28 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 					 RTW89_HW_RATE_MCS16,
 					 RTW89_HW_RATE_MCS24};
 	u8 band = rtwdev->hal.current_band_type;
+	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
 	u8 tx_nss = rtwdev->hal.tx_nss;
 	u8 i;
 
 	for (i = 0; i < tx_nss; i++)
 		if (!__check_rate_pattern(&next_pattern, hw_rate_he[i],
 					  RA_MASK_HE_RATES, RTW89_RA_MODE_HE,
-					  mask->control[band].he_mcs[i],
+					  mask->control[nl_band].he_mcs[i],
 					  0, true))
 			goto out;
 
 	for (i = 0; i < tx_nss; i++)
 		if (!__check_rate_pattern(&next_pattern, hw_rate_vht[i],
 					  RA_MASK_VHT_RATES, RTW89_RA_MODE_VHT,
-					  mask->control[band].vht_mcs[i],
+					  mask->control[nl_band].vht_mcs[i],
 					  0, true))
 			goto out;
 
 	for (i = 0; i < tx_nss; i++)
 		if (!__check_rate_pattern(&next_pattern, hw_rate_ht[i],
 					  RA_MASK_HT_RATES, RTW89_RA_MODE_HT,
-					  mask->control[band].ht_mcs[i],
+					  mask->control[nl_band].ht_mcs[i],
 					  0, true))
 			goto out;
 
@@ -457,18 +458,18 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 	 * require at least one basic rate for ieee80211_set_bitrate_mask,
 	 * so the decision just depends on if all bitrates are set or not.
 	 */
-	sband = rtwdev->hw->wiphy->bands[band];
+	sband = rtwdev->hw->wiphy->bands[nl_band];
 	if (band == RTW89_BAND_2G) {
 		if (!__check_rate_pattern(&next_pattern, RTW89_HW_RATE_CCK1,
 					  RA_MASK_CCK_RATES | RA_MASK_OFDM_RATES,
 					  RTW89_RA_MODE_CCK | RTW89_RA_MODE_OFDM,
-					  mask->control[band].legacy,
+					  mask->control[nl_band].legacy,
 					  BIT(sband->n_bitrates) - 1, false))
 			goto out;
 	} else {
 		if (!__check_rate_pattern(&next_pattern, RTW89_HW_RATE_OFDM6,
 					  RA_MASK_OFDM_RATES, RTW89_RA_MODE_OFDM,
-					  mask->control[band].legacy,
+					  mask->control[nl_band].legacy,
 					  BIT(sband->n_bitrates) - 1, false))
 			goto out;
 	}
-- 
2.25.1

