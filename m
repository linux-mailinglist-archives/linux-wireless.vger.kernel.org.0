Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB86FBDBD
	for <lists+linux-wireless@lfdr.de>; Tue,  9 May 2023 05:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjEIDhe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 23:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjEIDg7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 23:36:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E6F4222
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 20:36:56 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3492tb13012886;
        Tue, 9 May 2023 03:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=0TZ2jqYSAs30nemRzIYzcpvnW6cbVRHyodmYPGx3whc=;
 b=f9+TTDNn+NTTuv8bpXJ0sCSOz1GnqQ7Jt3tLn7PnNkK3ircUS1jJrX/EbGX6OHj8KDC4
 6DA1SFqs4es/X+UTiHwwwGseQneg9l8fmrSJ5B/P0oR4AKfyrhCbd2pn30iDfclaQ2+/
 CwTxXuj7Yrl6MZI43bsJ3ldhbAueweMsimZP7O0UjaMY2c+WQ/bRiz50wI1Dda0mjczA
 nI1eEy99Ob0nIEc2H0+JZXt4h8XjRCKHzafb6gpdwvZft/GjHaQJ0E1yunBiF2MBS4dq
 GWCBkCM+VmemYo4NdAbCCUxP+qjFAk2fOIEodokUwrtTV8lUEf8pUD1qzuXofmZgYuQz MQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf77krpjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 03:36:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3493aqqb008660
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 03:36:52 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 8 May 2023
 20:36:51 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] wifi: ath12k: Use msdu_end to check MCBC
Date:   Tue, 9 May 2023 11:36:38 +0800
Message-ID: <20230509033638.3228-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j03lo1kp_76cNQhA_jYZnkjNmA0X6qqD
X-Proofpoint-ORIG-GUID: j03lo1kp_76cNQhA_jYZnkjNmA0X6qqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=912 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090025
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are seeing a very low TCP throughput testing with some specific
tools. This is because for sub-frames of an AMSDU, MCBC flag in
mpdu_start may be not valid, and as a result those frames would be
dropped by kernel.

Add a new helper to get it from msdu_end.

Since original helper is not used for now, add __maybe_unused
attribute to make GCC happy.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v2:
 1. add a new helper according to Vasanth's comment.
 2. change to use __le16_to_cpu instead of __le32_to_cpu

 drivers/net/wireless/ath/ath12k/dp_rx.c | 13 ++++++++++---
 drivers/net/wireless/ath/ath12k/hal.c   | 14 ++++++++++++++
 drivers/net/wireless/ath/ath12k/hal.h   |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 8c8162fbe5c6..972034b7f159 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -193,13 +193,20 @@ static void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
 	ab->hw_params->hal_ops->rx_desc_set_msdu_len(desc, len);
 }
 
-static bool ath12k_dp_rx_h_is_mcbc(struct ath12k_base *ab,
-				   struct hal_rx_desc *desc)
+static __maybe_unused bool ath12k_dp_rx_h_is_mcbc(struct ath12k_base *ab,
+						  struct hal_rx_desc *desc)
 {
 	return (ath12k_dp_rx_h_first_msdu(ab, desc) &&
 		ab->hw_params->hal_ops->rx_desc_is_mcbc(desc));
 }
 
+static bool ath12k_dp_rx_h_is_da_mcbc(struct ath12k_base *ab,
+				      struct hal_rx_desc *desc)
+{
+	return (ath12k_dp_rx_h_first_msdu(ab, desc) &&
+		ab->hw_params->hal_ops->rx_desc_is_da_mcbc(desc));
+}
+
 static bool ath12k_dp_rxdesc_mac_addr2_valid(struct ath12k_base *ab,
 					     struct hal_rx_desc *desc)
 {
@@ -2208,7 +2215,7 @@ static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 
 	/* PN for multicast packets will be checked in mac80211 */
 	rxcb = ATH12K_SKB_RXCB(msdu);
-	fill_crypto_hdr = ath12k_dp_rx_h_is_mcbc(ar->ab, rx_desc);
+	fill_crypto_hdr = ath12k_dp_rx_h_is_da_mcbc(ar->ab, rx_desc);
 	rxcb->is_mcbc = fill_crypto_hdr;
 
 	if (rxcb->is_mcbc)
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 0ec53afe9915..b25fa1200656 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -453,6 +453,12 @@ static bool ath12k_hw_qcn9274_rx_desc_is_mcbc(struct hal_rx_desc *desc)
 	       RX_MPDU_START_INFO6_MCAST_BCAST;
 }
 
+static bool ath12k_hw_qcn9274_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.qcn9274.msdu_end.info5) &
+	       RX_MSDU_END_INFO5_DA_IS_MCBC;
+}
+
 static void ath12k_hw_qcn9274_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
 						    struct ieee80211_hdr *hdr)
 {
@@ -709,6 +715,7 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_desc_mac_addr2_valid = ath12k_hw_qcn9274_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath12k_hw_qcn9274_rx_desc_mpdu_start_addr2,
 	.rx_desc_is_mcbc = ath12k_hw_qcn9274_rx_desc_is_mcbc,
+	.rx_desc_is_da_mcbc = ath12k_hw_qcn9274_rx_desc_is_da_mcbc,
 	.rx_desc_get_dot11_hdr = ath12k_hw_qcn9274_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_qcn9274_rx_desc_get_crypto_hdr,
 	.rx_desc_get_mpdu_frame_ctl = ath12k_hw_qcn9274_rx_desc_get_mpdu_frame_ctl,
@@ -893,6 +900,12 @@ static bool ath12k_hw_wcn7850_rx_desc_is_mcbc(struct hal_rx_desc *desc)
 	       RX_MPDU_START_INFO6_MCAST_BCAST;
 }
 
+static bool ath12k_hw_wcn7850_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.wcn7850.msdu_end.info5) &
+	       RX_MSDU_END_INFO5_DA_IS_MCBC;
+}
+
 static void ath12k_hw_wcn7850_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
 						    struct ieee80211_hdr *hdr)
 {
@@ -1164,6 +1177,7 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_desc_mac_addr2_valid = ath12k_hw_wcn7850_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2,
 	.rx_desc_is_mcbc = ath12k_hw_wcn7850_rx_desc_is_mcbc,
+	.rx_desc_is_da_mcbc = ath12k_hw_wcn7850_rx_desc_is_da_mcbc,
 	.rx_desc_get_dot11_hdr = ath12k_hw_wcn7850_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_wcn7850_rx_desc_get_crypto_hdr,
 	.rx_desc_get_mpdu_frame_ctl = ath12k_hw_wcn7850_rx_desc_get_mpdu_frame_ctl,
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 0d4fa12ea622..88c0d022f5f6 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1064,6 +1064,7 @@ struct hal_ops {
 	bool (*rx_desc_mac_addr2_valid)(struct hal_rx_desc *desc);
 	u8* (*rx_desc_mpdu_start_addr2)(struct hal_rx_desc *desc);
 	bool (*rx_desc_is_mcbc)(struct hal_rx_desc *desc);
+	bool (*rx_desc_is_da_mcbc)(struct hal_rx_desc *desc);
 	void (*rx_desc_get_dot11_hdr)(struct hal_rx_desc *desc,
 				      struct ieee80211_hdr *hdr);
 	u16 (*rx_desc_get_mpdu_frame_ctl)(struct hal_rx_desc *desc);

base-commit: 858793444bc68ad8e8fa73d20055aa8da8ab591b
-- 
2.25.1

