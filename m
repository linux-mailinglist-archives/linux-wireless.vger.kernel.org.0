Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD9262C4FF
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbiKPQnq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiKPQm7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:42:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA8A1B0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61F6DB81DFC
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850D0C433D6;
        Wed, 16 Nov 2022 16:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616757;
        bh=MDwsYTPrGo9CNwWMSoHQAhvjhFDCQLCa7ws1qSRRgNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeD+yrbd9l7T8Y8f444Z3iogIq4FqxK5+n0ZzLY7ElIOzaWCT3ZWuVlUuW3RaCxLK
         VxCAd2w1RypHz2TaJ1lsjs4r790X+PKaEuYNv4PN4CR4EGDJbiUbUlddlvIoIqhENM
         IP3o+xTrEYGEuY9UDrpimYd1unjwxPpfy3hNduaOn8dxGlrM/Exhe8++UewMbgfyaa
         J3oMWozQRJ6WF/umuBcT0oJsdQ8rtsWMz8pTAcVHwn2Aw4tAeb2P36xWR0tYqfI1wP
         1cM9EzXDc20RYKW5Zu1raLsdFl0Ac58hfVpNRXczJqgodeAek5W0FCMJC9elDwAfY1
         eq2Z0qSVC0txg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 09/50] wifi: ath12k: add debug.c
Date:   Wed, 16 Nov 2022 18:38:21 +0200
Message-Id: <20221116163902.24996-10-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116163902.24996-1-kvalo@kernel.org>
References: <20221116163902.24996-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

