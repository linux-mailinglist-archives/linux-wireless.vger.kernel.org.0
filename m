Return-Path: <linux-wireless+bounces-38576-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cr8NC8ugR2o4cgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38576-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 13:45:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91923701FA9
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 13:45:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="j/y+g607";
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38576-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38576-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B572F3088CA8
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E7437EFEF;
	Fri,  3 Jul 2026 11:43:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07012386440
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 11:43:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079005; cv=none; b=JIx7UjBhwKFh8OSnM3MSIWhhIomyJmWq4xB1PFhBDrORzfH2oWlGsmaL7LtAu41f2i1GmTnUlTn1NP/bq4jSBYx+430uWz8N8316Ri/vAnc8y17ypzgzwo9vz37j9Ypzrs+ja1uQpdQmCYK6AvqNFIIf03bL98vtmLIWCcLTS7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079005; c=relaxed/simple;
	bh=f/AH01BLk+khu5lzcRjlTDmIS4KZ0QlTHfNiA2lrtck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B23qrPK2imhUNQ1JbmAbj9Ctk2EokX6eqyWvR1uIEJmzntF7VzlG9goYHPjVmAiHvQdEt/ZGYa6eAT2iF8afBXo0/vRRiAXRo8X6USKh7Rxz7d2NZKoDbCR/IxXLDk1ZN0V9TvN0hNsESvk6b0U8ctSCqmZ62kfiSJFdsWWGuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=j/y+g607; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 663BhMdoD2637107, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783079002; bh=fKyCMZEJ/iVBbRUuGXLt+JLhpg7jj4pFQIQAPCkCeY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=j/y+g6079v5/2mESGvlN965GxTjwZ52uueMyoJTUxslFb/6QUViWhzyVGDKqSCBBH
	 RMhKx80DN1eHonRCxKUTMmWEMIJIqQ8D/2w+2dzMIFQ0HnDiSE863VmO+BUcHRQ7N+
	 jwYC8DzVZLgCXm5fsECuAyL2HZC5hu/Sz+wKEY5ehAl0Zx/xevzR5Ib5MFylg0sON/
	 YhmkORCPdI0WS5EuRcqMdW3oi0/63UiN6iEG/bQXpzAL32gBeHB+JpKownc+fdoCDH
	 HxUE19pW8/6/i/eTE2TsynJxXC8IKn7G0jZfAVgaT812IbCrZl+ZuGIxM2zBAJ422X
	 L7aylg9+YW6qg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 663BhMdoD2637107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 19:43:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 19:43:22 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 19:43:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 2/9] wifi: rtw89: coex: add rtw89_btc_init() entry for initialization once
Date: Fri, 3 Jul 2026 19:43:04 +0800
Message-ID: <20260703114311.2609942-3-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-38576-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91923701FA9

From: Ching-Te Ku <ku920601@realtek.com>

Separate these two type of initialize entry. Because Wi-Fi power save
leaving will also call the initializing, but don't have to reset all the
stored variables.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 35 ++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/coex.h |  1 +
 drivers/net/wireless/realtek/rtw89/core.c |  1 +
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 43de238c18f8..196bec751070 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -7858,6 +7858,28 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	_action_common(rtwdev);
 }
 
+void rtw89_btc_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	const struct rtw89_btc_ver *ver = btc->ver;
+
+	rtw89_debug(rtwdev, RTW89_DBG_BTC,
+		    "[BTC], %s(): Init %s !!\n", __func__,
+		    chip_id_str(chip->chip_id));
+
+	_reset_btc_var(rtwdev, BTC_RESET_ALL);
+
+	btc->dm.run_reason = BTC_RSN_NONE;
+	btc->dm.run_action = BTC_ACT_NONE;
+	if (ver->fcxctrl >= 7)
+		btc->ctrl.ctrl_v7.igno_bt = true;
+	else
+		btc->ctrl.ctrl.igno_bt = true;
+	wl->status.map.init_ok = true;
+}
+
 void rtw89_btc_ntfy_poweron(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -7941,19 +7963,6 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_btc_ver *ver = btc->ver;
 
-	rtw89_debug(rtwdev, RTW89_DBG_BTC,
-		    "[BTC], %s(): Init %s !!\n", __func__,
-		    chip_id_str(chip->chip_id));
-
-	_reset_btc_var(rtwdev, BTC_RESET_ALL);
-	btc->dm.run_reason = BTC_RSN_NONE;
-	btc->dm.run_action = BTC_ACT_NONE;
-	if (ver->fcxctrl >= 7)
-		btc->ctrl.ctrl_v7.igno_bt = true;
-	else
-		btc->ctrl.ctrl.igno_bt = true;
-	wl->status.map.init_ok = true;
-
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): mode=%d\n", __func__, mode);
 
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 259c6e2c0e3c..fb151f68eb64 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -272,6 +272,7 @@ enum btc_wl_gpio_debug {
 	BTC_DBG_USER_DEF = 31,
 };
 
+void rtw89_btc_init(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_poweron(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_poweroff(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 26b744dfbcf8..85aeb9e90812 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -7488,6 +7488,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	}
 
 	rtw89_rfkill_polling_init(rtwdev);
+	rtw89_btc_init(rtwdev);
 
 	return 0;
 
-- 
2.25.1


