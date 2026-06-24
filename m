Return-Path: <linux-wireless+bounces-38032-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aBxfE8JRO2ptWAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38032-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:40:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B27166BB238
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:40:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=Qmlw5u4s;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38032-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38032-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF6C7302D1BC
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 03:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1300430C610;
	Wed, 24 Jun 2026 03:40:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5613230C161
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:40:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272434; cv=none; b=skGUmhjrq7uNGhYd21Pwsi22n6c78+hEBUk5WIEaKDdQynN4qIzgSzOb0VyAaUO4Evki9GrEYWeGkCCoSGIdNPjffacfREd68RoUjdPMe4OpygtcBFXkKKARyLB8/MVKiYr+AKDu9/GZuhBr3eDfAiW3ZD60gJ2ncBSQQhTSpLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272434; c=relaxed/simple;
	bh=yZDTeP7Vvqp4KS6QV85Bsgan/eF48XIo7/oXXQtgyhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paRnfyfICRI6HTuyiEFGyREP0gEQ9XiSGIsUXfz3qgocVWJH5AahSEeeJQOjkKVpcUrQucvD55RPC3EFptmNPxOAu8+h+qMaJbrNUshMB1JcTVAHVH3PaN97iGOl/vtntjx5FR8/2L6TCoXjXd5bfJUqpYFutcFJ2bjtEEDkbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Qmlw5u4s; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65O3eTZj93888592, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782272429; bh=b4fwoEtP52yYu1CJII693HVJhznAhgaHYZsdUB+aF0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Qmlw5u4su/aHukNz0FQOi2YYV8UMH11t6RI8MwxfWcePX1IQXNh7lw+yvaVgqcGuZ
	 ZdkbdfkXfByFcYv1jFOWF/X2elmknL6YQtHO53ET+RxHv9d4g3CKboUDXSoQAFMXHA
	 W3ewaabaqR8IBPEAGrvoe7MzcLxJ2PekWAt3YXTQ2c8/N0NshaI+UuukLz/uGmZdV6
	 wB6wZV8OZ41e1UDIhOcb4BVlqyLRbCC+ocPC2V8a65N7qQ0c+FlAlOJYA1Ps0eL2qD
	 MuxWW/isUTzDPhnuYx9Ery6HC5NuPCeXj2WtxaO64ifxqx0s6Gmcd2HADUP3HZ26os
	 zsi5P23r3U4HQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65O3eTZj93888592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 11:40:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:40:30 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Jun 2026 11:40:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 01/10] wifi: rtw89: coex: force to exit Wi-Fi LPS while Bluetooth profile exist
Date: Wed, 24 Jun 2026 11:39:32 +0800
Message-ID: <20260624033941.45918-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260624033941.45918-1-pkshih@realtek.com>
References: <20260624033941.45918-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38032-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B27166BB238

From: Ching-Te Ku <ku920601@realtek.com>

Wi-Fi can not reach LPS leave threshold while Wi-Fi only throughput
not good & Bluetooth share bandwidth. Add logic to let force leave
Wi-Fi LPS while Bluetooth profile exist. Update COEX version to 9.0.1.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 87 +++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/core.h |  4 ++
 2 files changed, 69 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 0f7ae572ef91..73f271a7ae7a 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -11,7 +11,7 @@
 #include "ps.h"
 #include "reg.h"
 
-#define RTW89_COEX_VERSION 0x09000013
+#define RTW89_COEX_VERSION 0x09000113
 #define FCXDEF_STEP 50 /* MUST <= FCXMAX_STEP and match with wl fw*/
 #define BTC_E2G_LIMIT_DEF 80
 
@@ -434,6 +434,8 @@ enum btc_b2w_scoreboard {
 	BTC_BSCB_WLRFK = BIT(11),
 	BTC_BSCB_BT_HILNA = BIT(13),
 	BTC_BSCB_BT_CONNECT = BIT(16),
+	BTC_BSCB_PAN_ACT = BIT(28),
+	BTC_BSCB_HFP_ACT = BIT(29),
 	BTC_BSCB_PATCH_CODE = BIT(30),
 	BTC_BSCB_ALL = GENMASK(30, 0),
 };
@@ -2747,7 +2749,9 @@ static void _fw_set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 	    dm->tdma.rxflctrl == CXFLC_QOSNULL)
 		btc->lps = 1;
 	else
-		btc->lps = 0;
+		btc->lps = dm->lps_ctrl_scbd;
+
+	dm->lps_ctrl_scbd_last = dm->lps_ctrl_scbd;
 
 	if (btc->lps == 1)
 		rtw89_set_coex_ctrl_lps(rtwdev, btc->lps);
@@ -4434,7 +4438,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 	if (dm->leak_ap && dm->tdma.leak_n > 1)
 		_tdma_set_lek(btc, 1);
 
-	if (dm->tdma_instant_excute) {
+	if (dm->tdma_instant_excute || dm->lps_ctrl_change) {
 		btc->dm.tdma.option_ctrl |= BIT(0);
 		btc->update_policy_force = true;
 	}
@@ -5638,7 +5642,8 @@ static void _action_common(struct rtw89_dev *rtwdev)
 			_fw_set_drv_info(rtwdev, CXDRVINFO_OSI);
 		}
 	}
-	btc->dm.tdma_instant_excute = 0;
+	dm->tdma_instant_excute = 0;
+	dm->lps_ctrl_change = false;
 	wl->pta_reg_mac_chg = false;
 }
 
@@ -7384,11 +7389,15 @@ void rtw89_coex_rfk_chk_work(struct wiphy *wiphy, struct wiphy_work *work)
 static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
-	u32 val;
-	bool status_change = false;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
+	bool bt_link_change = false, lps_ctrl = false;
+	u32 val, any_bt_connect;
+	u8 mode;
 
 	if (!chip->scbd)
 		return;
@@ -7403,13 +7412,26 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 		return;
 	}
 
+	if (ver->fwlrole == 0)
+		mode = wl->role_info.link_mode;
+	else if (ver->fwlrole == 1)
+		mode = wl->role_info_v1.link_mode;
+	else if (ver->fwlrole == 2)
+		mode = wl->role_info_v2.link_mode;
+	else if (ver->fwlrole == 7)
+		mode = wl->role_info_v7.link_mode;
+	else if (ver->fwlrole == 8)
+		mode = wl->role_info_v8.link_mode;
+	else
+		return;
+
 	if (!(val & BTC_BSCB_ON))
 		bt->enable.now = 0;
 	else
 		bt->enable.now = 1;
 
 	if (bt->enable.now != bt->enable.last)
-		status_change = true;
+		bt_link_change = true;
 
 	/* reset bt info if bt re-enable */
 	if (bt->enable.now && !bt->enable.last) {
@@ -7423,29 +7445,52 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 	bt->mbx_avl = !!(val & BTC_BSCB_ACT);
 
 	if (bt->whql_test != !!(val & BTC_BSCB_WHQL))
-		status_change = true;
+		bt_link_change = true;
 
 	bt->whql_test = !!(val & BTC_BSCB_WHQL);
 	bt->btg_type = val & BTC_BSCB_BT_S1 ? BTC_BT_BTG : BTC_BT_ALONE;
 	bt->link_info.a2dp_desc.exist = !!(val & BTC_BSCB_A2DP_ACT);
+	bt->link_info.pan_desc.exist = !!(val & BTC_BSCB_PAN_ACT);
+	bt->link_info.hfp_desc.exist = !!(val & BTC_BSCB_HFP_ACT);
 
 	bt->lna_constrain = !!(val & BTC_BSCB_BT_LNAB0) +
 			    !!(val & BTC_BSCB_BT_LNAB1) * 2 + 4;
 
 	/* if rfk run 1->0 */
 	if (bt->rfk_info.map.run && !(val & BTC_BSCB_RFK_RUN))
-		status_change = true;
+		bt_link_change = true;
 
 	bt->rfk_info.map.run  = !!(val & BTC_BSCB_RFK_RUN);
 	bt->rfk_info.map.req = !!(val & BTC_BSCB_RFK_REQ);
 	bt->hi_lna_rx = !!(val & BTC_BSCB_BT_HILNA);
-	bt->link_info.status.map.connect = !!(val & BTC_BSCB_BT_CONNECT);
-	if (bt->run_patch_code != !!(val & BTC_BSCB_PATCH_CODE))
-		status_change = true;
+	any_bt_connect = !!(val & BTC_BSCB_BT_CONNECT);
+
+	/* if connect change */
+	if (bt->link_info.status.map.connect != any_bt_connect)
+		bt_link_change = true;
+
+	/* if specific profile exist */
+	if (((bt->link_info.a2dp_desc.exist || bt->link_info.pan_desc.exist ||
+	      bt->link_info.hfp_desc.exist) && mode == BTC_WLINK_2G_STA) ||
+	    bt->whql_test)
+		lps_ctrl = true;
+
+	if (dm->lps_ctrl_scbd != lps_ctrl) {
+		dm->lps_ctrl_scbd = lps_ctrl;
+		bt_link_change = true;
+		dm->lps_ctrl_change = true;
+	} else {
+		dm->lps_ctrl_change = false;
+	}
+
+	bt->link_info.status.map.connect = any_bt_connect;
 	bt->run_patch_code = !!(val & BTC_BSCB_PATCH_CODE);
 
-	if (!only_update && status_change)
-		_run_coex(rtwdev, BTC_RSN_UPDATE_BT_SCBD);
+	if (bt_link_change) {
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s: bt status change!!\n", __func__);
+		/* TODO: Need to notify driver to update EXT-CTRL-BT-SLOT */
+	}
 }
 
 #define BTC_BTINFO_PWR_LEN 5
@@ -7560,7 +7605,8 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	}
 
 	if (wl->status.map.rf_off_pre == wl->status.map.rf_off &&
-	    wl->status.map.lps_pre == wl->status.map.lps) {
+	    wl->status.map.lps_pre == wl->status.map.lps &&
+	    !dm->lps_ctrl_change && !dm->lps_ctrl_scbd) {
 		if (reason == BTC_RSN_NTFY_POWEROFF ||
 		    reason == BTC_RSN_NTFY_RADIO_STATE) {
 			rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -7577,6 +7623,9 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		}
 	}
 
+	if (reason == BTC_RSN_NTFY_INIT || reason == BTC_RSN_NTFY_RADIO_STATE)
+		_update_bt_scbd(rtwdev, false);
+
 	dm->freerun = false;
 	dm->cnt_dm[BTC_DCNT_RUN]++;
 	dm->fddt_train = BTC_FDDT_DISABLE;
@@ -7597,7 +7646,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		goto exit;
 	}
 
-	if (wl->status.map.rf_off || wl->status.map.lps || dm->bt_only) {
+	if (wl->status.map.rf_off || dm->bt_only || wl->status.map.lps) {
 		_action_wl_off(rtwdev, mode);
 		igno_bt = true;
 		goto exit;
@@ -7781,7 +7830,6 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 
 	_write_scbd(rtwdev,
 		    BTC_WSCB_ACTIVE | BTC_WSCB_ON | BTC_WSCB_BTLOG, true);
-	_update_bt_scbd(rtwdev, true);
 	if (rtw89_mac_get_ctrl_path(rtwdev)) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): PTA owner warning!!\n",
@@ -8339,7 +8387,6 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_MREG, true);
 		val = BTC_WSCB_ACTIVE | BTC_WSCB_ON | BTC_WSCB_BTLOG;
 		_write_scbd(rtwdev, val, true);
-		_update_bt_scbd(rtwdev, true);
 		chip->ops->btc_init_cfg(rtwdev);
 	} else {
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_ALL, false);
@@ -8349,10 +8396,6 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 			_write_scbd(rtwdev, BTC_WSCB_ALL, false);
 		else
 			_write_scbd(rtwdev, BTC_WSCB_ACTIVE, false);
-
-		if (rf_state == BTC_RFCTRL_LPS_WL_ON &&
-		    wl->status.map.lps_pre != BTC_LPS_OFF)
-			_update_bt_scbd(rtwdev, true);
 	}
 
 	btc->dm.cnt_dm[BTC_DCNT_BTCNT_HANG] = 0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5547888d7e67..de92e42da614 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3153,6 +3153,10 @@ struct rtw89_btc_dm {
 	u8 wl_pre_agc_rb: 2;
 	u8 bt_select: 2; /* 0:s0, 1:s1, 2:s0 & s1, refer to enum btc_bt_index */
 	u8 slot_req_more: 1;
+	u8 lps_ctrl_scbd: 1;
+
+	u8 lps_ctrl_scbd_last: 1;
+	u8 lps_ctrl_change: 1;
 };
 
 struct rtw89_btc_ctrl {
-- 
2.25.1


