Return-Path: <linux-wireless+bounces-19510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E2A4706B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 01:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14606188DA75
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 00:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E51C27005F;
	Thu, 27 Feb 2025 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntH2SAe4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7155727005B
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616916; cv=none; b=gbwT85cyFlnO7QULPCGPhjtz3TySzhevQjVtiO7IZBEMb5d9KM9YyZ5ZcLM0sOkzaNERg3bg8T5Rv6zwPxNJP2TaHEm159A1AR0QXP+an+TlwU+taGFslIg145hm8WI8y+PM6FD5GYWFEBOWletUmsxCIEMmZMtDn2VIjMVqpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616916; c=relaxed/simple;
	bh=jjLX3E9Uz2dAvIJU5cmicvTUYmwnQ805IupmJvYnppQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Se1z/3dQfpQe5a4b68+sawQWZKF8zEHf/IPp/eLto8an4Zkt9k2IARRbWGFwIsW+phLwfwO9IwClCf8OWERlE5pmp+NNNKY7BUyHuZqgZjzEKyyRBllgV8ngfoDtYM/UcGl/zigbvQ2qbJSRHhKiJvnN+q6QG0/4+BUGQ9Z94Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntH2SAe4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e050b1491eso2512465a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 16:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740616912; x=1741221712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sbrw/CHRFzX7Ch3OZBesEyICrWDvADMFXlHhDEFqYuI=;
        b=ntH2SAe4EvA/ZObOy4iRyEXljuOx0xcHDFpUV2UXWbXbAjUpFsG9KUL8SDDRRVqG18
         5/rvLNd5cK1iJ5P0SylGriQ2UVQwlhepVPVU4qzzRjq09ciGLfXiWDTTaxC+f1gQW0qn
         /Yo9tkBQxC85y3fJl9nK4hXn7GXa/7tJ2ChYIr/iF6nNLaWSXDdS0bdRtTeRc9PHlhQA
         Zj4N5gzVTqmHXr5nnzkgJ1sYv3L7ZNyCspFhXsgy83zWhD3UtyQ7tfPANMmOAjT5Ai7l
         QBQjC+lKKrYLOFBLkojCYGE3DkBrUbjisJwTjeYumenLiAc5cyptkOszMeCgPJPAXUxB
         Ch+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616912; x=1741221712;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbrw/CHRFzX7Ch3OZBesEyICrWDvADMFXlHhDEFqYuI=;
        b=GT6v0Mt7k9eN5wuHyEMyI73aGRZjeTP+/d5DESvA6dJ4UOI+DbPB6MrIj43+ALqpw4
         2QvJ0HClgKrMsJRfwEEu70NflAER1gE1+O/4jnNBoj9DSFw+U38VEgSuT4QzHA7pIR36
         e02jlv/NZNMGX43KTgn9+qmOV0JhqjXFt3XATk35pkbp5q03vpHIfcgmJxFlh48F3Jz5
         qCzmXNWYaZLE0tWV97jFiWI5e+LqcQ8LdrXhzl4hxeFGMVDf8z5eAZvLZog/ZTo/K2pi
         3zhsQh9a2H4RTk0b3Fo8BuqmkeLPFhJq0mUjUdO23ykFKyQRuBaZLu9d+v/dVj/2iGB6
         VbIQ==
X-Gm-Message-State: AOJu0Yy1rA8KwShqaWgqeTIcBuHCFkn7EpZuXr0Tc/CTb0jmqiT/XvIU
	xZV2rS9y1r0y45THEHNmM0X/rSOcr5rjE2ifMUJaTT/xYCZxlg5gDNzb0A==
X-Gm-Gg: ASbGncsomZt3Cvi7SwzLWZmQvQz4E8cdyYyyZkPctU2sRwx/woYurQZ430WLtGKs4q3
	hX+xKF/rDnDq7CFeOUQjGq34Eou3w3QPaz4lCLRjGoNL7eQlgalsmyTZKBUaekbRLFqiSCXd2KH
	wUjMoJT/1uoiMFCAUQnrrDCXUJirNEWHKDAwJIKejQqXFLBTskNCM83WzRZ7fK7hbjTQ5gsUSz8
	4dcLausQUcl8gZRqSajAPyoFEi7hRzLgAf8BHmZgXdhj/KubXXtdRsMjPHwJIJ5kXlcyByNvM+I
	kl3B0lE+YtIr70dcBqHyQTntnopfbCWhKgI=
X-Google-Smtp-Source: AGHT+IEYNG5OtlVS0FXDShyRHdvgXy5PTEIlpZV2pBq4FB/3vZrXVhBaLvyxVmDXStogi79QuxgK3g==
X-Received: by 2002:a17:907:3fa7:b0:ab7:843c:2cbb with SMTP id a640c23a62f3a-abf0604bb62mr187771966b.11.1740616911503;
        Wed, 26 Feb 2025 16:41:51 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dc59asm30036866b.69.2025.02.26.16.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 16:41:50 -0800 (PST)
Message-ID: <b1768755-1468-4ba6-8782-1017853525ec@gmail.com>
Date: Thu, 27 Feb 2025 02:41:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 5/7] wifi: rtw88: Add rtw8814ae.c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
Content-Language: en-US
In-Reply-To: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the entry point for the new module rtw88_8814ae.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtw88/rtw8814ae.c    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814ae.c

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814ae.c b/drivers/net/wireless/realtek/rtw88/rtw8814ae.c
new file mode 100644
index 000000000000..51a87584179f
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814ae.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2025  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "pci.h"
+#include "rtw8814a.h"
+
+static const struct pci_device_id rtw_8814ae_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8813),
+		.driver_data = (kernel_ulong_t)&rtw8814a_hw_spec
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(pci, rtw_8814ae_id_table);
+
+static struct pci_driver rtw_8814ae_driver = {
+	.name = "rtw_8814ae",
+	.id_table = rtw_8814ae_id_table,
+	.probe = rtw_pci_probe,
+	.remove = rtw_pci_remove,
+	.driver.pm = &rtw_pm_ops,
+	.shutdown = rtw_pci_shutdown,
+};
+module_pci_driver(rtw_8814ae_driver);
+
+MODULE_AUTHOR("Bitterblue Smith <rtl8821cerfe2@gmail.com>");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8814ae driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.48.1


