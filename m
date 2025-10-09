Return-Path: <linux-wireless+bounces-27901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0740BC8B4A
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BF23AAF87
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F325A2E03F0;
	Thu,  9 Oct 2025 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R3/OMsKD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C92DD5EB
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008270; cv=none; b=HbKwmIxrdQqI1MYRSAkw1ovr9+bbF7L/nvYpogAELCSupVmnVD2Lv1J722rNJ2Ra2H6Fe68uR8FUsbuIQLiLovXyaWb8hM4lL/3E1bdc4fwAkXneg6YN5JtyQaOCZ2D3hGb9HITk1XreODJpAX7N1ndtvjbvtkLXNIQcm4qDJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008270; c=relaxed/simple;
	bh=CcuCl6C21syCHU01SYb8Db+oWmXL0hpS9mm0kMDMbaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRGtIVKZx6GfBIBbUVEI82GUl2Ta8S6NyH4ZHnt3BR8qqkSe6HIXo790YObDNr05UNoMSkBpgY+proVQAChtkxWt95mLeOEwZIcmKNta+Z26LwkFZ6xT3kG5AWuuUawl/41VGKvmRNAxp+LPkPrWSNn3YdxK5XxqzXE3rhj1WOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R3/OMsKD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EIPE023264;
	Thu, 9 Oct 2025 11:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uZjAecbvjdWUImreZqoMR5ZjXTyoZ6oJ246mf6G5wfc=; b=R3/OMsKDhr7vEgpO
	2i9zoQBWXUcGQv3Gw6Cyusk8vq4fq/Hw8XCib3ePnkz5IANZDkNii9ef6cd5a7nO
	htJdUKm+Sz3GB5bIju4Y2/ps2cPj+Iwva5ul/LPUKBCK79fj2Fu2QlNf2MSXBIcq
	YIDylwl87rniPxkJi1Zc7b2eY7bzQe5Vy0fK6Yj/sf+19dNnTJw51qP1Ssjzb9bF
	nEs2WFYHFkrLwzmv3b/Lsv2n8BxDrAJ21j1c0H7k1VhyMEw+LTQg40krHEmizfoQ
	REiFxMsf4R1ldup5nNEoQzX/NCSMI8FJE6E4EaeCTwsSuVbsvnPFOC9FJerLhMB2
	QDV17Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m2hrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BB5tl010910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:06 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:04 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 03/18] wifi: ath12k: Initialize hal_ops through hal_init
Date: Thu, 9 Oct 2025 16:40:30 +0530
Message-ID: <20251009111045.1763001-4-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
References: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX1PI4g2PSR3Wd
 PNVfdhE/uniXcxhRABdohbqUfdI5MfMJUtWu93J6BaqiV3T9iux26p2N+fUrZnzUY35+iEUdV0A
 FwNeDljzf7bPyxFPtFoRxJD1Jnb4YFlp3Qijgn2mOsTx3rX1KMuTf0yLugx91G20ahHzq0BKSes
 07tPpVJTBFTSm7yIXsltiu2dqRPrW2FcjpY2Zj8elFCSkgwEsFNT0QwKaGRFbxOw3NyIE6JaD9L
 P+WeGVKYPIaCGBl6Yu8oOjbaQP0DmpCIHeZxJMud1WLMYC7RhQqRUMz7vgBp7ALcK/zlbkkSib5
 pJOSUG8oPkNDVNQznv3HvfuTeVLnDlzVZiYwDU18i9hrVTvV0RWoz8yQeqi3xedj6tseeCYyu7B
 3NUqLKcN/a0Qk2r+Z5QSQbWHKA9jmw==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e7984a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=TwCGGek8gYUEDy4t_NIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: gfs-uA0OFnnnH2GPP72HCJY7MG2dqnK0
X-Proofpoint-ORIG-GUID: gfs-uA0OFnnnH2GPP72HCJY7MG2dqnK0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Modularize the HAL layer by moving hal_ops from ab->hw_params into the
ab->hal. This reduces indirection and allows data path to access HAL ops
directly through the HAL context.

Initialize hal_ops via hal_init using a const table ath12k_hw_version_map.
This approach will be extended to register other HAL parameters during
init.

Remove ab->hw_params->hal_ops as it is no longer needed.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c            |  2 +-
 drivers/net/wireless/ath/ath12k/dp.c             |  4 ++--
 drivers/net/wireless/ath/ath12k/dp_mon.c         |  2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h          | 16 ++++++++--------
 drivers/net/wireless/ath/ath12k/hal.c            |  2 +-
 drivers/net/wireless/ath/ath12k/hal.h            |  5 ++---
 drivers/net/wireless/ath/ath12k/hw.h             |  2 --
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h    |  2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c    |  2 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal.c      |  7 +++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h  |  1 +
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.h  |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c       |  8 --------
 13 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 7eb8dedaa947..2c991580571c 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -563,7 +563,7 @@ static int ath12k_ahb_config_ext_irq(struct ath12k_base *ab)
 	u32 num_irq;
 
 	ring_mask = ab->hw_params->ring_mask;
-	hal_ops = ab->hw_params->hal_ops;
+	hal_ops = ab->hal.hal_ops;
 	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		irq_grp = &ab->ext_irq_grp[i];
 		num_irq = 0;
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 5b255e7c0deb..167878e9964c 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -142,7 +142,7 @@ static int ath12k_dp_srng_calculate_msi_group(struct ath12k_base *ab,
 			grp_mask = &ab->hw_params->ring_mask->rx_wbm_rel[0];
 			ring_num = 0;
 		} else {
-			map = ab->hw_params->hal_ops->tcl_to_wbm_rbm_map;
+			map = ab->hal.hal_ops->tcl_to_wbm_rbm_map;
 			for (i = 0; i < ab->hw_params->max_tx_ring; i++) {
 				if (ring_num == map[i].wbm_ring_num) {
 					ring_num = i;
@@ -508,7 +508,7 @@ static int ath12k_dp_srng_common_setup(struct ath12k_base *ab)
 	}
 
 	for (i = 0; i < ab->hw_params->max_tx_ring; i++) {
-		map = ab->hw_params->hal_ops->tcl_to_wbm_rbm_map;
+		map = ab->hal.hal_ops->tcl_to_wbm_rbm_map;
 		tx_comp_ring_num = map[i].wbm_ring_num;
 
 		ret = ath12k_dp_srng_setup(ab, &dp->tx_ring[i].tcl_data_ring,
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index d2924fe46b4f..89ba9ad41417 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2052,7 +2052,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k_pdev_dp *dp_pdev,
 
 		rx_desc = (struct hal_rx_desc *)head_msdu->data;
 		hdr_desc =
-			ab->hw_params->hal_ops->rx_desc_get_msdu_payload(rx_desc);
+			ab->hal.hal_ops->rx_desc_get_msdu_payload(rx_desc);
 
 		/* Base size */
 		wh = (struct ieee80211_hdr_3addr *)hdr_desc;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 716623f83adc..0ecb96bc9054 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -109,27 +109,27 @@ static inline u16 ath12k_dp_rx_h_frag_no(struct ath12k_base *ab,
 static inline u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
 				      struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_l3_pad_bytes(desc);
+	return ab->hal.hal_ops->rx_desc_get_l3_pad_bytes(desc);
 }
 
 static inline void ath12k_dp_rx_desc_end_tlv_copy(struct ath12k_base *ab,
 						  struct hal_rx_desc *fdesc,
 						  struct hal_rx_desc *ldesc)
 {
-	ab->hw_params->hal_ops->rx_desc_copy_end_tlv(fdesc, ldesc);
+	ab->hal.hal_ops->rx_desc_copy_end_tlv(fdesc, ldesc);
 }
 
 static inline void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
 						 struct hal_rx_desc *desc,
 						 u16 len)
 {
-	ab->hw_params->hal_ops->rx_desc_set_msdu_len(desc, len);
+	ab->hal.hal_ops->rx_desc_set_msdu_len(desc, len);
 }
 
 static inline u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
 					      struct hal_rx_desc *rx_desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
+	return ab->hal.hal_ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
 }
 
 static inline bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
@@ -137,7 +137,7 @@ static inline bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 {
 	u32 tlv_tag;
 
-	tlv_tag = ab->hw_params->hal_ops->rx_desc_get_mpdu_start_tag(rx_desc);
+	tlv_tag = ab->hal.hal_ops->rx_desc_get_mpdu_start_tag(rx_desc);
 
 	return tlv_tag == HAL_RX_MPDU_START;
 }
@@ -146,7 +146,7 @@ static inline void ath12k_dp_rx_desc_get_dot11_hdr(struct ath12k_base *ab,
 						   struct hal_rx_desc *desc,
 						   struct ieee80211_hdr *hdr)
 {
-	ab->hw_params->hal_ops->rx_desc_get_dot11_hdr(desc, hdr);
+	ab->hal.hal_ops->rx_desc_get_dot11_hdr(desc, hdr);
 }
 
 static inline void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
@@ -154,13 +154,13 @@ static inline void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
 						       u8 *crypto_hdr,
 						       enum hal_encrypt_type enctype)
 {
-	ab->hw_params->hal_ops->rx_desc_get_crypto_header(desc, crypto_hdr, enctype);
+	ab->hal.hal_ops->rx_desc_get_crypto_header(desc, crypto_hdr, enctype);
 }
 
 static inline u8 ath12k_dp_rx_get_msdu_src_link(struct ath12k_base *ab,
 						struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_src_link_id(desc);
+	return ab->hal.hal_ops->rx_desc_get_msdu_src_link_id(desc);
 }
 
 static inline void ath12k_dp_clean_up_skb_list(struct sk_buff_head *skb_list)
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 87abacc8ae8e..338a4e5244dd 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -1105,7 +1105,7 @@ int ath12k_hal_srng_init(struct ath12k_base *ab)
 {
 	int ret;
 
-	ret = ab->hw_params->hal_ops->create_srng_config(ab);
+	ret = ab->hal.hal_ops->create_srng_config(ab);
 	if (ret)
 		goto err_hal;
 
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 4c3a5ec6ae83..4874bebc11f7 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1462,6 +1462,7 @@ struct ath12k_hal {
 		dma_addr_t paddr;
 	} wrp;
 
+	const struct hal_ops *hal_ops;
 	/* Available REO blocking resources bitmap */
 	u8 avail_blk_resource;
 
@@ -1579,6 +1580,7 @@ enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
 }
 
 struct ath12k_hw_version_map {
+	const struct hal_ops *hal_ops;
 	u32 hal_desc_sz;
 };
 
@@ -1603,9 +1605,6 @@ struct hal_ops {
 	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
 };
 
-extern const struct hal_ops hal_qcn9274_ops;
-extern const struct hal_ops hal_wcn7850_ops;
-
 u32 ath12k_wifi7_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
 void ath12k_wifi7_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
 				      int tid, u32 ba_window_size,
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 35d6900720fe..7e8f1f7ef584 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -193,8 +193,6 @@ struct ath12k_hw_params {
 	void (*wmi_init)(struct ath12k_base *ab,
 			 struct ath12k_wmi_resource_config_arg *config);
 
-	const struct hal_ops *hal_ops;
-
 	u64 qmi_cnss_feature_bitmap;
 
 	u32 rfkill_pin;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index 35709dfccbcf..ece6a1311ef0 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -50,6 +50,6 @@ void ath12k_wifi7_dp_extract_rx_desc_data(struct ath12k_base *ab,
 					  struct hal_rx_desc *rx_desc,
 					  struct hal_rx_desc *ldesc)
 {
-	ab->hw_params->hal_ops->extract_rx_desc_data(rx_info, rx_desc, ldesc);
+	ab->hal.hal_ops->extract_rx_desc_data(rx_info, rx_desc, ldesc);
 }
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index ab5824abfe75..036bacd704e9 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -107,7 +107,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 	ti.ring_id = ring_selector % ab->hw_params->max_tx_ring;
 
 	ring_map |= BIT(ti.ring_id);
-	ti.rbm_id = ab->hw_params->hal_ops->tcl_to_wbm_rbm_map[ti.ring_id].rbm_id;
+	ti.rbm_id = ab->hal.hal_ops->tcl_to_wbm_rbm_map[ti.ring_id].rbm_id;
 
 	tx_ring = &dp->tx_ring[ti.ring_id];
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index 4ad3ef3ba5e0..0e3930c8575a 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -7,18 +7,24 @@
 #include "hal_desc.h"
 #include "../hal.h"
 #include "hal.h"
+#include "hal_qcn9274.h"
+#include "hal_wcn7850.h"
 
 static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
 	[ATH12K_HW_QCN9274_HW10] = {
+		.hal_ops = &hal_qcn9274_ops,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
 	},
 	[ATH12K_HW_QCN9274_HW20] = {
+		.hal_ops = &hal_qcn9274_ops,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
 	},
 	[ATH12K_HW_WCN7850_HW20] = {
+		.hal_ops = &hal_wcn7850_ops,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn7850),
 	},
 	[ATH12K_HW_IPQ5332_HW10] = {
+		.hal_ops = &hal_qcn9274_ops,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
 	},
 };
@@ -29,6 +35,7 @@ int ath12k_wifi7_hal_init(struct ath12k_base *ab)
 
 	memset(hal, 0, sizeof(*hal));
 
+	hal->hal_ops = ath12k_wifi7_hw_ver_map[ab->hw_rev].hal_ops;
 	hal->hal_desc_sz = ath12k_wifi7_hw_ver_map[ab->hw_rev].hal_desc_sz;
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
index 1563854b5b6a..4d08292d8a7f 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
@@ -12,6 +12,7 @@
 #include "../hal.h"
 #include "hal_rx.h"
 
+extern const struct hal_ops hal_qcn9274_ops;
 extern const struct ath12k_hal_tcl_to_wbm_rbm_map
 ath12k_hal_qcn9274_tcl_to_wbm_rbm_map[DP_TCL_NUM_RING_MAX];
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
index 80de7ea522b5..8207e73602b3 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
@@ -10,6 +10,7 @@
 #include "../hal.h"
 #include "hal_rx.h"
 
+extern const struct hal_ops hal_wcn7850_ops;
 extern const struct ath12k_hal_tcl_to_wbm_rbm_map
 ath12k_hal_wcn7850_tcl_to_wbm_rbm_map[DP_TCL_NUM_RING_MAX];
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 621022064962..f469a829ae9a 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -758,8 +758,6 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 
 		.wmi_init = ath12k_wifi7_wmi_init_qcn9274,
 
-		.hal_ops = &hal_qcn9274_ops,
-
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
 
 		.rfkill_pin = 0,
@@ -847,8 +845,6 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 
 		.wmi_init = ath12k_wifi7_wmi_init_wcn7850,
 
-		.hal_ops = &hal_wcn7850_ops,
-
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01) |
 					   BIT(CNSS_PCIE_PERST_NO_PULL_V01),
 
@@ -934,8 +930,6 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 
 		.wmi_init = ath12k_wifi7_wmi_init_qcn9274,
 
-		.hal_ops = &hal_qcn9274_ops,
-
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
 
 		.rfkill_pin = 0,
@@ -1017,8 +1011,6 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 
 		.wmi_init = &ath12k_wifi7_wmi_init_qcn9274,
 
-		.hal_ops = &hal_qcn9274_ops,
-
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
 
 		.rfkill_pin = 0,
-- 
2.34.1


