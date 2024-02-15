Return-Path: <linux-wireless+bounces-3606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE7855A3D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 06:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013901F276F6
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 05:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FE54A12;
	Thu, 15 Feb 2024 05:58:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA23BA37
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707976720; cv=none; b=FcSVZVZdx83G88t6t62yeczAD6MHxA2u/6OYAtoavk3rbmQ+KK2+no8bZV9FC8ErI9KrTdGkBbLeJ678HYcvY400RtFf8mYx2KGXfIn+71eOSstd/tBTIxlaRJ7YRYnndsM6gpf9Haf5hpNxEyS9gQKiCsPObYC9NVeb3Y2IPDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707976720; c=relaxed/simple;
	bh=d6v+RIJlyfYzu1CjAyN+8GU3l+FgQF0vBXOaF6JfPyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzcjWxGEqr0HZzfJxNLSYACtkEhIT4ygENm+egl0uT9MqE4Tnuvuh9CXqrIEuQ/v99niypAPYrnLGq+hR4ahQdRFH+9Sv5syrVHOPITp9InB8/+0KiYK3ATmHZgUaaBf52tNqhfYW6sYKcWEr4z84kRGA7vStZVdxuXp/lqRZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41F5wWmfD2372762, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41F5wWmfD2372762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 13:58:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 15 Feb 2024 13:58:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 15 Feb
 2024 13:58:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: 8922a: add set_channel MAC part
Date: Thu, 15 Feb 2024 13:57:38 +0800
Message-ID: <20240215055741.14148-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215055741.14148-1-pkshih@realtek.com>
References: <20240215055741.14148-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

To set channel, add a function to get TXSB (TX subband) that is hardware
index to indicate primary channel. Then, configure band, channel,
bandwidth and TXSB via registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c      | 47 ++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  2 +
 drivers/net/wireless/realtek/rtw89/reg.h      | 33 ++++++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 92 +++++++++++++++++++
 4 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 81f73821e3fc..dfbf59895e4e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -725,6 +725,53 @@ u8 rtw89_phy_get_txsc(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_get_txsc);
 
+u8 rtw89_phy_get_txsb(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
+		      enum rtw89_bandwidth dbw)
+{
+	enum rtw89_bandwidth cbw = chan->band_width;
+	u8 pri_ch = chan->primary_channel;
+	u8 central_ch = chan->channel;
+	u8 txsb_idx = 0;
+
+	if (cbw == dbw || cbw == RTW89_CHANNEL_WIDTH_20)
+		return txsb_idx;
+
+	switch (cbw) {
+	case RTW89_CHANNEL_WIDTH_40:
+		txsb_idx = pri_ch > central_ch ? 1 : 0;
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		if (dbw == RTW89_CHANNEL_WIDTH_20)
+			txsb_idx = (pri_ch - central_ch + 6) / 4;
+		else
+			txsb_idx = pri_ch > central_ch ? 1 : 0;
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		if (dbw == RTW89_CHANNEL_WIDTH_20)
+			txsb_idx = (pri_ch - central_ch + 14) / 4;
+		else if (dbw == RTW89_CHANNEL_WIDTH_40)
+			txsb_idx = (pri_ch - central_ch + 12) / 8;
+		else
+			txsb_idx = pri_ch > central_ch ? 1 : 0;
+		break;
+	case RTW89_CHANNEL_WIDTH_320:
+		if (dbw == RTW89_CHANNEL_WIDTH_20)
+			txsb_idx = (pri_ch - central_ch + 30) / 4;
+		else if (dbw == RTW89_CHANNEL_WIDTH_40)
+			txsb_idx = (pri_ch - central_ch + 28) / 8;
+		else if (dbw == RTW89_CHANNEL_WIDTH_80)
+			txsb_idx = (pri_ch - central_ch + 24) / 16;
+		else
+			txsb_idx = pri_ch > central_ch ? 1 : 0;
+		break;
+	default:
+		break;
+	}
+
+	return txsb_idx;
+}
+EXPORT_SYMBOL(rtw89_phy_get_txsb);
+
 static bool rtw89_phy_check_swsi_busy(struct rtw89_dev *rtwdev)
 {
 	return !!rtw89_phy_read32_mask(rtwdev, R_SWSI_V1, B_SWSI_W_BUSY_V1) ||
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 76234daab896..de19f1c7f931 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -778,6 +778,8 @@ void rtw89_phy_write_reg3_tbl(struct rtw89_dev *rtwdev,
 u8 rtw89_phy_get_txsc(struct rtw89_dev *rtwdev,
 		      const struct rtw89_chan *chan,
 		      enum rtw89_bandwidth dbw);
+u8 rtw89_phy_get_txsb(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
+		      enum rtw89_bandwidth dbw);
 u32 rtw89_phy_read_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 		      u32 addr, u32 mask);
 u32 rtw89_phy_read_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 23a09efabab7..ae637203ee8a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -5986,6 +5986,16 @@
 			B_BE_RMAC_CKEN | B_BE_TXTIME_CKEN | B_BE_RESP_PKTCTL_CKEN | \
 			B_BE_SIGB_CKEN)
 
+#define R_BE_WMAC_RFMOD 0x10010
+#define R_BE_WMAC_RFMOD_C1 0x14010
+#define B_BE_CMAC_ASSERTION BIT(31)
+#define B_BE_WMAC_RFMOD_MASK GENMASK(2, 0)
+#define BE_WMAC_RFMOD_20M 0
+#define BE_WMAC_RFMOD_40M 1
+#define BE_WMAC_RFMOD_80M 2
+#define BE_WMAC_RFMOD_160M 3
+#define BE_WMAC_RFMOD_320M 4
+
 #define R_BE_TX_SUB_BAND_VALUE 0x10088
 #define R_BE_TX_SUB_BAND_VALUE_C1 0x14088
 #define B_BE_PRI20_BITMAP_MASK GENMASK(31, 16)
@@ -6122,6 +6132,13 @@
 #define B_BE_MACTX_LATENCY_MASK GENMASK(10, 8)
 #define B_BE_PREBKF_TIME_MASK GENMASK(4, 0)
 
+#define R_BE_PREBKF_CFG_1 0x1033C
+#define R_BE_PREBKF_CFG_1_C1 0x1433C
+#define B_BE_SIFS_TIMEOUT_TB_AGGR_MASK GENMASK(31, 24)
+#define B_BE_SIFS_PREBKF_MASK GENMASK(23, 16)
+#define B_BE_SIFS_TIMEOUT_T2_MASK GENMASK(14, 8)
+#define B_BE_SIFS_MACTXEN_T1_MASK GENMASK(6, 0)
+
 #define R_BE_CCA_CFG_0 0x10340
 #define R_BE_CCA_CFG_0_C1 0x14340
 #define B_BE_R_SIFS_AGGR_TIME_V1_MASK GENMASK(31, 24)
@@ -6163,9 +6180,12 @@
 
 #define R_BE_MUEDCA_EN 0x10370
 #define R_BE_MUEDCA_EN_C1 0x14370
+#define B_BE_SIFS_TIMEOUT_TB_T2_MASK GENMASK(30, 24)
+#define B_BE_SIFS_MACTXEN_TB_T1_MASK GENMASK(22, 16)
 #define B_BE_MUEDCA_WMM_SEL BIT(8)
-#define B_BE_SET_MUEDCATIMER_TF_1 BIT(5)
+#define B_BE_SET_MUEDCATIMER_TF_MASK GENMASK(5, 4)
 #define B_BE_SET_MUEDCATIMER_TF_0 BIT(4)
+#define B_BE_MUEDCA_EN_MASK GENMASK(1, 0)
 #define B_BE_MUEDCA_EN_0 BIT(0)
 
 #define R_BE_CTN_DRV_TXEN 0x10398
@@ -6419,6 +6439,17 @@
 #define B_BE_SPEC_SIFS_OFDM_PTCL_MASK GENMASK(15, 8)
 #define B_BE_SPEC_SIFS_CCK_PTCL_MASK GENMASK(7, 0)
 
+#define R_BE_TXRATE_CHK 0x10828
+#define R_BE_TXRATE_CHK_C1 0x14828
+#define B_BE_LATENCY_PADDING_PKT_TH_MASK GENMASK(31, 24)
+#define B_BE_PLCP_FETCH_BUFF_MASK GENMASK(23, 16)
+#define B_BE_OFDM_CCK_ERR_PROC BIT(6)
+#define B_BE_PKT_LAST_TX BIT(5)
+#define B_BE_BAND_MODE BIT(4)
+#define B_BE_MAX_TXNSS_MASK GENMASK(3, 2)
+#define B_BE_RTS_LIMIT_IN_OFDM6 BIT(1)
+#define B_BE_CHECK_CCK_EN BIT(0)
+
 #define R_BE_MBSSID_DROP_0 0x1083C
 #define R_BE_MBSSID_DROP_0_C1 0x1483C
 #define B_BE_GI_LTF_FB_SEL BIT(30)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index a4b7d2e79638..982e0ba13b9c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -771,6 +771,97 @@ static void rtw8922a_power_trim(struct rtw89_dev *rtwdev)
 	rtw8922a_pad_bias_trim(rtwdev);
 }
 
+static void rtw8922a_set_channel_mac(struct rtw89_dev *rtwdev,
+				     const struct rtw89_chan *chan,
+				     u8 mac_idx)
+{
+	u32 sub_carr = rtw89_mac_reg_by_idx(rtwdev, R_BE_TX_SUB_BAND_VALUE, mac_idx);
+	u32 chk_rate = rtw89_mac_reg_by_idx(rtwdev, R_BE_TXRATE_CHK, mac_idx);
+	u32 rf_mod = rtw89_mac_reg_by_idx(rtwdev, R_BE_WMAC_RFMOD, mac_idx);
+	u8 txsb20 = 0, txsb40 = 0, txsb80 = 0;
+	u8 rf_mod_val, chk_rate_mask;
+	u32 txsb;
+	u32 reg;
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_160:
+		txsb80 = rtw89_phy_get_txsb(rtwdev, chan, RTW89_CHANNEL_WIDTH_80);
+		fallthrough;
+	case RTW89_CHANNEL_WIDTH_80:
+		txsb40 = rtw89_phy_get_txsb(rtwdev, chan, RTW89_CHANNEL_WIDTH_40);
+		fallthrough;
+	case RTW89_CHANNEL_WIDTH_40:
+		txsb20 = rtw89_phy_get_txsb(rtwdev, chan, RTW89_CHANNEL_WIDTH_20);
+		break;
+	default:
+		break;
+	}
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_160:
+		rf_mod_val = BE_WMAC_RFMOD_160M;
+		txsb = u32_encode_bits(txsb20, B_BE_TXSB_20M_MASK) |
+		       u32_encode_bits(txsb40, B_BE_TXSB_40M_MASK) |
+		       u32_encode_bits(txsb80, B_BE_TXSB_80M_MASK);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rf_mod_val = BE_WMAC_RFMOD_80M;
+		txsb = u32_encode_bits(txsb20, B_BE_TXSB_20M_MASK) |
+		       u32_encode_bits(txsb40, B_BE_TXSB_40M_MASK);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rf_mod_val = BE_WMAC_RFMOD_40M;
+		txsb = u32_encode_bits(txsb20, B_BE_TXSB_20M_MASK);
+		break;
+	case RTW89_CHANNEL_WIDTH_20:
+	default:
+		rf_mod_val = BE_WMAC_RFMOD_20M;
+		txsb = 0;
+		break;
+	}
+
+	if (txsb20 <= BE_PRI20_BITMAP_MAX)
+		txsb |= u32_encode_bits(BIT(txsb20), B_BE_PRI20_BITMAP_MASK);
+
+	rtw89_write8_mask(rtwdev, rf_mod, B_BE_WMAC_RFMOD_MASK, rf_mod_val);
+	rtw89_write32(rtwdev, sub_carr, txsb);
+
+	switch (chan->band_type) {
+	case RTW89_BAND_2G:
+		chk_rate_mask = B_BE_BAND_MODE;
+		break;
+	case RTW89_BAND_5G:
+	case RTW89_BAND_6G:
+		chk_rate_mask = B_BE_CHECK_CCK_EN | B_BE_RTS_LIMIT_IN_OFDM6;
+		break;
+	default:
+		rtw89_warn(rtwdev, "Invalid band_type:%d\n", chan->band_type);
+		return;
+	}
+
+	rtw89_write8_clr(rtwdev, chk_rate, B_BE_BAND_MODE | B_BE_CHECK_CCK_EN |
+					   B_BE_RTS_LIMIT_IN_OFDM6);
+	rtw89_write8_set(rtwdev, chk_rate, chk_rate_mask);
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_320:
+	case RTW89_CHANNEL_WIDTH_160:
+	case RTW89_CHANNEL_WIDTH_80:
+	case RTW89_CHANNEL_WIDTH_40:
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PREBKF_CFG_1, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, B_BE_SIFS_MACTXEN_T1_MASK, 0x41);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_MUEDCA_EN, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, B_BE_SIFS_MACTXEN_TB_T1_MASK, 0x41);
+		break;
+	default:
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PREBKF_CFG_1, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, B_BE_SIFS_MACTXEN_T1_MASK, 0x3f);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_MUEDCA_EN, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, B_BE_SIFS_MACTXEN_TB_T1_MASK, 0x3e);
+		break;
+	}
+}
+
 struct rtw8922a_bb_gain {
 	u32 gain_g[BB_PATH_NUM_8922A];
 	u32 gain_a[BB_PATH_NUM_8922A];
@@ -1298,6 +1389,7 @@ static void rtw8922a_set_channel(struct rtw89_dev *rtwdev,
 				 enum rtw89_mac_idx mac_idx,
 				 enum rtw89_phy_idx phy_idx)
 {
+	rtw8922a_set_channel_mac(rtwdev, chan, mac_idx);
 	rtw8922a_set_channel_bb(rtwdev, chan, phy_idx);
 }
 
-- 
2.25.1


