Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE29171462E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 10:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjE2IQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 04:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjE2IQm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 04:16:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C190
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 01:16:40 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34T77OP9005773;
        Mon, 29 May 2023 08:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=x2KGN2ig6TCTvV4OBPBrr4W2B0jrBI9QQuiLADfxY54=;
 b=azu2cMEctuwoCZJRXiZx2+WKaTVaM3nYWrY0u2lOqhWuHefzl7x3ypPWEPIys4fIt9AE
 aQI2ulIm6tbfDWgjp1zNILH+qzdEMJBz21qzra9tfFkkLXvN5mAW4PS5K93W8huFneVm
 0+TqOCwRMkxVl8VDlSOzzP4S+M0GE9PQ4CMatVOgp4gDrJU8kmvagV2qZ7qehUSuuiRy
 L4/hOoeivD4gJEIdvvTjs6hFCk7d3B9c6GRe/OMQoA+2wfdz0TlHq8wl1BaoP8ZQQ1Yi
 v1K3mehuD6f9cMF9l/CwJqJTRIYaRP2RsfJQGolTCpzPEg7zJhob5riVR5ClZnbXDAqp WA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qub5djxyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 08:16:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34T8GJa8019744
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 08:16:19 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 29 May 2023 01:16:18 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3] wifi: ath12k: Use msdu_end to check MCBC
Date:   Mon, 29 May 2023 16:16:09 +0800
Message-ID: <20230529081609.34567-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: No44ztu3_WAY7wDOLXnCPBpjwEC087LW
X-Proofpoint-GUID: No44ztu3_WAY7wDOLXnCPBpjwEC087LW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_04,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=773 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305290071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are seeing a very low TCP throughput testing with some specific
tools. This is because for sub-frames of an AMSDU, MCBC flag in
mpdu_start may be not valid, and as a result those frames would be
dropped by kernel.

Add a new helper to get it from msdu_end. Also clean up original
helper since it is not needed any more.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v3:
 1. remove original helper since it is not needed.

v2:
 1. add a new helper according to Vasanth's comment.
 2. change to use __le16_to_cpu instead of __le32_to_cpu

 drivers/net/wireless/ath/ath12k/dp_rx.c |  8 ++++----
 drivers/net/wireless/ath/ath12k/hal.c   | 16 ++++++++--------
 drivers/net/wireless/ath/ath12k/hal.h   |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 8c8162fbe5c6..ffd9a2018610 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -193,11 +193,11 @@ static void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
 	ab->hw_params->hal_ops->rx_desc_set_msdu_len(desc, len);
 }
 
-static bool ath12k_dp_rx_h_is_mcbc(struct ath12k_base *ab,
-				   struct hal_rx_desc *desc)
+static bool ath12k_dp_rx_h_is_da_mcbc(struct ath12k_base *ab,
+				      struct hal_rx_desc *desc)
 {
 	return (ath12k_dp_rx_h_first_msdu(ab, desc) &&
-		ab->hw_params->hal_ops->rx_desc_is_mcbc(desc));
+		ab->hw_params->hal_ops->rx_desc_is_da_mcbc(desc));
 }
 
 static bool ath12k_dp_rxdesc_mac_addr2_valid(struct ath12k_base *ab,
@@ -2208,7 +2208,7 @@ static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 
 	/* PN for multicast packets will be checked in mac80211 */
 	rxcb = ATH12K_SKB_RXCB(msdu);
-	fill_crypto_hdr = ath12k_dp_rx_h_is_mcbc(ar->ab, rx_desc);
+	fill_crypto_hdr = ath12k_dp_rx_h_is_da_mcbc(ar->ab, rx_desc);
 	rxcb->is_mcbc = fill_crypto_hdr;
 
 	if (rxcb->is_mcbc)
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 0ec53afe9915..e7a150e7158e 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -447,10 +447,10 @@ static u8 *ath12k_hw_qcn9274_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
 	return desc->u.qcn9274.mpdu_start.addr2;
 }
 
-static bool ath12k_hw_qcn9274_rx_desc_is_mcbc(struct hal_rx_desc *desc)
+static bool ath12k_hw_qcn9274_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le32_to_cpu(desc->u.qcn9274.mpdu_start.info6) &
-	       RX_MPDU_START_INFO6_MCAST_BCAST;
+	return __le16_to_cpu(desc->u.qcn9274.msdu_end.info5) &
+	       RX_MSDU_END_INFO5_DA_IS_MCBC;
 }
 
 static void ath12k_hw_qcn9274_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
@@ -708,7 +708,7 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_desc_get_msdu_end_offset = ath12k_hw_qcn9274_rx_desc_get_msdu_end_offset,
 	.rx_desc_mac_addr2_valid = ath12k_hw_qcn9274_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath12k_hw_qcn9274_rx_desc_mpdu_start_addr2,
-	.rx_desc_is_mcbc = ath12k_hw_qcn9274_rx_desc_is_mcbc,
+	.rx_desc_is_da_mcbc = ath12k_hw_qcn9274_rx_desc_is_da_mcbc,
 	.rx_desc_get_dot11_hdr = ath12k_hw_qcn9274_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_qcn9274_rx_desc_get_crypto_hdr,
 	.rx_desc_get_mpdu_frame_ctl = ath12k_hw_qcn9274_rx_desc_get_mpdu_frame_ctl,
@@ -887,10 +887,10 @@ static u8 *ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
 	return desc->u.wcn7850.mpdu_start.addr2;
 }
 
-static bool ath12k_hw_wcn7850_rx_desc_is_mcbc(struct hal_rx_desc *desc)
+static bool ath12k_hw_wcn7850_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le32_to_cpu(desc->u.wcn7850.mpdu_start.info6) &
-	       RX_MPDU_START_INFO6_MCAST_BCAST;
+	return __le16_to_cpu(desc->u.wcn7850.msdu_end.info5) &
+	       RX_MSDU_END_INFO5_DA_IS_MCBC;
 }
 
 static void ath12k_hw_wcn7850_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
@@ -1163,7 +1163,7 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_desc_get_msdu_end_offset = ath12k_hw_wcn7850_rx_desc_get_msdu_end_offset,
 	.rx_desc_mac_addr2_valid = ath12k_hw_wcn7850_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2,
-	.rx_desc_is_mcbc = ath12k_hw_wcn7850_rx_desc_is_mcbc,
+	.rx_desc_is_da_mcbc = ath12k_hw_wcn7850_rx_desc_is_da_mcbc,
 	.rx_desc_get_dot11_hdr = ath12k_hw_wcn7850_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_wcn7850_rx_desc_get_crypto_hdr,
 	.rx_desc_get_mpdu_frame_ctl = ath12k_hw_wcn7850_rx_desc_get_mpdu_frame_ctl,
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 0d4fa12ea622..66035a787c72 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1063,7 +1063,7 @@ struct hal_ops {
 	u32 (*rx_desc_get_msdu_end_offset)(void);
 	bool (*rx_desc_mac_addr2_valid)(struct hal_rx_desc *desc);
 	u8* (*rx_desc_mpdu_start_addr2)(struct hal_rx_desc *desc);
-	bool (*rx_desc_is_mcbc)(struct hal_rx_desc *desc);
+	bool (*rx_desc_is_da_mcbc)(struct hal_rx_desc *desc);
 	void (*rx_desc_get_dot11_hdr)(struct hal_rx_desc *desc,
 				      struct ieee80211_hdr *hdr);
 	u16 (*rx_desc_get_mpdu_frame_ctl)(struct hal_rx_desc *desc);

base-commit: 4ab7f08db5310ded48a5c1f3ec3f2e177ba6b1c2
-- 
2.25.1

