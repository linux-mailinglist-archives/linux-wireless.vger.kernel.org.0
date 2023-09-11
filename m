Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3172179AE72
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 01:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352244AbjIKVsu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 17:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbjIKJbW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 05:31:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826FEBA
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 02:31:17 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B918RE008865;
        Mon, 11 Sep 2023 09:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=ZmVlwnckd+hM6CKugy8fysLR2eHk0wvfvMW4iEUp7+s=;
 b=N89pM0um9uukc7t6fA8JYImEEsxiGCF98CYl/QlzKQHD3fBXsF5/kfqczd4KekZZ83jf
 rboCl+u1b67y6vi4xoR8fQfbnz1BBv5wISC/zwMQmixShF2vdCZOjS0wU5Mu9q7ERz2l
 sLXzQBC2EmxPf3dlybEZrQsyog6qfFtY7AE4ctnQypyr1tiWdqnaC9khbRoeZlQTVhSW
 zwrHnFO3Nl3Ko8WbdsRV8mkebKxbBL78+ASQx4KXSY0Ij0opQvUtsMYAS16BZOII6mbE
 vQYb/0US0co0ljmX1YZT/4I4eDLk+fPKIMcPYsDAn6Hkv0z2gd57vFDJjyu0YwrF9CbO gg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0e2uk6kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 09:31:10 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B9V9A6006241
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 09:31:09 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 11 Sep 2023 02:31:07 -0700
From:   Kang Yang <quic_kangyang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: add msdu_end structure for WCN7850
Date:   Mon, 11 Sep 2023 17:30:54 +0800
Message-ID: <20230911093054.74943-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zPVnwQME0s5WjubYZkzI_DkUXDlqNtQ2
X-Proofpoint-ORIG-GUID: zPVnwQME0s5WjubYZkzI_DkUXDlqNtQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 clxscore=1011 phishscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WCN7850 and QCN9274 currently use the same structure rx_msdu_end_qcn9274
for msdu_end. But content of msdu_end on WCN7850 is different from that of
QCN9274. Need to update it for WCN7850, otherwise will get the wrong
values when using it.

For example, TID is no longer in WCN7850's msdu_end. But
ath12k_dp_rx_process_err() and ath12k_dp_rx_process_wbm_err() still get
TID from msdu_end. So an uncertain value will be used in these two
functions on WCN7850.

Therefore, add new structure rx_msdu_end_wcn7850 for WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v2:
 1. use different macro names for different contents(Jeff).
 2. add () to function references(Jeff). 

 drivers/net/wireless/ath/ath12k/hal.c     | 12 +--
 drivers/net/wireless/ath/ath12k/rx_desc.h | 91 +++++++++++++++++++----
 2 files changed, 83 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index e7a150e7158e..eca86fc25a60 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -385,13 +385,13 @@ static u8 ath12k_hw_qcn9274_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
 static u8 ath12k_hw_qcn9274_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274.msdu_end.info12,
-			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
+			     RX_MSDU_END_QCN9274_INFO12_MIMO_SS_BITMAP);
 }
 
 static u8 ath12k_hw_qcn9274_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
 {
 	return le16_get_bits(desc->u.qcn9274.msdu_end.info5,
-			    RX_MSDU_END_INFO5_TID);
+			    RX_MSDU_END_QCN9274_INFO5_TID);
 }
 
 static u16 ath12k_hw_qcn9274_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
@@ -819,13 +819,13 @@ static u8 ath12k_hw_wcn7850_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
 static u8 ath12k_hw_wcn7850_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
-			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
+			     RX_MSDU_END_WCN7850_INFO12_MIMO_SS_BITMAP);
 }
 
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
index bfa87cb8d021..c4058abc516e 100644
--- a/drivers/net/wireless/ath/ath12k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath12k/rx_desc.h
@@ -627,17 +627,18 @@ enum rx_msdu_start_reception_type {
 
 #define RX_MSDU_END_INFO5_SA_IDX_TIMEOUT	BIT(0)
 #define RX_MSDU_END_INFO5_DA_IDX_TIMEOUT	BIT(1)
-#define RX_MSDU_END_INFO5_TO_DS			BIT(2)
-#define RX_MSDU_END_INFO5_TID			GENMASK(6, 3)
 #define RX_MSDU_END_INFO5_SA_IS_VALID		BIT(7)
 #define RX_MSDU_END_INFO5_DA_IS_VALID		BIT(8)
 #define RX_MSDU_END_INFO5_DA_IS_MCBC		BIT(9)
 #define RX_MSDU_END_INFO5_L3_HDR_PADDING	GENMASK(11, 10)
 #define RX_MSDU_END_INFO5_FIRST_MSDU		BIT(12)
 #define RX_MSDU_END_INFO5_LAST_MSDU		BIT(13)
-#define RX_MSDU_END_INFO5_FROM_DS		BIT(14)
 #define RX_MSDU_END_INFO5_IP_CHKSUM_FAIL_COPY	BIT(15)
 
+#define RX_MSDU_END_QCN9274_INFO5_TO_DS         BIT(2)
+#define RX_MSDU_END_QCN9274_INFO5_TID           GENMASK(6, 3)
+#define RX_MSDU_END_QCN9274_INFO5_FROM_DS       BIT(14)
+
 #define RX_MSDU_END_INFO6_MSDU_DROP		BIT(0)
 #define RX_MSDU_END_INFO6_REO_DEST_IND		GENMASK(5, 1)
 #define RX_MSDU_END_INFO6_FLOW_IDX		GENMASK(25, 6)
@@ -650,14 +651,15 @@ enum rx_msdu_start_reception_type {
 #define RX_MSDU_END_INFO7_AGGR_COUNT		GENMASK(7, 0)
 #define RX_MSDU_END_INFO7_FLOW_AGGR_CONTN	BIT(8)
 #define RX_MSDU_END_INFO7_FISA_TIMEOUT		BIT(9)
-#define RX_MSDU_END_INFO7_TCPUDP_CSUM_FAIL_CPY	BIT(10)
-#define RX_MSDU_END_INFO7_MSDU_LIMIT_ERROR	BIT(11)
-#define RX_MSDU_END_INFO7_FLOW_IDX_TIMEOUT	BIT(12)
-#define RX_MSDU_END_INFO7_FLOW_IDX_INVALID	BIT(13)
-#define RX_MSDU_END_INFO7_CCE_MATCH		BIT(14)
-#define RX_MSDU_END_INFO7_AMSDU_PARSER_ERR	BIT(15)
 
-#define RX_MSDU_END_INFO8_KEY_ID		GENMASK(7, 0)
+#define RX_MSDU_END_QCN9274_INFO7_TCPUDP_CSUM_FAIL_CPY	BIT(10)
+#define RX_MSDU_END_QCN9274_INFO7_MSDU_LIMIT_ERROR	BIT(11)
+#define RX_MSDU_END_QCN9274_INFO7_FLOW_IDX_TIMEOUT	BIT(12)
+#define RX_MSDU_END_QCN9274_INFO7_FLOW_IDX_INVALID	BIT(13)
+#define RX_MSDU_END_QCN9274_INFO7_CCE_MATCH		BIT(14)
+#define RX_MSDU_END_QCN9274_INFO7_AMSDU_PARSER_ERR	BIT(15)
+
+#define RX_MSDU_END_QCN9274_INFO8_KEY_ID		GENMASK(7, 0)
 
 #define RX_MSDU_END_INFO9_SERVICE_CODE		GENMASK(14, 6)
 #define RX_MSDU_END_INFO9_PRIORITY_VALID	BIT(15)
@@ -698,8 +700,9 @@ enum rx_msdu_start_reception_type {
 #define RX_MSDU_END_INFO12_RATE_MCS		GENMASK(17, 14)
 #define RX_MSDU_END_INFO12_RECV_BW		GENMASK(20, 18)
 #define RX_MSDU_END_INFO12_RECEPTION_TYPE	GENMASK(23, 21)
-#define RX_MSDU_END_INFO12_MIMO_SS_BITMAP	GENMASK(30, 24)
-#define RX_MSDU_END_INFO12_MIMO_DONE_COPY	BIT(31)
+
+#define RX_MSDU_END_QCN9274_INFO12_MIMO_SS_BITMAP	GENMASK(30, 24)
+#define RX_MSDU_END_QCN9274_INFO12_MIMO_DONE_COPY	BIT(31)
 
 #define RX_MSDU_END_INFO13_FIRST_MPDU		BIT(0)
 #define RX_MSDU_END_INFO13_MCAST_BCAST		BIT(2)
@@ -714,7 +717,6 @@ enum rx_msdu_start_reception_type {
 #define RX_MSDU_END_INFO13_EOSP			BIT(11)
 #define RX_MSDU_END_INFO13_A_MSDU_ERROR		BIT(12)
 #define RX_MSDU_END_INFO13_ORDER		BIT(14)
-#define RX_MSDU_END_INFO13_WIFI_PARSER_ERR	BIT(15)
 #define RX_MSDU_END_INFO13_OVERFLOW_ERR		BIT(16)
 #define RX_MSDU_END_INFO13_MSDU_LEN_ERR		BIT(17)
 #define RX_MSDU_END_INFO13_TCP_UDP_CKSUM_FAIL	BIT(18)
@@ -732,6 +734,8 @@ enum rx_msdu_start_reception_type {
 #define RX_MSDU_END_INFO13_UNDECRYPT_FRAME_ERR	BIT(30)
 #define RX_MSDU_END_INFO13_FCS_ERR		BIT(31)
 
+#define RX_MSDU_END_QCN9274_INFO13_WIFI_PARSER_ERR      BIT(15)
+
 #define RX_MSDU_END_INFO14_DECRYPT_STATUS_CODE	GENMASK(12, 10)
 #define RX_MSDU_END_INFO14_RX_BITMAP_NOT_UPDED	BIT(13)
 #define RX_MSDU_END_INFO14_MSDU_DONE		BIT(31)
@@ -782,6 +786,65 @@ struct rx_msdu_end_qcn9274 {
 	__le32 info14;
 } __packed;
 
+/* These macro definitions are only used for WCN7850 */
+#define RX_MSDU_END_WCN7850_INFO2_KEY_ID			BIT(7, 0)
+
+#define RX_MSDU_END_WCN7850_INFO5_MSDU_LIMIT_ERR		BIT(2)
+#define RX_MSDU_END_WCN7850_INFO5_IDX_TIMEOUT			BIT(3)
+#define RX_MSDU_END_WCN7850_INFO5_IDX_INVALID			BIT(4)
+#define RX_MSDU_END_WCN7850_INFO5_WIFI_PARSE_ERR		BIT(5)
+#define RX_MSDU_END_WCN7850_INFO5_AMSDU_PARSER_ERR		BIT(6)
+#define RX_MSDU_END_WCN7850_INFO5_TCPUDP_CSUM_FAIL_CPY		BIT(14)
+
+#define RX_MSDU_END_WCN7850_INFO12_MIMO_SS_BITMAP		GENMASK(31, 24)
+
+#define RX_MSDU_END_WCN7850_INFO13_FRAGMENT_FLAG		BIT(13)
+#define RX_MSDU_END_WCN7850_INFO13_CCE_MATCH			BIT(15)
+
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
 /* rx_msdu_end
  *
  * rxpcu_mpdu_filter_in_category
@@ -1410,7 +1473,7 @@ struct rx_pkt_hdr_tlv {
 
 struct hal_rx_desc_wcn7850 {
 	__le64 msdu_end_tag;
-	struct rx_msdu_end_qcn9274 msdu_end;
+	struct rx_msdu_end_wcn7850 msdu_end;
 	u8 rx_padding0[RX_BE_PADDING0_BYTES];
 	__le64 mpdu_start_tag;
 	struct rx_mpdu_start_qcn9274 mpdu_start;
-- 
2.34.1

