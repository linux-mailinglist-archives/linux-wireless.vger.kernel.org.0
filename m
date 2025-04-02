Return-Path: <linux-wireless+bounces-21109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D2A7951A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 20:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1D23B3BE6
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 18:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0EE1D5ACF;
	Wed,  2 Apr 2025 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSNxNSJZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242026AFB
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618575; cv=none; b=O+h3O+XiFGYTXT0uRY4u6KubcOBqvLW4Y2AiknaeY9u/pYzBLVjCV2X3Tt+BSK81t+HQ3wVjk6J+3pQh/N9dTk3+UC7Pz9hAA6drmXcMDQDEsSmNc2Cmar2+DksXsWcF2JvIHwX8LNzTrCnwd7BROafjvEWDqTn1xVbm7mnQE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618575; c=relaxed/simple;
	bh=ECXoBaA7Cvm/M6WSVK3oYrR1CXtF0fJDLpr0CbIPydE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJJJlrMD1xOoSd7sCNKkK5i2fPfsT+iy0VKHFKbBHGNKgS7PO++JHp5HPTNOaaNlvJ/Urb44GUbR8mgEuhI1vPhqGwY9pryE0Co1F7/XtMVgqvUp2+NRcI0hFFMtQp+w5tsoMI8Y/vpiIUMhf3pGCjb7GUkMRgQfEm89X8J2Av0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NSNxNSJZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532Adj10032702
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 18:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=U4gq7VPG5p8
	hBCiNFCO8gQ2EvNElpYJTQ7AjMI7IsZU=; b=NSNxNSJZnf0HtYMNtu7KEWItFOr
	2OI1Eea1MIQPtPqwQ9UJgLOPHzho3qqrAE67BHLPUibXQ9vY+fO/IUTojKjEbc1K
	9e0TQtp66FqejqYu0xpFWI7FtObRh61g9aTXACrpSHuS2uVZTfR0NRThVqHECtgd
	rNfustVet4/vHHRoj9zc/wocEfbIVQ6BiheSygs7FzZZkWSuG/BAUIBCa279wsnF
	EahGeCgiKXbrFrfOWq3iRLyYilhzLDX5v+Hu4d/XLXh0CQ2FJDTtOnK4ldgQwbcg
	6qYnN7Zbktx8wbcalQNG2rYsFcw6DPgMbb5oT8ytM+cnv4/4rB1fiBjD3MA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qmpmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 18:29:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-227a8cdd272so1105945ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 11:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743618570; x=1744223370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4gq7VPG5p8hBCiNFCO8gQ2EvNElpYJTQ7AjMI7IsZU=;
        b=mYvP1Dl6ukdMjHvqwhefsU3ZS+eJ1te55h0j5WRzI2+6qUyCDOmHNyZWQDy4dbXZfh
         whZGMANPCUDBclk8PFOyxiXYF2soJrd84dPEt4LSb+M60/rwSvjsZCVFglf0DMIs72Ne
         jwNG2uTg+ALMlucnMZFG5V/CTWRH8Kys5pDqDkIASmhPRGd+eSSkn0p8AHsTxtknnVTI
         +Eu94cGKSqUKhKjYies3UwiIcJRPtZnpZmEZAOnYHgIH+6zA+Iiacgo/qCFMClzk6KEF
         a0igkJuGzv810b3G9fXHbO2dhO4GoSFqO3kpfVu3wwso4pOAr4xaOyk2U539vYl/cLoN
         C5/Q==
X-Gm-Message-State: AOJu0YzGRxUD7PuS9wbAxQFAe6A7I5s6ZQ8XoF79bS/bcKyiu+f+L2Bk
	w538pAesmMO/Bv594K5E1M3SmvvJXU/teZuaO1wxWsdOYrbTwsOa0xxIJEa6DKtfhVBtyHR897s
	zWJNw7HBUQ0n3KXYvCYbYeRUmOPq8v0jY9YsYjqT1rGbt3z2GY6/2mqzs0Q9UCEYA2oiQW2r5WQ
	==
X-Gm-Gg: ASbGncuj0MP9mSvdvoG60Woe8qUnWQ0bExMBbBYDYqAWo8C3iYCcxhzMKqXJg5PaLro
	K1tO2XBYACVO64nBMTj6lilNDBIAfh8W4lsYD+FWluBSVsSDDivoqC5cqRiFaHJD8mO3m7By5yk
	gBn+qqHbuBSl/Uhc5NpE2sKsTGdb3Tyxgu3D5ZaS4RYiheeZmZ4hiccxrKN/wOsZHqVVGNXSWdN
	hhNHtAfsLoFEo9UHkuwX9DRQ5kJF/0z/I2lHetSzda9XOMZCyNFb2Jt5A3BB3vq++3EN6zT4UJv
	cOqZzqjmIkHXqqybDUxCOyVeBxLK/ZeUVaFSPcEyjARYSZgYIpPBBh74wPYkuxIxrckjaovkwr3
	P3APn5yh9JkFvQOFDuvdDiGL/f4G7/5KP1Q==
X-Received: by 2002:a17:902:f682:b0:223:37ec:63d3 with SMTP id d9443c01a7336-2292f95d75bmr232199945ad.18.1743618569868;
        Wed, 02 Apr 2025 11:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdVbeZOHNycIjoKCaoHJHKNllRvjY+UdxJ9MCg6qf8S0OcUgTerhQHbmJucDtcvuokJPcogQ==
X-Received: by 2002:a17:902:f682:b0:223:37ec:63d3 with SMTP id d9443c01a7336-2292f95d75bmr232199535ad.18.1743618569037;
        Wed, 02 Apr 2025 11:29:29 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf860sm111978885ad.115.2025.04.02.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:29:28 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 1/2] wifi: ath12k: add rx_info to capture required field from rx descriptor
Date: Wed,  2 Apr 2025 23:59:16 +0530
Message-Id: <20250402182917.2715596-2-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402182917.2715596-1-praneesh.p@oss.qualcomm.com>
References: <20250402182917.2715596-1-praneesh.p@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67ed820b cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=wUTCkfucAXvQnJ7ZX4kA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: KF2ing5M0HR4VG0NwIrQD7SqUDVt2Cr3
X-Proofpoint-GUID: KF2ing5M0HR4VG0NwIrQD7SqUDVt2Cr3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=854 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020117

In ath12k_dp_rx_h_mpdu(), as part of undecap to native wifi mode, the rx
descriptor memory is getting overwritten. After this function call, all
the rx descriptor related memory accesses give invalid values. To handle
this scenario, introduce a new structure ath12k_dp_rx_info which
pre-caches all the required fields from the rx descriptor before calling
ath12k_dp_rx_h_ppdu(). This rx_info structure will be used in the next
patch.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 80 ++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/dp_rx.h | 18 ++++++
 2 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 66603e9c154b..27ac907789e5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2412,6 +2412,30 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc *rx_desc,
 	}
 }
 
+static void ath12k_dp_rx_h_fetch_info(struct ath12k_base *ab,
+				      struct hal_rx_desc *rx_desc,
+				      struct ath12k_dp_rx_info *rx_info)
+{
+	rx_info->ip_csum_fail = ath12k_dp_rx_h_ip_cksum_fail(ab, rx_desc);
+	rx_info->l4_csum_fail = ath12k_dp_rx_h_l4_cksum_fail(ab, rx_desc);
+	rx_info->is_mcbc = ath12k_dp_rx_h_is_da_mcbc(ab, rx_desc);
+	rx_info->decap_type = ath12k_dp_rx_h_decap_type(ab, rx_desc);
+	rx_info->pkt_type = ath12k_dp_rx_h_pkt_type(ab, rx_desc);
+	rx_info->sgi = ath12k_dp_rx_h_sgi(ab, rx_desc);
+	rx_info->rate_mcs = ath12k_dp_rx_h_rate_mcs(ab, rx_desc);
+	rx_info->bw = ath12k_dp_rx_h_rx_bw(ab, rx_desc);
+	rx_info->nss = ath12k_dp_rx_h_nss(ab, rx_desc);
+	rx_info->tid = ath12k_dp_rx_h_tid(ab, rx_desc);
+	rx_info->peer_id = ath12k_dp_rx_h_peer_id(ab, rx_desc);
+	rx_info->phy_meta_data = ath12k_dp_rx_h_freq(ab, rx_desc);
+
+	if (ath12k_dp_rxdesc_mac_addr2_valid(ab, rx_desc)) {
+		ether_addr_copy(rx_info->addr2,
+				ath12k_dp_rxdesc_get_mpdu_start_addr2(ab, rx_desc));
+		rx_info->addr2_present = true;
+	}
+}
+
 void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
 			 struct ieee80211_rx_status *rx_status)
 {
@@ -2574,7 +2598,7 @@ static bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
 static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 				     struct sk_buff *msdu,
 				     struct sk_buff_head *msdu_list,
-				     struct ieee80211_rx_status *rx_status)
+				     struct ath12k_dp_rx_info *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct hal_rx_desc *rx_desc, *lrx_desc;
@@ -2634,10 +2658,11 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 		goto free_out;
 	}
 
-	ath12k_dp_rx_h_ppdu(ar, rx_desc, rx_status);
-	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_status);
+	ath12k_dp_rx_h_fetch_info(ab, rx_desc, rx_info);
+	ath12k_dp_rx_h_ppdu(ar, rx_desc, rx_info->rx_status);
+	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_info->rx_status);
 
-	rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
+	rx_info->rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
 
 	return 0;
 
@@ -2657,12 +2682,16 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 	struct ath12k *ar;
 	struct ath12k_hw_link *hw_links = ag->hw_links;
 	struct ath12k_base *partner_ab;
+	struct ath12k_dp_rx_info rx_info;
 	u8 hw_link_id, pdev_id;
 	int ret;
 
 	if (skb_queue_empty(msdu_list))
 		return;
 
+	rx_info.addr2_present = false;
+	rx_info.rx_status = &rx_status;
+
 	rcu_read_lock();
 
 	while ((msdu = __skb_dequeue(msdu_list))) {
@@ -2683,7 +2712,7 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 			continue;
 		}
 
-		ret = ath12k_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_status);
+		ret = ath12k_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_info);
 		if (ret) {
 			ath12k_dbg(ab, ATH12K_DBG_DATA,
 				   "Unable to process msdu %d", ret);
@@ -2984,6 +3013,7 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 	struct ieee80211_rx_status *rxs = IEEE80211_SKB_RXCB(msdu);
 	struct ieee80211_key_conf *key_conf;
 	struct ieee80211_hdr *hdr;
+	struct ath12k_dp_rx_info rx_info;
 	u8 mic[IEEE80211_CCMP_MIC_LEN];
 	int head_len, tail_len, ret;
 	size_t data_len;
@@ -2994,6 +3024,9 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 	if (ath12k_dp_rx_h_enctype(ab, rx_desc) != HAL_ENCRYPT_TYPE_TKIP_MIC)
 		return 0;
 
+	rx_info.addr2_present = false;
+	rx_info.rx_status = rxs;
+
 	hdr = (struct ieee80211_hdr *)(msdu->data + hal_rx_desc_sz);
 	hdr_len = ieee80211_hdrlen(hdr->frame_control);
 	head_len = hdr_len + hal_rx_desc_sz + IEEE80211_TKIP_IV_LEN;
@@ -3020,6 +3053,8 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 	(ATH12K_SKB_RXCB(msdu))->is_first_msdu = true;
 	(ATH12K_SKB_RXCB(msdu))->is_last_msdu = true;
 
+	ath12k_dp_rx_h_fetch_info(ab, rx_desc, &rx_info);
+
 	rxs->flag |= RX_FLAG_MMIC_ERROR | RX_FLAG_MMIC_STRIPPED |
 		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
 	skb_pull(msdu, hal_rx_desc_sz);
@@ -3716,7 +3751,7 @@ static void ath12k_dp_rx_null_q_desc_sg_drop(struct ath12k *ar,
 }
 
 static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
-				      struct ieee80211_rx_status *status,
+				      struct ath12k_dp_rx_info *rx_info,
 				      struct sk_buff_head *msdu_list)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -3772,9 +3807,9 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
 		return -EINVAL;
 
-	ath12k_dp_rx_h_ppdu(ar, desc, status);
-
-	ath12k_dp_rx_h_mpdu(ar, msdu, desc, status);
+	ath12k_dp_rx_h_fetch_info(ab, desc, rx_info);
+	ath12k_dp_rx_h_ppdu(ar, desc, rx_info->rx_status);
+	ath12k_dp_rx_h_mpdu(ar, msdu, desc, rx_info->rx_status);
 
 	rxcb->tid = ath12k_dp_rx_h_tid(ab, desc);
 
@@ -3786,7 +3821,7 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 }
 
 static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
-				   struct ieee80211_rx_status *status,
+				   struct ath12k_dp_rx_info *rx_info,
 				   struct sk_buff_head *msdu_list)
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
@@ -3796,7 +3831,7 @@ static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
 
 	switch (rxcb->err_code) {
 	case HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO:
-		if (ath12k_dp_rx_h_null_q_desc(ar, msdu, status, msdu_list))
+		if (ath12k_dp_rx_h_null_q_desc(ar, msdu, rx_info, msdu_list))
 			drop = true;
 		break;
 	case HAL_REO_DEST_RING_ERROR_CODE_PN_CHECK_FAILED:
@@ -3817,7 +3852,7 @@ static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
 }
 
 static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
-					struct ieee80211_rx_status *status)
+					struct ath12k_dp_rx_info *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	u16 msdu_len;
@@ -3837,18 +3872,18 @@ static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
 		return true;
 
-	ath12k_dp_rx_h_ppdu(ar, desc, status);
+	ath12k_dp_rx_h_ppdu(ar, desc, rx_info->rx_status);
 
-	status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
-			 RX_FLAG_DECRYPTED);
+	rx_info->rx_status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
+				     RX_FLAG_DECRYPTED);
 
 	ath12k_dp_rx_h_undecap(ar, msdu, desc,
-			       HAL_ENCRYPT_TYPE_TKIP_MIC, status, false);
+			       HAL_ENCRYPT_TYPE_TKIP_MIC, rx_info->rx_status, false);
 	return false;
 }
 
 static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
-				     struct ieee80211_rx_status *status)
+				     struct ath12k_dp_rx_info *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
@@ -3863,7 +3898,8 @@ static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR:
 		err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, rx_desc);
 		if (err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC) {
-			drop = ath12k_dp_rx_h_tkip_mic_err(ar, msdu, status);
+			ath12k_dp_rx_h_fetch_info(ab, rx_desc, rx_info);
+			drop = ath12k_dp_rx_h_tkip_mic_err(ar, msdu, rx_info);
 			break;
 		}
 		fallthrough;
@@ -3885,14 +3921,18 @@ static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ieee80211_rx_status rxs = {0};
+	struct ath12k_dp_rx_info rx_info;
 	bool drop = true;
 
+	rx_info.addr2_present = false;
+	rx_info.rx_status = &rxs;
+
 	switch (rxcb->err_rel_src) {
 	case HAL_WBM_REL_SRC_MODULE_REO:
-		drop = ath12k_dp_rx_h_reo_err(ar, msdu, &rxs, msdu_list);
+		drop = ath12k_dp_rx_h_reo_err(ar, msdu, &rx_info, msdu_list);
 		break;
 	case HAL_WBM_REL_SRC_MODULE_RXDMA:
-		drop = ath12k_dp_rx_h_rxdma_err(ar, msdu, &rxs);
+		drop = ath12k_dp_rx_h_rxdma_err(ar, msdu, &rx_info);
 		break;
 	default:
 		/* msdu will get freed */
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 88e42365a9d8..0e7cec42a8d1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -65,6 +65,24 @@ struct ath12k_dp_rx_rfc1042_hdr {
 	__be16 snap_type;
 } __packed;
 
+struct ath12k_dp_rx_info {
+	struct ieee80211_rx_status *rx_status;
+	u32 phy_meta_data;
+	u16 peer_id;
+	u8 decap_type;
+	u8 pkt_type;
+	u8 sgi;
+	u8 rate_mcs;
+	u8 bw;
+	u8 nss;
+	u8 addr2[ETH_ALEN];
+	u8 tid;
+	bool ip_csum_fail;
+	bool l4_csum_fail;
+	bool is_mcbc;
+	bool addr2_present;
+};
+
 static inline u32 ath12k_he_gi_to_nl80211_he_gi(u8 sgi)
 {
 	u32 ret = 0;
-- 
2.34.1


