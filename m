Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8276C08D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 00:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjHAWrT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 18:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjHAWrO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 18:47:14 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6311FF3;
        Tue,  1 Aug 2023 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1690930031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wjSNp+Fc9Jt5MpoNE1r7E2tP2kQ/WOKZT6GzBaVgttM=;
        b=lcy/qjy21U7uUH8ft3i6bvD8CxwKsT0RiNOeNR+shWQkcPAZqI0vH9Zdv6p42G2+huThrm
        sMf/gHIaHmEgjEKcqFqY8q74SQATnsScxxq2uFJ4CwVFr5V3za6fNddmAdGO5ol3qPaOlD
        y0Jb8ATZqKLKwE0cAqyCFkDXuGNo8gQ=
From:   Sven Eckelmann <sven@narfation.org>
Date:   Wed, 02 Aug 2023 00:46:27 +0200
Subject: [PATCH v2 2/2] ath11k: Cleanup mac80211 references on failure
 during tx_complete
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-ath11k-ack_status_leak-v2-2-c0af729d6229@narfation.org>
References: <20230802-ath11k-ack_status_leak-v2-0-c0af729d6229@narfation.org>
In-Reply-To: <20230802-ath11k-ack_status_leak-v2-0-c0af729d6229@narfation.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc:     Kalle Valo <quic_kvalo@quicinc.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Sven Eckelmann <sven@narfation.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741; i=sven@narfation.org;
 h=from:subject:message-id; bh=V0GmeAeeQt0aCXU2oj7g+5cgKTE+OL2dACM9u/oszNE=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkyYtPfA2Rq4V9mZUnkITk5Gm63v2GRPrKuBSv6
 6ajaM6q+F+JAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZMmLTwAKCRBdhwoHwSZ7
 RvadD/46pI0BWWi3m/aXoJQ8jAZK4ubVCvQ3WEWaNeq9m8r9Pc10Uy514F69GxAZCvlIuAPhNQv
 HXUw+Py6JuM+qXG4tuP5r2n41CAIP3NnP9uIQ9yw83QkL+qXaZoPqWVoFyDyV6RvmSLii1GdotF
 k5sCnHEQ4A6FGpMKSbEdzxVVIgJ6TzSGDYf8+BaCC3M6bWTyq9WbtZe3Yzuym4Nbjrs6KkxbnK/
 sDxmkDoGgAnlMtydM6MFVcxuuSLdVoHvwVOl1AtI+guVY8eQkuxiDxx0UBzG4HtpbkREVEW7Vjs
 QaubdsFrH+9A293KKPkDwR0dxNaGa17ODPQlG0HuWbqrYSCqKr9Lbr9I17dRMLUYj3pxbmwob60
 c8NoT3bHIPIP1izPfofUKysAaQQzYeFnsXxoc0D5gdUxK/l6B3zrxfT4jSm1QvzEjsickcE9qHQ
 786/m0jICjaZdnYr7gKqrr3csyq3OiC1Ammul0936X9jcYe88Tl1s6xEXXUlqirk/+b8kGxr6O6
 D+3xcGcGEcenMwn86Fo2Of3ZjQ7X6pM4kN8+yf83jQKkxZxQxR2/kRoVDEttKxbD6FgQcSiU2W3
 sqckPRQgLkTaDbTZELhZCyOi6a9dhqbkYQsF2MmHVL5rCJu7Sz8rMo9lqAIQgOwL+WXJDbdhrZe
 Kqk98ePOKEtqcjw==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When a function is using functions from mac80211 to free an skb then it
should do it consistently and not switch to the generic dev_kfree_skb_any
(or similar functions). Otherwise (like in the error handlers), mac80211
will will not be aware of the freed skb and thus not clean up related
information in its internal data structures.

Not doing so lead in the past to filled up structure which then prevented
new clients to connect.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Fixes: 6257c702264c ("wifi: ath11k: fix tx status reporting in encap offload mode")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 27c976f52c7a..b85a4a03b37a 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -344,7 +344,7 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
 	if (!skb_cb->vif) {
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ar->hw, msdu);
 		return;
 	}
 
@@ -566,12 +566,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
 	if (unlikely(!rcu_access_pointer(ab->pdevs_active[ar->pdev_idx]))) {
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ar->hw, msdu);
 		return;
 	}
 
 	if (unlikely(!skb_cb->vif)) {
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ar->hw, msdu);
 		return;
 	}
 

-- 
2.39.2

