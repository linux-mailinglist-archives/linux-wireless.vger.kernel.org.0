Return-Path: <linux-wireless+bounces-16105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA49E9E7D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17BA1667D5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F3D197A6C;
	Mon,  9 Dec 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M62vUbQg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3DF197556
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770467; cv=none; b=THzfQ6TfD3Mg+ESxjJFVUghuS86UdDNbois6/1coUAkm3o9ww2/QxfgsEOQBnHPkBvKhi6i9MPu/jV58tojP0VxBhTquU6MjHWq2mJTTzFzDBdkQHpbV+Ll1jZTgttM87jpMWtijF6BrIPt0yWWSO3/7WdWW16b202sDmg4/Szw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770467; c=relaxed/simple;
	bh=u2J8AkrXzo18lafKVPi8O4cj/NL+/JTiqfpsU4yrLtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lP3+GPWwI8ayXO3VR/NsNrfJpSmsZVfWX6KS/k5H8bnb/vy6ykyLLDk4ChzWDraN30A5p5edy7DiNyq50+jYvLk1qzYV1r0hktZ8BbOjeEkfagNlPYtyPJaA4vhn0I2VLm1ELVEIIGS/53LBlAAtQyYp0qIg956zKDxBUXGBnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M62vUbQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0FCC2BCB5;
	Mon,  9 Dec 2024 18:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733770465;
	bh=u2J8AkrXzo18lafKVPi8O4cj/NL+/JTiqfpsU4yrLtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M62vUbQg96L3rLdWFHg7HMhZF7NyxX5lEKwwTndDrg5SCq7q9e6Ldo+9cK53fDksS
	 +g/ua11q3s4h5bTAoyx1Zrl+xnf2p7V6fLWnaaG0gGtS1pgoxQYFNg21s5sJMQIHTf
	 MiqJDzO27icmEOX4rAcu4jTXFKQdj4aejbDbCvj+ZUfnkYP4yZTy2BIfb5SH+gqe3B
	 oz0DehlHhzXWPBU/ZJOstcff+6iGOXfQI2xlkhFX4T9Qg9ZtUxOg6AnLIlNzN7YTfF
	 A864FRrTNjpf3Vl+SR0zjNrBE70lkC/MPDdEjsNcfa1NmI4pMgM1wenjEjBTtx0B16
	 xWPMAvqYEYWpQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 2/9] wifi: ath12k: add partner device buffer support in receive data path
Date: Mon,  9 Dec 2024 20:54:14 +0200
Message-Id: <20241209185421.376381-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209185421.376381-1-kvalo@kernel.org>
References: <20241209185421.376381-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, partner device buffer is not handled in the receive data path. In
Multi-Link Operation, the partner device buffer is reported to the primary
upper MAC rings. Therefore, add partner device buffer processing in the REO and
Exception ring handler.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h  |   6 +
 drivers/net/wireless/ath/ath12k/dp.c    |   1 +
 drivers/net/wireless/ath/ath12k/dp.h    |   3 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c | 179 +++++++++++++++++-------
 4 files changed, 140 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 9386e9592dff..d7caa58bb262 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1229,4 +1229,10 @@ static inline void ath12k_core_stopped(struct ath12k_base *ab)
 	ab->ag->num_started--;
 }
 
+static inline struct ath12k_base *ath12k_ag_to_ab(struct ath12k_hw_group *ag,
+						  u8 device_id)
+{
+	return ag->ab[device_id];
+}
+
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 68abe9d4ab45..9a7df54bf570 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1445,6 +1445,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 		for (j = 0; j < ATH12K_MAX_SPT_ENTRIES; j++) {
 			rx_descs[j].cookie = ath12k_dp_cc_cookie_gen(cookie_ppt_idx, j);
 			rx_descs[j].magic = ATH12K_DP_RX_DESC_MAGIC;
+			rx_descs[j].device_id = ab->device_id;
 			list_add_tail(&rx_descs[j].list, &dp->rx_desc_free_list);
 
 			/* Update descriptor VA in SPT */
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 021cd9e8ee1d..d3f3d39a1cd0 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -287,7 +287,8 @@ struct ath12k_rx_desc_info {
 	u32 cookie;
 	u32 magic;
 	u8 in_use	: 1,
-	   reserved	: 7;
+	   device_id	: 3,
+	   reserved	: 4;
 };
 
 struct ath12k_tx_desc_info {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index d658d4eb1fd7..adbd7bbcef6f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2601,6 +2601,7 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 	struct sk_buff *msdu;
 	struct ath12k *ar;
 	struct ath12k_hw_link *hw_links = ag->hw_links;
+	struct ath12k_base *partner_ab;
 	u8 hw_link_id, pdev_id;
 	int ret;
 
@@ -2612,11 +2613,12 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 	while ((msdu = __skb_dequeue(msdu_list))) {
 		rxcb = ATH12K_SKB_RXCB(msdu);
 		hw_link_id = rxcb->hw_link_id;
-
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params,
+		partner_ab = ath12k_ag_to_ab(ag,
+					     hw_links[hw_link_id].device_id);
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
 						      hw_links[hw_link_id].pdev_idx);
-		ar = ab->pdevs[pdev_id].ar;
-		if (!rcu_dereference(ab->pdevs_active[pdev_id])) {
+		ar = partner_ab->pdevs[pdev_id].ar;
+		if (!rcu_dereference(partner_ab->pdevs_active[pdev_id])) {
 			dev_kfree_skb_any(msdu);
 			continue;
 		}
@@ -2666,23 +2668,29 @@ static u16 ath12k_dp_rx_get_peer_id(struct ath12k_base *ab,
 int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 			 struct napi_struct *napi, int budget)
 {
-	LIST_HEAD(rx_desc_used_list);
+	struct ath12k_hw_group *ag = ab->ag;
+	struct list_head rx_desc_used_list[ATH12K_MAX_SOCS];
+	struct ath12k_hw_link *hw_links = ag->hw_links;
+	int num_buffs_reaped[ATH12K_MAX_SOCS] = {};
 	struct ath12k_rx_desc_info *desc_info;
 	struct ath12k_dp *dp = &ab->dp;
 	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 	struct hal_reo_dest_ring *desc;
-	int num_buffs_reaped = 0;
+	struct ath12k_base *partner_ab;
 	struct sk_buff_head msdu_list;
 	struct ath12k_skb_rxcb *rxcb;
 	int total_msdu_reaped = 0;
+	u8 hw_link_id, device_id;
 	struct hal_srng *srng;
 	struct sk_buff *msdu;
 	bool done = false;
-	u8 hw_link_id;
 	u64 desc_va;
 
 	__skb_queue_head_init(&msdu_list);
 
+	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++)
+		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
+
 	srng = &ab->hal.srng_list[dp->reo_dst_ring[ring_id].ring_id];
 
 	spin_lock_bh(&srng->lock);
@@ -2706,11 +2714,22 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 			   le32_to_cpu(desc->buf_va_lo));
 		desc_info = (struct ath12k_rx_desc_info *)((unsigned long)desc_va);
 
+		device_id = hw_links[hw_link_id].device_id;
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+		if (unlikely(!partner_ab)) {
+			if (desc_info->skb) {
+				dev_kfree_skb_any(desc_info->skb);
+				desc_info->skb = NULL;
+			}
+
+			continue;
+		}
+
 		/* retry manual desc retrieval */
 		if (!desc_info) {
-			desc_info = ath12k_dp_get_rx_desc(ab, cookie);
+			desc_info = ath12k_dp_get_rx_desc(partner_ab, cookie);
 			if (!desc_info) {
-				ath12k_warn(ab, "Invalid cookie in manual descriptor retrieval: 0x%x\n",
+				ath12k_warn(partner_ab, "Invalid cookie in manual descriptor retrieval: 0x%x\n",
 					    cookie);
 				continue;
 			}
@@ -2722,14 +2741,14 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		msdu = desc_info->skb;
 		desc_info->skb = NULL;
 
-		list_add_tail(&desc_info->list, &rx_desc_used_list);
+		list_add_tail(&desc_info->list, &rx_desc_used_list[device_id]);
 
 		rxcb = ATH12K_SKB_RXCB(msdu);
-		dma_unmap_single(ab->dev, rxcb->paddr,
+		dma_unmap_single(partner_ab->dev, rxcb->paddr,
 				 msdu->len + skb_tailroom(msdu),
 				 DMA_FROM_DEVICE);
 
-		num_buffs_reaped++;
+		num_buffs_reaped[device_id]++;
 
 		push_reason = le32_get_bits(desc->info0,
 					    HAL_REO_DEST_RING_INFO0_PUSH_REASON);
@@ -2786,8 +2805,17 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 	if (!total_msdu_reaped)
 		goto exit;
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, &rx_desc_used_list,
-				    num_buffs_reaped);
+	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++) {
+		if (!num_buffs_reaped[device_id])
+			continue;
+
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+		rx_ring = &partner_ab->dp.rx_refill_buf_ring;
+
+		ath12k_dp_rx_bufs_replenish(partner_ab, rx_ring,
+					    &rx_desc_used_list[device_id],
+					    num_buffs_reaped[device_id]);
+	}
 
 	ath12k_dp_rx_process_received_packets(ab, napi, &msdu_list,
 					      ring_id);
@@ -3477,7 +3505,9 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			     int budget)
 {
 	struct ath12k_hw_group *ag = ab->ag;
+	struct list_head rx_desc_used_list[ATH12K_MAX_SOCS];
 	u32 msdu_cookies[HAL_NUM_RX_MSDUS_PER_LINK_DESC];
+	int num_buffs_reaped[ATH12K_MAX_SOCS] = {};
 	struct dp_link_desc_bank *link_desc_banks;
 	enum hal_rx_buf_return_buf_manager rbm;
 	struct hal_rx_msdu_link *link_desc_va;
@@ -3486,11 +3516,10 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 	struct dp_rxdma_ring *rx_ring;
 	struct dp_srng *reo_except;
 	struct ath12k_hw_link *hw_links = ag->hw_links;
-	LIST_HEAD(rx_desc_used_list);
+	struct ath12k_base *partner_ab;
+	u8 hw_link_id, device_id;
 	u32 desc_bank, num_msdus;
 	struct hal_srng *srng;
-	struct ath12k_dp *dp;
-	u8 hw_link_id;
 	struct ath12k *ar;
 	dma_addr_t paddr;
 	bool is_frag;
@@ -3500,9 +3529,10 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 	tot_n_bufs_reaped = 0;
 	quota = budget;
 
-	dp = &ab->dp;
-	reo_except = &dp->reo_except_ring;
-	link_desc_banks = dp->link_desc_banks;
+	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++)
+		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
+
+	reo_except = &ab->dp.reo_except_ring;
 
 	srng = &ab->hal.srng_list[reo_except->ring_id];
 
@@ -3525,21 +3555,24 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 
 		hw_link_id = le32_get_bits(reo_desc->info0,
 					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
+		device_id = hw_links[hw_link_id].device_id;
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
 
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params,
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
 						      hw_links[hw_link_id].pdev_idx);
-		ar = ab->pdevs[pdev_id].ar;
+		ar = partner_ab->pdevs[pdev_id].ar;
 
+		link_desc_banks = partner_ab->dp.link_desc_banks;
 		link_desc_va = link_desc_banks[desc_bank].vaddr +
 			       (paddr - link_desc_banks[desc_bank].paddr);
 		ath12k_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus, msdu_cookies,
 						 &rbm);
-		if (rbm != dp->idle_link_rbm &&
+		if (rbm != partner_ab->dp.idle_link_rbm &&
 		    rbm != HAL_RX_BUF_RBM_SW3_BM &&
-		    rbm != ab->hw_params->hal_params->rx_buf_rbm) {
+		    rbm != partner_ab->hw_params->hal_params->rx_buf_rbm) {
 			ab->soc_stats.invalid_rbm++;
 			ath12k_warn(ab, "invalid return buffer manager %d\n", rbm);
-			ath12k_dp_rx_link_desc_return(ab, reo_desc,
+			ath12k_dp_rx_link_desc_return(partner_ab, reo_desc,
 						      HAL_WBM_REL_BM_ACT_REL_MSDU);
 			continue;
 		}
@@ -3549,20 +3582,26 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 
 		/* Process only rx fragments with one msdu per link desc below, and drop
 		 * msdu's indicated due to error reasons.
+		 * Dynamic fragmentation not supported in Multi-link client, so drop the
+		 * partner device buffers.
 		 */
-		if (!is_frag || num_msdus > 1) {
+		if (!is_frag || num_msdus > 1 ||
+		    partner_ab->device_id != ab->device_id) {
 			drop = true;
+
 			/* Return the link desc back to wbm idle list */
-			ath12k_dp_rx_link_desc_return(ab, reo_desc,
+			ath12k_dp_rx_link_desc_return(partner_ab, reo_desc,
 						      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
 		}
 
 		for (i = 0; i < num_msdus; i++) {
 			if (!ath12k_dp_process_rx_err_buf(ar, reo_desc,
-							  &rx_desc_used_list,
+							  &rx_desc_used_list[device_id],
 							  drop,
-							  msdu_cookies[i]))
+							  msdu_cookies[i])) {
+				num_buffs_reaped[device_id]++;
 				tot_n_bufs_reaped++;
+			}
 		}
 
 		if (tot_n_bufs_reaped >= quota) {
@@ -3578,10 +3617,17 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 
 	spin_unlock_bh(&srng->lock);
 
-	rx_ring = &dp->rx_refill_buf_ring;
+	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++) {
+		if (!num_buffs_reaped[device_id])
+			continue;
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, &rx_desc_used_list,
-				    tot_n_bufs_reaped);
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+		rx_ring = &partner_ab->dp.rx_refill_buf_ring;
+
+		ath12k_dp_rx_bufs_replenish(partner_ab, rx_ring,
+					    &rx_desc_used_list[device_id],
+					    num_buffs_reaped[device_id]);
+	}
 
 	return tot_n_bufs_reaped;
 }
@@ -3798,7 +3844,8 @@ static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
 int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 				 struct napi_struct *napi, int budget)
 {
-	LIST_HEAD(rx_desc_used_list);
+	struct list_head rx_desc_used_list[ATH12K_MAX_SOCS];
+	struct ath12k_hw_group *ag = ab->ag;
 	struct ath12k *ar;
 	struct ath12k_dp *dp = &ab->dp;
 	struct dp_rxdma_ring *rx_ring;
@@ -3808,18 +3855,22 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	struct sk_buff_head msdu_list, scatter_msdu_list;
 	struct ath12k_skb_rxcb *rxcb;
 	void *rx_desc;
-	u8 hw_link_id;
-	int num_buffs_reaped = 0;
+	int num_buffs_reaped[ATH12K_MAX_SOCS] = {};
+	int total_num_buffs_reaped = 0;
 	struct ath12k_rx_desc_info *desc_info;
-	struct ath12k_hw_link *hw_links = ab->ag->hw_links;
+	struct ath12k_hw_link *hw_links = ag->hw_links;
+	struct ath12k_base *partner_ab;
+	u8 hw_link_id, device_id;
 	int ret, pdev_id;
 	struct hal_rx_desc *msdu_data;
 
 	__skb_queue_head_init(&msdu_list);
 	__skb_queue_head_init(&scatter_msdu_list);
 
+	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++)
+		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
+
 	srng = &ab->hal.srng_list[dp->rx_rel_ring.ring_id];
-	rx_ring = &dp->rx_refill_buf_ring;
 	spin_lock_bh(&srng->lock);
 
 	ath12k_hal_srng_access_begin(ab, srng);
@@ -3855,14 +3906,27 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		msdu = desc_info->skb;
 		desc_info->skb = NULL;
 
-		list_add_tail(&desc_info->list, &rx_desc_used_list);
+		device_id = desc_info->device_id;
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+		if (unlikely(!partner_ab)) {
+			dev_kfree_skb_any(msdu);
+
+			/* In any case continuation bit is set
+			 * in the previous record, cleanup scatter_msdu_list
+			 */
+			ath12k_dp_clean_up_skb_list(&scatter_msdu_list);
+			continue;
+		}
+
+		list_add_tail(&desc_info->list, &rx_desc_used_list[device_id]);
 
 		rxcb = ATH12K_SKB_RXCB(msdu);
-		dma_unmap_single(ab->dev, rxcb->paddr,
+		dma_unmap_single(partner_ab->dev, rxcb->paddr,
 				 msdu->len + skb_tailroom(msdu),
 				 DMA_FROM_DEVICE);
 
-		num_buffs_reaped++;
+		num_buffs_reaped[device_id]++;
+		total_num_buffs_reaped++;
 
 		if (!err_info.continuation)
 			budget--;
@@ -3886,9 +3950,9 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			continue;
 		}
 
-		hw_link_id = ath12k_dp_rx_get_msdu_src_link(ab,
+		hw_link_id = ath12k_dp_rx_get_msdu_src_link(partner_ab,
 							    msdu_data);
-		if (hw_link_id >= MAX_RADIOS) {
+		if (hw_link_id >= ATH12K_GROUP_MAX_RADIO) {
 			dev_kfree_skb_any(msdu);
 
 			/* In any case continuation bit is set
@@ -3924,20 +3988,39 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 
 	spin_unlock_bh(&srng->lock);
 
-	if (!num_buffs_reaped)
+	if (!total_num_buffs_reaped)
 		goto done;
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, &rx_desc_used_list,
-				    num_buffs_reaped);
+	for (device_id = 0; device_id < ATH12K_MAX_SOCS; device_id++) {
+		if (!num_buffs_reaped[device_id])
+			continue;
+
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+		rx_ring = &partner_ab->dp.rx_refill_buf_ring;
+
+		ath12k_dp_rx_bufs_replenish(ab, rx_ring,
+					    &rx_desc_used_list[device_id],
+					    num_buffs_reaped[device_id]);
+	}
 
 	rcu_read_lock();
 	while ((msdu = __skb_dequeue(&msdu_list))) {
 		rxcb = ATH12K_SKB_RXCB(msdu);
 		hw_link_id = rxcb->hw_link_id;
 
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params,
+		device_id = hw_links[hw_link_id].device_id;
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+		if (unlikely(!partner_ab)) {
+			ath12k_dbg(ab, ATH12K_DBG_DATA,
+				   "Unable to process WBM error msdu due to invalid hw link id %d device id %d\n",
+				   hw_link_id, device_id);
+			dev_kfree_skb_any(msdu);
+			continue;
+		}
+
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
 						      hw_links[hw_link_id].pdev_idx);
-		ar = ab->pdevs[pdev_id].ar;
+		ar = partner_ab->pdevs[pdev_id].ar;
 
 		if (!ar || !rcu_dereference(ar->ab->pdevs_active[hw_link_id])) {
 			dev_kfree_skb_any(msdu);
@@ -3952,7 +4035,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	}
 	rcu_read_unlock();
 done:
-	return num_buffs_reaped;
+	return total_num_buffs_reaped;
 }
 
 void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab)
-- 
2.39.5


