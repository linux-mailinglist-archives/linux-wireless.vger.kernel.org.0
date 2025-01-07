Return-Path: <linux-wireless+bounces-17123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ADAA034F0
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 03:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342CC1642F8
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 02:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BC11494C3;
	Tue,  7 Jan 2025 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TjYmQy3l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610742A94
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736215849; cv=none; b=Xf7MqkJ2uNYfMkLUvPys8rIJyJ8PLJHZ5XJ0BsAEQsgG6qahvfWVfyjz4LcEdhXocNYq5kTgIayxiZuKZUnkehne+3GfzfHR49JKbsjHZwHyoSS9NEeQrO3cV3W1lDRnDFZmImMTgu0B50DHjOjF7PJl0HAUer7tJTegkUkssM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736215849; c=relaxed/simple;
	bh=CFQegViiiY1GOhTYzx65XZGyTGHGnLuGZxaZL0FcSmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlk27+JOFwgnuQe9ESVlwjjEqS0ztMtgI03oegc3ksZjpWWnBadE+JInxzbQ5nQ/nzikwoMeHLmIFGr6fwsorBEnlLYIiTqczcbxHGN1ZSf50G5raUf11Ahe2Fpj5MG3gILywj2wE0uUpQRzBk1+a9GFMK+Ij+je4yK/bpwQ3qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TjYmQy3l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506Hs7u1012374;
	Tue, 7 Jan 2025 02:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0IdGK4Np+eRQfFRkOJCRI2wHxUAtP5qX2KKsGB5l05A=; b=TjYmQy3lY5YehZk+
	Ptgamrnt/jAW43j9SYuu+9Ubcia4wcoXelii+dNGZ1NQZ5cDm7Mne5bv6E1acHht
	7Srgn2eiMSB4Ylxf98f2mCt6Nfti+jPhSjQycmWIWO56pdvuhNN3ds1+uUsnjW//
	AceQkzZ+1FfS1jR5Dr8W5XSMM0v4ZvcIHZwhXNKPfx7YxxEUjix8YxA89gU/hIuu
	WNUT5jMzHXeid/ZHQwk4TYE1sT4RNVZfZ6Qb1cZNvPvgfi303ZXWZsUbM1LjC+Yt
	tjIbIHNT8ghVRPWWeCgy8iqDpn7SfbJT4M3SVfedXRnKG6zitUnQjTk9X963om5P
	F96NWQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440kyqgw23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 02:10:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5072Ae2S010369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 02:10:40 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 Jan 2025 18:10:38 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 3/7] wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
Date: Tue, 7 Jan 2025 07:40:13 +0530
Message-ID: <20250107021017.3857555-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
References: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: F97I20jBpvxLta_ZAUmqrehYove5J8ej
X-Proofpoint-GUID: F97I20jBpvxLta_ZAUmqrehYove5J8ej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070015

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
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 58 ++++++++++--------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index c82dc71f8790..4e5c645b56e0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1731,30 +1731,26 @@ static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
 
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
@@ -1983,7 +1979,8 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 
 static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
 					  struct sk_buff *msdu,
-					  struct ieee80211_rx_status *status)
+					  struct ieee80211_rx_status *status,
+					  u8 decap)
 {
 	static const struct ieee80211_radiotap_he known = {
 		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
@@ -1995,7 +1992,6 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	struct ieee80211_sta *pubsta = NULL;
 	struct ath12k_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	u8 decap = DP_RX_DECAP_TYPE_RAW;
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol_tkip = rxcb->is_eapol;
 
@@ -2008,8 +2004,6 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 		status->flag |= RX_FLAG_RADIOTAP_HE;
 	}
 
-	if (!(status->flag & RX_FLAG_ONLY_MONITOR))
-		decap = ath12k_dp_rx_h_decap_type(ar->ab, rxcb->rx_desc);
 	spin_lock_bh(&ar->ab->base_lock);
 	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu);
 	if (peer && peer->sta) {
@@ -2066,25 +2060,23 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
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
@@ -2101,8 +2093,12 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
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
@@ -2110,7 +2106,7 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
 	return 0;
 
 mon_deliver_fail:
-	mon_skb = head_msdu;
+	mon_skb = mon_mpdu->head;
 	while (mon_skb) {
 		skb_next = mon_skb->next;
 		dev_kfree_skb_any(mon_skb);
@@ -2316,7 +2312,6 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
 	struct dp_mon_mpdu *tmp;
 	struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
-	struct sk_buff *head_msdu, *tail_msdu;
 	enum hal_rx_mon_status hal_status;
 
 	hal_status = ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
@@ -2325,13 +2320,9 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 
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
@@ -3016,16 +3007,13 @@ ath12k_dp_mon_tx_process_ppdu_info(struct ath12k *ar,
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


