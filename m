Return-Path: <linux-wireless+bounces-15482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46F9D1C96
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 01:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E084B282C97
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 00:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02951AAC4;
	Tue, 19 Nov 2024 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cEijMIdM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1808E571
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976404; cv=none; b=T4W57mz/rBigEyOerBb9WE4OquFX9dsMwnBjAkVJKAqXEI16yrd6GszDwy8/fVYyZ7By0v3AKR4E7EH0cmhYDyEELRbhJHhvxSGj0NGAfsiSeeDsK9+4a8ytszxXEa15nBCIAEzKetLi9XJOlUmyO381vRbROLh7hYx1U7X0dvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976404; c=relaxed/simple;
	bh=e+pfw0xLbIpAqoF5Y03phEK7Jt1X1U6nt/SqVrw0RSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2rY0NKKUWuckxqx1Zm7s9IzL5L7MFdnNPGAHGXR3lowNb7G8Cb6cOqxaOKBe1XP4qFmDochper7qxfRKxWFKF+wggAyIbBmqqFxefmVzX2HvAWCgUy4p2zSXVI/mgwZO0Q0nBEq3v2MeDOgg7WFUb2Lv8sJDDqu6qsgXuk8D4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cEijMIdM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGpjU030154;
	Tue, 19 Nov 2024 00:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oXsY3AHTiIagJojBxQW95e4F11XzUwxI+MJGje4cqD0=; b=cEijMIdM+E91psR+
	vxW/VXaXeIlXQwv+zdYpKkzXik7ohF6jRXg2bi1eODqt3gpjNHNCLAnjiViBIDAU
	yj2RDeAe0l60YuGwRGF/xWh43+KL1sNej0ciTz+Fgfh/vaCBExYReF99ZpnFbkDc
	PhpMAJkRmNch48CXJpI8Q1efM6XcPEjpMkA/lgAfO5rZcJa2p9imosXed0IzmG3Q
	JmUExOuQSD1Q5s6lGc+WP5GXLeMTjl7koyvW9onoM/A1J0Apsi5WanY797Qd0e/n
	XjdnfhmQpLKuwuqc+OQRVVQQ5s0QK9NaFrq7Duex4lxTdkPdEdHs69uWUHDybBgR
	RXgl7g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y68y86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ0XK2j018069
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:20 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 16:33:18 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 8/8] wifi: ath12k: Avoid explicit type cast in monitor status parse handler
Date: Tue, 19 Nov 2024 06:02:48 +0530
Message-ID: <20241119003248.1579567-9-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
References: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 7AmKtVDDJL3kBawC68D1LjsHliR23ic3
X-Proofpoint-GUID: 7AmKtVDDJL3kBawC68D1LjsHliR23ic3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190003

Currently, monitor status parse procedure handles all the supported TLV
tags. Each TLV tag has its own data structure for parsing. Now, this
handler is passed the tlv_data as a u8 pointer, so explicit type cast
conversion happens for every TLV tag parsing. Therefore, avoid the
explicit type conversion by changing the tlv_data type from a u8 pointer
to a const void pointer.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 126 +++++++++--------------
 1 file changed, 47 insertions(+), 79 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 37127771291f..22a27ce32b40 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -10,11 +10,10 @@
 #include "dp_tx.h"
 #include "peer.h"
 
-static void ath12k_dp_mon_rx_handle_ofdma_info(void *rx_tlv,
-					       struct hal_rx_user_status *rx_user_status)
+static void
+ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
+				   struct hal_rx_user_status *rx_user_status)
 {
-	struct hal_rx_ppdu_end_user_stats *ppdu_end_user = rx_tlv;
-
 	rx_user_status->ul_ofdma_user_v0_word0 =
 		__le32_to_cpu(ppdu_end_user->usr_resp_ref);
 	rx_user_status->ul_ofdma_user_v0_word1 =
@@ -35,7 +34,7 @@ ath12k_dp_mon_rx_populate_byte_count(const struct hal_rx_ppdu_end_user_stats *st
 }
 
 static void
-ath12k_dp_mon_rx_populate_mu_user_info(void *rx_tlv,
+ath12k_dp_mon_rx_populate_mu_user_info(const struct hal_rx_ppdu_end_user_stats *rx_tlv,
 				       struct hal_rx_mon_ppdu_info *ppdu_info,
 				       struct hal_rx_user_status *rx_user_status)
 {
@@ -73,11 +72,9 @@ ath12k_dp_mon_rx_populate_mu_user_info(void *rx_tlv,
 	ath12k_dp_mon_rx_populate_byte_count(rx_tlv, ppdu_info, rx_user_status);
 }
 
-static void ath12k_dp_mon_parse_vht_sig_a(u8 *tlv_data,
+static void ath12k_dp_mon_parse_vht_sig_a(const struct hal_rx_vht_sig_a_info *vht_sig,
 					  struct hal_rx_mon_ppdu_info *ppdu_info)
 {
-	struct hal_rx_vht_sig_a_info *vht_sig =
-			(struct hal_rx_vht_sig_a_info *)tlv_data;
 	u32 nsts, group_id, info0, info1;
 	u8 gi_setting;
 
@@ -119,11 +116,9 @@ static void ath12k_dp_mon_parse_vht_sig_a(u8 *tlv_data,
 		u32_get_bits(info1, HAL_RX_VHT_SIG_A_INFO_INFO1_SU_MU_CODING);
 }
 
-static void ath12k_dp_mon_parse_ht_sig(u8 *tlv_data,
+static void ath12k_dp_mon_parse_ht_sig(const struct hal_rx_ht_sig_info *ht_sig,
 				       struct hal_rx_mon_ppdu_info *ppdu_info)
 {
-	struct hal_rx_ht_sig_info *ht_sig =
-			(struct hal_rx_ht_sig_info *)tlv_data;
 	u32 info0 = __le32_to_cpu(ht_sig->info0);
 	u32 info1 = __le32_to_cpu(ht_sig->info1);
 
@@ -136,11 +131,9 @@ static void ath12k_dp_mon_parse_ht_sig(u8 *tlv_data,
 	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
 }
 
-static void ath12k_dp_mon_parse_l_sig_b(u8 *tlv_data,
+static void ath12k_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
 					struct hal_rx_mon_ppdu_info *ppdu_info)
 {
-	struct hal_rx_lsig_b_info *lsigb =
-			(struct hal_rx_lsig_b_info *)tlv_data;
 	u32 info0 = __le32_to_cpu(lsigb->info0);
 	u8 rate;
 
@@ -170,11 +163,9 @@ static void ath12k_dp_mon_parse_l_sig_b(u8 *tlv_data,
 	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
 }
 
-static void ath12k_dp_mon_parse_l_sig_a(u8 *tlv_data,
+static void ath12k_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
 					struct hal_rx_mon_ppdu_info *ppdu_info)
 {
-	struct hal_rx_lsig_a_info *lsiga =
-			(struct hal_rx_lsig_a_info *)tlv_data;
 	u32 info0 = __le32_to_cpu(lsiga->info0);
 	u8 rate;
 
@@ -212,14 +203,13 @@ static void ath12k_dp_mon_parse_l_sig_a(u8 *tlv_data,
 	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
 }
 
-static void ath12k_dp_mon_parse_he_sig_b2_ofdma(u8 *tlv_data,
-						struct hal_rx_mon_ppdu_info *ppdu_info)
+static void
+ath12k_dp_mon_parse_he_sig_b2_ofdma(const struct hal_rx_he_sig_b2_ofdma_info *ofdma,
+				    struct hal_rx_mon_ppdu_info *ppdu_info)
 {
-	struct hal_rx_he_sig_b2_ofdma_info *he_sig_b2_ofdma =
-			(struct hal_rx_he_sig_b2_ofdma_info *)tlv_data;
 	u32 info0, value;
 
-	info0 = __le32_to_cpu(he_sig_b2_ofdma->info0);
+	info0 = __le32_to_cpu(ofdma->info0);
 
 	ppdu_info->he_data1 |= HE_MCS_KNOWN | HE_DCM_KNOWN | HE_CODING_KNOWN;
 
@@ -250,11 +240,10 @@ static void ath12k_dp_mon_parse_he_sig_b2_ofdma(u8 *tlv_data,
 	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_OFDMA;
 }
 
-static void ath12k_dp_mon_parse_he_sig_b2_mu(u8 *tlv_data,
-					     struct hal_rx_mon_ppdu_info *ppdu_info)
+static void
+ath12k_dp_mon_parse_he_sig_b2_mu(const struct hal_rx_he_sig_b2_mu_info *he_sig_b2_mu,
+				 struct hal_rx_mon_ppdu_info *ppdu_info)
 {
-	struct hal_rx_he_sig_b2_mu_info *he_sig_b2_mu =
-			(struct hal_rx_he_sig_b2_mu_info *)tlv_data;
 	u32 info0, value;
 
 	info0 = __le32_to_cpu(he_sig_b2_mu->info0);
@@ -277,11 +266,10 @@ static void ath12k_dp_mon_parse_he_sig_b2_mu(u8 *tlv_data,
 	ppdu_info->nss = u32_get_bits(info0, HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_NSTS);
 }
 
-static void ath12k_dp_mon_parse_he_sig_b1_mu(u8 *tlv_data,
-					     struct hal_rx_mon_ppdu_info *ppdu_info)
+static void
+ath12k_dp_mon_parse_he_sig_b1_mu(const struct hal_rx_he_sig_b1_mu_info *he_sig_b1_mu,
+				 struct hal_rx_mon_ppdu_info *ppdu_info)
 {
-	struct hal_rx_he_sig_b1_mu_info *he_sig_b1_mu =
-			(struct hal_rx_he_sig_b1_mu_info *)tlv_data;
 	u32 info0 = __le32_to_cpu(he_sig_b1_mu->info0);
 	u16 ru_tones;
 
@@ -292,11 +280,10 @@ static void ath12k_dp_mon_parse_he_sig_b1_mu(u8 *tlv_data,
 	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
 }
 
-static void ath12k_dp_mon_parse_he_sig_mu(u8 *tlv_data,
-					  struct hal_rx_mon_ppdu_info *ppdu_info)
+static void
+ath12k_dp_mon_parse_he_sig_mu(const struct hal_rx_he_sig_a_mu_dl_info *he_sig_a_mu_dl,
+			      struct hal_rx_mon_ppdu_info *ppdu_info)
 {
-	struct hal_rx_he_sig_a_mu_dl_info *he_sig_a_mu_dl =
-			(struct hal_rx_he_sig_a_mu_dl_info *)tlv_data;
 	u32 info0, info1, value;
 	u16 he_gi = 0, he_ltf = 0;
 
@@ -427,11 +414,9 @@ static void ath12k_dp_mon_parse_he_sig_mu(u8 *tlv_data,
 	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
 }
 
-static void ath12k_dp_mon_parse_he_sig_su(u8 *tlv_data,
+static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *he_sig_a,
 					  struct hal_rx_mon_ppdu_info *ppdu_info)
 {
-	struct hal_rx_he_sig_a_su_info *he_sig_a =
-			(struct hal_rx_he_sig_a_su_info *)tlv_data;
 	u32 info0, info1, value;
 	u32 dcm;
 	u8 he_dcm = 0, he_stbc = 0;
@@ -580,15 +565,15 @@ static void ath12k_dp_mon_parse_he_sig_su(u8 *tlv_data,
 static enum hal_rx_mon_status
 ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 				  struct ath12k_mon_data *pmon,
-				  u32 tlv_tag, u8 *tlv_data, u32 userid)
+				  u32 tlv_tag, const void *tlv_data,
+				  u32 userid)
 {
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
 	u32 info[7];
 
 	switch (tlv_tag) {
 	case HAL_RX_PPDU_START: {
-		struct hal_rx_ppdu_start *ppdu_start =
-			(struct hal_rx_ppdu_start *)tlv_data;
+		const struct hal_rx_ppdu_start *ppdu_start = tlv_data;
 
 		u64 ppdu_ts = ath12k_le32hilo_to_u64(ppdu_start->ppdu_start_ts_63_32,
 						     ppdu_start->ppdu_start_ts_31_0);
@@ -615,8 +600,7 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		break;
 	}
 	case HAL_RX_PPDU_END_USER_STATS: {
-		struct hal_rx_ppdu_end_user_stats *eu_stats =
-			(struct hal_rx_ppdu_end_user_stats *)tlv_data;
+		const struct hal_rx_ppdu_end_user_stats *eu_stats = tlv_data;
 		u32 tid_bitmap;
 
 		info[0] = __le32_to_cpu(eu_stats->info0);
@@ -673,8 +657,8 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 				&ppdu_info->userstats[userid];
 			ppdu_info->num_users += 1;
 
-			ath12k_dp_mon_rx_handle_ofdma_info(tlv_data, rxuser_stats);
-			ath12k_dp_mon_rx_populate_mu_user_info(tlv_data, ppdu_info,
+			ath12k_dp_mon_rx_handle_ofdma_info(eu_stats, rxuser_stats);
+			ath12k_dp_mon_rx_populate_mu_user_info(eu_stats, ppdu_info,
 							       rxuser_stats);
 		}
 		ppdu_info->mpdu_fcs_ok_bitmap[0] = __le32_to_cpu(eu_stats->rsvd1[0]);
@@ -682,8 +666,8 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		break;
 	}
 	case HAL_RX_PPDU_END_USER_STATS_EXT: {
-		struct hal_rx_ppdu_end_user_stats_ext *eu_stats =
-			(struct hal_rx_ppdu_end_user_stats_ext *)tlv_data;
+		const struct hal_rx_ppdu_end_user_stats_ext *eu_stats = tlv_data;
+
 		ppdu_info->mpdu_fcs_ok_bitmap[2] = __le32_to_cpu(eu_stats->info1);
 		ppdu_info->mpdu_fcs_ok_bitmap[3] = __le32_to_cpu(eu_stats->info2);
 		ppdu_info->mpdu_fcs_ok_bitmap[4] = __le32_to_cpu(eu_stats->info3);
@@ -729,8 +713,7 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		break;
 
 	case HAL_PHYRX_RSSI_LEGACY: {
-		struct hal_rx_phyrx_rssi_legacy_info *rssi =
-			(struct hal_rx_phyrx_rssi_legacy_info *)tlv_data;
+		const struct hal_rx_phyrx_rssi_legacy_info *rssi = tlv_data;
 
 		info[0] = __le32_to_cpu(rssi->info0);
 		info[1] = __le32_to_cpu(rssi->info1);
@@ -748,8 +731,7 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		break;
 	}
 	case HAL_RXPCU_PPDU_END_INFO: {
-		struct hal_rx_ppdu_end_duration *ppdu_rx_duration =
-			(struct hal_rx_ppdu_end_duration *)tlv_data;
+		const struct hal_rx_ppdu_end_duration *ppdu_rx_duration = tlv_data;
 
 		info[0] = __le32_to_cpu(ppdu_rx_duration->info0);
 		ppdu_info->rx_duration =
@@ -760,8 +742,7 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		break;
 	}
 	case HAL_RX_MPDU_START: {
-		struct hal_rx_mpdu_start *mpdu_start =
-			(struct hal_rx_mpdu_start *)tlv_data;
+		const struct hal_rx_mpdu_start *mpdu_start = tlv_data;
 		struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
 		u16 peer_id;
 
@@ -790,8 +771,7 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		break;
 	case HAL_MON_BUF_ADDR: {
 		struct dp_rxdma_mon_ring *buf_ring = &ab->dp.rxdma_mon_buf_ring;
-		struct dp_mon_packet_info *packet_info =
-			(struct dp_mon_packet_info *)tlv_data;
+		const struct dp_mon_packet_info *packet_info = tlv_data;
 		int buf_id = u32_get_bits(packet_info->cookie,
 					  DP_RXDMA_BUF_COOKIE_BUF_ID);
 		struct sk_buff *msdu;
@@ -823,8 +803,7 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		break;
 	}
 	case HAL_RX_MSDU_END: {
-		struct rx_msdu_end_qcn9274 *msdu_end =
-			(struct rx_msdu_end_qcn9274 *)tlv_data;
+		const struct rx_msdu_end_qcn9274 *msdu_end = tlv_data;
 		bool is_first_msdu_in_mpdu;
 		u16 msdu_end_info;
 
@@ -1603,7 +1582,7 @@ ath12k_dp_mon_tx_gen_prot_frame(struct dp_mon_tx_ppdu_info *tx_ppdu_info)
 static enum dp_mon_tx_tlv_status
 ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 				  struct ath12k_mon_data *pmon,
-				  u16 tlv_tag, u8 *tlv_data, u32 userid)
+				  u16 tlv_tag, const void *tlv_data, u32 userid)
 {
 	struct dp_mon_tx_ppdu_info *tx_ppdu_info;
 	enum dp_mon_tx_tlv_status status = DP_MON_TX_STATUS_PPDU_NOT_DONE;
@@ -1613,8 +1592,7 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 
 	switch (tlv_tag) {
 	case HAL_TX_FES_SETUP: {
-		struct hal_tx_fes_setup *tx_fes_setup =
-					(struct hal_tx_fes_setup *)tlv_data;
+		const struct hal_tx_fes_setup *tx_fes_setup = tlv_data;
 
 		info[0] = __le32_to_cpu(tx_fes_setup->info0);
 		tx_ppdu_info->ppdu_id = __le32_to_cpu(tx_fes_setup->schedule_id);
@@ -1625,8 +1603,7 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 	}
 
 	case HAL_TX_FES_STATUS_END: {
-		struct hal_tx_fes_status_end *tx_fes_status_end =
-			(struct hal_tx_fes_status_end *)tlv_data;
+		const struct hal_tx_fes_status_end *tx_fes_status_end = tlv_data;
 		u32 tst_15_0, tst_31_16;
 
 		info[0] = __le32_to_cpu(tx_fes_status_end->info0);
@@ -1643,8 +1620,7 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 	}
 
 	case HAL_RX_RESPONSE_REQUIRED_INFO: {
-		struct hal_rx_resp_req_info *rx_resp_req_info =
-			(struct hal_rx_resp_req_info *)tlv_data;
+		const struct hal_rx_resp_req_info *rx_resp_req_info = tlv_data;
 		u32 addr_32;
 		u16 addr_16;
 
@@ -1689,8 +1665,7 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 	}
 
 	case HAL_PCU_PPDU_SETUP_INIT: {
-		struct hal_tx_pcu_ppdu_setup_init *ppdu_setup =
-			(struct hal_tx_pcu_ppdu_setup_init *)tlv_data;
+		const struct hal_tx_pcu_ppdu_setup_init *ppdu_setup = tlv_data;
 		u32 addr_32;
 		u16 addr_16;
 
@@ -1736,8 +1711,7 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 	}
 
 	case HAL_TX_QUEUE_EXTENSION: {
-		struct hal_tx_queue_exten *tx_q_exten =
-			(struct hal_tx_queue_exten *)tlv_data;
+		const struct hal_tx_queue_exten *tx_q_exten = tlv_data;
 
 		info[0] = __le32_to_cpu(tx_q_exten->info0);
 
@@ -1749,8 +1723,7 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 	}
 
 	case HAL_TX_FES_STATUS_START: {
-		struct hal_tx_fes_status_start *tx_fes_start =
-			(struct hal_tx_fes_status_start *)tlv_data;
+		const struct hal_tx_fes_status_start *tx_fes_start = tlv_data;
 
 		info[0] = __le32_to_cpu(tx_fes_start->info0);
 
@@ -1761,8 +1734,7 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 	}
 
 	case HAL_TX_FES_STATUS_PROT: {
-		struct hal_tx_fes_status_prot *tx_fes_status =
-			(struct hal_tx_fes_status_prot *)tlv_data;
+		const struct hal_tx_fes_status_prot *tx_fes_status = tlv_data;
 		u32 start_timestamp;
 		u32 end_timestamp;
 
@@ -1789,8 +1761,7 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 
 	case HAL_TX_FES_STATUS_START_PPDU:
 	case HAL_TX_FES_STATUS_START_PROT: {
-		struct hal_tx_fes_status_start_prot *tx_fes_stat_start =
-			(struct hal_tx_fes_status_start_prot *)tlv_data;
+		const struct hal_tx_fes_status_start_prot *tx_fes_stat_start = tlv_data;
 		u64 ppdu_ts;
 
 		info[0] = __le32_to_cpu(tx_fes_stat_start->info0);
@@ -1805,8 +1776,7 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 	}
 
 	case HAL_TX_FES_STATUS_USER_PPDU: {
-		struct hal_tx_fes_status_user_ppdu *tx_fes_usr_ppdu =
-			(struct hal_tx_fes_status_user_ppdu *)tlv_data;
+		const struct hal_tx_fes_status_user_ppdu *tx_fes_usr_ppdu = tlv_data;
 
 		info[0] = __le32_to_cpu(tx_fes_usr_ppdu->info0);
 
@@ -1849,8 +1819,7 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 		break;
 
 	case HAL_RX_FRAME_BITMAP_ACK: {
-		struct hal_rx_frame_bitmap_ack *fbm_ack =
-			(struct hal_rx_frame_bitmap_ack *)tlv_data;
+		const struct hal_rx_frame_bitmap_ack *fbm_ack = tlv_data;
 		u32 addr_32;
 		u16 addr_16;
 
@@ -1868,8 +1837,7 @@ ath12k_dp_mon_tx_parse_status_tlv(struct ath12k_base *ab,
 	}
 
 	case HAL_MACTX_PHY_DESC: {
-		struct hal_tx_phy_desc *tx_phy_desc =
-			(struct hal_tx_phy_desc *)tlv_data;
+		const struct hal_tx_phy_desc *tx_phy_desc = tlv_data;
 
 		info[0] = __le32_to_cpu(tx_phy_desc->info0);
 		info[1] = __le32_to_cpu(tx_phy_desc->info1);
-- 
2.34.1


