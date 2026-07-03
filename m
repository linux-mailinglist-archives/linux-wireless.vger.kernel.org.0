Return-Path: <linux-wireless+bounces-38582-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kptlGCuhR2pVcgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38582-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 13:46:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C8701FEE
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 13:46:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=cByQkwTb;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38582-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38582-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9D6F30233D8
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2121F3B3C11;
	Fri,  3 Jul 2026 11:43:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CA7386440
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 11:43:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079039; cv=none; b=Env1nhHPFPh9Ti5nRe6I2zZJl5jNC3Yn4mvYBkc6rzbcmuHSF6OAh5jsCazLn2mO+aycWz2WBX3JNEMMmxD3wKRgB1T2vRmQtXhT8aygSiSwZD/jViOvGQF76t3rJfQcmZMPtnV5TS5RJ/Ir1eLENMzF8uvHWT6bJkHJMX65M7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079039; c=relaxed/simple;
	bh=YdAlK1JG3u1Cb3lC4Fh3u7+IoXwP4lGklc96fDuYzqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NF5Xj89H3RsMzM7bmHy+31GaSyOBkxS08lc5PoaQd4sUxKLv7bfDWs7tOo1umuaKLfogE+lFJZDibHgNEKyomjIOVt9fRkJiLo+LJAHvyGKC/ghWLYh9ldPR3Av4FHMZ+vWJ066tNuliMGUPLeMxR3lt2Ni5iVM46fH8V3Rc+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cByQkwTb; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 663BhsLyB2637675, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783079034; bh=zQTYzm4TrZwD5nHIx0KNE6uRXS672VB5iyzls3F66YY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cByQkwTbSXlzZSupXvsJiOY/fTkhO49fHu4dDuHecIjSnpMslC9c30+lfb6h96oKp
	 CwAa230kVM5HK/zIXSzArvN76YunHpiOZylCdpdBjyLLu9KOpcgiOitJK+KUhWGiOI
	 O1qPJzu82coujz3RQ6b5Ml394r0i8O8zQoHo3QvMnvuWLU7TzsgrbsP7yUL1ZOQFp7
	 EuZ6VdfWkntVqjfJapbiwylbsltJOMcylhMnRYxRJ5HejeuznpWXaj9mBA+giipdw/
	 hSQqILNgSs3ASPmzW38tnarlQI93s0R27012nAVTxWeLt5BXytVnfTbno6ixcTlgFW
	 aq+G2sTN3mR+g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 663BhsLyB2637675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 19:43:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 19:43:54 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 19:43:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 8/9] wifi: rtw89: coex: Update scoreboard related logic for dual Bluetooth
Date: Fri, 3 Jul 2026 19:43:10 +0800
Message-ID: <20260703114311.2609942-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260703114311.2609942-1-pkshih@realtek.com>
References: <20260703114311.2609942-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38582-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA4C8701FEE

From: Ching-Te Ku <ku920601@realtek.com>

Update WiFi status to each Bluetooth & collect status from the two
Bluetooth adapter by non-stop power zone register. To correct the meaning
of variable, redefine the naming for the variables.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 525 ++++++++++++++--------
 drivers/net/wireless/realtek/rtw89/coex.h |   9 +
 drivers/net/wireless/realtek/rtw89/core.c |   4 +-
 drivers/net/wireless/realtek/rtw89/core.h |  33 +-
 4 files changed, 370 insertions(+), 201 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 86833b0cd47c..d45fab32ab46 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -461,7 +461,14 @@ enum btc_b2w_scoreboard {
 	BTC_BSCB_BT_LNAB1 = BIT(10),
 	BTC_BSCB_WLRFK = BIT(11),
 	BTC_BSCB_BT_HILNA = BIT(13),
+	BTC_BSCB_BT_HILNA_56G = BIT(14),
+	BTC_BSCB_CTCODE = BIT(15),
 	BTC_BSCB_BT_CONNECT = BIT(16),
+	BTC_BSCB_BT_CONNECT_56G = BIT(17),
+	BTC_BSCB_BT_LNAB0_56G = BIT(18),
+	BTC_BSCB_BT_LNAB1_56G = BIT(19),
+	BTC_BSCB_BT_15DOT4 = BIT(24),
+	BTC_BSCB_BT_PROTECT = BIT(27),
 	BTC_BSCB_PAN_ACT = BIT(28),
 	BTC_BSCB_HFP_ACT = BIT(29),
 	BTC_BSCB_PATCH_CODE = BIT(30),
@@ -808,6 +815,8 @@ enum btc_reset_module {
 	BTC_RESET_CXDM = BIT(0) | BIT(1),
 	BTC_RESET_BTINFO = BIT(3),
 	BTC_RESET_MDINFO = BIT(4),
+	BTC_RESET_BT_PSD_DM = BIT(5),
+	BTC_RESET_BTINFO2 = BIT(6),
 	BTC_RESET_ALL =  GENMASK(7, 0),
 };
 
@@ -905,8 +914,9 @@ enum btc_reason_and_action {
 
 static void _run_coex(struct rtw89_dev *rtwdev,
 		      enum btc_reason_and_action reason);
-static void _write_scbd(struct rtw89_dev *rtwdev, u32 val, bool state);
-static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update);
+static void _write_scbd(struct rtw89_dev *rtwdev, u8 bid, u32 val, bool state);
+static u8 _sned_h2c_w2bscbd(struct rtw89_dev *rtwdev, bool force_exec, u8 bid);
+static void _update_bt_scbd(struct rtw89_dev *rtwdev, u8 bid);
 
 static int _send_fw_cmd(struct rtw89_dev *rtwdev, u8 h2c_class, u8 h2c_func,
 			void *param, u16 len)
@@ -1272,11 +1282,6 @@ static void _chk_btc_err(struct rtw89_dev *rtwdev, u8 type, u32 cnt)
 			dm->cnt_dm[BTC_DCNT_BTCNT_HANG]++;
 		else
 			dm->cnt_dm[BTC_DCNT_BTCNT_HANG] = 0;
-
-		if ((dm->cnt_dm[BTC_DCNT_BTCNT_HANG] >= BTC_CHK_HANG_MAX &&
-		     bt->enable.now) || (!dm->cnt_dm[BTC_DCNT_BTCNT_HANG] &&
-		     !bt->enable.now))
-			_update_bt_scbd(rtwdev, false);
 		break;
 	case BTC_DCNT_WL_SLOT_DRIFT:
 		if (cnt >= BTC_CHK_WLSLOT_DRIFT_MAX)
@@ -1755,7 +1760,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				rtwdev->chip->ops->btc_update_bt_cnt(rtwdev);
 				_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
 
-				bt->bcnt[BTC_BCNT_POLUT] =
+				bt->bcnt[BTC_BCNT_POLLUTED] =
 					rtw89_mac_get_plt_cnt(rtwdev,
 							      RTW89_MAC_0);
 			}
@@ -1778,7 +1783,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_LO_TX]);
 			bt->bcnt[BTC_BCNT_LOPRI_RX] =
 				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_LO_RX]);
-			bt->bcnt[BTC_BCNT_POLUT] =
+			bt->bcnt[BTC_BCNT_POLLUTED] =
 				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_POLLUTED]);
 
 			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
@@ -1810,7 +1815,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				le16_to_cpu(prpt->v5.bt_cnt[BTC_BCNT_LO_TX]);
 			bt->bcnt[BTC_BCNT_LOPRI_RX] =
 				le16_to_cpu(prpt->v5.bt_cnt[BTC_BCNT_LO_RX]);
-			bt->bcnt[BTC_BCNT_POLUT] =
+			bt->bcnt[BTC_BCNT_POLLUTED] =
 				le16_to_cpu(prpt->v5.bt_cnt[BTC_BCNT_POLLUTED]);
 
 			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
@@ -1837,7 +1842,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_LO_TX_V105]);
 			bt->bcnt[BTC_BCNT_LOPRI_RX] =
 				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_LO_RX_V105]);
-			bt->bcnt[BTC_BCNT_POLUT] =
+			bt->bcnt[BTC_BCNT_POLLUTED] =
 				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_POLLUTED_V105]);
 
 			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
@@ -2791,14 +2796,14 @@ static void _fw_set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 
 	if (dm->tdma.rxflctrl == CXFLC_NULLP ||
 	    dm->tdma.rxflctrl == CXFLC_QOSNULL)
-		btc->lps = 1;
+		btc->btc_ctrl_lps = 1;
 	else
-		btc->lps = dm->lps_ctrl_scbd;
+		btc->btc_ctrl_lps = dm->lps_ctrl_scbd;
 
 	dm->lps_ctrl_scbd_last = dm->lps_ctrl_scbd;
 
-	if (btc->lps == 1)
-		rtw89_set_coex_ctrl_lps(rtwdev, btc->lps);
+	if (btc->btc_ctrl_lps == 1)
+		rtw89_set_coex_ctrl_lps(rtwdev, btc->btc_ctrl_lps);
 
 	ret = _send_fw_cmd(rtwdev, BTFC_SET, SET_CX_POLICY,
 			   btc->policy, btc->policy_len);
@@ -2813,8 +2818,8 @@ static void _fw_set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 	if (btc->update_policy_force)
 		btc->update_policy_force = false;
 
-	if (btc->lps == 0)
-		rtw89_set_coex_ctrl_lps(rtwdev, btc->lps);
+	if (btc->btc_ctrl_lps == 0)
+		rtw89_set_coex_ctrl_lps(rtwdev, btc->btc_ctrl_lps);
 }
 
 static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 index)
@@ -2913,21 +2918,35 @@ void btc_fw_event(struct rtw89_dev *rtwdev, u8 evt_id, void *data, u32 len)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
+	u8 i;
 
-	rtw89_debug(rtwdev, RTW89_DBG_BTC,
-		    "[BTC], %s(): evt_id:%d len:%d\n",
-		    __func__, evt_id, len);
+	_parse_btc_report(rtwdev, pfwinfo, data, len);
 
-	if (!len || !data)
+	if (!rtwdev->chip->scbd)
 		return;
 
-	switch (evt_id) {
-	case BTF_EVNT_RPT:
-		_parse_btc_report(rtwdev, pfwinfo, data, len);
-		break;
-	default:
-		break;
+	if (!btc->dm.scbd_b2w_update)
+		return; /* skip if init or no-update */
+
+	for (i = BTC_BT_1ST; i <= BTC_BT_2ND; i++) {
+		bt = (i == BTC_BT_1ST) ? &btc->cx.bt0 : &btc->cx.bt1;
+
+		if (bt->scbd_c2h != bt->scbd_rb) {
+			/* if btx b2w scbd non-sync */
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s() bt%d:c2h->0x%08x, rb->0x%08x\n",
+				    __func__, i, bt->scbd_c2h, bt->scbd_rb);
+			bt->scbd_c2h = bt->scbd_rb;
+			_update_bt_scbd(rtwdev, i);
+			btc->dm.scbd_b2w_update = false;
+		}
 	}
+
+	if (!btc->dm.scbd_b2w_update)
+		_run_coex(rtwdev, BTC_RSN_UPDATE_BT_SCBD);
+	else
+		btc->dm.scbd_b2w_update = 0;
 }
 
 static void _set_gnt(struct rtw89_dev *rtwdev, u8 phy_map, u8 wl_state, u8 bt_state)
@@ -3298,7 +3317,7 @@ static void _set_bt_rx_gain(struct rtw89_dev *rtwdev, bool force_exec, u8 bid,
 		if (buf[0] != BTC_BT_RX_NORMAL_LVL)
 			state = true;
 
-		_write_scbd(rtwdev, scbd_bit, state);
+		_write_scbd(rtwdev, bid, scbd_bit, state);
 	}
 
 }
@@ -3406,7 +3425,7 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 
 	if (dm->fddt_train) {
 		_set_wl_rx_gain(rtwdev, 1, RTW89_PHY_0);
-		_write_scbd(rtwdev, BTC_WSCB_RXGAIN, true);
+		_write_scbd(rtwdev, bid, BTC_WSCB_RXGAIN, true);
 	} else {
 		_set_wl_tx_power(rtwdev, para.wl_tx_power[RTW89_PHY_0], RTW89_PHY_0);
 		_set_wl_rx_gain(rtwdev, para.wl_rx_gain[RTW89_PHY_0], RTW89_PHY_0);
@@ -3899,14 +3918,22 @@ static void _set_tdma_bind(struct rtw89_dev *rtwdev, bool tdma_on)
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	struct rtw89_btc_bind_info *bind;
 	u8 null_role = RTW89_WIFI_ROLE_STATION;
+	u8 bt_sel;
 
 	if (dm->tdd_en)
 		bind = &dm->tdd_bind; /* tdd = 1 && fdd = 0 or 1 */
 	else
 		bind = &dm->fdd_bind; /* tdd = 0 && fdd = 1 */
 
+	if (bind->bt_sel >= (BIT(BTC_BT_1ST) | BIT(BTC_BT_2ND)))
+		bt_sel = BTC_ALL_BT;
+	else if (bind->bt_sel == BIT(BTC_BT_2ND))
+		bt_sel = BTC_BT_2ND;
+	else
+		bt_sel = BTC_BT_1ST;
+
 	/* notify BT TDMA on/off by scoreboard for ACL/Scan schedule */
-	_write_scbd(rtwdev, BTC_WSCB_TDMA, tdma_on);
+	_write_scbd(rtwdev, bt_sel, BTC_WSCB_TDMA, tdma_on);
 
 	/*
 	 * set hwb/bt bind to TDMA policy parameter
@@ -5849,7 +5876,7 @@ static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 	if (bt_hi_lna_rx == bt->hi_lna_rx)
 		return;
 
-	_write_scbd(rtwdev, BTC_WSCB_BT_HILNA, bt_hi_lna_rx);
+	_write_scbd(rtwdev, BTC_BT_1ST, BTC_WSCB_BT_HILNA, bt_hi_lna_rx);
 }
 
 static void _set_bt_rx_scan_pri(struct rtw89_dev *rtwdev)
@@ -5857,7 +5884,8 @@ static void _set_bt_rx_scan_pri(struct rtw89_dev *rtwdev)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 
-	_write_scbd(rtwdev, BTC_WSCB_RXSCAN_PRI, (bool)(!!bt->scan_rx_low_pri));
+	_write_scbd(rtwdev, BTC_ALL_BT, BTC_WSCB_RXSCAN_PRI,
+		    (bool)(!!bt->scan_rx_low_pri));
 }
 
 static void _wl_req_mac(struct rtw89_dev *rtwdev, u8 mac)
@@ -5897,6 +5925,7 @@ static void _action_common(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	u32 bt_rom_code_id, bt_fw_ver;
+	u8 i;
 
 	if (btc->ver->fwlrole == 8)
 		_wl_req_mac(rtwdev, rinfo_v8->pta_req_band);
@@ -5929,13 +5958,8 @@ static void _action_common(struct rtw89_dev *rtwdev)
 			rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_MREG, 1);
 	}
 
-	if (wl->scbd_change) {
-		rtw89_mac_cfg_sb(rtwdev, wl->scbd);
-		rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], write scbd: 0x%08x\n",
-			    wl->scbd);
-		wl->scbd_change = false;
-		wl->wcnt[BTC_WCNT_SCBDUPDATE]++;
-	}
+	for (i = BTC_BT_1ST; i <= BTC_BT_2ND; i++)
+		_sned_h2c_w2bscbd(rtwdev, false, i);
 
 	if (btc->ver->fcxosi) {
 		if (memcmp(&dm->ost_info_last, &dm->ost_info,
@@ -6187,42 +6211,97 @@ static void _action_wl_2g_nan(struct rtw89_dev *rtwdev)
 	}
 }
 
-static u32 _read_scbd(struct rtw89_dev *rtwdev)
+static u8 _sned_h2c_w2bscbd(struct rtw89_dev *rtwdev, bool force_exec, u8 bid)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
-	u32 scbd_val = 0;
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
+	u8 cnt_idx = BTC_WCNT_SCBDUPDATE;
+	u8 h2c_func = SET_IOFLD_SCBD;
+	u8 buf[4];
 
-	if (!chip->scbd)
-		return 0;
+	if (bid == BTC_BT_2ND) {
+		if (!(rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT))
+			return 0;
+
+		h2c_func |= BT_H2C_FUNC_BT2ND;
+		cnt_idx = BTC_WCNT_SCBDUPDATE2;
+	}
 
-	scbd_val = rtw89_mac_get_sb(rtwdev);
-	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], read scbd: 0x%08x\n",
-		    scbd_val);
+	if (wl->scbd_chg[bid] || force_exec) {
+		/* Add delay to avoid BT FW loss information */
 
-	btc->cx.bt0.bcnt[BTC_BCNT_SCBDREAD]++;
-	return scbd_val;
+		btc_dw2b(buf, 0, (wl->scbd[bid] | BIT(31))); /* trig */
+		if (rtwdev->chip->para_ver & BTC_FEAT_H2C_MACRO) {
+			if (!_send_fw_cmd(rtwdev, BTFC_SET,
+					  h2c_func, buf, sizeof(buf)))
+				return 0;
+		} else {
+			rtw89_mac_cfg_sb(rtwdev, wl->scbd[bid]);
+		}
+		wl->scbd_chg[bid] = 0;
+		wl->wcnt[cnt_idx]++;
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s() write BT%d scbd:0x%08x\n",
+			    __func__, bid, wl->scbd[bid]);
+	}
+	return 1;
 }
 
-static void _write_scbd(struct rtw89_dev *rtwdev, u32 val, bool state)
+static void _write_scbd(struct rtw89_dev *rtwdev, u8 bid, u32 val, bool state)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	u32 scbd_val = 0;
-	u8 force_exec = false;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u8 force_exec, id, id_start, id_stop;
+	u32 scbd = 0;
 
 	if (!chip->scbd)
 		return;
 
-	scbd_val = state ? wl->scbd | val : wl->scbd & ~val;
+	if (bid == BTC_ALL_BT) {
+		id_start = BTC_BT_1ST;
+		id_stop = BTC_BT_2ND;
+	} else {
+		id_start = bid;
+		id_stop = bid;
+	}
 
-	if (val & BTC_WSCB_ACTIVE || val & BTC_WSCB_ON)
-		force_exec = true;
+	for (id = id_start; id <= id_stop; id++) {
+		force_exec = false;
+		if (!(rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT) &&
+		    id == BTC_BT_2ND)
+			continue;
 
-	if (scbd_val != wl->scbd || force_exec) {
-		wl->scbd = scbd_val;
-		wl->scbd_change = true;
+		if (state)
+			scbd = wl->scbd[id] | val;
+		else
+			scbd = wl->scbd[id] & (~val);
+
+		if (val & BTC_WSCB_CTCODE ||
+		    val & BTC_WSCB_RXGAIN ||
+		    val & BTC_WSCB_RXGAIN_56G) { /* instant exec */
+			force_exec = true;
+			wl->scbd[id] = scbd;
+			dm->scbd_write_instant = 1;
+			if (rtwdev->chip->para_ver & BTC_FEAT_H2C_MACRO)
+				_sned_h2c_w2bscbd(rtwdev, force_exec, id);
+			else
+				rtw89_mac_cfg_sb(rtwdev, wl->scbd[id]);
+			dm->scbd_write_instant = 0;
+		} else if ((val & BTC_WSCB_ACTIVE ||
+			   val & BTC_WSCB_ON ||
+			   val & BTC_WSCB_WLRFK) ||
+			   scbd != wl->scbd[id]) {
+			/*
+			 * Just update wl->scbd[] and set wl->scbd_chg[],
+			 * moved "Write scoreboard I/O" to  _action_common()
+			 * _write_scbd will be executed if run_coex()
+			 */
+			wl->scbd[id] = scbd;
+			wl->scbd_chg[id] = 1;
+		}
 	}
 }
 
@@ -7522,34 +7601,27 @@ void rtw89_coex_rfk_chk_work(struct wiphy *wiphy, struct wiphy_work *work)
 		wl->wcnt[BTC_WCNT_RFK_TIMEOUT]++;
 		dm->error.map.wl_rfk_timeout = true;
 		wl->rfk_info.state = BTC_WRFK_STOP;
-		_write_scbd(rtwdev, BTC_WSCB_WLRFK, false);
+		_write_scbd(rtwdev, BTC_ALL_BT, BTC_WSCB_WLRFK, false);
 		_run_coex(rtwdev, BTC_RSN_RFK_CHK_WORK);
 	}
 }
 
-static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
+static void _update_bt_scbd(struct rtw89_dev *rtwdev, u8 bid)
 {
+	struct rtw89_btc_bt_link_info *bt_2g, *bt_56g;
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	const struct rtw89_btc_ver *ver = btc->ver;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
-	bool bt_link_change = false, lps_ctrl = false;
-	u32 val, any_bt_connect;
-	u8 mode;
-
-	if (rtwdev->chip->scbd)
-		return;
-
-	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s\n", __func__);
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_bt_info *bt;
+	u32 val, any_bt_connect, any_bt_6g_connect = 0;
+	u8 id, id_start, id_stop, mode;
+	bool bt_link_change = false;
+	bool lps_ctrl = false;
 
-	val = _read_scbd(rtwdev);
-	if (val == BTC_SCB_INV_VALUE) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): return by invalid scbd value\n",
-			    __func__);
+	if (!rtwdev->chip->scbd || bid > BTC_ALL_BT)
 		return;
-	}
 
 	if (ver->fwlrole == 0)
 		mode = wl->role_info.link_mode;
@@ -7564,66 +7636,112 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 	else
 		return;
 
-	if (!(val & BTC_BSCB_ON))
-		bt->enable.now = 0;
-	else
-		bt->enable.now = 1;
+	if (bid == BTC_ALL_BT) {
+		id_start = BTC_BT_1ST;
+		id_stop = BTC_BT_2ND;
+	} else {
+		id_start = bid;
+		id_stop = bid;
+	}
+
+	dm->lps_ctrl_change = false;
+	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s()\n", __func__);
 
-	if (bt->enable.now != bt->enable.last)
-		bt_link_change = true;
+	for (id = id_start; id <= id_stop; id++) {
+		bt = (id == BTC_BT_1ST) ? &cx->bt0 : &cx->bt1;
+		bt_2g = &bt->link_info;
+		bt_56g = &bt->link_info_56g;
 
-	/* reset bt info if bt re-enable */
-	if (bt->enable.now && !bt->enable.last) {
-		_reset_btc_var(rtwdev, BTC_RESET_BTINFO);
-		bt->bcnt[BTC_BCNT_REENABLE]++;
-		bt->enable.now = 1;
-	}
+		if (!(rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT) && id == BTC_BT_2ND)
+			break;
+
+		val = bt->scbd_c2h;
 
-	bt->enable.last = bt->enable.now;
-	bt->scbd = val;
-	bt->mbx_avl = !!(val & BTC_BSCB_ACT);
+		if (val == 0xffffffff) {
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s return by invalid scbd value\n",
+				    __func__);
+			return;
+		}
 
-	if (bt->whql_test != !!(val & BTC_BSCB_WHQL))
-		bt_link_change = true;
+		if (!(val & BTC_BSCB_ON))
+			bt->enable.now = 0;
+		else
+			bt->enable.now = 1;
 
-	bt->whql_test = !!(val & BTC_BSCB_WHQL);
-	bt->btg_type = val & BTC_BSCB_BT_S1 ? BTC_BT_BTG : BTC_BT_ALONE;
-	bt->link_info.a2dp_desc.exist = !!(val & BTC_BSCB_A2DP_ACT);
-	bt->link_info.pan_desc.exist = !!(val & BTC_BSCB_PAN_ACT);
-	bt->link_info.hfp_desc.exist = !!(val & BTC_BSCB_HFP_ACT);
+		if (bt->enable.now != bt->enable.last)
+			bt_link_change = true;
 
-	bt->lna_constrain = !!(val & BTC_BSCB_BT_LNAB0) +
-			    !!(val & BTC_BSCB_BT_LNAB1) * 2 + 4;
+		/* reset bt info if bt re-enable */
+		if (bt->enable.now && !bt->enable.last) {
+			if (id == BTC_BT_1ST)
+				_reset_btc_var(rtwdev, BTC_RESET_BTINFO);
+			else
+				_reset_btc_var(rtwdev, BTC_RESET_BTINFO2);
 
-	/* if rfk run 1->0 */
-	if (bt->rfk_info.map.run && !(val & BTC_BSCB_RFK_RUN))
-		bt_link_change = true;
+			bt->bcnt[BTC_BCNT_REENABLE]++;
+			bt->enable.now = 1;
+			bt->rf_band_map = BIT(RTW89_BAND_2G);
+			bt->link_weight[BTC_BT_B2G] = 5; /* no-profile */
+		}
+		bt->enable.last = bt->enable.now;
 
-	bt->rfk_info.map.run  = !!(val & BTC_BSCB_RFK_RUN);
-	bt->rfk_info.map.req = !!(val & BTC_BSCB_RFK_REQ);
-	bt->hi_lna_rx = !!(val & BTC_BSCB_BT_HILNA);
-	any_bt_connect = !!(val & BTC_BSCB_BT_CONNECT);
+		/* if BT will disconnect and adopt protect plan */
+		if ((val & BTC_BSCB_BT_PROTECT) &&
+		    !(bt->scbd & BTC_BSCB_BT_PROTECT))
+			bt->bcnt[BTC_BCNT_PROTECT]++;
 
-	/* if connect change */
-	if (bt->link_info.status.map.connect != any_bt_connect)
-		bt_link_change = true;
+		bt->mbx_avl = !!(val & BTC_BSCB_ACT);
+		if (bt->whql_test != !!(val & BTC_BSCB_WHQL))
+			bt_link_change = true;
 
-	/* if specific profile exist */
-	if (((bt->link_info.a2dp_desc.exist || bt->link_info.pan_desc.exist ||
-	      bt->link_info.hfp_desc.exist) && mode == BTC_WLINK_2G_STA) ||
-	    bt->whql_test)
-		lps_ctrl = true;
+		bt->whql_test = !!(val & BTC_BSCB_WHQL);
+		bt->btg_type = (val & BTC_BSCB_BT_S1 ? BTC_BT_BTG : BTC_BT_ALONE);
 
-	if (dm->lps_ctrl_scbd != lps_ctrl) {
-		dm->lps_ctrl_scbd = lps_ctrl;
-		bt_link_change = true;
-		dm->lps_ctrl_change = true;
-	} else {
-		dm->lps_ctrl_change = false;
-	}
+		bt_2g->a2dp_desc.exist = !!(val & BTC_BSCB_A2DP_ACT);
+		bt_2g->pan_desc.exist = !!(val & BTC_BSCB_PAN_ACT);
+		bt_2g->hfp_desc.exist = !!(val & BTC_BSCB_HFP_ACT);
 
-	bt->link_info.status.map.connect = any_bt_connect;
-	bt->run_patch_code = !!(val & BTC_BSCB_PATCH_CODE);
+		bt->lna_constrain = 4 + !!(val & BTC_BSCB_BT_LNAB0) +
+				    !!(val & BTC_BSCB_BT_LNAB1) * 2;
+
+		if (rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT) {
+			if (val & BTC_BSCB_BT_15DOT4)
+				bt->func_type |= (BTC_BTF_THREAD | BTC_BTF_ZB);
+			else
+				bt->func_type &= ~(BTC_BTF_THREAD | BTC_BTF_ZB);
+		}
+
+		bt->hi_lna_rx = !!(val & BTC_BSCB_BT_HILNA);
+		any_bt_connect = !!(val & BTC_BSCB_BT_CONNECT);
+
+		/* if connect change */
+		if (bt_2g->status.map.connect != any_bt_connect ||
+		    bt_56g->status.map.connect != any_bt_6g_connect) {
+			bt_link_change = true;
+			bt_2g->status.map.connect = any_bt_connect;
+			bt_56g->status.map.connect = any_bt_6g_connect;
+		}
+
+		/* if specific profile exist */
+		if (((bt->link_info.a2dp_desc.exist ||
+		      bt->link_info.pan_desc.exist ||
+		      bt->link_info.hfp_desc.exist) &&
+		     mode == BTC_WLINK_2G_STA) ||
+		    bt->whql_test)
+			lps_ctrl = true;
+
+		if (dm->lps_ctrl_scbd  != lps_ctrl) {
+			dm->lps_ctrl_scbd  = lps_ctrl;
+			bt_link_change = true;
+			dm->lps_ctrl_change = true;
+		} else {
+			dm->lps_ctrl_change = false;
+		}
+
+		bt->run_patch_code = !!(val & BTC_BSCB_PATCH_CODE);
+		bt->scbd = val;
+	}
 
 	if (bt_link_change) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -7651,26 +7769,6 @@ static void _update_bt_txpwr_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	memcpy(&b->bt_txpwr_desc, &buf[2], sizeof(b->bt_txpwr_desc));
 }
 
-static bool _chk_wl_rfk_request(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_cx *cx = &btc->cx;
-	struct rtw89_btc_bt_info *bt = &cx->bt0;
-
-	_update_bt_scbd(rtwdev, true);
-
-	cx->wl.wcnt[BTC_WCNT_RFK_REQ]++;
-
-	if ((bt->rfk_info.map.run || bt->rfk_info.map.req) &&
-	    !bt->rfk_info.map.timeout) {
-		cx->wl.wcnt[BTC_WCNT_RFK_REJECT]++;
-	} else {
-		cx->wl.wcnt[BTC_WCNT_RFK_GO]++;
-		return true;
-	}
-	return false;
-}
-
 static void _set_bind_info(struct rtw89_btc *btc, u8 type)
 {
 	struct rtw89_btc_cx *cx = &btc->cx;
@@ -8181,7 +8279,7 @@ void rtw89_btc_ntfy_poweroff(struct rtw89_dev *rtwdev)
 	btc->cx.wl.status.map.busy = 0;
 	wl->status.map.lps = BTC_LPS_OFF;
 
-	_write_scbd(rtwdev, BTC_WSCB_ALL, false);
+	_write_scbd(rtwdev, BTC_ALL_BT, BTC_WSCB_ALL, false);
 	_run_coex(rtwdev, BTC_RSN_NTFY_POWEROFF);
 
 	rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_ALL, 0);
@@ -8266,24 +8364,22 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 		return;
 	}
 
+	btc->cx.bt0.enable.now = 1;
+	btc->cx.bt0.run_patch_code = 1;
 	if (rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT) {
 		btc->cx.bt1.enable.now = 1;
 		btc->cx.bt1.run_patch_code = 1;
 	}
 
-	if (rtwdev->chip->para_ver & BTC_FEAT_H2C_MACRO) {
-		btc->cx.bt0.enable.now = 1;
-		btc->cx.bt0.run_patch_code = 1;
+	if (rtwdev->chip->para_ver & BTC_FEAT_H2C_MACRO)
 		btc->io_oflld_type = BTC_IO_OFLD_BTC_H2C;
-	} else {
+	else
 		btc->io_oflld_type = BTC_IO_OFLD_NO_SUPPORT;
-		_update_bt_scbd(rtwdev, true);
-	}
 
 	chip->ops->btc_set_rfe(rtwdev);
 	chip->ops->btc_init_cfg(rtwdev);
 
-	_write_scbd(rtwdev,
+	_write_scbd(rtwdev, BTC_ALL_BT,
 		    BTC_WSCB_ACTIVE | BTC_WSCB_ON | BTC_WSCB_BTLOG, true);
 
 	if (rtw89_mac_get_ctrl_path(rtwdev)) {
@@ -8842,16 +8938,16 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 	if (rf_state == BTC_RFCTRL_WL_ON) {
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_MREG, true);
 		val = BTC_WSCB_ACTIVE | BTC_WSCB_ON | BTC_WSCB_BTLOG;
-		_write_scbd(rtwdev, val, true);
+		_write_scbd(rtwdev, BTC_ALL_BT, val, true);
 		chip->ops->btc_init_cfg(rtwdev);
 	} else {
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_ALL, false);
 		if (rf_state == BTC_RFCTRL_FW_CTRL)
-			_write_scbd(rtwdev, BTC_WSCB_ACTIVE, false);
+			_write_scbd(rtwdev, BTC_ALL_BT, BTC_WSCB_ACTIVE, false);
 		else if (rf_state == BTC_RFCTRL_WL_OFF)
-			_write_scbd(rtwdev, BTC_WSCB_ALL, false);
+			_write_scbd(rtwdev, BTC_ALL_BT, BTC_WSCB_ALL, false);
 		else
-			_write_scbd(rtwdev, BTC_WSCB_ACTIVE, false);
+			_write_scbd(rtwdev, BTC_ALL_BT, BTC_WSCB_ACTIVE, false);
 	}
 
 	btc->dm.cnt_dm[BTC_DCNT_BTCNT_HANG] = 0;
@@ -8883,27 +8979,26 @@ static bool _ntfy_wl_rfk(struct rtw89_dev *rtwdev, u8 phy_path,
 
 	switch (state) {
 	case BTC_WRFK_START:
-		result = _chk_wl_rfk_request(rtwdev);
-		wl->rfk_info.state = result ? BTC_WRFK_START : BTC_WRFK_STOP;
-
-		_write_scbd(rtwdev, BTC_WSCB_WLRFK, result);
+		result = BTC_WRFK_ALLOW;
+		wl->rfk_info.state = BTC_WRFK_START;
 
+		btc->cx.wl.wcnt[BTC_WCNT_RFK_REQ]++;
+		btc->cx.wl.wcnt[BTC_WCNT_RFK_GO]++;
 		btc->dm.cnt_notify[BTC_NCNT_WL_RFK]++;
+
+		_write_scbd(rtwdev, BTC_ALL_BT, BTC_WSCB_WLRFK, true);
 		break;
 	case BTC_WRFK_ONESHOT_START:
 	case BTC_WRFK_ONESHOT_STOP:
-		if (wl->rfk_info.state == BTC_WRFK_STOP) {
-			result = BTC_WRFK_REJECT;
-		} else {
-			result = BTC_WRFK_ALLOW;
-			wl->rfk_info.state = state;
-		}
+		wl->rfk_info.state = state;
+		if (type != BTC_WRFKT_RXDCK)
+			return BTC_WRFK_ALLOW;
 		break;
 	case BTC_WRFK_STOP:
 		result = BTC_WRFK_ALLOW;
 		wl->rfk_info.state = BTC_WRFK_STOP;
 
-		_write_scbd(rtwdev, BTC_WSCB_WLRFK, false);
+		_write_scbd(rtwdev, BTC_ALL_BT, BTC_WSCB_WLRFK, false);
 		wiphy_delayed_work_cancel(rtwdev->hw->wiphy, &rtwdev->coex_rfk_chk_work);
 		break;
 	default:
@@ -8927,7 +9022,7 @@ static bool _ntfy_wl_rfk(struct rtw89_dev *rtwdev, u8 phy_path,
 		    "[BTC], %s()_finish: rfk_cnt=%d, result=%d\n",
 		    __func__, btc->dm.cnt_notify[BTC_NCNT_WL_RFK], result);
 
-	return result == BTC_WRFK_ALLOW;
+	return result;
 }
 
 void rtw89_btc_ntfy_wl_rfk(struct rtw89_dev *rtwdev, u8 phy_map,
@@ -9160,7 +9255,7 @@ void rtw89_btc_ntfy_wl_sta(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): busy=%d\n",
 		    __func__, !!wl->status.map.busy);
 
-	_write_scbd(rtwdev, BTC_WSCB_WLBUSY, (!!wl->status.map.busy));
+	_write_scbd(rtwdev, BTC_ALL_BT, BTC_WSCB_WLBUSY, (!!wl->status.map.busy));
 
 	if (data.is_traffic_change)
 		_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
@@ -9251,6 +9346,7 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	struct rtw89_btc_bt_info *bt = &rtwdev->btc.cx.bt0;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	u8 *buf = &skb->data[RTW89_C2H_HEADER_LEN];
+	u8 bid = BTC_BT_1ST;
 
 	len -= RTW89_C2H_HEADER_LEN;
 
@@ -9261,6 +9357,12 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	if (class != BTFC_FW_EVENT)
 		return;
 
+	if (func & BT_C2H_FUNC_BT2ND) {
+		bid = BTC_BT_2ND;
+		func &= ~BT_C2H_FUNC_BT2ND;
+		bt = &btc->cx.bt1;
+	}
+
 	func = rtw89_btc_c2h_get_index_by_ver(rtwdev, func);
 	pfwinfo->cnt_c2h++;
 
@@ -9280,10 +9382,15 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		_update_bt_info(rtwdev, buf, len);
 		break;
 	case BTF_EVNT_BT_SCBD:
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], handle C2H BT SCBD with data %8ph\n", buf);
 		bt->bcnt[BTC_BCNT_SCBDUPDATE]++;
-		_update_bt_scbd(rtwdev, false);
+		bt->scbd_c2h = ((buf[3] << 24) | (buf[2] << 16) |
+				(buf[1] << 8) | (buf[0]));
+		bt->scbd_rb = bt->scbd_c2h;
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], handle C2H BT%d SCBD with data 0x%08x\n",
+			    bid, bt->scbd_c2h);
+		_update_bt_scbd(rtwdev, bid);
+		_run_coex(rtwdev, BTC_RSN_UPDATE_BT_SCBD);
 		break;
 	case BTF_EVNT_BT_PSD:
 		break;
@@ -9300,7 +9407,7 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		btc->dm.cnt_dm[BTC_DCNT_CX_RUNINFO]++;
 		break;
 	case BTF_EVNT_BT_QUERY_TXPWR:
-		bt->bcnt[BTC_BCNT_BTTXPWR_UPDATE]++;
+		bt->bcnt[BTC_BCNT_TXPWR_UPDATE]++;
 		_update_bt_txpwr_info(rtwdev, buf, len);
 	}
 }
@@ -9680,7 +9787,7 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		       bt->bcnt[BTC_BCNT_HIPRI_TX],
 		       bt->bcnt[BTC_BCNT_LOPRI_RX],
 		       bt->bcnt[BTC_BCNT_LOPRI_TX],
-		       bt->bcnt[BTC_BCNT_POLUT]);
+		       bt->bcnt[BTC_BCNT_POLLUTED]);
 
 	if (!bt->scan_info_update) {
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_SCAN_INFO, true);
@@ -9716,7 +9823,7 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	else
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_TX_PWR_LVL, false);
 
-	if (bt->bcnt[BTC_BCNT_BTTXPWR_UPDATE]) {
+	if (bt->bcnt[BTC_BCNT_TXPWR_UPDATE]) {
 		p += scnprintf(p, end - p,
 			       " %-15s : br_index:0x%x, le_index:0x%x",
 			       "[bt_txpwr_lvl]",
@@ -10127,7 +10234,7 @@ static int _show_dm_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	p += scnprintf(p, end - p,
 		       " %-15s : wl_only:%d, bt_only:%d, igno_bt:%d, free_run:%d, wl_ps_ctrl:%d, wl_mimo_ps:%d, ",
 		       "[dm_flag]", dm->wl_only, dm->bt_only, igno_bt,
-		       dm->freerun, btc->lps, dm->wl_mimo_ps);
+		       dm->freerun, btc->btc_ctrl_lps, dm->wl_mimo_ps);
 
 	p += scnprintf(p, end - p, "leak_ap:%d, fw_offload:%s%s\n",
 		       dm->leak_ap,
@@ -11353,10 +11460,11 @@ static int _show_mreg_v1(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
-	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_mreg_val_v1 *pmreg = NULL;
+	struct rtw89_btc_bt_info *bt0 = &btc->cx.bt0;
+	struct rtw89_btc_bt_info *bt1 = &btc->cx.bt1;
+	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_mac_ax_coex_gnt gnt_cfg = {};
 	struct rtw89_mac_ax_gnt gnt;
 	char *p = buf, *end = buf + bufsz;
@@ -11369,11 +11477,20 @@ static int _show_mreg_v1(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	p += scnprintf(p, end - p, "========== [HW Status] ==========\n");
 
 	p += scnprintf(p, end - p,
-		       " %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)\n",
-		       "[scoreboard]", wl->scbd,
+		       " %-15s : WL->BT0:0x%08x(cnt:%d), BT0->WL:0x%08x(total:%d, bt_update:%d)\n",
+		       "[scoreboard]", wl->scbd[BTC_BT_1ST],
 		       wl->wcnt[BTC_WCNT_SCBDUPDATE],
-		       bt->scbd, bt->bcnt[BTC_BCNT_SCBDREAD],
-		       bt->bcnt[BTC_BCNT_SCBDUPDATE]);
+		       bt0->scbd, bt0->bcnt[BTC_BCNT_SCBDREAD],
+		       bt0->bcnt[BTC_BCNT_SCBDUPDATE]);
+
+	if (rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT) {
+		p += scnprintf(p, end - p,
+			       " %-15s : WL->BT1:0x%08x(cnt:%d), BT1->WL:0x%08x(total:%d, bt_update:%d)\n",
+			       "[scoreboard]", wl->scbd[BTC_BT_2ND],
+			       wl->wcnt[BTC_WCNT_SCBDUPDATE2],
+			       bt1->scbd, bt1->bcnt[BTC_BCNT_SCBDREAD],
+			       bt1->bcnt[BTC_BCNT_SCBDUPDATE]);
+	}
 
 	btc->dm.pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
 	_get_gnt(rtwdev, &gnt_cfg);
@@ -11437,10 +11554,11 @@ static int _show_mreg_v2(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
-	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_mreg_val_v2 *pmreg = NULL;
+	struct rtw89_btc_bt_info *bt0 = &btc->cx.bt0;
+	struct rtw89_btc_bt_info *bt1 = &btc->cx.bt1;
+	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_mac_ax_coex_gnt gnt_cfg = {};
 	struct rtw89_mac_ax_gnt gnt;
 	char *p = buf, *end = buf + bufsz;
@@ -11453,11 +11571,20 @@ static int _show_mreg_v2(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	p += scnprintf(p, end - p, "========== [HW Status] ==========\n");
 
 	p += scnprintf(p, end - p,
-		       " %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)\n",
-		       "[scoreboard]", wl->scbd,
+		       " %-15s : WL->BT0:0x%08x(cnt:%d), BT0->WL:0x%08x(total:%d, bt_update:%d)\n",
+		       "[scoreboard]", wl->scbd[BTC_BT_1ST],
 		       wl->wcnt[BTC_WCNT_SCBDUPDATE],
-		       bt->scbd, bt->bcnt[BTC_BCNT_SCBDREAD],
-		       bt->bcnt[BTC_BCNT_SCBDUPDATE]);
+		       bt0->scbd, bt0->bcnt[BTC_BCNT_SCBDREAD],
+		       bt0->bcnt[BTC_BCNT_SCBDUPDATE]);
+
+	if (rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT) {
+		p += scnprintf(p, end - p,
+			       " %-15s : WL->BT1:0x%08x(cnt:%d), BT1->WL:0x%08x(total:%d, bt_update:%d)\n",
+			       "[scoreboard]", wl->scbd[BTC_BT_2ND],
+			       wl->wcnt[BTC_WCNT_SCBDUPDATE2],
+			       bt1->scbd, bt1->bcnt[BTC_BCNT_SCBDREAD],
+			       bt1->bcnt[BTC_BCNT_SCBDUPDATE]);
+	}
 
 	btc->dm.pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
 	_get_gnt(rtwdev, &gnt_cfg);
@@ -11524,8 +11651,9 @@ static int _show_mreg_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_btc_fbtc_mreg_val_v7 *pmreg = NULL;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_bt_info *bt0 = &cx->bt0;
+	struct rtw89_btc_bt_info *bt1 = &cx->bt1;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
-	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	struct rtw89_mac_ax_gnt *gnt = NULL;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	char *p = buf, *end = buf + bufsz;
@@ -11538,11 +11666,20 @@ static int _show_mreg_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	p += scnprintf(p, end - p, "\n\r========== [HW Status] ==========");
 
 	p += scnprintf(p, end - p,
-		       "\n\r %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)",
-		       "[scoreboard]", wl->scbd,
+		       " %-15s : WL->BT0:0x%08x(cnt:%d), BT0->WL:0x%08x(total:%d, bt_update:%d)\n",
+		       "[scoreboard]", wl->scbd[BTC_BT_1ST],
 		       wl->wcnt[BTC_WCNT_SCBDUPDATE],
-		       bt->scbd, bt->bcnt[BTC_BCNT_SCBDREAD],
-		       bt->bcnt[BTC_BCNT_SCBDUPDATE]);
+		       bt0->scbd, bt0->bcnt[BTC_BCNT_SCBDREAD],
+		       bt0->bcnt[BTC_BCNT_SCBDUPDATE]);
+
+	if (rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT) {
+		p += scnprintf(p, end - p,
+			       " %-15s : WL->BT1:0x%08x(cnt:%d), BT1->WL:0x%08x(total:%d, bt_update:%d)\n",
+			       "[scoreboard]", wl->scbd[BTC_BT_2ND],
+			       wl->wcnt[BTC_WCNT_SCBDUPDATE2],
+			       bt1->scbd, bt1->bcnt[BTC_BCNT_SCBDREAD],
+			       bt1->bcnt[BTC_BCNT_SCBDUPDATE]);
+	}
 
 	/* To avoid I/O if WL LPS or power-off  */
 	dm->pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index fb151f68eb64..74027ca4eccc 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -391,4 +391,13 @@ void _slot_set_tbl(struct rtw89_btc *btc, u8 sid, u32 tbl)
 		btc->dm.slot.v7[sid].cxtbl = cpu_to_le32(tbl);
 }
 
+static inline
+void btc_dw2b(u8 *buf, size_t idx, u32 val)
+{
+	buf[idx] = u32_get_bits(val, MASKBYTE0);
+	buf[idx + 1] = u32_get_bits(val, MASKBYTE1);
+	buf[idx + 2] = u32_get_bits(val, MASKBYTE2);
+	buf[idx + 3] = u32_get_bits(val, MASKBYTE3);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 85aeb9e90812..b3376fadf593 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5417,7 +5417,7 @@ static void rtw89_track_ps_work(struct wiphy *wiphy, struct wiphy_work *work)
 	if (rtwdev->scanning)
 		return;
 
-	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
+	if (rtwdev->lps_enabled && !rtwdev->btc.btc_ctrl_lps)
 		rtw89_enter_lps_track(rtwdev, RTW89_TFC_INTERVAL_100MS);
 }
 
@@ -5465,7 +5465,7 @@ static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 	rtw89_core_rfkill_poll(rtwdev, false);
 	rtw89_core_mlo_track(rtwdev);
 
-	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
+	if (rtwdev->lps_enabled && !rtwdev->btc.btc_ctrl_lps)
 		rtw89_enter_lps_track(rtwdev, RTW89_TFC_INTERVAL_2SEC);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index eb814425f536..8646a13bfd79 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1415,6 +1415,7 @@ enum rtw89_btc_wl_state_cnt {
 	BTC_WCNT_RX_ERR_LAST,
 	BTC_WCNT_RX_ERR_LAST2S,
 	BTC_WCNT_RX_LAST,
+	BTC_WCNT_SCBDUPDATE2,
 	BTC_WCNT_NUM
 };
 
@@ -1431,17 +1432,25 @@ enum rtw89_btc_bt_state_cnt {
 	BTC_BCNT_ROLESW,
 	BTC_BCNT_AFH,
 	BTC_BCNT_INFOUPDATE,
+	BTC_BCNT_LEAUDIO_INFOUPDATE,
 	BTC_BCNT_INFOSAME,
+	BTC_BCNT_LEAUDIO_INFOSAME,
 	BTC_BCNT_SCBDUPDATE,
 	BTC_BCNT_HIPRI_TX,
 	BTC_BCNT_HIPRI_RX,
 	BTC_BCNT_LOPRI_TX,
 	BTC_BCNT_LOPRI_RX,
-	BTC_BCNT_POLUT,
 	BTC_BCNT_POLUT_NOW,
 	BTC_BCNT_POLUT_DIFF,
 	BTC_BCNT_RATECHG,
-	BTC_BCNT_BTTXPWR_UPDATE,
+	BTC_BCNT_AFH_CONFLICT,
+	BTC_BCNT_AFH_LE_CONFLICT,
+	BTC_BCNT_AFH_UPDATE,
+	BTC_BCNT_AFH_LE_UPDATE,
+	BTC_BCNT_AFH_CHN,
+	BTC_BCNT_AFH_LE_CHN,
+	BTC_BCNT_TXPWR_UPDATE,
+	BTC_BCNT_PROTECT,
 	BTC_BCNT_NUM,
 };
 
@@ -2188,12 +2197,13 @@ struct rtw89_btc_wl_info {
 	bool pta_reg_mac_chg;
 	bool bg_mode;
 	bool he_mode;
-	bool scbd_change;
+	bool scbd_chg[BTC_ALL_BT];
 	bool fw_ver_mismatch;
 	bool client_cnt_inc_2g;
 	bool link_mode_chg;
 	bool dbcc_chg;
-	u32 scbd;
+	u32 scbd[BTC_ALL_BT];
+	u32 scbd_rb[BTC_ALL_BT];
 	u32 wcnt[BTC_WCNT_NUM];
 };
 
@@ -2323,6 +2333,15 @@ enum rtw89_btc_ble_scan_type {
 	CXSCAN_MAX
 };
 
+enum rtw89_btc_bt_func_type {
+	BTC_BTF_NONE = 0,
+	BTC_BTF_BT = BIT(0),
+	BTC_BTF_ZB = BIT(1),
+	BTC_BTF_THREAD = BIT(2),
+	BTC_BTF_24GPRO = BIT(3), /* 2.4GHz Proprietary */
+	BTC_BTF_ULL = BIT(4),
+};
+
 #define RTW89_BTC_BTC_SCAN_V1_FLAG_ENABLE BIT(0)
 #define RTW89_BTC_BTC_SCAN_V1_FLAG_INTERLACE BIT(1)
 
@@ -2394,6 +2413,8 @@ struct rtw89_btc_bt_info {
 	u8 rsvd: 6;
 
 	u32 scbd;
+	u32 scbd_rb;
+	u32 scbd_c2h;
 	u32 feature;
 
 	u32 mbx_avl: 1;
@@ -3338,6 +3359,8 @@ struct rtw89_btc_dm {
 	u8 lps_ctrl_scbd: 1;
 	u8 lps_ctrl_scbd_last: 1;
 	u8 lps_ctrl_change: 1;
+	u8 scbd_write_instant;
+	bool scbd_b2w_update;
 };
 
 struct rtw89_btc_ctrl {
@@ -3585,7 +3608,7 @@ struct rtw89_btc {
 	u32 hubmsg_cnt;
 	bool bt_req_en;
 	bool update_policy_force;
-	bool lps;
+	bool btc_ctrl_lps;
 	bool manual_ctrl;
 	bool cli_h2c_cmd;
 };
-- 
2.25.1


