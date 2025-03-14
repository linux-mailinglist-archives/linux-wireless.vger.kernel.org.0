Return-Path: <linux-wireless+bounces-20387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F203CA6141A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 15:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDFA3B78B8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E4E201035;
	Fri, 14 Mar 2025 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SMxNrYel"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101FA201024
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963869; cv=none; b=TBN+eNfigS3PDlMFEHYhBK8Lp6wFe/j0Yj4CkpKJA75omcquG2f35vKL77KnMBDNUMl0QuPqmWiYeC8UZqf8M+SBqMB1koWdB/K8xvI++R/ZrbMOdgjAJtd4mfCSbdZSNyWRi7u+uupi4trRhUzgayfS5bHhTwtvi8G1nCiqE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963869; c=relaxed/simple;
	bh=Lxy2dtyubcdxig6gjepheKn2fprEzEbxfvhWxTX4+2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAQKGM0OWWKkdj8SFzh1OVN1dMBSMJSZBwhPo1k8LfsULMtGXXjM9yy8JGbu1plvaMoqxVUenO8//SO+7xdkjSTfg8rPs57SXliaPVwzk8U36sUEPYxkHS6W1Oqnw+NR6NWfJjGfQ/pIFIEHmPrwih6wMG5dLVPXr8qv49/ChDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SMxNrYel; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E8HUbd022578;
	Fri, 14 Mar 2025 14:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n7mIpbhpf8iAGiwgMP4kOBXDdAD2ArrEXHJNKGvNRx0=; b=SMxNrYelzOQRaD8A
	Ilt4JFx8/TnlzYeTXSOr8843L/T+1+TX/KE5j7pSxrwQyPRkEmIJZddQhPC93h/w
	ZGbxGTI9IeNRdSuTvwtN+wDaJdz1P5+/oV/M86IMroByJabvawgBX0y/MBWOogvG
	ttqAWR3rPuWmy1N5VfMF+LKz6lLEWt2+DTz5+eyzp7M56a6WHp5NSNtE2z1fYP5a
	nfS6A3JIBsPjv4RcUQXocMGk4EjqyZba3oGr/xQo0VeBE8+Un9m4sV8FR5rSpYTG
	X7/mnJzPcPJBFgz7udBzjWhoflUMpdzkTtJwnhaEQuyCRvR2K54bDjIpfT5umwf+
	7sQ6Og==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bu07mj0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:51:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52EEp2Xj004727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:51:02 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 14 Mar 2025 07:50:59 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Nicolas Escande <nico.escande@gmail.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v10 3/9] wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
Date: Fri, 14 Mar 2025 20:20:31 +0530
Message-ID: <20250314145037.3678649-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
References: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 7ghj_oyH2E8Yb_NUXYqrQlYAmeTpAdzg
X-Authority-Analysis: v=2.4 cv=V+F90fni c=1 sm=1 tr=0 ts=67d44257 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=y0izyFSgjemr6NruFqEA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 7ghj_oyH2E8Yb_NUXYqrQlYAmeTpAdzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=966
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140115

From: P Praneesh <quic_ppranees@quicinc.com>

Currently, error bitmap and decap format information are fetched from the
MSDU Rx TLV data. This logic is inherited from ath11k. However, for ath12k
802.11be hardware, the Rx TLV will not be present in the MSDU data.
Instead, this information is reported separately under the MSDU END TLV
tag. Therefore, remove the existing fetch code, handle the MSDU END TLV
tag and fetch the above information to store it in the mon_mpdu data
structure for use in the merge MSDU procedure.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Tested-by: Nicolas Escande <nico.escande@gmail.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 58 ++++++++++--------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index f4d481fe5b2f..c613f8408c84 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1702,30 +1702,26 @@ static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
 
 static struct sk_buff *
 ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
-			    struct sk_buff *head_msdu, struct sk_buff *tail_msdu,
-			    struct ieee80211_rx_status *rxs, bool *fcs_err)
+			    struct dp_mon_mpdu *mon_mpdu,
+			    struct ieee80211_rx_status *rxs)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct sk_buff *msdu, *mpdu_buf, *prev_buf, *head_frag_list;
+	struct sk_buff *head_msdu, *tail_msdu;
 	struct hal_rx_desc *rx_desc, *tail_rx_desc;
-	u8 *hdr_desc, *dest, decap_format;
+	u8 *hdr_desc, *dest, decap_format = mon_mpdu->decap_format;
 	struct ieee80211_hdr_3addr *wh;
-	u32 err_bitmap, frag_list_sum_len = 0;
+	u32 frag_list_sum_len = 0;
 
 	mpdu_buf = NULL;
+	head_msdu = mon_mpdu->head;
+	tail_msdu = mon_mpdu->tail;
 
 	if (!head_msdu)
 		goto err_merge_fail;
 
-	rx_desc = (struct hal_rx_desc *)head_msdu->data;
 	tail_rx_desc = (struct hal_rx_desc *)tail_msdu->data;
 
-	err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, tail_rx_desc);
-	if (err_bitmap & HAL_RX_MPDU_ERR_FCS)
-		*fcs_err = true;
-
-	decap_format = ath12k_dp_rx_h_decap_type(ab, tail_rx_desc);
-
 	ath12k_dp_rx_h_ppdu(ar, tail_rx_desc, rxs);
 
 	if (decap_format == DP_RX_DECAP_TYPE_RAW) {
@@ -1954,7 +1950,8 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 
 static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
 					  struct sk_buff *msdu,
-					  struct ieee80211_rx_status *status)
+					  struct ieee80211_rx_status *status,
+					  u8 decap)
 {
 	static const struct ieee80211_radiotap_he known = {
 		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
@@ -1966,7 +1963,6 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	struct ieee80211_sta *pubsta = NULL;
 	struct ath12k_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	u8 decap = DP_RX_DECAP_TYPE_RAW;
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol_tkip = rxcb->is_eapol;
 
@@ -1979,8 +1975,6 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 		status->flag |= RX_FLAG_RADIOTAP_HE;
 	}
 
-	if (!(status->flag & RX_FLAG_ONLY_MONITOR))
-		decap = ath12k_dp_rx_h_decap_type(ar->ab, rxcb->rx_desc);
 	spin_lock_bh(&ar->ab->base_lock);
 	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu);
 	if (peer && peer->sta) {
@@ -2037,25 +2031,23 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 }
 
 static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
-				    struct sk_buff *head_msdu, struct sk_buff *tail_msdu,
+				    struct dp_mon_mpdu *mon_mpdu,
 				    struct hal_rx_mon_ppdu_info *ppduinfo,
 				    struct napi_struct *napi)
 {
 	struct ath12k_pdev_dp *dp = &ar->dp;
 	struct sk_buff *mon_skb, *skb_next, *header;
 	struct ieee80211_rx_status *rxs = &dp->rx_status;
-	bool fcs_err = false;
+	u8 decap = DP_RX_DECAP_TYPE_RAW;
 
-	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar,
-					      head_msdu, tail_msdu,
-					      rxs, &fcs_err);
+	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar, mon_mpdu, rxs);
 	if (!mon_skb)
 		goto mon_deliver_fail;
 
 	header = mon_skb;
 	rxs->flag = 0;
 
-	if (fcs_err)
+	if (mon_mpdu->err_bitmap & HAL_RX_MPDU_ERR_FCS)
 		rxs->flag = RX_FLAG_FAILED_FCS_CRC;
 
 	do {
@@ -2072,8 +2064,12 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
 			rxs->flag |= RX_FLAG_ALLOW_SAME_PN;
 		}
 		rxs->flag |= RX_FLAG_ONLY_MONITOR;
+
+		if (!(rxs->flag & RX_FLAG_ONLY_MONITOR))
+			decap = mon_mpdu->decap_format;
+
 		ath12k_dp_mon_update_radiotap(ar, ppduinfo, mon_skb, rxs);
-		ath12k_dp_mon_rx_deliver_msdu(ar, napi, mon_skb, rxs);
+		ath12k_dp_mon_rx_deliver_msdu(ar, napi, mon_skb, rxs, decap);
 		mon_skb = skb_next;
 	} while (mon_skb);
 	rxs->flag = 0;
@@ -2081,7 +2077,7 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
 	return 0;
 
 mon_deliver_fail:
-	mon_skb = head_msdu;
+	mon_skb = mon_mpdu->head;
 	while (mon_skb) {
 		skb_next = mon_skb->next;
 		dev_kfree_skb_any(mon_skb);
@@ -2287,7 +2283,6 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
 	struct dp_mon_mpdu *tmp;
 	struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
-	struct sk_buff *head_msdu, *tail_msdu;
 	enum hal_rx_mon_status hal_status;
 
 	hal_status = ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
@@ -2296,13 +2291,9 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 
 	list_for_each_entry_safe(mon_mpdu, tmp, &pmon->dp_rx_mon_mpdu_list, list) {
 		list_del(&mon_mpdu->list);
-		head_msdu = mon_mpdu->head;
-		tail_msdu = mon_mpdu->tail;
 
-		if (head_msdu && tail_msdu) {
-			ath12k_dp_mon_rx_deliver(ar, head_msdu,
-						 tail_msdu, ppdu_info, napi);
-		}
+		if (mon_mpdu->head && mon_mpdu->tail)
+			ath12k_dp_mon_rx_deliver(ar, mon_mpdu, ppdu_info, napi);
 
 		kfree(mon_mpdu);
 	}
@@ -2987,16 +2978,13 @@ ath12k_dp_mon_tx_process_ppdu_info(struct ath12k *ar,
 				   struct dp_mon_tx_ppdu_info *tx_ppdu_info)
 {
 	struct dp_mon_mpdu *tmp, *mon_mpdu;
-	struct sk_buff *head_msdu, *tail_msdu;
 
 	list_for_each_entry_safe(mon_mpdu, tmp,
 				 &tx_ppdu_info->dp_tx_mon_mpdu_list, list) {
 		list_del(&mon_mpdu->list);
-		head_msdu = mon_mpdu->head;
-		tail_msdu = mon_mpdu->tail;
 
-		if (head_msdu)
-			ath12k_dp_mon_rx_deliver(ar, head_msdu, tail_msdu,
+		if (mon_mpdu->head)
+			ath12k_dp_mon_rx_deliver(ar, mon_mpdu,
 						 &tx_ppdu_info->rx_status, napi);
 
 		kfree(mon_mpdu);
-- 
2.34.1


