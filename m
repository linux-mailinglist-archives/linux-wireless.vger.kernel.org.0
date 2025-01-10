Return-Path: <linux-wireless+bounces-17278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0A5A0862A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 05:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBAE166E72
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 04:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1317E2063CA;
	Fri, 10 Jan 2025 04:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dp+buXkG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515551A9B45
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736483166; cv=none; b=X2NK4sjcGIJi6cDlkDhgVKvJWGRA4ddeQAIalrkSrYVdw++ilKHf70rS5fFWmrlnhCFED+9wIrUVZnt4AV2nb7lZbqhs2sufNRnxnoBqdjv0JYcPpWYymc6vaKD1Nfvck2kGVMOZ5wbNhazmPn6YCRWqGpXP8h96RGTJxvdh+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736483166; c=relaxed/simple;
	bh=GtJJFv2ylSC+Pd8toYf/1flIiSDr3CAuhuc+em+1KYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNn/RUim4ZvrB8Fg9Goxe3bzZGjW+6mLV8Ta9mMjqgsYs8YbYTcBKqLWnFy3w5b8FiUA1bYkG7Co96aM19caG6mSzeKcQ1zgC4tf/utEVvLpECPYr1xoUnURMN7IXs18h1bxqM4VfZbmQh9kzAZog9cVt3oajOiu6txb7ZYjT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dp+buXkG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A3bt6X002805;
	Fri, 10 Jan 2025 04:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FScCncM5aHAye7plWUiuIdHgnyFBit14vPGmKG6sVcI=; b=Dp+buXkGECCsojcE
	MDGwBJwvn4YVOkI7/4qbPIB8m2d53p+Iarf1qC0mWhEtebDR2XBD3fE9bcQaYgPD
	MS0xhAJKeG87qKu+PLRxTAn+H0aVPK40mUXU/MHketorXT3u5DRU2QIIzOIQGcT9
	KC6G0SVhqXgzg1aiy6QAM9GIZYfIT2hdLbRVK/AOgriT9ZbZDvDPVKPDB8S+vSdA
	Hlyw3Igx3FRc1K0THvgI9SesLyJVRW1A3BgdsSvjLThd3uF3TbazJ0cyt9KBiAo6
	Bq/7fs/cTAaqeq5p7hXUpMWbnn1bf4+RGtrne4RJ+gyZyhej/C4fH9d7bOs5eXah
	gBEgQQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442uteg2ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A4Pc1a002027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:38 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 20:25:37 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC 1/7] wifi: cfg80211: reorg sinfo structure elements for mesh
Date: Fri, 10 Jan 2025 09:54:43 +0530
Message-ID: <20250110042449.1158789-2-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: 7EGuG7fcQdMGkNBKWB7T9j8VgnCmxTq6
X-Proofpoint-ORIG-GUID: 7EGuG7fcQdMGkNBKWB7T9j8VgnCmxTq6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100034

Currently, as multi-link operation(MLO) is not supported for mesh,
reorganize the sinfo structure for mesh-specific fields and
introduce the sta_set_mesh_sinfo() API to populate these fields.
This will allow for the simplified reorganization of sinfo structure
for link level in a subsequent patch to add support for MLO station
statistics.
No functionality changes added.

Pahole summary before the reorg of sinfo structure:
 - size: 256, cachelines: 4, members: 50
 - sum members: 239, holes: 4, sum holes: 17
 - paddings: 2, sum paddings: 2
 - forced alignments: 1, forced holes: 1, sum forced holes: 1

Pahole summary after the reorg of sinfo structure:
 - size: 248, cachelines: 4, members: 50
 - sum members: 239, holes: 4, sum holes: 9
 - paddings: 2, sum paddings: 2
 - forced alignments: 1, last cacheline: 56 bytes

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h  | 43 ++++++++++++++-------------
 net/mac80211/sta_info.c | 64 ++++++++++++++++++++++-------------------
 net/wireless/nl80211.c  | 11 +++----
 3 files changed, 62 insertions(+), 56 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7790af534b7f..77f72a46ce42 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2045,9 +2045,6 @@ struct cfg80211_tid_stats {
  * @assoc_at: bootime (ns) of the last association
  * @rx_bytes: bytes (size of MPDUs) received from this station
  * @tx_bytes: bytes (size of MPDUs) transmitted to this station
- * @llid: mesh local link id
- * @plid: mesh peer link id
- * @plink_state: mesh peer link state
  * @signal: The signal strength, type depends on the wiphy's signal_type.
  *	For CFG80211_SIGNAL_TYPE_MBM, value is expressed in _dBm_.
  * @signal_avg: Average signal strength, type depends on the wiphy's signal_type.
@@ -2067,14 +2064,20 @@ struct cfg80211_tid_stats {
  *	This number should increase every time the list of stations
  *	changes, i.e. when a station is added or removed, so that
  *	userspace can tell whether it got a consistent snapshot.
+ * @beacon_loss_count: Number of times beacon loss event has triggered.
  * @assoc_req_ies: IEs from (Re)Association Request.
  *	This is used only when in AP mode with drivers that do not use
  *	user space MLME/SME implementation. The information is provided for
  *	the cfg80211_new_sta() calls to notify user space of the IEs.
  * @assoc_req_ies_len: Length of assoc_req_ies buffer in octets.
  * @sta_flags: station flags mask & values
- * @beacon_loss_count: Number of times beacon loss event has triggered.
  * @t_offset: Time offset of the station relative to this host.
+ * @llid: mesh local link id
+ * @plid: mesh peer link id
+ * @plink_state: mesh peer link state
+ * @connected_to_gate: true if mesh STA has a path to mesh gate
+ * @connected_to_as: true if mesh STA has a path to authentication server
+ * @airtime_link_metric: mesh airtime link metric.
  * @local_pm: local mesh STA power save mode
  * @peer_pm: peer mesh STA power save mode
  * @nonpeer_pm: non-peer mesh STA power save mode
@@ -2083,7 +2086,6 @@ struct cfg80211_tid_stats {
  * @rx_beacon: number of beacons received from this peer
  * @rx_beacon_signal_avg: signal strength average (in dBm) for beacons received
  *	from this peer
- * @connected_to_gate: true if mesh STA has a path to mesh gate
  * @rx_duration: aggregate PPDU duration(usecs) for all the frames from a peer
  * @tx_duration: aggregate PPDU duration(usecs) for all the frames to a peer
  * @airtime_weight: current airtime scheduling weight
@@ -2097,8 +2099,6 @@ struct cfg80211_tid_stats {
  * @fcs_err_count: number of packets (MPDUs) received from this station with
  *	an FCS error. This counter should be incremented only when TA of the
  *	received packet with an FCS error matches the peer MAC address.
- * @airtime_link_metric: mesh airtime link metric.
- * @connected_to_as: true if mesh STA has a path to authentication server
  * @mlo_params_valid: Indicates @assoc_link_id and @mld_addr fields are filled
  *	by driver. Drivers use this only in cfg80211_new_sta() calls when AP
  *	MLD's MLME/SME is offload to driver. Drivers won't fill this
@@ -2125,9 +2125,6 @@ struct station_info {
 	u64 assoc_at;
 	u64 rx_bytes;
 	u64 tx_bytes;
-	u16 llid;
-	u16 plid;
-	u8 plink_state;
 	s8 signal;
 	s8 signal_avg;
 
@@ -2147,36 +2144,38 @@ struct station_info {
 
 	int generation;
 
+	u32 beacon_loss_count;
+
 	const u8 *assoc_req_ies;
 	size_t assoc_req_ies_len;
 
-	u32 beacon_loss_count;
 	s64 t_offset;
+	u16 llid;
+	u16 plid;
+	u8 plink_state;
+	u8 connected_to_gate;
+	u8 connected_to_as;
+	u32 airtime_link_metric;
 	enum nl80211_mesh_power_mode local_pm;
 	enum nl80211_mesh_power_mode peer_pm;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
 	u32 expected_throughput;
 
-	u64 tx_duration;
-	u64 rx_duration;
-	u64 rx_beacon;
-	u8 rx_beacon_signal_avg;
-	u8 connected_to_gate;
+	u16 airtime_weight;
 
-	struct cfg80211_tid_stats *pertid;
 	s8 ack_signal;
 	s8 avg_ack_signal;
+	struct cfg80211_tid_stats *pertid;
 
-	u16 airtime_weight;
+	u64 tx_duration;
+	u64 rx_duration;
+	u64 rx_beacon;
+	u8 rx_beacon_signal_avg;
 
 	u32 rx_mpdu_count;
 	u32 fcs_err_count;
 
-	u32 airtime_link_metric;
-
-	u8 connected_to_as;
-
 	bool mlo_params_valid;
 	u8 assoc_link_id;
 	u8 mld_addr[ETH_ALEN] __aligned(2);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index aa22f09e6d14..53f8da74fb99 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2563,6 +2563,39 @@ static inline u64 sta_get_stats_bytes(struct ieee80211_sta_rx_stats *rxstats)
 	return value;
 }
 
+#ifdef CONFIG_MAC80211_MESH
+static void sta_set_mesh_sinfo(struct sta_info *sta,
+			       struct station_info *sinfo)
+{
+	struct ieee80211_local *local = sta->sdata->local;
+
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_LLID) |
+			 BIT_ULL(NL80211_STA_INFO_PLID) |
+			 BIT_ULL(NL80211_STA_INFO_PLINK_STATE) |
+			 BIT_ULL(NL80211_STA_INFO_LOCAL_PM) |
+			 BIT_ULL(NL80211_STA_INFO_PEER_PM) |
+			 BIT_ULL(NL80211_STA_INFO_NONPEER_PM) |
+			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TO_GATE) |
+			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TO_AS);
+
+	sinfo->llid = sta->mesh->llid;
+	sinfo->plid = sta->mesh->plid;
+	sinfo->plink_state = sta->mesh->plink_state;
+	if (test_sta_flag(sta, WLAN_STA_TOFFSET_KNOWN)) {
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_T_OFFSET);
+		sinfo->t_offset = sta->mesh->t_offset;
+	}
+	sinfo->local_pm = sta->mesh->local_pm;
+	sinfo->peer_pm = sta->mesh->peer_pm;
+	sinfo->nonpeer_pm = sta->mesh->nonpeer_pm;
+	sinfo->connected_to_gate = sta->mesh->connected_to_gate;
+	sinfo->connected_to_as = sta->mesh->connected_to_as;
+
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_AIRTIME_LINK_METRIC);
+	sinfo->airtime_link_metric = airtime_link_metric_get(local, sta);
+}
+#endif
+
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
@@ -2747,31 +2780,10 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			sta_set_tidstats(sta, &sinfo->pertid[i], i);
 	}
 
-	if (ieee80211_vif_is_mesh(&sdata->vif)) {
 #ifdef CONFIG_MAC80211_MESH
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_LLID) |
-				 BIT_ULL(NL80211_STA_INFO_PLID) |
-				 BIT_ULL(NL80211_STA_INFO_PLINK_STATE) |
-				 BIT_ULL(NL80211_STA_INFO_LOCAL_PM) |
-				 BIT_ULL(NL80211_STA_INFO_PEER_PM) |
-				 BIT_ULL(NL80211_STA_INFO_NONPEER_PM) |
-				 BIT_ULL(NL80211_STA_INFO_CONNECTED_TO_GATE) |
-				 BIT_ULL(NL80211_STA_INFO_CONNECTED_TO_AS);
-
-		sinfo->llid = sta->mesh->llid;
-		sinfo->plid = sta->mesh->plid;
-		sinfo->plink_state = sta->mesh->plink_state;
-		if (test_sta_flag(sta, WLAN_STA_TOFFSET_KNOWN)) {
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_T_OFFSET);
-			sinfo->t_offset = sta->mesh->t_offset;
-		}
-		sinfo->local_pm = sta->mesh->local_pm;
-		sinfo->peer_pm = sta->mesh->peer_pm;
-		sinfo->nonpeer_pm = sta->mesh->nonpeer_pm;
-		sinfo->connected_to_gate = sta->mesh->connected_to_gate;
-		sinfo->connected_to_as = sta->mesh->connected_to_as;
+	if (ieee80211_vif_is_mesh(&sdata->vif))
+		sta_set_mesh_sinfo(sta, sinfo);
 #endif
-	}
 
 	sinfo->bss_param.flags = 0;
 	if (sdata->vif.bss_conf.use_cts_prot)
@@ -2827,12 +2839,6 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->filled |=
 			BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
 	}
-
-	if (ieee80211_vif_is_mesh(&sdata->vif)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_AIRTIME_LINK_METRIC);
-		sinfo->airtime_link_metric =
-			airtime_link_metric_get(local, sta);
-	}
 }
 
 u32 sta_get_expected_throughput(struct sta_info *sta)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8789d8b73f0f..d90033e03dd6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6726,9 +6726,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 
 	PUT_SINFO_U64(RX_BYTES64, rx_bytes);
 	PUT_SINFO_U64(TX_BYTES64, tx_bytes);
-	PUT_SINFO(LLID, llid, u16);
-	PUT_SINFO(PLID, plid, u16);
-	PUT_SINFO(PLINK_STATE, plink_state, u8);
 	PUT_SINFO_U64(RX_DURATION, rx_duration);
 	PUT_SINFO_U64(TX_DURATION, tx_duration);
 
@@ -6772,13 +6769,18 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	PUT_SINFO(TX_RETRIES, tx_retries, u32);
 	PUT_SINFO(TX_FAILED, tx_failed, u32);
 	PUT_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
-	PUT_SINFO(AIRTIME_LINK_METRIC, airtime_link_metric, u32);
 	PUT_SINFO(BEACON_LOSS, beacon_loss_count, u32);
+
+	PUT_SINFO(LLID, llid, u16);
+	PUT_SINFO(PLID, plid, u16);
+	PUT_SINFO(PLINK_STATE, plink_state, u8);
+	PUT_SINFO(AIRTIME_LINK_METRIC, airtime_link_metric, u32);
 	PUT_SINFO(LOCAL_PM, local_pm, u32);
 	PUT_SINFO(PEER_PM, peer_pm, u32);
 	PUT_SINFO(NONPEER_PM, nonpeer_pm, u32);
 	PUT_SINFO(CONNECTED_TO_GATE, connected_to_gate, u8);
 	PUT_SINFO(CONNECTED_TO_AS, connected_to_as, u8);
+	PUT_SINFO_U64(T_OFFSET, t_offset);
 
 	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
 		bss_param = nla_nest_start_noflag(msg,
@@ -6806,7 +6808,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    &sinfo->sta_flags))
 		goto nla_put_failure;
 
-	PUT_SINFO_U64(T_OFFSET, t_offset);
 	PUT_SINFO_U64(RX_DROP_MISC, rx_dropped_misc);
 	PUT_SINFO_U64(BEACON_RX, rx_beacon);
 	PUT_SINFO(BEACON_SIGNAL_AVG, rx_beacon_signal_avg, u8);
-- 
2.34.1


