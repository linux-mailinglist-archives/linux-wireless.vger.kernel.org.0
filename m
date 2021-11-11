Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0195844D013
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 03:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhKKCkV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 21:40:21 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52888 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbhKKCkU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 21:40:20 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AB2bSY51008617, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AB2bSY51008617
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Nov 2021 10:37:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 11 Nov 2021 10:37:27 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 11 Nov
 2021 10:37:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH 2/2] rtw89: fix incorrect channel info during scan
Date:   Thu, 11 Nov 2021 10:37:06 +0800
Message-ID: <20211111023706.14154-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211111023706.14154-1-pkshih@realtek.com>
References: <20211111023706.14154-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/11/2021 02:24:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzExIKRXpMggMTI6MjM6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/11/2021 02:21:48
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167193 [Nov 11 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/11/2021 02:24:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po Hao Huang <phhuang@realtek.com>

We used to fill in rx skbs' frequency field by mac80211's current
channel value. In some cases, mac80211 switches channel before all
rx packets have been processed. This results in incorrect bss info.
We fix this by filling in frequency field with channel index obtained
from hardware, then fix potential cck missing issue by skb's original
hw rate. After all fix is done, convert hw rate back to the supported
band rate index.

Signed-off-by: Po Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  53 +++++++--
 drivers/net/wireless/realtek/rtw89/core.h     |   4 +
 drivers/net/wireless/realtek/rtw89/debug.c    |   2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 111 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  60 ++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      |  23 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  19 +++
 drivers/net/wireless/realtek/rtw89/txrx.h     |  45 +------
 8 files changed, 264 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 6c91e99fd28f1..2c079388a664e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -242,6 +242,7 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 
 	hal->current_band_width = bandwidth;
 	hal->current_channel = center_chan;
+	hal->prev_primary_channel = hal->current_primary_channel;
 	hal->current_primary_channel = ch_param.primary_chan;
 	hal->current_band_type = band_type;
 
@@ -881,8 +882,11 @@ static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev, u8 *addr,
 {
 	s16 cfo;
 
+	phy_ppdu->chan_idx = RTW89_GET_PHY_STS_IE01_CH_IDX(addr);
+	if (phy_ppdu->rate < RTW89_HW_RATE_OFDM6)
+		return;
 	/* sign conversion for S(12,2) */
-	cfo = sign_extend32(RTW89_GET_PHY_STS_IE0_CFO(addr), 11);
+	cfo = sign_extend32(RTW89_GET_PHY_STS_IE01_CFO(addr), 11);
 	rtw89_phy_cfo_parse(rtwdev, cfo, phy_ppdu);
 }
 
@@ -908,6 +912,7 @@ static void rtw89_core_update_phy_ppdu(struct rtw89_rx_phy_ppdu *phy_ppdu)
 	s8 *rssi = phy_ppdu->rssi;
 	u8 *buf = phy_ppdu->buf;
 
+	phy_ppdu->ie = RTW89_GET_PHY_STS_IE_MAP(buf);
 	phy_ppdu->rssi_avg = RTW89_GET_PHY_STS_RSSI_AVG(buf);
 	rssi[RF_PATH_A] = RTW89_RSSI_RAW_TO_DBM(RTW89_GET_PHY_STS_RSSI_A(buf));
 	rssi[RF_PATH_B] = RTW89_RSSI_RAW_TO_DBM(RTW89_GET_PHY_STS_RSSI_B(buf));
@@ -936,8 +941,9 @@ static int rtw89_core_rx_parse_phy_sts(struct rtw89_dev *rtwdev,
 	u16 ie_len;
 	u8 *pos, *end;
 
-	if (!phy_ppdu->to_self)
-		return 0;
+	/* mark invalid reports and bypass them */
+	if (phy_ppdu->ie < RTW89_CCK_PKT)
+		return -EINVAL;
 
 	pos = (u8 *)phy_ppdu->buf + PHY_STS_HDR_LEN;
 	end = (u8 *)phy_ppdu->buf + phy_ppdu->len;
@@ -1000,9 +1006,7 @@ static bool rtw89_core_rx_ppdu_match(struct rtw89_dev *rtwdev,
 	data_rate_mode = GET_DATA_RATE_MODE(data_rate);
 	if (data_rate_mode == DATA_RATE_MODE_NON_HT) {
 		rate_idx = GET_DATA_RATE_NOT_HT_IDX(data_rate);
-		/* No 4 CCK rates for 5G */
-		if (status->band == NL80211_BAND_5GHZ)
-			rate_idx -= 4;
+		/* rate_idx is still hardware value here */
 	} else if (data_rate_mode == DATA_RATE_MODE_HT) {
 		rate_idx = GET_DATA_RATE_HT_IDX(data_rate);
 	} else if (data_rate_mode == DATA_RATE_MODE_VHT) {
@@ -1081,6 +1085,29 @@ static void rtw89_core_rx_stats(struct rtw89_dev *rtwdev,
 	rtw89_iterate_vifs_bh(rtwdev, rtw89_vif_rx_stats_iter, &iter_data);
 }
 
+static void rtw89_correct_cck_chan(struct rtw89_dev *rtwdev,
+				   struct ieee80211_rx_status *status)
+{
+	u16 chan = rtwdev->hal.prev_primary_channel;
+	u8 band = chan <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+
+	if (status->band != NL80211_BAND_2GHZ &&
+	    status->encoding == RX_ENC_LEGACY &&
+	    status->rate_idx < RTW89_HW_RATE_OFDM6) {
+		status->freq = ieee80211_channel_to_frequency(chan, band);
+		status->band = band;
+	}
+}
+
+static void rtw89_core_hw_to_sband_rate(struct ieee80211_rx_status *rx_status)
+{
+	if (rx_status->band == NL80211_BAND_2GHZ ||
+	    rx_status->encoding != RX_ENC_LEGACY)
+		return;
+	/* No 4 CCK rates for non-2G */
+	rx_status->rate_idx -= 4;
+}
+
 static void rtw89_core_rx_pending_skb(struct rtw89_dev *rtwdev,
 				      struct rtw89_rx_phy_ppdu *phy_ppdu,
 				      struct rtw89_rx_desc_info *desc_info,
@@ -1099,6 +1126,8 @@ static void rtw89_core_rx_pending_skb(struct rtw89_dev *rtwdev,
 		rx_status = IEEE80211_SKB_RXCB(skb_ppdu);
 		if (rtw89_core_rx_ppdu_match(rtwdev, desc_info, rx_status))
 			rtw89_chip_query_ppdu(rtwdev, phy_ppdu, rx_status);
+		rtw89_correct_cck_chan(rtwdev, rx_status);
+		rtw89_core_hw_to_sband_rate(rx_status);
 		rtw89_core_rx_stats(rtwdev, phy_ppdu, desc_info, skb_ppdu);
 		ieee80211_rx_napi(rtwdev->hw, NULL, skb_ppdu, &rtwdev->napi);
 		rtwdev->napi_budget_countdown--;
@@ -1112,6 +1141,7 @@ static void rtw89_core_rx_process_ppdu_sts(struct rtw89_dev *rtwdev,
 	struct rtw89_rx_phy_ppdu phy_ppdu = {.buf = skb->data, .valid = false,
 					     .len = skb->len,
 					     .to_self = desc_info->addr1_match,
+					     .rate = desc_info->data_rate,
 					     .mac_id = desc_info->mac_id};
 	int ret;
 
@@ -1267,12 +1297,7 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 	if (data_rate_mode == DATA_RATE_MODE_NON_HT) {
 		rx_status->encoding = RX_ENC_LEGACY;
 		rx_status->rate_idx = GET_DATA_RATE_NOT_HT_IDX(data_rate);
-		/* No 4 CCK rates for 5G */
-		if (rx_status->band == NL80211_BAND_5GHZ)
-			rx_status->rate_idx -= 4;
-		if (rtwdev->scanning)
-			rx_status->rate_idx = min_t(u8, rx_status->rate_idx,
-						    ARRAY_SIZE(rtw89_bitrates) - 5);
+		/* convert rate_idx after we get the correct band */
 	} else if (data_rate_mode == DATA_RATE_MODE_HT) {
 		rx_status->encoding = RX_ENC_HT;
 		rx_status->rate_idx = GET_DATA_RATE_HT_IDX(data_rate);
@@ -1324,10 +1349,13 @@ static void rtw89_core_flush_ppdu_rx_queue(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_ppdu_sts_info *ppdu_sts = &rtwdev->ppdu_sts;
 	u8 band = desc_info->bb_sel ? RTW89_PHY_1 : RTW89_PHY_0;
+	struct ieee80211_rx_status *rx_status;
 	struct sk_buff *skb_ppdu, *tmp;
 
 	skb_queue_walk_safe(&ppdu_sts->rx_queue[band], skb_ppdu, tmp) {
 		skb_unlink(skb_ppdu, &ppdu_sts->rx_queue[band]);
+		rx_status = IEEE80211_SKB_RXCB(skb_ppdu);
+		rtw89_core_hw_to_sband_rate(rx_status);
 		rtw89_core_rx_stats(rtwdev, NULL, desc_info, skb_ppdu);
 		ieee80211_rx_napi(rtwdev->hw, NULL, skb_ppdu, &rtwdev->napi);
 		rtwdev->napi_budget_countdown--;
@@ -1360,6 +1388,7 @@ void rtw89_core_rx(struct rtw89_dev *rtwdev,
 	    BIT(desc_info->frame_type) & PPDU_FILTER_BITMAP) {
 		skb_queue_tail(&ppdu_sts->rx_queue[band], skb);
 	} else {
+		rtw89_core_hw_to_sband_rate(rx_status);
 		rtw89_core_rx_stats(rtwdev, NULL, desc_info, skb);
 		ieee80211_rx_napi(rtwdev->hw, NULL, skb, &rtwdev->napi);
 		rtwdev->napi_budget_countdown--;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c2885e4dd882f..01cc6d9ce428b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -472,6 +472,9 @@ struct rtw89_rx_phy_ppdu {
 	u8 rssi_avg;
 	s8 rssi[RF_PATH_MAX];
 	u8 mac_id;
+	u8 chan_idx;
+	u8 ie;
+	u16 rate;
 	bool to_self;
 	bool valid;
 };
@@ -2354,6 +2357,7 @@ struct rtw89_hal {
 	u32 rx_fltr;
 	u8 cv;
 	u8 current_channel;
+	u8 prev_primary_channel;
 	u8 current_primary_channel;
 	enum rtw89_subband current_subband;
 	u8 current_band_width;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 29eb188c888c7..6402bca413cb8 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2280,7 +2280,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	switch (status->encoding) {
 	case RX_ENC_LEGACY:
 		seq_printf(m, "Legacy %d", status->rate_idx +
-			   (status->band == NL80211_BAND_5GHZ ? 4 : 0));
+			   (status->band != NL80211_BAND_2GHZ ? 4 : 0));
 		break;
 	case RX_ENC_HT:
 		seq_printf(m, "HT MCS-%d%s", status->rate_idx,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ab134856baac7..29eb087475932 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2404,6 +2404,116 @@ void rtw89_phy_env_monitor_track(struct rtw89_dev *rtwdev)
 		    env->ccx_watchdog_result, chk_result);
 }
 
+static bool rtw89_physts_ie_page_valid(enum rtw89_phy_status_bitmap *ie_page)
+{
+	if (*ie_page > RTW89_PHYSTS_BITMAP_NUM ||
+	    *ie_page == RTW89_RSVD_9)
+		return false;
+	else if (*ie_page > RTW89_RSVD_9)
+		*ie_page -= 1;
+
+	return true;
+}
+
+static u32 rtw89_phy_get_ie_bitmap_addr(enum rtw89_phy_status_bitmap ie_page)
+{
+	static const u8 ie_page_shift = 2;
+
+	return R_PHY_STS_BITMAP_ADDR_START + (ie_page << ie_page_shift);
+}
+
+static u32 rtw89_physts_get_ie_bitmap(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_status_bitmap ie_page)
+{
+	u32 addr;
+
+	if (!rtw89_physts_ie_page_valid(&ie_page))
+		return 0;
+
+	addr = rtw89_phy_get_ie_bitmap_addr(ie_page);
+
+	return rtw89_phy_read32(rtwdev, addr);
+}
+
+static void rtw89_physts_set_ie_bitmap(struct rtw89_dev *rtwdev,
+				       enum rtw89_phy_status_bitmap ie_page,
+				       u32 val)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 addr;
+
+	if (!rtw89_physts_ie_page_valid(&ie_page))
+		return;
+
+	if (chip->chip_id == RTL8852A)
+		val &= B_PHY_STS_BITMAP_MSK_52A;
+
+	addr = rtw89_phy_get_ie_bitmap_addr(ie_page);
+	rtw89_phy_write32(rtwdev, addr, val);
+}
+
+static void rtw89_physts_enable_ie_bitmap(struct rtw89_dev *rtwdev,
+					  enum rtw89_phy_status_bitmap bitmap,
+					  enum rtw89_phy_status_ie_type ie,
+					  bool enable)
+{
+	u32 val = rtw89_physts_get_ie_bitmap(rtwdev, bitmap);
+
+	if (enable)
+		val |= BIT(ie);
+	else
+		val &= ~BIT(ie);
+
+	rtw89_physts_set_ie_bitmap(rtwdev, bitmap, val);
+}
+
+static void rtw89_physts_enable_fail_report(struct rtw89_dev *rtwdev,
+					    bool enable,
+					    enum rtw89_phy_idx phy_idx)
+{
+	if (enable) {
+		rtw89_phy_write32_clr(rtwdev, R_PLCP_HISTOGRAM,
+				      B_STS_DIS_TRIG_BY_FAIL);
+		rtw89_phy_write32_clr(rtwdev, R_PLCP_HISTOGRAM,
+				      B_STS_DIS_TRIG_BY_BRK);
+	} else {
+		rtw89_phy_write32_set(rtwdev, R_PLCP_HISTOGRAM,
+				      B_STS_DIS_TRIG_BY_FAIL);
+		rtw89_phy_write32_set(rtwdev, R_PLCP_HISTOGRAM,
+				      B_STS_DIS_TRIG_BY_BRK);
+	}
+}
+
+static void rtw89_physts_parsing_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 i;
+
+	if (chip->chip_id == RTL8852A && rtwdev->hal.cv == CHIP_CBV)
+		rtw89_physts_enable_fail_report(rtwdev, false, RTW89_PHY_0);
+
+	for (i = 0; i < RTW89_PHYSTS_BITMAP_NUM; i++) {
+		if (i >= RTW89_CCK_PKT)
+			rtw89_physts_enable_ie_bitmap(rtwdev, i,
+						      RTW89_PHYSTS_IE09_FTR_0,
+						      true);
+		if ((i >= RTW89_CCK_BRK && i <= RTW89_VHT_MU) ||
+		    (i >= RTW89_RSVD_9 && i <= RTW89_CCK_PKT))
+			continue;
+		rtw89_physts_enable_ie_bitmap(rtwdev, i,
+					      RTW89_PHYSTS_IE24_OFDM_TD_PATH_A,
+					      true);
+	}
+	rtw89_physts_enable_ie_bitmap(rtwdev, RTW89_VHT_PKT,
+				      RTW89_PHYSTS_IE13_DL_MU_DEF, true);
+	rtw89_physts_enable_ie_bitmap(rtwdev, RTW89_HE_PKT,
+				      RTW89_PHYSTS_IE13_DL_MU_DEF, true);
+
+	/* force IE01 for channel index, only channel field is valid */
+	rtw89_physts_enable_ie_bitmap(rtwdev, RTW89_CCK_PKT,
+				      RTW89_PHYSTS_IE01_CMN_OFDM, true);
+}
+
 static void rtw89_phy_dig_read_gain_table(struct rtw89_dev *rtwdev, int type)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -2839,6 +2949,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 	rtw89_chip_bb_sethw(rtwdev);
 
 	rtw89_phy_env_monitor_init(rtwdev);
+	rtw89_physts_parsing_init(rtwdev);
 	rtw89_phy_dig_init(rtwdev);
 	rtw89_phy_cfo_init(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 370129345e0f7..b1f059b725a10 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -134,6 +134,66 @@ enum rtw89_ccx_unit {
 	RTW89_CCX_32_US = 3
 };
 
+enum rtw89_phy_status_ie_type {
+	RTW89_PHYSTS_IE00_CMN_CCK			= 0,
+	RTW89_PHYSTS_IE01_CMN_OFDM			= 1,
+	RTW89_PHYSTS_IE02_CMN_EXT_AX			= 2,
+	RTW89_PHYSTS_IE03_CMN_EXT_SEG_1			= 3,
+	RTW89_PHYSTS_IE04_CMN_EXT_PATH_A		= 4,
+	RTW89_PHYSTS_IE05_CMN_EXT_PATH_B		= 5,
+	RTW89_PHYSTS_IE06_CMN_EXT_PATH_C		= 6,
+	RTW89_PHYSTS_IE07_CMN_EXT_PATH_D		= 7,
+	RTW89_PHYSTS_IE08_FTR_CH			= 8,
+	RTW89_PHYSTS_IE09_FTR_0				= 9,
+	RTW89_PHYSTS_IE10_FTR_PLCP_EXT			= 10,
+	RTW89_PHYSTS_IE11_FTR_PLCP_HISTOGRAM		= 11,
+	RTW89_PHYSTS_IE12_MU_EIGEN_INFO			= 12,
+	RTW89_PHYSTS_IE13_DL_MU_DEF			= 13,
+	RTW89_PHYSTS_IE14_TB_UL_CQI			= 14,
+	RTW89_PHYSTS_IE15_TB_UL_DEF			= 15,
+	RTW89_PHYSTS_IE16_RSVD16			= 16,
+	RTW89_PHYSTS_IE17_TB_UL_CTRL			= 17,
+	RTW89_PHYSTS_IE18_DBG_OFDM_FD_CMN		= 18,
+	RTW89_PHYSTS_IE19_DBG_OFDM_TD_CMN		= 19,
+	RTW89_PHYSTS_IE20_DBG_OFDM_FD_USER_SEG_0	= 20,
+	RTW89_PHYSTS_IE21_DBG_OFDM_FD_USER_SEG_1	= 21,
+	RTW89_PHYSTS_IE22_DBG_OFDM_FD_USER_AGC		= 22,
+	RTW89_PHYSTS_IE23_RSVD23			= 23,
+	RTW89_PHYSTS_IE24_OFDM_TD_PATH_A		= 24,
+	RTW89_PHYSTS_IE25_OFDM_TD_PATH_B		= 25,
+	RTW89_PHYSTS_IE26_OFDM_TD_PATH_C		= 26,
+	RTW89_PHYSTS_IE27_OFDM_TD_PATH_D		= 27,
+	RTW89_PHYSTS_IE28_DBG_CCK_PATH_A		= 28,
+	RTW89_PHYSTS_IE29_DBG_CCK_PATH_B		= 29,
+	RTW89_PHYSTS_IE30_DBG_CCK_PATH_C		= 30,
+	RTW89_PHYSTS_IE31_DBG_CCK_PATH_D		= 31,
+
+	/* keep last */
+	RTW89_PHYSTS_IE_NUM,
+	RTW89_PHYSTS_IE_MAX = RTW89_PHYSTS_IE_NUM - 1
+};
+
+enum rtw89_phy_status_bitmap {
+	RTW89_TD_SEARCH_FAIL  = 0,
+	RTW89_BRK_BY_TX_PKT   = 1,
+	RTW89_CCA_SPOOF       = 2,
+	RTW89_OFDM_BRK        = 3,
+	RTW89_CCK_BRK         = 4,
+	RTW89_DL_MU_SPOOFING  = 5,
+	RTW89_HE_MU           = 6,
+	RTW89_VHT_MU          = 7,
+	RTW89_UL_TB_SPOOFING  = 8,
+	RTW89_RSVD_9          = 9,
+	RTW89_TRIG_BASE_PPDU  = 10,
+	RTW89_CCK_PKT         = 11,
+	RTW89_LEGACY_OFDM_PKT = 12,
+	RTW89_HT_PKT          = 13,
+	RTW89_VHT_PKT         = 14,
+	RTW89_HE_PKT          = 15,
+
+	RTW89_PHYSTS_BITMAP_NUM
+};
+
 enum rtw89_dig_gain_type {
 	RTW89_DIG_GAIN_LNA_G = 0,
 	RTW89_DIG_GAIN_TIA_G = 1,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 365d8c8ce57b9..b6049009f183b 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1674,6 +1674,29 @@
 #define B_UPD_CLK_ADC_VAL GENMASK(26, 25)
 #define R_RSTB_ASYNC 0x0704
 #define B_RSTB_ASYNC_ALL BIT(1)
+#define R_MAC_PIN_SEL 0x0734
+#define B_CH_IDX_SEG0 GENMASK(23, 16)
+#define R_PLCP_HISTOGRAM 0x0738
+#define B_STS_DIS_TRIG_BY_BRK BIT(2)
+#define B_STS_DIS_TRIG_BY_FAIL BIT(3)
+#define R_PHY_STS_BITMAP_ADDR_START R_PHY_STS_BITMAP_SEARCH_FAIL
+#define B_PHY_STS_BITMAP_ADDR_MASK GENMASK(6, 2)
+#define R_PHY_STS_BITMAP_SEARCH_FAIL 0x073C
+#define B_PHY_STS_BITMAP_MSK_52A 0x337cff3f
+#define R_PHY_STS_BITMAP_R2T 0x0740
+#define R_PHY_STS_BITMAP_CCA_SPOOF 0x0744
+#define R_PHY_STS_BITMAP_OFDM_BRK 0x0748
+#define R_PHY_STS_BITMAP_CCK_BRK 0x074C
+#define R_PHY_STS_BITMAP_DL_MU_SPOOF 0x0750
+#define R_PHY_STS_BITMAP_HE_MU 0x0754
+#define R_PHY_STS_BITMAP_VHT_MU 0x0758
+#define R_PHY_STS_BITMAP_UL_TB_SPOOF 0x075C
+#define R_PHY_STS_BITMAP_TRIGBASE 0x0760
+#define R_PHY_STS_BITMAP_CCK 0x0764
+#define R_PHY_STS_BITMAP_LEGACY 0x0768
+#define R_PHY_STS_BITMAP_HT 0x076C
+#define R_PHY_STS_BITMAP_VHT 0x0770
+#define R_PHY_STS_BITMAP_HE 0x0774
 #define R_PMAC_GNT 0x0980
 #define B_PMAC_GNT_TXEN BIT(0)
 #define B_PMAC_GNT_RXEN BIT(16)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 5c6ffca3a324e..445236531ad6d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1069,6 +1069,8 @@ static void rtw8852a_set_channel_bb(struct rtw89_dev *rtwdev,
 		rtw8852a_bbrst_for_rfk(rtwdev, phy_idx);
 	}
 	rtw8852a_spur_elimination(rtwdev, param->center_chan);
+	rtw89_phy_write32_mask(rtwdev, R_MAC_PIN_SEL, B_CH_IDX_SEG0,
+			       param->primary_chan);
 	rtw8852a_bb_reset_all(rtwdev, phy_idx);
 }
 
@@ -1927,6 +1929,21 @@ void rtw8852a_btc_wl_s1_standby(struct rtw89_dev *rtwdev, bool state)
 	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
 }
 
+static void rtw8852a_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
+					 struct rtw89_rx_phy_ppdu *phy_ppdu,
+					 struct ieee80211_rx_status *status)
+{
+	u16 chan = phy_ppdu->chan_idx;
+	u8 band;
+
+	if (chan == 0)
+		return;
+
+	band = chan <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+	status->freq = ieee80211_channel_to_frequency(chan, band);
+	status->band = band;
+}
+
 static void rtw8852a_query_ppdu(struct rtw89_dev *rtwdev,
 				struct rtw89_rx_phy_ppdu *phy_ppdu,
 				struct ieee80211_rx_status *status)
@@ -1939,6 +1956,8 @@ static void rtw8852a_query_ppdu(struct rtw89_dev *rtwdev,
 		status->chains |= BIT(path);
 		status->chain_signal[path] = rx_power[path];
 	}
+	if (phy_ppdu->valid)
+		rtw8852a_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
 }
 
 static const struct rtw89_chip_ops rtw8852a_chip_ops = {
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 5570d8ccf136a..75b11249f3065 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -168,6 +168,8 @@
 #define RTW89_GET_RXINFO_MACID(rpt, usr) \
 	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), GENMASK(15, 8))
 
+#define RTW89_GET_PHY_STS_IE_MAP(sts) \
+	le32_get_bits(*((const __le32 *)(sts)), GENMASK(4, 0))
 #define RTW89_GET_PHY_STS_RSSI_A(sts) \
 	le32_get_bits(*((const __le32 *)(sts) + 1), GENMASK(7, 0))
 #define RTW89_GET_PHY_STS_RSSI_B(sts) \
@@ -184,7 +186,9 @@
 	le32_get_bits(*((const __le32 *)ie), GENMASK(4, 0))
 #define RTW89_GET_PHY_STS_IE_LEN(ie) \
 	le32_get_bits(*((const __le32 *)ie), GENMASK(11, 5))
-#define RTW89_GET_PHY_STS_IE0_CFO(ie) \
+#define RTW89_GET_PHY_STS_IE01_CH_IDX(ie) \
+	le32_get_bits(*((const __le32 *)ie), GENMASK(23, 16))
+#define RTW89_GET_PHY_STS_IE01_CFO(ie) \
 	le32_get_bits(*((const __le32 *)(ie) + 1), GENMASK(31, 20))
 
 enum rtw89_tx_channel {
@@ -251,45 +255,6 @@ enum rtw89_tx_qsel {
 	/* reserved */
 };
 
-enum rtw89_phy_status_ie_type {
-	RTW89_PHYSTS_IE00_CMN_CCK			= 0,
-	RTW89_PHYSTS_IE01_CMN_OFDM			= 1,
-	RTW89_PHYSTS_IE02_CMN_EXT_AX			= 2,
-	RTW89_PHYSTS_IE03_CMN_EXT_SEG_1			= 3,
-	RTW89_PHYSTS_IE04_CMN_EXT_PATH_A		= 4,
-	RTW89_PHYSTS_IE05_CMN_EXT_PATH_B		= 5,
-	RTW89_PHYSTS_IE06_CMN_EXT_PATH_C		= 6,
-	RTW89_PHYSTS_IE07_CMN_EXT_PATH_D		= 7,
-	RTW89_PHYSTS_IE08_FTR_CH			= 8,
-	RTW89_PHYSTS_IE09_FTR_PLCP_0			= 9,
-	RTW89_PHYSTS_IE10_FTR_PLCP_EXT			= 10,
-	RTW89_PHYSTS_IE11_FTR_PLCP_HISTOGRAM		= 11,
-	RTW89_PHYSTS_IE12_MU_EIGEN_INFO			= 12,
-	RTW89_PHYSTS_IE13_DL_MU_DEF			= 13,
-	RTW89_PHYSTS_IE14_TB_UL_CQI			= 14,
-	RTW89_PHYSTS_IE15_TB_UL_DEF			= 15,
-	RTW89_PHYSTS_IE16_RSVD16			= 16,
-	RTW89_PHYSTS_IE17_TB_UL_CTRL			= 17,
-	RTW89_PHYSTS_IE18_DBG_OFDM_FD_CMN		= 18,
-	RTW89_PHYSTS_IE19_DBG_OFDM_TD_CMN		= 19,
-	RTW89_PHYSTS_IE20_DBG_OFDM_FD_USER_SEG_0	= 20,
-	RTW89_PHYSTS_IE21_DBG_OFDM_FD_USER_SEG_1	= 21,
-	RTW89_PHYSTS_IE22_DBG_OFDM_FD_USER_AGC		= 22,
-	RTW89_PHYSTS_IE23_RSVD23			= 23,
-	RTW89_PHYSTS_IE24_DBG_OFDM_TD_PATH_A		= 24,
-	RTW89_PHYSTS_IE25_DBG_OFDM_TD_PATH_B		= 25,
-	RTW89_PHYSTS_IE26_DBG_OFDM_TD_PATH_C		= 26,
-	RTW89_PHYSTS_IE27_DBG_OFDM_TD_PATH_D		= 27,
-	RTW89_PHYSTS_IE28_DBG_CCK_PATH_A		= 28,
-	RTW89_PHYSTS_IE29_DBG_CCK_PATH_B		= 29,
-	RTW89_PHYSTS_IE30_DBG_CCK_PATH_C		= 30,
-	RTW89_PHYSTS_IE31_DBG_CCK_PATH_D		= 31,
-
-	/* keep last */
-	RTW89_PHYSTS_IE_NUM,
-	RTW89_PHYSTS_IE_MAX = RTW89_PHYSTS_IE_NUM - 1
-};
-
 static inline u8 rtw89_core_get_qsel(struct rtw89_dev *rtwdev, u8 tid)
 {
 	switch (tid) {
-- 
2.25.1

