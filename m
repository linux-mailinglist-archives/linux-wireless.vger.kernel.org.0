Return-Path: <linux-wireless+bounces-30787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F06D1B45B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A7B030A425A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1601B2FDC35;
	Tue, 13 Jan 2026 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="iLoflrk6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C1276051
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336907; cv=none; b=BEn3KEtBijUms9gUDqDp4BJy7zo7AuDfzVfEUXH7zFFy4BnYrbdGmosU/P0cg8qV7qWRsWELS6LS5gNC0mQox0USEvWDejFfWePYKGL1BFZby6Ggt/QHENDtdsyirzwknuZywyLw2vHQDl4Q1wgflnrjK1uAkR6mztayMOJ1ryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336907; c=relaxed/simple;
	bh=dNUQSVPj1ia0nybr3QhANE/QVppHNoclKw9KslyD9Is=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgsoeizUrUdAJgK78A8KdExP/ZhqiRYGwlhb5PrUx8mqkCBQoTYWS2XiE+Ekv+Prb6CgpCtkJ8s4FgrkixsymqaxWY3fQgqs6GQSCoomoVz4MbCiaM0MxqNP/3y9ygKb+jCkD99VHyRvdhSNNjsK5guDOodPj8sKg9RMCBCB3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=iLoflrk6; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336906; x=1799872906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dNUQSVPj1ia0nybr3QhANE/QVppHNoclKw9KslyD9Is=;
  b=iLoflrk6zi1x4wZ2oresNzh6q8WCo7wX88jIRYq7CsOkOI7U9SMTqgOQ
   S308zO3S+ZRNrlNkl2SuBKInw0pNX8lybr7g9SATsST/9hJ7LWW2mNwyM
   O3Fa98RttI4cmV+t6gqIXdaMTQY7HQZv9aOQufGrszbeHtu+bSUNpqpST
   A=;
X-CSE-ConnectionGUID: +AuxUoLwQTmxfPMUZm7fWg==
X-CSE-MsgGUID: fxNpbpTcRbCZsj71pjslQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="139542182"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="139542182"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:41:44 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:41:43 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:41:41 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 32/34] wifi: inffmac: add debug.c/h
Date: Wed, 14 Jan 2026 02:03:45 +0530
Message-ID: <20260113203350.16734-33-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE802.infineon.com (172.23.29.28) To
 MUCSE827.infineon.com (172.23.29.20)

Implements the driver debugging infrastructure for sending debug prints to
the user (based on the configured debug level) with the help of helper
functions. These functions are utilized by source files in the driver.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/debug.c | 117 ++++++++++++
 drivers/net/wireless/infineon/inffmac/debug.h | 174 ++++++++++++++++++
 2 files changed, 291 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/debug.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/debug.h

diff --git a/drivers/net/wireless/infineon/inffmac/debug.c b/drivers/net/wireless/infineon/inffmac/debug.c
new file mode 100644
index 000000000000..5ddbbb6ab505
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/debug.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+#include <linux/debugfs.h>
+#include <linux/netdevice.h>
+#include <linux/module.h>
+#include <linux/devcoredump.h>
+
+#include "main.h"
+#include "bus_proto.h"
+#include "debug.h"
+
+void __inff_dbg(u32 level, const char *func, const char *fmt, ...)
+{
+	struct va_format vaf = {
+		.fmt = fmt,
+	};
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+	if (inff_msg_level & level)
+		pr_debug("%s %pV", func, &vaf);
+	va_end(args);
+}
+
+void
+__inff_err(struct device *dev, const char *func, const char *fmt, ...)
+{
+	struct va_format vaf = {
+		.fmt = fmt,
+	};
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+	if (dev)
+		dev_err(dev, "%s: %pV", func, &vaf);
+	else
+		pr_err("%s: %pV", func, &vaf);
+	va_end(args);
+}
+
+/* pretty hex print a pkt buffer chain */
+void inff_prpkt(const char *msg, struct sk_buff *p0)
+{
+	struct sk_buff *p;
+
+	if (msg && (msg[0] != '\0'))
+		pr_debug("%s:\n", msg);
+
+	for (p = p0; p; p = p->next)
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, p->data, p->len);
+}
+
+void __inff_dbg_hex_dump(const void *data, size_t size,
+			 const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	pr_debug("%pV", &vaf);
+
+	va_end(args);
+
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, data, size);
+}
+
+int inff_debug_create_memdump(struct inff_bus *bus, const void *data,
+			      size_t len)
+{
+	void *dump;
+	size_t ramsize;
+	int err;
+
+	ramsize = inff_bus_get_ramsize(bus);
+	if (!ramsize)
+		return -EOPNOTSUPP;
+
+	dump = vzalloc(len + ramsize);
+	if (!dump)
+		return -ENOMEM;
+
+	if (data && len > 0)
+		memcpy(dump, data, len);
+	err = inff_bus_get_memdump(bus, dump + len, ramsize);
+	if (err) {
+		vfree(dump);
+		return err;
+	}
+
+	dev_coredumpv(bus->dev, dump, len + ramsize, GFP_KERNEL);
+
+	return 0;
+}
+
+struct dentry *inff_debugfs_get_devdir(struct inff_pub *drvr)
+{
+	return drvr->wiphy->debugfsdir;
+}
+
+void inff_debugfs_add_entry(struct inff_pub *drvr, const char *fn,
+			    int (*read_fn)(struct seq_file *seq, void *data))
+{
+	WARN(!drvr->wiphy->debugfsdir, "wiphy not (yet) registered\n");
+	debugfs_create_devm_seqfile(drvr->bus_if->dev, fn,
+				    drvr->wiphy->debugfsdir, read_fn);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/debug.h b/drivers/net/wireless/infineon/inffmac/debug.h
new file mode 100644
index 000000000000..9a366ee9111f
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/debug.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_DEBUG_H
+#define INFF_DEBUG_H
+
+#include <linux/net.h>	/* net_ratelimit() */
+#include <linux/device.h>
+
+/* message levels */
+enum inff_msglvl {
+	INFF_MSGLVL_TRACE	= BIT(1),
+	INFF_MSGLVL_INFO	= BIT(2),
+	INFF_MSGLVL_DATA	= BIT(3),
+	INFF_MSGLVL_CTL		= BIT(4),
+	INFF_MSGLVL_TIMER	= BIT(5),
+	INFF_MSGLVL_HDRS	= BIT(6),
+	INFF_MSGLVL_BYTES	= BIT(7),
+	INFF_MSGLVL_INTR	= BIT(8),
+	INFF_MSGLVL_GLOM	= BIT(9),
+	INFF_MSGLVL_DEVEVT	= BIT(10),
+	INFF_MSGLVL_BTA		= BIT(11),
+	INFF_MSGLVL_DEVCMD	= BIT(12),
+	INFF_MSGLVL_USB		= BIT(13),
+	INFF_MSGLVL_SCAN	= BIT(14),
+	INFF_MSGLVL_CONN	= BIT(15),
+	INFF_MSGLVL_BCDC	= BIT(16),
+	INFF_MSGLVL_SDIO	= BIT(17),
+	INFF_MSGLVL_MSGBUF	= BIT(18),
+	INFF_MSGLVL_PCIE	= BIT(19),
+	INFF_MSGLVL_FWCON	= BIT(20),
+	INFF_MSGLVL_ULP		= BIT(21),
+	INFF_MSGLVL_TWT		= BIT(22),
+	INFF_MSGLVL_SDIOEXT	= BIT(24),
+	INFF_MSGLVL_ICDC	= BIT(25),
+};
+
+#ifdef DEBUG
+#define INFF_MSGLVL_ON(level) (inff_msg_level & INFF_MSGLVL_##level)
+#else /* DEBUG */
+#define INFF_MSGLVL_ON(LVL)	0
+#endif /* DEBUG */
+
+/* set default print format */
+#undef pr_fmt
+#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
+
+struct inff_bus;
+
+__printf(3, 4)
+void __inff_err(struct device *dev, const char *func, const char *fmt, ...);
+/* Macro for error messages. When debugging / tracing the driver all error
+ * messages are important to us.
+ */
+#define inff_err(fmt, ...)						\
+	do {								\
+		if (IS_ENABLED(CONFIG_INF_DEBUG) ||			\
+		    net_ratelimit())					\
+			__inff_err(NULL, __func__, fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#define inff_dev_err(dev, fmt, ...)						\
+	do {								\
+		if (IS_ENABLED(CONFIG_INF_DEBUG) ||			\
+		    net_ratelimit())					\
+			__inff_err(dev, __func__, fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#define iphy_err(drvr, fmt, ...)					\
+	do {								\
+		if (IS_ENABLED(CONFIG_INF_DEBUG) ||			\
+		    net_ratelimit())					\
+			wiphy_err((drvr)->wiphy, "%s: " fmt, __func__,	\
+				  ##__VA_ARGS__);			\
+	} while (0)
+
+#define iphy_info_once(drvr, fmt, ...)					\
+	wiphy_info_once((drvr)->wiphy, "%s: " fmt, __func__,		\
+			##__VA_ARGS__)
+
+#ifdef DEBUG
+
+/* For debug purposes treat info messages as errors */
+#define inff_info inff_err
+
+__printf(3, 4)
+void __inff_dbg(u32 level, const char *func, const char *fmt, ...);
+#define inff_dbg(level, fmt, ...)				\
+do {								\
+	if (IS_ENABLED(CONFIG_INF_DEBUG))			\
+		__inff_dbg(INFF_MSGLVL_##level, __func__,	\
+			fmt, ##__VA_ARGS__);			\
+} while (0)
+
+__printf(3, 4)
+void __inff_dbg_hex_dump(const void *data, size_t size,
+			 const char *fmt, ...);
+#define inff_dbg_hex_dump(test, data, len, fmt, ...) \
+do { \
+	if (test) \
+		__inff_dbg_hex_dump(data, len, fmt, ##__VA_ARGS__); \
+} while (0)
+
+void inff_prpkt(const char *msg, struct sk_buff *p0);
+
+#else /* DEBUG */
+
+#define inff_info(fmt, ...)						\
+	{								\
+		pr_info("%s: " fmt, __func__, ##__VA_ARGS__);		\
+	}
+
+#define inff_dbg(level, fmt, ...) \
+	{	\
+		UNUSED_PARAMETER(level);	\
+		no_printk(fmt, ##__VA_ARGS__);	\
+	}
+
+#define inff_dbg_hex_dump(test, data, len, fmt, ...)
+#define inff_prpkt(a, b)
+
+#endif /* DEBUG */
+
+extern int inff_msg_level;
+struct inff_pub;
+
+#ifdef DEBUG
+struct dentry *inff_debugfs_get_devdir(struct inff_pub *drvr);
+void inff_debugfs_add_entry(struct inff_pub *drvr, const char *fn,
+			    int (*read_fn)(struct seq_file *seq, void *data));
+int inff_debug_create_memdump(struct inff_bus *bus, const void *data,
+			      size_t len);
+#else
+static inline struct dentry *inff_debugfs_get_devdir(struct inff_pub *drvr)
+{
+	return ERR_PTR(-ENOENT);
+}
+
+static inline
+void inff_debugfs_add_entry(struct inff_pub *drvr, const char *fn,
+			    int (*read_fn)(struct seq_file *seq, void *data))
+{ }
+static inline
+int inff_debug_create_memdump(struct inff_bus *bus, const void *data,
+			      size_t len)
+{
+	return 0;
+}
+#endif /* DEBUG */
+
+#define MSGTRACE_VERSION 1
+#define MSGTRACE_HDR_TYPE_MSG 0
+#define MSGTRACE_HDR_TYPE_LOG 1
+
+/* Message trace header */
+struct msgtrace_hdr {
+	u8	version;
+	u8	trace_type;
+	u16	len;    /* Len of the trace */
+	u32	seqnum; /* Sequence number of message */
+	/* Number of discarded bytes because of trace overflow  */
+	u32	discarded_bytes;
+	/* Number of discarded printf because of trace overflow */
+	u32	discarded_printf;
+};
+
+#define MSGTRACE_HDRLEN		sizeof(struct msgtrace_hdr)
+
+#endif /* INFF_DEBUG_H */
-- 
2.25.1


