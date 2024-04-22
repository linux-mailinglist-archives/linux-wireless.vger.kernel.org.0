Return-Path: <linux-wireless+bounces-6665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB468ACD96
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 14:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1FBB25D02
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 12:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022E314F11D;
	Mon, 22 Apr 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LFJirNh7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278E14A61A
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790625; cv=none; b=ijQobwoovjiNjp4mOigCUsysrUzNO5n3oi/lEApJ1pG+PhQeBl0vgvkaKc/FjpwBGwz5xB/7UWXUGVkYlwqt7YXW/B0Ugex8n4DbprLly8y5gMq6bDjgL3plCU4RatpHT9RuTogX1jKDxfjj/5ze9Vj88Tf6lN9Zth9+ntabDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790625; c=relaxed/simple;
	bh=YouGwxLD2VelTPXZ3WcTKeZNScCImoRM1f+fNdZlZdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5tivYLTd6eB2Qh44wpfssJ+i/hq3OJgWh//BRCpOS2VMubcYjfUPZpxdlyISIzW0jHlrMUZhEcngRRQK5sUBvFeMALqLuVqs5H55VmiNqKgUgZy3gY2UNmIN/R0S+N3kxs2vhPhsrMGsCQRggBIANYZrNBgKezkG1WcsJx/1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LFJirNh7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M81ubJ002828;
	Mon, 22 Apr 2024 12:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=gi5Y4+eXyOBaZ6Nt6MFxxNLJRciVPg9YrpMhUZc9Fkw=; b=LF
	JirNh70BgmGF+oc1aaoQXybR5NIIHxjNltARDq72armF32etuuV8wTPNz3kI7tYD
	8q2zVS/otDr/BIgzdIq/L8XyypnwExDYyJ6x1ZXRdwTDSbqKxqspzUOYz6+G1k+b
	0ZIALRzd3AHeDkBEu8vhdDcJg+TD3UXLzgK2coNdKw+4P+IlEVXQVgQYjM/Z9ooF
	ptoJoposVkRWNhLXWpbYTGek5WHlGF2VELecP/5pMszCNJJ6JJ29QjHEpgiiGgNQ
	NfD3uTjigIXGDSdlLh9U1irnIbP6aexw6JPOmAXycRFBkkDlnINZo64Vemys25s2
	LY9XqQoq3Hoy3xKXRepw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnm1bgqfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:56:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MCuvqN002397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:56:57 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 05:56:55 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH 3/3] wifi: ath12k: prepare sta data structure for MLO handling
Date: Mon, 22 Apr 2024 18:26:30 +0530
Message-ID: <20240422125630.1469456-4-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422125630.1469456-1-quic_ramess@quicinc.com>
References: <20240422125630.1469456-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: XhLiuGmD9oFD0CPFHpF5MJJ6IcllqPO9
X-Proofpoint-ORIG-GUID: XhLiuGmD9oFD0CPFHpF5MJJ6IcllqPO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220057

From: Sriram R <quic_srirrama@quicinc.com>

To prepare the driver for MLO support, split the driver sta
data structure to scale for multiple links. This requires changing
the use of arsta to per link and not per hw which can now
comprise of multiple links.
Also since most configurations from mac80211 are done per link,
do refactoring of the driver functions to apply these configurations
at link level.

Split ath12k_sta which is the driver private of ieee80211_sta to store
link specific information as ath12k_link_sta. For default use cases
the ath12k_sta will have a preallocated link sta called deflink which will
be used by non ML STAs and the first link sta of ML STA.

With MLO Support to be added, remaining link stas will allocated during
state change where new STA is added. These link stas will be freed when
STA is deleted.

		Current ath12k_sta(arsta) structure

	 +-----------------+       +----------------+
	 |                 |       |                |
	 |   ieee80211_sta |       |  ieee80211_sta |
	 |   private data  |       |  private data  |
	 |                 |       |                |
	 |   ath12k_sta    |       |  ath12k_sta    |
	 |   (arsta)       |       |   (arsta)      |
	 |+---------------+|       | +-------------+|
	 || *arvif (link  ||       | |*arvif (link ||
	 || vif of an ar  ||       | | vif of an ar||
	 || say 5GHz)     ||       | | say 6GHz)   ||
	 |+---------------+|       | +-------------+|
	 +-----------------+       +----------------+

	Proposed ath12k_sta(ahsta) containing ath12k_link_sta(s) (arsta)
	(deflink is preallocated member which is always the first link if
	 ieee80211_sta is ML STA and is the only link sta otherwise)

		+---------------------------------------+
		|         ieee80211_sta                 |
		|         private data                  |
		|                                       |
		|         ath12k_sta (ahsta)            |
		| +-------------------------------------+
		| | ath12k_link_sta deflink (arsta)     |
		| |                                     |
		| |  *arvif (link vif of ar (5GHz))     |
		| +-------------------------------------+
		| +-------------------------------------+
		| | ath12k_link_sta *link (arsta)       |
		| |                                     |
		| |   *arvif (link vif of ar (6GHz))    |
		| |                                     |
		| +-------------------------------------+
		|                                       |
		+---------------------------------------+

To refactor existing ath12k_sta to make use of link stas, following
 changes are made,

 1. Limit ieee80211_sta argument mac80211 ops unless otherwise really required.

 2. ath12k_sta now called by variable name arsta stores multiple
    arstas(ah12k_link_sta) and also has a back pointer to ath12k_sta

 3. Pass ath12k_link_sta to mac functions that passed ieee80211_sta arg
    and fetch ath12k_sta(ahsta) and sta(ieee80211_sta) internally.
    This is done to avoid passing link id in all the functions and performing
    validation across these functions.
    Rather the validation and sta to arsta conversion can be done only at the
    mac80211 ops.

 4. In this patchset, only ahsta->deflink is used to be on par with the
    existing code. When MLO support is added the link id will be used to fetch
    the arsta.

 5. Change ath12k_sta_to_arsta() to ath12k_vif_to_ahsta() to fetch the
    ML level sta. The link sta can be fetched from ahsta->link[], or the
    deflink can be accessed via ahsta->deflink. API to access link
    sta (arsta) by passing link_id can be introduced with MLO Support.

 6. The ieee80211_sta can be accessed from ahsta using ath12k_sta_to_sta()

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h   |  24 ++-
 drivers/net/wireless/ath/ath12k/dp_mon.c |  14 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |  14 +-
 drivers/net/wireless/ath/ath12k/mac.c    | 185 +++++++++++++++--------
 4 files changed, 162 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index c599eb37e5cc..d115ce51ff97 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -440,15 +440,15 @@ struct ath12k_wbm_tx_stats {
 	u64 wbm_tx_comp_stats[HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX];
 };
 
-struct ath12k_sta {
+struct ath12k_link_sta {
 	struct ath12k_link_vif *arvif;
+	struct ath12k_sta *ahsta;
 
 	/* the following are protected by ar->data_lock */
 	u32 changed; /* IEEE80211_RC_* */
 	u32 bw;
 	u32 nss;
 	u32 smps;
-	enum hal_pn_type pn_type;
 
 	struct work_struct update_wk;
 	struct rate_info txrate;
@@ -456,11 +456,20 @@ struct ath12k_sta {
 	u64 rx_duration;
 	u64 tx_duration;
 	u8 rssi_comb;
+	u8 link_id;
 	struct ath12k_rx_peer_stats *rx_stats;
 	struct ath12k_wbm_tx_stats *wbm_tx_stats;
 	u32 bw_prev;
 };
 
+struct ath12k_sta {
+	enum hal_pn_type pn_type;
+	struct ath12k_link_sta deflink;
+	struct ath12k_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	/* indicates bitmap of link sta created in FW */
+	u16 links_map;
+};
+
 #define ATH12K_MIN_5G_FREQ 4150
 #define ATH12K_MIN_6G_FREQ 5925
 #define ATH12K_MAX_6G_FREQ 7115
@@ -649,8 +658,8 @@ struct ath12k_hw {
 	bool regd_updated;
 	bool use_6ghz_regd;
 
-	/* To synchronize concurrent access of ahvif->link[]
-	 * between mac80211 operations.
+	/* To synchronize concurrent access of ahvif->link[] and
+	 * ahsta->link[] between mac80211 operations.
 	 */
 	struct mutex conf_mutex;
 	u8 num_radio;
@@ -987,11 +996,16 @@ static inline struct ath12k_vif *ath12k_vif_to_ahvif(struct ieee80211_vif *vif)
 	return (struct ath12k_vif *)vif->drv_priv;
 }
 
-static inline struct ath12k_sta *ath12k_sta_to_arsta(struct ieee80211_sta *sta)
+static inline struct ath12k_sta *ath12k_sta_to_ahsta(struct ieee80211_sta *sta)
 {
 	return (struct ath12k_sta *)sta->drv_priv;
 }
 
+static inline struct ieee80211_sta *ath12k_sta_to_sta(struct ath12k_sta *ahsta)
+{
+	return container_of((void *)ahsta, struct ieee80211_sta, drv_priv);
+}
+
 static inline struct ieee80211_vif *ath12k_vif_to_vif(struct ath12k_vif *ahvif)
 {
 	return container_of((void *)ahvif, struct ieee80211_vif, drv_priv);
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 6b0b72477540..ae76b999a4ca 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2203,7 +2203,7 @@ ath12k_dp_mon_rx_update_peer_rate_table_stats(struct ath12k_rx_peer_stats *rx_st
 }
 
 static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k *ar,
-						  struct ath12k_sta *arsta,
+						  struct ath12k_link_sta *arsta,
 						  struct hal_rx_mon_ppdu_info *ppdu_info)
 {
 	struct ath12k_rx_peer_stats *rx_stats = arsta->rx_stats;
@@ -2359,7 +2359,8 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 				   struct hal_rx_mon_ppdu_info *ppdu_info,
 				   u32 uid)
 {
-	struct ath12k_sta *arsta = NULL;
+	struct ath12k_sta *ahsta;
+	struct ath12k_link_sta *arsta;
 	struct ath12k_rx_peer_stats *rx_stats = NULL;
 	struct hal_rx_user_status *user_stats = &ppdu_info->userstats[uid];
 	struct ath12k_peer *peer;
@@ -2376,7 +2377,8 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 		return;
 	}
 
-	arsta = ath12k_sta_to_arsta(peer->sta);
+	ahsta = ath12k_sta_to_ahsta(peer->sta);
+	arsta = &ahsta->deflink;
 	rx_stats = arsta->rx_stats;
 
 	if (!rx_stats)
@@ -2483,7 +2485,8 @@ int ath12k_dp_mon_rx_process_stats(struct ath12k *ar, int mac_id,
 	struct dp_srng *mon_dst_ring;
 	struct hal_srng *srng;
 	struct dp_rxdma_mon_ring *buf_ring;
-	struct ath12k_sta *arsta = NULL;
+	struct ath12k_sta *ahsta = NULL;
+	struct ath12k_link_sta *arsta;
 	struct ath12k_peer *peer;
 	u64 cookie;
 	int num_buffs_reaped = 0, srng_id, buf_id;
@@ -2552,7 +2555,8 @@ int ath12k_dp_mon_rx_process_stats(struct ath12k *ar, int mac_id,
 			}
 
 			if (ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_SU) {
-				arsta = ath12k_sta_to_arsta(peer->sta);
+				ahsta = ath12k_sta_to_ahsta(peer->sta);
+				arsta = &ahsta->deflink;
 				ath12k_dp_mon_rx_update_peer_su_stats(ar, arsta,
 								      ppdu_info);
 			} else if ((ppdu_info->fc_valid) &&
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 980358342ac1..f26a6e4b9255 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1086,13 +1086,14 @@ int ath12k_dp_rx_ampdu_start(struct ath12k *ar,
 			     struct ieee80211_ampdu_params *params)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_sta *arsta = ath12k_sta_to_arsta(params->sta);
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(params->sta);
+	struct ath12k_link_sta *arsta = &ahsta->deflink;
 	int vdev_id = arsta->arvif->vdev_id;
 	int ret;
 
 	ret = ath12k_dp_rx_peer_tid_setup(ar, params->sta->addr, vdev_id,
 					  params->tid, params->buf_size,
-					  params->ssn, arsta->pn_type);
+					  params->ssn, arsta->ahsta->pn_type);
 	if (ret)
 		ath12k_warn(ab, "failed to setup rx tid %d\n", ret);
 
@@ -1104,7 +1105,8 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_peer *peer;
-	struct ath12k_sta *arsta = ath12k_sta_to_arsta(params->sta);
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(params->sta);
+	struct ath12k_link_sta *arsta = &ahsta->deflink;
 	int vdev_id = arsta->arvif->vdev_id;
 	bool active;
 	int ret;
@@ -1358,7 +1360,8 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_peer *peer;
 	struct ieee80211_sta *sta;
-	struct ath12k_sta *arsta;
+	struct ath12k_sta *ahsta;
+	struct ath12k_link_sta *arsta;
 	struct htt_ppdu_stats_user_rate *user_rate;
 	struct ath12k_per_peer_tx_stats *peer_stats = &ar->peer_tx_stats;
 	struct htt_ppdu_user_stats *usr_stats = &ppdu_stats->user_stats[user];
@@ -1439,7 +1442,8 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	}
 
 	sta = peer->sta;
-	arsta = ath12k_sta_to_arsta(sta);
+	ahsta = ath12k_sta_to_ahsta(sta);
+	arsta = &ahsta->deflink;
 
 	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 49ee2c724160..845c968941e8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1408,10 +1408,11 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 
 static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
 				      struct ath12k_link_vif *arvif,
-				      struct ieee80211_sta *sta,
+				      struct ath12k_link_sta *arsta,
 				      struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	u32 aid;
 
@@ -1434,10 +1435,11 @@ static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
 
 static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
 				       struct ath12k_link_vif *arvif,
-				       struct ieee80211_sta *sta,
+				       struct ath12k_link_sta *arsta,
 				       struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_bss_conf *info = &vif->bss_conf;
 	struct cfg80211_chan_def def;
@@ -1497,10 +1499,11 @@ static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
 
 static void ath12k_peer_assoc_h_rates(struct ath12k *ar,
 				      struct ath12k_link_vif *arvif,
-				      struct ieee80211_sta *sta,
+				      struct ath12k_link_sta *arsta,
 				      struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	struct wmi_rate_set_arg *rateset = &arg->peer_legacy_rates;
 	struct cfg80211_chan_def def;
 	const struct ieee80211_supported_band *sband;
@@ -1560,10 +1563,11 @@ ath12k_peer_assoc_h_vht_masked(const u16 *vht_mcs_mask)
 
 static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 				   struct ath12k_link_vif *arvif,
-				   struct ieee80211_sta *sta,
+				   struct ath12k_link_sta *arsta,
 				   struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
@@ -1721,10 +1725,11 @@ ath12k_peer_assoc_h_vht_limit(u16 tx_mcs_set,
 
 static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 				    struct ath12k_link_vif *arvif,
-				    struct ieee80211_sta *sta,
+				    struct ath12k_link_sta *arsta,
 				    struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
@@ -1816,10 +1821,11 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 
 static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 				   struct ath12k_link_vif *arvif,
-				   struct ieee80211_sta *sta,
+				   struct ath12k_link_sta *arsta,
 				   struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
 	int i;
 	u8 ampdu_factor, rx_mcs_80, rx_mcs_160, max_nss;
@@ -1969,9 +1975,10 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	}
 }
 
-static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
+static void ath12k_peer_assoc_h_smps(struct ath12k_link_sta *arsta,
 				     struct ath12k_wmi_peer_assoc_arg *arg)
 {
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
 	int smps;
 
@@ -1998,9 +2005,11 @@ static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
 
 static void ath12k_peer_assoc_h_qos(struct ath12k *ar,
 				    struct ath12k_link_vif *arvif,
-				    struct ieee80211_sta *sta,
+				    struct ath12k_link_sta *arsta,
 				    struct ath12k_wmi_peer_assoc_arg *arg)
 {
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
+
 	switch (arvif->ahvif->vdev_type) {
 	case WMI_VDEV_TYPE_AP:
 		if (sta->wme) {
@@ -2032,8 +2041,9 @@ static void ath12k_peer_assoc_h_qos(struct ath12k *ar,
 
 static int ath12k_peer_assoc_qos_ap(struct ath12k *ar,
 				    struct ath12k_link_vif *arvif,
-				    struct ieee80211_sta *sta)
+				    struct ath12k_link_sta *arsta)
 {
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	struct ath12k_wmi_ap_ps_arg arg;
 	u32 max_sp;
 	u32 uapsd;
@@ -2194,7 +2204,7 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_eht(struct ath12k *ar,
 
 static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 					struct ath12k_link_vif *arvif,
-					struct ieee80211_sta *sta,
+					struct ath12k_link_sta *arsta,
 					struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	struct cfg80211_chan_def def;
@@ -2203,6 +2213,7 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	const u16 *vht_mcs_mask;
 	enum wmi_phy_mode phymode = MODE_UNKNOWN;
 	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
@@ -2339,9 +2350,10 @@ static void ath12k_mac_set_eht_ppe_threshold(const u8 *ppe_thres,
 
 static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 				    struct ath12k_link_vif *arvif,
-				    struct ieee80211_sta *sta,
+				    struct ath12k_link_sta *arsta,
 				    struct ath12k_wmi_peer_assoc_arg *arg)
 {
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	const struct ieee80211_sta_eht_cap *eht_cap = &sta->deflink.eht_cap;
 	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
 	const struct ieee80211_eht_mcs_nss_supp_20mhz_only *bw_20;
@@ -2421,7 +2433,7 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 
 static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 				      struct ath12k_link_vif *arvif,
-				      struct ieee80211_sta *sta,
+				      struct ath12k_link_sta *arsta,
 				      struct ath12k_wmi_peer_assoc_arg *arg,
 				      bool reassoc)
 {
@@ -2432,16 +2444,16 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 	reinit_completion(&ar->peer_assoc_done);
 
 	arg->peer_new_assoc = !reassoc;
-	ath12k_peer_assoc_h_basic(ar, arvif, sta, arg);
-	ath12k_peer_assoc_h_crypto(ar, arvif, sta, arg);
-	ath12k_peer_assoc_h_rates(ar, arvif, sta, arg);
-	ath12k_peer_assoc_h_ht(ar, arvif, sta, arg);
-	ath12k_peer_assoc_h_vht(ar, arvif, sta, arg);
-	ath12k_peer_assoc_h_he(ar, arvif, sta, arg);
-	ath12k_peer_assoc_h_eht(ar, arvif, sta, arg);
-	ath12k_peer_assoc_h_qos(ar, arvif, sta, arg);
-	ath12k_peer_assoc_h_phymode(ar, arvif, sta, arg);
-	ath12k_peer_assoc_h_smps(sta, arg);
+	ath12k_peer_assoc_h_basic(ar, arvif, arsta, arg);
+	ath12k_peer_assoc_h_crypto(ar, arvif, arsta, arg);
+	ath12k_peer_assoc_h_rates(ar, arvif, arsta, arg);
+	ath12k_peer_assoc_h_ht(ar, arvif, arsta, arg);
+	ath12k_peer_assoc_h_vht(ar, arvif, arsta, arg);
+	ath12k_peer_assoc_h_he(ar, arvif, arsta, arg);
+	ath12k_peer_assoc_h_eht(ar, arvif, arsta, arg);
+	ath12k_peer_assoc_h_qos(ar, arvif, arsta, arg);
+	ath12k_peer_assoc_h_phymode(ar, arvif, arsta, arg);
+	ath12k_peer_assoc_h_smps(arsta, arg);
 
 	/* TODO: amsdu_disable req? */
 }
@@ -2473,7 +2485,9 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_vif_to_vif(ahvif);
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
+	struct ath12k_link_sta *arsta;
 	struct ieee80211_sta *ap_sta;
+	struct ath12k_sta *ahsta;
 	struct ath12k_peer *peer;
 	bool is_auth = false;
 	int ret;
@@ -2493,7 +2507,15 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 		return;
 	}
 
-	ath12k_peer_assoc_prepare(ar, arvif, ap_sta, &peer_arg, false);
+	ahsta = ath12k_sta_to_ahsta(ap_sta);
+	arsta = &ahsta->deflink;
+
+	if (WARN_ON(!arsta)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	ath12k_peer_assoc_prepare(ar, arvif, arsta, &peer_arg, false);
 
 	rcu_read_unlock();
 
@@ -3586,20 +3608,25 @@ static int ath12k_clear_peer_keys(struct ath12k_link_vif *arvif,
 }
 
 static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
-			      struct ath12k_link_vif *arvif, struct ieee80211_sta *sta,
+			      struct ath12k_link_vif *arvif,
+			      struct ath12k_link_sta *arsta,
 			      struct ieee80211_key_conf *key)
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_vif_to_vif(ahvif);
+	struct ieee80211_sta *sta = NULL;
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_peer *peer;
-	struct ath12k_sta *arsta;
+	struct ath12k_sta *ahsta;
 	const u8 *peer_addr;
 	int ret = 0;
 	u32 flags = 0;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
+	if (arsta)
+		sta = ath12k_sta_to_sta(arsta->ahsta);
+
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
 		return 1;
 
@@ -3672,7 +3699,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 		ath12k_warn(ab, "peer %pM disappeared!\n", peer_addr);
 
 	if (sta) {
-		arsta = ath12k_sta_to_arsta(sta);
+		ahsta = ath12k_sta_to_ahsta(sta);
 
 		switch (key->cipher) {
 		case WLAN_CIPHER_SUITE_TKIP:
@@ -3681,12 +3708,12 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 		case WLAN_CIPHER_SUITE_GCMP:
 		case WLAN_CIPHER_SUITE_GCMP_256:
 			if (cmd == SET_KEY)
-				arsta->pn_type = HAL_PN_TYPE_WPA;
+				ahsta->pn_type = HAL_PN_TYPE_WPA;
 			else
-				arsta->pn_type = HAL_PN_TYPE_NONE;
+				ahsta->pn_type = HAL_PN_TYPE_NONE;
 			break;
 		default:
-			arsta->pn_type = HAL_PN_TYPE_NONE;
+			ahsta->pn_type = HAL_PN_TYPE_NONE;
 			break;
 		}
 	}
@@ -3704,7 +3731,9 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_link_vif *arvif;
+	struct ath12k_link_sta *arsta = NULL;
 	struct ath12k_vif_cache *cache;
+	struct ath12k_sta *ahsta;
 	struct ath12k *ar;
 	int ret;
 
@@ -3745,14 +3774,19 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		return 0;
 	}
 
-	/* Note: Currently only deflink of ahvif is used here, once MLO
-	 * support is added the allocated links (i.e ahvif->links[])
+	if (sta) {
+		ahsta = ath12k_sta_to_ahsta(sta);
+		arsta = &ahsta->deflink;
+	}
+
+	/* Note: Currently only deflink of ahvif and ahsta are used here,
+	 * once MLO support is added the allocated links (i.e ahvif->links[])
 	 * should be use based on link id passed from mac80211 and such link
 	 * access needs to be protected with ah->conf_mutex.
 	 */
 
 	mutex_lock(&ar->conf_mutex);
-	ret = ath12k_mac_set_key(ar, cmd, arvif, sta, key);
+	ret = ath12k_mac_set_key(ar, cmd, arvif, arsta, key);
 	mutex_unlock(&ar->conf_mutex);
 	mutex_unlock(&ah->conf_mutex);
 	return ret;
@@ -3774,10 +3808,11 @@ ath12k_mac_bitrate_mask_num_vht_rates(struct ath12k *ar,
 
 static int
 ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_link_vif *arvif,
-				   struct ieee80211_sta *sta,
+				   struct ath12k_link_sta *arsta,
 				   const struct cfg80211_bitrate_mask *mask,
 				   enum nl80211_band band)
 {
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	struct ath12k *ar = arvif->ar;
 	u8 vht_rate, nss;
 	u32 rate_code;
@@ -3820,10 +3855,11 @@ ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_link_vif *arvif,
 
 static int ath12k_station_assoc(struct ath12k *ar,
 				struct ath12k_link_vif *arvif,
-				struct ieee80211_sta *sta,
+				struct ath12k_link_sta *arsta,
 				bool reassoc)
 {
 	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	int ret;
 	struct cfg80211_chan_def def;
@@ -3839,7 +3875,7 @@ static int ath12k_station_assoc(struct ath12k *ar,
 	band = def.chan->band;
 	mask = &arvif->bitrate_mask;
 
-	ath12k_peer_assoc_prepare(ar, arvif, sta, &peer_arg, reassoc);
+	ath12k_peer_assoc_prepare(ar, arvif, arsta, &peer_arg, reassoc);
 
 	ret = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
@@ -3862,7 +3898,7 @@ static int ath12k_station_assoc(struct ath12k *ar,
 	 * Note that all other rates and NSS will be disabled for this peer.
 	 */
 	if (sta->deflink.vht_cap.vht_supported && num_vht_rates == 1) {
-		ret = ath12k_mac_set_peer_vht_fixed_rate(arvif, sta, mask,
+		ret = ath12k_mac_set_peer_vht_fixed_rate(arvif, arsta, mask,
 							 band);
 		if (ret)
 			return ret;
@@ -3890,7 +3926,7 @@ static int ath12k_station_assoc(struct ath12k *ar,
 	}
 
 	if (sta->wme && sta->uapsd_queues) {
-		ret = ath12k_peer_assoc_qos_ap(ar, arvif, sta);
+		ret = ath12k_peer_assoc_qos_ap(ar, arvif, arsta);
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to set qos params for STA %pM for vdev %i: %d\n",
 				    sta->addr, arvif->vdev_id, ret);
@@ -3903,8 +3939,9 @@ static int ath12k_station_assoc(struct ath12k *ar,
 
 static int ath12k_station_disassoc(struct ath12k *ar,
 				   struct ath12k_link_vif *arvif,
-				   struct ieee80211_sta *sta)
+				   struct ath12k_link_sta *arsta)
 {
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -3928,7 +3965,6 @@ static int ath12k_station_disassoc(struct ath12k *ar,
 static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 {
 	struct ath12k *ar;
-	struct ath12k_sta *arsta;
 	struct ath12k_link_vif *arvif;
 	struct ieee80211_sta *sta;
 	struct cfg80211_chan_def def;
@@ -3940,10 +3976,11 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 	const struct cfg80211_bitrate_mask *mask;
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	enum wmi_phy_mode peer_phymode;
+	struct ath12k_link_sta *arsta;
 	struct ieee80211_vif *vif;
 
-	arsta = container_of(wk, struct ath12k_sta, update_wk);
-	sta = container_of((void *)arsta, struct ieee80211_sta, drv_priv);
+	arsta = container_of(wk, struct ath12k_link_sta, update_wk);
+	sta = ath12k_sta_to_sta(arsta->ahsta);
 	arvif = arsta->arvif;
 	vif = ath12k_vif_to_vif(arvif->ahvif);
 	ar = arvif->ar;
@@ -3974,7 +4011,7 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 			   ath12k_mac_max_vht_nss(vht_mcs_mask)));
 
 	if (changed & IEEE80211_RC_BW_CHANGED) {
-		ath12k_peer_assoc_h_phymode(ar, arvif, sta, &peer_arg);
+		ath12k_peer_assoc_h_phymode(ar, arvif, arsta, &peer_arg);
 		peer_phymode = peer_arg.peer_phymode;
 
 		if (bw > bw_prev) {
@@ -4062,14 +4099,14 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 		 * across HT/VHT and for multiple VHT MCS support.
 		 */
 		if (sta->deflink.vht_cap.vht_supported && num_vht_rates == 1) {
-			ath12k_mac_set_peer_vht_fixed_rate(arvif, sta, mask,
+			ath12k_mac_set_peer_vht_fixed_rate(arvif, arsta, mask,
 							   band);
 		} else {
 			/* If the peer is non-VHT or no fixed VHT rate
 			 * is provided in the new bitrate mask we set the
 			 * other rates using peer_assoc command.
 			 */
-			ath12k_peer_assoc_prepare(ar, arvif, sta,
+			ath12k_peer_assoc_prepare(ar, arvif, arsta,
 						  &peer_arg, true);
 
 			err = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
@@ -4087,8 +4124,9 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 }
 
 static int ath12k_mac_inc_num_stations(struct ath12k_link_vif *arvif,
-				       struct ieee80211_sta *sta)
+				       struct ath12k_link_sta *arsta)
 {
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	struct ath12k *ar = arvif->ar;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -4105,8 +4143,9 @@ static int ath12k_mac_inc_num_stations(struct ath12k_link_vif *arvif,
 }
 
 static void ath12k_mac_dec_num_stations(struct ath12k_link_vif *arvif,
-					struct ieee80211_sta *sta)
+					struct ath12k_link_sta *arsta)
 {
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	struct ath12k *ar = arvif->ar;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -4119,17 +4158,17 @@ static void ath12k_mac_dec_num_stations(struct ath12k_link_vif *arvif,
 
 static int ath12k_mac_station_add(struct ath12k *ar,
 				  struct ath12k_link_vif *arvif,
-				  struct ieee80211_sta *sta)
+				  struct ath12k_link_sta *arsta)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_vif *vif = ath12k_vif_to_vif(arvif->ahvif);
-	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
+	struct ieee80211_sta *sta = ath12k_sta_to_sta(arsta->ahsta);
 	struct ath12k_wmi_peer_create_arg peer_param;
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	ret = ath12k_mac_inc_num_stations(arvif, sta);
+	ret = ath12k_mac_inc_num_stations(arvif, arsta);
 	if (ret) {
 		ath12k_warn(ab, "refusing to associate station: too many connected already (%d)\n",
 			    ar->max_num_stations);
@@ -4188,7 +4227,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 free_peer:
 	ath12k_peer_delete(ar, arvif->vdev_id, sta->addr);
 dec_num_station:
-	ath12k_mac_dec_num_stations(arvif, sta);
+	ath12k_mac_dec_num_stations(arvif, arsta);
 exit:
 	return ret;
 }
@@ -4232,14 +4271,16 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
 	struct ath12k *ar;
-	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_link_vif *arvif;
+	struct ath12k_link_sta *arsta;
 	struct ath12k_peer *peer;
 	int ret = 0;
 
 	mutex_lock(&ah->conf_mutex);
 	arvif = &ahvif->deflink;
+	arsta = &ahsta->deflink;
 
 	/* cancel must be done outside the mutex to avoid deadlock */
 	if ((old_state == IEEE80211_STA_NONE &&
@@ -4257,10 +4298,15 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE) {
 		memset(arsta, 0, sizeof(*arsta));
+		rcu_assign_pointer(ahsta->link[0], arsta);
+		/* TODO use appropriate link id once MLO support is added  */
+		arsta->link_id = ATH12K_DEFAULT_LINK_ID;
+		ahsta->links_map = BIT(arsta->link_id);
+		arsta->ahsta = ahsta;
 		arsta->arvif = arvif;
 		INIT_WORK(&arsta->update_wk, ath12k_sta_rc_update_wk);
 
-		ret = ath12k_mac_station_add(ar, arvif, sta);
+		ret = ath12k_mac_station_add(ar, arvif, arsta);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to add station: %pM for VDEV: %d\n",
 				    sta->addr, arvif->vdev_id);
@@ -4283,7 +4329,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 			ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "Removed peer: %pM for VDEV: %d\n",
 				   sta->addr, arvif->vdev_id);
 
-		ath12k_mac_dec_num_stations(arvif, sta);
+		ath12k_mac_dec_num_stations(arvif, arsta);
 		spin_lock_bh(&ar->ab->base_lock);
 		peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
 		if (peer && peer->sta == sta) {
@@ -4298,12 +4344,20 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 
 		kfree(arsta->rx_stats);
 		arsta->rx_stats = NULL;
+
+		if (arsta->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
+			rcu_assign_pointer(ahsta->link[arsta->link_id], NULL);
+			synchronize_rcu();
+			ahsta->links_map &= ~(BIT(arsta->link_id));
+			arsta->link_id = ATH12K_INVALID_LINK_ID;
+			arsta->ahsta = NULL;
+		}
 	} else if (old_state == IEEE80211_STA_AUTH &&
 		   new_state == IEEE80211_STA_ASSOC &&
 		   (vif->type == NL80211_IFTYPE_AP ||
 		    vif->type == NL80211_IFTYPE_MESH_POINT ||
 		    vif->type == NL80211_IFTYPE_ADHOC)) {
-		ret = ath12k_station_assoc(ar, arvif, sta, false);
+		ret = ath12k_station_assoc(ar, arvif, arsta, false);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to associate station: %pM\n",
 				    sta->addr);
@@ -4347,7 +4401,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		   (vif->type == NL80211_IFTYPE_AP ||
 		    vif->type == NL80211_IFTYPE_MESH_POINT ||
 		    vif->type == NL80211_IFTYPE_ADHOC)) {
-		ret = ath12k_station_disassoc(ar, arvif, sta);
+		ret = ath12k_station_disassoc(ar, arvif, arsta);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to disassociate station: %pM\n",
 				    sta->addr);
@@ -4412,8 +4466,9 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 					u32 changed)
 {
 	struct ath12k *ar;
-	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_sta *arsta;
 	struct ath12k_link_vif *arvif;
 	struct ath12k_peer *peer;
 	u32 bw, smps;
@@ -4425,6 +4480,7 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	}
 
 	rcu_read_lock();
+	arsta = &ahsta->deflink;
 	arvif = &ahvif->deflink;
 	spin_lock_bh(&ar->ab->base_lock);
 
@@ -7816,7 +7872,8 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 					     struct ieee80211_sta *sta)
 {
 	struct ath12k_link_vif *arvif = data;
-	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+	struct ath12k_link_sta *arsta = &ahsta->deflink;
 	struct ath12k *ar = arvif->ar;
 
 	if (arsta->arvif != arvif)
@@ -7833,7 +7890,8 @@ static void ath12k_mac_disable_peer_fixed_rate(void *data,
 					       struct ieee80211_sta *sta)
 {
 	struct ath12k_link_vif *arvif = data;
-	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+	struct ath12k_link_sta *arsta = &ahsta->deflink;
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
@@ -8135,16 +8193,22 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct ieee80211_sta *sta,
 					 struct station_info *sinfo)
 {
-	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+	struct ath12k_link_sta *arsta;
 
+	mutex_lock(&ah->conf_mutex);
+	arsta = &ahsta->deflink;
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
 
 	sinfo->tx_duration = arsta->tx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
 
-	if (!arsta->txrate.legacy && !arsta->txrate.nss)
+	if (!arsta->txrate.legacy && !arsta->txrate.nss) {
+		mutex_unlock(&ah->conf_mutex);
 		return;
+	}
 
 	if (arsta->txrate.legacy) {
 		sinfo->txrate.legacy = arsta->txrate.legacy;
@@ -8162,6 +8226,7 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	/* TODO: Use real NF instead of default one. */
 	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	mutex_unlock(&ah->conf_mutex);
 }
 
 static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
-- 
2.25.1


