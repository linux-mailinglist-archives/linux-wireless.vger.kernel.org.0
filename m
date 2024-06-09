Return-Path: <linux-wireless+bounces-8724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39E1901793
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 20:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3453BB2108D
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 18:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAE750275;
	Sun,  9 Jun 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SFe0Fq3s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7AE57D;
	Sun,  9 Jun 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957375; cv=none; b=b8+8jMU6GW5Dt+95c1FCzgTkF2Tw2hRl1eO/jDmalCcR9YNF0pbFf1HUb0xMk0lBHd/nOSlnjr1/09PGlquxHQzY0Dv/wSQjTkdYhUkP40ILIrHdACjjMx7FX1MdZCktECsGFqxer4HvO3UiI7y1kjX0AWjxExmtPHZ6PY4qDUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957375; c=relaxed/simple;
	bh=5HeIfH04EkxerFQeJZzdfSPNA6luupHO4SUYrAzqReg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bmd+hVgKeT5zgPYiYPCnEdTfuVb069R5N8ZHjzfQ6Hi665UZaXCvb9uL1ns/oUAYq5HBykFuNTiqbiD2utswqkVV34p3XmoslzX6O3JBFfGeUAvL0FOCyyLNC/wzi8rS4KGEA2Mk2kE8JTzv03bb8Afn5JKQy4Fn4Ei8w5d0New=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SFe0Fq3s; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 459IMXur075084;
	Sun, 9 Jun 2024 13:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717957353;
	bh=HYGuuBoePx44We64nuR+IzZWZgaVxiz1hWFxFIVedUA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SFe0Fq3s2MZDNLEhudlxYIfcAPD2n1j8UOQGvB3bPk3Fuz5cOgd1wvtauOZlaenoZ
	 uJrS0fOCcvQY+Qk7STXnfkt8wznfabqz3nX1bz1/2sYza6/B8WQuU8CDrxlv7G0wzt
	 oFD3Y/ZHMyzoYI+G1k/pRNifvqxEAlAqofao/2Ro=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 459IMXrg058691
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 9 Jun 2024 13:22:33 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 9
 Jun 2024 13:22:33 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 9 Jun 2024 13:22:33 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 459IMWrv067565;
	Sun, 9 Jun 2024 13:22:33 -0500
From: <michael.nemanov@ti.com>
To: Sabeeh Khan <sabeeh-khan@ti.com>, Kalle Valo <kvalo@kernel.org>,
        Johannes
 Berg <johannes.berg@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Nemanov
	<Michael.Nemanov@ti.com>
Subject: [PATCH v2 02/17] wifi: cc33xx: Add debug.h
Date: Sun, 9 Jun 2024 21:20:47 +0300
Message-ID: <20240609182102.2950457-3-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609182102.2950457-1-michael.nemanov@ti.com>
References: <20240609182102.2950457-1-michael.nemanov@ti.com>
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
---
 drivers/net/wireless/ti/cc33xx/debug.h | 92 ++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/debug.h

diff --git a/drivers/net/wireless/ti/cc33xx/debug.h b/drivers/net/wireless/ti/cc33xx/debug.h
new file mode 100644
index 000000000000..53b2168c04c7
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
+	DEBUG_ALL		= GENMASK(31, 0),
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


