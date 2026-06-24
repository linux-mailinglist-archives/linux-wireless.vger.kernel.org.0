Return-Path: <linux-wireless+bounces-38033-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D8l6BLxRO2prWAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38033-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:40:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA886BB230
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:40:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=Nbj4JLRt;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38033-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38033-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6543E303E15A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 03:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FACD30BF52;
	Wed, 24 Jun 2026 03:40:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769FB30BBB8
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:40:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272440; cv=none; b=IbHuudvlfzPtsVNeWVrNt6Klrhob90PONMOdP9c97fkJ8XffF2NxGQg7S+NbCutiiOnczz/68rCKFXqqAumoROr8w3ii0HOU6s30zzOZSIzzk5gz2GWgF5eXjHOxtkvIy9Js2yODFeaiRLAlBAUiD1dhQ5OmkEQkLT06li/v2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272440; c=relaxed/simple;
	bh=dO7BLiATqnmn1wqWccmGxAFqfybeAYMwv/LKugsvLy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdaHYHZzFPxW5v14h97oMhWAxXXjel7j1HcYkaPCARuo/iAJKKyLdpCzc6bSw65mEdrOW3AiLiw75+rHqZk8sNxnVJTdbJRjQb5a5apjMoZPL5d29+2c3uKII08jc7qBYjDPVgF5okzjtiSlnugp7/OWYotxqJJycVuIU+bmDf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Nbj4JLRt; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65O3eY4X13888613, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782272435; bh=H9EjhM9tczytUjM/q+ua/zSwLdXeP5gkhs1cNYRxaiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Nbj4JLRtFO00a0GE64o86zrQPQimcYgvOqYbWlhMCky/Q4CZXUhcQkfGjSA9d4YbS
	 u9TLJJsgpTZK8KAbbTJXXEZHZubuaNY6J8Sk5vYhaXfvSjBsqzlKCtY33b89Di2CKQ
	 oLIQJZqVAz+tVDV9rG2qKh3Ojmnu7AMGoZpr8NmWpMadbSRniHdVaBYMX8QZLOiXAw
	 Qz6TwuD+8NFWRTa2w/bijn3dXC28H9rXlawTplFHZ7vgz5xGnSUuGI8JehZPXp/wA7
	 On02Q/LjdjP/Uvyr8VqZam62GOv4d+8Op4G3SJ1CbGbfOafL7jtntJscgEpsptbtO7
	 VHa+hSZ6O27Yw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65O3eY4X13888613
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 11:40:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:40:35 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Jun 2026 11:40:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 02/10] wifi: rtw89: coex: offset current BT info to BT0 for dual BT configuration
Date: Wed, 24 Jun 2026 11:39:33 +0800
Message-ID: <20260624033941.45918-3-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38033-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,vger.kernel.org:from_smtp,coex_bt_devinfo_work.work:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AA886BB230

From: Ching-Te Ku <ku920601@realtek.com>

In order to compatible with single/dual Bluetooth structure in one branch,
offset the currently using BT info structure to BT-0.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 130 +++++++++++-----------
 drivers/net/wireless/realtek/rtw89/core.h |   3 +-
 2 files changed, 67 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 73f271a7ae7a..f857ba247c23 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -924,7 +924,7 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	struct rtw89_btc_wl_link_info *wl_linfo;
 	u8 i;
@@ -1106,7 +1106,7 @@ static void _chk_btc_err(struct rtw89_dev *rtwdev, u8 type, u32 cnt)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
-	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	struct rtw89_btc_dm *dm = &btc->dm;
 
@@ -1276,7 +1276,7 @@ static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &bt_linfo->a2dp_desc;
 	union  rtw89_btc_fbtc_btver *pver = &btc->fwinfo.rpt_fbtc_btver.finfo;
@@ -1417,7 +1417,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	union rtw89_btc_fbtc_rpt_ctrl_ver_info *prpt = NULL;
 	union rtw89_btc_fbtc_cysta_info *pcysta = NULL;
 	struct rtw89_btc_prpt *btc_prpt = NULL;
@@ -3079,7 +3079,7 @@ static void _set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 static void _set_bt_tx_power(struct rtw89_dev *rtwdev, u8 level)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	int ret;
 	u8 buf;
 
@@ -3106,7 +3106,7 @@ static void _set_bt_tx_power(struct rtw89_dev *rtwdev, u8 level)
 static void _set_bt_rx_gain(struct rtw89_dev *rtwdev, u8 level)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 
 	if (btc->cx.cnt_bt[BTC_BCNT_INFOUPDATE] == 0)
 		return;
@@ -3138,7 +3138,7 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_bt_link_info *b = &bt->link_info;
 	struct rtw89_btc_wl_smap *wl_smap = &wl->status.map;
 	struct rtw89_btc_rf_trx_para para;
@@ -3224,7 +3224,7 @@ static void _update_btc_state_map(struct rtw89_dev *rtwdev)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
-	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 
 	if (wl->status.map.connecting || wl->status.map._4way ||
@@ -3251,7 +3251,7 @@ static void _set_bt_afh_info_v0(struct rtw89_dev *rtwdev)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_bt_link_info *b = &bt->link_info;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
@@ -3421,7 +3421,7 @@ static void _set_bt_afh_info_v1(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
 	struct rtw89_btc_wl_afh_info *wl_afh = &wl->afh_info;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_wl_rlink *rlink;
 	u8 en = 0, ch = 0, bw = 0, buf[3] = {};
 	u8 i, j, link_mode;
@@ -3527,7 +3527,7 @@ static bool _check_freerun(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
@@ -4000,9 +4000,9 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_fbtc_tdma *t = &dm->tdma;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo = &btc->cx.wl.role_info_v1;
-	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
-	struct rtw89_btc_bt_hid_desc *hid = &btc->cx.bt.link_info.hid_desc;
-	struct rtw89_btc_bt_hfp_desc *hfp = &btc->cx.bt.link_info.hfp_desc;
+	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt0.link_info.a2dp_desc;
+	struct rtw89_btc_bt_hid_desc *hid = &btc->cx.bt0.link_info.hid_desc;
+	struct rtw89_btc_bt_hfp_desc *hfp = &btc->cx.bt0.link_info.hfp_desc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	u8 type, null_role;
 	u32 tbl_w1, tbl_b1, tbl_b4;
@@ -4483,7 +4483,7 @@ static void _set_ant_v0(struct rtw89_dev *rtwdev, bool force_exec,
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 	u8 gnt_wl_ctrl, gnt_bt_ctrl, plt_ctrl, i, b2g = 0;
 	bool dbcc_chg = false;
@@ -4611,7 +4611,7 @@ static void _set_ant_v1(struct rtw89_dev *rtwdev, bool force_exec,
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
 	u32 ant_path_type = rtw89_get_antpath_type(phy_map, type);
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
@@ -4750,7 +4750,7 @@ static void _action_wl_off(struct rtw89_dev *rtwdev, u8 mode)
 	if (mode == BTC_WLINK_5G) {
 		_set_policy(rtwdev, BTC_CXP_OFF_EQ0, BTC_ACT_WL_OFF);
 	} else if (wl->status.map.lps == BTC_LPS_RF_ON) {
-		if (btc->cx.bt.link_info.a2dp_desc.active)
+		if (btc->cx.bt0.link_info.a2dp_desc.active)
 			_set_policy(rtwdev, BTC_CXP_OFF_BT, BTC_ACT_WL_OFF);
 		else
 			_set_policy(rtwdev, BTC_CXP_OFF_BWB1, BTC_ACT_WL_OFF);
@@ -4790,7 +4790,7 @@ static void _action_bt_off(struct rtw89_dev *rtwdev)
 static void _action_bt_idle(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_link_info *b = &btc->cx.bt.link_info;
+	struct rtw89_btc_bt_link_info *b = &btc->cx.bt0.link_info;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
@@ -4838,7 +4838,7 @@ static void _action_bt_hfp(struct rtw89_dev *rtwdev)
 		if (btc->cx.wl.status.map._4way) {
 			_set_policy(rtwdev, BTC_CXP_OFF_WL, BTC_ACT_BT_HFP);
 		} else if (wl->status.map.traffic_dir & BIT(RTW89_TFC_UL)) {
-			btc->cx.bt.scan_rx_low_pri = true;
+			btc->cx.bt0.scan_rx_low_pri = true;
 			_set_policy(rtwdev, BTC_CXP_OFF_BWB2, BTC_ACT_BT_HFP);
 		} else {
 			_set_policy(rtwdev, BTC_CXP_OFF_BWB1, BTC_ACT_BT_HFP);
@@ -4858,7 +4858,7 @@ static void _action_bt_hid(struct rtw89_dev *rtwdev)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_bt_hid_desc *hid = &bt->link_info.hid_desc;
 	u16 policy_type = BTC_CXP_OFF_BT;
 
@@ -4868,7 +4868,7 @@ static void _action_bt_hid(struct rtw89_dev *rtwdev)
 		if (wl->status.map._4way) {
 			policy_type = BTC_CXP_OFF_WL;
 		} else if (wl->status.map.traffic_dir & BIT(RTW89_TFC_UL)) {
-			btc->cx.bt.scan_rx_low_pri = true;
+			btc->cx.bt0.scan_rx_low_pri = true;
 			if (hid->type & BTC_HID_BLE)
 				policy_type = BTC_CXP_OFF_BWB0;
 			else
@@ -4960,7 +4960,7 @@ static void _action_bt_a2dpsink(struct rtw89_dev *rtwdev)
 static void _action_bt_pan(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt.link_info;
+	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt0.link_info;
 	struct rtw89_btc_bt_a2dp_desc a2dp = bt_linfo->a2dp_desc;
 	struct rtw89_btc_bt_pan_desc pan = bt_linfo->pan_desc;
 
@@ -5172,7 +5172,7 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info *wl_rinfo_v0 = &wl->role_info;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_btc_ver *ver = btc->ver;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct _wl_rinfo_now wl_rinfo;
 	u32 is_btg = BTC_BTGCTRL_DISABLE;
@@ -5249,13 +5249,13 @@ static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_fbtc_outsrc_set_info *o_info = &btc->dm.ost_info;
-	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt.link_info;
+	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt0.link_info;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info_v2 *rinfo_v2 = &wl->role_info_v2;
 	struct rtw89_btc_wl_role_info_v7 *rinfo_v7 = &wl->role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 *rinfo_v8 = &wl->role_info_v8;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	u8 is_preagc, val, link_mode, dbcc_2g_phy;
 	u8 role_ver = rtwdev->btc.ver->fwlrole;
@@ -5285,7 +5285,7 @@ static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 	} else if (link_mode == BTC_WLINK_5G) {
 		is_preagc = BTC_PREAGC_DISABLE;
 	} else if (link_mode == BTC_WLINK_NOLINK ||
-		 btc->cx.bt.link_info.profile_cnt.now == 0) {
+		 btc->cx.bt0.link_info.profile_cnt.now == 0) {
 		is_preagc = BTC_PREAGC_DISABLE;
 	} else if (dm->tdma_now.type != CXTDMA_OFF &&
 		 !bt_linfo->hfp_desc.exist &&
@@ -5435,7 +5435,7 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
-	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	struct rtw89_btc_bt_link_info *b = &bt->link_info;
 	struct rtw89_btc_bt_hfp_desc *hfp = &b->hfp_desc;
 	struct rtw89_btc_bt_hid_desc *hid = &b->hid_desc;
@@ -5522,7 +5522,7 @@ static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
 	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	bool bt_hi_lna_rx = false;
 	u8 mode;
 
@@ -5551,7 +5551,7 @@ static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 static void _set_bt_rx_scan_pri(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 
 	_write_scbd(rtwdev, BTC_WSCB_RXSCAN_PRI, (bool)(!!bt->scan_rx_low_pri));
 }
@@ -5590,7 +5590,7 @@ static void _action_common(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info_v8 *rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_wl_smap *wl_smap = &wl->status.map;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	u32 bt_rom_code_id, bt_fw_ver;
 
@@ -5650,7 +5650,7 @@ static void _action_common(struct rtw89_dev *rtwdev)
 static void _action_by_bt(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	struct rtw89_btc_bt_hid_desc hid = bt_linfo->hid_desc;
 	struct rtw89_btc_bt_a2dp_desc a2dp = bt_linfo->a2dp_desc;
@@ -5747,7 +5747,7 @@ static void _action_wl_25g_mcc(struct rtw89_dev *rtwdev)
 			policy_type = BTC_CXP_OFFE_WL;
 		else if (btc->cx.wl.status.val & btc_scanning_map.val)
 			policy_type = BTC_CXP_OFFE_2GBWMIXB;
-		else if (btc->cx.bt.link_info.status.map.connect == 0)
+		else if (btc->cx.bt0.link_info.status.map.connect == 0)
 			policy_type = BTC_CXP_OFFE_2GISOB;
 		else
 			policy_type = BTC_CXP_OFFE_2GBWISOB;
@@ -5791,7 +5791,7 @@ static void _action_wl_2g_mcc(struct rtw89_dev *rtwdev)
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
-		if (btc->cx.bt.link_info.profile_cnt.now == 0)
+		if (btc->cx.bt0.link_info.profile_cnt.now == 0)
 			_set_policy(rtwdev, BTC_CXP_OFFE_DEF2,
 				    BTC_ACT_WL_2G_MCC);
 		else
@@ -5809,7 +5809,7 @@ static void _action_wl_2g_scc(struct rtw89_dev *rtwdev)
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
-		if (btc->cx.bt.link_info.profile_cnt.now == 0)
+		if (btc->cx.bt0.link_info.profile_cnt.now == 0)
 			_set_policy(rtwdev,
 				    BTC_CXP_OFFE_DEF2, BTC_ACT_WL_2G_SCC);
 		else
@@ -5824,7 +5824,7 @@ static void _action_wl_2g_scc_v1(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo = &wl->role_info_v1;
 	u16 policy_type = BTC_CXP_OFF_BT;
@@ -5886,7 +5886,7 @@ static void _action_wl_2g_scc_v2(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_role_info_v2 *rinfo_v2 = &wl->role_info_v2;
 	struct rtw89_btc_wl_role_info_v7 *rinfo_v7 = &wl->role_info_v7;
@@ -5959,7 +5959,7 @@ static void _action_wl_2g_scc_v8(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	u16 policy_type = BTC_CXP_OFF_BT;
 
@@ -5987,7 +5987,7 @@ static void _action_wl_2g_ap(struct rtw89_dev *rtwdev)
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	if (btc->ant_type == BTC_ANT_SHARED) {
-		if (btc->cx.bt.link_info.profile_cnt.now == 0)
+		if (btc->cx.bt0.link_info.profile_cnt.now == 0)
 			_set_policy(rtwdev, BTC_CXP_OFFE_DEF2,
 				    BTC_ACT_WL_2G_AP);
 		else
@@ -6004,7 +6004,7 @@ static void _action_wl_2g_go(struct rtw89_dev *rtwdev)
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
-		if (btc->cx.bt.link_info.profile_cnt.now == 0)
+		if (btc->cx.bt0.link_info.profile_cnt.now == 0)
 			_set_policy(rtwdev,
 				    BTC_CXP_OFFE_DEF2, BTC_ACT_WL_2G_GO);
 		else
@@ -6035,7 +6035,7 @@ static void _action_wl_2g_nan(struct rtw89_dev *rtwdev)
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
-		if (btc->cx.bt.link_info.profile_cnt.now == 0)
+		if (btc->cx.bt0.link_info.profile_cnt.now == 0)
 			_set_policy(rtwdev,
 				    BTC_CXP_OFFE_DEF2, BTC_ACT_WL_2G_NAN);
 		else
@@ -7352,7 +7352,7 @@ void rtw89_coex_bt_devinfo_work(struct wiphy *wiphy, struct wiphy_work *work)
 						coex_bt_devinfo_work.work);
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
-	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
+	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt0.link_info.a2dp_desc;
 
 	lockdep_assert_wiphy(wiphy);
 
@@ -7392,7 +7392,7 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	bool bt_link_change = false, lps_ctrl = false;
@@ -7496,7 +7496,7 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 #define BTC_BTINFO_PWR_LEN 5
 static void _update_bt_txpwr_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 {
-	struct rtw89_btc_bt_info *bt = &rtwdev->btc.cx.bt;
+	struct rtw89_btc_bt_info *bt = &rtwdev->btc.cx.bt0;
 	struct rtw89_btc_bt_link_info *b = &bt->link_info;
 
 	if (len != BTC_BTINFO_PWR_LEN)
@@ -7516,7 +7516,7 @@ static bool _chk_wl_rfk_request(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
-	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
 
 	_update_bt_scbd(rtwdev, true);
 
@@ -7540,7 +7540,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
@@ -7657,12 +7657,12 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		goto exit;
 	}
 
-	if (!cx->bt.enable.now && !cx->other.type) {
+	if (!cx->bt0.enable.now && !cx->other.type) {
 		_action_bt_off(rtwdev);
 		goto exit;
 	}
 
-	if (cx->bt.whql_test) {
+	if (cx->bt0.whql_test) {
 		_action_bt_whql(rtwdev);
 		goto exit;
 	}
@@ -7925,7 +7925,7 @@ void rtw89_btc_ntfy_specific_packet(struct rtw89_dev *rtwdev,
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
-	struct rtw89_btc_bt_link_info *b = &cx->bt.link_info;
+	struct rtw89_btc_bt_link_info *b = &cx->bt0.link_info;
 	struct rtw89_btc_bt_hfp_desc *hfp = &b->hfp_desc;
 	struct rtw89_btc_bt_hid_desc *hid = &b->hid_desc;
 	u32 cnt;
@@ -8030,7 +8030,7 @@ static u8 _update_bt_rssi_level(struct rtw89_dev *rtwdev, u8 rssi)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	u8 *rssi_st, rssi_th, rssi_level = 0;
 	u8 i;
 
@@ -8080,7 +8080,7 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_cx *cx = &btc->cx;
-	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	struct rtw89_btc_bt_link_info *b = &bt->link_info;
 	struct rtw89_btc_bt_hfp_desc *hfp = &b->hfp_desc;
 	struct rtw89_btc_bt_hid_desc *hid = &b->hid_desc;
@@ -8851,7 +8851,7 @@ static int _show_cx_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	u32 ver_main = 0, ver_sub = 0, ver_hotfix = 0, id_branch = 0;
 	u8 cv, rfe, iso, ant_num, ant_single_pos;
@@ -9050,7 +9050,7 @@ enum btc_bt_a2dp_type {
 static int _show_bt_profile_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt.link_info;
+	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt0.link_info;
 	struct rtw89_btc_bt_hfp_desc hfp = bt_linfo->hfp_desc;
 	struct rtw89_btc_bt_hid_desc hid = bt_linfo->hid_desc;
 	struct rtw89_btc_bt_a2dp_desc a2dp = bt_linfo->a2dp_desc;
@@ -9108,7 +9108,7 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_cx *cx = &btc->cx;
-	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	u32 ver_main = FIELD_GET(GENMASK(31, 24), wl->ver_info.fw_coex);
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
@@ -9631,7 +9631,7 @@ static int _show_dm_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	char *p = buf, *end = buf + bufsz;
 	u8 igno_bt;
 
@@ -9853,7 +9853,7 @@ static int _show_fbtc_cysta_v2(struct rtw89_dev *rtwdev, char *buf, size_t bufsz
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
+	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt0.link_info.a2dp_desc;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_cysta_v2 *pcysta_le32 = NULL;
 	union rtw89_btc_fbtc_rxflct r;
@@ -9984,7 +9984,7 @@ static int _show_fbtc_cysta_v2(struct rtw89_dev *rtwdev, char *buf, size_t bufsz
 static int _show_fbtc_cysta_v3(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
+	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt0.link_info.a2dp_desc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_fbtc_a2dp_trx_stat *a2dp_trx;
@@ -10123,7 +10123,7 @@ static int _show_fbtc_cysta_v3(struct rtw89_dev *rtwdev, char *buf, size_t bufsz
 static int _show_fbtc_cysta_v4(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
+	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt0.link_info.a2dp_desc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_fbtc_a2dp_trx_stat_v4 *a2dp_trx;
@@ -10262,7 +10262,7 @@ static int _show_fbtc_cysta_v4(struct rtw89_dev *rtwdev, char *buf, size_t bufsz
 static int _show_fbtc_cysta_v5(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
+	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt0.link_info.a2dp_desc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_fbtc_a2dp_trx_stat_v4 *a2dp_trx;
@@ -10399,7 +10399,7 @@ static int _show_fbtc_cysta_v5(struct rtw89_dev *rtwdev, char *buf, size_t bufsz
 
 static int _show_fbtc_cysta_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
-	struct rtw89_btc_bt_info *bt = &rtwdev->btc.cx.bt;
+	struct rtw89_btc_bt_info *bt = &rtwdev->btc.cx.bt0;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &bt->link_info.a2dp_desc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &rtwdev->btc.fwinfo;
 	struct rtw89_btc_fbtc_cysta_v7 *pcysta = NULL;
@@ -10898,7 +10898,7 @@ static int _show_mreg_v1(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_btc_fbtc_mreg_val_v1 *pmreg = NULL;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_mac_ax_coex_gnt gnt_cfg = {};
 	struct rtw89_mac_ax_gnt gnt;
 	char *p = buf, *end = buf + bufsz;
@@ -10983,7 +10983,7 @@ static int _show_mreg_v2(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_btc_fbtc_mreg_val_v2 *pmreg = NULL;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_mac_ax_coex_gnt gnt_cfg = {};
 	struct rtw89_mac_ax_gnt gnt;
 	char *p = buf, *end = buf + bufsz;
@@ -11068,7 +11068,7 @@ static int _show_mreg_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
-	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	struct rtw89_mac_ax_gnt *gnt = NULL;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	char *p = buf, *end = buf + bufsz;
@@ -11146,7 +11146,7 @@ static int _show_summary_v1(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
-	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	u32 cnt_sum = 0, *cnt = btc->dm.cnt_notify;
 	char *p = buf, *end = buf + bufsz;
 	u8 i;
@@ -11255,7 +11255,7 @@ static int _show_summary_v4(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
-	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	u32 cnt_sum = 0, *cnt = btc->dm.cnt_notify;
 	char *p = buf, *end = buf + bufsz;
 	u8 i;
@@ -11929,7 +11929,7 @@ void rtw89_coex_recognize_ver(struct rtw89_dev *rtwdev)
 
 void rtw89_btc_ntfy_preserve_bt_time(struct rtw89_dev *rtwdev, u32 ms)
 {
-	struct rtw89_btc_bt_link_info *bt_linfo = &rtwdev->btc.cx.bt.link_info;
+	struct rtw89_btc_bt_link_info *bt_linfo = &rtwdev->btc.cx.bt0.link_info;
 	struct rtw89_btc_bt_a2dp_desc a2dp = bt_linfo->a2dp_desc;
 
 	if (test_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags))
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index de92e42da614..2f12252bc26e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2262,7 +2262,8 @@ struct rtw89_btc_rf_trx_para_v9 {
 
 struct rtw89_btc_cx {
 	struct rtw89_btc_wl_info wl;
-	struct rtw89_btc_bt_info bt;
+	struct rtw89_btc_bt_info bt0;
+	struct rtw89_btc_bt_info bt1;
 	struct rtw89_btc_3rdcx_info other;
 	u32 state_map;
 	u32 cnt_bt[BTC_BCNT_NUM];
-- 
2.25.1


