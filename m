Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D8E1F4C5C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 06:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgFJEc1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 00:32:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30576 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgFJEcZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 00:32:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591763544; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=gU57Oxv5z3IsJkf7hj5VAMNODMMGU8iaY76wmulOI/o=; b=bJT+ZK9ZywrfwYvII5n2nuMRNxd2/+BW1bYob2kxSsHK5lf422+Ty0nyZ1QxgxhPbhr1XTqZ
 4Tgl+beWp3tivvlovpIjO5rM4NOCCkBdRn9TM/g1fmtQMYcqtK0l9MPTNV+lflzmeQMtIVpM
 x629QL2EKQuqa3B6WW38Kzd+LrM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ee062503a8a8b20b8272f5b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Jun 2020 04:32:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39CB0C43387; Wed, 10 Jun 2020 04:32:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from checstp253621-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 432D4C433CA;
        Wed, 10 Jun 2020 04:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 432D4C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc:     Sriram R <srirrama@codeaurora.org>,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Subject: [PATCH 2/2] ath11k: add rx path 802.11 decapsulation offloading support
Date:   Wed, 10 Jun 2020 10:00:56 +0530
Message-Id: <1591763456-23275-3-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591763456-23275-1-git-send-email-srirrama@codeaurora.org>
References: <1591763456-23275-1-git-send-email-srirrama@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adding 802.11 decapsulation offloading support to the driver.
Since the packets delivered to the driver are in 802.3 format, these
can be sent to the network core with minimal processing in mac80211.
This helps in releasing some CPU cycles in the host processor and
thereby improving the performance.

Ethernet decap can be enabled by using a modparam as shown below:
insmod ath11k frame_mode=2

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01213-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h     |   3 +
 drivers/net/wireless/ath/ath11k/dp_rx.c    | 185 +++++++++++++++++------------
 drivers/net/wireless/ath/ath11k/hal_desc.h |   2 +
 drivers/net/wireless/ath/ath11k/mac.c      |  20 ++++
 4 files changed, 136 insertions(+), 74 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index e04f0e7..f9e0f30 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -77,6 +77,7 @@ struct ath11k_skb_rxcb {
 	bool is_first_msdu;
 	bool is_last_msdu;
 	bool is_continuation;
+	bool is_mcbc;
 	struct hal_rx_desc *rx_desc;
 	u8 err_rel_src;
 	u8 err_code;
@@ -84,6 +85,8 @@ struct ath11k_skb_rxcb {
 	u8 unmapped;
 	u8 is_frag;
 	u8 tid;
+	u16 peer_id;
+	u16 seq_no;
 };
 
 enum ath11k_hw_rev {
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index a54610d..d5cf15c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -260,6 +260,13 @@ static u32 ath11k_dp_rxdesc_get_ppduid(struct hal_rx_desc *rx_desc)
 	return __le16_to_cpu(rx_desc->mpdu_start.phy_ppdu_id);
 }
 
+static bool ath11k_dp_rx_h_attn_is_mcbc(struct hal_rx_desc *desc)
+{
+	return ath11k_dp_rx_h_msdu_end_first_msdu(desc) &&
+		(!!FIELD_GET(RX_ATTENTION_INFO1_MCAST_BCAST,
+			     __le32_to_cpu(desc->attention.info1)));
+}
+
 /* Returns number of Rx buffers replenished */
 int ath11k_dp_rxbufs_replenish(struct ath11k_base *ab, int mac_id,
 			       struct dp_rxdma_ring *rx_ring,
@@ -2012,9 +2019,15 @@ static void ath11k_dp_rx_h_undecap(struct ath11k *ar, struct sk_buff *msdu,
 					   decrypted);
 		break;
 	case DP_RX_DECAP_TYPE_ETHERNET2_DIX:
-		/* TODO undecap support for middle/last msdu's of amsdu */
-		ath11k_dp_rx_h_undecap_eth(ar, msdu, first_hdr,
-					   enctype, status);
+		/* PN for mcast packets will be validated in mac80211;
+		 * remove eth header and add 802.11 header.
+		 */
+		if (ATH11K_SKB_RXCB(msdu)->is_mcbc) {
+			status->flag |= RX_FLAG_80211_MCAST;
+			if (decrypted)
+				ath11k_dp_rx_h_undecap_eth(ar, msdu, first_hdr,
+							   enctype, status);
+		}
 		break;
 	case DP_RX_DECAP_TYPE_8023:
 		/* TODO: Handle undecap for these formats */
@@ -2022,39 +2035,65 @@ static void ath11k_dp_rx_h_undecap(struct ath11k *ar, struct sk_buff *msdu,
 	}
 }
 
+static struct ath11k_peer *
+ath11k_dp_rx_h_find_peer(struct ath11k_base *ab, struct sk_buff *msdu)
+{
+	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
+	struct hal_rx_desc *rx_desc = rxcb->rx_desc;
+	struct ath11k_peer *peer = NULL;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	if (rxcb->peer_id)
+		peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
+	if (peer)
+		return peer;
+
+	if (!rx_desc ||
+	    !(rx_desc->mpdu_start.info1 & RX_MPDU_START_INFO1_MAC_ADDR2_VALID))
+		return NULL;
+
+	peer = ath11k_peer_find_by_addr(ab, rx_desc->mpdu_start.addr2);
+
+	return peer;
+}
+
 static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 				struct sk_buff *msdu,
 				struct hal_rx_desc *rx_desc,
 				struct ieee80211_rx_status *rx_status)
 {
-	bool  fill_crypto_hdr, mcast;
+	bool fill_crypto_hdr;
 	enum hal_encrypt_type enctype;
 	bool is_decrypted = false;
+	struct ath11k_skb_rxcb *rxcb;
 	struct ieee80211_hdr *hdr;
 	struct ath11k_peer *peer;
 	u32 err_bitmap;
 
-	hdr = (struct ieee80211_hdr *)msdu->data;
-
 	/* PN for multicast packets will be checked in mac80211 */
+	rxcb = ATH11K_SKB_RXCB(msdu);
+	rxcb->is_mcbc = ath11k_dp_rx_h_attn_is_mcbc(rx_desc);
+	fill_crypto_hdr = rxcb->is_mcbc;
 
-	mcast = is_multicast_ether_addr(hdr->addr1);
-	fill_crypto_hdr = mcast;
-
-	is_decrypted = ath11k_dp_rx_h_attn_is_decrypted(rx_desc);
+	if (rxcb->is_mcbc) {
+		rxcb->peer_id = ath11k_dp_rx_h_mpdu_start_peer_id(rx_desc);
+		rxcb->seq_no = ath11k_dp_rx_h_mpdu_start_seq_no(rx_desc);
+	}
 
 	spin_lock_bh(&ar->ab->base_lock);
-	peer = ath11k_peer_find_by_addr(ar->ab, hdr->addr2);
+	peer = ath11k_dp_rx_h_find_peer(ar->ab, msdu);
 	if (peer) {
-		if (mcast)
+		if (rxcb->is_mcbc)
 			enctype = peer->sec_type_grp;
 		else
 			enctype = peer->sec_type;
 	} else {
-		enctype = HAL_ENCRYPT_TYPE_OPEN;
+		enctype = ath11k_dp_rx_h_mpdu_start_enctype(rx_desc);
 	}
 	spin_unlock_bh(&ar->ab->base_lock);
 
+	is_decrypted = ath11k_dp_rx_h_attn_is_decrypted(rx_desc);
 	err_bitmap = ath11k_dp_rx_h_attn_mpdu_err(rx_desc);
 
 	/* Clear per-MPDU flags while leaving per-PPDU flags intact */
@@ -2087,8 +2126,11 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 	if (!is_decrypted || fill_crypto_hdr)
 		return;
 
-	hdr = (void *)msdu->data;
-	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+	if (ath11k_dp_rx_h_msdu_start_decap_type(rx_desc) !=
+	    DP_RX_DECAP_TYPE_ETHERNET2_DIX) {
+		hdr = (void *)msdu->data;
+		hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+	}
 }
 
 static void ath11k_dp_rx_h_rate(struct ath11k *ar, struct hal_rx_desc *rx_desc,
@@ -2193,51 +2235,48 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 	ath11k_dp_rx_h_rate(ar, rx_desc, rx_status);
 }
 
-static char *ath11k_print_get_tid(struct ieee80211_hdr *hdr, char *out,
-				  size_t size)
-{
-	u8 *qc;
-	int tid;
-
-	if (!ieee80211_is_data_qos(hdr->frame_control))
-		return "";
-
-	qc = ieee80211_get_qos_ctl(hdr);
-	tid = *qc & IEEE80211_QOS_CTL_TID_MASK;
-	snprintf(out, size, "tid %d", tid);
-
-	return out;
-}
-
 static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *napi,
-				      struct sk_buff *msdu)
+				      struct sk_buff *msdu,
+				      struct ieee80211_rx_status *status)
 {
 	static const struct ieee80211_radiotap_he known = {
-		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
-				     IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN),
+		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN),
 		.data2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN),
 	};
-	struct ieee80211_rx_status *status;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)msdu->data;
+	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_radiotap_he *he = NULL;
-	char tid[32];
+	struct ieee80211_sta *pubsta = NULL;
+	struct ath11k_peer *peer;
+	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
+	bool is_mcbc = rxcb->is_mcbc;
+	u8 decap;
 
-	status = IEEE80211_SKB_RXCB(msdu);
-	if (status->encoding == RX_ENC_HE) {
+	if (status->encoding == RX_ENC_HE && status->flag & RX_FLAG_ONLY_MONITOR) {
 		he = skb_push(msdu, sizeof(known));
 		memcpy(he, &known, sizeof(known));
 		status->flag |= RX_FLAG_RADIOTAP_HE;
 	}
 
+	if (!(status->flag & RX_FLAG_ONLY_MONITOR))
+		decap = ath11k_dp_rx_h_msdu_start_decap_type(rxcb->rx_desc);
+	else
+		decap = DP_RX_DECAP_TYPE_RAW;
+
+	spin_lock_bh(&ar->ab->base_lock);
+	peer = ath11k_dp_rx_h_find_peer(ar->ab, msdu);
+	if (peer && peer->sta)
+		pubsta = peer->sta;
+	spin_unlock_bh(&ar->ab->base_lock);
+
 	ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
-		   "rx skb %pK len %u peer %pM %s %s sn %u %s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
+		   "rx skb %pK len %u peer %pM tid %u %s sn %u %s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
 		   msdu,
 		   msdu->len,
-		   ieee80211_get_SA(hdr),
-		   ath11k_print_get_tid(hdr, tid, sizeof(tid)),
-		   is_multicast_ether_addr(ieee80211_get_DA(hdr)) ?
-							"mcast" : "ucast",
-		   (__le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4,
+		   peer ? peer->addr : NULL,
+		   rxcb->tid,
+		   (rxcb->rx_desc->msdu_end.info2 &
+			RX_MSDU_END_INFO2_DA_IS_MCBC) ? "mcast" : "ucast",
+		   rxcb->seq_no,
 		   (status->encoding == RX_ENC_LEGACY) ? "legacy" : "",
 		   (status->encoding == RX_ENC_HT) ? "ht" : "",
 		   (status->encoding == RX_ENC_VHT) ? "vht" : "",
@@ -2254,20 +2293,28 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 		   !!(status->flag & RX_FLAG_MMIC_ERROR),
 		   !!(status->flag & RX_FLAG_AMSDU_MORE));
 
+	rx_status = IEEE80211_SKB_RXCB(msdu);
+	*rx_status = *status;
+
 	/* TODO: trace rx packet */
 
-	ieee80211_rx_napi(ar->hw, NULL, msdu, napi);
+	/* PN for multicast packets are validated in mac80211,
+	 * so send them through ieee80211_rx_napi().
+	 */
+	if (decap != DP_RX_DECAP_TYPE_ETHERNET2_DIX ||
+	    (is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
+		ieee80211_rx_napi(ar->hw, pubsta, msdu, napi);
+	else
+		ieee80211_rx_8023(ar->hw, pubsta, msdu, napi);
 }
 
 static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 				     struct sk_buff *msdu,
-				     struct sk_buff_head *msdu_list)
+				     struct sk_buff_head *msdu_list,
+				     struct ieee80211_rx_status *rx_status)
 {
 	struct hal_rx_desc *rx_desc, *lrx_desc;
-	struct ieee80211_rx_status rx_status = {0};
-	struct ieee80211_rx_status *status;
 	struct ath11k_skb_rxcb *rxcb;
-	struct ieee80211_hdr *hdr;
 	struct sk_buff *last_buf;
 	u8 l3_pad_bytes;
 	u8 *hdr_status;
@@ -2321,19 +2368,11 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 		}
 	}
 
-	hdr = (struct ieee80211_hdr *)msdu->data;
-
-	/* Process only data frames */
-	if (!ieee80211_is_data(hdr->frame_control))
-		return -EINVAL;
+	ath11k_dp_rx_h_ppdu(ar, rx_desc, rx_status);
+	ath11k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_status);
 
-	ath11k_dp_rx_h_ppdu(ar, rx_desc, &rx_status);
-	ath11k_dp_rx_h_mpdu(ar, msdu, rx_desc, &rx_status);
+	rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
 
-	rx_status.flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
-
-	status = IEEE80211_SKB_RXCB(msdu);
-	*status = rx_status;
 	return 0;
 
 free_out:
@@ -2348,6 +2387,7 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 	struct ath11k_skb_rxcb *rxcb;
 	struct sk_buff *msdu;
 	struct ath11k *ar;
+	struct ieee80211_rx_status rx_status = {0};
 	u8 mac_id;
 	int ret;
 
@@ -2370,7 +2410,7 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 			continue;
 		}
 
-		ret = ath11k_dp_rx_process_msdu(ar, msdu, msdu_list);
+		ret = ath11k_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_status);
 		if (ret) {
 			ath11k_dbg(ab, ATH11K_DBG_DATA,
 				   "Unable to process msdu %d", ret);
@@ -2378,7 +2418,7 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 			continue;
 		}
 
-		ath11k_dp_rx_deliver_msdu(ar, napi, msdu);
+		ath11k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_status);
 		(*quota)--;
 	}
 
@@ -2460,9 +2500,13 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 					RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU);
 		rxcb->is_continuation = !!(desc.rx_msdu_info.info0 &
 					   RX_MSDU_DESC_INFO0_MSDU_CONTINUATION);
-		rxcb->mac_id = mac_id;
+		rxcb->peer_id = FIELD_GET(RX_MPDU_DESC_META_DATA_PEER_ID,
+					  desc.rx_mpdu_info.meta_data);
+		rxcb->seq_no = FIELD_GET(RX_MPDU_DESC_INFO0_SEQ_NUM,
+					 desc.rx_mpdu_info.info0);
 		rxcb->tid = FIELD_GET(HAL_REO_DEST_RING_INFO0_RX_QUEUE_NUM,
 				      desc.info0);
+		rxcb->mac_id = mac_id;
 
 		__skb_queue_tail(&msdu_list, msdu);
 
@@ -3749,7 +3793,6 @@ static void ath11k_dp_rx_wbm_err(struct ath11k *ar,
 {
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
 	struct ieee80211_rx_status rxs = {0};
-	struct ieee80211_rx_status *status;
 	bool drop = true;
 
 	switch (rxcb->err_rel_src) {
@@ -3769,10 +3812,7 @@ static void ath11k_dp_rx_wbm_err(struct ath11k *ar,
 		return;
 	}
 
-	status = IEEE80211_SKB_RXCB(msdu);
-	*status = rxs;
-
-	ath11k_dp_rx_deliver_msdu(ar, napi, msdu);
+	ath11k_dp_rx_deliver_msdu(ar, napi, msdu, &rxs);
 }
 
 int ath11k_dp_rx_process_wbm_err(struct ath11k_base *ab,
@@ -4599,7 +4639,7 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
 	struct sk_buff *mon_skb, *skb_next, *header;
-	struct ieee80211_rx_status *rxs = &dp->rx_status, *status;
+	struct ieee80211_rx_status *rxs = &dp->rx_status;
 
 	mon_skb = ath11k_dp_rx_mon_merg_msdus(ar, mac_id, head_msdu,
 					      tail_msdu, rxs);
@@ -4625,10 +4665,7 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 		}
 		rxs->flag |= RX_FLAG_ONLY_MONITOR;
 
-		status = IEEE80211_SKB_RXCB(mon_skb);
-		*status = *rxs;
-
-		ath11k_dp_rx_deliver_msdu(ar, napi, mon_skb);
+		ath11k_dp_rx_deliver_msdu(ar, napi, mon_skb, rxs);
 		mon_skb = skb_next;
 	} while (mon_skb);
 	rxs->flag = 0;
diff --git a/drivers/net/wireless/ath/ath11k/hal_desc.h b/drivers/net/wireless/ath/ath11k/hal_desc.h
index 8a59281..a47c288 100644
--- a/drivers/net/wireless/ath/ath11k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath11k/hal_desc.h
@@ -496,6 +496,8 @@ struct hal_tlv_hdr {
 #define RX_MPDU_DESC_INFO0_DA_IDX_TIMEOUT	BIT(29)
 #define RX_MPDU_DESC_INFO0_RAW_MPDU		BIT(30)
 
+#define RX_MPDU_DESC_META_DATA_PEER_ID		GENMASK(15, 0)
+
 struct rx_mpdu_desc {
 	u32 info0; /* %RX_MPDU_DESC_INFO */
 	u32 meta_data;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2836a0f..de6c132 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4278,6 +4278,26 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 		goto err_vdev_del;
 	}
 
+	/* Do not enable ethernet mode for mesh vifs, packets in mesh network
+	 * can be forwarded to other mesh nodes and mac80211 expects the packet
+	 * in 802.11 format. Also, please note that ethernet mode shall not be
+	 * used on interface where 4addr mode is enabled as we might not have
+	 * 4addr related config during add_interface().
+	 */
+	if (ath11k_frame_mode == ATH11K_HW_TXRX_ETHERNET &&
+	    vif->type != NL80211_IFTYPE_MESH_POINT) {
+		param_id = WMI_VDEV_PARAM_RX_DECAP_TYPE;
+		param_value = ATH11K_HW_TXRX_ETHERNET;
+
+		ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+						    param_id, param_value);
+		if (ret) {
+			ath11k_warn(ab, "failed to set vdev %d tx encap mode: %d\n",
+				    arvif->vdev_id, ret);
+			goto err_vdev_del;
+		}
+	}
+
 	nss = get_num_chains(ar->cfg_tx_chainmask) ? : 1;
 	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 					    WMI_VDEV_PARAM_NSS, nss);
-- 
2.7.4

