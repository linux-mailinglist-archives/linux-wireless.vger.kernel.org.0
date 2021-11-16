Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C487452C7D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 09:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhKPIRL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 03:17:11 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:55467 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhKPIRJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 03:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637050453; x=1668586453;
  h=from:to:cc:subject:date:message-id;
  bh=cSgJke0QMG1KWogss1ZFzWebUpsEGINRXz9AVqdkDm4=;
  b=jYYscJLEMPflbPDQylhxbSyNIth5cLG1FUYRVFtN1WIBacBaMAvDSVAH
   dOAY8ML6rSaisMvJyymkGkITc9ebjiBJSKxDWoUfdI6PuBvDnr/QCPkei
   nPBloW2V4B3QgICsxrNStrOoSmj5zn5sNuYRDMxo98WVEZ7IvEEcU+oZG
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 16 Nov 2021 00:14:13 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 Nov 2021 00:14:11 -0800
X-QCInternal: smtphost
Received: from akalaise-linux.qualcomm.com ([10.201.26.157])
  by ironmsg02-blr.qualcomm.com with ESMTP; 16 Nov 2021 13:44:06 +0530
Received: by akalaise-linux.qualcomm.com (Postfix, from userid 2376239)
        id 30271221A0; Tue, 16 Nov 2021 13:44:05 +0530 (IST)
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <kathirve@codeaurora.org>
Subject: [PATCHv1 05/16] ath11k: fix destination monitor ring out of sync
Date:   Tue, 16 Nov 2021 13:43:25 +0530
Message-Id: <1637050405-28137-1-git-send-email-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Kathirvel <kathirve@codeaurora.org>

More than 20000 PPDU id jumping causing status ring and destination
ring processing not sync. The status ring is processed and the
destination ring is not processed. Since destination is not reaped for
so long, backpressure occurs at the destination ring.

To address this issue update the PPDU id with the latest PPDU, this
will allow the destination ring to be reaped and will prevent the
rings from getting out of sync.

Signed-off-by: Karthikeyan Kathirvel <kathirve@codeaurora.org>
---
v1 :
Addressed the below comments from Jouni Malinen and it is Rebased
0005-ath11k-fix-destination-monitor-ring-out-of-sync.patch
- dp_rx.c comment could be cleaned up:
+/* The destination ring processing is stuck if the destination is not
+ * moving while status ring moves 16 PPDU. the destination ring processing
+ * skips this destination ring PPDU as workaround
  "PPDU. the" --> "PPDU. The"
  "as workaround" --> "as a workaround."
- fine to send out with that addressed

 drivers/net/wireless/ath/ath11k/dp.h    |  3 +++
 drivers/net/wireless/ath/ath11k/dp_rx.c | 42 ++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index b0d0e7b..cc36b57 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -101,6 +101,8 @@ struct ath11k_pdev_mon_stats {
 	u32 dest_mpdu_drop;
 	u32 dup_mon_linkdesc_cnt;
 	u32 dup_mon_buf_cnt;
+	u32 dest_mon_stuck;
+	u32 dest_mon_not_reaped;
 };
 
 struct dp_link_desc_bank {
@@ -143,6 +145,7 @@ struct ath11k_mon_data {
 
 struct ath11k_pdev_dp {
 	u32 mac_id;
+	u32 mon_dest_ring_stuck_cnt;
 	atomic_t num_tx_pending;
 	wait_queue_head_t tx_empty_waitq;
 	struct dp_rxdma_ring rx_refill_buf_ring;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 3a9c362..d0b8829 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4939,6 +4939,12 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 	return -EINVAL;
 }
 
+/* The destination ring processing is stuck if the destination is not
+ * moving while status ring moves 16 PPDU. The destination ring processing
+ * skips this destination ring PPDU as a workaround.
+ */
+#define MON_DEST_RING_STUCK_MAX_CNT 16
+
 static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 					  u32 quota, struct napi_struct *napi)
 {
@@ -4951,6 +4957,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 	u32 ring_id;
 	struct ath11k_pdev_mon_stats *rx_mon_stats;
 	u32	 npackets = 0;
+	u32 mpdu_rx_bufs_used;
 
 	if (ar->ab->hw_params.rxdma1_enable)
 		ring_id = dp->rxdma_mon_dst_ring.ring_id;
@@ -4980,16 +4987,39 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 		head_msdu = NULL;
 		tail_msdu = NULL;
 
-		rx_bufs_used += ath11k_dp_rx_mon_mpdu_pop(ar, mac_id, ring_entry,
-							  &head_msdu,
-							  &tail_msdu,
-							  &npackets, &ppdu_id);
+		mpdu_rx_bufs_used = ath11k_dp_rx_mon_mpdu_pop(ar, mac_id, ring_entry,
+							      &head_msdu,
+							      &tail_msdu,
+							      &npackets, &ppdu_id);
+
+		rx_bufs_used += mpdu_rx_bufs_used;
+
+		if (mpdu_rx_bufs_used) {
+			dp->mon_dest_ring_stuck_cnt = 0;
+		} else {
+			dp->mon_dest_ring_stuck_cnt++;
+			rx_mon_stats->dest_mon_not_reaped++;
+		}
+
+		if (dp->mon_dest_ring_stuck_cnt > MON_DEST_RING_STUCK_MAX_CNT) {
+			rx_mon_stats->dest_mon_stuck++;
+			ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
+				   "status ring ppdu_id=%d dest ring ppdu_id=%d mon_dest_ring_stuck_cnt=%d dest_mon_not_reaped=%u dest_mon_stuck=%u\n",
+				   pmon->mon_ppdu_info.ppdu_id, ppdu_id,
+				   dp->mon_dest_ring_stuck_cnt,
+				   rx_mon_stats->dest_mon_not_reaped,
+				   rx_mon_stats->dest_mon_stuck);
+			pmon->mon_ppdu_info.ppdu_id = ppdu_id;
+			continue;
+		}
 
 		if (ppdu_id != pmon->mon_ppdu_info.ppdu_id) {
 			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
 			ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
-				   "dest_rx: new ppdu_id %x != status ppdu_id %x",
-				   ppdu_id, pmon->mon_ppdu_info.ppdu_id);
+				   "dest_rx: new ppdu_id %x != status ppdu_id %x dest_mon_not_reaped = %u dest_mon_stuck = %u\n",
+				   ppdu_id, pmon->mon_ppdu_info.ppdu_id,
+				   rx_mon_stats->dest_mon_not_reaped,
+				   rx_mon_stats->dest_mon_stuck);
 			break;
 		}
 		if (head_msdu && tail_msdu) {
-- 
2.7.4

