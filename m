Return-Path: <linux-wireless+bounces-4579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D803878C60
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 02:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43E1282CF5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 01:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169EB4687;
	Tue, 12 Mar 2024 01:38:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13861C2E
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 01:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207523; cv=none; b=XGmEBeFg78pJqvXQmEIt/wR+q3bq8NdG4VeLwx09hlrINEtJRoIkOJ3pt3+lngMqhuFKdQB8RKwUvoqziRDg2xW+FdBi6FFQNhcTreWNeRyBQRYI5WdihegSpmtEmU4m5YVfgDOKO6+Cf0dOvsB1Uv+kWtWUPoN/KxiUym6sdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207523; c=relaxed/simple;
	bh=+ziNL3Q4hjYSwGpSEBQ3QfQcLVMokwldp5FEuz4c5LY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UujefSdGZQjndypWjYoi6XBUsPmum5djwYQYvTdW26dn92Y5r4qi+kt0Q+nKo6nCxHe2lfVemyDEYXrn1cmUpb5ywzxRmdM7dDRdO+5HfJ4K2xvm5fpJjXl8Hkm9KAgT3EzstXSQY8hkbHFTT2Oe/eEAWx/fyYhVNDq06ghJvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42C1cZCK13941699, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42C1cZCK13941699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 09:38:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 09:38:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 12 Mar
 2024 09:38:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/6] wifi: rtw89: coex: Add antenna setting function for RTL8922A
Date: Tue, 12 Mar 2024 09:37:17 +0800
Message-ID: <20240312013721.17452-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312013721.17452-1-pkshih@realtek.com>
References: <20240312013721.17452-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Ching-Te Ku <ku920601@realtek.com>

Because there is new hardware structure and Wi-Fi 7 protocol,
the antenna settings need to concern more complex for Wi-Fi 7
using. The antenna setting included grant control signal, they
decide which MAC/Port or Bluetooth can do traffic.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 193 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/coex.h |   5 +
 drivers/net/wireless/realtek/rtw89/core.h |   1 +
 3 files changed, 197 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 955664fbcbc2..57bf23d1adc7 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -311,6 +311,7 @@ enum btc_ant_phase {
 	BTC_ANT_W25G,
 	BTC_ANT_FREERUN,
 	BTC_ANT_WRFK,
+	BTC_ANT_WRFK2,
 	BTC_ANT_BRFK,
 	BTC_ANT_MAX
 };
@@ -615,6 +616,13 @@ enum btc_ctr_path {
 	BTC_CTRL_BY_WL
 };
 
+enum btc_wlact_state {
+	BTC_WLACT_HW = 0,
+	BTC_WLACT_SW_LO,
+	BTC_WLACT_SW_HI,
+	BTC_WLACT_MAX,
+};
+
 enum btc_wl_max_tx_time {
 	BTC_MAX_TX_TIME_L1 = 500,
 	BTC_MAX_TX_TIME_L2 = 1000,
@@ -2247,6 +2255,76 @@ static void _set_gnt(struct rtw89_dev *rtwdev, u8 phy_map, u8 wl_state, u8 bt_st
 	rtw89_chip_mac_cfg_gnt(rtwdev, &dm->gnt);
 }
 
+static void _set_gnt_v1(struct rtw89_dev *rtwdev, u8 phy_map,
+			u8 wl_state, u8 bt_state, u8 wlact_state)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
+	u8 i, bt_idx = dm->bt_select + 1;
+
+	if (phy_map > BTC_PHY_ALL)
+		return;
+
+	for (i = 0; i < RTW89_PHY_MAX; i++) {
+		if (!(phy_map & BIT(i)))
+			continue;
+
+		switch (wl_state) {
+		case BTC_GNT_HW:
+			g[i].gnt_wl_sw_en = 0;
+			g[i].gnt_wl = 0;
+			break;
+		case BTC_GNT_SW_LO:
+			g[i].gnt_wl_sw_en = 1;
+			g[i].gnt_wl = 0;
+			break;
+		case BTC_GNT_SW_HI:
+			g[i].gnt_wl_sw_en = 1;
+			g[i].gnt_wl = 1;
+			break;
+		}
+
+		switch (bt_state) {
+		case BTC_GNT_HW:
+			g[i].gnt_bt_sw_en = 0;
+			g[i].gnt_bt = 0;
+			break;
+		case BTC_GNT_SW_LO:
+			g[i].gnt_bt_sw_en = 1;
+			g[i].gnt_bt = 0;
+			break;
+		case BTC_GNT_SW_HI:
+			g[i].gnt_bt_sw_en = 1;
+			g[i].gnt_bt = 1;
+			break;
+		}
+	}
+
+	if (rtwdev->chip->para_ver & BTC_FEAT_WLAN_ACT_MUX) {
+		for (i = 0; i < 2; i++) {
+			if (!(bt_idx & BIT(i)))
+				continue;
+
+			switch (wlact_state) {
+			case BTC_WLACT_HW:
+				dm->gnt.bt[i].wlan_act_en = 0;
+				dm->gnt.bt[i].wlan_act = 0;
+				break;
+			case BTC_WLACT_SW_LO:
+				dm->gnt.bt[i].wlan_act_en = 1;
+				dm->gnt.bt[i].wlan_act = 0;
+				break;
+			case BTC_WLACT_SW_HI:
+				dm->gnt.bt[i].wlan_act_en = 1;
+				dm->gnt.bt[i].wlan_act = 1;
+				break;
+			}
+		}
+	}
+	rtw89_mac_cfg_gnt_v2(rtwdev, &dm->gnt);
+}
+
 #define BTC_TDMA_WLROLE_MAX 2
 
 static void _set_bt_ignore_wlan_act(struct rtw89_dev *rtwdev, u8 enable)
@@ -3512,8 +3590,8 @@ static void _set_bt_plut(struct rtw89_dev *rtwdev, u8 phy_map,
 		rtw89_mac_cfg_plt(rtwdev, &plt);
 }
 
-static void _set_ant(struct rtw89_dev *rtwdev, bool force_exec,
-		     u8 phy_map, u8 type)
+static void _set_ant_v0(struct rtw89_dev *rtwdev, bool force_exec,
+			u8 phy_map, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
@@ -3639,6 +3717,117 @@ static void _set_ant(struct rtw89_dev *rtwdev, bool force_exec,
 	}
 }
 
+static void _set_ant_v1(struct rtw89_dev *rtwdev, bool force_exec,
+			u8 phy_map, u8 type)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
+	u32 ant_path_type = rtw89_get_antpath_type(phy_map, type);
+	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u8 gwl = BTC_GNT_HW;
+
+	if (btc->dm.run_reason == BTC_RSN_NTFY_POWEROFF ||
+	    btc->dm.run_reason == BTC_RSN_NTFY_RADIO_STATE ||
+	    btc->dm.run_reason == BTC_RSN_CMD_SET_COEX || wl_rinfo->dbcc_chg)
+		force_exec = FC_EXEC;
+
+	if (wl_rinfo->link_mode != BTC_WLINK_25G_MCC &&
+	    btc->dm.wl_btg_rx == 2)
+		force_exec = FC_EXEC;
+
+	if (!force_exec && ant_path_type == dm->set_ant_path) {
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s(): return by no change!!\n",
+			     __func__);
+		return;
+	} else if (bt->rfk_info.map.run) {
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s(): return by bt rfk!!\n", __func__);
+		return;
+	} else if (btc->dm.run_reason != BTC_RSN_NTFY_WL_RFK &&
+		   wl->rfk_info.state != BTC_WRFK_STOP) {
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s(): return by wl rfk!!\n", __func__);
+		return;
+	}
+
+	dm->set_ant_path = ant_path_type;
+
+	rtw89_debug(rtwdev, RTW89_DBG_BTC,
+		    "[BTC], %s(): path=0x%x, set_type=0x%x\n",
+		    __func__, phy_map, dm->set_ant_path & 0xff);
+
+	switch (type) {
+	case BTC_ANT_WINIT:
+		/* To avoid BT MP driver case (bt_enable but no mailbox) */
+		if (bt->enable.now && bt->run_patch_code)
+			_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_LO, BTC_GNT_SW_HI,
+				    BTC_WLACT_SW_LO);
+		else
+			_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
+				    BTC_WLACT_SW_HI);
+		break;
+	case BTC_ANT_WONLY:
+		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
+			    BTC_WLACT_SW_HI);
+		break;
+	case BTC_ANT_WOFF:
+		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_LO, BTC_GNT_SW_HI,
+			    BTC_WLACT_SW_LO);
+		break;
+	case BTC_ANT_W2G:
+	case BTC_ANT_W25G:
+		if (wl_rinfo->dbcc_en) {
+			if (wl_dinfo->real_band[RTW89_PHY_0] == RTW89_BAND_2G)
+				gwl = BTC_GNT_HW;
+			else
+				gwl = BTC_GNT_SW_HI;
+			_set_gnt_v1(rtwdev, BTC_PHY_0, gwl, BTC_GNT_HW, BTC_WLACT_HW);
+
+			if (wl_dinfo->real_band[RTW89_PHY_1] == RTW89_BAND_2G)
+				gwl = BTC_GNT_HW;
+			else
+				gwl = BTC_GNT_SW_HI;
+			_set_gnt_v1(rtwdev, BTC_PHY_1, gwl, BTC_GNT_HW, BTC_WLACT_HW);
+		} else {
+			gwl = BTC_GNT_HW;
+			_set_gnt_v1(rtwdev, phy_map, gwl, BTC_GNT_HW, BTC_WLACT_HW);
+		}
+		break;
+	case BTC_ANT_W5G:
+		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_HW, BTC_WLACT_HW);
+		break;
+	case BTC_ANT_FREERUN:
+		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_HI,
+			    BTC_WLACT_SW_LO);
+		break;
+	case BTC_ANT_WRFK:
+		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
+			    BTC_WLACT_HW);
+		break;
+	case BTC_ANT_WRFK2:
+		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
+			    BTC_WLACT_SW_HI); /* no BT-Tx */
+		break;
+	default:
+		return;
+	}
+
+	_set_bt_plut(rtwdev, phy_map, BTC_PLT_GNT_WL, BTC_PLT_GNT_WL);
+}
+
+static void _set_ant(struct rtw89_dev *rtwdev, bool force_exec,
+		     u8 phy_map, u8 type)
+{
+	if (rtwdev->chip->chip_id == RTL8922A)
+		_set_ant_v1(rtwdev, force_exec, phy_map, type);
+	else
+		_set_ant_v0(rtwdev, force_exec, phy_map, type);
+}
+
 static void _action_wl_only(struct rtw89_dev *rtwdev)
 {
 	_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_WONLY);
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 32c95022d6ee..671f52fe8931 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -280,4 +280,9 @@ static inline u16 rtw89_coex_query_bt_req_len(struct rtw89_dev *rtwdev,
 	return btc->bt_req_len;
 }
 
+static inline u32 rtw89_get_antpath_type(u8 phy_map, u8 type)
+{
+	return ((phy_map << 8) + type);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8617c65ff60e..bc10ebb785a2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2658,6 +2658,7 @@ struct rtw89_btc_dm {
 	u8 wl_pre_agc: 2;
 	u8 wl_lna2: 1;
 	u8 wl_pre_agc_rb: 2;
+	u8 bt_select: 2; /* 0:s0, 1:s1, 2:s0 & s1, refer to enum btc_bt_index */
 };
 
 struct rtw89_btc_ctrl {
-- 
2.25.1


