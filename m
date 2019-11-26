Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86231109CBA
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 12:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfKZLE5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 06:04:57 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:49660
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727897AbfKZLE4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 06:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574766295;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=jkynW/q2+cFWecq3LsTGopGApzaLezmtVoJv+R+3Zl8=;
        b=eFZhEQr9XQe4EkJqZ8a8vv4MffFmheM/d9kF52/BTVqqa0MINX9wcy928OKisYIG
        CpRzQjynRKAmJ21+PnAg1dIrFoDUtW2MoMm4ybm+CJi8f5JLvLuv6rLwaERC9/LDd1a
        m8pLyQVrZjMSSOGxBLHbZmyEB8vXHcjMt44IlmYA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574766295;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=jkynW/q2+cFWecq3LsTGopGApzaLezmtVoJv+R+3Zl8=;
        b=BLTMFpRCjvJPmYcFvuqrFkOlclMHUhaw01PwNhMesjtF16mI8KursL0laYJoOnFh
        VeDevESWrdW4ihebEH/KoK4ZUVUuFI04wDZmwRnnAZTsRwrNbxukg9opR+lE+Bf2ygf
        1AriOyakswRGi08axN3F/y6yKMgOUrjdYjB04Aws=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABC89C48B03
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 07/10] ath11k: remove unused tx ring counters
Date:   Tue, 26 Nov 2019 11:04:55 +0000
Message-ID: <0101016ea762b952-f1141b05-ce6b-4329-aa05-d3a4cd8ea911-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
References: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.26-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

remove unused counter to avoid taking locks inorder to optimize
cpu load.

Using Flamegraph, cpu usage of ath11k_dp_tx() observed to be decreased
from 5.58% to 3.74% with iperf traffic running with 80MHz bandwidth ap
mode.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.h    | 1 -
 drivers/net/wireless/ath/ath11k/dp_tx.c | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index eb0f3df131c5..db216f055c42 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -63,7 +63,6 @@ struct dp_tx_ring {
 	struct dp_srng tcl_data_ring;
 	struct dp_srng tcl_comp_ring;
 	struct idr txbuf_idr;
-	u32 num_tx_pending;
 	/* Protects txbuf_idr and num_pending */
 	spinlock_t tx_idr_lock;
 	DECLARE_KFIFO_PTR(tx_status_fifo, struct hal_wbm_release_ring);
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 51a02b8e66cc..a8b9557c2346 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -196,10 +196,6 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 
 	spin_unlock_bh(&tcl_ring->lock);
 
-	spin_lock_bh(&tx_ring->tx_idr_lock);
-	tx_ring->num_tx_pending++;
-	spin_unlock_bh(&tx_ring->tx_idr_lock);
-
 	atomic_inc(&ar->dp.num_tx_pending);
 
 	return 0;
@@ -236,7 +232,6 @@ static void ath11k_dp_tx_free_txbuf(struct ath11k_base *ab, u8 mac_id,
 	skb_cb = ATH11K_SKB_CB(msdu);
 
 	idr_remove(&tx_ring->txbuf_idr, msdu_id);
-	tx_ring->num_tx_pending--;
 	spin_unlock_bh(&tx_ring->tx_idr_lock);
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
@@ -272,7 +267,6 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 	ar = skb_cb->ar;
 
 	idr_remove(&tx_ring->txbuf_idr, ts->msdu_id);
-	tx_ring->num_tx_pending--;
 	spin_unlock_bh(&tx_ring->tx_idr_lock);
 
 	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
@@ -495,7 +489,6 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 			continue;
 		}
 		idr_remove(&tx_ring->txbuf_idr, msdu_id);
-		tx_ring->num_tx_pending--;
 		spin_unlock_bh(&tx_ring->tx_idr_lock);
 
 		ar = ab->pdevs[mac_id].ar;
-- 
2.7.4

