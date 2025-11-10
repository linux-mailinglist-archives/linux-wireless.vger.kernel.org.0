Return-Path: <linux-wireless+bounces-28743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 452BAC45F81
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFC4F4E807C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24663081C2;
	Mon, 10 Nov 2025 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g7fB7NUd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DBC3074B1
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771052; cv=none; b=U2RFHu0R69QFdDkrbuGrSnis+PYtHMPbAGOxgbgr3gPYaDqJhtqsFQhovfBzn/QP9KUju/I6C+3xGZEOyT66NvyeBYNQw4++i8MYoJd0blZ8NGxtjmlQ00xKKOXu6RMtORKYNUdXqWHUTNRcYTigWzikMs1ctOXXxgrSF/dCuDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771052; c=relaxed/simple;
	bh=1KBMQCgxXliEcSN57/tZqDf6l0WKCAOi0HY42dG8NZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmdCr/wJxkfcD7ukkGu7IRI71262DcCM6oewQckSZsP44MdRb7jo0Z1vXMm4GyXvaJQQO6+0zboyJ9uUSa4/lwMMqCE/ZGUrcj/3ouV5RVwgSCKjor4ZxmnjiAWuakOsw0L94i5pSOaf/KTkWEPqV0dqqd83oAhZ2ooN1nouJ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g7fB7NUd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9Bsb92867961;
	Mon, 10 Nov 2025 10:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=J4S/Se+4hqn
	C/hKqLH3oRmJ5M/DhA1rGsEuZB++x6p4=; b=g7fB7NUd6zhLpo8nYgthf5Uh6zq
	EcUvxWrZ4XaC37+UNii42QWmBxJ9Loj3II0uVBEZZo8z3q7aa+ZZ4fnEVm8nrDpP
	ZHh+UqS9+5dVPjgW2PVak3h+HfJEp/toLC6xFRFgn+QbZju/usCiHs755e0dXH4h
	yvJcUPpK+AzjjPkSX0o7yOix4PSEqXgv6dbYQA6HbLi2xMdoqFmUKT5gt+8cN4Ry
	MAYo9C/IHaUP40A7J5qpta03JIOonzylyQWUp2NNeubu65IqqAPuDy6019kqmAmJ
	gMSC1cyDxWM8XKlOeZzqh8CUsxqd43BLwO0sBqlcdb3X5XVjMY2sRQAtJow==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd760a22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:22 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAbIFL008144;
	Mon, 10 Nov 2025 10:37:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxkq1ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:19 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AAAbH8U008045;
	Mon, 10 Nov 2025 10:37:18 GMT
Received: from hu-devc-blr-u22-c.qualcomm.com (hu-aloksing-blr.qualcomm.com [10.190.111.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AAAbIgo008094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:18 +0000
Received: by hu-devc-blr-u22-c.qualcomm.com (Postfix, from userid 2272527)
	id 9E9F8B74; Mon, 10 Nov 2025 16:07:16 +0530 (+0530)
From: Alok Singh <quic_aloksing@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Alok Singh <quic_aloksing@quicinc.com>
Subject: [PATCH ath12k-ng 10/12] wifi: ath12k: Move MU user processing to Wi-Fi 7 module
Date: Mon, 10 Nov 2025 16:07:11 +0530
Message-Id: <20251110103713.3484779-11-quic_aloksing@quicinc.com>
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
X-Proofpoint-ORIG-GUID: fVgU7Op4_7CTDQ7ZlkuULx9Rmslu0R0E
X-Authority-Analysis: v=2.4 cv=OK4qHCaB c=1 sm=1 tr=0 ts=6911c062 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=rZv5k5h2vg1mbdN_0e8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MiBTYWx0ZWRfXxwIq8itJrhF5
 vm6Hs9OvRy4wn3sATUYvsOrMg2qMqoGFcgntN/DXbp8VpgVsmE91ijjryR1ZvoN2cHKTnLNosZ2
 qLMPzl/EM9JTBECLOsbeSSYcNK8eFaxPP1bkv5HJGOBBRNViZQEkxOlyVMs+MEhXD1KbMHZDI+0
 99+sYAyAuOi0nmx1qZrQxHzAvQCFXaAGAmXEVvzew4wMfwLWQc7HpjQBQZdW1sjT1omCNFsYhYC
 Wh9iJAy2TMvn7VIIE8R6bgEvzAuQiAMdx8uPfhHfN+/AFUtiW5aHtSKQI+CRboNym6uIRKpH63l
 ZzkYAeKlZibbR6jXuMJgLEOLJ8WWoi+WHzesnYdKw7TFf/ZVHZR+NW18pzfOYogOhLheu72vtkg
 zUTcVy21Ozy6EX9QuSLjvw3Eciv7nw==
X-Proofpoint-GUID: fVgU7Op4_7CTDQ7ZlkuULx9Rmslu0R0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100092

Move Wi-Fi 7-specific monitor functionality out of ath12k common code
into the Wi-Fi 7 module to improve modularity.

Move and rename the following MU user processing functions to
wifi7/dp_mon.c with the ath12k_wifi7_ prefix:
- ath12k_dp_mon_rx_handle_ofdma_info()
- ath12k_dp_mon_rx_populate_mu_user_info()
- ath12k_dp_mon_hal_rx_parse_user_info()

Move the helper functions hal_rx_mon_hal_ru_size_to_ath12k_ru_size and
hal_rx_ul_ofdma_ru_size_to_width to the Wi-Fi 7 module, and export the
helpers required by the ath12k_wifi7 code. Isolate the parsing of
MU-specific user information within the Wi-Fi 7 module to keep
common code generic.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Alok Singh <quic_aloksing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 351 -----------------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |  11 -
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 356 +++++++++++++++++-
 3 files changed, 352 insertions(+), 366 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 9b04a9505ea0..db67d81d557f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -11,357 +11,6 @@
 #include "dp_tx.h"
 #include "peer.h"
 
-void
-ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
-				   struct hal_rx_user_status *rx_user_status)
-{
-	rx_user_status->ul_ofdma_user_v0_word0 =
-		__le32_to_cpu(ppdu_end_user->usr_resp_ref);
-	rx_user_status->ul_ofdma_user_v0_word1 =
-		__le32_to_cpu(ppdu_end_user->usr_resp_ref_ext);
-}
-EXPORT_SYMBOL(ath12k_dp_mon_rx_handle_ofdma_info);
-
-static void
-ath12k_dp_mon_rx_populate_byte_count(const struct hal_rx_ppdu_end_user_stats *stats,
-				     void *ppduinfo,
-				     struct hal_rx_user_status *rx_user_status)
-{
-	rx_user_status->mpdu_ok_byte_count =
-		le32_get_bits(stats->info7,
-			      HAL_RX_PPDU_END_USER_STATS_INFO7_MPDU_OK_BYTE_COUNT);
-	rx_user_status->mpdu_err_byte_count =
-		le32_get_bits(stats->info8,
-			      HAL_RX_PPDU_END_USER_STATS_INFO8_MPDU_ERR_BYTE_COUNT);
-}
-
-void
-ath12k_dp_mon_rx_populate_mu_user_info(const struct hal_rx_ppdu_end_user_stats *rx_tlv,
-				       struct hal_rx_mon_ppdu_info *ppdu_info,
-				       struct hal_rx_user_status *rx_user_status)
-{
-	rx_user_status->ast_index = ppdu_info->ast_index;
-	rx_user_status->tid = ppdu_info->tid;
-	rx_user_status->tcp_ack_msdu_count =
-		ppdu_info->tcp_ack_msdu_count;
-	rx_user_status->tcp_msdu_count =
-		ppdu_info->tcp_msdu_count;
-	rx_user_status->udp_msdu_count =
-		ppdu_info->udp_msdu_count;
-	rx_user_status->other_msdu_count =
-		ppdu_info->other_msdu_count;
-	rx_user_status->frame_control = ppdu_info->frame_control;
-	rx_user_status->frame_control_info_valid =
-		ppdu_info->frame_control_info_valid;
-	rx_user_status->data_sequence_control_info_valid =
-		ppdu_info->data_sequence_control_info_valid;
-	rx_user_status->first_data_seq_ctrl =
-		ppdu_info->first_data_seq_ctrl;
-	rx_user_status->preamble_type = ppdu_info->preamble_type;
-	rx_user_status->ht_flags = ppdu_info->ht_flags;
-	rx_user_status->vht_flags = ppdu_info->vht_flags;
-	rx_user_status->he_flags = ppdu_info->he_flags;
-	rx_user_status->rs_flags = ppdu_info->rs_flags;
-
-	rx_user_status->mpdu_cnt_fcs_ok =
-		ppdu_info->num_mpdu_fcs_ok;
-	rx_user_status->mpdu_cnt_fcs_err =
-		ppdu_info->num_mpdu_fcs_err;
-	memcpy(&rx_user_status->mpdu_fcs_ok_bitmap[0], &ppdu_info->mpdu_fcs_ok_bitmap[0],
-	       HAL_RX_NUM_WORDS_PER_PPDU_BITMAP *
-	       sizeof(ppdu_info->mpdu_fcs_ok_bitmap[0]));
-
-	ath12k_dp_mon_rx_populate_byte_count(rx_tlv, ppdu_info, rx_user_status);
-}
-EXPORT_SYMBOL(ath12k_dp_mon_rx_populate_mu_user_info);
-
-static inline enum ath12k_eht_ru_size
-hal_rx_mon_hal_ru_size_to_ath12k_ru_size(u32 hal_ru_size)
-{
-	switch (hal_ru_size) {
-	case HAL_EHT_RU_26:
-		return ATH12K_EHT_RU_26;
-	case HAL_EHT_RU_52:
-		return ATH12K_EHT_RU_52;
-	case HAL_EHT_RU_78:
-		return ATH12K_EHT_RU_52_26;
-	case HAL_EHT_RU_106:
-		return ATH12K_EHT_RU_106;
-	case HAL_EHT_RU_132:
-		return ATH12K_EHT_RU_106_26;
-	case HAL_EHT_RU_242:
-		return ATH12K_EHT_RU_242;
-	case HAL_EHT_RU_484:
-		return ATH12K_EHT_RU_484;
-	case HAL_EHT_RU_726:
-		return ATH12K_EHT_RU_484_242;
-	case HAL_EHT_RU_996:
-		return ATH12K_EHT_RU_996;
-	case HAL_EHT_RU_996x2:
-		return ATH12K_EHT_RU_996x2;
-	case HAL_EHT_RU_996x3:
-		return ATH12K_EHT_RU_996x3;
-	case HAL_EHT_RU_996x4:
-		return ATH12K_EHT_RU_996x4;
-	case HAL_EHT_RU_NONE:
-		return ATH12K_EHT_RU_INVALID;
-	case HAL_EHT_RU_996_484:
-		return ATH12K_EHT_RU_996_484;
-	case HAL_EHT_RU_996x2_484:
-		return ATH12K_EHT_RU_996x2_484;
-	case HAL_EHT_RU_996x3_484:
-		return ATH12K_EHT_RU_996x3_484;
-	case HAL_EHT_RU_996_484_242:
-		return ATH12K_EHT_RU_996_484_242;
-	default:
-		return ATH12K_EHT_RU_INVALID;
-	}
-}
-
-static inline u32
-hal_rx_ul_ofdma_ru_size_to_width(enum ath12k_eht_ru_size ru_size)
-{
-	switch (ru_size) {
-	case ATH12K_EHT_RU_26:
-		return RU_26;
-	case ATH12K_EHT_RU_52:
-		return RU_52;
-	case ATH12K_EHT_RU_52_26:
-		return RU_52_26;
-	case ATH12K_EHT_RU_106:
-		return RU_106;
-	case ATH12K_EHT_RU_106_26:
-		return RU_106_26;
-	case ATH12K_EHT_RU_242:
-		return RU_242;
-	case ATH12K_EHT_RU_484:
-		return RU_484;
-	case ATH12K_EHT_RU_484_242:
-		return RU_484_242;
-	case ATH12K_EHT_RU_996:
-		return RU_996;
-	case ATH12K_EHT_RU_996_484:
-		return RU_996_484;
-	case ATH12K_EHT_RU_996_484_242:
-		return RU_996_484_242;
-	case ATH12K_EHT_RU_996x2:
-		return RU_2X996;
-	case ATH12K_EHT_RU_996x2_484:
-		return RU_2X996_484;
-	case ATH12K_EHT_RU_996x3:
-		return RU_3X996;
-	case ATH12K_EHT_RU_996x3_484:
-		return RU_3X996_484;
-	case ATH12K_EHT_RU_996x4:
-		return RU_4X996;
-	default:
-		return RU_INVALID;
-	}
-}
-
-void
-ath12k_dp_mon_hal_rx_parse_user_info(const struct hal_receive_user_info *rx_usr_info,
-				     u16 user_id,
-				     struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	struct hal_rx_user_status *mon_rx_user_status = NULL;
-	struct hal_rx_radiotap_eht *eht = &ppdu_info->eht_info.eht;
-	enum ath12k_eht_ru_size rtap_ru_size = ATH12K_EHT_RU_INVALID;
-	u32 ru_width, reception_type, ru_index = HAL_EHT_RU_INVALID;
-	u32 ru_type_80_0, ru_start_index_80_0;
-	u32 ru_type_80_1, ru_start_index_80_1;
-	u32 ru_type_80_2, ru_start_index_80_2;
-	u32 ru_type_80_3, ru_start_index_80_3;
-	u32 ru_size = 0, num_80mhz_with_ru = 0;
-	u64 ru_index_320mhz = 0;
-	u32 ru_index_per80mhz;
-
-	reception_type = le32_get_bits(rx_usr_info->info0,
-				       HAL_RX_USR_INFO0_RECEPTION_TYPE);
-
-	switch (reception_type) {
-	case HAL_RECEPTION_TYPE_SU:
-		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
-		break;
-	case HAL_RECEPTION_TYPE_DL_MU_MIMO:
-	case HAL_RECEPTION_TYPE_UL_MU_MIMO:
-		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
-		break;
-	case HAL_RECEPTION_TYPE_DL_MU_OFMA:
-	case HAL_RECEPTION_TYPE_UL_MU_OFDMA:
-		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_OFDMA;
-		break;
-	case HAL_RECEPTION_TYPE_DL_MU_OFDMA_MIMO:
-	case HAL_RECEPTION_TYPE_UL_MU_OFDMA_MIMO:
-		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_OFDMA_MIMO;
-	}
-
-	ppdu_info->is_stbc = le32_get_bits(rx_usr_info->info0, HAL_RX_USR_INFO0_STBC);
-	ppdu_info->ldpc = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_LDPC);
-	ppdu_info->dcm = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_STA_DCM);
-	ppdu_info->bw = le32_get_bits(rx_usr_info->info1, HAL_RX_USR_INFO1_RX_BW);
-	ppdu_info->mcs = le32_get_bits(rx_usr_info->info1, HAL_RX_USR_INFO1_MCS);
-	ppdu_info->nss = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_NSS) + 1;
-
-	if (user_id < HAL_MAX_UL_MU_USERS) {
-		mon_rx_user_status = &ppdu_info->userstats[user_id];
-		mon_rx_user_status->mcs = ppdu_info->mcs;
-		mon_rx_user_status->nss = ppdu_info->nss;
-	}
-
-	if (!(ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_MU_MIMO ||
-	      ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_MU_OFDMA ||
-	      ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_MU_OFDMA_MIMO))
-		return;
-
-	/* RU allocation present only for OFDMA reception */
-	ru_type_80_0 = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_RU_TYPE_80_0);
-	ru_start_index_80_0 = le32_get_bits(rx_usr_info->info3,
-					    HAL_RX_USR_INFO3_RU_START_IDX_80_0);
-	if (ru_type_80_0 != HAL_EHT_RU_NONE) {
-		ru_size += ru_type_80_0;
-		ru_index_per80mhz = ru_start_index_80_0;
-		ru_index = ru_index_per80mhz;
-		ru_index_320mhz |= HAL_RU_PER80(ru_type_80_0, 0, ru_index_per80mhz);
-		num_80mhz_with_ru++;
-	}
-
-	ru_type_80_1 = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_RU_TYPE_80_1);
-	ru_start_index_80_1 = le32_get_bits(rx_usr_info->info3,
-					    HAL_RX_USR_INFO3_RU_START_IDX_80_1);
-	if (ru_type_80_1 != HAL_EHT_RU_NONE) {
-		ru_size += ru_type_80_1;
-		ru_index_per80mhz = ru_start_index_80_1;
-		ru_index = ru_index_per80mhz;
-		ru_index_320mhz |= HAL_RU_PER80(ru_type_80_1, 1, ru_index_per80mhz);
-		num_80mhz_with_ru++;
-	}
-
-	ru_type_80_2 = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_RU_TYPE_80_2);
-	ru_start_index_80_2 = le32_get_bits(rx_usr_info->info3,
-					    HAL_RX_USR_INFO3_RU_START_IDX_80_2);
-	if (ru_type_80_2 != HAL_EHT_RU_NONE) {
-		ru_size += ru_type_80_2;
-		ru_index_per80mhz = ru_start_index_80_2;
-		ru_index = ru_index_per80mhz;
-		ru_index_320mhz |= HAL_RU_PER80(ru_type_80_2, 2, ru_index_per80mhz);
-		num_80mhz_with_ru++;
-	}
-
-	ru_type_80_3 = le32_get_bits(rx_usr_info->info2, HAL_RX_USR_INFO2_RU_TYPE_80_3);
-	ru_start_index_80_3 = le32_get_bits(rx_usr_info->info2,
-					    HAL_RX_USR_INFO3_RU_START_IDX_80_3);
-	if (ru_type_80_3 != HAL_EHT_RU_NONE) {
-		ru_size += ru_type_80_3;
-		ru_index_per80mhz = ru_start_index_80_3;
-		ru_index = ru_index_per80mhz;
-		ru_index_320mhz |= HAL_RU_PER80(ru_type_80_3, 3, ru_index_per80mhz);
-		num_80mhz_with_ru++;
-	}
-
-	if (num_80mhz_with_ru > 1) {
-		/* Calculate the MRU index */
-		switch (ru_index_320mhz) {
-		case HAL_EHT_RU_996_484_0:
-		case HAL_EHT_RU_996x2_484_0:
-		case HAL_EHT_RU_996x3_484_0:
-			ru_index = 0;
-			break;
-		case HAL_EHT_RU_996_484_1:
-		case HAL_EHT_RU_996x2_484_1:
-		case HAL_EHT_RU_996x3_484_1:
-			ru_index = 1;
-			break;
-		case HAL_EHT_RU_996_484_2:
-		case HAL_EHT_RU_996x2_484_2:
-		case HAL_EHT_RU_996x3_484_2:
-			ru_index = 2;
-			break;
-		case HAL_EHT_RU_996_484_3:
-		case HAL_EHT_RU_996x2_484_3:
-		case HAL_EHT_RU_996x3_484_3:
-			ru_index = 3;
-			break;
-		case HAL_EHT_RU_996_484_4:
-		case HAL_EHT_RU_996x2_484_4:
-		case HAL_EHT_RU_996x3_484_4:
-			ru_index = 4;
-			break;
-		case HAL_EHT_RU_996_484_5:
-		case HAL_EHT_RU_996x2_484_5:
-		case HAL_EHT_RU_996x3_484_5:
-			ru_index = 5;
-			break;
-		case HAL_EHT_RU_996_484_6:
-		case HAL_EHT_RU_996x2_484_6:
-		case HAL_EHT_RU_996x3_484_6:
-			ru_index = 6;
-			break;
-		case HAL_EHT_RU_996_484_7:
-		case HAL_EHT_RU_996x2_484_7:
-		case HAL_EHT_RU_996x3_484_7:
-			ru_index = 7;
-			break;
-		case HAL_EHT_RU_996x2_484_8:
-			ru_index = 8;
-			break;
-		case HAL_EHT_RU_996x2_484_9:
-			ru_index = 9;
-			break;
-		case HAL_EHT_RU_996x2_484_10:
-			ru_index = 10;
-			break;
-		case HAL_EHT_RU_996x2_484_11:
-			ru_index = 11;
-			break;
-		default:
-			ru_index = HAL_EHT_RU_INVALID;
-			break;
-		}
-
-		ru_size += 4;
-	}
-
-	rtap_ru_size = hal_rx_mon_hal_ru_size_to_ath12k_ru_size(ru_size);
-	if (rtap_ru_size != ATH12K_EHT_RU_INVALID) {
-		u32 known, data;
-
-		known = __le32_to_cpu(eht->known);
-		known |= IEEE80211_RADIOTAP_EHT_KNOWN_RU_MRU_SIZE_OM;
-		eht->known = cpu_to_le32(known);
-
-		data = __le32_to_cpu(eht->data[1]);
-		data |=	u32_encode_bits(rtap_ru_size,
-					IEEE80211_RADIOTAP_EHT_DATA1_RU_SIZE);
-		eht->data[1] = cpu_to_le32(data);
-	}
-
-	if (ru_index != HAL_EHT_RU_INVALID) {
-		u32 known, data;
-
-		known = __le32_to_cpu(eht->known);
-		known |= IEEE80211_RADIOTAP_EHT_KNOWN_RU_MRU_INDEX_OM;
-		eht->known = cpu_to_le32(known);
-
-		data = __le32_to_cpu(eht->data[1]);
-		data |=	u32_encode_bits(rtap_ru_size,
-					IEEE80211_RADIOTAP_EHT_DATA1_RU_INDEX);
-		eht->data[1] = cpu_to_le32(data);
-	}
-
-	if (mon_rx_user_status && ru_index != HAL_EHT_RU_INVALID &&
-	    rtap_ru_size != ATH12K_EHT_RU_INVALID) {
-		mon_rx_user_status->ul_ofdma_ru_start_index = ru_index;
-		mon_rx_user_status->ul_ofdma_ru_size = rtap_ru_size;
-
-		ru_width = hal_rx_ul_ofdma_ru_size_to_width(rtap_ru_size);
-
-		mon_rx_user_status->ul_ofdma_ru_width = ru_width;
-		mon_rx_user_status->ofdma_info_valid = 1;
-	}
-}
-EXPORT_SYMBOL(ath12k_dp_mon_hal_rx_parse_user_info);
-
 static void ath12k_dp_mon_parse_rx_msdu_end_err(u32 info, u32 *errmap)
 {
 	if (info & RX_MSDU_END_INFO13_FCS_ERR)
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index 063d57512db7..6dac4e9569b6 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -120,17 +120,6 @@ ath12k_dp_mon_parse_status_buf(struct ath12k_pdev_dp *dp_pdev,
 			       struct ath12k_mon_data *pmon,
 			       const struct dp_mon_packet_info *packet_info);
 void
-ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
-				   struct hal_rx_user_status *rx_user_status);
-void
-ath12k_dp_mon_rx_populate_mu_user_info(const struct hal_rx_ppdu_end_user_stats *rx_tlv,
-				       struct hal_rx_mon_ppdu_info *ppdu_info,
-				       struct hal_rx_user_status *rx_user_status);
-void
-ath12k_dp_mon_hal_rx_parse_user_info(const struct hal_receive_user_info *rx_usr_info,
-				     u16 user_id,
-				     struct hal_rx_mon_ppdu_info *ppdu_info);
-void
 ath12k_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
 				    const struct hal_rx_msdu_end *msdu_end);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
index 2d67fd553776..8d913d09f882 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -31,6 +31,354 @@ ath12k_wifi7_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info)
 	ppdu_info->peer_id = HAL_INVALID_PEERID;
 }
 
+static void
+ath12k_wifi7_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
+					 struct hal_rx_user_status *rx_user_status)
+{
+	rx_user_status->ul_ofdma_user_v0_word0 =
+		__le32_to_cpu(ppdu_end_user->usr_resp_ref);
+	rx_user_status->ul_ofdma_user_v0_word1 =
+		__le32_to_cpu(ppdu_end_user->usr_resp_ref_ext);
+}
+
+static void
+ath12k_wifi7_dp_mon_rx_populate_byte_count(const struct hal_rx_ppdu_end_user_stats *stats,
+					   void *ppduinfo,
+					   struct hal_rx_user_status *rx_user_status)
+{
+	rx_user_status->mpdu_ok_byte_count =
+		le32_get_bits(stats->info7,
+			      HAL_RX_PPDU_END_USER_STATS_INFO7_MPDU_OK_BYTE_COUNT);
+	rx_user_status->mpdu_err_byte_count =
+		le32_get_bits(stats->info8,
+			      HAL_RX_PPDU_END_USER_STATS_INFO8_MPDU_ERR_BYTE_COUNT);
+}
+
+static void
+ath12k_wifi7_dp_mon_rx_populate_mu_user_info(const struct hal_rx_ppdu_end_user_stats *rx_tlv,
+					     struct hal_rx_mon_ppdu_info *ppdu_info,
+					     struct hal_rx_user_status *rx_user_status)
+{
+	rx_user_status->ast_index = ppdu_info->ast_index;
+	rx_user_status->tid = ppdu_info->tid;
+	rx_user_status->tcp_ack_msdu_count =
+		ppdu_info->tcp_ack_msdu_count;
+	rx_user_status->tcp_msdu_count =
+		ppdu_info->tcp_msdu_count;
+	rx_user_status->udp_msdu_count =
+		ppdu_info->udp_msdu_count;
+	rx_user_status->other_msdu_count =
+		ppdu_info->other_msdu_count;
+	rx_user_status->frame_control = ppdu_info->frame_control;
+	rx_user_status->frame_control_info_valid =
+		ppdu_info->frame_control_info_valid;
+	rx_user_status->data_sequence_control_info_valid =
+		ppdu_info->data_sequence_control_info_valid;
+	rx_user_status->first_data_seq_ctrl =
+		ppdu_info->first_data_seq_ctrl;
+	rx_user_status->preamble_type = ppdu_info->preamble_type;
+	rx_user_status->ht_flags = ppdu_info->ht_flags;
+	rx_user_status->vht_flags = ppdu_info->vht_flags;
+	rx_user_status->he_flags = ppdu_info->he_flags;
+	rx_user_status->rs_flags = ppdu_info->rs_flags;
+
+	rx_user_status->mpdu_cnt_fcs_ok =
+		ppdu_info->num_mpdu_fcs_ok;
+	rx_user_status->mpdu_cnt_fcs_err =
+		ppdu_info->num_mpdu_fcs_err;
+	memcpy(&rx_user_status->mpdu_fcs_ok_bitmap[0], &ppdu_info->mpdu_fcs_ok_bitmap[0],
+	       HAL_RX_NUM_WORDS_PER_PPDU_BITMAP *
+	       sizeof(ppdu_info->mpdu_fcs_ok_bitmap[0]));
+
+	ath12k_wifi7_dp_mon_rx_populate_byte_count(rx_tlv, ppdu_info, rx_user_status);
+}
+
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
+static void
+ath12k_wifi7_dp_mon_hal_rx_parse_user_info(const struct hal_receive_user_info *rx_usr_info,
+					   u16 user_id,
+					   struct hal_rx_mon_ppdu_info *ppdu_info)
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
+		return;
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
+}
+
 static void
 ath12k_wifi7_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
 				  struct hal_rx_mon_ppdu_info *ppdu_info)
@@ -1196,9 +1544,9 @@ ath12k_wifi7_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 
 			ppdu_info->num_users += 1;
 
-			ath12k_dp_mon_rx_handle_ofdma_info(eu_stats, rxuser_stats);
-			ath12k_dp_mon_rx_populate_mu_user_info(eu_stats, ppdu_info,
-							       rxuser_stats);
+			ath12k_wifi7_dp_mon_rx_handle_ofdma_info(eu_stats, rxuser_stats);
+			ath12k_wifi7_dp_mon_rx_populate_mu_user_info(eu_stats, ppdu_info,
+								     rxuser_stats);
 		}
 		ppdu_info->mpdu_fcs_ok_bitmap[0] = __le32_to_cpu(eu_stats->rsvd1[0]);
 		ppdu_info->mpdu_fcs_ok_bitmap[1] = __le32_to_cpu(eu_stats->rsvd1[1]);
@@ -1277,7 +1625,7 @@ ath12k_wifi7_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 		break;
 	}
 	case HAL_RX_PPDU_START_USER_INFO:
-		ath12k_dp_mon_hal_rx_parse_user_info(tlv_data, userid, ppdu_info);
+		ath12k_wifi7_dp_mon_hal_rx_parse_user_info(tlv_data, userid, ppdu_info);
 		break;
 
 	case HAL_RXPCU_PPDU_END_INFO: {
-- 
2.34.1


