Return-Path: <linux-wireless+bounces-10352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A22B934CE8
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 14:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D96A1C2239E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 12:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0609213B2A4;
	Thu, 18 Jul 2024 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iTQuWmw4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2410137905
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304464; cv=none; b=PAyl222lRtl48efLnZveFqfK8jj+lPRfDgObRAE+GSsstnnqGd6qpZO6c6Fe/V8XXyeK60B4yACVx41sc6s1Uog1DEULJz4J1QmrHhG6HeQrQSxpZ0PxiQlYbprRS0AcszxEnzJTf1QYygt7A4KDANO1G1P4qEEj6Mwp9suA7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304464; c=relaxed/simple;
	bh=NVBrRyyBj1XlfA5EkCTeyilmkBD2wzv4wUuAgV5z1Wc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpvftcH8SZnjCl5jXFJsN1jzvXVdHbimK0s6c619mn/P0VRwmsN8538VIKhf1bqAnghFYNdqUwUPtPzDQ7BatAXuQ+Axh0bVlqxE5cfGmmS6OKYmA5xdoGQwmNpDYG9f71WzKT7hN8Xbqj1b1Qo8K4f0UqdneHSsJqTrPSaHVhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iTQuWmw4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IAXThX001954;
	Thu, 18 Jul 2024 12:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	md0h5MzgHrEG3j1YNQdNXdF84SxG8BMiJjvfgqgptK8=; b=iTQuWmw4DB16RRAj
	nVU9iCzDmiEI5YeeSfAej9imr9SQ7HsW9wOANhbqvTKOPlFNM1cKuek6kq/FIsv/
	L8QHNVxPKtYA0WEBQmh+UBTol2cap/jmG0raBXbDbI4nsqqSB1+0lu2BIZeUx4mO
	T3WvDuPtC4K6BGNUHFYHM1er6B7s7h0/kFm+MpJGl/obWaJEpyDAR6WKWF8Gxjpe
	2R3lMvKgZ5xGXGcBrs549l8zSBIpFoGuKvp/k58bICs7Hi8AjUP15TwhQkQvLI5A
	qdmGqqTDDqaGmR+wQwZoLm48tRnBeoHvsBmzub1V4zN7N/JdZvtJqltRK+TJPRkB
	qIFp2g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfs5e8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 12:07:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46IC7cmX013325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 12:07:38 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Jul 2024 05:07:36 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v5 1/3] wifi: ath12k: report station mode transmit rate
Date: Thu, 18 Jul 2024 20:07:23 +0800
Message-ID: <20240718120725.130265-2-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718120725.130265-1-quic_lingbok@quicinc.com>
References: <20240718120725.130265-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wQbX1VE6H8YgxhECB2F084BMME9dFao_
X-Proofpoint-GUID: wQbX1VE6H8YgxhECB2F084BMME9dFao_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_07,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180081

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
 drivers/net/wireless/ath/ath12k/dp_tx.c   | 117 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_rx.h  |   3 +
 drivers/net/wireless/ath/ath12k/hal_tx.h  |   7 +-
 drivers/net/wireless/ath/ath12k/mac.c     |  84 ++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h     |   4 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h |   1 +
 8 files changed, 215 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index cdfd43a7321a..ec9a114a746c 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -78,6 +78,7 @@ enum wme_ac {
 #define ATH12K_HT_MCS_MAX	7
 #define ATH12K_VHT_MCS_MAX	9
 #define ATH12K_HE_MCS_MAX	11
+#define ATH12K_EHT_MCS_MAX	15
 
 enum ath12k_crypt_mode {
 	/* Only use hardware crypto engine */
@@ -454,6 +455,7 @@ struct ath12k_sta {
 	struct ath12k_rx_peer_stats *rx_stats;
 	struct ath12k_wbm_tx_stats *wbm_tx_stats;
 	u32 bw_prev;
+	u32 peer_nss;
 };
 
 #define ATH12K_MIN_5G_FREQ 4150
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index eb1f92559179..54fa4f4d4b66 100644
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
index d08c04343e90..c68f3645ed33 100644
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
@@ -507,6 +509,95 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
 	}
 }
 
+static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts,
+					struct ieee80211_sta *sta)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
+	u16 rate, ru_tones;
+	u8 rate_idx = 0;
+	int ret;
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
+			return;
+		}
+
+		arsta->txrate.legacy = rate;
+	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
+		if (ts->mcs > ATH12K_HT_MCS_MAX) {
+			ath12k_warn(ab, "Invalid HT mcs index %d\n", ts->mcs);
+			return;
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
+			return;
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
+			return;
+		}
+
+		arsta->txrate.mcs = ts->mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
+		arsta->txrate.he_gi = ath12k_he_gi_to_nl80211_he_gi(ts->sgi);
+	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11BE) {
+		if (ts->mcs > ATH12K_EHT_MCS_MAX) {
+			ath12k_warn(ab, "Invalid EHT mcs index %d\n", ts->mcs);
+			return;
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
+		ru_tones = ath12k_mac_he_convert_tones_to_ru_tones(ts->tones);
+		arsta->txrate.he_ru_alloc =
+			ath12k_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
+	}
+
+	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11BE) {
+		arsta->txrate.bw = RATE_INFO_BW_EHT_RU;
+		arsta->txrate.eht_ru_alloc =
+			ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(ts->tones);
+	}
+}
+
 static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 				       struct sk_buff *msdu,
 				       struct hal_tx_status *ts)
@@ -515,6 +606,8 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	struct ath12k_hw *ah = ar->ah;
 	struct ieee80211_tx_info *info;
 	struct ath12k_skb_cb *skb_cb;
+	struct ieee80211_sta *sta;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)msdu->data;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -585,6 +678,11 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	 * Might end up reporting it out-of-band from HTT stats.
 	 */
 
+	sta = ieee80211_find_sta_by_ifaddr(ath12k_ar_to_hw(ar),
+					   hdr->addr1, NULL);
+	if (sta)
+		ath12k_dp_tx_update_txcompl(ar, ts, sta);
+
 	ieee80211_tx_status_skb(ath12k_ar_to_hw(ar), msdu);
 
 exit:
@@ -609,10 +707,21 @@ static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
 
 	ts->ppdu_id = le32_get_bits(desc->info1,
 				    HAL_WBM_COMPL_TX_INFO1_TQM_STATUS_NUMBER);
-	if (le32_to_cpu(desc->rate_stats.info0) & HAL_TX_RATE_STATS_INFO0_VALID)
-		ts->rate_stats = le32_to_cpu(desc->rate_stats.info0);
-	else
-		ts->rate_stats = 0;
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
+		ts->tones = le32_get_bits(desc->rate_stats.info0,
+					  HAL_TX_RATE_STATS_INFO0_TONES_IN_RU);
+		ts->ofdma = le32_get_bits(desc->rate_stats.info0,
+					  HAL_TX_RATE_STATS_INFO0_OFDMA_TX);
+	}
 }
 
 void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 095216eabc01..00424bdd9ed0 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
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
index 8106297f0bc1..2b9cc05d6b91 100644
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
@@ -2808,8 +2884,12 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
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
@@ -2827,6 +2907,8 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 	ath12k_peer_assoc_h_phymode(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_smps(sta, arg);
 
+	arsta->peer_nss = arg->peer_nss;
+
 	/* TODO: amsdu_disable req? */
 }
 
@@ -8440,6 +8522,8 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->txrate.he_gi = arsta->txrate.he_gi;
 		sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
 		sinfo->txrate.he_ru_alloc = arsta->txrate.he_ru_alloc;
+		sinfo->txrate.eht_gi = arsta->txrate.eht_gi;
+		sinfo->txrate.eht_ru_alloc = arsta->txrate.eht_ru_alloc;
 	}
 	sinfo->txrate.flags = arsta->txrate.flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 5efbb6822628..730c6a63373a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -86,5 +86,7 @@ int ath12k_mac_vif_set_keepalive(struct ath12k_vif *arvif,
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


