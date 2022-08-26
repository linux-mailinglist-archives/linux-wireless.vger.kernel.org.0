Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FD45A20AF
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 08:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbiHZGKm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 02:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241159AbiHZGKk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 02:10:40 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7842146200
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 23:10:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27Q6ADsW4002158, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27Q6ADsW4002158
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 26 Aug 2022 14:10:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 26 Aug 2022 14:10:28 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 26 Aug
 2022 14:10:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: no HTC field if TX rate might fallback to legacy
Date:   Fri, 26 Aug 2022 14:10:09 +0800
Message-ID: <20220826061011.9037-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 08/26/2022 05:47:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMjYgpFekyCAwMjoxNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

Packets containing HTC field with legacy rate could be dropped by AP. If
TX rate of report is lower than MCS2, hardware might fall back rate to
legacy. Therefore, add a checking rule to avoid HTC field in this
situation.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  |  4 ++++
 drivers/net/wireless/realtek/rtw89/core.h  |  1 +
 drivers/net/wireless/realtek/rtw89/debug.c |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c   | 20 ++++++++------------
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a5880a54812e7..f2402f60c8958 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -617,6 +617,7 @@ __rtw89_core_tx_check_he_qos_htc(struct rtw89_dev *rtwdev,
 				 enum btc_pkt_type pkt_type)
 {
 	struct ieee80211_sta *sta = tx_req->sta;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct sk_buff *skb = tx_req->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	__le16 fc = hdr->frame_control;
@@ -634,6 +635,9 @@ __rtw89_core_tx_check_he_qos_htc(struct rtw89_dev *rtwdev,
 	if (skb_headroom(skb) < IEEE80211_HT_CTL_LEN)
 		return false;
 
+	if (rtwsta && rtwsta->ra_report.might_fallback_legacy)
+		return false;
+
 	return true;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7a9d6f5d8a513..98aead2e8d34c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1911,6 +1911,7 @@ struct rtw89_ra_report {
 	struct rate_info txrate;
 	u32 bit_rate;
 	u16 hw_rate;
+	bool might_fallback_legacy;
 };
 
 DECLARE_EWMA(rssi, 10, 16);
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 829c61da99bb9..2f5799926cf22 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2305,6 +2305,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 			   he_gi_str[rate->he_gi] : "N/A");
 	else
 		seq_printf(m, "Legacy %d", rate->legacy);
+	seq_printf(m, "%s", rtwsta->ra_report.might_fallback_legacy ? " FB_G" : "");
 	seq_printf(m, "\t(hw_rate=0x%x)", rtwsta->ra_report.hw_rate);
 	seq_printf(m, "\t==> agg_wait=%d (%d)\n", rtwsta->max_agg_wait,
 		   sta->max_rc_amsdu_len);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 1532c0a6bbc44..96cbe812cd482 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -14,23 +14,14 @@
 static u16 get_max_amsdu_len(struct rtw89_dev *rtwdev,
 			     const struct rtw89_ra_report *report)
 {
-	const struct rate_info *txrate = &report->txrate;
 	u32 bit_rate = report->bit_rate;
-	u8 mcs;
 
 	/* lower than ofdm, do not aggregate */
 	if (bit_rate < 550)
 		return 1;
 
-	/* prevent hardware rate fallback to G mode rate */
-	if (txrate->flags & RATE_INFO_FLAGS_MCS)
-		mcs = txrate->mcs & 0x07;
-	else if (txrate->flags & (RATE_INFO_FLAGS_VHT_MCS | RATE_INFO_FLAGS_HE_MCS))
-		mcs = txrate->mcs;
-	else
-		mcs = 0;
-
-	if (mcs <= 2)
+	/* avoid AMSDU for legacy rate */
+	if (report->might_fallback_legacy)
 		return 1;
 
 	/* lower than 20M vht 2ss mcs8, make it small */
@@ -1920,6 +1911,7 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 	u8 mode, rate, bw, giltf, mac_id;
 	u16 legacy_bitrate;
 	bool valid;
+	u8 mcs = 0;
 
 	mac_id = RTW89_GET_PHY_C2H_RA_RPT_MACID(c2h->data);
 	if (mac_id != rtwsta->mac_id)
@@ -1936,7 +1928,7 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 			return;
 	}
 
-	memset(ra_report, 0, sizeof(*ra_report));
+	memset(&ra_report->txrate, 0, sizeof(ra_report->txrate));
 
 	switch (mode) {
 	case RTW89_RA_RPT_MODE_LEGACY:
@@ -1952,6 +1944,7 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 		ra_report->txrate.mcs = rate;
 		if (giltf)
 			ra_report->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		mcs = ra_report->txrate.mcs & 0x07;
 		break;
 	case RTW89_RA_RPT_MODE_VHT:
 		ra_report->txrate.flags |= RATE_INFO_FLAGS_VHT_MCS;
@@ -1959,6 +1952,7 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 		ra_report->txrate.nss = FIELD_GET(RTW89_RA_RATE_MASK_NSS, rate) + 1;
 		if (giltf)
 			ra_report->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		mcs = ra_report->txrate.mcs;
 		break;
 	case RTW89_RA_RPT_MODE_HE:
 		ra_report->txrate.flags |= RATE_INFO_FLAGS_HE_MCS;
@@ -1970,6 +1964,7 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 			ra_report->txrate.he_gi = NL80211_RATE_INFO_HE_GI_1_6;
 		else
 			ra_report->txrate.he_gi = NL80211_RATE_INFO_HE_GI_3_2;
+		mcs = ra_report->txrate.mcs;
 		break;
 	}
 
@@ -1977,6 +1972,7 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 	ra_report->bit_rate = cfg80211_calculate_bitrate(&ra_report->txrate);
 	ra_report->hw_rate = FIELD_PREP(RTW89_HW_RATE_MASK_MOD, mode) |
 			     FIELD_PREP(RTW89_HW_RATE_MASK_VAL, rate);
+	ra_report->might_fallback_legacy = mcs <= 2;
 	sta->max_rc_amsdu_len = get_max_amsdu_len(rtwdev, ra_report);
 	rtwsta->max_agg_wait = sta->max_rc_amsdu_len / 1500 - 1;
 }
-- 
2.25.1

