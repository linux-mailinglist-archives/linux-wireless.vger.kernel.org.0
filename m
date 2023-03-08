Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2236AFE6D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 06:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCHFdw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 00:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCHFdv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 00:33:51 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF828DCEA
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 21:33:46 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3285XU4T0016699, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3285XU4T0016699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 8 Mar 2023 13:33:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 8 Mar 2023 13:33:28 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 8 Mar 2023
 13:33:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: coex: Add WiFi role info v2
Date:   Wed, 8 Mar 2023 13:32:20 +0800
Message-ID: <20230308053225.24377-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308053225.24377-1-pkshih@realtek.com>
References: <20230308053225.24377-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Remove WiFi traffic busy level & traffic rate from active role information.
This information will move to v5 version TDMA cycle info.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 277 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  32 +++
 drivers/net/wireless/realtek/rtw89/fw.c   |  86 +++++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  51 ++++
 4 files changed, 439 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index f80952e6e11ba..b56897529504a 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1819,6 +1819,8 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 			rtw89_fw_h2c_cxdrv_role(rtwdev);
 		else if (ver->fwlrole == 1)
 			rtw89_fw_h2c_cxdrv_role_v1(rtwdev);
+		else if (ver->fwlrole == 2)
+			rtw89_fw_h2c_cxdrv_role_v2(rtwdev);
 		break;
 	case CXDRVINFO_CTRL:
 		rtw89_fw_h2c_cxdrv_ctrl(rtwdev);
@@ -2113,8 +2115,10 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_bt_link_info *b = &bt->link_info;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
+	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
 	struct rtw89_btc_wl_active_role *r;
 	struct rtw89_btc_wl_active_role_v1 *r1;
+	struct rtw89_btc_wl_active_role_v2 *r2;
 	u8 en = 0, i, ch = 0, bw = 0;
 	u8 mode, connect_cnt;
 
@@ -2124,9 +2128,14 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 	if (ver->fwlrole == 0) {
 		mode = wl_rinfo->link_mode;
 		connect_cnt = wl_rinfo->connect_cnt;
-	} else {
+	} else if (ver->fwlrole == 1) {
 		mode = wl_rinfo_v1->link_mode;
 		connect_cnt = wl_rinfo_v1->connect_cnt;
+	} else if (ver->fwlrole == 2) {
+		mode = wl_rinfo_v2->link_mode;
+		connect_cnt = wl_rinfo_v2->connect_cnt;
+	} else {
+		return;
 	}
 
 	if (wl->status.map.rf_off || bt->whql_test ||
@@ -2139,6 +2148,7 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 		for (i = 0; i < RTW89_PORT_NUM; i++) {
 			r = &wl_rinfo->active_role[i];
 			r1 = &wl_rinfo_v1->active_role_v1[i];
+			r2 = &wl_rinfo_v2->active_role_v2[i];
 
 			if (ver->fwlrole == 0 &&
 			    (r->role == RTW89_WIFI_ROLE_P2P_GO ||
@@ -2152,6 +2162,12 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 				ch = r1->ch;
 				bw = r1->bw;
 				break;
+			} else if (ver->fwlrole == 2 &&
+				   (r2->role == RTW89_WIFI_ROLE_P2P_GO ||
+				    r2->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
+				ch = r2->ch;
+				bw = r2->bw;
+				break;
 			}
 		}
 	} else {
@@ -2160,6 +2176,7 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 		for (i = 0; i < RTW89_PORT_NUM; i++) {
 			r = &wl_rinfo->active_role[i];
 			r1 = &wl_rinfo_v1->active_role_v1[i];
+			r2 = &wl_rinfo_v2->active_role_v2[i];
 
 			if (ver->fwlrole == 0 &&
 			    r->connected && r->band == RTW89_BAND_2G) {
@@ -2171,6 +2188,11 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 				ch = r1->ch;
 				bw = r1->bw;
 				break;
+			} else if (ver->fwlrole == 2 &&
+				   r2->connected && r2->band == RTW89_BAND_2G) {
+				ch = r2->ch;
+				bw = r2->bw;
+				break;
 			}
 		}
 	}
@@ -3625,6 +3647,7 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
+	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 	bool is_btg;
 	u8 mode;
@@ -3634,8 +3657,12 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 
 	if (ver->fwlrole == 0)
 		mode = wl_rinfo->link_mode;
-	else
+	else if (ver->fwlrole == 1)
 		mode = wl_rinfo_v1->link_mode;
+	else if (ver->fwlrole == 2)
+		mode = wl_rinfo_v2->link_mode;
+	else
+		return;
 
 	/* notify halbb ignore GNT_BT or not for WL BB Rx-AGC control */
 	if (mode == BTC_WLINK_5G) /* always 0 if 5G */
@@ -3736,6 +3763,7 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_bt_hid_desc *hid = &b->hid_desc;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
+	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
 	struct rtw89_txtime_data data = {.rtwdev = rtwdev};
 	u8 mode;
 	u8 tx_retry;
@@ -3748,8 +3776,12 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 
 	if (ver->fwlrole == 0)
 		mode = wl_rinfo->link_mode;
-	else
+	else if (ver->fwlrole == 1)
 		mode = wl_rinfo_v1->link_mode;
+	else if (ver->fwlrole == 2)
+		mode = wl_rinfo_v2->link_mode;
+	else
+		return;
 
 	if (btc->dm.freerun || btc->ctrl.igno_bt || b->profile_cnt.now == 0 ||
 	    mode == BTC_WLINK_5G || mode == BTC_WLINK_NOLINK) {
@@ -3799,14 +3831,19 @@ static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
+	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	bool bt_hi_lna_rx = false;
 	u8 mode;
 
 	if (ver->fwlrole == 0)
 		mode = wl_rinfo->link_mode;
-	else
+	else if (ver->fwlrole == 1)
 		mode = wl_rinfo_v1->link_mode;
+	else if (ver->fwlrole == 2)
+		mode = wl_rinfo_v2->link_mode;
+	else
+		return;
 
 	if (mode != BTC_WLINK_NOLINK && btc->dm.wl_btg_rx)
 		bt_hi_lna_rx = true;
@@ -4079,6 +4116,68 @@ static void _action_wl_2g_scc_v1(struct rtw89_dev *rtwdev)
 	_set_policy(rtwdev, policy_type, BTC_ACT_WL_2G_SCC);
 }
 
+static void _action_wl_2g_scc_v2(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_wl_role_info_v2 *wl_rinfo = &wl->role_info_v2;
+	u16 policy_type = BTC_CXP_OFF_BT;
+	u32 dur;
+
+	if (btc->mdinfo.ant.type == BTC_ANT_DEDICATED) {
+		policy_type = BTC_CXP_OFF_EQ0;
+	} else {
+		/* shared-antenna */
+		switch (wl_rinfo->mrole_type) {
+		case BTC_WLMROLE_STA_GC:
+			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
+			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_P2P_CLIENT;
+			dm->wl_scc.ebt_null = 0; /* no ext-slot-control */
+			_action_by_bt(rtwdev);
+			return;
+		case BTC_WLMROLE_STA_STA:
+			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
+			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_STATION;
+			dm->wl_scc.ebt_null = 0; /* no ext-slot-control */
+			_action_by_bt(rtwdev);
+			return;
+		case BTC_WLMROLE_STA_GC_NOA:
+		case BTC_WLMROLE_STA_GO:
+		case BTC_WLMROLE_STA_GO_NOA:
+			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
+			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_NONE;
+			dur = wl_rinfo->mrole_noa_duration;
+
+			if (wl->status.map._4way) {
+				dm->wl_scc.ebt_null = 0;
+				policy_type = BTC_CXP_OFFE_WL;
+			} else if (bt->link_info.status.map.connect == 0) {
+				dm->wl_scc.ebt_null = 0;
+				policy_type = BTC_CXP_OFFE_2GISOB;
+			} else if (bt->link_info.a2dp_desc.exist &&
+				   dur < btc->bt_req_len) {
+				dm->wl_scc.ebt_null = 1; /* tx null at EBT */
+				policy_type = BTC_CXP_OFFE_2GBWMIXB2;
+			} else if (bt->link_info.a2dp_desc.exist ||
+				   bt->link_info.pan_desc.exist) {
+				dm->wl_scc.ebt_null = 1; /* tx null at EBT */
+				policy_type = BTC_CXP_OFFE_2GBWISOB;
+			} else {
+				dm->wl_scc.ebt_null = 0;
+				policy_type = BTC_CXP_OFFE_2GBWISOB;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
+	_set_policy(rtwdev, policy_type, BTC_ACT_WL_2G_SCC);
+}
+
 static void _action_wl_2g_ap(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -4518,6 +4617,156 @@ static void _update_wl_info_v1(struct rtw89_dev *rtwdev)
 	_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
 }
 
+static void _update_wl_info_v2(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_link_info *wl_linfo = wl->link_info;
+	struct rtw89_btc_wl_role_info_v2 *wl_rinfo = &wl->role_info_v2;
+	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
+	u8 cnt_connect = 0, cnt_connecting = 0, cnt_active = 0;
+	u8 cnt_2g = 0, cnt_5g = 0, phy;
+	u32 wl_2g_ch[2] = {}, wl_5g_ch[2] = {};
+	bool b2g = false, b5g = false, client_joined = false;
+	u8 i;
+
+	memset(wl_rinfo, 0, sizeof(*wl_rinfo));
+
+	for (i = 0; i < RTW89_PORT_NUM; i++) {
+		if (!wl_linfo[i].active)
+			continue;
+
+		cnt_active++;
+		wl_rinfo->active_role_v2[cnt_active - 1].role = wl_linfo[i].role;
+		wl_rinfo->active_role_v2[cnt_active - 1].pid = wl_linfo[i].pid;
+		wl_rinfo->active_role_v2[cnt_active - 1].phy = wl_linfo[i].phy;
+		wl_rinfo->active_role_v2[cnt_active - 1].band = wl_linfo[i].band;
+		wl_rinfo->active_role_v2[cnt_active - 1].noa = (u8)wl_linfo[i].noa;
+		wl_rinfo->active_role_v2[cnt_active - 1].connected = 0;
+
+		wl->port_id[wl_linfo[i].role] = wl_linfo[i].pid;
+
+		phy = wl_linfo[i].phy;
+
+		if (rtwdev->dbcc_en && phy < RTW89_PHY_MAX) {
+			wl_dinfo->role[phy] = wl_linfo[i].role;
+			wl_dinfo->op_band[phy] = wl_linfo[i].band;
+			_update_dbcc_band(rtwdev, phy);
+			_fw_set_drv_info(rtwdev, CXDRVINFO_DBCC);
+		}
+
+		if (wl_linfo[i].connected == MLME_NO_LINK) {
+			continue;
+		} else if (wl_linfo[i].connected == MLME_LINKING) {
+			cnt_connecting++;
+		} else {
+			cnt_connect++;
+			if ((wl_linfo[i].role == RTW89_WIFI_ROLE_P2P_GO ||
+			     wl_linfo[i].role == RTW89_WIFI_ROLE_AP) &&
+			     wl_linfo[i].client_cnt > 1)
+				client_joined = true;
+		}
+
+		wl_rinfo->role_map.val |= BIT(wl_linfo[i].role);
+		wl_rinfo->active_role_v2[cnt_active - 1].ch = wl_linfo[i].ch;
+		wl_rinfo->active_role_v2[cnt_active - 1].bw = wl_linfo[i].bw;
+		wl_rinfo->active_role_v2[cnt_active - 1].connected = 1;
+
+		/* only care 2 roles + BT coex */
+		if (wl_linfo[i].band != RTW89_BAND_2G) {
+			if (cnt_5g <= ARRAY_SIZE(wl_5g_ch) - 1)
+				wl_5g_ch[cnt_5g] = wl_linfo[i].ch;
+			cnt_5g++;
+			b5g = true;
+		} else {
+			if (cnt_2g <= ARRAY_SIZE(wl_2g_ch) - 1)
+				wl_2g_ch[cnt_2g] = wl_linfo[i].ch;
+			cnt_2g++;
+			b2g = true;
+		}
+	}
+
+	wl_rinfo->connect_cnt = cnt_connect;
+
+	/* Be careful to change the following sequence!! */
+	if (cnt_connect == 0) {
+		wl_rinfo->link_mode = BTC_WLINK_NOLINK;
+		wl_rinfo->role_map.role.none = 1;
+	} else if (!b2g && b5g) {
+		wl_rinfo->link_mode = BTC_WLINK_5G;
+	} else if (wl_rinfo->role_map.role.nan) {
+		wl_rinfo->link_mode = BTC_WLINK_2G_NAN;
+	} else if (cnt_connect > BTC_TDMA_WLROLE_MAX) {
+		wl_rinfo->link_mode = BTC_WLINK_OTHER;
+	} else  if (b2g && b5g && cnt_connect == 2) {
+		if (rtwdev->dbcc_en) {
+			switch (wl_dinfo->role[RTW89_PHY_0]) {
+			case RTW89_WIFI_ROLE_STATION:
+				wl_rinfo->link_mode = BTC_WLINK_2G_STA;
+				break;
+			case RTW89_WIFI_ROLE_P2P_GO:
+				wl_rinfo->link_mode = BTC_WLINK_2G_GO;
+				break;
+			case RTW89_WIFI_ROLE_P2P_CLIENT:
+				wl_rinfo->link_mode = BTC_WLINK_2G_GC;
+				break;
+			case RTW89_WIFI_ROLE_AP:
+				wl_rinfo->link_mode = BTC_WLINK_2G_AP;
+				break;
+			default:
+				wl_rinfo->link_mode = BTC_WLINK_OTHER;
+				break;
+			}
+		} else {
+			wl_rinfo->link_mode = BTC_WLINK_25G_MCC;
+		}
+	} else if (!b5g && cnt_connect == 2) {
+		if (wl_rinfo->role_map.role.station &&
+		    (wl_rinfo->role_map.role.p2p_go ||
+		    wl_rinfo->role_map.role.p2p_gc ||
+		    wl_rinfo->role_map.role.ap)) {
+			if (wl_2g_ch[0] == wl_2g_ch[1])
+				wl_rinfo->link_mode = BTC_WLINK_2G_SCC;
+			else
+				wl_rinfo->link_mode = BTC_WLINK_2G_MCC;
+		} else {
+			wl_rinfo->link_mode = BTC_WLINK_2G_MCC;
+		}
+	} else if (!b5g && cnt_connect == 1) {
+		if (wl_rinfo->role_map.role.station)
+			wl_rinfo->link_mode = BTC_WLINK_2G_STA;
+		else if (wl_rinfo->role_map.role.ap)
+			wl_rinfo->link_mode = BTC_WLINK_2G_AP;
+		else if (wl_rinfo->role_map.role.p2p_go)
+			wl_rinfo->link_mode = BTC_WLINK_2G_GO;
+		else if (wl_rinfo->role_map.role.p2p_gc)
+			wl_rinfo->link_mode = BTC_WLINK_2G_GC;
+		else
+			wl_rinfo->link_mode = BTC_WLINK_OTHER;
+	}
+
+	/* if no client_joined, don't care P2P-GO/AP role */
+	if (wl_rinfo->role_map.role.p2p_go || wl_rinfo->role_map.role.ap) {
+		if (!client_joined) {
+			if (wl_rinfo->link_mode == BTC_WLINK_2G_SCC ||
+			    wl_rinfo->link_mode == BTC_WLINK_2G_MCC) {
+				wl_rinfo->link_mode = BTC_WLINK_2G_STA;
+				wl_rinfo->connect_cnt = 1;
+			} else if (wl_rinfo->link_mode == BTC_WLINK_2G_GO ||
+				 wl_rinfo->link_mode == BTC_WLINK_2G_AP) {
+				wl_rinfo->link_mode = BTC_WLINK_NOLINK;
+				wl_rinfo->connect_cnt = 0;
+			}
+		}
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_BTC,
+		    "[BTC], cnt_connect = %d, connecting = %d, link_mode = %d\n",
+		    cnt_connect, cnt_connecting, wl_rinfo->link_mode);
+
+	_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
+}
+
 #define BTC_CHK_HANG_MAX 3
 #define BTC_SCB_INV_VALUE GENMASK(31, 0)
 
@@ -4676,6 +4925,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
+	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
 	u8 mode;
 
 	lockdep_assert_held(&rtwdev->mutex);
@@ -4686,8 +4936,12 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 
 	if (ver->fwlrole == 0)
 		mode = wl_rinfo->link_mode;
-	else
+	else if (ver->fwlrole == 1)
 		mode = wl_rinfo_v1->link_mode;
+	else if (ver->fwlrole == 2)
+		mode = wl_rinfo_v2->link_mode;
+	else
+		return;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): reason=%d, mode=%d\n",
 		    __func__, reason, mode);
@@ -4812,6 +5066,8 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 			_action_wl_2g_scc(rtwdev);
 		else if (ver->fwlrole == 1)
 			_action_wl_2g_scc_v1(rtwdev);
+		else if (ver->fwlrole == 2)
+			_action_wl_2g_scc_v2(rtwdev);
 		break;
 	case BTC_WLINK_2G_MCC:
 		bt->scan_rx_low_pri = true;
@@ -5317,8 +5573,10 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 	memcpy(wlinfo, &r, sizeof(*wlinfo));
 	if (ver->fwlrole == 0)
 		_update_wl_info(rtwdev);
-	else
+	else if (ver->fwlrole == 1)
 		_update_wl_info_v1(rtwdev);
+	else if (ver->fwlrole == 2)
+		_update_wl_info_v2(rtwdev);
 
 	if (wlinfo->role == RTW89_WIFI_ROLE_STATION &&
 	    wlinfo->connected == MLME_NO_LINK)
@@ -5838,6 +6096,7 @@ static void _show_wl_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
+	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
 	u8 mode;
 
 	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_WL))
@@ -5847,8 +6106,12 @@ static void _show_wl_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 	if (ver->fwlrole == 0)
 		mode = wl_rinfo->link_mode;
-	else
+	else if (ver->fwlrole == 1)
 		mode = wl_rinfo_v1->link_mode;
+	else if (ver->fwlrole == 2)
+		mode = wl_rinfo_v2->link_mode;
+	else
+		return;
 
 	seq_printf(m, " %-15s : link_mode:%d, ", "[status]", mode);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 77e3c5c283c1f..62c2e0a63a9ba 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1180,6 +1180,22 @@ struct rtw89_btc_wl_active_role_v1 {
 	u32 noa_duration; /* ms */
 };
 
+struct rtw89_btc_wl_active_role_v2 {
+	u8 connected: 1;
+	u8 pid: 3;
+	u8 phy: 1;
+	u8 noa: 1;
+	u8 band: 2;
+
+	u8 client_ps: 1;
+	u8 bw: 7;
+
+	u8 role;
+	u8 ch;
+
+	u32 noa_duration; /* ms */
+};
+
 struct rtw89_btc_wl_role_info_bpos {
 	u16 none: 1;
 	u16 station: 1;
@@ -1228,6 +1244,21 @@ struct rtw89_btc_wl_role_info_v1 { /* struct size must be n*4 bytes */
 	u32 rsvd: 27;
 };
 
+struct rtw89_btc_wl_role_info_v2 { /* struct size must be n*4 bytes */
+	u8 connect_cnt;
+	u8 link_mode;
+	union rtw89_btc_wl_role_info_map role_map;
+	struct rtw89_btc_wl_active_role_v2 active_role_v2[RTW89_PORT_NUM];
+	u32 mrole_type; /* btc_wl_mrole_type */
+	u32 mrole_noa_duration; /* ms */
+
+	u32 dbcc_en: 1;
+	u32 dbcc_chg: 1;
+	u32 dbcc_2g_phy: 2; /* which phy operate in 2G, HW_PHY_0 or HW_PHY_1 */
+	u32 link_mode_chg: 1;
+	u32 rsvd: 27;
+};
+
 struct rtw89_btc_wl_ver_info {
 	u32 fw_coex; /* match with which coex_ver */
 	u32 fw;
@@ -1343,6 +1374,7 @@ struct rtw89_btc_wl_info {
 	struct rtw89_btc_wl_afh_info afh_info;
 	struct rtw89_btc_wl_role_info role_info;
 	struct rtw89_btc_wl_role_info_v1 role_info_v1;
+	struct rtw89_btc_wl_role_info_v2 role_info_v2;
 	struct rtw89_btc_wl_scan_info scan_info;
 	struct rtw89_btc_wl_dbcc_info dbcc_info;
 	struct rtw89_btc_rf_para rf_para;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 1a4ff24078fb9..46d9cda2c617c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2038,6 +2038,92 @@ int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
+#define H2C_LEN_CXDRVINFO_ROLE_SIZE_V2(max_role_num) \
+	(4 + 8 * (max_role_num) + H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN + H2C_LEN_CXDRVHDR)
+
+int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_role_info_v2 *role_info = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_bpos *bpos = &role_info->role_map.role;
+	struct rtw89_btc_wl_active_role_v2 *active = role_info->active_role_v2;
+	struct sk_buff *skb;
+	u32 len;
+	u8 *cmd, offset;
+	int ret;
+	int i;
+
+	len = H2C_LEN_CXDRVINFO_ROLE_SIZE_V2(ver->max_role_num);
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_role\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	cmd = skb->data;
+
+	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, CXDRVINFO_ROLE);
+	RTW89_SET_FWCMD_CXHDR_LEN(cmd, len - H2C_LEN_CXDRVHDR);
+
+	RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, role_info->connect_cnt);
+	RTW89_SET_FWCMD_CXROLE_LINK_MODE(cmd, role_info->link_mode);
+
+	RTW89_SET_FWCMD_CXROLE_ROLE_NONE(cmd, bpos->none);
+	RTW89_SET_FWCMD_CXROLE_ROLE_STA(cmd, bpos->station);
+	RTW89_SET_FWCMD_CXROLE_ROLE_AP(cmd, bpos->ap);
+	RTW89_SET_FWCMD_CXROLE_ROLE_VAP(cmd, bpos->vap);
+	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC(cmd, bpos->adhoc);
+	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC_MASTER(cmd, bpos->adhoc_master);
+	RTW89_SET_FWCMD_CXROLE_ROLE_MESH(cmd, bpos->mesh);
+	RTW89_SET_FWCMD_CXROLE_ROLE_MONITOR(cmd, bpos->moniter);
+	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_DEV(cmd, bpos->p2p_device);
+	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GC(cmd, bpos->p2p_gc);
+	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GO(cmd, bpos->p2p_go);
+	RTW89_SET_FWCMD_CXROLE_ROLE_NAN(cmd, bpos->nan);
+
+	offset = PORT_DATA_OFFSET;
+	for (i = 0; i < RTW89_PORT_NUM; i++, active++) {
+		RTW89_SET_FWCMD_CXROLE_ACT_CONNECTED_V2(cmd, active->connected, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_PID_V2(cmd, active->pid, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_PHY_V2(cmd, active->phy, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_NOA_V2(cmd, active->noa, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_BAND_V2(cmd, active->band, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_CLIENT_PS_V2(cmd, active->client_ps, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_BW_V2(cmd, active->bw, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_ROLE_V2(cmd, active->role, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_CH_V2(cmd, active->ch, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_NOA_DUR_V2(cmd, active->noa_duration, i, offset);
+	}
+
+	offset = len - H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN;
+	RTW89_SET_FWCMD_CXROLE_MROLE_TYPE(cmd, role_info->mrole_type, offset);
+	RTW89_SET_FWCMD_CXROLE_MROLE_NOA(cmd, role_info->mrole_noa_duration, offset);
+	RTW89_SET_FWCMD_CXROLE_DBCC_EN(cmd, role_info->dbcc_en, offset);
+	RTW89_SET_FWCMD_CXROLE_DBCC_CHG(cmd, role_info->dbcc_chg, offset);
+	RTW89_SET_FWCMD_CXROLE_DBCC_2G_PHY(cmd, role_info->dbcc_2g_phy, offset);
+	RTW89_SET_FWCMD_CXROLE_LINK_MODE_CHG(cmd, role_info->link_mode_chg, offset);
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
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 3f6e0871381df..fa9e786ad7c9a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2393,6 +2393,56 @@ static inline void RTW89_SET_FWCMD_CXROLE_ACT_NOA_DUR(void *cmd, u32 val, int n,
 	le32p_replace_bits((__le32 *)((u8 *)cmd + (20 + (12 + offset) * n)), val, GENMASK(31, 0));
 }
 
+static inline void RTW89_SET_FWCMD_CXROLE_ACT_CONNECTED_V2(void *cmd, u8 val, int n, u8 offset)
+{
+	u8p_replace_bits((u8 *)cmd + (6 + (12 + offset) * n), val, BIT(0));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ACT_PID_V2(void *cmd, u8 val, int n, u8 offset)
+{
+	u8p_replace_bits((u8 *)cmd + (6 + (12 + offset) * n), val, GENMASK(3, 1));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ACT_PHY_V2(void *cmd, u8 val, int n, u8 offset)
+{
+	u8p_replace_bits((u8 *)cmd + (6 + (12 + offset) * n), val, BIT(4));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ACT_NOA_V2(void *cmd, u8 val, int n, u8 offset)
+{
+	u8p_replace_bits((u8 *)cmd + (6 + (12 + offset) * n), val, BIT(5));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ACT_BAND_V2(void *cmd, u8 val, int n, u8 offset)
+{
+	u8p_replace_bits((u8 *)cmd + (6 + (12 + offset) * n), val, GENMASK(7, 6));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ACT_CLIENT_PS_V2(void *cmd, u8 val, int n, u8 offset)
+{
+	u8p_replace_bits((u8 *)cmd + (7 + (12 + offset) * n), val, BIT(0));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ACT_BW_V2(void *cmd, u8 val, int n, u8 offset)
+{
+	u8p_replace_bits((u8 *)cmd + (7 + (12 + offset) * n), val, GENMASK(7, 1));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ACT_ROLE_V2(void *cmd, u8 val, int n, u8 offset)
+{
+	u8p_replace_bits((u8 *)cmd + (8 + (12 + offset) * n), val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ACT_CH_V2(void *cmd, u8 val, int n, u8 offset)
+{
+	u8p_replace_bits((u8 *)cmd + (9 + (12 + offset) * n), val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ACT_NOA_DUR_V2(void *cmd, u32 val, int n, u8 offset)
+{
+	le32p_replace_bits((__le32 *)((u8 *)cmd + (10 + (12 + offset) * n)), val, GENMASK(31, 0));
+}
+
 static inline void RTW89_SET_FWCMD_CXROLE_MROLE_TYPE(void *cmd, u32 val, u8 offset)
 {
 	le32p_replace_bits((__le32 *)((u8 *)cmd + offset), val, GENMASK(31, 0));
@@ -3505,6 +3555,7 @@ int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi
 int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id);
-- 
2.25.1

