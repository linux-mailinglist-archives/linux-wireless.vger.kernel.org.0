Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284D4FD938
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfKOJbP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:31:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKOJbP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:31:15 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8809C61413; Fri, 15 Nov 2019 09:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810274;
        bh=fa9hCX4g8slCcLccmmk0EFGldfw/IJlSmmXGheDaPds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTgl+YNhJHV724KJzfyZlYAobZxTa5sCHTiUqFMzLkswb2sWtz66SqJRbrL1Hlr61
         M2uVrY6UHTzRAmxJrdlogZp/vXggX6Khd2sy/Z3w8ue61TuUU1Fjrb4HIbKTRkd1uY
         1jlEuQUTf+lTntwzASYwCC7KeEHVswUbaqxRZ254=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD35B6168F;
        Fri, 15 Nov 2019 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810263;
        bh=fa9hCX4g8slCcLccmmk0EFGldfw/IJlSmmXGheDaPds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FunSewchpIpUn/rvkZZEjGsSDlgVX/1PrPh9/aBV3DaOo+LDOmzKGkpp/uPawWoa2
         k+m8525u6FalvvxvyoqKdHZZb4K6swrV/Tv0KexAwadpKL12s3bGE4RwTLXlcpByIa
         /wgUituU7J312W2SPuaM78ScL4VmIteMYy+TereI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD35B6168F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 42/49] ath11k: add testmode_i.h
Date:   Fri, 15 Nov 2019 11:29:06 +0200
Message-Id: <1573810153-29623-43-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
References: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(patches split for easier review, see the cover letter for more)

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/testmode_i.h | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/testmode_i.h b/drivers/net/wireless/ath/ath11k/testmode_i.h
new file mode 100644
index 000000000000..4bae2a9eeea4
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/testmode_i.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+/* "API" level of the ath11k testmode interface. Bump it after every
+ * incompatible interface change.
+ */
+#define ATH11K_TESTMODE_VERSION_MAJOR 1
+
+/* Bump this after every _compatible_ interface change, for example
+ * addition of a new command or an attribute.
+ */
+#define ATH11K_TESTMODE_VERSION_MINOR 0
+
+#define ATH11K_TM_DATA_MAX_LEN		5000
+
+enum ath11k_tm_attr {
+	__ATH11K_TM_ATTR_INVALID		= 0,
+	ATH11K_TM_ATTR_CMD			= 1,
+	ATH11K_TM_ATTR_DATA			= 2,
+	ATH11K_TM_ATTR_WMI_CMDID		= 3,
+	ATH11K_TM_ATTR_VERSION_MAJOR		= 4,
+	ATH11K_TM_ATTR_VERSION_MINOR		= 5,
+	ATH11K_TM_ATTR_WMI_OP_VERSION		= 6,
+
+	/* keep last */
+	__ATH11K_TM_ATTR_AFTER_LAST,
+	ATH11K_TM_ATTR_MAX		= __ATH11K_TM_ATTR_AFTER_LAST - 1,
+};
+
+/* All ath11k testmode interface commands specified in
+ * ATH11K_TM_ATTR_CMD
+ */
+enum ath11k_tm_cmd {
+	/* Returns the supported ath11k testmode interface version in
+	 * ATH11K_TM_ATTR_VERSION. Always guaranteed to work. User space
+	 * uses this to verify it's using the correct version of the
+	 * testmode interface
+	 */
+	ATH11K_TM_CMD_GET_VERSION = 0,
+
+	/* The command used to transmit a WMI command to the firmware and
+	 * the event to receive WMI events from the firmware. Without
+	 * struct wmi_cmd_hdr header, only the WMI payload. Command id is
+	 * provided with ATH11K_TM_ATTR_WMI_CMDID and payload in
+	 * ATH11K_TM_ATTR_DATA.
+	 */
+	ATH11K_TM_CMD_WMI = 1,
+};

