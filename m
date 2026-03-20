Return-Path: <linux-wireless+bounces-33593-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AZjLyFrvWnL9gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33593-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 16:43:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4480F2DCD05
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 16:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88CCE30342B1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24963199D8;
	Fri, 20 Mar 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBIwxK7z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F88308F36
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021308; cv=none; b=LKJ+ozieFiV8P6AQCbcf6adiuTxUj7f3j5iloZOyWCEgLNVHvOrfEwVmUAQc/cRAZz0BFOQAwaFIXPfmpGmh+ENFtj2at6j5JjsGgRDOFpQEQGB8fpoF9fCs8ITqbEI6dS8JEZsH/PtdDn/Zk1MqHjCPkOipeFD7y9IxZ5ouzlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021308; c=relaxed/simple;
	bh=gx1YhthFDXzHnIMSPmRZkb4BdhQAaIFeZdl1SLV8HQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnWiGaPMnY14gmbu/d+JMOlGvyFf6+8muhf21A8yiVzEgQEELTCTm2K9M9GPkevf8C9bhbT+I+lnT0RyLzK5EVDPCwmnBrSqILKsHARkdqzHl/u2H7MBVi3yl8YNXKBx5GoC6xLpzeQwP21I7pFMbpuDU4rdlA6PDsp+siiYXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBIwxK7z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2adff872068so3649545ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774021304; x=1774626104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIpW+vFvHCzKF+T2hKfffBvDeXS4/VHT4dzFoY20ou0=;
        b=DBIwxK7zC1A2a2hH0Ag73WR9r8nCNQvOI4MIfVKdYZSk2/YamrfVOfxwmVZ4WdF9II
         tw9oLS9D9rMmQrMg6RO+oeluOa3DTc3H7nSnjIJN8gu6FlXrNdOxjNsdQkDPDIfPGAoD
         8ye6vrQdCeIMDPS5yRXDqYdtIzH/Ya+/3m4C36W1j2FkatOsYoJfjL/4nxaADzRUXiAf
         ukA2MKA0GIrl/4Ynjy1YBeh7ZlBfbD2CBc77+cvOoeRSGgr8xU8KuVMtYiWdkOREj8Dj
         y2GUb43EufrM1nYkCR3EP8l2z7OSXvQCZjfCnSXuUB3pvPOLNWa4SPug5M6Jtm7ATbSU
         eZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774021304; x=1774626104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIpW+vFvHCzKF+T2hKfffBvDeXS4/VHT4dzFoY20ou0=;
        b=k71RgEGpOLKbNyIJiZ1ppCJdKEreftkXhRFiZbEvoo8pQw5X2VDk6xvODBmiEwoKtV
         c4KZzVkvTEyJKP05GsA9DnNnWqZW5gF9c9B7Xm28J+V0pmqiYttmF637DNqrTSR301zw
         pHQUuPh/8dtnSdDyxhxckS6CI8mCGYmkNoBgcJOUGwZOYaOKhQ13Vz5PVRN0f3Q6dmoh
         3Y04OFbPEvficVzLiJoQYmPFfamQ1gy94NgDDnZErB1sYpe/ytNGqmWE1ilpdpOtV+os
         z7X6221dqQ4J5kNAFGoj77vD0a5TijE9Vztx21l8ZURF+O3dryoTwIh0Cq2BDvwIvDNv
         7Teg==
X-Gm-Message-State: AOJu0Yy8QwBI9pXk/fFX8Q/7fCuulZ5jyfnfKseqF4UX/CB+GXZhgG4r
	/Qngp/RwWrUPTbTE86izwpYQj7Q2kkafrKHPS/7uU+PeJuNVNXEVac7AFl4qs2Cm
X-Gm-Gg: ATEYQzxrFnSTJc+OvNshcjCsnSYqemt1vbB7g39pD1424E66EfQswu8+qR34UrY8/Dd
	W1tbfEBagTaxB/0d5DEc3H4QZqIZDvQr+pzaN1P8Wms4/L73Khp4hBYKxUtFupAi0qEmiMmJK+5
	uxGxt8et7ClSx40BFD7yim9ro3HIKxNy7H/lKIrmAdLVzPnLHccvkPTaP09k89y7o/wfbV91BO4
	pOJsqftCVlGP6UQL19iaIUxx5e58RFQcscvAFhnUInNWcpgMwdApydenMGO5yYw7nOrNJCkNK4Q
	mHq1/5ZpWXzV1jAbfx6BT34Z+S/IV7VfpVLlOr4MKx3SnlfGs6yNhcmQW7iA8Fu5x7J6+/M88ta
	pIclNcnvWRqsFjdUslpbhohgNfPGxKkENRPrwHYqRbb+BWCFEpwUPd2mUFGokQg5qNKX6nqM2Tu
	IIG79JJkI7u9dBVBOcinN9/ozSRIJ4RBTTOdatvLad1pl3LmGRx8dzQRjaQqicC+Q=
X-Received: by 2002:a17:902:ec85:b0:2b0:4ec8:fb92 with SMTP id d9443c01a7336-2b0827d8deamr31938955ad.39.1774021304503;
        Fri, 20 Mar 2026 08:41:44 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b08354bce3sm33197205ad.32.2026.03.20.08.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:41:44 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: usbwifi2024@gmail.com,
	Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw89: Add support for Buffalo WI-U3-2400XE2
Date: Fri, 20 Mar 2026 23:41:36 +0800
Message-ID: <20260320154136.5750-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33593-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,realtek.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenmchen@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.898];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4480F2DCD05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the ID 0411:03a6 to the table to support an additional RTL8832CU
adapter: Buffalo WI-U3-2400XE2.

Link: https://github.com/morrownr/rtw89/commit/506d193b8cb7d6394509aebcf8de1531629f6100
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
index 0c5aebaed..86be0981a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -39,6 +39,8 @@ static const struct rtw89_driver_info rtw89_8852cu_info = {
 };
 
 static const struct usb_device_id rtw_8852cu_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03a6, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xc832, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xc85a, 0xff, 0xff, 0xff),
-- 
2.53.0


