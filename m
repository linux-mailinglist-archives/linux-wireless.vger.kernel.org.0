Return-Path: <linux-wireless+bounces-28741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9F9C45FA6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0646F1891810
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38FE3081AD;
	Mon, 10 Nov 2025 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q9894PtB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F6306B18
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771052; cv=none; b=Bn8IHcIUo5FCWLYheliARm2syjOzdKduwWCg7bEcAVPjGI0Kjs+4espPzUB2ZpW40MCr7ZycawajorNpOTFnCqC6nN2Ughm7Q0FFrF2zG2X7DGfDUJfmxUhhd3JLpUSTtAMemWzPNPYjFXNGwB60LlAA2VzXiYMPOC0zx91kbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771052; c=relaxed/simple;
	bh=6d3s7le5La7pGM1VLSpFmUZoNv8TuFNx9DJzApKX95o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YR97ERkPzP6R6cvtgSdpiY3GEStn8TnshjGxY9vJyO5J7252O5pNIiIwxuOiVL1Y7HRcsF97H344tbC93p4PlAYRcw8++//o6izeQj9aTWMkFGt352zpLov3/fCmszOAL/fODnY8KVwekWD/S8jFX3EqGzUczs3cXay6DEck37E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q9894PtB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA82aWZ1639796;
	Mon, 10 Nov 2025 10:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=icoiEd86iQN
	RbiJIB7uJ8gwmI5eTO+BbcEOWrAN6eeM=; b=Q9894PtB9T+7IqNfci7w7NPHsio
	zisNXWTxca0athMhfFm74JfxITG0+A+RWL7a4nDujwWPPhPT5/hMg6PfQQDgk3TJ
	2TDIUlhEvNoubNTiSa3r5oFJT4jYBL85gn+SGfqM58FnZef2hDqck+6jMtqlbV2k
	jmO8j6i7CcyrHPlNhNVH8rweeOsvH745TEXNyY4GFsHrBTxZwK2opbPsOmyMrXdU
	ljsTaDSpZq+CMPM3n6u1TQipPGornWV5XcDq4LJEJuKmxVgHjLuiK1ASf7zp7zKI
	Eg1vE+VMqb6xRWnZYGhhkNmN8RUT1PPnHvivjoJ/cmyNzbAdkRK21Ex0r6Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aaue0j870-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAbHTo008069;
	Mon, 10 Nov 2025 10:37:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxkq1f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AAAbHQQ008042;
	Mon, 10 Nov 2025 10:37:17 GMT
Received: from hu-devc-blr-u22-c.qualcomm.com (hu-aloksing-blr.qualcomm.com [10.190.111.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AAAbHiT008036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:17 +0000
Received: by hu-devc-blr-u22-c.qualcomm.com (Postfix, from userid 2272527)
	id 87C35A9E; Mon, 10 Nov 2025 16:07:16 +0530 (+0530)
From: Alok Singh <quic_aloksing@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Alok Singh <quic_aloksing@quicinc.com>
Subject: [PATCH ath12k-ng 04/12] wifi: ath12k: Move RX status TLV parsing to Wi-Fi 7 module
Date: Mon, 10 Nov 2025 16:07:05 +0530
Message-Id: <20251110103713.3484779-5-quic_aloksing@quicinc.com>
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
X-Proofpoint-ORIG-GUID: fvL0DrAtbQe_NBYAI0SeDPObPMKd3d6g
X-Authority-Analysis: v=2.4 cv=BfDVE7t2 c=1 sm=1 tr=0 ts=6911c060 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=IPIzRhE9WCfyV3gR_18A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fvL0DrAtbQe_NBYAI0SeDPObPMKd3d6g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MiBTYWx0ZWRfX31DCOO4QdZ+T
 xWL691Sc1qoP01OBevWqwtbryv8zPCuRhOUvG0UVvs8BFDj7XaxTDObcH45uqQL7gc8t5C7+uEA
 BoUnijMqv4tO/WQZGppYFDak7PrksWFt1ys3mMTy+WBbJZJzL52EZ5Ve9q22hPF9Wo1eB1FEqCi
 EWKVBPYa1U4pWUd1oa7ncbLMq9tICYRXazdSv6mR8aiH3Sf7l4aqyNJ81Relss2ywIYigHpGntx
 iEsac1K4GiKrMFJaGtEnyMiM9N8Zl276sfv6oIITVlC6JWkTrsB2fq6MnBdmZm64cm8wfAEYajj
 przVlcJ1Bktd0ISXhom3DoHZa0z4D4QnC9Vt1Q6dQOHETQJhb8o89D//wh/gyqo5292331iBht8
 lF+1x3M/++k9nLz4x473WMjV38bvWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100092

Split Wi-Fi 7-specific monitor code out of ath12k common code
to improve modularity.

Move following RX status TLV parsing functions to the new file
wifi7/dp_mon.c and rename the helpers with the ath12k_wifi7_ prefix:
- ath12k_dp_mon_rx_parse_status_tlv()
- ath12k_dp_mon_parse_rx_dest_tlv()

Export helper functions required by the Wi-Fi 7 module.

Temporarily include wifi7/hal_rx.h from dp_mon.h to provide
HAL structure definitions; remove this dependency in a later patch.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Alok Singh <quic_aloksing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 374 ++----------------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |  59 ++-
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 319 ++++++++++++++-
 3 files changed, 405 insertions(+), 347 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 16361dd77a6a..dc4827771a64 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -17,7 +17,7 @@
 #define ATH12K_LE64_DEC_ENC(value, dec_bits, enc_bits) \
 		u32_encode_bits(le64_get_bits(value, dec_bits), enc_bits)
 
-static void
+void
 ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
 				   struct hal_rx_user_status *rx_user_status)
 {
@@ -26,6 +26,7 @@ ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu
 	rx_user_status->ul_ofdma_user_v0_word1 =
 		__le32_to_cpu(ppdu_end_user->usr_resp_ref_ext);
 }
+EXPORT_SYMBOL(ath12k_dp_mon_rx_handle_ofdma_info);
 
 static void
 ath12k_dp_mon_rx_populate_byte_count(const struct hal_rx_ppdu_end_user_stats *stats,
@@ -40,7 +41,7 @@ ath12k_dp_mon_rx_populate_byte_count(const struct hal_rx_ppdu_end_user_stats *st
 			      HAL_RX_PPDU_END_USER_STATS_INFO8_MPDU_ERR_BYTE_COUNT);
 }
 
-static void
+void
 ath12k_dp_mon_rx_populate_mu_user_info(const struct hal_rx_ppdu_end_user_stats *rx_tlv,
 				       struct hal_rx_mon_ppdu_info *ppdu_info,
 				       struct hal_rx_user_status *rx_user_status)
@@ -78,9 +79,10 @@ ath12k_dp_mon_rx_populate_mu_user_info(const struct hal_rx_ppdu_end_user_stats *
 
 	ath12k_dp_mon_rx_populate_byte_count(rx_tlv, ppdu_info, rx_user_status);
 }
+EXPORT_SYMBOL(ath12k_dp_mon_rx_populate_mu_user_info);
 
-static void ath12k_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vht_sig,
-					  struct hal_rx_mon_ppdu_info *ppdu_info)
+void ath12k_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vht_sig,
+				   struct hal_rx_mon_ppdu_info *ppdu_info)
 {
 	u32 nsts, info0, info1;
 	u8 gi_setting;
@@ -118,9 +120,10 @@ static void ath12k_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vh
 	ppdu_info->vht_flag_values4 =
 		u32_get_bits(info1, HAL_RX_VHT_SIG_A_INFO_INFO1_SU_MU_CODING);
 }
+EXPORT_SYMBOL(ath12k_dp_mon_parse_vht_sig_a);
 
-static void ath12k_dp_mon_parse_ht_sig(const struct hal_rx_ht_sig_info *ht_sig,
-				       struct hal_rx_mon_ppdu_info *ppdu_info)
+void ath12k_dp_mon_parse_ht_sig(const struct hal_rx_ht_sig_info *ht_sig,
+				struct hal_rx_mon_ppdu_info *ppdu_info)
 {
 	u32 info0 = __le32_to_cpu(ht_sig->info0);
 	u32 info1 = __le32_to_cpu(ht_sig->info1);
@@ -132,9 +135,10 @@ static void ath12k_dp_mon_parse_ht_sig(const struct hal_rx_ht_sig_info *ht_sig,
 	ppdu_info->gi = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_GI);
 	ppdu_info->nss = (ppdu_info->mcs >> 3);
 }
+EXPORT_SYMBOL(ath12k_dp_mon_parse_ht_sig);
 
-static void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
-					struct hal_rx_mon_ppdu_info *ppdu_info)
+void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
+				 struct hal_rx_mon_ppdu_info *ppdu_info)
 {
 	u32 info0 = __le32_to_cpu(lsigb->info0);
 	u8 rate;
@@ -163,9 +167,10 @@ static void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
 	ppdu_info->rate = rate;
 	ppdu_info->cck_flag = 1;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_parse_l_sig_b);
 
-static void ath12k_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
-					struct hal_rx_mon_ppdu_info *ppdu_info)
+void ath12k_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
+				 struct hal_rx_mon_ppdu_info *ppdu_info)
 {
 	u32 info0 = __le32_to_cpu(lsiga->info0);
 	u8 rate;
@@ -202,8 +207,9 @@ static void ath12k_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
 
 	ppdu_info->rate = rate;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_parse_l_sig_a);
 
-static void
+void
 ath12k_dp_mon_parse_he_sig_b2_ofdma(const struct hal_rx_he_sig_b2_ofdma_info *ofdma,
 				    struct hal_rx_mon_ppdu_info *ppdu_info)
 {
@@ -238,8 +244,9 @@ ath12k_dp_mon_parse_he_sig_b2_ofdma(const struct hal_rx_he_sig_b2_ofdma_info *of
 	ppdu_info->beamformed = u32_get_bits(info0,
 					     HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF);
 }
+EXPORT_SYMBOL(ath12k_dp_mon_parse_he_sig_b2_ofdma);
 
-static void
+void
 ath12k_dp_mon_parse_he_sig_b2_mu(const struct hal_rx_he_sig_b2_mu_info *he_sig_b2_mu,
 				 struct hal_rx_mon_ppdu_info *ppdu_info)
 {
@@ -264,8 +271,9 @@ ath12k_dp_mon_parse_he_sig_b2_mu(const struct hal_rx_he_sig_b2_mu_info *he_sig_b
 
 	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_NSTS);
 }
+EXPORT_SYMBOL(ath12k_dp_mon_parse_he_sig_b2_mu);
 
-static void
+void
 ath12k_dp_mon_parse_he_sig_b1_mu(const struct hal_rx_he_sig_b1_mu_info *he_sig_b1_mu,
 				 struct hal_rx_mon_ppdu_info *ppdu_info)
 {
@@ -277,8 +285,9 @@ ath12k_dp_mon_parse_he_sig_b1_mu(const struct hal_rx_he_sig_b1_mu_info *he_sig_b
 	ppdu_info->ru_alloc = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
 	ppdu_info->he_RU[0] = ru_tones;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_parse_he_sig_b1_mu);
 
-static void
+void
 ath12k_dp_mon_parse_he_sig_mu(const struct hal_rx_he_sig_a_mu_dl_info *he_sig_a_mu_dl,
 			      struct hal_rx_mon_ppdu_info *ppdu_info)
 {
@@ -410,9 +419,10 @@ ath12k_dp_mon_parse_he_sig_mu(const struct hal_rx_he_sig_a_mu_dl_info *he_sig_a_
 	ppdu_info->is_stbc = info1 &
 			     HAL_RX_HE_SIG_A_MU_DL_INFO1_STBC;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_parse_he_sig_mu);
 
-static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *he_sig_a,
-					  struct hal_rx_mon_ppdu_info *ppdu_info)
+void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *he_sig_a,
+				   struct hal_rx_mon_ppdu_info *ppdu_info)
 {
 	u32 info0, info1, value;
 	u32 dcm;
@@ -557,6 +567,7 @@ static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *
 	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_A_SU_INFO_INFO0_NSTS);
 	ppdu_info->dcm = dcm;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_parse_he_sig_su);
 
 static void
 ath12k_dp_mon_hal_rx_parse_u_sig_cmn(const struct hal_mon_usig_cmn *cmn,
@@ -731,7 +742,7 @@ ath12k_dp_mon_hal_rx_parse_u_sig_mu(const struct hal_mon_usig_mu *usig_mu,
 	usig->mask = cpu_to_le32(mask);
 }
 
-static void
+void
 ath12k_dp_mon_hal_rx_parse_u_sig_hdr(const struct hal_mon_usig_hdr *usig,
 				     struct hal_rx_mon_ppdu_info *ppdu_info)
 {
@@ -749,8 +760,9 @@ ath12k_dp_mon_hal_rx_parse_u_sig_hdr(const struct hal_mon_usig_hdr *usig,
 	else
 		ath12k_dp_mon_hal_rx_parse_u_sig_mu(&usig->non_cmn.mu, ppdu_info);
 }
+EXPORT_SYMBOL(ath12k_dp_mon_hal_rx_parse_u_sig_hdr);
 
-static void
+void
 ath12k_dp_mon_hal_aggr_tlv(struct hal_rx_mon_ppdu_info *ppdu_info,
 			   u16 tlv_len, const void *tlv_data)
 {
@@ -760,6 +772,7 @@ ath12k_dp_mon_hal_aggr_tlv(struct hal_rx_mon_ppdu_info *ppdu_info,
 		ppdu_info->tlv_aggr.cur_len += tlv_len;
 	}
 }
+EXPORT_SYMBOL(ath12k_dp_mon_hal_aggr_tlv);
 
 static inline bool
 ath12k_dp_mon_hal_rx_is_frame_type_ndp(const struct hal_rx_u_sig_info *usig_info)
@@ -1117,7 +1130,7 @@ ath12k_dp_mon_hal_rx_parse_eht_sig_ofdma(const void *tlv,
 						       ppdu_info);
 }
 
-static void
+void
 ath12k_dp_mon_parse_eht_sig_hdr(struct hal_rx_mon_ppdu_info *ppdu_info,
 				const void *tlv_data)
 {
@@ -1130,6 +1143,7 @@ ath12k_dp_mon_parse_eht_sig_hdr(struct hal_rx_mon_ppdu_info *ppdu_info,
 	else if (ath12k_dp_mon_hal_rx_is_ofdma(&ppdu_info->u_sig_info))
 		ath12k_dp_mon_hal_rx_parse_eht_sig_ofdma(tlv_data, ppdu_info);
 }
+EXPORT_SYMBOL(ath12k_dp_mon_parse_eht_sig_hdr);
 
 static inline enum ath12k_eht_ru_size
 hal_rx_mon_hal_ru_size_to_ath12k_ru_size(u32 hal_ru_size)
@@ -1215,7 +1229,7 @@ hal_rx_ul_ofdma_ru_size_to_width(enum ath12k_eht_ru_size ru_size)
 	}
 }
 
-static void
+void
 ath12k_dp_mon_hal_rx_parse_user_info(const struct hal_receive_user_info *rx_usr_info,
 				     u16 user_id,
 				     struct hal_rx_mon_ppdu_info *ppdu_info)
@@ -1416,6 +1430,7 @@ ath12k_dp_mon_hal_rx_parse_user_info(const struct hal_receive_user_info *rx_usr_
 		mon_rx_user_status->ofdma_info_valid = 1;
 	}
 }
+EXPORT_SYMBOL(ath12k_dp_mon_hal_rx_parse_user_info);
 
 static void ath12k_dp_mon_parse_rx_msdu_end_err(u32 info, u32 *errmap)
 {
@@ -1441,7 +1456,7 @@ static void ath12k_dp_mon_parse_rx_msdu_end_err(u32 info, u32 *errmap)
 		*errmap |= HAL_RX_MPDU_ERR_MPDU_LEN;
 }
 
-static void
+void
 ath12k_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
 				    const struct hal_rx_msdu_end *msdu_end)
 {
@@ -1450,280 +1465,7 @@ ath12k_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
 	pmon->decap_format = le32_get_bits(msdu_end->info1,
 					   RX_MSDU_END_INFO11_DECAP_FORMAT);
 }
-
-enum hal_rx_mon_status
-ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
-				  struct ath12k_mon_data *pmon,
-				  const struct hal_tlv_64_hdr *tlv)
-{
-	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
-	const void *tlv_data = tlv->value;
-	u32 info[7], userid;
-	u16 tlv_tag, tlv_len;
-
-	tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
-	tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
-	userid = le64_get_bits(tlv->tl, HAL_TLV_64_USR_ID);
-
-	if (ppdu_info->tlv_aggr.in_progress && ppdu_info->tlv_aggr.tlv_tag != tlv_tag) {
-		ath12k_dp_mon_parse_eht_sig_hdr(ppdu_info, ppdu_info->tlv_aggr.buf);
-
-		ppdu_info->tlv_aggr.in_progress = false;
-		ppdu_info->tlv_aggr.cur_len = 0;
-	}
-
-	switch (tlv_tag) {
-	case HAL_RX_PPDU_START: {
-		const struct hal_rx_ppdu_start *ppdu_start = tlv_data;
-
-		u64 ppdu_ts = ath12k_le32hilo_to_u64(ppdu_start->ppdu_start_ts_63_32,
-						     ppdu_start->ppdu_start_ts_31_0);
-
-		info[0] = __le32_to_cpu(ppdu_start->info0);
-
-		ppdu_info->ppdu_id = u32_get_bits(info[0],
-						  HAL_RX_PPDU_START_INFO0_PPDU_ID);
-
-		info[1] = __le32_to_cpu(ppdu_start->info1);
-		ppdu_info->chan_num = u32_get_bits(info[1],
-						   HAL_RX_PPDU_START_INFO1_CHAN_NUM);
-		ppdu_info->freq = u32_get_bits(info[1],
-					       HAL_RX_PPDU_START_INFO1_CHAN_FREQ);
-		ppdu_info->ppdu_ts = ppdu_ts;
-
-		if (ppdu_info->ppdu_id != ppdu_info->last_ppdu_id) {
-			ppdu_info->last_ppdu_id = ppdu_info->ppdu_id;
-			ppdu_info->num_users = 0;
-			memset(&ppdu_info->mpdu_fcs_ok_bitmap, 0,
-			       HAL_RX_NUM_WORDS_PER_PPDU_BITMAP *
-			       sizeof(ppdu_info->mpdu_fcs_ok_bitmap[0]));
-		}
-		break;
-	}
-	case HAL_RX_PPDU_END_USER_STATS: {
-		const struct hal_rx_ppdu_end_user_stats *eu_stats = tlv_data;
-		u32 tid_bitmap;
-
-		info[0] = __le32_to_cpu(eu_stats->info0);
-		info[1] = __le32_to_cpu(eu_stats->info1);
-		info[2] = __le32_to_cpu(eu_stats->info2);
-		info[4] = __le32_to_cpu(eu_stats->info4);
-		info[5] = __le32_to_cpu(eu_stats->info5);
-		info[6] = __le32_to_cpu(eu_stats->info6);
-
-		ppdu_info->ast_index =
-			u32_get_bits(info[2], HAL_RX_PPDU_END_USER_STATS_INFO2_AST_INDEX);
-		ppdu_info->fc_valid =
-			u32_get_bits(info[1], HAL_RX_PPDU_END_USER_STATS_INFO1_FC_VALID);
-		tid_bitmap = u32_get_bits(info[6],
-					  HAL_RX_PPDU_END_USER_STATS_INFO6_TID_BITMAP);
-		ppdu_info->tid = ffs(tid_bitmap) - 1;
-		ppdu_info->tcp_msdu_count =
-			u32_get_bits(info[4],
-				     HAL_RX_PPDU_END_USER_STATS_INFO4_TCP_MSDU_CNT);
-		ppdu_info->udp_msdu_count =
-			u32_get_bits(info[4],
-				     HAL_RX_PPDU_END_USER_STATS_INFO4_UDP_MSDU_CNT);
-		ppdu_info->other_msdu_count =
-			u32_get_bits(info[5],
-				     HAL_RX_PPDU_END_USER_STATS_INFO5_OTHER_MSDU_CNT);
-		ppdu_info->tcp_ack_msdu_count =
-			u32_get_bits(info[5],
-				     HAL_RX_PPDU_END_USER_STATS_INFO5_TCP_ACK_MSDU_CNT);
-		ppdu_info->preamble_type =
-			u32_get_bits(info[1],
-				     HAL_RX_PPDU_END_USER_STATS_INFO1_PKT_TYPE);
-		ppdu_info->num_mpdu_fcs_ok =
-			u32_get_bits(info[1],
-				     HAL_RX_PPDU_END_USER_STATS_INFO1_MPDU_CNT_FCS_OK);
-		ppdu_info->num_mpdu_fcs_err =
-			u32_get_bits(info[0],
-				     HAL_RX_PPDU_END_USER_STATS_INFO0_MPDU_CNT_FCS_ERR);
-		ppdu_info->peer_id =
-			u32_get_bits(info[0], HAL_RX_PPDU_END_USER_STATS_INFO0_PEER_ID);
-
-		switch (ppdu_info->preamble_type) {
-		case HAL_RX_PREAMBLE_11N:
-			ppdu_info->ht_flags = 1;
-			break;
-		case HAL_RX_PREAMBLE_11AC:
-			ppdu_info->vht_flags = 1;
-			break;
-		case HAL_RX_PREAMBLE_11AX:
-			ppdu_info->he_flags = 1;
-			break;
-		case HAL_RX_PREAMBLE_11BE:
-			ppdu_info->is_eht = true;
-			break;
-		default:
-			break;
-		}
-
-		if (userid < HAL_MAX_UL_MU_USERS) {
-			struct hal_rx_user_status *rxuser_stats =
-				&ppdu_info->userstats[userid];
-
-			if (ppdu_info->num_mpdu_fcs_ok > 1 ||
-			    ppdu_info->num_mpdu_fcs_err > 1)
-				ppdu_info->userstats[userid].ampdu_present = true;
-
-			ppdu_info->num_users += 1;
-
-			ath12k_dp_mon_rx_handle_ofdma_info(eu_stats, rxuser_stats);
-			ath12k_dp_mon_rx_populate_mu_user_info(eu_stats, ppdu_info,
-							       rxuser_stats);
-		}
-		ppdu_info->mpdu_fcs_ok_bitmap[0] = __le32_to_cpu(eu_stats->rsvd1[0]);
-		ppdu_info->mpdu_fcs_ok_bitmap[1] = __le32_to_cpu(eu_stats->rsvd1[1]);
-		break;
-	}
-	case HAL_RX_PPDU_END_USER_STATS_EXT: {
-		const struct hal_rx_ppdu_end_user_stats_ext *eu_stats = tlv_data;
-
-		ppdu_info->mpdu_fcs_ok_bitmap[2] = __le32_to_cpu(eu_stats->info1);
-		ppdu_info->mpdu_fcs_ok_bitmap[3] = __le32_to_cpu(eu_stats->info2);
-		ppdu_info->mpdu_fcs_ok_bitmap[4] = __le32_to_cpu(eu_stats->info3);
-		ppdu_info->mpdu_fcs_ok_bitmap[5] = __le32_to_cpu(eu_stats->info4);
-		ppdu_info->mpdu_fcs_ok_bitmap[6] = __le32_to_cpu(eu_stats->info5);
-		ppdu_info->mpdu_fcs_ok_bitmap[7] = __le32_to_cpu(eu_stats->info6);
-		break;
-	}
-	case HAL_PHYRX_HT_SIG:
-		ath12k_dp_mon_parse_ht_sig(tlv_data, ppdu_info);
-		break;
-
-	case HAL_PHYRX_L_SIG_B:
-		ath12k_dp_mon_parse_l_sig_b(tlv_data, ppdu_info);
-		break;
-
-	case HAL_PHYRX_L_SIG_A:
-		ath12k_dp_mon_parse_l_sig_a(tlv_data, ppdu_info);
-		break;
-
-	case HAL_PHYRX_VHT_SIG_A:
-		ath12k_dp_mon_parse_vht_sig_a(tlv_data, ppdu_info);
-		break;
-
-	case HAL_PHYRX_HE_SIG_A_SU:
-		ath12k_dp_mon_parse_he_sig_su(tlv_data, ppdu_info);
-		break;
-
-	case HAL_PHYRX_HE_SIG_A_MU_DL:
-		ath12k_dp_mon_parse_he_sig_mu(tlv_data, ppdu_info);
-		break;
-
-	case HAL_PHYRX_HE_SIG_B1_MU:
-		ath12k_dp_mon_parse_he_sig_b1_mu(tlv_data, ppdu_info);
-		break;
-
-	case HAL_PHYRX_HE_SIG_B2_MU:
-		ath12k_dp_mon_parse_he_sig_b2_mu(tlv_data, ppdu_info);
-		break;
-
-	case HAL_PHYRX_HE_SIG_B2_OFDMA:
-		ath12k_dp_mon_parse_he_sig_b2_ofdma(tlv_data, ppdu_info);
-		break;
-
-	case HAL_PHYRX_RSSI_LEGACY: {
-		const struct hal_rx_phyrx_rssi_legacy_info *rssi = tlv_data;
-
-		info[0] = __le32_to_cpu(rssi->info0);
-		info[1] = __le32_to_cpu(rssi->info1);
-
-		/* TODO: Please note that the combined rssi will not be accurate
-		 * in MU case. Rssi in MU needs to be retrieved from
-		 * PHYRX_OTHER_RECEIVE_INFO TLV.
-		 */
-		ppdu_info->rssi_comb =
-			u32_get_bits(info[1],
-				     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB);
-
-		ppdu_info->bw = u32_get_bits(info[0],
-					     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RX_BW);
-		break;
-	}
-	case HAL_PHYRX_OTHER_RECEIVE_INFO: {
-		const struct hal_phyrx_common_user_info *cmn_usr_info = tlv_data;
-
-		ppdu_info->gi = le32_get_bits(cmn_usr_info->info0,
-					      HAL_RX_PHY_CMN_USER_INFO0_GI);
-		break;
-	}
-	case HAL_RX_PPDU_START_USER_INFO:
-		ath12k_dp_mon_hal_rx_parse_user_info(tlv_data, userid, ppdu_info);
-		break;
-
-	case HAL_RXPCU_PPDU_END_INFO: {
-		const struct hal_rx_ppdu_end_duration *ppdu_rx_duration = tlv_data;
-
-		info[0] = __le32_to_cpu(ppdu_rx_duration->info0);
-		ppdu_info->rx_duration =
-			u32_get_bits(info[0], HAL_RX_PPDU_END_DURATION);
-		ppdu_info->tsft = __le32_to_cpu(ppdu_rx_duration->rsvd0[1]);
-		ppdu_info->tsft = (ppdu_info->tsft << 32) |
-				   __le32_to_cpu(ppdu_rx_duration->rsvd0[0]);
-		break;
-	}
-	case HAL_RX_MPDU_START: {
-		const struct hal_rx_mpdu_start *mpdu_start = tlv_data;
-		u16 peer_id;
-
-		info[1] = __le32_to_cpu(mpdu_start->info1);
-		peer_id = u32_get_bits(info[1], HAL_RX_MPDU_START_INFO1_PEERID);
-		if (peer_id)
-			ppdu_info->peer_id = peer_id;
-
-		ppdu_info->mpdu_len += u32_get_bits(info[1],
-						    HAL_RX_MPDU_START_INFO2_MPDU_LEN);
-		if (userid < HAL_MAX_UL_MU_USERS) {
-			info[0] = __le32_to_cpu(mpdu_start->info0);
-			ppdu_info->userid = userid;
-			ppdu_info->userstats[userid].ampdu_id =
-				u32_get_bits(info[0], HAL_RX_MPDU_START_INFO0_PPDU_ID);
-		}
-
-		return HAL_RX_MON_STATUS_MPDU_START;
-	}
-	case HAL_RX_MSDU_START:
-		/* TODO: add msdu start parsing logic */
-		break;
-	case HAL_MON_BUF_ADDR:
-		return HAL_RX_MON_STATUS_BUF_ADDR;
-	case HAL_RX_MSDU_END:
-		ath12k_dp_mon_parse_status_msdu_end(pmon, tlv_data);
-		return HAL_RX_MON_STATUS_MSDU_END;
-	case HAL_RX_MPDU_END:
-		return HAL_RX_MON_STATUS_MPDU_END;
-	case HAL_PHYRX_GENERIC_U_SIG:
-		ath12k_dp_mon_hal_rx_parse_u_sig_hdr(tlv_data, ppdu_info);
-		break;
-	case HAL_PHYRX_GENERIC_EHT_SIG:
-		/* Handle the case where aggregation is in progress
-		 * or the current TLV is one of the TLVs which should be
-		 * aggregated
-		 */
-		if (!ppdu_info->tlv_aggr.in_progress) {
-			ppdu_info->tlv_aggr.in_progress = true;
-			ppdu_info->tlv_aggr.tlv_tag = tlv_tag;
-			ppdu_info->tlv_aggr.cur_len = 0;
-		}
-
-		ppdu_info->is_eht = true;
-
-		ath12k_dp_mon_hal_aggr_tlv(ppdu_info, tlv_len, tlv_data);
-		break;
-	case HAL_DUMMY:
-		return HAL_RX_MON_STATUS_BUF_DONE;
-	case HAL_RX_PPDU_END_STATUS_DONE:
-	case 0:
-		return HAL_RX_MON_STATUS_PPDU_DONE;
-	default:
-		break;
-	}
-
-	return HAL_RX_MON_STATUS_PPDU_NOT_DONE;
-}
-EXPORT_SYMBOL(ath12k_dp_mon_rx_parse_status_tlv);
+EXPORT_SYMBOL(ath12k_dp_mon_parse_status_msdu_end);
 
 static void
 ath12k_dp_mon_fill_rx_stats_info(struct hal_rx_mon_ppdu_info *ppdu_info,
@@ -2413,7 +2155,7 @@ ath12k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
 }
 EXPORT_SYMBOL(ath12k_dp_mon_get_buf_len);
 
-static int
+int
 ath12k_dp_mon_parse_status_buf(struct ath12k_pdev_dp *dp_pdev,
 			       struct ath12k_mon_data *pmon,
 			       const struct dp_mon_packet_info *packet_info)
@@ -2458,45 +2200,7 @@ ath12k_dp_mon_parse_status_buf(struct ath12k_pdev_dp *dp_pdev,
 
 	return 0;
 }
-
-int
-ath12k_dp_mon_parse_rx_dest_tlv(struct ath12k_pdev_dp *dp_pdev,
-				struct ath12k_mon_data *pmon,
-				enum hal_rx_mon_status hal_status,
-				const void *tlv_data)
-{
-	switch (hal_status) {
-	case HAL_RX_MON_STATUS_MPDU_START:
-		if (WARN_ON_ONCE(pmon->mon_mpdu))
-			break;
-
-		pmon->mon_mpdu = kzalloc(sizeof(*pmon->mon_mpdu), GFP_ATOMIC);
-		if (!pmon->mon_mpdu)
-			return -ENOMEM;
-		break;
-	case HAL_RX_MON_STATUS_BUF_ADDR:
-		return ath12k_dp_mon_parse_status_buf(dp_pdev, pmon, tlv_data);
-	case HAL_RX_MON_STATUS_MPDU_END:
-		/* If no MSDU then free empty MPDU */
-		if (pmon->mon_mpdu->tail) {
-			pmon->mon_mpdu->tail->next = NULL;
-			list_add_tail(&pmon->mon_mpdu->list, &pmon->dp_rx_mon_mpdu_list);
-		} else {
-			kfree(pmon->mon_mpdu);
-		}
-		pmon->mon_mpdu = NULL;
-		break;
-	case HAL_RX_MON_STATUS_MSDU_END:
-		pmon->mon_mpdu->decap_format = pmon->decap_format;
-		pmon->mon_mpdu->err_bitmap = pmon->err_bitmap;
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(ath12k_dp_mon_parse_rx_dest_tlv);
+EXPORT_SYMBOL(ath12k_dp_mon_parse_status_buf);
 
 int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_mon_ring *buf_ring,
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index 425bec6f0f3c..bfea7d4041cb 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -9,6 +9,7 @@
 
 #include "core.h"
 #include "wifi7/hal_desc.h"
+#include "wifi7/hal_rx.h"
 
 #define ATH12K_MON_RX_DOT11_OFFSET	5
 #define ATH12K_MON_RX_PKT_OFFSET	8
@@ -106,15 +107,6 @@ int ath12k_dp_mon_rx_deliver(struct ath12k_pdev_dp *dp_pdev,
 			     struct dp_mon_mpdu *mon_mpdu,
 			     struct hal_rx_mon_ppdu_info *ppduinfo,
 			     struct napi_struct *napi);
-int
-ath12k_dp_mon_parse_rx_dest_tlv(struct ath12k_pdev_dp *dp_pdev,
-				struct ath12k_mon_data *pmon,
-				enum hal_rx_mon_status hal_status,
-				const void *tlv_data);
-enum hal_rx_mon_status
-ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
-				  struct ath12k_mon_data *pmon,
-				  const struct hal_tlv_64_hdr *tlv);
 struct sk_buff
 *ath12k_dp_rx_alloc_mon_status_buf(struct ath12k_base *ab,
 				   struct dp_rxdma_mon_ring *rx_ring,
@@ -128,4 +120,53 @@ void ath12k_dp_mon_next_link_desc_get(struct ath12k_base *ab,
 				      dma_addr_t *paddr, u32 *sw_cookie, u8 *rbm,
 				      struct ath12k_buffer_addr **pp_buf_addr_info);
 u32 ath12k_dp_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id);
+int
+ath12k_dp_mon_parse_status_buf(struct ath12k_pdev_dp *dp_pdev,
+			       struct ath12k_mon_data *pmon,
+			       const struct dp_mon_packet_info *packet_info);
+void ath12k_dp_mon_parse_ht_sig(const struct hal_rx_ht_sig_info *ht_sig,
+				struct hal_rx_mon_ppdu_info *ppdu_info);
+void
+ath12k_dp_mon_parse_eht_sig_hdr(struct hal_rx_mon_ppdu_info *ppdu_info,
+				const void *tlv_data);
+void
+ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
+				   struct hal_rx_user_status *rx_user_status);
+void
+ath12k_dp_mon_rx_populate_mu_user_info(const struct hal_rx_ppdu_end_user_stats *rx_tlv,
+				       struct hal_rx_mon_ppdu_info *ppdu_info,
+				       struct hal_rx_user_status *rx_user_status);
+void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
+				 struct hal_rx_mon_ppdu_info *ppdu_info);
+void ath12k_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
+				 struct hal_rx_mon_ppdu_info *ppdu_info);
+void
+ath12k_dp_mon_parse_he_sig_b2_ofdma(const struct hal_rx_he_sig_b2_ofdma_info *ofdma,
+				    struct hal_rx_mon_ppdu_info *ppdu_info);
+void
+ath12k_dp_mon_parse_he_sig_b2_mu(const struct hal_rx_he_sig_b2_mu_info *he_sig_b2_mu,
+				 struct hal_rx_mon_ppdu_info *ppdu_info);
+void ath12k_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vht_sig,
+				   struct hal_rx_mon_ppdu_info *ppdu_info);
+void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *he_sig_a,
+				   struct hal_rx_mon_ppdu_info *ppdu_info);
+void
+ath12k_dp_mon_parse_he_sig_b1_mu(const struct hal_rx_he_sig_b1_mu_info *he_sig_b1_mu,
+				 struct hal_rx_mon_ppdu_info *ppdu_info);
+void
+ath12k_dp_mon_parse_he_sig_mu(const struct hal_rx_he_sig_a_mu_dl_info *he_sig_a_mu_dl,
+			      struct hal_rx_mon_ppdu_info *ppdu_info);
+void
+ath12k_dp_mon_hal_rx_parse_user_info(const struct hal_receive_user_info *rx_usr_info,
+				     u16 user_id,
+				     struct hal_rx_mon_ppdu_info *ppdu_info);
+void
+ath12k_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
+				    const struct hal_rx_msdu_end *msdu_end);
+void
+ath12k_dp_mon_hal_rx_parse_u_sig_hdr(const struct hal_mon_usig_hdr *usig,
+				     struct hal_rx_mon_ppdu_info *ppdu_info);
+void
+ath12k_dp_mon_hal_aggr_tlv(struct hal_rx_mon_ppdu_info *ppdu_info,
+			   u16 tlv_len, const void *tlv_data);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
index dae3f262cc50..076fb75a101f 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -10,6 +10,7 @@
 #include "../debug.h"
 #include "hal_qcn9274.h"
 #include "dp_rx.h"
+#include "../dp_tx.h"
 #include "../peer.h"
 
 static void
@@ -19,6 +20,317 @@ ath12k_wifi7_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info)
 	ppdu_info->peer_id = HAL_INVALID_PEERID;
 }
 
+static enum hal_rx_mon_status
+ath12k_wifi7_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
+					struct ath12k_mon_data *pmon,
+					const struct hal_tlv_64_hdr *tlv)
+{
+	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
+	const void *tlv_data = tlv->value;
+	u32 info[7], userid;
+	u16 tlv_tag, tlv_len;
+
+	tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
+	tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
+	userid = le64_get_bits(tlv->tl, HAL_TLV_64_USR_ID);
+
+	if (ppdu_info->tlv_aggr.in_progress && ppdu_info->tlv_aggr.tlv_tag != tlv_tag) {
+		ath12k_dp_mon_parse_eht_sig_hdr(ppdu_info, ppdu_info->tlv_aggr.buf);
+
+		ppdu_info->tlv_aggr.in_progress = false;
+		ppdu_info->tlv_aggr.cur_len = 0;
+	}
+
+	switch (tlv_tag) {
+	case HAL_RX_PPDU_START: {
+		const struct hal_rx_ppdu_start *ppdu_start = tlv_data;
+
+		u64 ppdu_ts = ath12k_le32hilo_to_u64(ppdu_start->ppdu_start_ts_63_32,
+						     ppdu_start->ppdu_start_ts_31_0);
+
+		info[0] = __le32_to_cpu(ppdu_start->info0);
+
+		ppdu_info->ppdu_id = u32_get_bits(info[0],
+						  HAL_RX_PPDU_START_INFO0_PPDU_ID);
+
+		info[1] = __le32_to_cpu(ppdu_start->info1);
+		ppdu_info->chan_num = u32_get_bits(info[1],
+						   HAL_RX_PPDU_START_INFO1_CHAN_NUM);
+		ppdu_info->freq = u32_get_bits(info[1],
+					       HAL_RX_PPDU_START_INFO1_CHAN_FREQ);
+		ppdu_info->ppdu_ts = ppdu_ts;
+
+		if (ppdu_info->ppdu_id != ppdu_info->last_ppdu_id) {
+			ppdu_info->last_ppdu_id = ppdu_info->ppdu_id;
+			ppdu_info->num_users = 0;
+			memset(&ppdu_info->mpdu_fcs_ok_bitmap, 0,
+			       HAL_RX_NUM_WORDS_PER_PPDU_BITMAP *
+			       sizeof(ppdu_info->mpdu_fcs_ok_bitmap[0]));
+		}
+		break;
+	}
+	case HAL_RX_PPDU_END_USER_STATS: {
+		const struct hal_rx_ppdu_end_user_stats *eu_stats = tlv_data;
+		u32 tid_bitmap;
+
+		info[0] = __le32_to_cpu(eu_stats->info0);
+		info[1] = __le32_to_cpu(eu_stats->info1);
+		info[2] = __le32_to_cpu(eu_stats->info2);
+		info[4] = __le32_to_cpu(eu_stats->info4);
+		info[5] = __le32_to_cpu(eu_stats->info5);
+		info[6] = __le32_to_cpu(eu_stats->info6);
+
+		ppdu_info->ast_index =
+			u32_get_bits(info[2], HAL_RX_PPDU_END_USER_STATS_INFO2_AST_INDEX);
+		ppdu_info->fc_valid =
+			u32_get_bits(info[1], HAL_RX_PPDU_END_USER_STATS_INFO1_FC_VALID);
+		tid_bitmap = u32_get_bits(info[6],
+					  HAL_RX_PPDU_END_USER_STATS_INFO6_TID_BITMAP);
+		ppdu_info->tid = ffs(tid_bitmap) - 1;
+		ppdu_info->tcp_msdu_count =
+			u32_get_bits(info[4],
+				     HAL_RX_PPDU_END_USER_STATS_INFO4_TCP_MSDU_CNT);
+		ppdu_info->udp_msdu_count =
+			u32_get_bits(info[4],
+				     HAL_RX_PPDU_END_USER_STATS_INFO4_UDP_MSDU_CNT);
+		ppdu_info->other_msdu_count =
+			u32_get_bits(info[5],
+				     HAL_RX_PPDU_END_USER_STATS_INFO5_OTHER_MSDU_CNT);
+		ppdu_info->tcp_ack_msdu_count =
+			u32_get_bits(info[5],
+				     HAL_RX_PPDU_END_USER_STATS_INFO5_TCP_ACK_MSDU_CNT);
+		ppdu_info->preamble_type =
+			u32_get_bits(info[1],
+				     HAL_RX_PPDU_END_USER_STATS_INFO1_PKT_TYPE);
+		ppdu_info->num_mpdu_fcs_ok =
+			u32_get_bits(info[1],
+				     HAL_RX_PPDU_END_USER_STATS_INFO1_MPDU_CNT_FCS_OK);
+		ppdu_info->num_mpdu_fcs_err =
+			u32_get_bits(info[0],
+				     HAL_RX_PPDU_END_USER_STATS_INFO0_MPDU_CNT_FCS_ERR);
+		ppdu_info->peer_id =
+			u32_get_bits(info[0], HAL_RX_PPDU_END_USER_STATS_INFO0_PEER_ID);
+
+		switch (ppdu_info->preamble_type) {
+		case HAL_RX_PREAMBLE_11N:
+			ppdu_info->ht_flags = 1;
+			break;
+		case HAL_RX_PREAMBLE_11AC:
+			ppdu_info->vht_flags = 1;
+			break;
+		case HAL_RX_PREAMBLE_11AX:
+			ppdu_info->he_flags = 1;
+			break;
+		case HAL_RX_PREAMBLE_11BE:
+			ppdu_info->is_eht = true;
+			break;
+		default:
+			break;
+		}
+
+		if (userid < HAL_MAX_UL_MU_USERS) {
+			struct hal_rx_user_status *rxuser_stats =
+				&ppdu_info->userstats[userid];
+
+			if (ppdu_info->num_mpdu_fcs_ok > 1 ||
+			    ppdu_info->num_mpdu_fcs_err > 1)
+				ppdu_info->userstats[userid].ampdu_present = true;
+
+			ppdu_info->num_users += 1;
+
+			ath12k_dp_mon_rx_handle_ofdma_info(eu_stats, rxuser_stats);
+			ath12k_dp_mon_rx_populate_mu_user_info(eu_stats, ppdu_info,
+							       rxuser_stats);
+		}
+		ppdu_info->mpdu_fcs_ok_bitmap[0] = __le32_to_cpu(eu_stats->rsvd1[0]);
+		ppdu_info->mpdu_fcs_ok_bitmap[1] = __le32_to_cpu(eu_stats->rsvd1[1]);
+		break;
+	}
+	case HAL_RX_PPDU_END_USER_STATS_EXT: {
+		const struct hal_rx_ppdu_end_user_stats_ext *eu_stats = tlv_data;
+
+		ppdu_info->mpdu_fcs_ok_bitmap[2] = __le32_to_cpu(eu_stats->info1);
+		ppdu_info->mpdu_fcs_ok_bitmap[3] = __le32_to_cpu(eu_stats->info2);
+		ppdu_info->mpdu_fcs_ok_bitmap[4] = __le32_to_cpu(eu_stats->info3);
+		ppdu_info->mpdu_fcs_ok_bitmap[5] = __le32_to_cpu(eu_stats->info4);
+		ppdu_info->mpdu_fcs_ok_bitmap[6] = __le32_to_cpu(eu_stats->info5);
+		ppdu_info->mpdu_fcs_ok_bitmap[7] = __le32_to_cpu(eu_stats->info6);
+		break;
+	}
+	case HAL_PHYRX_HT_SIG:
+		ath12k_dp_mon_parse_ht_sig(tlv_data, ppdu_info);
+		break;
+
+	case HAL_PHYRX_L_SIG_B:
+		ath12k_dp_mon_parse_l_sig_b(tlv_data, ppdu_info);
+		break;
+
+	case HAL_PHYRX_L_SIG_A:
+		ath12k_dp_mon_parse_l_sig_a(tlv_data, ppdu_info);
+		break;
+
+	case HAL_PHYRX_VHT_SIG_A:
+		ath12k_dp_mon_parse_vht_sig_a(tlv_data, ppdu_info);
+		break;
+
+	case HAL_PHYRX_HE_SIG_A_SU:
+		ath12k_dp_mon_parse_he_sig_su(tlv_data, ppdu_info);
+		break;
+
+	case HAL_PHYRX_HE_SIG_A_MU_DL:
+		ath12k_dp_mon_parse_he_sig_mu(tlv_data, ppdu_info);
+		break;
+
+	case HAL_PHYRX_HE_SIG_B1_MU:
+		ath12k_dp_mon_parse_he_sig_b1_mu(tlv_data, ppdu_info);
+		break;
+
+	case HAL_PHYRX_HE_SIG_B2_MU:
+		ath12k_dp_mon_parse_he_sig_b2_mu(tlv_data, ppdu_info);
+		break;
+
+	case HAL_PHYRX_HE_SIG_B2_OFDMA:
+		ath12k_dp_mon_parse_he_sig_b2_ofdma(tlv_data, ppdu_info);
+		break;
+
+	case HAL_PHYRX_RSSI_LEGACY: {
+		const struct hal_rx_phyrx_rssi_legacy_info *rssi = tlv_data;
+
+		info[0] = __le32_to_cpu(rssi->info0);
+		info[1] = __le32_to_cpu(rssi->info1);
+
+		/* TODO: Please note that the combined rssi will not be accurate
+		 * in MU case. Rssi in MU needs to be retrieved from
+		 * PHYRX_OTHER_RECEIVE_INFO TLV.
+		 */
+		ppdu_info->rssi_comb =
+			u32_get_bits(info[1],
+				     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB);
+
+		ppdu_info->bw = u32_get_bits(info[0],
+					     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RX_BW);
+		break;
+	}
+	case HAL_PHYRX_OTHER_RECEIVE_INFO: {
+		const struct hal_phyrx_common_user_info *cmn_usr_info = tlv_data;
+
+		ppdu_info->gi = le32_get_bits(cmn_usr_info->info0,
+					      HAL_RX_PHY_CMN_USER_INFO0_GI);
+		break;
+	}
+	case HAL_RX_PPDU_START_USER_INFO:
+		ath12k_dp_mon_hal_rx_parse_user_info(tlv_data, userid, ppdu_info);
+		break;
+
+	case HAL_RXPCU_PPDU_END_INFO: {
+		const struct hal_rx_ppdu_end_duration *ppdu_rx_duration = tlv_data;
+
+		info[0] = __le32_to_cpu(ppdu_rx_duration->info0);
+		ppdu_info->rx_duration =
+			u32_get_bits(info[0], HAL_RX_PPDU_END_DURATION);
+		ppdu_info->tsft = __le32_to_cpu(ppdu_rx_duration->rsvd0[1]);
+		ppdu_info->tsft = (ppdu_info->tsft << 32) |
+				   __le32_to_cpu(ppdu_rx_duration->rsvd0[0]);
+		break;
+	}
+	case HAL_RX_MPDU_START: {
+		const struct hal_rx_mpdu_start *mpdu_start = tlv_data;
+		u16 peer_id;
+
+		info[1] = __le32_to_cpu(mpdu_start->info1);
+		peer_id = u32_get_bits(info[1], HAL_RX_MPDU_START_INFO1_PEERID);
+		if (peer_id)
+			ppdu_info->peer_id = peer_id;
+
+		ppdu_info->mpdu_len += u32_get_bits(info[1],
+						    HAL_RX_MPDU_START_INFO2_MPDU_LEN);
+		if (userid < HAL_MAX_UL_MU_USERS) {
+			info[0] = __le32_to_cpu(mpdu_start->info0);
+			ppdu_info->userid = userid;
+			ppdu_info->userstats[userid].ampdu_id =
+				u32_get_bits(info[0], HAL_RX_MPDU_START_INFO0_PPDU_ID);
+		}
+
+		return HAL_RX_MON_STATUS_MPDU_START;
+	}
+	case HAL_RX_MSDU_START:
+		/* TODO: add msdu start parsing logic */
+		break;
+	case HAL_MON_BUF_ADDR:
+		return HAL_RX_MON_STATUS_BUF_ADDR;
+	case HAL_RX_MSDU_END:
+		ath12k_dp_mon_parse_status_msdu_end(pmon, tlv_data);
+		return HAL_RX_MON_STATUS_MSDU_END;
+	case HAL_RX_MPDU_END:
+		return HAL_RX_MON_STATUS_MPDU_END;
+	case HAL_PHYRX_GENERIC_U_SIG:
+		ath12k_dp_mon_hal_rx_parse_u_sig_hdr(tlv_data, ppdu_info);
+		break;
+	case HAL_PHYRX_GENERIC_EHT_SIG:
+		/* Handle the case where aggregation is in progress
+		 * or the current TLV is one of the TLVs which should be
+		 * aggregated
+		 */
+		if (!ppdu_info->tlv_aggr.in_progress) {
+			ppdu_info->tlv_aggr.in_progress = true;
+			ppdu_info->tlv_aggr.tlv_tag = tlv_tag;
+			ppdu_info->tlv_aggr.cur_len = 0;
+		}
+
+		ppdu_info->is_eht = true;
+
+		ath12k_dp_mon_hal_aggr_tlv(ppdu_info, tlv_len, tlv_data);
+		break;
+	case HAL_DUMMY:
+		return HAL_RX_MON_STATUS_BUF_DONE;
+	case HAL_RX_PPDU_END_STATUS_DONE:
+	case 0:
+		return HAL_RX_MON_STATUS_PPDU_DONE;
+	default:
+		break;
+	}
+
+	return HAL_RX_MON_STATUS_PPDU_NOT_DONE;
+}
+
+static int
+ath12k_wifi7_dp_mon_parse_rx_dest_tlv(struct ath12k_pdev_dp *dp_pdev,
+				      struct ath12k_mon_data *pmon,
+				      enum hal_rx_mon_status hal_status,
+				      const void *tlv_data)
+{
+	switch (hal_status) {
+	case HAL_RX_MON_STATUS_MPDU_START:
+		if (WARN_ON_ONCE(pmon->mon_mpdu))
+			break;
+
+		pmon->mon_mpdu = kzalloc(sizeof(*pmon->mon_mpdu), GFP_ATOMIC);
+		if (!pmon->mon_mpdu)
+			return -ENOMEM;
+		break;
+	case HAL_RX_MON_STATUS_BUF_ADDR:
+		return ath12k_dp_mon_parse_status_buf(dp_pdev, pmon, tlv_data);
+	case HAL_RX_MON_STATUS_MPDU_END:
+		/* If no MSDU then free empty MPDU */
+		if (pmon->mon_mpdu->tail) {
+			pmon->mon_mpdu->tail->next = NULL;
+			list_add_tail(&pmon->mon_mpdu->list, &pmon->dp_rx_mon_mpdu_list);
+		} else {
+			kfree(pmon->mon_mpdu);
+		}
+		pmon->mon_mpdu = NULL;
+		break;
+	case HAL_RX_MON_STATUS_MSDU_END:
+		pmon->mon_mpdu->decap_format = pmon->decap_format;
+		pmon->mon_mpdu->err_bitmap = pmon->err_bitmap;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static u32
 ath12k_wifi7_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 				void *ring_entry, struct sk_buff **head_msdu,
@@ -389,11 +701,12 @@ ath12k_wifi7_dp_mon_parse_rx_dest(struct ath12k_pdev_dp *dp_pdev,
 		else
 			tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
 
-		hal_status = ath12k_dp_mon_rx_parse_status_tlv(dp_pdev, pmon, tlv);
+		hal_status = ath12k_wifi7_dp_mon_rx_parse_status_tlv(dp_pdev, pmon,
+								     tlv);
 
 		if (ar->monitor_started && ar->ab->hw_params->rxdma1_enable &&
-		    ath12k_dp_mon_parse_rx_dest_tlv(dp_pdev, pmon, hal_status,
-						    tlv->value))
+		    ath12k_wifi7_dp_mon_parse_rx_dest_tlv(dp_pdev, pmon, hal_status,
+							  tlv->value))
 			return HAL_RX_MON_STATUS_PPDU_DONE;
 
 		ptr += sizeof(*tlv) + tlv_len;
-- 
2.34.1


