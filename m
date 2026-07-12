Return-Path: <linux-wireless+bounces-38906-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RaKRMUYOU2qIWQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38906-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:47:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CFA743B8F
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:47:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=Ybnwrs9O;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38906-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38906-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDD4B3027B7D
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C59B846A;
	Sun, 12 Jul 2026 03:46:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA02AD37
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:46:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783827995; cv=none; b=JOPHWLwdsru9PSfdDWGfSjS0mWKrAGnjHOjIzOZE8JNfhIt5ggljJlKmU/0udwsn8yKUPL9mj0ul+2axGF95VZ3XIty8CJyPhhLZArwyA2BXZAstAkhuGTuMaZlDC2b00c1gbHr7atVVOoFQl13eiSEGBLa9v7cWptwLhXTkYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783827995; c=relaxed/simple;
	bh=chZbaCI86GY9KnZu8yJEeNRGpwIT2UQRmoPLgmgdevI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6aQ1JQ0rqqI33x8q98929UGecx4qDpaNs9xT+zkCoI3cTyWle8vQu5/d4UYz7RA7piDYBTR7SOHbZ9jOEPMjfyR+9eb+8Gg8mWMX7KDMsjtENw1KdmMKiswq18bxBsSXF73SMpROU8V3xqZf9F9V9qODOTrYn0uSAjnz2ItXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ybnwrs9O; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C3kUaL5535659, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783827991; bh=wGoOY89R7+TDfy0ZlW9SeqtNYEY1jde/LIu41ltw4EA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ybnwrs9O6p8H2Y5K+ADuyYYqylhnBs+pht1KbNsE0a70Ozd5mTgw9zVwE9vAz0mkh
	 WIbkC9AGVOTsOF15GB7Pd79AuT/rmW6wm7sTWj7wOI9Mq5UjdLUH03iwsn3JkKvEVp
	 1qp0+0B16UGGkV7/VUO6MsvyOLBJZN8c+rsQgQF/Z5od2pc12CYxqfz59MRkAB7XMH
	 gJHXRT5pkyv66zriPa3BBTzN9Ulx8llvlQN4kDIGaU57tra7eIQE3Mn4wR4/vy1ulX
	 AeYjmtqR+HGzmVwJvxcEUzFGquwttaH0iwdi7ykhoXdwxN5gWuzzY/s9EbPGyv5Wob
	 z9zTPwAJ4GcLQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C3kUaL5535659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:46:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:46:31 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:46:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 5/8] wifi: rtw89: add tx shape v0 to keep built-in arrays compatible during transitions
Date: Sun, 12 Jul 2026 11:45:03 +0800
Message-ID: <20260712034506.53209-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260712034506.53209-1-pkshih@realtek.com>
References: <20260712034506.53209-1-pkshih@realtek.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38906-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:echuang@realtek.com,m:kevin_yang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28CFA743B8F

From: Zong-Zhe Yang <kevin_yang@realtek.com>

TX shape parameters can come from (old way) built-in arrays or (new way)
FW elements. The built-in arrays will no longer be updated, but will be
retained during a certain transition period. However, the format of newer
TX shape parameters are going to be expanded. It will only be applied to
FW elements. To keep built-in arrays compatible during transition period,
add tx shape v0 for old format.

The v0 fields can be removed along with built-in arrays once transition
period ends.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h           | 9 +++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b_table.c | 8 ++++----
 drivers/net/wireless/realtek/rtw89/rtw8852b_table.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c_table.c | 4 ++--
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1e323007421c..94ba7e368880 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4518,6 +4518,9 @@ struct rtw89_txpwr_rule_6ghz {
 struct rtw89_tx_shape {
 	const u8 (*lmt)[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM][RTW89_REGD_NUM];
 	const u8 (*lmt_ru)[RTW89_BAND_NUM][RTW89_REGD_NUM];
+
+	const u8 (*lmt_v0)[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM][RTW89_REGD_NUM];
+	const u8 (*lmt_ru_v0)[RTW89_BAND_NUM][RTW89_REGD_NUM];
 };
 
 struct rtw89_rfe_parms {
@@ -8052,7 +8055,13 @@ static inline u8 rtw89_get_tx_shape_idx(struct rtw89_dev *rtwdev, u8 band,
 	if (unlikely(rs >= RTW89_RS_TX_SHAPE_NUM))
 		rs = RTW89_RS_OFDM;
 
+	if (!tx_shape->lmt)
+		goto v0;
+
 	return (*tx_shape->lmt)[band][rs][regd];
+
+v0:
+	return (*tx_shape->lmt_v0)[band][rs][regd];
 }
 
 static inline void rtw89_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
index b8105f6e94f1..f875beaec555 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
@@ -14887,8 +14887,8 @@ const struct rtw89_rfe_parms rtw89_8851b_dflt_parms = {
 		.lmt_ru = &rtw89_8851b_txpwr_lmt_ru_5g,
 	},
 	.tx_shape = {
-		.lmt = &rtw89_8851b_tx_shape_lmt,
-		.lmt_ru = &rtw89_8851b_tx_shape_lmt_ru,
+		.lmt_v0 = &rtw89_8851b_tx_shape_lmt,
+		.lmt_ru_v0 = &rtw89_8851b_tx_shape_lmt_ru,
 	},
 };
 
@@ -14903,8 +14903,8 @@ static const struct rtw89_rfe_parms rtw89_8851b_rfe_parms_type2 = {
 		.lmt_ru = &rtw89_8851b_txpwr_lmt_ru_5g_type2,
 	},
 	.tx_shape = {
-		.lmt = &rtw89_8851b_tx_shape_lmt,
-		.lmt_ru = &rtw89_8851b_tx_shape_lmt_ru,
+		.lmt_v0 = &rtw89_8851b_tx_shape_lmt,
+		.lmt_ru_v0 = &rtw89_8851b_tx_shape_lmt_ru,
 	},
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
index 96b18e9095b3..1485a8fc4bde 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
@@ -22922,7 +22922,7 @@ const struct rtw89_rfe_parms rtw89_8852b_dflt_parms = {
 		.lmt_ru = &rtw89_8852b_txpwr_lmt_ru_5g,
 	},
 	.tx_shape = {
-		.lmt = &rtw89_8852b_tx_shape_lmt,
-		.lmt_ru = &rtw89_8852b_tx_shape_lmt_ru,
+		.lmt_v0 = &rtw89_8852b_tx_shape_lmt,
+		.lmt_ru_v0 = &rtw89_8852b_tx_shape_lmt_ru,
 	},
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
index b4cf497e8524..c5ede63e7e23 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
@@ -57154,7 +57154,7 @@ const struct rtw89_rfe_parms rtw89_8852c_dflt_parms = {
 		.lmt_ru = &rtw89_8852c_txpwr_lmt_ru_6g,
 	},
 	.tx_shape = {
-		.lmt = &rtw89_8852c_tx_shape_lmt,
-		.lmt_ru = &rtw89_8852c_tx_shape_lmt_ru,
+		.lmt_v0 = &rtw89_8852c_tx_shape_lmt,
+		.lmt_ru_v0 = &rtw89_8852c_tx_shape_lmt_ru,
 	},
 };
-- 
2.25.1


