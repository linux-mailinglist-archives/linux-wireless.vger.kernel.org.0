Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685924B1FC8
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 09:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347883AbiBKIAh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 03:00:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347876AbiBKIAd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 03:00:33 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A0BBD9
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 00:00:31 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21B80PS40023927, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21B80PS40023927
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 16:00:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 16:00:25 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 11 Feb
 2022 16:00:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 6/6] rtw89: handle TX/RX 160M bandwidth
Date:   Fri, 11 Feb 2022 15:59:53 +0800
Message-ID: <20220211075953.40421-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211075953.40421-1-pkshih@realtek.com>
References: <20220211075953.40421-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/11/2022 07:45:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTEgpFekyCAwNjowMDowMA==?=
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

Apply 160M bandwidth to RA (rate adaptive) mechanism, so it can transmit
packets with this bandwidth. On the other hand, convert 160M bandwidth
from RX desc to rx_info_bw.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 15 ++-------------
 drivers/net/wireless/realtek/rtw89/core.h | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c  | 13 ++++++-------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index bf5b7589906d8..63828dbfef4ef 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1165,13 +1165,7 @@ static bool rtw89_core_rx_ppdu_match(struct rtw89_dev *rtwdev,
 		rtw89_warn(rtwdev, "invalid RX rate mode %d\n", data_rate_mode);
 	}
 
-	if (desc_info->bw == RTW89_CHANNEL_WIDTH_80)
-		bw = RATE_INFO_BW_80;
-	else if (desc_info->bw == RTW89_CHANNEL_WIDTH_40)
-		bw = RATE_INFO_BW_40;
-	else
-		bw = RATE_INFO_BW_20;
-
+	bw = rtw89_hw_to_rate_info_bw(desc_info->bw);
 	gi_ltf = rtw89_rxdesc_to_nl_he_gi(rtwdev, desc_info, false);
 	ret = rtwdev->ppdu_sts.curr_rx_ppdu_cnt[band] == desc_info->ppdu_cnt &&
 	      status->rate_idx == rate_idx &&
@@ -1442,12 +1436,7 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 	    !(desc_info->sw_dec || desc_info->icv_err))
 		rx_status->flag |= RX_FLAG_DECRYPTED;
 
-	if (desc_info->bw == RTW89_CHANNEL_WIDTH_80)
-		rx_status->bw = RATE_INFO_BW_80;
-	else if (desc_info->bw == RTW89_CHANNEL_WIDTH_40)
-		rx_status->bw = RATE_INFO_BW_40;
-	else
-		rx_status->bw = RATE_INFO_BW_20;
+	rx_status->bw = rtw89_hw_to_rate_info_bw(desc_info->bw);
 
 	data_rate = desc_info->data_rate;
 	data_rate_mode = GET_DATA_RATE_MODE(data_rate);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0e55778b83ece..3254be670bd67 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3160,6 +3160,18 @@ static inline struct rtw89_sta *sta_to_rtwsta_safe(struct ieee80211_sta *sta)
 	return sta ? (struct rtw89_sta *)sta->drv_priv : NULL;
 }
 
+static inline u8 rtw89_hw_to_rate_info_bw(enum rtw89_bandwidth hw_bw)
+{
+	if (hw_bw == RTW89_CHANNEL_WIDTH_160)
+		return RATE_INFO_BW_160;
+	else if (hw_bw == RTW89_CHANNEL_WIDTH_80)
+		return RATE_INFO_BW_80;
+	else if (hw_bw == RTW89_CHANNEL_WIDTH_40)
+		return RATE_INFO_BW_40;
+	else
+		return RATE_INFO_BW_20;
+}
+
 static inline
 struct rtw89_addr_cam_entry *rtw89_get_addr_cam_of(struct rtw89_vif *rtwvif,
 						   struct rtw89_sta *rtwsta)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 69668108e19f3..d1d3ebb5e2264 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -302,6 +302,11 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	ra_mask &= rtw89_phy_ra_mask_cfg(rtwdev, rtwsta);
 
 	switch (sta->bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+		bw_mode = RTW89_CHANNEL_WIDTH_160;
+		sgi = sta->vht_cap.vht_supported &&
+		      (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160);
+		break;
 	case IEEE80211_STA_RX_BW_80:
 		bw_mode = RTW89_CHANNEL_WIDTH_80;
 		sgi = sta->vht_cap.vht_supported &&
@@ -1439,13 +1444,7 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 		break;
 	}
 
-	if (bw == RTW89_CHANNEL_WIDTH_80)
-		ra_report->txrate.bw = RATE_INFO_BW_80;
-	else if (bw == RTW89_CHANNEL_WIDTH_40)
-		ra_report->txrate.bw = RATE_INFO_BW_40;
-	else
-		ra_report->txrate.bw = RATE_INFO_BW_20;
-
+	ra_report->txrate.bw = rtw89_hw_to_rate_info_bw(bw);
 	ra_report->bit_rate = cfg80211_calculate_bitrate(&ra_report->txrate);
 	ra_report->hw_rate = FIELD_PREP(RTW89_HW_RATE_MASK_MOD, mode) |
 			     FIELD_PREP(RTW89_HW_RATE_MASK_VAL, rate);
-- 
2.25.1

