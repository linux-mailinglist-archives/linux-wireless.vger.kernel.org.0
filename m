Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3925127E719
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 12:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgI3Kvg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 06:51:36 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:14816 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbgI3Kvg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 06:51:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601463095; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=1mTf62OHh6/92uHucnCLiUNOl9/5XkejeXknVPwpHl0=; b=RQcRlquJ3D43KTgvzO+nNVJXMD0MZFY30kyk9H6Pos0cEpGV+FBO3mW+QpqHSYgi6aadUk4g
 E8ZOBrFvUfOMJtDd7R9wJyEGzxJ+tFQeSamMMW02+fbZu16T2hnnEMqoD49NpmEhToQrZBJS
 TYtgpByZSKokmB4uWb0g7w+lr2o=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f7463291fdd3a1390aa02b7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 10:51:21
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A33B7C433FF; Wed, 30 Sep 2020 10:51:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC07DC433C8;
        Wed, 30 Sep 2020 10:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC07DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/5] ath11k: add packet log support for QCA6390
Date:   Wed, 30 Sep 2020 13:51:09 +0300
Message-Id: <1601463073-12106-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601463073-12106-1-git-send-email-kvalo@codeaurora.org>
References: <1601463073-12106-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Add packet log support for QCA6390, otherwise the data connection will stall
within a minute or so.  Enable it via debugfs and use trace-cmd to capture the
pktlogs.

echo 0xffff 1 > /sys/kernel/debug/ath11k/qca6390\ hw2.0/mac0/pktlog_filter

The mon status ring doesn't support interrupt so far, so host starts
a timer to reap this ring. The timer handler also reaps the
rxdma_err_dst_ring in case of monitor mode.

As QCA6390 requires bss created ahead of starting vdev, so check
vdev_start_delay for monitor mode.

For QCA6390, it uses wbm_desc_rel_ring to return descriptors.
It also uses rx_refill_buf_ring to fill mon buffer instead of
rxdma_mon_buf_ring.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h   |   3 +
 drivers/net/wireless/ath/ath11k/dp.c     |   2 +
 drivers/net/wireless/ath/ath11k/dp.h     |   3 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c  | 108 +++++++++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/dp_tx.c  |  77 +++++++++++++++-------
 drivers/net/wireless/ath/ath11k/hal.c    |   2 +
 drivers/net/wireless/ath/ath11k/hal_rx.c |   4 +-
 drivers/net/wireless/ath/ath11k/hal_rx.h |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c    |  24 ++++++-
 9 files changed, 169 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 02a87027c4e4..18b97420f0d8 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -37,6 +37,8 @@
 
 extern unsigned int ath11k_frame_mode;
 
+#define ATH11K_MON_TIMER_INTERVAL  10
+
 enum ath11k_supported_bw {
 	ATH11K_BW_20	= 0,
 	ATH11K_BW_40	= 1,
@@ -727,6 +729,7 @@ struct ath11k_base {
 	struct ath11k_dbring_cap *db_caps;
 	u32 num_db_cap;
 
+	struct timer_list mon_reap_timer;
 	/* must be last */
 	u8 drv_priv[0] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 29a614227658..0802f5b05fe8 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -828,6 +828,8 @@ void ath11k_dp_pdev_free(struct ath11k_base *ab)
 	struct ath11k *ar;
 	int i;
 
+	del_timer_sync(&ab->mon_reap_timer);
+
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
 		ath11k_dp_rx_pdev_free(ab, i);
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 558f03fbec99..5402d5ad2e5a 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -40,6 +40,7 @@ struct dp_rx_tid {
 
 #define DP_REO_DESC_FREE_THRESHOLD  64
 #define DP_REO_DESC_FREE_TIMEOUT_MS 1000
+#define DP_MON_SERVICE_BUDGET       128
 
 struct dp_reo_cache_flush_elem {
 	struct list_head list;
@@ -497,7 +498,7 @@ struct htt_ppdu_stats_cfg_cmd {
 } __packed;
 
 #define HTT_PPDU_STATS_CFG_MSG_TYPE		GENMASK(7, 0)
-#define HTT_PPDU_STATS_CFG_PDEV_ID		GENMASK(16, 9)
+#define HTT_PPDU_STATS_CFG_PDEV_ID		GENMASK(15, 8)
 #define HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK	GENMASK(31, 16)
 
 enum htt_ppdu_stats_tag_type {
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 37668a2b42cf..01625327eef7 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -262,6 +262,18 @@ static u32 ath11k_dp_rxdesc_get_ppduid(struct hal_rx_desc *rx_desc)
 	return __le16_to_cpu(rx_desc->mpdu_start.phy_ppdu_id);
 }
 
+static void ath11k_dp_service_mon_ring(struct timer_list *t)
+{
+	struct ath11k_base *ab = from_timer(ab, t, mon_reap_timer);
+	int i;
+
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++)
+		ath11k_dp_rx_process_mon_rings(ab, i, NULL, DP_MON_SERVICE_BUDGET);
+
+	mod_timer(&ab->mon_reap_timer, jiffies +
+		  msecs_to_jiffies(ATH11K_MON_TIMER_INTERVAL));
+}
+
 /* Returns number of Rx buffers replenished */
 int ath11k_dp_rxbufs_replenish(struct ath11k_base *ab, int mac_id,
 			       struct dp_rxdma_ring *rx_ring,
@@ -569,9 +581,14 @@ static int ath11k_dp_rx_pdev_srng_alloc(struct ath11k *ar)
 	/* if rxdma1_enable is false, then it doesn't need
 	 * to setup rxdam_mon_buf_ring, rxdma_mon_dst_ring
 	 * and rxdma_mon_desc_ring.
+	 * init reap timer for QCA6390.
 	 */
-	if (!ar->ab->hw_params.rxdma1_enable)
+	if (!ar->ab->hw_params.rxdma1_enable) {
+		//init mon status buffer reap timer
+		timer_setup(&ar->ab->mon_reap_timer,
+			    ath11k_dp_service_mon_ring, 0);
 		return 0;
+	}
 
 	ret = ath11k_dp_srng_setup(ar->ab,
 				   &dp->rxdma_mon_buf_ring.refill_buf_ring,
@@ -4289,8 +4306,13 @@ int ath11k_dp_rx_monitor_link_desc_return(struct ath11k *ar,
 	void *src_srng_desc;
 	int ret = 0;
 
-	dp_srng = &dp->rxdma_mon_desc_ring;
-	hal_srng = &ar->ab->hal.srng_list[dp_srng->ring_id];
+	if (ar->ab->hw_params.rxdma1_enable) {
+		dp_srng = &dp->rxdma_mon_desc_ring;
+		hal_srng = &ar->ab->hal.srng_list[dp_srng->ring_id];
+	} else {
+		dp_srng = &ar->ab->dp.wbm_desc_rel_ring;
+		hal_srng = &ar->ab->hal.srng_list[dp_srng->ring_id];
+	}
 
 	ath11k_hal_srng_access_begin(ar->ab, hal_srng);
 
@@ -4314,16 +4336,16 @@ int ath11k_dp_rx_monitor_link_desc_return(struct ath11k *ar,
 static
 void ath11k_dp_rx_mon_next_link_desc_get(void *rx_msdu_link_desc,
 					 dma_addr_t *paddr, u32 *sw_cookie,
+					 u8 *rbm,
 					 void **pp_buf_addr_info)
 {
 	struct hal_rx_msdu_link *msdu_link =
 			(struct hal_rx_msdu_link *)rx_msdu_link_desc;
 	struct ath11k_buffer_addr *buf_addr_info;
-	u8 rbm = 0;
 
 	buf_addr_info = (struct ath11k_buffer_addr *)&msdu_link->buf_addr_info;
 
-	ath11k_hal_rx_buf_addr_info_get(buf_addr_info, paddr, sw_cookie, &rbm);
+	ath11k_hal_rx_buf_addr_info_get(buf_addr_info, paddr, sw_cookie, rbm);
 
 	*pp_buf_addr_info = (void *)buf_addr_info;
 }
@@ -4434,7 +4456,7 @@ static void ath11k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
 }
 
 static u32
-ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar,
+ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
 			  void *ring_entry, struct sk_buff **head_msdu,
 			  struct sk_buff **tail_msdu, u32 *npackets,
 			  u32 *ppdu_id)
@@ -4459,9 +4481,15 @@ ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar,
 	struct hal_reo_entrance_ring *ent_desc =
 			(struct hal_reo_entrance_ring *)ring_entry;
 	int buf_id;
+	u32 rx_link_buf_info[2];
+	u8 rbm;
+
+	if (!ar->ab->hw_params.rxdma1_enable)
+		rx_ring = &dp->rx_refill_buf_ring;
 
 	ath11k_hal_rx_reo_ent_buf_paddr_get(ring_entry, &paddr,
-					    &sw_cookie, &p_last_buf_addr_info,
+					    &sw_cookie,
+					    &p_last_buf_addr_info, &rbm,
 					    &msdu_cnt);
 
 	if (FIELD_GET(HAL_REO_ENTR_RING_INFO1_RXDMA_PUSH_REASON,
@@ -4487,9 +4515,14 @@ ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar,
 			return rx_bufs_used;
 		}
 
-		rx_msdu_link_desc =
-			(void *)pmon->link_desc_banks[sw_cookie].vaddr +
-			(paddr - pmon->link_desc_banks[sw_cookie].paddr);
+		if (ar->ab->hw_params.rxdma1_enable)
+			rx_msdu_link_desc =
+				(void *)pmon->link_desc_banks[sw_cookie].vaddr +
+				(paddr - pmon->link_desc_banks[sw_cookie].paddr);
+		else
+			rx_msdu_link_desc =
+				(void *)ar->ab->dp.link_desc_banks[sw_cookie].vaddr +
+				(paddr - ar->ab->dp.link_desc_banks[sw_cookie].paddr);
 
 		ath11k_hal_rx_msdu_list_get(ar, rx_msdu_link_desc, &msdu_list,
 					    &num_msdus);
@@ -4585,15 +4618,22 @@ ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar,
 			spin_unlock_bh(&rx_ring->idr_lock);
 		}
 
+		ath11k_hal_rx_buf_addr_info_set(rx_link_buf_info, paddr, sw_cookie, rbm);
+
 		ath11k_dp_rx_mon_next_link_desc_get(rx_msdu_link_desc, &paddr,
-						    &sw_cookie,
+						    &sw_cookie, &rbm,
 						    &p_buf_addr_info);
 
-		if (ath11k_dp_rx_monitor_link_desc_return(ar,
-							  p_last_buf_addr_info,
-							  dp->mac_id))
-			ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
-				   "dp_rx_monitor_link_desc_return failed");
+		if (ar->ab->hw_params.rxdma1_enable) {
+			if (ath11k_dp_rx_monitor_link_desc_return(ar,
+								  p_last_buf_addr_info,
+								  dp->mac_id))
+				ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
+					   "dp_rx_monitor_link_desc_return failed");
+		} else {
+			ath11k_dp_rx_link_desc_return(ar->ab, rx_link_buf_info,
+						      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+		}
 
 		p_last_buf_addr_info = p_buf_addr_info;
 
@@ -4777,8 +4817,8 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 	return -EINVAL;
 }
 
-static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, u32 quota,
-					  struct napi_struct *napi)
+static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
+					  u32 quota, struct napi_struct *napi)
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
 	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&dp->mon_data;
@@ -4786,10 +4826,16 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, u32 quota,
 	void *mon_dst_srng;
 	u32 ppdu_id;
 	u32 rx_bufs_used;
+	u32 ring_id;
 	struct ath11k_pdev_mon_stats *rx_mon_stats;
 	u32	 npackets = 0;
 
-	mon_dst_srng = &ar->ab->hal.srng_list[dp->rxdma_mon_dst_ring.ring_id];
+	if (ar->ab->hw_params.rxdma1_enable)
+		ring_id = dp->rxdma_mon_dst_ring.ring_id;
+	else
+		ring_id = dp->rxdma_err_dst_ring[mac_id].ring_id;
+
+	mon_dst_srng = &ar->ab->hal.srng_list[ring_id];
 
 	if (!mon_dst_srng) {
 		ath11k_warn(ar->ab,
@@ -4812,7 +4858,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, u32 quota,
 		head_msdu = NULL;
 		tail_msdu = NULL;
 
-		rx_bufs_used += ath11k_dp_rx_mon_mpdu_pop(ar, ring_entry,
+		rx_bufs_used += ath11k_dp_rx_mon_mpdu_pop(ar, mac_id, ring_entry,
 							  &head_msdu,
 							  &tail_msdu,
 							  &npackets, &ppdu_id);
@@ -4839,15 +4885,21 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, u32 quota,
 
 	if (rx_bufs_used) {
 		rx_mon_stats->dest_ppdu_done++;
-		ath11k_dp_rxbufs_replenish(ar->ab, dp->mac_id,
-					   &dp->rxdma_mon_buf_ring,
-					   rx_bufs_used,
-					   HAL_RX_BUF_RBM_SW3_BM);
+		if (ar->ab->hw_params.rxdma1_enable)
+			ath11k_dp_rxbufs_replenish(ar->ab, dp->mac_id,
+						   &dp->rxdma_mon_buf_ring,
+						   rx_bufs_used,
+						   HAL_RX_BUF_RBM_SW3_BM);
+		else
+			ath11k_dp_rxbufs_replenish(ar->ab, dp->mac_id,
+						   &dp->rx_refill_buf_ring,
+						   rx_bufs_used,
+						   HAL_RX_BUF_RBM_SW3_BM);
 	}
 }
 
 static void ath11k_dp_rx_mon_status_process_tlv(struct ath11k *ar,
-						u32 quota,
+						int mac_id, u32 quota,
 						struct napi_struct *napi)
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
@@ -4871,7 +4923,7 @@ static void ath11k_dp_rx_mon_status_process_tlv(struct ath11k *ar,
 		if (tlv_status == HAL_TLV_STATUS_PPDU_DONE) {
 			rx_mon_stats->status_ppdu_done++;
 			pmon->mon_ppdu_status = DP_PPDU_STATUS_DONE;
-			ath11k_dp_rx_mon_dest_process(ar, quota, napi);
+			ath11k_dp_rx_mon_dest_process(ar, mac_id, quota, napi);
 			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
 		}
 		dev_kfree_skb_any(status_skb);
@@ -4886,10 +4938,10 @@ static int ath11k_dp_mon_process_rx(struct ath11k_base *ab, int mac_id,
 	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&dp->mon_data;
 	int num_buffs_reaped = 0;
 
-	num_buffs_reaped = ath11k_dp_rx_reap_mon_status_ring(ar->ab, dp->mac_id, &budget,
+	num_buffs_reaped = ath11k_dp_rx_reap_mon_status_ring(ar->ab, mac_id, &budget,
 							     &pmon->rx_status_q);
 	if (num_buffs_reaped)
-		ath11k_dp_rx_mon_status_process_tlv(ar, budget, napi);
+		ath11k_dp_rx_mon_status_process_tlv(ar, mac_id, budget, napi);
 
 	return num_buffs_reaped;
 }
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8625465500de..e907a8555583 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -786,9 +786,9 @@ int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
 	cmd->ring_tail_off32_remote_addr_hi = (u64)tp_addr >>
 					      HAL_ADDR_MSB_REG_SHIFT;
 
-	cmd->ring_msi_addr_lo = 0;
-	cmd->ring_msi_addr_hi = 0;
-	cmd->msi_data = 0;
+	cmd->ring_msi_addr_lo = params.msi_addr & 0xffffffff;
+	cmd->ring_msi_addr_hi = ((uint64_t)(params.msi_addr) >> 32) & 0xffffffff;
+	cmd->msi_data = params.msi_data;
 
 	cmd->intr_info = FIELD_PREP(
 			HTT_SRNG_SETUP_CMD_INTR_INFO_BATCH_COUNTER_THRESH,
@@ -804,6 +804,15 @@ int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
 				params.low_threshold);
 	}
 
+	ath11k_dbg(ab, ATH11k_DBG_HAL,
+		   "%s msi_addr_lo:0x%x, msi_addr_hi:0x%x, msi_data:0x%x\n",
+		   __func__, cmd->ring_msi_addr_lo, cmd->ring_msi_addr_hi,
+		   cmd->msi_data);
+
+	ath11k_dbg(ab, ATH11k_DBG_HAL,
+		   "ring_id:%d, ring_type:%d, intr_info:0x%x, flags:0x%x\n",
+		   ring_id, ring_type, cmd->intr_info, cmd->info2);
+
 	ret = ath11k_htc_send(&ab->htc, ab->dp.eid, skb);
 	if (ret)
 		goto err_free;
@@ -868,24 +877,27 @@ int ath11k_dp_tx_htt_h2t_ppdu_stats_req(struct ath11k *ar, u32 mask)
 	int len = sizeof(*cmd);
 	u8 pdev_mask;
 	int ret;
+	int i;
 
-	skb = ath11k_htc_alloc_skb(ab, len);
-	if (!skb)
-		return -ENOMEM;
-
-	skb_put(skb, len);
-	cmd = (struct htt_ppdu_stats_cfg_cmd *)skb->data;
-	cmd->msg = FIELD_PREP(HTT_PPDU_STATS_CFG_MSG_TYPE,
-			      HTT_H2T_MSG_TYPE_PPDU_STATS_CFG);
-
-	pdev_mask = 1 << (ar->pdev_idx);
-	cmd->msg |= FIELD_PREP(HTT_PPDU_STATS_CFG_PDEV_ID, pdev_mask);
-	cmd->msg |= FIELD_PREP(HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK, mask);
-
-	ret = ath11k_htc_send(&ab->htc, dp->eid, skb);
-	if (ret) {
-		dev_kfree_skb_any(skb);
-		return ret;
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		skb = ath11k_htc_alloc_skb(ab, len);
+		if (!skb)
+			return -ENOMEM;
+
+		skb_put(skb, len);
+		cmd = (struct htt_ppdu_stats_cfg_cmd *)skb->data;
+		cmd->msg = FIELD_PREP(HTT_PPDU_STATS_CFG_MSG_TYPE,
+				      HTT_H2T_MSG_TYPE_PPDU_STATS_CFG);
+
+		pdev_mask = 1 << (i + 1);
+		cmd->msg |= FIELD_PREP(HTT_PPDU_STATS_CFG_PDEV_ID, pdev_mask);
+		cmd->msg |= FIELD_PREP(HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK, mask);
+
+		ret = ath11k_htc_send(&ab->htc, dp->eid, skb);
+		if (ret) {
+			dev_kfree_skb_any(skb);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1028,10 +1040,23 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
 					HTT_RX_MON_MO_DATA_FILTER_FLASG3;
 	}
 
-	ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, dp->mac_id,
-					       HAL_RXDMA_MONITOR_BUF,
-					       DP_RXDMA_REFILL_RING_SIZE,
-					       &tlv_filter);
+	if (ab->hw_params.rxdma1_enable) {
+		ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, dp->mac_id,
+						       HAL_RXDMA_MONITOR_BUF,
+						       DP_RXDMA_REFILL_RING_SIZE,
+						       &tlv_filter);
+	} else if (!reset) {
+		/* set in monitor mode only */
+		for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+			ring_id = dp->rx_mac_buf_ring[i].ring_id;
+			ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id,
+							       dp->mac_id + i,
+							       HAL_RXDMA_BUF,
+							       1024,
+							       &tlv_filter);
+		}
+	}
+
 	if (ret)
 		return ret;
 
@@ -1050,5 +1075,9 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
 						       &tlv_filter);
 	}
 
+	if (!ar->ab->hw_params.rxdma1_enable)
+		mod_timer(&ar->ab->mon_reap_timer, jiffies +
+			  msecs_to_jiffies(ATH11K_MON_TIMER_INTERVAL));
+
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 5cd948f55b95..a23e87910056 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -560,6 +560,8 @@ void ath11k_hal_srng_get_params(struct ath11k_base *ab, struct hal_srng *srng,
 	params->intr_batch_cntr_thres_entries =
 		srng->intr_batch_cntr_thres_entries;
 	params->low_threshold = srng->u.src_ring.low_threshold;
+	params->msi_addr = srng->msi_addr;
+	params->msi_data = srng->msi_data;
 	params->flags = srng->flags;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 4bbad2e341ee..b0d6ece145be 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -1195,7 +1195,7 @@ ath11k_hal_rx_parse_mon_status(struct ath11k_base *ab,
 
 void ath11k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr,
 					 u32 *sw_cookie, void **pp_buf_addr,
-					 u32  *msdu_cnt)
+					 u8 *rbm, u32 *msdu_cnt)
 {
 	struct hal_reo_entrance_ring *reo_ent_ring =
 		(struct hal_reo_entrance_ring *)rx_desc;
@@ -1217,6 +1217,8 @@ void ath11k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr,
 
 	*sw_cookie = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
 			       buf_addr_info->info1);
+	*rbm = FIELD_GET(BUFFER_ADDR_INFO1_RET_BUF_MGR,
+			 buf_addr_info->info1);
 
 	*pp_buf_addr = (void *)buf_addr_info;
 }
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index c436191ae1e8..d464a270c049 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -321,7 +321,7 @@ void ath11k_hal_rx_reo_ent_paddr_get(struct ath11k_base *ab, void *desc,
 				     dma_addr_t *paddr, u32 *desc_bank);
 void ath11k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc,
 					 dma_addr_t *paddr, u32 *sw_cookie,
-					 void **pp_buf_addr_info,
+					 void **pp_buf_addr_info, u8 *rbm,
 					 u32 *msdu_cnt);
 enum hal_rx_mon_status
 ath11k_hal_rx_parse_mon_status(struct ath11k_base *ab,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9efaf6e7aacf..c43844ed6b61 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4698,6 +4698,10 @@ static void ath11k_mac_op_configure_filter(struct ieee80211_hw *hw,
 		ath11k_warn(ar->ab,
 			    "fail to set monitor filter: %d\n", ret);
 	}
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+		   "changed_flags:0x%x, total_flags:0x%x, reset_flag:%d\n",
+		   changed_flags, *total_flags, reset_flag);
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
@@ -5203,6 +5207,7 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	int ret;
+	struct peer_create_params param;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -5212,7 +5217,8 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	/* for QCA6390 bss peer must be created before vdev_start */
 	if (ab->hw_params.vdev_start_delay &&
-	    arvif->vdev_type != WMI_VDEV_TYPE_AP) {
+	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&
+	    arvif->vdev_type != WMI_VDEV_TYPE_MONITOR) {
 		memcpy(&arvif->chanctx, ctx, sizeof(*ctx));
 		mutex_unlock(&ar->conf_mutex);
 		return 0;
@@ -5223,6 +5229,13 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		return -EBUSY;
 	}
 
+	if (ab->hw_params.vdev_start_delay) {
+		param.vdev_id = arvif->vdev_id;
+		param.peer_type = WMI_PEER_TYPE_DEFAULT;
+		param.peer_addr = ar->mac_addr;
+		ret = ath11k_peer_create(ar, arvif, NULL, &param);
+	}
+
 	ret = ath11k_mac_vdev_start(arvif, &ctx->def);
 	if (ret) {
 		ath11k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
@@ -5268,6 +5281,11 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	WARN_ON(!arvif->is_started);
 
+	if (ab->hw_params.vdev_start_delay &&
+	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR &&
+	    ath11k_peer_find_by_addr(ab, ar->mac_addr))
+		ath11k_peer_delete(ar, arvif->vdev_id, ar->mac_addr);
+
 	ret = ath11k_mac_vdev_stop(arvif);
 	if (ret)
 		ath11k_warn(ab, "failed to stop vdev %i: %d\n",
@@ -5275,6 +5293,10 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	arvif->is_started = false;
 
+	if (ab->hw_params.vdev_start_delay &&
+	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR)
+		ath11k_wmi_vdev_down(ar, arvif->vdev_id);
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
-- 
2.7.4

