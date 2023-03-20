Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C86C104C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 12:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCTLIW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 07:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjCTLIA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 07:08:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951A81B564
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 04:03:53 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K8PJVJ022463;
        Mon, 20 Mar 2023 11:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=qyGKriUovEi90eCubcSMPoWVgQF25Sy8dt628ZxhWLs=;
 b=pNXa3MMvLp3SGP9Zeo09KPrxHMZwbmq7Uc4V7zsAfY06QntIXpMXM/sHafi18utwalTr
 79s1Xvf/3BnnrE72IXvElKpWyWFcbQ/gV/2DHzZMn0L8USYb+XNeHHsYAr2WHn+DxIxK
 U45M30eoMb6Xo4x6V6ffK+uSBYeIZrWma6jnR84XSXz/krwmw+BR5Qy6jxLdW70rrh39
 73BzOpVV3G+UQLqpqKbHyoVhI5Oi9Ui081QJMVyLrtuq/SqejV5OjMwrQxemMj0NYLi7
 vsHQ4VtxrePIRPx0IuwTjlxHvmSprsCXuisGuQGNrWXn/kZrL3pd1/ovQr4hpjlsHQxk HA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pd4w8vktn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 11:03:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KB3ljb007292
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 11:03:48 GMT
Received: from ppranees-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Mar 2023 04:03:46 -0700
From:   P Praneesh <quic_ppranees@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix rssi station dump not updated in QCN9074
Date:   Mon, 20 Mar 2023 16:33:12 +0530
Message-ID: <20230320110312.20639-1-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wBnIuuLeSsGGKqrx7oNHBFA8C1HbNvla
X-Proofpoint-ORIG-GUID: wBnIuuLeSsGGKqrx7oNHBFA8C1HbNvla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_07,2023-03-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In QCN9074, station dump signal values display default value which
is -95 dbm, since there is firmware header change for HAL_RX_MPDU_START
between QCN9074 and IPQ8074 which cause wrong peer_id fetch from msdu.
Fix this by updating hal_rx_mpdu_info with corresponding QCN9074 tlv
format.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal_rx.c | 10 ++++++++-
 drivers/net/wireless/ath/ath11k/hal_rx.h | 18 +++++++++++++++-
 drivers/net/wireless/ath/ath11k/hw.c     | 27 ++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/hw.h     |  2 +-
 4 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 7f39c6fb7408..b9939c5a4ecd 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -865,6 +865,12 @@ ath11k_hal_rx_populate_mu_user_info(void *rx_tlv, struct hal_rx_mon_ppdu_info *p
 	ath11k_hal_rx_populate_byte_count(rx_tlv, ppdu_info, rx_user_status);
 }
 
+static u16 ath11k_hal_rx_mpduinfo_get_peerid(struct ath11k_base *ab,
+					     struct hal_rx_mpdu_info *mpdu_info)
+{
+	return ab->hw_params.hw_ops->mpdu_info_get_peerid(mpdu_info);
+}
+
 static enum hal_rx_mon_status
 ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 				   struct hal_rx_mon_ppdu_info *ppdu_info,
@@ -1459,9 +1465,11 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		break;
 	}
 	case HAL_RX_MPDU_START: {
+		struct hal_rx_mpdu_info *mpdu_info =
+				(struct hal_rx_mpdu_info *)tlv_data;
 		u16 peer_id;
 
-		peer_id = ab->hw_params.hw_ops->mpdu_info_get_peerid(tlv_data);
+		peer_id = ath11k_hal_rx_mpduinfo_get_peerid(ab, mpdu_info);
 		if (peer_id)
 			ppdu_info->peer_id = peer_id;
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index f6bae07abfd3..47e8208b22e1 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -405,7 +405,7 @@ struct hal_rx_phyrx_rssi_legacy_info {
 #define HAL_RX_MPDU_INFO_INFO0_PEERID_WCN6855	GENMASK(15, 0)
 #define HAL_RX_MPDU_INFO_INFO1_MPDU_LEN		GENMASK(13, 0)
 
-struct hal_rx_mpdu_info {
+struct hal_rx_mpdu_info_ipq8074 {
 	__le32 rsvd0;
 	__le32 info0;
 	__le32 rsvd1[11];
@@ -413,12 +413,28 @@ struct hal_rx_mpdu_info {
 	__le32 rsvd2[9];
 } __packed;
 
+struct hal_rx_mpdu_info_qcn9074 {
+	__le32 rsvd0[10];
+	__le32 info0;
+	__le32 rsvd1[2];
+	__le32 info1;
+	__le32 rsvd2[9];
+} __packed;
+
 struct hal_rx_mpdu_info_wcn6855 {
 	__le32 rsvd0[8];
 	__le32 info0;
 	__le32 rsvd1[14];
 } __packed;
 
+struct hal_rx_mpdu_info {
+	union {
+		struct hal_rx_mpdu_info_ipq8074 ipq8074;
+		struct hal_rx_mpdu_info_qcn9074 qcn9074;
+		struct hal_rx_mpdu_info_wcn6855 wcn6855;
+	} u;
+} __packed;
+
 #define HAL_RX_PPDU_END_DURATION	GENMASK(23, 0)
 struct hal_rx_ppdu_end_duration {
 	__le32 rsvd0[9];
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 60ac215e0678..6b4355a68e26 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -835,26 +835,35 @@ static void ath11k_hw_ipq5018_reo_setup(struct ath11k_base *ab)
 			   ring_hash_map);
 }
 
-static u16 ath11k_hw_ipq8074_mpdu_info_get_peerid(u8 *tlv_data)
+static u16
+ath11k_hw_ipq8074_mpdu_info_get_peerid(struct hal_rx_mpdu_info *mpdu_info)
 {
 	u16 peer_id = 0;
-	struct hal_rx_mpdu_info *mpdu_info =
-		(struct hal_rx_mpdu_info *)tlv_data;
 
 	peer_id = FIELD_GET(HAL_RX_MPDU_INFO_INFO0_PEERID,
-			    __le32_to_cpu(mpdu_info->info0));
+			    __le32_to_cpu(mpdu_info->u.ipq8074.info0));
 
 	return peer_id;
 }
 
-static u16 ath11k_hw_wcn6855_mpdu_info_get_peerid(u8 *tlv_data)
+static u16
+ath11k_hw_qcn9074_mpdu_info_get_peerid(struct hal_rx_mpdu_info *mpdu_info)
+{
+	u16 peer_id = 0;
+
+	peer_id = FIELD_GET(HAL_RX_MPDU_INFO_INFO0_PEERID,
+			    __le32_to_cpu(mpdu_info->u.qcn9074.info0));
+
+	return peer_id;
+}
+
+static u16
+ath11k_hw_wcn6855_mpdu_info_get_peerid(struct hal_rx_mpdu_info *mpdu_info)
 {
 	u16 peer_id = 0;
-	struct hal_rx_mpdu_info_wcn6855 *mpdu_info =
-		(struct hal_rx_mpdu_info_wcn6855 *)tlv_data;
 
 	peer_id = FIELD_GET(HAL_RX_MPDU_INFO_INFO0_PEERID_WCN6855,
-			    __le32_to_cpu(mpdu_info->info0));
+			    __le32_to_cpu(mpdu_info->u.wcn6855.info0));
 	return peer_id;
 }
 
@@ -1042,7 +1051,7 @@ const struct ath11k_hw_ops qcn9074_ops = {
 	.rx_desc_get_attention = ath11k_hw_qcn9074_rx_desc_get_attention,
 	.rx_desc_get_msdu_payload = ath11k_hw_qcn9074_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_ipq8074_reo_setup,
-	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
+	.mpdu_info_get_peerid = ath11k_hw_qcn9074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2,
 	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 0be4e1232384..68380f2ccab5 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -264,7 +264,7 @@ struct ath11k_hw_ops {
 	struct rx_attention *(*rx_desc_get_attention)(struct hal_rx_desc *desc);
 	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
 	void (*reo_setup)(struct ath11k_base *ab);
-	u16 (*mpdu_info_get_peerid)(u8 *tlv_data);
+	u16 (*mpdu_info_get_peerid)(struct hal_rx_mpdu_info *mpdu_info);
 	bool (*rx_desc_mac_addr2_valid)(struct hal_rx_desc *desc);
 	u8* (*rx_desc_mpdu_start_addr2)(struct hal_rx_desc *desc);
 	u32 (*get_ring_selector)(struct sk_buff *skb);
-- 
2.17.1

