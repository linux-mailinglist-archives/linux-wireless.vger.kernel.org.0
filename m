Return-Path: <linux-wireless+bounces-38579-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UWc5DpijR2rucgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38579-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 13:57:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6F770216A
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 13:57:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=EoCQJ45w;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38579-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38579-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35BF1305811D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C33C9ED5;
	Fri,  3 Jul 2026 11:43:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39B3C8716
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 11:43:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079022; cv=none; b=EZi7ZIxI7OD1trN4LC+ezxNA2luudmyuTaAepbFlfI8YxXsSJ7HfC+KIYZfbCK8jqIsNBIWlFdvRygXsgckrNXOsHJIrhsAPYGcm9zxHVFFGGXAD1a3eZEse3jex8gm84GGAlLwEJXiehNCb5vaIIVebIJ3UfdlnCSmtwD1S1i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079022; c=relaxed/simple;
	bh=mUzERasbuwqmHvycKg/KacbA0m5Td633/VPPH5OdW5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYWz5hXxOKxati8Ty80pqyhK2vNMfAhm2RCfzsgDSpIOZw87ZgJxhShL+q+2pKqw/P5XsD/7s+nrrlGRwnLzgN0pGJemGAGbVmPc5uA2TUXyuw/Y9+9w5Et8VAbJh9QJCcpa3N+DOmlwnbvx8LQUPXzf9rGm1DbgP+Z9zla9XYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EoCQJ45w; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 663Bhc8R32637634, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783079018; bh=OIuCJh6mCaJS6znCNi0YYIaOjf0oqyCsMt+xlbN43Vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EoCQJ45wiQjjJwMWc8UcmvXyFDNf2U9aCszCIzhCkgV02uYMlM4Zy57R7lrOBPYXA
	 N4EVn8zbcpuOmZw06lBZA+jftCiHFD9Zfgr9LwshANA6zefHRYkVLuYNQ7yfcvk5SB
	 xzvTfEjq/MAq84NamWPgzQkVaIFBURjk+1cbMS0LJt//hMEXvi03swF/M9HgdDs/oq
	 Vc3nzjXPRa5cVh2n7unGmrkxSIVm9+BE6w4Zzfzyg42Y0k2WGU6YwV1FZqISyrloDU
	 ky/dWioKCcB74I2u3uxIdYY9oJQZBnB9vh2bZdZ6pAW8zuXxYc/vspzZnd5sczLQBa
	 4pMDebaRnq4HQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 663Bhc8R32637634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 19:43:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 19:43:38 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 19:43:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 5/9] wifi: rtw89: coex: Add Bluetooth binding for Bluetooth RX gain setting
Date: Fri, 3 Jul 2026 19:43:07 +0800
Message-ID: <20260703114311.2609942-6-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38579-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A6F770216A

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


