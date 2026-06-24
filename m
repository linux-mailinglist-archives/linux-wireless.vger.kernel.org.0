Return-Path: <linux-wireless+bounces-38039-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dXLiJ9lRO2p5WAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38039-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B8E6BB24E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=fxeJcb5p;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38039-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38039-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B50DE3014245
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 03:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DB9246788;
	Wed, 24 Jun 2026 03:41:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE7730C161
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:41:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272470; cv=none; b=kZzDJcWaNLDBcHphH1kGeuJy0u8OC2jdf11GYJvfmEUUNWMruWwnSjt0yXku3kpZ5bjwNaPqd+8ghfwt7rGYeI/8XfaS2xI/10SsTPhyrl9gfefVmzmrwsYKbEVVOOLAIsJi0+htpKcbEz2GpJoqUzcnsWhLos7nFfbJA2/IOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272470; c=relaxed/simple;
	bh=kd5l7D4THQSpZBB79L69cHnVqw/js2z5cqQqOmvBc7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdrrbV2Dgb1+RVUb3xvzwpntfrZfVtpf6djBlqq3e3GtbvHK6Jad/3NZzIeUQlphMg9qRkQHXHcAoeJgGpNpzDR3b4vzqjXuPMSvdcW/+1usVNZ0jOgN1d+tZ5dhd/0IOWjEuK1n8fO+MPEXYyLzzgu0k2Td4quGQW8NdKNAxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fxeJcb5p; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65O3f6FD13888951, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782272466; bh=fv8nbJ8We5JufL+Oh/vqSYYRpsyaw5RGJWl2sQTXIJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=fxeJcb5pnVLOdgSbw0egS6+8hpvJ+1enj5NahE2Zo3x1Fpgje8f+HGHb1AHeCooWL
	 M++2qH2YdtRcW9n/guZueBMse9XCJ96+Aw5XVjVnJH36Lv+7fPcHj41ooQ7SY+29U2
	 w6/NwSibmjgX4q31Hbv45lRLW4L3f6pTBMTu2CEFhrfObK4dcdxLr6InkWa6UCV8RZ
	 wEy7REztomyvwHIYgX8TuVdLir355hMCmXh/dvw7OzzO9NRh4YkaTJYiHpI0xgkolf
	 kd6zIIVYFySCCPvPK0hZ/lKYe4tUxbtl3iPL/CH04tNUADHo5XGFkdgVeqi21nDSi8
	 +j1aZbPPcUwpA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65O3f6FD13888951
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 11:41:06 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:41:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:41:07 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Jun 2026 11:41:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 08/10] wifi: rtw89: coex: Renaming drvinfo_type to drvinfo_ver
Date: Wed, 24 Jun 2026 11:39:39 +0800
Message-ID: <20260624033941.45918-9-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-38039-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42B8E6BB24E

From: Ching-Te Ku <ku920601@realtek.com>

It's more closing to the original meaning. It is defined for rearranging
driver info index by firmware support version.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 84 +++++++++++------------
 drivers/net/wireless/realtek/rtw89/core.h |  2 +-
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index dd9d6cbc2943..572eed7939e1 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -138,7 +138,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
-	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
+	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_ver = 1, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 8,
 	 .fcxtrx = 0,
 	},
@@ -147,7 +147,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
-	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
+	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_ver = 1, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 8,
 	 .fcxtrx = 0,
 	},
@@ -156,7 +156,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 8,   .frptmap = 4,    .fcxctrl = 7,  .fcxinit = 7,
-	 .fwevntrptl = 1, .fwc2hfunc = 3, .drvinfo_type = 2, .info_buf = 1800,
+	 .fwevntrptl = 1, .fwc2hfunc = 3, .drvinfo_ver = 2, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,   .bt_desired = 9,
 	 .fcxtrx = 7,
 	},
@@ -165,7 +165,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 8,   .frptmap = 4,    .fcxctrl = 7,  .fcxinit = 7,
-	 .fwevntrptl = 1, .fwc2hfunc = 3, .drvinfo_type = 2, .info_buf = 1800,
+	 .fwevntrptl = 1, .fwc2hfunc = 3, .drvinfo_ver = 2, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,   .bt_desired = 9,
 	 .fcxtrx = 0,
 	},
@@ -174,7 +174,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 8,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
-	 .fwevntrptl = 1, .fwc2hfunc = 1, .drvinfo_type = 1, .info_buf = 1800,
+	 .fwevntrptl = 1, .fwc2hfunc = 1, .drvinfo_ver = 1, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	 .fcxtrx = 0,
 	},
@@ -183,7 +183,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_ver = 0, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	 .fcxtrx = 0,
 	},
@@ -192,7 +192,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_ver = 0, .info_buf = 1280,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	 .fcxtrx = 0,
 	},
@@ -201,7 +201,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_ver = 0, .info_buf = 1280,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	 .fcxtrx = 0,
 	},
@@ -210,7 +210,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_ver = 0, .info_buf = 1280,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	 .fcxtrx = 0,
 	},
@@ -219,7 +219,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
-	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
+	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_ver = 1, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 8,
 	 .fcxtrx = 0,
 	},
@@ -228,7 +228,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_ver = 0, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	 .fcxtrx = 0,
 	},
@@ -237,7 +237,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_ver = 0, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	 .fcxtrx = 0,
 	},
@@ -246,7 +246,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 1,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_ver = 0, .info_buf = 1280,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	 .fcxtrx = 0,
 	},
@@ -255,7 +255,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .fwc2hfunc = 0, .drvinfo_type = 0, .info_buf = 1280,
+	 .fwevntrptl = 0, .fwc2hfunc = 0, .drvinfo_ver = 0, .info_buf = 1280,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	 .fcxtrx = 0,
 	},
@@ -264,7 +264,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 2,   .fcxnullsta = 1, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
-	 .fwevntrptl = 0, .fwc2hfunc = 0, .drvinfo_type = 0, .info_buf = 1024,
+	 .fwevntrptl = 0, .fwc2hfunc = 0, .drvinfo_ver = 0, .info_buf = 1024,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	 .fcxtrx = 0,
 	},
@@ -275,7 +275,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 2,   .fcxnullsta = 1, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
-	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1024,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_ver = 0, .info_buf = 1024,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
 	 .fcxtrx = 0,
 	},
@@ -2789,62 +2789,62 @@ static void _fw_set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 		rtw89_set_coex_ctrl_lps(rtwdev, btc->lps);
 }
 
-static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
+static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 index)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 
-	switch (type) {
+	switch (index) {
 	case CXDRVINFO_INIT:
 		if (ver->fcxinit == 7)
-			rtw89_fw_h2c_cxdrv_init_v7(rtwdev, type);
+			rtw89_fw_h2c_cxdrv_init_v7(rtwdev, index);
 		else
-			rtw89_fw_h2c_cxdrv_init(rtwdev, type);
+			rtw89_fw_h2c_cxdrv_init(rtwdev, index);
 		break;
 	case CXDRVINFO_ROLE:
 		if (ver->fwlrole == 0)
-			rtw89_fw_h2c_cxdrv_role(rtwdev, type);
+			rtw89_fw_h2c_cxdrv_role(rtwdev, index);
 		else if (ver->fwlrole == 1)
-			rtw89_fw_h2c_cxdrv_role_v1(rtwdev, type);
+			rtw89_fw_h2c_cxdrv_role_v1(rtwdev, index);
 		else if (ver->fwlrole == 2)
-			rtw89_fw_h2c_cxdrv_role_v2(rtwdev, type);
+			rtw89_fw_h2c_cxdrv_role_v2(rtwdev, index);
 		else if (ver->fwlrole == 7)
-			rtw89_fw_h2c_cxdrv_role_v7(rtwdev, type);
+			rtw89_fw_h2c_cxdrv_role_v7(rtwdev, index);
 		else if (ver->fwlrole == 8)
-			rtw89_fw_h2c_cxdrv_role_v8(rtwdev, type);
+			rtw89_fw_h2c_cxdrv_role_v8(rtwdev, index);
 		break;
 	case CXDRVINFO_CTRL:
-		if (ver->drvinfo_type == 1)
-			type = 2;
+		if (ver->drvinfo_ver == 1)
+			index = 2;
 
 		if (ver->fcxctrl == 7)
-			rtw89_fw_h2c_cxdrv_ctrl_v7(rtwdev, type);
+			rtw89_fw_h2c_cxdrv_ctrl_v7(rtwdev, index);
 		else
-			rtw89_fw_h2c_cxdrv_ctrl(rtwdev, type);
+			rtw89_fw_h2c_cxdrv_ctrl(rtwdev, index);
 		break;
 	case CXDRVINFO_TRX:
-		if (ver->drvinfo_type == 1)
-			type = 3;
+		if (ver->drvinfo_ver == 1)
+			index = 3;
 
 		if (ver->fcxtrx == 7)
-			rtw89_fw_h2c_cxdrv_trx_v7(rtwdev, type);
+			rtw89_fw_h2c_cxdrv_trx_v7(rtwdev, index);
 		else if (ver->fcxtrx == 9)
-			rtw89_fw_h2c_cxdrv_trx_v9(rtwdev, type);
+			rtw89_fw_h2c_cxdrv_trx_v9(rtwdev, index);
 		break;
 	case CXDRVINFO_RFK:
-		if (ver->drvinfo_type == 1)
+		if (ver->drvinfo_ver == 1)
 			return;
 
-		rtw89_fw_h2c_cxdrv_rfk(rtwdev, type);
+		rtw89_fw_h2c_cxdrv_rfk(rtwdev, index);
 		break;
 	case CXDRVINFO_TXPWR:
-		if (ver->drvinfo_type == 3)
-			type = 4;
+		if (ver->drvinfo_ver == 3)
+			index = 4;
 
 		if (ver->fcxtrx == 7)
-			rtw89_fw_h2c_cxtxpwr_v7(rtwdev, type);
+			rtw89_fw_h2c_cxtxpwr_v7(rtwdev, index);
 		else if (ver->fcxtrx == 9)
-			rtw89_fw_h2c_cxtxpwr_v9(rtwdev, type);
+			rtw89_fw_h2c_cxtxpwr_v9(rtwdev, index);
 		break;
 	case CXDRVINFO_FDDT:
 	case CXDRVINFO_MLO:
@@ -2852,12 +2852,12 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 		if (!ver->fcxosi)
 			return;
 
-		if (ver->drvinfo_type == 2)
-			type = 7;
+		if (ver->drvinfo_ver == 2)
+			index = 7;
 		else
 			return;
 
-		rtw89_fw_h2c_cxdrv_osi_info(rtwdev, type);
+		rtw89_fw_h2c_cxdrv_osi_info(rtwdev, index);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 70c6ee1a6da2..7a87ffc1931e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3365,7 +3365,7 @@ struct rtw89_btc_ver {
 
 	u8 fwevntrptl;
 	u8 fwc2hfunc;
-	u8 drvinfo_type;
+	u8 drvinfo_ver;
 	u16 info_buf;
 	u8 max_role_num;
 	u8 fcxosi;
-- 
2.25.1


