Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6448496562
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfHTPuX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:50:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46208 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730699AbfHTPuW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:50:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8FB5761BCE; Tue, 20 Aug 2019 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316221;
        bh=SqD20Sd9Z5y43Sj+h9v7V1YVBNUkdZH9DYiwbga7BHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AglYdwEhN4V6KWWpBYzCIwm/oWNWQ8yxQXCQI4Yuc1+6sXh6QYV8K8azjv8Hc2XYg
         lEUgLtlyW5p6HIlFKkTWPFN0+LQARPALvo/Nr3w7IVftBjzaQtNdlQOuYPFukeot9B
         NOwkWpgdx1jXtWlx628z81sOGBImoG9AJiri86O4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2EBB761BBE;
        Tue, 20 Aug 2019 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316204;
        bh=SqD20Sd9Z5y43Sj+h9v7V1YVBNUkdZH9DYiwbga7BHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jziJsUYcjHG04ofrPzc+AhaZQWVxlioMsDW9ypme7ci8mKhrjoWLBiibb+hoQMtDh
         sEVNA64qX8nHaH2Tlu/TcnvkAlLGfzqw/YG6AGIgcSyACB/zWfdBfUJnMDeWUDAh3f
         SyqYn7yvMk2r8C/p0mW+5yWHsxZrBfPavWxrfMTk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EBB761BBE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 38/49] ath11k: add reg.h
Date:   Tue, 20 Aug 2019 18:48:04 +0300
Message-Id: <1566316095-27507-39-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/reg.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
new file mode 100644
index 000000000000..d0fc246a34ce
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef ATH11K_REG_H
+#define ATH11K_REG_H
+
+#include <linux/kernel.h>
+#include <net/regulatory.h>
+
+struct ath11k_base;
+struct ath11k;
+
+/* DFS regdomains supported by Firmware */
+enum ath11k_dfs_region {
+	ATH11K_DFS_REG_UNSET,
+	ATH11K_DFS_REG_FCC,
+	ATH11K_DFS_REG_ETSI,
+	ATH11K_DFS_REG_MKK,
+	ATH11K_DFS_REG_CN,
+	ATH11K_DFS_REG_KR,
+	ATH11K_DFS_REG_UNDEF,
+};
+
+/* ATH11K Regulatory API's */
+void ath11k_reg_init(struct ath11k *ar);
+void ath11k_reg_free(struct ath11k_base *ab);
+void ath11k_regd_update_work(struct work_struct *work);
+struct ieee80211_regdomain *
+ath11k_reg_build_regd(struct ath11k_base *ab,
+		      struct cur_regulatory_info *reg_info, bool intersect);
+int ath11k_regd_update(struct ath11k *ar, bool init);
+int ath11k_reg_update_chan_list(struct ath11k *ar);
+#endif

