Return-Path: <linux-wireless+bounces-33817-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIQ8HFWOw2lVrgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33817-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:27:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAAE320ADD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 081653042B77
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 07:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DA5371D07;
	Wed, 25 Mar 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="P5XJNEI1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C7371041
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423372; cv=none; b=DRF9BtKv7ax0utJ8/EBNhm5A3cK7a+F0YwBkYF3Hlc2fMAZlphQGznTQWfWIptFonMbZYnILW0P8g353MK/s3Kftba2uLIxHwwmuYZsSa9ecNdOnAoWZPGN2F+1pVfrYkARSwWQx9TnaSRUHk+nu97TNov9SltLhkNU+DOqrR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423372; c=relaxed/simple;
	bh=7N/sdGk8p8ihxpTDp7fkK0PAJ/73AX2g207BTzM1uDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8n+FyF8dwdR1ZRIm4aFxhIrdSut0PYUmBB8hYzZvdUUZ+Gf6/fQr2oHp/G983TI8rO5/Yp6txaP5L00ZYJpQl3XoK+2dhfe55wexQ2H7/NRffG+SC8ciiynZnW+oQWs3Q/eNAA1hK5HjPjCJtgYezWiaexa7esyeyF4REnoZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=P5XJNEI1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62P7MiwB62939590, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774423364; bh=6ZSbBw9t5rG21qdRausJpNMCjLaDRO+e8biuRITLCGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=P5XJNEI1Ojn03uhZlcHqYD1Fwgdkv69cF9chDitEzDTiUz7wCJ3xpBaYpVImcL2Py
	 JAemEE11ZgPwk3nxivSCU2DimCEpIc6rS7E8HD/rC1hqHpEgHR3fU8shstxkcbnGyC
	 vTJYvyirQAU18/+/uQjCWTfpc6j6Y8zaNmeEEATBBQtajCXO22ZFcmk0zD4o9tJP/Q
	 y69fJOTJjS87UrNpQFEdLml4JQJxoyoh1yB0gG2DZcRweA/bb6t6SBe7IYpoVLXddc
	 31QkG4GMjJDqLblZQNmwVb98W3rxF341pwVKdK6qKIwNh3wUoH08XhVqsH0HE9hPeD
	 koKU0z851wxyg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62P7MiwB62939590
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 15:22:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Mar 2026 15:22:45 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Mar 2026 15:22:44 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 25 Mar 2026 15:22:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 8/8] wifi: rtw89: fw: load TX power elements according to AID
Date: Wed, 25 Mar 2026 15:21:30 +0800
Message-ID: <20260325072130.41751-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325072130.41751-1-pkshih@realtek.com>
References: <20260325072130.41751-1-pkshih@realtek.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33817-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7BAAE320ADD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zong-Zhe Yang <kevin_yang@realtek.com>

For different A-die, there will be different TX power parameters.
In FW element header, the corresponding A-die ID will be described.
So, compare runtime AID with that to load the target TX power
parameters.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 13391ec9627c..52db41c67265 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1153,8 +1153,13 @@ int rtw89_fw_recognize_txpwr_from_elm(struct rtw89_dev *rtwdev,
 	const struct __rtw89_fw_txpwr_element *txpwr_elm = &elm->u.txpwr;
 	const unsigned long offset = arg.offset;
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u16 aid = le16_to_cpu(elm->aid);
 	struct rtw89_txpwr_conf *conf;
 
+	if (aid && aid != hal->aid)
+		return 1;
+
 	if (!rtwdev->rfe_data) {
 		rtwdev->rfe_data = kzalloc_obj(*rtwdev->rfe_data);
 		if (!rtwdev->rfe_data)
-- 
2.25.1


