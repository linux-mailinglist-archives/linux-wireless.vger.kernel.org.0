Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B0633D7E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 14:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiKVNWl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 08:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiKVNWX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 08:22:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013D96454C
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 05:22:21 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMBmdb6010501;
        Tue, 22 Nov 2022 13:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=J12QCtSDhxpemVQ8EUqgMXVE7xBnjGNzgHG/deKJvMc=;
 b=J74ec4QOj60wR5llfkrO4FMtz6pCFlbNJbc+UE5xmo4VlYlt0Og41Ep9+vcD4bCgsq18
 trnwKn2ugLAF4XWYHL9uXALClBcDFpR0X0eI5/te9sWq7567s2a2h8DugRITIsV8e6aW
 5eEuwrvRjkl0lmEJPFjX1f4MKCpCpCeXS7sr7XpP4tNCPRu0u5Cyvk3rqQVtF5IPn++T
 Dv73uW+nZmGr7toQjepyI6dKC8j2lRORrHybUplfxuDojAIWQ69uWtPxIgQUR3Es/Ko1
 Nz+FY6S/LDVxW8lv4Ytx6tj6fSRiNvikjLyizuDT8RQzaedPUT/BcXe34wfK+08hgppQ RA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m0hwp9ntn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 13:22:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AMDMJhi004050
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 13:22:19 GMT
Received: from kathirve-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 22 Nov 2022 05:22:17 -0800
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Subject: [PATCHv2 6/8] wifi: ath11k: initialize hw_ops for IPQ5018
Date:   Tue, 22 Nov 2022 18:51:50 +0530
Message-ID: <20221122132152.17771-7-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221122132152.17771-1-quic_kathirve@quicinc.com>
References: <20221122132152.17771-1-quic_kathirve@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yiT_f-r283Dnv-SSihaZvC-zxDxA-Tlr
X-Proofpoint-ORIG-GUID: yiT_f-r283Dnv-SSihaZvC-zxDxA-Tlr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211220098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sriram R <quic_srirrama@quicinc.com>

The ipq5018_ops is initialized for IPQ5018. This is different from
other platforms.

Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/hw.c   | 40 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 3 files changed, 42 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 127d7317ac69..25cda5044a06 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -635,6 +635,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		},
 		.internal_sleep_clock = false,
 		.regs = &ipq5018_regs,
+		.hw_ops = &ipq5018_ops,
 		.host_ce_config = ath11k_host_ce_config_qcn9074,
 		.ce_count = CE_CNT_5018,
 		.target_ce_config = ath11k_target_ce_config_wlan_ipq5018,
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index ce62e26df70c..39a97a779b61 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1084,6 +1084,46 @@ const struct ath11k_hw_ops wcn6750_ops = {
 	.get_ring_selector = ath11k_hw_wcn6750_get_tcl_ring_selector,
 };
 
+/* IPQ5018 hw ops is similar to QCN9074 except for the dest ring remap */
+const struct ath11k_hw_ops ipq5018_ops = {
+	.get_hw_mac_from_pdev_id = ath11k_hw_ipq6018_mac_from_pdev_id,
+	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
+	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_ipq8074,
+	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_ipq8074,
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
+	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
+	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
+	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2,
+
+};
+
 #define ATH11K_TX_RING_MASK_0 BIT(0)
 #define ATH11K_TX_RING_MASK_1 BIT(1)
 #define ATH11K_TX_RING_MASK_2 BIT(2)
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index b8afd51d0c1e..9f45d061d826 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -275,6 +275,7 @@ extern const struct ath11k_hw_ops qca6390_ops;
 extern const struct ath11k_hw_ops qcn9074_ops;
 extern const struct ath11k_hw_ops wcn6855_ops;
 extern const struct ath11k_hw_ops wcn6750_ops;
+extern const struct ath11k_hw_ops ipq5018_ops;
 
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390;
-- 
2.17.1

