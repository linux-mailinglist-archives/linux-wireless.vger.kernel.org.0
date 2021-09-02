Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7D13FE8BD
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Sep 2021 07:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhIBFf5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Sep 2021 01:35:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36254 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231522AbhIBFfw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Sep 2021 01:35:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630560895; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=2S0bTeAXmnDiO/K5oS5s0t6PTSBZNHu7Oq5kBfZ63Ok=; b=fyFgRGrMaO9Rs2qIUcIWALSC2tQ/zuZi4aUMritKi0Q8sQFlK+1fZuVIIJBXPXm0AVWnkM+F
 QXnYqniEfcvgIKbcAIMtbAWugdAeLQEVUiH39p7xUPCJjER1kG/hUywBHA5BdU5PX3gGv/tp
 rhdMkfeR/SeU8Df+hCRn+EEjGRQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61306276c603a0154fc2daf1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Sep 2021 05:34:45
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3E9D6C4360D; Thu,  2 Sep 2021 05:34:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C638AC4338F;
        Thu,  2 Sep 2021 05:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C638AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH v3 02/12] ath11k: allocate dst ring descriptors from cacheable memory
Date:   Thu,  2 Sep 2021 11:03:30 +0530
Message-Id: <1630560820-21905-3-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org>
References: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tcl_data and reo_dst rings are currently being allocated using
dma_allocate_coherent() which is non cacheable.

Allocating ring memory from cacheable memory area allows cached descriptor
access and prefetch next descriptors to optimize CPU usage during
descriptor processing on NAPI. Based on the hardware param we can enable
or disable this feature for the corresponding platform.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Co-developed-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Co-developed-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |  5 +++++
 drivers/net/wireless/ath/ath11k/dp.c   | 38 +++++++++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/dp.h   |  1 +
 drivers/net/wireless/ath/ath11k/hal.c  | 28 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/hal.h  |  1 +
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 6 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 969bf1a..298c4dc 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -71,6 +71,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
+		.alloc_cacheable_memory = true,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -112,6 +113,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
+		.alloc_cacheable_memory = true,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -152,6 +154,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
+		.alloc_cacheable_memory = false,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -190,6 +193,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
 		.fix_l1ss = true,
+		.alloc_cacheable_memory = true,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -230,6 +234,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
 		.fix_l1ss = false,
+		.alloc_cacheable_memory = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index b0c8f62..943d0a7 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -101,8 +101,11 @@ void ath11k_dp_srng_cleanup(struct ath11k_base *ab, struct dp_srng *ring)
 	if (!ring->vaddr_unaligned)
 		return;
 
-	dma_free_coherent(ab->dev, ring->size, ring->vaddr_unaligned,
-			  ring->paddr_unaligned);
+	if (ring->cached)
+		kfree(ring->vaddr_unaligned);
+	else
+		dma_free_coherent(ab->dev, ring->size, ring->vaddr_unaligned,
+				  ring->paddr_unaligned);
 
 	ring->vaddr_unaligned = NULL;
 }
@@ -222,6 +225,7 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 	int entry_sz = ath11k_hal_srng_get_entrysize(ab, type);
 	int max_entries = ath11k_hal_srng_get_max_entries(ab, type);
 	int ret;
+	bool cached = false;
 
 	if (max_entries < 0 || entry_sz < 0)
 		return -EINVAL;
@@ -230,9 +234,28 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 		num_entries = max_entries;
 
 	ring->size = (num_entries * entry_sz) + HAL_RING_BASE_ALIGN - 1;
-	ring->vaddr_unaligned = dma_alloc_coherent(ab->dev, ring->size,
-						   &ring->paddr_unaligned,
-						   GFP_KERNEL);
+
+	if (ab->hw_params.alloc_cacheable_memory) {
+		/* Allocate the reo dst and tx completion rings from cacheable memory */
+		switch (type) {
+		case HAL_REO_DST:
+			cached = true;
+			break;
+		default:
+			cached = false;
+		}
+
+		if (cached) {
+			ring->vaddr_unaligned = kzalloc(ring->size, GFP_KERNEL);
+			ring->paddr_unaligned = virt_to_phys(ring->vaddr_unaligned);
+		}
+	}
+
+	if (!cached)
+		ring->vaddr_unaligned = dma_alloc_coherent(ab->dev, ring->size,
+							   &ring->paddr_unaligned,
+							   GFP_KERNEL);
+
 	if (!ring->vaddr_unaligned)
 		return -ENOMEM;
 
@@ -292,6 +315,11 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 		return -EINVAL;
 	}
 
+	if (cached) {
+		params.flags |= HAL_SRNG_FLAGS_CACHED;
+		ring->cached = 1;
+	}
+
 	ret = ath11k_hal_srng_setup(ab, type, ring_num, mac_id, &params);
 	if (ret < 0) {
 		ath11k_warn(ab, "failed to setup srng: %d ring_id %d\n",
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index ee768cc..e659148 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -64,6 +64,7 @@ struct dp_srng {
 	dma_addr_t paddr;
 	int size;
 	u32 ring_id;
+	u8 cached;
 };
 
 struct dp_rxdma_ring {
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index eaa0edc..f04edaf 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -627,6 +627,21 @@ u32 *ath11k_hal_srng_dst_peek(struct ath11k_base *ab, struct hal_srng *srng)
 	return NULL;
 }
 
+static void ath11k_hal_srng_prefetch_desc(struct ath11k_base *ab,
+					  struct hal_srng *srng)
+{
+	u32 *desc;
+
+	/* prefetch only if desc is available */
+	desc = ath11k_hal_srng_dst_peek(ab, srng);
+	if (likely(desc)) {
+		dma_sync_single_for_cpu(ab->dev, virt_to_phys(desc),
+					(srng->entry_size * sizeof(u32)),
+					DMA_FROM_DEVICE);
+		prefetch(desc);
+	}
+}
+
 u32 *ath11k_hal_srng_dst_get_next_entry(struct ath11k_base *ab,
 					struct hal_srng *srng)
 {
@@ -642,6 +657,10 @@ u32 *ath11k_hal_srng_dst_get_next_entry(struct ath11k_base *ab,
 	srng->u.dst_ring.tp = (srng->u.dst_ring.tp + srng->entry_size) %
 			      srng->ring_size;
 
+	/* Try to prefetch the next descriptor in the ring */
+	if (srng->flags & HAL_SRNG_FLAGS_CACHED)
+		ath11k_hal_srng_prefetch_desc(ab, srng);
+
 	return desc;
 }
 
@@ -775,11 +794,16 @@ void ath11k_hal_srng_access_begin(struct ath11k_base *ab, struct hal_srng *srng)
 {
 	lockdep_assert_held(&srng->lock);
 
-	if (srng->ring_dir == HAL_SRNG_DIR_SRC)
+	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		srng->u.src_ring.cached_tp =
 			*(volatile u32 *)srng->u.src_ring.tp_addr;
-	else
+	} else {
 		srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
+
+		/* Try to prefetch the next descriptor in the ring */
+		if (srng->flags & HAL_SRNG_FLAGS_CACHED)
+			ath11k_hal_srng_prefetch_desc(ab, srng);
+	}
 }
 
 /* Update cached ring head/tail pointers to HW. ath11k_hal_srng_access_begin()
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 35ed3a1..0f4f9ce 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -513,6 +513,7 @@ enum hal_srng_dir {
 #define HAL_SRNG_FLAGS_DATA_TLV_SWAP		0x00000020
 #define HAL_SRNG_FLAGS_LOW_THRESH_INTR_EN	0x00010000
 #define HAL_SRNG_FLAGS_MSI_INTR			0x00020000
+#define HAL_SRNG_FLAGS_CACHED                   0x20000000
 #define HAL_SRNG_FLAGS_LMAC_RING		0x80000000
 
 #define HAL_SRNG_TLV_HDR_TAG		GENMASK(9, 1)
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 62f5978..7fe8edb 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -163,6 +163,7 @@ struct ath11k_hw_params {
 	bool supports_suspend;
 	u32 hal_desc_sz;
 	bool fix_l1ss;
+	bool alloc_cacheable_memory;
 };
 
 struct ath11k_hw_ops {
-- 
2.7.4

