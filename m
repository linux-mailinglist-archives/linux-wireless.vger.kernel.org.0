Return-Path: <linux-wireless+bounces-4937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981E28808DF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 02:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2551C22429
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 01:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D71C20;
	Wed, 20 Mar 2024 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UGoBqKyy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38310EB
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896801; cv=none; b=iN20B/Shvoe4SdW/hk18T3x3OwY83QS9MXymLYKuqZ/hY+drmZhpOEYAO1YY+fVvDj8qd/LB401KVgVhdYo2VczOL+w/PM5CCkgoK3TN26BfsA8dXECzuGcnhWHf+emHvERkRhRGaY542xT3xvKawZrfFhZQphwNQwHHZ71y/lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896801; c=relaxed/simple;
	bh=sAjgfnjUnX5FkJgIGKcCmjxVFjn2pRzyti8jcZcfW78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUpL2OtCMdYj70rwcKLZC7XaWi7MOg+epnfvY2Dhd+o9lcij3Z3eXjGni8fUago9/42Q/RzzdvTwYbt4D7yfX+UlGdI9rYiZfIs2RbosFkzoD+bwnBYysglKzlenqOFPBKqvywvoEaQeu0EHyjoOTcxUXh9PZ4h4Rc8iSTyzmcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UGoBqKyy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K0HCKE004651;
	Wed, 20 Mar 2024 01:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=bfXldiYLrIEUzkZSE5GLhLj3BX7zvyaeyXFURTHeS3Q=; b=UG
	oBqKyycZN2TPaG8Sf0RhHdtoPkWwE7gSPZrAWjK2DsKfdUJSwXyQxjMz4G0ZiTCa
	I6wUCeKl7OqTFZ//GLrmN2I4cMu0/TWBkl12Vl820Ol94h7H1gs3codNjXPCUWsd
	ACcG9ISFUc7CNHbAZpEy9vHfl1vW00V/I19IkYlIVyXgx+2pZB07mnorXQvR8EEp
	0EbGYaOYBIWQOwXvjLRRGXS2Al9lQ09RpD2B/nwPLfytylRyJVgjcLepApCR/ej2
	zukvLpM2sDWVG4cBBZ2UDfpjDzhoAlpAFEdoRppXxHu6S60Imk5RRsbPbM5uARgA
	BVezMNeImkFdm5lq4RLw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wye5n9294-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:06:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K16Z5c032214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:06:35 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 18:06:34 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 2/3] wifi: ath12k: Optimize the lock contention of used list in Rx data path
Date: Wed, 20 Mar 2024 06:36:14 +0530
Message-ID: <20240320010615.91331-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320010615.91331-1-quic_periyasa@quicinc.com>
References: <20240320010615.91331-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L3hepbjZEeHVx4zSSDELIpS2ozPt161o
X-Proofpoint-ORIG-GUID: L3hepbjZEeHVx4zSSDELIpS2ozPt161o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=665 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200006

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

This is a simple UDP UL throughput test case results on x86+NUC device
with QCN9274 card, which clearly shows 8% to 12% improvement in the CPU
idle for the same ingress traffic.

Before:
Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:     all    0.24    0.00   12.54    0.08    0.00   23.33    0.00    0.00    0.00   63.81

After:
Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:     all    0.34    0.00    4.60    0.00    0.00   19.59    0.00    0.00    0.00   75.47

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


