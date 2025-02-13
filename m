Return-Path: <linux-wireless+bounces-18931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F143A34BCA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0684F3AD1FF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E642040AB;
	Thu, 13 Feb 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hoAL4nG1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9F2040BA
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467054; cv=none; b=p9s0ZMv2FgWqlZR9EYP6975PLUowX4yIlS3CcJsTRFkGcpUy26vgT+3anxsJxT4oMR7/ZEM1vEJMSYuGgpY9ILEs6UVyqk6cQ+8Wwf/D4Fa2mwNlzs8KBmQbMb+bMpXsdhKkx2RI+YuzHRbwedGNdG1CBjHeeLu85GN+y3WgMFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467054; c=relaxed/simple;
	bh=X7RiXboVPZ0qHYFd0F+q6NpRxHBV+Lm1OEk2nL4NGBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ub2kLHNqJ0Rz4Sq+20ZPhuV8nJbo+B+ByZNjJbb4kI9pIMVboe8ru0Zr2I6MNTkDfav/13tcUZpc6f/r9wfeEQlD4kcbzSLpUlGJOQEmww0D+vMd8u0QV9M0zSVPiP5tR0RbSFVRDiRNo6O3jwtAMH4VE/YH97ZrpY6MGDLdh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hoAL4nG1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DAUamf002088;
	Thu, 13 Feb 2025 17:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YVMgTs3eKlyrnrJ7SNcAq4c4AEROEu5Kt34wYGHQFvM=; b=hoAL4nG1kJZmfdRk
	heJR4ORIpkw6hDF1udhyrTk/ivR05hvt6/bgs9dDSt7UsdJ9c+Q1/rUYwwQoWdQx
	X+pK+225QvT/bLcLcu1VO7xYegsydpmeLZEUS+BSPKPDBJuzq9R18iLUNpNxXTeK
	WmPvh+Ilmy38Q5sCsNtRfbyJ7A6IRqqSjqu5329xaBtO8yUSBxo56Erh6vrx28tu
	7InIJAFjZ9cFMRsirg0j3LFR8x37xBnG+ojRE9wwVpEIEWTtKRWw9d5vnMD+Ij8w
	ttcCS4kS6vCC4F7BI0TyV9UTiL4QeahOVHu5VqkN2XrUL0IHFAswSIykmP8hmzad
	NpKM9g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44s5w4afc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:27 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DHHRAS005022
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:27 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Feb 2025 09:17:25 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH v3 07/12] wifi: cfg80211: extend statistics for link level in sinfo
Date: Thu, 13 Feb 2025 22:46:27 +0530
Message-ID: <20250213171632.1646538-8-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: A62PVMIAHYEvuinoLwivcAdFt4NpN_w0
X-Proofpoint-ORIG-GUID: A62PVMIAHYEvuinoLwivcAdFt4NpN_w0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130123

Currently, statistics is supported at deflink( or one of the links)
level for station. This has problems when applied to multi-link(ML)
connections.

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
		NL80211_ATTR_MAC,
			NL80211_ATTR_STA_INFO | nest flag
				NL80211_STA_INFO_RX_BYTES,
				NL80211_STA_INFO_TX_BYTES,
				..........etc.
		link_id-2 | nested
		NL80211_ATTR_MLO_LINK_ID,
		NL80211_ATTR_MAC,
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
 include/net/cfg80211.h  | 27 ++++++++++-----
 net/mac80211/sta_info.c | 69 +++++++++++++++++++++++++++++---------
 net/wireless/nl80211.c  | 74 ++++++++++++++++++++++++++++++++---------
 3 files changed, 129 insertions(+), 41 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index db1f9b79b280..e07eb657fdfe 100644
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
@@ -2176,6 +2171,9 @@ struct link_station_info {
  *	dump_station() callbacks. User space needs this information to determine
  *	the accepted and rejected affiliated links of the connected station.
  * @assoc_resp_ies_len: Length of @assoc_resp_ies buffer in octets.
+ * @valid_links: bitmap of valid links, or 0 for non-MLO. Drivers fill this
+ *	information in cfg80211_new_sta(), cfg80211_del_sta_sinfo(),
+ *	get_station() and dump_station() callbacks.
  * @links: reference to Link sta entries for MLO STA. For non-MLO STA
  *	and case where the driver offload link decisions and do not provide
  *	per-link statistics, all link specific information is accessed
@@ -2203,12 +2201,12 @@ struct station_info {
 	enum nl80211_mesh_power_mode peer_pm;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
-	bool mlo_params_valid;
 	u8 assoc_link_id;
 	u8 mld_addr[ETH_ALEN] __aligned(2);
 	const u8 *assoc_resp_ies;
 	size_t assoc_resp_ies_len;
 
+	u16 valid_links;
 	/* TODO: Need to check and add protection access to links memory */
 	struct link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
@@ -8503,9 +8501,20 @@ int cfg80211_sinfo_alloc_tid_stats(struct link_station_info *sinfo, gfp_t gfp);
  */
 static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 {
-	if (sinfo->links[0]) {
-		kfree(sinfo->links[0]->pertid);
-		kfree(sinfo->links[0]);
+	int link_id;
+
+	if (sinfo->valid_links) {
+		for_each_valid_link(sinfo, link_id) {
+			if (sinfo->links[link_id]) {
+				kfree(sinfo->links[link_id]->pertid);
+				kfree(sinfo->links[link_id]);
+			}
+		}
+	} else {
+		if (sinfo->links[0]) {
+			kfree(sinfo->links[0]->pertid);
+			kfree(sinfo->links[0]);
+		}
 	}
 }
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 3522afaf94ca..1bfe1a55888d 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2639,14 +2639,23 @@ static void sta_set_mesh_sinfo(struct sta_info *sta,
 static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *sinfo,
 			       struct ieee80211_link_data *link_sdata, bool tidstats)
 {
-	struct link_sta_info *link_sta_info = &sta->deflink;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sta_rx_stats *last_rxstats;
+	struct link_sta_info *link_sta_info;
 	u32 thr = 0;
-	int i, ac, cpu;
+	int i, ac, cpu, link_id;
+
 
-	last_rxstats = sta_get_last_rx_stats(sta, -1);
+	link_id = sinfo->link_id;
+	last_rxstats = sta_get_last_rx_stats(sta, link_id);
+
+	if (link_id < 0)
+		link_sta_info = &sta->deflink;
+	else
+		link_sta_info =
+			rcu_dereference_protected(sta->link[link_id],
+						  lockdep_is_held(&local->hw.wiphy->mtx));
 
 	/* do before driver, so beacon filtering drivers have a
 	 * chance to e.g. just add the number of filtered beacons
@@ -2655,6 +2664,8 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
 		sinfo->rx_beacon = link_sdata->u.mgd.count_beacon_signal;
 
+	memcpy(sinfo->addr, link_sta_info->addr, ETH_ALEN);
+
 	drv_link_sta_statistics(local, sdata, &sta->sta, sinfo);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
 			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
@@ -2667,7 +2678,7 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
 	}
 
 	sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, -1));
+		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, link_id));
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
@@ -2756,7 +2767,7 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
 	    !(sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX) |
 				 BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
-		sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif, -1);
+		sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif, link_id);
 	}
 
 	if (ieee80211_hw_check(&sta->local->hw, SIGNAL_DBM) ||
@@ -2796,22 +2807,20 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
-	    !sta->sta.valid_links &&
 	    ieee80211_rate_valid(&link_sta_info->tx_stats.last_rate)) {
 		sta_set_rate_info_tx(sta, &link_sta_info->tx_stats.last_rate,
 				     &sinfo->txrate);
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
 
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) &&
-	    !sta->sta.valid_links) {
-		if (sta_set_rate_info_rx(sta, &sinfo->rxrate, -1) == 0)
+	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE))) {
+		if (sta_set_rate_info_rx(sta, &sinfo->rxrate, link_id) == 0)
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
 	}
 
 	if (tidstats && !cfg80211_sinfo_alloc_tid_stats(sinfo, GFP_KERNEL)) {
 		for (i = 0; i < IEEE80211_NUM_TIDS + 1; i++)
-			sta_set_tidstats(sta, &sinfo->pertid[i], i, -1);
+			sta_set_tidstats(sta, &sinfo->pertid[i], i, link_id);
 	}
 
 	sinfo->bss_param.flags = 0;
@@ -2851,10 +2860,13 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	struct link_station_info *link_sinfo = sinfo->links[0];
-	struct ieee80211_link_data *link_sdata = &sdata->deflink;
+	struct link_station_info *link_sinfo;
+	struct ieee80211_link_data *link_sdata;
+	struct link_sta_info *link_sta;
+	int link_id;
 
 	sinfo->generation = sdata->local->sta_generation;
+	sinfo->valid_links = sta->sta.valid_links;
 
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_STA_FLAGS) |
 			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME) |
@@ -2891,11 +2903,36 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER))
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
 
-	link_sinfo = kzalloc(sizeof(*link_sinfo), GFP_KERNEL);
-	if (!link_sinfo)
-		return;
+	if (sinfo->valid_links) {
+		memcpy(sinfo->mld_addr, sta->addr, ETH_ALEN);
+
+		for_each_valid_link(sinfo, link_id) {
+			link_sta =
+				rcu_dereference_protected(sta->link[link_id],
+							  lockdep_is_held(&sta->local->hw.wiphy->mtx));
+			if (!link_sta)
+				continue;
 
-	sta_set_link_sinfo(sta, link_sinfo, link_sdata, tidstats);
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
+		link_sinfo = kzalloc(sizeof(*link_sinfo), GFP_KERNEL);
+		if (!link_sinfo)
+			return;
+		link_sinfo->link_id = -1;
+		link_sdata = &sdata->deflink;
+		sta_set_link_sinfo(sta, link_sinfo, link_sdata, tidstats);
+		sinfo->links[0] = link_sinfo;
+	}
 }
 
 u32 sta_get_expected_throughput(struct sta_info *sta)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index db0175052c65..3527cea4e071 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6867,8 +6867,9 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 				const u8 *mac_addr, struct station_info *sinfo)
 {
 	void *hdr;
-	struct nlattr *sinfoattr;
-	struct link_station_info *link_sinfo = sinfo->links[0];
+	struct nlattr *sinfoattr, *link_sinfoattr, *links, *link;
+	struct link_station_info *link_sinfo;
+	int link_id;
 
 	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr) {
@@ -6905,22 +6906,16 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    &sinfo->sta_flags))
 		goto nla_put_failure;
 
-	if (link_sinfo && nl80211_fill_link_station(msg, rdev, link_sinfo))
-		goto nla_put_failure;
-
-	nla_nest_end(msg, sinfoattr);
-
-	if (sinfo->assoc_req_ies_len &&
-	    nla_put(msg, NL80211_ATTR_IE, sinfo->assoc_req_ies_len,
-		    sinfo->assoc_req_ies))
-		goto nla_put_failure;
+	if (sinfo->valid_links) {
+		/* TODO: Add accumulated stats for packets, bytes for
+		 *	 better representation at MLO level.
+		 */
 
-	if (sinfo->assoc_resp_ies_len &&
-	    nla_put(msg, NL80211_ATTR_RESP_IE, sinfo->assoc_resp_ies_len,
-		    sinfo->assoc_resp_ies))
-		goto nla_put_failure;
+		/* Closing nested STA_INFO as MLO links ATTR should not
+		 * be in nested STA_INFO
+		 */
+		nla_nest_end(msg, sinfoattr);
 
-	if (sinfo->mlo_params_valid) {
 		if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
 			       sinfo->assoc_link_id))
 			goto nla_put_failure;
@@ -6929,8 +6924,55 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    nla_put(msg, NL80211_ATTR_MLD_ADDR, ETH_ALEN,
 			    sinfo->mld_addr))
 			goto nla_put_failure;
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
+
+			if (link_sinfo && !is_zero_ether_addr(link_sinfo->addr) &&
+			    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
+				    link_sinfo->addr))
+				goto nla_put_failure;
+
+			link_sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
+			if (!link_sinfoattr)
+				goto nla_put_failure;
+
+			if (link_sinfo && nl80211_fill_link_station(msg, rdev, link_sinfo))
+				goto nla_put_failure;
+
+			nla_nest_end(msg, link_sinfoattr);
+			nla_nest_end(msg, link);
+		}
+		nla_nest_end(msg, links);
+	} else {
+		link_sinfo = sinfo->links[0];
+		if (link_sinfo && nl80211_fill_link_station(msg, rdev, link_sinfo))
+			goto nla_put_failure;
+
+		nla_nest_end(msg, sinfoattr);
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
 	cfg80211_sinfo_release_content(sinfo);
 	genlmsg_end(msg, hdr);
 	return 0;
-- 
2.34.1


