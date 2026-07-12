Return-Path: <linux-wireless+bounces-38894-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rNluKskEU2pNWAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38894-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:06:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B17743A45
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:06:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=wT2hObfK;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38894-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38894-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C9DE30107ED
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A21C2773DE;
	Sun, 12 Jul 2026 03:06:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14EC2571DA
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:06:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783825594; cv=none; b=qLKzYGQR8giPcq8zLxXEqLFjVKEaikZ3+HFaIROPpwrXf7nQAJUfjVr8OEIyOu60+F51ED1rPQ0v+ntKvnAyxk0Y8+16RfN80K5NGRiw9Y8Nx6rZENE0zhjgbBYyco03FULNb4kLkOALslD2mxxlD++pCNTY9GIik3GNHbe7roU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783825594; c=relaxed/simple;
	bh=Oo4QNALM4+73p6fYveBDPzHYACoQX0AFWkDggpJZxSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQPPKT/26WkRm6eeOGxcUVUpldi5VzIsxLKW/xyy1xILDM2gYX+mnqTqE89yFpG/79HRs3ZgEv69bOUOcIxjdnJgh9J5CDBQmLr+pfPV4atb6u4omEtSrzA1cveMZ3NSpavu/1C+o3S9H5I+wvhxIPhwo4hsqASdN3VOPXZVYlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wT2hObfK; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C36UqwC525896, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783825590; bh=bXmjqKlAT7K9M0kfXqIxM8kKDW7fiB7ZvRv/PkPdFdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wT2hObfKFftH+GNnH7x2+sDEOR1KzdV9Guo8GWi4Oh9yIvO3gZAtaFqEp4zWqDMd2
	 WQ2JZXiwCzycDdYBAGWNqgZ6WVWAmx9gz/ByyuHOWsX77+q2ehSELcy7ezt4g7UNp8
	 H2XSuqIWn0zCVG2gCFGiqaiFKF2kxgjQqd2eKeRw/AR8/3qq2RpbZc0/oCKN566zqj
	 +Jc3h2MuJIVo8H0L602cE0Y3+ZJMrNs77wChMOJr/2495AQO53YrKFKHKOMN2JdrV5
	 7+SgHFLhumLwJPIzTuqwIDs584MGj8g4f4+c5E/E0dessLVl1o4M7NDwO6MvvIa37h
	 Xmi+dZfXxfnxw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C36UqwC525896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:06:30 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:30 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:06:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 05/11] wifi: rtw89: coex: Rearrange Bluetooth firmware report entry
Date: Sun, 12 Jul 2026 11:05:00 +0800
Message-ID: <20260712030506.43438-6-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-38894-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: F1B17743A45

From: Ching-Te Ku <ku920601@realtek.com>

To enable/disable firmware report once at the end of mechanism round.
This can make the logic more clearly, and make sure every round the
mechanism running can refresh the settings. It can avoid some report
missing after driver status change.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 209 +++++++++++-----------
 1 file changed, 104 insertions(+), 105 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 2ca6090e9f62..ff3345824a2a 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -2659,37 +2659,27 @@ static void rtw89_btc_fw_set_slots(struct rtw89_dev *rtwdev)
 }
 
 static void rtw89_btc_fw_en_rpt(struct rtw89_dev *rtwdev,
-				u32 rpt_map, bool rpt_state)
+				bool force_exec, u32 rpt_map)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_smap *wl_smap = &btc->cx.wl.status.map;
 	struct rtw89_btc_btf_fwinfo *fwinfo = &btc->fwinfo;
 	union rtw89_fbtc_rtp_ctrl r;
-	u32 val, bit_map;
 	int ret;
+	u32 i;
 
-	if ((wl_smap->rf_off || wl_smap->lps != BTC_LPS_OFF) && rpt_state != 0)
+	if (!force_exec && rpt_map == fwinfo->rpt_en_map)
 		return;
 
-	bit_map = rtw89_btc_fw_rpt_ver(rtwdev, rpt_map);
-
-	rtw89_debug(rtwdev, RTW89_DBG_BTC,
-		    "[BTC], %s(): rpt_map=%x, rpt_state=%x\n",
-		    __func__, rpt_map, rpt_state);
-
-	if (rpt_state)
-		val = fwinfo->rpt_en_map | bit_map;
-	else
-		val = fwinfo->rpt_en_map & ~bit_map;
-
-	if (val == fwinfo->rpt_en_map)
-		return;
+	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): rpt_map=%x\n",
+		    __func__, fwinfo->rpt_en_map);
 
-	if (btc->ver->fcxbtcrpt == 7 || btc->ver->fcxbtcrpt == 8) {
+	if (btc->ver->fcxbtcrpt == 7 ||
+	    btc->ver->fcxbtcrpt == 8 ||
+	    btc->ver->fcxbtcrpt == 11) {
 		r.v8.type = SET_REPORT_EN;
 		r.v8.fver = btc->ver->fcxbtcrpt;
 		r.v8.len = sizeof(r.v8.map);
-		r.v8.map = cpu_to_le32(val);
+		r.v8.map = cpu_to_le32(rpt_map);
 		ret = _send_fw_cmd(rtwdev, BTFC_SET, SET_REPORT_EN, &r.v8,
 				   sizeof(r.v8));
 	} else {
@@ -2697,14 +2687,21 @@ static void rtw89_btc_fw_en_rpt(struct rtw89_dev *rtwdev,
 			r.v1.fver = 5;
 		else
 			r.v1.fver = btc->ver->fcxbtcrpt;
-		r.v1.enable = cpu_to_le32(val);
-		r.v1.para = cpu_to_le32(rpt_state);
-		ret = _send_fw_cmd(rtwdev, BTFC_SET, SET_REPORT_EN, &r.v1,
-				   sizeof(r.v1));
+
+		for (i = 0; i < RPT_EN_MONITER; i++) {
+			r.v1.enable = cpu_to_le32(i);
+			if (rpt_map & BIT(i))
+				r.v1.para = cpu_to_le32(1);
+			else
+				r.v1.para = 0;
+
+			ret = _send_fw_cmd(rtwdev, BTFC_SET, SET_REPORT_EN,
+					   &r.v1, sizeof(r.v1));
+		}
 	}
 
 	if (!ret)
-		fwinfo->rpt_en_map = val;
+		fwinfo->rpt_en_map = rpt_map;
 }
 
 static void btc_fw_set_monreg(struct rtw89_dev *rtwdev)
@@ -2766,8 +2763,6 @@ static void btc_fw_set_monreg(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): sz=%d ulen=%d n=%d\n",
 		    __func__, sz, ulen, n);
-
-	rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_MREG, 1);
 }
 
 static void _update_dm_step(struct rtw89_dev *rtwdev,
@@ -5882,15 +5877,72 @@ static void _update_zb_coex_tbl(struct rtw89_dev *rtwdev)
 	rtw89_write32(rtwdev, R_BTC_ZB_COEX_TBL_1, zb_tbl1);
 }
 
+static void _set_fw_report_map(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_smap *wl_smap = &btc->cx.wl.status.map;
+	struct rtw89_btc_bt_info *bt0 = &btc->cx.bt0;
+	struct rtw89_btc_bt_info *bt1 = &btc->cx.bt1;
+	u32 rpt_map = btc->fwinfo.rpt_en_map;
+	u32 bt_rom_code_id, bt_fw_ver;
+	bool bt_ver_unknown = false;
+	u32 bitmap;
+
+	if (wl_smap->rf_off == 1 || wl_smap->lps != BTC_LPS_OFF) {
+		rtw89_btc_fw_en_rpt(rtwdev, false, 0);
+		return;
+	}
+
+	rpt_map |= rtw89_btc_fw_rpt_ver(rtwdev, RPT_EN_MREG);
+
+	bitmap = rtw89_btc_fw_rpt_ver(rtwdev, RPT_EN_BT_SCAN_INFO);
+	if ((bt0->run_patch_code && bt0->enable.now) ||
+	    (bt1->run_patch_code && bt1->enable.now))
+		rpt_map |= bitmap;
+	else
+		rpt_map &= ~bitmap;
+
+	bt_rom_code_id = chip_id_to_bt_rom_code_id(rtwdev->btc.ver->chip_id);
+	bt_fw_ver = bt0->ver_info.fw & 0xffff;
+	if (bt_fw_ver == 0 ||
+	    (bt_fw_ver == bt_rom_code_id && bt0->run_patch_code))
+		bt_ver_unknown = true;
+
+	bitmap = rtw89_btc_fw_rpt_ver(rtwdev, RPT_EN_BT_VER_INFO);
+	if (bt0->enable.now && bt_ver_unknown)
+		rpt_map |= bitmap;
+	else
+		rpt_map &= ~bitmap;
+
+	bitmap = rtw89_btc_fw_rpt_ver(rtwdev, RPT_EN_BT_AFH_MAP) |
+		 rtw89_btc_fw_rpt_ver(rtwdev, RPT_EN_BT_AFH_MAP_LE) |
+		 rtw89_btc_fw_rpt_ver(rtwdev, RPT_EN_BT_TX_PWR_LVL);
+	if (bt0->link_info.link_cnt.now ||
+	    bt0->link_info_56g.link_cnt.now ||
+	    bt1->link_info.link_cnt.now ||
+	    bt1->link_info_56g.link_cnt.now)
+		rpt_map |= bitmap;
+	else
+		rpt_map &= ~bitmap;
+
+	bitmap = rtw89_btc_fw_rpt_ver(rtwdev, RPT_EN_BT_DEVICE_INFO);
+	if ((bt0->link_info.a2dp_desc.exist &&
+	     bt0->link_info.a2dp_desc.play_latency) ||
+	    (bt1->link_info.a2dp_desc.exist &&
+	     bt1->link_info.a2dp_desc.play_latency))
+		rpt_map |= bitmap;
+	else
+		rpt_map &= ~bitmap;
+
+	rtw89_btc_fw_en_rpt(rtwdev, false, rpt_map);
+}
+
 static void _action_common(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info *rinfo = &wl->role_info;
-	struct rtw89_btc_wl_smap *wl_smap = &wl->status.map;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	u32 bt_rom_code_id, bt_fw_ver;
 	u8 i;
 
 	_wl_req_mac(rtwdev, rinfo->pta_req_band);
@@ -5902,27 +5954,13 @@ static void _action_common(struct rtw89_dev *rtwdev)
 	_set_bt_rx_agc(rtwdev);
 	_set_rf_trx_para(rtwdev);
 	_set_bt_rx_scan_pri(rtwdev);
-
-	bt_rom_code_id = chip_id_to_bt_rom_code_id(rtwdev->btc.ver->chip_id);
-	bt_fw_ver = bt->ver_info.fw & 0xffff;
-	if (bt->enable.now &&
-	    (bt_fw_ver == 0 ||
-	     (bt_fw_ver == bt_rom_code_id && bt->run_patch_code && rtwdev->chip->scbd)))
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, 1);
-	else
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, 0);
+	_set_fw_report_map(rtwdev);
 
 	if (dm->run_reason == BTC_RSN_NTFY_INIT ||
 	    dm->run_reason == BTC_RSN_NTFY_RADIO_STATE ||
-	    dm->run_reason == BTC_RSN_NTFY_POWEROFF) {
+	    dm->run_reason == BTC_RSN_NTFY_POWEROFF)
 		_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
 
-		if (wl_smap->rf_off == 1 || wl_smap->lps != BTC_LPS_OFF)
-			rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_ALL, 0);
-		else
-			rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_MREG, 1);
-	}
-
 	for (i = BTC_BT_1ST; i <= BTC_BT_2ND; i++)
 		_sned_h2c_w2bscbd(rtwdev, false, i);
 
@@ -7730,8 +7768,6 @@ void rtw89_btc_ntfy_poweroff(struct rtw89_dev *rtwdev)
 	_write_scbd(rtwdev, BTC_ALL_BT, BTC_WSCB_ALL, false);
 	_run_coex(rtwdev, BTC_RSN_NTFY_POWEROFF);
 
-	rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_ALL, 0);
-
 	btc->cx.wl.status.map.rf_off_pre = btc->cx.wl.status.map.rf_off;
 }
 
@@ -8344,12 +8380,10 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 	}
 
 	if (rf_state == BTC_RFCTRL_WL_ON) {
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_MREG, true);
 		val = BTC_WSCB_ACTIVE | BTC_WSCB_ON | BTC_WSCB_BTLOG;
 		_write_scbd(rtwdev, BTC_ALL_BT, val, true);
 		chip->ops->btc_init_cfg(rtwdev);
 	} else {
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_ALL, false);
 		if (rf_state == BTC_RFCTRL_FW_CTRL)
 			_write_scbd(rtwdev, BTC_ALL_BT, BTC_WSCB_ACTIVE, false);
 		else if (rf_state == BTC_RFCTRL_WL_OFF)
@@ -8857,11 +8891,6 @@ static int _show_cx_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		       (bt->ver_info.fw_coex >= ver->bt_desired ?
 			"Match" : "Mismatch"), ver->bt_desired);
 
-	if (bt->enable.now && bt->ver_info.fw == 0)
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, true);
-	else
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, false);
-
 	ver_main = FIELD_GET(GENMASK(31, 24), wl->ver_info.fw);
 	ver_sub = FIELD_GET(GENMASK(23, 16), wl->ver_info.fw);
 	ver_hotfix = FIELD_GET(GENMASK(15, 8), wl->ver_info.fw);
@@ -9056,7 +9085,6 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_bt_info *bt = &cx->bt0;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
-	u32 ver_main = FIELD_GET(GENMASK(31, 24), wl->ver_info.fw_coex);
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	union rtw89_btc_module_info *md = &btc->mdinfo;
 	s8 br_dbm = bt->link_info.bt_txpwr_desc.br_dbm;
@@ -9167,39 +9195,28 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		       bt->bcnt[BTC_BCNT_LOPRI_TX],
 		       bt->bcnt[BTC_BCNT_POLLUTED]);
 
-	if (!bt->scan_info_update) {
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_SCAN_INFO, true);
-		p += scnprintf(p, end - p, "\n");
-	} else {
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_SCAN_INFO, false);
-		if (ver->fcxbtscan == 1) {
-			p += scnprintf(p, end - p,
-				       "(INQ:%d-%d/PAGE:%d-%d/LE:%d-%d/INIT:%d-%d)",
-				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INQ].win),
-				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INQ].intvl),
-				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_PAGE].win),
-				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_PAGE].intvl),
-				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_BLE].win),
-				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_BLE].intvl),
-				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INIT].win),
-				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INIT].intvl));
-		} else if (ver->fcxbtscan == 2) {
-			p += scnprintf(p, end - p,
-				       "(BG:%d-%d/INIT:%d-%d/LE:%d-%d)",
-				       le16_to_cpu(bt->scan_info_v2[CXSCAN_BG].win),
-				       le16_to_cpu(bt->scan_info_v2[CXSCAN_BG].intvl),
-				       le16_to_cpu(bt->scan_info_v2[CXSCAN_INIT].win),
-				       le16_to_cpu(bt->scan_info_v2[CXSCAN_INIT].intvl),
-				       le16_to_cpu(bt->scan_info_v2[CXSCAN_LE].win),
-				       le16_to_cpu(bt->scan_info_v2[CXSCAN_LE].intvl));
-		}
-		p += scnprintf(p, end - p, "\n");
+	if (ver->fcxbtscan == 1) {
+		p += scnprintf(p, end - p,
+			       "(INQ:%d-%d/PAGE:%d-%d/LE:%d-%d/INIT:%d-%d)",
+			       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INQ].win),
+			       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INQ].intvl),
+			       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_PAGE].win),
+			       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_PAGE].intvl),
+			       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_BLE].win),
+			       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_BLE].intvl),
+			       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INIT].win),
+			       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INIT].intvl));
+	} else if (ver->fcxbtscan == 2) {
+		p += scnprintf(p, end - p,
+			       "(BG:%d-%d/INIT:%d-%d/LE:%d-%d)",
+			       le16_to_cpu(bt->scan_info_v2[CXSCAN_BG].win),
+			       le16_to_cpu(bt->scan_info_v2[CXSCAN_BG].intvl),
+			       le16_to_cpu(bt->scan_info_v2[CXSCAN_INIT].win),
+			       le16_to_cpu(bt->scan_info_v2[CXSCAN_INIT].intvl),
+			       le16_to_cpu(bt->scan_info_v2[CXSCAN_LE].win),
+			       le16_to_cpu(bt->scan_info_v2[CXSCAN_LE].intvl));
 	}
-
-	if (ver_main >= 9 && bt_linfo->link_cnt.now)
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_TX_PWR_LVL, true);
-	else
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_TX_PWR_LVL, false);
+	p += scnprintf(p, end - p, "\n");
 
 	if (bt->bcnt[BTC_BCNT_TXPWR_UPDATE]) {
 		p += scnprintf(p, end - p,
@@ -9218,24 +9235,6 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	}
 	p += scnprintf(p, end - p, "\n");
 
-	if (bt_linfo->link_cnt.now || bt_linfo->status.map.ble_connect)
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP, true);
-	else
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP, false);
-
-	if (ver->fcxbtafh == 2 && bt_linfo->status.map.ble_connect)
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP_LE, true);
-	else
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP_LE, false);
-
-	if (bt_linfo->a2dp_desc.exist &&
-	    (bt_linfo->a2dp_desc.flush_time == 0 ||
-	     bt_linfo->a2dp_desc.vendor_id == 0 ||
-	     bt_linfo->a2dp_desc.play_latency == 1))
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_DEVICE_INFO, true);
-	else
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_DEVICE_INFO, false);
-
 	return p - buf;
 }
 
-- 
2.25.1


