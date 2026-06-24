Return-Path: <linux-wireless+bounces-38036-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +KMdIOdRO2p8WAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38036-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D126BB25B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=CAnulnSw;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38036-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38036-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 300973012BDA
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 03:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AED830BB91;
	Wed, 24 Jun 2026 03:40:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690330B53A
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:40:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272455; cv=none; b=MHUvpz1dUZbI/mdY3x1IXJTUGQtIh91TRodY20yRMWplVqbyXIT0MN91OcITT9PenyB/f+QUZ0cQ7TjP7jlv/cLeJkCTNd3ud+NPS9pYYd1h4Xjg98BqYctj8vIVE800U2IcaBvFMNk9jMJFdDnC2JU34T50ulSMIIdGChmBMXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272455; c=relaxed/simple;
	bh=I/nC1phAddmmBjtAa8T7LMsRotJaEHhyxxj+SB725Ew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMD+doJuXx7gqSEijFiYJxpODVSTD+2SYSapF60HTd3lRO7Y0AB/hfgF6F/RMO+Emv0iwwmI1Z7AkxU73Y3hUZTHMS264c+xulMcnnS5oTjRUtQrYixwoHfesdGC0duVrM4GWDPb44kdcgbzm/+LdwWFglTcihlHNHVllXPKyxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CAnulnSw; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65O3ep3W33888869, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782272451; bh=rrIL4q23F0jgCUKKV1OiUMK31VPQfJVxaTzCLW35FKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=CAnulnSwO75HTFdnpRkCC6AxOWQMb7UMKexRSDt8MIF+jBNXsFVe3TanX81w0zBjq
	 52meHyyDCkRTnsRTqOTo7uG1CQR1y4F+WmNuTcz8m9I/imVnh6Vqkb8vtxfRI5thoz
	 OzSLvt/5EWK1gpY2+XKMP6p2KMXUPL1RuRdUafEGSCHsLlrcSxKx3+7OudLuWckapn
	 LR79Z9s7L8uSkkhMd61PFYl3llQ6Ti4Q4Bk5BQg/hIvjU/ofmoChfxqA9dg6x3WU8q
	 3dY1EQ2yrvulnX87Irvmys/PvFllgy++KVSxjt8xC/KVOoX+i8bwAy9vrTgjNFqvEM
	 50kk/UCGH0sXg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65O3ep3W33888869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 11:40:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:40:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:40:51 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Jun 2026 11:40:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 05/10] wifi: rtw89: coex: Move Bluetooth related counters to BT info
Date: Wed, 24 Jun 2026 11:39:36 +0800
Message-ID: <20260624033941.45918-6-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38036-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6D126BB25B

From: Ching-Te Ku <ku920601@realtek.com>

In order to support dual Bluetooth chip, move Bluetooth counters to BT
info. Because the two Bluetooth need to collect their own counters.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 163 +++++++++---------
 drivers/net/wireless/realtek/rtw89/core.h     |   3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   8 +-
 3 files changed, 86 insertions(+), 88 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 659028edccfa..8fa51867055b 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1218,7 +1218,7 @@ static void _chk_btc_err(struct rtw89_dev *rtwdev, u8 type, u32 cnt)
 			dm->error.map.slot_no_sync = false;
 		break;
 	case BTC_DCNT_BTTX_HANG:
-		cnt = cx->cnt_bt[BTC_BCNT_LOPRI_TX];
+		cnt = bt->bcnt[BTC_BCNT_LOPRI_TX];
 
 		if (cnt == 0 && bt->link_info.slave_role)
 			dm->cnt_dm[BTC_DCNT_BTTX_HANG]++;
@@ -1231,10 +1231,10 @@ static void _chk_btc_err(struct rtw89_dev *rtwdev, u8 type, u32 cnt)
 			dm->error.map.bt_tx_hang = false;
 		break;
 	case BTC_DCNT_BTCNT_HANG:
-		cnt = cx->cnt_bt[BTC_BCNT_HIPRI_RX] +
-		      cx->cnt_bt[BTC_BCNT_HIPRI_TX] +
-		      cx->cnt_bt[BTC_BCNT_LOPRI_RX] +
-		      cx->cnt_bt[BTC_BCNT_LOPRI_TX];
+		cnt = bt->bcnt[BTC_BCNT_HIPRI_RX] +
+		      bt->bcnt[BTC_BCNT_HIPRI_TX] +
+		      bt->bcnt[BTC_BCNT_LOPRI_RX] +
+		      bt->bcnt[BTC_BCNT_LOPRI_TX];
 
 		if (cnt == 0)
 			dm->cnt_dm[BTC_DCNT_BTCNT_HANG]++;
@@ -1723,7 +1723,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				rtwdev->chip->ops->btc_update_bt_cnt(rtwdev);
 				_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
 
-				btc->cx.cnt_bt[BTC_BCNT_POLUT] =
+				bt->bcnt[BTC_BCNT_POLUT] =
 					rtw89_mac_get_plt_cnt(rtwdev,
 							      RTW89_MAC_0);
 			}
@@ -1738,15 +1738,15 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				memcpy(&dm->gnt.band[i], &prpt->v4.gnt_val[i],
 				       sizeof(dm->gnt.band[i]));
 
-			btc->cx.cnt_bt[BTC_BCNT_HIPRI_TX] =
+			bt->bcnt[BTC_BCNT_HIPRI_TX] =
 				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_HI_TX]);
-			btc->cx.cnt_bt[BTC_BCNT_HIPRI_RX] =
+			bt->bcnt[BTC_BCNT_HIPRI_RX] =
 				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_HI_RX]);
-			btc->cx.cnt_bt[BTC_BCNT_LOPRI_TX] =
+			bt->bcnt[BTC_BCNT_LOPRI_TX] =
 				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_LO_TX]);
-			btc->cx.cnt_bt[BTC_BCNT_LOPRI_RX] =
+			bt->bcnt[BTC_BCNT_LOPRI_RX] =
 				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_LO_RX]);
-			btc->cx.cnt_bt[BTC_BCNT_POLUT] =
+			bt->bcnt[BTC_BCNT_POLUT] =
 				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_POLLUTED]);
 
 			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
@@ -1770,15 +1770,15 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				memcpy(&dm->gnt.band[i], &prpt->v5.gnt_val[i][0],
 				       sizeof(dm->gnt.band[i]));
 
-			btc->cx.cnt_bt[BTC_BCNT_HIPRI_TX] =
+			bt->bcnt[BTC_BCNT_HIPRI_TX] =
 				le16_to_cpu(prpt->v5.bt_cnt[BTC_BCNT_HI_TX]);
-			btc->cx.cnt_bt[BTC_BCNT_HIPRI_RX] =
+			bt->bcnt[BTC_BCNT_HIPRI_RX] =
 				le16_to_cpu(prpt->v5.bt_cnt[BTC_BCNT_HI_RX]);
-			btc->cx.cnt_bt[BTC_BCNT_LOPRI_TX] =
+			bt->bcnt[BTC_BCNT_LOPRI_TX] =
 				le16_to_cpu(prpt->v5.bt_cnt[BTC_BCNT_LO_TX]);
-			btc->cx.cnt_bt[BTC_BCNT_LOPRI_RX] =
+			bt->bcnt[BTC_BCNT_LOPRI_RX] =
 				le16_to_cpu(prpt->v5.bt_cnt[BTC_BCNT_LO_RX]);
-			btc->cx.cnt_bt[BTC_BCNT_POLUT] =
+			bt->bcnt[BTC_BCNT_POLUT] =
 				le16_to_cpu(prpt->v5.bt_cnt[BTC_BCNT_POLLUTED]);
 
 			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
@@ -1797,15 +1797,15 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				memcpy(&dm->gnt.band[i], &prpt->v105.gnt_val[i][0],
 				       sizeof(dm->gnt.band[i]));
 
-			btc->cx.cnt_bt[BTC_BCNT_HIPRI_TX] =
+			bt->bcnt[BTC_BCNT_HIPRI_TX] =
 				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_HI_TX_V105]);
-			btc->cx.cnt_bt[BTC_BCNT_HIPRI_RX] =
+			bt->bcnt[BTC_BCNT_HIPRI_RX] =
 				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_HI_RX_V105]);
-			btc->cx.cnt_bt[BTC_BCNT_LOPRI_TX] =
+			bt->bcnt[BTC_BCNT_LOPRI_TX] =
 				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_LO_TX_V105]);
-			btc->cx.cnt_bt[BTC_BCNT_LOPRI_RX] =
+			bt->bcnt[BTC_BCNT_LOPRI_RX] =
 				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_LO_RX_V105]);
-			btc->cx.cnt_bt[BTC_BCNT_POLUT] =
+			bt->bcnt[BTC_BCNT_POLUT] =
 				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_POLLUTED_V105]);
 
 			_chk_btc_err(rtwdev, BTC_DCNT_BTCNT_HANG, 0);
@@ -1823,21 +1823,21 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				memcpy(&dm->gnt.band[i], &prpt->v7.gnt_val[i][0],
 				       sizeof(dm->gnt.band[i]));
 
-			btc->cx.cnt_bt[BTC_BCNT_HIPRI_TX] =
+			bt->bcnt[BTC_BCNT_HIPRI_TX] =
 				le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_HI_TX_V105]);
-			btc->cx.cnt_bt[BTC_BCNT_HIPRI_RX] =
+			bt->bcnt[BTC_BCNT_HIPRI_RX] =
 				le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_HI_RX_V105]);
-			btc->cx.cnt_bt[BTC_BCNT_LOPRI_TX] =
+			bt->bcnt[BTC_BCNT_LOPRI_TX] =
 				le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_LO_TX_V105]);
-			btc->cx.cnt_bt[BTC_BCNT_LOPRI_RX] =
+			bt->bcnt[BTC_BCNT_LOPRI_RX] =
 				le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_LO_RX_V105]);
 
 			val1 = le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_POLLUTED_V105]);
-			if (val1 > btc->cx.cnt_bt[BTC_BCNT_POLUT_NOW])
-				val1 -= btc->cx.cnt_bt[BTC_BCNT_POLUT_NOW]; /* diff */
+			if (val1 > bt->bcnt[BTC_BCNT_POLUT_NOW])
+				val1 -= bt->bcnt[BTC_BCNT_POLUT_NOW]; /* diff */
 
-			btc->cx.cnt_bt[BTC_BCNT_POLUT_DIFF] = val1;
-			btc->cx.cnt_bt[BTC_BCNT_POLUT_NOW] =
+			bt->bcnt[BTC_BCNT_POLUT_DIFF] = val1;
+			bt->bcnt[BTC_BCNT_POLUT_NOW] =
 				le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_POLLUTED_V105]);
 
 			val1 = pfwinfo->event[BTF_EVNT_RPT];
@@ -1855,21 +1855,21 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				memcpy(&dm->gnt.band[i], &prpt->v8.gnt_val[i][0],
 				       sizeof(dm->gnt.band[i]));
 
-			btc->cx.cnt_bt[BTC_BCNT_HIPRI_TX] =
+			bt->bcnt[BTC_BCNT_HIPRI_TX] =
 				le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_HI_TX_V105]);
-			btc->cx.cnt_bt[BTC_BCNT_HIPRI_RX] =
+			bt->bcnt[BTC_BCNT_HIPRI_RX] =
 				le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_HI_RX_V105]);
-			btc->cx.cnt_bt[BTC_BCNT_LOPRI_TX] =
+			bt->bcnt[BTC_BCNT_LOPRI_TX] =
 				le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_LO_TX_V105]);
-			btc->cx.cnt_bt[BTC_BCNT_LOPRI_RX] =
+			bt->bcnt[BTC_BCNT_LOPRI_RX] =
 				le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_LO_RX_V105]);
 
 			val1 = le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_POLLUTED_V105]);
-			if (val1 > btc->cx.cnt_bt[BTC_BCNT_POLUT_NOW])
-				val1 -= btc->cx.cnt_bt[BTC_BCNT_POLUT_NOW]; /* diff */
+			if (val1 > bt->bcnt[BTC_BCNT_POLUT_NOW])
+				val1 -= bt->bcnt[BTC_BCNT_POLUT_NOW]; /* diff */
 
-			btc->cx.cnt_bt[BTC_BCNT_POLUT_DIFF] = val1;
-			btc->cx.cnt_bt[BTC_BCNT_POLUT_NOW] =
+			bt->bcnt[BTC_BCNT_POLUT_DIFF] = val1;
+			bt->bcnt[BTC_BCNT_POLUT_NOW] =
 				le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_POLLUTED_V105]);
 
 			val1 = pfwinfo->event[BTF_EVNT_RPT];
@@ -3083,7 +3083,7 @@ static void _set_bt_tx_power(struct rtw89_dev *rtwdev, u8 level)
 	int ret;
 	u8 buf;
 
-	if (btc->cx.cnt_bt[BTC_BCNT_INFOUPDATE] == 0)
+	if (bt->bcnt[BTC_BCNT_INFOUPDATE] == 0)
 		return;
 
 	if (bt->rf_para.tx_pwr_freerun == level)
@@ -3108,7 +3108,7 @@ static void _set_bt_rx_gain(struct rtw89_dev *rtwdev, u8 level)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 
-	if (btc->cx.cnt_bt[BTC_BCNT_INFOUPDATE] == 0)
+	if (bt->bcnt[BTC_BCNT_INFOUPDATE] == 0)
 		return;
 
 	if ((bt->rf_para.rx_gain_freerun == level ||
@@ -6059,7 +6059,7 @@ static u32 _read_scbd(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], read scbd: 0x%08x\n",
 		    scbd_val);
 
-	btc->cx.cnt_bt[BTC_BCNT_SCBDREAD]++;
+	btc->cx.bt0.bcnt[BTC_BCNT_SCBDREAD]++;
 	return scbd_val;
 }
 
@@ -7388,18 +7388,16 @@ void rtw89_coex_rfk_chk_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	bool bt_link_change = false, lps_ctrl = false;
 	u32 val, any_bt_connect;
 	u8 mode;
 
-	if (!chip->scbd)
+	if (rtwdev->chip->scbd)
 		return;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s\n", __func__);
@@ -7436,7 +7434,7 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 	/* reset bt info if bt re-enable */
 	if (bt->enable.now && !bt->enable.last) {
 		_reset_btc_var(rtwdev, BTC_RESET_BTINFO);
-		cx->cnt_bt[BTC_BCNT_REENABLE]++;
+		bt->bcnt[BTC_BCNT_REENABLE]++;
 		bt->enable.now = 1;
 	}
 
@@ -8095,7 +8093,7 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): return by bt-info duplicate!!\n",
 			    __func__);
-		cx->cnt_bt[BTC_BCNT_INFOSAME]++;
+		bt->bcnt[BTC_BCNT_INFOSAME]++;
 		return;
 	}
 
@@ -8116,7 +8114,7 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	b->status.map.acl_busy = btinfo.lb2.acl_busy;
 	b->status.map.inq_pag = btinfo.lb2.inq_pag;
 	bt->inq_pag.now = btinfo.lb2.inq_pag;
-	cx->cnt_bt[BTC_BCNT_INQPAG] += !!(bt->inq_pag.now && !bt->inq_pag.last);
+	bt->bcnt[BTC_BCNT_INQPAG] += !!(bt->inq_pag.now && !bt->inq_pag.last);
 
 	hfp->exist = btinfo.lb2.hfp;
 	b->profile_cnt.now += (u8)hfp->exist;
@@ -8131,11 +8129,11 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	/* parse raw info low-Byte3 */
 	btinfo.val = bt->raw_info[BTC_BTINFO_L3];
 	if (btinfo.lb3.retry != 0)
-		cx->cnt_bt[BTC_BCNT_RETRY]++;
+		bt->bcnt[BTC_BCNT_RETRY]++;
 	b->cqddr = btinfo.lb3.cqddr;
-	cx->cnt_bt[BTC_BCNT_INQ] += !!(btinfo.lb3.inq && !bt->inq);
+	bt->bcnt[BTC_BCNT_INQ] += !!(btinfo.lb3.inq && !bt->inq);
 	bt->inq = btinfo.lb3.inq;
-	cx->cnt_bt[BTC_BCNT_PAGE] += !!(btinfo.lb3.pag && !bt->pag);
+	bt->bcnt[BTC_BCNT_PAGE] += !!(btinfo.lb3.pag && !bt->pag);
 	bt->pag = btinfo.lb3.pag;
 
 	b->status.map.mesh_busy = btinfo.lb3.mesh_busy;
@@ -8158,11 +8156,11 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 			hid->type |= BTC_HID_RCU;
 	}
 
-	cx->cnt_bt[BTC_BCNT_REINIT] += !!(btinfo.hb1.reinit && !bt->reinit);
+	bt->bcnt[BTC_BCNT_REINIT] += !!(btinfo.hb1.reinit && !bt->reinit);
 	bt->reinit = btinfo.hb1.reinit;
-	cx->cnt_bt[BTC_BCNT_RELINK] += !!(btinfo.hb1.relink && !b->relink.now);
+	bt->bcnt[BTC_BCNT_RELINK] += !!(btinfo.hb1.relink && !b->relink.now);
 	b->relink.now = btinfo.hb1.relink;
-	cx->cnt_bt[BTC_BCNT_IGNOWL] += !!(btinfo.hb1.igno_wl && !bt->igno_wl);
+	bt->bcnt[BTC_BCNT_IGNOWL] += !!(btinfo.hb1.igno_wl && !bt->igno_wl);
 	bt->igno_wl = btinfo.hb1.igno_wl;
 
 	if (bt->igno_wl && !cx->wl.status.map.rf_off)
@@ -8170,7 +8168,7 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 
 	bt->ble_scan_en = btinfo.hb1.ble_scan;
 
-	cx->cnt_bt[BTC_BCNT_ROLESW] += !!(btinfo.hb1.role_sw && !b->role_sw);
+	bt->bcnt[BTC_BCNT_ROLESW] += !!(btinfo.hb1.role_sw && !b->role_sw);
 	b->role_sw = btinfo.hb1.role_sw;
 
 	b->multi_link.now = btinfo.hb1.multi_link;
@@ -8179,7 +8177,7 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	btinfo.val = bt->raw_info[BTC_BTINFO_H2];
 	pan->active = !!btinfo.hb2.pan_active;
 
-	cx->cnt_bt[BTC_BCNT_AFH] += !!(btinfo.hb2.afh_update && !b->afh_update);
+	bt->bcnt[BTC_BCNT_AFH] += !!(btinfo.hb2.afh_update && !b->afh_update);
 	b->afh_update = btinfo.hb2.afh_update;
 	a2dp->active = btinfo.hb2.a2dp_active;
 	b->slave_role = btinfo.hb2.slave;
@@ -8193,7 +8191,7 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	a2dp->bitpool = btinfo.hb3.a2dp_bitpool;
 
 	if (b->tx_3m != (u32)btinfo.hb3.tx_3m)
-		cx->cnt_bt[BTC_BCNT_RATECHG]++;
+		bt->bcnt[BTC_BCNT_RATECHG]++;
 	b->tx_3m = (u32)btinfo.hb3.tx_3m;
 
 	a2dp->sink = btinfo.hb3.a2dp_sink;
@@ -8785,6 +8783,7 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_bt_info *bt = &rtwdev->btc.cx.bt0;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	u8 *buf = &skb->data[RTW89_C2H_HEADER_LEN];
 
@@ -8812,13 +8811,13 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	case BTF_EVNT_BT_INFO:
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], handle C2H BT INFO with data %8ph\n", buf);
-		btc->cx.cnt_bt[BTC_BCNT_INFOUPDATE]++;
+		bt->bcnt[BTC_BCNT_INFOUPDATE]++;
 		_update_bt_info(rtwdev, buf, len);
 		break;
 	case BTF_EVNT_BT_SCBD:
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], handle C2H BT SCBD with data %8ph\n", buf);
-		btc->cx.cnt_bt[BTC_BCNT_SCBDUPDATE]++;
+		bt->bcnt[BTC_BCNT_SCBDUPDATE]++;
 		_update_bt_scbd(rtwdev, false);
 		break;
 	case BTF_EVNT_BT_PSD:
@@ -8836,7 +8835,7 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		btc->dm.cnt_dm[BTC_DCNT_CX_RUNINFO]++;
 		break;
 	case BTF_EVNT_BT_QUERY_TXPWR:
-		btc->cx.cnt_bt[BTC_BCNT_BTTXPWR_UPDATE]++;
+		bt->bcnt[BTC_BCNT_BTTXPWR_UPDATE]++;
 		_update_bt_txpwr_info(rtwdev, buf, len);
 	}
 }
@@ -9187,17 +9186,17 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 	p += scnprintf(p, end - p,
 		       " %-15s : retry:%d, relink:%d, rate_chg:%d, reinit:%d, reenable:%d, ",
-		       "[stat_cnt]", cx->cnt_bt[BTC_BCNT_RETRY],
-		       cx->cnt_bt[BTC_BCNT_RELINK],
-		       cx->cnt_bt[BTC_BCNT_RATECHG],
-		       cx->cnt_bt[BTC_BCNT_REINIT],
-		       cx->cnt_bt[BTC_BCNT_REENABLE]);
+		       "[stat_cnt]", bt->bcnt[BTC_BCNT_RETRY],
+		       bt->bcnt[BTC_BCNT_RELINK],
+		       bt->bcnt[BTC_BCNT_RATECHG],
+		       bt->bcnt[BTC_BCNT_REINIT],
+		       bt->bcnt[BTC_BCNT_REENABLE]);
 
 	p += scnprintf(p, end - p,
 		       "role-switch:%d, afh:%d, inq_page:%d(inq:%d/page:%d), igno_wl:%d\n",
-		       cx->cnt_bt[BTC_BCNT_ROLESW], cx->cnt_bt[BTC_BCNT_AFH],
-		       cx->cnt_bt[BTC_BCNT_INQPAG], cx->cnt_bt[BTC_BCNT_INQ],
-		       cx->cnt_bt[BTC_BCNT_PAGE], cx->cnt_bt[BTC_BCNT_IGNOWL]);
+		       bt->bcnt[BTC_BCNT_ROLESW], bt->bcnt[BTC_BCNT_AFH],
+		       bt->bcnt[BTC_BCNT_INQPAG], bt->bcnt[BTC_BCNT_INQ],
+		       bt->bcnt[BTC_BCNT_PAGE], bt->bcnt[BTC_BCNT_IGNOWL]);
 
 	p += _show_bt_profile_info(rtwdev, p, end - p);
 
@@ -9207,16 +9206,16 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		       bt->raw_info[4], bt->raw_info[5], bt->raw_info[6],
 		       bt->raw_info[7],
 		       bt->raw_info[0] == BTC_BTINFO_AUTO ? "auto" : "reply",
-		       cx->cnt_bt[BTC_BCNT_INFOUPDATE],
-		       cx->cnt_bt[BTC_BCNT_INFOSAME]);
+		       bt->bcnt[BTC_BCNT_INFOUPDATE],
+		       bt->bcnt[BTC_BCNT_INFOSAME]);
 
 	p += scnprintf(p, end - p,
 		       " %-15s : Hi-rx = %d, Hi-tx = %d, Lo-rx = %d, Lo-tx = %d (bt_polut_wl_tx = %d)",
-		       "[trx_req_cnt]", cx->cnt_bt[BTC_BCNT_HIPRI_RX],
-		       cx->cnt_bt[BTC_BCNT_HIPRI_TX],
-		       cx->cnt_bt[BTC_BCNT_LOPRI_RX],
-		       cx->cnt_bt[BTC_BCNT_LOPRI_TX],
-		       cx->cnt_bt[BTC_BCNT_POLUT]);
+		       "[trx_req_cnt]", bt->bcnt[BTC_BCNT_HIPRI_RX],
+		       bt->bcnt[BTC_BCNT_HIPRI_TX],
+		       bt->bcnt[BTC_BCNT_LOPRI_RX],
+		       bt->bcnt[BTC_BCNT_LOPRI_TX],
+		       bt->bcnt[BTC_BCNT_POLUT]);
 
 	if (!bt->scan_info_update) {
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_SCAN_INFO, true);
@@ -9252,7 +9251,7 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	else
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_TX_PWR_LVL, false);
 
-	if (cx->cnt_bt[BTC_BCNT_BTTXPWR_UPDATE]) {
+	if (bt->bcnt[BTC_BCNT_BTTXPWR_UPDATE]) {
 		p += scnprintf(p, end - p,
 			       " %-15s : br_index:0x%x, le_index:0x%x",
 			       "[bt_txpwr_lvl]",
@@ -10896,7 +10895,6 @@ static int _show_mreg_v1(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_mreg_val_v1 *pmreg = NULL;
-	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_mac_ax_coex_gnt gnt_cfg = {};
@@ -10914,8 +10912,8 @@ static int _show_mreg_v1(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		       " %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)\n",
 		       "[scoreboard]", wl->scbd,
 		       wl->wcnt[BTC_WCNT_SCBDUPDATE],
-		       bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
-		       cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
+		       bt->scbd, bt->bcnt[BTC_BCNT_SCBDREAD],
+		       bt->bcnt[BTC_BCNT_SCBDUPDATE]);
 
 	btc->dm.pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
 	_get_gnt(rtwdev, &gnt_cfg);
@@ -10981,7 +10979,6 @@ static int _show_mreg_v2(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_mreg_val_v2 *pmreg = NULL;
-	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_mac_ax_coex_gnt gnt_cfg = {};
@@ -10999,8 +10996,8 @@ static int _show_mreg_v2(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		       " %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)\n",
 		       "[scoreboard]", wl->scbd,
 		       wl->wcnt[BTC_WCNT_SCBDUPDATE],
-		       bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
-		       cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
+		       bt->scbd, bt->bcnt[BTC_BCNT_SCBDREAD],
+		       bt->bcnt[BTC_BCNT_SCBDUPDATE]);
 
 	btc->dm.pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
 	_get_gnt(rtwdev, &gnt_cfg);
@@ -11084,8 +11081,8 @@ static int _show_mreg_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		       "\n\r %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)",
 		       "[scoreboard]", wl->scbd,
 		       wl->wcnt[BTC_WCNT_SCBDUPDATE],
-		       bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
-		       cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
+		       bt->scbd, bt->bcnt[BTC_BCNT_SCBDREAD],
+		       bt->bcnt[BTC_BCNT_SCBDUPDATE]);
 
 	/* To avoid I/O if WL LPS or power-off  */
 	dm->pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 13fa7f574e91..31ac9fa4282e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2250,6 +2250,8 @@ struct rtw89_btc_bt_info {
 	u32 scan_info_update: 1;
 	u32 lna_constrain: 3;
 	u32 rsvd: 17;
+
+	u32 bcnt[BTC_BCNT_NUM];
 };
 
 struct rtw89_btc_rf_trx_para_v9 {
@@ -2267,7 +2269,6 @@ struct rtw89_btc_cx {
 	struct rtw89_btc_bt_info bt1;
 	struct rtw89_btc_3rdcx_info other;
 	u32 state_map;
-	u32 cnt_bt[BTC_BCNT_NUM];
 };
 
 struct rtw89_btc_fbtc_tdma {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 2c1f166e687f..94027e5b8d28 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2105,12 +2105,12 @@ void rtw8852a_btc_update_bt_cnt(struct rtw89_dev *rtwdev)
 		return;
 
 	val = rtw89_read32(rtwdev, R_AX_BT_STAST_HIGH);
-	cx->cnt_bt[BTC_BCNT_HIPRI_TX] = FIELD_GET(B_AX_STATIS_BT_HI_TX_MASK, val);
-	cx->cnt_bt[BTC_BCNT_HIPRI_RX] = FIELD_GET(B_AX_STATIS_BT_HI_RX_MASK, val);
+	cx->bt0.bcnt[BTC_BCNT_HIPRI_TX] = FIELD_GET(B_AX_STATIS_BT_HI_TX_MASK, val);
+	cx->bt0.bcnt[BTC_BCNT_HIPRI_RX] = FIELD_GET(B_AX_STATIS_BT_HI_RX_MASK, val);
 
 	val = rtw89_read32(rtwdev, R_AX_BT_STAST_LOW);
-	cx->cnt_bt[BTC_BCNT_LOPRI_TX] = FIELD_GET(B_AX_STATIS_BT_LO_TX_1_MASK, val);
-	cx->cnt_bt[BTC_BCNT_LOPRI_RX] = FIELD_GET(B_AX_STATIS_BT_LO_RX_1_MASK, val);
+	cx->bt0.bcnt[BTC_BCNT_LOPRI_TX] = FIELD_GET(B_AX_STATIS_BT_LO_TX_1_MASK, val);
+	cx->bt0.bcnt[BTC_BCNT_LOPRI_RX] = FIELD_GET(B_AX_STATIS_BT_LO_RX_1_MASK, val);
 
 	/* clock-gate off before reset counter*/
 	rtw89_write32_set(rtwdev, R_AX_BTC_CFG, B_AX_DIS_BTC_CLK_G);
-- 
2.25.1


