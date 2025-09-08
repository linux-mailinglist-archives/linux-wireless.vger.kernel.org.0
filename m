Return-Path: <linux-wireless+bounces-27107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896AB4953C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 18:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205F644023C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63E430E0D4;
	Mon,  8 Sep 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DLD1IRrZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5F30CDB7
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348918; cv=none; b=PLpn4Cw/+qUUgeW2HlU+5D4mKkBvgrkm562ctmBhepe4gG9+SdoETdMiKEdrf9muLpzdD+ryp8esK6kWXwl4yYhpNd2rWQPLZXPhmHjz/J/oKVnvL+0Qi9tyAQ80qqYB3xACVYaWgr9TXj1SiLBz0VptYLl3TSBebqkMsYE7AKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348918; c=relaxed/simple;
	bh=7OkTKclv9Rc5hqPZyTrw8s01nLEMXr+az3hsXWS+UeE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B744kdKQMyHVxwOiOJnc76k/hSkiRmD34tPMMFuZcSSlhNkAxAzV1s1GFhOsquyMiqdZomDOhOIrHr27PERwGZtydysWWhkyE1eu2sgRnmoYKbWctT9hGfP/qiLXETVw5HSOPy7FM1WvD6UrOSDmEx3GneYAvK9TP9O1X3K+ZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DLD1IRrZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58895UDB012162;
	Mon, 8 Sep 2025 16:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n0pUvYDP4Ka8nxRQpvJD7cbe5SjdDvJPuvJ2ut+o5gY=; b=DLD1IRrZfu9UvzW0
	UEcfKFg8fFGhyYShNCi2r39z0K7a7EVvVq6gTI/0nq6B4XCJuc2Ra1vzbHGzU7E0
	a8FvAuzDq/s5bymPiq40aAhiu/xPnANEpMW2aHqDilcfrYlVcndXpwrfGt1fxvzk
	uTlIEawAI5nQLjsgdsFIkL2PdL/hYZi+WTU6pBbbZ8TmFsVTQrMBkGvIADiLirGc
	dcZYKHkfLZLFMxsKMc34vINygsYEAVOQHFh0u3xOxq5u902flADxUTdUZPez4+ls
	CFDaEHDEmKSzqi/lNvFLhEljWL/BkazSS0EBfW/50fpcElqzNOeQxIuK7rPPiVUO
	NXDitQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapdh91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 16:28:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 588GSTA6029062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 16:28:29 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 8 Sep 2025 09:28:28 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 6/8] wifi: ath12k: Add new infra for the rx path
Date: Mon, 8 Sep 2025 21:57:55 +0530
Message-ID: <20250908162757.2938849-7-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908162757.2938849-1-quic_rdeuri@quicinc.com>
References: <20250908162757.2938849-1-quic_rdeuri@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68bf042e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=NqW8gW467OoKBAeMndkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: I4gr9R0UT_kFPgTDYYlObacy0gssBN1g
X-Proofpoint-ORIG-GUID: I4gr9R0UT_kFPgTDYYlObacy0gssBN1g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX7pqFKCywaYl/
 R7AW8USXtldlRPFq94L1xstl3SsE0WumY8YbdI4STAI+YQflH04PNXW0l6vQVaU892o+6ZiixkS
 2CTWPikERz5lQ7WB0AytkT9jOIbZqjIMVtm2RuQYrcpTVV3Twa2nnWBauMDAeOLpbtFAd+I0IHS
 i102rTFcjh89/oJNVJe7wNRXvUZh1TrURTgz3eT/h9+HyrCSA+18rbt0EW/mbIAzfX9U3wKDQhG
 BGqr2rvnPU932tYvbWk/cJpKIyKMc4Mgm3uEVdsmB3I08cMuhYLBwhPnSO4NdXRAdJ1VbhWYGhB
 TsmwkDuPlzO7hOEPJ2LhW7yLztUaHIupjbFYH6Uf8QIkzo0IByfWGeLTSuWkBvYxL062znqTyyV
 I0SsvckQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

The existing usage of rx_ops to reach the hal APIs at multiple place
uses function pointer indirections. In order to avoid multiple function
pointer indirections, add an API to extract the required hal parameters in
the rx path right at the beginning and store them in a structure which
is then leveraged by rest of the rx path.

rx_desc_get_first_msdu
rx_desc_get_last_msdu
rx_desc_encrypt_valid
rx_desc_get_encrypt_type
rx_desc_get_decap_type
rx_desc_get_mesh_ctl
rx_desc_get_mpdu_seq_ctl_vld
rx_desc_get_mpdu_fc_valid
rx_desc_get_mpdu_start_seq_no
rx_desc_get_msdu_len
rx_desc_get_msdu_sgi
rx_desc_get_msdu_rate_mcs
rx_desc_get_msdu_rx_bw
rx_desc_get_msdu_freq
rx_desc_get_msdu_pkt_type
rx_desc_get_msdu_nss
rx_desc_get_mpdu_tid
rx_desc_get_mpdu_peer_id
rx_desc_mac_addr2_valid
rx_desc_mpdu_start_addr2
rx_desc_is_da_mcbc
dp_rx_h_msdu_done
dp_rx_h_l4_cksum_fail
dp_rx_h_ip_cksum_fail
dp_rx_h_is_decrypted
dp_rx_h_mpdu_err

Remove following unused HAL rx ops
rx_desc_get_hdr_status
rx_desc_get_attention

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c        |   2 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c      |   6 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  85 +++-----
 drivers/net/wireless/ath/ath12k/dp_rx.h       | 188 +-----------------
 drivers/net/wireless/ath/ath12k/hal.c         |  56 +-----
 drivers/net/wireless/ath/ath12k/hal.h         |  61 +++---
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 163 +++++++--------
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   8 +
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  64 +++++-
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |  29 +--
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  64 +++++-
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |  29 +--
 12 files changed, 290 insertions(+), 465 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 346687d15982..0956d39c7b95 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -16,6 +15,7 @@
 #include "core.h"
 #include "dp_tx.h"
 #include "dp_rx.h"
+#include "wifi7/dp_rx.h"
 #include "debug.h"
 #include "debugfs.h"
 #include "fw.h"
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index b0a0e2a97e8f..0ae500ec3463 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -6,6 +6,7 @@
 
 #include "dp_mon.h"
 #include "debug.h"
+#include "wifi7/hal_qcn9274.h"
 #include "wifi7/dp_rx.h"
 #include "dp_tx.h"
 #include "peer.h"
@@ -2257,9 +2258,10 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	struct ieee80211_sta *pubsta = NULL;
 	struct ath12k_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	struct ath12k_dp_rx_info rx_info;
+	struct hal_rx_desc_data rx_info;
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol_tkip = rxcb->is_eapol;
+	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
 
 	status->link_valid = 0;
 
@@ -2270,6 +2272,8 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 		status->flag |= RX_FLAG_RADIOTAP_HE;
 	}
 
+	ath12k_wifi7_dp_extract_rx_desc_data(ar->ab, &rx_info, rx_desc, rx_desc);
+
 	spin_lock_bh(&ar->ab->base_lock);
 	rx_info.addr2_present = false;
 	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu, &rx_info);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index e1a2f5f54adb..4197c6d4d562 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -819,9 +819,8 @@ static int ath12k_dp_rx_crypto_icv_len(struct ath12k *ar,
 static void ath12k_dp_rx_h_undecap_nwifi(struct ath12k *ar,
 					 struct sk_buff *msdu,
 					 enum hal_encrypt_type enctype,
-					 struct ieee80211_rx_status *status)
+					 struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	u8 decap_hdr[DP_MAX_NWIFI_HDR_LEN];
 	struct ieee80211_hdr *hdr;
@@ -842,7 +841,7 @@ static void ath12k_dp_rx_h_undecap_nwifi(struct ath12k *ar,
 
 	qos_ctl = rxcb->tid;
 
-	if (ath12k_dp_rx_h_mesh_ctl_present(ab, rxcb->rx_desc))
+	if (rx_info->mesh_ctrl_present)
 		qos_ctl |= IEEE80211_QOS_CTL_MESH_CONTROL_PRESENT;
 
 	/* TODO: Add other QoS ctl fields when required */
@@ -851,7 +850,7 @@ static void ath12k_dp_rx_h_undecap_nwifi(struct ath12k *ar,
 	memcpy(decap_hdr, hdr, hdr_len);
 
 	/* Rebuild crypto header for mac80211 use */
-	if (!(status->flag & RX_FLAG_IV_STRIPPED)) {
+	if (!(rx_info->rx_status->flag & RX_FLAG_IV_STRIPPED)) {
 		crypto_hdr = skb_push(msdu, ath12k_dp_rx_crypto_param_len(ar, enctype));
 		ath12k_dp_rx_desc_get_crypto_header(ar->ab,
 						    rxcb->rx_desc, crypto_hdr,
@@ -925,21 +924,20 @@ static void ath12k_dp_rx_h_undecap_raw(struct ath12k *ar, struct sk_buff *msdu,
 static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
 					      struct sk_buff *msdu,
 					      struct ath12k_skb_rxcb *rxcb,
-					      struct ieee80211_rx_status *status,
-					      enum hal_encrypt_type enctype)
+					      enum hal_encrypt_type enctype,
+					      struct hal_rx_desc_data *rx_info)
 {
 	struct hal_rx_desc *rx_desc = rxcb->rx_desc;
 	struct ath12k_base *ab = ar->ab;
 	size_t hdr_len, crypto_len;
 	struct ieee80211_hdr hdr;
 	__le16 qos_ctl;
-	u8 *crypto_hdr, mesh_ctrl;
+	u8 *crypto_hdr;
 
 	ath12k_dp_rx_desc_get_dot11_hdr(ab, rx_desc, &hdr);
 	hdr_len = ieee80211_hdrlen(hdr.frame_control);
-	mesh_ctrl = ath12k_dp_rx_h_mesh_ctl_present(ab, rx_desc);
 
-	if (!(status->flag & RX_FLAG_IV_STRIPPED)) {
+	if (!(rx_info->rx_status->flag & RX_FLAG_IV_STRIPPED)) {
 		crypto_len = ath12k_dp_rx_crypto_param_len(ar, enctype);
 		crypto_hdr = skb_push(msdu, crypto_len);
 		ath12k_dp_rx_desc_get_crypto_header(ab, rx_desc, crypto_hdr, enctype);
@@ -949,14 +947,14 @@ static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
 	memcpy(msdu->data, &hdr, min(hdr_len, sizeof(hdr)));
 
 	if (rxcb->is_mcbc)
-		status->flag &= ~RX_FLAG_PN_VALIDATED;
+		rx_info->rx_status->flag &= ~RX_FLAG_PN_VALIDATED;
 
 	/* Add QOS header */
 	if (ieee80211_is_data_qos(hdr.frame_control)) {
 		struct ieee80211_hdr *qos_ptr = (struct ieee80211_hdr *)msdu->data;
 
 		qos_ctl = cpu_to_le16(rxcb->tid & IEEE80211_QOS_CTL_TID_MASK);
-		if (mesh_ctrl)
+		if (rx_info->mesh_ctrl_present)
 			qos_ctl |= cpu_to_le16(IEEE80211_QOS_CTL_MESH_CONTROL_PRESENT);
 
 		memcpy(ieee80211_get_qos_ctl(qos_ptr), &qos_ctl, IEEE80211_QOS_CTL_LEN);
@@ -966,7 +964,7 @@ static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
 static void ath12k_dp_rx_h_undecap_eth(struct ath12k *ar,
 				       struct sk_buff *msdu,
 				       enum hal_encrypt_type enctype,
-				       struct ieee80211_rx_status *status)
+				       struct hal_rx_desc_data *rx_info)
 {
 	struct ieee80211_hdr *hdr;
 	struct ethhdr *eth;
@@ -982,7 +980,7 @@ static void ath12k_dp_rx_h_undecap_eth(struct ath12k *ar,
 	skb_pull(msdu, sizeof(*eth));
 	memcpy(skb_push(msdu, sizeof(rfc)), &rfc,
 	       sizeof(rfc));
-	ath12k_get_dot11_hdr_from_rx_desc(ar, msdu, rxcb, status, enctype);
+	ath12k_get_dot11_hdr_from_rx_desc(ar, msdu, rxcb, enctype, rx_info);
 
 	/* original 802.11 header has a different DA and in
 	 * case of 4addr it may also have different SA
@@ -995,21 +993,17 @@ static void ath12k_dp_rx_h_undecap_eth(struct ath12k *ar,
 void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
 			    struct hal_rx_desc *rx_desc,
 			    enum hal_encrypt_type enctype,
-			    struct ieee80211_rx_status *status,
-			    bool decrypted)
+			    bool decrypted,
+			    struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
-	u8 decap;
 	struct ethhdr *ehdr;
 
-	decap = ath12k_dp_rx_h_decap_type(ab, rx_desc);
-
-	switch (decap) {
+	switch (rx_info->decap_type) {
 	case DP_RX_DECAP_TYPE_NATIVE_WIFI:
-		ath12k_dp_rx_h_undecap_nwifi(ar, msdu, enctype, status);
+		ath12k_dp_rx_h_undecap_nwifi(ar, msdu, enctype, rx_info);
 		break;
 	case DP_RX_DECAP_TYPE_RAW:
-		ath12k_dp_rx_h_undecap_raw(ar, msdu, enctype, status,
+		ath12k_dp_rx_h_undecap_raw(ar, msdu, enctype, rx_info->rx_status,
 					   decrypted);
 		break;
 	case DP_RX_DECAP_TYPE_ETHERNET2_DIX:
@@ -1018,7 +1012,7 @@ void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
 		/* mac80211 allows fast path only for authorized STA */
 		if (ehdr->h_proto == cpu_to_be16(ETH_P_PAE)) {
 			ATH12K_SKB_RXCB(msdu)->is_eapol = true;
-			ath12k_dp_rx_h_undecap_eth(ar, msdu, enctype, status);
+			ath12k_dp_rx_h_undecap_eth(ar, msdu, enctype, rx_info);
 			break;
 		}
 
@@ -1026,7 +1020,7 @@ void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
 		 * remove eth header and add 802.11 header.
 		 */
 		if (ATH12K_SKB_RXCB(msdu)->is_mcbc && decrypted)
-			ath12k_dp_rx_h_undecap_eth(ar, msdu, enctype, status);
+			ath12k_dp_rx_h_undecap_eth(ar, msdu, enctype, rx_info);
 		break;
 	case DP_RX_DECAP_TYPE_8023:
 		/* TODO: Handle undecap for these formats */
@@ -1036,7 +1030,7 @@ void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
 
 struct ath12k_peer *
 ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu,
-			 struct ath12k_dp_rx_info *rx_info)
+			 struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ath12k_peer *peer = NULL;
@@ -1055,7 +1049,7 @@ ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu,
 	return peer;
 }
 
-static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info)
+static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc_data *rx_info)
 {
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
@@ -1132,33 +1126,7 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct ath12k_dp_rx_info *rx_
 	}
 }
 
-void ath12k_dp_rx_h_fetch_info(struct ath12k_base *ab, struct hal_rx_desc *rx_desc,
-			       struct ath12k_dp_rx_info *rx_info)
-{
-	rx_info->ip_csum_fail = ath12k_dp_rx_h_ip_cksum_fail(ab, rx_desc);
-	rx_info->l4_csum_fail = ath12k_dp_rx_h_l4_cksum_fail(ab, rx_desc);
-	rx_info->is_mcbc = ath12k_dp_rx_h_is_da_mcbc(ab, rx_desc);
-	rx_info->decap_type = ath12k_dp_rx_h_decap_type(ab, rx_desc);
-	rx_info->pkt_type = ath12k_dp_rx_h_pkt_type(ab, rx_desc);
-	rx_info->sgi = ath12k_dp_rx_h_sgi(ab, rx_desc);
-	rx_info->rate_mcs = ath12k_dp_rx_h_rate_mcs(ab, rx_desc);
-	rx_info->bw = ath12k_dp_rx_h_rx_bw(ab, rx_desc);
-	rx_info->nss = ath12k_dp_rx_h_nss(ab, rx_desc);
-	rx_info->tid = ath12k_dp_rx_h_tid(ab, rx_desc);
-	rx_info->peer_id = ath12k_dp_rx_h_peer_id(ab, rx_desc);
-	rx_info->phy_meta_data = ath12k_dp_rx_h_freq(ab, rx_desc);
-
-	if (ath12k_dp_rxdesc_mac_addr2_valid(ab, rx_desc)) {
-		ether_addr_copy(rx_info->addr2,
-				ath12k_dp_rxdesc_get_mpdu_start_addr2(ab, rx_desc));
-		rx_info->addr2_present = true;
-	}
-
-	ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "rx_desc: ",
-			rx_desc, sizeof(*rx_desc));
-}
-
-void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info)
+void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc_data *rx_info)
 {
 	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
 	u8 channel_num;
@@ -1206,7 +1174,7 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info)
 
 void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
 			       struct sk_buff *msdu,
-			       struct ath12k_dp_rx_info *rx_info)
+			       struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_rx_status *rx_status;
@@ -1237,7 +1205,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
 		   peer ? peer->addr : NULL,
 		   rxcb->tid,
 		   is_mcbc ? "mcast" : "ucast",
-		   ath12k_dp_rx_h_seq_no(ab, rxcb->rx_desc),
+		   rx_info->seq_no,
 		   (status->encoding == RX_ENC_LEGACY) ? "legacy" : "",
 		   (status->encoding == RX_ENC_HT) ? "ht" : "",
 		   (status->encoding == RX_ENC_VHT) ? "vht" : "",
@@ -1278,14 +1246,13 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
 
 bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
 					    struct hal_rx_desc *rx_desc,
-					    struct sk_buff *msdu)
+					    struct sk_buff *msdu,
+					    struct hal_rx_desc_data *rx_info)
 {
 	struct ieee80211_hdr *hdr;
-	u8 decap_type;
 	u32 hdr_len;
 
-	decap_type = ath12k_dp_rx_h_decap_type(ab, rx_desc);
-	if (decap_type != DP_RX_DECAP_TYPE_NATIVE_WIFI)
+	if (rx_info->decap_type != DP_RX_DECAP_TYPE_NATIVE_WIFI)
 		return true;
 
 	hdr = (struct ieee80211_hdr *)msdu->data;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 150f4b1dbfbb..432707d60fca 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -66,24 +66,6 @@ struct ath12k_dp_rx_rfc1042_hdr {
 	__be16 snap_type;
 } __packed;
 
-struct ath12k_dp_rx_info {
-	struct ieee80211_rx_status *rx_status;
-	u32 phy_meta_data;
-	u16 peer_id;
-	u8 decap_type;
-	u8 pkt_type;
-	u8 sgi;
-	u8 rate_mcs;
-	u8 bw;
-	u8 nss;
-	u8 addr2[ETH_ALEN];
-	u8 tid;
-	bool ip_csum_fail;
-	bool l4_csum_fail;
-	bool is_mcbc;
-	bool addr2_present;
-};
-
 static inline u32 ath12k_he_gi_to_nl80211_he_gi(u8 sgi)
 {
 	u32 ret = 0;
@@ -106,39 +88,6 @@ static inline u32 ath12k_he_gi_to_nl80211_he_gi(u8 sgi)
 	return ret;
 }
 
-static inline enum hal_encrypt_type ath12k_dp_rx_h_enctype(struct ath12k_base *ab,
-							   struct hal_rx_desc *desc)
-{
-	if (!ab->hal_rx_ops->rx_desc_encrypt_valid(desc))
-		return HAL_ENCRYPT_TYPE_OPEN;
-
-	return ab->hal_rx_ops->rx_desc_get_encrypt_type(desc);
-}
-
-static inline u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
-					   struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_decap_type(desc);
-}
-
-static inline u8 ath12k_dp_rx_h_mesh_ctl_present(struct ath12k_base *ab,
-						 struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_mesh_ctl(desc);
-}
-
-static inline bool ath12k_dp_rx_h_seq_ctrl_valid(struct ath12k_base *ab,
-						 struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_mpdu_seq_ctl_vld(desc);
-}
-
-static inline bool ath12k_dp_rx_h_fc_valid(struct ath12k_base *ab,
-					   struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_mpdu_fc_valid(desc);
-}
-
 static inline bool ath12k_dp_rx_h_more_frags(struct ath12k_base *ab,
 					     struct sk_buff *skb)
 {
@@ -157,114 +106,12 @@ static inline u16 ath12k_dp_rx_h_frag_no(struct ath12k_base *ab,
 	return le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;
 }
 
-static inline u16 ath12k_dp_rx_h_seq_no(struct ath12k_base *ab,
-					struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_mpdu_start_seq_no(desc);
-}
-
-static inline bool ath12k_dp_rx_h_msdu_done(struct ath12k_base *ab,
-					    struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->dp_rx_h_msdu_done(desc);
-}
-
-static inline bool ath12k_dp_rx_h_l4_cksum_fail(struct ath12k_base *ab,
-						struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->dp_rx_h_l4_cksum_fail(desc);
-}
-
-static inline bool ath12k_dp_rx_h_ip_cksum_fail(struct ath12k_base *ab,
-						struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->dp_rx_h_ip_cksum_fail(desc);
-}
-
-static inline bool ath12k_dp_rx_h_is_decrypted(struct ath12k_base *ab,
-					       struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->dp_rx_h_is_decrypted(desc);
-}
-
-static inline u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
-					  struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->dp_rx_h_mpdu_err(desc);
-}
-
-static inline u16 ath12k_dp_rx_h_msdu_len(struct ath12k_base *ab,
-					  struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_msdu_len(desc);
-}
-
-static inline u8 ath12k_dp_rx_h_sgi(struct ath12k_base *ab,
-				    struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_msdu_sgi(desc);
-}
-
-static inline u8 ath12k_dp_rx_h_rate_mcs(struct ath12k_base *ab,
-					 struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_msdu_rate_mcs(desc);
-}
-
-static inline u8 ath12k_dp_rx_h_rx_bw(struct ath12k_base *ab,
-				      struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_msdu_rx_bw(desc);
-}
-
-static inline u32 ath12k_dp_rx_h_freq(struct ath12k_base *ab,
-				      struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_msdu_freq(desc);
-}
-
-static inline u8 ath12k_dp_rx_h_pkt_type(struct ath12k_base *ab,
-					 struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_msdu_pkt_type(desc);
-}
-
-static inline u8 ath12k_dp_rx_h_nss(struct ath12k_base *ab,
-				    struct hal_rx_desc *desc)
-{
-	return hweight8(ab->hal_rx_ops->rx_desc_get_msdu_nss(desc));
-}
-
-static inline u8 ath12k_dp_rx_h_tid(struct ath12k_base *ab,
-				    struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_mpdu_tid(desc);
-}
-
-static inline u16 ath12k_dp_rx_h_peer_id(struct ath12k_base *ab,
-					 struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_mpdu_peer_id(desc);
-}
-
 static inline u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
 				      struct hal_rx_desc *desc)
 {
 	return ab->hal_rx_ops->rx_desc_get_l3_pad_bytes(desc);
 }
 
-static inline bool ath12k_dp_rx_h_first_msdu(struct ath12k_base *ab,
-					     struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_first_msdu(desc);
-}
-
-static inline bool ath12k_dp_rx_h_last_msdu(struct ath12k_base *ab,
-					    struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_last_msdu(desc);
-}
-
 static inline void ath12k_dp_rx_desc_end_tlv_copy(struct ath12k_base *ab,
 						  struct hal_rx_desc *fdesc,
 						  struct hal_rx_desc *ldesc)
@@ -295,25 +142,6 @@ static inline bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 	return tlv_tag == HAL_RX_MPDU_START;
 }
 
-static inline bool ath12k_dp_rx_h_is_da_mcbc(struct ath12k_base *ab,
-					     struct hal_rx_desc *desc)
-{
-	return (ath12k_dp_rx_h_first_msdu(ab, desc) &&
-		ab->hal_rx_ops->rx_desc_is_da_mcbc(desc));
-}
-
-static inline bool ath12k_dp_rxdesc_mac_addr2_valid(struct ath12k_base *ab,
-						    struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_mac_addr2_valid(desc);
-}
-
-static inline u8 *ath12k_dp_rxdesc_get_mpdu_start_addr2(struct ath12k_base *ab,
-							struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_mpdu_start_addr2(desc);
-}
-
 static inline void ath12k_dp_rx_desc_get_dot11_hdr(struct ath12k_base *ab,
 						   struct hal_rx_desc *desc,
 						   struct ieee80211_hdr *hdr)
@@ -346,14 +174,15 @@ static inline void ath12k_dp_clean_up_skb_list(struct sk_buff_head *skb_list)
 void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
 			    struct hal_rx_desc *rx_desc,
 			    enum hal_encrypt_type enctype,
-			    struct ieee80211_rx_status *status,
-			    bool decrypted);
+			    bool decrypted,
+			    struct hal_rx_desc_data *rx_info);
 void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
 			       struct sk_buff *msdu,
-			       struct ath12k_dp_rx_info *rx_info);
+			       struct hal_rx_desc_data *rx_info);
 bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
 					    struct hal_rx_desc *rx_desc,
-					    struct sk_buff *msdu);
+					    struct sk_buff *msdu,
+					    struct hal_rx_desc_data *rx_info);
 u64 ath12k_dp_rx_h_get_pn(struct ath12k *ar, struct sk_buff *skb);
 void ath12k_dp_rx_h_sort_frags(struct ath12k_base *ab,
 			       struct sk_buff_head *frag_list,
@@ -403,14 +232,11 @@ u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
 			struct hal_rx_desc *desc);
 struct ath12k_peer *
 ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu,
-			 struct ath12k_dp_rx_info *rx_info);
+			 struct hal_rx_desc_data *rx_info);
 u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc);
 u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
 			    struct hal_rx_desc *desc);
-void ath12k_dp_rx_h_fetch_info(struct ath12k_base *ab,  struct hal_rx_desc *rx_desc,
-			       struct ath12k_dp_rx_info *rx_info);
-
 int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar, enum hal_encrypt_type enctype);
 u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
 				struct hal_rx_desc *rx_desc);
@@ -418,7 +244,7 @@ bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 				 struct hal_rx_desc *rx_desc);
 bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 				 struct hal_rx_desc *rx_desc);
-void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info);
+void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc_data *rx_info);
 struct sk_buff *ath12k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_list,
 					       struct sk_buff *first);
 void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 60a4e5766f51..db6294ba6771 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -407,37 +407,9 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 }
 
 const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
-	.rx_desc_get_first_msdu = ath12k_hal_rx_desc_get_first_msdu_qcn9274,
-	.rx_desc_get_last_msdu = ath12k_hal_rx_desc_get_last_msdu_qcn9274,
 	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274,
-	.rx_desc_encrypt_valid = ath12k_hal_rx_desc_encrypt_valid_qcn9274,
-	.rx_desc_get_encrypt_type = ath12k_hal_rx_desc_get_encrypt_type_qcn9274,
-	.rx_desc_get_decap_type = ath12k_hal_rx_desc_get_decap_type_qcn9274,
-	.rx_desc_get_mesh_ctl = ath12k_hal_rx_desc_get_mesh_ctl_qcn9274,
-	.rx_desc_get_mpdu_seq_ctl_vld =
-		ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_qcn9274,
-	.rx_desc_get_mpdu_fc_valid = ath12k_hal_rx_desc_get_mpdu_fc_valid_qcn9274,
-	.rx_desc_get_mpdu_start_seq_no =
-		ath12k_hal_rx_desc_get_mpdu_start_seq_no_qcn9274,
-	.rx_desc_get_msdu_len = ath12k_hal_rx_desc_get_msdu_len_qcn9274,
-	.rx_desc_get_msdu_sgi = ath12k_hal_rx_desc_get_msdu_sgi_qcn9274,
-	.rx_desc_get_msdu_rate_mcs = ath12k_hal_rx_desc_get_msdu_rate_mcs_qcn9274,
-	.rx_desc_get_msdu_rx_bw = ath12k_hal_rx_desc_get_msdu_rx_bw_qcn9274,
-	.rx_desc_get_msdu_freq = ath12k_hal_rx_desc_get_msdu_freq_qcn9274,
-	.rx_desc_get_msdu_pkt_type = ath12k_hal_rx_desc_get_msdu_pkt_type_qcn9274,
-	.rx_desc_get_msdu_nss = ath12k_hal_rx_desc_get_msdu_nss_qcn9274,
-	.rx_desc_get_mpdu_tid = ath12k_hal_rx_desc_get_mpdu_tid_qcn9274,
-	.rx_desc_get_mpdu_peer_id = ath12k_hal_rx_desc_get_mpdu_peer_id_qcn9274,
 	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
 	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
-	.rx_desc_mac_addr2_valid = ath12k_hal_rx_desc_mac_addr2_valid_qcn9274,
-	.rx_desc_mpdu_start_addr2 = ath12k_hal_rx_desc_mpdu_start_addr2_qcn9274,
-	.rx_desc_is_da_mcbc = ath12k_hal_rx_desc_is_da_mcbc_qcn9274,
-	.dp_rx_h_msdu_done = ath12k_hal_rx_h_msdu_done_qcn9274,
-	.dp_rx_h_l4_cksum_fail = ath12k_hal_rx_h_l4_cksum_fail_qcn9274,
-	.dp_rx_h_ip_cksum_fail = ath12k_hal_rx_h_ip_cksum_fail_qcn9274,
-	.dp_rx_h_is_decrypted = ath12k_hal_rx_h_is_decrypted_qcn9274,
-	.dp_rx_h_mpdu_err = ath12k_hal_rx_h_mpdu_err_qcn9274,
 };
 EXPORT_SYMBOL(hal_rx_qcn9274_compact_ops);
 
@@ -449,6 +421,7 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_qcn9274,
 	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_qcn9274,
 	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_qcn9274,
+	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_qcn9274,
 	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_qcn9274,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
@@ -578,36 +551,10 @@ static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 }
 
 const struct hal_rx_ops hal_rx_wcn7850_ops = {
-	.rx_desc_get_first_msdu = ath12k_hal_rx_desc_get_first_msdu_wcn7850,
-	.rx_desc_get_last_msdu = ath12k_hal_rx_desc_get_last_msdu_wcn7850,
 	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850,
-	.rx_desc_encrypt_valid = ath12k_hal_rx_desc_encrypt_valid_wcn7850,
-	.rx_desc_get_encrypt_type = ath12k_hal_rx_desc_get_encrypt_type_wcn7850,
-	.rx_desc_get_decap_type = ath12k_hal_rx_desc_get_decap_type_wcn7850,
-	.rx_desc_get_mesh_ctl = ath12k_hal_rx_desc_get_mesh_ctl_wcn7850,
-	.rx_desc_get_mpdu_seq_ctl_vld = ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_wcn7850,
-	.rx_desc_get_mpdu_fc_valid = ath12k_hal_rx_desc_get_mpdu_fc_valid_wcn7850,
-	.rx_desc_get_mpdu_start_seq_no = ath12k_hal_rx_desc_get_mpdu_start_seq_no_wcn7850,
-	.rx_desc_get_msdu_len = ath12k_hal_rx_desc_get_msdu_len_wcn7850,
-	.rx_desc_get_msdu_sgi = ath12k_hal_rx_desc_get_msdu_sgi_wcn7850,
-	.rx_desc_get_msdu_rate_mcs = ath12k_hal_rx_desc_get_msdu_rate_mcs_wcn7850,
-	.rx_desc_get_msdu_rx_bw = ath12k_hal_rx_desc_get_msdu_rx_bw_wcn7850,
-	.rx_desc_get_msdu_freq = ath12k_hal_rx_desc_get_msdu_freq_wcn7850,
-	.rx_desc_get_msdu_pkt_type = ath12k_hal_rx_desc_get_msdu_pkt_type_wcn7850,
-	.rx_desc_get_msdu_nss = ath12k_hal_rx_desc_get_msdu_nss_wcn7850,
-	.rx_desc_get_mpdu_tid = ath12k_hal_rx_desc_get_mpdu_tid_wcn7850,
-	.rx_desc_get_mpdu_peer_id = ath12k_hal_rx_desc_get_mpdu_peer_id_wcn7850,
 	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
 	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
 	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
-	.rx_desc_mac_addr2_valid = ath12k_hal_rx_desc_mac_addr2_valid_wcn7850,
-	.rx_desc_mpdu_start_addr2 = ath12k_hal_rx_desc_mpdu_start_addr2_wcn7850,
-	.rx_desc_is_da_mcbc = ath12k_hal_rx_desc_is_da_mcbc_wcn7850,
-	.dp_rx_h_msdu_done = ath12k_hal_rx_h_msdu_done_wcn7850,
-	.dp_rx_h_l4_cksum_fail = ath12k_hal_rx_h_l4_cksum_fail_wcn7850,
-	.dp_rx_h_ip_cksum_fail = ath12k_hal_rx_h_ip_cksum_fail_wcn7850,
-	.dp_rx_h_is_decrypted = ath12k_hal_rx_h_is_decrypted_wcn7850,
-	.dp_rx_h_mpdu_err = ath12k_hal_rx_h_mpdu_err_wcn7850,
 };
 EXPORT_SYMBOL(hal_rx_wcn7850_ops);
 
@@ -619,6 +566,7 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_wcn7850,
 	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_wcn7850,
 	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_wcn7850,
+	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_wcn7850,
 	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_wcn7850,
 };
 EXPORT_SYMBOL(hal_wcn7850_ops);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 553d93dcc268..37593bb7953b 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1022,6 +1022,36 @@ struct hal_rx_mon_ppdu_info {
 	struct hal_rx_tlv_aggr_info tlv_aggr;
 };
 
+struct hal_rx_desc_data {
+	struct ieee80211_rx_status *rx_status;
+	u32 phy_meta_data;
+	u32 err_bitmap;
+	u32 enctype;
+	u32 msdu_done:1,
+	    is_decrypted:1,
+	    ip_csum_fail:1,
+	    l4_csum_fail:1,
+	    is_first_msdu:1,
+	    is_last_msdu:1,
+	    mesh_ctrl_present:1,
+	    addr2_present:1,
+	    is_mcbc:1,
+	    seq_ctl_valid:1,
+	    fc_valid:1;
+	u16 msdu_len;
+	u16 peer_id;
+	u16 seq_no;
+	u8 *addr2;
+	u8 pkt_type;
+	u8 l3_pad_bytes;
+	u8 decap_type;
+	u8 bw;
+	u8 rate_mcs;
+	u8 nss;
+	u8 sgi;
+	u8 tid;
+};
+
 /* srng flags */
 #define HAL_SRNG_FLAGS_MSI_SWAP			0x00000008
 #define HAL_SRNG_FLAGS_RING_PTR_SWAP		0x00000010
@@ -1549,38 +1579,10 @@ enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
 }
 
 struct hal_rx_ops {
-	bool (*rx_desc_get_first_msdu)(struct hal_rx_desc *desc);
-	bool (*rx_desc_get_last_msdu)(struct hal_rx_desc *desc);
 	u8 (*rx_desc_get_l3_pad_bytes)(struct hal_rx_desc *desc);
-	u8 *(*rx_desc_get_hdr_status)(struct hal_rx_desc *desc);
-	bool (*rx_desc_encrypt_valid)(struct hal_rx_desc *desc);
-	u32 (*rx_desc_get_encrypt_type)(struct hal_rx_desc *desc);
-	u8 (*rx_desc_get_decap_type)(struct hal_rx_desc *desc);
-	u8 (*rx_desc_get_mesh_ctl)(struct hal_rx_desc *desc);
-	bool (*rx_desc_get_mpdu_seq_ctl_vld)(struct hal_rx_desc *desc);
-	bool (*rx_desc_get_mpdu_fc_valid)(struct hal_rx_desc *desc);
-	u16 (*rx_desc_get_mpdu_start_seq_no)(struct hal_rx_desc *desc);
-	u16 (*rx_desc_get_msdu_len)(struct hal_rx_desc *desc);
-	u8 (*rx_desc_get_msdu_sgi)(struct hal_rx_desc *desc);
-	u8 (*rx_desc_get_msdu_rate_mcs)(struct hal_rx_desc *desc);
-	u8 (*rx_desc_get_msdu_rx_bw)(struct hal_rx_desc *desc);
-	u32 (*rx_desc_get_msdu_freq)(struct hal_rx_desc *desc);
-	u8 (*rx_desc_get_msdu_pkt_type)(struct hal_rx_desc *desc);
-	u8 (*rx_desc_get_msdu_nss)(struct hal_rx_desc *desc);
-	u8 (*rx_desc_get_mpdu_tid)(struct hal_rx_desc *desc);
-	u16 (*rx_desc_get_mpdu_peer_id)(struct hal_rx_desc *desc);
 	u32 (*rx_desc_get_mpdu_start_tag)(struct hal_rx_desc *desc);
 	u32 (*rx_desc_get_mpdu_ppdu_id)(struct hal_rx_desc *desc);
-	struct rx_attention *(*rx_desc_get_attention)(struct hal_rx_desc *desc);
 	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
-	bool (*rx_desc_mac_addr2_valid)(struct hal_rx_desc *desc);
-	u8* (*rx_desc_mpdu_start_addr2)(struct hal_rx_desc *desc);
-	bool (*rx_desc_is_da_mcbc)(struct hal_rx_desc *desc);
-	bool (*dp_rx_h_msdu_done)(struct hal_rx_desc *desc);
-	bool (*dp_rx_h_l4_cksum_fail)(struct hal_rx_desc *desc);
-	bool (*dp_rx_h_ip_cksum_fail)(struct hal_rx_desc *desc);
-	bool (*dp_rx_h_is_decrypted)(struct hal_rx_desc *desc);
-	u32 (*dp_rx_h_mpdu_err)(struct hal_rx_desc *desc);
 };
 
 struct hal_ops {
@@ -1595,6 +1597,9 @@ struct hal_ops {
 	void (*rx_desc_copy_end_tlv)(struct hal_rx_desc *fdesc,
 				     struct hal_rx_desc *ldesc);
 	u8 (*rx_desc_get_msdu_src_link_id)(struct hal_rx_desc *desc);
+	void (*extract_rx_desc_data)(struct hal_rx_desc_data *rx_desc_data,
+				     struct hal_rx_desc *rx_desc,
+				     struct hal_rx_desc *ldesc);
 	u32 (*rx_desc_get_desc_size)(void);
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 99ff56038452..f19c5612bb7c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -301,7 +301,7 @@ int ath12k_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ahsta,
 }
 
 static void ath12k_dp_rx_h_csum_offload(struct sk_buff *msdu,
-					struct ath12k_dp_rx_info *rx_info)
+					struct hal_rx_desc_data *rx_info)
 {
 	msdu->ip_summed = (rx_info->ip_csum_fail || rx_info->l4_csum_fail) ?
 			   CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
@@ -310,16 +310,15 @@ static void ath12k_dp_rx_h_csum_offload(struct sk_buff *msdu,
 static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 				struct sk_buff *msdu,
 				struct hal_rx_desc *rx_desc,
-				struct ath12k_dp_rx_info *rx_info)
+				struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
 	struct ath12k_skb_rxcb *rxcb;
 	enum hal_encrypt_type enctype;
 	bool is_decrypted = false;
 	struct ieee80211_hdr *hdr;
 	struct ath12k_peer *peer;
 	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
-	u32 err_bitmap;
+	u32 err_bitmap = rx_info->err_bitmap;
 
 	/* PN for multicast packets will be checked in mac80211 */
 	rxcb = ATH12K_SKB_RXCB(msdu);
@@ -345,9 +344,8 @@ static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 	}
 	spin_unlock_bh(&ar->ab->base_lock);
 
-	err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, rx_desc);
 	if (enctype != HAL_ENCRYPT_TYPE_OPEN && !err_bitmap)
-		is_decrypted = ath12k_dp_rx_h_is_decrypted(ab, rx_desc);
+		is_decrypted = rx_info->is_decrypted;
 
 	/* Clear per-MPDU flags while leaving per-PPDU flags intact */
 	rx_status->flag &= ~(RX_FLAG_FAILED_FCS_CRC |
@@ -374,7 +372,7 @@ static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 
 	ath12k_dp_rx_h_csum_offload(msdu, rx_info);
 	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
-			       enctype, rx_status, is_decrypted);
+			       enctype, is_decrypted, rx_info);
 
 	if (!is_decrypted || rx_info->is_mcbc)
 		return;
@@ -388,7 +386,8 @@ static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
 				      struct sk_buff_head *msdu_list,
 				      struct sk_buff *first, struct sk_buff *last,
-				      u8 l3pad_bytes, int msdu_len)
+				      u8 l3pad_bytes, int msdu_len,
+				      struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct sk_buff *skb;
@@ -413,8 +412,8 @@ static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
 	}
 
 	ldesc = (struct hal_rx_desc *)last->data;
-	rxcb->is_first_msdu = ath12k_dp_rx_h_first_msdu(ab, ldesc);
-	rxcb->is_last_msdu = ath12k_dp_rx_h_last_msdu(ab, ldesc);
+	rxcb->is_first_msdu = rx_info->is_first_msdu;
+	rxcb->is_last_msdu = rx_info->is_last_msdu;
 
 	/* MSDU spans over multiple buffers because the length of the MSDU
 	 * exceeds DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE. So assume the data
@@ -475,7 +474,7 @@ static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
 static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 				     struct sk_buff *msdu,
 				     struct sk_buff_head *msdu_list,
-				     struct ath12k_dp_rx_info *rx_info)
+				     struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct hal_rx_desc *rx_desc, *lrx_desc;
@@ -496,7 +495,9 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 
 	rx_desc = (struct hal_rx_desc *)msdu->data;
 	lrx_desc = (struct hal_rx_desc *)last_buf->data;
-	if (!ath12k_dp_rx_h_msdu_done(ab, lrx_desc)) {
+
+	ath12k_wifi7_dp_extract_rx_desc_data(ab, rx_info, rx_desc, lrx_desc);
+	if (!rx_info->msdu_done) {
 		ath12k_warn(ab, "msdu_done bit in msdu_end is not set\n");
 		ret = -EIO;
 		goto free_out;
@@ -504,8 +505,8 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 
 	rxcb = ATH12K_SKB_RXCB(msdu);
 	rxcb->rx_desc = rx_desc;
-	msdu_len = ath12k_dp_rx_h_msdu_len(ab, lrx_desc);
-	l3_pad_bytes = ath12k_dp_rx_h_l3pad(ab, lrx_desc);
+	msdu_len = rx_info->msdu_len;
+	l3_pad_bytes = rx_info->l3_pad_bytes;
 
 	if (rxcb->is_frag) {
 		skb_pull(msdu, hal_rx_desc_sz);
@@ -522,7 +523,8 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 	} else {
 		ret = ath12k_dp_rx_msdu_coalesce(ar, msdu_list,
 						 msdu, last_buf,
-						 l3_pad_bytes, msdu_len);
+						 l3_pad_bytes, msdu_len,
+						 rx_info);
 		if (ret) {
 			ath12k_warn(ab,
 				    "failed to coalesce msdu rx buffer%d\n", ret);
@@ -530,12 +532,12 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 		}
 	}
 
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu))) {
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu,
+							     rx_info))) {
 		ret = -EINVAL;
 		goto free_out;
 	}
 
-	ath12k_dp_rx_h_fetch_info(ab, rx_desc, rx_info);
 	ath12k_dp_rx_h_ppdu(ar, rx_info);
 	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_info);
 
@@ -559,7 +561,7 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 	struct ath12k *ar;
 	struct ath12k_hw_link *hw_links = ag->hw_links;
 	struct ath12k_base *partner_ab;
-	struct ath12k_dp_rx_info rx_info;
+	struct hal_rx_desc_data rx_info;
 	u8 hw_link_id, pdev_id;
 	int ret;
 
@@ -764,19 +766,16 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 }
 
 static bool
-ath12k_dp_rx_h_defrag_validate_incr_pn(struct ath12k *ar, struct ath12k_dp_rx_tid *rx_tid)
+ath12k_dp_rx_h_defrag_validate_incr_pn(struct ath12k *ar,
+				       struct ath12k_dp_rx_tid *rx_tid,
+				       enum hal_encrypt_type encrypt_type)
 {
-	struct ath12k_base *ab = ar->ab;
-	enum hal_encrypt_type encrypt_type;
 	struct sk_buff *first_frag, *skb;
-	struct hal_rx_desc *desc;
 	u64 last_pn;
 	u64 cur_pn;
 
 	first_frag = skb_peek(&rx_tid->rx_frags);
-	desc = (struct hal_rx_desc *)first_frag->data;
 
-	encrypt_type = ath12k_dp_rx_h_enctype(ab, desc);
 	if (encrypt_type != HAL_ENCRYPT_TYPE_CCMP_128 &&
 	    encrypt_type != HAL_ENCRYPT_TYPE_CCMP_256 &&
 	    encrypt_type != HAL_ENCRYPT_TYPE_GCMP_128 &&
@@ -943,27 +942,29 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	return ret;
 }
 
-static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer *peer,
-					  struct sk_buff *msdu)
+static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar,
+					  struct ath12k_peer *peer,
+					  enum hal_encrypt_type enctype,
+					  struct sk_buff *msdu,
+					  struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
 	struct ieee80211_rx_status *rxs = IEEE80211_SKB_RXCB(msdu);
 	struct ieee80211_key_conf *key_conf;
 	struct ieee80211_hdr *hdr;
-	struct ath12k_dp_rx_info rx_info;
 	u8 mic[IEEE80211_CCMP_MIC_LEN];
 	int head_len, tail_len, ret;
 	size_t data_len;
-	u32 hdr_len, hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+	u32 hdr_len, hal_rx_desc_sz = ab->hal.hal_desc_sz;
 	u8 *key, *data;
 	u8 key_idx;
 
-	if (ath12k_dp_rx_h_enctype(ab, rx_desc) != HAL_ENCRYPT_TYPE_TKIP_MIC)
+	if (enctype != HAL_ENCRYPT_TYPE_TKIP_MIC)
 		return 0;
 
-	rx_info.addr2_present = false;
-	rx_info.rx_status = rxs;
+	rx_info->addr2_present = false;
+	rx_info->rx_status = rxs;
 
 	hdr = (struct ieee80211_hdr *)(msdu->data + hal_rx_desc_sz);
 	hdr_len = ieee80211_hdrlen(hdr->frame_control);
@@ -991,18 +992,19 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 	(ATH12K_SKB_RXCB(msdu))->is_first_msdu = true;
 	(ATH12K_SKB_RXCB(msdu))->is_last_msdu = true;
 
-	ath12k_dp_rx_h_fetch_info(ab, rx_desc, &rx_info);
+	ath12k_wifi7_dp_extract_rx_desc_data(ab, rx_info, rx_desc, rx_desc);
 
 	rxs->flag |= RX_FLAG_MMIC_ERROR | RX_FLAG_MMIC_STRIPPED |
 		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
 	skb_pull(msdu, hal_rx_desc_sz);
 
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu)))
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu,
+							     rx_info)))
 		return -EINVAL;
 
-	ath12k_dp_rx_h_ppdu(ar, &rx_info);
+	ath12k_dp_rx_h_ppdu(ar, rx_info);
 	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
-			       HAL_ENCRYPT_TYPE_TKIP_MIC, rxs, true);
+			       HAL_ENCRYPT_TYPE_TKIP_MIC, true, rx_info);
 	ieee80211_rx(ath12k_ar_to_hw(ar), msdu);
 	return -EINVAL;
 }
@@ -1010,13 +1012,12 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 static int ath12k_dp_rx_h_defrag(struct ath12k *ar,
 				 struct ath12k_peer *peer,
 				 struct ath12k_dp_rx_tid *rx_tid,
-				 struct sk_buff **defrag_skb)
+				 struct sk_buff **defrag_skb,
+				 enum hal_encrypt_type enctype,
+				 struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
-	struct hal_rx_desc *rx_desc;
 	struct sk_buff *skb, *first_frag, *last_frag;
 	struct ieee80211_hdr *hdr;
-	enum hal_encrypt_type enctype;
 	bool is_decrypted = false;
 	int msdu_len = 0;
 	int extra_space;
@@ -1027,13 +1028,10 @@ static int ath12k_dp_rx_h_defrag(struct ath12k *ar,
 
 	skb_queue_walk(&rx_tid->rx_frags, skb) {
 		flags = 0;
-		rx_desc = (struct hal_rx_desc *)skb->data;
 		hdr = (struct ieee80211_hdr *)(skb->data + hal_rx_desc_sz);
 
-		enctype = ath12k_dp_rx_h_enctype(ab, rx_desc);
 		if (enctype != HAL_ENCRYPT_TYPE_OPEN)
-			is_decrypted = ath12k_dp_rx_h_is_decrypted(ab,
-								   rx_desc);
+			is_decrypted = rx_info->is_decrypted;
 
 		if (is_decrypted) {
 			if (skb != first_frag)
@@ -1069,7 +1067,7 @@ static int ath12k_dp_rx_h_defrag(struct ath12k *ar,
 	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_MOREFRAGS);
 	ATH12K_SKB_RXCB(first_frag)->is_frag = 1;
 
-	if (ath12k_dp_rx_h_verify_tkip_mic(ar, peer, first_frag))
+	if (ath12k_dp_rx_h_verify_tkip_mic(ar, peer, enctype, first_frag, rx_info))
 		first_frag = NULL;
 
 	*defrag_skb = first_frag;
@@ -1078,28 +1076,25 @@ static int ath12k_dp_rx_h_defrag(struct ath12k *ar,
 
 static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
 				    struct sk_buff *msdu,
-				    struct hal_reo_dest_ring *ring_desc)
+				    struct hal_reo_dest_ring *ring_desc,
+				    struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct hal_rx_desc *rx_desc;
 	struct ath12k_peer *peer;
 	struct ath12k_dp_rx_tid *rx_tid;
 	struct sk_buff *defrag_skb = NULL;
-	u32 peer_id;
+	u32 peer_id = rx_info->peer_id;
 	u16 seqno, frag_no;
-	u8 tid;
+	u8 tid = rx_info->tid;
 	int ret = 0;
 	bool more_frags;
+	enum hal_encrypt_type enctype = rx_info->enctype;
 
-	rx_desc = (struct hal_rx_desc *)msdu->data;
-	peer_id = ath12k_dp_rx_h_peer_id(ab, rx_desc);
-	tid = ath12k_dp_rx_h_tid(ab, rx_desc);
-	seqno = ath12k_dp_rx_h_seq_no(ab, rx_desc);
 	frag_no = ath12k_dp_rx_h_frag_no(ab, msdu);
 	more_frags = ath12k_dp_rx_h_more_frags(ab, msdu);
+	seqno = rx_info->seq_no;
 
-	if (!ath12k_dp_rx_h_seq_ctrl_valid(ab, rx_desc) ||
-	    !ath12k_dp_rx_h_fc_valid(ab, rx_desc) ||
+	if (!rx_info->seq_ctl_valid || !rx_info->fc_valid ||
 	    tid > IEEE80211_NUM_TIDS)
 		return -EINVAL;
 
@@ -1179,10 +1174,11 @@ static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
 	if (!peer)
 		goto err_frags_cleanup;
 
-	if (!ath12k_dp_rx_h_defrag_validate_incr_pn(ar, rx_tid))
+	if (!ath12k_dp_rx_h_defrag_validate_incr_pn(ar, rx_tid, enctype))
 		goto err_frags_cleanup;
 
-	if (ath12k_dp_rx_h_defrag(ar, peer, rx_tid, &defrag_skb))
+	if (ath12k_dp_rx_h_defrag(ar, peer, rx_tid, &defrag_skb,
+				  enctype, rx_info))
 		goto err_frags_cleanup;
 
 	if (!defrag_skb)
@@ -1210,6 +1206,7 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 	struct ath12k_base *ab = ar->ab;
 	struct sk_buff *msdu;
 	struct ath12k_skb_rxcb *rxcb;
+	struct hal_rx_desc_data rx_info;
 	struct hal_rx_desc *rx_desc;
 	u16 msdu_len;
 	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
@@ -1260,7 +1257,9 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 	}
 
 	rx_desc = (struct hal_rx_desc *)msdu->data;
-	msdu_len = ath12k_dp_rx_h_msdu_len(ar->ab, rx_desc);
+	ath12k_wifi7_dp_extract_rx_desc_data(ab, &rx_info, rx_desc, rx_desc);
+
+	msdu_len = rx_info.msdu_len;
 	if ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE) {
 		ath12k_warn(ar->ab, "invalid msdu leng %u", msdu_len);
 		ath12k_dbg_dump(ar->ab, ATH12K_DBG_DATA, NULL, "", rx_desc,
@@ -1271,7 +1270,7 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 
 	skb_put(msdu, hal_rx_desc_sz + msdu_len);
 
-	if (ath12k_dp_rx_frag_h_mpdu(ar, msdu, desc)) {
+	if (ath12k_dp_rx_frag_h_mpdu(ar, msdu, desc, &rx_info)) {
 		dev_kfree_skb_any(msdu);
 		ath12k_dp_rx_link_desc_return(ar->ab, &desc->buf_addr_info,
 					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
@@ -1439,18 +1438,16 @@ static void ath12k_dp_rx_null_q_desc_sg_drop(struct ath12k *ar,
 }
 
 static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
-				      struct ath12k_dp_rx_info *rx_info,
+				      struct hal_rx_desc_data *rx_info,
 				      struct sk_buff_head *msdu_list)
 {
 	struct ath12k_base *ab = ar->ab;
-	u16 msdu_len;
+	u16 msdu_len = rx_info->msdu_len;
 	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
-	u8 l3pad_bytes;
+	u8 l3pad_bytes = rx_info->l3_pad_bytes;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
-	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
-
 	if (!rxcb->is_frag && ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE)) {
 		/* First buffer will be freed by the caller, so deduct it's length */
 		msdu_len = msdu_len - (DP_RX_BUFFER_SIZE - hal_rx_desc_sz);
@@ -1465,7 +1462,7 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 	if (rxcb->is_continuation)
 		return -EINVAL;
 
-	if (!ath12k_dp_rx_h_msdu_done(ab, desc)) {
+	if (!rx_info->msdu_done) {
 		ath12k_warn(ar->ab,
 			    "msdu_done bit not set in null_q_des processing\n");
 		__skb_queue_purge(msdu_list);
@@ -1484,18 +1481,15 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 	if (rxcb->is_frag) {
 		skb_pull(msdu, hal_rx_desc_sz);
 	} else {
-		l3pad_bytes = ath12k_dp_rx_h_l3pad(ab, desc);
-
 		if ((hal_rx_desc_sz + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE)
 			return -EINVAL;
 
 		skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 		skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 	}
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu, rx_info)))
 		return -EINVAL;
 
-	ath12k_dp_rx_h_fetch_info(ab, desc, rx_info);
 	ath12k_dp_rx_h_ppdu(ar, rx_info);
 	ath12k_dp_rx_h_mpdu(ar, msdu, desc, rx_info);
 
@@ -1509,20 +1503,17 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 }
 
 static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
-					struct ath12k_dp_rx_info *rx_info)
+					struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
-	u16 msdu_len;
+	u16 msdu_len = rx_info->msdu_len;
 	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
-	u8 l3pad_bytes;
+	u8 l3pad_bytes = rx_info->l3_pad_bytes;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
-	rxcb->is_first_msdu = ath12k_dp_rx_h_first_msdu(ab, desc);
-	rxcb->is_last_msdu = ath12k_dp_rx_h_last_msdu(ab, desc);
-
-	l3pad_bytes = ath12k_dp_rx_h_l3pad(ab, desc);
-	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
+	rxcb->is_first_msdu = rx_info->is_first_msdu;
+	rxcb->is_last_msdu = rx_info->is_last_msdu;
 
 	if ((hal_rx_desc_sz + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE) {
 		ath12k_dbg(ab, ATH12K_DBG_DATA,
@@ -1535,7 +1526,7 @@ static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu, rx_info)))
 		return true;
 
 	ath12k_dp_rx_h_ppdu(ar, rx_info);
@@ -1544,27 +1535,22 @@ static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 				     RX_FLAG_DECRYPTED);
 
 	ath12k_dp_rx_h_undecap(ar, msdu, desc,
-			       HAL_ENCRYPT_TYPE_TKIP_MIC, rx_info->rx_status, false);
+			       HAL_ENCRYPT_TYPE_TKIP_MIC, false, rx_info);
 	return false;
 }
 
 static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
-				     struct ath12k_dp_rx_info *rx_info)
+				     struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_base *ab = ar->ab;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
 	bool drop = false;
-	u32 err_bitmap;
 
 	ar->ab->device_stats.rxdma_error[rxcb->err_code]++;
 
 	switch (rxcb->err_code) {
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR:
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR:
-		err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, rx_desc);
-		if (err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC) {
-			ath12k_dp_rx_h_fetch_info(ab, rx_desc, rx_info);
+		if (rx_info->err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC) {
 			drop = ath12k_dp_rx_h_tkip_mic_err(ar, msdu, rx_info);
 			break;
 		}
@@ -1581,7 +1567,7 @@ static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
 }
 
 static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
-				   struct ath12k_dp_rx_info *rx_info,
+				   struct hal_rx_desc_data *rx_info,
 				   struct sk_buff_head *msdu_list)
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
@@ -1616,14 +1602,17 @@ static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
 				 struct sk_buff *msdu,
 				 struct sk_buff_head *msdu_list)
 {
+	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ieee80211_rx_status rxs = {};
-	struct ath12k_dp_rx_info rx_info;
+	struct hal_rx_desc_data rx_info;
 	bool drop = true;
 
 	rx_info.addr2_present = false;
 	rx_info.rx_status = &rxs;
 
+	ath12k_wifi7_dp_extract_rx_desc_data(ar->ab, &rx_info, rx_desc, rx_desc);
+
 	switch (rxcb->err_rel_src) {
 	case HAL_WBM_REL_SRC_MODULE_REO:
 		drop = ath12k_dp_rx_h_reo_err(ar, msdu, &rx_info, msdu_list);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index 45b856aaaa12..f258472bc1fc 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -44,4 +44,12 @@ int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
 				  struct ath12k_dp_rx_tid *rx_tid,
 				  u32 ba_win_sz, u16 ssn,
 				  bool update_ssn);
+static inline
+void ath12k_wifi7_dp_extract_rx_desc_data(struct ath12k_base *ab,
+					  struct hal_rx_desc_data *rx_info,
+					  struct hal_rx_desc *rx_desc,
+					  struct hal_rx_desc *ldesc)
+{
+	ab->hw_params->hal_ops->extract_rx_desc_data(rx_info, rx_desc, ldesc);
+}
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index bf09a40c91d9..2e84c830d9b2 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -6,12 +6,14 @@
 #include "hal_desc.h"
 #include "hal_qcn9274.h"
 
+static inline
 bool ath12k_hal_rx_desc_get_first_msdu_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
 			       RX_MSDU_END_INFO5_FIRST_MSDU);
 }
 
+static inline
 bool ath12k_hal_rx_desc_get_last_msdu_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
@@ -24,95 +26,114 @@ u8 ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274(struct hal_rx_desc *desc)
 			     RX_MSDU_END_INFO5_L3_HDR_PADDING);
 }
 
+static inline
 bool ath12k_hal_rx_desc_encrypt_valid_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
 			       RX_MPDU_START_INFO4_ENCRYPT_INFO_VALID);
 }
 
+static inline
 u32 ath12k_hal_rx_desc_get_encrypt_type_qcn9274(struct hal_rx_desc *desc)
 {
+	if (!ath12k_hal_rx_desc_encrypt_valid_qcn9274(desc))
+		return HAL_ENCRYPT_TYPE_OPEN;
+
 	return le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info2,
 			     RX_MPDU_START_INFO2_ENC_TYPE);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_decap_type_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info11,
 			     RX_MSDU_END_INFO11_DECAP_FORMAT);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_mesh_ctl_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info11,
 			     RX_MSDU_END_INFO11_MESH_CTRL_PRESENT);
 }
 
+static inline
 bool ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
 			       RX_MPDU_START_INFO4_MPDU_SEQ_CTRL_VALID);
 }
 
+static inline
 bool ath12k_hal_rx_desc_get_mpdu_fc_valid_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
 			       RX_MPDU_START_INFO4_MPDU_FCTRL_VALID);
 }
 
+static inline
 u16 ath12k_hal_rx_desc_get_mpdu_start_seq_no_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
 			     RX_MPDU_START_INFO4_MPDU_SEQ_NUM);
 }
 
+static inline
 u16 ath12k_hal_rx_desc_get_msdu_len_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info10,
 			     RX_MSDU_END_INFO10_MSDU_LENGTH);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_msdu_sgi_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
 			     RX_MSDU_END_INFO12_SGI);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_msdu_rate_mcs_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
 			     RX_MSDU_END_INFO12_RATE_MCS);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_msdu_rx_bw_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
 			     RX_MSDU_END_INFO12_RECV_BW);
 }
 
+static inline
 u32 ath12k_hal_rx_desc_get_msdu_freq_qcn9274(struct hal_rx_desc *desc)
 {
 	return __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.phy_meta_data);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_msdu_pkt_type_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
 			     RX_MSDU_END_INFO12_PKT_TYPE);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_msdu_nss_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
 			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_mpdu_tid_qcn9274(struct hal_rx_desc *desc)
 {
 	return le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
 			     RX_MSDU_END_INFO5_TID);
 }
 
+static inline
 u16 ath12k_hal_rx_desc_get_mpdu_peer_id_qcn9274(struct hal_rx_desc *desc)
 {
 	return __le16_to_cpu(desc->u.qcn9274_compact.mpdu_start.sw_peer_id);
@@ -152,41 +173,48 @@ u32 ath12k_hal_rx_desc_get_msdu_end_offset_qcn9274(void)
 	return offsetof(struct hal_rx_desc_qcn9274_compact, msdu_end);
 }
 
+static inline
 bool ath12k_hal_rx_desc_mac_addr2_valid_qcn9274(struct hal_rx_desc *desc)
 {
 	return __le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info4) &
 			     RX_MPDU_START_INFO4_MAC_ADDR2_VALID;
 }
 
+static inline
 u8 *ath12k_hal_rx_desc_mpdu_start_addr2_qcn9274(struct hal_rx_desc *desc)
 {
 	return desc->u.qcn9274_compact.mpdu_start.addr2;
 }
 
+static inline
 bool ath12k_hal_rx_desc_is_da_mcbc_qcn9274(struct hal_rx_desc *desc)
 {
 	return __le16_to_cpu(desc->u.qcn9274_compact.msdu_end.info5) &
 	       RX_MSDU_END_INFO5_DA_IS_MCBC;
 }
 
+static inline
 bool ath12k_hal_rx_h_msdu_done_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info14,
 			       RX_MSDU_END_INFO14_MSDU_DONE);
 }
 
+static inline
 bool ath12k_hal_rx_h_l4_cksum_fail_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info13,
 			       RX_MSDU_END_INFO13_TCP_UDP_CKSUM_FAIL);
 }
 
+static inline
 bool ath12k_hal_rx_h_ip_cksum_fail_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info13,
 			       RX_MSDU_END_INFO13_IP_CKSUM_FAIL);
 }
 
+static inline
 bool ath12k_hal_rx_h_is_decrypted_qcn9274(struct hal_rx_desc *desc)
 {
 	return (le32_get_bits(desc->u.qcn9274_compact.msdu_end.info14,
@@ -215,7 +243,7 @@ u32 ath12k_hal_rx_msdu_end_wmask_get_qcn9274(void)
 	return QCN9274_MSDU_END_WMASK;
 }
 
-u32 ath12k_hal_rx_h_mpdu_err_qcn9274(struct hal_rx_desc *desc)
+static u32 ath12k_hal_rx_h_mpdu_err_qcn9274(struct hal_rx_desc *desc)
 {
 	u32 info = __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info13);
 	u32 errmap = 0;
@@ -305,3 +333,37 @@ void ath12k_hal_rx_desc_get_dot11_hdr_qcn9274(struct hal_rx_desc *desc,
 	}
 	hdr->seq_ctrl = desc->u.qcn9274_compact.mpdu_start.seq_ctrl;
 }
+
+void ath12k_hal_extract_rx_desc_data_qcn9274(struct hal_rx_desc_data *rx_desc_data,
+					     struct hal_rx_desc *rx_desc,
+					     struct hal_rx_desc *ldesc)
+{
+	rx_desc_data->is_first_msdu = ath12k_hal_rx_desc_get_first_msdu_qcn9274(ldesc);
+	rx_desc_data->is_last_msdu = ath12k_hal_rx_desc_get_last_msdu_qcn9274(ldesc);
+	rx_desc_data->l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274(ldesc);
+	rx_desc_data->enctype = ath12k_hal_rx_desc_get_encrypt_type_qcn9274(rx_desc);
+	rx_desc_data->decap_type = ath12k_hal_rx_desc_get_decap_type_qcn9274(rx_desc);
+	rx_desc_data->mesh_ctrl_present =
+		ath12k_hal_rx_desc_get_mesh_ctl_qcn9274(rx_desc);
+	rx_desc_data->seq_ctl_valid =
+		ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_qcn9274(rx_desc);
+	rx_desc_data->fc_valid = ath12k_hal_rx_desc_get_mpdu_fc_valid_qcn9274(rx_desc);
+	rx_desc_data->seq_no = ath12k_hal_rx_desc_get_mpdu_start_seq_no_qcn9274(rx_desc);
+	rx_desc_data->msdu_len = ath12k_hal_rx_desc_get_msdu_len_qcn9274(ldesc);
+	rx_desc_data->sgi = ath12k_hal_rx_desc_get_msdu_sgi_qcn9274(rx_desc);
+	rx_desc_data->rate_mcs = ath12k_hal_rx_desc_get_msdu_rate_mcs_qcn9274(rx_desc);
+	rx_desc_data->bw = ath12k_hal_rx_desc_get_msdu_rx_bw_qcn9274(rx_desc);
+	rx_desc_data->phy_meta_data = ath12k_hal_rx_desc_get_msdu_freq_qcn9274(rx_desc);
+	rx_desc_data->pkt_type = ath12k_hal_rx_desc_get_msdu_pkt_type_qcn9274(rx_desc);
+	rx_desc_data->nss = hweight8(ath12k_hal_rx_desc_get_msdu_nss_qcn9274(rx_desc));
+	rx_desc_data->tid = ath12k_hal_rx_desc_get_mpdu_tid_qcn9274(rx_desc);
+	rx_desc_data->peer_id = ath12k_hal_rx_desc_get_mpdu_peer_id_qcn9274(rx_desc);
+	rx_desc_data->addr2_present = ath12k_hal_rx_desc_mac_addr2_valid_qcn9274(rx_desc);
+	rx_desc_data->addr2 = ath12k_hal_rx_desc_mpdu_start_addr2_qcn9274(rx_desc);
+	rx_desc_data->is_mcbc = ath12k_hal_rx_desc_is_da_mcbc_qcn9274(rx_desc);
+	rx_desc_data->msdu_done = ath12k_hal_rx_h_msdu_done_qcn9274(ldesc);
+	rx_desc_data->l4_csum_fail = ath12k_hal_rx_h_l4_cksum_fail_qcn9274(rx_desc);
+	rx_desc_data->ip_csum_fail = ath12k_hal_rx_h_ip_cksum_fail_qcn9274(rx_desc);
+	rx_desc_data->is_decrypted = ath12k_hal_rx_h_is_decrypted_qcn9274(rx_desc);
+	rx_desc_data->err_bitmap = ath12k_hal_rx_h_mpdu_err_qcn9274(rx_desc);
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
index 562156bbd726..9a918824e093 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
@@ -12,25 +12,7 @@
 #include "../hal.h"
 #include "hal_rx.h"
 
-bool ath12k_hal_rx_desc_get_first_msdu_qcn9274(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_desc_get_last_msdu_qcn9274(struct hal_rx_desc *desc);
 u8 ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_desc_encrypt_valid_qcn9274(struct hal_rx_desc *desc);
-u32 ath12k_hal_rx_desc_get_encrypt_type_qcn9274(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_decap_type_qcn9274(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_mesh_ctl_qcn9274(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_qcn9274(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_desc_get_mpdu_fc_valid_qcn9274(struct hal_rx_desc *desc);
-u16 ath12k_hal_rx_desc_get_mpdu_start_seq_no_qcn9274(struct hal_rx_desc *desc);
-u16 ath12k_hal_rx_desc_get_msdu_len_qcn9274(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_msdu_sgi_qcn9274(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_msdu_rate_mcs_qcn9274(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_msdu_rx_bw_qcn9274(struct hal_rx_desc *desc);
-u32 ath12k_hal_rx_desc_get_msdu_freq_qcn9274(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_msdu_pkt_type_qcn9274(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_msdu_nss_qcn9274(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_mpdu_tid_qcn9274(struct hal_rx_desc *desc);
-u16 ath12k_hal_rx_desc_get_mpdu_peer_id_qcn9274(struct hal_rx_desc *desc);
 void ath12k_hal_rx_desc_copy_end_tlv_qcn9274(struct hal_rx_desc *fdesc,
 					     struct hal_rx_desc *ldesc);
 u32 ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274(struct hal_rx_desc *desc);
@@ -38,21 +20,16 @@ void ath12k_hal_rx_desc_set_msdu_len_qcn9274(struct hal_rx_desc *desc, u16 len);
 u8 *ath12k_hal_rx_desc_get_msdu_payload_qcn9274(struct hal_rx_desc *desc);
 u32 ath12k_hal_rx_desc_get_mpdu_start_offset_qcn9274(void);
 u32 ath12k_hal_rx_desc_get_msdu_end_offset_qcn9274(void);
-bool ath12k_hal_rx_desc_mac_addr2_valid_qcn9274(struct hal_rx_desc *desc);
-u8 *ath12k_hal_rx_desc_mpdu_start_addr2_qcn9274(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_desc_is_da_mcbc_qcn9274(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_h_msdu_done_qcn9274(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_h_l4_cksum_fail_qcn9274(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_h_ip_cksum_fail_qcn9274(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_h_is_decrypted_qcn9274(struct hal_rx_desc *desc);
 u32 ath12k_hal_get_rx_desc_size_qcn9274(void);
 u8 ath12k_hal_rx_desc_get_msdu_src_link_qcn9274(struct hal_rx_desc *desc);
 u16 ath12k_hal_rx_mpdu_start_wmask_get_qcn9274(void);
 u32 ath12k_hal_rx_msdu_end_wmask_get_qcn9274(void);
-u32 ath12k_hal_rx_h_mpdu_err_qcn9274(struct hal_rx_desc *desc);
 void ath12k_hal_rx_desc_get_crypto_hdr_qcn9274(struct hal_rx_desc *desc,
 					       u8 *crypto_hdr,
 					       enum hal_encrypt_type enctype);
 void ath12k_hal_rx_desc_get_dot11_hdr_qcn9274(struct hal_rx_desc *desc,
 					      struct ieee80211_hdr *hdr);
+void ath12k_hal_extract_rx_desc_data_qcn9274(struct hal_rx_desc_data *rx_desc_data,
+					     struct hal_rx_desc *rx_desc,
+					     struct hal_rx_desc *ldesc);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 11b03452494c..0fa1d9fad2e1 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -7,12 +7,14 @@
 #include "hal_desc.h"
 #include "hal_wcn7850.h"
 
+static inline
 bool ath12k_hal_rx_desc_get_first_msdu_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le16_get_bits(desc->u.wcn7850.msdu_end.info5,
 			       RX_MSDU_END_INFO5_FIRST_MSDU);
 }
 
+static inline
 bool ath12k_hal_rx_desc_get_last_msdu_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le16_get_bits(desc->u.wcn7850.msdu_end.info5,
@@ -25,95 +27,114 @@ u8 ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850(struct hal_rx_desc *desc)
 			    RX_MSDU_END_INFO5_L3_HDR_PADDING);
 }
 
+static inline
 bool ath12k_hal_rx_desc_encrypt_valid_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
 			       RX_MPDU_START_INFO4_ENCRYPT_INFO_VALID);
 }
 
+static inline
 u32 ath12k_hal_rx_desc_get_encrypt_type_wcn7850(struct hal_rx_desc *desc)
 {
+	if (!ath12k_hal_rx_desc_encrypt_valid_wcn7850(desc))
+		return HAL_ENCRYPT_TYPE_OPEN;
+
 	return le32_get_bits(desc->u.wcn7850.mpdu_start.info2,
 			     RX_MPDU_START_INFO2_ENC_TYPE);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_decap_type_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info11,
 			     RX_MSDU_END_INFO11_DECAP_FORMAT);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_mesh_ctl_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info11,
 			     RX_MSDU_END_INFO11_MESH_CTRL_PRESENT);
 }
 
+static inline
 bool ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
 			       RX_MPDU_START_INFO4_MPDU_SEQ_CTRL_VALID);
 }
 
+static inline
 bool ath12k_hal_rx_desc_get_mpdu_fc_valid_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
 			       RX_MPDU_START_INFO4_MPDU_FCTRL_VALID);
 }
 
+static inline
 u16 ath12k_hal_rx_desc_get_mpdu_start_seq_no_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
 			     RX_MPDU_START_INFO4_MPDU_SEQ_NUM);
 }
 
+static inline
 u16 ath12k_hal_rx_desc_get_msdu_len_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info10,
 			     RX_MSDU_END_INFO10_MSDU_LENGTH);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_msdu_sgi_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
 			     RX_MSDU_END_INFO12_SGI);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_msdu_rate_mcs_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
 			     RX_MSDU_END_INFO12_RATE_MCS);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_msdu_rx_bw_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
 			     RX_MSDU_END_INFO12_RECV_BW);
 }
 
+static inline
 u32 ath12k_hal_rx_desc_get_msdu_freq_wcn7850(struct hal_rx_desc *desc)
 {
 	return __le32_to_cpu(desc->u.wcn7850.msdu_end.phy_meta_data);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_msdu_pkt_type_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
 			     RX_MSDU_END_INFO12_PKT_TYPE);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_msdu_nss_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
 			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
 }
 
+static inline
 u8 ath12k_hal_rx_desc_get_mpdu_tid_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.mpdu_start.info2,
 			     RX_MPDU_START_INFO2_TID);
 }
 
+static inline
 u16 ath12k_hal_rx_desc_get_mpdu_peer_id_wcn7850(struct hal_rx_desc *desc)
 {
 	return __le16_to_cpu(desc->u.wcn7850.mpdu_start.sw_peer_id);
@@ -162,41 +183,48 @@ u32 ath12k_hal_rx_desc_get_msdu_end_offset_wcn7850(void)
 	return offsetof(struct hal_rx_desc_wcn7850, msdu_end_tag);
 }
 
+static inline
 bool ath12k_hal_rx_desc_mac_addr2_valid_wcn7850(struct hal_rx_desc *desc)
 {
 	return __le32_to_cpu(desc->u.wcn7850.mpdu_start.info4) &
 	       RX_MPDU_START_INFO4_MAC_ADDR2_VALID;
 }
 
+static inline
 u8 *ath12k_hal_rx_desc_mpdu_start_addr2_wcn7850(struct hal_rx_desc *desc)
 {
 	return desc->u.wcn7850.mpdu_start.addr2;
 }
 
+static inline
 bool ath12k_hal_rx_desc_is_da_mcbc_wcn7850(struct hal_rx_desc *desc)
 {
 	return __le32_to_cpu(desc->u.wcn7850.msdu_end.info13) &
 	       RX_MSDU_END_INFO13_MCAST_BCAST;
 }
 
+static inline
 bool ath12k_hal_rx_h_msdu_done_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.wcn7850.msdu_end.info14,
 			       RX_MSDU_END_INFO14_MSDU_DONE);
 }
 
+static inline
 bool ath12k_hal_rx_h_l4_cksum_fail_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.wcn7850.msdu_end.info13,
 			       RX_MSDU_END_INFO13_TCP_UDP_CKSUM_FAIL);
 }
 
+static inline
 bool ath12k_hal_rx_h_ip_cksum_fail_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.wcn7850.msdu_end.info13,
 			      RX_MSDU_END_INFO13_IP_CKSUM_FAIL);
 }
 
+static inline
 bool ath12k_hal_rx_h_is_decrypted_wcn7850(struct hal_rx_desc *desc)
 {
 	return (le32_get_bits(desc->u.wcn7850.msdu_end.info14,
@@ -214,7 +242,7 @@ u8 ath12k_hal_rx_desc_get_msdu_src_link_wcn7850(struct hal_rx_desc *desc)
 	return 0;
 }
 
-u32 ath12k_hal_rx_h_mpdu_err_wcn7850(struct hal_rx_desc *desc)
+static u32 ath12k_hal_rx_h_mpdu_err_wcn7850(struct hal_rx_desc *desc)
 {
 	u32 info = __le32_to_cpu(desc->u.wcn7850.msdu_end.info13);
 	u32 errmap = 0;
@@ -300,3 +328,37 @@ void ath12k_hal_rx_desc_get_dot11_hdr_wcn7850(struct hal_rx_desc *desc,
 	}
 	hdr->seq_ctrl = desc->u.wcn7850.mpdu_start.seq_ctrl;
 }
+
+void ath12k_hal_extract_rx_desc_data_wcn7850(struct hal_rx_desc_data *rx_desc_data,
+					     struct hal_rx_desc *rx_desc,
+					     struct hal_rx_desc *ldesc)
+{
+	rx_desc_data->is_first_msdu = ath12k_hal_rx_desc_get_first_msdu_wcn7850(ldesc);
+	rx_desc_data->is_last_msdu = ath12k_hal_rx_desc_get_last_msdu_wcn7850(ldesc);
+	rx_desc_data->l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850(ldesc);
+	rx_desc_data->enctype = ath12k_hal_rx_desc_get_encrypt_type_wcn7850(rx_desc);
+	rx_desc_data->decap_type = ath12k_hal_rx_desc_get_decap_type_wcn7850(rx_desc);
+	rx_desc_data->mesh_ctrl_present =
+		ath12k_hal_rx_desc_get_mesh_ctl_wcn7850(rx_desc);
+	rx_desc_data->seq_ctl_valid =
+		ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_wcn7850(rx_desc);
+	rx_desc_data->fc_valid = ath12k_hal_rx_desc_get_mpdu_fc_valid_wcn7850(rx_desc);
+	rx_desc_data->seq_no = ath12k_hal_rx_desc_get_mpdu_start_seq_no_wcn7850(rx_desc);
+	rx_desc_data->msdu_len = ath12k_hal_rx_desc_get_msdu_len_wcn7850(ldesc);
+	rx_desc_data->sgi = ath12k_hal_rx_desc_get_msdu_sgi_wcn7850(rx_desc);
+	rx_desc_data->rate_mcs = ath12k_hal_rx_desc_get_msdu_rate_mcs_wcn7850(rx_desc);
+	rx_desc_data->bw = ath12k_hal_rx_desc_get_msdu_rx_bw_wcn7850(rx_desc);
+	rx_desc_data->phy_meta_data = ath12k_hal_rx_desc_get_msdu_freq_wcn7850(rx_desc);
+	rx_desc_data->pkt_type = ath12k_hal_rx_desc_get_msdu_pkt_type_wcn7850(rx_desc);
+	rx_desc_data->nss = hweight8(ath12k_hal_rx_desc_get_msdu_nss_wcn7850(rx_desc));
+	rx_desc_data->tid = ath12k_hal_rx_desc_get_mpdu_tid_wcn7850(rx_desc);
+	rx_desc_data->peer_id = ath12k_hal_rx_desc_get_mpdu_peer_id_wcn7850(rx_desc);
+	rx_desc_data->addr2_present = ath12k_hal_rx_desc_mac_addr2_valid_wcn7850(rx_desc);
+	rx_desc_data->addr2 = ath12k_hal_rx_desc_mpdu_start_addr2_wcn7850(rx_desc);
+	rx_desc_data->is_mcbc = ath12k_hal_rx_desc_is_da_mcbc_wcn7850(rx_desc);
+	rx_desc_data->msdu_done = ath12k_hal_rx_h_msdu_done_wcn7850(ldesc);
+	rx_desc_data->l4_csum_fail = ath12k_hal_rx_h_l4_cksum_fail_wcn7850(rx_desc);
+	rx_desc_data->ip_csum_fail = ath12k_hal_rx_h_ip_cksum_fail_wcn7850(rx_desc);
+	rx_desc_data->is_decrypted = ath12k_hal_rx_h_is_decrypted_wcn7850(rx_desc);
+	rx_desc_data->err_bitmap = ath12k_hal_rx_h_mpdu_err_wcn7850(rx_desc);
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
index c9a6b7ffb607..a90978b2a454 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
@@ -10,25 +10,7 @@
 #include "../hal.h"
 #include "hal_rx.h"
 
-bool ath12k_hal_rx_desc_get_first_msdu_wcn7850(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_desc_get_last_msdu_wcn7850(struct hal_rx_desc *desc);
 u8 ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_desc_encrypt_valid_wcn7850(struct hal_rx_desc *desc);
-u32 ath12k_hal_rx_desc_get_encrypt_type_wcn7850(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_decap_type_wcn7850(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_mesh_ctl_wcn7850(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_wcn7850(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_desc_get_mpdu_fc_valid_wcn7850(struct hal_rx_desc *desc);
-u16 ath12k_hal_rx_desc_get_mpdu_start_seq_no_wcn7850(struct hal_rx_desc *desc);
-u16 ath12k_hal_rx_desc_get_msdu_len_wcn7850(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_msdu_sgi_wcn7850(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_msdu_rate_mcs_wcn7850(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_msdu_rx_bw_wcn7850(struct hal_rx_desc *desc);
-u32 ath12k_hal_rx_desc_get_msdu_freq_wcn7850(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_msdu_pkt_type_wcn7850(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_msdu_nss_wcn7850(struct hal_rx_desc *desc);
-u8 ath12k_hal_rx_desc_get_mpdu_tid_wcn7850(struct hal_rx_desc *desc);
-u16 ath12k_hal_rx_desc_get_mpdu_peer_id_wcn7850(struct hal_rx_desc *desc);
 void ath12k_hal_rx_desc_copy_end_tlv_wcn7850(struct hal_rx_desc *fdesc,
 					     struct hal_rx_desc *ldesc);
 u32 ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850(struct hal_rx_desc *desc);
@@ -37,19 +19,14 @@ void ath12k_hal_rx_desc_set_msdu_len_wcn7850(struct hal_rx_desc *desc, u16 len);
 u8 *ath12k_hal_rx_desc_get_msdu_payload_wcn7850(struct hal_rx_desc *desc);
 u32 ath12k_hal_rx_desc_get_mpdu_start_offset_wcn7850(void);
 u32 ath12k_hal_rx_desc_get_msdu_end_offset_wcn7850(void);
-bool ath12k_hal_rx_desc_mac_addr2_valid_wcn7850(struct hal_rx_desc *desc);
-u8 *ath12k_hal_rx_desc_mpdu_start_addr2_wcn7850(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_desc_is_da_mcbc_wcn7850(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_h_msdu_done_wcn7850(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_h_l4_cksum_fail_wcn7850(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_h_ip_cksum_fail_wcn7850(struct hal_rx_desc *desc);
-bool ath12k_hal_rx_h_is_decrypted_wcn7850(struct hal_rx_desc *desc);
 u32 ath12k_hal_get_rx_desc_size_wcn7850(void);
 u8 ath12k_hal_rx_desc_get_msdu_src_link_wcn7850(struct hal_rx_desc *desc);
-u32 ath12k_hal_rx_h_mpdu_err_wcn7850(struct hal_rx_desc *desc);
 void ath12k_hal_rx_desc_get_crypto_hdr_wcn7850(struct hal_rx_desc *desc,
 					       u8 *crypto_hdr,
 					       enum hal_encrypt_type enctype);
 void ath12k_hal_rx_desc_get_dot11_hdr_wcn7850(struct hal_rx_desc *desc,
 					      struct ieee80211_hdr *hdr);
+void ath12k_hal_extract_rx_desc_data_wcn7850(struct hal_rx_desc_data *rx_desc_data,
+					     struct hal_rx_desc *rx_desc,
+					     struct hal_rx_desc *ldesc);
 #endif
-- 
2.34.1


