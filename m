Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9EC48A639
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 04:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347695AbiAKDWp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jan 2022 22:22:45 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:14099 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347686AbiAKDWm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jan 2022 22:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641871361; x=1673407361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZgcrGhx08iS8crHPqjNxCujEzPNZ0N7sIjosO6tZNsQ=;
  b=g9M5BFTm3wxwvLDbrpNnobcZP+XnNmPCgclO7c39TnN82wELE4dVO9p9
   YYnLGBNXQGZKqi9WxQJcp5OxxBtEWzmJe/E8mIiCc96m8hbt0OsGVnMJ5
   WmhGDTMPeskNFlYuprnAUastkf+Zu8fAVL/S1c6lLXHSRBON8qqCSmOYO
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Jan 2022 19:22:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 19:22:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 10 Jan 2022 19:22:40 -0800
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 10 Jan 2022 19:22:39 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, Miles Hu <milehu@codeaurora.org>,
        "Aloka Dixit" <quic_alokad@quicinc.com>
Subject: [PATCH 1/2] ath11k: enable RX PPDU stats in monitor co-exist mode
Date:   Mon, 10 Jan 2022 19:22:23 -0800
Message-ID: <20220111032224.14093-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miles Hu <milehu@codeaurora.org>

RX PPDU statistics collection is missing when monitor mode co-exists
with other modes. This commit combines the processing of the destination
ring with the status ring to fix the issue.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01179-QCAHKSWPL_SILICONZ-1
Signed-off-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debugfs.c |  6 ++
 drivers/net/wireless/ath/ath11k/dp_rx.c   | 84 +++++++----------------
 drivers/net/wireless/ath/ath11k/hal_rx.h  |  8 +--
 3 files changed, 34 insertions(+), 64 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index ca68cf63dd27..1484d733f88a 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -664,6 +664,12 @@ static ssize_t ath11k_write_extd_rx_stats(struct file *file,
 		goto exit;
 	}
 
+	if (test_bit(ATH11K_FLAG_MONITOR_STARTED, &ar->monitor_flags)) {
+		ar->debug.extd_rx_stats = enable;
+		ret = count;
+		goto exit;
+	}
+
 	if (enable) {
 		rx_filter =  HTT_RX_FILTER_TLV_FLAGS_MPDU_START;
 		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_START;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index c212a789421e..808028285957 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -20,6 +20,9 @@
 
 #define ATH11K_DP_RX_FRAGMENT_TIMEOUT_MS (2 * HZ)
 
+static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
+					  u32 quota, struct napi_struct *napi);
+
 static inline
 u8 *ath11k_dp_rx_h_80211_hdr(struct ath11k_base *ab, struct hal_rx_desc *desc)
 {
@@ -3087,12 +3090,14 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 	enum hal_rx_mon_status hal_status;
 	struct sk_buff *skb;
 	struct sk_buff_head skb_list;
-	struct hal_rx_mon_ppdu_info ppdu_info;
 	struct ath11k_peer *peer;
 	struct ath11k_sta *arsta;
 	int num_buffs_reaped = 0;
 	u32 rx_buf_sz;
 	u16 log_type = 0;
+	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&ar->dp.mon_data;
+	struct ath11k_pdev_mon_stats *rx_mon_stats = &pmon->rx_mon_stats;
+	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
 
 	__skb_queue_head_init(&skb_list);
 
@@ -3101,8 +3106,8 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 	if (!num_buffs_reaped)
 		goto exit;
 
-	memset(&ppdu_info, 0, sizeof(ppdu_info));
-	ppdu_info.peer_id = HAL_INVALID_PEERID;
+	memset(ppdu_info, 0, sizeof(*ppdu_info));
+	ppdu_info->peer_id = HAL_INVALID_PEERID;
 
 	while ((skb = __skb_dequeue(&skb_list))) {
 		if (ath11k_debugfs_is_pktlog_lite_mode_enabled(ar)) {
@@ -3116,9 +3121,18 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		if (log_type)
 			trace_ath11k_htt_rxdesc(ar, skb->data, log_type, rx_buf_sz);
 
-		hal_status = ath11k_hal_rx_parse_mon_status(ab, &ppdu_info, skb);
+		hal_status = ath11k_hal_rx_parse_mon_status(ab, ppdu_info, skb);
 
-		if (ppdu_info.peer_id == HAL_INVALID_PEERID ||
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
 		    hal_status != HAL_RX_MON_STATUS_PPDU_DONE) {
 			dev_kfree_skb_any(skb);
 			continue;
@@ -3126,17 +3140,17 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 
 		rcu_read_lock();
 		spin_lock_bh(&ab->base_lock);
-		peer = ath11k_peer_find_by_id(ab, ppdu_info.peer_id);
+		peer = ath11k_peer_find_by_id(ab, ppdu_info->peer_id);
 
 		if (!peer || !peer->sta) {
 			ath11k_dbg(ab, ATH11K_DBG_DATA,
 				   "failed to find the peer with peer_id %d\n",
-				   ppdu_info.peer_id);
+				   ppdu_info->peer_id);
 			goto next_skb;
 		}
 
 		arsta = (struct ath11k_sta *)peer->sta->drv_priv;
-		ath11k_dp_rx_update_peer_stats(arsta, &ppdu_info);
+		ath11k_dp_rx_update_peer_stats(arsta, ppdu_info);
 
 		if (ath11k_debugfs_is_pktlog_peer_valid(ar, peer->addr))
 			trace_ath11k_htt_rxdesc(ar, skb->data, log_type, rx_buf_sz);
@@ -3146,8 +3160,8 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		rcu_read_unlock();
 
 		dev_kfree_skb_any(skb);
-		memset(&ppdu_info, 0, sizeof(ppdu_info));
-		ppdu_info.peer_id = HAL_INVALID_PEERID;
+		memset(ppdu_info, 0, sizeof(*ppdu_info));
+		ppdu_info->peer_id = HAL_INVALID_PEERID;
 	}
 exit:
 	return num_buffs_reaped;
@@ -5106,38 +5120,6 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 	}
 }
 
-static void ath11k_dp_rx_mon_status_process_tlv(struct ath11k *ar,
-						int mac_id, u32 quota,
-						struct napi_struct *napi)
-{
-	struct ath11k_pdev_dp *dp = &ar->dp;
-	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&dp->mon_data;
-	struct hal_rx_mon_ppdu_info *ppdu_info;
-	struct sk_buff *status_skb;
-	u32 tlv_status = HAL_TLV_STATUS_BUF_DONE;
-	struct ath11k_pdev_mon_stats *rx_mon_stats;
-
-	ppdu_info = &pmon->mon_ppdu_info;
-	rx_mon_stats = &pmon->rx_mon_stats;
-
-	if (pmon->mon_ppdu_status != DP_PPDU_STATUS_START)
-		return;
-
-	while (!skb_queue_empty(&pmon->rx_status_q)) {
-		status_skb = skb_dequeue(&pmon->rx_status_q);
-
-		tlv_status = ath11k_hal_rx_parse_mon_status(ar->ab, ppdu_info,
-							    status_skb);
-		if (tlv_status == HAL_TLV_STATUS_PPDU_DONE) {
-			rx_mon_stats->status_ppdu_done++;
-			pmon->mon_ppdu_status = DP_PPDU_STATUS_DONE;
-			ath11k_dp_rx_mon_dest_process(ar, mac_id, quota, napi);
-			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
-		}
-		dev_kfree_skb_any(status_skb);
-	}
-}
-
 static u32
 ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
 			       void *ring_entry, struct sk_buff **head_msdu,
@@ -5489,22 +5471,6 @@ static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
 	return quota;
 }
 
-static int ath11k_dp_mon_process_rx(struct ath11k_base *ab, int mac_id,
-				    struct napi_struct *napi, int budget)
-{
-	struct ath11k *ar = ath11k_ab_to_ar(ab, mac_id);
-	struct ath11k_pdev_dp *dp = &ar->dp;
-	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&dp->mon_data;
-	int num_buffs_reaped = 0;
-
-	num_buffs_reaped = ath11k_dp_rx_reap_mon_status_ring(ar->ab, mac_id, &budget,
-							     &pmon->rx_status_q);
-	if (num_buffs_reaped)
-		ath11k_dp_rx_mon_status_process_tlv(ar, mac_id, budget, napi);
-
-	return num_buffs_reaped;
-}
-
 int ath11k_dp_rx_process_mon_rings(struct ath11k_base *ab, int mac_id,
 				   struct napi_struct *napi, int budget)
 {
@@ -5514,8 +5480,6 @@ int ath11k_dp_rx_process_mon_rings(struct ath11k_base *ab, int mac_id,
 	if (test_bit(ATH11K_FLAG_MONITOR_STARTED, &ar->monitor_flags) &&
 	    ab->hw_params.full_monitor_mode)
 		ret = ath11k_dp_full_mon_process_rx(ab, mac_id, napi, budget);
-	else if (test_bit(ATH11K_FLAG_MONITOR_STARTED, &ar->monitor_flags))
-		ret = ath11k_dp_mon_process_rx(ab, mac_id, napi, budget);
 	else
 		ret = ath11k_dp_rx_process_mon_status(ab, mac_id, napi, budget);
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index 571054c6d7f8..7bba4f0411e1 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -65,10 +65,6 @@ enum hal_rx_reception_type {
 	HAL_RX_RECEPTION_TYPE_MAX,
 };
 
-#define HAL_TLV_STATUS_PPDU_NOT_DONE            0
-#define HAL_TLV_STATUS_PPDU_DONE                1
-#define HAL_TLV_STATUS_BUF_DONE                 2
-#define HAL_TLV_STATUS_PPDU_NON_STD_DONE        3
 #define HAL_RX_FCS_LEN                          4
 
 enum hal_rx_mon_status {
@@ -77,6 +73,10 @@ enum hal_rx_mon_status {
 	HAL_RX_MON_STATUS_BUF_DONE,
 };
 
+#define HAL_TLV_STATUS_PPDU_NOT_DONE    HAL_RX_MON_STATUS_PPDU_NOT_DONE
+#define HAL_TLV_STATUS_PPDU_DONE        HAL_RX_MON_STATUS_PPDU_DONE
+#define HAL_TLV_STATUS_BUF_DONE         HAL_RX_MON_STATUS_BUF_DONE
+
 struct hal_sw_mon_ring_entries {
 	dma_addr_t mon_dst_paddr;
 	dma_addr_t mon_status_paddr;

base-commit: 5fb5c140c01092fc4b47109653f35e0cc7f5cadc
-- 
2.31.1

