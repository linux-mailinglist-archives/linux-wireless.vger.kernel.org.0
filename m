Return-Path: <linux-wireless+bounces-38891-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YnkeJrEEU2pJWAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38891-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:06:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66827743A34
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:06:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=pnQRJIDC;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38891-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38891-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FCA3301906A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1EF2C21E8;
	Sun, 12 Jul 2026 03:06:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA052571DA
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:06:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783825579; cv=none; b=W27aqhXedT0EbDPUmKb0gdNWFZDbOU01qvX0/0Ya+o+DJzqqBQHd+AYJoPys055jsDRLAqHige+orFkzm6geIDKS4H6ghoj9yye//FaDN9VXwFKqMFq/EDXyPtofAp6ve9XY+RGK2gcCfCoLhdbypfbJsPypnCciOcX7blkivV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783825579; c=relaxed/simple;
	bh=AD/YxjOL+y0dJINhzND42kzg9bscKJwPeoLCNFzFbpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTDPq76O71J9hYp2C66d59bDmycIX7K4DbXQoBqVq5+nzbVsIKzjLJMUtQmDo2ZQiFA19gGFJx1Lg0VF0QtdFAB9uGFooC64DJbqsEEugEbyznk8I6DB6ZPVguXISFynds3Zbgrawfj67gFFZXh+H33SZ6fM6kxYyK0tb41LaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pnQRJIDC; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C369I50525827, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783825569; bh=KUVWL6YD6h0UFP7tOIRIhwPPzlCj9pCaRAGtahfdGUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pnQRJIDCduuArC9tWzCsL3qey0JtoaE3ci4MgVRdf/HLYDmBGu24+OCCY5kdVC70k
	 abZc9v5Hq0UCOSh9DjtaiB54YvXZJjbZ2jVylJ3qKNP2PcDi9B2vUKyfQKh5K3CIqp
	 b52jc3VppCiQSXUp38LOAd91xajedOJkKT81VASsNqGASKEL0Y3461y4VZCFOZ2jn8
	 KFzE3CzrEmGXo2KLWqIE8bgd7am3PITroB24CM0+1SlC/6GHZjvJVA7ipGvN87HzsY
	 J7fZQJOpb3qOAtoYeLtFAXMLiVcH+UosopKfgD4fC2WtG5lu/7W8hTwHtCfsgQJ2tK
	 b4ZKny1mUfaDg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C369I50525827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:06:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:09 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:06:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 01/11] wifi: rtw89: coex: Add Wi-Fi role info version 10
Date: Sun, 12 Jul 2026 11:04:56 +0800
Message-ID: <20260712030506.43438-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260712030506.43438-1-pkshih@realtek.com>
References: <20260712030506.43438-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38891-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:ku920601@realtek.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,chdef.band:url,r.bw:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66827743A34

From: Ching-Te Ku <ku920601@realtek.com>

Because the new generation Bluetooth will able to work on 5/6GHz band,
it will suffer 5/6GHz Wi-Fi, the mechanism need to cover more scenario
with different Wi-Fi/Bluetooth combination.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 2445 +++++++----------
 drivers/net/wireless/realtek/rtw89/coex.h     |   34 +
 drivers/net/wireless/realtek/rtw89/core.h     |  153 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |  392 ++-
 drivers/net/wireless/realtek/rtw89/fw.h       |   48 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |    1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |    1 +
 12 files changed, 1391 insertions(+), 1688 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 989344e93ab7..c02de0b4f7bf 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -436,11 +436,6 @@ union rtw89_fbtc_set_mon_reg {
 	struct rtw89_btc_btf_set_mon_reg_v7 v7;
 } __packed;
 
-struct _wl_rinfo_now {
-	u8 link_mode;
-	u32 dbcc_2g_phy: 2;
-};
-
 enum btc_btf_set_cx_policy {
 	CXPOLICY_TDMA = 0x0,
 	CXPOLICY_SLOT = 0x1,
@@ -570,9 +565,21 @@ enum btc_cx_poicy_type {
 	/* TDMA off + pri: WL > BT, Block-BT*/
 	BTC_CXP_OFF_WL2 = (BTC_CXP_OFF << 8) | 12,
 
-	/* TDMA off+Bcn-Protect + pri: WL_Hi-Tx > BT_Hi_Rx, BT_Hi > WL > BT_Lo*/
+	/* TDMA off+Bcn-Protect + pri: BT_Hi > WL > BT_Lo */
 	BTC_CXP_OFFB_BWB0 = (BTC_CXP_OFFB << 8) | 0,
 
+	/* TDMA off+Bcn-Protect + pri: BT_Hi_Tx = WL_Hi-Tx > BT_Hi_Rx, BT_Hi > WL > BT_Lo */
+	BTC_CXP_OFFB_BWB1 = (BTC_CXP_OFFB << 8) | 1,
+
+	/* TDMA off+Bcn-Protect + pri: WL_Hi-Tx > BT, BT_Hi > other-WL > BT_Lo */
+	BTC_CXP_OFFB_BWB2 = (BTC_CXP_OFFB << 8) | 2,
+
+	/* TDMA off+Bcn-Protect + pri: WL_Hi-Tx = BT*/
+	BTC_CXP_OFFB_BWB3 = (BTC_CXP_OFFB << 8) | 3,
+
+	/* TDMA off+Bcn-Protect + pri: BT > WL*/
+	BTC_CXP_OFFB_BWB4 = (BTC_CXP_OFFB << 8) | 4,
+
 	/* TDMA off + Ext-Ctrl + pri: default */
 	BTC_CXP_OFFE_DEF = (BTC_CXP_OFFE << 8) | 0,
 
@@ -752,19 +759,31 @@ enum btc_w2b_scoreboard {
 	BTC_WSCB_ALL = GENMASK(23, 0),
 };
 
-enum btc_wl_link_mode {
+enum btc_wl_link_mode_v0 {
+	BTC_WLINK_V0_NOLINK = 0x0,
+	BTC_WLINK_V0_2G_STA,
+	BTC_WLINK_V0_2G_AP,
+	BTC_WLINK_V0_2G_GO,
+	BTC_WLINK_V0_2G_GC,
+	BTC_WLINK_V0_2G_SCC,
+	BTC_WLINK_V0_2G_MCC,
+	BTC_WLINK_V0_25G_MCC,
+	BTC_WLINK_V0_25G_DBCC,
+	BTC_WLINK_V0_5G,
+	BTC_WLINK_V0_2G_NAN,
+	BTC_WLINK_V0_OTHER,
+	BTC_WLINK_V0_MAX
+};
+
+enum btc_wl_link_mode_v1 {
 	BTC_WLINK_NOLINK = 0x0,
-	BTC_WLINK_2G_STA,
-	BTC_WLINK_2G_AP,
-	BTC_WLINK_2G_GO,
-	BTC_WLINK_2G_GC,
-	BTC_WLINK_2G_SCC,
-	BTC_WLINK_2G_MCC,
-	BTC_WLINK_25G_MCC,
-	BTC_WLINK_25G_DBCC,
-	BTC_WLINK_5G,
-	BTC_WLINK_2G_NAN,
-	BTC_WLINK_OTHER,
+	BTC_WLINK_STA,
+	BTC_WLINK_AP,
+	BTC_WLINK_GO,
+	BTC_WLINK_GC,
+	BTC_WLINK_SCC,
+	BTC_WLINK_SB_MCC,
+	BTC_WLINK_DB_MCC, /* 2+0/0+2 Dual-RF-band MCC */
 	BTC_WLINK_MAX
 };
 
@@ -774,16 +793,13 @@ static const char *id_to_linkmode(u8 id)
 {
 	switch (id) {
 	CASE_BTC_WL_LINK_MODE(NOLINK);
-	CASE_BTC_WL_LINK_MODE(2G_STA);
-	CASE_BTC_WL_LINK_MODE(2G_AP);
-	CASE_BTC_WL_LINK_MODE(2G_GO);
-	CASE_BTC_WL_LINK_MODE(2G_GC);
-	CASE_BTC_WL_LINK_MODE(2G_SCC);
-	CASE_BTC_WL_LINK_MODE(2G_MCC);
-	CASE_BTC_WL_LINK_MODE(25G_MCC);
-	CASE_BTC_WL_LINK_MODE(25G_DBCC);
-	CASE_BTC_WL_LINK_MODE(5G);
-	CASE_BTC_WL_LINK_MODE(OTHER);
+	CASE_BTC_WL_LINK_MODE(STA);
+	CASE_BTC_WL_LINK_MODE(AP);
+	CASE_BTC_WL_LINK_MODE(GO);
+	CASE_BTC_WL_LINK_MODE(GC);
+	CASE_BTC_WL_LINK_MODE(SCC);
+	CASE_BTC_WL_LINK_MODE(SB_MCC);
+	CASE_BTC_WL_LINK_MODE(DB_MCC);
 	default:
 		return "unknown";
 	}
@@ -969,7 +985,7 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	struct rtw89_btc_wl_link_info *wl_linfo;
-	u8 i;
+	u8 i, j;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s\n", __func__);
 
@@ -990,12 +1006,11 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 	if (type & BTC_RESET_DM) {
 		memset(&btc->dm, 0, sizeof(btc->dm));
 		memset(bt_linfo->rssi_state, 0, sizeof(bt_linfo->rssi_state));
-		for (i = 0; i < RTW89_PORT_NUM; i++) {
-			if (btc->ver->fwlrole == 8)
-				wl_linfo = &wl->rlink_info[i][0];
-			else
-				wl_linfo = &wl->link_info[i];
-			memset(wl_linfo->rssi_state, 0, sizeof(wl_linfo->rssi_state));
+		for (j = RTW89_MAC_0; j <= RTW89_MAC_1; j++) {
+			for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
+				wl_linfo = &wl->rlink_info[i][j];
+				memset(wl_linfo->rssi_state, 0, sizeof(wl_linfo->rssi_state));
+			}
 		}
 
 		/* set the slot_now table to original */
@@ -2847,6 +2862,8 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 index)
 			rtw89_fw_h2c_cxdrv_role_v7(rtwdev, index);
 		else if (ver->fwlrole == 8)
 			rtw89_fw_h2c_cxdrv_role_v8(rtwdev, index);
+		else if (ver->fwlrole == 10)
+			rtw89_fw_h2c_cxdrv_role_v10(rtwdev, index);
 		break;
 	case CXDRVINFO_CTRL:
 		if (ver->drvinfo_ver != 0)
@@ -3396,29 +3413,17 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_role_info *r = &wl->role_info;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_bt_link_info *b = &bt->link_info;
 	struct rtw89_btc_wl_smap *wl_smap = &wl->status.map;
 	struct rtw89_btc_rf_trx_para_v9 para;
-	u8 lv, link_mode = 0, i, dbcc_2g_phy = 0;
-	u8 ul_para_num, dl_para_num;
-	u8 rf_band = RTW89_BAND_2G;
-	u8 bid = BTC_BT_1ST;
-	u32 wl_stb_chg = 0;
-
-	if (ver->fwlrole == 0) {
-		link_mode = wl->role_info.link_mode;
-		for (i = 0; i < RTW89_PHY_NUM; i++) {
-			if (wl->dbcc_info.real_band[i] == RTW89_BAND_2G)
-				dbcc_2g_phy = i;
-		}
-	} else if (ver->fwlrole == 1) {
-		link_mode = wl->role_info_v1.link_mode;
-		dbcc_2g_phy = wl->role_info_v1.dbcc_2g_phy;
-	} else if (ver->fwlrole == 2) {
-		link_mode = wl->role_info_v2.link_mode;
-		dbcc_2g_phy = wl->role_info_v2.dbcc_2g_phy;
-	}
+	u8 bmode = dm->tdd_bind.wl_link_mode;
+	u8 rf_band = dm->tdd_bind.rf_band;
+	u8 i, ul_para_num, dl_para_num;
+	u8 mode = BTC_WLINK_NOLINK;
+	u8 bid = BTC_BT_1ST, lv;
+	u32 wl_stb_chg;
 
 	if (ver->fcxtrx == 9 && chip->rf_para_ulink_v9) {
 		ul_para_num = chip->rf_para_ulink_num_v9;
@@ -3434,6 +3439,19 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 		goto next;
 	}
 
+	if (bmode == BTC_WLINK_NOLINK) {
+		return;
+	} else if (btc->ver->fwlrole == 10) {
+		if (rf_band == RTW89_BAND_5G) {
+			mode = BTC_WLINK_V0_5G;
+		} else if (rf_band == RTW89_BAND_2G &&
+			   bmode == BTC_WLINK_STA) {
+			mode = BTC_WLINK_V0_2G_STA;
+		}
+	} else {
+		mode = r->link_mode_v0;
+	}
+
 	/* decide trx_para_level */
 	if (btc->ant_type == BTC_ANT_SHARED) {
 		/* fix LNA2 + TIA gain not change by GNT_BT */
@@ -3446,7 +3464,7 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 		dm->trx_para_level = 5;
 		/* modify trx_para if WK 2.4G-STA-DL + bt link */
 		if (b->link_cnt.now != 0 &&
-		    link_mode == BTC_WLINK_2G_STA &&
+		    mode == BTC_WLINK_V0_2G_STA &&
 		    wl->status.map.traffic_dir & BIT(RTW89_TFC_UL)) { /* uplink */
 			if (wl->rssi_level == 4 && bt->rssi_level > 2)
 				dm->trx_para_level = 6;
@@ -3504,10 +3522,8 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 
 next:
 	if (!bt->enable.now || dm->wl_only || wl_smap->rf_off ||
-	    wl_smap->lps == BTC_LPS_RF_OFF ||
-	    link_mode == BTC_WLINK_5G ||
-	    link_mode == BTC_WLINK_NOLINK ||
-	    (rtwdev->dbcc_en && dbcc_2g_phy != RTW89_PHY_1))
+	    wl_smap->lps == BTC_LPS_RF_OFF || mode == BTC_WLINK_V0_5G ||
+	    (rtwdev->dbcc_en && r->dbcc_2g_phy != RTW89_PHY_1))
 		wl_stb_chg = 0;
 	else
 		wl_stb_chg = 1;
@@ -3544,282 +3560,372 @@ static void _update_btc_state_map(struct rtw89_dev *rtwdev)
 	}
 }
 
-static void _set_bt_afh_info_v0(struct rtw89_dev *rtwdev)
+static u8 _get_wl_guard_bw(struct rtw89_dev *rtwdev, u8 index)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_btc *btc = &rtwdev->btc;
-	const struct rtw89_btc_ver *ver = btc->ver;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
-	struct rtw89_btc_bt_link_info *b = &bt->link_info;
-	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
-	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
-	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
-	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
-	struct rtw89_btc_wl_active_role *r;
-	struct rtw89_btc_wl_active_role_v1 *r1;
-	struct rtw89_btc_wl_active_role_v2 *r2;
-	struct rtw89_btc_wl_active_role_v7 *r7;
-	struct rtw89_btc_wl_rlink *rlink;
-	u8 en = 0, i, ch = 0, bw = 0;
-	u8 mode, connect_cnt;
-
-	if (btc->manual_ctrl || wl->status.map.scan)
-		return;
-
-	if (ver->fwlrole == 0) {
-		mode = wl_rinfo->link_mode;
-		connect_cnt = wl_rinfo->connect_cnt;
-	} else if (ver->fwlrole == 1) {
-		mode = wl_rinfo_v1->link_mode;
-		connect_cnt = wl_rinfo_v1->connect_cnt;
-	} else if (ver->fwlrole == 2) {
-		mode = wl_rinfo_v2->link_mode;
-		connect_cnt = wl_rinfo_v2->connect_cnt;
-	} else if (ver->fwlrole == 7) {
-		mode = wl_rinfo_v7->link_mode;
-		connect_cnt = wl_rinfo_v7->connect_cnt;
-	} else if (ver->fwlrole == 8) {
-		mode = wl_rinfo_v8->link_mode;
-		connect_cnt = wl_rinfo_v8->connect_cnt;
-	} else {
-		return;
-	}
-
-	if (wl->status.map.rf_off || bt->whql_test ||
-	    mode == BTC_WLINK_NOLINK || mode == BTC_WLINK_5G ||
-	    connect_cnt > BTC_TDMA_WLROLE_MAX) {
-		en = false;
-	} else if (mode == BTC_WLINK_2G_MCC || mode == BTC_WLINK_2G_SCC) {
-		en = true;
-		/* get p2p channel */
-		for (i = 0; i < RTW89_PORT_NUM; i++) {
-			r = &wl_rinfo->active_role[i];
-			r1 = &wl_rinfo_v1->active_role_v1[i];
-			r2 = &wl_rinfo_v2->active_role_v2[i];
-			r7 = &wl_rinfo_v7->active_role[i];
-			rlink = &wl_rinfo_v8->rlink[i][0];
-
-			if (ver->fwlrole == 0 &&
-			    (r->role == RTW89_WIFI_ROLE_P2P_GO ||
-			     r->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
-				ch = r->ch;
-				bw = r->bw;
-				break;
-			} else if (ver->fwlrole == 1 &&
-				   (r1->role == RTW89_WIFI_ROLE_P2P_GO ||
-				    r1->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
-				ch = r1->ch;
-				bw = r1->bw;
-				break;
-			} else if (ver->fwlrole == 2 &&
-				   (r2->role == RTW89_WIFI_ROLE_P2P_GO ||
-				    r2->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
-				ch = r2->ch;
-				bw = r2->bw;
-				break;
-			} else if (ver->fwlrole == 7 &&
-				   (r7->role == RTW89_WIFI_ROLE_P2P_GO ||
-				    r7->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
-				ch = r7->ch;
-				bw = r7->bw;
-				break;
-			} else if (ver->fwlrole == 8 &&
-				   (rlink->role == RTW89_WIFI_ROLE_P2P_GO ||
-				    rlink->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
-				ch = rlink->ch;
-				bw = rlink->bw;
-				break;
-			}
-		}
-	} else {
-		en = true;
-		/* get 2g channel  */
-		for (i = 0; i < RTW89_PORT_NUM; i++) {
-			r = &wl_rinfo->active_role[i];
-			r1 = &wl_rinfo_v1->active_role_v1[i];
-			r2 = &wl_rinfo_v2->active_role_v2[i];
-			r7 = &wl_rinfo_v7->active_role[i];
-			rlink = &wl_rinfo_v8->rlink[i][0];
-
-			if (ver->fwlrole == 0 &&
-			    r->connected && r->band == RTW89_BAND_2G) {
-				ch = r->ch;
-				bw = r->bw;
-				break;
-			} else if (ver->fwlrole == 1 &&
-				   r1->connected && r1->band == RTW89_BAND_2G) {
-				ch = r1->ch;
-				bw = r1->bw;
-				break;
-			} else if (ver->fwlrole == 2 &&
-				   r2->connected && r2->band == RTW89_BAND_2G) {
-				ch = r2->ch;
-				bw = r2->bw;
-				break;
-			} else if (ver->fwlrole == 7 &&
-				   r7->connected && r7->band == RTW89_BAND_2G) {
-				ch = r7->ch;
-				bw = r7->bw;
-				break;
-			} else if (ver->fwlrole == 8 &&
-				   rlink->connected && rlink->rf_band == RTW89_BAND_2G) {
-				ch = rlink->ch;
-				bw = rlink->bw;
-				break;
-			}
-		}
-	}
+	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
+	u8 guard_ch = rtwdev->chip->afh_guard_ch;
+	u8 bw = 0;
 
-	switch (bw) {
+	/* default AFH channel sapn = center-ch +- 6MHz  */
+	switch (index) {
 	case RTW89_CHANNEL_WIDTH_20:
-		bw = 20 + chip->afh_guard_ch * 2;
+		if (dm->freerun || dm->fddt_train)
+			bw = 48;
+		else
+			bw = 20 + guard_ch * 2;
 		break;
 	case RTW89_CHANNEL_WIDTH_40:
-		bw = 40 + chip->afh_guard_ch * 2;
+		bw = 40 + guard_ch * 2;
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		bw = 80 + guard_ch * 2;
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+	case RTW89_CHANNEL_WIDTH_80_80:
+		bw = 160 + guard_ch * 2;
+		break;
+	case RTW89_CHANNEL_WIDTH_320:
+		bw = 320 + guard_ch * 2;
 		break;
 	case RTW89_CHANNEL_WIDTH_5:
-		bw = 5 + chip->afh_guard_ch * 2;
+		bw = 5 + guard_ch * 2;
 		break;
 	case RTW89_CHANNEL_WIDTH_10:
-		bw = 10 + chip->afh_guard_ch * 2;
+		bw = 10 + guard_ch * 2;
 		break;
 	default:
 		bw = 0;
-		en = false; /* turn off AFH info if BW > 40 */
 		break;
 	}
 
-	if (wl->afh_info.en == en &&
-	    wl->afh_info.ch == ch &&
-	    wl->afh_info.bw == bw &&
-	    b->link_cnt.last == b->link_cnt.now) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): return because no change!\n",
-			    __func__);
+	return bw;
+}
+
+static void _set_wl_ch_map(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_afh_info *afh;
+	u16 ch_start, ch_end, i;
+	u8 b_group, b_pos; /* byte-group, bit-position */
+	u8 hwb;
+
+	if (wl->afh_info[RTW89_MAC_0][RTW89_BAND_2G].en &&
+	    wl->afh_info[RTW89_MAC_1][RTW89_BAND_2G].en) {
+		/* select wilder bw if 1+1 */
+		if (wl->afh_info[RTW89_MAC_1][RTW89_BAND_2G].bw >
+		    wl->afh_info[RTW89_MAC_0][RTW89_BAND_2G].bw)
+			hwb = RTW89_MAC_1;
+		else
+			hwb = RTW89_MAC_0;
+	} else if (wl->afh_info[RTW89_MAC_1][RTW89_BAND_2G].en) {
+		hwb = RTW89_MAC_1;
+	} else {
+		hwb = RTW89_MAC_0;
+	}
+
+	afh = &wl->afh_info[hwb][RTW89_BAND_2G];
+
+	/* focus on WL 2.4GHz link */
+	if (!afh->en || afh->band != RTW89_BAND_2G)
 		return;
+
+	memset(wl->ch_map, 0x0, sizeof(wl->ch_map));
+	memset(wl->ch_map_le, 0x0, sizeof(wl->ch_map_le));
+
+	ch_start = afh->ch * 5 + 2407 - afh->bw / 2;
+	ch_end = ch_start + afh->bw;
+
+	for (i = ch_start; i < ch_end; i++) {
+		if (i < 2402 || i > 2480)
+			continue;
+		b_group = (i - 2402) / 8;
+		b_pos = 7 - ((i - 2402) % 8);
+		wl->ch_map[b_group] |= BIT(b_pos);
+
+		if (i % 2)  /* BLE ch = even-freq (ex:2402,2404) */
+			continue;
+
+		b_group = (i - 2402) / 16;
+		b_pos = 7 - (((i - 2402) / 2) % 8);
+		wl->ch_map_le[b_group] |= BIT(b_pos);
 	}
+}
 
-	wl->afh_info.en = en;
-	wl->afh_info.ch = ch;
-	wl->afh_info.bw = bw;
+static u8 _get_w2b_fbd_ch(struct rtw89_dev *rtwdev,
+			  u8 bt_fb_band, u32 wl_vco_freq,
+			  u32 *ch_lo_bound, u32 *ch_up_bound)
+{
+	u32 ch_lo, ch_pup, ch_min, ch_max;
+	u8 out_of_range = 0;
+	s32 val_lo, val_up;
+	u32 vco_lo_in_KHz; /* VCO pulling lower bound */
+	u32 vco_up_in_KHz; /* VCO pulling Upper bound */
+	u32 freq_start;
 
-	_send_fw_cmd(rtwdev, BTFC_SET, SET_BT_WL_CH_INFO, &wl->afh_info, 3);
+	vco_lo_in_KHz = wl_vco_freq - BTC_VCO_GUARD_W2B * 1000; /* KHz */
+	vco_up_in_KHz = wl_vco_freq + BTC_VCO_GUARD_W2B * 1000;
 
-	rtw89_debug(rtwdev, RTW89_DBG_BTC,
-		    "[BTC], %s(): en=%d, ch=%d, bw=%d\n",
-		    __func__, en, ch, bw);
-	wl->wcnt[BTC_WCNT_CH_UPDATE]++;
+	switch (bt_fb_band) {
+	default:
+	case BTC_BT_B2G: /* BT 2GHz forbiddened Channel */
+		val_lo = vco_lo_in_KHz * BTC_LO_2G_DNM / BTC_LO_2G_NMR;
+		val_up = vco_up_in_KHz * BTC_LO_2G_DNM / BTC_LO_2G_NMR;
+		freq_start = BTC_FREQ_B2G * 1000; /* KHz */
+		ch_min = BTC_CH_B2G_MIN;
+		ch_max = BTC_CH_B2G_MAX;
+		break;
+	case BTC_BT_B5G: /* BT 5/6GHz forbiddened Channel */
+		val_lo = vco_lo_in_KHz * BTC_LO_6G_DNM / BTC_LO_6G_NMR;
+		val_up = vco_up_in_KHz * BTC_LO_6G_DNM / BTC_LO_6G_NMR;
+		freq_start = BTC_FREQ_B6G * 1000; /* KHz */
+		ch_min = BTC_CH_B5G_MIN;
+		ch_max = BTC_CH_B5G_MAX;
+		break;
+	}
+
+	/* Search forbiddened Channel (un-process range)*/
+	ch_lo = (val_lo - freq_start) / 1000;
+	if ((val_lo - freq_start) % 1000 != 0) /* Round-UP */
+		ch_lo++;
+
+	ch_pup = (val_up - freq_start) / 1000; /* Round-down */
+
+	/* Search forbiddened Channel */
+	if (ch_lo > ch_max || ch_pup < ch_min) { /* out-of-range -> NA */
+		out_of_range = 1;
+		*ch_lo_bound = 0;
+		*ch_up_bound = 0;
+	}
+
+	if (ch_lo < ch_min)
+		*ch_lo_bound = ch_min;
+	else if (ch_lo <= ch_max)
+		*ch_lo_bound = ch_lo;
+
+	if (ch_pup > ch_max)
+		*ch_up_bound = ch_max;
+	else if (ch_pup >= ch_min)
+		*ch_up_bound = ch_pup;
+
+	if (bt_fb_band == BTC_BT_B5G) { /* BT ch is 8MHz-spacing for 5/6GHz */
+		*ch_lo_bound = *ch_lo_bound / 8; /* low-bound -> Round-down */
+
+		if (*ch_up_bound % 8 != 0) /* Up-bound -> cover wider range */
+			*ch_up_bound = *ch_up_bound / 8 + 1;
+		else
+			*ch_up_bound = *ch_up_bound / 8;
+	}
+
+	return out_of_range;
 }
 
-static void _set_bt_afh_info_v1(struct rtw89_dev *rtwdev)
+static void _set_wl_ch_info(struct rtw89_dev *rtwdev)
+{
+	static const u8 path_hwb[BTC_RF_NUM] = {RTW89_PHY_0, RTW89_PHY_1};
+	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
+	struct rtw89_btc_cx *cx = &rtwdev->btc.cx;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
+	u32 vco_freq, ch_lo = 0, ch_up = 0;
+	u16 rf_band, freq, f_diff;
+	u8 i, j, ch;
+
+	if (!(rtwdev->chip->para_ver & BTC_FEAT_MULTI_PTA)) /* only new-PTA require setup */
+		return;
+
+	for (i = RTW89_PHY_0; i <= RTW89_PHY_1; i++) {
+		if (wl->mlo_info.wmode[i] == RTW89_MR_WMODE_NONE) { /* no-connect */
+			dm->ost_info.rf_center_freq[i] = 0;
+			dm->ost_info.fbd_group_en[i][0] = 0;
+			dm->ost_info.fbd_group_en[i][1] = 0;
+			dm->ost_info.fbd_group_bound[i][0] = 0;
+			dm->ost_info.fbd_group_bound[i][1] = 0;
+			continue;
+		}
+
+		ch = wl->rf_ch_info[i].center_ch;
+		switch (wl->rf_ch_info[i].band) {
+		case RTW89_BAND_2G:
+		default:
+			rf_band = 0;
+			if (ch == 14)
+				freq = BTC_FREQ_W2G_CH14;
+			else
+				freq = BTC_FREQ_W2G + (ch - 1) * 5;
+			vco_freq = freq * 1000 * BTC_LO_2G_NMR / BTC_LO_2G_DNM;
+			break;
+		case RTW89_BAND_5G:
+			rf_band = BIT(15);
+			freq = BTC_FREQ_W5G + (ch - 1) * 5;
+			vco_freq = freq * 1000 * BTC_LO_5G_NMR / BTC_LO_5G_DNM;
+			break;
+		case RTW89_BAND_6G:
+			rf_band = BIT(15);
+			freq = BTC_FREQ_W6G + (ch - 1) * 5;
+			vco_freq = freq * 1000 * BTC_LO_6G_NMR / BTC_LO_6G_DNM;
+			break;
+		}
+
+		dm->ost_info.rf_center_freq[i] = rf_band + freq;
+
+		for (j = BTC_BT_B2G; j <= BTC_BT_B5G; j++) {
+			/* no WL->BT forbidden channel */
+			if (_get_w2b_fbd_ch(rtwdev, j, vco_freq, &ch_lo, &ch_up)) {
+				dm->ost_info.fbd_group_en[i][j] = j << 1;
+				dm->ost_info.fbd_group_bound[i][j] = 0;
+				continue;
+			}
+
+			dm->ost_info.fbd_group_en[i][j] = (j << 1) + 0x1;
+			dm->ost_info.fbd_group_bound[i][j] = (ch_up << 8) + ch_lo;
+		}
+	}
+
+	for (i = BTC_RF_S0; i <= BTC_RF_S1; i++) {
+		for (j = BTC_BT_1ST; j <= BTC_BT_EXT; j++) {
+			/*
+			 * If WL & BT share same ANT/Path, set freq-diff > 2GHz,
+			 * because TDD will always run in 5/6GHz band.
+			 * Otherwise, the frq-diff thres is decided by the RF
+			 * out-of-channel rejection capability.
+			 */
+			if (dm->ant_xmap[i][j])
+				f_diff = 0x7ff; /* 2047MHz */
+			else
+				f_diff = rtwdev->chip->fdd_iso_freq;
+
+			dm->ost_info.freq_diff_thres[path_hwb[i]][j] = f_diff;
+		}
+	}
+}
+
+static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
-	struct rtw89_btc_wl_afh_info *wl_afh = &wl->afh_info;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
+	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_rlink *rlink;
-	u8 en = 0, ch = 0, bw = 0, buf[3] = {};
-	u8 i, j, link_mode;
+	u8 h2c_func, hwb, bt_link_chg;
+	u8 i, j, sz, bw;
+	u8 buf[4];
 
-	if (btc->manual_ctrl || wl->status.map.scan)
+	if (btc->manual_ctrl || wl->status.map.rf_off ||
+	    (wl->status.val & btc_scanning_map.val))
 		return;
 
-	link_mode = wl_rinfo->link_mode;
+	memset(wl->afh_info, 0, sizeof(wl->afh_info));
 
-	for (i = 0; i < btc->ver->max_role_num; i++) {
-		for (j = RTW89_MAC_0; j < RTW89_MAC_NUM; j++) {
-			if (wl->status.map.rf_off || bt->whql_test ||
-			    link_mode == BTC_WLINK_NOLINK ||
-			    link_mode == BTC_WLINK_5G)
-				break;
+	for (j = RTW89_MAC_0; j < RTW89_MAC_NUM; j++) {
+		/* skip HW-Band if no fdd/fdd bind */
+		if ((!(btc->dm.tdd_bind.wl_hwb_sel & BIT(j))) &&
+		    (!(btc->dm.fdd_bind.wl_hwb_sel & BIT(j))))
+			continue;
 
+		for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
 			rlink = &wl_rinfo->rlink[i][j];
 
-			/* Don't care no-connected/non-2G-band role */
+			/* Skip no-active case */
 			if (!rlink->connected || !rlink->active ||
-			    rlink->rf_band != RTW89_BAND_2G)
+			    rlink->rf_band >= RTW89_BAND_NUM)
 				continue;
 
-			en = 1;
-			ch = rlink->ch;
-			bw = rlink->bw;
+			/* In addition to AP/P2P, skip if same-rf-band*/
+			if (wl->afh_info[j][rlink->rf_band].en &&
+			    (rlink->role != RTW89_WIFI_ROLE_AP &&
+			     rlink->role != RTW89_WIFI_ROLE_P2P_GO &&
+			     rlink->role != RTW89_WIFI_ROLE_P2P_CLIENT))
+				continue;
 
-			if (link_mode == BTC_WLINK_2G_MCC &&
-			    (rlink->role == RTW89_WIFI_ROLE_AP ||
-			     rlink->role == RTW89_WIFI_ROLE_P2P_GO ||
-			     rlink->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
-				/* for 2.4G MCC, take role = ap/go/gc */
-				break;
-			} else if (link_mode != BTC_WLINK_2G_SCC ||
-				   rlink->bw == RTW89_CHANNEL_WIDTH_40) {
-				/* for 2.4G scc, take bw = 40M */
-				break;
-			}
+			bw = _get_wl_guard_bw(rtwdev, rlink->bw);
+			wl->afh_info[j][rlink->rf_band].en = 1;
+			wl->afh_info[j][rlink->rf_band].ch = rlink->ch;
+			wl->afh_info[j][rlink->rf_band].bw = bw;
+			wl->afh_info[j][rlink->rf_band].band = rlink->rf_band;
 		}
 	}
 
-	/* default AFH channel sapn = center-ch +- 6MHz */
-	switch (bw) {
-	case RTW89_CHANNEL_WIDTH_20:
-		if (btc->dm.freerun || btc->dm.fddt_train)
-			bw = 48;
-		else
-			bw = 20 + chip->afh_guard_ch * 2;
-		break;
-	case RTW89_CHANNEL_WIDTH_40:
-		if (btc->dm.freerun)
-			bw = 40 + chip->afh_guard_ch * 2;
-		else
-			bw = 40;
-		break;
-	case RTW89_CHANNEL_WIDTH_5:
-		bw = 5 + chip->afh_guard_ch * 2;
-		break;
-	case RTW89_CHANNEL_WIDTH_10:
-		bw = 10 + chip->afh_guard_ch * 2;
-		break;
-	default:
-		en = false; /* turn off AFH info if invalid BW */
-		bw = 0;
-		ch = 0;
-		break;
-	}
+	for (j = RTW89_BAND_2G; j < RTW89_BAND_NUM; j++) {
+		/* skip non-2.4GHz if BT is 2.4GHz only*/
+		if (!(rtwdev->chip->para_ver &  BTC_FEAT_BT_6G)) {
+			if (j != RTW89_BAND_2G)
+				continue;
+			sz = 3;
+		} else {
+			sz = 4;
+		}
 
-	if (!en || ch > 14 || ch == 0) {
-		en = false;
-		bw = 0;
-		ch = 0;
-	}
+		if (wl->afh_info[RTW89_MAC_0][j].en &&
+		    wl->afh_info[RTW89_MAC_1][j].en) {
+			/* select wilder bw if 1+1 */
+			if (wl->afh_info[RTW89_MAC_1][j].bw >
+			    wl->afh_info[RTW89_MAC_0][j].bw)
+				hwb = RTW89_MAC_1;
+			else
+				hwb = RTW89_MAC_0;
+		} else if (wl->afh_info[RTW89_MAC_1][j].en) {
+			hwb = RTW89_MAC_1;
+		} else {
+			hwb = RTW89_MAC_0;
+		}
 
-	if (wl_afh->en == en &&
-	    wl_afh->ch == ch &&
-	    wl_afh->bw == bw &&
-	    (!bt->enable.now || bt->enable.last))
-		return;
+		if (j == RTW89_BAND_2G) {
+			if (cx->bt0.link_info.link_cnt.chg ||
+			    cx->bt1.link_info.link_cnt.chg)
+				bt_link_chg = 1;
+			else
+				bt_link_chg = 0;
+		} else {
+			if (cx->bt0.link_info_56g.link_cnt.chg ||
+			    cx->bt1.link_info_56g.link_cnt.chg)
+				bt_link_chg = 1;
+			else
+				bt_link_chg = 0;
+		}
+
+		/* return if no-afh-info-change/no wl-bt link change */
+		if (!memcmp(&wl->afh_info_last[hwb][j],
+			    &wl->afh_info[hwb][j],
+			    sizeof(struct rtw89_btc_wl_afh_info)) &&
+			    !bt_link_chg &&
+			    !wl->link_mode_chg)
+			continue;
+
+		memcpy(&wl->afh_info_last[hwb][j],
+		       &wl->afh_info[hwb][j],
+		       sizeof(struct rtw89_btc_wl_afh_info));
+
+		buf[0] = wl->afh_info[hwb][j].en;
+		buf[1] = wl->afh_info[hwb][j].ch;
+		buf[2] = wl->afh_info[hwb][j].bw;
+		buf[3] = wl->afh_info[hwb][j].band;
+
+		h2c_func = SET_BT_WL_CH_INFO;
+		if (cx->bt0.enable.now)
+			_send_fw_cmd(rtwdev, BTFC_SET, h2c_func, buf, sz);
 
-	wl_afh->en = buf[0];
-	wl_afh->ch = buf[1];
-	wl_afh->bw = buf[2];
+		/* send mailbox to 2nd-BT if exist */
+		if (cx->bt1.enable.now) {
+			h2c_func |= BT_H2C_FUNC_BT2ND;
+			_send_fw_cmd(rtwdev, BTFC_SET, h2c_func, buf, sz);
+		}
 
-	if (_send_fw_cmd(rtwdev, BTFC_SET, SET_BT_WL_CH_INFO, &wl->afh_info, 3)) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): en=%d, ch=%d, bw=%d\n",
-			    __func__, en, ch, bw);
+			    "[BTC], %s(): en=%d, ch=%d, bw=%d, rf_band=%d\n",
+			    __func__, buf[0], buf[1], buf[2], buf[3]);
 
 		wl->wcnt[BTC_WCNT_CH_UPDATE]++;
+
+		/* ToDo: Remove if BT update new-define to support 6GHz */
+		if (j == RTW89_BAND_2G)
+			break;
 	}
-}
 
-static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
-{
-	if (rtwdev->chip->chip_id == RTL8922A)
-		_set_bt_afh_info_v1(rtwdev);
-	else
-		_set_bt_afh_info_v0(rtwdev);
+	/* for AFH map display in coex log */
+	_set_wl_ch_map(rtwdev);
+
+	/* set HWB center-ch/forbidden group to ost_info for CR setup in FW */
+	_set_wl_ch_info(rtwdev);
 }
 
 static bool _check_freerun(struct rtw89_dev *rtwdev)
@@ -3828,39 +3934,24 @@ static bool _check_freerun(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
-	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
-	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
-	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	struct rtw89_btc_bt_hid_desc *hid = &bt_linfo->hid_desc;
 	union rtw89_btc_module_info *md = &btc->mdinfo;
 	const struct rtw89_btc_ver *ver = btc->ver;
-	u8 isolation, connect_cnt = 0;
+	u8 isolation;
 
 	if (ver->fcxinit == 7)
 		isolation = md->md_v7.ant.isolation;
 	else
 		isolation = md->md.ant.isolation;
 
-	if (ver->fwlrole == 0)
-		connect_cnt = wl_rinfo->connect_cnt;
-	else if (ver->fwlrole == 1)
-		connect_cnt = wl_rinfo_v1->connect_cnt;
-	else if (ver->fwlrole == 2)
-		connect_cnt = wl_rinfo_v2->connect_cnt;
-	else if (ver->fwlrole == 7)
-		connect_cnt = wl_rinfo_v7->connect_cnt;
-	else if (ver->fwlrole == 8)
-		connect_cnt = wl_rinfo_v8->connect_cnt;
-
 	if (btc->ant_type == BTC_ANT_SHARED) {
 		btc->dm.trx_para_level = 0;
 		return false;
 	}
 
 	/* The below is dedicated antenna case */
-	if (connect_cnt > BTC_TDMA_WLROLE_MAX) {
+	if (wl_rinfo->connect_cnt > BTC_TDMA_WLROLE_MAX) {
 		btc->dm.trx_para_level = 5;
 		return true;
 	}
@@ -4097,11 +4188,26 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 	case BTC_CXP_OFFB: /* TDMA off + beacon protect */
 		tdma_on = false;
 		*t = t_def[CXTD_OFF_B2];
-		s[CXST_OFF] = s_def[CXST_OFF];
+		_slot_set_le(btc, CXST_OFF, s_def[CXST_OFF].dur,
+			     s_def[CXST_OFF].cxtbl, s_def[CXST_OFF].cxtype);
+		_slot_set(btc, CXST_B2, 10, cxtbl[1], SLOT_ISO);
+
 		switch (policy_type) {
 		case BTC_CXP_OFFB_BWB0:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[5]);
+			break;
+		case BTC_CXP_OFFB_BWB1:
 			_slot_set_tbl(btc, CXST_OFF, cxtbl[8]);
 			break;
+		case BTC_CXP_OFFB_BWB2:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[7]);
+			break;
+		case BTC_CXP_OFFB_BWB3:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[6]);
+			break;
+		case BTC_CXP_OFFB_BWB4:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[2]);
+			break;
 		}
 		break;
 	case BTC_CXP_OFFE: /* TDMA off + beacon protect + Ext_control */
@@ -4182,7 +4288,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 	case BTC_CXP_PFIX: /* PS-TDMA Fix-Slot */
 		tdma_on = true;
 		*t = t_def[CXTD_PFIX];
-		if (btc->cx.wl.role_info.role_map.role.ap)
+		if (btc->cx.wl.role_info.role_map  & BIT(RTW89_WIFI_ROLE_AP))
 			_tdma_set_flctrl(btc, CXFLC_QOSNULL);
 
 		switch (policy_type) {
@@ -4461,12 +4567,23 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		*t = t_def[CXTD_OFF_B2];
 		_slot_set_le(btc, CXST_OFF, s_def[CXST_OFF].dur,
 			     s_def[CXST_OFF].cxtbl, s_def[CXST_OFF].cxtype);
+		_slot_set(btc, CXST_B2, 10, cxtbl[1], SLOT_ISO);
 
 		switch (policy_type) {
 		case BTC_CXP_OFFB_BWB0:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[5]);
+			break;
+		case BTC_CXP_OFFB_BWB1:
 			_slot_set_tbl(btc, CXST_OFF, cxtbl[8]);
 			break;
-		default:
+		case BTC_CXP_OFFB_BWB2:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[7]);
+			break;
+		case BTC_CXP_OFFB_BWB3:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[6]);
+			break;
+		case BTC_CXP_OFFB_BWB4:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[2]);
 			break;
 		}
 		break;
@@ -4841,35 +4958,17 @@ static void _set_ant_v0(struct rtw89_dev *rtwdev, bool force_exec,
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_role_info *r = &btc->cx.wl.role_info;
 	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
-	u8 gwl, gwl0, gwl1, gbt, plt_ctrl, i, dbcc_2g_phy, b2g = 0;
-	bool dbcc_chg = false, dbcc_en = false;
+	u8 gwl, gwl0, gwl1, gbt, plt_ctrl, i, b2g = 0;
 	u32 ant_path_type;
 
 	ant_path_type = ((phy_map << 8) + type);
 
-	if (btc->ver->fwlrole == 1) {
-		dbcc_chg = wl->role_info_v1.dbcc_chg;
-		dbcc_en = wl->role_info_v1.dbcc_en;
-		dbcc_2g_phy = wl->role_info_v1.dbcc_2g_phy;
-	} else if (btc->ver->fwlrole == 2) {
-		dbcc_chg = wl->role_info_v2.dbcc_chg;
-		dbcc_en = wl->role_info_v2.dbcc_en;
-		dbcc_2g_phy = wl->role_info_v2.dbcc_2g_phy;
-	} else if (btc->ver->fwlrole == 7) {
-		dbcc_chg = wl->role_info_v7.dbcc_chg;
-		dbcc_en = wl->role_info_v7.dbcc_en;
-		dbcc_2g_phy = wl->role_info_v7.dbcc_2g_phy;
-	} else if (btc->ver->fwlrole == 8) {
-		dbcc_chg = wl->role_info_v8.dbcc_chg;
-		dbcc_en = wl->role_info_v8.dbcc_en;
-		dbcc_2g_phy = wl->role_info_v8.dbcc_2g_phy;
-	}
-
 	if (btc->dm.run_reason == BTC_RSN_NTFY_POWEROFF ||
 	    btc->dm.run_reason == BTC_RSN_NTFY_RADIO_STATE ||
-	    btc->dm.run_reason == BTC_RSN_CMD_SET_COEX || dbcc_chg)
+	    btc->dm.run_reason == BTC_RSN_CMD_SET_COEX || r->dbcc_chg)
 		force_exec = FC_EXEC;
 
 	if (!force_exec && ant_path_type == dm->set_ant_path) {
@@ -4967,12 +5066,12 @@ static void _set_ant_v0(struct rtw89_dev *rtwdev, bool force_exec,
 	default:
 		gbt = BTC_GNT_HW;
 		if ((rtwdev->chip->para_ver & BTC_FEAT_MULTI_PTA) ||
-		    !dbcc_en) {
+		    !r->dbcc_en) {
 			gwl = BTC_GNT_HW;
 			_set_gnt(rtwdev, BTC_PHY_ALL, gwl, gbt);
 		} else {
 			/* for DBCC Only-1-PTA */
-			if (dbcc_2g_phy == RTW89_PHY_0) {
+			if (r->dbcc_2g_phy == RTW89_PHY_0) {
 				gwl0 = BTC_GNT_HW;
 				gwl1 = BTC_GNT_SW_HI;
 			} else {
@@ -4994,7 +5093,7 @@ static void _set_ant_v1(struct rtw89_dev *rtwdev, bool force_exec,
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
+	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	u32 ant_path_type = rtw89_get_antpath_type(phy_map, type);
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 	struct rtw89_btc_dm *dm = &btc->dm;
@@ -5005,7 +5104,7 @@ static void _set_ant_v1(struct rtw89_dev *rtwdev, bool force_exec,
 	    btc->dm.run_reason == BTC_RSN_CMD_SET_COEX || wl_rinfo->dbcc_chg)
 		force_exec = FC_EXEC;
 
-	if (wl_rinfo->link_mode != BTC_WLINK_25G_MCC &&
+	if (wl_rinfo->link_mode != BTC_WLINK_DB_MCC &&
 	    btc->dm.wl_btg_rx == 2)
 		force_exec = FC_EXEC;
 
@@ -5111,7 +5210,7 @@ static void _set_ant_v1(struct rtw89_dev *rtwdev, bool force_exec,
 static void _set_ant(struct rtw89_dev *rtwdev, bool force_exec,
 		     u8 phy_map, u8 type)
 {
-	if (rtwdev->chip->chip_id == RTL8922A)
+	if (rtwdev->chip->chip_id >= RTL8922A)
 		_set_ant_v1(rtwdev, force_exec, phy_map, type);
 	else
 		_set_ant_v0(rtwdev, force_exec, phy_map, type);
@@ -5134,29 +5233,24 @@ static void _action_wl_init(struct rtw89_dev *rtwdev)
 static void _action_wl_off(struct rtw89_dev *rtwdev, u8 mode)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): !!\n", __func__);
 
-	if (wl->status.map.rf_off || btc->dm.bt_only) {
+	if (wl->status.map.rf_off || btc->dm.bt_only)
 		_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_WOFF);
-	} else if (wl->status.map.lps == BTC_LPS_RF_ON) {
-		if (mode == BTC_WLINK_5G)
-			_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_W5G);
-		else
-			_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
-	}
+	else if (wl->status.map.lps == BTC_LPS_RF_ON ||
+		 cx->bt0.whql_test || cx->bt1.whql_test)
+		_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_PTA);
 
-	if (mode == BTC_WLINK_5G) {
+	if (dm->out_of_band)
 		_set_policy(rtwdev, BTC_CXP_OFF_EQ0, BTC_ACT_WL_OFF);
-	} else if (wl->status.map.lps == BTC_LPS_RF_ON) {
-		if (btc->cx.bt0.link_info.a2dp_desc.active)
-			_set_policy(rtwdev, BTC_CXP_OFF_BT, BTC_ACT_WL_OFF);
-		else
-			_set_policy(rtwdev, BTC_CXP_OFF_BWB1, BTC_ACT_WL_OFF);
-	} else {
+	else if (cx->bt0.whql_test || cx->bt1.whql_test)
+		_set_policy(rtwdev, BTC_CXP_OFFB_BWB4, BTC_ACT_WL_OFF);
+	else
 		_set_policy(rtwdev, BTC_CXP_OFF_BT, BTC_ACT_WL_OFF);
-	}
 }
 
 static void _action_freerun(struct rtw89_dev *rtwdev)
@@ -5563,48 +5657,29 @@ static void _action_wl_rfk(struct rtw89_dev *rtwdev)
 static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_fbtc_outsrc_set_info *o_info = &dm->ost_info;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
-	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
-	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
-	struct rtw89_btc_fbtc_outsrc_set_info *o_info = &btc->dm.ost_info;
-	struct rtw89_btc_wl_role_info *wl_rinfo_v0 = &wl->role_info;
+	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
-	struct rtw89_btc_dm *dm = &btc->dm;
-	struct _wl_rinfo_now wl_rinfo;
 	u32 is_btg = BTC_BTGCTRL_DISABLE;
 
 	if (btc->manual_ctrl)
 		return;
 
-	if (ver->fwlrole == 0)
-		wl_rinfo.link_mode = wl_rinfo_v0->link_mode;
-	else if (ver->fwlrole == 1)
-		wl_rinfo.link_mode = wl_rinfo_v1->link_mode;
-	else if (ver->fwlrole == 2)
-		wl_rinfo.link_mode = wl_rinfo_v2->link_mode;
-	else if (ver->fwlrole == 7)
-		wl_rinfo.link_mode = wl_rinfo_v7->link_mode;
-	else if (ver->fwlrole == 8)
-		wl_rinfo.link_mode = wl_rinfo_v8->link_mode;
-	else
-		return;
-
 	/* notify halbb ignore GNT_BT or not for WL BB Rx-AGC control */
 	if (btc->ant_type == BTC_ANT_SHARED) {
 		if (!(bt->run_patch_code && bt->enable.now))
 			is_btg = BTC_BTGCTRL_DISABLE;
-		else if (wl_rinfo.link_mode != BTC_WLINK_5G)
+		else if (wl_rinfo->link_mode_v0 != BTC_WLINK_V0_5G)
 			is_btg = BTC_BTGCTRL_ENABLE;
 		else
 			is_btg = BTC_BTGCTRL_DISABLE;
 
 		/* bb call ctrl_btg() in WL FW by slot */
-		if (!ver->fcxosi &&
-		    wl_rinfo.link_mode == BTC_WLINK_25G_MCC)
+		if (!btc->ver->fcxosi &&
+		    wl_rinfo->link_mode_v0 == BTC_WLINK_V0_25G_MCC)
 			is_btg = BTC_BTGCTRL_BB_GNT_FWCTRL;
 	}
 
@@ -5614,7 +5689,7 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 		dm->wl_btg_rx = is_btg;
 
 	/* skip setup if btg_ctrl set by wl fw */
-	if (!ver->fcxosi && is_btg > BTC_BTGCTRL_ENABLE)
+	if (!btc->ver->fcxosi && is_btg > BTC_BTGCTRL_ENABLE)
 		return;
 
 	/* Below flow is for BTC_FEAT_NEW_BBAPI_FLOW = 1 */
@@ -5633,7 +5708,7 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 		o_info->btg_rx[BTC_RF_S1] = is_btg;
 	}
 
-	if (ver->fcxosi)
+	if (btc->ver->fcxosi)
 		return;
 
 	chip->ops->ctrl_btg_bt_rx(rtwdev, o_info->btg_rx[BTC_RF_S0],
@@ -5651,40 +5726,20 @@ static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_fbtc_outsrc_set_info *o_info = &btc->dm.ost_info;
 	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt0.link_info;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_role_info_v2 *rinfo_v2 = &wl->role_info_v2;
-	struct rtw89_btc_wl_role_info_v7 *rinfo_v7 = &wl->role_info_v7;
-	struct rtw89_btc_wl_role_info_v8 *rinfo_v8 = &wl->role_info_v8;
+	struct rtw89_btc_wl_role_info *rinfo = &wl->role_info;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	u8 is_preagc, val, link_mode, dbcc_2g_phy;
-	u8 role_ver = rtwdev->btc.ver->fwlrole;
-	bool dbcc_en;
+	u8 is_preagc, val;
 
 	if (btc->manual_ctrl)
 		return;
 
-	if (role_ver == 2) {
-		dbcc_en = rinfo_v2->dbcc_en;
-		link_mode = rinfo_v2->link_mode;
-		dbcc_2g_phy = rinfo_v2->dbcc_2g_phy;
-	} else if (role_ver == 7) {
-		dbcc_en = rinfo_v7->dbcc_en;
-		link_mode = rinfo_v7->link_mode;
-		dbcc_2g_phy = rinfo_v7->dbcc_2g_phy;
-	} else if (role_ver == 8) {
-		dbcc_en = rinfo_v8->dbcc_en;
-		link_mode = rinfo_v8->link_mode;
-		dbcc_2g_phy = rinfo_v7->dbcc_2g_phy;
-	} else {
-		return;
-	}
-
 	if (!(bt->run_patch_code && bt->enable.now)) {
 		is_preagc = BTC_PREAGC_DISABLE;
-	} else if (link_mode == BTC_WLINK_5G) {
+	} else if (dm->tdd_bind.rf_band == BIT(RTW89_BAND_5G)) {
 		is_preagc = BTC_PREAGC_DISABLE;
-	} else if (link_mode == BTC_WLINK_NOLINK ||
+	} else if (rinfo->link_mode == BTC_WLINK_NOLINK ||
 		 btc->cx.bt0.link_info.link_cnt.now == 0) {
 		is_preagc = BTC_PREAGC_DISABLE;
 	} else if (dm->tdma_now.type != CXTDMA_OFF &&
@@ -5692,7 +5747,7 @@ static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 		 !bt_linfo->hid_desc.exist &&
 		 dm->fddt_train == BTC_FDDT_DISABLE) {
 		is_preagc = BTC_PREAGC_DISABLE;
-	} else if (dbcc_en && (dbcc_2g_phy != RTW89_PHY_1)) {
+	} else if (rinfo->dbcc_en && (rinfo->dbcc_2g_phy != RTW89_PHY_1)) {
 		is_preagc = BTC_PREAGC_DISABLE;
 	} else if (btc->ant_type == BTC_ANT_SHARED) {
 		is_preagc = BTC_PREAGC_DISABLE;
@@ -5700,7 +5755,7 @@ static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 		is_preagc = BTC_PREAGC_ENABLE;
 	}
 
-	if (!btc->ver->fcxosi && link_mode == BTC_WLINK_25G_MCC)
+	if (!btc->ver->fcxosi && rinfo->link_mode == BTC_WLINK_DB_MCC)
 		is_preagc = BTC_PREAGC_BB_FWCTRL;
 
 	if (dm->wl_pre_agc_rb != dm->wl_pre_agc &&
@@ -5771,10 +5826,7 @@ static void __rtw89_tx_time_iter(struct rtw89_vif_link *rtwvif_link,
 	u16 enable = iter_data->enable;
 	bool reenable = iter_data->reenable;
 
-	if (btc->ver->fwlrole == 8)
-		plink = &wl->rlink_info[port][0];
-	else
-		plink = &wl->link_info[port];
+	plink = &wl->rlink_info[port][rtwsta_link->link_id];
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): port = %d\n", __func__, port);
@@ -5840,39 +5892,23 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_bt_hfp_desc *hfp = &b->hfp_desc;
 	struct rtw89_btc_bt_hid_desc *hid = &b->hid_desc;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
-	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
-	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
-	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_txtime_data data = {.rtwdev = rtwdev};
-	u8 mode, igno_bt, tx_retry;
+	bool reenable = false;
+	u8 igno_bt, tx_retry;
 	u32 tx_time;
 	u16 enable;
-	bool reenable = false;
 
 	if (btc->manual_ctrl)
 		return;
 
-	if (ver->fwlrole == 0)
-		mode = wl_rinfo->link_mode;
-	else if (ver->fwlrole == 1)
-		mode = wl_rinfo_v1->link_mode;
-	else if (ver->fwlrole == 2)
-		mode = wl_rinfo_v2->link_mode;
-	else if (ver->fwlrole == 7)
-		mode = wl_rinfo_v7->link_mode;
-	else if (ver->fwlrole == 8)
-		mode = wl_rinfo_v8->link_mode;
-	else
-		return;
-
 	if (ver->fcxctrl == 7)
 		igno_bt = btc->ctrl.ctrl_v7.igno_bt;
 	else
 		igno_bt = btc->ctrl.ctrl.igno_bt;
 
 	if (btc->dm.freerun || igno_bt || b->link_cnt.now == 0 ||
-	    mode == BTC_WLINK_5G || mode == BTC_WLINK_NOLINK) {
+	    dm->tdd_bind.rf_band == BIT(RTW89_BAND_5G) ||
+	    wl_rinfo->link_mode == BTC_WLINK_NOLINK) {
 		enable = 0;
 		tx_time = BTC_MAX_TX_TIME_DEF;
 		tx_retry = BTC_MAX_TX_RETRY_DEF;
@@ -5915,31 +5951,12 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
-	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
-	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
-	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	bool bt_hi_lna_rx = false;
-	u8 mode;
 
-	if (ver->fwlrole == 0)
-		mode = wl_rinfo->link_mode;
-	else if (ver->fwlrole == 1)
-		mode = wl_rinfo_v1->link_mode;
-	else if (ver->fwlrole == 2)
-		mode = wl_rinfo_v2->link_mode;
-	else if (ver->fwlrole == 7)
-		mode = wl_rinfo_v7->link_mode;
-	else if (ver->fwlrole == 8)
-		mode = wl_rinfo_v8->link_mode;
-	else
-		return;
-
-	if (mode != BTC_WLINK_NOLINK && btc->dm.wl_btg_rx)
+	if (wl_rinfo->link_mode != BTC_WLINK_NOLINK && btc->dm.wl_btg_rx)
 		bt_hi_lna_rx = true;
 
 	if (bt_hi_lna_rx == bt->hi_lna_rx)
@@ -5985,20 +6002,51 @@ static void _wl_req_mac(struct rtw89_dev *rtwdev, u8 mac)
 		rtw89_write32_set(rtwdev, add, B_AX_WL_SRC);
 }
 
-static void _action_common(struct rtw89_dev *rtwdev)
+static void _update_zb_coex_tbl(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_role_info_v8 *rinfo_v8 = &wl->role_info_v8;
-	struct rtw89_btc_wl_smap *wl_smap = &wl->status.map;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
-	struct rtw89_btc_dm *dm = &btc->dm;
-	u32 bt_rom_code_id, bt_fw_ver;
-	u8 i;
-
-	if (btc->ver->fwlrole == 8)
-		_wl_req_mac(rtwdev, rinfo_v8->pta_req_band);
+	const struct rtw89_btc_ver *ver = btc->ver;
+	u32 zb_tbl0 = 0xda5a5a5a, zb_tbl1 = 0xda5a5a5a;
+	u8 link_mode_chg = btc->cx.wl.link_mode_chg;
+	u8 mode = btc->cx.wl.role_info.link_mode;
+	u8 wa_type;
+
+	if (btc->dm.run_reason != BTC_RSN_NTFY_INIT && !link_mode_chg)
+		return;
+
+	if (ver->fcxinit == 7)
+		wa_type = btc->mdinfo.md_v7.wa_type;
+	else
+		wa_type = btc->mdinfo.md.wa_type;
 
+	if (!(wa_type & BTC_WA_HFP_ZB))
+		return;
+
+	if (btc->dm.tdd_bind.rf_band == BIT(RTW89_BAND_5G) ||
+	    rtwdev->btc.dm.freerun) {
+		zb_tbl0 = 0xffffffff;
+		zb_tbl1 = 0xffffffff;
+	} else if (mode == BTC_WLINK_DB_MCC) {
+		zb_tbl0 = 0xffffffff; /* for E5G slot */
+		zb_tbl1 = 0xda5a5a5a; /* for E2G slot */
+	}
+	rtw89_write32(rtwdev, R_BTC_ZB_COEX_TBL_0, zb_tbl0);
+	rtw89_write32(rtwdev, R_BTC_ZB_COEX_TBL_1, zb_tbl1);
+}
+
+static void _action_common(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_role_info *rinfo = &wl->role_info;
+	struct rtw89_btc_wl_smap *wl_smap = &wl->status.map;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u32 bt_rom_code_id, bt_fw_ver;
+	u8 i;
+
+	_wl_req_mac(rtwdev, rinfo->pta_req_band);
+	_update_zb_coex_tbl(rtwdev);
 	_set_btg_ctrl(rtwdev);
 	_set_wl_preagc_ctrl(rtwdev);
 	_set_wl_tx_limit(rtwdev);
@@ -6041,7 +6089,10 @@ static void _action_common(struct rtw89_dev *rtwdev)
 	}
 	dm->tdma_instant_excute = 0;
 	dm->lps_ctrl_change = false;
+	wl->role_info.link_mode_chg = 0;
 	wl->pta_reg_mac_chg = false;
+	dm->pre_agc_chg = false;
+	wl->dbcc_chg = 0;
 }
 
 static void _action_by_bt(struct rtw89_dev *rtwdev)
@@ -6407,473 +6458,29 @@ void _update_dbcc_band(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 		btc->cx.wl.dbcc_info.op_band[phy_idx];
 }
 
-static void _update_wl_info(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_link_info *wl_linfo = wl->link_info;
-	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
-	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
-	u8 i, cnt_connect = 0, cnt_connecting = 0, cnt_active = 0;
-	u8 cnt_2g = 0, cnt_5g = 0, phy;
-	u32 wl_2g_ch[2] = {0}, wl_5g_ch[2] = {0};
-	bool b2g = false, b5g = false, client_joined = false;
-
-	memset(wl_rinfo, 0, sizeof(*wl_rinfo));
-
-	for (i = 0; i < RTW89_PORT_NUM; i++) {
-		/* check if role active? */
-		if (!wl_linfo[i].active)
-			continue;
-
-		cnt_active++;
-		wl_rinfo->active_role[cnt_active - 1].role = wl_linfo[i].role;
-		wl_rinfo->active_role[cnt_active - 1].pid = wl_linfo[i].pid;
-		wl_rinfo->active_role[cnt_active - 1].phy = wl_linfo[i].phy;
-		wl_rinfo->active_role[cnt_active - 1].band = wl_linfo[i].band;
-		wl_rinfo->active_role[cnt_active - 1].noa = (u8)wl_linfo[i].noa;
-		wl_rinfo->active_role[cnt_active - 1].connected = 0;
-
-		wl->port_id[wl_linfo[i].role] = wl_linfo[i].pid;
-
-		phy = wl_linfo[i].phy;
-
-		/* check dbcc role */
-		if (rtwdev->dbcc_en && phy < RTW89_PHY_NUM) {
-			wl_dinfo->role[phy] = wl_linfo[i].role;
-			wl_dinfo->op_band[phy] = wl_linfo[i].band;
-			_update_dbcc_band(rtwdev, phy);
-			_fw_set_drv_info(rtwdev, CXDRVINFO_DBCC);
-		}
-
-		if (wl_linfo[i].connected == MLME_NO_LINK) {
-			continue;
-		} else if (wl_linfo[i].connected == MLME_LINKING) {
-			cnt_connecting++;
-		} else {
-			cnt_connect++;
-			if ((wl_linfo[i].role == RTW89_WIFI_ROLE_P2P_GO ||
-			     wl_linfo[i].role == RTW89_WIFI_ROLE_AP) &&
-			     wl_linfo[i].client_cnt > 1)
-				client_joined = true;
-		}
-
-		wl_rinfo->role_map.val |= BIT(wl_linfo[i].role);
-		wl_rinfo->active_role[cnt_active - 1].ch = wl_linfo[i].ch;
-		wl_rinfo->active_role[cnt_active - 1].bw = wl_linfo[i].bw;
-		wl_rinfo->active_role[cnt_active - 1].connected = 1;
-
-		/* only care 2 roles + BT coex */
-		if (wl_linfo[i].band != RTW89_BAND_2G) {
-			if (cnt_5g <= ARRAY_SIZE(wl_5g_ch) - 1)
-				wl_5g_ch[cnt_5g] = wl_linfo[i].ch;
-			cnt_5g++;
-			b5g = true;
-		} else {
-			if (cnt_2g <= ARRAY_SIZE(wl_2g_ch) - 1)
-				wl_2g_ch[cnt_2g] = wl_linfo[i].ch;
-			cnt_2g++;
-			b2g = true;
-		}
-	}
-
-	wl_rinfo->connect_cnt = cnt_connect;
-
-	/* Be careful to change the following sequence!! */
-	if (cnt_connect == 0) {
-		wl_rinfo->link_mode = BTC_WLINK_NOLINK;
-		wl_rinfo->role_map.role.none = 1;
-	} else if (!b2g && b5g) {
-		wl_rinfo->link_mode = BTC_WLINK_5G;
-	} else if (wl_rinfo->role_map.role.nan) {
-		wl_rinfo->link_mode = BTC_WLINK_2G_NAN;
-	} else if (cnt_connect > BTC_TDMA_WLROLE_MAX) {
-		wl_rinfo->link_mode = BTC_WLINK_OTHER;
-	} else  if (b2g && b5g && cnt_connect == 2) {
-		if (rtwdev->dbcc_en) {
-			switch (wl_dinfo->role[RTW89_PHY_0]) {
-			case RTW89_WIFI_ROLE_STATION:
-				wl_rinfo->link_mode = BTC_WLINK_2G_STA;
-				break;
-			case RTW89_WIFI_ROLE_P2P_GO:
-				wl_rinfo->link_mode = BTC_WLINK_2G_GO;
-				break;
-			case RTW89_WIFI_ROLE_P2P_CLIENT:
-				wl_rinfo->link_mode = BTC_WLINK_2G_GC;
-				break;
-			case RTW89_WIFI_ROLE_AP:
-				wl_rinfo->link_mode = BTC_WLINK_2G_AP;
-				break;
-			default:
-				wl_rinfo->link_mode = BTC_WLINK_OTHER;
-				break;
-			}
-		} else {
-			wl_rinfo->link_mode = BTC_WLINK_25G_MCC;
-		}
-	} else if (!b5g && cnt_connect == 2) {
-		if (wl_rinfo->role_map.role.station &&
-		    (wl_rinfo->role_map.role.p2p_go ||
-		    wl_rinfo->role_map.role.p2p_gc ||
-		    wl_rinfo->role_map.role.ap)) {
-			if (wl_2g_ch[0] == wl_2g_ch[1])
-				wl_rinfo->link_mode = BTC_WLINK_2G_SCC;
-			else
-				wl_rinfo->link_mode = BTC_WLINK_2G_MCC;
-		} else {
-			wl_rinfo->link_mode = BTC_WLINK_2G_MCC;
-		}
-	} else if (!b5g && cnt_connect == 1) {
-		if (wl_rinfo->role_map.role.station)
-			wl_rinfo->link_mode = BTC_WLINK_2G_STA;
-		else if (wl_rinfo->role_map.role.ap)
-			wl_rinfo->link_mode = BTC_WLINK_2G_AP;
-		else if (wl_rinfo->role_map.role.p2p_go)
-			wl_rinfo->link_mode = BTC_WLINK_2G_GO;
-		else if (wl_rinfo->role_map.role.p2p_gc)
-			wl_rinfo->link_mode = BTC_WLINK_2G_GC;
-		else
-			wl_rinfo->link_mode = BTC_WLINK_OTHER;
-	}
-
-	/* if no client_joined, don't care P2P-GO/AP role */
-	if (wl_rinfo->role_map.role.p2p_go || wl_rinfo->role_map.role.ap) {
-		if (!client_joined) {
-			if (wl_rinfo->link_mode == BTC_WLINK_2G_SCC ||
-			    wl_rinfo->link_mode == BTC_WLINK_2G_MCC) {
-				wl_rinfo->link_mode = BTC_WLINK_2G_STA;
-				wl_rinfo->connect_cnt = 1;
-			} else if (wl_rinfo->link_mode == BTC_WLINK_2G_GO ||
-				 wl_rinfo->link_mode == BTC_WLINK_2G_AP) {
-				wl_rinfo->link_mode = BTC_WLINK_NOLINK;
-				wl_rinfo->connect_cnt = 0;
-			}
-		}
-	}
-
-	rtw89_debug(rtwdev, RTW89_DBG_BTC,
-		    "[BTC], cnt_connect = %d, connecting = %d, link_mode = %d\n",
-		    cnt_connect, cnt_connecting, wl_rinfo->link_mode);
-
-	_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
-}
-
-static void _update_wl_info_v1(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_link_info *wl_linfo = wl->link_info;
-	struct rtw89_btc_wl_role_info_v1 *wl_rinfo = &wl->role_info_v1;
-	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
-	u8 cnt_connect = 0, cnt_connecting = 0, cnt_active = 0;
-	u8 cnt_2g = 0, cnt_5g = 0, phy;
-	u32 wl_2g_ch[2] = {}, wl_5g_ch[2] = {};
-	bool b2g = false, b5g = false, client_joined = false;
-	u8 i;
-
-	memset(wl_rinfo, 0, sizeof(*wl_rinfo));
-
-	for (i = 0; i < RTW89_PORT_NUM; i++) {
-		if (!wl_linfo[i].active)
-			continue;
-
-		cnt_active++;
-		wl_rinfo->active_role_v1[cnt_active - 1].role = wl_linfo[i].role;
-		wl_rinfo->active_role_v1[cnt_active - 1].pid = wl_linfo[i].pid;
-		wl_rinfo->active_role_v1[cnt_active - 1].phy = wl_linfo[i].phy;
-		wl_rinfo->active_role_v1[cnt_active - 1].band = wl_linfo[i].band;
-		wl_rinfo->active_role_v1[cnt_active - 1].noa = (u8)wl_linfo[i].noa;
-		wl_rinfo->active_role_v1[cnt_active - 1].connected = 0;
-
-		wl->port_id[wl_linfo[i].role] = wl_linfo[i].pid;
-
-		phy = wl_linfo[i].phy;
-
-		if (rtwdev->dbcc_en && phy < RTW89_PHY_NUM) {
-			wl_dinfo->role[phy] = wl_linfo[i].role;
-			wl_dinfo->op_band[phy] = wl_linfo[i].band;
-			_update_dbcc_band(rtwdev, phy);
-			_fw_set_drv_info(rtwdev, CXDRVINFO_DBCC);
-		}
-
-		if (wl_linfo[i].connected == MLME_NO_LINK) {
-			continue;
-		} else if (wl_linfo[i].connected == MLME_LINKING) {
-			cnt_connecting++;
-		} else {
-			cnt_connect++;
-			if ((wl_linfo[i].role == RTW89_WIFI_ROLE_P2P_GO ||
-			     wl_linfo[i].role == RTW89_WIFI_ROLE_AP) &&
-			     wl_linfo[i].client_cnt > 1)
-				client_joined = true;
-		}
-
-		wl_rinfo->role_map.val |= BIT(wl_linfo[i].role);
-		wl_rinfo->active_role_v1[cnt_active - 1].ch = wl_linfo[i].ch;
-		wl_rinfo->active_role_v1[cnt_active - 1].bw = wl_linfo[i].bw;
-		wl_rinfo->active_role_v1[cnt_active - 1].connected = 1;
-
-		/* only care 2 roles + BT coex */
-		if (wl_linfo[i].band != RTW89_BAND_2G) {
-			if (cnt_5g <= ARRAY_SIZE(wl_5g_ch) - 1)
-				wl_5g_ch[cnt_5g] = wl_linfo[i].ch;
-			cnt_5g++;
-			b5g = true;
-		} else {
-			if (cnt_2g <= ARRAY_SIZE(wl_2g_ch) - 1)
-				wl_2g_ch[cnt_2g] = wl_linfo[i].ch;
-			cnt_2g++;
-			b2g = true;
-		}
-	}
-
-	wl_rinfo->connect_cnt = cnt_connect;
-
-	/* Be careful to change the following sequence!! */
-	if (cnt_connect == 0) {
-		wl_rinfo->link_mode = BTC_WLINK_NOLINK;
-		wl_rinfo->role_map.role.none = 1;
-	} else if (!b2g && b5g) {
-		wl_rinfo->link_mode = BTC_WLINK_5G;
-	} else if (wl_rinfo->role_map.role.nan) {
-		wl_rinfo->link_mode = BTC_WLINK_2G_NAN;
-	} else if (cnt_connect > BTC_TDMA_WLROLE_MAX) {
-		wl_rinfo->link_mode = BTC_WLINK_OTHER;
-	} else  if (b2g && b5g && cnt_connect == 2) {
-		if (rtwdev->dbcc_en) {
-			switch (wl_dinfo->role[RTW89_PHY_0]) {
-			case RTW89_WIFI_ROLE_STATION:
-				wl_rinfo->link_mode = BTC_WLINK_2G_STA;
-				break;
-			case RTW89_WIFI_ROLE_P2P_GO:
-				wl_rinfo->link_mode = BTC_WLINK_2G_GO;
-				break;
-			case RTW89_WIFI_ROLE_P2P_CLIENT:
-				wl_rinfo->link_mode = BTC_WLINK_2G_GC;
-				break;
-			case RTW89_WIFI_ROLE_AP:
-				wl_rinfo->link_mode = BTC_WLINK_2G_AP;
-				break;
-			default:
-				wl_rinfo->link_mode = BTC_WLINK_OTHER;
-				break;
-			}
-		} else {
-			wl_rinfo->link_mode = BTC_WLINK_25G_MCC;
-		}
-	} else if (!b5g && cnt_connect == 2) {
-		if (wl_rinfo->role_map.role.station &&
-		    (wl_rinfo->role_map.role.p2p_go ||
-		    wl_rinfo->role_map.role.p2p_gc ||
-		    wl_rinfo->role_map.role.ap)) {
-			if (wl_2g_ch[0] == wl_2g_ch[1])
-				wl_rinfo->link_mode = BTC_WLINK_2G_SCC;
-			else
-				wl_rinfo->link_mode = BTC_WLINK_2G_MCC;
-		} else {
-			wl_rinfo->link_mode = BTC_WLINK_2G_MCC;
-		}
-	} else if (!b5g && cnt_connect == 1) {
-		if (wl_rinfo->role_map.role.station)
-			wl_rinfo->link_mode = BTC_WLINK_2G_STA;
-		else if (wl_rinfo->role_map.role.ap)
-			wl_rinfo->link_mode = BTC_WLINK_2G_AP;
-		else if (wl_rinfo->role_map.role.p2p_go)
-			wl_rinfo->link_mode = BTC_WLINK_2G_GO;
-		else if (wl_rinfo->role_map.role.p2p_gc)
-			wl_rinfo->link_mode = BTC_WLINK_2G_GC;
-		else
-			wl_rinfo->link_mode = BTC_WLINK_OTHER;
-	}
-
-	/* if no client_joined, don't care P2P-GO/AP role */
-	if (wl_rinfo->role_map.role.p2p_go || wl_rinfo->role_map.role.ap) {
-		if (!client_joined) {
-			if (wl_rinfo->link_mode == BTC_WLINK_2G_SCC ||
-			    wl_rinfo->link_mode == BTC_WLINK_2G_MCC) {
-				wl_rinfo->link_mode = BTC_WLINK_2G_STA;
-				wl_rinfo->connect_cnt = 1;
-			} else if (wl_rinfo->link_mode == BTC_WLINK_2G_GO ||
-				 wl_rinfo->link_mode == BTC_WLINK_2G_AP) {
-				wl_rinfo->link_mode = BTC_WLINK_NOLINK;
-				wl_rinfo->connect_cnt = 0;
-			}
-		}
-	}
-
-	rtw89_debug(rtwdev, RTW89_DBG_BTC,
-		    "[BTC], cnt_connect = %d, connecting = %d, link_mode = %d\n",
-		    cnt_connect, cnt_connecting, wl_rinfo->link_mode);
-
-	_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
-}
-
-static void _update_wl_info_v2(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_link_info *wl_linfo = wl->link_info;
-	struct rtw89_btc_wl_role_info_v2 *wl_rinfo = &wl->role_info_v2;
-	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
-	u8 cnt_connect = 0, cnt_connecting = 0, cnt_active = 0;
-	u8 cnt_2g = 0, cnt_5g = 0, phy;
-	u32 wl_2g_ch[2] = {}, wl_5g_ch[2] = {};
-	bool b2g = false, b5g = false, client_joined = false;
-	u8 i;
-
-	memset(wl_rinfo, 0, sizeof(*wl_rinfo));
-
-	for (i = 0; i < RTW89_PORT_NUM; i++) {
-		if (!wl_linfo[i].active)
-			continue;
-
-		cnt_active++;
-		wl_rinfo->active_role_v2[cnt_active - 1].role = wl_linfo[i].role;
-		wl_rinfo->active_role_v2[cnt_active - 1].pid = wl_linfo[i].pid;
-		wl_rinfo->active_role_v2[cnt_active - 1].phy = wl_linfo[i].phy;
-		wl_rinfo->active_role_v2[cnt_active - 1].band = wl_linfo[i].band;
-		wl_rinfo->active_role_v2[cnt_active - 1].noa = (u8)wl_linfo[i].noa;
-		wl_rinfo->active_role_v2[cnt_active - 1].connected = 0;
-
-		wl->port_id[wl_linfo[i].role] = wl_linfo[i].pid;
-
-		phy = wl_linfo[i].phy;
-
-		if (rtwdev->dbcc_en && phy < RTW89_PHY_NUM) {
-			wl_dinfo->role[phy] = wl_linfo[i].role;
-			wl_dinfo->op_band[phy] = wl_linfo[i].band;
-			_update_dbcc_band(rtwdev, phy);
-			_fw_set_drv_info(rtwdev, CXDRVINFO_DBCC);
-		}
-
-		if (wl_linfo[i].connected == MLME_NO_LINK) {
-			continue;
-		} else if (wl_linfo[i].connected == MLME_LINKING) {
-			cnt_connecting++;
-		} else {
-			cnt_connect++;
-			if ((wl_linfo[i].role == RTW89_WIFI_ROLE_P2P_GO ||
-			     wl_linfo[i].role == RTW89_WIFI_ROLE_AP) &&
-			     wl_linfo[i].client_cnt > 1)
-				client_joined = true;
-		}
-
-		wl_rinfo->role_map.val |= BIT(wl_linfo[i].role);
-		wl_rinfo->active_role_v2[cnt_active - 1].ch = wl_linfo[i].ch;
-		wl_rinfo->active_role_v2[cnt_active - 1].bw = wl_linfo[i].bw;
-		wl_rinfo->active_role_v2[cnt_active - 1].connected = 1;
-
-		/* only care 2 roles + BT coex */
-		if (wl_linfo[i].band != RTW89_BAND_2G) {
-			if (cnt_5g <= ARRAY_SIZE(wl_5g_ch) - 1)
-				wl_5g_ch[cnt_5g] = wl_linfo[i].ch;
-			cnt_5g++;
-			b5g = true;
-		} else {
-			if (cnt_2g <= ARRAY_SIZE(wl_2g_ch) - 1)
-				wl_2g_ch[cnt_2g] = wl_linfo[i].ch;
-			cnt_2g++;
-			b2g = true;
-		}
-	}
-
-	wl_rinfo->connect_cnt = cnt_connect;
-
-	/* Be careful to change the following sequence!! */
-	if (cnt_connect == 0) {
-		wl_rinfo->link_mode = BTC_WLINK_NOLINK;
-		wl_rinfo->role_map.role.none = 1;
-	} else if (!b2g && b5g) {
-		wl_rinfo->link_mode = BTC_WLINK_5G;
-	} else if (wl_rinfo->role_map.role.nan) {
-		wl_rinfo->link_mode = BTC_WLINK_2G_NAN;
-	} else if (cnt_connect > BTC_TDMA_WLROLE_MAX) {
-		wl_rinfo->link_mode = BTC_WLINK_OTHER;
-	} else  if (b2g && b5g && cnt_connect == 2) {
-		if (rtwdev->dbcc_en) {
-			switch (wl_dinfo->role[RTW89_PHY_0]) {
-			case RTW89_WIFI_ROLE_STATION:
-				wl_rinfo->link_mode = BTC_WLINK_2G_STA;
-				break;
-			case RTW89_WIFI_ROLE_P2P_GO:
-				wl_rinfo->link_mode = BTC_WLINK_2G_GO;
-				break;
-			case RTW89_WIFI_ROLE_P2P_CLIENT:
-				wl_rinfo->link_mode = BTC_WLINK_2G_GC;
-				break;
-			case RTW89_WIFI_ROLE_AP:
-				wl_rinfo->link_mode = BTC_WLINK_2G_AP;
-				break;
-			default:
-				wl_rinfo->link_mode = BTC_WLINK_OTHER;
-				break;
-			}
-		} else {
-			wl_rinfo->link_mode = BTC_WLINK_25G_MCC;
-		}
-	} else if (!b5g && cnt_connect == 2) {
-		if (wl_rinfo->role_map.role.station &&
-		    (wl_rinfo->role_map.role.p2p_go ||
-		    wl_rinfo->role_map.role.p2p_gc ||
-		    wl_rinfo->role_map.role.ap)) {
-			if (wl_2g_ch[0] == wl_2g_ch[1])
-				wl_rinfo->link_mode = BTC_WLINK_2G_SCC;
-			else
-				wl_rinfo->link_mode = BTC_WLINK_2G_MCC;
-		} else {
-			wl_rinfo->link_mode = BTC_WLINK_2G_MCC;
-		}
-	} else if (!b5g && cnt_connect == 1) {
-		if (wl_rinfo->role_map.role.station)
-			wl_rinfo->link_mode = BTC_WLINK_2G_STA;
-		else if (wl_rinfo->role_map.role.ap)
-			wl_rinfo->link_mode = BTC_WLINK_2G_AP;
-		else if (wl_rinfo->role_map.role.p2p_go)
-			wl_rinfo->link_mode = BTC_WLINK_2G_GO;
-		else if (wl_rinfo->role_map.role.p2p_gc)
-			wl_rinfo->link_mode = BTC_WLINK_2G_GC;
-		else
-			wl_rinfo->link_mode = BTC_WLINK_OTHER;
-	}
-
-	/* if no client_joined, don't care P2P-GO/AP role */
-	if (wl_rinfo->role_map.role.p2p_go || wl_rinfo->role_map.role.ap) {
-		if (!client_joined) {
-			if (wl_rinfo->link_mode == BTC_WLINK_2G_SCC ||
-			    wl_rinfo->link_mode == BTC_WLINK_2G_MCC) {
-				wl_rinfo->link_mode = BTC_WLINK_2G_STA;
-				wl_rinfo->connect_cnt = 1;
-			} else if (wl_rinfo->link_mode == BTC_WLINK_2G_GO ||
-				 wl_rinfo->link_mode == BTC_WLINK_2G_AP) {
-				wl_rinfo->link_mode = BTC_WLINK_NOLINK;
-				wl_rinfo->connect_cnt = 0;
-			}
-		}
-	}
-
-	rtw89_debug(rtwdev, RTW89_DBG_BTC,
-		    "[BTC], cnt_connect = %d, connecting = %d, link_mode = %d\n",
-		    cnt_connect, cnt_connecting, wl_rinfo->link_mode);
-
-	_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
-}
-
 #define BTC_CHK_HANG_MAX 3
 #define BTC_SCB_INV_VALUE GENMASK(31, 0)
 
-static u8 _get_role_link_mode(u8 role)
+static u8 _get_role_link_mode(struct rtw89_btc_wl_role_info *r, u8 role, bool notv10)
 {
 	switch (role) {
 	case RTW89_WIFI_ROLE_STATION:
-		return BTC_WLINK_2G_STA;
+	default:
+		if (notv10)
+			r->link_mode_v0 = BTC_WLINK_V0_2G_STA;
+		return BTC_WLINK_STA;
 	case RTW89_WIFI_ROLE_P2P_GO:
-		return BTC_WLINK_2G_GO;
+		if (notv10)
+			r->link_mode_v0 = BTC_WLINK_V0_2G_GO;
+		return BTC_WLINK_GO;
 	case RTW89_WIFI_ROLE_P2P_CLIENT:
-		return BTC_WLINK_2G_GC;
+		if (notv10)
+			r->link_mode_v0 = BTC_WLINK_V0_2G_GC;
+		return BTC_WLINK_GC;
 	case RTW89_WIFI_ROLE_AP:
-		return BTC_WLINK_2G_AP;
-	default:
-		return BTC_WLINK_OTHER;
+		if (notv10)
+			r->link_mode_v0 = BTC_WLINK_V0_2G_AP;
+		return BTC_WLINK_AP;
 	}
 }
 
@@ -6891,13 +6498,13 @@ static bool _chk_role_ch_group(const struct rtw89_btc_chdef *r1,
 }
 
 static u8 _chk_dbcc(struct rtw89_dev *rtwdev, struct rtw89_btc_chdef *ch,
-		    u8 *phy, u8 *role, u8 link_cnt)
+		    u8 *phy, u8 *role, u8 link_cnt, bool notv10)
 {
 	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
-	struct rtw89_btc_wl_role_info_v7 *rinfo_v7 = &wl->role_info_v7;
-	struct rtw89_btc_wl_role_info_v8 *rinfo_v8 = &wl->role_info_v8;
+	struct rtw89_btc_wl_role_info *rinfo = &wl->role_info;
 	bool is_2g_ch_exist = false, is_multi_role_in_2g_phy = false;
-	u8 j, k, dbcc_2g_cid, dbcc_2g_cid2, dbcc_2g_phy, pta_req_band;
+	u8 j, k, dbcc_2g_cid = 0, dbcc_2g_cid2 = 0;
+	u8 mode;
 
 	/* find out the 2G-PHY by connect-id ->ch  */
 	for (j = 0; j < link_cnt; j++) {
@@ -6908,34 +6515,31 @@ static u8 _chk_dbcc(struct rtw89_dev *rtwdev, struct rtw89_btc_chdef *ch,
 	}
 
 	/* If no any 2G-port exist, it's impossible because 5G-exclude */
-	if (!is_2g_ch_exist)
-		return BTC_WLINK_5G;
+	if (!is_2g_ch_exist) {
+		mode = BTC_WLINK_SB_MCC;
+		if (notv10)
+			rinfo->link_mode_v0 = BTC_WLINK_V0_5G;
+		return mode;
+	}
 
 	dbcc_2g_cid = j;
-	dbcc_2g_phy = phy[dbcc_2g_cid];
+	rinfo->dbcc_2g_phy = phy[dbcc_2g_cid];
 
-	if (dbcc_2g_phy == RTW89_PHY_1)
-		pta_req_band = RTW89_PHY_1;
+	if (rinfo->dbcc_2g_phy == RTW89_PHY_1)
+		rinfo->pta_req_band = RTW89_PHY_1;
 	else
-		pta_req_band = RTW89_PHY_0;
-
-	if (rtwdev->btc.ver->fwlrole == 7) {
-		rinfo_v7->dbcc_2g_phy = dbcc_2g_phy;
-	} else if (rtwdev->btc.ver->fwlrole == 8) {
-		rinfo_v8->dbcc_2g_phy = dbcc_2g_phy;
-		rinfo_v8->pta_req_band = pta_req_band;
-	}
+		rinfo->pta_req_band = RTW89_PHY_0;
 
 	/* connect_cnt <= 2 */
 	if (link_cnt < BTC_TDMA_WLROLE_MAX)
-		return (_get_role_link_mode((role[dbcc_2g_cid])));
+		return _get_role_link_mode(rinfo, role[dbcc_2g_cid], notv10);
 
 	/* find the other-port in the 2G-PHY, ex: PHY-0:6G, PHY1: mcc/scc */
 	for (k = 0; k < link_cnt; k++) {
 		if (k == dbcc_2g_cid)
 			continue;
 
-		if (phy[k] == dbcc_2g_phy) {
+		if (phy[k] == rinfo->dbcc_2g_phy) {
 			is_multi_role_in_2g_phy = true;
 			dbcc_2g_cid2 = k;
 			break;
@@ -6944,319 +6548,151 @@ static u8 _chk_dbcc(struct rtw89_dev *rtwdev, struct rtw89_btc_chdef *ch,
 
 	/* Single-role in 2G-PHY */
 	if (!is_multi_role_in_2g_phy)
-		return (_get_role_link_mode(role[dbcc_2g_cid]));
+		return _get_role_link_mode(rinfo, role[dbcc_2g_cid], notv10);
 
 	/* 2-role in 2G-PHY */
-	if (ch[dbcc_2g_cid2].center_ch > 14)
-		return BTC_WLINK_25G_MCC;
-	else if (_chk_role_ch_group(&ch[dbcc_2g_cid], &ch[dbcc_2g_cid2]))
-		return BTC_WLINK_2G_SCC;
-	else
-		return BTC_WLINK_2G_MCC;
-}
-
-static void _update_role_link_mode(struct rtw89_dev *rtwdev,
-				   bool client_joined, u32 noa)
-{
-	struct rtw89_btc_wl_role_info_v8 *rinfo_v8 = &rtwdev->btc.cx.wl.role_info_v8;
-	struct rtw89_btc_wl_role_info_v7 *rinfo_v7 = &rtwdev->btc.cx.wl.role_info_v7;
-	u8 role_ver = rtwdev->btc.ver->fwlrole;
-	u32 type = BTC_WLMROLE_NONE, dur = 0;
-	u8 link_mode, connect_cnt;
-	u32 wl_role;
-
-	if (role_ver == 7) {
-		wl_role = rinfo_v7->role_map;
-		link_mode = rinfo_v7->link_mode;
-		connect_cnt = rinfo_v7->connect_cnt;
-	} else if (role_ver == 8) {
-		wl_role = rinfo_v8->role_map;
-		link_mode = rinfo_v8->link_mode;
-		connect_cnt = rinfo_v8->connect_cnt;
+	if (ch[dbcc_2g_cid2].center_ch > 14) {
+		if (notv10)
+			rinfo->link_mode_v0 = BTC_WLINK_V0_25G_MCC;
+		return BTC_WLINK_DB_MCC;
+	} else if (_chk_role_ch_group(&ch[dbcc_2g_cid], &ch[dbcc_2g_cid2])) {
+		if (notv10)
+			rinfo->link_mode_v0 = BTC_WLINK_V0_2G_SCC;
+		return BTC_WLINK_SCC;
 	} else {
-		return;
-	}
-
-	/* if no client_joined, don't care P2P-GO/AP role */
-	if (((wl_role & BIT(RTW89_WIFI_ROLE_P2P_GO)) ||
-	     (wl_role & BIT(RTW89_WIFI_ROLE_AP))) && !client_joined) {
-		if (link_mode == BTC_WLINK_2G_SCC) {
-			if (role_ver == 7) {
-				rinfo_v7->link_mode = BTC_WLINK_2G_STA;
-				rinfo_v7->connect_cnt--;
-			} else if (role_ver == 8) {
-				rinfo_v8->link_mode = BTC_WLINK_2G_STA;
-				rinfo_v8->connect_cnt--;
-			}
-		} else if (link_mode == BTC_WLINK_2G_GO ||
-			   link_mode == BTC_WLINK_2G_AP) {
-			if (role_ver == 7) {
-				rinfo_v7->link_mode = BTC_WLINK_NOLINK;
-				rinfo_v7->connect_cnt--;
-			} else if (role_ver == 8) {
-				rinfo_v8->link_mode = BTC_WLINK_NOLINK;
-				rinfo_v8->connect_cnt--;
-			}
-		}
-	}
-
-	/* Identify 2-Role type  */
-	if (connect_cnt >= 2 &&
-	    (link_mode == BTC_WLINK_2G_SCC ||
-	     link_mode == BTC_WLINK_2G_MCC ||
-	     link_mode == BTC_WLINK_25G_MCC ||
-	     link_mode == BTC_WLINK_5G)) {
-		if ((wl_role & BIT(RTW89_WIFI_ROLE_P2P_GO)) ||
-		    (wl_role & BIT(RTW89_WIFI_ROLE_AP)))
-			type = noa ? BTC_WLMROLE_STA_GO_NOA : BTC_WLMROLE_STA_GO;
-		else if (wl_role & BIT(RTW89_WIFI_ROLE_P2P_CLIENT))
-			type = noa ? BTC_WLMROLE_STA_GC_NOA : BTC_WLMROLE_STA_GC;
-		else
-			type = BTC_WLMROLE_STA_STA;
-
-		dur = noa;
-	}
-
-	if (role_ver == 7) {
-		rinfo_v7->mrole_type = type;
-		rinfo_v7->mrole_noa_duration = dur;
-	} else if (role_ver == 8) {
-		rinfo_v8->mrole_type = type;
-		rinfo_v8->mrole_noa_duration = dur;
+		if (notv10)
+			rinfo->link_mode_v0 = BTC_WLINK_V0_2G_MCC;
+		return BTC_WLINK_SB_MCC;
 	}
 }
 
-static void _update_wl_info_v7(struct rtw89_dev *rtwdev, u8 rid)
+static void _update_wl_link_mode(struct rtw89_dev *rtwdev, u8 hw_band, u8 type)
 {
-	struct rtw89_btc_chdef cid_ch[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER];
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_role_info_v7 *wl_rinfo = &wl->role_info_v7;
-	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
-	struct rtw89_btc_wl_link_info *wl_linfo = wl->link_info;
-	struct rtw89_btc_wl_active_role_v7 *act_role = NULL;
-	u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, phy_now = RTW89_PHY_NUM, phy_dbcc;
-	bool b2g = false, b5g = false, client_joined = false, client_inc_2g = false;
-	u8 client_cnt_last[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
-	u8 cid_role[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
-	u8 cid_phy[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
-	u8 mac = RTW89_MAC_0, dbcc_2g_phy = RTW89_PHY_0;
-	u32 noa_duration = 0;
-
-	memset(wl_rinfo, 0, sizeof(*wl_rinfo));
-
-	for (i = 0; i < RTW89_PORT_NUM; i++) {
-		if (!wl_linfo[i].active || wl_linfo[i].phy >= RTW89_PHY_NUM)
-			continue;
-
-		act_role = &wl_rinfo->active_role[i];
-		act_role->role = wl_linfo[i].role;
-
-		/* check if role connect? */
-		if (wl_linfo[i].connected == MLME_NO_LINK) {
-			act_role->connected = 0;
-			continue;
-		} else if (wl_linfo[i].connected == MLME_LINKING) {
-			continue;
-		}
-
-		cnt++;
-		act_role->connected = 1;
-		act_role->pid = wl_linfo[i].pid;
-		act_role->phy = wl_linfo[i].phy;
-		act_role->band = wl_linfo[i].band;
-		act_role->ch = wl_linfo[i].ch;
-		act_role->bw = wl_linfo[i].bw;
-		act_role->noa = wl_linfo[i].noa;
-		act_role->noa_dur = wl_linfo[i].noa_duration;
-		cid_ch[cnt - 1] = wl_linfo[i].chdef;
-		cid_phy[cnt - 1] = wl_linfo[i].phy;
-		cid_role[cnt - 1] = wl_linfo[i].role;
-		wl_rinfo->role_map |= BIT(wl_linfo[i].role);
-
-		if (rid == i)
-			phy_now = act_role->phy;
-
-		if (wl_linfo[i].role == RTW89_WIFI_ROLE_P2P_GO ||
-		    wl_linfo[i].role == RTW89_WIFI_ROLE_AP) {
-			if (wl_linfo[i].client_cnt > 1)
-				client_joined = true;
-			if (client_cnt_last[i] < wl_linfo[i].client_cnt &&
-			    wl_linfo[i].chdef.band == RTW89_BAND_2G)
-				client_inc_2g = true;
-			act_role->client_cnt = wl_linfo[i].client_cnt;
-		} else {
-			act_role->client_cnt = 0;
-		}
-
-		if (act_role->noa && act_role->noa_dur > 0)
-			noa_duration = act_role->noa_dur;
-
-		if (rtwdev->dbcc_en) {
-			phy_dbcc = wl_linfo[i].phy;
-			wl_dinfo->role[phy_dbcc] |= BIT(wl_linfo[i].role);
-			wl_dinfo->op_band[phy_dbcc] = wl_linfo[i].chdef.band;
-		}
-
-		if (wl_linfo[i].chdef.band != RTW89_BAND_2G) {
-			cnt_5g++;
-			b5g = true;
-		} else {
-			if (((wl_linfo[i].role == RTW89_WIFI_ROLE_P2P_GO ||
-			      wl_linfo[i].role == RTW89_WIFI_ROLE_AP) &&
-			     client_joined) ||
-			    wl_linfo[i].role == RTW89_WIFI_ROLE_P2P_CLIENT)
-				wl_rinfo->p2p_2g = 1;
-
-			if ((wl_linfo[i].mode & BIT(BTC_WL_MODE_11B)) ||
-			    (wl_linfo[i].mode & BIT(BTC_WL_MODE_11G)))
-				wl->bg_mode = 1;
-			else if (wl_linfo[i].mode & BIT(BTC_WL_MODE_HE))
-				wl->he_mode = true;
-
-			cnt_2g++;
-			b2g = true;
-		}
-
-		if (act_role->band == RTW89_BAND_5G && act_role->ch >= 100)
-			wl->is_5g_hi_channel = 1;
-		else
-			wl->is_5g_hi_channel = 0;
-	}
-
-	wl_rinfo->connect_cnt = cnt;
-	wl->client_cnt_inc_2g = client_inc_2g;
-
-	if (cnt == 0) {
-		mode = BTC_WLINK_NOLINK;
-		wl_rinfo->role_map = BIT(RTW89_WIFI_ROLE_NONE);
-	} else if (!b2g && b5g) {
-		mode = BTC_WLINK_5G;
-	} else if (wl_rinfo->role_map & BIT(RTW89_WIFI_ROLE_NAN)) {
-		mode = BTC_WLINK_2G_NAN;
-	} else if (cnt > BTC_TDMA_WLROLE_MAX) {
-		mode = BTC_WLINK_OTHER;
-	} else if (rtwdev->dbcc_en) {
-		mode = _chk_dbcc(rtwdev, cid_ch, cid_phy, cid_role, cnt);
-
-		/* correct 2G-located PHY band for gnt ctrl */
-		if (dbcc_2g_phy < RTW89_PHY_NUM)
-			wl_dinfo->op_band[dbcc_2g_phy] = RTW89_BAND_2G;
-	} else if (b2g && b5g && cnt == 2) {
-		mode = BTC_WLINK_25G_MCC;
-	} else if (!b5g && cnt == 2) { /* cnt_connect = 2 */
-		if (_chk_role_ch_group(&cid_ch[0], &cid_ch[cnt - 1]))
-			mode = BTC_WLINK_2G_SCC;
-		else
-			mode = BTC_WLINK_2G_MCC;
-	} else if (!b5g && cnt == 1) { /* cnt_connect = 1 */
-		mode = _get_role_link_mode(cid_role[0]);
-	} else {
-		mode = BTC_WLINK_NOLINK;
-	}
-
-	wl_rinfo->link_mode = mode;
-	_update_role_link_mode(rtwdev, client_joined, noa_duration);
-
-	/* todo DBCC related event */
-	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC] wl_info phy_now=%d\n", phy_now);
-	rtw89_debug(rtwdev, RTW89_DBG_BTC,
-		    "[BTC] rlink cnt_2g=%d cnt_5g=%d\n", cnt_2g, cnt_5g);
-
-	if (wl_rinfo->dbcc_en != rtwdev->dbcc_en) {
-		wl_rinfo->dbcc_chg = 1;
-		wl_rinfo->dbcc_en = rtwdev->dbcc_en;
-		wl->wcnt[BTC_WCNT_DBCC_CHG]++;
-	}
-
-	if (rtwdev->dbcc_en) {
-		wl_rinfo->dbcc_2g_phy = dbcc_2g_phy;
-
-		if (dbcc_2g_phy == RTW89_PHY_1)
-			mac = RTW89_MAC_1;
-
-		_update_dbcc_band(rtwdev, RTW89_PHY_0);
-		_update_dbcc_band(rtwdev, RTW89_PHY_1);
-	}
-	_wl_req_mac(rtwdev, mac);
-	_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
-}
-
-static u8 _update_wl_link_mode(struct rtw89_dev *rtwdev, u8 hw_band, u8 type)
-{
-	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
 	struct rtw89_btc_wl_mlo_info *mlo_info = &wl->mlo_info;
-	u8 mode = BTC_WLINK_NOLINK;
+	struct rtw89_btc_wl_role_info *r = &wl->role_info;
+	u8 p2p_exist = wl->role_info.p2p_exist;
 
+	if (hw_band == RTW89_PHY_1)
+		p2p_exist = wl->role_info.p2p_exist_hb1;
+
+	/* MLD: nLmR --> 2L1R: 2-Link by 1-RF,  2L2R: 2-link by 2-RF */
 	switch (type) {
 	case RTW89_MR_WTYPE_NONE: /* no-link */
-		mode = BTC_WLINK_NOLINK;
+		r->link_mode = BTC_WLINK_NOLINK;
 		break;
 	case RTW89_MR_WTYPE_NONMLD:  /* Non_MLO 1-role 2+0/0+2 */
 	case RTW89_MR_WTYPE_MLD1L1R: /* MLO only-1 link 2+0/0+2 */
+		if (mlo_info->wmode[hw_band] == RTW89_MR_WMODE_1AP) {
+			r->link_mode = BTC_WLINK_GO;
+		} else if (mlo_info->wmode[hw_band] == RTW89_MR_WMODE_1CLIENT &&
+			   p2p_exist) {
+			r->link_mode = BTC_WLINK_GC;
+		} else {
+			r->link_mode = BTC_WLINK_STA;
+		}
+
+		if (ver->fwlrole >= 10)
+			break;
+
 		if (mlo_info->hwb_rf_band[hw_band] != RTW89_BAND_2G) {
-			mode = BTC_WLINK_5G;
+			r->link_mode_v0 = BTC_WLINK_V0_5G;
 		} else if (mlo_info->wmode[hw_band] == RTW89_MR_WMODE_1AP) {
-			mode = BTC_WLINK_2G_GO;
+			r->link_mode_v0 = BTC_WLINK_V0_2G_GO;
 		} else if (mlo_info->wmode[hw_band] == RTW89_MR_WMODE_1CLIENT) {
-			if (wl->role_info_v8.p2p_2g)
-				mode = BTC_WLINK_2G_GC;
+			if (wl->role_info.p2p_2g)
+				r->link_mode_v0 = BTC_WLINK_V0_2G_GC;
 			else
-				mode = BTC_WLINK_2G_STA;
+				r->link_mode_v0 = BTC_WLINK_V0_2G_STA;
 		}
 		break;
 	case RTW89_MR_WTYPE_NONMLD_NONMLD: /* Non_MLO 2-role 2+0/0+2 */
 	case RTW89_MR_WTYPE_MLD1L1R_NONMLD: /* MLO only-1 link + P2P 2+0/0+2 */
+		if (mlo_info->ch_type[hw_band] == RTW89_MR_CTX2_2GHZ_5GHZ ||
+		    mlo_info->ch_type[hw_band] == RTW89_MR_CTX2_2GHZ_6GHZ) {
+			r->link_mode = BTC_WLINK_DB_MCC;
+		} else if (mlo_info->ch_type[hw_band] == RTW89_MR_CTX2_2GHZ ||
+			   mlo_info->ch_type[hw_band] == RTW89_MR_CTX2_5GHZ ||
+			   mlo_info->ch_type[hw_band] == RTW89_MR_CTX2_6GHZ ||
+			   mlo_info->ch_type[hw_band] == RTW89_MR_CTX2_5GHZ_6GHZ) {
+			r->link_mode = BTC_WLINK_SB_MCC;
+		} else {
+			r->link_mode = BTC_WLINK_SCC;
+		}
+
+		if (ver->fwlrole >= 10)
+			break;
+
 		if (mlo_info->hwb_rf_band[hw_band] != RTW89_BAND_2G) {
-			mode = BTC_WLINK_5G;
+			r->link_mode_v0 = BTC_WLINK_V0_5G;
 		} else if (mlo_info->ch_type[hw_band] == RTW89_MR_CTX2_2GHZ_5GHZ ||
 			   mlo_info->ch_type[hw_band] == RTW89_MR_CTX2_2GHZ_6GHZ) {
-			mode = BTC_WLINK_25G_MCC;
+			r->link_mode_v0 = BTC_WLINK_V0_25G_MCC;
 		} else if (mlo_info->ch_type[hw_band] == RTW89_MR_CTX2_2GHZ) {
-			mode = BTC_WLINK_2G_MCC;
+			r->link_mode_v0 = BTC_WLINK_V0_2G_MCC;
 		} else if (mlo_info->ch_type[hw_band] == RTW89_MR_CTX1_2GHZ) {
-			mode = BTC_WLINK_2G_SCC;
+			r->link_mode_v0 = BTC_WLINK_V0_2G_SCC;
 		}
 		break;
 	case RTW89_MR_WTYPE_MLD2L1R: /* MLO_MLSR 2+0/0+2 */
+		if (p2p_exist) /* MLO_MLSR only support STA/GC */
+			r->link_mode = BTC_WLINK_GC;
+		else
+			r->link_mode = BTC_WLINK_STA;
+
+		if (ver->fwlrole >= 10)
+			break;
+
 		if (mlo_info->hwb_rf_band[hw_band] != RTW89_BAND_2G)
-			mode = BTC_WLINK_5G;
-		else if (wl->role_info_v8.p2p_2g)
-			mode = BTC_WLINK_2G_GC;
+			r->link_mode_v0 = BTC_WLINK_V0_5G;
+		else if (wl->role_info.p2p_2g)
+			r->link_mode_v0 = BTC_WLINK_V0_2G_GC;
 		else
-			mode = BTC_WLINK_2G_STA;
+			r->link_mode_v0 = BTC_WLINK_V0_2G_STA;
 		break;
 	case RTW89_MR_WTYPE_MLD2L1R_NONMLD: /* MLO_MLSR + P2P 2+0/0+2 */
-	case RTW89_MR_WTYPE_MLD2L2R_NONMLD: /* MLO_MLMR + P2P 1+1/2+2 */
-		/* driver may doze 1-link to
+	case RTW89_MR_WTYPE_MLD2L2R_NONMLD: /* MLO_MLMR + P2P 1+1/2+2*/
+		/* driver may doze 1-link (1+1) or 2+0->0+2->1+1
 		 * 2G+5G   -> TDMA slot switch by E2G/E5G
 		 * 5G only -> TDMA slot switch by E5G
 		 */
-		mode = BTC_WLINK_25G_MCC;
+		r->link_mode = BTC_WLINK_DB_MCC;
+
+		if (ver->fwlrole >= 10)
+			break;
+
+		r->link_mode_v0 = BTC_WLINK_V0_25G_MCC;
 		break;
 	case RTW89_MR_WTYPE_MLD2L2R: /* MLO_MLMR  1+1/2+2 */
+		/* MLMR only support STA now (2024) */
+		r->link_mode = BTC_WLINK_STA;
+
+		if (ver->fwlrole >= 10)
+			break;
+
 		if (mlo_info->hwb_rf_band[hw_band] != RTW89_BAND_2G) {
-			mode = BTC_WLINK_5G;
+			r->link_mode_v0 = BTC_WLINK_V0_5G;
 		} else if (mlo_info->wmode[hw_band] == RTW89_MR_WMODE_1AP) {
-			mode = BTC_WLINK_2G_GO;
+			r->link_mode_v0 = BTC_WLINK_V0_2G_GO;
 		} else if (mlo_info->wmode[hw_band] == RTW89_MR_WMODE_1CLIENT) {
-			if (wl->role_info_v8.p2p_2g)
-				mode = BTC_WLINK_2G_GC;
+			if (wl->role_info.p2p_2g)
+				r->link_mode_v0 = BTC_WLINK_V0_2G_GC;
 			else
-				mode = BTC_WLINK_2G_STA;
+				r->link_mode_v0 = BTC_WLINK_V0_2G_STA;
 		}
 		break;
 	}
-	return mode;
 }
 
-static void _update_wl_mlo_info(struct rtw89_dev *rtwdev)
+static void _update_wl_mlo_info(struct rtw89_dev *rtwdev, u8 hw_band)
 {
 	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
+	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_mlo_info *mlo_info = &wl->mlo_info;
 	struct rtw89_mr_chanctx_info qinfo;
-	u8 track_band = RTW89_PHY_0;
+	struct rtw89_chanctx *ch;
 	u8 rf_band = RTW89_BAND_2G;
 	u8 i, type;
 
@@ -7265,19 +6701,46 @@ static void _update_wl_mlo_info(struct rtw89_dev *rtwdev)
 		memset(&qinfo, 0, sizeof(qinfo));
 
 		rtw89_query_mr_chanctx_info(rtwdev, i, &qinfo);
+
+		switch (qinfo.ctxtype) {
+		default:
+			mlo_info->hwb_rf_band[i] = 0;
+			break;
+		case RTW89_MR_CTX1_2GHZ:
+		case RTW89_MR_CTX2_2GHZ:
+			mlo_info->hwb_rf_band[i] = BIT(RTW89_BAND_2G);
+			break;
+		case RTW89_MR_CTX1_5GHZ:
+		case RTW89_MR_CTX2_5GHZ:
+			mlo_info->hwb_rf_band[i] = BIT(RTW89_BAND_5G);
+			break;
+		case RTW89_MR_CTX1_6GHZ:
+		case RTW89_MR_CTX2_6GHZ:
+			mlo_info->hwb_rf_band[i] = BIT(RTW89_BAND_6G);
+			break;
+		case RTW89_MR_CTX2_2GHZ_5GHZ:
+			mlo_info->hwb_rf_band[i] = BIT(RTW89_BAND_2G) |
+						    BIT(RTW89_BAND_5G);
+			break;
+		case RTW89_MR_CTX2_2GHZ_6GHZ:
+			mlo_info->hwb_rf_band[i] = BIT(RTW89_BAND_2G) |
+						    BIT(RTW89_BAND_6G);
+			break;
+		case RTW89_MR_CTX2_5GHZ_6GHZ:
+			mlo_info->hwb_rf_band[i] = BIT(RTW89_BAND_5G) |
+						    BIT(RTW89_BAND_6G);
+			break;
+		}
 		mlo_info->wmode[i] = qinfo.wmode;
 		mlo_info->ch_type[i] = qinfo.ctxtype;
 		mlo_info->wtype = qinfo.wtype;
-
-		if (mlo_info->ch_type[i] == RTW89_MR_CTX1_5GHZ ||
-		    mlo_info->ch_type[i] == RTW89_MR_CTX2_5GHZ ||
-		    mlo_info->ch_type[i] == RTW89_MR_CTX2_5GHZ_6GHZ)
-			mlo_info->hwb_rf_band[i] = RTW89_BAND_5G;
-		else if (mlo_info->ch_type[i] == RTW89_MR_CTX1_6GHZ ||
-			 mlo_info->ch_type[i] == RTW89_MR_CTX2_6GHZ)
-			mlo_info->hwb_rf_band[i] = RTW89_BAND_6G;
-		else /* check if "2G-included" or unknown in each HW-band */
-			mlo_info->hwb_rf_band[i] = RTW89_BAND_2G;
+		wl->rf_band_map[i] = mlo_info->hwb_rf_band[i];
+		ch = &rtwdev->hal.chanctx[i];
+		wl->rf_ch_info[i].center_ch = ch->chan.channel;
+		wl->rf_ch_info[i].band = ch->chan.band_type;
+		wl->rf_ch_info[i].chan = ch->chan.channel;
+		wl->rf_ch_info[i].offset = ch->chan.pri_ch_idx;
+		wl->rf_ch_info[i].bw = ch->chan.band_width;
 	}
 
 	mlo_info->link_status = rtwdev->mlo_dbcc_mode;
@@ -7312,71 +6775,64 @@ static void _update_wl_mlo_info(struct rtw89_dev *rtwdev)
 	default:
 	case MLO_2_PLUS_0_1RF: /* 2+0 */
 	case MLO_2_PLUS_0_2RF:
-		mlo_info->rf_combination = BTC_MLO_RF_2_PLUS_0;
-		track_band = RTW89_MAC_0;
-		rf_band = mlo_info->hwb_rf_band[RTW89_MAC_0];
-		mlo_info->path_rf_band[BTC_RF_S0] = rf_band;
-		mlo_info->path_rf_band[BTC_RF_S1] = rf_band;
-
+		_update_wl_link_mode(rtwdev, RTW89_MAC_0, type);
+		wl_rinfo->link_mode_hb1 = wl_rinfo->link_mode;
 		wl_rinfo->pta_req_band = RTW89_MAC_0;
 		wl_rinfo->dbcc_2g_phy = RTW89_PHY_0;
 		wl_rinfo->dbcc_en = 0;
+
+		rf_band = wl->rf_band_map[RTW89_PHY_0];
+		mlo_info->path_rf_band[BTC_RF_S0] = rf_band;
+		mlo_info->path_rf_band[BTC_RF_S1] = rf_band;
 		break;
 	case MLO_0_PLUS_2_1RF: /* 0+2 */
 	case MLO_0_PLUS_2_2RF:
-		mlo_info->rf_combination = BTC_MLO_RF_0_PLUS_2;
-		track_band = RTW89_MAC_1;
-		rf_band = mlo_info->hwb_rf_band[RTW89_MAC_1];
-		mlo_info->path_rf_band[BTC_RF_S0] = rf_band;
-		mlo_info->path_rf_band[BTC_RF_S1] = rf_band;
-
+		_update_wl_link_mode(rtwdev, RTW89_MAC_1, type);
+		wl_rinfo->link_mode_hb1 = wl_rinfo->link_mode;
 		wl_rinfo->pta_req_band = RTW89_MAC_1;
 		wl_rinfo->dbcc_2g_phy = RTW89_PHY_1;
 		wl_rinfo->dbcc_en = 0;
+
+		rf_band = wl->rf_band_map[RTW89_PHY_1];
+		mlo_info->path_rf_band[BTC_RF_S0] = rf_band;
+		mlo_info->path_rf_band[BTC_RF_S1] = rf_band;
 		break;
 	case MLO_1_PLUS_1_1RF: /* 1+1 */
 	case MLO_1_PLUS_1_2RF: /* 1+1 */
 	case MLO_2_PLUS_2_2RF: /* 2+2 */
 	case DBCC_LEGACY: /* DBCC 1+1 */
-		if (mlo_info->link_status == MLO_2_PLUS_2_2RF)
-			mlo_info->rf_combination = BTC_MLO_RF_2_PLUS_2;
-		else
-			mlo_info->rf_combination = BTC_MLO_RF_1_PLUS_1;
-
-		if (mlo_info->hwb_rf_band[RTW89_MAC_0] == RTW89_BAND_2G)
-			track_band = RTW89_MAC_0;
+		/* Check ch count from ch_type and modify type*/
+		if (mlo_info->ch_type[hw_band] == RTW89_MR_CTX1_2GHZ ||
+		    mlo_info->ch_type[hw_band] == RTW89_MR_CTX1_5GHZ ||
+		    mlo_info->ch_type[hw_band] == RTW89_MR_CTX1_6GHZ)
+			type = RTW89_MR_WTYPE_NONMLD; /* only 1-role */
 		else
-			track_band = RTW89_MAC_1;
+			type = RTW89_MR_WTYPE_NONMLD_NONMLD;
 
-		mlo_info->path_rf_band[BTC_RF_S0] =
-					mlo_info->hwb_rf_band[RTW89_MAC_0];
-		mlo_info->path_rf_band[BTC_RF_S1] =
-					mlo_info->hwb_rf_band[RTW89_MAC_1];
+		rf_band = wl->rf_band_map[hw_band];
+		_update_wl_link_mode(rtwdev, hw_band, type);
 
-		/* Check ch count from ch_type @ 2.4G HW-band, and modify type */
-		if (mlo_info->ch_type[track_band] == RTW89_MR_CTX1_2GHZ)
-			type = RTW89_MR_WTYPE_NONMLD; /* only 1-role at 2G */
-		else
-			type = RTW89_MR_WTYPE_NONMLD_NONMLD;
+		if (hw_band == RTW89_MAC_0) {
+			mlo_info->path_rf_band[BTC_RF_S0] = rf_band;
+		} else {
+			wl_rinfo->link_mode_hb1 = wl_rinfo->link_mode;
+			mlo_info->path_rf_band[BTC_RF_S1] = rf_band;
+		}
 
-		if (mlo_info->hwb_rf_band[RTW89_MAC_0] == RTW89_BAND_2G) {
+		/* set pta_req_band for 1-PTA architecture */
+		if (wl->rf_band_map[RTW89_MAC_0] & BIT(RTW89_BAND_2G)) {
 			wl_rinfo->pta_req_band = RTW89_MAC_0;
 			wl_rinfo->dbcc_2g_phy = RTW89_PHY_0;
-		} else {
+		} else if (wl->rf_band_map[RTW89_MAC_1] & BIT(RTW89_BAND_2G)) {
 			wl_rinfo->pta_req_band = RTW89_MAC_1;
 			wl_rinfo->dbcc_2g_phy = RTW89_PHY_1;
+		} else { /* Both HW-BAND are not on 2.4G*/
+			wl_rinfo->pta_req_band = RTW89_MAC_0;
+			wl_rinfo->dbcc_2g_phy = RTW89_PHY_0;
 		}
-
-		if (mlo_info->wmode[RTW89_MAC_0] == RTW89_MR_WMODE_NONE &&
-		    mlo_info->wmode[RTW89_MAC_1] == RTW89_MR_WMODE_NONE)
-			wl_rinfo->dbcc_en = 0;
-		else
-			wl_rinfo->dbcc_en = 1;
 		break;
 	}
 
-	wl_rinfo->link_mode = _update_wl_link_mode(rtwdev, track_band, type);
-
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(), mode=%s, pta_band=%d",
 		    __func__, id_to_linkmode(wl_rinfo->link_mode),
 		    wl_rinfo->pta_req_band);
@@ -7386,16 +6842,19 @@ static void _update_wl_non_mlo_info(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
 	struct rtw89_btc_wl_rlink *rlink = NULL;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
+	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_chdef cid_ch[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
 	u8 cid_role[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
 	u8 cid_phy[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
 	bool b2g = false, b5g = false, outloop = false;
+	bool notv10 = rtwdev->btc.ver->fwlrole != 10;
+	u8 mode_v0 = BTC_WLINK_V0_NOLINK;
 	u8 mode = BTC_WLINK_NOLINK;
 	u8 cnt_2g = 0, cnt_5g = 0;
 	u8 i, j, cnt = 0;
 
 	for (j = RTW89_PHY_0; j < RTW89_PHY_NUM; j++) {
+		wl->rf_band_map[j] = 0; /* j=link id, is the link use which band */
 		for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
 			rlink = &wl_rinfo->rlink[i][j];
 
@@ -7419,6 +6878,7 @@ static void _update_wl_non_mlo_info(struct rtw89_dev *rtwdev)
 				cnt_2g++;
 				b2g = true;
 			}
+			wl->rf_band_map[j] |= BIT(rlink->rf_band);
 		}
 		if (outloop)
 			break;
@@ -7427,56 +6887,73 @@ static void _update_wl_non_mlo_info(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): cnt_2g=%d, cnt_5g=%d\n", __func__, cnt_2g, cnt_5g);
 
+	wl_rinfo->pta_req_band = RTW89_PHY_0; /* no 0+2 for non-MLO */
 	wl_rinfo->dbcc_en = rtwdev->dbcc_en;
+
 	/* Be careful to change the following sequence!! */
 	if (cnt == 0) {
 		mode = BTC_WLINK_NOLINK;
-	} else if (!b2g && b5g) {
-		mode = BTC_WLINK_5G;
+		mode_v0 = BTC_WLINK_V0_NOLINK;
 	} else if (wl_rinfo->dbcc_en) {
-		mode = _chk_dbcc(rtwdev, cid_ch, cid_phy, cid_role, cnt);
+		/* update pta_req_band to 2.4GHz HW-BAND for DBCC = 1*/
+		mode = _chk_dbcc(rtwdev, cid_ch, cid_phy, cid_role, cnt, notv10);
+		mode_v0 = wl_rinfo->link_mode_v0;
+	} else if (!b2g && b5g && notv10) {
+		mode_v0 = BTC_WLINK_V0_5G;
 	} else if (b2g && b5g) {
-		mode = BTC_WLINK_25G_MCC;
-	} else if (!b5g && cnt >= 2) {
-		if (_chk_role_ch_group(&cid_ch[0], &cid_ch[1]))
-			mode = BTC_WLINK_2G_SCC;
-		else
-			mode = BTC_WLINK_2G_MCC;
-	} else if (!b5g) { /* cnt_connect = 1 */
-		mode = _get_role_link_mode(cid_role[0]);
+		mode = BTC_WLINK_DB_MCC;
+		mode_v0 = BTC_WLINK_V0_25G_MCC;
+	} else if (cnt >= 2) {
+		if (_chk_role_ch_group(&cid_ch[0], &cid_ch[1])) {
+			mode = BTC_WLINK_SCC;
+			mode_v0 = BTC_WLINK_V0_2G_SCC;
+		} else {
+			mode = BTC_WLINK_SB_MCC;
+			mode_v0 = BTC_WLINK_V0_2G_MCC;
+		}
+	} else {
+		mode = _get_role_link_mode(wl_rinfo, cid_role[0], notv10);
 	}
 
 	wl_rinfo->link_mode = mode;
+	wl_rinfo->link_mode_hb1 = mode;
+	wl_rinfo->link_mode_v0 = mode_v0;
 }
 
-static void _modify_role_link_mode(struct rtw89_dev *rtwdev)
+static void _modify_role_link_mode(struct rtw89_dev *rtwdev, u8 hw_band)
 {
-	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	u8 go_cleint_exist = wl->go_client_exist;
-	u8 link_mode = wl_rinfo->link_mode;
+	u8 *link_mode = &wl_rinfo->link_mode;
 	u32 role_map = wl_rinfo->role_map;
 	u8 noa_exist = wl->noa_exist;
 	u32 mrole = BTC_WLMROLE_NONE;
 
+	if (hw_band == RTW89_PHY_1) {
+		*link_mode = wl_rinfo->link_mode_hb1;
+		role_map = wl_rinfo->role_map_hb1;
+		go_cleint_exist = wl->go_client_exist_hb1;
+	}
+
 	/* if no client_joined, don't care P2P-GO/AP role */
 	if (((role_map & BIT(RTW89_WIFI_ROLE_P2P_GO)) ||
-	     (role_map & BIT(RTW89_WIFI_ROLE_AP))) && !go_cleint_exist) {
-		if (link_mode == BTC_WLINK_2G_SCC) {
-			wl_rinfo->link_mode = BTC_WLINK_2G_STA;
-		} else if (link_mode == BTC_WLINK_2G_GO ||
-			   link_mode == BTC_WLINK_2G_AP) {
-			wl_rinfo->link_mode = BTC_WLINK_NOLINK;
+	      (role_map & BIT(RTW89_WIFI_ROLE_AP))) && !go_cleint_exist) {
+		if (*link_mode == BTC_WLINK_SCC) {
+			*link_mode = BTC_WLINK_STA;
+		} else if (*link_mode == BTC_WLINK_GO ||
+			   *link_mode == BTC_WLINK_AP) {
+			*link_mode = BTC_WLINK_NOLINK;
 		}
 	}
 
-	/* Identify 2-Role type */
-	if  (link_mode == BTC_WLINK_2G_SCC ||
-	     link_mode == BTC_WLINK_2G_MCC ||
-	     link_mode == BTC_WLINK_25G_MCC ||
-	     link_mode == BTC_WLINK_5G) {
+	/* Identify 2-Role type  */
+	if  (*link_mode == BTC_WLINK_SCC ||
+	     *link_mode == BTC_WLINK_SB_MCC ||
+	     *link_mode == BTC_WLINK_DB_MCC) {
 		if ((role_map & BIT(RTW89_WIFI_ROLE_P2P_GO)) ||
-		    (role_map & BIT(RTW89_WIFI_ROLE_AP))) {
+		     (role_map & BIT(RTW89_WIFI_ROLE_AP))) {
 			if (noa_exist)
 				mrole = BTC_WLMROLE_STA_GO_NOA;
 			else
@@ -7489,127 +6966,147 @@ static void _modify_role_link_mode(struct rtw89_dev *rtwdev)
 		} else {
 			mrole = BTC_WLMROLE_STA_STA;
 		}
-	}
 
-	wl_rinfo->mrole_type = mrole;
+		if (hw_band == RTW89_PHY_0) {
+			wl_rinfo->mrole_type &= GENMASK(31, 16); /* clear Low-Word */
+			wl_rinfo->mrole_type |= mrole;
+		} else {
+			wl_rinfo->mrole_type &= GENMASK(15, 0); /* clear high-Word */
+			wl_rinfo->mrole_type |= (mrole << 16);
+		}
+	} else {
+		wl_rinfo->mrole_type = BTC_WLMROLE_NONE;
+	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): link_mode=%s, mrole_type=%d\n", __func__,
 		    id_to_linkmode(wl_rinfo->link_mode), wl_rinfo->mrole_type);
 }
 
-static void _update_wl_info_v8(struct rtw89_dev *rtwdev, u8 role_id, u8 rlink_id,
-			       enum btc_role_state state)
+static void _update_wl_info(struct rtw89_dev *rtwdev, struct rtw89_btc_wl_link_info *wl_linfo)
 {
-	struct rtw89_btc_wl_rlink *rlink = NULL;
-	struct rtw89_btc_wl_link_info *wl_linfo;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
-	bool client_joined = false, noa_exist = false, p2p_exist = false;
-	bool is_5g_hi_channel = false, bg_mode = false, dbcc_en_ori;
-	u8 i, j, link_mode_ori;
+	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
+	struct rtw89_btc_wl_rlink *rlink = NULL;
+	u8 dbcc_en_ori, is_5g_hi_ch = 0, bg_mode = 0, p2p_exist = 0;
+	u8 go_client_exist = 0, noa_exist = 0;
+	u8 rlink_id = wl_linfo->phy;
+	u8 role_id = wl_linfo->pid;
+	u8 i, link_mode_ori;
 	u32 role_map = 0;
 
-	if (role_id >= RTW89_BE_BTC_WL_MAX_ROLE_NUMBER || rlink_id >= RTW89_MAC_NUM)
+	if (role_id >= RTW89_BE_BTC_WL_MAX_ROLE_NUMBER || rlink_id >= RTW89_BAND_NUM)
 		return;
 
-	/* Extract wl->link_info[role_id][rlink_id] to wl->role_info
+	/*
+	 * Extract wl->link_info[role_id][rlink_id] to wl->role_info
 	 * role_id: role index
 	 * rlink_id: rlink index (= HW-band index)
 	 * pid: port_index
 	 */
-
-	wl_linfo = &wl->rlink_info[role_id][rlink_id];
 	rlink = &wl_rinfo->rlink[role_id][rlink_id];
 
 	rlink->role = wl_linfo->role;
 	rlink->active = wl_linfo->active; /* Doze or not */
 	rlink->pid = wl_linfo->pid;
+	rlink->mac_id = wl_linfo->mac_id;
 	rlink->phy = wl_linfo->phy;
-	rlink->rf_band = wl_linfo->band;
-	rlink->ch = wl_linfo->ch;
-	rlink->bw = wl_linfo->bw;
+	rlink->rf_band = wl_linfo->chdef.band;
+	rlink->ch = wl_linfo->chdef.center_ch;
+	rlink->bw = wl_linfo->chdef.bw;
 	rlink->noa = wl_linfo->noa;
 	rlink->noa_dur = wl_linfo->noa_duration / 1000;
 	rlink->client_cnt = wl_linfo->client_cnt;
 	rlink->mode = wl_linfo->mode;
 
+	/* check if rlink connect? */
 	switch (wl_linfo->connected) {
 	case MLME_NO_LINK:
 		rlink->connected = 0;
 		break;
 	case MLME_LINKED:
 		rlink->connected = 1;
+
+		/* reset special-AP flag if station mode linked */
+		dm->leak_ap = 0;
 		break;
 	default:
 		return;
 	}
 
-	for (j = RTW89_MAC_0; j <= RTW89_MAC_1; j++) {
-		for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
-			rlink = &wl_rinfo->rlink[i][j];
-
-			if (!rlink->active || !rlink->connected)
-				continue;
+	/* update by HW-Band */
+	for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) { /* i = role_id */
+		rlink = &wl_rinfo->rlink[i][rlink_id];
 
-			role_map |= BIT(rlink->role);
+		if (!rlink->active || !rlink->connected)
+			continue;
 
-			/* only one noa-role exist */
-			if (rlink->noa && rlink->noa_dur > 0)
-				noa_exist = true;
+		role_map |= BIT(rlink->role);
 
-			/* for WL 5G-Rx interfered with BT issue */
-			if (rlink->rf_band == RTW89_BAND_5G) {
-				if (rlink->ch >= 100)
-					is_5g_hi_channel = true;
+		/* Identify if P2P-Go (GO/GC/AP) exist at 2GHz band */
+		if (((rlink->role == RTW89_WIFI_ROLE_P2P_GO ||
+		      rlink->role == RTW89_WIFI_ROLE_AP) &&
+		     rlink->client_cnt > 1)) {
+			p2p_exist = 1;
+			go_client_exist = 1;
+		}
 
-				continue;
-			}
+		if (rlink->role == RTW89_WIFI_ROLE_P2P_CLIENT)
+			p2p_exist = 1;
 
-			/* only if client connect for p2p-Go/AP */
-			if ((rlink->role == RTW89_WIFI_ROLE_P2P_GO ||
-			     rlink->role == RTW89_WIFI_ROLE_AP) &&
-			     rlink->client_cnt > 1) {
-				p2p_exist = true;
-				client_joined = true;
-			}
+		/* only one noa-role exist */
+		if (rlink->noa && rlink->noa_dur > 0)
+			noa_exist = 1;
 
-			/* Identify if P2P-Go (GO/GC/AP) exist at 2G band */
-			if (rlink->role == RTW89_WIFI_ROLE_P2P_CLIENT)
-				p2p_exist = true;
+		/* for WL 5G-Rx interfered with BT issue */
+		if (rlink->rf_band == RTW89_BAND_5G && rlink->ch >= 100)
+			is_5g_hi_ch = 1;
 
-			if ((rlink->mode & BIT(BTC_WL_MODE_11B)) ||
-			    (rlink->mode & BIT(BTC_WL_MODE_11G)))
-				bg_mode = true;
-		}
+		if ((rlink->mode & BIT(BTC_WL_MODE_11B)) ||
+		    (rlink->mode & BIT(BTC_WL_MODE_11G)))
+			bg_mode = 1;
 	}
 
-	link_mode_ori = wl_rinfo->link_mode;
-	wl->is_5g_hi_channel = is_5g_hi_channel;
-	wl->bg_mode = bg_mode;
-	wl->go_client_exist = client_joined;
-	wl->noa_exist = noa_exist;
-	wl_rinfo->p2p_2g = p2p_exist;
-	wl_rinfo->role_map = role_map;
+	if (rlink_id == RTW89_PHY_0) {
+		link_mode_ori = wl_rinfo->link_mode;
+		wl->is_5g_hi_ch = is_5g_hi_ch;
+		wl->bg_mode = bg_mode;
+		wl->go_client_exist = go_client_exist;
+		wl->noa_exist = noa_exist;
+		wl_rinfo->p2p_exist = p2p_exist;
+		wl_rinfo->role_map = role_map;
+	} else {
+		link_mode_ori = wl_rinfo->link_mode_hb1;
+		wl->is_5g_hi_ch_hb1 = is_5g_hi_ch;
+		wl->bg_mode_hb1 = bg_mode;
+		wl->go_client_exist_hb1 = go_client_exist;
+		wl->noa_exist_hb1 = noa_exist;
+		wl_rinfo->p2p_exist_hb1 = p2p_exist;
+		wl_rinfo->role_map_hb1 = role_map;
+	}
 
 	dbcc_en_ori = wl_rinfo->dbcc_en;
 
+	/* for MLO-supported, link-mode from driver directly */
 	if (rtwdev->chip->para_ver & BTC_FEAT_MLO_SUPPORT) {
-		/* for MLO-supported, link-mode from driver directly */
-		_update_wl_mlo_info(rtwdev);
-	} else {
-		/* for non-MLO-supported, link-mode by BTC */
+		_update_wl_mlo_info(rtwdev, rlink_id);
+	} else { /* for non-MLO-supported, link-mode by BTC */
 		_update_wl_non_mlo_info(rtwdev);
 	}
 
-	_modify_role_link_mode(rtwdev);
+	_modify_role_link_mode(rtwdev, rlink_id);
 
-	if (link_mode_ori != wl_rinfo->link_mode)
-		wl->link_mode_chg = true;
+	if ((rlink_id == RTW89_PHY_0 && wl_rinfo->link_mode != link_mode_ori) ||
+	    (rlink_id == RTW89_PHY_1 && wl_rinfo->link_mode_hb1 != link_mode_ori)) {
+		wl_rinfo->link_mode_chg = 1;
+		wl->link_mode_chg = 1;
+	}
 
 	if (wl_rinfo->dbcc_en != dbcc_en_ori) {
-		wl->dbcc_chg = true;
+		wl->dbcc_chg = 1;
+		wl->role_info.dbcc_chg = 1;
 		wl->wcnt[BTC_WCNT_DBCC_CHG]++;
 	}
 }
@@ -7685,25 +7182,21 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, u8 bid)
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_bt_info *bt;
 	u32 val, any_bt_connect, any_bt_6g_connect = 0;
-	u8 id, id_start, id_stop, mode;
+	u8 id, id_start, id_stop, mode = 0;
 	bool bt_link_change = false;
 	bool lps_ctrl = false;
 
 	if (!rtwdev->chip->scbd || bid > BTC_ALL_BT)
 		return;
 
-	if (ver->fwlrole == 0)
-		mode = wl->role_info.link_mode;
-	else if (ver->fwlrole == 1)
-		mode = wl->role_info_v1.link_mode;
-	else if (ver->fwlrole == 2)
-		mode = wl->role_info_v2.link_mode;
-	else if (ver->fwlrole == 7)
-		mode = wl->role_info_v7.link_mode;
-	else if (ver->fwlrole == 8)
-		mode = wl->role_info_v8.link_mode;
-	else
-		return;
+	if (ver->fwlrole == 10) {
+		if (wl->role_info.link_mode == BTC_WLINK_STA &&
+		    (dm->tdd_en && wl->rf_band_map[RTW89_MAC_0] &
+		     BIT(RTW89_BAND_2G)))
+			mode = BTC_WLINK_V0_2G_STA;
+	} else {
+		mode = wl->role_info.link_mode_v0;
+	}
 
 	if (bid == BTC_ALL_BT) {
 		id_start = BTC_BT_1ST;
@@ -7796,7 +7289,7 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, u8 bid)
 		if (((bt->link_info.a2dp_desc.exist ||
 		      bt->link_info.pan_desc.exist ||
 		      bt->link_info.hfp_desc.exist) &&
-		     mode == BTC_WLINK_2G_STA) ||
+		     mode == BTC_WLINK_V0_2G_STA) ||
 		    bt->whql_test)
 			lps_ctrl = true;
 
@@ -7900,7 +7393,12 @@ static void _set_bind_info(struct rtw89_btc *btc, u8 type)
 	 * HW-Band is decided by wl->mlo_info.mrcx_act_hwb_map
 	 */
 	if (wl->mlo_info.wtype == RTW89_MR_WTYPE_MLD2L1R_NONMLD) {
-		/* TODO: Should patched WiFi mode & WiFi role patch */
+		if (wl->role_info.link_mode != BTC_WLINK_DB_MCC) { /* mode chg */
+			if (wl->mlo_info.mrcx_act_hwb_map == BIT(RTW89_MAC_1))
+				path_hwb[BTC_RF_S0] = RTW89_PHY_1; /* S0/1->HWB1 */
+			else
+				path_hwb[BTC_RF_S1] = RTW89_PHY_0; /* S0/1->HWB0 */
+		}
 	} else {
 		/*
 		 * Dual-RF_band(HWB)TDMA if BT-profile is TDMA-type at both
@@ -7933,7 +7431,22 @@ static void _set_bind_info(struct rtw89_btc *btc, u8 type)
 		}
 	}
 
-	/* TODO: Should patched WiFi mode & WiFi role patch */
+	if (wl->mlo_info.wtype == RTW89_MR_WTYPE_MLD2L2R &&
+	    (bd->wl_hwb_sel == (BIT(RTW89_MAC_1) | BIT(RTW89_MAC_0)))) {
+		if (wl->role_info.link_mode == BTC_WLINK_AP ||
+		    wl->role_info.link_mode_hb1 == BTC_WLINK_AP)
+			bd->wl_link_mode = BTC_WLINK_DB_MCC;
+		else
+			bd->wl_link_mode = BTC_WLINK_STA;
+		bd->wl_bg_mode = wl->bg_mode | wl->bg_mode_hb1;
+	} else if (bd->wl_hwb_sel == (BIT(RTW89_MAC_1))) {
+		bd->wl_link_mode = wl->role_info.link_mode_hb1;
+		bd->wl_bg_mode = wl->bg_mode_hb1;
+	} else {/* HW-BAND-0 or no-hw-band */
+		bd->wl_hwb_sel = BIT(RTW89_MAC_0);
+		bd->wl_link_mode = wl->role_info.link_mode;
+		bd->wl_bg_mode = wl->bg_mode;
+	}
 
 	/* update Bind-BT status map for BT0/BT1 */
 	for (i = BTC_BT_1ST; i < BTC_ALL_BT_EZL; i++) {
@@ -7966,9 +7479,9 @@ static void _set_bind_info(struct rtw89_btc *btc, u8 type)
 			bd->bt_smap.a2dp_sink |= b->a2dp_desc.sink;
 			bd->bt_smap.pan_active |= b->pan_desc.active;
 			bd->bt_smap.connect |= b->status.map.connect;
-			bd->bt_smap.hid_cnt += (u8)b->hid_desc.pair_cnt;
+			bd->bt_smap.hid_cnt += b->hid_desc.pair_cnt;
 			bd->bt_smap.hid_type |= b->hid_desc.type;
-			bd->bt_smap.cis_cnt += (u8)b->leaudio_desc.cis_cnt;
+			bd->bt_smap.cis_cnt += b->leaudio_desc.cis_cnt;
 			bd->bt_smap.link_cnt += b->link_cnt.now;
 			bd->bt_smap.inq_page |= b->status.map.inq_pag;
 			bd->bt_smap.page |= b->pag;
@@ -8028,7 +7541,7 @@ static void _set_coex_binding(struct rtw89_btc *btc)
 	 * ==> 1: interference, 0: no-interference
 	 *
 	 * fdm_map(Frequency-Division-Multiplexing): WL/BT RF_Band overlap-map
-	 * 2bit-map: bit[1]:5GHz/6GHz, bit[0]:2.4GHz
+	 * 2bit-map: bit[1]:5/6GHz, bit[0]:2.4GHz
 	 */
 	for (i = 0; i < RTW89_PHY_NUM; i++) {
 		if (wl->rf_band_map[i] & BIT(RTW89_BAND_2G))
@@ -8050,9 +7563,7 @@ static void _set_coex_binding(struct rtw89_btc *btc)
 	 * In this case, BTC_RF_S0->HWB0, BTC_RF_S1->HWB1
 	 */
 	if (wl->mlo_info.wtype == RTW89_MR_WTYPE_MLD2L1R_NONMLD) {
-		if (wl->role_info.link_mode != BTC_WLINK_2G_MCC &&
-		    wl->role_info.link_mode != BTC_WLINK_25G_MCC &&
-		    wl->role_info.link_mode != BTC_WLINK_25G_DBCC) {/* mode chg */
+		if (wl->role_info.link_mode != BTC_WLINK_DB_MCC) {/* mode chg */
 			if (wl->mlo_info.mrcx_act_hwb_map == BIT(RTW89_PHY_1))
 				path_hwb[BTC_RF_S0] = RTW89_PHY_1;/* S0/1->HWB1 */
 			else
@@ -8114,31 +7625,14 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
-	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
-	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
-	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
-	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
-	u8 mode, igno_bt, always_freerun;
+	u8 mode = btc->dm.tdd_bind.wl_link_mode;
+	u8 mode_v0 = wl->role_info.link_mode_v0;
+	u8 igno_bt, always_freerun;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	dm->run_reason = reason;
 	_update_dm_step(rtwdev, reason);
-	_update_btc_state_map(rtwdev);
-
-	if (ver->fwlrole == 0)
-		mode = wl_rinfo->link_mode;
-	else if (ver->fwlrole == 1)
-		mode = wl_rinfo_v1->link_mode;
-	else if (ver->fwlrole == 2)
-		mode = wl_rinfo_v2->link_mode;
-	else if (ver->fwlrole == 7)
-		mode = wl_rinfo_v7->link_mode;
-	else if (ver->fwlrole == 8)
-		mode = wl_rinfo_v8->link_mode;
-	else
-		return;
 
 	if (ver->fcxctrl == 7) {
 		igno_bt = btc->ctrl.ctrl_v7.igno_bt;
@@ -8206,6 +7700,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	igno_bt = false;
 
 	_set_coex_binding(btc);
+	_update_btc_state_map(rtwdev);
 
 	dm->freerun_chk = _check_freerun(rtwdev); /* check if meet freerun */
 
@@ -8253,43 +7748,76 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		goto exit;
 	}
 
-	switch (mode) {
+	if (mode == BTC_WLINK_NOLINK) {
+		mode_v0 = BTC_WLINK_V0_NOLINK;
+	} else if (btc->dm.tdd_bind.rf_band == BIT(RTW89_BAND_5G)) {
+		mode_v0 = BTC_WLINK_V0_5G;
+	} else if (btc->dm.tdd_bind.rf_band & BIT(RTW89_BAND_5G) &&
+		   btc->dm.tdd_bind.rf_band & BIT(RTW89_BAND_2G)) {
+		mode_v0 = BTC_WLINK_V0_25G_MCC;
+	} else if (btc->dm.tdd_bind.rf_band == BIT(RTW89_BAND_2G)) {
+		switch (mode) {
+		case BTC_WLINK_STA:
+			mode_v0 = BTC_WLINK_V0_2G_STA;
+			break;
+		case BTC_WLINK_AP:
+			mode_v0 = BTC_WLINK_V0_2G_AP;
+			break;
+		case BTC_WLINK_GO:
+			mode_v0 = BTC_WLINK_V0_2G_GO;
+			break;
+		case BTC_WLINK_GC:
+			mode_v0 = BTC_WLINK_V0_2G_GC;
+			break;
+		case BTC_WLINK_SCC:
+			mode_v0 = BTC_WLINK_V0_2G_SCC;
+			break;
+		case BTC_WLINK_SB_MCC:
+			mode_v0 = BTC_WLINK_V0_2G_MCC;
+			break;
+		default:
+			mode_v0 = BTC_WLINK_V0_OTHER;
+			break;
+		}
+	}
+
+	switch (mode_v0) {
 	case BTC_WLINK_NOLINK:
 		_action_wl_nc(rtwdev);
 		break;
-	case BTC_WLINK_2G_STA:
+	case BTC_WLINK_V0_2G_STA:
 		if (wl->status.map.traffic_dir & BIT(RTW89_TFC_DL))
 			bt->scan_rx_low_pri = true;
 		_action_wl_2g_sta(rtwdev);
 		break;
-	case BTC_WLINK_2G_AP:
+	case BTC_WLINK_V0_2G_AP:
 		bt->scan_rx_low_pri = true;
 		_action_wl_2g_ap(rtwdev);
 		break;
-	case BTC_WLINK_2G_GO:
+	case BTC_WLINK_V0_2G_GO:
 		bt->scan_rx_low_pri = true;
 		_action_wl_2g_go(rtwdev);
 		break;
-	case BTC_WLINK_2G_GC:
+	case BTC_WLINK_V0_2G_GC:
 		bt->scan_rx_low_pri = true;
 		_action_wl_2g_gc(rtwdev);
 		break;
-	case BTC_WLINK_2G_SCC:
+	case BTC_WLINK_V0_2G_SCC:
 		bt->scan_rx_low_pri = true;
 		_action_wl_2g_scc(rtwdev);
 		break;
-	case BTC_WLINK_2G_MCC:
+	case BTC_WLINK_V0_2G_MCC:
 		bt->scan_rx_low_pri = true;
 		_action_wl_2g_mcc(rtwdev);
 		break;
-	case BTC_WLINK_25G_MCC:
+	case BTC_WLINK_V0_25G_MCC:
 		bt->scan_rx_low_pri = true;
 		_action_wl_25g_mcc(rtwdev);
 		break;
-	case BTC_WLINK_5G:
+	case BTC_WLINK_V0_5G:
 		_action_wl_5g(rtwdev);
 		break;
-	case BTC_WLINK_2G_NAN:
+	case BTC_WLINK_V0_2G_NAN:
 		_action_wl_2g_nan(rtwdev);
 		break;
 	default:
@@ -8678,22 +8206,6 @@ static u8 _update_bt_rssi_level(struct rtw89_dev *rtwdev, u8 rssi)
 	return rssi_level;
 }
 
-static void _update_zb_coex_tbl(struct rtw89_dev *rtwdev)
-{
-	u8 mode = rtwdev->btc.cx.wl.role_info.link_mode;
-	u32 zb_tbl0 = 0xda5a5a5a, zb_tbl1 = 0xda5a5a5a;
-
-	if (mode == BTC_WLINK_5G || rtwdev->btc.dm.freerun) {
-		zb_tbl0 = 0xffffffff;
-		zb_tbl1 = 0xffffffff;
-	} else if (mode == BTC_WLINK_25G_MCC) {
-		zb_tbl0 = 0xffffffff; /* for E5G slot */
-		zb_tbl1 = 0xda5a5a5a; /* for E2G slot */
-	}
-	rtw89_write32(rtwdev, R_BTC_ZB_COEX_TBL_0, zb_tbl0);
-	rtw89_write32(rtwdev, R_BTC_ZB_COEX_TBL_1, zb_tbl1);
-}
-
 #define BT_PROFILE_PROTOCOL_MASK GENMASK(7, 4)
 
 static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
@@ -8842,11 +8354,10 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 	struct ieee80211_bss_conf *bss_conf;
 	struct ieee80211_link_sta *link_sta;
 	struct rtw89_btc *btc = &rtwdev->btc;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_link_info r = {0};
 	struct rtw89_btc_wl_link_info *wlinfo = NULL;
-	u8 mode = 0, rlink_id, link_mode_ori, pta_req_mac_ori, wa_type;
+	u8 mode = 0;
 
 	rcu_read_lock();
 
@@ -8894,66 +8405,32 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], wifi_role=%d\n", rtwvif_link->wifi_role);
 
-	r.role = rtwvif_link->wifi_role;
-	r.phy = rtwvif_link->phy_idx;
-	r.pid = rtwvif_link->port;
-	r.active = true;
-	r.connected = MLME_LINKED;
-	r.bcn_period = bss_conf->beacon_int;
-	r.dtim_period = bss_conf->dtim_period;
-	r.band = chan->band_type;
-	r.ch = chan->channel;
-	r.bw = chan->band_width;
-	r.chdef.band = chan->band_type;
-	r.chdef.center_ch = chan->channel;
-	r.chdef.bw = chan->band_width;
-	r.chdef.chan = chan->primary_channel;
+	wlinfo = &wl->rlink_info[rtwvif_link->port][rtwvif_link->phy_idx];
+
+	wlinfo->mode = mode;
+	wlinfo->role = rtwvif_link->wifi_role;
+	wlinfo->phy = rtwvif_link->phy_idx;
+	wlinfo->pid = rtwvif_link->port;
+	wlinfo->active = true;
+	wlinfo->connected = MLME_LINKED;
+	wlinfo->bcn_period = bss_conf->beacon_int;
+	wlinfo->dtim_period = bss_conf->dtim_period;
+	wlinfo->band = chan->band_type;
+	wlinfo->ch = chan->channel;
+	wlinfo->bw = chan->band_width;
+	wlinfo->chdef.band = chan->band_type;
+	wlinfo->chdef.center_ch = chan->channel;
+	wlinfo->chdef.bw = chan->band_width;
+	wlinfo->chdef.chan = chan->primary_channel;
 	ether_addr_copy(r.mac_addr, rtwvif_link->mac_addr);
 
 	rcu_read_unlock();
 
 	if (rtwsta_link && vif->type == NL80211_IFTYPE_STATION)
-		r.mac_id = rtwsta_link->mac_id;
+		wlinfo->mac_id = rtwsta_link->mac_id;
 
 	btc->dm.cnt_notify[BTC_NCNT_ROLE_INFO]++;
 
-	wlinfo = &wl->link_info[r.pid];
-
-	if (ver->fwlrole == 0) {
-		*wlinfo = r;
-		_update_wl_info(rtwdev);
-	} else if (ver->fwlrole == 1) {
-		*wlinfo = r;
-		_update_wl_info_v1(rtwdev);
-	} else if (ver->fwlrole == 2) {
-		*wlinfo = r;
-		_update_wl_info_v2(rtwdev);
-	} else if (ver->fwlrole == 7) {
-		*wlinfo = r;
-		_update_wl_info_v7(rtwdev, r.pid);
-	} else if (ver->fwlrole == 8) {
-		rlink_id = rtwvif_link->mac_idx;
-		wlinfo = &wl->rlink_info[r.pid][rlink_id];
-		*wlinfo = r;
-		link_mode_ori = wl->role_info_v8.link_mode;
-		pta_req_mac_ori = wl->pta_req_mac;
-		_update_wl_info_v8(rtwdev, r.pid, rlink_id, state);
-
-		if (wl->role_info_v8.link_mode != link_mode_ori) {
-			wl->role_info_v8.link_mode_chg = 1;
-			if (ver->fcxinit == 7)
-				wa_type = btc->mdinfo.md_v7.wa_type;
-			else
-				wa_type = btc->mdinfo.md.wa_type;
-
-			if (wa_type & BTC_WA_HFP_ZB)
-				_update_zb_coex_tbl(rtwdev);
-		}
-
-		if (wl->pta_req_mac != pta_req_mac_ori)
-			wl->pta_reg_mac_chg = 1;
-	}
-
 	if (wlinfo->role == RTW89_WIFI_ROLE_STATION &&
 	    wlinfo->connected == MLME_NO_LINK)
 		btc->dm.leak_ap = 0;
@@ -8967,6 +8444,8 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 	    state == BTC_ROLE_MSTS_STA_CONN_END)
 		wl->status.map._4way = false;
 
+	_update_wl_info(rtwdev, wlinfo);
+
 	_run_coex(rtwdev, BTC_RSN_NTFY_ROLE_INFO);
 }
 
@@ -9150,15 +8629,14 @@ void __rtw89_btc_ntfy_wl_sta_iter(struct rtw89_vif_link *rtwvif_link,
 	struct rtw89_dev *rtwdev = iter_data->rtwdev;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_link_info *link_info = NULL;
 	struct rtw89_traffic_stats *link_info_t = NULL;
 	struct rtw89_traffic_stats *stats = &rtwvif->stats;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc_wl_role_info *r;
-	struct rtw89_btc_wl_role_info_v1 *r1;
 	u32 last_tx_rate, last_rx_rate;
+	u8 link = rtwvif_link->phy_idx;
 	u16 last_tx_lvl, last_rx_lvl;
 	u8 port = rtwvif_link->port;
 	u8 rssi;
@@ -9171,10 +8649,7 @@ void __rtw89_btc_ntfy_wl_sta_iter(struct rtw89_vif_link *rtwvif_link,
 	rssi = ewma_rssi_read(&rtwsta_link->avg_rssi) >> RSSI_FACTOR;
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], rssi=%d\n", rssi);
 
-	if (btc->ver->fwlrole != 8)
-		link_info = &wl->link_info[port];
-	else
-		link_info = &wl->rlink_info[port][rtwvif_link->mac_idx];
+	link_info = &wl->rlink_info[port][link];
 
 	link_info->stat.traffic = *stats;
 	link_info_t = &link_info->stat.traffic;
@@ -9214,7 +8689,6 @@ void __rtw89_btc_ntfy_wl_sta_iter(struct rtw89_vif_link *rtwvif_link,
 	else
 		dir = RTW89_TFC_DL;
 
-	link_info = &wl->link_info[port];
 	if (link_info->busy != busy || link_info->dir != dir) {
 		is_sta_change = true;
 		link_info->busy = busy;
@@ -9244,19 +8718,11 @@ void __rtw89_btc_ntfy_wl_sta_iter(struct rtw89_vif_link *rtwvif_link,
 		dm->trx_info.rx_rate = link_info_t->rx_rate;
 	}
 
-	if (ver->fwlrole == 0) {
-		r = &wl->role_info;
-		r->active_role[port].tx_lvl = stats->tx_tfc_lv;
-		r->active_role[port].rx_lvl = stats->rx_tfc_lv;
-		r->active_role[port].tx_rate = rtwsta_link->ra_report.hw_rate;
-		r->active_role[port].rx_rate = rtwsta_link->rx_hw_rate;
-	} else if (ver->fwlrole == 1) {
-		r1 = &wl->role_info_v1;
-		r1->active_role_v1[port].tx_lvl = stats->tx_tfc_lv;
-		r1->active_role_v1[port].rx_lvl = stats->rx_tfc_lv;
-		r1->active_role_v1[port].tx_rate = rtwsta_link->ra_report.hw_rate;
-		r1->active_role_v1[port].rx_rate = rtwsta_link->rx_hw_rate;
-	}
+	r = &wl->role_info;
+	r->rlink[port][link].tx_lvl = stats->tx_tfc_lv;
+	r->rlink[port][link].rx_lvl = stats->rx_tfc_lv;
+	r->rlink[port][link].tx_rate = rtwsta_link->ra_report.hw_rate;
+	r->rlink[port][link].rx_rate = rtwsta_link->rx_hw_rate;
 
 	dm->trx_info.tx_lvl = stats->tx_tfc_lv;
 	dm->trx_info.rx_lvl = stats->rx_tfc_lv;
@@ -9584,10 +9050,7 @@ static int _show_wl_role_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 	for (i = 0; i < btc->ver->max_role_num; i++) {
 		for (j = 0; j < RTW89_MAC_NUM; j++) {
-			if (btc->ver->fwlrole == 8)
-				plink = &btc->cx.wl.rlink_info[i][j];
-			else
-				plink = &btc->cx.wl.link_info[i];
+			plink = &btc->cx.wl.rlink_info[i][j];
 
 			if (!plink->active)
 				continue;
@@ -9630,14 +9093,9 @@ static int _show_wl_role_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 static int _show_wl_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
-	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
-	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
-	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
-	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	char *p = buf, *end = buf + bufsz;
 	u8 mode;
 
@@ -9646,18 +9104,7 @@ static int _show_wl_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 	p += scnprintf(p, end - p, "========== [WL Status] ==========\n");
 
-	if (ver->fwlrole == 0)
-		mode = wl_rinfo->link_mode;
-	else if (ver->fwlrole == 1)
-		mode = wl_rinfo_v1->link_mode;
-	else if (ver->fwlrole == 2)
-		mode = wl_rinfo_v2->link_mode;
-	else if (ver->fwlrole == 7)
-		mode = wl_rinfo_v7->link_mode;
-	else if (ver->fwlrole == 8)
-		mode = wl_rinfo_v8->link_mode;
-	else
-		goto out;
+	mode = wl_rinfo->link_mode;
 
 	p += scnprintf(p, end - p, " %-15s : link_mode:%s, ", "[status]",
 		       id_to_linkmode(mode));
@@ -9677,7 +9124,6 @@ static int _show_wl_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 	p += _show_wl_role_info(rtwdev, p, end - p);
 
-out:
 	return p - buf;
 }
 
@@ -9755,6 +9201,8 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	union rtw89_btc_module_info *md = &btc->mdinfo;
 	s8 br_dbm = bt->link_info.bt_txpwr_desc.br_dbm;
 	s8 le_dbm = bt->link_info.bt_txpwr_desc.le_dbm;
+	u8 hw_band = wl->role_info.pta_req_band;
+	struct rtw89_btc_wl_afh_info *wl_afh;
 	char *p = buf, *end = buf + bufsz;
 	u8 *afh = bt_linfo->afh_map;
 	u8 *afh_le = bt_linfo->afh_map_le;
@@ -9822,8 +9270,9 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 			       afh_le[0], afh_le[1], afh_le[2],
 			       afh_le[3], afh_le[4]);
 
-	p += scnprintf(p, end - p, "wl_ch_map[en:%d/ch:%d/bw:%d]\n",
-		       wl->afh_info.en, wl->afh_info.ch, wl->afh_info.bw);
+	wl_afh = &wl->afh_info[hw_band][RTW89_BAND_2G];
+	p += scnprintf(p, end - p, "wl_ch_map[hwb:%d/en:%d/ch:%d/bw:%d/rf_band:%d]\n",
+		       hw_band, wl_afh->en, wl_afh->ch, wl_afh->bw, wl_afh->band);
 
 	p += scnprintf(p, end - p,
 		       " %-15s : retry:%d, relink:%d, rate_chg:%d, reinit:%d, reenable:%d, ",
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 74027ca4eccc..c127bd80d31c 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -11,6 +11,40 @@
 #define BTC_TLV_SLOT_ID_LEN_V7 1
 #define BTC_SLOT_REQ_TH 2
 
+#define BTC_FREQ_W2G 2412
+#define BTC_FREQ_W5G 5005
+#define BTC_FREQ_W6G 5955
+
+#define BTC_FREQ_B2G 2402
+#define BTC_FREQ_B6G 5125
+
+#define BTC_FREQ_W2G_CH14 2484
+
+#define BTC_LO_2G_DNM 125 /* LO Coefficient Denominator */
+#define BTC_LO_5G_DNM 125
+#define BTC_LO_6G_DNM 150
+
+#define BTC_LO_2G_NMR 400 /* LO Coefficient Numerator */
+#define BTC_LO_5G_NMR 200
+#define BTC_LO_6G_NMR 200
+
+#define BTC_CH_W2G_MIN 1    /* start from 2412MHz */
+#define BTC_CH_W2G_MAX 14
+#define BTC_CH_W5G_MIN 1    /* start from 5005MHz */
+#define BTC_CH_W5G_MAX 165
+#define BTC_CH_W6G_MIN 1    /* start from 5955MHz */
+#define BTC_CH_W6G_MAX 233
+
+#define BTC_CH_B2G_MIN 0    /* start from 2402MHz */
+#define BTC_CH_B2G_MAX 78
+
+#define BTC_CH_B5G_MIN 600    /* start from 5725MHz */
+#define BTC_CH_B5G_MAX 1300
+
+#define BTC_VCO_GUARD_W2W 10 /* WiFi to WiFi VCO freq forbiddened range (MHZ) */
+#define BTC_VCO_GUARD_W2B 25 /* WiFi to WiFi VCO freq forbiddened range (MHZ) */
+#define BTC_VCO_GUARD_B2B 10 /* WiFi to WiFi VCO freq forbiddened range (MHZ) */
+
 enum btc_mode {
 	BTC_MODE_NORMAL,
 	BTC_MODE_WL,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 174349c6bc58..ded788534651 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1854,7 +1854,7 @@ union rtw89_btc_wl_role_info_map {
 	struct rtw89_btc_wl_role_info_bpos role;
 };
 
-struct rtw89_btc_wl_role_info { /* struct size must be n*4 bytes */
+struct rtw89_btc_wl_role_info_v0 { /* struct size must be n*4 bytes */
 	u8 connect_cnt;
 	u8 link_mode;
 	union rtw89_btc_wl_role_info_map role_map;
@@ -1891,7 +1891,7 @@ struct rtw89_btc_wl_role_info_v2 { /* struct size must be n*4 bytes */
 	u32 rsvd: 27;
 };
 
-struct rtw89_btc_wl_rlink { /* H2C info, struct size must be n*4 bytes */
+struct rtw89_btc_wl_rlink_v0 { /* H2C info, struct size must be n*4 bytes */
 	u8 connected;
 	u8 pid;
 	u8 phy;
@@ -1908,6 +1908,28 @@ struct rtw89_btc_wl_rlink { /* H2C info, struct size must be n*4 bytes */
 	u8 mode; /* wifi protocol */
 } __packed;
 
+struct rtw89_btc_wl_rlink_v10 { /* H2C info, struct size must be n*4 bytes */
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
+
+	u8 mac_id;
+	u8 rsvd0;
+	u8 rsvd1;
+	u8 rsvd2;
+} __packed;
+
 #define RTW89_BE_BTC_WL_MAX_ROLE_NUMBER 6
 struct rtw89_btc_wl_role_info_v7 { /* struct size must be n*4 bytes */
 	u8 connect_cnt;
@@ -1917,12 +1939,12 @@ struct rtw89_btc_wl_role_info_v7 { /* struct size must be n*4 bytes */
 
 	struct rtw89_btc_wl_active_role_v7 active_role[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER];
 
-	u32 role_map;
-	u32 mrole_type; /* btc_wl_mrole_type */
-	u32 mrole_noa_duration; /* ms */
-	u32 dbcc_en;
-	u32 dbcc_chg;
-	u32 dbcc_2g_phy; /* which phy operate in 2G, HW_PHY_0 or HW_PHY_1 */
+	__le32 role_map;
+	__le32 mrole_type; /* btc_wl_mrole_type */
+	__le32 mrole_noa_duration; /* ms */
+	__le32 dbcc_en;
+	__le32 dbcc_chg;
+	__le32 dbcc_2g_phy; /* which phy operate in 2G, HW_PHY_0 or HW_PHY_1 */
 } __packed;
 
 struct rtw89_btc_wl_role_info_v8 { /* H2C info, struct size must be n*4 bytes */
@@ -1936,12 +1958,90 @@ struct rtw89_btc_wl_role_info_v8 { /* H2C info, struct size must be n*4 bytes */
 	u8 dbcc_chg;
 	u8 dbcc_2g_phy; /* which phy operate in 2G, HW_PHY_0 or HW_PHY_1 */
 
+	struct rtw89_btc_wl_rlink_v0 rlink[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER][RTW89_MAC_NUM];
+
+	__le32 role_map;
+	__le32 mrole_type; /* btc_wl_mrole_type */
+	__le32 mrole_noa_duration; /* ms */
+} __packed;
+
+struct rtw89_btc_wl_role_info_v10 { /* H2C info, struct size must be n*4 bytes */
+	struct rtw89_btc_wl_rlink_v10 rlink[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER][RTW89_MAC_NUM];
+	u8 link_mode;
+	u8 link_mode_hb1;
+	u8 p2p_exist;
+	u8 p2p_exist_hb1;
+
+	u8 pta_req_band;
+	u8 dbcc_en; /* 1+1 and 2.4G-included */
+	u8 dbcc_2g_phy; /* which phy operate in 2G, HW_PHY_0 or HW_PHY_1 */
+	u8 rsvd;
+
+	__le32 role_map;
+	__le32 role_map_hb1;
+	__le32 mrole_type; /* btc_wl_mrole_type: [31:16]:band1, [15:0]:band0 */
+} __packed;
+
+struct rtw89_btc_wl_rlink { /* Logic dynamic using */
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
+
+	/*v0 v1*/
+	u16 tx_lvl;
+	u16 rx_lvl;
+	u16 tx_rate;
+	u16 rx_rate;
+
+	/* v7 */
+	u8 client_ps; /*v7 v2 v1 v0*/
+
+	/* v10 */
+	u8 mac_id;
+	u8 rsvd0;
+	u8 rsvd1;
+	u8 rsvd2;
+};
+
+struct rtw89_btc_wl_role_info { /* Logic dynamic using */
 	struct rtw89_btc_wl_rlink rlink[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER][RTW89_MAC_NUM];
+	u8 link_mode;
+	u8 link_mode_hb1;
+	u8 p2p_exist;
+	u8 p2p_exist_hb1;
+
+	u8 pta_req_band;
+	u8 dbcc_en; /* 1+1 and 2.4G-included */
+	u8 dbcc_2g_phy; /* which phy operate in 2G, HW_PHY_0 or HW_PHY_1 */
+	u8 rsvd;
 
 	u32 role_map;
-	u32 mrole_type; /* btc_wl_mrole_type */
-	u32 mrole_noa_duration; /* ms */
-} __packed;
+	u32 role_map_hb1;
+	u32 mrole_type; /* btc_wl_mrole_type: [31:16]:band1, [15:0]:band0 */
+
+	/* Before v10 use this linkmode */
+	u8 link_mode_v0;
+
+	/* v7 */
+	u8 connect_cnt;
+	u32 dbcc_chg; /* v7 v2*/
+
+	/* v8 */
+	u8 link_mode_chg; /* v8, v7 v2*/
+	u8 p2p_2g; /* v8, v7 */
+	u32 mrole_noa_duration; /* v8, v7 v2*/
+};
 
 struct rtw89_btc_wl_ver_info {
 	u32 fw_coex; /* match with which coex_ver */
@@ -1955,7 +2055,7 @@ struct rtw89_btc_wl_afh_info {
 	u8 en;
 	u8 ch;
 	u8 bw;
-	u8 rsvd;
+	u8 band;
 } __packed;
 
 struct rtw89_btc_wl_rfk_info {
@@ -2167,16 +2267,13 @@ struct rtw89_btc_wl_nhm {
 };
 
 struct rtw89_btc_wl_info {
-	struct rtw89_btc_wl_link_info link_info[RTW89_PORT_NUM];
 	struct rtw89_btc_wl_link_info rlink_info[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER][RTW89_MAC_NUM];
+	struct rtw89_btc_chdef rf_ch_info[RTW89_PHY_NUM];
 	struct rtw89_btc_wl_rfk_info rfk_info;
-	struct rtw89_btc_wl_ver_info  ver_info;
-	struct rtw89_btc_wl_afh_info afh_info;
+	struct rtw89_btc_wl_ver_info ver_info;
+	struct rtw89_btc_wl_afh_info afh_info[RTW89_MAC_NUM][RTW89_BAND_NUM];
+	struct rtw89_btc_wl_afh_info afh_info_last[RTW89_MAC_NUM][RTW89_BAND_NUM];
 	struct rtw89_btc_wl_role_info role_info;
-	struct rtw89_btc_wl_role_info_v1 role_info_v1;
-	struct rtw89_btc_wl_role_info_v2 role_info_v2;
-	struct rtw89_btc_wl_role_info_v7 role_info_v7;
-	struct rtw89_btc_wl_role_info_v8 role_info_v8;
 	struct rtw89_btc_wl_scan_info scan_info;
 	struct rtw89_btc_wl_dbcc_info dbcc_info;
 	struct rtw89_btc_wl_mlo_info mlo_info;
@@ -2191,12 +2288,18 @@ struct rtw89_btc_wl_info {
 	u8 pta_req_mac;
 	u8 bt_polut_type[RTW89_PHY_NUM]; /* BT polluted WL-Tx type for phy0/1  */
 	u8 rf_band_map[RTW89_PHY_NUM]; /* rf_band bit-map */
+	u8 ch_map[12];
+	u8 ch_map_le[5];
 
-	bool is_5g_hi_channel;
+	bool is_5g_hi_ch;
+	bool is_5g_hi_ch_hb1;
 	bool go_client_exist;
+	bool go_client_exist_hb1;
 	bool noa_exist;
+	bool noa_exist_hb1;
 	bool pta_reg_mac_chg;
 	bool bg_mode;
+	bool bg_mode_hb1;
 	bool he_mode;
 	bool scbd_chg[BTC_ALL_BT];
 	bool fw_ver_mismatch;
@@ -3280,6 +3383,14 @@ struct rtw89_btc_fbtc_outsrc_set_info {
 	u8 rf_gbt_source;
 	u8 bt_enable_state;
 	u8 wl_btg_standby_chg;
+	/* bit[15]-> 0:2G/1:5G,6G, bit[14:0]-> WL HWBx ch freq in MHz */
+	/* forbidden group-> bit[1]:fbd rf-band, bit[0]: fbd enable */
+	u8 fbd_group_en[RTW89_MAC_NUM][2]; /* HWB0/1 +.Group0/1 */
+	u16 rf_center_freq[RTW89_MAC_NUM]; /* HWB0/1 */
+	/* forbidden group boundary: [15:8]->UP, [7:0]->LO */
+	u16 fbd_group_bound[RTW89_MAC_NUM][2]; /* HWB0/1 +.Group0/1 */
+	/* 11-bit in MHz, freq diff threshold */
+	u16 freq_diff_thres[RTW89_MAC_NUM][BTC_ALL_BT_EZL]; /* HWB0/1 vs.BT0/1/2 */
 } __packed;
 
 union rtw89_btc_fbtc_slot_u {
@@ -3363,6 +3474,7 @@ struct rtw89_btc_dm {
 	u8 lps_ctrl_change: 1;
 	u8 scbd_write_instant;
 	bool scbd_b2w_update;
+	bool pre_agc_chg;
 };
 
 struct rtw89_btc_ctrl {
@@ -4961,6 +5073,7 @@ struct rtw89_chip_info {
 	u8 mailbox;
 
 	u8 afh_guard_ch;
+	u16 fdd_iso_freq;
 	const u8 *wl_rssi_thres;
 	const u8 *bt_rssi_thres;
 	u8 rssi_tol;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0e7168605850..41c033d2ae7b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5922,14 +5922,14 @@ int rtw89_fw_h2c_cxdrv_init_v10(struct rtw89_dev *rtwdev, u8 type)
 int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_role_info *role_info = &wl->role_info;
-	struct rtw89_btc_wl_role_info_bpos *bpos = &role_info->role_map.role;
-	struct rtw89_btc_wl_active_role *active = role_info->active_role;
+	struct rtw89_btc_wl_role_info *r = &wl->role_info;
+	const struct rtw89_btc_ver *ver = btc->ver;
+	struct rtw89_btc_wl_rlink *rl;
 	struct sk_buff *skb;
-	u32 len;
+	u32 rmap = r->role_map;
 	u8 offset = 0;
+	u32 len;
 	u8 *cmd;
 	int ret;
 	int i;
@@ -5947,36 +5947,37 @@ int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev, u8 type)
 	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, type);
 	RTW89_SET_FWCMD_CXHDR_LEN(cmd, len - H2C_LEN_CXDRVHDR);
 
-	RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, role_info->connect_cnt);
-	RTW89_SET_FWCMD_CXROLE_LINK_MODE(cmd, role_info->link_mode);
-
-	RTW89_SET_FWCMD_CXROLE_ROLE_NONE(cmd, bpos->none);
-	RTW89_SET_FWCMD_CXROLE_ROLE_STA(cmd, bpos->station);
-	RTW89_SET_FWCMD_CXROLE_ROLE_AP(cmd, bpos->ap);
-	RTW89_SET_FWCMD_CXROLE_ROLE_VAP(cmd, bpos->vap);
-	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC(cmd, bpos->adhoc);
-	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC_MASTER(cmd, bpos->adhoc_master);
-	RTW89_SET_FWCMD_CXROLE_ROLE_MESH(cmd, bpos->mesh);
-	RTW89_SET_FWCMD_CXROLE_ROLE_MONITOR(cmd, bpos->moniter);
-	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_DEV(cmd, bpos->p2p_device);
-	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GC(cmd, bpos->p2p_gc);
-	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GO(cmd, bpos->p2p_go);
-	RTW89_SET_FWCMD_CXROLE_ROLE_NAN(cmd, bpos->nan);
-
-	for (i = 0; i < RTW89_PORT_NUM; i++, active++) {
-		RTW89_SET_FWCMD_CXROLE_ACT_CONNECTED(cmd, active->connected, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_PID(cmd, active->pid, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_PHY(cmd, active->phy, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_NOA(cmd, active->noa, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_BAND(cmd, active->band, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_CLIENT_PS(cmd, active->client_ps, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_BW(cmd, active->bw, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_ROLE(cmd, active->role, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_CH(cmd, active->ch, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_TX_LVL(cmd, active->tx_lvl, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_RX_LVL(cmd, active->rx_lvl, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_TX_RATE(cmd, active->tx_rate, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_RX_RATE(cmd, active->rx_rate, i, offset);
+	RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, r->connect_cnt);
+	RTW89_SET_FWCMD_CXROLE_LINK_MODE(cmd, r->link_mode);
+
+	RTW89_SET_FWCMD_CXROLE_ROLE_NONE(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_NONE)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_STA(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_STATION)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_AP(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_AP)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_VAP(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_AP_VLAN)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_ADHOC)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC_MASTER(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_ADHOC_MASTER)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_MESH(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_MESH_POINT)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_MONITOR(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_MONITOR)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_DEV(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_P2P_DEVICE)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GC(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_P2P_CLIENT)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GO(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_P2P_GO)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_NAN(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_NAN)));
+
+	for (i = 0; i < RTW89_PORT_NUM; i++) {
+		rl = &r->rlink[i][RTW89_MAC_0];
+		RTW89_SET_FWCMD_CXROLE_ACT_CONNECTED(cmd, rl->connected, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_PID(cmd, rl->pid, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_PHY(cmd, rl->phy, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_NOA(cmd, rl->noa, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_BAND(cmd, rl->rf_band, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_CLIENT_PS(cmd, rl->client_ps, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_BW(cmd, rl->bw, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_ROLE(cmd, rl->role, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_CH(cmd, rl->ch, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_TX_LVL(cmd, rl->tx_lvl, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_RX_LVL(cmd, rl->rx_lvl, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_TX_RATE(cmd, rl->tx_rate, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_RX_RATE(cmd, rl->rx_rate, i, offset);
 	}
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
@@ -6005,12 +6006,12 @@ int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev, u8 type)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_role_info_v1 *role_info = &wl->role_info_v1;
-	struct rtw89_btc_wl_role_info_bpos *bpos = &role_info->role_map.role;
-	struct rtw89_btc_wl_active_role_v1 *active = role_info->active_role_v1;
+	struct rtw89_btc_wl_role_info *r = &wl->role_info;
+	struct rtw89_btc_wl_rlink *rl;
 	struct sk_buff *skb;
-	u32 len;
+	u32 rmap = r->role_map;
 	u8 *cmd, offset;
+	u32 len;
 	int ret;
 	int i;
 
@@ -6027,47 +6028,49 @@ int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev, u8 type)
 	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, type);
 	RTW89_SET_FWCMD_CXHDR_LEN(cmd, len - H2C_LEN_CXDRVHDR);
 
-	RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, role_info->connect_cnt);
-	RTW89_SET_FWCMD_CXROLE_LINK_MODE(cmd, role_info->link_mode);
-
-	RTW89_SET_FWCMD_CXROLE_ROLE_NONE(cmd, bpos->none);
-	RTW89_SET_FWCMD_CXROLE_ROLE_STA(cmd, bpos->station);
-	RTW89_SET_FWCMD_CXROLE_ROLE_AP(cmd, bpos->ap);
-	RTW89_SET_FWCMD_CXROLE_ROLE_VAP(cmd, bpos->vap);
-	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC(cmd, bpos->adhoc);
-	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC_MASTER(cmd, bpos->adhoc_master);
-	RTW89_SET_FWCMD_CXROLE_ROLE_MESH(cmd, bpos->mesh);
-	RTW89_SET_FWCMD_CXROLE_ROLE_MONITOR(cmd, bpos->moniter);
-	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_DEV(cmd, bpos->p2p_device);
-	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GC(cmd, bpos->p2p_gc);
-	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GO(cmd, bpos->p2p_go);
-	RTW89_SET_FWCMD_CXROLE_ROLE_NAN(cmd, bpos->nan);
+	RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, r->connect_cnt);
+	RTW89_SET_FWCMD_CXROLE_LINK_MODE(cmd, r->link_mode);
+
+	RTW89_SET_FWCMD_CXROLE_ROLE_NONE(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_NONE)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_STA(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_STATION)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_AP(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_AP)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_VAP(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_AP_VLAN)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_ADHOC)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC_MASTER(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_ADHOC_MASTER)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_MESH(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_MESH_POINT)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_MONITOR(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_MONITOR)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_DEV(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_P2P_DEVICE)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GC(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_P2P_CLIENT)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GO(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_P2P_GO)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_NAN(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_NAN)));
 
 	offset = PORT_DATA_OFFSET;
-	for (i = 0; i < RTW89_PORT_NUM; i++, active++) {
-		RTW89_SET_FWCMD_CXROLE_ACT_CONNECTED(cmd, active->connected, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_PID(cmd, active->pid, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_PHY(cmd, active->phy, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_NOA(cmd, active->noa, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_BAND(cmd, active->band, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_CLIENT_PS(cmd, active->client_ps, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_BW(cmd, active->bw, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_ROLE(cmd, active->role, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_CH(cmd, active->ch, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_TX_LVL(cmd, active->tx_lvl, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_RX_LVL(cmd, active->rx_lvl, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_TX_RATE(cmd, active->tx_rate, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_RX_RATE(cmd, active->rx_rate, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_NOA_DUR(cmd, active->noa_duration, i, offset);
+
+	for (i = 0; i < RTW89_PORT_NUM; i++) {
+		rl = &r->rlink[i][RTW89_MAC_0];
+		RTW89_SET_FWCMD_CXROLE_ACT_CONNECTED(cmd, rl->connected, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_PID(cmd, rl->pid, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_PHY(cmd, rl->phy, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_NOA(cmd, rl->noa, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_BAND(cmd, rl->rf_band, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_CLIENT_PS(cmd, rl->client_ps, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_BW(cmd, rl->bw, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_ROLE(cmd, rl->role, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_CH(cmd, rl->ch, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_TX_LVL(cmd, rl->tx_lvl, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_RX_LVL(cmd, rl->rx_lvl, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_TX_RATE(cmd, rl->tx_rate, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_RX_RATE(cmd, rl->rx_rate, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_NOA_DUR(cmd, rl->noa_dur, i, offset);
 	}
 
 	offset = len - H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN;
-	RTW89_SET_FWCMD_CXROLE_MROLE_TYPE(cmd, role_info->mrole_type, offset);
-	RTW89_SET_FWCMD_CXROLE_MROLE_NOA(cmd, role_info->mrole_noa_duration, offset);
-	RTW89_SET_FWCMD_CXROLE_DBCC_EN(cmd, role_info->dbcc_en, offset);
-	RTW89_SET_FWCMD_CXROLE_DBCC_CHG(cmd, role_info->dbcc_chg, offset);
-	RTW89_SET_FWCMD_CXROLE_DBCC_2G_PHY(cmd, role_info->dbcc_2g_phy, offset);
-	RTW89_SET_FWCMD_CXROLE_LINK_MODE_CHG(cmd, role_info->link_mode_chg, offset);
+	RTW89_SET_FWCMD_CXROLE_MROLE_TYPE(cmd, r->mrole_type, offset);
+	RTW89_SET_FWCMD_CXROLE_MROLE_NOA(cmd, r->mrole_noa_duration, offset);
+	RTW89_SET_FWCMD_CXROLE_DBCC_EN(cmd, r->dbcc_en, offset);
+	RTW89_SET_FWCMD_CXROLE_DBCC_CHG(cmd, r->dbcc_chg, offset);
+	RTW89_SET_FWCMD_CXROLE_DBCC_2G_PHY(cmd, r->dbcc_2g_phy, offset);
+	RTW89_SET_FWCMD_CXROLE_LINK_MODE_CHG(cmd, r->link_mode_chg, offset);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, BTFC_SET,
@@ -6095,10 +6098,10 @@ int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev, u8 type)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_role_info_v2 *role_info = &wl->role_info_v2;
-	struct rtw89_btc_wl_role_info_bpos *bpos = &role_info->role_map.role;
-	struct rtw89_btc_wl_active_role_v2 *active = role_info->active_role_v2;
+	struct rtw89_btc_wl_role_info *r = &wl->role_info;
+	struct rtw89_btc_wl_rlink *rl;
 	struct sk_buff *skb;
+	u32 rmap = r->role_map;
 	u32 len;
 	u8 *cmd, offset;
 	int ret;
@@ -6117,43 +6120,45 @@ int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev, u8 type)
 	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, type);
 	RTW89_SET_FWCMD_CXHDR_LEN(cmd, len - H2C_LEN_CXDRVHDR);
 
-	RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, role_info->connect_cnt);
-	RTW89_SET_FWCMD_CXROLE_LINK_MODE(cmd, role_info->link_mode);
-
-	RTW89_SET_FWCMD_CXROLE_ROLE_NONE(cmd, bpos->none);
-	RTW89_SET_FWCMD_CXROLE_ROLE_STA(cmd, bpos->station);
-	RTW89_SET_FWCMD_CXROLE_ROLE_AP(cmd, bpos->ap);
-	RTW89_SET_FWCMD_CXROLE_ROLE_VAP(cmd, bpos->vap);
-	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC(cmd, bpos->adhoc);
-	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC_MASTER(cmd, bpos->adhoc_master);
-	RTW89_SET_FWCMD_CXROLE_ROLE_MESH(cmd, bpos->mesh);
-	RTW89_SET_FWCMD_CXROLE_ROLE_MONITOR(cmd, bpos->moniter);
-	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_DEV(cmd, bpos->p2p_device);
-	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GC(cmd, bpos->p2p_gc);
-	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GO(cmd, bpos->p2p_go);
-	RTW89_SET_FWCMD_CXROLE_ROLE_NAN(cmd, bpos->nan);
+	RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, r->connect_cnt);
+	RTW89_SET_FWCMD_CXROLE_LINK_MODE(cmd, r->link_mode);
+
+	RTW89_SET_FWCMD_CXROLE_ROLE_NONE(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_NONE)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_STA(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_STATION)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_AP(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_AP)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_VAP(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_AP_VLAN)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_ADHOC)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC_MASTER(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_ADHOC_MASTER)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_MESH(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_MESH_POINT)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_MONITOR(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_MONITOR)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_DEV(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_P2P_DEVICE)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GC(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_P2P_CLIENT)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GO(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_P2P_GO)));
+	RTW89_SET_FWCMD_CXROLE_ROLE_NAN(cmd, !!(rmap & BIT(RTW89_WIFI_ROLE_NAN)));
 
 	offset = PORT_DATA_OFFSET;
-	for (i = 0; i < RTW89_PORT_NUM; i++, active++) {
-		RTW89_SET_FWCMD_CXROLE_ACT_CONNECTED_V2(cmd, active->connected, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_PID_V2(cmd, active->pid, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_PHY_V2(cmd, active->phy, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_NOA_V2(cmd, active->noa, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_BAND_V2(cmd, active->band, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_CLIENT_PS_V2(cmd, active->client_ps, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_BW_V2(cmd, active->bw, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_ROLE_V2(cmd, active->role, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_CH_V2(cmd, active->ch, i, offset);
-		RTW89_SET_FWCMD_CXROLE_ACT_NOA_DUR_V2(cmd, active->noa_duration, i, offset);
+
+	for (i = 0; i < RTW89_PORT_NUM; i++) {
+		rl = &r->rlink[i][RTW89_MAC_0];
+		RTW89_SET_FWCMD_CXROLE_ACT_CONNECTED_V2(cmd, rl->connected, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_PID_V2(cmd, rl->pid, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_PHY_V2(cmd, rl->phy, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_NOA_V2(cmd, rl->noa, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_BAND_V2(cmd, rl->rf_band, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_CLIENT_PS_V2(cmd, rl->client_ps, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_BW_V2(cmd, rl->bw, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_ROLE_V2(cmd, rl->role, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_CH_V2(cmd, rl->ch, i, offset);
+		RTW89_SET_FWCMD_CXROLE_ACT_NOA_DUR_V2(cmd, rl->noa_dur, i, offset);
 	}
 
 	offset = len - H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN;
-	RTW89_SET_FWCMD_CXROLE_MROLE_TYPE(cmd, role_info->mrole_type, offset);
-	RTW89_SET_FWCMD_CXROLE_MROLE_NOA(cmd, role_info->mrole_noa_duration, offset);
-	RTW89_SET_FWCMD_CXROLE_DBCC_EN(cmd, role_info->dbcc_en, offset);
-	RTW89_SET_FWCMD_CXROLE_DBCC_CHG(cmd, role_info->dbcc_chg, offset);
-	RTW89_SET_FWCMD_CXROLE_DBCC_2G_PHY(cmd, role_info->dbcc_2g_phy, offset);
-	RTW89_SET_FWCMD_CXROLE_LINK_MODE_CHG(cmd, role_info->link_mode_chg, offset);
+	RTW89_SET_FWCMD_CXROLE_MROLE_TYPE(cmd, r->mrole_type, offset);
+	RTW89_SET_FWCMD_CXROLE_MROLE_NOA(cmd, r->mrole_noa_duration, offset);
+	RTW89_SET_FWCMD_CXROLE_DBCC_EN(cmd, r->dbcc_en, offset);
+	RTW89_SET_FWCMD_CXROLE_DBCC_CHG(cmd, r->dbcc_chg, offset);
+	RTW89_SET_FWCMD_CXROLE_DBCC_2G_PHY(cmd, r->dbcc_2g_phy, offset);
+	RTW89_SET_FWCMD_CXROLE_LINK_MODE_CHG(cmd, r->link_mode_chg, offset);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, BTFC_SET,
@@ -6175,12 +6180,14 @@ int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev, u8 type)
 
 int rtw89_fw_h2c_cxdrv_role_v7(struct rtw89_dev *rtwdev, u8 type)
 {
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_role_info_v7 *role = &btc->cx.wl.role_info_v7;
+	struct rtw89_btc_wl_role_info *r = &rtwdev->btc.cx.wl.role_info;
 	struct rtw89_h2c_cxrole_v7 *h2c;
+	struct rtw89_btc_wl_rlink *rl;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
+	__le32 rm;
 	int ret;
+	u8 i;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -6190,16 +6197,35 @@ int rtw89_fw_h2c_cxdrv_role_v7(struct rtw89_dev *rtwdev, u8 type)
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_cxrole_v7 *)skb->data;
 
-	h2c->hdr.type = type;
-	h2c->hdr.ver = btc->ver->fwlrole;
-	h2c->hdr.len = len - H2C_LEN_CXDRVHDR_V7;
-	memcpy(&h2c->_u8, role, sizeof(h2c->_u8));
-	h2c->_u32.role_map = cpu_to_le32(role->role_map);
-	h2c->_u32.mrole_type = cpu_to_le32(role->mrole_type);
-	h2c->_u32.mrole_noa_duration = cpu_to_le32(role->mrole_noa_duration);
-	h2c->_u32.dbcc_en = cpu_to_le32(role->dbcc_en);
-	h2c->_u32.dbcc_chg = cpu_to_le32(role->dbcc_chg);
-	h2c->_u32.dbcc_2g_phy = cpu_to_le32(role->dbcc_2g_phy);
+	h2c->r.connect_cnt = r->connect_cnt;
+	h2c->r.link_mode = r->link_mode;
+	h2c->r.link_mode_chg = r->link_mode_chg;
+	h2c->r.p2p_2g = r->p2p_2g;
+
+	for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
+		rl = &r->rlink[i][RTW89_MAC_0];
+		h2c->r.active_role[i].connected = rl->connected;
+		h2c->r.active_role[i].pid = rl->pid;
+		h2c->r.active_role[i].phy = rl->phy;
+		h2c->r.active_role[i].noa = rl->noa;
+
+		h2c->r.active_role[i].band = rl->rf_band;
+		h2c->r.active_role[i].client_ps = rl->client_ps;
+		h2c->r.active_role[i].bw = rl->bw;
+		h2c->r.active_role[i].role = rl->role;
+
+		h2c->r.active_role[i].ch = rl->ch;
+		h2c->r.active_role[i].noa_dur = rl->noa_dur;
+		h2c->r.active_role[i].client_cnt = rl->client_cnt;
+	}
+
+	rm = cpu_to_le32(r->role_map);
+	memcpy(&h2c->r.role_map, &rm, sizeof(h2c->r.role_map));
+	h2c->r.mrole_type = cpu_to_le32(r->mrole_type);
+	h2c->r.mrole_noa_duration = cpu_to_le32(r->mrole_noa_duration);
+	h2c->r.dbcc_en = cpu_to_le32((u32)r->dbcc_en);
+	h2c->r.dbcc_chg = cpu_to_le32(r->dbcc_chg);
+	h2c->r.dbcc_2g_phy = cpu_to_le32(r->dbcc_2g_phy);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, BTFC_SET,
@@ -6221,12 +6247,14 @@ int rtw89_fw_h2c_cxdrv_role_v7(struct rtw89_dev *rtwdev, u8 type)
 
 int rtw89_fw_h2c_cxdrv_role_v8(struct rtw89_dev *rtwdev, u8 type)
 {
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_role_info_v8 *role = &btc->cx.wl.role_info_v8;
+	struct rtw89_btc_wl_role_info *r = &rtwdev->btc.cx.wl.role_info;
 	struct rtw89_h2c_cxrole_v8 *h2c;
+	struct rtw89_btc_wl_rlink *rl;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
+	__le32 rm;
 	int ret;
+	u8 i, j;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -6237,12 +6265,118 @@ int rtw89_fw_h2c_cxdrv_role_v8(struct rtw89_dev *rtwdev, u8 type)
 	h2c = (struct rtw89_h2c_cxrole_v8 *)skb->data;
 
 	h2c->hdr.type = type;
-	h2c->hdr.ver = btc->ver->fwlrole;
+	h2c->hdr.ver = rtwdev->btc.ver->fwlrole;
+	h2c->hdr.len = len - H2C_LEN_CXDRVHDR_V7;
+	h2c->r.connect_cnt = r->connect_cnt;
+	h2c->r.link_mode = r->link_mode;
+	h2c->r.link_mode_chg =  r->link_mode_chg;
+	h2c->r.p2p_2g = r->p2p_2g;
+	h2c->r.pta_req_band = r->pta_req_band;
+	h2c->r.dbcc_en = r->dbcc_en;
+	h2c->r.dbcc_chg = r->dbcc_chg;
+	h2c->r.dbcc_2g_phy = r->dbcc_2g_phy;
+
+	for (j = RTW89_MAC_0; j <= RTW89_MAC_1; j++) {
+		for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
+			rl = &r->rlink[i][j];
+			h2c->r.rlink[i][j].connected = rl->connected;
+			h2c->r.rlink[i][j].pid = rl->pid;
+			h2c->r.rlink[i][j].phy = rl->phy;
+			h2c->r.rlink[i][j].noa = rl->noa;
+
+			h2c->r.rlink[i][j].rf_band = rl->rf_band;
+			h2c->r.rlink[i][j].active = rl->active;
+			h2c->r.rlink[i][j].bw = rl->bw;
+			h2c->r.rlink[i][j].role = rl->role;
+
+			h2c->r.rlink[i][j].ch = rl->ch;
+			h2c->r.rlink[i][j].noa_dur = rl->noa_dur;
+			h2c->r.rlink[i][j].client_cnt = rl->client_cnt;
+			h2c->r.rlink[i][j].mode = rl->mode;
+		}
+	}
+
+	rm = cpu_to_le32(r->role_map);
+	memcpy(&h2c->r.role_map, &rm, sizeof(h2c->r.role_map));
+	h2c->r.mrole_type = cpu_to_le32(r->mrole_type);
+	h2c->r.mrole_noa_duration = cpu_to_le32(r->mrole_noa_duration);
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
+int rtw89_fw_h2c_cxdrv_role_v10(struct rtw89_dev *rtwdev, u8 type)
+{
+	struct rtw89_btc_wl_role_info *r = &rtwdev->btc.cx.wl.role_info;
+	struct rtw89_h2c_cxrole_v10 *h2c;
+	struct rtw89_btc_wl_rlink *rl;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	__le32 rm;
+	int ret;
+	u8 i, j;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_role\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxrole_v10 *)skb->data;
+
+	h2c->hdr.type = type;
+	h2c->hdr.ver = rtwdev->btc.ver->fwlrole;
 	h2c->hdr.len = len - H2C_LEN_CXDRVHDR_V7;
-	memcpy(&h2c->_u8, role, sizeof(h2c->_u8));
-	h2c->_u32.role_map = cpu_to_le32(role->role_map);
-	h2c->_u32.mrole_type = cpu_to_le32(role->mrole_type);
-	h2c->_u32.mrole_noa_duration = cpu_to_le32(role->mrole_noa_duration);
+
+	for (j = RTW89_MAC_0; j <= RTW89_MAC_1; j++) {
+		for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
+			rl = &r->rlink[i][j];
+			h2c->r.rlink[i][j].connected = rl->connected;
+			h2c->r.rlink[i][j].pid = rl->pid;
+			h2c->r.rlink[i][j].phy = rl->phy;
+			h2c->r.rlink[i][j].noa = rl->noa;
+
+			h2c->r.rlink[i][j].rf_band = rl->rf_band;
+			h2c->r.rlink[i][j].active = rl->active;
+			h2c->r.rlink[i][j].bw = rl->bw;
+			h2c->r.rlink[i][j].role = rl->role;
+
+			h2c->r.rlink[i][j].ch = rl->ch;
+			h2c->r.rlink[i][j].noa_dur = rl->noa_dur;
+			h2c->r.rlink[i][j].client_cnt = rl->client_cnt;
+			h2c->r.rlink[i][j].mode = rl->mode;
+			h2c->r.rlink[i][j].mac_id = rl->mac_id;
+		}
+	}
+
+	h2c->r.link_mode = r->link_mode;
+	h2c->r.link_mode_hb1 = r->link_mode_hb1;
+	h2c->r.p2p_exist = r->p2p_exist;
+	h2c->r.p2p_exist_hb1 = r->p2p_exist_hb1;
+
+	h2c->r.pta_req_band = r->pta_req_band;
+	h2c->r.dbcc_en = r->dbcc_en;
+	h2c->r.dbcc_2g_phy = r->dbcc_2g_phy;
+
+	rm = cpu_to_le32(r->role_map);
+	memcpy(&h2c->r.role_map, &rm, sizeof(h2c->r.role_map));
+	rm = cpu_to_le32(r->role_map_hb1);
+	memcpy(&h2c->r.role_map_hb1, &rm, sizeof(h2c->r.role_map_hb1));
+	h2c->r.mrole_type = cpu_to_le32(r->mrole_type);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, BTFC_SET,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index af126d15a1fb..1e4267b22b36 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2433,54 +2433,19 @@ struct rtw89_h2c_cxctrl_v7 {
 #define H2C_LEN_CXDRVHDR sizeof(struct rtw89_h2c_cxhdr)
 #define H2C_LEN_CXDRVHDR_V7 sizeof(struct rtw89_h2c_cxhdr_v7)
 
-struct rtw89_btc_wl_role_info_v7_u8 {
-	u8 connect_cnt;
-	u8 link_mode;
-	u8 link_mode_chg;
-	u8 p2p_2g;
-
-	struct rtw89_btc_wl_active_role_v7 active_role[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER];
-} __packed;
-
-struct rtw89_btc_wl_role_info_v7_u32 {
-	__le32 role_map;
-	__le32 mrole_type;
-	__le32 mrole_noa_duration;
-	__le32 dbcc_en;
-	__le32 dbcc_chg;
-	__le32 dbcc_2g_phy;
-} __packed;
-
 struct rtw89_h2c_cxrole_v7 {
 	struct rtw89_h2c_cxhdr_v7 hdr;
-	struct rtw89_btc_wl_role_info_v7_u8 _u8;
-	struct rtw89_btc_wl_role_info_v7_u32 _u32;
-} __packed;
-
-struct rtw89_btc_wl_role_info_v8_u8 {
-	u8 connect_cnt;
-	u8 link_mode;
-	u8 link_mode_chg;
-	u8 p2p_2g;
-
-	u8 pta_req_band;
-	u8 dbcc_en;
-	u8 dbcc_chg;
-	u8 dbcc_2g_phy;
-
-	struct rtw89_btc_wl_rlink rlink[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER][RTW89_MAC_NUM];
+	struct rtw89_btc_wl_role_info_v7 r;
 } __packed;
 
-struct rtw89_btc_wl_role_info_v8_u32 {
-	__le32 role_map;
-	__le32 mrole_type;
-	__le32 mrole_noa_duration;
+struct rtw89_h2c_cxrole_v8 {
+	struct rtw89_h2c_cxhdr_v7 hdr;
+	struct rtw89_btc_wl_role_info_v8 r;
 } __packed;
 
-struct rtw89_h2c_cxrole_v8 {
+struct rtw89_h2c_cxrole_v10 {
 	struct rtw89_h2c_cxhdr_v7 hdr;
-	struct rtw89_btc_wl_role_info_v8_u8 _u8;
-	struct rtw89_btc_wl_role_info_v8_u32 _u32;
+	struct rtw89_btc_wl_role_info_v10 r;
 } __packed;
 
 struct rtw89_h2c_cxosi {
@@ -5413,6 +5378,7 @@ int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v7(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role_v8(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_role_v10(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_osi_info(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 50480f72c96d..91d6cddc713e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2725,6 +2725,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.mailbox		= 0x1,
 
 	.afh_guard_ch		= 6,
+	.fdd_iso_freq		= 1000,
 	.wl_rssi_thres		= rtw89_btc_8851b_wl_rssi_thres,
 	.bt_rssi_thres		= rtw89_btc_8851b_bt_rssi_thres,
 	.rssi_tol		= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 0c7794742650..ed6dee63694f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2464,6 +2464,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.mailbox		= 0x1,
 
 	.afh_guard_ch		= 6,
+	.fdd_iso_freq		= 1000,
 	.wl_rssi_thres		= rtw89_btc_8852a_wl_rssi_thres,
 	.bt_rssi_thres		= rtw89_btc_8852a_bt_rssi_thres,
 	.rssi_tol		= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 5904127cc836..4f55a153d169 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1060,6 +1060,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.mailbox		= 0x1,
 
 	.afh_guard_ch		= 6,
+	.fdd_iso_freq		= 1000,
 	.wl_rssi_thres		= rtw89_btc_8852b_wl_rssi_thres,
 	.bt_rssi_thres		= rtw89_btc_8852b_bt_rssi_thres,
 	.rssi_tol		= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index e68f73827fa5..9e0c48fde2fa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -898,6 +898,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.mailbox		= 0x1,
 
 	.afh_guard_ch		= 6,
+	.fdd_iso_freq		= 1000,
 	.wl_rssi_thres		= rtw89_btc_8852bt_wl_rssi_thres,
 	.bt_rssi_thres		= rtw89_btc_8852bt_bt_rssi_thres,
 	.rssi_tol		= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 968666280c89..f21dd87e3846 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3266,6 +3266,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.mailbox		= 0x1,
 
 	.afh_guard_ch		= 6,
+	.fdd_iso_freq		= 1000,
 	.wl_rssi_thres		= rtw89_btc_8852c_wl_rssi_thres,
 	.bt_rssi_thres		= rtw89_btc_8852c_bt_rssi_thres,
 	.rssi_tol		= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index fe87b4929ddc..cdcce091b922 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -3249,6 +3249,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.mailbox		= 0x1,
 
 	.afh_guard_ch		= 6,
+	.fdd_iso_freq		= 1000,
 	.wl_rssi_thres		= rtw89_btc_8922a_wl_rssi_thres,
 	.bt_rssi_thres		= rtw89_btc_8922a_bt_rssi_thres,
 	.rssi_tol		= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 768434db14c6..aeade858ce95 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -3535,6 +3535,7 @@ const struct rtw89_chip_info rtw8922d_chip_info = {
 	.mailbox		= 0x1,
 
 	.afh_guard_ch		= 6,
+	.fdd_iso_freq		= 1000,
 	.wl_rssi_thres		= rtw89_btc_8922d_wl_rssi_thres,
 	.bt_rssi_thres		= rtw89_btc_8922d_bt_rssi_thres,
 	.rssi_tol		= 2,
-- 
2.25.1


