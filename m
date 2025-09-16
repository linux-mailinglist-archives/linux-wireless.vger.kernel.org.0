Return-Path: <linux-wireless+bounces-27379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E3B7DC32
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9082B328653
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238832E0415;
	Tue, 16 Sep 2025 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="hvUOc3u8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB91D24A06A
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061475; cv=none; b=Wc6GlBX8Mme85ww7UQrbh7O3d5+giHhfDHD034ynRBJYvp+YTdtPtoYIo0n220y3zMZlWuuND83lKBuaI+wS9VnZnJ/9olJTj+wayOonz8BPHAfONtVy6honxopQtbYeaKUEcodctfMCDmdNKQac+u/pUdcaoTR2AbhbpNnAHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061475; c=relaxed/simple;
	bh=jdz3qKmsQiqsKY1h0CMYD+gk/a2kvPmBqe6fFNlW6AM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dO0BcqXLqhK+JC1D50NX0w5KbfLf3x+Lfb67B3eK8CBkvP99TyPojSYhdGORxu084dMYa8R50q2tl+IuYid4YXqIRh7PyzJc38qsE1VKZ4pDikr0nuLYggnljj6n4rWe+3TqGVyGUC1WDBRb7XMox+KfD4PAxgagWlGO0z6N4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=hvUOc3u8; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061474; x=1789597474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jdz3qKmsQiqsKY1h0CMYD+gk/a2kvPmBqe6fFNlW6AM=;
  b=hvUOc3u8sKQaQzc2egwcDqXNrQ7i24WLdyvod6IcWUza0YzlCLKsNiYI
   TQE03aC+3rubuKv4cnZMR8/Ot4TEOaRyDbjIFnAQ0C1vMfTkEoZdpD+Jr
   ie6yCqQT8RhuymEeMbmZMrOd26QXnyv0kFJU8TCEi9xQQpBJ8Gm097cWi
   4=;
X-CSE-ConnectionGUID: YG7Fa7AeR7SYQfi+ymrrGw==
X-CSE-MsgGUID: Ep8Mk16xTOq3rWVvIk7yFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918494"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918494"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:24:32 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:24:30 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:24:28 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 25/57] wifi: inffmac: add debug.c/h
Date: Wed, 17 Sep 2025 03:47:44 +0530
Message-ID: <20250916221821.4387-30-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE821.infineon.com (172.23.29.47) To
 MUCSE827.infineon.com (172.23.29.20)

Implements the driver debugging infrastructure for sending debug prints to
the user (based on the configured debug level) with the help of helper
functions. These functions are utilized by source files in the driver.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/debug.c | 138 +++++++++++++
 drivers/net/wireless/infineon/inffmac/debug.h | 184 ++++++++++++++++++
 2 files changed, 322 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/debug.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/debug.h

diff --git a/drivers/net/wireless/infineon/inffmac/debug.c b/drivers/net/wireless/infineon/inffmac/debug.c
new file mode 100644
index 000000000000..59c51c86bf51
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/debug.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+#include <linux/debugfs.h>
+#include <linux/netdevice.h>
+#include <linux/module.h>
+#include <linux/devcoredump.h>
+
+#include "core.h"
+#include "bus.h"
+#include "debug.h"
+
+static int
+inff_debug_msgtrace_seqchk(u32 *prev, u32 cur)
+{
+	if ((cur == 0 && *prev == 0xFFFFFFFF) || ((cur - *prev) == 1)) {
+		goto done;
+	} else if (cur == *prev) {
+		inff_dbg(FWCON, "duplicate trace\n");
+		return -1;
+	} else if (cur > *prev) {
+		inff_dbg(FWCON, "lost %d packets\n", cur - *prev);
+	} else {
+		inff_dbg(FWCON, "seq out of order, host %d, dongle %d\n",
+			 *prev, cur);
+	}
+done:
+	*prev = cur;
+	return 0;
+}
+
+static int
+inff_debug_msg_parser(void *event_data)
+{
+	int err = 0;
+	struct msgtrace_hdr *hdr;
+	char *data, *s;
+	static u32 seqnum_prev;
+
+	hdr = (struct msgtrace_hdr *)event_data;
+	data = (char *)event_data + MSGTRACE_HDRLEN;
+
+	/* There are 2 bytes available at the end of data */
+	data[ntohs(hdr->len)] = '\0';
+
+	if (ntohl(hdr->discarded_bytes) || ntohl(hdr->discarded_printf)) {
+		inff_dbg(FWCON, "Discarded_bytes %d discarded_printf %d\n",
+			 ntohl(hdr->discarded_bytes),
+				ntohl(hdr->discarded_printf));
+	}
+
+	err = inff_debug_msgtrace_seqchk(&seqnum_prev, ntohl(hdr->seqnum));
+	if (err)
+		return err;
+
+	while (*data != '\0' && (s = strstr(data, "\n")) != NULL) {
+		*s = '\0';
+		inff_dbg(FWCON, "CONSOLE: %s\n", data);
+		data = s + 1;
+	}
+	if (*data)
+		inff_dbg(FWCON, "CONSOLE: %s", data);
+
+	return err;
+}
+
+static int
+inff_debug_trace_parser(struct inff_if *ifp,
+			const struct inff_event_msg *evtmsg,
+			 void *event_data)
+{
+	int err = 0;
+	struct msgtrace_hdr *hdr;
+
+	hdr = (struct msgtrace_hdr *)event_data;
+	if (hdr->version != MSGTRACE_VERSION) {
+		inff_dbg(FWCON, "trace version mismatch host %d dngl %d\n",
+			 MSGTRACE_VERSION, hdr->version);
+		err = -EPROTO;
+		return err;
+	}
+
+	if (hdr->trace_type == MSGTRACE_HDR_TYPE_MSG)
+		err = inff_debug_msg_parser(event_data);
+
+	return err;
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
+int inff_debug_fwlog_init(struct inff_pub *drvr)
+{
+	return inff_fweh_register(drvr, INFF_E_TRACE,
+				inff_debug_trace_parser);
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
index 000000000000..a2ec711b8674
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/debug.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_DEBUG_H
+#define INFF_DEBUG_H
+
+#include <linux/net.h>	/* net_ratelimit() */
+
+/* message levels */
+#define INFF_TRACE_VAL		0x00000002
+#define INFF_INFO_VAL		0x00000004
+#define INFF_DATA_VAL		0x00000008
+#define INFF_CTL_VAL		0x00000010
+#define INFF_TIMER_VAL		0x00000020
+#define INFF_HDRS_VAL		0x00000040
+#define INFF_BYTES_VAL		0x00000080
+#define INFF_INTR_VAL		0x00000100
+#define INFF_GLOM_VAL		0x00000200
+#define INFF_EVENT_VAL		0x00000400
+#define INFF_BTA_VAL		0x00000800
+#define INFF_FIL_VAL		0x00001000
+#define INFF_USB_VAL		0x00002000
+#define INFF_SCAN_VAL		0x00004000
+#define INFF_CONN_VAL		0x00008000
+#define INFF_BCDC_VAL		0x00010000
+#define INFF_SDIO_VAL		0x00020000
+#define INFF_MSGBUF_VAL	0x00040000
+#define INFF_PCIE_VAL		0x00080000
+#define INFF_FWCON_VAL		0x00100000
+#define INFF_ULP_VAL		0x00200000
+#define INFF_TWT_VAL		0x00400000
+#define INFF_WLAN_SENSE_VAL	0x00800000
+#define INFF_SDIOEXT_VAL	0x01000000
+
+/* set default print format */
+#undef pr_fmt
+#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
+
+struct inff_bus;
+
+__printf(3, 4)
+void __inff_err(struct inff_bus *bus, const char *func, const char *fmt, ...);
+/* Macro for error messages. When debugging / tracing the driver all error
+ * messages are important to us.
+ */
+#ifndef inff_err
+#define inff_err(fmt, ...)						\
+	do {								\
+		if (IS_ENABLED(CONFIG_INF_DEBUG) ||			\
+		    IS_ENABLED(CONFIG_INF_TRACING) ||			\
+		    net_ratelimit())					\
+			__inff_err(NULL, __func__, fmt, ##__VA_ARGS__);\
+	} while (0)
+#endif
+
+#define iphy_err(drvr, fmt, ...)					\
+	do {								\
+		if (IS_ENABLED(CONFIG_INF_DEBUG) ||			\
+		    IS_ENABLED(CONFIG_INF_TRACING) ||			\
+		    net_ratelimit())					\
+			wiphy_err((drvr)->wiphy, "%s: " fmt, __func__,	\
+				  ##__VA_ARGS__);			\
+	} while (0)
+
+#define iphy_info_once(drvr, fmt, ...)					\
+	wiphy_info_once((drvr)->wiphy, "%s: " fmt, __func__,		\
+			##__VA_ARGS__)
+
+#if defined(DEBUG) || defined(CONFIG_INF_TRACING)
+
+/* For debug/tracing purposes treat info messages as errors */
+#define inff_info inff_err
+
+__printf(3, 4)
+void __inff_dbg(u32 level, const char *func, const char *fmt, ...);
+#define inff_dbg(level, fmt, ...)				\
+do {								\
+	if (IS_ENABLED(CONFIG_INF_DEBUG) ||			\
+		IS_ENABLED(CONFIG_INF_TRACING))			\
+		__inff_dbg(INFF_##level##_VAL, __func__,	\
+			fmt, ##__VA_ARGS__);			\
+} while (0)
+
+#define INFF_DATA_ON()		(inff_msg_level & INFF_DATA_VAL)
+#define INFF_CTL_ON()		(inff_msg_level & INFF_CTL_VAL)
+#define INFF_HDRS_ON()		(inff_msg_level & INFF_HDRS_VAL)
+#define INFF_BYTES_ON()	(inff_msg_level & INFF_BYTES_VAL)
+#define INFF_GLOM_ON()		(inff_msg_level & INFF_GLOM_VAL)
+#define INFF_EVENT_ON()	(inff_msg_level & INFF_EVENT_VAL)
+#define INFF_FIL_ON()		(inff_msg_level & INFF_FIL_VAL)
+#define INFF_FWCON_ON()	(inff_msg_level & INFF_FWCON_VAL)
+#define INFF_SCAN_ON()		(inff_msg_level & INFF_SCAN_VAL)
+#define INFF_WLAN_SENSE_ON()	(inff_msg_level & INFF_WLAN_SENSE_VAL)
+
+#else /* defined(DEBUG) || defined(CONFIG_INF_TRACING) */
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
+#define INFF_DATA_ON()		0
+#define INFF_CTL_ON()		0
+#define INFF_HDRS_ON()		0
+#define INFF_BYTES_ON()	0
+#define INFF_GLOM_ON()		0
+#define INFF_EVENT_ON()	0
+#define INFF_FIL_ON()		0
+#define INFF_FWCON_ON()	0
+#define INFF_SCAN_ON()		0
+
+#endif /* defined(DEBUG) || defined(CONFIG_INF_TRACING) */
+
+#define MSGTRACE_VERSION 1
+#define MSGTRACE_HDR_TYPE_MSG 0
+#define MSGTRACE_HDR_TYPE_LOG 1
+
+#define inff_dbg_hex_dump(test, data, len, fmt, ...) \
+do { \
+	if (test) \
+		inff_dbg_hex_dump(data, len, fmt, ##__VA_ARGS__); \
+} while (0)
+
+extern int inff_msg_level;
+
+struct inff_pub;
+#ifdef DEBUG
+struct dentry *inff_debugfs_get_devdir(struct inff_pub *drvr);
+void inff_debugfs_add_entry(struct inff_pub *drvr, const char *fn,
+			    int (*read_fn)(struct seq_file *seq, void *data));
+int inff_debug_create_memdump(struct inff_bus *bus, const void *data,
+			      size_t len);
+int inff_debug_fwlog_init(struct inff_pub *drvr);
+#else
+
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
+
+static inline
+int inff_debug_fwlog_init(struct inff_pub *drvr)
+{
+	return 0;
+}
+#endif
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


