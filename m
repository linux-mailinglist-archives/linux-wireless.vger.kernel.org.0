Return-Path: <linux-wireless+bounces-38647-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TVSDIE8ZS2qRLwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38647-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 04:56:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A9270C394
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 04:56:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=n2atEixd;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38647-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38647-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DDB83006B5A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 02:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9612B384CFD;
	Mon,  6 Jul 2026 02:56:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6E351C22
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 02:56:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306568; cv=none; b=J8eytLCtAqQikIhk8yvOr9UbdIm1IbFVl+5KSgwsUsa77eBs90l1yTifbE49G4Wx8n/CWnladyzyJAPrxQYqdfTDRWjs0++Uo9xPWxSY1q+gSSbBSGNeKfoVjGjjF3o1sT0AeB+bO9xsTOQo0tBFT9p7GjjE9NijpsoH2HXYBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306568; c=relaxed/simple;
	bh=swFo5GPLxkIrDPMzdT4yq469lA8j/blIQLe9K6cse6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2dw/X9jYUJ5oSSiX+xhDWZVKis2N/5VyXFo7fPjCLqo7Tsu0A5RXBTFnIXO3+bnro1Gxv03pwcJFhIF+YvGShdQftTkgt1PkKOO3oXiipp304zo9/E2uNuMlX+31hOi+6KbL/oyNIpYhJqg+16kG8trBlVTubMU0FkiC79YBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=n2atEixd; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6662u4ptD120520, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783306565; bh=r9I2zHwtd9TdE1u2K5Zpvql/KcVWngBP6eVg6oTPG4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=n2atEixdLAliaEg2n04U0z2FtwAsYQUvt1gHheKTWmRImedD1RpfIOjA6dCyXVwtH
	 SyCjQZ4b6LqCfLZaul5CHZQZ+PK8eBrOHEMOUDNlTDuWw/rREasHls04Pvl2sezDDt
	 i8HmzqbfERW2lHdYQEpjKyGtJ/Xezh273npdCLTpYgRJp5OCMDujsWVzb7QgyvsQUt
	 jTNSHSwBI5fGx7kou+d/Fm2/xMc8dJ0USvekD4wEmUCSTDWGsZOPATyCnOqTKDqqMX
	 iyJXNnN3rns2oE01AxTW25ZtIYBG2qxA+Ua2JokEjbSbCUNq/1lbGezfcxPRuGA3Ju
	 LGGzJy4mVj7BA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6662u4ptD120520
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jul 2026 10:56:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Jul 2026 10:56:03 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Jul 2026 10:56:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next v2 4/9] wifi: rtw89: coex: Add Bluetooth binding for Bluetooth TX power setting
Date: Mon, 6 Jul 2026 10:54:40 +0800
Message-ID: <20260706025445.18428-5-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-38647-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: E1A9270C394

From: Ching-Te Ku <ku920601@realtek.com>

Dual Bluetooth the each of Bluetooth may use different TX power by their
condition.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 65 ++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h | 15 ++++--
 drivers/net/wireless/realtek/rtw89/fw.h   |  3 ++
 3 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 14cc62cf399d..2080253559a7 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3078,6 +3078,7 @@ static void _set_bt_ignore_wlan_act(struct rtw89_dev *rtwdev, u8 enable)
 #define WL_TX_POWER_FRA_PART GENMASK(1, 0)
 #define B_BTC_WL_TX_POWER_SIGN BIT(7)
 #define B_TSSI_WL_TX_POWER_SIGN BIT(8)
+#define SET_RF_PARA_AX_LEN 1
 
 static void _set_wl_tx_power(struct rtw89_dev *rtwdev, u32 level, u8 phy_map)
 {
@@ -3161,28 +3162,64 @@ static void _set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level, u8 phy_map)
 	chip->ops->btc_set_wl_rx_gain(rtwdev, level);
 }
 
-static void _set_bt_tx_power(struct rtw89_dev *rtwdev, u8 level)
+static void _set_bt_tx_power(struct rtw89_dev *rtwdev, bool force_exec, u8 bid,
+			     u8 rf_band, u8 level)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
-	int ret;
-	u8 buf;
+	u8 h2c_func = SET_BT_TX_PWR;
+	u8 i, id_start, id_stop;
+	u8 buf[2] = {};
+	u8 len = sizeof(*buf);
 
-	if (bt->bcnt[BTC_BCNT_INFOUPDATE] == 0)
+	if (bt->bcnt[BTC_BCNT_INFOUPDATE] == 0 || !rf_band)
 		return;
 
 	if (bt->rf_para.tx_pwr_freerun == level)
 		return;
 
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
 
-	buf = (s8)(-level);
-	ret = _send_fw_cmd(rtwdev, BTFC_SET, SET_BT_TX_PWR, &buf, 1);
-	if (!ret) {
-		bt->rf_para.tx_pwr_freerun = level;
-		btc->dm.rf_trx_para.bt_tx_power[BTC_BT_1ST] = level;
+	for (i = id_start; i <= id_stop; i++) {
+		if (i == BTC_BT_2ND) {
+			if (!(rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT))
+				continue;
+
+			bt = &btc->cx.bt1;
+			h2c_func |= BT_H2C_FUNC_BT2ND;
+		}
+
+		buf[0] = (s8)(-level);
+		buf[1] = rf_band;  /* bit-map: bit1->5GHz/6Ghz, bit0->2.4GHz */
+
+		if (!force_exec && !btc->cli_h2c_cmd) {
+			if (rf_band == RTW89_BAND_2G &&
+			    bt->tx_power_now == level)
+				continue;
+			else if (rf_band != RTW89_BAND_2G &&
+				 bt->tx_power_now_6g == level)
+				continue;
+		}
+
+		if (rtwdev->chip->chip_gen == RTW89_CHIP_AX)
+			len = SET_RF_PARA_AX_LEN;
+
+		if (_send_fw_cmd(rtwdev, BTFC_SET, h2c_func, buf, len)) {
+			btc->dm.rf_trx_para.bt_tx_power[i] = level;
+			if (rf_band == RTW89_BAND_2G)
+				bt->tx_power_now = level;
+			else
+				bt->tx_power_now_6g = level;
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s(): bt%d_tx_power_level = %d\n",
+				    __func__, i, level);
+		}
 	}
 }
 
@@ -3229,6 +3266,8 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_rf_trx_para_v9 para;
 	u8 lv, link_mode = 0, i, dbcc_2g_phy = 0;
 	u8 ul_para_num, dl_para_num;
+	u8 rf_band = RTW89_BAND_2G;
+	u8 bid = BTC_BT_1ST;
 	u32 wl_stb_chg = 0;
 
 	if (ver->fwlrole == 0) {
@@ -3321,7 +3360,7 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 	} else {
 		_set_wl_tx_power(rtwdev, para.wl_tx_power[RTW89_PHY_0], RTW89_PHY_0);
 		_set_wl_rx_gain(rtwdev, para.wl_rx_gain[RTW89_PHY_0], RTW89_PHY_0);
-		_set_bt_tx_power(rtwdev, para.bt_tx_power[BTC_BT_1ST]);
+		_set_bt_tx_power(rtwdev, true, bid, rf_band, para.bt_tx_power[BTC_BT_1ST]);
 		_set_bt_rx_gain(rtwdev, para.bt_rx_gain[BTC_BT_1ST]);
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a0f6929873ab..3f77707e2733 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2302,7 +2302,18 @@ struct rtw89_btc_bt_info {
 	u8 raw_info[BTC_BTINFO_MAX]; /* raw bt info from mailbox */
 	u8 txpwr_info[BTC_BTINFO_MAX];
 	u8 rssi_level;
+	u8 rf_band_map;
 	u8 func_type;
+	u8 tx_power_now;
+	u8 tx_power_now_6g;
+
+	u8 fw_ver_mismatch: 1;
+	u8 band_56G_support: 1;
+	u8 hi_lna_rx: 1;
+	u8 lna_constrain: 3;
+	u8 hi_lna_rx_6g: 1;
+	u8 lna_constrain_6g: 3;
+	u8 rsvd: 6;
 
 	u32 scbd;
 	u32 feature;
@@ -2316,11 +2327,9 @@ struct rtw89_btc_bt_info {
 	u32 inq: 1;
 	u32 pag: 1;
 	u32 run_patch_code: 1;
-	u32 hi_lna_rx: 1;
 	u32 scan_rx_low_pri: 1;
 	u32 scan_info_update: 1;
-	u32 lna_constrain: 3;
-	u32 rsvd: 17;
+	u32 rsvd1: 22;
 
 	u32 bcnt[BTC_BCNT_NUM];
 };
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index de8b77de8705..a6f3b28b9e33 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2337,6 +2337,9 @@ struct rtw89_h2c_arp_offload {
 #define RTW89_H2C_ARP_OFFLOAD_W0_PKT_ID GENMASK(31, 24)
 #define RTW89_H2C_ARP_OFFLOAD_W1_CONTENT GENMASK(31, 0)
 
+#define BT_H2C_FUNC_BT2ND 0x80
+#define BT_C2H_FUNC_BT2ND 0x80
+
 enum rtw89_btc_btf_h2c_class {
 	BTFC_SET = 0x10,
 	BTFC_GET = 0x11,
-- 
2.25.1


