Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACB45F64BC
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 13:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJFLAz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 07:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiJFLAd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 07:00:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052C8C17
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 04:00:32 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296AqI0P029835;
        Thu, 6 Oct 2022 11:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=FUpW+TcHJwzFUTK2T06ChfCe8BXBkuBely7XwKdn/8k=;
 b=LN9TWYzwLanJ/yxnfC2k9uq8hxZZErnEqWalV/xFqhy8w+vOlkDEx97f1cwwZWlA0kB/
 myUZc0MXblJLBA28i0PTKR/aV5AuTRZIo7TCQ56yiHa2tOgBo/iodHcq0IhOexoRp6sH
 SKGVgGerKNr2wUSrRV3qst+1O3L05c5hKw6qsm6KrwmngIZoTMled/z5jMKVXeytIfnN
 3cjbb4zf+y3r9FhXkSNDN0k3emkswJNRqAOeRJYu8ILzqeQM87y4hAZOHpmbiTnlTb2a
 i4/sQRN1wTS1uCFLSMZJfVY5VlLUSTvzKJUpP5Z21ec6RAfT/MKNTqygSDSfYXn8OuK6 pg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0rf43uvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 11:00:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 296B0SjV017405
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 11:00:28 GMT
Received: from kathirve-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 6 Oct 2022 04:00:26 -0700
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Subject: [PATCH 7/8] wifi: ath11k: add new hw ops for IPQ5018 to get rx dest ring hashmap
Date:   Thu, 6 Oct 2022 16:29:12 +0530
Message-ID: <20221006105913.18356-8-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221006105913.18356-1-quic_kathirve@quicinc.com>
References: <20221006105913.18356-1-quic_kathirve@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CEk7U8onRqfq3CGgy-fRgMr7S8NEcpKQ
X-Proofpoint-ORIG-GUID: CEk7U8onRqfq3CGgy-fRgMr7S8NEcpKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sriram R <quic_srirrama@quicinc.com>

The Destination ring control register is different
for IPQ5018 when compared to IPQ8074/IPQ6018/QCN9074.
Hence create a new hw ops to fetch the hash ring map
for different device variants. ipq5018 hw ops
is similar to qcn9074 except for this change, so reuse
all the qcn9074 ops for ipq5018.

Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.5.0.1-01192-QCAHKSWPL_SILICONZ-1 v1

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hw.c | 44 ++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index bd77314de65e..3ece72b587a5 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -791,6 +791,49 @@ static void ath11k_hw_wcn6855_reo_setup(struct ath11k_base *ab)
 			   ring_hash_map);
 }
 
+static void ath11k_hw_ipq5018_reo_setup(struct ath11k_base *ab)
+{
+	u32 reo_base = HAL_SEQ_WCSS_UMAC_REO_REG;
+	u32 val;
+
+	/* Each hash entry uses three bits to map to a particular ring. */
+	u32 ring_hash_map = HAL_HASH_ROUTING_RING_SW1 << 0 |
+		HAL_HASH_ROUTING_RING_SW2 << 4 |
+		HAL_HASH_ROUTING_RING_SW3 << 8 |
+		HAL_HASH_ROUTING_RING_SW4 << 12 |
+		HAL_HASH_ROUTING_RING_SW1 << 16 |
+		HAL_HASH_ROUTING_RING_SW2 << 20 |
+		HAL_HASH_ROUTING_RING_SW3 << 24 |
+		HAL_HASH_ROUTING_RING_SW4 << 28;
+
+	val = ath11k_hif_read32(ab, reo_base + HAL_REO1_GEN_ENABLE);
+
+	val &= ~HAL_REO1_GEN_ENABLE_FRAG_DST_RING;
+	val |= FIELD_PREP(HAL_REO1_GEN_ENABLE_FRAG_DST_RING,
+			HAL_SRNG_RING_ID_REO2SW1) |
+		FIELD_PREP(HAL_REO1_GEN_ENABLE_AGING_LIST_ENABLE, 1) |
+		FIELD_PREP(HAL_REO1_GEN_ENABLE_AGING_FLUSH_ENABLE, 1);
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_GEN_ENABLE, val);
+
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_0(ab),
+			   HAL_DEFAULT_REO_TIMEOUT_USEC);
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_1(ab),
+			   HAL_DEFAULT_REO_TIMEOUT_USEC);
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_2(ab),
+			   HAL_DEFAULT_REO_TIMEOUT_USEC);
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_3(ab),
+			   HAL_DEFAULT_REO_TIMEOUT_USEC);
+
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_0,
+			   ring_hash_map);
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_1,
+			   ring_hash_map);
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_2,
+			   ring_hash_map);
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_3,
+			   ring_hash_map);
+}
+
 static u16 ath11k_hw_ipq8074_mpdu_info_get_peerid(u8 *tlv_data)
 {
 	u16 peer_id = 0;
@@ -1117,6 +1160,7 @@ const struct ath11k_hw_ops ipq5018_ops = {
 	.rx_desc_get_mpdu_ppdu_id = ath11k_hw_qcn9074_rx_desc_get_mpdu_ppdu_id,
 	.rx_desc_set_msdu_len = ath11k_hw_qcn9074_rx_desc_set_msdu_len,
 	.rx_desc_get_attention = ath11k_hw_qcn9074_rx_desc_get_attention,
+	.reo_setup = ath11k_hw_ipq5018_reo_setup,
 	.rx_desc_get_msdu_payload = ath11k_hw_qcn9074_rx_desc_get_msdu_payload,
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
-- 
2.38.0

