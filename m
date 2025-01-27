Return-Path: <linux-wireless+bounces-18007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F292A1D4BA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 11:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66E63A2A32
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE271D540;
	Mon, 27 Jan 2025 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JAczkQHM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926A1FE44E
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974889; cv=none; b=qxd+oaEtTLids8/SPoMuZ7aEzpFEPqjokxccbPoZGq3VgPtG9HpQsSQE7CsQjLzhWWTWYYQvdew5J8fnij2fcjm2pZaxJqUMquecAdwX3J/RifdH9ZragrQBMgxBpVgyHl/UbpRuy/qhm0A0UFI8PwxbuEI4UJdEmzjKWXJ9ZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974889; c=relaxed/simple;
	bh=3lMpKG4NsSGUC7uAEU/GV1ca5CtYj80/rkEm9VSrwjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmySYbVSwtlFxNO3NLO2t0qvin1YKMtG5kdw+Ywi2kN4bnNCh3b2Ri30pezRPRpxbwAZavYDf9AcAUz5E86oGf+qmdLiBXimQ2dgeZGRnUp87M2FkPQJpulfU3gjkiOrAK08d3QwMNAGS8H4zjsZypBnEeSObLWqqLPMarf0/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JAczkQHM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R9l29Y026728;
	Mon, 27 Jan 2025 10:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W7zNzdZiO5lu1y54c05kYkU6WFQ7PsQUxMBXuAxkfbc=; b=JAczkQHMk/cgInZp
	aPK1wrVgKgFD9yHE3a9pUTYJkP4TfWVAqGl7N78+/Ym+eeaX3lC7JoLoTQHzrCpO
	+hoVd5ldcwDP6XdW7dLOnedUpV74mWMsEiu/lJwZJzRYc8zPH+lKgg1gC5xdYbVM
	k00dJJfbjqvVjCToF4ZIdxl4NACSdRkAsXsw6jdV9hYV/WLPqkHmPQK4D5RL6NnE
	70/4SvrM+2bNxfSQ5KtsRa/h/RwLmu6ewzqGym/dvFQ44re8u+RXIvfa27SOJf2p
	2a+VWmwOqdRuXvD6fQ9QBZ1uwtZ0n5nqzfBYAoBgep5XZKCkjfEtdWSxrddIlrEa
	4Y+G0g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44e7tj839f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:48:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50RAm3tA032024
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:48:03 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 02:48:01 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v5 3/9] wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
Date: Mon, 27 Jan 2025 16:17:32 +0530
Message-ID: <20250127104738.4174862-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
References: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -PPx569_EuZQBBLAf1vfSqhYCBgKFWcD
X-Proofpoint-GUID: -PPx569_EuZQBBLAf1vfSqhYCBgKFWcD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270087

Currently, monitor is not enabled. However, in the future, the monitor
will be enabled. Therefore, add necessary HAL_RX_PPDU_START_USER_INFO TLV
parsing support in monitor Rx path, which help to populate the EHT radiotap
data.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c  | 309 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_rx.h  | 291 +++++++++++++++++---
 drivers/net/wireless/ath/ath12k/rx_desc.h |   9 -
 3 files changed, 553 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 3636916c5d37..f9de8c509061 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -81,7 +81,7 @@ ath12k_dp_mon_rx_populate_mu_user_info(const struct hal_rx_ppdu_end_user_stats *
 static void ath12k_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vht_sig,
 					  struct hal_rx_mon_ppdu_info *ppdu_info)
 {
-	u32 nsts, group_id, info0, info1;
+	u32 nsts, info0, info1;
 	u8 gi_setting;
 
 	info0 = __le32_to_cpu(vht_sig->info0);
@@ -109,12 +109,8 @@ static void ath12k_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vh
 	ppdu_info->bw = u32_get_bits(info0, HAL_RX_VHT_SIG_A_INFO_INFO0_BW);
 	ppdu_info->beamformed = u32_get_bits(info1,
 					     HAL_RX_VHT_SIG_A_INFO_INFO1_BEAMFORMED);
-	group_id = u32_get_bits(info0, HAL_RX_VHT_SIG_A_INFO_INFO0_GROUP_ID);
-	if (group_id == 0 || group_id == 63)
-		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
-	else
-		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
-	ppdu_info->vht_flag_values5 = group_id;
+	ppdu_info->vht_flag_values5 = u32_get_bits(info0,
+						   HAL_RX_VHT_SIG_A_INFO_INFO0_GROUP_ID);
 	ppdu_info->vht_flag_values3[0] = (((ppdu_info->mcs) << 4) |
 					    ppdu_info->nss);
 	ppdu_info->vht_flag_values2 = ppdu_info->bw;
@@ -134,7 +130,6 @@ static void ath12k_dp_mon_parse_ht_sig(const struct hal_rx_ht_sig_info *ht_sig,
 	ppdu_info->ldpc = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_FEC_CODING);
 	ppdu_info->gi = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_GI);
 	ppdu_info->nss = (ppdu_info->mcs >> 3);
-	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
 }
 
 static void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
@@ -166,7 +161,6 @@ static void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
 
 	ppdu_info->rate = rate;
 	ppdu_info->cck_flag = 1;
-	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
 }
 
 static void ath12k_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
@@ -206,7 +200,6 @@ static void ath12k_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
 	}
 
 	ppdu_info->rate = rate;
-	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
 }
 
 static void
@@ -243,7 +236,6 @@ ath12k_dp_mon_parse_he_sig_b2_ofdma(const struct hal_rx_he_sig_b2_ofdma_info *of
 	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_NSTS);
 	ppdu_info->beamformed = u32_get_bits(info0,
 					     HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF);
-	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_OFDMA;
 }
 
 static void
@@ -283,7 +275,6 @@ ath12k_dp_mon_parse_he_sig_b1_mu(const struct hal_rx_he_sig_b1_mu_info *he_sig_b
 				HAL_RX_HE_SIG_B1_MU_INFO_INFO0_RU_ALLOCATION);
 	ppdu_info->ru_alloc = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
 	ppdu_info->he_RU[0] = ru_tones;
-	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
 }
 
 static void
@@ -417,7 +408,6 @@ ath12k_dp_mon_parse_he_sig_mu(const struct hal_rx_he_sig_a_mu_dl_info *he_sig_a_
 
 	ppdu_info->is_stbc = info1 &
 			     HAL_RX_HE_SIG_A_MU_DL_INFO1_STBC;
-	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
 }
 
 static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *he_sig_a,
@@ -565,7 +555,6 @@ static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *
 	dcm = u32_get_bits(info0, HAL_RX_HE_SIG_A_SU_INFO_INFO0_DCM);
 	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_A_SU_INFO_INFO0_NSTS);
 	ppdu_info->dcm = dcm;
-	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
 }
 
 static enum hal_rx_mon_status
@@ -1170,6 +1159,294 @@ ath12k_dp_mon_parse_eht_sig_hdr(struct hal_rx_mon_ppdu_info *ppdu_info,
 		ath12k_dp_mon_hal_rx_parse_eht_sig_ofdma(tlv_data, ppdu_info);
 }
 
+static inline enum ath12k_eht_ru_size
+hal_rx_mon_hal_ru_size_to_ath12k_ru_size(u32 hal_ru_size)
+{
+	switch (hal_ru_size) {
+	case HAL_EHT_RU_26:
+		return ATH12K_EHT_RU_26;
+	case HAL_EHT_RU_52:
+		return ATH12K_EHT_RU_52;
+	case HAL_EHT_RU_78:
+		return ATH12K_EHT_RU_52_26;
+	case HAL_EHT_RU_106:
+		return ATH12K_EHT_RU_106;
+	case HAL_EHT_RU_132:
+		return ATH12K_EHT_RU_106_26;
+	case HAL_EHT_RU_242:
+		return ATH12K_EHT_RU_242;
+	case HAL_EHT_RU_484:
+		return ATH12K_EHT_RU_484;
+	case HAL_EHT_RU_726:
+		return ATH12K_EHT_RU_484_242;
+	case HAL_EHT_RU_996:
+		return ATH12K_EHT_RU_996;
+	case HAL_EHT_RU_996x2:
+		return ATH12K_EHT_RU_996x2;
+	case HAL_EHT_RU_996x3:
+		return ATH12K_EHT_RU_996x3;
+	case HAL_EHT_RU_996x4:
+		return ATH12K_EHT_RU_996x4;
+	case HAL_EHT_RU_NONE:
+		return ATH12K_EHT_RU_INVALID;
+	case HAL_EHT_RU_996_484:
+		return ATH12K_EHT_RU_996_484;
+	case HAL_EHT_RU_996x2_484:
+		return ATH12K_EHT_RU_996x2_484;
+	case HAL_EHT_RU_996x3_484:
+		return ATH12K_EHT_RU_996x3_484;
+	case HAL_EHT_RU_996_484_242:
+		return ATH12K_EHT_RU_996_484_242;
+	default:
+		return ATH12K_EHT_RU_INVALID;
+	}
+}
+
+static inline u32
+hal_rx_ul_ofdma_ru_size_to_width(enum ath12k_eht_ru_size ru_size)
+{
+	switch (ru_size) {
+	case ATH12K_EHT_RU_26:
+		return RU_26;
+	case ATH12K_EHT_RU_52:
+		return RU_52;
+	case ATH12K_EHT_RU_52_26:
+		return RU_52_26;
+	case ATH12K_EHT_RU_106:
+		return RU_106;
+	case ATH12K_EHT_RU_106_26:
+		return RU_106_26;
+	case ATH12K_EHT_RU_242:
+		return RU_242;
+	case ATH12K_EHT_RU_484:
+		return RU_484;
+	case ATH12K_EHT_RU_484_242:
+		return RU_484_242;
+	case ATH12K_EHT_RU_996:
+		return RU_996;
+	case ATH12K_EHT_RU_996_484:
+		return RU_996_484;
+	case ATH12K_EHT_RU_996_484_242:
+		return RU_996_484_242;
+	case ATH12K_EHT_RU_996x2:
+		return RU_2X996;
+	case ATH12K_EHT_RU_996x2_484:
+		return RU_2X996_484;
+	case ATH12K_EHT_RU_996x3:
+		return RU_3X996;
+	case ATH12K_EHT_RU_996x3_484:
+		return RU_3X996_484;
+	case ATH12K_EHT_RU_996x4:
+		return RU_4X996;
+	default:
+		return RU_INVALID;
+	}
+}
+
+static enum hal_rx_mon_status
+ath12k_dp_mon_hal_rx_parse_user_info(const struct hal_receive_user_info *rx_usr_info,
+				     u16 user_id,
+				     struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	struct hal_rx_user_status *mon_rx_user_status = NULL;
+	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
+	enum ath12k_eht_ru_size rtap_ru_size = ATH12K_EHT_RU_INVALID;
+	u32 ru_width, reception_type, ru_index = HAL_EHT_RU_INVALID;
+	u32 ru_type_80_0, ru_start_index_80_0;
+	u32 ru_type_80_1, ru_start_index_80_1;
+	u32 ru_type_80_2, ru_start_index_80_2;
+	u32 ru_type_80_3, ru_start_index_80_3;
+	u32 ru_size = 0, num_80mhz_with_ru = 0;
+	u64 ru_index_320mhz = 0;
+	u32 ru_index_per80mhz;
+
+	reception_type = le32_get_bits(rx_usr_info->info0,
+				       HAL_RX_USR_INFO0_RECEPTION_TYPE);
+
+	switch (reception_type) {
+	case HAL_RECEPTION_TYPE_SU:
+		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
+		break;
+	case HAL_RECEPTION_TYPE_DL_MU_MIMO:
+	case HAL_RECEPTION_TYPE_UL_MU_MIMO:
+		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
+		break;
+	case HAL_RECEPTION_TYPE_DL_MU_OFMA:
+	case HAL_RECEPTION_TYPE_UL_MU_OFDMA:
+		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_OFDMA;
+		break;
+	case HAL_RECEPTION_TYPE_DL_MU_OFDMA_MIMO:
+	case HAL_RECEPTION_TYPE_UL_MU_OFDMA_MIMO:
+		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_OFDMA_MIMO;
+	}
+
+	ppdu_info->is_stbc = le32_get_bits(rx_usr_info->info0, HAL_RX_USR_INFO0_STBC);
+	ppdu_info->ldpc = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_LDPC);
+	ppdu_info->dcm = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_STA_DCM);
+	ppdu_info->bw = le32_get_bits(rx_usr_info->info1, HAL_RX_USR_INFO1_RX_BW);
+	ppdu_info->mcs = le32_get_bits(rx_usr_info->info1, HAL_RX_USR_INFO1_MCS);
+	ppdu_info->nss = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_NSS) + 1;
+
+	if (user_id < HAL_MAX_UL_MU_USERS) {
+		mon_rx_user_status = &ppdu_info->userstats[user_id];
+		mon_rx_user_status->mcs = ppdu_info->mcs;
+		mon_rx_user_status->nss = ppdu_info->nss;
+	}
+
+	if (!(ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_MU_MIMO ||
+	      ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_MU_OFDMA ||
+	      ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_MU_OFDMA_MIMO))
+		return HAL_TLV_STATUS_PPDU_NOT_DONE;
+
+	/* RU allocation present only for OFDMA reception */
+	ru_type_80_0 = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_RU_TYPE_80_0);
+	ru_start_index_80_0 = le32_get_bits(rx_usr_info->info3,
+					    HAL_RX_USR_INFO3_RU_START_IDX_80_0);
+	if (ru_type_80_0 != HAL_EHT_RU_NONE) {
+		ru_size += ru_type_80_0;
+		ru_index_per80mhz = ru_start_index_80_0;
+		ru_index = ru_index_per80mhz;
+		ru_index_320mhz |= HAL_RU_PER80(ru_type_80_0, 0, ru_index_per80mhz);
+		num_80mhz_with_ru++;
+	}
+
+	ru_type_80_1 = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_RU_TYPE_80_1);
+	ru_start_index_80_1 = le32_get_bits(rx_usr_info->info3,
+					    HAL_RX_USR_INFO3_RU_START_IDX_80_1);
+	if (ru_type_80_1 != HAL_EHT_RU_NONE) {
+		ru_size += ru_type_80_1;
+		ru_index_per80mhz = ru_start_index_80_1;
+		ru_index = ru_index_per80mhz;
+		ru_index_320mhz |= HAL_RU_PER80(ru_type_80_1, 1, ru_index_per80mhz);
+		num_80mhz_with_ru++;
+	}
+
+	ru_type_80_2 = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_RU_TYPE_80_2);
+	ru_start_index_80_2 = le32_get_bits(rx_usr_info->info3,
+					    HAL_RX_USR_INFO3_RU_START_IDX_80_2);
+	if (ru_type_80_2 != HAL_EHT_RU_NONE) {
+		ru_size += ru_type_80_2;
+		ru_index_per80mhz = ru_start_index_80_2;
+		ru_index = ru_index_per80mhz;
+		ru_index_320mhz |= HAL_RU_PER80(ru_type_80_2, 2, ru_index_per80mhz);
+		num_80mhz_with_ru++;
+	}
+
+	ru_type_80_3 = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_RU_TYPE_80_3);
+	ru_start_index_80_3 = le32_get_bits(rx_usr_info->info2,
+					    HAL_RX_USR_INFO3_RU_START_IDX_80_3);
+	if (ru_type_80_3 != HAL_EHT_RU_NONE) {
+		ru_size += ru_type_80_3;
+		ru_index_per80mhz = ru_start_index_80_3;
+		ru_index = ru_index_per80mhz;
+		ru_index_320mhz |= HAL_RU_PER80(ru_type_80_3, 3, ru_index_per80mhz);
+		num_80mhz_with_ru++;
+	}
+
+	if (num_80mhz_with_ru > 1) {
+		/* Calculate the MRU index */
+		switch (ru_index_320mhz) {
+		case HAL_EHT_RU_996_484_0:
+		case HAL_EHT_RU_996x2_484_0:
+		case HAL_EHT_RU_996x3_484_0:
+			ru_index = 0;
+			break;
+		case HAL_EHT_RU_996_484_1:
+		case HAL_EHT_RU_996x2_484_1:
+		case HAL_EHT_RU_996x3_484_1:
+			ru_index = 1;
+			break;
+		case HAL_EHT_RU_996_484_2:
+		case HAL_EHT_RU_996x2_484_2:
+		case HAL_EHT_RU_996x3_484_2:
+			ru_index = 2;
+			break;
+		case HAL_EHT_RU_996_484_3:
+		case HAL_EHT_RU_996x2_484_3:
+		case HAL_EHT_RU_996x3_484_3:
+			ru_index = 3;
+			break;
+		case HAL_EHT_RU_996_484_4:
+		case HAL_EHT_RU_996x2_484_4:
+		case HAL_EHT_RU_996x3_484_4:
+			ru_index = 4;
+			break;
+		case HAL_EHT_RU_996_484_5:
+		case HAL_EHT_RU_996x2_484_5:
+		case HAL_EHT_RU_996x3_484_5:
+			ru_index = 5;
+			break;
+		case HAL_EHT_RU_996_484_6:
+		case HAL_EHT_RU_996x2_484_6:
+		case HAL_EHT_RU_996x3_484_6:
+			ru_index = 6;
+			break;
+		case HAL_EHT_RU_996_484_7:
+		case HAL_EHT_RU_996x2_484_7:
+		case HAL_EHT_RU_996x3_484_7:
+			ru_index = 7;
+			break;
+		case HAL_EHT_RU_996x2_484_8:
+			ru_index = 8;
+			break;
+		case HAL_EHT_RU_996x2_484_9:
+			ru_index = 9;
+			break;
+		case HAL_EHT_RU_996x2_484_10:
+			ru_index = 10;
+			break;
+		case HAL_EHT_RU_996x2_484_11:
+			ru_index = 11;
+			break;
+		default:
+			ru_index = HAL_EHT_RU_INVALID;
+			break;
+		}
+
+		ru_size += 4;
+	}
+
+	rtap_ru_size = hal_rx_mon_hal_ru_size_to_ath12k_ru_size(ru_size);
+	if (rtap_ru_size != ATH12K_EHT_RU_INVALID) {
+		u32 known, data;
+
+		known = __le32_to_cpu(eht->known);
+		known |= IEEE80211_RADIOTAP_EHT_KNOWN_RU_MRU_SIZE_OM;
+		eht->known = cpu_to_le32(known);
+
+		data = __le32_to_cpu(eht->data[1]);
+		data |=	u32_encode_bits(rtap_ru_size,
+					IEEE80211_RADIOTAP_EHT_DATA1_RU_SIZE);
+		eht->data[1] = cpu_to_le32(data);
+	}
+
+	if (ru_index != HAL_EHT_RU_INVALID) {
+		u32 known, data;
+
+		known = __le32_to_cpu(eht->known);
+		known |= IEEE80211_RADIOTAP_EHT_KNOWN_RU_MRU_INDEX_OM;
+		eht->known = cpu_to_le32(known);
+
+		data = __le32_to_cpu(eht->data[1]);
+		data |=	u32_encode_bits(rtap_ru_size,
+					IEEE80211_RADIOTAP_EHT_DATA1_RU_INDEX);
+		eht->data[1] = cpu_to_le32(data);
+	}
+
+	if (mon_rx_user_status && ru_index != HAL_EHT_RU_INVALID &&
+	    rtap_ru_size != ATH12K_EHT_RU_INVALID) {
+		mon_rx_user_status->ul_ofdma_ru_start_index = ru_index;
+		mon_rx_user_status->ul_ofdma_ru_size = rtap_ru_size;
+
+		ru_width = hal_rx_ul_ofdma_ru_size_to_width(rtap_ru_size);
+
+		mon_rx_user_status->ul_ofdma_ru_width = ru_width;
+		mon_rx_user_status->ofdma_info_valid = 1;
+	}
+
+	return HAL_TLV_STATUS_PPDU_NOT_DONE;
+}
+
 static enum hal_rx_mon_status
 ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 				  struct ath12k_mon_data *pmon,
@@ -1353,6 +1630,10 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 					     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RX_BW);
 		break;
 	}
+	case HAL_RX_PPDU_START_USER_INFO:
+		ath12k_dp_mon_hal_rx_parse_user_info(tlv_data, userid, ppdu_info);
+		break;
+
 	case HAL_RXPCU_PPDU_END_INFO: {
 		const struct hal_rx_ppdu_end_duration *ppdu_rx_duration = tlv_data;
 
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 959f2283294c..765b53741861 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -781,39 +781,6 @@ struct hal_eht_sig_ofdma_cmn_eb {
 	union hal_eht_sig_user_field user_field;
 } __packed;
 
-static inline
-enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
-{
-	enum nl80211_he_ru_alloc ret;
-
-	switch (ru_tones) {
-	case RU_52:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
-		break;
-	case RU_106:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
-		break;
-	case RU_242:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
-		break;
-	case RU_484:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
-		break;
-	case RU_996:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
-		break;
-	case RU_2X996:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
-		break;
-	case RU_26:
-		fallthrough;
-	default:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
-		break;
-	}
-	return ret;
-}
-
 enum hal_eht_bw {
 	HAL_EHT_BW_20,
 	HAL_EHT_BW_40,
@@ -872,6 +839,264 @@ struct hal_mon_usig_hdr {
 	union hal_mon_usig_non_cmn non_cmn;
 } __packed;
 
+#define HAL_RX_USR_INFO0_PHY_PPDU_ID		GENMASK(15, 0)
+#define HAL_RX_USR_INFO0_USR_RSSI		GENMASK(23, 16)
+#define HAL_RX_USR_INFO0_PKT_TYPE		GENMASK(27, 24)
+#define HAL_RX_USR_INFO0_STBC			BIT(28)
+#define HAL_RX_USR_INFO0_RECEPTION_TYPE		GENMASK(31, 29)
+
+#define HAL_RX_USR_INFO1_MCS			GENMASK(3, 0)
+#define HAL_RX_USR_INFO1_SGI			GENMASK(5, 4)
+#define HAL_RX_USR_INFO1_HE_RANGING_NDP		BIT(6)
+#define HAL_RX_USR_INFO1_MIMO_SS_BITMAP		GENMASK(15, 8)
+#define HAL_RX_USR_INFO1_RX_BW			GENMASK(18, 16)
+#define HAL_RX_USR_INFO1_DL_OFMDA_USR_IDX	GENMASK(31, 24)
+
+#define HAL_RX_USR_INFO2_DL_OFDMA_CONTENT_CHAN	BIT(0)
+#define HAL_RX_USR_INFO2_NSS			GENMASK(10, 8)
+#define HAL_RX_USR_INFO2_STREAM_OFFSET		GENMASK(13, 11)
+#define HAL_RX_USR_INFO2_STA_DCM		BIT(14)
+#define HAL_RX_USR_INFO2_LDPC			BIT(15)
+#define HAL_RX_USR_INFO2_RU_TYPE_80_0		GENMASK(19, 16)
+#define HAL_RX_USR_INFO2_RU_TYPE_80_1		GENMASK(23, 20)
+#define HAL_RX_USR_INFO2_RU_TYPE_80_2		GENMASK(27, 24)
+#define HAL_RX_USR_INFO2_RU_TYPE_80_3		GENMASK(31, 28)
+
+#define HAL_RX_USR_INFO3_RU_START_IDX_80_0	GENMASK(5, 0)
+#define HAL_RX_USR_INFO3_RU_START_IDX_80_1	GENMASK(13, 8)
+#define HAL_RX_USR_INFO3_RU_START_IDX_80_2	GENMASK(21, 16)
+#define HAL_RX_USR_INFO3_RU_START_IDX_80_3	GENMASK(29, 24)
+
+struct hal_receive_user_info {
+	__le32 info0;
+	__le32 info1;
+	__le32 info2;
+	__le32 info3;
+	__le32 user_fd_rssi_seg0;
+	__le32 user_fd_rssi_seg1;
+	__le32 user_fd_rssi_seg2;
+	__le32 user_fd_rssi_seg3;
+} __packed;
+
+enum hal_mon_reception_type {
+	HAL_RECEPTION_TYPE_SU,
+	HAL_RECEPTION_TYPE_DL_MU_MIMO,
+	HAL_RECEPTION_TYPE_DL_MU_OFMA,
+	HAL_RECEPTION_TYPE_DL_MU_OFDMA_MIMO,
+	HAL_RECEPTION_TYPE_UL_MU_MIMO,
+	HAL_RECEPTION_TYPE_UL_MU_OFDMA,
+	HAL_RECEPTION_TYPE_UL_MU_OFDMA_MIMO,
+};
+
+/* Different allowed RU in 11BE */
+#define HAL_EHT_RU_26		0ULL
+#define HAL_EHT_RU_52		1ULL
+#define HAL_EHT_RU_78		2ULL
+#define HAL_EHT_RU_106		3ULL
+#define HAL_EHT_RU_132		4ULL
+#define HAL_EHT_RU_242		5ULL
+#define HAL_EHT_RU_484		6ULL
+#define HAL_EHT_RU_726		7ULL
+#define HAL_EHT_RU_996		8ULL
+#define HAL_EHT_RU_996x2	9ULL
+#define HAL_EHT_RU_996x3	10ULL
+#define HAL_EHT_RU_996x4	11ULL
+#define HAL_EHT_RU_NONE		15ULL
+#define HAL_EHT_RU_INVALID	31ULL
+/* MRUs spanning above 80Mhz
+ * HAL_EHT_RU_996_484 = HAL_EHT_RU_484 + HAL_EHT_RU_996 + 4 (reserved)
+ */
+#define HAL_EHT_RU_996_484	18ULL
+#define HAL_EHT_RU_996x2_484	28ULL
+#define HAL_EHT_RU_996x3_484	40ULL
+#define HAL_EHT_RU_996_484_242	23ULL
+
+#define NUM_RU_BITS_PER80	16
+#define NUM_RU_BITS_PER20	4
+
+/* Different per_80Mhz band in 320Mhz bandwidth */
+#define HAL_80_0	0
+#define HAL_80_1	1
+#define HAL_80_2	2
+#define HAL_80_3	3
+
+#define HAL_RU_80MHZ(num_band)		((num_band) * NUM_RU_BITS_PER80)
+#define HAL_RU_20MHZ(idx_per_80)	((idx_per_80) * NUM_RU_BITS_PER20)
+
+#define HAL_RU_SHIFT(num_band, idx_per_80)	\
+		(HAL_RU_80MHZ(num_band) + HAL_RU_20MHZ(idx_per_80))
+
+#define HAL_RU(ru, num_band, idx_per_80)	\
+		((u64)(ru) << HAL_RU_SHIFT(num_band, idx_per_80))
+
+/* MRU-996+484 */
+#define HAL_EHT_RU_996_484_0	(HAL_RU(HAL_EHT_RU_484, HAL_80_0, 1) |	\
+				 HAL_RU(HAL_EHT_RU_996, HAL_80_1, 0))
+#define HAL_EHT_RU_996_484_1	(HAL_RU(HAL_EHT_RU_484, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996, HAL_80_1, 0))
+#define HAL_EHT_RU_996_484_2	(HAL_RU(HAL_EHT_RU_996, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_1, 1))
+#define HAL_EHT_RU_996_484_3	(HAL_RU(HAL_EHT_RU_996, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_1, 0))
+#define HAL_EHT_RU_996_484_4	(HAL_RU(HAL_EHT_RU_484, HAL_80_2, 1) |	\
+				 HAL_RU(HAL_EHT_RU_996, HAL_80_3, 0))
+#define HAL_EHT_RU_996_484_5	(HAL_RU(HAL_EHT_RU_484, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996, HAL_80_3, 0))
+#define HAL_EHT_RU_996_484_6	(HAL_RU(HAL_EHT_RU_996, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_3, 1))
+#define HAL_EHT_RU_996_484_7	(HAL_RU(HAL_EHT_RU_996, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_3, 0))
+
+/* MRU-996x2+484 */
+#define HAL_EHT_RU_996x2_484_0	(HAL_RU(HAL_EHT_RU_484, HAL_80_0, 1) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_2, 0))
+#define HAL_EHT_RU_996x2_484_1	(HAL_RU(HAL_EHT_RU_484, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_2, 0))
+#define HAL_EHT_RU_996x2_484_2	(HAL_RU(HAL_EHT_RU_996x2, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_1, 1) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_2, 0))
+#define HAL_EHT_RU_996x2_484_3	(HAL_RU(HAL_EHT_RU_996x2, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_2, 0))
+#define HAL_EHT_RU_996x2_484_4	(HAL_RU(HAL_EHT_RU_996x2, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_2, 1))
+#define HAL_EHT_RU_996x2_484_5	(HAL_RU(HAL_EHT_RU_996x2, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_2, 0))
+#define HAL_EHT_RU_996x2_484_6	(HAL_RU(HAL_EHT_RU_484, HAL_80_1, 1) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_3, 0))
+#define HAL_EHT_RU_996x2_484_7	(HAL_RU(HAL_EHT_RU_484, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_3, 0))
+#define HAL_EHT_RU_996x2_484_8	(HAL_RU(HAL_EHT_RU_996x2, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_2, 1) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_3, 0))
+#define HAL_EHT_RU_996x2_484_9	(HAL_RU(HAL_EHT_RU_996x2, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_3, 0))
+#define HAL_EHT_RU_996x2_484_10	(HAL_RU(HAL_EHT_RU_996x2, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_3, 1))
+#define HAL_EHT_RU_996x2_484_11	(HAL_RU(HAL_EHT_RU_996x2, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x2, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_3, 0))
+
+/* MRU-996x3+484 */
+#define HAL_EHT_RU_996x3_484_0	(HAL_RU(HAL_EHT_RU_484, HAL_80_0, 1) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_3, 0))
+#define HAL_EHT_RU_996x3_484_1	(HAL_RU(HAL_EHT_RU_484, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_3, 0))
+#define HAL_EHT_RU_996x3_484_2	(HAL_RU(HAL_EHT_RU_996x3, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_1, 1) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_3, 0))
+#define HAL_EHT_RU_996x3_484_3	(HAL_RU(HAL_EHT_RU_996x3, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_3, 0))
+#define HAL_EHT_RU_996x3_484_4	(HAL_RU(HAL_EHT_RU_996x3, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_2, 1) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_3, 0))
+#define HAL_EHT_RU_996x3_484_5	(HAL_RU(HAL_EHT_RU_996x3, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_3, 0))
+#define HAL_EHT_RU_996x3_484_6	(HAL_RU(HAL_EHT_RU_996x3, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_3, 1))
+#define HAL_EHT_RU_996x3_484_7	(HAL_RU(HAL_EHT_RU_996x3, HAL_80_0, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_1, 0) |	\
+				 HAL_RU(HAL_EHT_RU_996x3, HAL_80_2, 0) |	\
+				 HAL_RU(HAL_EHT_RU_484, HAL_80_3, 0))
+
+#define HAL_RU_PER80(ru_per80, num_80mhz, ru_idx_per80mhz) \
+			(HAL_RU(ru_per80, num_80mhz, ru_idx_per80mhz))
+
+#define RU_INVALID		0
+#define RU_26			1
+#define RU_52			2
+#define RU_106			4
+#define RU_242			9
+#define RU_484			18
+#define RU_996			37
+#define RU_2X996		74
+#define RU_3X996		111
+#define RU_4X996		148
+#define RU_52_26		(RU_52 + RU_26)
+#define RU_106_26		(RU_106 + RU_26)
+#define RU_484_242		(RU_484 + RU_242)
+#define RU_996_484		(RU_996 + RU_484)
+#define RU_996_484_242		(RU_996 + RU_484_242)
+#define RU_2X996_484		(RU_2X996 + RU_484)
+#define RU_3X996_484		(RU_3X996 + RU_484)
+
+enum ath12k_eht_ru_size {
+	ATH12K_EHT_RU_26,
+	ATH12K_EHT_RU_52,
+	ATH12K_EHT_RU_106,
+	ATH12K_EHT_RU_242,
+	ATH12K_EHT_RU_484,
+	ATH12K_EHT_RU_996,
+	ATH12K_EHT_RU_996x2,
+	ATH12K_EHT_RU_996x4,
+	ATH12K_EHT_RU_52_26,
+	ATH12K_EHT_RU_106_26,
+	ATH12K_EHT_RU_484_242,
+	ATH12K_EHT_RU_996_484,
+	ATH12K_EHT_RU_996_484_242,
+	ATH12K_EHT_RU_996x2_484,
+	ATH12K_EHT_RU_996x3,
+	ATH12K_EHT_RU_996x3_484,
+
+	/* Keep last */
+	ATH12K_EHT_RU_INVALID,
+};
+
+#define HAL_RX_RU_ALLOC_TYPE_MAX	ATH12K_EHT_RU_INVALID
+
+static inline
+enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
+{
+	enum nl80211_he_ru_alloc ret;
+
+	switch (ru_tones) {
+	case RU_52:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
+		break;
+	case RU_106:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		break;
+	case RU_242:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+		break;
+	case RU_484:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+		break;
+	case RU_996:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+		break;
+	case RU_2X996:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+		break;
+	case RU_26:
+		fallthrough;
+	default:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		break;
+	}
+	return ret;
+}
+
 void ath12k_hal_reo_status_queue_stats(struct ath12k_base *ab,
 				       struct hal_tlv_64_hdr *tlv,
 				       struct hal_reo_status *status);
diff --git a/drivers/net/wireless/ath/ath12k/rx_desc.h b/drivers/net/wireless/ath/ath12k/rx_desc.h
index 7367935ee68b..6c600473b402 100644
--- a/drivers/net/wireless/ath/ath12k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath12k/rx_desc.h
@@ -1541,13 +1541,4 @@ struct hal_rx_desc {
 #define MAX_MU_GROUP_SHOW 16
 #define MAX_MU_GROUP_LENGTH (6 * MAX_MU_GROUP_SHOW)
 
-#define HAL_RX_RU_ALLOC_TYPE_MAX 6
-#define RU_26  1
-#define RU_52  2
-#define RU_106 4
-#define RU_242 9
-#define RU_484 18
-#define RU_996 37
-#define RU_2X996 74
-
 #endif /* ATH12K_RX_DESC_H */
-- 
2.34.1


