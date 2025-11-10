Return-Path: <linux-wireless+bounces-28737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEFEC45F9C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952D4188DFDD
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5407030595A;
	Mon, 10 Nov 2025 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eQWwvmaE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23E3064A9
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771051; cv=none; b=QtTbzcKNUNGyPd/4UspSccW8cwdMXAWX6xieTSycpNq5MxcgFRZWxQqnML4OoEx188WNaPq0z6zow6N4E76lD+YzzNi8UqGnRAPIqG63uh+fEkbYe5MjegugFD6zjV2az+T5tEsJ5DhNhPIakByhxe6PV3vLOU8y3qtWAKDAgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771051; c=relaxed/simple;
	bh=Jx0DAEq2WujvED4X7ZSNGHH75NaV5+k20E+hLcUeoHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irC25AAQWZc7pvGkGXYX1d2lmpDn3NYcA3ly/uXsBfGrwnclommXfDjkNYvmxIV3RpsLpCmvve+fta3ugJoy4s+OqDAUN14QPmZLpnSUN1gdyUcOmSaNTMPJdh1lfGvMBhHCL5XdZ2TOYOsUtqznYpafQkQV0LiHCLjKYZoAZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eQWwvmaE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8EIaZ1434945;
	Mon, 10 Nov 2025 10:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=b8SjTkP15YZ
	SjXcjG3RWEoASayBZm1A7Hmc9Pefl+xs=; b=eQWwvmaE7+bgs1QtXhWTsZi8SP2
	jokSYwNqQ9TGzBn053RtDankUAGrS9542+a6EUz4lhG6Zqow366KGIYPRbow7wkD
	HyIRnkr21l4Wffp/v5sKhX30IifcFwDEbttf8SBrcY3fd8XeiCc12lofq7+tJkF9
	J50po7rtJIWiKolGZuFUz/7M+pHzD/1Ya28QKmygcD0fPY4Yy6sds5+pyUqGbjVp
	krCsW0FOFbPSFudkn0dmjM3nCCr86oK3wujIdhwQ05lzrAZ5QHw7PYetGxLXzd02
	NEEEi0wp6bp0GK3/6BjdSpy78AjDb/hEORIuWNp7ML+IgV74gi+vtENOlYA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xs7ceqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:22 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAbIUb008142;
	Mon, 10 Nov 2025 10:37:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxkq1gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:19 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AAAbH2L008046;
	Mon, 10 Nov 2025 10:37:18 GMT
Received: from hu-devc-blr-u22-c.qualcomm.com (hu-aloksing-blr.qualcomm.com [10.190.111.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AAAbIbM008090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:18 +0000
Received: by hu-devc-blr-u22-c.qualcomm.com (Postfix, from userid 2272527)
	id 90382B70; Mon, 10 Nov 2025 16:07:16 +0530 (+0530)
From: Alok Singh <quic_aloksing@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Alok Singh <quic_aloksing@quicinc.com>
Subject: [PATCH ath12k-ng 06/12] wifi: ath12k: Move HT/VHT SIG processing to Wi-Fi 7 module
Date: Mon, 10 Nov 2025 16:07:07 +0530
Message-Id: <20251110103713.3484779-7-quic_aloksing@quicinc.com>
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
X-Proofpoint-GUID: S6FTCsRVby_JN55oh7dD4qlFziFNESzl
X-Proofpoint-ORIG-GUID: S6FTCsRVby_JN55oh7dD4qlFziFNESzl
X-Authority-Analysis: v=2.4 cv=LtifC3dc c=1 sm=1 tr=0 ts=6911c063 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=20ooYGPJy4puZ6AmL08A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MiBTYWx0ZWRfXzgn2ssMCYXzS
 a5s7iViJaLHtrHCHEcrdvyslFUD8E+Jc9cSArdMgABa87kMfT4LNowlyC00MgY9e9CFxiAJDcdl
 /XgLq38xjVTNsfhjP4trw/jSNTcnw2y+RY2BdHSxkuUdbxvDYSPTRlUTusClqOS+C6j5CaTwPBX
 SC4iJPmfkXsgp/4NHHOM70wC4q8cDi5nYRje9bJicyF5XCys0N05h5kQdQvHQOsp48X0h9CtRBt
 tIoUE+CFuT5tFFN5nj3lfbuls2D4VMqpNJgwmePB8tWEDfYfg8BRVG5PVloBtXG/yMRYJauf1aH
 eyS5Fy2Paj8NYnC/vd1jsUTnQbC6EhKZP0dl6a84eFJaRtULV5ML8l5NCStwXdmeIYNm92e69+h
 hssZNsGe4xX2Uz3s3KhWKWpcK5MSZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100092

Separate Wi-Fi 7-specific monitor parsing from ath12k common code
to improve modularity and keep Wi-Fi 7 logic within the Wi-Fi 7 module.

Move following HT/VHT SIG parsing functions to wifi7/dp_mon.c and
rename the functions with the ath12k_wifi7 prefix:
- ath12k_dp_mon_parse_vht_sig_a()
- ath12k_dp_mon_parse_ht_sig()

Export helper functions required by the ath12k_wifi7 module.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Alok Singh <quic_aloksing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 56 -----------------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |  4 --
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 62 ++++++++++++++++++-
 3 files changed, 59 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index d3e662399c31..879dc86fcdb7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -81,62 +81,6 @@ ath12k_dp_mon_rx_populate_mu_user_info(const struct hal_rx_ppdu_end_user_stats *
 }
 EXPORT_SYMBOL(ath12k_dp_mon_rx_populate_mu_user_info);
 
-void ath12k_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vht_sig,
-				   struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	u32 nsts, info0, info1;
-	u8 gi_setting;
-
-	info0 = __le32_to_cpu(vht_sig->info0);
-	info1 = __le32_to_cpu(vht_sig->info1);
-
-	ppdu_info->ldpc = u32_get_bits(info1, HAL_RX_VHT_SIG_A_INFO_INFO1_SU_MU_CODING);
-	ppdu_info->mcs = u32_get_bits(info1, HAL_RX_VHT_SIG_A_INFO_INFO1_MCS);
-	gi_setting = u32_get_bits(info1, HAL_RX_VHT_SIG_A_INFO_INFO1_GI_SETTING);
-	switch (gi_setting) {
-	case HAL_RX_VHT_SIG_A_NORMAL_GI:
-		ppdu_info->gi = HAL_RX_GI_0_8_US;
-		break;
-	case HAL_RX_VHT_SIG_A_SHORT_GI:
-	case HAL_RX_VHT_SIG_A_SHORT_GI_AMBIGUITY:
-		ppdu_info->gi = HAL_RX_GI_0_4_US;
-		break;
-	}
-
-	ppdu_info->is_stbc = u32_get_bits(info0, HAL_RX_VHT_SIG_A_INFO_INFO0_STBC);
-	nsts = u32_get_bits(info0, HAL_RX_VHT_SIG_A_INFO_INFO0_NSTS);
-	if (ppdu_info->is_stbc && nsts > 0)
-		nsts = ((nsts + 1) >> 1) - 1;
-
-	ppdu_info->nss = u32_get_bits(nsts, VHT_SIG_SU_NSS_MASK);
-	ppdu_info->bw = u32_get_bits(info0, HAL_RX_VHT_SIG_A_INFO_INFO0_BW);
-	ppdu_info->beamformed = u32_get_bits(info1,
-					     HAL_RX_VHT_SIG_A_INFO_INFO1_BEAMFORMED);
-	ppdu_info->vht_flag_values5 = u32_get_bits(info0,
-						   HAL_RX_VHT_SIG_A_INFO_INFO0_GROUP_ID);
-	ppdu_info->vht_flag_values3[0] = (((ppdu_info->mcs) << 4) |
-					    ppdu_info->nss);
-	ppdu_info->vht_flag_values2 = ppdu_info->bw;
-	ppdu_info->vht_flag_values4 =
-		u32_get_bits(info1, HAL_RX_VHT_SIG_A_INFO_INFO1_SU_MU_CODING);
-}
-EXPORT_SYMBOL(ath12k_dp_mon_parse_vht_sig_a);
-
-void ath12k_dp_mon_parse_ht_sig(const struct hal_rx_ht_sig_info *ht_sig,
-				struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	u32 info0 = __le32_to_cpu(ht_sig->info0);
-	u32 info1 = __le32_to_cpu(ht_sig->info1);
-
-	ppdu_info->mcs = u32_get_bits(info0, HAL_RX_HT_SIG_INFO_INFO0_MCS);
-	ppdu_info->bw = u32_get_bits(info0, HAL_RX_HT_SIG_INFO_INFO0_BW);
-	ppdu_info->is_stbc = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_STBC);
-	ppdu_info->ldpc = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_FEC_CODING);
-	ppdu_info->gi = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_GI);
-	ppdu_info->nss = (ppdu_info->mcs >> 3);
-}
-EXPORT_SYMBOL(ath12k_dp_mon_parse_ht_sig);
-
 void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
 				 struct hal_rx_mon_ppdu_info *ppdu_info)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index 1d2ec4072a83..86d0c18d8c07 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -113,8 +113,6 @@ int
 ath12k_dp_mon_parse_status_buf(struct ath12k_pdev_dp *dp_pdev,
 			       struct ath12k_mon_data *pmon,
 			       const struct dp_mon_packet_info *packet_info);
-void ath12k_dp_mon_parse_ht_sig(const struct hal_rx_ht_sig_info *ht_sig,
-				struct hal_rx_mon_ppdu_info *ppdu_info);
 void
 ath12k_dp_mon_parse_eht_sig_hdr(struct hal_rx_mon_ppdu_info *ppdu_info,
 				const void *tlv_data);
@@ -135,8 +133,6 @@ ath12k_dp_mon_parse_he_sig_b2_ofdma(const struct hal_rx_he_sig_b2_ofdma_info *of
 void
 ath12k_dp_mon_parse_he_sig_b2_mu(const struct hal_rx_he_sig_b2_mu_info *he_sig_b2_mu,
 				 struct hal_rx_mon_ppdu_info *ppdu_info);
-void ath12k_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vht_sig,
-				   struct hal_rx_mon_ppdu_info *ppdu_info);
 void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *he_sig_a,
 				   struct hal_rx_mon_ppdu_info *ppdu_info);
 void
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
index abdfd3cfd0e4..0c83df4be9da 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -20,6 +20,62 @@ ath12k_wifi7_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info)
 	ppdu_info->peer_id = HAL_INVALID_PEERID;
 }
 
+static void
+ath12k_wifi7_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vht_sig,
+				    struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	u32 nsts, info0, info1;
+	u8 gi_setting;
+
+	info0 = __le32_to_cpu(vht_sig->info0);
+	info1 = __le32_to_cpu(vht_sig->info1);
+
+	ppdu_info->ldpc = u32_get_bits(info1, HAL_RX_VHT_SIG_A_INFO_INFO1_SU_MU_CODING);
+	ppdu_info->mcs = u32_get_bits(info1, HAL_RX_VHT_SIG_A_INFO_INFO1_MCS);
+	gi_setting = u32_get_bits(info1, HAL_RX_VHT_SIG_A_INFO_INFO1_GI_SETTING);
+	switch (gi_setting) {
+	case HAL_RX_VHT_SIG_A_NORMAL_GI:
+		ppdu_info->gi = HAL_RX_GI_0_8_US;
+		break;
+	case HAL_RX_VHT_SIG_A_SHORT_GI:
+	case HAL_RX_VHT_SIG_A_SHORT_GI_AMBIGUITY:
+		ppdu_info->gi = HAL_RX_GI_0_4_US;
+		break;
+	}
+
+	ppdu_info->is_stbc = u32_get_bits(info0, HAL_RX_VHT_SIG_A_INFO_INFO0_STBC);
+	nsts = u32_get_bits(info0, HAL_RX_VHT_SIG_A_INFO_INFO0_NSTS);
+	if (ppdu_info->is_stbc && nsts > 0)
+		nsts = ((nsts + 1) >> 1) - 1;
+
+	ppdu_info->nss = u32_get_bits(nsts, VHT_SIG_SU_NSS_MASK);
+	ppdu_info->bw = u32_get_bits(info0, HAL_RX_VHT_SIG_A_INFO_INFO0_BW);
+	ppdu_info->beamformed = u32_get_bits(info1,
+					     HAL_RX_VHT_SIG_A_INFO_INFO1_BEAMFORMED);
+	ppdu_info->vht_flag_values5 = u32_get_bits(info0,
+						   HAL_RX_VHT_SIG_A_INFO_INFO0_GROUP_ID);
+	ppdu_info->vht_flag_values3[0] = (((ppdu_info->mcs) << 4) |
+					    ppdu_info->nss);
+	ppdu_info->vht_flag_values2 = ppdu_info->bw;
+	ppdu_info->vht_flag_values4 =
+		u32_get_bits(info1, HAL_RX_VHT_SIG_A_INFO_INFO1_SU_MU_CODING);
+}
+
+static void
+ath12k_wifi7_dp_mon_parse_ht_sig(const struct hal_rx_ht_sig_info *ht_sig,
+				 struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	u32 info0 = __le32_to_cpu(ht_sig->info0);
+	u32 info1 = __le32_to_cpu(ht_sig->info1);
+
+	ppdu_info->mcs = u32_get_bits(info0, HAL_RX_HT_SIG_INFO_INFO0_MCS);
+	ppdu_info->bw = u32_get_bits(info0, HAL_RX_HT_SIG_INFO_INFO0_BW);
+	ppdu_info->is_stbc = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_STBC);
+	ppdu_info->ldpc = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_FEC_CODING);
+	ppdu_info->gi = u32_get_bits(info1, HAL_RX_HT_SIG_INFO_INFO1_GI);
+	ppdu_info->nss = (ppdu_info->mcs >> 3);
+}
+
 static enum hal_rx_mon_status
 ath12k_wifi7_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 					struct ath12k_mon_data *pmon,
@@ -158,7 +214,7 @@ ath12k_wifi7_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 		break;
 	}
 	case HAL_PHYRX_HT_SIG:
-		ath12k_dp_mon_parse_ht_sig(tlv_data, ppdu_info);
+		ath12k_wifi7_dp_mon_parse_ht_sig(tlv_data, ppdu_info);
 		break;
 
 	case HAL_PHYRX_L_SIG_B:
@@ -170,7 +226,7 @@ ath12k_wifi7_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 		break;
 
 	case HAL_PHYRX_VHT_SIG_A:
-		ath12k_dp_mon_parse_vht_sig_a(tlv_data, ppdu_info);
+		ath12k_wifi7_dp_mon_parse_vht_sig_a(tlv_data, ppdu_info);
 		break;
 
 	case HAL_PHYRX_HE_SIG_A_SU:
@@ -819,7 +875,7 @@ ath12k_wifi7_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 		break;
 
 	case HAL_MACTX_VHT_SIG_A:
-		ath12k_dp_mon_parse_vht_sig_a(tlv_data, &tx_ppdu_info->rx_status);
+		ath12k_wifi7_dp_mon_parse_vht_sig_a(tlv_data, &tx_ppdu_info->rx_status);
 		break;
 
 	case HAL_MACTX_L_SIG_A:
-- 
2.34.1


