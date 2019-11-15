Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAAB1FD946
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKOJbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:31:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfKOJbh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:31:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 40BF461609; Fri, 15 Nov 2019 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810296;
        bh=Kxqc5QO3KywQh2Tr62cMbJ1rX0g2C3BZ01Ey4NzoEC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoarRHtPnvCCPjDzycV0Or8J/aFm3qKqbp6obL8dCHy09o4CBIQ1G3hxZW4eh454Q
         t2tm+xmYjonRuOv6JOWYtfs8uMYxwtlqU44b9r6zcLYzIDe7ZeyzrYACZIdG/ygbsE
         wgMzNeJ6uYuBRYlF7gaXGqA/BJ2P5zMMSorVJ62E=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E74661683;
        Fri, 15 Nov 2019 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810261;
        bh=Kxqc5QO3KywQh2Tr62cMbJ1rX0g2C3BZ01Ey4NzoEC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEa2kXAudw9IRU9DLR8hsacYPaYP5YODGdXzscNhYgtG0qHtXjGK09pH0MUlWv/p+
         RCTxtUWKFDjNfFYSjomR7gB8MDTaewtM61Zr6O7Di9aUvfLDqIlwRKv2mJKSzGt7e6
         z2Vg4tNE51teJ+X+g4N0PFjH2Jd0UQQ0HkPElLVg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E74661683
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 41/49] ath11k: add testmode.h
Date:   Fri, 15 Nov 2019 11:29:05 +0200
Message-Id: <1573810153-29623-42-git-send-email-kvalo@codeaurora.org>
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
 drivers/net/wireless/ath/ath11k/testmode.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.h b/drivers/net/wireless/ath/ath11k/testmode.h
new file mode 100644
index 000000000000..aaa122ed9069
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/testmode.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#include "core.h"
+
+#ifdef CONFIG_NL80211_TESTMODE
+
+bool ath11k_tm_event_wmi(struct ath11k *ar, u32 cmd_id, struct sk_buff *skb);
+int ath11k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  void *data, int len);
+
+#else
+
+static inline bool ath11k_tm_event_wmi(struct ath11k *ar, u32 cmd_id,
+				       struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline int ath11k_tm_cmd(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				void *data, int len)
+{
+	return 0;
+}
+
+#endif

