Return-Path: <linux-wireless+bounces-17643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB55A14F9D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 13:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A5F3A2A7A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 12:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4479C1F7917;
	Fri, 17 Jan 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RWdbrG//"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596A1FF7A9
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117999; cv=none; b=YeS0MyIUkeQRnuxizTuYZM0aw+G4PS3kS8BowZgrxLztRt8vB096PfmEHF8Uf7nV6mVQM+RYA6tXNlZyHtNRzigvZZuJ4MH/JyAbKut7DXjXqLKr5Zz0sYi3/fY0YzKMo1jPE0crHKGpZjdkoomXAKG/kMo/G7yKDqaOendZ04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117999; c=relaxed/simple;
	bh=jhSOQfCkNFrI3/qKnDoFDREmjjhA/jBCQhiplSW2JuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mc/PgcMC7J7IoPNOr74Z0FyquXc/jJcoNzcxLE+eVYCgyGcmIondGW0fSXz+LYH0eQm9XMzCcFnn7XVsox+HIiJYv5b9KdZMtsntaz/TfFsynp6BhJ4fiXnLsI3Rqz3p+HTLL6tANFhZVAHm+xPmf2IbNT99e2G9k/a+LIhXwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RWdbrG//; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H9Saxk009414;
	Fri, 17 Jan 2025 12:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	28XlwDNKxLF2KeSnmnZzdwoxeJoKziFn1/uCqis5PJ4=; b=RWdbrG//ztOW6tx9
	phZiJC4Uvf4DWu2tTp8hOI5/TK3QdvHsyA1gqVffsucU4e3mUoSRrWqnsuKKHjuZ
	qGf8s5udV2pQk0IxIyio/Sy9HOqqPxEMkD14IR5vMOakGfniWJFjAecrWpCvbyC6
	OnIsC0HM+nBkxJAy/E/YhVtfdMxQ4z6Zo0msyFeIf7w4Q4jZwRWa65tvyKS3Zy0s
	cTkn31rFBgIBMsllOUldyQksDYSB95lRgiFuG4d3ZUjhXcczwZt+aHoAAQaD1fRe
	Qm6fpQBWbsCQXZyc9PMNk6ktfEuuIOwThV/PmthXB7UiHsmpn25q2hJOzJqTwbbb
	gEuVyQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447mm00gjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:46:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50HCkWcL023190
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:46:32 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 Jan 2025 04:46:30 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC v2 06/12] wifi: cfg80211: reorg sinfo structure elements for MLO
Date: Fri, 17 Jan 2025 18:15:48 +0530
Message-ID: <20250117124554.3719808-7-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
References: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: Avv5PcgzJlQy2Mx-LM9xf2fUONSyI2vY
X-Proofpoint-ORIG-GUID: Avv5PcgzJlQy2Mx-LM9xf2fUONSyI2vY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501170103

Current implementation of NL80211_GET_STATION does not work for
multi-link operation(MLO) since in case of MLO only deflink (or one
of the links) is considered and not all links.

Therefore to support for MLO, start reorganizing sinfo structure
related data elements and add link_sinfo structure for link-level
statistics and keep station related data at sinfo structure.
Currently, changes are done at the deflink(or one of the links) level.
Actual link-level changes will be added in subsequent changes.

Also currently, mac80211 ops .sta_statistics() is mapped to fill sinfo
structure. But to add support for station statistics at link level,
change the ops to .link_sta_statistics() to fill link_sinfo structure.

Additionally, move connected_time before assoc_at in station_info
structure to get minimal holes.
pahole summary before this change:
 - size: 232, cachelines: 4, members: 23
 - sum members: 223, holes: 3, sum holes: 9
 - forced alignments: 1
 - last cacheline: 40 bytes

pahole summary after this change:
 - size: 224, cachelines: 4, members: 23
 - sum members: 223, holes: 1, sum holes: 1
 - forced alignments: 1
 - last cacheline: 32 bytes

NOTE:
 - Currently this patch is not-bisectable, once RFC patches are
   approved could add other required driver changes.
 - Have included ath12k driver changes as an example that could be
   used as reference for other drivers.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c |  12 +-
 include/net/cfg80211.h                | 169 +++++++++++++++-----------
 include/net/mac80211.h                |  18 +--
 net/mac80211/driver-ops.h             |  14 +--
 net/mac80211/ethtool.c                |  31 ++---
 net/mac80211/sta_info.c               |  11 +-
 net/mac80211/trace.h                  |   2 +-
 net/wireless/nl80211.c                |   9 +-
 net/wireless/trace.h                  |  33 ++---
 net/wireless/util.c                   |   6 +-
 net/wireless/wext-compat.c            |  22 ++--
 11 files changed, 183 insertions(+), 144 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c4eab4c1c10e..ef4f7eb07763 100644
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
+					      struct link_station_info *sinfo)
 {
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
 	struct ath12k_link_sta *arsta;
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
index 77f72a46ce42..9c7a0dbf5d3d 100644
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
@@ -2117,35 +2176,19 @@ struct cfg80211_tid_stats {
  *	dump_station() callbacks. User space needs this information to determine
  *	the accepted and rejected affiliated links of the connected station.
  * @assoc_resp_ies_len: Length of @assoc_resp_ies buffer in octets.
+ * @links: reference to Link sta entries for MLO STA. For non-MLO STA
+ *	and case where the driver offload link decisions and do not provide
+ *	per-link statistics, all link specific information is accessed
+ *	through links[0].
  */
 struct station_info {
 	u64 filled;
-	u32 connected_time;
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
+	u32 connected_time;
 	struct nl80211_sta_flag_update sta_flags;
 
 	int generation;
 
-	u32 beacon_loss_count;
-
 	const u8 *assoc_req_ies;
 	size_t assoc_req_ies_len;
 
@@ -2160,27 +2203,14 @@ struct station_info {
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
+	/* TODO: Need to check and add protection access to links memory */
+	struct link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
 /**
@@ -8434,7 +8464,7 @@ void cfg80211_tx_mgmt_expired(struct wireless_dev *wdev, u64 cookie,
  *
  * Return: 0 on success. Non-zero on error.
  */
-int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
+int cfg80211_sinfo_alloc_tid_stats(struct link_station_info *sinfo, gfp_t gfp);
 
 /**
  * cfg80211_sinfo_release_content - release contents of station info
@@ -8446,7 +8476,8 @@ int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
  */
 static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 {
-	kfree(sinfo->pertid);
+	kfree(sinfo->links[0]->pertid);
+	kfree(sinfo->links[0]);
 }
 
 /**
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 70ece0083d40..c1e88761b5e8 100644
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
index 42f7ee142ce3..72ee417cd899 100644
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
@@ -117,23 +117,23 @@ static void ieee80211_get_stats(struct net_device *dev,
 		memset(&sinfo, 0, sizeof(sinfo));
 		sta_set_sinfo(sta, &sinfo, false);
 
+		link_sinfo = sinfo.links[0];
 		i = 0;
 		ADD_STA_STATS(&sta->deflink);
 
 		data[i++] = sta->sta_state;
 
-
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
@@ -143,6 +143,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 
 			memset(&sinfo, 0, sizeof(sinfo));
 			sta_set_sinfo(sta, &sinfo, false);
+			link_sinfo = sinfo.links[0];
 			i = 0;
 			ADD_STA_STATS(&sta->deflink);
 		}
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 1060b6d7c6f9..20b7465ac962 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2615,7 +2615,7 @@ static void sta_set_mesh_sinfo(struct sta_info *sta,
 }
 #endif
 
-static void sta_set_link_sinfo(struct sta_info *sta, struct station_info *sinfo,
+static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *sinfo,
 			       struct ieee80211_link_data *link_sdata, bool tidstats)
 {
 	struct link_sta_info *link_sta_info = &sta->deflink;
@@ -2634,7 +2634,7 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
 		sinfo->rx_beacon = link_sdata->u.mgd.count_beacon_signal;
 
-	drv_sta_statistics(local, sdata, &sta->sta, sinfo);
+	drv_link_sta_statistics(local, sdata, &sta->sta, sinfo);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
 			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
 			 BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
@@ -2830,6 +2830,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct link_station_info *link_sinfo = sinfo->links[0];
 	struct ieee80211_link_data *link_sdata = &sdata->deflink;
 
 	sinfo->generation = sdata->local->sta_generation;
@@ -2869,7 +2870,11 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER))
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
 
-	sta_set_link_sinfo(sta, sinfo, link_sdata, tidstats);
+	link_sinfo = kzalloc(sizeof(*link_sinfo), GFP_KERNEL);
+	if (!link_sinfo)
+		return;
+
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
index bf4426fbbabd..422c31da4c24 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6686,7 +6686,7 @@ static bool nl80211_put_signal(struct sk_buff *msg, u8 mask, s8 *signal,
 
 static int nl80211_fill_link_station(struct sk_buff *msg,
 				     struct cfg80211_registered_device *rdev,
-				     struct station_info *sinfo)
+				     struct link_station_info *sinfo)
 {
 	struct nlattr *bss_param;
 
@@ -6844,6 +6844,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 {
 	void *hdr;
 	struct nlattr *sinfoattr;
+	struct link_station_info *link_sinfo = sinfo->links[0];
 
 	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr) {
@@ -6880,7 +6881,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    &sinfo->sta_flags))
 		goto nla_put_failure;
 
-	if (nl80211_fill_link_station(msg, rdev, sinfo))
+	if (nl80211_fill_link_station(msg, rdev, link_sinfo))
 		goto nla_put_failure;
 
 	nla_nest_end(msg, sinfoattr);
@@ -13024,9 +13025,9 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 			return err;
 
 		cfg80211_sinfo_release_content(&sinfo);
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG))
+		if (sinfo.links[0]->filled & BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG))
 			cqm_config->last_rssi_event_value =
-				(s8) sinfo.rx_beacon_signal_avg;
+				(s8)sinfo.links[0]->rx_beacon_signal_avg;
 	}
 
 	last = cqm_config->last_rssi_event_value;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index a57210c8087c..93b7b31b89bc 100644
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
+	struct link_station_info *link_sinfo = sinfo->links[0];		\
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
index 60157943d351..cbc0de1b6c6c 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2626,11 +2626,11 @@ bool cfg80211_does_bw_fit_range(const struct ieee80211_freq_range *freq_range,
 	return false;
 }
 
-int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp)
+int cfg80211_sinfo_alloc_tid_stats(struct link_station_info *sinfo, gfp_t gfp)
 {
 	sinfo->pertid = kcalloc(IEEE80211_NUM_TIDS + 1,
-				sizeof(*(sinfo->pertid)),
-				gfp);
+				     sizeof(*(sinfo->pertid)),
+				     gfp);
 	if (!sinfo->pertid)
 		return -ENOMEM;
 
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index a74b1afc594e..1da85440e6be 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -1267,12 +1267,12 @@ static int cfg80211_wext_giwrate(struct net_device *dev,
 	if (err)
 		return err;
 
-	if (!(sinfo.filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))) {
+	if (!(sinfo.links[0]->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))) {
 		err = -EOPNOTSUPP;
 		goto free;
 	}
 
-	rate->value = 100000 * cfg80211_calculate_bitrate(&sinfo.txrate);
+	rate->value = 100000 * cfg80211_calculate_bitrate(&sinfo.links[0]->txrate);
 
 free:
 	cfg80211_sinfo_release_content(&sinfo);
@@ -1316,8 +1316,8 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 
 	switch (rdev->wiphy.signal_type) {
 	case CFG80211_SIGNAL_TYPE_MBM:
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
-			int sig = sinfo.signal;
+		if (sinfo.links[0]->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
+			int sig = sinfo.links[0]->signal;
 			wstats.qual.updated |= IW_QUAL_LEVEL_UPDATED;
 			wstats.qual.updated |= IW_QUAL_QUAL_UPDATED;
 			wstats.qual.updated |= IW_QUAL_DBM;
@@ -1331,11 +1331,11 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 		}
 		fallthrough;
 	case CFG80211_SIGNAL_TYPE_UNSPEC:
-		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
+		if (sinfo.links[0]->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
 			wstats.qual.updated |= IW_QUAL_LEVEL_UPDATED;
 			wstats.qual.updated |= IW_QUAL_QUAL_UPDATED;
-			wstats.qual.level = sinfo.signal;
-			wstats.qual.qual = sinfo.signal;
+			wstats.qual.level = sinfo.links[0]->signal;
+			wstats.qual.qual = sinfo.links[0]->signal;
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
+	if (sinfo.links[0]->filled & BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC))
+		wstats.discard.misc = sinfo.links[0]->rx_dropped_misc;
+	if (sinfo.links[0]->filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED))
+		wstats.discard.retries = sinfo.links[0]->tx_failed;
 
 	cfg80211_sinfo_release_content(&sinfo);
 
-- 
2.34.1


