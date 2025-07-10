Return-Path: <linux-wireless+bounces-25163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DB9AFF80D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F420C1C4825E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F892F3E;
	Thu, 10 Jul 2025 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kSUnEzBO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC24C239E89
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121563; cv=none; b=tGOxDyP/5G8aSZaJMTzUQuRZk4oc1Bkcu1QccmJNxzL9ByS+Yf+Fqt4waDFlKqjfz2m97N8YqpJSlmv9Pcu/HkuUOBh+0CqEBR1fayMp9pQ33FzoQi6uHpEB7yYidN43nN2arQC9/NT0NlaYcq8jfHXQLGKFJnpw33THYbvneEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121563; c=relaxed/simple;
	bh=kWiyfnWfxW5rSBS86Si+TG6qNa9mMX4DeMj/+c1W2Vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pynuHHC/dpUkv6KnQMuhH5NMaQgqc+XYStGE+qbzaVJH2s6hnozVH0gV8JphLz9JoM1MP7OEi55Grdb7qJB126ktpemymT5jXD3ssJctimb1Z56kQTsVgnvUIhSCRYwVQkCgLVZl3X8leQI4nAtiaNsGFutjv6s6y7C92cNl6Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kSUnEzBO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4Q05z82455909, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121560; bh=C+a5fHSLe7prUwuSa51h3QN/9SjcTg59etEPZiJVxfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=kSUnEzBObYeA8V0YnUoDEDh4h15l/t2MKhvzLvpKBHKIdYIdJ6o0Fd1X1aGDKF7Gh
	 a9uBK8jxbZjdFvhwmPQ/q4FzFissWuY8zGTZ4aLKqkY/OcF0rWebHjY+2+wCmgB1/W
	 J46f52DimKY/9+oKTrZ4fe9oNxdoQ6Ikb9+ykpSZJI1rxnxVEZtfDeNBJZvF6VOe/U
	 qfqw/NUvMBg2K/RrBqqrEOCADdzDFM72wzCn3l1IqiovJgoGnkdz0/FPtbFVUNlT6P
	 wNqVd+/Zn7g/TnmOt36AnFJCc/kJ6QKyYFpYoSvN/EbJsjbG4fYm/npGjHwW1+ehc/
	 olIeko2DmUb7Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4Q05z82455909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:26:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:25:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:25:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 14/14] wifi: rtw89: 8852b: implement RFK multi-channel handling and support chanctx up to 2
Date: Thu, 10 Jul 2025 12:24:23 +0800
Message-ID: <20250710042423.73617-15-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710042423.73617-1-pkshih@realtek.com>
References: <20250710042423.73617-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

To support multiple channels, 2 for this case, RFK requires to record each
calibration result for each channel in different RFK tables, and also needs
to notify FW. Then, when FW runs in MCC (multi-channel concurrency), it can
switch to the corresponding calibration result according to the channel.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 12 ++-
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c | 77 +++++++++++++------
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.h |  3 +
 3 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 33ab71d84ffc..389dfac26028 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -628,8 +628,11 @@ static void rtw8852b_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 
 static void rtw8852b_rfk_init(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+
 	rtwdev->is_tssi_mode[RF_PATH_A] = false;
 	rtwdev->is_tssi_mode[RF_PATH_B] = false;
+	memset(rfk_mcc, 0, sizeof(*rfk_mcc));
 
 	rtw8852b_dpk_init(rtwdev);
 	rtw8852b_rck(rtwdev);
@@ -643,6 +646,7 @@ static void rtw8852b_rfk_channel(struct rtw89_dev *rtwdev,
 	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
 	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 
+	rtw8852b_mcc_get_ch_info(rtwdev, phy_idx);
 	rtw89_btc_ntfy_conn_rfk(rtwdev, true);
 
 	rtw8852b_rx_dck(rtwdev, phy_idx, chanctx_idx);
@@ -653,6 +657,7 @@ static void rtw8852b_rfk_channel(struct rtw89_dev *rtwdev,
 	rtw8852b_dpk(rtwdev, phy_idx, chanctx_idx);
 
 	rtw89_btc_ntfy_conn_rfk(rtwdev, false);
+	rtw89_fw_h2c_rf_ntfy_mcc(rtwdev);
 }
 
 static void rtw8852b_rfk_band_changed(struct rtw89_dev *rtwdev,
@@ -861,6 +866,10 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.btc_set_policy		= rtw89_btc_set_policy_v1,
 };
 
+static const struct rtw89_chanctx_listener rtw8852b_chanctx_listener = {
+	.callbacks[RTW89_CHANCTX_CALLBACK_RFK] = rtw8852b_rfk_chanctx_cb,
+};
+
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8852b = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
@@ -909,6 +918,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.nctl_post_table	= NULL,
 	.dflt_parms		= &rtw89_8852b_dflt_parms,
 	.rfe_parms_conf		= NULL,
+	.chanctx_listener	= &rtw8852b_chanctx_listener,
 	.txpwr_factor_bb	= 3,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
@@ -917,7 +927,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.tssi_dbw_table		= NULL,
 	.support_macid_num	= RTW89_MAX_MAC_ID_NUM,
 	.support_link_num	= 0,
-	.support_chanctx_num	= 0,
+	.support_chanctx_num	= 2,
 	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index fbf82d42687b..4796588c0256 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
 
+#include "chan.h"
 #include "coex.h"
 #include "debug.h"
 #include "mac.h"
@@ -1145,19 +1146,19 @@ static void _lok_res_table(struct rtw89_dev *rtwdev, u8 path, u8 ibias)
 
 static bool _lok_finetune_check(struct rtw89_dev *rtwdev, u8 path)
 {
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u8 ch = rfk_mcc->table_idx;
 	bool is_fail1, is_fail2;
 	u32 vbuff_i;
 	u32 vbuff_q;
 	u32 core_i;
 	u32 core_q;
 	u32 tmp;
-	u8 ch;
 
 	tmp = rtw89_read_rf(rtwdev, path, RR_TXMO, RFREG_MASK);
 	core_i = FIELD_GET(RR_TXMO_COI, tmp);
 	core_q = FIELD_GET(RR_TXMO_COQ, tmp);
-	ch = (iqk_info->iqk_times / 2) % RTW89_IQK_CHS_NR;
 
 	if (core_i < 0x2 || core_i > 0x1d || core_q < 0x2 || core_q > 0x1d)
 		is_fail1 = true;
@@ -1386,26 +1387,11 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u
 			     enum rtw89_chanctx_idx chanctx_idx)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
+	u8 idx = rfk_mcc->table_idx;
 	u32 reg_rf18;
 	u32 reg_35c;
-	u8 idx;
-	u8 get_empty_table = false;
-
-	for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
-		if (iqk_info->iqk_mcc_ch[idx][path] == 0) {
-			get_empty_table = true;
-			break;
-		}
-	}
-	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] (1)idx = %x\n", idx);
-
-	if (!get_empty_table) {
-		idx = iqk_info->iqk_table_idx[path] + 1;
-		if (idx > 1)
-			idx = 0;
-	}
-	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] (2)idx = %x\n", idx);
 
 	reg_rf18 = rtw89_read_rf(rtwdev, path, RR_CFGCH, RFREG_MASK);
 	reg_35c = rtw89_phy_read32_mask(rtwdev, R_CIRST, B_CIRST_SYN);
@@ -1506,11 +1492,10 @@ static void _iqk_afebb_restore(struct rtw89_dev *rtwdev,
 
 static void _iqk_preset(struct rtw89_dev *rtwdev, u8 path)
 {
-	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
-	u8 idx;
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
+	u8 idx = rfk_mcc->table_idx;
 
-	idx = iqk_info->iqk_table_idx[path];
-	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] (3)idx = %x\n", idx);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] idx = %x\n", idx);
 
 	rtw89_phy_write32_mask(rtwdev, R_COEF_SEL + (path << 8), B_COEF_SEL_IQC, idx);
 	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_G3, idx);
@@ -4179,3 +4164,49 @@ void rtw8852b_set_channel_rf(struct rtw89_dev *rtwdev,
 	rtw8852b_ctrl_bw_ch(rtwdev, phy_idx, chan->channel, chan->band_type,
 			    chan->band_width);
 }
+
+void rtw8852b_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_chan *chan = rtw89_mgnt_chan_get(rtwdev, 0);
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
+	struct rtw89_rfk_chan_desc desc[__RTW89_RFK_CHS_NR_V0] = {};
+	u8 idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(desc); idx++) {
+		struct rtw89_rfk_chan_desc *p = &desc[idx];
+
+		p->ch = rfk_mcc->ch[idx];
+
+		p->has_band = true;
+		p->band = rfk_mcc->band[idx];
+	}
+
+	idx = rtw89_rfk_chan_lookup(rtwdev, desc, ARRAY_SIZE(desc), chan);
+
+	rfk_mcc->ch[idx] = chan->channel;
+	rfk_mcc->band[idx] = chan->band_type;
+	rfk_mcc->table_idx = idx;
+}
+
+void rtw8852b_rfk_chanctx_cb(struct rtw89_dev *rtwdev,
+			     enum rtw89_chanctx_state state)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 path;
+
+	switch (state) {
+	case RTW89_CHANCTX_STATE_MCC_START:
+		dpk->is_dpk_enable = false;
+		for (path = 0; path < RTW8852B_DPK_RF_PATH; path++)
+			_dpk_onoff(rtwdev, path, false);
+		break;
+	case RTW89_CHANCTX_STATE_MCC_STOP:
+		dpk->is_dpk_enable = true;
+		for (path = 0; path < RTW8852B_DPK_RF_PATH; path++)
+			_dpk_onoff(rtwdev, path, false);
+		rtw8852b_dpk(rtwdev, RTW89_PHY_0, RTW89_CHANCTX_0);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
index c31ba446e6e0..5fae980d5e2c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
@@ -27,5 +27,8 @@ void rtw8852b_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
 void rtw8852b_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx);
+void rtw8852b_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8852b_rfk_chanctx_cb(struct rtw89_dev *rtwdev,
+			     enum rtw89_chanctx_state state);
 
 #endif
-- 
2.25.1


