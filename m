Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA7DDDDD
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfJTKFz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:05:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfJTKFy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:05:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5D0AA6164E; Sun, 20 Oct 2019 10:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565953;
        bh=fa9hCX4g8slCcLccmmk0EFGldfw/IJlSmmXGheDaPds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DRkLE0pbVRMeYIFb/U14NtB7121L1Zz66QqMEw1rIE8Kz/ArXqer7d5lwFR1nQ1C6
         5jZxt9HBi1w4RapTELeWvAMkNnml08264cZe2eYLwIrOVklcsrM6hhTJv0yTgu6+rK
         ufPLEObnTC0xmg6pGFLgzHFOzYP7tJ3Ojt7oOR7w=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C7CBB6164C;
        Sun, 20 Oct 2019 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565949;
        bh=fa9hCX4g8slCcLccmmk0EFGldfw/IJlSmmXGheDaPds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eWv4K+8xmktX2f/SNMCPRe6Dn3GP2gEmN1S7L/nbSYUzAg0maCmskZnaBl2meNx+I
         r4awoJnZgGr9QQRgbHvoM0DEuea/1r0UZMq6C9qBIaF3MnR5NiDozvGhuKTBmXBLXW
         ODyu34JsFrZDXR+4HshXy48JzGnz2Q+VlcB6vIHo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7CBB6164C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 42/49] ath11k: add testmode_i.h
Date:   Sun, 20 Oct 2019 13:04:00 +0300
Message-Id: <1571565847-10338-43-git-send-email-kvalo@codeaurora.org>
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

