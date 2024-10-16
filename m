Return-Path: <linux-wireless+bounces-14052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C48D9A01E8
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3E71C209EE
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519001B394D;
	Wed, 16 Oct 2024 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RV23bXBv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC31B3941
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061863; cv=none; b=OCBWBMubuNNIZy0/GCo1cmzb3RDG7K8J+xAu0Cl5NputkfeuTezVdD62liMeBb0Q1grFoGEyrUcfLc8fz5JO8Z/ePhk6QLvQeOv8RRspRwlM60SCau21QDeRev9dgpwef5VvjO5N4LN4UD3zZt3SKFBL7vrCByQ+LV/nDr5WkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061863; c=relaxed/simple;
	bh=UMorZGioDACxSWGY0Vt9c21A2Z8lgAqj3t/+Xsto2UU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=az+7qqZWebKiuy4uFzaKjAUiBV2uFCAF1Jy8gKvgtQQMI1g11Y6WFzt0qfa21SRam3K7MZUfxBxw3Zee2emSmuRmwu9cKUXU0GY/esGdvU3Bnz/ttAFlZSZd+wnWrPHXqSL9NrWGh4GHAsevBpXD21rbUeHHUIRl+OrdUhDkxhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RV23bXBv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G6uVDZ023585;
	Wed, 16 Oct 2024 06:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ILuyuaShI57NtPFUiEpkKU6/1saS3ftxntnqrkzuILA=; b=RV23bXBvUXeJICre
	jIPoooyzBRaDVI/h/prUm0o3iS13LQFUuJum8+KeDBvOxxCpaEnWOq57q4xiVvE1
	2jhJXXxy9vhXXt1sn71jxgAY04Aqbo4RzszgUZrj26D1SbxKGwTiPAqk5e6/Di53
	vMgeHYEbbFtcGQoKAWH60HIY0j/QZ15rS71dTVJ7aIke5kp+BHqCgMHSJX17eJ1s
	tDHLD3QA0mHuf8vL2GFUdQTCExRff4fMY0lzv0WHlkYtdGr1o+LSTNUNEzFVjzUY
	CcNx4AWIOoX2cA43ngIWeVHaedFuVa+WZrCMCZuAq+11sLlKm2DajKS01FdHv5FR
	tGo88w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a8nq0060-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G6vcat019500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:39 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 23:57:37 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 09/11] wifi: ath12k: use tail MSDU to get MSDU information
Date: Wed, 16 Oct 2024 14:56:58 +0800
Message-ID: <20241016065700.1090-10-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241016065700.1090-1-quic_kangyang@quicinc.com>
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fh7e2VLebaOg2rFjuwFKwUuaviyZf21u
X-Proofpoint-GUID: Fh7e2VLebaOg2rFjuwFKwUuaviyZf21u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160044

When receiving a packet in monitor mode, hardware will fill status
information msdu_end for MSDUs. Then host can use these status
information to get specific information about this packet, such as
l3 offset, bandwidth, mcs, packet type.

If this packet is composed of multiple MSDUs, then hardware will only
fill status information for the last(tail) MSDU. At this time,
MSDU information is uncertain for others MSDUs. But current code use
the first MSDU in monitor mode, so will get the wrong information.

Fix it by getting msdu information from last(tail) msdu.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 41 +++++++++++++-----------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 486f95593aa6..ed963ea2cb8f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -855,24 +855,26 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 	return HAL_RX_MON_STATUS_PPDU_NOT_DONE;
 }
 
-static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar, struct sk_buff *msdu)
+static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
+					       struct sk_buff *head_msdu,
+					       struct sk_buff *tail_msdu)
 {
 	u32 rx_pkt_offset, l2_hdr_offset;
 
 	rx_pkt_offset = ar->ab->hal.hal_desc_sz;
-	l2_hdr_offset = ath12k_dp_rx_h_l3pad(ar->ab,
-					     (struct hal_rx_desc *)msdu->data);
-	skb_pull(msdu, rx_pkt_offset + l2_hdr_offset);
+	l2_hdr_offset =
+		ath12k_dp_rx_h_l3pad(ar->ab, (struct hal_rx_desc *)tail_msdu->data);
+	skb_pull(head_msdu, rx_pkt_offset + l2_hdr_offset);
 }
 
 static struct sk_buff *
-ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
-			    u32 mac_id, struct sk_buff *head_msdu,
+ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar, u32 mac_id,
+			    struct sk_buff *head_msdu, struct sk_buff *tail_msdu,
 			    struct ieee80211_rx_status *rxs, bool *fcs_err)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct sk_buff *msdu, *mpdu_buf, *prev_buf;
-	struct hal_rx_desc *rx_desc;
+	struct hal_rx_desc *rx_desc, *tail_rx_desc;
 	u8 *hdr_desc, *dest, decap_format;
 	struct ieee80211_hdr_3addr *wh;
 	u32 err_bitmap;
@@ -883,23 +885,24 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 		goto err_merge_fail;
 
 	rx_desc = (struct hal_rx_desc *)head_msdu->data;
-	err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, rx_desc);
+	tail_rx_desc = (struct hal_rx_desc *)tail_msdu->data;
 
+	err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, tail_rx_desc);
 	if (err_bitmap & HAL_RX_MPDU_ERR_FCS)
 		*fcs_err = true;
 
-	decap_format = ath12k_dp_rx_h_decap_type(ab, rx_desc);
+	decap_format = ath12k_dp_rx_h_decap_type(ab, tail_rx_desc);
 
-	ath12k_dp_rx_h_ppdu(ar, rx_desc, rxs);
+	ath12k_dp_rx_h_ppdu(ar, tail_rx_desc, rxs);
 
 	if (decap_format == DP_RX_DECAP_TYPE_RAW) {
-		ath12k_dp_mon_rx_msdus_set_payload(ar, head_msdu);
+		ath12k_dp_mon_rx_msdus_set_payload(ar, head_msdu, tail_msdu);
 
 		prev_buf = head_msdu;
 		msdu = head_msdu->next;
 
 		while (msdu) {
-			ath12k_dp_mon_rx_msdus_set_payload(ar, msdu);
+			ath12k_dp_mon_rx_msdus_set_payload(ar, msdu, tail_msdu);
 
 			prev_buf = msdu;
 			msdu = msdu->next;
@@ -924,7 +927,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 		msdu = head_msdu;
 
 		while (msdu) {
-			ath12k_dp_mon_rx_msdus_set_payload(ar, msdu);
+			ath12k_dp_mon_rx_msdus_set_payload(ar, msdu, tail_msdu);
 			if (qos_pkt) {
 				dest = skb_push(msdu, sizeof(__le16));
 				if (!dest)
@@ -1130,7 +1133,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 }
 
 static int ath12k_dp_mon_rx_deliver(struct ath12k *ar, u32 mac_id,
-				    struct sk_buff *head_msdu,
+				    struct sk_buff *head_msdu, struct sk_buff *tail_msdu,
 				    struct hal_rx_mon_ppdu_info *ppduinfo,
 				    struct napi_struct *napi)
 {
@@ -1139,7 +1142,8 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar, u32 mac_id,
 	struct ieee80211_rx_status *rxs = &dp->rx_status;
 	bool fcs_err = false;
 
-	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar, mac_id, head_msdu,
+	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar, mac_id,
+					      head_msdu, tail_msdu,
 					      rxs, &fcs_err);
 	if (!mon_skb)
 		goto mon_deliver_fail;
@@ -1247,7 +1251,7 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 
 		if (head_msdu && tail_msdu) {
 			ath12k_dp_mon_rx_deliver(ar, mac_id, head_msdu,
-						 ppdu_info, napi);
+						 tail_msdu, ppdu_info, napi);
 		}
 
 		kfree(mon_mpdu);
@@ -1943,15 +1947,16 @@ ath12k_dp_mon_tx_process_ppdu_info(struct ath12k *ar, int mac_id,
 				   struct dp_mon_tx_ppdu_info *tx_ppdu_info)
 {
 	struct dp_mon_mpdu *tmp, *mon_mpdu;
-	struct sk_buff *head_msdu;
+	struct sk_buff *head_msdu, *tail_msdu;
 
 	list_for_each_entry_safe(mon_mpdu, tmp,
 				 &tx_ppdu_info->dp_tx_mon_mpdu_list, list) {
 		list_del(&mon_mpdu->list);
 		head_msdu = mon_mpdu->head;
+		tail_msdu = mon_mpdu->tail;
 
 		if (head_msdu)
-			ath12k_dp_mon_rx_deliver(ar, mac_id, head_msdu,
+			ath12k_dp_mon_rx_deliver(ar, mac_id, head_msdu, tail_msdu,
 						 &tx_ppdu_info->rx_status, napi);
 
 		kfree(mon_mpdu);
-- 
2.34.1


