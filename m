Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6BC77C7C2
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 08:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjHOG0r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 02:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbjHOG0d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 02:26:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04AA10D1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 23:26:32 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F6DYsn007069;
        Tue, 15 Aug 2023 06:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=mBUenQdNpqQ5JCEFrJXv5l10Q8BcWV7ZVjmmjJD+pL8=;
 b=VK5Cpj+sIiiEEPnCBAhHG+57zolRx6POon+CG5Sy/An70Jv/gcN5al9k1Roes4/vxE53
 h220zdpFMeWKQnfPwZEGwSXsyMJ4W6OnkhxsDwPJzvcKtDzlMYX9Sie0DCyNK5voKWbb
 IxDqW8/49SO6rsJIMRhzCOIZDDBe+qMi+gkbN2KYTWHPAnHGRDMDUGXRBUB7fpatA3Ke
 I74lGe/DY0f/bqoG8HZsvGD1Fg4+8wL0SdeNjN2tbfE3Hh6HhXr0dehyEwWBHK+xPV/W
 YQP9wXKVX3EFAu6nC37WotLtewQF+SzLzAqG9J/AYNZFCJFqdcxzbOkt4hngNu24DsjY 0Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfx0qggkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 06:26:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37F6QPSP004677
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 06:26:25 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 14 Aug 2023 23:26:24 -0700
From:   Kang Yang <quic_kangyang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 1/1] wifi: ath12k: add msdu_end structure for WCN7850
Date:   Tue, 15 Aug 2023 14:26:10 +0800
Message-ID: <20230815062610.59248-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AjUwrv2QOZA3jnNR8OTNtusPsBx7LAPS
X-Proofpoint-ORIG-GUID: AjUwrv2QOZA3jnNR8OTNtusPsBx7LAPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_05,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WCN7850 and QCN9274 use the same structure rx_msdu_end_qcn9274 for
msdu_end. But content of msdu_end on WCN7850 is different from that of
QCN9274. Need to update it for WCN7850, otherwise will get the wrong
values when using it.

For example, TID is no longer in WCN7850's msdu_end. But
ath12k_dp_rx_process_err and ath12k_dp_rx_process_wbm_err still get TID
from msdu_end. So an uncertain value will be used in these two functions
on WCN7850.

Therefore, add new structure rx_msdu_end_wcn7850 for WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c     |  6 +--
 drivers/net/wireless/ath/ath12k/rx_desc.h | 53 ++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index e7a150e7158e..19b4207ca048 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -824,8 +824,8 @@ static u8 ath12k_hw_wcn7850_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
 
 static u8 ath12k_hw_wcn7850_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
 {
-	return le16_get_bits(desc->u.wcn7850.msdu_end.info5,
-			     RX_MSDU_END_INFO5_TID);
+	return le32_get_bits(desc->u.wcn7850.mpdu_start.info2,
+			     RX_MPDU_START_INFO2_TID);
 }
 
 static u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
@@ -837,7 +837,7 @@ static void ath12k_hw_wcn7850_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
 						   struct hal_rx_desc *ldesc)
 {
 	memcpy(&fdesc->u.wcn7850.msdu_end, &ldesc->u.wcn7850.msdu_end,
-	       sizeof(struct rx_msdu_end_qcn9274));
+	       sizeof(struct rx_msdu_end_wcn7850));
 }
 
 static u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_tag(struct hal_rx_desc *desc)
diff --git a/drivers/net/wireless/ath/ath12k/rx_desc.h b/drivers/net/wireless/ath/ath12k/rx_desc.h
index f99556a253e5..8769d8f3e7ea 100644
--- a/drivers/net/wireless/ath/ath12k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath12k/rx_desc.h
@@ -782,6 +782,57 @@ struct rx_msdu_end_qcn9274 {
 	__le32 info14;
 } __packed;
 
+struct rx_msdu_end_wcn7850 {
+	__le16 info0;
+	__le16 phy_ppdu_id;
+	__le16 ip_hdr_cksum;
+	__le16 info1;
+	__le16 info2;
+	__le16 cumulative_l3_checksum;
+	__le32 rule_indication0;
+	__le32 rule_indication1;
+	__le16 info3;
+	__le16 l3_type;
+	__le32 ipv6_options_crc;
+	__le32 tcp_seq_num;
+	__le32 tcp_ack_num;
+	__le16 info4;
+	__le16 window_size;
+	__le16 tcp_udp_chksum;
+	__le16 info5;
+	__le16 sa_idx;
+	__le16 da_idx_or_sw_peer_id;
+	__le32 info6;
+	__le32 fse_metadata;
+	__le16 cce_metadata;
+	__le16 sa_sw_peer_id;
+	__le16 info7;
+	__le16 rsvd0;
+	__le16 cumulative_l4_checksum;
+	__le16 cumulative_ip_length;
+	__le32 info9;
+	__le32 info10;
+	__le32 info11;
+	__le32 toeplitz_hash_2_or_4;
+	__le32 flow_id_toeplitz;
+	__le32 info12;
+	__le32 ppdu_start_timestamp_31_0;
+	__le32 ppdu_start_timestamp_63_32;
+	__le32 phy_meta_data;
+	__le16 vlan_ctag_ci;
+	__le16 vlan_stag_ci;
+	__le32 rsvd[3];
+	__le32 info13;
+	__le32 info14;
+} __packed;
+
+/* These macro definitions are only used for WCN7850 */
+#define RX_MSDU_END_INFO5_MSDU_LIMIT_ERR       BIT(2)
+#define RX_MSDU_END_INFO5_IDX_TIMOUT           BIT(3)
+#define RX_MSDU_END_INFO5_IDX_INVLID           BIT(4)
+#define RX_MSDU_END_INFO5_WIFI_PARSE_ERR       BIT(5)
+#define RX_MSDU_END_INFO5_AMSDU_PARSER_ERR     BIT(6)
+
 /* rx_msdu_end
  *
  * rxpcu_mpdu_filter_in_category
@@ -1410,7 +1461,7 @@ struct rx_pkt_hdr_tlv {
 
 struct hal_rx_desc_wcn7850 {
 	__le64 msdu_end_tag;
-	struct rx_msdu_end_qcn9274 msdu_end;
+	struct rx_msdu_end_wcn7850 msdu_end;
 	u8 rx_padding0[RX_BE_PADDING0_BYTES];
 	__le64 mpdu_start_tag;
 	struct rx_mpdu_start_qcn9274 mpdu_start;
-- 
2.34.1

