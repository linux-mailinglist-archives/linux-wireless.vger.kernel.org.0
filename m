Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B323A8ADB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 23:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhFOVRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 17:17:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50752 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhFOVRC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 17:17:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623791697; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zIqQOZ4s7YOII1b8KU8ODDrMglqW4IFDBtoWvB5qoYI=; b=EJnu2/kJD56Zd1qUmFCOpO81+MwlxSfvBkV/2qcjhMfcjpL7Gbvyuul1vPwxBKnCUigWWIfX
 NF4FQPtORdIzL3q4KdjlNor1EiwdraRxhBeRsNp4HIpSPaHwWP3C+DcBn19pnkHGcFMzDU5E
 hkzcAigJt+tda5qgz8jKnMH2fPg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60c91846abfd22a3dcdc1400 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 21:14:46
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3ADFFC4338A; Tue, 15 Jun 2021 21:14:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-78-13-nat.elisa-mobile.fi [85.76.78.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE517C43145;
        Tue, 15 Jun 2021 21:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE517C43145
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 07/12] ath11k: add branch predictors in process_rx
Date:   Wed, 16 Jun 2021 00:14:02 +0300
Message-Id: <20210615211407.92233-8-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615211407.92233-1-jouni@codeaurora.org>
References: <20210615211407.92233-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: P Praneesh <ppranees@codeaurora.org>

In datapath, add branch predictors where required in the process rx().
This protects high value rx path without having performance overhead.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 3ece90d890e5..6e9338f1b4db 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2540,13 +2540,13 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
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
@@ -2554,7 +2554,7 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 
 	while ((msdu = __skb_dequeue(msdu_list))) {
 		ret = ath11k_dp_rx_process_msdu(ar, msdu, msdu_list);
-		if (ret) {
+		if (unlikely(ret)) {
 			ath11k_dbg(ab, ATH11K_DBG_DATA,
 				   "Unable to process msdu %d", ret);
 			dev_kfree_skb_any(msdu);
@@ -2609,7 +2609,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		rx_ring = &ar->dp.rx_refill_buf_ring;
 		spin_lock_bh(&rx_ring->idr_lock);
 		msdu = idr_find(&rx_ring->bufs_idr, buf_id);
-		if (!msdu) {
+		if (unlikely(!msdu)) {
 			ath11k_warn(ab, "frame rx with invalid buf_id %d\n",
 				    buf_id);
 			spin_unlock_bh(&rx_ring->idr_lock);
@@ -2628,8 +2628,8 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
 					desc->info0);
-		if (push_reason !=
-		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
+		if (unlikely(push_reason !=
+			     HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION)) {
 			dev_kfree_skb_any(msdu);
 			ab->soc_stats.hal_reo_error[dp->reo_dst_ring[ring_id].ring_id]++;
 			continue;
@@ -2664,7 +2664,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	 * head pointer so that we can reap complete MPDU in the current
 	 * rx processing.
 	 */
-	if (!done && ath11k_hal_srng_dst_num_free(ab, srng, true)) {
+	if (unlikely(!done && ath11k_hal_srng_dst_num_free(ab, srng, true))) {
 		ath11k_hal_srng_access_end(ab, srng);
 		goto try_again;
 	}
@@ -2673,7 +2673,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 	spin_unlock_bh(&srng->lock);
 
-	if (!total_msdu_reaped)
+	if (unlikely(!total_msdu_reaped))
 		goto exit;
 
 	for (i = 0; i < ab->num_radios; i++) {
-- 
2.25.1

