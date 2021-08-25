Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F5B3F7204
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Aug 2021 11:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbhHYJkA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 05:40:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14298 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbhHYJj5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 05:39:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629884352; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Wop+K36uB00RQ8N8wL7zesMhmTejxin3L+U++FK+EC0=; b=F9ei/vV6hMxtTHrUN2HtcwPh0XylPkuuqK9qwPqONgYcJGTZ4+JzaJIEfVcvNsSi8t9SBOT5
 /SZGEQL0tePgsNQZoEOu7gTOQwxo0iJUprss/axpnMzx5J7m3RyIfW5j8a/fycBpIXnfLiVV
 lrLAhaCZjMpJPK5YP3fFUbgxV0M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61260fb81567234b8cbd5b33 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 09:39:04
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0968CC43616; Wed, 25 Aug 2021 09:39:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5805DC4361A;
        Wed, 25 Aug 2021 09:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5805DC4361A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH v2 07/12] ath11k: add branch predictors in process_rx
Date:   Wed, 25 Aug 2021 15:07:52 +0530
Message-Id: <1629884277-18759-8-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org>
References: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In datapath, add branch predictors where required in the process rx().
This protects high value rx path without having performance overhead.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index e105bdc..5d805881 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2535,13 +2535,13 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 	rcu_read_lock();
 
 	ar = ab->pdevs[mac_id].ar;
-	if (!rcu_dereference(ab->pdevs_active[mac_id])) {
+	if (unlikely(!rcu_dereference(ab->pdevs_active[mac_id]))) {
 		__skb_queue_purge(msdu_list);
 		rcu_read_unlock();
 		return;
 	}
 
-	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
+	if (unlikely(test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags))) {
 		__skb_queue_purge(msdu_list);
 		rcu_read_unlock();
 		return;
@@ -2549,7 +2549,7 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 
 	while ((msdu = __skb_dequeue(msdu_list))) {
 		ret = ath11k_dp_rx_process_msdu(ar, msdu, msdu_list);
-		if (ret) {
+		if (unlikely(ret)) {
 			ath11k_dbg(ab, ATH11K_DBG_DATA,
 				   "Unable to process msdu %d", ret);
 			dev_kfree_skb_any(msdu);
@@ -2604,7 +2604,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		rx_ring = &ar->dp.rx_refill_buf_ring;
 		spin_lock_bh(&rx_ring->idr_lock);
 		msdu = idr_find(&rx_ring->bufs_idr, buf_id);
-		if (!msdu) {
+		if (unlikely(!msdu)) {
 			ath11k_warn(ab, "frame rx with invalid buf_id %d\n",
 				    buf_id);
 			spin_unlock_bh(&rx_ring->idr_lock);
@@ -2623,8 +2623,8 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
 					desc->info0);
-		if (push_reason !=
-		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
+		if (unlikely(push_reason !=
+			     HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION)) {
 			dev_kfree_skb_any(msdu);
 			ab->soc_stats.hal_reo_error[dp->reo_dst_ring[ring_id].ring_id]++;
 			continue;
@@ -2659,7 +2659,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	 * head pointer so that we can reap complete MPDU in the current
 	 * rx processing.
 	 */
-	if (!done && ath11k_hal_srng_dst_num_free(ab, srng, true)) {
+	if (unlikely(!done && ath11k_hal_srng_dst_num_free(ab, srng, true))) {
 		ath11k_hal_srng_access_end(ab, srng);
 		goto try_again;
 	}
@@ -2668,7 +2668,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 	spin_unlock_bh(&srng->lock);
 
-	if (!total_msdu_reaped)
+	if (unlikely(!total_msdu_reaped))
 		goto exit;
 
 	for (i = 0; i < ab->num_radios; i++) {
-- 
2.7.4

