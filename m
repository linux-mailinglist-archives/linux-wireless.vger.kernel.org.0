Return-Path: <linux-wireless+bounces-32244-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J0UKVYaoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32244-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:15:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3D71B28FB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84DFE317D931
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5935B345731;
	Fri, 27 Feb 2026 04:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="3f2dQOtS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CE345740
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165536; cv=none; b=ArC2nLwFA9QEMlCR7M7//eVzLfJWFUSrzu/kgFq1vxpEwZ8Kz0AVW5tCjUgzSTz6lMLZSx7gmlsGciOfODK1OiMadddPbLj8hDe3gB4U8Bkh0ZJK4VLn/anz2M9KcYDqU8lkNWkiYii/0lY5L+vIEiYmu653ud9kDIFXWExACOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165536; c=relaxed/simple;
	bh=PfaE2oykh63PRByo/98BnFbDnWqOF+gJJ/6JbYmDqZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVgpzR0Gs4879wHfOdOyBqnJTpBafbJDxqd9tcq+23eowEBTg3lQBNk9QSorDAe/bVQpX2t/644KZwxo7xxYOs3PhR5TYeh02INmhwdQivx/cfM8sQwbNPq271lwBy974js9ypfJYKjA9CLMGG+pSQY3uH7uPo2upgEa8J0i63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=3f2dQOtS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aad1bb5058so15291245ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165534; x=1772770334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybBEY3wHcU2hbqLjENyuhDp73IxC8jpoAT1ZAaW6Ou0=;
        b=3f2dQOtSjXqtk/4As0R9N2x9aIckSHzBYmJz1FTtcfTs4YEEf7BWLpGmpuo/QiE/W1
         uZHxxEnGO7F0RknpbtkGJ2VNtY7CK8g0OwyQ2yWvuA0aYNL38ohjZD2w3J4QQ2A6z1y4
         B6gRZ8NmeXVDhZWU4l0t3XnQ7GmhXKhufpRdDmhCAZz3KBpwIUXs9G7/Ut4rIsNfiE2q
         du/xehBQcrPoY67xoki32D8h7FUnfb8ZB4F87hMU7kWryRXT3l/SAWcoZzDTwY/dd3Kd
         FGm/GLqkhc39wxs1I5KznZnqD934owHeWgGg/2/7p8UmoQdcAp+rYz3TpqnEj05nxqyF
         W7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165534; x=1772770334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ybBEY3wHcU2hbqLjENyuhDp73IxC8jpoAT1ZAaW6Ou0=;
        b=dDSD+ZjHoWhSzs9uLDR5Nqfj0zASQ0HxYFJNpLklME6Y89f1y/tkBeCwLqqKhrGuYr
         N6mWzOGd4ok+5PMOKnFph3IzwI96A3uUBJ5+wXYd4Ix499Pzxr7LFB1UuKnQ2moZKDst
         U5odmbqDfQuWgQoVG+TurC3ERushpk6JOVNoXI/5XCkiS54a2gLF3/CZ4tB8Y9GAlxiK
         BwfG27KxQwJFCxe8Ro/x6UKt3hIdlGP37sxMWrOr+AlchqlQNp7oOct3xRgK2cYcq7cu
         o3IU725IminhXYiANF6KUT9JNU5bRZ5AzN6NdOEhHTwi/dFyhbba+qyOeFMzC68DDqtc
         4CNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoyTNqyjTwf65105rgKymFvR25fhP1BJelb3+aKVb9d7/vt4fkBG6p7j6bpGBDptLwx6OlQjUGUz/Of8vumQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpsnAPTtFRnDHFysqCbk6XV8BcUvJByPaZOHik32XrscSGXbV
	vJOanTwQxo/yI4zkghsJLxRqL+U4XB0ydjbHvLH2QF7P8g5DuPMY+JLIckMw5zQNZBU=
X-Gm-Gg: ATEYQzypL11O4hHV2sg8PLP7DaIm15VIN7GRZ3Zl1tvmxy3iwJKb1tFgm3nI2h89s7A
	5UEXww5fDRs/QYm8pay9HXSRwZc9Gd9W0dNYTptdGhYbUwHkYZ0n5TtqXztQcncKCGvtYdCyU4V
	V7RhvuUkWIdQ460jbjnDk42a8VxaXl99Aw2iSEQUX2Sjv8Tn4ayX78K0r6RWfSOMU0xLKXfA8Bc
	1UV87BNw6IM5Uzjfw/yY5psS8bdMO7oFl9mDKd9x92pwYEYKle26r4tZeEJtLvgRZmeBDcesGXe
	H0UbGEuBuitVqtQGWmiwOWp08l0aNva8FFqFP4PXrvJ+AdMHpxyUi80kKqvV3j6XWjfzU6fUKDc
	pZcggJ9O0A2KSPQCy0OOt+QBW8ypYN/s7zy8L3AT2VvSvq8SikuCa4SCEeuG3lDRXiuaBJX6LT3
	+ClSImXswiFwitvmq2ONQ76X0Mbzqy9qEebX2mQ8is1ygwOK4IWXtweDzTae4PFAqvFnvIA+WNY
	wNFrxCcDZPrjeeR+7oi+zvWADZdWt8=
X-Received: by 2002:a17:902:d2c1:b0:2ad:9edf:7fe5 with SMTP id d9443c01a7336-2ae2e4bce9dmr15815265ad.42.1772165534450;
        Thu, 26 Feb 2026 20:12:14 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:12:14 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 05/35] wifi: mm81x: add core.c
Date: Fri, 27 Feb 2026 15:10:15 +1100
Message-ID: <20260227041108.66508-6-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32244-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0A3D71B28FB
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/core.c | 157 +++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/core.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/core.c b/drivers/net/wireless/morsemicro/mm81x/core.c
new file mode 100644
index 000000000000..1bcb9b5a00c9
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/core.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/module.h>
+#include "core.h"
+#include "debug.h"
+#include "bus.h"
+#include "hif.h"
+
+unsigned int mm81x_debug_mask;
+module_param_named(debug_mask, mm81x_debug_mask, uint, 0644);
+MODULE_PARM_DESC(debug_mask, "mm81x debug mask");
+
+char board_config_file[BCF_SIZE_MAX] = "";
+module_param_string(bcf, board_config_file, sizeof(board_config_file), 0644);
+MODULE_PARM_DESC(bcf, "BCF filename to load");
+
+int mm81x_core_attach_regs(struct mm81x *mm)
+{
+	int ret = 0;
+
+	mm81x_claim_bus(mm);
+	ret = mm81x_reg32_read(mm, MM8108_REG_CHIP_ID, &mm->chip_id);
+	mm81x_release_bus(mm);
+
+	if (ret < 0) {
+		mm81x_err(mm, "failed to read chip id %d", ret);
+		return ret;
+	}
+
+	switch (mm->chip_id) {
+	case (MM8108B2_ID):
+		mm->regs = &mm8108_regs;
+		mm->hif.ops = &mm81x_yaps_ops;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return ret;
+}
+
+static char *mm81x_core_get_revision_string(u32 chip_id)
+{
+	u8 chip_rev = MM81X_DEVICE_GET_CHIP_REV(chip_id);
+
+	switch (chip_rev) {
+	case MM8108B2_REV:
+		return MM8108B2_REV_STRING;
+	default:
+		return "??";
+	}
+}
+
+void mm81x_core_init_mac_addr(struct mm81x *mm)
+{
+	int ret = mm81x_hw_otp_get_mac_addr(mm);
+
+	if (ret || !is_valid_ether_addr(mm->macaddr))
+		eth_random_addr(mm->macaddr);
+}
+
+char *mm81x_core_get_fw_path(u32 chip_id)
+{
+	return kasprintf(GFP_KERNEL,
+			 MM81X_FW_DIR "/" MM8108_FW_BASE
+				      "%s" FW_ROM_LINKED_STRING MM81X_FW_EXT,
+			 mm81x_core_get_revision_string(chip_id));
+}
+
+int mm81x_core_create(struct mm81x *mm)
+{
+	int ret;
+
+	set_bit(MM81X_STATE_CHIP_UNRESPONSIVE, &mm->state_flags);
+	set_bit(MM81X_STATE_RELOAD_FW_AFTER_START, &mm->state_flags);
+
+	mm->chip_wq = create_singlethread_workqueue("chip_wq");
+	if (!mm->chip_wq) {
+		mm81x_err(mm, "create_singlethread_workqueue failed");
+		return -ENOMEM;
+	}
+
+	mm->net_wq = create_singlethread_workqueue("net_wq");
+	if (!mm->net_wq) {
+		mm81x_err(mm, "create_singlethread_workqueue failed");
+		ret = -ENOMEM;
+		goto err_chip_wq;
+	}
+
+	ret = mm81x_hif_init(mm);
+	if (ret) {
+		mm81x_err(mm, "mm81x_hif_init failed: %d", ret);
+		goto err_wqs;
+	}
+
+	return 0;
+
+err_wqs:
+	flush_workqueue(mm->net_wq);
+	destroy_workqueue(mm->net_wq);
+
+err_chip_wq:
+	flush_workqueue(mm->chip_wq);
+	destroy_workqueue(mm->chip_wq);
+
+	return ret;
+}
+
+void mm81x_core_destroy(struct mm81x *mm)
+{
+	mm81x_hif_finish(mm);
+	flush_workqueue(mm->net_wq);
+	destroy_workqueue(mm->net_wq);
+	flush_workqueue(mm->chip_wq);
+	destroy_workqueue(mm->chip_wq);
+}
+
+static int __init mm81x_init(void)
+{
+	int ret = 0;
+
+	pr_info("Morse Micro mm81x driver registration. Version %s\n",
+		DRV_VERSION);
+
+#ifdef CONFIG_MM81X_USB
+	ret = mm81x_usb_init();
+	if (ret)
+		pr_err("mm81x_usb_init() failed: %d\n", ret);
+#endif
+#ifdef CONFIG_MM81X_SDIO
+	ret = mm81x_sdio_init();
+	if (ret)
+		pr_err("mm81x_sdio_init() failed: %d\n", ret);
+#endif
+
+	return ret;
+}
+
+static void __exit mm81x_exit(void)
+{
+#ifdef CONFIG_MM81X_USB
+	mm81x_usb_exit();
+#endif
+#ifdef CONFIG_MM81X_SDIO
+	mm81x_sdio_exit();
+#endif
+}
+
+module_init(mm81x_init);
+module_exit(mm81x_exit);
+
+MODULE_AUTHOR("Morse Micro");
+MODULE_DESCRIPTION("Driver support for Morse Micro MM81X SDIO/USB devices");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION("1.0");
-- 
2.43.0


