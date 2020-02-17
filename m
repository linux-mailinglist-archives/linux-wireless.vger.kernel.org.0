Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2750816087C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2020 04:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgBQDI1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Feb 2020 22:08:27 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:51426 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbgBQDI0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Feb 2020 22:08:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581908905; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=dMFEgkc95kCIjCUYsj5l5/jvpnLMPdKdbAGvL+LGWbw=; b=ucs0QFI1j44PrWxNQXU42N2SPEmi9MpCHgiXkbpEBrdAmWlLLKB+KZJpfiNAZy5ynIQ8Cz1C
 fW1G/DLd0tw8hrZfh1/JgOY4t0r6sLgqheqqbN32gYCk98G08FZhq/L2IZZc/pfJF0Xc0WjU
 ucRiGAvmWX0JOONsXFx4czpRFZE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4a03a1.7f386b822ab0-smtp-out-n02;
 Mon, 17 Feb 2020 03:08:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C82B3C433A2; Mon, 17 Feb 2020 03:08:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from checstp253621-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DF6BC43383;
        Mon, 17 Feb 2020 03:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DF6BC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>,
        Tamizh Chelvam Raja <tamizhr@codeaurora.org>
Subject: [PATCHv2 2/2] ath11k: Perform per-msdu rx processing
Date:   Mon, 17 Feb 2020 08:37:53 +0530
Message-Id: <1581908873-14749-3-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581908873-14749-1-git-send-email-srirrama@codeaurora.org>
References: <1581908873-14749-1-git-send-email-srirrama@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As Hash based reo destination selection is configured,
the decapped packets reach different reo destintion rings
based on the destintaion ring selected for the computed hash (based on
the 5-tuple {ip src/ip dst/src port/dst port/protocol}) by hw and
as configured by driver.

Hence the current implementation of amsdu list based processing after all
the subframes of amsdu are received (since all msdu's for a pdev are
received in same reo dest ring), is not applicable here and hence is
replaced with per msdu based handling as these subframes
can be received in different reo dest rings.

Also, as some of the rx descriptor fields might be valid only for the
first msdu (for ex. received 80211 header, encryption type, etc),
it might not be useful now as we cannot sync between different
subframes received in different rings. Hence do not rely on those
fields and replace them with fieds valid only on per msdu descriptors.
Also cache other details such as encryption type for a peer so that
it can be reused when a packet is received from it.

Co-developed-by: Tamizh Chelvam Raja <tamizhr@codeaurora.org>
Signed-off-by: Tamizh Chelvam Raja <tamizhr@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c   |   5 -
 drivers/net/wireless/ath/ath11k/core.h  |   5 +-
 drivers/net/wireless/ath/ath11k/dp.c    |  18 +-
 drivers/net/wireless/ath/ath11k/dp.h    |   2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 511 ++++++++++++++------------------
 drivers/net/wireless/ath/ath11k/dp_rx.h |   4 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c   |   6 +
 drivers/net/wireless/ath/ath11k/mac.h   |   1 +
 drivers/net/wireless/ath/ath11k/peer.c  |   3 +
 drivers/net/wireless/ath/ath11k/peer.h  |   2 +
 11 files changed, 244 insertions(+), 315 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index e7e3e64..214e24b 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -458,7 +458,6 @@ static void ath11k_ahb_ext_grp_disable(struct ath11k_ext_irq_grp *irq_grp)
 
 static void __ath11k_ahb_ext_irq_disable(struct ath11k_base *ab)
 {
-	struct sk_buff *skb;
 	int i;
 
 	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
@@ -468,9 +467,6 @@ static void __ath11k_ahb_ext_irq_disable(struct ath11k_base *ab)
 
 		napi_synchronize(&irq_grp->napi);
 		napi_disable(&irq_grp->napi);
-
-		while ((skb = __skb_dequeue(&irq_grp->pending_q)))
-			dev_kfree_skb_any(skb);
 	}
 }
 
@@ -734,7 +730,6 @@ static int ath11k_ahb_ext_irq_config(struct ath11k_base *ab)
 		init_dummy_netdev(&irq_grp->napi_ndev);
 		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
 			       ath11k_ahb_ext_grp_napi_poll, NAPI_POLL_WEIGHT);
-		__skb_queue_head_init(&irq_grp->pending_q);
 
 		for (j = 0; j < ATH11K_EXT_IRQ_NUM_MAX; j++) {
 			if (ath11k_tx_ring_mask[i] & BIT(j)) {
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b545721..ce8f7fe 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -77,6 +77,7 @@ struct ath11k_skb_rxcb {
 	u8 mac_id;
 	u8 unmapped;
 	u8 is_frag;
+	u8 tid;
 };
 
 enum ath11k_hw_rev {
@@ -111,10 +112,6 @@ struct ath11k_ext_irq_grp {
 	u32 grp_id;
 	struct napi_struct napi;
 	struct net_device napi_ndev;
-	/* Queue of pending packets, not expected to be accessed concurrently
-	 * to avoid locking overhead.
-	 */
-	struct sk_buff_head pending_q;
 };
 
 #define HEHANDLE_CAP_PHYINFO_SIZE       3
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index b887520..50350f7 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -650,17 +650,13 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 	}
 
 	if (ath11k_rx_ring_mask[grp_id]) {
-		for (i = 0; i <  ab->num_radios; i++) {
-			if (ath11k_rx_ring_mask[grp_id] & BIT(i)) {
-				work_done = ath11k_dp_process_rx(ab, i, napi,
-								 &irq_grp->pending_q,
-								 budget);
-				budget -= work_done;
-				tot_work_done += work_done;
-			}
-			if (budget <= 0)
-				goto done;
-		}
+		i =  fls(ath11k_rx_ring_mask[grp_id]) - 1;
+		work_done = ath11k_dp_process_rx(ab, i, napi,
+						 budget);
+		budget -= work_done;
+		tot_work_done += work_done;
+		if (budget <= 0)
+			goto done;
 	}
 
 	if (rx_mon_status_ring_mask[grp_id]) {
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 98cbbbc..994ab9b 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -140,7 +140,6 @@ struct ath11k_pdev_dp {
 	u32 mac_id;
 	atomic_t num_tx_pending;
 	wait_queue_head_t tx_empty_waitq;
-	struct dp_srng reo_dst_ring;
 	struct dp_rxdma_ring rx_refill_buf_ring;
 	struct dp_srng rxdma_err_dst_ring;
 	struct dp_srng rxdma_mon_dst_ring;
@@ -218,6 +217,7 @@ struct ath11k_dp {
 	struct dp_srng reo_except_ring;
 	struct dp_srng reo_cmd_ring;
 	struct dp_srng reo_status_ring;
+	struct dp_srng reo_dst_ring[DP_REO_DST_RING_MAX];
 	struct dp_tx_ring tx_ring[DP_TCL_NUM_RING_MAX];
 	struct hal_wbm_idle_scatter_list scatter_list[DP_IDLE_SCATTER_BUFS_MAX];
 	struct list_head reo_cmd_list;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 06dbf06..f40e5a7 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/ieee80211.h>
+#include <linux/kernel.h>
+#include <linux/skbuff.h>
 #include <crypto/hash.h>
 #include "core.h"
 #include "debug.h"
@@ -37,6 +39,12 @@ static u8 ath11k_dp_rx_h_msdu_start_decap_type(struct hal_rx_desc *desc)
 			 __le32_to_cpu(desc->msdu_start.info2));
 }
 
+static u8 ath11k_dp_rx_h_msdu_start_mesh_ctl_present(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO2_MESH_CTRL_PRESENT,
+			 __le32_to_cpu(desc->msdu_start.info2));
+}
+
 static bool ath11k_dp_rx_h_mpdu_start_seq_ctrl_valid(struct hal_rx_desc *desc)
 {
 	return !!FIELD_GET(RX_MPDU_START_INFO1_MPDU_SEQ_CTRL_VALID,
@@ -77,12 +85,6 @@ static bool ath11k_dp_rx_h_attn_msdu_done(struct hal_rx_desc *desc)
 			   __le32_to_cpu(desc->attention.info2));
 }
 
-static bool ath11k_dp_rx_h_attn_first_mpdu(struct hal_rx_desc *desc)
-{
-	return !!FIELD_GET(RX_ATTENTION_INFO1_FIRST_MPDU,
-			   __le32_to_cpu(desc->attention.info1));
-}
-
 static bool ath11k_dp_rx_h_attn_l4_cksum_fail(struct hal_rx_desc *desc)
 {
 	return !!FIELD_GET(RX_ATTENTION_INFO1_TCP_UDP_CKSUM_FAIL,
@@ -450,32 +452,25 @@ static void ath11k_dp_rx_pdev_srng_free(struct ath11k *ar)
 
 void ath11k_dp_pdev_reo_cleanup(struct ath11k_base *ab)
 {
-	struct ath11k_pdev_dp *dp;
-	struct ath11k *ar;
+	struct ath11k_dp *dp = &ab->dp;
 	int i;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		ar = ab->pdevs[i].ar;
-		dp = &ar->dp;
-		ath11k_dp_srng_cleanup(ab, &dp->reo_dst_ring);
-	}
+	for (i = 0; i < DP_REO_DST_RING_MAX; i++)
+		ath11k_dp_srng_cleanup(ab, &dp->reo_dst_ring[i]);
 }
 
 int ath11k_dp_pdev_reo_setup(struct ath11k_base *ab)
 {
-	struct ath11k *ar;
-	struct ath11k_pdev_dp *dp;
+	struct ath11k_dp *dp = &ab->dp;
 	int ret;
 	int i;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		ar = ab->pdevs[i].ar;
-		dp = &ar->dp;
-		ret = ath11k_dp_srng_setup(ab, &dp->reo_dst_ring, HAL_REO_DST,
-					   dp->mac_id, dp->mac_id,
+	for (i = 0; i < DP_REO_DST_RING_MAX; i++) {
+		ret = ath11k_dp_srng_setup(ab, &dp->reo_dst_ring[i],
+					   HAL_REO_DST, i, 0,
 					   DP_REO_DST_RING_SIZE);
 		if (ret) {
-			ath11k_warn(ar->ab, "failed to setup reo_dst_ring\n");
+			ath11k_warn(ab, "failed to setup reo_dst_ring\n");
 			goto err_reo_cleanup;
 		}
 	}
@@ -1659,90 +1654,6 @@ static struct sk_buff *ath11k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_
 	return NULL;
 }
 
-static int ath11k_dp_rx_retrieve_amsdu(struct ath11k *ar,
-				       struct sk_buff_head *msdu_list,
-				       struct sk_buff_head *amsdu_list)
-{
-	struct sk_buff *msdu = skb_peek(msdu_list);
-	struct sk_buff *last_buf;
-	struct ath11k_skb_rxcb *rxcb;
-	struct ieee80211_hdr *hdr;
-	struct hal_rx_desc *rx_desc, *lrx_desc;
-	u16 msdu_len;
-	u8 l3_pad_bytes;
-	u8 *hdr_status;
-	int ret;
-
-	if (!msdu)
-		return -ENOENT;
-
-	rx_desc = (struct hal_rx_desc *)msdu->data;
-	hdr_status = ath11k_dp_rx_h_80211_hdr(rx_desc);
-	hdr = (struct ieee80211_hdr *)hdr_status;
-	/* Process only data frames */
-	if (!ieee80211_is_data(hdr->frame_control)) {
-		__skb_unlink(msdu, msdu_list);
-		dev_kfree_skb_any(msdu);
-		return -EINVAL;
-	}
-
-	do {
-		__skb_unlink(msdu, msdu_list);
-		last_buf = ath11k_dp_rx_get_msdu_last_buf(msdu_list, msdu);
-		if (!last_buf) {
-			ath11k_warn(ar->ab,
-				    "No valid Rx buffer to access Atten/MSDU_END/MPDU_END tlvs\n");
-			ret = -EIO;
-			goto free_out;
-		}
-
-		rx_desc = (struct hal_rx_desc *)msdu->data;
-		lrx_desc = (struct hal_rx_desc *)last_buf->data;
-
-		if (!ath11k_dp_rx_h_attn_msdu_done(lrx_desc)) {
-			ath11k_warn(ar->ab, "msdu_done bit in attention is not set\n");
-			ret = -EIO;
-			goto free_out;
-		}
-
-		rxcb = ATH11K_SKB_RXCB(msdu);
-		rxcb->rx_desc = rx_desc;
-		msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(rx_desc);
-		l3_pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(lrx_desc);
-
-		if (rxcb->is_frag) {
-			skb_pull(msdu, HAL_RX_DESC_SIZE);
-		} else if (!rxcb->is_continuation) {
-			skb_put(msdu, HAL_RX_DESC_SIZE + l3_pad_bytes + msdu_len);
-			skb_pull(msdu, HAL_RX_DESC_SIZE + l3_pad_bytes);
-		} else {
-			ret = ath11k_dp_rx_msdu_coalesce(ar, msdu_list,
-							 msdu, last_buf,
-							 l3_pad_bytes, msdu_len);
-			if (ret) {
-				ath11k_warn(ar->ab,
-					    "failed to coalesce msdu rx buffer%d\n", ret);
-				goto free_out;
-			}
-		}
-		__skb_queue_tail(amsdu_list, msdu);
-
-		/* Should we also consider msdu_cnt from mpdu_meta while
-		 * preparing amsdu list?
-		 */
-		if (rxcb->is_last_msdu)
-			break;
-	} while ((msdu = skb_peek(msdu_list)) != NULL);
-
-	return 0;
-
-free_out:
-	dev_kfree_skb_any(msdu);
-	__skb_queue_purge(amsdu_list);
-
-	return ret;
-}
-
 static void ath11k_dp_rx_h_csum_offload(struct sk_buff *msdu)
 {
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
@@ -1841,20 +1752,53 @@ static void ath11k_dp_rx_h_undecap_nwifi(struct ath11k *ar,
 					 enum hal_encrypt_type enctype,
 					 struct ieee80211_rx_status *status)
 {
+	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
+	u8 decap_hdr[DP_MAX_NWIFI_HDR_LEN];
 	struct ieee80211_hdr *hdr;
 	size_t hdr_len;
 	u8 da[ETH_ALEN];
 	u8 sa[ETH_ALEN];
+	u16 qos_ctl = 0;
+	u8 *qos;
 
-	/* pull decapped header and copy SA & DA */
+	/* copy SA & DA and pull decapped header */
 	hdr = (struct ieee80211_hdr *)msdu->data;
+	hdr_len = ieee80211_hdrlen(hdr->frame_control);
 	ether_addr_copy(da, ieee80211_get_DA(hdr));
 	ether_addr_copy(sa, ieee80211_get_SA(hdr));
 	skb_pull(msdu, ieee80211_hdrlen(hdr->frame_control));
 
-	/* push original 802.11 header */
-	hdr = (struct ieee80211_hdr *)first_hdr;
-	hdr_len = ieee80211_hdrlen(hdr->frame_control);
+	if (rxcb->is_first_msdu) {
+		/* original 802.11 header is valid for the first msdu
+		 * hence we can reuse the same header
+		 */
+		hdr = (struct ieee80211_hdr *)first_hdr;
+		hdr_len = ieee80211_hdrlen(hdr->frame_control);
+
+		/* Each A-MSDU subframe will be reported as a separate MSDU,
+		 * so strip the A-MSDU bit from QoS Ctl.
+		 */
+		if (ieee80211_is_data_qos(hdr->frame_control)) {
+			qos = ieee80211_get_qos_ctl(hdr);
+			qos[0] &= ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
+		}
+	} else {
+		/*  Rebuild qos header if this is a middle/last msdu */
+		hdr->frame_control |= __cpu_to_le16(IEEE80211_STYPE_QOS_DATA);
+
+		/* Reset the order bit as the HT_Control header is stripped */
+		hdr->frame_control &= ~(__cpu_to_le16(IEEE80211_FCTL_ORDER));
+
+		qos_ctl = rxcb->tid;
+
+		if (ath11k_dp_rx_h_msdu_start_mesh_ctl_present(rxcb->rx_desc))
+			qos_ctl |= IEEE80211_QOS_CTL_MESH_CONTROL_PRESENT;
+
+		/* TODO Add other QoS ctl fields when required */
+
+		/* copy decap header before overwriting for reuse below */
+		memcpy(decap_hdr, (uint8_t *)hdr, hdr_len);
+	}
 
 	if (!(status->flag & RX_FLAG_IV_STRIPPED)) {
 		memcpy(skb_push(msdu,
@@ -1863,6 +1807,14 @@ static void ath11k_dp_rx_h_undecap_nwifi(struct ath11k *ar,
 		       ath11k_dp_rx_crypto_param_len(ar, enctype));
 	}
 
+	if (!rxcb->is_first_msdu) {
+		memcpy(skb_push(msdu,
+				IEEE80211_QOS_CTL_LEN), &qos_ctl,
+				IEEE80211_QOS_CTL_LEN);
+		memcpy(skb_push(msdu, hdr_len), decap_hdr, hdr_len);
+		return;
+	}
+
 	memcpy(skb_push(msdu, hdr_len), hdr, hdr_len);
 
 	/* original 802.11 header has a different DA and in
@@ -2029,6 +1981,7 @@ static void ath11k_dp_rx_h_undecap(struct ath11k *ar, struct sk_buff *msdu,
 					   decrypted);
 		break;
 	case DP_RX_DECAP_TYPE_ETHERNET2_DIX:
+		/* TODO undecap support for middle/last msdu's of amsdu */
 		ath11k_dp_rx_h_undecap_eth(ar, msdu, first_hdr,
 					   enctype, status);
 		break;
@@ -2039,45 +1992,40 @@ static void ath11k_dp_rx_h_undecap(struct ath11k *ar, struct sk_buff *msdu,
 }
 
 static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
-				struct sk_buff_head *amsdu_list,
+				struct sk_buff *msdu,
 				struct hal_rx_desc *rx_desc,
 				struct ieee80211_rx_status *rx_status)
 {
-	struct ieee80211_hdr *hdr;
+	bool  fill_crypto_hdr, mcast;
 	enum hal_encrypt_type enctype;
-	struct sk_buff *last_msdu;
-	struct sk_buff *msdu;
-	struct ath11k_skb_rxcb *last_rxcb;
-	bool is_decrypted = false, fill_crypto_hdr;
+	bool is_decrypted = false;
+	struct ieee80211_hdr *hdr;
+	struct ath11k_peer *peer;
 	u32 err_bitmap;
-	u8 *qos;
-
-	if (skb_queue_empty(amsdu_list))
-		return;
-
-	hdr = (struct ieee80211_hdr *)ath11k_dp_rx_h_80211_hdr(rx_desc);
 
-	/* Each A-MSDU subframe will use the original header as the base and be
-	 * reported as a separate MSDU so strip the A-MSDU bit from QoS Ctl.
-	 */
-	if (ieee80211_is_data_qos(hdr->frame_control)) {
-		qos = ieee80211_get_qos_ctl(hdr);
-		qos[0] &= ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
-	}
+	hdr = (struct ieee80211_hdr *)msdu->data;
 
 	/* PN for multicast packets will be checked in mac80211 */
-	fill_crypto_hdr = is_multicast_ether_addr(hdr->addr1);
+
+	mcast = fill_crypto_hdr = is_multicast_ether_addr(hdr->addr1);
 
 	is_decrypted = ath11k_dp_rx_h_attn_is_decrypted(rx_desc);
-	enctype = ath11k_dp_rx_h_mpdu_start_enctype(rx_desc);
 
-	/* Some attention flags are valid only in the last MSDU. */
-	last_msdu = skb_peek_tail(amsdu_list);
-	last_rxcb = ATH11K_SKB_RXCB(last_msdu);
+	spin_lock_bh(&ar->ab->base_lock);
+	peer = ath11k_peer_find_by_addr(ar->ab, hdr->addr2);
+	if (peer) {
+		if (mcast)
+			enctype = peer->sec_type_grp;
+		else
+			enctype = peer->sec_type;
+	} else {
+		enctype = HAL_ENCRYPT_TYPE_OPEN;
+	}
+	spin_unlock_bh(&ar->ab->base_lock);
 
-	err_bitmap = ath11k_dp_rx_h_attn_mpdu_err(last_rxcb->rx_desc);
+	err_bitmap = ath11k_dp_rx_h_attn_mpdu_err(rx_desc);
 
-	/* Clear per-MPDU flags while leaving per-PPDU flags intact. */
+	/* Clear per-MPDU flags while leaving per-PPDU flags intact */
 	rx_status->flag &= ~(RX_FLAG_FAILED_FCS_CRC |
 			     RX_FLAG_MMIC_ERROR |
 			     RX_FLAG_DECRYPTED |
@@ -2086,7 +2034,6 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 
 	if (err_bitmap & DP_RX_MPDU_ERR_FCS)
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
-
 	if (err_bitmap & DP_RX_MPDU_ERR_TKIP_MIC)
 		rx_status->flag |= RX_FLAG_MMIC_ERROR;
 
@@ -2101,17 +2048,15 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 					   RX_FLAG_PN_VALIDATED;
 	}
 
-	skb_queue_walk(amsdu_list, msdu) {
-		ath11k_dp_rx_h_csum_offload(msdu);
-		ath11k_dp_rx_h_undecap(ar, msdu, rx_desc,
-				       enctype, rx_status, is_decrypted);
+	ath11k_dp_rx_h_csum_offload(msdu);
+	ath11k_dp_rx_h_undecap(ar, msdu, rx_desc,
+			       enctype, rx_status, is_decrypted);
 
-		if (!is_decrypted || fill_crypto_hdr)
-			continue;
+	if (!is_decrypted || fill_crypto_hdr)
+		return;
 
-		hdr = (void *)msdu->data;
-		hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
-	}
+	hdr = (void *)msdu->data;
+	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
 }
 
 static void ath11k_dp_rx_h_rate(struct ath11k *ar, struct hal_rx_desc *rx_desc,
@@ -2212,28 +2157,6 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 	ath11k_dp_rx_h_rate(ar, rx_desc, rx_status);
 }
 
-static void ath11k_dp_rx_process_amsdu(struct ath11k *ar,
-				       struct sk_buff_head *amsdu_list,
-				       struct ieee80211_rx_status *rx_status)
-{
-	struct sk_buff *first;
-	struct ath11k_skb_rxcb *rxcb;
-	struct hal_rx_desc *rx_desc;
-	bool first_mpdu;
-
-	if (skb_queue_empty(amsdu_list))
-		return;
-
-	first = skb_peek(amsdu_list);
-	rxcb = ATH11K_SKB_RXCB(first);
-	rx_desc = rxcb->rx_desc;
-
-	first_mpdu = ath11k_dp_rx_h_attn_first_mpdu(rx_desc);
-	if (first_mpdu)
-		ath11k_dp_rx_h_ppdu(ar, rx_desc, rx_status);
-
-	ath11k_dp_rx_h_mpdu(ar, amsdu_list, rx_desc, rx_status);
-}
 
 static char *ath11k_print_get_tid(struct ieee80211_hdr *hdr, char *out,
 				  size_t size)
@@ -2301,55 +2224,115 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 	ieee80211_rx_napi(ar->hw, NULL, msdu, napi);
 }
 
-static void ath11k_dp_rx_pre_deliver_amsdu(struct ath11k *ar,
-					   struct sk_buff_head *amsdu_list,
-					   struct ieee80211_rx_status *rxs)
+static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
+				     struct sk_buff *msdu,
+				     struct sk_buff_head *msdu_list)
 {
-	struct sk_buff *msdu;
-	struct sk_buff *first_subframe;
+	struct hal_rx_desc *rx_desc, *lrx_desc;
+	struct ieee80211_rx_status rx_status = {0};
 	struct ieee80211_rx_status *status;
+	struct ath11k_skb_rxcb *rxcb;
+	struct ieee80211_hdr *hdr;
+	struct sk_buff *last_buf;
+	u8 l3_pad_bytes;
+	u16 msdu_len;
+	int ret;
 
-	first_subframe = skb_peek(amsdu_list);
+	last_buf = ath11k_dp_rx_get_msdu_last_buf(msdu_list, msdu);
+	if (!last_buf) {
+		ath11k_warn(ar->ab,
+			    "No valid Rx buffer to access Atten/MSDU_END/MPDU_END tlvs\n");
+		ret = -EIO;
+		goto free_out;
+	}
 
-	skb_queue_walk(amsdu_list, msdu) {
-		/* Setup per-MSDU flags */
-		if (skb_queue_empty(amsdu_list))
-			rxs->flag &= ~RX_FLAG_AMSDU_MORE;
-		else
-			rxs->flag |= RX_FLAG_AMSDU_MORE;
+	rx_desc = (struct hal_rx_desc *)msdu->data;
+	lrx_desc = (struct hal_rx_desc *)last_buf->data;
+	if (!ath11k_dp_rx_h_attn_msdu_done(lrx_desc)) {
+		ath11k_warn(ar->ab, "msdu_done bit in attention is not set\n");
+		ret = -EIO;
+		goto free_out;
+	}
 
-		if (msdu == first_subframe) {
-			first_subframe = NULL;
-			rxs->flag &= ~RX_FLAG_ALLOW_SAME_PN;
-		} else {
-			rxs->flag |= RX_FLAG_ALLOW_SAME_PN;
-		}
-		rxs->flag |= RX_FLAG_SKIP_MONITOR;
+	rxcb = ATH11K_SKB_RXCB(msdu);
+	rxcb->rx_desc = rx_desc;
+	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(rx_desc);
+	l3_pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(lrx_desc);
 
-		status = IEEE80211_SKB_RXCB(msdu);
-		*status = *rxs;
+	if (rxcb->is_frag) {
+		skb_pull(msdu, HAL_RX_DESC_SIZE);
+	} else if (!rxcb->is_continuation) {
+		if ((msdu_len + HAL_RX_DESC_SIZE) > DP_RX_BUFFER_SIZE) {
+			ret = -EINVAL;
+			ath11k_warn(ar->ab, "invalid msdu len %u\n", msdu_len);
+			goto free_out;
+		}
+		skb_put(msdu, HAL_RX_DESC_SIZE + l3_pad_bytes + msdu_len);
+		skb_pull(msdu, HAL_RX_DESC_SIZE + l3_pad_bytes);
+	} else {
+		ret = ath11k_dp_rx_msdu_coalesce(ar, msdu_list,
+						 msdu, last_buf,
+						 l3_pad_bytes, msdu_len);
+		if (ret) {
+			ath11k_warn(ar->ab,
+				    "failed to coalesce msdu rx buffer%d\n", ret);
+			goto free_out;
+		}
 	}
+
+	hdr = (struct ieee80211_hdr *)msdu->data;
+
+	/* Process only data frames */
+	if (!ieee80211_is_data(hdr->frame_control))
+		return -EINVAL;
+
+	ath11k_dp_rx_h_ppdu(ar, rx_desc, &rx_status);
+	ath11k_dp_rx_h_mpdu(ar, msdu, rx_desc, &rx_status);
+
+	rx_status.flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
+
+	status = IEEE80211_SKB_RXCB(msdu);
+	*status = rx_status;
+	return 0;
+
+free_out:
+	return ret;
 }
 
-static void ath11k_dp_rx_process_pending_packets(struct ath11k_base *ab,
-						 struct napi_struct *napi,
-						 struct sk_buff_head *pending_q,
-						 int *quota, u8 mac_id)
+static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
+						  struct napi_struct *napi,
+						  struct sk_buff_head *msdu_list,
+						  int *quota, int ring_id)
 {
-	struct ath11k *ar;
+	struct ath11k_skb_rxcb *rxcb;
 	struct sk_buff *msdu;
-	struct ath11k_pdev *pdev;
+	struct ath11k *ar;
+	u8 mac_id;
+	int ret;
 
-	if (skb_queue_empty(pending_q))
+	if (skb_queue_empty(msdu_list))
 		return;
 
-	ar = ab->pdevs[mac_id].ar;
-
 	rcu_read_lock();
-	pdev = rcu_dereference(ab->pdevs_active[mac_id]);
 
-	while (*quota && (msdu = __skb_dequeue(pending_q))) {
-		if (!pdev) {
+	while (*quota && (msdu = __skb_dequeue(msdu_list))) {
+		rxcb = ATH11K_SKB_RXCB(msdu);
+		mac_id = rxcb->mac_id;
+		ar = ab->pdevs[mac_id].ar;
+		if (!rcu_dereference(ab->pdevs_active[mac_id])) {
+			dev_kfree_skb_any(msdu);
+			continue;
+		}
+
+		if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
+			dev_kfree_skb_any(msdu);
+			continue;
+		}
+
+		ret = ath11k_dp_rx_process_msdu(ar, msdu, msdu_list);
+		if (ret) {
+			ath11k_dbg(ab, ATH11K_DBG_DATA,
+				   "Unable to process msdu %d", ret);
 			dev_kfree_skb_any(msdu);
 			continue;
 		}
@@ -2357,46 +2340,31 @@ static void ath11k_dp_rx_process_pending_packets(struct ath11k_base *ab,
 		ath11k_dp_rx_deliver_msdu(ar, napi, msdu);
 		(*quota)--;
 	}
+
 	rcu_read_unlock();
 }
 
-int ath11k_dp_process_rx(struct ath11k_base *ab, int mac_id,
-			 struct napi_struct *napi, struct sk_buff_head *pending_q,
-			 int budget)
+int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
+			 struct napi_struct *napi, int budget)
 {
-	struct ath11k *ar = ab->pdevs[mac_id].ar;
-	struct ath11k_pdev_dp *dp = &ar->dp;
-	struct ieee80211_rx_status *rx_status = &dp->rx_status;
-	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
-	struct hal_srng *srng;
-	struct sk_buff *msdu;
+	struct ath11k_dp *dp = &ab->dp;
+	struct dp_rxdma_ring *rx_ring;
+	int num_buffs_reaped[MAX_RADIOS] = {0};
 	struct sk_buff_head msdu_list;
-	struct sk_buff_head amsdu_list;
 	struct ath11k_skb_rxcb *rxcb;
-	u32 *rx_desc;
-	int buf_id;
-	int num_buffs_reaped = 0;
+	int total_msdu_reaped = 0;
+	struct hal_srng *srng;
+	struct sk_buff *msdu;
 	int quota = budget;
-	int ret;
 	bool done = false;
-
-	/* Process any pending packets from the previous napi poll.
-	 * Note: All msdu's in this pending_q corresponds to the same mac id
-	 * due to pdev based reo dest mapping and also since each irq group id
-	 * maps to specific reo dest ring.
-	 */
-	ath11k_dp_rx_process_pending_packets(ab, napi, pending_q, &quota,
-					     mac_id);
-
-	/* If all quota is exhausted by processing the pending_q,
-	 * Wait for the next napi poll to reap the new info
-	 */
-	if (!quota)
-		goto exit;
+	int buf_id, mac_id;
+	struct ath11k *ar;
+	u32 *rx_desc;
+	int i;
 
 	__skb_queue_head_init(&msdu_list);
 
-	srng = &ab->hal.srng_list[dp->reo_dst_ring.ring_id];
+	srng = &ab->hal.srng_list[dp->reo_dst_ring[ring_id].ring_id];
 
 	spin_lock_bh(&srng->lock);
 
@@ -2412,6 +2380,10 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int mac_id,
 				   desc->buf_addr_info.info1);
 		buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID,
 				   cookie);
+		mac_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_PDEV_ID, cookie);
+
+		ar = ab->pdevs[mac_id].ar;
+		rx_ring = &ar->dp.rx_refill_buf_ring;
 		spin_lock_bh(&rx_ring->idr_lock);
 		msdu = idr_find(&rx_ring->bufs_idr, buf_id);
 		if (!msdu) {
@@ -2429,15 +2401,15 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int mac_id,
 				 msdu->len + skb_tailroom(msdu),
 				 DMA_FROM_DEVICE);
 
-		num_buffs_reaped++;
+		num_buffs_reaped[mac_id]++;
+		total_msdu_reaped++;
 
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
 					desc->info0);
 		if (push_reason !=
 		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
-			/* TODO: Check if the msdu can be sent up for processing */
 			dev_kfree_skb_any(msdu);
-			ab->soc_stats.hal_reo_error[dp->reo_dst_ring.ring_id]++;
+			ab->soc_stats.hal_reo_error[dp->reo_dst_ring[ring_id].ring_id]++;
 			continue;
 		}
 
@@ -2448,19 +2420,12 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int mac_id,
 		rxcb->is_continuation = !!(desc->rx_msdu_info.info0 &
 					   RX_MSDU_DESC_INFO0_MSDU_CONTINUATION);
 		rxcb->mac_id = mac_id;
+		rxcb->tid = FIELD_GET(HAL_REO_DEST_RING_INFO0_RX_QUEUE_NUM,
+				      desc->info0);
+
 		__skb_queue_tail(&msdu_list, msdu);
 
-		/* Stop reaping from the ring once quota is exhausted
-		 * and we've received all msdu's in the the AMSDU. The
-		 * additional msdu's reaped in excess of quota here would
-		 * be pushed into the pending queue to be processed during
-		 * the next napi poll.
-		 * Note: More profiling can be done to see the impact on
-		 * pending_q and throughput during various traffic & density
-		 * and how use of budget instead of remaining quota affects it.
-		 */
-		if (num_buffs_reaped >= quota && rxcb->is_last_msdu &&
-		    !rxcb->is_continuation) {
+		if (total_msdu_reaped >= quota && !rxcb->is_continuation) {
 			done = true;
 			break;
 		}
@@ -2481,58 +2446,23 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int mac_id,
 
 	spin_unlock_bh(&srng->lock);
 
-	if (!num_buffs_reaped)
+	if (!total_msdu_reaped)
 		goto exit;
 
-	/* Should we reschedule it later if we are not able to replenish all
-	 * the buffers?
-	 */
-	ath11k_dp_rxbufs_replenish(ab, mac_id, rx_ring, num_buffs_reaped,
-				   HAL_RX_BUF_RBM_SW3_BM, GFP_ATOMIC);
-
-	rcu_read_lock();
-	if (!rcu_dereference(ab->pdevs_active[mac_id])) {
-		__skb_queue_purge(&msdu_list);
-		goto rcu_unlock;
-	}
-
-	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
-		__skb_queue_purge(&msdu_list);
-		goto rcu_unlock;
-	}
-
-	while (!skb_queue_empty(&msdu_list)) {
-		__skb_queue_head_init(&amsdu_list);
-		ret = ath11k_dp_rx_retrieve_amsdu(ar, &msdu_list, &amsdu_list);
-		if (ret) {
-			if (ret == -EIO) {
-				ath11k_err(ab, "rx ring got corrupted %d\n", ret);
-				__skb_queue_purge(&msdu_list);
-				/* Should stop processing any more rx in
-				 * future from this ring?
-				 */
-				goto rcu_unlock;
-			}
-
-			/* A-MSDU retrieval got failed due to non-fatal condition,
-			 * continue processing with the next msdu.
-			 */
+	for (i = 0; i < ab->num_radios; i++) {
+		if (!num_buffs_reaped[i])
 			continue;
-		}
 
-		ath11k_dp_rx_process_amsdu(ar, &amsdu_list, rx_status);
+		ar = ab->pdevs[i].ar;
+		rx_ring = &ar->dp.rx_refill_buf_ring;
 
-		ath11k_dp_rx_pre_deliver_amsdu(ar, &amsdu_list, rx_status);
-		skb_queue_splice_tail(&amsdu_list, pending_q);
+		ath11k_dp_rxbufs_replenish(ab, i, rx_ring, num_buffs_reaped[i],
+					   HAL_RX_BUF_RBM_SW3_BM, GFP_ATOMIC);
 	}
 
-	while (quota && (msdu = __skb_dequeue(pending_q))) {
-		ath11k_dp_rx_deliver_msdu(ar, napi, msdu);
-		quota--;
-	}
+	ath11k_dp_rx_process_received_packets(ab, napi, &msdu_list,
+					      &quota, ring_id);
 
-rcu_unlock:
-	rcu_read_unlock();
 exit:
 	return budget - quota;
 }
@@ -3619,7 +3549,6 @@ static int ath11k_dp_rx_h_null_q_desc(struct ath11k *ar, struct sk_buff *msdu,
 				      struct ieee80211_rx_status *status,
 				      struct sk_buff_head *msdu_list)
 {
-	struct sk_buff_head amsdu_list;
 	u16 msdu_len;
 	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
 	u8 l3pad_bytes;
@@ -3650,8 +3579,6 @@ static int ath11k_dp_rx_h_null_q_desc(struct ath11k *ar, struct sk_buff *msdu,
 	 * This error can show up both in a REO destination or WBM release ring.
 	 */
 
-	__skb_queue_head_init(&amsdu_list);
-
 	rxcb->is_first_msdu = ath11k_dp_rx_h_msdu_end_first_msdu(desc);
 	rxcb->is_last_msdu = ath11k_dp_rx_h_msdu_end_last_msdu(desc);
 
@@ -3668,9 +3595,9 @@ static int ath11k_dp_rx_h_null_q_desc(struct ath11k *ar, struct sk_buff *msdu,
 	}
 	ath11k_dp_rx_h_ppdu(ar, desc, status);
 
-	__skb_queue_tail(&amsdu_list, msdu);
+	ath11k_dp_rx_h_mpdu(ar, msdu, desc, status);
 
-	ath11k_dp_rx_h_mpdu(ar, &amsdu_list, desc, status);
+	rxcb->tid = ath11k_dp_rx_h_mpdu_start_tid(desc);
 
 	/* Please note that caller will having the access to msdu and completing
 	 * rx with mac80211. Need not worry about cleaning up amsdu_list.
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
index 9ab535f..88bbcae 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.h
@@ -9,6 +9,8 @@
 #include "rx_desc.h"
 #include "debug.h"
 
+#define DP_MAX_NWIFI_HDR_LEN	30
+
 #define DP_RX_MPDU_ERR_FCS			BIT(0)
 #define DP_RX_MPDU_ERR_DECRYPT			BIT(1)
 #define DP_RX_MPDU_ERR_TKIP_MIC			BIT(2)
@@ -67,7 +69,7 @@ int ath11k_dp_rx_process_wbm_err(struct ath11k_base *ab,
 int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
 			     int budget);
 int ath11k_dp_process_rx(struct ath11k_base *ab, int mac_id,
-			 struct napi_struct *napi, struct sk_buff_head *pending_q,
+			 struct napi_struct *napi,
 			 int budget);
 int ath11k_dp_rxbufs_replenish(struct ath11k_base *ab, int mac_id,
 			       struct dp_rxdma_ring *rx_ring,
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8c3f973..7aac4b0 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -47,7 +47,7 @@ static u8 ath11k_dp_tx_get_tid(struct sk_buff *skb)
 		return skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 }
 
-static enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher)
+enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher)
 {
 	switch (cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 576e950..7f29b4d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2426,6 +2426,12 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			break;
 		}
 	}
+
+	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
+		peer->sec_type = ath11k_dp_tx_get_encrypt_type(key->cipher);
+	else
+		peer->sec_type_grp = ath11k_dp_tx_get_encrypt_type(key->cipher);
+
 	spin_unlock_bh(&ab->base_lock);
 
 exit:
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index f4937a0..0607479 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -145,4 +145,5 @@ void ath11k_mac_peer_cleanup_all(struct ath11k *ar);
 int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
 u8 ath11k_mac_bw_to_mac80211_bw(u8 bw);
 enum ath11k_supported_bw ath11k_mac_mac80211_bw_to_ath11k_bw(enum rate_info_bw bw);
+enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 4bf1dfa..f43deac 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -228,6 +228,9 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 	peer->sta = sta;
 	arvif->ast_hash = peer->ast_hash;
 
+	peer->sec_type = HAL_ENCRYPT_TYPE_OPEN;
+	peer->sec_type_grp = HAL_ENCRYPT_TYPE_OPEN;
+
 	ar->num_peers++;
 
 	spin_unlock_bh(&ar->ab->base_lock);
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index 55d9919..ccca152 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -24,6 +24,8 @@ struct ath11k_peer {
 	struct crypto_shash *tfm_mmic;
 	u8 mcast_keyidx;
 	u8 ucast_keyidx;
+	u16 sec_type;
+	u16 sec_type_grp;
 };
 
 void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id);
-- 
2.7.4
