Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DB11842B6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 09:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCMIcr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 04:32:47 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:62649 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgCMIcr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 04:32:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584088367; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=zqKC+TFR/QaUIs4aBINzxVWqfzmVO6EOjAMLlQsFcsQ=; b=CMpUUCIKgvlrETu5oE0fGMvICdLEUEaqpW6o3yc/AqD70/riNeWWJx9f0TFl3fKILLHvPXPD
 TDbbAIpGIACSyiS0LXRVXtGVDOZ0FWldKCIuz1qzXGuCDYz2jC/SH7zGFhYCya6oEmj48SLy
 p4fFQ35uTWChhUZ4Ota4Ks4KvcQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6b452d.7f01023b5068-smtp-out-n05;
 Fri, 13 Mar 2020 08:32:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 26E5BC4478F; Fri, 13 Mar 2020 08:32:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DFCB8C44792;
        Fri, 13 Mar 2020 08:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFCB8C44792
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Subject: [PATCH v2 2/2] ath11k: enable PN offload
Date:   Fri, 13 Mar 2020 14:02:23 +0530
Message-Id: <1584088343-3584-3-git-send-email-mpubbise@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584088343-3584-1-git-send-email-mpubbise@codeaurora.org>
References: <1584088343-3584-1-git-send-email-mpubbise@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enabling PN checking in the hardware; hardware checks
the PN of the received packets and reports the errors
to the host for further handling; default action is to
drop such packets. TSC (TKIP sequence counter)
validation is also offloaded.

Hardware validates PN/TSC only for unicast packets;
for group addressed packets, PN validation is done
in mac80211.

PN errors are reported to the driver via WBM RX release
ring and can be dumped by using the following command.

"cat /sys/kernel/debug/ath11k/soc_rx_stats | grep -i pn"

Sample Output:
PN check fail: 210

Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h   |   1 +
 drivers/net/wireless/ath/ath11k/dp.c     |   4 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c  | 115 ++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/dp_rx.h  |   7 +-
 drivers/net/wireless/ath/ath11k/hal.h    |   2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c |  14 +++-
 drivers/net/wireless/ath/ath11k/mac.c    |  27 ++++++++
 7 files changed, 156 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index af83429..af04e12 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -333,6 +333,7 @@ struct ath11k_sta {
 	u32 bw;
 	u32 nss;
 	u32 smps;
+	enum hal_pn_type pn_type;
 
 	struct work_struct update_wk;
 	struct rate_info txrate;
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 9971744..a1371ab 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -58,8 +58,8 @@ int ath11k_dp_peer_setup(struct ath11k *ar, int vdev_id, const u8 *addr)
 	}
 
 	for (tid = 0; tid <= IEEE80211_NUM_TIDS; tid++) {
-		ret = ath11k_peer_rx_tid_setup(ar, addr, vdev_id,
-					       tid, 1, 0);
+		ret = ath11k_peer_rx_tid_setup(ar, addr, vdev_id, tid, 1, 0,
+					       HAL_PN_TYPE_NONE);
 		if (ret) {
 			ath11k_warn(ab, "failed to setup rxd tid queue for tid %d: %d\n",
 				    tid, ret);
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 9871f2d..320fec2 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -843,7 +843,8 @@ static void ath11k_dp_rx_tid_mem_free(struct ath11k_base *ab,
 }
 
 int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
-			     u8 tid, u32 ba_win_sz, u16 ssn)
+			     u8 tid, u32 ba_win_sz, u16 ssn,
+			     enum hal_pn_type pn_type)
 {
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_peer *peer;
@@ -904,7 +905,8 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 
 	addr_aligned = PTR_ALIGN(vaddr, HAL_LINK_DESC_ALIGN);
 
-	ath11k_hal_reo_qdesc_setup(addr_aligned, tid, ba_win_sz, ssn);
+	ath11k_hal_reo_qdesc_setup(addr_aligned, tid, ba_win_sz,
+				   ssn, pn_type);
 
 	paddr = dma_map_single(ab->dev, addr_aligned, hw_desc_sz,
 			       DMA_BIDIRECTIONAL);
@@ -948,7 +950,7 @@ int ath11k_dp_rx_ampdu_start(struct ath11k *ar,
 
 	ret = ath11k_peer_rx_tid_setup(ar, params->sta->addr, vdev_id,
 				       params->tid, params->buf_size,
-				       params->ssn);
+				       params->ssn, arsta->pn_type);
 	if (ret)
 		ath11k_warn(ab, "failed to setup rx tid %d\n", ret);
 
@@ -1001,8 +1003,80 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
 	return ret;
 }
 
-static int ath11k_get_ppdu_user_index(struct htt_ppdu_stats *ppdu_stats,
-				      u16 peer_id)
+int ath11k_dp_peer_rx_pn_replay_config(struct ath11k_vif *arvif,
+				       const u8 *peer_addr,
+				       enum set_key_cmd key_cmd,
+				       struct ieee80211_key_conf *key)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_hal_reo_cmd cmd = {0};
+	struct ath11k_peer *peer;
+	struct dp_rx_tid *rx_tid;
+	u8 tid;
+	int ret = 0;
+
+	/* NOTE: Enable PN/TSC replay check offload only for unicast frames.
+	 * We use mac80211 PN/TSC replay check functionality for bcast/mcast
+	 * for now.
+	 */
+	if (!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		return 0;
+
+	cmd.flag |= HAL_REO_CMD_FLG_NEED_STATUS;
+	cmd.upd0 |= HAL_REO_CMD_UPD0_PN |
+		    HAL_REO_CMD_UPD0_PN_SIZE |
+		    HAL_REO_CMD_UPD0_PN_VALID |
+		    HAL_REO_CMD_UPD0_PN_CHECK |
+		    HAL_REO_CMD_UPD0_SVLD;
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		if (key_cmd == SET_KEY) {
+			cmd.upd1 |= HAL_REO_CMD_UPD1_PN_CHECK;
+			cmd.pn_size = 48;
+		}
+		break;
+	default:
+		break;
+	}
+
+	spin_lock_bh(&ab->base_lock);
+
+	peer = ath11k_peer_find(ab, arvif->vdev_id, peer_addr);
+	if (!peer) {
+		ath11k_warn(ab, "failed to find the peer to configure pn replay detection\n");
+		spin_unlock_bh(&ab->base_lock);
+		return -ENOENT;
+	}
+
+	for (tid = 0; tid <= IEEE80211_NUM_TIDS; tid++) {
+		rx_tid = &peer->rx_tid[tid];
+		if (!rx_tid->active)
+			continue;
+		cmd.addr_lo = lower_32_bits(rx_tid->paddr);
+		cmd.addr_hi = upper_32_bits(rx_tid->paddr);
+		ret = ath11k_dp_tx_send_reo_cmd(ab, rx_tid,
+						HAL_REO_CMD_UPDATE_RX_QUEUE,
+						&cmd, NULL);
+		if (ret) {
+			ath11k_warn(ab, "failed to configure rx tid %d queue for pn replay detection %d\n",
+				    tid, ret);
+			break;
+		}
+	}
+
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	return ret;
+}
+
+static inline int ath11k_get_ppdu_user_index(struct htt_ppdu_stats *ppdu_stats,
+					     u16 peer_id)
 {
 	int i;
 
@@ -1974,7 +2048,7 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 	struct sk_buff *last_msdu;
 	struct sk_buff *msdu;
 	struct ath11k_skb_rxcb *last_rxcb;
-	bool is_decrypted;
+	bool is_decrypted = false, fill_crypto_hdr;
 	u32 err_bitmap;
 	u8 *qos;
 
@@ -1991,6 +2065,9 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 		qos[0] &= ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
 	}
 
+	/* PN for multicast packets will be checked in mac80211 */
+	fill_crypto_hdr = is_multicast_ether_addr(hdr->addr1);
+
 	is_decrypted = ath11k_dp_rx_h_attn_is_decrypted(rx_desc);
 	enctype = ath11k_dp_rx_h_mpdu_start_enctype(rx_desc);
 
@@ -2013,14 +2090,27 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 	if (err_bitmap & DP_RX_MPDU_ERR_TKIP_MIC)
 		rx_status->flag |= RX_FLAG_MMIC_ERROR;
 
-	if (is_decrypted)
-		rx_status->flag |= RX_FLAG_DECRYPTED | RX_FLAG_MMIC_STRIPPED |
-				   RX_FLAG_MIC_STRIPPED | RX_FLAG_ICV_STRIPPED;
+	if (is_decrypted) {
+		rx_status->flag |= RX_FLAG_DECRYPTED | RX_FLAG_MMIC_STRIPPED;
+
+		if (fill_crypto_hdr)
+			rx_status->flag |= RX_FLAG_MIC_STRIPPED |
+					RX_FLAG_ICV_STRIPPED;
+		else
+			rx_status->flag |= RX_FLAG_IV_STRIPPED |
+					   RX_FLAG_PN_VALIDATED;
+	}
 
 	skb_queue_walk(amsdu_list, msdu) {
 		ath11k_dp_rx_h_csum_offload(msdu);
 		ath11k_dp_rx_h_undecap(ar, msdu, rx_desc,
 				       enctype, rx_status, is_decrypted);
+
+		if (!is_decrypted || fill_crypto_hdr)
+			continue;
+
+		hdr = (void *)msdu->data;
+		hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
 	}
 }
 
@@ -3603,6 +3693,13 @@ static bool ath11k_dp_rx_h_reo_err(struct ath11k *ar, struct sk_buff *msdu,
 		if (ath11k_dp_rx_h_null_q_desc(ar, msdu, status, msdu_list))
 			drop = true;
 		break;
+	case HAL_REO_DEST_RING_ERROR_CODE_PN_CHECK_FAILED:
+		/* TODO: Do not drop PN failed packets in the driver;
+		 * instead, it is good to drop such packets in mac80211
+		 * after incrementing the replay counters.
+		 */
+
+		/* fall through */
 	default:
 		/* TODO: Review other errors and process them to mac80211
 		 * as appropriate.
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
index c3f3ccd..9ab535f 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.h
@@ -43,11 +43,16 @@ int ath11k_dp_rx_ampdu_start(struct ath11k *ar,
 			     struct ieee80211_ampdu_params *params);
 int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
 			    struct ieee80211_ampdu_params *params);
+int ath11k_dp_peer_rx_pn_replay_config(struct ath11k_vif *arvif,
+				       const u8 *peer_addr,
+				       enum set_key_cmd key_cmd,
+				       struct ieee80211_key_conf *key);
 void ath11k_peer_rx_tid_cleanup(struct ath11k *ar, struct ath11k_peer *peer);
 void ath11k_peer_rx_tid_delete(struct ath11k *ar,
 			       struct ath11k_peer *peer, u8 tid);
 int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
-			     u8 tid, u32 ba_win_sz, u16 ssn);
+			     u8 tid, u32 ba_win_sz, u16 ssn,
+			     enum hal_pn_type pn_type);
 void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
 				       struct sk_buff *skb);
 int ath11k_dp_pdev_reo_setup(struct ath11k_base *ab);
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 5b13ccd..4cfd934 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -847,7 +847,7 @@ struct ath11k_hal {
 
 u32 ath11k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
 void ath11k_hal_reo_qdesc_setup(void *vaddr, int tid, u32 ba_window_size,
-				u32 start_seqtype);
+				u32 start_seq, enum hal_pn_type type);
 void ath11k_hal_reo_init_cmd_ring(struct ath11k_base *ab,
 				  struct hal_srng *srng);
 void ath11k_hal_reo_hw_setup(struct ath11k_base *ab);
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 58c57f9..3a66656 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -694,7 +694,7 @@ u32 ath11k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid)
 }
 
 void ath11k_hal_reo_qdesc_setup(void *vaddr, int tid, u32 ba_window_size,
-				u32 start_seq)
+				u32 start_seq, enum hal_pn_type type)
 {
 	struct hal_rx_reo_queue *qdesc = (struct hal_rx_reo_queue *)vaddr;
 	struct hal_rx_reo_queue_ext *ext_desc;
@@ -723,6 +723,18 @@ void ath11k_hal_reo_qdesc_setup(void *vaddr, int tid, u32 ba_window_size,
 
 	qdesc->info0 |= FIELD_PREP(HAL_RX_REO_QUEUE_INFO0_BA_WINDOW_SIZE,
 				   ba_window_size - 1);
+	switch (type) {
+	case HAL_PN_TYPE_NONE:
+	case HAL_PN_TYPE_WAPI_EVEN:
+	case HAL_PN_TYPE_WAPI_UNEVEN:
+		break;
+	case HAL_PN_TYPE_WPA:
+		qdesc->info0 |=
+			FIELD_PREP(HAL_RX_REO_QUEUE_INFO0_PN_CHECK, 1) |
+			FIELD_PREP(HAL_RX_REO_QUEUE_INFO0_PN_SIZE,
+				   HAL_RX_REO_QUEUE_PN_SIZE_48);
+		break;
+	}
 
 	/* TODO: Set Ignore ampdu flags based on BA window size and/or
 	 * AMPDU capabilities
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2b90975..c02e4a3 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2325,6 +2325,7 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_peer *peer;
+	struct ath11k_sta *arsta;
 	const u8 *peer_addr;
 	int ret = 0;
 	u32 flags = 0;
@@ -2382,6 +2383,12 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		goto exit;
 	}
 
+	ret = ath11k_dp_peer_rx_pn_replay_config(arvif, peer_addr, cmd, key);
+	if (ret) {
+		ath11k_warn(ab, "failed to offload PN replay detection %d\n", ret);
+		goto exit;
+	}
+
 	spin_lock_bh(&ab->base_lock);
 	peer = ath11k_peer_find(ab, arvif->vdev_id, peer_addr);
 	if (peer && cmd == SET_KEY) {
@@ -2399,6 +2406,26 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	} else if (!peer)
 		/* impossible unless FW goes crazy */
 		ath11k_warn(ab, "peer %pM disappeared!\n", peer_addr);
+
+	if (sta) {
+		arsta = (struct ath11k_sta *)sta->drv_priv;
+
+		switch (key->cipher) {
+		case WLAN_CIPHER_SUITE_TKIP:
+		case WLAN_CIPHER_SUITE_CCMP:
+		case WLAN_CIPHER_SUITE_CCMP_256:
+		case WLAN_CIPHER_SUITE_GCMP:
+		case WLAN_CIPHER_SUITE_GCMP_256:
+			if (cmd == SET_KEY)
+				arsta->pn_type = HAL_PN_TYPE_WPA;
+			else
+				arsta->pn_type = HAL_PN_TYPE_NONE;
+			break;
+		default:
+			arsta->pn_type = HAL_PN_TYPE_NONE;
+			break;
+		}
+	}
 	spin_unlock_bh(&ab->base_lock);
 
 exit:
-- 
2.7.4
