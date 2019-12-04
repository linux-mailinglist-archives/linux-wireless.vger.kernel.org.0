Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868F211339D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 19:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfLDSSE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 13:18:04 -0500
Received: from nbd.name ([46.4.11.11]:40966 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731842AbfLDSSC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 13:18:02 -0500
Received: from p5dcfb666.dip0.t-ipconnect.de ([93.207.182.102] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1icZDp-0005Od-Fc; Wed, 04 Dec 2019 19:17:57 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 8/9] ath11k: optimise ath11k_dp_tx_completion_handler
Date:   Wed,  4 Dec 2019 19:17:44 +0100
Message-Id: <20191204181745.27297-9-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204181745.27297-1-john@phrozen.org>
References: <20191204181745.27297-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

the current code does 4 memcpys for each completion frame.
1) duplicate the desc
2 + 3) inside kfifo insertion
4) kfifo remove

The code simply drops the kfifo and uses a trivial ring buffer. This
requires a single memcpy for insertion. There is no removal needed as
we can simply use the inserted data for processing. As the code runs
inside the NAPI context it is atomic and there is no need for most of
the locking.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/dp.c     | 16 ++++-----
 drivers/net/wireless/ath/ath11k/dp.h     | 11 +++----
 drivers/net/wireless/ath/ath11k/dp_tx.c  | 41 +++++++++---------------
 drivers/net/wireless/ath/ath11k/hal_tx.c | 13 --------
 drivers/net/wireless/ath/ath11k/hal_tx.h |  2 --
 5 files changed, 27 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index b966a16a930f..ef989795e985 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  */
 
-#include <linux/kfifo.h>
 #include "core.h"
 #include "dp_tx.h"
 #include "hal_tx.h"
@@ -828,10 +827,7 @@ void ath11k_dp_free(struct ath11k_base *ab)
 			     ath11k_dp_tx_pending_cleanup, ab);
 		idr_destroy(&dp->tx_ring[i].txbuf_idr);
 		spin_unlock_bh(&dp->tx_ring[i].tx_idr_lock);
-
-		spin_lock_bh(&dp->tx_ring[i].tx_status_lock);
-		kfifo_free(&dp->tx_ring[i].tx_status_fifo);
-		spin_unlock_bh(&dp->tx_ring[i].tx_status_lock);
+		kfree(&dp->tx_ring[i].tx_status);
 	}
 
 	/* Deinit any SOC level resource */
@@ -871,17 +867,17 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 	if (ret)
 		goto fail_link_desc_cleanup;
 
-	size = roundup_pow_of_two(DP_TX_COMP_RING_SIZE);
+	size = sizeof(struct hal_wbm_release_ring) * DP_TX_COMP_RING_SIZE;
 
 	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++) {
 		idr_init(&dp->tx_ring[i].txbuf_idr);
 		spin_lock_init(&dp->tx_ring[i].tx_idr_lock);
 		dp->tx_ring[i].tcl_data_ring_id = i;
 
-		spin_lock_init(&dp->tx_ring[i].tx_status_lock);
-		ret = kfifo_alloc(&dp->tx_ring[i].tx_status_fifo, size,
-				  GFP_KERNEL);
-		if (ret)
+		dp->tx_ring[i].tx_status_head = 0;
+		dp->tx_ring[i].tx_status_tail = DP_TX_COMP_RING_SIZE - 1;
+		dp->tx_ring[i].tx_status = kmalloc(size, GFP_KERNEL);
+		if (!dp->tx_ring[i].tx_status)
 			goto fail_cmn_srng_cleanup;
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index f7e53509ae07..d4011f902930 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -6,7 +6,6 @@
 #ifndef ATH11K_DP_H
 #define ATH11K_DP_H
 
-#include <linux/kfifo.h>
 #include "hal_rx.h"
 
 struct ath11k_base;
@@ -58,6 +57,8 @@ struct dp_rxdma_ring {
 	int bufs_max;
 };
 
+#define ATH11K_TX_COMPL_NEXT(x)	((x + 1) % DP_TX_COMP_RING_SIZE)
+
 struct dp_tx_ring {
 	u8 tcl_data_ring_id;
 	struct dp_srng tcl_data_ring;
@@ -65,11 +66,9 @@ struct dp_tx_ring {
 	struct idr txbuf_idr;
 	/* Protects txbuf_idr and num_pending */
 	spinlock_t tx_idr_lock;
-	DECLARE_KFIFO_PTR(tx_status_fifo, struct hal_wbm_release_ring);
-	/* lock to protect tx_status_fifo because tx_status_fifo can be
-	 * accessed concurrently.
-	 */
-	spinlock_t tx_status_lock;
+	struct hal_wbm_release_ring *tx_status;
+	int tx_status_head;
+	int tx_status_tail;
 };
 
 struct ath11k_pdev_mon_stats {
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 28ebc414533e..5d6403cf99ab 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -79,7 +79,6 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	struct hal_srng *tcl_ring;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct dp_tx_ring *tx_ring;
-	u8 cached_desc[HAL_TCL_DESC_LEN];
 	void *hal_tcl_desc;
 	u8 pool_id;
 	u8 hal_ring_id;
@@ -167,8 +166,6 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	skb_cb->vif = arvif->vif;
 	skb_cb->ar = ar;
 
-	ath11k_hal_tx_cmd_desc_setup(ab, cached_desc, &ti);
-
 	hal_ring_id = tx_ring->tcl_data_ring.ring_id;
 	tcl_ring = &ab->hal.srng_list[hal_ring_id];
 
@@ -188,7 +185,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		goto fail_unmap_dma;
 	}
 
-	ath11k_hal_tx_desc_sync(cached_desc, hal_tcl_desc);
+	ath11k_hal_tx_cmd_desc_setup(ab, hal_tcl_desc +
+					 sizeof(struct hal_tlv_hdr), &ti);
 
 	ath11k_hal_srng_access_end(ab, tcl_ring);
 
@@ -432,47 +430,44 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
 	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
 	struct sk_buff *msdu;
-	struct hal_wbm_release_ring tx_status;
 	struct hal_tx_status ts;
 	struct dp_tx_ring *tx_ring = &dp->tx_ring[ring_id];
 	u32 *desc;
 	u32 msdu_id;
 	u8 mac_id;
 
-	spin_lock_bh(&status_ring->lock);
-
 	ath11k_hal_srng_access_begin(ab, status_ring);
 
-	spin_lock_bh(&tx_ring->tx_status_lock);
-	while (!kfifo_is_full(&tx_ring->tx_status_fifo) &&
+	while ((ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_head) != tx_ring->tx_status_tail) &&
 	       (desc = ath11k_hal_srng_dst_get_next_entry(ab, status_ring))) {
-		ath11k_hal_tx_status_desc_sync((void *)desc,
-					       (void *)&tx_status);
-		kfifo_put(&tx_ring->tx_status_fifo, tx_status);
+		memcpy(&tx_ring->tx_status[tx_ring->tx_status_head],
+		       desc, sizeof(struct hal_wbm_release_ring));
+		tx_ring->tx_status_head =
+			ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_head);
 	}
 
 	if ((ath11k_hal_srng_dst_peek(ab, status_ring) != NULL) &&
-	    kfifo_is_full(&tx_ring->tx_status_fifo)) {
+	    (ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_head) == tx_ring->tx_status_tail)) {
 		/* TODO: Process pending tx_status messages when kfifo_is_full() */
 		ath11k_warn(ab, "Unable to process some of the tx_status ring desc because status_fifo is full\n");
 	}
 
-	spin_unlock_bh(&tx_ring->tx_status_lock);
-
 	ath11k_hal_srng_access_end(ab, status_ring);
-	spin_unlock_bh(&status_ring->lock);
 
-	spin_lock_bh(&tx_ring->tx_status_lock);
-	while (kfifo_get(&tx_ring->tx_status_fifo, &tx_status)) {
-		memset(&ts, 0, sizeof(ts));
-		ath11k_hal_tx_status_parse(ab, &tx_status, &ts);
+	while (ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_tail) != tx_ring->tx_status_head) {
+		struct hal_wbm_release_ring *tx_status;
+
+		tx_ring->tx_status_tail =
+			ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_tail);
+		tx_status = &tx_ring->tx_status[tx_ring->tx_status_tail];
+		ath11k_hal_tx_status_parse(ab, tx_status, &ts);
 
 		mac_id = FIELD_GET(DP_TX_DESC_ID_MAC_ID, ts.desc_id);
 		msdu_id = FIELD_GET(DP_TX_DESC_ID_MSDU_ID, ts.desc_id);
 
 		if (ts.buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW) {
 			ath11k_dp_tx_process_htt_tx_complete(ab,
-							     (void *)&tx_status,
+							     (void *)tx_status,
 							     mac_id, msdu_id,
 							     tx_ring);
 			continue;
@@ -494,12 +489,8 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 		if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 			wake_up(&ar->dp.tx_empty_waitq);
 
-		/* TODO: Locking optimization so that tx_completion for an msdu
-		 * is not called with tx_status_lock acquired
-		 */
 		ath11k_dp_tx_complete_msdu(ar, msdu, &ts);
 	}
-	spin_unlock_bh(&tx_ring->tx_status_lock);
 }
 
 int ath11k_dp_tx_send_reo_cmd(struct ath11k_base *ab, struct dp_rx_tid *rx_tid,
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index c2a3a9d2e534..e8710bbbbc3a 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -74,19 +74,6 @@ void ath11k_hal_tx_cmd_desc_setup(struct ath11k_base *ab, void *cmd,
 	tcl_cmd->info4 = 0;
 }
 
-/* Commit the descriptor to hardware */
-void ath11k_hal_tx_desc_sync(void *tx_desc_cached, void *hw_desc)
-{
-	memcpy(hw_desc + sizeof(struct hal_tlv_hdr), tx_desc_cached,
-	       sizeof(struct hal_tcl_data_cmd));
-}
-
-/* Get the descriptor status from hardware */
-void ath11k_hal_tx_status_desc_sync(void *hw_desc, void *local_desc)
-{
-	memcpy(local_desc, hw_desc, HAL_TX_STATUS_DESC_LEN);
-}
-
 void ath11k_hal_tx_status_parse(struct ath11k_base *ab,
 				struct hal_wbm_release_ring *desc,
 				struct hal_tx_status *ts)
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.h b/drivers/net/wireless/ath/ath11k/hal_tx.h
index cf99e2b31f9f..5fe89b729a6e 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.h
@@ -61,11 +61,9 @@ struct hal_tx_status {
 
 void ath11k_hal_tx_cmd_desc_setup(struct ath11k_base *ab, void *cmd,
 				  struct hal_tx_info *ti);
-void ath11k_hal_tx_desc_sync(void *tx_desc_cached, void *hw_desc);
 void ath11k_hal_tx_status_parse(struct ath11k_base *ab,
 				struct hal_wbm_release_ring *desc,
 				struct hal_tx_status *ts);
-void ath11k_hal_tx_status_desc_sync(void *hw_desc, void *local_desc);
 void ath11k_hal_tx_set_dscp_tid_map(struct ath11k_base *ab, int id);
 int ath11k_hal_reo_cmd_send(struct ath11k_base *ab, struct hal_srng *srng,
 			    enum hal_reo_cmd_type type,
-- 
2.20.1

