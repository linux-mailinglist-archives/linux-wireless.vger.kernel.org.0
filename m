Return-Path: <linux-wireless+bounces-38038-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ATuHFtdRO2p4WAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38038-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 787DF6BB245
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="KhMGJ/Yk";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38038-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38038-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31FBD301FD59
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 03:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C706430C177;
	Wed, 24 Jun 2026 03:41:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3230BBB9
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:41:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272467; cv=none; b=iKaKMdkHD7VsZ0rcIoylj+w8AgvFSMb/LWRFQJcGV4Ey6843jfDDkzM0d8IyeNWun/SttAp346A5ZJKaftaoOd0cAYOsESB8AVdgsyTDhhmcw4DPVFT1JhUHG4rrazTeHTymhqXAVc5CrPc58dekZU37mN3LCBoZhGbOKtfe6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272467; c=relaxed/simple;
	bh=u05pUQag4aj9kPMLzsPTjHDDScOFApYknzXjOn2f/+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kr4fFa33PO8hhj1ZQpq5BGyHzEBHTsCr5f4tuyLJfQnzHgFFsZHpZXgSEwfuzB/uCoi84+lujmU3+ujKKw3akaUrVVTaiblTKsMU9vjVOoKdkxkn/b5oojaha01sCCH2+8xM0nZBQY5xKqSdHvvRA/NSidCAVkyC0cc+OfgR9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KhMGJ/Yk; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65O3f1Zm93888920, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782272461; bh=arWgUx8VgfH3Cr0UqHVIe3JmeONJM+ITsVotpS81S+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KhMGJ/YkvkYlpt5sAAwwiFINpA3wQ9X4yBdJmNi7XGT9MlBvmJTDwprQM8YgdxWVs
	 Id5048oDXnV4HomqPUATQXr71bjdoOfizfSGRoL4Y4Ahr8bYg+igjJ1vufLqihsziU
	 LL7ifG0SmTcsnt5btASYyW4poe+ZNcqrzz+NtzKx/l7lwLg5opf7FP2svvV/f0MgwK
	 LQmO/R1jhbqlbZAIzTx8BjbblebYvMTE5rTMOUS9gAdrkd4HKMjVzsS7AFSvW3C7F3
	 weUjQ965yxHAc6ykxr+w+sw+wEBcI0npSkOwh1bftG0UsfVQ8Lmk1UGZGdJXLJISm5
	 TRVsoctote1qg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65O3f1Zm93888920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 11:41:01 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:41:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:41:01 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Jun 2026 11:41:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 07/10] wifi: rtw89: coex: Add TX/RX RF parameter format version 9
Date: Wed, 24 Jun 2026 11:39:38 +0800
Message-ID: <20260624033941.45918-8-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38038-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 787DF6BB245

From: Ching-Te Ku <ku920601@realtek.com>

In order to support external Zigbee/Thread/Bluetooth etc module,
the version 8 add the parameter for the case. And also update the
related configuration function.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 226 ++++++++++------
 drivers/net/wireless/realtek/rtw89/core.h     |  40 +--
 drivers/net/wireless/realtek/rtw89/fw.c       | 252 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h       | 160 +++++------
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  12 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |   4 +
 11 files changed, 511 insertions(+), 243 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 5159338960f3..dd9d6cbc2943 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -140,6 +140,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 8,
+	 .fcxtrx = 0,
 	},
 	{RTL8852BT, RTW89_FW_VER_CODE(0, 29, 90, 0),
 	 .fcxbtcrpt = 7, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
@@ -148,6 +149,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 8,
+	 .fcxtrx = 0,
 	},
 	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 71, 0),
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
@@ -156,6 +158,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 8,   .frptmap = 4,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 3, .drvinfo_type = 2, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,   .bt_desired = 9,
+	 .fcxtrx = 7,
 	},
 	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 63, 0),
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
@@ -164,6 +167,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 8,   .frptmap = 4,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 3, .drvinfo_type = 2, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,   .bt_desired = 9,
+	 .fcxtrx = 0,
 	},
 	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 8, 0),
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
@@ -172,6 +176,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 8,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 1, .drvinfo_type = 1, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
+	 .fcxtrx = 0,
 	},
 	{RTL8851B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 5,
@@ -180,6 +185,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
+	 .fcxtrx = 0,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 57, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -188,6 +194,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
+	 .fcxtrx = 0,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 42, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -196,6 +203,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
+	 .fcxtrx = 0,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -204,6 +212,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
+	 .fcxtrx = 0,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 122, 0),
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
@@ -212,6 +221,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
 	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 8,
+	 .fcxtrx = 0,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,  .fcxslots = 1, .fcxcysta = 5,
@@ -220,6 +230,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
+	 .fcxtrx = 0,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 14, 0),
 	 .fcxbtcrpt = 5, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 4,
@@ -228,6 +239,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
+	 .fcxtrx = 0,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -236,6 +248,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 1,   .frptmap = 1,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
+	 .fcxtrx = 0,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 37, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
@@ -244,6 +257,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 0, .drvinfo_type = 0, .info_buf = 1280,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
+	 .fcxtrx = 0,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 0, 0),
 	 .fcxbtcrpt = 1, .fcxtdma = 1,    .fcxslots = 1, .fcxcysta = 2,
@@ -252,6 +266,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 0, .drvinfo_type = 0, .info_buf = 1024,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
+	 .fcxtrx = 0,
 	},
 
 	/* keep it to be the last as default entry */
@@ -262,6 +277,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
 	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1024,
 	 .max_role_num = 5, .fcxosi = 0,  .fcxmlo = 0,   .bt_desired = 7,
+	 .fcxtrx = 0,
 	},
 };
 
@@ -2777,9 +2793,6 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
-	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_rf_trx_para rf_para = dm->rf_trx_para;
 
 	switch (type) {
 	case CXDRVINFO_INIT:
@@ -2813,17 +2826,10 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 		if (ver->drvinfo_type == 1)
 			type = 3;
 
-		dm->trx_info.tx_power = u32_get_bits(rf_para.wl_tx_power,
-						     RTW89_BTC_WL_DEF_TX_PWR);
-		dm->trx_info.rx_gain = u32_get_bits(rf_para.wl_rx_gain,
-						    RTW89_BTC_WL_DEF_TX_PWR);
-		dm->trx_info.bt_tx_power = u32_get_bits(rf_para.bt_tx_power,
-							RTW89_BTC_WL_DEF_TX_PWR);
-		dm->trx_info.bt_rx_gain = u32_get_bits(rf_para.bt_rx_gain,
-						       RTW89_BTC_WL_DEF_TX_PWR);
-		dm->trx_info.cn = wl->cn_report;
-		dm->trx_info.nhm = wl->nhm.pwr;
-		rtw89_fw_h2c_cxdrv_trx(rtwdev, type);
+		if (ver->fcxtrx == 7)
+			rtw89_fw_h2c_cxdrv_trx_v7(rtwdev, type);
+		else if (ver->fcxtrx == 9)
+			rtw89_fw_h2c_cxdrv_trx_v9(rtwdev, type);
 		break;
 	case CXDRVINFO_RFK:
 		if (ver->drvinfo_type == 1)
@@ -2832,6 +2838,14 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 		rtw89_fw_h2c_cxdrv_rfk(rtwdev, type);
 		break;
 	case CXDRVINFO_TXPWR:
+		if (ver->drvinfo_type == 3)
+			type = 4;
+
+		if (ver->fcxtrx == 7)
+			rtw89_fw_h2c_cxtxpwr_v7(rtwdev, type);
+		else if (ver->fcxtrx == 9)
+			rtw89_fw_h2c_cxtxpwr_v9(rtwdev, type);
+		break;
 	case CXDRVINFO_FDDT:
 	case CXDRVINFO_MLO:
 	case CXDRVINFO_OSI:
@@ -3025,53 +3039,84 @@ static void _set_bt_ignore_wlan_act(struct rtw89_dev *rtwdev, u8 enable)
 #define B_BTC_WL_TX_POWER_SIGN BIT(7)
 #define B_TSSI_WL_TX_POWER_SIGN BIT(8)
 
-static void _set_wl_tx_power(struct rtw89_dev *rtwdev, u32 level)
+static void _set_wl_tx_power(struct rtw89_dev *rtwdev, u32 level, u8 phy_map)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	const struct rtw89_btc_ver *ver = btc->ver;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	bool level_chg = false;
 	u32 pwr_val;
 
-	if (wl->rf_para.tx_pwr_freerun == level)
+	if (phy_map & BIT(RTW89_PHY_0))
+		level_chg = !(dm->rf_trx_para.wl_tx_power[RTW89_PHY_0] == level);
+
+	if (phy_map & BIT(RTW89_PHY_1))
+		level_chg |= !(dm->rf_trx_para.wl_tx_power[RTW89_PHY_1] == level);
+
+	if (!level_chg && !btc->cli_h2c_cmd)
 		return;
 
-	wl->rf_para.tx_pwr_freerun = level;
-	btc->dm.rf_trx_para.wl_tx_power = level;
+	if (phy_map & BIT(RTW89_PHY_0))
+		dm->rf_trx_para.wl_tx_power[RTW89_PHY_0] = level;
 
-	rtw89_debug(rtwdev, RTW89_DBG_BTC,
-		    "[BTC], %s(): level = %d\n",
-		    __func__, level);
+	if (phy_map & BIT(RTW89_PHY_1))
+		dm->rf_trx_para.wl_tx_power[RTW89_PHY_1] = level;
 
-	if (level == RTW89_BTC_WL_DEF_TX_PWR) {
-		pwr_val = WL_TX_POWER_NO_BTC_CTRL;
-	} else { /* only apply "force tx power" */
-		pwr_val = FIELD_PREP(WL_TX_POWER_INT_PART, level);
-		if (pwr_val > RTW89_BTC_WL_DEF_TX_PWR)
-			pwr_val = RTW89_BTC_WL_DEF_TX_PWR;
+	dm->wl_tx_pwr_phy_map = phy_map;
+	rtw89_debug(rtwdev, RTW89_DBG_BTC,
+		    "[BTC], %s(): phy_map=0x%x, wl_tx_pwr-> phy0=%d, phy1=%d\n",
+		    __func__, phy_map,
+		    dm->rf_trx_para.wl_tx_power[RTW89_PHY_0],
+		    dm->rf_trx_para.wl_tx_power[RTW89_PHY_1]);
+
+	if (ver->fcxtrx == 7 && chip->chip_id == RTL8922A) {
+		_fw_set_drv_info(rtwdev, CXDRVINFO_TXPWR);
+	} else if (ver->fcxtrx == 9) {
+		_fw_set_drv_info(rtwdev, CXDRVINFO_TXPWR);
+	} else {
+		if (level == RTW89_BTC_WL_DEF_TX_PWR) {
+			pwr_val = WL_TX_POWER_NO_BTC_CTRL;
+		} else { /* only apply "force tx power" */
+			pwr_val = FIELD_PREP(WL_TX_POWER_INT_PART, level);
+			if (pwr_val > RTW89_BTC_WL_DEF_TX_PWR)
+				pwr_val = RTW89_BTC_WL_DEF_TX_PWR;
 
-		if (level & B_BTC_WL_TX_POWER_SIGN)
-			pwr_val |= B_TSSI_WL_TX_POWER_SIGN;
-		pwr_val |= WL_TX_POWER_WITH_BT;
+			if (level & B_BTC_WL_TX_POWER_SIGN)
+				pwr_val |= B_TSSI_WL_TX_POWER_SIGN;
+			pwr_val |= WL_TX_POWER_WITH_BT;
+		}
+		chip->ops->btc_set_wl_txpwr_ctrl(rtwdev, pwr_val);
 	}
-
-	chip->ops->btc_set_wl_txpwr_ctrl(rtwdev, pwr_val);
 }
 
-static void _set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
+static void _set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level, u8 phy_map)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	bool level_chg = false;
+
+	if (phy_map & BIT(RTW89_PHY_0))
+		level_chg = !(dm->rf_trx_para.wl_rx_gain[RTW89_PHY_0] == level);
 
-	if (wl->rf_para.rx_gain_freerun == level)
+	if (phy_map & BIT(RTW89_PHY_1))
+		level_chg |= !(dm->rf_trx_para.wl_rx_gain[RTW89_PHY_1] == level);
+
+	if (!level_chg && !btc->cli_h2c_cmd)
 		return;
 
-	wl->rf_para.rx_gain_freerun = level;
-	btc->dm.rf_trx_para.wl_rx_gain = level;
+	if (phy_map & BIT(RTW89_PHY_0))
+		dm->rf_trx_para.wl_rx_gain[RTW89_PHY_0] = level;
+
+	if (phy_map & BIT(RTW89_PHY_1))
+		dm->rf_trx_para.wl_rx_gain[RTW89_PHY_1] = level;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
-		    "[BTC], %s(): level = %d\n",
-		    __func__, level);
+		    "[BTC], %s(): phy_map=0x%x, wl_rx_gain-> phy0=%d, phy1=%d\n",
+		    __func__, phy_map,
+		    dm->rf_trx_para.wl_rx_gain[RTW89_PHY_0],
+		    dm->rf_trx_para.wl_rx_gain[RTW89_PHY_1]);
 
 	chip->ops->btc_set_wl_rx_gain(rtwdev, level);
 }
@@ -3097,7 +3142,7 @@ static void _set_bt_tx_power(struct rtw89_dev *rtwdev, u8 level)
 	ret = _send_fw_cmd(rtwdev, BTFC_SET, SET_BT_TX_PWR, &buf, 1);
 	if (!ret) {
 		bt->rf_para.tx_pwr_freerun = level;
-		btc->dm.rf_trx_para.bt_tx_power = level;
+		btc->dm.rf_trx_para.bt_tx_power[BTC_BT_1ST] = level;
 	}
 }
 
@@ -3117,7 +3162,7 @@ static void _set_bt_rx_gain(struct rtw89_dev *rtwdev, u8 level)
 		return;
 
 	bt->rf_para.rx_gain_freerun = level;
-	btc->dm.rf_trx_para.bt_rx_gain = level;
+	btc->dm.rf_trx_para.bt_rx_gain[BTC_BT_1ST] = level;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): level = %d\n",
@@ -3141,9 +3186,10 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_bt_link_info *b = &bt->link_info;
 	struct rtw89_btc_wl_smap *wl_smap = &wl->status.map;
-	struct rtw89_btc_rf_trx_para para;
+	struct rtw89_btc_rf_trx_para_v9 para;
+	u8 lv, link_mode = 0, i, dbcc_2g_phy = 0;
+	u8 ul_para_num, dl_para_num;
 	u32 wl_stb_chg = 0;
-	u8 level_id = 0, link_mode = 0, i, dbcc_2g_phy = 0;
 
 	if (ver->fwlrole == 0) {
 		link_mode = wl->role_info.link_mode;
@@ -3159,6 +3205,18 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 		dbcc_2g_phy = wl->role_info_v2.dbcc_2g_phy;
 	}
 
+	if (ver->fcxtrx == 9 && chip->rf_para_ulink_v9) {
+		ul_para_num = chip->rf_para_ulink_num_v9;
+		dl_para_num = chip->rf_para_dlink_num_v9;
+	} else if (ver->fcxtrx == 0 && chip->rf_para_ulink_v0) {
+		ul_para_num = chip->rf_para_ulink_num_v0;
+		dl_para_num = chip->rf_para_dlink_num_v0;
+	} else {
+		rtw89_warn(rtwdev, "[BTC]%s(), No rf_para for verseion %d\n",
+			   __func__, ver->fcxtrx);
+		goto next;
+	}
+
 	/* decide trx_para_level */
 	if (btc->ant_type == BTC_ANT_SHARED) {
 		/* fix LNA2 + TIA gain not change by GNT_BT */
@@ -3180,30 +3238,54 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 		}
 	}
 
-	level_id = dm->trx_para_level;
-	if (level_id >= chip->rf_para_dlink_num ||
-	    level_id >= chip->rf_para_ulink_num) {
+	lv = dm->trx_para_level;
+	if (lv >= ul_para_num ||
+	    lv >= dl_para_num) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): invalid level_id: %d\n",
-			    __func__, level_id);
+			    __func__, lv);
 		return;
 	}
 
-	if (wl->status.map.traffic_dir & BIT(RTW89_TFC_UL))
-		para = chip->rf_para_ulink[level_id];
-	else
-		para = chip->rf_para_dlink[level_id];
+	if (wl->status.map.traffic_dir & BIT(RTW89_TFC_UL)) {
+		if (ver->fcxtrx == 9) {
+			para = chip->rf_para_ulink_v9[lv];
+		} else {
+			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++) {
+				para.wl_tx_power[i] = chip->rf_para_ulink_v0[lv].wl_tx_power;
+				para.wl_rx_gain[i] = chip->rf_para_ulink_v0[lv].wl_rx_gain;
+			}
+			for (i = BTC_BT_1ST; i < BTC_ALL_BT; i++) {
+				para.bt_tx_power[i] = chip->rf_para_ulink_v0[lv].bt_tx_power;
+				para.bt_rx_gain[i] = chip->rf_para_ulink_v0[lv].bt_rx_gain;
+			}
+		}
+	} else {
+		if (ver->fcxtrx == 9) {
+			para = chip->rf_para_dlink_v9[lv];
+		} else {
+			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++) {
+				para.wl_tx_power[i] = chip->rf_para_dlink_v0[lv].wl_tx_power;
+				para.wl_rx_gain[i] = chip->rf_para_dlink_v0[lv].wl_rx_gain;
+			}
+			for (i = BTC_BT_1ST; i < BTC_ALL_BT; i++) {
+				para.bt_tx_power[i] = chip->rf_para_dlink_v0[lv].bt_tx_power;
+				para.bt_rx_gain[i] = chip->rf_para_dlink_v0[lv].bt_rx_gain;
+			}
+		}
+	}
 
 	if (dm->fddt_train) {
-		_set_wl_rx_gain(rtwdev, 1);
+		_set_wl_rx_gain(rtwdev, 1, RTW89_PHY_0);
 		_write_scbd(rtwdev, BTC_WSCB_RXGAIN, true);
 	} else {
-		_set_wl_tx_power(rtwdev, para.wl_tx_power);
-		_set_wl_rx_gain(rtwdev, para.wl_rx_gain);
-		_set_bt_tx_power(rtwdev, para.bt_tx_power);
-		_set_bt_rx_gain(rtwdev, para.bt_rx_gain);
+		_set_wl_tx_power(rtwdev, para.wl_tx_power[RTW89_PHY_0], RTW89_PHY_0);
+		_set_wl_rx_gain(rtwdev, para.wl_rx_gain[RTW89_PHY_0], RTW89_PHY_0);
+		_set_bt_tx_power(rtwdev, para.bt_tx_power[BTC_BT_1ST]);
+		_set_bt_rx_gain(rtwdev, para.bt_rx_gain[BTC_BT_1ST]);
 	}
 
+next:
 	if (!bt->enable.now || dm->wl_only || wl_smap->rf_off ||
 	    wl_smap->lps == BTC_LPS_RF_OFF ||
 	    link_mode == BTC_WLINK_5G ||
@@ -7836,7 +7918,7 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 	}
 
 	_set_init_info(rtwdev);
-	_set_wl_tx_power(rtwdev, RTW89_BTC_WL_DEF_TX_PWR);
+	_set_wl_tx_power(rtwdev, RTW89_BTC_WL_DEF_TX_PWR, RTW89_PHY_0);
 	btc_fw_set_monreg(rtwdev);
 	rtw89_btc_fw_set_slots(rtwdev);
 	_fw_set_drv_info(rtwdev, CXDRVINFO_INIT);
@@ -9669,25 +9751,19 @@ static int _show_dm_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		       (dm->wl_fw_cx_offload == BTC_CX_FW_OFFLOAD ?
 			"" : "(Mismatch!!)"));
 
-	if (dm->rf_trx_para.wl_tx_power == 0xff)
-		p += scnprintf(p, end - p,
-			       " %-15s : wl_rssi_lvl:%d, para_lvl:%d, wl_tx_pwr:orig, ",
-			       "[trx_ctrl]", wl->rssi_level,
-			       dm->trx_para_level);
-
-	else
-		p += scnprintf(p, end - p,
-			       " %-15s : wl_rssi_lvl:%d, para_lvl:%d, wl_tx_pwr:%d, ",
-			       "[trx_ctrl]", wl->rssi_level,
-			       dm->trx_para_level,
-			       dm->rf_trx_para.wl_tx_power);
+	p += scnprintf(p, end - p,
+		       " %-15s : wl[rssi_lvl:%d/para:%d/tx_pwr:[%d %d]/rx_lvl:[%d %d]/lna2:%d/stb_chg:%d]\n ",
+		       "[dm_rf_ctrl]",
+		       wl->rssi_level, dm->trx_para_level,
+		       dm->rf_trx_para.wl_tx_power[RTW89_PHY_0],
+		       dm->rf_trx_para.wl_tx_power[RTW89_PHY_1],
+		       dm->rf_trx_para.wl_rx_gain[RTW89_PHY_0],
+		       dm->rf_trx_para.wl_rx_gain[RTW89_PHY_1],
+		       dm->wl_lna2, dm->wl_stb_chg);
 
 	p += scnprintf(p, end - p,
-		       "wl_rx_lvl:%d, bt_tx_pwr_dec:%d, bt_rx_lna:%d(%s-tbl), wl_btg_rx:%d\n",
-		       dm->rf_trx_para.wl_rx_gain,
-		       dm->rf_trx_para.bt_tx_power,
-		       dm->rf_trx_para.bt_rx_gain,
-		       (bt->hi_lna_rx ? "Hi" : "Ori"), dm->wl_btg_rx);
+		       " %-15s : pre_agc:%d, btg_rx:%d\n ",
+		       "[dm_bb_ctrl]", dm->wl_pre_agc, dm->wl_btg_rx);
 
 	p += scnprintf(p, end - p,
 		       " %-15s : wl_tx_limit[en:%d/max_t:%dus/max_retry:%d], bt_slot_reg:%d-TU, bt_scan_rx_low_pri:%d\n",
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2366894bf609..70c6ee1a6da2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2275,6 +2275,14 @@ struct rtw89_btc_bt_info {
 	u32 bcnt[BTC_BCNT_NUM];
 };
 
+#define RTW89_BTC_WL_DEF_TX_PWR GENMASK(7, 0)
+struct rtw89_btc_rf_trx_para_v0 {
+	u32 wl_tx_power; /* absolute Tx power (dBm), 0xff-> no BTC control */
+	u32 wl_rx_gain;  /* rx gain table index (TBD.) */
+	u8 bt_tx_power; /* decrease Tx power (dB) */
+	u8 bt_rx_gain;  /* LNA constrain level */
+};
+
 struct rtw89_btc_rf_trx_para_v9 {
 	u32 wl_tx_power[RTW89_PHY_NUM]; /* absolute Tx power (dBm), 1's complement -5->0x85 */
 	u32 wl_rx_gain[RTW89_PHY_NUM]; /* rx gain table index (TBD.) */
@@ -2289,6 +2297,7 @@ struct rtw89_btc_cx {
 	struct rtw89_btc_bt_info bt0;
 	struct rtw89_btc_bt_info bt1;
 	struct rtw89_btc_extsoc_info bt_ext;
+	struct rtw89_btc_rf_trx_para_v9 rf_para;
 	u32 state_map;
 };
 
@@ -3068,24 +3077,18 @@ struct rtw89_btc_fbtc_btdevinfo {
 	__le32 flush_time;
 } __packed;
 
-#define RTW89_BTC_WL_DEF_TX_PWR GENMASK(7, 0)
-struct rtw89_btc_rf_trx_para {
-	u32 wl_tx_power; /* absolute Tx power (dBm), 0xff-> no BTC control */
-	u32 wl_rx_gain;  /* rx gain table index (TBD.) */
-	u8 bt_tx_power; /* decrease Tx power (dB) */
-	u8 bt_rx_gain;  /* LNA constrain level */
-};
-
 struct rtw89_btc_trx_info {
 	u8 tx_lvl;
 	u8 rx_lvl;
 	u8 wl_rssi;
 	u8 bt_rssi;
 
-	s8 tx_power; /* absolute Tx power (dBm), 0xff-> no BTC control */
-	s8 rx_gain;  /* rx gain table index (TBD.) */
-	s8 bt_tx_power; /* decrease Tx power (dB) */
-	s8 bt_rx_gain;  /* LNA constrain level */
+	s8 wl_tx_power[RTW89_PHY_NUM]; /* absolute Tx power (dBm), 0xff-> no BTC control */
+	s8 wl_rx_gain[RTW89_PHY_NUM];  /* rx gain table index (TBD.) */
+	s8 bt_tx_power[BTC_ALL_BT]; /* decrease Tx power (dB) */
+	s8 bt_rx_gain[BTC_ALL_BT];  /* LNA constrain level */
+	s8 zb_tx_power[BTC_ALL_BT];
+	s8 zb_rx_gain[BTC_ALL_BT];
 
 	u8 cn; /* condition_num */
 	s8 nhm;
@@ -3132,7 +3135,7 @@ struct rtw89_btc_dm {
 	struct rtw89_btc_fbtc_tdma tdma_now;
 	struct rtw89_mac_ax_coex_gnt gnt;
 	union rtw89_btc_init_info_u init_info; /* pass to wl_fw if offload */
-	struct rtw89_btc_rf_trx_para rf_trx_para;
+	struct rtw89_btc_rf_trx_para_v9 rf_trx_para;
 	struct rtw89_btc_wl_tx_limit_para wl_tx_limit;
 	struct rtw89_btc_dm_step dm_step;
 	struct rtw89_btc_wl_scc_ctrl wl_scc;
@@ -3169,6 +3172,7 @@ struct rtw89_btc_dm {
 
 	u8 run_reason;
 	u8 run_action;
+	u8 wl_tx_pwr_phy_map;
 
 	u8 wl_pre_agc: 2;
 	u8 wl_lna2: 1;
@@ -3367,6 +3371,7 @@ struct rtw89_btc_ver {
 	u8 fcxosi;
 	u8 fcxmlo;
 	u8 bt_desired;
+	u8 fcxtrx;
 };
 
 struct rtw89_btc_btf_fwinfo {
@@ -3424,6 +3429,7 @@ struct rtw89_btc {
 	bool update_policy_force;
 	bool lps;
 	bool manual_ctrl;
+	bool cli_h2c_cmd;
 };
 
 enum rtw89_btc_hmsg {
@@ -4772,10 +4778,10 @@ struct rtw89_chip_info {
 
 	u8 mon_reg_num;
 	const struct rtw89_btc_fbtc_mreg *mon_reg;
-	u8 rf_para_ulink_num;
-	const struct rtw89_btc_rf_trx_para *rf_para_ulink;
-	u8 rf_para_dlink_num;
-	const struct rtw89_btc_rf_trx_para *rf_para_dlink;
+	const struct rtw89_btc_rf_trx_para_v0 *rf_para_ulink_v0;
+	const struct rtw89_btc_rf_trx_para_v0 *rf_para_dlink_v0;
+	u8 rf_para_ulink_num_v0;
+	u8 rf_para_dlink_num_v0;
 	const struct rtw89_btc_rf_trx_para_v9 *rf_para_ulink_v9;
 	const struct rtw89_btc_rf_trx_para_v9 *rf_para_dlink_v9;
 	u8 rf_para_ulink_num_v9;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d6a594b75ab2..804ae2a1130d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6303,48 +6303,158 @@ int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type)
 	return ret;
 }
 
-#define H2C_LEN_CXDRVINFO_TRX (28 + H2C_LEN_CXDRVHDR)
-int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev, u8 type)
+int rtw89_fw_h2c_cxdrv_trx_v7(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_rf_trx_para_v9 rf_para = btc->dm.rf_trx_para;
 	struct rtw89_btc_trx_info *trx = &btc->dm.trx_info;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_h2c_cxtrx_v7 *h2c;
+	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
-	u8 *cmd;
 	int ret;
+	u8 i;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_CXDRVINFO_TRX);
+	for (i = 0; i < RTW89_PHY_NUM; i++) {
+		trx->wl_tx_power[i] = u32_get_bits(rf_para.wl_tx_power[i],
+						   RTW89_BTC_WL_DEF_TX_PWR);
+		trx->wl_rx_gain[i] = u32_get_bits(rf_para.wl_rx_gain[i],
+						  RTW89_BTC_WL_DEF_TX_PWR);
+	}
+	for (i = 0; i < BTC_ALL_BT; i++) {
+		trx->bt_tx_power[i] = u32_get_bits(rf_para.bt_tx_power[i],
+						   RTW89_BTC_WL_DEF_TX_PWR);
+		trx->bt_rx_gain[i] = u32_get_bits(rf_para.bt_rx_gain[i],
+						  RTW89_BTC_WL_DEF_TX_PWR);
+		trx->zb_tx_power[i] = u32_get_bits(rf_para.zb_tx_power[i],
+						   RTW89_BTC_WL_DEF_TX_PWR);
+		trx->zb_rx_gain[i] = u32_get_bits(rf_para.zb_rx_gain[i],
+						  RTW89_BTC_WL_DEF_TX_PWR);
+	}
+	trx->cn = wl->cn_report;
+	trx->nhm = wl->nhm.pwr;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
-		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_trx\n");
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxtrx_v9\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_LEN_CXDRVINFO_TRX);
-	cmd = skb->data;
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxtrx_v7 *)skb->data;
 
-	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, type);
-	RTW89_SET_FWCMD_CXHDR_LEN(cmd, H2C_LEN_CXDRVINFO_TRX - H2C_LEN_CXDRVHDR);
-
-	RTW89_SET_FWCMD_CXTRX_TXLV(cmd, trx->tx_lvl);
-	RTW89_SET_FWCMD_CXTRX_RXLV(cmd, trx->rx_lvl);
-	RTW89_SET_FWCMD_CXTRX_WLRSSI(cmd, trx->wl_rssi);
-	RTW89_SET_FWCMD_CXTRX_BTRSSI(cmd, trx->bt_rssi);
-	RTW89_SET_FWCMD_CXTRX_TXPWR(cmd, trx->tx_power);
-	RTW89_SET_FWCMD_CXTRX_RXGAIN(cmd, trx->rx_gain);
-	RTW89_SET_FWCMD_CXTRX_BTTXPWR(cmd, trx->bt_tx_power);
-	RTW89_SET_FWCMD_CXTRX_BTRXGAIN(cmd, trx->bt_rx_gain);
-	RTW89_SET_FWCMD_CXTRX_CN(cmd, trx->cn);
-	RTW89_SET_FWCMD_CXTRX_NHM(cmd, trx->nhm);
-	RTW89_SET_FWCMD_CXTRX_BTPROFILE(cmd, trx->bt_profile);
-	RTW89_SET_FWCMD_CXTRX_RSVD2(cmd, trx->rsvd2);
-	RTW89_SET_FWCMD_CXTRX_TXRATE(cmd, trx->tx_rate);
-	RTW89_SET_FWCMD_CXTRX_RXRATE(cmd, trx->rx_rate);
-	RTW89_SET_FWCMD_CXTRX_TXTP(cmd, trx->tx_tp);
-	RTW89_SET_FWCMD_CXTRX_RXTP(cmd, trx->rx_tp);
-	RTW89_SET_FWCMD_CXTRX_RXERRRA(cmd, trx->rx_err_ratio);
+	h2c->hdr.type = type;
+	h2c->hdr.ver = btc->ver->fcxtrx;
+	h2c->hdr.len = sizeof(*h2c) - H2C_LEN_CXDRVHDR_V7;
+
+	h2c->v7_u8.tx_lvl = trx->tx_lvl;
+	h2c->v7_u8.rx_lvl = trx->rx_lvl;
+	h2c->v7_u8.wl_rssi = trx->wl_rssi;
+	h2c->v7_u8.bt_rssi = trx->bt_rssi;
+	h2c->v7_u8.wl_tx_power = trx->wl_tx_power[RTW89_PHY_0];
+	h2c->v7_u8.wl_rx_gain = trx->wl_rx_gain[RTW89_PHY_0];
+	h2c->v7_u8.bt_tx_power = trx->bt_tx_power[BTC_BT_1ST];
+	h2c->v7_u8.bt_rx_gain = trx->bt_rx_gain[BTC_BT_1ST];
+	h2c->v7_u8.zb_tx_power = trx->zb_tx_power[BTC_BT_1ST];
+	h2c->v7_u8.zb_rx_gain = trx->zb_rx_gain[BTC_BT_1ST];
+	h2c->v7_u8.cn = trx->cn;
+	h2c->v7_u8.nhm = trx->nhm;
+	h2c->v7_u8.bt_profile = trx->bt_profile;
+	h2c->v7_u8.rsvd2 = trx->rsvd2;
+	h2c->v7_le.tx_rate = cpu_to_le16(trx->tx_rate);
+	h2c->v7_le.rx_rate = cpu_to_le16(trx->rx_rate);
+	h2c->v7_le.tx_tp = cpu_to_le32(trx->tx_tp);
+	h2c->v7_le.rx_tp = cpu_to_le32(trx->rx_tp);
+	h2c->v7_le.rx_err_ratio = cpu_to_le32(trx->rx_err_ratio);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, BTFC_SET,
-			      SET_DRV_INFO, 0, 0,
-			      H2C_LEN_CXDRVINFO_TRX);
+			      SET_DRV_INFO, 0, 0, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+int rtw89_fw_h2c_cxdrv_trx_v9(struct rtw89_dev *rtwdev, u8 type)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_rf_trx_para_v9 rf_para = btc->dm.rf_trx_para;
+	struct rtw89_btc_trx_info *trx = &btc->dm.trx_info;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_h2c_cxtrx_v9 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+	u8 i;
+
+	for (i = 0; i < RTW89_PHY_NUM; i++) {
+		trx->wl_tx_power[i] = u32_get_bits(rf_para.wl_tx_power[i],
+						   RTW89_BTC_WL_DEF_TX_PWR);
+		trx->wl_rx_gain[i] = u32_get_bits(rf_para.wl_rx_gain[i],
+						  RTW89_BTC_WL_DEF_TX_PWR);
+	}
+	for (i = 0; i < BTC_ALL_BT; i++) {
+		trx->bt_tx_power[i] = u32_get_bits(rf_para.bt_tx_power[i],
+						   RTW89_BTC_WL_DEF_TX_PWR);
+		trx->bt_rx_gain[i] = u32_get_bits(rf_para.bt_rx_gain[i],
+						  RTW89_BTC_WL_DEF_TX_PWR);
+		trx->zb_tx_power[i] = u32_get_bits(rf_para.zb_tx_power[i],
+						   RTW89_BTC_WL_DEF_TX_PWR);
+		trx->zb_rx_gain[i] = u32_get_bits(rf_para.zb_rx_gain[i],
+						  RTW89_BTC_WL_DEF_TX_PWR);
+	}
+	trx->cn = wl->cn_report;
+	trx->nhm = wl->nhm.pwr;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxtrx_v9\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxtrx_v9 *)skb->data;
+
+	h2c->hdr.type = type;
+	h2c->hdr.ver = btc->ver->fcxtrx;
+	h2c->hdr.len = sizeof(*h2c) - H2C_LEN_CXDRVHDR_V7;
+
+	h2c->v9_u8.tx_lvl = trx->tx_lvl;
+	h2c->v9_u8.rx_lvl = trx->rx_lvl;
+	h2c->v9_u8.wl_rssi = trx->wl_rssi;
+	h2c->v9_u8.bt_rssi = trx->bt_rssi;
+
+	for (i = 0; i < RTW89_PHY_NUM; i++) {
+		h2c->v9_u8.wl_tx_power[i] = trx->wl_tx_power[i];
+		h2c->v9_u8.wl_rx_gain[i] = trx->wl_rx_gain[i];
+	}
+
+	for (i = 0; i < BTC_ALL_BT; i++) {
+		h2c->v9_u8.bt_tx_power[i] = trx->bt_tx_power[i];
+		h2c->v9_u8.bt_rx_gain[i] = trx->bt_rx_gain[i];
+		h2c->v9_u8.zb_tx_power[i] = trx->zb_tx_power[i];
+		h2c->v9_u8.zb_rx_gain[i] = trx->zb_rx_gain[i];
+	}
+	h2c->v9_u8.cn = trx->cn;
+	h2c->v9_u8.nhm = trx->nhm;
+	h2c->v9_u8.bt_profile = trx->bt_profile;
+	h2c->v9_u8.rsvd2 = trx->rsvd2;
+	h2c->v9_le.tx_rate = cpu_to_le16(trx->tx_rate);
+	h2c->v9_le.rx_rate = cpu_to_le16(trx->rx_rate);
+	h2c->v9_le.tx_tp = cpu_to_le32(trx->tx_tp);
+	h2c->v9_le.rx_tp = cpu_to_le32(trx->rx_tp);
+	h2c->v9_le.rx_err_ratio = cpu_to_le32(trx->rx_err_ratio);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, BTFC_SET,
+			      SET_DRV_INFO, 0, 0, len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
@@ -6404,6 +6514,90 @@ int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev, u8 type)
 	return ret;
 }
 
+int rtw89_fw_h2c_cxtxpwr_v7(struct rtw89_dev *rtwdev, u8 type)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_rf_trx_para_v9 rp = dm->rf_trx_para;
+	struct rtw89_h2c_cxtxpwr_v7 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_ctrl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxtxpwr_v7 *)skb->data;
+
+	h2c->hdr.type = type;
+	h2c->hdr.ver = btc->ver->fcxtrx;
+	h2c->hdr.len = sizeof(*h2c) - H2C_LEN_CXDRVHDR_V7;
+	h2c->pwr = rp.wl_tx_power[RTW89_PHY_0] & 0xff;
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, BTFC_SET,
+			      SET_DRV_INFO, 0, 0, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+int rtw89_fw_h2c_cxtxpwr_v9(struct rtw89_dev *rtwdev, u8 type)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_rf_trx_para_v9 rp = dm->rf_trx_para;
+	struct rtw89_h2c_cxtxpwr_v9 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_ctrl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxtxpwr_v9 *)skb->data;
+
+	h2c->hdr.type = type;
+	h2c->hdr.ver = btc->ver->fcxtrx;
+	h2c->hdr.len = sizeof(*h2c) - H2C_LEN_CXDRVHDR_V7;
+	if (dm->wl_tx_pwr_phy_map == BIT(RTW89_PHY_1))
+		h2c->pwr = rp.wl_tx_power[RTW89_PHY_1] & 0xff;
+	else
+		h2c->pwr = rp.wl_tx_power[RTW89_PHY_0] & 0xff;
+	h2c->band = dm->wl_tx_pwr_phy_map;
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, BTFC_SET,
+			      SET_DRV_INFO, 0, 0, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 #define H2C_LEN_PKT_OFLD 4
 int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 20721d5209aa..36c8430a2e7a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2499,6 +2499,76 @@ struct rtw89_h2c_cxinit {
 	u8 rsvd1;
 } __packed;
 
+struct rtw89_btc_trx_info_u8 {
+	u8 tx_lvl;
+	u8 rx_lvl;
+	u8 wl_rssi;
+	u8 bt_rssi;
+
+	s8 wl_tx_power[RTW89_PHY_NUM]; /* absolute Tx power (dBm), 0xff-> no BTC control */
+	s8 wl_rx_gain[RTW89_PHY_NUM];  /* rx gain table index (TBD.) */
+	s8 bt_tx_power[BTC_ALL_BT]; /* decrease Tx power (dB) */
+	s8 bt_rx_gain[BTC_ALL_BT];  /* LNA constrain level */
+	s8 zb_tx_power[BTC_ALL_BT];
+	s8 zb_rx_gain[BTC_ALL_BT];
+
+	u8 cn; /* condition_num */
+	s8 nhm;
+	u8 bt_profile;
+	u8 rsvd2;
+} __packed;
+
+struct rtw89_btc_trx_info_v7_u8 {
+	u8 tx_lvl;
+	u8 rx_lvl;
+	u8 wl_rssi;
+	u8 bt_rssi;
+
+	s8 wl_tx_power;
+	s8 wl_rx_gain;
+	s8 bt_tx_power;
+	s8 bt_rx_gain;
+	s8 zb_tx_power;
+	s8 zb_rx_gain;
+
+	u8 cn;
+	s8 nhm;
+	u8 bt_profile;
+	u8 rsvd2;
+} __packed;
+
+struct rtw89_btc_trx_info_le {
+	__le16 tx_rate;
+	__le16 rx_rate;
+
+	__le32 tx_tp;
+	__le32 rx_tp;
+	__le32 rx_err_ratio;
+} __packed;
+
+struct rtw89_h2c_cxtrx_v9 {
+	struct rtw89_h2c_cxhdr_v7 hdr;
+	struct rtw89_btc_trx_info_u8 v9_u8;
+	struct rtw89_btc_trx_info_le v9_le;
+} __packed;
+
+struct rtw89_h2c_cxtrx_v7 {
+	struct rtw89_h2c_cxhdr_v7 hdr;
+	struct rtw89_btc_trx_info_v7_u8 v7_u8;
+	struct rtw89_btc_trx_info_le v7_le;
+} __packed;
+
+struct rtw89_h2c_cxtxpwr_v7 {
+	struct rtw89_h2c_cxhdr_v7 hdr;
+	u8 pwr;
+} __packed;
+
+struct rtw89_h2c_cxtxpwr_v9 {
+	struct rtw89_h2c_cxhdr_v7 hdr;
+	u8 pwr;
+	u8 band;
+} __packed;
+
 #define RTW89_H2C_CXINIT_ANT_INFO_POS BIT(0)
 #define RTW89_H2C_CXINIT_ANT_INFO_DIVERSITY BIT(1)
 #define RTW89_H2C_CXINIT_ANT_INFO_BTG_POS GENMASK(3, 2)
@@ -2760,91 +2830,6 @@ static inline void RTW89_SET_FWCMD_CXCTRL_TRACE_STEP(void *cmd, u32 val)
 	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(18, 3));
 }
 
-static inline void RTW89_SET_FWCMD_CXTRX_TXLV(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)cmd + 2, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_RXLV(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)cmd + 3, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_WLRSSI(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)cmd + 4, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_BTRSSI(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)cmd + 5, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_TXPWR(void *cmd, s8 val)
-{
-	u8p_replace_bits((u8 *)cmd + 6, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_RXGAIN(void *cmd, s8 val)
-{
-	u8p_replace_bits((u8 *)cmd + 7, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_BTTXPWR(void *cmd, s8 val)
-{
-	u8p_replace_bits((u8 *)cmd + 8, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_BTRXGAIN(void *cmd, s8 val)
-{
-	u8p_replace_bits((u8 *)cmd + 9, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_CN(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)cmd + 10, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_NHM(void *cmd, s8 val)
-{
-	u8p_replace_bits((u8 *)cmd + 11, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_BTPROFILE(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)cmd + 12, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_RSVD2(void *cmd, u8 val)
-{
-	u8p_replace_bits((u8 *)cmd + 13, val, GENMASK(7, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_TXRATE(void *cmd, u16 val)
-{
-	le16p_replace_bits((__le16 *)((u8 *)cmd + 14), val, GENMASK(15, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_RXRATE(void *cmd, u16 val)
-{
-	le16p_replace_bits((__le16 *)((u8 *)cmd + 16), val, GENMASK(15, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_TXTP(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)cmd + 18), val, GENMASK(31, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_RXTP(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)cmd + 22), val, GENMASK(31, 0));
-}
-
-static inline void RTW89_SET_FWCMD_CXTRX_RXERRRA(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)((u8 *)cmd + 26), val, GENMASK(31, 0));
-}
-
 static inline void RTW89_SET_FWCMD_CXRFK_STATE(void *cmd, u32 val)
 {
 	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(1, 0));
@@ -5399,8 +5384,11 @@ int rtw89_fw_h2c_cxdrv_role_v8(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_osi_info(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type);
-int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_trx_v7(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_trx_v9(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxtxpwr_v7(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxtxpwr_v9(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id);
 int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 				 struct sk_buff *skb_ofld);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 60f362593696..4caf231c6287 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -355,7 +355,7 @@ static const struct rtw89_pmac_regs rtw8851b_pmac_regs = {
 	.ampdu_crc_err_mask = B_CNT_AMPDU_RX_CRC32_ERR,
 };
 
-static const struct rtw89_btc_rf_trx_para rtw89_btc_8851b_rf_ul[] = {
+static const struct rtw89_btc_rf_trx_para_v0 rtw89_btc_8851b_rf_ul_v0[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
@@ -367,7 +367,7 @@ static const struct rtw89_btc_rf_trx_para rtw89_btc_8851b_rf_ul[] = {
 	{13, 1, 0, 7}
 };
 
-static const struct rtw89_btc_rf_trx_para rtw89_btc_8851b_rf_dl[] = {
+static const struct rtw89_btc_rf_trx_para_v0 rtw89_btc_8851b_rf_dl_v0[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
@@ -2730,10 +2730,10 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.rssi_tol		= 2,
 	.mon_reg_num		= ARRAY_SIZE(rtw89_btc_8851b_mon_reg),
 	.mon_reg		= rtw89_btc_8851b_mon_reg,
-	.rf_para_ulink_num	= ARRAY_SIZE(rtw89_btc_8851b_rf_ul),
-	.rf_para_ulink		= rtw89_btc_8851b_rf_ul,
-	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8851b_rf_dl),
-	.rf_para_dlink		= rtw89_btc_8851b_rf_dl,
+	.rf_para_ulink_v0	= rtw89_btc_8851b_rf_ul_v0,
+	.rf_para_dlink_v0	= rtw89_btc_8851b_rf_dl_v0,
+	.rf_para_ulink_num_v0	= ARRAY_SIZE(rtw89_btc_8851b_rf_ul_v0),
+	.rf_para_dlink_num_v0	= ARRAY_SIZE(rtw89_btc_8851b_rf_dl_v0),
 	.rf_para_ulink_v9	= NULL,
 	.rf_para_dlink_v9	= NULL,
 	.rf_para_ulink_num_v9	= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 94027e5b8d28..78addc0aef69 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2049,7 +2049,7 @@ s8 rtw8852a_btc_get_bt_rssi(struct rtw89_dev *rtwdev, s8 val)
 	return clamp_t(s8, val + 6, -100, 0) + 100;
 }
 
-static struct rtw89_btc_rf_trx_para rtw89_btc_8852a_rf_ul[] = {
+static struct rtw89_btc_rf_trx_para_v0 rtw89_btc_8852a_rf_ul_v0[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
@@ -2061,7 +2061,7 @@ static struct rtw89_btc_rf_trx_para rtw89_btc_8852a_rf_ul[] = {
 	{13, 1, 0, 7}
 };
 
-static struct rtw89_btc_rf_trx_para rtw89_btc_8852a_rf_dl[] = {
+static struct rtw89_btc_rf_trx_para_v0 rtw89_btc_8852a_rf_dl_v0[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
@@ -2468,10 +2468,10 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.rssi_tol		= 2,
 	.mon_reg_num		= ARRAY_SIZE(rtw89_btc_8852a_mon_reg),
 	.mon_reg		= rtw89_btc_8852a_mon_reg,
-	.rf_para_ulink_num	= ARRAY_SIZE(rtw89_btc_8852a_rf_ul),
-	.rf_para_ulink		= rtw89_btc_8852a_rf_ul,
-	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8852a_rf_dl),
-	.rf_para_dlink		= rtw89_btc_8852a_rf_dl,
+	.rf_para_ulink_v0	= rtw89_btc_8852a_rf_ul_v0,
+	.rf_para_dlink_v0	= rtw89_btc_8852a_rf_dl_v0,
+	.rf_para_ulink_num_v0	= ARRAY_SIZE(rtw89_btc_8852a_rf_ul_v0),
+	.rf_para_dlink_num_v0	= ARRAY_SIZE(rtw89_btc_8852a_rf_dl_v0),
 	.rf_para_ulink_v9	= NULL,
 	.rf_para_dlink_v9	= NULL,
 	.rf_para_ulink_num_v9	= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 4e7b068aaa75..debcdb2eacd6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -307,7 +307,7 @@ static const struct rtw89_pmac_regs rtw8852b_pmac_regs = {
 	.ampdu_crc_err_mask = B_CNT_AMPDU_RX_CRC32_ERR,
 };
 
-static const struct rtw89_btc_rf_trx_para rtw89_btc_8852b_rf_ul[] = {
+static const struct rtw89_btc_rf_trx_para_v0 rtw89_btc_8852b_rf_ul_v0[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
@@ -319,7 +319,7 @@ static const struct rtw89_btc_rf_trx_para rtw89_btc_8852b_rf_ul[] = {
 	{13, 1, 0, 7}
 };
 
-static const struct rtw89_btc_rf_trx_para rtw89_btc_8852b_rf_dl[] = {
+static const struct rtw89_btc_rf_trx_para_v0 rtw89_btc_8852b_rf_dl_v0[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
@@ -1063,10 +1063,10 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.rssi_tol		= 2,
 	.mon_reg_num		= ARRAY_SIZE(rtw89_btc_8852b_mon_reg),
 	.mon_reg		= rtw89_btc_8852b_mon_reg,
-	.rf_para_ulink_num	= ARRAY_SIZE(rtw89_btc_8852b_rf_ul),
-	.rf_para_ulink		= rtw89_btc_8852b_rf_ul,
-	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8852b_rf_dl),
-	.rf_para_dlink		= rtw89_btc_8852b_rf_dl,
+	.rf_para_ulink_v0	= rtw89_btc_8852b_rf_ul_v0,
+	.rf_para_dlink_v0	= rtw89_btc_8852b_rf_dl_v0,
+	.rf_para_ulink_num_v0	= ARRAY_SIZE(rtw89_btc_8852b_rf_ul_v0),
+	.rf_para_dlink_num_v0	= ARRAY_SIZE(rtw89_btc_8852b_rf_dl_v0),
 	.rf_para_ulink_v9	= NULL,
 	.rf_para_dlink_v9	= NULL,
 	.rf_para_ulink_num_v9	= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 7fcc877f6ea0..fc8a17fb95f4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -250,7 +250,7 @@ static const struct rtw89_pmac_regs rtw8852bt_pmac_regs = {
 	.ampdu_crc_err_mask = B_CNT_AMPDU_RX_CRC32_ERR,
 };
 
-static const struct rtw89_btc_rf_trx_para rtw89_btc_8852bt_rf_ul[] = {
+static const struct rtw89_btc_rf_trx_para_v0 rtw89_btc_8852bt_rf_ul_v0[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
@@ -262,7 +262,7 @@ static const struct rtw89_btc_rf_trx_para rtw89_btc_8852bt_rf_ul[] = {
 	{13, 1, 0, 7}
 };
 
-static const struct rtw89_btc_rf_trx_para rtw89_btc_8852bt_rf_dl[] = {
+static const struct rtw89_btc_rf_trx_para_v0 rtw89_btc_8852bt_rf_dl_v0[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
@@ -902,10 +902,10 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.rssi_tol		= 2,
 	.mon_reg_num		= ARRAY_SIZE(rtw89_btc_8852bt_mon_reg),
 	.mon_reg		= rtw89_btc_8852bt_mon_reg,
-	.rf_para_ulink_num	= ARRAY_SIZE(rtw89_btc_8852bt_rf_ul),
-	.rf_para_ulink		= rtw89_btc_8852bt_rf_ul,
-	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8852bt_rf_dl),
-	.rf_para_dlink		= rtw89_btc_8852bt_rf_dl,
+	.rf_para_ulink_v0	= rtw89_btc_8852bt_rf_ul_v0,
+	.rf_para_dlink_v0	= rtw89_btc_8852bt_rf_dl_v0,
+	.rf_para_ulink_num_v0	= ARRAY_SIZE(rtw89_btc_8852bt_rf_ul_v0),
+	.rf_para_dlink_num_v0	= ARRAY_SIZE(rtw89_btc_8852bt_rf_dl_v0),
 	.rf_para_ulink_v9	= NULL,
 	.rf_para_dlink_v9	= NULL,
 	.rf_para_ulink_num_v9	= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 3861cce42b1b..bec6aa574e9d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2863,7 +2863,7 @@ s8 rtw8852c_btc_get_bt_rssi(struct rtw89_dev *rtwdev, s8 val)
 	return clamp_t(s8, val + 6, -100, 0) + 100;
 }
 
-static const struct rtw89_btc_rf_trx_para rtw89_btc_8852c_rf_ul[] = {
+static const struct rtw89_btc_rf_trx_para_v0 rtw89_btc_8852c_rf_ul_v0[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
@@ -2875,7 +2875,7 @@ static const struct rtw89_btc_rf_trx_para rtw89_btc_8852c_rf_ul[] = {
 	{13, 1, 0, 7}
 };
 
-static const struct rtw89_btc_rf_trx_para rtw89_btc_8852c_rf_dl[] = {
+static const struct rtw89_btc_rf_trx_para_v0 rtw89_btc_8852c_rf_dl_v0[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
@@ -3270,10 +3270,10 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.rssi_tol		= 2,
 	.mon_reg_num		= ARRAY_SIZE(rtw89_btc_8852c_mon_reg),
 	.mon_reg		= rtw89_btc_8852c_mon_reg,
-	.rf_para_ulink_num	= ARRAY_SIZE(rtw89_btc_8852c_rf_ul),
-	.rf_para_ulink		= rtw89_btc_8852c_rf_ul,
-	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8852c_rf_dl),
-	.rf_para_dlink		= rtw89_btc_8852c_rf_dl,
+	.rf_para_ulink_v0	= rtw89_btc_8852c_rf_ul_v0,
+	.rf_para_dlink_v0	= rtw89_btc_8852c_rf_dl_v0,
+	.rf_para_ulink_num_v0	= ARRAY_SIZE(rtw89_btc_8852c_rf_ul_v0),
+	.rf_para_dlink_num_v0	= ARRAY_SIZE(rtw89_btc_8852c_rf_dl_v0),
 	.rf_para_ulink_v9	= NULL,
 	.rf_para_dlink_v9	= NULL,
 	.rf_para_ulink_num_v9	= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 91897aeced28..6d4301661b04 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2874,7 +2874,7 @@ s8 rtw8922a_btc_get_bt_rssi(struct rtw89_dev *rtwdev, s8 val)
 	return clamp_t(s8, val, -100, 0) + 100;
 }
 
-static const struct rtw89_btc_rf_trx_para rtw89_btc_8922a_rf_ul[] = {
+static const struct rtw89_btc_rf_trx_para_v0 rtw89_btc_8922a_rf_ul_v0[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
@@ -2886,7 +2886,7 @@ static const struct rtw89_btc_rf_trx_para rtw89_btc_8922a_rf_ul[] = {
 	{13, 1, 0, 7}
 };
 
-static const struct rtw89_btc_rf_trx_para rtw89_btc_8922a_rf_dl[] = {
+static const struct rtw89_btc_rf_trx_para_v0 rtw89_btc_8922a_rf_dl_v0[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
@@ -3254,10 +3254,10 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.rssi_tol		= 2,
 	.mon_reg_num		= ARRAY_SIZE(rtw89_btc_8922a_mon_reg),
 	.mon_reg		= rtw89_btc_8922a_mon_reg,
-	.rf_para_ulink_num	= ARRAY_SIZE(rtw89_btc_8922a_rf_ul),
-	.rf_para_ulink		= rtw89_btc_8922a_rf_ul,
-	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8922a_rf_dl),
-	.rf_para_dlink		= rtw89_btc_8922a_rf_dl,
+	.rf_para_ulink_v0	= rtw89_btc_8922a_rf_ul_v0,
+	.rf_para_dlink_v0	= rtw89_btc_8922a_rf_dl_v0,
+	.rf_para_ulink_num_v0	= ARRAY_SIZE(rtw89_btc_8922a_rf_ul_v0),
+	.rf_para_dlink_num_v0	= ARRAY_SIZE(rtw89_btc_8922a_rf_dl_v0),
 	.rf_para_ulink_v9	= NULL,
 	.rf_para_dlink_v9	= NULL,
 	.rf_para_ulink_num_v9	= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 888973f4ef95..f78d6d46e65f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -3430,6 +3430,10 @@ const struct rtw89_chip_info rtw8922d_chip_info = {
 	.rssi_tol		= 2,
 	.mon_reg_num		= ARRAY_SIZE(rtw89_btc_8922d_mon_reg),
 	.mon_reg		= rtw89_btc_8922d_mon_reg,
+	.rf_para_ulink_v0	= NULL,
+	.rf_para_dlink_v0	= NULL,
+	.rf_para_ulink_num_v0	= 0,
+	.rf_para_dlink_num_v0	= 0,
 	.rf_para_ulink_v9	= rtw89_btc_8922d_rf_ul_v9,
 	.rf_para_dlink_v9	= rtw89_btc_8922d_rf_dl_v9,
 	.rf_para_ulink_num_v9	= ARRAY_SIZE(rtw89_btc_8922d_rf_ul_v9),
-- 
2.25.1


