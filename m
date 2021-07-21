Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B844F3D1849
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 22:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhGUUCE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 16:02:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56240 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhGUUCC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 16:02:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626900158; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=dOpbjWX75vcH6GHTDr/3tHY6iueQn45Aq4Zx3YlKKYY=; b=lPghijj7njN9qzZBZW8VVtBDcE5coWNAgT9inG1YruLXCGYSZ+a2WTLq9960vdBsoO2o+4il
 hCE6OzYF0I6tUfbwx2ivCz/MnTcsLx1XI5xmaRejVWjVc37usZcMx2xR5yZEc5sleILdweNE
 fwdyB0n5j39XbRCzqZEhqNVexL0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60f886b14815712f3ab130b8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 20:42:25
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AB501C43460; Wed, 21 Jul 2021 20:42:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73C7CC4338A;
        Wed, 21 Jul 2021 20:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73C7CC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH] ath11k: Add support for RX decapsulation offload
Date:   Wed, 21 Jul 2021 23:42:17 +0300
Message-Id: <20210721204217.120572-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sriram R <srirrama@codeaurora.org>

Add support for rx decapsulation offload by advertising
the support to mac80211 during registration. Also ensure
the frames have the RX_FLAG_8023 flag set in decap offload
frames before passing to mac80211.

Since the packets delivered to the driver are in 802.3 format, these
can be sent to the network core with minimal processing in mac80211.
This helps in releasing some CPU cycles in the host processor and
thereby improving the performance.

Two exceptions are made before passing decap frames, one is
for EAPOL packets since mac80211 8023 fast rx for the sta
is set only after authorization, other case is for multicast
packets to validate PN in mac80211. In both the cases the
decap frames are converted to 80211 frame and sent to mac80211.

Ethernet decap can be enabled by using a modparam as shown below:
insmod ath11k frame_mode=2

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00844-QCAHKSWPL_SILICONZ-1 v2

Co-developed-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h     |   4 +
 drivers/net/wireless/ath/ath11k/dp_rx.c    | 194 +++++++++++++--------
 drivers/net/wireless/ath/ath11k/hal_desc.h |   2 +
 drivers/net/wireless/ath/ath11k/hw.c       |  43 +++++
 drivers/net/wireless/ath/ath11k/hw.h       |   2 +
 drivers/net/wireless/ath/ath11k/mac.c      |  25 ++-
 6 files changed, 198 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index c73001014795..9d97da2a3ba8 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -93,6 +93,8 @@ struct ath11k_skb_rxcb {
 	bool is_first_msdu;
 	bool is_last_msdu;
 	bool is_continuation;
+	bool is_mcbc;
+	bool is_eapol;
 	struct hal_rx_desc *rx_desc;
 	u8 err_rel_src;
 	u8 err_code;
@@ -100,6 +102,8 @@ struct ath11k_skb_rxcb {
 	u8 unmapped;
 	u8 is_frag;
 	u8 tid;
+	u16 peer_id;
+	u16 seq_no;
 };
 
 enum ath11k_hw_rev {
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 587690bec595..cc53432827e5 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -270,6 +270,18 @@ static bool ath11k_dp_rx_h_attn_is_mcbc(struct ath11k_base *ab,
 		 __le32_to_cpu(attn->info1)));
 }
 
+static bool ath11k_dp_rxdesc_mac_addr2_valid(struct ath11k_base *ab,
+					     struct hal_rx_desc *desc)
+{
+	return ab->hw_params.hw_ops->rx_desc_mac_addr2_valid(desc);
+}
+
+static u8 *ath11k_dp_rxdesc_mpdu_start_addr2(struct ath11k_base *ab,
+					     struct hal_rx_desc *desc)
+{
+	return ab->hw_params.hw_ops->rx_desc_mpdu_start_addr2(desc);
+}
+
 static void ath11k_dp_service_mon_ring(struct timer_list *t)
 {
 	struct ath11k_base *ab = from_timer(ab, t, mon_reap_timer);
@@ -2156,6 +2168,7 @@ static void ath11k_dp_rx_h_undecap(struct ath11k *ar, struct sk_buff *msdu,
 {
 	u8 *first_hdr;
 	u8 decap;
+	struct ethhdr *ehdr;
 
 	first_hdr = ath11k_dp_rx_h_80211_hdr(ar->ab, rx_desc);
 	decap = ath11k_dp_rx_h_msdu_start_decap_type(ar->ab, rx_desc);
@@ -2170,9 +2183,22 @@ static void ath11k_dp_rx_h_undecap(struct ath11k *ar, struct sk_buff *msdu,
 					   decrypted);
 		break;
 	case DP_RX_DECAP_TYPE_ETHERNET2_DIX:
-		/* TODO undecap support for middle/last msdu's of amsdu */
-		ath11k_dp_rx_h_undecap_eth(ar, msdu, first_hdr,
-					   enctype, status);
+		ehdr = (struct ethhdr *)msdu->data;
+
+		/* mac80211 allows fast path only for authorized STA */
+		if (ehdr->h_proto == cpu_to_be16(ETH_P_PAE)) {
+			ATH11K_SKB_RXCB(msdu)->is_eapol = true;
+			ath11k_dp_rx_h_undecap_eth(ar, msdu, first_hdr,
+						   enctype, status);
+			break;
+		}
+
+		/* PN for mcast packets will be validated in mac80211;
+		 * remove eth header and add 802.11 header.
+		 */
+		if (ATH11K_SKB_RXCB(msdu)->is_mcbc && decrypted)
+			ath11k_dp_rx_h_undecap_eth(ar, msdu, first_hdr,
+						   enctype, status);
 		break;
 	case DP_RX_DECAP_TYPE_8023:
 		/* TODO: Handle undecap for these formats */
@@ -2180,35 +2206,62 @@ static void ath11k_dp_rx_h_undecap(struct ath11k *ar, struct sk_buff *msdu,
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
+
+	if (peer)
+		return peer;
+
+	if (!rx_desc || !(ath11k_dp_rxdesc_mac_addr2_valid(ab, rx_desc)))
+		return NULL;
+
+	peer = ath11k_peer_find_by_addr(ab,
+					ath11k_dp_rxdesc_mpdu_start_addr2(ab, rx_desc));
+	return peer;
+}
+
 static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 				struct sk_buff *msdu,
 				struct hal_rx_desc *rx_desc,
 				struct ieee80211_rx_status *rx_status)
 {
-	bool  fill_crypto_hdr, mcast;
+	bool  fill_crypto_hdr;
 	enum hal_encrypt_type enctype;
 	bool is_decrypted = false;
+	struct ath11k_skb_rxcb *rxcb;
 	struct ieee80211_hdr *hdr;
 	struct ath11k_peer *peer;
 	struct rx_attention *rx_attention;
 	u32 err_bitmap;
 
-	hdr = (struct ieee80211_hdr *)msdu->data;
-
 	/* PN for multicast packets will be checked in mac80211 */
+	rxcb = ATH11K_SKB_RXCB(msdu);
+	fill_crypto_hdr = ath11k_dp_rx_h_attn_is_mcbc(ar->ab, rx_desc);
+	rxcb->is_mcbc = fill_crypto_hdr;
 
-	mcast = is_multicast_ether_addr(hdr->addr1);
-	fill_crypto_hdr = mcast;
+	if (rxcb->is_mcbc) {
+		rxcb->peer_id = ath11k_dp_rx_h_mpdu_start_peer_id(ar->ab, rx_desc);
+		rxcb->seq_no = ath11k_dp_rx_h_mpdu_start_seq_no(ar->ab, rx_desc);
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
+		enctype = ath11k_dp_rx_h_mpdu_start_enctype(ar->ab, rx_desc);
 	}
 	spin_unlock_bh(&ar->ab->base_lock);
 
@@ -2247,8 +2300,11 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 	if (!is_decrypted || fill_crypto_hdr)
 		return;
 
-	hdr = (void *)msdu->data;
-	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+	if (ath11k_dp_rx_h_msdu_start_decap_type(ar->ab, rx_desc) !=
+	    DP_RX_DECAP_TYPE_ETHERNET2_DIX) {
+		hdr = (void *)msdu->data;
+		hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+	}
 }
 
 static void ath11k_dp_rx_h_rate(struct ath11k *ar, struct hal_rx_desc *rx_desc,
@@ -2362,51 +2418,49 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
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
 		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
 				     IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN),
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
+	u8 decap = DP_RX_DECAP_TYPE_RAW;
+	bool is_mcbc = rxcb->is_mcbc;
+	bool is_eapol = rxcb->is_eapol;
 
-	status = IEEE80211_SKB_RXCB(msdu);
-	if (status->encoding == RX_ENC_HE) {
+	if (status->encoding == RX_ENC_HE &&
+	    !(status->flag & RX_FLAG_RADIOTAP_HE) &&
+	    !(status->flag & RX_FLAG_SKIP_MONITOR)) {
 		he = skb_push(msdu, sizeof(known));
 		memcpy(he, &known, sizeof(known));
 		status->flag |= RX_FLAG_RADIOTAP_HE;
 	}
 
+	if (!(status->flag & RX_FLAG_ONLY_MONITOR))
+		decap = ath11k_dp_rx_h_msdu_start_decap_type(ar->ab, rxcb->rx_desc);
+
+	spin_lock_bh(&ar->ab->base_lock);
+	peer = ath11k_dp_rx_h_find_peer(ar->ab, msdu);
+	if (peer && peer->sta)
+		pubsta = peer->sta;
+	spin_unlock_bh(&ar->ab->base_lock);
+
 	ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
-		   "rx skb %pK len %u peer %pM %s %s sn %u %s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
+		   "rx skb %pK len %u peer %pM %d %s sn %u %s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
 		   msdu,
 		   msdu->len,
-		   ieee80211_get_SA(hdr),
-		   ath11k_print_get_tid(hdr, tid, sizeof(tid)),
-		   is_multicast_ether_addr(ieee80211_get_DA(hdr)) ?
-							"mcast" : "ucast",
-		   (__le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4,
+		   peer ? peer->addr : NULL,
+		   rxcb->tid,
+		   is_mcbc ? "mcast" : "ucast",
+		   rxcb->seq_no,
 		   (status->encoding == RX_ENC_LEGACY) ? "legacy" : "",
 		   (status->encoding == RX_ENC_HT) ? "ht" : "",
 		   (status->encoding == RX_ENC_VHT) ? "vht" : "",
@@ -2426,22 +2480,32 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 	ath11k_dbg_dump(ar->ab, ATH11K_DBG_DP_RX, NULL, "dp rx msdu: ",
 			msdu->data, msdu->len);
 
+	rx_status = IEEE80211_SKB_RXCB(msdu);
+	*rx_status = *status;
+
 	/* TODO: trace rx packet */
 
-	ieee80211_rx_napi(ar->hw, NULL, msdu, napi);
+	/* PN for multicast packets are not validate in HW,
+	 * so skip 802.3 rx path
+	 * Also, fast_rx expectes the STA to be authorized, hence
+	 * eapol packets are sent in slow path.
+	 */
+	if (decap == DP_RX_DECAP_TYPE_ETHERNET2_DIX && !is_eapol &&
+	    !(is_mcbc && rx_status->flag & RX_FLAG_DECRYPTED))
+		rx_status->flag |= RX_FLAG_8023;
+
+	ieee80211_rx_napi(ar->hw, pubsta, msdu, napi);
 }
 
 static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 				     struct sk_buff *msdu,
-				     struct sk_buff_head *msdu_list)
+				     struct sk_buff_head *msdu_list,
+				     struct ieee80211_rx_status *rx_status)
 {
 	struct ath11k_base *ab = ar->ab;
 	struct hal_rx_desc *rx_desc, *lrx_desc;
 	struct rx_attention *rx_attention;
-	struct ieee80211_rx_status rx_status = {0};
-	struct ieee80211_rx_status *status;
 	struct ath11k_skb_rxcb *rxcb;
-	struct ieee80211_hdr *hdr;
 	struct sk_buff *last_buf;
 	u8 l3_pad_bytes;
 	u8 *hdr_status;
@@ -2497,19 +2561,11 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 		}
 	}
 
-	hdr = (struct ieee80211_hdr *)msdu->data;
-
-	/* Process only data frames */
-	if (!ieee80211_is_data(hdr->frame_control))
-		return -EINVAL;
-
-	ath11k_dp_rx_h_ppdu(ar, rx_desc, &rx_status);
-	ath11k_dp_rx_h_mpdu(ar, msdu, rx_desc, &rx_status);
+	ath11k_dp_rx_h_ppdu(ar, rx_desc, rx_status);
+	ath11k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_status);
 
-	rx_status.flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
+	rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
 
-	status = IEEE80211_SKB_RXCB(msdu);
-	*status = rx_status;
 	return 0;
 
 free_out:
@@ -2524,6 +2580,7 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 	struct ath11k_skb_rxcb *rxcb;
 	struct sk_buff *msdu;
 	struct ath11k *ar;
+	struct ieee80211_rx_status rx_status = {0};
 	u8 mac_id;
 	int ret;
 
@@ -2546,7 +2603,7 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 			continue;
 		}
 
-		ret = ath11k_dp_rx_process_msdu(ar, msdu, msdu_list);
+		ret = ath11k_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_status);
 		if (ret) {
 			ath11k_dbg(ab, ATH11K_DBG_DATA,
 				   "Unable to process msdu %d", ret);
@@ -2554,7 +2611,7 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 			continue;
 		}
 
-		ath11k_dp_rx_deliver_msdu(ar, napi, msdu);
+		ath11k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_status);
 		(*quota)--;
 	}
 
@@ -2636,10 +2693,14 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
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
 
 		if (total_msdu_reaped >= quota && !rxcb->is_continuation) {
@@ -3991,7 +4052,6 @@ static void ath11k_dp_rx_wbm_err(struct ath11k *ar,
 {
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
 	struct ieee80211_rx_status rxs = {0};
-	struct ieee80211_rx_status *status;
 	bool drop = true;
 
 	switch (rxcb->err_rel_src) {
@@ -4011,10 +4071,7 @@ static void ath11k_dp_rx_wbm_err(struct ath11k *ar,
 		return;
 	}
 
-	status = IEEE80211_SKB_RXCB(msdu);
-	*status = rxs;
-
-	ath11k_dp_rx_deliver_msdu(ar, napi, msdu);
+	ath11k_dp_rx_deliver_msdu(ar, napi, msdu, &rxs);
 }
 
 int ath11k_dp_rx_process_wbm_err(struct ath11k_base *ab,
@@ -4898,7 +4955,7 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
 	struct sk_buff *mon_skb, *skb_next, *header;
-	struct ieee80211_rx_status *rxs = &dp->rx_status, *status;
+	struct ieee80211_rx_status *rxs = &dp->rx_status;
 
 	mon_skb = ath11k_dp_rx_mon_merg_msdus(ar, mac_id, head_msdu,
 					      tail_msdu, rxs);
@@ -4924,10 +4981,7 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
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
index 0be0e8939783..406767672844 100644
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
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 9dd02f8b1dd2..7a343db1dde8 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -374,6 +374,17 @@ static void ath11k_hw_ipq8074_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16
 	desc->u.ipq8074.msdu_start.info1 = __cpu_to_le32(info);
 }
 
+static bool ath11k_hw_ipq8074_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.ipq8074.mpdu_start.info1) &
+	       RX_MPDU_START_INFO1_MAC_ADDR2_VALID;
+}
+
+static u8 *ath11k_hw_ipq8074_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
+{
+	return desc->u.ipq8074.mpdu_start.addr2;
+}
+
 static
 struct rx_attention *ath11k_hw_ipq8074_rx_desc_get_attention(struct hal_rx_desc *desc)
 {
@@ -545,6 +556,17 @@ static u8 *ath11k_hw_qcn9074_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
 	return &desc->u.qcn9074.msdu_payload[0];
 }
 
+static bool ath11k_hw_ipq9074_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.qcn9074.mpdu_start.info11) &
+	       RX_MPDU_START_INFO11_MAC_ADDR2_VALID;
+}
+
+static u8 *ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
+{
+	return desc->u.qcn9074.mpdu_start.addr2;
+}
+
 static bool ath11k_hw_wcn6855_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
 {
 	return !!FIELD_GET(RX_MSDU_END_INFO2_FIRST_MSDU_WCN6855,
@@ -705,6 +727,17 @@ static u8 *ath11k_hw_wcn6855_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
 	return &desc->u.wcn6855.msdu_payload[0];
 }
 
+static bool ath11k_hw_wcn6855_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.wcn6855.mpdu_start.info1) &
+	       RX_MPDU_START_INFO1_MAC_ADDR2_VALID;
+}
+
+static u8 *ath11k_hw_wcn6855_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
+{
+	return desc->u.wcn6855.mpdu_start.addr2;
+}
+
 static void ath11k_hw_wcn6855_reo_setup(struct ath11k_base *ab)
 {
 	u32 reo_base = HAL_SEQ_WCSS_UMAC_REO_REG;
@@ -801,6 +834,8 @@ const struct ath11k_hw_ops ipq8074_ops = {
 	.rx_desc_get_msdu_payload = ath11k_hw_ipq8074_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_ipq8074_reo_setup,
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
+	.rx_desc_mac_addr2_valid = ath11k_hw_ipq8074_rx_desc_mac_addr2_valid,
+	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq8074_rx_desc_mpdu_start_addr2,
 };
 
 const struct ath11k_hw_ops ipq6018_ops = {
@@ -837,6 +872,8 @@ const struct ath11k_hw_ops ipq6018_ops = {
 	.rx_desc_get_msdu_payload = ath11k_hw_ipq8074_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_ipq8074_reo_setup,
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
+	.rx_desc_mac_addr2_valid = ath11k_hw_ipq8074_rx_desc_mac_addr2_valid,
+	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq8074_rx_desc_mpdu_start_addr2,
 };
 
 const struct ath11k_hw_ops qca6390_ops = {
@@ -873,6 +910,8 @@ const struct ath11k_hw_ops qca6390_ops = {
 	.rx_desc_get_msdu_payload = ath11k_hw_ipq8074_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_ipq8074_reo_setup,
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
+	.rx_desc_mac_addr2_valid = ath11k_hw_ipq8074_rx_desc_mac_addr2_valid,
+	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq8074_rx_desc_mpdu_start_addr2,
 };
 
 const struct ath11k_hw_ops qcn9074_ops = {
@@ -909,6 +948,8 @@ const struct ath11k_hw_ops qcn9074_ops = {
 	.rx_desc_get_msdu_payload = ath11k_hw_qcn9074_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_ipq8074_reo_setup,
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
+	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
+	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2,
 };
 
 const struct ath11k_hw_ops wcn6855_ops = {
@@ -945,6 +986,8 @@ const struct ath11k_hw_ops wcn6855_ops = {
 	.rx_desc_get_msdu_payload = ath11k_hw_wcn6855_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_wcn6855_reo_setup,
 	.mpdu_info_get_peerid = ath11k_hw_wcn6855_mpdu_info_get_peerid,
+	.rx_desc_mac_addr2_valid = ath11k_hw_wcn6855_rx_desc_mac_addr2_valid,
+	.rx_desc_mpdu_start_addr2 = ath11k_hw_wcn6855_rx_desc_mpdu_start_addr2,
 };
 
 #define ATH11K_TX_RING_MASK_0 0x1
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 3a03e09563e7..8a75afae11db 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -210,6 +210,8 @@ struct ath11k_hw_ops {
 	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
 	void (*reo_setup)(struct ath11k_base *ab);
 	u16 (*mpdu_info_get_peerid)(u8 *tlv_data);
+	bool (*rx_desc_mac_addr2_valid)(struct hal_rx_desc *desc);
+	u8* (*rx_desc_mpdu_start_addr2)(struct hal_rx_desc *desc);
 };
 
 extern const struct ath11k_hw_ops ipq8074_ops;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 11d919d3c23e..55bc45f8fe92 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5313,7 +5313,8 @@ static void ath11k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 	if (ath11k_frame_mode != ATH11K_HW_TXRX_ETHERNET ||
 	    (vif->type != NL80211_IFTYPE_STATION &&
 	     vif->type != NL80211_IFTYPE_AP))
-		vif->offload_flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
+		vif->offload_flags &= ~(IEEE80211_OFFLOAD_ENCAP_ENABLED |
+					IEEE80211_OFFLOAD_DECAP_ENABLED);
 
 	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
 		param_value = ATH11K_HW_TXRX_ETHERNET;
@@ -5329,6 +5330,22 @@ static void ath11k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 			    arvif->vdev_id, ret);
 		vif->offload_flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
 	}
+
+	param_id = WMI_VDEV_PARAM_RX_DECAP_TYPE;
+	if (vif->offload_flags & IEEE80211_OFFLOAD_DECAP_ENABLED)
+		param_value = ATH11K_HW_TXRX_ETHERNET;
+	else if (test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags))
+		param_value = ATH11K_HW_TXRX_RAW;
+	else
+		param_value = ATH11K_HW_TXRX_NATIVE_WIFI;
+
+	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+					    param_id, param_value);
+	if (ret) {
+		ath11k_warn(ab, "failed to set vdev %d rx decap mode: %d\n",
+			    arvif->vdev_id, ret);
+		vif->offload_flags &= ~IEEE80211_OFFLOAD_DECAP_ENABLED;
+	}
 }
 
 static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
@@ -7448,7 +7465,11 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ieee80211_hw_set(ar->hw, QUEUE_CONTROL);
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(ar->hw, REPORTS_LOW_ACK);
-	ieee80211_hw_set(ar->hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+
+	if (ath11k_frame_mode == ATH11K_HW_TXRX_ETHERNET) {
+		ieee80211_hw_set(ar->hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+		ieee80211_hw_set(ar->hw, SUPPORTS_RX_DECAP_OFFLOAD);
+	}
 
 	if (cap->nss_ratio_enabled)
 		ieee80211_hw_set(ar->hw, SUPPORTS_VHT_EXT_NSS_BW);
-- 
2.25.1

