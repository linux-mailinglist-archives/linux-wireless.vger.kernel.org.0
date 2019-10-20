Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC4DDDD9
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfJTKFw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:05:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfJTKFv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:05:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B4965612EE; Sun, 20 Oct 2019 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565950;
        bh=XJybD5uGC+L3kvQxcr+1c6jZvPE3CbU+r81KelTNQuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guNI9qXrdYQQLAH+XO+FtEU5DB2nOS1U3DqdYhil+n/+UUgpfXyvwaJGeTVmhqwr7
         GJi5qYnKtT+ftiTNaqQMTtaZ4aAwJercg/io4w29ct3d7wgsKrkf5fBrytgFmK9Btg
         lGkontr3CwK/tJxScmjL3BlNXns+FDFJhFLUI2cI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16859612DE;
        Sun, 20 Oct 2019 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565941;
        bh=XJybD5uGC+L3kvQxcr+1c6jZvPE3CbU+r81KelTNQuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gveHzsYAQVelktKDOk8ubIVZDVCAef42LSnTEFyPGZPW7eP3iPfuegN6QU3b2xKJc
         baOOXj4GGAOFMIGGg3frCuzXSf0bN1SwUyJARCoDkDJQV9fiCoiIh/nPy94ry8EcY0
         8xTdzB+F4rHPyC5III+Hun4IlUq9Zj+jszu9g6d8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16859612DE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 38/49] ath11k: add reg.h
Date:   Sun, 20 Oct 2019 13:03:56 +0300
Message-Id: <1571565847-10338-39-git-send-email-kvalo@codeaurora.org>
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
 drivers/net/wireless/ath/ath11k/reg.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
new file mode 100644
index 000000000000..39b7fc943541
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
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

