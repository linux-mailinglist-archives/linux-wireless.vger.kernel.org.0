Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D81F48A638
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 04:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347690AbiAKDWn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jan 2022 22:22:43 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:9089 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347689AbiAKDWm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jan 2022 22:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641871362; x=1673407362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Cw4rDP+RYjuZO6d4cwEyDLOdnC0GrQsNvCDwBomVYg=;
  b=hoFzjGKExYqA89NYE29RJ2agK0VgH7qiWNejnzbUe6yVPT1nPX6YNiOl
   Wgv27PpZrrjqTAijY9pcE2jwsNz+yMmsogD9F8+qAMLPD3Z+VUpGFxCTy
   UtpUmDCNRq2680UVdh7AP1vrIUCJbUzFQoxIy88et17Estujh0ArqiMDo
   k=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 10 Jan 2022 19:22:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 19:22:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 10 Jan 2022 19:22:41 -0800
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 10 Jan 2022 19:22:40 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 2/2] ath11k: move function ath11k_dp_rx_process_mon_status
Date:   Mon, 10 Jan 2022 19:22:24 -0800
Message-ID: <20220111032224.14093-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111032224.14093-1-quic_alokad@quicinc.com>
References: <20220111032224.14093-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move the function below ath11k_dp_rx_mon_dest_process() and remove
the forward declaration.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01179-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 171 ++++++++++++------------
 1 file changed, 84 insertions(+), 87 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 808028285957..ab57ed650ec7 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -20,9 +20,6 @@
 
 #define ATH11K_DP_RX_FRAGMENT_TIMEOUT_MS (2 * HZ)
 
-static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
-					  u32 quota, struct napi_struct *napi);
-
 static inline
 u8 *ath11k_dp_rx_h_80211_hdr(struct ath11k_base *ab, struct hal_rx_desc *desc)
 {
@@ -3083,90 +3080,6 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 	return num_buffs_reaped;
 }
 
-int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
-				    struct napi_struct *napi, int budget)
-{
-	struct ath11k *ar = ath11k_ab_to_ar(ab, mac_id);
-	enum hal_rx_mon_status hal_status;
-	struct sk_buff *skb;
-	struct sk_buff_head skb_list;
-	struct ath11k_peer *peer;
-	struct ath11k_sta *arsta;
-	int num_buffs_reaped = 0;
-	u32 rx_buf_sz;
-	u16 log_type = 0;
-	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&ar->dp.mon_data;
-	struct ath11k_pdev_mon_stats *rx_mon_stats = &pmon->rx_mon_stats;
-	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
-
-	__skb_queue_head_init(&skb_list);
-
-	num_buffs_reaped = ath11k_dp_rx_reap_mon_status_ring(ab, mac_id, &budget,
-							     &skb_list);
-	if (!num_buffs_reaped)
-		goto exit;
-
-	memset(ppdu_info, 0, sizeof(*ppdu_info));
-	ppdu_info->peer_id = HAL_INVALID_PEERID;
-
-	while ((skb = __skb_dequeue(&skb_list))) {
-		if (ath11k_debugfs_is_pktlog_lite_mode_enabled(ar)) {
-			log_type = ATH11K_PKTLOG_TYPE_LITE_RX;
-			rx_buf_sz = DP_RX_BUFFER_SIZE_LITE;
-		} else if (ath11k_debugfs_is_pktlog_rx_stats_enabled(ar)) {
-			log_type = ATH11K_PKTLOG_TYPE_RX_STATBUF;
-			rx_buf_sz = DP_RX_BUFFER_SIZE;
-		}
-
-		if (log_type)
-			trace_ath11k_htt_rxdesc(ar, skb->data, log_type, rx_buf_sz);
-
-		hal_status = ath11k_hal_rx_parse_mon_status(ab, ppdu_info, skb);
-
-		if (test_bit(ATH11K_FLAG_MONITOR_STARTED, &ar->monitor_flags) &&
-		    pmon->mon_ppdu_status == DP_PPDU_STATUS_START &&
-		    hal_status == HAL_TLV_STATUS_PPDU_DONE) {
-			rx_mon_stats->status_ppdu_done++;
-			pmon->mon_ppdu_status = DP_PPDU_STATUS_DONE;
-			ath11k_dp_rx_mon_dest_process(ar, mac_id, budget, napi);
-			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
-		}
-
-		if (ppdu_info->peer_id == HAL_INVALID_PEERID ||
-		    hal_status != HAL_RX_MON_STATUS_PPDU_DONE) {
-			dev_kfree_skb_any(skb);
-			continue;
-		}
-
-		rcu_read_lock();
-		spin_lock_bh(&ab->base_lock);
-		peer = ath11k_peer_find_by_id(ab, ppdu_info->peer_id);
-
-		if (!peer || !peer->sta) {
-			ath11k_dbg(ab, ATH11K_DBG_DATA,
-				   "failed to find the peer with peer_id %d\n",
-				   ppdu_info->peer_id);
-			goto next_skb;
-		}
-
-		arsta = (struct ath11k_sta *)peer->sta->drv_priv;
-		ath11k_dp_rx_update_peer_stats(arsta, ppdu_info);
-
-		if (ath11k_debugfs_is_pktlog_peer_valid(ar, peer->addr))
-			trace_ath11k_htt_rxdesc(ar, skb->data, log_type, rx_buf_sz);
-
-next_skb:
-		spin_unlock_bh(&ab->base_lock);
-		rcu_read_unlock();
-
-		dev_kfree_skb_any(skb);
-		memset(ppdu_info, 0, sizeof(*ppdu_info));
-		ppdu_info->peer_id = HAL_INVALID_PEERID;
-	}
-exit:
-	return num_buffs_reaped;
-}
-
 static void ath11k_dp_rx_frag_timer(struct timer_list *timer)
 {
 	struct dp_rx_tid *rx_tid = from_timer(rx_tid, timer, frag_timer);
@@ -5120,6 +5033,90 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 	}
 }
 
+int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
+				    struct napi_struct *napi, int budget)
+{
+	struct ath11k *ar = ath11k_ab_to_ar(ab, mac_id);
+	enum hal_rx_mon_status hal_status;
+	struct sk_buff *skb;
+	struct sk_buff_head skb_list;
+	struct ath11k_peer *peer;
+	struct ath11k_sta *arsta;
+	int num_buffs_reaped = 0;
+	u32 rx_buf_sz;
+	u16 log_type = 0;
+	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&ar->dp.mon_data;
+	struct ath11k_pdev_mon_stats *rx_mon_stats = &pmon->rx_mon_stats;
+	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
+
+	__skb_queue_head_init(&skb_list);
+
+	num_buffs_reaped = ath11k_dp_rx_reap_mon_status_ring(ab, mac_id, &budget,
+							     &skb_list);
+	if (!num_buffs_reaped)
+		goto exit;
+
+	memset(ppdu_info, 0, sizeof(*ppdu_info));
+	ppdu_info->peer_id = HAL_INVALID_PEERID;
+
+	while ((skb = __skb_dequeue(&skb_list))) {
+		if (ath11k_debugfs_is_pktlog_lite_mode_enabled(ar)) {
+			log_type = ATH11K_PKTLOG_TYPE_LITE_RX;
+			rx_buf_sz = DP_RX_BUFFER_SIZE_LITE;
+		} else if (ath11k_debugfs_is_pktlog_rx_stats_enabled(ar)) {
+			log_type = ATH11K_PKTLOG_TYPE_RX_STATBUF;
+			rx_buf_sz = DP_RX_BUFFER_SIZE;
+		}
+
+		if (log_type)
+			trace_ath11k_htt_rxdesc(ar, skb->data, log_type, rx_buf_sz);
+
+		hal_status = ath11k_hal_rx_parse_mon_status(ab, ppdu_info, skb);
+
+		if (test_bit(ATH11K_FLAG_MONITOR_STARTED, &ar->monitor_flags) &&
+		    pmon->mon_ppdu_status == DP_PPDU_STATUS_START &&
+		    hal_status == HAL_TLV_STATUS_PPDU_DONE) {
+			rx_mon_stats->status_ppdu_done++;
+			pmon->mon_ppdu_status = DP_PPDU_STATUS_DONE;
+			ath11k_dp_rx_mon_dest_process(ar, mac_id, budget, napi);
+			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
+		}
+
+		if (ppdu_info->peer_id == HAL_INVALID_PEERID ||
+		    hal_status != HAL_RX_MON_STATUS_PPDU_DONE) {
+			dev_kfree_skb_any(skb);
+			continue;
+		}
+
+		rcu_read_lock();
+		spin_lock_bh(&ab->base_lock);
+		peer = ath11k_peer_find_by_id(ab, ppdu_info->peer_id);
+
+		if (!peer || !peer->sta) {
+			ath11k_dbg(ab, ATH11K_DBG_DATA,
+				   "failed to find the peer with peer_id %d\n",
+				   ppdu_info->peer_id);
+			goto next_skb;
+		}
+
+		arsta = (struct ath11k_sta *)peer->sta->drv_priv;
+		ath11k_dp_rx_update_peer_stats(arsta, ppdu_info);
+
+		if (ath11k_debugfs_is_pktlog_peer_valid(ar, peer->addr))
+			trace_ath11k_htt_rxdesc(ar, skb->data, log_type, rx_buf_sz);
+
+next_skb:
+		spin_unlock_bh(&ab->base_lock);
+		rcu_read_unlock();
+
+		dev_kfree_skb_any(skb);
+		memset(ppdu_info, 0, sizeof(*ppdu_info));
+		ppdu_info->peer_id = HAL_INVALID_PEERID;
+	}
+exit:
+	return num_buffs_reaped;
+}
+
 static u32
 ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
 			       void *ring_entry, struct sk_buff **head_msdu,
-- 
2.31.1

