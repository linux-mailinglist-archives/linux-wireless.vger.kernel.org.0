Return-Path: <linux-wireless+bounces-21110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793ADA79517
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 20:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6449816F5A5
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC6026AFB;
	Wed,  2 Apr 2025 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nuUSSc37"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D901CDFAC
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618576; cv=none; b=r6OZX+Kr+fwuRlX0NiDAy3FxdD8vn7hN4gP2QttD9sUU8oFRZEgzMYdQ/aN199ndlyjppaxn6/DHu4uNeyvWS4MEbTCsh8S1VWmzipS78eYHbvnSgwaDsokGPoqCgSzUTDoL8ABg73olWwXjpHZLvh+xzOG0oSo2vdlNPM2AASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618576; c=relaxed/simple;
	bh=JvKBdrRPBPJNLpq5XfWW6ha1pIFKxQ3QqdHMgcvt1Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KqoQ1fdwOJUxYihemLm1TCEykxPh6r4o8SVSSKdASFA0RqLKKGYRQIMAp5Om+5LJak+9Z9ffzRRzpqQ5v74kAU/pAbaHfFpBWi9Ur356t8dH4R9tkxabV7dFPaGumfKtxcsYYdGiMKGNzFwoerr2xLyLtoQZgD5m0j9SZY6uwb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nuUSSc37; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532D2lLW012636
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 18:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=89zaCiJrmkd
	hsLCDqbYzQpiCR18eP3Figf1EHbgLRS4=; b=nuUSSc37k1W9AgOUQHvwFCKKfMX
	pCZzQAjOvUXbgECMUhlqlwWhKTQCPTtYIuvhQIbXcETno4lH9C48RCyKd84TAgzf
	KrXpJFjYUCTiX1axO+WEHsNQdMBtUgxkxFLE6qiI7VyL1iWe+8X6vuGVZAwZi/z0
	YWkkcvObuAOzGjl5EXjvPTpJqePMmF41uyFjNHY+AH+ililH6B9x4ohFj3/uCIF7
	XHo6XH5m8fGvuDfcG8lZfneFZO/PcSk2QcWVSmocRt35ArOIHXwZElV63VSlEjGH
	u1Peworb/ajdpgwPYlT2ASbn1fRClIeqxHuSxFEtFK2fIfqpP8qIpPhL/RQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rxbf29ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 18:29:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-223fd6e9408so12722655ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 11:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743618571; x=1744223371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89zaCiJrmkdhsLCDqbYzQpiCR18eP3Figf1EHbgLRS4=;
        b=FWTSwpwJZ5AyrIn1WmO9odXZQ4dP4uh37rou4kJqfpchYvBLIG92tcVdSo6w+wFAc1
         C9pJcStxF5e54k8i24LHhqDZ/m94sInXFLeQUqPbUO/FGNbdpMxKxM+ES1jfRGxljrSY
         8BpedMdiObgUcGyeO2eiWCTqrBlEmHQXNmNSIVjuJo1bWYWOwW82qGInCSm3oBtrzwz2
         M+uYBH5Bp6kHE5DXJ/s3G/w3WE4EBwmE23U1oG+wSsTanIRRq/6yk9fOyrAWA4cKFTa7
         MhSTHHaQz6DoRZSNMYixqEeh24k0X6yThd1PneAeLcg8jZfZkIetrvGw+Tv+n/rSDfVL
         vZ7A==
X-Gm-Message-State: AOJu0YzeJOsbjjTjra3Wi6HLNFTPZgCKdkP0A/7EObbjmrW8FtAtGUlI
	YPBTZtgZQOveOuHJJkfdMCismEXI5VI4/rp9IUSsc2TUlcsnwAdq42JZ//9SL+NuIv7hO9mries
	9tUjSsgVD7O7ls4OlrhrcneCyMZmqGlac38wFuqSvamyKmRe4u0z9xV+Xd0NShsX3dKTLUfxC8g
	==
X-Gm-Gg: ASbGncvDaZuskI2QUCXC2wWRi0MtY5IfeFZ1yUVxkExWffPAV0Ewx/1APY0BkB1su6I
	LImGqCAyepWLTUOZYlb7QWOiIftrf0kGfXImfCqbNwxILiPWSmnUyoPZNQt7k/N1dTPmbegGsUv
	e76PdnvmQDsN4+6c18gO70j26WEdBwd+v2hijPk0AGe91mEWOUrYgEuauPt6Pp90khn2cNWuyrX
	tEhXJNhTvlXiVu8ECBNlopwQd+SIk1h6vAwOu4NWhZjLXZ5Cp+relkdQL7nTIMF4ETAbtBFZFLN
	z1rKtXE1CRPAoTAgIYzyCqj8nbLjoulVbcXmvJs0dmxojhx7kycW3eUc50qR+CPm3yJ7ZPvnCmr
	2u6HJs0KIRgUoexdCWmvTVly86ASmm/PTcA==
X-Received: by 2002:a17:903:1c4:b0:221:751f:cfbe with SMTP id d9443c01a7336-229766029f8mr5548655ad.19.1743618571329;
        Wed, 02 Apr 2025 11:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1nKYcQoEGVnKcd9AuoNv/7E1ihlL7aN9gABZ6D2VBvhJw9eMux1oZvu74pVvn/FHkLoyEvg==
X-Received: by 2002:a17:903:1c4:b0:221:751f:cfbe with SMTP id d9443c01a7336-229766029f8mr5548455ad.19.1743618570864;
        Wed, 02 Apr 2025 11:29:30 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf860sm111978885ad.115.2025.04.02.11.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:29:30 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 2/2] wifi: ath12k: replace the usage of rx desc with rx_info
Date: Wed,  2 Apr 2025 23:59:17 +0530
Message-Id: <20250402182917.2715596-3-praneesh.p@oss.qualcomm.com>
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
X-Proofpoint-GUID: eUbtO2bCMk_FiarLyRN925UTxnqAdlFA
X-Proofpoint-ORIG-GUID: eUbtO2bCMk_FiarLyRN925UTxnqAdlFA
X-Authority-Analysis: v=2.4 cv=F/5XdrhN c=1 sm=1 tr=0 ts=67ed820d cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=nCWi5yUcUyrMkYL_efIA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020117

In ath12k_dp_rx_h_mpdu(), during the undecap to native wifi mode, the rx
descriptor memory is overwritten. After this function call, any subsequent
accesses to rx descriptor related memory yield invalid values. Fix this by
replacing instances where rx_desc was used with the pre-cached information
in rx_info. This ensures that the values populated from the rx descriptor
are accurate and prevents invalid memory access.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 107 ++++++++++-------------
 drivers/net/wireless/ath/ath12k/dp_rx.h  |   8 +-
 3 files changed, 52 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 6df04920a0c6..210fda4af5d0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2080,6 +2080,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	struct ieee80211_sta *pubsta = NULL;
 	struct ath12k_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
+	struct ath12k_dp_rx_info rx_info;
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol_tkip = rxcb->is_eapol;
 
@@ -2093,7 +2094,8 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	}
 
 	spin_lock_bh(&ar->ab->base_lock);
-	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu);
+	rx_info.addr2_present = false;
+	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu, &rx_info);
 	if (peer && peer->sta) {
 		pubsta = peer->sta;
 		if (pubsta->valid_links) {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 27ac907789e5..be4bb71f2480 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1914,17 +1914,11 @@ static struct sk_buff *ath12k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_
 	return NULL;
 }
 
-static void ath12k_dp_rx_h_csum_offload(struct ath12k *ar, struct sk_buff *msdu)
+static void ath12k_dp_rx_h_csum_offload(struct sk_buff *msdu,
+					struct ath12k_dp_rx_info *rx_info)
 {
-	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	struct ath12k_base *ab = ar->ab;
-	bool ip_csum_fail, l4_csum_fail;
-
-	ip_csum_fail = ath12k_dp_rx_h_ip_cksum_fail(ab, rxcb->rx_desc);
-	l4_csum_fail = ath12k_dp_rx_h_l4_cksum_fail(ab, rxcb->rx_desc);
-
-	msdu->ip_summed = (ip_csum_fail || l4_csum_fail) ?
-			  CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
+	msdu->ip_summed = (rx_info->ip_csum_fail || rx_info->l4_csum_fail) ?
+			   CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
 }
 
 static int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar,
@@ -2229,10 +2223,10 @@ static void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
 }
 
 struct ath12k_peer *
-ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu)
+ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu,
+			 struct ath12k_dp_rx_info *rx_info)
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	struct hal_rx_desc *rx_desc = rxcb->rx_desc;
 	struct ath12k_peer *peer = NULL;
 
 	lockdep_assert_held(&ab->base_lock);
@@ -2243,39 +2237,35 @@ ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu)
 	if (peer)
 		return peer;
 
-	if (!rx_desc || !(ath12k_dp_rxdesc_mac_addr2_valid(ab, rx_desc)))
-		return NULL;
+	if (rx_info->addr2_present)
+		peer = ath12k_peer_find_by_addr(ab, rx_info->addr2);
 
-	peer = ath12k_peer_find_by_addr(ab,
-					ath12k_dp_rxdesc_get_mpdu_start_addr2(ab,
-									      rx_desc));
 	return peer;
 }
 
 static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 				struct sk_buff *msdu,
 				struct hal_rx_desc *rx_desc,
-				struct ieee80211_rx_status *rx_status)
+				struct ath12k_dp_rx_info *rx_info)
 {
-	bool  fill_crypto_hdr;
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_skb_rxcb *rxcb;
 	enum hal_encrypt_type enctype;
 	bool is_decrypted = false;
 	struct ieee80211_hdr *hdr;
 	struct ath12k_peer *peer;
+	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
 	u32 err_bitmap;
 
 	/* PN for multicast packets will be checked in mac80211 */
 	rxcb = ATH12K_SKB_RXCB(msdu);
-	fill_crypto_hdr = ath12k_dp_rx_h_is_da_mcbc(ar->ab, rx_desc);
-	rxcb->is_mcbc = fill_crypto_hdr;
+	rxcb->is_mcbc = rx_info->is_mcbc;
 
 	if (rxcb->is_mcbc)
-		rxcb->peer_id = ath12k_dp_rx_h_peer_id(ar->ab, rx_desc);
+		rxcb->peer_id = rx_info->peer_id;
 
 	spin_lock_bh(&ar->ab->base_lock);
-	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu);
+	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu, rx_info);
 	if (peer) {
 		if (rxcb->is_mcbc)
 			enctype = peer->sec_type_grp;
@@ -2305,7 +2295,7 @@ static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 	if (is_decrypted) {
 		rx_status->flag |= RX_FLAG_DECRYPTED | RX_FLAG_MMIC_STRIPPED;
 
-		if (fill_crypto_hdr)
+		if (rx_info->is_mcbc)
 			rx_status->flag |= RX_FLAG_MIC_STRIPPED |
 					RX_FLAG_ICV_STRIPPED;
 		else
@@ -2313,37 +2303,28 @@ static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 					   RX_FLAG_PN_VALIDATED;
 	}
 
-	ath12k_dp_rx_h_csum_offload(ar, msdu);
+	ath12k_dp_rx_h_csum_offload(msdu, rx_info);
 	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
 			       enctype, rx_status, is_decrypted);
 
-	if (!is_decrypted || fill_crypto_hdr)
+	if (!is_decrypted || rx_info->is_mcbc)
 		return;
 
-	if (ath12k_dp_rx_h_decap_type(ar->ab, rx_desc) !=
-	    DP_RX_DECAP_TYPE_ETHERNET2_DIX) {
+	if (rx_info->decap_type != DP_RX_DECAP_TYPE_ETHERNET2_DIX) {
 		hdr = (void *)msdu->data;
 		hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
 	}
 }
 
-static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc *rx_desc,
-				struct ieee80211_rx_status *rx_status)
+static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_supported_band *sband;
-	enum rx_msdu_start_pkt_type pkt_type;
-	u8 bw;
-	u8 rate_mcs, nss;
-	u8 sgi;
+	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
+	enum rx_msdu_start_pkt_type pkt_type = rx_info->pkt_type;
+	u8 bw = rx_info->bw, sgi = rx_info->sgi;
+	u8 rate_mcs = rx_info->rate_mcs, nss = rx_info->nss;
 	bool is_cck;
 
-	pkt_type = ath12k_dp_rx_h_pkt_type(ab, rx_desc);
-	bw = ath12k_dp_rx_h_rx_bw(ab, rx_desc);
-	rate_mcs = ath12k_dp_rx_h_rate_mcs(ab, rx_desc);
-	nss = ath12k_dp_rx_h_nss(ab, rx_desc);
-	sgi = ath12k_dp_rx_h_sgi(ab, rx_desc);
-
 	switch (pkt_type) {
 	case RX_MSDU_START_PKT_TYPE_11A:
 	case RX_MSDU_START_PKT_TYPE_11B:
@@ -2412,9 +2393,8 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc *rx_desc,
 	}
 }
 
-static void ath12k_dp_rx_h_fetch_info(struct ath12k_base *ab,
-				      struct hal_rx_desc *rx_desc,
-				      struct ath12k_dp_rx_info *rx_info)
+void ath12k_dp_rx_h_fetch_info(struct ath12k_base *ab, struct hal_rx_desc *rx_desc,
+			       struct ath12k_dp_rx_info *rx_info)
 {
 	rx_info->ip_csum_fail = ath12k_dp_rx_h_ip_cksum_fail(ab, rx_desc);
 	rx_info->l4_csum_fail = ath12k_dp_rx_h_l4_cksum_fail(ab, rx_desc);
@@ -2434,12 +2414,14 @@ static void ath12k_dp_rx_h_fetch_info(struct ath12k_base *ab,
 				ath12k_dp_rxdesc_get_mpdu_start_addr2(ab, rx_desc));
 		rx_info->addr2_present = true;
 	}
+
+	ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "rx_desc: ",
+			rx_desc, sizeof(*rx_desc));
 }
 
-void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
-			 struct ieee80211_rx_status *rx_status)
+void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
+	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
 	u8 channel_num;
 	u32 center_freq, meta_data;
 	struct ieee80211_channel *channel;
@@ -2453,7 +2435,7 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
 
 	rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 
-	meta_data = ath12k_dp_rx_h_freq(ab, rx_desc);
+	meta_data = rx_info->phy_meta_data;
 	channel_num = meta_data;
 	center_freq = meta_data >> 16;
 
@@ -2474,20 +2456,18 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
 				ieee80211_frequency_to_channel(channel->center_freq);
 		}
 		spin_unlock_bh(&ar->data_lock);
-		ath12k_dbg_dump(ar->ab, ATH12K_DBG_DATA, NULL, "rx_desc: ",
-				rx_desc, sizeof(*rx_desc));
 	}
 
 	if (rx_status->band != NL80211_BAND_6GHZ)
 		rx_status->freq = ieee80211_channel_to_frequency(channel_num,
 								 rx_status->band);
 
-	ath12k_dp_rx_h_rate(ar, rx_desc, rx_status);
+	ath12k_dp_rx_h_rate(ar, rx_info);
 }
 
 static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
 				      struct sk_buff *msdu,
-				      struct ieee80211_rx_status *status)
+				      struct ath12k_dp_rx_info *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	static const struct ieee80211_radiotap_he known = {
@@ -2500,6 +2480,7 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
 	struct ieee80211_sta *pubsta;
 	struct ath12k_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
+	struct ieee80211_rx_status *status = rx_info->rx_status;
 	u8 decap = DP_RX_DECAP_TYPE_RAW;
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol = rxcb->is_eapol;
@@ -2512,10 +2493,10 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
 	}
 
 	if (!(status->flag & RX_FLAG_ONLY_MONITOR))
-		decap = ath12k_dp_rx_h_decap_type(ab, rxcb->rx_desc);
+		decap = rx_info->decap_type;
 
 	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_rx_h_find_peer(ab, msdu);
+	peer = ath12k_dp_rx_h_find_peer(ab, msdu, rx_info);
 
 	pubsta = peer ? peer->sta : NULL;
 
@@ -2659,8 +2640,8 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 	}
 
 	ath12k_dp_rx_h_fetch_info(ab, rx_desc, rx_info);
-	ath12k_dp_rx_h_ppdu(ar, rx_desc, rx_info->rx_status);
-	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_info->rx_status);
+	ath12k_dp_rx_h_ppdu(ar, rx_info);
+	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_info);
 
 	rx_info->rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
 
@@ -2720,7 +2701,7 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 			continue;
 		}
 
-		ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_status);
+		ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_info);
 	}
 
 	rcu_read_unlock();
@@ -3062,7 +3043,7 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu)))
 		return -EINVAL;
 
-	ath12k_dp_rx_h_ppdu(ar, rx_desc, rxs);
+	ath12k_dp_rx_h_ppdu(ar, &rx_info);
 	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
 			       HAL_ENCRYPT_TYPE_TKIP_MIC, rxs, true);
 	ieee80211_rx(ath12k_ar_to_hw(ar), msdu);
@@ -3808,10 +3789,10 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 		return -EINVAL;
 
 	ath12k_dp_rx_h_fetch_info(ab, desc, rx_info);
-	ath12k_dp_rx_h_ppdu(ar, desc, rx_info->rx_status);
-	ath12k_dp_rx_h_mpdu(ar, msdu, desc, rx_info->rx_status);
+	ath12k_dp_rx_h_ppdu(ar, rx_info);
+	ath12k_dp_rx_h_mpdu(ar, msdu, desc, rx_info);
 
-	rxcb->tid = ath12k_dp_rx_h_tid(ab, desc);
+	rxcb->tid = rx_info->tid;
 
 	/* Please note that caller will having the access to msdu and completing
 	 * rx with mac80211. Need not worry about cleaning up amsdu_list.
@@ -3872,7 +3853,7 @@ static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
 		return true;
 
-	ath12k_dp_rx_h_ppdu(ar, desc, rx_info->rx_status);
+	ath12k_dp_rx_h_ppdu(ar, rx_info);
 
 	rx_info->rx_status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
 				     RX_FLAG_DECRYPTED);
@@ -3944,7 +3925,7 @@ static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
 		return;
 	}
 
-	ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rxs);
+	ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_info);
 }
 
 int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 0e7cec42a8d1..eb4d2b60a035 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -149,13 +149,13 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
 			struct hal_rx_desc *desc);
 struct ath12k_peer *
-ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu);
+ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu,
+			 struct ath12k_dp_rx_info *rx_info);
 u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc);
 u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
 			    struct hal_rx_desc *desc);
-void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
-			 struct ieee80211_rx_status *rx_status);
+void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info);
 int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
 
@@ -163,4 +163,6 @@ int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
 			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
 				       const void *ptr, void *data),
 			   void *data);
+void ath12k_dp_rx_h_fetch_info(struct ath12k_base *ab,  struct hal_rx_desc *rx_desc,
+			       struct ath12k_dp_rx_info *rx_info);
 #endif /* ATH12K_DP_RX_H */
-- 
2.34.1


