Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF123245621
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 07:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgHPFcA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 01:32:00 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53937 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730068AbgHPFb7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 01:31:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597555917; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=YBpawfD6JxVHp1cljiSWoZ8cYb3TvrJGAVTRHFx4j38=; b=ip9S719wdDe/ICRmwtWV8jyDVjVeKu2GBhtHdvi7JX2uPIYTp7l3u099hEK8adP65ZKy0nlY
 1yFXALPq7BZ2I9XFBMcNendm5FhdthTSEp0AyIa5t/VXhxooBE5AUVastMhDImfuWEkqWE5M
 b59u8+gNPIehyah/QBIeE05W9U8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5f38c4be440a07969a75ecdc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 05:31:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5CAA4C4339C; Sun, 16 Aug 2020 05:31:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F08BC433C6;
        Sun, 16 Aug 2020 05:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F08BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/9] ath11k: setup QCA6390 rings for both rxdmas
Date:   Sun, 16 Aug 2020 08:31:25 +0300
Message-Id: <1597555891-26112-4-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
References: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For QCA6390, only one pdev is created and this pdev manages both lmacs, thus
both rxdmas. So host needs to initialize all rxdma related rings for one pdev.

Another difference is for QCA6390, host fills rxbuf to firmware and firmware
further fills the rxbuf to rxbuf ring for each rxdma.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c  |   4 +
 drivers/net/wireless/ath/ath11k/core.h  |   6 ++
 drivers/net/wireless/ath/ath11k/debug.c |  41 ++++----
 drivers/net/wireless/ath/ath11k/dp.c    |   7 +-
 drivers/net/wireless/ath/ath11k/dp.h    |   7 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 164 ++++++++++++++++++++++----------
 drivers/net/wireless/ath/ath11k/dp_tx.c |  55 +++++++----
 drivers/net/wireless/ath/ath11k/hw.c    |  31 ++++++
 drivers/net/wireless/ath/ath11k/hw.h    |  34 +++++--
 drivers/net/wireless/ath/ath11k/mac.c   |  15 ++-
 10 files changed, 268 insertions(+), 96 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 8e9bf0e64a68..e583b1492eca 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -38,6 +38,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.single_pdev_only = false,
 		.needs_band_to_mac = true,
 		.rxdma1_enable = true,
+		.num_rxmda_per_pdev = 1,
+		.rx_mac_buf_ring = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -58,6 +60,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.single_pdev_only = true,
 		.needs_band_to_mac = false,
 		.rxdma1_enable = false,
+		.num_rxmda_per_pdev = 2,
+		.rx_mac_buf_ring = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 48bf2954c97c..f623f357aa33 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -901,6 +901,12 @@ static inline struct ath11k_vif *ath11k_vif_to_arvif(struct ieee80211_vif *vif)
 	return (struct ath11k_vif *)vif->drv_priv;
 }
 
+static inline struct ath11k *ath11k_ab_to_ar(struct ath11k_base *ab,
+					     int mac_id)
+{
+	return ab->pdevs[ath11k_hw_mac_id_to_pdev_id(&ab->hw_params, mac_id)].ar;
+}
+
 static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
 						    const char *filename,
 						    void *buf, size_t buf_len)
diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 60b961e59189..0a3cfa716390 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -698,8 +698,10 @@ static ssize_t ath11k_write_extd_rx_stats(struct file *file,
 					  size_t count, loff_t *ppos)
 {
 	struct ath11k *ar = file->private_data;
+	struct ath11k_base *ab = ar->ab;
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	u32 enable, rx_filter = 0, ring_id;
+	int i;
 	int ret;
 
 	if (kstrtouint_from_user(ubuf, count, 0, &enable))
@@ -742,14 +744,16 @@ static ssize_t ath11k_write_extd_rx_stats(struct file *file,
 
 	ar->debug.rx_filter = tlv_filter.rx_filter;
 
-	ring_id = ar->dp.rx_mon_status_refill_ring.refill_buf_ring.ring_id;
-	ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, ar->dp.mac_id,
-					       HAL_RXDMA_MONITOR_STATUS,
-					       DP_RX_BUFFER_SIZE, &tlv_filter);
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		ring_id = ar->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
+		ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, ar->dp.mac_id,
+						       HAL_RXDMA_MONITOR_STATUS,
+						       DP_RX_BUFFER_SIZE, &tlv_filter);
 
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to set rx filter for monitor status ring\n");
-		goto exit;
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to set rx filter for monitor status ring\n");
+			goto exit;
+		}
 	}
 
 	ar->debug.extd_rx_stats = enable;
@@ -1000,10 +1004,11 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 					  size_t count, loff_t *ppos)
 {
 	struct ath11k *ar = file->private_data;
+	struct ath11k_base *ab = ar->ab;
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	u32 rx_filter = 0, ring_id, filter, mode;
 	u8 buf[128] = {0};
-	int ret;
+	int i, ret;
 	ssize_t rc;
 
 	mutex_lock(&ar->conf_mutex);
@@ -1084,16 +1089,20 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 					       HTT_RX_FP_DATA_FILTER_FLASG3;
 	}
 
-	ring_id = ar->dp.rx_mon_status_refill_ring.refill_buf_ring.ring_id;
-	ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, ar->dp.mac_id,
-					       HAL_RXDMA_MONITOR_STATUS,
-					       DP_RX_BUFFER_SIZE, &tlv_filter);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to set rx filter for monitor status ring\n");
-		goto out;
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		ring_id = ar->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
+		ret = ath11k_dp_tx_htt_rx_filter_setup(ab, ring_id,
+						       ar->dp.mac_id + i,
+						       HAL_RXDMA_MONITOR_STATUS,
+						       DP_RX_BUFFER_SIZE, &tlv_filter);
+
+		if (ret) {
+			ath11k_warn(ab, "failed to set rx filter for moniter status ring\n");
+			goto out;
+		}
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "pktlog filter %d mode %s\n",
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "pktlog filter %d mode %s\n",
 		   filter, ((mode == ATH11K_PKTLOG_MODE_FULL) ? "full" : "lite"));
 
 	ar->debug.pktlog_filter = filter;
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index ac92f345a013..93f30525d7f6 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -831,6 +831,7 @@ void ath11k_dp_pdev_pre_alloc(struct ath11k_base *ab)
 	struct ath11k *ar;
 	struct ath11k_pdev_dp *dp;
 	int i;
+	int j;
 
 	for (i = 0; i <  ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
@@ -840,8 +841,10 @@ void ath11k_dp_pdev_pre_alloc(struct ath11k_base *ab)
 		spin_lock_init(&dp->rx_refill_buf_ring.idr_lock);
 		atomic_set(&dp->num_tx_pending, 0);
 		init_waitqueue_head(&dp->tx_empty_waitq);
-		idr_init(&dp->rx_mon_status_refill_ring.bufs_idr);
-		spin_lock_init(&dp->rx_mon_status_refill_ring.idr_lock);
+		for (j = 0; j < ab->hw_params.num_rxmda_per_pdev; j++) {
+			idr_init(&dp->rx_mon_status_refill_ring[j].bufs_idr);
+			spin_lock_init(&dp->rx_mon_status_refill_ring[j].idr_lock);
+		}
 		idr_init(&dp->rxdma_mon_buf_ring.bufs_idr);
 		spin_lock_init(&dp->rxdma_mon_buf_ring.idr_lock);
 	}
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 07876fd521f7..558f03fbec99 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -8,6 +8,8 @@
 
 #include "hal_rx.h"
 
+#define MAX_RXDMA_PER_PDEV     2
+
 struct ath11k_base;
 struct ath11k_peer;
 struct ath11k_dp;
@@ -142,12 +144,13 @@ struct ath11k_pdev_dp {
 	atomic_t num_tx_pending;
 	wait_queue_head_t tx_empty_waitq;
 	struct dp_rxdma_ring rx_refill_buf_ring;
-	struct dp_srng rxdma_err_dst_ring;
+	struct dp_srng rx_mac_buf_ring[MAX_RXDMA_PER_PDEV];
+	struct dp_srng rxdma_err_dst_ring[MAX_RXDMA_PER_PDEV];
 	struct dp_srng rxdma_mon_dst_ring;
 	struct dp_srng rxdma_mon_desc_ring;
 
 	struct dp_rxdma_ring rxdma_mon_buf_ring;
-	struct dp_rxdma_ring rx_mon_status_refill_ring;
+	struct dp_rxdma_ring rx_mon_status_refill_ring[MAX_RXDMA_PER_PDEV];
 	struct ieee80211_rx_status rx_status;
 	struct ath11k_mon_data mon_data;
 };
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 64aa0077a45d..4d745ea63f3e 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -381,7 +381,7 @@ static int ath11k_dp_rxdma_buf_ring_free(struct ath11k *ar,
 	if (!ar->ab->hw_params.rxdma1_enable)
 		return 0;
 
-	rx_ring = &dp->rx_mon_status_refill_ring;
+	rx_ring = &dp->rx_mon_status_refill_ring[0];
 
 	spin_lock_bh(&rx_ring->idr_lock);
 	idr_for_each_entry(&rx_ring->bufs_idr, skb, buf_id) {
@@ -403,15 +403,20 @@ static int ath11k_dp_rxdma_buf_ring_free(struct ath11k *ar,
 static int ath11k_dp_rxdma_pdev_buf_free(struct ath11k *ar)
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
+	struct ath11k_base *ab = ar->ab;
 	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
+	int i;
 
 	ath11k_dp_rxdma_buf_ring_free(ar, rx_ring);
 
 	rx_ring = &dp->rxdma_mon_buf_ring;
 	ath11k_dp_rxdma_buf_ring_free(ar, rx_ring);
 
-	rx_ring = &dp->rx_mon_status_refill_ring;
-	ath11k_dp_rxdma_buf_ring_free(ar, rx_ring);
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		rx_ring = &dp->rx_mon_status_refill_ring[i];
+		ath11k_dp_rxdma_buf_ring_free(ar, rx_ring);
+	}
+
 	return 0;
 }
 
@@ -434,7 +439,9 @@ static int ath11k_dp_rxdma_ring_buf_setup(struct ath11k *ar,
 static int ath11k_dp_rxdma_pdev_buf_setup(struct ath11k *ar)
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
+	struct ath11k_base *ab = ar->ab;
 	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
+	int i;
 
 	ath11k_dp_rxdma_ring_buf_setup(ar, rx_ring, HAL_RXDMA_BUF);
 
@@ -443,8 +450,10 @@ static int ath11k_dp_rxdma_pdev_buf_setup(struct ath11k *ar)
 		ath11k_dp_rxdma_ring_buf_setup(ar, rx_ring, HAL_RXDMA_MONITOR_BUF);
 	}
 
-	rx_ring = &dp->rx_mon_status_refill_ring;
-	ath11k_dp_rxdma_ring_buf_setup(ar, rx_ring, HAL_RXDMA_MONITOR_STATUS);
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		rx_ring = &dp->rx_mon_status_refill_ring[i];
+		ath11k_dp_rxdma_ring_buf_setup(ar, rx_ring, HAL_RXDMA_MONITOR_STATUS);
+	}
 
 	return 0;
 }
@@ -452,11 +461,21 @@ static int ath11k_dp_rxdma_pdev_buf_setup(struct ath11k *ar)
 static void ath11k_dp_rx_pdev_srng_free(struct ath11k *ar)
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
+	struct ath11k_base *ab = ar->ab;
+	int i;
+
+	ath11k_dp_srng_cleanup(ab, &dp->rx_refill_buf_ring.refill_buf_ring);
+
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		if (ab->hw_params.rx_mac_buf_ring)
+			ath11k_dp_srng_cleanup(ab, &dp->rx_mac_buf_ring[i]);
 
-	ath11k_dp_srng_cleanup(ar->ab, &dp->rx_refill_buf_ring.refill_buf_ring);
-	ath11k_dp_srng_cleanup(ar->ab, &dp->rxdma_err_dst_ring);
-	ath11k_dp_srng_cleanup(ar->ab, &dp->rx_mon_status_refill_ring.refill_buf_ring);
-	ath11k_dp_srng_cleanup(ar->ab, &dp->rxdma_mon_buf_ring.refill_buf_ring);
+		ath11k_dp_srng_cleanup(ab, &dp->rxdma_err_dst_ring[i]);
+		ath11k_dp_srng_cleanup(ab,
+				       &dp->rx_mon_status_refill_ring[i].refill_buf_ring);
+	}
+
+	ath11k_dp_srng_cleanup(ab, &dp->rxdma_mon_buf_ring.refill_buf_ring);
 }
 
 void ath11k_dp_pdev_reo_cleanup(struct ath11k_base *ab)
@@ -495,7 +514,9 @@ int ath11k_dp_pdev_reo_setup(struct ath11k_base *ab)
 static int ath11k_dp_rx_pdev_srng_alloc(struct ath11k *ar)
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
+	struct ath11k_base *ab = ar->ab;
 	struct dp_srng *srng = NULL;
+	int i;
 	int ret;
 
 	ret = ath11k_dp_srng_setup(ar->ab,
@@ -507,23 +528,41 @@ static int ath11k_dp_rx_pdev_srng_alloc(struct ath11k *ar)
 		return ret;
 	}
 
-	ret = ath11k_dp_srng_setup(ar->ab, &dp->rxdma_err_dst_ring,
-				   HAL_RXDMA_DST, 0, dp->mac_id,
-				   DP_RXDMA_ERR_DST_RING_SIZE);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to setup rxdma_err_dst_ring\n");
-		return ret;
+	if (ar->ab->hw_params.rx_mac_buf_ring) {
+		for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+			ret = ath11k_dp_srng_setup(ar->ab,
+						   &dp->rx_mac_buf_ring[i],
+						   HAL_RXDMA_BUF, 1,
+						   dp->mac_id + i, 1024);
+			if (ret) {
+				ath11k_warn(ar->ab, "failed to setup rx_mac_buf_ring %d\n",
+					    i);
+				return ret;
+			}
+		}
 	}
 
-	srng = &dp->rx_mon_status_refill_ring.refill_buf_ring;
-	ret = ath11k_dp_srng_setup(ar->ab,
-				   srng,
-				   HAL_RXDMA_MONITOR_STATUS, 0, dp->mac_id,
-				   DP_RXDMA_MON_STATUS_RING_SIZE);
-	if (ret) {
-		ath11k_warn(ar->ab,
-			    "failed to setup rx_mon_status_refill_ring\n");
-		return ret;
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		ret = ath11k_dp_srng_setup(ar->ab, &dp->rxdma_err_dst_ring[i],
+					   HAL_RXDMA_DST, 0, dp->mac_id + i,
+					   DP_RXDMA_ERR_DST_RING_SIZE);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to setup rxdma_err_dst_ring %d\n", i);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		srng = &dp->rx_mon_status_refill_ring[i].refill_buf_ring;
+		ret = ath11k_dp_srng_setup(ar->ab,
+					   srng,
+					   HAL_RXDMA_MONITOR_STATUS, 0, dp->mac_id + i,
+					   DP_RXDMA_MON_STATUS_RING_SIZE);
+		if (ret) {
+			ath11k_warn(ar->ab,
+				    "failed to setup rx_mon_status_refill_ring %d\n", i);
+			return ret;
+		}
 	}
 
 	/* if rxdma1_enable is false, then it doesn't need
@@ -2738,20 +2777,25 @@ int ath11k_dp_rx_mon_status_bufs_replenish(struct ath11k_base *ab, int mac_id,
 static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 					     int *budget, struct sk_buff_head *skb_list)
 {
-	struct ath11k *ar = ab->pdevs[mac_id].ar;
-	struct ath11k_pdev_dp *dp = &ar->dp;
-	struct dp_rxdma_ring *rx_ring = &dp->rx_mon_status_refill_ring;
+	struct ath11k *ar;
+	struct ath11k_pdev_dp *dp;
+	struct dp_rxdma_ring *rx_ring;
 	struct hal_srng *srng;
 	void *rx_mon_status_desc;
 	struct sk_buff *skb;
 	struct ath11k_skb_rxcb *rxcb;
 	struct hal_tlv_hdr *tlv;
 	u32 cookie;
-	int buf_id;
+	int buf_id, srng_id;
 	dma_addr_t paddr;
 	u8 rbm;
 	int num_buffs_reaped = 0;
 
+	ar = ab->pdevs[ath11k_hw_mac_id_to_pdev_id(&ab->hw_params, mac_id)].ar;
+	dp = &ar->dp;
+	srng_id = ath11k_hw_mac_id_to_srng_id(&ab->hw_params, mac_id);
+	rx_ring = &dp->rx_mon_status_refill_ring[srng_id];
+
 	srng = &ab->hal.srng_list[rx_ring->refill_buf_ring.ring_id];
 
 	spin_lock_bh(&srng->lock);
@@ -2832,7 +2876,7 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 				    struct napi_struct *napi, int budget)
 {
-	struct ath11k *ar = ab->pdevs[mac_id].ar;
+	struct ath11k *ar = ath11k_ab_to_ar(ab, mac_id);
 	enum hal_rx_mon_status hal_status;
 	struct sk_buff *skb;
 	struct sk_buff_head skb_list;
@@ -3942,9 +3986,9 @@ int ath11k_dp_rx_process_wbm_err(struct ath11k_base *ab,
 
 int ath11k_dp_process_rxdma_err(struct ath11k_base *ab, int mac_id, int budget)
 {
-	struct ath11k *ar = ab->pdevs[mac_id].ar;
-	struct dp_srng *err_ring = &ar->dp.rxdma_err_dst_ring;
-	struct dp_rxdma_ring *rx_ring = &ar->dp.rx_refill_buf_ring;
+	struct ath11k *ar;
+	struct dp_srng *err_ring;
+	struct dp_rxdma_ring *rx_ring;
 	struct dp_link_desc_bank *link_desc_banks = ab->dp.link_desc_banks;
 	struct hal_srng *srng;
 	u32 msdu_cookies[HAL_NUM_RX_MSDUS_PER_LINK_DESC];
@@ -3963,6 +4007,11 @@ int ath11k_dp_process_rxdma_err(struct ath11k_base *ab, int mac_id, int budget)
 	int i;
 	int buf_id;
 
+	ar = ab->pdevs[ath11k_hw_mac_id_to_pdev_id(&ab->hw_params, mac_id)].ar;
+	err_ring = &ar->dp.rxdma_err_dst_ring[ath11k_hw_mac_id_to_srng_id(&ab->hw_params,
+									  mac_id)];
+	rx_ring = &ar->dp.rx_refill_buf_ring;
+
 	srng = &ab->hal.srng_list[err_ring->ring_id];
 
 	spin_lock_bh(&srng->lock);
@@ -4116,6 +4165,7 @@ int ath11k_dp_rx_pdev_alloc(struct ath11k_base *ab, int mac_id)
 	struct ath11k *ar = ab->pdevs[mac_id].ar;
 	struct ath11k_pdev_dp *dp = &ar->dp;
 	u32 ring_id;
+	int i;
 	int ret;
 
 	ret = ath11k_dp_rx_pdev_srng_alloc(ar);
@@ -4138,12 +4188,28 @@ int ath11k_dp_rx_pdev_alloc(struct ath11k_base *ab, int mac_id)
 		return ret;
 	}
 
-	ring_id = dp->rxdma_err_dst_ring.ring_id;
-	ret = ath11k_dp_tx_htt_srng_setup(ab, ring_id, mac_id, HAL_RXDMA_DST);
-	if (ret) {
-		ath11k_warn(ab, "failed to configure rxdma_err_dest_ring %d\n",
-			    ret);
-		return ret;
+	if (ab->hw_params.rx_mac_buf_ring) {
+		for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+			ring_id = dp->rx_mac_buf_ring[i].ring_id;
+			ret = ath11k_dp_tx_htt_srng_setup(ab, ring_id,
+							  mac_id + i, HAL_RXDMA_BUF);
+			if (ret) {
+				ath11k_warn(ab, "failed to configure rx_mac_buf_ring%d %d\n",
+					    i, ret);
+				return ret;
+			}
+		}
+	}
+
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		ring_id = dp->rxdma_err_dst_ring[i].ring_id;
+		ret = ath11k_dp_tx_htt_srng_setup(ab, ring_id,
+						  mac_id + i, HAL_RXDMA_DST);
+		if (ret) {
+			ath11k_warn(ab, "failed to configure rxdma_err_dest_ring%d %d\n",
+				    i, ret);
+			return ret;
+		}
 	}
 
 	if (!ab->hw_params.rxdma1_enable)
@@ -4175,14 +4241,16 @@ int ath11k_dp_rx_pdev_alloc(struct ath11k_base *ab, int mac_id)
 	}
 
 config_refill_ring:
-	ring_id = dp->rx_mon_status_refill_ring.refill_buf_ring.ring_id;
-	ret = ath11k_dp_tx_htt_srng_setup(ab, ring_id, mac_id,
-					  HAL_RXDMA_MONITOR_STATUS);
-	if (ret) {
-		ath11k_warn(ab,
-			    "failed to configure mon_status_refill_ring %d\n",
-			    ret);
-		return ret;
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		ring_id = dp->rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
+		ret = ath11k_dp_tx_htt_srng_setup(ab, ring_id, mac_id + i,
+						  HAL_RXDMA_MONITOR_STATUS);
+		if (ret) {
+			ath11k_warn(ab,
+				    "failed to configure mon_status_refill_ring%d %d\n",
+				    i, ret);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -4802,7 +4870,7 @@ static void ath11k_dp_rx_mon_status_process_tlv(struct ath11k *ar,
 static int ath11k_dp_mon_process_rx(struct ath11k_base *ab, int mac_id,
 				    struct napi_struct *napi, int budget)
 {
-	struct ath11k *ar = ab->pdevs[mac_id].ar;
+	struct ath11k *ar = ath11k_ab_to_ar(ab, mac_id);
 	struct ath11k_pdev_dp *dp = &ar->dp;
 	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&dp->mon_data;
 	int num_buffs_reaped = 0;
@@ -4818,7 +4886,7 @@ static int ath11k_dp_mon_process_rx(struct ath11k_base *ab, int mac_id,
 int ath11k_dp_rx_process_mon_rings(struct ath11k_base *ab, int mac_id,
 				   struct napi_struct *napi, int budget)
 {
-	struct ath11k *ar = ab->pdevs[mac_id].ar;
+	struct ath11k *ar = ath11k_ab_to_ar(ab, mac_id);
 	int ret = 0;
 
 	if (test_bit(ATH11K_FLAG_MONITOR_ENABLED, &ar->monitor_flags))
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index b83b5176a5df..953c435ef3b3 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -633,14 +633,28 @@ ath11k_dp_tx_get_ring_id_type(struct ath11k_base *ab,
 	switch (ring_type) {
 	case HAL_RXDMA_BUF:
 		lmac_ring_id_offset = mac_id * HAL_SRNG_RINGS_PER_LMAC;
-		if (!(ring_id == (HAL_SRNG_RING_ID_WMAC1_SW2RXDMA0_BUF +
-				  lmac_ring_id_offset) ||
-		    ring_id == (HAL_SRNG_RING_ID_WMAC1_SW2RXDMA1_BUF +
-				lmac_ring_id_offset))) {
-			ret = -EINVAL;
+
+		/* for QCA6390, host fills rx buffer to fw and fw fills to
+		 * rxbuf ring for each rxdma
+		 */
+		if (!ab->hw_params.rx_mac_buf_ring) {
+			if (!(ring_id == (HAL_SRNG_RING_ID_WMAC1_SW2RXDMA0_BUF +
+					  lmac_ring_id_offset) ||
+				ring_id == (HAL_SRNG_RING_ID_WMAC1_SW2RXDMA1_BUF +
+					lmac_ring_id_offset))) {
+				ret = -EINVAL;
+			}
+			*htt_ring_id = HTT_RXDMA_HOST_BUF_RING;
+			*htt_ring_type = HTT_SW_TO_HW_RING;
+		} else {
+			if (ring_id == HAL_SRNG_RING_ID_WMAC1_SW2RXDMA0_BUF) {
+				*htt_ring_id = HTT_HOST1_TO_FW_RXBUF_RING;
+				*htt_ring_type = HTT_SW_TO_SW_RING;
+			} else {
+				*htt_ring_id = HTT_RXDMA_HOST_BUF_RING;
+				*htt_ring_type = HTT_SW_TO_HW_RING;
+			}
 		}
-		*htt_ring_id = HTT_RXDMA_HOST_BUF_RING;
-		*htt_ring_type = HTT_SW_TO_HW_RING;
 		break;
 	case HAL_RXDMA_DST:
 		*htt_ring_id = HTT_RXDMA_NON_MONITOR_DEST_RING;
@@ -968,8 +982,9 @@ ath11k_dp_tx_htt_h2t_ext_stats_req(struct ath11k *ar, u8 type,
 int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
+	struct ath11k_base *ab = ar->ab;
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
-	int ret = 0, ring_id = 0;
+	int ret = 0, ring_id = 0, i;
 
 	ring_id = dp->rxdma_mon_buf_ring.refill_buf_ring.ring_id;
 
@@ -998,16 +1013,20 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
 	if (ret)
 		return ret;
 
-	ring_id = dp->rx_mon_status_refill_ring.refill_buf_ring.ring_id;
-	if (!reset)
-		tlv_filter.rx_filter =
-				HTT_RX_MON_FILTER_TLV_FLAGS_MON_STATUS_RING;
-	else
-		tlv_filter = ath11k_mac_mon_status_filter_default;
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		ring_id = dp->rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
+		if (!reset)
+			tlv_filter.rx_filter =
+					HTT_RX_MON_FILTER_TLV_FLAGS_MON_STATUS_RING;
+		else
+			tlv_filter = ath11k_mac_mon_status_filter_default;
+
+		ret = ath11k_dp_tx_htt_rx_filter_setup(ab, ring_id,
+						       dp->mac_id + i,
+						       HAL_RXDMA_MONITOR_STATUS,
+						       DP_RXDMA_REFILL_RING_SIZE,
+						       &tlv_filter);
+	}
 
-	ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, dp->mac_id,
-					       HAL_RXDMA_MONITOR_STATUS,
-					       DP_RXDMA_REFILL_RING_SIZE,
-					       &tlv_filter);
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 9737b9f5e1b5..e0788994ea22 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -127,18 +127,49 @@ static void ath11k_init_wmi_config_ipq8074(struct ath11k_base *ab,
 	config->twt_ap_sta_count = 1000;
 }
 
+static int ath11k_hw_mac_id_to_pdev_id_ipq8074(struct ath11k_hw_params *hw,
+					       int mac_id)
+{
+	return mac_id;
+}
+
+static int ath11k_hw_mac_id_to_srng_id_ipq8074(struct ath11k_hw_params *hw,
+					       int mac_id)
+{
+	return 0;
+}
+
+static int ath11k_hw_mac_id_to_pdev_id_qca6390(struct ath11k_hw_params *hw,
+					       int mac_id)
+{
+	return 0;
+}
+
+static int ath11k_hw_mac_id_to_srng_id_qca6390(struct ath11k_hw_params *hw,
+					       int mac_id)
+{
+	return mac_id;
+}
+
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
 	.wmi_init_config = ath11k_init_wmi_config_qca6390,
+	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_ipq8074,
+	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_ipq8074,
 };
 
 const struct ath11k_hw_ops ipq6018_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq6018_mac_from_pdev_id,
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
+	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_ipq8074,
+	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_ipq8074,
 };
 
 const struct ath11k_hw_ops qca6390_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
+	.wmi_init_config = ath11k_init_wmi_config_qca6390,
+	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_qca6390,
+	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_qca6390,
 };
 
 #define ATH11K_TX_RING_MASK_0 0x1
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 2e88194da329..1a8f63e789a0 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -116,12 +116,6 @@ struct ath11k_hw_ring_mask {
 	u8 host2rxdma[ATH11K_EXT_IRQ_GRP_NUM_MAX];
 };
 
-struct ath11k_hw_ops {
-	u8 (*get_hw_mac_from_pdev_id)(int pdev_id);
-	void (*wmi_init_config)(struct ath11k_base *ab,
-				struct target_resource_config *config);
-};
-
 struct ath11k_hw_params {
 	const char *name;
 	u16 hw_rev;
@@ -153,6 +147,16 @@ struct ath11k_hw_params {
 	bool needs_band_to_mac;
 
 	bool rxdma1_enable;
+	int num_rxmda_per_pdev;
+	bool rx_mac_buf_ring;
+};
+
+struct ath11k_hw_ops {
+	u8 (*get_hw_mac_from_pdev_id)(int pdev_id);
+	void (*wmi_init_config)(struct ath11k_base *ab,
+				struct target_resource_config *config);
+	int (*mac_id_to_pdev_id)(struct ath11k_hw_params *hw, int mac_id);
+	int (*mac_id_to_srng_id)(struct ath11k_hw_params *hw, int mac_id);
 };
 
 extern const struct ath11k_hw_ops ipq8074_ops;
@@ -172,6 +176,24 @@ int ath11k_hw_get_mac_from_pdev_id(struct ath11k_hw_params *hw,
 	return 0;
 }
 
+static inline int ath11k_hw_mac_id_to_pdev_id(struct ath11k_hw_params *hw,
+					      int mac_id)
+{
+	if (hw->hw_ops->mac_id_to_pdev_id)
+		return hw->hw_ops->mac_id_to_pdev_id(hw, mac_id);
+
+	return 0;
+}
+
+static inline int ath11k_hw_mac_id_to_srng_id(struct ath11k_hw_params *hw,
+					      int mac_id)
+{
+	if (hw->hw_ops->mac_id_to_srng_id)
+		return hw->hw_ops->mac_id_to_srng_id(hw, mac_id);
+
+	return 0;
+}
+
 struct ath11k_fw_ie {
 	__le32 id;
 	__le32 len;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ec68b5eea847..5aae1ec27e9f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4054,6 +4054,8 @@ void ath11k_mac_drain_tx(struct ath11k *ar)
 static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 {
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct ath11k_base *ab = ar->ab;
+	int i, ret = 0;
 	u32 ring_id;
 
 	if (enable) {
@@ -4061,11 +4063,16 @@ static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 		tlv_filter.rx_filter = ath11k_debug_rx_filter(ar);
 	}
 
-	ring_id = ar->dp.rx_mon_status_refill_ring.refill_buf_ring.ring_id;
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		ring_id = ar->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
+		ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id,
+						       ar->dp.mac_id + i,
+						       HAL_RXDMA_MONITOR_STATUS,
+						       DP_RX_BUFFER_SIZE,
+						       &tlv_filter);
+	}
 
-	return ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, ar->dp.mac_id,
-						HAL_RXDMA_MONITOR_STATUS,
-						DP_RX_BUFFER_SIZE, &tlv_filter);
+	return ret;
 }
 
 static int ath11k_mac_op_start(struct ieee80211_hw *hw)
-- 
2.7.4

