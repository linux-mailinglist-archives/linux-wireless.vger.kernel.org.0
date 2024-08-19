Return-Path: <linux-wireless+bounces-11606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FBD9566B0
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAF61C219CA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 09:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E5215ECEF;
	Mon, 19 Aug 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="s4l1blGA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E7115ECD9
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059067; cv=none; b=N9NHGdnEK4jDcBKSLfkbCNl23lvrVQAnHscBEVaNLY105wohi7Z8btIhcPkuxuA0s38hAxc05PT9kc0ONrrpen9x2M1g1w+sm1PP+5DXZ2MU5OqhKEvGR5WxS2oGqQBJu+unhwggPLDAqwooppZBMb0OUmaQucBOMtLR98FEl/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059067; c=relaxed/simple;
	bh=rdwhG0+td7Bd1qyJt6dwivH7G59oEI5905V/nE8XGnU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5W5Wg30mqR+HKzGm9pyq1Aku5e/H+Jeu2RcyfRFBKyDVh+Q9eKNincRvO9AVVqt4dMtSOCd8qctGVc3Mr3wEu78VNEJYDy5KSDnJHA0iUY56U7LDSifCUD/3LnEeyCMI5/fGzpncg3sDz8+7e9t/K/Mnf5wli+rYOEHiw4nKh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=s4l1blGA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J9HfUD24126001, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724059061; bh=rdwhG0+td7Bd1qyJt6dwivH7G59oEI5905V/nE8XGnU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=s4l1blGA9cV78JEn3P4oIj7tWIQsZS9Fa6C8SiApigrlvSiRXjoB7JcRzz/UAbkqM
	 sJKcz0dGMfgtSAiYQr8HRofsOhBrhkAU43aDHCLFMwaFDxH5H9V+zlrKhlPTXt9zbM
	 xb7tnYKS8yyurztNPns6WhWvCmhqPPfEma5dM02AOEv6BFM9+2awh0IKBXMZYagvfh
	 flQ1iTe1Zk8ZLnn9GsP3EqBgTEwvxBTkkQTDOWmxIkVYlHm39TGOCqMd+8jFjpzuVS
	 2a7TVw8ja/dw8R+qUeMK4MD8YtkrcdJjRAiPVtsFehgk1xTSrZsbQj9jTx4F1yOXue
	 BcshoOaqPIG1g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J9HfUD24126001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:17:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 17:17:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 19 Aug
 2024 17:17:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 2/8] wifi: rtw89: 8851b: use right chanctx whenever possible in RFK flow
Date: Mon, 19 Aug 2024 17:17:18 +0800
Message-ID: <20240819091724.33730-3-pkshih@realtek.com>
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
Instead, obtain the right chanctx from somewhere and use it in RTL8851B
RFK (RF calibration) related code.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  15 +-
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 138 +++++++++---------
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.h |  18 ++-
 3 files changed, 93 insertions(+), 78 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index d5e42b2ad9ac..c2fa8e270a4b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1587,30 +1587,31 @@ static void rtw8851b_rfk_init(struct rtw89_dev *rtwdev)
 	rtw8851b_aack(rtwdev);
 	rtw8851b_rck(rtwdev);
 	rtw8851b_dack(rtwdev);
-	rtw8851b_rx_dck(rtwdev, RTW89_PHY_0);
+	rtw8851b_rx_dck(rtwdev, RTW89_PHY_0, RTW89_CHANCTX_0);
 }
 
 static void rtw8851b_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif->chanctx_idx;
 	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
 
-	rtw8851b_rx_dck(rtwdev, phy_idx);
-	rtw8851b_iqk(rtwdev, phy_idx);
-	rtw8851b_tssi(rtwdev, phy_idx, true);
-	rtw8851b_dpk(rtwdev, phy_idx);
+	rtw8851b_rx_dck(rtwdev, phy_idx, chanctx_idx);
+	rtw8851b_iqk(rtwdev, phy_idx, chanctx_idx);
+	rtw8851b_tssi(rtwdev, phy_idx, true, chanctx_idx);
+	rtw8851b_dpk(rtwdev, phy_idx, chanctx_idx);
 }
 
 static void rtw8851b_rfk_band_changed(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx,
 				      const struct rtw89_chan *chan)
 {
-	rtw8851b_tssi_scan(rtwdev, phy_idx);
+	rtw8851b_tssi_scan(rtwdev, phy_idx, chan);
 }
 
 static void rtw8851b_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			      bool start)
 {
-	rtw8851b_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx);
+	rtw8851b_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx, rtwvif->chanctx_idx);
 }
 
 static void rtw8851b_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 7942f334066c..364e36354225 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -521,9 +521,10 @@ static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
 }
 
 static void _rx_dck_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			 enum rtw89_rf_path path, bool is_afe)
+			 enum rtw89_rf_path path, bool is_afe,
+			 enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[RX_DCK] ==== S%d RX DCK (%s / CH%d / %s / by %s)====\n", path,
@@ -574,7 +575,8 @@ static void _set_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, u8 rf
 	_rxbb_ofst_swap(rtwdev, path, rf_mode);
 }
 
-static void _rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_afe)
+static void _rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_afe,
+		    enum rtw89_chanctx_idx chanctx_idx)
 {
 	u32 rf_reg5;
 	u8 path;
@@ -584,7 +586,7 @@ static void _rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_af
 		    0x2, rtwdev->hal.cv);
 
 	for (path = 0; path < RF_PATH_NUM_8851B; path++) {
-		_rx_dck_info(rtwdev, phy, path, is_afe);
+		_rx_dck_info(rtwdev, phy, path, is_afe, chanctx_idx);
 
 		rf_reg5 = rtw89_read_rf(rtwdev, path, RR_RSV1, RFREG_MASK);
 
@@ -1481,9 +1483,9 @@ static void _rfk_restore_rf_reg(struct rtw89_dev *rtwdev,
 }
 
 static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			     u8 path)
+			     u8 path, enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u8 idx = 0;
 
@@ -1586,10 +1588,11 @@ static void _iqk_init(struct rtw89_dev *rtwdev)
 }
 
 static void _doiqk(struct rtw89_dev *rtwdev, bool force,
-		   enum rtw89_phy_idx phy_idx, u8 path)
+		   enum rtw89_phy_idx phy_idx, u8 path,
+		   enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, chanctx_idx);
 	u32 backup_rf_val[RTW8851B_IQK_SS][BACKUP_RF_REGS_NR];
 	u32 backup_bb_val[BACKUP_BB_REGS_NR];
 
@@ -1602,7 +1605,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	iqk_info->version = RTW8851B_IQK_VER;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]Test Ver 0x%x\n", iqk_info->version);
-	_iqk_get_ch_info(rtwdev, phy_idx, path);
+	_iqk_get_ch_info(rtwdev, phy_idx, path, chanctx_idx);
 
 	_rfk_backup_bb_reg(rtwdev, &backup_bb_val[0]);
 	_rfk_backup_rf_reg(rtwdev, &backup_rf_val[path][0], path);
@@ -1618,9 +1621,10 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 			      BTC_WRFK_ONESHOT_STOP);
 }
 
-static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool force)
+static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		 bool force, enum rtw89_chanctx_idx chanctx_idx)
 {
-	_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
+	_doiqk(rtwdev, force, phy_idx, RF_PATH_A, chanctx_idx);
 }
 
 static void _dpk_bkup_kip(struct rtw89_dev *rtwdev, const u32 *reg,
@@ -1746,9 +1750,9 @@ static void _dpk_init(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 }
 
 static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			     enum rtw89_rf_path path)
+			     enum rtw89_rf_path path, enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 
 	u8 kidx = dpk->cur_idx[path];
@@ -2449,7 +2453,8 @@ static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
-			    enum rtw89_phy_idx phy, u8 kpath)
+			    enum rtw89_phy_idx phy, u8 kpath,
+			    enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	u32 kip_bkup[RF_PATH_NUM_8851B][DPK_KIP_REG_NUM_8851B] = {};
@@ -2465,7 +2470,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 			continue;
 		_dpk_bkup_kip(rtwdev, dpk_kip_reg, kip_bkup, path);
 		_dpk_bkup_rf(rtwdev, dpk_rf_reg, rf_bkup, path);
-		_dpk_information(rtwdev, phy, path);
+		_dpk_information(rtwdev, phy, path, chanctx_idx);
 		_dpk_init(rtwdev, path);
 
 		if (rtwdev->is_tssi_mode[path])
@@ -2505,13 +2510,14 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 	_dpk_kip_pwr_clk_onoff(rtwdev, false);
 }
 
-static void _dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool force)
+static void _dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool force,
+		 enum rtw89_chanctx_idx chanctx_idx)
 {
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] ****** 8851B DPK Start (Ver: 0x%x, Cv: %d) ******\n",
 		    DPK_VER_8851B, rtwdev->hal.cv);
 
-	_dpk_cal_select(rtwdev, force, phy, _kpath(rtwdev, phy));
+	_dpk_cal_select(rtwdev, force, phy, _kpath(rtwdev, phy), chanctx_idx);
 }
 
 static void _dpk_track(struct rtw89_dev *rtwdev)
@@ -2617,9 +2623,8 @@ static void _rck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 }
 
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			  enum rtw89_rf_path path)
+			  enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser(rtwdev, &rtw8851b_tssi_sys_defs_tbl);
@@ -2650,7 +2655,7 @@ static void _tssi_set_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				 enum rtw89_rf_path path)
+				 enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 #define RTW8851B_TSSI_GET_VAL(ptr, idx)			\
 ({							\
@@ -2664,7 +2669,6 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	__val;						\
 })
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
 	const s8 *thm_up_a = NULL;
@@ -2755,9 +2759,8 @@ static void _tssi_set_dac_gain_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx
 }
 
 static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				enum rtw89_rf_path path)
+				enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
@@ -2766,9 +2769,9 @@ static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 }
 
 static void _tssi_alignment_default(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				    enum rtw89_rf_path path, bool all)
+				    enum rtw89_rf_path path, bool all,
+				    const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
@@ -2944,10 +2947,9 @@ static u32 _tssi_get_trim_group(struct rtw89_dev *rtwdev, u8 ch)
 }
 
 static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			    enum rtw89_rf_path path)
+			    enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u32 gidx, gidx_1st, gidx_2nd;
 	u8 ch = chan->channel;
 	s8 de_1st;
@@ -2980,10 +2982,9 @@ static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				 enum rtw89_rf_path path)
+				 enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u32 tgidx, tgidx_1st, tgidx_2nd;
 	u8 ch = chan->channel;
 	s8 tde_1st;
@@ -3017,10 +3018,10 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	return val;
 }
 
-static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				  const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 gidx;
 	s8 ofdm_de;
@@ -3033,7 +3034,7 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx p
 
 	for (i = RF_PATH_A; i < RTW8851B_TSSI_PATH_NR; i++) {
 		gidx = _tssi_get_cck_group(rtwdev, ch);
-		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i, chan);
 		val = tssi_info->tssi_cck[i][gidx] + trim_de;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -3049,8 +3050,8 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx p
 			    rtw89_phy_read32_mask(rtwdev, _tssi_de_cck_long[i],
 						  _TSSI_DE_MASK));
 
-		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i);
-		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i, chan);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i, chan);
 		val = ofdm_de + trim_de;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -3096,10 +3097,10 @@ static void _tssi_alimentk_dump_result(struct rtw89_dev *rtwdev, enum rtw89_rf_p
 }
 
 static void _tssi_alimentk_done(struct rtw89_dev *rtwdev,
-				enum rtw89_phy_idx phy, enum rtw89_rf_path path)
+				enum rtw89_phy_idx phy, enum rtw89_rf_path path,
+				const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 channel = chan->channel;
 	u8 band;
 
@@ -3255,9 +3256,10 @@ void rtw8851b_dack(struct rtw89_dev *rtwdev)
 	_dac_cal(rtwdev, false);
 }
 
-void rtw8851b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8851b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
@@ -3265,30 +3267,32 @@ void rtw8851b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
 
 	_iqk_init(rtwdev);
-	_iqk(rtwdev, phy_idx, false);
+	_iqk(rtwdev, phy_idx, false, chanctx_idx);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_STOP);
 }
 
-void rtw8851b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8851b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		     enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
 
-	_rx_dck(rtwdev, phy_idx, false);
+	_rx_dck(rtwdev, phy_idx, false, chanctx_idx);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_STOP);
 }
 
-void rtw8851b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8851b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_START);
@@ -3297,7 +3301,7 @@ void rtw8851b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 	rtwdev->dpk.is_dpk_enable = true;
 	rtwdev->dpk.is_dpk_reload_en = false;
-	_dpk(rtwdev, phy_idx, false);
+	_dpk(rtwdev, phy_idx, false, chanctx_idx);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_STOP);
@@ -3308,9 +3312,11 @@ void rtw8851b_dpk_track(struct rtw89_dev *rtwdev)
 	_dpk_track(rtwdev);
 }
 
-void rtw8851b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en)
+void rtw8851b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		   bool hwtx_en, enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_A, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_A, chanctx_idx);
 	u8 i;
 
 	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI] %s: phy=%d\n", __func__, phy);
@@ -3319,26 +3325,26 @@ void rtw8851b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_e
 	_tssi_disable(rtwdev, phy);
 
 	for (i = RF_PATH_A; i < RF_PATH_NUM_8851B; i++) {
-		_tssi_set_sys(rtwdev, phy, i);
+		_tssi_set_sys(rtwdev, phy, i, chan);
 		_tssi_ini_txpwr_ctrl_bb(rtwdev, phy, i);
 		_tssi_ini_txpwr_ctrl_bb_he_tb(rtwdev, phy, i);
 		_tssi_set_dck(rtwdev, phy, i);
-		_tssi_set_tmeter_tbl(rtwdev, phy, i);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i, chan);
 		_tssi_set_dac_gain_tbl(rtwdev, phy, i);
-		_tssi_slope_cal_org(rtwdev, phy, i);
-		_tssi_alignment_default(rtwdev, phy, i, true);
+		_tssi_slope_cal_org(rtwdev, phy, i, chan);
+		_tssi_alignment_default(rtwdev, phy, i, true, chan);
 		_tssi_set_tssi_slope(rtwdev, phy, i);
 	}
 
 	_tssi_enable(rtwdev, phy);
-	_tssi_set_efuse_to_de(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy, chan);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_STOP);
 }
 
-void rtw8851b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+void rtw8851b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 channel = chan->channel;
 	u32 i;
 
@@ -3348,20 +3354,21 @@ void rtw8851b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	_tssi_disable(rtwdev, phy);
 
 	for (i = RF_PATH_A; i < RF_PATH_NUM_8851B; i++) {
-		_tssi_set_sys(rtwdev, phy, i);
-		_tssi_set_tmeter_tbl(rtwdev, phy, i);
-		_tssi_slope_cal_org(rtwdev, phy, i);
-		_tssi_alignment_default(rtwdev, phy, i, true);
+		_tssi_set_sys(rtwdev, phy, i, chan);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i, chan);
+		_tssi_slope_cal_org(rtwdev, phy, i, chan);
+		_tssi_alignment_default(rtwdev, phy, i, true, chan);
 	}
 
 	_tssi_enable(rtwdev, phy);
-	_tssi_set_efuse_to_de(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy, chan);
 }
 
 static void rtw8851b_tssi_default_txagc(struct rtw89_dev *rtwdev,
-					enum rtw89_phy_idx phy, bool enable)
+					enum rtw89_phy_idx phy, bool enable,
+					enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	u8 channel = chan->channel;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "======> %s   ch=%d\n",
@@ -3379,7 +3386,7 @@ static void rtw8851b_tssi_default_txagc(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT_EN, 0x0);
 	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT_EN, 0x1);
 
-	_tssi_alimentk_done(rtwdev, phy, RF_PATH_A);
+	_tssi_alimentk_done(rtwdev, phy, RF_PATH_A, chan);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "======>%s 2 SCAN_END Set 0x5818[7:0]=0x%x\n",
@@ -3391,12 +3398,13 @@ static void rtw8851b_tssi_default_txagc(struct rtw89_dev *rtwdev,
 }
 
 void rtw8851b_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
-			       enum rtw89_phy_idx phy_idx)
+			       enum rtw89_phy_idx phy_idx,
+			       enum rtw89_chanctx_idx chanctx_idx)
 {
 	if (scan_start)
-		rtw8851b_tssi_default_txagc(rtwdev, phy_idx, true);
+		rtw8851b_tssi_default_txagc(rtwdev, phy_idx, true, chanctx_idx);
 	else
-		rtw8851b_tssi_default_txagc(rtwdev, phy_idx, false);
+		rtw8851b_tssi_default_txagc(rtwdev, phy_idx, false, chanctx_idx);
 }
 
 static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
index b66a23d6d367..ea7df628256b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
@@ -12,15 +12,21 @@ void rtw8851b_lck_init(struct rtw89_dev *rtwdev);
 void rtw8851b_lck_track(struct rtw89_dev *rtwdev);
 void rtw8851b_rck(struct rtw89_dev *rtwdev);
 void rtw8851b_dack(struct rtw89_dev *rtwdev);
-void rtw8851b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
-void rtw8851b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8851b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx);
+void rtw8851b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		     enum rtw89_chanctx_idx chanctx_idx);
 void rtw8851b_dpk_init(struct rtw89_dev *rtwdev);
-void rtw8851b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8851b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx);
 void rtw8851b_dpk_track(struct rtw89_dev *rtwdev);
-void rtw8851b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en);
-void rtw8851b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8851b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		   bool hwtx_en, enum rtw89_chanctx_idx chanctx_idx);
+void rtw8851b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			const struct rtw89_chan *chan);
 void rtw8851b_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
-			       enum rtw89_phy_idx phy_idx);
+			       enum rtw89_phy_idx phy_idx,
+			       enum rtw89_chanctx_idx chanctx_idx);
 void rtw8851b_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx);
-- 
2.25.1


