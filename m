Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6A57BF0AD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 04:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441853AbjJJCKs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 22:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441850AbjJJCKr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 22:10:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E2E99
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 19:10:45 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39A2AUu542015391, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39A2AUu542015391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 10:10:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 10 Oct 2023 10:10:30 +0800
Received: from [127.0.1.1] (172.16.16.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 10 Oct
 2023 10:10:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/6] wifi: rtw89: parse EHT information from RX descriptor and PPDU status packet
Date:   Tue, 10 Oct 2023 10:10:01 +0800
Message-ID: <20231010021006.6061-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231010021006.6061-1-pkshih@realtek.com>
References: <20231010021006.6061-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.25]
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
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are two kinds of RX packets -- normal and its PPDU status packet.
Both have RX descriptor containing some information such as rate, GI and
bandwidth, and we use these information to find the relationship between
two kinds of packets. Then, we can get more information like RSSI and EVM
from PPDU status packet.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 59 +++++++++++++++++------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index cca18d7ea1dd..2742e6646cf1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1621,32 +1621,49 @@ static void rtw89_core_rx_process_phy_sts(struct rtw89_dev *rtwdev,
 					  phy_ppdu);
 }
 
-static u8 rtw89_rxdesc_to_nl_he_gi(struct rtw89_dev *rtwdev,
-				   const struct rtw89_rx_desc_info *desc_info,
-				   bool rx_status)
+static u8 rtw89_rxdesc_to_nl_he_eht_gi(struct rtw89_dev *rtwdev,
+				       u8 desc_info_gi,
+				       bool rx_status, bool eht)
 {
-	switch (desc_info->gi_ltf) {
+	switch (desc_info_gi) {
 	case RTW89_GILTF_SGI_4XHE08:
 	case RTW89_GILTF_2XHE08:
 	case RTW89_GILTF_1XHE08:
-		return NL80211_RATE_INFO_HE_GI_0_8;
+		return eht ? NL80211_RATE_INFO_EHT_GI_0_8 :
+			     NL80211_RATE_INFO_HE_GI_0_8;
 	case RTW89_GILTF_2XHE16:
 	case RTW89_GILTF_1XHE16:
-		return NL80211_RATE_INFO_HE_GI_1_6;
+		return eht ? NL80211_RATE_INFO_EHT_GI_1_6 :
+			     NL80211_RATE_INFO_HE_GI_1_6;
 	case RTW89_GILTF_LGI_4XHE32:
-		return NL80211_RATE_INFO_HE_GI_3_2;
+		return eht ? NL80211_RATE_INFO_EHT_GI_3_2 :
+			     NL80211_RATE_INFO_HE_GI_3_2;
 	default:
-		rtw89_warn(rtwdev, "invalid gi_ltf=%d", desc_info->gi_ltf);
-		return rx_status ? NL80211_RATE_INFO_HE_GI_3_2 : U8_MAX;
+		rtw89_warn(rtwdev, "invalid gi_ltf=%d", desc_info_gi);
+		if (rx_status)
+			return eht ? NL80211_RATE_INFO_EHT_GI_3_2 :
+				     NL80211_RATE_INFO_HE_GI_3_2;
+		return U8_MAX;
 	}
 }
 
+static
+bool rtw89_check_rx_statu_gi_match(struct ieee80211_rx_status *status, u8 gi_ltf,
+				   bool eht)
+{
+	if (eht)
+		return status->eht.gi == gi_ltf;
+
+	return status->he_gi == gi_ltf;
+}
+
 static bool rtw89_core_rx_ppdu_match(struct rtw89_dev *rtwdev,
 				     struct rtw89_rx_desc_info *desc_info,
 				     struct ieee80211_rx_status *status)
 {
 	u8 band = desc_info->bb_sel ? RTW89_PHY_1 : RTW89_PHY_0;
 	u8 data_rate_mode, bw, rate_idx = MASKBYTE0, gi_ltf;
+	bool eht = false;
 	u16 data_rate;
 	bool ret;
 
@@ -1657,19 +1674,20 @@ static bool rtw89_core_rx_ppdu_match(struct rtw89_dev *rtwdev,
 		/* rate_idx is still hardware value here */
 	} else if (data_rate_mode == DATA_RATE_MODE_HT) {
 		rate_idx = rtw89_get_data_ht_mcs(rtwdev, data_rate);
-	} else if (data_rate_mode == DATA_RATE_MODE_VHT) {
-		rate_idx = rtw89_get_data_mcs(rtwdev, data_rate);
-	} else if (data_rate_mode == DATA_RATE_MODE_HE) {
+	} else if (data_rate_mode == DATA_RATE_MODE_VHT ||
+		   data_rate_mode == DATA_RATE_MODE_HE ||
+		   data_rate_mode == DATA_RATE_MODE_EHT) {
 		rate_idx = rtw89_get_data_mcs(rtwdev, data_rate);
 	} else {
 		rtw89_warn(rtwdev, "invalid RX rate mode %d\n", data_rate_mode);
 	}
 
+	eht = data_rate_mode == DATA_RATE_MODE_EHT;
 	bw = rtw89_hw_to_rate_info_bw(desc_info->bw);
-	gi_ltf = rtw89_rxdesc_to_nl_he_gi(rtwdev, desc_info, false);
+	gi_ltf = rtw89_rxdesc_to_nl_he_eht_gi(rtwdev, desc_info->gi_ltf, false, eht);
 	ret = rtwdev->ppdu_sts.curr_rx_ppdu_cnt[band] == desc_info->ppdu_cnt &&
 	      status->rate_idx == rate_idx &&
-	      status->he_gi == gi_ltf &&
+	      rtw89_check_rx_statu_gi_match(status, gi_ltf, eht) &&
 	      status->bw == bw;
 
 	return ret;
@@ -2168,6 +2186,8 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 		rtw89_chandef_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u16 data_rate;
 	u8 data_rate_mode;
+	bool eht = false;
+	u8 gi;
 
 	/* currently using single PHY */
 	rx_status->freq = chandef->chan->center_freq;
@@ -2215,12 +2235,21 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 		rx_status->encoding = RX_ENC_HE;
 		rx_status->rate_idx = rtw89_get_data_mcs(rtwdev, data_rate);
 		rx_status->nss = rtw89_get_data_nss(rtwdev, data_rate) + 1;
+	} else if (data_rate_mode == DATA_RATE_MODE_EHT) {
+		rx_status->encoding = RX_ENC_EHT;
+		rx_status->rate_idx = rtw89_get_data_mcs(rtwdev, data_rate);
+		rx_status->nss = rtw89_get_data_nss(rtwdev, data_rate) + 1;
+		eht = true;
 	} else {
 		rtw89_warn(rtwdev, "invalid RX rate mode %d\n", data_rate_mode);
 	}
 
 	/* he_gi is used to match ppdu, so we always fill it. */
-	rx_status->he_gi = rtw89_rxdesc_to_nl_he_gi(rtwdev, desc_info, true);
+	gi = rtw89_rxdesc_to_nl_he_eht_gi(rtwdev, desc_info->gi_ltf, true, eht);
+	if (eht)
+		rx_status->eht.gi = gi;
+	else
+		rx_status->he_gi = gi;
 	rx_status->flag |= RX_FLAG_MACTIME_START;
 	rx_status->mactime = desc_info->free_run_cnt;
 
-- 
2.25.1

