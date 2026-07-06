Return-Path: <linux-wireless+bounces-38648-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zsg5FVcZS2qWLwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38648-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 04:56:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E6870C397
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 04:56:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=kSyvfx0n;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38648-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38648-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742BD3009161
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 02:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD7385D7A;
	Mon,  6 Jul 2026 02:56:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C7384CFD
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 02:56:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306574; cv=none; b=SLRr1UxHKLL3lXvWPNRFTgP5wx4Cgyn2NNqlE4ksx1nBhOPi7DiTriwBwiA4CwqBsisbleYqwliOjA2iWgnSWtTCHbBOQcIYwJ0kIE/5Ly1HX9Gm9t8NRmvDV03DYkJt7D03fiThW5Jevbf/LOHCrANz8vR9ZnprQfCNEOHo65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306574; c=relaxed/simple;
	bh=mUzERasbuwqmHvycKg/KacbA0m5Td633/VPPH5OdW5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoOxTJx42o8rA1HJweyDElmNN2lOht10rxyhhXRu32bcl18sX5vYVTM41N1Ch+3/SZrYFHMfptRNH3YGACm0Ref9Gt34EUVJN5AiENkxnKzHeGbzAgP3tZhnaYy6qhbOI5FB6rrnUA3XatDUCes8qhYgaAzcEtsbebDHozUTKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kSyvfx0n; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6662uAV11120556, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783306571; bh=OIuCJh6mCaJS6znCNi0YYIaOjf0oqyCsMt+xlbN43Vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=kSyvfx0nMu+iJESRzpyIbH3PFv8MEJvrtcdPQp5y+t8FEV2hPg68v6e+dBauYADjH
	 HAiM8dMBhQwCZipI8Eh6YCFpMJCnw4vsQKM1gHHvwNEUwXUTAe43pLx5UGX7ukrd2U
	 LEgdDxNYN0GU6j7LiqbRidR4Cven1L4PLkT4SgMx3ZoC+/rN+H+O7J3LMGBcIC++mX
	 l8hokLh5glMVQKHKX9hM5rgbhfbqKnFCyL1ijO+uGVV49bk+vTYcBc+zODfAtgtofh
	 gsI8yh2G21IDHmeL6V6oHqlmj6ASCXPOE8eXBc3Fc43x6L7UrmjVwO1DBNQ2b9++Ox
	 XkSfegn8vUrDg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6662uAV11120556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jul 2026 10:56:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Jul 2026 10:56:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Jul 2026 10:56:09 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Jul 2026 10:56:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next v2 5/9] wifi: rtw89: coex: Add Bluetooth binding for Bluetooth RX gain setting
Date: Mon, 6 Jul 2026 10:54:41 +0800
Message-ID: <20260706025445.18428-6-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-38648-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7E6870C397

From: Ching-Te Ku <ku920601@realtek.com>

Dual Bluetooth the each of Bluetooth may use different RX gain by their
condition.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 86 ++++++++++++++++++-----
 1 file changed, 68 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 2080253559a7..ff3c05101ab3 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -730,6 +730,7 @@ enum btc_w2b_scoreboard {
 	BTC_WSCB_SCAN = BIT(2),
 	BTC_WSCB_UNDERTEST = BIT(3),
 	BTC_WSCB_RXGAIN = BIT(4),
+	BTC_WSCB_5GHICH = BIT(6),
 	BTC_WSCB_WLBUSY = BIT(7),
 	BTC_WSCB_EXTFEM = BIT(8),
 	BTC_WSCB_TDMA = BIT(9),
@@ -738,6 +739,9 @@ enum btc_w2b_scoreboard {
 	BTC_WSCB_RXSCAN_PRI = BIT(12),
 	BTC_WSCB_BT_HILNA = BIT(13),
 	BTC_WSCB_BTLOG = BIT(14),
+	BTC_WSCB_CTCODE = BIT(15),
+	BTC_WSCB_RXGAIN_56G = BIT(16),
+	BTC_WSCB_BT_HILNA_56G = BIT(17),
 	BTC_WSCB_ALL = GENMASK(23, 0),
 };
 
@@ -3224,33 +3228,79 @@ static void _set_bt_tx_power(struct rtw89_dev *rtwdev, bool force_exec, u8 bid,
 }
 
 #define BTC_BT_RX_NORMAL_LVL 7
-
-static void _set_bt_rx_gain(struct rtw89_dev *rtwdev, u8 level)
+static void _set_bt_rx_gain(struct rtw89_dev *rtwdev, bool force_exec, u8 bid,
+			    u8 rf_band, u8 level)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_bt_info *bt = &cx->bt0;
+	u8 h2c_func = SET_BT_LNA_CONSTRAIN;
+	u8 i, id_start, id_stop;
+	bool state = false;
+	u32 scbd_bit = 0;
+	u8 buf[2] = {};
+	u8 len = sizeof(*buf);
 
-	if (bt->bcnt[BTC_BCNT_INFOUPDATE] == 0)
+	if (bt->bcnt[BTC_BCNT_INFOUPDATE] == 0 || !rf_band)
 		return;
 
-	if ((bt->rf_para.rx_gain_freerun == level ||
-	     level > BTC_BT_RX_NORMAL_LVL) &&
-	    (!rtwdev->chip->scbd || bt->lna_constrain == level))
+	if (bt->rf_para.rx_gain_freerun == level ||
+	    level > BTC_BT_RX_NORMAL_LVL || !rtwdev->chip->scbd ||
+	    bid > BTC_ALL_BT)
 		return;
 
-	bt->rf_para.rx_gain_freerun = level;
-	btc->dm.rf_trx_para.bt_rx_gain[BTC_BT_1ST] = level;
-
-	rtw89_debug(rtwdev, RTW89_DBG_BTC,
-		    "[BTC], %s(): level = %d\n",
-		    __func__, level);
+	if (bid == BTC_ALL_BT) {
+		id_start = BTC_BT_1ST;
+		id_stop = BTC_BT_2ND;
+	} else {
+		id_start = bid;
+		id_stop = bid;
+	}
 
-	if (level == BTC_BT_RX_NORMAL_LVL)
-		_write_scbd(rtwdev, BTC_WSCB_RXGAIN, false);
+	if (rf_band == RTW89_BAND_2G)
+		scbd_bit |= BTC_WSCB_RXGAIN;
 	else
-		_write_scbd(rtwdev, BTC_WSCB_RXGAIN, true);
+		scbd_bit |= BTC_WSCB_RXGAIN_56G;
+
+	for (i = id_start; i <= id_stop; i++) {
+		if (i == BTC_BT_2ND) {
+			if (!(rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT))
+				continue;
+
+			bt = &cx->bt1;
+			h2c_func |= BT_H2C_FUNC_BT2ND;
+		}
+
+		/* return if same setup */
+		if (!force_exec && !btc->cli_h2c_cmd) {
+			if (rf_band == RTW89_BAND_2G &&
+			    bt->lna_constrain == level)
+				continue;
+			else if (rf_band != RTW89_BAND_2G &&
+				 bt->lna_constrain_6g == level)
+				continue;
+		}
+
+		buf[0] = level;
+		buf[1] = rf_band;
+
+		if (rtwdev->chip->chip_gen == RTW89_CHIP_AX)
+			len = SET_RF_PARA_AX_LEN;
+
+		if (_send_fw_cmd(rtwdev, BTFC_SET, h2c_func, buf, len)) {
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s(): bt%d_rx_gain_level = %d\n",
+				    __func__, i, level);
+		}
+
+		btc->dm.rf_trx_para.bt_rx_gain[i] = level;
+
+		if (buf[0] != BTC_BT_RX_NORMAL_LVL)
+			state = true;
+
+		_write_scbd(rtwdev, scbd_bit, state);
+	}
 
-	_send_fw_cmd(rtwdev, BTFC_SET, SET_BT_LNA_CONSTRAIN, &level, sizeof(level));
 }
 
 static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
@@ -3361,7 +3411,7 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 		_set_wl_tx_power(rtwdev, para.wl_tx_power[RTW89_PHY_0], RTW89_PHY_0);
 		_set_wl_rx_gain(rtwdev, para.wl_rx_gain[RTW89_PHY_0], RTW89_PHY_0);
 		_set_bt_tx_power(rtwdev, true, bid, rf_band, para.bt_tx_power[BTC_BT_1ST]);
-		_set_bt_rx_gain(rtwdev, para.bt_rx_gain[BTC_BT_1ST]);
+		_set_bt_rx_gain(rtwdev, true, bid, rf_band, para.bt_rx_gain[BTC_BT_1ST]);
 	}
 
 next:
-- 
2.25.1


