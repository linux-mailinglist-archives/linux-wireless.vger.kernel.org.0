Return-Path: <linux-wireless+bounces-18554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBC8A29E72
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 02:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EBC3A6D09
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 01:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FBBBE49;
	Thu,  6 Feb 2025 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZZnIGWlv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4432C85
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805976; cv=none; b=O1w5gw3KZHdxfzqFkU8m6XA5/PD8CshN7sXSmvkDRNONO/IfL2dVtrR48WWv7rxAWaDP248ZudCsopxgeQZKY/o5yhaULby0XHNrZjMkbqbCZIHjfD73ZYsx8/zCr7fKomaA4qlFhu3Wf24nXNeLnMVshdD3fRs8JFIb82A2lpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805976; c=relaxed/simple;
	bh=q1mrFBZtEH4KyG3lS88yav9515a2fS5D4bAG6oOeSsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/Ys33VErqtQcKIEfOXZF+T6I3/i/Lx4dz+m9Y7yB57mq0YzU+q1tok7RgEpWURfefzJqCYMzF6l9GbHeDDcHpaoVDGNz0cXYlQR4sjZz5p6+H0xL03j3LSveXzp8k6tbVSkXsPH+T2+x2NRh9jvWfU86uG604FHAPWcQSa/MNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZZnIGWlv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515LDb94021201;
	Thu, 6 Feb 2025 01:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ki6difVjPOFRYk3xhaAC0PAIdBAWfaly5b+mcLNm/fw=; b=ZZnIGWlvTKuNdbzI
	izU9IEH5JsnBYtiXoMk9wAQXEXbe8ZSWOJcGGfCZ8d6eFnjfPru80okJ9ZybIQ3H
	qB+SbPkMzslyQ5272L1CmzIe4vaoSSA0+8I3I0/QigcFinAdqc1zxxHpglNxv7Ux
	GZ6HE3gRaYEsoWolzCd61KfGd4/sxenxHnrE8E2CxJ0vtWyHePNdZNQr6wbARYyf
	h+ea/u+1nL824fsoHpqP8s+gWeRgqcnvh6UxwR/qUR/0rsBd5h/VNhSD9US+YEzm
	t0tzA5kI3Xr1kUbs+AxJqlMfrwnItWcpQ0ZBsKHttWgxvPMANn7lnt0O9c7cu6F+
	+kzx1g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mfqcgegg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 01:39:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5161dVQT012318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Feb 2025 01:39:31 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 17:39:28 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH v9 1/9] wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
Date: Thu, 6 Feb 2025 07:08:46 +0530
Message-ID: <20250206013854.174765-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206013854.174765-1-quic_periyasa@quicinc.com>
References: <20250206013854.174765-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: Mq0Jwmel-ei6avGuDX_gcbI83zjAQEqn
X-Proofpoint-ORIG-GUID: Mq0Jwmel-ei6avGuDX_gcbI83zjAQEqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060010

Currently, monitor is not enabled. However, in the future, the monitor
will be enabled. Therefore, add the necessary HAL_PHYRX_GENERIC_U_SIG TLV
parsing support in monitor Rx path, which help to populate the EHT
radiotap data.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 205 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_rx.h |  60 +++++++
 2 files changed, 264 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 4e9a60181c06..61fd481b7a3b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -10,6 +10,9 @@
 #include "dp_tx.h"
 #include "peer.h"
 
+#define ATH12K_LE32_DEC_ENC(value, dec_bits, enc_bits)	\
+		u32_encode_bits(le32_get_bits(value, dec_bits), enc_bits)
+
 static void
 ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
 				   struct hal_rx_user_status *rx_user_status)
@@ -562,6 +565,187 @@ static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *
 	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
 }
 
+static void
+ath12k_dp_mon_hal_rx_parse_u_sig_cmn(const struct hal_mon_usig_cmn *cmn,
+				     struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	u32 common;
+	u8 bw;
+
+	bw = le32_get_bits(cmn->info0, HAL_RX_USIG_CMN_INFO0_BW);
+
+	common = __le32_to_cpu(ppdu_info->usig.common);
+	common |= IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER_KNOWN |
+		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_KNOWN |
+		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL_KNOWN |
+		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR_KNOWN |
+		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP_KNOWN |
+		  ATH12K_LE32_DEC_ENC(cmn->info0,
+				      HAL_RX_USIG_CMN_INFO0_PHY_VERSION,
+				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER) |
+		  u32_encode_bits(bw, IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW) |
+		  ATH12K_LE32_DEC_ENC(cmn->info0,
+				      HAL_RX_USIG_CMN_INFO0_UL_DL,
+				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL) |
+		  ATH12K_LE32_DEC_ENC(cmn->info0,
+				      HAL_RX_USIG_CMN_INFO0_BSS_COLOR,
+				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR) |
+		  ATH12K_LE32_DEC_ENC(cmn->info0,
+				      HAL_RX_USIG_CMN_INFO0_TXOP,
+				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
+	ppdu_info->usig.common = cpu_to_le32(common);
+
+	switch (bw) {
+	default:
+		fallthrough;
+	case HAL_EHT_BW_20:
+		ppdu_info->bw = HAL_RX_BW_20MHZ;
+		break;
+	case HAL_EHT_BW_40:
+		ppdu_info->bw = HAL_RX_BW_40MHZ;
+		break;
+	case HAL_EHT_BW_80:
+		ppdu_info->bw = HAL_RX_BW_80MHZ;
+		break;
+	case HAL_EHT_BW_160:
+		ppdu_info->bw = HAL_RX_BW_160MHZ;
+		break;
+	case HAL_EHT_BW_320_1:
+	case HAL_EHT_BW_320_2:
+		ppdu_info->bw = HAL_RX_BW_320MHZ;
+		break;
+	}
+}
+
+static void
+ath12k_dp_mon_hal_rx_parse_u_sig_tb(const struct hal_mon_usig_tb *usig_tb,
+				    struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	enum ieee80211_radiotap_eht_usig_tb spatial_reuse1, spatial_reuse2;
+	u32 common, value, mask;
+
+	spatial_reuse1 = IEEE80211_RADIOTAP_EHT_USIG2_TB_B3_B6_SPATIAL_REUSE_1;
+	spatial_reuse2 = IEEE80211_RADIOTAP_EHT_USIG2_TB_B7_B10_SPATIAL_REUSE_2;
+
+	common = __le32_to_cpu(ppdu_info->usig.common);
+	value = __le32_to_cpu(ppdu_info->usig.value);
+	mask = __le32_to_cpu(ppdu_info->usig.mask);
+
+	common |= ATH12K_LE32_DEC_ENC(usig_tb->info0,
+				      HAL_RX_USIG_TB_INFO0_RX_INTEG_CHECK_PASS,
+				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC);
+
+	value |= IEEE80211_RADIOTAP_EHT_USIG1_TB_B20_B25_DISREGARD |
+		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
+				     HAL_RX_USIG_TB_INFO0_PPDU_TYPE_COMP_MODE,
+				     IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE) |
+		 IEEE80211_RADIOTAP_EHT_USIG2_TB_B2_VALIDATE |
+		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
+				     HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_1,
+				     spatial_reuse1) |
+		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
+				     HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_2,
+				     spatial_reuse2) |
+		 IEEE80211_RADIOTAP_EHT_USIG2_TB_B11_B15_DISREGARD |
+		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
+				     HAL_RX_USIG_TB_INFO0_CRC,
+				     IEEE80211_RADIOTAP_EHT_USIG2_TB_B16_B19_CRC) |
+		 ATH12K_LE32_DEC_ENC(usig_tb->info0,
+				     HAL_RX_USIG_TB_INFO0_TAIL,
+				     IEEE80211_RADIOTAP_EHT_USIG2_TB_B20_B25_TAIL);
+
+	mask |= IEEE80211_RADIOTAP_EHT_USIG1_TB_B20_B25_DISREGARD |
+		IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE |
+		IEEE80211_RADIOTAP_EHT_USIG2_TB_B2_VALIDATE |
+		spatial_reuse1 | spatial_reuse2 |
+		IEEE80211_RADIOTAP_EHT_USIG2_TB_B11_B15_DISREGARD |
+		IEEE80211_RADIOTAP_EHT_USIG2_TB_B16_B19_CRC |
+		IEEE80211_RADIOTAP_EHT_USIG2_TB_B20_B25_TAIL;
+
+	ppdu_info->usig.common = cpu_to_le32(common);
+	ppdu_info->usig.value = cpu_to_le32(value);
+	ppdu_info->usig.mask = cpu_to_le32(mask);
+}
+
+static void
+ath12k_dp_mon_hal_rx_parse_u_sig_mu(const struct hal_mon_usig_mu *usig_mu,
+				    struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	enum ieee80211_radiotap_eht_usig_mu sig_symb, punc;
+	u32 common, value, mask;
+
+	sig_symb = IEEE80211_RADIOTAP_EHT_USIG2_MU_B11_B15_EHT_SIG_SYMBOLS;
+	punc = IEEE80211_RADIOTAP_EHT_USIG2_MU_B3_B7_PUNCTURED_INFO;
+
+	common = __le32_to_cpu(ppdu_info->usig.common);
+	value = __le32_to_cpu(ppdu_info->usig.value);
+	mask = __le32_to_cpu(ppdu_info->usig.mask);
+
+	common |= ATH12K_LE32_DEC_ENC(usig_mu->info0,
+				      HAL_RX_USIG_MU_INFO0_RX_INTEG_CHECK_PASS,
+				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC);
+
+	value |= IEEE80211_RADIOTAP_EHT_USIG1_MU_B20_B24_DISREGARD |
+		 IEEE80211_RADIOTAP_EHT_USIG1_MU_B25_VALIDATE |
+		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
+				     HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE,
+				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE) |
+		 IEEE80211_RADIOTAP_EHT_USIG2_MU_B2_VALIDATE |
+		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
+				     HAL_RX_USIG_MU_INFO0_PUNC_CH_INFO,
+				     punc) |
+		 IEEE80211_RADIOTAP_EHT_USIG2_MU_B8_VALIDATE |
+		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
+				     HAL_RX_USIG_MU_INFO0_EHT_SIG_MCS,
+				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS) |
+		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
+				     HAL_RX_USIG_MU_INFO0_NUM_EHT_SIG_SYM,
+				     sig_symb) |
+		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
+				     HAL_RX_USIG_MU_INFO0_CRC,
+				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B16_B19_CRC) |
+		 ATH12K_LE32_DEC_ENC(usig_mu->info0,
+				     HAL_RX_USIG_MU_INFO0_TAIL,
+				     IEEE80211_RADIOTAP_EHT_USIG2_MU_B20_B25_TAIL);
+
+	mask |= IEEE80211_RADIOTAP_EHT_USIG1_MU_B20_B24_DISREGARD |
+		IEEE80211_RADIOTAP_EHT_USIG1_MU_B25_VALIDATE |
+		IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE |
+		IEEE80211_RADIOTAP_EHT_USIG2_MU_B2_VALIDATE |
+		punc |
+		IEEE80211_RADIOTAP_EHT_USIG2_MU_B8_VALIDATE |
+		IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS |
+		sig_symb |
+		IEEE80211_RADIOTAP_EHT_USIG2_MU_B16_B19_CRC |
+		IEEE80211_RADIOTAP_EHT_USIG2_MU_B20_B25_TAIL;
+
+	ppdu_info->usig.common = cpu_to_le32(common);
+	ppdu_info->usig.value = cpu_to_le32(value);
+	ppdu_info->usig.mask = cpu_to_le32(mask);
+}
+
+static void
+ath12k_dp_mon_hal_rx_parse_u_sig_hdr(const struct hal_mon_usig_hdr *usig,
+				     struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	const struct hal_mon_usig_cmn *usig_cmn = &usig->cmn;
+	u8 comp_mode;
+	bool ap_ppdu;
+
+	ppdu_info->eht_usig = true;
+
+	ath12k_dp_mon_hal_rx_parse_u_sig_cmn(&usig->cmn, ppdu_info);
+
+	ap_ppdu = le32_get_bits(usig_cmn->info0, HAL_RX_USIG_CMN_INFO0_UL_DL);
+	comp_mode = le32_get_bits(usig->non_cmn.mu.info0,
+				  HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE);
+
+	if (comp_mode == 0 && ap_ppdu)
+		ath12k_dp_mon_hal_rx_parse_u_sig_tb(&usig->non_cmn.tb, ppdu_info);
+	else
+		ath12k_dp_mon_hal_rx_parse_u_sig_mu(&usig->non_cmn.mu, ppdu_info);
+}
+
 static enum hal_rx_mon_status
 ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 				  struct ath12k_mon_data *pmon,
@@ -774,6 +958,9 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 		return HAL_RX_MON_STATUS_MSDU_END;
 	case HAL_RX_MPDU_END:
 		return HAL_RX_MON_STATUS_MPDU_END;
+	case HAL_PHYRX_GENERIC_U_SIG:
+		ath12k_dp_mon_hal_rx_parse_u_sig_hdr(tlv_data, ppdu_info);
+		break;
 	case HAL_DUMMY:
 		return HAL_RX_MON_STATUS_BUF_DONE;
 	case HAL_RX_PPDU_END_STATUS_DONE:
@@ -971,7 +1158,23 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 		rxs->ampdu_reference = ampdu_id;
 	}
 
-	if (ppduinfo->he_mu_flags) {
+	if (ppduinfo->eht_usig) {
+		struct ieee80211_radiotap_tlv *tlv;
+		struct ieee80211_radiotap_eht_usig *usig;
+		u16 len = sizeof(*usig);
+
+		rxs->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
+		rxs->encoding = RX_ENC_EHT;
+
+		skb_reset_mac_header(mon_skb);
+
+		tlv = skb_push(mon_skb, sizeof(*tlv) + len);
+		tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT_USIG);
+		tlv->len = cpu_to_le16(len);
+
+		usig = (struct ieee80211_radiotap_eht_usig *)tlv->data;
+		*usig = ppduinfo->usig;
+	} else if (ppduinfo->he_mu_flags) {
 		rxs->flag |= RX_FLAG_RADIOTAP_HE_MU;
 		rxs->encoding = RX_ENC_HE;
 		ptr = skb_push(mon_skb, sizeof(struct ieee80211_radiotap_he_mu));
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 96954b2f7ca6..2da16f27e76c 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -235,6 +235,8 @@ struct hal_rx_mon_ppdu_info {
 	bool is_ampdu;
 	u8 medium_prot_type;
 	bool ppdu_continuation;
+	bool eht_usig;
+	struct ieee80211_radiotap_eht_usig usig;
 };
 
 #define HAL_RX_PPDU_START_INFO0_PPDU_ID			GENMASK(15, 0)
@@ -678,6 +680,64 @@ enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
 	return ret;
 }
 
+enum hal_eht_bw {
+	HAL_EHT_BW_20,
+	HAL_EHT_BW_40,
+	HAL_EHT_BW_80,
+	HAL_EHT_BW_160,
+	HAL_EHT_BW_320_1,
+	HAL_EHT_BW_320_2,
+};
+
+#define HAL_RX_USIG_CMN_INFO0_PHY_VERSION	GENMASK(2, 0)
+#define HAL_RX_USIG_CMN_INFO0_BW		GENMASK(5, 3)
+#define HAL_RX_USIG_CMN_INFO0_UL_DL		BIT(6)
+#define HAL_RX_USIG_CMN_INFO0_BSS_COLOR		GENMASK(12, 7)
+#define HAL_RX_USIG_CMN_INFO0_TXOP		GENMASK(19, 13)
+#define HAL_RX_USIG_CMN_INFO0_DISREGARD		GENMASK(25, 20)
+#define HAL_RX_USIG_CMN_INFO0_VALIDATE		BIT(26)
+
+struct hal_mon_usig_cmn {
+	__le32 info0;
+} __packed;
+
+#define HAL_RX_USIG_TB_INFO0_PPDU_TYPE_COMP_MODE	GENMASK(1, 0)
+#define HAL_RX_USIG_TB_INFO0_VALIDATE			BIT(2)
+#define HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_1		GENMASK(6, 3)
+#define HAL_RX_USIG_TB_INFO0_SPATIAL_REUSE_2		GENMASK(10, 7)
+#define HAL_RX_USIG_TB_INFO0_DISREGARD_1		GENMASK(15, 11)
+#define HAL_RX_USIG_TB_INFO0_CRC			GENMASK(19, 16)
+#define HAL_RX_USIG_TB_INFO0_TAIL			GENMASK(25, 20)
+#define HAL_RX_USIG_TB_INFO0_RX_INTEG_CHECK_PASS	BIT(31)
+
+struct hal_mon_usig_tb {
+	__le32 info0;
+} __packed;
+
+#define HAL_RX_USIG_MU_INFO0_PPDU_TYPE_COMP_MODE	GENMASK(1, 0)
+#define HAL_RX_USIG_MU_INFO0_VALIDATE_1			BIT(2)
+#define HAL_RX_USIG_MU_INFO0_PUNC_CH_INFO		GENMASK(7, 3)
+#define HAL_RX_USIG_MU_INFO0_VALIDATE_2			BIT(8)
+#define HAL_RX_USIG_MU_INFO0_EHT_SIG_MCS		GENMASK(10, 9)
+#define HAL_RX_USIG_MU_INFO0_NUM_EHT_SIG_SYM		GENMASK(15, 11)
+#define HAL_RX_USIG_MU_INFO0_CRC			GENMASK(20, 16)
+#define HAL_RX_USIG_MU_INFO0_TAIL			GENMASK(26, 21)
+#define HAL_RX_USIG_MU_INFO0_RX_INTEG_CHECK_PASS	BIT(31)
+
+struct hal_mon_usig_mu {
+	__le32 info0;
+} __packed;
+
+union hal_mon_usig_non_cmn {
+	struct hal_mon_usig_tb tb;
+	struct hal_mon_usig_mu mu;
+};
+
+struct hal_mon_usig_hdr {
+	struct hal_mon_usig_cmn cmn;
+	union hal_mon_usig_non_cmn non_cmn;
+} __packed;
+
 void ath12k_hal_reo_status_queue_stats(struct ath12k_base *ab,
 				       struct hal_tlv_64_hdr *tlv,
 				       struct hal_reo_status *status);
-- 
2.34.1


