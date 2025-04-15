Return-Path: <linux-wireless+bounces-21532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC42A892CB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 06:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB1189AF7E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 04:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B661DE3C4;
	Tue, 15 Apr 2025 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f2tkLMV2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8121B905
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 04:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744690881; cv=none; b=tm/NR6tgDB5NmJUE6UhkoRfgJqIcjenggaGCK1Jr8pqi64/u4YZxRkJVauGsi9lX0VackcR5J3nsN/7T2nCSgjx6TVlB68UhcoprilsQ8+2PA8CDisBEvtR2Z1S9xtj7RSRlDFGQSnjq1+qeIAx4hYCOcQpHDorIJX6tYFvd4ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744690881; c=relaxed/simple;
	bh=zeJHr/3wo/jSBhQVk1ZnZbZFzEcz+732KO5K063Macs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWMKRc0muN+XYE53L09ZIeKEqJfMgM5AXCRu0ec4JmIBSaFB+hlUVELLwA3NJViwL8uvsS/11GffS9Yf/jGFACn7ZbK1mpBMVymceLFtrvedYxOFQXaRsR0H1iog41udpni6CCgy/v17ZcJ5E4n4JoAozgBDUc5Recl4PAM+Y/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f2tkLMV2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F15NvB031007;
	Tue, 15 Apr 2025 04:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w+f1Un+7SYCmCutNpQX3Yf3Gjw+n8kH9gV3YWs6U8JY=; b=f2tkLMV2+OXt3Izn
	AVxMNDfkI2FfB8oivQwCpthF3UzJCRbZlt0HczkG449tVErMflqXnd/QdCDOGaqy
	t+xK0Rkd/IBuHsKpQEbTxXDvnxm9WIiwg6X3EaNX26DnwOE8v9l68JUzI9WVEfGI
	q1xviw6+z0SHJ2gPobpQvhqaBIHhard2+0AF0r+vAr9n5Q6i9h71kfWAjeRB0BEI
	9QK1wZk+gWtb2cnd34cRvepkf3OsX0f3IayU4E6XVLhC6pK8GqvfJyw9woL/7MN+
	+eYzVtsiJ/4oj+932XR6S6PvvRQau6CtVEXbY7cfcF0SO96QyO5yMiV9W5mCmkSr
	QcS+Gw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxjxg82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:16 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F4LFrn020689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:15 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Apr 2025 21:21:14 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v6 09/11] wifi: mac80211: extend support to fill link level sinfo structure
Date: Tue, 15 Apr 2025 09:50:28 +0530
Message-ID: <20250415042030.1246187-10-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=67fddebc cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=X_n8wxKkR8uZPODnql0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZqomJBOdtF1tZw8CTxTWlqHwwIi8ofr8
X-Proofpoint-ORIG-GUID: ZqomJBOdtF1tZw8CTxTWlqHwwIi8ofr8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150026

Currently, sinfo structure is supported to fill information at
deflink( or one of the links) level for station. This has problems
when applied to fetch multi-link(ML) station information.

Hence, add changes to verify if driver supports link level statistics
and if valid_links are present and if so, support filling link_sinfo
structure.

This will be helpful to check the link related statistics during MLO.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/mac80211/sta_info.c | 67 +++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 0c3a38cde089..6b3c953bc371 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2651,14 +2651,21 @@ static void sta_set_mesh_sinfo(struct sta_info *sta,
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
@@ -2667,6 +2674,8 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
 		sinfo->rx_beacon = link_sdata->u.mgd.count_beacon_signal;
 
+	ether_addr_copy(sinfo->addr, link_sta_info->addr);
+
 	drv_link_sta_statistics(local, sdata, &sta->sta, sinfo);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
 			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
@@ -2679,7 +2688,7 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
 	}
 
 	sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, -1));
+		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, link_id));
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
@@ -2768,7 +2777,7 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
 	    !(sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX) |
 				 BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
-		sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif, -1);
+		sinfo->rx_beacon_signal_avg = ieee80211_ave_rssi(&sdata->vif, link_id);
 	}
 
 	if (ieee80211_hw_check(&sta->local->hw, SIGNAL_DBM) ||
@@ -2808,22 +2817,20 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
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
@@ -2863,10 +2870,13 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
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
@@ -2903,11 +2913,36 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER))
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
 
-	link_sinfo = kzalloc(sizeof(*link_sinfo), GFP_KERNEL);
-	if (!link_sinfo)
-		return;
+	if ((sdata->local->hw.wiphy->flags &
+	     WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS) &&
+	    sinfo->valid_links) {
+		ether_addr_copy(sinfo->mld_addr, sta->addr);
+
+		for_each_valid_link(sinfo, link_id) {
+			link_sta = wiphy_dereference(sta->local->hw.wiphy,
+						     sta->link[link_id]);
+			if (!link_sta)
+				continue;
+
+			link_sinfo = kzalloc(sizeof(*link_sinfo), GFP_KERNEL);
+			if (!link_sinfo)
+				return;
 
-	sta_set_link_sinfo(sta, link_sinfo, link_sdata, tidstats);
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


