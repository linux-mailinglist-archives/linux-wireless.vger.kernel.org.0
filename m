Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB1CD10B0E1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 15:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfK0OIy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 09:08:54 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:57714
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726603AbfK0OIx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 09:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574863733;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=qsoBcCpSXIPRMWVBNr77qSnpbKOuIcZeG/v5nt7/43s=;
        b=HYFh/IcnlCjY9oDlFsfYFExjI6ltIU55Lr3YZ6Z8skT47P5wdtSwy6OF3lmC0N9Q
        G/i+BrOwLZJwGxsOPMAYB/BAjhi+xEVKH4yRadk8LA6nhChl6mbBmzEIaQ6TdUlxWcO
        lGqFtVbInMIgNFQ/1XTGTtNLLCYBahNEwgArUurw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574863733;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=qsoBcCpSXIPRMWVBNr77qSnpbKOuIcZeG/v5nt7/43s=;
        b=OqyZkbug5RWpIDWG2zLVxO4IIfJAgJuOQnGXtByvOYJmFr9KrHMiu6hYM488spFX
        8NsOxK3iVSrpp5ynzset+DRezWrqRi41KPrM4rD0/QSl8Vpo2IVQ1s3kInoq30IjQT8
        aL2TQNQmfWr/o0QbNKI7+L/d8r7nlMGB5s/mH9pQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 604F4C36E70
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 06/10] ath11k: avoid use_after_free in ath11k_dp_rx_msdu_coalesce API
Date:   Wed, 27 Nov 2019 14:08:53 +0000
Message-ID: <0101016ead318147-651b8fe0-6d5e-48aa-a998-8548e87c91c6-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
References: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.27-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

Accessing already stored first msdu data after the skb expand trigger
use_after_free, since first msdu got deleted. so do the descriptor copy
operation before the skb expand operation.

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 67efa247bf65..f87bd327b082 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1376,6 +1376,11 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
 	skb_put(first, DP_RX_BUFFER_SIZE);
 	skb_pull(first, buf_first_hdr_len);
 
+	/* When an MSDU spread over multiple buffers attention, MSDU_END and
+	 * MPDU_END tlvs are valid only in the last buffer. Copy those tlvs.
+	 */
+	ath11k_dp_rx_desc_end_tlv_copy(rxcb->rx_desc, ldesc);
+
 	space_extra = msdu_len - (buf_first_len + skb_tailroom(first));
 	if (space_extra > 0 &&
 	    (pskb_expand_head(first, 0, space_extra, GFP_ATOMIC) < 0)) {
@@ -1391,11 +1396,6 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
 		return -ENOMEM;
 	}
 
-	/* When an MSDU spread over multiple buffers attention, MSDU_END and
-	 * MPDU_END tlvs are valid only in the last buffer. Copy those tlvs.
-	 */
-	ath11k_dp_rx_desc_end_tlv_copy(rxcb->rx_desc, ldesc);
-
 	rem_len = msdu_len - buf_first_len;
 	while ((skb = __skb_dequeue(msdu_list)) != NULL && rem_len > 0) {
 		rxcb = ATH11K_SKB_RXCB(skb);
-- 
2.7.4

