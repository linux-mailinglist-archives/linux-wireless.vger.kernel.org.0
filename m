Return-Path: <linux-wireless+bounces-27105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DB6B4953A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 18:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48858164177
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7DA1DF26E;
	Mon,  8 Sep 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JxTus1sK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9630EF95
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348913; cv=none; b=O1rS8rkDf6UBx69qY0YSztcpe/+CR8NuVPMrySFyB52SxcCSadU9h44WWV5P4vIcTOcu+m4YHkFJIVcrIipa/MYNbuNJImtvumKmNAHaxUddBL0mCbMCbyAbKQPta68VByRyW1PMWZb2Ow/WS1xP5jlVMZPQu/5sMm9jEz2+xN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348913; c=relaxed/simple;
	bh=MmFQtyVVcRTENMUUecY4uKuM8D2jzd2M39jUSXou7lQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIsfyfCO6uQGgpKTaDdwkGvhe+q4VP2RRMtS6LUYWd9p/nBZB1hbXT38ud2ZvpIJDcbTzghMeEBBKsFwvzvuneBuiV04H3mSmGk+DxykYDtL+5V6Wk2NroguLM65RK26tojEIeUE8gzr65/3rJw8vq9hpmGg4GY7GmOQR6PMrYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JxTus1sK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58894ord013497;
	Mon, 8 Sep 2025 16:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L47GoqT7nAWiSjpo/IwoS8icnrBtMuxNW61JhSkxnjw=; b=JxTus1sK+MHz4pxV
	hBkT5elnzb+disUNIG2s50ofUNWqesVx3LmGKxRY8XzRksYbemnkMwFQS2CHhcMV
	KReNhRpiOmyayjW9gNkBPebcr9suC20ImQC7pbbFXvf5OcY3t3Nx7iB69rmX+mfy
	b08ep6Wo0Pa2ayufxHTevuQAfx9/ZsG1A3p4XXdwQxbVeLO6yn8HMnUqsB5v3bZh
	dKvEn83iJnQh6++qrWr59hzo/IttSENlht8bu8c+PL0UhU+focUk+aFvKFliL80t
	HBEgi4OqRfMXagJIkw1LvwVNSca27fGhTP+5cfyrLnbHwm2o6h+gHPnKnXRZzMxv
	lUu7Hw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0n8rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 16:28:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 588GSRTv029026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 16:28:27 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 8 Sep 2025 09:28:26 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 5/8] wifi: ath12k: Move hal_rx_ops callbacks to hal_ops
Date: Mon, 8 Sep 2025 21:57:54 +0530
Message-ID: <20250908162757.2938849-6-quic_rdeuri@quicinc.com>
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
X-Proofpoint-ORIG-GUID: shC7tFADsd20bcXmO4ivoR2XD8PlMdoj
X-Proofpoint-GUID: shC7tFADsd20bcXmO4ivoR2XD8PlMdoj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX8UGk8Q+bNVB2
 mcNuYBtbpWAn8hRD3DJtGqzvjUw2agt+h5riQz8Gj68ZzZT909P+uuUnlgKfvySlXyjESlFjf6Y
 rbW3UjJEZi/WRxvFYiKyOSJDT4teVFf+hLA4tpTtZXbiMjEosH6yWm4kVh9E+Fz6HOcAKf/QQIi
 YD5vvkowCArxu+BnzaGnyDtk1510Y0Jn3sG0F37Y6kQdycEoEUsyVPvo8U2thebYjyR7DLGotHi
 FxJggJ9hhOs6l4eoLdHmF2/sF5zH4bvX59jBnZ1dofXEjQajeAButpC2aTWl2SKC0fC6r+jsms4
 t0rGtzLeNUCJdsuB3jdgwI4s5J3Fyo5WChjwUPAGQjYnTZWQ55yoNQuqW0JqN+O1PZh7dOOZbbF
 t6QElczh
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68bf042c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=uGfbuUcNw5SBLKsPKdUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move the following callbacks from hal_rx_ops to hal_ops for use in
non-performance-critical paths:

rx_desc_set_msdu_len
rx_desc_get_dot11_hdr
rx_desc_get_crypto_header
rx_desc_copy_end_tlv
rx_desc_get_msdu_src_link_id
rx_desc_get_desc_size

hal_rx_ops currently includes callbacks used in both critical and
non-critical Rx paths. To reduce function pointer indirection in hot
path, performance-critical ops will be consolidated into a single
extraction API in a follow-up patch.

Begin cleanup by migrating non-performance-critical callbacks from
hal_rx_ops to hal_ops. Once the extraction API is in place, remove
hal_rx_ops entirely to simplify the HAL interface.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    |  2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h | 10 +++++-----
 drivers/net/wireless/ath/ath12k/hal.c   | 25 ++++++++++++-------------
 drivers/net/wireless/ath/ath12k/hal.h   | 20 ++++++++++----------
 4 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 83d41154c115..9dd602311433 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -897,7 +897,7 @@ void ath12k_dp_pdev_pre_alloc(struct ath12k *ar)
 
 void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab)
 {
-	ab->hal.hal_desc_sz = ab->hal_rx_ops->rx_desc_get_desc_size();
+	ab->hal.hal_desc_sz = ab->hw_params->hal_ops->rx_desc_get_desc_size();
 }
 
 int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 6f56a56db097..150f4b1dbfbb 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -269,14 +269,14 @@ static inline void ath12k_dp_rx_desc_end_tlv_copy(struct ath12k_base *ab,
 						  struct hal_rx_desc *fdesc,
 						  struct hal_rx_desc *ldesc)
 {
-	ab->hal_rx_ops->rx_desc_copy_end_tlv(fdesc, ldesc);
+	ab->hw_params->hal_ops->rx_desc_copy_end_tlv(fdesc, ldesc);
 }
 
 static inline void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
 						 struct hal_rx_desc *desc,
 						 u16 len)
 {
-	ab->hal_rx_ops->rx_desc_set_msdu_len(desc, len);
+	ab->hw_params->hal_ops->rx_desc_set_msdu_len(desc, len);
 }
 
 static inline u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
@@ -318,7 +318,7 @@ static inline void ath12k_dp_rx_desc_get_dot11_hdr(struct ath12k_base *ab,
 						   struct hal_rx_desc *desc,
 						   struct ieee80211_hdr *hdr)
 {
-	ab->hal_rx_ops->rx_desc_get_dot11_hdr(desc, hdr);
+	ab->hw_params->hal_ops->rx_desc_get_dot11_hdr(desc, hdr);
 }
 
 static inline void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
@@ -326,13 +326,13 @@ static inline void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
 						       u8 *crypto_hdr,
 						       enum hal_encrypt_type enctype)
 {
-	ab->hal_rx_ops->rx_desc_get_crypto_header(desc, crypto_hdr, enctype);
+	ab->hw_params->hal_ops->rx_desc_get_crypto_header(desc, crypto_hdr, enctype);
 }
 
 static inline u8 ath12k_dp_rx_get_msdu_src_link(struct ath12k_base *ab,
 						struct hal_rx_desc *desc)
 {
-	return ab->hal_rx_ops->rx_desc_get_msdu_src_link_id(desc);
+	return ab->hw_params->hal_ops->rx_desc_get_msdu_src_link_id(desc);
 }
 
 static inline void ath12k_dp_clean_up_skb_list(struct sk_buff_head *skb_list)
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 329c458d1fe2..60a4e5766f51 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -428,29 +428,28 @@ const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
 	.rx_desc_get_msdu_nss = ath12k_hal_rx_desc_get_msdu_nss_qcn9274,
 	.rx_desc_get_mpdu_tid = ath12k_hal_rx_desc_get_mpdu_tid_qcn9274,
 	.rx_desc_get_mpdu_peer_id = ath12k_hal_rx_desc_get_mpdu_peer_id_qcn9274,
-	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_qcn9274,
 	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
-	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_qcn9274,
 	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
 	.rx_desc_mac_addr2_valid = ath12k_hal_rx_desc_mac_addr2_valid_qcn9274,
 	.rx_desc_mpdu_start_addr2 = ath12k_hal_rx_desc_mpdu_start_addr2_qcn9274,
 	.rx_desc_is_da_mcbc = ath12k_hal_rx_desc_is_da_mcbc_qcn9274,
-	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_qcn9274,
-	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_qcn9274,
 	.dp_rx_h_msdu_done = ath12k_hal_rx_h_msdu_done_qcn9274,
 	.dp_rx_h_l4_cksum_fail = ath12k_hal_rx_h_l4_cksum_fail_qcn9274,
 	.dp_rx_h_ip_cksum_fail = ath12k_hal_rx_h_ip_cksum_fail_qcn9274,
 	.dp_rx_h_is_decrypted = ath12k_hal_rx_h_is_decrypted_qcn9274,
 	.dp_rx_h_mpdu_err = ath12k_hal_rx_h_mpdu_err_qcn9274,
-	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_qcn9274,
-	.rx_desc_get_msdu_src_link_id =
-		ath12k_hal_rx_desc_get_msdu_src_link_qcn9274,
 };
 EXPORT_SYMBOL(hal_rx_qcn9274_compact_ops);
 
 const struct hal_ops hal_qcn9274_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
 	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
+	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_qcn9274,
+	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_qcn9274,
+	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_qcn9274,
+	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_qcn9274,
+	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_qcn9274,
+	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_qcn9274,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
 
@@ -598,29 +597,29 @@ const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.rx_desc_get_msdu_nss = ath12k_hal_rx_desc_get_msdu_nss_wcn7850,
 	.rx_desc_get_mpdu_tid = ath12k_hal_rx_desc_get_mpdu_tid_wcn7850,
 	.rx_desc_get_mpdu_peer_id = ath12k_hal_rx_desc_get_mpdu_peer_id_wcn7850,
-	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_wcn7850,
 	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
 	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
-	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_wcn7850,
 	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
 	.rx_desc_mac_addr2_valid = ath12k_hal_rx_desc_mac_addr2_valid_wcn7850,
 	.rx_desc_mpdu_start_addr2 = ath12k_hal_rx_desc_mpdu_start_addr2_wcn7850,
 	.rx_desc_is_da_mcbc = ath12k_hal_rx_desc_is_da_mcbc_wcn7850,
-	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_wcn7850,
-	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_wcn7850,
 	.dp_rx_h_msdu_done = ath12k_hal_rx_h_msdu_done_wcn7850,
 	.dp_rx_h_l4_cksum_fail = ath12k_hal_rx_h_l4_cksum_fail_wcn7850,
 	.dp_rx_h_ip_cksum_fail = ath12k_hal_rx_h_ip_cksum_fail_wcn7850,
 	.dp_rx_h_is_decrypted = ath12k_hal_rx_h_is_decrypted_wcn7850,
 	.dp_rx_h_mpdu_err = ath12k_hal_rx_h_mpdu_err_wcn7850,
-	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_wcn7850,
-	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_wcn7850,
 };
 EXPORT_SYMBOL(hal_rx_wcn7850_ops);
 
 const struct hal_ops hal_wcn7850_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
 	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
+	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_wcn7850,
+	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_wcn7850,
+	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_wcn7850,
+	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_wcn7850,
+	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_wcn7850,
+	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_wcn7850,
 };
 EXPORT_SYMBOL(hal_wcn7850_ops);
 
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index ee0c22d65d2c..553d93dcc268 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1569,33 +1569,33 @@ struct hal_rx_ops {
 	u8 (*rx_desc_get_msdu_nss)(struct hal_rx_desc *desc);
 	u8 (*rx_desc_get_mpdu_tid)(struct hal_rx_desc *desc);
 	u16 (*rx_desc_get_mpdu_peer_id)(struct hal_rx_desc *desc);
-	void (*rx_desc_copy_end_tlv)(struct hal_rx_desc *fdesc,
-				     struct hal_rx_desc *ldesc);
 	u32 (*rx_desc_get_mpdu_start_tag)(struct hal_rx_desc *desc);
 	u32 (*rx_desc_get_mpdu_ppdu_id)(struct hal_rx_desc *desc);
-	void (*rx_desc_set_msdu_len)(struct hal_rx_desc *desc, u16 len);
 	struct rx_attention *(*rx_desc_get_attention)(struct hal_rx_desc *desc);
 	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
 	bool (*rx_desc_mac_addr2_valid)(struct hal_rx_desc *desc);
 	u8* (*rx_desc_mpdu_start_addr2)(struct hal_rx_desc *desc);
 	bool (*rx_desc_is_da_mcbc)(struct hal_rx_desc *desc);
-	void (*rx_desc_get_dot11_hdr)(struct hal_rx_desc *desc,
-				      struct ieee80211_hdr *hdr);
-	void (*rx_desc_get_crypto_header)(struct hal_rx_desc *desc,
-					  u8 *crypto_hdr,
-					  enum hal_encrypt_type enctype);
 	bool (*dp_rx_h_msdu_done)(struct hal_rx_desc *desc);
 	bool (*dp_rx_h_l4_cksum_fail)(struct hal_rx_desc *desc);
 	bool (*dp_rx_h_ip_cksum_fail)(struct hal_rx_desc *desc);
 	bool (*dp_rx_h_is_decrypted)(struct hal_rx_desc *desc);
 	u32 (*dp_rx_h_mpdu_err)(struct hal_rx_desc *desc);
-	u32 (*rx_desc_get_desc_size)(void);
-	u8 (*rx_desc_get_msdu_src_link_id)(struct hal_rx_desc *desc);
 };
 
 struct hal_ops {
 	int (*create_srng_config)(struct ath12k_base *ab);
 	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
+	void (*rx_desc_set_msdu_len)(struct hal_rx_desc *desc, u16 len);
+	void (*rx_desc_get_dot11_hdr)(struct hal_rx_desc *desc,
+				      struct ieee80211_hdr *hdr);
+	void (*rx_desc_get_crypto_header)(struct hal_rx_desc *desc,
+					  u8 *crypto_hdr,
+					  enum hal_encrypt_type enctype);
+	void (*rx_desc_copy_end_tlv)(struct hal_rx_desc *fdesc,
+				     struct hal_rx_desc *ldesc);
+	u8 (*rx_desc_get_msdu_src_link_id)(struct hal_rx_desc *desc);
+	u32 (*rx_desc_get_desc_size)(void);
 };
 
 extern const struct hal_ops hal_qcn9274_ops;
-- 
2.34.1


