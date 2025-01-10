Return-Path: <linux-wireless+bounces-17282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C84C4A0862F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 05:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519191887D44
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 04:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAEF2066C1;
	Fri, 10 Jan 2025 04:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BkXjPXNM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF40C2046A5
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 04:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736483173; cv=none; b=tXcaAFgqlNoXiOrNrNNOCXGelE1I2eNGds8jvSIPVJr8z5LDOOkdGfU00PordboMdAAc6rSLcXYAr2wAfBdSnNummJGh68p4WUq+XFKyU8y6evlxq3Be2ygJvBa8tfTVOpm8SDiskx86XAdrYcjeO73husj5KOt7/NI6NV4eGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736483173; c=relaxed/simple;
	bh=eECMbhHO/tZtTtgd9wWhiV1Jsmr1ysOK9ZGzKnz52KQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSaxwMi/Lv/wZ2uoUagBYFo7b/Eu3jFiwdob2teGXHRn10IqmTMFwqAOAfV4UfbFzVeMKvydMcmtqr93pJWxvwu2ELSaxaZATCnqI4n0gtc/6/fiWyhQ+cJnG8y/3n9maOJM8pSn8PsZeJvbih8vPPmdWyD8J4tBhGYTYraMAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BkXjPXNM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A1W32H023421;
	Fri, 10 Jan 2025 04:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nVtkMhadTyinaJhpt2IRpczkOn3ERE/pOh4gnqQFWhU=; b=BkXjPXNMNnfxRhzk
	pjqYiLydi0B1qaXqq7zhgW3kRNNJTg/l3BeiNtB8olX0OAZ7E/xsmJ0ueAgDYVUg
	Yd7LwlV50XYl33DJsFYVaps1kRu+Tb4fvBx0lxezjCfFbWcoyQk4qJlsypwz24Om
	dO+Rw6nlaRRUdNKr8dDq/JyJAZH1oN73a7feebUjVvZSvrfqrbSgCJxkGZcWA4nn
	zgGN1PSorr9B2TvHw5iQZKwx0tVAZsFePlTP2vUPxs/T6cPCIvuxu6tXhX7sQzv4
	QcbRuxkg66F3ff8j5HG2O9DUwKHG7xpCxP/OoJzNvftmgYjmJ3EhxD1/j7FcA/fl
	b0ITTA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442syc0bba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:43 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A4Pgev004621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:42 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 20:25:40 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC 3/7] wifi: cfg80211: extend statistics for link level in sinfo
Date: Fri, 10 Jan 2025 09:54:45 +0530
Message-ID: <20250110042449.1158789-4-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: i1sQBMCCmRkmQ9DAXgQ6Hm8IQuQI9OOF
X-Proofpoint-ORIG-GUID: i1sQBMCCmRkmQ9DAXgQ6Hm8IQuQI9OOF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501100034

Currently, statistics is supported at deflink level for station. This
has problems when applied to multi-link(ML) connections.
Hence, add changes to support link level statistics in sinfo structure.
Additionally, remove mlo_params_valid from the sinfo structure and
add valid_links to indicate bitmap of valid links for MLO.

This will be helpful to check the link related statistics during MLO.

The statistics could be embedded into NL message as below:
For MLO:
cmd ->
	NL80211_ATTR_IFINDEX
	NL80211_ATTR_MAC
	NL80211_ATTR_GENERATION
	.......etc
	NL80211_ATTR_STA_INFO | nest flag
		NL80211_STA_INFO_CONNECTED_TIME,
		NL80211_STA_INFO_STA_FLAGS,
		........etc
	NL80211_ATTR_MLO_LINK_ID,
	NL80211_ATTR_MLD_ADDR,
	NL80211_ATTR_MLO_LINKS | nested
		link_id-1 | nested
		NL80211_ATTR_MLO_LINK_ID,
		NL80211_ATTR_MLD_ADDR,
			NL80211_ATTR_STA_INFO | nest flag
				NL80211_STA_INFO_RX_BYTES,
				NL80211_STA_INFO_TX_BYTES,
				..........etc.
		link_id-2 | nested
		NL80211_ATTR_MLO_LINK_ID,
		NL80211_ATTR_MLD_ADDR,
			NL80211_ATTR_STA_INFO | nest flag
				NL80211_STA_INFO_RX_BYTES,
				NL80211_STA_INFO_TX_BYTES,
				.........etc
For non-ML:
cmd->
	NL80211_ATTR_IFINDEX
	NL80211_ATTR_MAC
	NL80211_ATTR_GENERATION
	....
	NL80211_ATTR_STA_INFO | nest flag
		NL80211_STA_INFO_CONNECTED_TIME,
		NL80211_STA_INFO_STA_FLAGS,
		NL80211_STA_INFO_RX_BYTES,
		NL80211_STA_INFO_TX_BYTES,
		.........etc

The output of iw dev wlan0 station dump for MLO could look like below:

Station 00:03:7f:04:31:78 (on wlan0)
	authorized:     yes
	authenticated:  yes
	associated:     yes
	preamble:       long
	WMM/WME:        yes
	MFP:            yes
	TDLS peer:      no
	connected time: 383 seconds
	associated at [boottime]:       93.740s
	associated at:  93685 ms
	current time:   340046 ms
        MLD address: 00:03:7f:04:31:78
        Link 0:
                Address: 00:03:7f:04:31:78
                inactive time:  330120 ms
                rx bytes:       116
                rx packets:     3
                tx bytes:       0
                tx packets:     0
                tx retries:     0
                tx failed:      0
                rx drop misc:   0
                signal:         -95 dBm
                tx bitrate:     6.0 MBit/s
                tx duration:    2669 us
                rx duration:    0 us
	        DTIM period:    2
	        beacon interval:100
        Link 1:
                Address: 00:03:7f:04:31:79
                inactive time:  81268 ms
                rx bytes:       1323
                rx packets:     12
                tx bytes:       1538
                tx packets:     8
                tx retries:     0
                tx failed:      0
                rx drop misc:   0
                signal:         -95 dBm
                tx bitrate:     6.0 MBit/s
                tx duration:    2669 us
                rx bitrate:     6.0 MBit/s
                rx duration:    0 us
	        DTIM period:    2
	        beacon interval:100

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h  |  24 +++++---
 include/net/mac80211.h  |   3 +-
 net/mac80211/ibss.c     |   4 +-
 net/mac80211/sta_info.c | 132 ++++++++++++++++++++++++++++++----------
 net/mac80211/sta_info.h |   2 +-
 net/mac80211/util.c     |  18 +++++-
 net/wireless/nl80211.c  |  78 ++++++++++++++++++------
 7 files changed, 198 insertions(+), 63 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ba3e7e72ab5d..5b0ec0394715 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2158,11 +2158,6 @@ struct link_station_info {
  * @local_pm: local mesh STA power save mode
  * @peer_pm: peer mesh STA power save mode
  * @nonpeer_pm: non-peer mesh STA power save mode
- * @mlo_params_valid: Indicates @assoc_link_id and @mld_addr fields are filled
- *	by driver. Drivers use this only in cfg80211_new_sta() calls when AP
- *	MLD's MLME/SME is offload to driver. Drivers won't fill this
- *	information in cfg80211_del_sta_sinfo(), get_station() and
- *	dump_station() callbacks.
  * @assoc_link_id: Indicates MLO link ID of the AP, with which the station
  *	completed (re)association. This information filled for both MLO
  *	and non-MLO STA connections when the AP affiliated with an MLD.
@@ -2176,8 +2171,12 @@ struct link_station_info {
  *	dump_station() callbacks. User space needs this information to determine
  *	the accepted and rejected affiliated links of the connected station.
  * @assoc_resp_ies_len: Length of @assoc_resp_ies buffer in octets.
+ * @valid_links: bitmap of valid links, or 0 for non-MLO. Drivers fill this
+ *	information in cfg80211_new_sta(), cfg80211_del_sta_sinfo(),
+ *	get_station() and dump_station() callbacks.
  * @deflink: This holds the default link STA information, for non MLO STA
  *	all link specific STA information is accessed through @deflink.
+ * @links: reference to Link sta entries for MLO.
  */
 struct station_info {
 	u64 filled;
@@ -2201,13 +2200,15 @@ struct station_info {
 	enum nl80211_mesh_power_mode peer_pm;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
-	bool mlo_params_valid;
 	u8 assoc_link_id;
 	u8 mld_addr[ETH_ALEN] __aligned(2);
 	const u8 *assoc_resp_ies;
 	size_t assoc_resp_ies_len;
 
+	u16 valid_links;
 	struct link_station_info deflink;
+	/* TODO: Need to check and add protection access to links memory */
+	struct link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
 /**
@@ -8473,7 +8474,16 @@ int cfg80211_sinfo_alloc_tid_stats(struct link_station_info *link_sinfo, gfp_t g
  */
 static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 {
-	kfree(sinfo->deflink.pertid);
+	int link_id;
+
+	if (sinfo->valid_links) {
+		for_each_valid_link(sinfo, link_id) {
+			kfree(sinfo->links[link_id]->pertid);
+			kfree(sinfo->links[link_id]);
+		}
+	} else {
+		kfree(sinfo->deflink.pertid);
+	}
 }
 
 /**
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ea62d223a0e4..c1e88761b5e8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7214,13 +7214,14 @@ void ieee80211_disable_rssi_reports(struct ieee80211_vif *vif);
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
index a1b4178deccf..0848fbda65f9 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -642,7 +642,7 @@ static int ieee80211_sta_active_ibss(struct ieee80211_sub_if_data *sdata)
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(sta, &local->sta_list, list) {
-		unsigned long last_active = ieee80211_sta_last_active(sta);
+		unsigned long last_active = ieee80211_sta_last_active(sta, -1);
 
 		if (sta->sdata == sdata &&
 		    time_is_after_jiffies(last_active +
@@ -1235,7 +1235,7 @@ static void ieee80211_ibss_sta_expire(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry_safe(sta, tmp, &local->sta_list, list) {
-		unsigned long last_active = ieee80211_sta_last_active(sta);
+		unsigned long last_active = ieee80211_sta_last_active(sta, -1);
 
 		if (sdata != sta->sdata)
 			continue;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 985e53bf04bc..6be5c05b686a 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1622,7 +1622,7 @@ void ieee80211_sta_expire(struct ieee80211_sub_if_data *sdata,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry_safe(sta, tmp, &local->sta_list, list) {
-		unsigned long last_active = ieee80211_sta_last_active(sta);
+		unsigned long last_active = ieee80211_sta_last_active(sta, -1);
 
 		if (sdata != sta->sdata)
 			continue;
@@ -2391,18 +2391,28 @@ void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
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
@@ -2470,9 +2480,10 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
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
@@ -2497,20 +2508,28 @@ static inline u64 sta_get_tidstats_msdu(struct ieee80211_sta_rx_stats *rxstats,
 
 static void sta_set_tidstats(struct sta_info *sta,
 			     struct cfg80211_tid_stats *tidstats,
-			     int tid)
+			     int link_id, int tid)
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
 
-		if (sta->deflink.pcpu_rx_stats) {
+		if (link_sta_info->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats,
+				cpurxs = per_cpu_ptr(link_sta_info->pcpu_rx_stats,
 						     cpu);
 				tidstats->rx_msdu +=
 					sta_get_tidstats_msdu(cpurxs, tid);
@@ -2522,19 +2541,19 @@ static void sta_set_tidstats(struct sta_info *sta,
 
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
@@ -2602,11 +2621,20 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *l
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
 	u32 thr = 0;
-	int i, ac, cpu;
+	int i, ac, cpu, link_id;
 	struct ieee80211_sta_rx_stats *last_rxstats;
-	struct link_sta_info *link_sta_info = &sta->deflink;
+	struct link_sta_info *link_sta_info;
 
-	last_rxstats = sta_get_last_rx_stats(sta);
+	link_id = link_sinfo->link_id;
+
+	if (link_id < 0)
+		link_sta_info = &sta->deflink;
+	else
+		link_sta_info =
+			rcu_dereference_protected(sta->link[link_id],
+						  lockdep_is_held(&local->hw.wiphy->mtx));
+
+	last_rxstats = sta_get_last_rx_stats(sta, link_id);
 
 
 	/* do before driver, so beacon filtering drivers have a
@@ -2617,6 +2645,9 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *l
 		link_sinfo->rx_beacon = link_sdata->u.mgd.count_beacon_signal;
 
 	drv_link_sta_statistics(local, sdata, &sta->sta, link_sinfo);
+
+	memcpy(link_sinfo->addr, link_sta_info->addr, ETH_ALEN);
+
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
 			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
 			 BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
@@ -2628,7 +2659,7 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *l
 	}
 
 	link_sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta));
+		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, link_id));
 
 	if (!(link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
@@ -2717,7 +2748,8 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *l
 	    !(sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)) {
 		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX) |
 				 BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
-		link_sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif);
+		link_sinfo->rx_beacon_signal_avg =
+			ieee80211_ave_rssi(&sdata->vif, link_id);
 	}
 
 	if (ieee80211_hw_check(&sta->local->hw, SIGNAL_DBM) ||
@@ -2756,22 +2788,20 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *l
 	}
 
 	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
-	    !sta->sta.valid_links &&
 	    ieee80211_rate_valid(&link_sta_info->tx_stats.last_rate)) {
 		sta_set_rate_info_tx(sta, &link_sta_info->tx_stats.last_rate,
 				     &link_sinfo->txrate);
 		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
 
-	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) &&
-	    !sta->sta.valid_links){
-		if (sta_set_rate_info_rx(sta, &link_sinfo->rxrate) == 0)
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE))) {
+		if (sta_set_rate_info_rx(sta, &link_sinfo->rxrate, link_id) == 0)
 			link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
 	}
 
 	if (tidstats && !cfg80211_sinfo_alloc_tid_stats(link_sinfo, GFP_KERNEL)) {
 		for (i = 0; i < IEEE80211_NUM_TIDS + 1; i++)
-			sta_set_tidstats(sta, &link_sinfo->pertid[i], i);
+			sta_set_tidstats(sta, &link_sinfo->pertid[i], link_id, i);
 	}
 
 	link_sinfo->bss_param.flags = 0;
@@ -2810,10 +2840,13 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	struct link_station_info *link_sinfo = &sinfo->deflink;
-	struct ieee80211_link_data *link_sdata = &sdata->deflink;
+	struct ieee80211_link_data *link_sdata;
+	struct link_station_info *link_sinfo;
+	struct link_sta_info *link_sta;
+	int link_id;
 
 	sinfo->generation = sdata->local->sta_generation;
+	sinfo->valid_links = sta->sta.valid_links;
 
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_STA_FLAGS) |
 			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME) |
@@ -2851,7 +2884,33 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sta_set_mesh_sinfo(sta, sinfo);
 #endif
 
-	sta_set_link_sinfo(sta, link_sinfo, link_sdata, tidstats);
+	if (sinfo->valid_links) {
+		memcpy(sinfo->mld_addr, sta->addr, ETH_ALEN);
+
+		for_each_valid_link(sinfo, link_id) {
+			link_sta =
+				rcu_dereference_protected(sta->link[link_id],
+							  lockdep_is_held(&sta->local->hw.wiphy->mtx));
+			if (!link_sta)
+				continue;
+
+			link_sinfo = kzalloc(sizeof(*link_sinfo), GFP_KERNEL);
+			if (!link_sinfo)
+				return;
+
+			link_sinfo->link_id = link_id;
+			link_sdata =
+				rcu_dereference_protected(sdata->link[link_id],
+							  lockdep_is_held(&sdata->local->hw.wiphy->mtx));
+			sta_set_link_sinfo(sta, link_sinfo, link_sdata, tidstats);
+			sinfo->links[link_id] = link_sinfo;
+		}
+	} else {
+		link_sinfo = &sinfo->deflink;
+		link_sinfo->link_id = -1;
+		link_sdata = &sdata->deflink;
+		sta_set_link_sinfo(sta, link_sinfo, link_sdata, tidstats);
+	}
 }
 
 u32 sta_get_expected_throughput(struct sta_info *sta)
@@ -2873,14 +2932,23 @@ u32 sta_get_expected_throughput(struct sta_info *sta)
 	return thr;
 }
 
-unsigned long ieee80211_sta_last_active(struct sta_info *sta)
+unsigned long ieee80211_sta_last_active(struct sta_info *sta, int link_id)
 {
-	struct ieee80211_sta_rx_stats *stats = sta_get_last_rx_stats(sta);
+	struct ieee80211_sta_rx_stats *stats = sta_get_last_rx_stats(sta, link_id);
+	struct link_sta_info *link_sta_info;
 
-	if (!sta->deflink.status_stats.last_ack ||
-	    time_after(stats->last_rx, sta->deflink.status_stats.last_ack))
+	if (link_id < 0)
+		link_sta_info = &sta->deflink;
+	else
+		link_sta_info =
+			rcu_dereference_protected(sta->link[link_id],
+						  lockdep_is_held(&sta->local->hw.wiphy->mtx));
+
+	if (!link_sta_info->status_stats.last_ack ||
+	    time_after(stats->last_rx, link_sta_info->status_stats.last_ack))
 		return stats->last_rx;
-	return sta->deflink.status_stats.last_ack;
+
+	return link_sta_info->status_stats.last_ack;
 }
 
 static void sta_update_codel_params(struct sta_info *sta, u32 thr)
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 9f89fb5bee37..1d82519319fe 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -939,7 +939,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta);
 void ieee80211_sta_ps_deliver_poll_response(struct sta_info *sta);
 void ieee80211_sta_ps_deliver_uapsd(struct sta_info *sta);
 
-unsigned long ieee80211_sta_last_active(struct sta_info *sta);
+unsigned long ieee80211_sta_last_active(struct sta_info *sta, int link_id);
 
 void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 					   const u8 *ext_capab,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7b656326e68a..f8ae7726eede 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3274,14 +3274,28 @@ int ieee80211_put_srates_elem(struct sk_buff *skb,
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
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7740ab5c778d..37a8cbb1022a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6844,10 +6844,10 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 				struct net_device *dev,
 				const u8 *mac_addr, struct station_info *sinfo)
 {
-	struct nlattr *sinfoattr;
+	struct nlattr *sinfoattr, *link_sinfoattr, *links, *link;
 	void *hdr;
-	struct link_station_info *link_sinfo = &sinfo->deflink;
-	int ret = -1;
+	struct link_station_info *link_sinfo;
+	int ret = -1, link_id;
 
 	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr) {
@@ -6860,17 +6860,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	    nla_put_u32(msg, NL80211_ATTR_GENERATION, sinfo->generation))
 		goto nla_put_failure;
 
-	if (sinfo->mlo_params_valid) {
-		if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
-			       sinfo->assoc_link_id))
-			goto nla_put_failure;
-
-		if (!is_zero_ether_addr(sinfo->mld_addr) &&
-		    nla_put(msg, NL80211_ATTR_MLD_ADDR, ETH_ALEN,
-			    sinfo->mld_addr))
-			goto nla_put_failure;
-	}
-
 	if (sinfo->assoc_req_ies_len &&
 	    nla_put(msg, NL80211_ATTR_IE, sinfo->assoc_req_ies_len,
 		    sinfo->assoc_req_ies))
@@ -6922,11 +6911,64 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 #undef PUT_SINFO
 #undef PUT_SINFO_U64
 
-	ret = nl80211_fill_link_station(msg, rdev, link_sinfo);
-	if (ret)
-		goto nla_put_failure;
+	if (sinfo->valid_links) {
+		/* TODO: Add accumulated stats for packets, bytes for
+		 *	 better representation at MLO level.
+		 */
+
+		/* Closing nested STA_INFO as MLO links ATTR should not
+		 * be in nested STA_INFO
+		 */
+		nla_nest_end(msg, sinfoattr);
+
+		if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
+			       sinfo->assoc_link_id))
+			goto nla_put_failure;
+
+		if (!is_zero_ether_addr(sinfo->mld_addr) &&
+		    nla_put(msg, NL80211_ATTR_MLD_ADDR, ETH_ALEN,
+			    sinfo->mld_addr))
+			goto nla_put_failure;
+
+		links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
+		if (!links)
+			goto nla_put_failure;
+
+		for_each_valid_link(sinfo, link_id) {
+			link_sinfo = sinfo->links[link_id];
+			link = nla_nest_start(msg, link_id + 1);
+			if (!link)
+				goto nla_put_failure;
+
+			if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
+				       link_id))
+				goto nla_put_failure;
 
-	nla_nest_end(msg, sinfoattr);
+			if (!is_zero_ether_addr(link_sinfo->addr) &&
+			    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
+				    link_sinfo->addr))
+				goto nla_put_failure;
+
+			link_sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
+			if (!link_sinfoattr)
+				goto nla_put_failure;
+
+			ret = nl80211_fill_link_station(msg, rdev, link_sinfo);
+			if (ret)
+				goto nla_put_failure;
+
+			nla_nest_end(msg, link_sinfoattr);
+			nla_nest_end(msg, link);
+		}
+		nla_nest_end(msg, links);
+	} else {
+		link_sinfo = &sinfo->deflink;
+		ret = nl80211_fill_link_station(msg, rdev, link_sinfo);
+		if (ret)
+			goto nla_put_failure;
+
+		nla_nest_end(msg, sinfoattr);
+	}
 
 	cfg80211_sinfo_release_content(sinfo);
 	genlmsg_end(msg, hdr);
-- 
2.34.1


