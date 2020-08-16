Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30E4245623
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 07:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgHPFcI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 01:32:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63395 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730107AbgHPFcH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 01:32:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597555927; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=/nVRcdoQI6rM6pORNNY/nV4tX206WUXoBwK2u7O1/Kg=; b=liVuK2VRn1KlpL17ChVDuEB6OCaw52ps558adO8Ybm/hTdy8Gsl44hJcAV69ciLCUOWKZ+H4
 q0Q9ZZzS8LVj2mE1+F1EKR5PvtazkZ0ANxNeFEGHcrKiyAVPXc3mE0kxoiiAitKiHMoTPc6C
 PUuNCUHmQAsxndILl5XvmZAONvQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f38c4c1ba4c2cd367b6af14 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 05:31:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D633DC433CA; Sun, 16 Aug 2020 05:31:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFBA0C433C6;
        Sun, 16 Aug 2020 05:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFBA0C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 7/9] ath11k: process both lmac rings for QCA6390
Date:   Sun, 16 Aug 2020 08:31:29 +0300
Message-Id: <1597555891-26112-8-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
References: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For QCA6390, the num_radios is 1 but it needs to process 2 lmac rings.
So use NUM_RXDMA_PER_PDEV to do another loop.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.c | 59 +++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index fb82c4f75ced..b0ea5958833a 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -731,7 +731,7 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 	struct napi_struct *napi = &irq_grp->napi;
 	int grp_id = irq_grp->grp_id;
 	int work_done = 0;
-	int i = 0;
+	int i = 0, j;
 	int tot_work_done = 0;
 
 	while (ab->hw_params.ring_mask->tx[grp_id] >> i) {
@@ -770,17 +770,23 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 	}
 
 	if (ab->hw_params.ring_mask->rx_mon_status[grp_id]) {
-		for (i = 0; i <  ab->num_radios; i++) {
-			if (ab->hw_params.ring_mask->rx_mon_status[grp_id] & BIT(i)) {
-				work_done =
-				ath11k_dp_rx_process_mon_rings(ab,
-							       i, napi,
-							       budget);
-				budget -= work_done;
-				tot_work_done += work_done;
+		for (i = 0; i < ab->num_radios; i++) {
+			for (j = 0; j < ab->hw_params.num_rxmda_per_pdev; j++) {
+				int id = i * ab->hw_params.num_rxmda_per_pdev + j;
+
+				if (ab->hw_params.ring_mask->rx_mon_status[grp_id] &
+					BIT(id)) {
+					work_done =
+					ath11k_dp_rx_process_mon_rings(ab,
+								       id,
+								       napi, budget);
+					budget -= work_done;
+					tot_work_done += work_done;
+
+					if (budget <= 0)
+						goto done;
+				}
 			}
-			if (budget <= 0)
-				goto done;
 		}
 	}
 
@@ -788,22 +794,27 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 		ath11k_dp_process_reo_status(ab);
 
 	for (i = 0; i < ab->num_radios; i++) {
-		if (ab->hw_params.ring_mask->rxdma2host[grp_id] & BIT(i)) {
-			work_done = ath11k_dp_process_rxdma_err(ab, i, budget);
-			budget -= work_done;
-			tot_work_done += work_done;
-		}
+		for (j = 0; j < ab->hw_params.num_rxmda_per_pdev; j++) {
+			int id = i * ab->hw_params.num_rxmda_per_pdev + j;
 
-		if (budget <= 0)
-			goto done;
+			if (ab->hw_params.ring_mask->rxdma2host[grp_id] & BIT(id)) {
+				work_done = ath11k_dp_process_rxdma_err(ab, id, budget);
+				budget -= work_done;
+				tot_work_done += work_done;
+			}
 
-		if (ab->hw_params.ring_mask->host2rxdma[grp_id] & BIT(i)) {
-			struct ath11k_pdev_dp *dp = &ab->pdevs[i].ar->dp;
-			struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
+			if (budget <= 0)
+				goto done;
+
+			if (ab->hw_params.ring_mask->host2rxdma[grp_id] & BIT(id)) {
+				struct ath11k *ar = ath11k_ab_to_ar(ab, id);
+				struct ath11k_pdev_dp *dp = &ar->dp;
+				struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
 
-			ath11k_dp_rxbufs_replenish(ab, i, rx_ring, 0,
-						   HAL_RX_BUF_RBM_SW3_BM,
-						   GFP_ATOMIC);
+				ath11k_dp_rxbufs_replenish(ab, id, rx_ring, 0,
+							   HAL_RX_BUF_RBM_SW3_BM,
+							   GFP_ATOMIC);
+			}
 		}
 	}
 	/* TODO: Implement handler for other interrupts */
-- 
2.7.4

