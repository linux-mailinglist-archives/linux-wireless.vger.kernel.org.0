Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCBE1FB33A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgFPOBZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:01:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25510 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbgFPOBZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:01:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592316083; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=AY4XGsdHzs+GRhKR3zzGdtnW2aQdPyTG2VLnDPVl4dA=; b=QYyk6UulP6CRraYB92t09wc4Y2YpILWwWdtKGg7uLDDpYmxvREgm/5i9gPwq9tQmcpnl0vsh
 2atuZP7dKjQNyAWDgt80IqU1cHFgvuy6gniKw1XoRGtGdkI5nnnI3V+fRoihIZS9bpwcjYTD
 uySTBBtEKs60OCKRMFwtv8k0BXg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5ee8d0a65866879c76974368 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 14:01:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD13DC433C8; Tue, 16 Jun 2020 14:01:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B29F4C433C9;
        Tue, 16 Jun 2020 14:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B29F4C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 04/12] ath11k: add hw_ops for pdev id to hw_mac mapping
Date:   Tue, 16 Jun 2020 17:00:47 +0300
Message-Id: <1592316055-24958-5-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
References: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

pdev_id to hw_mac is different for ipq8074 and ipq6018
Below table has the mapping

pdev_id	ipq8074	ipq6018
-------	------- -------
  0		0	0
  1		2	1
  2		1	Not applicable

No functional changes. Compile tested only.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/Makefile |  3 ++-
 drivers/net/wireless/ath/ath11k/ahb.c    | 15 +++++++-------
 drivers/net/wireless/ath/ath11k/core.c   | 18 +----------------
 drivers/net/wireless/ath/ath11k/core.h   |  1 -
 drivers/net/wireless/ath/ath11k/hw.c     | 34 ++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h     | 19 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.c    |  2 +-
 7 files changed, 65 insertions(+), 27 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/hw.c

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index 104186373c9e..ee13a3becbcf 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -16,7 +16,8 @@ ath11k-y += core.o \
 	    debug.o \
 	    ce.o \
 	    peer.o \
-	    dbring.o
+	    dbring.o \
+	    hw.o
 
 ath11k-$(CONFIG_ATH11K_DEBUGFS) += debug_htt_stats.o debugfs_sta.o
 ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 2ea6da7682ce..7e9bfeaaf4d2 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -734,6 +734,7 @@ static irqreturn_t ath11k_ahb_ext_interrupt_handler(int irq, void *arg)
 
 static int ath11k_ahb_ext_irq_config(struct ath11k_base *ab)
 {
+	struct ath11k_hw_params *hw = &ab->hw_params;
 	int i, j;
 	int irq;
 	int ret;
@@ -768,26 +769,26 @@ static int ath11k_ahb_ext_irq_config(struct ath11k_base *ab)
 			if (ath11k_reo_status_ring_mask[i] & BIT(j))
 				irq_grp->irqs[num_irq++] = reo2host_status;
 
-			if (j < MAX_RADIOS) {
+			if (j < ab->hw_params.max_radios) {
 				if (ath11k_rxdma2host_ring_mask[i] & BIT(j)) {
 					irq_grp->irqs[num_irq++] =
-						rxdma2host_destination_ring_mac1
-						- ath11k_core_get_hw_mac_id(ab, j);
+						rxdma2host_destination_ring_mac1 -
+						ath11k_hw_get_mac_from_pdev_id(hw, j);
 				}
 
 				if (ath11k_host2rxdma_ring_mask[i] & BIT(j)) {
 					irq_grp->irqs[num_irq++] =
-						host2rxdma_host_buf_ring_mac1
-						- ath11k_core_get_hw_mac_id(ab, j);
+						host2rxdma_host_buf_ring_mac1 -
+						ath11k_hw_get_mac_from_pdev_id(hw, j);
 				}
 
 				if (rx_mon_status_ring_mask[i] & BIT(j)) {
 					irq_grp->irqs[num_irq++] =
 						ppdu_end_interrupts_mac1 -
-						ath11k_core_get_hw_mac_id(ab, j);
+						ath11k_hw_get_mac_from_pdev_id(hw, j);
 					irq_grp->irqs[num_irq++] =
 						rxdma2host_monitor_status_ring_mac1 -
-						ath11k_core_get_hw_mac_id(ab, j);
+						ath11k_hw_get_mac_from_pdev_id(hw, j);
 				}
 			}
 		}
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 67822508327c..089b46ba86c5 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -27,26 +27,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 			.cal_size =  IPQ8074_MAX_CAL_DATA_SZ,
 		},
 		.max_radios = 3,
+		.hw_ops = &ipq8074_ops,
 	},
 };
 
-/* Map from pdev index to hw mac index */
-u8 ath11k_core_get_hw_mac_id(struct ath11k_base *ab, int pdev_idx)
-{
-	switch (pdev_idx) {
-	case 0:
-		return 0;
-	case 1:
-		return 2;
-	case 2:
-		return 1;
-	default:
-		ath11k_warn(ab, "Invalid pdev idx %d\n", pdev_idx);
-		return ATH11K_INVALID_HW_MAC_ID;
-	}
-}
-EXPORT_SYMBOL(ath11k_core_get_hw_mac_id);
-
 static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 					 size_t name_len)
 {
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index e5c4e19020ee..98de9c35e178 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -860,7 +860,6 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ath11k,
 void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
 
 void ath11k_core_halt(struct ath11k *ar);
-u8 ath11k_core_get_hw_mac_id(struct ath11k_base *ab, int pdev_idx);
 
 static inline const char *ath11k_scan_state_str(enum ath11k_scan_state state)
 {
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
new file mode 100644
index 000000000000..7cc5f36509c0
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
+ */
+
+#include "core.h"
+
+/* Map from pdev index to hw mac index */
+static u8 ath11k_hw_ipq8074_mac_from_pdev_id(int pdev_idx)
+{
+	switch (pdev_idx) {
+	case 0:
+		return 0;
+	case 1:
+		return 2;
+	case 2:
+		return 1;
+	default:
+		return ATH11K_INVALID_HW_MAC_ID;
+	}
+}
+
+static u8 ath11k_hw_ipq6018_mac_from_pdev_id(int pdev_idx)
+{
+	return pdev_idx;
+}
+
+const struct ath11k_hw_ops ipq8074_ops = {
+	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
+};
+
+const struct ath11k_hw_ops ipq6018_ops = {
+	.get_hw_mac_from_pdev_id = ath11k_hw_ipq6018_mac_from_pdev_id,
+};
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index ba897d186cf5..2fb986b9a6cb 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -104,6 +104,10 @@ enum ath11k_bus {
 	ATH11K_BUS_PCI,
 };
 
+struct ath11k_hw_ops {
+	u8 (*get_hw_mac_from_pdev_id)(int pdev_id);
+};
+
 struct ath11k_hw_params {
 	const char *name;
 	u16 hw_rev;
@@ -113,8 +117,23 @@ struct ath11k_hw_params {
 		size_t board_size;
 		size_t cal_size;
 	} fw;
+
+	const struct ath11k_hw_ops *hw_ops;
 };
 
+extern const struct ath11k_hw_ops ipq8074_ops;
+extern const struct ath11k_hw_ops ipq6018_ops;
+
+static inline
+int ath11k_hw_get_mac_from_pdev_id(struct ath11k_hw_params *hw,
+				   int pdev_idx)
+{
+	if (hw->hw_ops->get_hw_mac_from_pdev_id)
+		return hw->hw_ops->get_hw_mac_from_pdev_id(pdev_idx);
+
+	return 0;
+}
+
 struct ath11k_fw_ie {
 	__le32 id;
 	__le32 len;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 07d3e031c75a..cdedb2ea7d87 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6194,7 +6194,7 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		ar->ab = ab;
 		ar->pdev = pdev;
 		ar->pdev_idx = i;
-		ar->lmac_id = ath11k_core_get_hw_mac_id(ab, i);
+		ar->lmac_id = ath11k_hw_get_mac_from_pdev_id(&ab->hw_params, i);
 
 		ar->wmi = &ab->wmi_ab.wmi[i];
 		/* FIXME wmi[0] is already initialized during attach,
-- 
2.7.4

