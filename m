Return-Path: <linux-wireless+bounces-28500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E84C2B4A1
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE800342FA6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D113B3019B7;
	Mon,  3 Nov 2025 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TM17CRcE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285DC2FC870
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168914; cv=none; b=f/pl6JQfY1VuzcBPQbO7/22kKTNkb+y/prLZ4uPz7MLjrSRM8GBe1f7diRiJSwXQpUJonVrnfwxmvmhIAeSONqJBWjhqOv+0QEEzxtvPB2sbQ5BtnrBPl3mhUxa9uio74pzPYRc+/idFywhLC4WddBZFrtkXFuN0Cj32Hzo9XhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168914; c=relaxed/simple;
	bh=Rmbh80Z8MAIIBxiI2xzfziVZ28iTPrRWs0tWExv/oUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gg8SjWeLebSWGlSWQLyCK5omAODr7wPTOSQ2+9Tw+QKLUgzIaWiPPTJbq/J70B4N6vSbKxHm3BEFSc0NSfLPcevTTODq9Ty6wXbIdPzi6NDS2GfcklqiYpjwocpMt1AfLqZX67zo+vPajWANpi5OYI0to9EXmxJJf4Pkh8gJUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TM17CRcE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3B7icF2984202;
	Mon, 3 Nov 2025 11:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iq/0bakhkkR3523scFE1dlGKAPArD2ExpyCxhn7Wh8I=; b=TM17CRcE21u4VhBQ
	8zIpwDvukQgEu8e/K28mzI0VqznGr5X7rBJ1ekL7EBrCl0k4UMl1E6AonCGXwGi9
	+yBA4+RXaUpMF6+s7YpKMtvWSf/9+VcN2YNSVwbait3LRJ/rntH6N0rkc76Ns+Th
	uafsDVw1krkTE5W16PQ9Km5zAAzKIviAUi8ufMKhUuXrZa5Vi3Ep2fk58x4weDoD
	OByXwv6RvwA++Y1ttHXPr9oKWnxdb8U9NP03LDqW3ke55AuhiA9Nny9+92HFRlri
	erD/lzJFvzWimyk55UNj4m9E4Px/R3ExBorRa7vbsVOU647h/+jSxCmaVN+l1EFY
	VFoEQA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b00yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:21:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A3BLn2F018203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 11:21:49 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 3 Nov 2025 03:21:47 -0800
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 08/12] wifi: ath12k: Move ath12k_dp_rx_get_peer_id API to Wi-Fi 7
Date: Mon, 3 Nov 2025 16:51:07 +0530
Message-ID: <20251103112111.2260639-9-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
References: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwMyBTYWx0ZWRfX7BW1iYtukqSY
 9O7/ctyHU9O+2ioPhPToslbOC70CLCCPZM77AKCue3jQDpYbcUgBhKLa6TaDONT9t5G0tD1I3QH
 d41r+c868gHqUfRPT9EMa8OdcGckAmvIPA/37Ii1IGh6JMonDEEUmE3L9i+75X+UASXEbDvCsPl
 LA3i8Capb4TXEe4T+uFCgFUqJGe7tX89k98Ek8Bo6L4+Lwd6vQEIiDDgIwNlclfbpdibPkq6h0E
 377J9PXduuIkq2pSzQcgKr+uVHm2mpHN8g0ECfSX8v1aCV6/rbGC71CCN1C65yIMPvra3+kldam
 JSXwIJ2MHzyD8yuGVJvPXatwz2lmCk90Dhiwnkmi1NVkUbJCo6lO+3jJYPXDzBzc/uZKvVqjcAi
 UjuQmQEoKnwNQy9gMzOP5OIFJKDadQ==
X-Proofpoint-GUID: -JMEDqntg2J-iCFmPTXqEULYHUci7Jts
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=6908904e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=AbU1xqyEAIe7s5FDwhwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -JMEDqntg2J-iCFmPTXqEULYHUci7Jts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030103

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move ath12k_dp_rx_get_peer_id() from common to Wi-Fi 7 as it operates on
arch specific peer metadata.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 23 --------------
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  3 --
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 31 ++++++++++++++++---
 3 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index f76d13299258..763d8cff0529 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1269,29 +1269,6 @@ bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_dp *dp,
 	return false;
 }
 
-u16 ath12k_dp_rx_get_peer_id(struct ath12k_base *ab,
-			     enum ath12k_peer_metadata_version ver,
-			     __le32 peer_metadata)
-{
-	switch (ver) {
-	default:
-		ath12k_warn(ab, "Unknown peer metadata version: %d", ver);
-		fallthrough;
-	case ATH12K_PEER_METADATA_V0:
-		return le32_get_bits(peer_metadata,
-				     RX_MPDU_DESC_META_DATA_V0_PEER_ID);
-	case ATH12K_PEER_METADATA_V1:
-		return le32_get_bits(peer_metadata,
-				     RX_MPDU_DESC_META_DATA_V1_PEER_ID);
-	case ATH12K_PEER_METADATA_V1A:
-		return le32_get_bits(peer_metadata,
-				     RX_MPDU_DESC_META_DATA_V1A_PEER_ID);
-	case ATH12K_PEER_METADATA_V1B:
-		return le32_get_bits(peer_metadata,
-				     RX_MPDU_DESC_META_DATA_V1B_PEER_ID);
-	}
-}
-
 static void ath12k_dp_rx_frag_timer(struct timer_list *timer)
 {
 	struct ath12k_dp_rx_tid *rx_tid = timer_container_of(rx_tid, timer,
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 0dffb59c13b8..8a1dc5d15341 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -186,9 +186,6 @@ void ath12k_dp_rx_h_undecap_frag(struct ath12k_pdev_dp *dp_pdev, struct sk_buff
 int ath12k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
 			       struct ieee80211_hdr *hdr, u8 *data,
 			       size_t data_len, u8 *mic);
-u16 ath12k_dp_rx_get_peer_id(struct ath12k_base *ab,
-			     enum ath12k_peer_metadata_version ver,
-			     __le32 peer_metadata);
 int ath12k_dp_rx_ampdu_start(struct ath12k *ar,
 			     struct ieee80211_ampdu_params *params,
 			     u8 link_id);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 13cd23d7c7da..5eb62afde4a5 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -10,6 +10,29 @@
 #include "hal_qcn9274.h"
 #include "hal_wcn7850.h"
 
+static u16 ath12k_wifi7_dp_rx_get_peer_id(struct ath12k_dp *dp,
+					  enum ath12k_peer_metadata_version ver,
+					  __le32 peer_metadata)
+{
+	switch (ver) {
+	default:
+		ath12k_warn(dp->ab, "Unknown peer metadata version: %d", ver);
+		fallthrough;
+	case ATH12K_PEER_METADATA_V0:
+		return le32_get_bits(peer_metadata,
+				     RX_MPDU_DESC_META_DATA_V0_PEER_ID);
+	case ATH12K_PEER_METADATA_V1:
+		return le32_get_bits(peer_metadata,
+				     RX_MPDU_DESC_META_DATA_V1_PEER_ID);
+	case ATH12K_PEER_METADATA_V1A:
+		return le32_get_bits(peer_metadata,
+				     RX_MPDU_DESC_META_DATA_V1A_PEER_ID);
+	case ATH12K_PEER_METADATA_V1B:
+		return le32_get_bits(peer_metadata,
+				     RX_MPDU_DESC_META_DATA_V1B_PEER_ID);
+	}
+}
+
 void ath12k_wifi7_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
 					 dma_addr_t paddr)
 {
@@ -731,8 +754,8 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		rxcb->is_continuation = !!(le32_to_cpu(msdu_info->info0) &
 					   RX_MSDU_DESC_INFO0_MSDU_CONTINUATION);
 		rxcb->hw_link_id = hw_link_id;
-		rxcb->peer_id = ath12k_dp_rx_get_peer_id(ab, dp->peer_metadata_ver,
-							 mpdu_info->peer_meta_data);
+		rxcb->peer_id = ath12k_wifi7_dp_rx_get_peer_id(dp, dp->peer_metadata_ver,
+							       mpdu_info->peer_meta_data);
 		rxcb->tid = le32_get_bits(mpdu_info->info0,
 					  RX_MPDU_DESC_INFO0_TID);
 
@@ -1855,8 +1878,8 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		rxcb->is_last_msdu = err_info.last_msdu;
 		rxcb->is_continuation = err_info.continuation;
 		rxcb->rx_desc = msdu_data;
-		rxcb->peer_id = ath12k_dp_rx_get_peer_id(ab, dp->peer_metadata_ver,
-							 err_info.peer_metadata);
+		rxcb->peer_id = ath12k_wifi7_dp_rx_get_peer_id(dp, dp->peer_metadata_ver,
+							       err_info.peer_metadata);
 
 		if (err_info.continuation) {
 			__skb_queue_tail(&scatter_msdu_list, msdu);
-- 
2.34.1


