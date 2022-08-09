Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B771458D79B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 12:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbiHIKul (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 06:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbiHIKua (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 06:50:30 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E47702DCE
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 03:50:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 279AoAHm9018837, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 279AoAHm9018837
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 9 Aug 2022 18:50:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 9 Aug 2022 18:50:21 +0800
Received: from localhost (172.16.16.191) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Aug 2022
 18:50:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 04/13] wifi: rtw89: create rtw89_chan centrally to avoid breakage
Date:   Tue, 9 Aug 2022 18:49:43 +0800
Message-ID: <20220809104952.61355-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809104952.61355-1-pkshih@realtek.com>
References: <20220809104952.61355-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 08/09/2022 10:19:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvOSCkV6TIIDA4OjU0OjAw?=
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Sometimes we need to write current rtw89_chan outside set_channel(),
e.g. during HW scan, we adjust it to align FW process through C2H.
However, we don't have full parameters to fill entire rtw89_chan.
And it will breakage if we update only part of current rtw89_chan.
That is what we don't want to see because most flows throughout
driver treat rtw89_chan as a whole.

So, we divide struct rtw89_chan to basic part and derived part. The
basic part contains the parameters which we are always able to know.
And the derived part will be calculated by the basic part. Then, a
central function, rtw89_chan_create(), is added to deal with this.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 98 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h |  2 +
 drivers/net/wireless/realtek/rtw89/core.c | 70 +---------------
 drivers/net/wireless/realtek/rtw89/core.h |  6 +-
 drivers/net/wireless/realtek/rtw89/fw.c   |  7 +-
 drivers/net/wireless/realtek/rtw89/mac.c  |  7 +-
 6 files changed, 109 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index a5d1bf573ea62..0bf27a344d2b4 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -4,6 +4,104 @@
 
 #include "chan.h"
 
+static enum rtw89_subband rtw89_get_subband_type(enum rtw89_band band,
+						 u8 center_chan)
+{
+	switch (band) {
+	default:
+	case RTW89_BAND_2G:
+		switch (center_chan) {
+		default:
+		case 1 ... 14:
+			return RTW89_CH_2G;
+		}
+	case RTW89_BAND_5G:
+		switch (center_chan) {
+		default:
+		case 36 ... 64:
+			return RTW89_CH_5G_BAND_1;
+		case 100 ... 144:
+			return RTW89_CH_5G_BAND_3;
+		case 149 ... 177:
+			return RTW89_CH_5G_BAND_4;
+		}
+	case RTW89_BAND_6G:
+		switch (center_chan) {
+		default:
+		case 1 ... 29:
+			return RTW89_CH_6G_BAND_IDX0;
+		case 33 ... 61:
+			return RTW89_CH_6G_BAND_IDX1;
+		case 65 ... 93:
+			return RTW89_CH_6G_BAND_IDX2;
+		case 97 ... 125:
+			return RTW89_CH_6G_BAND_IDX3;
+		case 129 ... 157:
+			return RTW89_CH_6G_BAND_IDX4;
+		case 161 ... 189:
+			return RTW89_CH_6G_BAND_IDX5;
+		case 193 ... 221:
+			return RTW89_CH_6G_BAND_IDX6;
+		case 225 ... 253:
+			return RTW89_CH_6G_BAND_IDX7;
+		}
+	}
+}
+
+static enum rtw89_sc_offset rtw89_get_primary_chan_idx(enum rtw89_bandwidth bw,
+						       u32 center_freq,
+						       u32 primary_freq)
+{
+	u8 primary_chan_idx;
+	u32 offset;
+
+	switch (bw) {
+	default:
+	case RTW89_CHANNEL_WIDTH_20:
+		primary_chan_idx = RTW89_SC_DONT_CARE;
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		if (primary_freq > center_freq)
+			primary_chan_idx = RTW89_SC_20_UPPER;
+		else
+			primary_chan_idx = RTW89_SC_20_LOWER;
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+	case RTW89_CHANNEL_WIDTH_160:
+		if (primary_freq > center_freq) {
+			offset = (primary_freq - center_freq - 10) / 20;
+			primary_chan_idx = RTW89_SC_20_UPPER + offset * 2;
+		} else {
+			offset = (center_freq - primary_freq - 10) / 20;
+			primary_chan_idx = RTW89_SC_20_LOWER + offset * 2;
+		}
+		break;
+	}
+
+	return primary_chan_idx;
+}
+
+void rtw89_chan_create(struct rtw89_chan *chan, u8 center_chan, u8 primary_chan,
+		       enum rtw89_band band, enum rtw89_bandwidth bandwidth)
+{
+	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
+	u32 center_freq, primary_freq;
+
+	memset(chan, 0, sizeof(*chan));
+	chan->channel = center_chan;
+	chan->primary_channel = primary_chan;
+	chan->band_type = band;
+	chan->band_width = bandwidth;
+
+	center_freq = ieee80211_channel_to_frequency(center_chan, nl_band);
+	primary_freq = ieee80211_channel_to_frequency(primary_chan, nl_band);
+
+	chan->freq = center_freq;
+	chan->subband_type = rtw89_get_subband_type(band, center_chan);
+	chan->pri_ch_idx = rtw89_get_primary_chan_idx(bandwidth, center_freq,
+						      primary_freq);
+}
+
 bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
 			      enum rtw89_sub_entity_idx idx,
 			      const struct rtw89_chan *new)
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index ac5cc356b8182..d39311a3d5baf 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -21,6 +21,8 @@ static inline void rtw89_set_entity_state(struct rtw89_dev *rtwdev, bool active)
 	WRITE_ONCE(hal->entity_active, active);
 }
 
+void rtw89_chan_create(struct rtw89_chan *chan, u8 center_chan, u8 primary_chan,
+		       enum rtw89_band band, enum rtw89_bandwidth bandwidth);
 bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
 			      enum rtw89_sub_entity_idx idx,
 			      const struct rtw89_chan *new);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 78d9e6a7a0981..6ffad5da9161e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -233,10 +233,8 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 	u32 primary_freq, center_freq;
 	u8 center_chan;
 	u8 bandwidth = RTW89_CHANNEL_WIDTH_20;
-	u8 primary_chan_idx = 0;
 	u32 offset;
 	u8 band;
-	u8 subband;
 
 	center_chan = channel->hw_value;
 	primary_freq = channel->center_freq;
@@ -246,15 +244,12 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 	case NL80211_CHAN_WIDTH_20_NOHT:
 	case NL80211_CHAN_WIDTH_20:
 		bandwidth = RTW89_CHANNEL_WIDTH_20;
-		primary_chan_idx = RTW89_SC_DONT_CARE;
 		break;
 	case NL80211_CHAN_WIDTH_40:
 		bandwidth = RTW89_CHANNEL_WIDTH_40;
 		if (primary_freq > center_freq) {
-			primary_chan_idx = RTW89_SC_20_UPPER;
 			center_chan -= 2;
 		} else {
-			primary_chan_idx = RTW89_SC_20_LOWER;
 			center_chan += 2;
 		}
 		break;
@@ -263,11 +258,9 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 		bandwidth = nl_to_rtw89_bandwidth(width);
 		if (primary_freq > center_freq) {
 			offset = (primary_freq - center_freq - 10) / 20;
-			primary_chan_idx = RTW89_SC_20_UPPER + offset * 2;
 			center_chan -= 2 + offset * 4;
 		} else {
 			offset = (center_freq - primary_freq - 10) / 20;
-			primary_chan_idx = RTW89_SC_20_LOWER + offset * 2;
 			center_chan += 2 + offset * 4;
 		}
 		break;
@@ -289,68 +282,7 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 		break;
 	}
 
-	switch (band) {
-	default:
-	case RTW89_BAND_2G:
-		switch (center_chan) {
-		default:
-		case 1 ... 14:
-			subband = RTW89_CH_2G;
-			break;
-		}
-		break;
-	case RTW89_BAND_5G:
-		switch (center_chan) {
-		default:
-		case 36 ... 64:
-			subband = RTW89_CH_5G_BAND_1;
-			break;
-		case 100 ... 144:
-			subband = RTW89_CH_5G_BAND_3;
-			break;
-		case 149 ... 177:
-			subband = RTW89_CH_5G_BAND_4;
-			break;
-		}
-		break;
-	case RTW89_BAND_6G:
-		switch (center_chan) {
-		default:
-		case 1 ... 29:
-			subband = RTW89_CH_6G_BAND_IDX0;
-			break;
-		case 33 ... 61:
-			subband = RTW89_CH_6G_BAND_IDX1;
-			break;
-		case 65 ... 93:
-			subband = RTW89_CH_6G_BAND_IDX2;
-			break;
-		case 97 ... 125:
-			subband = RTW89_CH_6G_BAND_IDX3;
-			break;
-		case 129 ... 157:
-			subband = RTW89_CH_6G_BAND_IDX4;
-			break;
-		case 161 ... 189:
-			subband = RTW89_CH_6G_BAND_IDX5;
-			break;
-		case 193 ... 221:
-			subband = RTW89_CH_6G_BAND_IDX6;
-			break;
-		case 225 ... 253:
-			subband = RTW89_CH_6G_BAND_IDX7;
-			break;
-		}
-		break;
-	}
-
-	chan->channel = center_chan;
-	chan->freq = center_freq;
-	chan->primary_channel = channel->hw_value;
-	chan->band_type = band;
-	chan->band_width = bandwidth;
-	chan->subband_type = subband;
-	chan->pri_ch_idx = primary_chan_idx;
+	rtw89_chan_create(chan, center_chan, channel->hw_value, band, bandwidth);
 }
 
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 86e7341198c6f..cc61043fb5da6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -632,10 +632,14 @@ enum rtw89_sc_offset {
 
 struct rtw89_chan {
 	u8 channel;
-	u32 freq;
 	u8 primary_channel;
 	enum rtw89_band band_type;
 	enum rtw89_bandwidth band_width;
+
+	/* The follow-up are derived from the above. We must ensure that it
+	 * is assigned correctly in rtw89_chan_create() if new one is added.
+	 */
+	u32 freq;
 	enum rtw89_subband subband_type;
 	enum rtw89_sc_offset pri_ch_idx;
 };
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8dcd02d90f457..cee9815b6df6f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2388,11 +2388,8 @@ void rtw89_store_op_chan(struct rtw89_dev *rtwdev, bool backup)
 		scan_info->op_bw = cur->band_width;
 		scan_info->op_band = cur->band_type;
 	} else {
-		new = *cur;
-		new.primary_channel = scan_info->op_pri_ch;
-		new.channel = scan_info->op_chan;
-		new.band_width = scan_info->op_bw;
-		new.band_type = scan_info->op_band;
+		rtw89_chan_create(&new, scan_info->op_chan, scan_info->op_pri_ch,
+				  scan_info->op_band, scan_info->op_bw);
 		rtw89_assign_entity_chan(rtwdev, RTW89_SUB_ENTITY_0, &new);
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b9fb983b6ce24..b90ab56b1c771 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3655,7 +3655,6 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 			   u32 len)
 {
 	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
-	const struct rtw89_chan *cur = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct rtw89_chan new;
 	u8 reason, status, tx_fail, band;
 	u16 chan;
@@ -3682,11 +3681,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 		rtw89_hw_scan_complete(rtwdev, vif, false);
 		break;
 	case RTW89_SCAN_ENTER_CH_NOTIFY:
-		new = *cur;
-		new.channel = chan;
-		new.primary_channel = chan;
-		new.band_type = band;
-		new.band_width = RTW89_CHANNEL_WIDTH_20;
+		rtw89_chan_create(&new, chan, chan, band, RTW89_CHANNEL_WIDTH_20);
 		rtw89_assign_entity_chan(rtwdev, RTW89_SUB_ENTITY_0, &new);
 		if (rtw89_is_op_chan(rtwdev, band, chan)) {
 			rtw89_store_op_chan(rtwdev, false);
-- 
2.25.1

