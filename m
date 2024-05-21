Return-Path: <linux-wireless+bounces-7907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAFE8CB2B6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 19:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519821F231E3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E6E14884C;
	Tue, 21 May 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aMTc0jRi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245E148317;
	Tue, 21 May 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311968; cv=none; b=XafI0pL3DAqjB03U7UREUq5QXXTit1bHd+f/8SnDGznaDVkovoGKKtiNOMUCztK//ZfTL+7YxSADjXchqHqNRkivWBqB5d4ZqDU2B1BaDx4Or8cNvSMZeR6bXEvEMARQH9qs7lraFEJ6qmuQCkGcxULTQR+msv7E9AFyAjHgQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311968; c=relaxed/simple;
	bh=jjo57Gr0OzRovClfoZv+9dQtVGRTeWuKYkbcPaEz7rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=an522sY8muNEk0Hyg9KGJ/C7UXmjAgilZ6fd+O4Gew7NTlfNmVP3QEYl4v2lFrqRaqCl+HMvkW492TDATnH9h4KEN0kMNQdQlk3kKJbBD4b28vVH3Y+6k5t5linphwiiUymRA9rJKq5Li001pUxX6YkODoksjcKHi2KidX+1XPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aMTc0jRi; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44LHIxpN071193;
	Tue, 21 May 2024 12:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716311939;
	bh=iEvzsW5L2NUBj7nr0zp2xH89vF2/tMJAzLRRwGJqbvs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aMTc0jRiFnJxi63YykwXAof39CDKieRfJEPzkSXovJCukVfB7Cy20KAY/BaHkT6sZ
	 UYyXfk/FP+xc/VanN8zM94AHk9CFElhk7d0FKSLkOxUxUxFXWLBad22TF/DcDBl8LH
	 OEbXCINNOKLXWnSrV7yMv5wbPCVCq1hA+hZHu4DI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44LHIwRY032405
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 May 2024 12:18:58 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 12:18:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 12:18:58 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44LHIvW7023002;
	Tue, 21 May 2024 12:18:58 -0500
From: <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        Breno Leitao <leitao@debian.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees
 Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>,
        Michael Nemanov
	<Michael.Nemanov@ti.com>,
        Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH 02/17] Add debug.h
Date: Tue, 21 May 2024 20:18:26 +0300
Message-ID: <20240521171841.884576-3-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521171841.884576-1-michael.nemanov@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <Michael.Nemanov@ti.com>

These are trace macros used throughout the driver.

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/debug.h | 92 ++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/debug.h

diff --git a/drivers/net/wireless/ti/cc33xx/debug.h b/drivers/net/wireless/ti/cc33xx/debug.h
new file mode 100644
index 000000000000..2cf20e387c1d
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/debug.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __DEBUG_H__
+#define __DEBUG_H__
+
+#define DRIVER_NAME "cc33xx"
+#define DRIVER_PREFIX DRIVER_NAME ": "
+
+enum {
+	DEBUG_NONE		= 0,
+	DEBUG_IRQ		= BIT(0),
+	DEBUG_SPI		= BIT(1),
+	DEBUG_BOOT		= BIT(2),
+	DEBUG_CORE_STATUS	= BIT(3),
+	DEBUG_TESTMODE		= BIT(4),
+	DEBUG_EVENT		= BIT(5),
+	DEBUG_TX		= BIT(6),
+	DEBUG_RX		= BIT(7),
+	DEBUG_SCAN		= BIT(8),
+	DEBUG_CRYPT		= BIT(9),
+	DEBUG_PSM		= BIT(10),
+	DEBUG_MAC80211		= BIT(11),
+	DEBUG_CMD		= BIT(12),
+	DEBUG_ACX		= BIT(13),
+	DEBUG_SDIO		= BIT(14),
+	DEBUG_FILTERS		= BIT(15),
+	DEBUG_ADHOC		= BIT(16),
+	DEBUG_AP		= BIT(17),
+	DEBUG_PROBE		= BIT(18),
+	DEBUG_IO		= BIT(19),
+	DEBUG_MASTER		= (DEBUG_ADHOC | DEBUG_AP),
+	DEBUG_CC33xx		= BIT(20),
+	DEBUG_ALL		= ~0,
+	DEBUG_NO_DATAPATH = (DEBUG_ALL & ~DEBUG_IRQ & ~DEBUG_TX & ~DEBUG_RX & ~DEBUG_CORE_STATUS),
+};
+
+extern u32 cc33xx_debug_level;
+
+#define DEBUG_DUMP_LIMIT 1024
+
+#define cc33xx_error(fmt, arg...) \
+	pr_err(DRIVER_PREFIX "ERROR " fmt "\n", ##arg)
+
+#define cc33xx_warning(fmt, arg...) \
+	pr_warn(DRIVER_PREFIX "WARNING " fmt "\n", ##arg)
+
+#define cc33xx_notice(fmt, arg...) \
+	pr_info(DRIVER_PREFIX fmt "\n", ##arg)
+
+#define cc33xx_info(fmt, arg...) \
+	pr_info(DRIVER_PREFIX fmt "\n", ##arg)
+
+/* define the debug macro differently if dynamic debug is supported */
+#if defined(CONFIG_DYNAMIC_DEBUG)
+#define cc33xx_debug(level, fmt, arg...) \
+	do { \
+		if (unlikely((level) & cc33xx_debug_level)) \
+			dynamic_pr_debug(DRIVER_PREFIX fmt "\n", ##arg); \
+	} while (0)
+#else
+#define cc33xx_debug(level, fmt, arg...) \
+	do { \
+		if (unlikely((level) & cc33xx_debug_level)) \
+			pr_debug(pr_fmt(DRIVER_PREFIX fmt "\n"), \
+			       ##arg); \
+	} while (0)
+#endif /* CONFIG_DYNAMIC_DEBUG */
+
+#define cc33xx_dump(level, prefix, buf, len)					\
+	do {									\
+		if ((level) & cc33xx_debug_level)				\
+			print_hex_dump_debug(DRIVER_PREFIX prefix,		\
+					DUMP_PREFIX_OFFSET, 16, 1,		\
+					buf,					\
+					min_t(size_t, len, DEBUG_DUMP_LIMIT),	\
+					0);					\
+	} while (0)
+
+#define cc33xx_dump_ascii(level, prefix, buf, len)				\
+	do {									\
+		if ((level) & cc33xx_debug_level)				\
+			print_hex_dump_debug(DRIVER_PREFIX prefix,		\
+					DUMP_PREFIX_OFFSET, 16, 1,		\
+					buf,					\
+					min_t(size_t, len, DEBUG_DUMP_LIMIT),	\
+					true);					\
+	} while (0)
+
+#endif /* __DEBUG_H__ */
-- 
2.25.1


