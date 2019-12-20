Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEC31277FC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 10:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLTJWa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 04:22:30 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47430 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfLTJWa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 04:22:30 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBK9MN6D025709, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBK9MN6D025709
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Dec 2019 17:22:23 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Dec 2019 17:22:23 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 03/11] rtw88: Use secondary channel offset enumeration
Date:   Fri, 20 Dec 2019 17:21:48 +0800
Message-ID: <20191220092156.13443-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220092156.13443-1-yhchuang@realtek.com>
References: <20191220092156.13443-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

The hardware value of secondary channel offset isn't very intuitive. This
commit adds enumeration, so we can easier to check the logic with the
suffix of enumeration name, likes _UPPER or _LOWER.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c      |  6 +++---
 drivers/net/wireless/realtek/rtw88/main.c     | 14 +++++++-------
 drivers/net/wireless/realtek/rtw88/main.h     | 10 ++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  2 +-
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index ed9bb427ba60..94d1b179e2e1 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -17,10 +17,10 @@ void rtw_set_channel_mac(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 
 	txsc20 = primary_ch_idx;
 	if (bw == RTW_CHANNEL_WIDTH_80) {
-		if (txsc20 == 1 || txsc20 == 3)
-			txsc40 = 9;
+		if (txsc20 == RTW_SC_20_UPPER || txsc20 == RTW_SC_20_UPPERST)
+			txsc40 = RTW_SC_40_UPPER;
 		else
-			txsc40 = 10;
+			txsc40 = RTW_SC_40_LOWER;
 	}
 	rtw_write8(rtwdev, REG_DATA_SC,
 		   BIT_TXSC_20M(txsc20) | BIT_TXSC_40M(txsc40));
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f369ddca953a..cc61c390226c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -317,15 +317,15 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 	case NL80211_CHAN_WIDTH_20_NOHT:
 	case NL80211_CHAN_WIDTH_20:
 		bandwidth = RTW_CHANNEL_WIDTH_20;
-		primary_chan_idx = 0;
+		primary_chan_idx = RTW_SC_DONT_CARE;
 		break;
 	case NL80211_CHAN_WIDTH_40:
 		bandwidth = RTW_CHANNEL_WIDTH_40;
 		if (primary_freq > center_freq) {
-			primary_chan_idx = 1;
+			primary_chan_idx = RTW_SC_20_UPPER;
 			center_chan -= 2;
 		} else {
-			primary_chan_idx = 2;
+			primary_chan_idx = RTW_SC_20_LOWER;
 			center_chan += 2;
 		}
 		break;
@@ -333,10 +333,10 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 		bandwidth = RTW_CHANNEL_WIDTH_80;
 		if (primary_freq > center_freq) {
 			if (primary_freq - center_freq == 10) {
-				primary_chan_idx = 1;
+				primary_chan_idx = RTW_SC_20_UPPER;
 				center_chan -= 2;
 			} else {
-				primary_chan_idx = 3;
+				primary_chan_idx = RTW_SC_20_UPPERST;
 				center_chan -= 6;
 			}
 			/* assign the center channel used
@@ -345,10 +345,10 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			cch_by_bw[RTW_CHANNEL_WIDTH_40] = center_chan + 4;
 		} else {
 			if (center_freq - primary_freq == 10) {
-				primary_chan_idx = 2;
+				primary_chan_idx = RTW_SC_20_LOWER;
 				center_chan += 2;
 			} else {
-				primary_chan_idx = 4;
+				primary_chan_idx = RTW_SC_20_LOWEST;
 				center_chan += 6;
 			}
 			/* assign the center channel used
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index d012eefcd0da..144fbab38fd5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -95,6 +95,16 @@ enum rtw_bandwidth {
 	RTW_CHANNEL_WIDTH_10	= 6,
 };
 
+enum rtw_sc_offset {
+	RTW_SC_DONT_CARE	= 0,
+	RTW_SC_20_UPPER		= 1,
+	RTW_SC_20_LOWER		= 2,
+	RTW_SC_20_UPPERST	= 3,
+	RTW_SC_20_LOWEST	= 4,
+	RTW_SC_40_UPPER		= 9,
+	RTW_SC_40_LOWER		= 10,
+};
+
 enum rtw_net_type {
 	RTW_NET_NO_LINK		= 0,
 	RTW_NET_AD_HOC		= 1,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 4bc14b1a6340..2eed777ee692 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -645,7 +645,7 @@ static void rtw8822b_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		rtw_write32_mask(rtwdev, REG_ADC160, BIT(30), 0x1);
 		break;
 	case RTW_CHANNEL_WIDTH_40:
-		if (primary_ch_idx == 1)
+		if (primary_ch_idx == RTW_SC_20_UPPER)
 			rtw_write32_set(rtwdev, REG_RXSB, BIT(4));
 		else
 			rtw_write32_clr(rtwdev, REG_RXSB, BIT(4));
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 174029836833..57faef21ea52 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1482,7 +1482,7 @@ static void rtw8822c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		break;
 	case RTW_CHANNEL_WIDTH_40:
 		rtw_write32_mask(rtwdev, REG_CCKSB, BIT(4),
-				 (primary_ch_idx == 1 ? 1 : 0));
+				 (primary_ch_idx == RTW_SC_20_UPPER ? 1 : 0));
 		rtw_write32_mask(rtwdev, REG_TXBWCTL, 0xf, 0x5);
 		rtw_write32_mask(rtwdev, REG_TXBWCTL, 0xc0, 0x0);
 		rtw_write32_mask(rtwdev, REG_TXBWCTL, 0xff00,
-- 
2.17.1

