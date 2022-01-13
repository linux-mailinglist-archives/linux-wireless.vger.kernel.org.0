Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBB348D000
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 02:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiAMBLV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 20:11:21 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42612 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiAMBLJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 20:11:09 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20D1AtMU2031956, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20D1AtMU2031956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 Jan 2022 09:10:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 09:10:55 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 13 Jan
 2022 09:10:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 2/2] rtw89: include subband type in channel params
Date:   Thu, 13 Jan 2022 09:10:42 +0800
Message-ID: <20220113011042.6705-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113011042.6705-1-pkshih@realtek.com>
References: <20220113011042.6705-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/13/2022 00:56:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMTIgpFWkyCAxMDowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Make stuffs related to channel be collected in channel_params,
and encapsulate the corresponding decision in get_channel_params().
Then, functions that takes channel_params can also notice subband type.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 34 +++++++++++++----------
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e7ca3db4b4cf5..805c9c0e57e55 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -230,6 +230,7 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 	u8 bandwidth = RTW89_CHANNEL_WIDTH_20;
 	u8 primary_chan_idx = 0;
 	u8 band;
+	u8 subband;
 
 	center_chan = channel->hw_value;
 	primary_freq = channel->center_freq;
@@ -289,11 +290,28 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 		break;
 	}
 
+	switch (center_chan) {
+	default:
+	case 1 ... 14:
+		subband = RTW89_CH_2G;
+		break;
+	case 36 ... 64:
+		subband = RTW89_CH_5G_BAND_1;
+		break;
+	case 100 ... 144:
+		subband = RTW89_CH_5G_BAND_3;
+		break;
+	case 149 ... 177:
+		subband = RTW89_CH_5G_BAND_4;
+		break;
+	}
+
 	chan_param->center_chan = center_chan;
 	chan_param->primary_chan = channel->hw_value;
 	chan_param->bandwidth = bandwidth;
 	chan_param->pri_ch_idx = primary_chan_idx;
 	chan_param->band_type = band;
+	chan_param->subband_type = subband;
 }
 
 void rtw89_set_channel(struct rtw89_dev *rtwdev)
@@ -320,21 +338,7 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 	hal->prev_primary_channel = hal->current_primary_channel;
 	hal->current_primary_channel = ch_param.primary_chan;
 	hal->current_band_type = ch_param.band_type;
-
-	switch (center_chan) {
-	case 1 ... 14:
-		hal->current_subband = RTW89_CH_2G;
-		break;
-	case 36 ... 64:
-		hal->current_subband = RTW89_CH_5G_BAND_1;
-		break;
-	case 100 ... 144:
-		hal->current_subband = RTW89_CH_5G_BAND_3;
-		break;
-	case 149 ... 177:
-		hal->current_subband = RTW89_CH_5G_BAND_4;
-		break;
-	}
+	hal->current_subband = ch_param.subband_type;
 
 	rtw89_chip_set_channel_prepare(rtwdev, &bak);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index bec1e640cd71b..feffad4ffd68c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -575,6 +575,7 @@ struct rtw89_channel_params {
 	u8 bandwidth;
 	u8 pri_ch_idx;
 	u8 band_type;
+	u8 subband_type;
 };
 
 struct rtw89_channel_help_params {
-- 
2.25.1

