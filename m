Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B821F316168
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhBJIrz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:47:55 -0500
Received: from so15.mailgun.net ([198.61.254.15]:63564 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230353AbhBJIn7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:43:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612946597; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=IvHwSIt28c/NsfAvY+Y9bCISvjBRP0OZfXAsYZlIqNY=; b=fbWq1eWNmBoAjBe74h/8Z8fKOmPY1MG8Aro/bSJNxmfHUExYYpbIssUJQZWGHiuUvWyZVreg
 PL3KEubqeGWeTKPqH1Hd3h/gDE2r25iagy7NE85E0vjcVCsCGSvRnxNOCQolrDBQzk/+0r3D
 Zf9AnWnSS+pUIy5r6PakD+X167Q=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60239c8234db06ef79f417a5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 08:42:42
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 58934C4346A; Wed, 10 Feb 2021 08:42:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0138C433CA;
        Wed, 10 Feb 2021 08:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0138C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH 08/11] ath11k: add data path support for QCN9074
Date:   Wed, 10 Feb 2021 14:12:07 +0530
Message-Id: <1612946530-28504-9-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

hal rx descriptor is different for QCN9074 target type. since
rx_msdu_end, rx_msdu_start, rx_mpdu_start elements are in
different placement/alignment. In order to have generic data path,
introduce platform specific hal rx descriptor access ops in
ath11k_hw_ops.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c    |   4 +
 drivers/net/wireless/ath/ath11k/dp_rx.c   | 476 ++++++++++++++++--------------
 drivers/net/wireless/ath/ath11k/hal.h     |   2 -
 drivers/net/wireless/ath/ath11k/hal_tx.c  |   2 +-
 drivers/net/wireless/ath/ath11k/hw.c      | 424 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h      |  29 ++
 drivers/net/wireless/ath/ath11k/pci.c     |   1 +
 drivers/net/wireless/ath/ath11k/rx_desc.h | 212 ++++++++++++-
 8 files changed, 913 insertions(+), 237 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 2d9a00d96885..a17812270c07 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -69,6 +69,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = false,
 		.cold_boot_calib = true,
 		.supports_suspend = false,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -108,6 +109,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = false,
 		.cold_boot_calib = true,
 		.supports_suspend = false,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -146,6 +148,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = true,
 		.cold_boot_calib = false,
 		.supports_suspend = true,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -175,6 +178,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = false,
 		.cold_boot_calib = false,
 		.supports_suspend = false,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 850ad38b888f..1d9aa1bb6b6e 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -20,95 +20,102 @@
 
 #define ATH11K_DP_RX_FRAGMENT_TIMEOUT_MS (2 * HZ)
 
-static u8 *ath11k_dp_rx_h_80211_hdr(struct hal_rx_desc *desc)
+static u8 *ath11k_dp_rx_h_80211_hdr(struct ath11k_base *ab, struct hal_rx_desc *desc)
 {
-	return desc->hdr_status;
+	return ab->hw_params.hw_ops->rx_desc_get_hdr_status(desc);
 }
 
-static enum hal_encrypt_type ath11k_dp_rx_h_mpdu_start_enctype(struct hal_rx_desc *desc)
+static enum hal_encrypt_type ath11k_dp_rx_h_mpdu_start_enctype(struct ath11k_base *ab,
+							       struct hal_rx_desc *desc)
 {
-	if (!(__le32_to_cpu(desc->mpdu_start.info1) &
-	    RX_MPDU_START_INFO1_ENCRYPT_INFO_VALID))
+	if (!ab->hw_params.hw_ops->rx_desc_encrypt_valid(desc))
 		return HAL_ENCRYPT_TYPE_OPEN;
 
-	return FIELD_GET(RX_MPDU_START_INFO2_ENC_TYPE,
-			 __le32_to_cpu(desc->mpdu_start.info2));
+	return ab->hw_params.hw_ops->rx_desc_get_encrypt_type(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_decap_type(struct hal_rx_desc *desc)
+static u8 ath11k_dp_rx_h_msdu_start_decap_type(struct ath11k_base *ab,
+					       struct hal_rx_desc *desc)
 {
-	return FIELD_GET(RX_MSDU_START_INFO2_DECAP_FORMAT,
-			 __le32_to_cpu(desc->msdu_start.info2));
+	return ab->hw_params.hw_ops->rx_desc_get_decap_type(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_mesh_ctl_present(struct hal_rx_desc *desc)
+static u8 ath11k_dp_rx_h_msdu_start_mesh_ctl_present(struct ath11k_base *ab,
+						     struct hal_rx_desc *desc)
 {
-	return FIELD_GET(RX_MSDU_START_INFO2_MESH_CTRL_PRESENT,
-			 __le32_to_cpu(desc->msdu_start.info2));
+	return ab->hw_params.hw_ops->rx_desc_get_mesh_ctl(desc);
 }
 
-static bool ath11k_dp_rx_h_mpdu_start_seq_ctrl_valid(struct hal_rx_desc *desc)
+static bool ath11k_dp_rx_h_mpdu_start_seq_ctrl_valid(struct ath11k_base *ab,
+						     struct hal_rx_desc *desc)
 {
-	return !!FIELD_GET(RX_MPDU_START_INFO1_MPDU_SEQ_CTRL_VALID,
-			   __le32_to_cpu(desc->mpdu_start.info1));
+	return ab->hw_params.hw_ops->rx_desc_get_mpdu_seq_ctl_vld(desc);
 }
 
-static bool ath11k_dp_rx_h_mpdu_start_fc_valid(struct hal_rx_desc *desc)
+static bool ath11k_dp_rx_h_mpdu_start_fc_valid(struct ath11k_base *ab,
+					       struct hal_rx_desc *desc)
 {
-	return !!FIELD_GET(RX_MPDU_START_INFO1_MPDU_FCTRL_VALID,
-			   __le32_to_cpu(desc->mpdu_start.info1));
+	return ab->hw_params.hw_ops->rx_desc_get_mpdu_fc_valid(desc);
 }
 
-static bool ath11k_dp_rx_h_mpdu_start_more_frags(struct sk_buff *skb)
+static bool ath11k_dp_rx_h_mpdu_start_more_frags(struct ath11k_base *ab,
+						 struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr;
 
-	hdr = (struct ieee80211_hdr *)(skb->data + HAL_RX_DESC_SIZE);
+	hdr = (struct ieee80211_hdr *)(skb->data + ab->hw_params.hal_desc_sz);
 	return ieee80211_has_morefrags(hdr->frame_control);
 }
 
-static u16 ath11k_dp_rx_h_mpdu_start_frag_no(struct sk_buff *skb)
+static u16 ath11k_dp_rx_h_mpdu_start_frag_no(struct ath11k_base *ab,
+					     struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr;
 
-	hdr = (struct ieee80211_hdr *)(skb->data + HAL_RX_DESC_SIZE);
+	hdr = (struct ieee80211_hdr *)(skb->data + ab->hw_params.hal_desc_sz);
 	return le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;
 }
 
-static u16 ath11k_dp_rx_h_mpdu_start_seq_no(struct hal_rx_desc *desc)
+static u16 ath11k_dp_rx_h_mpdu_start_seq_no(struct ath11k_base *ab,
+					    struct hal_rx_desc *desc)
 {
-	return FIELD_GET(RX_MPDU_START_INFO1_MPDU_SEQ_NUM,
-			 __le32_to_cpu(desc->mpdu_start.info1));
+	return ab->hw_params.hw_ops->rx_desc_get_mpdu_start_seq_no(desc);
 }
 
-static bool ath11k_dp_rx_h_attn_msdu_done(struct hal_rx_desc *desc)
+static void *ath11k_dp_rx_get_attention(struct ath11k_base *ab,
+					struct hal_rx_desc *desc)
+{
+	return ab->hw_params.hw_ops->rx_desc_get_attention(desc);
+}
+
+static bool ath11k_dp_rx_h_attn_msdu_done(struct rx_attention *attn)
 {
 	return !!FIELD_GET(RX_ATTENTION_INFO2_MSDU_DONE,
-			   __le32_to_cpu(desc->attention.info2));
+			   __le32_to_cpu(attn->info2));
 }
 
-static bool ath11k_dp_rx_h_attn_l4_cksum_fail(struct hal_rx_desc *desc)
+static bool ath11k_dp_rx_h_attn_l4_cksum_fail(struct rx_attention *attn)
 {
 	return !!FIELD_GET(RX_ATTENTION_INFO1_TCP_UDP_CKSUM_FAIL,
-			   __le32_to_cpu(desc->attention.info1));
+			   __le32_to_cpu(attn->info1));
 }
 
-static bool ath11k_dp_rx_h_attn_ip_cksum_fail(struct hal_rx_desc *desc)
+static bool ath11k_dp_rx_h_attn_ip_cksum_fail(struct rx_attention *attn)
 {
 	return !!FIELD_GET(RX_ATTENTION_INFO1_IP_CKSUM_FAIL,
-			   __le32_to_cpu(desc->attention.info1));
+			   __le32_to_cpu(attn->info1));
 }
 
-static bool ath11k_dp_rx_h_attn_is_decrypted(struct hal_rx_desc *desc)
+static bool ath11k_dp_rx_h_attn_is_decrypted(struct rx_attention *attn)
 {
 	return (FIELD_GET(RX_ATTENTION_INFO2_DCRYPT_STATUS_CODE,
-			  __le32_to_cpu(desc->attention.info2)) ==
+			  __le32_to_cpu(attn->info2)) ==
 		RX_DESC_DECRYPT_STATUS_CODE_OK);
 }
 
-static u32 ath11k_dp_rx_h_attn_mpdu_err(struct hal_rx_desc *desc)
+static u32 ath11k_dp_rx_h_attn_mpdu_err(struct rx_attention *attn)
 {
-	u32 info = __le32_to_cpu(desc->attention.info1);
+	u32 info = __le32_to_cpu(attn->info1);
 	u32 errmap = 0;
 
 	if (info & RX_ATTENTION_INFO1_FCS_ERR)
@@ -135,131 +142,122 @@ static u32 ath11k_dp_rx_h_attn_mpdu_err(struct hal_rx_desc *desc)
 	return errmap;
 }
 
-static u16 ath11k_dp_rx_h_msdu_start_msdu_len(struct hal_rx_desc *desc)
+static u16 ath11k_dp_rx_h_msdu_start_msdu_len(struct ath11k_base *ab,
+					      struct hal_rx_desc *desc)
 {
-	return FIELD_GET(RX_MSDU_START_INFO1_MSDU_LENGTH,
-			 __le32_to_cpu(desc->msdu_start.info1));
+	return ab->hw_params.hw_ops->rx_desc_get_msdu_len(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_sgi(struct hal_rx_desc *desc)
+static u8 ath11k_dp_rx_h_msdu_start_sgi(struct ath11k_base *ab,
+					struct hal_rx_desc *desc)
 {
-	return FIELD_GET(RX_MSDU_START_INFO3_SGI,
-			 __le32_to_cpu(desc->msdu_start.info3));
+	return ab->hw_params.hw_ops->rx_desc_get_msdu_sgi(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_rate_mcs(struct hal_rx_desc *desc)
+static u8 ath11k_dp_rx_h_msdu_start_rate_mcs(struct ath11k_base *ab,
+					     struct hal_rx_desc *desc)
 {
-	return FIELD_GET(RX_MSDU_START_INFO3_RATE_MCS,
-			 __le32_to_cpu(desc->msdu_start.info3));
+	return ab->hw_params.hw_ops->rx_desc_get_msdu_rate_mcs(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_rx_bw(struct hal_rx_desc *desc)
+static u8 ath11k_dp_rx_h_msdu_start_rx_bw(struct ath11k_base *ab,
+					  struct hal_rx_desc *desc)
 {
-	return FIELD_GET(RX_MSDU_START_INFO3_RECV_BW,
-			 __le32_to_cpu(desc->msdu_start.info3));
+	return ab->hw_params.hw_ops->rx_desc_get_msdu_rx_bw(desc);
 }
 
-static u32 ath11k_dp_rx_h_msdu_start_freq(struct hal_rx_desc *desc)
+static u32 ath11k_dp_rx_h_msdu_start_freq(struct ath11k_base *ab,
+					  struct hal_rx_desc *desc)
 {
-	return __le32_to_cpu(desc->msdu_start.phy_meta_data);
+	return ab->hw_params.hw_ops->rx_desc_get_msdu_freq(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_pkt_type(struct hal_rx_desc *desc)
+static u8 ath11k_dp_rx_h_msdu_start_pkt_type(struct ath11k_base *ab,
+					     struct hal_rx_desc *desc)
 {
-	return FIELD_GET(RX_MSDU_START_INFO3_PKT_TYPE,
-			 __le32_to_cpu(desc->msdu_start.info3));
+	return ab->hw_params.hw_ops->rx_desc_get_msdu_pkt_type(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_nss(struct hal_rx_desc *desc)
+static u8 ath11k_dp_rx_h_msdu_start_nss(struct ath11k_base *ab,
+					struct hal_rx_desc *desc)
 {
-	u8 mimo_ss_bitmap = FIELD_GET(RX_MSDU_START_INFO3_MIMO_SS_BITMAP,
-				      __le32_to_cpu(desc->msdu_start.info3));
-
-	return hweight8(mimo_ss_bitmap);
+	return hweight8(ab->hw_params.hw_ops->rx_desc_get_msdu_nss(desc));
 }
 
-static u8 ath11k_dp_rx_h_mpdu_start_tid(struct hal_rx_desc *desc)
+static u8 ath11k_dp_rx_h_mpdu_start_tid(struct ath11k_base *ab,
+					struct hal_rx_desc *desc)
 {
-	return FIELD_GET(RX_MPDU_START_INFO2_TID,
-			 __le32_to_cpu(desc->mpdu_start.info2));
+	return ab->hw_params.hw_ops->rx_desc_get_mpdu_tid(desc);
 }
 
-static u16 ath11k_dp_rx_h_mpdu_start_peer_id(struct hal_rx_desc *desc)
+static u16 ath11k_dp_rx_h_mpdu_start_peer_id(struct ath11k_base *ab,
+					     struct hal_rx_desc *desc)
 {
-	return __le16_to_cpu(desc->mpdu_start.sw_peer_id);
+	return ab->hw_params.hw_ops->rx_desc_get_mpdu_peer_id(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_end_l3pad(struct hal_rx_desc *desc)
+static u8 ath11k_dp_rx_h_msdu_end_l3pad(struct ath11k_base *ab,
+					struct hal_rx_desc *desc)
 {
-	return FIELD_GET(RX_MSDU_END_INFO2_L3_HDR_PADDING,
-			 __le32_to_cpu(desc->msdu_end.info2));
+	return ab->hw_params.hw_ops->rx_desc_get_l3_pad_bytes(desc);
 }
 
-static bool ath11k_dp_rx_h_msdu_end_first_msdu(struct hal_rx_desc *desc)
+static bool ath11k_dp_rx_h_msdu_end_first_msdu(struct ath11k_base *ab,
+					       struct hal_rx_desc *desc)
 {
-	return !!FIELD_GET(RX_MSDU_END_INFO2_FIRST_MSDU,
-			   __le32_to_cpu(desc->msdu_end.info2));
+	return ab->hw_params.hw_ops->rx_desc_get_first_msdu(desc);
 }
 
-static bool ath11k_dp_rx_h_msdu_end_last_msdu(struct hal_rx_desc *desc)
+static bool ath11k_dp_rx_h_msdu_end_last_msdu(struct ath11k_base *ab,
+					      struct hal_rx_desc *desc)
 {
-	return !!FIELD_GET(RX_MSDU_END_INFO2_LAST_MSDU,
-			   __le32_to_cpu(desc->msdu_end.info2));
+	return ab->hw_params.hw_ops->rx_desc_get_last_msdu(desc);
 }
 
-static void ath11k_dp_rx_desc_end_tlv_copy(struct hal_rx_desc *fdesc,
+static void ath11k_dp_rx_desc_end_tlv_copy(struct ath11k_base *ab,
+					   struct hal_rx_desc *fdesc,
 					   struct hal_rx_desc *ldesc)
 {
-	memcpy((u8 *)&fdesc->msdu_end, (u8 *)&ldesc->msdu_end,
-	       sizeof(struct rx_msdu_end));
-	memcpy((u8 *)&fdesc->attention, (u8 *)&ldesc->attention,
-	       sizeof(struct rx_attention));
-	memcpy((u8 *)&fdesc->mpdu_end, (u8 *)&ldesc->mpdu_end,
-	       sizeof(struct rx_mpdu_end));
+	ab->hw_params.hw_ops->rx_desc_copy_attn_end_tlv(fdesc, ldesc);
 }
 
-static u32 ath11k_dp_rxdesc_get_mpdulen_err(struct hal_rx_desc *rx_desc)
+static u32 ath11k_dp_rxdesc_get_mpdulen_err(struct rx_attention *attn)
 {
-	struct rx_attention *rx_attn;
-
-	rx_attn = &rx_desc->attention;
-
 	return FIELD_GET(RX_ATTENTION_INFO1_MPDU_LEN_ERR,
-			 __le32_to_cpu(rx_attn->info1));
+			 __le32_to_cpu(attn->info1));
 }
 
-static u32 ath11k_dp_rxdesc_get_decap_format(struct hal_rx_desc *rx_desc)
-{
-	struct rx_msdu_start *rx_msdu_start;
-
-	rx_msdu_start = &rx_desc->msdu_start;
-
-	return FIELD_GET(RX_MSDU_START_INFO2_DECAP_FORMAT,
-			 __le32_to_cpu(rx_msdu_start->info2));
-}
-
-static u8 *ath11k_dp_rxdesc_get_80211hdr(struct hal_rx_desc *rx_desc)
+static u8 *ath11k_dp_rxdesc_get_80211hdr(struct ath11k_base *ab,
+					 struct hal_rx_desc *rx_desc)
 {
 	u8 *rx_pkt_hdr;
 
-	rx_pkt_hdr = &rx_desc->msdu_payload[0];
+	rx_pkt_hdr = ab->hw_params.hw_ops->rx_desc_get_msdu_payload(rx_desc);
 
 	return rx_pkt_hdr;
 }
 
-static bool ath11k_dp_rxdesc_mpdu_valid(struct hal_rx_desc *rx_desc)
+static bool ath11k_dp_rxdesc_mpdu_valid(struct ath11k_base *ab,
+					struct hal_rx_desc *rx_desc)
 {
 	u32 tlv_tag;
 
-	tlv_tag = FIELD_GET(HAL_TLV_HDR_TAG,
-			    __le32_to_cpu(rx_desc->mpdu_start_tag));
+	tlv_tag = ab->hw_params.hw_ops->rx_desc_get_mpdu_start_tag(rx_desc);
 
 	return tlv_tag == HAL_RX_MPDU_START;
 }
 
-static u32 ath11k_dp_rxdesc_get_ppduid(struct hal_rx_desc *rx_desc)
+static u32 ath11k_dp_rxdesc_get_ppduid(struct ath11k_base *ab,
+				       struct hal_rx_desc *rx_desc)
+{
+	return ab->hw_params.hw_ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
+}
+
+static void ath11k_dp_rxdesc_set_msdu_len(struct ath11k_base *ab,
+					  struct hal_rx_desc *desc,
+					  u16 len)
 {
-	return __le16_to_cpu(rx_desc->mpdu_start.phy_ppdu_id);
+	ab->hw_params.hw_ops->rx_desc_set_msdu_len(desc, len);
 }
 
 static void ath11k_dp_service_mon_ring(struct timer_list *t)
@@ -1722,19 +1720,19 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
 				      struct sk_buff *first, struct sk_buff *last,
 				      u8 l3pad_bytes, int msdu_len)
 {
+	struct ath11k_base *ab = ar->ab;
 	struct sk_buff *skb;
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(first);
 	int buf_first_hdr_len, buf_first_len;
 	struct hal_rx_desc *ldesc;
-	int space_extra;
-	int rem_len;
-	int buf_len;
+	int space_extra, rem_len, buf_len;
+	u32 hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
 
 	/* As the msdu is spread across multiple rx buffers,
 	 * find the offset to the start of msdu for computing
 	 * the length of the msdu in the first buffer.
 	 */
-	buf_first_hdr_len = HAL_RX_DESC_SIZE + l3pad_bytes;
+	buf_first_hdr_len = hal_rx_desc_sz + l3pad_bytes;
 	buf_first_len = DP_RX_BUFFER_SIZE - buf_first_hdr_len;
 
 	if (WARN_ON_ONCE(msdu_len <= buf_first_len)) {
@@ -1744,8 +1742,8 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
 	}
 
 	ldesc = (struct hal_rx_desc *)last->data;
-	rxcb->is_first_msdu = ath11k_dp_rx_h_msdu_end_first_msdu(ldesc);
-	rxcb->is_last_msdu = ath11k_dp_rx_h_msdu_end_last_msdu(ldesc);
+	rxcb->is_first_msdu = ath11k_dp_rx_h_msdu_end_first_msdu(ab, ldesc);
+	rxcb->is_last_msdu = ath11k_dp_rx_h_msdu_end_last_msdu(ab, ldesc);
 
 	/* MSDU spans over multiple buffers because the length of the MSDU
 	 * exceeds DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE. So assume the data
@@ -1757,7 +1755,7 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
 	/* When an MSDU spread over multiple buffers attention, MSDU_END and
 	 * MPDU_END tlvs are valid only in the last buffer. Copy those tlvs.
 	 */
-	ath11k_dp_rx_desc_end_tlv_copy(rxcb->rx_desc, ldesc);
+	ath11k_dp_rx_desc_end_tlv_copy(ab, rxcb->rx_desc, ldesc);
 
 	space_extra = msdu_len - (buf_first_len + skb_tailroom(first));
 	if (space_extra > 0 &&
@@ -1778,18 +1776,18 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
 	while ((skb = __skb_dequeue(msdu_list)) != NULL && rem_len > 0) {
 		rxcb = ATH11K_SKB_RXCB(skb);
 		if (rxcb->is_continuation)
-			buf_len = DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE;
+			buf_len = DP_RX_BUFFER_SIZE - hal_rx_desc_sz;
 		else
 			buf_len = rem_len;
 
-		if (buf_len > (DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE)) {
+		if (buf_len > (DP_RX_BUFFER_SIZE - hal_rx_desc_sz)) {
 			WARN_ON_ONCE(1);
 			dev_kfree_skb_any(skb);
 			return -EINVAL;
 		}
 
-		skb_put(skb, buf_len + HAL_RX_DESC_SIZE);
-		skb_pull(skb, HAL_RX_DESC_SIZE);
+		skb_put(skb, buf_len + hal_rx_desc_sz);
+		skb_pull(skb, hal_rx_desc_sz);
 		skb_copy_from_linear_data(skb, skb_put(first, buf_len),
 					  buf_len);
 		dev_kfree_skb_any(skb);
@@ -1820,13 +1818,15 @@ static struct sk_buff *ath11k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_
 	return NULL;
 }
 
-static void ath11k_dp_rx_h_csum_offload(struct sk_buff *msdu)
+static void ath11k_dp_rx_h_csum_offload(struct ath11k *ar, struct sk_buff *msdu)
 {
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
+	struct rx_attention *rx_attention;
 	bool ip_csum_fail, l4_csum_fail;
 
-	ip_csum_fail = ath11k_dp_rx_h_attn_ip_cksum_fail(rxcb->rx_desc);
-	l4_csum_fail = ath11k_dp_rx_h_attn_l4_cksum_fail(rxcb->rx_desc);
+	rx_attention = ath11k_dp_rx_get_attention(ar->ab, rxcb->rx_desc);
+	ip_csum_fail = ath11k_dp_rx_h_attn_ip_cksum_fail(rx_attention);
+	l4_csum_fail = ath11k_dp_rx_h_attn_l4_cksum_fail(rx_attention);
 
 	msdu->ip_summed = (ip_csum_fail || l4_csum_fail) ?
 			  CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
@@ -1957,7 +1957,7 @@ static void ath11k_dp_rx_h_undecap_nwifi(struct ath11k *ar,
 
 		qos_ctl = rxcb->tid;
 
-		if (ath11k_dp_rx_h_msdu_start_mesh_ctl_present(rxcb->rx_desc))
+		if (ath11k_dp_rx_h_msdu_start_mesh_ctl_present(ar->ab, rxcb->rx_desc))
 			qos_ctl |= IEEE80211_QOS_CTL_MESH_CONTROL_PRESENT;
 
 		/* TODO Add other QoS ctl fields when required */
@@ -2061,7 +2061,7 @@ static void *ath11k_dp_rx_h_find_rfc1042(struct ath11k *ar,
 	bool is_amsdu;
 
 	is_amsdu = !(rxcb->is_first_msdu && rxcb->is_last_msdu);
-	hdr = (struct ieee80211_hdr *)ath11k_dp_rx_h_80211_hdr(rxcb->rx_desc);
+	hdr = (struct ieee80211_hdr *)ath11k_dp_rx_h_80211_hdr(ar->ab, rxcb->rx_desc);
 	rfc1042 = hdr;
 
 	if (rxcb->is_first_msdu) {
@@ -2134,8 +2134,8 @@ static void ath11k_dp_rx_h_undecap(struct ath11k *ar, struct sk_buff *msdu,
 	u8 *first_hdr;
 	u8 decap;
 
-	first_hdr = ath11k_dp_rx_h_80211_hdr(rx_desc);
-	decap = ath11k_dp_rx_h_msdu_start_decap_type(rx_desc);
+	first_hdr = ath11k_dp_rx_h_80211_hdr(ar->ab, rx_desc);
+	decap = ath11k_dp_rx_h_msdu_start_decap_type(ar->ab, rx_desc);
 
 	switch (decap) {
 	case DP_RX_DECAP_TYPE_NATIVE_WIFI:
@@ -2167,6 +2167,7 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 	bool is_decrypted = false;
 	struct ieee80211_hdr *hdr;
 	struct ath11k_peer *peer;
+	struct rx_attention *rx_attention;
 	u32 err_bitmap;
 
 	hdr = (struct ieee80211_hdr *)msdu->data;
@@ -2188,9 +2189,10 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 	}
 	spin_unlock_bh(&ar->ab->base_lock);
 
-	err_bitmap = ath11k_dp_rx_h_attn_mpdu_err(rx_desc);
+	rx_attention = ath11k_dp_rx_get_attention(ar->ab, rx_desc);
+	err_bitmap = ath11k_dp_rx_h_attn_mpdu_err(rx_attention);
 	if (enctype != HAL_ENCRYPT_TYPE_OPEN && !err_bitmap)
-		is_decrypted = ath11k_dp_rx_h_attn_is_decrypted(rx_desc);
+		is_decrypted = ath11k_dp_rx_h_attn_is_decrypted(rx_attention);
 
 	/* Clear per-MPDU flags while leaving per-PPDU flags intact */
 	rx_status->flag &= ~(RX_FLAG_FAILED_FCS_CRC |
@@ -2215,7 +2217,7 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 					   RX_FLAG_PN_VALIDATED;
 	}
 
-	ath11k_dp_rx_h_csum_offload(msdu);
+	ath11k_dp_rx_h_csum_offload(ar, msdu);
 	ath11k_dp_rx_h_undecap(ar, msdu, rx_desc,
 			       enctype, rx_status, is_decrypted);
 
@@ -2236,11 +2238,11 @@ static void ath11k_dp_rx_h_rate(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 	u8 sgi;
 	bool is_cck;
 
-	pkt_type = ath11k_dp_rx_h_msdu_start_pkt_type(rx_desc);
-	bw = ath11k_dp_rx_h_msdu_start_rx_bw(rx_desc);
-	rate_mcs = ath11k_dp_rx_h_msdu_start_rate_mcs(rx_desc);
-	nss = ath11k_dp_rx_h_msdu_start_nss(rx_desc);
-	sgi = ath11k_dp_rx_h_msdu_start_sgi(rx_desc);
+	pkt_type = ath11k_dp_rx_h_msdu_start_pkt_type(ar->ab, rx_desc);
+	bw = ath11k_dp_rx_h_msdu_start_rx_bw(ar->ab, rx_desc);
+	rate_mcs = ath11k_dp_rx_h_msdu_start_rate_mcs(ar->ab, rx_desc);
+	nss = ath11k_dp_rx_h_msdu_start_nss(ar->ab, rx_desc);
+	sgi = ath11k_dp_rx_h_msdu_start_sgi(ar->ab, rx_desc);
 
 	switch (pkt_type) {
 	case RX_MSDU_START_PKT_TYPE_11A:
@@ -2297,7 +2299,7 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 				struct ieee80211_rx_status *rx_status)
 {
 	u8 channel_num;
-	u32 center_freq;
+	u32 center_freq, meta_data;
 	struct ieee80211_channel *channel;
 
 	rx_status->freq = 0;
@@ -2308,8 +2310,9 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 
 	rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 
-	channel_num = ath11k_dp_rx_h_msdu_start_freq(rx_desc);
-	center_freq = ath11k_dp_rx_h_msdu_start_freq(rx_desc) >> 16;
+	meta_data = ath11k_dp_rx_h_msdu_start_freq(ar->ab, rx_desc);
+	channel_num = meta_data;
+	center_freq = meta_data >> 16;
 
 	if (center_freq >= 5935 && center_freq <= 7105) {
 		rx_status->band = NL80211_BAND_6GHZ;
@@ -2409,7 +2412,9 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 				     struct sk_buff *msdu,
 				     struct sk_buff_head *msdu_list)
 {
+	struct ath11k_base *ab = ar->ab;
 	struct hal_rx_desc *rx_desc, *lrx_desc;
+	struct rx_attention *rx_attention;
 	struct ieee80211_rx_status rx_status = {0};
 	struct ieee80211_rx_status *status;
 	struct ath11k_skb_rxcb *rxcb;
@@ -2419,10 +2424,11 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 	u8 *hdr_status;
 	u16 msdu_len;
 	int ret;
+	u32 hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
 
 	last_buf = ath11k_dp_rx_get_msdu_last_buf(msdu_list, msdu);
 	if (!last_buf) {
-		ath11k_warn(ar->ab,
+		ath11k_warn(ab,
 			    "No valid Rx buffer to access Atten/MSDU_END/MPDU_END tlvs\n");
 		ret = -EIO;
 		goto free_out;
@@ -2430,38 +2436,39 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 
 	rx_desc = (struct hal_rx_desc *)msdu->data;
 	lrx_desc = (struct hal_rx_desc *)last_buf->data;
-	if (!ath11k_dp_rx_h_attn_msdu_done(lrx_desc)) {
-		ath11k_warn(ar->ab, "msdu_done bit in attention is not set\n");
+	rx_attention = ath11k_dp_rx_get_attention(ab, lrx_desc);
+	if (!ath11k_dp_rx_h_attn_msdu_done(rx_attention)) {
+		ath11k_warn(ab, "msdu_done bit in attention is not set\n");
 		ret = -EIO;
 		goto free_out;
 	}
 
 	rxcb = ATH11K_SKB_RXCB(msdu);
 	rxcb->rx_desc = rx_desc;
-	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(rx_desc);
-	l3_pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(lrx_desc);
+	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(ab, rx_desc);
+	l3_pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(ab, lrx_desc);
 
 	if (rxcb->is_frag) {
-		skb_pull(msdu, HAL_RX_DESC_SIZE);
+		skb_pull(msdu, hal_rx_desc_sz);
 	} else if (!rxcb->is_continuation) {
-		if ((msdu_len + HAL_RX_DESC_SIZE) > DP_RX_BUFFER_SIZE) {
-			hdr_status = ath11k_dp_rx_h_80211_hdr(rx_desc);
+		if ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE) {
+			hdr_status = ath11k_dp_rx_h_80211_hdr(ab, rx_desc);
 			ret = -EINVAL;
-			ath11k_warn(ar->ab, "invalid msdu len %u\n", msdu_len);
-			ath11k_dbg_dump(ar->ab, ATH11K_DBG_DATA, NULL, "", hdr_status,
+			ath11k_warn(ab, "invalid msdu len %u\n", msdu_len);
+			ath11k_dbg_dump(ab, ATH11K_DBG_DATA, NULL, "", hdr_status,
 					sizeof(struct ieee80211_hdr));
-			ath11k_dbg_dump(ar->ab, ATH11K_DBG_DATA, NULL, "", rx_desc,
+			ath11k_dbg_dump(ab, ATH11K_DBG_DATA, NULL, "", rx_desc,
 					sizeof(struct hal_rx_desc));
 			goto free_out;
 		}
-		skb_put(msdu, HAL_RX_DESC_SIZE + l3_pad_bytes + msdu_len);
-		skb_pull(msdu, HAL_RX_DESC_SIZE + l3_pad_bytes);
+		skb_put(msdu, hal_rx_desc_sz + l3_pad_bytes + msdu_len);
+		skb_pull(msdu, hal_rx_desc_sz + l3_pad_bytes);
 	} else {
 		ret = ath11k_dp_rx_msdu_coalesce(ar, msdu_list,
 						 msdu, last_buf,
 						 l3_pad_bytes, msdu_len);
 		if (ret) {
-			ath11k_warn(ar->ab,
+			ath11k_warn(ab,
 				    "failed to coalesce msdu rx buffer%d\n", ret);
 			goto free_out;
 		}
@@ -3090,16 +3097,17 @@ static int ath11k_dp_rx_h_verify_tkip_mic(struct ath11k *ar, struct ath11k_peer
 	u8 mic[IEEE80211_CCMP_MIC_LEN];
 	int head_len, tail_len, ret;
 	size_t data_len;
-	u32 hdr_len;
+	u32 hdr_len, hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
 	u8 *key, *data;
 	u8 key_idx;
 
-	if (ath11k_dp_rx_h_mpdu_start_enctype(rx_desc) != HAL_ENCRYPT_TYPE_TKIP_MIC)
+	if (ath11k_dp_rx_h_mpdu_start_enctype(ar->ab, rx_desc) !=
+	    HAL_ENCRYPT_TYPE_TKIP_MIC)
 		return 0;
 
-	hdr = (struct ieee80211_hdr *)(msdu->data + HAL_RX_DESC_SIZE);
+	hdr = (struct ieee80211_hdr *)(msdu->data + hal_rx_desc_sz);
 	hdr_len = ieee80211_hdrlen(hdr->frame_control);
-	head_len = hdr_len + HAL_RX_DESC_SIZE + IEEE80211_TKIP_IV_LEN;
+	head_len = hdr_len + hal_rx_desc_sz + IEEE80211_TKIP_IV_LEN;
 	tail_len = IEEE80211_CCMP_MIC_LEN + IEEE80211_TKIP_ICV_LEN + FCS_LEN;
 
 	if (!is_multicast_ether_addr(hdr->addr1))
@@ -3125,7 +3133,7 @@ static int ath11k_dp_rx_h_verify_tkip_mic(struct ath11k *ar, struct ath11k_peer
 
 	rxs->flag |= RX_FLAG_MMIC_ERROR | RX_FLAG_MMIC_STRIPPED |
 		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
-	skb_pull(msdu, HAL_RX_DESC_SIZE);
+	skb_pull(msdu, hal_rx_desc_sz);
 
 	ath11k_dp_rx_h_ppdu(ar, rx_desc, rxs);
 	ath11k_dp_rx_h_undecap(ar, msdu, rx_desc,
@@ -3140,11 +3148,12 @@ static void ath11k_dp_rx_h_undecap_frag(struct ath11k *ar, struct sk_buff *msdu,
 	struct ieee80211_hdr *hdr;
 	size_t hdr_len;
 	size_t crypto_len;
+	u32 hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
 
 	if (!flags)
 		return;
 
-	hdr = (struct ieee80211_hdr *)(msdu->data + HAL_RX_DESC_SIZE);
+	hdr = (struct ieee80211_hdr *)(msdu->data + hal_rx_desc_sz);
 
 	if (flags & RX_FLAG_MIC_STRIPPED)
 		skb_trim(msdu, msdu->len -
@@ -3158,8 +3167,8 @@ static void ath11k_dp_rx_h_undecap_frag(struct ath11k *ar, struct sk_buff *msdu,
 		hdr_len = ieee80211_hdrlen(hdr->frame_control);
 		crypto_len = ath11k_dp_rx_crypto_param_len(ar, enctype);
 
-		memmove((void *)msdu->data + HAL_RX_DESC_SIZE + crypto_len,
-			(void *)msdu->data + HAL_RX_DESC_SIZE, hdr_len);
+		memmove((void *)msdu->data + hal_rx_desc_sz + crypto_len,
+			(void *)msdu->data + hal_rx_desc_sz, hdr_len);
 		skb_pull(msdu, crypto_len);
 	}
 }
@@ -3172,11 +3181,12 @@ static int ath11k_dp_rx_h_defrag(struct ath11k *ar,
 	struct hal_rx_desc *rx_desc;
 	struct sk_buff *skb, *first_frag, *last_frag;
 	struct ieee80211_hdr *hdr;
+	struct rx_attention *rx_attention;
 	enum hal_encrypt_type enctype;
 	bool is_decrypted = false;
 	int msdu_len = 0;
 	int extra_space;
-	u32 flags;
+	u32 flags, hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
 
 	first_frag = skb_peek(&rx_tid->rx_frags);
 	last_frag = skb_peek_tail(&rx_tid->rx_frags);
@@ -3184,11 +3194,13 @@ static int ath11k_dp_rx_h_defrag(struct ath11k *ar,
 	skb_queue_walk(&rx_tid->rx_frags, skb) {
 		flags = 0;
 		rx_desc = (struct hal_rx_desc *)skb->data;
-		hdr = (struct ieee80211_hdr *)(skb->data + HAL_RX_DESC_SIZE);
+		hdr = (struct ieee80211_hdr *)(skb->data + hal_rx_desc_sz);
 
-		enctype = ath11k_dp_rx_h_mpdu_start_enctype(rx_desc);
-		if (enctype != HAL_ENCRYPT_TYPE_OPEN)
-			is_decrypted = ath11k_dp_rx_h_attn_is_decrypted(rx_desc);
+		enctype = ath11k_dp_rx_h_mpdu_start_enctype(ar->ab, rx_desc);
+		if (enctype != HAL_ENCRYPT_TYPE_OPEN) {
+			rx_attention = ath11k_dp_rx_get_attention(ar->ab, rx_desc);
+			is_decrypted = ath11k_dp_rx_h_attn_is_decrypted(rx_attention);
+		}
 
 		if (is_decrypted) {
 			if (skb != first_frag)
@@ -3204,7 +3216,7 @@ static int ath11k_dp_rx_h_defrag(struct ath11k *ar,
 		ath11k_dp_rx_h_undecap_frag(ar, skb, enctype, flags);
 
 		if (skb != first_frag)
-			skb_pull(skb, HAL_RX_DESC_SIZE +
+			skb_pull(skb, hal_rx_desc_sz +
 				      ieee80211_hdrlen(hdr->frame_control));
 		msdu_len += skb->len;
 	}
@@ -3220,7 +3232,7 @@ static int ath11k_dp_rx_h_defrag(struct ath11k *ar,
 		dev_kfree_skb_any(skb);
 	}
 
-	hdr = (struct ieee80211_hdr *)(first_frag->data + HAL_RX_DESC_SIZE);
+	hdr = (struct ieee80211_hdr *)(first_frag->data + hal_rx_desc_sz);
 	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_MOREFRAGS);
 	ATH11K_SKB_RXCB(first_frag)->is_frag = 1;
 
@@ -3246,10 +3258,10 @@ static int ath11k_dp_rx_h_defrag_reo_reinject(struct ath11k *ar, struct dp_rx_ti
 	struct hal_srng *srng;
 	dma_addr_t paddr;
 	u32 desc_bank, msdu_info, mpdu_info;
-	u32 dst_idx, cookie;
-	u32 *msdu_len_offset;
+	u32 dst_idx, cookie, hal_rx_desc_sz;
 	int ret, buf_id;
 
+	hal_rx_desc_sz = ab->hw_params.hal_desc_sz;
 	link_desc_banks = ab->dp.link_desc_banks;
 	reo_dest_ring = rx_tid->dst_ring_desc;
 
@@ -3264,16 +3276,14 @@ static int ath11k_dp_rx_h_defrag_reo_reinject(struct ath11k *ar, struct dp_rx_ti
 		    FIELD_PREP(RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU, 1) |
 		    FIELD_PREP(RX_MSDU_DESC_INFO0_MSDU_CONTINUATION, 0) |
 		    FIELD_PREP(RX_MSDU_DESC_INFO0_MSDU_LENGTH,
-			       defrag_skb->len - HAL_RX_DESC_SIZE) |
+			       defrag_skb->len - hal_rx_desc_sz) |
 		    FIELD_PREP(RX_MSDU_DESC_INFO0_REO_DEST_IND, dst_idx) |
 		    FIELD_PREP(RX_MSDU_DESC_INFO0_VALID_SA, 1) |
 		    FIELD_PREP(RX_MSDU_DESC_INFO0_VALID_DA, 1);
 	msdu0->rx_msdu_info.info0 = msdu_info;
 
 	/* change msdu len in hal rx desc */
-	msdu_len_offset = (u32 *)&rx_desc->msdu_start;
-	*msdu_len_offset &= ~(RX_MSDU_START_INFO1_MSDU_LENGTH);
-	*msdu_len_offset |= defrag_skb->len - HAL_RX_DESC_SIZE;
+	ath11k_dp_rxdesc_set_msdu_len(ab, rx_desc, defrag_skb->len - hal_rx_desc_sz);
 
 	paddr = dma_map_single(ab->dev, defrag_skb->data,
 			       defrag_skb->len + skb_tailroom(defrag_skb),
@@ -3346,24 +3356,26 @@ static int ath11k_dp_rx_h_defrag_reo_reinject(struct ath11k *ar, struct dp_rx_ti
 	return ret;
 }
 
-static int ath11k_dp_rx_h_cmp_frags(struct sk_buff *a, struct sk_buff *b)
+static int ath11k_dp_rx_h_cmp_frags(struct ath11k *ar,
+				    struct sk_buff *a, struct sk_buff *b)
 {
 	int frag1, frag2;
 
-	frag1 = ath11k_dp_rx_h_mpdu_start_frag_no(a);
-	frag2 = ath11k_dp_rx_h_mpdu_start_frag_no(b);
+	frag1 = ath11k_dp_rx_h_mpdu_start_frag_no(ar->ab, a);
+	frag2 = ath11k_dp_rx_h_mpdu_start_frag_no(ar->ab, b);
 
 	return frag1 - frag2;
 }
 
-static void ath11k_dp_rx_h_sort_frags(struct sk_buff_head *frag_list,
+static void ath11k_dp_rx_h_sort_frags(struct ath11k *ar,
+				      struct sk_buff_head *frag_list,
 				      struct sk_buff *cur_frag)
 {
 	struct sk_buff *skb;
 	int cmp;
 
 	skb_queue_walk(frag_list, skb) {
-		cmp = ath11k_dp_rx_h_cmp_frags(skb, cur_frag);
+		cmp = ath11k_dp_rx_h_cmp_frags(ar, skb, cur_frag);
 		if (cmp < 0)
 			continue;
 		__skb_queue_before(frag_list, skb, cur_frag);
@@ -3372,14 +3384,15 @@ static void ath11k_dp_rx_h_sort_frags(struct sk_buff_head *frag_list,
 	__skb_queue_tail(frag_list, cur_frag);
 }
 
-static u64 ath11k_dp_rx_h_get_pn(struct sk_buff *skb)
+static u64 ath11k_dp_rx_h_get_pn(struct ath11k *ar, struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr;
 	u64 pn = 0;
 	u8 *ehdr;
+	u32 hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
 
-	hdr = (struct ieee80211_hdr *)(skb->data + HAL_RX_DESC_SIZE);
-	ehdr = skb->data + HAL_RX_DESC_SIZE + ieee80211_hdrlen(hdr->frame_control);
+	hdr = (struct ieee80211_hdr *)(skb->data + hal_rx_desc_sz);
+	ehdr = skb->data + hal_rx_desc_sz + ieee80211_hdrlen(hdr->frame_control);
 
 	pn = ehdr[0];
 	pn |= (u64)ehdr[1] << 8;
@@ -3403,19 +3416,19 @@ ath11k_dp_rx_h_defrag_validate_incr_pn(struct ath11k *ar, struct dp_rx_tid *rx_t
 	first_frag = skb_peek(&rx_tid->rx_frags);
 	desc = (struct hal_rx_desc *)first_frag->data;
 
-	encrypt_type = ath11k_dp_rx_h_mpdu_start_enctype(desc);
+	encrypt_type = ath11k_dp_rx_h_mpdu_start_enctype(ar->ab, desc);
 	if (encrypt_type != HAL_ENCRYPT_TYPE_CCMP_128 &&
 	    encrypt_type != HAL_ENCRYPT_TYPE_CCMP_256 &&
 	    encrypt_type != HAL_ENCRYPT_TYPE_GCMP_128 &&
 	    encrypt_type != HAL_ENCRYPT_TYPE_AES_GCMP_256)
 		return true;
 
-	last_pn = ath11k_dp_rx_h_get_pn(first_frag);
+	last_pn = ath11k_dp_rx_h_get_pn(ar, first_frag);
 	skb_queue_walk(&rx_tid->rx_frags, skb) {
 		if (skb == first_frag)
 			continue;
 
-		cur_pn = ath11k_dp_rx_h_get_pn(skb);
+		cur_pn = ath11k_dp_rx_h_get_pn(ar, skb);
 		if (cur_pn != last_pn + 1)
 			return false;
 		last_pn = cur_pn;
@@ -3439,14 +3452,14 @@ static int ath11k_dp_rx_frag_h_mpdu(struct ath11k *ar,
 	bool more_frags;
 
 	rx_desc = (struct hal_rx_desc *)msdu->data;
-	peer_id = ath11k_dp_rx_h_mpdu_start_peer_id(rx_desc);
-	tid = ath11k_dp_rx_h_mpdu_start_tid(rx_desc);
-	seqno = ath11k_dp_rx_h_mpdu_start_seq_no(rx_desc);
-	frag_no = ath11k_dp_rx_h_mpdu_start_frag_no(msdu);
-	more_frags = ath11k_dp_rx_h_mpdu_start_more_frags(msdu);
-
-	if (!ath11k_dp_rx_h_mpdu_start_seq_ctrl_valid(rx_desc) ||
-	    !ath11k_dp_rx_h_mpdu_start_fc_valid(rx_desc) ||
+	peer_id = ath11k_dp_rx_h_mpdu_start_peer_id(ar->ab, rx_desc);
+	tid = ath11k_dp_rx_h_mpdu_start_tid(ar->ab, rx_desc);
+	seqno = ath11k_dp_rx_h_mpdu_start_seq_no(ar->ab, rx_desc);
+	frag_no = ath11k_dp_rx_h_mpdu_start_frag_no(ar->ab, msdu);
+	more_frags = ath11k_dp_rx_h_mpdu_start_more_frags(ar->ab, msdu);
+
+	if (!ath11k_dp_rx_h_mpdu_start_seq_ctrl_valid(ar->ab, rx_desc) ||
+	    !ath11k_dp_rx_h_mpdu_start_fc_valid(ar->ab, rx_desc) ||
 	    tid > IEEE80211_NUM_TIDS)
 		return -EINVAL;
 
@@ -3484,7 +3497,7 @@ static int ath11k_dp_rx_frag_h_mpdu(struct ath11k *ar,
 	if (frag_no > __fls(rx_tid->rx_frag_bitmap))
 		__skb_queue_tail(&rx_tid->rx_frags, msdu);
 	else
-		ath11k_dp_rx_h_sort_frags(&rx_tid->rx_frags, msdu);
+		ath11k_dp_rx_h_sort_frags(ar, &rx_tid->rx_frags, msdu);
 
 	rx_tid->rx_frag_bitmap |= BIT(frag_no);
 	if (!more_frags)
@@ -3551,6 +3564,7 @@ ath11k_dp_process_rx_err_buf(struct ath11k *ar, u32 *ring_desc, int buf_id, bool
 	struct hal_rx_desc *rx_desc;
 	u8 *hdr_status;
 	u16 msdu_len;
+	u32 hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
 
 	spin_lock_bh(&rx_ring->idr_lock);
 	msdu = idr_find(&rx_ring->bufs_idr, buf_id);
@@ -3586,9 +3600,9 @@ ath11k_dp_process_rx_err_buf(struct ath11k *ar, u32 *ring_desc, int buf_id, bool
 	}
 
 	rx_desc = (struct hal_rx_desc *)msdu->data;
-	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(rx_desc);
-	if ((msdu_len + HAL_RX_DESC_SIZE) > DP_RX_BUFFER_SIZE) {
-		hdr_status = ath11k_dp_rx_h_80211_hdr(rx_desc);
+	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(ar->ab, rx_desc);
+	if ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE) {
+		hdr_status = ath11k_dp_rx_h_80211_hdr(ar->ab, rx_desc);
 		ath11k_warn(ar->ab, "invalid msdu leng %u", msdu_len);
 		ath11k_dbg_dump(ar->ab, ATH11K_DBG_DATA, NULL, "", hdr_status,
 				sizeof(struct ieee80211_hdr));
@@ -3598,7 +3612,7 @@ ath11k_dp_process_rx_err_buf(struct ath11k *ar, u32 *ring_desc, int buf_id, bool
 		goto exit;
 	}
 
-	skb_put(msdu, HAL_RX_DESC_SIZE + msdu_len);
+	skb_put(msdu, hal_rx_desc_sz + msdu_len);
 
 	if (ath11k_dp_rx_frag_h_mpdu(ar, msdu, ring_desc)) {
 		dev_kfree_skb_any(msdu);
@@ -3732,7 +3746,7 @@ static void ath11k_dp_rx_null_q_desc_sg_drop(struct ath11k *ar,
 	int n_buffs;
 
 	n_buffs = DIV_ROUND_UP(msdu_len,
-			       (DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE));
+			       (DP_RX_BUFFER_SIZE - ar->ab->hw_params.hal_desc_sz));
 
 	skb_queue_walk_safe(msdu_list, skb, tmp) {
 		rxcb = ATH11K_SKB_RXCB(skb);
@@ -3753,19 +3767,22 @@ static int ath11k_dp_rx_h_null_q_desc(struct ath11k *ar, struct sk_buff *msdu,
 {
 	u16 msdu_len;
 	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
+	struct rx_attention *rx_attention;
 	u8 l3pad_bytes;
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
+	u32 hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
 
-	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(desc);
+	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(ar->ab, desc);
 
-	if (!rxcb->is_frag && ((msdu_len + HAL_RX_DESC_SIZE) > DP_RX_BUFFER_SIZE)) {
+	if (!rxcb->is_frag && ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE)) {
 		/* First buffer will be freed by the caller, so deduct it's length */
-		msdu_len = msdu_len - (DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE);
+		msdu_len = msdu_len - (DP_RX_BUFFER_SIZE - hal_rx_desc_sz);
 		ath11k_dp_rx_null_q_desc_sg_drop(ar, msdu_len, msdu_list);
 		return -EINVAL;
 	}
 
-	if (!ath11k_dp_rx_h_attn_msdu_done(desc)) {
+	rx_attention = ath11k_dp_rx_get_attention(ar->ab, desc);
+	if (!ath11k_dp_rx_h_attn_msdu_done(rx_attention)) {
 		ath11k_warn(ar->ab,
 			    "msdu_done bit not set in null_q_des processing\n");
 		__skb_queue_purge(msdu_list);
@@ -3781,25 +3798,25 @@ static int ath11k_dp_rx_h_null_q_desc(struct ath11k *ar, struct sk_buff *msdu,
 	 * This error can show up both in a REO destination or WBM release ring.
 	 */
 
-	rxcb->is_first_msdu = ath11k_dp_rx_h_msdu_end_first_msdu(desc);
-	rxcb->is_last_msdu = ath11k_dp_rx_h_msdu_end_last_msdu(desc);
+	rxcb->is_first_msdu = ath11k_dp_rx_h_msdu_end_first_msdu(ar->ab, desc);
+	rxcb->is_last_msdu = ath11k_dp_rx_h_msdu_end_last_msdu(ar->ab, desc);
 
 	if (rxcb->is_frag) {
-		skb_pull(msdu, HAL_RX_DESC_SIZE);
+		skb_pull(msdu, hal_rx_desc_sz);
 	} else {
-		l3pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(desc);
+		l3pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, desc);
 
-		if ((HAL_RX_DESC_SIZE + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE)
+		if ((hal_rx_desc_sz + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE)
 			return -EINVAL;
 
-		skb_put(msdu, HAL_RX_DESC_SIZE + l3pad_bytes + msdu_len);
-		skb_pull(msdu, HAL_RX_DESC_SIZE + l3pad_bytes);
+		skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
+		skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 	}
 	ath11k_dp_rx_h_ppdu(ar, desc, status);
 
 	ath11k_dp_rx_h_mpdu(ar, msdu, desc, status);
 
-	rxcb->tid = ath11k_dp_rx_h_mpdu_start_tid(desc);
+	rxcb->tid = ath11k_dp_rx_h_mpdu_start_tid(ar->ab, desc);
 
 	/* Please note that caller will having the access to msdu and completing
 	 * rx with mac80211. Need not worry about cleaning up amsdu_list.
@@ -3846,14 +3863,15 @@ static void ath11k_dp_rx_h_tkip_mic_err(struct ath11k *ar, struct sk_buff *msdu,
 	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
 	u8 l3pad_bytes;
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
+	u32 hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
 
-	rxcb->is_first_msdu = ath11k_dp_rx_h_msdu_end_first_msdu(desc);
-	rxcb->is_last_msdu = ath11k_dp_rx_h_msdu_end_last_msdu(desc);
+	rxcb->is_first_msdu = ath11k_dp_rx_h_msdu_end_first_msdu(ar->ab, desc);
+	rxcb->is_last_msdu = ath11k_dp_rx_h_msdu_end_last_msdu(ar->ab, desc);
 
-	l3pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(desc);
-	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(desc);
-	skb_put(msdu, HAL_RX_DESC_SIZE + l3pad_bytes + msdu_len);
-	skb_pull(msdu, HAL_RX_DESC_SIZE + l3pad_bytes);
+	l3pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, desc);
+	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(ar->ab, desc);
+	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
+	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 
 	ath11k_dp_rx_h_ppdu(ar, desc, status);
 
@@ -4595,10 +4613,10 @@ ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
 			rx_desc = (struct hal_rx_desc *)msdu->data;
 
 			rx_pkt_offset = sizeof(struct hal_rx_desc);
-			l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad(rx_desc);
+			l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, rx_desc);
 
 			if (is_first_msdu) {
-				if (!ath11k_dp_rxdesc_mpdu_valid(rx_desc)) {
+				if (!ath11k_dp_rxdesc_mpdu_valid(ar->ab, rx_desc)) {
 					drop_mpdu = true;
 					dev_kfree_skb_any(msdu);
 					msdu = NULL;
@@ -4607,7 +4625,7 @@ ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
 				}
 
 				msdu_ppdu_id =
-					ath11k_dp_rxdesc_get_ppduid(rx_desc);
+					ath11k_dp_rxdesc_get_ppduid(ar->ab, rx_desc);
 
 				if (ath11k_dp_rx_mon_comp_ppduid(msdu_ppdu_id,
 								 ppdu_id,
@@ -4676,12 +4694,13 @@ ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
 	return rx_bufs_used;
 }
 
-static void ath11k_dp_rx_msdus_set_payload(struct sk_buff *msdu)
+static void ath11k_dp_rx_msdus_set_payload(struct ath11k *ar, struct sk_buff *msdu)
 {
 	u32 rx_pkt_offset, l2_hdr_offset;
 
-	rx_pkt_offset = sizeof(struct hal_rx_desc);
-	l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad((struct hal_rx_desc *)msdu->data);
+	rx_pkt_offset = ar->ab->hw_params.hal_desc_sz;
+	l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab,
+						      (struct hal_rx_desc *)msdu->data);
 	skb_pull(msdu, rx_pkt_offset + l2_hdr_offset);
 }
 
@@ -4691,12 +4710,14 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 			    struct sk_buff *last_msdu,
 			    struct ieee80211_rx_status *rxs)
 {
+	struct ath11k_base *ab = ar->ab;
 	struct sk_buff *msdu, *mpdu_buf, *prev_buf;
-	u32 decap_format, wifi_hdr_len;
+	u32 wifi_hdr_len;
 	struct hal_rx_desc *rx_desc;
 	char *hdr_desc;
-	u8 *dest;
+	u8 *dest, decap_format;
 	struct ieee80211_hdr_3addr *wh;
+	struct rx_attention *rx_attention;
 
 	mpdu_buf = NULL;
 
@@ -4704,22 +4725,23 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 		goto err_merge_fail;
 
 	rx_desc = (struct hal_rx_desc *)head_msdu->data;
+	rx_attention = ath11k_dp_rx_get_attention(ab, rx_desc);
 
-	if (ath11k_dp_rxdesc_get_mpdulen_err(rx_desc))
+	if (ath11k_dp_rxdesc_get_mpdulen_err(rx_attention))
 		return NULL;
 
-	decap_format = ath11k_dp_rxdesc_get_decap_format(rx_desc);
+	decap_format = ath11k_dp_rx_h_msdu_start_decap_type(ab, rx_desc);
 
 	ath11k_dp_rx_h_ppdu(ar, rx_desc, rxs);
 
 	if (decap_format == DP_RX_DECAP_TYPE_RAW) {
-		ath11k_dp_rx_msdus_set_payload(head_msdu);
+		ath11k_dp_rx_msdus_set_payload(ar, head_msdu);
 
 		prev_buf = head_msdu;
 		msdu = head_msdu->next;
 
 		while (msdu) {
-			ath11k_dp_rx_msdus_set_payload(msdu);
+			ath11k_dp_rx_msdus_set_payload(ar, msdu);
 
 			prev_buf = msdu;
 			msdu = msdu->next;
@@ -4733,7 +4755,7 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 		u8 qos_pkt = 0;
 
 		rx_desc = (struct hal_rx_desc *)head_msdu->data;
-		hdr_desc = ath11k_dp_rxdesc_get_80211hdr(rx_desc);
+		hdr_desc = ath11k_dp_rxdesc_get_80211hdr(ab, rx_desc);
 
 		/* Base size */
 		wifi_hdr_len = sizeof(struct ieee80211_hdr_3addr);
@@ -4750,7 +4772,7 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 
 		while (msdu) {
 			rx_desc = (struct hal_rx_desc *)msdu->data;
-			hdr_desc = ath11k_dp_rxdesc_get_80211hdr(rx_desc);
+			hdr_desc = ath11k_dp_rxdesc_get_80211hdr(ab, rx_desc);
 
 			if (qos_pkt) {
 				dest = skb_push(msdu, sizeof(__le16));
@@ -4760,7 +4782,7 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 				memcpy(dest + wifi_hdr_len,
 				       (u8 *)&qos_field, sizeof(__le16));
 			}
-			ath11k_dp_rx_msdus_set_payload(msdu);
+			ath11k_dp_rx_msdus_set_payload(ar, msdu);
 			prev_buf = msdu;
 			msdu = msdu->next;
 		}
@@ -4768,11 +4790,11 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 		if (!dest)
 			goto err_merge_fail;
 
-		ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
+		ath11k_dbg(ab, ATH11K_DBG_DATA,
 			   "mpdu_buf %pK mpdu_buf->len %u",
 			   prev_buf, prev_buf->len);
 	} else {
-		ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
+		ath11k_dbg(ab, ATH11K_DBG_DATA,
 			   "decap format %d is not supported!\n",
 			   decap_format);
 		goto err_merge_fail;
@@ -4782,7 +4804,7 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 
 err_merge_fail:
 	if (mpdu_buf && decap_format != DP_RX_DECAP_TYPE_RAW) {
-		ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
+		ath11k_dbg(ab, ATH11K_DBG_DATA,
 			   "err_merge_fail mpdu_buf %pK", mpdu_buf);
 		/* Free the head buffer */
 		dev_kfree_skb_any(mpdu_buf);
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 8a28a51999b7..d5dab6c2ce3a 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -316,8 +316,6 @@ struct ath11k_base;
 #define HAL_WBM2SW_RELEASE_RING_BASE_MSB_RING_SIZE	0x000fffff
 #define HAL_RXDMA_RING_MAX_SIZE				0x0000ffff
 
-#define HAL_RX_DESC_SIZE (sizeof(struct hal_rx_desc))
-
 /* Add any other errors here and return them in
  * ath11k_hal_rx_desc_get_err().
  */
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index 86ed450f8238..c8929de8ce6c 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -76,7 +76,7 @@ void ath11k_hal_tx_cmd_desc_setup(struct ath11k_base *ab, void *cmd,
 				    ti->bss_ast_hash);
 	tcl_cmd->info4 = 0;
 
-	if (ti->enable_mesh && ab->hw_params.hw_ops->tx_mesh_enable)
+	if (ti->enable_mesh)
 		ab->hw_params.hw_ops->tx_mesh_enable(ab, tcl_cmd);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 626739b54989..462d5e81bee8 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -169,12 +169,358 @@ static int ath11k_hw_mac_id_to_srng_id_qca6390(struct ath11k_hw_params *hw,
 	return mac_id;
 }
 
+static bool ath11k_hw_ipq8074_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MSDU_END_INFO2_FIRST_MSDU,
+			   __le32_to_cpu(desc->u.ipq8074.msdu_end.info2));
+}
+
+static bool ath11k_hw_ipq8074_rx_desc_get_last_msdu(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MSDU_END_INFO2_LAST_MSDU,
+			   __le32_to_cpu(desc->u.ipq8074.msdu_end.info2));
+}
+
+static u8 ath11k_hw_ipq8074_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_END_INFO2_L3_HDR_PADDING,
+			 __le32_to_cpu(desc->u.ipq8074.msdu_end.info2));
+}
+
+static u8 *ath11k_hw_ipq8074_rx_desc_get_hdr_status(struct hal_rx_desc *desc)
+{
+	return desc->u.ipq8074.hdr_status;
+}
+
+static bool ath11k_hw_ipq8074_rx_desc_encrypt_valid(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.ipq8074.mpdu_start.info1) &
+	       RX_MPDU_START_INFO1_ENCRYPT_INFO_VALID;
+}
+
+static u32 ath11k_hw_ipq8074_rx_desc_get_encrypt_type(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MPDU_START_INFO2_ENC_TYPE,
+			 __le32_to_cpu(desc->u.ipq8074.mpdu_start.info2));
+}
+
+static u8 ath11k_hw_ipq8074_rx_desc_get_decap_type(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO2_DECAP_FORMAT,
+			 __le32_to_cpu(desc->u.ipq8074.msdu_start.info2));
+}
+
+static u8 ath11k_hw_ipq8074_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO2_MESH_CTRL_PRESENT,
+			 __le32_to_cpu(desc->u.ipq8074.msdu_start.info2));
+}
+
+static bool ath11k_hw_ipq8074_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MPDU_START_INFO1_MPDU_SEQ_CTRL_VALID,
+			   __le32_to_cpu(desc->u.ipq8074.mpdu_start.info1));
+}
+
+static bool ath11k_hw_ipq8074_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MPDU_START_INFO1_MPDU_FCTRL_VALID,
+			   __le32_to_cpu(desc->u.ipq8074.mpdu_start.info1));
+}
+
+static u16 ath11k_hw_ipq8074_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MPDU_START_INFO1_MPDU_SEQ_NUM,
+			 __le32_to_cpu(desc->u.ipq8074.mpdu_start.info1));
+}
+
+static u16 ath11k_hw_ipq8074_rx_desc_get_msdu_len(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO1_MSDU_LENGTH,
+			 __le32_to_cpu(desc->u.ipq8074.msdu_start.info1));
+}
+
+static u8 ath11k_hw_ipq8074_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_SGI,
+			 __le32_to_cpu(desc->u.ipq8074.msdu_start.info3));
+}
+
+static u8 ath11k_hw_ipq8074_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_RATE_MCS,
+			 __le32_to_cpu(desc->u.ipq8074.msdu_start.info3));
+}
+
+static u8 ath11k_hw_ipq8074_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_RECV_BW,
+			 __le32_to_cpu(desc->u.ipq8074.msdu_start.info3));
+}
+
+static u32 ath11k_hw_ipq8074_rx_desc_get_msdu_freq(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.ipq8074.msdu_start.phy_meta_data);
+}
+
+static u8 ath11k_hw_ipq8074_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_PKT_TYPE,
+			 __le32_to_cpu(desc->u.ipq8074.msdu_start.info3));
+}
+
+static u8 ath11k_hw_ipq8074_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_MIMO_SS_BITMAP,
+			 __le32_to_cpu(desc->u.ipq8074.msdu_start.info3));
+}
+
+static u8 ath11k_hw_ipq8074_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MPDU_START_INFO2_TID,
+			 __le32_to_cpu(desc->u.ipq8074.mpdu_start.info2));
+}
+
+static u16 ath11k_hw_ipq8074_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.ipq8074.mpdu_start.sw_peer_id);
+}
+
+static void ath11k_hw_ipq8074_rx_desc_copy_attn_end(struct hal_rx_desc *fdesc,
+						    struct hal_rx_desc *ldesc)
+{
+	memcpy((u8 *)&fdesc->u.ipq8074.msdu_end, (u8 *)&ldesc->u.ipq8074.msdu_end,
+	       sizeof(struct rx_msdu_end_ipq8074));
+	memcpy((u8 *)&fdesc->u.ipq8074.attention, (u8 *)&ldesc->u.ipq8074.attention,
+	       sizeof(struct rx_attention));
+	memcpy((u8 *)&fdesc->u.ipq8074.mpdu_end, (u8 *)&ldesc->u.ipq8074.mpdu_end,
+	       sizeof(struct rx_mpdu_end));
+}
+
+static u32 ath11k_hw_ipq8074_rx_desc_get_mpdu_start_tag(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(HAL_TLV_HDR_TAG,
+			 __le32_to_cpu(desc->u.ipq8074.mpdu_start_tag));
+}
+
+static u32 ath11k_hw_ipq8074_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.ipq8074.mpdu_start.phy_ppdu_id);
+}
+
+static void ath11k_hw_ipq8074_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
+{
+	u32 info = __le32_to_cpu(desc->u.ipq8074.msdu_start.info1);
+
+	info &= ~RX_MSDU_START_INFO1_MSDU_LENGTH;
+	info |= FIELD_PREP(RX_MSDU_START_INFO1_MSDU_LENGTH, len);
+
+	desc->u.ipq8074.msdu_start.info1 = __cpu_to_le32(info);
+}
+
+static
+struct rx_attention *ath11k_hw_ipq8074_rx_desc_get_attention(struct hal_rx_desc *desc)
+{
+	return &desc->u.ipq8074.attention;
+}
+
+static u8 *ath11k_hw_ipq8074_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
+{
+	return &desc->u.ipq8074.msdu_payload[0];
+}
+
+static bool ath11k_hw_qcn9074_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MSDU_END_INFO4_FIRST_MSDU,
+			   __le16_to_cpu(desc->u.qcn9074.msdu_end.info4));
+}
+
+static bool ath11k_hw_qcn9074_rx_desc_get_last_msdu(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MSDU_END_INFO4_LAST_MSDU,
+			   __le16_to_cpu(desc->u.qcn9074.msdu_end.info4));
+}
+
+static u8 ath11k_hw_qcn9074_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_END_INFO4_L3_HDR_PADDING,
+			 __le16_to_cpu(desc->u.qcn9074.msdu_end.info4));
+}
+
+static u8 *ath11k_hw_qcn9074_rx_desc_get_hdr_status(struct hal_rx_desc *desc)
+{
+	return desc->u.qcn9074.hdr_status;
+}
+
+static bool ath11k_hw_qcn9074_rx_desc_encrypt_valid(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.qcn9074.mpdu_start.info11) &
+	       RX_MPDU_START_INFO11_ENCRYPT_INFO_VALID;
+}
+
+static u32 ath11k_hw_qcn9074_rx_desc_get_encrypt_type(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MPDU_START_INFO9_ENC_TYPE,
+			 __le32_to_cpu(desc->u.qcn9074.mpdu_start.info9));
+}
+
+static u8 ath11k_hw_qcn9074_rx_desc_get_decap_type(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO2_DECAP_FORMAT,
+			 __le32_to_cpu(desc->u.qcn9074.msdu_start.info2));
+}
+
+static u8 ath11k_hw_qcn9074_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO2_MESH_CTRL_PRESENT,
+			 __le32_to_cpu(desc->u.qcn9074.msdu_start.info2));
+}
+
+static bool ath11k_hw_qcn9074_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MPDU_START_INFO11_MPDU_SEQ_CTRL_VALID,
+			   __le32_to_cpu(desc->u.qcn9074.mpdu_start.info11));
+}
+
+static bool ath11k_hw_qcn9074_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MPDU_START_INFO11_MPDU_FCTRL_VALID,
+			   __le32_to_cpu(desc->u.qcn9074.mpdu_start.info11));
+}
+
+static u16 ath11k_hw_qcn9074_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MPDU_START_INFO11_MPDU_SEQ_NUM,
+			 __le32_to_cpu(desc->u.qcn9074.mpdu_start.info11));
+}
+
+static u16 ath11k_hw_qcn9074_rx_desc_get_msdu_len(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO1_MSDU_LENGTH,
+			 __le32_to_cpu(desc->u.qcn9074.msdu_start.info1));
+}
+
+static u8 ath11k_hw_qcn9074_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_SGI,
+			 __le32_to_cpu(desc->u.qcn9074.msdu_start.info3));
+}
+
+static u8 ath11k_hw_qcn9074_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_RATE_MCS,
+			 __le32_to_cpu(desc->u.qcn9074.msdu_start.info3));
+}
+
+static u8 ath11k_hw_qcn9074_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_RECV_BW,
+			 __le32_to_cpu(desc->u.qcn9074.msdu_start.info3));
+}
+
+static u32 ath11k_hw_qcn9074_rx_desc_get_msdu_freq(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.qcn9074.msdu_start.phy_meta_data);
+}
+
+static u8 ath11k_hw_qcn9074_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_PKT_TYPE,
+			 __le32_to_cpu(desc->u.qcn9074.msdu_start.info3));
+}
+
+static u8 ath11k_hw_qcn9074_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_MIMO_SS_BITMAP,
+			 __le32_to_cpu(desc->u.qcn9074.msdu_start.info3));
+}
+
+static u8 ath11k_hw_qcn9074_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MPDU_START_INFO9_TID,
+			 __le32_to_cpu(desc->u.qcn9074.mpdu_start.info9));
+}
+
+static u16 ath11k_hw_qcn9074_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.qcn9074.mpdu_start.sw_peer_id);
+}
+
+static void ath11k_hw_qcn9074_rx_desc_copy_attn_end(struct hal_rx_desc *fdesc,
+						    struct hal_rx_desc *ldesc)
+{
+	memcpy((u8 *)&fdesc->u.qcn9074.msdu_end, (u8 *)&ldesc->u.qcn9074.msdu_end,
+	       sizeof(struct rx_msdu_end_qcn9074));
+	memcpy((u8 *)&fdesc->u.qcn9074.attention, (u8 *)&ldesc->u.qcn9074.attention,
+	       sizeof(struct rx_attention));
+	memcpy((u8 *)&fdesc->u.qcn9074.mpdu_end, (u8 *)&ldesc->u.qcn9074.mpdu_end,
+	       sizeof(struct rx_mpdu_end));
+}
+
+static u32 ath11k_hw_qcn9074_rx_desc_get_mpdu_start_tag(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(HAL_TLV_HDR_TAG,
+			 __le32_to_cpu(desc->u.qcn9074.mpdu_start_tag));
+}
+
+static u32 ath11k_hw_qcn9074_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.qcn9074.mpdu_start.phy_ppdu_id);
+}
+
+static void ath11k_hw_qcn9074_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
+{
+	u32 info = __le32_to_cpu(desc->u.qcn9074.msdu_start.info1);
+
+	info &= ~RX_MSDU_START_INFO1_MSDU_LENGTH;
+	info |= FIELD_PREP(RX_MSDU_START_INFO1_MSDU_LENGTH, len);
+
+	desc->u.qcn9074.msdu_start.info1 = __cpu_to_le32(info);
+}
+
+static
+struct rx_attention *ath11k_hw_qcn9074_rx_desc_get_attention(struct hal_rx_desc *desc)
+{
+	return &desc->u.qcn9074.attention;
+}
+
+static u8 *ath11k_hw_qcn9074_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
+{
+	return &desc->u.qcn9074.msdu_payload[0];
+}
+
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
 	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_ipq8074,
 	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_ipq8074,
 	.tx_mesh_enable = ath11k_hw_ipq8074_tx_mesh_enable,
+	.rx_desc_get_first_msdu = ath11k_hw_ipq8074_rx_desc_get_first_msdu,
+	.rx_desc_get_last_msdu = ath11k_hw_ipq8074_rx_desc_get_last_msdu,
+	.rx_desc_get_l3_pad_bytes = ath11k_hw_ipq8074_rx_desc_get_l3_pad_bytes,
+	.rx_desc_get_hdr_status = ath11k_hw_ipq8074_rx_desc_get_hdr_status,
+	.rx_desc_encrypt_valid = ath11k_hw_ipq8074_rx_desc_encrypt_valid,
+	.rx_desc_get_encrypt_type = ath11k_hw_ipq8074_rx_desc_get_encrypt_type,
+	.rx_desc_get_decap_type = ath11k_hw_ipq8074_rx_desc_get_decap_type,
+	.rx_desc_get_mesh_ctl = ath11k_hw_ipq8074_rx_desc_get_mesh_ctl,
+	.rx_desc_get_mpdu_seq_ctl_vld = ath11k_hw_ipq8074_rx_desc_get_mpdu_seq_ctl_vld,
+	.rx_desc_get_mpdu_fc_valid = ath11k_hw_ipq8074_rx_desc_get_mpdu_fc_valid,
+	.rx_desc_get_mpdu_start_seq_no = ath11k_hw_ipq8074_rx_desc_get_mpdu_start_seq_no,
+	.rx_desc_get_msdu_len = ath11k_hw_ipq8074_rx_desc_get_msdu_len,
+	.rx_desc_get_msdu_sgi = ath11k_hw_ipq8074_rx_desc_get_msdu_sgi,
+	.rx_desc_get_msdu_rate_mcs = ath11k_hw_ipq8074_rx_desc_get_msdu_rate_mcs,
+	.rx_desc_get_msdu_rx_bw = ath11k_hw_ipq8074_rx_desc_get_msdu_rx_bw,
+	.rx_desc_get_msdu_freq = ath11k_hw_ipq8074_rx_desc_get_msdu_freq,
+	.rx_desc_get_msdu_pkt_type = ath11k_hw_ipq8074_rx_desc_get_msdu_pkt_type,
+	.rx_desc_get_msdu_nss = ath11k_hw_ipq8074_rx_desc_get_msdu_nss,
+	.rx_desc_get_mpdu_tid = ath11k_hw_ipq8074_rx_desc_get_mpdu_tid,
+	.rx_desc_get_mpdu_peer_id = ath11k_hw_ipq8074_rx_desc_get_mpdu_peer_id,
+	.rx_desc_copy_attn_end_tlv = ath11k_hw_ipq8074_rx_desc_copy_attn_end,
+	.rx_desc_get_mpdu_start_tag = ath11k_hw_ipq8074_rx_desc_get_mpdu_start_tag,
+	.rx_desc_get_mpdu_ppdu_id = ath11k_hw_ipq8074_rx_desc_get_mpdu_ppdu_id,
+	.rx_desc_set_msdu_len = ath11k_hw_ipq8074_rx_desc_set_msdu_len,
+	.rx_desc_get_attention = ath11k_hw_ipq8074_rx_desc_get_attention,
+	.rx_desc_get_msdu_payload = ath11k_hw_ipq8074_rx_desc_get_msdu_payload,
 };
 
 const struct ath11k_hw_ops ipq6018_ops = {
@@ -183,6 +529,32 @@ const struct ath11k_hw_ops ipq6018_ops = {
 	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_ipq8074,
 	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_ipq8074,
 	.tx_mesh_enable = ath11k_hw_ipq8074_tx_mesh_enable,
+	.rx_desc_get_first_msdu = ath11k_hw_ipq8074_rx_desc_get_first_msdu,
+	.rx_desc_get_last_msdu = ath11k_hw_ipq8074_rx_desc_get_last_msdu,
+	.rx_desc_get_l3_pad_bytes = ath11k_hw_ipq8074_rx_desc_get_l3_pad_bytes,
+	.rx_desc_get_hdr_status = ath11k_hw_ipq8074_rx_desc_get_hdr_status,
+	.rx_desc_encrypt_valid = ath11k_hw_ipq8074_rx_desc_encrypt_valid,
+	.rx_desc_get_encrypt_type = ath11k_hw_ipq8074_rx_desc_get_encrypt_type,
+	.rx_desc_get_decap_type = ath11k_hw_ipq8074_rx_desc_get_decap_type,
+	.rx_desc_get_mesh_ctl = ath11k_hw_ipq8074_rx_desc_get_mesh_ctl,
+	.rx_desc_get_mpdu_seq_ctl_vld = ath11k_hw_ipq8074_rx_desc_get_mpdu_seq_ctl_vld,
+	.rx_desc_get_mpdu_fc_valid = ath11k_hw_ipq8074_rx_desc_get_mpdu_fc_valid,
+	.rx_desc_get_mpdu_start_seq_no = ath11k_hw_ipq8074_rx_desc_get_mpdu_start_seq_no,
+	.rx_desc_get_msdu_len = ath11k_hw_ipq8074_rx_desc_get_msdu_len,
+	.rx_desc_get_msdu_sgi = ath11k_hw_ipq8074_rx_desc_get_msdu_sgi,
+	.rx_desc_get_msdu_rate_mcs = ath11k_hw_ipq8074_rx_desc_get_msdu_rate_mcs,
+	.rx_desc_get_msdu_rx_bw = ath11k_hw_ipq8074_rx_desc_get_msdu_rx_bw,
+	.rx_desc_get_msdu_freq = ath11k_hw_ipq8074_rx_desc_get_msdu_freq,
+	.rx_desc_get_msdu_pkt_type = ath11k_hw_ipq8074_rx_desc_get_msdu_pkt_type,
+	.rx_desc_get_msdu_nss = ath11k_hw_ipq8074_rx_desc_get_msdu_nss,
+	.rx_desc_get_mpdu_tid = ath11k_hw_ipq8074_rx_desc_get_mpdu_tid,
+	.rx_desc_get_mpdu_peer_id = ath11k_hw_ipq8074_rx_desc_get_mpdu_peer_id,
+	.rx_desc_copy_attn_end_tlv = ath11k_hw_ipq8074_rx_desc_copy_attn_end,
+	.rx_desc_get_mpdu_start_tag = ath11k_hw_ipq8074_rx_desc_get_mpdu_start_tag,
+	.rx_desc_get_mpdu_ppdu_id = ath11k_hw_ipq8074_rx_desc_get_mpdu_ppdu_id,
+	.rx_desc_set_msdu_len = ath11k_hw_ipq8074_rx_desc_set_msdu_len,
+	.rx_desc_get_attention = ath11k_hw_ipq8074_rx_desc_get_attention,
+	.rx_desc_get_msdu_payload = ath11k_hw_ipq8074_rx_desc_get_msdu_payload,
 };
 
 const struct ath11k_hw_ops qca6390_ops = {
@@ -191,6 +563,32 @@ const struct ath11k_hw_ops qca6390_ops = {
 	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_qca6390,
 	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_qca6390,
 	.tx_mesh_enable = ath11k_hw_ipq8074_tx_mesh_enable,
+	.rx_desc_get_first_msdu = ath11k_hw_ipq8074_rx_desc_get_first_msdu,
+	.rx_desc_get_last_msdu = ath11k_hw_ipq8074_rx_desc_get_last_msdu,
+	.rx_desc_get_l3_pad_bytes = ath11k_hw_ipq8074_rx_desc_get_l3_pad_bytes,
+	.rx_desc_get_hdr_status = ath11k_hw_ipq8074_rx_desc_get_hdr_status,
+	.rx_desc_encrypt_valid = ath11k_hw_ipq8074_rx_desc_encrypt_valid,
+	.rx_desc_get_encrypt_type = ath11k_hw_ipq8074_rx_desc_get_encrypt_type,
+	.rx_desc_get_decap_type = ath11k_hw_ipq8074_rx_desc_get_decap_type,
+	.rx_desc_get_mesh_ctl = ath11k_hw_ipq8074_rx_desc_get_mesh_ctl,
+	.rx_desc_get_mpdu_seq_ctl_vld = ath11k_hw_ipq8074_rx_desc_get_mpdu_seq_ctl_vld,
+	.rx_desc_get_mpdu_fc_valid = ath11k_hw_ipq8074_rx_desc_get_mpdu_fc_valid,
+	.rx_desc_get_mpdu_start_seq_no = ath11k_hw_ipq8074_rx_desc_get_mpdu_start_seq_no,
+	.rx_desc_get_msdu_len = ath11k_hw_ipq8074_rx_desc_get_msdu_len,
+	.rx_desc_get_msdu_sgi = ath11k_hw_ipq8074_rx_desc_get_msdu_sgi,
+	.rx_desc_get_msdu_rate_mcs = ath11k_hw_ipq8074_rx_desc_get_msdu_rate_mcs,
+	.rx_desc_get_msdu_rx_bw = ath11k_hw_ipq8074_rx_desc_get_msdu_rx_bw,
+	.rx_desc_get_msdu_freq = ath11k_hw_ipq8074_rx_desc_get_msdu_freq,
+	.rx_desc_get_msdu_pkt_type = ath11k_hw_ipq8074_rx_desc_get_msdu_pkt_type,
+	.rx_desc_get_msdu_nss = ath11k_hw_ipq8074_rx_desc_get_msdu_nss,
+	.rx_desc_get_mpdu_tid = ath11k_hw_ipq8074_rx_desc_get_mpdu_tid,
+	.rx_desc_get_mpdu_peer_id = ath11k_hw_ipq8074_rx_desc_get_mpdu_peer_id,
+	.rx_desc_copy_attn_end_tlv = ath11k_hw_ipq8074_rx_desc_copy_attn_end,
+	.rx_desc_get_mpdu_start_tag = ath11k_hw_ipq8074_rx_desc_get_mpdu_start_tag,
+	.rx_desc_get_mpdu_ppdu_id = ath11k_hw_ipq8074_rx_desc_get_mpdu_ppdu_id,
+	.rx_desc_set_msdu_len = ath11k_hw_ipq8074_rx_desc_set_msdu_len,
+	.rx_desc_get_attention = ath11k_hw_ipq8074_rx_desc_get_attention,
+	.rx_desc_get_msdu_payload = ath11k_hw_ipq8074_rx_desc_get_msdu_payload,
 };
 
 const struct ath11k_hw_ops qcn9074_ops = {
@@ -199,6 +597,32 @@ const struct ath11k_hw_ops qcn9074_ops = {
 	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_ipq8074,
 	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_ipq8074,
 	.tx_mesh_enable = ath11k_hw_qcn9074_tx_mesh_enable,
+	.rx_desc_get_first_msdu = ath11k_hw_qcn9074_rx_desc_get_first_msdu,
+	.rx_desc_get_last_msdu = ath11k_hw_qcn9074_rx_desc_get_last_msdu,
+	.rx_desc_get_l3_pad_bytes = ath11k_hw_qcn9074_rx_desc_get_l3_pad_bytes,
+	.rx_desc_get_hdr_status = ath11k_hw_qcn9074_rx_desc_get_hdr_status,
+	.rx_desc_encrypt_valid = ath11k_hw_qcn9074_rx_desc_encrypt_valid,
+	.rx_desc_get_encrypt_type = ath11k_hw_qcn9074_rx_desc_get_encrypt_type,
+	.rx_desc_get_decap_type = ath11k_hw_qcn9074_rx_desc_get_decap_type,
+	.rx_desc_get_mesh_ctl = ath11k_hw_qcn9074_rx_desc_get_mesh_ctl,
+	.rx_desc_get_mpdu_seq_ctl_vld = ath11k_hw_qcn9074_rx_desc_get_mpdu_seq_ctl_vld,
+	.rx_desc_get_mpdu_fc_valid = ath11k_hw_qcn9074_rx_desc_get_mpdu_fc_valid,
+	.rx_desc_get_mpdu_start_seq_no = ath11k_hw_qcn9074_rx_desc_get_mpdu_start_seq_no,
+	.rx_desc_get_msdu_len = ath11k_hw_qcn9074_rx_desc_get_msdu_len,
+	.rx_desc_get_msdu_sgi = ath11k_hw_qcn9074_rx_desc_get_msdu_sgi,
+	.rx_desc_get_msdu_rate_mcs = ath11k_hw_qcn9074_rx_desc_get_msdu_rate_mcs,
+	.rx_desc_get_msdu_rx_bw = ath11k_hw_qcn9074_rx_desc_get_msdu_rx_bw,
+	.rx_desc_get_msdu_freq = ath11k_hw_qcn9074_rx_desc_get_msdu_freq,
+	.rx_desc_get_msdu_pkt_type = ath11k_hw_qcn9074_rx_desc_get_msdu_pkt_type,
+	.rx_desc_get_msdu_nss = ath11k_hw_qcn9074_rx_desc_get_msdu_nss,
+	.rx_desc_get_mpdu_tid = ath11k_hw_qcn9074_rx_desc_get_mpdu_tid,
+	.rx_desc_get_mpdu_peer_id = ath11k_hw_qcn9074_rx_desc_get_mpdu_peer_id,
+	.rx_desc_copy_attn_end_tlv = ath11k_hw_qcn9074_rx_desc_copy_attn_end,
+	.rx_desc_get_mpdu_start_tag = ath11k_hw_qcn9074_rx_desc_get_mpdu_start_tag,
+	.rx_desc_get_mpdu_ppdu_id = ath11k_hw_qcn9074_rx_desc_get_mpdu_ppdu_id,
+	.rx_desc_set_msdu_len = ath11k_hw_qcn9074_rx_desc_set_msdu_len,
+	.rx_desc_get_attention = ath11k_hw_qcn9074_rx_desc_get_attention,
+	.rx_desc_get_msdu_payload = ath11k_hw_qcn9074_rx_desc_get_msdu_payload,
 };
 
 #define ATH11K_TX_RING_MASK_0 0x1
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 13f4f9c9814b..54b7edfc4f88 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -105,6 +105,7 @@ enum ath11k_bus {
 
 #define ATH11K_EXT_IRQ_GRP_NUM_MAX 11
 
+struct hal_rx_desc;
 struct hal_tcl_data_cmd;
 
 struct ath11k_hw_ring_mask {
@@ -160,6 +161,7 @@ struct ath11k_hw_params {
 	bool idle_ps;
 	bool cold_boot_calib;
 	bool supports_suspend;
+	u32 hal_desc_sz;
 };
 
 struct ath11k_hw_ops {
@@ -170,6 +172,33 @@ struct ath11k_hw_ops {
 	int (*mac_id_to_srng_id)(struct ath11k_hw_params *hw, int mac_id);
 	void (*tx_mesh_enable)(struct ath11k_base *ab,
 			       struct hal_tcl_data_cmd *tcl_cmd);
+	bool (*rx_desc_get_first_msdu)(struct hal_rx_desc *desc);
+	bool (*rx_desc_get_last_msdu)(struct hal_rx_desc *desc);
+	u8 (*rx_desc_get_l3_pad_bytes)(struct hal_rx_desc *desc);
+	u8 *(*rx_desc_get_hdr_status)(struct hal_rx_desc *desc);
+	bool (*rx_desc_encrypt_valid)(struct hal_rx_desc *desc);
+	u32 (*rx_desc_get_encrypt_type)(struct hal_rx_desc *desc);
+	u8 (*rx_desc_get_decap_type)(struct hal_rx_desc *desc);
+	u8 (*rx_desc_get_mesh_ctl)(struct hal_rx_desc *desc);
+	bool (*rx_desc_get_mpdu_seq_ctl_vld)(struct hal_rx_desc *desc);
+	bool (*rx_desc_get_mpdu_fc_valid)(struct hal_rx_desc *desc);
+	u16 (*rx_desc_get_mpdu_start_seq_no)(struct hal_rx_desc *desc);
+	u16 (*rx_desc_get_msdu_len)(struct hal_rx_desc *desc);
+	u8 (*rx_desc_get_msdu_sgi)(struct hal_rx_desc *desc);
+	u8 (*rx_desc_get_msdu_rate_mcs)(struct hal_rx_desc *desc);
+	u8 (*rx_desc_get_msdu_rx_bw)(struct hal_rx_desc *desc);
+	u32 (*rx_desc_get_msdu_freq)(struct hal_rx_desc *desc);
+	u8 (*rx_desc_get_msdu_pkt_type)(struct hal_rx_desc *desc);
+	u8 (*rx_desc_get_msdu_nss)(struct hal_rx_desc *desc);
+	u8 (*rx_desc_get_mpdu_tid)(struct hal_rx_desc *desc);
+	u16 (*rx_desc_get_mpdu_peer_id)(struct hal_rx_desc *desc);
+	void (*rx_desc_copy_attn_end_tlv)(struct hal_rx_desc *fdesc,
+					  struct hal_rx_desc *ldesc);
+	u32 (*rx_desc_get_mpdu_start_tag)(struct hal_rx_desc *desc);
+	u32 (*rx_desc_get_mpdu_ppdu_id)(struct hal_rx_desc *desc);
+	void (*rx_desc_set_msdu_len)(struct hal_rx_desc *desc, u16 len);
+	struct rx_attention *(*rx_desc_get_attention)(struct hal_rx_desc *desc);
+	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
 };
 
 extern const struct ath11k_hw_ops ipq8074_ops;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 71cad954f65f..6e60b132b7a1 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -775,6 +775,7 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 		}
 
 		ab->irq_num[irq_idx] = irq;
+
 		ath11k_pci_ce_irq_disable(ab, i);
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/rx_desc.h b/drivers/net/wireless/ath/ath11k/rx_desc.h
index 86494da1069a..0cdb4a1f816e 100644
--- a/drivers/net/wireless/ath/ath11k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath11k/rx_desc.h
@@ -414,7 +414,7 @@ struct rx_attention {
 
 #define RX_MPDU_START_RAW_MPDU			BIT(0)
 
-struct rx_mpdu_start {
+struct rx_mpdu_start_ipq8074 {
 	__le16 info0;
 	__le16 phy_ppdu_id;
 	__le16 ast_index;
@@ -440,6 +440,112 @@ struct rx_mpdu_start {
 	__le32 raw;
 } __packed;
 
+#define RX_MPDU_START_INFO7_REO_DEST_IND		GENMASK(4, 0)
+#define RX_MPDU_START_INFO7_LMAC_PEER_ID_MSB		GENMASK(6, 5)
+#define RX_MPDU_START_INFO7_FLOW_ID_TOEPLITZ		BIT(7)
+#define RX_MPDU_START_INFO7_PKT_SEL_FP_UCAST_DATA	BIT(8)
+#define RX_MPDU_START_INFO7_PKT_SEL_FP_MCAST_DATA	BIT(9)
+#define RX_MPDU_START_INFO7_PKT_SEL_FP_CTRL_BAR		BIT(10)
+#define RX_MPDU_START_INFO7_RXDMA0_SRC_RING_SEL		GENMASK(12, 11)
+#define RX_MPDU_START_INFO7_RXDMA0_DST_RING_SEL		GENMASK(14, 13)
+
+#define RX_MPDU_START_INFO8_REO_QUEUE_DESC_HI		GENMASK(7, 0)
+#define RX_MPDU_START_INFO8_RECV_QUEUE_NUM		GENMASK(23, 8)
+#define RX_MPDU_START_INFO8_PRE_DELIM_ERR_WARN		BIT(24)
+#define RX_MPDU_START_INFO8_FIRST_DELIM_ERR		BIT(25)
+
+#define RX_MPDU_START_INFO9_EPD_EN			BIT(0)
+#define RX_MPDU_START_INFO9_ALL_FRAME_ENCPD		BIT(1)
+#define RX_MPDU_START_INFO9_ENC_TYPE			GENMASK(5, 2)
+#define RX_MPDU_START_INFO9_VAR_WEP_KEY_WIDTH		GENMASK(7, 6)
+#define RX_MPDU_START_INFO9_MESH_STA			GENMASK(9, 8)
+#define RX_MPDU_START_INFO9_BSSID_HIT			BIT(10)
+#define RX_MPDU_START_INFO9_BSSID_NUM			GENMASK(14, 11)
+#define RX_MPDU_START_INFO9_TID				GENMASK(18, 15)
+
+#define RX_MPDU_START_INFO10_RXPCU_MPDU_FLTR		GENMASK(1, 0)
+#define RX_MPDU_START_INFO10_SW_FRAME_GRP_ID		GENMASK(8, 2)
+#define RX_MPDU_START_INFO10_NDP_FRAME			BIT(9)
+#define RX_MPDU_START_INFO10_PHY_ERR			BIT(10)
+#define RX_MPDU_START_INFO10_PHY_ERR_MPDU_HDR		BIT(11)
+#define RX_MPDU_START_INFO10_PROTO_VER_ERR		BIT(12)
+#define RX_MPDU_START_INFO10_AST_LOOKUP_VALID		BIT(13)
+
+#define RX_MPDU_START_INFO11_MPDU_FCTRL_VALID		BIT(0)
+#define RX_MPDU_START_INFO11_MPDU_DUR_VALID		BIT(1)
+#define RX_MPDU_START_INFO11_MAC_ADDR1_VALID		BIT(2)
+#define RX_MPDU_START_INFO11_MAC_ADDR2_VALID		BIT(3)
+#define RX_MPDU_START_INFO11_MAC_ADDR3_VALID		BIT(4)
+#define RX_MPDU_START_INFO11_MAC_ADDR4_VALID		BIT(5)
+#define RX_MPDU_START_INFO11_MPDU_SEQ_CTRL_VALID	BIT(6)
+#define RX_MPDU_START_INFO11_MPDU_QOS_CTRL_VALID	BIT(7)
+#define RX_MPDU_START_INFO11_MPDU_HT_CTRL_VALID		BIT(8)
+#define RX_MPDU_START_INFO11_ENCRYPT_INFO_VALID		BIT(9)
+#define RX_MPDU_START_INFO11_MPDU_FRAG_NUMBER		GENMASK(13, 10)
+#define RX_MPDU_START_INFO11_MORE_FRAG_FLAG		BIT(14)
+#define RX_MPDU_START_INFO11_FROM_DS			BIT(16)
+#define RX_MPDU_START_INFO11_TO_DS			BIT(17)
+#define RX_MPDU_START_INFO11_ENCRYPTED			BIT(18)
+#define RX_MPDU_START_INFO11_MPDU_RETRY			BIT(19)
+#define RX_MPDU_START_INFO11_MPDU_SEQ_NUM		GENMASK(31, 20)
+
+#define RX_MPDU_START_INFO12_KEY_ID			GENMASK(7, 0)
+#define RX_MPDU_START_INFO12_NEW_PEER_ENTRY		BIT(8)
+#define RX_MPDU_START_INFO12_DECRYPT_NEEDED		BIT(9)
+#define RX_MPDU_START_INFO12_DECAP_TYPE			GENMASK(11, 10)
+#define RX_MPDU_START_INFO12_VLAN_TAG_C_PADDING		BIT(12)
+#define RX_MPDU_START_INFO12_VLAN_TAG_S_PADDING		BIT(13)
+#define RX_MPDU_START_INFO12_STRIP_VLAN_TAG_C		BIT(14)
+#define RX_MPDU_START_INFO12_STRIP_VLAN_TAG_S		BIT(15)
+#define RX_MPDU_START_INFO12_PRE_DELIM_COUNT		GENMASK(27, 16)
+#define RX_MPDU_START_INFO12_AMPDU_FLAG			BIT(28)
+#define RX_MPDU_START_INFO12_BAR_FRAME			BIT(29)
+#define RX_MPDU_START_INFO12_RAW_MPDU			BIT(30)
+
+#define RX_MPDU_START_INFO13_MPDU_LEN			GENMASK(13, 0)
+#define RX_MPDU_START_INFO13_FIRST_MPDU			BIT(14)
+#define RX_MPDU_START_INFO13_MCAST_BCAST		BIT(15)
+#define RX_MPDU_START_INFO13_AST_IDX_NOT_FOUND		BIT(16)
+#define RX_MPDU_START_INFO13_AST_IDX_TIMEOUT		BIT(17)
+#define RX_MPDU_START_INFO13_POWER_MGMT			BIT(18)
+#define RX_MPDU_START_INFO13_NON_QOS			BIT(19)
+#define RX_MPDU_START_INFO13_NULL_DATA			BIT(20)
+#define RX_MPDU_START_INFO13_MGMT_TYPE			BIT(21)
+#define RX_MPDU_START_INFO13_CTRL_TYPE			BIT(22)
+#define RX_MPDU_START_INFO13_MORE_DATA			BIT(23)
+#define RX_MPDU_START_INFO13_EOSP			BIT(24)
+#define RX_MPDU_START_INFO13_FRAGMENT			BIT(25)
+#define RX_MPDU_START_INFO13_ORDER			BIT(26)
+#define RX_MPDU_START_INFO13_UAPSD_TRIGGER		BIT(27)
+#define RX_MPDU_START_INFO13_ENCRYPT_REQUIRED		BIT(28)
+#define RX_MPDU_START_INFO13_DIRECTED			BIT(29)
+#define RX_MPDU_START_INFO13_AMSDU_PRESENT		BIT(30)
+
+struct rx_mpdu_start_qcn9074 {
+	__le32 info7;
+	__le32 reo_queue_desc_lo;
+	__le32 info8;
+	__le32 pn[4];
+	__le32 info9;
+	__le32 peer_meta_data;
+	__le16 info10;
+	__le16 phy_ppdu_id;
+	__le16 ast_index;
+	__le16 sw_peer_id;
+	__le32 info11;
+	__le32 info12;
+	__le32 info13;
+	__le16 frame_ctrl;
+	__le16 duration;
+	u8 addr1[ETH_ALEN];
+	u8 addr2[ETH_ALEN];
+	u8 addr3[ETH_ALEN];
+	__le16 seq_ctrl;
+	u8 addr4[ETH_ALEN];
+	__le16 qos_ctrl;
+	__le32 ht_ctrl;
+} __packed;
+
 /* rx_mpdu_start
  *
  * rxpcu_mpdu_filter_in_category
@@ -672,7 +778,19 @@ enum rx_msdu_start_reception_type {
 #define RX_MSDU_START_INFO3_RECEPTION_TYPE	GENMASK(23, 21)
 #define RX_MSDU_START_INFO3_MIMO_SS_BITMAP	GENMASK(31, 24)
 
-struct rx_msdu_start {
+struct rx_msdu_start_ipq8074 {
+	__le16 info0;
+	__le16 phy_ppdu_id;
+	__le32 info1;
+	__le32 info2;
+	__le32 toeplitz_hash;
+	__le32 flow_id_toeplitz;
+	__le32 info3;
+	__le32 ppdu_start_timestamp;
+	__le32 phy_meta_data;
+} __packed;
+
+struct rx_msdu_start_qcn9074 {
 	__le16 info0;
 	__le16 phy_ppdu_id;
 	__le32 info1;
@@ -682,6 +800,8 @@ struct rx_msdu_start {
 	__le32 info3;
 	__le32 ppdu_start_timestamp;
 	__le32 phy_meta_data;
+	__le16 vlan_ctag_c1;
+	__le16 vlan_stag_c1;
 } __packed;
 
 /* rx_msdu_start
@@ -894,7 +1014,7 @@ struct rx_msdu_start {
 #define RX_MSDU_END_INFO5_REO_DEST_IND		GENMASK(5, 1)
 #define RX_MSDU_END_INFO5_FLOW_IDX		GENMASK(25, 6)
 
-struct rx_msdu_end {
+struct rx_msdu_end_ipq8074 {
 	__le16 info0;
 	__le16 phy_ppdu_id;
 	__le16 ip_hdr_cksum;
@@ -917,6 +1037,58 @@ struct rx_msdu_end {
 	__le16 sa_sw_peer_id;
 } __packed;
 
+#define RX_MSDU_END_MPDU_LENGTH_INFO		GENMASK(13, 0)
+
+#define RX_MSDU_END_INFO2_DA_OFFSET		GENMASK(5, 0)
+#define RX_MSDU_END_INFO2_SA_OFFSET		GENMASK(11, 6)
+#define RX_MSDU_END_INFO2_DA_OFFSET_VALID	BIT(12)
+#define RX_MSDU_END_INFO2_SA_OFFSET_VALID	BIT(13)
+#define RX_MSDU_END_INFO2_L3_TYPE		GENMASK(31, 16)
+
+#define RX_MSDU_END_INFO4_SA_IDX_TIMEOUT	BIT(0)
+#define RX_MSDU_END_INFO4_DA_IDX_TIMEOUT	BIT(1)
+#define RX_MSDU_END_INFO4_MSDU_LIMIT_ERR	BIT(2)
+#define RX_MSDU_END_INFO4_FLOW_IDX_TIMEOUT	BIT(3)
+#define RX_MSDU_END_INFO4_FLOW_IDX_INVALID	BIT(4)
+#define RX_MSDU_END_INFO4_WIFI_PARSER_ERR	BIT(5)
+#define RX_MSDU_END_INFO4_AMSDU_PARSER_ERR	BIT(6)
+#define RX_MSDU_END_INFO4_SA_IS_VALID		BIT(7)
+#define RX_MSDU_END_INFO4_DA_IS_VALID		BIT(8)
+#define RX_MSDU_END_INFO4_DA_IS_MCBC		BIT(9)
+#define RX_MSDU_END_INFO4_L3_HDR_PADDING	GENMASK(11, 10)
+#define RX_MSDU_END_INFO4_FIRST_MSDU		BIT(12)
+#define RX_MSDU_END_INFO4_LAST_MSDU		BIT(13)
+
+#define RX_MSDU_END_INFO6_AGGR_COUNT		GENMASK(7, 0)
+#define RX_MSDU_END_INFO6_FLOW_AGGR_CONTN	BIT(8)
+#define RX_MSDU_END_INFO6_FISA_TIMEOUT		BIT(9)
+
+struct rx_msdu_end_qcn9074 {
+	__le16 info0;
+	__le16 phy_ppdu_id;
+	__le16 ip_hdr_cksum;
+	__le16 mpdu_length_info;
+	__le32 info1;
+	__le32 rule_indication[2];
+	__le32 info2;
+	__le32 ipv6_options_crc;
+	__le32 tcp_seq_num;
+	__le32 tcp_ack_num;
+	__le16 info3;
+	__le16 window_size;
+	__le16 tcp_udp_cksum;
+	__le16 info4;
+	__le16 sa_idx;
+	__le16 da_idx;
+	__le32 info5;
+	__le32 fse_metadata;
+	__le16 cce_metadata;
+	__le16 sa_sw_peer_id;
+	__le32 info6;
+	__le16 cum_l4_cksum;
+	__le16 cum_ip_length;
+} __packed;
+
 /* rx_msdu_end
  *
  * rxpcu_mpdu_filter_in_category
@@ -1190,16 +1362,16 @@ struct rx_mpdu_end {
 
 #define HAL_RX_DESC_HDR_STATUS_LEN	120
 
-struct hal_rx_desc {
+struct hal_rx_desc_ipq8074 {
 	__le32 msdu_end_tag;
-	struct rx_msdu_end msdu_end;
+	struct rx_msdu_end_ipq8074 msdu_end;
 	__le32 rx_attn_tag;
 	struct rx_attention attention;
 	__le32 msdu_start_tag;
-	struct rx_msdu_start msdu_start;
+	struct rx_msdu_start_ipq8074 msdu_start;
 	u8 rx_padding0[HAL_RX_DESC_PADDING0_BYTES];
 	__le32 mpdu_start_tag;
-	struct rx_mpdu_start mpdu_start;
+	struct rx_mpdu_start_ipq8074 mpdu_start;
 	__le32 mpdu_end_tag;
 	struct rx_mpdu_end mpdu_end;
 	u8 rx_padding1[HAL_RX_DESC_PADDING1_BYTES];
@@ -1209,6 +1381,32 @@ struct hal_rx_desc {
 	u8 msdu_payload[0];
 } __packed;
 
+struct hal_rx_desc_qcn9074 {
+	__le32 msdu_end_tag;
+	struct rx_msdu_end_qcn9074 msdu_end;
+	__le32 rx_attn_tag;
+	struct rx_attention attention;
+	__le32 msdu_start_tag;
+	struct rx_msdu_start_qcn9074 msdu_start;
+	u8 rx_padding0[HAL_RX_DESC_PADDING0_BYTES];
+	__le32 mpdu_start_tag;
+	struct rx_mpdu_start_qcn9074 mpdu_start;
+	__le32 mpdu_end_tag;
+	struct rx_mpdu_end mpdu_end;
+	u8 rx_padding1[HAL_RX_DESC_PADDING1_BYTES];
+	__le32 hdr_status_tag;
+	__le32 phy_ppdu_id;
+	u8 hdr_status[HAL_RX_DESC_HDR_STATUS_LEN];
+	u8 msdu_payload[0];
+} __packed;
+
+struct hal_rx_desc {
+	union {
+		struct hal_rx_desc_ipq8074 ipq8074;
+		struct hal_rx_desc_qcn9074 qcn9074;
+	} u;
+} __packed;
+
 #define HAL_RX_RU_ALLOC_TYPE_MAX 6
 #define RU_26  1
 #define RU_52  2
-- 
2.7.4

