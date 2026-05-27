Return-Path: <linux-wireless+bounces-36970-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NeYD8p1FmqemgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36970-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 06:40:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0655DF34F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 06:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F1F13028EA1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 04:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AF345039;
	Wed, 27 May 2026 04:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvT0hIbL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED129B20A
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 04:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779856838; cv=none; b=IpEfClVaX29sDkAsNXDQjm/qoBEEhtfYBIOMYux7+PBl4+EMWGEA1SPQYFRcMkozpETY9VN+toMaMzVlOvARCMnFnyIP1bK0wWNTjRMcIQmfwHh3YahGtO7SVKlWjXwUcLMnR80K9dYJDC9OiPZ+O/Azv7lV4qNH51KIBgABErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779856838; c=relaxed/simple;
	bh=dmFsIk/WLCAL+7cdTAMEWM8Whg955WkMWM/WZhW198o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGPmWbGcNZBZYXmFudIZ1733ahMPrxuVEPr1I/uZ8akJ9zokTxw0fDOj6G5G6jlLkaMDLQGgPkDZKVfHROXXOIq1u/dprc2BNNfXoLxUV5TINPUAdNX6zffnjPhmvgftUr9E8DHBPQ30Ok35MWG1chtph1SFN4Do26PcnK6UK9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvT0hIbL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-83537a80ab6so7836933b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 21:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779856836; x=1780461636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uig1ar0ubb1IdQjR9df29Kp7MA+4ff8WWsdNWtKOIAs=;
        b=fvT0hIbLgoV0uYzALPSf2Uav+YcZN+FtQTkJte2fEdRYZSMddLb20HTN1nzHZD/DiF
         3RFIhkr2FZ92PXiMjIrYB17AbOCRfYGjLeE09KxfakFRGKRNSsgdfbjJAtC75l3/6rlk
         3KMDla/JLEF8xk7LJg5l2NCc/Hp7hCqhHDo9VY00KCgfhui/3fkFCMJdhYx50LGeMSld
         DfVI9r0lgLDIm4JHiFco4tHbrY7qdvfYPuYMnSHSsHRhVp1c6NuYIGCHwVRI2+6Qm9aE
         1h9JgYZqO6W3T1Vd+1obQKF4hDrAvAwMuqj0xU5UgN9+ESzu01tyhcz+Yuyr0e0Y0+4Y
         XSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779856836; x=1780461636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uig1ar0ubb1IdQjR9df29Kp7MA+4ff8WWsdNWtKOIAs=;
        b=rZu8UL/LuAqyaan4N4DKc/N35IbHvTaPpJ2ZC2yD6KWUOTNwcBbnOS+X5F1QLZeWHD
         NBPKAOHKQDcbr7oyu4JiWKcTrciP2fMM/Wv1KTKVega7mZ83GxWxW/9ZE9RZgZssHbTh
         a5G2RZwa5rC2Wd2ILK+Xqd8y0pZC30GoBaDqBriMj+N/zhnqpSYBi0rT7dnW6UV5LkvB
         4mAE2HwmM6WAAnvo+Idh+kYImFt07U8ZOdBofpGHfUECVTufXgTjT24koaUA9OQann74
         ZGI/9457P4YbWZqjRY0MfJozK1qUaqmKvdn0BZSj8S86od7rFjCcieZogvTYeD6qsHAz
         s2GA==
X-Gm-Message-State: AOJu0Yxi04VHc2MT2WdJibouoQl6m6NYUapKhaOX1h0DE+FDr6CqZzLs
	1l9ivKIDs2PxgiLn/2nxcqn/BrAV5M1OlSOHZgJuvev/IcZNjwOcS+pOPBlukTqK
X-Gm-Gg: Acq92OEfvLycrE1yIbjdSgAL2VdQXnzs44FctkhFzg5eZdnvlnNWJfZtxpkMFMvu78X
	s/9TLI7oiY/L0kpZ84BUub73vAPPZyu++LZRZJ6auk1UR49fsJiBDqDywxVFQFq7/A4Dslehph8
	lC3gDOgkYqJ6+c8hblMeP8BFqJNAn6kqErMo622BC8U5mRmgWUEI/hci8YSPLlJbRugvNUl5VDE
	+NojnVvQUKFB+WVqRGDuZO/N9nFokXLq7X3VKgLmA0cpC6GaExRkJG6XmEBY3aQufChLq+54qD5
	GtpuNFA/s20b8NKEW3mIq1XS1g7MByXS09UCbnMJJrtS262DJMGd7y1kWsrVcwpWhke9FbBmoIc
	ZH8tiF7OsmXtQdNx33x7szC4a0/pdxGzhiTdjyKOyIbWbC+nL+nFwdp4umJpjFhK1FbezZOkBhG
	wGOlJ6bviZ3b2UCsalVliUQRDp8I9elpDiTT6yXq10ETxRRl79Crt9PFFALGy1o4mR1A==
X-Received: by 2002:a05:6a00:391e:b0:837:27f4:ffe5 with SMTP id d2e1a72fcca58-8415f18266dmr19836486b3a.19.1779856836191;
        Tue, 26 May 2026 21:40:36 -0700 (PDT)
Received: from BM5220 (123-194-40-181.dynamic.kbronet.com.tw. [123.194.40.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-841d6e806c7sm907522b3a.1.2026.05.26.21.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:40:35 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: zenmchen@gmail.com
Subject: [PATCH rtw-next 4/5] wifi: rtw89: 8832cu: Add support for Mercusys MA86XH
Date: Wed, 27 May 2026 12:40:18 +0800
Message-ID: <20260527044019.9192-4-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527044019.9192-1-zenmchen@gmail.com>
References: <20260527044019.9192-1-zenmchen@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,realtek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-36970-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AB0655DF34F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the id 2c4e:0127 into the device table to support Mercusys MA86XH,
a new 8832cu-based adapter.

This also deletes the id 35b2:0502 which doesn't actaully exist and was
wrongly added into the driver.

Compile tested only.

https://github.com/morrownr/rtw89/commit/40149484a9db41a4146d2fb4980c92017c5f552c
https://github.com/morrownr/rtw89/commit/c82b4b42a93c2d189a11306701552d4732dc9fb0
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
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


