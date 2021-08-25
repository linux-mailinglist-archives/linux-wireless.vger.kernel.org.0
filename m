Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A1F3F7208
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Aug 2021 11:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbhHYJkJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 05:40:09 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14298 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbhHYJkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 05:40:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629884363; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=rRhc9UiQlQEzgehQC70OG6a+Apmw4TczCeFXF3SHDLM=; b=LuVkUUfSKlAmr7cl9fOenza/BPdiFxJguPA6uqNRRcz7FsCdoYDY56FbC14/zc+DblZ/b4xD
 V6oOUoNQUXxPtrug3Otbyos1d5cbCVY1TCcMEeyoMsYCUSiJ+y9jKRRr/DPtuVKyvpN4k/gN
 aCj9TQDBijeBYBpM2AUonGU76Xw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 61260fc64cd90150372c67cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 09:39:18
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C462EC43616; Wed, 25 Aug 2021 09:39:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E40F1C43616;
        Wed, 25 Aug 2021 09:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E40F1C43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH v2 12/12] ath11k: avoid unnecessary lock contention in tx_completion path
Date:   Wed, 25 Aug 2021 15:07:57 +0530
Message-Id: <1629884277-18759-13-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org>
References: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid unnecessary idr_find calls before the idr_remove calls.
Because idr_remove gives the valid ptr if id is valid otherwise
return NULL ptr. So removed the idr_find before idr_remove in tx
completion path. Also no need to disable the bottom half preempt
if it is already in the bottom half context, so modify the
spin_lock_bh to spin_lock in the data tx completion path.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1 v2

Co-developed-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index ab9ccf0..3e0efad 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -288,20 +288,18 @@ static void ath11k_dp_tx_free_txbuf(struct ath11k_base *ab, u8 mac_id,
 	struct sk_buff *msdu;
 	struct ath11k_skb_cb *skb_cb;
 
-	spin_lock_bh(&tx_ring->tx_idr_lock);
-	msdu = idr_find(&tx_ring->txbuf_idr, msdu_id);
-	if (!msdu) {
+	spin_lock(&tx_ring->tx_idr_lock);
+	msdu = idr_remove(&tx_ring->txbuf_idr, msdu_id);
+	spin_unlock(&tx_ring->tx_idr_lock);
+
+	if (unlikely(!msdu)) {
 		ath11k_warn(ab, "tx completion for unknown msdu_id %d\n",
 			    msdu_id);
-		spin_unlock_bh(&tx_ring->tx_idr_lock);
 		return;
 	}
 
 	skb_cb = ATH11K_SKB_CB(msdu);
 
-	idr_remove(&tx_ring->txbuf_idr, msdu_id);
-	spin_unlock_bh(&tx_ring->tx_idr_lock);
-
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	dev_kfree_skb_any(msdu);
 
@@ -320,12 +318,13 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 	struct ath11k_skb_cb *skb_cb;
 	struct ath11k *ar;
 
-	spin_lock_bh(&tx_ring->tx_idr_lock);
-	msdu = idr_find(&tx_ring->txbuf_idr, ts->msdu_id);
+	spin_lock(&tx_ring->tx_idr_lock);
+	msdu = idr_remove(&tx_ring->txbuf_idr, ts->msdu_id);
+	spin_unlock(&tx_ring->tx_idr_lock);
+
 	if (unlikely(!msdu)) {
 		ath11k_warn(ab, "htt tx completion for unknown msdu_id %d\n",
 			    ts->msdu_id);
-		spin_unlock_bh(&tx_ring->tx_idr_lock);
 		return;
 	}
 
@@ -334,9 +333,6 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 
 	ar = skb_cb->ar;
 
-	idr_remove(&tx_ring->txbuf_idr, ts->msdu_id);
-	spin_unlock_bh(&tx_ring->tx_idr_lock);
-
 	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 		wake_up(&ar->dp.tx_empty_waitq);
 
@@ -584,16 +580,15 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 			continue;
 		}
 
-		spin_lock_bh(&tx_ring->tx_idr_lock);
-		msdu = idr_find(&tx_ring->txbuf_idr, msdu_id);
+		msdu = idr_remove(&tx_ring->txbuf_idr, msdu_id);
 		if (unlikely(!msdu)) {
 			ath11k_warn(ab, "tx completion for unknown msdu_id %d\n",
 				    msdu_id);
-			spin_unlock_bh(&tx_ring->tx_idr_lock);
+			spin_unlock(&tx_ring->tx_idr_lock);
 			continue;
 		}
-		idr_remove(&tx_ring->txbuf_idr, msdu_id);
-		spin_unlock_bh(&tx_ring->tx_idr_lock);
+
+		spin_unlock(&tx_ring->tx_idr_lock);
 
 		ar = ab->pdevs[mac_id].ar;
 
-- 
2.7.4

