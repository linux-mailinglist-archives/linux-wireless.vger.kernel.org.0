Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1DD28ED2D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Oct 2020 08:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgJOGr7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Oct 2020 02:47:59 -0400
Received: from z5.mailgun.us ([104.130.96.5]:10248 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgJOGr7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Oct 2020 02:47:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602744478; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=qdkZYXu0Oe8Z9NOSyB9wSdJ0H/skMi6D76gjhV5M+SY=; b=e6FE/PLMcTwP7QhMynTA1xG8Psa1kqyqtdjz1gY7IkfLF6pFx5l88GXi4Zmt+HxT8h8hxJDO
 SloWhkcUpw3WscPH/J4OIcbL4ucIrtxs+E6VhDAAQKZYfZttrFFFSuxGFfqrjaRQIU3IO42k
 OBielfm5WHrCjSyl4HXv40e9itM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f87f090e9e942744c35b1cb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Oct 2020 06:47:44
 GMT
Sender: vthiagar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2655FC433F1; Thu, 15 Oct 2020 06:47:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from CHECSTEX0180100-LIN.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vthiagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9B24C433CB;
        Thu, 15 Oct 2020 06:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9B24C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vthiagar@codeaurora.org
From:   Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: Remove unnecessary data sync to cpu on monitor buffer
Date:   Thu, 15 Oct 2020 12:17:34 +0530
Message-Id: <1602744454-22969-1-git-send-email-vthiagar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Monitor ring Rx buffer is not really modified between dma map
and unmap. So remove the unnecssary data sync before dma unmap.
This does not fix any visible issue, found in code review.

Compile tested only.

Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 0162532..4455e5af 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2856,10 +2856,6 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 
 			rxcb = ATH11K_SKB_RXCB(skb);
 
-			dma_sync_single_for_cpu(ab->dev, rxcb->paddr,
-						skb->len + skb_tailroom(skb),
-						DMA_FROM_DEVICE);
-
 			dma_unmap_single(ab->dev, rxcb->paddr,
 					 skb->len + skb_tailroom(skb),
 					 DMA_BIDIRECTIONAL);
-- 
2.7.4

