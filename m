Return-Path: <linux-wireless+bounces-38652-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MnbfKX4ZS2qjLwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38652-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 04:57:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7FA70C3B8
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 04:57:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=Ce3iv5ax;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38652-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38652-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFEE33011C6F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 02:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF878384CFD;
	Mon,  6 Jul 2026 02:56:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A0385D7A
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 02:56:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306600; cv=none; b=GjD7xrZlXRA+LjzBkItDUIFkqfhQ2caXzt26mpNfWOYPIsvO8wWCOEEwUot7vHh6PR4Qywm/nCaNx6HuXMj6W59u30cZ/Xs0iRw+8gIXB4C9a3zCVniFHa6eobXBES0/Oct6KRL6W6F9FYYItPSYtUlYKdAwh4e/mYkDDS7tnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306600; c=relaxed/simple;
	bh=c76CqyLjjy2hLg/jPSxQqr9pvRUXUjbXq6vwwyHk4Yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/n91mIGhG5pkLB1EeNiKvuowuixT3ziodsXB0w/gGoSnMznL8PFybMI5oUdd/ZkJlzK2PmfFtfyOEVpxzcXZB4E77wiziS+3/MIfuRn2La2NzYVapax1LEPuuBuUBJ9UrQVXllM/LjbR4tq46ssbVLWdrwnMQUtnntQ5PfIBzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ce3iv5ax; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6662uaTqB120704, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783306597; bh=vOVbm36l0uzK8FdoYmkDn8uFi1Cfjbqndt88B/dQRMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ce3iv5ax7/JV6qIQQ0D5TJAPpIt26ZaFo/qJzkoQAQt0k2T6HkyHFj374uk5sFK4x
	 c0/Y6XnT4nhXV6O9YcnpN8bXYJShoWZ94rrkwwa33pi39Tq/OTi1xte0tNkJGZFJBP
	 eAcPDKl4J/kT+nkmS8nOWtnNHyoby9nPdUwTtq//BWwHRpC4BsaHLZz/cDUJVJ4758
	 ypz7PYNFY5dDSkntuBx+llVmm1tKE8IviMGu8fUei9kDzN6wq/HpTzW3gk/ae7evXf
	 +Mz8P3bfSdphk2hnm6+yoIP0G1unLuD9QEAl4sIMDxBNVkfr9MmXNBFJl5XJ9jLkjq
	 yd41ksSG3iJcw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6662uaTqB120704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jul 2026 10:56:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Jul 2026 10:56:34 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Jul 2026 10:56:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next v2 9/9] wifi: rtw89: coex: Add Co-RX logic
Date: Mon, 6 Jul 2026 10:54:45 +0800
Message-ID: <20260706025445.18428-10-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38652-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C7FA70C3B8

From: Ching-Te Ku <ku920601@realtek.com>

Co-RX means Wi-Fi & Bluetooth can be able to RX in the same time. This
patch is for judging the Wi-Fi/Bluetooth condition could be Co-RX or not,
and how to set the gain and power.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 69 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 70 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index e78fcaf4e196..802348166e6b 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3319,7 +3319,74 @@ static void _set_bt_rx_gain(struct rtw89_dev *rtwdev, bool force_exec, u8 bid,
 
 		_write_scbd(rtwdev, bid, scbd_bit, state);
 	}
+}
+
+static void _set_bt_corx_table(struct rtw89_dev *rtwdev, bool en)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u8 is_24g, is_56g, i;
+	u32 scbd_bit;
+
+	/*
+	 * true: bt use Hi-LNA rx gain table (f/e/3/2) in -3x~-9xdBm for co-rx
+	 * false: bt use original rx gain table (f/b/7/3/2)
+	 */
+
+	if (btc->dm.fdd_bind.bt_sel == BIT(BTC_BT_EXT))
+		return;
+
+	for (i = BTC_BT_1ST; i <= BTC_BT_2ND; i++) {
+		scbd_bit = 0;
+		if (i == BTC_BT_2ND) {
+			if (!(rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT))
+				continue;
+			bt = &cx->bt1;
+		}
 
+		is_24g = (dm->corx_map[BTC_RF_S0][i] ||
+			  dm->corx_map[BTC_RF_S1][i]) & BIT(RTW89_BAND_2G);
+		is_56g = (dm->corx_map[BTC_RF_S0][i] ||
+			  dm->corx_map[BTC_RF_S1][i]) & BIT(RTW89_BAND_5G);
+		if (is_24g)
+			scbd_bit |= BTC_WSCB_BT_HILNA;
+		if (is_56g)
+			scbd_bit |= BTC_WSCB_BT_HILNA_56G;
+
+		if ((is_24g && (en != (!!bt->hi_lna_rx))) ||
+		    (is_56g && (en != (!!bt->hi_lna_rx_6g))))
+			_write_scbd(rtwdev, i, scbd_bit, en);
+	}
+}
+
+static void _set_rf_trx_para_v9(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_wl_smap *wl_smap = &cx->wl.status.map;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	bool bt_2r = false;
+	u8 wl_stb_chg = 0;
+
+	if (wl_smap->rf_off || wl_smap->lps == BTC_LPS_RF_OFF)
+		return;
+
+	/* must call after _set_halbb_btg_ctrl() */
+	if (dm->tdd_bind.wl_link_mode != BTC_WLINK_NOLINK) {
+		wl_stb_chg = 1;
+		if (dm->wl_btg_rx)
+			bt_2r = true;
+	}
+
+	_set_bt_corx_table(rtwdev, bt_2r);
+
+	if (wl_stb_chg != dm->wl_stb_chg) {
+		dm->wl_stb_chg = wl_stb_chg;
+		dm->ost_info.wl_btg_standby_chg = wl_stb_chg;
+		rtwdev->chip->ops->btc_wl_s1_standby(rtwdev, dm->wl_stb_chg);
+	}
 }
 
 static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
@@ -3356,6 +3423,8 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 	if (ver->fcxtrx == 9 && chip->rf_para_ulink_v9) {
 		ul_para_num = chip->rf_para_ulink_num_v9;
 		dl_para_num = chip->rf_para_dlink_num_v9;
+		_set_rf_trx_para_v9(rtwdev);
+		return;
 	} else if (ver->fcxtrx == 0 && chip->rf_para_ulink_v0) {
 		ul_para_num = chip->rf_para_ulink_num_v0;
 		dl_para_num = chip->rf_para_dlink_num_v0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8646a13bfd79..524b4974040c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3278,6 +3278,7 @@ struct rtw89_btc_fbtc_outsrc_set_info {
 	u8 pta_req_hw_band;
 	u8 rf_gbt_source;
 	u8 bt_enable_state;
+	u8 wl_btg_standby_chg;
 } __packed;
 
 union rtw89_btc_fbtc_slot_u {
-- 
2.25.1


