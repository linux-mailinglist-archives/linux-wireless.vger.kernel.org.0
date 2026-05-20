Return-Path: <linux-wireless+bounces-36710-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NCtJKGtDWrW1QUAu9opvQ
	(envelope-from <linux-wireless+bounces-36710-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:48:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0086958E2D1
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA780313C4B8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D9F374E62;
	Wed, 20 May 2026 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UrxUFi8D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2183DC4C1
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280741; cv=none; b=bWdlPPXgvpxR4tjhzni3R5bYVAIk8hUoQbUTV7gRakOdr//gJZpzC+s/3cLlFTCrCiExH7cEyJ8A+15H7xcr2iMddrrYS5Z2//VrEuqCSyHQnEU2v5GHk1IMvRXBCo32KioG7HmuIVM1pQzziWw0+oiiezEbdc+2CzUf3n/YBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280741; c=relaxed/simple;
	bh=gThcBRCKeWQ4YInGGVa69bV9olzBpZMmy+k8vBYiNfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3nUHNsYJ/IMTJ4JIUY6rdS07jJa+SBgge7S+X7jz7fc+w8NbgGJEMB8N5VJtXyWXZry83Vyw5wkRxZ+TBs0QXChBki6MPKIQlMHjCSCB2jzOXgj57Pvy3oV+t2BAGtl+UNiAHRPUr062a97sMVmGWOm+hu4/ffJMvgaQftLIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UrxUFi8D; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64KCcvvxF095596, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779280737; bh=8QwhycUMF8dNShHGh7Ptmj6aQoKVKHMteEez+4afmho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UrxUFi8Do0ugXRNvWnZt8aOC724zYh5pqUSyDd73mYBpXVgaKhYFL0uwElcMwZUzm
	 OhFABmuzsr2A5pdNbAIcqZ41J9rH7pmWUTJRMLgqAwbI+16sQ7yALrNc/dnzm6jg58
	 EvR3HDiydbeB9OskKL13vaSz7fYtgO7BDWPrRAepbYV02S8beUxJiy9lwOJBuTfuuP
	 6sRnaUYlqbQw0EDIj9eU4Kh9Gw6N1vFEJiSEswJMSTpuwB/DlAAvb/5PM86Ph+2cCk
	 laiPUjI5QiPrcwXx//w4cXvXKg8Sn8FNIpfnO0ZMWUOhgaWMP9iqH0lNz6OAvO8b5S
	 Qw00e3HNpw5aA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64KCcvvxF095596
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 20:38:57 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 20:38:55 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 20:38:55 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 20 May 2026 20:38:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 6/7] wifi: rtw89: debug: show large MRU in txpwr_table dbgfs
Date: Wed, 20 May 2026 20:38:22 +0800
Message-ID: <20260520123823.1792954-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260520123823.1792954-1-pkshih@realtek.com>
References: <20260520123823.1792954-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
	TAGGED_FROM(0.00)[bounces-36710-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:email,realtek.com:mid,realtek.com:dkim];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0086958E2D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Read and print the CR settings of large MRU.
For now, only RTL8922D_CID7090 support it.

For example,

[TX power limit_large_mru]
RU484_242 1TX     	-  IDX_0   IDX_1   IDX_2   IDX_3 	|  17,   0,   0,   0,	dBm
RU484_242 2TX     	-  IDX_0   IDX_1   IDX_2   IDX_3 	|  16,   0,   0,   0,	dBm
RU996_484 1TX     	-  IDX_0   IDX_1 	|   0,   0,		dBm
RU996_484 2TX     	-  IDX_0   IDX_1 	|   0,   0,		dBm
RU996_484_242 1TX 	-  IDX_0   IDX_1 	|   0,   0,		dBm
RU996_484_242 2TX 	-  IDX_0   IDX_1 	|   0,   0,		dBm

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 8ee800c76cfe..eb9106932187 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -767,6 +767,45 @@ static const struct txpwr_map __txpwr_map_lmt_ru_be = {
 	.addr_to_1ss = 0, /* not support */
 };
 
+static const struct txpwr_ent __txpwr_ent_lmt_ru484_242_be[] = {
+	__GEN_TXPWR_ENT4("RU484_242 1TX     ", "IDX_0 ", "IDX_1 ", "IDX_2 ", "IDX_3 "),
+	__GEN_TXPWR_ENT4("RU484_242 2TX     ", "IDX_0 ", "IDX_1 ", "IDX_2 ", "IDX_3 "),
+};
+
+static const struct txpwr_map __txpwr_map_lmt_ru484_242_be = {
+	.ent = __txpwr_ent_lmt_ru484_242_be,
+	.size = ARRAY_SIZE(__txpwr_ent_lmt_ru484_242_be),
+	.addr_from = R_BE_TXAGC_MAX_1TX_RU484_242_0,
+	.addr_to = R_BE_TXAGC_MAX_1TX_RU484_242_0 + 4,
+	.addr_to_1ss = 0, /* not support */
+};
+
+static const struct txpwr_ent __txpwr_ent_lmt_ru996_484_be[] = {
+	__GEN_TXPWR_ENT2("RU996_484 1TX     ", "IDX_0 ", "IDX_1 "),
+	__GEN_TXPWR_ENT2("RU996_484 2TX     ", "IDX_0 ", "IDX_1 "),
+};
+
+static const struct txpwr_map __txpwr_map_lmt_ru996_484_be = {
+	.ent = __txpwr_ent_lmt_ru996_484_be,
+	.size = ARRAY_SIZE(__txpwr_ent_lmt_ru996_484_be),
+	.addr_from = R_BE_TXAGC_MAX_1TX_RU996_484_0,
+	.addr_to = R_BE_TXAGC_MAX_1TX_RU996_484_0,
+	.addr_to_1ss = 0, /* not support */
+};
+
+static const struct txpwr_ent __txpwr_ent_lmt_ru996_484_242_be[] = {
+	__GEN_TXPWR_ENT2("RU996_484_242 1TX ", "IDX_0 ", "IDX_1 "),
+	__GEN_TXPWR_ENT2("RU996_484_242 2TX ", "IDX_0 ", "IDX_1 "),
+};
+
+static const struct txpwr_map __txpwr_map_lmt_ru996_484_242_be = {
+	.ent = __txpwr_ent_lmt_ru996_484_242_be,
+	.size = ARRAY_SIZE(__txpwr_ent_lmt_ru996_484_242_be),
+	.addr_from = R_BE_TXAGC_MAX_1TX_RU996_484_242_0,
+	.addr_to = R_BE_TXAGC_MAX_1TX_RU996_484_242_0,
+	.addr_to_1ss = 0, /* not support */
+};
+
 static unsigned int
 __print_txpwr_ent(char *buf, size_t bufsz, const struct txpwr_ent *ent,
 		  const s8 *bufp, const unsigned int cur, unsigned int *ate)
@@ -882,6 +921,9 @@ struct dbgfs_txpwr_table {
 	const struct txpwr_map *byr;
 	const struct txpwr_map *lmt;
 	const struct txpwr_map *lmt_ru;
+	const struct txpwr_map *lmt_ru484_242;
+	const struct txpwr_map *lmt_ru996_484;
+	const struct txpwr_map *lmt_ru996_484_242;
 };
 
 static const struct dbgfs_txpwr_table dbgfs_txpwr_table_ax = {
@@ -894,6 +936,9 @@ static const struct dbgfs_txpwr_table dbgfs_txpwr_table_be = {
 	.byr = &__txpwr_map_byr_be,
 	.lmt = &__txpwr_map_lmt_be,
 	.lmt_ru = &__txpwr_map_lmt_ru_be,
+	.lmt_ru484_242 = &__txpwr_map_lmt_ru484_242_be,
+	.lmt_ru996_484 = &__txpwr_map_lmt_ru996_484_be,
+	.lmt_ru996_484_242 = &__txpwr_map_lmt_ru996_484_242_be,
 };
 
 static const struct dbgfs_txpwr_table *dbgfs_txpwr_tables[RTW89_CHIP_GEN_NUM] = {
@@ -934,6 +979,8 @@ ssize_t rtw89_debug_priv_txpwr_table_get(struct rtw89_dev *rtwdev,
 					 char *buf, size_t bufsz)
 {
 	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_sar_parm sar_parm = {};
 	const struct dbgfs_txpwr_table *tbl;
 	const struct rtw89_chan *chan;
@@ -979,6 +1026,35 @@ ssize_t rtw89_debug_priv_txpwr_table_get(struct rtw89_dev *rtwdev,
 		return n;
 	p += n;
 
+	switch (chip_gen) {
+	case RTW89_CHIP_AX:
+		goto out;
+	case RTW89_CHIP_BE:
+		if (!(chip->chip_id == RTL8922D && hal->cid == RTL8922D_CID7090))
+			goto out;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	p += scnprintf(p, end - p, "\n[TX power limit_large_mru]\n");
+
+	n = __print_txpwr_map(rtwdev, p, end - p, tbl->lmt_ru484_242);
+	if (n < 0)
+		return n;
+	p += n;
+
+	n = __print_txpwr_map(rtwdev, p, end - p, tbl->lmt_ru996_484);
+	if (n < 0)
+		return n;
+	p += n;
+
+	n = __print_txpwr_map(rtwdev, p, end - p, tbl->lmt_ru996_484_242);
+	if (n < 0)
+		return n;
+	p += n;
+
+out:
 	return p - buf;
 }
 
-- 
2.25.1


