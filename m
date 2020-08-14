Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D024454B
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 09:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgHNHLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 03:11:01 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:54912 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbgHNHKy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 03:10:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597389053; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=6C0aSv4KB9xlWJfK6OI+XrwdnLqo2FbbYakIbnIwRbI=; b=KcLxumjL8NoVXmTGcO6fSSdt3j/nRhVZC+a8IWeEr6grzg0fMI9JHEK81+nb+QVqN58a9PHA
 mtK7u4DUemfNey0Z1xGKEg+UGx+fLJXNiS8lviikwn9f1xWpH0wgnX36qokKtXR45gHSapnY
 UGGdRB+BOgvrKFR0X6KsfqAcvP4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5f3638fcd96d28d61eef4d49 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 07:10:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36D45C433C6; Fri, 14 Aug 2020 07:10:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 252A6C43391;
        Fri, 14 Aug 2020 07:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 252A6C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 11/11] ath11k: hal: create hw_srng_config dynamically
Date:   Fri, 14 Aug 2020 10:10:30 +0300
Message-Id: <1597389030-13887-12-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
References: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On QCA6390 reg_start and reg_size values are different from IPQ8074 so we need
to change the values runtime. As we can't modify a static const variable
hw_srng_config directly, instead use it as a template, copy it and modify the
copy with correct values.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dbring.c |   2 +-
 drivers/net/wireless/ath/ath11k/dp.c     |   8 +--
 drivers/net/wireless/ath/ath11k/dp_rx.c  |   4 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c  |   2 +-
 drivers/net/wireless/ath/ath11k/hal.c    | 119 +++++++++++++++++--------------
 drivers/net/wireless/ath/ath11k/hal.h    |   6 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c |   2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.c |   2 +-
 8 files changed, 79 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index cf20db370123..5e1f5437b418 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -168,7 +168,7 @@ int ath11k_dbring_buf_setup(struct ath11k *ar,
 
 	srng = &ab->hal.srng_list[ring->refill_srng.ring_id];
 	ring->bufs_max = ring->refill_srng.size /
-			 ath11k_hal_srng_get_entrysize(HAL_RXDMA_DIR_BUF);
+		ath11k_hal_srng_get_entrysize(ab, HAL_RXDMA_DIR_BUF);
 
 	ring->buf_sz = db_cap->min_buf_sz;
 	ring->buf_align = db_cap->min_buf_align;
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index d6a2fd5e641c..a3c4d36f850d 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -112,8 +112,8 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 			 int mac_id, int num_entries)
 {
 	struct hal_srng_params params = { 0 };
-	int entry_sz = ath11k_hal_srng_get_entrysize(type);
-	int max_entries = ath11k_hal_srng_get_max_entries(type);
+	int entry_sz = ath11k_hal_srng_get_entrysize(ab, type);
+	int max_entries = ath11k_hal_srng_get_max_entries(ab, type);
 	int ret;
 
 	if (max_entries < 0 || entry_sz < 0)
@@ -368,7 +368,7 @@ static int ath11k_dp_scatter_idle_link_desc_setup(struct ath11k_base *ab,
 	u32 end_offset;
 
 	n_entries_per_buf = HAL_WBM_IDLE_SCATTER_BUF_SIZE /
-			    ath11k_hal_srng_get_entrysize(HAL_WBM_IDLE_LINK);
+		ath11k_hal_srng_get_entrysize(ab, HAL_WBM_IDLE_LINK);
 	num_scatter_buf = DIV_ROUND_UP(size, HAL_WBM_IDLE_SCATTER_BUF_SIZE);
 
 	if (num_scatter_buf > DP_IDLE_SCATTER_BUFS_MAX)
@@ -566,7 +566,7 @@ int ath11k_dp_link_desc_setup(struct ath11k_base *ab,
 		return ret;
 
 	/* Setup link desc idle list for HW internal usage */
-	entry_sz = ath11k_hal_srng_get_entrysize(ring_type);
+	entry_sz = ath11k_hal_srng_get_entrysize(ab, ring_type);
 	tot_mem_sz = entry_sz * n_link_desc;
 
 	/* Setup scatter desc list when the total memory requirement is more */
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 5680b99a4f5c..66002de04aec 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -416,7 +416,7 @@ static int ath11k_dp_rxdma_ring_buf_setup(struct ath11k *ar,
 	int num_entries;
 
 	num_entries = rx_ring->refill_buf_ring.size /
-		      ath11k_hal_srng_get_entrysize(ringtype);
+		ath11k_hal_srng_get_entrysize(ar->ab, ringtype);
 
 	rx_ring->bufs_max = num_entries;
 	ath11k_dp_rxbufs_replenish(ar->ab, dp->mac_id, rx_ring, num_entries,
@@ -4834,7 +4834,7 @@ int ath11k_dp_rx_pdev_mon_attach(struct ath11k *ar)
 
 	dp_srng = &dp->rxdma_mon_desc_ring;
 	n_link_desc = dp_srng->size /
-		ath11k_hal_srng_get_entrysize(HAL_RXDMA_MONITOR_DESC);
+		ath11k_hal_srng_get_entrysize(ar->ab, HAL_RXDMA_MONITOR_DESC);
 	mon_desc_srng =
 		&ar->ab->hal.srng_list[dp->rxdma_mon_desc_ring.ring_id];
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 1af76775b1a8..b83b5176a5df 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -720,7 +720,7 @@ int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
 	cmd->ring_base_addr_hi = (u64)params.ring_base_paddr >>
 				 HAL_ADDR_MSB_REG_SHIFT;
 
-	ret = ath11k_hal_srng_get_entrysize(ring_type);
+	ret = ath11k_hal_srng_get_entrysize(ab, ring_type);
 	if (ret < 0)
 		goto err_free;
 
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index fe4df2b4a2cc..25f2270be195 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -8,7 +8,7 @@
 #include "hal_desc.h"
 #include "hif.h"
 
-static const struct hal_srng_config hw_srng_config[] = {
+static const struct hal_srng_config hw_srng_config_template[] = {
 	/* TODO: max_rings can populated by querying HW capabilities */
 	{ /* REO_DST */
 		.start_ring_id = HAL_SRNG_RING_ID_REO2SW1,
@@ -16,14 +16,6 @@ static const struct hal_srng_config hw_srng_config[] = {
 		.entry_size = sizeof(struct hal_reo_dest_ring) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_DST,
-		.reg_start = {
-			HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_BASE_LSB,
-			HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_HP,
-		},
-		.reg_size = {
-			HAL_REO2_RING_BASE_LSB - HAL_REO1_RING_BASE_LSB,
-			HAL_REO2_RING_HP - HAL_REO1_RING_HP,
-		},
 		.max_size = HAL_REO_REO2SW1_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* REO_EXCEPTION */
@@ -36,10 +28,6 @@ static const struct hal_srng_config hw_srng_config[] = {
 		.entry_size = sizeof(struct hal_reo_dest_ring) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_DST,
-		.reg_start = {
-			HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_TCL_RING_BASE_LSB,
-			HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_TCL_RING_HP,
-		},
 		.max_size = HAL_REO_REO2TCL_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* REO_REINJECT */
@@ -48,10 +36,6 @@ static const struct hal_srng_config hw_srng_config[] = {
 		.entry_size = sizeof(struct hal_reo_entrance_ring) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_SRC,
-		.reg_start = {
-			HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB,
-			HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_HP,
-		},
 		.max_size = HAL_REO_SW2REO_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* REO_CMD */
@@ -61,10 +45,6 @@ static const struct hal_srng_config hw_srng_config[] = {
 			sizeof(struct hal_reo_get_queue_stats)) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_SRC,
-		.reg_start = {
-			HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_RING_BASE_LSB,
-			HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_HP,
-		},
 		.max_size = HAL_REO_CMD_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* REO_STATUS */
@@ -74,11 +54,6 @@ static const struct hal_srng_config hw_srng_config[] = {
 			sizeof(struct hal_reo_get_queue_stats_status)) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_DST,
-		.reg_start = {
-			HAL_SEQ_WCSS_UMAC_REO_REG +
-				HAL_REO_STATUS_RING_BASE_LSB,
-			HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_HP,
-		},
 		.max_size = HAL_REO_STATUS_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* TCL_DATA */
@@ -88,14 +63,6 @@ static const struct hal_srng_config hw_srng_config[] = {
 			     sizeof(struct hal_tcl_data_cmd)) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_SRC,
-		.reg_start = {
-			HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB,
-			HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP,
-		},
-		.reg_size = {
-			HAL_TCL2_RING_BASE_LSB - HAL_TCL1_RING_BASE_LSB,
-			HAL_TCL2_RING_HP - HAL_TCL1_RING_HP,
-		},
 		.max_size = HAL_SW2TCL1_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* TCL_CMD */
@@ -105,10 +72,6 @@ static const struct hal_srng_config hw_srng_config[] = {
 			     sizeof(struct hal_tcl_gse_cmd)) >> 2,
 		.lmac_ring =  false,
 		.ring_dir = HAL_SRNG_DIR_SRC,
-		.reg_start = {
-			HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_BASE_LSB,
-			HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_HP,
-		},
 		.max_size = HAL_SW2TCL1_CMD_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* TCL_STATUS */
@@ -118,11 +81,6 @@ static const struct hal_srng_config hw_srng_config[] = {
 			     sizeof(struct hal_tcl_status_ring)) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_DST,
-		.reg_start = {
-			HAL_SEQ_WCSS_UMAC_TCL_REG +
-				HAL_TCL_STATUS_RING_BASE_LSB,
-			HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP,
-		},
 		.max_size = HAL_TCL_STATUS_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* CE_SRC */
@@ -344,7 +302,7 @@ static void ath11k_hal_free_cont_wrp(struct ath11k_base *ab)
 static void ath11k_hal_ce_dst_setup(struct ath11k_base *ab,
 				    struct hal_srng *srng, int ring_num)
 {
-	const struct hal_srng_config *srng_config = &hw_srng_config[HAL_CE_DST];
+	struct hal_srng_config *srng_config = &ab->hal.srng_config[HAL_CE_DST];
 	u32 addr;
 	u32 val;
 
@@ -550,7 +508,7 @@ static int ath11k_hal_srng_get_ring_id(struct ath11k_base *ab,
 				       enum hal_ring_type type,
 				       int ring_num, int mac_id)
 {
-	const struct hal_srng_config *srng_config = &hw_srng_config[type];
+	struct hal_srng_config *srng_config = &ab->hal.srng_config[type];
 	int ring_id;
 
 	if (ring_num >= srng_config->max_rings) {
@@ -568,26 +526,26 @@ static int ath11k_hal_srng_get_ring_id(struct ath11k_base *ab,
 	return ring_id;
 }
 
-int ath11k_hal_srng_get_entrysize(u32 ring_type)
+int ath11k_hal_srng_get_entrysize(struct ath11k_base *ab, u32 ring_type)
 {
-	const struct hal_srng_config *srng_config;
+	struct hal_srng_config *srng_config;
 
 	if (WARN_ON(ring_type >= HAL_MAX_RING_TYPES))
 		return -EINVAL;
 
-	srng_config = &hw_srng_config[ring_type];
+	srng_config = &ab->hal.srng_config[ring_type];
 
 	return (srng_config->entry_size << 2);
 }
 
-int ath11k_hal_srng_get_max_entries(u32 ring_type)
+int ath11k_hal_srng_get_max_entries(struct ath11k_base *ab, u32 ring_type)
 {
-	const struct hal_srng_config *srng_config;
+	struct hal_srng_config *srng_config;
 
 	if (WARN_ON(ring_type >= HAL_MAX_RING_TYPES))
 		return -EINVAL;
 
-	srng_config = &hw_srng_config[ring_type];
+	srng_config = &ab->hal.srng_config[ring_type];
 
 	return (srng_config->max_size / srng_config->entry_size);
 }
@@ -1003,7 +961,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 			  struct hal_srng_params *params)
 {
 	struct ath11k_hal *hal = &ab->hal;
-	const struct hal_srng_config *srng_config = &hw_srng_config[type];
+	struct hal_srng_config *srng_config = &ab->hal.srng_config[type];
 	struct hal_srng *srng;
 	int ring_id;
 	u32 lmac_idx;
@@ -1102,6 +1060,56 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 	return ring_id;
 }
 
+static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
+{
+	struct ath11k_hal *hal = &ab->hal;
+	struct hal_srng_config *s;
+
+	hal->srng_config = kmemdup(hw_srng_config_template,
+				   sizeof(hw_srng_config_template),
+				   GFP_KERNEL);
+	if (!hal->srng_config)
+		return -ENOMEM;
+
+	s = &hal->srng_config[HAL_REO_DST];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_HP;
+	s->reg_size[0] = HAL_REO2_RING_BASE_LSB - HAL_REO1_RING_BASE_LSB;
+	s->reg_size[1] = HAL_REO2_RING_HP - HAL_REO1_RING_HP;
+
+	s = &hal->srng_config[HAL_REO_EXCEPTION];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_TCL_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_TCL_RING_HP;
+
+	s = &hal->srng_config[HAL_REO_REINJECT];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_HP;
+
+	s = &hal->srng_config[HAL_REO_CMD];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_HP;
+
+	s = &hal->srng_config[HAL_REO_STATUS];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_HP;
+
+	s = &hal->srng_config[HAL_TCL_DATA];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP;
+	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB - HAL_TCL1_RING_BASE_LSB;
+	s->reg_size[1] = HAL_TCL2_RING_HP - HAL_TCL1_RING_HP;
+
+	s = &hal->srng_config[HAL_TCL_CMD];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_HP;
+
+	s = &hal->srng_config[HAL_TCL_STATUS];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
+
+	return 0;
+}
+
 int ath11k_hal_srng_init(struct ath11k_base *ab)
 {
 	struct ath11k_hal *hal = &ab->hal;
@@ -1109,7 +1117,9 @@ int ath11k_hal_srng_init(struct ath11k_base *ab)
 
 	memset(hal, 0, sizeof(*hal));
 
-	hal->srng_config = hw_srng_config;
+	ret = ath11k_hal_srng_create_config(ab);
+	if (ret)
+		goto err_hal;
 
 	ret = ath11k_hal_alloc_cont_rdp(ab);
 	if (ret)
@@ -1131,8 +1141,11 @@ EXPORT_SYMBOL(ath11k_hal_srng_init);
 
 void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 {
+	struct ath11k_hal *hal = &ab->hal;
+
 	ath11k_hal_free_cont_rdp(ab);
 	ath11k_hal_free_cont_wrp(ab);
+	kfree(hal->srng_config);
 }
 EXPORT_SYMBOL(ath11k_hal_srng_deinit);
 
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 6d9a6938870c..40c51d80430c 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -841,7 +841,7 @@ struct ath11k_hal {
 	struct hal_srng srng_list[HAL_SRNG_RING_ID_MAX];
 
 	/* SRNG configuration table */
-	const struct hal_srng_config *srng_config;
+	struct hal_srng_config *srng_config;
 
 	/* Remote pointer memory for HW/FW updates */
 	struct {
@@ -887,8 +887,8 @@ void ath11k_hal_ce_src_set_desc(void *buf, dma_addr_t paddr, u32 len, u32 id,
 				u8 byte_swap_data);
 void ath11k_hal_ce_dst_set_desc(void *buf, dma_addr_t paddr);
 u32 ath11k_hal_ce_dst_status_get_length(void *buf);
-int ath11k_hal_srng_get_entrysize(u32 ring_type);
-int ath11k_hal_srng_get_max_entries(u32 ring_type);
+int ath11k_hal_srng_get_entrysize(struct ath11k_base *ab, u32 ring_type);
+int ath11k_hal_srng_get_max_entries(struct ath11k_base *ab, u32 ring_type);
 void ath11k_hal_srng_get_params(struct ath11k_base *ab, struct hal_srng *srng,
 				struct hal_srng_params *params);
 u32 *ath11k_hal_srng_dst_get_next_entry(struct ath11k_base *ab,
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 129c9e1efeb9..b30f1931313d 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -786,7 +786,7 @@ void ath11k_hal_reo_init_cmd_ring(struct ath11k_base *ab,
 
 	memset(&params, 0, sizeof(params));
 
-	entry_size = ath11k_hal_srng_get_entrysize(HAL_REO_CMD);
+	entry_size = ath11k_hal_srng_get_entrysize(ab, HAL_REO_CMD);
 	ath11k_hal_srng_get_params(ab, srng, &params);
 	entry = (u8 *)params.ring_base_vaddr;
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index 81937c29ffca..a755aa86c5de 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -141,7 +141,7 @@ void ath11k_hal_tx_init_data_ring(struct ath11k_base *ab, struct hal_srng *srng)
 
 	memset(&params, 0, sizeof(params));
 
-	entry_size = ath11k_hal_srng_get_entrysize(HAL_TCL_DATA);
+	entry_size = ath11k_hal_srng_get_entrysize(ab, HAL_TCL_DATA);
 	ath11k_hal_srng_get_params(ab, srng, &params);
 	desc = (u8 *)params.ring_base_vaddr;
 
-- 
2.7.4

