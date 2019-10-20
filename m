Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32183DDDDC
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfJTKFy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:05:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49972 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfJTKFx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:05:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8BEAF61645; Sun, 20 Oct 2019 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565952;
        bh=Kxqc5QO3KywQh2Tr62cMbJ1rX0g2C3BZ01Ey4NzoEC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLKW1ltksHGRulpmopMC6aiC8w33p+4c7X6e3FWpuh8o8g2IJeS76c3cmvsGkvS4u
         agQVl3df9uk5MvKy5NNC75qz7TdP9SmMBtkJp0StptVNzdIr8zsoREzTgoEqn3Vxqy
         yuSQWHsT3XqMEOr3iaG8WlqbdRpcA3ck+mTb0Xwo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 267B361271;
        Sun, 20 Oct 2019 10:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565947;
        bh=Kxqc5QO3KywQh2Tr62cMbJ1rX0g2C3BZ01Ey4NzoEC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGSqOrqeQMZ+AL6YODTIWn9PHENIUp9ihV2HubVY4pb93izFjaL/J40dYBfHNyPr9
         SFLOvD/ctqQwxWrGF+uVS3DaokHJ0BQ6aEiZpKNC1QmFbBanQgRgbW3PxfzNQA3n1r
         kV2wxq+cfV7uHYTaS/FDJrdWUleBsnEWs/E7iFBA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 267B361271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 41/49] ath11k: add testmode.h
Date:   Sun, 20 Oct 2019 13:03:59 +0300
Message-Id: <1571565847-10338-42-git-send-email-kvalo@codeaurora.org>
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

