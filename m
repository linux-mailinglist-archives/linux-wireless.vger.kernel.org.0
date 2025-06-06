Return-Path: <linux-wireless+bounces-23787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2444ACFB15
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 04:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2078818893A6
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 02:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3A01ADFE4;
	Fri,  6 Jun 2025 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ECc1JlXv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869029A2
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 02:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175466; cv=none; b=oJEer80kGv3qJgbGQqxhkfu5DOa4O2Dfp7q4izojsFN+v5lf9ymAHDrn5DwHKF5a3XOz0lY5xOwqUWVUtFilYAuIo2RKJY0ohqpjUQVvgDHOaUexpJvlQrfxNeqIi4W5lt/D31mpmy5qjl+J8h4U9gHn4GET6Yu38pxAGeg+2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175466; c=relaxed/simple;
	bh=rYWp2wamHKXDeWE+wjz5T3HjbfH3L/8/P9anW55YAkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6ZSDoSPHtkF9Cn/u+TET36MHBepGVs4GDRqAnUNdT6VHUsUmN17fhILHcrb4F8/M4kVfYwKRUmCb1rG0Q8HYLv7mH3J9xA9DxUki21F9QQdUBKydiZBtgXxFoEbDB3ZXv6+OogBIuJplhT3HIuZGab7JqNzkRgDTH7doVgMfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ECc1JlXv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55624MBX02621356, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749175462; bh=Z+8i9oPEya6hAcvS3A51n5aY6/WoLXvQ0ykzb7Gn41I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ECc1JlXvNpnVJ4rhtNkLuZPSNp4s37KMzR8HcFciStgABb2fQYUNaqVSBG9jtKMTX
	 2ZjRo+fHq4gAle59a2+yLYUzmBefIK1nNzIjqbt1UtI20Af9GqMFf6CJMi8QJ07Zne
	 Vpex76DJHDKq+Pv0yaA0WEkTg2i+3XBJGCuHUHMHdVpe/M7sGAXM+ata0p14yp1ud+
	 3SWyE6Ur4ML1lLztmWhhfRRi9zbsEgqI/L13hBQJIBdMGhGUIt8fkucjIk54RPscEx
	 /3s774FuUAmpMVGBhFiwP/unDzohmqbpM+HzrLe+eYKoZGml4EVBYMXRZK/coMEMST
	 bbG6Oo3I2S87Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55624MBX02621356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 10:04:22 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Jun 2025 10:04:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Jun
 2025 10:04:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 5/6] wifi: rtw89: add chip_ops::chan_to_rf18_val to get code of RF register value
Date: Fri, 6 Jun 2025 10:04:08 +0800
Message-ID: <20250606020408.17035-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250606020302.16873-1-pkshih@realtek.com>
References: <20250606020302.16873-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

From: Kuan-Chung Chen <damon.chen@realtek.com>

The RF 0x18 register stores radio frequency domain parameters, including
band, center channel and bandwidth. This information is used in RF
domain. Add a chip_ops to retrieve the RF 0x18 value, which allows
driver to query for a specific channel.

No logic is changed.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 13 +++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 43 +++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c | 52 ++-----------------
 8 files changed, 66 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c570f0180923..9a61f22ede15 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3645,6 +3645,8 @@ struct rtw89_chip_ops {
 			       enum rtw89_phy_idx phy_idx);
 	int (*init_txpwr_unit)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 	u8 (*get_thermal)(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path);
+	u32 (*chan_to_rf18_val)(struct rtw89_dev *rtwdev,
+				const struct rtw89_chan *chan);
 	void (*ctrl_btg_bt_rx)(struct rtw89_dev *rtwdev, bool en,
 			       enum rtw89_phy_idx phy_idx);
 	void (*query_ppdu)(struct rtw89_dev *rtwdev,
@@ -6881,6 +6883,17 @@ static inline u8 rtw89_chip_get_thermal(struct rtw89_dev *rtwdev,
 	return chip->ops->get_thermal(rtwdev, rf_path);
 }
 
+static inline u32 rtw89_chip_chan_to_rf18_val(struct rtw89_dev *rtwdev,
+					      const struct rtw89_chan *chan)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (!chip->ops->chan_to_rf18_val)
+		return 0;
+
+	return chip->ops->chan_to_rf18_val(rtwdev, chan);
+}
+
 static inline void rtw89_chip_query_ppdu(struct rtw89_dev *rtwdev,
 					 struct rtw89_rx_phy_ppdu *phy_ppdu,
 					 struct ieee80211_rx_status *status)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index fafa200a9c8d..39df1a255095 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2402,6 +2402,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.set_txpwr_ctrl		= rtw8851b_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8851b_init_txpwr_unit,
 	.get_thermal		= rtw8851b_get_thermal,
+	.chan_to_rf18_val	= NULL,
 	.ctrl_btg_bt_rx		= rtw8851b_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8851b_query_ppdu,
 	.convert_rpl_to_rssi	= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index cd5987fc52d7..dc4eab2e7919 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2128,6 +2128,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.set_txpwr_ctrl		= rtw8852a_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852a_init_txpwr_unit,
 	.get_thermal		= rtw8852a_get_thermal,
+	.chan_to_rf18_val	= NULL,
 	.ctrl_btg_bt_rx		= rtw8852a_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852a_query_ppdu,
 	.convert_rpl_to_rssi	= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index dacdb384de2c..1f1e10f2b39d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -755,6 +755,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.set_txpwr_ctrl		= rtw8852bx_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852bx_init_txpwr_unit,
 	.get_thermal		= rtw8852bx_get_thermal,
+	.chan_to_rf18_val	= NULL,
 	.ctrl_btg_bt_rx		= rtw8852bx_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852bx_query_ppdu,
 	.convert_rpl_to_rssi	= rtw8852bx_convert_rpl_to_rssi,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 289dce688d72..4c34f5037908 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -689,6 +689,7 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.set_txpwr_ctrl		= rtw8852bx_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852bx_init_txpwr_unit,
 	.get_thermal		= rtw8852bx_get_thermal,
+	.chan_to_rf18_val	= NULL,
 	.ctrl_btg_bt_rx		= rtw8852bx_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852bx_query_ppdu,
 	.convert_rpl_to_rssi	= rtw8852bx_convert_rpl_to_rssi,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 2a6143a8d256..b39add1b798c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2948,6 +2948,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.set_txpwr_ctrl		= rtw8852c_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852c_init_txpwr_unit,
 	.get_thermal		= rtw8852c_get_thermal,
+	.chan_to_rf18_val	= NULL,
 	.ctrl_btg_bt_rx		= rtw8852c_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852c_query_ppdu,
 	.convert_rpl_to_rssi	= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 680168f31466..ca32ccb00107 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2390,6 +2390,48 @@ static u8 rtw8922a_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_p
 	return clamp_t(int, th, 0, U8_MAX);
 }
 
+static u32 rtw8922a_chan_to_rf18_val(struct rtw89_dev *rtwdev,
+				     const struct rtw89_chan *chan)
+{
+	u32 val = u32_encode_bits(chan->channel, RR_CFGCH_CH);
+
+	switch (chan->band_type) {
+	case RTW89_BAND_2G:
+	default:
+		break;
+	case RTW89_BAND_5G:
+		val |= u32_encode_bits(CFGCH_BAND1_5G, RR_CFGCH_BAND1) |
+		       u32_encode_bits(CFGCH_BAND0_5G, RR_CFGCH_BAND0);
+		break;
+	case RTW89_BAND_6G:
+		val |= u32_encode_bits(CFGCH_BAND1_6G, RR_CFGCH_BAND1) |
+		       u32_encode_bits(CFGCH_BAND0_6G, RR_CFGCH_BAND0);
+		break;
+	}
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_5:
+	case RTW89_CHANNEL_WIDTH_10:
+	case RTW89_CHANNEL_WIDTH_20:
+	default:
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		val |= u32_encode_bits(CFGCH_BW_V2_40M, RR_CFGCH_BW_V2);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		val |= u32_encode_bits(CFGCH_BW_V2_80M, RR_CFGCH_BW_V2);
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		val |= u32_encode_bits(CFGCH_BW_V2_160M, RR_CFGCH_BW_V2);
+		break;
+	case RTW89_CHANNEL_WIDTH_320:
+		val |= u32_encode_bits(CFGCH_BW_V2_320M, RR_CFGCH_BW_V2);
+		break;
+	}
+
+	return val;
+}
+
 static void rtw8922a_btc_set_rfe(struct rtw89_dev *rtwdev)
 {
 	union rtw89_btc_module_info *md = &rtwdev->btc.mdinfo;
@@ -2761,6 +2803,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.set_txpwr_ctrl		= rtw8922a_set_txpwr_ctrl,
 	.init_txpwr_unit	= NULL,
 	.get_thermal		= rtw8922a_get_thermal,
+	.chan_to_rf18_val	= rtw8922a_chan_to_rf18_val,
 	.ctrl_btg_bt_rx		= rtw8922a_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8922a_query_ppdu,
 	.convert_rpl_to_rssi	= rtw8922a_convert_rpl_to_rssi,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
index 1659ea64ade1..fce094c7ce93 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -36,8 +36,7 @@ void rtw8922a_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx)
 
 static
 void rtw8922a_ctl_band_ch_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			     u8 central_ch, enum rtw89_band band,
-			     enum rtw89_bandwidth bw)
+			     const struct rtw89_chan *chan)
 {
 	const u32 rf_addr[2] = {RR_CFGCH, RR_CFGCH_V1};
 	struct rtw89_hal *hal = &rtwdev->hal;
@@ -73,49 +72,9 @@ void rtw8922a_ctl_band_ch_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				return;
 			}
 
-			rf_reg[path][i] &= ~(RR_CFGCH_BAND1 | RR_CFGCH_BW |
+			rf_reg[path][i] &= ~(RR_CFGCH_BAND1 | RR_CFGCH_BW_V2 |
 					     RR_CFGCH_BAND0 | RR_CFGCH_CH);
-			rf_reg[path][i] |= u32_encode_bits(central_ch, RR_CFGCH_CH);
-
-			switch (band) {
-			case RTW89_BAND_2G:
-			default:
-				break;
-			case RTW89_BAND_5G:
-				rf_reg[path][i] |=
-					u32_encode_bits(CFGCH_BAND1_5G, RR_CFGCH_BAND1) |
-					u32_encode_bits(CFGCH_BAND0_5G, RR_CFGCH_BAND0);
-				break;
-			case RTW89_BAND_6G:
-				rf_reg[path][i] |=
-					u32_encode_bits(CFGCH_BAND1_6G, RR_CFGCH_BAND1) |
-					u32_encode_bits(CFGCH_BAND0_6G, RR_CFGCH_BAND0);
-				break;
-			}
-
-			switch (bw) {
-			case RTW89_CHANNEL_WIDTH_5:
-			case RTW89_CHANNEL_WIDTH_10:
-			case RTW89_CHANNEL_WIDTH_20:
-			default:
-				break;
-			case RTW89_CHANNEL_WIDTH_40:
-				rf_reg[path][i] |=
-					u32_encode_bits(CFGCH_BW_V2_40M, RR_CFGCH_BW_V2);
-				break;
-			case RTW89_CHANNEL_WIDTH_80:
-				rf_reg[path][i] |=
-					u32_encode_bits(CFGCH_BW_V2_80M, RR_CFGCH_BW_V2);
-				break;
-			case RTW89_CHANNEL_WIDTH_160:
-				rf_reg[path][i] |=
-					u32_encode_bits(CFGCH_BW_V2_160M, RR_CFGCH_BW_V2);
-				break;
-			case RTW89_CHANNEL_WIDTH_320:
-				rf_reg[path][i] |=
-					u32_encode_bits(CFGCH_BW_V2_320M, RR_CFGCH_BW_V2);
-				break;
-			}
+			rf_reg[path][i] |= rtw89_chip_chan_to_rf18_val(rtwdev, chan);
 
 			rtw89_write_rf(rtwdev, path, rf_addr[i],
 				       RFREG_MASK, rf_reg[path][i]);
@@ -126,7 +85,7 @@ void rtw8922a_ctl_band_ch_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	if (hal->cv != CHIP_CAV)
 		return;
 
-	if (band == RTW89_BAND_2G) {
+	if (chan->band_type == RTW89_BAND_2G) {
 		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x80000);
 		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x00003);
 		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD1, RFREG_MASK, 0x0c990);
@@ -145,8 +104,7 @@ void rtw8922a_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx)
 {
-	rtw8922a_ctl_band_ch_bw(rtwdev, phy_idx, chan->channel, chan->band_type,
-				chan->band_width);
+	rtw8922a_ctl_band_ch_bw(rtwdev, phy_idx, chan);
 }
 
 enum _rf_syn_pow {
-- 
2.25.1


