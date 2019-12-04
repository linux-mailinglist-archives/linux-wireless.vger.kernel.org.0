Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506F6112293
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 06:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfLDFh3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 00:37:29 -0500
Received: from nbd.name ([46.4.11.11]:56598 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbfLDFh2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 00:37:28 -0500
Received: from p5dcfb666.dip0.t-ipconnect.de ([93.207.182.102] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1icNLp-00089G-Vr; Wed, 04 Dec 2019 06:37:26 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [RESEND 9/9] ath11k: optimize ath11k_hal_tx_status_parse
Date:   Wed,  4 Dec 2019 06:37:13 +0100
Message-Id: <20191204053713.3064-10-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204053713.3064-1-john@phrozen.org>
References: <20191204053713.3064-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Moving the function into dp_tx.c allows gcc to optimize the code better
and also avoid chace invalidates and context switches.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/dp.h     |  2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c  | 38 +++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/hal_tx.c | 43 ------------------------
 drivers/net/wireless/ath/ath11k/hal_tx.h |  4 ---
 4 files changed, 37 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index d4011f902930..2f0980f2c762 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -57,7 +57,7 @@ struct dp_rxdma_ring {
 	int bufs_max;
 };
 
-#define ATH11K_TX_COMPL_NEXT(x)	((x + 1) % DP_TX_COMP_RING_SIZE)
+#define ATH11K_TX_COMPL_NEXT(x)	(((x) + 1) % DP_TX_COMP_RING_SIZE)
 
 struct dp_tx_ring {
 	u8 tcl_data_ring_id;
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 5d6403cf99ab..828f8984235e 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -423,6 +423,37 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 	rcu_read_unlock();
 }
 
+static inline void ath11k_hal_tx_status_parse(struct ath11k_base *ab,
+					      struct hal_wbm_release_ring *desc,
+					      struct hal_tx_status *ts)
+{
+	ts->buf_rel_source =
+		FIELD_GET(HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE, desc->info0);
+	if (ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_FW &&
+	    ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)
+		return;
+
+	if (ts->buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW)
+		return;
+
+	ts->status = FIELD_GET(HAL_WBM_RELEASE_INFO0_TQM_RELEASE_REASON,
+			       desc->info0);
+	ts->ppdu_id = FIELD_GET(HAL_WBM_RELEASE_INFO1_TQM_STATUS_NUMBER,
+				desc->info1);
+	ts->try_cnt = FIELD_GET(HAL_WBM_RELEASE_INFO1_TRANSMIT_COUNT,
+				desc->info1);
+	ts->ack_rssi = FIELD_GET(HAL_WBM_RELEASE_INFO2_ACK_FRAME_RSSI,
+				 desc->info2);
+	if (desc->info2 & HAL_WBM_RELEASE_INFO2_FIRST_MSDU)
+		ts->flags |= HAL_TX_STATUS_FLAGS_FIRST_MSDU;
+	ts->peer_id = FIELD_GET(HAL_WBM_RELEASE_INFO3_PEER_ID, desc->info3);
+	ts->tid = FIELD_GET(HAL_WBM_RELEASE_INFO3_TID, desc->info3);
+	if (desc->rate_stats.info0 & HAL_TX_RATE_STATS_INFO0_VALID)
+		ts->rate_stats = desc->rate_stats.info0;
+	else
+		ts->rate_stats = 0;
+}
+
 void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 {
 	struct ath11k *ar;
@@ -456,14 +487,17 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 
 	while (ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_tail) != tx_ring->tx_status_head) {
 		struct hal_wbm_release_ring *tx_status;
+		u32 desc_id;
 
 		tx_ring->tx_status_tail =
 			ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_tail);
 		tx_status = &tx_ring->tx_status[tx_ring->tx_status_tail];
 		ath11k_hal_tx_status_parse(ab, tx_status, &ts);
 
-		mac_id = FIELD_GET(DP_TX_DESC_ID_MAC_ID, ts.desc_id);
-		msdu_id = FIELD_GET(DP_TX_DESC_ID_MSDU_ID, ts.desc_id);
+		desc_id = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
+				    tx_status->buf_addr_info.info1);
+		mac_id = FIELD_GET(DP_TX_DESC_ID_MAC_ID, desc_id);
+		msdu_id = FIELD_GET(DP_TX_DESC_ID_MSDU_ID, desc_id);
 
 		if (ts.buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW) {
 			ath11k_dp_tx_process_htt_tx_complete(ab,
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index e8710bbbbc3a..e4aa7e8a1284 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -74,49 +74,6 @@ void ath11k_hal_tx_cmd_desc_setup(struct ath11k_base *ab, void *cmd,
 	tcl_cmd->info4 = 0;
 }
 
-void ath11k_hal_tx_status_parse(struct ath11k_base *ab,
-				struct hal_wbm_release_ring *desc,
-				struct hal_tx_status *ts)
-{
-	ts->buf_rel_source =
-		FIELD_GET(HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE, desc->info0);
-	if (ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_FW &&
-	    ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)
-		return;
-
-	ts->desc_id = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
-				desc->buf_addr_info.info1);
-
-	if (ts->buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW)
-		return;
-
-	ts->status = FIELD_GET(HAL_WBM_RELEASE_INFO0_TQM_RELEASE_REASON,
-			       desc->info0);
-	ts->ppdu_id = FIELD_GET(HAL_WBM_RELEASE_INFO1_TQM_STATUS_NUMBER,
-				desc->info1);
-	ts->try_cnt = FIELD_GET(HAL_WBM_RELEASE_INFO1_TRANSMIT_COUNT,
-				desc->info1);
-
-	ts->ack_rssi = FIELD_GET(HAL_WBM_RELEASE_INFO2_ACK_FRAME_RSSI,
-				 desc->info2);
-	if (desc->info2 & HAL_WBM_RELEASE_INFO2_FIRST_MSDU)
-		ts->flags |= HAL_TX_STATUS_FLAGS_FIRST_MSDU;
-
-	if (desc->info2 & HAL_WBM_RELEASE_INFO2_LAST_MSDU)
-		ts->flags |= HAL_TX_STATUS_FLAGS_LAST_MSDU;
-
-	if (desc->info2 & HAL_WBM_RELEASE_INFO2_MSDU_IN_AMSDU)
-		ts->flags |= HAL_TX_STATUS_FLAGS_MSDU_IN_AMSDU;
-
-	ts->peer_id = FIELD_GET(HAL_WBM_RELEASE_INFO3_PEER_ID, desc->info3);
-	ts->tid = FIELD_GET(HAL_WBM_RELEASE_INFO3_TID, desc->info3);
-
-	if (!(desc->rate_stats.info0 & HAL_TX_RATE_STATS_INFO0_VALID))
-		return;
-
-	ts->rate_stats = desc->rate_stats.info0;
-}
-
 void ath11k_hal_tx_set_dscp_tid_map(struct ath11k_base *ab, int id)
 {
 	u32 ctrl_reg_val;
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.h b/drivers/net/wireless/ath/ath11k/hal_tx.h
index 5fe89b729a6e..ce48a61bfb66 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.h
@@ -48,7 +48,6 @@ struct hal_tx_info {
 /* Tx status parsed from srng desc */
 struct hal_tx_status {
 	enum hal_wbm_rel_src_module buf_rel_source;
-	u32 desc_id;
 	enum hal_wbm_tqm_rel_reason status;
 	u8 ack_rssi;
 	u32 flags; /* %HAL_TX_STATUS_FLAGS_ */
@@ -61,9 +60,6 @@ struct hal_tx_status {
 
 void ath11k_hal_tx_cmd_desc_setup(struct ath11k_base *ab, void *cmd,
 				  struct hal_tx_info *ti);
-void ath11k_hal_tx_status_parse(struct ath11k_base *ab,
-				struct hal_wbm_release_ring *desc,
-				struct hal_tx_status *ts);
 void ath11k_hal_tx_set_dscp_tid_map(struct ath11k_base *ab, int id);
 int ath11k_hal_reo_cmd_send(struct ath11k_base *ab, struct hal_srng *srng,
 			    enum hal_reo_cmd_type type,
-- 
2.20.1

