Return-Path: <linux-wireless+bounces-38896-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eM0SL9cEU2pVWAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38896-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:07:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD01743A4D
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:07:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=eAkFO0B7;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38896-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38896-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFE60301809E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC8F2773DE;
	Sun, 12 Jul 2026 03:06:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B882571DA
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:06:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783825605; cv=none; b=mEqlnYQdEXIeJMEL5hFI8LPMw7y3g++jo2y60P92gC+r1lE5xTavriw0ymzKqHxaw2j5FPF9qE0VyNvn4I2zrikPfrcxN7pSGTXSfcrno/ZozwCvmBWjpI4NTttHHAA3UWGBniJAT3zXAiYMY68JgKoxpMFkGaCqokbQ4fMKkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783825605; c=relaxed/simple;
	bh=w45GSDByEM8YAlAfagZZdYDM3flODUGojtJBpEJNuWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGjosRJubPdGqyfdBKw5RNzQOhzL+3Hz1LHhII84eBeaVZTMzoE2bu+0dIQBlSNuqf2OcGvfauqIp0w4WggKcHTgwkaOIpz3sWdiRYMFH1qnDK3wH2NA171y6qcG2Xv+3P7p4lhqxElhSLyfcEmqzQcuZqyotymtSu47tt8nGv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eAkFO0B7; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C36fJK2525946, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783825601; bh=CY7hdocGpk+Ecbw+DbiPugSxrxFFsHBB6/Foa6Xcjg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eAkFO0B7VFbLDG1TQoiOfFvYoXh64IeIRkTftXUCf4Bb8XceQbhL554EY5kS2DpGV
	 e68mKuJOH9FNjjzx+i6OOakKqWtJJ1LcZKny9t47F76rEVJ3msR+NbfIctfXLzyGYK
	 iviSvhmdLeOKbjRxvnPPuSlqmkhEeoNyKOs1owKfjN/HT62imLTGLJgEUdLd6z/RnD
	 +tscDd4GTu+6O4KdeHQILbpQaU4VhzGX1AygsXelFvUyqaCZoSZJQW2kpc4OkDOPKG
	 H2WqGNq/dkOhNYjsRjjQG1fX1k/lbrsZ6FQiJrbuMXGe+fNZ0yfBRtWl1D9CBV3sMk
	 +yxXMK2WiMX8g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C36fJK2525946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:06:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:41 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:06:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 07/11] wifi: rtw89: coex: Refine _reset_btc_var()
Date: Sun, 12 Jul 2026 11:05:02 +0800
Message-ID: <20260712030506.43438-8-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-38896-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FD01743A4D

From: Ching-Te Ku <ku920601@realtek.com>

To avoid the default value not match the real using scenario, it should
after assign desired default value after variable reset.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c |  68 ++++++++----
 drivers/net/wireless/realtek/rtw89/coex.h |   8 ++
 drivers/net/wireless/realtek/rtw89/core.h | 127 ++++++++++++++++++++++
 3 files changed, 180 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 07d054f59eb5..17290b2cb2c8 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1048,44 +1048,52 @@ static int _send_fw_cmd(struct rtw89_dev *rtwdev, u8 h2c_class, u8 h2c_func,
 	return ret;
 }
 
-#define BTC_BT_DEF_BR_TX_PWR 4
-#define BTC_BT_DEF_LE_TX_PWR 4
+#define BTC_DEFAULT_SIR_THRES 51 /* dB, BT Pin - This = TDD/FDD swtch thres */
+#define BTC_FDDR_TP_SETUP_TIME 1 /* in second */
+#define BTC_FDDR_TP_HOLD_TIME 3 /* in second */
+#define BTC_FDDR_RX_LOW_RATE_THRES 4  /* low rate for TDD swotch */
 
 static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_cx *cx = &btc->cx;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
-	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
-	struct rtw89_btc_wl_link_info *wl_linfo;
-	u8 i, j;
+	const struct rtw89_btc_ver *ver = btc->ver;
+	struct rtw89_btc_bt_info *bt0 = &cx->bt0;
+	struct rtw89_btc_bt_info *bt1 = &cx->bt1;
+	u8 i;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s\n", __func__);
 
-	if (type & BTC_RESET_CX)
+	if (type & BTC_RESET_CX) {
 		memset(cx, 0, sizeof(*cx));
-
-	if (type & BTC_RESET_BTINFO) /* only for BT enable */
-		memset(bt, 0, sizeof(*bt));
+		cx->bt_ext.max_tx_pwr = RTW89_BTC_BT_DEF_LE_TX_PWR;
+		cx->bt_ext.ant_iso_to_wl = RTW89_BTC_DEFAULT_ANISO;
+	}
+
+	if (type & BTC_RESET_BTINFO) {/* only for BT enable */
+		memset(bt0, 0, sizeof(*bt0));
+		bt0->link_info.bt_txpwr_desc.br_dbm = RTW89_BTC_BT_DEF_BR_TX_PWR;
+		bt0->link_info_56g.bt_txpwr_desc.br_dbm = RTW89_BTC_BT_DEF_BR_TX_PWR;
+		bt0->link_info.bt_txpwr_desc.le_dbm = RTW89_BTC_BT_DEF_LE_TX_PWR;
+		bt0->link_info_56g.bt_txpwr_desc.le_dbm = RTW89_BTC_BT_DEF_LE_TX_PWR;
+		bt0->ant_iso_to_wl = RTW89_BTC_DEFAULT_ANISO;
+	} else if (type & BTC_RESET_BTINFO2) {
+		memset(bt1, 0, sizeof(*bt1));
+		bt1->link_info.bt_txpwr_desc.br_dbm = RTW89_BTC_BT_DEF_BR_TX_PWR;
+		bt1->link_info_56g.bt_txpwr_desc.br_dbm = RTW89_BTC_BT_DEF_BR_TX_PWR;
+		bt1->link_info.bt_txpwr_desc.le_dbm = RTW89_BTC_BT_DEF_LE_TX_PWR;
+		bt1->link_info_56g.bt_txpwr_desc.le_dbm = RTW89_BTC_BT_DEF_LE_TX_PWR;
+		bt1->ant_iso_to_wl = RTW89_BTC_DEFAULT_ANISO;
+	}
 
 	if (type & BTC_RESET_CTRL) {
 		memset(&btc->ctrl, 0, sizeof(btc->ctrl));
-		btc->manual_ctrl = false;
 		btc->ctrl.trace_step = FCXDEF_STEP;
 	}
 
 	/* Init Coex variables that are not zero */
 	if (type & BTC_RESET_DM) {
 		memset(&btc->dm, 0, sizeof(btc->dm));
-		memset(bt_linfo->rssi_state, 0, sizeof(bt_linfo->rssi_state));
-		for (j = RTW89_MAC_0; j <= RTW89_MAC_1; j++) {
-			for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
-				wl_linfo = &wl->rlink_info[i][j];
-				memset(wl_linfo->rssi_state, 0, sizeof(wl_linfo->rssi_state));
-			}
-		}
 
 		/* set the slot_now table to original */
 		btc->dm.tdma_now = t_def[CXTD_OFF];
@@ -1108,18 +1116,32 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 		btc->policy_len = 0;
 		btc->bt_req_len[RTW89_PHY_0] = 0;
 		btc->bt_req_len[RTW89_PHY_1] = 0;
+		btc->hubmsg_cnt = 0;
+
 		btc->dm.coex_info_map = BTC_COEX_INFO_ALL;
 		btc->dm.wl_tx_limit.tx_time = BTC_MAX_TX_TIME_DEF;
 		btc->dm.wl_tx_limit.tx_retry = BTC_MAX_TX_RETRY_DEF;
+		btc->dm.bt_slot_flood = BTC_B1_MAX;
+		btc->dm.sir_thres = BTC_DEFAULT_SIR_THRES;
+		btc->dm.fddr_info.tp_setup_time = BTC_FDDR_TP_SETUP_TIME;
+		btc->dm.fddr_info.tp_hold_time = BTC_FDDR_TP_HOLD_TIME;
+		btc->dm.fddr_info.wl_rx_rate_thres = BTC_FDDR_RX_LOW_RATE_THRES;
+		btc->dm.fddt_info.type = BTC_FDDT_TYPE_AUTO;
+
 		btc->dm.wl_pre_agc_rb = BTC_PREAGC_NOTFOUND;
 		btc->dm.wl_btg_rx_rb = BTC_BTGCTRL_BB_GNT_NOTFOUND;
 	}
 
-	if (type & BTC_RESET_MDINFO)
+	if (type & BTC_RESET_MDINFO) {
 		memset(&btc->mdinfo, 0, sizeof(btc->mdinfo));
 
-	bt->link_info.bt_txpwr_desc.br_dbm = BTC_BT_DEF_BR_TX_PWR;
-	bt->link_info.bt_txpwr_desc.le_dbm = BTC_BT_DEF_LE_TX_PWR;
+		if (ver->fcxinit == 10)
+			btc->mdinfo.md_v10.ant.isolation = RTW89_BTC_DEFAULT_ANISO;
+		else if (ver->fcxinit == 7)
+			btc->mdinfo.md_v7.ant.isolation = RTW89_BTC_DEFAULT_ANISO;
+		else
+			btc->mdinfo.md.ant.isolation = RTW89_BTC_DEFAULT_ANISO;
+	}
 }
 
 static u8 _search_reg_index(struct rtw89_dev *rtwdev, u8 mreg_num, u16 reg_type, u32 target)
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index c127bd80d31c..fdd63e2c0837 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -241,6 +241,14 @@ enum btc_3cx_type {
 	BTC_3CX_MAX,
 };
 
+enum btc_fddt_type {
+	BTC_FDDT_TYPE_STOP,
+	BTC_FDDT_TYPE_AUTO,
+	BTC_FDDT_TYPE_FIX_TDD,
+	BTC_FDDT_TYPE_FIX_FULL_FDD,
+	BTC_FDDT_MAX,
+};
+
 enum btc_chip_feature {
 	BTC_FEAT_PTA_ONOFF_CTRL  = BIT(0), /* on/off ctrl by HW (not 0x73[2]) */
 	BTC_FEAT_NONBTG_GWL_THRU = BIT(1), /* non-BTG GNT_WL!=0 if GNT_BT = 1 */
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cb3a740e4719..f784e8437292 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2462,6 +2462,9 @@ enum rtw89_btc_bt_func_type {
 
 #define RTW89_BTC_BTC_SCAN_V1_FLAG_ENABLE BIT(0)
 #define RTW89_BTC_BTC_SCAN_V1_FLAG_INTERLACE BIT(1)
+#define RTW89_BTC_BT_DEF_BR_TX_PWR 4
+#define RTW89_BTC_BT_DEF_LE_TX_PWR 4
+#define RTW89_BTC_DEFAULT_ANISO 10
 
 struct rtw89_btc_bt_scan_info_v1 {
 	__le16 win;
@@ -2521,6 +2524,7 @@ struct rtw89_btc_bt_info {
 	u8 func_type;
 	u8 tx_power_now;
 	u8 tx_power_now_6g;
+	u8 ant_iso_to_wl; /* ant isolation between BTx and WL */
 
 	u8 fw_ver_mismatch: 1;
 	u8 band_56G_support: 1;
@@ -3474,6 +3478,123 @@ union rtw89_btc_fbtc_slot_u {
 	struct rtw89_btc_fbtc_slot_v7 v7[CXST_MAX];
 };
 
+struct rtw89_btc_fddr_cell {
+	u8 en;
+	u8 wl_rx_max;
+	u8 wl_rx_min;
+};
+
+struct rtw89_btc_fddr_result {
+	u8 wl_rx_limit;
+	u8 wl_rx_limit_step[6]; /* record search process */
+	u8 search_cnt; /* the rx-limit serach count */
+	u32 wl_tp;
+	u32 wl_tp_step[6]; /* record search process */
+};
+
+struct rtw89_btc_fddr_train_info {
+	u8 rx_limit_pre;
+	u8 rx_limit_now;
+
+	u32 tp_rec_cnt;
+	u32 tp_avg_cnt;
+
+	u32 wl_tp_pre;
+	u32 wl_tp_now;
+};
+
+struct rtw89_btc_fddr_info {
+	u8 state; /* refer to enum btc_fddr_state */
+	u8 cell_now; /* wl rssi_level after filter LNA != 6 */
+	u8 cell_change;
+	u8 wl_low_rate;
+
+	u8 tp_setup_time; /* calculate TP after this value (in second) */
+	u8 tp_hold_time; /* TP calculation period (in second) */
+	u8 wl_rssi_thres[BTC_WL_RSSI_THMAX]; /* index 0 -> Max RSSI */
+
+	u8 search_mode; /* 0: search, 1:look-up  */
+	u8 search_dir; /* 0: Max->Min, 1:Min->Max */
+
+	struct rtw89_btc_fddr_train_info tctrl; /* train flag */
+	struct rtw89_btc_fddr_result cell_result[BTC_WL_RSSI_THMAX + 1];
+	struct rtw89_btc_fddr_cell cell[BTC_WL_RSSI_THMAX + 1]; /* parameters */
+
+	u16 wl_rx_rate_thres; /* switch to TDD if rx_rate < this threshold */
+
+	u32 nrsn_map; /* the reason map for no-run fdd-traing */
+	u32 wl_rx_rate_now;
+};
+
+struct rtw89_btc_rpt_ctrl_a2dp_empty {
+	u32 cnt_empty; /* a2dp empty count */
+	u32 cnt_flowctrl; /* a2dp empty flow control counter */
+	u32 cnt_tx;
+	u32 cnt_ack;
+	u32 cnt_nack;
+};
+
+struct rtw89_btc_fddt_bt_stat {
+	struct rtw89_btc_rpt_ctrl_a2dp_empty a2dp_last;
+	u32 retry_last;
+};
+
+struct rtw89_btc_fddt_cell {
+	s8 wl_pwr_min;
+	s8 wl_pwr_max;
+	s8 bt_pwr_dec_max;
+	s8 bt_rx_gain;
+};
+
+struct rtw89_btc_fddt_fail_check { /* for cell stay in training */
+	u8 check_map; /* check pass condition if bit-map = 1 */
+	u8 bt_no_empty_cnt; /* 0-fail if no bt-empty >= th in train_cycle */
+	u8 wl_tp_ratio; /* 1-fail if wl tp rise ratio < th */
+	u8 wl_kpibtr_ratio; /* 2-fail if phase_now_tp < phase_last_tp * kpibtr_ratio */
+};
+
+struct rtw89_btc_fddt_break_check { /* for cell stay in training or train-ok */
+	u8 check_map; /* check break condition if bit-map = 1 */
+	u8 bt_no_empty_cnt; /* 0-break if no empty count >= th */
+	u8 wl_tp_ratio; /* 1-break if wl tp ratio < th (%) */
+	u8 wl_tp_low_bound; /* 2-break if wl tp (in Mbps) < th */
+
+	u8 cn; /* 3-break if (cn >= cn_limit) >= th cycle */
+	u8 cell_chg; /* 4-break if non-matched-RSSI >= th cycle */
+	s8 nhm_limit; /* 5-break if nhm >= th --> ill-condition */
+	u8 cn_limit; /* if condition number >= th --> ill-condition */
+};
+
+struct rtw89_btc_fddt_time_ctrl {
+	/* 1 TDD cycle = w1 + b1, FDD 1cycle = w1fdd-slot + b1fdd-slot */
+	u8 m_cycle; /* KPI Moving-Average-Cycle: 1~32 cycles */
+	u8 w_cycle; /* Start to calcul WKPI after this if train-phase change */
+	u8 k_cycle; /* Total kpi-estimate cycles for each training-step */
+	u8 rsvd;
+};
+
+struct rtw89_btc_fddt_train_info {
+	struct rtw89_btc_fddt_time_ctrl t_ctrl;
+	struct rtw89_btc_fddt_break_check b_chk;
+	struct rtw89_btc_fddt_fail_check f_chk;
+	struct rtw89_btc_fddt_cell cell_ul[5][5];
+	struct rtw89_btc_fddt_cell cell_dl[5][5];
+};
+
+struct rtw89_btc_fddt_info {
+	u8 type; /* refer to enum btc_fddt_type */
+	u8 result; /* fw send fdd-training status by c2h */
+	u8 state; /* refer to enum btc_fddt_state */
+
+	u8 wl_iot[6]; /* wl bssid  */
+	u16 bt_iot; /* bt vendor-id */
+
+	u32 nrsn_map; /* the reason map for no-run fdd-traing */
+	struct rtw89_btc_fddt_bt_stat bt_stat; /* bt statistics */
+	struct rtw89_btc_fddt_train_info train;
+	struct rtw89_btc_fddt_train_info train_now;
+};
+
 struct rtw89_btc_dm {
 	struct rtw89_btc_fbtc_outsrc_set_info ost_info_last; /* outsrc API setup info */
 	struct rtw89_btc_fbtc_outsrc_set_info ost_info; /* outsrc API setup info */
@@ -3493,6 +3614,8 @@ struct rtw89_btc_dm {
 	union rtw89_btc_dm_error_map error;
 	struct rtw89_btc_bind_info tdd_bind;
 	struct rtw89_btc_bind_info fdd_bind;
+	struct rtw89_btc_fddt_info fddt_info;
+	struct rtw89_btc_fddr_info fddr_info;
 	u32 cnt_dm[BTC_DCNT_NUM];
 	u32 cnt_notify[BTC_NCNT_NUM];
 	u8 ant_xmap[BTC_RF_NUM][BTC_ALL_BT_EZL]; /* WL-BT ANT interact-map */
@@ -3506,6 +3629,10 @@ struct rtw89_btc_dm {
 	u8 sit_xmap_last[BTC_RF_NUM][BTC_ALL_BT_EZL];
 	u8 fit_xmap_last[RTW89_PHY_NUM][BTC_ALL_BT_EZL];
 
+	u8 tdd_rssi_thres;  /* The FDD/TDD switch RSSI (in %) */
+	u8 sir_thres; /* WL(Signal) to BT(interference Pin) ratio */
+	u8 sir_state[BTC_ALL_BT_EZL]; /* 1: WL RSSI > BTx-interference */
+
 	u32 update_slot_map;
 	u32 set_ant_path;
 	u32 e2g_slot_limit;
-- 
2.25.1


