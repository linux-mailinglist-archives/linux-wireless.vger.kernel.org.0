Return-Path: <linux-wireless+bounces-22983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE75AB7D44
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 07:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24474C7431
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81D029550B;
	Thu, 15 May 2025 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H/4hbLge"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8729616C
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 05:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288179; cv=none; b=PQEpyR5UIialESNzucZq4297A5NpsGbquI3tSypujTdaUYlTWMjmupjeC51ooDItPNy5EmEvt6VeGskwiUXM9wflDjFZ4IKxCf8LJCuff5QGpmtmDeW8oj2E112XspClT/Fb8PvPhdCI6g7aZEK8e2Muih8nW03RKMEVw8qRnsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288179; c=relaxed/simple;
	bh=Toxpq3NG16yCMgoHdQg0AlkY5v0IuPv1o0hdg3pmby0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1r9mVEABiATRnqA+jruFyEy3GtJfglz3F3eZVi4SZV6eKGZYjcH7QEUbG/z3939T0uwuA4pk/VC5o67h19WnQ+pBP+0yMak0IidGPV4UzHBKuue9DWaXyMNOQitejDEaezLG6Nk3Jl/Zz4OIobc4VAwgKbEMRv+EWrmOl/Fnuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H/4hbLge; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ELL1Gj003090;
	Thu, 15 May 2025 05:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AMBRwJG8o7UtYRmigwmcDKmp9UQfcslSBrTYbTAW+Hs=; b=H/4hbLgeayuckaiY
	q62yMN4QiQKC/7wdIaCm1W8Vl7ElHlbUyfGN3yJDD3jayKso2vQFWvaQmtR9LHM+
	RJS6xu+ZYoF32KqjmKIWk95VbZ1az3Vpqirb4H8EgO4WndN12AsFgCplY3ga5EpG
	cFw23UsZsnIsqN9KTiOnOCMqdfun1qE2X80eamTe5Wl33Vu6jyK3zbL43cEinFbr
	LRKhH5Ku27J8RbNJ8Sa9qDgy9CPtnHbpveG69D4XHtK+PVKIoaK1gMRuCcvjBnt5
	kJLzF1GOm3JR9GjRxVQ3gfZzQRCO9IN19ILI6rgVzQ7GiJK5CasKKdNaccTPtSDo
	OMyU8Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcrcyfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F5nWx9010612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:32 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 22:49:30 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to accumulate removed link statistics
Date: Thu, 15 May 2025 11:19:00 +0530
Message-ID: <20250515054904.1214096-7-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0KJCE0IFh_-GnNiwiDz0gYH_gF4Kz0YG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA1NSBTYWx0ZWRfX1i1vGuU+bqin
 04sjXDeoxsUXB+4E+VJWEcTP5KLiIhzfP3RdsoA40tZNsLjKOBOFH06rfBBDnBNFqzpkQEeCIan
 E6Y9orgi5I8BK22fbOjPaK0ezAW5CwBnLlWQRX6cKIJ92jbQOBVSbdnDj1wqYtsmMZk2+BXfxSa
 sRPDbnhJ+u/VEf5BgCffq32QiDVqJK2ty+j0gfR7r3Ol0r6ScFJCWTqz6CtROvIGflVOLNvkS+9
 FDrREcYYm9SNkS8Erx+FSUs6LOZ6kLn2+DQVMqrUeQjsdpEslE2D/je6v/kewMRkL/CCVQxJ9l3
 ElWBbUchAAHRFZSYJo6PNrO6/hFB/Hx1ogoe79SRVT1idiIQis/zOdxCioENamUzu1j9QvqI57c
 RKyiwnKPjIn2STQdcy+vo1TtCM6MsVjM2dp19tHt0uCUeofwp8ey1bKFrXpIqbfAml/Blx1C
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=6825806d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=hIxSXKRmwHcaXGphL0oA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0KJCE0IFh_-GnNiwiDz0gYH_gF4Kz0YG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150055

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

Also, initialize accumulatable fields in sinfo structure to 0, to avoid
any additional packets account for MLO station.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/mac80211/cfg.c      | 13 ++++++++++
 net/mac80211/sta_info.c | 54 +++++++++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.h | 34 ++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2cd8731d8275..a523a6a5db32 100644
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
index 5cc28eb1005b..709250ba37c9 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -355,6 +355,25 @@ static void sta_info_free_link(struct link_sta_info *link_sta)
 	free_percpu(link_sta->pcpu_rx_stats);
 }
 
+static void sta_accumulate_removed_link_stats(struct sta_info *sta, int link_id)
+{
+	struct link_sta_info *link_sta = wiphy_dereference(sta->local->hw.wiphy,
+							   sta->link[link_id]);
+	int ac;
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
+}
+
 static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 			    bool unhash)
 {
@@ -377,6 +396,10 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 		alloc = container_of(link_sta, typeof(*alloc), info);
 
 	sta->sta.valid_links &= ~BIT(link_id);
+
+	/* store removed link info for accumulated stats consistency */
+	sta_accumulate_removed_link_stats(sta, link_id);
+
 	RCU_INIT_POINTER(sta->link[link_id], NULL);
 	RCU_INIT_POINTER(sta->sta.link[link_id], NULL);
 	if (alloc) {
@@ -2644,6 +2667,37 @@ static void sta_set_mesh_sinfo(struct sta_info *sta,
 }
 #endif
 
+void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
+					     struct station_info *sinfo)
+{
+	/* Resetting the MLO statistics for accumulated fields, to
+	 * avoid duplication.
+	 */
+	sinfo->tx_packets = 0;
+	sinfo->rx_packets = 0;
+	sinfo->tx_bytes = 0;
+	sinfo->rx_bytes = 0;
+	sinfo->tx_retries = 0;
+	sinfo->tx_failed = 0;
+	sinfo->rx_dropped_misc = 0;
+	sinfo->beacon_loss_count = 0;
+	sinfo->expected_throughput = 0;
+	sinfo->rx_mpdu_count = 0;
+	sinfo->fcs_err_count = 0;
+	sinfo->rx_beacon = 0;
+	sinfo->rx_duration = 0;
+	sinfo->tx_duration = 0;
+
+	/* Accumulating the removed link statistics. */
+	sinfo->tx_packets += sta->rem_link_stats.tx_packets;
+	sinfo->rx_packets += sta->rem_link_stats.rx_packets;
+	sinfo->tx_bytes += sta->rem_link_stats.tx_bytes;
+	sinfo->rx_bytes += sta->rem_link_stats.rx_bytes;
+	sinfo->tx_retries += sta->rem_link_stats.tx_retries;
+	sinfo->tx_failed += sta->rem_link_stats.tx_failed;
+	sinfo->rx_dropped_misc += sta->rem_link_stats.rx_dropped_misc;
+}
+
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index e5b91e60405b..6851cf10a1da 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -568,6 +568,35 @@ struct link_sta_info {
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
+ */
+struct ieee80211_sta_removed_link_stats {
+	u32 rx_packets;
+	u32 tx_packets;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	u32 tx_retries;
+	u32 tx_failed;
+	u32 rx_dropped_misc;
+};
+
 /**
  * struct sta_info - STA information
  *
@@ -644,6 +673,7 @@ struct link_sta_info {
  *	@deflink address and remaining would be allocated and the address
  *	would be assigned to link[link_id] where link_id is the id assigned
  *	by the AP.
+ * @rem_link_stats: accumulated removed link stats
  */
 struct sta_info {
 	/* General information, mostly static */
@@ -718,6 +748,7 @@ struct sta_info {
 	struct ieee80211_sta_aggregates cur;
 	struct link_sta_info deflink;
 	struct link_sta_info __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct ieee80211_sta_removed_link_stats rem_link_stats;
 
 	/* keep last! */
 	struct ieee80211_sta sta;
@@ -922,6 +953,9 @@ void sta_set_rate_info_tx(struct sta_info *sta,
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats);
 
+void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
+					     struct station_info *sinfo);
+
 u32 sta_get_expected_throughput(struct sta_info *sta);
 
 void ieee80211_sta_expire(struct ieee80211_sub_if_data *sdata,
-- 
2.34.1


