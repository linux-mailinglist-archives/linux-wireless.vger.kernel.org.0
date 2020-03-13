Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C261842B5
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 09:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCMIcq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 04:32:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:48387 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726364AbgCMIcq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 04:32:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584088364; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=eAjQJ1GRw9cXW2qfRYlcmnM8gH4X40+x9LyP0V6kEs4=; b=BpQ/zRfE8gfckGgqNWOV2BWCMQ5t6nqgabx5qvvzcHCljczef7U7J1GYlAGNNRFZZimZBH2L
 dOQHd8/kvlG2/XB4vzksh8jj12VhpASmRewpZaKakKU4tanugB+burkR/C7mVwDnLMj0rNn0
 SA0eaOHw3kLVegijki2PEns9b80=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6b452c.7f31a9618dc0-smtp-out-n02;
 Fri, 13 Mar 2020 08:32:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25106C433CB; Fri, 13 Mar 2020 08:32:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1AF4C44788;
        Fri, 13 Mar 2020 08:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1AF4C44788
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Subject: [PATCH v2 1/2] ath11k: handle RX fragments
Date:   Fri, 13 Mar 2020 14:02:22 +0530
Message-Id: <1584088343-3584-2-git-send-email-mpubbise@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584088343-3584-1-git-send-email-mpubbise@codeaurora.org>
References: <1584088343-3584-1-git-send-email-mpubbise@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IPQ8074 HW has support to verify the PN of the received frames.
For all frames except for fragmented ones, HW checks the PN and
delivers them to the driver. For fragmented frames, driver is
required to do a little more; it has to reassemble the fragments
and then reinject them to the HW for verifying the PN. Currently,
to keep the logic simple, PN verifcation is disabled in HW and is
handled in mac80211 for all the frames (fragmented and unfragmented).

On the contrary, offloading PN Validation to the HW brings important
benefits. It reduces CPU cycles spent on the host CPU for verifying
the same; helps in enabling features which improve performance like
mac80211 fast RX path, enabling multiple REO rings for parallel RX
processing, 802.11 decapsulation offloading. All these features are
dependent on PN offload which in turn is dependent on handling of
the received fragments in the driver.

When TKIP security is used, additional handling is required while
processing the fragments; since MIC is computed on an MSDU in TKIP,
only the last fragment has the MIC info. In this case, driver has to
compute the MIC after reassembly and compare it against the MIC
present in the frame. For this, MICHAEL_MIC kernel crypto library
APIs are used and the dependencies are appropriately set.

Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/Kconfig   |   1 +
 drivers/net/wireless/ath/ath11k/core.h    |   1 +
 drivers/net/wireless/ath/ath11k/dp.c      |   8 +
 drivers/net/wireless/ath/ath11k/dp.h      |  12 +
 drivers/net/wireless/ath/ath11k/dp_rx.c   | 755 ++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/dp_rx.h   |   1 +
 drivers/net/wireless/ath/ath11k/mac.c     |  14 +-
 drivers/net/wireless/ath/ath11k/peer.h    |   7 +
 drivers/net/wireless/ath/ath11k/rx_desc.h |   2 +-
 9 files changed, 709 insertions(+), 92 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index c88e16d..738f990 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -3,6 +3,7 @@ config ATH11K
 	tristate "Qualcomm Technologies 802.11ax chipset support"
 	depends on MAC80211 && HAS_DMA
 	depends on REMOTEPROC
+	depends on CRYPTO_MICHAEL_MIC
 	depends on ARCH_QCOM || COMPILE_TEST
 	select ATH_COMMON
 	select QCOM_QMI_HELPERS
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 5c767d8..af83429 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -77,6 +77,7 @@ struct ath11k_skb_rxcb {
 	u8 err_code;
 	u8 mac_id;
 	u8 unmapped;
+	u8 is_frag;
 };
 
 enum ath11k_hw_rev {
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index ce76341..9971744 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  */
 
+#include <crypto/hash.h>
 #include "core.h"
 #include "dp_tx.h"
 #include "hal_tx.h"
@@ -33,6 +34,7 @@ void ath11k_dp_peer_cleanup(struct ath11k *ar, int vdev_id, const u8 *addr)
 	}
 
 	ath11k_peer_rx_tid_cleanup(ar, peer);
+	crypto_free_shash(peer->tfm_mmic);
 	spin_unlock_bh(&ab->base_lock);
 }
 
@@ -65,6 +67,12 @@ int ath11k_dp_peer_setup(struct ath11k *ar, int vdev_id, const u8 *addr)
 		}
 	}
 
+	ret = ath11k_peer_rx_frag_setup(ar, addr, vdev_id);
+	if (ret) {
+		ath11k_warn(ab, "failed to setup rx defrag context\n");
+		return ret;
+	}
+
 	/* TODO: Setup other peer specific resource used in data path */
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 4f9e4ce..ed11728 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -22,6 +22,18 @@ struct dp_rx_tid {
 	u32 size;
 	u32 ba_win_sz;
 	bool active;
+
+	/* Info related to rx fragments */
+	u32 cur_sn;
+	u16 last_frag_no;
+	u16 rx_frag_bitmap;
+
+	struct sk_buff_head rx_frags;
+	struct hal_reo_dest_ring *dst_ring_desc;
+
+	/* Timer info related to fragments */
+	struct timer_list frag_timer;
+	struct ath11k_base *ab;
 };
 
 #define DP_REO_DESC_FREE_TIMEOUT_MS 1000
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index dc7881b..9871f2d 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/ieee80211.h>
+#include <crypto/hash.h>
 #include "core.h"
 #include "debug.h"
 #include "hal_desc.h"
@@ -13,6 +14,8 @@
 #include "dp_tx.h"
 #include "peer.h"
 
+#define ATH11K_DP_RX_FRAGMENT_TIMEOUT_MS (2 * HZ)
+
 static u8 *ath11k_dp_rx_h_80211_hdr(struct hal_rx_desc *desc)
 {
 	return desc->hdr_status;
@@ -28,10 +31,44 @@ static enum hal_encrypt_type ath11k_dp_rx_h_mpdu_start_enctype(struct hal_rx_des
 			 __le32_to_cpu(desc->mpdu_start.info2));
 }
 
-static u8 ath11k_dp_rx_h_mpdu_start_decap_type(struct hal_rx_desc *desc)
+static u8 ath11k_dp_rx_h_msdu_start_decap_type(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO2_DECAP_FORMAT,
+			 __le32_to_cpu(desc->msdu_start.info2));
+}
+
+static bool ath11k_dp_rx_h_mpdu_start_seq_ctrl_valid(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MPDU_START_INFO1_MPDU_SEQ_CTRL_VALID,
+			   __le32_to_cpu(desc->mpdu_start.info1));
+}
+
+static bool ath11k_dp_rx_h_mpdu_start_fc_valid(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MPDU_START_INFO1_MPDU_FCTRL_VALID,
+			   __le32_to_cpu(desc->mpdu_start.info1));
+}
+
+static bool ath11k_dp_rx_h_mpdu_start_more_frags(struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr;
+
+	hdr = (struct ieee80211_hdr *)(skb->data + HAL_RX_DESC_SIZE);
+	return ieee80211_has_morefrags(hdr->frame_control);
+}
+
+static u16 ath11k_dp_rx_h_mpdu_start_frag_no(struct sk_buff *skb)
 {
-	return FIELD_GET(RX_MPDU_START_INFO5_DECAP_TYPE,
-			 __le32_to_cpu(desc->mpdu_start.info5));
+	struct ieee80211_hdr *hdr;
+
+	hdr = (struct ieee80211_hdr *)(skb->data + HAL_RX_DESC_SIZE);
+	return le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;
+}
+
+static u16 ath11k_dp_rx_h_mpdu_start_seq_no(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MPDU_START_INFO1_MPDU_SEQ_NUM,
+			 __le32_to_cpu(desc->mpdu_start.info1));
 }
 
 static bool ath11k_dp_rx_h_attn_msdu_done(struct hal_rx_desc *desc)
@@ -137,6 +174,17 @@ static u8 ath11k_dp_rx_h_msdu_start_nss(struct hal_rx_desc *desc)
 	return hweight8(mimo_ss_bitmap);
 }
 
+static u8 ath11k_dp_rx_h_mpdu_start_tid(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MPDU_START_INFO2_TID,
+			 __le32_to_cpu(desc->mpdu_start.info2));
+}
+
+static u16 ath11k_dp_rx_h_mpdu_start_peer_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->mpdu_start.sw_peer_id);
+}
+
 static u8 ath11k_dp_rx_h_msdu_end_l3pad(struct hal_rx_desc *desc)
 {
 	return FIELD_GET(RX_MSDU_END_INFO2_L3_HDR_PADDING,
@@ -661,12 +709,75 @@ void ath11k_peer_rx_tid_delete(struct ath11k *ar,
 	rx_tid->active = false;
 }
 
+static int ath11k_dp_rx_link_desc_return(struct ath11k_base *ab,
+					 u32 *link_desc,
+					 enum hal_wbm_rel_bm_act action)
+{
+	struct ath11k_dp *dp = &ab->dp;
+	struct hal_srng *srng;
+	u32 *desc;
+	int ret = 0;
+
+	srng = &ab->hal.srng_list[dp->wbm_desc_rel_ring.ring_id];
+
+	spin_lock_bh(&srng->lock);
+
+	ath11k_hal_srng_access_begin(ab, srng);
+
+	desc = ath11k_hal_srng_src_get_next_entry(ab, srng);
+	if (!desc) {
+		ret = -ENOBUFS;
+		goto exit;
+	}
+
+	ath11k_hal_rx_msdu_link_desc_set(ab, (void *)desc, (void *)link_desc,
+					 action);
+
+exit:
+	ath11k_hal_srng_access_end(ab, srng);
+
+	spin_unlock_bh(&srng->lock);
+
+	return ret;
+}
+
+static void ath11k_dp_rx_frags_cleanup(struct dp_rx_tid *rx_tid, bool rel_link_desc)
+{
+	struct ath11k_base *ab = rx_tid->ab;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	if (rx_tid->dst_ring_desc) {
+		if (rel_link_desc)
+			ath11k_dp_rx_link_desc_return(ab, (u32 *)rx_tid->dst_ring_desc,
+						      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+		kfree(rx_tid->dst_ring_desc);
+		rx_tid->dst_ring_desc = NULL;
+	}
+
+	rx_tid->cur_sn = 0;
+	rx_tid->last_frag_no = 0;
+	rx_tid->rx_frag_bitmap = 0;
+	__skb_queue_purge(&rx_tid->rx_frags);
+}
+
 void ath11k_peer_rx_tid_cleanup(struct ath11k *ar, struct ath11k_peer *peer)
 {
+	struct dp_rx_tid *rx_tid;
 	int i;
 
-	for (i = 0; i <= IEEE80211_NUM_TIDS; i++)
+	lockdep_assert_held(&ar->ab->base_lock);
+
+	for (i = 0; i <= IEEE80211_NUM_TIDS; i++) {
+		rx_tid = &peer->rx_tid[i];
+
 		ath11k_peer_rx_tid_delete(ar, peer, i);
+		ath11k_dp_rx_frags_cleanup(rx_tid, true);
+
+		spin_unlock_bh(&ar->ab->base_lock);
+		del_timer_sync(&rx_tid->frag_timer);
+		spin_lock_bh(&ar->ab->base_lock);
+	}
 }
 
 static int ath11k_peer_rx_tid_reo_update(struct ath11k *ar,
@@ -1525,7 +1636,9 @@ static int ath11k_dp_rx_retrieve_amsdu(struct ath11k *ar,
 		msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(rx_desc);
 		l3_pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(lrx_desc);
 
-		if (!rxcb->is_continuation) {
+		if (rxcb->is_frag) {
+			skb_pull(msdu, HAL_RX_DESC_SIZE);
+		} else if (!rxcb->is_continuation) {
 			skb_put(msdu, HAL_RX_DESC_SIZE + l3_pad_bytes + msdu_len);
 			skb_pull(msdu, HAL_RX_DESC_SIZE + l3_pad_bytes);
 		} else {
@@ -1830,7 +1943,7 @@ static void ath11k_dp_rx_h_undecap(struct ath11k *ar, struct sk_buff *msdu,
 	u8 decap;
 
 	first_hdr = ath11k_dp_rx_h_80211_hdr(rx_desc);
-	decap = ath11k_dp_rx_h_mpdu_start_decap_type(rx_desc);
+	decap = ath11k_dp_rx_h_msdu_start_decap_type(rx_desc);
 
 	switch (decap) {
 	case DP_RX_DECAP_TYPE_NATIVE_WIFI:
@@ -2668,99 +2781,563 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 	return num_buffs_reaped;
 }
 
-static int ath11k_dp_rx_link_desc_return(struct ath11k_base *ab,
-					 u32 *link_desc,
-					 enum hal_wbm_rel_bm_act action)
+static void ath11k_dp_rx_frag_timer(struct timer_list *timer)
 {
-	struct ath11k_dp *dp = &ab->dp;
-	struct hal_srng *srng;
-	u32 *desc;
-	int ret = 0;
+	struct dp_rx_tid *rx_tid = from_timer(rx_tid, timer, frag_timer);
 
-	srng = &ab->hal.srng_list[dp->wbm_desc_rel_ring.ring_id];
+	spin_lock_bh(&rx_tid->ab->base_lock);
+	if (rx_tid->last_frag_no &&
+	    rx_tid->rx_frag_bitmap == GENMASK(rx_tid->last_frag_no, 0)) {
+		spin_unlock_bh(&rx_tid->ab->base_lock);
+		return;
+	}
+	ath11k_dp_rx_frags_cleanup(rx_tid, true);
+	spin_unlock_bh(&rx_tid->ab->base_lock);
+}
 
-	spin_lock_bh(&srng->lock);
+int ath11k_peer_rx_frag_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct crypto_shash *tfm;
+	struct ath11k_peer *peer;
+	struct dp_rx_tid *rx_tid;
+	int i;
 
-	ath11k_hal_srng_access_begin(ab, srng);
+	tfm = crypto_alloc_shash("michael_mic", 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
 
-	desc = ath11k_hal_srng_src_get_next_entry(ab, srng);
-	if (!desc) {
-		ret = -ENOBUFS;
-		goto exit;
+	spin_lock_bh(&ab->base_lock);
+
+	peer = ath11k_peer_find(ab, vdev_id, peer_mac);
+	if (!peer) {
+		ath11k_warn(ab, "failed to find the peer to set up fragment info\n");
+		spin_unlock_bh(&ab->base_lock);
+		return -ENOENT;
 	}
 
-	ath11k_hal_rx_msdu_link_desc_set(ab, (void *)desc, (void *)link_desc,
-					 action);
+	for (i = 0; i <= IEEE80211_NUM_TIDS; i++) {
+		rx_tid = &peer->rx_tid[i];
+		rx_tid->ab = ab;
+		timer_setup(&rx_tid->frag_timer, ath11k_dp_rx_frag_timer, 0);
+		skb_queue_head_init(&rx_tid->rx_frags);
+	}
 
-exit:
-	ath11k_hal_srng_access_end(ab, srng);
+	peer->tfm_mmic = tfm;
+	spin_unlock_bh(&ab->base_lock);
 
-	spin_unlock_bh(&srng->lock);
+	return 0;
+}
+
+static int ath11k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
+				      struct ieee80211_hdr *hdr, u8 *data,
+				      size_t data_len, u8 *mic)
+{
+	SHASH_DESC_ON_STACK(desc, tfm);
+	u8 mic_hdr[16] = {0};
+	u8 tid = 0;
+	int ret;
+
+	if (!tfm)
+		return -EINVAL;
+
+	desc->tfm = tfm;
+
+	ret = crypto_shash_setkey(tfm, key, 8);
+	if (ret)
+		goto out;
 
+	ret = crypto_shash_init(desc);
+	if (ret)
+		goto out;
+
+	/* TKIP MIC header */
+	memcpy(mic_hdr, ieee80211_get_DA(hdr), ETH_ALEN);
+	memcpy(mic_hdr + ETH_ALEN, ieee80211_get_SA(hdr), ETH_ALEN);
+	if (ieee80211_is_data_qos(hdr->frame_control))
+		tid = ieee80211_get_tid(hdr);
+	mic_hdr[12] = tid;
+
+	ret = crypto_shash_update(desc, mic_hdr, 16);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(desc, data, data_len);
+	if (ret)
+		goto out;
+	ret = crypto_shash_final(desc, mic);
+out:
+	shash_desc_zero(desc);
 	return ret;
 }
 
-static void ath11k_dp_rx_frag_h_mpdu(struct ath11k *ar,
-				     struct sk_buff *msdu,
-				     struct hal_rx_desc *rx_desc,
-				     struct ieee80211_rx_status *rx_status)
+static int ath11k_dp_rx_h_verify_tkip_mic(struct ath11k *ar, struct ath11k_peer *peer,
+					  struct sk_buff *msdu)
 {
-	u8 rx_channel;
+	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
+	struct ieee80211_rx_status *rxs = IEEE80211_SKB_RXCB(msdu);
+	struct ieee80211_key_conf *key_conf;
+	struct ieee80211_hdr *hdr;
+	u8 mic[IEEE80211_CCMP_MIC_LEN];
+	int head_len, tail_len, ret;
+	size_t data_len;
+	u32 hdr_len;
+	u8 *key, *data;
+	u8 key_idx;
+
+	if (ath11k_dp_rx_h_mpdu_start_enctype(rx_desc) != HAL_ENCRYPT_TYPE_TKIP_MIC)
+		return 0;
+
+	hdr = (struct ieee80211_hdr *)(msdu->data + HAL_RX_DESC_SIZE);
+	hdr_len = ieee80211_hdrlen(hdr->frame_control);
+	head_len = hdr_len + HAL_RX_DESC_SIZE + IEEE80211_TKIP_IV_LEN;
+	tail_len = IEEE80211_CCMP_MIC_LEN + IEEE80211_TKIP_ICV_LEN + FCS_LEN;
+
+	if (!is_multicast_ether_addr(hdr->addr1))
+		key_idx = peer->ucast_keyidx;
+	else
+		key_idx = peer->mcast_keyidx;
+
+	key_conf = peer->keys[key_idx];
+
+	data = msdu->data + head_len;
+	data_len = msdu->len - head_len - tail_len;
+	key = &key_conf->key[NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY];
+
+	ret = ath11k_dp_rx_h_michael_mic(peer->tfm_mmic, key, hdr, data, data_len, mic);
+	if (ret || memcmp(mic, data + data_len, IEEE80211_CCMP_MIC_LEN))
+		goto mic_fail;
+
+	return 0;
+
+mic_fail:
+	(ATH11K_SKB_RXCB(msdu))->is_first_msdu = 1;
+	(ATH11K_SKB_RXCB(msdu))->is_last_msdu = 1;
+
+	rxs->flag |= RX_FLAG_MMIC_ERROR | RX_FLAG_MMIC_STRIPPED |
+		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
+	skb_pull(msdu, HAL_RX_DESC_SIZE);
+
+	ath11k_dp_rx_h_ppdu(ar, rx_desc, rxs);
+	ath11k_dp_rx_h_undecap(ar, msdu, rx_desc,
+			       HAL_ENCRYPT_TYPE_TKIP_MIC, rxs, true);
+	ieee80211_rx(ar->hw, msdu);
+	return -EINVAL;
+}
+
+static void ath11k_dp_rx_h_undecap_frag(struct ath11k *ar, struct sk_buff *msdu,
+					enum hal_encrypt_type enctype, u32 flags)
+{
+	struct ieee80211_hdr *hdr;
+	size_t hdr_len;
+	size_t crypto_len;
+
+	if (!flags)
+		return;
+
+	hdr = (struct ieee80211_hdr *)(msdu->data + HAL_RX_DESC_SIZE);
+
+	if (flags & RX_FLAG_MIC_STRIPPED)
+		skb_trim(msdu, msdu->len -
+			 ath11k_dp_rx_crypto_mic_len(ar, enctype));
+
+	if (flags & RX_FLAG_ICV_STRIPPED)
+		skb_trim(msdu, msdu->len -
+			 ath11k_dp_rx_crypto_icv_len(ar, enctype));
+
+	if (flags & RX_FLAG_IV_STRIPPED) {
+		hdr_len = ieee80211_hdrlen(hdr->frame_control);
+		crypto_len = ath11k_dp_rx_crypto_param_len(ar, enctype);
+
+		memmove((void *)msdu->data + HAL_RX_DESC_SIZE + crypto_len,
+			(void *)msdu->data + HAL_RX_DESC_SIZE, hdr_len);
+		skb_pull(msdu, crypto_len);
+	}
+}
+
+static int ath11k_dp_rx_h_defrag(struct ath11k *ar,
+				 struct ath11k_peer *peer,
+				 struct dp_rx_tid *rx_tid,
+				 struct sk_buff **defrag_skb)
+{
+	struct hal_rx_desc *rx_desc;
+	struct sk_buff *skb, *first_frag, *last_frag;
+	struct ieee80211_hdr *hdr;
 	enum hal_encrypt_type enctype;
-	bool is_decrypted;
-	u32 err_bitmap;
+	bool is_decrypted = false;
+	int msdu_len = 0;
+	int extra_space;
+	u32 flags;
+
+	first_frag = skb_peek(&rx_tid->rx_frags);
+	last_frag = skb_peek_tail(&rx_tid->rx_frags);
+
+	skb_queue_walk(&rx_tid->rx_frags, skb) {
+		flags = 0;
+		rx_desc = (struct hal_rx_desc *)skb->data;
+		hdr = (struct ieee80211_hdr *)(skb->data + HAL_RX_DESC_SIZE);
+
+		enctype = ath11k_dp_rx_h_mpdu_start_enctype(rx_desc);
+		if (enctype != HAL_ENCRYPT_TYPE_OPEN)
+			is_decrypted = ath11k_dp_rx_h_attn_is_decrypted(rx_desc);
+
+		if (is_decrypted) {
+			if (skb != first_frag)
+				flags |=  RX_FLAG_IV_STRIPPED;
+			if (skb != last_frag)
+				flags |= RX_FLAG_ICV_STRIPPED |
+					 RX_FLAG_MIC_STRIPPED;
+		}
 
-	is_decrypted = ath11k_dp_rx_h_attn_is_decrypted(rx_desc);
-	enctype = ath11k_dp_rx_h_mpdu_start_enctype(rx_desc);
-	err_bitmap = ath11k_dp_rx_h_attn_mpdu_err(rx_desc);
+		/* RX fragments are always raw packets */
+		if (skb != last_frag)
+			skb_trim(skb, skb->len - FCS_LEN);
+		ath11k_dp_rx_h_undecap_frag(ar, skb, enctype, flags);
 
-	if (err_bitmap & DP_RX_MPDU_ERR_FCS)
-		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
+		if (skb != first_frag)
+			skb_pull(skb, HAL_RX_DESC_SIZE +
+				      ieee80211_hdrlen(hdr->frame_control));
+		msdu_len += skb->len;
+	}
 
-	if (err_bitmap & DP_RX_MPDU_ERR_TKIP_MIC)
-		rx_status->flag |= RX_FLAG_MMIC_ERROR;
+	extra_space = msdu_len - (DP_RX_BUFFER_SIZE + skb_tailroom(first_frag));
+	if (extra_space > 0 &&
+	    (pskb_expand_head(first_frag, 0, extra_space, GFP_ATOMIC) < 0))
+		return -ENOMEM;
 
-	rx_status->encoding = RX_ENC_LEGACY;
-	rx_status->bw = RATE_INFO_BW_20;
+	__skb_unlink(first_frag, &rx_tid->rx_frags);
+	while ((skb = __skb_dequeue(&rx_tid->rx_frags))) {
+		skb_put_data(first_frag, skb->data, skb->len);
+		dev_kfree_skb_any(skb);
+	}
 
-	rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
+	hdr = (struct ieee80211_hdr *)(first_frag->data + HAL_RX_DESC_SIZE);
+	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_MOREFRAGS);
+	ATH11K_SKB_RXCB(first_frag)->is_frag = 1;
 
-	rx_channel = ath11k_dp_rx_h_msdu_start_freq(rx_desc);
+	if (ath11k_dp_rx_h_verify_tkip_mic(ar, peer, first_frag))
+		first_frag = NULL;
 
-	if (rx_channel >= 1 && rx_channel <= 14) {
-		rx_status->band = NL80211_BAND_2GHZ;
-	} else if (rx_channel >= 36 && rx_channel <= 173) {
-		rx_status->band = NL80211_BAND_5GHZ;
-	} else {
-		ath11k_warn(ar->ab, "Unsupported Channel info received %d\n",
-			    rx_channel);
+	*defrag_skb = first_frag;
+	return 0;
+}
+
+static int ath11k_dp_rx_h_defrag_reo_reinject(struct ath11k *ar, struct dp_rx_tid *rx_tid,
+					      struct sk_buff *defrag_skb)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_pdev_dp *dp = &ar->dp;
+	struct dp_rxdma_ring *rx_refill_ring = &dp->rx_refill_buf_ring;
+	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)defrag_skb->data;
+	struct hal_reo_entrance_ring *reo_ent_ring;
+	struct hal_reo_dest_ring *reo_dest_ring;
+	struct dp_link_desc_bank *link_desc_banks;
+	struct hal_rx_msdu_link *msdu_link;
+	struct hal_rx_msdu_details *msdu0;
+	struct hal_srng *srng;
+	dma_addr_t paddr;
+	u32 desc_bank, msdu_info, mpdu_info;
+	u32 dst_idx, cookie;
+	u32 *msdu_len_offset;
+	int ret, buf_id;
+
+	link_desc_banks = ab->dp.link_desc_banks;
+	reo_dest_ring = rx_tid->dst_ring_desc;
+
+	ath11k_hal_rx_reo_ent_paddr_get(ab, reo_dest_ring, &paddr, &desc_bank);
+	msdu_link = (struct hal_rx_msdu_link *)(link_desc_banks[desc_bank].vaddr +
+			(paddr - link_desc_banks[desc_bank].paddr));
+	msdu0 = &msdu_link->msdu_link[0];
+	dst_idx = FIELD_GET(RX_MSDU_DESC_INFO0_REO_DEST_IND, msdu0->rx_msdu_info.info0);
+	memset(msdu0, 0, sizeof(*msdu0));
+
+	msdu_info = FIELD_PREP(RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU, 1) |
+		    FIELD_PREP(RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU, 1) |
+		    FIELD_PREP(RX_MSDU_DESC_INFO0_MSDU_CONTINUATION, 0) |
+		    FIELD_PREP(RX_MSDU_DESC_INFO0_MSDU_LENGTH,
+			       defrag_skb->len - HAL_RX_DESC_SIZE) |
+		    FIELD_PREP(RX_MSDU_DESC_INFO0_REO_DEST_IND, dst_idx) |
+		    FIELD_PREP(RX_MSDU_DESC_INFO0_VALID_SA, 1) |
+		    FIELD_PREP(RX_MSDU_DESC_INFO0_VALID_DA, 1);
+	msdu0->rx_msdu_info.info0 = msdu_info;
+
+	/* change msdu len in hal rx desc */
+	msdu_len_offset = (u32 *)&rx_desc->msdu_start;
+	*msdu_len_offset &= ~(RX_MSDU_START_INFO1_MSDU_LENGTH);
+	*msdu_len_offset |= defrag_skb->len - HAL_RX_DESC_SIZE;
+
+	paddr = dma_map_single(ab->dev, defrag_skb->data,
+			       defrag_skb->len + skb_tailroom(defrag_skb),
+			       DMA_FROM_DEVICE);
+	if (dma_mapping_error(ab->dev, paddr))
+		return -ENOMEM;
+
+	spin_lock_bh(&rx_refill_ring->idr_lock);
+	buf_id = idr_alloc(&rx_refill_ring->bufs_idr, defrag_skb, 0,
+			   rx_refill_ring->bufs_max * 3, GFP_ATOMIC);
+	spin_unlock_bh(&rx_refill_ring->idr_lock);
+	if (buf_id < 0) {
+		ret = -ENOMEM;
+		goto err_unmap_dma;
+	}
+
+	ATH11K_SKB_RXCB(defrag_skb)->paddr = paddr;
+	cookie = FIELD_PREP(DP_RXDMA_BUF_COOKIE_PDEV_ID, dp->mac_id) |
+		 FIELD_PREP(DP_RXDMA_BUF_COOKIE_BUF_ID, buf_id);
+
+	ath11k_hal_rx_buf_addr_info_set(msdu0, paddr, cookie, HAL_RX_BUF_RBM_SW3_BM);
+
+	/* Fill mpdu details into reo entrace ring */
+	srng = &ab->hal.srng_list[ab->dp.reo_reinject_ring.ring_id];
+
+	spin_lock_bh(&srng->lock);
+	ath11k_hal_srng_access_begin(ab, srng);
+
+	reo_ent_ring = (struct hal_reo_entrance_ring *)
+			ath11k_hal_srng_src_get_next_entry(ab, srng);
+	if (!reo_ent_ring) {
+		ath11k_hal_srng_access_end(ab, srng);
+		spin_unlock_bh(&srng->lock);
+		ret = -ENOSPC;
+		goto err_free_idr;
+	}
+	memset(reo_ent_ring, 0, sizeof(*reo_ent_ring));
+
+	ath11k_hal_rx_reo_ent_paddr_get(ab, reo_dest_ring, &paddr, &desc_bank);
+	ath11k_hal_rx_buf_addr_info_set(reo_ent_ring, paddr, desc_bank,
+					HAL_RX_BUF_RBM_WBM_IDLE_DESC_LIST);
+
+	mpdu_info = FIELD_PREP(RX_MPDU_DESC_INFO0_MSDU_COUNT, 1) |
+		    FIELD_PREP(RX_MPDU_DESC_INFO0_SEQ_NUM, rx_tid->cur_sn) |
+		    FIELD_PREP(RX_MPDU_DESC_INFO0_FRAG_FLAG, 0) |
+		    FIELD_PREP(RX_MPDU_DESC_INFO0_VALID_SA, 1) |
+		    FIELD_PREP(RX_MPDU_DESC_INFO0_VALID_DA, 1) |
+		    FIELD_PREP(RX_MPDU_DESC_INFO0_RAW_MPDU, 1) |
+		    FIELD_PREP(RX_MPDU_DESC_INFO0_VALID_PN, 1);
+
+	reo_ent_ring->rx_mpdu_info.info0 = mpdu_info;
+	reo_ent_ring->rx_mpdu_info.meta_data = reo_dest_ring->rx_mpdu_info.meta_data;
+	reo_ent_ring->queue_addr_lo = reo_dest_ring->queue_addr_lo;
+	reo_ent_ring->info0 = FIELD_PREP(HAL_REO_ENTR_RING_INFO0_QUEUE_ADDR_HI,
+					 FIELD_GET(HAL_REO_DEST_RING_INFO0_QUEUE_ADDR_HI,
+						   reo_dest_ring->info0)) |
+			      FIELD_PREP(HAL_REO_ENTR_RING_INFO0_DEST_IND, dst_idx);
+	ath11k_hal_srng_access_end(ab, srng);
+	spin_unlock_bh(&srng->lock);
+
+	return 0;
+
+err_free_idr:
+	spin_lock_bh(&rx_refill_ring->idr_lock);
+	idr_remove(&rx_refill_ring->bufs_idr, buf_id);
+	spin_unlock_bh(&rx_refill_ring->idr_lock);
+err_unmap_dma:
+	dma_unmap_single(ab->dev, paddr, defrag_skb->len + skb_tailroom(defrag_skb),
+			 DMA_FROM_DEVICE);
+	return ret;
+}
+
+static int ath11k_dp_rx_h_cmp_frags(struct sk_buff *a, struct sk_buff *b)
+{
+	int frag1, frag2;
+
+	frag1 = ath11k_dp_rx_h_mpdu_start_frag_no(a);
+	frag2 = ath11k_dp_rx_h_mpdu_start_frag_no(b);
+
+	return frag1 - frag2;
+}
+
+static void ath11k_dp_rx_h_sort_frags(struct sk_buff_head *frag_list,
+				      struct sk_buff *cur_frag)
+{
+	struct sk_buff *skb;
+	int cmp;
+
+	skb_queue_walk(frag_list, skb) {
+		cmp = ath11k_dp_rx_h_cmp_frags(skb, cur_frag);
+		if (cmp < 0)
+			continue;
+		__skb_queue_before(frag_list, skb, cur_frag);
 		return;
 	}
+	__skb_queue_tail(frag_list, cur_frag);
+}
 
-	rx_status->freq = ieee80211_channel_to_frequency(rx_channel,
-							 rx_status->band);
-	ath11k_dp_rx_h_rate(ar, rx_desc, rx_status);
+static u64 ath11k_dp_rx_h_get_pn(struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr;
+	u64 pn = 0;
+	u8 *ehdr;
 
-	/* Rx fragments are received in raw mode */
-	skb_trim(msdu, msdu->len - FCS_LEN);
+	hdr = (struct ieee80211_hdr *)(skb->data + HAL_RX_DESC_SIZE);
+	ehdr = skb->data + HAL_RX_DESC_SIZE + ieee80211_hdrlen(hdr->frame_control);
 
-	if (is_decrypted) {
-		rx_status->flag |= RX_FLAG_DECRYPTED | RX_FLAG_MIC_STRIPPED;
-		skb_trim(msdu, msdu->len -
-			 ath11k_dp_rx_crypto_mic_len(ar, enctype));
+	pn = ehdr[0];
+	pn |= (u64)ehdr[1] << 8;
+	pn |= (u64)ehdr[4] << 16;
+	pn |= (u64)ehdr[5] << 24;
+	pn |= (u64)ehdr[6] << 32;
+	pn |= (u64)ehdr[7] << 40;
+
+	return pn;
+}
+
+static bool
+ath11k_dp_rx_h_defrag_validate_incr_pn(struct ath11k *ar, struct dp_rx_tid *rx_tid)
+{
+	enum hal_encrypt_type encrypt_type;
+	struct sk_buff *first_frag, *skb;
+	struct hal_rx_desc *desc;
+	u64 last_pn;
+	u64 cur_pn;
+
+	first_frag = skb_peek(&rx_tid->rx_frags);
+	desc = (struct hal_rx_desc *)first_frag->data;
+
+	encrypt_type = ath11k_dp_rx_h_mpdu_start_enctype(desc);
+	if (encrypt_type != HAL_ENCRYPT_TYPE_CCMP_128 &&
+	    encrypt_type != HAL_ENCRYPT_TYPE_CCMP_256 &&
+	    encrypt_type != HAL_ENCRYPT_TYPE_GCMP_128 &&
+	    encrypt_type != HAL_ENCRYPT_TYPE_AES_GCMP_256)
+		return true;
+
+	last_pn = ath11k_dp_rx_h_get_pn(first_frag);
+	skb_queue_walk(&rx_tid->rx_frags, skb) {
+		if (skb == first_frag)
+			continue;
+
+		cur_pn = ath11k_dp_rx_h_get_pn(skb);
+		if (cur_pn != last_pn + 1)
+			return false;
+		last_pn = cur_pn;
 	}
+	return true;
+}
+
+static int ath11k_dp_rx_frag_h_mpdu(struct ath11k *ar,
+				    struct sk_buff *msdu,
+				    u32 *ring_desc)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct hal_rx_desc *rx_desc;
+	struct ath11k_peer *peer;
+	struct dp_rx_tid *rx_tid;
+	struct sk_buff *defrag_skb = NULL;
+	u32 peer_id;
+	u16 seqno, frag_no;
+	u8 tid;
+	int ret = 0;
+	bool more_frags;
+
+	rx_desc = (struct hal_rx_desc *)msdu->data;
+	peer_id = ath11k_dp_rx_h_mpdu_start_peer_id(rx_desc);
+	tid = ath11k_dp_rx_h_mpdu_start_tid(rx_desc);
+	seqno = ath11k_dp_rx_h_mpdu_start_seq_no(rx_desc);
+	frag_no = ath11k_dp_rx_h_mpdu_start_frag_no(msdu);
+	more_frags = ath11k_dp_rx_h_mpdu_start_more_frags(msdu);
+
+	if (!ath11k_dp_rx_h_mpdu_start_seq_ctrl_valid(rx_desc) ||
+	    !ath11k_dp_rx_h_mpdu_start_fc_valid(rx_desc) ||
+	    tid > IEEE80211_NUM_TIDS)
+		return -EINVAL;
+
+	/* received unfragmented packet in reo
+	 * exception ring, this shouldn't happen
+	 * as these packets typically come from
+	 * reo2sw srngs.
+	 */
+	if (WARN_ON_ONCE(!frag_no && !more_frags))
+		return -EINVAL;
+
+	spin_lock_bh(&ab->base_lock);
+	peer = ath11k_peer_find_by_id(ab, peer_id);
+	if (!peer) {
+		ath11k_warn(ab, "failed to find the peer to de-fragment received fragment peer_id %d\n",
+			    peer_id);
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+	rx_tid = &peer->rx_tid[tid];
+
+	if ((!skb_queue_empty(&rx_tid->rx_frags) && seqno != rx_tid->cur_sn) ||
+	    skb_queue_empty(&rx_tid->rx_frags)) {
+		/* Flush stored fragments and start a new sequence */
+		ath11k_dp_rx_frags_cleanup(rx_tid, true);
+		rx_tid->cur_sn = seqno;
+	}
+
+	if (rx_tid->rx_frag_bitmap & BIT(frag_no)) {
+		/* Fragment already present */
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (frag_no > __fls(rx_tid->rx_frag_bitmap))
+		__skb_queue_tail(&rx_tid->rx_frags, msdu);
+	else
+		ath11k_dp_rx_h_sort_frags(&rx_tid->rx_frags, msdu);
+
+	rx_tid->rx_frag_bitmap |= BIT(frag_no);
+	if (!more_frags)
+		rx_tid->last_frag_no = frag_no;
+
+	if (frag_no == 0) {
+		rx_tid->dst_ring_desc = kmemdup(ring_desc,
+						sizeof(*rx_tid->dst_ring_desc),
+						GFP_ATOMIC);
+		if (!rx_tid->dst_ring_desc) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
+	} else {
+		ath11k_dp_rx_link_desc_return(ab, ring_desc,
+					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+	}
+
+	if (!rx_tid->last_frag_no ||
+	    rx_tid->rx_frag_bitmap != GENMASK(rx_tid->last_frag_no, 0)) {
+		mod_timer(&rx_tid->frag_timer, jiffies +
+					       ATH11K_DP_RX_FRAGMENT_TIMEOUT_MS);
+		goto out_unlock;
+	}
+
+	spin_unlock_bh(&ab->base_lock);
+	del_timer_sync(&rx_tid->frag_timer);
+	spin_lock_bh(&ab->base_lock);
+
+	peer = ath11k_peer_find_by_id(ab, peer_id);
+	if (!peer)
+		goto err_frags_cleanup;
+
+	if (!ath11k_dp_rx_h_defrag_validate_incr_pn(ar, rx_tid))
+		goto err_frags_cleanup;
+
+	if (ath11k_dp_rx_h_defrag(ar, peer, rx_tid, &defrag_skb))
+		goto err_frags_cleanup;
+
+	if (!defrag_skb)
+		goto err_frags_cleanup;
+
+	if (ath11k_dp_rx_h_defrag_reo_reinject(ar, rx_tid, defrag_skb))
+		goto err_frags_cleanup;
+
+	ath11k_dp_rx_frags_cleanup(rx_tid, false);
+	goto out_unlock;
+
+err_frags_cleanup:
+	dev_kfree_skb_any(defrag_skb);
+	ath11k_dp_rx_frags_cleanup(rx_tid, true);
+out_unlock:
+	spin_unlock_bh(&ab->base_lock);
+	return ret;
 }
 
 static int
-ath11k_dp_process_rx_err_buf(struct ath11k *ar, struct napi_struct *napi,
-			     int buf_id, bool frag)
+ath11k_dp_process_rx_err_buf(struct ath11k *ar, u32 *ring_desc, int buf_id, bool drop)
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
 	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
-	struct ieee80211_rx_status rx_status = {0};
 	struct sk_buff *msdu;
 	struct ath11k_skb_rxcb *rxcb;
-	struct ieee80211_rx_status *status;
 	struct hal_rx_desc *rx_desc;
 	u16 msdu_len;
 
@@ -2781,10 +3358,7 @@ ath11k_dp_process_rx_err_buf(struct ath11k *ar, struct napi_struct *napi,
 			 msdu->len + skb_tailroom(msdu),
 			 DMA_FROM_DEVICE);
 
-	if (!frag) {
-		/* Process only rx fragments below, and drop
-		 * msdu's indicated due to error reasons.
-		 */
+	if (drop) {
 		dev_kfree_skb_any(msdu);
 		return 0;
 	}
@@ -2803,16 +3377,12 @@ ath11k_dp_process_rx_err_buf(struct ath11k *ar, struct napi_struct *napi,
 	rx_desc = (struct hal_rx_desc *)msdu->data;
 	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(rx_desc);
 	skb_put(msdu, HAL_RX_DESC_SIZE + msdu_len);
-	skb_pull(msdu, HAL_RX_DESC_SIZE);
-
-	ath11k_dp_rx_frag_h_mpdu(ar, msdu, rx_desc, &rx_status);
-
-	status = IEEE80211_SKB_RXCB(msdu);
-
-	*status = rx_status;
-
-	ath11k_dp_rx_deliver_msdu(ar, napi, msdu);
 
+	if (ath11k_dp_rx_frag_h_mpdu(ar, msdu, ring_desc)) {
+		dev_kfree_skb_any(msdu);
+		ath11k_dp_rx_link_desc_return(ar->ab, ring_desc,
+					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+	}
 exit:
 	rcu_read_unlock();
 	return 0;
@@ -2837,6 +3407,7 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
 	dma_addr_t paddr;
 	u32 *desc;
 	bool is_frag;
+	u8 drop = 0;
 
 	tot_n_bufs_reaped = 0;
 	quota = budget;
@@ -2878,9 +3449,15 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
 
 		is_frag = !!(reo_desc->rx_mpdu_info.info0 & RX_MPDU_DESC_INFO0_FRAG_FLAG);
 
-		/* Return the link desc back to wbm idle list */
-		ath11k_dp_rx_link_desc_return(ab, desc,
-					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+		/* Process only rx fragments with one msdu per link desc below, and drop
+		 * msdu's indicated due to error reasons.
+		 */
+		if (!is_frag || num_msdus > 1) {
+			drop = 1;
+			/* Return the link desc back to wbm idle list */
+			ath11k_dp_rx_link_desc_return(ab, desc,
+						      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+		}
 
 		for (i = 0; i < num_msdus; i++) {
 			buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID,
@@ -2891,8 +3468,7 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
 
 			ar = ab->pdevs[mac_id].ar;
 
-			if (!ath11k_dp_process_rx_err_buf(ar, napi, buf_id,
-							  is_frag)) {
+			if (!ath11k_dp_process_rx_err_buf(ar, desc, buf_id, drop)) {
 				n_bufs_reaped[mac_id]++;
 				tot_n_bufs_reaped++;
 			}
@@ -2961,7 +3537,7 @@ static int ath11k_dp_rx_h_null_q_desc(struct ath11k *ar, struct sk_buff *msdu,
 
 	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(desc);
 
-	if ((msdu_len + HAL_RX_DESC_SIZE) > DP_RX_BUFFER_SIZE) {
+	if (!rxcb->is_frag && ((msdu_len + HAL_RX_DESC_SIZE) > DP_RX_BUFFER_SIZE)) {
 		/* First buffer will be freed by the caller, so deduct it's length */
 		msdu_len = msdu_len - (DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE);
 		ath11k_dp_rx_null_q_desc_sg_drop(ar, msdu_len, msdu_list);
@@ -2989,14 +3565,17 @@ static int ath11k_dp_rx_h_null_q_desc(struct ath11k *ar, struct sk_buff *msdu,
 	rxcb->is_first_msdu = ath11k_dp_rx_h_msdu_end_first_msdu(desc);
 	rxcb->is_last_msdu = ath11k_dp_rx_h_msdu_end_last_msdu(desc);
 
-	l3pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(desc);
-
-	if ((HAL_RX_DESC_SIZE + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE)
-		return -EINVAL;
+	if (rxcb->is_frag) {
+		skb_pull(msdu, HAL_RX_DESC_SIZE);
+	} else {
+		l3pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(desc);
 
-	skb_put(msdu, HAL_RX_DESC_SIZE + l3pad_bytes + msdu_len);
-	skb_pull(msdu, HAL_RX_DESC_SIZE + l3pad_bytes);
+		if ((HAL_RX_DESC_SIZE + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE)
+			return -EINVAL;
 
+		skb_put(msdu, HAL_RX_DESC_SIZE + l3pad_bytes + msdu_len);
+		skb_pull(msdu, HAL_RX_DESC_SIZE + l3pad_bytes);
+	}
 	ath11k_dp_rx_h_ppdu(ar, desc, status);
 
 	__skb_queue_tail(&amsdu_list, msdu);
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
index 1b08b7d..c3f3ccd 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.h
@@ -84,5 +84,6 @@ int ath11k_dp_rx_mon_status_bufs_replenish(struct ath11k_base *ab, int mac_id,
 					   gfp_t gfp);
 int ath11k_dp_rx_pdev_mon_detach(struct ath11k *ar);
 int ath11k_dp_rx_pdev_mon_attach(struct ath11k *ar);
+int ath11k_peer_rx_frag_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id);
 
 #endif /* ATH11K_DP_RX_H */
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e28f5a3..2b90975 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2384,11 +2384,19 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	spin_lock_bh(&ab->base_lock);
 	peer = ath11k_peer_find(ab, arvif->vdev_id, peer_addr);
-	if (peer && cmd == SET_KEY)
+	if (peer && cmd == SET_KEY) {
 		peer->keys[key->keyidx] = key;
-	else if (peer && cmd == DISABLE_KEY)
+		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
+			peer->ucast_keyidx = key->keyidx;
+		else
+			peer->mcast_keyidx = key->keyidx;
+	} else if (peer && cmd == DISABLE_KEY) {
 		peer->keys[key->keyidx] = NULL;
-	else if (!peer)
+		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
+			peer->ucast_keyidx = 0;
+		else
+			peer->mcast_keyidx = 0;
+	} else if (!peer)
 		/* impossible unless FW goes crazy */
 		ath11k_warn(ab, "peer %pM disappeared!\n", peer_addr);
 	spin_unlock_bh(&ab->base_lock);
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index 9a40d1f6..55d9919 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -17,6 +17,13 @@ struct ath11k_peer {
 	/* protected by ab->data_lock */
 	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1];
 	struct dp_rx_tid rx_tid[IEEE80211_NUM_TIDS + 1];
+
+	/* Info used in MMIC verification of
+	 * RX fragments
+	 */
+	struct crypto_shash *tfm_mmic;
+	u8 mcast_keyidx;
+	u8 ucast_keyidx;
 };
 
 void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id);
diff --git a/drivers/net/wireless/ath/ath11k/rx_desc.h b/drivers/net/wireless/ath/ath11k/rx_desc.h
index 4d586fd..1c42646 100644
--- a/drivers/net/wireless/ath/ath11k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath11k/rx_desc.h
@@ -342,7 +342,7 @@ struct rx_attention {
 #define RX_MPDU_START_INFO0_PROTO_VER_ERR	BIT(12)
 #define RX_MPDU_START_INFO0_AST_LOOKUP_VALID	BIT(13)
 
-#define RX_MPDU_START_INFO1_MPDU_CTRL_VALID	BIT(0)
+#define RX_MPDU_START_INFO1_MPDU_FCTRL_VALID	BIT(0)
 #define RX_MPDU_START_INFO1_MPDU_DUR_VALID	BIT(1)
 #define RX_MPDU_START_INFO1_MAC_ADDR1_VALID	BIT(2)
 #define RX_MPDU_START_INFO1_MAC_ADDR2_VALID	BIT(3)
-- 
2.7.4
