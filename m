Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422AF62C526
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbiKPQot (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKPQns (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:43:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E73959869
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC80DCE1BF0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E05BC433C1;
        Wed, 16 Nov 2022 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616795;
        bh=FuZczF/hyCy9Ks5fu7boL/st6k7IVj/C/Yj5WbdQ/rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ng1LIGQlljpWlNVRjYdu72g1qP5e+mlcnvs+E4asXoy5eGwWvXNDfxqfIivMMfXro
         JO+q5rkpXBeNgapEEjDZnhyfO3+e16lIm8t1q907viVJQ0hsUrwk2hPe2c6Dp+RRpt
         8pimBsPpOdfllDEuDqP2L/cvQm3OO+16FdrWNJwAKOG9UJ2seoiDKEsTlzcfId2o8z
         p3+EivQW8VsfFYQNXDocCSTwwaWCembkkg53l4kieNYyvyUV30xDd62tcAQV6+aTqV
         QyKrnzCtiTlrTAAhsLDJvM1Xvg/wiSLbgUsn3cCSJEcweMX2q1/LWW1S28vtD6Zv4d
         hgXlzOJG8A9Ng==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 45/50] wifi: ath12k: add trace.h
Date:   Wed, 16 Nov 2022 18:38:57 +0200
Message-Id: <20221116163902.24996-46-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/trace.h | 152 ++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/trace.h b/drivers/net/wireless/ath/ath12k/trace.h
new file mode 100644
index 000000000000..f72096684b74
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/trace.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#if !defined(_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
+
+#include <linux/tracepoint.h>
+#include "core.h"
+
+#define _TRACE_H_
+
+/* create empty functions when tracing is disabled */
+#if !defined(CONFIG_ATH12K_TRACING)
+#undef TRACE_EVENT
+#define TRACE_EVENT(name, proto, ...) \
+static inline void trace_ ## name(proto) {}
+#endif /* !CONFIG_ATH12K_TRACING || __CHECKER__ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ath12k
+
+TRACE_EVENT(ath12k_htt_pktlog,
+	    TP_PROTO(struct ath12k *ar, const void *buf, u16 buf_len,
+		     u32 pktlog_checksum),
+
+	TP_ARGS(ar, buf, buf_len, pktlog_checksum),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(ar->ab->dev))
+		__string(driver, dev_driver_string(ar->ab->dev))
+		__field(u16, buf_len)
+		__field(u32, pktlog_checksum)
+		__dynamic_array(u8, pktlog, buf_len)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(ar->ab->dev));
+		__assign_str(driver, dev_driver_string(ar->ab->dev));
+		__entry->buf_len = buf_len;
+		__entry->pktlog_checksum = pktlog_checksum;
+		memcpy(__get_dynamic_array(pktlog), buf, buf_len);
+	),
+
+	TP_printk(
+		"%s %s size %u pktlog_checksum %d",
+		__get_str(driver),
+		__get_str(device),
+		__entry->buf_len,
+		__entry->pktlog_checksum
+	 )
+);
+
+TRACE_EVENT(ath12k_htt_ppdu_stats,
+	    TP_PROTO(struct ath12k *ar, const void *data, size_t len),
+
+	TP_ARGS(ar, data, len),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(ar->ab->dev))
+		__string(driver, dev_driver_string(ar->ab->dev))
+		__field(u16, len)
+		__field(u32, info)
+		__field(u32, sync_tstmp_lo_us)
+		__field(u32, sync_tstmp_hi_us)
+		__field(u32, mlo_offset_lo)
+		__field(u32, mlo_offset_hi)
+		__field(u32, mlo_offset_clks)
+		__field(u32, mlo_comp_clks)
+		__field(u32, mlo_comp_timer)
+		__dynamic_array(u8, ppdu, len)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(ar->ab->dev));
+		__assign_str(driver, dev_driver_string(ar->ab->dev));
+		__entry->len = len;
+		__entry->info = ar->pdev->timestamp.info;
+		__entry->sync_tstmp_lo_us = ar->pdev->timestamp.sync_timestamp_hi_us;
+		__entry->sync_tstmp_hi_us = ar->pdev->timestamp.sync_timestamp_lo_us;
+		__entry->mlo_offset_lo = ar->pdev->timestamp.mlo_offset_lo;
+		__entry->mlo_offset_hi = ar->pdev->timestamp.mlo_offset_hi;
+		__entry->mlo_offset_clks = ar->pdev->timestamp.mlo_offset_clks;
+		__entry->mlo_comp_clks = ar->pdev->timestamp.mlo_comp_clks;
+		__entry->mlo_comp_timer = ar->pdev->timestamp.mlo_comp_timer;
+		memcpy(__get_dynamic_array(ppdu), data, len);
+	),
+
+	TP_printk(
+		"%s %s ppdu len %d",
+		__get_str(driver),
+		__get_str(device),
+		__entry->len
+	 )
+);
+
+TRACE_EVENT(ath12k_htt_rxdesc,
+	    TP_PROTO(struct ath12k *ar, const void *data, size_t type, size_t len),
+
+	TP_ARGS(ar, data, type, len),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(ar->ab->dev))
+		__string(driver, dev_driver_string(ar->ab->dev))
+		__field(u16, len)
+		__field(u16, type)
+		__field(u32, info)
+		__field(u32, sync_tstmp_lo_us)
+		__field(u32, sync_tstmp_hi_us)
+		__field(u32, mlo_offset_lo)
+		__field(u32, mlo_offset_hi)
+		__field(u32, mlo_offset_clks)
+		__field(u32, mlo_comp_clks)
+		__field(u32, mlo_comp_timer)
+		__dynamic_array(u8, rxdesc, len)
+	),
+
+	TP_fast_assign(
+		__assign_str(device, dev_name(ar->ab->dev));
+		__assign_str(driver, dev_driver_string(ar->ab->dev));
+		__entry->len = len;
+		__entry->type = type;
+		__entry->info = ar->pdev->timestamp.info;
+		__entry->sync_tstmp_lo_us = ar->pdev->timestamp.sync_timestamp_hi_us;
+		__entry->sync_tstmp_hi_us = ar->pdev->timestamp.sync_timestamp_lo_us;
+		__entry->mlo_offset_lo = ar->pdev->timestamp.mlo_offset_lo;
+		__entry->mlo_offset_hi = ar->pdev->timestamp.mlo_offset_hi;
+		__entry->mlo_offset_clks = ar->pdev->timestamp.mlo_offset_clks;
+		__entry->mlo_comp_clks = ar->pdev->timestamp.mlo_comp_clks;
+		__entry->mlo_comp_timer = ar->pdev->timestamp.mlo_comp_timer;
+		memcpy(__get_dynamic_array(rxdesc), data, len);
+	),
+
+	TP_printk(
+		"%s %s rxdesc len %d",
+		__get_str(driver),
+		__get_str(device),
+		__entry->len
+	 )
+);
+
+#endif /* _TRACE_H_ || TRACE_HEADER_MULTI_READ*/
+
+/* we don't want to use include/trace/events */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

