Return-Path: <linux-wireless+bounces-22950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3BCAB71E6
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 18:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AAD3A61CD
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB0B27C15B;
	Wed, 14 May 2025 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fbwUyTtG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135F27A137
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241376; cv=none; b=XYfFuvGl4lHDUD+hY8V1uKXOvemmEhxYCjEEBRTymPfdqxQguYsLIGVxCy3pJ5XLTKJKdPJNkctRUElnkQ/O4lGw2s6hPd1cITEXGoWxWHmoZudyL1pyhspAHjy5nzENZzLKyDpR53Gtn4rhKcFOgxI/hDIW+uRI6YmCa8fEOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241376; c=relaxed/simple;
	bh=Toxpq3NG16yCMgoHdQg0AlkY5v0IuPv1o0hdg3pmby0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAnVhEttAvNVID0JDU5r91lgRHXvd/rJqjCTWRRzCC22iedISRNkERjUHUc3dPkXJOMWUs2K6yYjvhh1w48EMAp5xnq28yIXlfI3qjuHepRqmr9yOg7soi8RFjJZeid/JkV8KGSuHRku62MWMUZ2/cLJ435K/WwLlpftb6wIjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fbwUyTtG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuvPp015135;
	Wed, 14 May 2025 16:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AMBRwJG8o7UtYRmigwmcDKmp9UQfcslSBrTYbTAW+Hs=; b=fbwUyTtG7DO+pDP4
	6CRthOBIUSUtisl/JdSJgTJicFAEGDU56DWgaSv8q9dXtxn2GZxlH/a5G52lJwsj
	vIiRxnaCRDG3qKF+BpP263VX12DG0zOfor7bs61M0P02TZw2may8DMWQaM53JKaI
	jsHenL7hNazw2Hrwstep0BIFUwAx2RlChMaaCpKNNrbwz4oCrybHyhkiNmrJFD5F
	KcBz5A8Yl9FADtBCF1NXh/Gv2JpE8ZM1ELPoTfjN1COPOl9fl9xG4IekIc6FkjrU
	dXp4XhMIMz5kpdlRwbvdhQPXq2sHsRVGbAaTsjCHGxzU4FBwNUtKiMHyBYAmxSAE
	B9oaiw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcr3apk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:31 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EGnULI028224
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:49:30 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 09:49:28 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v7 06/10] wifi: mac80211: add support to accumulate removed link statistics
Date: Wed, 14 May 2025 22:18:53 +0530
Message-ID: <20250514164857.227540-7-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514164857.227540-1-quic_sarishar@quicinc.com>
References: <20250514164857.227540-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: VCxIfAQzWBiAcH4UjPTrYNI6rXMsKVpg
X-Authority-Analysis: v=2.4 cv=Auju3P9P c=1 sm=1 tr=0 ts=6824c99b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=hIxSXKRmwHcaXGphL0oA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VCxIfAQzWBiAcH4UjPTrYNI6rXMsKVpg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE1MSBTYWx0ZWRfX/eUHufvJf2QR
 DIDx0ElWmGYsNL00oEOWCkMhcP9IR4KFayrAp+nmji8dn8A1P8HsukLfm/hnL0lXsAf07XS8Xun
 8sMnbdwPCBpH2iKzsusbx34nolSN1FCUXauhs/sADxn+5AyoizXh/gxSfICaFYGv/14oq51PUca
 35ufknWSW48WKFVQHy3rU35dFCZa2z1kkTQBZMoRjaQKtmlPy17Kqy0bTAm6PEQ9PtMmbXuD8I+
 wPt1haD52jBoeoPU9UgjNI7h+jlKL6J7B3bEKNL97EbkHyOjgTkC49NZQjHmUB5DQEgr3KMS3mF
 kAx9WBpPL/uCV2DbHCFQfLo/AqB5x/ncx0x+5AtR6AgEqFFsIoRGRwTBkR+Hii9KTX9/Euxk0dD
 gWtenB1D6lc8MgIajXK2W6RBlzYaSvQ+S8dBfOEAxwEekyX4SwLIUJSPi/38VA1Wl4KaRCmn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140151

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


