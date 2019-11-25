Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB52B1091F5
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 17:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfKYQg0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 11:36:26 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:58432
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728927AbfKYQgZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 11:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574699785;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=n+8oq4DnXCwqq2Dt8XDwM7lYH/RbHiCqrGoqJ9M/0fo=;
        b=H5bfvC01akCCwenlRCu6TOepnAYqeNrhE7pwJ8EdCF3oFFbcpkSX3n7cRie0Grmf
        FIgc2EhRNIbAqdno8S0s4Y04ZP1VWompzyvIuPguQXEsin8fYBt4MGfc5p5qPvBuP/k
        moccvvEtXp3INkazxvVuKo9ptbtA77mey1K3+Dtw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574699785;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=n+8oq4DnXCwqq2Dt8XDwM7lYH/RbHiCqrGoqJ9M/0fo=;
        b=Jim6xCLL055hVKs1fEJcDmkvt54GzWD/ZgS1kAeUnqcAbqXKak2Rfamy+seJwxCU
        sDsh29LxIoQQ0Nr6xAq0RaCAicbcvdBbL57PD2BN5LttJn4wPz7nkYiMAS6A6wKDEYC
        tYiMiHgQngS1jUT5xAC9mErbjOUiyQ+zFVk/5PuE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5057CC447AF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 5/8] ath11k: Remove dead code while handling amsdu packets
Date:   Mon, 25 Nov 2019 16:36:25 +0000
Message-ID: <0101016ea36bdc5d-226b45e9-87ca-49a2-9ed9-655159b3d626-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
References: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.25-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tamizh chelvam <tamizhr@codeaurora.org>

Remove unexecuted code while handling amsdu packets.
The same logic is done before calling ath11k_dp_rx_msdu_coalesce

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 0ff0ff81adeb..7aade0314e61 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1349,12 +1349,6 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
 	int rem_len;
 	int buf_len;
 
-	if (!rxcb->is_continuation) {
-		skb_put(first, HAL_RX_DESC_SIZE + l3pad_bytes + msdu_len);
-		skb_pull(first, HAL_RX_DESC_SIZE + l3pad_bytes);
-		return 0;
-	}
-
 	if (WARN_ON_ONCE(msdu_len <= (DP_RX_BUFFER_SIZE -
 			 (HAL_RX_DESC_SIZE + l3pad_bytes)))) {
 		skb_put(first, HAL_RX_DESC_SIZE + l3pad_bytes + msdu_len);
-- 
2.7.4

