Return-Path: <linux-wireless+bounces-16771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8269FBF40
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 15:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572D71647F6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8981D7E4F;
	Tue, 24 Dec 2024 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XupfOMOE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4A1D7E26
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050998; cv=none; b=ME8w1Qsrlh35XEv7B+7LQT7PrKd4YI0LQILdzWKkr+AW1meqZ+0XlE6lnCs2jF6RWH72q9XSQbxYbnaOegp5bOyJn+frPwHgR9ZEP688yhtd88Pl8wnxYELinuhRU2ak+5RW7hRXQ01ju0GLKPX6pdA5qW13thGid9Ld/uTTuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050998; c=relaxed/simple;
	bh=I4k8lg9jRBko72YZCOW0APenl5KQa6EoBjSgVe3PBOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcXGqla9UY+5M6eQwZ5Pt3pSfXxeGbXZRHXEsN1e9TSKQP5CvVFUg+LW8pEHYQn/H6WXAhtVlGaCtsN8HHSObePiQMQLKrPefSEdrbwxjGa0etl/OVuVE/CPHTI4cSXfOKfGytaSw0xsoPGxYbTXm+E5tRZyfdM9kjdFsLOKzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XupfOMOE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO9ZbNF007908;
	Tue, 24 Dec 2024 14:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JW3kHTJk1fdpHrhjMF2MFpLHJyAqqwq76yzYInYlMgg=; b=XupfOMOEI5sGNuCZ
	FCJzt8xs4uGU5zK/v5D7npZqQdpNMScOUPpLr6QkqYNK+DMDhcu4KNkt8yb0+G5k
	xnIArkTUgEe19dkYVMKZ4QD3R5Qc1XSOJuz7yERu3SInOjNQj/CIzSRVYOlgtkFT
	O/6kTd5h+n+FhCt1HkKCXzwKVaJuWyPYKCYr5nL97SD8RLrovXNcF8D3wYdqifMd
	fKZeizPDbqTExtWq0wRTXQtVuUunuhX+HWHmuNt4TDi8SkT9IudppIWVkdFMxazc
	eP5AqEyhkPbqfycAoWPzNGhzad3hrThG5JRnL4POq9YUkqeFzi2bgJhYALC4/Wxc
	mO6ALw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qtf89hdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 14:36:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BOEaWBh028626
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 14:36:32 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Dec 2024 06:36:30 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 2/3] wifi: ath12k: Refactor the monitor Tx/RX handler procedure arguments
Date: Tue, 24 Dec 2024 20:06:12 +0530
Message-ID: <20241224143613.164921-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224143613.164921-1-quic_periyasa@quicinc.com>
References: <20241224143613.164921-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: _3RJX6WBwYkEJa1xMxAztPkb9mxKEjKm
X-Proofpoint-ORIG-GUID: _3RJX6WBwYkEJa1xMxAztPkb9mxKEjKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=829 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240126

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


