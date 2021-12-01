Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA56D46494A
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 09:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347373AbhLAIMy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 03:12:54 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39308 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345308AbhLAIMx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 03:12:53 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1B189T610031931, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1B189T610031931
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 1 Dec 2021 16:09:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 16:09:29 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 1 Dec
 2021 16:09:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH] rtw89: remove cch_by_bw which is not used
Date:   Wed, 1 Dec 2021 16:09:01 +0800
Message-ID: <20211201080901.12125-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 12/01/2021 07:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzEgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, cch_by_bw recorded center channels of each available
bandwidths under current bandwidth. And the plan was to iterate
cch_by_bw as parameters to query other configurations. However,
we have not used it for the time being. Keeping it will disturb
the follow-up things, such as bandwidth 160 MHz, so we remove it
for now. If it's really needed at some point, we will redesign it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 23 -----------------------
 drivers/net/wireless/realtek/rtw89/core.h |  6 ------
 2 files changed, 29 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d02ec5a735cb1..d9369416a7009 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -143,20 +143,15 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 {
 	struct ieee80211_channel *channel = chandef->chan;
 	enum nl80211_chan_width width = chandef->width;
-	u8 *cch_by_bw = chan_param->cch_by_bw;
 	u32 primary_freq, center_freq;
 	u8 center_chan;
 	u8 bandwidth = RTW89_CHANNEL_WIDTH_20;
 	u8 primary_chan_idx = 0;
-	u8 i;
 
 	center_chan = channel->hw_value;
 	primary_freq = channel->center_freq;
 	center_freq = chandef->center_freq1;
 
-	/* assign the center channel used while 20M bw is selected */
-	cch_by_bw[RTW89_CHANNEL_WIDTH_20] = channel->hw_value;
-
 	switch (width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
 	case NL80211_CHAN_WIDTH_20:
@@ -183,10 +178,6 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 				primary_chan_idx = RTW89_SC_20_UPMOST;
 				center_chan -= 6;
 			}
-			/* assign the center channel used
-			 * while 40M bw is selected
-			 */
-			cch_by_bw[RTW89_CHANNEL_WIDTH_40] = center_chan + 4;
 		} else {
 			if (center_freq - primary_freq == 10) {
 				primary_chan_idx = RTW89_SC_20_LOWER;
@@ -195,10 +186,6 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 				primary_chan_idx = RTW89_SC_20_LOWEST;
 				center_chan += 6;
 			}
-			/* assign the center channel used
-			 * while 40M bw is selected
-			 */
-			cch_by_bw[RTW89_CHANNEL_WIDTH_40] = center_chan - 4;
 		}
 		break;
 	default:
@@ -210,12 +197,6 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 	chan_param->primary_chan = channel->hw_value;
 	chan_param->bandwidth = bandwidth;
 	chan_param->pri_ch_idx = primary_chan_idx;
-
-	/* assign the center channel used while current bw is selected */
-	cch_by_bw[bandwidth] = center_chan;
-
-	for (i = bandwidth + 1; i <= RTW89_MAX_CHANNEL_WIDTH; i++)
-		cch_by_bw[i] = 0;
 }
 
 void rtw89_set_channel(struct rtw89_dev *rtwdev)
@@ -228,7 +209,6 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 	u8 center_chan, bandwidth;
 	u8 band_type;
 	bool band_changed;
-	u8 i;
 
 	rtw89_get_channel_params(&hw->conf.chandef, &ch_param);
 	if (WARN(ch_param.center_chan == 0, "Invalid channel\n"))
@@ -260,9 +240,6 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 		break;
 	}
 
-	for (i = RTW89_CHANNEL_WIDTH_20; i <= RTW89_MAX_CHANNEL_WIDTH; i++)
-		hal->cch_by_bw[i] = ch_param.cch_by_bw[i];
-
 	rtw89_chip_set_channel_prepare(rtwdev, &bak);
 
 	chip->ops->set_channel(rtwdev, &ch_param);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3729abda04f9f..58ed1e4f4339a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -544,7 +544,6 @@ enum rtw89_ps_mode {
 	RTW89_PS_MODE_PWR_GATED	= 3,
 };
 
-#define RTW89_MAX_CHANNEL_WIDTH RTW89_CHANNEL_WIDTH_80
 #define RTW89_2G_BW_NUM (RTW89_CHANNEL_WIDTH_40 + 1)
 #define RTW89_5G_BW_NUM (RTW89_CHANNEL_WIDTH_80 + 1)
 #define RTW89_PPE_BW_NUM (RTW89_CHANNEL_WIDTH_80 + 1)
@@ -571,7 +570,6 @@ struct rtw89_channel_params {
 	u8 primary_chan;
 	u8 bandwidth;
 	u8 pri_ch_idx;
-	u8 cch_by_bw[RTW89_MAX_CHANNEL_WIDTH + 1];
 };
 
 struct rtw89_channel_help_params {
@@ -2359,10 +2357,6 @@ struct rtw89_hal {
 	enum rtw89_subband current_subband;
 	u8 current_band_width;
 	u8 current_band_type;
-	/* center channel for different available bandwidth,
-	 * val of (bw > current_band_width) is invalid
-	 */
-	u8 cch_by_bw[RTW89_MAX_CHANNEL_WIDTH + 1];
 	u32 sw_amsdu_max_size;
 	u32 antenna_tx;
 	u32 antenna_rx;
-- 
2.25.1

