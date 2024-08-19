Return-Path: <linux-wireless+bounces-11609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A0F9566BB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596AF280F80
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BACF15F406;
	Mon, 19 Aug 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Y6/EJk3T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DD515DBA5
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059081; cv=none; b=PlTTyugi3erWEkcZImwhDro9waBGGZM5ZSLZdhFdXB+7PPDH1bNTBf1WSiYTg3HQpF5TO9yhApmd07AeuTyI0IWe+0EyO1n/czK/enAdGh87keXK4bhvfn8opWc7KQjqaTkJThPE+Fa21nAmF1XOOyPIotYady9QkzarMxkvj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059081; c=relaxed/simple;
	bh=6WR8aZsLKJpxP6NUxGljyClKKodfm00MeXtCAW8kZQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqX90Mj3rDVc9ymRcpqPSItogS33wItRbo6RngAM4ygN3sN5ZE6nmHREQPfn6Rjos9mJ8+Vuu/uFRWBmfquTzekipXAToObt0bbsjHk90W7bAJpyCd94FRccHQVU2Ey2x3kNnh3m+DxRVKdYV1nm1SxoqKZQ7vi0dTB16pptzP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Y6/EJk3T; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J9HubfE4126054, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724059076; bh=6WR8aZsLKJpxP6NUxGljyClKKodfm00MeXtCAW8kZQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Y6/EJk3Ttvz8LJaAwshwTR9QKRmxwxkcZFCiItyNAcLL7EKlZAhaucTQtGScIFB5M
	 vQ/Cpnx26WlNsph8lBJLeVAFj4aAu1kr+x2XelejSRwhDSPE7O12fnv9M85OdlZfka
	 1onjcGBiT4rCEyEPfL1ns56I+ZVQfhJj0AwWx4HXs6C0AzaaICz709grdG6z6Y/d0j
	 KceZ96qxGrPzzVOJcjD54K5ZXAjHEbahEnnFvP7YQDf32nEau1U9BTP4tBe79SqnS7
	 gfHhJhiwjbl/C3XW1i9idgPqDgYuTEb4K9NaGU/Kj7iB7YmwUiw7E/yAxOxu3psBOf
	 sZGZYu9CgLWag==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J9HubfE4126054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:17:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 17:17:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 19 Aug
 2024 17:17:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 5/8] wifi: rtw89: 8852c: use right chanctx whenever possible in RFK flow
Date: Mon, 19 Aug 2024 17:17:21 +0800
Message-ID: <20240819091724.33730-6-pkshih@realtek.com>
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
Instead, obtain the right chanctx from somewhere and use it in RTL8852C
RFK (RF calibration) related code.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  15 +-
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 162 +++++++++---------
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |  17 +-
 3 files changed, 104 insertions(+), 90 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 1fde8a07f73c..d4adab43f4f2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1817,7 +1817,7 @@ static void rtw8852c_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 				       RTW89_SCH_TX_SEL_ALL);
 		rtw89_mac_cfg_ppdu_status(rtwdev, mac_idx, false);
 		rtw8852c_dfs_en(rtwdev, false);
-		rtw8852c_tssi_cont_en_phyidx(rtwdev, false, phy_idx);
+		rtw8852c_tssi_cont_en_phyidx(rtwdev, false, phy_idx, chan);
 		rtw8852c_adc_en(rtwdev, false);
 		fsleep(40);
 		rtw8852c_bb_reset_en(rtwdev, chan->band_type, phy_idx, false);
@@ -1825,7 +1825,7 @@ static void rtw8852c_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 		rtw89_mac_cfg_ppdu_status(rtwdev, mac_idx, true);
 		rtw8852c_adc_en(rtwdev, true);
 		rtw8852c_dfs_en(rtwdev, true);
-		rtw8852c_tssi_cont_en_phyidx(rtwdev, true, phy_idx);
+		rtw8852c_tssi_cont_en_phyidx(rtwdev, true, phy_idx, chan);
 		rtw8852c_bb_reset_en(rtwdev, chan->band_type, phy_idx, true);
 		rtw89_chip_resume_sch_tx(rtwdev, mac_idx, p->tx_en);
 	}
@@ -1842,19 +1842,20 @@ static void rtw8852c_rfk_init(struct rtw89_dev *rtwdev)
 	rtw8852c_dpk_init(rtwdev);
 
 	rtw8852c_rck(rtwdev);
-	rtw8852c_dack(rtwdev);
+	rtw8852c_dack(rtwdev, RTW89_CHANCTX_0);
 	rtw8852c_rx_dck(rtwdev, RTW89_PHY_0, false);
 }
 
 static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif->chanctx_idx;
 	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
 
 	rtw8852c_mcc_get_ch_info(rtwdev, phy_idx);
 	rtw8852c_rx_dck(rtwdev, phy_idx, false);
-	rtw8852c_iqk(rtwdev, phy_idx);
-	rtw8852c_tssi(rtwdev, phy_idx);
-	rtw8852c_dpk(rtwdev, phy_idx);
+	rtw8852c_iqk(rtwdev, phy_idx, chanctx_idx);
+	rtw8852c_tssi(rtwdev, phy_idx, chanctx_idx);
+	rtw8852c_dpk(rtwdev, phy_idx, chanctx_idx);
 	rtw89_fw_h2c_rf_ntfy_mcc(rtwdev);
 }
 
@@ -1862,7 +1863,7 @@ static void rtw8852c_rfk_band_changed(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx,
 				      const struct rtw89_chan *chan)
 {
-	rtw8852c_tssi_scan(rtwdev, phy_idx);
+	rtw8852c_tssi_scan(rtwdev, phy_idx, chan);
 }
 
 static void rtw8852c_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 8fee820be258..211c051c2967 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -585,11 +585,12 @@ static void _drck(struct rtw89_dev *rtwdev)
 		    rtw89_phy_read32_mask(rtwdev, R_DRCK, MASKDWORD));
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
@@ -1322,9 +1323,10 @@ static void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u
 }
 
 static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
-			     enum rtw89_phy_idx phy, u8 path)
+			     enum rtw89_phy_idx phy, u8 path,
+			     enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
@@ -1517,12 +1519,13 @@ static void _iqk_init(struct rtw89_dev *rtwdev)
 }
 
 static void _doiqk(struct rtw89_dev *rtwdev, bool force,
-		   enum rtw89_phy_idx phy_idx, u8 path)
+		   enum rtw89_phy_idx phy_idx, u8 path,
+		   enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u32 backup_bb_val[BACKUP_BB_REGS_NR];
 	u32 backup_rf_val[RTW8852C_IQK_SS][BACKUP_RF_REGS_NR];
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
@@ -1532,7 +1535,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	iqk_info->version = RTW8852C_IQK_VER;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]Test Ver 0x%x\n", iqk_info->version);
-	_iqk_get_ch_info(rtwdev, phy_idx, path);
+	_iqk_get_ch_info(rtwdev, phy_idx, path, chanctx_idx);
 	_rfk_backup_bb_reg(rtwdev, backup_bb_val);
 	_rfk_backup_rf_reg(rtwdev, backup_rf_val[path], path);
 	_iqk_macbb_setting(rtwdev, phy_idx, path);
@@ -1545,18 +1548,19 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
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
@@ -1902,9 +1906,9 @@ static u8 _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 
 static void _dpk_information(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy,
-			     enum rtw89_rf_path path)
+			     enum rtw89_rf_path path, enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 
 	u8 kidx = dpk->cur_idx[path];
@@ -2496,9 +2500,9 @@ static void _dpk_idl_mpa(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			      enum rtw89_rf_path path)
+			      enum rtw89_rf_path path, enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	bool is_reload = false;
 	u8 idx, cur_band, cur_ch;
@@ -2690,7 +2694,8 @@ static void _dpk_drf_direct_cntrl(struct rtw89_dev *rtwdev, u8 path, bool is_byb
 }
 
 static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
-			    enum rtw89_phy_idx phy, u8 kpath)
+			    enum rtw89_phy_idx phy, u8 kpath,
+			    enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	static const u32 kip_reg[] = {0x813c, 0x8124, 0x8120, 0xc0c4, 0xc0e8, 0xc0d4, 0xc0d8};
@@ -2706,7 +2711,8 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 			if (!(kpath & BIT(path)))
 				continue;
 
-			reloaded[path] = _dpk_reload_check(rtwdev, phy, path);
+			reloaded[path] = _dpk_reload_check(rtwdev, phy, path,
+							   chanctx_idx);
 			if (!reloaded[path] && dpk->bp[path][0].ch != 0)
 				dpk->cur_idx[path] = !dpk->cur_idx[path];
 			else
@@ -2723,7 +2729,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 			    path, dpk->cur_idx[path]);
 		_dpk_bkup_kip(rtwdev, kip_reg, kip_bkup, path);
 		_rfk_backup_rf_reg(rtwdev, backup_rf_val[path], path);
-		_dpk_information(rtwdev, phy, path);
+		_dpk_information(rtwdev, phy, path, chanctx_idx);
 		_dpk_init(rtwdev, path);
 		if (rtwdev->is_tssi_mode[path])
 			_dpk_tssi_pause(rtwdev, path, true);
@@ -2756,10 +2762,11 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 	_dpk_kip_pwr_clk_onoff(rtwdev, false);
 }
 
-static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			      enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_fem_info *fem = &rtwdev->fem;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	u8 band = chan->band_type;
 
 	if (rtwdev->hal.cv == CHIP_CAV && band != RTW89_BAND_2G) {
@@ -2791,17 +2798,18 @@ static void _dpk_force_bypass(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	}
 }
 
-static void _dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool force)
+static void _dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool force,
+		 enum rtw89_chanctx_idx chanctx_idx)
 {
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] ****** DPK Start (Ver: 0x%x, Cv: %d, RF_para: %d) ******\n",
 		    RTW8852C_DPK_VER, rtwdev->hal.cv,
 		    RTW8852C_RF_REL_VERSION);
 
-	if (_dpk_bypass_check(rtwdev, phy))
+	if (_dpk_bypass_check(rtwdev, phy, chanctx_idx))
 		_dpk_force_bypass(rtwdev, phy);
 	else
-		_dpk_cal_select(rtwdev, force, phy, _kpath(rtwdev, phy));
+		_dpk_cal_select(rtwdev, force, phy, _kpath(rtwdev, phy), chanctx_idx);
 
 	if (rtw89_read_rf(rtwdev, RF_PATH_A, RR_DCKC, RR_DCKC_CHK) == 0x1)
 		rtw8852c_rx_dck(rtwdev, phy, false);
@@ -2892,9 +2900,8 @@ static void _dpk_track(struct rtw89_dev *rtwdev)
 }
 
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			  enum rtw89_rf_path path)
+			  enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_bandwidth bw = chan->band_width;
 	enum rtw89_band band = chan->band_type;
 	u32 clk = 0x0;
@@ -2946,9 +2953,8 @@ static void _tssi_ini_txpwr_ctrl_bb_he_tb(struct rtw89_dev *rtwdev,
 }
 
 static void _tssi_set_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			  enum rtw89_rf_path path)
+			  enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (path == RF_PATH_A) {
@@ -2973,7 +2979,7 @@ static void _tssi_set_bbgain_split(struct rtw89_dev *rtwdev, enum rtw89_phy_idx
 }
 
 static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				 enum rtw89_rf_path path)
+				 enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 #define RTW8852C_TSSI_GET_VAL(ptr, idx)			\
 ({							\
@@ -2986,7 +2992,6 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	}						\
 	__val;						\
 })
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_fw_txpwr_track_cfg *trk = rtwdev->fw.elm_info.txpwr_trk;
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	u8 ch = chan->channel;
@@ -3192,9 +3197,8 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 }
 
 static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				enum rtw89_rf_path path)
+				enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (path == RF_PATH_A) {
@@ -3209,9 +3213,9 @@ static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 }
 
 static void _tssi_set_aligk_default(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				    enum rtw89_rf_path path)
+				    enum rtw89_rf_path path,
+				    const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 	const struct rtw89_rfk_tbl *tbl;
 
@@ -3620,10 +3624,9 @@ static u32 _tssi_get_6g_trim_group(struct rtw89_dev *rtwdev, u8 ch)
 }
 
 static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			    enum rtw89_rf_path path)
+			    enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 	u8 ch = chan->channel;
 	u32 gidx, gidx_1st, gidx_2nd;
@@ -3684,10 +3687,9 @@ static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 
 static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy,
-				 enum rtw89_rf_path path)
+				 enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 	u8 ch = chan->channel;
 	u32 tgidx, tgidx_1st, tgidx_2nd;
@@ -3749,10 +3751,9 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev,
 }
 
 static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
-				  enum rtw89_phy_idx phy)
+				  enum rtw89_phy_idx phy, const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 gidx;
 	s8 ofdm_de;
@@ -3775,7 +3776,7 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
 
 	for (i = path; i < path_max; i++) {
 		gidx = _tssi_get_cck_group(rtwdev, ch);
-		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i, chan);
 		val = tssi_info->tssi_cck[i][gidx] + trim_de;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -3791,8 +3792,8 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
 			    rtw89_phy_read32_mask(rtwdev, _tssi_de_cck_long[i],
 						  _TSSI_DE_MASK));
 
-		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i);
-		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i, chan);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i, chan);
 		val = ofdm_de + trim_de;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -3815,7 +3816,7 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852c_tssi_cont_en(struct rtw89_dev *rtwdev, bool en,
-				  enum rtw89_rf_path path)
+				  enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	static const u32 tssi_trk[2] = {0x5818, 0x7818};
 	static const u32 tssi_en[2] = {0x5820, 0x7820};
@@ -3824,25 +3825,26 @@ static void rtw8852c_tssi_cont_en(struct rtw89_dev *rtwdev, bool en,
 		rtw89_phy_write32_mask(rtwdev, tssi_trk[path], BIT(30), 0x0);
 		rtw89_phy_write32_mask(rtwdev, tssi_en[path], BIT(31), 0x0);
 		if (rtwdev->dbcc_en && path == RF_PATH_B)
-			_tssi_set_efuse_to_de(rtwdev, RTW89_PHY_1);
+			_tssi_set_efuse_to_de(rtwdev, RTW89_PHY_1, chan);
 		else
-			_tssi_set_efuse_to_de(rtwdev, RTW89_PHY_0);
+			_tssi_set_efuse_to_de(rtwdev, RTW89_PHY_0, chan);
 	} else {
 		rtw89_phy_write32_mask(rtwdev, tssi_trk[path], BIT(30), 0x1);
 		rtw89_phy_write32_mask(rtwdev, tssi_en[path], BIT(31), 0x1);
 	}
 }
 
-void rtw8852c_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx)
+void rtw8852c_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx,
+				  const struct rtw89_chan *chan)
 {
 	if (!rtwdev->dbcc_en) {
-		rtw8852c_tssi_cont_en(rtwdev, en, RF_PATH_A);
-		rtw8852c_tssi_cont_en(rtwdev, en, RF_PATH_B);
+		rtw8852c_tssi_cont_en(rtwdev, en, RF_PATH_A, chan);
+		rtw8852c_tssi_cont_en(rtwdev, en, RF_PATH_B, chan);
 	} else {
 		if (phy_idx == RTW89_PHY_0)
-			rtw8852c_tssi_cont_en(rtwdev, en, RF_PATH_A);
+			rtw8852c_tssi_cont_en(rtwdev, en, RF_PATH_A, chan);
 		else
-			rtw8852c_tssi_cont_en(rtwdev, en, RF_PATH_B);
+			rtw8852c_tssi_cont_en(rtwdev, en, RF_PATH_B, chan);
 	}
 }
 
@@ -4146,26 +4148,27 @@ void rtw8852c_rck(struct rtw89_dev *rtwdev)
 		_rck(rtwdev, path);
 }
 
-void rtw8852c_dack(struct rtw89_dev *rtwdev)
+void rtw8852c_dack(struct rtw89_dev *rtwdev, enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_START);
-	_dac_cal(rtwdev, false);
+	_dac_cal(rtwdev, false, chanctx_idx);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_STOP);
 }
 
-void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx)
 {
 	u32 tx_en;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
 
 	_iqk_init(rtwdev);
-	_iqk(rtwdev, phy_idx, false);
+	_iqk(rtwdev, phy_idx, false, chanctx_idx);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_STOP);
@@ -4236,10 +4239,11 @@ void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_a
 
 void rtw8852c_rx_dck_track(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	enum rtw89_chanctx_idx chanctx_idx = RTW89_CHANCTX_0;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_rx_dck_info *rx_dck = &rtwdev->rx_dck;
 	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 	u8 dck_channel;
 	u8 cur_thermal;
 	u32 tx_en;
@@ -4293,16 +4297,17 @@ void rtw8852c_dpk_init(struct rtw89_dev *rtwdev)
 	dpk->is_dpk_reload_en = false;
 }
 
-void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx)
 {
 	u32 tx_en;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_START);
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
 
-	_dpk(rtwdev, phy_idx, false);
+	_dpk(rtwdev, phy_idx, false, chanctx_idx);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_STOP);
@@ -4313,8 +4318,10 @@ void rtw8852c_dpk_track(struct rtw89_dev *rtwdev)
 	_dpk_track(rtwdev);
 }
 
-void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		   enum rtw89_chanctx_idx chanctx_idx)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	u32 i, path = RF_PATH_A, path_max = RF_PATH_NUM_8852C;
 
 	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI] %s: phy=%d\n", __func__, phy);
@@ -4332,23 +4339,24 @@ void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	_tssi_disable(rtwdev, phy);
 
 	for (i = path; i < path_max; i++) {
-		_tssi_set_sys(rtwdev, phy, i);
+		_tssi_set_sys(rtwdev, phy, i, chan);
 		_tssi_ini_txpwr_ctrl_bb(rtwdev, phy, i);
 		_tssi_ini_txpwr_ctrl_bb_he_tb(rtwdev, phy, i);
-		_tssi_set_dck(rtwdev, phy, i);
+		_tssi_set_dck(rtwdev, phy, i, chan);
 		_tssi_set_bbgain_split(rtwdev, phy, i);
-		_tssi_set_tmeter_tbl(rtwdev, phy, i);
-		_tssi_slope_cal_org(rtwdev, phy, i);
-		_tssi_set_aligk_default(rtwdev, phy, i);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i, chan);
+		_tssi_slope_cal_org(rtwdev, phy, i, chan);
+		_tssi_set_aligk_default(rtwdev, phy, i, chan);
 		_tssi_set_slope(rtwdev, phy, i);
 		_tssi_run_slope(rtwdev, phy, i);
 	}
 
 	_tssi_enable(rtwdev, phy);
-	_tssi_set_efuse_to_de(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy, chan);
 }
 
-void rtw8852c_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+void rtw8852c_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			const struct rtw89_chan *chan)
 {
 	u32 i, path = RF_PATH_A, path_max = RF_PATH_NUM_8852C;
 
@@ -4373,15 +4381,15 @@ void rtw8852c_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	_tssi_disable(rtwdev, phy);
 
 	for (i = path; i < path_max; i++) {
-		_tssi_set_sys(rtwdev, phy, i);
-		_tssi_set_dck(rtwdev, phy, i);
-		_tssi_set_tmeter_tbl(rtwdev, phy, i);
-		_tssi_slope_cal_org(rtwdev, phy, i);
-		_tssi_set_aligk_default(rtwdev, phy, i);
+		_tssi_set_sys(rtwdev, phy, i, chan);
+		_tssi_set_dck(rtwdev, phy, i, chan);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i, chan);
+		_tssi_slope_cal_org(rtwdev, phy, i, chan);
+		_tssi_set_aligk_default(rtwdev, phy, i, chan);
 	}
 
 	_tssi_enable(rtwdev, phy);
-	_tssi_set_efuse_to_de(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy, chan);
 }
 
 static void rtw8852c_tssi_default_txagc(struct rtw89_dev *rtwdev,
@@ -4456,7 +4464,7 @@ void rtw8852c_rfk_chanctx_cb(struct rtw89_dev *rtwdev,
 		dpk->is_dpk_enable = true;
 		for (path = 0; path < RTW8852C_DPK_RF_PATH; path++)
 			_dpk_onoff(rtwdev, path, false);
-		rtw8852c_dpk(rtwdev, RTW89_PHY_0);
+		rtw8852c_dpk(rtwdev, RTW89_PHY_0, RTW89_CHANCTX_0);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
index 6605137e61aa..306dd0a0be73 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
@@ -9,16 +9,21 @@
 
 void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852c_rck(struct rtw89_dev *rtwdev);
-void rtw8852c_dack(struct rtw89_dev *rtwdev);
-void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8852c_dack(struct rtw89_dev *rtwdev, enum rtw89_chanctx_idx chanctx_idx);
+void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx);
 void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool is_afe);
 void rtw8852c_rx_dck_track(struct rtw89_dev *rtwdev);
 void rtw8852c_dpk_init(struct rtw89_dev *rtwdev);
-void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx);
 void rtw8852c_dpk_track(struct rtw89_dev *rtwdev);
-void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
-void rtw8852c_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
-void rtw8852c_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx);
+void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		   enum rtw89_chanctx_idx chanctx_idx);
+void rtw8852c_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			const struct rtw89_chan *chan);
+void rtw8852c_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx,
+				  const struct rtw89_chan *chan);
 void rtw8852c_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
 			       enum rtw89_phy_idx phy_idx);
 void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
-- 
2.25.1


