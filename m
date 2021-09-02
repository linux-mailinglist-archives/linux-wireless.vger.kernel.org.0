Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BFC3FE8BF
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Sep 2021 07:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhIBFf7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Sep 2021 01:35:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51275 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231996AbhIBFfz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Sep 2021 01:35:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630560897; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=GFoJidY/sdda2ISwneKC1H4HOktMe1hobz2cQIftxOY=; b=fFv5F6AR9vyRfwXI1c4WUgSoGH3Y2AeqyMPoIxD0Ajxdf+OzMilKVgkGAAOZAZtOfnne74Eh
 VXCDXRHTqczyl+rYWF9EZYr3oVj379RwcTWDaIU28RbUIg3vrtU+021M+NUgIdUo6PPf/gi3
 yFWHeOeU+6SlXcje0fEPyUFFvjI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 613062796fc2cf7ad9208ce3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Sep 2021 05:34:49
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD69CC4360D; Thu,  2 Sep 2021 05:34:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF1F0C43460;
        Thu,  2 Sep 2021 05:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org DF1F0C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH v3 03/12] ath11k: modify dp_rx desc access wrapper calls inline
Date:   Thu,  2 Sep 2021 11:03:31 +0530
Message-Id: <1630560820-21905-4-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org>
References: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In data path, to reduce the CPU cycles spending on descriptor access
wrapper function, changed those functions as static inline.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 114 +++++++++++++++++---------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 9a22481..b84c2db 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -20,13 +20,15 @@
 
 #define ATH11K_DP_RX_FRAGMENT_TIMEOUT_MS (2 * HZ)
 
-static u8 *ath11k_dp_rx_h_80211_hdr(struct ath11k_base *ab, struct hal_rx_desc *desc)
+static inline
+u8 *ath11k_dp_rx_h_80211_hdr(struct ath11k_base *ab, struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_hdr_status(desc);
 }
 
-static enum hal_encrypt_type ath11k_dp_rx_h_mpdu_start_enctype(struct ath11k_base *ab,
-							       struct hal_rx_desc *desc)
+static inline
+enum hal_encrypt_type ath11k_dp_rx_h_mpdu_start_enctype(struct ath11k_base *ab,
+							struct hal_rx_desc *desc)
 {
 	if (!ab->hw_params.hw_ops->rx_desc_encrypt_valid(desc))
 		return HAL_ENCRYPT_TYPE_OPEN;
@@ -34,32 +36,34 @@ static enum hal_encrypt_type ath11k_dp_rx_h_mpdu_start_enctype(struct ath11k_bas
 	return ab->hw_params.hw_ops->rx_desc_get_encrypt_type(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_decap_type(struct ath11k_base *ab,
-					       struct hal_rx_desc *desc)
+static inline u8 ath11k_dp_rx_h_msdu_start_decap_type(struct ath11k_base *ab,
+						      struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_decap_type(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_mesh_ctl_present(struct ath11k_base *ab,
-						     struct hal_rx_desc *desc)
+static inline
+u8 ath11k_dp_rx_h_msdu_start_mesh_ctl_present(struct ath11k_base *ab,
+					      struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_mesh_ctl(desc);
 }
 
-static bool ath11k_dp_rx_h_mpdu_start_seq_ctrl_valid(struct ath11k_base *ab,
-						     struct hal_rx_desc *desc)
+static inline
+bool ath11k_dp_rx_h_mpdu_start_seq_ctrl_valid(struct ath11k_base *ab,
+					      struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_mpdu_seq_ctl_vld(desc);
 }
 
-static bool ath11k_dp_rx_h_mpdu_start_fc_valid(struct ath11k_base *ab,
-					       struct hal_rx_desc *desc)
+static inline bool ath11k_dp_rx_h_mpdu_start_fc_valid(struct ath11k_base *ab,
+						      struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_mpdu_fc_valid(desc);
 }
 
-static bool ath11k_dp_rx_h_mpdu_start_more_frags(struct ath11k_base *ab,
-						 struct sk_buff *skb)
+static inline bool ath11k_dp_rx_h_mpdu_start_more_frags(struct ath11k_base *ab,
+							struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr;
 
@@ -67,8 +71,8 @@ static bool ath11k_dp_rx_h_mpdu_start_more_frags(struct ath11k_base *ab,
 	return ieee80211_has_morefrags(hdr->frame_control);
 }
 
-static u16 ath11k_dp_rx_h_mpdu_start_frag_no(struct ath11k_base *ab,
-					     struct sk_buff *skb)
+static inline u16 ath11k_dp_rx_h_mpdu_start_frag_no(struct ath11k_base *ab,
+						    struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr;
 
@@ -76,37 +80,37 @@ static u16 ath11k_dp_rx_h_mpdu_start_frag_no(struct ath11k_base *ab,
 	return le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;
 }
 
-static u16 ath11k_dp_rx_h_mpdu_start_seq_no(struct ath11k_base *ab,
-					    struct hal_rx_desc *desc)
+static inline u16 ath11k_dp_rx_h_mpdu_start_seq_no(struct ath11k_base *ab,
+						   struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_mpdu_start_seq_no(desc);
 }
 
-static void *ath11k_dp_rx_get_attention(struct ath11k_base *ab,
-					struct hal_rx_desc *desc)
+static inline void *ath11k_dp_rx_get_attention(struct ath11k_base *ab,
+					       struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_attention(desc);
 }
 
-static bool ath11k_dp_rx_h_attn_msdu_done(struct rx_attention *attn)
+static inline bool ath11k_dp_rx_h_attn_msdu_done(struct rx_attention *attn)
 {
 	return !!FIELD_GET(RX_ATTENTION_INFO2_MSDU_DONE,
 			   __le32_to_cpu(attn->info2));
 }
 
-static bool ath11k_dp_rx_h_attn_l4_cksum_fail(struct rx_attention *attn)
+static inline bool ath11k_dp_rx_h_attn_l4_cksum_fail(struct rx_attention *attn)
 {
 	return !!FIELD_GET(RX_ATTENTION_INFO1_TCP_UDP_CKSUM_FAIL,
 			   __le32_to_cpu(attn->info1));
 }
 
-static bool ath11k_dp_rx_h_attn_ip_cksum_fail(struct rx_attention *attn)
+static inline bool ath11k_dp_rx_h_attn_ip_cksum_fail(struct rx_attention *attn)
 {
 	return !!FIELD_GET(RX_ATTENTION_INFO1_IP_CKSUM_FAIL,
 			   __le32_to_cpu(attn->info1));
 }
 
-static bool ath11k_dp_rx_h_attn_is_decrypted(struct rx_attention *attn)
+static inline bool ath11k_dp_rx_h_attn_is_decrypted(struct rx_attention *attn)
 {
 	return (FIELD_GET(RX_ATTENTION_INFO2_DCRYPT_STATUS_CODE,
 			  __le32_to_cpu(attn->info2)) ==
@@ -142,68 +146,68 @@ static u32 ath11k_dp_rx_h_attn_mpdu_err(struct rx_attention *attn)
 	return errmap;
 }
 
-static u16 ath11k_dp_rx_h_msdu_start_msdu_len(struct ath11k_base *ab,
-					      struct hal_rx_desc *desc)
+static inline u16 ath11k_dp_rx_h_msdu_start_msdu_len(struct ath11k_base *ab,
+						     struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_msdu_len(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_sgi(struct ath11k_base *ab,
-					struct hal_rx_desc *desc)
+static inline u8 ath11k_dp_rx_h_msdu_start_sgi(struct ath11k_base *ab,
+					       struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_msdu_sgi(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_rate_mcs(struct ath11k_base *ab,
-					     struct hal_rx_desc *desc)
+static inline u8 ath11k_dp_rx_h_msdu_start_rate_mcs(struct ath11k_base *ab,
+						    struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_msdu_rate_mcs(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_rx_bw(struct ath11k_base *ab,
-					  struct hal_rx_desc *desc)
+static inline u8 ath11k_dp_rx_h_msdu_start_rx_bw(struct ath11k_base *ab,
+						 struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_msdu_rx_bw(desc);
 }
 
-static u32 ath11k_dp_rx_h_msdu_start_freq(struct ath11k_base *ab,
-					  struct hal_rx_desc *desc)
+static inline u32 ath11k_dp_rx_h_msdu_start_freq(struct ath11k_base *ab,
+						 struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_msdu_freq(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_pkt_type(struct ath11k_base *ab,
-					     struct hal_rx_desc *desc)
+static inline u8 ath11k_dp_rx_h_msdu_start_pkt_type(struct ath11k_base *ab,
+						    struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_msdu_pkt_type(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_start_nss(struct ath11k_base *ab,
-					struct hal_rx_desc *desc)
+static inline u8 ath11k_dp_rx_h_msdu_start_nss(struct ath11k_base *ab,
+					       struct hal_rx_desc *desc)
 {
 	return hweight8(ab->hw_params.hw_ops->rx_desc_get_msdu_nss(desc));
 }
 
-static u8 ath11k_dp_rx_h_mpdu_start_tid(struct ath11k_base *ab,
-					struct hal_rx_desc *desc)
+static inline u8 ath11k_dp_rx_h_mpdu_start_tid(struct ath11k_base *ab,
+					       struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_mpdu_tid(desc);
 }
 
-static u16 ath11k_dp_rx_h_mpdu_start_peer_id(struct ath11k_base *ab,
-					     struct hal_rx_desc *desc)
+static inline u16 ath11k_dp_rx_h_mpdu_start_peer_id(struct ath11k_base *ab,
+						    struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_mpdu_peer_id(desc);
 }
 
-static u8 ath11k_dp_rx_h_msdu_end_l3pad(struct ath11k_base *ab,
-					struct hal_rx_desc *desc)
+static inline u8 ath11k_dp_rx_h_msdu_end_l3pad(struct ath11k_base *ab,
+					       struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_l3_pad_bytes(desc);
 }
 
-static bool ath11k_dp_rx_h_msdu_end_first_msdu(struct ath11k_base *ab,
-					       struct hal_rx_desc *desc)
+static inline bool ath11k_dp_rx_h_msdu_end_first_msdu(struct ath11k_base *ab,
+						      struct hal_rx_desc *desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_first_msdu(desc);
 }
@@ -221,14 +225,14 @@ static void ath11k_dp_rx_desc_end_tlv_copy(struct ath11k_base *ab,
 	ab->hw_params.hw_ops->rx_desc_copy_attn_end_tlv(fdesc, ldesc);
 }
 
-static u32 ath11k_dp_rxdesc_get_mpdulen_err(struct rx_attention *attn)
+static inline u32 ath11k_dp_rxdesc_get_mpdulen_err(struct rx_attention *attn)
 {
 	return FIELD_GET(RX_ATTENTION_INFO1_MPDU_LEN_ERR,
 			 __le32_to_cpu(attn->info1));
 }
 
-static u8 *ath11k_dp_rxdesc_get_80211hdr(struct ath11k_base *ab,
-					 struct hal_rx_desc *rx_desc)
+static inline u8 *ath11k_dp_rxdesc_get_80211hdr(struct ath11k_base *ab,
+						struct hal_rx_desc *rx_desc)
 {
 	u8 *rx_pkt_hdr;
 
@@ -237,8 +241,8 @@ static u8 *ath11k_dp_rxdesc_get_80211hdr(struct ath11k_base *ab,
 	return rx_pkt_hdr;
 }
 
-static bool ath11k_dp_rxdesc_mpdu_valid(struct ath11k_base *ab,
-					struct hal_rx_desc *rx_desc)
+static inline bool ath11k_dp_rxdesc_mpdu_valid(struct ath11k_base *ab,
+					       struct hal_rx_desc *rx_desc)
 {
 	u32 tlv_tag;
 
@@ -247,15 +251,15 @@ static bool ath11k_dp_rxdesc_mpdu_valid(struct ath11k_base *ab,
 	return tlv_tag == HAL_RX_MPDU_START;
 }
 
-static u32 ath11k_dp_rxdesc_get_ppduid(struct ath11k_base *ab,
-				       struct hal_rx_desc *rx_desc)
+static inline u32 ath11k_dp_rxdesc_get_ppduid(struct ath11k_base *ab,
+					      struct hal_rx_desc *rx_desc)
 {
 	return ab->hw_params.hw_ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
 }
 
-static void ath11k_dp_rxdesc_set_msdu_len(struct ath11k_base *ab,
-					  struct hal_rx_desc *desc,
-					  u16 len)
+static inline void ath11k_dp_rxdesc_set_msdu_len(struct ath11k_base *ab,
+						 struct hal_rx_desc *desc,
+						 u16 len)
 {
 	ab->hw_params.hw_ops->rx_desc_set_msdu_len(desc, len);
 }
-- 
2.7.4

