Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC0714D62F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 06:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgA3Fb1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 00:31:27 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:57769 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgA3Fb1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 00:31:27 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 00U5VGoH004151, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 00U5VGoH004151
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jan 2020 13:31:17 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 30 Jan 2020 13:31:16 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 30 Jan 2020 13:31:15 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Thu, 30 Jan 2020 13:31:15 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 30 Jan 2020 13:31:15 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <chiu@endlessm.com>
Subject: [PATCH v2 1/2] rtw88: Use secondary channel offset enumeration
Date:   Thu, 30 Jan 2020 13:31:11 +0800
Message-ID: <20200130053112.28162-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130053112.28162-1-yhchuang@realtek.com>
References: <20200130053112.28162-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
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

v1 -> v2
 * rename RTW_SC_20_UPPERST to RTW_SC_20_UPMOST

 drivers/net/wireless/realtek/rtw88/mac.c      |  6 +++---
 drivers/net/wireless/realtek/rtw88/main.c     | 14 +++++++-------
 drivers/net/wireless/realtek/rtw88/main.h     | 10 ++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  2 +-
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index cadf0abbe16b..ec2c1adcb900 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -17,10 +17,10 @@ void rtw_set_channel_mac(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 
 	txsc20 = primary_ch_idx;
 	if (bw == RTW_CHANNEL_WIDTH_80) {
-		if (txsc20 == 1 || txsc20 == 3)
-			txsc40 = 9;
+		if (txsc20 == RTW_SC_20_UPPER || txsc20 == RTW_SC_20_UPMOST)
+			txsc40 = RTW_SC_40_UPPER;
 		else
-			txsc40 = 10;
+			txsc40 = RTW_SC_40_LOWER;
 	}
 	rtw_write8(rtwdev, REG_DATA_SC,
 		   BIT_TXSC_20M(txsc20) | BIT_TXSC_40M(txsc40));
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 2845d2838f7b..6318d44d9525 100644
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
+				primary_chan_idx = RTW_SC_20_UPMOST;
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
index f334d201bfb5..d11f3a26b7bf 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -99,6 +99,16 @@ enum rtw_bandwidth {
 	RTW_CHANNEL_WIDTH_10	= 6,
 };
 
+enum rtw_sc_offset {
+	RTW_SC_DONT_CARE	= 0,
+	RTW_SC_20_UPPER		= 1,
+	RTW_SC_20_LOWER		= 2,
+	RTW_SC_20_UPMOST	= 3,
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
index 3865097696d4..4c416d603b33 100644
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

