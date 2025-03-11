Return-Path: <linux-wireless+bounces-20143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B92A5B93F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 07:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1AA18959F9
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 06:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F97F215178;
	Tue, 11 Mar 2025 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NVpdqGgE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684C20B208
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674467; cv=none; b=XFJzWsEFxi0mHvpiS8ln4SWfyugOU01kQ4u4HJ+vzRCq5EW5o6pp0rUhaMXKpMvD1jMxe+2ZzQi8aqiZQItdzXehYwzPxq6UgDWHOwqRa2yzi8lApnV0er5Nsai6KvZmUHgadDC97MbqzPOipfvmgHBP6IOaC+Xj+C4S3n8DfK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674467; c=relaxed/simple;
	bh=7xmG2B9HfH/PfJ8OuUtblf5k5EE+hcRlP9Nqhylnraw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+X+dgp2hLNYZ4DjDxuMdNcKQcbQyJsBo1JTcU7hwQ1v9Z/wh7+q7eKvUxF5T8cz9ZwxPLjhQUJUxXwhMQtIT+L0Lg5sUozG/ximyiinG/JbJBLde2I+fT4/ct0wmU0gyu56mv1kNHaKq5qzkobvpCwl3IPpBLsFh8+SShqBBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NVpdqGgE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJBp2V020316;
	Tue, 11 Mar 2025 06:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v7+C0FLk9pA0goCoMnnEm4QgEkmaBNbVNulQBmCMeuQ=; b=NVpdqGgE0OggMh6G
	Y4EG1h5Wfu15CVmfIeyODKApS4GqJqccp/SoBxXsMGk7pfBE83S3YTlKBsXN7cAc
	VIaaUXVf1SC9T2sWfmxlDLBcZPoBH5++T6C5FdWhA4huuEVRIlOVbHkiqKCXImkv
	MUu1mAbXkm6uzIMYPdkUgPHVystES3JM5s2JQ2ncK3HaZzhr7xRUshsi5ym2mYxE
	UfDoAa0HSHulcgtFdqwYwVS/GCCpoWmNucHfyqYwz+omcaXaTbVwZmFMf27zFzxw
	crKfUYBnjqSAVH1zyLEqbJW20FGnXjiuw2ONzc4lPpHbuLy+lpRBwjG2vn2T30bj
	yYZrzA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ex6ycbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:27:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52B6RTcO017962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:27:29 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Mar 2025 23:27:27 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v4 09/11] wifi: mac80211: extend support to fill link level sinfo structure
Date: Tue, 11 Mar 2025 11:56:52 +0530
Message-ID: <20250311062654.1407532-10-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311062654.1407532-1-quic_sarishar@quicinc.com>
References: <20250311062654.1407532-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=G8bmE8k5 c=1 sm=1 tr=0 ts=67cfd7d2 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=X_n8wxKkR8uZPODnql0A:9 a=-xfCAL3FBaT3DXZhEJRK:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 49m-pxbAq2C93Kk4CsjVe07GgDFgNFSD
X-Proofpoint-ORIG-GUID: 49m-pxbAq2C93Kk4CsjVe07GgDFgNFSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110042

Currently, sinfo structure is supported to fill information at
deflink( or one of the links) level for station. This has problems
when applied to fetch multi-link(ML) station information.

Hence, add changes to verify if driver supports link level statistics
and if valid_links are present and if so, support filling link_sinfo
structure.

This will be helpful to check the link related statistics during MLO.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/mac80211/sta_info.c | 68 +++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 195eacaca492..9a3daf0a6205 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2637,14 +2637,22 @@ static void sta_set_mesh_sinfo(struct sta_info *sta,
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
+
+	link_id = sinfo->link_id;
+	last_rxstats = sta_get_last_rx_stats(sta, link_id);
 
-	last_rxstats = sta_get_last_rx_stats(sta, -1);
+	if (link_id < 0)
+		link_sta_info = &sta->deflink;
+	else
+		link_sta_info = wiphy_dereference(sta->local->hw.wiphy,
+						  sta->link[link_id]);
 
 	/* do before driver, so beacon filtering drivers have a
 	 * chance to e.g. just add the number of filtered beacons
@@ -2653,6 +2661,8 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
 		sinfo->rx_beacon = link_sdata->u.mgd.count_beacon_signal;
 
+	memcpy(sinfo->addr, link_sta_info->addr, ETH_ALEN);
+
 	drv_link_sta_statistics(local, sdata, &sta->sta, sinfo);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
 			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
@@ -2665,7 +2675,7 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
 	}
 
 	sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, -1));
+		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, link_id));
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
@@ -2754,7 +2764,7 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
 	    !(sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX) |
 				 BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
-		sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif, -1);
+		sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif, link_id);
 	}
 
 	if (ieee80211_hw_check(&sta->local->hw, SIGNAL_DBM) ||
@@ -2794,22 +2804,20 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
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
@@ -2849,10 +2857,15 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
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
+	sinfo->is_per_link_stats_support =
+		!!(sdata->local->hw.wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS);
 
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_STA_FLAGS) |
 			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME) |
@@ -2889,11 +2902,34 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER))
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
 
-	link_sinfo = kzalloc(sizeof(*link_sinfo), GFP_KERNEL);
-	if (!link_sinfo)
-		return;
+	if (sinfo->is_per_link_stats_support && sinfo->valid_links) {
+		memcpy(sinfo->mld_addr, sta->addr, ETH_ALEN);
+
+		for_each_valid_link(sinfo, link_id) {
+			link_sta = wiphy_dereference(sta->local->hw.wiphy,
+						     sta->link[link_id]);
+			if (!link_sta)
+				continue;
 
-	sta_set_link_sinfo(sta, link_sinfo, link_sdata, tidstats);
+			link_sinfo = kzalloc(sizeof(*link_sinfo), GFP_KERNEL);
+			if (!link_sinfo)
+				return;
+
+			link_sinfo->link_id = link_id;
+			link_sdata = wiphy_dereference(sdata->local->hw.wiphy,
+						       sdata->link[link_id]);
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
-- 
2.34.1


