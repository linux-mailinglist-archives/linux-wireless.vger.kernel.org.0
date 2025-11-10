Return-Path: <linux-wireless+bounces-28738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66275C45F9F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411BC1890691
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4EC307AE1;
	Mon, 10 Nov 2025 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jQxS+u2B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990FB301474
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771051; cv=none; b=jBZk8BJ8SmOP5HGNy8eWVhQTTuqU6AptE/luS5aGIfly8d47A9ecuqbWwhz3Ux1kPV+4Q5z/hNnjtCobfqaGJqgeBcvLaKmuqwQsCave8pgI8bmYdQDjZ/59Gb8ifNuhPxjmKmszg5s7/yBNFoYvffHCh+Tb/Tp2qwKEL7sFrn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771051; c=relaxed/simple;
	bh=00tzzVm01fY5EdEy9R8sZrLDmXvB6mQ3xMpB+fP/xUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EL4ijFexXoPb3mgCowVCmdiE9BLEk99dtS6mtaxzDjm2TqggDXS3dVn7Qk2ZO96LjHMCZ1p6yzZyDXhMINH3u+oAgashzmPans1HeGuZE+RrDUqC9SSrYN/6RTchPNiikIkzXwMw6qg8Xx6kNJ+WzoEFzg26MILQCpO1uHuASkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jQxS+u2B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA6SYln2407943;
	Mon, 10 Nov 2025 10:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PhGzmgXjbZW
	7UzhPZGQ51CCk6iWEzx3fDR06k4tXaws=; b=jQxS+u2BDn8nUxurRpr4VO/JFgL
	js9+RxDZ5M+WolbgSBm2OMGyR7UwPV6mGV6kesgp4GS8vAWGj0vytVakeRUsyvzw
	WVu1IUEpHmMKyCP8Aba1b/IqUyHm4fDZyoQ5BScj5YiXsP7v0LK1HaAW4NKfF9oy
	M93+XnO/z4q7A0r6xMz+jccqGIAIM3sTewqfV5MV8yNhlkmVTShG3FmUMSNVjSF6
	NpsILmpLmZ1U21d56rkkrw1v7UAs7jWqNP93nsWxU3ElBmHXwPU578MI7eSxPomt
	UY8YXZgcadzzPa82EngTSz1Cx5PJ+NiYM8z0bTVPKSuw7KMcZXlQeZaO2lQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd8sp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:22 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAbIot008146;
	Mon, 10 Nov 2025 10:37:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxkq1gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:18 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AAAbIoJ008101;
	Mon, 10 Nov 2025 10:37:18 GMT
Received: from hu-devc-blr-u22-c.qualcomm.com (hu-aloksing-blr.qualcomm.com [10.190.111.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AAAbIeJ008093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:18 +0000
Received: by hu-devc-blr-u22-c.qualcomm.com (Postfix, from userid 2272527)
	id 977F7B72; Mon, 10 Nov 2025 16:07:16 +0530 (+0530)
From: Alok Singh <quic_aloksing@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Alok Singh <quic_aloksing@quicinc.com>
Subject: [PATCH ath12k-ng 08/12] wifi: ath12k: Move EHT SIG processing to Wi-Fi 7 module
Date: Mon, 10 Nov 2025 16:07:09 +0530
Message-Id: <20251110103713.3484779-9-quic_aloksing@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
References: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 39KLUIaZ2OTWektPXEhhOZ6wthDZ7zv5
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=6911c062 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=eeubCUCWC7m21ZpwqboA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 39KLUIaZ2OTWektPXEhhOZ6wthDZ7zv5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MiBTYWx0ZWRfX1x9rt5HXNgzu
 Wuyhhf4kfj9il22SDgYhhbTNVjWaO7g8IRBJGhmaeQTZ/2Q/QaRM86GQA6ovMtYx3Vnx5Zcu9BK
 jFb13mNyAfR3m0EnAXf7aZcYiOIEB+5x9+WJ0ajq/RBaWqUlX3Nn3Qnkl1zaxoce5bgC+JM1mav
 MLYKCyy/n6I3ImZiZegHRwbGKlJI22JTGqgdjZ7xqkdZTqNAH1SWGD96yrQDux5XNHdp/PV+0Iz
 Vzbpn8kBbA7Q3cDQavppDF9EjEMwsse9svLNlLHykGVU8BTKdRxAPJGijbtVpog0NRgVCL+zTA0
 RoKDCGHlYPj/ZtpsD4kK5zWvz5/zLwKbY9I0TiGYpafv4tQIvmuqgSOIb2Mef8AAfMqYn6XndLR
 WGGcEGB8KNVsCQF2MKCgDQfjuxUIzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100092

Split Wi-Fi 7 specific EHT SIG parsing out of ath12k common
code into the Wi-Fi 7 module to improve modularity.

Move the following EHT SIG processing functions to wifi7/dp_mon.c and
add the ath12k_wifi7 prefix to each relocated function.
- ath12k_dp_mon_hal_aggr_tlv()
- ath12k_dp_mon_hal_rx_is_frame_type_ndp()
- ath12k_dp_mon_hal_rx_is_non_ofdma()
- ath12k_dp_mon_hal_rx_is_ofdma()
- ath12k_dp_mon_hal_rx_parse_eht_sig_ndp()
- ath12k_dp_mon_hal_rx_parse_usig_overflow()
- ath12k_dp_mon_hal_rx_parse_non_ofdma_users()
- ath12k_dp_mon_hal_rx_parse_eht_mumimo_user()
- ath12k_dp_mon_hal_rx_parse_eht_non_mumimo_user()
- ath12k_dp_mon_hal_rx_is_mu_mimo_user()
- ath12k_dp_mon_hal_rx_parse_eht_sig_non_ofdma()
- ath12k_dp_mon_hal_rx_parse_ru_allocation()
- ath12k_dp_mon_hal_rx_parse_eht_sig_ofdma()
- ath12k_dp_mon_parse_eht_sig_hdr()

Export helper functions needed by the ath12k_wifi7 module.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Alok Singh <quic_aloksing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 389 ------------------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |  12 +-
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 386 ++++++++++++++++-
 3 files changed, 390 insertions(+), 397 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index df9203d90f00..1ad984cd561e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -11,12 +11,6 @@
 #include "dp_tx.h"
 #include "peer.h"
 
-#define ATH12K_LE32_DEC_ENC(value, dec_bits, enc_bits)	\
-		u32_encode_bits(le32_get_bits(value, dec_bits), enc_bits)
-
-#define ATH12K_LE64_DEC_ENC(value, dec_bits, enc_bits) \
-		u32_encode_bits(le64_get_bits(value, dec_bits), enc_bits)
-
 void
 ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
 				   struct hal_rx_user_status *rx_user_status)
@@ -346,389 +340,6 @@ ath12k_dp_mon_hal_rx_parse_u_sig_hdr(const struct hal_mon_usig_hdr *usig,
 }
 EXPORT_SYMBOL(ath12k_dp_mon_hal_rx_parse_u_sig_hdr);
 
-void
-ath12k_dp_mon_hal_aggr_tlv(struct hal_rx_mon_ppdu_info *ppdu_info,
-			   u16 tlv_len, const void *tlv_data)
-{
-	if (tlv_len <= HAL_RX_MON_MAX_AGGR_SIZE - ppdu_info->tlv_aggr.cur_len) {
-		memcpy(ppdu_info->tlv_aggr.buf + ppdu_info->tlv_aggr.cur_len,
-		       tlv_data, tlv_len);
-		ppdu_info->tlv_aggr.cur_len += tlv_len;
-	}
-}
-EXPORT_SYMBOL(ath12k_dp_mon_hal_aggr_tlv);
-
-static inline bool
-ath12k_dp_mon_hal_rx_is_frame_type_ndp(const struct hal_rx_u_sig_info *usig_info)
-{
-	if (usig_info->ppdu_type_comp_mode == 1 &&
-	    usig_info->eht_sig_mcs == 0 &&
-	    usig_info->num_eht_sig_sym == 0)
-		return true;
-
-	return false;
-}
-
-static inline bool
-ath12k_dp_mon_hal_rx_is_non_ofdma(const struct hal_rx_u_sig_info *usig_info)
-{
-	u32 ppdu_type_comp_mode = usig_info->ppdu_type_comp_mode;
-	u32 ul_dl = usig_info->ul_dl;
-
-	if ((ppdu_type_comp_mode == HAL_RX_RECEPTION_TYPE_MU_MIMO && ul_dl == 0) ||
-	    (ppdu_type_comp_mode == HAL_RX_RECEPTION_TYPE_MU_OFDMA && ul_dl == 0) ||
-	    (ppdu_type_comp_mode == HAL_RX_RECEPTION_TYPE_MU_MIMO  && ul_dl == 1))
-		return true;
-
-	return false;
-}
-
-static inline bool
-ath12k_dp_mon_hal_rx_is_ofdma(const struct hal_rx_u_sig_info *usig_info)
-{
-	if (usig_info->ppdu_type_comp_mode == 0 && usig_info->ul_dl == 0)
-		return true;
-
-	return false;
-}
-
-static void
-ath12k_dp_mon_hal_rx_parse_eht_sig_ndp(const struct hal_eht_sig_ndp_cmn_eb *eht_sig_ndp,
-				       struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
-	u32 known, data;
-
-	known = __le32_to_cpu(eht->known);
-	known |= IEEE80211_RADIOTAP_EHT_KNOWN_SPATIAL_REUSE |
-		 IEEE80211_RADIOTAP_EHT_KNOWN_EHT_LTF |
-		 IEEE80211_RADIOTAP_EHT_KNOWN_NSS_S |
-		 IEEE80211_RADIOTAP_EHT_KNOWN_BEAMFORMED_S |
-		 IEEE80211_RADIOTAP_EHT_KNOWN_DISREGARD_S |
-		 IEEE80211_RADIOTAP_EHT_KNOWN_CRC1 |
-		 IEEE80211_RADIOTAP_EHT_KNOWN_TAIL1;
-	eht->known = cpu_to_le32(known);
-
-	data = __le32_to_cpu(eht->data[0]);
-	data |= ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
-				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_SPATIAL_REUSE,
-				    IEEE80211_RADIOTAP_EHT_DATA0_SPATIAL_REUSE);
-	/* GI and LTF size are separately indicated in radiotap header
-	 * and hence will be parsed from other TLV
-	 */
-	data |=	ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
-				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_NUM_LTF_SYM,
-				    IEEE80211_RADIOTAP_EHT_DATA0_EHT_LTF);
-
-	data |=	ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
-				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_CRC,
-				    IEEE80211_RADIOTAP_EHT_DATA0_CRC1_O);
-
-	data |= ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
-				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_DISREGARD,
-				    IEEE80211_RADIOTAP_EHT_DATA0_DISREGARD_S);
-	eht->data[0] = cpu_to_le32(data);
-
-	data = __le32_to_cpu(eht->data[7]);
-	data |=	ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
-				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_NSS,
-				    IEEE80211_RADIOTAP_EHT_DATA7_NSS_S);
-
-	data |=	ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
-				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_BEAMFORMED,
-				    IEEE80211_RADIOTAP_EHT_DATA7_BEAMFORMED_S);
-	eht->data[7] = cpu_to_le32(data);
-}
-
-static void
-ath12k_dp_mon_hal_rx_parse_usig_overflow(const struct hal_eht_sig_usig_overflow *ovflow,
-					 struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
-	u32 known, data;
-
-	known = __le32_to_cpu(eht->known);
-	known |= IEEE80211_RADIOTAP_EHT_KNOWN_SPATIAL_REUSE |
-		 IEEE80211_RADIOTAP_EHT_KNOWN_EHT_LTF |
-		 IEEE80211_RADIOTAP_EHT_KNOWN_LDPC_EXTRA_SYM_OM |
-		 IEEE80211_RADIOTAP_EHT_KNOWN_PRE_PADD_FACOR_OM |
-		 IEEE80211_RADIOTAP_EHT_KNOWN_PE_DISAMBIGUITY_OM |
-		 IEEE80211_RADIOTAP_EHT_KNOWN_DISREGARD_O;
-	eht->known = cpu_to_le32(known);
-
-	data = __le32_to_cpu(eht->data[0]);
-	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
-				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_SPATIAL_REUSE,
-				    IEEE80211_RADIOTAP_EHT_DATA0_SPATIAL_REUSE);
-
-	/* GI and LTF size are separately indicated in radiotap header
-	 * and hence will be parsed from other TLV
-	 */
-	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
-				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_NUM_LTF_SYM,
-				    IEEE80211_RADIOTAP_EHT_DATA0_EHT_LTF);
-
-	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
-				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_LDPC_EXTA_SYM,
-				    IEEE80211_RADIOTAP_EHT_DATA0_LDPC_EXTRA_SYM_OM);
-
-	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
-				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_PRE_FEC_PAD_FACTOR,
-				    IEEE80211_RADIOTAP_EHT_DATA0_PRE_PADD_FACOR_OM);
-
-	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
-				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_DISAMBIGUITY,
-				    IEEE80211_RADIOTAP_EHT_DATA0_PE_DISAMBIGUITY_OM);
-
-	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
-				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_DISREGARD,
-				    IEEE80211_RADIOTAP_EHT_DATA0_DISREGARD_O);
-	eht->data[0] = cpu_to_le32(data);
-}
-
-static void
-ath12k_dp_mon_hal_rx_parse_non_ofdma_users(const struct hal_eht_sig_non_ofdma_cmn_eb *eb,
-					   struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
-	u32 known, data;
-
-	known = __le32_to_cpu(eht->known);
-	known |= IEEE80211_RADIOTAP_EHT_KNOWN_NR_NON_OFDMA_USERS_M;
-	eht->known = cpu_to_le32(known);
-
-	data = __le32_to_cpu(eht->data[7]);
-	data |=	ATH12K_LE32_DEC_ENC(eb->info0,
-				    HAL_RX_EHT_SIG_NON_OFDMA_INFO0_NUM_USERS,
-				    IEEE80211_RADIOTAP_EHT_DATA7_NUM_OF_NON_OFDMA_USERS);
-	eht->data[7] = cpu_to_le32(data);
-}
-
-static void
-ath12k_dp_mon_hal_rx_parse_eht_mumimo_user(const struct hal_eht_sig_mu_mimo *user,
-					   struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	struct hal_rx_eht_info *eht_info = &ppdu_info->eht_info;
-	u32 user_idx;
-
-	if (eht_info->num_user_info >= ARRAY_SIZE(eht_info->user_info))
-		return;
-
-	user_idx = eht_info->num_user_info++;
-
-	eht_info->user_info[user_idx] |=
-		IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID_KNOWN |
-		IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
-		IEEE80211_RADIOTAP_EHT_USER_INFO_CODING_KNOWN |
-		IEEE80211_RADIOTAP_EHT_USER_INFO_SPATIAL_CONFIG_KNOWN_M |
-		ATH12K_LE32_DEC_ENC(user->info0,
-				    HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_STA_ID,
-				    IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID) |
-		ATH12K_LE32_DEC_ENC(user->info0,
-				    HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_CODING,
-				    IEEE80211_RADIOTAP_EHT_USER_INFO_CODING) |
-		ATH12K_LE32_DEC_ENC(user->info0,
-				    HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_MCS,
-				    IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
-		ATH12K_LE32_DEC_ENC(user->info0,
-				    HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_SPATIAL_CODING,
-				    IEEE80211_RADIOTAP_EHT_USER_INFO_SPATIAL_CONFIG_M);
-
-	ppdu_info->mcs = le32_get_bits(user->info0,
-				       HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_MCS);
-}
-
-static void
-ath12k_dp_mon_hal_rx_parse_eht_non_mumimo_user(const struct hal_eht_sig_non_mu_mimo *user,
-					       struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	struct hal_rx_eht_info *eht_info = &ppdu_info->eht_info;
-	u32 user_idx;
-
-	if (eht_info->num_user_info >= ARRAY_SIZE(eht_info->user_info))
-		return;
-
-	user_idx = eht_info->num_user_info++;
-
-	eht_info->user_info[user_idx] |=
-		IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID_KNOWN |
-		IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
-		IEEE80211_RADIOTAP_EHT_USER_INFO_CODING_KNOWN |
-		IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_KNOWN_O |
-		IEEE80211_RADIOTAP_EHT_USER_INFO_BEAMFORMING_KNOWN_O |
-		ATH12K_LE32_DEC_ENC(user->info0,
-				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_STA_ID,
-				    IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID) |
-		ATH12K_LE32_DEC_ENC(user->info0,
-				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_CODING,
-				    IEEE80211_RADIOTAP_EHT_USER_INFO_CODING) |
-		ATH12K_LE32_DEC_ENC(user->info0,
-				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_MCS,
-				    IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
-		ATH12K_LE32_DEC_ENC(user->info0,
-				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_NSS,
-				    IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O) |
-		ATH12K_LE32_DEC_ENC(user->info0,
-				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_BEAMFORMED,
-				    IEEE80211_RADIOTAP_EHT_USER_INFO_BEAMFORMING_O);
-
-	ppdu_info->mcs = le32_get_bits(user->info0,
-				       HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_MCS);
-
-	ppdu_info->nss = le32_get_bits(user->info0,
-				       HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_NSS) + 1;
-}
-
-static inline bool
-ath12k_dp_mon_hal_rx_is_mu_mimo_user(const struct hal_rx_u_sig_info *usig_info)
-{
-	if (usig_info->ppdu_type_comp_mode == HAL_RX_RECEPTION_TYPE_SU &&
-	    usig_info->ul_dl == 1)
-		return true;
-
-	return false;
-}
-
-static void
-ath12k_dp_mon_hal_rx_parse_eht_sig_non_ofdma(const void *tlv,
-					     struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	const struct hal_eht_sig_non_ofdma_cmn_eb *eb = tlv;
-
-	ath12k_dp_mon_hal_rx_parse_usig_overflow(tlv, ppdu_info);
-	ath12k_dp_mon_hal_rx_parse_non_ofdma_users(eb, ppdu_info);
-
-	if (ath12k_dp_mon_hal_rx_is_mu_mimo_user(&ppdu_info->u_sig_info))
-		ath12k_dp_mon_hal_rx_parse_eht_mumimo_user(&eb->user_field.mu_mimo,
-							   ppdu_info);
-	else
-		ath12k_dp_mon_hal_rx_parse_eht_non_mumimo_user(&eb->user_field.n_mu_mimo,
-							       ppdu_info);
-}
-
-static void
-ath12k_dp_mon_hal_rx_parse_ru_allocation(const struct hal_eht_sig_ofdma_cmn_eb *eb,
-					 struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	const struct hal_eht_sig_ofdma_cmn_eb1 *ofdma_cmn_eb1 = &eb->eb1;
-	const struct hal_eht_sig_ofdma_cmn_eb2 *ofdma_cmn_eb2 = &eb->eb2;
-	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
-	enum ieee80211_radiotap_eht_data ru_123, ru_124, ru_125, ru_126;
-	enum ieee80211_radiotap_eht_data ru_121, ru_122, ru_112, ru_111;
-	u32 data;
-
-	ru_123 = IEEE80211_RADIOTAP_EHT_DATA4_RU_ALLOC_CC_1_2_3;
-	ru_124 = IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_4;
-	ru_125 = IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_5;
-	ru_126 = IEEE80211_RADIOTAP_EHT_DATA6_RU_ALLOC_CC_1_2_6;
-	ru_121 = IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_1;
-	ru_122 = IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_2;
-	ru_112 = IEEE80211_RADIOTAP_EHT_DATA2_RU_ALLOC_CC_1_1_2;
-	ru_111 = IEEE80211_RADIOTAP_EHT_DATA1_RU_ALLOC_CC_1_1_1;
-
-	switch (ppdu_info->u_sig_info.bw) {
-	case HAL_EHT_BW_320_2:
-	case HAL_EHT_BW_320_1:
-		data = __le32_to_cpu(eht->data[4]);
-		/* CC1 2::3 */
-		data |=	IEEE80211_RADIOTAP_EHT_DATA4_RU_ALLOC_CC_1_2_3_KNOWN |
-			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
-					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_3,
-					    ru_123);
-		eht->data[4] = cpu_to_le32(data);
-
-		data = __le32_to_cpu(eht->data[5]);
-		/* CC1 2::4 */
-		data |=	IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_4_KNOWN |
-			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
-					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_4,
-					    ru_124);
-
-		/* CC1 2::5 */
-		data |=	IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_5_KNOWN |
-			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
-					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_5,
-					    ru_125);
-		eht->data[5] = cpu_to_le32(data);
-
-		data = __le32_to_cpu(eht->data[6]);
-		/* CC1 2::6 */
-		data |=	IEEE80211_RADIOTAP_EHT_DATA6_RU_ALLOC_CC_1_2_6_KNOWN |
-			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
-					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_6,
-					    ru_126);
-		eht->data[6] = cpu_to_le32(data);
-
-		fallthrough;
-	case HAL_EHT_BW_160:
-		data = __le32_to_cpu(eht->data[3]);
-		/* CC1 2::1 */
-		data |=	IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_1_KNOWN |
-			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
-					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_1,
-					    ru_121);
-		/* CC1 2::2 */
-		data |=	IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_2_KNOWN |
-			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
-					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_2,
-					    ru_122);
-		eht->data[3] = cpu_to_le32(data);
-
-		fallthrough;
-	case HAL_EHT_BW_80:
-		data = __le32_to_cpu(eht->data[2]);
-		/* CC1 1::2 */
-		data |=	IEEE80211_RADIOTAP_EHT_DATA2_RU_ALLOC_CC_1_1_2_KNOWN |
-			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb1->info0,
-					    HAL_RX_EHT_SIG_OFDMA_EB1_RU_ALLOC_1_2,
-					    ru_112);
-		eht->data[2] = cpu_to_le32(data);
-
-		fallthrough;
-	case HAL_EHT_BW_40:
-		fallthrough;
-	case HAL_EHT_BW_20:
-		data = __le32_to_cpu(eht->data[1]);
-		/* CC1 1::1 */
-		data |=	IEEE80211_RADIOTAP_EHT_DATA1_RU_ALLOC_CC_1_1_1_KNOWN |
-			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb1->info0,
-					    HAL_RX_EHT_SIG_OFDMA_EB1_RU_ALLOC_1_1,
-					    ru_111);
-		eht->data[1] = cpu_to_le32(data);
-		break;
-	default:
-		break;
-	}
-}
-
-static void
-ath12k_dp_mon_hal_rx_parse_eht_sig_ofdma(const void *tlv,
-					 struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	const struct hal_eht_sig_ofdma_cmn_eb *ofdma = tlv;
-
-	ath12k_dp_mon_hal_rx_parse_usig_overflow(tlv, ppdu_info);
-	ath12k_dp_mon_hal_rx_parse_ru_allocation(ofdma, ppdu_info);
-
-	ath12k_dp_mon_hal_rx_parse_eht_non_mumimo_user(&ofdma->user_field.n_mu_mimo,
-						       ppdu_info);
-}
-
-void
-ath12k_dp_mon_parse_eht_sig_hdr(struct hal_rx_mon_ppdu_info *ppdu_info,
-				const void *tlv_data)
-{
-	ppdu_info->is_eht = true;
-
-	if (ath12k_dp_mon_hal_rx_is_frame_type_ndp(&ppdu_info->u_sig_info))
-		ath12k_dp_mon_hal_rx_parse_eht_sig_ndp(tlv_data, ppdu_info);
-	else if (ath12k_dp_mon_hal_rx_is_non_ofdma(&ppdu_info->u_sig_info))
-		ath12k_dp_mon_hal_rx_parse_eht_sig_non_ofdma(tlv_data, ppdu_info);
-	else if (ath12k_dp_mon_hal_rx_is_ofdma(&ppdu_info->u_sig_info))
-		ath12k_dp_mon_hal_rx_parse_eht_sig_ofdma(tlv_data, ppdu_info);
-}
-EXPORT_SYMBOL(ath12k_dp_mon_parse_eht_sig_hdr);
-
 static inline enum ath12k_eht_ru_size
 hal_rx_mon_hal_ru_size_to_ath12k_ru_size(u32 hal_ru_size)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index 90811a2f75a7..d2bee88f561f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -14,6 +14,12 @@
 #define ATH12K_MON_RX_DOT11_OFFSET	5
 #define ATH12K_MON_RX_PKT_OFFSET	8
 
+#define ATH12K_LE32_DEC_ENC(value, dec_bits, enc_bits)	\
+		u32_encode_bits(le32_get_bits(value, dec_bits), enc_bits)
+
+#define ATH12K_LE64_DEC_ENC(value, dec_bits, enc_bits) \
+		u32_encode_bits(le64_get_bits(value, dec_bits), enc_bits)
+
 enum dp_monitor_mode {
 	ATH12K_DP_TX_MONITOR_MODE,
 	ATH12K_DP_RX_MONITOR_MODE
@@ -114,9 +120,6 @@ ath12k_dp_mon_parse_status_buf(struct ath12k_pdev_dp *dp_pdev,
 			       struct ath12k_mon_data *pmon,
 			       const struct dp_mon_packet_info *packet_info);
 void
-ath12k_dp_mon_parse_eht_sig_hdr(struct hal_rx_mon_ppdu_info *ppdu_info,
-				const void *tlv_data);
-void
 ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
 				   struct hal_rx_user_status *rx_user_status);
 void
@@ -137,7 +140,4 @@ ath12k_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
 void
 ath12k_dp_mon_hal_rx_parse_u_sig_hdr(const struct hal_mon_usig_hdr *usig,
 				     struct hal_rx_mon_ppdu_info *ppdu_info);
-void
-ath12k_dp_mon_hal_aggr_tlv(struct hal_rx_mon_ppdu_info *ppdu_info,
-			   u16 tlv_len, const void *tlv_data);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
index f6d41ded5715..b924180007c5 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -13,6 +13,17 @@
 #include "../dp_tx.h"
 #include "../peer.h"
 
+static void
+ath12k_wifi7_dp_mon_hal_aggr_tlv(struct hal_rx_mon_ppdu_info *ppdu_info,
+				 u16 tlv_len, const void *tlv_data)
+{
+	if (tlv_len <= HAL_RX_MON_MAX_AGGR_SIZE - ppdu_info->tlv_aggr.cur_len) {
+		memcpy(ppdu_info->tlv_aggr.buf + ppdu_info->tlv_aggr.cur_len,
+		       tlv_data, tlv_len);
+		ppdu_info->tlv_aggr.cur_len += tlv_len;
+	}
+}
+
 static void
 ath12k_wifi7_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info)
 {
@@ -432,6 +443,376 @@ ath12k_wifi7_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *he_sig
 	ppdu_info->dcm = dcm;
 }
 
+static inline bool
+ath12k_wifi7_dp_mon_hal_rx_is_non_ofdma(const struct hal_rx_u_sig_info *usig_info)
+{
+	u32 ppdu_type_comp_mode = usig_info->ppdu_type_comp_mode;
+	u32 ul_dl = usig_info->ul_dl;
+
+	if ((ppdu_type_comp_mode == HAL_RX_RECEPTION_TYPE_MU_MIMO && ul_dl == 0) ||
+	    (ppdu_type_comp_mode == HAL_RX_RECEPTION_TYPE_MU_OFDMA && ul_dl == 0) ||
+	    (ppdu_type_comp_mode == HAL_RX_RECEPTION_TYPE_MU_MIMO  && ul_dl == 1))
+		return true;
+
+	return false;
+}
+
+static inline bool
+ath12k_wifi7_dp_mon_hal_rx_is_ofdma(const struct hal_rx_u_sig_info *usig_info)
+{
+	if (usig_info->ppdu_type_comp_mode == 0 && usig_info->ul_dl == 0)
+		return true;
+
+	return false;
+}
+
+static inline bool
+ath12k_wifi7_dp_mon_hal_rx_is_frame_type_ndp(const struct hal_rx_u_sig_info *usig_info)
+{
+	if (usig_info->ppdu_type_comp_mode == 1 &&
+	    usig_info->eht_sig_mcs == 0 &&
+	    usig_info->num_eht_sig_sym == 0)
+		return true;
+
+	return false;
+}
+
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_eht_sig_ndp(const struct hal_eht_sig_ndp_cmn_eb *eht_sig_ndp,
+					     struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
+	u32 known, data;
+
+	known = __le32_to_cpu(eht->known);
+	known |= IEEE80211_RADIOTAP_EHT_KNOWN_SPATIAL_REUSE |
+		 IEEE80211_RADIOTAP_EHT_KNOWN_EHT_LTF |
+		 IEEE80211_RADIOTAP_EHT_KNOWN_NSS_S |
+		 IEEE80211_RADIOTAP_EHT_KNOWN_BEAMFORMED_S |
+		 IEEE80211_RADIOTAP_EHT_KNOWN_DISREGARD_S |
+		 IEEE80211_RADIOTAP_EHT_KNOWN_CRC1 |
+		 IEEE80211_RADIOTAP_EHT_KNOWN_TAIL1;
+	eht->known = cpu_to_le32(known);
+
+	data = __le32_to_cpu(eht->data[0]);
+	data |= ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
+				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_SPATIAL_REUSE,
+				    IEEE80211_RADIOTAP_EHT_DATA0_SPATIAL_REUSE);
+	/* GI and LTF size are separately indicated in radiotap header
+	 * and hence will be parsed from other TLV
+	 */
+	data |=	ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
+				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_NUM_LTF_SYM,
+				    IEEE80211_RADIOTAP_EHT_DATA0_EHT_LTF);
+
+	data |=	ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
+				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_CRC,
+				    IEEE80211_RADIOTAP_EHT_DATA0_CRC1_O);
+
+	data |= ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
+				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_DISREGARD,
+				    IEEE80211_RADIOTAP_EHT_DATA0_DISREGARD_S);
+	eht->data[0] = cpu_to_le32(data);
+
+	data = __le32_to_cpu(eht->data[7]);
+	data |=	ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
+				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_NSS,
+				    IEEE80211_RADIOTAP_EHT_DATA7_NSS_S);
+
+	data |=	ATH12K_LE32_DEC_ENC(eht_sig_ndp->info0,
+				    HAL_RX_EHT_SIG_NDP_CMN_INFO0_BEAMFORMED,
+				    IEEE80211_RADIOTAP_EHT_DATA7_BEAMFORMED_S);
+	eht->data[7] = cpu_to_le32(data);
+}
+
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_usig_overflow(const struct hal_eht_sig_usig_overflow *ovflow,
+					       struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
+	u32 known, data;
+
+	known = __le32_to_cpu(eht->known);
+	known |= IEEE80211_RADIOTAP_EHT_KNOWN_SPATIAL_REUSE |
+		 IEEE80211_RADIOTAP_EHT_KNOWN_EHT_LTF |
+		 IEEE80211_RADIOTAP_EHT_KNOWN_LDPC_EXTRA_SYM_OM |
+		 IEEE80211_RADIOTAP_EHT_KNOWN_PRE_PADD_FACOR_OM |
+		 IEEE80211_RADIOTAP_EHT_KNOWN_PE_DISAMBIGUITY_OM |
+		 IEEE80211_RADIOTAP_EHT_KNOWN_DISREGARD_O;
+	eht->known = cpu_to_le32(known);
+
+	data = __le32_to_cpu(eht->data[0]);
+	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
+				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_SPATIAL_REUSE,
+				    IEEE80211_RADIOTAP_EHT_DATA0_SPATIAL_REUSE);
+
+	/* GI and LTF size are separately indicated in radiotap header
+	 * and hence will be parsed from other TLV
+	 */
+	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
+				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_NUM_LTF_SYM,
+				    IEEE80211_RADIOTAP_EHT_DATA0_EHT_LTF);
+
+	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
+				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_LDPC_EXTA_SYM,
+				    IEEE80211_RADIOTAP_EHT_DATA0_LDPC_EXTRA_SYM_OM);
+
+	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
+				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_PRE_FEC_PAD_FACTOR,
+				    IEEE80211_RADIOTAP_EHT_DATA0_PRE_PADD_FACOR_OM);
+
+	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
+				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_DISAMBIGUITY,
+				    IEEE80211_RADIOTAP_EHT_DATA0_PE_DISAMBIGUITY_OM);
+
+	data |=	ATH12K_LE32_DEC_ENC(ovflow->info0,
+				    HAL_RX_EHT_SIG_OVERFLOW_INFO0_DISREGARD,
+				    IEEE80211_RADIOTAP_EHT_DATA0_DISREGARD_O);
+	eht->data[0] = cpu_to_le32(data);
+}
+
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_non_ofdma_users(const struct hal_eht_sig_non_ofdma_cmn_eb *eb,
+						 struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
+	u32 known, data;
+
+	known = __le32_to_cpu(eht->known);
+	known |= IEEE80211_RADIOTAP_EHT_KNOWN_NR_NON_OFDMA_USERS_M;
+	eht->known = cpu_to_le32(known);
+
+	data = __le32_to_cpu(eht->data[7]);
+	data |=	ATH12K_LE32_DEC_ENC(eb->info0,
+				    HAL_RX_EHT_SIG_NON_OFDMA_INFO0_NUM_USERS,
+				    IEEE80211_RADIOTAP_EHT_DATA7_NUM_OF_NON_OFDMA_USERS);
+	eht->data[7] = cpu_to_le32(data);
+}
+
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_eht_mumimo_user(const struct hal_eht_sig_mu_mimo *user,
+						 struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	struct hal_rx_eht_info *eht_info = &ppdu_info->eht_info;
+	u32 user_idx;
+
+	if (eht_info->num_user_info >= ARRAY_SIZE(eht_info->user_info))
+		return;
+
+	user_idx = eht_info->num_user_info++;
+
+	eht_info->user_info[user_idx] |=
+		IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID_KNOWN |
+		IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
+		IEEE80211_RADIOTAP_EHT_USER_INFO_CODING_KNOWN |
+		IEEE80211_RADIOTAP_EHT_USER_INFO_SPATIAL_CONFIG_KNOWN_M |
+		ATH12K_LE32_DEC_ENC(user->info0,
+				    HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_STA_ID,
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID) |
+		ATH12K_LE32_DEC_ENC(user->info0,
+				    HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_CODING,
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_CODING) |
+		ATH12K_LE32_DEC_ENC(user->info0,
+				    HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_MCS,
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
+		ATH12K_LE32_DEC_ENC(user->info0,
+				    HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_SPATIAL_CODING,
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_SPATIAL_CONFIG_M);
+
+	ppdu_info->mcs = le32_get_bits(user->info0,
+				       HAL_RX_EHT_SIG_MUMIMO_USER_INFO0_MCS);
+}
+
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_eht_non_mumimo_user(const struct hal_eht_sig_non_mu_mimo *user,
+						     struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	struct hal_rx_eht_info *eht_info = &ppdu_info->eht_info;
+	u32 user_idx;
+
+	if (eht_info->num_user_info >= ARRAY_SIZE(eht_info->user_info))
+		return;
+
+	user_idx = eht_info->num_user_info++;
+
+	eht_info->user_info[user_idx] |=
+		IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID_KNOWN |
+		IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
+		IEEE80211_RADIOTAP_EHT_USER_INFO_CODING_KNOWN |
+		IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_KNOWN_O |
+		IEEE80211_RADIOTAP_EHT_USER_INFO_BEAMFORMING_KNOWN_O |
+		ATH12K_LE32_DEC_ENC(user->info0,
+				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_STA_ID,
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID) |
+		ATH12K_LE32_DEC_ENC(user->info0,
+				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_CODING,
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_CODING) |
+		ATH12K_LE32_DEC_ENC(user->info0,
+				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_MCS,
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
+		ATH12K_LE32_DEC_ENC(user->info0,
+				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_NSS,
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O) |
+		ATH12K_LE32_DEC_ENC(user->info0,
+				    HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_BEAMFORMED,
+				    IEEE80211_RADIOTAP_EHT_USER_INFO_BEAMFORMING_O);
+
+	ppdu_info->mcs = le32_get_bits(user->info0,
+				       HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_MCS);
+
+	ppdu_info->nss = le32_get_bits(user->info0,
+				       HAL_RX_EHT_SIG_NON_MUMIMO_USER_INFO0_NSS) + 1;
+}
+
+static inline bool
+ath12k_wifi7_dp_mon_hal_rx_is_mu_mimo_user(const struct hal_rx_u_sig_info *usig_info)
+{
+	if (usig_info->ppdu_type_comp_mode == HAL_RX_RECEPTION_TYPE_SU &&
+	    usig_info->ul_dl == 1)
+		return true;
+
+	return false;
+}
+
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_eht_sig_non_ofdma(const void *tlv,
+						   struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	const struct hal_eht_sig_non_ofdma_cmn_eb *eb = tlv;
+
+	ath12k_wifi7_dp_mon_hal_rx_parse_usig_overflow(tlv, ppdu_info);
+	ath12k_wifi7_dp_mon_hal_rx_parse_non_ofdma_users(eb, ppdu_info);
+
+	if (ath12k_wifi7_dp_mon_hal_rx_is_mu_mimo_user(&ppdu_info->u_sig_info))
+		ath12k_wifi7_dp_mon_hal_rx_parse_eht_mumimo_user(&eb->user_field.mu_mimo,
+								 ppdu_info);
+	else
+		ath12k_wifi7_dp_mon_hal_rx_parse_eht_non_mumimo_user(&eb->user_field.n_mu_mimo,
+								     ppdu_info);
+}
+
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_ru_allocation(const struct hal_eht_sig_ofdma_cmn_eb *eb,
+					       struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	const struct hal_eht_sig_ofdma_cmn_eb1 *ofdma_cmn_eb1 = &eb->eb1;
+	const struct hal_eht_sig_ofdma_cmn_eb2 *ofdma_cmn_eb2 = &eb->eb2;
+	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
+	enum ieee80211_radiotap_eht_data ru_123, ru_124, ru_125, ru_126;
+	enum ieee80211_radiotap_eht_data ru_121, ru_122, ru_112, ru_111;
+	u32 data;
+
+	ru_123 = IEEE80211_RADIOTAP_EHT_DATA4_RU_ALLOC_CC_1_2_3;
+	ru_124 = IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_4;
+	ru_125 = IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_5;
+	ru_126 = IEEE80211_RADIOTAP_EHT_DATA6_RU_ALLOC_CC_1_2_6;
+	ru_121 = IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_1;
+	ru_122 = IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_2;
+	ru_112 = IEEE80211_RADIOTAP_EHT_DATA2_RU_ALLOC_CC_1_1_2;
+	ru_111 = IEEE80211_RADIOTAP_EHT_DATA1_RU_ALLOC_CC_1_1_1;
+
+	switch (ppdu_info->u_sig_info.bw) {
+	case HAL_EHT_BW_320_2:
+	case HAL_EHT_BW_320_1:
+		data = __le32_to_cpu(eht->data[4]);
+		/* CC1 2::3 */
+		data |=	IEEE80211_RADIOTAP_EHT_DATA4_RU_ALLOC_CC_1_2_3_KNOWN |
+			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
+					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_3,
+					    ru_123);
+		eht->data[4] = cpu_to_le32(data);
+
+		data = __le32_to_cpu(eht->data[5]);
+		/* CC1 2::4 */
+		data |=	IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_4_KNOWN |
+			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
+					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_4,
+					    ru_124);
+
+		/* CC1 2::5 */
+		data |=	IEEE80211_RADIOTAP_EHT_DATA5_RU_ALLOC_CC_1_2_5_KNOWN |
+			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
+					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_5,
+					    ru_125);
+		eht->data[5] = cpu_to_le32(data);
+
+		data = __le32_to_cpu(eht->data[6]);
+		/* CC1 2::6 */
+		data |=	IEEE80211_RADIOTAP_EHT_DATA6_RU_ALLOC_CC_1_2_6_KNOWN |
+			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
+					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_6,
+					    ru_126);
+		eht->data[6] = cpu_to_le32(data);
+
+		fallthrough;
+	case HAL_EHT_BW_160:
+		data = __le32_to_cpu(eht->data[3]);
+		/* CC1 2::1 */
+		data |=	IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_1_KNOWN |
+			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
+					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_1,
+					    ru_121);
+		/* CC1 2::2 */
+		data |=	IEEE80211_RADIOTAP_EHT_DATA3_RU_ALLOC_CC_1_2_2_KNOWN |
+			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb2->info0,
+					    HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_2,
+					    ru_122);
+		eht->data[3] = cpu_to_le32(data);
+
+		fallthrough;
+	case HAL_EHT_BW_80:
+		data = __le32_to_cpu(eht->data[2]);
+		/* CC1 1::2 */
+		data |=	IEEE80211_RADIOTAP_EHT_DATA2_RU_ALLOC_CC_1_1_2_KNOWN |
+			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb1->info0,
+					    HAL_RX_EHT_SIG_OFDMA_EB1_RU_ALLOC_1_2,
+					    ru_112);
+		eht->data[2] = cpu_to_le32(data);
+
+		fallthrough;
+	case HAL_EHT_BW_40:
+		fallthrough;
+	case HAL_EHT_BW_20:
+		data = __le32_to_cpu(eht->data[1]);
+		/* CC1 1::1 */
+		data |=	IEEE80211_RADIOTAP_EHT_DATA1_RU_ALLOC_CC_1_1_1_KNOWN |
+			ATH12K_LE64_DEC_ENC(ofdma_cmn_eb1->info0,
+					    HAL_RX_EHT_SIG_OFDMA_EB1_RU_ALLOC_1_1,
+					    ru_111);
+		eht->data[1] = cpu_to_le32(data);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_eht_sig_ofdma(const void *tlv,
+					       struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	const struct hal_eht_sig_ofdma_cmn_eb *ofdma = tlv;
+
+	ath12k_wifi7_dp_mon_hal_rx_parse_usig_overflow(tlv, ppdu_info);
+	ath12k_wifi7_dp_mon_hal_rx_parse_ru_allocation(ofdma, ppdu_info);
+
+	ath12k_wifi7_dp_mon_hal_rx_parse_eht_non_mumimo_user(&ofdma->user_field.n_mu_mimo,
+							     ppdu_info);
+}
+
+static void
+ath12k_wifi7_dp_mon_parse_eht_sig_hdr(struct hal_rx_mon_ppdu_info *ppdu_info,
+				      const void *tlv_data)
+{
+	ppdu_info->is_eht = true;
+
+	if (ath12k_wifi7_dp_mon_hal_rx_is_frame_type_ndp(&ppdu_info->u_sig_info))
+		ath12k_wifi7_dp_mon_hal_rx_parse_eht_sig_ndp(tlv_data, ppdu_info);
+	else if (ath12k_wifi7_dp_mon_hal_rx_is_non_ofdma(&ppdu_info->u_sig_info))
+		ath12k_wifi7_dp_mon_hal_rx_parse_eht_sig_non_ofdma(tlv_data, ppdu_info);
+	else if (ath12k_wifi7_dp_mon_hal_rx_is_ofdma(&ppdu_info->u_sig_info))
+		ath12k_wifi7_dp_mon_hal_rx_parse_eht_sig_ofdma(tlv_data, ppdu_info);
+}
+
 static enum hal_rx_mon_status
 ath12k_wifi7_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 					struct ath12k_mon_data *pmon,
@@ -447,7 +828,8 @@ ath12k_wifi7_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 	userid = le64_get_bits(tlv->tl, HAL_TLV_64_USR_ID);
 
 	if (ppdu_info->tlv_aggr.in_progress && ppdu_info->tlv_aggr.tlv_tag != tlv_tag) {
-		ath12k_dp_mon_parse_eht_sig_hdr(ppdu_info, ppdu_info->tlv_aggr.buf);
+		ath12k_wifi7_dp_mon_parse_eht_sig_hdr(ppdu_info,
+						      ppdu_info->tlv_aggr.buf);
 
 		ppdu_info->tlv_aggr.in_progress = false;
 		ppdu_info->tlv_aggr.cur_len = 0;
@@ -691,7 +1073,7 @@ ath12k_wifi7_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 
 		ppdu_info->is_eht = true;
 
-		ath12k_dp_mon_hal_aggr_tlv(ppdu_info, tlv_len, tlv_data);
+		ath12k_wifi7_dp_mon_hal_aggr_tlv(ppdu_info, tlv_len, tlv_data);
 		break;
 	case HAL_DUMMY:
 		return HAL_RX_MON_STATUS_BUF_DONE;
-- 
2.34.1


