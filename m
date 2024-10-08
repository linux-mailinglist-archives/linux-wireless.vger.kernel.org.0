Return-Path: <linux-wireless+bounces-13721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E22994451
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 11:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA034B20FB7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 09:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6459115FD16;
	Tue,  8 Oct 2024 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WpjIBcJu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC612C484
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379862; cv=none; b=rs659uehRJ99I+yRE8VubE16SVq5S7U2uRwKsQirgj69lXW7fm/ByePNhIVAjrzgmPMA57tpWNfwt7k+opf73QTDgH1scrKk5uY2o8eG8aDqjjKN2fqg7RneokpkKqZNMea2GAMCU1hIxaU2GTcOXsNBmt4KkzzKvByaqfifxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379862; c=relaxed/simple;
	bh=U6xH2qjNKdBb6d6ix8APyLyNU2C/Xn5pPsBD0piwj1c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mn/UzqJR5gFwyRyjiW8BCIAWkW1z79Q7FxFhYK2I8YJnJNoSwi/19HDuscBDnyZ1WkFNuwI+fbGZl9mVm92mEuP6DVesI8hXzHdb7t2cAgcaa5rSVmIqAHH/g0zH/Ic1LL3RuAgSKFUkccoa1TNAnViIPPbfycmo78eILQVHZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WpjIBcJu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49852rSN013602;
	Tue, 8 Oct 2024 09:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JKc8DPrFU9ORtxrw5BuKDZ
	KaecX1dP/9rb4dY/DdSNg=; b=WpjIBcJuBrNcN5cF0/r26NEmCxkzZ5c08uhLUv
	CgFb953hcvxdH/gn2355j35n3TpmP3ngycJ1laaDjwxE/mOBDd1aAbHuNAgBByaj
	4A18FNS6Sm6W5lPUJ/lheDVRQO7YpbnEFLwkQg+/fXhzcp1rJqDCqqHBw/1xYoWr
	niCctpO1uLObLycKaW9egzQ/P7UcwLA+enr/l9/LvNViUOA7ROPoo2pQ2qvi4Bv9
	jhkZR9hOOJLEdUVPG6Ly4NyBX872AXerJ4Zc3ZgE4YJ45C2hWyyg/nBajVdFLwT/
	FCHvmau63pyY+6Msm7WAB/RoazoOE0R1E9bMp2Hdin4stvVQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424x7rrn7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 09:30:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4989UuaD002217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 09:30:56 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 8 Oct 2024 02:30:54 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH] wifi: ath12k: remove msdu_end structure for WCN7850
Date: Tue, 8 Oct 2024 17:30:39 +0800
Message-ID: <20241008093039.11076-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -Cw3RGmGOM8O8eTyNV1lAKrkcfpF4vCh
X-Proofpoint-ORIG-GUID: -Cw3RGmGOM8O8eTyNV1lAKrkcfpF4vCh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080062

Currently, when ath12k retrieves values from the structure
rx_msdu_end_wcn7850, the information obtained is incorrect. This is because
the definition of the rx_msdu_end_wcn7850 structure in ath12k is incorrect.
In fact, the rx_msdu_end structure used by WCN7850 is the same as the
rx_msdu_end structure of QCN9274.

Commit ed823fd113b7 ("wifi: ath12k: add msdu_end structure for WCN7850")
introduced this structure. The original issue trying to be fixed with that
commit is that the TID information retrieved from the rx_msdu_end structure
was incorrect, and it was thought that the structure wasn't correct, so a
supposedly correct structure was introduced. However it was subsequently
discovered that the TID information is only guaranteed to be valid in the
rx_msdu_start structure, so that commit added the logic to retrieve the TID
from the rx_msdu_start, but unfortunately kept the rx_msdu_end_wcn7850
structure.

To address this issue, revert the code related to the rx_msdu_end_wcn7850
structure, retaining the TID retrieval logic.

This patch does not affect QCN9274.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: ed823fd113b7 ("wifi: ath12k: add msdu_end structure for WCN7850")
Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c     | 12 ++--
 drivers/net/wireless/ath/ath12k/rx_desc.h | 88 ++++-------------------
 2 files changed, 20 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index ca04bfae8bdc..fd98fac16dd5 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -385,13 +385,13 @@ static u8 ath12k_hw_qcn9274_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
 static u8 ath12k_hw_qcn9274_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274.msdu_end.info12,
-			     RX_MSDU_END_QCN9274_INFO12_MIMO_SS_BITMAP);
+			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
 }
 
 static u8 ath12k_hw_qcn9274_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
 {
 	return le16_get_bits(desc->u.qcn9274.msdu_end.info5,
-			    RX_MSDU_END_QCN9274_INFO5_TID);
+			    RX_MSDU_END_INFO5_TID);
 }
 
 static u16 ath12k_hw_qcn9274_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
@@ -846,13 +846,13 @@ static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_pkt_type(struct hal_rx_desc
 static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
-			     RX_MSDU_END_QCN9274_INFO12_MIMO_SS_BITMAP);
+			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
 }
 
 static u8 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
 {
 	return le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
-			     RX_MSDU_END_QCN9274_INFO5_TID);
+			     RX_MSDU_END_INFO5_TID);
 }
 
 static u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
@@ -1198,7 +1198,7 @@ static u8 ath12k_hw_wcn7850_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
 static u8 ath12k_hw_wcn7850_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
-			     RX_MSDU_END_WCN7850_INFO12_MIMO_SS_BITMAP);
+			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
 }
 
 static u8 ath12k_hw_wcn7850_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
@@ -1216,7 +1216,7 @@ static void ath12k_hw_wcn7850_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
 						   struct hal_rx_desc *ldesc)
 {
 	memcpy(&fdesc->u.wcn7850.msdu_end, &ldesc->u.wcn7850.msdu_end,
-	       sizeof(struct rx_msdu_end_wcn7850));
+	       sizeof(struct rx_msdu_end_qcn9274));
 }
 
 static u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_tag(struct hal_rx_desc *desc)
diff --git a/drivers/net/wireless/ath/ath12k/rx_desc.h b/drivers/net/wireless/ath/ath12k/rx_desc.h
index a0db6702a189..10366bbe9999 100644
--- a/drivers/net/wireless/ath/ath12k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath12k/rx_desc.h
@@ -684,18 +684,17 @@ enum rx_msdu_start_reception_type {
 
 #define RX_MSDU_END_INFO5_SA_IDX_TIMEOUT	BIT(0)
 #define RX_MSDU_END_INFO5_DA_IDX_TIMEOUT	BIT(1)
+#define RX_MSDU_END_INFO5_TO_DS			BIT(2)
+#define RX_MSDU_END_INFO5_TID			GENMASK(6, 3)
 #define RX_MSDU_END_INFO5_SA_IS_VALID		BIT(7)
 #define RX_MSDU_END_INFO5_DA_IS_VALID		BIT(8)
 #define RX_MSDU_END_INFO5_DA_IS_MCBC		BIT(9)
 #define RX_MSDU_END_INFO5_L3_HDR_PADDING	GENMASK(11, 10)
 #define RX_MSDU_END_INFO5_FIRST_MSDU		BIT(12)
 #define RX_MSDU_END_INFO5_LAST_MSDU		BIT(13)
+#define RX_MSDU_END_INFO5_FROM_DS		BIT(14)
 #define RX_MSDU_END_INFO5_IP_CHKSUM_FAIL_COPY	BIT(15)
 
-#define RX_MSDU_END_QCN9274_INFO5_TO_DS         BIT(2)
-#define RX_MSDU_END_QCN9274_INFO5_TID           GENMASK(6, 3)
-#define RX_MSDU_END_QCN9274_INFO5_FROM_DS       BIT(14)
-
 #define RX_MSDU_END_INFO6_MSDU_DROP		BIT(0)
 #define RX_MSDU_END_INFO6_REO_DEST_IND		GENMASK(5, 1)
 #define RX_MSDU_END_INFO6_FLOW_IDX		GENMASK(25, 6)
@@ -709,14 +708,14 @@ enum rx_msdu_start_reception_type {
 #define RX_MSDU_END_INFO7_FLOW_AGGR_CONTN	BIT(8)
 #define RX_MSDU_END_INFO7_FISA_TIMEOUT		BIT(9)
 
-#define RX_MSDU_END_QCN9274_INFO7_TCPUDP_CSUM_FAIL_CPY	BIT(10)
-#define RX_MSDU_END_QCN9274_INFO7_MSDU_LIMIT_ERROR	BIT(11)
-#define RX_MSDU_END_QCN9274_INFO7_FLOW_IDX_TIMEOUT	BIT(12)
-#define RX_MSDU_END_QCN9274_INFO7_FLOW_IDX_INVALID	BIT(13)
-#define RX_MSDU_END_QCN9274_INFO7_CCE_MATCH		BIT(14)
-#define RX_MSDU_END_QCN9274_INFO7_AMSDU_PARSER_ERR	BIT(15)
+#define RX_MSDU_END_INFO7_TCPUDP_CSUM_FAIL_CPY	BIT(10)
+#define RX_MSDU_END_INFO7_MSDU_LIMIT_ERROR	BIT(11)
+#define RX_MSDU_END_INFO7_FLOW_IDX_TIMEOUT	BIT(12)
+#define RX_MSDU_END_INFO7_FLOW_IDX_INVALID	BIT(13)
+#define RX_MSDU_END_INFO7_CCE_MATCH		BIT(14)
+#define RX_MSDU_END_INFO7_AMSDU_PARSER_ERR	BIT(15)
 
-#define RX_MSDU_END_QCN9274_INFO8_KEY_ID		GENMASK(7, 0)
+#define RX_MSDU_END_INFO8_KEY_ID		GENMASK(7, 0)
 
 #define RX_MSDU_END_INFO9_SERVICE_CODE		GENMASK(14, 6)
 #define RX_MSDU_END_INFO9_PRIORITY_VALID	BIT(15)
@@ -758,8 +757,8 @@ enum rx_msdu_start_reception_type {
 #define RX_MSDU_END_INFO12_RECV_BW		GENMASK(20, 18)
 #define RX_MSDU_END_INFO12_RECEPTION_TYPE	GENMASK(23, 21)
 
-#define RX_MSDU_END_QCN9274_INFO12_MIMO_SS_BITMAP	GENMASK(30, 24)
-#define RX_MSDU_END_QCN9274_INFO12_MIMO_DONE_COPY	BIT(31)
+#define RX_MSDU_END_INFO12_MIMO_SS_BITMAP	GENMASK(30, 24)
+#define RX_MSDU_END_INFO12_MIMO_DONE_COPY	BIT(31)
 
 #define RX_MSDU_END_INFO13_FIRST_MPDU		BIT(0)
 #define RX_MSDU_END_INFO13_MCAST_BCAST		BIT(2)
@@ -791,7 +790,7 @@ enum rx_msdu_start_reception_type {
 #define RX_MSDU_END_INFO13_UNDECRYPT_FRAME_ERR	BIT(30)
 #define RX_MSDU_END_INFO13_FCS_ERR		BIT(31)
 
-#define RX_MSDU_END_QCN9274_INFO13_WIFI_PARSER_ERR      BIT(15)
+#define RX_MSDU_END_INFO13_WIFI_PARSER_ERR      BIT(15)
 
 #define RX_MSDU_END_INFO14_DECRYPT_STATUS_CODE	GENMASK(12, 10)
 #define RX_MSDU_END_INFO14_RX_BITMAP_NOT_UPDED	BIT(13)
@@ -889,65 +888,6 @@ struct rx_msdu_end_qcn9274_compact {
 	__le32 info14;
 } __packed;
 
-/* These macro definitions are only used for WCN7850 */
-#define RX_MSDU_END_WCN7850_INFO2_KEY_ID			BIT(7, 0)
-
-#define RX_MSDU_END_WCN7850_INFO5_MSDU_LIMIT_ERR		BIT(2)
-#define RX_MSDU_END_WCN7850_INFO5_IDX_TIMEOUT			BIT(3)
-#define RX_MSDU_END_WCN7850_INFO5_IDX_INVALID			BIT(4)
-#define RX_MSDU_END_WCN7850_INFO5_WIFI_PARSE_ERR		BIT(5)
-#define RX_MSDU_END_WCN7850_INFO5_AMSDU_PARSER_ERR		BIT(6)
-#define RX_MSDU_END_WCN7850_INFO5_TCPUDP_CSUM_FAIL_CPY		BIT(14)
-
-#define RX_MSDU_END_WCN7850_INFO12_MIMO_SS_BITMAP		GENMASK(31, 24)
-
-#define RX_MSDU_END_WCN7850_INFO13_FRAGMENT_FLAG		BIT(13)
-#define RX_MSDU_END_WCN7850_INFO13_CCE_MATCH			BIT(15)
-
-struct rx_msdu_end_wcn7850 {
-	__le16 info0;
-	__le16 phy_ppdu_id;
-	__le16 ip_hdr_cksum;
-	__le16 info1;
-	__le16 info2;
-	__le16 cumulative_l3_checksum;
-	__le32 rule_indication0;
-	__le32 rule_indication1;
-	__le16 info3;
-	__le16 l3_type;
-	__le32 ipv6_options_crc;
-	__le32 tcp_seq_num;
-	__le32 tcp_ack_num;
-	__le16 info4;
-	__le16 window_size;
-	__le16 tcp_udp_chksum;
-	__le16 info5;
-	__le16 sa_idx;
-	__le16 da_idx_or_sw_peer_id;
-	__le32 info6;
-	__le32 fse_metadata;
-	__le16 cce_metadata;
-	__le16 sa_sw_peer_id;
-	__le16 info7;
-	__le16 rsvd0;
-	__le16 cumulative_l4_checksum;
-	__le16 cumulative_ip_length;
-	__le32 info9;
-	__le32 info10;
-	__le32 info11;
-	__le32 toeplitz_hash_2_or_4;
-	__le32 flow_id_toeplitz;
-	__le32 info12;
-	__le32 ppdu_start_timestamp_31_0;
-	__le32 ppdu_start_timestamp_63_32;
-	__le32 phy_meta_data;
-	__le16 vlan_ctag_ci;
-	__le16 vlan_stag_ci;
-	__le32 rsvd[3];
-	__le32 info13;
-	__le32 info14;
-} __packed;
-
 /* rx_msdu_end
  *
  * rxpcu_mpdu_filter_in_category
@@ -1578,7 +1518,7 @@ struct rx_pkt_hdr_tlv {
 
 struct hal_rx_desc_wcn7850 {
 	__le64 msdu_end_tag;
-	struct rx_msdu_end_wcn7850 msdu_end;
+	struct rx_msdu_end_qcn9274 msdu_end;
 	u8 rx_padding0[RX_BE_PADDING0_BYTES];
 	__le64 mpdu_start_tag;
 	struct rx_mpdu_start_qcn9274 mpdu_start;

base-commit: b9545f4570fcfebe982439de7c9106e55b4bf756
-- 
2.34.1


