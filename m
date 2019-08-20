Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601099651D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfHTPsi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:48:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39196 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbfHTPsh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:48:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C34B361A39; Tue, 20 Aug 2019 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316116;
        bh=C9e0dZgzKJg7gHIfkg0xgSxFRlyUr9xm5pxFjMx5Wis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkSeJnZxdub1/3y530HtYG7pwc/1w4eyoN3anKVryoM77rnCocBrjzOI6CRHvX7UC
         /aQazrzCrNyF7fNKfIJaHHzLmpIxMHzPV5Dw9nTzEpWE37UvRkntpEny/YPkLrwN1h
         C10tld9860BgUn0aSJPb2gYbWJNB2347UPnTsGRA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 664E761A24;
        Tue, 20 Aug 2019 15:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316110;
        bh=C9e0dZgzKJg7gHIfkg0xgSxFRlyUr9xm5pxFjMx5Wis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajU+zNsxQDrwEDDU0cwsfCHgwQeXFOSznCWcfyXen387wBmkaFKt/lcm+J3tpfXzN
         R+zx4HOtclUzZmZ+seGo5IlCXz0HaFeDXIjybyw5RtboLtJEOJKwwc/qjOdS8gfXV6
         kmirJM5059hSZ1uM/sSO6To6rBWoa5YKb/YEFOYs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 664E761A24
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 05/49] ath11k: add ahb.h
Date:   Tue, 20 Aug 2019 18:47:31 +0300
Message-Id: <1566316095-27507-6-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/ahb.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.h b/drivers/net/wireless/ath/ath11k/ahb.h
new file mode 100644
index 000000000000..8a6b308d4a6a
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/ahb.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: ISC */
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
+u32 ath11k_ahb_read32(struct ath11k_base *ab, u32 address);
+void ath11k_ahb_write32(struct ath11k_base *ab, u32 address, u32 data);
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

