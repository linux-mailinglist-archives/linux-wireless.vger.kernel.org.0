Return-Path: <linux-wireless+bounces-27378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD4B7DFB2
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F57C7A9A70
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9222E0415;
	Tue, 16 Sep 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="DRh2QtvW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E4747F
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061464; cv=none; b=P8XXxLAg4b4NKuzH6jF2lltwe4h1zNiMEsiWaB0DfsDVwDtrxA3POcS8wLU8rqW6ZhJTCV8Nnn6CqPHOa3NgvoL77BLb3dnglFNKPAG9BMZBiCf6L0lwWMnQNdaI5E0/CYM23sZutyMcTaBFpV0Yo27/HKw54OWBxsXt391QVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061464; c=relaxed/simple;
	bh=sgke4Whjv+//0RuxnHdkxN+TL0S84Kfn2BK8lslHfGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtcP25FHtsWcAefqwlV+Xrx0r8IlRUk+bBKR7SRQM1+iS1i4+aacA4r3+PCKamkcCd6s2UAVNGYO8ElvqZ4jbMma12Wmp4j/C4irwE8eRmPMGxHGL+I/aqCSHVUJk+t1panG6kNjEbiFJ3BRFvjZkEIiloQBYhzhaSf34Upbfck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=DRh2QtvW; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061462; x=1789597462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sgke4Whjv+//0RuxnHdkxN+TL0S84Kfn2BK8lslHfGo=;
  b=DRh2QtvWcyfzGbdTSHDHQb6FC70sAG+Gh5GShFclI8lxRF6i2vEFgUcu
   EIHLPJPLIP4wZiLcJ0c+NP6w3JmwdkXY2zrPNsHNIXtj1hNrqLSaWyNu/
   YOPpiXlGHHRLSm8XcIgvADgd6eYdtl9sVCVGEgmaNsFiyS6RI6PAEupa2
   c=;
X-CSE-ConnectionGUID: aYhn9tAsROGmI0CtxZkUcA==
X-CSE-MsgGUID: ztXd+4DXSxm06HNwaPrKTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093544"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093544"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:24:19 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:24:18 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:24:15 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 24/57] wifi: inffmac: add logger.c/h
Date: Wed, 17 Sep 2025 03:47:43 +0530
Message-ID: <20250916221821.4387-29-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE810.infineon.com (172.23.29.36) To
 MUCSE827.infineon.com (172.23.29.20)

Implements the driver debugging infrastructure for logging important event
or state information in a ring buffer, which is helpful in debugging
intermittent issues that happened in the driver if kernel debug mechanisms
were not enabled.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/logger.c    | 189 ++++++++++++++++++
 .../net/wireless/infineon/inffmac/logger.h    | 133 ++++++++++++
 2 files changed, 322 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/logger.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/logger.h

diff --git a/drivers/net/wireless/infineon/inffmac/logger.c b/drivers/net/wireless/infineon/inffmac/logger.c
new file mode 100644
index 000000000000..7a1cf8c90dee
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/logger.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+#include <linux/slab.h>
+#include "core.h"
+#include "debug.h"
+#include "logger.h"
+
+/**
+ * inff_logring_fill() - Dump all the data in the logring.
+ *
+ * @drvr: Driver Context.
+ * @ringid: Logring ID.
+ */
+void inff_logring_dump(struct inff_pub *drvr, u8 ringid)
+{
+	struct inff_logger *logger = drvr->logger;
+	struct inff_logring *logring = &logger->logring[ringid];
+
+	if (!logring->enabled)
+		return;
+
+	do {
+		if (logring->dump_cb)
+			logring->dump_cb(&logring->buffer[logring->curr],
+					 logring->item_size);
+
+		logring->curr = (logring->curr + logring->item_size) %
+				(logger->logring_depth * logring->item_size);
+	} while (logring->curr != logring->head);
+}
+
+/**
+ * inff_logring_fill() - Fill the logring with data
+ *
+ * @drvr: Driver Context.
+ * @ringid: Logring ID.
+ * @data: data to be logged.
+ * @size: size of the data to be logged.
+ */
+void inff_logring_fill(struct inff_pub *drvr, u8 ringid, u8 *data, u32 size)
+{
+	struct inff_logger *logger = drvr->logger;
+	struct inff_logring *logring = &logger->logring[ringid];
+	u8 *logring_buf;
+
+	if (!logring->enabled)
+		return;
+
+	logring_buf = &logring->buffer[logring->curr];
+
+	memset(logring_buf, 0, logring->item_size);
+
+	/* Log timestamp */
+	*(u64 *)logring_buf = (u64)ktime_to_ns(ktime_get_boottime());
+	logring_buf += sizeof(u64);
+
+	/* Log Data */
+	memcpy(logring_buf, data, size);
+
+	logring->curr = (logring->curr + logring->item_size) %
+			(logger->logring_depth * logring->item_size);
+
+	/* If logring becomes full, dump the ringitem contents before overwrite */
+	if (logring->curr == logring->head)
+		inff_logring_dump(drvr, ringid);
+}
+
+/**
+ * inff_logring_init() - Logring Initialization
+ *
+ * @drvr: Driver Context.
+ * @ringid: Logring ID.
+ * @item_size: Size of individual items in the logring.
+ * @dump_cb: Callback function that dumps the ring item contents.
+ *
+ * Return success or failure.
+ */
+int inff_logring_init(struct inff_pub *drvr, u8 ringid, u32 item_size,
+		      dump_callback_t dump_cb)
+{
+	struct inff_logger *logger = drvr->logger;
+	struct inff_logring *logring = &logger->logring[ringid];
+
+	if (!(logger->level & BIT(ringid)))
+		return 0;
+
+	logring->buffer = kzalloc(item_size * logger->logring_depth, GFP_KERNEL);
+	if (!logring->buffer)
+		return -ENOMEM;
+
+	logring->item_size = item_size;
+	logring->curr = 0;
+	logring->head = 0;
+	logring->ringid = ringid;
+	logring->dump_cb = dump_cb;
+	logring->enabled = true;
+
+	return 0;
+}
+
+/**
+ * inff_logring_deinit() - Logring De-initialization
+ *
+ * @drvr: Driver Context.
+ * @ringid: Logring ID.
+ */
+void inff_logring_deinit(struct inff_pub *drvr, u8 ringid)
+{
+	struct inff_logger *logger = drvr->logger;
+	struct inff_logring *logring;
+
+	if (!logger ||
+	    !(logger->level & BIT(ringid)))
+		return;
+
+	logring = &logger->logring[ringid];
+
+	if (logring->enabled) {
+		logring->enabled = false;
+		kfree(logring->buffer);
+		logring->buffer = NULL;
+	}
+}
+
+/**
+ * inff_logger_attach() - allocate a context for the logger.
+ *
+ * @drvr: driver instance.
+ * @logger_level: Debug logger log levels.
+ * @logring_depth: Debug logring depth
+ *
+ * Returns success or failure
+ */
+int inff_logger_attach(struct inff_pub *drvr, u32 logger_level, u32 logring_depth)
+{
+	struct inff_logger *logger;
+	s32 ret;
+
+	logger = kzalloc(sizeof(*logger), GFP_KERNEL);
+	if (!logger)
+		return -ENOMEM;
+
+	logger->level = logger_level;
+	logger->logring_depth = logring_depth;
+
+	drvr->logger = logger;
+
+	ret = inff_logring_init(drvr, INFF_LOGRING_FW_CMD_SET,
+				sizeof(struct inff_logring_fw_cmd_item), NULL);
+	if (ret) {
+		inff_err("Logger: FW_CMD_SET logring initialization failed ret=%d\n", ret);
+		goto detach;
+	}
+
+	ret = inff_logring_init(drvr, INFF_LOGRING_FW_CMD_GET,
+				sizeof(struct inff_logring_fw_cmd_item), NULL);
+	if (ret) {
+		inff_err("Logger: FW_CMD_GET logring initialization failed ret=%d\n", ret);
+		goto detach;
+	}
+
+	return 0;
+detach:
+	inff_logger_detach(drvr);
+	return ret;
+}
+
+/**
+ * inff_logger_detach() - Delloaction of the logger context
+ *
+ * @drvr: Driver instance.
+ */
+void inff_logger_detach(struct inff_pub *drvr)
+{
+	struct inff_logger *logger = drvr->logger;
+
+	if (!logger)
+		return;
+
+	inff_logring_deinit(drvr, INFF_LOGRING_FW_CMD_SET);
+
+	inff_logring_deinit(drvr, INFF_LOGRING_FW_CMD_GET);
+
+	kfree(logger);
+	drvr->logger = NULL;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/logger.h b/drivers/net/wireless/infineon/inffmac/logger.h
new file mode 100644
index 000000000000..11b73df5fea7
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/logger.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_LOGGER_H
+#define INFF_LOGGER_H
+
+#include <linux/types.h>
+#include <linux/bits.h>
+
+/**
+ * enum inff_logrings - Logring types
+ *
+ * @INFF_LOGRING_FW_EVENT - Logs all the events received from the firmware.
+ *
+ * @INFF_LOGRING_FW_CMD_SET - Logs all the SET CMD sent to the firmware.
+ *
+ * @INFF_LOGRING_FW_CMD_SET - Logs all the GET CMD sent to the firmware.
+ */
+enum inff_logrings {
+	INFF_LOGRING_FW_EVENT,
+	INFF_LOGRING_FW_CMD_SET,
+	INFF_LOGRING_FW_CMD_GET,
+	INFF_LOGRING_MAX,
+};
+
+#define INFF_LOGGER_LEVEL_FW_EVENT	BIT(INFF_LOGRING_FW_EVENT)
+#define INFF_LOGGER_LEVEL_FW_CMD_SET	BIT(INFF_LOGRING_FW_CMD_SET)
+#define INFF_LOGGER_LEVEL_FW_CMD_GET	BIT(INFF_LOGRING_FW_CMD_GET)
+
+#define INFF_LOGGER_LEVEL_DEFAULT	0x1
+#define INFF_LOGRING_DEPTH_DEFAULT	32
+
+/**
+ * struct inff_logring_fw_event_item - Firmware event logring item
+ *
+ * @timestamp: firmware event received time stamp.
+ * @emsg: firmware event message.
+ */
+struct inff_logring_fw_event_item {
+	u64 timestamp;
+	struct inff_event_msg emsg;
+};
+
+/**
+ * struct inff_logring_fw_cmd_item - Firmware cmd logring item
+ *
+ * @timestamp: firmware cmd senti time stamp.
+ * @cmdid: firmware cmd ID.
+ * @cmdstr: firmware cmd string.
+ */
+struct inff_logring_fw_cmd_item {
+	u64 timestamp;
+	u32 cmdid;
+	u8 cmdstr[64];
+};
+
+typedef void (*dump_callback_t) (u8 *data, u32 size);
+
+/**
+ * struct inff_logring - Debug Log ring structure.
+ *
+ * @enabled: Ring is enabled/disabled.
+ * @ringid: unique identifier of the ring.
+ * @curr: Current Index in the Ring.
+ * @head: Head Index in the Ring.
+ * @item_size: logring item size.
+ * @buffer: Buffer for holding data.
+ * @dump_cb: Dump callback function.
+ */
+struct inff_logring {
+	bool enabled;
+	u8 ringid;
+	u32 curr;
+	u32 head;
+	u32 item_size;
+	u8 *buffer;
+	dump_callback_t dump_cb;
+};
+
+/**
+ * struct inff_logger - Debug Logger structure.
+ *
+ * @level: Logging level.
+ * @logring_depth: Count of no if items in the logring.
+ * @logring: array of ring buffers for logging the debug info by type.
+ */
+struct inff_logger {
+	u32 level;
+	u32 logring_depth;
+	struct inff_logring logring[INFF_LOGRING_MAX];
+};
+
+#ifdef DEBUG
+void inff_logring_dump(struct inff_pub *drvr, u8 ringid);
+void inff_logring_fill(struct inff_pub *drvr, u8 ringid, u8 *data, u32 size);
+int inff_logring_init(struct inff_pub *drvr, u8 ringid, u32 ring_item_size,
+		      dump_callback_t dump_cb);
+void inff_logring_deinit(struct inff_pub *drvr, u8 ringid);
+int inff_logger_attach(struct inff_pub *drvr, u32 logger_level, u32 logring_depth);
+void inff_logger_detach(struct inff_pub *drvr);
+#else
+static inline void inff_logring_dump(struct inff_pub *drvr, u8 ringid)
+{
+}
+
+static inline void inff_logring_fill(struct inff_pub *drvr, u8 ringid, u8 *data, u32 size)
+{
+}
+
+static inline int inff_logring_init(struct inff_pub *drvr, u8 ringid, u32 ring_item_size,
+				    dump_callback_t dump_cb)
+{
+	return 0;
+}
+
+static inline void inff_logring_deinit(struct inff_pub *drvr, u8 ringid)
+{
+}
+
+static inline int inff_logger_attach(struct inff_pub *drvr, u32 logger_level, u32 logring_depth)
+{
+	return 0;
+}
+
+static inline void inff_logger_detach(struct inff_pub *drvr)
+{
+}
+#endif /* DEBUG */
+
+#endif /* INFF_LOGGER_H */
-- 
2.25.1


