Return-Path: <linux-wireless+bounces-16104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8639E9E79
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0ED28338E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F9A194C6A;
	Mon,  9 Dec 2024 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlYaaZXC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF6167DAC
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770465; cv=none; b=GHaxktOO/7SUipj6VUrKIEdSQngqsPZCEvTX2OCfuS2o18eS0B9xxwziKRRaUqOa4TKaFsQCMK/T6g4XUro7ahkrZWQHt5jRF83TSzm9eG2NH+leYIaiKj0t/YsrHnsMUpbWpVu9qsV1q1gPPS9DrgNPFbuy9rYcmNaO/IdGwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770465; c=relaxed/simple;
	bh=+ct0kbflG9txcTgNzKO0PVelD5KbgzHgswkc+rSVBcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvt90F+HIRGVj2WZb2qIeMmVjwTvumttnwQXNUcXCD0elAz96k+CjFr64NGJNKPHMcwNPADkJGpbQD9GsoiUx96aKiA/2Wh6sWRddyn3AnS7iHiPXnIfMRhy+IKlsu5LzlNAfBWZWUKdvTMvt3yx/JDW4Wdts7t5fF27T1K0900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlYaaZXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E30C4CEE0;
	Mon,  9 Dec 2024 18:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733770464;
	bh=+ct0kbflG9txcTgNzKO0PVelD5KbgzHgswkc+rSVBcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlYaaZXC+InQWdCQhRwUueHCbKE8XaS0zPj3sKVUiOV6RuDOJDV7iKQQBFiC/fBZW
	 a/GkdF3DNZMOGRB0PDBXOnpAqeo7UeRNCMK5c7Be/Uqjy4zq3vw7bRoUp5MkJ9KDwT
	 eLjVB43xjeuO8QTmpqR9XZ9kjRXZJshlKy1TuVtWxVV2OAUVwdSIYkVa/ngXTg5bOo
	 OTnwDBNb1oKaH6shNaszmXFE2izN2v4BTvUeadeu3glD9Fm+l90sXEHjS1tUWYb/TB
	 DiShmyHnaeERz8bF7Fj8sTJOEpX6gyTy76vMQp6o7nJOKG5+w0U02EfNvh4UDjZXGl
	 cg8KAWK0Ubg9A==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/9] wifi: ath12k: move to HW link id based reveive handling
Date: Mon,  9 Dec 2024 20:54:13 +0200
Message-Id: <20241209185421.376381-2-kvalo@kernel.org>
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

Currently, all the rx processing treats the hardware link id as the MAC id.
The HW link id is a unique identifier for all hardware links participating in
the multi link group. Therefore, the current MAC id derivation is insufficient
to process the partner rx buffer in the Multi-Link Operation. So derive the
MAC id from the HW link id and implementing this change in rx processing will
enable the scaling of partner buffer processing in Multi-Link Operation.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h  |  8 +++-
 drivers/net/wireless/ath/ath12k/dp_rx.c | 49 +++++++++++++++----------
 drivers/net/wireless/ath/ath12k/mac.c   |  3 ++
 3 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index dc01f7b3fd73..9386e9592dff 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -136,7 +136,7 @@ struct ath12k_skb_rxcb {
 	struct hal_rx_desc *rx_desc;
 	u8 err_rel_src;
 	u8 err_code;
-	u8 mac_id;
+	u8 hw_link_id;
 	u8 unmapped;
 	u8 is_frag;
 	u8 tid;
@@ -831,6 +831,11 @@ struct ath12k_mlo_memory {
 	bool init_done;
 };
 
+struct ath12k_hw_link {
+	u8 device_id;
+	u8 pdev_idx;
+};
+
 /* Holds info on the group of devices that are registered as a single
  * wiphy, protected with struct ath12k_hw_group::mutex.
  */
@@ -857,6 +862,7 @@ struct ath12k_hw_group {
 	bool mlo_capable;
 	struct device_node *wsi_node[ATH12K_MAX_SOCS];
 	struct ath12k_mlo_memory mlo_mem;
+	struct ath12k_hw_link hw_links[ATH12K_GROUP_MAX_RADIO];
 };
 
 /* Holds WSI info specific to each device, excluding WSI group info */
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 2c919503ddef..d658d4eb1fd7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2595,11 +2595,13 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 						  struct sk_buff_head *msdu_list,
 						  int ring_id)
 {
+	struct ath12k_hw_group *ag = ab->ag;
 	struct ieee80211_rx_status rx_status = {0};
 	struct ath12k_skb_rxcb *rxcb;
 	struct sk_buff *msdu;
 	struct ath12k *ar;
-	u8 mac_id, pdev_id;
+	struct ath12k_hw_link *hw_links = ag->hw_links;
+	u8 hw_link_id, pdev_id;
 	int ret;
 
 	if (skb_queue_empty(msdu_list))
@@ -2609,8 +2611,10 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 
 	while ((msdu = __skb_dequeue(msdu_list))) {
 		rxcb = ATH12K_SKB_RXCB(msdu);
-		mac_id = rxcb->mac_id;
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
+		hw_link_id = rxcb->hw_link_id;
+
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params,
+						      hw_links[hw_link_id].pdev_idx);
 		ar = ab->pdevs[pdev_id].ar;
 		if (!rcu_dereference(ab->pdevs_active[pdev_id])) {
 			dev_kfree_skb_any(msdu);
@@ -2674,7 +2678,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 	struct hal_srng *srng;
 	struct sk_buff *msdu;
 	bool done = false;
-	int mac_id;
+	u8 hw_link_id;
 	u64 desc_va;
 
 	__skb_queue_head_init(&msdu_list);
@@ -2695,8 +2699,8 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		cookie = le32_get_bits(desc->buf_addr_info.info1,
 				       BUFFER_ADDR_INFO1_SW_COOKIE);
 
-		mac_id = le32_get_bits(desc->info0,
-				       HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
+		hw_link_id = le32_get_bits(desc->info0,
+					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
 
 		desc_va = ((u64)le32_to_cpu(desc->buf_va_hi) << 32 |
 			   le32_to_cpu(desc->buf_va_lo));
@@ -2745,7 +2749,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 					RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU);
 		rxcb->is_continuation = !!(le32_to_cpu(msdu_info->info0) &
 					   RX_MSDU_DESC_INFO0_MSDU_CONTINUATION);
-		rxcb->mac_id = mac_id;
+		rxcb->hw_link_id = hw_link_id;
 		rxcb->peer_id = ath12k_dp_rx_get_peer_id(ab, dp->peer_metadata_ver,
 							 mpdu_info->peer_meta_data);
 		rxcb->tid = le32_get_bits(mpdu_info->info0,
@@ -3472,6 +3476,7 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			     int budget)
 {
+	struct ath12k_hw_group *ag = ab->ag;
 	u32 msdu_cookies[HAL_NUM_RX_MSDUS_PER_LINK_DESC];
 	struct dp_link_desc_bank *link_desc_banks;
 	enum hal_rx_buf_return_buf_manager rbm;
@@ -3480,11 +3485,12 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 	struct hal_reo_dest_ring *reo_desc;
 	struct dp_rxdma_ring *rx_ring;
 	struct dp_srng *reo_except;
+	struct ath12k_hw_link *hw_links = ag->hw_links;
 	LIST_HEAD(rx_desc_used_list);
 	u32 desc_bank, num_msdus;
 	struct hal_srng *srng;
 	struct ath12k_dp *dp;
-	int mac_id;
+	u8 hw_link_id;
 	struct ath12k *ar;
 	dma_addr_t paddr;
 	bool is_frag;
@@ -3517,10 +3523,11 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			continue;
 		}
 
-		mac_id = le32_get_bits(reo_desc->info0,
-				       HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
+		hw_link_id = le32_get_bits(reo_desc->info0,
+					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
 
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params,
+						      hw_links[hw_link_id].pdev_idx);
 		ar = ab->pdevs[pdev_id].ar;
 
 		link_desc_va = link_desc_banks[desc_bank].vaddr +
@@ -3801,9 +3808,10 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	struct sk_buff_head msdu_list, scatter_msdu_list;
 	struct ath12k_skb_rxcb *rxcb;
 	void *rx_desc;
-	u8 mac_id;
+	u8 hw_link_id;
 	int num_buffs_reaped = 0;
 	struct ath12k_rx_desc_info *desc_info;
+	struct ath12k_hw_link *hw_links = ab->ag->hw_links;
 	int ret, pdev_id;
 	struct hal_rx_desc *msdu_data;
 
@@ -3878,9 +3886,9 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			continue;
 		}
 
-		mac_id = ath12k_dp_rx_get_msdu_src_link(ab,
-							msdu_data);
-		if (mac_id >= MAX_RADIOS) {
+		hw_link_id = ath12k_dp_rx_get_msdu_src_link(ab,
+							    msdu_data);
+		if (hw_link_id >= MAX_RADIOS) {
 			dev_kfree_skb_any(msdu);
 
 			/* In any case continuation bit is set
@@ -3895,7 +3903,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 
 			skb_queue_walk(&scatter_msdu_list, msdu) {
 				rxcb = ATH12K_SKB_RXCB(msdu);
-				rxcb->mac_id = mac_id;
+				rxcb->hw_link_id = hw_link_id;
 			}
 
 			skb_queue_splice_tail_init(&scatter_msdu_list,
@@ -3903,7 +3911,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		}
 
 		rxcb = ATH12K_SKB_RXCB(msdu);
-		rxcb->mac_id = mac_id;
+		rxcb->hw_link_id = hw_link_id;
 		__skb_queue_tail(&msdu_list, msdu);
 	}
 
@@ -3925,12 +3933,13 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	rcu_read_lock();
 	while ((msdu = __skb_dequeue(&msdu_list))) {
 		rxcb = ATH12K_SKB_RXCB(msdu);
-		mac_id = rxcb->mac_id;
+		hw_link_id = rxcb->hw_link_id;
 
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params,
+						      hw_links[hw_link_id].pdev_idx);
 		ar = ab->pdevs[pdev_id].ar;
 
-		if (!ar || !rcu_dereference(ar->ab->pdevs_active[mac_id])) {
+		if (!ar || !rcu_dereference(ar->ab->pdevs_active[hw_link_id])) {
 			dev_kfree_skb_any(msdu);
 			continue;
 		}
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 23c5c8fd952d..7e8eb0feb871 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11050,6 +11050,9 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_hw_group *ag,
 		ar->pdev_idx = pdev_idx;
 		pdev->ar = ar;
 
+		ag->hw_links[ar->hw_link_id].device_id = ab->device_id;
+		ag->hw_links[ar->hw_link_id].pdev_idx = pdev_idx;
+
 		ath12k_mac_setup(ar);
 		ath12k_dp_pdev_pre_alloc(ar);
 	}
-- 
2.39.5


