Return-Path: <linux-wireless+bounces-6140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64988A063A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 04:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4591C233BB
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 02:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1143513B2BE;
	Thu, 11 Apr 2024 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pi9dGF5I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6B626DD
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804036; cv=none; b=jt1qln76i0f3Q1JcAFvuhnNtZdGxDTyHa9bkbEM61nofYNihe683JPoXpWBF2CG0gV/TVzh1mYJWvfk9yFgJ/p6YS/D5wIa/pdPN2Nh4kInxJ9d0cAAN7Vd2W3jDxAFgRk5iBqXXzNII/Xli6z5BNvqAQlOBCn4a51bCnbKZfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804036; c=relaxed/simple;
	bh=yuNKnVUhn6Bzsy+kzjBh5vKARaJFLks+1noo+on/0o0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcmTE4fyg/AKKvsvic47XNHvpyrM5lJG1//r5WjOvWAxEcFtooJ/5g1czMoM/tYEHuRWBZIsAwAi8dB2ppiw69dN2hdDZugCz3z3pmYcByrCenfrhZ0stFz5tCUrswJLge8+Ig+9ok/T8WFGmzEMb8Gwzr33r3/E4cNC9Odnen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pi9dGF5I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B2YR1K004125;
	Thu, 11 Apr 2024 02:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=hWqqu5ZCHoqUKXXEYY6c1kwJ+UmyN6lh/UoFbpbBbOQ=; b=pi
	9dGF5I0wvHJKNTNajRwI4ic7mOJb69t8OPAFHwsvxYQfVp/l0vYZi+PbQp643EEU
	VgJEri0mkSrcDp7JjJR0gm9dd7c/Nx/Xb9UCaY/JOTHTKbxNN5erAh8Vy1K2yqMx
	ZzBmRYZCCAal3bVXn0uqzeG+baPl3tjJaBsHrN2O2WSUb15O2GEOCCWczZT1WQdh
	1UyJQObbBYlWoxHfk0NlXzho24iXusW8PaPoss3czPM7oWYABFXaJLjDRfeXlDD6
	/QbFDWSIEEkrWO2nmg/Sc7a6sC9KPOHl1ahdtiVgnKHCYx97tNJJif9x601JK2PY
	wvggMDRp+DrSp9TA9/cw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdquhusmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 02:53:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43B2rm17003634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 02:53:48 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Apr 2024 19:53:47 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH 1/3] wifi: ath12k: report station mode transmit rate
Date: Thu, 11 Apr 2024 10:53:20 +0800
Message-ID: <20240411025322.33888-2-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411025322.33888-1-quic_lingbok@quicinc.com>
References: <20240411025322.33888-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ME9OX4E1QOb0-4iWQhCjb8tyydByWIWm
X-Proofpoint-GUID: ME9OX4E1QOb0-4iWQhCjb8tyydByWIWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110019

Currently, the transmit rate of "iw dev xxx station dump" command
always show an invalid value.

To address this issue, ath12k parse the info of transmit complete
report from firmware and indicate the transmit rate to mac80211.

This patch affects the station mode of WCN7850 and QCN9274.

After that, "iw dev xxx station dump" show the correct transmit rate.
Such as:

Station 00:03:7f:12:03:03 (on wlo1)
        inactive time:  872 ms
        rx bytes:       219111
        rx packets:     1133
        tx bytes:       53767
        tx packets:     462
        tx retries:     51
        tx failed:      0
        beacon loss:    0
        beacon rx:      403
        rx drop misc:   74
        signal:         -95 dBm
        beacon signal avg:      -18 dBm
        tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h   |   2 +
 drivers/net/wireless/ath/ath12k/dp_rx.h  |   3 +
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 147 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_tx.h |   9 +-
 drivers/net/wireless/ath/ath12k/mac.c    | 124 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h    |   3 +
 6 files changed, 282 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 86895139052b..20298f1ffbe3 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -73,6 +73,7 @@ enum wme_ac {
 #define ATH12K_HT_MCS_MAX	7
 #define ATH12K_VHT_MCS_MAX	9
 #define ATH12K_HE_MCS_MAX	11
+#define ATH12K_EHT_MCS_MAX	13
 
 enum ath12k_crypt_mode {
 	/* Only use hardware crypto engine */
@@ -425,6 +426,7 @@ struct ath12k_sta {
 	struct ath12k_rx_peer_stats *rx_stats;
 	struct ath12k_wbm_tx_stats *wbm_tx_stats;
 	u32 bw_prev;
+	u32 peer_nss;
 };
 
 #define ATH12K_MIN_5G_FREQ 4150
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 25940061ead5..0b437762b7ad 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -79,6 +79,9 @@ static inline u32 ath12k_he_gi_to_nl80211_he_gi(u8 sgi)
 	case RX_MSDU_START_SGI_3_2_US:
 		ret = NL80211_RATE_INFO_HE_GI_3_2;
 		break;
+	default:
+		ret = NL80211_RATE_INFO_HE_GI_0_8;
+		break;
 	}
 
 	return ret;
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 9b6d7d72f57c..74ef4c7a72c1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -8,6 +8,8 @@
 #include "dp_tx.h"
 #include "debug.h"
 #include "hw.h"
+#include "peer.h"
+#include "mac.h"
 
 static enum hal_tcl_encap_type
 ath12k_dp_tx_get_encap_type(struct ath12k_vif *arvif, struct sk_buff *skb)
@@ -443,6 +445,125 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
 	}
 }
 
+static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_peer *peer;
+	struct ath12k_sta *arsta;
+	struct ieee80211_sta *sta;
+	u16 rate;
+	u8 rate_idx = 0;
+	int ret;
+
+	spin_lock_bh(&ab->base_lock);
+
+	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
+	if (!peer || !peer->sta) {
+		ath12k_dbg(ab, ATH12K_DBG_DP_TX,
+			   "failed to find the peer by id %u\n", ts->peer_id);
+		goto err_out;
+	}
+
+	sta = peer->sta;
+	arsta = ath12k_sta_to_arsta(sta);
+
+	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
+
+	/* This is to prefer choose the real NSS value arsta->last_txrate.nss,
+	 * if it is invalid, then choose the NSS value while assoc.
+	 */
+	if (arsta->last_txrate.nss)
+		arsta->txrate.nss = arsta->last_txrate.nss;
+	else
+		arsta->txrate.nss = arsta->peer_nss;
+
+	if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11A ||
+	    ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11B) {
+		ret = ath12k_mac_hw_ratecode_to_legacy_rate(ts->mcs,
+							    ts->pkt_type,
+							    &rate_idx,
+							    &rate);
+		if (ret < 0) {
+			ath12k_warn(ab, "Invalid tx legacy rate %d\n", ret);
+			goto err_out;
+		}
+
+		arsta->txrate.legacy = rate;
+	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
+		if (ts->mcs > ATH12K_HT_MCS_MAX) {
+			ath12k_warn(ab, "Invalid HT mcs index %d\n", ts->mcs);
+			goto err_out;
+		}
+
+		if (arsta->txrate.nss != 0)
+			arsta->txrate.mcs = ts->mcs + 8 * (arsta->txrate.nss - 1);
+
+		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
+
+		if (ts->sgi)
+			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AC) {
+		if (ts->mcs > ATH12K_VHT_MCS_MAX) {
+			ath12k_warn(ab, "Invalid VHT mcs index %d\n", ts->mcs);
+			goto err_out;
+		}
+
+		arsta->txrate.mcs = ts->mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
+
+		if (ts->sgi)
+			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
+		if (ts->mcs > ATH12K_HE_MCS_MAX) {
+			ath12k_warn(ab, "Invalid HE mcs index %d\n", ts->mcs);
+			goto err_out;
+		}
+
+		arsta->txrate.mcs = ts->mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
+		arsta->txrate.he_gi = ath12k_he_gi_to_nl80211_he_gi(ts->sgi);
+	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11BE) {
+		if (ts->mcs > ATH12K_EHT_MCS_MAX) {
+			ath12k_warn(ab, "Invalid EHT mcs index %d\n", ts->mcs);
+			goto err_out;
+		}
+
+		arsta->txrate.mcs = ts->mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
+		arsta->txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(ts->sgi);
+	}
+
+	arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(ts->bw);
+
+	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
+		arsta->txrate.bw = RATE_INFO_BW_HE_RU;
+		arsta->txrate.he_ru_alloc =
+			ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(ts->ru_tones);
+	}
+
+	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11BE) {
+		arsta->txrate.bw = RATE_INFO_BW_EHT_RU;
+		arsta->txrate.eht_ru_alloc =
+			ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(ts->ru_tones);
+	}
+
+err_out:
+	spin_unlock_bh(&ab->base_lock);
+}
+
+static void ath12k_dp_tx_update(struct ath12k *ar, struct hal_tx_status *ts)
+{
+	if (ar->last_ppdu_id != 0) {
+		if (ar->last_ppdu_id == ts->ppdu_id ||
+		    ar->cached_ppdu_id == ar->last_ppdu_id)
+			ar->cached_ppdu_id = ar->last_ppdu_id;
+
+		ath12k_dp_tx_update_txcompl(ar, ts);
+	}
+
+	ar->last_ppdu_id = ts->ppdu_id;
+}
+
 static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 				       struct sk_buff *msdu,
 				       struct hal_tx_status *ts)
@@ -498,6 +619,8 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	 * Might end up reporting it out-of-band from HTT stats.
 	 */
 
+	ath12k_dp_tx_update(ar, ts);
+
 	ieee80211_tx_status_skb(ath12k_ar_to_hw(ar), msdu);
 
 exit:
@@ -522,10 +645,26 @@ static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
 
 	ts->ppdu_id = le32_get_bits(desc->info1,
 				    HAL_WBM_COMPL_TX_INFO1_TQM_STATUS_NUMBER);
-	if (le32_to_cpu(desc->rate_stats.info0) & HAL_TX_RATE_STATS_INFO0_VALID)
-		ts->rate_stats = le32_to_cpu(desc->rate_stats.info0);
-	else
-		ts->rate_stats = 0;
+
+	if (le32_to_cpu(desc->info2) & HAL_WBM_COMPL_TX_INFO2_FIRST_MSDU)
+		ts->flags |= HAL_TX_STATUS_FLAGS_FIRST_MSDU;
+
+	ts->peer_id = le32_get_bits(desc->info3, HAL_WBM_COMPL_TX_INFO3_PEER_ID);
+
+	if (le32_to_cpu(desc->rate_stats.info0) & HAL_TX_RATE_STATS_INFO0_VALID) {
+		ts->pkt_type = le32_get_bits(desc->rate_stats.info0,
+					     HAL_TX_RATE_STATS_INFO0_PKT_TYPE);
+		ts->mcs = le32_get_bits(desc->rate_stats.info0,
+					HAL_TX_RATE_STATS_INFO0_MCS);
+		ts->sgi = le32_get_bits(desc->rate_stats.info0,
+					HAL_TX_RATE_STATS_INFO0_SGI);
+		ts->bw = le32_get_bits(desc->rate_stats.info0,
+				       HAL_TX_RATE_STATS_INFO0_BW);
+		ts->ru_tones = le32_get_bits(desc->rate_stats.info0,
+					     HAL_TX_RATE_STATS_INFO0_TONES_IN_RU);
+		ts->ofdma = le32_get_bits(desc->rate_stats.info0,
+					  HAL_TX_RATE_STATS_INFO0_OFDMA_TX);
+	}
 }
 
 void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
diff --git a/drivers/net/wireless/ath/ath12k/hal_tx.h b/drivers/net/wireless/ath/ath12k/hal_tx.h
index 7c837094a6f7..7cfc584649ad 100644
--- a/drivers/net/wireless/ath/ath12k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_tx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HAL_TX_H
@@ -63,7 +63,12 @@ struct hal_tx_status {
 	u8 try_cnt;
 	u8 tid;
 	u16 peer_id;
-	u32 rate_stats;
+	enum hal_tx_rate_stats_pkt_type pkt_type;
+	enum hal_tx_rate_stats_sgi sgi;
+	enum ath12k_supported_bw bw;
+	u8 mcs;
+	u16 ru_tones;
+	u8 ofdma;
 };
 
 #define HAL_TX_PHY_DESC_INFO0_BF_TYPE		GENMASK(17, 16)
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2df966723c44..f7f465eb22a6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -326,6 +326,122 @@ static const char *ath12k_mac_phymode_str(enum wmi_phy_mode mode)
 	return "<unknown>";
 }
 
+enum nl80211_he_ru_alloc ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
+{
+	enum nl80211_he_ru_alloc ret;
+
+	switch (ru_tones) {
+	case 26:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		break;
+	case 52:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
+		break;
+	case 106:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		break;
+	case 242:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+		break;
+	case 484:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+		break;
+	case 996:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+		break;
+	case (996 * 2):
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+		break;
+	default:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		break;
+	}
+
+	return ret;
+}
+
+enum nl80211_eht_gi ath12k_mac_eht_gi_to_nl80211_eht_gi(u8 sgi)
+{
+	enum nl80211_eht_gi ret;
+
+	switch (sgi) {
+	case RX_MSDU_START_SGI_0_8_US:
+		ret = NL80211_RATE_INFO_EHT_GI_0_8;
+		break;
+	case RX_MSDU_START_SGI_1_6_US:
+		ret = NL80211_RATE_INFO_EHT_GI_1_6;
+		break;
+	case RX_MSDU_START_SGI_3_2_US:
+		ret = NL80211_RATE_INFO_EHT_GI_3_2;
+		break;
+	default:
+		ret = NL80211_RATE_INFO_EHT_GI_0_8;
+		break;
+	}
+
+	return ret;
+}
+
+enum nl80211_eht_ru_alloc ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(u16 ru_tones)
+{
+	enum nl80211_eht_ru_alloc ret;
+
+	switch (ru_tones) {
+	case 26:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_26;
+		break;
+	case 52:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_52;
+		break;
+	case (52 + 26):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_52P26;
+		break;
+	case 106:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_106;
+		break;
+	case (106 + 26):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_106P26;
+		break;
+	case 242:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_242;
+		break;
+	case 484:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_484;
+		break;
+	case (484 + 242):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_484P242;
+		break;
+	case 996:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_996;
+		break;
+	case (996 + 484):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_996P484;
+		break;
+	case (996 + 484 + 242):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_996P484P242;
+		break;
+	case (2 * 996):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_2x996;
+		break;
+	case (2 * 996 + 484):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_2x996P484;
+		break;
+	case (3 * 996):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_3x996;
+		break;
+	case (3 * 996 + 484):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_3x996P484;
+		break;
+	case (4 * 996):
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_4x996;
+		break;
+	default:
+		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_26;
+	}
+
+	return ret;
+}
+
 enum rate_info_bw
 ath12k_mac_bw_to_mac80211_bw(enum ath12k_supported_bw bw)
 {
@@ -2366,8 +2482,12 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 				      struct ath12k_wmi_peer_assoc_arg *arg,
 				      bool reassoc)
 {
+	struct ath12k_sta *arsta;
+
 	lockdep_assert_held(&ar->conf_mutex);
 
+	arsta = ath12k_sta_to_arsta(sta);
+
 	memset(arg, 0, sizeof(*arg));
 
 	reinit_completion(&ar->peer_assoc_done);
@@ -2384,6 +2504,8 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 	ath12k_peer_assoc_h_phymode(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_smps(sta, arg);
 
+	arsta->peer_nss = arg->peer_nss;
+
 	/* TODO: amsdu_disable req? */
 }
 
@@ -7464,6 +7586,8 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->txrate.he_gi = arsta->txrate.he_gi;
 		sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
 		sinfo->txrate.he_ru_alloc = arsta->txrate.he_ru_alloc;
+		sinfo->txrate.eht_gi = arsta->txrate.eht_gi;
+		sinfo->txrate.eht_ru_alloc = arsta->txrate.eht_ru_alloc;
 	}
 	sinfo->txrate.flags = arsta->txrate.flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 3f5e1be0dff9..03785b7ad9ed 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -78,4 +78,7 @@ enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath12k_bw(enum rate_info_bw b
 enum hal_encrypt_type ath12k_dp_tx_get_encrypt_type(u32 cipher);
 int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable);
 int ath12k_mac_rfkill_config(struct ath12k *ar);
+enum nl80211_he_ru_alloc ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones);
+enum nl80211_eht_ru_alloc ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(u16 ru_tones);
+enum nl80211_eht_gi ath12k_mac_eht_gi_to_nl80211_eht_gi(u8 sgi);
 #endif
-- 
2.34.1


