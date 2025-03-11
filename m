Return-Path: <linux-wireless+bounces-20144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF8DA5B940
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 07:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFE7170655
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 06:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805B82206BD;
	Tue, 11 Mar 2025 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m+cSJPUa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B50C21D59F
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674467; cv=none; b=ejqx1bCWGbRUMPsBw0pmWOqlv0a1PNdXGtmsPw49AoRFgXrcWg98fQo9/0dH7SeGXbHENtY0HcuNybrbktkDGqNkBQTyZx7fZ4S3bHm0oF1tsjiHF6kPaYuv3cQ2wljhwlgcsgegE13EHAAJzo7kcZxkDuDE0FA5m5Fgf9dnhqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674467; c=relaxed/simple;
	bh=yLty/p777b18fZ2U24bqVdeVAntr6OJOMlvBfH6bhOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUMfzzxXFzSTD18r6z5iU59whhOVjtXspvOYDK8f2DEVw1LFjgqG+nUJHrjq88o+6OkntoQadwFU0ediTNJzvNnWhF+LgOVQIfcA9iNRIMYth9O4eqBvYwfJ8mOGwV1LZOcs6lVIdc2oT1Pto/BGr9l8yX+D/IHm88XiDaE0r6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m+cSJPUa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AK0C8K013903;
	Tue, 11 Mar 2025 06:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iArcYGXz9UdbqmH9FHjqqYpNDSLBG/i6RxTDdFl/r2s=; b=m+cSJPUawp+heyRC
	EpMZ9N47L6JGZzMz5R9dblMk/AW18ZLqTLBjaXtT30ae3ULj+kgYgKS4yeLpk02q
	zM2kysiEskxCOm5itYOK6s0uoeS4L0zLi8FtXUytDNUyzlfMsNdCoIRPOUKMiYhs
	MF2qizJrGQg0IZ488jxHfw1BWvJYTojOLDesYdu1r6VFsYZDCQV25n7NBx/usDnx
	3CNMEqOaQFjWUaGM5mLxHTb+zOiFZpfKlv4HwhUFs46G1SDiJU6wt2I8v0XxyYjO
	Bo8PppygxCXktxbjLo26sbThtbyNycYCWBK2B35iTK+q3r6mYtmv+aheO8QzBVYF
	OJDHAQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ewk7bme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:27:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52B6RVIj002120
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:27:31 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Mar 2025 23:27:29 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v4 10/11] wifi: mac80211: add support to accumulate removed link statistics
Date: Tue, 11 Mar 2025 11:56:53 +0530
Message-ID: <20250311062654.1407532-11-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=Tr8chCXh c=1 sm=1 tr=0 ts=67cfd7d4 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=WJ3WS-W4AXyLPryFm8oA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: OtSsPhviw0Ol3EY1R8-KBEbvhVfWGOc6
X-Proofpoint-ORIG-GUID: OtSsPhviw0Ol3EY1R8-KBEbvhVfWGOc6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110042

Currently, if a link gets removed in between for a station then
directly accumulated data will fall down to sum of other active links.
This will bring inconsistency in station dump statistics.

For instance, let's take Tx packets
- at t=0-> link-0:2 link-1:3 Tx packets => accumulated = 5
- at t=1-> link-0:4 link-1:6 Tx packets => accumulated = 10
let say at t=2, link-0 went down => link-0:0 link-1:7 => accumulated = 7
Here, suddenly accumulated Tx packets will come down to 7 from 10.
This is showing inconsistency.

Therefore, store link-0 data when it went down and add to accumulated
Tx packet = 11.

Hence, store the removed link statistics data in sta structure and
add it in accumulated statistics for consistency.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/mac80211/sta_info.c | 35 +++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 9a3daf0a6205..478761438e2f 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -356,6 +356,23 @@ static void sta_info_free_link(struct link_sta_info *link_sta)
 	free_percpu(link_sta->pcpu_rx_stats);
 }
 
+static void sta_accumulate_removed_link_stats(struct sta_info *sta, int link_id)
+{
+	struct link_sta_info *link_sta = wiphy_dereference(sta->local->hw.wiphy,
+							   sta->link[link_id]);
+	int ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		sta->rem_link_stats.tx_packets += link_sta->tx_stats.packets[ac];
+		sta->rem_link_stats.tx_bytes += link_sta->tx_stats.bytes[ac];
+	}
+
+	sta->rem_link_stats.rx_packets += link_sta->rx_stats.packets;
+	sta->rem_link_stats.rx_bytes += link_sta->rx_stats.bytes;
+	sta->rem_link_stats.tx_retries += link_sta->status_stats.retry_count;
+	sta->rem_link_stats.tx_failed += link_sta->status_stats.retry_failed;
+}
+
 static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 			    bool unhash)
 {
@@ -378,6 +395,10 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 		alloc = container_of(link_sta, typeof(*alloc), info);
 
 	sta->sta.valid_links &= ~BIT(link_id);
+
+	/* store removed link info for accumulated stats consistency */
+	sta_accumulate_removed_link_stats(sta, link_id);
+
 	RCU_INIT_POINTER(sta->link[link_id], NULL);
 	RCU_INIT_POINTER(sta->sta.link[link_id], NULL);
 	if (alloc) {
@@ -2853,6 +2874,17 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *s
 	}
 }
 
+static void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
+						    struct station_info *sinfo)
+{
+	sinfo->tx_packets += sta->rem_link_stats.tx_packets;
+	sinfo->rx_packets += sta->rem_link_stats.rx_packets;
+	sinfo->tx_bytes += sta->rem_link_stats.tx_bytes;
+	sinfo->rx_bytes += sta->rem_link_stats.rx_bytes;
+	sinfo->tx_retries += sta->rem_link_stats.tx_retries;
+	sinfo->tx_failed += sta->rem_link_stats.tx_failed;
+}
+
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
@@ -2921,6 +2953,9 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			sta_set_link_sinfo(sta, link_sinfo, link_sdata, tidstats);
 			sinfo->links[link_id] = link_sinfo;
 		}
+
+		/* Add accumulated removed link data to sinfo data for consistency */
+		sta_set_accumulated_removed_links_sinfo(sta, sinfo);
 	} else {
 		link_sinfo = kzalloc(sizeof(*link_sinfo), GFP_KERNEL);
 		if (!link_sinfo)
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 7e600c82a6e1..b2dc92ba0070 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -576,6 +576,32 @@ struct link_sta_info {
 	struct ieee80211_link_sta *pub;
 };
 
+/**
+ * struct ieee80211_sta_removed_link_stats - Removed link sta data
+ *
+ * keep required accumulated removed link data for stats
+ *
+ * @rx_packets: accumulated packets (MSDUs & MMPDUs) received from
+ *	this station for removed links
+ * @tx_packets: accumulated packets (MSDUs & MMPDUs) transmitted to
+ *	this station for removed links
+ * @rx_bytes: accumulated bytes (size of MPDUs) received from this
+ *	station for removed links
+ * @tx_bytes: accumulated bytes (size of MPDUs) transmitted to this
+ *	station for removed links
+ * @tx_retries: cumulative retry counts (MPDUs) for removed links
+ * @tx_failed: accumulated number of failed transmissions (MPDUs)
+ *	(retries exceeded, no ACK) for removed links
+ */
+struct ieee80211_sta_removed_link_stats {
+	u32 rx_packets;
+	u32 tx_packets;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	u32 tx_retries;
+	u32 tx_failed;
+};
+
 /**
  * struct sta_info - STA information
  *
@@ -653,6 +679,7 @@ struct link_sta_info {
  *	@deflink address and remaining would be allocated and the address
  *	would be assigned to link[link_id] where link_id is the id assigned
  *	by the AP.
+ * @rem_link_stats: accumulated removed link stats
  */
 struct sta_info {
 	/* General information, mostly static */
@@ -729,6 +756,7 @@ struct sta_info {
 	struct ieee80211_sta_aggregates cur;
 	struct link_sta_info deflink;
 	struct link_sta_info __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct ieee80211_sta_removed_link_stats rem_link_stats;
 
 	/* keep last! */
 	struct ieee80211_sta sta;
-- 
2.34.1


