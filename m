Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1E771A311C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 10:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDIInu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 04:43:50 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:36473 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgDIInu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 04:43:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586421830; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=J0vtTaLnI0a7vOQ+fPkjj1FHDESnDO3rMcl8Hm4wfX8=; b=DNp7+s5FulXd8GsjcUPPCuyPq1kTbNCHiF+40H/0h9lBAIae6Ie51iLxqde7XotzfuUgKGuj
 i0r2DogfH/fihRRNpo+7QTm2eYMF1xgseT1yeeUVgLb1S02KciZmNCmuW/fx1xGNC9M6zeXY
 2ncKydaTY7l0xERxmoUV00fbghw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8ee032.7f4598998ab0-smtp-out-n02;
 Thu, 09 Apr 2020 08:43:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 679B5C433CB; Thu,  9 Apr 2020 08:43:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E051EC433D2;
        Thu,  9 Apr 2020 08:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E051EC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Subject: [PATCH] ath11k: rx path optimizations
Date:   Thu,  9 Apr 2020 14:13:17 +0530
Message-Id: <1586421797-885-1-git-send-email-mpubbise@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

During RX, accessing the reo dest ring descriptor directly is consuming
a lot of CPU cycles. Accessing the descriptor after copying it locally
has improved CPU usage by around ~10-15% while measuring throughput
in RX DBTC test cases(all radios are involved in the throughput
measurement).

HW tested: IPQ8074

Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index a3f2c76..203fd44 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2403,12 +2403,12 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 try_again:
 	while ((rx_desc = ath11k_hal_srng_dst_get_next_entry(ab, srng))) {
-		struct hal_reo_dest_ring *desc = (struct hal_reo_dest_ring *)rx_desc;
+		struct hal_reo_dest_ring desc = *(struct hal_reo_dest_ring *)rx_desc;
 		enum hal_reo_dest_ring_push_reason push_reason;
 		u32 cookie;
 
 		cookie = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
-				   desc->buf_addr_info.info1);
+				   desc.buf_addr_info.info1);
 		buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID,
 				   cookie);
 		mac_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_PDEV_ID, cookie);
@@ -2436,7 +2436,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		total_msdu_reaped++;
 
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
-					desc->info0);
+					desc.info0);
 		if (push_reason !=
 		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
 			dev_kfree_skb_any(msdu);
@@ -2444,15 +2444,15 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 			continue;
 		}
 
-		rxcb->is_first_msdu = !!(desc->rx_msdu_info.info0 &
+		rxcb->is_first_msdu = !!(desc.rx_msdu_info.info0 &
 					 RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU);
-		rxcb->is_last_msdu = !!(desc->rx_msdu_info.info0 &
+		rxcb->is_last_msdu = !!(desc.rx_msdu_info.info0 &
 					RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU);
-		rxcb->is_continuation = !!(desc->rx_msdu_info.info0 &
+		rxcb->is_continuation = !!(desc.rx_msdu_info.info0 &
 					   RX_MSDU_DESC_INFO0_MSDU_CONTINUATION);
 		rxcb->mac_id = mac_id;
 		rxcb->tid = FIELD_GET(HAL_REO_DEST_RING_INFO0_RX_QUEUE_NUM,
-				      desc->info0);
+				      desc.info0);
 
 		__skb_queue_tail(&msdu_list, msdu);
 
-- 
2.7.4
