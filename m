Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A88798D52
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 20:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344297AbjIHSVS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Sep 2023 14:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344088AbjIHST4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Sep 2023 14:19:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E52D4F;
        Fri,  8 Sep 2023 11:18:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CFCC116A6;
        Fri,  8 Sep 2023 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197047;
        bh=kPzyhGpLgYOWktsL2OvjuWdZRDytUuhx+35KEFmIYus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q50RXMX/3CNt/mCrvswG/RKmtYFLhhrSOb163E7LjbGz02Eqj29u9fzoopT8UN63L
         n5M7RnWBcnL53kD9BqS0tSd+83mCPuBIEPU5eEYDFcpo6Npd3wkVvoDxsxOUOb/h6y
         S7UmBukIRNGWOSumcyI+5LrSI11LBZ4uLOADj7GQrMg2yoiPUo6vHDeIdVgRC5cKvZ
         FtsAGKsUr4PtjreUa8A+H+BKPcFHzyrHwW89godobMvSDFVvY0kAggvfCspysxx8q/
         NSB1X6n1oAlq8D6P+fAbhIQJ0DLGB4JwHlqcCIHEDQjLzuLEmVmS8Kw+KN0M6ViHkA
         mgUb1UlumEoLQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rajat Soni <quic_rajson@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        quic_jjohnson@quicinc.com, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 36/41] wifi: ath12k: Fix memory leak in rx_desc and tx_desc
Date:   Fri,  8 Sep 2023 14:15:50 -0400
Message-Id: <20230908181555.3459640-36-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rajat Soni <quic_rajson@quicinc.com>

[ Upstream commit afb522b36e76acaa9f8fc06d0a9742d841c47c16 ]

Currently when ath12k_dp_cc_desc_init() is called we allocate
memory to rx_descs and tx_descs. In ath12k_dp_cc_cleanup(), during
descriptor cleanup rx_descs and tx_descs memory is not freed.

This is cause of memory leak. These allocated memory should be
freed in ath12k_dp_cc_cleanup.

In ath12k_dp_cc_desc_init(), we can save base address of rx_descs
and tx_descs. In ath12k_dp_cc_cleanup(), we can free rx_descs and
tx_descs memory using their base address.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230718053510.30894-1-quic_rajson@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp.c | 30 +++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/dp.h |  2 ++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index ae1645d0f42a2..f933896f2a68d 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1129,6 +1129,7 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 	struct ath12k_dp *dp = &ab->dp;
 	struct sk_buff *skb;
 	int i;
+	u32 pool_id, tx_spt_page;
 
 	if (!dp->spt_info)
 		return;
@@ -1148,6 +1149,14 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 		dev_kfree_skb_any(skb);
 	}
 
+	for (i = 0; i < ATH12K_NUM_RX_SPT_PAGES; i++) {
+		if (!dp->spt_info->rxbaddr[i])
+			continue;
+
+		kfree(dp->spt_info->rxbaddr[i]);
+		dp->spt_info->rxbaddr[i] = NULL;
+	}
+
 	spin_unlock_bh(&dp->rx_desc_lock);
 
 	/* TX Descriptor cleanup */
@@ -1170,6 +1179,21 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 		spin_unlock_bh(&dp->tx_desc_lock[i]);
 	}
 
+	for (pool_id = 0; pool_id < ATH12K_HW_MAX_QUEUES; pool_id++) {
+		spin_lock_bh(&dp->tx_desc_lock[pool_id]);
+
+		for (i = 0; i < ATH12K_TX_SPT_PAGES_PER_POOL; i++) {
+			tx_spt_page = i + pool_id * ATH12K_TX_SPT_PAGES_PER_POOL;
+			if (!dp->spt_info->txbaddr[tx_spt_page])
+				continue;
+
+			kfree(dp->spt_info->txbaddr[tx_spt_page]);
+			dp->spt_info->txbaddr[tx_spt_page] = NULL;
+		}
+
+		spin_unlock_bh(&dp->tx_desc_lock[pool_id]);
+	}
+
 	/* unmap SPT pages */
 	for (i = 0; i < dp->num_spt_pages; i++) {
 		if (!dp->spt_info[i].vaddr)
@@ -1343,6 +1367,8 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 			return -ENOMEM;
 		}
 
+		dp->spt_info->rxbaddr[i] = &rx_descs[0];
+
 		for (j = 0; j < ATH12K_MAX_SPT_ENTRIES; j++) {
 			rx_descs[j].cookie = ath12k_dp_cc_cookie_gen(i, j);
 			rx_descs[j].magic = ATH12K_DP_RX_DESC_MAGIC;
@@ -1368,8 +1394,10 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
 				return -ENOMEM;
 			}
 
+			tx_spt_page = i + pool_id * ATH12K_TX_SPT_PAGES_PER_POOL;
+			dp->spt_info->txbaddr[tx_spt_page] = &tx_descs[0];
+
 			for (j = 0; j < ATH12K_MAX_SPT_ENTRIES; j++) {
-				tx_spt_page = i + pool_id * ATH12K_TX_SPT_PAGES_PER_POOL;
 				ppt_idx = ATH12K_NUM_RX_SPT_PAGES + tx_spt_page;
 				tx_descs[j].desc_id = ath12k_dp_cc_cookie_gen(ppt_idx, j);
 				tx_descs[j].pool_id = pool_id;
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 7c5dafce5a68d..9aeda0321cd75 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -289,6 +289,8 @@ struct ath12k_tx_desc_info {
 struct ath12k_spt_info {
 	dma_addr_t paddr;
 	u64 *vaddr;
+	struct ath12k_rx_desc_info *rxbaddr[ATH12K_NUM_RX_SPT_PAGES];
+	struct ath12k_tx_desc_info *txbaddr[ATH12K_NUM_TX_SPT_PAGES];
 };
 
 struct ath12k_reo_queue_ref {
-- 
2.40.1

