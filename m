Return-Path: <linux-wireless+bounces-500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BBC80712F
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 14:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A791F212D5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676C364B9;
	Wed,  6 Dec 2023 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cfJwZECV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1CDD47
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 05:50:38 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B66vc3v001308;
	Wed, 6 Dec 2023 13:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=4JYaQlxqIS0NtCMmU/Vlsz2J1I0jWr7PeFnDobSu9IA=;
 b=cfJwZECVW/PZOEDCBaMi31xYLRr/bjhWCnn7TnxihdOUAlzI33phN6EH6uRW/J7OPlDz
 4x8X2KOyF7MwmZxIJFhyLr6VDdnSDuFlBaT7CUiiNKbsH+rjOb/mtjYqidUneXpSilgg
 qHz40PDiriTLcF18rqIXypNNraYjXyG8Enw3HUOnBmccUacnjx1XcaaEbyH8/gjfT4Vy
 DxQMYgULD7EGTVadK5EmcTW1LVczMo5dfR6BgPl5Y7Z27vN5NvwvaW/M1DyxvK8e+RgC
 azzH6xCjVdSIKKqSbecvHwnmNBwq+i50J7uaVYO/BPlx27xI6NKCgEjcyYUaLLZGh/Eg Mw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utd1whwsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 13:50:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B6DoTP2018442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Dec 2023 13:50:31 GMT
Received: from lingbok-HP-EliteBook-8460p.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 05:47:04 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH] wifi: ath12k: report tx bitrate for iw dev xxx station dump
Date: Wed, 6 Dec 2023 21:46:54 +0800
Message-ID: <20231206134654.24662-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: plMb3aE9o6Jb2bYU9CDqcz-1H6YDEpzE
X-Proofpoint-ORIG-GUID: plMb3aE9o6Jb2bYU9CDqcz-1H6YDEpzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_10,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1011 impostorscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060111

The tx bitrate of "iw dev xxx station dump" always show an invalid value
"tx bitrate: 6.0MBit/s".

To address this issue, parse the tx complete report from firmware and
indicate the tx rate to mac80211.

After that, "iw dev xxx station dump" show the correct tx bitrate such as:
tx bitrate: 104.0 MBit/s MCS 13
tx bitrate: 144.4 MBit/s MCS 15 short GI
tx bitrate: 626.9 MBit/s 80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
tx bitrate: 1921.5 MBit/s 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h   |   1 +
 drivers/net/wireless/ath/ath12k/dp_mon.c |   2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |   6 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 128 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_tx.h |   7 +-
 drivers/net/wireless/ath/ath12k/mac.c    |  92 ++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h    |   3 +
 7 files changed, 230 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 8458dc292821..0598d18c51a6 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -417,6 +417,7 @@ struct ath12k_sta {
 	struct ath12k_rx_peer_stats *rx_stats;
 	struct ath12k_wbm_tx_stats *wbm_tx_stats;
 	u32 bw_prev;
+	u32 peer_nss;
 };
 
 #define ATH12K_MIN_5G_FREQ 4150
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index be4b39f5fa80..f5be951a165e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -290,7 +290,7 @@ static void ath12k_dp_mon_parse_he_sig_b1_mu(u8 *tlv_data,
 
 	ru_tones = u32_get_bits(info0,
 				HAL_RX_HE_SIG_B1_MU_INFO_INFO0_RU_ALLOCATION);
-	ppdu_info->ru_alloc = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
+	ppdu_info->ru_alloc = ath12k_mac_phy_he_ru_to_nl80211_he_ru_alloc(ru_tones);
 	ppdu_info->he_RU[0] = ru_tones;
 	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
 }
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 1ee83f765929..60e10a4893cc 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1416,10 +1416,10 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 		arsta->txrate.mcs = mcs;
 		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
 		arsta->txrate.he_dcm = dcm;
-		arsta->txrate.he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
+		arsta->txrate.he_gi = ath12k_mac_he_gi_to_nl80211_he_gi(sgi);
 		tones = le16_to_cpu(user_rate->ru_end) -
 			le16_to_cpu(user_rate->ru_start) + 1;
-		v = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(tones);
+		v = ath12k_mac_phy_he_ru_to_nl80211_he_ru_alloc(tones);
 		arsta->txrate.he_ru_alloc = v;
 		break;
 	}
@@ -2328,7 +2328,7 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc *rx_desc,
 		}
 		rx_status->encoding = RX_ENC_HE;
 		rx_status->nss = nss;
-		rx_status->he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
+		rx_status->he_gi = ath12k_mac_he_gi_to_nl80211_he_gi(sgi);
 		rx_status->bw = ath12k_mac_bw_to_mac80211_bw(bw);
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 62f9cdbb811c..6313851b1a40 100644
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
@@ -443,6 +445,106 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
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
+		if (ret < 0)
+			goto err_out;
+
+		arsta->txrate.legacy = rate;
+	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
+		if (ts->mcs > 7)
+			goto err_out;
+
+		if (arsta->txrate.nss != 0)
+			arsta->txrate.mcs = ts->mcs + 8 * (arsta->txrate.nss - 1);
+		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
+		if (ts->sgi)
+			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AC) {
+		if (ts->mcs > 9)
+			goto err_out;
+
+		arsta->txrate.mcs = ts->mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		if (ts->sgi)
+			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
+		if (ts->mcs > 11)
+			goto err_out;
+
+		arsta->txrate.mcs = ts->mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
+		arsta->txrate.he_gi = ath12k_mac_he_gi_to_nl80211_he_gi(ts->sgi);
+	}
+
+	arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(ts->bw);
+	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
+		arsta->txrate.bw = RATE_INFO_BW_HE_RU;
+		arsta->txrate.he_ru_alloc =
+			ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(ts->ru_tones);
+	}
+
+err_out:
+	spin_unlock_bh(&ab->base_lock);
+}
+
+static void ath12k_dp_tx_update(struct ath12k *ar, struct hal_tx_status *ts)
+{
+	if (!ar->ab->hw_params->single_pdev_only)
+		return;
+
+	if (ar->last_ppdu_id == 0)
+		goto update_last_ppdu_id;
+
+	if (ar->last_ppdu_id == ts->ppdu_id ||
+	    ar->cached_ppdu_id == ar->last_ppdu_id) {
+		ar->cached_ppdu_id = ar->last_ppdu_id;
+		ar->cached_stats.is_ampdu = true;
+	} else {
+		ar->cached_stats.is_ampdu = false;
+	}
+
+	ath12k_dp_tx_update_txcompl(ar, ts);
+
+update_last_ppdu_id:
+	ar->last_ppdu_id = ts->ppdu_id;
+}
+
 static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 				       struct sk_buff *msdu,
 				       struct hal_tx_status *ts)
@@ -498,6 +600,8 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	 * Might end up reporting it out-of-band from HTT stats.
 	 */
 
+	ath12k_dp_tx_update(ar, ts);
+
 	ieee80211_tx_status_skb(ar->hw, msdu);
 
 exit:
@@ -522,10 +626,26 @@ static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
 
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
index 7c837094a6f7..4ffd5c82fcfd 100644
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
+	u16 ru_tones;
+	u8 ofdma;
 };
 
 #define HAL_TX_PHY_DESC_INFO0_BF_TYPE		GENMASK(17, 16)
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88cec54c6c2e..40aa00002885 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2225,8 +2225,12 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
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
@@ -2243,6 +2247,7 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 	ath12k_peer_assoc_h_phymode(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_smps(sta, arg);
 
+	arsta->peer_nss = arg->peer_nss;
 	/* TODO: amsdu_disable req? */
 }
 
@@ -7691,3 +7696,90 @@ void ath12k_mac_destroy(struct ath12k_base *ab)
 		pdev->ar = NULL;
 	}
 }
+
+enum nl80211_he_ru_alloc ath12k_mac_phy_he_ru_to_nl80211_he_ru_alloc(u16 ru_phy)
+{
+	enum nl80211_he_ru_alloc ret;
+
+	switch (ru_phy) {
+	case RU_26:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		break;
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
+	default:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		break;
+	}
+
+	return ret;
+}
+
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
+enum nl80211_he_gi ath12k_mac_he_gi_to_nl80211_he_gi(u8 sgi)
+{
+	enum nl80211_he_gi ret;
+
+	switch (sgi) {
+	case RX_MSDU_START_SGI_0_8_US:
+		ret = NL80211_RATE_INFO_HE_GI_0_8;
+		break;
+	case RX_MSDU_START_SGI_1_6_US:
+		ret = NL80211_RATE_INFO_HE_GI_1_6;
+		break;
+	case RX_MSDU_START_SGI_3_2_US:
+		ret = NL80211_RATE_INFO_HE_GI_3_2;
+		break;
+	default:
+		ret = NL80211_RATE_INFO_HE_GI_0_8;
+		break;
+	}
+
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 7c63bb628adc..061a41b33641 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -76,4 +76,7 @@ enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath12k_bw(enum rate_info_bw b
 enum hal_encrypt_type ath12k_dp_tx_get_encrypt_type(u32 cipher);
 int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable);
 int ath12k_mac_rfkill_config(struct ath12k *ar);
+u32 ath12k_mac_he_gi_to_nl80211_he_gi(u8 sgi);
+enum nl80211_he_ru_alloc ath12k_mac_phy_he_ru_to_nl80211_he_ru_alloc(u16 ru_phy);
+enum nl80211_he_ru_alloc ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones);
 #endif

base-commit: 0dbdc9383054fd3ecbcacfeb364aace3db744314
-- 
2.34.1


