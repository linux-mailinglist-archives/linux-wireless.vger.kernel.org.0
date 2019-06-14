Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24BC545606
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 09:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfFNHY1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 03:24:27 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48170 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFNHY0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 03:24:26 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x5E7OMSN024928, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x5E7OMSN024928
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 14 Jun 2019 15:24:22 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Jun 2019 15:24:21 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 05/11] rtw88: 8822c: update channel and bandwidth BB setting
Date:   Fri, 14 Jun 2019 15:24:09 +0800
Message-ID: <1560497055-17197-6-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560497055-17197-1-git-send-email-yhchuang@realtek.com>
References: <1560497055-17197-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chien-Hsun Liao <ben.liao@realtek.com>

In 2G channels, the cck source and rxagc should be set to different
values based on different bandwidth to increase the performance of rx
sensitivity.

To improve rx throughput performance, the values of sbd subtune and
pt_opt should be changed in different bandwidth.

Signed-off-by: Chien-Hsun Liao <ben.liao@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 56 +++++++++++++++++++++++----
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  8 ++++
 2 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index b4f7242e..be46a1b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1015,8 +1015,28 @@ static void rtw8822c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		rtw_write32_clr(rtwdev, REG_CCKTXONLY, BIT_BB_CCK_CHECK_EN);
 		rtw_write32_mask(rtwdev, REG_CCAMSK, 0x3F000000, 0xF);
 
-		rtw_write32_mask(rtwdev, REG_RXAGCCTL0, 0x1f0, 0x0);
-		rtw_write32_mask(rtwdev, REG_RXAGCCTL, 0x1f0, 0x0);
+		switch (bw) {
+		case RTW_CHANNEL_WIDTH_20:
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, BITS_RXAGC_CCK,
+					 0x5);
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL, BITS_RXAGC_CCK,
+					 0x5);
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, BITS_RXAGC_OFDM,
+					 0x6);
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL, BITS_RXAGC_OFDM,
+					 0x6);
+			break;
+		case RTW_CHANNEL_WIDTH_40:
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, BITS_RXAGC_CCK,
+					 0x4);
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL, BITS_RXAGC_CCK,
+					 0x4);
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, BITS_RXAGC_OFDM,
+					 0x0);
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL, BITS_RXAGC_OFDM,
+					 0x0);
+			break;
+		}
 		if (channel == 13 || channel == 14)
 			rtw_write32_mask(rtwdev, REG_SCOTRK, 0xfff, 0x969);
 		else if (channel == 11 || channel == 12)
@@ -1061,14 +1081,20 @@ static void rtw8822c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		rtw_write32_mask(rtwdev, REG_CCAMSK, 0x3F000000, 0x22);
 		rtw_write32_mask(rtwdev, REG_TXDFIR0, 0x70, 0x3);
 		if (channel >= 36 && channel <= 64) {
-			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, 0x1f0, 0x1);
-			rtw_write32_mask(rtwdev, REG_RXAGCCTL, 0x1f0, 0x1);
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, BITS_RXAGC_OFDM,
+					 0x1);
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL, BITS_RXAGC_OFDM,
+					 0x1);
 		} else if (channel >= 100 && channel <= 144) {
-			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, 0x1f0, 0x2);
-			rtw_write32_mask(rtwdev, REG_RXAGCCTL, 0x1f0, 0x2);
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, BITS_RXAGC_OFDM,
+					 0x2);
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL, BITS_RXAGC_OFDM,
+					 0x2);
 		} else if (channel >= 149) {
-			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, 0x1f0, 0x3);
-			rtw_write32_mask(rtwdev, REG_RXAGCCTL, 0x1f0, 0x3);
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, BITS_RXAGC_OFDM,
+					 0x3);
+			rtw_write32_mask(rtwdev, REG_RXAGCCTL, BITS_RXAGC_OFDM,
+					 0x3);
 		}
 
 		if (channel >= 36 && channel <= 51)
@@ -1092,6 +1118,9 @@ static void rtw8822c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		rtw_write32_mask(rtwdev, REG_TXBWCTL, 0xffc0, 0x0);
 		rtw_write32_mask(rtwdev, REG_TXCLK, 0x700, 0x7);
 		rtw_write32_mask(rtwdev, REG_TXCLK, 0x700000, 0x6);
+		rtw_write32_mask(rtwdev, REG_CCK_SOURCE, BIT_NBI_EN, 0x0);
+		rtw_write32_mask(rtwdev, REG_SBD, BITS_SUBTUNE, 0x1);
+		rtw_write32_mask(rtwdev, REG_PT_CHSMO, BIT_PT_OPT, 0x0);
 		break;
 	case RTW_CHANNEL_WIDTH_40:
 		rtw_write32_mask(rtwdev, REG_CCKSB, BIT(4),
@@ -1100,12 +1129,17 @@ static void rtw8822c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		rtw_write32_mask(rtwdev, REG_TXBWCTL, 0xc0, 0x0);
 		rtw_write32_mask(rtwdev, REG_TXBWCTL, 0xff00,
 				 (primary_ch_idx | (primary_ch_idx << 4)));
+		rtw_write32_mask(rtwdev, REG_CCK_SOURCE, BIT_NBI_EN, 0x1);
+		rtw_write32_mask(rtwdev, REG_SBD, BITS_SUBTUNE, 0x1);
+		rtw_write32_mask(rtwdev, REG_PT_CHSMO, BIT_PT_OPT, 0x1);
 		break;
 	case RTW_CHANNEL_WIDTH_80:
 		rtw_write32_mask(rtwdev, REG_TXBWCTL, 0xf, 0xa);
 		rtw_write32_mask(rtwdev, REG_TXBWCTL, 0xc0, 0x0);
 		rtw_write32_mask(rtwdev, REG_TXBWCTL, 0xff00,
 				 (primary_ch_idx | (primary_ch_idx << 4)));
+		rtw_write32_mask(rtwdev, REG_SBD, BITS_SUBTUNE, 0x6);
+		rtw_write32_mask(rtwdev, REG_PT_CHSMO, BIT_PT_OPT, 0x1);
 		break;
 	case RTW_CHANNEL_WIDTH_5:
 		rtw_write32_mask(rtwdev, REG_DFIRBW, 0x3FF0, 0x2AB);
@@ -1113,6 +1147,9 @@ static void rtw8822c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		rtw_write32_mask(rtwdev, REG_TXBWCTL, 0xffc0, 0x1);
 		rtw_write32_mask(rtwdev, REG_TXCLK, 0x700, 0x4);
 		rtw_write32_mask(rtwdev, REG_TXCLK, 0x700000, 0x4);
+		rtw_write32_mask(rtwdev, REG_CCK_SOURCE, BIT_NBI_EN, 0x0);
+		rtw_write32_mask(rtwdev, REG_SBD, BITS_SUBTUNE, 0x1);
+		rtw_write32_mask(rtwdev, REG_PT_CHSMO, BIT_PT_OPT, 0x0);
 		break;
 	case RTW_CHANNEL_WIDTH_10:
 		rtw_write32_mask(rtwdev, REG_DFIRBW, 0x3FF0, 0x2AB);
@@ -1120,6 +1157,9 @@ static void rtw8822c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		rtw_write32_mask(rtwdev, REG_TXBWCTL, 0xffc0, 0x2);
 		rtw_write32_mask(rtwdev, REG_TXCLK, 0x700, 0x6);
 		rtw_write32_mask(rtwdev, REG_TXCLK, 0x700000, 0x5);
+		rtw_write32_mask(rtwdev, REG_CCK_SOURCE, BIT_NBI_EN, 0x0);
+		rtw_write32_mask(rtwdev, REG_SBD, BITS_SUBTUNE, 0x1);
+		rtw_write32_mask(rtwdev, REG_PT_CHSMO, BIT_PT_OPT, 0x0);
 		break;
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index d3bd985..ef708ba 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -133,6 +133,8 @@ struct rtw8822c_efuse {
 #define REG_DYMPRITH	0x86c
 #define REG_DYMENTH0	0x870
 #define REG_DYMENTH	0x874
+#define REG_SBD		0x88c
+#define BITS_SUBTUNE		GENMASK(15, 12)
 #define REG_DYMTHMIN	0x8a4
 #define REG_TXBWCTL	0x9b0
 #define REG_TXCLK	0x9b4
@@ -140,12 +142,16 @@ struct rtw8822c_efuse {
 #define REG_MRCM	0xc38
 #define REG_AGCSWSH	0xc44
 #define REG_ANTWTPD	0xc54
+#define REG_PT_CHSMO	0xcbc
+#define BIT_PT_OPT		BIT(21)
 #define REG_ORITXCODE	0x1800
 #define REG_3WIRE	0x180c
 #define BIT_3WIRE_TX_EN		BIT(0)
 #define BIT_3WIRE_RX_EN		BIT(1)
 #define BIT_3WIRE_PI_ON		BIT(28)
 #define REG_RXAGCCTL0	0x18ac
+#define BITS_RXAGC_CCK		GENMASK(15, 12)
+#define BITS_RXAGC_OFDM		GENMASK(8, 4)
 #define REG_CCKSB	0x1a00
 #define REG_RXCCKSEL	0x1a04
 #define REG_BGCTRL	0x1a14
@@ -164,6 +170,8 @@ struct rtw8822c_efuse {
 #define REG_TXF5	0x1aa0
 #define REG_TXF6	0x1aac
 #define REG_TXF7	0x1ab0
+#define REG_CCK_SOURCE	0x1abc
+#define BIT_NBI_EN		BIT(30)
 #define REG_TXANT	0x1c28
 #define REG_ENCCK	0x1c3c
 #define BIT_CCK_BLK_EN		BIT(1)
-- 
2.7.4

