Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F8C3FE8BE
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Sep 2021 07:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhIBFf6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Sep 2021 01:35:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57414 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232010AbhIBFfw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Sep 2021 01:35:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630560895; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hu/mxWASfGvzpqe/GpnCNsQQ5v0oR6qGppRWgtylL7k=; b=skC8NotdQNob2nspFhdPB/2XYqCexF/b3NaIiJEKe1aWniEVaUCXah4eot7FQgeJC7ohEtt6
 0Ntn+wmM5dqTTukiES8OiaAAcG+bnyCsq50Q1ZqXHXmHR4Y3PjDSGrL1zJsaT7rhyMEJa2/2
 MjaJP1TdPnvWqcmVDS0HEi2clNo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6130627ee0fcecca1999cdd4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Sep 2021 05:34:54
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4ADBC4361A; Thu,  2 Sep 2021 05:34:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88DE5C4360D;
        Thu,  2 Sep 2021 05:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 88DE5C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH v3 05/12] ath11k: avoid active pdev check for each msdu
Date:   Thu,  2 Sep 2021 11:03:33 +0530
Message-Id: <1630560820-21905-6-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org>
References: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Active Pdev and CAC check are done for each msdu in
ath11k_dp_rx_process_received_packets which is a overhead.
To avoid this overhead, collect all msdus in a per mac msdu
list and pass to function.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 66 ++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 994959b..1d85e10 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2523,12 +2523,10 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 						  struct napi_struct *napi,
 						  struct sk_buff_head *msdu_list,
-						  int *quota, int ring_id)
+						  int *quota, int mac_id)
 {
-	struct ath11k_skb_rxcb *rxcb;
 	struct sk_buff *msdu;
 	struct ath11k *ar;
-	u8 mac_id;
 	int ret;
 
 	if (skb_queue_empty(msdu_list))
@@ -2536,20 +2534,20 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 
 	rcu_read_lock();
 
-	while (*quota && (msdu = __skb_dequeue(msdu_list))) {
-		rxcb = ATH11K_SKB_RXCB(msdu);
-		mac_id = rxcb->mac_id;
-		ar = ab->pdevs[mac_id].ar;
-		if (!rcu_dereference(ab->pdevs_active[mac_id])) {
-			dev_kfree_skb_any(msdu);
-			continue;
-		}
+	ar = ab->pdevs[mac_id].ar;
+	if (!rcu_dereference(ab->pdevs_active[mac_id])) {
+		__skb_queue_purge(msdu_list);
+		rcu_read_unlock();
+		return;
+	}
 
-		if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
-			dev_kfree_skb_any(msdu);
-			continue;
-		}
+	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
+		__skb_queue_purge(msdu_list);
+		rcu_read_unlock();
+		return;
+	}
 
+	while ((msdu = __skb_dequeue(msdu_list))) {
 		ret = ath11k_dp_rx_process_msdu(ar, msdu, msdu_list);
 		if (ret) {
 			ath11k_dbg(ab, ATH11K_DBG_DATA,
@@ -2571,7 +2569,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	struct ath11k_dp *dp = &ab->dp;
 	struct dp_rxdma_ring *rx_ring;
 	int num_buffs_reaped[MAX_RADIOS] = {0};
-	struct sk_buff_head msdu_list;
+	struct sk_buff_head msdu_list[MAX_RADIOS];
 	struct ath11k_skb_rxcb *rxcb;
 	int total_msdu_reaped = 0;
 	struct hal_srng *srng;
@@ -2580,10 +2578,13 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	bool done = false;
 	int buf_id, mac_id;
 	struct ath11k *ar;
-	u32 *rx_desc;
+	struct hal_reo_dest_ring *desc;
+	enum hal_reo_dest_ring_push_reason push_reason;
+	u32 cookie;
 	int i;
 
-	__skb_queue_head_init(&msdu_list);
+	for (i = 0; i < MAX_RADIOS; i++)
+		__skb_queue_head_init(&msdu_list[i]);
 
 	srng = &ab->hal.srng_list[dp->reo_dst_ring[ring_id].ring_id];
 
@@ -2592,13 +2593,11 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	ath11k_hal_srng_access_begin(ab, srng);
 
 try_again:
-	while ((rx_desc = ath11k_hal_srng_dst_get_next_entry(ab, srng))) {
-		struct hal_reo_dest_ring desc = *(struct hal_reo_dest_ring *)rx_desc;
-		enum hal_reo_dest_ring_push_reason push_reason;
-		u32 cookie;
-
+	while (likely(desc =
+	      (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_entry(ab,
+									     srng))) {
 		cookie = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
-				   desc.buf_addr_info.info1);
+				   desc->buf_addr_info.info1);
 		buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID,
 				   cookie);
 		mac_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_PDEV_ID, cookie);
@@ -2625,7 +2624,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		num_buffs_reaped[mac_id]++;
 
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
-					desc.info0);
+					desc->info0);
 		if (push_reason !=
 		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
 			dev_kfree_skb_any(msdu);
@@ -2633,17 +2632,17 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 			continue;
 		}
 
-		rxcb->is_first_msdu = !!(desc.rx_msdu_info.info0 &
+		rxcb->is_first_msdu = !!(desc->rx_msdu_info.info0 &
 					 RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU);
-		rxcb->is_last_msdu = !!(desc.rx_msdu_info.info0 &
+		rxcb->is_last_msdu = !!(desc->rx_msdu_info.info0 &
 					RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU);
-		rxcb->is_continuation = !!(desc.rx_msdu_info.info0 &
+		rxcb->is_continuation = !!(desc->rx_msdu_info.info0 &
 					   RX_MSDU_DESC_INFO0_MSDU_CONTINUATION);
 		rxcb->mac_id = mac_id;
 		rxcb->tid = FIELD_GET(HAL_REO_DEST_RING_INFO0_RX_QUEUE_NUM,
-				      desc.info0);
+				      desc->info0);
 
-		__skb_queue_tail(&msdu_list, msdu);
+		__skb_queue_tail(&msdu_list[mac_id], msdu);
 
 		if (rxcb->is_continuation) {
 			done = false;
@@ -2678,16 +2677,15 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		if (!num_buffs_reaped[i])
 			continue;
 
+		ath11k_dp_rx_process_received_packets(ab, napi, &msdu_list[i],
+						      &quota, i);
+
 		ar = ab->pdevs[i].ar;
 		rx_ring = &ar->dp.rx_refill_buf_ring;
 
 		ath11k_dp_rxbufs_replenish(ab, i, rx_ring, num_buffs_reaped[i],
 					   HAL_RX_BUF_RBM_SW3_BM);
 	}
-
-	ath11k_dp_rx_process_received_packets(ab, napi, &msdu_list,
-					      &quota, ring_id);
-
 exit:
 	return budget - quota;
 }
-- 
2.7.4

