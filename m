Return-Path: <linux-wireless+bounces-27106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84867B4953B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 18:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3A017939E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A564E30DD26;
	Mon,  8 Sep 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oOYSGjSa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3230EF95
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348916; cv=none; b=LRQMqnF6FgQQ1DTTsEaqahhzaiukC+pCylDphNXTfYk64hOQeCCtnPnjQF6hZmDXM88jaKXEIlmF8XTThphqtxDtYpKxE6Y9nwt7AgqoVVKaIpLSgy/fOj1IBN94OBEOXHDLTuffmFhyOqTRJO5ht7cw0bgd8gCgxOa9xlMmYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348916; c=relaxed/simple;
	bh=p1m07JWfjpdzOhVsF/ZAAYEQPSRB5wptWP8kADH+H9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3J+k4rL5J2inpiCfJOcqYEWP1XWokkaLyeC+waVTo5KVECCTkszxhuQv2ijVWrcow0bHxqbiaLDJeVgFY1+wT0ogj82vdxTXJF/YAH0le0SbKWjxXxCmxjSCDT8h66PgfGYL3hgguS3s8V6bW0S7h/cBtOD1hRmY+5KdHpWXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oOYSGjSa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588G5HBW012802;
	Mon, 8 Sep 2025 16:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M4tb9jgoSTAWNVJ4ni6sCCTs6UQW8N/0CIqnFFOz3eo=; b=oOYSGjSa/gMInori
	GkDcgikqnl/SrJm+yvvpbUZ2N7HL+6mDMLDH/83n1abqXuk5XAjZ2ACEyx7WftWs
	bPLQ34INk30aEIsAALjchCF3Dp5eY8aVPxw8m7COXu3gdI02kGECpTrpbyMlYFo7
	Kpe2ptQKpoKUFbWoVGbC3Pd8tmBomXGF7fdXXy52hKT4ZS0RGsnqyQ4VsNWE8BQ3
	DqhA+nCyRQccHeRGbZTas3AX5FVR0J15klt3w9a5OuE0bgMgC+pxtdilLWb207fD
	/uNrbKC1n9HI1OAUYWDuZx2C+OjMyUTnpg1DBLCo3g5hqjd92frokg27v0wxVqRD
	d6gOZQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws5c2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 16:28:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 588GSVEB004585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 16:28:31 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 8 Sep 2025 09:28:29 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 7/8] wifi: ath12k: Remove hal_rx_ops and merge into hal_ops
Date: Mon, 8 Sep 2025 21:57:56 +0530
Message-ID: <20250908162757.2938849-8-quic_rdeuri@quicinc.com>
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
X-Proofpoint-ORIG-GUID: DPXMpNstI_AaDTCXxNEyzvx3HK_EjRja
X-Proofpoint-GUID: DPXMpNstI_AaDTCXxNEyzvx3HK_EjRja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfXx7sBXu0l2Kv9
 trHwT+ts6TqG1WqcKADfp0SnoA5lDjQA5ffJ/MWv8UD05/C2Hv3VEy3YCK+ToAExVIGLJ7V47xV
 /5UHmtXTyj5naG6AV3ahCsWnYuXfcdRg0D6kNyW4kwGsDYTFkHpSciThK86R030bIQL4mLjpHsG
 e8zvqVLALrSATkbIy5PxZdveXS0gmUrMDem5eGv8YUpleEBRVYR7QaCR3WaVYxPCpHS5n6jiFxY
 3vjqQOy1yPI15iJheDLvNQhNpjuKz6N87PdlmgrXkj+6Wu7ZQGbB3zl4gOLuSMjHn4aHSeq4isW
 n6HrPRFKBv1195R7HpORVH/Q0tUGpF8KqfeExBZxsfOHsVAA8B2kT2zl3lGkMJcgrcMOrFi14wj
 s20xhLIt
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68bf042f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=u5Y36L8z59rl5QDsvE8A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

Move following ops from hal_rx_ops to hal_ops to simplify the HAL interface.

rx_desc_get_l3_pad_bytes
rx_desc_get_mpdu_start_tag
rx_desc_get_mpdu_ppdu_id
rx_desc_get_msdu_payload

Remove the compact_ops as they become unused with this change.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h      |  2 --
 drivers/net/wireless/ath/ath12k/dp_mon.c    |  2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h     |  6 +++---
 drivers/net/wireless/ath/ath12k/hal.c       | 22 +++++++--------------
 drivers/net/wireless/ath/ath12k/hal.h       | 14 ++++---------
 drivers/net/wireless/ath/ath12k/wifi7/pci.c |  2 --
 6 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index b68f063283fe..9ae98556dd94 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1196,8 +1196,6 @@ struct ath12k_base {
 		bool fw_features_valid;
 	} fw;
 
-	const struct hal_rx_ops *hal_rx_ops;
-
 	struct completion restart_completed;
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 0ae500ec3463..3315a9e3d40a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2046,7 +2046,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 
 		rx_desc = (struct hal_rx_desc *)head_msdu->data;
 		hdr_desc =
-			ab->hal_rx_ops->rx_desc_get_msdu_payload(rx_desc);
+			ab->hw_params->hal_ops->rx_desc_get_msdu_payload(rx_desc);
 
 		/* Base size */
 		wh = (struct ieee80211_hdr_3addr *)hdr_desc;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 432707d60fca..ff214bff389b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -109,7 +109,7 @@ static inline u16 ath12k_dp_rx_h_frag_no(struct ath12k_base *ab,
 static inline u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
 				      struct hal_rx_desc *desc)
 {
-	return ab->hal_rx_ops->rx_desc_get_l3_pad_bytes(desc);
+	return ab->hw_params->hal_ops->rx_desc_get_l3_pad_bytes(desc);
 }
 
 static inline void ath12k_dp_rx_desc_end_tlv_copy(struct ath12k_base *ab,
@@ -129,7 +129,7 @@ static inline void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
 static inline u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
 					      struct hal_rx_desc *rx_desc)
 {
-	return ab->hal_rx_ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
+	return ab->hw_params->hal_ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
 }
 
 static inline bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
@@ -137,7 +137,7 @@ static inline bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 {
 	u32 tlv_tag;
 
-	tlv_tag = ab->hal_rx_ops->rx_desc_get_mpdu_start_tag(rx_desc);
+	tlv_tag = ab->hw_params->hal_ops->rx_desc_get_mpdu_start_tag(rx_desc);
 
 	return tlv_tag == HAL_RX_MPDU_START;
 }
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index db6294ba6771..a14a7d8dc69f 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -406,13 +406,6 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 	return 0;
 }
 
-const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
-	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274,
-	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
-	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
-};
-EXPORT_SYMBOL(hal_rx_qcn9274_compact_ops);
-
 const struct hal_ops hal_qcn9274_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
 	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
@@ -423,6 +416,9 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_qcn9274,
 	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_qcn9274,
 	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_qcn9274,
+	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274,
+	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
+	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
 
@@ -550,14 +546,6 @@ static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 	return 0;
 }
 
-const struct hal_rx_ops hal_rx_wcn7850_ops = {
-	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850,
-	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
-	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
-	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
-};
-EXPORT_SYMBOL(hal_rx_wcn7850_ops);
-
 const struct hal_ops hal_wcn7850_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
 	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
@@ -568,6 +556,10 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_wcn7850,
 	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_wcn7850,
 	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_wcn7850,
+	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850,
+	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
+	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
+	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
 };
 EXPORT_SYMBOL(hal_wcn7850_ops);
 
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 37593bb7953b..692d495d01c9 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1578,13 +1578,6 @@ enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
 	return ret;
 }
 
-struct hal_rx_ops {
-	u8 (*rx_desc_get_l3_pad_bytes)(struct hal_rx_desc *desc);
-	u32 (*rx_desc_get_mpdu_start_tag)(struct hal_rx_desc *desc);
-	u32 (*rx_desc_get_mpdu_ppdu_id)(struct hal_rx_desc *desc);
-	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
-};
-
 struct hal_ops {
 	int (*create_srng_config)(struct ath12k_base *ab);
 	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
@@ -1601,14 +1594,15 @@ struct hal_ops {
 				     struct hal_rx_desc *rx_desc,
 				     struct hal_rx_desc *ldesc);
 	u32 (*rx_desc_get_desc_size)(void);
+	u32 (*rx_desc_get_mpdu_start_tag)(struct hal_rx_desc *desc);
+	u32 (*rx_desc_get_mpdu_ppdu_id)(struct hal_rx_desc *desc);
+	u8 (*rx_desc_get_l3_pad_bytes)(struct hal_rx_desc *desc);
+	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
 };
 
 extern const struct hal_ops hal_qcn9274_ops;
 extern const struct hal_ops hal_wcn7850_ops;
 
-extern const struct hal_rx_ops hal_rx_qcn9274_compact_ops;
-extern const struct hal_rx_ops hal_rx_wcn7850_ops;
-
 u32 ath12k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
 void ath12k_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
 				int tid, u32 ba_window_size,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/pci.c b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
index abdb3b8ff658..ba8c19c24ae6 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/pci.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
@@ -101,7 +101,6 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
 		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
 		ab->static_window_map = true;
 		ab_pci->pci_ops = &ath12k_wifi7_pci_ops_qcn9274;
-		ab->hal_rx_ops = &hal_rx_qcn9274_compact_ops;
 		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
 						 &soc_hw_version_minor);
 		ab->target_mem_mode = ath12k_core_get_memory_mode(ab);
@@ -124,7 +123,6 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
 		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
 		ab->static_window_map = false;
 		ab_pci->pci_ops = &ath12k_wifi7_pci_ops_wcn7850;
-		ab->hal_rx_ops = &hal_rx_wcn7850_ops;
 		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
 						 &soc_hw_version_minor);
 		ab->target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;
-- 
2.34.1


