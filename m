Return-Path: <linux-wireless+bounces-37220-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAOqOGTEHGpNSQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37220-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 01:29:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A3261848D
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 01:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B985300D71B
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 23:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94730341660;
	Sun, 31 May 2026 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+MRvu9f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC320378805
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780270169; cv=none; b=mxbJg9LSf0NL7d/ZHWU3O+utGvisQWJBQCNf9Zm2/alCAKXzM+RDDu7dX8spd/llx/H7ZLQp+R/Nj7Uagy8v4iGFegjCWjGrDeUKakI8wdXRv81sHxChzIJxwrLPDNjaIycD/YC2AQgEqFKKf9tNwkf6C0oqCZro0i42nNi6M50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780270169; c=relaxed/simple;
	bh=btAnkxSqikgTLUXOGnFeFn+CgGjtOPvUo0FCBtt0o0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slSw43pmzgGOaX5JUha8qzLWZ5MlRQJqBROM8NItkMdauHyTTLkvP4408PKH8EB5U/8l+NYEKJm3E2usapjaQjJmyix3ioz57pmr4xv+3gb9GdR8MRePQU2ropRjhXSe7S3nvlFthph7XCN1nC1uHPBfN7Hdy2r/QIwejS23Gbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+MRvu9f; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c858dc05ee3so743182a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 16:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780270167; x=1780874967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGsMYizei7pkUnU2KA78P1yshIilGxAcASEAOC0TMQE=;
        b=l+MRvu9fRHawIQdM2adBEQuw87speYioVglNTeqtCr56fbBNiKpPmNQ7YNFYS0XUBD
         GWVENO7q8NXXDZFg3Q6/AImM9s30RG6eoYXcyWVcYrXW8qTbERmuY/mfuOqcWFwJJf6X
         Xq4IWHrSfYarwgO1STOR3kHfDJQyj8rMMmjVqtBSXL18Kyen85GNRxB39Ydj8cLPjbQo
         FT9U40vfeXDV2ZkW17JDquULy/5gjZRsCeR64LEErNOr1Q5cPZ0wx/hHcE1+i0B31Ix2
         rBcHlsPCsV35vUzwRgdzLGK7n3bX6N8aFeg6UYXkouoIPyTKbYyAV/lgxU35bmVENpra
         bTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780270167; x=1780874967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TGsMYizei7pkUnU2KA78P1yshIilGxAcASEAOC0TMQE=;
        b=HGv1oebSJOnsTgsVJuneHmYZLU+6TFdj9+i7ZFkoD5TgGfU6hCrYuz84eYWbJOZ3Lg
         kiZZRijquRfPTfo25mQH85cUUEs0ovand9UqEqceSjDYZh+6n0DTWz/iJwoCjuweu9fc
         tAr5x8IpUNiaNO+7VTvKTTPYBWbT1sZnF9bIGDeVB4drizReTngB6w1ljag+wVlX6WRp
         5itE+Yf+ewRRh6Fp+8cp030WYLD1ZOuFWqMQCn8kNmmo6KLmrUZx/VyoYeRQsr/8SUaZ
         wIf94MaVV+3q0+ORzdjMqLLmlHRmen5O550FOI5QLN5EjUI+/opqtWItIt2ceI2geD1W
         p9WA==
X-Gm-Message-State: AOJu0YwDR9LzIm7bCcN5PFTC/6UVBHRsyOXw89/mMjblKKpG+zYu8SS8
	g0rqdiBEXoME8zgWt7jMo4iREg3gs63j3D+MMS/KZbSibLFCo9MjKfpdlRT7rh91
X-Gm-Gg: Acq92OFNn2FK4T4BAR2j+bE0ivEn1FMWJ/QKuF8xDMNSAFI515YFiCrVpkapwTvjuji
	3/CTl+vE7bNmhcOTwohN7E5drOK0DJBzwA1auQmG4gLPGGsD2n4uO8/Wn+GLAjI2q18LOzVfLUR
	nY3DsqcI/TYQVt2OiyQFxcP8MaWE8BZ/O9YG6upKkR/ZYrz3qCyU/kSavJ/JMtTe5jzGo9hS1h7
	jYOuS3d++0A1R24wuo89WikY3ge21okpcLufRXCrIfBvHmcsRmn77TvRVdzGy9HZrw9K9HMFZxQ
	uFm25s6blcVuh7GmGAIlF8gm53fpGTlXGP2+XG65q9mDqQeTLgHrGq73TpfQ+WzNe6F/SuwaMQb
	ihKf3Sy1EGxj2bQqf4wHuYrzRFhdOJbWB/SG2dHfGSJBoryhQTSyyDr5eZwQXg6dDC+dbNZtt+/
	2UNc3ZTzZtX4NBpF8BCUYr43GC+gV+1Ic+9W1OumJJNFOmG6voRkItUHji0vaqMy/SUs0=
X-Received: by 2002:a05:6300:6d8a:20b0:3b4:640e:f6b1 with SMTP id adf61e73a8af0-3b4640ef9a1mr158764637.10.1780270166976;
        Sun, 31 May 2026 16:29:26 -0700 (PDT)
Received: from BM5220 (123-194-40-181.dynamic.kbronet.com.tw. [123.194.40.181])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c85772d7342sm7954473a12.26.2026.05.31.16.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:29:26 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: zenmchen@gmail.com
Subject: [PATCH rtw-next v2 4/5] wifi: rtw89: 8832cu: Add support for Mercusys MA86XH
Date: Mon,  1 Jun 2026 07:29:13 +0800
Message-ID: <20260531232914.4406-4-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531232914.4406-1-zenmchen@gmail.com>
References: <20260531232914.4406-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,realtek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-37220-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenmchen@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 42A3261848D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the id 2c4e:0127 into the device table to support Mercusys MA86XH,
a new 8832cu-based adapter.

This also deletes the id 35b2:0502 which doesn't actually exist and was
wrongly added into the driver.

Compile tested only.

Link: https://github.com/morrownr/rtw89/commit/40149484a9db41a4146d2fb4980c92017c5f552c
Link: https://github.com/morrownr/rtw89/commit/c82b4b42a93c2d189a11306701552d4732dc9fb0
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
v2:
 - Fix a typo in the commit message (actaully -> actually)
 - Add missing "Link: "
---
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
index 790fd1dec..2162dabbb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -53,9 +53,9 @@ static const struct usb_device_id rtw_8852cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x28de, 0x2432, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
-	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c7c, 0x8206, 0xff, 0xff, 0xff),
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0127, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
-	{ USB_DEVICE_AND_INTERFACE_INFO(0x35b2, 0x0502, 0xff, 0xff, 0xff),
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c7c, 0x8206, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0101, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
-- 
2.53.0


