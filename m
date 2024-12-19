Return-Path: <linux-wireless+bounces-16563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306169F713F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 01:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC0218903F7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 00:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4D14A04;
	Thu, 19 Dec 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BaJQ6St0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA42111
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734567035; cv=none; b=Pp9iSF3brz6mhgY9MoH0T76TSyJNeyJZG7vrSNmSv18saRH9+FuTU+Q5C9R6A7/AdP8PgFPQUhIkLdO3mfEC715+glb0t3MIFBjQx1QxvJl3nzdAWA7OQbMSJPS4dBtEhbCu2ot3nzBzYLrVEbJF0ZYMSuUXGQ56k158OlhiX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734567035; c=relaxed/simple;
	bh=I4k8lg9jRBko72YZCOW0APenl5KQa6EoBjSgVe3PBOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTDK84S5XY8MWrfWDfS4g1QZLKKHrArl6mlCa6Cr7gONJHhUkrSdLaElJ71b6XU2DOuaGVnDspBQPgzt9mUOc3jhEJpYyCwU1pk41laqrSLlaUhCBSywk68jKCmaVkzVLNXbqyNGaky7xyc6pb3yOvjO8b/7z3G9tLhG5iBQOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BaJQ6St0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIGQvDX013097;
	Thu, 19 Dec 2024 00:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JW3kHTJk1fdpHrhjMF2MFpLHJyAqqwq76yzYInYlMgg=; b=BaJQ6St0epdnIwGo
	TJdkZXLLBRNpDIlnG0ABCM/lFmc2q7xA00tBD+d2qrzAXf8KfEKhyhxexIx9LmOh
	KcmVrpjRtonLhdMiP8QceLOVxJF5I/Eu6B+sQ8SHJvaIWZ4UEtu+BA0nscvghTFB
	2MQNMVDd7HsnfhfNa/x0IyCAa9DJTrMo1jTdlAdY95FBZ1KI0bXduRS3VEiiM/JC
	MSSCzoQP9pJQmkCLr8P6hAM20f1RcHhPhEyurVn+65jAH4pUMl2ludjph28wVKbr
	PwQ4l/UVX9bhOO2oH/yNj5XY+pwMJ+4RSMesTM5lXedZI2d4ecteeQ8fgOKHuTvC
	lIYiyw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43kyjx9cfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 00:10:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJ0AUqL001749
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 00:10:30 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 18 Dec 2024 16:10:28 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/3] wifi: ath12k: Refactor the monitor Tx/RX handler procedure arguments
Date: Thu, 19 Dec 2024 05:40:05 +0530
Message-ID: <20241219001006.1036495-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
References: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AZkY879K33ZH9Wb-Rpjy1Up5sM_Xj-x7
X-Proofpoint-GUID: AZkY879K33ZH9Wb-Rpjy1Up5sM_Xj-x7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=822
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180188

Currently, the pdev handle is given along with the mac id to all the
monitor Tx/Rx handler procedure arguments. The mac id information is
derived from the pdev handle itself. Therefore, remove the unnecessary
mac id argument from the handler.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 29 ++++++++++++------------
 drivers/net/wireless/ath/ath12k/dp_mon.h |  7 +++---
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 85ff89b91624..ae2f6847bc88 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -845,7 +845,7 @@ static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
 }
 
 static struct sk_buff *
-ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar, u32 mac_id,
+ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 			    struct sk_buff *head_msdu, struct sk_buff *tail_msdu,
 			    struct ieee80211_rx_status *rxs, bool *fcs_err)
 {
@@ -1126,7 +1126,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	ieee80211_rx_napi(ath12k_ar_to_hw(ar), pubsta, msdu, napi);
 }
 
-static int ath12k_dp_mon_rx_deliver(struct ath12k *ar, u32 mac_id,
+static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
 				    struct sk_buff *head_msdu, struct sk_buff *tail_msdu,
 				    struct hal_rx_mon_ppdu_info *ppduinfo,
 				    struct napi_struct *napi)
@@ -1136,7 +1136,7 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar, u32 mac_id,
 	struct ieee80211_rx_status *rxs = &dp->rx_status;
 	bool fcs_err = false;
 
-	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar, mac_id,
+	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar,
 					      head_msdu, tail_msdu,
 					      rxs, &fcs_err);
 	if (!mon_skb)
@@ -1225,7 +1225,6 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 enum hal_rx_mon_status
 ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 				  struct ath12k_mon_data *pmon,
-				  int mac_id,
 				  struct sk_buff *skb,
 				  struct napi_struct *napi)
 {
@@ -1243,7 +1242,7 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 		tail_msdu = mon_mpdu->tail;
 
 		if (head_msdu && tail_msdu) {
-			ath12k_dp_mon_rx_deliver(ar, mac_id, head_msdu,
+			ath12k_dp_mon_rx_deliver(ar, head_msdu,
 						 tail_msdu, ppdu_info, napi);
 		}
 
@@ -1924,7 +1923,7 @@ ath12k_dp_mon_tx_status_get_num_user(u16 tlv_tag,
 }
 
 static void
-ath12k_dp_mon_tx_process_ppdu_info(struct ath12k *ar, int mac_id,
+ath12k_dp_mon_tx_process_ppdu_info(struct ath12k *ar,
 				   struct napi_struct *napi,
 				   struct dp_mon_tx_ppdu_info *tx_ppdu_info)
 {
@@ -1938,7 +1937,7 @@ ath12k_dp_mon_tx_process_ppdu_info(struct ath12k *ar, int mac_id,
 		tail_msdu = mon_mpdu->tail;
 
 		if (head_msdu)
-			ath12k_dp_mon_rx_deliver(ar, mac_id, head_msdu, tail_msdu,
+			ath12k_dp_mon_rx_deliver(ar, head_msdu, tail_msdu,
 						 &tx_ppdu_info->rx_status, napi);
 
 		kfree(mon_mpdu);
@@ -1948,7 +1947,6 @@ ath12k_dp_mon_tx_process_ppdu_info(struct ath12k *ar, int mac_id,
 enum hal_rx_mon_status
 ath12k_dp_mon_tx_parse_mon_status(struct ath12k *ar,
 				  struct ath12k_mon_data *pmon,
-				  int mac_id,
 				  struct sk_buff *skb,
 				  struct napi_struct *napi,
 				  u32 ppdu_id)
@@ -1995,13 +1993,13 @@ ath12k_dp_mon_tx_parse_mon_status(struct ath12k *ar,
 			break;
 	} while (tlv_status != DP_MON_TX_FES_STATUS_END);
 
-	ath12k_dp_mon_tx_process_ppdu_info(ar, mac_id, napi, tx_data_ppdu_info);
-	ath12k_dp_mon_tx_process_ppdu_info(ar, mac_id, napi, tx_prot_ppdu_info);
+	ath12k_dp_mon_tx_process_ppdu_info(ar, napi, tx_data_ppdu_info);
+	ath12k_dp_mon_tx_process_ppdu_info(ar, napi, tx_prot_ppdu_info);
 
 	return tlv_status;
 }
 
-int ath12k_dp_mon_srng_process(struct ath12k *ar, int mac_id, int *budget,
+int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 			       enum dp_monitor_mode monitor_mode,
 			       struct napi_struct *napi)
 {
@@ -2022,12 +2020,13 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int mac_id, int *budget,
 	bool end_of_ppdu;
 	struct hal_rx_mon_ppdu_info *ppdu_info;
 	struct ath12k_peer *peer = NULL;
+	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, ar->pdev_idx);
 
 	ppdu_info = &pmon->mon_ppdu_info;
 	memset(ppdu_info, 0, sizeof(*ppdu_info));
 	ppdu_info->peer_id = HAL_INVALID_PEERID;
 
-	srng_id = ath12k_hw_mac_id_to_srng_id(ab->hw_params, mac_id);
+	srng_id = ath12k_hw_mac_id_to_srng_id(ab->hw_params, pdev_idx);
 
 	if (monitor_mode == ATH12K_DP_RX_MONITOR_MODE) {
 		mon_dst_ring = &pdev_dp->rxdma_mon_dst_ring[srng_id];
@@ -2077,10 +2076,10 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int mac_id, int *budget,
 			skb = pmon->dest_skb_q[i];
 
 			if (monitor_mode == ATH12K_DP_RX_MONITOR_MODE)
-				ath12k_dp_mon_rx_parse_mon_status(ar, pmon, mac_id,
+				ath12k_dp_mon_rx_parse_mon_status(ar, pmon,
 								  skb, napi);
 			else
-				ath12k_dp_mon_tx_parse_mon_status(ar, pmon, mac_id,
+				ath12k_dp_mon_tx_parse_mon_status(ar, pmon,
 								  skb, napi, ppdu_id);
 
 			peer = ath12k_peer_find_by_id(ab, ppdu_info->peer_id);
@@ -2538,7 +2537,7 @@ int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
 	if (!ar->monitor_started)
 		ath12k_dp_mon_rx_process_stats(ar, mac_id, napi, &budget);
 	else
-		num_buffs_reaped = ath12k_dp_mon_srng_process(ar, mac_id, &budget,
+		num_buffs_reaped = ath12k_dp_mon_srng_process(ar, &budget,
 							      monitor_mode, napi);
 
 	return num_buffs_reaped;
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index fb9e9c176ce5..64c959c36459 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_DP_MON_H
@@ -77,12 +77,12 @@ struct dp_mon_tx_ppdu_info {
 enum hal_rx_mon_status
 ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 				  struct ath12k_mon_data *pmon,
-				  int mac_id, struct sk_buff *skb,
+				  struct sk_buff *skb,
 				  struct napi_struct *napi);
 int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_mon_ring *buf_ring,
 				int req_entries);
-int ath12k_dp_mon_srng_process(struct ath12k *ar, int mac_id,
+int ath12k_dp_mon_srng_process(struct ath12k *ar,
 			       int *budget, enum dp_monitor_mode monitor_mode,
 			       struct napi_struct *napi);
 int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
@@ -96,7 +96,6 @@ ath12k_dp_mon_tx_status_get_num_user(u16 tlv_tag,
 enum hal_rx_mon_status
 ath12k_dp_mon_tx_parse_mon_status(struct ath12k *ar,
 				  struct ath12k_mon_data *pmon,
-				  int mac_id,
 				  struct sk_buff *skb,
 				  struct napi_struct *napi,
 				  u32 ppdu_id);
-- 
2.34.1


