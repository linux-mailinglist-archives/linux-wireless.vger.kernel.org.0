Return-Path: <linux-wireless+bounces-11607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D19566B1
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C271F23AEB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 09:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8415C132;
	Mon, 19 Aug 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="K+yDBouo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E815ECD7
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059071; cv=none; b=SNsKt/QtVy1E6pj5YFGSY0SkWDH7gyNVoCKQBTxkVxpiXRawzgj1RcaZNUEjv1wmVlwBokC4lb+xArNXjcQynW80B19mpQ4ppfVCqPrFwshY1t28HfI3j9oxshylF8U3qOYia+Xni45O+OUZfd2tzBzVXJLgiYmVsE83K4/rSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059071; c=relaxed/simple;
	bh=R9oSRp16KYNL0yyuLbe6yvcoxBndqD++BgWpFucqPRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEGhKRwbZdQWirtgr3jAioIngGxqwoZjmAcBN4IwHY4S2JNxB8Qs7jlBh+eg94LAp3NWFzig9uWC6apl/Gk83AY1/gNP28xZlJkQDEWnhmTGzu6xnxV6DLC4JG76pEc1hhxhyVTRPfMC+5WRwJ3MBf8La2mFLBNa1erGWOhcAGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=K+yDBouo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J9HiIU24126004, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724059064; bh=R9oSRp16KYNL0yyuLbe6yvcoxBndqD++BgWpFucqPRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=K+yDBouo1yftMDQRQgmQwScqzG4RI2Ae8BR1KtbnefzXg1244uhCSqQknNVMlQcY4
	 SMygz0LiU/wJDANtPyJYhibfZEvnfuaQeAAPYjpKPc8MhS/nWrg79DPhCq/MPUFb2t
	 8nMO2+BbPxTQ1bySOY2B+/1kv6vUJvjqQVcrX+B+CgMjrsYWQfldHmEUA+sSwsS3xo
	 JEOHPH1Rzo1/6HANmutUS2gjG+/OQpg3lq+mtU4ArIMIlielW9R0TcUpIcNA3/xVuW
	 Cd9wMBMZmEa2Bgl+avqjMFklDNszVwzGgeLbuuHbNzMvFhQsBlX7JUC//xW+e6MxOA
	 tDezxXT40UHNg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J9HiIU24126004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:17:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 17:17:45 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 19 Aug
 2024 17:17:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 3/8] wifi: rtw89: 8852a: use right chanctx whenever possible in RFK flow
Date: Mon, 19 Aug 2024 17:17:19 +0800
Message-ID: <20240819091724.33730-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240819091724.33730-1-pkshih@realtek.com>
References: <20240819091724.33730-1-pkshih@realtek.com>
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

No longer access chan with hard-code RTW89_CHANCTX_X whenever possible.
Instead, obtain the right chanctx from somewhere and use it in RTL8852A
RFK (RF calibration) related code.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  23 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.h |   4 +-
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c | 292 ++++++++++--------
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.h |  17 +-
 4 files changed, 185 insertions(+), 151 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 365f074108d4..1034d8b29f5d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1346,25 +1346,26 @@ static void rtw8852a_rfk_init(struct rtw89_dev *rtwdev)
 	rtwdev->is_tssi_mode[RF_PATH_B] = false;
 
 	rtw8852a_rck(rtwdev);
-	rtw8852a_dack(rtwdev);
-	rtw8852a_rx_dck(rtwdev, RTW89_PHY_0, true);
+	rtw8852a_dack(rtwdev, RTW89_CHANCTX_0);
+	rtw8852a_rx_dck(rtwdev, RTW89_PHY_0, true, RTW89_CHANCTX_0);
 }
 
 static void rtw8852a_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif->chanctx_idx;
 	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
 
-	rtw8852a_rx_dck(rtwdev, phy_idx, true);
-	rtw8852a_iqk(rtwdev, phy_idx);
-	rtw8852a_tssi(rtwdev, phy_idx);
-	rtw8852a_dpk(rtwdev, phy_idx);
+	rtw8852a_rx_dck(rtwdev, phy_idx, true, chanctx_idx);
+	rtw8852a_iqk(rtwdev, phy_idx, chanctx_idx);
+	rtw8852a_tssi(rtwdev, phy_idx, chanctx_idx);
+	rtw8852a_dpk(rtwdev, phy_idx, chanctx_idx);
 }
 
 static void rtw8852a_rfk_band_changed(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx,
 				      const struct rtw89_chan *chan)
 {
-	rtw8852a_tssi_scan(rtwdev, phy_idx);
+	rtw8852a_tssi_scan(rtwdev, phy_idx, chan);
 }
 
 static void rtw8852a_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
@@ -1550,10 +1551,8 @@ static void rtw8852a_start_pmac_tx(struct rtw89_dev *rtwdev,
 
 void rtw8852a_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
 			     struct rtw8852a_bb_pmac_info *tx_info,
-			     enum rtw89_phy_idx idx)
+			     enum rtw89_phy_idx idx, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
-
 	if (!tx_info->en_pmac_tx) {
 		rtw8852a_stop_pmac_tx(rtwdev, tx_info, idx);
 		rtw89_phy_write32_idx(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0, idx);
@@ -1575,7 +1574,7 @@ void rtw8852a_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
 
 void rtw8852a_bb_set_pmac_pkt_tx(struct rtw89_dev *rtwdev, u8 enable,
 				 u16 tx_cnt, u16 period, u16 tx_time,
-				 enum rtw89_phy_idx idx)
+				 enum rtw89_phy_idx idx, const struct rtw89_chan *chan)
 {
 	struct rtw8852a_bb_pmac_info tx_info = {0};
 
@@ -1585,7 +1584,7 @@ void rtw8852a_bb_set_pmac_pkt_tx(struct rtw89_dev *rtwdev, u8 enable,
 	tx_info.tx_cnt = tx_cnt;
 	tx_info.period = period;
 	tx_info.tx_time = tx_time;
-	rtw8852a_bb_set_pmac_tx(rtwdev, &tx_info, idx);
+	rtw8852a_bb_set_pmac_tx(rtwdev, &tx_info, idx, chan);
 }
 
 void rtw8852a_bb_set_power(struct rtw89_dev *rtwdev, s16 pwr_dbm,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.h b/drivers/net/wireless/realtek/rtw89/rtw8852a.h
index ea82fed7b7be..d6c1acd09238 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.h
@@ -97,10 +97,10 @@ extern const struct rtw89_chip_info rtw8852a_chip_info;
 void rtw8852a_bb_set_plcp_tx(struct rtw89_dev *rtwdev);
 void rtw8852a_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
 			     struct rtw8852a_bb_pmac_info *tx_info,
-			     enum rtw89_phy_idx idx);
+			     enum rtw89_phy_idx idx, const struct rtw89_chan *chan);
 void rtw8852a_bb_set_pmac_pkt_tx(struct rtw89_dev *rtwdev, u8 enable,
 				 u16 tx_cnt, u16 period, u16 tx_time,
-				 enum rtw89_phy_idx idx);
+				 enum rtw89_phy_idx idx, const struct rtw89_chan *chan);
 void rtw8852a_bb_set_power(struct rtw89_dev *rtwdev, s16 pwr_dbm,
 			   enum rtw89_phy_idx idx);
 void rtw8852a_bb_cfg_tx_path(struct rtw89_dev *rtwdev, u8 tx_path);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index 6bae8bc07e93..9db8713ac99b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -493,11 +493,12 @@ static void _dack(struct rtw89_dev *rtwdev)
 	_dack_s1(rtwdev);
 }
 
-static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
+static void _dac_cal(struct rtw89_dev *rtwdev, bool force,
+		     enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_dack_info *dack = &rtwdev->dack;
 	u32 rf0_0, rf1_0;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, RF_AB, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, RF_AB, chanctx_idx);
 
 	dack->dack_done = false;
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK b\n");
@@ -799,12 +800,13 @@ static bool _iqk_check_cal(struct rtw89_dev *rtwdev, u8 path, u8 ktype)
 }
 
 static bool _iqk_one_shot(struct rtw89_dev *rtwdev,
-			  enum rtw89_phy_idx phy_idx, u8 path, u8 ktype)
+			  enum rtw89_phy_idx phy_idx, u8 path, u8 ktype,
+			  enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	bool fail = false;
 	u32 iqk_cmd = 0x0;
-	u8 phy_map = rtw89_btc_path_phymap(rtwdev, phy_idx, path, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_path_phymap(rtwdev, phy_idx, path, chanctx_idx);
 	u32 addr_rfc_ctl = 0x0;
 
 	if (path == RF_PATH_A)
@@ -888,7 +890,8 @@ static bool _iqk_one_shot(struct rtw89_dev *rtwdev,
 }
 
 static bool _rxk_group_sel(struct rtw89_dev *rtwdev,
-			   enum rtw89_phy_idx phy_idx, u8 path)
+			   enum rtw89_phy_idx phy_idx, u8 path,
+			   enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	static const u32 rxgn_a[4] = {0x18C, 0x1A0, 0x28C, 0x2A0};
@@ -927,7 +930,7 @@ static bool _rxk_group_sel(struct rtw89_dev *rtwdev,
 		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_GP, gp);
 		rtw89_phy_write32_mask(rtwdev, R_IOQ_IQK_DPK, B_IOQ_IQK_DPK_EN, 0x1);
 		rtw89_phy_write32_clr(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP);
-		fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXK);
+		fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_RXK, chanctx_idx);
 		rtw89_phy_write32_mask(rtwdev, R_IQKINF, BIT(16 + gp + path * 4), fail);
 	}
 
@@ -952,7 +955,8 @@ static bool _rxk_group_sel(struct rtw89_dev *rtwdev,
 }
 
 static bool _iqk_nbrxk(struct rtw89_dev *rtwdev,
-		       enum rtw89_phy_idx phy_idx, u8 path)
+		       enum rtw89_phy_idx phy_idx, u8 path,
+		       enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u8 group = 0x0;
@@ -991,7 +995,7 @@ static bool _iqk_nbrxk(struct rtw89_dev *rtwdev,
 			       B_CFIR_LUT_GP, group);
 	rtw89_phy_write32_set(rtwdev, R_IOQ_IQK_DPK, B_IOQ_IQK_DPK_EN);
 	rtw89_phy_write32_clr(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP);
-	fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK);
+	fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBRXK, chanctx_idx);
 
 	switch (iqk_info->iqk_band[path]) {
 	case RTW89_BAND_2G:
@@ -1040,7 +1044,8 @@ static void _iqk_rxclk_setting(struct rtw89_dev *rtwdev, u8 path)
 }
 
 static bool _txk_group_sel(struct rtw89_dev *rtwdev,
-			   enum rtw89_phy_idx phy_idx, u8 path)
+			   enum rtw89_phy_idx phy_idx, u8 path,
+			   enum rtw89_chanctx_idx chanctx_idx)
 {
 	static const u32 a_txgain[4] = {0xE466, 0x646D, 0xE4E2, 0x64ED};
 	static const u32 g_txgain[4] = {0x60e8, 0x60f0, 0x61e8, 0x61ED};
@@ -1083,7 +1088,7 @@ static bool _txk_group_sel(struct rtw89_dev *rtwdev,
 		rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8),
 				       B_CFIR_LUT_GP, gp);
 		rtw89_phy_write32_clr(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP);
-		fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_TXK);
+		fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_TXK, chanctx_idx);
 		rtw89_phy_write32_mask(rtwdev, R_IQKINF, BIT(8 + gp + path * 4), fail);
 	}
 
@@ -1098,7 +1103,8 @@ static bool _txk_group_sel(struct rtw89_dev *rtwdev,
 }
 
 static bool _iqk_nbtxk(struct rtw89_dev *rtwdev,
-		       enum rtw89_phy_idx phy_idx, u8 path)
+		       enum rtw89_phy_idx phy_idx, u8 path,
+		       enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u8 group = 0x2;
@@ -1131,7 +1137,7 @@ static bool _iqk_nbtxk(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_GP, group);
 	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), MASKDWORD, itqt);
 	rtw89_phy_write32_clr(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP);
-	fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK);
+	fail = _iqk_one_shot(rtwdev, phy_idx, path, ID_NBTXK, chanctx_idx);
 	if (!fail) {
 		tmp = rtw89_phy_read32_mask(rtwdev, R_TXIQC + (path << 8), MASKDWORD);
 		iqk_info->nb_txcfir[path] = tmp | 0x2;
@@ -1179,7 +1185,8 @@ static bool _lok_finetune_check(struct rtw89_dev *rtwdev, u8 path)
 }
 
 static bool _iqk_lok(struct rtw89_dev *rtwdev,
-		     enum rtw89_phy_idx phy_idx, u8 path)
+		     enum rtw89_phy_idx phy_idx, u8 path,
+		     enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u32 rf0 = 0x0;
@@ -1210,11 +1217,11 @@ static bool _iqk_lok(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_set(rtwdev, R_IOQ_IQK_DPK, B_IOQ_IQK_DPK_EN);
 	rtw89_phy_write32_clr(rtwdev, R_NCTL_N1, B_NCTL_N1_CIP);
 	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), MASKDWORD, itqt);
-	tmp = _iqk_one_shot(rtwdev, phy_idx, path, ID_FLOK_COARSE);
+	tmp = _iqk_one_shot(rtwdev, phy_idx, path, ID_FLOK_COARSE, chanctx_idx);
 	iqk_info->lok_cor_fail[0][path] = tmp;
 	fsleep(10);
 	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), MASKDWORD, itqt);
-	tmp = _iqk_one_shot(rtwdev, phy_idx, path, ID_FLOK_FINE);
+	tmp = _iqk_one_shot(rtwdev, phy_idx, path, ID_FLOK_FINE, chanctx_idx);
 	iqk_info->lok_fin_fail[0][path] = tmp;
 	fail = _lok_finetune_check(rtwdev, path);
 	return fail;
@@ -1321,7 +1328,8 @@ static void _iqk_info_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 }
 
 static
-void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
+void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path,
+		  enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	bool lok_is_fail = false;
@@ -1333,30 +1341,35 @@ void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8 path)
 	for (i = 0; i < 3; i++) {
 		_lok_res_table(rtwdev, path, ibias++);
 		_iqk_txk_setting(rtwdev, path);
-		lok_is_fail = _iqk_lok(rtwdev, phy_idx, path);
+		lok_is_fail = _iqk_lok(rtwdev, phy_idx, path, chanctx_idx);
 		if (!lok_is_fail)
 			break;
 	}
 	if (iqk_info->is_nbiqk)
-		iqk_info->iqk_tx_fail[0][path] = _iqk_nbtxk(rtwdev, phy_idx, path);
+		iqk_info->iqk_tx_fail[0][path] = _iqk_nbtxk(rtwdev, phy_idx, path,
+							    chanctx_idx);
 	else
-		iqk_info->iqk_tx_fail[0][path] = _txk_group_sel(rtwdev, phy_idx, path);
+		iqk_info->iqk_tx_fail[0][path] = _txk_group_sel(rtwdev, phy_idx, path,
+								chanctx_idx);
 
 	_iqk_rxclk_setting(rtwdev, path);
 	_iqk_rxk_setting(rtwdev, path);
 	if (iqk_info->is_nbiqk || rtwdev->dbcc_en || iqk_info->iqk_band[path] == RTW89_BAND_2G)
-		iqk_info->iqk_rx_fail[0][path] = _iqk_nbrxk(rtwdev, phy_idx, path);
+		iqk_info->iqk_rx_fail[0][path] = _iqk_nbrxk(rtwdev, phy_idx, path,
+							    chanctx_idx);
 	else
-		iqk_info->iqk_rx_fail[0][path] = _rxk_group_sel(rtwdev, phy_idx, path);
+		iqk_info->iqk_rx_fail[0][path] = _rxk_group_sel(rtwdev, phy_idx, path,
+								chanctx_idx);
 
 	_iqk_info_iqk(rtwdev, phy_idx, path);
 }
 
 static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
-			     enum rtw89_phy_idx phy, u8 path)
+			     enum rtw89_phy_idx phy, u8 path,
+			     enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	u32 reg_rf18 = 0x0, reg_35c = 0x0;
 	u8 idx = 0;
 	u8 get_empty_table = false;
@@ -1413,9 +1426,9 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
 }
 
 static void _iqk_start_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
-			   u8 path)
+			   u8 path, enum rtw89_chanctx_idx chanctx_idx)
 {
-	_iqk_by_path(rtwdev, phy_idx, path);
+	_iqk_by_path(rtwdev, phy_idx, path, chanctx_idx);
 }
 
 static void _iqk_restore(struct rtw89_dev *rtwdev, u8 path)
@@ -1513,7 +1526,8 @@ static void _iqk_macbb_setting(struct rtw89_dev *rtwdev,
 	rtw89_rfk_parser(rtwdev, tbl);
 }
 
-static void _iqk_dbcc(struct rtw89_dev *rtwdev, u8 path)
+static void _iqk_dbcc(struct rtw89_dev *rtwdev, u8 path,
+		      enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u8 phy_idx = 0x0;
@@ -1525,10 +1539,10 @@ static void _iqk_dbcc(struct rtw89_dev *rtwdev, u8 path)
 	else
 		phy_idx = RTW89_PHY_1;
 
-	_iqk_get_ch_info(rtwdev, phy_idx, path);
+	_iqk_get_ch_info(rtwdev, phy_idx, path, chanctx_idx);
 	_iqk_macbb_setting(rtwdev, phy_idx, path);
 	_iqk_preset(rtwdev, path);
-	_iqk_start_iqk(rtwdev, phy_idx, path);
+	_iqk_start_iqk(rtwdev, phy_idx, path, chanctx_idx);
 	_iqk_restore(rtwdev, path);
 	_iqk_afebb_restore(rtwdev, phy_idx, path);
 }
@@ -1607,12 +1621,13 @@ static void _iqk_init(struct rtw89_dev *rtwdev)
 }
 
 static void _doiqk(struct rtw89_dev *rtwdev, bool force,
-		   enum rtw89_phy_idx phy_idx, u8 path)
+		   enum rtw89_phy_idx phy_idx, u8 path,
+		   enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u32 backup_bb_val[BACKUP_BB_REGS_NR];
 	u32 backup_rf_val[RTW8852A_IQK_SS][BACKUP_RF_REGS_NR];
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
@@ -1622,12 +1637,12 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	iqk_info->version = RTW8852A_IQK_VER;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]Test Ver 0x%x\n", iqk_info->version);
-	_iqk_get_ch_info(rtwdev, phy_idx, path);
+	_iqk_get_ch_info(rtwdev, phy_idx, path, chanctx_idx);
 	_rfk_backup_bb_reg(rtwdev, &backup_bb_val[0]);
 	_rfk_backup_rf_reg(rtwdev, &backup_rf_val[path][0], path);
 	_iqk_macbb_setting(rtwdev, phy_idx, path);
 	_iqk_preset(rtwdev, path);
-	_iqk_start_iqk(rtwdev, phy_idx, path);
+	_iqk_start_iqk(rtwdev, phy_idx, path, chanctx_idx);
 	_iqk_restore(rtwdev, path);
 	_iqk_afebb_restore(rtwdev, phy_idx, path);
 	_rfk_restore_bb_reg(rtwdev, &backup_bb_val[0]);
@@ -1635,18 +1650,19 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_STOP);
 }
 
-static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool force)
+static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool force,
+		 enum rtw89_chanctx_idx chanctx_idx)
 {
 	switch (_kpath(rtwdev, phy_idx)) {
 	case RF_A:
-		_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_A, chanctx_idx);
 		break;
 	case RF_B:
-		_doiqk(rtwdev, force, phy_idx, RF_PATH_B);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_B, chanctx_idx);
 		break;
 	case RF_AB:
-		_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
-		_doiqk(rtwdev, force, phy_idx, RF_PATH_B);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_A, chanctx_idx);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_B, chanctx_idx);
 		break;
 	default:
 		break;
@@ -1656,9 +1672,10 @@ static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool forc
 #define RXDCK_VER_8852A 0xe
 
 static void _set_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			enum rtw89_rf_path path, bool is_afe)
+			enum rtw89_rf_path path, bool is_afe,
+			enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_path_phymap(rtwdev, phy, path, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_path_phymap(rtwdev, phy, path, chanctx_idx);
 	u32 ori_val;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
@@ -1704,7 +1721,7 @@ static void _set_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-		    bool is_afe)
+		    bool is_afe, enum rtw89_chanctx_idx chanctx_idx)
 {
 	u8 path, kpath, dck_tune;
 	u32 rf_reg5;
@@ -1732,7 +1749,7 @@ static void _rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
 		rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_FINE, 0x0);
 		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, RR_MOD_V_RX);
-		_set_rx_dck(rtwdev, phy, path, is_afe);
+		_set_rx_dck(rtwdev, phy, path, is_afe, chanctx_idx);
 		rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_FINE, dck_tune);
 		rtw89_write_rf(rtwdev, path, RR_RSV1, RFREG_MASK, rf_reg5);
 
@@ -1800,9 +1817,10 @@ static void _dpk_reload_kip(struct rtw89_dev *rtwdev, u32 *reg,
 }
 
 static u8 _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			enum rtw89_rf_path path, enum rtw8852a_dpk_id id)
+			enum rtw89_rf_path path, enum rtw8852a_dpk_id id,
+			enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map  = rtw89_btc_path_phymap(rtwdev, phy, path, RTW89_CHANCTX_0);
+	u8 phy_map  = rtw89_btc_path_phymap(rtwdev, phy, path, chanctx_idx);
 	u16 dpk_cmd = 0x0;
 	u32 val;
 	int ret;
@@ -1841,18 +1859,19 @@ static u8 _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 
 static void _dpk_rx_dck(struct rtw89_dev *rtwdev,
 			enum rtw89_phy_idx phy,
-			enum rtw89_rf_path path)
+			enum rtw89_rf_path path,
+			enum rtw89_chanctx_idx chanctx_idx)
 {
 	rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_EN_TIA_IDA, 0x3);
-	_set_rx_dck(rtwdev, phy, path, false);
+	_set_rx_dck(rtwdev, phy, path, false, chanctx_idx);
 }
 
 static void _dpk_information(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy,
-			     enum rtw89_rf_path path)
+			     enum rtw89_rf_path path, enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	u8 kidx = dpk->cur_idx[path];
 
 	dpk->bp[path][kidx].band = chan->band_type;
@@ -1967,7 +1986,8 @@ static void _dpk_kip_restore(struct rtw89_dev *rtwdev,
 
 static void _dpk_lbk_rxiqk(struct rtw89_dev *rtwdev,
 			   enum rtw89_phy_idx phy,
-			   enum rtw89_rf_path path)
+			   enum rtw89_rf_path path,
+			   enum rtw89_chanctx_idx chanctx_idx)
 {
 	u8 cur_rxbb;
 
@@ -1997,7 +2017,7 @@ static void _dpk_lbk_rxiqk(struct rtw89_dev *rtwdev,
 
 	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x11);
 
-	_dpk_one_shot(rtwdev, phy, path, LBK_RXIQK);
+	_dpk_one_shot(rtwdev, phy, path, LBK_RXIQK, chanctx_idx);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d LBK RXIQC = 0x%x\n", path,
 		    rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD));
@@ -2186,10 +2206,11 @@ static bool _dpk_sync_check(struct rtw89_dev *rtwdev,
 }
 
 static bool _dpk_sync(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-		      enum rtw89_rf_path path, u8 kidx)
+		      enum rtw89_rf_path path, u8 kidx,
+		      enum rtw89_chanctx_idx chanctx_idx)
 {
 	_dpk_tpg_sel(rtwdev, path, kidx);
-	_dpk_one_shot(rtwdev, phy, path, SYNC);
+	_dpk_one_shot(rtwdev, phy, path, SYNC, chanctx_idx);
 	return _dpk_sync_check(rtwdev, path); /*1= fail*/
 }
 
@@ -2242,10 +2263,10 @@ static u8 _dpk_gainloss_read(struct rtw89_dev *rtwdev)
 
 static void _dpk_gainloss(struct rtw89_dev *rtwdev,
 			  enum rtw89_phy_idx phy, enum rtw89_rf_path path,
-			  u8 kidx)
+			  u8 kidx, enum rtw89_chanctx_idx chanctx_idx)
 {
 	_dpk_table_select(rtwdev, path, kidx, 1);
-	_dpk_one_shot(rtwdev, phy, path, GAIN_LOSS);
+	_dpk_one_shot(rtwdev, phy, path, GAIN_LOSS, chanctx_idx);
 }
 
 #define DPK_TXAGC_LOWER 0x2e
@@ -2322,7 +2343,7 @@ static u8 _dpk_pas_read(struct rtw89_dev *rtwdev, bool is_check)
 
 static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		   enum rtw89_rf_path path, u8 kidx, u8 init_txagc,
-		   bool loss_only)
+		   bool loss_only, enum rtw89_chanctx_idx chanctx_idx)
 {
 #define DPK_AGC_ADJ_LMT 6
 #define DPK_DGAIN_UPPER 1922
@@ -2330,7 +2351,7 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 #define DPK_RXBB_UPPER 0x1f
 #define DPK_RXBB_LOWER 0
 #define DPK_GL_CRIT 7
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	u8 tmp_txagc, tmp_rxbb = 0, tmp_gl_idx = 0;
 	u8 agc_cnt = 0;
 	bool limited_rxbb = false;
@@ -2344,7 +2365,7 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	do {
 		switch (step) {
 		case DPK_AGC_STEP_SYNC_DGAIN:
-			if (_dpk_sync(rtwdev, phy, path, kidx)) {
+			if (_dpk_sync(rtwdev, phy, path, kidx, chanctx_idx)) {
 				tmp_txagc = DPK_TXAGC_INVAL;
 				goout = true;
 				break;
@@ -2380,7 +2401,8 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				if (chan->band_width < RTW89_CHANNEL_WIDTH_80)
 					_dpk_bypass_rxcfir(rtwdev, path, true);
 				else
-					_dpk_lbk_rxiqk(rtwdev, phy, path);
+					_dpk_lbk_rxiqk(rtwdev, phy, path,
+						       chanctx_idx);
 			}
 			if (dgain > DPK_DGAIN_UPPER || dgain < DPK_DGAIN_LOWER)
 				step = DPK_AGC_STEP_SYNC_DGAIN;
@@ -2391,7 +2413,7 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			break;
 
 		case DPK_AGC_STEP_GAIN_LOSS_IDX:
-			_dpk_gainloss(rtwdev, phy, path, kidx);
+			_dpk_gainloss(rtwdev, phy, path, kidx, chanctx_idx);
 			tmp_gl_idx = _dpk_gainloss_read(rtwdev);
 
 			if ((tmp_gl_idx == 0 && _dpk_pas_read(rtwdev, true)) ||
@@ -2475,11 +2497,12 @@ static void _dpk_set_mdpd_para(struct rtw89_dev *rtwdev, u8 order)
 }
 
 static void _dpk_idl_mpa(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			 enum rtw89_rf_path path, u8 kidx, u8 gain)
+			 enum rtw89_rf_path path, u8 kidx, u8 gain,
+			 enum rtw89_chanctx_idx chanctx_idx)
 {
 	_dpk_set_mdpd_para(rtwdev, 0x0);
 	_dpk_table_select(rtwdev, path, kidx, 1);
-	_dpk_one_shot(rtwdev, phy, path, MDPK_IDL);
+	_dpk_one_shot(rtwdev, phy, path, MDPK_IDL, chanctx_idx);
 }
 
 static void _dpk_fill_result(struct rtw89_dev *rtwdev,
@@ -2518,10 +2541,10 @@ static void _dpk_fill_result(struct rtw89_dev *rtwdev,
 }
 
 static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			      enum rtw89_rf_path path)
+			      enum rtw89_rf_path path, enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	bool is_reload = false;
 	u8 idx, cur_band, cur_ch;
 
@@ -2545,7 +2568,8 @@ static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-		      enum rtw89_rf_path path, u8 gain)
+		      enum rtw89_rf_path path, u8 gain,
+		      enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	u8 txagc = 0, kidx = dpk->cur_idx[path];
@@ -2558,16 +2582,16 @@ static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	_rf_direct_cntrl(rtwdev, path, false);
 	txagc = _dpk_set_tx_pwr(rtwdev, gain, path);
 	_dpk_rf_setting(rtwdev, gain, path, kidx);
-	_dpk_rx_dck(rtwdev, phy, path);
+	_dpk_rx_dck(rtwdev, phy, path, chanctx_idx);
 
 	_dpk_kip_setting(rtwdev, path, kidx);
 	_dpk_manual_txcfir(rtwdev, path, true);
-	txagc = _dpk_agc(rtwdev, phy, path, kidx, txagc, false);
+	txagc = _dpk_agc(rtwdev, phy, path, kidx, txagc, false, chanctx_idx);
 	if (txagc == DPK_TXAGC_INVAL)
 		is_fail = true;
 	_dpk_get_thermal(rtwdev, kidx, path);
 
-	_dpk_idl_mpa(rtwdev, phy, path, kidx, gain);
+	_dpk_idl_mpa(rtwdev, phy, path, kidx, gain, chanctx_idx);
 	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, RR_MOD_V_RX);
 	_dpk_fill_result(rtwdev, path, kidx, gain, txagc);
 	_dpk_manual_txcfir(rtwdev, path, false);
@@ -2584,7 +2608,8 @@ static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
-			    enum rtw89_phy_idx phy, u8 kpath)
+			    enum rtw89_phy_idx phy, u8 kpath,
+			    enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	u32 backup_bb_val[BACKUP_BB_REGS_NR];
@@ -2599,7 +2624,8 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 			if (!(kpath & BIT(path)))
 				continue;
 
-			reloaded[path] = _dpk_reload_check(rtwdev, phy, path);
+			reloaded[path] = _dpk_reload_check(rtwdev, phy, path,
+							   chanctx_idx);
 			if (!reloaded[path] && dpk->bp[path][0].ch != 0)
 				dpk->cur_idx[path] = !dpk->cur_idx[path];
 			else
@@ -2624,7 +2650,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 			_dpk_tssi_pause(rtwdev, path, true);
 		_dpk_bkup_kip(rtwdev, kip_reg, kip_bkup, path);
 		_rfk_backup_rf_reg(rtwdev, &backup_rf_val[path][0], path);
-		_dpk_information(rtwdev, phy, path);
+		_dpk_information(rtwdev, phy, path, chanctx_idx);
 	}
 
 	_dpk_bb_afe_setting(rtwdev, phy, path, kpath);
@@ -2633,7 +2659,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 		if (!(kpath & BIT(path)) || reloaded[path])
 			continue;
 
-		is_fail = _dpk_main(rtwdev, phy, path, 1);
+		is_fail = _dpk_main(rtwdev, phy, path, 1, chanctx_idx);
 		_dpk_onoff(rtwdev, path, is_fail);
 	}
 
@@ -2652,10 +2678,11 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 	}
 }
 
-static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			      enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_fem_info *fem = &rtwdev->fem;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 
 	if (fem->epa_2g && chan->band_type == RTW89_BAND_2G) {
 		rtw89_debug(rtwdev, RTW89_DBG_RFK,
@@ -2682,17 +2709,19 @@ static void _dpk_force_bypass(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	}
 }
 
-static void _dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool force)
+static void _dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		 bool force, enum rtw89_chanctx_idx chanctx_idx)
 {
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] ****** DPK Start (Ver: 0x%x, Cv: %d, RF_para: %d) ******\n",
 		    RTW8852A_DPK_VER, rtwdev->hal.cv,
 		    RTW8852A_RF_REL_VERSION);
 
-	if (_dpk_bypass_check(rtwdev, phy))
+	if (_dpk_bypass_check(rtwdev, phy, chanctx_idx))
 		_dpk_force_bypass(rtwdev, phy);
 	else
-		_dpk_cal_select(rtwdev, force, phy, _kpath(rtwdev, phy));
+		_dpk_cal_select(rtwdev, force, phy, _kpath(rtwdev, phy),
+				chanctx_idx);
 }
 
 static void _dpk_onoff(struct rtw89_dev *rtwdev,
@@ -2815,9 +2844,8 @@ static void _dpk_track(struct rtw89_dev *rtwdev)
 }
 
 static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			     enum rtw89_rf_path path)
+			     enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (band == RTW89_BAND_2G)
@@ -2826,9 +2854,9 @@ static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		rtw89_write_rf(rtwdev, path, RR_TXPOW, RR_TXPOW_TXA, 0x1);
 }
 
-static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser(rtwdev, &rtw8852a_tssi_sys_defs_tbl);
@@ -2838,9 +2866,9 @@ static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 }
 
 static void _tssi_ini_txpwr_ctrl_bb(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				    enum rtw89_rf_path path)
+				    enum rtw89_rf_path path,
+				    const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
@@ -2869,7 +2897,7 @@ static void _tssi_set_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				 enum rtw89_rf_path path)
+				 enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 #define __get_val(ptr, idx)				\
 ({							\
@@ -2883,7 +2911,6 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	__val;						\
 })
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
 	const s8 *thm_up_a = NULL;
@@ -3076,9 +3103,8 @@ static void _tssi_set_txagc_offset_mv_avg(struct rtw89_dev *rtwdev,
 }
 
 static void _tssi_pak(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-		      enum rtw89_rf_path path)
+		      enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 subband = chan->subband_type;
 
 	switch (subband) {
@@ -3252,10 +3278,9 @@ static u32 _tssi_get_trim_group(struct rtw89_dev *rtwdev, u8 ch)
 }
 
 static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			    enum rtw89_rf_path path)
+			    enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u32 gidx, gidx_1st, gidx_2nd;
 	s8 de_1st = 0;
@@ -3290,10 +3315,9 @@ static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 
 static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy,
-				 enum rtw89_rf_path path)
+				 enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u32 tgidx, tgidx_1st, tgidx_2nd;
 	s8 tde_1st = 0;
@@ -3328,11 +3352,10 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev,
 }
 
 static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
-				  enum rtw89_phy_idx phy)
+				  enum rtw89_phy_idx phy, const struct rtw89_chan *chan)
 {
 #define __DE_MASK 0x003ff000
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	static const u32 r_cck_long[RF_PATH_NUM_8852A] = {0x5858, 0x7858};
 	static const u32 r_cck_short[RF_PATH_NUM_8852A] = {0x5860, 0x7860};
 	static const u32 r_mcs_20m[RF_PATH_NUM_8852A] = {0x5838, 0x7838};
@@ -3352,7 +3375,7 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
 
 	for (i = 0; i < RF_PATH_NUM_8852A; i++) {
 		gidx = _tssi_get_cck_group(rtwdev, ch);
-		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i, chan);
 		val = tssi_info->tssi_cck[i][gidx] + trim_de;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -3368,8 +3391,8 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
 			    rtw89_phy_read32_mask(rtwdev, r_cck_long[i],
 						  __DE_MASK));
 
-		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i);
-		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i, chan);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i, chan);
 		val = ofdm_de + trim_de;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -3458,10 +3481,10 @@ static void _tssi_track(struct rtw89_dev *rtwdev)
 	}
 }
 
-static void _tssi_high_power(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+static void _tssi_high_power(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			     const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel, ch_tmp;
 	u8 bw = chan->band_width;
 	u8 band = chan->band_type;
@@ -3497,24 +3520,25 @@ static void _tssi_high_power(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 }
 
 static void _tssi_hw_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			u8 path, s16 pwr_dbm, u8 enable)
+			u8 path, s16 pwr_dbm, u8 enable, const struct rtw89_chan *chan)
 {
 	rtw8852a_bb_set_plcp_tx(rtwdev);
 	rtw8852a_bb_cfg_tx_path(rtwdev, path);
 	rtw8852a_bb_set_power(rtwdev, pwr_dbm, phy);
-	rtw8852a_bb_set_pmac_pkt_tx(rtwdev, enable, 20, 5000, 0, phy);
+	rtw8852a_bb_set_pmac_pkt_tx(rtwdev, enable, 20, 5000, 0, phy, chan);
 }
 
-static void _tssi_pre_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+static void _tssi_pre_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			 enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	const struct rtw89_chip_info *mac_reg = rtwdev->chip;
 	u8 ch = chan->channel, ch_tmp;
 	u8 bw = chan->band_width;
 	u8 band = chan->band_type;
 	u32 tx_en;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, 0, chanctx_idx);
 	s8 power;
 	s16 xdbm;
 	u32 i, tx_counter = 0;
@@ -3546,9 +3570,9 @@ static void _tssi_pre_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy));
 	tx_counter = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
 
-	_tssi_hw_tx(rtwdev, phy, RF_PATH_AB, xdbm, true);
+	_tssi_hw_tx(rtwdev, phy, RF_PATH_AB, xdbm, true, chan);
 	mdelay(15);
-	_tssi_hw_tx(rtwdev, phy, RF_PATH_AB, xdbm, false);
+	_tssi_hw_tx(rtwdev, phy, RF_PATH_AB, xdbm, false, chan);
 
 	tx_counter = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD) -
 		    tx_counter;
@@ -3600,19 +3624,21 @@ void rtw8852a_rck(struct rtw89_dev *rtwdev)
 		_rck(rtwdev, path);
 }
 
-void rtw8852a_dack(struct rtw89_dev *rtwdev)
+void rtw8852a_dack(struct rtw89_dev *rtwdev,
+		   enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_START);
-	_dac_cal(rtwdev, false);
+	_dac_cal(rtwdev, false, chanctx_idx);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_STOP);
 }
 
-void rtw8852a_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8852a_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx)
 {
 	u32 tx_en;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
@@ -3620,34 +3646,35 @@ void rtw8852a_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 	_iqk_init(rtwdev);
 	if (rtwdev->dbcc_en)
-		_iqk_dbcc(rtwdev, phy_idx);
+		_iqk_dbcc(rtwdev, phy_idx, chanctx_idx);
 	else
-		_iqk(rtwdev, phy_idx, false);
+		_iqk(rtwdev, phy_idx, false, chanctx_idx);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_STOP);
 }
 
 void rtw8852a_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
-		     bool is_afe)
+		     bool is_afe, enum rtw89_chanctx_idx chanctx_idx)
 {
 	u32 tx_en;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
 
-	_rx_dck(rtwdev, phy_idx, is_afe);
+	_rx_dck(rtwdev, phy_idx, is_afe, chanctx_idx);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_STOP);
 }
 
-void rtw8852a_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8852a_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx)
 {
 	u32 tx_en;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_START);
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
@@ -3655,7 +3682,7 @@ void rtw8852a_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 	rtwdev->dpk.is_dpk_enable = true;
 	rtwdev->dpk.is_dpk_reload_en = false;
-	_dpk(rtwdev, phy_idx, false);
+	_dpk(rtwdev, phy_idx, false, chanctx_idx);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_STOP);
@@ -3666,8 +3693,10 @@ void rtw8852a_dpk_track(struct rtw89_dev *rtwdev)
 	_dpk_track(rtwdev);
 }
 
-void rtw8852a_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+void rtw8852a_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		   enum rtw89_chanctx_idx chanctx_idx)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	u8 i;
 
 	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI] %s: phy=%d\n",
@@ -3676,26 +3705,27 @@ void rtw8852a_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	_tssi_disable(rtwdev, phy);
 
 	for (i = RF_PATH_A; i < RF_PATH_NUM_8852A; i++) {
-		_tssi_rf_setting(rtwdev, phy, i);
-		_tssi_set_sys(rtwdev, phy);
-		_tssi_ini_txpwr_ctrl_bb(rtwdev, phy, i);
+		_tssi_rf_setting(rtwdev, phy, i, chan);
+		_tssi_set_sys(rtwdev, phy, chan);
+		_tssi_ini_txpwr_ctrl_bb(rtwdev, phy, i, chan);
 		_tssi_ini_txpwr_ctrl_bb_he_tb(rtwdev, phy, i);
 		_tssi_set_dck(rtwdev, phy, i);
-		_tssi_set_tmeter_tbl(rtwdev, phy, i);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i, chan);
 		_tssi_set_dac_gain_tbl(rtwdev, phy, i);
 		_tssi_slope_cal_org(rtwdev, phy, i);
 		_tssi_set_rf_gap_tbl(rtwdev, phy, i);
 		_tssi_set_slope(rtwdev, phy, i);
-		_tssi_pak(rtwdev, phy, i);
+		_tssi_pak(rtwdev, phy, i, chan);
 	}
 
 	_tssi_enable(rtwdev, phy);
-	_tssi_set_efuse_to_de(rtwdev, phy);
-	_tssi_high_power(rtwdev, phy);
-	_tssi_pre_tx(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy, chan);
+	_tssi_high_power(rtwdev, phy, chan);
+	_tssi_pre_tx(rtwdev, phy, chanctx_idx);
 }
 
-void rtw8852a_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+void rtw8852a_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			const struct rtw89_chan *chan)
 {
 	u8 i;
 
@@ -3710,14 +3740,14 @@ void rtw8852a_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	_tssi_disable(rtwdev, phy);
 
 	for (i = RF_PATH_A; i < RF_PATH_NUM_8852A; i++) {
-		_tssi_rf_setting(rtwdev, phy, i);
-		_tssi_set_sys(rtwdev, phy);
-		_tssi_set_tmeter_tbl(rtwdev, phy, i);
-		_tssi_pak(rtwdev, phy, i);
+		_tssi_rf_setting(rtwdev, phy, i, chan);
+		_tssi_set_sys(rtwdev, phy, chan);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i, chan);
+		_tssi_pak(rtwdev, phy, i, chan);
 	}
 
 	_tssi_enable(rtwdev, phy);
-	_tssi_set_efuse_to_de(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy, chan);
 }
 
 void rtw8852a_tssi_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h
index fa058ccc8616..8761f2cc9359 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h
@@ -8,14 +8,19 @@
 #include "core.h"
 
 void rtw8852a_rck(struct rtw89_dev *rtwdev);
-void rtw8852a_dack(struct rtw89_dev *rtwdev);
-void rtw8852a_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8852a_dack(struct rtw89_dev *rtwdev,
+		   enum rtw89_chanctx_idx chanctx_idx);
+void rtw8852a_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx);
 void rtw8852a_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
-		     bool is_afe);
-void rtw8852a_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+		     bool is_afe, enum rtw89_chanctx_idx chanctx_idx);
+void rtw8852a_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx);
 void rtw8852a_dpk_track(struct rtw89_dev *rtwdev);
-void rtw8852a_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
-void rtw8852a_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852a_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		   enum rtw89_chanctx_idx chanctx_idx);
+void rtw8852a_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			const struct rtw89_chan *chan);
 void rtw8852a_tssi_track(struct rtw89_dev *rtwdev);
 void rtw8852a_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
 			       enum rtw89_phy_idx phy_idx);
-- 
2.25.1


