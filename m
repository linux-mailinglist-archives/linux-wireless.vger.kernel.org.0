Return-Path: <linux-wireless+bounces-36967-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i4iyCMR1FmqemgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36967-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 06:40:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6845DF341
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 06:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F5D2301FFA0
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 04:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D27E27BF7C;
	Wed, 27 May 2026 04:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsHPxWQS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927C45039
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779856832; cv=none; b=MIWfBQfQrmAQpvnvpdipoQ+T8CH7c8G4mf6cp4vvVasRNr6SZmhuRAmFnjdm/fDO0elOTqspKfx7/DFNkX8J9WGyT2U/Ecd/u1yJn/8i5X3zVLhg0nz8V9SvRKwjXEdpso647/+jl5OlqoLUEz0g/HE7qMGOeP1amXaRLNVlxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779856832; c=relaxed/simple;
	bh=ho/CrAiKJhPMA2kcw8VC3EhTDpvk89CK+QkxEMUMleE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7OlyxPDnyvjrRxO5ZsFfByxrPRtBKdPJVVmUH1Yte/UTEgxLz3Evkiz8L6HwDU+O4OZrLY2fa+TzJOpMzA4FdkcFN6xlN33Plsn2E7AZrntvcLXB2GC5WtBQkrSEvTYFfI4JNTFP46i7Ke9SgnE6snXszE5ZPK9Okhda0ukRXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsHPxWQS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-83f674f978fso4379029b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 21:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779856830; x=1780461630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9O67c11aqDKJlfGRKT8nZNPwERXcewHGX8qdEB3V+Ug=;
        b=LsHPxWQSKzJxd3HDxJ6IeE8Lzv3gBMDXeTEjC5Qq2UURGJkcuQU2ocwGB/JN307dNl
         aeKem943c855fpw0RzsCR9HYn9Rs3sWJ3fhY5HMhjkhbWe5wUH74yoU8WShDbCIXcwL2
         gE6e/AOupQUK319gzr6+DWrj9VgrXAI7wGWwb5BY6g0XNfdTc4+bEchOMM+61htCoNSk
         6S5u7+aC45apn8Q60FtKejmGYyovDYM6+75nQLU6N5GIwJmtWgFPIfu6Atv+SbzPLHWj
         5RTpYr27E/76w9Ll8Oqig2DXPwwGOkCULn+l0eB+hWCC0STC6eS0fD/CdEKz0gx0Y0di
         32Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779856830; x=1780461630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9O67c11aqDKJlfGRKT8nZNPwERXcewHGX8qdEB3V+Ug=;
        b=dlp9k1HWf4V0Azfr0q9M1g7OR4ILUDrumrVSKCMSJxac4xs/REN++F7mm8ZmmKIRj2
         3K8BRT9rBXCZi2/+1BWOqb2wn3HrlrfYKeaTmiCd0bZUgmBWwOlarO0lJQI2wHtnRiZT
         ZihQvSOP27sQYsm1PI1STUfuNAtN4J/fC0vDIUb9viQzO6J79laX2TbL8CwL3Z9UTlLL
         y7vCCDwZLAuVF8/QAZjgFBX1fzsiluqbFASGni3whPl9u+iBDbcvdgNIGZk6S0pKbjJb
         F4JwAnx7OYwaZdDFfDUsTlweH4yHMA1Uaw9X4GqaXYiU+cvOU7uxR0+MGFqrdyGGJb+Q
         3ZqA==
X-Gm-Message-State: AOJu0YwiH2y5VUMGSNIySg3MwLgPis428pQRspj4Bo1onWyr90a1Oms7
	NWcK0l/KG4QFkhCpaSQy3RIzbx3g+Eo6FjJWkqnLHyhaaKMHIix6ZRbdj3+QF4I4
X-Gm-Gg: Acq92OEU25sADFK5MDiTB0mUUGWZ0OiR7xysEIrs3Vi0rJtfbPKZ+/6USiv0XB0U7AR
	lCeD5oy0rFobSERr9yE9yp51z1wQJdYBw/p1CXZMd6tXA8+0cG4QjtU19KqkoU0PVjQ/FjQJYwZ
	YGAmTo2tmos5BtXrVjjE6wfzUWSupEjrCcUb80ABcSxxDveK03JQXY+bE2ciLP/ESGv2TN0Y9v4
	TJJG5Dl1L/AjC7F+hONOoVboaBHfFsSUtdS2tQ4FtVHDBU0q0j16dYodZQeOz+GKYyvTYbNladM
	MbU9R3QjBFmb2qxcEJkQ2NHRZ4yY2AF2DVgbIwNUm2LJ2EaErVCly3AWokAMwM/oOvElWUC2gTS
	ee+B0zs4zTuDmGmylaZg2a4rnniNeFhOfrzsZZgqd2AHi9HCHXgj6A4mfxQMcALkEQLhg78kxko
	mKao0DeNto1KK5fbgVsMBza7dhhYIvB34M1h7yDpthy8TKO/QQP6jaYj4=
X-Received: by 2002:a05:6a00:889:b0:81f:3bcb:af2a with SMTP id d2e1a72fcca58-8415f407d35mr20539786b3a.26.1779856830043;
        Tue, 26 May 2026 21:40:30 -0700 (PDT)
Received: from BM5220 (123-194-40-181.dynamic.kbronet.com.tw. [123.194.40.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-841d6e806c7sm907522b3a.1.2026.05.26.21.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:40:29 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: zenmchen@gmail.com
Subject: [PATCH rtw-next 1/5] wifi: rtw89: 8831bu: Add support for ELECOM WD{B,C}-X600DU2M-B
Date: Wed, 27 May 2026 12:40:15 +0800
Message-ID: <20260527044019.9192-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,realtek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-36967-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenmchen@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6A6845DF341
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the ids 056e:4027 and 056e:4028 into the device table to support
ELECOM WD{B,C}-X600DU2M-B, two new 8831bu-based adapters.

Compile tested only.

https://github.com/morrownr/rtw89/commit/9e2db2834b37c6adfc4b872a9ef56c927df22bea
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index 6a8d31544..343941ccb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -37,6 +37,12 @@ static const struct rtw89_driver_info rtw89_8851bu_info = {
 };
 
 static const struct usb_device_id rtw_8851bu_id_table[] = {
+	/* ELECOM WDC-X600DU2M-B */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4027, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
+	/* ELECOM WDB-X600DU2M-B */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4028, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb831, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb851, 0xff, 0xff, 0xff),
-- 
2.53.0


