Return-Path: <linux-wireless+bounces-27101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 925CBB49536
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7079A1899031
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3282030BBA4;
	Mon,  8 Sep 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kOXXWJ9w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDDE1DF26E
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348908; cv=none; b=h/lTZu3Bzku5LY6789nLh/3N8NAetIN5zBe01mFvJ9+fqBGmHPri+MUldGRbEc/FHwO873xLzr1K9ejOmkkVMOlv/hayDzdubyG1YZChuB1fg50YNS6QapaJD2VLiN6Ei+YfyZtNfZmCg9L80Sn8keOS3dKBY9VvjdtmpymsPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348908; c=relaxed/simple;
	bh=NmBvzOLSK/xv/wv6dls2gBV7baza29+L4zKo8DvJr/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTPawancZP/szpdm4l8D9aXYVWL6sHil3hbcQnu5VeAC6T3jj3mRA+kKLuofJnCqlYF2dAzsjry2Cg5Zl8aDLJVbQzBktbv51qXSzLa629gp/y/n4wsHIzdzwobfPvA85O3mTYdKh38VZ7Wd+vYLFUH/DYDgvugU3Cn6wwiKGWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kOXXWJ9w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889O3Xo001510;
	Mon, 8 Sep 2025 16:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	srnjD62i2q+JPYGOr4+MvLDTFstYWZdZ4RZ4tOvMLe8=; b=kOXXWJ9wwLJ1IZ84
	q5ZDAddm2XpYSws/O6avsAy2MyLPX5Akvul6ejl/oGPdxYJ78uN94P920gkV43Iw
	R1z25J746aZ0JN8WUP7X2k79tUwY8X54PdYmdi+bWhaWBZb59/OIG8HEPg3AyUtK
	u/2xdqjwzsOwe9RRo0fjffG0p27Ky3XPoZ9Q/PL7V7EW/5xI+LK8RY1OSYEzW7sQ
	6uTNWM38zXTxbVRuwKF9e0bhdQO5DbyF940LsXCOKnH/+KS9LCFj37YMOE9cSWHT
	QkyvOojEXkgg9BnCzt7kS3RmY2jW97pXw41XHFt+xv+xfQYb1Xn2/BNQ+16tzd7S
	sWIeiw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8wbgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 16:28:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 588GSLsj004592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 16:28:21 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 8 Sep 2025 09:28:20 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 1/8] wifi: ath12k: Remove non-compact TLV support from QCN
Date: Mon, 8 Sep 2025 21:57:50 +0530
Message-ID: <20250908162757.2938849-2-quic_rdeuri@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68bf0426 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=AWQmlI5REiQkNSw2GZkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: xc5JgBZTiOfaFe0uuZ5Zo4F8TDYM4SJu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX8KzpvaO/hE2V
 FE3hywf/O8xnR/c0hp1aS9R0Oo7lUMv0GAiqFVFu8fbR5S4Xu3DP+rWepztHDeHDWNe0Sm8/z65
 WmAn5WhR8EHygd5B6FRgLPIgYyTSVFI1YIQcnHzpMeXmvbenVfcDlxh8x4xHGNhxFskTWwXU5Hi
 AXrPR4C7Cmtxegg1DalP8ZhPEV3yJSEErJMLgdhUYBc8mv5rYpzMhfYsw2cuebuJ4nGDDslgC2t
 s/p8OSbSowe+ySSA1AFCtBS/YfJ6eiTe3iqeJwnVolIqgW0BjGvVFOuQtEHUULn+SHV8sCuD5yW
 wZVW2kY6fer97M7FZzxEp5XE8SDqPPc3e0iF/Z9FqL48jSqcaFS6cdHDBl/4kUpl4nKb7V2Jn9p
 XxFriIUP
X-Proofpoint-ORIG-GUID: xc5JgBZTiOfaFe0uuZ5Zo4F8TDYM4SJu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Set compact TLV ops as the default ops by registering them in
hw_params by default for QCN, and remove non-compact TLV ops and the
corresponding hal APIs for QCN.

Please note that compact TLVs have been supported by the firmware since
the beginning of Wi-Fi 7, so backward compatibility has been maintained.

These changes are specific to QCN as WCN only support non-compact TLVs.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c          |  20 +-
 drivers/net/wireless/ath/ath12k/dp.h          |   1 -
 drivers/net/wireless/ath/ath12k/hal.c         | 339 +-----------------
 drivers/net/wireless/ath/ath12k/hal.h         |   2 -
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  16 +-
 .../wireless/ath/ath12k/wifi7/hal_rx_desc.h   |   7 -
 drivers/net/wireless/ath/ath12k/wifi7/pci.c   |   2 +-
 7 files changed, 11 insertions(+), 376 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 8909415df2e2..83d41154c115 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -895,27 +895,9 @@ void ath12k_dp_pdev_pre_alloc(struct ath12k *ar)
 	/* TODO: Add any RXDMA setup required per pdev */
 }
 
-bool ath12k_dp_wmask_compaction_rx_tlv_supported(struct ath12k_base *ab)
-{
-	if (test_bit(WMI_TLV_SERVICE_WMSK_COMPACTION_RX_TLVS, ab->wmi_ab.svc_map) &&
-	    ab->hw_params->hal_ops->rxdma_ring_wmask_rx_mpdu_start &&
-	    ab->hw_params->hal_ops->rxdma_ring_wmask_rx_msdu_end &&
-	    ab->hw_params->hal_ops->get_hal_rx_compact_ops) {
-		return true;
-	}
-	return false;
-}
-
 void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab)
 {
-	if (ath12k_dp_wmask_compaction_rx_tlv_supported(ab)) {
-		/* RX TLVS compaction is supported, hence change the hal_rx_ops
-		 * to compact hal_rx_ops.
-		 */
-		ab->hal_rx_ops = ab->hw_params->hal_ops->get_hal_rx_compact_ops();
-	}
-	ab->hal.hal_desc_sz =
-		ab->hal_rx_ops->rx_desc_get_desc_size();
+	ab->hal.hal_desc_sz = ab->hal_rx_ops->rx_desc_get_desc_size();
 }
 
 int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 18a3287945b7..71f7c4858176 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -457,6 +457,5 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
 						  u32 cookie);
 struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
 						  u32 desc_id);
-bool ath12k_dp_wmask_compaction_rx_tlv_supported(struct ath12k_base *ab);
 void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 144c26586b79..980f17791c1a 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -294,230 +294,6 @@ static unsigned int ath12k_hal_reo1_ring_misc_offset(struct ath12k_base *ab)
 	return HAL_REO1_RING_MISC(ab) - HAL_REO1_RING_BASE_LSB(ab);
 }
 
-static bool ath12k_hw_qcn9274_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
-{
-	return !!le16_get_bits(desc->u.qcn9274.msdu_end.info5,
-			       RX_MSDU_END_INFO5_FIRST_MSDU);
-}
-
-static bool ath12k_hw_qcn9274_rx_desc_get_last_msdu(struct hal_rx_desc *desc)
-{
-	return !!le16_get_bits(desc->u.qcn9274.msdu_end.info5,
-			       RX_MSDU_END_INFO5_LAST_MSDU);
-}
-
-static u8 ath12k_hw_qcn9274_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc)
-{
-	return le16_get_bits(desc->u.qcn9274.msdu_end.info5,
-			     RX_MSDU_END_INFO5_L3_HDR_PADDING);
-}
-
-static bool ath12k_hw_qcn9274_rx_desc_encrypt_valid(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.qcn9274.mpdu_start.info4,
-			       RX_MPDU_START_INFO4_ENCRYPT_INFO_VALID);
-}
-
-static u32 ath12k_hw_qcn9274_rx_desc_get_encrypt_type(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274.mpdu_start.info2,
-			     RX_MPDU_START_INFO2_ENC_TYPE);
-}
-
-static u8 ath12k_hw_qcn9274_rx_desc_get_decap_type(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274.msdu_end.info11,
-			     RX_MSDU_END_INFO11_DECAP_FORMAT);
-}
-
-static u8 ath12k_hw_qcn9274_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274.msdu_end.info11,
-			     RX_MSDU_END_INFO11_MESH_CTRL_PRESENT);
-}
-
-static bool ath12k_hw_qcn9274_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.qcn9274.mpdu_start.info4,
-			       RX_MPDU_START_INFO4_MPDU_SEQ_CTRL_VALID);
-}
-
-static bool ath12k_hw_qcn9274_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.qcn9274.mpdu_start.info4,
-			       RX_MPDU_START_INFO4_MPDU_FCTRL_VALID);
-}
-
-static u16 ath12k_hw_qcn9274_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274.mpdu_start.info4,
-			     RX_MPDU_START_INFO4_MPDU_SEQ_NUM);
-}
-
-static u16 ath12k_hw_qcn9274_rx_desc_get_msdu_len(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274.msdu_end.info10,
-			     RX_MSDU_END_INFO10_MSDU_LENGTH);
-}
-
-static u8 ath12k_hw_qcn9274_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274.msdu_end.info12,
-			     RX_MSDU_END_INFO12_SGI);
-}
-
-static u8 ath12k_hw_qcn9274_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274.msdu_end.info12,
-			     RX_MSDU_END_INFO12_RATE_MCS);
-}
-
-static u8 ath12k_hw_qcn9274_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274.msdu_end.info12,
-			     RX_MSDU_END_INFO12_RECV_BW);
-}
-
-static u32 ath12k_hw_qcn9274_rx_desc_get_msdu_freq(struct hal_rx_desc *desc)
-{
-	return __le32_to_cpu(desc->u.qcn9274.msdu_end.phy_meta_data);
-}
-
-static u8 ath12k_hw_qcn9274_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274.msdu_end.info12,
-			     RX_MSDU_END_INFO12_PKT_TYPE);
-}
-
-static u8 ath12k_hw_qcn9274_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
-{
-	return le32_get_bits(desc->u.qcn9274.msdu_end.info12,
-			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
-}
-
-static u8 ath12k_hw_qcn9274_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
-{
-	return le16_get_bits(desc->u.qcn9274.msdu_end.info5,
-			    RX_MSDU_END_INFO5_TID);
-}
-
-static u16 ath12k_hw_qcn9274_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.qcn9274.mpdu_start.sw_peer_id);
-}
-
-static void ath12k_hw_qcn9274_rx_desc_copy_end_tlv(struct hal_rx_desc *fdesc,
-						   struct hal_rx_desc *ldesc)
-{
-	memcpy(&fdesc->u.qcn9274.msdu_end, &ldesc->u.qcn9274.msdu_end,
-	       sizeof(struct rx_msdu_end_qcn9274));
-}
-
-static u32 ath12k_hw_qcn9274_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.qcn9274.mpdu_start.phy_ppdu_id);
-}
-
-static void ath12k_hw_qcn9274_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
-{
-	u32 info = __le32_to_cpu(desc->u.qcn9274.msdu_end.info10);
-
-	info &= ~RX_MSDU_END_INFO10_MSDU_LENGTH;
-	info |= u32_encode_bits(len, RX_MSDU_END_INFO10_MSDU_LENGTH);
-
-	desc->u.qcn9274.msdu_end.info10 = __cpu_to_le32(info);
-}
-
-static u8 *ath12k_hw_qcn9274_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
-{
-	return &desc->u.qcn9274.msdu_payload[0];
-}
-
-static u32 ath12k_hw_qcn9274_rx_desc_get_mpdu_start_offset(void)
-{
-	return offsetof(struct hal_rx_desc_qcn9274, mpdu_start);
-}
-
-static u32 ath12k_hw_qcn9274_rx_desc_get_msdu_end_offset(void)
-{
-	return offsetof(struct hal_rx_desc_qcn9274, msdu_end);
-}
-
-static bool ath12k_hw_qcn9274_rx_desc_mac_addr2_valid(struct hal_rx_desc *desc)
-{
-	return __le32_to_cpu(desc->u.qcn9274.mpdu_start.info4) &
-	       RX_MPDU_START_INFO4_MAC_ADDR2_VALID;
-}
-
-static u8 *ath12k_hw_qcn9274_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
-{
-	return desc->u.qcn9274.mpdu_start.addr2;
-}
-
-static bool ath12k_hw_qcn9274_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.qcn9274.msdu_end.info5) &
-	       RX_MSDU_END_INFO5_DA_IS_MCBC;
-}
-
-static void ath12k_hw_qcn9274_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
-						    struct ieee80211_hdr *hdr)
-{
-	hdr->frame_control = desc->u.qcn9274.mpdu_start.frame_ctrl;
-	hdr->duration_id = desc->u.qcn9274.mpdu_start.duration;
-	ether_addr_copy(hdr->addr1, desc->u.qcn9274.mpdu_start.addr1);
-	ether_addr_copy(hdr->addr2, desc->u.qcn9274.mpdu_start.addr2);
-	ether_addr_copy(hdr->addr3, desc->u.qcn9274.mpdu_start.addr3);
-	if (__le32_to_cpu(desc->u.qcn9274.mpdu_start.info4) &
-			RX_MPDU_START_INFO4_MAC_ADDR4_VALID) {
-		ether_addr_copy(hdr->addr4, desc->u.qcn9274.mpdu_start.addr4);
-	}
-	hdr->seq_ctrl = desc->u.qcn9274.mpdu_start.seq_ctrl;
-}
-
-static void ath12k_hw_qcn9274_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
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
-			HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274.mpdu_start.pn[0]);
-		crypto_hdr[1] = 0;
-		crypto_hdr[2] =
-			HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcn9274.mpdu_start.pn[0]);
-		break;
-	case HAL_ENCRYPT_TYPE_CCMP_128:
-	case HAL_ENCRYPT_TYPE_CCMP_256:
-	case HAL_ENCRYPT_TYPE_GCMP_128:
-	case HAL_ENCRYPT_TYPE_AES_GCMP_256:
-		crypto_hdr[0] =
-			HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcn9274.mpdu_start.pn[0]);
-		crypto_hdr[1] =
-			HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274.mpdu_start.pn[0]);
-		crypto_hdr[2] = 0;
-		break;
-	case HAL_ENCRYPT_TYPE_WEP_40:
-	case HAL_ENCRYPT_TYPE_WEP_104:
-	case HAL_ENCRYPT_TYPE_WEP_128:
-	case HAL_ENCRYPT_TYPE_WAPI_GCM_SM4:
-	case HAL_ENCRYPT_TYPE_WAPI:
-		return;
-	}
-	key_id = le32_get_bits(desc->u.qcn9274.mpdu_start.info5,
-			       RX_MPDU_START_INFO5_KEY_ID);
-	crypto_hdr[3] = 0x20 | (key_id << 6);
-	crypto_hdr[4] = HAL_RX_MPDU_INFO_PN_GET_BYTE3(desc->u.qcn9274.mpdu_start.pn[0]);
-	crypto_hdr[5] = HAL_RX_MPDU_INFO_PN_GET_BYTE4(desc->u.qcn9274.mpdu_start.pn[0]);
-	crypto_hdr[6] = HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcn9274.mpdu_start.pn[1]);
-	crypto_hdr[7] = HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274.mpdu_start.pn[1]);
-}
-
 static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 {
 	struct ath12k_hal *hal = &ab->hal;
@@ -638,116 +414,6 @@ static u32 ath12k_hal_qcn9274_rx_msdu_end_wmask_get(void)
 	return QCN9274_MSDU_END_WMASK;
 }
 
-static const struct hal_rx_ops *ath12k_hal_qcn9274_get_hal_rx_compact_ops(void)
-{
-	return &hal_rx_qcn9274_compact_ops;
-}
-
-static bool ath12k_hw_qcn9274_dp_rx_h_msdu_done(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.qcn9274.msdu_end.info14,
-			       RX_MSDU_END_INFO14_MSDU_DONE);
-}
-
-static bool ath12k_hw_qcn9274_dp_rx_h_l4_cksum_fail(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.qcn9274.msdu_end.info13,
-			       RX_MSDU_END_INFO13_TCP_UDP_CKSUM_FAIL);
-}
-
-static bool ath12k_hw_qcn9274_dp_rx_h_ip_cksum_fail(struct hal_rx_desc *desc)
-{
-	return !!le32_get_bits(desc->u.qcn9274.msdu_end.info13,
-			       RX_MSDU_END_INFO13_IP_CKSUM_FAIL);
-}
-
-static bool ath12k_hw_qcn9274_dp_rx_h_is_decrypted(struct hal_rx_desc *desc)
-{
-	return (le32_get_bits(desc->u.qcn9274.msdu_end.info14,
-			      RX_MSDU_END_INFO14_DECRYPT_STATUS_CODE) ==
-			      RX_DESC_DECRYPT_STATUS_CODE_OK);
-}
-
-static u32 ath12k_hw_qcn9274_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
-{
-	u32 info = __le32_to_cpu(desc->u.qcn9274.msdu_end.info13);
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
-static u32 ath12k_hw_qcn9274_get_rx_desc_size(void)
-{
-	return sizeof(struct hal_rx_desc_qcn9274);
-}
-
-static u8 ath12k_hw_qcn9274_rx_desc_get_msdu_src_link(struct hal_rx_desc *desc)
-{
-	return 0;
-}
-
-const struct hal_rx_ops hal_rx_qcn9274_ops = {
-	.rx_desc_get_first_msdu = ath12k_hw_qcn9274_rx_desc_get_first_msdu,
-	.rx_desc_get_last_msdu = ath12k_hw_qcn9274_rx_desc_get_last_msdu,
-	.rx_desc_get_l3_pad_bytes = ath12k_hw_qcn9274_rx_desc_get_l3_pad_bytes,
-	.rx_desc_encrypt_valid = ath12k_hw_qcn9274_rx_desc_encrypt_valid,
-	.rx_desc_get_encrypt_type = ath12k_hw_qcn9274_rx_desc_get_encrypt_type,
-	.rx_desc_get_decap_type = ath12k_hw_qcn9274_rx_desc_get_decap_type,
-	.rx_desc_get_mesh_ctl = ath12k_hw_qcn9274_rx_desc_get_mesh_ctl,
-	.rx_desc_get_mpdu_seq_ctl_vld = ath12k_hw_qcn9274_rx_desc_get_mpdu_seq_ctl_vld,
-	.rx_desc_get_mpdu_fc_valid = ath12k_hw_qcn9274_rx_desc_get_mpdu_fc_valid,
-	.rx_desc_get_mpdu_start_seq_no = ath12k_hw_qcn9274_rx_desc_get_mpdu_start_seq_no,
-	.rx_desc_get_msdu_len = ath12k_hw_qcn9274_rx_desc_get_msdu_len,
-	.rx_desc_get_msdu_sgi = ath12k_hw_qcn9274_rx_desc_get_msdu_sgi,
-	.rx_desc_get_msdu_rate_mcs = ath12k_hw_qcn9274_rx_desc_get_msdu_rate_mcs,
-	.rx_desc_get_msdu_rx_bw = ath12k_hw_qcn9274_rx_desc_get_msdu_rx_bw,
-	.rx_desc_get_msdu_freq = ath12k_hw_qcn9274_rx_desc_get_msdu_freq,
-	.rx_desc_get_msdu_pkt_type = ath12k_hw_qcn9274_rx_desc_get_msdu_pkt_type,
-	.rx_desc_get_msdu_nss = ath12k_hw_qcn9274_rx_desc_get_msdu_nss,
-	.rx_desc_get_mpdu_tid = ath12k_hw_qcn9274_rx_desc_get_mpdu_tid,
-	.rx_desc_get_mpdu_peer_id = ath12k_hw_qcn9274_rx_desc_get_mpdu_peer_id,
-	.rx_desc_copy_end_tlv = ath12k_hw_qcn9274_rx_desc_copy_end_tlv,
-	.rx_desc_get_mpdu_ppdu_id = ath12k_hw_qcn9274_rx_desc_get_mpdu_ppdu_id,
-	.rx_desc_set_msdu_len = ath12k_hw_qcn9274_rx_desc_set_msdu_len,
-	.rx_desc_get_msdu_payload = ath12k_hw_qcn9274_rx_desc_get_msdu_payload,
-	.rx_desc_get_mpdu_start_offset = ath12k_hw_qcn9274_rx_desc_get_mpdu_start_offset,
-	.rx_desc_get_msdu_end_offset = ath12k_hw_qcn9274_rx_desc_get_msdu_end_offset,
-	.rx_desc_mac_addr2_valid = ath12k_hw_qcn9274_rx_desc_mac_addr2_valid,
-	.rx_desc_mpdu_start_addr2 = ath12k_hw_qcn9274_rx_desc_mpdu_start_addr2,
-	.rx_desc_is_da_mcbc = ath12k_hw_qcn9274_rx_desc_is_da_mcbc,
-	.rx_desc_get_dot11_hdr = ath12k_hw_qcn9274_rx_desc_get_dot11_hdr,
-	.rx_desc_get_crypto_header = ath12k_hw_qcn9274_rx_desc_get_crypto_hdr,
-	.dp_rx_h_msdu_done = ath12k_hw_qcn9274_dp_rx_h_msdu_done,
-	.dp_rx_h_l4_cksum_fail = ath12k_hw_qcn9274_dp_rx_h_l4_cksum_fail,
-	.dp_rx_h_ip_cksum_fail = ath12k_hw_qcn9274_dp_rx_h_ip_cksum_fail,
-	.dp_rx_h_is_decrypted = ath12k_hw_qcn9274_dp_rx_h_is_decrypted,
-	.dp_rx_h_mpdu_err = ath12k_hw_qcn9274_dp_rx_h_mpdu_err,
-	.rx_desc_get_desc_size = ath12k_hw_qcn9274_get_rx_desc_size,
-	.rx_desc_get_msdu_src_link_id = ath12k_hw_qcn9274_rx_desc_get_msdu_src_link,
-};
-EXPORT_SYMBOL(hal_rx_qcn9274_ops);
-
 static bool ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
 {
 	return !!le16_get_bits(desc->u.qcn9274_compact.msdu_end.info5,
@@ -786,7 +452,7 @@ static u8 ath12k_hw_qcn9274_compact_rx_desc_get_decap_type(struct hal_rx_desc *d
 
 static u8 ath12k_hw_qcn9274_compact_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
 {
-	return le32_get_bits(desc->u.qcn9274.msdu_end.info11,
+	return le32_get_bits(desc->u.qcn9274_compact.msdu_end.info11,
 			     RX_MSDU_END_INFO11_MESH_CTRL_PRESENT);
 }
 
@@ -1086,13 +752,13 @@ const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
 	.rx_desc_get_msdu_src_link_id =
 		ath12k_hw_qcn9274_compact_rx_desc_get_msdu_src_link,
 };
+EXPORT_SYMBOL(hal_rx_qcn9274_compact_ops);
 
 const struct hal_ops hal_qcn9274_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
 	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
 	.rxdma_ring_wmask_rx_mpdu_start = ath12k_hal_qcn9274_rx_mpdu_start_wmask_get,
 	.rxdma_ring_wmask_rx_msdu_end = ath12k_hal_qcn9274_rx_msdu_end_wmask_get,
-	.get_hal_rx_compact_ops = ath12k_hal_qcn9274_get_hal_rx_compact_ops,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
 
@@ -1561,7 +1227,6 @@ const struct hal_ops hal_wcn7850_ops = {
 	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
 	.rxdma_ring_wmask_rx_mpdu_start = NULL,
 	.rxdma_ring_wmask_rx_msdu_end = NULL,
-	.get_hal_rx_compact_ops = NULL,
 };
 EXPORT_SYMBOL(hal_wcn7850_ops);
 
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index c99878262a4a..e4c46a9ad94e 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1599,14 +1599,12 @@ struct hal_ops {
 	int (*create_srng_config)(struct ath12k_base *ab);
 	u16 (*rxdma_ring_wmask_rx_mpdu_start)(void);
 	u32 (*rxdma_ring_wmask_rx_msdu_end)(void);
-	const struct hal_rx_ops *(*get_hal_rx_compact_ops)(void);
 	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
 };
 
 extern const struct hal_ops hal_qcn9274_ops;
 extern const struct hal_ops hal_wcn7850_ops;
 
-extern const struct hal_rx_ops hal_rx_qcn9274_ops;
 extern const struct hal_rx_ops hal_rx_qcn9274_compact_ops;
 extern const struct hal_rx_ops hal_rx_wcn7850_ops;
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index d95e3c4daa5d..2105d9e94976 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -1901,15 +1901,13 @@ int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
 	tlv_filter.rx_msdu_end_offset =
 		ab->hal_rx_ops->rx_desc_get_msdu_end_offset();
 
-	if (ath12k_dp_wmask_compaction_rx_tlv_supported(ab)) {
-		tlv_filter.rx_mpdu_start_wmask =
-			ab->hw_params->hal_ops->rxdma_ring_wmask_rx_mpdu_start();
-		tlv_filter.rx_msdu_end_wmask =
-			ab->hw_params->hal_ops->rxdma_ring_wmask_rx_msdu_end();
-		ath12k_dbg(ab, ATH12K_DBG_DATA,
-			   "Configuring compact tlv masks rx_mpdu_start_wmask 0x%x rx_msdu_end_wmask 0x%x\n",
-			   tlv_filter.rx_mpdu_start_wmask, tlv_filter.rx_msdu_end_wmask);
-	}
+	tlv_filter.rx_mpdu_start_wmask =
+		ab->hw_params->hal_ops->rxdma_ring_wmask_rx_mpdu_start();
+	tlv_filter.rx_msdu_end_wmask =
+		ab->hw_params->hal_ops->rxdma_ring_wmask_rx_msdu_end();
+	ath12k_dbg(ab, ATH12K_DBG_DATA,
+		   "Configuring compact tlv masks rx_mpdu_start_wmask 0x%x rx_msdu_end_wmask 0x%x\n",
+		   tlv_filter.rx_mpdu_start_wmask, tlv_filter.rx_msdu_end_wmask);
 
 	ret = ath12k_dp_tx_htt_rx_filter_setup(ab, ring_id, 0,
 					       HAL_RXDMA_BUF,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h
index 60f165a176e0..cc5e1d336376 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h
@@ -1454,12 +1454,6 @@ struct rx_msdu_end_qcn9274_compact {
  *
  */
 
-struct hal_rx_desc_qcn9274 {
-	struct rx_msdu_end_qcn9274 msdu_end;
-	struct rx_mpdu_start_qcn9274 mpdu_start;
-	u8 msdu_payload[];
-} __packed;
-
 struct hal_rx_desc_qcn9274_compact {
 	struct rx_msdu_end_qcn9274_compact msdu_end;
 	struct rx_mpdu_start_qcn9274_compact mpdu_start;
@@ -1489,7 +1483,6 @@ struct hal_rx_desc_wcn7850 {
 
 struct hal_rx_desc {
 	union {
-		struct hal_rx_desc_qcn9274 qcn9274;
 		struct hal_rx_desc_qcn9274_compact qcn9274_compact;
 		struct hal_rx_desc_wcn7850 wcn7850;
 	} u;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/pci.c b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
index 9b1acf6c7aa3..abdb3b8ff658 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/pci.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
@@ -101,7 +101,7 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
 		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
 		ab->static_window_map = true;
 		ab_pci->pci_ops = &ath12k_wifi7_pci_ops_qcn9274;
-		ab->hal_rx_ops = &hal_rx_qcn9274_ops;
+		ab->hal_rx_ops = &hal_rx_qcn9274_compact_ops;
 		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
 						 &soc_hw_version_minor);
 		ab->target_mem_mode = ath12k_core_get_memory_mode(ab);
-- 
2.34.1


