Return-Path: <linux-wireless+bounces-17627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D458DA14A23
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 08:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268D0188A719
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADBA1F867E;
	Fri, 17 Jan 2025 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ENWZAPdx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2081F866D
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098960; cv=none; b=FHhNfxqULvbByrV5OLoVnUcg+ZIBRjuEG+j0ikM3+xjKEhvbJJ81YNfHXXgi/gflztrhCbaL8Oz26k5t7PbFnqhDz4jbabWNs2XIT4Kt1TXt2z8UngZVmqmVEsHQIJhiJMBnLWNYbitnny27i46sLZwGwZcD2RwwEnkvI/sSwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098960; c=relaxed/simple;
	bh=gEYKIk2lTd+pTT5ecy/K67DSiSM3LLklwyaWyI72bWk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjEPcoNPW+rGichtv/8rtFj3PkHytg4iSduQkQWOnNbf0r7aP/SrJHR9EV5hr0LAb57PJNJ8QEEqTPZE2pLyieugZSG0IiTcncI4ND/+ypEYtoINtbvfQvC6Ql+adQDu+WcohoJCkFMpjxr1M8Ta3+tx2Zb6XpUoUSqTlNXL438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ENWZAPdx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50H7TC4A02337821, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737098952; bh=gEYKIk2lTd+pTT5ecy/K67DSiSM3LLklwyaWyI72bWk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ENWZAPdx0fWDstdme3gFRQTUKbkoSYRVZMBpYAZXVn7XlAoBU77ayQxq0oLRUHE5G
	 Vo+mIqJMIN9vsXhdpwtl0kpTyL8gK6xgyZ6szmuytrHaNHr8tBKcS8jtFOyIp4bIhi
	 Ph1yss7RJpJPyWBku/FI0W+XIIzp6LRgMfhTGAY6lJr5hgeNYgYQnSZvTo34Chw48H
	 4ERdyx3h4DkwMmkD1hCeTyJzW7yKCmOZIHKgBe2TiO7SGwef/cZop+7fS1dWcaYcIB
	 GQTd496uQPnONpr5DsAyy6vHiZy2rlru8czSz/lDpkJLVTL7HaJgdfBnoCWo/83DPq
	 eznqPURESSriw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50H7TC4A02337821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 15:29:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 Jan 2025 15:29:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 Jan
 2025 15:29:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/8] wifi: rtw89: phy: support DIG per PHY
Date: Fri, 17 Jan 2025 15:28:24 +0800
Message-ID: <20250117072828.16728-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117072828.16728-1-pkshih@realtek.com>
References: <20250117072828.16728-1-pkshih@realtek.com>
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

DIG standing for dynamic initial gain is to define RX coverage. Adjust this
value dynamically to gain good RX performance.

Use PHY context to extend DIG algorithm to support two PHY.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |   4 +-
 drivers/net/wireless/realtek/rtw89/core.h |   2 +-
 drivers/net/wireless/realtek/rtw89/phy.c  | 224 +++++++++++++---------
 drivers/net/wireless/realtek/rtw89/phy.h  |   2 +-
 4 files changed, 136 insertions(+), 96 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 42815a58a49a..e39fb696ac13 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4925,6 +4925,7 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link, bool hw_scan)
 {
 	struct ieee80211_bss_conf *bss_conf;
+	struct rtw89_bb_ctx *bb;
 
 	if (!rtwvif_link)
 		return;
@@ -4943,7 +4944,8 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 	rtw89_phy_config_edcca(rtwdev, false);
 
 	rtwdev->scanning = false;
-	rtwdev->dig.bypass_dig = true;
+	rtw89_for_each_active_bb(rtwdev, bb)
+		bb->dig.bypass_dig = true;
 	if (hw_scan && (rtwdev->hw->conf.flags & IEEE80211_CONF_IDLE))
 		ieee80211_queue_work(rtwdev->hw, &rtwdev->ips_work);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 99bb32f4fd8d..86f1370ff136 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5682,7 +5682,6 @@ struct rtw89_dev {
 	struct rtw89_power_trim_info pwr_trim;
 
 	struct rtw89_cfo_tracking_info cfo_tracking;
-	struct rtw89_dig_info dig;
 	struct rtw89_phy_ch_info ch_info;
 	union {
 		struct rtw89_phy_bb_gain_info ax;
@@ -5695,6 +5694,7 @@ struct rtw89_dev {
 	struct rtw89_bb_ctx {
 		enum rtw89_phy_idx phy_idx;
 		struct rtw89_env_monitor_info env_monitor;
+		struct rtw89_dig_info dig;
 	} bbs[RTW89_PHY_NUM];
 
 	struct delayed_work track_work;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e266ddae0c31..bae8d8643490 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5835,11 +5835,12 @@ static void rtw89_physts_parsing_init(struct rtw89_dev *rtwdev)
 		__rtw89_physts_parsing_init(rtwdev, RTW89_PHY_1);
 }
 
-static void rtw89_phy_dig_read_gain_table(struct rtw89_dev *rtwdev, int type)
+static void rtw89_phy_dig_read_gain_table(struct rtw89_dev *rtwdev,
+					  struct rtw89_bb_ctx *bb, int type)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_dig_info *dig = &rtwdev->dig;
 	const struct rtw89_phy_dig_gain_cfg *cfg;
+	struct rtw89_dig_info *dig = &bb->dig;
 	const char *msg;
 	u8 i;
 	s8 gain_base;
@@ -5876,8 +5877,8 @@ static void rtw89_phy_dig_read_gain_table(struct rtw89_dev *rtwdev, int type)
 	}
 
 	for (i = 0; i < cfg->size; i++) {
-		tmp = rtw89_phy_read32_mask(rtwdev, cfg->table[i].addr,
-					    cfg->table[i].mask);
+		tmp = rtw89_phy_read32_idx(rtwdev, cfg->table[i].addr,
+					   cfg->table[i].mask, bb->phy_idx);
 		tmp >>= DIG_GAIN_SHIFT;
 		gain_arr[i] = sign_extend32(tmp, U4_MAX_BIT) + gain_base;
 		gain_base += DIG_GAIN;
@@ -5887,25 +5888,26 @@ static void rtw89_phy_dig_read_gain_table(struct rtw89_dev *rtwdev, int type)
 	}
 }
 
-static void rtw89_phy_dig_update_gain_para(struct rtw89_dev *rtwdev)
+static void rtw89_phy_dig_update_gain_para(struct rtw89_dev *rtwdev,
+					   struct rtw89_bb_ctx *bb)
 {
-	struct rtw89_dig_info *dig = &rtwdev->dig;
+	struct rtw89_dig_info *dig = &bb->dig;
 	u32 tmp;
 	u8 i;
 
 	if (!rtwdev->hal.support_igi)
 		return;
 
-	tmp = rtw89_phy_read32_mask(rtwdev, R_PATH0_IB_PKPW,
-				    B_PATH0_IB_PKPW_MSK);
+	tmp = rtw89_phy_read32_idx(rtwdev, R_PATH0_IB_PKPW,
+				   B_PATH0_IB_PKPW_MSK, bb->phy_idx);
 	dig->ib_pkpwr = sign_extend32(tmp >> DIG_GAIN_SHIFT, U8_MAX_BIT);
-	dig->ib_pbk = rtw89_phy_read32_mask(rtwdev, R_PATH0_IB_PBK,
-					    B_PATH0_IB_PBK_MSK);
+	dig->ib_pbk = rtw89_phy_read32_idx(rtwdev, R_PATH0_IB_PBK,
+					   B_PATH0_IB_PBK_MSK, bb->phy_idx);
 	rtw89_debug(rtwdev, RTW89_DBG_DIG, "ib_pkpwr=%d, ib_pbk=%d\n",
 		    dig->ib_pkpwr, dig->ib_pbk);
 
 	for (i = RTW89_DIG_GAIN_LNA_G; i < RTW89_DIG_GAIN_MAX; i++)
-		rtw89_phy_dig_read_gain_table(rtwdev, i);
+		rtw89_phy_dig_read_gain_table(rtwdev, bb, i);
 }
 
 static const u8 rssi_nolink = 22;
@@ -5914,10 +5916,11 @@ static const u16 fa_th_2g[FA_TH_NUM] = {22, 44, 66, 88};
 static const u16 fa_th_5g[FA_TH_NUM] = {4, 8, 12, 16};
 static const u16 fa_th_nolink[FA_TH_NUM] = {196, 352, 440, 528};
 
-static void rtw89_phy_dig_update_rssi_info(struct rtw89_dev *rtwdev)
+static void rtw89_phy_dig_update_rssi_info(struct rtw89_dev *rtwdev,
+					   struct rtw89_bb_ctx *bb)
 {
 	struct rtw89_phy_ch_info *ch_info = &rtwdev->ch_info;
-	struct rtw89_dig_info *dig = &rtwdev->dig;
+	struct rtw89_dig_info *dig = &bb->dig;
 	bool is_linked = rtwdev->total_sta_assoc > 0;
 
 	if (is_linked) {
@@ -5928,10 +5931,11 @@ static void rtw89_phy_dig_update_rssi_info(struct rtw89_dev *rtwdev)
 	}
 }
 
-static void rtw89_phy_dig_update_para(struct rtw89_dev *rtwdev)
+static void rtw89_phy_dig_update_para(struct rtw89_dev *rtwdev,
+				      struct rtw89_bb_ctx *bb)
 {
-	struct rtw89_dig_info *dig = &rtwdev->dig;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_mgnt_chan_get(rtwdev, bb->phy_idx);
+	struct rtw89_dig_info *dig = &bb->dig;
 	bool is_linked = rtwdev->total_sta_assoc > 0;
 	const u16 *fa_th_src = NULL;
 
@@ -5960,9 +5964,10 @@ static const u8 pd_low_th_offset = 16, dynamic_igi_min = 0x20;
 static const u8 igi_max_performance_mode = 0x5a;
 static const u8 dynamic_pd_threshold_max;
 
-static void rtw89_phy_dig_para_reset(struct rtw89_dev *rtwdev)
+static void rtw89_phy_dig_para_reset(struct rtw89_dev *rtwdev,
+				     struct rtw89_bb_ctx *bb)
 {
-	struct rtw89_dig_info *dig = &rtwdev->dig;
+	struct rtw89_dig_info *dig = &bb->dig;
 
 	dig->cur_gaincode.lna_idx = LNA_IDX_MAX;
 	dig->cur_gaincode.tia_idx = TIA_IDX_MAX;
@@ -5978,15 +5983,27 @@ static void rtw89_phy_dig_para_reset(struct rtw89_dev *rtwdev)
 	dig->is_linked_pre = false;
 }
 
+static void __rtw89_phy_dig_init(struct rtw89_dev *rtwdev,
+				 struct rtw89_bb_ctx *bb)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_DIG, "BB-%d dig_init\n", bb->phy_idx);
+
+	rtw89_phy_dig_update_gain_para(rtwdev, bb);
+	rtw89_phy_dig_reset(rtwdev, bb);
+}
+
 static void rtw89_phy_dig_init(struct rtw89_dev *rtwdev)
 {
-	rtw89_phy_dig_update_gain_para(rtwdev);
-	rtw89_phy_dig_reset(rtwdev);
+	struct rtw89_bb_ctx *bb;
+
+	rtw89_for_each_capab_bb(rtwdev, bb)
+		__rtw89_phy_dig_init(rtwdev, bb);
 }
 
-static u8 rtw89_phy_dig_lna_idx_by_rssi(struct rtw89_dev *rtwdev, u8 rssi)
+static u8 rtw89_phy_dig_lna_idx_by_rssi(struct rtw89_dev *rtwdev,
+					struct rtw89_bb_ctx *bb, u8 rssi)
 {
-	struct rtw89_dig_info *dig = &rtwdev->dig;
+	struct rtw89_dig_info *dig = &bb->dig;
 	u8 lna_idx;
 
 	if (rssi < dig->igi_rssi_th[0])
@@ -6005,9 +6022,10 @@ static u8 rtw89_phy_dig_lna_idx_by_rssi(struct rtw89_dev *rtwdev, u8 rssi)
 	return lna_idx;
 }
 
-static u8 rtw89_phy_dig_tia_idx_by_rssi(struct rtw89_dev *rtwdev, u8 rssi)
+static u8 rtw89_phy_dig_tia_idx_by_rssi(struct rtw89_dev *rtwdev,
+					struct rtw89_bb_ctx *bb, u8 rssi)
 {
-	struct rtw89_dig_info *dig = &rtwdev->dig;
+	struct rtw89_dig_info *dig = &bb->dig;
 	u8 tia_idx;
 
 	if (rssi < dig->igi_rssi_th[0])
@@ -6020,10 +6038,11 @@ static u8 rtw89_phy_dig_tia_idx_by_rssi(struct rtw89_dev *rtwdev, u8 rssi)
 
 #define IB_PBK_BASE 110
 #define WB_RSSI_BASE 10
-static u8 rtw89_phy_dig_rxb_idx_by_rssi(struct rtw89_dev *rtwdev, u8 rssi,
+static u8 rtw89_phy_dig_rxb_idx_by_rssi(struct rtw89_dev *rtwdev,
+					struct rtw89_bb_ctx *bb, u8 rssi,
 					struct rtw89_agc_gaincode_set *set)
 {
-	struct rtw89_dig_info *dig = &rtwdev->dig;
+	struct rtw89_dig_info *dig = &bb->dig;
 	s8 lna_gain = dig->lna_gain[set->lna_idx];
 	s8 tia_gain = dig->tia_gain[set->tia_idx];
 	s32 wb_rssi = rssi + lna_gain + tia_gain;
@@ -6039,12 +6058,13 @@ static u8 rtw89_phy_dig_rxb_idx_by_rssi(struct rtw89_dev *rtwdev, u8 rssi,
 	return rxb_idx;
 }
 
-static void rtw89_phy_dig_gaincode_by_rssi(struct rtw89_dev *rtwdev, u8 rssi,
+static void rtw89_phy_dig_gaincode_by_rssi(struct rtw89_dev *rtwdev,
+					   struct rtw89_bb_ctx *bb, u8 rssi,
 					   struct rtw89_agc_gaincode_set *set)
 {
-	set->lna_idx = rtw89_phy_dig_lna_idx_by_rssi(rtwdev, rssi);
-	set->tia_idx = rtw89_phy_dig_tia_idx_by_rssi(rtwdev, rssi);
-	set->rxb_idx = rtw89_phy_dig_rxb_idx_by_rssi(rtwdev, rssi, set);
+	set->lna_idx = rtw89_phy_dig_lna_idx_by_rssi(rtwdev, bb, rssi);
+	set->tia_idx = rtw89_phy_dig_tia_idx_by_rssi(rtwdev, bb, rssi);
+	set->rxb_idx = rtw89_phy_dig_rxb_idx_by_rssi(rtwdev, bb, rssi, set);
 
 	rtw89_debug(rtwdev, RTW89_DBG_DIG,
 		    "final_rssi=%03d, (lna,tia,rab)=(%d,%d,%02d)\n",
@@ -6053,10 +6073,11 @@ static void rtw89_phy_dig_gaincode_by_rssi(struct rtw89_dev *rtwdev, u8 rssi,
 
 #define IGI_OFFSET_MAX 25
 #define IGI_OFFSET_MUL 2
-static void rtw89_phy_dig_igi_offset_by_env(struct rtw89_dev *rtwdev)
+static void rtw89_phy_dig_igi_offset_by_env(struct rtw89_dev *rtwdev,
+					    struct rtw89_bb_ctx *bb)
 {
-	struct rtw89_dig_info *dig = &rtwdev->dig;
-	struct rtw89_env_monitor_info *env = &rtwdev->bbs[0].env_monitor;
+	struct rtw89_dig_info *dig = &bb->dig;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
 	enum rtw89_dig_noisy_level noisy_lv;
 	u8 igi_offset = dig->fa_rssi_ofst;
 	u16 fa_ratio = 0;
@@ -6093,92 +6114,99 @@ static void rtw89_phy_dig_igi_offset_by_env(struct rtw89_dev *rtwdev)
 		    noisy_lv, igi_offset);
 }
 
-static void rtw89_phy_dig_set_lna_idx(struct rtw89_dev *rtwdev, u8 lna_idx)
+static void rtw89_phy_dig_set_lna_idx(struct rtw89_dev *rtwdev,
+				      struct rtw89_bb_ctx *bb, u8 lna_idx)
 {
 	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 
-	rtw89_phy_write32_mask(rtwdev, dig_regs->p0_lna_init.addr,
-			       dig_regs->p0_lna_init.mask, lna_idx);
-	rtw89_phy_write32_mask(rtwdev, dig_regs->p1_lna_init.addr,
-			       dig_regs->p1_lna_init.mask, lna_idx);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->p0_lna_init.addr,
+			      dig_regs->p0_lna_init.mask, lna_idx, bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->p1_lna_init.addr,
+			      dig_regs->p1_lna_init.mask, lna_idx, bb->phy_idx);
 }
 
-static void rtw89_phy_dig_set_tia_idx(struct rtw89_dev *rtwdev, u8 tia_idx)
+static void rtw89_phy_dig_set_tia_idx(struct rtw89_dev *rtwdev,
+				      struct rtw89_bb_ctx *bb, u8 tia_idx)
 {
 	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 
-	rtw89_phy_write32_mask(rtwdev, dig_regs->p0_tia_init.addr,
-			       dig_regs->p0_tia_init.mask, tia_idx);
-	rtw89_phy_write32_mask(rtwdev, dig_regs->p1_tia_init.addr,
-			       dig_regs->p1_tia_init.mask, tia_idx);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->p0_tia_init.addr,
+			      dig_regs->p0_tia_init.mask, tia_idx, bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->p1_tia_init.addr,
+			      dig_regs->p1_tia_init.mask, tia_idx, bb->phy_idx);
 }
 
-static void rtw89_phy_dig_set_rxb_idx(struct rtw89_dev *rtwdev, u8 rxb_idx)
+static void rtw89_phy_dig_set_rxb_idx(struct rtw89_dev *rtwdev,
+				      struct rtw89_bb_ctx *bb, u8 rxb_idx)
 {
 	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 
-	rtw89_phy_write32_mask(rtwdev, dig_regs->p0_rxb_init.addr,
-			       dig_regs->p0_rxb_init.mask, rxb_idx);
-	rtw89_phy_write32_mask(rtwdev, dig_regs->p1_rxb_init.addr,
-			       dig_regs->p1_rxb_init.mask, rxb_idx);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->p0_rxb_init.addr,
+			      dig_regs->p0_rxb_init.mask, rxb_idx, bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->p1_rxb_init.addr,
+			      dig_regs->p1_rxb_init.mask, rxb_idx, bb->phy_idx);
 }
 
 static void rtw89_phy_dig_set_igi_cr(struct rtw89_dev *rtwdev,
+				     struct rtw89_bb_ctx *bb,
 				     const struct rtw89_agc_gaincode_set set)
 {
 	if (!rtwdev->hal.support_igi)
 		return;
 
-	rtw89_phy_dig_set_lna_idx(rtwdev, set.lna_idx);
-	rtw89_phy_dig_set_tia_idx(rtwdev, set.tia_idx);
-	rtw89_phy_dig_set_rxb_idx(rtwdev, set.rxb_idx);
+	rtw89_phy_dig_set_lna_idx(rtwdev, bb, set.lna_idx);
+	rtw89_phy_dig_set_tia_idx(rtwdev, bb, set.tia_idx);
+	rtw89_phy_dig_set_rxb_idx(rtwdev, bb, set.rxb_idx);
 
 	rtw89_debug(rtwdev, RTW89_DBG_DIG, "Set (lna,tia,rxb)=((%d,%d,%02d))\n",
 		    set.lna_idx, set.tia_idx, set.rxb_idx);
 }
 
 static void rtw89_phy_dig_sdagc_follow_pagc_config(struct rtw89_dev *rtwdev,
+						   struct rtw89_bb_ctx *bb,
 						   bool enable)
 {
 	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 
-	rtw89_phy_write32_mask(rtwdev, dig_regs->p0_p20_pagcugc_en.addr,
-			       dig_regs->p0_p20_pagcugc_en.mask, enable);
-	rtw89_phy_write32_mask(rtwdev, dig_regs->p0_s20_pagcugc_en.addr,
-			       dig_regs->p0_s20_pagcugc_en.mask, enable);
-	rtw89_phy_write32_mask(rtwdev, dig_regs->p1_p20_pagcugc_en.addr,
-			       dig_regs->p1_p20_pagcugc_en.mask, enable);
-	rtw89_phy_write32_mask(rtwdev, dig_regs->p1_s20_pagcugc_en.addr,
-			       dig_regs->p1_s20_pagcugc_en.mask, enable);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->p0_p20_pagcugc_en.addr,
+			      dig_regs->p0_p20_pagcugc_en.mask, enable, bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->p0_s20_pagcugc_en.addr,
+			      dig_regs->p0_s20_pagcugc_en.mask, enable, bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->p1_p20_pagcugc_en.addr,
+			      dig_regs->p1_p20_pagcugc_en.mask, enable, bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->p1_s20_pagcugc_en.addr,
+			      dig_regs->p1_s20_pagcugc_en.mask, enable, bb->phy_idx);
 
 	rtw89_debug(rtwdev, RTW89_DBG_DIG, "sdagc_follow_pagc=%d\n", enable);
 }
 
-static void rtw89_phy_dig_config_igi(struct rtw89_dev *rtwdev)
+static void rtw89_phy_dig_config_igi(struct rtw89_dev *rtwdev,
+				     struct rtw89_bb_ctx *bb)
 {
-	struct rtw89_dig_info *dig = &rtwdev->dig;
+	struct rtw89_dig_info *dig = &bb->dig;
 
 	if (!rtwdev->hal.support_igi)
 		return;
 
 	if (dig->force_gaincode_idx_en) {
-		rtw89_phy_dig_set_igi_cr(rtwdev, dig->force_gaincode);
+		rtw89_phy_dig_set_igi_cr(rtwdev, bb, dig->force_gaincode);
 		rtw89_debug(rtwdev, RTW89_DBG_DIG,
 			    "Force gaincode index enabled.\n");
 	} else {
-		rtw89_phy_dig_gaincode_by_rssi(rtwdev, dig->igi_fa_rssi,
+		rtw89_phy_dig_gaincode_by_rssi(rtwdev, bb, dig->igi_fa_rssi,
 					       &dig->cur_gaincode);
-		rtw89_phy_dig_set_igi_cr(rtwdev, dig->cur_gaincode);
+		rtw89_phy_dig_set_igi_cr(rtwdev, bb, dig->cur_gaincode);
 	}
 }
 
-static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
-				    bool enable)
+static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev,
+				    struct rtw89_bb_ctx *bb,
+				    u8 rssi, bool enable)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_mgnt_chan_get(rtwdev, bb->phy_idx);
 	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 	enum rtw89_bandwidth cbw = chan->band_width;
-	struct rtw89_dig_info *dig = &rtwdev->dig;
+	struct rtw89_dig_info *dig = &bb->dig;
 	u8 final_rssi = 0, under_region = dig->pd_low_th_ofst;
 	u8 ofdm_cca_th;
 	s8 cck_cca_th;
@@ -6220,10 +6248,10 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
 			    "Dynamic PD th disabled, Set PD_low_bd=0\n");
 	}
 
-	rtw89_phy_write32_mask(rtwdev, dig_regs->seg0_pd_reg,
-			       dig_regs->pd_lower_bound_mask, pd_val);
-	rtw89_phy_write32_mask(rtwdev, dig_regs->seg0_pd_reg,
-			       dig_regs->pd_spatial_reuse_en, enable);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->seg0_pd_reg,
+			      dig_regs->pd_lower_bound_mask, pd_val, bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->seg0_pd_reg,
+			      dig_regs->pd_spatial_reuse_en, enable, bb->phy_idx);
 
 	if (!rtwdev->hal.support_cckpd)
 		return;
@@ -6235,29 +6263,29 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
 		    "igi=%d, cck_ccaTH=%d, backoff=%d, cck_PD_low=((%d))dB\n",
 		    final_rssi, cck_cca_th, under_region, pd_val);
 
-	rtw89_phy_write32_mask(rtwdev, dig_regs->bmode_pd_reg,
-			       dig_regs->bmode_cca_rssi_limit_en, enable);
-	rtw89_phy_write32_mask(rtwdev, dig_regs->bmode_pd_lower_bound_reg,
-			       dig_regs->bmode_rssi_nocca_low_th_mask, pd_val);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->bmode_pd_reg,
+			      dig_regs->bmode_cca_rssi_limit_en, enable, bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, dig_regs->bmode_pd_lower_bound_reg,
+			      dig_regs->bmode_rssi_nocca_low_th_mask, pd_val, bb->phy_idx);
 }
 
-void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev)
+void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 {
-	struct rtw89_dig_info *dig = &rtwdev->dig;
+	struct rtw89_dig_info *dig = &bb->dig;
 
 	dig->bypass_dig = false;
-	rtw89_phy_dig_para_reset(rtwdev);
-	rtw89_phy_dig_set_igi_cr(rtwdev, dig->force_gaincode);
-	rtw89_phy_dig_dyn_pd_th(rtwdev, rssi_nolink, false);
-	rtw89_phy_dig_sdagc_follow_pagc_config(rtwdev, false);
-	rtw89_phy_dig_update_para(rtwdev);
+	rtw89_phy_dig_para_reset(rtwdev, bb);
+	rtw89_phy_dig_set_igi_cr(rtwdev, bb, dig->force_gaincode);
+	rtw89_phy_dig_dyn_pd_th(rtwdev, bb, rssi_nolink, false);
+	rtw89_phy_dig_sdagc_follow_pagc_config(rtwdev, bb, false);
+	rtw89_phy_dig_update_para(rtwdev, bb);
 }
 
 #define IGI_RSSI_MIN 10
 #define ABS_IGI_MIN 0xc
-void rtw89_phy_dig(struct rtw89_dev *rtwdev)
+static void __rtw89_phy_dig(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 {
-	struct rtw89_dig_info *dig = &rtwdev->dig;
+	struct rtw89_dig_info *dig = &bb->dig;
 	bool is_linked = rtwdev->total_sta_assoc > 0;
 	u8 igi_min;
 
@@ -6266,20 +6294,22 @@ void rtw89_phy_dig(struct rtw89_dev *rtwdev)
 		return;
 	}
 
-	rtw89_phy_dig_update_rssi_info(rtwdev);
+	rtw89_debug(rtwdev, RTW89_DBG_DIG, "BB-%d dig track\n", bb->phy_idx);
+
+	rtw89_phy_dig_update_rssi_info(rtwdev, bb);
 
 	if (!dig->is_linked_pre && is_linked) {
 		rtw89_debug(rtwdev, RTW89_DBG_DIG, "First connected\n");
-		rtw89_phy_dig_update_para(rtwdev);
+		rtw89_phy_dig_update_para(rtwdev, bb);
 		dig->igi_fa_rssi = dig->igi_rssi;
 	} else if (dig->is_linked_pre && !is_linked) {
 		rtw89_debug(rtwdev, RTW89_DBG_DIG, "First disconnected\n");
-		rtw89_phy_dig_update_para(rtwdev);
+		rtw89_phy_dig_update_para(rtwdev, bb);
 		dig->igi_fa_rssi = dig->igi_rssi;
 	}
 	dig->is_linked_pre = is_linked;
 
-	rtw89_phy_dig_igi_offset_by_env(rtwdev);
+	rtw89_phy_dig_igi_offset_by_env(rtwdev, bb);
 
 	igi_min = max_t(int, dig->igi_rssi - IGI_RSSI_MIN, 0);
 	dig->dyn_igi_max = min(igi_min + IGI_OFFSET_MAX, igi_max_performance_mode);
@@ -6298,14 +6328,22 @@ void rtw89_phy_dig(struct rtw89_dev *rtwdev)
 		    dig->igi_rssi, dig->dyn_igi_max, dig->dyn_igi_min,
 		    dig->igi_fa_rssi);
 
-	rtw89_phy_dig_config_igi(rtwdev);
+	rtw89_phy_dig_config_igi(rtwdev, bb);
 
-	rtw89_phy_dig_dyn_pd_th(rtwdev, dig->igi_fa_rssi, dig->dyn_pd_th_en);
+	rtw89_phy_dig_dyn_pd_th(rtwdev, bb, dig->igi_fa_rssi, dig->dyn_pd_th_en);
 
 	if (dig->dyn_pd_th_en && dig->igi_fa_rssi > dig->dyn_pd_th_max)
-		rtw89_phy_dig_sdagc_follow_pagc_config(rtwdev, true);
+		rtw89_phy_dig_sdagc_follow_pagc_config(rtwdev, bb, true);
 	else
-		rtw89_phy_dig_sdagc_follow_pagc_config(rtwdev, false);
+		rtw89_phy_dig_sdagc_follow_pagc_config(rtwdev, bb, false);
+}
+
+void rtw89_phy_dig(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_bb_ctx *bb;
+
+	rtw89_for_each_active_bb(rtwdev, bb)
+		__rtw89_phy_dig(rtwdev, bb);
 }
 
 static void __rtw89_phy_tx_path_div_sta_iter(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 08b635c93ac3..db748c7453cd 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -985,7 +985,7 @@ void rtw89_phy_stat_track(struct rtw89_dev *rtwdev);
 void rtw89_phy_env_monitor_track(struct rtw89_dev *rtwdev);
 void rtw89_phy_set_phy_regs(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			    u32 val);
-void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev);
+void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb);
 void rtw89_phy_dig(struct rtw89_dev *rtwdev);
 void rtw89_phy_tx_path_div_track(struct rtw89_dev *rtwdev);
 void rtw89_phy_antdiv_parse(struct rtw89_dev *rtwdev,
-- 
2.25.1


