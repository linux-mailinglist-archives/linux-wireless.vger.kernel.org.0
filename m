Return-Path: <linux-wireless+bounces-19288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640BFA3FBE6
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 17:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25B319E4879
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26D2116F9;
	Fri, 21 Feb 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k6x48NZA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D60212FB5
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156103; cv=none; b=ZoziNNqoSR5AgMeE9yr/fITQj1YcVdeXDNT3m2LLwPDuIj/tGdURjm9CN7JCWm70IdWFZ1JfSirGmlKoh9x/xMqKSha8iovN8xk2foM1DHFD7bxCxF3yPl5s41Ljo5SNrnI1B11lD69CZWarund4EoiLSdhJ8TtRmjt19rFXtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156103; c=relaxed/simple;
	bh=Lxy2dtyubcdxig6gjepheKn2fprEzEbxfvhWxTX4+2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkglOpb9xdP8BsNOCHVSXHdtoMUK86Ud8MnY0kU3DWPREV1bRu9gFSFrpP1pK+Y8sLXSlwbt6mZ7nPa0c2H9iKtaWlAWMHCPRht5AAtsWTATdB9O/0jyzhU5JkZpXSfdaH7J7MmFjdXCOOWM8v5Px5A1YpyNHozRf2Zi1AdSgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k6x48NZA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LBM3ni011647;
	Fri, 21 Feb 2025 16:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n7mIpbhpf8iAGiwgMP4kOBXDdAD2ArrEXHJNKGvNRx0=; b=k6x48NZAhU5NMkTN
	y3h7yjgTRl89VuSAA5ExHgq4JvJy8iPqWbgR7iZsl320e/7C2bnDVS4yfQoyswEk
	O9LgWhlv7kSYAIIGez6CcjWa0srBtibkMiIOvSbbtQHb2nFQOj+ug+i7lRdEab+2
	N6aAfLBP9iPwfw1wK0w9hizJn5BFjTcYluOA1v0Dl3g+DJApZRnQt1rEeuQtggaL
	nNbkV/ItgBucA9vDCFMaG2YtOzrOYDaluL0pSk7HjmM4sU1HydKGLBme87+ztnRN
	ansqJG8oskx7A7WbauHfqNI/ojwwEPmsFoh2r2LRcpdoKCWuU1TexRtzbpZORai+
	DGETJQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3tk89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 16:41:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51LGfatl006688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 16:41:36 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Feb 2025 08:41:34 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Nicolas Escande <nico.escande@gmail.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v6 3/8] wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
Date: Fri, 21 Feb 2025 22:11:05 +0530
Message-ID: <20250221164110.3277222-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221164110.3277222-1-quic_periyasa@quicinc.com>
References: <20250221164110.3277222-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Ume103qIytU13t_yO90cxnex58vkqkO8
X-Proofpoint-GUID: Ume103qIytU13t_yO90cxnex58vkqkO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=970 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502210118

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


