Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C82A3A8ADC
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 23:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhFOVRG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 17:17:06 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:10563 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhFOVRG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 17:17:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623791701; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=PweW9X1A3aOlLVXUb/xcnljlu5UdX6c93+2YDKIb3tU=; b=JwpxUPOeDt5y9+EMGQFqJBqKZpacyInuHOamIXaBa/6EdJM/LV7pcZS56CMqsMRSVmJAR2Nu
 OzWMkcryQh17evu8z1zH33BMMJDX8ZuL7z+EBwRDtBwfBWa5V9sKQTr+gBIY0tZ4Zgy5PjAh
 H+9RSz4UUCtC+Q0q5VvJGY5z4t0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60c91851ed59bf69cc3725e3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 21:14:57
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6B1BC4360C; Tue, 15 Jun 2021 21:14:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-78-13-nat.elisa-mobile.fi [85.76.78.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2313AC43144;
        Tue, 15 Jun 2021 21:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2313AC43144
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 11/12] ath11k: add branch predictors in dp_tx path
Date:   Wed, 16 Jun 2021 00:14:06 +0300
Message-Id: <20210615211407.92233-12-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615211407.92233-1-jouni@codeaurora.org>
References: <20210615211407.92233-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: P Praneesh <ppranees@codeaurora.org>

Add branch prediciton in dp_tx code path in tx and tx completion
handler.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1 v2

Co-developed-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 45 +++++++++++++------------
 drivers/net/wireless/ath/ath11k/mac.c   |  2 +-
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8bba5234f81f..ab9ccf0eb274 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -95,11 +95,11 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	u8 ring_selector = 0, ring_map = 0;
 	bool tcl_ring_retry;
 
-	if (test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
+	if (unlikely(test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags)))
 		return -ESHUTDOWN;
 
-	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
-	    !ieee80211_is_data(hdr->frame_control))
+	if (unlikely(!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
+		     !ieee80211_is_data(hdr->frame_control)))
 		return -ENOTSUPP;
 
 	pool_id = skb_get_queue_mapping(skb) & (ATH11K_HW_MAX_QUEUES - 1);
@@ -130,7 +130,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 			DP_TX_IDR_SIZE - 1, GFP_ATOMIC);
 	spin_unlock_bh(&tx_ring->tx_idr_lock);
 
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		if (ring_map == (BIT(DP_TCL_NUM_RING_MAX) - 1)) {
 			atomic_inc(&ab->soc_stats.tx_err.misc_fail);
 			return -ENOSPC;
@@ -147,7 +147,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	ti.encap_type = ath11k_dp_tx_get_encap_type(arvif, skb);
 	ti.meta_data_flags = arvif->tcl_metadata;
 
-	if (ti.encap_type == HAL_TCL_ENCAP_TYPE_RAW) {
+	if (unlikely(ti.encap_type == HAL_TCL_ENCAP_TYPE_RAW)) {
 		if (skb_cb->flags & ATH11K_SKB_CIPHER_SET) {
 			ti.encrypt_type =
 				ath11k_dp_tx_get_encrypt_type(skb_cb->cipher);
@@ -168,8 +168,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	ti.bss_ast_idx = arvif->ast_idx;
 	ti.dscp_tid_tbl_idx = 0;
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    ti.encap_type != HAL_TCL_ENCAP_TYPE_RAW) {
+	if (likely(skb->ip_summed == CHECKSUM_PARTIAL &&
+		   ti.encap_type != HAL_TCL_ENCAP_TYPE_RAW)) {
 		ti.flags0 |= FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_IP4_CKSUM_EN, 1) |
 			     FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_UDP4_CKSUM_EN, 1) |
 			     FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_UDP6_CKSUM_EN, 1) |
@@ -206,7 +206,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	}
 
 	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
-	if (dma_mapping_error(ab->dev, ti.paddr)) {
+	if (unlikely(dma_mapping_error(ab->dev, ti.paddr))) {
 		atomic_inc(&ab->soc_stats.tx_err.misc_fail);
 		ath11k_warn(ab, "failed to DMA map data Tx buffer\n");
 		ret = -ENOMEM;
@@ -226,7 +226,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	ath11k_hal_srng_access_begin(ab, tcl_ring);
 
 	hal_tcl_desc = (void *)ath11k_hal_srng_src_get_next_entry(ab, tcl_ring);
-	if (!hal_tcl_desc) {
+	if (unlikely(!hal_tcl_desc)) {
 		/* NOTE: It is highly unlikely we'll be running out of tcl_ring
 		 * desc because the desc is directly enqueued onto hw queue.
 		 */
@@ -240,8 +240,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		 * checking this ring earlier for each pkt tx.
 		 * Restart ring selection if some rings are not checked yet.
 		 */
-		if (ring_map != (BIT(DP_TCL_NUM_RING_MAX) - 1) &&
-		    !ar->ab->hw_params.tcl_0_only) {
+		if (unlikely(ring_map != (BIT(DP_TCL_NUM_RING_MAX) - 1) &&
+			     !ar->ab->hw_params.tcl_0_only)) {
 			tcl_ring_retry = true;
 			ring_selector++;
 		}
@@ -322,7 +322,7 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 
 	spin_lock_bh(&tx_ring->tx_idr_lock);
 	msdu = idr_find(&tx_ring->txbuf_idr, ts->msdu_id);
-	if (!msdu) {
+	if (unlikely(!msdu)) {
 		ath11k_warn(ab, "htt tx completion for unknown msdu_id %d\n",
 			    ts->msdu_id);
 		spin_unlock_bh(&tx_ring->tx_idr_lock);
@@ -432,12 +432,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 
 	rcu_read_lock();
 
-	if (!rcu_dereference(ab->pdevs_active[ar->pdev_idx])) {
+	if (unlikely(!rcu_dereference(ab->pdevs_active[ar->pdev_idx]))) {
 		dev_kfree_skb_any(msdu);
 		goto exit;
 	}
 
-	if (!skb_cb->vif) {
+	if (unlikely(!skb_cb->vif)) {
 		dev_kfree_skb_any(msdu);
 		goto exit;
 	}
@@ -460,7 +460,7 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 	    (info->flags & IEEE80211_TX_CTL_NO_ACK))
 		info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
 
-	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar)) {
+	if (unlikely(ath11k_debugfs_is_extd_tx_stats_enabled(ar))) {
 		if (ts->flags & HAL_TX_STATUS_FLAGS_FIRST_MSDU) {
 			if (ar->last_ppdu_id == 0) {
 				ar->last_ppdu_id = ts->ppdu_id;
@@ -500,11 +500,11 @@ static inline void ath11k_dp_tx_status_parse(struct ath11k_base *ab,
 {
 	ts->buf_rel_source =
 		FIELD_GET(HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE, desc->info0);
-	if (ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_FW &&
-	    ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)
+	if (unlikely(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_FW &&
+		     ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM))
 		return;
 
-	if (ts->buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW)
+	if (unlikely(ts->buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW))
 		return;
 
 	ts->status = FIELD_GET(HAL_WBM_RELEASE_INFO0_TQM_RELEASE_REASON,
@@ -551,8 +551,9 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 			ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_head);
 	}
 
-	if ((ath11k_hal_srng_dst_peek(ab, status_ring) != NULL) &&
-	    (ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_head) == tx_ring->tx_status_tail)) {
+	if (unlikely((ath11k_hal_srng_dst_peek(ab, status_ring) != NULL) &&
+		     (ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_head) ==
+		      tx_ring->tx_status_tail))) {
 		/* TODO: Process pending tx_status messages when kfifo_is_full() */
 		ath11k_warn(ab, "Unable to process some of the tx_status ring desc because status_fifo is full\n");
 	}
@@ -575,7 +576,7 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 		mac_id = FIELD_GET(DP_TX_DESC_ID_MAC_ID, desc_id);
 		msdu_id = FIELD_GET(DP_TX_DESC_ID_MSDU_ID, desc_id);
 
-		if (ts.buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW) {
+		if (unlikely(ts.buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW)) {
 			ath11k_dp_tx_process_htt_tx_complete(ab,
 							     (void *)tx_status,
 							     mac_id, msdu_id,
@@ -585,7 +586,7 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 
 		spin_lock_bh(&tx_ring->tx_idr_lock);
 		msdu = idr_find(&tx_ring->txbuf_idr, msdu_id);
-		if (!msdu) {
+		if (unlikely(!msdu)) {
 			ath11k_warn(ab, "tx completion for unknown msdu_id %d\n",
 				    msdu_id);
 			spin_unlock_bh(&tx_ring->tx_idr_lock);
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index eb52332dbe3f..32e90b13fac0 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4333,7 +4333,7 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 	}
 
 	ret = ath11k_dp_tx(ar, arvif, skb);
-	if (ret) {
+	if (unlikely(ret)) {
 		ath11k_warn(ar->ab, "failed to transmit frame %d\n", ret);
 		ieee80211_free_txskb(ar->hw, skb);
 	}
-- 
2.25.1

