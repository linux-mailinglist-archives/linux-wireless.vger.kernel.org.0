Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F873FE8C2
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Sep 2021 07:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhIBFgK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Sep 2021 01:36:10 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57414 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232203AbhIBFgJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Sep 2021 01:36:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630560912; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Pk11lce8PhTeY2FsTpUbO7vYjNiU+ABGJ/b2pZPGhjI=; b=eg8PFJJf+ZlU0gyfNepbrg8Rl4dL9XjBjWGz6naLNCcHcqW4FaCGyLf9cZdW/UI/gE32XwCu
 107rym686+6lzrHxmSgX+V+qOHWMkSpYUi5FdcrQIjIxiYZnKate1mSIqnpPQnjjBYfylhO8
 6KaVUpyhOmS63U2dVuY59Zmur1A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61306283d15f4d68a22bac20 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Sep 2021 05:34:59
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1CF2BC4360C; Thu,  2 Sep 2021 05:34:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 378EAC4360C;
        Thu,  2 Sep 2021 05:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 378EAC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH v3 07/12] ath11k: add branch predictors in process_rx
Date:   Thu,  2 Sep 2021 11:03:35 +0530
Message-Id: <1630560820-21905-8-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org>
References: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In datapath, add branch predictors where required in the process rx().
This protects high value rx path without having performance overhead.
Also while processing rx packets, the pointer that is returned by
rcu_dereference() is not dereferenced. so it is preferable to use
rcu_access_pointer() here.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index e105bdc..a362615 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2532,24 +2532,20 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 	if (skb_queue_empty(msdu_list))
 		return;
 
-	rcu_read_lock();
-
-	ar = ab->pdevs[mac_id].ar;
-	if (!rcu_dereference(ab->pdevs_active[mac_id])) {
+	if (unlikely(!rcu_access_pointer(ab->pdevs_active[mac_id]))) {
 		__skb_queue_purge(msdu_list);
-		rcu_read_unlock();
 		return;
 	}
 
-	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
+	ar = ab->pdevs[mac_id].ar;
+	if (unlikely(test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags))) {
 		__skb_queue_purge(msdu_list);
-		rcu_read_unlock();
 		return;
 	}
 
 	while ((msdu = __skb_dequeue(msdu_list))) {
 		ret = ath11k_dp_rx_process_msdu(ar, msdu, msdu_list);
-		if (ret) {
+		if (unlikely(ret)) {
 			ath11k_dbg(ab, ATH11K_DBG_DATA,
 				   "Unable to process msdu %d", ret);
 			dev_kfree_skb_any(msdu);
@@ -2558,8 +2554,6 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 
 		ath11k_dp_rx_deliver_msdu(ar, napi, msdu);
 	}
-
-	rcu_read_unlock();
 }
 
 int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
@@ -2604,7 +2598,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		rx_ring = &ar->dp.rx_refill_buf_ring;
 		spin_lock_bh(&rx_ring->idr_lock);
 		msdu = idr_find(&rx_ring->bufs_idr, buf_id);
-		if (!msdu) {
+		if (unlikely(!msdu)) {
 			ath11k_warn(ab, "frame rx with invalid buf_id %d\n",
 				    buf_id);
 			spin_unlock_bh(&rx_ring->idr_lock);
@@ -2623,8 +2617,8 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
 					desc->info0);
-		if (push_reason !=
-		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
+		if (unlikely(push_reason !=
+			     HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION)) {
 			dev_kfree_skb_any(msdu);
 			ab->soc_stats.hal_reo_error[dp->reo_dst_ring[ring_id].ring_id]++;
 			continue;
@@ -2659,7 +2653,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	 * head pointer so that we can reap complete MPDU in the current
 	 * rx processing.
 	 */
-	if (!done && ath11k_hal_srng_dst_num_free(ab, srng, true)) {
+	if (unlikely(!done && ath11k_hal_srng_dst_num_free(ab, srng, true))) {
 		ath11k_hal_srng_access_end(ab, srng);
 		goto try_again;
 	}
@@ -2668,7 +2662,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 	spin_unlock_bh(&srng->lock);
 
-	if (!total_msdu_reaped)
+	if (unlikely(!total_msdu_reaped))
 		goto exit;
 
 	for (i = 0; i < ab->num_radios; i++) {
-- 
2.7.4

