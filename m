Return-Path: <linux-wireless+bounces-27102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9219FB49537
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806AD7A2AEF
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A4330E84B;
	Mon,  8 Sep 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WmhW7wc9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8130C616
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348911; cv=none; b=dJoYroHvUXrYBAd81+9ll6izM/hXWYKL17aWejtXiHo1y/wcCRxBy+fO925tHNBvOyzsMHArUzTYJqECMhbnnV1QkLFLXAyXzuCYTh4DBFK26tMKlsx4QLAggMl5JjpMDhCftwGFfa7g/INqgDrTebejxiUVoWV2UQBZDKm1nts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348911; c=relaxed/simple;
	bh=NnUWCFhL3zsYM4LtTvlSVGCboUFdCp4VhVX08HkZCVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNR0GaApoFe6ZC84gYNCj+LAB7du1qa2uSNuXP4/2TQKCgqAc9vYSSnjI00GpOyPJXei+5tXKMnhQTL+Ihj58y+DljvaZrLoJvBxauHuaSPCQ8+ZM9q+VwhbZQPVYe3DNS7csrwR7vqCaEce7KO1u7zZBlY7Bmm0qUE5RqYC2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WmhW7wc9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GOxi4031220;
	Mon, 8 Sep 2025 16:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C64iw4Gmtz67/y+MGGhNTLR7vnJFJL8l5Mh4Vkv1YPY=; b=WmhW7wc9R8F3P7YX
	5RU+a8e+VW2MuJEPV/oxLNo1zEuDDuiq5WhMpZDzzvZWmvSBHNV4g4d3B2FrvPP7
	m2AbWKL5LaAuGbczIsK/MAWV9tqrwRnMKKXe6CvYOVkLtxYHQAEwyp4MNlwSkXZ6
	y6D+TjYoJqYXSlROzYWflD214ZDzr3a9IV13yAiqJVLwHewKL5ewUGA6kziU/ixP
	LLLMl+25UQGBR6agg5bqvlBqlpFYcZrYF1xD1GgwFT6GSE6FgIjzHFQitVP/zpRt
	w5IslO9bb7qmf1YTMenwr1j82/qhG931YCnwSR4lZsMmiiWVHUeQ5v5yWpIpfP9C
	7OINuA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j5cta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 16:28:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 588GSN5t028980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 16:28:23 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 8 Sep 2025 09:28:21 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 2/8] wifi: ath12k: Move the hal APIs to hardware specific files
Date: Mon, 8 Sep 2025 21:57:51 +0530
Message-ID: <20250908162757.2938849-3-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX+jUvNUVvrfdV
 XKj2IonI3sMgchHj0tSSOYD+AEpTRw4TPOucmzIsqm+QYHV7wh3IyAxl4i0xQjT4VEBTzDzw2/g
 GNkCk5OYgd+CmcveScyUTHHJyNF1GSlFvMvEmQ8Zwo/D1hbrp9uyBq150kOmI4qUWMnFOyblXIW
 8R/pdLGAPLkpIH1+aSI1/EvMY+2dPe/1NSqBiNsz4FwGntZs+oPiaNa5pOYowZREPD4dA6BQLAl
 rnXnAZZA3rHePvXWSdL89d8wFHPql6ip0+0y0qlmn/azptU/ZGNK1IWf9AuZeFHzQ7yzAOGEmNC
 QHN7isANU7KG5ehzBmh14V4RAfMTXveXmJ3ZATAkL6G389JhngjllNy05I/wwFMlWT/ykGLZNtX
 Uodbijnh
X-Proofpoint-ORIG-GUID: kBVHk4mCGfxnX4MUYaY9_Gl44mMTxmre
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68bf0428 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=PMc3Tcc15sbnAWJhLAoA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kBVHk4mCGfxnX4MUYaY9_Gl44mMTxmre
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

Move the hal APIs from the existing common hal files to hardware specific
hal files.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile      |   4 +-
 drivers/net/wireless/ath/ath12k/hal.c         | 600 +-----------------
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   | 307 +++++++++
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |  58 ++
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   | 302 +++++++++
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |  55 ++
 6 files changed, 727 insertions(+), 599 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 70d4daa48c90..e14844402163 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -27,7 +27,9 @@ ath12k-y += wifi7/hal_tx.o \
 	    wifi7/hal_rx.o \
 	    wifi7/dp_rx.o \
 	    wifi7/dp_tx.o \
-	    wifi7/dp.o
+	    wifi7/dp.o \
+	    wifi7/hal_qcn9274.o \
+	    wifi7/hal_wcn7850.o
 
 obj-$(CONFIG_ATH12K) += wifi7/
 
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 980f17791c1a..77024c99d0bf 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -9,6 +9,8 @@
 #include "debug.h"
 #include "wifi7/hal_desc.h"
 #include "hif.h"
+#include "wifi7/hal_qcn9274.h"
+#include "wifi7/hal_wcn7850.h"
 
 static const struct hal_srng_config hw_srng_config_template[] = {
 	/* TODO: max_rings can populated by querying HW capabilities */
@@ -404,310 +406,6 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 	return 0;
 }
 
-static u16 ath12k_hal_qcn9274_rx_mpdu_start_wmask_get(void)
-{
-	return QCN9274_MPDU_START_WMASK;
-}
-
-static u32 ath12k_hal_qcn9274_rx_msdu_end_wmask_get(void)
-{
-	return QCN9274_MSDU_END_WMASK;
-}
-
-static bool ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
-{
-	return !!le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
-			       RX_MSDU_END_INFO5_FIRST_MSDU);
-}
-
-static bool ath12k_hw_qcn9274_compact_rx_desc_get_last_msdu(struct hal_rx_desc *desc)
-{
-	return !!le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
-			       RX_MSDU_END_INFO5_LAST_MSDU);
-}
-
-static u8 ath12k_hw_qcn9274_compact_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc)
-{
-	return le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
-			     RX_MSDU_END_INFO5_L3_HDR_PADDING);
-}
-
-static bool ath12k_hw_qcn9274_compact_rx_desc_encrypt_valid(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
-			       RX_MPDU_START_INFO4_ENCRYPT_INFO_VALID);
-}
-
-static u32 ath12k_hw_qcn9274_compact_rx_desc_get_encrypt_type(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info2,
-			     RX_MPDU_START_INFO2_ENC_TYPE);
-}
-
-static u8 ath12k_hw_qcn9274_compact_rx_desc_get_decap_type(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info11,
-			     RX_MSDU_END_INFO11_DECAP_FORMAT);
-}
-
-static u8 ath12k_hw_qcn9274_compact_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info11,
-			     RX_MSDU_END_INFO11_MESH_CTRL_PRESENT);
-}
-
-static bool
-ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
-			       RX_MPDU_START_INFO4_MPDU_SEQ_CTRL_VALID);
-}
-
-static bool ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
-			       RX_MPDU_START_INFO4_MPDU_FCTRL_VALID);
-}
-
-static u16
-ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
-			     RX_MPDU_START_INFO4_MPDU_SEQ_NUM);
-}
-
-static u16 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_len(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info10,
-			     RX_MSDU_END_INFO10_MSDU_LENGTH);
-}
-
-static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
-			     RX_MSDU_END_INFO12_SGI);
-}
-
-static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
-			     RX_MSDU_END_INFO12_RATE_MCS);
-}
-
-static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
-			     RX_MSDU_END_INFO12_RECV_BW);
-}
-
-static u32 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_freq(struct hal_rx_desc *desc)
-{
-	return __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.phy_meta_data);
-}
-
-static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
-			     RX_MSDU_END_INFO12_PKT_TYPE);
-}
-
-static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
-			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
-}
-
-static u8 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
-{
-	return le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
-			     RX_MSDU_END_INFO5_TID);
-}
-
-static u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.qcn9274_compact.mpdu_start.sw_peer_id);
-}
-
-static void ath12k_hw_qcn9274_compact_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
-							   struct hal_rx_desc *ldesc)
-{
-	fdesc->u.qcn9274_compact.msdu_end = ldesc->u.qcn9274_compact.msdu_end;
-}
-
-static u32 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.qcn9274_compact.mpdu_start.phy_ppdu_id);
-}
-
-static void
-ath12k_hw_qcn9274_compact_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
-{
-	u32 info = __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info10);
-
-	info = u32_replace_bits(info, len, RX_MSDU_END_INFO10_MSDU_LENGTH);
-	desc->u.qcn9274_compact.msdu_end.info10 = __cpu_to_le32(info);
-}
-
-static u8 *ath12k_hw_qcn9274_compact_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
-{
-	return &desc->u.qcn9274_compact.msdu_payload[0];
-}
-
-static u32 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_offset(void)
-{
-	return offsetof(struct hal_rx_desc_qcn9274_compact, mpdu_start);
-}
-
-static u32 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_end_offset(void)
-{
-	return offsetof(struct hal_rx_desc_qcn9274_compact, msdu_end);
-}
-
-static bool ath12k_hw_qcn9274_compact_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc)
-{
-	return __le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info4) &
-			     RX_MPDU_START_INFO4_MAC_ADDR2_VALID;
-}
-
-static u8 *ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
-{
-	return desc->u.qcn9274_compact.mpdu_start.addr2;
-}
-
-static bool ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.qcn9274_compact.msdu_end.info5) &
-	       RX_MSDU_END_INFO5_DA_IS_MCBC;
-}
-
-static void ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
-							    struct ieee80211_hdr *hdr)
-{
-	hdr->frame_control = desc->u.qcn9274_compact.mpdu_start.frame_ctrl;
-	hdr->duration_id = desc->u.qcn9274_compact.mpdu_start.duration;
-	ether_addr_copy(hdr->addr1, desc->u.qcn9274_compact.mpdu_start.addr1);
-	ether_addr_copy(hdr->addr2, desc->u.qcn9274_compact.mpdu_start.addr2);
-	ether_addr_copy(hdr->addr3, desc->u.qcn9274_compact.mpdu_start.addr3);
-	if (__le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info4) &
-			RX_MPDU_START_INFO4_MAC_ADDR4_VALID) {
-		ether_addr_copy(hdr->addr4, desc->u.qcn9274_compact.mpdu_start.addr4);
-	}
-	hdr->seq_ctrl = desc->u.qcn9274_compact.mpdu_start.seq_ctrl;
-}
-
-static void
-ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
-						 u8 *crypto_hdr,
-						 enum hal_encrypt_type enctype)
-{
-	unsigned int key_id;
-
-	switch (enctype) {
-	case HAL_ENCRYPT_TYPE_OPEN:
-		return;
-	case HAL_ENCRYPT_TYPE_TKIP_NO_MIC:
-	case HAL_ENCRYPT_TYPE_TKIP_MIC:
-		crypto_hdr[0] =
-		HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274_compact.mpdu_start.pn[0]);
-		crypto_hdr[1] = 0;
-		crypto_hdr[2] =
-		HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcn9274_compact.mpdu_start.pn[0]);
-		break;
-	case HAL_ENCRYPT_TYPE_CCMP_128:
-	case HAL_ENCRYPT_TYPE_CCMP_256:
-	case HAL_ENCRYPT_TYPE_GCMP_128:
-	case HAL_ENCRYPT_TYPE_AES_GCMP_256:
-		crypto_hdr[0] =
-		HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcn9274_compact.mpdu_start.pn[0]);
-		crypto_hdr[1] =
-		HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274_compact.mpdu_start.pn[0]);
-		crypto_hdr[2] = 0;
-		break;
-	case HAL_ENCRYPT_TYPE_WEP_40:
-	case HAL_ENCRYPT_TYPE_WEP_104:
-	case HAL_ENCRYPT_TYPE_WEP_128:
-	case HAL_ENCRYPT_TYPE_WAPI_GCM_SM4:
-	case HAL_ENCRYPT_TYPE_WAPI:
-		return;
-	}
-	key_id = le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info5,
-			       RX_MPDU_START_INFO5_KEY_ID);
-	crypto_hdr[3] = 0x20 | (key_id << 6);
-	crypto_hdr[4] =
-		HAL_RX_MPDU_INFO_PN_GET_BYTE3(desc->u.qcn9274_compact.mpdu_start.pn[0]);
-	crypto_hdr[5] =
-		HAL_RX_MPDU_INFO_PN_GET_BYTE4(desc->u.qcn9274_compact.mpdu_start.pn[0]);
-	crypto_hdr[6] =
-		HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcn9274_compact.mpdu_start.pn[1]);
-	crypto_hdr[7] =
-		HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274_compact.mpdu_start.pn[1]);
-}
-
-static bool ath12k_hw_qcn9274_compact_dp_rx_h_msdu_done(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info14,
-			       RX_MSDU_END_INFO14_MSDU_DONE);
-}
-
-static bool ath12k_hw_qcn9274_compact_dp_rx_h_l4_cksum_fail(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info13,
-			       RX_MSDU_END_INFO13_TCP_UDP_CKSUM_FAIL);
-}
-
-static bool ath12k_hw_qcn9274_compact_dp_rx_h_ip_cksum_fail(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info13,
-			       RX_MSDU_END_INFO13_IP_CKSUM_FAIL);
-}
-
-static bool ath12k_hw_qcn9274_compact_dp_rx_h_is_decrypted(struct hal_rx_desc *desc)
-{
-	return (le32_get_bits(desc->u.qcn9274_compact.msdu_end.info14,
-			      RX_MSDU_END_INFO14_DECRYPT_STATUS_CODE) ==
-			RX_DESC_DECRYPT_STATUS_CODE_OK);
-}
-
-static u32 ath12k_hw_qcn9274_compact_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
-{
-	u32 info = __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info13);
-	u32 errmap = 0;
-
-	if (info & RX_MSDU_END_INFO13_FCS_ERR)
-		errmap |= HAL_RX_MPDU_ERR_FCS;
-
-	if (info & RX_MSDU_END_INFO13_DECRYPT_ERR)
-		errmap |= HAL_RX_MPDU_ERR_DECRYPT;
-
-	if (info & RX_MSDU_END_INFO13_TKIP_MIC_ERR)
-		errmap |= HAL_RX_MPDU_ERR_TKIP_MIC;
-
-	if (info & RX_MSDU_END_INFO13_A_MSDU_ERROR)
-		errmap |= HAL_RX_MPDU_ERR_AMSDU_ERR;
-
-	if (info & RX_MSDU_END_INFO13_OVERFLOW_ERR)
-		errmap |= HAL_RX_MPDU_ERR_OVERFLOW;
-
-	if (info & RX_MSDU_END_INFO13_MSDU_LEN_ERR)
-		errmap |= HAL_RX_MPDU_ERR_MSDU_LEN;
-
-	if (info & RX_MSDU_END_INFO13_MPDU_LEN_ERR)
-		errmap |= HAL_RX_MPDU_ERR_MPDU_LEN;
-
-	return errmap;
-}
-
-static u32 ath12k_hw_qcn9274_compact_get_rx_desc_size(void)
-{
-	return sizeof(struct hal_rx_desc_qcn9274_compact);
-}
-
-static u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc)
-{
-	return le64_get_bits(desc->u.qcn9274_compact.msdu_end.msdu_end_tag,
-			     RX_MSDU_END_64_TLV_SRC_LINK_ID);
-}
-
 const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
 	.rx_desc_get_first_msdu = ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu,
 	.rx_desc_get_last_msdu = ath12k_hw_qcn9274_compact_rx_desc_get_last_msdu,
@@ -762,236 +460,6 @@ const struct hal_ops hal_qcn9274_ops = {
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
 
-static bool ath12k_hw_wcn7850_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
-{
-	return !!le16_get_bits(desc->u.wcn7850.msdu_end.info5,
-			       RX_MSDU_END_INFO5_FIRST_MSDU);
-}
-
-static bool ath12k_hw_wcn7850_rx_desc_get_last_msdu(struct hal_rx_desc *desc)
-{
-	return !!le16_get_bits(desc->u.wcn7850.msdu_end.info5,
-			       RX_MSDU_END_INFO5_LAST_MSDU);
-}
-
-static u8 ath12k_hw_wcn7850_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc)
-{
-	return le16_get_bits(desc->u.wcn7850.msdu_end.info5,
-			    RX_MSDU_END_INFO5_L3_HDR_PADDING);
-}
-
-static bool ath12k_hw_wcn7850_rx_desc_encrypt_valid(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
-			       RX_MPDU_START_INFO4_ENCRYPT_INFO_VALID);
-}
-
-static u32 ath12k_hw_wcn7850_rx_desc_get_encrypt_type(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.wcn7850.mpdu_start.info2,
-			     RX_MPDU_START_INFO2_ENC_TYPE);
-}
-
-static u8 ath12k_hw_wcn7850_rx_desc_get_decap_type(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.wcn7850.msdu_end.info11,
-			     RX_MSDU_END_INFO11_DECAP_FORMAT);
-}
-
-static u8 ath12k_hw_wcn7850_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.wcn7850.msdu_end.info11,
-			     RX_MSDU_END_INFO11_MESH_CTRL_PRESENT);
-}
-
-static bool ath12k_hw_wcn7850_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
-			       RX_MPDU_START_INFO4_MPDU_SEQ_CTRL_VALID);
-}
-
-static bool ath12k_hw_wcn7850_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
-			       RX_MPDU_START_INFO4_MPDU_FCTRL_VALID);
-}
-
-static u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
-			     RX_MPDU_START_INFO4_MPDU_SEQ_NUM);
-}
-
-static u16 ath12k_hw_wcn7850_rx_desc_get_msdu_len(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.wcn7850.msdu_end.info10,
-			     RX_MSDU_END_INFO10_MSDU_LENGTH);
-}
-
-static u8 ath12k_hw_wcn7850_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
-			     RX_MSDU_END_INFO12_SGI);
-}
-
-static u8 ath12k_hw_wcn7850_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
-			     RX_MSDU_END_INFO12_RATE_MCS);
-}
-
-static u8 ath12k_hw_wcn7850_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
-			     RX_MSDU_END_INFO12_RECV_BW);
-}
-
-static u32 ath12k_hw_wcn7850_rx_desc_get_msdu_freq(struct hal_rx_desc *desc)
-{
-	return __le32_to_cpu(desc->u.wcn7850.msdu_end.phy_meta_data);
-}
-
-static u8 ath12k_hw_wcn7850_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
-			     RX_MSDU_END_INFO12_PKT_TYPE);
-}
-
-static u8 ath12k_hw_wcn7850_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
-			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
-}
-
-static u8 ath12k_hw_wcn7850_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.wcn7850.mpdu_start.info2,
-			     RX_MPDU_START_INFO2_TID);
-}
-
-static u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.wcn7850.mpdu_start.sw_peer_id);
-}
-
-static void ath12k_hw_wcn7850_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
-						   struct hal_rx_desc *ldesc)
-{
-	memcpy(&fdesc->u.wcn7850.msdu_end, &ldesc->u.wcn7850.msdu_end,
-	       sizeof(struct rx_msdu_end_qcn9274));
-}
-
-static u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_tag(struct hal_rx_desc *desc)
-{
-	return le64_get_bits(desc->u.wcn7850.mpdu_start_tag,
-			    HAL_TLV_HDR_TAG);
-}
-
-static u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.wcn7850.mpdu_start.phy_ppdu_id);
-}
-
-static void ath12k_hw_wcn7850_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
-{
-	u32 info = __le32_to_cpu(desc->u.wcn7850.msdu_end.info10);
-
-	info &= ~RX_MSDU_END_INFO10_MSDU_LENGTH;
-	info |= u32_encode_bits(len, RX_MSDU_END_INFO10_MSDU_LENGTH);
-
-	desc->u.wcn7850.msdu_end.info10 = __cpu_to_le32(info);
-}
-
-static u8 *ath12k_hw_wcn7850_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
-{
-	return &desc->u.wcn7850.msdu_payload[0];
-}
-
-static u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_offset(void)
-{
-	return offsetof(struct hal_rx_desc_wcn7850, mpdu_start_tag);
-}
-
-static u32 ath12k_hw_wcn7850_rx_desc_get_msdu_end_offset(void)
-{
-	return offsetof(struct hal_rx_desc_wcn7850, msdu_end_tag);
-}
-
-static bool ath12k_hw_wcn7850_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc)
-{
-	return __le32_to_cpu(desc->u.wcn7850.mpdu_start.info4) &
-	       RX_MPDU_START_INFO4_MAC_ADDR2_VALID;
-}
-
-static u8 *ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
-{
-	return desc->u.wcn7850.mpdu_start.addr2;
-}
-
-static bool ath12k_hw_wcn7850_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
-{
-	return __le32_to_cpu(desc->u.wcn7850.msdu_end.info13) &
-	       RX_MSDU_END_INFO13_MCAST_BCAST;
-}
-
-static void ath12k_hw_wcn7850_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
-						    struct ieee80211_hdr *hdr)
-{
-	hdr->frame_control = desc->u.wcn7850.mpdu_start.frame_ctrl;
-	hdr->duration_id = desc->u.wcn7850.mpdu_start.duration;
-	ether_addr_copy(hdr->addr1, desc->u.wcn7850.mpdu_start.addr1);
-	ether_addr_copy(hdr->addr2, desc->u.wcn7850.mpdu_start.addr2);
-	ether_addr_copy(hdr->addr3, desc->u.wcn7850.mpdu_start.addr3);
-	if (__le32_to_cpu(desc->u.wcn7850.mpdu_start.info4) &
-			RX_MPDU_START_INFO4_MAC_ADDR4_VALID) {
-		ether_addr_copy(hdr->addr4, desc->u.wcn7850.mpdu_start.addr4);
-	}
-	hdr->seq_ctrl = desc->u.wcn7850.mpdu_start.seq_ctrl;
-}
-
-static void ath12k_hw_wcn7850_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
-						     u8 *crypto_hdr,
-						     enum hal_encrypt_type enctype)
-{
-	unsigned int key_id;
-
-	switch (enctype) {
-	case HAL_ENCRYPT_TYPE_OPEN:
-		return;
-	case HAL_ENCRYPT_TYPE_TKIP_NO_MIC:
-	case HAL_ENCRYPT_TYPE_TKIP_MIC:
-		crypto_hdr[0] =
-			HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.wcn7850.mpdu_start.pn[0]);
-		crypto_hdr[1] = 0;
-		crypto_hdr[2] =
-			HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.wcn7850.mpdu_start.pn[0]);
-		break;
-	case HAL_ENCRYPT_TYPE_CCMP_128:
-	case HAL_ENCRYPT_TYPE_CCMP_256:
-	case HAL_ENCRYPT_TYPE_GCMP_128:
-	case HAL_ENCRYPT_TYPE_AES_GCMP_256:
-		crypto_hdr[0] =
-			HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.wcn7850.mpdu_start.pn[0]);
-		crypto_hdr[1] =
-			HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.wcn7850.mpdu_start.pn[0]);
-		crypto_hdr[2] = 0;
-		break;
-	case HAL_ENCRYPT_TYPE_WEP_40:
-	case HAL_ENCRYPT_TYPE_WEP_104:
-	case HAL_ENCRYPT_TYPE_WEP_128:
-	case HAL_ENCRYPT_TYPE_WAPI_GCM_SM4:
-	case HAL_ENCRYPT_TYPE_WAPI:
-		return;
-	}
-	key_id = u32_get_bits(__le32_to_cpu(desc->u.wcn7850.mpdu_start.info5),
-			      RX_MPDU_START_INFO5_KEY_ID);
-	crypto_hdr[3] = 0x20 | (key_id << 6);
-	crypto_hdr[4] = HAL_RX_MPDU_INFO_PN_GET_BYTE3(desc->u.wcn7850.mpdu_start.pn[0]);
-	crypto_hdr[5] = HAL_RX_MPDU_INFO_PN_GET_BYTE4(desc->u.wcn7850.mpdu_start.pn[0]);
-	crypto_hdr[6] = HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.wcn7850.mpdu_start.pn[1]);
-	crypto_hdr[7] = HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.wcn7850.mpdu_start.pn[1]);
-}
-
 static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 {
 	struct ath12k_hal *hal = &ab->hal;
@@ -1116,70 +584,6 @@ static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 	return 0;
 }
 
-static bool ath12k_hw_wcn7850_dp_rx_h_msdu_done(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.wcn7850.msdu_end.info14,
-			       RX_MSDU_END_INFO14_MSDU_DONE);
-}
-
-static bool ath12k_hw_wcn7850_dp_rx_h_l4_cksum_fail(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.wcn7850.msdu_end.info13,
-			       RX_MSDU_END_INFO13_TCP_UDP_CKSUM_FAIL);
-}
-
-static bool ath12k_hw_wcn7850_dp_rx_h_ip_cksum_fail(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.wcn7850.msdu_end.info13,
-			      RX_MSDU_END_INFO13_IP_CKSUM_FAIL);
-}
-
-static bool ath12k_hw_wcn7850_dp_rx_h_is_decrypted(struct hal_rx_desc *desc)
-{
-	return (le32_get_bits(desc->u.wcn7850.msdu_end.info14,
-			      RX_MSDU_END_INFO14_DECRYPT_STATUS_CODE) ==
-			      RX_DESC_DECRYPT_STATUS_CODE_OK);
-}
-
-static u32 ath12k_hw_wcn7850_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
-{
-	u32 info = __le32_to_cpu(desc->u.wcn7850.msdu_end.info13);
-	u32 errmap = 0;
-
-	if (info & RX_MSDU_END_INFO13_FCS_ERR)
-		errmap |= HAL_RX_MPDU_ERR_FCS;
-
-	if (info & RX_MSDU_END_INFO13_DECRYPT_ERR)
-		errmap |= HAL_RX_MPDU_ERR_DECRYPT;
-
-	if (info & RX_MSDU_END_INFO13_TKIP_MIC_ERR)
-		errmap |= HAL_RX_MPDU_ERR_TKIP_MIC;
-
-	if (info & RX_MSDU_END_INFO13_A_MSDU_ERROR)
-		errmap |= HAL_RX_MPDU_ERR_AMSDU_ERR;
-
-	if (info & RX_MSDU_END_INFO13_OVERFLOW_ERR)
-		errmap |= HAL_RX_MPDU_ERR_OVERFLOW;
-
-	if (info & RX_MSDU_END_INFO13_MSDU_LEN_ERR)
-		errmap |= HAL_RX_MPDU_ERR_MSDU_LEN;
-
-	if (info & RX_MSDU_END_INFO13_MPDU_LEN_ERR)
-		errmap |= HAL_RX_MPDU_ERR_MPDU_LEN;
-
-	return errmap;
-}
-
-static u32 ath12k_hw_wcn7850_get_rx_desc_size(void)
-{
-	return sizeof(struct hal_rx_desc_wcn7850);
-}
-
-static u8 ath12k_hw_wcn7850_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc)
-{
-	return 0;
-}
-
 const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.rx_desc_get_first_msdu = ath12k_hw_wcn7850_rx_desc_get_first_msdu,
 	.rx_desc_get_last_msdu = ath12k_hw_wcn7850_rx_desc_get_last_msdu,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
new file mode 100644
index 000000000000..bd114e82d55b
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include "hal_desc.h"
+#include "hal_qcn9274.h"
+
+bool ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
+{
+	return !!le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
+			       RX_MSDU_END_INFO5_FIRST_MSDU);
+}
+
+bool ath12k_hw_qcn9274_compact_rx_desc_get_last_msdu(struct hal_rx_desc *desc)
+{
+	return !!le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
+			       RX_MSDU_END_INFO5_LAST_MSDU);
+}
+
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc)
+{
+	return le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
+			     RX_MSDU_END_INFO5_L3_HDR_PADDING);
+}
+
+bool ath12k_hw_qcn9274_compact_rx_desc_encrypt_valid(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
+			       RX_MPDU_START_INFO4_ENCRYPT_INFO_VALID);
+}
+
+u32 ath12k_hw_qcn9274_compact_rx_desc_get_encrypt_type(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info2,
+			     RX_MPDU_START_INFO2_ENC_TYPE);
+}
+
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_decap_type(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info11,
+			     RX_MSDU_END_INFO11_DECAP_FORMAT);
+}
+
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info11,
+			     RX_MSDU_END_INFO11_MESH_CTRL_PRESENT);
+}
+
+bool ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
+			       RX_MPDU_START_INFO4_MPDU_SEQ_CTRL_VALID);
+}
+
+bool ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
+			       RX_MPDU_START_INFO4_MPDU_FCTRL_VALID);
+}
+
+u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info4,
+			     RX_MPDU_START_INFO4_MPDU_SEQ_NUM);
+}
+
+u16 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_len(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info10,
+			     RX_MSDU_END_INFO10_MSDU_LENGTH);
+}
+
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
+			     RX_MSDU_END_INFO12_SGI);
+}
+
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
+			     RX_MSDU_END_INFO12_RATE_MCS);
+}
+
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
+			     RX_MSDU_END_INFO12_RECV_BW);
+}
+
+u32 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_freq(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.phy_meta_data);
+}
+
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
+			     RX_MSDU_END_INFO12_PKT_TYPE);
+}
+
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info12,
+			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
+}
+
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
+{
+	return le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
+			     RX_MSDU_END_INFO5_TID);
+}
+
+u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.qcn9274_compact.mpdu_start.sw_peer_id);
+}
+
+void ath12k_hw_qcn9274_compact_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
+						    struct hal_rx_desc *ldesc)
+{
+	fdesc->u.qcn9274_compact.msdu_end = ldesc->u.qcn9274_compact.msdu_end;
+}
+
+u32 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.qcn9274_compact.mpdu_start.phy_ppdu_id);
+}
+
+void ath12k_hw_qcn9274_compact_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
+{
+	u32 info = __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info10);
+
+	info = u32_replace_bits(info, len, RX_MSDU_END_INFO10_MSDU_LENGTH);
+	desc->u.qcn9274_compact.msdu_end.info10 = __cpu_to_le32(info);
+}
+
+u8 *ath12k_hw_qcn9274_compact_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
+{
+	return &desc->u.qcn9274_compact.msdu_payload[0];
+}
+
+u32 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_offset(void)
+{
+	return offsetof(struct hal_rx_desc_qcn9274_compact, mpdu_start);
+}
+
+u32 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_end_offset(void)
+{
+	return offsetof(struct hal_rx_desc_qcn9274_compact, msdu_end);
+}
+
+bool ath12k_hw_qcn9274_compact_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info4) &
+			     RX_MPDU_START_INFO4_MAC_ADDR2_VALID;
+}
+
+u8 *ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
+{
+	return desc->u.qcn9274_compact.mpdu_start.addr2;
+}
+
+bool ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.qcn9274_compact.msdu_end.info5) &
+	       RX_MSDU_END_INFO5_DA_IS_MCBC;
+}
+
+bool ath12k_hw_qcn9274_compact_dp_rx_h_msdu_done(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info14,
+			       RX_MSDU_END_INFO14_MSDU_DONE);
+}
+
+bool ath12k_hw_qcn9274_compact_dp_rx_h_l4_cksum_fail(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info13,
+			       RX_MSDU_END_INFO13_TCP_UDP_CKSUM_FAIL);
+}
+
+bool ath12k_hw_qcn9274_compact_dp_rx_h_ip_cksum_fail(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info13,
+			       RX_MSDU_END_INFO13_IP_CKSUM_FAIL);
+}
+
+bool ath12k_hw_qcn9274_compact_dp_rx_h_is_decrypted(struct hal_rx_desc *desc)
+{
+	return (le32_get_bits(desc->u.qcn9274_compact.msdu_end.info14,
+			      RX_MSDU_END_INFO14_DECRYPT_STATUS_CODE) ==
+			RX_DESC_DECRYPT_STATUS_CODE_OK);
+}
+
+u32 ath12k_hw_qcn9274_compact_get_rx_desc_size(void)
+{
+	return sizeof(struct hal_rx_desc_qcn9274_compact);
+}
+
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc)
+{
+	return le64_get_bits(desc->u.qcn9274_compact.msdu_end.msdu_end_tag,
+			     RX_MSDU_END_64_TLV_SRC_LINK_ID);
+}
+
+u16 ath12k_hal_qcn9274_rx_mpdu_start_wmask_get(void)
+{
+	return QCN9274_MPDU_START_WMASK;
+}
+
+u32 ath12k_hal_qcn9274_rx_msdu_end_wmask_get(void)
+{
+	return QCN9274_MSDU_END_WMASK;
+}
+
+u32 ath12k_hw_qcn9274_compact_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
+{
+	u32 info = __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info13);
+	u32 errmap = 0;
+
+	if (info & RX_MSDU_END_INFO13_FCS_ERR)
+		errmap |= HAL_RX_MPDU_ERR_FCS;
+
+	if (info & RX_MSDU_END_INFO13_DECRYPT_ERR)
+		errmap |= HAL_RX_MPDU_ERR_DECRYPT;
+
+	if (info & RX_MSDU_END_INFO13_TKIP_MIC_ERR)
+		errmap |= HAL_RX_MPDU_ERR_TKIP_MIC;
+
+	if (info & RX_MSDU_END_INFO13_A_MSDU_ERROR)
+		errmap |= HAL_RX_MPDU_ERR_AMSDU_ERR;
+
+	if (info & RX_MSDU_END_INFO13_OVERFLOW_ERR)
+		errmap |= HAL_RX_MPDU_ERR_OVERFLOW;
+
+	if (info & RX_MSDU_END_INFO13_MSDU_LEN_ERR)
+		errmap |= HAL_RX_MPDU_ERR_MSDU_LEN;
+
+	if (info & RX_MSDU_END_INFO13_MPDU_LEN_ERR)
+		errmap |= HAL_RX_MPDU_ERR_MPDU_LEN;
+
+	return errmap;
+}
+
+void ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
+						      u8 *crypto_hdr,
+						      enum hal_encrypt_type enctype)
+{
+	unsigned int key_id;
+
+	switch (enctype) {
+	case HAL_ENCRYPT_TYPE_OPEN:
+		return;
+	case HAL_ENCRYPT_TYPE_TKIP_NO_MIC:
+	case HAL_ENCRYPT_TYPE_TKIP_MIC:
+		crypto_hdr[0] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274_compact.mpdu_start.pn[0]);
+		crypto_hdr[1] = 0;
+		crypto_hdr[2] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcn9274_compact.mpdu_start.pn[0]);
+		break;
+	case HAL_ENCRYPT_TYPE_CCMP_128:
+	case HAL_ENCRYPT_TYPE_CCMP_256:
+	case HAL_ENCRYPT_TYPE_GCMP_128:
+	case HAL_ENCRYPT_TYPE_AES_GCMP_256:
+		crypto_hdr[0] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcn9274_compact.mpdu_start.pn[0]);
+		crypto_hdr[1] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274_compact.mpdu_start.pn[0]);
+		crypto_hdr[2] = 0;
+		break;
+	case HAL_ENCRYPT_TYPE_WEP_40:
+	case HAL_ENCRYPT_TYPE_WEP_104:
+	case HAL_ENCRYPT_TYPE_WEP_128:
+	case HAL_ENCRYPT_TYPE_WAPI_GCM_SM4:
+	case HAL_ENCRYPT_TYPE_WAPI:
+		return;
+	}
+	key_id = le32_get_bits(desc->u.qcn9274_compact.mpdu_start.info5,
+			       RX_MPDU_START_INFO5_KEY_ID);
+	crypto_hdr[3] = 0x20 | (key_id << 6);
+	crypto_hdr[4] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE3(desc->u.qcn9274_compact.mpdu_start.pn[0]);
+	crypto_hdr[5] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE4(desc->u.qcn9274_compact.mpdu_start.pn[0]);
+	crypto_hdr[6] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcn9274_compact.mpdu_start.pn[1]);
+	crypto_hdr[7] =
+		HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274_compact.mpdu_start.pn[1]);
+}
+
+void ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
+						     struct ieee80211_hdr *hdr)
+{
+	hdr->frame_control = desc->u.qcn9274_compact.mpdu_start.frame_ctrl;
+	hdr->duration_id = desc->u.qcn9274_compact.mpdu_start.duration;
+	ether_addr_copy(hdr->addr1, desc->u.qcn9274_compact.mpdu_start.addr1);
+	ether_addr_copy(hdr->addr2, desc->u.qcn9274_compact.mpdu_start.addr2);
+	ether_addr_copy(hdr->addr3, desc->u.qcn9274_compact.mpdu_start.addr3);
+	if (__le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info4) &
+			RX_MPDU_START_INFO4_MAC_ADDR4_VALID) {
+		ether_addr_copy(hdr->addr4, desc->u.qcn9274_compact.mpdu_start.addr4);
+	}
+	hdr->seq_ctrl = desc->u.qcn9274_compact.mpdu_start.seq_ctrl;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
new file mode 100644
index 000000000000..d066e5bc00db
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear*/
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH12K_HAL_QCN9274_H
+#define ATH12K_HAL_QCN9274_H
+
+#include <linux/ieee80211.h>
+#include <linux/etherdevice.h>
+#include "../hal.h"
+#include "hal_rx.h"
+
+bool ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu(struct hal_rx_desc *desc);
+bool ath12k_hw_qcn9274_compact_rx_desc_get_last_msdu(struct hal_rx_desc *desc);
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc);
+bool ath12k_hw_qcn9274_compact_rx_desc_encrypt_valid(struct hal_rx_desc *desc);
+u32 ath12k_hw_qcn9274_compact_rx_desc_get_encrypt_type(struct hal_rx_desc *desc);
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_decap_type(struct hal_rx_desc *desc);
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc);
+bool ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc);
+bool ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc);
+u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc);
+u16 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_len(struct hal_rx_desc *desc);
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc);
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc);
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc);
+u32 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_freq(struct hal_rx_desc *desc);
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc);
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_nss(struct hal_rx_desc *desc);
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc);
+u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc);
+void ath12k_hw_qcn9274_compact_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
+						    struct hal_rx_desc *ldesc);
+u32 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc);
+void ath12k_hw_qcn9274_compact_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len);
+u8 *ath12k_hw_qcn9274_compact_rx_desc_get_msdu_payload(struct hal_rx_desc *desc);
+u32 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_start_offset(void);
+u32 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_end_offset(void);
+bool ath12k_hw_qcn9274_compact_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc);
+u8 *ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc);
+bool ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc(struct hal_rx_desc *desc);
+bool ath12k_hw_qcn9274_compact_dp_rx_h_msdu_done(struct hal_rx_desc *desc);
+bool ath12k_hw_qcn9274_compact_dp_rx_h_l4_cksum_fail(struct hal_rx_desc *desc);
+bool ath12k_hw_qcn9274_compact_dp_rx_h_ip_cksum_fail(struct hal_rx_desc *desc);
+bool ath12k_hw_qcn9274_compact_dp_rx_h_is_decrypted(struct hal_rx_desc *desc);
+u32 ath12k_hw_qcn9274_compact_get_rx_desc_size(void);
+u8 ath12k_hw_qcn9274_compact_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc);
+u16 ath12k_hal_qcn9274_rx_mpdu_start_wmask_get(void);
+u32 ath12k_hal_qcn9274_rx_msdu_end_wmask_get(void);
+u32 ath12k_hw_qcn9274_compact_dp_rx_h_mpdu_err(struct hal_rx_desc *desc);
+void ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
+						      u8 *crypto_hdr,
+						      enum hal_encrypt_type enctype);
+void ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
+						     struct ieee80211_hdr *hdr);
+#endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
new file mode 100644
index 000000000000..1e23665aabc9
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "hal_desc.h"
+#include "hal_wcn7850.h"
+
+bool ath12k_hw_wcn7850_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
+{
+	return !!le16_get_bits(desc->u.wcn7850.msdu_end.info5,
+			       RX_MSDU_END_INFO5_FIRST_MSDU);
+}
+
+bool ath12k_hw_wcn7850_rx_desc_get_last_msdu(struct hal_rx_desc *desc)
+{
+	return !!le16_get_bits(desc->u.wcn7850.msdu_end.info5,
+			       RX_MSDU_END_INFO5_LAST_MSDU);
+}
+
+u8 ath12k_hw_wcn7850_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc)
+{
+	return le16_get_bits(desc->u.wcn7850.msdu_end.info5,
+			    RX_MSDU_END_INFO5_L3_HDR_PADDING);
+}
+
+bool ath12k_hw_wcn7850_rx_desc_encrypt_valid(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
+			       RX_MPDU_START_INFO4_ENCRYPT_INFO_VALID);
+}
+
+u32 ath12k_hw_wcn7850_rx_desc_get_encrypt_type(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.wcn7850.mpdu_start.info2,
+			     RX_MPDU_START_INFO2_ENC_TYPE);
+}
+
+u8 ath12k_hw_wcn7850_rx_desc_get_decap_type(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.wcn7850.msdu_end.info11,
+			     RX_MSDU_END_INFO11_DECAP_FORMAT);
+}
+
+u8 ath12k_hw_wcn7850_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.wcn7850.msdu_end.info11,
+			     RX_MSDU_END_INFO11_MESH_CTRL_PRESENT);
+}
+
+bool ath12k_hw_wcn7850_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
+			       RX_MPDU_START_INFO4_MPDU_SEQ_CTRL_VALID);
+}
+
+bool ath12k_hw_wcn7850_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
+			       RX_MPDU_START_INFO4_MPDU_FCTRL_VALID);
+}
+
+u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.wcn7850.mpdu_start.info4,
+			     RX_MPDU_START_INFO4_MPDU_SEQ_NUM);
+}
+
+u16 ath12k_hw_wcn7850_rx_desc_get_msdu_len(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.wcn7850.msdu_end.info10,
+			     RX_MSDU_END_INFO10_MSDU_LENGTH);
+}
+
+u8 ath12k_hw_wcn7850_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
+			     RX_MSDU_END_INFO12_SGI);
+}
+
+u8 ath12k_hw_wcn7850_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
+			     RX_MSDU_END_INFO12_RATE_MCS);
+}
+
+u8 ath12k_hw_wcn7850_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
+			     RX_MSDU_END_INFO12_RECV_BW);
+}
+
+u32 ath12k_hw_wcn7850_rx_desc_get_msdu_freq(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.wcn7850.msdu_end.phy_meta_data);
+}
+
+u8 ath12k_hw_wcn7850_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
+			     RX_MSDU_END_INFO12_PKT_TYPE);
+}
+
+u8 ath12k_hw_wcn7850_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.wcn7850.msdu_end.info12,
+			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
+}
+
+u8 ath12k_hw_wcn7850_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.wcn7850.mpdu_start.info2,
+			     RX_MPDU_START_INFO2_TID);
+}
+
+u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.wcn7850.mpdu_start.sw_peer_id);
+}
+
+void ath12k_hw_wcn7850_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
+					    struct hal_rx_desc *ldesc)
+{
+	memcpy(&fdesc->u.wcn7850.msdu_end, &ldesc->u.wcn7850.msdu_end,
+	       sizeof(struct rx_msdu_end_qcn9274));
+}
+
+u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_tag(struct hal_rx_desc *desc)
+{
+	return le64_get_bits(desc->u.wcn7850.mpdu_start_tag,
+			    HAL_TLV_HDR_TAG);
+}
+
+u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.wcn7850.mpdu_start.phy_ppdu_id);
+}
+
+void ath12k_hw_wcn7850_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
+{
+	u32 info = __le32_to_cpu(desc->u.wcn7850.msdu_end.info10);
+
+	info &= ~RX_MSDU_END_INFO10_MSDU_LENGTH;
+	info |= u32_encode_bits(len, RX_MSDU_END_INFO10_MSDU_LENGTH);
+
+	desc->u.wcn7850.msdu_end.info10 = __cpu_to_le32(info);
+}
+
+u8 *ath12k_hw_wcn7850_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
+{
+	return &desc->u.wcn7850.msdu_payload[0];
+}
+
+u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_offset(void)
+{
+	return offsetof(struct hal_rx_desc_wcn7850, mpdu_start_tag);
+}
+
+u32 ath12k_hw_wcn7850_rx_desc_get_msdu_end_offset(void)
+{
+	return offsetof(struct hal_rx_desc_wcn7850, msdu_end_tag);
+}
+
+bool ath12k_hw_wcn7850_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.wcn7850.mpdu_start.info4) &
+	       RX_MPDU_START_INFO4_MAC_ADDR2_VALID;
+}
+
+u8 *ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
+{
+	return desc->u.wcn7850.mpdu_start.addr2;
+}
+
+bool ath12k_hw_wcn7850_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.wcn7850.msdu_end.info13) &
+	       RX_MSDU_END_INFO13_MCAST_BCAST;
+}
+
+bool ath12k_hw_wcn7850_dp_rx_h_msdu_done(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.wcn7850.msdu_end.info14,
+			       RX_MSDU_END_INFO14_MSDU_DONE);
+}
+
+bool ath12k_hw_wcn7850_dp_rx_h_l4_cksum_fail(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.wcn7850.msdu_end.info13,
+			       RX_MSDU_END_INFO13_TCP_UDP_CKSUM_FAIL);
+}
+
+bool ath12k_hw_wcn7850_dp_rx_h_ip_cksum_fail(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.wcn7850.msdu_end.info13,
+			      RX_MSDU_END_INFO13_IP_CKSUM_FAIL);
+}
+
+bool ath12k_hw_wcn7850_dp_rx_h_is_decrypted(struct hal_rx_desc *desc)
+{
+	return (le32_get_bits(desc->u.wcn7850.msdu_end.info14,
+			      RX_MSDU_END_INFO14_DECRYPT_STATUS_CODE) ==
+			      RX_DESC_DECRYPT_STATUS_CODE_OK);
+}
+
+u32 ath12k_hw_wcn7850_get_rx_desc_size(void)
+{
+	return sizeof(struct hal_rx_desc_wcn7850);
+}
+
+u8 ath12k_hw_wcn7850_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc)
+{
+	return 0;
+}
+
+u32 ath12k_hw_wcn7850_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
+{
+	u32 info = __le32_to_cpu(desc->u.wcn7850.msdu_end.info13);
+	u32 errmap = 0;
+
+	if (info & RX_MSDU_END_INFO13_FCS_ERR)
+		errmap |= HAL_RX_MPDU_ERR_FCS;
+
+	if (info & RX_MSDU_END_INFO13_DECRYPT_ERR)
+		errmap |= HAL_RX_MPDU_ERR_DECRYPT;
+
+	if (info & RX_MSDU_END_INFO13_TKIP_MIC_ERR)
+		errmap |= HAL_RX_MPDU_ERR_TKIP_MIC;
+
+	if (info & RX_MSDU_END_INFO13_A_MSDU_ERROR)
+		errmap |= HAL_RX_MPDU_ERR_AMSDU_ERR;
+
+	if (info & RX_MSDU_END_INFO13_OVERFLOW_ERR)
+		errmap |= HAL_RX_MPDU_ERR_OVERFLOW;
+
+	if (info & RX_MSDU_END_INFO13_MSDU_LEN_ERR)
+		errmap |= HAL_RX_MPDU_ERR_MSDU_LEN;
+
+	if (info & RX_MSDU_END_INFO13_MPDU_LEN_ERR)
+		errmap |= HAL_RX_MPDU_ERR_MPDU_LEN;
+
+	return errmap;
+}
+
+void ath12k_hw_wcn7850_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
+					      u8 *crypto_hdr,
+					      enum hal_encrypt_type enctype)
+{
+	unsigned int key_id;
+
+	switch (enctype) {
+	case HAL_ENCRYPT_TYPE_OPEN:
+		return;
+	case HAL_ENCRYPT_TYPE_TKIP_NO_MIC:
+	case HAL_ENCRYPT_TYPE_TKIP_MIC:
+		crypto_hdr[0] =
+			HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.wcn7850.mpdu_start.pn[0]);
+		crypto_hdr[1] = 0;
+		crypto_hdr[2] =
+			HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.wcn7850.mpdu_start.pn[0]);
+		break;
+	case HAL_ENCRYPT_TYPE_CCMP_128:
+	case HAL_ENCRYPT_TYPE_CCMP_256:
+	case HAL_ENCRYPT_TYPE_GCMP_128:
+	case HAL_ENCRYPT_TYPE_AES_GCMP_256:
+		crypto_hdr[0] =
+			HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.wcn7850.mpdu_start.pn[0]);
+		crypto_hdr[1] =
+			HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.wcn7850.mpdu_start.pn[0]);
+		crypto_hdr[2] = 0;
+		break;
+	case HAL_ENCRYPT_TYPE_WEP_40:
+	case HAL_ENCRYPT_TYPE_WEP_104:
+	case HAL_ENCRYPT_TYPE_WEP_128:
+	case HAL_ENCRYPT_TYPE_WAPI_GCM_SM4:
+	case HAL_ENCRYPT_TYPE_WAPI:
+		return;
+	}
+	key_id = u32_get_bits(__le32_to_cpu(desc->u.wcn7850.mpdu_start.info5),
+			      RX_MPDU_START_INFO5_KEY_ID);
+	crypto_hdr[3] = 0x20 | (key_id << 6);
+	crypto_hdr[4] = HAL_RX_MPDU_INFO_PN_GET_BYTE3(desc->u.wcn7850.mpdu_start.pn[0]);
+	crypto_hdr[5] = HAL_RX_MPDU_INFO_PN_GET_BYTE4(desc->u.wcn7850.mpdu_start.pn[0]);
+	crypto_hdr[6] = HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.wcn7850.mpdu_start.pn[1]);
+	crypto_hdr[7] = HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.wcn7850.mpdu_start.pn[1]);
+}
+
+void ath12k_hw_wcn7850_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
+					     struct ieee80211_hdr *hdr)
+{
+	hdr->frame_control = desc->u.wcn7850.mpdu_start.frame_ctrl;
+	hdr->duration_id = desc->u.wcn7850.mpdu_start.duration;
+	ether_addr_copy(hdr->addr1, desc->u.wcn7850.mpdu_start.addr1);
+	ether_addr_copy(hdr->addr2, desc->u.wcn7850.mpdu_start.addr2);
+	ether_addr_copy(hdr->addr3, desc->u.wcn7850.mpdu_start.addr3);
+	if (__le32_to_cpu(desc->u.wcn7850.mpdu_start.info4) &
+			RX_MPDU_START_INFO4_MAC_ADDR4_VALID) {
+		ether_addr_copy(hdr->addr4, desc->u.wcn7850.mpdu_start.addr4);
+	}
+	hdr->seq_ctrl = desc->u.wcn7850.mpdu_start.seq_ctrl;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
new file mode 100644
index 000000000000..a5395a005383
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH12K_HAL_WCN7850_H
+#define ATH12K_HAL_WCN7850_H
+
+#include "../hal.h"
+#include "hal_rx.h"
+
+bool ath12k_hw_wcn7850_rx_desc_get_first_msdu(struct hal_rx_desc *desc);
+bool ath12k_hw_wcn7850_rx_desc_get_last_msdu(struct hal_rx_desc *desc);
+u8 ath12k_hw_wcn7850_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc);
+bool ath12k_hw_wcn7850_rx_desc_encrypt_valid(struct hal_rx_desc *desc);
+u32 ath12k_hw_wcn7850_rx_desc_get_encrypt_type(struct hal_rx_desc *desc);
+u8 ath12k_hw_wcn7850_rx_desc_get_decap_type(struct hal_rx_desc *desc);
+u8 ath12k_hw_wcn7850_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc);
+bool ath12k_hw_wcn7850_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc);
+bool ath12k_hw_wcn7850_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc);
+u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc);
+u16 ath12k_hw_wcn7850_rx_desc_get_msdu_len(struct hal_rx_desc *desc);
+u8 ath12k_hw_wcn7850_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc);
+u8 ath12k_hw_wcn7850_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc);
+u8 ath12k_hw_wcn7850_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc);
+u32 ath12k_hw_wcn7850_rx_desc_get_msdu_freq(struct hal_rx_desc *desc);
+u8 ath12k_hw_wcn7850_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc);
+u8 ath12k_hw_wcn7850_rx_desc_get_msdu_nss(struct hal_rx_desc *desc);
+u8 ath12k_hw_wcn7850_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc);
+u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc);
+void ath12k_hw_wcn7850_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
+					    struct hal_rx_desc *ldesc);
+u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_tag(struct hal_rx_desc *desc);
+u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc);
+void ath12k_hw_wcn7850_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len);
+u8 *ath12k_hw_wcn7850_rx_desc_get_msdu_payload(struct hal_rx_desc *desc);
+u32 ath12k_hw_wcn7850_rx_desc_get_mpdu_start_offset(void);
+u32 ath12k_hw_wcn7850_rx_desc_get_msdu_end_offset(void);
+bool ath12k_hw_wcn7850_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc);
+u8 *ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc);
+bool ath12k_hw_wcn7850_rx_desc_is_da_mcbc(struct hal_rx_desc *desc);
+bool ath12k_hw_wcn7850_dp_rx_h_msdu_done(struct hal_rx_desc *desc);
+bool ath12k_hw_wcn7850_dp_rx_h_l4_cksum_fail(struct hal_rx_desc *desc);
+bool ath12k_hw_wcn7850_dp_rx_h_ip_cksum_fail(struct hal_rx_desc *desc);
+bool ath12k_hw_wcn7850_dp_rx_h_is_decrypted(struct hal_rx_desc *desc);
+u32 ath12k_hw_wcn7850_get_rx_desc_size(void);
+u8 ath12k_hw_wcn7850_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc);
+u32 ath12k_hw_wcn7850_dp_rx_h_mpdu_err(struct hal_rx_desc *desc);
+void ath12k_hw_wcn7850_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
+					      u8 *crypto_hdr,
+					      enum hal_encrypt_type enctype);
+void ath12k_hw_wcn7850_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
+					     struct ieee80211_hdr *hdr);
+#endif
-- 
2.34.1


