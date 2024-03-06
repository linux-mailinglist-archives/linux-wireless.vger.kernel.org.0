Return-Path: <linux-wireless+bounces-4408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4573872DA6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 04:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45DC4B25C68
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 03:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DA779E4;
	Wed,  6 Mar 2024 03:47:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A52214A8B
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696839; cv=none; b=cf6CcUx7ZH/zIzFWkQX2VngjHYaysYDK/S0k5jXyF7CbKyI4z0/9FBbduuXG/o/nF5q9pdo4++ikr5zMgTc1UMW68szumPiWqI5M2muTjWPmXWotR2U7JYa/KFYiS7mE9YxQKVpgrEZ2pQe5Jz2YYP/kDQFBdi+goJuPyqDw+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696839; c=relaxed/simple;
	bh=PIsMp1U8wTSWxNoCRvO7zuAs1N7pUkc82Wh63StPWr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGxpQ2x4FimodKx8rnosH8t2cpG3E2ODbGvBqWvfTLYCPeyaUUHBL1zbA/JdohTZMDY16wst4vUldYGfexmzDQ4TpUVfNq2ZDACNxlbaQdN7GZH053j2ppghaPWPYm8eILGSqmmEIYMHV6iemCoFDD6ENImyP96t5RwpIz3+oHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4263l2hY5482437, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4263l2hY5482437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 11:47:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 11:47:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 11:47:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: coex: Add WiFi role info format version 8
Date: Wed, 6 Mar 2024 11:45:53 +0800
Message-ID: <20240306034558.19648-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306034558.19648-1-pkshih@realtek.com>
References: <20240306034558.19648-1-pkshih@realtek.com>
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

In order to control the hardware band and related protocol control,
add version 8 format and related logic to control the mechanism.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 458 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/coex.h     |  19 +
 drivers/net/wireless/realtek/rtw89/core.h     |  62 +++
 drivers/net/wireless/realtek/rtw89/fw.c       |  42 ++
 drivers/net/wireless/realtek/rtw89/fw.h       |  27 ++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   5 +
 6 files changed, 588 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index d9b66d43f32e..836d958c4f6f 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -12,6 +12,7 @@
 
 #define RTW89_COEX_VERSION 0x07000113
 #define FCXDEF_STEP 50 /* MUST <= FCXMAX_STEP and match with wl fw*/
+#define BTC_E2G_LIMIT_DEF 80
 
 enum btc_fbtc_tdma_template {
 	CXTD_OFF = 0x0,
@@ -133,7 +134,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
-	 .fwlrole = 2,   .frptmap = 7,    .fcxctrl = 7,  .fcxinit = 7,
+	 .fwlrole = 8,   .frptmap = 7,    .fcxctrl = 7,  .fcxinit = 7,
 	 .drvinfo_type = 1, .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8851B, RTW89_FW_VER_CODE(0, 29, 29, 0),
@@ -739,7 +740,7 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
-	struct rtw89_btc_wl_link_info *wl_linfo = wl->link_info;
+	struct rtw89_btc_wl_link_info *wl_linfo;
 	u8 i;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s\n", __func__);
@@ -761,10 +762,13 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 	if (type & BTC_RESET_DM) {
 		memset(&btc->dm, 0, sizeof(btc->dm));
 		memset(bt_linfo->rssi_state, 0, sizeof(bt_linfo->rssi_state));
-
-		for (i = 0; i < RTW89_PORT_NUM; i++)
-			memset(wl_linfo[i].rssi_state, 0,
-			       sizeof(wl_linfo[i].rssi_state));
+		for (i = 0; i < RTW89_PORT_NUM; i++) {
+			if (btc->ver->fwlrole == 8)
+				wl_linfo = &wl->rlink_info[i][0];
+			else
+				wl_linfo = &wl->link_info[i];
+			memset(wl_linfo->rssi_state, 0, sizeof(wl_linfo->rssi_state));
+		}
 
 		/* set the slot_now table to original */
 		btc->dm.tdma_now = t_def[CXTD_OFF];
@@ -2622,25 +2626,35 @@ static bool _check_freerun(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
+	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	struct rtw89_btc_bt_hid_desc *hid = &bt_linfo->hid_desc;
 	union rtw89_btc_module_info *md = &btc->mdinfo;
 	const struct rtw89_btc_ver *ver = btc->ver;
-	u8 isolation;
+	u8 isolation, connect_cnt = 0;
 
 	if (ver->fcxinit == 7)
 		isolation = md->md_v7.ant.isolation;
 	else
 		isolation = md->md.ant.isolation;
 
+	if (ver->fwlrole == 0)
+		connect_cnt = wl_rinfo->connect_cnt;
+	else if (ver->fwlrole == 1)
+		connect_cnt = wl_rinfo_v1->connect_cnt;
+	else if (ver->fwlrole == 2)
+		connect_cnt = wl_rinfo_v2->connect_cnt;
+	else if (ver->fwlrole == 8)
+		connect_cnt = wl_rinfo_v8->connect_cnt;
+
 	if (btc->ant_type == BTC_ANT_SHARED) {
 		btc->dm.trx_para_level = 0;
 		return false;
 	}
 
 	/* The below is dedicated antenna case */
-	if (wl_rinfo->connect_cnt > BTC_TDMA_WLROLE_MAX ||
-	    wl_rinfo_v1->connect_cnt > BTC_TDMA_WLROLE_MAX) {
+	if (connect_cnt > BTC_TDMA_WLROLE_MAX) {
 		btc->dm.trx_para_level = 5;
 		return true;
 	}
@@ -3508,13 +3522,21 @@ static void _set_ant(struct rtw89_dev *rtwdev, bool force_exec,
 	struct rtw89_btc_bt_info *bt = &cx->bt;
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 	u8 gnt_wl_ctrl, gnt_bt_ctrl, plt_ctrl, i, b2g = 0;
+	bool dbcc_chg = false;
 	u32 ant_path_type;
 
 	ant_path_type = ((phy_map << 8) + type);
 
+	if (btc->ver->fwlrole == 1)
+		dbcc_chg = wl->role_info_v1.dbcc_chg;
+	else if (btc->ver->fwlrole == 2)
+		dbcc_chg = wl->role_info_v2.dbcc_chg;
+	else if (btc->ver->fwlrole == 8)
+		dbcc_chg = wl->role_info_v8.dbcc_chg;
+
 	if (btc->dm.run_reason == BTC_RSN_NTFY_POWEROFF ||
 	    btc->dm.run_reason == BTC_RSN_NTFY_RADIO_STATE ||
-	    btc->dm.run_reason == BTC_RSN_CMD_SET_COEX)
+	    btc->dm.run_reason == BTC_RSN_CMD_SET_COEX || dbcc_chg)
 		force_exec = FC_EXEC;
 
 	if (!force_exec && ant_path_type == dm->set_ant_path) {
@@ -3641,7 +3663,7 @@ static void _action_wl_off(struct rtw89_dev *rtwdev, u8 mode)
 	if (wl->status.map.rf_off || btc->dm.bt_only) {
 		_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_WOFF);
 	} else if (wl->status.map.lps == BTC_LPS_RF_ON) {
-		if (wl->role_info.link_mode == BTC_WLINK_5G)
+		if (mode == BTC_WLINK_5G)
 			_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_W5G);
 		else
 			_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
@@ -4223,7 +4245,10 @@ static void rtw89_tx_time_iter(void *data, struct ieee80211_sta *sta)
 	u16 enable = iter_data->enable;
 	bool reenable = iter_data->reenable;
 
-	plink = &wl->link_info[port];
+	if (btc->ver->fwlrole == 8)
+		plink = &wl->rlink_info[port][0];
+	else
+		plink = &wl->link_info[port];
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): port = %d\n", __func__, port);
@@ -4276,6 +4301,7 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_txtime_data data = {.rtwdev = rtwdev};
 	u8 mode, igno_bt, tx_retry;
 	u32 tx_time;
@@ -4291,6 +4317,8 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 		mode = wl_rinfo_v1->link_mode;
 	else if (ver->fwlrole == 2)
 		mode = wl_rinfo_v2->link_mode;
+	else if (ver->fwlrole == 8)
+		mode = wl_rinfo_v8->link_mode;
 	else
 		return;
 
@@ -4348,6 +4376,7 @@ static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	bool bt_hi_lna_rx = false;
 	u8 mode;
@@ -4358,6 +4387,8 @@ static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 		mode = wl_rinfo_v1->link_mode;
 	else if (ver->fwlrole == 2)
 		mode = wl_rinfo_v2->link_mode;
+	else if (ver->fwlrole == 8)
+		mode = wl_rinfo_v8->link_mode;
 	else
 		return;
 
@@ -4695,6 +4726,31 @@ static void _action_wl_2g_scc_v2(struct rtw89_dev *rtwdev)
 	_set_policy(rtwdev, policy_type, BTC_ACT_WL_2G_SCC);
 }
 
+static void _action_wl_2g_scc_v8(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u16 policy_type = BTC_CXP_OFF_BT;
+
+	if (btc->ant_type == BTC_ANT_SHARED) {
+		if (wl->status.map._4way)
+			policy_type = BTC_CXP_OFFE_WL;
+		else if (bt->link_info.status.map.connect == 0)
+			policy_type = BTC_CXP_OFFE_2GISOB;
+		else
+			policy_type = BTC_CXP_OFFE_2GBWISOB;
+	} else {
+		policy_type = BTC_CXP_OFF_EQ0;
+	}
+
+	dm->e2g_slot_limit = BTC_E2G_LIMIT_DEF;
+
+	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
+	_set_policy(rtwdev, policy_type, BTC_ACT_WL_2G_SCC);
+}
+
 static void _action_wl_2g_ap(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -5287,6 +5343,310 @@ static void _update_wl_info_v2(struct rtw89_dev *rtwdev)
 #define BTC_CHK_HANG_MAX 3
 #define BTC_SCB_INV_VALUE GENMASK(31, 0)
 
+static u8 _get_role_link_mode(u8 role)
+{
+	switch (role) {
+	case RTW89_WIFI_ROLE_STATION:
+		return BTC_WLINK_2G_STA;
+	case RTW89_WIFI_ROLE_P2P_GO:
+		return BTC_WLINK_2G_GO;
+	case RTW89_WIFI_ROLE_P2P_CLIENT:
+		return BTC_WLINK_2G_GC;
+	case RTW89_WIFI_ROLE_AP:
+		return BTC_WLINK_2G_AP;
+	default:
+		return BTC_WLINK_OTHER;
+	}
+}
+
+static bool _chk_role_ch_group(const struct rtw89_btc_chdef *r1,
+			       const struct rtw89_btc_chdef *r2)
+{
+	if (r1->chan != r2->chan) { /* primary ch is different */
+		return false;
+	} else if (r1->bw == RTW89_CHANNEL_WIDTH_40 &&
+		   r2->bw == RTW89_CHANNEL_WIDTH_40) {
+		if (r1->offset != r2->offset)
+			return false;
+	}
+	return true;
+}
+
+static u8 _chk_dbcc(struct rtw89_dev *rtwdev, struct rtw89_btc_chdef *ch,
+		    u8 *phy, u8 *role, u8 *dbcc_2g_phy)
+{
+	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
+	bool is_2g_ch_exist = false, is_multi_role_in_2g_phy = false;
+	u8 j, k, dbcc_2g_cid, dbcc_2g_cid2;
+
+	/* find out the 2G-PHY by connect-id ->ch  */
+	for (j = 0; j < wl_rinfo->connect_cnt; j++) {
+		if (ch[j].center_ch <= 14) {
+			is_2g_ch_exist = true;
+			break;
+		}
+	}
+
+	/* If no any 2G-port exist, it's impossible because 5G-exclude */
+	if (!is_2g_ch_exist)
+		return BTC_WLINK_OTHER;
+
+	dbcc_2g_cid = j;
+	*dbcc_2g_phy = phy[dbcc_2g_cid];
+
+	/* connect_cnt <= 2 */
+	if (wl_rinfo->connect_cnt < BTC_TDMA_WLROLE_MAX)
+		return (_get_role_link_mode((role[dbcc_2g_cid])));
+
+	/* find the other-port in the 2G-PHY, ex: PHY-0:6G, PHY1: mcc/scc */
+	for (k = 0; k < wl_rinfo->connect_cnt; k++) {
+		if (k == dbcc_2g_cid)
+			continue;
+
+		if (phy[k] == *dbcc_2g_phy) {
+			is_multi_role_in_2g_phy = true;
+			dbcc_2g_cid2 = k;
+			break;
+		}
+	}
+
+	/* Single-role in 2G-PHY */
+	if (!is_multi_role_in_2g_phy)
+		return (_get_role_link_mode(role[dbcc_2g_cid]));
+
+	/* 2-role in 2G-PHY */
+	if (ch[dbcc_2g_cid2].center_ch > 14)
+		return BTC_WLINK_25G_MCC;
+	else if (_chk_role_ch_group(&ch[dbcc_2g_cid], &ch[dbcc_2g_cid2]))
+		return BTC_WLINK_2G_SCC;
+	else
+		return BTC_WLINK_2G_MCC;
+}
+
+static void _update_role_link_mode(struct rtw89_dev *rtwdev,
+				   bool client_joined, u32 noa)
+{
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &rtwdev->btc.cx.wl.role_info_v8;
+	u32 type = BTC_WLMROLE_NONE, dur = 0;
+	u32 wl_role = wl_rinfo->role_map;
+
+	/* if no client_joined, don't care P2P-GO/AP role */
+	if (((wl_role & BIT(RTW89_WIFI_ROLE_P2P_GO)) ||
+	     (wl_role & BIT(RTW89_WIFI_ROLE_AP))) && !client_joined) {
+		if (wl_rinfo->link_mode == BTC_WLINK_2G_SCC) {
+			wl_rinfo->link_mode = BTC_WLINK_2G_STA;
+			wl_rinfo->connect_cnt--;
+		} else if (wl_rinfo->link_mode == BTC_WLINK_2G_GO ||
+			wl_rinfo->link_mode == BTC_WLINK_2G_AP) {
+			wl_rinfo->link_mode = BTC_WLINK_NOLINK;
+			wl_rinfo->connect_cnt--;
+		}
+	}
+
+	/* Identify 2-Role type  */
+	if (wl_rinfo->connect_cnt >= 2 &&
+	    (wl_rinfo->link_mode == BTC_WLINK_2G_SCC ||
+	     wl_rinfo->link_mode == BTC_WLINK_2G_MCC ||
+	     wl_rinfo->link_mode == BTC_WLINK_25G_MCC ||
+	     wl_rinfo->link_mode == BTC_WLINK_5G)) {
+		if ((wl_role & BIT(RTW89_WIFI_ROLE_P2P_GO)) ||
+		    (wl_role & BIT(RTW89_WIFI_ROLE_AP)))
+			type = noa ? BTC_WLMROLE_STA_GO_NOA : BTC_WLMROLE_STA_GO;
+		else if (wl_role & BIT(RTW89_WIFI_ROLE_P2P_CLIENT))
+			type = noa ? BTC_WLMROLE_STA_GC_NOA : BTC_WLMROLE_STA_GC;
+		else
+			type = BTC_WLMROLE_STA_STA;
+
+		dur = noa;
+	}
+
+	wl_rinfo->mrole_type = type;
+	wl_rinfo->mrole_noa_duration = dur;
+}
+
+static void _update_wl_info_v8(struct rtw89_dev *rtwdev, u8 role_id, u8 rlink_id,
+			       enum btc_role_state state)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_chdef cid_ch[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER];
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
+	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
+	bool client_joined = false, b2g = false, b5g = false;
+	u8 cid_role[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
+	u8 cid_phy[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
+	u8 dbcc_en = 0, pta_req_band = RTW89_MAC_0;
+	u8 i, j, cnt = 0, cnt_2g = 0, cnt_5g = 0;
+	struct rtw89_btc_wl_link_info *wl_linfo;
+	struct rtw89_btc_wl_rlink *rlink = NULL;
+	u8 dbcc_2g_phy = RTW89_PHY_0;
+	u8 mode = BTC_WLINK_NOLINK;
+	u32 noa_dur = 0;
+
+	if (role_id >= RTW89_BE_BTC_WL_MAX_ROLE_NUMBER || rlink_id > RTW89_MAC_1)
+		return;
+
+	/* Extract wl->link_info[role_id][rlink_id] to wl->role_info
+	 * role_id: role index
+	 * rlink_id: rlink index (= HW-band index)
+	 * pid: port_index
+	 */
+
+	wl_linfo = &wl->rlink_info[role_id][rlink_id];
+	if (wl_linfo->connected == MLME_LINKING)
+		return;
+
+	rlink = &wl_rinfo->rlink[role_id][rlink_id];
+	rlink->role = wl_linfo->role;
+	rlink->active = wl_linfo->active; /* Doze or not */
+	rlink->pid = wl_linfo->pid;
+	rlink->phy = wl_linfo->phy;
+	rlink->rf_band = wl_linfo->band;
+	rlink->ch = wl_linfo->ch;
+	rlink->bw = wl_linfo->bw;
+	rlink->noa = wl_linfo->noa;
+	rlink->noa_dur = wl_linfo->noa_duration / 1000;
+	rlink->client_cnt = wl_linfo->client_cnt;
+	rlink->mode = wl_linfo->mode;
+
+	switch (wl_linfo->connected) {
+	case MLME_NO_LINK:
+		rlink->connected = 0;
+		if (rlink->role == RTW89_WIFI_ROLE_STATION)
+			btc->dm.leak_ap = 0;
+		break;
+	case MLME_LINKED:
+		rlink->connected = 1;
+		break;
+	default:
+		return;
+	}
+
+	wl->is_5g_hi_channel = false;
+	wl->bg_mode = false;
+	wl_rinfo->role_map = 0;
+	wl_rinfo->p2p_2g = 0;
+	memset(cid_ch, 0, sizeof(cid_ch));
+
+	for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
+		for (j = RTW89_MAC_0; j <= RTW89_MAC_1; j++) {
+			rlink = &wl_rinfo->rlink[i][j];
+
+			if (!rlink->active || !rlink->connected)
+				continue;
+
+			cnt++;
+			wl_rinfo->role_map |= BIT(rlink->role);
+
+			/* only if client connect for p2p-Go/AP */
+			if ((rlink->role == RTW89_WIFI_ROLE_P2P_GO ||
+			     rlink->role == RTW89_WIFI_ROLE_AP) &&
+			     rlink->client_cnt > 1)
+				client_joined = true;
+
+			/* Identufy if P2P-Go (GO/GC/AP) exist at 2G band*/
+			if (rlink->rf_band == RTW89_BAND_2G &&
+			    (client_joined || rlink->role == RTW89_WIFI_ROLE_P2P_CLIENT))
+				wl_rinfo->p2p_2g = 1;
+
+			/* only one noa-role exist */
+			if (rlink->noa && rlink->noa_dur > 0)
+				noa_dur = rlink->noa_dur;
+
+			/* for WL 5G-Rx interfered with BT issue */
+			if (rlink->rf_band == RTW89_BAND_5G && rlink->ch >= 100)
+				wl->is_5g_hi_channel = 1;
+
+			if ((rlink->mode & BIT(BTC_WL_MODE_11B)) ||
+			    (rlink->mode & BIT(BTC_WL_MODE_11G)))
+				wl->bg_mode = 1;
+
+			if (rtwdev->chip->para_ver & BTC_FEAT_MLO_SUPPORT)
+				continue;
+
+			cid_ch[cnt - 1] = wl_linfo->chdef;
+			cid_phy[cnt - 1] = rlink->phy;
+			cid_role[cnt - 1] = rlink->role;
+
+			if (rlink->rf_band != RTW89_BAND_2G) {
+				cnt_5g++;
+				b5g = true;
+			} else {
+				cnt_2g++;
+				b2g = true;
+			}
+		}
+	}
+
+	if (rtwdev->chip->para_ver & BTC_FEAT_MLO_SUPPORT) {
+		rtw89_warn(rtwdev, "not support MLO feature yet");
+	} else {
+		dbcc_en = rtwdev->dbcc_en;
+
+		/* Be careful to change the following sequence!! */
+		if (cnt == 0) {
+			mode = BTC_WLINK_NOLINK;
+		} else if (!b2g && b5g) {
+			mode = BTC_WLINK_5G;
+		} else if (wl_rinfo->role_map & BIT(RTW89_WIFI_ROLE_NAN)) {
+			mode = BTC_WLINK_2G_NAN;
+		} else if (cnt > BTC_TDMA_WLROLE_MAX) {
+			mode = BTC_WLINK_OTHER;
+		} else if (dbcc_en) {
+			mode = _chk_dbcc(rtwdev, cid_ch, cid_phy, cid_role,
+					 &dbcc_2g_phy);
+		} else if (b2g && b5g && cnt == 2) {
+			mode = BTC_WLINK_25G_MCC;
+		} else if (!b5g && cnt == 2) { /* cnt_connect = 2 */
+			if (_chk_role_ch_group(&cid_ch[0], &cid_ch[cnt - 1]))
+				mode = BTC_WLINK_2G_SCC;
+			else
+				mode = BTC_WLINK_2G_MCC;
+		} else if (!b5g && cnt == 1) { /* cnt_connect = 1 */
+			mode = _get_role_link_mode(cid_role[0]);
+		}
+	}
+
+	wl_rinfo->link_mode = mode;
+	wl_rinfo->connect_cnt = cnt;
+	if (wl_rinfo->connect_cnt == 0)
+		wl_rinfo->role_map = BIT(RTW89_WIFI_ROLE_NONE);
+	_update_role_link_mode(rtwdev, client_joined, noa_dur);
+
+	wl_rinfo->dbcc_2g_phy = dbcc_2g_phy;
+	if (wl_rinfo->dbcc_en != dbcc_en) {
+		wl_rinfo->dbcc_en = dbcc_en;
+		wl_rinfo->dbcc_chg = 1;
+		btc->cx.cnt_wl[BTC_WCNT_DBCC_CHG]++;
+	} else {
+		wl_rinfo->dbcc_chg = 0;
+	}
+
+	if (wl_rinfo->dbcc_en) {
+		memset(wl_dinfo, 0, sizeof(struct rtw89_btc_wl_dbcc_info));
+
+		if (mode == BTC_WLINK_5G) {
+			pta_req_band = RTW89_PHY_0;
+			wl_dinfo->op_band[RTW89_PHY_0] = RTW89_BAND_5G;
+			wl_dinfo->op_band[RTW89_PHY_1] = RTW89_BAND_2G;
+		} else if (wl_rinfo->dbcc_2g_phy == RTW89_PHY_1) {
+			pta_req_band = RTW89_PHY_1;
+			wl_dinfo->op_band[RTW89_PHY_0] = RTW89_BAND_5G;
+			wl_dinfo->op_band[RTW89_PHY_1] = RTW89_BAND_2G;
+		} else {
+			pta_req_band = RTW89_PHY_0;
+			wl_dinfo->op_band[RTW89_PHY_0] = RTW89_BAND_2G;
+			wl_dinfo->op_band[RTW89_PHY_1] = RTW89_BAND_5G;
+		}
+		_update_dbcc_band(rtwdev, RTW89_PHY_0);
+		_update_dbcc_band(rtwdev, RTW89_PHY_1);
+	}
+
+	wl_rinfo->pta_req_band = pta_req_band;
+	_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
+}
+
 void rtw89_coex_act1_work(struct work_struct *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
@@ -5445,6 +5805,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	u8 mode, igno_bt, always_freerun;
 
 	lockdep_assert_held(&rtwdev->mutex);
@@ -5459,6 +5820,8 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		mode = wl_rinfo_v1->link_mode;
 	else if (ver->fwlrole == 2)
 		mode = wl_rinfo_v2->link_mode;
+	else if (ver->fwlrole == 8)
+		mode = wl_rinfo_v8->link_mode;
 	else
 		return;
 
@@ -5605,6 +5968,8 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 			_action_wl_2g_scc_v1(rtwdev);
 		else if (ver->fwlrole == 2)
 			_action_wl_2g_scc_v2(rtwdev);
+		else if (ver->fwlrole == 8)
+			_action_wl_2g_scc_v8(rtwdev);
 		break;
 	case BTC_WLINK_2G_MCC:
 		bt->scan_rx_low_pri = true;
@@ -5956,6 +6321,22 @@ static u8 _update_bt_rssi_level(struct rtw89_dev *rtwdev, u8 rssi)
 	return rssi_level;
 }
 
+static void _update_zb_coex_tbl(struct rtw89_dev *rtwdev)
+{
+	u8 mode = rtwdev->btc.cx.wl.role_info.link_mode;
+	u32 zb_tbl0 = 0xda5a5a5a, zb_tbl1 = 0xda5a5a5a;
+
+	if (mode == BTC_WLINK_5G || rtwdev->btc.dm.freerun) {
+		zb_tbl0 = 0xffffffff;
+		zb_tbl1 = 0xffffffff;
+	} else if (mode == BTC_WLINK_25G_MCC) {
+		zb_tbl0 = 0xffffffff; /* for E5G slot */
+		zb_tbl1 = 0xda5a5a5a; /* for E2G slot */
+	}
+	rtw89_write32(rtwdev, R_BTC_ZB_COEX_TBL_0, zb_tbl0);
+	rtw89_write32(rtwdev, R_BTC_ZB_COEX_TBL_1, zb_tbl1);
+}
+
 #define BT_PROFILE_PROTOCOL_MASK GENMASK(7, 4)
 
 static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
@@ -6093,13 +6474,6 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	_run_coex(rtwdev, BTC_RSN_UPDATE_BT_INFO);
 }
 
-enum btc_wl_mode {
-	BTC_WL_MODE_HT = 0,
-	BTC_WL_MODE_VHT = 1,
-	BTC_WL_MODE_HE = 2,
-	BTC_WL_MODE_NUM,
-};
-
 void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			      struct rtw89_sta *rtwsta, enum btc_role_state state)
 {
@@ -6112,7 +6486,7 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_link_info r = {0};
 	struct rtw89_btc_wl_link_info *wlinfo = NULL;
-	u8 mode = 0;
+	u8 mode = 0, rlink_id, link_mode_ori, pta_req_mac_ori, wa_type;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], state=%d\n", state);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -6162,6 +6536,10 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 	r.band = chan->band_type;
 	r.ch = chan->channel;
 	r.bw = chan->band_width;
+	r.chdef.band = chan->band_type;
+	r.chdef.center_ch = chan->channel;
+	r.chdef.bw = chan->band_width;
+	r.chdef.chan = chan->primary_channel;
 	ether_addr_copy(r.mac_addr, rtwvif->mac_addr);
 
 	if (rtwsta && vif->type == NL80211_IFTYPE_STATION)
@@ -6171,13 +6549,37 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 
 	wlinfo = &wl->link_info[r.pid];
 
-	memcpy(wlinfo, &r, sizeof(*wlinfo));
-	if (ver->fwlrole == 0)
+	rlink_id = 0; /* to do */
+	if (ver->fwlrole == 0) {
+		*wlinfo = r;
 		_update_wl_info(rtwdev);
-	else if (ver->fwlrole == 1)
+	} else if (ver->fwlrole == 1) {
+		*wlinfo = r;
 		_update_wl_info_v1(rtwdev);
-	else if (ver->fwlrole == 2)
+	} else if (ver->fwlrole == 2) {
+		*wlinfo = r;
 		_update_wl_info_v2(rtwdev);
+	} else if (ver->fwlrole == 8) {
+		wlinfo = &wl->rlink_info[r.pid][rlink_id];
+		*wlinfo = r;
+		link_mode_ori = wl->role_info_v8.link_mode;
+		pta_req_mac_ori = wl->pta_req_mac;
+		_update_wl_info_v8(rtwdev, r.pid, rlink_id, state);
+
+		if (wl->role_info_v8.link_mode != link_mode_ori) {
+			wl->role_info_v8.link_mode_chg = 1;
+			if (ver->fcxinit == 7)
+				wa_type = btc->mdinfo.md_v7.wa_type;
+			else
+				wa_type = btc->mdinfo.md.wa_type;
+
+			if (wa_type & BTC_WA_HFP_ZB)
+				_update_zb_coex_tbl(rtwdev);
+		}
+
+		if (wl->pta_req_mac != pta_req_mac_ori)
+			wl->pta_reg_mac_chg = 1;
+	}
 
 	if (wlinfo->role == RTW89_WIFI_ROLE_STATION &&
 	    wlinfo->connected == MLME_NO_LINK)
@@ -6715,7 +7117,10 @@ static void _show_wl_role_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	}
 
 	for (i = 0; i < RTW89_PORT_NUM; i++) {
-		plink = &btc->cx.wl.link_info[i];
+		if (btc->ver->fwlrole == 8)
+			plink = &btc->cx.wl.rlink_info[i][0];
+		else
+			plink = &btc->cx.wl.link_info[i];
 
 		if (!plink->active)
 			continue;
@@ -6760,6 +7165,7 @@ static void _show_wl_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	u8 mode;
 
 	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_WL))
@@ -6773,6 +7179,8 @@ static void _show_wl_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		mode = wl_rinfo_v1->link_mode;
 	else if (ver->fwlrole == 2)
 		mode = wl_rinfo_v2->link_mode;
+	else if (ver->fwlrole == 8)
+		mode = wl_rinfo_v8->link_mode;
 	else
 		return;
 
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 13303830684e..32c95022d6ee 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -201,6 +201,25 @@ enum btc_3cx_type {
 	BTC_3CX_MAX,
 };
 
+enum btc_chip_feature {
+	BTC_FEAT_PTA_ONOFF_CTRL  = BIT(0), /* on/off ctrl by HW (not 0x73[2]) */
+	BTC_FEAT_NONBTG_GWL_THRU = BIT(1), /* non-BTG GNT_WL!=0 if GNT_BT = 1 */
+	BTC_FEAT_WLAN_ACT_MUX = BIT(2), /* separate wlan_act/gnt mux */
+	BTC_FEAT_NEW_BBAPI_FLOW = BIT(3), /* new btg_ctrl/pre_agc_ctrl */
+	BTC_FEAT_MLO_SUPPORT = BIT(4),
+	BTC_FEAT_H2C_MACRO = BIT(5),
+};
+
+enum btc_wl_mode {
+	BTC_WL_MODE_11B = 0,
+	BTC_WL_MODE_11A = 1,
+	BTC_WL_MODE_11G = 2,
+	BTC_WL_MODE_HT = 3,
+	BTC_WL_MODE_VHT = 4,
+	BTC_WL_MODE_HE = 5,
+	BTC_WL_MODE_NUM,
+};
+
 void rtw89_btc_ntfy_poweron(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_poweroff(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2e854c9af709..8617c65ff60e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -799,6 +799,7 @@ struct rtw89_rx_phy_ppdu {
 enum rtw89_mac_idx {
 	RTW89_MAC_0 = 0,
 	RTW89_MAC_1 = 1,
+	RTW89_MAC_NUM,
 };
 
 enum rtw89_phy_idx {
@@ -1230,6 +1231,13 @@ enum rtw89_btc_wl_state_cnt {
 	BTC_WCNT_RFK_REJECT,
 	BTC_WCNT_RFK_TIMEOUT,
 	BTC_WCNT_CH_UPDATE,
+	BTC_WCNT_DBCC_ALL_2G,
+	BTC_WCNT_DBCC_CHG,
+	BTC_WCNT_RX_OK_LAST,
+	BTC_WCNT_RX_OK_LAST2S,
+	BTC_WCNT_RX_ERR_LAST,
+	BTC_WCNT_RX_ERR_LAST2S,
+	BTC_WCNT_RX_LAST,
 	BTC_WCNT_NUM
 };
 
@@ -1349,6 +1357,14 @@ struct rtw89_traffic_stats {
 	u16 rx_rate;
 };
 
+struct rtw89_btc_chdef {
+	u8 center_ch;
+	u8 band;
+	u8 chan;
+	enum rtw89_sc_offset offset;
+	enum rtw89_bandwidth bw;
+};
+
 struct rtw89_btc_statistic {
 	u8 rssi; /* 0%~110% (dBm = rssi -110) */
 	struct rtw89_traffic_stats traffic;
@@ -1357,6 +1373,7 @@ struct rtw89_btc_statistic {
 #define BTC_WL_RSSI_THMAX 4
 
 struct rtw89_btc_wl_link_info {
+	struct rtw89_btc_chdef chdef;
 	struct rtw89_btc_statistic stat;
 	enum rtw89_tfc_dir dir;
 	u8 rssi_state[BTC_WL_RSSI_THMAX];
@@ -1370,6 +1387,7 @@ struct rtw89_btc_wl_link_info {
 	u8 phy;
 	u8 dtim_period;
 	u8 mode;
+	u8 tx_1ss_limit;
 
 	u8 mac_id;
 	u8 tx_retry;
@@ -1379,6 +1397,7 @@ struct rtw89_btc_wl_link_info {
 	u32 tx_time;
 	u32 client_cnt;
 	u32 rx_rate_drop_cnt;
+	u32 noa_duration;
 
 	u32 active: 1;
 	u32 noa: 1;
@@ -1589,6 +1608,42 @@ struct rtw89_btc_wl_role_info_v2 { /* struct size must be n*4 bytes */
 	u32 rsvd: 27;
 };
 
+struct rtw89_btc_wl_rlink { /* H2C info, struct size must be n*4 bytes */
+	u8 connected;
+	u8 pid;
+	u8 phy;
+	u8 noa;
+
+	u8 rf_band; /* enum band_type RF band: 2.4G/5G/6G */
+	u8 active; /* 0:rlink is under doze */
+	u8 bw; /* enum channel_width */
+	u8 role; /*enum role_type */
+
+	u8 ch;
+	u8 noa_dur; /* ms */
+	u8 client_cnt; /* for Role = P2P-Go/AP */
+	u8 mode; /* wifi protocol */
+} __packed;
+
+#define RTW89_BE_BTC_WL_MAX_ROLE_NUMBER 6
+struct rtw89_btc_wl_role_info_v8 { /* H2C info, struct size must be n*4 bytes */
+	u8 connect_cnt;
+	u8 link_mode;
+	u8 link_mode_chg;
+	u8 p2p_2g;
+
+	u8 pta_req_band;
+	u8 dbcc_en; /* 1+1 and 2.4G-included */
+	u8 dbcc_chg;
+	u8 dbcc_2g_phy; /* which phy operate in 2G, HW_PHY_0 or HW_PHY_1 */
+
+	struct rtw89_btc_wl_rlink rlink[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER][RTW89_MAC_NUM];
+
+	u32 role_map;
+	u32 mrole_type; /* btc_wl_mrole_type */
+	u32 mrole_noa_duration; /* ms */
+} __packed;
+
 struct rtw89_btc_wl_ver_info {
 	u32 fw_coex; /* match with which coex_ver */
 	u32 fw;
@@ -1724,12 +1779,14 @@ struct rtw89_btc_wl_nhm {
 
 struct rtw89_btc_wl_info {
 	struct rtw89_btc_wl_link_info link_info[RTW89_PORT_NUM];
+	struct rtw89_btc_wl_link_info rlink_info[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER][RTW89_MAC_NUM];
 	struct rtw89_btc_wl_rfk_info rfk_info;
 	struct rtw89_btc_wl_ver_info  ver_info;
 	struct rtw89_btc_wl_afh_info afh_info;
 	struct rtw89_btc_wl_role_info role_info;
 	struct rtw89_btc_wl_role_info_v1 role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 role_info_v2;
+	struct rtw89_btc_wl_role_info_v8 role_info_v8;
 	struct rtw89_btc_wl_scan_info scan_info;
 	struct rtw89_btc_wl_dbcc_info dbcc_info;
 	struct rtw89_btc_rf_para rf_para;
@@ -1740,7 +1797,10 @@ struct rtw89_btc_wl_info {
 	u8 rssi_level;
 	u8 cn_report;
 	u8 coex_mode;
+	u8 pta_req_mac;
 
+	bool is_5g_hi_channel;
+	bool pta_reg_mac_chg;
 	bool bg_mode;
 	bool scbd_change;
 	u32 scbd;
@@ -2569,6 +2629,8 @@ struct rtw89_btc_dm {
 
 	u32 update_slot_map;
 	u32 set_ant_path;
+	u32 e2g_slot_limit;
+	u32 e2g_slot_nulltx_time;
 
 	u32 wl_only: 1;
 	u32 wl_fw_cx_offload: 1;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 185cd339c085..f27486d35cbc 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4120,6 +4120,48 @@ int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev, u8 type)
 	return ret;
 }
 
+int rtw89_fw_h2c_cxdrv_role_v8(struct rtw89_dev *rtwdev, u8 type)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_role_info_v8 *role = &btc->cx.wl.role_info_v8;
+	struct rtw89_h2c_cxrole_v8 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_ctrl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxrole_v8 *)skb->data;
+
+	h2c->hdr.type = type;
+	h2c->hdr.len = len - H2C_LEN_CXDRVHDR_V7;
+	memcpy(&h2c->_u8, role, sizeof(h2c->_u8));
+	h2c->_u32.role_map = cpu_to_le32(role->role_map);
+	h2c->_u32.mrole_type = cpu_to_le32(role->mrole_type);
+	h2c->_u32.mrole_noa_duration = cpu_to_le32(role->mrole_noa_duration);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, BTFC_SET,
+			      SET_DRV_INFO, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 #define H2C_LEN_CXDRVINFO_CTRL (4 + H2C_LEN_CXDRVHDR)
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 44311f65b4fa..d7666c3d6a89 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2395,6 +2395,32 @@ struct rtw89_h2c_cxctrl_v7 {
 #define H2C_LEN_CXDRVHDR sizeof(struct rtw89_h2c_cxhdr)
 #define H2C_LEN_CXDRVHDR_V7 sizeof(struct rtw89_h2c_cxhdr_v7)
 
+struct rtw89_btc_wl_role_info_v8_u8 {
+	u8 connect_cnt;
+	u8 link_mode;
+	u8 link_mode_chg;
+	u8 p2p_2g;
+
+	u8 pta_req_band;
+	u8 dbcc_en;
+	u8 dbcc_chg;
+	u8 dbcc_2g_phy;
+
+	struct rtw89_btc_wl_rlink rlink[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER][RTW89_MAC_NUM];
+} __packed;
+
+struct rtw89_btc_wl_role_info_v8_u32 {
+	__le32 role_map;
+	__le32 mrole_type;
+	__le32 mrole_noa_duration;
+} __packed;
+
+struct rtw89_h2c_cxrole_v8 {
+	struct rtw89_h2c_cxhdr hdr;
+	struct rtw89_btc_wl_role_info_v8_u8 _u8;
+	struct rtw89_btc_wl_role_info_v8_u32 _u32;
+} __packed;
+
 struct rtw89_h2c_cxinit {
 	struct rtw89_h2c_cxhdr hdr;
 	u8 ant_type;
@@ -4568,6 +4594,7 @@ int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_role_v8(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev, u8 type);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 367459bd1345..948eeb6755fd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2436,6 +2436,11 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.efuse_blocks		= rtw8922a_efuse_blocks,
 	.phycap_addr		= 0x1700,
 	.phycap_size		= 0x38,
+	.para_ver		= 0xf,
+	.wlcx_desired		= 0x07110000,
+	.btcx_desired		= 0x7,
+	.scbd			= 0x1,
+	.mailbox		= 0x1,
 
 	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
 				  BIT(RTW89_PS_MODE_CLK_GATED) |
-- 
2.25.1


