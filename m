Return-Path: <linux-wireless+bounces-22568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66405AAAA7A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09AD9880F6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E066938C402;
	Mon,  5 May 2025 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPPncBP6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340E136AD18;
	Mon,  5 May 2025 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485774; cv=none; b=jY1OYYh5EW7A4FnLUUK6x8YHrTPJ8VPTQ8MSZzyB2ono/I9ElGOWCJ9w3GzvPg39DoN5JlCG+/DMM1sYatVDUh3zKn8oj4AbN/cuQpPsNjdhgCyoXgPITd4zAEwhp0yBSDuVZSizGniQwItkv8rB5FMfZi5+qtBjRXb/q6bHbk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485774; c=relaxed/simple;
	bh=04fT3HF5zV7+v+IOXiYHLUDgH0S8C7MsvuRieKy+yGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qtow2LcXNi7JPkFLkjSRnWi4T5OCXtllu3L1x+HSMPO5/iRfHs3wlbyMMBWfo+9Of5mXNw7gOjLGZ/kUXF2+IgyVw+zH2Pz8IxjnzKCbvy1yCNUGcDBwREq9sN/DkPR4pJWGcVjB2Kg7So7nnQyzm53fZBWZRau1M2xYcRG+cVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPPncBP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B54C4CEE4;
	Mon,  5 May 2025 22:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485773;
	bh=04fT3HF5zV7+v+IOXiYHLUDgH0S8C7MsvuRieKy+yGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kPPncBP66SLSDLMzxw8HcepL0B8eY7UVdkrwfqvzwkAmhvnB+dqGa0SGGrYbRJIiB
	 YPGqdsgU0Hc7xQcnOyjYal2Ovl8ocEqqQjh84yEtn22yoeGWBbC8NKqyxcTPaVyGWZ
	 j2vgBVR/fLOUOEn4LwAWk8cldv4sa1xmxNxgMal/Gw5o5pr8b1BfGZelfDNWu0T7YC
	 mq2rysYbLmk0+MrNDOvTbjs3Qx3JEmzO55QJz3rW0e8zz9NcPoMdonbDT/hhIsYcDz
	 8x8ueA/eN/QQNCJHKsRQxdX6CEcUHaj6z5sNAjOptQGq5m5+qeVKpzzYR1nGZ13pY5
	 3w6aLoVAa8YKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: P Praneesh <quic_ppranees@quicinc.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 476/486] wifi: ath11k: Use dma_alloc_noncoherent for rx_tid buffer allocation
Date: Mon,  5 May 2025 18:39:12 -0400
Message-Id: <20250505223922.2682012-476-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: P Praneesh <quic_ppranees@quicinc.com>

[ Upstream commit eeadc6baf8b3dcd32787cc84f0473dc2a2850370 ]

Currently, the driver allocates cacheable DMA buffers for the rx_tid
structure using kzalloc() and dma_map_single(). These buffers are
long-lived and can persist for the lifetime of the peer, which is not
advisable. Instead of using kzalloc() and dma_map_single() for allocating
cacheable DMA buffers, utilize the dma_alloc_noncoherent() helper for the
allocation of long-lived cacheable DMA buffers, such as the peer's rx_tid.
Since dma_alloc_noncoherent() returns unaligned physical and virtual
addresses, align them internally before use within the driver. This
ensures proper allocation of non-coherent memory through the kernel
helper.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>
Link: https://patch.msgid.link/20250119164219.647059-3-quic_ppranees@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dp.h    |   6 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 117 +++++++++++-------------
 2 files changed, 58 insertions(+), 65 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 65d2bc0687c88..eaf902c25e192 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023, 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_DP_H
@@ -20,7 +20,6 @@ struct ath11k_ext_irq_grp;
 
 struct dp_rx_tid {
 	u8 tid;
-	u32 *vaddr;
 	dma_addr_t paddr;
 	u32 size;
 	u32 ba_win_sz;
@@ -37,6 +36,9 @@ struct dp_rx_tid {
 	/* Timer info related to fragments */
 	struct timer_list frag_timer;
 	struct ath11k_base *ab;
+	u32 *vaddr_unaligned;
+	dma_addr_t paddr_unaligned;
+	u32 unaligned_size;
 };
 
 #define DP_REO_DESC_FREE_THRESHOLD  64
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 40b52d12b4323..bfb8e7b1a300c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/ieee80211.h>
@@ -675,11 +675,11 @@ void ath11k_dp_reo_cmd_list_cleanup(struct ath11k_base *ab)
 	list_for_each_entry_safe(cmd, tmp, &dp->reo_cmd_list, list) {
 		list_del(&cmd->list);
 		rx_tid = &cmd->data;
-		if (rx_tid->vaddr) {
-			dma_unmap_single(ab->dev, rx_tid->paddr,
-					 rx_tid->size, DMA_BIDIRECTIONAL);
-			kfree(rx_tid->vaddr);
-			rx_tid->vaddr = NULL;
+		if (rx_tid->vaddr_unaligned) {
+			dma_free_noncoherent(ab->dev, rx_tid->unaligned_size,
+					     rx_tid->vaddr_unaligned,
+					     rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);
+			rx_tid->vaddr_unaligned = NULL;
 		}
 		kfree(cmd);
 	}
@@ -689,11 +689,11 @@ void ath11k_dp_reo_cmd_list_cleanup(struct ath11k_base *ab)
 		list_del(&cmd_cache->list);
 		dp->reo_cmd_cache_flush_count--;
 		rx_tid = &cmd_cache->data;
-		if (rx_tid->vaddr) {
-			dma_unmap_single(ab->dev, rx_tid->paddr,
-					 rx_tid->size, DMA_BIDIRECTIONAL);
-			kfree(rx_tid->vaddr);
-			rx_tid->vaddr = NULL;
+		if (rx_tid->vaddr_unaligned) {
+			dma_free_noncoherent(ab->dev, rx_tid->unaligned_size,
+					     rx_tid->vaddr_unaligned,
+					     rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);
+			rx_tid->vaddr_unaligned = NULL;
 		}
 		kfree(cmd_cache);
 	}
@@ -708,11 +708,11 @@ static void ath11k_dp_reo_cmd_free(struct ath11k_dp *dp, void *ctx,
 	if (status != HAL_REO_CMD_SUCCESS)
 		ath11k_warn(dp->ab, "failed to flush rx tid hw desc, tid %d status %d\n",
 			    rx_tid->tid, status);
-	if (rx_tid->vaddr) {
-		dma_unmap_single(dp->ab->dev, rx_tid->paddr, rx_tid->size,
-				 DMA_BIDIRECTIONAL);
-		kfree(rx_tid->vaddr);
-		rx_tid->vaddr = NULL;
+	if (rx_tid->vaddr_unaligned) {
+		dma_free_noncoherent(dp->ab->dev, rx_tid->unaligned_size,
+				     rx_tid->vaddr_unaligned,
+				     rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);
+		rx_tid->vaddr_unaligned = NULL;
 	}
 }
 
@@ -749,10 +749,10 @@ static void ath11k_dp_reo_cache_flush(struct ath11k_base *ab,
 	if (ret) {
 		ath11k_err(ab, "failed to send HAL_REO_CMD_FLUSH_CACHE cmd, tid %d (%d)\n",
 			   rx_tid->tid, ret);
-		dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
-				 DMA_BIDIRECTIONAL);
-		kfree(rx_tid->vaddr);
-		rx_tid->vaddr = NULL;
+		dma_free_noncoherent(ab->dev, rx_tid->unaligned_size,
+				     rx_tid->vaddr_unaligned,
+				     rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);
+		rx_tid->vaddr_unaligned = NULL;
 	}
 }
 
@@ -802,10 +802,10 @@ static void ath11k_dp_rx_tid_del_func(struct ath11k_dp *dp, void *ctx,
 
 	return;
 free_desc:
-	dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
-			 DMA_BIDIRECTIONAL);
-	kfree(rx_tid->vaddr);
-	rx_tid->vaddr = NULL;
+	dma_free_noncoherent(ab->dev, rx_tid->unaligned_size,
+			     rx_tid->vaddr_unaligned,
+			     rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);
+	rx_tid->vaddr_unaligned = NULL;
 }
 
 void ath11k_peer_rx_tid_delete(struct ath11k *ar,
@@ -831,14 +831,16 @@ void ath11k_peer_rx_tid_delete(struct ath11k *ar,
 		if (ret != -ESHUTDOWN)
 			ath11k_err(ar->ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid %d (%d)\n",
 				   tid, ret);
-		dma_unmap_single(ar->ab->dev, rx_tid->paddr, rx_tid->size,
-				 DMA_BIDIRECTIONAL);
-		kfree(rx_tid->vaddr);
-		rx_tid->vaddr = NULL;
+		dma_free_noncoherent(ar->ab->dev, rx_tid->unaligned_size,
+				     rx_tid->vaddr_unaligned,
+				     rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);
+		rx_tid->vaddr_unaligned = NULL;
 	}
 
 	rx_tid->paddr = 0;
+	rx_tid->paddr_unaligned = 0;
 	rx_tid->size = 0;
+	rx_tid->unaligned_size = 0;
 }
 
 static int ath11k_dp_rx_link_desc_return(struct ath11k_base *ab,
@@ -982,10 +984,9 @@ static void ath11k_dp_rx_tid_mem_free(struct ath11k_base *ab,
 	if (!rx_tid->active)
 		goto unlock_exit;
 
-	dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
-			 DMA_BIDIRECTIONAL);
-	kfree(rx_tid->vaddr);
-	rx_tid->vaddr = NULL;
+	dma_free_noncoherent(ab->dev, rx_tid->unaligned_size, rx_tid->vaddr_unaligned,
+			     rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);
+	rx_tid->vaddr_unaligned = NULL;
 
 	rx_tid->active = false;
 
@@ -1000,9 +1001,8 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_peer *peer;
 	struct dp_rx_tid *rx_tid;
-	u32 hw_desc_sz;
-	u32 *addr_aligned;
-	void *vaddr;
+	u32 hw_desc_sz, *vaddr;
+	void *vaddr_unaligned;
 	dma_addr_t paddr;
 	int ret;
 
@@ -1050,49 +1050,40 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 	else
 		hw_desc_sz = ath11k_hal_reo_qdesc_size(DP_BA_WIN_SZ_MAX, tid);
 
-	vaddr = kzalloc(hw_desc_sz + HAL_LINK_DESC_ALIGN - 1, GFP_ATOMIC);
-	if (!vaddr) {
+	rx_tid->unaligned_size = hw_desc_sz + HAL_LINK_DESC_ALIGN - 1;
+	vaddr_unaligned = dma_alloc_noncoherent(ab->dev, rx_tid->unaligned_size, &paddr,
+						DMA_BIDIRECTIONAL, GFP_ATOMIC);
+	if (!vaddr_unaligned) {
 		spin_unlock_bh(&ab->base_lock);
 		return -ENOMEM;
 	}
 
-	addr_aligned = PTR_ALIGN(vaddr, HAL_LINK_DESC_ALIGN);
-
-	ath11k_hal_reo_qdesc_setup(addr_aligned, tid, ba_win_sz,
-				   ssn, pn_type);
-
-	paddr = dma_map_single(ab->dev, addr_aligned, hw_desc_sz,
-			       DMA_BIDIRECTIONAL);
-
-	ret = dma_mapping_error(ab->dev, paddr);
-	if (ret) {
-		spin_unlock_bh(&ab->base_lock);
-		ath11k_warn(ab, "failed to setup dma map for peer %pM rx tid %d: %d\n",
-			    peer_mac, tid, ret);
-		goto err_mem_free;
-	}
-
-	rx_tid->vaddr = vaddr;
-	rx_tid->paddr = paddr;
+	rx_tid->vaddr_unaligned = vaddr_unaligned;
+	vaddr = PTR_ALIGN(vaddr_unaligned, HAL_LINK_DESC_ALIGN);
+	rx_tid->paddr_unaligned = paddr;
+	rx_tid->paddr = rx_tid->paddr_unaligned + ((unsigned long)vaddr -
+			(unsigned long)rx_tid->vaddr_unaligned);
+	ath11k_hal_reo_qdesc_setup(vaddr, tid, ba_win_sz, ssn, pn_type);
 	rx_tid->size = hw_desc_sz;
 	rx_tid->active = true;
 
+	/* After dma_alloc_noncoherent, vaddr is being modified for reo qdesc setup.
+	 * Since these changes are not reflected in the device, driver now needs to
+	 * explicitly call dma_sync_single_for_device.
+	 */
+	dma_sync_single_for_device(ab->dev, rx_tid->paddr,
+				   rx_tid->size,
+				   DMA_TO_DEVICE);
 	spin_unlock_bh(&ab->base_lock);
 
-	ret = ath11k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id, peer_mac,
-						     paddr, tid, 1, ba_win_sz);
+	ret = ath11k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id, peer_mac, rx_tid->paddr,
+						     tid, 1, ba_win_sz);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to setup rx reorder queue for peer %pM tid %d: %d\n",
 			    peer_mac, tid, ret);
 		ath11k_dp_rx_tid_mem_free(ab, peer_mac, vdev_id, tid);
 	}
 
-	return ret;
-
-err_mem_free:
-	kfree(rx_tid->vaddr);
-	rx_tid->vaddr = NULL;
-
 	return ret;
 }
 
-- 
2.39.5


