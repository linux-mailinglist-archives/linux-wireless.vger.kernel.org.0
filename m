Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A0D3D14FC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 19:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhGUQjY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 12:39:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44073 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhGUQjX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 12:39:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626887999; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=e+emqh3b/+a5V7vdCnaCqRJUnw0sMJ7PF0Ihk4RitNQ=; b=q+J23dJnSilMkEUEL9IGg8307WDl0EeAa6/4+J7/idYioW1F8zPMt7eaJRPI94lUUfGz53JT
 O8cT2V3AiWn1pHnwFezrbcox42P4/9vdEEFVqReji4+p0mAoKFZl5kM4jBTdfISIlRvKoS+j
 97plK9R5OGxq9+FqSz2GiVivcT0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60f85738fcf9fe7b787765cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 17:19:52
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5D730C43460; Wed, 21 Jul 2021 17:19:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 734ECC433F1;
        Wed, 21 Jul 2021 17:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 734ECC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/3] ath11k: process full monitor mode rx support
Date:   Wed, 21 Jul 2021 20:19:05 +0300
Message-Id: <20210721171905.61838-4-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721171905.61838-1-jouni@codeaurora.org>
References: <20210721171905.61838-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

In full monitor mode, monitor destination ring is read before monitor
status ring. mon_dst_ring has ppdu id, reap till the end of PPDU. Add
all the MPDUs to list. Start processing the status ring, if PPDU id in
status ring is lagging behind, reap the status ring, once the PPDU ID
matches, deliver the MSDU to upper layer. If status PPDU id leading,
reap the mon_dst_ring. The advantage with full monitor mode is hardware
has status buffers available for all the MPDUs in mon_dst_ring.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.c    |   1 +
 drivers/net/wireless/ath/ath11k/dp.h    |  26 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 413 +++++++++++++++++++++++-
 3 files changed, 436 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index b0c8f6290099..dd69ba8f7d80 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -1021,6 +1021,7 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 
 	INIT_LIST_HEAD(&dp->reo_cmd_list);
 	INIT_LIST_HEAD(&dp->reo_cmd_cache_flush_list);
+	INIT_LIST_HEAD(&dp->dp_full_mon_mpdu_list);
 	spin_lock_init(&dp->reo_cmd_lock);
 
 	dp->reo_cmd_cache_flush_count = 0;
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index b39a6652d631..69b75bc3312f 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -88,6 +88,19 @@ struct dp_tx_ring {
 	int tx_status_tail;
 };
 
+enum dp_mon_status_buf_state {
+	/* PPDU id matches in dst ring and status ring */
+	DP_MON_STATUS_MATCH,
+	/* status ring dma is not done */
+	DP_MON_STATUS_NO_DMA,
+	/* status ring is lagging, reap status ring */
+	DP_MON_STATUS_LAG,
+	/* status ring is leading, reap dst ring and drop */
+	DP_MON_STATUS_LEAD,
+	/* replinish monitor status ring */
+	DP_MON_STATUS_REPLINISH,
+};
+
 struct ath11k_pdev_mon_stats {
 	u32 status_ppdu_state;
 	u32 status_ppdu_start;
@@ -103,6 +116,12 @@ struct ath11k_pdev_mon_stats {
 	u32 dup_mon_buf_cnt;
 };
 
+struct dp_full_mon_mpdu {
+	struct list_head list;
+	struct sk_buff *head;
+	struct sk_buff *tail;
+};
+
 struct dp_link_desc_bank {
 	void *vaddr_unaligned;
 	void *vaddr;
@@ -134,7 +153,11 @@ struct ath11k_mon_data {
 	u32 mon_last_buf_cookie;
 	u64 mon_last_linkdesc_paddr;
 	u16 chan_noise_floor;
-
+	bool hold_mon_dst_ring;
+	enum dp_mon_status_buf_state buf_state;
+	dma_addr_t mon_status_paddr;
+	struct dp_full_mon_mpdu *mon_mpdu;
+	struct hal_sw_mon_ring_entries sw_mon_entries;
 	struct ath11k_pdev_mon_stats rx_mon_stats;
 	/* lock for monitor data */
 	spinlock_t mon_lock;
@@ -242,6 +265,7 @@ struct ath11k_dp {
 	struct hal_wbm_idle_scatter_list scatter_list[DP_IDLE_SCATTER_BUFS_MAX];
 	struct list_head reo_cmd_list;
 	struct list_head reo_cmd_cache_flush_list;
+	struct list_head dp_full_mon_mpdu_list;
 	u32 reo_cmd_cache_flush_count;
 	/**
 	 * protects access to below fields,
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 6fde70914e1a..587690bec595 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2863,11 +2863,49 @@ int ath11k_dp_rx_mon_status_bufs_replenish(struct ath11k_base *ab, int mac_id,
 	return req_entries - num_remain;
 }
 
+#define ATH11K_DP_RX_FULL_MON_PPDU_ID_WRAP 32535
+
+static void
+ath11k_dp_rx_mon_update_status_buf_state(struct ath11k_mon_data *pmon,
+					 struct hal_tlv_hdr *tlv)
+{
+	struct hal_rx_ppdu_start *ppdu_start;
+	u16 ppdu_id_diff, ppdu_id, tlv_len;
+	u8 *ptr;
+
+	/* PPDU id is part of second tlv, move ptr to second tlv */
+	tlv_len = FIELD_GET(HAL_TLV_HDR_LEN, tlv->tl);
+	ptr = (u8 *)tlv;
+	ptr += sizeof(*tlv) + tlv_len;
+	tlv = (struct hal_tlv_hdr *)ptr;
+
+	if (FIELD_GET(HAL_TLV_HDR_TAG, tlv->tl) != HAL_RX_PPDU_START)
+		return;
+
+	ptr += sizeof(*tlv);
+	ppdu_start = (struct hal_rx_ppdu_start *)ptr;
+	ppdu_id = FIELD_GET(HAL_RX_PPDU_START_INFO0_PPDU_ID,
+			    __le32_to_cpu(ppdu_start->info0));
+
+	if (pmon->sw_mon_entries.ppdu_id < ppdu_id) {
+		pmon->buf_state = DP_MON_STATUS_LEAD;
+		ppdu_id_diff = ppdu_id - pmon->sw_mon_entries.ppdu_id;
+		if (ppdu_id_diff > ATH11K_DP_RX_FULL_MON_PPDU_ID_WRAP)
+			pmon->buf_state = DP_MON_STATUS_LAG;
+	} else if (pmon->sw_mon_entries.ppdu_id > ppdu_id) {
+		pmon->buf_state = DP_MON_STATUS_LAG;
+		ppdu_id_diff = pmon->sw_mon_entries.ppdu_id - ppdu_id;
+		if (ppdu_id_diff > ATH11K_DP_RX_FULL_MON_PPDU_ID_WRAP)
+			pmon->buf_state = DP_MON_STATUS_LEAD;
+	}
+}
+
 static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 					     int *budget, struct sk_buff_head *skb_list)
 {
 	struct ath11k *ar;
 	struct ath11k_pdev_dp *dp;
+	struct ath11k_mon_data *pmon;
 	struct dp_rxdma_ring *rx_ring;
 	struct hal_srng *srng;
 	void *rx_mon_status_desc;
@@ -2882,6 +2920,7 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 
 	ar = ab->pdevs[ath11k_hw_mac_id_to_pdev_id(&ab->hw_params, mac_id)].ar;
 	dp = &ar->dp;
+	pmon = &dp->mon_data;
 	srng_id = ath11k_hw_mac_id_to_srng_id(&ab->hw_params, mac_id);
 	rx_ring = &dp->rx_mon_status_refill_ring[srng_id];
 
@@ -2894,8 +2933,10 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 		*budget -= 1;
 		rx_mon_status_desc =
 			ath11k_hal_srng_src_peek(ab, srng);
-		if (!rx_mon_status_desc)
+		if (!rx_mon_status_desc) {
+			pmon->buf_state = DP_MON_STATUS_REPLINISH;
 			break;
+		}
 
 		ath11k_hal_rx_buf_addr_info_get(rx_mon_status_desc, &paddr,
 						&cookie, &rbm);
@@ -2908,6 +2949,7 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 				ath11k_warn(ab, "rx monitor status with invalid buf_id %d\n",
 					    buf_id);
 				spin_unlock_bh(&rx_ring->idr_lock);
+				pmon->buf_state = DP_MON_STATUS_REPLINISH;
 				goto move_next;
 			}
 
@@ -2927,10 +2969,18 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 					    FIELD_GET(HAL_TLV_HDR_TAG,
 						      tlv->tl));
 				dev_kfree_skb_any(skb);
+				pmon->buf_state = DP_MON_STATUS_NO_DMA;
 				goto move_next;
 			}
 
+			if (ab->hw_params.full_monitor_mode) {
+				ath11k_dp_rx_mon_update_status_buf_state(pmon, tlv);
+				if (paddr == pmon->mon_status_paddr)
+					pmon->buf_state = DP_MON_STATUS_MATCH;
+			}
 			__skb_queue_tail(skb_list, skb);
+		} else {
+			pmon->buf_state = DP_MON_STATUS_REPLINISH;
 		}
 move_next:
 		skb = ath11k_dp_rx_alloc_mon_status_buf(ab, rx_ring,
@@ -5007,6 +5057,360 @@ static void ath11k_dp_rx_mon_status_process_tlv(struct ath11k *ar,
 	}
 }
 
+static u32
+ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
+			       void *ring_entry, struct sk_buff **head_msdu,
+			       struct sk_buff **tail_msdu,
+			       struct hal_sw_mon_ring_entries *sw_mon_entries)
+{
+	struct ath11k_pdev_dp *dp = &ar->dp;
+	struct ath11k_mon_data *pmon = &dp->mon_data;
+	struct dp_rxdma_ring *rx_ring = &dp->rxdma_mon_buf_ring;
+	struct sk_buff *msdu = NULL, *last = NULL;
+	struct hal_sw_monitor_ring *sw_desc = ring_entry;
+	struct hal_rx_msdu_list msdu_list;
+	struct hal_rx_desc *rx_desc;
+	struct ath11k_pdev_mon_stats *rx_mon_stats;
+	struct ath11k_skb_rxcb *rxcb;
+	void *rx_msdu_link_desc;
+	void *p_buf_addr_info, *p_last_buf_addr_info;
+	int buf_id, i = 0;
+	u32 rx_buf_size, rx_pkt_offset, l2_hdr_offset;
+	u32 rx_bufs_used = 0, msdu_cnt = 0;
+	u32 total_len = 0, frag_len = 0, sw_cookie;
+	u16 num_msdus = 0;
+	u8 rxdma_err, rbm;
+	bool is_frag, is_first_msdu;
+	bool drop_mpdu = false;
+
+	rx_mon_stats = &pmon->rx_mon_stats;
+
+	ath11k_hal_rx_sw_mon_ring_buf_paddr_get(ring_entry, sw_mon_entries);
+
+	sw_cookie = sw_mon_entries->mon_dst_sw_cookie;
+	sw_mon_entries->end_of_ppdu = false;
+	sw_mon_entries->drop_ppdu = false;
+	p_last_buf_addr_info = sw_mon_entries->dst_buf_addr_info;
+	msdu_cnt = sw_mon_entries->msdu_cnt;
+
+	sw_mon_entries->end_of_ppdu =
+		FIELD_GET(HAL_SW_MON_RING_INFO0_END_OF_PPDU, sw_desc->info0);
+	if (sw_mon_entries->end_of_ppdu)
+		return rx_bufs_used;
+
+	if (FIELD_GET(HAL_SW_MON_RING_INFO0_RXDMA_PUSH_REASON,
+		      sw_desc->info0) ==
+		      HAL_REO_DEST_RING_PUSH_REASON_ERR_DETECTED) {
+		rxdma_err =
+			FIELD_GET(HAL_SW_MON_RING_INFO0_RXDMA_ERROR_CODE,
+				  sw_desc->info0);
+		if (rxdma_err == HAL_REO_ENTR_RING_RXDMA_ECODE_FLUSH_REQUEST_ERR ||
+		    rxdma_err == HAL_REO_ENTR_RING_RXDMA_ECODE_MPDU_LEN_ERR ||
+		    rxdma_err == HAL_REO_ENTR_RING_RXDMA_ECODE_OVERFLOW_ERR) {
+			rx_mon_stats->dest_mpdu_drop++;
+			drop_mpdu = true;
+		}
+	}
+
+	is_frag = false;
+	is_first_msdu = true;
+
+	do {
+		rx_msdu_link_desc =
+			(u8 *)pmon->link_desc_banks[sw_cookie].vaddr +
+			(sw_mon_entries->mon_dst_paddr -
+			 pmon->link_desc_banks[sw_cookie].paddr);
+
+		ath11k_hal_rx_msdu_list_get(ar, rx_msdu_link_desc, &msdu_list,
+					    &num_msdus);
+
+		for (i = 0; i < num_msdus; i++) {
+			buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID,
+					   msdu_list.sw_cookie[i]);
+
+			spin_lock_bh(&rx_ring->idr_lock);
+			msdu = idr_find(&rx_ring->bufs_idr, buf_id);
+			if (!msdu) {
+				ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
+					   "full mon msdu_pop: invalid buf_id %d\n",
+					    buf_id);
+				spin_unlock_bh(&rx_ring->idr_lock);
+				break;
+			}
+			idr_remove(&rx_ring->bufs_idr, buf_id);
+			spin_unlock_bh(&rx_ring->idr_lock);
+
+			rxcb = ATH11K_SKB_RXCB(msdu);
+			if (!rxcb->unmapped) {
+				dma_unmap_single(ar->ab->dev, rxcb->paddr,
+						 msdu->len +
+						 skb_tailroom(msdu),
+						 DMA_FROM_DEVICE);
+				rxcb->unmapped = 1;
+			}
+			if (drop_mpdu) {
+				ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
+					   "full mon: i %d drop msdu %p *ppdu_id %x\n",
+					   i, msdu, sw_mon_entries->ppdu_id);
+				dev_kfree_skb_any(msdu);
+				msdu_cnt--;
+				goto next_msdu;
+			}
+
+			rx_desc = (struct hal_rx_desc *)msdu->data;
+
+			rx_pkt_offset = sizeof(struct hal_rx_desc);
+			l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, rx_desc);
+
+			if (is_first_msdu) {
+				if (!ath11k_dp_rxdesc_mpdu_valid(ar->ab, rx_desc)) {
+					drop_mpdu = true;
+					dev_kfree_skb_any(msdu);
+					msdu = NULL;
+					goto next_msdu;
+				}
+				is_first_msdu = false;
+			}
+
+			ath11k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
+						  &is_frag, &total_len,
+						  &frag_len, &msdu_cnt);
+
+			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;
+
+			ath11k_dp_pkt_set_pktlen(msdu, rx_buf_size);
+
+			if (!(*head_msdu))
+				*head_msdu = msdu;
+			else if (last)
+				last->next = msdu;
+
+			last = msdu;
+next_msdu:
+			rx_bufs_used++;
+		}
+
+		ath11k_dp_rx_mon_next_link_desc_get(rx_msdu_link_desc,
+						    &sw_mon_entries->mon_dst_paddr,
+						    &sw_mon_entries->mon_dst_sw_cookie,
+						    &rbm,
+						    &p_buf_addr_info);
+
+		if (ath11k_dp_rx_monitor_link_desc_return(ar,
+							  p_last_buf_addr_info,
+							  dp->mac_id))
+			ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
+				   "full mon: dp_rx_monitor_link_desc_return failed\n");
+
+		p_last_buf_addr_info = p_buf_addr_info;
+
+	} while (sw_mon_entries->mon_dst_paddr && msdu_cnt);
+
+	if (last)
+		last->next = NULL;
+
+	*tail_msdu = msdu;
+
+	return rx_bufs_used;
+}
+
+static int ath11k_dp_rx_full_mon_prepare_mpdu(struct ath11k_dp *dp,
+					      struct dp_full_mon_mpdu *mon_mpdu,
+					      struct sk_buff *head,
+					      struct sk_buff *tail)
+{
+	mon_mpdu = kzalloc(sizeof(*mon_mpdu), GFP_ATOMIC);
+	if (!mon_mpdu)
+		return -ENOMEM;
+
+	list_add_tail(&mon_mpdu->list, &dp->dp_full_mon_mpdu_list);
+	mon_mpdu->head = head;
+	mon_mpdu->tail = tail;
+
+	return 0;
+}
+
+static void ath11k_dp_rx_full_mon_drop_ppdu(struct ath11k_dp *dp,
+					    struct dp_full_mon_mpdu *mon_mpdu)
+{
+	struct dp_full_mon_mpdu *tmp;
+	struct sk_buff *tmp_msdu, *skb_next;
+
+	if (list_empty(&dp->dp_full_mon_mpdu_list))
+		return;
+
+	list_for_each_entry_safe(mon_mpdu, tmp, &dp->dp_full_mon_mpdu_list, list) {
+		list_del(&mon_mpdu->list);
+
+		tmp_msdu = mon_mpdu->head;
+		while (tmp_msdu) {
+			skb_next = tmp_msdu->next;
+			dev_kfree_skb_any(tmp_msdu);
+			tmp_msdu = skb_next;
+		}
+
+		kfree(mon_mpdu);
+	}
+}
+
+static int ath11k_dp_rx_full_mon_deliver_ppdu(struct ath11k *ar,
+					      int mac_id,
+					      struct ath11k_mon_data *pmon,
+					      struct napi_struct *napi)
+{
+	struct ath11k_pdev_mon_stats *rx_mon_stats;
+	struct dp_full_mon_mpdu *tmp;
+	struct dp_full_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
+	struct sk_buff *head_msdu, *tail_msdu;
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_dp *dp = &ab->dp;
+	int ret;
+
+	rx_mon_stats = &pmon->rx_mon_stats;
+
+	list_for_each_entry_safe(mon_mpdu, tmp, &dp->dp_full_mon_mpdu_list, list) {
+		list_del(&mon_mpdu->list);
+		head_msdu = mon_mpdu->head;
+		tail_msdu = mon_mpdu->tail;
+		if (head_msdu && tail_msdu) {
+			ret = ath11k_dp_rx_mon_deliver(ar, mac_id, head_msdu,
+						       tail_msdu, napi);
+			rx_mon_stats->dest_mpdu_done++;
+			ath11k_dbg(ar->ab, ATH11K_DBG_DATA, "full mon: deliver ppdu\n");
+		}
+		kfree(mon_mpdu);
+	}
+
+	return ret;
+}
+
+static int
+ath11k_dp_rx_process_full_mon_status_ring(struct ath11k_base *ab, int mac_id,
+					  struct napi_struct *napi, int budget)
+{
+	struct ath11k *ar = ab->pdevs[mac_id].ar;
+	struct ath11k_pdev_dp *dp = &ar->dp;
+	struct ath11k_mon_data *pmon = &dp->mon_data;
+	struct hal_sw_mon_ring_entries *sw_mon_entries;
+	int quota = 0, work = 0, count;
+
+	sw_mon_entries = &pmon->sw_mon_entries;
+
+	while (pmon->hold_mon_dst_ring) {
+		quota = ath11k_dp_rx_process_mon_status(ab, mac_id,
+							napi, 1);
+		if (pmon->buf_state == DP_MON_STATUS_MATCH) {
+			count = sw_mon_entries->status_buf_count;
+			if (count > 1) {
+				quota += ath11k_dp_rx_process_mon_status(ab, mac_id,
+									 napi, count);
+			}
+
+			ath11k_dp_rx_full_mon_deliver_ppdu(ar, dp->mac_id,
+							   pmon, napi);
+			pmon->hold_mon_dst_ring = false;
+		} else if (!pmon->mon_status_paddr ||
+			   pmon->buf_state == DP_MON_STATUS_LEAD) {
+			sw_mon_entries->drop_ppdu = true;
+			pmon->hold_mon_dst_ring = false;
+		}
+
+		if (!quota)
+			break;
+
+		work += quota;
+	}
+
+	if (sw_mon_entries->drop_ppdu)
+		ath11k_dp_rx_full_mon_drop_ppdu(&ab->dp, pmon->mon_mpdu);
+
+	return work;
+}
+
+static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
+					 struct napi_struct *napi, int budget)
+{
+	struct ath11k *ar = ab->pdevs[mac_id].ar;
+	struct ath11k_pdev_dp *dp = &ar->dp;
+	struct ath11k_mon_data *pmon = &dp->mon_data;
+	struct hal_sw_mon_ring_entries *sw_mon_entries;
+	struct ath11k_pdev_mon_stats *rx_mon_stats;
+	struct sk_buff *head_msdu, *tail_msdu;
+	void *mon_dst_srng = &ar->ab->hal.srng_list[dp->rxdma_mon_dst_ring.ring_id];
+	void *ring_entry;
+	u32 rx_bufs_used = 0, mpdu_rx_bufs_used;
+	int quota = 0, ret;
+	bool break_dst_ring = false;
+
+	spin_lock_bh(&pmon->mon_lock);
+
+	sw_mon_entries = &pmon->sw_mon_entries;
+	rx_mon_stats = &pmon->rx_mon_stats;
+
+	if (pmon->hold_mon_dst_ring) {
+		spin_unlock_bh(&pmon->mon_lock);
+		goto reap_status_ring;
+	}
+
+	ath11k_hal_srng_access_begin(ar->ab, mon_dst_srng);
+	while ((ring_entry = ath11k_hal_srng_dst_peek(ar->ab, mon_dst_srng))) {
+		head_msdu = NULL;
+		tail_msdu = NULL;
+
+		mpdu_rx_bufs_used = ath11k_dp_rx_full_mon_mpdu_pop(ar, ring_entry,
+								   &head_msdu,
+								   &tail_msdu,
+								   sw_mon_entries);
+		rx_bufs_used += mpdu_rx_bufs_used;
+
+		if (!sw_mon_entries->end_of_ppdu) {
+			if (head_msdu) {
+				ret = ath11k_dp_rx_full_mon_prepare_mpdu(&ab->dp,
+									 pmon->mon_mpdu,
+									 head_msdu,
+									 tail_msdu);
+				if (ret)
+					break_dst_ring = true;
+			}
+
+			goto next_entry;
+		} else {
+			if (!sw_mon_entries->ppdu_id &&
+			    !sw_mon_entries->mon_status_paddr) {
+				break_dst_ring = true;
+				goto next_entry;
+			}
+		}
+
+		rx_mon_stats->dest_ppdu_done++;
+		pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
+		pmon->buf_state = DP_MON_STATUS_LAG;
+		pmon->mon_status_paddr = sw_mon_entries->mon_status_paddr;
+		pmon->hold_mon_dst_ring = true;
+next_entry:
+		ring_entry = ath11k_hal_srng_dst_get_next_entry(ar->ab,
+								mon_dst_srng);
+		if (break_dst_ring)
+			break;
+	}
+
+	ath11k_hal_srng_access_end(ar->ab, mon_dst_srng);
+	spin_unlock_bh(&pmon->mon_lock);
+
+	if (rx_bufs_used) {
+		ath11k_dp_rxbufs_replenish(ar->ab, dp->mac_id,
+					   &dp->rxdma_mon_buf_ring,
+					   rx_bufs_used,
+					   HAL_RX_BUF_RBM_SW3_BM);
+	}
+
+reap_status_ring:
+	quota = ath11k_dp_rx_process_full_mon_status_ring(ab, mac_id,
+							  napi, budget);
+
+	return quota;
+}
+
 static int ath11k_dp_mon_process_rx(struct ath11k_base *ab, int mac_id,
 				    struct napi_struct *napi, int budget)
 {
@@ -5029,10 +5433,13 @@ int ath11k_dp_rx_process_mon_rings(struct ath11k_base *ab, int mac_id,
 	struct ath11k *ar = ath11k_ab_to_ar(ab, mac_id);
 	int ret = 0;
 
-	if (ar->monitor_started)
+	if (!ar->monitor_started)
+		ret = ath11k_dp_rx_process_mon_status(ab, mac_id, napi, budget);
+	else if (!ab->hw_params.full_monitor_mode)
 		ret = ath11k_dp_mon_process_rx(ab, mac_id, napi, budget);
 	else
-		ret = ath11k_dp_rx_process_mon_status(ab, mac_id, napi, budget);
+		ret = ath11k_dp_full_mon_process_rx(ab, mac_id, napi, budget);
+
 	return ret;
 }
 
-- 
2.25.1

