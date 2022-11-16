Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C8162C500
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiKPQnq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiKPQm7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:42:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84E2A462
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63FC9B81DBF
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBC2C433D7;
        Wed, 16 Nov 2022 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616758;
        bh=4IoCUrGf0FwbVKzhWv2BPh7LogF1bHxu5TFd/Yrmcz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXtWoIe1FGY27cl21vVsZ52K5OWOs6mnSzuJ5+rjxDMQR9FgLS4BHnaV6RDrprlbQ
         qs4Mctglg4u4VBSzbXiTmilRNfWqOFL/qWaUItnUWP3nc52roI/3kEUdHpIjG3ksM+
         4LSLlBS87wtcamGRuq1vKs36oMjg45e5bxChFeRU3iYxhIQJxqltuvvPjq3c9Synnk
         1Ugm1+7aFXoaeSGh9ddjDND15joBwyevemCR3YP2AEgGdV+8z9ALFyfc1FLY0TyLGY
         nbZnhQ+pahMg/EtniOlYvZ7oYgchzvEMCwg4gkly6h9fTEIgA0DjZBVST+WI54zPp0
         zpFkRKLoqx3eg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 10/50] wifi: ath12k: add debug.h
Date:   Wed, 16 Nov 2022 18:38:22 +0200
Message-Id: <20221116163902.24996-11-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/debug.h | 67 +++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
new file mode 100644
index 000000000000..aa685295f8a4
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/debug.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _ATH12K_DEBUG_H_
+#define _ATH12K_DEBUG_H_
+
+#include "trace.h"
+
+enum ath12k_debug_mask {
+	ATH12K_DBG_AHB		= 0x00000001,
+	ATH12K_DBG_WMI		= 0x00000002,
+	ATH12K_DBG_HTC		= 0x00000004,
+	ATH12K_DBG_DP_HTT	= 0x00000008,
+	ATH12K_DBG_MAC		= 0x00000010,
+	ATH12K_DBG_BOOT		= 0x00000020,
+	ATH12K_DBG_QMI		= 0x00000040,
+	ATH12K_DBG_DATA		= 0x00000080,
+	ATH12K_DBG_MGMT		= 0x00000100,
+	ATH12K_DBG_REG		= 0x00000200,
+	ATH12K_DBG_TESTMODE	= 0x00000400,
+	ATH12K_DBG_HAL		= 0x00000800,
+	ATH12K_DBG_PCI		= 0x00001000,
+	ATH12K_DBG_DP_TX	= 0x00002000,
+	ATH12K_DBG_DP_RX	= 0x00004000,
+	ATH12K_DBG_ANY		= 0xffffffff,
+};
+
+__printf(2, 3) void ath12k_info(struct ath12k_base *ab, const char *fmt, ...);
+__printf(2, 3) void ath12k_err(struct ath12k_base *ab, const char *fmt, ...);
+__printf(2, 3) void ath12k_warn(struct ath12k_base *ab, const char *fmt, ...);
+
+extern unsigned int ath12k_debug_mask;
+
+#ifdef CONFIG_ATH12K_DEBUG
+__printf(3, 4) void __ath12k_dbg(struct ath12k_base *ab,
+				 enum ath12k_debug_mask mask,
+				 const char *fmt, ...);
+void ath12k_dbg_dump(struct ath12k_base *ab,
+		     enum ath12k_debug_mask mask,
+		     const char *msg, const char *prefix,
+		     const void *buf, size_t len);
+#else /* CONFIG_ATH12K_DEBUG */
+static inline void __ath12k_dbg(struct ath12k_base *ab,
+				enum ath12k_debug_mask dbg_mask,
+				const char *fmt, ...)
+{
+}
+
+static inline void ath12k_dbg_dump(struct ath12k_base *ab,
+				   enum ath12k_debug_mask mask,
+				   const char *msg, const char *prefix,
+				   const void *buf, size_t len)
+{
+}
+#endif /* CONFIG_ATH12K_DEBUG */
+
+#define ath12k_dbg(ar, dbg_mask, fmt, ...)			\
+do {								\
+	typeof(dbg_mask) mask = (dbg_mask);			\
+	if (ath12k_debug_mask & mask)				\
+		__ath12k_dbg(ar, mask, fmt, ##__VA_ARGS__);	\
+} while (0)
+
+#endif /* _ATH12K_DEBUG_H_ */

