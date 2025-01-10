Return-Path: <linux-wireless+bounces-17276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C375DA08629
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 05:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1E93A101F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 04:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF201E3762;
	Fri, 10 Jan 2025 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UfpPjfa7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF5126C10
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736483163; cv=none; b=a3eRRvrW8/AGVJ6T2q8WUYVXqBz4KH+Qreuar/vHq45tSCW6IxMcC/vRhtcPr9mpRxWZDYwwH4H27lvXz27dSrzEPRjHYo48TNFU9Dtl/q16pHpCiYzr46Ij7sGDmzBs6LNHQhf36JVZho3CwNAhLUyC/Ih6fZrvuLCvGdnBxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736483163; c=relaxed/simple;
	bh=bRZK4yWiGqo5PzkqGihN/wSBRWYOfwsos9YSBhGd5QU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjRE1rp99ufqO/H5WEV+/6/0kbr4gMIFIdyhqnSUEPH9vm2xbWDWTX3J4o4sD+UvA53Qf1GuS18YZAG6H7EFG01UA2rdfHfycr5NfwtcEaFC2CVwItQEo5RA4wMhUX6P5EVaiDBYS1fFdh//IdzNgE9uccjWllySXffkfhqhc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UfpPjfa7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509FrxZk007709;
	Fri, 10 Jan 2025 04:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h7PTceYHEJ8FwagAljsHcvcMtUscLCt6Jw8RbJqWz3Q=; b=UfpPjfa76hdEGIYh
	dVARt4Hkuj4JF4wdbVvy1ytY2NyKrj5/ISVUKza+VQO9IZmLQ2qEQhuOx+7hVbGj
	H8K+lXGk8+1GCUKHdKqUei2AbNInTOWHitl5J/NZas2y4rVSwE0peVVPgQP0cCbk
	3b5vN+w37SX+4sMLKDAZa6mMlbSdwklXmVhJ1CaLCJtDDYZISC6+nCYGdkIciDh+
	C5xyOLyabX51covObqLzPn+yP47GIHeSDnWg3aEpZtOmYQRv6OEC/DmrKZcrWSKb
	XXf+YWimmw+KSyzspIWELusWLC6QAdJQY6lpKkFmlB0mKCd7u1qS8FTgZe8nF+Ns
	u5Bkcw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442hgg1gxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:41 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A4Pex5028032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:40 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 20:25:38 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC 2/7] wifi: cfg80211: reorg sinfo structure elements for MLO
Date: Fri, 10 Jan 2025 09:54:44 +0530
Message-ID: <20250110042449.1158789-3-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: bGSc6RjH0VI9pivgyhUHEea31KUbr8R6
X-Proofpoint-ORIG-GUID: bGSc6RjH0VI9pivgyhUHEea31KUbr8R6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100034

Current implementation of NL80211_GET_STATION does not work for
multi-link operation(MLO) since in case of MLO only deflink (or one
of the links) is considered and not all links.

Therefore to support for MLO, start reorganizing sinfo structure
related data elements and add link_sinfo structure for link-level
statistics and keep station related data at sinfo structure.
Currently, changes are done at the deflink level. Actual link-level
changes will be added in subsequent changes.

Also currently, mac80211 ops .sta_statistics() is mapped to fill sinfo
structure. But to add support for station statistics at link level,
change the ops to .link_sta_statistics() to fill link_sinfo structure.

NOTE:
 - Currently this patch is not-bisectable, once RFC patches are
   approved could add other required driver changes.
 - Have included ath12k driver changes as an example that could be
   used as reference for other drivers.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c |  42 ++--
 include/net/cfg80211.h                | 165 +++++++++-------
 include/net/mac80211.h                |  18 +-
 net/mac80211/driver-ops.h             |  14 +-
 net/mac80211/ethtool.c                |  30 +--
 net/mac80211/sta_info.c               | 251 ++++++++++++-----------
 net/mac80211/trace.h                  |   2 +-
 net/wireless/nl80211.c                | 273 +++++++++++++++-----------
 net/wireless/trace.h                  |  33 ++--
 net/wireless/util.c                   |  10 +-
 net/wireless/wext-compat.c            |  22 +--
 11 files changed, 469 insertions(+), 391 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c4eab4c1c10e..ebde8a604eec 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -9896,10 +9896,10 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	return 0;
 }
 
-static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
-					 struct ieee80211_vif *vif,
-					 struct ieee80211_sta *sta,
-					 struct station_info *sinfo)
+static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
+					      struct ieee80211_vif *vif,
+					      struct ieee80211_sta *sta,
+					      struct link_station_info *link_sinfo)
 {
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
 	struct ath12k_link_sta *arsta;
@@ -9908,31 +9908,31 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 
 	arsta = &ahsta->deflink;
 
-	sinfo->rx_duration = arsta->rx_duration;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
+	link_sinfo->rx_duration = arsta->rx_duration;
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
 
-	sinfo->tx_duration = arsta->tx_duration;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
+	link_sinfo->tx_duration = arsta->tx_duration;
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
 
 	if (!arsta->txrate.legacy && !arsta->txrate.nss)
 		return;
 
 	if (arsta->txrate.legacy) {
-		sinfo->txrate.legacy = arsta->txrate.legacy;
+		link_sinfo->txrate.legacy = arsta->txrate.legacy;
 	} else {
-		sinfo->txrate.mcs = arsta->txrate.mcs;
-		sinfo->txrate.nss = arsta->txrate.nss;
-		sinfo->txrate.bw = arsta->txrate.bw;
-		sinfo->txrate.he_gi = arsta->txrate.he_gi;
-		sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
-		sinfo->txrate.he_ru_alloc = arsta->txrate.he_ru_alloc;
+		link_sinfo->txrate.mcs = arsta->txrate.mcs;
+		link_sinfo->txrate.nss = arsta->txrate.nss;
+		link_sinfo->txrate.bw = arsta->txrate.bw;
+		link_sinfo->txrate.he_gi = arsta->txrate.he_gi;
+		link_sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
+		link_sinfo->txrate.he_ru_alloc = arsta->txrate.he_ru_alloc;
 	}
-	sinfo->txrate.flags = arsta->txrate.flags;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	link_sinfo->txrate.flags = arsta->txrate.flags;
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 
 	/* TODO: Use real NF instead of default one. */
-	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	link_sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 }
 
 static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
@@ -10177,7 +10177,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.set_bitrate_mask		= ath12k_mac_op_set_bitrate_mask,
 	.get_survey			= ath12k_mac_op_get_survey,
 	.flush				= ath12k_mac_op_flush,
-	.sta_statistics			= ath12k_mac_op_sta_statistics,
+	.link_sta_statistics		= ath12k_mac_op_link_sta_statistics,
 	.remain_on_channel              = ath12k_mac_op_remain_on_channel,
 	.cancel_remain_on_channel       = ath12k_mac_op_cancel_remain_on_channel,
 	.change_sta_links               = ath12k_mac_op_change_sta_links,
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 77f72a46ce42..ba3e7e72ab5d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2034,17 +2034,18 @@ struct cfg80211_tid_stats {
 #define IEEE80211_MAX_CHAINS	4
 
 /**
- * struct station_info - station information
+ * struct link_station_info - link station information
  *
- * Station information filled by driver for get_station() and dump_station.
+ * Link station information filled by driver for get_station() and dump_station.
  *
+ * @link_id: Link ID uniquely identifying the link STA. This is -1 for non-ML
  * @filled: bitflag of flags using the bits of &enum nl80211_sta_info to
  *	indicate the relevant values in this struct for them
- * @connected_time: time(in secs) since a station is last connected
- * @inactive_time: time since last station activity (tx/rx) in milliseconds
- * @assoc_at: bootime (ns) of the last association
- * @rx_bytes: bytes (size of MPDUs) received from this station
- * @tx_bytes: bytes (size of MPDUs) transmitted to this station
+ * @connected_time: time(in secs) since a link station is last connected
+ * @inactive_time: time since last link station activity (tx/rx) in milliseconds
+ * @assoc_at: bootime (ns) of the last link station association
+ * @rx_bytes: bytes (size of MPDUs) received from this link station
+ * @tx_bytes: bytes (size of MPDUs) transmitted to this link station
  * @signal: The signal strength, type depends on the wiphy's signal_type.
  *	For CFG80211_SIGNAL_TYPE_MBM, value is expressed in _dBm_.
  * @signal_avg: Average signal strength, type depends on the wiphy's signal_type.
@@ -2052,19 +2053,95 @@ struct cfg80211_tid_stats {
  * @chains: bitmask for filled values in @chain_signal, @chain_signal_avg
  * @chain_signal: per-chain signal strength of last received packet in dBm
  * @chain_signal_avg: per-chain signal strength average in dBm
- * @txrate: current unicast bitrate from this station
- * @rxrate: current unicast bitrate to this station
- * @rx_packets: packets (MSDUs & MMPDUs) received from this station
- * @tx_packets: packets (MSDUs & MMPDUs) transmitted to this station
+ * @txrate: current unicast bitrate from this link station
+ * @rxrate: current unicast bitrate to this link station
+ * @rx_packets: packets (MSDUs & MMPDUs) received from this link station
+ * @tx_packets: packets (MSDUs & MMPDUs) transmitted to thislink station
  * @tx_retries: cumulative retry counts (MPDUs)
  * @tx_failed: number of failed transmissions (MPDUs) (retries exceeded, no ACK)
  * @rx_dropped_misc:  Dropped for un-specified reason.
  * @bss_param: current BSS parameters
+ * @beacon_loss_count: Number of times beacon loss event has triggered.
+ * @expected_throughput: expected throughput in kbps (including 802.11 headers)
+ *	towards this link station.
+ * @rx_beacon: number of beacons received from this peer
+ * @rx_beacon_signal_avg: signal strength average (in dBm) for beacons received
+ *	from this peer
+ * @rx_duration: aggregate PPDU duration(usecs) for all the frames from a peer
+ * @tx_duration: aggregate PPDU duration(usecs) for all the frames to a peer
+ * @airtime_weight: current airtime scheduling weight
+ * @pertid: per-TID statistics, see &struct cfg80211_tid_stats, using the last
+ *	(IEEE80211_NUM_TIDS) index for MSDUs not encapsulated in QoS-MPDUs.
+ *	Note that this doesn't use the @filled bit, but is used if non-NULL.
+ * @ack_signal: signal strength (in dBm) of the last ACK frame.
+ * @avg_ack_signal: average rssi value of ack packet for the no of msdu's has
+ *	been sent.
+ * @rx_mpdu_count: number of MPDUs received from this link station
+ * @fcs_err_count: number of packets (MPDUs) received from this link station with
+ *	an FCS error. This counter should be incremented only when TA of the
+ *	received packet with an FCS error matches the peer MAC address.
+ * @addr: For MLO STA connection, filled with address of the link station.
+ *	For non-MLO STA connection, filled with all zeros.
+ */
+struct link_station_info {
+	int link_id;
+	u64 filled;
+	u32 connected_time;
+	u32 inactive_time;
+	u64 assoc_at;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	s8 signal;
+	s8 signal_avg;
+
+	u8 chains;
+	s8 chain_signal[IEEE80211_MAX_CHAINS];
+	s8 chain_signal_avg[IEEE80211_MAX_CHAINS];
+
+	struct rate_info txrate;
+	struct rate_info rxrate;
+	u32 rx_packets;
+	u32 tx_packets;
+	u32 tx_retries;
+	u32 tx_failed;
+	u32 rx_dropped_misc;
+	struct sta_bss_parameters bss_param;
+
+	u32 beacon_loss_count;
+
+	u32 expected_throughput;
+
+	u64 tx_duration;
+	u64 rx_duration;
+	u64 rx_beacon;
+	u8 rx_beacon_signal_avg;
+
+	u16 airtime_weight;
+
+	s8 ack_signal;
+	s8 avg_ack_signal;
+	struct cfg80211_tid_stats *pertid;
+
+	u32 rx_mpdu_count;
+	u32 fcs_err_count;
+
+	u8 addr[ETH_ALEN] __aligned(2);
+};
+
+/**
+ * struct station_info - station information
+ *
+ * Station information filled by driver for get_station() and dump_station.
+ *
+ * @filled: bitflag of flags using the bits of &enum nl80211_sta_info to
+ *	indicate the relevant values in this struct for them
+ * @connected_time: time(in secs) since a station is last connected
+ * @assoc_at: bootime (ns) of the last association
+ * @sta_flags: station flags mask & values
  * @generation: generation number for nl80211 dumps.
  *	This number should increase every time the list of stations
  *	changes, i.e. when a station is added or removed, so that
  *	userspace can tell whether it got a consistent snapshot.
- * @beacon_loss_count: Number of times beacon loss event has triggered.
  * @assoc_req_ies: IEs from (Re)Association Request.
  *	This is used only when in AP mode with drivers that do not use
  *	user space MLME/SME implementation. The information is provided for
@@ -2081,24 +2158,6 @@ struct cfg80211_tid_stats {
  * @local_pm: local mesh STA power save mode
  * @peer_pm: peer mesh STA power save mode
  * @nonpeer_pm: non-peer mesh STA power save mode
- * @expected_throughput: expected throughput in kbps (including 802.11 headers)
- *	towards this station.
- * @rx_beacon: number of beacons received from this peer
- * @rx_beacon_signal_avg: signal strength average (in dBm) for beacons received
- *	from this peer
- * @rx_duration: aggregate PPDU duration(usecs) for all the frames from a peer
- * @tx_duration: aggregate PPDU duration(usecs) for all the frames to a peer
- * @airtime_weight: current airtime scheduling weight
- * @pertid: per-TID statistics, see &struct cfg80211_tid_stats, using the last
- *	(IEEE80211_NUM_TIDS) index for MSDUs not encapsulated in QoS-MPDUs.
- *	Note that this doesn't use the @filled bit, but is used if non-NULL.
- * @ack_signal: signal strength (in dBm) of the last ACK frame.
- * @avg_ack_signal: average rssi value of ack packet for the no of msdu's has
- *	been sent.
- * @rx_mpdu_count: number of MPDUs received from this station
- * @fcs_err_count: number of packets (MPDUs) received from this station with
- *	an FCS error. This counter should be incremented only when TA of the
- *	received packet with an FCS error matches the peer MAC address.
  * @mlo_params_valid: Indicates @assoc_link_id and @mld_addr fields are filled
  *	by driver. Drivers use this only in cfg80211_new_sta() calls when AP
  *	MLD's MLME/SME is offload to driver. Drivers won't fill this
@@ -2117,35 +2176,17 @@ struct cfg80211_tid_stats {
  *	dump_station() callbacks. User space needs this information to determine
  *	the accepted and rejected affiliated links of the connected station.
  * @assoc_resp_ies_len: Length of @assoc_resp_ies buffer in octets.
+ * @deflink: This holds the default link STA information, for non MLO STA
+ *	all link specific STA information is accessed through @deflink.
  */
 struct station_info {
 	u64 filled;
 	u32 connected_time;
-	u32 inactive_time;
 	u64 assoc_at;
-	u64 rx_bytes;
-	u64 tx_bytes;
-	s8 signal;
-	s8 signal_avg;
-
-	u8 chains;
-	s8 chain_signal[IEEE80211_MAX_CHAINS];
-	s8 chain_signal_avg[IEEE80211_MAX_CHAINS];
-
-	struct rate_info txrate;
-	struct rate_info rxrate;
-	u32 rx_packets;
-	u32 tx_packets;
-	u32 tx_retries;
-	u32 tx_failed;
-	u32 rx_dropped_misc;
-	struct sta_bss_parameters bss_param;
 	struct nl80211_sta_flag_update sta_flags;
 
 	int generation;
 
-	u32 beacon_loss_count;
-
 	const u8 *assoc_req_ies;
 	size_t assoc_req_ies_len;
 
@@ -2160,27 +2201,13 @@ struct station_info {
 	enum nl80211_mesh_power_mode peer_pm;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
-	u32 expected_throughput;
-
-	u16 airtime_weight;
-
-	s8 ack_signal;
-	s8 avg_ack_signal;
-	struct cfg80211_tid_stats *pertid;
-
-	u64 tx_duration;
-	u64 rx_duration;
-	u64 rx_beacon;
-	u8 rx_beacon_signal_avg;
-
-	u32 rx_mpdu_count;
-	u32 fcs_err_count;
-
 	bool mlo_params_valid;
 	u8 assoc_link_id;
 	u8 mld_addr[ETH_ALEN] __aligned(2);
 	const u8 *assoc_resp_ies;
 	size_t assoc_resp_ies_len;
+
+	struct link_station_info deflink;
 };
 
 /**
@@ -8429,12 +8456,12 @@ void cfg80211_tx_mgmt_expired(struct wireless_dev *wdev, u64 cookie,
 /**
  * cfg80211_sinfo_alloc_tid_stats - allocate per-tid statistics.
  *
- * @sinfo: the station information
+ * @link_sinfo: the station information
  * @gfp: allocation flags
  *
  * Return: 0 on success. Non-zero on error.
  */
-int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
+int cfg80211_sinfo_alloc_tid_stats(struct link_station_info *link_sinfo, gfp_t gfp);
 
 /**
  * cfg80211_sinfo_release_content - release contents of station info
@@ -8446,7 +8473,7 @@ int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
  */
 static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 {
-	kfree(sinfo->pertid);
+	kfree(sinfo->deflink.pertid);
 }
 
 /**
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9320d4bc22ee..ea62d223a0e4 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4106,11 +4106,11 @@ struct ieee80211_prep_tx_info {
  *	is only used if the configured rate control algorithm actually uses
  *	the new rate table API, and is therefore optional. Must be atomic.
  *
- * @sta_statistics: Get statistics for this station. For example with beacon
- *	filtering, the statistics kept by mac80211 might not be accurate, so
- *	let the driver pre-fill the statistics. The driver can fill most of
- *	the values (indicating which by setting the filled bitmap), but not
- *	all of them make sense - see the source for which ones are possible.
+ * @link_sta_statistics: Get statistics for this link station. For example
+ *	with beacon filtering, the statistics kept by mac80211 might not be
+ *	accurate, so let the driver pre-fill the statistics. The driver can
+ *	fill most of the values (indicating which by setting the filled bitmap),
+ *	but not all of them make sense - see the source for which ones are possible.
  *	Statistics that the driver doesn't fill will be filled by mac80211.
  *	The callback can sleep.
  *
@@ -4593,10 +4593,10 @@ struct ieee80211_ops {
 	void (*sta_rate_tbl_update)(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_sta *sta);
-	void (*sta_statistics)(struct ieee80211_hw *hw,
-			       struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta,
-			       struct station_info *sinfo);
+	void (*link_sta_statistics)(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta,
+				    struct link_station_info *link_sinfo);
 	int (*conf_tx)(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif,
 		       unsigned int link_id, u16 ac,
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index c64531e0a60e..33365870ce86 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -613,10 +613,10 @@ static inline void drv_sta_rate_tbl_update(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
-static inline void drv_sta_statistics(struct ieee80211_local *local,
-				      struct ieee80211_sub_if_data *sdata,
-				      struct ieee80211_sta *sta,
-				      struct station_info *sinfo)
+static inline void drv_link_sta_statistics(struct ieee80211_local *local,
+					   struct ieee80211_sub_if_data *sdata,
+					   struct ieee80211_sta *sta,
+					   struct link_station_info *link_sinfo)
 {
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -625,9 +625,9 @@ static inline void drv_sta_statistics(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	trace_drv_sta_statistics(local, sdata, sta);
-	if (local->ops->sta_statistics)
-		local->ops->sta_statistics(&local->hw, &sdata->vif, sta, sinfo);
+	trace_drv_link_sta_statistics(local, sdata, sta);
+	if (local->ops->link_sta_statistics)
+		local->ops->link_sta_statistics(&local->hw, &sdata->vif, sta, link_sinfo);
 	trace_drv_return_void(local);
 }
 
diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 42f7ee142ce3..172e0c4659de 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -79,6 +79,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 	struct sta_info *sta;
 	struct ieee80211_local *local = sdata->local;
 	struct station_info sinfo;
+	struct link_station_info *link_sinfo;
 	struct survey_info survey;
 	int i, q;
 #define STA_STATS_SURVEY_LEN 7
@@ -87,17 +88,16 @@ static void ieee80211_get_stats(struct net_device *dev,
 
 #define ADD_STA_STATS(sta)					\
 	do {							\
-		data[i++] += sinfo.rx_packets;			\
-		data[i++] += sinfo.rx_bytes;			\
+		data[i++] += link_sinfo->rx_packets;		\
+		data[i++] += link_sinfo->rx_bytes;		\
 		data[i++] += (sta)->rx_stats.num_duplicates;	\
 		data[i++] += (sta)->rx_stats.fragments;		\
-		data[i++] += sinfo.rx_dropped_misc;		\
-								\
-		data[i++] += sinfo.tx_packets;			\
-		data[i++] += sinfo.tx_bytes;			\
+		data[i++] += link_sinfo->rx_dropped_misc;	\
+		data[i++] += link_sinfo->tx_packets;		\
+		data[i++] += link_sinfo->tx_bytes;		\
 		data[i++] += (sta)->status_stats.filtered;	\
-		data[i++] += sinfo.tx_failed;			\
-		data[i++] += sinfo.tx_retries;			\
+		data[i++] += link_sinfo->tx_failed;		\
+		data[i++] += link_sinfo->tx_retries;		\
 	} while (0)
 
 	/* For Managed stations, find the single station based on BSSID
@@ -117,23 +117,24 @@ static void ieee80211_get_stats(struct net_device *dev,
 		memset(&sinfo, 0, sizeof(sinfo));
 		sta_set_sinfo(sta, &sinfo, false);
 
+		link_sinfo = &sinfo.deflink;
 		i = 0;
 		ADD_STA_STATS(&sta->deflink);
 
 		data[i++] = sta->sta_state;
 
 
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))
 			data[i] = 100000ULL *
-				cfg80211_calculate_bitrate(&sinfo.txrate);
+				cfg80211_calculate_bitrate(&link_sinfo->txrate);
 		i++;
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE))
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE))
 			data[i] = 100000ULL *
-				cfg80211_calculate_bitrate(&sinfo.rxrate);
+				cfg80211_calculate_bitrate(&link_sinfo->rxrate);
 		i++;
 
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))
-			data[i] = (u8)sinfo.signal_avg;
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))
+			data[i] = (u8)link_sinfo->signal_avg;
 		i++;
 	} else {
 		list_for_each_entry(sta, &local->sta_list, list) {
@@ -143,6 +144,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 
 			memset(&sinfo, 0, sizeof(sinfo));
 			sta_set_sinfo(sta, &sinfo, false);
+			link_sinfo = &sinfo.deflink;
 			i = 0;
 			ADD_STA_STATS(&sta->deflink);
 		}
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 53f8da74fb99..985e53bf04bc 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2596,204 +2596,231 @@ static void sta_set_mesh_sinfo(struct sta_info *sta,
 }
 #endif
 
-void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
-		   bool tidstats)
+static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *link_sinfo,
+			       struct ieee80211_link_data *link_sdata, bool tidstats)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
 	u32 thr = 0;
 	int i, ac, cpu;
 	struct ieee80211_sta_rx_stats *last_rxstats;
+	struct link_sta_info *link_sta_info = &sta->deflink;
 
 	last_rxstats = sta_get_last_rx_stats(sta);
 
-	sinfo->generation = sdata->local->sta_generation;
 
 	/* do before driver, so beacon filtering drivers have a
 	 * chance to e.g. just add the number of filtered beacons
 	 * (or just modify the value entirely, of course)
 	 */
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		sinfo->rx_beacon = sdata->deflink.u.mgd.count_beacon_signal;
+		link_sinfo->rx_beacon = link_sdata->u.mgd.count_beacon_signal;
 
-	drv_sta_statistics(local, sdata, &sta->sta, sinfo);
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
-			 BIT_ULL(NL80211_STA_INFO_STA_FLAGS) |
+	drv_link_sta_statistics(local, sdata, &sta->sta, link_sinfo);
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
 			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
-			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME) |
-			 BIT_ULL(NL80211_STA_INFO_ASSOC_AT_BOOTTIME) |
 			 BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
 
 	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
-		sinfo->beacon_loss_count =
-			sdata->deflink.u.mgd.beacon_loss_count;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_LOSS);
+		link_sinfo->beacon_loss_count =
+			link_sdata->u.mgd.beacon_loss_count;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_LOSS);
 	}
 
-	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
-	sinfo->assoc_at = sta->assoc_at;
-	sinfo->inactive_time =
+	link_sinfo->inactive_time =
 		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta));
 
-	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
+	if (!(link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
-		sinfo->tx_bytes = 0;
+		link_sinfo->tx_bytes = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			sinfo->tx_bytes += sta->deflink.tx_stats.bytes[ac];
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
+			link_sinfo->tx_bytes += link_sta_info->tx_stats.bytes[ac];
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
 	}
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_PACKETS))) {
-		sinfo->tx_packets = 0;
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_PACKETS))) {
+		link_sinfo->tx_packets = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			sinfo->tx_packets += sta->deflink.tx_stats.packets[ac];
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+			link_sinfo->tx_packets += link_sta_info->tx_stats.packets[ac];
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
 	}
 
-	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES64) |
+	if (!(link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_RX_BYTES)))) {
-		sinfo->rx_bytes += sta_get_stats_bytes(&sta->deflink.rx_stats);
+		link_sinfo->rx_bytes += sta_get_stats_bytes(&link_sta_info->rx_stats);
 
-		if (sta->deflink.pcpu_rx_stats) {
+		if (link_sta_info->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats,
+				cpurxs = per_cpu_ptr(link_sta_info->pcpu_rx_stats,
 						     cpu);
-				sinfo->rx_bytes += sta_get_stats_bytes(cpurxs);
+				link_sinfo->rx_bytes += sta_get_stats_bytes(cpurxs);
 			}
 		}
 
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
 	}
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_PACKETS))) {
-		sinfo->rx_packets = sta->deflink.rx_stats.packets;
-		if (sta->deflink.pcpu_rx_stats) {
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_PACKETS))) {
+		link_sinfo->rx_packets = link_sta_info->rx_stats.packets;
+		if (link_sta_info->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats,
+				cpurxs = per_cpu_ptr(link_sta_info->pcpu_rx_stats,
 						     cpu);
-				sinfo->rx_packets += cpurxs->packets;
+				link_sinfo->rx_packets += cpurxs->packets;
 			}
 		}
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
 	}
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_RETRIES))) {
-		sinfo->tx_retries = sta->deflink.status_stats.retry_count;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_RETRIES))) {
+		link_sinfo->tx_retries = link_sta_info->status_stats.retry_count;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 	}
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED))) {
-		sinfo->tx_failed = sta->deflink.status_stats.retry_failed;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED))) {
+		link_sinfo->tx_failed = link_sta_info->status_stats.retry_failed;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 	}
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_DURATION))) {
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_DURATION))) {
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			sinfo->rx_duration += sta->airtime[ac].rx_airtime;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
+			link_sinfo->rx_duration += sta->airtime[ac].rx_airtime;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
 	}
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_DURATION))) {
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_DURATION))) {
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			sinfo->tx_duration += sta->airtime[ac].tx_airtime;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
+			link_sinfo->tx_duration += sta->airtime[ac].tx_airtime;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
 	}
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT))) {
-		sinfo->airtime_weight = sta->airtime_weight;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT);
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT))) {
+		link_sinfo->airtime_weight = sta->airtime_weight;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT);
 	}
 
-	sinfo->rx_dropped_misc = sta->deflink.rx_stats.dropped;
-	if (sta->deflink.pcpu_rx_stats) {
+	link_sinfo->rx_dropped_misc = link_sta_info->rx_stats.dropped;
+	if (link_sta_info->pcpu_rx_stats) {
 		for_each_possible_cpu(cpu) {
 			struct ieee80211_sta_rx_stats *cpurxs;
 
-			cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats, cpu);
-			sinfo->rx_dropped_misc += cpurxs->dropped;
+			cpurxs = per_cpu_ptr(link_sta_info->pcpu_rx_stats, cpu);
+			link_sinfo->rx_dropped_misc += cpurxs->dropped;
 		}
 	}
 
 	if (sdata->vif.type == NL80211_IFTYPE_STATION &&
 	    !(sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX) |
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX) |
 				 BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
-		sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif);
+		link_sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif);
 	}
 
 	if (ieee80211_hw_check(&sta->local->hw, SIGNAL_DBM) ||
 	    ieee80211_hw_check(&sta->local->hw, SIGNAL_UNSPEC)) {
-		if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL))) {
-			sinfo->signal = (s8)last_rxstats->last_signal;
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+		if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL))) {
+			link_sinfo->signal = (s8)last_rxstats->last_signal;
+			link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 		}
 
-		if (!sta->deflink.pcpu_rx_stats &&
-		    !(sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))) {
-			sinfo->signal_avg =
-				-ewma_signal_read(&sta->deflink.rx_stats_avg.signal);
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+		if (!link_sta_info->pcpu_rx_stats &&
+		    !(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))) {
+			link_sinfo->signal_avg =
+				-ewma_signal_read(&link_sta_info->rx_stats_avg.signal);
+			link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 		}
 	}
 
 	/* for the average - if pcpu_rx_stats isn't set - rxstats must point to
-	 * the sta->rx_stats struct, so the check here is fine with and without
+	 * the link_sta_info->rx_stats struct, so the check here is fine with and without
 	 * pcpu statistics
 	 */
 	if (last_rxstats->chains &&
-	    !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL) |
+	    !(link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL) |
 			       BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)))) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
-		if (!sta->deflink.pcpu_rx_stats)
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
+		if (!link_sta_info->pcpu_rx_stats)
+			link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
+		link_sinfo->chains = last_rxstats->chains;
 
-		sinfo->chains = last_rxstats->chains;
-
-		for (i = 0; i < ARRAY_SIZE(sinfo->chain_signal); i++) {
-			sinfo->chain_signal[i] =
+		for (i = 0; i < ARRAY_SIZE(link_sinfo->chain_signal); i++) {
+			link_sinfo->chain_signal[i] =
 				last_rxstats->chain_signal_last[i];
-			sinfo->chain_signal_avg[i] =
-				-ewma_signal_read(&sta->deflink.rx_stats_avg.chain_signal[i]);
+			link_sinfo->chain_signal_avg[i] =
+				-ewma_signal_read(&link_sta_info->rx_stats_avg.chain_signal[i]);
 		}
 	}
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
 	    !sta->sta.valid_links &&
-	    ieee80211_rate_valid(&sta->deflink.tx_stats.last_rate)) {
-		sta_set_rate_info_tx(sta, &sta->deflink.tx_stats.last_rate,
-				     &sinfo->txrate);
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	    ieee80211_rate_valid(&link_sta_info->tx_stats.last_rate)) {
+		sta_set_rate_info_tx(sta, &link_sta_info->tx_stats.last_rate,
+				     &link_sinfo->txrate);
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) &&
-	    !sta->sta.valid_links) {
-		if (sta_set_rate_info_rx(sta, &sinfo->rxrate) == 0)
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) &&
+	    !sta->sta.valid_links){
+		if (sta_set_rate_info_rx(sta, &link_sinfo->rxrate) == 0)
+			link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
 	}
 
-	if (tidstats && !cfg80211_sinfo_alloc_tid_stats(sinfo, GFP_KERNEL)) {
+	if (tidstats && !cfg80211_sinfo_alloc_tid_stats(link_sinfo, GFP_KERNEL)) {
 		for (i = 0; i < IEEE80211_NUM_TIDS + 1; i++)
-			sta_set_tidstats(sta, &sinfo->pertid[i], i);
+			sta_set_tidstats(sta, &link_sinfo->pertid[i], i);
 	}
 
-#ifdef CONFIG_MAC80211_MESH
-	if (ieee80211_vif_is_mesh(&sdata->vif))
-		sta_set_mesh_sinfo(sta, sinfo);
-#endif
+	link_sinfo->bss_param.flags = 0;
+	if (link_sdata->conf->use_cts_prot)
+		link_sinfo->bss_param.flags |= BSS_PARAM_FLAGS_CTS_PROT;
+	if (link_sdata->conf->use_short_preamble)
+		link_sinfo->bss_param.flags |= BSS_PARAM_FLAGS_SHORT_PREAMBLE;
+	if (link_sdata->conf->use_short_slot)
+		link_sinfo->bss_param.flags |= BSS_PARAM_FLAGS_SHORT_SLOT_TIME;
+	link_sinfo->bss_param.dtim_period = link_sdata->conf->dtim_period;
+	link_sinfo->bss_param.beacon_interval = link_sdata->conf->beacon_int;
+
+	thr = sta_get_expected_throughput(sta);
+
+	if (thr != 0) {
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
+		link_sinfo->expected_throughput = thr;
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL)) &&
+	    link_sta_info->status_stats.ack_signal_filled) {
+		link_sinfo->ack_signal = link_sta_info->status_stats.last_ack_signal;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG)) &&
+	    link_sta_info->status_stats.ack_signal_filled) {
+		link_sinfo->avg_ack_signal =
+			-(s8)ewma_avg_signal_read(&link_sta_info->status_stats.avg_ack_signal);
+		link_sinfo->filled |=
+			BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
+	}
+}
 
-	sinfo->bss_param.flags = 0;
-	if (sdata->vif.bss_conf.use_cts_prot)
-		sinfo->bss_param.flags |= BSS_PARAM_FLAGS_CTS_PROT;
-	if (sdata->vif.bss_conf.use_short_preamble)
-		sinfo->bss_param.flags |= BSS_PARAM_FLAGS_SHORT_PREAMBLE;
-	if (sdata->vif.bss_conf.use_short_slot)
-		sinfo->bss_param.flags |= BSS_PARAM_FLAGS_SHORT_SLOT_TIME;
-	sinfo->bss_param.dtim_period = sdata->vif.bss_conf.dtim_period;
-	sinfo->bss_param.beacon_interval = sdata->vif.bss_conf.beacon_int;
+void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
+		   bool tidstats)
+{
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct link_station_info *link_sinfo = &sinfo->deflink;
+	struct ieee80211_link_data *link_sdata = &sdata->deflink;
+
+	sinfo->generation = sdata->local->sta_generation;
+
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_STA_FLAGS) |
+			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME) |
+			 BIT_ULL(NL80211_STA_INFO_ASSOC_AT_BOOTTIME);
+
+	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
+	sinfo->assoc_at = sta->assoc_at;
 
 	sinfo->sta_flags.set = 0;
 	sinfo->sta_flags.mask = BIT(NL80211_STA_FLAG_AUTHORIZED) |
@@ -2803,6 +2830,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 				BIT(NL80211_STA_FLAG_AUTHENTICATED) |
 				BIT(NL80211_STA_FLAG_ASSOCIATED) |
 				BIT(NL80211_STA_FLAG_TDLS_PEER);
+
 	if (test_sta_flag(sta, WLAN_STA_AUTHORIZED))
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_AUTHORIZED);
 	if (test_sta_flag(sta, WLAN_STA_SHORT_PREAMBLE))
@@ -2818,27 +2846,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER))
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
 
-	thr = sta_get_expected_throughput(sta);
-
-	if (thr != 0) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
-		sinfo->expected_throughput = thr;
-	}
-
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL)) &&
-	    sta->deflink.status_stats.ack_signal_filled) {
-		sinfo->ack_signal = sta->deflink.status_stats.last_ack_signal;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
-	}
+#ifdef CONFIG_MAC80211_MESH
+	if (ieee80211_vif_is_mesh(&sdata->vif))
+		sta_set_mesh_sinfo(sta, sinfo);
+#endif
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG)) &&
-	    sta->deflink.status_stats.ack_signal_filled) {
-		sinfo->avg_ack_signal =
-			-(s8)ewma_avg_signal_read(
-				&sta->deflink.status_stats.avg_ack_signal);
-		sinfo->filled |=
-			BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
-	}
+	sta_set_link_sinfo(sta, link_sinfo, link_sdata, tidstats);
 }
 
 u32 sta_get_expected_throughput(struct sta_info *sta)
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index dc35fed7e9b0..1477506c76d6 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -995,7 +995,7 @@ DECLARE_EVENT_CLASS(sta_event,
 	)
 );
 
-DEFINE_EVENT(sta_event, drv_sta_statistics,
+DEFINE_EVENT(sta_event, drv_link_sta_statistics,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
 		 struct ieee80211_sta *sta),
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d90033e03dd6..7740ab5c778d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6670,185 +6670,151 @@ static bool nl80211_put_signal(struct sk_buff *msg, u8 mask, s8 *signal,
 	return true;
 }
 
-static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
-				u32 seq, int flags,
-				struct cfg80211_registered_device *rdev,
-				struct net_device *dev,
-				const u8 *mac_addr, struct station_info *sinfo)
+static int nl80211_fill_link_station(struct sk_buff *msg,
+				     struct cfg80211_registered_device *rdev,
+				     struct link_station_info *link_sinfo)
 {
-	void *hdr;
-	struct nlattr *sinfoattr, *bss_param;
+	struct nlattr *bss_param;
 
-	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
-	if (!hdr) {
-		cfg80211_sinfo_release_content(sinfo);
-		return -1;
-	}
-
-	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
-	    nla_put_u32(msg, NL80211_ATTR_GENERATION, sinfo->generation))
-		goto nla_put_failure;
-
-	sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
-	if (!sinfoattr)
-		goto nla_put_failure;
-
-#define PUT_SINFO(attr, memb, type) do {				\
+#define PUT_LINK_SINFO(attr, memb, type) do {				\
 	BUILD_BUG_ON(sizeof(type) == sizeof(u64));			\
-	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
 	    nla_put_ ## type(msg, NL80211_STA_INFO_ ## attr,		\
-			     sinfo->memb))				\
-		goto nla_put_failure;					\
+			     link_sinfo->memb))				\
+		return -EMSGSIZE;					\
 	} while (0)
-#define PUT_SINFO_U64(attr, memb) do {					\
-	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
+#define PUT_LINK_SINFO_U64(attr, memb) do {				\
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
 	    nla_put_u64_64bit(msg, NL80211_STA_INFO_ ## attr,		\
-			      sinfo->memb, NL80211_STA_INFO_PAD))	\
-		goto nla_put_failure;					\
+			      link_sinfo->memb, NL80211_STA_INFO_PAD))	\
+		return -EMSGSIZE;					\
 	} while (0)
 
-	PUT_SINFO(CONNECTED_TIME, connected_time, u32);
-	PUT_SINFO(INACTIVE_TIME, inactive_time, u32);
-	PUT_SINFO_U64(ASSOC_AT_BOOTTIME, assoc_at);
+	PUT_LINK_SINFO(CONNECTED_TIME, connected_time, u32);
+	PUT_LINK_SINFO(INACTIVE_TIME, inactive_time, u32);
+	PUT_LINK_SINFO_U64(ASSOC_AT_BOOTTIME, assoc_at);
 
-	if (sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
-			     BIT_ULL(NL80211_STA_INFO_RX_BYTES64)) &&
+	if (link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
+				  BIT_ULL(NL80211_STA_INFO_RX_BYTES64)) &&
 	    nla_put_u32(msg, NL80211_STA_INFO_RX_BYTES,
-			(u32)sinfo->rx_bytes))
-		goto nla_put_failure;
+			(u32)link_sinfo->rx_bytes))
+		return -EMSGSIZE;
 
-	if (sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
-			     BIT_ULL(NL80211_STA_INFO_TX_BYTES64)) &&
+	if (link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
+				  BIT_ULL(NL80211_STA_INFO_TX_BYTES64)) &&
 	    nla_put_u32(msg, NL80211_STA_INFO_TX_BYTES,
-			(u32)sinfo->tx_bytes))
-		goto nla_put_failure;
+			(u32)link_sinfo->tx_bytes))
+		return -EMSGSIZE;
 
-	PUT_SINFO_U64(RX_BYTES64, rx_bytes);
-	PUT_SINFO_U64(TX_BYTES64, tx_bytes);
-	PUT_SINFO_U64(RX_DURATION, rx_duration);
-	PUT_SINFO_U64(TX_DURATION, tx_duration);
+	PUT_LINK_SINFO_U64(RX_BYTES64, rx_bytes);
+	PUT_LINK_SINFO_U64(TX_BYTES64, tx_bytes);
+	PUT_LINK_SINFO_U64(RX_DURATION, rx_duration);
+	PUT_LINK_SINFO_U64(TX_DURATION, tx_duration);
 
 	if (wiphy_ext_feature_isset(&rdev->wiphy,
 				    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
-		PUT_SINFO(AIRTIME_WEIGHT, airtime_weight, u16);
+		PUT_LINK_SINFO(AIRTIME_WEIGHT, airtime_weight, u16);
 
 	switch (rdev->wiphy.signal_type) {
 	case CFG80211_SIGNAL_TYPE_MBM:
-		PUT_SINFO(SIGNAL, signal, u8);
-		PUT_SINFO(SIGNAL_AVG, signal_avg, u8);
+		PUT_LINK_SINFO(SIGNAL, signal, u8);
+		PUT_LINK_SINFO(SIGNAL_AVG, signal_avg, u8);
 		break;
 	default:
 		break;
 	}
-	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) {
-		if (!nl80211_put_signal(msg, sinfo->chains,
-					sinfo->chain_signal,
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) {
+		if (!nl80211_put_signal(msg, link_sinfo->chains,
+					link_sinfo->chain_signal,
 					NL80211_STA_INFO_CHAIN_SIGNAL))
-			goto nla_put_failure;
+			return -EMSGSIZE;
 	}
-	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)) {
-		if (!nl80211_put_signal(msg, sinfo->chains,
-					sinfo->chain_signal_avg,
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)) {
+		if (!nl80211_put_signal(msg, link_sinfo->chains,
+					link_sinfo->chain_signal_avg,
 					NL80211_STA_INFO_CHAIN_SIGNAL_AVG))
-			goto nla_put_failure;
+			return -EMSGSIZE;
 	}
-	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) {
-		if (!nl80211_put_sta_rate(msg, &sinfo->txrate,
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) {
+		if (!nl80211_put_sta_rate(msg, &link_sinfo->txrate,
 					  NL80211_STA_INFO_TX_BITRATE))
-			goto nla_put_failure;
+			return -EMSGSIZE;
 	}
-	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) {
-		if (!nl80211_put_sta_rate(msg, &sinfo->rxrate,
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) {
+		if (!nl80211_put_sta_rate(msg, &link_sinfo->rxrate,
 					  NL80211_STA_INFO_RX_BITRATE))
-			goto nla_put_failure;
+			return -EMSGSIZE;
 	}
 
-	PUT_SINFO(RX_PACKETS, rx_packets, u32);
-	PUT_SINFO(TX_PACKETS, tx_packets, u32);
-	PUT_SINFO(TX_RETRIES, tx_retries, u32);
-	PUT_SINFO(TX_FAILED, tx_failed, u32);
-	PUT_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
-	PUT_SINFO(BEACON_LOSS, beacon_loss_count, u32);
+	PUT_LINK_SINFO(RX_PACKETS, rx_packets, u32);
+	PUT_LINK_SINFO(TX_PACKETS, tx_packets, u32);
+	PUT_LINK_SINFO(TX_RETRIES, tx_retries, u32);
+	PUT_LINK_SINFO(TX_FAILED, tx_failed, u32);
+	PUT_LINK_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
+	PUT_LINK_SINFO(BEACON_LOSS, beacon_loss_count, u32);
 
-	PUT_SINFO(LLID, llid, u16);
-	PUT_SINFO(PLID, plid, u16);
-	PUT_SINFO(PLINK_STATE, plink_state, u8);
-	PUT_SINFO(AIRTIME_LINK_METRIC, airtime_link_metric, u32);
-	PUT_SINFO(LOCAL_PM, local_pm, u32);
-	PUT_SINFO(PEER_PM, peer_pm, u32);
-	PUT_SINFO(NONPEER_PM, nonpeer_pm, u32);
-	PUT_SINFO(CONNECTED_TO_GATE, connected_to_gate, u8);
-	PUT_SINFO(CONNECTED_TO_AS, connected_to_as, u8);
-	PUT_SINFO_U64(T_OFFSET, t_offset);
-
-	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
 		bss_param = nla_nest_start_noflag(msg,
 						  NL80211_STA_INFO_BSS_PARAM);
 		if (!bss_param)
-			goto nla_put_failure;
+			return -EMSGSIZE;
 
-		if (((sinfo->bss_param.flags & BSS_PARAM_FLAGS_CTS_PROT) &&
+		if (((link_sinfo->bss_param.flags & BSS_PARAM_FLAGS_CTS_PROT) &&
 		     nla_put_flag(msg, NL80211_STA_BSS_PARAM_CTS_PROT)) ||
-		    ((sinfo->bss_param.flags & BSS_PARAM_FLAGS_SHORT_PREAMBLE) &&
+		    ((link_sinfo->bss_param.flags & BSS_PARAM_FLAGS_SHORT_PREAMBLE) &&
 		     nla_put_flag(msg, NL80211_STA_BSS_PARAM_SHORT_PREAMBLE)) ||
-		    ((sinfo->bss_param.flags & BSS_PARAM_FLAGS_SHORT_SLOT_TIME) &&
+		    ((link_sinfo->bss_param.flags & BSS_PARAM_FLAGS_SHORT_SLOT_TIME) &&
 		     nla_put_flag(msg, NL80211_STA_BSS_PARAM_SHORT_SLOT_TIME)) ||
 		    nla_put_u8(msg, NL80211_STA_BSS_PARAM_DTIM_PERIOD,
-			       sinfo->bss_param.dtim_period) ||
+			       link_sinfo->bss_param.dtim_period) ||
 		    nla_put_u16(msg, NL80211_STA_BSS_PARAM_BEACON_INTERVAL,
-				sinfo->bss_param.beacon_interval))
-			goto nla_put_failure;
+				link_sinfo->bss_param.beacon_interval))
+			return -EMSGSIZE;
 
 		nla_nest_end(msg, bss_param);
 	}
-	if ((sinfo->filled & BIT_ULL(NL80211_STA_INFO_STA_FLAGS)) &&
-	    nla_put(msg, NL80211_STA_INFO_STA_FLAGS,
-		    sizeof(struct nl80211_sta_flag_update),
-		    &sinfo->sta_flags))
-		goto nla_put_failure;
 
-	PUT_SINFO_U64(RX_DROP_MISC, rx_dropped_misc);
-	PUT_SINFO_U64(BEACON_RX, rx_beacon);
-	PUT_SINFO(BEACON_SIGNAL_AVG, rx_beacon_signal_avg, u8);
-	PUT_SINFO(RX_MPDUS, rx_mpdu_count, u32);
-	PUT_SINFO(FCS_ERROR_COUNT, fcs_err_count, u32);
+	PUT_LINK_SINFO_U64(RX_DROP_MISC, rx_dropped_misc);
+	PUT_LINK_SINFO_U64(BEACON_RX, rx_beacon);
+	PUT_LINK_SINFO(BEACON_SIGNAL_AVG, rx_beacon_signal_avg, u8);
+	PUT_LINK_SINFO(RX_MPDUS, rx_mpdu_count, u32);
+	PUT_LINK_SINFO(FCS_ERROR_COUNT, fcs_err_count, u32);
 	if (wiphy_ext_feature_isset(&rdev->wiphy,
 				    NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT)) {
-		PUT_SINFO(ACK_SIGNAL, ack_signal, u8);
-		PUT_SINFO(ACK_SIGNAL_AVG, avg_ack_signal, s8);
+		PUT_LINK_SINFO(ACK_SIGNAL, ack_signal, u8);
+		PUT_LINK_SINFO(ACK_SIGNAL_AVG, avg_ack_signal, s8);
 	}
 
-#undef PUT_SINFO
-#undef PUT_SINFO_U64
+#undef PUT_LINK_SINFO
+#undef PUT_LINK_SINFO_U64
 
-	if (sinfo->pertid) {
+	if (link_sinfo->pertid) {
 		struct nlattr *tidsattr;
 		int tid;
 
 		tidsattr = nla_nest_start_noflag(msg,
 						 NL80211_STA_INFO_TID_STATS);
 		if (!tidsattr)
-			goto nla_put_failure;
+			return -EMSGSIZE;
 
 		for (tid = 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
 			struct cfg80211_tid_stats *tidstats;
 			struct nlattr *tidattr;
 
-			tidstats = &sinfo->pertid[tid];
+			tidstats = &link_sinfo->pertid[tid];
 
 			if (!tidstats->filled)
 				continue;
 
 			tidattr = nla_nest_start_noflag(msg, tid + 1);
 			if (!tidattr)
-				goto nla_put_failure;
+				return -EMSGSIZE;
 
 #define PUT_TIDVAL_U64(attr, memb) do {					\
 	if (tidstats->filled & BIT(NL80211_TID_STATS_ ## attr) &&	\
 	    nla_put_u64_64bit(msg, NL80211_TID_STATS_ ## attr,		\
 			      tidstats->memb, NL80211_TID_STATS_PAD))	\
-		goto nla_put_failure;					\
+		return -EMSGSIZE;					\
 	} while (0)
 
 			PUT_TIDVAL_U64(RX_MSDU, rx_msdu);
@@ -6861,7 +6827,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 			     BIT(NL80211_TID_STATS_TXQ_STATS)) &&
 			    !nl80211_put_txq_stats(msg, &tidstats->txq_stats,
 						   NL80211_TID_STATS_TXQ_STATS))
-				goto nla_put_failure;
+				return -EMSGSIZE;
 
 			nla_nest_end(msg, tidattr);
 		}
@@ -6869,16 +6835,29 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		nla_nest_end(msg, tidsattr);
 	}
 
-	nla_nest_end(msg, sinfoattr);
+	return 0;
+}
 
-	if (sinfo->assoc_req_ies_len &&
-	    nla_put(msg, NL80211_ATTR_IE, sinfo->assoc_req_ies_len,
-		    sinfo->assoc_req_ies))
-		goto nla_put_failure;
+static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
+				u32 seq, int flags,
+				struct cfg80211_registered_device *rdev,
+				struct net_device *dev,
+				const u8 *mac_addr, struct station_info *sinfo)
+{
+	struct nlattr *sinfoattr;
+	void *hdr;
+	struct link_station_info *link_sinfo = &sinfo->deflink;
+	int ret = -1;
 
-	if (sinfo->assoc_resp_ies_len &&
-	    nla_put(msg, NL80211_ATTR_RESP_IE, sinfo->assoc_resp_ies_len,
-		    sinfo->assoc_resp_ies))
+	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
+	if (!hdr) {
+		cfg80211_sinfo_release_content(sinfo);
+		return ret;
+	}
+
+	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
+	    nla_put_u32(msg, NL80211_ATTR_GENERATION, sinfo->generation))
 		goto nla_put_failure;
 
 	if (sinfo->mlo_params_valid) {
@@ -6892,11 +6871,68 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 			goto nla_put_failure;
 	}
 
+	if (sinfo->assoc_req_ies_len &&
+	    nla_put(msg, NL80211_ATTR_IE, sinfo->assoc_req_ies_len,
+		    sinfo->assoc_req_ies))
+		goto nla_put_failure;
+
+	if (sinfo->assoc_resp_ies_len &&
+	    nla_put(msg, NL80211_ATTR_RESP_IE, sinfo->assoc_resp_ies_len,
+		    sinfo->assoc_resp_ies))
+		goto nla_put_failure;
+
+	sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
+	if (!sinfoattr)
+		goto nla_put_failure;
+
+	if ((sinfo->filled & BIT_ULL(NL80211_STA_INFO_STA_FLAGS)) &&
+	    nla_put(msg, NL80211_STA_INFO_STA_FLAGS,
+		    sizeof(struct nl80211_sta_flag_update),
+		    &sinfo->sta_flags))
+		goto nla_put_failure;
+
+#define PUT_SINFO(attr, memb, type) do {				\
+	BUILD_BUG_ON(sizeof(type) == sizeof(u64));			\
+	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
+	    nla_put_ ## type(msg, NL80211_STA_INFO_ ## attr,		\
+			     sinfo->memb))				\
+		goto nla_put_failure;					\
+	} while (0)
+#define PUT_SINFO_U64(attr, memb) do {					\
+	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
+	    nla_put_u64_64bit(msg, NL80211_STA_INFO_ ## attr,		\
+			      sinfo->memb, NL80211_STA_INFO_PAD))	\
+		goto nla_put_failure;					\
+	} while (0)
+
+	PUT_SINFO(CONNECTED_TIME, connected_time, u32);
+	PUT_SINFO_U64(ASSOC_AT_BOOTTIME, assoc_at);
+
+	PUT_SINFO(LLID, llid, u16);
+	PUT_SINFO(PLID, plid, u16);
+	PUT_SINFO(PLINK_STATE, plink_state, u8);
+	PUT_SINFO(AIRTIME_LINK_METRIC, airtime_link_metric, u32);
+	PUT_SINFO(LOCAL_PM, local_pm, u32);
+	PUT_SINFO(PEER_PM, peer_pm, u32);
+	PUT_SINFO(NONPEER_PM, nonpeer_pm, u32);
+	PUT_SINFO(CONNECTED_TO_GATE, connected_to_gate, u8);
+	PUT_SINFO(CONNECTED_TO_AS, connected_to_as, u8);
+	PUT_SINFO_U64(T_OFFSET, t_offset);
+
+#undef PUT_SINFO
+#undef PUT_SINFO_U64
+
+	ret = nl80211_fill_link_station(msg, rdev, link_sinfo);
+	if (ret)
+		goto nla_put_failure;
+
+	nla_nest_end(msg, sinfoattr);
+
 	cfg80211_sinfo_release_content(sinfo);
 	genlmsg_end(msg, hdr);
 	return 0;
 
- nla_put_failure:
+nla_put_failure:
 	cfg80211_sinfo_release_content(sinfo);
 	genlmsg_cancel(msg, hdr);
 	return -EMSGSIZE;
@@ -13005,11 +13041,10 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 		err = rdev_get_station(rdev, dev, mac_addr, &sinfo);
 		if (err)
 			return err;
-
 		cfg80211_sinfo_release_content(&sinfo);
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG))
+		if (sinfo.deflink.filled & BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG))
 			cqm_config->last_rssi_event_value =
-				(s8) sinfo.rx_beacon_signal_avg;
+				(s8)sinfo.deflink.rx_beacon_signal_avg;
 	}
 
 	last = cqm_config->last_rssi_event_value;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index a57210c8087c..69193fc3b040 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -200,22 +200,23 @@
 		    __field(u16, llid)		    \
 		    __field(u16, plid)		    \
 		    __field(u8, plink_state)
-#define SINFO_ASSIGN						       \
-	do {							       \
-		__entry->generation = sinfo->generation;	       \
-		__entry->connected_time = sinfo->connected_time;       \
-		__entry->inactive_time = sinfo->inactive_time;	       \
-		__entry->rx_bytes = sinfo->rx_bytes;		       \
-		__entry->tx_bytes = sinfo->tx_bytes;		       \
-		__entry->rx_packets = sinfo->rx_packets;	       \
-		__entry->tx_packets = sinfo->tx_packets;	       \
-		__entry->tx_retries = sinfo->tx_retries;	       \
-		__entry->tx_failed = sinfo->tx_failed;		       \
-		__entry->rx_dropped_misc = sinfo->rx_dropped_misc;     \
-		__entry->beacon_loss_count = sinfo->beacon_loss_count; \
-		__entry->llid = sinfo->llid;			       \
-		__entry->plid = sinfo->plid;			       \
-		__entry->plink_state = sinfo->plink_state;	       \
+#define SINFO_ASSIGN							\
+	struct link_station_info *link_sinfo = &sinfo->deflink;		\
+	do {								\
+		__entry->generation = sinfo->generation;		\
+		__entry->connected_time = link_sinfo->connected_time;	\
+		__entry->inactive_time = link_sinfo->inactive_time;	\
+		__entry->rx_bytes = link_sinfo->rx_bytes;		\
+		__entry->tx_bytes = link_sinfo->tx_bytes;		\
+		__entry->rx_packets = link_sinfo->rx_packets;		\
+		__entry->tx_packets = link_sinfo->tx_packets;		\
+		__entry->tx_retries = link_sinfo->tx_retries;		\
+		__entry->tx_failed = link_sinfo->tx_failed;		\
+		__entry->rx_dropped_misc = link_sinfo->rx_dropped_misc;	\
+		__entry->beacon_loss_count = link_sinfo->beacon_loss_count; \
+		__entry->llid = sinfo->llid;				\
+		__entry->plid = sinfo->plid;				\
+		__entry->plink_state = sinfo->plink_state;		\
 	} while (0)
 
 #define BOOL_TO_STR(bo) (bo) ? "true" : "false"
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 60157943d351..dbb2313b6982 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2626,12 +2626,12 @@ bool cfg80211_does_bw_fit_range(const struct ieee80211_freq_range *freq_range,
 	return false;
 }
 
-int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp)
+int cfg80211_sinfo_alloc_tid_stats(struct link_station_info *link_sinfo, gfp_t gfp)
 {
-	sinfo->pertid = kcalloc(IEEE80211_NUM_TIDS + 1,
-				sizeof(*(sinfo->pertid)),
-				gfp);
-	if (!sinfo->pertid)
+	link_sinfo->pertid = kcalloc(IEEE80211_NUM_TIDS + 1,
+				     sizeof(*(link_sinfo->pertid)),
+				     gfp);
+	if (!link_sinfo->pertid)
 		return -ENOMEM;
 
 	return 0;
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index a74b1afc594e..a59510deffae 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -1267,12 +1267,12 @@ static int cfg80211_wext_giwrate(struct net_device *dev,
 	if (err)
 		return err;
 
-	if (!(sinfo.filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))) {
+	if (!(sinfo.deflink.filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))) {
 		err = -EOPNOTSUPP;
 		goto free;
 	}
 
-	rate->value = 100000 * cfg80211_calculate_bitrate(&sinfo.txrate);
+	rate->value = 100000 * cfg80211_calculate_bitrate(&sinfo.deflink.txrate);
 
 free:
 	cfg80211_sinfo_release_content(&sinfo);
@@ -1316,8 +1316,8 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 
 	switch (rdev->wiphy.signal_type) {
 	case CFG80211_SIGNAL_TYPE_MBM:
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
-			int sig = sinfo.signal;
+		if (sinfo.deflink.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
+			int sig = sinfo.deflink.signal;
 			wstats.qual.updated |= IW_QUAL_LEVEL_UPDATED;
 			wstats.qual.updated |= IW_QUAL_QUAL_UPDATED;
 			wstats.qual.updated |= IW_QUAL_DBM;
@@ -1331,11 +1331,11 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 		}
 		fallthrough;
 	case CFG80211_SIGNAL_TYPE_UNSPEC:
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
+		if (sinfo.deflink.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
 			wstats.qual.updated |= IW_QUAL_LEVEL_UPDATED;
 			wstats.qual.updated |= IW_QUAL_QUAL_UPDATED;
-			wstats.qual.level = sinfo.signal;
-			wstats.qual.qual = sinfo.signal;
+			wstats.qual.level = sinfo.deflink.signal;
+			wstats.qual.qual = sinfo.deflink.signal;
 			break;
 		}
 		fallthrough;
@@ -1345,10 +1345,10 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 	}
 
 	wstats.qual.updated |= IW_QUAL_NOISE_INVALID;
-	if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC))
-		wstats.discard.misc = sinfo.rx_dropped_misc;
-	if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED))
-		wstats.discard.retries = sinfo.tx_failed;
+	if (sinfo.deflink.filled & BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC))
+		wstats.discard.misc = sinfo.deflink.rx_dropped_misc;
+	if (sinfo.deflink.filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED))
+		wstats.discard.retries = sinfo.deflink.tx_failed;
 
 	cfg80211_sinfo_release_content(&sinfo);
 
-- 
2.34.1


