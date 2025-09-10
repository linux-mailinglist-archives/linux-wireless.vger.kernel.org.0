Return-Path: <linux-wireless+bounces-27227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8E0B52011
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 20:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5863ABF11
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 18:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A3033EAE1;
	Wed, 10 Sep 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dk3yhKwx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74733CE86
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528081; cv=none; b=e2iVLZ8F0GmOGqpviny0mzzmckuPOeC+4H+BPN1/s7sg5HTzNCFoDQ8srg7wbh6ITtqpPIT8nEkkmzkYoncWNP7PAIJaDgEJHmCiNA4Df9Zh0HB2b122bMqZX1t9DyzVn8hAS8oPGmSAfX5hfUL7wLDMekrdrwcZwTywouxl7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528081; c=relaxed/simple;
	bh=cMqhtuCm1Z3hwkDQBO3H3FWowqGSpdspEAKooNbMTv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRTctXSKolxmdGEPHwxlDBoEsSsgDftsl5FIJAEhV1f9irczoDi/r99jf2holqH8zk4dbhHgylZj2NIJNOLKD9si+DRtJA7gzVc9aU/sGJh4T/z3cjzoUzJi/MDF9kwMREVIzIVrMga88sk93CSJ9WvUpiE/SFyw1G496nQqeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dk3yhKwx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgT76003898;
	Wed, 10 Sep 2025 18:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NW31VUPQlUKVqwRmJvkhSFzrfhSIE2JzeZVhyK9He6M=; b=Dk3yhKwxSL2g6ZU3
	fQCuV3IbUFHxTB8MJdowGXq1aUbFJNArBWuNLj5nVfAF+iXOpCm/+scAZMfGbE4Q
	w62KlbKd5aVo82wmz/TdbxvkC37FSzL0y9ohQifNs5Zt2vnFLtjgIcjgzmPVHFgq
	F8hUALKiBJN+vY6BXOE15vtPMsLzmyuP58Gm5uMT0cMjMjCh8pBtRWE2zTYmSFDZ
	NkZ57eIFQwSW1v0OCEEs8dm2tnSU4KHJEla9LuAlx3a+2WZsNZ8rBR02Ch6D43ba
	cbXHlIlkfdBM+qtYohfLRG6CcxsYeRyh7T/0bRiqMRsUdbPi81lxddBXYgT+FUuv
	NKpFog==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg4nkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 18:14:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58AIEZHW000311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 18:14:35 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 10 Sep 2025 11:14:34 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng v2 3/8] wifi: ath12k: unify HAL ops naming across chips
Date: Wed, 10 Sep 2025 23:44:09 +0530
Message-ID: <20250910181414.2062280-4-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910181414.2062280-1-quic_rdeuri@quicinc.com>
References: <20250910181414.2062280-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-ORIG-GUID: zarJMYtZlqvWx3ha4dxwkEeHyRAaEPRu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfXzcFnrV/o2Igl
 FXfepPRzR6i8oeTdCeS+pzTg33sZNQaE5ol7fFdffmbfxqggyZ0X3swx+MpwzZ32Emx4BIsBI2O
 YbeAkyDHRlfEDSHT4oNNTYLS7hROopQ8+bExHgHFhZVDvFtAp2b/epqZ8RG8uopRfzRCgGznPLq
 IvwujV7bfNK7Qg4JicpGvnHgOQBbZqTSPe/rhD0rkihjqetcZZqJHCdLlFxtM3ufoppUWbsCjjB
 Dzsat3hq7Ggcw5uFYpM1Z+KR67VFurnRUR1w07aYJ5xpSVI17e7EctnX9evByBhBUFhcQ9iDqjL
 I5ojpwHRWAiY3AaPaiw5tTngpDOoFd8Tbb5T6+pJXUSoMrDiBiMAiQk+QIMt1A1L/WaAx8bnWPn
 5ocAx2bc
X-Proofpoint-GUID: zarJMYtZlqvWx3ha4dxwkEeHyRAaEPRu
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c1c00c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=wNpPi5G-192g07xaMP4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

Rename HAL ops to follow a consistent hal ops format:
ath12k_hal_rx_xxxx_<chip>.

Remove "compact" references as non-compacts variant is no longer used.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c         | 154 +++++++++---------
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  86 +++++-----
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |  86 +++++-----
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  84 +++++-----
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |  84 +++++-----
 5 files changed, 247 insertions(+), 247 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 77024c99d0bf..1fba023d0859 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -407,56 +407,56 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 }
 
 const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
-	.rx_desc_get_first_msdu = ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu,
-	.rx_desc_get_last_msdu = ath12k_hw_qcn9274_compact_rx_desc_get_last_msdu,
-	.rx_desc_get_l3_pad_bytes = ath12k_hw_qcn9274_compact_rx_desc_get_l3_pad_bytes,
-	.rx_desc_encrypt_valid = ath12k_hw_qcn9274_compact_rx_desc_encrypt_valid,
-	.rx_desc_get_encrypt_type = ath12k_hw_qcn9274_compact_rx_desc_get_encrypt_type,
-	.rx_desc_get_decap_type = ath12k_hw_qcn9274_compact_rx_desc_get_decap_type,
-	.rx_desc_get_mesh_ctl = ath12k_hw_qcn9274_compact_rx_desc_get_mesh_ctl,
+	.rx_desc_get_first_msdu = ath12k_hal_rx_desc_get_first_msdu_qcn9274,
+	.rx_desc_get_last_msdu = ath12k_hal_rx_desc_get_last_msdu_qcn9274,
+	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274,
+	.rx_desc_encrypt_valid = ath12k_hal_rx_desc_encrypt_valid_qcn9274,
+	.rx_desc_get_encrypt_type = ath12k_hal_rx_desc_get_encrypt_type_qcn9274,
+	.rx_desc_get_decap_type = ath12k_hal_rx_desc_get_decap_type_qcn9274,
+	.rx_desc_get_mesh_ctl = ath12k_hal_rx_desc_get_mesh_ctl_qcn9274,
 	.rx_desc_get_mpdu_seq_ctl_vld =
-		ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_seq_ctl_vld,
-	.rx_desc_get_mpdu_fc_valid = ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_fc_valid,
+		ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_qcn9274,
+	.rx_desc_get_mpdu_fc_valid = ath12k_hal_rx_desc_get_mpdu_fc_valid_qcn9274,
 	.rx_desc_get_mpdu_start_seq_no =
-		ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_seq_no,
-	.rx_desc_get_msdu_len = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_len,
-	.rx_desc_get_msdu_sgi = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_sgi,
-	.rx_desc_get_msdu_rate_mcs = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rate_mcs,
-	.rx_desc_get_msdu_rx_bw = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rx_bw,
-	.rx_desc_get_msdu_freq = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_freq,
-	.rx_desc_get_msdu_pkt_type = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_pkt_type,
-	.rx_desc_get_msdu_nss = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_nss,
-	.rx_desc_get_mpdu_tid = ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_tid,
-	.rx_desc_get_mpdu_peer_id = ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_peer_id,
-	.rx_desc_copy_end_tlv = ath12k_hw_qcn9274_compact_rx_desc_copy_end_tlv,
-	.rx_desc_get_mpdu_ppdu_id = ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_ppdu_id,
-	.rx_desc_set_msdu_len = ath12k_hw_qcn9274_compact_rx_desc_set_msdu_len,
-	.rx_desc_get_msdu_payload = ath12k_hw_qcn9274_compact_rx_desc_get_msdu_payload,
+		ath12k_hal_rx_desc_get_mpdu_start_seq_no_qcn9274,
+	.rx_desc_get_msdu_len = ath12k_hal_rx_desc_get_msdu_len_qcn9274,
+	.rx_desc_get_msdu_sgi = ath12k_hal_rx_desc_get_msdu_sgi_qcn9274,
+	.rx_desc_get_msdu_rate_mcs = ath12k_hal_rx_desc_get_msdu_rate_mcs_qcn9274,
+	.rx_desc_get_msdu_rx_bw = ath12k_hal_rx_desc_get_msdu_rx_bw_qcn9274,
+	.rx_desc_get_msdu_freq = ath12k_hal_rx_desc_get_msdu_freq_qcn9274,
+	.rx_desc_get_msdu_pkt_type = ath12k_hal_rx_desc_get_msdu_pkt_type_qcn9274,
+	.rx_desc_get_msdu_nss = ath12k_hal_rx_desc_get_msdu_nss_qcn9274,
+	.rx_desc_get_mpdu_tid = ath12k_hal_rx_desc_get_mpdu_tid_qcn9274,
+	.rx_desc_get_mpdu_peer_id = ath12k_hal_rx_desc_get_mpdu_peer_id_qcn9274,
+	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_qcn9274,
+	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
+	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_qcn9274,
+	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
 	.rx_desc_get_mpdu_start_offset =
-		ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_offset,
+		ath12k_hal_rx_desc_get_mpdu_start_offset_qcn9274,
 	.rx_desc_get_msdu_end_offset =
-		ath12k_hw_qcn9274_compact_rx_desc_get_msdu_end_offset,
-	.rx_desc_mac_addr2_valid = ath12k_hw_qcn9274_compact_rx_desc_mac_addr2_valid,
-	.rx_desc_mpdu_start_addr2 = ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2,
-	.rx_desc_is_da_mcbc = ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc,
-	.rx_desc_get_dot11_hdr = ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr,
-	.rx_desc_get_crypto_header = ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr,
-	.dp_rx_h_msdu_done = ath12k_hw_qcn9274_compact_dp_rx_h_msdu_done,
-	.dp_rx_h_l4_cksum_fail = ath12k_hw_qcn9274_compact_dp_rx_h_l4_cksum_fail,
-	.dp_rx_h_ip_cksum_fail = ath12k_hw_qcn9274_compact_dp_rx_h_ip_cksum_fail,
-	.dp_rx_h_is_decrypted = ath12k_hw_qcn9274_compact_dp_rx_h_is_decrypted,
-	.dp_rx_h_mpdu_err = ath12k_hw_qcn9274_compact_dp_rx_h_mpdu_err,
-	.rx_desc_get_desc_size = ath12k_hw_qcn9274_compact_get_rx_desc_size,
+		ath12k_hal_rx_desc_get_msdu_end_offset_qcn9274,
+	.rx_desc_mac_addr2_valid = ath12k_hal_rx_desc_mac_addr2_valid_qcn9274,
+	.rx_desc_mpdu_start_addr2 = ath12k_hal_rx_desc_mpdu_start_addr2_qcn9274,
+	.rx_desc_is_da_mcbc = ath12k_hal_rx_desc_is_da_mcbc_qcn9274,
+	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_qcn9274,
+	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_qcn9274,
+	.dp_rx_h_msdu_done = ath12k_hal_rx_h_msdu_done_qcn9274,
+	.dp_rx_h_l4_cksum_fail = ath12k_hal_rx_h_l4_cksum_fail_qcn9274,
+	.dp_rx_h_ip_cksum_fail = ath12k_hal_rx_h_ip_cksum_fail_qcn9274,
+	.dp_rx_h_is_decrypted = ath12k_hal_rx_h_is_decrypted_qcn9274,
+	.dp_rx_h_mpdu_err = ath12k_hal_rx_h_mpdu_err_qcn9274,
+	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_qcn9274,
 	.rx_desc_get_msdu_src_link_id =
-		ath12k_hw_qcn9274_compact_rx_desc_get_msdu_src_link,
+		ath12k_hal_rx_desc_get_msdu_src_link_qcn9274,
 };
 EXPORT_SYMBOL(hal_rx_qcn9274_compact_ops);
 
 const struct hal_ops hal_qcn9274_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
 	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
-	.rxdma_ring_wmask_rx_mpdu_start = ath12k_hal_qcn9274_rx_mpdu_start_wmask_get,
-	.rxdma_ring_wmask_rx_msdu_end = ath12k_hal_qcn9274_rx_msdu_end_wmask_get,
+	.rxdma_ring_wmask_rx_mpdu_start = ath12k_hal_rx_mpdu_start_wmask_get_qcn9274,
+	.rxdma_ring_wmask_rx_msdu_end = ath12k_hal_rx_msdu_end_wmask_get_qcn9274,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
 
@@ -585,44 +585,44 @@ static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 }
 
 const struct hal_rx_ops hal_rx_wcn7850_ops = {
-	.rx_desc_get_first_msdu = ath12k_hw_wcn7850_rx_desc_get_first_msdu,
-	.rx_desc_get_last_msdu = ath12k_hw_wcn7850_rx_desc_get_last_msdu,
-	.rx_desc_get_l3_pad_bytes = ath12k_hw_wcn7850_rx_desc_get_l3_pad_bytes,
-	.rx_desc_encrypt_valid = ath12k_hw_wcn7850_rx_desc_encrypt_valid,
-	.rx_desc_get_encrypt_type = ath12k_hw_wcn7850_rx_desc_get_encrypt_type,
-	.rx_desc_get_decap_type = ath12k_hw_wcn7850_rx_desc_get_decap_type,
-	.rx_desc_get_mesh_ctl = ath12k_hw_wcn7850_rx_desc_get_mesh_ctl,
-	.rx_desc_get_mpdu_seq_ctl_vld = ath12k_hw_wcn7850_rx_desc_get_mpdu_seq_ctl_vld,
-	.rx_desc_get_mpdu_fc_valid = ath12k_hw_wcn7850_rx_desc_get_mpdu_fc_valid,
-	.rx_desc_get_mpdu_start_seq_no = ath12k_hw_wcn7850_rx_desc_get_mpdu_start_seq_no,
-	.rx_desc_get_msdu_len = ath12k_hw_wcn7850_rx_desc_get_msdu_len,
-	.rx_desc_get_msdu_sgi = ath12k_hw_wcn7850_rx_desc_get_msdu_sgi,
-	.rx_desc_get_msdu_rate_mcs = ath12k_hw_wcn7850_rx_desc_get_msdu_rate_mcs,
-	.rx_desc_get_msdu_rx_bw = ath12k_hw_wcn7850_rx_desc_get_msdu_rx_bw,
-	.rx_desc_get_msdu_freq = ath12k_hw_wcn7850_rx_desc_get_msdu_freq,
-	.rx_desc_get_msdu_pkt_type = ath12k_hw_wcn7850_rx_desc_get_msdu_pkt_type,
-	.rx_desc_get_msdu_nss = ath12k_hw_wcn7850_rx_desc_get_msdu_nss,
-	.rx_desc_get_mpdu_tid = ath12k_hw_wcn7850_rx_desc_get_mpdu_tid,
-	.rx_desc_get_mpdu_peer_id = ath12k_hw_wcn7850_rx_desc_get_mpdu_peer_id,
-	.rx_desc_copy_end_tlv = ath12k_hw_wcn7850_rx_desc_copy_end_tlv,
-	.rx_desc_get_mpdu_start_tag = ath12k_hw_wcn7850_rx_desc_get_mpdu_start_tag,
-	.rx_desc_get_mpdu_ppdu_id = ath12k_hw_wcn7850_rx_desc_get_mpdu_ppdu_id,
-	.rx_desc_set_msdu_len = ath12k_hw_wcn7850_rx_desc_set_msdu_len,
-	.rx_desc_get_msdu_payload = ath12k_hw_wcn7850_rx_desc_get_msdu_payload,
-	.rx_desc_get_mpdu_start_offset = ath12k_hw_wcn7850_rx_desc_get_mpdu_start_offset,
-	.rx_desc_get_msdu_end_offset = ath12k_hw_wcn7850_rx_desc_get_msdu_end_offset,
-	.rx_desc_mac_addr2_valid = ath12k_hw_wcn7850_rx_desc_mac_addr2_valid,
-	.rx_desc_mpdu_start_addr2 = ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2,
-	.rx_desc_is_da_mcbc = ath12k_hw_wcn7850_rx_desc_is_da_mcbc,
-	.rx_desc_get_dot11_hdr = ath12k_hw_wcn7850_rx_desc_get_dot11_hdr,
-	.rx_desc_get_crypto_header = ath12k_hw_wcn7850_rx_desc_get_crypto_hdr,
-	.dp_rx_h_msdu_done = ath12k_hw_wcn7850_dp_rx_h_msdu_done,
-	.dp_rx_h_l4_cksum_fail = ath12k_hw_wcn7850_dp_rx_h_l4_cksum_fail,
-	.dp_rx_h_ip_cksum_fail = ath12k_hw_wcn7850_dp_rx_h_ip_cksum_fail,
-	.dp_rx_h_is_decrypted = ath12k_hw_wcn7850_dp_rx_h_is_decrypted,
-	.dp_rx_h_mpdu_err = ath12k_hw_wcn7850_dp_rx_h_mpdu_err,
-	.rx_desc_get_desc_size = ath12k_hw_wcn7850_get_rx_desc_size,
-	.rx_desc_get_msdu_src_link_id = ath12k_hw_wcn7850_rx_desc_get_msdu_src_link,
+	.rx_desc_get_first_msdu = ath12k_hal_rx_desc_get_first_msdu_wcn7850,
+	.rx_desc_get_last_msdu = ath12k_hal_rx_desc_get_last_msdu_wcn7850,
+	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850,
+	.rx_desc_encrypt_valid = ath12k_hal_rx_desc_encrypt_valid_wcn7850,
+	.rx_desc_get_encrypt_type = ath12k_hal_rx_desc_get_encrypt_type_wcn7850,
+	.rx_desc_get_decap_type = ath12k_hal_rx_desc_get_decap_type_wcn7850,
+	.rx_desc_get_mesh_ctl = ath12k_hal_rx_desc_get_mesh_ctl_wcn7850,
+	.rx_desc_get_mpdu_seq_ctl_vld = ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_wcn7850,
+	.rx_desc_get_mpdu_fc_valid = ath12k_hal_rx_desc_get_mpdu_fc_valid_wcn7850,
+	.rx_desc_get_mpdu_start_seq_no = ath12k_hal_rx_desc_get_mpdu_start_seq_no_wcn7850,
+	.rx_desc_get_msdu_len = ath12k_hal_rx_desc_get_msdu_len_wcn7850,
+	.rx_desc_get_msdu_sgi = ath12k_hal_rx_desc_get_msdu_sgi_wcn7850,
+	.rx_desc_get_msdu_rate_mcs = ath12k_hal_rx_desc_get_msdu_rate_mcs_wcn7850,
+	.rx_desc_get_msdu_rx_bw = ath12k_hal_rx_desc_get_msdu_rx_bw_wcn7850,
+	.rx_desc_get_msdu_freq = ath12k_hal_rx_desc_get_msdu_freq_wcn7850,
+	.rx_desc_get_msdu_pkt_type = ath12k_hal_rx_desc_get_msdu_pkt_type_wcn7850,
+	.rx_desc_get_msdu_nss = ath12k_hal_rx_desc_get_msdu_nss_wcn7850,
+	.rx_desc_get_mpdu_tid = ath12k_hal_rx_desc_get_mpdu_tid_wcn7850,
+	.rx_desc_get_mpdu_peer_id = ath12k_hal_rx_desc_get_mpdu_peer_id_wcn7850,
+	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_wcn7850,
+	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
+	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
+	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_wcn7850,
+	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
+	.rx_desc_get_mpdu_start_offset = ath12k_hal_rx_desc_get_mpdu_start_offset_wcn7850,
+	.rx_desc_get_msdu_end_offset = ath12k_hal_rx_desc_get_msdu_end_offset_wcn7850,
+	.rx_desc_mac_addr2_valid = ath12k_hal_rx_desc_mac_addr2_valid_wcn7850,
+	.rx_desc_mpdu_start_addr2 = ath12k_hal_rx_desc_mpdu_start_addr2_wcn7850,
+	.rx_desc_is_da_mcbc = ath12k_hal_rx_desc_is_da_mcbc_wcn7850,
+	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_wcn7850,
+	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_wcn7850,
+	.dp_rx_h_msdu_done = ath12k_hal_rx_h_msdu_done_wcn7850,
+	.dp_rx_h_l4_cksum_fail = ath12k_hal_rx_h_l4_cksum_fail_wcn7850,
+	.dp_rx_h_ip_cksum_fail = ath12k_hal_rx_h_ip_cksum_fail_wcn7850,
+	.dp_rx_h_is_decrypted = ath12k_hal_rx_h_is_decrypted_wcn7850,
+	.dp_rx_h_mpdu_err = ath12k_hal_rx_h_mpdu_err_wcn7850,
+	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_wcn7850,
+	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_wcn7850,
 };
 EXPORT_SYMBOL(hal_rx_wcn7850_ops);
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index bd114e82d55b..bf09a40c91d9 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -6,130 +6,130 @@
 #include "hal_desc.h"
 #include "hal_qcn9274.h"
 
-bool ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_get_first_msdu_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
 			       RX_MSDU_END_INFO5_FIRST_MSDU);
 }
 
-bool ath12k_hw_qcn9274_compact_rx_desc_get_last_msdu(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_get_last_msdu_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
 			       RX_MSDU_END_INFO5_LAST_MSDU);
 }
 
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274(struct hal_rx_desc *desc)
 {
 	return le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
 			     RX_MSDU_END_INFO5_L3_HDR_PADDING);
 }
 
-bool ath12k_hw_qcn9274_compact_rx_desc_encrypt_valid(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_encrypt_valid_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
 			       RX_MPDU_START_INFO4_ENCRYPT_INFO_VALID);
 }
 
-u32 ath12k_hw_qcn9274_compact_rx_desc_get_encrypt_type(struct hal_rx_desc *desc)
+u32 ath12k_hal_rx_desc_get_encrypt_type_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info2,
 			     RX_MPDU_START_INFO2_ENC_TYPE);
 }
 
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_decap_type(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_decap_type_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info11,
 			     RX_MSDU_END_INFO11_DECAP_FORMAT);
 }
 
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_mesh_ctl_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info11,
 			     RX_MSDU_END_INFO11_MESH_CTRL_PRESENT);
 }
 
-bool ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
 			       RX_MPDU_START_INFO4_MPDU_SEQ_CTRL_VALID);
 }
 
-bool ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_get_mpdu_fc_valid_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
 			       RX_MPDU_START_INFO4_MPDU_FCTRL_VALID);
 }
 
-u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc)
+u16 ath12k_hal_rx_desc_get_mpdu_start_seq_no_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
 			     RX_MPDU_START_INFO4_MPDU_SEQ_NUM);
 }
 
-u16 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_len(struct hal_rx_desc *desc)
+u16 ath12k_hal_rx_desc_get_msdu_len_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info10,
 			     RX_MSDU_END_INFO10_MSDU_LENGTH);
 }
 
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_msdu_sgi_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
 			     RX_MSDU_END_INFO12_SGI);
 }
 
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_msdu_rate_mcs_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
 			     RX_MSDU_END_INFO12_RATE_MCS);
 }
 
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_msdu_rx_bw_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
 			     RX_MSDU_END_INFO12_RECV_BW);
 }
 
-u32 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_freq(struct hal_rx_desc *desc)
+u32 ath12k_hal_rx_desc_get_msdu_freq_qcn9274(struct hal_rx_desc *desc)
 {
 	return __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.phy_meta_data);
 }
 
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_msdu_pkt_type_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
 			     RX_MSDU_END_INFO12_PKT_TYPE);
 }
 
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_msdu_nss_qcn9274(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
 			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
 }
 
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_mpdu_tid_qcn9274(struct hal_rx_desc *desc)
 {
 	return le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
 			     RX_MSDU_END_INFO5_TID);
 }
 
-u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
+u16 ath12k_hal_rx_desc_get_mpdu_peer_id_qcn9274(struct hal_rx_desc *desc)
 {
 	return __le16_to_cpu(desc->u.qcn9274_compact.mpdu_start.sw_peer_id);
 }
 
-void ath12k_hw_qcn9274_compact_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
-						    struct hal_rx_desc *ldesc)
+void ath12k_hal_rx_desc_copy_end_tlv_qcn9274(struct hal_rx_desc *fdesc,
+					     struct hal_rx_desc *ldesc)
 {
 	fdesc->u.qcn9274_compact.msdu_end = ldesc->u.qcn9274_compact.msdu_end;
 }
 
-u32 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc)
+u32 ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274(struct hal_rx_desc *desc)
 {
 	return __le16_to_cpu(desc->u.qcn9274_compact.mpdu_start.phy_ppdu_id);
 }
 
-void ath12k_hw_qcn9274_compact_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
+void ath12k_hal_rx_desc_set_msdu_len_qcn9274(struct hal_rx_desc *desc, u16 len)
 {
 	u32 info = __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info10);
 
@@ -137,85 +137,85 @@ void ath12k_hw_qcn9274_compact_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u1
 	desc->u.qcn9274_compact.msdu_end.info10 = __cpu_to_le32(info);
 }
 
-u8 *ath12k_hw_qcn9274_compact_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
+u8 *ath12k_hal_rx_desc_get_msdu_payload_qcn9274(struct hal_rx_desc *desc)
 {
 	return &desc->u.qcn9274_compact.msdu_payload[0];
 }
 
-u32 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_offset(void)
+u32 ath12k_hal_rx_desc_get_mpdu_start_offset_qcn9274(void)
 {
 	return offsetof(struct hal_rx_desc_qcn9274_compact, mpdu_start);
 }
 
-u32 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_end_offset(void)
+u32 ath12k_hal_rx_desc_get_msdu_end_offset_qcn9274(void)
 {
 	return offsetof(struct hal_rx_desc_qcn9274_compact, msdu_end);
 }
 
-bool ath12k_hw_qcn9274_compact_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_mac_addr2_valid_qcn9274(struct hal_rx_desc *desc)
 {
 	return __le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info4) &
 			     RX_MPDU_START_INFO4_MAC_ADDR2_VALID;
 }
 
-u8 *ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
+u8 *ath12k_hal_rx_desc_mpdu_start_addr2_qcn9274(struct hal_rx_desc *desc)
 {
 	return desc->u.qcn9274_compact.mpdu_start.addr2;
 }
 
-bool ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_is_da_mcbc_qcn9274(struct hal_rx_desc *desc)
 {
 	return __le16_to_cpu(desc->u.qcn9274_compact.msdu_end.info5) &
 	       RX_MSDU_END_INFO5_DA_IS_MCBC;
 }
 
-bool ath12k_hw_qcn9274_compact_dp_rx_h_msdu_done(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_h_msdu_done_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info14,
 			       RX_MSDU_END_INFO14_MSDU_DONE);
 }
 
-bool ath12k_hw_qcn9274_compact_dp_rx_h_l4_cksum_fail(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_h_l4_cksum_fail_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info13,
 			       RX_MSDU_END_INFO13_TCP_UDP_CKSUM_FAIL);
 }
 
-bool ath12k_hw_qcn9274_compact_dp_rx_h_ip_cksum_fail(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_h_ip_cksum_fail_qcn9274(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info13,
 			       RX_MSDU_END_INFO13_IP_CKSUM_FAIL);
 }
 
-bool ath12k_hw_qcn9274_compact_dp_rx_h_is_decrypted(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_h_is_decrypted_qcn9274(struct hal_rx_desc *desc)
 {
 	return (le32_get_bits(desc->u.qcn9274_compact.msdu_end.info14,
 			      RX_MSDU_END_INFO14_DECRYPT_STATUS_CODE) ==
 			RX_DESC_DECRYPT_STATUS_CODE_OK);
 }
 
-u32 ath12k_hw_qcn9274_compact_get_rx_desc_size(void)
+u32 ath12k_hal_get_rx_desc_size_qcn9274(void)
 {
 	return sizeof(struct hal_rx_desc_qcn9274_compact);
 }
 
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_msdu_src_link_qcn9274(struct hal_rx_desc *desc)
 {
 	return le64_get_bits(desc->u.qcn9274_compact.msdu_end.msdu_end_tag,
 			     RX_MSDU_END_64_TLV_SRC_LINK_ID);
 }
 
-u16 ath12k_hal_qcn9274_rx_mpdu_start_wmask_get(void)
+u16 ath12k_hal_rx_mpdu_start_wmask_get_qcn9274(void)
 {
 	return QCN9274_MPDU_START_WMASK;
 }
 
-u32 ath12k_hal_qcn9274_rx_msdu_end_wmask_get(void)
+u32 ath12k_hal_rx_msdu_end_wmask_get_qcn9274(void)
 {
 	return QCN9274_MSDU_END_WMASK;
 }
 
-u32 ath12k_hw_qcn9274_compact_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
+u32 ath12k_hal_rx_h_mpdu_err_qcn9274(struct hal_rx_desc *desc)
 {
 	u32 info = __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info13);
 	u32 errmap = 0;
@@ -244,9 +244,9 @@ u32 ath12k_hw_qcn9274_compact_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
 	return errmap;
 }
 
-void ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
-						      u8 *crypto_hdr,
-						      enum hal_encrypt_type enctype)
+void ath12k_hal_rx_desc_get_crypto_hdr_qcn9274(struct hal_rx_desc *desc,
+					       u8 *crypto_hdr,
+					       enum hal_encrypt_type enctype)
 {
 	unsigned int key_id;
 
@@ -291,8 +291,8 @@ void ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
 		HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274_compact.mpdu_start.pn[1]);
 }
 
-void ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
-						     struct ieee80211_hdr *hdr)
+void ath12k_hal_rx_desc_get_dot11_hdr_qcn9274(struct hal_rx_desc *desc,
+					      struct ieee80211_hdr *hdr)
 {
 	hdr->frame_control = desc->u.qcn9274_compact.mpdu_start.frame_ctrl;
 	hdr->duration_id = desc->u.qcn9274_compact.mpdu_start.duration;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
index d066e5bc00db..562156bbd726 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
@@ -12,47 +12,47 @@
 #include "../hal.h"
 #include "hal_rx.h"
 
-bool ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu(struct hal_rx_desc *desc);
-bool ath12k_hw_qcn9274_compact_rx_desc_get_last_msdu(struct hal_rx_desc *desc);
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc);
-bool ath12k_hw_qcn9274_compact_rx_desc_encrypt_valid(struct hal_rx_desc *desc);
-u32 ath12k_hw_qcn9274_compact_rx_desc_get_encrypt_type(struct hal_rx_desc *desc);
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_decap_type(struct hal_rx_desc *desc);
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc);
-bool ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc);
-bool ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc);
-u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc);
-u16 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_len(struct hal_rx_desc *desc);
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc);
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc);
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc);
-u32 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_freq(struct hal_rx_desc *desc);
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc);
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_nss(struct hal_rx_desc *desc);
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc);
-u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc);
-void ath12k_hw_qcn9274_compact_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
-						    struct hal_rx_desc *ldesc);
-u32 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc);
-void ath12k_hw_qcn9274_compact_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len);
-u8 *ath12k_hw_qcn9274_compact_rx_desc_get_msdu_payload(struct hal_rx_desc *desc);
-u32 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_offset(void);
-u32 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_end_offset(void);
-bool ath12k_hw_qcn9274_compact_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc);
-u8 *ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc);
-bool ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc(struct hal_rx_desc *desc);
-bool ath12k_hw_qcn9274_compact_dp_rx_h_msdu_done(struct hal_rx_desc *desc);
-bool ath12k_hw_qcn9274_compact_dp_rx_h_l4_cksum_fail(struct hal_rx_desc *desc);
-bool ath12k_hw_qcn9274_compact_dp_rx_h_ip_cksum_fail(struct hal_rx_desc *desc);
-bool ath12k_hw_qcn9274_compact_dp_rx_h_is_decrypted(struct hal_rx_desc *desc);
-u32 ath12k_hw_qcn9274_compact_get_rx_desc_size(void);
-u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc);
-u16 ath12k_hal_qcn9274_rx_mpdu_start_wmask_get(void);
-u32 ath12k_hal_qcn9274_rx_msdu_end_wmask_get(void);
-u32 ath12k_hw_qcn9274_compact_dp_rx_h_mpdu_err(struct hal_rx_desc *desc);
-void ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
-						      u8 *crypto_hdr,
-						      enum hal_encrypt_type enctype);
-void ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
-						     struct ieee80211_hdr *hdr);
+bool ath12k_hal_rx_desc_get_first_msdu_qcn9274(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_desc_get_last_msdu_qcn9274(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_desc_encrypt_valid_qcn9274(struct hal_rx_desc *desc);
+u32 ath12k_hal_rx_desc_get_encrypt_type_qcn9274(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_decap_type_qcn9274(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_mesh_ctl_qcn9274(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_qcn9274(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_desc_get_mpdu_fc_valid_qcn9274(struct hal_rx_desc *desc);
+u16 ath12k_hal_rx_desc_get_mpdu_start_seq_no_qcn9274(struct hal_rx_desc *desc);
+u16 ath12k_hal_rx_desc_get_msdu_len_qcn9274(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_msdu_sgi_qcn9274(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_msdu_rate_mcs_qcn9274(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_msdu_rx_bw_qcn9274(struct hal_rx_desc *desc);
+u32 ath12k_hal_rx_desc_get_msdu_freq_qcn9274(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_msdu_pkt_type_qcn9274(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_msdu_nss_qcn9274(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_mpdu_tid_qcn9274(struct hal_rx_desc *desc);
+u16 ath12k_hal_rx_desc_get_mpdu_peer_id_qcn9274(struct hal_rx_desc *desc);
+void ath12k_hal_rx_desc_copy_end_tlv_qcn9274(struct hal_rx_desc *fdesc,
+					     struct hal_rx_desc *ldesc);
+u32 ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274(struct hal_rx_desc *desc);
+void ath12k_hal_rx_desc_set_msdu_len_qcn9274(struct hal_rx_desc *desc, u16 len);
+u8 *ath12k_hal_rx_desc_get_msdu_payload_qcn9274(struct hal_rx_desc *desc);
+u32 ath12k_hal_rx_desc_get_mpdu_start_offset_qcn9274(void);
+u32 ath12k_hal_rx_desc_get_msdu_end_offset_qcn9274(void);
+bool ath12k_hal_rx_desc_mac_addr2_valid_qcn9274(struct hal_rx_desc *desc);
+u8 *ath12k_hal_rx_desc_mpdu_start_addr2_qcn9274(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_desc_is_da_mcbc_qcn9274(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_h_msdu_done_qcn9274(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_h_l4_cksum_fail_qcn9274(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_h_ip_cksum_fail_qcn9274(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_h_is_decrypted_qcn9274(struct hal_rx_desc *desc);
+u32 ath12k_hal_get_rx_desc_size_qcn9274(void);
+u8 ath12k_hal_rx_desc_get_msdu_src_link_qcn9274(struct hal_rx_desc *desc);
+u16 ath12k_hal_rx_mpdu_start_wmask_get_qcn9274(void);
+u32 ath12k_hal_rx_msdu_end_wmask_get_qcn9274(void);
+u32 ath12k_hal_rx_h_mpdu_err_qcn9274(struct hal_rx_desc *desc);
+void ath12k_hal_rx_desc_get_crypto_hdr_qcn9274(struct hal_rx_desc *desc,
+					       u8 *crypto_hdr,
+					       enum hal_encrypt_type enctype);
+void ath12k_hal_rx_desc_get_dot11_hdr_qcn9274(struct hal_rx_desc *desc,
+					      struct ieee80211_hdr *hdr);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 1e23665aabc9..11b03452494c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -7,137 +7,137 @@
 #include "hal_desc.h"
 #include "hal_wcn7850.h"
 
-bool ath12k_hw_wcn7850_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_get_first_msdu_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le16_get_bits(desc->u.wcn7850.msdu_end.info5,
 			       RX_MSDU_END_INFO5_FIRST_MSDU);
 }
 
-bool ath12k_hw_wcn7850_rx_desc_get_last_msdu(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_get_last_msdu_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le16_get_bits(desc->u.wcn7850.msdu_end.info5,
 			       RX_MSDU_END_INFO5_LAST_MSDU);
 }
 
-u8 ath12k_hw_wcn7850_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850(struct hal_rx_desc *desc)
 {
 	return le16_get_bits(desc->u.wcn7850.msdu_end.info5,
 			    RX_MSDU_END_INFO5_L3_HDR_PADDING);
 }
 
-bool ath12k_hw_wcn7850_rx_desc_encrypt_valid(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_encrypt_valid_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
 			       RX_MPDU_START_INFO4_ENCRYPT_INFO_VALID);
 }
 
-u32 ath12k_hw_wcn7850_rx_desc_get_encrypt_type(struct hal_rx_desc *desc)
+u32 ath12k_hal_rx_desc_get_encrypt_type_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.mpdu_start.info2,
 			     RX_MPDU_START_INFO2_ENC_TYPE);
 }
 
-u8 ath12k_hw_wcn7850_rx_desc_get_decap_type(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_decap_type_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info11,
 			     RX_MSDU_END_INFO11_DECAP_FORMAT);
 }
 
-u8 ath12k_hw_wcn7850_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_mesh_ctl_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info11,
 			     RX_MSDU_END_INFO11_MESH_CTRL_PRESENT);
 }
 
-bool ath12k_hw_wcn7850_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
 			       RX_MPDU_START_INFO4_MPDU_SEQ_CTRL_VALID);
 }
 
-bool ath12k_hw_wcn7850_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_get_mpdu_fc_valid_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
 			       RX_MPDU_START_INFO4_MPDU_FCTRL_VALID);
 }
 
-u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc)
+u16 ath12k_hal_rx_desc_get_mpdu_start_seq_no_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
 			     RX_MPDU_START_INFO4_MPDU_SEQ_NUM);
 }
 
-u16 ath12k_hw_wcn7850_rx_desc_get_msdu_len(struct hal_rx_desc *desc)
+u16 ath12k_hal_rx_desc_get_msdu_len_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info10,
 			     RX_MSDU_END_INFO10_MSDU_LENGTH);
 }
 
-u8 ath12k_hw_wcn7850_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_msdu_sgi_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
 			     RX_MSDU_END_INFO12_SGI);
 }
 
-u8 ath12k_hw_wcn7850_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_msdu_rate_mcs_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
 			     RX_MSDU_END_INFO12_RATE_MCS);
 }
 
-u8 ath12k_hw_wcn7850_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_msdu_rx_bw_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
 			     RX_MSDU_END_INFO12_RECV_BW);
 }
 
-u32 ath12k_hw_wcn7850_rx_desc_get_msdu_freq(struct hal_rx_desc *desc)
+u32 ath12k_hal_rx_desc_get_msdu_freq_wcn7850(struct hal_rx_desc *desc)
 {
 	return __le32_to_cpu(desc->u.wcn7850.msdu_end.phy_meta_data);
 }
 
-u8 ath12k_hw_wcn7850_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_msdu_pkt_type_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
 			     RX_MSDU_END_INFO12_PKT_TYPE);
 }
 
-u8 ath12k_hw_wcn7850_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_msdu_nss_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
 			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
 }
 
-u8 ath12k_hw_wcn7850_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_mpdu_tid_wcn7850(struct hal_rx_desc *desc)
 {
 	return le32_get_bits(desc->u.wcn7850.mpdu_start.info2,
 			     RX_MPDU_START_INFO2_TID);
 }
 
-u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
+u16 ath12k_hal_rx_desc_get_mpdu_peer_id_wcn7850(struct hal_rx_desc *desc)
 {
 	return __le16_to_cpu(desc->u.wcn7850.mpdu_start.sw_peer_id);
 }
 
-void ath12k_hw_wcn7850_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
-					    struct hal_rx_desc *ldesc)
+void ath12k_hal_rx_desc_copy_end_tlv_wcn7850(struct hal_rx_desc *fdesc,
+					     struct hal_rx_desc *ldesc)
 {
 	memcpy(&fdesc->u.wcn7850.msdu_end, &ldesc->u.wcn7850.msdu_end,
 	       sizeof(struct rx_msdu_end_qcn9274));
 }
 
-u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_tag(struct hal_rx_desc *desc)
+u32 ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850(struct hal_rx_desc *desc)
 {
 	return le64_get_bits(desc->u.wcn7850.mpdu_start_tag,
 			    HAL_TLV_HDR_TAG);
 }
 
-u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc)
+u32 ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850(struct hal_rx_desc *desc)
 {
 	return __le16_to_cpu(desc->u.wcn7850.mpdu_start.phy_ppdu_id);
 }
 
-void ath12k_hw_wcn7850_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
+void ath12k_hal_rx_desc_set_msdu_len_wcn7850(struct hal_rx_desc *desc, u16 len)
 {
 	u32 info = __le32_to_cpu(desc->u.wcn7850.msdu_end.info10);
 
@@ -147,74 +147,74 @@ void ath12k_hw_wcn7850_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
 	desc->u.wcn7850.msdu_end.info10 = __cpu_to_le32(info);
 }
 
-u8 *ath12k_hw_wcn7850_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
+u8 *ath12k_hal_rx_desc_get_msdu_payload_wcn7850(struct hal_rx_desc *desc)
 {
 	return &desc->u.wcn7850.msdu_payload[0];
 }
 
-u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_offset(void)
+u32 ath12k_hal_rx_desc_get_mpdu_start_offset_wcn7850(void)
 {
 	return offsetof(struct hal_rx_desc_wcn7850, mpdu_start_tag);
 }
 
-u32 ath12k_hw_wcn7850_rx_desc_get_msdu_end_offset(void)
+u32 ath12k_hal_rx_desc_get_msdu_end_offset_wcn7850(void)
 {
 	return offsetof(struct hal_rx_desc_wcn7850, msdu_end_tag);
 }
 
-bool ath12k_hw_wcn7850_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_mac_addr2_valid_wcn7850(struct hal_rx_desc *desc)
 {
 	return __le32_to_cpu(desc->u.wcn7850.mpdu_start.info4) &
 	       RX_MPDU_START_INFO4_MAC_ADDR2_VALID;
 }
 
-u8 *ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
+u8 *ath12k_hal_rx_desc_mpdu_start_addr2_wcn7850(struct hal_rx_desc *desc)
 {
 	return desc->u.wcn7850.mpdu_start.addr2;
 }
 
-bool ath12k_hw_wcn7850_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_desc_is_da_mcbc_wcn7850(struct hal_rx_desc *desc)
 {
 	return __le32_to_cpu(desc->u.wcn7850.msdu_end.info13) &
 	       RX_MSDU_END_INFO13_MCAST_BCAST;
 }
 
-bool ath12k_hw_wcn7850_dp_rx_h_msdu_done(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_h_msdu_done_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.wcn7850.msdu_end.info14,
 			       RX_MSDU_END_INFO14_MSDU_DONE);
 }
 
-bool ath12k_hw_wcn7850_dp_rx_h_l4_cksum_fail(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_h_l4_cksum_fail_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.wcn7850.msdu_end.info13,
 			       RX_MSDU_END_INFO13_TCP_UDP_CKSUM_FAIL);
 }
 
-bool ath12k_hw_wcn7850_dp_rx_h_ip_cksum_fail(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_h_ip_cksum_fail_wcn7850(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.wcn7850.msdu_end.info13,
 			      RX_MSDU_END_INFO13_IP_CKSUM_FAIL);
 }
 
-bool ath12k_hw_wcn7850_dp_rx_h_is_decrypted(struct hal_rx_desc *desc)
+bool ath12k_hal_rx_h_is_decrypted_wcn7850(struct hal_rx_desc *desc)
 {
 	return (le32_get_bits(desc->u.wcn7850.msdu_end.info14,
 			      RX_MSDU_END_INFO14_DECRYPT_STATUS_CODE) ==
 			      RX_DESC_DECRYPT_STATUS_CODE_OK);
 }
 
-u32 ath12k_hw_wcn7850_get_rx_desc_size(void)
+u32 ath12k_hal_get_rx_desc_size_wcn7850(void)
 {
 	return sizeof(struct hal_rx_desc_wcn7850);
 }
 
-u8 ath12k_hw_wcn7850_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc)
+u8 ath12k_hal_rx_desc_get_msdu_src_link_wcn7850(struct hal_rx_desc *desc)
 {
 	return 0;
 }
 
-u32 ath12k_hw_wcn7850_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
+u32 ath12k_hal_rx_h_mpdu_err_wcn7850(struct hal_rx_desc *desc)
 {
 	u32 info = __le32_to_cpu(desc->u.wcn7850.msdu_end.info13);
 	u32 errmap = 0;
@@ -243,9 +243,9 @@ u32 ath12k_hw_wcn7850_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
 	return errmap;
 }
 
-void ath12k_hw_wcn7850_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
-					      u8 *crypto_hdr,
-					      enum hal_encrypt_type enctype)
+void ath12k_hal_rx_desc_get_crypto_hdr_wcn7850(struct hal_rx_desc *desc,
+					       u8 *crypto_hdr,
+					       enum hal_encrypt_type enctype)
 {
 	unsigned int key_id;
 
@@ -286,8 +286,8 @@ void ath12k_hw_wcn7850_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
 	crypto_hdr[7] = HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.wcn7850.mpdu_start.pn[1]);
 }
 
-void ath12k_hw_wcn7850_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
-					     struct ieee80211_hdr *hdr)
+void ath12k_hal_rx_desc_get_dot11_hdr_wcn7850(struct hal_rx_desc *desc,
+					      struct ieee80211_hdr *hdr)
 {
 	hdr->frame_control = desc->u.wcn7850.mpdu_start.frame_ctrl;
 	hdr->duration_id = desc->u.wcn7850.mpdu_start.duration;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
index a5395a005383..c9a6b7ffb607 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
@@ -10,46 +10,46 @@
 #include "../hal.h"
 #include "hal_rx.h"
 
-bool ath12k_hw_wcn7850_rx_desc_get_first_msdu(struct hal_rx_desc *desc);
-bool ath12k_hw_wcn7850_rx_desc_get_last_msdu(struct hal_rx_desc *desc);
-u8 ath12k_hw_wcn7850_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc);
-bool ath12k_hw_wcn7850_rx_desc_encrypt_valid(struct hal_rx_desc *desc);
-u32 ath12k_hw_wcn7850_rx_desc_get_encrypt_type(struct hal_rx_desc *desc);
-u8 ath12k_hw_wcn7850_rx_desc_get_decap_type(struct hal_rx_desc *desc);
-u8 ath12k_hw_wcn7850_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc);
-bool ath12k_hw_wcn7850_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc);
-bool ath12k_hw_wcn7850_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc);
-u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc);
-u16 ath12k_hw_wcn7850_rx_desc_get_msdu_len(struct hal_rx_desc *desc);
-u8 ath12k_hw_wcn7850_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc);
-u8 ath12k_hw_wcn7850_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc);
-u8 ath12k_hw_wcn7850_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc);
-u32 ath12k_hw_wcn7850_rx_desc_get_msdu_freq(struct hal_rx_desc *desc);
-u8 ath12k_hw_wcn7850_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc);
-u8 ath12k_hw_wcn7850_rx_desc_get_msdu_nss(struct hal_rx_desc *desc);
-u8 ath12k_hw_wcn7850_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc);
-u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc);
-void ath12k_hw_wcn7850_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
-					    struct hal_rx_desc *ldesc);
-u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_tag(struct hal_rx_desc *desc);
-u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc);
-void ath12k_hw_wcn7850_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len);
-u8 *ath12k_hw_wcn7850_rx_desc_get_msdu_payload(struct hal_rx_desc *desc);
-u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_offset(void);
-u32 ath12k_hw_wcn7850_rx_desc_get_msdu_end_offset(void);
-bool ath12k_hw_wcn7850_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc);
-u8 *ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc);
-bool ath12k_hw_wcn7850_rx_desc_is_da_mcbc(struct hal_rx_desc *desc);
-bool ath12k_hw_wcn7850_dp_rx_h_msdu_done(struct hal_rx_desc *desc);
-bool ath12k_hw_wcn7850_dp_rx_h_l4_cksum_fail(struct hal_rx_desc *desc);
-bool ath12k_hw_wcn7850_dp_rx_h_ip_cksum_fail(struct hal_rx_desc *desc);
-bool ath12k_hw_wcn7850_dp_rx_h_is_decrypted(struct hal_rx_desc *desc);
-u32 ath12k_hw_wcn7850_get_rx_desc_size(void);
-u8 ath12k_hw_wcn7850_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc);
-u32 ath12k_hw_wcn7850_dp_rx_h_mpdu_err(struct hal_rx_desc *desc);
-void ath12k_hw_wcn7850_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
-					      u8 *crypto_hdr,
-					      enum hal_encrypt_type enctype);
-void ath12k_hw_wcn7850_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
-					     struct ieee80211_hdr *hdr);
+bool ath12k_hal_rx_desc_get_first_msdu_wcn7850(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_desc_get_last_msdu_wcn7850(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_desc_encrypt_valid_wcn7850(struct hal_rx_desc *desc);
+u32 ath12k_hal_rx_desc_get_encrypt_type_wcn7850(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_decap_type_wcn7850(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_mesh_ctl_wcn7850(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_wcn7850(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_desc_get_mpdu_fc_valid_wcn7850(struct hal_rx_desc *desc);
+u16 ath12k_hal_rx_desc_get_mpdu_start_seq_no_wcn7850(struct hal_rx_desc *desc);
+u16 ath12k_hal_rx_desc_get_msdu_len_wcn7850(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_msdu_sgi_wcn7850(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_msdu_rate_mcs_wcn7850(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_msdu_rx_bw_wcn7850(struct hal_rx_desc *desc);
+u32 ath12k_hal_rx_desc_get_msdu_freq_wcn7850(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_msdu_pkt_type_wcn7850(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_msdu_nss_wcn7850(struct hal_rx_desc *desc);
+u8 ath12k_hal_rx_desc_get_mpdu_tid_wcn7850(struct hal_rx_desc *desc);
+u16 ath12k_hal_rx_desc_get_mpdu_peer_id_wcn7850(struct hal_rx_desc *desc);
+void ath12k_hal_rx_desc_copy_end_tlv_wcn7850(struct hal_rx_desc *fdesc,
+					     struct hal_rx_desc *ldesc);
+u32 ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850(struct hal_rx_desc *desc);
+u32 ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850(struct hal_rx_desc *desc);
+void ath12k_hal_rx_desc_set_msdu_len_wcn7850(struct hal_rx_desc *desc, u16 len);
+u8 *ath12k_hal_rx_desc_get_msdu_payload_wcn7850(struct hal_rx_desc *desc);
+u32 ath12k_hal_rx_desc_get_mpdu_start_offset_wcn7850(void);
+u32 ath12k_hal_rx_desc_get_msdu_end_offset_wcn7850(void);
+bool ath12k_hal_rx_desc_mac_addr2_valid_wcn7850(struct hal_rx_desc *desc);
+u8 *ath12k_hal_rx_desc_mpdu_start_addr2_wcn7850(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_desc_is_da_mcbc_wcn7850(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_h_msdu_done_wcn7850(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_h_l4_cksum_fail_wcn7850(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_h_ip_cksum_fail_wcn7850(struct hal_rx_desc *desc);
+bool ath12k_hal_rx_h_is_decrypted_wcn7850(struct hal_rx_desc *desc);
+u32 ath12k_hal_get_rx_desc_size_wcn7850(void);
+u8 ath12k_hal_rx_desc_get_msdu_src_link_wcn7850(struct hal_rx_desc *desc);
+u32 ath12k_hal_rx_h_mpdu_err_wcn7850(struct hal_rx_desc *desc);
+void ath12k_hal_rx_desc_get_crypto_hdr_wcn7850(struct hal_rx_desc *desc,
+					       u8 *crypto_hdr,
+					       enum hal_encrypt_type enctype);
+void ath12k_hal_rx_desc_get_dot11_hdr_wcn7850(struct hal_rx_desc *desc,
+					      struct ieee80211_hdr *hdr);
 #endif
-- 
2.34.1


