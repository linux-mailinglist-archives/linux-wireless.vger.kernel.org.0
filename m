Return-Path: <linux-wireless+bounces-21525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF1EA892C3
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 06:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8D6166BE3
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 04:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FA61DE3C4;
	Tue, 15 Apr 2025 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OEm39TK8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111314B945
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744690869; cv=none; b=JGbiEmdCkaOPbLq0/dQHOIvTPyCq38cuPQvLLGC4VBVQsOIf8UV1IyxQBdyPXlzvwHR/16WuTYy82l1LwG1ZJDSf8Ke8anYpeZPAV3JMViDK2mIQPB2VV7ekFlie5rWWsSDTwcdMd+5F5WmpoJAx2BW2FgmeRen4c/0QeQwjoA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744690869; c=relaxed/simple;
	bh=EeeMDfJBLET5GhSt0hAkFtlCZ6ZmK39pI1D9RaaJmwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaX5TKK1lXNhDj3fbEmfB9fdorKQ6Q56pq9C7f5hV1/M/YEt98dKVJ/WOqM3FGeRGxIeGYxRX5LXUinhV0P5x6bpX3OZ9YLggj3+5zTQIRnlQDl4msn5tIpRNIxpMuwjtsZqVjdfT9hdcsRQuqKYxB8SsX1Y7c0srOuoNGL7o7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OEm39TK8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F15hfi023132;
	Tue, 15 Apr 2025 04:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ifpmyQuWPOe5n5kHpcppHpggFcWcxcSjovAIxR8DcHU=; b=OEm39TK86w9wB8hK
	PcYNrDMkyxgzyX8BlEqVFSxsfzHHApFLseKlLmirx4aqmSVWc9TAGidICDgFyiVD
	dmXcljYm2oIZ3vM/NNzXtsFPBWgA0F2l2QUlw3ocxMfy0MKz8SJU/bI0fuLnwMcN
	RGkyHcnmyc1JnqS08cqyzLkqUewlWt91KQ7yxAk7ZJ16PenHGWBoDDS16p0PbUj9
	/fVxEZURR2eC/prfjLuRu9M/DaCWTcqw3IyxXQRuczanXCU2N0CrT2Rxllpc+sBW
	rEJ+zgYgS6+yZx2Pt1WS49fEI1G2xG854HrTKaAw3hv/y7/Y3Jhu9bDGWwtFnuZ+
	oW/wig==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf4veq4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:02 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F4L2Uj018761
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:02 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Apr 2025 21:21:00 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v6 01/11] wifi: mac80211: add support towards MLO handling of station statistics
Date: Tue, 15 Apr 2025 09:50:20 +0530
Message-ID: <20250415042030.1246187-2-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: I4qvPLTS_pm2wd5hUbbnAat94LsWtFsX
X-Authority-Analysis: v=2.4 cv=IZ6HWXqa c=1 sm=1 tr=0 ts=67fddeae cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=4qy7MeMMegWVXLquuOAA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: I4qvPLTS_pm2wd5hUbbnAat94LsWtFsX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150026

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
 net/mac80211/sta_info.c                      | 71 +++++++++++++-------
 net/mac80211/sta_info.h                      |  2 +-
 net/mac80211/util.c                          | 14 +++-
 6 files changed, 66 insertions(+), 30 deletions(-)

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
index c498f685d01f..cbb154ce8551 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7252,13 +7252,14 @@ void ieee80211_disable_rssi_reports(struct ieee80211_vif *vif);
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
index 4246d168374f..bed0356691f7 100644
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
index 248e1f63bf73..068f08d6c967 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1657,7 +1657,7 @@ void ieee80211_sta_expire(struct ieee80211_sub_if_data *sdata,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry_safe(sta, tmp, &local->sta_list, list) {
-		unsigned long last_active = ieee80211_sta_last_active(sta);
+		unsigned long last_active = ieee80211_sta_last_active(sta, -1);
 
 		if (sdata != sta->sdata)
 			continue;
@@ -2426,18 +2426,27 @@ void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
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
+		link_sta_info = wiphy_dereference(sta->local->hw.wiphy,
+						  sta->link[link_id]);
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
@@ -2505,9 +2514,10 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
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
@@ -2532,20 +2542,27 @@ static inline u64 sta_get_tidstats_msdu(struct ieee80211_sta_rx_stats *rxstats,
 
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
+		link_sta_info = wiphy_dereference(sta->local->hw.wiphy,
+						  sta->link[link_id]);
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
@@ -2557,19 +2574,19 @@ static void sta_set_tidstats(struct sta_info *sta,
 
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
@@ -2640,7 +2657,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	int i, ac, cpu;
 	struct ieee80211_sta_rx_stats *last_rxstats;
 
-	last_rxstats = sta_get_last_rx_stats(sta);
+	last_rxstats = sta_get_last_rx_stats(sta, -1);
 
 	sinfo->generation = sdata->local->sta_generation;
 
@@ -2668,7 +2685,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
 	sinfo->assoc_at = sta->assoc_at;
 	sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta));
+		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, -1));
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
@@ -2757,7 +2774,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	    !(sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX) |
 				 BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
-		sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif);
+		sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif, -1);
 	}
 
 	if (ieee80211_hw_check(&sta->local->hw, SIGNAL_DBM) ||
@@ -2806,13 +2823,13 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 
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
@@ -2895,14 +2912,22 @@ u32 sta_get_expected_throughput(struct sta_info *sta)
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
+		link_sta_info = wiphy_dereference(sta->local->hw.wiphy,
+						  sta->link[link_id]);
 
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
index dec6e16b8c7d..287ce96f28d4 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3280,14 +3280,24 @@ int ieee80211_put_srates_elem(struct sk_buff *skb,
 	return 0;
 }
 
-int ieee80211_ave_rssi(struct ieee80211_vif *vif)
+int ieee80211_ave_rssi(struct ieee80211_vif *vif, int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_link_data *link_data;
 
 	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION))
 		return 0;
 
-	return -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal);
+	if (link_id < 0)
+		link_data = &sdata->deflink;
+	else
+		link_data = wiphy_dereference(sdata->local->hw.wiphy,
+					      sdata->link[link_id]);
+
+	if (WARN_ON(!link_data))
+		return -99;
+
+	return -ewma_beacon_signal_read(&link_data->u.mgd.ave_beacon_signal);
 }
 EXPORT_SYMBOL_GPL(ieee80211_ave_rssi);
 
-- 
2.34.1


