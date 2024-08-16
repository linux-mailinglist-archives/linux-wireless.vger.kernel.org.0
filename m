Return-Path: <linux-wireless+bounces-11554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC73954914
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 14:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852331C240E0
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B394F13DBB7;
	Fri, 16 Aug 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Fro7JkqB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96261A76B2
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812401; cv=none; b=kJfYLAOSsGwIUIBq6jXGnrQvdGrfxILtls7g7QN+SN7MECKnLowuPm5dgAPpChZdDl2k3g4smHUqc3cNDKP14K+aGmFXn095MlOBlfqyP7kwEsmeF1eTDQf5OzjXyZDxDBfFvmN3uVScDew4yIRQdLtcgxrlu3jXf099HI8g0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812401; c=relaxed/simple;
	bh=6Iqvz1QSsBCpRJ2Pk+mIce70P4EiTJKghfKMH5SynMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPFLIhaERGOfp1HP66+MXW5Ga++O32Jn01g2sLXPYxv75wAMiKSW9I3EEUbOmZQZW/VuEWej1ngzbnQHspncVEAlHNYCm05TQ/w7SVMOZpOiAuTy1PPsWX4WJyTWZJCaQn3XZwG8R2mo1gD42XcDHdfhRctnpfOxOjbK/anqYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Fro7JkqB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47GCkascF1028006, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723812396; bh=6Iqvz1QSsBCpRJ2Pk+mIce70P4EiTJKghfKMH5SynMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Fro7JkqBppsfOfOqb5EZxMdEfuw5WT/DKCKOyZbiou+/vykWLX0Z53U2kFSb4dCgQ
	 CD0uk+uyMhGXpBMJeLrv9NWaI+fCpgmb4NtH/PX9W4NYz4NdFwDvP4yLe5DRhi8p31
	 orNRbYhWrD3DLYImozIejnpwSBkv7ujd9wQn6zXX9ee/4+b7Df5m/k7GvWFGyl9yh5
	 2oqDYKWroQtSoX0d5eaRyHPeEEGBqfKyqbQ2w0h7k+kFt8v9s/ntl8V4Fvkw7JY65u
	 A5bbagJVTfNuZIJQo49Ry7WnSqeGAH0EamTaMsodxfdE8ApQGyWBJ2DfTSVHF7VSKP
	 3XM0TBurNzH5w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47GCkascF1028006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 20:46:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 20:46:37 +0800
Received: from [127.0.1.1] (172.16.21.174) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 Aug
 2024 20:46:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 2/4] wifi: rtw89: coex: Update Wi-Fi role info version 7
Date: Fri, 16 Aug 2024 20:46:12 +0800
Message-ID: <20240816124614.25592-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816124614.25592-1-pkshih@realtek.com>
References: <20240816124614.25592-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

This version included new introduced Wi-Fi DBCC information related to
WiFi role.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 251 ++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h |  36 ++++
 drivers/net/wireless/realtek/rtw89/fw.c   |  49 ++++-
 drivers/net/wireless/realtek/rtw89/fw.h   |  27 ++-
 4 files changed, 339 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 97e34287dfca..0a8480644b0c 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -2610,6 +2610,10 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 			rtw89_fw_h2c_cxdrv_role_v1(rtwdev, type);
 		else if (ver->fwlrole == 2)
 			rtw89_fw_h2c_cxdrv_role_v2(rtwdev, type);
+		else if (ver->fwlrole == 7)
+			rtw89_fw_h2c_cxdrv_role_v7(rtwdev, type);
+		else if (ver->fwlrole == 8)
+			rtw89_fw_h2c_cxdrv_role_v8(rtwdev, type);
 		break;
 	case CXDRVINFO_CTRL:
 		if (ver->drvinfo_type == 1)
@@ -2791,7 +2795,7 @@ static void _set_gnt_v1(struct rtw89_dev *rtwdev, u8 phy_map,
 	rtw89_mac_cfg_gnt_v2(rtwdev, &dm->gnt);
 }
 
-#define BTC_TDMA_WLROLE_MAX 2
+#define BTC_TDMA_WLROLE_MAX 3
 
 static void _set_bt_ignore_wlan_act(struct rtw89_dev *rtwdev, u8 enable)
 {
@@ -5610,6 +5614,14 @@ _update_rssi_state(struct rtw89_dev *rtwdev, u8 pre_state, u8 rssi, u8 thresh)
 	return next_state;
 }
 
+static void _wl_req_mac(struct rtw89_dev *rtwdev, u8 mac)
+{
+	if (mac == RTW89_MAC_0)
+		rtw89_write32_clr(rtwdev, R_AX_BTC_CFG, B_AX_WL_SRC);
+	else
+		rtw89_write32_set(rtwdev, R_AX_BTC_CFG, B_AX_WL_SRC);
+}
+
 static
 void _update_dbcc_band(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
@@ -6108,12 +6120,20 @@ static u8 _chk_dbcc(struct rtw89_dev *rtwdev, struct rtw89_btc_chdef *ch,
 		    u8 *phy, u8 *role, u8 *dbcc_2g_phy)
 {
 	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
+	struct rtw89_btc_wl_role_info_v7 *rinfo_v7 = &wl->role_info_v7;
+	struct rtw89_btc_wl_role_info_v8 *rinfo_v8 = &wl->role_info_v8;
 	bool is_2g_ch_exist = false, is_multi_role_in_2g_phy = false;
-	u8 j, k, dbcc_2g_cid, dbcc_2g_cid2;
+	u8 j, k, dbcc_2g_cid, dbcc_2g_cid2, connect_cnt;
+
+	if (rtwdev->btc.ver->fwlrole == 7)
+		connect_cnt = rinfo_v7->connect_cnt;
+	else if (rtwdev->btc.ver->fwlrole == 8)
+		connect_cnt = rinfo_v8->connect_cnt;
+	else
+		return BTC_WLINK_NOLINK;
 
 	/* find out the 2G-PHY by connect-id ->ch  */
-	for (j = 0; j < wl_rinfo->connect_cnt; j++) {
+	for (j = 0; j < connect_cnt; j++) {
 		if (ch[j].center_ch <= 14) {
 			is_2g_ch_exist = true;
 			break;
@@ -6128,11 +6148,11 @@ static u8 _chk_dbcc(struct rtw89_dev *rtwdev, struct rtw89_btc_chdef *ch,
 	*dbcc_2g_phy = phy[dbcc_2g_cid];
 
 	/* connect_cnt <= 2 */
-	if (wl_rinfo->connect_cnt < BTC_TDMA_WLROLE_MAX)
+	if (connect_cnt < BTC_TDMA_WLROLE_MAX)
 		return (_get_role_link_mode((role[dbcc_2g_cid])));
 
 	/* find the other-port in the 2G-PHY, ex: PHY-0:6G, PHY1: mcc/scc */
-	for (k = 0; k < wl_rinfo->connect_cnt; k++) {
+	for (k = 0; k < connect_cnt; k++) {
 		if (k == dbcc_2g_cid)
 			continue;
 
@@ -6159,29 +6179,54 @@ static u8 _chk_dbcc(struct rtw89_dev *rtwdev, struct rtw89_btc_chdef *ch,
 static void _update_role_link_mode(struct rtw89_dev *rtwdev,
 				   bool client_joined, u32 noa)
 {
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &rtwdev->btc.cx.wl.role_info_v8;
+	struct rtw89_btc_wl_role_info_v8 *rinfo_v8 = &rtwdev->btc.cx.wl.role_info_v8;
+	struct rtw89_btc_wl_role_info_v7 *rinfo_v7 = &rtwdev->btc.cx.wl.role_info_v7;
+	u8 role_ver = rtwdev->btc.ver->fwlrole;
 	u32 type = BTC_WLMROLE_NONE, dur = 0;
-	u32 wl_role = wl_rinfo->role_map;
+	u8 link_mode, connect_cnt;
+	u32 wl_role;
+
+	if (role_ver == 7) {
+		wl_role = rinfo_v7->role_map;
+		link_mode = rinfo_v7->link_mode;
+		connect_cnt = rinfo_v7->connect_cnt;
+	} else if (role_ver == 8) {
+		wl_role = rinfo_v8->role_map;
+		link_mode = rinfo_v8->link_mode;
+		connect_cnt = rinfo_v8->connect_cnt;
+	} else {
+		return;
+	}
 
 	/* if no client_joined, don't care P2P-GO/AP role */
 	if (((wl_role & BIT(RTW89_WIFI_ROLE_P2P_GO)) ||
 	     (wl_role & BIT(RTW89_WIFI_ROLE_AP))) && !client_joined) {
-		if (wl_rinfo->link_mode == BTC_WLINK_2G_SCC) {
-			wl_rinfo->link_mode = BTC_WLINK_2G_STA;
-			wl_rinfo->connect_cnt--;
-		} else if (wl_rinfo->link_mode == BTC_WLINK_2G_GO ||
-			wl_rinfo->link_mode == BTC_WLINK_2G_AP) {
-			wl_rinfo->link_mode = BTC_WLINK_NOLINK;
-			wl_rinfo->connect_cnt--;
+		if (link_mode == BTC_WLINK_2G_SCC) {
+			if (role_ver == 7) {
+				rinfo_v7->link_mode = BTC_WLINK_2G_STA;
+				rinfo_v7->connect_cnt--;
+			} else if (role_ver == 8) {
+				rinfo_v8->link_mode = BTC_WLINK_2G_STA;
+				rinfo_v8->connect_cnt--;
+			}
+		} else if (link_mode == BTC_WLINK_2G_GO ||
+			   link_mode == BTC_WLINK_2G_AP) {
+			if (role_ver == 7) {
+				rinfo_v7->link_mode = BTC_WLINK_NOLINK;
+				rinfo_v7->connect_cnt--;
+			} else if (role_ver == 8) {
+				rinfo_v8->link_mode = BTC_WLINK_NOLINK;
+				rinfo_v8->connect_cnt--;
+			}
 		}
 	}
 
 	/* Identify 2-Role type  */
-	if (wl_rinfo->connect_cnt >= 2 &&
-	    (wl_rinfo->link_mode == BTC_WLINK_2G_SCC ||
-	     wl_rinfo->link_mode == BTC_WLINK_2G_MCC ||
-	     wl_rinfo->link_mode == BTC_WLINK_25G_MCC ||
-	     wl_rinfo->link_mode == BTC_WLINK_5G)) {
+	if (connect_cnt >= 2 &&
+	    (link_mode == BTC_WLINK_2G_SCC ||
+	     link_mode == BTC_WLINK_2G_MCC ||
+	     link_mode == BTC_WLINK_25G_MCC ||
+	     link_mode == BTC_WLINK_5G)) {
 		if ((wl_role & BIT(RTW89_WIFI_ROLE_P2P_GO)) ||
 		    (wl_role & BIT(RTW89_WIFI_ROLE_AP)))
 			type = noa ? BTC_WLMROLE_STA_GO_NOA : BTC_WLMROLE_STA_GO;
@@ -6193,8 +6238,167 @@ static void _update_role_link_mode(struct rtw89_dev *rtwdev,
 		dur = noa;
 	}
 
-	wl_rinfo->mrole_type = type;
-	wl_rinfo->mrole_noa_duration = dur;
+	if (role_ver == 7) {
+		rinfo_v7->mrole_type = type;
+		rinfo_v7->mrole_noa_duration = dur;
+	} else if (role_ver == 8) {
+		rinfo_v8->mrole_type = type;
+		rinfo_v8->mrole_noa_duration = dur;
+	}
+}
+
+static void _update_wl_info_v7(struct rtw89_dev *rtwdev, u8 rid)
+{
+	struct rtw89_btc_chdef cid_ch[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER];
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_role_info_v7 *wl_rinfo = &wl->role_info_v7;
+	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
+	struct rtw89_btc_wl_link_info *wl_linfo = wl->link_info;
+	struct rtw89_btc_wl_active_role_v7 *act_role = NULL;
+	u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, phy_now = RTW89_PHY_MAX, phy_dbcc;
+	bool b2g = false, b5g = false, client_joined = false, client_inc_2g = false;
+	u8 client_cnt_last[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
+	u8 cid_role[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
+	u8 cid_phy[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
+	u8 mac = RTW89_MAC_0, dbcc_2g_phy = RTW89_PHY_0;
+	u32 noa_duration = 0;
+
+	memset(wl_rinfo, 0, sizeof(*wl_rinfo));
+
+	for (i = 0; i < RTW89_PORT_NUM; i++) {
+		if (!wl_linfo[i].active || wl_linfo[i].phy >= RTW89_PHY_MAX)
+			continue;
+
+		act_role = &wl_rinfo->active_role[i];
+		act_role->role = wl_linfo[i].role;
+
+		/* check if role connect? */
+		if (wl_linfo[i].connected == MLME_NO_LINK) {
+			act_role->connected = 0;
+			continue;
+		} else if (wl_linfo[i].connected == MLME_LINKING) {
+			continue;
+		}
+
+		cnt++;
+		act_role->connected = 1;
+		act_role->pid = wl_linfo[i].pid;
+		act_role->phy = wl_linfo[i].phy;
+		act_role->band = wl_linfo[i].band;
+		act_role->ch = wl_linfo[i].ch;
+		act_role->bw = wl_linfo[i].bw;
+		act_role->noa = wl_linfo[i].noa;
+		act_role->noa_dur = wl_linfo[i].noa_duration;
+		cid_ch[cnt - 1] = wl_linfo[i].chdef;
+		cid_phy[cnt - 1] = wl_linfo[i].phy;
+		cid_role[cnt - 1] = wl_linfo[i].role;
+		wl_rinfo->role_map |= BIT(wl_linfo[i].role);
+
+		if (rid == i)
+			phy_now = act_role->phy;
+
+		if (wl_linfo[i].role == RTW89_WIFI_ROLE_P2P_GO ||
+		    wl_linfo[i].role == RTW89_WIFI_ROLE_AP) {
+			if (wl_linfo[i].client_cnt > 1)
+				client_joined = true;
+			if (client_cnt_last[i] < wl_linfo[i].client_cnt &&
+			    wl_linfo[i].chdef.band == RTW89_BAND_2G)
+				client_inc_2g = true;
+			act_role->client_cnt = wl_linfo[i].client_cnt;
+		} else {
+			act_role->client_cnt = 0;
+		}
+
+		if (act_role->noa && act_role->noa_dur > 0)
+			noa_duration = act_role->noa_dur;
+
+		if (rtwdev->dbcc_en) {
+			phy_dbcc = wl_linfo[i].phy;
+			wl_dinfo->role[phy_dbcc] |= BIT(wl_linfo[i].role);
+			wl_dinfo->op_band[phy_dbcc] = wl_linfo[i].chdef.band;
+		}
+
+		if (wl_linfo[i].chdef.band != RTW89_BAND_2G) {
+			cnt_5g++;
+			b5g = true;
+		} else {
+			if (((wl_linfo[i].role == RTW89_WIFI_ROLE_P2P_GO ||
+			      wl_linfo[i].role == RTW89_WIFI_ROLE_AP) &&
+			     client_joined) ||
+			    wl_linfo[i].role == RTW89_WIFI_ROLE_P2P_CLIENT)
+				wl_rinfo->p2p_2g = 1;
+
+			if ((wl_linfo[i].mode & BIT(BTC_WL_MODE_11B)) ||
+			    (wl_linfo[i].mode & BIT(BTC_WL_MODE_11G)))
+				wl->bg_mode = 1;
+			else if (wl_linfo[i].mode & BIT(BTC_WL_MODE_HE))
+				wl->he_mode = true;
+
+			cnt_2g++;
+			b2g = true;
+		}
+
+		if (act_role->band == RTW89_BAND_5G && act_role->ch >= 100)
+			wl->is_5g_hi_channel = 1;
+		else
+			wl->is_5g_hi_channel = 0;
+	}
+
+	wl_rinfo->connect_cnt = cnt;
+	wl->client_cnt_inc_2g = client_inc_2g;
+
+	if (cnt == 0) {
+		mode = BTC_WLINK_NOLINK;
+		wl_rinfo->role_map = BIT(RTW89_WIFI_ROLE_NONE);
+	} else if (!b2g && b5g) {
+		mode = BTC_WLINK_5G;
+	} else if (wl_rinfo->role_map & BIT(RTW89_WIFI_ROLE_NAN)) {
+		mode = BTC_WLINK_2G_NAN;
+	} else if (cnt > BTC_TDMA_WLROLE_MAX) {
+		mode = BTC_WLINK_OTHER;
+	} else if (rtwdev->dbcc_en) {
+		mode = _chk_dbcc(rtwdev, cid_ch, cid_phy, cid_role, &dbcc_2g_phy);
+
+		/* correct 2G-located PHY band for gnt ctrl */
+		if (dbcc_2g_phy < RTW89_PHY_MAX)
+			wl_dinfo->op_band[dbcc_2g_phy] = RTW89_BAND_2G;
+	} else if (b2g && b5g && cnt == 2) {
+		mode = BTC_WLINK_25G_MCC;
+	} else if (!b5g && cnt == 2) { /* cnt_connect = 2 */
+		if (_chk_role_ch_group(&cid_ch[0], &cid_ch[cnt - 1]))
+			mode = BTC_WLINK_2G_SCC;
+		else
+			mode = BTC_WLINK_2G_MCC;
+	} else if (!b5g && cnt == 1) { /* cnt_connect = 1 */
+		mode = _get_role_link_mode(cid_role[0]);
+	} else {
+		mode = BTC_WLINK_NOLINK;
+	}
+
+	wl_rinfo->link_mode = mode;
+	_update_role_link_mode(rtwdev, client_joined, noa_duration);
+
+	/* todo DBCC related event */
+	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC] wl_info phy_now=%d\n", phy_now);
+
+	if (wl_rinfo->dbcc_en != rtwdev->dbcc_en) {
+		wl_rinfo->dbcc_chg = 1;
+		wl_rinfo->dbcc_en = rtwdev->dbcc_en;
+		btc->cx.cnt_wl[BTC_WCNT_DBCC_CHG]++;
+	}
+
+	if (rtwdev->dbcc_en) {
+		wl_rinfo->dbcc_2g_phy = dbcc_2g_phy;
+
+		if (dbcc_2g_phy == RTW89_PHY_1)
+			mac = RTW89_MAC_1;
+
+		_update_dbcc_band(rtwdev, RTW89_PHY_0);
+		_update_dbcc_band(rtwdev, RTW89_PHY_1);
+	}
+	_wl_req_mac(rtwdev, mac);
+	_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
 }
 
 static void _update_wl_info_v8(struct rtw89_dev *rtwdev, u8 role_id, u8 rlink_id,
@@ -7293,6 +7497,9 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 	} else if (ver->fwlrole == 2) {
 		*wlinfo = r;
 		_update_wl_info_v2(rtwdev);
+	} else if (ver->fwlrole == 7) {
+		*wlinfo = r;
+		_update_wl_info_v7(rtwdev, r.pid);
 	} else if (ver->fwlrole == 8) {
 		wlinfo = &wl->rlink_info[r.pid][rlink_id];
 		*wlinfo = r;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a9feb235c269..e798fb96bf16 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1589,6 +1589,23 @@ struct rtw89_btc_wl_active_role_v2 {
 	u32 noa_duration; /* ms */
 };
 
+struct rtw89_btc_wl_active_role_v7 {
+	u8 connected;
+	u8 pid;
+	u8 phy;
+	u8 noa;
+
+	u8 band;
+	u8 client_ps;
+	u8 bw;
+	u8 role;
+
+	u8 ch;
+	u8 noa_dur;
+	u8 client_cnt;
+	u8 rsvd2;
+} __packed;
+
 struct rtw89_btc_wl_role_info_bpos {
 	u16 none: 1;
 	u16 station: 1;
@@ -1670,6 +1687,22 @@ struct rtw89_btc_wl_rlink { /* H2C info, struct size must be n*4 bytes */
 } __packed;
 
 #define RTW89_BE_BTC_WL_MAX_ROLE_NUMBER 6
+struct rtw89_btc_wl_role_info_v7 { /* struct size must be n*4 bytes */
+	u8 connect_cnt;
+	u8 link_mode;
+	u8 link_mode_chg;
+	u8 p2p_2g;
+
+	struct rtw89_btc_wl_active_role_v7 active_role[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER];
+
+	u32 role_map;
+	u32 mrole_type; /* btc_wl_mrole_type */
+	u32 mrole_noa_duration; /* ms */
+	u32 dbcc_en;
+	u32 dbcc_chg;
+	u32 dbcc_2g_phy; /* which phy operate in 2G, HW_PHY_0 or HW_PHY_1 */
+} __packed;
+
 struct rtw89_btc_wl_role_info_v8 { /* H2C info, struct size must be n*4 bytes */
 	u8 connect_cnt;
 	u8 link_mode;
@@ -1833,6 +1866,7 @@ struct rtw89_btc_wl_info {
 	struct rtw89_btc_wl_role_info role_info;
 	struct rtw89_btc_wl_role_info_v1 role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 role_info_v2;
+	struct rtw89_btc_wl_role_info_v7 role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 role_info_v8;
 	struct rtw89_btc_wl_scan_info scan_info;
 	struct rtw89_btc_wl_dbcc_info dbcc_info;
@@ -1850,8 +1884,10 @@ struct rtw89_btc_wl_info {
 	bool is_5g_hi_channel;
 	bool pta_reg_mac_chg;
 	bool bg_mode;
+	bool he_mode;
 	bool scbd_change;
 	bool fw_ver_mismatch;
+	bool client_cnt_inc_2g;
 	u32 scbd;
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 47aa365991c1..06b263550ef0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4325,6 +4325,52 @@ int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev, u8 type)
 	return ret;
 }
 
+int rtw89_fw_h2c_cxdrv_role_v7(struct rtw89_dev *rtwdev, u8 type)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_role_info_v7 *role = &btc->cx.wl.role_info_v7;
+	struct rtw89_h2c_cxrole_v7 *h2c;
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
+	h2c = (struct rtw89_h2c_cxrole_v7 *)skb->data;
+
+	h2c->hdr.type = type;
+	h2c->hdr.ver = btc->ver->fwlrole;
+	h2c->hdr.len = len - H2C_LEN_CXDRVHDR_V7;
+	memcpy(&h2c->_u8, role, sizeof(h2c->_u8));
+	h2c->_u32.role_map = cpu_to_le32(role->role_map);
+	h2c->_u32.mrole_type = cpu_to_le32(role->mrole_type);
+	h2c->_u32.mrole_noa_duration = cpu_to_le32(role->mrole_noa_duration);
+	h2c->_u32.dbcc_en = cpu_to_le32(role->dbcc_en);
+	h2c->_u32.dbcc_chg = cpu_to_le32(role->dbcc_chg);
+	h2c->_u32.dbcc_2g_phy = cpu_to_le32(role->dbcc_2g_phy);
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
 int rtw89_fw_h2c_cxdrv_role_v8(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -4343,6 +4389,7 @@ int rtw89_fw_h2c_cxdrv_role_v8(struct rtw89_dev *rtwdev, u8 type)
 	h2c = (struct rtw89_h2c_cxrole_v8 *)skb->data;
 
 	h2c->hdr.type = type;
+	h2c->hdr.ver = btc->ver->fwlrole;
 	h2c->hdr.len = len - H2C_LEN_CXDRVHDR_V7;
 	memcpy(&h2c->_u8, role, sizeof(h2c->_u8));
 	h2c->_u32.role_map = cpu_to_le32(role->role_map);
@@ -4423,7 +4470,7 @@ int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type)
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
-		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_ctrl\n");
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_ctrl_v7\n");
 		return -ENOMEM;
 	}
 	skb_put(skb, len);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 663eda5d0452..cb0ecb9b4c11 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2147,6 +2147,30 @@ struct rtw89_h2c_cxctrl_v7 {
 #define H2C_LEN_CXDRVHDR sizeof(struct rtw89_h2c_cxhdr)
 #define H2C_LEN_CXDRVHDR_V7 sizeof(struct rtw89_h2c_cxhdr_v7)
 
+struct rtw89_btc_wl_role_info_v7_u8 {
+	u8 connect_cnt;
+	u8 link_mode;
+	u8 link_mode_chg;
+	u8 p2p_2g;
+
+	struct rtw89_btc_wl_active_role_v7 active_role[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER];
+} __packed;
+
+struct rtw89_btc_wl_role_info_v7_u32 {
+	__le32 role_map;
+	__le32 mrole_type;
+	__le32 mrole_noa_duration;
+	__le32 dbcc_en;
+	__le32 dbcc_chg;
+	__le32 dbcc_2g_phy;
+} __packed;
+
+struct rtw89_h2c_cxrole_v7 {
+	struct rtw89_h2c_cxhdr_v7 hdr;
+	struct rtw89_btc_wl_role_info_v7_u8 _u8;
+	struct rtw89_btc_wl_role_info_v7_u32 _u32;
+} __packed;
+
 struct rtw89_btc_wl_role_info_v8_u8 {
 	u8 connect_cnt;
 	u8 link_mode;
@@ -2168,7 +2192,7 @@ struct rtw89_btc_wl_role_info_v8_u32 {
 } __packed;
 
 struct rtw89_h2c_cxrole_v8 {
-	struct rtw89_h2c_cxhdr hdr;
+	struct rtw89_h2c_cxhdr_v7 hdr;
 	struct rtw89_btc_wl_role_info_v8_u8 _u8;
 	struct rtw89_btc_wl_role_info_v8_u32 _u32;
 } __packed;
@@ -4426,6 +4450,7 @@ int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_role_v7(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v8(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type);
-- 
2.25.1


