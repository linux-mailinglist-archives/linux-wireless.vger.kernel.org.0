Return-Path: <linux-wireless+bounces-38040-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fc2rEt5RO2p6WAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38040-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A06BB254
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:41:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=tdxyZ0Ys;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38040-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38040-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 928E4302CD8F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 03:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A35F30B53A;
	Wed, 24 Jun 2026 03:41:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B6246788
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:41:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272476; cv=none; b=c2axSd44YNu31MpPOV7he/RTCxt2GREzXdAWhcTTJjM60ZXC9EyRXZ5rvjr98TBM9dsxPKt92mO+7qgMqrMsJXzxNZm3PVzqq/HqGDOEdFeCXwlRlkcg4nwXGCUiXTBxmISFO6ltn/PCUnJpu3fJraEgAvubTemLHmWpWxroj3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272476; c=relaxed/simple;
	bh=8tbGvUD52mDR/DPnEV3Nfs2KpOFKhshYiTnX4lY+V1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRX7mu2YTEymL+SzyP1HkdK0PXgH51x7Cz+0h0v/dAxaTkTXhuuzTAVahEX8PkpInG4Zp5N40+m547YSkntoGYAo4CbcW/tm6EgjgPWtBmzLUftdIOsHqQyg2ejOlFhc9iQuRy/V07rnYqMQrjUkaD+0vFfrs7dy7OzjElxZMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=tdxyZ0Ys; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65O3fCeyD3888975, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782272472; bh=FZkNnaZV/IBVAl35g7U4sMXRK1rj0IZkND3gHGMHIgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=tdxyZ0YsTW9Yn4CxB6Tvg49RrVgB4yUKPCy8F3kw578G8fFw4YKW+ST1pvOCiVKfb
	 ThOUPTVhIEu8HZSvoDxqZBFfMnQgHsLL+ZenDJ0MeoU0+X9PqET/jGTE2R6MQ9AF/y
	 HXKj/cgZNqYMKDJKl1v0GOwEaYVLeUa/rPbxOSfqgfxQKG0LAyugobBCWf2gdRN+9g
	 np+7HRWaMSsTm0g0qus4JW4y0dHFc+dLNMeEoKm8diIe5+PPu3ZiTuC6rrc4Cbozh7
	 yUoM+eAWW33HyUcdvkYOgjhIjLtBf47TjPY2217Qw0lPF4YHQftnQkmFLpESjqZ2yt
	 Ppu0vLC2FKSWQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65O3fCeyD3888975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 11:41:12 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:41:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:41:12 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Jun 2026 11:41:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 09/10] wifi: rtw89: coex: Add Wi-Fi firmware 0.35.94.1 support for RTL8922D
Date: Wed, 24 Jun 2026 11:39:40 +0800
Message-ID: <20260624033941.45918-10-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-38040-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 218A06BB254

From: Ching-Te Ku <ku920601@realtek.com>

The firmware 0.35.94.1 included several new features. Wi-Fi TX power
setting offload to firmware. Including dual BT / dual Wi-Fi MAC related
configurations.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 62 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h |  3 ++
 2 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 572eed7939e1..6f9bb31b5263 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -133,6 +133,15 @@ static const u32 cxtbl[] = {
 
 static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	/* firmware version must be in decreasing order for each chip */
+	{RTL8922D, RTW89_FW_VER_CODE(0, 35, 94, 0),
+	 .fcxbtcrpt = 11, .fcxtdma = 8,    .fcxslots = 7, .fcxcysta = 8,
+	 .fcxstep = 7,    .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 8,
+	 .fcxbtver = 8,   .fcxbtscan = 8,  .fcxbtafh = 8, .fcxbtdevinfo = 8,
+	 .fwlrole = 10,    .frptmap = 5,    .fcxctrl = 9,  .fcxinit = 10,
+	 .fwevntrptl = 1,  .fwc2hfunc = 4, .drvinfo_ver = 3, .info_buf = 1800,
+	 .max_role_num = 6, .fcxosi = 6,   .fcxmlo = 2,   .bt_desired = 8,
+	 .fcxtrx = 9,
+	},
 	{RTL8852BT, RTW89_FW_VER_CODE(0, 29, 122, 0),
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
@@ -156,7 +165,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 8,   .frptmap = 4,    .fcxctrl = 7,  .fcxinit = 7,
-	 .fwevntrptl = 1, .fwc2hfunc = 3, .drvinfo_ver = 2, .info_buf = 1800,
+	 .fwevntrptl = 1, .fwc2hfunc = 3, .drvinfo_ver = 3, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,   .bt_desired = 9,
 	 .fcxtrx = 7,
 	},
@@ -2423,6 +2432,7 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 			break;
 		case 3:
 		case 4:
+		case 5:
 			bit_map = BIT(5);
 			break;
 		default:
@@ -2438,6 +2448,7 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 			break;
 		case 3:
 		case 4:
+		case 5:
 			bit_map = BIT(6);
 			break;
 		default:
@@ -2451,6 +2462,7 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 			break;
 		case 3:
 		case 4:
+		case 5:
 			bit_map = BIT(7);
 			break;
 		default:
@@ -2465,6 +2477,7 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 		case 3:
 			break;
 		case 4:
+		case 5:
 			bit_map = BIT(8);
 			break;
 		default:
@@ -2481,6 +2494,7 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 			bit_map = BIT(8);
 			break;
 		case 4:
+		case 5:
 			bit_map = BIT(9);
 			break;
 		default:
@@ -2488,7 +2502,10 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 		}
 		break;
 	case RPT_EN_TEST:
-		bit_map = BIT(31);
+		if (ver->frptmap == 5)
+			bit_map = BIT(10);
+		else
+			bit_map = BIT(31);
 		break;
 	case RPT_EN_WL_ALL:
 		switch (ver->frptmap) {
@@ -2501,6 +2518,7 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 			bit_map = GENMASK(2, 0) | BIT(8);
 			break;
 		case 4:
+		case 5:
 			bit_map = GENMASK(2, 0) | BIT(9);
 			break;
 		default:
@@ -2520,6 +2538,7 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 			bit_map = GENMASK(7, 3);
 			break;
 		case 4:
+		case 5:
 			bit_map = GENMASK(8, 3);
 			break;
 		default:
@@ -2539,6 +2558,7 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 			bit_map = GENMASK(8, 0);
 			break;
 		case 4:
+		case 5:
 			bit_map = GENMASK(9, 0);
 			break;
 		default:
@@ -2558,6 +2578,7 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 			bit_map = GENMASK(8, 2);
 			break;
 		case 4:
+		case 5:
 			bit_map = GENMASK(9, 2);
 			break;
 		default:
@@ -2814,7 +2835,7 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 index)
 			rtw89_fw_h2c_cxdrv_role_v8(rtwdev, index);
 		break;
 	case CXDRVINFO_CTRL:
-		if (ver->drvinfo_ver == 1)
+		if (ver->drvinfo_ver != 0)
 			index = 2;
 
 		if (ver->fcxctrl == 7)
@@ -2823,7 +2844,7 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 index)
 			rtw89_fw_h2c_cxdrv_ctrl(rtwdev, index);
 		break;
 	case CXDRVINFO_TRX:
-		if (ver->drvinfo_ver == 1)
+		if (ver->drvinfo_ver > 1)
 			index = 3;
 
 		if (ver->fcxtrx == 7)
@@ -2832,7 +2853,7 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 index)
 			rtw89_fw_h2c_cxdrv_trx_v9(rtwdev, index);
 		break;
 	case CXDRVINFO_RFK:
-		if (ver->drvinfo_ver == 1)
+		if (ver->drvinfo_ver != 0)
 			return;
 
 		rtw89_fw_h2c_cxdrv_rfk(rtwdev, index);
@@ -2847,12 +2868,26 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 index)
 			rtw89_fw_h2c_cxtxpwr_v9(rtwdev, index);
 		break;
 	case CXDRVINFO_FDDT:
+		if (ver->drvinfo_ver == 3)
+			index = 5;
+		else
+			return;
+
+		rtw89_debug(rtwdev, RTW89_DBG_BTC, "drv_info FDDT index=%d\n", index);
+		break;
 	case CXDRVINFO_MLO:
+		if (ver->drvinfo_ver == 3)
+			index = 6;
+		else
+			return;
+
+		rtw89_debug(rtwdev, RTW89_DBG_BTC, "drv_info MLO index=%d\n", index);
+		break;
 	case CXDRVINFO_OSI:
 		if (!ver->fcxosi)
 			return;
 
-		if (ver->drvinfo_ver == 2)
+		if (ver->drvinfo_ver > 1)
 			index = 7;
 		else
 			return;
@@ -8828,7 +8863,7 @@ static u8 rtw89_btc_c2h_get_index_by_ver(struct rtw89_dev *rtwdev, u8 func)
 			return BTF_EVNT_BUF_OVERFLOW;
 		else if (ver->fwc2hfunc == 2)
 			return func;
-		else if (ver->fwc2hfunc == 3)
+		else if (ver->fwc2hfunc == 3 || ver->fwc2hfunc == 4)
 			return BTF_EVNT_BUF_OVERFLOW;
 		else
 			return BTF_EVNT_MAX;
@@ -8839,19 +8874,26 @@ static u8 rtw89_btc_c2h_get_index_by_ver(struct rtw89_dev *rtwdev, u8 func)
 			return BTF_EVNT_C2H_LOOPBACK;
 		else if (ver->fwc2hfunc == 2)
 			return func;
-		else if (ver->fwc2hfunc == 3)
+		else if (ver->fwc2hfunc == 3 || ver->fwc2hfunc == 4)
 			return BTF_EVNT_C2H_LOOPBACK;
 		else
 			return BTF_EVNT_MAX;
 	case BTF_EVNT_C2H_LOOPBACK:
 		if (ver->fwc2hfunc == 2)
 			return func;
-		else if (ver->fwc2hfunc == 3)
+		else if (ver->fwc2hfunc == 3 || ver->fwc2hfunc == 4)
 			return BTF_EVNT_BT_LEAUDIO_INFO;
 		else
 			return BTF_EVNT_MAX;
 	case BTF_EVNT_BT_QUERY_TXPWR:
-		if (ver->fwc2hfunc == 3)
+		if (ver->fwc2hfunc == 3 || ver->fwc2hfunc == 4)
+			return func;
+		else
+			return BTF_EVNT_MAX;
+	case BTF_EVNT_ZB_INFO:
+	case BTF_EVNT_ZB_CH:
+	case BTF_EVNT_ZB_QUERY_TXPWR:
+		if (ver->fwc2hfunc == 4)
 			return func;
 		else
 			return BTF_EVNT_MAX;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7a87ffc1931e..6947f4c2c25d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3224,6 +3224,9 @@ enum rtw89_btc_btf_fw_event {
 	BTF_EVNT_BUF_OVERFLOW,
 	BTF_EVNT_C2H_LOOPBACK,
 	BTF_EVNT_BT_QUERY_TXPWR, /* fwc2hfunc > 3 */
+	BTF_EVNT_ZB_INFO = 11,
+	BTF_EVNT_ZB_CH = 12,
+	BTF_EVNT_ZB_QUERY_TXPWR = 13,
 	BTF_EVNT_MAX,
 };
 
-- 
2.25.1


