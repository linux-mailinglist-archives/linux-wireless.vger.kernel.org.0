Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4783D5913BA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbiHLQK2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbiHLQKV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659D0A5
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C90A26158A
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB35C433C1;
        Fri, 12 Aug 2022 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320616;
        bh=MDwsYTPrGo9CNwWMSoHQAhvjhFDCQLCa7ws1qSRRgNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPL/Y8DR/sn+y4eAR/Ayd/apBT7vJgLJt45lKdMFbuASlSwlcpRYzAs6LSwWfVAlM
         +ozWrcCdJZTzMJa3agu0uD0cW8w6naC090ljnG95hbidqnqjEkkgCLsxW5p51cJRM8
         E+sqvmOrOt0KdSj06B8rWjB4y2ediKahBpttoHe8KbNZw5Bxk20sEsdUmCyatxkvZp
         3cV2G6CNT/YVtRogMW4N47Bfpj7dZF5AbPnYphO/N1hb5t8aagRVz0yVkJ8iAmXSqO
         ttEnUjhVXKlT1Y3bdKRo98TNbZbYydmoJF71+ubnceyfHd/CUic2DC4BAeQAkVglLW
         xTK2QRsu+9zJg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 09/50] wifi: ath12k: add debug.c
Date:   Fri, 12 Aug 2022 19:09:22 +0300
Message-Id: <20220812161003.27279-10-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812161003.27279-1-kvalo@kernel.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/debug.c | 102 ++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debug.c b/drivers/net/wireless/ath/ath12k/debug.c
new file mode 100644
index 000000000000..67893923e010
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/debug.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/vmalloc.h>
+#include "core.h"
+#include "debug.h"
+
+void ath12k_info(struct ath12k_base *ab, const char *fmt, ...)
+{
+	struct va_format vaf = {
+		.fmt = fmt,
+	};
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+	dev_info(ab->dev, "%pV", &vaf);
+	/* TODO: Trace the log */
+	va_end(args);
+}
+
+void ath12k_err(struct ath12k_base *ab, const char *fmt, ...)
+{
+	struct va_format vaf = {
+		.fmt = fmt,
+	};
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+	dev_err(ab->dev, "%pV", &vaf);
+	/* TODO: Trace the log */
+	va_end(args);
+}
+
+void ath12k_warn(struct ath12k_base *ab, const char *fmt, ...)
+{
+	struct va_format vaf = {
+		.fmt = fmt,
+	};
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+	dev_warn_ratelimited(ab->dev, "%pV", &vaf);
+	/* TODO: Trace the log */
+	va_end(args);
+}
+
+#ifdef CONFIG_ATH12K_DEBUG
+
+void __ath12k_dbg(struct ath12k_base *ab, enum ath12k_debug_mask mask,
+		  const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	if (ath12k_debug_mask & mask)
+		dev_dbg(ab->dev, "%pV", &vaf);
+
+	/* TODO: trace log */
+
+	va_end(args);
+}
+
+void ath12k_dbg_dump(struct ath12k_base *ab,
+		     enum ath12k_debug_mask mask,
+		     const char *msg, const char *prefix,
+		     const void *buf, size_t len)
+{
+	char linebuf[256];
+	size_t linebuflen;
+	const void *ptr;
+
+	if (ath12k_debug_mask & mask) {
+		if (msg)
+			__ath12k_dbg(ab, mask, "%s\n", msg);
+
+		for (ptr = buf; (ptr - buf) < len; ptr += 16) {
+			linebuflen = 0;
+			linebuflen += scnprintf(linebuf + linebuflen,
+						sizeof(linebuf) - linebuflen,
+						"%s%08x: ",
+						(prefix ? prefix : ""),
+						(unsigned int)(ptr - buf));
+			hex_dump_to_buffer(ptr, len - (ptr - buf), 16, 1,
+					   linebuf + linebuflen,
+					   sizeof(linebuf) - linebuflen, true);
+			dev_dbg(ab->dev, "%s\n", linebuf);
+		}
+	}
+}
+
+#endif /* CONFIG_ATH12K_DEBUG */

