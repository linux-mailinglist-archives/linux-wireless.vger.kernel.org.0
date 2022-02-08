Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7934AD33B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 09:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349341AbiBHIZB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 03:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349335AbiBHIY7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 03:24:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4593C03FEC0
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 00:24:57 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2188OoB02020537, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2188OoB02020537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 8 Feb 2022 16:24:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 8 Feb 2022 16:24:49 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 8 Feb
 2022 16:24:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <ben.liao@realtek.com>,
        <damon.chen@realtek.com>
Subject: [PATCH 1/2] rtw88: recover rates of rate adaptive mechanism
Date:   Tue, 8 Feb 2022 16:24:26 +0800
Message-ID: <20220208082427.42433-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208082427.42433-1-pkshih@realtek.com>
References: <20220208082427.42433-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/08/2022 08:04:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvOCCkV6TIIDA2OjAwOjAw?=
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

From: Chien-Hsun Liao <ben.liao@realtek.com>

Some APs like CMW270 only support one phyrate and the function
rtw_update_rate_mask could disable that rate. To fix such problem, we
restore the rate mask if we find that the rate_mask is empty.

Signed-off-by: Chien-Hsun Liao <ben.liao@realtek.com>
Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 67 +++++++++++++++--------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 39c223a2e3e2d..2757aa0dc586b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1020,37 +1020,52 @@ static u8 get_rate_id(u8 wireless_set, enum rtw_bandwidth bw_mode, u8 tx_num)
 #define RA_MASK_VHT_RATES	(RA_MASK_VHT_RATES_1SS | \
 				 RA_MASK_VHT_RATES_2SS | \
 				 RA_MASK_VHT_RATES_3SS)
+#define RA_MASK_CCK_IN_BG	0x00005
 #define RA_MASK_CCK_IN_HT	0x00005
 #define RA_MASK_CCK_IN_VHT	0x00005
 #define RA_MASK_OFDM_IN_VHT	0x00010
 #define RA_MASK_OFDM_IN_HT_2G	0x00010
 #define RA_MASK_OFDM_IN_HT_5G	0x00030
 
-static u64 rtw_update_rate_mask(struct rtw_dev *rtwdev,
-				struct rtw_sta_info *si,
-				u64 ra_mask, bool is_vht_enable,
-				u8 wireless_set)
+static u64 rtw_rate_mask_rssi(struct rtw_sta_info *si, u8 wireless_set)
+{
+	u8 rssi_level = si->rssi_level;
+
+	if (wireless_set == WIRELESS_CCK)
+		return 0xffffffffffffffffULL;
+
+	if (rssi_level == 0)
+		return 0xffffffffffffffffULL;
+	else if (rssi_level == 1)
+		return 0xfffffffffffffff0ULL;
+	else if (rssi_level == 2)
+		return 0xffffffffffffefe0ULL;
+	else if (rssi_level == 3)
+		return 0xffffffffffffcfc0ULL;
+	else if (rssi_level == 4)
+		return 0xffffffffffff8f80ULL;
+	else
+		return 0xffffffffffff0f00ULL;
+}
+
+static u64 rtw_rate_mask_recover(u64 ra_mask, u64 ra_mask_bak)
+{
+	if ((ra_mask & ~(RA_MASK_CCK_RATES | RA_MASK_OFDM_RATES)) == 0)
+		ra_mask |= (ra_mask_bak & ~(RA_MASK_CCK_RATES | RA_MASK_OFDM_RATES));
+
+	if (ra_mask == 0)
+		ra_mask |= (ra_mask_bak & (RA_MASK_CCK_RATES | RA_MASK_OFDM_RATES));
+
+	return ra_mask;
+}
+
+static u64 rtw_rate_mask_cfg(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
+			     u64 ra_mask, bool is_vht_enable)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	const struct cfg80211_bitrate_mask *mask = si->mask;
 	u64 cfg_mask = GENMASK_ULL(63, 0);
-	u8 rssi_level, band;
-
-	if (wireless_set != WIRELESS_CCK) {
-		rssi_level = si->rssi_level;
-		if (rssi_level == 0)
-			ra_mask &= 0xffffffffffffffffULL;
-		else if (rssi_level == 1)
-			ra_mask &= 0xfffffffffffffff0ULL;
-		else if (rssi_level == 2)
-			ra_mask &= 0xffffffffffffefe0ULL;
-		else if (rssi_level == 3)
-			ra_mask &= 0xffffffffffffcfc0ULL;
-		else if (rssi_level == 4)
-			ra_mask &= 0xffffffffffff8f80ULL;
-		else if (rssi_level >= 5)
-			ra_mask &= 0xffffffffffff0f00ULL;
-	}
+	u8 band;
 
 	if (!si->use_cfg_mask)
 		return ra_mask;
@@ -1100,6 +1115,7 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 	u8 ldpc_en = 0;
 	u8 tx_num = 1;
 	u64 ra_mask = 0;
+	u64 ra_mask_bak = 0;
 	bool is_vht_enable = false;
 	bool is_support_sgi = false;
 
@@ -1124,6 +1140,7 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 
 	if (hal->current_band_type == RTW_BAND_5G) {
 		ra_mask |= (u64)sta->supp_rates[NL80211_BAND_5GHZ] << 4;
+		ra_mask_bak = ra_mask;
 		if (sta->vht_cap.vht_supported) {
 			ra_mask &= RA_MASK_VHT_RATES | RA_MASK_OFDM_IN_VHT;
 			wireless_set = WIRELESS_OFDM | WIRELESS_VHT;
@@ -1136,6 +1153,7 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 		dm_info->rrsr_val_init = RRSR_INIT_5G;
 	} else if (hal->current_band_type == RTW_BAND_2G) {
 		ra_mask |= sta->supp_rates[NL80211_BAND_2GHZ];
+		ra_mask_bak = ra_mask;
 		if (sta->vht_cap.vht_supported) {
 			ra_mask &= RA_MASK_VHT_RATES | RA_MASK_CCK_IN_VHT |
 				   RA_MASK_OFDM_IN_VHT;
@@ -1149,11 +1167,13 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 		} else if (sta->supp_rates[0] <= 0xf) {
 			wireless_set = WIRELESS_CCK;
 		} else {
+			ra_mask &= RA_MASK_OFDM_RATES | RA_MASK_CCK_IN_BG;
 			wireless_set = WIRELESS_CCK | WIRELESS_OFDM;
 		}
 		dm_info->rrsr_val_init = RRSR_INIT_2G;
 	} else {
 		rtw_err(rtwdev, "Unknown band type\n");
+		ra_mask_bak = ra_mask;
 		wireless_set = 0;
 	}
 
@@ -1185,8 +1205,9 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 
 	rate_id = get_rate_id(wireless_set, bw_mode, tx_num);
 
-	ra_mask = rtw_update_rate_mask(rtwdev, si, ra_mask, is_vht_enable,
-				       wireless_set);
+	ra_mask &= rtw_rate_mask_rssi(si, wireless_set);
+	ra_mask = rtw_rate_mask_recover(ra_mask, ra_mask_bak);
+	ra_mask = rtw_rate_mask_cfg(rtwdev, si, ra_mask, is_vht_enable);
 
 	si->bw_mode = bw_mode;
 	si->stbc_en = stbc_en;
-- 
2.25.1

