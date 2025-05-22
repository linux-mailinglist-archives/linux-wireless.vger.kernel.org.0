Return-Path: <linux-wireless+bounces-23288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D8AC07F7
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11581BC4684
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED85928A3FC;
	Thu, 22 May 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VFRWPo6p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24B28A1EA
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904202; cv=none; b=mCAuDmDJAtS5uzOMNOtJ6O69UOA6+6v085+WAqnIDQhsK36m2tQXqjXuYrsOfb9jBaQSx0mxHbDGtop+mwhBUBEivxG3aj4p9I8jv9GyO4x3g2BOnwUAYrki2NVABUVWEt2SxaCaV+9XDiIYOGfgTmrSy2uVmg1pY8aF7GMScDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904202; c=relaxed/simple;
	bh=eGsPV8VDzJ1c4hiCbCWZNUNk/B2kXl8I2iRUI/XirKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o65ESFwT9665jD8Yi29hS103o6cNUoO7+XfEjUK6s7L3dz5AeCmfH7LDEYOIMjWk08k8CTZ4dypNyAZeGqBsCuj3ob8QRkFRNWYz8seDQBY8Ap7A8zQmKg8o8cpV/ZnWrU1/sz6Ac9JeR+Mj1m6GXrv+8Nf1obc2ZUodxjc9qSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VFRWPo6p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M8DFJN024840;
	Thu, 22 May 2025 08:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ng/X1Zs8sv2u68xdvpftSqSF2rYI3/85l2+azHAIGtY=; b=VFRWPo6p39Zoj304
	01fAkVccAUJ5CiGaVv37tfZ+RN0uyBVxdTewr/ioD2KrGTdtlJfNgtfRiUHThvg5
	lPPxNB6jqavCoju955rnubIDlv09XRBWuoTbHtCfI/3fvMQmiOlyOipu+EEUX1Cj
	cqL+YOREd5PJcxYBFR0mGG7ogKEs/UETROLFIHb6QPQJRrZFKWu9TZAG1cYVZnyT
	PiMWtbRoVj2V+xU0AEjnPTvTjrXahIREXzwZ9dMYPaJuYDvqsQdvUUgaF8WLsiB8
	BQUTJbZBgTTvrJsu7h/paPZlLE/n7/QAjpQYlhJakOQIbvPay2r/AjUI8ZUzSutB
	QSUGaQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4wp4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:37 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8uaf3009724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:36 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 22 May 2025 01:56:34 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v9 06/10] wifi: mac80211: add support to accumulate removed link statistics
Date: Thu, 22 May 2025 14:25:57 +0530
Message-ID: <20250522085601.2741458-7-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
References: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: Y_75pJ1ufKKk4ytCqx-KEWWN6D_c9djT
X-Proofpoint-ORIG-GUID: Y_75pJ1ufKKk4ytCqx-KEWWN6D_c9djT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfXwJ82M1gO5LiB
 Zow4D0upe5bkhbPiiifLt8UgAWawdeeKP4/puiFBKY8ytxzgW2sX8OLZtT18BhswciEsuNd/83c
 L1p0+PApelNpKJoM0TVGgiNiqoj5wOLLgQicOLHt8Sa92GYSw7m5NEaSK36i76vVfJsL+xuXGdq
 489mYRD7IN37dZFHUvb1LvbYIFIfOF/WtVlSoG0zER7UWSdUnQpnJvqDFcS9hTNCrBq7CZWLREI
 YI3z74+9roBIZCdCLM2PW6URq1oq4zQoVjcRZv6qcIy6wuaB7MIjeAXmsM7DkvtfHI9xc/SD87H
 tKTekcolHpo+nDdA9nML4bNuHzx5qGzHanSUBODuaB2Poz+BijNDlRoIQ9Jgltym60pEwudjeuy
 a5XTAqlIcmdNJ/OuvTEpw8FXYNpgj/me0lf9618Wn5uzS9aRZqyS8j0SKLm26BmlehMnSnh+
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682ee6c5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=6IugdaIWA08vTE6I6UkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220089

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
 net/mac80211/cfg.c      | 13 ++++++++
 net/mac80211/sta_info.c | 74 +++++++++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.h | 55 ++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d9d88f2f2831..ea4093551110 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -885,6 +885,13 @@ static int ieee80211_dump_station(struct wiphy *wiphy, struct net_device *dev,
 		ret = 0;
 		memcpy(mac, sta->sta.addr, ETH_ALEN);
 		sta_set_sinfo(sta, sinfo, true);
+
+		/* Add accumulated removed link data to sinfo data for
+		 * consistency for MLO
+		 */
+		if (sinfo->valid_links)
+			sta_set_accumulated_removed_links_sinfo(sta, sinfo);
+
 	}
 
 	return ret;
@@ -912,6 +919,12 @@ static int ieee80211_get_station(struct wiphy *wiphy, struct net_device *dev,
 	if (sta) {
 		ret = 0;
 		sta_set_sinfo(sta, sinfo, true);
+
+		/* Add accumulated removed link data to sinfo data for
+		 * consistency for MLO
+		 */
+		if (sinfo->valid_links)
+			sta_set_accumulated_removed_links_sinfo(sta, sinfo);
 	}
 
 	return ret;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 896c0d912b42..9304f7bba7eb 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -355,6 +355,50 @@ static void sta_info_free_link(struct link_sta_info *link_sta)
 	free_percpu(link_sta->pcpu_rx_stats);
 }
 
+static void sta_accumulate_removed_link_stats(struct sta_info *sta, int link_id)
+{
+	struct link_sta_info *link_sta = wiphy_dereference(sta->local->hw.wiphy,
+							   sta->link[link_id]);
+	struct ieee80211_link_data *link;
+	int ac, tid;
+	u32 thr;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		sta->rem_link_stats.tx_packets +=
+			link_sta->tx_stats.packets[ac];
+		sta->rem_link_stats.tx_bytes += link_sta->tx_stats.bytes[ac];
+	}
+
+	sta->rem_link_stats.rx_packets += link_sta->rx_stats.packets;
+	sta->rem_link_stats.rx_bytes += link_sta->rx_stats.bytes;
+	sta->rem_link_stats.tx_retries += link_sta->status_stats.retry_count;
+	sta->rem_link_stats.tx_failed += link_sta->status_stats.retry_failed;
+	sta->rem_link_stats.rx_dropped_misc += link_sta->rx_stats.dropped;
+
+	thr = sta_get_expected_throughput(sta);
+	if (thr != 0)
+		sta->rem_link_stats.expected_throughput += thr;
+
+	for (tid = 0; tid < IEEE80211_NUM_TIDS; tid++) {
+		sta->rem_link_stats.pertid_stats.rx_msdu +=
+			link_sta->rx_stats.msdu[tid];
+		sta->rem_link_stats.pertid_stats.tx_msdu +=
+			link_sta->tx_stats.msdu[tid];
+		sta->rem_link_stats.pertid_stats.tx_msdu_retries +=
+			link_sta->status_stats.msdu_retries[tid];
+		sta->rem_link_stats.pertid_stats.tx_msdu_failed +=
+			link_sta->status_stats.msdu_failed[tid];
+	}
+
+	if (sta->sdata->vif.type == NL80211_IFTYPE_STATION) {
+		link = wiphy_dereference(sta->sdata->local->hw.wiphy,
+					 sta->sdata->link[link_id]);
+		if (link)
+			sta->rem_link_stats.beacon_loss_count +=
+				link->u.mgd.beacon_loss_count;
+	}
+}
+
 static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 			    bool unhash)
 {
@@ -377,6 +421,10 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 		alloc = container_of(link_sta, typeof(*alloc), info);
 
 	sta->sta.valid_links &= ~BIT(link_id);
+
+	/* store removed link info for accumulated stats consistency */
+	sta_accumulate_removed_link_stats(sta, link_id);
+
 	RCU_INIT_POINTER(sta->link[link_id], NULL);
 	RCU_INIT_POINTER(sta->sta.link[link_id], NULL);
 	if (alloc) {
@@ -2644,6 +2692,32 @@ static void sta_set_mesh_sinfo(struct sta_info *sta,
 }
 #endif
 
+void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
+					     struct station_info *sinfo)
+{
+	/* Accumulating the removed link statistics. */
+	sinfo->tx_packets = sta->rem_link_stats.tx_packets;
+	sinfo->rx_packets = sta->rem_link_stats.rx_packets;
+	sinfo->tx_bytes = sta->rem_link_stats.tx_bytes;
+	sinfo->rx_bytes = sta->rem_link_stats.rx_bytes;
+	sinfo->tx_retries = sta->rem_link_stats.tx_retries;
+	sinfo->tx_failed = sta->rem_link_stats.tx_failed;
+	sinfo->rx_dropped_misc = sta->rem_link_stats.rx_dropped_misc;
+	sinfo->beacon_loss_count = sta->rem_link_stats.beacon_loss_count;
+	sinfo->expected_throughput = sta->rem_link_stats.expected_throughput;
+
+	if (sinfo->pertid) {
+		sinfo->pertid->rx_msdu =
+			sta->rem_link_stats.pertid_stats.rx_msdu;
+		sinfo->pertid->tx_msdu =
+			sta->rem_link_stats.pertid_stats.tx_msdu;
+		sinfo->pertid->tx_msdu_retries =
+			sta->rem_link_stats.pertid_stats.tx_msdu_retries;
+		sinfo->pertid->tx_msdu_failed =
+			sta->rem_link_stats.pertid_stats.tx_msdu_failed;
+	}
+}
+
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index e5b91e60405b..7f740bf1b2d8 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -568,6 +568,56 @@ struct link_sta_info {
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
+ * @rx_dropped_misc: accumulated dropped packets for un-specified reason
+ *	from this station for removed links
+ * @@beacon_loss_count: Number of times beacon loss event has triggered
+ *	from this station for removed links.
+ * @expected_throughput: expected throughput in kbps (including 802.11
+ *	headers) towards this station for removed links
+ * @pertid_stats.rx_msdu : accumulated number of received MSDUs towards
+ *	this station for removed links.
+ * @pertid_stats.tx_msdu: accumulated number of (attempted) transmitted
+ *	MSDUs towards this station for removed links
+ * @pertid_stats.tx_msdu_retries: accumulated number of retries (not
+ *	counting the first) for transmitted MSDUs towards this station
+ *	for removed links
+ * @pertid_stats.tx_msdu_failed: accumulated number of failed transmitted
+ *	MSDUs towards this station for removed links
+ */
+struct ieee80211_sta_removed_link_stats {
+	u32 rx_packets;
+	u32 tx_packets;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	u32 tx_retries;
+	u32 tx_failed;
+	u32 rx_dropped_misc;
+	u32 beacon_loss_count;
+	u32 expected_throughput;
+	struct {
+		u64 rx_msdu;
+		u64 tx_msdu;
+		u64 tx_msdu_retries;
+		u64 tx_msdu_failed;
+	} pertid_stats;
+};
+
 /**
  * struct sta_info - STA information
  *
@@ -644,6 +694,7 @@ struct link_sta_info {
  *	@deflink address and remaining would be allocated and the address
  *	would be assigned to link[link_id] where link_id is the id assigned
  *	by the AP.
+ * @rem_link_stats: accumulated removed link stats
  */
 struct sta_info {
 	/* General information, mostly static */
@@ -718,6 +769,7 @@ struct sta_info {
 	struct ieee80211_sta_aggregates cur;
 	struct link_sta_info deflink;
 	struct link_sta_info __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct ieee80211_sta_removed_link_stats rem_link_stats;
 
 	/* keep last! */
 	struct ieee80211_sta sta;
@@ -922,6 +974,9 @@ void sta_set_rate_info_tx(struct sta_info *sta,
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats);
 
+void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
+					     struct station_info *sinfo);
+
 u32 sta_get_expected_throughput(struct sta_info *sta);
 
 void ieee80211_sta_expire(struct ieee80211_sub_if_data *sdata,
-- 
2.34.1


