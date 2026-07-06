Return-Path: <linux-wireless+bounces-38650-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id naQEB14ZS2qXLwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38650-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 04:56:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 948E970C39C
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 04:56:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="dSpqzP7/";
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38650-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38650-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1D243008E14
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 02:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA91384CFD;
	Mon,  6 Jul 2026 02:56:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE5351C22
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 02:56:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306587; cv=none; b=ipcWei+Oxu38tdFhG+amlQNk4/Zb9S7uwwC5GmuGAS0zlUyJqraDxpiBazrIzn/WZA6Qc/n9uhJY3v8srr/3kwOJYuAagC21RyToVp4WqY7Z/ovVsUfvEEwT/FfXjeI6IY7bcnr30i1bxm4h9//p7MXk4AOcZzx+jOTooe0jayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306587; c=relaxed/simple;
	bh=1Gwycnxb6eFhbD1JSkox770AQUxabuSBclkaywwNodo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5LQBUt89TXbUwnVEjzPwT7AvsFTHPv+Gj/G1xj3rwiC/2X11Us+fKn/rlMkMTzxd/wl31nxYplbbBADbBydWydJvhfmHWzVYVyW69ckqmtYAZifZ4s0NsYRdJcZW20h7ibWRQHIK+cLxYhGmolfHBlTC7YbXTjy+qWPHvzfyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dSpqzP7/; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6662uMctD120644, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783306583; bh=ZNbWMSjBtemHqhPrCl28M2fmr05aN3tFF69y1br5y5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dSpqzP7/pjBrTOHghQX/5zDmErpNfXE7lh8XwRe+953Fb/sSxKNRo511Gt6plH7Ti
	 FugDL2LSJfIH5AXzxsUgMa/ADeDxNQYFQ93s21G5kQ93Awl9FcjTsMtNG2Cu54bwqv
	 pyUSLWkOcm0s5FtPFJgdgtixWbuI2b9QmFl7b3uhyzBiV48u0QkVnVFTMgMivhY84S
	 Tylp8SG6sJN8uOaWpjdqYnPC5QfAjMABHdyoDW8cAVvyQmhadtFp2rH+4OS4stuWuv
	 6nwDFjfhfJZlA2KVo5rSzoIKWdYKiCj82Z6aPRxB066v8bbzhYqw0vmVQLw1ActNHl
	 5lvjAqgV+7USg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6662uMctD120644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jul 2026 10:56:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Jul 2026 10:56:21 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Jul 2026 10:56:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next v2 7/9] wifi: rtw89: coex: Add TDMA binding for dual MAC
Date: Mon, 6 Jul 2026 10:54:43 +0800
Message-ID: <20260706025445.18428-8-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38650-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 948E970C39C

From: Ching-Te Ku <ku920601@realtek.com>

Because the two MAC should have their own individual using, they will
need different TDMA mechanism. This patch will bind TDMA with MAC index,
and also the corresponding antenna, hardware grant signal setting.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 381 +++++++++-------------
 drivers/net/wireless/realtek/rtw89/core.h |  11 +-
 2 files changed, 158 insertions(+), 234 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 15f929d60f94..efa177f8b231 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -494,7 +494,7 @@ enum btc_ant_phase {
 	BTC_ANT_FREERUN,
 	BTC_ANT_WRFK,
 	BTC_ANT_WRFK2,
-	BTC_ANT_BRFK,
+	BTC_ANT_PTA, /* for Multi-PTA, each hw-band has its own PTA */
 	BTC_ANT_MAX
 };
 
@@ -3894,6 +3894,41 @@ static void _set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 	_fw_set_policy(rtwdev, policy_type, action);
 }
 
+static void _set_tdma_bind(struct rtw89_dev *rtwdev, bool tdma_on)
+{
+	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
+	struct rtw89_btc_bind_info *bind;
+	u8 null_role = RTW89_WIFI_ROLE_STATION;
+
+	if (dm->tdd_en)
+		bind = &dm->tdd_bind; /* tdd = 1 && fdd = 0 or 1 */
+	else
+		bind = &dm->fdd_bind; /* tdd = 0 && fdd = 1 */
+
+	/* notify BT TDMA on/off by scoreboard for ACL/Scan schedule */
+	_write_scbd(rtwdev, BTC_WSCB_TDMA, tdma_on);
+
+	/*
+	 * set hwb/bt bind to TDMA policy parameter
+	 * FW-BTC will setup related hwbx vs. BTx coex tables by slot toggle
+	 * ex: HWb0 + BT0 + BT1, HWB0-BT0/HWB0-BT1 coex by WL/BT slot toggle
+	 */
+	dm->tdma.bind = ((bind->bt_sel & 0xf) << 4) + (bind->wl_hwb_sel & 0x3);
+	if (dm->tdd_en)
+		dm->tdma.bind |= BIT(2);
+	if (dm->fdd_en)
+		dm->tdma.bind |= BIT(3);
+	if (rtwdev->btc.ver->fcxtdma != 8)
+		dm->tdma.bind |= 0;
+
+	/* set Null-tx role for 2 HW-BAND TDMA (MLMR) */
+	if (!dm->eslot_ctrl.en && dm->tdma.rxflctrl &&
+	    (bind->wl_hwb_sel == (BIT(RTW89_PHY_1) | BIT(RTW89_PHY_0)))) {
+		null_role = (null_role << 4) + null_role;
+		_tdma_set_flctrl_role(&rtwdev->btc, null_role);
+	}
+}
+
 #define BTC_B1_MAX 250 /* unit ms */
 void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 {
@@ -3903,6 +3938,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 	struct rtw89_btc_fbtc_slot *s = dm->slot.v1;
 	u8 type;
 	u32 tbl_w1, tbl_b1, tbl_b4;
+	bool tdma_on = false;
 
 	if (btc->ant_type == BTC_ANT_SHARED) {
 		if (btc->cx.wl.status.map._4way)
@@ -3928,7 +3964,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 		btc->update_policy_force = true;
 		break;
 	case BTC_CXP_OFF: /* TDMA off */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, false);
+		tdma_on = false;
 		*t = t_def[CXTD_OFF];
 		s[CXST_OFF] = s_def[CXST_OFF];
 
@@ -3963,7 +3999,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_OFFB: /* TDMA off + beacon protect */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, false);
+		tdma_on = false;
 		*t = t_def[CXTD_OFF_B2];
 		s[CXST_OFF] = s_def[CXST_OFF];
 		switch (policy_type) {
@@ -3974,7 +4010,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 		break;
 	case BTC_CXP_OFFE: /* TDMA off + beacon protect + Ext_control */
 		btc->bt_req_en = true;
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_OFF_EXT];
 		switch (policy_type) {
 		case BTC_CXP_OFFE_DEF:
@@ -3992,7 +4028,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_FIX: /* TDMA Fix-Slot */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_FIX];
 		switch (policy_type) {
 		case BTC_CXP_FIX_TD3030:
@@ -4048,7 +4084,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_PFIX: /* PS-TDMA Fix-Slot */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_PFIX];
 		if (btc->cx.wl.role_info.role_map.role.ap)
 			_tdma_set_flctrl(btc, CXFLC_QOSNULL);
@@ -4081,7 +4117,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_AUTO: /* TDMA Auto-Slot */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_AUTO];
 		switch (policy_type) {
 		case BTC_CXP_AUTO_TD50B1:
@@ -4105,7 +4141,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_PAUTO: /* PS-TDMA Auto-Slot */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_PAUTO];
 		switch (policy_type) {
 		case BTC_CXP_PAUTO_TD50B1:
@@ -4129,7 +4165,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_AUTO2: /* TDMA Auto-Slot2 */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_AUTO2];
 		switch (policy_type) {
 		case BTC_CXP_AUTO2_TD3050:
@@ -4166,7 +4202,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_PAUTO2: /* PS-TDMA Auto-Slot2 */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_PAUTO2];
 		switch (policy_type) {
 		case BTC_CXP_PAUTO2_TD3050:
@@ -4203,6 +4239,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	}
+	_set_tdma_bind(rtwdev, tdma_on);
 }
 EXPORT_SYMBOL(rtw89_btc_set_policy);
 
@@ -4211,14 +4248,14 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_fbtc_tdma *t = &dm->tdma;
-	struct rtw89_btc_wl_role_info_v1 *wl_rinfo = &btc->cx.wl.role_info_v1;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt0.link_info.a2dp_desc;
 	struct rtw89_btc_bt_hid_desc *hid = &btc->cx.bt0.link_info.hid_desc;
 	struct rtw89_btc_bt_hfp_desc *hfp = &btc->cx.bt0.link_info.hfp_desc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	u8 type, null_role;
 	u32 tbl_w1, tbl_b1, tbl_b4;
-	u16 dur_2;
+	bool tdma_on = false;
+	u16 dur_1 = 0, dur_2;
 
 	if (wl->status.map.lps) {
 		_slot_set_le(btc, CXST_E2G, s_def[CXST_E2G].dur,
@@ -4272,7 +4309,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		_slot_set_tbl(btc, CXST_OFF, cxtbl[2]);
 		break;
 	case BTC_CXP_OFF: /* TDMA off */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, false);
+		tdma_on = false;
 		*t = t_def[CXTD_OFF];
 		_slot_set_le(btc, CXST_OFF, s_def[CXST_OFF].dur,
 			     s_def[CXST_OFF].cxtbl, s_def[CXST_OFF].cxtype);
@@ -4324,7 +4361,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_OFFB: /* TDMA off + beacon protect */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, false);
+		tdma_on = false;
 		*t = t_def[CXTD_OFF_B2];
 		_slot_set_le(btc, CXST_OFF, s_def[CXST_OFF].dur,
 			     s_def[CXST_OFF].cxtbl, s_def[CXST_OFF].cxtype);
@@ -4338,24 +4375,35 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_OFFE: /* TDMA off + beacon protect + Ext_control */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_OFF_EXT];
 
 		/* To avoid wl-s0 tx break by hid/hfp tx */
 		if (hid->exist || hfp->exist)
 			tbl_w1 = cxtbl[16];
 
+		if (dm->eslot_ctrl.en) {
+			null_role = u8_encode_bits(dm->eslot_ctrl.nulltx_role1, 0x0f) |
+				    u8_encode_bits(dm->eslot_ctrl.nulltx_role2, 0xf0);
+			_tdma_set_flctrl_role(btc, null_role);
+			_tdma_set_rxflctrl(btc, 1);
+			_tdma_set_txflctrl(btc, 1);
+			/* Set Null-Tx time-tick by E2G duration */
+			dm->eslot_ctrl.nulltx_pre_time = 5; /* TODO: BIS COEX */
+			dur_1 = dm->eslot_ctrl.nulltx_pre_time;
+		}
+
 		dur_2 = dm->e2g_slot_limit;
 
 		switch (policy_type) {
 		case BTC_CXP_OFFE_2GBWISOB: /* for normal-case */
-			_slot_set(btc, CXST_E2G, 5, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_E2G, dur_1, tbl_w1, SLOT_ISO);
 			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			_slot_set_dur(btc, CXST_EBT, dur_2);
 			break;
 		case BTC_CXP_OFFE_2GISOB: /* for bt no-link */
-			_slot_set(btc, CXST_E2G, 5, cxtbl[1], SLOT_ISO);
+			_slot_set(btc, CXST_E2G, dur_1, cxtbl[1], SLOT_ISO);
 			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			_slot_set_dur(btc, CXST_EBT, dur_2);
@@ -4383,16 +4431,16 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 			break;
 		case BTC_CXP_OFFE_2GBWMIXB:
 			if (a2dp->exist)
-				_slot_set(btc, CXST_E2G, 5, cxtbl[2], SLOT_MIX);
+				_slot_set(btc, CXST_E2G, dur_1, cxtbl[2], SLOT_MIX);
 			else
-				_slot_set(btc, CXST_E2G, 5, tbl_w1, SLOT_MIX);
+				_slot_set(btc, CXST_E2G, dur_1, tbl_w1, SLOT_MIX);
 			_slot_set_le(btc, CXST_EBT, cpu_to_le16(40),
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			_slot_set_dur(btc, CXST_EBT, dur_2);
 			break;
 		case BTC_CXP_OFFE_WL: /* for 4-way */
-			_slot_set(btc, CXST_E2G, 5, cxtbl[1], SLOT_MIX);
-			_slot_set(btc, CXST_EBT, 5, cxtbl[1], SLOT_MIX);
+			_slot_set(btc, CXST_E2G, dur_1, cxtbl[1], SLOT_MIX);
+			_slot_set(btc, CXST_EBT, dur_1, cxtbl[1], SLOT_MIX);
 			break;
 		default:
 			break;
@@ -4403,7 +4451,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 			     s_def[CXST_OFF].cxtbl, s_def[CXST_OFF].cxtype);
 		break;
 	case BTC_CXP_FIX: /* TDMA Fix-Slot */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_FIX];
 
 		switch (policy_type) {
@@ -4462,7 +4510,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_PFIX: /* PS-TDMA Fix-Slot */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_PFIX];
 
 		switch (policy_type) {
@@ -4501,7 +4549,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_AUTO: /* TDMA Auto-Slot */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_AUTO];
 
 		switch (policy_type) {
@@ -4528,7 +4576,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_PAUTO: /* PS-TDMA Auto-Slot */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_PAUTO];
 
 		switch (policy_type) {
@@ -4555,7 +4603,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_AUTO2: /* TDMA Auto-Slot2 */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_AUTO2];
 
 		switch (policy_type) {
@@ -4597,7 +4645,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		}
 		break;
 	case BTC_CXP_PAUTO2: /* PS-TDMA Auto-Slot2 */
-		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		tdma_on = true;
 		*t = t_def[CXTD_PAUTO2];
 
 		switch (policy_type) {
@@ -4640,20 +4688,22 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		break;
 	}
 
-	if (wl_rinfo->link_mode == BTC_WLINK_2G_SCC && dm->tdma.rxflctrl) {
-		null_role = FIELD_PREP(0x0f, dm->wl_scc.null_role1) |
-			    FIELD_PREP(0xf0, dm->wl_scc.null_role2);
-		_tdma_set_flctrl_role(btc, null_role);
-	}
-
 	/* enter leak_slot after each null-1 */
 	if (dm->leak_ap && dm->tdma.leak_n > 1)
 		_tdma_set_lek(btc, 1);
 
-	if (dm->tdma_instant_excute || dm->lps_ctrl_change) {
+	if (dm->tdma_instant_excute ||
+	    dm->error.map.tdma_no_sync ||
+	    dm->error.map.slot_no_sync ||
+	    dm->lps_ctrl_change) {
 		btc->dm.tdma.option_ctrl |= BIT(0);
 		btc->update_policy_force = true;
 	}
+
+	if (btc->cli_h2c_cmd)
+		btc->update_policy_force = true;
+
+	_set_tdma_bind(rtwdev, tdma_on);
 }
 EXPORT_SYMBOL(rtw89_btc_set_policy_v1);
 
@@ -4697,20 +4747,29 @@ static void _set_ant_v0(struct rtw89_dev *rtwdev, bool force_exec,
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
-	u8 gnt_wl_ctrl, gnt_bt_ctrl, plt_ctrl, i, b2g = 0;
-	bool dbcc_chg = false;
+	u8 gwl, gwl0, gwl1, gbt, plt_ctrl, i, dbcc_2g_phy, b2g = 0;
+	bool dbcc_chg = false, dbcc_en = false;
 	u32 ant_path_type;
 
 	ant_path_type = ((phy_map << 8) + type);
 
-	if (btc->ver->fwlrole == 1)
+	if (btc->ver->fwlrole == 1) {
 		dbcc_chg = wl->role_info_v1.dbcc_chg;
-	else if (btc->ver->fwlrole == 2)
+		dbcc_en = wl->role_info_v1.dbcc_en;
+		dbcc_2g_phy = wl->role_info_v1.dbcc_2g_phy;
+	} else if (btc->ver->fwlrole == 2) {
 		dbcc_chg = wl->role_info_v2.dbcc_chg;
-	else if (btc->ver->fwlrole == 7)
+		dbcc_en = wl->role_info_v2.dbcc_en;
+		dbcc_2g_phy = wl->role_info_v2.dbcc_2g_phy;
+	} else if (btc->ver->fwlrole == 7) {
 		dbcc_chg = wl->role_info_v7.dbcc_chg;
-	else if (btc->ver->fwlrole == 8)
+		dbcc_en = wl->role_info_v7.dbcc_en;
+		dbcc_2g_phy = wl->role_info_v7.dbcc_2g_phy;
+	} else if (btc->ver->fwlrole == 8) {
 		dbcc_chg = wl->role_info_v8.dbcc_chg;
+		dbcc_en = wl->role_info_v8.dbcc_en;
+		dbcc_2g_phy = wl->role_info_v8.dbcc_2g_phy;
+	}
 
 	if (btc->dm.run_reason == BTC_RSN_NTFY_POWEROFF ||
 	    btc->dm.run_reason == BTC_RSN_NTFY_RADIO_STATE ||
@@ -4768,14 +4827,14 @@ static void _set_ant_v0(struct rtw89_dev *rtwdev, bool force_exec,
 			for (i = 0; i < RTW89_PHY_NUM; i++) {
 				b2g = (wl_dinfo->real_band[i] == RTW89_BAND_2G);
 
-				gnt_wl_ctrl = b2g ? BTC_GNT_HW : BTC_GNT_SW_HI;
-				gnt_bt_ctrl = b2g ? BTC_GNT_HW : BTC_GNT_SW_HI;
+				gwl = b2g ? BTC_GNT_HW : BTC_GNT_SW_HI;
+				gbt = b2g ? BTC_GNT_HW : BTC_GNT_SW_HI;
 				/* BT should control by GNT_BT if WL_2G at S0 */
 				if (i == 1 &&
 				    wl_dinfo->real_band[0] == RTW89_BAND_2G &&
 				    wl_dinfo->real_band[1] == RTW89_BAND_5G)
-					gnt_bt_ctrl = BTC_GNT_HW;
-				_set_gnt(rtwdev, BIT(i), gnt_wl_ctrl, gnt_bt_ctrl);
+					gbt = BTC_GNT_HW;
+				_set_gnt(rtwdev, BIT(i), gwl, gbt);
 				plt_ctrl = b2g ? BTC_PLT_BT : BTC_PLT_NONE;
 				_set_bt_plut(rtwdev, BIT(i),
 					     plt_ctrl, plt_ctrl);
@@ -4808,12 +4867,27 @@ static void _set_ant_v0(struct rtw89_dev *rtwdev, bool force_exec,
 		_set_gnt(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO);
 		_set_bt_plut(rtwdev, phy_map, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
-	case BTC_ANT_BRFK:
-		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_BT);
-		_set_gnt(rtwdev, phy_map, BTC_GNT_SW_LO, BTC_GNT_SW_HI);
-		_set_bt_plut(rtwdev, phy_map, BTC_PLT_NONE, BTC_PLT_NONE);
-		break;
+	case BTC_ANT_PTA:
 	default:
+		gbt = BTC_GNT_HW;
+		if ((rtwdev->chip->para_ver & BTC_FEAT_MULTI_PTA) ||
+		    !dbcc_en) {
+			gwl = BTC_GNT_HW;
+			_set_gnt(rtwdev, BTC_PHY_ALL, gwl, gbt);
+		} else {
+			/* for DBCC Only-1-PTA */
+			if (dbcc_2g_phy == RTW89_PHY_0) {
+				gwl0 = BTC_GNT_HW;
+				gwl1 = BTC_GNT_SW_HI;
+			} else {
+				gwl0 = BTC_GNT_SW_HI;
+				gwl1 = BTC_GNT_HW;
+			}
+			_set_gnt(rtwdev, BTC_PHY_0, gwl0, gbt);
+			_set_gnt(rtwdev, BTC_PHY_1, gwl1, gbt);
+		}
+		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
+		_set_bt_plut(rtwdev, phy_map, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	}
 }
@@ -4828,7 +4902,7 @@ static void _set_ant_v1(struct rtw89_dev *rtwdev, bool force_exec,
 	u32 ant_path_type = rtw89_get_antpath_type(phy_map, type);
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	u8 gwl = BTC_GNT_HW;
+	u8 gwl = BTC_GNT_HW, gwl0, gwl1, gbt;
 
 	if (btc->dm.run_reason == BTC_RSN_NTFY_POWEROFF ||
 	    btc->dm.run_reason == BTC_RSN_NTFY_RADIO_STATE ||
@@ -4913,8 +4987,26 @@ static void _set_ant_v1(struct rtw89_dev *rtwdev, bool force_exec,
 		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
 			    BTC_WLACT_SW_HI); /* no BT-Tx */
 		break;
+	case BTC_ANT_PTA:
 	default:
-		return;
+		gbt = BTC_GNT_HW;
+		if ((rtwdev->chip->para_ver & BTC_FEAT_MULTI_PTA) ||
+		    !wl_rinfo->dbcc_en) {
+			gwl = BTC_GNT_HW;
+			_set_gnt_v1(rtwdev, BTC_PHY_ALL, gwl, gbt, BTC_WLACT_HW);
+		} else {
+			/* for DBCC Only-1-PTA */
+			if (wl_rinfo->dbcc_2g_phy == RTW89_PHY_0) {
+				gwl0 = BTC_GNT_HW;
+				gwl1 = BTC_GNT_SW_HI;
+			} else {
+				gwl0 = BTC_GNT_SW_HI;
+				gwl1 = BTC_GNT_HW;
+			}
+			_set_gnt_v1(rtwdev, BTC_PHY_0, gwl0, gbt, BTC_WLACT_HW);
+			_set_gnt_v1(rtwdev, BTC_PHY_1, gwl1, gbt, BTC_WLACT_HW);
+		}
+		break;
 	}
 
 	_set_bt_plut(rtwdev, phy_map, BTC_PLT_GNT_WL, BTC_PLT_GNT_WL);
@@ -6017,178 +6109,15 @@ static void _action_wl_2g_mcc(struct rtw89_dev *rtwdev)
 static void _action_wl_2g_scc(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-
-	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
-
-	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
-		if (btc->cx.bt0.link_info.link_cnt.now == 0)
-			_set_policy(rtwdev,
-				    BTC_CXP_OFFE_DEF2, BTC_ACT_WL_2G_SCC);
-		else
-			_set_policy(rtwdev,
-				    BTC_CXP_OFFE_DEF, BTC_ACT_WL_2G_SCC);
-	} else { /* dedicated-antenna */
-		_set_policy(rtwdev, BTC_CXP_OFF_EQ0, BTC_ACT_WL_2G_SCC);
-	}
-}
-
-static void _action_wl_2g_scc_v1(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_btc_wl_role_info_v1 *wl_rinfo = &wl->role_info_v1;
-	u16 policy_type = BTC_CXP_OFF_BT;
-	u32 dur;
+	u16 policy_type;
 
-	if (btc->ant_type == BTC_ANT_DEDICATED) {
-		policy_type = BTC_CXP_OFF_EQ0;
-	} else {
-		/* shared-antenna */
-		switch (wl_rinfo->mrole_type) {
-		case BTC_WLMROLE_STA_GC:
-			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
-			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_P2P_CLIENT;
-			dm->wl_scc.ebt_null = 0; /* no ext-slot-control */
-			_action_by_bt(rtwdev);
-			return;
-		case BTC_WLMROLE_STA_STA:
-			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
-			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_STATION;
-			dm->wl_scc.ebt_null = 0; /* no ext-slot-control */
-			_action_by_bt(rtwdev);
-			return;
-		case BTC_WLMROLE_STA_GC_NOA:
-		case BTC_WLMROLE_STA_GO:
-		case BTC_WLMROLE_STA_GO_NOA:
-			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
-			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_NONE;
-			dur = wl_rinfo->mrole_noa_duration;
-
-			if (wl->status.map._4way) {
-				dm->wl_scc.ebt_null = 0;
-				policy_type = BTC_CXP_OFFE_WL;
-			} else if (bt->link_info.status.map.connect == 0) {
-				dm->wl_scc.ebt_null = 0;
-				policy_type = BTC_CXP_OFFE_2GISOB;
-			} else if (bt->link_info.a2dp_desc.exist &&
-				   dur < btc->bt_req_len[RTW89_PHY_0]) {
-				dm->wl_scc.ebt_null = 1; /* tx null at EBT */
-				policy_type = BTC_CXP_OFFE_2GBWMIXB2;
-			} else if (bt->link_info.a2dp_desc.exist ||
-				   bt->link_info.pan_desc.exist) {
-				dm->wl_scc.ebt_null = 1; /* tx null at EBT */
-				policy_type = BTC_CXP_OFFE_2GBWISOB;
-			} else {
-				dm->wl_scc.ebt_null = 0;
-				policy_type = BTC_CXP_OFFE_2GBWISOB;
-			}
-			break;
-		default:
-			break;
-		}
-	}
-
-	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
-	_set_policy(rtwdev, policy_type, BTC_ACT_WL_2G_SCC);
-}
-
-static void _action_wl_2g_scc_v2(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
-	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_btc_wl_role_info_v2 *rinfo_v2 = &wl->role_info_v2;
-	struct rtw89_btc_wl_role_info_v7 *rinfo_v7 = &wl->role_info_v7;
-	u32 dur, mrole_type, mrole_noa_duration;
-	u16 policy_type = BTC_CXP_OFF_BT;
-
-	if (btc->ver->fwlrole == 2) {
-		mrole_type = rinfo_v2->mrole_type;
-		mrole_noa_duration = rinfo_v2->mrole_noa_duration;
-	} else if (btc->ver->fwlrole == 7) {
-		mrole_type = rinfo_v7->mrole_type;
-		mrole_noa_duration = rinfo_v7->mrole_noa_duration;
-	} else {
-		return;
-	}
-
-	if (btc->ant_type == BTC_ANT_DEDICATED) {
-		policy_type = BTC_CXP_OFF_EQ0;
-	} else {
-		/* shared-antenna */
-		switch (mrole_type) {
-		case BTC_WLMROLE_STA_GC:
-			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
-			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_P2P_CLIENT;
-			dm->wl_scc.ebt_null = 0; /* no ext-slot-control */
-			_action_by_bt(rtwdev);
-			return;
-		case BTC_WLMROLE_STA_STA:
-			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
-			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_STATION;
-			dm->wl_scc.ebt_null = 0; /* no ext-slot-control */
-			_action_by_bt(rtwdev);
-			return;
-		case BTC_WLMROLE_STA_GC_NOA:
-		case BTC_WLMROLE_STA_GO:
-		case BTC_WLMROLE_STA_GO_NOA:
-			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
-			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_NONE;
-			dur = mrole_noa_duration;
-
-			if (wl->status.map._4way) {
-				dm->wl_scc.ebt_null = 0;
-				policy_type = BTC_CXP_OFFE_WL;
-			} else if (bt->link_info.status.map.connect == 0) {
-				dm->wl_scc.ebt_null = 0;
-				policy_type = BTC_CXP_OFFE_2GISOB;
-			} else if (bt->link_info.a2dp_desc.exist &&
-				   dur < btc->bt_req_len[RTW89_PHY_0]) {
-				dm->wl_scc.ebt_null = 1; /* tx null at EBT */
-				policy_type = BTC_CXP_OFFE_2GBWMIXB2;
-			} else if (bt->link_info.a2dp_desc.exist ||
-				   bt->link_info.pan_desc.exist) {
-				dm->wl_scc.ebt_null = 1; /* tx null at EBT */
-				policy_type = BTC_CXP_OFFE_2GBWISOB;
-			} else {
-				dm->wl_scc.ebt_null = 0;
-				policy_type = BTC_CXP_OFFE_2GBWISOB;
-			}
-			break;
-		default:
-			break;
-		}
-	}
-
-	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
-	_set_policy(rtwdev, policy_type, BTC_ACT_WL_2G_SCC);
-}
-
-static void _action_wl_2g_scc_v8(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
-	struct rtw89_btc_dm *dm = &btc->dm;
-	u16 policy_type = BTC_CXP_OFF_BT;
-
-	if (btc->ant_type == BTC_ANT_SHARED) {
-		if (wl->status.map._4way)
-			policy_type = BTC_CXP_OFFE_WL;
-		else if (bt->link_info.status.map.connect == 0)
-			policy_type = BTC_CXP_OFFE_2GISOB;
-		else
-			policy_type = BTC_CXP_OFFE_2GBWISOB;
-	} else {
-		policy_type = BTC_CXP_OFF_EQ0;
-	}
-
-	dm->e2g_slot_limit = BTC_E2G_LIMIT_DEF;
+	if (!dm->tdd_bind.bt_smap.connect)
+		policy_type = BTC_CXP_OFFE_2GISOB;
+	else
+		policy_type = BTC_CXP_OFFE_2GBWISOB;
 
-	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
+	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_PTA);
 	_set_policy(rtwdev, policy_type, BTC_ACT_WL_2G_SCC);
 }
 
@@ -8180,14 +8109,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		break;
 	case BTC_WLINK_2G_SCC:
 		bt->scan_rx_low_pri = true;
-		if (ver->fwlrole == 0)
-			_action_wl_2g_scc(rtwdev);
-		else if (ver->fwlrole == 1)
-			_action_wl_2g_scc_v1(rtwdev);
-		else if (ver->fwlrole == 2 || ver->fwlrole == 7)
-			_action_wl_2g_scc_v2(rtwdev);
-		else if (ver->fwlrole == 8)
-			_action_wl_2g_scc_v8(rtwdev);
+		_action_wl_2g_scc(rtwdev);
 		break;
 	case BTC_WLINK_2G_MCC:
 		bt->scan_rx_low_pri = true;
@@ -10115,7 +10037,8 @@ static const char *id_to_ant(u32 id)
 	CASE_BTC_ANTPATH_STR(W25G);
 	CASE_BTC_ANTPATH_STR(FREERUN);
 	CASE_BTC_ANTPATH_STR(WRFK);
-	CASE_BTC_ANTPATH_STR(BRFK);
+	CASE_BTC_ANTPATH_STR(WRFK2);
+	CASE_BTC_ANTPATH_STR(PTA);
 	CASE_BTC_ANTPATH_STR(MAX);
 	default:
 		return "unknown";
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 21bdf229723c..eb814425f536 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1832,10 +1832,11 @@ struct rtw89_btc_wl_role_info_bpos {
 	u16 nan: 1;
 };
 
-struct rtw89_btc_wl_scc_ctrl {
-	u8 null_role1;
-	u8 null_role2;
-	u8 ebt_null; /* if tx null at EBT slot */
+struct rtw89_btc_eslot_ctrl {
+	u8 en;  /* 1: toggle tx-flow-ctrl (null 0/1), tx-pause by Ext-slot */
+	u8 nulltx_role1;
+	u8 nulltx_role2;
+	u8 nulltx_pre_time; /* null-tx time prior to EBT-start (from E2G-end) */
 };
 
 union rtw89_btc_wl_role_info_map {
@@ -3275,7 +3276,7 @@ struct rtw89_btc_dm {
 	struct rtw89_btc_rf_trx_para_v9 rf_trx_para;
 	struct rtw89_btc_wl_tx_limit_para wl_tx_limit;
 	struct rtw89_btc_dm_step dm_step;
-	struct rtw89_btc_wl_scc_ctrl wl_scc;
+	struct rtw89_btc_eslot_ctrl eslot_ctrl;
 	struct rtw89_btc_trx_info trx_info;
 	union rtw89_btc_dm_error_map error;
 	struct rtw89_btc_bind_info tdd_bind;
-- 
2.25.1


