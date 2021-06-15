Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5D23A8ADF
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 23:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhFOVRW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 17:17:22 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19049 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhFOVRW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 17:17:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623791717; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=OJzxyJAbKjQ3t8h2kb3Qwx2K1ZliALJEeolpOxZGi/8=; b=Rnhpk8KKpI1OnNGBGO4gRIxL6rV4FR2U9BsgDtSGgA7jUYjUI0cjas13iz+gnmW1cR3FRyG2
 So3depO9K1PrbVt3xUzal9E7eiqkYFU7Qfbz6oBRtiB2IoTNwT/sZIA8NqCQTdkvuLLzJDSI
 DoxlkCIIX9huyl5McmDLu7m+uGs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60c9185551f29e6bae1dcc69 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 21:15:01
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A9695C43143; Tue, 15 Jun 2021 21:15:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-78-13-nat.elisa-mobile.fi [85.76.78.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 464AAC4338A;
        Tue, 15 Jun 2021 21:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 464AAC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 12/12] ath11k: avoid unnecessary lock contention in tx_completion path
Date:   Wed, 16 Jun 2021 00:14:07 +0300
Message-Id: <20210615211407.92233-13-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615211407.92233-1-jouni@codeaurora.org>
References: <20210615211407.92233-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: P Praneesh <ppranees@codeaurora.org>

Lock is not needed for the readable idr operation, so avoid spin_lock_bh
for the idr_find() call. No need to disable the bottom half preempt if
it is already in bottom half context, so modify the spin_lock_bh to
spin_lock in the data tx completion handler.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1 v2

Co-developed-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index ab9ccf0eb274..659f9d98bc0c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -288,19 +288,18 @@ static void ath11k_dp_tx_free_txbuf(struct ath11k_base *ab, u8 mac_id,
 	struct sk_buff *msdu;
 	struct ath11k_skb_cb *skb_cb;
 
-	spin_lock_bh(&tx_ring->tx_idr_lock);
 	msdu = idr_find(&tx_ring->txbuf_idr, msdu_id);
-	if (!msdu) {
+	if (unlikely(!msdu)) {
 		ath11k_warn(ab, "tx completion for unknown msdu_id %d\n",
 			    msdu_id);
-		spin_unlock_bh(&tx_ring->tx_idr_lock);
 		return;
 	}
 
 	skb_cb = ATH11K_SKB_CB(msdu);
 
+	spin_lock(&tx_ring->tx_idr_lock);
 	idr_remove(&tx_ring->txbuf_idr, msdu_id);
-	spin_unlock_bh(&tx_ring->tx_idr_lock);
+	spin_unlock(&tx_ring->tx_idr_lock);
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	dev_kfree_skb_any(msdu);
@@ -320,12 +319,10 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 	struct ath11k_skb_cb *skb_cb;
 	struct ath11k *ar;
 
-	spin_lock_bh(&tx_ring->tx_idr_lock);
 	msdu = idr_find(&tx_ring->txbuf_idr, ts->msdu_id);
 	if (unlikely(!msdu)) {
 		ath11k_warn(ab, "htt tx completion for unknown msdu_id %d\n",
 			    ts->msdu_id);
-		spin_unlock_bh(&tx_ring->tx_idr_lock);
 		return;
 	}
 
@@ -334,8 +331,9 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 
 	ar = skb_cb->ar;
 
+	spin_lock(&tx_ring->tx_idr_lock);
 	idr_remove(&tx_ring->txbuf_idr, ts->msdu_id);
-	spin_unlock_bh(&tx_ring->tx_idr_lock);
+	spin_unlock(&tx_ring->tx_idr_lock);
 
 	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 		wake_up(&ar->dp.tx_empty_waitq);
@@ -584,16 +582,16 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 			continue;
 		}
 
-		spin_lock_bh(&tx_ring->tx_idr_lock);
 		msdu = idr_find(&tx_ring->txbuf_idr, msdu_id);
 		if (unlikely(!msdu)) {
 			ath11k_warn(ab, "tx completion for unknown msdu_id %d\n",
 				    msdu_id);
-			spin_unlock_bh(&tx_ring->tx_idr_lock);
 			continue;
 		}
+
+		spin_lock(&tx_ring->tx_idr_lock);
 		idr_remove(&tx_ring->txbuf_idr, msdu_id);
-		spin_unlock_bh(&tx_ring->tx_idr_lock);
+		spin_unlock(&tx_ring->tx_idr_lock);
 
 		ar = ab->pdevs[mac_id].ar;
 
-- 
2.25.1

