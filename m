Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B474B4B068B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 07:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiBJGrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 01:47:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiBJGrW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 01:47:22 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9BA10A8
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 22:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644475644; x=1676011644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8PsGU9fxPxF4Mkq8GiWx/hKa+JpNG+XyHSIpxbmK1Es=;
  b=F+nhspHMRi2ax1qJb/8yO32DUqEQyhL5427Zmcgqcldw9evrw3nFwbkH
   9QnKVeE3Lp8HaBhU6BmW37MYUFVNXm8AYXmeGafowAD2zIwN5i86f0xaQ
   TgZ9QFLJHeR2W1xESobh2buBp+RbOetlNrD8bwCm4aWihhs3ROQIxZlkM
   k=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 Feb 2022 22:47:24 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 22:47:24 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 22:47:24 -0800
Received: from akalaise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 22:47:22 -0800
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Subject: [PATCH v4] ath11k: fix destination monitor ring out of sync
Date:   Thu, 10 Feb 2022 12:17:06 +0530
Message-ID: <20220210064706.6171-1-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

More than 20000 PPDU id jumping causing status ring and destination
ring processing not sync. The status ring is processed and the
destination ring is not processed. Since destination is not reaped for
so long, backpressure occurs at the destination ring.

To address this issue update the PPDU id with the latest PPDU, this
will allow the destination ring to be reaped and will prevent the
rings from getting out of sync.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1.r1-00026-QCAHKSWPL_SILICONZ-2
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
v4:
	Rebased and added base details
v3:
	Added Tested-on tag
v2:
	Corrected the signed off details

 drivers/net/wireless/ath/ath11k/dp.h    |  3 ++
 drivers/net/wireless/ath/ath11k/dp_rx.c | 42 +++++++++++++++++++++----
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 409d6cc5a1d5..b6ec2d6a2bb6 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -115,6 +115,8 @@ struct ath11k_pdev_mon_stats {
 	u32 dest_mpdu_drop;
 	u32 dup_mon_linkdesc_cnt;
 	u32 dup_mon_buf_cnt;
+	u32 dest_mon_stuck;
+	u32 dest_mon_not_reaped;
 };
 
 struct dp_full_mon_mpdu {
@@ -167,6 +169,7 @@ struct ath11k_mon_data {
 
 struct ath11k_pdev_dp {
 	u32 mac_id;
+	u32 mon_dest_ring_stuck_cnt;
 	atomic_t num_tx_pending;
 	wait_queue_head_t tx_empty_waitq;
 	struct dp_rxdma_ring rx_refill_buf_ring;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 99dc9b5bbf4b..20c9e7904261 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4959,6 +4959,12 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
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
@@ -4972,6 +4978,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 	u32 ring_id;
 	struct ath11k_pdev_mon_stats *rx_mon_stats;
 	u32	 npackets = 0;
+	u32 mpdu_rx_bufs_used;
 
 	if (ar->ab->hw_params.rxdma1_enable)
 		ring_id = dp->rxdma_mon_dst_ring.ring_id;
@@ -5001,16 +5008,39 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
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

base-commit: 9d2612e898b29539a5f395aa03487a826fe70ecf
-- 
2.23.0

