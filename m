Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CE496575
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfHTPup (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:50:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48048 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbfHTPup (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:50:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 120BE61C4E; Tue, 20 Aug 2019 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316244;
        bh=RQR2XiIPbbHMpD0U9F0wWi86BwK8o/6dTYFy1OJl6F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXjZXwUi67A4dPTteTcrpKwxTF8+n6CZaJvEK1/dRAsDiV5/o7vfLoqHMYOLnBied
         Eq7n/gn/SDCcdnctfCEemojZ6eT8JBxxsIzv6xdGthMNNqFYYVucMAsTT2Iqgn8xS5
         KwCJE8OwXkrry231l38VWpss+bPC9AHrnjAI1LAM=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EB2F61BFF;
        Tue, 20 Aug 2019 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316210;
        bh=RQR2XiIPbbHMpD0U9F0wWi86BwK8o/6dTYFy1OJl6F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrWHZcCrgzSDmwYUa4qVBYZ1hPLCgt8/kGMDzqcBJfQ/Clpk7DurZ9gHNO5QSyYA+
         zQYDSRAMtDsR1O5BHyG6FKb+O6YW7POSHccDl2XZy2HxXh+mUjXXskqbkfWUxMY+8G
         21RJ8DjZT4AP/CzxEyQ0xNXqf8iMTmXsfJg94lMY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EB2F61BFF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 41/49] ath11k: add testmode.h
Date:   Tue, 20 Aug 2019 18:48:07 +0300
Message-Id: <1566316095-27507-42-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/testmode.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.h b/drivers/net/wireless/ath/ath11k/testmode.h
new file mode 100644
index 000000000000..303091b7fe78
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/testmode.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: ISC */
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

