Return-Path: <linux-wireless+bounces-27381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E51FB7DC37
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950D54609FF
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52F92E0415;
	Tue, 16 Sep 2025 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="jV8adi5N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8415A24A06A
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061498; cv=none; b=csPNslDU9pDDw34S6tI1qVunOhxRd/0vJ2c/3yStKbrkCvGVvMlORqR+aYhY8tnRidF62rT7HPjizLIWeXB1Fkgo4R5iSax43+fzYTFjB/TDCP9ds80BbeZYh0cQZa1nPDYLGMG/0Bk9fF53+wPACzTSsEcFojuPVPJmhP5hdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061498; c=relaxed/simple;
	bh=ayG84R11EKPgFbscSumso8Ml7AZdQcLkQF/+uc/LXGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCcTLAX/ZXbg6zeicvfTyU0A5c/p5PwUust12ttP0zelgpWryWvT19V9+AJDSzAdIwHXm0hxHT0eg+GmbK9Kq83NSEd7wW/h6X8yZ0lQ3C3WB/QSUHiF/uoFDtdoxtMIqH8WDx6MJWpkkVIhPgOoUjzer5ZxsB19y51xn4mP9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=jV8adi5N; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061496; x=1789597496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ayG84R11EKPgFbscSumso8Ml7AZdQcLkQF/+uc/LXGo=;
  b=jV8adi5NoApPKtj3pj3F4Vyg7velkP+HISYFhFtx0K9RIZc6BudIMi54
   DtpwQRq5Omij010BOsYuDloLHSWfKVI97S/s+cMb353NelRDH+j0WyWI3
   0BoZr9Fr0go0rdHJroOTAiYL5gEniexsCQZwxSV+wtrpJ3X1Sic3vlSxJ
   M=;
X-CSE-ConnectionGUID: h2ezRd+4QmW2T7IDjqPxlQ==
X-CSE-MsgGUID: YjIBq0hQRmW+W9Yve2GpIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093587"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093587"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:24:54 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:24:54 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:24:52 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 26/57] wifi: inffmac: add tracepoint.c/h
Date: Wed, 17 Sep 2025 03:47:46 +0530
Message-ID: <20250916221821.4387-32-gokulkumar.sivakumar@infineon.com>
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

Driver implementation to define tracepoints which can be traced using the
Kernel's FTRACE support. Helpful while debugging the funcationalities.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../wireless/infineon/inffmac/tracepoint.c    |  35 +++++
 .../wireless/infineon/inffmac/tracepoint.h    | 138 ++++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/tracepoint.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/tracepoint.h

diff --git a/drivers/net/wireless/infineon/inffmac/tracepoint.c b/drivers/net/wireless/infineon/inffmac/tracepoint.c
new file mode 100644
index 000000000000..627481ce538b
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/tracepoint.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h> /* bug in tracepoint.h, it should include this */
+
+#ifndef __CHECKER__
+#define CREATE_TRACE_POINTS
+#include "bus.h"
+#include "tracepoint.h"
+#include "debug.h"
+
+void __inff_err(struct inff_bus *bus, const char *func, const char *fmt, ...)
+{
+	struct va_format vaf = {
+		.fmt = fmt,
+	};
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+	if (bus)
+		dev_err(bus->dev, "%s: %pV", func, &vaf);
+	else
+		pr_err("%s: %pV", func, &vaf);
+	trace_inff_err(func, &vaf);
+	va_end(args);
+}
+
+#endif
diff --git a/drivers/net/wireless/infineon/inffmac/tracepoint.h b/drivers/net/wireless/infineon/inffmac/tracepoint.h
new file mode 100644
index 000000000000..e6e1778574ea
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/tracepoint.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#if !defined(INFF_TRACEPOINT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define INFF_TRACEPOINT_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+#ifndef CONFIG_INF_TRACING
+
+#undef TRACE_EVENT
+#define TRACE_EVENT(name, proto, ...) \
+static inline void trace_ ## name(proto) {}
+
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(...)
+
+#undef DEFINE_EVENT
+#define DEFINE_EVENT(name, proto, ...) \
+static inline void trace_ ## name(proto) {}
+
+#endif /* CONFIG_INF_TRACING */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM	inffmac
+
+#define MAX_MSG_LEN		100
+
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
+
+TRACE_EVENT(inff_err,
+	    TP_PROTO(const char *func, struct va_format *vaf),
+	    TP_ARGS(func, vaf),
+	    TP_STRUCT__entry(__string(func, func)
+		__vstring(msg, vaf->fmt, vaf->va)
+	    ),
+	    TP_fast_assign(__assign_str(func);
+		__assign_vstr(msg, vaf->fmt, vaf->va);
+	    ),
+	    TP_printk("%s: %s", __get_str(func), __get_str(msg))
+);
+
+TRACE_EVENT(inff_dbg,
+	    TP_PROTO(u32 level, const char *func, struct va_format *vaf),
+	    TP_ARGS(level, func, vaf),
+	    TP_STRUCT__entry(__field(u32, level)
+		__string(func, func)
+		__vstring(msg, vaf->fmt, vaf->va)
+	    ),
+	    TP_fast_assign(__entry->level = level;
+		__assign_str(func);
+		__assign_vstr(msg, vaf->fmt, vaf->va);
+	    ),
+	    TP_printk("%s: %s", __get_str(func), __get_str(msg))
+);
+
+TRACE_EVENT(inff_hexdump,
+	    TP_PROTO(void *data, size_t len),
+	    TP_ARGS(data, len),
+	    TP_STRUCT__entry(__field(unsigned long, len)
+		__field(unsigned long, addr)
+		__dynamic_array(u8, hdata, len)
+	    ),
+	    TP_fast_assign(__entry->len = len;
+		__entry->addr = (unsigned long)data;
+		memcpy(__get_dynamic_array(hdata), data, len);
+	    ),
+	    TP_printk("hexdump [addr=%lx, length=%lu]", __entry->addr, __entry->len)
+);
+
+TRACE_EVENT(inff_bcdchdr,
+	    TP_PROTO(void *data),
+	    TP_ARGS(data),
+	    TP_STRUCT__entry(__field(u8, flags)
+		__field(u8, prio)
+		__field(u8, flags2)
+		__field(u32, siglen)
+		__dynamic_array(u8, signal, *((u8 *)data + 3) * 4)
+	    ),
+	    TP_fast_assign(__entry->flags = *(u8 *)data;
+		__entry->prio = *((u8 *)data + 1);
+		__entry->flags2 = *((u8 *)data + 2);
+		__entry->siglen = *((u8 *)data + 3) * 4;
+		memcpy(__get_dynamic_array(signal),
+		       (u8 *)data + 4, __entry->siglen);
+	    ),
+	    TP_printk("bcdc: prio=%d siglen=%d", __entry->prio, __entry->siglen)
+);
+
+#ifndef SDPCM_RX
+#define SDPCM_RX	0
+#endif
+#ifndef SDPCM_TX
+#define SDPCM_TX	1
+#endif
+#ifndef SDPCM_GLOM
+#define SDPCM_GLOM	2
+#endif
+
+TRACE_EVENT(inff_sdpcm_hdr,
+	    TP_PROTO(u8 dir, void *data),
+	    TP_ARGS(dir, data),
+	    TP_STRUCT__entry(__field(u8, dir)
+		__field(u16, len)
+		__dynamic_array(u8, hdr, dir == SDPCM_GLOM ? 20 : 12)
+	    ),
+	    TP_fast_assign(memcpy(__get_dynamic_array(hdr), data, dir == SDPCM_GLOM ? 20 : 12);
+		__entry->len = *(u8 *)data | (*((u8 *)data + 1) << 8);
+		__entry->dir = dir;
+	    ),
+	    TP_printk("sdpcm: %s len %u, seq %d",
+		      __entry->dir == SDPCM_RX ? "RX" : "TX",
+		      __entry->len, ((u8 *)__get_dynamic_array(hdr))[4])
+);
+
+#pragma GCC diagnostic pop
+
+#ifdef CONFIG_INF_TRACING
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE tracepoint
+
+#include <trace/define_trace.h>
+
+#endif /* CONFIG_INF_TRACING */
+
+#endif /* INFF_TRACEPOINT_H */
-- 
2.25.1


