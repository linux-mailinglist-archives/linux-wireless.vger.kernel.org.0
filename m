Return-Path: <linux-wireless+bounces-15071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CA79C064E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C234A1C21EAF
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 12:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB6021313B;
	Thu,  7 Nov 2024 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c8u0qlib"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB6D212EEB;
	Thu,  7 Nov 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983980; cv=none; b=b27nuZIM4mmYYDAUBu1iFTLTfSdGpO/k53HSRuPplmHQnDxwqCkqCNsQNpKHYHyR6tzF3sp4NudAqCvZcrnzOKL4tDbl6eU1hAqJmWJtmyu9tuMSNKjHciSAAwS4hpXQ7+E/EyCtLetQKqV3wYniuJWS/8Ei32KTBzJpsuzk0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983980; c=relaxed/simple;
	bh=4zqDyWqTQTrK+jNEhpJzM11nbPhPLqhRqG0GcClrp2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sjmi6G7YHVoS5py0T0/fl9uL0wzSdWd0kk4wHAQIV/yB00pEPY8WgLDM/RejhApb0gGoLQw/6IY+ybFWP0OjuhkWNkVDebWjwdQwHaY5wp1FH7vvI25Or2Vw3DZ21aHk+ZhlgMFRhbGWbGaQRyNXT4wK7r/y676JTg+p+yOxu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c8u0qlib; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A7CqfLt041931;
	Thu, 7 Nov 2024 06:52:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730983961;
	bh=D3BYH+c4+v9/TCb1eLjg2rWqpH715CLIMEdGywtJ/Ac=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=c8u0qlib/rWvJXz/ueEFmSCH4bM+T/YcianOEMpYkpSMvc7SxbWQtUxJavl7Do9na
	 E0u92ZbgqHYSis6HKKSholdG4b8y2L64ASMheny6I+rcQ/4GJf4cnaiE7DstI5alfd
	 hueAXdCFgGJOQ1G2DQH9eu1cmQtdveEWSMGqGTc4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A7Cqfgc060319
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 06:52:41 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Nov 2024 06:52:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Nov 2024 06:52:41 -0600
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A7Cqea1054776;
	Thu, 7 Nov 2024 06:52:41 -0600
From: Michael Nemanov <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>, Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH v5 03/17] wifi: cc33xx: Add debug.h
Date: Thu, 7 Nov 2024 14:51:55 +0200
Message-ID: <20241107125209.1736277-4-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107125209.1736277-1-michael.nemanov@ti.com>
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

These are trace macros used throughout the driver.

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
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
2.34.1


