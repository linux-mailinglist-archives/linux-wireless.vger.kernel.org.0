Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA642E0184
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 12:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbfJVKEb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 06:04:31 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37556 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbfJVKEb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 06:04:31 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9MA4M7C017632, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9MA4M7C017632
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 22 Oct 2019 18:04:23 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 22 Oct 2019 18:04:22 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v3 1/5] rtw88: use macro to check the current band
Date:   Tue, 22 Oct 2019 18:04:16 +0800
Message-ID: <20191022100420.25116-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191022100420.25116-1-yhchuang@realtek.com>
References: <20191022100420.25116-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Add macros to see which band we are, based on the current channel.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v2 -> v3
 * no change

 drivers/net/wireless/realtek/rtw88/mac.c      |  2 +-
 drivers/net/wireless/realtek/rtw88/main.h     | 13 ++++++
 drivers/net/wireless/realtek/rtw88/phy.c      |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 40 +++++++++----------
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 16 ++++----
 5 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 8d72825ed3a7..c471117b1472 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -47,7 +47,7 @@ void rtw_set_channel_mac(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 
 	value8 = rtw_read8(rtwdev, REG_CCK_CHECK);
 	value8 = value8 & ~BIT_CHECK_CCK_EN;
-	if (channel > 35)
+	if (IS_CH_5G_BAND(channel))
 		value8 |= BIT_CHECK_CCK_EN;
 	rtw_write8(rtwdev, REG_CCK_CHECK, value8);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 4759d6a0ca6e..492a2bfc0d5a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -58,6 +58,19 @@ struct rtw_hci {
 	u8 bulkout_num;
 };
 
+#define IS_CH_5G_BAND_1(channel) ((channel) >= 36 && (channel <= 48))
+#define IS_CH_5G_BAND_2(channel) ((channel) >= 52 && (channel <= 64))
+#define IS_CH_5G_BAND_3(channel) ((channel) >= 100 && (channel <= 144))
+#define IS_CH_5G_BAND_4(channel) ((channel) >= 149 && (channel <= 177))
+
+#define IS_CH_5G_BAND_MID(channel) \
+	(IS_CH_5G_BAND_2(channel) || IS_CH_5G_BAND_3(channel))
+
+#define IS_CH_2G_BAND(channel) ((channel) <= 14)
+#define IS_CH_5G_BAND(channel) \
+	(IS_CH_5G_BAND_1(channel) || IS_CH_5G_BAND_2(channel) || \
+	 IS_CH_5G_BAND_3(channel) || IS_CH_5G_BAND_4(channel))
+
 enum rtw_supported_band {
 	RTW_BAND_2G = 1 << 0,
 	RTW_BAND_5G = 1 << 1,
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 8ebe1f4b76ad..ae5ecefb424e 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1748,7 +1748,7 @@ void rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path, u8 rate, u8 bw,
 	group = rtw_get_channel_group(ch);
 
 	/* base power index for 2.4G/5G */
-	if (ch <= 14) {
+	if (IS_CH_2G_BAND(ch)) {
 		band = PHY_BAND_2G;
 		*base = rtw_phy_get_2g_tx_power_index(rtwdev,
 						      &pwr_idx->pwr_idx_2g,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 1e20c4465bc9..baf5091fa253 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -211,9 +211,8 @@ static int rtw8822b_mac_init(struct rtw_dev *rtwdev)
 static void rtw8822b_set_channel_rfe_efem(struct rtw_dev *rtwdev, u8 channel)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
-	bool is_channel_2g = (channel <= 14) ? true : false;
 
-	if (is_channel_2g) {
+	if (IS_CH_2G_BAND(channel)) {
 		rtw_write32s_mask(rtwdev, REG_RFESEL0, 0xffffff, 0x705770);
 		rtw_write32s_mask(rtwdev, REG_RFESEL8, MASKBYTE1, 0x57);
 		rtw_write32s_mask(rtwdev, REG_RFECTL, BIT(4), 0);
@@ -241,9 +240,8 @@ static void rtw8822b_set_channel_rfe_efem(struct rtw_dev *rtwdev, u8 channel)
 static void rtw8822b_set_channel_rfe_ifem(struct rtw_dev *rtwdev, u8 channel)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
-	bool is_channel_2g = (channel <= 14) ? true : false;
 
-	if (is_channel_2g) {
+	if (IS_CH_2G_BAND(channel)) {
 		/* signal source */
 		rtw_write32s_mask(rtwdev, REG_RFESEL0, 0xffffff, 0x745774);
 		rtw_write32s_mask(rtwdev, REG_RFESEL8, MASKBYTE1, 0x57);
@@ -255,7 +253,7 @@ static void rtw8822b_set_channel_rfe_ifem(struct rtw_dev *rtwdev, u8 channel)
 
 	rtw_write32s_mask(rtwdev, REG_RFEINV, BIT(11) | BIT(10) | 0x3f, 0x0);
 
-	if (is_channel_2g) {
+	if (IS_CH_2G_BAND(channel)) {
 		if (hal->antenna_rx == BB_PATH_AB ||
 		    hal->antenna_tx == BB_PATH_AB) {
 			/* 2TX or 2RX */
@@ -350,7 +348,7 @@ static void rtw8822b_set_channel_cca(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 	u32 reg82c, reg830, reg838;
 	bool is_efem_cca = false, is_ifem_cca = false, is_rfe_type = false;
 
-	if (channel <= 14) {
+	if (IS_CH_2G_BAND(channel)) {
 		cca_ccut = rfe_info->cca_ccut_2g;
 
 		if (hal->antenna_rx == BB_PATH_A ||
@@ -381,7 +379,7 @@ static void rtw8822b_set_channel_cca(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		is_efem_cca = true;
 		break;
 	case RTW_RFE_IFEM2G_EFEM5G:
-		if (channel <= 14)
+		if (IS_CH_2G_BAND(channel))
 			is_ifem_cca = true;
 		else
 			is_efem_cca = true;
@@ -405,9 +403,7 @@ static void rtw8822b_set_channel_cca(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 	if (is_efem_cca && !(hal->cut_version == RTW_CHIP_VER_CUT_B))
 		rtw_write32_mask(rtwdev, REG_L1WT, MASKDWORD, 0x9194b2b9);
 
-	if (bw == RTW_CHANNEL_WIDTH_20 &&
-	    ((channel >= 52 && channel <= 64) ||
-	     (channel >= 100 && channel <= 144)))
+	if (bw == RTW_CHANNEL_WIDTH_20 && IS_CH_5G_BAND_MID(channel))
 		rtw_write32_mask(rtwdev, REG_CCA2ND, 0xf0, 0x4);
 }
 
@@ -442,7 +438,7 @@ static void rtw8822b_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
 	rf_reg18 &= ~(RF18_BAND_MASK | RF18_CHANNEL_MASK | RF18_RFSI_MASK |
 		      RF18_BW_MASK);
 
-	rf_reg18 |= (channel <= 14 ? RF18_BAND_2G : RF18_BAND_5G);
+	rf_reg18 |= (IS_CH_2G_BAND(channel) ? RF18_BAND_2G : RF18_BAND_5G);
 	rf_reg18 |= (channel & RF18_CHANNEL_MASK);
 	if (channel > 144)
 		rf_reg18 |= RF18_RFSI_GT_CH144;
@@ -464,13 +460,13 @@ static void rtw8822b_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
 		break;
 	}
 
-	if (channel <= 14)
+	if (IS_CH_2G_BAND(channel))
 		rf_reg_be = 0x0;
-	else if (channel >= 36 && channel <= 64)
+	else if (IS_CH_5G_BAND_1(channel) || IS_CH_5G_BAND_2(channel))
 		rf_reg_be = low_band[(channel - 36) >> 1];
-	else if (channel >= 100 && channel <= 144)
+	else if (IS_CH_5G_BAND_3(channel))
 		rf_reg_be = middle_band[(channel - 100) >> 1];
-	else if (channel >= 149 && channel <= 177)
+	else if (IS_CH_5G_BAND_4(channel))
 		rf_reg_be = high_band[(channel - 149) >> 1];
 	else
 		goto err;
@@ -539,7 +535,7 @@ static void rtw8822b_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 	u8 rfe_option = efuse->rfe_option;
 	u32 val32;
 
-	if (channel <= 14) {
+	if (IS_CH_2G_BAND(channel)) {
 		rtw_write32_mask(rtwdev, REG_RXPSEL, BIT(28), 0x1);
 		rtw_write32_mask(rtwdev, REG_CCK_CHECK, BIT(7), 0x0);
 		rtw_write32_mask(rtwdev, REG_ENTXCCK, BIT(18), 0x0);
@@ -556,22 +552,22 @@ static void rtw8822b_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		}
 
 		rtw_write32_mask(rtwdev, REG_RFEINV, 0x300, 0x2);
-	} else if (channel > 35) {
+	} else if (IS_CH_5G_BAND(channel)) {
 		rtw_write32_mask(rtwdev, REG_ENTXCCK, BIT(18), 0x1);
 		rtw_write32_mask(rtwdev, REG_CCK_CHECK, BIT(7), 0x1);
 		rtw_write32_mask(rtwdev, REG_RXPSEL, BIT(28), 0x0);
 		rtw_write32_mask(rtwdev, REG_RXCCAMSK, 0x0000FC00, 34);
 
-		if (channel >= 36 && channel <= 64)
+		if (IS_CH_5G_BAND_1(channel) || IS_CH_5G_BAND_2(channel))
 			rtw_write32_mask(rtwdev, REG_ACGG2TBL, 0x1f, 0x1);
-		else if (channel >= 100 && channel <= 144)
+		else if (IS_CH_5G_BAND_3(channel))
 			rtw_write32_mask(rtwdev, REG_ACGG2TBL, 0x1f, 0x2);
-		else if (channel >= 149)
+		else if (IS_CH_5G_BAND_4(channel))
 			rtw_write32_mask(rtwdev, REG_ACGG2TBL, 0x1f, 0x3);
 
-		if (channel >= 36 && channel <= 48)
+		if (IS_CH_5G_BAND_1(channel))
 			rtw_write32_mask(rtwdev, REG_CLKTRK, 0x1ffe0000, 0x494);
-		else if (channel >= 52 && channel <= 64)
+		else if (IS_CH_5G_BAND_2(channel))
 			rtw_write32_mask(rtwdev, REG_CLKTRK, 0x1ffe0000, 0x453);
 		else if (channel >= 100 && channel <= 116)
 			rtw_write32_mask(rtwdev, REG_CLKTRK, 0x1ffe0000, 0x452);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 690934386b85..167af317c7c5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1287,11 +1287,11 @@ static void rtw8822c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
 	rf_reg18 &= ~(RF18_BAND_MASK | RF18_CHANNEL_MASK | RF18_RFSI_MASK |
 		      RF18_BW_MASK);
 
-	rf_reg18 |= (channel <= 14 ? RF18_BAND_2G : RF18_BAND_5G);
+	rf_reg18 |= (IS_CH_2G_BAND(channel) ? RF18_BAND_2G : RF18_BAND_5G);
 	rf_reg18 |= (channel & RF18_CHANNEL_MASK);
-	if (channel > 144)
+	if (IS_CH_5G_BAND_4(channel))
 		rf_reg18 |= RF18_RFSI_GT_CH140;
-	else if (channel >= 80)
+	else if (IS_CH_5G_BAND_3(channel))
 		rf_reg18 |= RF18_RFSI_GE_CH80;
 
 	switch (bw) {
@@ -1341,7 +1341,7 @@ static void rtw8822c_toggle_igi(struct rtw_dev *rtwdev)
 static void rtw8822c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 				    u8 primary_ch_idx)
 {
-	if (channel <= 14) {
+	if (IS_CH_2G_BAND(channel)) {
 		rtw_write32_clr(rtwdev, REG_BGCTRL, BITS_RX_IQ_WEIGHT);
 		rtw_write32_mask(rtwdev, REG_RXCCKSEL, 0xf0000000, 0x8);
 		rtw_write32_set(rtwdev, REG_TXF4, BIT(20));
@@ -1406,7 +1406,7 @@ static void rtw8822c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 			rtw_write32_mask(rtwdev, REG_TXDFIR0, 0x70, 0x3);
 		else
 			rtw_write32_mask(rtwdev, REG_TXDFIR0, 0x70, 0x1);
-	} else if (channel > 35) {
+	} else if (IS_CH_5G_BAND(channel)) {
 		rtw_write32_set(rtwdev, REG_CCKTXONLY, BIT_BB_CCK_CHECK_EN);
 		rtw_write32_set(rtwdev, REG_CCK_CHECK, BIT_CHECK_CCK_EN);
 		rtw_write32_set(rtwdev, REG_BGCTRL, BITS_RX_IQ_WEIGHT);
@@ -1414,17 +1414,17 @@ static void rtw8822c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		rtw_write32_mask(rtwdev, REG_RXCCKSEL, 0xf0000000, 0x0);
 		rtw_write32_mask(rtwdev, REG_CCAMSK, 0x3F000000, 0x22);
 		rtw_write32_mask(rtwdev, REG_TXDFIR0, 0x70, 0x3);
-		if (channel >= 36 && channel <= 64) {
+		if (IS_CH_5G_BAND_1(channel) || IS_CH_5G_BAND_2(channel)) {
 			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, BITS_RXAGC_OFDM,
 					 0x1);
 			rtw_write32_mask(rtwdev, REG_RXAGCCTL, BITS_RXAGC_OFDM,
 					 0x1);
-		} else if (channel >= 100 && channel <= 144) {
+		} else if (IS_CH_5G_BAND_3(channel)) {
 			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, BITS_RXAGC_OFDM,
 					 0x2);
 			rtw_write32_mask(rtwdev, REG_RXAGCCTL, BITS_RXAGC_OFDM,
 					 0x2);
-		} else if (channel >= 149) {
+		} else if (IS_CH_5G_BAND_4(channel)) {
 			rtw_write32_mask(rtwdev, REG_RXAGCCTL0, BITS_RXAGC_OFDM,
 					 0x3);
 			rtw_write32_mask(rtwdev, REG_RXAGCCTL, BITS_RXAGC_OFDM,
-- 
2.17.1

