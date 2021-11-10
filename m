Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090E144C4F6
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 17:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhKJQYb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 11:24:31 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:22726 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbhKJQYa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 11:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636561303; x=1668097303;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=yGMS5MC/wpZ6wEgWJkC5EdriNiGXW4Sd1OxBytFB5Go=;
  b=IvUTNjqCSe+YLsiyqfeNA3FLHTmCNQLa4GZ5NxAzJ8fYuI1h1Beo1hgu
   RNvMDcUenTBL3nB44/5VRZ58twyOLD6vhHMDjc8QG9Erwo7TdMh/fN26g
   b527xak2KvPkfndyp4fUIZXkx7oKrTyw3M2ChdZmsKvSGIbcgBhFZyiBg
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Nov 2021 08:21:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 08:21:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 08:21:42 -0800
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 08:21:40 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH] ath11k: fix DMA memory free in CE pipe cleanup
Date:   Wed, 10 Nov 2021 21:51:30 +0530
Message-ID: <1636561290-18966-1-git-send-email-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In CE pipe cleanup, DMA memory gets freed by the aligned address
(base_addr_owner_space) which is wrong. It needs to be freed
by the address (base_addr_owner_space_unaligned) returned by
dma_alloc. So free the dma memory by the proper address.
This was found in code review.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00729-QCAHKSWPL_SILICONZ-3 v2

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ce.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index de8b632..4249c2e 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -953,6 +953,7 @@ int ath11k_ce_init_pipes(struct ath11k_base *ab)
 void ath11k_ce_free_pipes(struct ath11k_base *ab)
 {
 	struct ath11k_ce_pipe *pipe;
+	struct ath11k_ce_ring *ce_ring;
 	int desc_sz;
 	int i;
 
@@ -964,22 +965,24 @@ void ath11k_ce_free_pipes(struct ath11k_base *ab)
 
 		if (pipe->src_ring) {
 			desc_sz = ath11k_hal_ce_get_desc_size(HAL_CE_DESC_SRC);
+			ce_ring = pipe->src_ring;
 			dma_free_coherent(ab->dev,
 					  pipe->src_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
-					  pipe->src_ring->base_addr_owner_space,
-					  pipe->src_ring->base_addr_ce_space);
+					  ce_ring->base_addr_owner_space_unaligned,
+					  ce_ring->base_addr_ce_space_unaligned);
 			kfree(pipe->src_ring);
 			pipe->src_ring = NULL;
 		}
 
 		if (pipe->dest_ring) {
 			desc_sz = ath11k_hal_ce_get_desc_size(HAL_CE_DESC_DST);
+			ce_ring = pipe->dest_ring;
 			dma_free_coherent(ab->dev,
 					  pipe->dest_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
-					  pipe->dest_ring->base_addr_owner_space,
-					  pipe->dest_ring->base_addr_ce_space);
+					  ce_ring->base_addr_owner_space_unaligned,
+					  ce_ring->base_addr_ce_space_unaligned);
 			kfree(pipe->dest_ring);
 			pipe->dest_ring = NULL;
 		}
@@ -987,11 +990,12 @@ void ath11k_ce_free_pipes(struct ath11k_base *ab)
 		if (pipe->status_ring) {
 			desc_sz =
 			  ath11k_hal_ce_get_desc_size(HAL_CE_DESC_DST_STATUS);
+			ce_ring = pipe->status_ring;
 			dma_free_coherent(ab->dev,
 					  pipe->status_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
-					  pipe->status_ring->base_addr_owner_space,
-					  pipe->status_ring->base_addr_ce_space);
+					  ce_ring->base_addr_owner_space_unaligned,
+					  ce_ring->base_addr_ce_space_unaligned);
 			kfree(pipe->status_ring);
 			pipe->status_ring = NULL;
 		}
-- 
2.7.4

