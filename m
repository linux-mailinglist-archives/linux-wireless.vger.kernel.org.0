Return-Path: <linux-wireless+bounces-38890-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aN12CK4EU2pIWAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38890-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:06:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15C743A2F
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:06:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=IoFvkGoB;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38890-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38890-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E2C3300DF7D
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E83C2BCF4C;
	Sun, 12 Jul 2026 03:06:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E172773DE
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:06:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783825579; cv=none; b=JaTSAEvda5mmYMmYHQ9mJJ7LMvYXOMtIC4SXxNZY61zxfFJCFu3DFAHuqtrG0LCg7o8MOoq7BzyrzHHAMltc7mBxnYvwaPnhjRW3TGvITOjncEL3FejPupFuHUwJvadKiA5s0d02dupSdqpdGjCeXDZGrWPpMLrQCzAbROeU47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783825579; c=relaxed/simple;
	bh=SrPJ84gy6jiiLBXMWUSI4VB95zqgrPLjwj5vzvY8/dE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rulJth+PajVHIn+K4Ck6t+oLKNRmdA8ol+p3FprqhpQwWJ94wnnHxZ4GavGgRC7jNylmh5a+dGM/jZcjg+6vHTQkD34bo41YK3+lyNHE2evmXM7xPPMPVra4HnJ0bDJhnc7+vBDDUkEAZ5PbicxaWBI+JPUatMKhNDNZ4CkizXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IoFvkGoB; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C36EbxC525843, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783825574; bh=vUnSb9A28WYoQQUDloQ4bib2SQIXsc+7j1mDtGWUD40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=IoFvkGoBw9HhpcSSFe0L0HE+NWyNwOKpryrNr1cVuk6NSkP2OLXlcQKJY3UeFqBYB
	 9EikJfzpFsqIETJ33Kzx1Y1PqE9Wi5jz3VmQdDXnEtcI14c4MaUEU5kUooTJ/+OOWQ
	 fypcnMt3TAYwY+TNJMCFNgBQAvl05Q1Lt/M+ZZLOVaHty98iqvZK593Cl+c80iAtTq
	 5ITGoKE+O24Itf8SiYQY5AINp0oMSGOmh0uaRlEPamOqDJxAqoMzxEGS7Z8F5zMahg
	 xjAL+pARbulogK4pI3ewhfpmoqsJJz0R/vpbixisGKBSBNAKz3eVEE75zc16VTBuAu
	 /cM3SRC/zYZoA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C36EbxC525843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:06:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:14 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:06:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 02/11] wifi: rtw89: coex: Rearrange coexistence control structure
Date: Sun, 12 Jul 2026 11:04:57 +0800
Message-ID: <20260712030506.43438-3-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38890-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E15C743A2F

From: Ching-Te Ku <ku920601@realtek.com>

The control structure will record some Wi-Fi/Bluetooth status, and
packed send to firmware. The new generation chip had offloaded many
mechanism control to firmware, firmware may need update these very
often to make sure run in correct mechanism.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c  | 154 ++++++++++-----------
 drivers/net/wireless/realtek/rtw89/core.h  |  76 ++++++++--
 drivers/net/wireless/realtek/rtw89/debug.c |   6 +-
 drivers/net/wireless/realtek/rtw89/fw.c    |  63 ++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h    |   6 +
 5 files changed, 207 insertions(+), 98 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index c02de0b4f7bf..72586179ec2c 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -295,10 +295,11 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 static const union rtw89_btc_wl_state_map btc_scanning_map = {
 	.map = {
 		.scan = 1,
-		.connecting = 1,
+		.dhcp = 1,
 		.roaming = 1,
-		.dbccing = 1,
+		.transacting = 1,
 		._4way = 1,
+		.handshake = 1,
 	},
 };
 
@@ -998,8 +999,7 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 	if (type & BTC_RESET_CTRL) {
 		memset(&btc->ctrl, 0, sizeof(btc->ctrl));
 		btc->manual_ctrl = false;
-		if (ver->fcxctrl != 7)
-			btc->ctrl.ctrl.trace_step = FCXDEF_STEP;
+		btc->ctrl.trace_step = FCXDEF_STEP;
 	}
 
 	/* Init Coex variables that are not zero */
@@ -1601,7 +1601,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	case BTC_RPT_TYPE_STEP:
 		pcinfo = &pfwinfo->rpt_fbtc_step.cinfo;
 		if (ver->fcxctrl != 7)
-			trace_step = btc->ctrl.ctrl.trace_step;
+			trace_step = btc->ctrl.trace_step;
 
 		if (ver->fcxstep == 2) {
 			pfinfo = &pfwinfo->rpt_fbtc_step.finfo.v2;
@@ -3542,8 +3542,9 @@ static void _update_btc_state_map(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 
-	if (wl->status.map.connecting || wl->status.map._4way ||
-	    wl->status.map.roaming || wl->status.map.dbccing) {
+	if (wl->status.map.dhcp || wl->status.map._4way ||
+	    wl->status.map.roaming || wl->status.map.transacting ||
+	    wl->status.map.handshake) {
 		cx->state_map = BTC_WLINKING;
 	} else if (wl->status.map.scan) { /* wl scan */
 		if (bt_linfo->status.map.inq_pag)
@@ -5883,7 +5884,6 @@ static void rtw89_tx_time_iter(void *data, struct ieee80211_sta *sta)
 static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
@@ -5894,19 +5894,14 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_txtime_data data = {.rtwdev = rtwdev};
 	bool reenable = false;
-	u8 igno_bt, tx_retry;
+	u8 tx_retry;
 	u32 tx_time;
 	u16 enable;
 
 	if (btc->manual_ctrl)
 		return;
 
-	if (ver->fcxctrl == 7)
-		igno_bt = btc->ctrl.ctrl_v7.igno_bt;
-	else
-		igno_bt = btc->ctrl.ctrl.igno_bt;
-
-	if (btc->dm.freerun || igno_bt || b->link_cnt.now == 0 ||
+	if (btc->dm.freerun || btc->ctrl.igno_bt || b->link_cnt.now == 0 ||
 	    dm->tdd_bind.rf_band == BIT(RTW89_BAND_5G) ||
 	    wl_rinfo->link_mode == BTC_WLINK_NOLINK) {
 		enable = 0;
@@ -6216,7 +6211,7 @@ static void _action_wl_scan(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 
 	if (btc->cx.state_map != BTC_WLINKING &&
-	    RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
+	    btc->ctrl.wl_ctrl_info.fw_scan) {
 		_action_wl_25g_mcc(rtwdev);
 		rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], Scan offload!\n");
 	} else if (rtwdev->dbcc_en) {
@@ -7124,11 +7119,13 @@ void rtw89_coex_act1_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): enter\n", __func__);
 	dm->cnt_notify[BTC_NCNT_TIMER]++;
-	if (wl->status.map._4way)
-		wl->status.map._4way = false;
-	if (wl->status.map.connecting)
-		wl->status.map.connecting = false;
-
+	if (wl->status.map.handshake ||
+	    wl->status.map._4way ||
+	    wl->status.map.dhcp) {
+		wl->status.map._4way = 0;
+		wl->status.map.dhcp = 0;
+		wl->status.map.handshake = 0;
+	}
 	_run_coex(rtwdev, BTC_RSN_ACT1_WORK);
 }
 
@@ -7616,32 +7613,53 @@ static void _set_coex_binding(struct rtw89_btc *btc)
 	dm->ost_info.bt_enable_state = dm->bt_only ? _bind_is_btonly : val;
 }
 
+static void _update_run_ctrl_info(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_ctrl ctrl = btc->ctrl;
+	struct rtw89_fbtc_wl_ctrl_info *wl_ctrl_info = &ctrl.wl_ctrl_info;
+	u8 i;
+
+	ctrl.wl_only = dm->wl_only;
+	ctrl.bt_only = dm->bt_only;
+	ctrl.ntfy_type = dm->run_reason;
+
+	wl_ctrl_info->smap_val = wl->status.val;
+	wl_ctrl_info->rfk_state = wl->rfk_info.state;
+	wl_ctrl_info->rfk_type = wl->rfk_info.type;
+	wl_ctrl_info->client_pstdma_on =  dm->client_ps_tdma_on;
+	wl_ctrl_info->fw_scan = wl->scan_info.fw_scan;
+
+	for (i = RTW89_MAC_0; i <= RTW89_MAC_1; i++) {
+		wl_ctrl_info->rf_band_map[i] = wl->rf_band_map[i];
+		wl_ctrl_info->rf_ch[i] = wl->rf_ch_info[i].center_ch;
+	}
+
+	if (!memcmp(&btc->ctrl, &ctrl, sizeof(struct rtw89_btc_ctrl))) {
+		memcpy(&btc->ctrl, &ctrl, sizeof(struct rtw89_btc_ctrl));
+		if (btc->ver->fcxctrl >= 9)
+			_fw_set_drv_info(rtwdev, CXDRVINFO_CTRL);
+	}
+}
+
 static
 void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	u8 mode = btc->dm.tdd_bind.wl_link_mode;
 	u8 mode_v0 = wl->role_info.link_mode_v0;
-	u8 igno_bt, always_freerun;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	dm->run_reason = reason;
 	_update_dm_step(rtwdev, reason);
 
-	if (ver->fcxctrl == 7) {
-		igno_bt = btc->ctrl.ctrl_v7.igno_bt;
-		always_freerun = btc->ctrl.ctrl_v7.always_freerun;
-	} else {
-		igno_bt = btc->ctrl.ctrl.igno_bt;
-		always_freerun = btc->ctrl.ctrl.always_freerun;
-	}
-
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): reason=%d, mode=%d\n",
 		    __func__, reason, mode);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): wl_only=%d, bt_only=%d\n",
@@ -7655,15 +7673,6 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		return;
 	}
 
-	if (igno_bt &&
-	    (reason == BTC_RSN_UPDATE_BT_INFO ||
-	     reason == BTC_RSN_UPDATE_BT_SCBD)) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): return for Stop Coex DM!!\n",
-			    __func__);
-		return;
-	}
-
 	if (!wl->status.map.init_ok) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): return for WL init fail!!\n",
@@ -7690,6 +7699,8 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		}
 	}
 
+	_update_run_ctrl_info(rtwdev);
+
 	if (reason == BTC_RSN_NTFY_INIT || reason == BTC_RSN_NTFY_RADIO_STATE)
 		_update_bt_scbd(rtwdev, false);
 
@@ -7697,28 +7708,24 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	dm->cnt_dm[BTC_DCNT_RUN]++;
 	dm->fddt_train = BTC_FDDT_DISABLE;
 	bt->scan_rx_low_pri = false;
-	igno_bt = false;
 
 	_set_coex_binding(btc);
 	_update_btc_state_map(rtwdev);
 
 	dm->freerun_chk = _check_freerun(rtwdev); /* check if meet freerun */
 
-	if (always_freerun) {
+	if (btc->ctrl.always_freerun) {
 		_action_freerun(rtwdev);
-		igno_bt = true;
 		goto exit;
 	}
 
 	if (dm->wl_only) {
 		_action_wl_only(rtwdev);
-		igno_bt = true;
 		goto exit;
 	}
 
 	if (wl->status.map.rf_off || dm->bt_only || wl->status.map.lps) {
 		_action_wl_off(rtwdev, mode);
-		igno_bt = true;
 		goto exit;
 	}
 
@@ -7827,10 +7834,6 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 
 exit:
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): exit\n", __func__);
-	if (ver->fcxctrl == 7)
-		btc->ctrl.ctrl_v7.igno_bt = igno_bt;
-	else
-		btc->ctrl.ctrl.igno_bt = igno_bt;
 	_action_common(rtwdev);
 }
 
@@ -7839,7 +7842,6 @@ void rtw89_btc_init(struct rtw89_dev *rtwdev)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	const struct rtw89_btc_ver *ver = btc->ver;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): Init %s !!\n", __func__,
@@ -7849,10 +7851,6 @@ void rtw89_btc_init(struct rtw89_dev *rtwdev)
 
 	btc->dm.run_reason = BTC_RSN_NONE;
 	btc->dm.run_action = BTC_ACT_NONE;
-	if (ver->fcxctrl >= 7)
-		btc->ctrl.ctrl_v7.igno_bt = true;
-	else
-		btc->ctrl.ctrl.igno_bt = true;
 	wl->status.map.init_ok = true;
 }
 
@@ -7937,7 +7935,6 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_btc_ver *ver = btc->ver;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): mode=%d\n", __func__, mode);
@@ -7948,10 +7945,7 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 	dm->bt_only = mode == BTC_MODE_BT ? 1 : 0;
 	wl->status.map.rf_off = mode == BTC_MODE_WLOFF ? 1 : 0;
 	dm->vid = rtwdev->custid;
-	if (ver->fcxctrl >= 7)
-		btc->ctrl.ctrl_v7.always_freerun = mode == BTC_MODE_COTX;
-	else
-		btc->ctrl.ctrl.always_freerun = mode == BTC_MODE_COTX;
+	btc->ctrl.always_freerun = mode == BTC_MODE_COTX;
 
 	if (!wl->status.map.init_ok) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -8020,6 +8014,9 @@ void rtw89_btc_ntfy_scan_start(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band)
 		_fw_set_drv_info(rtwdev, CXDRVINFO_DBCC);
 	}
 
+	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
+		btc->ctrl.wl_ctrl_info.fw_scan = 1;
+
 	_run_coex(rtwdev, BTC_RSN_NTFY_SCAN_START);
 }
 
@@ -8086,14 +8083,18 @@ void rtw89_btc_ntfy_specific_packet(struct rtw89_dev *rtwdev,
 		cnt = ++wl->wcnt[BTC_WCNT_DHCP];
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): DHCP cnt=%d\n", __func__, cnt);
-		wl->status.map.connecting = true;
+		wl->status.map.handshake = 0;
+		wl->status.map._4way = 0;
+		wl->status.map.dhcp = 1;
 		delay_work = true;
 		break;
 	case PACKET_EAPOL:
 		cnt = ++wl->wcnt[BTC_WCNT_EAPOL];
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): EAPOL cnt=%d\n", __func__, cnt);
-		wl->status.map._4way = true;
+		wl->status.map.handshake = 0;
+		wl->status.map._4way = 1;
+		wl->status.map.dhcp = 0;
 		delay_work = true;
 		if (hfp->exist || hid->exist)
 			delay /= 2;
@@ -8103,7 +8104,7 @@ void rtw89_btc_ntfy_specific_packet(struct rtw89_dev *rtwdev,
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): EAPOL_End cnt=%d\n",
 			    __func__, cnt);
-		wl->status.map._4way = false;
+		wl->status.map._4way = 0;
 		wiphy_delayed_work_cancel(rtwdev->hw->wiphy, &rtwdev->coex_act1_work);
 		break;
 	case PACKET_ARP:
@@ -8435,10 +8436,16 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 	    wlinfo->connected == MLME_NO_LINK)
 		btc->dm.leak_ap = 0;
 
-	if (state == BTC_ROLE_MSTS_STA_CONN_START)
-		wl->status.map.connecting = 1;
-	else
-		wl->status.map.connecting = 0;
+	if (state == BTC_ROLE_MSTS_STA_CONN_START) {
+		wl->status.map.transacting = 1;
+		wiphy_delayed_work_cancel(rtwdev->hw->wiphy, &rtwdev->coex_act1_work);
+		wiphy_delayed_work_queue(rtwdev->hw->wiphy,
+					 &rtwdev->coex_act1_work,
+					 RTW89_COEX_ACT1_WORK_PERIOD);
+	} else {
+		wiphy_delayed_work_cancel(rtwdev->hw->wiphy, &rtwdev->coex_act1_work);
+		wl->status.map.transacting = 0;
+	}
 
 	if (state == BTC_ROLE_MSTS_STA_DIS_CONN ||
 	    state == BTC_ROLE_MSTS_STA_CONN_END)
@@ -9116,8 +9123,8 @@ static int _show_wl_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		       wl->scan_info.band[RTW89_PHY_0], wl->scan_info.phy_map);
 
 	p += scnprintf(p, end - p,
-		       "connecting:%s, roam:%s, 4way:%s, init_ok:%s\n",
-		       wl->status.map.connecting ? "Y" : "N",
+		       "handshake:%s, roam:%s, 4way:%s, init_ok:%s\n",
+		       wl->status.map.handshake ? "Y" : "N",
 		       wl->status.map.roaming ?  "Y" : "N",
 		       wl->status.map._4way ? "Y" : "N",
 		       wl->status.map.init_ok ? "Y" : "N");
@@ -9718,12 +9725,10 @@ static int _show_dm_step(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 static int _show_dm_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	char *p = buf, *end = buf + bufsz;
-	u8 igno_bt;
 
 	if (!(dm->coex_info_map & BTC_COEX_INFO_DM))
 		return 0;
@@ -9744,14 +9749,9 @@ static int _show_dm_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 	p += _show_dm_step(rtwdev, p, end - p);
 
-	if (ver->fcxctrl == 7)
-		igno_bt = btc->ctrl.ctrl_v7.igno_bt;
-	else
-		igno_bt = btc->ctrl.ctrl.igno_bt;
-
 	p += scnprintf(p, end - p,
 		       " %-15s : wl_only:%d, bt_only:%d, igno_bt:%d, free_run:%d, wl_ps_ctrl:%d, wl_mimo_ps:%d, ",
-		       "[dm_flag]", dm->wl_only, dm->bt_only, igno_bt,
+		       "[dm_flag]", dm->wl_only, dm->bt_only, btc->ctrl.igno_bt,
 		       dm->freerun, btc->btc_ctrl_lps, dm->wl_mimo_ps);
 
 	p += scnprintf(p, end - p, "leak_ap:%d, fw_offload:%s%s\n",
@@ -10742,7 +10742,7 @@ static int _show_fbtc_step_v2(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 			if (ver->fcxctrl == 7 || ver->fcxctrl == 1)
 				trace_step = 50;
 			else
-				trace_step = btc->ctrl.ctrl.trace_step;
+				trace_step = btc->ctrl.trace_step;
 
 			n_start = pos_old;
 			if (pos_new >=  pos_old)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ded788534651..0b20ee7d7a28 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1531,19 +1531,20 @@ enum rtw89_tfc_dir {
 struct rtw89_btc_wl_smap {
 	u32 busy: 1;
 	u32 scan: 1;
-	u32 connecting: 1;
+	u32 dhcp: 1;
 	u32 roaming: 1;
-	u32 dbccing: 1;
+	u32 transacting: 1;
 	u32 _4way: 1;
+	u32 handshake: 1;
 	u32 rf_off: 1;
-	u32 lps: 2;
-	u32 ips: 1;
-	u32 init_ok: 1;
-	u32 traffic_dir : 2;
 	u32 rf_off_pre: 1;
+	u32 ips: 1;
+	u32 lps: 2;
 	u32 lps_pre: 2;
 	u32 lps_exiting: 1;
 	u32 emlsr: 1;
+	u32 init_ok: 1;
+	u32 traffic_dir : 2;
 };
 
 enum rtw89_tfc_interval {
@@ -1725,7 +1726,9 @@ struct rtw89_btc_u8_sta_chg {
 struct rtw89_btc_wl_scan_info {
 	u8 band[RTW89_PHY_NUM];
 	u8 phy_map;
-	u8 rsvd;
+	u8 hw_band_map;
+	u8 type;
+	u8 fw_scan;
 };
 
 struct rtw89_btc_wl_dbcc_info {
@@ -3458,6 +3461,7 @@ struct rtw89_btc_dm {
 	u8 run_action;
 	u8 wl_tx_pwr_phy_map;
 	u8 vid;
+	u8 client_ps_tdma_on;
 
 	u8 wl_pre_agc: 2;
 	u8 wl_lna2: 1;
@@ -3477,13 +3481,38 @@ struct rtw89_btc_dm {
 	bool pre_agc_chg;
 };
 
+struct rtw89_fbtc_wl_ctrl_info {
+	u8 rf_band_map[RTW89_MAC_NUM];
+	u8 rf_ch[RTW89_MAC_NUM];
+
+	u8 client_pstdma_on;
+	u8 fw_scan;
+	u8 rfk_state;
+	u8 rfk_type;
+
+	u32 smap_val;
+};
+
 struct rtw89_btc_ctrl {
+	u32 manual;
+	u32 igno_bt: 1;
+	u32 always_freerun: 1;
+	u32 trace_step: 16;
+
+	u8 wl_only;
+	u8 bt_only;
+
+	u8 ntfy_type;
+	struct rtw89_fbtc_wl_ctrl_info wl_ctrl_info;
+};
+
+struct rtw89_btc_ctrl_v0 {
 	u32 manual: 1;
 	u32 igno_bt: 1;
 	u32 always_freerun: 1;
 	u32 trace_step: 16;
 	u32 rsvd: 12;
-};
+} __packed;
 
 struct rtw89_btc_ctrl_v7 {
 	u8 manual;
@@ -3492,10 +3521,31 @@ struct rtw89_btc_ctrl_v7 {
 	u8 rsvd;
 } __packed;
 
-union rtw89_btc_ctrl_list {
-	struct rtw89_btc_ctrl ctrl;
-	struct rtw89_btc_ctrl_v7 ctrl_v7; /* ver 8, 9 is the same */
-};
+struct rtw89_fbtc_wl_ctrl_info_v9 {
+	u8 rf_band_map[RTW89_MAC_NUM];
+	u8 rf_ch[RTW89_MAC_NUM];
+
+	u8 client_pstdma_on;
+	u8 fw_scan;
+	u8 rfk_state;
+	u8 rfk_type;
+
+	__le32 smap_val;
+} __packed;
+
+struct rtw89_btc_ctrl_v9 {
+	u8 manual;
+	u8 always_freerun;
+	u8 wl_only;
+	u8 bt_only;
+
+	u8 ntfy_type;
+	u8 rsvd0;
+	u8 rsvd1;
+	u8 rsvd2;
+
+	struct rtw89_fbtc_wl_ctrl_info_v9 wl_ctrl_info;
+} __packed;
 
 struct rtw89_btc_dbg {
 	/* cmd "rb" */
@@ -3701,7 +3751,7 @@ struct rtw89_btc {
 
 	struct rtw89_btc_cx cx;
 	struct rtw89_btc_dm dm;
-	union rtw89_btc_ctrl_list ctrl;
+	struct rtw89_btc_ctrl ctrl;
 	union rtw89_btc_module_info mdinfo;
 	struct rtw89_btc_btf_fwinfo fwinfo;
 	struct rtw89_btc_dbg dbg;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index e42dc5707576..8b41991963e8 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3900,17 +3900,13 @@ static ssize_t rtw89_debug_priv_btc_manual_set(struct rtw89_dev *rtwdev,
 					       const char *buf, size_t count)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	int ret;
 
 	ret = kstrtobool(buf, &btc->manual_ctrl);
 	if (ret)
 		return ret;
 
-	if (ver->fcxctrl == 7)
-		btc->ctrl.ctrl_v7.manual = btc->manual_ctrl;
-	else
-		btc->ctrl.ctrl.manual = btc->manual_ctrl;
+	btc->ctrl.manual = btc->manual_ctrl;
 
 	return count;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 41c033d2ae7b..59e51e67d51b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6441,7 +6441,7 @@ int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
-	struct rtw89_btc_ctrl *ctrl = &btc->ctrl.ctrl;
+	struct rtw89_btc_ctrl *ctrl = &btc->ctrl;
 	struct sk_buff *skb;
 	u8 *cmd;
 	int ret;
@@ -6484,7 +6484,7 @@ int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type)
 int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_ctrl_v7 *ctrl = &btc->ctrl.ctrl_v7;
+	struct rtw89_btc_ctrl *ctrl = &btc->ctrl;
 	struct rtw89_h2c_cxctrl_v7 *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -6501,7 +6501,64 @@ int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type)
 	h2c->hdr.type = type;
 	h2c->hdr.ver = btc->ver->fcxctrl;
 	h2c->hdr.len = sizeof(*h2c) - H2C_LEN_CXDRVHDR_V7;
-	h2c->ctrl = *ctrl;
+
+	h2c->ctrl.manual = ctrl->manual;
+	h2c->ctrl.igno_bt = ctrl->igno_bt;
+	h2c->ctrl.always_freerun = ctrl->always_freerun;
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, BTFC_SET,
+			      SET_DRV_INFO, 0, 0, len);
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
+int rtw89_fw_h2c_cxdrv_ctrl_v9(struct rtw89_dev *rtwdev, u8 type)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_ctrl *ctrl = &btc->ctrl;
+	struct rtw89_fbtc_wl_ctrl_info_v9 *cinfo;
+	struct rtw89_h2c_cxctrl_v9 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_ctrl_v7\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxctrl_v9 *)skb->data;
+	cinfo = &h2c->ctrl.wl_ctrl_info;
+
+	h2c->hdr.type = type;
+	h2c->hdr.ver = btc->ver->fcxctrl;
+	h2c->hdr.len = sizeof(*h2c) - H2C_LEN_CXDRVHDR_V7;
+
+	h2c->ctrl.manual = ctrl->manual;
+	h2c->ctrl.always_freerun = ctrl->always_freerun;
+	h2c->ctrl.wl_only = ctrl->wl_only;
+	h2c->ctrl.bt_only = ctrl->bt_only;
+	h2c->ctrl.ntfy_type = ctrl->ntfy_type;
+	memcpy(cinfo->rf_band_map, ctrl->wl_ctrl_info.rf_band_map,
+	       sizeof(cinfo->rf_band_map));
+	memcpy(cinfo->rf_ch, ctrl->wl_ctrl_info.rf_ch, sizeof(cinfo->rf_ch));
+	cinfo->client_pstdma_on = ctrl->wl_ctrl_info.client_pstdma_on;
+	cinfo->fw_scan = ctrl->wl_ctrl_info.fw_scan;
+	cinfo->rfk_state = ctrl->wl_ctrl_info.rfk_state;
+	cinfo->rfk_type = ctrl->wl_ctrl_info.rfk_type;
+	cinfo->smap_val = cpu_to_le32(ctrl->wl_ctrl_info.smap_val);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, BTFC_SET,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 1e4267b22b36..72f56d32e3b0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2430,6 +2430,11 @@ struct rtw89_h2c_cxctrl_v7 {
 	struct rtw89_btc_ctrl_v7 ctrl;
 } __packed;
 
+struct rtw89_h2c_cxctrl_v9 {
+	struct rtw89_h2c_cxhdr_v7 hdr;
+	struct rtw89_btc_ctrl_v9 ctrl;
+} __packed;
+
 #define H2C_LEN_CXDRVHDR sizeof(struct rtw89_h2c_cxhdr)
 #define H2C_LEN_CXDRVHDR_V7 sizeof(struct rtw89_h2c_cxhdr_v7)
 
@@ -5382,6 +5387,7 @@ int rtw89_fw_h2c_cxdrv_role_v10(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_osi_info(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_ctrl_v9(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_trx_v7(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_trx_v9(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev, u8 type);
-- 
2.25.1


