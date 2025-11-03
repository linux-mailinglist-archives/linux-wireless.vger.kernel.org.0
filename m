Return-Path: <linux-wireless+bounces-28495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A2DC2B4BF
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2CA54F0EB0
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A96E2EB87A;
	Mon,  3 Nov 2025 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZjY2I8XS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D23019D6
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168906; cv=none; b=V9alGhAOW28p0c1mpKftQ6Bi/hwksuN6WA7B/ZTlslxOki6xEcva5Z3+jsvdBPiPoJaaZ0B0J64hdFBmDx6c4kcWrxxN3pN7V2Xg47SfhtKRzQ6c4Yt8SGDh0oVq9gDLvEner3JAe7iObG5M5kWwntfNcvGsI2lDfrnvNz5bJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168906; c=relaxed/simple;
	bh=csUxPhl4bIMMlV6On1ftx2TD7UlFZrfOLNQwVgwPr0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lasvMS7bbS2FD7Irga/MpzQmcFYvzDibsswvig2U4jeKcUK65gpdc/E4effIuxOhSx+2Kft2ZNveRK/4GRm41TdiVfTcdLRy1k5oR1Q5d1IyHWKzNQn1iE3yx2zUcUqXjLMZiE56XIm1m4XiExI4gK0rqW43h6LECb1Vg4WyuIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZjY2I8XS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A36Iisd2247242;
	Mon, 3 Nov 2025 11:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SVqkF/Zj38FVmOJBkmvN+ogcZu4BX68jV3oCxTxX7ac=; b=ZjY2I8XSCgUCR4qn
	hTu1s+BV37ZFR8ENHhj/BL39S92+cr+f2NLT9gd5L02dNYLv8BrkKvcTmWxHON8e
	DPdQHiOBCFqiCkowFGZKw1e/6MUnTH5Yrks0uCyjD/JgeJoBE+/oNZkbG3oMd67I
	bM3YkdMilFRvx7nAxjdFNirSp/O44FRdLikzc/qtpzPvLlf2uFwY+0h055yuBjkq
	ylQqhKTMdaBNn/EYhbOxTcyZ4Naewho0A31Z5EKpVb2bPYCs3DAlhxS7S1A+Tynj
	2zyqhlJeipzXP844zeATC8cp0MLFpKKf6BRWXU+twy9FjgsuMP1qakLGDTwAwvp7
	lEu1oA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6q0ygwyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:21:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A3BLe6i005066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 11:21:40 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 3 Nov 2025 03:21:39 -0800
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 03/12] wifi: ath12k: Move DP specific link stats to DP link peer
Date: Mon, 3 Nov 2025 16:51:02 +0530
Message-ID: <20251103112111.2260639-4-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
References: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=NYbrFmD4 c=1 sm=1 tr=0 ts=69089045 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=5RRWBY4WAAAA:8 a=o36MbcGDqfSfNDL-QvgA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=drtMOSl5Q_Tsf-UZi3mY:22 a=poXaRoVlC6wW9_mwW8W4:22
X-Proofpoint-GUID: iEcfqtSDSDnNQvOuM8LhUVfGtIX8J8pO
X-Proofpoint-ORIG-GUID: iEcfqtSDSDnNQvOuM8LhUVfGtIX8J8pO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwMyBTYWx0ZWRfX1vUkEzDLouwT
 UHJfw4CvSVWkF0FTrh9ANmqt32z8aaODhddzjNBB5ZxzNhYpXP3YLIsUwia+KpH7ha96++mRivM
 +Qqzl6RU7bnQ4x/PW7aji2kGjf2EJw8jRJVLTHxNK2sKXJaLC0yujdKcQ+cWIYZBc4gNHw6u6m/
 i631sEzctnDPGK5E5CLB6X7KM2shtFuEQQuOdKWTycCjdcq/9tjei7q/wXPZlia/oz4GrYtWczT
 64CSFY+hswRVnDr0zaNt8hd36Iy41IYnz8fW+mrknDfoe0kOHwKJSFylWzfzJ+ux0GcXO835CpE
 mKw1ha1SvKc3uc6ezArQk7N11LXmddVcTSJSrUgvv56Iwd6Bw1V3iUk803lVI7B83NmE6+Nf2Th
 fKDtLHMU5HjnWh/66KhugVoUxVsGvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030103

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

As part of peer modularization in the Driver Framework, the station view is as
follows:

            Common Path                      Data Path
    -------------------------------------------------------------------
    ath12k_sta                           ath12k_dp_peer
        |                                       |
        |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer
        |                                       |
        |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer
        |                                       |
        |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer

Currently ath12k_link_sta has data path stats updated in tx_htt and rx monitor
path. Move those stats from ath12_link_sta to ath12k_dp_link_peer to align with
peer modularization model as shown above.

This allows datapath to use only ath12k_dp_link_peer without having to reach out
to other objects for updating stats, thereby improving the cache locality.

Add following API to fetch rate info from DP link peer:

	ath12k_dp_link_peer_get_sta_rate_info_stats()

This wrapper API populates link stats in 'struct ath12k_dp_link_peer_rate_info',
which can be extended to support out-of-band retrieval of various rate stats.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h        |  59 ---------
 drivers/net/wireless/ath/ath12k/debugfs_sta.c |  35 +++--
 drivers/net/wireless/ath/ath12k/dp_cmn.h      |  12 ++
 drivers/net/wireless/ath/ath12k/dp_htt.c      |  63 +++++----
 drivers/net/wireless/ath/ath12k/dp_mon.c      |  41 ++----
 drivers/net/wireless/ath/ath12k/dp_peer.c     |  58 ++++++++-
 drivers/net/wireless/ath/ath12k/dp_peer.h     |  56 ++++++++
 drivers/net/wireless/ath/ath12k/hal.h         |   9 ++
 drivers/net/wireless/ath/ath12k/mac.c         | 120 ++++++++++--------
 drivers/net/wireless/ath/ath12k/peer.c        |   3 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  33 ++---
 11 files changed, 281 insertions(+), 208 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index b6ed0e082fc6..e32fc1355c04 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -395,51 +395,8 @@ struct ath12k_vif_iter {
 	struct ath12k_link_vif *arvif;
 };
 
-#define HAL_AST_IDX_INVALID	0xFFFF
-#define HAL_RX_MAX_MCS		12
-#define HAL_RX_MAX_MCS_HT	31
-#define HAL_RX_MAX_MCS_VHT	9
-#define HAL_RX_MAX_MCS_HE	11
-#define HAL_RX_MAX_MCS_BE	15
-#define HAL_RX_MAX_NSS		8
-#define HAL_RX_MAX_NUM_LEGACY_RATES 12
-
 #define ATH12K_SCAN_TIMEOUT_HZ (20 * HZ)
 
-struct ath12k_rx_peer_rate_stats {
-	u64 ht_mcs_count[HAL_RX_MAX_MCS_HT + 1];
-	u64 vht_mcs_count[HAL_RX_MAX_MCS_VHT + 1];
-	u64 he_mcs_count[HAL_RX_MAX_MCS_HE + 1];
-	u64 be_mcs_count[HAL_RX_MAX_MCS_BE + 1];
-	u64 nss_count[HAL_RX_MAX_NSS];
-	u64 bw_count[HAL_RX_BW_MAX];
-	u64 gi_count[HAL_RX_GI_MAX];
-	u64 legacy_count[HAL_RX_MAX_NUM_LEGACY_RATES];
-	u64 rx_rate[HAL_RX_BW_MAX][HAL_RX_GI_MAX][HAL_RX_MAX_NSS][HAL_RX_MAX_MCS_HT + 1];
-};
-
-struct ath12k_rx_peer_stats {
-	u64 num_msdu;
-	u64 num_mpdu_fcs_ok;
-	u64 num_mpdu_fcs_err;
-	u64 tcp_msdu_count;
-	u64 udp_msdu_count;
-	u64 other_msdu_count;
-	u64 ampdu_msdu_count;
-	u64 non_ampdu_msdu_count;
-	u64 stbc_count;
-	u64 beamformed_count;
-	u64 coding_count[HAL_RX_SU_MU_CODING_MAX];
-	u64 tid_count[IEEE80211_NUM_TIDS + 1];
-	u64 pream_cnt[HAL_RX_PREAMBLE_MAX];
-	u64 reception_type[HAL_RX_RECEPTION_TYPE_MAX];
-	u64 rx_duration;
-	u64 dcm_count;
-	u64 ru_alloc_cnt[HAL_RX_RU_ALLOC_TYPE_MAX];
-	struct ath12k_rx_peer_rate_stats pkt_stats;
-	struct ath12k_rx_peer_rate_stats byte_stats;
-};
-
 #define ATH12K_HE_MCS_NUM       12
 #define ATH12K_VHT_MCS_NUM      10
 #define ATH12K_BW_NUM           5
@@ -521,12 +478,6 @@ struct ath12k_per_ppdu_tx_stats {
 	u32 retry_bytes;
 };
 
-struct ath12k_wbm_tx_stats {
-	u64 wbm_tx_comp_stats[HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX];
-};
-
-DECLARE_EWMA(avg_rssi, 10, 8)
-
 struct ath12k_link_sta {
 	struct ath12k_link_vif *arvif;
 	struct ath12k_sta *ahsta;
@@ -541,15 +492,7 @@ struct ath12k_link_sta {
 	u32 smps;
 
 	struct wiphy_work update_wk;
-	struct rate_info txrate;
-	struct rate_info last_txrate;
-	u64 rx_duration;
-	u64 tx_duration;
-	u8 rssi_comb;
-	struct ewma_avg_rssi avg_rssi;
 	u8 link_id;
-	struct ath12k_rx_peer_stats *rx_stats;
-	struct ath12k_wbm_tx_stats *wbm_tx_stats;
 	u32 bw_prev;
 	u32 peer_nss;
 	s8 rssi_beacon;
@@ -559,8 +502,6 @@ struct ath12k_link_sta {
 
 	 /* for firmware use only */
 	u8 link_idx;
-	u32 tx_retry_failed;
-	u32 tx_retry_count;
 
 	/* peer addr based rhashtable list pointer */
 	struct rhash_head rhash_addr;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_sta.c b/drivers/net/wireless/ath/ath12k/debugfs_sta.c
index e6665fd521db..dde3efed4b60 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_sta.c
@@ -11,6 +11,7 @@
 #include "debug.h"
 #include "debugfs_htt_stats.h"
 #include "debugfs.h"
+#include "dp_cmn.h"
 
 static
 u32 ath12k_dbg_sta_dump_rate_stats(u8 *buf, u32 offset, const int size,
@@ -144,9 +145,11 @@ static ssize_t ath12k_dbg_sta_dump_rx_stats(struct file *file,
 	const int size = ATH12K_STA_RX_STATS_BUF_SIZE;
 	struct ath12k_hw *ah = ahsta->ahvif->ah;
 	struct ath12k_rx_peer_stats *rx_stats;
+	struct ath12k_dp_link_peer *link_peer;
 	struct ath12k_link_sta *arsta;
 	u8 link_id = link_sta->link_id;
 	int len = 0, i, ret = 0;
+	struct ath12k_dp *dp;
 	bool he_rates_avail;
 	struct ath12k *ar;
 
@@ -171,9 +174,16 @@ static ssize_t ath12k_dbg_sta_dump_rx_stats(struct file *file,
 		goto out;
 	}
 
-	spin_lock_bh(&ar->ab->base_lock);
+	dp = ath12k_ab_to_dp(ar->ab);
+	spin_lock_bh(&dp->dp_lock);
 
-	rx_stats = arsta->rx_stats;
+	link_peer = ath12k_dp_link_peer_find_by_addr(dp, arsta->addr);
+	if (!link_peer) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	rx_stats = link_peer->peer_stats.rx_stats;
 	if (!rx_stats) {
 		ret = -ENOENT;
 		goto unlock;
@@ -238,7 +248,7 @@ static ssize_t ath12k_dbg_sta_dump_rx_stats(struct file *file,
 					      &rx_stats->byte_stats);
 
 unlock:
-	spin_unlock_bh(&ar->ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	if (len)
 		ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
@@ -261,10 +271,9 @@ static ssize_t ath12k_dbg_sta_reset_rx_stats(struct file *file,
 	struct ieee80211_link_sta *link_sta = file->private_data;
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(link_sta->sta);
 	struct ath12k_hw *ah = ahsta->ahvif->ah;
-	struct ath12k_rx_peer_stats *rx_stats;
-	struct ath12k_link_sta *arsta;
 	u8 link_id = link_sta->link_id;
-	struct ath12k *ar;
+	struct ath12k_link_sta *arsta;
+	struct ath12k_dp *dp;
 	bool reset;
 	int ret;
 
@@ -288,19 +297,9 @@ static ssize_t ath12k_dbg_sta_reset_rx_stats(struct file *file,
 		goto out;
 	}
 
-	ar = arsta->arvif->ar;
-
-	spin_lock_bh(&ar->ab->base_lock);
-
-	rx_stats = arsta->rx_stats;
-	if (!rx_stats) {
-		spin_unlock_bh(&ar->ab->base_lock);
-		ret = -ENOENT;
-		goto out;
-	}
+	dp = ath12k_ab_to_dp(arsta->arvif->ar->ab);
 
-	memset(rx_stats, 0, sizeof(*rx_stats));
-	spin_unlock_bh(&ar->ab->base_lock);
+	ath12k_dp_link_peer_reset_rx_stats(dp, arsta->addr);
 
 	ret = count;
 out:
diff --git a/drivers/net/wireless/ath/ath12k/dp_cmn.h b/drivers/net/wireless/ath/ath12k/dp_cmn.h
index dd10426bd12d..e17f044ff812 100644
--- a/drivers/net/wireless/ath/ath12k/dp_cmn.h
+++ b/drivers/net/wireless/ath/ath12k/dp_cmn.h
@@ -74,6 +74,14 @@ struct ath12k_dp_peer_create_params {
 	bool ucast_ra_only;
 };
 
+struct ath12k_dp_link_peer_rate_info {
+	struct rate_info txrate;
+	u64 rx_duration;
+	u64 tx_duration;
+	u8 rssi_comb;
+	s8 signal_avg;
+};
+
 static inline struct ath12k_dp_link_vif *
 ath12k_dp_vif_to_dp_link_vif(struct ath12k_dp_vif *dp_vif, u8 link_id)
 {
@@ -91,4 +99,8 @@ int ath12k_dp_link_peer_assign(struct ath12k_dp *dp, struct ath12k_dp_hw *dp_hw,
 			       u8 link_id, u32 hw_link_id);
 void ath12k_dp_link_peer_unassign(struct ath12k_dp *dp, struct ath12k_dp_hw *dp_hw,
 				  u8 vdev_id, u8 *addr, u32 hw_link_id);
+void
+ath12k_dp_link_peer_get_sta_rate_info_stats(struct ath12k_dp *dp, const u8 *addr,
+					    struct ath12k_dp_link_peer_rate_info *info);
+void ath12k_dp_link_peer_reset_rx_stats(struct ath12k_dp *dp, const u8 *addr);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index db5ac36adf3d..39f42cd99835 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -189,7 +189,6 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
 	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_base *ab = dp->ab;
 	struct ath12k_dp_link_peer *peer;
-	struct ath12k_link_sta *arsta;
 	struct htt_ppdu_stats_user_rate *user_rate;
 	struct ath12k_per_peer_tx_stats *peer_stats = &dp_pdev->peer_tx_stats;
 	struct htt_ppdu_user_stats *usr_stats = &ppdu_stats->user_stats[user];
@@ -279,66 +278,64 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
 		return;
 	}
 
-	arsta = ath12k_dp_link_peer_to_link_sta(ab, peer);
-	if (!arsta) {
-		rcu_read_unlock();
-		return;
-	}
+	spin_lock_bh(&dp->dp_lock);
 
-	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
+	memset(&peer->txrate, 0, sizeof(peer->txrate));
 
-	arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(bw);
+	peer->txrate.bw = ath12k_mac_bw_to_mac80211_bw(bw);
 
 	switch (flags) {
 	case WMI_RATE_PREAMBLE_OFDM:
-		arsta->txrate.legacy = rate;
+		peer->txrate.legacy = rate;
 		break;
 	case WMI_RATE_PREAMBLE_CCK:
-		arsta->txrate.legacy = rate;
+		peer->txrate.legacy = rate;
 		break;
 	case WMI_RATE_PREAMBLE_HT:
-		arsta->txrate.mcs = mcs + 8 * (nss - 1);
-		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
+		peer->txrate.mcs = mcs + 8 * (nss - 1);
+		peer->txrate.flags = RATE_INFO_FLAGS_MCS;
 		if (sgi)
-			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+			peer->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case WMI_RATE_PREAMBLE_VHT:
-		arsta->txrate.mcs = mcs;
-		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		peer->txrate.mcs = mcs;
+		peer->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
 		if (sgi)
-			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+			peer->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case WMI_RATE_PREAMBLE_HE:
-		arsta->txrate.mcs = mcs;
-		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
-		arsta->txrate.he_dcm = dcm;
-		arsta->txrate.he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
+		peer->txrate.mcs = mcs;
+		peer->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
+		peer->txrate.he_dcm = dcm;
+		peer->txrate.he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
 		tones = le16_to_cpu(user_rate->ru_end) -
 			le16_to_cpu(user_rate->ru_start) + 1;
 		v = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(tones);
-		arsta->txrate.he_ru_alloc = v;
+		peer->txrate.he_ru_alloc = v;
 		if (is_ofdma)
-			arsta->txrate.bw = RATE_INFO_BW_HE_RU;
+			peer->txrate.bw = RATE_INFO_BW_HE_RU;
 		break;
 	case WMI_RATE_PREAMBLE_EHT:
-		arsta->txrate.mcs = mcs;
-		arsta->txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
-		arsta->txrate.he_dcm = dcm;
-		arsta->txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(sgi);
+		peer->txrate.mcs = mcs;
+		peer->txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
+		peer->txrate.he_dcm = dcm;
+		peer->txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(sgi);
 		tones = le16_to_cpu(user_rate->ru_end) -
 			le16_to_cpu(user_rate->ru_start) + 1;
 		v = ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(tones);
-		arsta->txrate.eht_ru_alloc = v;
+		peer->txrate.eht_ru_alloc = v;
 		if (is_ofdma)
-			arsta->txrate.bw = RATE_INFO_BW_EHT_RU;
+			peer->txrate.bw = RATE_INFO_BW_EHT_RU;
 		break;
 	}
 
-	arsta->tx_retry_failed += tx_retry_failed;
-	arsta->tx_retry_count += tx_retry_count;
-	arsta->txrate.nss = nss;
-	arsta->tx_duration += tx_duration;
-	memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info));
+	peer->tx_retry_failed += tx_retry_failed;
+	peer->tx_retry_count += tx_retry_count;
+	peer->txrate.nss = nss;
+	peer->tx_duration += tx_duration;
+	memcpy(&peer->last_txrate, &peer->txrate, sizeof(struct rate_info));
+
+	spin_unlock_bh(&dp->dp_lock);
 
 	/* PPDU stats reported for mgmt packet doesn't have valid tx bytes.
 	 * So skip peer stats update for mgmt packets.
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index b9ccb5462e9d..ded47015c1d0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -3456,6 +3456,9 @@ ath12k_dp_mon_rx_update_peer_rate_table_stats(struct ath12k_rx_peer_stats *rx_st
 	u32 gi_idx = ppdu_info->gi;
 	u32 len;
 
+	if (!rx_stats)
+		return;
+
 	if (mcs_idx > HAL_RX_MAX_MCS_HT || nss_idx >= HAL_RX_MAX_NSS ||
 	    bw_idx >= HAL_RX_BW_MAX || gi_idx >= HAL_RX_GI_MAX) {
 		return;
@@ -3476,14 +3479,14 @@ ath12k_dp_mon_rx_update_peer_rate_table_stats(struct ath12k_rx_peer_stats *rx_st
 	stats->rx_rate[bw_idx][gi_idx][nss_idx][mcs_idx] += len;
 }
 
-static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k_link_sta *arsta,
+static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k_dp_link_peer *peer,
 						  struct hal_rx_mon_ppdu_info *ppdu_info)
 {
-	struct ath12k_rx_peer_stats *rx_stats = arsta->rx_stats;
+	struct ath12k_rx_peer_stats *rx_stats = peer->peer_stats.rx_stats;
 	u32 num_msdu;
 
-	arsta->rssi_comb = ppdu_info->rssi_comb;
-	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
+	peer->rssi_comb = ppdu_info->rssi_comb;
+	ewma_avg_rssi_add(&peer->avg_rssi, ppdu_info->rssi_comb);
 	if (!rx_stats)
 		return;
 
@@ -3531,7 +3534,7 @@ static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k_link_sta *arsta,
 	rx_stats->dcm_count += ppdu_info->dcm;
 
 	rx_stats->rx_duration += ppdu_info->rx_duration;
-	arsta->rx_duration = rx_stats->rx_duration;
+	peer->rx_duration = rx_stats->rx_duration;
 
 	if (ppdu_info->nss > 0 && ppdu_info->nss <= HAL_RX_MAX_NSS) {
 		rx_stats->pkt_stats.nss_count[ppdu_info->nss - 1] += num_msdu;
@@ -3638,7 +3641,6 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k_base *ab,
 				   struct hal_rx_mon_ppdu_info *ppdu_info,
 				   u32 uid)
 {
-	struct ath12k_link_sta *arsta;
 	struct ath12k_rx_peer_stats *rx_stats = NULL;
 	struct hal_rx_user_status *user_stats = &ppdu_info->userstats[uid];
 	struct ath12k_dp_link_peer *peer;
@@ -3656,16 +3658,9 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k_base *ab,
 		return;
 	}
 
-	arsta = ath12k_dp_link_peer_to_link_sta(ab, peer);
-	if (!arsta) {
-		ath12k_warn(ab, "link sta not found on peer %pM id %d\n",
-			    peer->addr, peer->peer_id);
-		return;
-	}
-
-	arsta->rssi_comb = ppdu_info->rssi_comb;
-	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
-	rx_stats = arsta->rx_stats;
+	peer->rssi_comb = ppdu_info->rssi_comb;
+	ewma_avg_rssi_add(&peer->avg_rssi, ppdu_info->rssi_comb);
+	rx_stats = peer->peer_stats.rx_stats;
 	if (!rx_stats)
 		return;
 
@@ -3709,7 +3704,7 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k_base *ab,
 		rx_stats->ru_alloc_cnt[user_stats->ul_ofdma_ru_size] += num_msdu;
 
 	rx_stats->rx_duration += ppdu_info->rx_duration;
-	arsta->rx_duration = rx_stats->rx_duration;
+	peer->rx_duration = rx_stats->rx_duration;
 
 	if (user_stats->nss > 0 && user_stats->nss <= HAL_RX_MAX_NSS) {
 		rx_stats->pkt_stats.nss_count[user_stats->nss - 1] += num_msdu;
@@ -3774,7 +3769,6 @@ int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 	struct dp_srng *mon_dst_ring;
 	struct hal_srng *srng;
 	struct dp_rxdma_mon_ring *buf_ring;
-	struct ath12k_link_sta *arsta;
 	struct ath12k_dp_link_peer *peer;
 	struct sk_buff_head skb_list;
 	u64 cookie;
@@ -3898,16 +3892,7 @@ int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 		}
 
 		if (ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_SU) {
-			arsta = ath12k_dp_link_peer_to_link_sta(ab, peer);
-			if (!arsta) {
-				ath12k_warn(ab, "link sta not found on peer %pM id %d\n",
-					    peer->addr, peer->peer_id);
-				rcu_read_unlock();
-				dev_kfree_skb_any(skb);
-				continue;
-			}
-			ath12k_dp_mon_rx_update_peer_su_stats(arsta,
-							      ppdu_info);
+			ath12k_dp_mon_rx_update_peer_su_stats(peer, ppdu_info);
 		} else if ((ppdu_info->fc_valid) &&
 			   (ppdu_info->ast_index != HAL_AST_IDX_INVALID)) {
 			ath12k_dp_mon_rx_process_ulofdma(ppdu_info);
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index a06113bedf0d..8961c4635ed0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -7,6 +7,7 @@
 #include "core.h"
 #include "dp_peer.h"
 #include "debug.h"
+#include "debugfs.h"
 
 struct ath12k_dp_link_peer *
 ath12k_dp_link_peer_find_by_vdev_and_addr(struct ath12k_dp *dp,
@@ -140,6 +141,8 @@ void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id)
 		   peer->vdev_id, peer->addr, peer_id);
 
 	list_del(&peer->list);
+
+	kfree(peer->peer_stats.rx_stats);
 	kfree(peer);
 	wake_up(&ab->peer_mapping_wq);
 
@@ -152,6 +155,7 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_
 {
 	struct ath12k_dp_link_peer *peer;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k *ar;
 
 	spin_lock_bh(&dp->dp_lock);
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, mac_addr);
@@ -165,10 +169,20 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_
 		peer->ast_hash = ast_hash;
 		peer->hw_peer_id = hw_peer_id;
 		ether_addr_copy(peer->addr, mac_addr);
+
+		rcu_read_lock();
+		ar = ath12k_mac_get_ar_by_vdev_id(ab, vdev_id);
+		if (ar && ath12k_debugfs_is_extd_rx_stats_enabled(ar) &&
+		    !peer->peer_stats.rx_stats) {
+			peer->peer_stats.rx_stats =
+				kzalloc(sizeof(*peer->peer_stats.rx_stats), GFP_ATOMIC);
+		}
+		rcu_read_unlock();
+
 		list_add(&peer->list, &dp->peers);
 		wake_up(&ab->peer_mapping_wq);
+		ewma_avg_rssi_init(&peer->avg_rssi);
 	}
-
 	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "htt peer map vdev %d peer %pM id %d\n",
 		   vdev_id, mac_addr, peer_id);
 
@@ -625,3 +639,45 @@ void ath12k_dp_link_peer_unassign(struct ath12k_dp *dp, struct ath12k_dp_hw *dp_
 
 	synchronize_rcu();
 }
+
+void
+ath12k_dp_link_peer_get_sta_rate_info_stats(struct ath12k_dp *dp, const u8 *addr,
+					    struct ath12k_dp_link_peer_rate_info *info)
+{
+	struct ath12k_dp_link_peer *link_peer;
+
+	guard(spinlock_bh)(&dp->dp_lock);
+
+	link_peer = ath12k_dp_link_peer_find_by_addr(dp, addr);
+	if (!link_peer)
+		return;
+
+	info->rx_duration = link_peer->rx_duration;
+	info->tx_duration = link_peer->tx_duration;
+	info->txrate.legacy = link_peer->txrate.legacy;
+	info->txrate.mcs = link_peer->txrate.mcs;
+	info->txrate.nss = link_peer->txrate.nss;
+	info->txrate.bw = link_peer->txrate.bw;
+	info->txrate.he_gi = link_peer->txrate.he_gi;
+	info->txrate.he_dcm = link_peer->txrate.he_dcm;
+	info->txrate.he_ru_alloc = link_peer->txrate.he_ru_alloc;
+	info->txrate.flags = link_peer->txrate.flags;
+	info->rssi_comb = link_peer->rssi_comb;
+	info->signal_avg = ewma_avg_rssi_read(&link_peer->avg_rssi);
+}
+
+void ath12k_dp_link_peer_reset_rx_stats(struct ath12k_dp *dp, const u8 *addr)
+{
+	struct ath12k_rx_peer_stats *rx_stats;
+	struct ath12k_dp_link_peer *link_peer;
+
+	guard(spinlock_bh)(&dp->dp_lock);
+
+	link_peer = ath12k_dp_link_peer_find_by_addr(dp, addr);
+	if (!link_peer || !link_peer->peer_stats.rx_stats)
+		return;
+
+	rx_stats = link_peer->peer_stats.rx_stats;
+	if (rx_stats)
+		memset(rx_stats, 0, sizeof(*rx_stats));
+}
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.h b/drivers/net/wireless/ath/ath12k/dp_peer.h
index f7c995e8c4e3..f9be27d86545 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.h
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.h
@@ -23,6 +23,51 @@ struct ppdu_user_delayba {
 
 #define ATH12K_PEER_ML_ID_VALID         BIT(13)
 
+struct ath12k_rx_peer_rate_stats {
+	u64 ht_mcs_count[HAL_RX_MAX_MCS_HT + 1];
+	u64 vht_mcs_count[HAL_RX_MAX_MCS_VHT + 1];
+	u64 he_mcs_count[HAL_RX_MAX_MCS_HE + 1];
+	u64 be_mcs_count[HAL_RX_MAX_MCS_BE + 1];
+	u64 nss_count[HAL_RX_MAX_NSS];
+	u64 bw_count[HAL_RX_BW_MAX];
+	u64 gi_count[HAL_RX_GI_MAX];
+	u64 legacy_count[HAL_RX_MAX_NUM_LEGACY_RATES];
+	u64 rx_rate[HAL_RX_BW_MAX][HAL_RX_GI_MAX][HAL_RX_MAX_NSS][HAL_RX_MAX_MCS_HT + 1];
+};
+
+struct ath12k_rx_peer_stats {
+	u64 num_msdu;
+	u64 num_mpdu_fcs_ok;
+	u64 num_mpdu_fcs_err;
+	u64 tcp_msdu_count;
+	u64 udp_msdu_count;
+	u64 other_msdu_count;
+	u64 ampdu_msdu_count;
+	u64 non_ampdu_msdu_count;
+	u64 stbc_count;
+	u64 beamformed_count;
+	u64 coding_count[HAL_RX_SU_MU_CODING_MAX];
+	u64 tid_count[IEEE80211_NUM_TIDS + 1];
+	u64 pream_cnt[HAL_RX_PREAMBLE_MAX];
+	u64 reception_type[HAL_RX_RECEPTION_TYPE_MAX];
+	u64 rx_duration;
+	u64 dcm_count;
+	u64 ru_alloc_cnt[HAL_RX_RU_ALLOC_TYPE_MAX];
+	struct ath12k_rx_peer_rate_stats pkt_stats;
+	struct ath12k_rx_peer_rate_stats byte_stats;
+};
+
+struct ath12k_wbm_tx_stats {
+	u64 wbm_tx_comp_stats[HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX];
+};
+
+struct ath12k_dp_peer_stats {
+	struct ath12k_rx_peer_stats *rx_stats;
+	struct ath12k_wbm_tx_stats *wbm_tx_stats;
+};
+
+DECLARE_EWMA(avg_rssi, 10, 8)
+
 struct ath12k_dp_link_peer {
 	struct list_head list;
 	struct ieee80211_sta *sta;
@@ -58,6 +103,17 @@ struct ath12k_dp_link_peer {
 
 	u8 hw_link_id;
 	u32 rx_tid_active_bitmask;
+
+	/* link stats */
+	struct rate_info txrate;
+	struct rate_info last_txrate;
+	u64 rx_duration;
+	u64 tx_duration;
+	u8 rssi_comb;
+	struct ewma_avg_rssi avg_rssi;
+	struct ath12k_dp_peer_stats peer_stats;
+	u32 tx_retry_failed;
+	u32 tx_retry_count;
 };
 
 void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index dbf07c15481b..69c2e8b318d5 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -64,6 +64,15 @@ struct ath12k_base;
 #define HAL_WBM_IDLE_SCATTER_BUF_SIZE (HAL_WBM_IDLE_SCATTER_BUF_SIZE_MAX - \
 				       HAL_WBM_IDLE_SCATTER_NEXT_PTR_SIZE)
 
+#define HAL_AST_IDX_INVALID    0xFFFF
+#define HAL_RX_MAX_MCS         12
+#define HAL_RX_MAX_MCS_HT      31
+#define HAL_RX_MAX_MCS_VHT     9
+#define HAL_RX_MAX_MCS_HE      11
+#define HAL_RX_MAX_MCS_BE      15
+#define HAL_RX_MAX_NSS         8
+#define HAL_RX_MAX_NUM_LEGACY_RATES 12
+
 enum hal_srng_ring_id {
 	HAL_SRNG_RING_ID_REO2SW0 = 0,
 	HAL_SRNG_RING_ID_REO2SW1,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f55c207c4962..4972367dd1ba 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -23,6 +23,7 @@
 #include "wow.h"
 #include "debugfs_sta.h"
 #include "dp.h"
+#include "dp_cmn.h"
 
 #define CHAN2G(_channel, _freq, _flags) { \
 	.band                   = NL80211_BAND_2GHZ, \
@@ -1213,6 +1214,8 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 
 	list_for_each_entry_safe(peer, tmp, &peers, list) {
 		list_del(&peer->list);
+
+		kfree(peer->peer_stats.rx_stats);
 		kfree(peer);
 	}
 
@@ -6375,14 +6378,13 @@ static void ath12k_mac_station_post_remove(struct ath12k *ar,
 			    vif->addr, arvif->vdev_id);
 		peer->sta = NULL;
 		list_del(&peer->list);
+
+		kfree(peer->peer_stats.rx_stats);
 		kfree(peer);
 		ar->num_peers--;
 	}
 
 	spin_unlock_bh(&dp->dp_lock);
-
-	kfree(arsta->rx_stats);
-	arsta->rx_stats = NULL;
 }
 
 static int ath12k_mac_station_unauthorize(struct ath12k *ar,
@@ -6527,14 +6529,6 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 		goto exit;
 	}
 
-	if (ath12k_debugfs_is_extd_rx_stats_enabled(ar) && !arsta->rx_stats) {
-		arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
-		if (!arsta->rx_stats) {
-			ret = -ENOMEM;
-			goto dec_num_station;
-		}
-	}
-
 	spin_lock_bh(&ab->base_lock);
 
 	/*
@@ -6552,7 +6546,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 	if (ret) {
 		ath12k_warn(ab, "Failed to add arsta: %pM to hash table, ret: %d",
 			    arsta->addr, ret);
-		goto free_rx_stats;
+		goto dec_num_station;
 	}
 
 	peer_param.vdev_id = arvif->vdev_id;
@@ -6598,7 +6592,6 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 		}
 	}
 
-	ewma_avg_rssi_init(&arsta->avg_rssi);
 	return 0;
 
 free_peer:
@@ -6606,9 +6599,6 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 	spin_lock_bh(&ab->base_lock);
 	ath12k_link_sta_rhash_delete(ab, arsta);
 	spin_unlock_bh(&ab->base_lock);
-free_rx_stats:
-	kfree(arsta->rx_stats);
-	arsta->rx_stats = NULL;
 dec_num_station:
 	ath12k_mac_dec_num_stations(arvif, arsta);
 exit:
@@ -12888,9 +12878,12 @@ void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 				  struct station_info *sinfo)
 {
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+	struct ath12k_dp_link_peer_rate_info rate_info = {};
 	struct ath12k_fw_stats_req_params params = {};
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_link_sta *arsta;
 	s8 signal, noise_floor;
+	struct ath12k_dp *dp;
 	struct ath12k *ar;
 	bool db2dbm;
 
@@ -12901,34 +12894,37 @@ void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	if (!ar)
 		return;
 
+	dp = ath12k_ab_to_dp(ar->ab);
+	ath12k_dp_link_peer_get_sta_rate_info_stats(dp, arsta->addr, &rate_info);
+
 	db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
 			  ar->ab->wmi_ab.svc_map);
 
-	sinfo->rx_duration = arsta->rx_duration;
+	sinfo->rx_duration = rate_info.rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
 
-	sinfo->tx_duration = arsta->tx_duration;
+	sinfo->tx_duration = rate_info.tx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
 
-	if (arsta->txrate.legacy || arsta->txrate.nss) {
-		if (arsta->txrate.legacy) {
-			sinfo->txrate.legacy = arsta->txrate.legacy;
+	if (rate_info.txrate.legacy || rate_info.txrate.nss) {
+		if (rate_info.txrate.legacy) {
+			sinfo->txrate.legacy = rate_info.txrate.legacy;
 		} else {
-			sinfo->txrate.mcs = arsta->txrate.mcs;
-			sinfo->txrate.nss = arsta->txrate.nss;
-			sinfo->txrate.bw = arsta->txrate.bw;
-			sinfo->txrate.he_gi = arsta->txrate.he_gi;
-			sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
-			sinfo->txrate.he_ru_alloc = arsta->txrate.he_ru_alloc;
-			sinfo->txrate.eht_gi = arsta->txrate.eht_gi;
-			sinfo->txrate.eht_ru_alloc = arsta->txrate.eht_ru_alloc;
-		}
-		sinfo->txrate.flags = arsta->txrate.flags;
+			sinfo->txrate.mcs = rate_info.txrate.mcs;
+			sinfo->txrate.nss = rate_info.txrate.nss;
+			sinfo->txrate.bw = rate_info.txrate.bw;
+			sinfo->txrate.he_gi = rate_info.txrate.he_gi;
+			sinfo->txrate.he_dcm = rate_info.txrate.he_dcm;
+			sinfo->txrate.he_ru_alloc = rate_info.txrate.he_ru_alloc;
+			sinfo->txrate.eht_gi = rate_info.txrate.eht_gi;
+			sinfo->txrate.eht_ru_alloc = rate_info.txrate.eht_ru_alloc;
+		}
+		sinfo->txrate.flags = rate_info.txrate.flags;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
 
 	/* TODO: Use real NF instead of default one. */
-	signal = arsta->rssi_comb;
+	signal = rate_info.rssi_comb;
 
 	params.pdev_id = ar->pdev->pdev_id;
 	params.vdev_id = 0;
@@ -12948,17 +12944,26 @@ void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 	}
 
-	sinfo->signal_avg = ewma_avg_rssi_read(&arsta->avg_rssi);
+	sinfo->signal_avg = rate_info.signal_avg;
 
 	if (!db2dbm)
 		sinfo->signal_avg += noise_floor;
 
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 
-	sinfo->tx_retries = arsta->tx_retry_count;
-	sinfo->tx_failed = arsta->tx_retry_failed;
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_addr(dp, arsta->addr);
+	if (!peer) {
+		spin_unlock_bh(&dp->dp_lock);
+		return;
+	}
+
+	sinfo->tx_retries = peer->tx_retry_count;
+	sinfo->tx_failed = peer->tx_retry_failed;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+
+	spin_unlock_bh(&dp->dp_lock);
 }
 EXPORT_SYMBOL(ath12k_mac_op_sta_statistics);
 
@@ -12969,6 +12974,7 @@ void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 {
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(link_sta->sta);
 	struct ath12k_fw_stats_req_params params = {};
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_link_sta *arsta;
 	struct ath12k *ar;
 	s8 signal;
@@ -12988,33 +12994,40 @@ void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 	db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
 			  ar->ab->wmi_ab.svc_map);
 
-	link_sinfo->rx_duration = arsta->rx_duration;
+	spin_lock_bh(&ar->ab->dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_addr(ar->ab->dp, arsta->addr);
+	if (!peer) {
+		spin_unlock_bh(&ar->ab->dp->dp_lock);
+		return;
+	}
+
+	link_sinfo->rx_duration = peer->rx_duration;
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
 
-	link_sinfo->tx_duration = arsta->tx_duration;
+	link_sinfo->tx_duration = peer->tx_duration;
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
 
-	if (arsta->txrate.legacy || arsta->txrate.nss) {
-		if (arsta->txrate.legacy) {
-			link_sinfo->txrate.legacy = arsta->txrate.legacy;
+	if (peer->txrate.legacy || peer->txrate.nss) {
+		if (peer->txrate.legacy) {
+			link_sinfo->txrate.legacy = peer->txrate.legacy;
 		} else {
-			link_sinfo->txrate.mcs = arsta->txrate.mcs;
-			link_sinfo->txrate.nss = arsta->txrate.nss;
-			link_sinfo->txrate.bw = arsta->txrate.bw;
-			link_sinfo->txrate.he_gi = arsta->txrate.he_gi;
-			link_sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
+			link_sinfo->txrate.mcs = peer->txrate.mcs;
+			link_sinfo->txrate.nss = peer->txrate.nss;
+			link_sinfo->txrate.bw = peer->txrate.bw;
+			link_sinfo->txrate.he_gi = peer->txrate.he_gi;
+			link_sinfo->txrate.he_dcm = peer->txrate.he_dcm;
 			link_sinfo->txrate.he_ru_alloc =
-				arsta->txrate.he_ru_alloc;
-			link_sinfo->txrate.eht_gi = arsta->txrate.eht_gi;
+				peer->txrate.he_ru_alloc;
+			link_sinfo->txrate.eht_gi = peer->txrate.eht_gi;
 			link_sinfo->txrate.eht_ru_alloc =
-				arsta->txrate.eht_ru_alloc;
+				peer->txrate.eht_ru_alloc;
 		}
-		link_sinfo->txrate.flags = arsta->txrate.flags;
+		link_sinfo->txrate.flags = peer->txrate.flags;
 		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
 
 	/* TODO: Use real NF instead of default one. */
-	signal = arsta->rssi_comb;
+	signal = peer->rssi_comb;
 
 	params.pdev_id = ar->pdev->pdev_id;
 	params.vdev_id = 0;
@@ -13031,17 +13044,18 @@ void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 	}
 
-	link_sinfo->signal_avg = ewma_avg_rssi_read(&arsta->avg_rssi);
+	link_sinfo->signal_avg = ewma_avg_rssi_read(&peer->avg_rssi);
 
 	if (!db2dbm)
 		link_sinfo->signal_avg += ATH12K_DEFAULT_NOISE_FLOOR;
 
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 
-	link_sinfo->tx_retries = arsta->tx_retry_count;
-	link_sinfo->tx_failed = arsta->tx_retry_failed;
+	link_sinfo->tx_retries = peer->tx_retry_count;
+	link_sinfo->tx_failed = peer->tx_retry_failed;
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+	spin_unlock_bh(&ar->ab->dp->dp_lock);
 }
 EXPORT_SYMBOL(ath12k_mac_op_link_sta_statistics);
 
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 812247decab4..9c100ecea798 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -7,6 +7,7 @@
 #include "core.h"
 #include "peer.h"
 #include "debug.h"
+#include "debugfs.h"
 
 static int ath12k_wait_for_dp_link_peer_common(struct ath12k_base *ab, int vdev_id,
 					       const u8 *addr, bool expect_mapped)
@@ -50,6 +51,8 @@ void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id)
 			    peer->addr, vdev_id);
 
 		list_del(&peer->list);
+
+		kfree(peer->peer_stats.rx_stats);
 		kfree(peer);
 		ar->num_peers--;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 454d5a7532cf..737651341afc 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -517,31 +517,36 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 					      struct hal_tx_status *ts)
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
+	struct ath12k_dp_link_peer *peer;
 	struct ath12k_base *ab = dp->ab;
-	struct ath12k_dp_peer *peer;
-	struct ieee80211_sta *sta;
-	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
 	struct rate_info txrate = {};
+	struct ieee80211_sta *sta;
+	struct ath12k_sta *ahsta;
 	u16 rate, ru_tones;
 	u8 rate_idx = 0;
 	int ret;
 
-	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, ts->peer_id);
+	peer = ath12k_dp_link_peer_find_by_peerid(dp_pdev, ts->peer_id);
 	if (!peer || !peer->sta) {
 		ath12k_dbg(ab, ATH12K_DBG_DP_TX,
 			   "failed to find the peer by id %u\n", ts->peer_id);
 		return;
 	}
+
+	spin_lock_bh(&dp->dp_lock);
+
 	sta = peer->sta;
 	ahsta = ath12k_sta_to_ahsta(sta);
 	arsta = &ahsta->deflink;
 
+	spin_unlock_bh(&dp->dp_lock);
+
 	/* This is to prefer choose the real NSS value arsta->last_txrate.nss,
 	 * if it is invalid, then choose the NSS value while assoc.
 	 */
-	if (arsta->last_txrate.nss)
-		txrate.nss = arsta->last_txrate.nss;
+	if (peer->last_txrate.nss)
+		txrate.nss = peer->last_txrate.nss;
 	else
 		txrate.nss = arsta->peer_nss;
 
@@ -625,9 +630,9 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 			ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(ts->tones);
 	}
 
-	spin_lock_bh(&ab->base_lock);
-	arsta->txrate = txrate;
-	spin_unlock_bh(&ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
+	peer->txrate = txrate;
+	spin_unlock_bh(&dp->dp_lock);
 }
 
 static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
@@ -646,9 +651,7 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 	s32 noise_floor;
 	struct ieee80211_tx_status status = {};
 	struct ieee80211_rate_status status_rate = {};
-	struct ath12k_dp_peer *peer;
-	struct ath12k_link_sta *arsta;
-	struct ath12k_sta *ahsta;
+	struct ath12k_dp_link_peer *peer;
 	struct rate_info rate;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
@@ -743,7 +746,7 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 
 	ath12k_wifi7_dp_tx_update_txcompl(dp_pdev, ts);
 
-	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, ts->peer_id);
+	peer = ath12k_dp_link_peer_find_by_peerid(dp_pdev, ts->peer_id);
 	if (!peer || !peer->sta) {
 		ath12k_err(ab,
 			   "dp_tx: failed to find the peer with peer_id %d\n",
@@ -751,13 +754,11 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 		ieee80211_free_txskb(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 		goto exit;
 	}
-	ahsta = ath12k_sta_to_ahsta(peer->sta);
-	arsta = &ahsta->deflink;
 
 	status.sta = peer->sta;
 	status.info = info;
 	status.skb = msdu;
-	rate = arsta->last_txrate;
+	rate = peer->last_txrate;
 
 	status_rate.rate_idx = rate;
 	status_rate.try_count = 1;
-- 
2.34.1


