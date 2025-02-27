Return-Path: <linux-wireless+bounces-19518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D7FA474F1
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 05:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26731888275
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 04:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546BC1E98F8;
	Thu, 27 Feb 2025 04:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UskOFQGx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971081EB5C6
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 04:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632348; cv=none; b=YQWraLXLw9/OX+XBfj5MJxyBuujqns+82JXLSX19VwpPl9nkNKmVUZ1EBWeshkLOxsd7NC5ewqlNIpQ3r7lYfBowinmV2wnGL8l+9jvweHIEcBAqIdgSCf7sGUQAiZhdxCp9kDOdKeNpYHTT80XSRgDeG5YefrOnxsZvFCTV+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632348; c=relaxed/simple;
	bh=i4Ob7qqBM08iVLXvRTGr5O+GcPqXgrhhnM1bZUSCbxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qi7rVn3cvEWlXrfrbtZVzXU2JgGZ+I8tA2KfGkyolYt4hP2MHauC93q9xxGvjQGA6WdgBFoF2xhXzk2UJbfYWJ+5U/huJUaepFeOgT3hFlY6f93+diTSGeZo67KIo66ro+V54HHdIXuD63tfsdkqyIuA7hZYlQCWByfQ0p7w86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UskOFQGx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QKP5GS025442;
	Thu, 27 Feb 2025 04:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5ev18krOPwCbuVEfs6qlgOHpvdu7leGNzx9Jurt2qtw=; b=UskOFQGxHBp4E1CO
	OcmlLp2adr8Dq+usUNrZj5pazGlh1N350aRhD1BwoGjeOTOB6iXMY7NweMSdfD0f
	gG5PmGlvgtHqrhyM7RSZoY4hii8aXZggiYEWnQwfAuyOQL8SbxTq9COc5y/c+S4O
	+i3i/1owd4ZShCssMHI5Vg5Dab3ckV1DrBBhREncOVRMTDSCwxC94zfd14+XMDIc
	ydNFXrRE5SK3IJFCbHtKmszBynUfaDVvzd6mRwHTENcmqkM9q746v7M23KQF2URf
	VwqJXwlXX+j5qae8XByztPV/zOnOyY94brj4oOnnd75k8cbwHfyi9GYPfeXHg1ny
	tS+E4A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prmma56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 04:58:50 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51R4wnKv010903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 04:58:49 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Feb 2025 20:58:48 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        "Sarika
 Sharma" <quic_sarishar@quicinc.com>
Subject: [PATCH v3 4/5] wifi: ath12k: correctly update bw for ofdma packets
Date: Thu, 27 Feb 2025 10:28:23 +0530
Message-ID: <20250227045824.91480-5-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227045824.91480-1-quic_sarishar@quicinc.com>
References: <20250227045824.91480-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RjhlsX0PpffigB_8QfdlV76mSxLEaMuK
X-Proofpoint-ORIG-GUID: RjhlsX0PpffigB_8QfdlV76mSxLEaMuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502270036

Currently, arsta->txrate.bw is filled from ath12k_mac_bw_to_mac80211_bw(bw)
during ath12k_update_per_peer_tx_stats(). But in tx_completion path bw
is filled differently if ppdu_type is ofdma for HE/EHT rates.

Hence, update arsta->txrate.bw correctly if packet is ofdma for HE
and EHT rate.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h    |  2 ++
 drivers/net/wireless/ath/ath12k/dp_rx.c | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 75435a931548..3ddbf781c2b5 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1508,6 +1508,8 @@ enum HTT_PPDU_STATS_PPDU_TYPE {
 #define HTT_PPDU_STATS_USER_RATE_FLAGS_DCM_M		BIT(28)
 #define HTT_PPDU_STATS_USER_RATE_FLAGS_LDPC_M		BIT(29)
 
+#define HTT_USR_RATE_PPDU_TYPE(_val) \
+		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_INFO1_PPDU_TYPE_M)
 #define HTT_USR_RATE_PREAMBLE(_val) \
 		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_PREAMBLE_M)
 #define HTT_USR_RATE_BW(_val) \
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 070568b8322c..c3bd7a39150b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1368,12 +1368,12 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	struct htt_ppdu_user_stats *usr_stats = &ppdu_stats->user_stats[user];
 	struct htt_ppdu_stats_common *common = &ppdu_stats->common;
 	int ret;
-	u8 flags, mcs, nss, bw, sgi, dcm, rate_idx = 0;
+	u8 flags, mcs, nss, bw, sgi, dcm, ppdu_type, rate_idx = 0;
 	u32 v, succ_bytes = 0;
 	u16 tones, rate = 0, succ_pkts = 0;
 	u32 tx_duration = 0;
 	u8 tid = HTT_PPDU_STATS_NON_QOS_TID;
-	bool is_ampdu = false;
+	bool is_ampdu = false, is_ofdma = false;
 
 	if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
 		return;
@@ -1402,6 +1402,10 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	sgi = HTT_USR_RATE_GI(user_rate->rate_flags);
 	dcm = HTT_USR_RATE_DCM(user_rate->rate_flags);
 
+	ppdu_type = HTT_USR_RATE_PPDU_TYPE(user_rate->info1);
+	is_ofdma = (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_OFDMA) ||
+		   (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_MIMO_OFDMA);
+
 	/* Note: If host configured fixed rates and in some other special
 	 * cases, the broadcast/management frames are sent in different rates.
 	 * Firmware rate's control to be skipped for this?
@@ -1452,6 +1456,8 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 
 	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
 
+	arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(bw);
+
 	switch (flags) {
 	case WMI_RATE_PREAMBLE_OFDM:
 		arsta->txrate.legacy = rate;
@@ -1480,6 +1486,8 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 			le16_to_cpu(user_rate->ru_start) + 1;
 		v = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(tones);
 		arsta->txrate.he_ru_alloc = v;
+		if (is_ofdma)
+			arsta->txrate.bw = RATE_INFO_BW_HE_RU;
 		break;
 	case WMI_RATE_PREAMBLE_EHT:
 		arsta->txrate.mcs = mcs;
@@ -1490,11 +1498,12 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 			le16_to_cpu(user_rate->ru_start) + 1;
 		v = ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(tones);
 		arsta->txrate.eht_ru_alloc = v;
+		if (is_ofdma)
+			arsta->txrate.bw = RATE_INFO_BW_EHT_RU;
 		break;
 	}
 
 	arsta->txrate.nss = nss;
-	arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(bw);
 	arsta->tx_duration += tx_duration;
 	memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info));
 
-- 
2.34.1


