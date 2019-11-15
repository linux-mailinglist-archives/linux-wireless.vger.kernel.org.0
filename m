Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27232FD90D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKOJaa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:30:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKOJaZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:30:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EE822614A0; Fri, 15 Nov 2019 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810224;
        bh=0j7JRfvbanD7VudHpKfxrxBgexZUI1054BR36Ugbfw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X6OD29+aiBlkJcMaCvSsFYBZtETWMYRU8x5w3Gk7vF3MIFaHtmQIXsKsxDLHShifT
         6vaHheSq+wCwMCpmh0sdnXZ34W/kljb+3vL2cTdpafVRyPkvPMxSKXWjuOqw1g3Pa0
         bOYxS/1ZXzgrP+dxM455GddRPGBDoq9LlDvWudQw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5711D61389;
        Fri, 15 Nov 2019 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810207;
        bh=0j7JRfvbanD7VudHpKfxrxBgexZUI1054BR36Ugbfw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCKE3hwyqZyzhcAmtcY9OPpLeirdkhVjh5uqoM6QdfXtVgLMNSr4wARPT92/bvbsD
         KF+/besG8kW/SHmH4FSoeoiWCl6OWg8DRP6boMtPwt85cGnYw7aveJSei9zx+fEwlc
         75clubnaJzGy2tf8qTbJQFUJ10O18rk7UFynKvNY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5711D61389
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 19/49] ath11k: add dp_tx.c
Date:   Fri, 15 Nov 2019 11:28:43 +0200
Message-Id: <1573810153-29623-20-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
References: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(patches split for easier review, see the cover letter for more)

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 943 ++++++++++++++++++++++++++++++++
 1 file changed, 943 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
new file mode 100644
index 000000000000..51a02b8e66cc
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -0,0 +1,943 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#include "core.h"
+#include "dp_tx.h"
+#include "debug.h"
+#include "hw.h"
+
+/* NOTE: Any of the mapped ring id value must not exceed DP_TCL_NUM_RING_MAX */
+static const u8
+ath11k_txq_tcl_ring_map[ATH11K_HW_MAX_QUEUES] = { 0x0, 0x1, 0x2, 0x2 };
+
+static enum hal_tcl_encap_type
+ath11k_dp_tx_get_encap_type(struct ath11k_vif *arvif, struct sk_buff *skb)
+{
+	/* TODO: Determine encap type based on vif_type and configuration */
+	return HAL_TCL_ENCAP_TYPE_NATIVE_WIFI;
+}
+
+static void ath11k_dp_tx_encap_nwifi(struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	u8 *qos_ctl;
+
+	if (!ieee80211_is_data_qos(hdr->frame_control))
+		return;
+
+	qos_ctl = ieee80211_get_qos_ctl(hdr);
+	memmove(skb->data + IEEE80211_QOS_CTL_LEN,
+		skb->data, (void *)qos_ctl - (void *)skb->data);
+	skb_pull(skb, IEEE80211_QOS_CTL_LEN);
+
+	hdr = (void *)skb->data;
+	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_STYPE_QOS_DATA);
+}
+
+static u8 ath11k_dp_tx_get_tid(struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+
+	if (!ieee80211_is_data_qos(hdr->frame_control))
+		return HAL_DESC_REO_NON_QOS_TID;
+	else
+		return skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+}
+
+static enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher)
+{
+	switch (cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		return HAL_ENCRYPT_TYPE_WEP_40;
+	case WLAN_CIPHER_SUITE_WEP104:
+		return HAL_ENCRYPT_TYPE_WEP_104;
+	case WLAN_CIPHER_SUITE_TKIP:
+		return HAL_ENCRYPT_TYPE_TKIP_MIC;
+	case WLAN_CIPHER_SUITE_CCMP:
+		return HAL_ENCRYPT_TYPE_CCMP_128;
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		return HAL_ENCRYPT_TYPE_CCMP_256;
+	case WLAN_CIPHER_SUITE_GCMP:
+		return HAL_ENCRYPT_TYPE_GCMP_128;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		return HAL_ENCRYPT_TYPE_AES_GCMP_256;
+	default:
+		return HAL_ENCRYPT_TYPE_OPEN;
+	}
+}
+
+int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
+		 struct sk_buff *skb)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_dp *dp = &ab->dp;
+	struct hal_tx_info ti = {0};
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB(skb);
+	struct hal_srng *tcl_ring;
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct dp_tx_ring *tx_ring;
+	u8 cached_desc[HAL_TCL_DESC_LEN];
+	void *hal_tcl_desc;
+	u8 pool_id;
+	u8 hal_ring_id;
+	int ret;
+
+	if (test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
+		return -ESHUTDOWN;
+
+	if (!ieee80211_is_data(hdr->frame_control))
+		return -ENOTSUPP;
+
+	pool_id = skb_get_queue_mapping(skb) & (ATH11K_HW_MAX_QUEUES - 1);
+	ti.ring_id = ath11k_txq_tcl_ring_map[pool_id];
+
+	tx_ring = &dp->tx_ring[ti.ring_id];
+
+	spin_lock_bh(&tx_ring->tx_idr_lock);
+	ret = idr_alloc(&tx_ring->txbuf_idr, skb, 0,
+			DP_TX_IDR_SIZE - 1, GFP_ATOMIC);
+	spin_unlock_bh(&tx_ring->tx_idr_lock);
+
+	if (ret < 0)
+		return -ENOSPC;
+
+	ti.desc_id = FIELD_PREP(DP_TX_DESC_ID_MAC_ID, ar->pdev_idx) |
+		     FIELD_PREP(DP_TX_DESC_ID_MSDU_ID, ret) |
+		     FIELD_PREP(DP_TX_DESC_ID_POOL_ID, pool_id);
+	ti.encap_type = ath11k_dp_tx_get_encap_type(arvif, skb);
+	ti.meta_data_flags = arvif->tcl_metadata;
+
+	if (info->control.hw_key)
+		ti.encrypt_type =
+			ath11k_dp_tx_get_encrypt_type(info->control.hw_key->cipher);
+	else
+		ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
+
+	ti.addr_search_flags = arvif->hal_addr_search_flags;
+	ti.search_type = arvif->search_type;
+	ti.type = HAL_TCL_DESC_TYPE_BUFFER;
+	ti.pkt_offset = 0;
+	ti.lmac_id = ar->lmac_id;
+	ti.bss_ast_hash = arvif->ast_hash;
+	ti.dscp_tid_tbl_idx = 0;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		ti.flags0 |= FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_IP4_CKSUM_EN, 1) |
+			     FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_UDP4_CKSUM_EN, 1) |
+			     FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_UDP6_CKSUM_EN, 1) |
+			     FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_TCP4_CKSUM_EN, 1) |
+			     FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_TCP6_CKSUM_EN, 1);
+	}
+
+	if (ieee80211_vif_is_mesh(arvif->vif))
+		ti.flags1 |= FIELD_PREP(HAL_TCL_DATA_CMD_INFO2_MESH_ENABLE, 1);
+
+	ti.flags1 |= FIELD_PREP(HAL_TCL_DATA_CMD_INFO2_TID_OVERWRITE, 1);
+
+	ti.tid = ath11k_dp_tx_get_tid(skb);
+
+	switch (ti.encap_type) {
+	case HAL_TCL_ENCAP_TYPE_NATIVE_WIFI:
+		ath11k_dp_tx_encap_nwifi(skb);
+		break;
+	case HAL_TCL_ENCAP_TYPE_RAW:
+		/*  TODO: for CHECKSUM_PARTIAL case in raw mode, HW checksum offload
+		 *	  is not applicable, hence manual checksum calculation using
+		 *	  skb_checksum_help() is needed
+		 */
+	case HAL_TCL_ENCAP_TYPE_ETHERNET:
+	case HAL_TCL_ENCAP_TYPE_802_3:
+		/* TODO: Take care of other encap modes as well */
+		ret = -EINVAL;
+		goto fail_remove_idr;
+	}
+
+	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(ab->dev, ti.paddr)) {
+		ath11k_warn(ab, "failed to DMA map data Tx buffer\n");
+		ret = -ENOMEM;
+		goto fail_remove_idr;
+	}
+
+	ti.data_len = skb->len;
+	skb_cb->paddr = ti.paddr;
+	skb_cb->vif = arvif->vif;
+	skb_cb->ar = ar;
+
+	memset(cached_desc, 0, HAL_TCL_DESC_LEN);
+
+	ath11k_hal_tx_cmd_desc_setup(ab, cached_desc, &ti);
+
+	hal_ring_id = tx_ring->tcl_data_ring.ring_id;
+	tcl_ring = &ab->hal.srng_list[hal_ring_id];
+
+	spin_lock_bh(&tcl_ring->lock);
+
+	ath11k_hal_srng_access_begin(ab, tcl_ring);
+
+	hal_tcl_desc = (void *)ath11k_hal_srng_src_get_next_entry(ab, tcl_ring);
+	if (!hal_tcl_desc) {
+		/* NOTE: It is highly unlikely we'll be running out of tcl_ring
+		 * desc because the desc is directly enqueued onto hw queue.
+		 * So add tx packet throttling logic in future if required.
+		 */
+		ath11k_hal_srng_access_end(ab, tcl_ring);
+		spin_unlock_bh(&tcl_ring->lock);
+		ret = -ENOMEM;
+		goto fail_unmap_dma;
+	}
+
+	ath11k_hal_tx_desc_sync(cached_desc, hal_tcl_desc);
+
+	ath11k_hal_srng_access_end(ab, tcl_ring);
+
+	spin_unlock_bh(&tcl_ring->lock);
+
+	spin_lock_bh(&tx_ring->tx_idr_lock);
+	tx_ring->num_tx_pending++;
+	spin_unlock_bh(&tx_ring->tx_idr_lock);
+
+	atomic_inc(&ar->dp.num_tx_pending);
+
+	return 0;
+
+fail_unmap_dma:
+	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
+
+fail_remove_idr:
+	spin_lock_bh(&tx_ring->tx_idr_lock);
+	idr_remove(&tx_ring->txbuf_idr,
+		   FIELD_GET(DP_TX_DESC_ID_MSDU_ID, ti.desc_id));
+	spin_unlock_bh(&tx_ring->tx_idr_lock);
+
+	return ret;
+}
+
+static void ath11k_dp_tx_free_txbuf(struct ath11k_base *ab, u8 mac_id,
+				    int msdu_id,
+				    struct dp_tx_ring *tx_ring)
+{
+	struct ath11k *ar;
+	struct sk_buff *msdu;
+	struct ath11k_skb_cb *skb_cb;
+
+	spin_lock_bh(&tx_ring->tx_idr_lock);
+	msdu = idr_find(&tx_ring->txbuf_idr, msdu_id);
+	if (!msdu) {
+		ath11k_warn(ab, "tx completion for unknown msdu_id %d\n",
+			    msdu_id);
+		spin_unlock_bh(&tx_ring->tx_idr_lock);
+		return;
+	}
+
+	skb_cb = ATH11K_SKB_CB(msdu);
+
+	idr_remove(&tx_ring->txbuf_idr, msdu_id);
+	tx_ring->num_tx_pending--;
+	spin_unlock_bh(&tx_ring->tx_idr_lock);
+
+	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
+	dev_kfree_skb_any(msdu);
+
+	ar = ab->pdevs[mac_id].ar;
+	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
+		wake_up(&ar->dp.tx_empty_waitq);
+}
+
+static void
+ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
+				 struct dp_tx_ring *tx_ring,
+				 struct ath11k_dp_htt_wbm_tx_status *ts)
+{
+	struct sk_buff *msdu;
+	struct ieee80211_tx_info *info;
+	struct ath11k_skb_cb *skb_cb;
+	struct ath11k *ar;
+
+	spin_lock_bh(&tx_ring->tx_idr_lock);
+	msdu = idr_find(&tx_ring->txbuf_idr, ts->msdu_id);
+	if (!msdu) {
+		ath11k_warn(ab, "htt tx completion for unknown msdu_id %d\n",
+			    ts->msdu_id);
+		spin_unlock_bh(&tx_ring->tx_idr_lock);
+		return;
+	}
+
+	skb_cb = ATH11K_SKB_CB(msdu);
+	info = IEEE80211_SKB_CB(msdu);
+
+	ar = skb_cb->ar;
+
+	idr_remove(&tx_ring->txbuf_idr, ts->msdu_id);
+	tx_ring->num_tx_pending--;
+	spin_unlock_bh(&tx_ring->tx_idr_lock);
+
+	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
+		wake_up(&ar->dp.tx_empty_waitq);
+
+	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
+
+	memset(&info->status, 0, sizeof(info->status));
+
+	if (ts->acked) {
+		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
+			info->flags |= IEEE80211_TX_STAT_ACK;
+			info->status.ack_signal = ATH11K_DEFAULT_NOISE_FLOOR +
+						  ts->ack_rssi;
+			info->status.is_valid_ack_signal = true;
+		} else {
+			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
+		}
+	}
+
+	ieee80211_tx_status(ar->hw, msdu);
+}
+
+static void
+ath11k_dp_tx_process_htt_tx_complete(struct ath11k_base *ab,
+				     void *desc, u8 mac_id,
+				     u32 msdu_id, struct dp_tx_ring *tx_ring)
+{
+	struct htt_tx_wbm_completion *status_desc;
+	struct ath11k_dp_htt_wbm_tx_status ts = {0};
+	enum hal_wbm_htt_tx_comp_status wbm_status;
+
+	status_desc = desc + HTT_TX_WBM_COMP_STATUS_OFFSET;
+
+	wbm_status = FIELD_GET(HTT_TX_WBM_COMP_INFO0_STATUS,
+			       status_desc->info0);
+
+	switch (wbm_status) {
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_OK:
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP:
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL:
+		ts.acked = (wbm_status == HAL_WBM_REL_HTT_TX_COMP_STATUS_OK);
+		ts.msdu_id = msdu_id;
+		ts.ack_rssi = FIELD_GET(HTT_TX_WBM_COMP_INFO1_ACK_RSSI,
+					status_desc->info1);
+		ath11k_dp_tx_htt_tx_complete_buf(ab, tx_ring, &ts);
+		break;
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ:
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT:
+		ath11k_dp_tx_free_txbuf(ab, mac_id, msdu_id, tx_ring);
+		break;
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY:
+		/* This event is to be handled only when the driver decides to
+		 * use WDS offload functionality.
+		 */
+		break;
+	default:
+		ath11k_warn(ab, "Unknown htt tx status %d\n", wbm_status);
+		break;
+	}
+}
+
+static void ath11k_dp_tx_cache_peer_stats(struct ath11k *ar,
+					  struct sk_buff *msdu,
+					  struct hal_tx_status *ts)
+{
+	struct ath11k_per_peer_tx_stats *peer_stats = &ar->cached_stats;
+
+	if (ts->try_cnt > 1) {
+		peer_stats->retry_pkts += ts->try_cnt - 1;
+		peer_stats->retry_bytes += (ts->try_cnt - 1) * msdu->len;
+
+		if (ts->status != HAL_WBM_TQM_REL_REASON_FRAME_ACKED) {
+			peer_stats->failed_pkts += 1;
+			peer_stats->failed_bytes += msdu->len;
+		}
+	}
+}
+
+static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
+				       struct sk_buff *msdu,
+				       struct hal_tx_status *ts)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ieee80211_tx_info *info;
+	struct ath11k_skb_cb *skb_cb;
+
+	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
+		/* Must not happen */
+		return;
+	}
+
+	skb_cb = ATH11K_SKB_CB(msdu);
+
+	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
+
+	rcu_read_lock();
+
+	if (!rcu_dereference(ab->pdevs_active[ar->pdev_idx])) {
+		dev_kfree_skb_any(msdu);
+		goto exit;
+	}
+
+	if (!skb_cb->vif) {
+		dev_kfree_skb_any(msdu);
+		goto exit;
+	}
+
+	info = IEEE80211_SKB_CB(msdu);
+	memset(&info->status, 0, sizeof(info->status));
+
+	/* skip tx rate update from ieee80211_status*/
+	info->status.rates[0].idx = -1;
+
+	if (ts->status == HAL_WBM_TQM_REL_REASON_FRAME_ACKED &&
+	    !(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
+		info->flags |= IEEE80211_TX_STAT_ACK;
+		info->status.ack_signal = ATH11K_DEFAULT_NOISE_FLOOR +
+					  ts->ack_rssi;
+		info->status.is_valid_ack_signal = true;
+	}
+
+	if (ts->status == HAL_WBM_TQM_REL_REASON_CMD_REMOVE_TX &&
+	    (info->flags & IEEE80211_TX_CTL_NO_ACK))
+		info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
+
+	if (ath11k_debug_is_extd_tx_stats_enabled(ar)) {
+		if (ts->flags & HAL_TX_STATUS_FLAGS_FIRST_MSDU) {
+			if (ar->last_ppdu_id == 0) {
+				ar->last_ppdu_id = ts->ppdu_id;
+			} else if (ar->last_ppdu_id == ts->ppdu_id ||
+				   ar->cached_ppdu_id == ar->last_ppdu_id) {
+				ar->cached_ppdu_id = ar->last_ppdu_id;
+				ar->cached_stats.is_ampdu = true;
+				ath11k_update_per_peer_stats_from_txcompl(ar, msdu, ts);
+				memset(&ar->cached_stats, 0,
+				       sizeof(struct ath11k_per_peer_tx_stats));
+			} else {
+				ar->cached_stats.is_ampdu = false;
+				ath11k_update_per_peer_stats_from_txcompl(ar, msdu, ts);
+				memset(&ar->cached_stats, 0,
+				       sizeof(struct ath11k_per_peer_tx_stats));
+			}
+			ar->last_ppdu_id = ts->ppdu_id;
+		}
+
+		ath11k_dp_tx_cache_peer_stats(ar, msdu, ts);
+	}
+
+	/* NOTE: Tx rate status reporting. Tx completion status does not have
+	 * necessary information (for example nss) to build the tx rate.
+	 * Might end up reporting it out-of-band from HTT stats.
+	 */
+
+	ieee80211_tx_status(ar->hw, msdu);
+
+exit:
+	rcu_read_unlock();
+}
+
+void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
+{
+	struct ath11k *ar;
+	struct ath11k_dp *dp = &ab->dp;
+	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
+	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
+	struct sk_buff *msdu;
+	struct hal_wbm_release_ring tx_status;
+	struct hal_tx_status ts;
+	struct dp_tx_ring *tx_ring = &dp->tx_ring[ring_id];
+	u32 *desc;
+	u32 msdu_id;
+	u8 mac_id;
+
+	spin_lock_bh(&status_ring->lock);
+
+	ath11k_hal_srng_access_begin(ab, status_ring);
+
+	spin_lock_bh(&tx_ring->tx_status_lock);
+	while (!kfifo_is_full(&tx_ring->tx_status_fifo) &&
+	       (desc = ath11k_hal_srng_dst_get_next_entry(ab, status_ring))) {
+		ath11k_hal_tx_status_desc_sync((void *)desc,
+					       (void *)&tx_status);
+		kfifo_put(&tx_ring->tx_status_fifo, tx_status);
+	}
+
+	if ((ath11k_hal_srng_dst_peek(ab, status_ring) != NULL) &&
+	    kfifo_is_full(&tx_ring->tx_status_fifo)) {
+		/* TODO: Process pending tx_status messages when kfifo_is_full() */
+		ath11k_warn(ab, "Unable to process some of the tx_status ring desc because status_fifo is full\n");
+	}
+
+	spin_unlock_bh(&tx_ring->tx_status_lock);
+
+	ath11k_hal_srng_access_end(ab, status_ring);
+	spin_unlock_bh(&status_ring->lock);
+
+	spin_lock_bh(&tx_ring->tx_status_lock);
+	while (kfifo_get(&tx_ring->tx_status_fifo, &tx_status)) {
+		memset(&ts, 0, sizeof(ts));
+		ath11k_hal_tx_status_parse(ab, &tx_status, &ts);
+
+		mac_id = FIELD_GET(DP_TX_DESC_ID_MAC_ID, ts.desc_id);
+		msdu_id = FIELD_GET(DP_TX_DESC_ID_MSDU_ID, ts.desc_id);
+
+		if (ts.buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW) {
+			ath11k_dp_tx_process_htt_tx_complete(ab,
+							     (void *)&tx_status,
+							     mac_id, msdu_id,
+							     tx_ring);
+			continue;
+		}
+
+		spin_lock_bh(&tx_ring->tx_idr_lock);
+		msdu = idr_find(&tx_ring->txbuf_idr, msdu_id);
+		if (!msdu) {
+			ath11k_warn(ab, "tx completion for unknown msdu_id %d\n",
+				    msdu_id);
+			spin_unlock_bh(&tx_ring->tx_idr_lock);
+			continue;
+		}
+		idr_remove(&tx_ring->txbuf_idr, msdu_id);
+		tx_ring->num_tx_pending--;
+		spin_unlock_bh(&tx_ring->tx_idr_lock);
+
+		ar = ab->pdevs[mac_id].ar;
+
+		if (atomic_dec_and_test(&ar->dp.num_tx_pending))
+			wake_up(&ar->dp.tx_empty_waitq);
+
+		/* TODO: Locking optimization so that tx_completion for an msdu
+		 * is not called with tx_status_lock acquired
+		 */
+		ath11k_dp_tx_complete_msdu(ar, msdu, &ts);
+	}
+	spin_unlock_bh(&tx_ring->tx_status_lock);
+}
+
+int ath11k_dp_tx_send_reo_cmd(struct ath11k_base *ab, struct dp_rx_tid *rx_tid,
+			      enum hal_reo_cmd_type type,
+			      struct ath11k_hal_reo_cmd *cmd,
+			      void (*cb)(struct ath11k_dp *, void *,
+					 enum hal_reo_cmd_status))
+{
+	struct ath11k_dp *dp = &ab->dp;
+	struct dp_reo_cmd *dp_cmd;
+	struct hal_srng *cmd_ring;
+	int cmd_num;
+
+	cmd_ring = &ab->hal.srng_list[dp->reo_cmd_ring.ring_id];
+	cmd_num = ath11k_hal_reo_cmd_send(ab, cmd_ring, type, cmd);
+
+	/* reo cmd ring descriptors has cmd_num starting from 1 */
+	if (cmd_num <= 0)
+		return -EINVAL;
+
+	if (!cb)
+		return 0;
+
+	/* Can this be optimized so that we keep the pending command list only
+	 * for tid delete command to free up the resoruce on the command status
+	 * indication?
+	 */
+	dp_cmd = kzalloc(sizeof(*dp_cmd), GFP_ATOMIC);
+
+	if (!dp_cmd)
+		return -ENOMEM;
+
+	memcpy(&dp_cmd->data, rx_tid, sizeof(struct dp_rx_tid));
+	dp_cmd->cmd_num = cmd_num;
+	dp_cmd->handler = cb;
+
+	spin_lock_bh(&dp->reo_cmd_lock);
+	list_add_tail(&dp_cmd->list, &dp->reo_cmd_list);
+	spin_unlock_bh(&dp->reo_cmd_lock);
+
+	return 0;
+}
+
+static int
+ath11k_dp_tx_get_ring_id_type(struct ath11k_base *ab,
+			      int mac_id, u32 ring_id,
+			      enum hal_ring_type ring_type,
+			      enum htt_srng_ring_type *htt_ring_type,
+			      enum htt_srng_ring_id *htt_ring_id)
+{
+	int lmac_ring_id_offset = 0;
+	int ret = 0;
+
+	switch (ring_type) {
+	case HAL_RXDMA_BUF:
+		lmac_ring_id_offset = mac_id * HAL_SRNG_RINGS_PER_LMAC;
+		if (!(ring_id == (HAL_SRNG_RING_ID_WMAC1_SW2RXDMA0_BUF +
+				  lmac_ring_id_offset) ||
+		    ring_id == (HAL_SRNG_RING_ID_WMAC1_SW2RXDMA1_BUF +
+				lmac_ring_id_offset))) {
+			ret = -EINVAL;
+		}
+		*htt_ring_id = HTT_RXDMA_HOST_BUF_RING;
+		*htt_ring_type = HTT_SW_TO_HW_RING;
+		break;
+	case HAL_RXDMA_DST:
+		*htt_ring_id = HTT_RXDMA_NON_MONITOR_DEST_RING;
+		*htt_ring_type = HTT_HW_TO_SW_RING;
+		break;
+	case HAL_RXDMA_MONITOR_BUF:
+		*htt_ring_id = HTT_RXDMA_MONITOR_BUF_RING;
+		*htt_ring_type = HTT_SW_TO_HW_RING;
+		break;
+	case HAL_RXDMA_MONITOR_STATUS:
+		*htt_ring_id = HTT_RXDMA_MONITOR_STATUS_RING;
+		*htt_ring_type = HTT_SW_TO_HW_RING;
+		break;
+	case HAL_RXDMA_MONITOR_DST:
+		*htt_ring_id = HTT_RXDMA_MONITOR_DEST_RING;
+		*htt_ring_type = HTT_HW_TO_SW_RING;
+		break;
+	case HAL_RXDMA_MONITOR_DESC:
+		*htt_ring_id = HTT_RXDMA_MONITOR_DESC_RING;
+		*htt_ring_type = HTT_SW_TO_HW_RING;
+		break;
+	default:
+		ath11k_warn(ab, "Unsupported ring type in DP :%d\n", ring_type);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
+				int mac_id, enum hal_ring_type ring_type)
+{
+	struct htt_srng_setup_cmd *cmd;
+	struct hal_srng *srng = &ab->hal.srng_list[ring_id];
+	struct hal_srng_params params;
+	struct sk_buff *skb;
+	u32 ring_entry_sz;
+	int len = sizeof(*cmd);
+	dma_addr_t hp_addr, tp_addr;
+	enum htt_srng_ring_type htt_ring_type;
+	enum htt_srng_ring_id htt_ring_id;
+	int ret = 0;
+
+	skb = ath11k_htc_alloc_skb(ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	memset(&params, 0, sizeof(params));
+	ath11k_hal_srng_get_params(ab, srng, &params);
+
+	hp_addr = ath11k_hal_srng_get_hp_addr(ab, srng);
+	tp_addr = ath11k_hal_srng_get_tp_addr(ab, srng);
+
+	if (ath11k_dp_tx_get_ring_id_type(ab, mac_id, ring_id,
+					  ring_type, &htt_ring_type,
+					  &htt_ring_id))
+		goto err_free;
+
+	skb_put(skb, len);
+	cmd = (struct htt_srng_setup_cmd *)skb->data;
+	cmd->info0 = FIELD_PREP(HTT_SRNG_SETUP_CMD_INFO0_MSG_TYPE,
+				HTT_H2T_MSG_TYPE_SRING_SETUP);
+	if (htt_ring_type == HTT_SW_TO_HW_RING ||
+	    htt_ring_type == HTT_HW_TO_SW_RING)
+		cmd->info0 |= FIELD_PREP(HTT_SRNG_SETUP_CMD_INFO0_PDEV_ID,
+					 DP_SW2HW_MACID(mac_id));
+	else
+		cmd->info0 |= FIELD_PREP(HTT_SRNG_SETUP_CMD_INFO0_PDEV_ID,
+					 mac_id);
+	cmd->info0 |= FIELD_PREP(HTT_SRNG_SETUP_CMD_INFO0_RING_TYPE,
+				 htt_ring_type);
+	cmd->info0 |= FIELD_PREP(HTT_SRNG_SETUP_CMD_INFO0_RING_ID, htt_ring_id);
+
+	cmd->ring_base_addr_lo = params.ring_base_paddr &
+				 HAL_ADDR_LSB_REG_MASK;
+
+	cmd->ring_base_addr_hi = (u64)params.ring_base_paddr >>
+				 HAL_ADDR_MSB_REG_SHIFT;
+
+	ret = ath11k_hal_srng_get_entrysize(ring_type);
+	if (ret < 0)
+		return -EINVAL;
+
+	ring_entry_sz = ret;
+
+	ring_entry_sz >>= 2;
+	cmd->info1 = FIELD_PREP(HTT_SRNG_SETUP_CMD_INFO1_RING_ENTRY_SIZE,
+				ring_entry_sz);
+	cmd->info1 |= FIELD_PREP(HTT_SRNG_SETUP_CMD_INFO1_RING_SIZE,
+				 params.num_entries * ring_entry_sz);
+	cmd->info1 |= FIELD_PREP(HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_MSI_SWAP,
+				 !!(params.flags & HAL_SRNG_FLAGS_MSI_SWAP));
+	cmd->info1 |= FIELD_PREP(
+			HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_TLV_SWAP,
+			!!(params.flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP));
+	cmd->info1 |= FIELD_PREP(
+			HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_HOST_FW_SWAP,
+			!!(params.flags & HAL_SRNG_FLAGS_RING_PTR_SWAP));
+	if (htt_ring_type == HTT_SW_TO_HW_RING)
+		cmd->info1 |= HTT_SRNG_SETUP_CMD_INFO1_RING_LOOP_CNT_DIS;
+
+	cmd->ring_head_off32_remote_addr_lo = hp_addr & HAL_ADDR_LSB_REG_MASK;
+	cmd->ring_head_off32_remote_addr_hi = (u64)hp_addr >>
+					      HAL_ADDR_MSB_REG_SHIFT;
+
+	cmd->ring_tail_off32_remote_addr_lo = tp_addr & HAL_ADDR_LSB_REG_MASK;
+	cmd->ring_tail_off32_remote_addr_hi = (u64)tp_addr >>
+					      HAL_ADDR_MSB_REG_SHIFT;
+
+	cmd->ring_msi_addr_lo = 0;
+	cmd->ring_msi_addr_hi = 0;
+	cmd->msi_data = 0;
+
+	cmd->intr_info = FIELD_PREP(
+			HTT_SRNG_SETUP_CMD_INTR_INFO_BATCH_COUNTER_THRESH,
+			params.intr_batch_cntr_thres_entries * ring_entry_sz);
+	cmd->intr_info |= FIELD_PREP(
+			HTT_SRNG_SETUP_CMD_INTR_INFO_INTR_TIMER_THRESH,
+			params.intr_timer_thres_us >> 3);
+
+	cmd->info2 = 0;
+	if (params.flags & HAL_SRNG_FLAGS_LOW_THRESH_INTR_EN) {
+		cmd->info2 = FIELD_PREP(
+				HTT_SRNG_SETUP_CMD_INFO2_INTR_LOW_THRESH,
+				params.low_threshold);
+	}
+
+	ret = ath11k_htc_send(&ab->htc, ab->dp.eid, skb);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+#define HTT_TARGET_VERSION_TIMEOUT_HZ (3 * HZ)
+
+int ath11k_dp_tx_htt_h2t_ver_req_msg(struct ath11k_base *ab)
+{
+	struct ath11k_dp *dp = &ab->dp;
+	struct sk_buff *skb;
+	struct htt_ver_req_cmd *cmd;
+	int len = sizeof(*cmd);
+	int ret;
+
+	init_completion(&dp->htt_tgt_version_received);
+
+	skb = ath11k_htc_alloc_skb(ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put(skb, len);
+	cmd = (struct htt_ver_req_cmd *)skb->data;
+	cmd->ver_reg_info = FIELD_PREP(HTT_VER_REQ_INFO_MSG_ID,
+				       HTT_H2T_MSG_TYPE_VERSION_REQ);
+
+	ret = ath11k_htc_send(&ab->htc, dp->eid, skb);
+	if (ret) {
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	ret = wait_for_completion_timeout(&dp->htt_tgt_version_received,
+					  HTT_TARGET_VERSION_TIMEOUT_HZ);
+	if (ret == 0) {
+		ath11k_warn(ab, "htt target version request timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	if (dp->htt_tgt_ver_major != HTT_TARGET_VERSION_MAJOR) {
+		ath11k_err(ab, "unsupported htt major version %d supported version is %d\n",
+			   dp->htt_tgt_ver_major, HTT_TARGET_VERSION_MAJOR);
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
+int ath11k_dp_tx_htt_h2t_ppdu_stats_req(struct ath11k *ar, u32 mask)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_dp *dp = &ab->dp;
+	struct sk_buff *skb;
+	struct htt_ppdu_stats_cfg_cmd *cmd;
+	int len = sizeof(*cmd);
+	u8 pdev_mask;
+	int ret;
+
+	skb = ath11k_htc_alloc_skb(ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put(skb, len);
+	cmd = (struct htt_ppdu_stats_cfg_cmd *)skb->data;
+	cmd->msg = FIELD_PREP(HTT_PPDU_STATS_CFG_MSG_TYPE,
+			      HTT_H2T_MSG_TYPE_PPDU_STATS_CFG);
+
+	pdev_mask = 1 << (ar->pdev_idx);
+	cmd->msg |= FIELD_PREP(HTT_PPDU_STATS_CFG_PDEV_ID, pdev_mask);
+	cmd->msg |= FIELD_PREP(HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK, mask);
+
+	ret = ath11k_htc_send(&ab->htc, dp->eid, skb);
+	if (ret) {
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	return 0;
+}
+
+int ath11k_dp_tx_htt_rx_filter_setup(struct ath11k_base *ab, u32 ring_id,
+				     int mac_id, enum hal_ring_type ring_type,
+				     int rx_buf_size,
+				     struct htt_rx_ring_tlv_filter *tlv_filter)
+{
+	struct htt_rx_ring_selection_cfg_cmd *cmd;
+	struct hal_srng *srng = &ab->hal.srng_list[ring_id];
+	struct hal_srng_params params;
+	struct sk_buff *skb;
+	int len = sizeof(*cmd);
+	enum htt_srng_ring_type htt_ring_type;
+	enum htt_srng_ring_id htt_ring_id;
+	int ret = 0;
+
+	skb = ath11k_htc_alloc_skb(ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	memset(&params, 0, sizeof(params));
+	ath11k_hal_srng_get_params(ab, srng, &params);
+
+	if (ath11k_dp_tx_get_ring_id_type(ab, mac_id, ring_id,
+					  ring_type, &htt_ring_type,
+					  &htt_ring_id))
+		goto err_free;
+
+	skb_put(skb, len);
+	cmd = (struct htt_rx_ring_selection_cfg_cmd *)skb->data;
+	cmd->info0 = FIELD_PREP(HTT_RX_RING_SELECTION_CFG_CMD_INFO0_MSG_TYPE,
+				HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG);
+	if (htt_ring_type == HTT_SW_TO_HW_RING ||
+	    htt_ring_type == HTT_HW_TO_SW_RING)
+		cmd->info0 |=
+			FIELD_PREP(HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID,
+				   DP_SW2HW_MACID(mac_id));
+	else
+		cmd->info0 |=
+			FIELD_PREP(HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PDEV_ID,
+				   mac_id);
+	cmd->info0 |= FIELD_PREP(HTT_RX_RING_SELECTION_CFG_CMD_INFO0_RING_ID,
+				 htt_ring_id);
+	cmd->info0 |= FIELD_PREP(HTT_RX_RING_SELECTION_CFG_CMD_INFO0_SS,
+				 !!(params.flags & HAL_SRNG_FLAGS_MSI_SWAP));
+	cmd->info0 |= FIELD_PREP(HTT_RX_RING_SELECTION_CFG_CMD_INFO0_PS,
+				 !!(params.flags & HAL_SRNG_FLAGS_DATA_TLV_SWAP));
+
+	cmd->info1 = FIELD_PREP(HTT_RX_RING_SELECTION_CFG_CMD_INFO1_BUF_SIZE,
+				rx_buf_size);
+	cmd->pkt_type_en_flags0 = tlv_filter->pkt_filter_flags0;
+	cmd->pkt_type_en_flags1 = tlv_filter->pkt_filter_flags1;
+	cmd->pkt_type_en_flags2 = tlv_filter->pkt_filter_flags2;
+	cmd->pkt_type_en_flags3 = tlv_filter->pkt_filter_flags3;
+	cmd->rx_filter_tlv = tlv_filter->rx_filter;
+
+	ret = ath11k_htc_send(&ab->htc, ab->dp.eid, skb);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+int
+ath11k_dp_tx_htt_h2t_ext_stats_req(struct ath11k *ar, u8 type,
+				   struct htt_ext_stats_cfg_params *cfg_params,
+				   u64 cookie)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_dp *dp = &ab->dp;
+	struct sk_buff *skb;
+	struct htt_ext_stats_cfg_cmd *cmd;
+	int len = sizeof(*cmd);
+	int ret;
+
+	skb = ath11k_htc_alloc_skb(ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put(skb, len);
+
+	cmd = (struct htt_ext_stats_cfg_cmd *)skb->data;
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->hdr.msg_type = HTT_H2T_MSG_TYPE_EXT_STATS_CFG;
+
+	cmd->hdr.pdev_mask = 1 << ar->pdev->pdev_id;
+
+	cmd->hdr.stats_type = type;
+	cmd->cfg_param0 = cfg_params->cfg0;
+	cmd->cfg_param1 = cfg_params->cfg1;
+	cmd->cfg_param2 = cfg_params->cfg2;
+	cmd->cfg_param3 = cfg_params->cfg3;
+	cmd->cookie_lsb = lower_32_bits(cookie);
+	cmd->cookie_msb = upper_32_bits(cookie);
+
+	ret = ath11k_htc_send(&ab->htc, dp->eid, skb);
+	if (ret) {
+		ath11k_warn(ab, "failed to send htt type stats request: %d",
+			    ret);
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	return 0;
+}
+
+int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
+{
+	struct ath11k_pdev_dp *dp = &ar->dp;
+	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	int ret = 0, ring_id = 0;
+
+	ring_id = dp->rxdma_mon_buf_ring.refill_buf_ring.ring_id;
+
+	if (!reset) {
+		tlv_filter.rx_filter = HTT_RX_MON_FILTER_TLV_FLAGS_MON_BUF_RING;
+		tlv_filter.pkt_filter_flags0 =
+					HTT_RX_MON_FP_MGMT_FILTER_FLAGS0 |
+					HTT_RX_MON_MO_MGMT_FILTER_FLAGS0;
+		tlv_filter.pkt_filter_flags1 =
+					HTT_RX_MON_FP_MGMT_FILTER_FLAGS1 |
+					HTT_RX_MON_MO_MGMT_FILTER_FLAGS1;
+		tlv_filter.pkt_filter_flags2 =
+					HTT_RX_MON_FP_CTRL_FILTER_FLASG2 |
+					HTT_RX_MON_MO_CTRL_FILTER_FLASG2;
+		tlv_filter.pkt_filter_flags3 =
+					HTT_RX_MON_FP_CTRL_FILTER_FLASG3 |
+					HTT_RX_MON_MO_CTRL_FILTER_FLASG3 |
+					HTT_RX_MON_FP_DATA_FILTER_FLASG3 |
+					HTT_RX_MON_MO_DATA_FILTER_FLASG3;
+	}
+
+	ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, dp->mac_id,
+					       HAL_RXDMA_MONITOR_BUF,
+					       DP_RXDMA_REFILL_RING_SIZE,
+					       &tlv_filter);
+	if (ret)
+		return ret;
+
+	ring_id = dp->rx_mon_status_refill_ring.refill_buf_ring.ring_id;
+	if (!reset)
+		tlv_filter.rx_filter =
+				HTT_RX_MON_FILTER_TLV_FLAGS_MON_STATUS_RING;
+	else
+		tlv_filter = ath11k_mac_mon_status_filter_default;
+
+	ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, dp->mac_id,
+					       HAL_RXDMA_MONITOR_STATUS,
+					       DP_RXDMA_REFILL_RING_SIZE,
+					       &tlv_filter);
+	return ret;
+}

