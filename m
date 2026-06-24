Return-Path: <linux-wireless+bounces-38034-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0cj9LtZRO2p3WAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38034-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D936BB244
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=RuTvuIjC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38034-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38034-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14735300B76F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 03:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBDD30BBB9;
	Wed, 24 Jun 2026 03:40:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33E330B53A
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:40:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272444; cv=none; b=B4Fq89vSDgE1WdP8o3foneKPCJjnS/tQPJvPDxjO3idDOssf5zOlaE1afCiA40032d7+oiNqKJYRHDG9jajAC5C9RUPFw4cuniYL+3WBS1edbnq+UetGJAfRrpHZXJ8u/GOG0VT1rpYLYYhxyonRC5VP3C/u85n/P5vqzrr5nXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272444; c=relaxed/simple;
	bh=4fvAT3RofCoPxYGIGuejSWGq0RLOF0X//Y04rygnUb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQxscS4W55YE8Q4MuS5bh72Xq4AYxEaGXa6+/Y3ItUn9CYGT9++S4qLK0pKz9d3jnpnns/GHJRKcJs8mjJIkaxMPd1shL+Mp+DIAvE0QO1loBjkmLE5I59Rhko5c++vURTdA3+Gt0mSHLVa2F2YHIs3+uXZo06xKWs5hoL4u+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RuTvuIjC; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65O3ee0K33888831, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782272440; bh=IoXI+tj9u5IVINTe6Ei1hUrunqBorHIsbqQpcyokwrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=RuTvuIjCtmGkiyg5tnu2bGu649B7TBefdp3aUjtRP11lTmHAWSTYIYEsH+qvX9vMv
	 StjKmXfYnMPBUwEhxbEuO2r3c9yCnRFlgswVGSa0zlbr/3dSmf1etcgkyin7Z+7ZCi
	 ksNeQ07nNsay4lkQ8fBC1XfmzStOpqf3sZmhL91rpx9fLFf82qfIWaeL5Fhzxlio6c
	 GRN+/cqKSoLUOQfRZNP4yYb9ln7qhLBej0ToIWh3MVXzRogc20md4i2hOSNfSPc1hA
	 rw3EasU30qyk8sRfh5UwHT9/fTnmZkmq2Dbs51GC7LFEBgENbQSssAgwwDZ7kJmvyU
	 AH4KPlUhWLbeQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65O3ee0K33888831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 11:40:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:40:40 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Jun 2026 11:40:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 03/10] wifi: rtw89: coex: Move wifi related counters to wifi info
Date: Wed, 24 Jun 2026 11:39:34 +0800
Message-ID: <20260624033941.45918-4-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-38034-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38D936BB244

From: Ching-Te Ku <ku920601@realtek.com>

Move wifi related counters to wifi main info, it is to facilitate
the after modification for dual MAC wifi structure.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 80 +++++++++++------------
 drivers/net/wireless/realtek/rtw89/core.h |  2 +-
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index f857ba247c23..e4662e7b74e0 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3411,7 +3411,7 @@ static void _set_bt_afh_info_v0(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): en=%d, ch=%d, bw=%d\n",
 		    __func__, en, ch, bw);
-	btc->cx.cnt_wl[BTC_WCNT_CH_UPDATE]++;
+	wl->wcnt[BTC_WCNT_CH_UPDATE]++;
 }
 
 static void _set_bt_afh_info_v1(struct rtw89_dev *rtwdev)
@@ -3511,7 +3511,7 @@ static void _set_bt_afh_info_v1(struct rtw89_dev *rtwdev)
 			    "[BTC], %s(): en=%d, ch=%d, bw=%d\n",
 			    __func__, en, ch, bw);
 
-		btc->cx.cnt_wl[BTC_WCNT_CH_UPDATE]++;
+		wl->wcnt[BTC_WCNT_CH_UPDATE]++;
 	}
 }
 
@@ -5630,7 +5630,7 @@ static void _action_common(struct rtw89_dev *rtwdev)
 		rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], write scbd: 0x%08x\n",
 			    wl->scbd);
 		wl->scbd_change = false;
-		btc->cx.cnt_wl[BTC_WCNT_SCBDUPDATE]++;
+		wl->wcnt[BTC_WCNT_SCBDUPDATE]++;
 	}
 
 	if (btc->ver->fcxosi) {
@@ -6877,7 +6877,7 @@ static void _update_wl_info_v7(struct rtw89_dev *rtwdev, u8 rid)
 	if (wl_rinfo->dbcc_en != rtwdev->dbcc_en) {
 		wl_rinfo->dbcc_chg = 1;
 		wl_rinfo->dbcc_en = rtwdev->dbcc_en;
-		btc->cx.cnt_wl[BTC_WCNT_DBCC_CHG]++;
+		wl->wcnt[BTC_WCNT_DBCC_CHG]++;
 	}
 
 	if (rtwdev->dbcc_en) {
@@ -7321,7 +7321,7 @@ static void _update_wl_info_v8(struct rtw89_dev *rtwdev, u8 role_id, u8 rlink_id
 
 	if (wl_rinfo->dbcc_en != dbcc_en_ori) {
 		wl->dbcc_chg = true;
-		btc->cx.cnt_wl[BTC_WCNT_DBCC_CHG]++;
+		wl->wcnt[BTC_WCNT_DBCC_CHG]++;
 	}
 }
 
@@ -7378,7 +7378,7 @@ void rtw89_coex_rfk_chk_work(struct wiphy *wiphy, struct wiphy_work *work)
 	if (wl->rfk_info.state != BTC_WRFK_STOP) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): RFK timeout\n", __func__);
-		cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]++;
+		wl->wcnt[BTC_WCNT_RFK_TIMEOUT]++;
 		dm->error.map.wl_rfk_timeout = true;
 		wl->rfk_info.state = BTC_WRFK_STOP;
 		_write_scbd(rtwdev, BTC_WSCB_WLRFK, false);
@@ -7520,13 +7520,13 @@ static bool _chk_wl_rfk_request(struct rtw89_dev *rtwdev)
 
 	_update_bt_scbd(rtwdev, true);
 
-	cx->cnt_wl[BTC_WCNT_RFK_REQ]++;
+	cx->wl.wcnt[BTC_WCNT_RFK_REQ]++;
 
 	if ((bt->rfk_info.map.run || bt->rfk_info.map.req) &&
 	    !bt->rfk_info.map.timeout) {
-		cx->cnt_wl[BTC_WCNT_RFK_REJECT]++;
+		cx->wl.wcnt[BTC_WCNT_RFK_REJECT]++;
 	} else {
-		cx->cnt_wl[BTC_WCNT_RFK_GO]++;
+		cx->wl.wcnt[BTC_WCNT_RFK_GO]++;
 		return true;
 	}
 	return false;
@@ -7934,14 +7934,14 @@ void rtw89_btc_ntfy_specific_packet(struct rtw89_dev *rtwdev,
 
 	switch (pkt_type) {
 	case PACKET_DHCP:
-		cnt = ++cx->cnt_wl[BTC_WCNT_DHCP];
+		cnt = ++wl->wcnt[BTC_WCNT_DHCP];
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): DHCP cnt=%d\n", __func__, cnt);
 		wl->status.map.connecting = true;
 		delay_work = true;
 		break;
 	case PACKET_EAPOL:
-		cnt = ++cx->cnt_wl[BTC_WCNT_EAPOL];
+		cnt = ++wl->wcnt[BTC_WCNT_EAPOL];
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): EAPOL cnt=%d\n", __func__, cnt);
 		wl->status.map._4way = true;
@@ -7950,7 +7950,7 @@ void rtw89_btc_ntfy_specific_packet(struct rtw89_dev *rtwdev,
 			delay /= 2;
 		break;
 	case PACKET_EAPOL_END:
-		cnt = ++cx->cnt_wl[BTC_WCNT_EAPOL];
+		cnt = ++wl->wcnt[BTC_WCNT_EAPOL];
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): EAPOL_End cnt=%d\n",
 			    __func__, cnt);
@@ -7958,7 +7958,7 @@ void rtw89_btc_ntfy_specific_packet(struct rtw89_dev *rtwdev,
 		wiphy_delayed_work_cancel(rtwdev->hw->wiphy, &rtwdev->coex_act1_work);
 		break;
 	case PACKET_ARP:
-		cnt = ++cx->cnt_wl[BTC_WCNT_ARP];
+		cnt = ++wl->wcnt[BTC_WCNT_ARP];
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): ARP cnt=%d\n", __func__, cnt);
 		return;
@@ -10913,7 +10913,7 @@ static int _show_mreg_v1(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	p += scnprintf(p, end - p,
 		       " %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)\n",
 		       "[scoreboard]", wl->scbd,
-		       cx->cnt_wl[BTC_WCNT_SCBDUPDATE],
+		       wl->wcnt[BTC_WCNT_SCBDUPDATE],
 		       bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
 		       cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
 
@@ -10998,7 +10998,7 @@ static int _show_mreg_v2(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	p += scnprintf(p, end - p,
 		       " %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)\n",
 		       "[scoreboard]", wl->scbd,
-		       cx->cnt_wl[BTC_WCNT_SCBDUPDATE],
+		       wl->wcnt[BTC_WCNT_SCBDUPDATE],
 		       bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
 		       cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
 
@@ -11083,7 +11083,7 @@ static int _show_mreg_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	p += scnprintf(p, end - p,
 		       "\n\r %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)",
 		       "[scoreboard]", wl->scbd,
-		       cx->cnt_wl[BTC_WCNT_SCBDUPDATE],
+		       wl->wcnt[BTC_WCNT_SCBDUPDATE],
 		       bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
 		       cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
 
@@ -11189,10 +11189,10 @@ static int _show_summary_v1(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 		p += scnprintf(p, end - p,
 			       " %-15s : wl_rfk[req:%d/go:%d/reject:%d/timeout:%d]",
-			       "[RFK]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
-			       cx->cnt_wl[BTC_WCNT_RFK_GO],
-			       cx->cnt_wl[BTC_WCNT_RFK_REJECT],
-			       cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
+			       "[RFK]", wl->wcnt[BTC_WCNT_RFK_REQ],
+			       wl->wcnt[BTC_WCNT_RFK_GO],
+			       wl->wcnt[BTC_WCNT_RFK_REJECT],
+			       wl->wcnt[BTC_WCNT_RFK_TIMEOUT]);
 
 		p += scnprintf(p, end - p,
 			       ", bt_rfk[req:%d/go:%d/reject:%d/timeout:%d/fail:%d]\n",
@@ -11304,10 +11304,10 @@ static int _show_summary_v4(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 		p += scnprintf(p, end - p,
 			       " %-15s : wl_rfk[req:%d/go:%d/reject:%d/timeout:%d]",
-			       "[RFK]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
-			       cx->cnt_wl[BTC_WCNT_RFK_GO],
-			       cx->cnt_wl[BTC_WCNT_RFK_REJECT],
-			       cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
+			       "[RFK]", wl->wcnt[BTC_WCNT_RFK_REQ],
+			       wl->wcnt[BTC_WCNT_RFK_GO],
+			       wl->wcnt[BTC_WCNT_RFK_REJECT],
+			       wl->wcnt[BTC_WCNT_RFK_TIMEOUT]);
 
 		p += scnprintf(p, end - p,
 			       ", bt_rfk[req:%d/go:%d/reject:%d/timeout:%d/fail:%d]\n",
@@ -11418,10 +11418,10 @@ static int _show_summary_v5(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 		p += scnprintf(p, end - p,
 			       " %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d]",
-			       "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
-			       cx->cnt_wl[BTC_WCNT_RFK_GO],
-			       cx->cnt_wl[BTC_WCNT_RFK_REJECT],
-			       cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
+			       "[RFK/LPS]", wl->wcnt[BTC_WCNT_RFK_REQ],
+			       wl->wcnt[BTC_WCNT_RFK_GO],
+			       wl->wcnt[BTC_WCNT_RFK_REJECT],
+			       wl->wcnt[BTC_WCNT_RFK_TIMEOUT]);
 
 		p += scnprintf(p, end - p,
 			       ", bt_rfk[req:%d]",
@@ -11539,10 +11539,10 @@ static int _show_summary_v105(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 		p += scnprintf(p, end - p,
 			       " %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d]",
-			       "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
-			       cx->cnt_wl[BTC_WCNT_RFK_GO],
-			       cx->cnt_wl[BTC_WCNT_RFK_REJECT],
-			       cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
+			       "[RFK/LPS]", wl->wcnt[BTC_WCNT_RFK_REQ],
+			       wl->wcnt[BTC_WCNT_RFK_GO],
+			       wl->wcnt[BTC_WCNT_RFK_REJECT],
+			       wl->wcnt[BTC_WCNT_RFK_TIMEOUT]);
 
 		p += scnprintf(p, end - p,
 			       ", bt_rfk[req:%d]",
@@ -11664,10 +11664,10 @@ static int _show_summary_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 		p += scnprintf(p, end - p,
 			       "\n\r %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d/time:%dms]",
-			       "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
-			       cx->cnt_wl[BTC_WCNT_RFK_GO],
-			       cx->cnt_wl[BTC_WCNT_RFK_REJECT],
-			       cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT],
+			       "[RFK/LPS]", wl->wcnt[BTC_WCNT_RFK_REQ],
+			       wl->wcnt[BTC_WCNT_RFK_GO],
+			       wl->wcnt[BTC_WCNT_RFK_REJECT],
+			       wl->wcnt[BTC_WCNT_RFK_TIMEOUT],
 			       wl->rfk_info.proc_time);
 
 		p += scnprintf(p, end - p, ", bt_rfk[req:%d]",
@@ -11777,10 +11777,10 @@ static int _show_summary_v8(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 
 		p += scnprintf(p, end - p,
 			       "\n\r %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d/time:%dms]",
-			       "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
-			       cx->cnt_wl[BTC_WCNT_RFK_GO],
-			       cx->cnt_wl[BTC_WCNT_RFK_REJECT],
-			       cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT],
+			       "[RFK/LPS]", wl->wcnt[BTC_WCNT_RFK_REQ],
+			       wl->wcnt[BTC_WCNT_RFK_GO],
+			       wl->wcnt[BTC_WCNT_RFK_REJECT],
+			       wl->wcnt[BTC_WCNT_RFK_TIMEOUT],
 			       wl->rfk_info.proc_time);
 
 		p += scnprintf(p, end - p, ", bt_rfk[req:%d]",
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2f12252bc26e..0abbde6a2013 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2078,6 +2078,7 @@ struct rtw89_btc_wl_info {
 	bool link_mode_chg;
 	bool dbcc_chg;
 	u32 scbd;
+	u32 wcnt[BTC_WCNT_NUM];
 };
 
 struct rtw89_btc_module {
@@ -2267,7 +2268,6 @@ struct rtw89_btc_cx {
 	struct rtw89_btc_3rdcx_info other;
 	u32 state_map;
 	u32 cnt_bt[BTC_BCNT_NUM];
-	u32 cnt_wl[BTC_WCNT_NUM];
 };
 
 struct rtw89_btc_fbtc_tdma {
-- 
2.25.1


