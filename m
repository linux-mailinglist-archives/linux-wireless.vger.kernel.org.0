Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3BF2D715
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 09:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfE2HzB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 03:55:01 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37208 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfE2Hy7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 03:54:59 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4T7stb7005579, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4T7stb7005579
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Wed, 29 May 2019 15:54:55 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Wed, 29 May 2019 15:54:54 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 07/11] rtw88: correct power limit selection
Date:   Wed, 29 May 2019 15:54:43 +0800
Message-ID: <1559116487-5244-8-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

If phy rate is decreased, sub bandwidth may be chosen by RA.
We consider possible power limits and apply the min one;
otherwise, the tx power index may be larger than spec.

And we cross-reference power limits of vht and ht with
20/40M bandwidth in 5G to avoid values are not assigned.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c |  24 +++++++
 drivers/net/wireless/realtek/rtw88/main.h |  13 ++++
 drivers/net/wireless/realtek/rtw88/phy.c  | 102 +++++++++++++++++++++++++++---
 3 files changed, 131 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f1ea5aa..e7a74b0 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -198,15 +198,20 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 {
 	struct ieee80211_channel *channel = chandef->chan;
 	enum nl80211_chan_width width = chandef->width;
+	u8 *cch_by_bw = chan_params->cch_by_bw;
 	u32 primary_freq, center_freq;
 	u8 center_chan;
 	u8 bandwidth = RTW_CHANNEL_WIDTH_20;
 	u8 primary_chan_idx = 0;
+	u8 i;
 
 	center_chan = channel->hw_value;
 	primary_freq = channel->center_freq;
 	center_freq = chandef->center_freq1;
 
+	/* assign the center channel used while 20M bw is selected */
+	cch_by_bw[RTW_CHANNEL_WIDTH_20] = channel->hw_value;
+
 	switch (width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
 	case NL80211_CHAN_WIDTH_20:
@@ -233,6 +238,10 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 				primary_chan_idx = 3;
 				center_chan -= 6;
 			}
+			/* assign the center channel used
+			 * while 40M bw is selected
+			 */
+			cch_by_bw[RTW_CHANNEL_WIDTH_40] = center_chan + 4;
 		} else {
 			if (center_freq - primary_freq == 10) {
 				primary_chan_idx = 2;
@@ -241,6 +250,10 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 				primary_chan_idx = 4;
 				center_chan += 6;
 			}
+			/* assign the center channel used
+			 * while 40M bw is selected
+			 */
+			cch_by_bw[RTW_CHANNEL_WIDTH_40] = center_chan - 4;
 		}
 		break;
 	default:
@@ -251,6 +264,12 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 	chan_params->center_chan = center_chan;
 	chan_params->bandwidth = bandwidth;
 	chan_params->primary_chan_idx = primary_chan_idx;
+
+	/* assign the center channel used while current bw is selected */
+	cch_by_bw[bandwidth] = center_chan;
+
+	for (i = bandwidth + 1; i <= RTW_MAX_CHANNEL_WIDTH; i++)
+		cch_by_bw[i] = 0;
 }
 
 void rtw_set_channel(struct rtw_dev *rtwdev)
@@ -260,6 +279,7 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_channel_params ch_param;
 	u8 center_chan, bandwidth, primary_chan_idx;
+	u8 i;
 
 	rtw_get_channel_params(&hw->conf.chandef, &ch_param);
 	if (WARN(ch_param.center_chan == 0, "Invalid channel\n"))
@@ -272,6 +292,10 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
 	hal->current_band_width = bandwidth;
 	hal->current_channel = center_chan;
 	hal->current_band_type = center_chan > 14 ? RTW_BAND_5G : RTW_BAND_2G;
+
+	for (i = RTW_CHANNEL_WIDTH_20; i <= RTW_MAX_CHANNEL_WIDTH; i++)
+		hal->cch_by_bw[i] = ch_param.cch_by_bw[i];
+
 	chip->ops->set_channel(rtwdev, center_chan, bandwidth, primary_chan_idx);
 
 	rtw_phy_set_tx_power_level(rtwdev, center_chan);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 00fc77f..4feff37 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -62,6 +62,9 @@ enum rtw_supported_band {
 	RTW_BAND_MAX,
 };
 
+/* now, support upto 80M bw */
+#define RTW_MAX_CHANNEL_WIDTH RTW_CHANNEL_WIDTH_80
+
 enum rtw_bandwidth {
 	RTW_CHANNEL_WIDTH_20	= 0,
 	RTW_CHANNEL_WIDTH_40	= 1,
@@ -413,6 +416,10 @@ struct rtw_channel_params {
 	u8 center_chan;
 	u8 bandwidth;
 	u8 primary_chan_idx;
+	/* center channel by different available bandwidth,
+	 * val of (bw > current bandwidth) is invalid
+	 */
+	u8 cch_by_bw[RTW_MAX_CHANNEL_WIDTH + 1];
 };
 
 struct rtw_hw_reg {
@@ -973,6 +980,12 @@ struct rtw_hal {
 	u8 current_channel;
 	u8 current_band_width;
 	u8 current_band_type;
+
+	/* center channel for different available bandwidth,
+	 * val of (bw > current_band_width) is invalid
+	 */
+	u8 cch_by_bw[RTW_MAX_CHANNEL_WIDTH + 1];
+
 	u8 sec_ch_offset;
 	u8 rf_type;
 	u8 rf_path_num;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 91f8b61..840538f 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1193,6 +1193,70 @@ static void rtw_phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
 	}
 }
 
+/* cross-reference 5G power limits if values are not assigned */
+static void
+rtw_xref_5g_txpwr_lmt(struct rtw_dev *rtwdev, u8 regd,
+		      u8 bw, u8 ch_idx, u8 rs_ht, u8 rs_vht)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	s8 lmt_ht = hal->tx_pwr_limit_5g[regd][bw][rs_ht][ch_idx];
+	s8 lmt_vht = hal->tx_pwr_limit_5g[regd][bw][rs_vht][ch_idx];
+
+	if (lmt_ht == lmt_vht)
+		return;
+
+	if (lmt_ht == RTW_MAX_POWER_INDEX)
+		hal->tx_pwr_limit_5g[regd][bw][rs_ht][ch_idx] = lmt_vht;
+
+	else if (lmt_vht == RTW_MAX_POWER_INDEX)
+		hal->tx_pwr_limit_5g[regd][bw][rs_vht][ch_idx] = lmt_ht;
+}
+
+/* cross-reference power limits for ht and vht */
+static void
+rtw_xref_txpwr_lmt_by_rs(struct rtw_dev *rtwdev, u8 regd, u8 bw, u8 ch_idx)
+{
+	u8 rs_idx, rs_ht, rs_vht;
+	u8 rs_cmp[2][2] = {{RTW_RATE_SECTION_HT_1S, RTW_RATE_SECTION_VHT_1S},
+			   {RTW_RATE_SECTION_HT_2S, RTW_RATE_SECTION_VHT_2S} };
+
+	for (rs_idx = 0; rs_idx < 2; rs_idx++) {
+		rs_ht = rs_cmp[rs_idx][0];
+		rs_vht = rs_cmp[rs_idx][1];
+
+		rtw_xref_5g_txpwr_lmt(rtwdev, regd, bw, ch_idx, rs_ht, rs_vht);
+	}
+}
+
+/* cross-reference power limits for 5G channels */
+static void
+rtw_xref_5g_txpwr_lmt_by_ch(struct rtw_dev *rtwdev, u8 regd, u8 bw)
+{
+	u8 ch_idx;
+
+	for (ch_idx = 0; ch_idx < RTW_MAX_CHANNEL_NUM_5G; ch_idx++)
+		rtw_xref_txpwr_lmt_by_rs(rtwdev, regd, bw, ch_idx);
+}
+
+/* cross-reference power limits for 20/40M bandwidth */
+static void
+rtw_xref_txpwr_lmt_by_bw(struct rtw_dev *rtwdev, u8 regd)
+{
+	u8 bw;
+
+	for (bw = RTW_CHANNEL_WIDTH_20; bw <= RTW_CHANNEL_WIDTH_40; bw++)
+		rtw_xref_5g_txpwr_lmt_by_ch(rtwdev, regd, bw);
+}
+
+/* cross-reference power limits */
+static void rtw_xref_txpwr_lmt(struct rtw_dev *rtwdev)
+{
+	u8 regd;
+
+	for (regd = 0; regd < RTW_REGD_MAX; regd++)
+		rtw_xref_txpwr_lmt_by_bw(rtwdev, regd);
+}
+
 void rtw_parse_tbl_txpwr_lmt(struct rtw_dev *rtwdev,
 			     const struct rtw_table *tbl)
 {
@@ -1205,6 +1269,8 @@ void rtw_parse_tbl_txpwr_lmt(struct rtw_dev *rtwdev,
 		rtw_phy_set_tx_power_limit(rtwdev, p->regd, p->band,
 					   p->bw, p->rs, p->ch, p->txpwr_lmt);
 	}
+
+	rtw_xref_txpwr_lmt(rtwdev);
 }
 
 void rtw_phy_cfg_mac(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
@@ -1474,9 +1540,12 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 				     u8 rate, u8 channel, u8 regd)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
-	s8 power_limit;
+	u8 *cch_by_bw = hal->cch_by_bw;
+	s8 power_limit = RTW_MAX_POWER_INDEX;
 	u8 rs;
 	int ch_idx;
+	u8 cur_bw, cur_ch;
+	s8 cur_lmt;
 
 	if (regd > RTW_REGD_WW)
 		return RTW_MAX_POWER_INDEX;
@@ -1496,14 +1565,28 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 	else
 		goto err;
 
-	ch_idx = rtw_channel_to_idx(band, channel);
-	if (ch_idx < 0)
-		goto err;
+	/* only 20M BW with cck and ofdm */
+	if (rs == RTW_RATE_SECTION_CCK || rs == RTW_RATE_SECTION_OFDM)
+		bw = RTW_CHANNEL_WIDTH_20;
 
-	if (channel <= RTW_MAX_CHANNEL_NUM_2G)
-		power_limit = hal->tx_pwr_limit_2g[regd][bw][rs][ch_idx];
-	else
-		power_limit = hal->tx_pwr_limit_5g[regd][bw][rs][ch_idx];
+	/* only 20/40M BW with ht */
+	if (rs == RTW_RATE_SECTION_HT_1S || rs == RTW_RATE_SECTION_HT_2S)
+		bw = min_t(u8, bw, RTW_CHANNEL_WIDTH_40);
+
+	/* select min power limit among [20M BW ~ current BW] */
+	for (cur_bw = RTW_CHANNEL_WIDTH_20; cur_bw <= bw; cur_bw++) {
+		cur_ch = cch_by_bw[cur_bw];
+
+		ch_idx = rtw_channel_to_idx(band, cur_ch);
+		if (ch_idx < 0)
+			goto err;
+
+		cur_lmt = cur_ch <= RTW_MAX_CHANNEL_NUM_2G ?
+			hal->tx_pwr_limit_2g[regd][cur_bw][rs][ch_idx] :
+			hal->tx_pwr_limit_5g[regd][cur_bw][rs][ch_idx];
+
+		power_limit = min_t(s8, cur_lmt, power_limit);
+	}
 
 	return power_limit;
 
@@ -1688,6 +1771,9 @@ void rtw_phy_tx_power_limit_config(struct rtw_hal *hal)
 {
 	u8 regd, bw, rs;
 
+	/* default at channel 1 */
+	hal->cch_by_bw[RTW_CHANNEL_WIDTH_20] = 1;
+
 	for (regd = 0; regd < RTW_REGD_MAX; regd++)
 		for (bw = 0; bw < RTW_CHANNEL_WIDTH_MAX; bw++)
 			for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
-- 
2.7.4

