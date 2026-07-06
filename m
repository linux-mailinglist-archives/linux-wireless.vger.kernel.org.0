Return-Path: <linux-wireless+bounces-38649-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I6tJB2QZS2qbLwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38649-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 04:56:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E21470C3A4
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 04:56:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=kU0u5a1V;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38649-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38649-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5673D300D16F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 02:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2C2384CFD;
	Mon,  6 Jul 2026 02:56:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C666351C22
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 02:56:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306580; cv=none; b=tNhvuFN1FUSLhp4s9PnSvhbo8SOfZGzsStmUEBSMvgxswebekAYBjfRW8YO0UVc/WsGtFk0YC1qI7mSKyuShXo8Mdyf2ieH9ER6SMYAF2SdkEs1+QCMAqjWX7DBiVmOkDn2nZH1WHi+/DCkrhiKK39U3fYR962FClTsWF23NTdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306580; c=relaxed/simple;
	bh=VDB8Ji+YHZU54rQ+VlU2KBfvbhHZO9JLwO21sC77tto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXLMDG6i+yXJCp00zJHPuS12z/Og4gLU33KqXAEqGH3wnkh8Muw2qaLHKid3Oa2fZvdwknUcyefliyZGKTVDocR5qcZiyUTmQu8dj+vvonzqSN4tDwEjd2wacE83Jiu49vk4CXxiYwUVaPdOJGyouKVzwl0m0yCoZm8PGMRtBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kU0u5a1V; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6662uGMh9120605, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783306576; bh=asmNe7eMEdEXNvvrpOvnooSZo3/ne/oStW5Hym7VVf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=kU0u5a1Vp0fgN4Baj4KHx7mozZeykN+gTTiWmqtHkuWF92ztHWc6lqWVDPl6alWlp
	 ckCWS+Ltwkvt/mQV+Vd2+Rz4XSWdV6U1kLCQjOAxJhjre1xLXteyJcS30Q4iw4EEkb
	 FGkB3C2yYrRt3slHCionCB3Y6EHNrdUYyStqfeyOTE2xkzWCLEwJ+xdEaq+pMQ2zto
	 x1fGeqY+7VAc/NElB2eGGbDIDlllSURp/Gld+68EGaFsGR73ZMUoIzRM88nKnrVkLe
	 m5pN8kAmbucRdy4F/gpAygTlqzkEmqsrIZekvod66a+UEieZExGpz0HTzgkHqpm8nz
	 /tgOnvxladJcw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6662uGMh9120605
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jul 2026 10:56:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Jul 2026 10:56:15 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Jul 2026 10:56:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next v2 6/9] wifi: rtw89: coex: Add WiFi/Bluetooth adapter binding info
Date: Mon, 6 Jul 2026 10:54:42 +0800
Message-ID: <20260706025445.18428-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260706025445.18428-1-pkshih@realtek.com>
References: <20260706025445.18428-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38649-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E21470C3A4

From: Ching-Te Ku <ku920601@realtek.com>

To bind Wi-Fi/Bluetooth with which adapter, in which band.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - fix wrong compare logic, which should be && instead of || 
   found by kernel test robot.
   https://lore.kernel.org/oe-kbuild-all/202607032153.rVIyuBbI-lkp@intel.com/T/#u
---
 drivers/net/wireless/realtek/rtw89/coex.c | 309 ++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h | 121 ++++++++-
 2 files changed, 396 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index ff3c05101ab3..15f929d60f94 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3349,7 +3349,7 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 	/* decide trx_para_level */
 	if (btc->ant_type == BTC_ANT_SHARED) {
 		/* fix LNA2 + TIA gain not change by GNT_BT */
-		if ((btc->dm.wl_btg_rx && b->profile_cnt.now != 0) ||
+		if ((btc->dm.wl_btg_rx && b->link_cnt.now != 0) ||
 		    dm->bt_only == 1)
 			dm->trx_para_level = 1; /* for better BT ACI issue */
 		else
@@ -3357,7 +3357,7 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 	} else { /* non-shared antenna  */
 		dm->trx_para_level = 5;
 		/* modify trx_para if WK 2.4G-STA-DL + bt link */
-		if (b->profile_cnt.now != 0 &&
+		if (b->link_cnt.now != 0 &&
 		    link_mode == BTC_WLINK_2G_STA &&
 		    wl->status.map.traffic_dir & BIT(RTW89_TFC_UL)) { /* uplink */
 			if (wl->rssi_level == 4 && bt->rssi_level > 2)
@@ -3606,7 +3606,7 @@ static void _set_bt_afh_info_v0(struct rtw89_dev *rtwdev)
 	if (wl->afh_info.en == en &&
 	    wl->afh_info.ch == ch &&
 	    wl->afh_info.bw == bw &&
-	    b->profile_cnt.last == b->profile_cnt.now) {
+	    b->link_cnt.last == b->link_cnt.now) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): return because no change!\n",
 			    __func__);
@@ -3777,7 +3777,7 @@ static bool _check_freerun(struct rtw89_dev *rtwdev)
 		return true;
 	}
 
-	if (bt_linfo->profile_cnt.now == 0) {
+	if (bt_linfo->link_cnt.now == 0) {
 		btc->dm.trx_para_level = 5;
 		return true;
 	}
@@ -5497,7 +5497,7 @@ static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 	} else if (link_mode == BTC_WLINK_5G) {
 		is_preagc = BTC_PREAGC_DISABLE;
 	} else if (link_mode == BTC_WLINK_NOLINK ||
-		 btc->cx.bt0.link_info.profile_cnt.now == 0) {
+		 btc->cx.bt0.link_info.link_cnt.now == 0) {
 		is_preagc = BTC_PREAGC_DISABLE;
 	} else if (dm->tdma_now.type != CXTDMA_OFF &&
 		 !bt_linfo->hfp_desc.exist &&
@@ -5683,7 +5683,7 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 	else
 		igno_bt = btc->ctrl.ctrl.igno_bt;
 
-	if (btc->dm.freerun || igno_bt || b->profile_cnt.now == 0 ||
+	if (btc->dm.freerun || igno_bt || b->link_cnt.now == 0 ||
 	    mode == BTC_WLINK_5G || mode == BTC_WLINK_NOLINK) {
 		enable = 0;
 		tx_time = BTC_MAX_TX_TIME_DEF;
@@ -6003,7 +6003,7 @@ static void _action_wl_2g_mcc(struct rtw89_dev *rtwdev)
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
-		if (btc->cx.bt0.link_info.profile_cnt.now == 0)
+		if (btc->cx.bt0.link_info.link_cnt.now == 0)
 			_set_policy(rtwdev, BTC_CXP_OFFE_DEF2,
 				    BTC_ACT_WL_2G_MCC);
 		else
@@ -6021,7 +6021,7 @@ static void _action_wl_2g_scc(struct rtw89_dev *rtwdev)
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
-		if (btc->cx.bt0.link_info.profile_cnt.now == 0)
+		if (btc->cx.bt0.link_info.link_cnt.now == 0)
 			_set_policy(rtwdev,
 				    BTC_CXP_OFFE_DEF2, BTC_ACT_WL_2G_SCC);
 		else
@@ -6199,7 +6199,7 @@ static void _action_wl_2g_ap(struct rtw89_dev *rtwdev)
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	if (btc->ant_type == BTC_ANT_SHARED) {
-		if (btc->cx.bt0.link_info.profile_cnt.now == 0)
+		if (btc->cx.bt0.link_info.link_cnt.now == 0)
 			_set_policy(rtwdev, BTC_CXP_OFFE_DEF2,
 				    BTC_ACT_WL_2G_AP);
 		else
@@ -6216,7 +6216,7 @@ static void _action_wl_2g_go(struct rtw89_dev *rtwdev)
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
-		if (btc->cx.bt0.link_info.profile_cnt.now == 0)
+		if (btc->cx.bt0.link_info.link_cnt.now == 0)
 			_set_policy(rtwdev,
 				    BTC_CXP_OFFE_DEF2, BTC_ACT_WL_2G_GO);
 		else
@@ -6247,7 +6247,7 @@ static void _action_wl_2g_nan(struct rtw89_dev *rtwdev)
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
-		if (btc->cx.bt0.link_info.profile_cnt.now == 0)
+		if (btc->cx.bt0.link_info.link_cnt.now == 0)
 			_set_policy(rtwdev,
 				    BTC_CXP_OFFE_DEF2, BTC_ACT_WL_2G_NAN);
 		else
@@ -7742,6 +7742,273 @@ static bool _chk_wl_rfk_request(struct rtw89_dev *rtwdev)
 	return false;
 }
 
+static void _set_bind_info(struct rtw89_btc *btc, u8 type)
+{
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
+	struct rtw89_btc_bt_link_info *b;
+	struct rtw89_btc_bind_info *bd;
+	u8 path_hwb[BTC_RF_NUM] = {RTW89_PHY_0, RTW89_PHY_1};
+	u8 link_weight[BTC_ALL_BT_EZL][BTC_BT_BMAX];
+	u8 map[BTC_RF_NUM][BTC_ALL_BT_EZL];
+	u8 b2g_score = 0, b5g_score = 0;
+	u8 i, j, rf_band_map, thres;
+	u8 weight[BTC_BT_BMAX] = {};
+
+	if (type == BTC_MECH_TDD) {
+		bd = &dm->tdd_bind;
+		memcpy(map, dm->tdd_map, sizeof(map));
+		thres = 30; /* BT profile score threshold for TDMA */
+	} else {
+		bd = &dm->fdd_bind;
+		memcpy(map, dm->fdd_map, sizeof(map));
+		thres = 5;
+	}
+
+	memset(bd, 0, sizeof(*bd));
+	/* compare BT 2GHz/5GHz profile by link-weighting */
+	for (i = 0; i < BTC_BT_BMAX; i++) {
+		link_weight[BTC_BT_1ST][i] = cx->bt0.link_weight[i];
+		link_weight[BTC_BT_2ND][i] = cx->bt1.link_weight[i];
+		link_weight[BTC_BT_EXT][i] = cx->bt_ext.link_weight[i];
+	}
+
+	/*
+	 * get 2GHz/5GHz link weight score by "band-overlap" map
+	 * link_weight from _update_bt_link_cnt(),
+	 * if link_weight >30 --> TDMA-required
+	 */
+	for (j = 0; j < BTC_ALL_BT_EZL; j++) {
+		rf_band_map = map[BTC_RF_S0][j] | map[BTC_RF_S1][j];
+		if (rf_band_map & BIT(RTW89_BAND_2G))
+			b2g_score += link_weight[j][BTC_BT_B2G];
+		if (rf_band_map & BIT(RTW89_BAND_5G))
+			b5g_score += link_weight[j][BTC_BT_B5G];
+	}
+
+	/* rf-band bound by comparing link weight */
+	if (b2g_score == 0 && b5g_score == 0) /* no-rf-band overlap */
+		bd->rf_band = 0;
+	else if (b5g_score > b2g_score)
+		bd->rf_band = BIT(BTC_BT_B5G);
+	else
+		bd->rf_band = BIT(BTC_BT_B2G);
+
+	/*
+	 * if MR_WTYPE_MLD2L1R_NONMLD, FW will change 2+0/0+2/1+1
+	 * Therefore, BTC_MLO_RF_xxx is not real-time state.
+	 * In this case, RF_S0->HWB0, RF_S1->HWB1
+	 * If link-mode change by _ntfy_generic(BTC_GNTFY_MRCX_INFO)
+	 * HW-Band is decided by wl->mlo_info.mrcx_act_hwb_map
+	 */
+	if (wl->mlo_info.wtype == RTW89_MR_WTYPE_MLD2L1R_NONMLD) {
+		/* TODO: Should patched WiFi mode & WiFi role patch */
+	} else {
+		/*
+		 * Dual-RF_band(HWB)TDMA if BT-profile is TDMA-type at both
+		 * 2GHz and 5GHz.
+		 * ex: 1+1: HWB0 5GHz + BT0 5GHz (BIS, HDT)
+		 * && HWB1 2.4GHz + BT1 2.4GHz(PAN)
+		 * for TDD: the link score must > 30 (from _bt_link_cnt)
+		 * for FDD: the link score must > 5 (bt enable)
+		 */
+		if ((wl->mlo_info.rf_combination == BTC_MLO_RF_1_PLUS_1 ||
+		     wl->mlo_info.rf_combination == BTC_MLO_RF_2_PLUS_2) &&
+		     (b2g_score >= thres && b5g_score >= thres)) {
+			bd->rf_band = BIT(BTC_BT_B2G) | BIT(BTC_BT_B5G);
+		}
+
+		if (wl->mlo_info.rf_combination == BTC_MLO_RF_2_PLUS_0)
+			path_hwb[BTC_RF_S1] = RTW89_PHY_0; /* 2+0 RF-S0/1->HWB0 */
+		else if (wl->mlo_info.rf_combination == BTC_MLO_RF_0_PLUS_2)
+			path_hwb[BTC_RF_S0] = RTW89_PHY_1; /* 2+0 RF-S0/1->HWB1 */
+	}
+
+	/* Get HWB-sel and BT-sel by rf-band-binding */
+	for (i = 0; i < BTC_RF_NUM; i++) {
+		for (j = 0; j < BTC_ALL_BT_EZL; j++) {
+			if (!(map[i][j] & bd->rf_band)) /* no-overlap */
+				continue;
+
+			bd->wl_hwb_sel |= BIT(path_hwb[i]);
+			bd->bt_sel |= BIT(j);
+		}
+	}
+
+	/* TODO: Should patched WiFi mode & WiFi role patch */
+
+	/* update Bind-BT status map for BT0/BT1 */
+	for (i = BTC_BT_1ST; i < BTC_ALL_BT_EZL; i++) {
+		if (!(bd->bt_sel & BIT(i)))
+			continue;
+
+		for (j = BTC_BT_B2G; j <= BTC_BT_B5G; j++) {
+			if (!(bd->rf_band & BIT(j)))
+				continue;
+
+			if (i == BTC_BT_EXT) {
+				bd->bt_profile |= cx->bt_ext.profile_map[j];
+				weight[j] = cx->bt_ext.link_weight[j];
+				if (weight[j] > bd->bt_link_weight) /* max */
+					bd->bt_link_weight = weight[j];
+				continue;
+			} else if (i == BTC_BT_1ST) {
+				bt = &cx->bt0;
+			} else {
+				bt = &cx->bt1;
+			}
+
+			if (j == BTC_BT_B2G)
+				b = &bt->link_info;
+			else
+				b = &bt->link_info_56g;
+
+			bd->bt_profile |= b->status.map.profile_map;
+			bd->bt_smap.a2dp_active |= b->a2dp_desc.active;
+			bd->bt_smap.a2dp_sink |= b->a2dp_desc.sink;
+			bd->bt_smap.pan_active |= b->pan_desc.active;
+			bd->bt_smap.connect |= b->status.map.connect;
+			bd->bt_smap.hid_cnt += (u8)b->hid_desc.pair_cnt;
+			bd->bt_smap.hid_type |= b->hid_desc.type;
+			bd->bt_smap.cis_cnt += (u8)b->leaudio_desc.cis_cnt;
+			bd->bt_smap.link_cnt += b->link_cnt.now;
+			bd->bt_smap.inq_page |= b->status.map.inq_pag;
+			bd->bt_smap.page |= b->pag;
+
+			if (bt->link_weight[j] > bd->bt_link_weight) /* max */
+				bd->bt_link_weight = bt->link_weight[j];
+
+			if (b->slave_role)
+				bd->bt_smap.slave_role = b->slave_role;
+
+			if (b->a2dp_desc.vendor_id != 0)
+				bd->bt_smap.a2dp_vendor_id =
+							b->a2dp_desc.vendor_id;
+		}
+	}
+
+	if (bd->bt_profile & BTC_BT_HFP)
+		bd->bt_smap.hfp_exist = 1;
+	if (bd->bt_profile & BTC_BT_HID)
+		bd->bt_smap.hid_exist = 1;
+	if (bd->bt_profile & BTC_BT_A2DP)
+		bd->bt_smap.a2dp_exist = 1;
+	if (bd->bt_profile & BTC_BT_PAN)
+		bd->bt_smap.pan_exist = 1;
+	if (bd->bt_profile & BTC_BT_BIS)
+		bd->bt_smap.bis_exist = 1;
+	if (bd->bt_profile & BTC_BT_CIS)
+		bd->bt_smap.cis_exist = 1;
+	if (bd->bt_profile & BTC_BT_THREAD)
+		bd->bt_smap.thread_exist = 1;
+	if (bd->bt_profile & BTC_BT_ULL)
+		bd->bt_smap.ull_exist = 1;
+}
+
+#define _bind_is_btonly 0x7
+static void _set_coex_binding(struct rtw89_btc *btc)
+{
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_extsoc_info *bt2 =  &cx->bt_ext;
+	struct rtw89_btc_bt_info *bt0 = &cx->bt0;
+	struct rtw89_btc_bt_info *bt1 = &cx->bt1;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u8 path_hwb[BTC_RF_NUM] = {RTW89_PHY_0, RTW89_PHY_1};
+	u8 wl_rf_band[RTW89_BAND_NUM] = {};
+	u8 i, j, val = 0;
+
+	/*
+	 * sit_xmap(Space-Interaction) = ant_xmap | xtk_xmap
+	 * 1: WL-BT space-interference, always 1 if BTG/BTA/SPDT = 1
+	 * if dedicated-ant, it may be 1 if BT-Tx is bigger than WL-Rx(xtk_xmap)
+	 *
+	 * ant_xmap(ANT-Division-Multiplexing)
+	 * ==> dedicated-ant->0, BTG/BTA/SPDT->1
+	 *
+	 * xtk_xmap(Cross-talk map)-> calculate WL/BT interference by SIR
+	 * ==> 1: interference, 0: no-interference
+	 *
+	 * fdm_map(Frequency-Division-Multiplexing): WL/BT RF_Band overlap-map
+	 * 2bit-map: bit[1]:5GHz/6GHz, bit[0]:2.4GHz
+	 */
+	for (i = 0; i < RTW89_PHY_NUM; i++) {
+		if (wl->rf_band_map[i] & BIT(RTW89_BAND_2G))
+			wl_rf_band[i] |= BIT(RTW89_BAND_2G);
+
+		if (wl->rf_band_map[i] & (BIT(RTW89_BAND_5G) | BIT(RTW89_BAND_6G)))
+			wl_rf_band[i] |= BIT(RTW89_BAND_5G);
+
+		dm->fit_xmap[i][BTC_BT_1ST] = wl_rf_band[i] & bt0->rf_band_map;
+		dm->fit_xmap[i][BTC_BT_2ND] = wl_rf_band[i] & bt1->rf_band_map;
+		dm->fit_xmap[i][BTC_BT_EXT] = wl_rf_band[i] & bt2->rf_band_map;
+	}
+
+	/*
+	 * if MR_WTYPE_MLD2L1R_NONMLD, FW will change 2+0/0+2/1+1
+	 * Therefore, BTC_MLO_RF_xxx is not real-time state.
+	 * if link mode change by _ntfy_generic(BTC_GNTFY_MRCX_INFO)
+	 * the HW-BAND is decided by wl->mlo_info.mrcx_act_hwb_map
+	 * In this case, BTC_RF_S0->HWB0, BTC_RF_S1->HWB1
+	 */
+	if (wl->mlo_info.wtype == RTW89_MR_WTYPE_MLD2L1R_NONMLD) {
+		if (wl->role_info.link_mode != BTC_WLINK_2G_MCC &&
+		    wl->role_info.link_mode != BTC_WLINK_25G_MCC &&
+		    wl->role_info.link_mode != BTC_WLINK_25G_DBCC) {/* mode chg */
+			if (wl->mlo_info.mrcx_act_hwb_map == BIT(RTW89_PHY_1))
+				path_hwb[BTC_RF_S0] = RTW89_PHY_1;/* S0/1->HWB1 */
+			else
+				path_hwb[BTC_RF_S1] = RTW89_PHY_0;/* S0/1->HWB0 */
+		}
+	} else {
+		if (wl->mlo_info.rf_combination == BTC_MLO_RF_2_PLUS_0)
+			path_hwb[BTC_RF_S1] = RTW89_PHY_0; /* 2+0 RF-S0/1->HWB0 */
+		else if (wl->mlo_info.rf_combination == BTC_MLO_RF_0_PLUS_2)
+			path_hwb[BTC_RF_S0] = RTW89_PHY_1; /* 2+0 RF-S0/1->HWB1 */
+	}
+
+	/*
+	 * tdd_map = sit_xmap * fdm_map, 1: WL-RF-Sx vs. BTx take TDD-Action
+	 * fdd_map =(!sit_xmap) * fdm_map, 1: WL-RF-Sx vs.BTx take FDD-Action
+	 * co-rx map = ant_xmap * fdm_map 1:WL/BT co-rx (for halbb-btg-ctrl)
+	 * sit_xmap,ant_xmap = 0 or 1, so tdd/fdd use multiplication (*)
+	 */
+
+	for (i = 0; i < BTC_RF_NUM; i++)
+		for (j = 0; j < BTC_ALL_BT_EZL; j++) {
+			dm->tdd_map[i][j] = dm->sit_xmap[i][j] *
+					    dm->fit_xmap[path_hwb[i]][j];
+			dm->fdd_map[i][j] = !dm->sit_xmap[i][j] *
+					     dm->fit_xmap[path_hwb[i]][j];
+			dm->corx_map[i][j] = dm->ant_xmap[i][j] *
+					     dm->fit_xmap[path_hwb[i]][j];
+	}
+
+	/* TDD-Binding */
+	_set_bind_info(btc, BTC_MECH_TDD);
+
+	/* FDD-Binding */
+	_set_bind_info(btc, BTC_MECH_FDD);
+
+	dm->out_of_band = !dm->tdd_bind.rf_band && !dm->fdd_bind.rf_band;
+	dm->fdd_en = !!dm->fdd_bind.rf_band;
+	dm->tdd_en = !!dm->tdd_bind.rf_band;
+
+	/* set BT on/off state for GNT_WL Combined-MUX control */
+	if (bt0->enable.now)
+		val |= BIT(0);
+
+	if (bt1->enable.now)
+		val |= BIT(1);
+
+	if (bt2->func_type)
+		val |= BIT(2);
+
+	dm->ost_info.bt_enable_state = dm->bt_only ? _bind_is_btonly : val;
+}
+
 static
 void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 {
@@ -7842,6 +8109,8 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	bt->scan_rx_low_pri = false;
 	igno_bt = false;
 
+	_set_coex_binding(btc);
+
 	dm->freerun_chk = _check_freerun(rtwdev); /* check if meet freerun */
 
 	if (always_freerun) {
@@ -8370,8 +8639,8 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 		    "[BTC], %s(): bt_info[2]=0x%02x\n",
 		    __func__, bt->raw_info[2]);
 
-	b->profile_cnt.last = b->profile_cnt.now;
-	b->profile_cnt.now = 0;
+	b->link_cnt.last = b->link_cnt.now;
+	b->link_cnt.now = 0;
 	hid->type = 0;
 
 	/* parse raw info low-Byte2 */
@@ -8384,13 +8653,13 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	bt->bcnt[BTC_BCNT_INQPAG] += !!(bt->inq_pag.now && !bt->inq_pag.last);
 
 	hfp->exist = btinfo.lb2.hfp;
-	b->profile_cnt.now += (u8)hfp->exist;
+	b->link_cnt.now += (u8)hfp->exist;
 	hid->exist = btinfo.lb2.hid;
-	b->profile_cnt.now += (u8)hid->exist;
+	b->link_cnt.now += (u8)hid->exist;
 	a2dp->exist = btinfo.lb2.a2dp;
-	b->profile_cnt.now += (u8)a2dp->exist;
+	b->link_cnt.now += (u8)a2dp->exist;
 	pan->exist = btinfo.lb2.pan;
-	b->profile_cnt.now += (u8)pan->exist;
+	b->link_cnt.now += (u8)pan->exist;
 	btc->dm.trx_info.bt_profile = u32_get_bits(btinfo.val, BT_PROFILE_PROTOCOL_MASK);
 
 	/* parse raw info low-Byte3 */
@@ -9418,7 +9687,7 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 	p += scnprintf(p, end - p, " %-15s : profile:%s%s%s%s%s ",
 		       "[profile]",
-		       (bt_linfo->profile_cnt.now == 0) ? "None," : "",
+		       (bt_linfo->link_cnt.now == 0) ? "None," : "",
 		       bt_linfo->hfp_desc.exist ? "HFP," : "",
 		       bt_linfo->hid_desc.exist ? "HID," : "",
 		       bt_linfo->a2dp_desc.exist ?
@@ -9520,7 +9789,7 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		p += scnprintf(p, end - p, "\n");
 	}
 
-	if (ver_main >= 9 && bt_linfo->profile_cnt.now)
+	if (ver_main >= 9 && bt_linfo->link_cnt.now)
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_TX_PWR_LVL, true);
 	else
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_TX_PWR_LVL, false);
@@ -9542,7 +9811,7 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	}
 	p += scnprintf(p, end - p, "\n");
 
-	if (bt_linfo->profile_cnt.now || bt_linfo->status.map.ble_connect)
+	if (bt_linfo->link_cnt.now || bt_linfo->status.map.ble_connect)
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP, true);
 	else
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP, false);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3f77707e2733..21bdf229723c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1445,6 +1445,11 @@ enum rtw89_btc_bt_state_cnt {
 	BTC_BCNT_NUM,
 };
 
+enum rtw89_btc_bt_mech_type {
+	BTC_MECH_TDD = 0,
+	BTC_MECH_FDD = 1,
+};
+
 enum rtw89_btc_bt_rf_band {
 	BTC_BT_B2G = 0x0, /* 2.4GHz */
 	BTC_BT_B5G = 0x1, /* 5GHz or 6GHz */
@@ -1463,6 +1468,12 @@ enum rtw89_btc_bt_profile {
 	BTC_BT_HID = BIT(1),
 	BTC_BT_A2DP = BIT(2),
 	BTC_BT_PAN = BIT(3),
+	BTC_BT_BIS = BIT(4),
+	BTC_BT_CIS = BIT(5),
+	BTC_BT_THREAD = BIT(6),
+	BTC_BT_ULL = BIT(7),
+	BTC_BT_LEGACY = 0xf,
+	BTC_BT_FULL = 0x3f,
 	BTC_PROFILE_MAX = 4,
 };
 
@@ -1688,16 +1699,16 @@ struct rtw89_btc_bt_ver_info {
 };
 
 struct rtw89_btc_bool_sta_chg {
-	u32 now: 1;
-	u32 last: 1;
-	u32 remain: 1;
-	u32 srvd: 29;
+	u8 now: 1;
+	u8 last: 1;
+	u8 remain: 1;
+	u8 srvd: 5;
 };
 
 struct rtw89_btc_u8_sta_chg {
 	u8 now;
 	u8 last;
-	u8 remain;
+	u8 chg;
 	u8 rsvd;
 };
 
@@ -1956,6 +1967,8 @@ struct rtw89_btc_bt_smap {
 	u32 sco_busy: 1;
 	u32 mesh_busy: 1;
 	u32 inq_pag: 1;
+	u32 profile_map: 8;
+	u32 rsvd: 18;
 };
 
 union rtw89_btc_bt_state_map {
@@ -1974,14 +1987,30 @@ struct rtw89_btc_bt_txpwr_desc {
 	u8 le_gain_index;
 };
 
+struct rtw89_btc_bt_leaudio_desc {
+	u32 bis_exist: 1;
+	u32 bis_exist_last: 1;
+	u32 cis_exist: 1;
+	u32 cis_exist_last: 1;
+	u32 bis_cnt: 3;
+	u32 cis_cnt: 3;
+	u32 rssi: 8;
+	u32 bis_cnt_last: 3;
+	u32 cis_cnt_last: 3;
+	u32 rsvd: 8;
+
+	u16 diff_t;
+};
+
 struct rtw89_btc_bt_link_info {
-	struct rtw89_btc_u8_sta_chg profile_cnt;
+	struct rtw89_btc_u8_sta_chg link_cnt;
 	struct rtw89_btc_bool_sta_chg multi_link;
 	struct rtw89_btc_bool_sta_chg relink;
 	struct rtw89_btc_bt_hfp_desc hfp_desc;
 	struct rtw89_btc_bt_hid_desc hid_desc;
 	struct rtw89_btc_bt_a2dp_desc a2dp_desc;
 	struct rtw89_btc_bt_pan_desc pan_desc;
+	struct rtw89_btc_bt_leaudio_desc leaudio_desc;
 	union rtw89_btc_bt_state_map status;
 	struct rtw89_btc_bt_txpwr_desc bt_txpwr_desc;
 
@@ -1990,14 +2019,59 @@ struct rtw89_btc_bt_link_info {
 	u8 rssi_state[BTC_BT_RSSI_THMAX];
 	u8 afh_map[BTC_BT_AFH_GROUP];
 	u8 afh_map_le[BTC_BT_AFH_LE_GROUP];
+	u8 rssi;
+
+	u8 role_sw: 1;
+	u8 slave_role: 1;
+	u8 afh_update: 1;
+	u8 cqddr: 1;
+	u8 tx_3m: 1;
+	u8 inq: 1;
+	u8 pag: 1;
+	u8 igno_wl: 1;
+
+	u8 ble_scan_en: 1;
+	u8 reinit: 1;
+	u8 rsvd: 6;
+};
 
-	u32 role_sw: 1;
-	u32 slave_role: 1;
-	u32 afh_update: 1;
-	u32 cqddr: 1;
-	u32 rssi: 8;
-	u32 tx_3m: 1;
-	u32 rsvd: 19;
+struct rtw89_btc_bind_bt_status {
+	u8 a2dp_active: 1;
+	u8 a2dp_sink: 1;
+	u8 pan_active: 1;
+	u8 connect: 1;
+	u8 inq_page: 1;
+	u8 multi_link: 1;
+	u8 slave_role: 1;
+	u8 page: 1;
+
+	u8 hfp_exist: 1;
+	u8 hid_exist: 1;
+	u8 a2dp_exist: 1;
+	u8 pan_exist: 1;
+	u8 bis_exist: 1;
+	u8 cis_exist: 1;
+	u8 thread_exist: 1;
+	u8 ull_exist: 1;
+
+	u8 hid_cnt;
+	u8 hid_type;
+	u8 cis_cnt;
+	u8 link_cnt;
+
+	u16 a2dp_vendor_id;
+};
+
+struct rtw89_btc_bind_info {
+	u8 wl_hwb_sel; /* map */
+	u8 wl_link_mode;
+	u8 wl_bg_mode;
+	u8 rf_band; /* map, 0: no any rf-band bind */
+	u8 bt_sel; /* map */
+	u8 bt_link_weight; /* select the highest weight between bt/rf-band */
+
+	u32 bt_profile; /* map */
+	struct rtw89_btc_bind_bt_status bt_smap;
 };
 
 struct rtw89_btc_extsoc_info {
@@ -2105,6 +2179,7 @@ struct rtw89_btc_wl_info {
 	u8 coex_mode;
 	u8 pta_req_mac;
 	u8 bt_polut_type[RTW89_PHY_NUM]; /* BT polluted WL-Tx type for phy0/1  */
+	u8 rf_band_map[RTW89_PHY_NUM]; /* rf_band bit-map */
 
 	bool is_5g_hi_channel;
 	bool go_client_exist;
@@ -2291,6 +2366,7 @@ union rtw89_btc_fbtc_btscan {
 
 struct rtw89_btc_bt_info {
 	struct rtw89_btc_bt_link_info link_info;
+	struct rtw89_btc_bt_link_info link_info_56g;
 	struct rtw89_btc_bt_scan_info_v1 scan_info_v1[BTC_SCAN_MAX1];
 	struct rtw89_btc_bt_scan_info_v2 scan_info_v2[CXSCAN_MAX];
 	struct rtw89_btc_bt_ver_info ver_info;
@@ -2301,6 +2377,7 @@ struct rtw89_btc_bt_info {
 
 	u8 raw_info[BTC_BTINFO_MAX]; /* raw bt info from mailbox */
 	u8 txpwr_info[BTC_BTINFO_MAX];
+	u8 link_weight[BTC_BT_BMAX]; /* Link Weight for RF-band/HWB selection */
 	u8 rssi_level;
 	u8 rf_band_map;
 	u8 func_type;
@@ -3178,6 +3255,7 @@ struct rtw89_btc_fbtc_outsrc_set_info {
 
 	u8 pta_req_hw_band;
 	u8 rf_gbt_source;
+	u8 bt_enable_state;
 } __packed;
 
 union rtw89_btc_fbtc_slot_u {
@@ -3200,8 +3278,20 @@ struct rtw89_btc_dm {
 	struct rtw89_btc_wl_scc_ctrl wl_scc;
 	struct rtw89_btc_trx_info trx_info;
 	union rtw89_btc_dm_error_map error;
+	struct rtw89_btc_bind_info tdd_bind;
+	struct rtw89_btc_bind_info fdd_bind;
 	u32 cnt_dm[BTC_DCNT_NUM];
 	u32 cnt_notify[BTC_NCNT_NUM];
+	u8 ant_xmap[BTC_RF_NUM][BTC_ALL_BT_EZL]; /* WL-BT ANT interact-map */
+	u8 xtk_xmap[BTC_RF_NUM][BTC_ALL_BT_EZL]; /* 1: If RSSI<(BT-Pin -SIR) */
+	u8 sit_xmap[BTC_RF_NUM][BTC_ALL_BT_EZL]; /* WL-BT space interact-map */
+	u8 fit_xmap[RTW89_PHY_NUM][BTC_ALL_BT_EZL]; /* HWB-BT freq interact-map */
+	u8 tdd_map[BTC_RF_NUM][BTC_ALL_BT_EZL];  /* WL-BT tdd-map */
+	u8 fdd_map[BTC_RF_NUM][BTC_ALL_BT_EZL];  /* WL-BT fdd-map */
+	u8 corx_map[BTC_RF_NUM][BTC_ALL_BT_EZL]; /* WL-BT Co-Rx */
+
+	u8 sit_xmap_last[BTC_RF_NUM][BTC_ALL_BT_EZL];
+	u8 fit_xmap_last[RTW89_PHY_NUM][BTC_ALL_BT_EZL];
 
 	u32 update_slot_map;
 	u32 set_ant_path;
@@ -3239,9 +3329,12 @@ struct rtw89_btc_dm {
 	u8 freerun_chk: 1;
 	u8 wl_pre_agc_rb: 2;
 	u8 bt_select: 2; /* 0:s0, 1:s1, 2:s0 & s1, refer to enum btc_bt_index */
+
 	u8 slot_req_more: 1;
+	u8 out_of_band: 1;
+	u8 fdd_en: 1;
+	u8 tdd_en: 1;
 	u8 lps_ctrl_scbd: 1;
-
 	u8 lps_ctrl_scbd_last: 1;
 	u8 lps_ctrl_change: 1;
 };
-- 
2.25.1


