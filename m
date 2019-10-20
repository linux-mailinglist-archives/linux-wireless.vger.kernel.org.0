Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F443DDD95
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfJTKEV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:04:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41848 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfJTKEV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:04:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 63EB960D88; Sun, 20 Oct 2019 10:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565860;
        bh=XNnZrPa3X7L+4iMhJWvzMUdrtJfKeuxn4SgCk2k3lIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GrVNuI7crko9XeJCXDwdLU2ajxYyvxwzgzwqCWVRffFTBEWIAGw1dvXwQzLnYL+BP
         Qpk55qwsvivB5OXqx70DsNb7kSyVDKjOq94BcLCEQZHqfCN16ddzfIbUD0pAM4sxls
         uiLlxsiJ2qwya49dSdW76Qmo8Z4uOl6GccNLi6o8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98B0C60D9D;
        Sun, 20 Oct 2019 10:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565858;
        bh=XNnZrPa3X7L+4iMhJWvzMUdrtJfKeuxn4SgCk2k3lIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tooph1XOsE95RXcRZhggjq0O0tv7DG1jkojc7iGb3REoR14IPoDVmBhOfYbcmjiqR
         0Q/UPack26HRgq7lf7YLDGQDtOiHXfjVx1ipWIcm00AEMIsyi/v9rMcDqjUXqis57M
         2U3xGUnVUGQrhi0YyV6SN0iL24XfX7ek4Pcx6Too=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98B0C60D9D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 05/49] ath11k: add ahb.h
Date:   Sun, 20 Oct 2019 13:03:23 +0300
Message-Id: <1571565847-10338-6-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
References: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(patches split for easier review, see the cover letter for more)

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.h b/drivers/net/wireless/ath/ath11k/ahb.h
new file mode 100644
index 000000000000..93f46dfe22df
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/ahb.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+#ifndef ATH11K_AHB_H
+#define ATH11K_AHB_H
+
+#include "core.h"
+
+#define ATH11K_AHB_RECOVERY_TIMEOUT (3 * HZ)
+struct ath11k_base;
+
+static inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 offset)
+{
+	return ioread32(ab->mem + offset);
+}
+
+static inline void ath11k_ahb_write32(struct ath11k_base *ab, u32 offset, u32 value)
+{
+	iowrite32(value, ab->mem + offset);
+}
+
+void ath11k_ahb_ext_irq_enable(struct ath11k_base *ab);
+void ath11k_ahb_ext_irq_disable(struct ath11k_base *ab);
+int ath11k_ahb_start(struct ath11k_base *ab);
+void ath11k_ahb_stop(struct ath11k_base *ab);
+int ath11k_ahb_power_up(struct ath11k_base *ab);
+void ath11k_ahb_power_down(struct ath11k_base *ab);
+int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
+				   u8 *ul_pipe, u8 *dl_pipe);
+
+int ath11k_ahb_init(void);
+void ath11k_ahb_exit(void);
+
+#endif

