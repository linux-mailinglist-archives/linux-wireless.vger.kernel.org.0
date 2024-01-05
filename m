Return-Path: <linux-wireless+bounces-1535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD2D825B4E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 20:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B305B21124
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5CA364AB;
	Fri,  5 Jan 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RuAPP4RT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961193608A
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405En27F027009;
	Fri, 5 Jan 2024 19:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=S86AcsUKv+7cFbxSrX8QJJSmRhXgvETXTCK2pggeLV4=; b=Ru
	APP4RTUKJNROyRutYggqxQs3wzhLeg1v8HDvAXyiEzRY0NZHwso4v5CnLUSrCIuR
	r0B+o9bYekDc6bXnRlzffMZnIxcJapbgD2LwM9oCks09hqsulP/eFFZdHRG07PDZ
	mJPGrWc7ZB+9JQrrSM1DfBed09NNvdS3AfeU6w+lKbdMjXAlkh9tNG6h/hRLPFEp
	+k2ESSTZ8ZfaPj9LCzjekmZlt4VBtZrYZuUl22qiLHEX2g5xGQ5s8EOL6AEG6RzM
	5o0IESZQREDFXlAGsEtA1LrdwNwrvpjpZCiTV8fY/spQj5WE1jMqa4FB3lIgEv6U
	rq9gfR4nO/iDpXQBo1jw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve94ra72g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 19:57:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405JvDbE008860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 19:57:13 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 5 Jan 2024 11:57:11 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 07/12] wifi: ath12k: split hal_ops to support RX TLVs word mask compaction
Date: Sat, 6 Jan 2024 01:26:34 +0530
Message-ID: <20240105195639.3217739-8-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
References: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ryW2Lycu7TIjUEthnL7Ea4lBSse4ZgYN
X-Proofpoint-GUID: ryW2Lycu7TIjUEthnL7Ea4lBSse4ZgYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050161

With word mask subscription support, the rx_desc structure will
change. The fields in this structure rx_desc will be reduced to only
the required fields. To make word mask subscription changes compatible
with the older firmware version (firmware that does not support word
mask subscription), two different structures of rx_desc will be
required for the same hardware.

Most of the hal_ops are directly related to rx_desc.

Hence, split hal_ops into operations that are independent of rx_desc
(hal_ops) and the operations that are directly dependent on rx_desc
(hal_rx_ops). These hal_rx_ops depend on both hardware and firmware
hence move them out of hw_params.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h   |  2 +
 drivers/net/wireless/ath/ath12k/dp_mon.c |  5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 75 ++++++++++++------------
 drivers/net/wireless/ath/ath12k/hal.c    | 18 ++++--
 drivers/net/wireless/ath/ath12k/hal.h    | 12 +++-
 drivers/net/wireless/ath/ath12k/pci.c    |  2 +
 6 files changed, 66 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 271a9e2afc59..36c9dcd57bdc 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -820,6 +820,8 @@ struct ath12k_base {
 		DECLARE_BITMAP(fw_features, ATH12K_FW_FEATURE_COUNT);
 	} fw;
 
+	const struct hal_rx_ops *hal_rx_ops;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index be4b39f5fa80..626aea73853a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "dp_mon.h"
@@ -917,7 +917,8 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 		u8 qos_pkt = 0;
 
 		rx_desc = (struct hal_rx_desc *)head_msdu->data;
-		hdr_desc = ab->hw_params->hal_ops->rx_desc_get_msdu_payload(rx_desc);
+		hdr_desc =
+			ab->hal_rx_ops->rx_desc_get_msdu_payload(rx_desc);
 
 		/* Base size */
 		wh = (struct ieee80211_hdr_3addr *)hdr_desc;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 1ee83f765929..0b819e45a624 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/ieee80211.h>
@@ -23,34 +23,34 @@
 static enum hal_encrypt_type ath12k_dp_rx_h_enctype(struct ath12k_base *ab,
 						    struct hal_rx_desc *desc)
 {
-	if (!ab->hw_params->hal_ops->rx_desc_encrypt_valid(desc))
+	if (!ab->hal_rx_ops->rx_desc_encrypt_valid(desc))
 		return HAL_ENCRYPT_TYPE_OPEN;
 
-	return ab->hw_params->hal_ops->rx_desc_get_encrypt_type(desc);
+	return ab->hal_rx_ops->rx_desc_get_encrypt_type(desc);
 }
 
 u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_decap_type(desc);
+	return ab->hal_rx_ops->rx_desc_get_decap_type(desc);
 }
 
 static u8 ath12k_dp_rx_h_mesh_ctl_present(struct ath12k_base *ab,
 					  struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mesh_ctl(desc);
+	return ab->hal_rx_ops->rx_desc_get_mesh_ctl(desc);
 }
 
 static bool ath12k_dp_rx_h_seq_ctrl_valid(struct ath12k_base *ab,
 					  struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_seq_ctl_vld(desc);
+	return ab->hal_rx_ops->rx_desc_get_mpdu_seq_ctl_vld(desc);
 }
 
 static bool ath12k_dp_rx_h_fc_valid(struct ath12k_base *ab,
 				    struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_fc_valid(desc);
+	return ab->hal_rx_ops->rx_desc_get_mpdu_fc_valid(desc);
 }
 
 static bool ath12k_dp_rx_h_more_frags(struct ath12k_base *ab,
@@ -74,149 +74,149 @@ static u16 ath12k_dp_rx_h_frag_no(struct ath12k_base *ab,
 static u16 ath12k_dp_rx_h_seq_no(struct ath12k_base *ab,
 				 struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_start_seq_no(desc);
+	return ab->hal_rx_ops->rx_desc_get_mpdu_start_seq_no(desc);
 }
 
 static bool ath12k_dp_rx_h_msdu_done(struct ath12k_base *ab,
 				     struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->dp_rx_h_msdu_done(desc);
+	return ab->hal_rx_ops->dp_rx_h_msdu_done(desc);
 }
 
 static bool ath12k_dp_rx_h_l4_cksum_fail(struct ath12k_base *ab,
 					 struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->dp_rx_h_l4_cksum_fail(desc);
+	return ab->hal_rx_ops->dp_rx_h_l4_cksum_fail(desc);
 }
 
 static bool ath12k_dp_rx_h_ip_cksum_fail(struct ath12k_base *ab,
 					 struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->dp_rx_h_ip_cksum_fail(desc);
+	return ab->hal_rx_ops->dp_rx_h_ip_cksum_fail(desc);
 }
 
 static bool ath12k_dp_rx_h_is_decrypted(struct ath12k_base *ab,
 					struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->dp_rx_h_is_decrypted(desc);
+	return ab->hal_rx_ops->dp_rx_h_is_decrypted(desc);
 }
 
 u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
 			    struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->dp_rx_h_mpdu_err(desc);
+	return ab->hal_rx_ops->dp_rx_h_mpdu_err(desc);
 }
 
 static u16 ath12k_dp_rx_h_msdu_len(struct ath12k_base *ab,
 				   struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_len(desc);
+	return ab->hal_rx_ops->rx_desc_get_msdu_len(desc);
 }
 
 static u8 ath12k_dp_rx_h_sgi(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_sgi(desc);
+	return ab->hal_rx_ops->rx_desc_get_msdu_sgi(desc);
 }
 
 static u8 ath12k_dp_rx_h_rate_mcs(struct ath12k_base *ab,
 				  struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_rate_mcs(desc);
+	return ab->hal_rx_ops->rx_desc_get_msdu_rate_mcs(desc);
 }
 
 static u8 ath12k_dp_rx_h_rx_bw(struct ath12k_base *ab,
 			       struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_rx_bw(desc);
+	return ab->hal_rx_ops->rx_desc_get_msdu_rx_bw(desc);
 }
 
 static u32 ath12k_dp_rx_h_freq(struct ath12k_base *ab,
 			       struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_freq(desc);
+	return ab->hal_rx_ops->rx_desc_get_msdu_freq(desc);
 }
 
 static u8 ath12k_dp_rx_h_pkt_type(struct ath12k_base *ab,
 				  struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_msdu_pkt_type(desc);
+	return ab->hal_rx_ops->rx_desc_get_msdu_pkt_type(desc);
 }
 
 static u8 ath12k_dp_rx_h_nss(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc)
 {
-	return hweight8(ab->hw_params->hal_ops->rx_desc_get_msdu_nss(desc));
+	return hweight8(ab->hal_rx_ops->rx_desc_get_msdu_nss(desc));
 }
 
 static u8 ath12k_dp_rx_h_tid(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_tid(desc);
+	return ab->hal_rx_ops->rx_desc_get_mpdu_tid(desc);
 }
 
 static u16 ath12k_dp_rx_h_peer_id(struct ath12k_base *ab,
 				  struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_peer_id(desc);
+	return ab->hal_rx_ops->rx_desc_get_mpdu_peer_id(desc);
 }
 
 u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
 			struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_l3_pad_bytes(desc);
+	return ab->hal_rx_ops->rx_desc_get_l3_pad_bytes(desc);
 }
 
 static bool ath12k_dp_rx_h_first_msdu(struct ath12k_base *ab,
 				      struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_first_msdu(desc);
+	return ab->hal_rx_ops->rx_desc_get_first_msdu(desc);
 }
 
 static bool ath12k_dp_rx_h_last_msdu(struct ath12k_base *ab,
 				     struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_last_msdu(desc);
+	return ab->hal_rx_ops->rx_desc_get_last_msdu(desc);
 }
 
 static void ath12k_dp_rx_desc_end_tlv_copy(struct ath12k_base *ab,
 					   struct hal_rx_desc *fdesc,
 					   struct hal_rx_desc *ldesc)
 {
-	ab->hw_params->hal_ops->rx_desc_copy_end_tlv(fdesc, ldesc);
+	ab->hal_rx_ops->rx_desc_copy_end_tlv(fdesc, ldesc);
 }
 
 static void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
 					  struct hal_rx_desc *desc,
 					  u16 len)
 {
-	ab->hw_params->hal_ops->rx_desc_set_msdu_len(desc, len);
+	ab->hal_rx_ops->rx_desc_set_msdu_len(desc, len);
 }
 
 static bool ath12k_dp_rx_h_is_da_mcbc(struct ath12k_base *ab,
 				      struct hal_rx_desc *desc)
 {
 	return (ath12k_dp_rx_h_first_msdu(ab, desc) &&
-		ab->hw_params->hal_ops->rx_desc_is_da_mcbc(desc));
+		ab->hal_rx_ops->rx_desc_is_da_mcbc(desc));
 }
 
 static bool ath12k_dp_rxdesc_mac_addr2_valid(struct ath12k_base *ab,
 					     struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_mac_addr2_valid(desc);
+	return ab->hal_rx_ops->rx_desc_mac_addr2_valid(desc);
 }
 
 static u8 *ath12k_dp_rxdesc_get_mpdu_start_addr2(struct ath12k_base *ab,
 						 struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_mpdu_start_addr2(desc);
+	return ab->hal_rx_ops->rx_desc_mpdu_start_addr2(desc);
 }
 
 static void ath12k_dp_rx_desc_get_dot11_hdr(struct ath12k_base *ab,
 					    struct hal_rx_desc *desc,
 					    struct ieee80211_hdr *hdr)
 {
-	ab->hw_params->hal_ops->rx_desc_get_dot11_hdr(desc, hdr);
+	ab->hal_rx_ops->rx_desc_get_dot11_hdr(desc, hdr);
 }
 
 static void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
@@ -224,13 +224,14 @@ static void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
 						u8 *crypto_hdr,
 						enum hal_encrypt_type enctype)
 {
-	ab->hw_params->hal_ops->rx_desc_get_crypto_header(desc, crypto_hdr, enctype);
+	ab->hal_rx_ops->rx_desc_get_crypto_header(desc, crypto_hdr,
+								  enctype);
 }
 
 static u16 ath12k_dp_rxdesc_get_mpdu_frame_ctrl(struct ath12k_base *ab,
 						struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_get_mpdu_frame_ctl(desc);
+	return ab->hal_rx_ops->rx_desc_get_mpdu_frame_ctl(desc);
 }
 
 static int ath12k_dp_purge_mon_ring(struct ath12k_base *ab)
@@ -3935,9 +3936,9 @@ int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
 	tlv_filter.rx_packet_offset = hal_rx_desc_sz;
 
 	tlv_filter.rx_mpdu_start_offset =
-			ab->hw_params->hal_ops->rx_desc_get_mpdu_start_offset();
+		ab->hal_rx_ops->rx_desc_get_mpdu_start_offset();
 	tlv_filter.rx_msdu_end_offset =
-		ab->hw_params->hal_ops->rx_desc_get_msdu_end_offset();
+		ab->hal_rx_ops->rx_desc_get_msdu_end_offset();
 
 	/* TODO: Selectively subscribe to required qwords within msdu_end
 	 * and mpdu_start and setup the mask in below msg
@@ -3973,9 +3974,9 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 	tlv_filter.rx_header_offset = offsetof(struct hal_rx_desc_wcn7850, pkt_hdr_tlv);
 
 	tlv_filter.rx_mpdu_start_offset =
-			ab->hw_params->hal_ops->rx_desc_get_mpdu_start_offset();
+		ab->hal_rx_ops->rx_desc_get_mpdu_start_offset();
 	tlv_filter.rx_msdu_end_offset =
-		ab->hw_params->hal_ops->rx_desc_get_msdu_end_offset();
+		ab->hal_rx_ops->rx_desc_get_msdu_end_offset();
 
 	/* TODO: Selectively subscribe to required qwords within msdu_end
 	 * and mpdu_start and setup the mask in below msg
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 1bdab8604db9..b6b8298a2bdc 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -680,7 +680,7 @@ static u32 ath12k_hw_qcn9274_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
 	return errmap;
 }
 
-const struct hal_ops hal_qcn9274_ops = {
+const struct hal_rx_ops hal_rx_qcn9274_ops = {
 	.rx_desc_get_first_msdu = ath12k_hw_qcn9274_rx_desc_get_first_msdu,
 	.rx_desc_get_last_msdu = ath12k_hw_qcn9274_rx_desc_get_last_msdu,
 	.rx_desc_get_l3_pad_bytes = ath12k_hw_qcn9274_rx_desc_get_l3_pad_bytes,
@@ -712,8 +712,6 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_desc_get_dot11_hdr = ath12k_hw_qcn9274_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_qcn9274_rx_desc_get_crypto_hdr,
 	.rx_desc_get_mpdu_frame_ctl = ath12k_hw_qcn9274_rx_desc_get_mpdu_frame_ctl,
-	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
-	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
 	.dp_rx_h_msdu_done = ath12k_hw_qcn9274_dp_rx_h_msdu_done,
 	.dp_rx_h_l4_cksum_fail = ath12k_hw_qcn9274_dp_rx_h_l4_cksum_fail,
 	.dp_rx_h_ip_cksum_fail = ath12k_hw_qcn9274_dp_rx_h_ip_cksum_fail,
@@ -721,6 +719,11 @@ const struct hal_ops hal_qcn9274_ops = {
 	.dp_rx_h_mpdu_err = ath12k_hw_qcn9274_dp_rx_h_mpdu_err,
 };
 
+const struct hal_ops hal_qcn9274_ops = {
+	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
+	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
+};
+
 static bool ath12k_hw_wcn7850_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
 {
 	return !!le16_get_bits(desc->u.wcn7850.msdu_end.info5,
@@ -1134,7 +1137,7 @@ static u32 ath12k_hw_wcn7850_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
 	return errmap;
 }
 
-const struct hal_ops hal_wcn7850_ops = {
+const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.rx_desc_get_first_msdu = ath12k_hw_wcn7850_rx_desc_get_first_msdu,
 	.rx_desc_get_last_msdu = ath12k_hw_wcn7850_rx_desc_get_last_msdu,
 	.rx_desc_get_l3_pad_bytes = ath12k_hw_wcn7850_rx_desc_get_l3_pad_bytes,
@@ -1167,8 +1170,6 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_desc_get_dot11_hdr = ath12k_hw_wcn7850_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_wcn7850_rx_desc_get_crypto_hdr,
 	.rx_desc_get_mpdu_frame_ctl = ath12k_hw_wcn7850_rx_desc_get_mpdu_frame_ctl,
-	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
-	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
 	.dp_rx_h_msdu_done = ath12k_hw_wcn7850_dp_rx_h_msdu_done,
 	.dp_rx_h_l4_cksum_fail = ath12k_hw_wcn7850_dp_rx_h_l4_cksum_fail,
 	.dp_rx_h_ip_cksum_fail = ath12k_hw_wcn7850_dp_rx_h_ip_cksum_fail,
@@ -1176,6 +1177,11 @@ const struct hal_ops hal_wcn7850_ops = {
 	.dp_rx_h_mpdu_err = ath12k_hw_wcn7850_dp_rx_h_mpdu_err,
 };
 
+const struct hal_ops hal_wcn7850_ops = {
+	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
+	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
+};
+
 static int ath12k_hal_alloc_cont_rdp(struct ath12k_base *ab)
 {
 	struct ath12k_hal *hal = &ab->hal;
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index fc47e7e6b498..33dedfbb3964 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HAL_H
@@ -1031,7 +1031,7 @@ struct ath12k_hal_tcl_to_wbm_rbm_map  {
 	u8 rbm_id;
 };
 
-struct hal_ops {
+struct hal_rx_ops {
 	bool (*rx_desc_get_first_msdu)(struct hal_rx_desc *desc);
 	bool (*rx_desc_get_last_msdu)(struct hal_rx_desc *desc);
 	u8 (*rx_desc_get_l3_pad_bytes)(struct hal_rx_desc *desc);
@@ -1070,18 +1070,24 @@ struct hal_ops {
 	void (*rx_desc_get_crypto_header)(struct hal_rx_desc *desc,
 					  u8 *crypto_hdr,
 					  enum hal_encrypt_type enctype);
-	int (*create_srng_config)(struct ath12k_base *ab);
 	bool (*dp_rx_h_msdu_done)(struct hal_rx_desc *desc);
 	bool (*dp_rx_h_l4_cksum_fail)(struct hal_rx_desc *desc);
 	bool (*dp_rx_h_ip_cksum_fail)(struct hal_rx_desc *desc);
 	bool (*dp_rx_h_is_decrypted)(struct hal_rx_desc *desc);
 	u32 (*dp_rx_h_mpdu_err)(struct hal_rx_desc *desc);
+};
+
+struct hal_ops {
+	int (*create_srng_config)(struct ath12k_base *ab);
 	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
 };
 
 extern const struct hal_ops hal_qcn9274_ops;
 extern const struct hal_ops hal_wcn7850_ops;
 
+extern const struct hal_rx_ops hal_rx_qcn9274_ops;
+extern const struct hal_rx_ops hal_rx_wcn7850_ops;
+
 u32 ath12k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
 void ath12k_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
 				int tid, u32 ba_window_size,
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 7a0ed7c9f5a2..d334f41f9658 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1361,6 +1361,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		ab_pci->msi_config = &ath12k_msi_config[0];
 		ab->static_window_map = true;
 		ab_pci->pci_ops = &ath12k_pci_ops_qcn9274;
+		ab->hal_rx_ops = &hal_rx_qcn9274_ops;
 		ath12k_pci_read_hw_version(ab, &soc_hw_version_major,
 					   &soc_hw_version_minor);
 		switch (soc_hw_version_major) {
@@ -1383,6 +1384,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		ab_pci->msi_config = &ath12k_msi_config[0];
 		ab->static_window_map = false;
 		ab_pci->pci_ops = &ath12k_pci_ops_wcn7850;
+		ab->hal_rx_ops = &hal_rx_wcn7850_ops;
 		ath12k_pci_read_hw_version(ab, &soc_hw_version_major,
 					   &soc_hw_version_minor);
 		switch (soc_hw_version_major) {
-- 
2.34.1


