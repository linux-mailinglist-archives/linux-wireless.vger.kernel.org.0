Return-Path: <linux-wireless+bounces-4015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D250D867BB6
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 17:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431D61F22DAB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A701012C807;
	Mon, 26 Feb 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UnjFz/xK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEC612C7F8
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964614; cv=none; b=q9ZtfamvahRKhzP7LZiVJDkhSkNIzjt0NYKY/8NHkFheab/GJRbYvSS7SZBi0ftPYM++ZZvsUetxwoxs/wxOTKFhHs6QmatMlrN9EB93A7o/VBvYiEK/r3aF4V1MD3yF6bJ0DxC4/1HQ5uyhxxeaNbntBR/V9ZAMcsYwzyBZ8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964614; c=relaxed/simple;
	bh=2BTalYyAQvvud4tyc2udw1Y1KG6j5v0Z5PNbvwgBC2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbcPNGztpe6T62JzrBmXuXQjuYCYklL2kUIZj8U8l9NQc3LXqisfteiVSALFt95JM4zfz2Ki/owYeqGvPHONerCGeB2FSxEMHMkd2zvFdm4s+LTeu6F4jEW2MDCYH7nMb/RfzQsaelne4mJPTKjsJebzOCH4038YaCBoQ8xi2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UnjFz/xK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QF8LaF005324;
	Mon, 26 Feb 2024 16:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=DuXkEkdwo7Ifu7xuXSPHm4eRbU9MrDG82b11fmZ51Ko=; b=Un
	jFz/xKzRZ6F+JnpVgCumaV/Sfn3jM+yd0Gq6SgqS/Vb0NTV48fB6JWmEQDQ1YgrY
	oZ/8p3kfHWoDZ4V9svQ5p+g4GZrf8cT+/ud9Qhi8yi0KZb4nTmA6Y2aQATQNYogL
	zQ2ufzTLCZI/Y6YuVxSvpZ9O5cQjS7k0BsOkENAZAfjKJTsYKKvgaG253tu5oC2/
	vo0vYJMpcW84BvQbBPPwIeWWYh7VDfy6ban3VJU5wdvqB+JZltruQF9Sx8VR7rMH
	xjlxO4SU7jrN9GkyHy6X4YXVkYzlUG2GE3yn+TXHwpyAs+E+luV5QdspEKpTfwnN
	ENBs5Q2M7lJrVPQt+Rpw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxmhds6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:23:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QGNTEu001833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:23:29 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 08:23:27 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/3] wifi: ath12k: Optimize the lock contention of used list in Rx data path
Date: Mon, 26 Feb 2024 21:53:09 +0530
Message-ID: <20240226162310.629162-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226162310.629162-1-quic_periyasa@quicinc.com>
References: <20240226162310.629162-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FtjYC9r7VAiYu0ZSN4X-f10vEKkl24Jy
X-Proofpoint-ORIG-GUID: FtjYC9r7VAiYu0ZSN4X-f10vEKkl24Jy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=729 impostorscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260124

When a packet arrives in Rx rings, the RX descriptor moves from the used
list to the free list. Then, the rxdma ring gets replenished, where the Rx
descriptor again moves from the free list to the used list. At the end, the
descriptor came to the used list with unnecessary list movement. The
descriptor used list is maintained in the Rxdma ring structure, which
creates lock contention for the list operations (add, delete) in the Rx
data path. Optimize the Rx data path by removing the used list from the
common Rxdma ring and maintain as a local variable in the Rx ring handler
itself, which avoid lock contention. Now, to find the used list descriptor
during descriptor cleanup, we need to check the in_use flag for each Rx
descriptor.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    |  31 +++---
 drivers/net/wireless/ath/ath12k/dp.h    |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c | 131 ++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/dp_rx.h |   1 +
 4 files changed, 114 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index c8e1b244b69e..1006eef8ff0c 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -960,8 +960,9 @@ int ath12k_dp_service_srng(struct ath12k_base *ab,
 	if (ab->hw_params->ring_mask->host2rxdma[grp_id]) {
 		struct ath12k_dp *dp = &ab->dp;
 		struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
+		LIST_HEAD(list);
 
-		ath12k_dp_rx_bufs_replenish(ab, rx_ring, 0);
+		ath12k_dp_rx_bufs_replenish(ab, rx_ring, &list, 0);
 	}
 
 	/* TODO: Implement handler for other interrupts */
@@ -1146,11 +1147,11 @@ void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_vif *arvif)
 
 static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 {
-	struct ath12k_rx_desc_info *desc_info, *tmp;
+	struct ath12k_rx_desc_info *desc_info;
 	struct ath12k_tx_desc_info *tx_desc_info, *tmp1;
 	struct ath12k_dp *dp = &ab->dp;
 	struct sk_buff *skb;
-	int i;
+	int i, j;
 	u32 pool_id, tx_spt_page;
 
 	if (!dp->spt_info)
@@ -1159,16 +1160,23 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 	/* RX Descriptor cleanup */
 	spin_lock_bh(&dp->rx_desc_lock);
 
-	list_for_each_entry_safe(desc_info, tmp, &dp->rx_desc_used_list, list) {
-		list_del(&desc_info->list);
-		skb = desc_info->skb;
+	for (i = 0; i < ATH12K_NUM_RX_SPT_PAGES; i++) {
+		desc_info = dp->spt_info->rxbaddr[i];
 
-		if (!skb)
-			continue;
+		for (j = 0; j < ATH12K_MAX_SPT_ENTRIES; j++) {
+			if (!desc_info[j].in_use) {
+				list_del(&desc_info[j].list);
+				continue;
+			}
 
-		dma_unmap_single(ab->dev, ATH12K_SKB_RXCB(skb)->paddr,
-				 skb->len + skb_tailroom(skb), DMA_FROM_DEVICE);
-		dev_kfree_skb_any(skb);
+			skb = desc_info[j].skb;
+			if (!skb)
+				continue;
+
+			dma_unmap_single(ab->dev, ATH12K_SKB_RXCB(skb)->paddr,
+					 skb->len + skb_tailroom(skb), DMA_FROM_DEVICE);
+			dev_kfree_skb_any(skb);
+		}
 	}
 
 	for (i = 0; i < ATH12K_NUM_RX_SPT_PAGES; i++) {
@@ -1444,7 +1452,6 @@ static int ath12k_dp_cc_init(struct ath12k_base *ab)
 	u32 cmem_base;
 
 	INIT_LIST_HEAD(&dp->rx_desc_free_list);
-	INIT_LIST_HEAD(&dp->rx_desc_used_list);
 	spin_lock_init(&dp->rx_desc_lock);
 
 	for (i = 0; i < ATH12K_HW_MAX_QUEUES; i++) {
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index eb2dd408e081..0d59910a00d9 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -282,6 +282,8 @@ struct ath12k_rx_desc_info {
 	struct sk_buff *skb;
 	u32 cookie;
 	u32 magic;
+	u8 in_use	: 1,
+	   reserved	: 7;
 };
 
 struct ath12k_tx_desc_info {
@@ -347,8 +349,7 @@ struct ath12k_dp {
 	struct ath12k_spt_info *spt_info;
 	u32 num_spt_pages;
 	struct list_head rx_desc_free_list;
-	struct list_head rx_desc_used_list;
-	/* protects the free and used desc list */
+	/* protects the free desc list */
 	spinlock_t rx_desc_lock;
 
 	struct list_head tx_desc_free_list[ATH12K_HW_MAX_QUEUES];
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 45646d987139..2a0e4faadcf1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -261,9 +261,53 @@ static int ath12k_dp_purge_mon_ring(struct ath12k_base *ab)
 	return -ETIMEDOUT;
 }
 
+static size_t ath12k_dp_list_cut_nodes(struct list_head *list,
+				       struct list_head *head,
+				       size_t count)
+{
+	struct list_head *cur;
+	struct ath12k_rx_desc_info *rx_desc;
+	size_t nodes = 0;
+
+	if (!count) {
+		INIT_LIST_HEAD(list);
+		goto out;
+	}
+
+	list_for_each(cur, head) {
+		if (!count)
+			break;
+
+		rx_desc = list_entry(cur, struct ath12k_rx_desc_info, list);
+		rx_desc->in_use = true;
+
+		count--;
+		nodes++;
+	}
+
+	list_cut_before(list, head, cur);
+out:
+	return nodes;
+}
+
+static void ath12k_dp_rx_enqueue_free(struct ath12k_dp *dp,
+				      struct list_head *used_list)
+{
+	struct ath12k_rx_desc_info *rx_desc, *safe;
+
+	/* Reset the use flag */
+	list_for_each_entry_safe(rx_desc, safe, used_list, list)
+		rx_desc->in_use = false;
+
+	spin_lock_bh(&dp->rx_desc_lock);
+	list_splice_tail(used_list, &dp->rx_desc_free_list);
+	spin_unlock_bh(&dp->rx_desc_lock);
+}
+
 /* Returns number of Rx buffers replenished */
 int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_ring *rx_ring,
+				struct list_head *used_list,
 				int req_entries)
 {
 	struct ath12k_buffer_addr *desc;
@@ -292,6 +336,19 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 	req_entries = min(num_free, req_entries);
 	num_remain = req_entries;
 
+	if (!num_remain)
+		goto skip_replenish;
+
+	/* Get the descriptor from free list */
+	if (list_empty(used_list)) {
+		spin_lock_bh(&dp->rx_desc_lock);
+		req_entries = ath12k_dp_list_cut_nodes(used_list,
+						       &dp->rx_desc_free_list,
+						       num_remain);
+		spin_unlock_bh(&dp->rx_desc_lock);
+		num_remain = req_entries;
+	}
+
 	while (num_remain > 0) {
 		skb = dev_alloc_skb(DP_RX_BUFFER_SIZE +
 				    DP_RX_BUFFER_ALIGN_SIZE);
@@ -311,33 +368,20 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 		if (dma_mapping_error(ab->dev, paddr))
 			goto fail_free_skb;
 
-		spin_lock_bh(&dp->rx_desc_lock);
-
-		/* Get desc from free list and store in used list
-		 * for cleanup purposes
-		 *
-		 * TODO: pass the removed descs rather than
-		 * add/read to optimize
-		 */
-		rx_desc = list_first_entry_or_null(&dp->rx_desc_free_list,
+		rx_desc = list_first_entry_or_null(used_list,
 						   struct ath12k_rx_desc_info,
 						   list);
-		if (!rx_desc) {
-			spin_unlock_bh(&dp->rx_desc_lock);
+		if (!rx_desc)
 			goto fail_dma_unmap;
-		}
 
 		rx_desc->skb = skb;
 		cookie = rx_desc->cookie;
-		list_del(&rx_desc->list);
-		list_add_tail(&rx_desc->list, &dp->rx_desc_used_list);
-
-		spin_unlock_bh(&dp->rx_desc_lock);
 
 		desc = ath12k_hal_srng_src_get_next_entry(ab, srng);
 		if (!desc)
-			goto fail_buf_unassign;
+			goto fail_dma_unmap;
 
+		list_del(&rx_desc->list);
 		ATH12K_SKB_RXCB(skb)->paddr = paddr;
 
 		num_remain--;
@@ -345,18 +389,16 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 		ath12k_hal_rx_buf_addr_info_set(desc, paddr, cookie, mgr);
 	}
 
+skip_replenish:
 	ath12k_hal_srng_access_end(ab, srng);
 
+	if (!list_empty(used_list))
+		ath12k_dp_rx_enqueue_free(dp, used_list);
+
 	spin_unlock_bh(&srng->lock);
 
 	return req_entries - num_remain;
 
-fail_buf_unassign:
-	spin_lock_bh(&dp->rx_desc_lock);
-	list_del(&rx_desc->list);
-	list_add_tail(&rx_desc->list, &dp->rx_desc_free_list);
-	rx_desc->skb = NULL;
-	spin_unlock_bh(&dp->rx_desc_lock);
 fail_dma_unmap:
 	dma_unmap_single(ab->dev, paddr, skb->len + skb_tailroom(skb),
 			 DMA_FROM_DEVICE);
@@ -365,6 +407,9 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 
 	ath12k_hal_srng_access_end(ab, srng);
 
+	if (!list_empty(used_list))
+		ath12k_dp_rx_enqueue_free(dp, used_list);
+
 	spin_unlock_bh(&srng->lock);
 
 	return req_entries - num_remain;
@@ -422,10 +467,12 @@ static int ath12k_dp_rxdma_mon_ring_buf_setup(struct ath12k_base *ab,
 static int ath12k_dp_rxdma_ring_buf_setup(struct ath12k_base *ab,
 					  struct dp_rxdma_ring *rx_ring)
 {
+	LIST_HEAD(list);
+
 	rx_ring->bufs_max = rx_ring->refill_buf_ring.size /
 			ath12k_hal_srng_get_entrysize(ab, HAL_RXDMA_BUF);
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, 0);
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, &list, 0);
 
 	return 0;
 }
@@ -2582,6 +2629,7 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 			 struct napi_struct *napi, int budget)
 {
+	LIST_HEAD(rx_desc_used_list);
 	struct ath12k_rx_desc_info *desc_info;
 	struct ath12k_dp *dp = &ab->dp;
 	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
@@ -2634,9 +2682,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		msdu = desc_info->skb;
 		desc_info->skb = NULL;
 
-		spin_lock_bh(&dp->rx_desc_lock);
-		list_move_tail(&desc_info->list, &dp->rx_desc_free_list);
-		spin_unlock_bh(&dp->rx_desc_lock);
+		list_add_tail(&desc_info->list, &rx_desc_used_list);
 
 		rxcb = ATH12K_SKB_RXCB(msdu);
 		dma_unmap_single(ab->dev, rxcb->paddr,
@@ -2697,7 +2743,8 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 	if (!total_msdu_reaped)
 		goto exit;
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped);
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, &rx_desc_used_list,
+				    num_buffs_reaped);
 
 	ath12k_dp_rx_process_received_packets(ab, napi, &msdu_list,
 					      ring_id);
@@ -3018,9 +3065,9 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	}
 
 	desc_info->skb = defrag_skb;
+	desc_info->in_use = true;
 
 	list_del(&desc_info->list);
-	list_add_tail(&desc_info->list, &dp->rx_desc_used_list);
 	spin_unlock_bh(&dp->rx_desc_lock);
 
 	ATH12K_SKB_RXCB(defrag_skb)->paddr = buf_paddr;
@@ -3082,9 +3129,9 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 
 err_free_desc:
 	spin_lock_bh(&dp->rx_desc_lock);
-	list_del(&desc_info->list);
-	list_add_tail(&desc_info->list, &dp->rx_desc_free_list);
+	desc_info->in_use = false;
 	desc_info->skb = NULL;
+	list_add_tail(&desc_info->list, &dp->rx_desc_free_list);
 	spin_unlock_bh(&dp->rx_desc_lock);
 err_unmap_dma:
 	dma_unmap_single(ab->dev, buf_paddr, defrag_skb->len + skb_tailroom(defrag_skb),
@@ -3301,6 +3348,7 @@ static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
 
 static int
 ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
+			     struct list_head *used_list,
 			     bool drop, u32 cookie)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -3330,9 +3378,8 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 
 	msdu = desc_info->skb;
 	desc_info->skb = NULL;
-	spin_lock_bh(&ab->dp.rx_desc_lock);
-	list_move_tail(&desc_info->list, &ab->dp.rx_desc_free_list);
-	spin_unlock_bh(&ab->dp.rx_desc_lock);
+
+	list_add_tail(&desc_info->list, used_list);
 
 	rxcb = ATH12K_SKB_RXCB(msdu);
 	dma_unmap_single(ar->ab->dev, rxcb->paddr,
@@ -3388,6 +3435,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 	struct hal_reo_dest_ring *reo_desc;
 	struct dp_rxdma_ring *rx_ring;
 	struct dp_srng *reo_except;
+	LIST_HEAD(rx_desc_used_list);
 	u32 desc_bank, num_msdus;
 	struct hal_srng *srng;
 	struct ath12k_dp *dp;
@@ -3455,7 +3503,9 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
 			ar = ab->pdevs[pdev_id].ar;
 
-			if (!ath12k_dp_process_rx_err_buf(ar, reo_desc, drop,
+			if (!ath12k_dp_process_rx_err_buf(ar, reo_desc,
+							  &rx_desc_used_list,
+							  drop,
 							  msdu_cookies[i]))
 				tot_n_bufs_reaped++;
 		}
@@ -3475,7 +3525,8 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 
 	rx_ring = &dp->rx_refill_buf_ring;
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, tot_n_bufs_reaped);
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, &rx_desc_used_list,
+				    tot_n_bufs_reaped);
 
 	return tot_n_bufs_reaped;
 }
@@ -3692,6 +3743,7 @@ static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
 int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 				 struct napi_struct *napi, int budget)
 {
+	LIST_HEAD(rx_desc_used_list);
 	struct ath12k *ar;
 	struct ath12k_dp *dp = &ab->dp;
 	struct dp_rxdma_ring *rx_ring;
@@ -3745,9 +3797,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		msdu = desc_info->skb;
 		desc_info->skb = NULL;
 
-		spin_lock_bh(&dp->rx_desc_lock);
-		list_move_tail(&desc_info->list, &dp->rx_desc_free_list);
-		spin_unlock_bh(&dp->rx_desc_lock);
+		list_add_tail(&desc_info->list, &rx_desc_used_list);
 
 		rxcb = ATH12K_SKB_RXCB(msdu);
 		dma_unmap_single(ab->dev, rxcb->paddr,
@@ -3783,7 +3833,8 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	if (!num_buffs_reaped)
 		goto done;
 
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_buffs_reaped);
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, &rx_desc_used_list,
+				    num_buffs_reaped);
 
 	rcu_read_lock();
 	while ((msdu = __skb_dequeue(&msdu_list))) {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 05b3d5581dbe..25940061ead5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -118,6 +118,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int mac_id,
 			 int budget);
 int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_ring *rx_ring,
+				struct list_head *used_list,
 				int req_entries);
 int ath12k_dp_rx_pdev_mon_attach(struct ath12k *ar);
 int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id);
-- 
2.34.1


