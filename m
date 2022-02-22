Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BB74BF077
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 05:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbiBVDWk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 22:22:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241523AbiBVDWM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 22:22:12 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB6814015
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 19:21:40 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21M3LRZX0002395, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21M3LRZX0002395
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Feb 2022 11:21:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 22 Feb 2022 11:21:26 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 22 Feb
 2022 11:21:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw89: get channel parameters of 160MHz bandwidth
Date:   Tue, 22 Feb 2022 11:21:03 +0800
Message-ID: <20220222032103.29392-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/22/2022 03:06:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMjIgpFekyCAwMTowODowMA==?=
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

Calculate the offset of center and primary frequencies to get hardware
indices of center channel and primary channel, and then use them to
configure hardware to a specific channel.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 26 ++++++++++-------------
 drivers/net/wireless/realtek/rtw89/core.h | 25 ++++++++++++++++++++++
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 36b1dde007c72..a0086b14550a8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -232,6 +232,7 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 	u8 center_chan;
 	u8 bandwidth = RTW89_CHANNEL_WIDTH_20;
 	u8 primary_chan_idx = 0;
+	u32 offset;
 	u8 band;
 	u8 subband;
 
@@ -256,23 +257,16 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 		}
 		break;
 	case NL80211_CHAN_WIDTH_80:
-		bandwidth = RTW89_CHANNEL_WIDTH_80;
+	case NL80211_CHAN_WIDTH_160:
+		bandwidth = nl_to_rtw89_bandwidth(width);
 		if (primary_freq > center_freq) {
-			if (primary_freq - center_freq == 10) {
-				primary_chan_idx = RTW89_SC_20_UPPER;
-				center_chan -= 2;
-			} else {
-				primary_chan_idx = RTW89_SC_20_UPMOST;
-				center_chan -= 6;
-			}
+			offset = (primary_freq - center_freq - 10) / 20;
+			primary_chan_idx = RTW89_SC_20_UPPER + offset * 2;
+			center_chan -= 2 + offset * 4;
 		} else {
-			if (center_freq - primary_freq == 10) {
-				primary_chan_idx = RTW89_SC_20_LOWER;
-				center_chan += 2;
-			} else {
-				primary_chan_idx = RTW89_SC_20_LOWEST;
-				center_chan += 6;
-			}
+			offset = (center_freq - primary_freq - 10) / 20;
+			primary_chan_idx = RTW89_SC_20_LOWER + offset * 2;
+			center_chan += 2 + offset * 4;
 		}
 		break;
 	default:
@@ -349,6 +343,7 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 	}
 
 	chan_param->center_chan = center_chan;
+	chan_param->center_freq = center_freq;
 	chan_param->primary_chan = channel->hw_value;
 	chan_param->bandwidth = bandwidth;
 	chan_param->pri_ch_idx = primary_chan_idx;
@@ -377,6 +372,7 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 
 	hal->current_band_width = bandwidth;
 	hal->current_channel = center_chan;
+	hal->current_freq = ch_param.center_freq;
 	hal->prev_primary_channel = hal->current_primary_channel;
 	hal->current_primary_channel = ch_param.primary_chan;
 	hal->current_band_type = ch_param.band_type;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4aca2062b65dd..1a409add81f91 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -569,12 +569,17 @@ enum rtw89_sc_offset {
 	RTW89_SC_20_LOWER	= 2,
 	RTW89_SC_20_UPMOST	= 3,
 	RTW89_SC_20_LOWEST	= 4,
+	RTW89_SC_20_UP2X	= 5,
+	RTW89_SC_20_LOW2X	= 6,
+	RTW89_SC_20_UP3X	= 7,
+	RTW89_SC_20_LOW3X	= 8,
 	RTW89_SC_40_UPPER	= 9,
 	RTW89_SC_40_LOWER	= 10,
 };
 
 struct rtw89_channel_params {
 	u8 center_chan;
+	u32 center_freq;
 	u8 primary_chan;
 	u8 bandwidth;
 	u8 pri_ch_idx;
@@ -2379,6 +2384,7 @@ struct rtw89_hal {
 	u32 rx_fltr;
 	u8 cv;
 	u8 current_channel;
+	u32 current_freq;
 	u8 prev_primary_channel;
 	u8 current_primary_channel;
 	enum rtw89_subband current_subband;
@@ -3172,6 +3178,25 @@ static inline u8 rtw89_hw_to_rate_info_bw(enum rtw89_bandwidth hw_bw)
 		return RATE_INFO_BW_20;
 }
 
+static inline
+enum rtw89_bandwidth nl_to_rtw89_bandwidth(enum nl80211_chan_width width)
+{
+	switch (width) {
+	default:
+		WARN(1, "Not support bandwidth %d\n", width);
+		fallthrough;
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		return RTW89_CHANNEL_WIDTH_20;
+	case NL80211_CHAN_WIDTH_40:
+		return RTW89_CHANNEL_WIDTH_40;
+	case NL80211_CHAN_WIDTH_80:
+		return RTW89_CHANNEL_WIDTH_80;
+	case NL80211_CHAN_WIDTH_160:
+		return RTW89_CHANNEL_WIDTH_160;
+	}
+}
+
 static inline
 struct rtw89_addr_cam_entry *rtw89_get_addr_cam_of(struct rtw89_vif *rtwvif,
 						   struct rtw89_sta *rtwsta)
-- 
2.25.1

