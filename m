Return-Path: <linux-wireless+bounces-23458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5533FAC615F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 07:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A9C4A3327
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 05:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D077220DD48;
	Wed, 28 May 2025 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i/5wABlV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2648207DFE
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748411095; cv=none; b=DP8DqRAg0/zqcL2z6t2iJy09zEkhWghKHrfK3eDYWfI8cHzeqMhftrKX4kTyALfMDkACv1XHqRfuTOrhou9jvsg6M/gCW4ZpqFJRzcu28/j1Y0bPghRH6s2Byhz3rox91k93eb8hoyKUIHt9QUiNwoYJKnuDTDIXBU34hAnmMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748411095; c=relaxed/simple;
	bh=OlSVHZOlWKQFTsLam9/xmobU5RxyG9HEyPLliwI/Mso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnRoktzyrpG2G354En+W5wYLY3Adj0/oSp1MAiGDw36JkRAfGOBEIQb7GEZee282tXRWOcrdqT4eGro1sL9TpLarwD7aWRcUs9p/ga7Q6jLklSwFLhfks2JwPQiOrm9sFWZzcdphyoBnHIKkZI4ZPTf+BbI2SkxmD6Itecj2BYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i/5wABlV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RJpR5E001593;
	Wed, 28 May 2025 05:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AYUSBZL9YW9DVUhfp4Ll1Q+weamDdEH8DY3FUfqHpeE=; b=i/5wABlV/jGkCKp7
	0qVHTeHfJNG3ZvE8BGRwjAkLAPXj2eFWfBRPBo5EMEw1/dIroKGkg+NWp4BOk5Jd
	hE7Pl57CYBnMD2YJoNs2OP23ddD6SzPoyEKVhOFzzZaNSJ9D4txc/5Iye5b3D7Wo
	hfoLxv4bADzIr/Q839qd46jueXQqGyyLYZWv/H3cmH2TcFS8GOk5AHw4mgThd93J
	dDaULlyZ6MVt/DmnyZx5Z4z+OP23NP9upg2vtV1n8NvVDeeH5DpdXyHxHyieZAf6
	7N7e2IrIyUylJpSmtDptAWoYjxfPUH786OvZ7EY+rb28MdfXEOeQM010i9k/uvUQ
	CdrH0A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6vjs748-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:49 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54S5im36031362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:48 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 May 2025 22:44:47 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v10 06/10] wifi: mac80211: add support to accumulate removed link statistics
Date: Wed, 28 May 2025 11:14:16 +0530
Message-ID: <20250528054420.3050133-7-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
References: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=UOXdHDfy c=1 sm=1 tr=0 ts=6836a2d1 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=6IugdaIWA08vTE6I6UkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ZgGYf6lfRIDu1rw_RV4SSp70FZlz3EHP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA0OSBTYWx0ZWRfX+fSZb+A/NJzJ
 aF2v5wy+heJ+zaULiCI9w/zMqqsIdvLWozCMY3SBUquciv8oWVK/8Nb7r65f/yEN8nRytSWfkWF
 62kCz6l/fqHlAVNG0cXs8CZrlnA+/CeedxBgq/jY/VN6/PzDXvbTlK9hLjrQ4quKkR51xCceokp
 vQo1diCUB2VmbXiWgvzD5wVacTTy4XaZXmlL81uL0HFtj+TAs69hzSOdt8CAf90IsyU9wXICypt
 LjXkTMegbbZ6FzIXCkv6NXCoUvRNYsc5Qfu3K1clEttnRGJHv+duoJRPst6HpvPdouJK2uLIpkh
 j6Kx60JsqcHtoEZhTGcmkR3z3sR9yNc8vOBwhsCA4hqmgRyyjFIYHx3ew2nhwrApLPoPDow/pAq
 9CNvbW6cG6MRUAy2ZUK5M82iKQImDJee2Cs59geYzH+2NxZcvJVcJYgKif/ILhmfIc/OwHx9
X-Proofpoint-GUID: ZgGYf6lfRIDu1rw_RV4SSp70FZlz3EHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505280049

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
 net/mac80211/sta_info.h | 57 +++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)

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
index e5b91e60405b..5288d5286651 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -568,6 +568,58 @@ struct link_sta_info {
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
+ * @beacon_loss_count: Number of times beacon loss event has triggered
+ *	from this station for removed links.
+ * @expected_throughput: expected throughput in kbps (including 802.11
+ *	headers) towards this station for removed links
+ * @pertid_stats: accumulated per-TID statistics for removed link of
+ *	station
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
@@ -644,6 +696,7 @@ struct link_sta_info {
  *	@deflink address and remaining would be allocated and the address
  *	would be assigned to link[link_id] where link_id is the id assigned
  *	by the AP.
+ * @rem_link_stats: accumulated removed link stats
  */
 struct sta_info {
 	/* General information, mostly static */
@@ -718,6 +771,7 @@ struct sta_info {
 	struct ieee80211_sta_aggregates cur;
 	struct link_sta_info deflink;
 	struct link_sta_info __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct ieee80211_sta_removed_link_stats rem_link_stats;
 
 	/* keep last! */
 	struct ieee80211_sta sta;
@@ -922,6 +976,9 @@ void sta_set_rate_info_tx(struct sta_info *sta,
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats);
 
+void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
+					     struct station_info *sinfo);
+
 u32 sta_get_expected_throughput(struct sta_info *sta);
 
 void ieee80211_sta_expire(struct ieee80211_sub_if_data *sdata,
-- 
2.34.1


