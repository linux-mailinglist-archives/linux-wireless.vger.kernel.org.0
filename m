Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F724515159
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 19:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379438AbiD2RJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 13:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379412AbiD2RJ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 13:09:29 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70C481FD8;
        Fri, 29 Apr 2022 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651251970; x=1682787970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qfBnpAMNUTlWX29znUuMBqVhnl82Qu1aRSKlszGyDLA=;
  b=MdWvXypnmZ1374SwiWz4URTABBnDg/NfkOBd2GFAVostDjWQqWeZUXs8
   WQV+K1Iq5K0R6dtPDNX6OydHLk5L2yBomlSBkS8Y1MEZ7ZQLEbyBUR+fw
   2Bn//peVqzsfxrrNYBCjyCogYs8/u177mzKqgClAbgtRIripOwhaESvKv
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Apr 2022 10:06:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:06:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 10:05:48 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 10:05:46 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <mka@chromium.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v7 8/9] ath11k: Datapath changes to support WCN6750
Date:   Fri, 29 Apr 2022 22:35:01 +0530
Message-ID: <20220429170502.20080-9-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429170502.20080-1-quic_mpubbise@quicinc.com>
References: <20220429170502.20080-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HAL RX descriptor for WCN6750 is same as QCN9074, this
means that the size of the HAL RX decriptor and the DP
APIs that WCN6750 requires to enable datapath should be
initialized with that of QCN9074's RX descriptor size
and the DP APIs respectively. There is one change wrt to
REO configuration though, REO configuration for WCN6750
follows WCN6855, therefore use reo_setup() of WCN6855
for WCN6750.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/hw.c   | 32 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 7385e1c60ca1..01e1d494b527 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -531,6 +531,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.num_vdevs = 16 + 1,
 		.num_peers = 512,
 		.supports_suspend = false,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
 		.supports_regdb = true,
 		.fix_l1ss = false,
 		.credit_flow = true,
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index a9f5c4e63d62..09ce357f0f0d 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1020,6 +1020,38 @@ const struct ath11k_hw_ops wcn6750_ops = {
 	.wmi_init_config = ath11k_init_wmi_config_qca6390,
 	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_qca6390,
 	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_qca6390,
+	.tx_mesh_enable = ath11k_hw_qcn9074_tx_mesh_enable,
+	.rx_desc_get_first_msdu = ath11k_hw_qcn9074_rx_desc_get_first_msdu,
+	.rx_desc_get_last_msdu = ath11k_hw_qcn9074_rx_desc_get_last_msdu,
+	.rx_desc_get_l3_pad_bytes = ath11k_hw_qcn9074_rx_desc_get_l3_pad_bytes,
+	.rx_desc_get_hdr_status = ath11k_hw_qcn9074_rx_desc_get_hdr_status,
+	.rx_desc_encrypt_valid = ath11k_hw_qcn9074_rx_desc_encrypt_valid,
+	.rx_desc_get_encrypt_type = ath11k_hw_qcn9074_rx_desc_get_encrypt_type,
+	.rx_desc_get_decap_type = ath11k_hw_qcn9074_rx_desc_get_decap_type,
+	.rx_desc_get_mesh_ctl = ath11k_hw_qcn9074_rx_desc_get_mesh_ctl,
+	.rx_desc_get_ldpc_support = ath11k_hw_qcn9074_rx_desc_get_ldpc_support,
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
+	.reo_setup = ath11k_hw_wcn6855_reo_setup,
+	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
+	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
+	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2,
 };
 
 #define ATH11K_TX_RING_MASK_0 0x1
-- 
2.35.1

