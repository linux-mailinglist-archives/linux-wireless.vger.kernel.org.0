Return-Path: <linux-wireless+bounces-10814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C2A944A65
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 13:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F351C21FC8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C718A18A6C0;
	Thu,  1 Aug 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m3Wio8uK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF55B189B96
	for <linux-wireless@vger.kernel.org>; Thu,  1 Aug 2024 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511779; cv=none; b=dPsAPVFYIQNzpMvLa7n4IDMXYBgz7zKgqU7nEb6/F8TYDbLvgawTfT2way4UUXGFeqSCGqTi84xNdJPV2XT24TcLXKnlUObLNCk0AYDBJoqDiNhaDxM9g9U280xu+aylb315bFP67Q/LcVgDwav1HKwzAq3IlCLHy0yuK1Ai2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511779; c=relaxed/simple;
	bh=7eh66ut7KahbAvLin3hZhNLWu2aQFPi/CbZYYnq8wz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEPhRTS5u6RJqDW8AW1+9ca4KOb/xYeRydIuipwcIELZH1J2vv1d/vjxlTNAOhV3e/zo8rkNc4fqAfZt75SqMK/WDWgzP2yxE/Qd0N2MpTIzEaPZyuc6eGGtCezsFV1Fz2BaeHm3g65WzKalLUgMZbodXGa4XO4ol1OAqKaZ2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m3Wio8uK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4718KLE6020552;
	Thu, 1 Aug 2024 11:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r9Qxynsw6lYUMqnhrbO4ERXPjeUJHx9Wll2Zq+ePHB4=; b=m3Wio8uKP62g7kSq
	yp70FiyQm81I693wBa2ONEZIVBMmAWgwoh8Gxrl04+J6GGZHvt2IBulgBe+H6kn6
	F0fVsVTT0VtgjIlhLf+xiqWT4sbX7oAB/XZgP0/XR7mjnMDR8VrzIQOW6T25zKjG
	vQ497I3QDeyhRmFsUfTXHy0sGlv7z9iz29d+OGzFu9Frtz+ti6tGr1Lyj7Esug8q
	to9w8pvrcafc8nIEmwuBjwcn5JckTh/1B1McE4NTlRj7+frUOvdBqEMOolqeLVwV
	zEDZtFHbtXaDVwheemjnsAA8S44GJYsI6J3PYF5gwh9Y1VUIbHHn0GPELDFY/O7f
	Y5MXvA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40qkv0uva3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 11:29:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 471BTRX3002747
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 11:29:27 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 Aug 2024 04:29:26 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v7 1/3] wifi: ath12k: report station mode transmit rate
Date: Thu, 1 Aug 2024 19:28:51 +0800
Message-ID: <20240801112853.85508-2-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801112853.85508-1-quic_lingbok@quicinc.com>
References: <20240801112853.85508-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4JVAslNAH0R2QWcvoCRQcPZgmkQNyrGi
X-Proofpoint-GUID: 4JVAslNAH0R2QWcvoCRQcPZgmkQNyrGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010073

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
v7:
1.use switch statement
2.use info0 = le32_to_cpu(desc->rate_stats.info0) and then use u32_get_bits() everywhere

v6:
1.rebase against wifi: ath12k: prepare sta data structure for MLO handling

v5:
1.use ieee80211_find_sta_by_ifaddr() to avoid using base_lock

v4:
1.change ATH12K_EHT_MCS_MAX from 13 to 15

v3:
no change

v2:
1.change copyright

 drivers/net/wireless/ath/ath12k/core.h    |   2 +
 drivers/net/wireless/ath/ath12k/dp_rx.h   |   3 +
 drivers/net/wireless/ath/ath12k/dp_tx.c   | 139 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_rx.h  |   5 +-
 drivers/net/wireless/ath/ath12k/hal_tx.h  |   7 +-
 drivers/net/wireless/ath/ath12k/mac.c     |  79 ++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h     |   4 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h |   1 +
 8 files changed, 233 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 13f8695c2337..3a28b3fbe8a0 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -78,6 +78,7 @@ enum wme_ac {
 #define ATH12K_HT_MCS_MAX	7
 #define ATH12K_VHT_MCS_MAX	9
 #define ATH12K_HE_MCS_MAX	11
+#define ATH12K_EHT_MCS_MAX	15
 
 enum ath12k_crypt_mode {
 	/* Only use hardware crypto engine */
@@ -468,6 +469,7 @@ struct ath12k_link_sta {
 	struct ath12k_rx_peer_stats *rx_stats;
 	struct ath12k_wbm_tx_stats *wbm_tx_stats;
 	u32 bw_prev;
+	u32 peer_nss;
 };
 
 struct ath12k_sta {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index bfd4f814553e..b9a1cc017e2f 100644
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
index a351b9994c93..802cac4934dd 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -8,6 +8,8 @@
 #include "dp_tx.h"
 #include "debug.h"
 #include "hw.h"
+#include "peer.h"
+#include "mac.h"
 
 static enum hal_tcl_encap_type
 ath12k_dp_tx_get_encap_type(struct ath12k_link_vif *arvif, struct sk_buff *skb)
@@ -508,6 +510,124 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
 	}
 }
 
+static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_peer *peer;
+	struct ieee80211_sta *sta;
+	struct ath12k_sta *ahsta;
+	struct ath12k_link_sta *arsta;
+	struct rate_info txrate = {0};
+	u16 rate, ru_tones;
+	u8 rate_idx = 0;
+	int ret;
+
+	spin_lock_bh(&ab->base_lock);
+	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
+	if (!peer || !peer->sta) {
+		ath12k_dbg(ab, ATH12K_DBG_DP_TX,
+			   "failed to find the peer by id %u\n", ts->peer_id);
+		spin_unlock_bh(&ab->base_lock);
+		return;
+	}
+	sta = peer->sta;
+	ahsta = ath12k_sta_to_ahsta(sta);
+	arsta = &ahsta->deflink;
+
+	/* This is to prefer choose the real NSS value arsta->last_txrate.nss,
+	 * if it is invalid, then choose the NSS value while assoc.
+	 */
+	if (arsta->last_txrate.nss)
+		txrate.nss = arsta->last_txrate.nss;
+	else
+		txrate.nss = arsta->peer_nss;
+	spin_unlock_bh(&ab->base_lock);
+
+	switch (ts->pkt_type) {
+	case HAL_TX_RATE_STATS_PKT_TYPE_11A:
+	case HAL_TX_RATE_STATS_PKT_TYPE_11B:
+		ret = ath12k_mac_hw_ratecode_to_legacy_rate(ts->mcs,
+							    ts->pkt_type,
+							    &rate_idx,
+							    &rate);
+		if (ret < 0) {
+			ath12k_warn(ab, "Invalid tx legacy rate %d\n", ret);
+			return;
+		}
+
+		txrate.legacy = rate;
+		break;
+	case HAL_TX_RATE_STATS_PKT_TYPE_11N:
+		if (ts->mcs > ATH12K_HT_MCS_MAX) {
+			ath12k_warn(ab, "Invalid HT mcs index %d\n", ts->mcs);
+			return;
+		}
+
+		if (txrate.nss != 0)
+			txrate.mcs = ts->mcs + 8 * (txrate.nss - 1);
+
+		txrate.flags = RATE_INFO_FLAGS_MCS;
+
+		if (ts->sgi)
+			txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case HAL_TX_RATE_STATS_PKT_TYPE_11AC:
+		if (ts->mcs > ATH12K_VHT_MCS_MAX) {
+			ath12k_warn(ab, "Invalid VHT mcs index %d\n", ts->mcs);
+			return;
+		}
+
+		txrate.mcs = ts->mcs;
+		txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
+
+		if (ts->sgi)
+			txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case HAL_TX_RATE_STATS_PKT_TYPE_11AX:
+		if (ts->mcs > ATH12K_HE_MCS_MAX) {
+			ath12k_warn(ab, "Invalid HE mcs index %d\n", ts->mcs);
+			return;
+		}
+
+		txrate.mcs = ts->mcs;
+		txrate.flags = RATE_INFO_FLAGS_HE_MCS;
+		txrate.he_gi = ath12k_he_gi_to_nl80211_he_gi(ts->sgi);
+		break;
+	case HAL_TX_RATE_STATS_PKT_TYPE_11BE:
+		if (ts->mcs > ATH12K_EHT_MCS_MAX) {
+			ath12k_warn(ab, "Invalid EHT mcs index %d\n", ts->mcs);
+			return;
+		}
+
+		txrate.mcs = ts->mcs;
+		txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
+		txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(ts->sgi);
+		break;
+	default:
+		ath12k_warn(ab, "Invalid tx pkt type: %d\n", ts->pkt_type);
+		return;
+	}
+
+	txrate.bw = ath12k_mac_bw_to_mac80211_bw(ts->bw);
+
+	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
+		txrate.bw = RATE_INFO_BW_HE_RU;
+		ru_tones = ath12k_mac_he_convert_tones_to_ru_tones(ts->tones);
+		txrate.he_ru_alloc =
+			ath12k_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
+	}
+
+	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11BE) {
+		txrate.bw = RATE_INFO_BW_EHT_RU;
+		txrate.eht_ru_alloc =
+			ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(ts->tones);
+	}
+
+	spin_lock_bh(&ab->base_lock);
+	arsta->txrate = txrate;
+	spin_unlock_bh(&ab->base_lock);
+}
+
 static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 				       struct sk_buff *msdu,
 				       struct hal_tx_status *ts)
@@ -586,6 +706,8 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	 * Might end up reporting it out-of-band from HTT stats.
 	 */
 
+	ath12k_dp_tx_update_txcompl(ar, ts);
+
 	ieee80211_tx_status_skb(ath12k_ar_to_hw(ar), msdu);
 
 exit:
@@ -596,6 +718,8 @@ static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
 				      struct hal_wbm_completion_ring_tx *desc,
 				      struct hal_tx_status *ts)
 {
+	u32 info0 = le32_to_cpu(desc->rate_stats.info0);
+
 	ts->buf_rel_source =
 		le32_get_bits(desc->info0, HAL_WBM_COMPL_TX_INFO0_REL_SRC_MODULE);
 	if (ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_FW &&
@@ -610,10 +734,17 @@ static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
 
 	ts->ppdu_id = le32_get_bits(desc->info1,
 				    HAL_WBM_COMPL_TX_INFO1_TQM_STATUS_NUMBER);
-	if (le32_to_cpu(desc->rate_stats.info0) & HAL_TX_RATE_STATS_INFO0_VALID)
-		ts->rate_stats = le32_to_cpu(desc->rate_stats.info0);
-	else
-		ts->rate_stats = 0;
+
+	ts->peer_id = le32_get_bits(desc->info3, HAL_WBM_COMPL_TX_INFO3_PEER_ID);
+
+	if (info0 & HAL_TX_RATE_STATS_INFO0_VALID) {
+		ts->pkt_type = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_PKT_TYPE);
+		ts->mcs = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_MCS);
+		ts->sgi = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_SGI);
+		ts->bw = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_BW);
+		ts->tones = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_TONES_IN_RU);
+		ts->ofdma = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_OFDMA_TX);
+	}
 }
 
 void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 095216eabc01..d42ce6f1d5f2 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HAL_RX_H
@@ -651,6 +651,9 @@ enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
 	case RU_996:
 		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
 		break;
+	case RU_2X996:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+		break;
 	case RU_26:
 		fallthrough;
 	default:
diff --git a/drivers/net/wireless/ath/ath12k/hal_tx.h b/drivers/net/wireless/ath/ath12k/hal_tx.h
index 3cf5973771d7..fa216a1af1c1 100644
--- a/drivers/net/wireless/ath/ath12k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_tx.h
@@ -63,7 +63,12 @@ struct hal_tx_status {
 	u8 try_cnt;
 	u8 tid;
 	u16 peer_id;
-	u32 rate_stats;
+	enum hal_tx_rate_stats_pkt_type pkt_type;
+	enum hal_tx_rate_stats_sgi sgi;
+	enum ath12k_supported_bw bw;
+	u8 mcs;
+	u16 tones;
+	u8 ofdma;
 };
 
 #define HAL_TX_PHY_DESC_INFO0_BF_TYPE		GENMASK(17, 16)
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b36b9250c924..6e3b3e40b2ca 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -336,6 +336,82 @@ static const char *ath12k_mac_phymode_str(enum wmi_phy_mode mode)
 	return "<unknown>";
 }
 
+u16 ath12k_mac_he_convert_tones_to_ru_tones(u16 tones)
+{
+	switch (tones) {
+	case 26:
+		return RU_26;
+	case 52:
+		return RU_52;
+	case 106:
+		return RU_106;
+	case 242:
+		return RU_242;
+	case 484:
+		return RU_484;
+	case 996:
+		return RU_996;
+	case (996 * 2):
+		return RU_2X996;
+	default:
+		return RU_26;
+	}
+}
+
+enum nl80211_eht_gi ath12k_mac_eht_gi_to_nl80211_eht_gi(u8 sgi)
+{
+	switch (sgi) {
+	case RX_MSDU_START_SGI_0_8_US:
+		return NL80211_RATE_INFO_EHT_GI_0_8;
+	case RX_MSDU_START_SGI_1_6_US:
+		return NL80211_RATE_INFO_EHT_GI_1_6;
+	case RX_MSDU_START_SGI_3_2_US:
+		return NL80211_RATE_INFO_EHT_GI_3_2;
+	default:
+		return NL80211_RATE_INFO_EHT_GI_0_8;
+	}
+}
+
+enum nl80211_eht_ru_alloc ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(u16 ru_tones)
+{
+	switch (ru_tones) {
+	case 26:
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_26;
+	case 52:
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_52;
+	case (52 + 26):
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_52P26;
+	case 106:
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_106;
+	case (106 + 26):
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_106P26;
+	case 242:
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_242;
+	case 484:
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_484;
+	case (484 + 242):
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_484P242;
+	case 996:
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_996;
+	case (996 + 484):
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_996P484;
+	case (996 + 484 + 242):
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_996P484P242;
+	case (2 * 996):
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_2x996;
+	case (2 * 996 + 484):
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_2x996P484;
+	case (3 * 996):
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_3x996;
+	case (3 * 996 + 484):
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_3x996P484;
+	case (4 * 996):
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_4x996;
+	default:
+		return NL80211_RATE_INFO_EHT_RU_ALLOC_26;
+	}
+}
+
 enum rate_info_bw
 ath12k_mac_bw_to_mac80211_bw(enum ath12k_supported_bw bw)
 {
@@ -2858,6 +2934,7 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 	ath12k_peer_assoc_h_phymode(ar, arvif, arsta, arg);
 	ath12k_peer_assoc_h_smps(arsta, arg);
 
+	arsta->peer_nss = arg->peer_nss;
 	/* TODO: amsdu_disable req? */
 }
 
@@ -8710,6 +8787,8 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->txrate.he_gi = arsta->txrate.he_gi;
 		sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
 		sinfo->txrate.he_ru_alloc = arsta->txrate.he_ru_alloc;
+		sinfo->txrate.eht_gi = arsta->txrate.eht_gi;
+		sinfo->txrate.eht_ru_alloc = arsta->txrate.eht_ru_alloc;
 	}
 	sinfo->txrate.flags = arsta->txrate.flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index d382337ba649..584f22f53316 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -89,5 +89,7 @@ int ath12k_mac_vif_set_keepalive(struct ath12k_link_vif *arvif,
 				 enum wmi_sta_keepalive_method method,
 				 u32 interval);
 u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar);
-
+u16 ath12k_mac_he_convert_tones_to_ru_tones(u16 tones);
+enum nl80211_eht_ru_alloc ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(u16 ru_tones);
+enum nl80211_eht_gi ath12k_mac_eht_gi_to_nl80211_eht_gi(u8 sgi);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/rx_desc.h b/drivers/net/wireless/ath/ath12k/rx_desc.h
index a0db6702a189..9d9d7e936cbc 100644
--- a/drivers/net/wireless/ath/ath12k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath12k/rx_desc.h
@@ -1606,5 +1606,6 @@ struct hal_rx_desc {
 #define RU_242 9
 #define RU_484 18
 #define RU_996 37
+#define RU_2X996 74
 
 #endif /* ATH12K_RX_DESC_H */
-- 
2.34.1


