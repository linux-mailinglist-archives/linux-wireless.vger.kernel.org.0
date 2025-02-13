Return-Path: <linux-wireless+bounces-18928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35050A34BCB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A33ACAEE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7732820766B;
	Thu, 13 Feb 2025 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hGUz/DQv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973EE2040BA
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467046; cv=none; b=ega5hZQBJR6GIbaUQoW81QHLyPXNZZzhwKGJmDXs1Uo/3eao3w1Y9ZCz06ETq9AF/2JR0fvK9z+4BQIq0p1qSuMbgwuvN81iOfDPluI2d7Vn7gCg37m4/7AoqvpIiEQC94I8/5JW+KwjJW7bnWICmrSCskN99UdCLSzHAswTkVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467046; c=relaxed/simple;
	bh=ImHju88ogogM0+XnDwakUE4cIk6dKwTL5WBj6eISiaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQ5OUK7z7PDKGggADWjHDbh4PQglIOk1AEiTGtltJR/uAB5uuUp0KmszVc+HkCs7FjnJLvGNodA1feFEDpkrb5bBux8hB9vsfoO2Z4FVr2TBP/MfnBBAYhsNdG4bUg6j+L8bdeX4Y0tZnpjfqFoMTsbb64N9T4oj3n4SfMHwqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hGUz/DQv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D9WUYe015774;
	Thu, 13 Feb 2025 17:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vZOMbxFp/+6sJyKXpVtcF32GzeQRERfmL2QRm0Uh8ZM=; b=hGUz/DQveP4xgIsT
	RNk4HAVYm3I8JI+GCOkIOrcBLbNlN01AAXPQ6we43tW+XrfShXOhRrnTsZDLQsSc
	HSkqtYnsh/IqWTdbjmUcfF2ePnccIX3molUOhbQ+3TzfATPpV9HKQ/p4oze31fBg
	2kUn2NYbnOPf4S53HlNLYVmzML2OkRe7zP/bEW9orl/fLkSWOeHyuG2m7aBRb81V
	oKXreBYGcI303dJpoG9EejmWnw3y7o84VSIVGjCrU2AEqJvrLQdjp/tRWRandnXa
	dhUIebwQWsufoHPrq1HPPvMlQs0Gtt8ju/KktY4y8GbU/AY4Uu2twUK167bN97sQ
	TOtzmw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rgpgnt3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:20 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DHHJNK010507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:19 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Feb 2025 09:17:18 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH v3 03/12] wifi: mac80211: add support towards MLO handling of station statistics
Date: Thu, 13 Feb 2025 22:46:23 +0530
Message-ID: <20250213171632.1646538-4-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i8d8fZ8MFnIVi1CqPxgR2fby6XIWo-Rv
X-Proofpoint-GUID: i8d8fZ8MFnIVi1CqPxgR2fby6XIWo-Rv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130123

Currently, in supporting API's to fill sinfo structure from sta
structure, is mapped to fill the fields from sta->deflink. However,
for multi-link (ML) station, sinfo structure should be filled from
corresponding link_id.

Therefore, add  link_id as an additional argument in supporting API's
for filling sinfo structure correctly. Link_id is set to -1 for non-ML
station and corresponding link_id for ML stations. In supporting API's
for filling sinfo structure, check for link_id, if link_id < 0, fill
the sinfo structure from sta-> deflink, otherwise fill from
sta->link[link_id].

Current, changes are done at the deflink level i.e, pass -1 as link_id.
Actual link_id will be added in subsequent patches to support
station statistics for MLO.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c |  2 +-
 include/net/mac80211.h                       |  3 +-
 net/mac80211/ibss.c                          |  4 +-
 net/mac80211/sta_info.c                      | 74 ++++++++++++++------
 net/mac80211/sta_info.h                      |  2 +-
 net/mac80211/util.c                          | 18 ++++-
 6 files changed, 73 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/lib.c b/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
index 1dc974e2c511..48711dbcfa5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
@@ -586,7 +586,7 @@ static bool iwlagn_fill_txpower_mode(struct iwl_priv *priv,
 		return false;
 	}
 
-	ave_rssi = ieee80211_ave_rssi(ctx->vif);
+	ave_rssi = ieee80211_ave_rssi(ctx->vif, -1);
 	if (!ave_rssi) {
 		/* no rssi data, no changes to reduce tx power */
 		IWL_DEBUG_COEX(priv, "no rssi data available\n");
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 22d32419e8a0..dc14fcd5544a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7227,13 +7227,14 @@ void ieee80211_disable_rssi_reports(struct ieee80211_vif *vif);
  * ieee80211_ave_rssi - report the average RSSI for the specified interface
  *
  * @vif: the specified virtual interface
+ * @link_id: the link ID for MLO, or -1 for non-MLO
  *
  * Note: This function assumes that the given vif is valid.
  *
  * Return: The average RSSI value for the requested interface, or 0 if not
  * applicable.
  */
-int ieee80211_ave_rssi(struct ieee80211_vif *vif);
+int ieee80211_ave_rssi(struct ieee80211_vif *vif, int link_id);
 
 /**
  * ieee80211_report_wowlan_wakeup - report WoWLAN wakeup
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 05a945df3259..438d7a3caa9c 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -643,7 +643,7 @@ static int ieee80211_sta_active_ibss(struct ieee80211_sub_if_data *sdata)
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(sta, &local->sta_list, list) {
-		unsigned long last_active = ieee80211_sta_last_active(sta);
+		unsigned long last_active = ieee80211_sta_last_active(sta, -1);
 
 		if (sta->sdata == sdata &&
 		    time_is_after_jiffies(last_active +
@@ -1236,7 +1236,7 @@ static void ieee80211_ibss_sta_expire(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry_safe(sta, tmp, &local->sta_list, list) {
-		unsigned long last_active = ieee80211_sta_last_active(sta);
+		unsigned long last_active = ieee80211_sta_last_active(sta, -1);
 
 		if (sdata != sta->sdata)
 			continue;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index a4b4506cd35b..0f280a89b60a 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1643,7 +1643,7 @@ void ieee80211_sta_expire(struct ieee80211_sub_if_data *sdata,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry_safe(sta, tmp, &local->sta_list, list) {
-		unsigned long last_active = ieee80211_sta_last_active(sta);
+		unsigned long last_active = ieee80211_sta_last_active(sta, -1);
 
 		if (sdata != sta->sdata)
 			continue;
@@ -2412,18 +2412,28 @@ void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 }
 
 static struct ieee80211_sta_rx_stats *
-sta_get_last_rx_stats(struct sta_info *sta)
+sta_get_last_rx_stats(struct sta_info *sta, int link_id)
 {
-	struct ieee80211_sta_rx_stats *stats = &sta->deflink.rx_stats;
+	struct ieee80211_sta_rx_stats *stats;
+	struct link_sta_info *link_sta_info;
 	int cpu;
 
-	if (!sta->deflink.pcpu_rx_stats)
+	if (link_id < 0)
+		link_sta_info = &sta->deflink;
+	else
+		link_sta_info =
+			rcu_dereference_protected(sta->link[link_id],
+						  lockdep_is_held(&sta->local->hw.wiphy->mtx));
+
+	stats = &link_sta_info->rx_stats;
+
+	if (!link_sta_info->pcpu_rx_stats)
 		return stats;
 
 	for_each_possible_cpu(cpu) {
 		struct ieee80211_sta_rx_stats *cpustats;
 
-		cpustats = per_cpu_ptr(sta->deflink.pcpu_rx_stats, cpu);
+		cpustats = per_cpu_ptr(link_sta_info->pcpu_rx_stats, cpu);
 
 		if (time_after(cpustats->last_rx, stats->last_rx))
 			stats = cpustats;
@@ -2491,9 +2501,10 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
 	}
 }
 
-static int sta_set_rate_info_rx(struct sta_info *sta, struct rate_info *rinfo)
+static int sta_set_rate_info_rx(struct sta_info *sta, struct rate_info *rinfo,
+				int link_id)
 {
-	u32 rate = READ_ONCE(sta_get_last_rx_stats(sta)->last_rate);
+	u32 rate = READ_ONCE(sta_get_last_rx_stats(sta, link_id)->last_rate);
 
 	if (rate == STA_STATS_RATE_INVALID)
 		return -EINVAL;
@@ -2518,20 +2529,28 @@ static inline u64 sta_get_tidstats_msdu(struct ieee80211_sta_rx_stats *rxstats,
 
 static void sta_set_tidstats(struct sta_info *sta,
 			     struct cfg80211_tid_stats *tidstats,
-			     int tid)
+			     int tid, int link_id)
 {
 	struct ieee80211_local *local = sta->local;
+	struct link_sta_info *link_sta_info;
 	int cpu;
 
+	if (link_id < 0)
+		link_sta_info = &sta->deflink;
+	else
+		link_sta_info =
+			rcu_dereference_protected(sta->link[link_id],
+						  lockdep_is_held(&local->hw.wiphy->mtx));
+
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_RX_MSDU))) {
-		tidstats->rx_msdu += sta_get_tidstats_msdu(&sta->deflink.rx_stats,
+		tidstats->rx_msdu += sta_get_tidstats_msdu(&link_sta_info->rx_stats,
 							   tid);
 
 		if (sta->deflink.pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats,
+				cpurxs = per_cpu_ptr(link_sta_info->pcpu_rx_stats,
 						     cpu);
 				tidstats->rx_msdu +=
 					sta_get_tidstats_msdu(cpurxs, tid);
@@ -2543,19 +2562,19 @@ static void sta_set_tidstats(struct sta_info *sta,
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU))) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU);
-		tidstats->tx_msdu = sta->deflink.tx_stats.msdu[tid];
+		tidstats->tx_msdu = link_sta_info->tx_stats.msdu[tid];
 	}
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU_RETRIES)) &&
 	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU_RETRIES);
-		tidstats->tx_msdu_retries = sta->deflink.status_stats.msdu_retries[tid];
+		tidstats->tx_msdu_retries = link_sta_info->status_stats.msdu_retries[tid];
 	}
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU_FAILED)) &&
 	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU_FAILED);
-		tidstats->tx_msdu_failed = sta->deflink.status_stats.msdu_failed[tid];
+		tidstats->tx_msdu_failed = link_sta_info->status_stats.msdu_failed[tid];
 	}
 
 	if (tid < IEEE80211_NUM_TIDS) {
@@ -2626,7 +2645,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	int i, ac, cpu;
 	struct ieee80211_sta_rx_stats *last_rxstats;
 
-	last_rxstats = sta_get_last_rx_stats(sta);
+	last_rxstats = sta_get_last_rx_stats(sta, -1);
 
 	sinfo->generation = sdata->local->sta_generation;
 
@@ -2654,7 +2673,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
 	sinfo->assoc_at = sta->assoc_at;
 	sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta));
+		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, -1));
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
@@ -2743,7 +2762,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	    !(sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX) |
 				 BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
-		sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif);
+		sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif, -1);
 	}
 
 	if (ieee80211_hw_check(&sta->local->hw, SIGNAL_DBM) ||
@@ -2792,13 +2811,13 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) &&
 	    !sta->sta.valid_links) {
-		if (sta_set_rate_info_rx(sta, &sinfo->rxrate) == 0)
+		if (sta_set_rate_info_rx(sta, &sinfo->rxrate, -1) == 0)
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
 	}
 
 	if (tidstats && !cfg80211_sinfo_alloc_tid_stats(sinfo, GFP_KERNEL)) {
 		for (i = 0; i < IEEE80211_NUM_TIDS + 1; i++)
-			sta_set_tidstats(sta, &sinfo->pertid[i], i);
+			sta_set_tidstats(sta, &sinfo->pertid[i], i, -1);
 	}
 
 #ifdef CONFIG_MAC80211_MESH
@@ -2881,14 +2900,23 @@ u32 sta_get_expected_throughput(struct sta_info *sta)
 	return thr;
 }
 
-unsigned long ieee80211_sta_last_active(struct sta_info *sta)
+unsigned long ieee80211_sta_last_active(struct sta_info *sta, int link_id)
 {
-	struct ieee80211_sta_rx_stats *stats = sta_get_last_rx_stats(sta);
+	struct ieee80211_sta_rx_stats *stats = sta_get_last_rx_stats(sta, link_id);
+	struct link_sta_info *link_sta_info;
+
+	if (link_id < 0)
+		link_sta_info = &sta->deflink;
+	else
+		link_sta_info =
+			rcu_dereference_protected(sta->link[link_id],
+						  lockdep_is_held(&sta->local->hw.wiphy->mtx));
 
-	if (!sta->deflink.status_stats.last_ack ||
-	    time_after(stats->last_rx, sta->deflink.status_stats.last_ack))
+	if (!link_sta_info->status_stats.last_ack ||
+	    time_after(stats->last_rx, link_sta_info->status_stats.last_ack))
 		return stats->last_rx;
-	return sta->deflink.status_stats.last_ack;
+
+	return link_sta_info->status_stats.last_ack;
 }
 
 static void sta_update_codel_params(struct sta_info *sta, u32 thr)
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 07b7ec39a52f..7e600c82a6e1 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -947,7 +947,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta);
 void ieee80211_sta_ps_deliver_poll_response(struct sta_info *sta);
 void ieee80211_sta_ps_deliver_uapsd(struct sta_info *sta);
 
-unsigned long ieee80211_sta_last_active(struct sta_info *sta);
+unsigned long ieee80211_sta_last_active(struct sta_info *sta, int link_id);
 
 void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 					   const u8 *ext_capab,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f6b631faf4f7..1e2cb33030da 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3276,14 +3276,28 @@ int ieee80211_put_srates_elem(struct sk_buff *skb,
 	return 0;
 }
 
-int ieee80211_ave_rssi(struct ieee80211_vif *vif)
+int ieee80211_ave_rssi(struct ieee80211_vif *vif, int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_link_data *link_data;
+	int rssi;
 
 	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION))
 		return 0;
 
-	return -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal);
+	if (link_id < 0)
+		link_data = &sdata->deflink;
+	else
+		link_data =
+			rcu_dereference_protected(sdata->link[link_id],
+						  lockdep_is_held(&sdata->local->hw.wiphy->mtx));
+
+	if (WARN_ON(!link_data))
+		return -99;
+
+	rssi = -ewma_beacon_signal_read(&link_data->u.mgd.ave_beacon_signal);
+
+	return rssi;
 }
 EXPORT_SYMBOL_GPL(ieee80211_ave_rssi);
 
-- 
2.34.1


