Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68E03A8ADA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 23:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhFOVQ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 17:16:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40679 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231311AbhFOVQ6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 17:16:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623791693; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=APIe96SaKORI7Y6PqBm3GzPVE0x9agw1hDS5hS/Vd1M=; b=tI79U/OohSy+NE38E88auMocL/Y3tmI04QAbd38VPEfha/Zz/lPdsTPAtnPYA4Ek0+G6rlww
 tnKw7r1VXtBkXofyd1KUXTeiyXCaETA02NXzPhqtNAM/XBIpbcnzFR463p4KYmWK6RwsUWKH
 41r+Ts44VSZYx/DHbdqwbY0J/DU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60c91844abfd22a3dcdc0806 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 21:14:44
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BF599C43144; Tue, 15 Jun 2021 21:14:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-78-13-nat.elisa-mobile.fi [85.76.78.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC479C4338A;
        Tue, 15 Jun 2021 21:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC479C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 05/12] ath11k: avoid active pdev check for each msdu
Date:   Wed, 16 Jun 2021 00:14:00 +0300
Message-Id: <20210615211407.92233-6-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615211407.92233-1-jouni@codeaurora.org>
References: <20210615211407.92233-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: P Praneesh <ppranees@codeaurora.org>

The Active Pdev and CAC check are done for each msdu in
ath11k_dp_rx_process_received_packets which is a overhead.
To avoid this overhead, collect all msdus in a per mac msdu
list and pass to function.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 66 ++++++++++++-------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 54ab69959c98..5810110ff519 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2528,12 +2528,10 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
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
@@ -2541,20 +2539,20 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 
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
@@ -2576,7 +2574,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	struct ath11k_dp *dp = &ab->dp;
 	struct dp_rxdma_ring *rx_ring;
 	int num_buffs_reaped[MAX_RADIOS] = {0};
-	struct sk_buff_head msdu_list;
+	struct sk_buff_head msdu_list[MAX_RADIOS];
 	struct ath11k_skb_rxcb *rxcb;
 	int total_msdu_reaped = 0;
 	struct hal_srng *srng;
@@ -2585,10 +2583,13 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
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
 
@@ -2597,13 +2598,11 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
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
@@ -2630,7 +2629,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		num_buffs_reaped[mac_id]++;
 
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
-					desc.info0);
+					desc->info0);
 		if (push_reason !=
 		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
 			dev_kfree_skb_any(msdu);
@@ -2638,17 +2637,17 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
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
@@ -2683,16 +2682,15 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
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
2.25.1

