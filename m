Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349B81CE1A0
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 19:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgEKRXs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 13:23:48 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:27330 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729731AbgEKRXs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 13:23:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589217827; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=WxGAWYe9sQovES2LJ6hQsj6et8DpZIjgrDyV160b1/0=; b=XZLd/2skMGEPC/yZa93pEYJypnoaa0+zJgtgpqZK3V4k+SJczBn56J5dfefza3idEsNgK+E/
 nrxWNfnlPwnrpPLoDAKI/u/7OM9xcwSXMFUJ2bXUhghCtdJfqSMJ/BuEqGcQXMmev+V/v+kT
 UFxtz5A2DZFiuSJoRQJPeQ4Nbpg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb98a16.7f0f316369d0-smtp-out-n01;
 Mon, 11 May 2020 17:23:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4B726C433CB; Mon, 11 May 2020 17:23:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29103C433BA;
        Mon, 11 May 2020 17:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29103C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: move ring mask variables to core.c
Date:   Mon, 11 May 2020 20:23:26 +0300
Message-Id: <1589217806-9376-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It should have been in core.c in the first place as the declarations are in
core.h. And these are needed by both pci.c and ahb.c so there needs to be a
common place for them.

Also add ath11k_ prefix to rx_mon_status_ring_mask to make it easy add
EXPORT_SYMBOL() later.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 74 +---------------------------------
 drivers/net/wireless/ath/ath11k/core.c | 45 +++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h | 29 ++++++++++++-
 drivers/net/wireless/ath/ath11k/dp.c   |  4 +-
 4 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 30092841ac46..f14483e2a76d 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -321,78 +321,6 @@ static const char *irq_name[ATH11K_IRQ_NUM_MAX] = {
 	"tcl2host-status-ring",
 };
 
-#define ATH11K_TX_RING_MASK_0 0x1
-#define ATH11K_TX_RING_MASK_1 0x2
-#define ATH11K_TX_RING_MASK_2 0x4
-
-#define ATH11K_RX_RING_MASK_0 0x1
-#define ATH11K_RX_RING_MASK_1 0x2
-#define ATH11K_RX_RING_MASK_2 0x4
-#define ATH11K_RX_RING_MASK_3 0x8
-
-#define ATH11K_RX_ERR_RING_MASK_0 0x1
-
-#define ATH11K_RX_WBM_REL_RING_MASK_0 0x1
-
-#define ATH11K_REO_STATUS_RING_MASK_0 0x1
-
-#define ATH11K_RXDMA2HOST_RING_MASK_0 0x1
-#define ATH11K_RXDMA2HOST_RING_MASK_1 0x2
-#define ATH11K_RXDMA2HOST_RING_MASK_2 0x4
-
-#define ATH11K_HOST2RXDMA_RING_MASK_0 0x1
-#define ATH11K_HOST2RXDMA_RING_MASK_1 0x2
-#define ATH11K_HOST2RXDMA_RING_MASK_2 0x4
-
-#define ATH11K_RX_MON_STATUS_RING_MASK_0 0x1
-#define ATH11K_RX_MON_STATUS_RING_MASK_1 0x2
-#define ATH11K_RX_MON_STATUS_RING_MASK_2 0x4
-
-const u8 ath11k_tx_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
-	ATH11K_TX_RING_MASK_0,
-	ATH11K_TX_RING_MASK_1,
-	ATH11K_TX_RING_MASK_2,
-};
-
-const u8 rx_mon_status_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
-	0, 0, 0, 0,
-	ATH11K_RX_MON_STATUS_RING_MASK_0,
-	ATH11K_RX_MON_STATUS_RING_MASK_1,
-	ATH11K_RX_MON_STATUS_RING_MASK_2,
-};
-
-const u8 ath11k_rx_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
-	0, 0, 0, 0, 0, 0, 0,
-	ATH11K_RX_RING_MASK_0,
-	ATH11K_RX_RING_MASK_1,
-	ATH11K_RX_RING_MASK_2,
-	ATH11K_RX_RING_MASK_3,
-};
-
-const u8 ath11k_rx_err_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
-	ATH11K_RX_ERR_RING_MASK_0,
-};
-
-const u8 ath11k_rx_wbm_rel_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
-	ATH11K_RX_WBM_REL_RING_MASK_0,
-};
-
-const u8 ath11k_reo_status_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
-	ATH11K_REO_STATUS_RING_MASK_0,
-};
-
-const u8 ath11k_rxdma2host_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
-	ATH11K_RXDMA2HOST_RING_MASK_0,
-	ATH11K_RXDMA2HOST_RING_MASK_1,
-	ATH11K_RXDMA2HOST_RING_MASK_2,
-};
-
-const u8 ath11k_host2rxdma_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
-	ATH11K_HOST2RXDMA_RING_MASK_0,
-	ATH11K_HOST2RXDMA_RING_MASK_1,
-	ATH11K_HOST2RXDMA_RING_MASK_2,
-};
-
 /* enum ext_irq_num - irq numbers that can be used by external modules
  * like datapath
  */
@@ -781,7 +709,7 @@ static int ath11k_ahb_ext_irq_config(struct ath11k_base *ab)
 						- ath11k_core_get_hw_mac_id(ab, j);
 				}
 
-				if (rx_mon_status_ring_mask[i] & BIT(j)) {
+				if (ath11k_rx_mon_status_ring_mask[i] & BIT(j)) {
 					irq_grp->irqs[num_irq++] =
 						ppdu_end_interrupts_mac1 -
 						ath11k_core_get_hw_mac_id(ab, j);
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 02501cc154fe..d6e0f172c36f 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -26,6 +26,51 @@ static const struct ath11k_hw_params ath11k_hw_params = {
 	},
 };
 
+const u8 ath11k_tx_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
+	ATH11K_TX_RING_MASK_0,
+	ATH11K_TX_RING_MASK_1,
+	ATH11K_TX_RING_MASK_2,
+};
+
+const u8 ath11k_rx_mon_status_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
+	0, 0, 0, 0,
+	ATH11K_RX_MON_STATUS_RING_MASK_0,
+	ATH11K_RX_MON_STATUS_RING_MASK_1,
+	ATH11K_RX_MON_STATUS_RING_MASK_2,
+};
+
+const u8 ath11k_rx_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
+	0, 0, 0, 0, 0, 0, 0,
+	ATH11K_RX_RING_MASK_0,
+	ATH11K_RX_RING_MASK_1,
+	ATH11K_RX_RING_MASK_2,
+	ATH11K_RX_RING_MASK_3,
+};
+
+const u8 ath11k_rx_err_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
+	ATH11K_RX_ERR_RING_MASK_0,
+};
+
+const u8 ath11k_rx_wbm_rel_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
+	ATH11K_RX_WBM_REL_RING_MASK_0,
+};
+
+const u8 ath11k_reo_status_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
+	ATH11K_REO_STATUS_RING_MASK_0,
+};
+
+const u8 ath11k_rxdma2host_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
+	ATH11K_RXDMA2HOST_RING_MASK_0,
+	ATH11K_RXDMA2HOST_RING_MASK_1,
+	ATH11K_RXDMA2HOST_RING_MASK_2,
+};
+
+const u8 ath11k_host2rxdma_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX] = {
+	ATH11K_HOST2RXDMA_RING_MASK_0,
+	ATH11K_HOST2RXDMA_RING_MASK_1,
+	ATH11K_HOST2RXDMA_RING_MASK_2,
+};
+
 /* Map from pdev index to hw mac index */
 u8 ath11k_core_get_hw_mac_id(struct ath11k_base *ab, int pdev_idx)
 {
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index e04f0e711779..161e3ae92b73 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -102,6 +102,33 @@ enum ath11k_firmware_mode {
 #define ATH11K_EXT_IRQ_GRP_NUM_MAX 11
 #define ATH11K_EXT_IRQ_NUM_MAX	16
 
+#define ATH11K_TX_RING_MASK_0 0x1
+#define ATH11K_TX_RING_MASK_1 0x2
+#define ATH11K_TX_RING_MASK_2 0x4
+
+#define ATH11K_RX_RING_MASK_0 0x1
+#define ATH11K_RX_RING_MASK_1 0x2
+#define ATH11K_RX_RING_MASK_2 0x4
+#define ATH11K_RX_RING_MASK_3 0x8
+
+#define ATH11K_RX_ERR_RING_MASK_0 0x1
+
+#define ATH11K_RX_WBM_REL_RING_MASK_0 0x1
+
+#define ATH11K_REO_STATUS_RING_MASK_0 0x1
+
+#define ATH11K_RXDMA2HOST_RING_MASK_0 0x1
+#define ATH11K_RXDMA2HOST_RING_MASK_1 0x2
+#define ATH11K_RXDMA2HOST_RING_MASK_2 0x4
+
+#define ATH11K_HOST2RXDMA_RING_MASK_0 0x1
+#define ATH11K_HOST2RXDMA_RING_MASK_1 0x2
+#define ATH11K_HOST2RXDMA_RING_MASK_2 0x4
+
+#define ATH11K_RX_MON_STATUS_RING_MASK_0 0x1
+#define ATH11K_RX_MON_STATUS_RING_MASK_1 0x2
+#define ATH11K_RX_MON_STATUS_RING_MASK_2 0x4
+
 extern const u8 ath11k_reo_status_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX];
 extern const u8 ath11k_tx_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX];
 extern const u8 ath11k_rx_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX];
@@ -109,7 +136,7 @@ extern const u8 ath11k_rx_err_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX];
 extern const u8 ath11k_rx_wbm_rel_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX];
 extern const u8 ath11k_rxdma2host_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX];
 extern const u8 ath11k_host2rxdma_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX];
-extern const u8 rx_mon_status_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX];
+extern const u8 ath11k_rx_mon_status_ring_mask[ATH11K_EXT_IRQ_GRP_NUM_MAX];
 
 struct ath11k_ext_irq_grp {
 	struct ath11k_base *ab;
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 9ae743e528af..75c177480ff4 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -659,9 +659,9 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 			goto done;
 	}
 
-	if (rx_mon_status_ring_mask[grp_id]) {
+	if (ath11k_rx_mon_status_ring_mask[grp_id]) {
 		for (i = 0; i <  ab->num_radios; i++) {
-			if (rx_mon_status_ring_mask[grp_id] & BIT(i)) {
+			if (ath11k_rx_mon_status_ring_mask[grp_id] & BIT(i)) {
 				work_done =
 				ath11k_dp_rx_process_mon_rings(ab,
 							       i, napi,
-- 
2.7.4
