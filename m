Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD1758D58F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbiHIIls (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 04:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240969AbiHIIlm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 04:41:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FB8A1E3E3
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 01:41:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2798fFmU5006244, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2798fFmU5006244
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 9 Aug 2022 16:41:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 16:41:25 +0800
Received: from localhost (172.16.16.191) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Aug 2022
 16:41:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/7] wifi: rtw88: add the update channel flow to support setting by parameters
Date:   Tue, 9 Aug 2022 16:41:03 +0800
Message-ID: <20220809084107.38137-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809084107.38137-1-pkshih@realtek.com>
References: <20220809084107.38137-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.191]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/09/2022 08:22:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvOSCkV6TIIDA2OjU1OjAw?=
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

From: Chih-Kang Chang <gary.chang@realtek.com>

In order to set channel info to hal during HW scan, we add the update
channel flow to support setting by parameters to meet the HW scan
requriement.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 164 +++++++++++++---------
 drivers/net/wireless/realtek/rtw88/main.h |  24 +++-
 2 files changed, 116 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 381f258835a7e..790dcfed1125d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -675,67 +675,127 @@ void rtw_set_dtim_period(struct rtw_dev *rtwdev, int dtim_period)
 	rtw_write8(rtwdev, REG_DTIM_COUNTER_ROOT, dtim_period - 1);
 }
 
+void rtw_update_channel(struct rtw_dev *rtwdev, u8 center_channel,
+			u8 primary_channel, enum rtw_supported_band band,
+			enum rtw_bandwidth bandwidth)
+{
+	enum nl80211_band nl_band = rtw_hw_to_nl80211_band(band);
+	struct rtw_hal *hal = &rtwdev->hal;
+	u8 *cch_by_bw = hal->cch_by_bw;
+	u32 center_freq, primary_freq;
+	enum rtw_sar_bands sar_band;
+	u8 primary_channel_idx;
+
+	center_freq = ieee80211_channel_to_frequency(center_channel, nl_band);
+	primary_freq = ieee80211_channel_to_frequency(primary_channel, nl_band);
+
+	/* assign the center channel used while 20M bw is selected */
+	cch_by_bw[RTW_CHANNEL_WIDTH_20] = primary_channel;
+
+	/* assign the center channel used while current bw is selected */
+	cch_by_bw[bandwidth] = center_channel;
+
+	switch (bandwidth) {
+	case RTW_CHANNEL_WIDTH_20:
+		primary_channel_idx = RTW_SC_DONT_CARE;
+		break;
+	case RTW_CHANNEL_WIDTH_40:
+		if (primary_freq > center_freq)
+			primary_channel_idx = RTW_SC_20_UPPER;
+		else
+			primary_channel_idx = RTW_SC_20_LOWER;
+		break;
+	case RTW_CHANNEL_WIDTH_80:
+		if (primary_freq > center_freq) {
+			if (primary_freq - center_freq == 10)
+				primary_channel_idx = RTW_SC_20_UPPER;
+			else
+				primary_channel_idx = RTW_SC_20_UPMOST;
+
+			/* assign the center channel used
+			 * while 40M bw is selected
+			 */
+			cch_by_bw[RTW_CHANNEL_WIDTH_40] = center_channel + 4;
+		} else {
+			if (center_freq - primary_freq == 10)
+				primary_channel_idx = RTW_SC_20_LOWER;
+			else
+				primary_channel_idx = RTW_SC_20_LOWEST;
+
+			/* assign the center channel used
+			 * while 40M bw is selected
+			 */
+			cch_by_bw[RTW_CHANNEL_WIDTH_40] = center_channel - 4;
+		}
+		break;
+	default:
+		break;
+	}
+
+	switch (center_channel) {
+	case 1 ... 14:
+		sar_band = RTW_SAR_BAND_0;
+		break;
+	case 36 ... 64:
+		sar_band = RTW_SAR_BAND_1;
+		break;
+	case 100 ... 144:
+		sar_band = RTW_SAR_BAND_3;
+		break;
+	case 149 ... 177:
+		sar_band = RTW_SAR_BAND_4;
+		break;
+	default:
+		WARN(1, "unknown ch(%u) to SAR band\n", center_channel);
+		sar_band = RTW_SAR_BAND_0;
+		break;
+	}
+
+	hal->current_primary_channel_index = primary_channel_idx;
+	hal->current_band_width = bandwidth;
+	hal->primary_channel = primary_channel;
+	hal->current_channel = center_channel;
+	hal->current_band_type = band;
+	hal->sar_band = sar_band;
+}
+
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *chan_params)
 {
 	struct ieee80211_channel *channel = chandef->chan;
 	enum nl80211_chan_width width = chandef->width;
-	u8 *cch_by_bw = chan_params->cch_by_bw;
 	u32 primary_freq, center_freq;
 	u8 center_chan;
 	u8 bandwidth = RTW_CHANNEL_WIDTH_20;
-	u8 primary_chan_idx = 0;
-	u8 i;
 
 	center_chan = channel->hw_value;
 	primary_freq = channel->center_freq;
 	center_freq = chandef->center_freq1;
 
-	/* assign the center channel used while 20M bw is selected */
-	cch_by_bw[RTW_CHANNEL_WIDTH_20] = channel->hw_value;
-
 	switch (width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
 	case NL80211_CHAN_WIDTH_20:
 		bandwidth = RTW_CHANNEL_WIDTH_20;
-		primary_chan_idx = RTW_SC_DONT_CARE;
 		break;
 	case NL80211_CHAN_WIDTH_40:
 		bandwidth = RTW_CHANNEL_WIDTH_40;
-		if (primary_freq > center_freq) {
-			primary_chan_idx = RTW_SC_20_UPPER;
+		if (primary_freq > center_freq)
 			center_chan -= 2;
-		} else {
-			primary_chan_idx = RTW_SC_20_LOWER;
+		else
 			center_chan += 2;
-		}
 		break;
 	case NL80211_CHAN_WIDTH_80:
 		bandwidth = RTW_CHANNEL_WIDTH_80;
 		if (primary_freq > center_freq) {
-			if (primary_freq - center_freq == 10) {
-				primary_chan_idx = RTW_SC_20_UPPER;
+			if (primary_freq - center_freq == 10)
 				center_chan -= 2;
-			} else {
-				primary_chan_idx = RTW_SC_20_UPMOST;
+			else
 				center_chan -= 6;
-			}
-			/* assign the center channel used
-			 * while 40M bw is selected
-			 */
-			cch_by_bw[RTW_CHANNEL_WIDTH_40] = center_chan + 4;
 		} else {
-			if (center_freq - primary_freq == 10) {
-				primary_chan_idx = RTW_SC_20_LOWER;
+			if (center_freq - primary_freq == 10)
 				center_chan += 2;
-			} else {
-				primary_chan_idx = RTW_SC_20_LOWEST;
+			else
 				center_chan += 6;
-			}
-			/* assign the center channel used
-			 * while 40M bw is selected
-			 */
-			cch_by_bw[RTW_CHANNEL_WIDTH_40] = center_chan - 4;
 		}
 		break;
 	default:
@@ -745,13 +805,7 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 
 	chan_params->center_chan = center_chan;
 	chan_params->bandwidth = bandwidth;
-	chan_params->primary_chan_idx = primary_chan_idx;
-
-	/* assign the center channel used while current bw is selected */
-	cch_by_bw[bandwidth] = center_chan;
-
-	for (i = bandwidth + 1; i <= RTW_MAX_CHANNEL_WIDTH; i++)
-		cch_by_bw[i] = 0;
+	chan_params->primary_chan = channel->hw_value;
 }
 
 void rtw_set_channel(struct rtw_dev *rtwdev)
@@ -760,45 +814,21 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_channel_params ch_param;
-	u8 center_chan, bandwidth, primary_chan_idx;
-	u8 i;
+	u8 center_chan, primary_chan, bandwidth, band;
 
 	rtw_get_channel_params(&hw->conf.chandef, &ch_param);
 	if (WARN(ch_param.center_chan == 0, "Invalid channel\n"))
 		return;
 
 	center_chan = ch_param.center_chan;
+	primary_chan = ch_param.primary_chan;
 	bandwidth = ch_param.bandwidth;
-	primary_chan_idx = ch_param.primary_chan_idx;
-
-	hal->current_band_width = bandwidth;
-	hal->current_channel = center_chan;
-	hal->current_primary_channel_index = primary_chan_idx;
-	hal->current_band_type = center_chan > 14 ? RTW_BAND_5G : RTW_BAND_2G;
-
-	switch (center_chan) {
-	case 1 ... 14:
-		hal->sar_band = RTW_SAR_BAND_0;
-		break;
-	case 36 ... 64:
-		hal->sar_band = RTW_SAR_BAND_1;
-		break;
-	case 100 ... 144:
-		hal->sar_band = RTW_SAR_BAND_3;
-		break;
-	case 149 ... 177:
-		hal->sar_band = RTW_SAR_BAND_4;
-		break;
-	default:
-		WARN(1, "unknown ch(%u) to SAR band\n", center_chan);
-		hal->sar_band = RTW_SAR_BAND_0;
-		break;
-	}
+	band = ch_param.center_chan > 14 ? RTW_BAND_5G : RTW_BAND_2G;
 
-	for (i = RTW_CHANNEL_WIDTH_20; i <= RTW_MAX_CHANNEL_WIDTH; i++)
-		hal->cch_by_bw[i] = ch_param.cch_by_bw[i];
+	rtw_update_channel(rtwdev, center_chan, primary_chan, band, bandwidth);
 
-	chip->ops->set_channel(rtwdev, center_chan, bandwidth, primary_chan_idx);
+	chip->ops->set_channel(rtwdev, center_chan, bandwidth,
+			       hal->current_primary_channel_index);
 
 	if (hal->current_band_type == RTW_BAND_5G) {
 		rtw_coex_switchband_notify(rtwdev, COEX_SWITCH_TO_5G);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index b3a7969b2b81c..e15d35f2c5957 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -510,12 +510,8 @@ struct rtw_timer_list {
 
 struct rtw_channel_params {
 	u8 center_chan;
+	u8 primary_chan;
 	u8 bandwidth;
-	u8 primary_chan_idx;
-	/* center channel by different available bandwidth,
-	 * val of (bw > current bandwidth) is invalid
-	 */
-	u8 cch_by_bw[RTW_MAX_CHANNEL_WIDTH + 1];
 };
 
 struct rtw_hw_reg {
@@ -1898,6 +1894,7 @@ struct rtw_hal {
 	u8 current_primary_channel_index;
 	u8 current_band_width;
 	u8 current_band_type;
+	u8 primary_channel;
 
 	/* center channel for different available bandwidth,
 	 * val of (bw > current_band_width) is invalid
@@ -2134,6 +2131,20 @@ static inline int rtw_chip_dump_fw_crash(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+static inline
+enum nl80211_band rtw_hw_to_nl80211_band(enum rtw_supported_band hw_band)
+{
+	switch (hw_band) {
+	default:
+	case RTW_BAND_2G:
+		return NL80211_BAND_2GHZ;
+	case RTW_BAND_5G:
+		return NL80211_BAND_5GHZ;
+	case RTW_BAND_60G:
+		return NL80211_BAND_60GHZ;
+	}
+}
+
 void rtw_set_rx_freq_band(struct rtw_rx_pkt_stat *pkt_stat, u8 channel);
 void rtw_set_dtim_period(struct rtw_dev *rtwdev, int dtim_period);
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
@@ -2175,4 +2186,7 @@ int rtw_dump_fw(struct rtw_dev *rtwdev, const u32 ocp_src, u32 size,
 		u32 fwcd_item);
 int rtw_dump_reg(struct rtw_dev *rtwdev, const u32 addr, const u32 size);
 void rtw_set_txrx_1ss(struct rtw_dev *rtwdev, bool config_1ss);
+void rtw_update_channel(struct rtw_dev *rtwdev, u8 center_channel,
+			u8 primary_channel, enum rtw_supported_band band,
+			enum rtw_bandwidth bandwidth);
 #endif
-- 
2.25.1

