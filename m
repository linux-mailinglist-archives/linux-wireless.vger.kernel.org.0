Return-Path: <linux-wireless+bounces-7558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2C98C37EF
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 20:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0011F211A1
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 18:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389B8535A8;
	Sun, 12 May 2024 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R6I9/pzl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E052F6A
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715538833; cv=none; b=o3Bhxmfyuku21+m3WHGX6qikAvBKYCrFVxalHC4TLVC6Lw09ypgwrlM1eKkzsaczYJ+mTJKJcTZGzaGfjo4l8tdl2uevdiDLFooNnO6KEj7AxAiUcH8EzVsTi143wNH8nXXGdW1sgjS5BraQD5GGHd6eohdipeWK8z2Bj64pVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715538833; c=relaxed/simple;
	bh=uF835I7WPY8LxwMn6Ge/pMvjS1vJWpQAO6u/5TiZeGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tE0AH3BVfpT3O7aIUjli/lcb40w/KG8fThxsz2RGbJrWJtAVBlCLJU5Q6cvb8L9r1tmTEfpnaBG1IlSqVSSsxHvdJ02PlUh/hwbmsYpWP1HPI4kBIWh19n6uyj/fv4shd5KLWR8oVKsawNAP4KUrBvl55ofUAzq5U2UgrqazzN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R6I9/pzl; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXawW001223;
	Sun, 12 May 2024 13:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715538816;
	bh=b+6/CN84pV8TX6Q4TyHNrHM0yqPzXkwrzzAvfDIVnSk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=R6I9/pzl7/n/NmFziU747565RziYf6a+J9rNGyJXDY8z4dPIYyOnDzu42Y/GF1MFW
	 MiX1gl9bBB2JcLVEs+2yTkfZMX4J2MGoh7zHWYQlkcPFXLjEo73l6olGowAk1zKrzV
	 GqblO2ohJ7VzYm4XtVyosDUEXnzUzQohWWsCyik0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44CIXaZo095964
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 12 May 2024 13:33:36 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 12
 May 2024 13:33:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 12 May 2024 13:33:36 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXZaW074445;
	Sun, 12 May 2024 13:33:36 -0500
From: <michael.nemanov@ti.com>
To: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC: <sabeeh-khan@ti.com>, Michael Nemanov <Michael.Nemanov@ti.com>,
        Michael
 Nemanov <michael.nemanov@ti.com>
Subject: [RFC PATCH 02/17] Add debug.h
Date: Sun, 12 May 2024 21:32:32 +0300
Message-ID: <20240512183247.2190242-3-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240512183247.2190242-1-michael.nemanov@ti.com>
References: <20240512183247.2190242-1-michael.nemanov@ti.com>
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
 drivers/net/wireless/ti/cc33xx/debug.h | 91 ++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/debug.h

diff --git a/drivers/net/wireless/ti/cc33xx/debug.h b/drivers/net/wireless/ti/cc33xx/debug.h
new file mode 100644
index 000000000000..a43c2ac5a215
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/debug.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/* Copyright (C) 2022-2024 Texas Instruments Inc.*/
+
+#ifndef __DEBUG_H__
+#define __DEBUG_H__
+
+#define DRIVER_NAME "cc33xx"
+#define DRIVER_PREFIX DRIVER_NAME ": "
+
+enum {
+	DEBUG_NONE	= 0,
+	DEBUG_IRQ	= BIT(0),
+	DEBUG_SPI	= BIT(1),
+	DEBUG_BOOT	= BIT(2),
+	DEBUG_CORE_STATUS = BIT(3),
+	DEBUG_TESTMODE	= BIT(4),
+	DEBUG_EVENT	= BIT(5),
+	DEBUG_TX	= BIT(6),
+	DEBUG_RX	= BIT(7),
+	DEBUG_SCAN	= BIT(8),
+	DEBUG_CRYPT	= BIT(9),
+	DEBUG_PSM	= BIT(10),
+	DEBUG_MAC80211	= BIT(11),
+	DEBUG_CMD	= BIT(12),
+	DEBUG_ACX	= BIT(13),
+	DEBUG_SDIO	= BIT(14),
+	DEBUG_FILTERS   = BIT(15),
+	DEBUG_ADHOC     = BIT(16),
+	DEBUG_AP	= BIT(17),
+	DEBUG_PROBE	= BIT(18),
+	DEBUG_IO	= BIT(19),
+	DEBUG_MASTER	= (DEBUG_ADHOC | DEBUG_AP),
+	DEBUG_CC33xx = BIT(20),
+	DEBUG_ALL	= ~0,
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


