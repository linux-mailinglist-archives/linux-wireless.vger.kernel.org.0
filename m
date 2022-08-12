Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5F259139A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiHLQK3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbiHLQKW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F43F31E
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B30CB8247C
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89DFC433B5;
        Fri, 12 Aug 2022 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320617;
        bh=L7VhiOSz3vMeG/T6MV5omMuhW7hbiw+AGqJaNOvOotQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2OZv9J5gq1WOjguYbO6QUIdpQL2/zRJO8OHAZxrn2utw5ThenwkyQlA3yX18tVB4
         1otlH8hYOeI0/8Ly5fc9fNrpK2N5aunwFt/XuEd+RDGBSNNizlSJLn9cs/IVXiKJwd
         7y2CuFuVWeIiSWlBPRRQMI/McFJag06xRwIGr2gt0Q8nKgdei5AqatZXs2u9H95lbC
         QgmbjoPPFgtUbvFO0k4VFC70HR418KWO/HjYwIsE4YP4TRXJiSyKt5VGJvPz/y4yQy
         DsDyhWyR5hlgd1Aey7+1a82xMexG0iVbqC5NN1LKhwHmIs03eg/r1mrJlJZTwENJf+
         Eg1pMKu7Sz+lQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 10/50] wifi: ath12k: add debug.h
Date:   Fri, 12 Aug 2022 19:09:23 +0300
Message-Id: <20220812161003.27279-11-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/debug.h | 68 +++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
new file mode 100644
index 000000000000..ec2be467edbc
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/debug.h
@@ -0,0 +1,68 @@
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
+	ATH12K_DBG_DP_TX	= 0x00001000,
+	ATH12K_DBG_DP_RX	= 0x00002000,
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
+static inline int __ath12k_dbg(struct ath12k_base *ab,
+			       enum ath12k_debug_mask dbg_mask,
+			       const char *fmt, ...)
+{
+	return 0;
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

