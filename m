Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D514463D40
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 18:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244852AbhK3Ryq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 12:54:46 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:33632 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245202AbhK3Ryl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 12:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638294682; x=1669830682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7C9yaLF8HRZcTFko5EAEXspKBHdav//DPFs6qRGyTRg=;
  b=UoFIX4wuwIx5m6vyPEuXLTmZVxevCjL38q3WtBeKBWNm5mGp8mov34u2
   M3cFl5MppDE+vYLgHdcJl5fpe772bvy2aPtmgS3060UkTM5I7PzCGx5vI
   GoLJgFkCr6AJURJF3gPXt0s7jbi1Z7vjrB/pQthlF/WsgAecprpgn/XQE
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Nov 2021 09:51:21 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 09:51:21 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 09:51:21 -0800
Received: from ppranees-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 09:51:19 -0800
From:   P Praneesh <quic_ppranees@quicinc.com>
To:     <ath11k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH 2/2] ath11k: add LDPC FEC type in 802.11 radiotap header
Date:   Tue, 30 Nov 2021 23:20:48 +0530
Message-ID: <1638294648-844-3-git-send-email-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638294648-844-1-git-send-email-quic_ppranees@quicinc.com>
References: <1638294648-844-1-git-send-email-quic_ppranees@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

LDPC is one the FEC type advertised in msdu_start info2 for HT packet
type. Hence, add hardware specific callback for fetching LDPC
support from msdu start and enable RX_ENC_FLAG_LDPC flag while passing
rx status to mac80211.

Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 12 +++++++++++-
 drivers/net/wireless/ath/ath11k/hw.c    | 16 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h    |  1 +
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 40f1c86..ed14a90 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -43,6 +43,13 @@ static inline u8 ath11k_dp_rx_h_msdu_start_decap_type(struct ath11k_base *ab,
 }
 
 static inline
+bool ath11k_dp_rx_h_msdu_start_ldpc_support(struct ath11k_base *ab,
+					    struct hal_rx_desc *desc)
+{
+	return ab->hw_params.hw_ops->rx_desc_get_ldpc_support(desc);
+}
+
+static inline
 u8 ath11k_dp_rx_h_msdu_start_mesh_ctl_present(struct ath11k_base *ab,
 					      struct hal_rx_desc *desc)
 {
@@ -2331,7 +2338,7 @@ static void ath11k_dp_rx_h_rate(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 	u8 bw;
 	u8 rate_mcs, nss;
 	u8 sgi;
-	bool is_cck;
+	bool is_cck, is_ldpc;
 
 	pkt_type = ath11k_dp_rx_h_msdu_start_pkt_type(ar->ab, rx_desc);
 	bw = ath11k_dp_rx_h_msdu_start_rx_bw(ar->ab, rx_desc);
@@ -2373,6 +2380,9 @@ static void ath11k_dp_rx_h_rate(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 		if (sgi)
 			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 		rx_status->bw = ath11k_mac_bw_to_mac80211_bw(bw);
+		is_ldpc = ath11k_dp_rx_h_msdu_start_ldpc_support(ar->ab, rx_desc);
+		if (is_ldpc)
+			rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
 		break;
 	case RX_MSDU_START_PKT_TYPE_11AX:
 		rx_status->rate_idx = rate_mcs;
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 2f0b526..25e902d 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -273,6 +273,12 @@ static u8 ath11k_hw_ipq8074_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
 			 __le32_to_cpu(desc->u.ipq8074.msdu_start.info2));
 }
 
+static bool ath11k_hw_ipq8074_rx_desc_get_ldpc_support(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO2_LDPC,
+			 __le32_to_cpu(desc->u.ipq8074.msdu_start.info2));
+}
+
 static bool ath11k_hw_ipq8074_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
 {
 	return !!FIELD_GET(RX_MPDU_START_INFO1_MPDU_SEQ_CTRL_VALID,
@@ -444,6 +450,12 @@ static u8 ath11k_hw_qcn9074_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
 			 __le32_to_cpu(desc->u.qcn9074.msdu_start.info2));
 }
 
+static bool ath11k_hw_qcn9074_rx_desc_get_ldpc_support(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO2_LDPC,
+			 __le32_to_cpu(desc->u.qcn9074.msdu_start.info2));
+}
+
 static bool ath11k_hw_qcn9074_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
 {
 	return !!FIELD_GET(RX_MPDU_START_INFO11_MPDU_SEQ_CTRL_VALID,
@@ -815,6 +827,7 @@ const struct ath11k_hw_ops ipq8074_ops = {
 	.rx_desc_get_encrypt_type = ath11k_hw_ipq8074_rx_desc_get_encrypt_type,
 	.rx_desc_get_decap_type = ath11k_hw_ipq8074_rx_desc_get_decap_type,
 	.rx_desc_get_mesh_ctl = ath11k_hw_ipq8074_rx_desc_get_mesh_ctl,
+	.rx_desc_get_ldpc_support = ath11k_hw_ipq8074_rx_desc_get_ldpc_support,
 	.rx_desc_get_mpdu_seq_ctl_vld = ath11k_hw_ipq8074_rx_desc_get_mpdu_seq_ctl_vld,
 	.rx_desc_get_mpdu_fc_valid = ath11k_hw_ipq8074_rx_desc_get_mpdu_fc_valid,
 	.rx_desc_get_mpdu_start_seq_no = ath11k_hw_ipq8074_rx_desc_get_mpdu_start_seq_no,
@@ -853,6 +866,7 @@ const struct ath11k_hw_ops ipq6018_ops = {
 	.rx_desc_get_encrypt_type = ath11k_hw_ipq8074_rx_desc_get_encrypt_type,
 	.rx_desc_get_decap_type = ath11k_hw_ipq8074_rx_desc_get_decap_type,
 	.rx_desc_get_mesh_ctl = ath11k_hw_ipq8074_rx_desc_get_mesh_ctl,
+	.rx_desc_get_ldpc_support = ath11k_hw_ipq8074_rx_desc_get_ldpc_support,
 	.rx_desc_get_mpdu_seq_ctl_vld = ath11k_hw_ipq8074_rx_desc_get_mpdu_seq_ctl_vld,
 	.rx_desc_get_mpdu_fc_valid = ath11k_hw_ipq8074_rx_desc_get_mpdu_fc_valid,
 	.rx_desc_get_mpdu_start_seq_no = ath11k_hw_ipq8074_rx_desc_get_mpdu_start_seq_no,
@@ -891,6 +905,7 @@ const struct ath11k_hw_ops qca6390_ops = {
 	.rx_desc_get_encrypt_type = ath11k_hw_ipq8074_rx_desc_get_encrypt_type,
 	.rx_desc_get_decap_type = ath11k_hw_ipq8074_rx_desc_get_decap_type,
 	.rx_desc_get_mesh_ctl = ath11k_hw_ipq8074_rx_desc_get_mesh_ctl,
+	.rx_desc_get_ldpc_support = ath11k_hw_ipq8074_rx_desc_get_ldpc_support,
 	.rx_desc_get_mpdu_seq_ctl_vld = ath11k_hw_ipq8074_rx_desc_get_mpdu_seq_ctl_vld,
 	.rx_desc_get_mpdu_fc_valid = ath11k_hw_ipq8074_rx_desc_get_mpdu_fc_valid,
 	.rx_desc_get_mpdu_start_seq_no = ath11k_hw_ipq8074_rx_desc_get_mpdu_start_seq_no,
@@ -929,6 +944,7 @@ const struct ath11k_hw_ops qcn9074_ops = {
 	.rx_desc_get_encrypt_type = ath11k_hw_qcn9074_rx_desc_get_encrypt_type,
 	.rx_desc_get_decap_type = ath11k_hw_qcn9074_rx_desc_get_decap_type,
 	.rx_desc_get_mesh_ctl = ath11k_hw_qcn9074_rx_desc_get_mesh_ctl,
+	.rx_desc_get_ldpc_support = ath11k_hw_qcn9074_rx_desc_get_ldpc_support,
 	.rx_desc_get_mpdu_seq_ctl_vld = ath11k_hw_qcn9074_rx_desc_get_mpdu_seq_ctl_vld,
 	.rx_desc_get_mpdu_fc_valid = ath11k_hw_qcn9074_rx_desc_get_mpdu_fc_valid,
 	.rx_desc_get_mpdu_start_seq_no = ath11k_hw_qcn9074_rx_desc_get_mpdu_start_seq_no,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 2c9d232..e025eda 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -199,6 +199,7 @@ struct ath11k_hw_ops {
 	u32 (*rx_desc_get_encrypt_type)(struct hal_rx_desc *desc);
 	u8 (*rx_desc_get_decap_type)(struct hal_rx_desc *desc);
 	u8 (*rx_desc_get_mesh_ctl)(struct hal_rx_desc *desc);
+	bool (*rx_desc_get_ldpc_support)(struct hal_rx_desc *desc);
 	bool (*rx_desc_get_mpdu_seq_ctl_vld)(struct hal_rx_desc *desc);
 	bool (*rx_desc_get_mpdu_fc_valid)(struct hal_rx_desc *desc);
 	u16 (*rx_desc_get_mpdu_start_seq_no)(struct hal_rx_desc *desc);
-- 
2.7.4

