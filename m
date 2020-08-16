Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55693245759
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 13:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgHPLbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 07:31:07 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53061 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729031AbgHPL3K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 07:29:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597577348; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=bWqau90w54ei2z8m9WbN9HEPqFXaWG+wyH7c2+6W1mA=; b=UwPu6s32gsNV5KzfilPKJkyhntiWZaM2NMyH/V436D03uU6ZB55l3zammWbJmPCRyZJMjSLP
 Fc7MRp5bTtv1o6Pz1B+Dh+te+aT61xk7tmCNY5LDjgjYU1HsTQim4BInJXLCln6BLYgweJ1i
 cJmkEpDk3ts5/6x5GQR+P6ZhX6s=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f3915a14c787f237b97a5dc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 11:16:49
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F2771C43391; Sun, 16 Aug 2020 11:16:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07E75C433CA;
        Sun, 16 Aug 2020 11:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07E75C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 03/12] ath11k: ce: support different CE configurations
Date:   Sun, 16 Aug 2020 14:16:30 +0300
Message-Id: <1597576599-8857-4-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
References: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

QCA6390 uses only 9 Copy Engines while IPQ8074 may use 12, make it possible to
change CE configuration dynamically via hw_params.

The defines for host_ce_config_wlan and CE_COUNT are temporary solutions, they
will be removed in the following patches to keep things simple.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 12 ++---
 drivers/net/wireless/ath/ath11k/ce.c   | 84 +++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/ce.h   | 11 +++--
 drivers/net/wireless/ath/ath11k/core.c |  4 ++
 drivers/net/wireless/ath/ath11k/hal.c  |  2 +-
 drivers/net/wireless/ath/ath11k/hw.c   |  1 +
 drivers/net/wireless/ath/ath11k/hw.h   |  2 +
 drivers/net/wireless/ath/ath11k/pci.c  | 12 ++---
 8 files changed, 110 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 2e0d90c022bb..4bc3558fc300 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -387,7 +387,7 @@ static void ath11k_ahb_kill_tasklets(struct ath11k_base *ab)
 	for (i = 0; i < CE_COUNT; i++) {
 		struct ath11k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
 
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 
 		tasklet_kill(&ce_pipe->intr_tq);
@@ -476,7 +476,7 @@ static void ath11k_ahb_sync_ce_irqs(struct ath11k_base *ab)
 	int irq_idx;
 
 	for (i = 0; i < CE_COUNT; i++) {
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 
 		irq_idx = ATH11K_IRQ_CE0_OFFSET + i;
@@ -504,7 +504,7 @@ static void ath11k_ahb_ce_irqs_enable(struct ath11k_base *ab)
 	int i;
 
 	for (i = 0; i < CE_COUNT; i++) {
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 		ath11k_ahb_ce_irq_enable(ab, i);
 	}
@@ -515,7 +515,7 @@ static void ath11k_ahb_ce_irqs_disable(struct ath11k_base *ab)
 	int i;
 
 	for (i = 0; i < CE_COUNT; i++) {
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 		ath11k_ahb_ce_irq_disable(ab, i);
 	}
@@ -602,7 +602,7 @@ static void ath11k_ahb_free_irq(struct ath11k_base *ab)
 	int i;
 
 	for (i = 0; i < CE_COUNT; i++) {
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 		irq_idx = ATH11K_IRQ_CE0_OFFSET + i;
 		free_irq(ab->irq_num[irq_idx], &ab->ce.ce_pipe[i]);
@@ -759,7 +759,7 @@ static int ath11k_ahb_config_irq(struct ath11k_base *ab)
 	for (i = 0; i < CE_COUNT; i++) {
 		struct ath11k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
 
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 
 		irq_idx = ATH11K_IRQ_CE0_OFFSET + i;
diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index 59cb403b8597..a588e5d0e5e0 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -7,7 +7,9 @@
 #include "debug.h"
 #include "hif.h"
 
-static const struct ce_attr host_ce_config_wlan[] = {
+#define host_ce_config_wlan ab->hw_params.host_ce_config
+
+const struct ce_attr ath11k_host_ce_config_ipq8074[] = {
 	/* CE0: host->target HTC control and raw streams */
 	{
 		.flags = CE_ATTR_FLAGS,
@@ -109,6 +111,84 @@ static const struct ce_attr host_ce_config_wlan[] = {
 	},
 };
 
+const struct ce_attr ath11k_host_ce_config_qca6390[] = {
+	/* CE0: host->target HTC control and raw streams */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 16,
+		.src_sz_max = 2048,
+		.dest_nentries = 0,
+	},
+
+	/* CE1: target->host HTT + HTC control */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 0,
+		.src_sz_max = 2048,
+		.dest_nentries = 512,
+		.recv_cb = ath11k_htc_rx_completion_handler,
+	},
+
+	/* CE2: target->host WMI */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 0,
+		.src_sz_max = 2048,
+		.dest_nentries = 512,
+		.recv_cb = ath11k_htc_rx_completion_handler,
+	},
+
+	/* CE3: host->target WMI (mac0) */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 32,
+		.src_sz_max = 2048,
+		.dest_nentries = 0,
+	},
+
+	/* CE4: host->target HTT */
+	{
+		.flags = CE_ATTR_FLAGS | CE_ATTR_DIS_INTR,
+		.src_nentries = 2048,
+		.src_sz_max = 256,
+		.dest_nentries = 0,
+	},
+
+	/* CE5: target->host pktlog */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 0,
+		.src_sz_max = 2048,
+		.dest_nentries = 512,
+		.recv_cb = ath11k_dp_htt_htc_t2h_msg_handler,
+	},
+
+	/* CE6: target autonomous hif_memcpy */
+	{
+		.flags = CE_ATTR_FLAGS | CE_ATTR_DIS_INTR,
+		.src_nentries = 0,
+		.src_sz_max = 0,
+		.dest_nentries = 0,
+	},
+
+	/* CE7: host->target WMI (mac1) */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 32,
+		.src_sz_max = 2048,
+		.dest_nentries = 0,
+	},
+
+	/* CE8: target autonomous hif_memcpy */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 0,
+		.src_sz_max = 0,
+		.dest_nentries = 0,
+	},
+
+};
+
 static int ath11k_ce_rx_buf_enqueue_pipe(struct ath11k_ce_pipe *pipe,
 					 struct sk_buff *skb, dma_addr_t paddr)
 {
@@ -834,7 +914,7 @@ void ath11k_ce_byte_swap(void *mem, u32 len)
 	}
 }
 
-int ath11k_ce_get_attr_flags(int ce_id)
+int ath11k_ce_get_attr_flags(struct ath11k_base *ab, int ce_id)
 {
 	if (ce_id >= CE_COUNT)
 		return -EINVAL;
diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index 6e3a37909ade..8feb6e98ea13 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -6,7 +6,8 @@
 #ifndef ATH11K_CE_H
 #define ATH11K_CE_H
 
-#define CE_COUNT 12
+#define CE_COUNT (ab->hw_params.ce_count)
+#define CE_COUNT_MAX 12
 
 /* Byte swap data words */
 #define CE_ATTR_BYTE_SWAP_DATA 2
@@ -165,11 +166,14 @@ struct ath11k_ce_pipe {
 };
 
 struct ath11k_ce {
-	struct ath11k_ce_pipe ce_pipe[CE_COUNT];
+	struct ath11k_ce_pipe ce_pipe[CE_COUNT_MAX];
 	/* Protects rings of all ce pipes */
 	spinlock_t ce_lock;
 };
 
+extern const struct ce_attr ath11k_host_ce_config_ipq8074[];
+extern const struct ce_attr ath11k_host_ce_config_qca6390[];
+
 void ath11k_ce_cleanup_pipes(struct ath11k_base *ab);
 void ath11k_ce_rx_replenish_retry(struct timer_list *t);
 void ath11k_ce_per_engine_service(struct ath11k_base *ab, u16 ce_id);
@@ -179,8 +183,9 @@ void ath11k_ce_rx_post_buf(struct ath11k_base *ab);
 int ath11k_ce_init_pipes(struct ath11k_base *ab);
 int ath11k_ce_alloc_pipes(struct ath11k_base *ab);
 void ath11k_ce_free_pipes(struct ath11k_base *ab);
-int ath11k_ce_get_attr_flags(int ce_id);
+int ath11k_ce_get_attr_flags(struct ath11k_base *ab, int ce_id);
 void ath11k_ce_poll_send_completed(struct ath11k_base *ab, u8 pipe_id);
 int ath11k_ce_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 				  u8 *ul_pipe, u8 *dl_pipe);
+int ath11k_ce_attr_attach(struct ath11k_base *ab);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 613a8a6721ba..c55c886f6276 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -33,6 +33,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ring_mask = &ath11k_hw_ring_mask_ipq8074,
 		.internal_sleep_clock = false,
 		.regs = &ipq8074_regs,
+		.host_ce_config = ath11k_host_ce_config_ipq8074,
+		.ce_count = 12,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -48,6 +50,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ring_mask = &ath11k_hw_ring_mask_ipq8074,
 		.internal_sleep_clock = true,
 		.regs = &qca6390_regs,
+		.host_ce_config = ath11k_host_ce_config_qca6390,
+		.ce_count = 9,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index ae4dc6c39e64..cca019cc0234 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1160,7 +1160,7 @@ void ath11k_hal_dump_srng_stats(struct ath11k_base *ab)
 	for (i = 0; i < CE_COUNT; i++) {
 		ce_pipe = &ab->ce.ce_pipe[i];
 
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 
 		ath11k_err(ab, "CE_id %d pipe_num %d %ums before\n",
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 51ddd418bc3b..5811eabf2275 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -9,6 +9,7 @@
 
 #include "hw.h"
 #include "core.h"
+#include "ce.h"
 
 /* Map from pdev index to hw mac index */
 static u8 ath11k_hw_ipq8074_mac_from_pdev_id(int pdev_idx)
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index eb1d8a2beffd..ef553bafa158 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -137,6 +137,8 @@ struct ath11k_hw_params {
 	bool internal_sleep_clock;
 
 	const struct ath11k_hw_regs *regs;
+	const struct ce_attr *host_ce_config;
+	u32 ce_count;
 };
 
 extern const struct ath11k_hw_ops ipq8074_ops;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index d5dcbb928baf..e4551fb493ff 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -394,7 +394,7 @@ static void ath11k_pci_free_irq(struct ath11k_base *ab)
 	int i, irq_idx;
 
 	for (i = 0; i < CE_COUNT; i++) {
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
 		free_irq(ab->irq_num[irq_idx], &ab->ce.ce_pipe[i]);
@@ -422,7 +422,7 @@ static void ath11k_pci_ce_irqs_disable(struct ath11k_base *ab)
 	int i;
 
 	for (i = 0; i < CE_COUNT; i++) {
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 		ath11k_pci_ce_irq_disable(ab, i);
 	}
@@ -434,7 +434,7 @@ static void ath11k_pci_sync_ce_irqs(struct ath11k_base *ab)
 	int irq_idx;
 
 	for (i = 0; i < CE_COUNT; i++) {
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 
 		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
@@ -482,7 +482,7 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 		irq = ath11k_pci_get_msi_irq(ab->dev, msi_data);
 		ce_pipe = &ab->ce.ce_pipe[i];
 
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 
 		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
@@ -522,7 +522,7 @@ static void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
 	int i;
 
 	for (i = 0; i < CE_COUNT; i++) {
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 		ath11k_pci_ce_irq_enable(ab, i);
 	}
@@ -683,7 +683,7 @@ static void ath11k_pci_kill_tasklets(struct ath11k_base *ab)
 	for (i = 0; i < CE_COUNT; i++) {
 		struct ath11k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
 
-		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 
 		tasklet_kill(&ce_pipe->intr_tq);
-- 
2.7.4

