Return-Path: <linux-wireless+bounces-22978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CD1AB7D3F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 07:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1363A17B708
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553CF295503;
	Thu, 15 May 2025 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="np0rYLAt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBE29346C
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288171; cv=none; b=p70nTGh9qkdfsHV0o8/ZKqox0DrT2yo9un8BPV03a21KP5ZflYdncELyFe+zojBjNiq1gX1PLKbMGUiyycbYbYPLdZ9jz3iXSnciWS3WdaeGwJU6ZqFmGK7UKMElaDC0TmCQJj136hhqI92UATO0pTZRIQfYU42VFjWYrSEwWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288171; c=relaxed/simple;
	bh=SVVRZfL+S1AZUmFucA9za5fYLRBNkd1rSk+lPcpKh2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PktODxzr1GYHuw/c8897YerVd8t02z2E0oLUZWKPlYH9uy7ojPmGWlr/V9fqhADYrGVqqh59QxTyxfrTXzB9C9gabu7wKVw+oqeSIoM1adWGmqD1eSkVpPOfMAiug5ORKQEJkZ4NSo/iQ3uyEVWCgFiIi0xcb+v9f7fw6qRsUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=np0rYLAt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJrhVY009078;
	Thu, 15 May 2025 05:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YuF4Lx2G1nIFlsn6Oi4ptZQuVIwvj47pMLyWlR4QwXo=; b=np0rYLAt00OtgGf4
	KgYZX5i9L97M+kSZZOD7eHbQdj3LwazepitI2bxFNIMXe/Tp6S4sg0JJuzpJB+cw
	/B+qEb3u4QBnxfHsJFBX4Fdr528083rV/PcdwRXUwLQ1Ckgpq3ZkUzx+l3TXuFiK
	2JOq2kWg0MgHniXvGrr6l90px0S5OsDUwa8a7XMHLuay1REgBrFYHJMwaLoA4WIc
	2R8UUr++PSI0OAC/AMbaaI25QwbdfOYuCEKu3Xe5czMZBFwj2kn/xvZSnGzlf09k
	eH8usVZL5YHGQLH4Giu7uoMqeaE+FC4HTiQLB34p3JjaFO8UXmwZmG1kTISyfM0m
	JpwWkQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcpw1xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F5nNFx000986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:23 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 22:49:22 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v8 01/10] wifi: mac80211: add support towards MLO handling of station statistics
Date: Thu, 15 May 2025 11:18:55 +0530
Message-ID: <20250515054904.1214096-2-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: 4Ef_r-U1-P-I2maIUArvWOZmQCJwZ4fP
X-Proofpoint-ORIG-GUID: 4Ef_r-U1-P-I2maIUArvWOZmQCJwZ4fP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA1NSBTYWx0ZWRfXx3B0ZyDWkYso
 dPJzQ39HvNQTm5XcW0fEP/h/vE80TNfBbg8tdve+eokpBcA6e6NWR8U1pVeg5Bfh8dV1KSOreAu
 //j5hL+aCYKDgUhC1AlfYgbT4UkTs9Y7Gxh+PQnb7bXqDvh/08jNwwvtAAKhJ92EpFhPGwdmbjY
 qtl0AiIStuRhOiMpxObcWM8XYqOGx+4FMAywPYen06QaOb2S4yOgCO++HdEE83HnumYfffzIUOh
 WqZnQpqZFfF+w9ZYuTdUr1ujpGpzL1MGMXmCYlVspcaIzcqpkDXnGDw4UYyNB4F4/J2MgsP7H2s
 oSZ4MDgVoEvQnzRsqn7L0JOoSci0ZsXMhn00cZ1Kzan+yiOLRY7PvFLclYLGH5Uie7YREBXCujf
 IdzFlKBJQwfPymY94aPO5qWaLjS5NabmqMYoejjmxzCZXVvyjMRNdENzC8FVV0zYg6BL/h1i
X-Authority-Analysis: v=2.4 cv=KcvSsRYD c=1 sm=1 tr=0 ts=68258064 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=4qy7MeMMegWVXLquuOAA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150055

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
 net/mac80211/sta_info.c                      | 79 ++++++++++++++------
 net/mac80211/sta_info.h                      |  2 +-
 net/mac80211/util.c                          | 14 +++-
 6 files changed, 73 insertions(+), 31 deletions(-)

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
index 82617579d910..a305e7f9c6b2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7242,13 +7242,14 @@ void ieee80211_disable_rssi_reports(struct ieee80211_vif *vif);
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
index a6e7b7ba6a01..d521308734c4 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -635,7 +635,7 @@ static int ieee80211_sta_active_ibss(struct ieee80211_sub_if_data *sdata)
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(sta, &local->sta_list, list) {
-		unsigned long last_active = ieee80211_sta_last_active(sta);
+		unsigned long last_active = ieee80211_sta_last_active(sta, -1);
 
 		if (sta->sdata == sdata &&
 		    time_is_after_jiffies(last_active +
@@ -1228,7 +1228,7 @@ static void ieee80211_ibss_sta_expire(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry_safe(sta, tmp, &local->sta_list, list) {
-		unsigned long last_active = ieee80211_sta_last_active(sta);
+		unsigned long last_active = ieee80211_sta_last_active(sta, -1);
 
 		if (sdata != sta->sdata)
 			continue;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 84b18be1f0b1..5cc28eb1005b 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1650,7 +1650,7 @@ void ieee80211_sta_expire(struct ieee80211_sub_if_data *sdata,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry_safe(sta, tmp, &local->sta_list, list) {
-		unsigned long last_active = ieee80211_sta_last_active(sta);
+		unsigned long last_active = ieee80211_sta_last_active(sta, -1);
 
 		if (sdata != sta->sdata)
 			continue;
@@ -2419,18 +2419,27 @@ void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
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
@@ -2498,9 +2507,10 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
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
@@ -2525,20 +2535,28 @@ static inline u64 sta_get_tidstats_msdu(struct ieee80211_sta_rx_stats *rxstats,
 
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
-							   tid);
+		tidstats->rx_msdu +=
+			sta_get_tidstats_msdu(&link_sta_info->rx_stats,
+					      tid);
 
 		if (sta->deflink.pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats,
+				cpurxs = per_cpu_ptr(link_sta_info->pcpu_rx_stats,
 						     cpu);
 				tidstats->rx_msdu +=
 					sta_get_tidstats_msdu(cpurxs, tid);
@@ -2550,19 +2568,21 @@ static void sta_set_tidstats(struct sta_info *sta,
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU))) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU);
-		tidstats->tx_msdu = sta->deflink.tx_stats.msdu[tid];
+		tidstats->tx_msdu = link_sta_info->tx_stats.msdu[tid];
 	}
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU_RETRIES)) &&
 	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU_RETRIES);
-		tidstats->tx_msdu_retries = sta->deflink.status_stats.msdu_retries[tid];
+		tidstats->tx_msdu_retries =
+			link_sta_info->status_stats.msdu_retries[tid];
 	}
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU_FAILED)) &&
 	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU_FAILED);
-		tidstats->tx_msdu_failed = sta->deflink.status_stats.msdu_failed[tid];
+		tidstats->tx_msdu_failed =
+			link_sta_info->status_stats.msdu_failed[tid];
 	}
 
 	if (tid < IEEE80211_NUM_TIDS) {
@@ -2633,7 +2653,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	int i, ac, cpu;
 	struct ieee80211_sta_rx_stats *last_rxstats;
 
-	last_rxstats = sta_get_last_rx_stats(sta);
+	last_rxstats = sta_get_last_rx_stats(sta, -1);
 
 	sinfo->generation = sdata->local->sta_generation;
 
@@ -2661,7 +2681,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
 	sinfo->assoc_at = sta->assoc_at;
 	sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta));
+		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, -1));
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
@@ -2750,7 +2770,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	    !(sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX) |
 				 BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
-		sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif);
+		sinfo->rx_beacon_signal_avg =
+			ieee80211_ave_rssi(&sdata->vif, -1);
 	}
 
 	if (ieee80211_hw_check(&sta->local->hw, SIGNAL_DBM) ||
@@ -2799,13 +2820,13 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 
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
@@ -2888,14 +2909,24 @@ u32 sta_get_expected_throughput(struct sta_info *sta)
 	return thr;
 }
 
-unsigned long ieee80211_sta_last_active(struct sta_info *sta)
+unsigned long ieee80211_sta_last_active(struct sta_info *sta, int link_id)
 {
-	struct ieee80211_sta_rx_stats *stats = sta_get_last_rx_stats(sta);
+	struct ieee80211_sta_rx_stats *stats;
+	struct link_sta_info *link_sta_info;
+
+	stats = sta_get_last_rx_stats(sta, link_id);
 
-	if (!sta->deflink.status_stats.last_ack ||
-	    time_after(stats->last_rx, sta->deflink.status_stats.last_ack))
+	if (link_id < 0)
+		link_sta_info = &sta->deflink;
+	else
+		link_sta_info = wiphy_dereference(sta->local->hw.wiphy,
+						  sta->link[link_id]);
+
+	if (!link_sta_info->status_stats.last_ack ||
+	    time_after(stats->last_rx, link_sta_info->status_stats.last_ack))
 		return stats->last_rx;
-	return sta->deflink.status_stats.last_ack;
+
+	return link_sta_info->status_stats.last_ack;
 }
 
 int ieee80211_sta_allocate_link(struct sta_info *sta, unsigned int link_id)
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 7a95d8d34fca..e5b91e60405b 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -936,7 +936,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta);
 void ieee80211_sta_ps_deliver_poll_response(struct sta_info *sta);
 void ieee80211_sta_ps_deliver_uapsd(struct sta_info *sta);
 
-unsigned long ieee80211_sta_last_active(struct sta_info *sta);
+unsigned long ieee80211_sta_last_active(struct sta_info *sta, int link_id);
 
 void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 					   const u8 *ext_capab,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 27d414efa3fd..85297faf659c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3265,14 +3265,24 @@ int ieee80211_put_srates_elem(struct sk_buff *skb,
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
+	if (WARN_ON_ONCE(!link_data))
+		return -99;
+
+	return -ewma_beacon_signal_read(&link_data->u.mgd.ave_beacon_signal);
 }
 EXPORT_SYMBOL_GPL(ieee80211_ave_rssi);
 
-- 
2.34.1


