Return-Path: <linux-wireless+bounces-25161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF6FAFF80B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F73AFCF1
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE0722B8A4;
	Thu, 10 Jul 2025 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iTD0ERoJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBBD206F27
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121553; cv=none; b=SjiHCZKuJDtRdbM1DsPxJr3BdN9ycObPtH7PrB92fNUWw2m+MFLdJVkYT2vtMBjDXmeiX3fNFEbBgDn5LpQWxSXNdWkaUD16ueNWM5a6Ed2bJ2AlAc+htBAkc+0BaAluOrC4fpzNWfbAYdu9RJQeUgAPRYOrIvYZh6pt4RlJ4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121553; c=relaxed/simple;
	bh=1n6qD43vRBlFtfUPMczihWcAtZ6IWcRqiXvOy7+pyog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avPk4ADsSvuCpt2BEzHW5xkxcwUebhlP/3wQZSR5wyn5cOyHpP3zPpSYobwIm4EEmcDJUacRTxpQyFjFR9AaoWJTPzxVlac/k/gbNyisjPqUnBk0JiXi7mKnlEGeO4c+J9ZgH5gTaJTc8gs6uGamAk43CYMJfGw+/gUoHeiUrTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iTD0ERoJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4PordE2455882, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121550; bh=4nGx5XVTNXaHmkGSylVH3/dPISlkaO/uMj3Wq1qAKsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iTD0ERoJPltXqhhWejddfky+xJBjpR37jrqeye4GOu+CV49r4PL27TmLnsVNfawsy
	 G0itfL+/Rgx9QPzs2+VrSIgyjcbknRPfqH+I9bOZkxDe8+AO+vWngQ1ZDcclU3Z1dI
	 usmpvO0N/rADyfU1j2YK2E1v/7VaCwqyoQxsz1lmag5cVjOgi3QAOyrhP1mvgQMBba
	 4kJX8+vZDNKl+w3r3f+pKGBUDQ9+Jyys73LtXRCeko+ufOPSOjnOKlcSiuCiL3ePQt
	 XZNS4QqaOUXrmYTSTJ+iLXaWQq3Q8oFe2oYWuELtrOXMdSyLVCs8syC9QUNFBM2FPg
	 324PSS0uBS/rA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4PordE2455882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:25:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:25:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:25:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 12/14] wifi: rtw89: 8852bt: implement RFK multi-channel handling and support chanctx up to 2
Date: Thu, 10 Jul 2025 12:24:21 +0800
Message-ID: <20250710042423.73617-13-pkshih@realtek.com>
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
 .../net/wireless/realtek/rtw89/rtw8852bt.c    | 12 +++-
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 69 ++++++++++++++-----
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |  3 +
 3 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 10d09c12f318..06a06c190553 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -533,8 +533,11 @@ static void rtw8852bt_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 
 static void rtw8852bt_rfk_init(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+
 	rtwdev->is_tssi_mode[RF_PATH_A] = false;
 	rtwdev->is_tssi_mode[RF_PATH_B] = false;
+	memset(rfk_mcc, 0, sizeof(*rfk_mcc));
 
 	rtw8852bt_dpk_init(rtwdev);
 	rtw8852bt_rck(rtwdev);
@@ -548,6 +551,7 @@ static void rtw8852bt_rfk_channel(struct rtw89_dev *rtwdev,
 	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
 	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 
+	rtw8852bt_mcc_get_ch_info(rtwdev, phy_idx);
 	rtw89_btc_ntfy_conn_rfk(rtwdev, true);
 
 	rtw8852bt_rx_dck(rtwdev, phy_idx, chanctx_idx);
@@ -558,6 +562,7 @@ static void rtw8852bt_rfk_channel(struct rtw89_dev *rtwdev,
 	rtw8852bt_dpk(rtwdev, phy_idx, chanctx_idx);
 
 	rtw89_btc_ntfy_conn_rfk(rtwdev, false);
+	rtw89_fw_h2c_rf_ntfy_mcc(rtwdev);
 }
 
 static void rtw8852bt_rfk_band_changed(struct rtw89_dev *rtwdev,
@@ -727,6 +732,10 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.btc_set_policy		= rtw89_btc_set_policy_v1,
 };
 
+static const struct rtw89_chanctx_listener rtw8852bt_chanctx_listener = {
+	.callbacks[RTW89_CHANCTX_CALLBACK_RFK] = rtw8852bt_rfk_chanctx_cb,
+};
+
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8852bt = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
@@ -769,6 +778,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.nctl_post_table	= NULL,
 	.dflt_parms		= NULL,
 	.rfe_parms_conf		= NULL,
+	.chanctx_listener	= &rtw8852bt_chanctx_listener,
 	.txpwr_factor_bb	= 3,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
@@ -777,7 +787,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.tssi_dbw_table		= NULL,
 	.support_macid_num	= RTW89_MAX_MAC_ID_NUM,
 	.support_link_num       = 0,
-	.support_chanctx_num	= 1,
+	.support_chanctx_num	= 2,
 	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 6e6889eea9a0..d0e299803225 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2024 Realtek Corporation
  */
 
+#include "chan.h"
 #include "coex.h"
 #include "debug.h"
 #include "fw.h"
@@ -1529,26 +1530,11 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u
 			     enum rtw89_chanctx_idx chanctx_idx)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
-	u8 get_empty_table = false;
+	u8 idx = rfk_mcc->table_idx;
 	u32 reg_rf18;
 	u32 reg_35c;
-	u8 idx;
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
@@ -1640,7 +1626,8 @@ static void _iqk_afebb_restore(struct rtw89_dev *rtwdev,
 
 static void _iqk_preset(struct rtw89_dev *rtwdev, u8 path)
 {
-	u8 idx = 0;
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
+	u8 idx = rfk_mcc->table_idx;
 
 	rtw89_phy_write32_mask(rtwdev, R_COEF_SEL + (path << 8), 0x00000001, idx);
 	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), 0x00000008, idx);
@@ -4252,3 +4239,49 @@ void rtw8852bt_set_channel_rf(struct rtw89_dev *rtwdev,
 	rtw8852bt_ctrl_bw_ch(rtwdev, phy_idx, chan->channel, chan->band_type,
 			     chan->band_width);
 }
+
+void rtw8852bt_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
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
+void rtw8852bt_rfk_chanctx_cb(struct rtw89_dev *rtwdev,
+			      enum rtw89_chanctx_state state)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 path;
+
+	switch (state) {
+	case RTW89_CHANCTX_STATE_MCC_START:
+		dpk->is_dpk_enable = false;
+		for (path = 0; path < RTW8852BT_SS; path++)
+			_dpk_onoff(rtwdev, path, false);
+		break;
+	case RTW89_CHANCTX_STATE_MCC_STOP:
+		dpk->is_dpk_enable = true;
+		for (path = 0; path < RTW8852BT_SS; path++)
+			_dpk_onoff(rtwdev, path, false);
+		rtw8852bt_dpk(rtwdev, RTW89_PHY_0, RTW89_CHANCTX_0);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
index e34560b4905f..a663bbda4075 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
@@ -27,5 +27,8 @@ void rtw8852bt_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
 void rtw8852bt_set_channel_rf(struct rtw89_dev *rtwdev,
 			      const struct rtw89_chan *chan,
 			      enum rtw89_phy_idx phy_idx);
+void rtw8852bt_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8852bt_rfk_chanctx_cb(struct rtw89_dev *rtwdev,
+			      enum rtw89_chanctx_state state);
 
 #endif
-- 
2.25.1


