Return-Path: <linux-wireless+bounces-21533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14574A892CA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 06:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65C23B67C4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 04:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BBC218AAB;
	Tue, 15 Apr 2025 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iESiAD7o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F221B91F
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 04:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744690882; cv=none; b=MWUnw7R8XvyA0jAhyHobJxCkvPCy9XESv7ZC4s0VxBF+IZNSu/1Bm13xAPoAK4Bre2qnUbDE7U3MslXmoDPkLV2rknmxWc8Oslpuqjc+Vp2eenSzmQuZcAyd+RtoJG0Hj0cyRQeBs6Vr8TkLdDobzSndpJwD3Rg1omZJWdob++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744690882; c=relaxed/simple;
	bh=NmU6aZgIFxmOAgfxxRUWc8Z+J4raftHLvSy/me/oGco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9LhZ9DGY2AwVQZoV/y9NtJFy9eNXR1ugGfJoalImdxZTHmlE8R7x4+mGZKArKuVy+7t5a8C7H5+Dtmwu5IpOI+v3f0pcvaNbxuBCofG6VLrerrgdlMQ8WFHPC9qkN75aVHDOYltqpCglG1bqeoMnb6jTHQkmA3rbDm59UcmnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iESiAD7o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F16OEc016669;
	Tue, 15 Apr 2025 04:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LAR9xwV84m+s9fnaUVtIsajM7Kj/ksDD9iAYShmdGlA=; b=iESiAD7oiorhTXds
	JA2qzyio45Xib6pb0yzlQVCrnfumLlC3Et/452IgpiRY3WsUQWyvbTYuDuhctwPJ
	NgAlWwVC1ETDK52rfkXF8qoA4KKGCw6Gps4fip6mRtEG5venPDr7LU8SCBPtvDaj
	YZ+lOFnObwUReOX0p4tQGu+n9cYuG9UiJxnzZey+lyWbxHqp1xbq3Dws4gcZzrAz
	x9l7OxXK7r4qCWl0Opuko4l5P10gwuro3a0K1W/yPQxp633IEAyqm4NnkBQpa+8E
	KnlshE/R1uhu4aJjKyTRZbiMC6pq34iaL1WCX6uG6WBnsope/8o0AuODVZT8QMnu
	dnkCwQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhfcxgye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:15 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F4LEr9018990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:14 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Apr 2025 21:21:12 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v6 08/11] wifi: cfg80211: add additional MLO statistics
Date: Tue, 15 Apr 2025 09:50:27 +0530
Message-ID: <20250415042030.1246187-9-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=CfUI5Krl c=1 sm=1 tr=0 ts=67fddebb cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=boqpVWCIW2Z0tQplh_0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: CYBKMFHUOzIUap0BvZ0ih-d1IL5Qu0NR
X-Proofpoint-ORIG-GUID: CYBKMFHUOzIUap0BvZ0ih-d1IL5Qu0NR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150026

Currently, the accumulable statistics for multi-link operation(MLO)
are handled. Other statistics, such as signal and rates, are managed at
the link level. Therefore, add signal, rates, inactive time, dtim_period
and beacon_interval at the MLO level to provide an comprehensive
overview of the station.

The signal could be the best of all links-
e.g. if Link 1 has a signal strength of -70 dBm and Link 2 has -65 dBm,
the signal for MLO will be -65 dBm.

The rate could be determined based on the most recently updated link-
e.g. if link 1 has a rate of 300 Mbps and link 2 has a rate of 450 Mbps,
the MLO rate can be calculated based on the inactivity of each link.
If the inactive time for link 1 is 20 seconds and for link 2 is 10 seconds,
the MLO rate will be the most recently updated rate, which is link 2's
rate of 450 Mbps.

The inactive time, dtim_period and beacon_interval can be taken as the
least value of field from link level.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h |  12 +++++
 net/wireless/nl80211.c | 105 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6c179d6179db..75df68166094 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2195,6 +2195,12 @@ struct link_station_info {
  * @beacon_loss_count: Number of times beacon loss event has triggered.
  * @expected_throughput: aggregated expected throughput in kbps (including
  *	802.11 headers) towards this station.
+ * @inactive_time: time since last station activity (tx/rx) in milliseconds
+ * @bss_param: current BSS parameters
+ * @signal: The signal strength, type depends on the wiphy's signal_type.
+ *	For CFG80211_SIGNAL_TYPE_MBM, value is expressed in _dBm_.
+ * @txrate: last updated unicast bitrate from this station
+ * @rxrate: last updated unicast bitrate to this station
  * @valid_links: bitmap of valid links, or 0 for non-MLO. Drivers fill this
  *	information in cfg80211_new_sta(), cfg80211_del_sta_sinfo(),
  *	get_station() and dump_station() callbacks.
@@ -2240,6 +2246,12 @@ struct station_info {
 	u32 beacon_loss_count;
 	u32 expected_throughput;
 
+	u32 inactive_time;
+	struct sta_bss_parameters bss_param;
+	s8 signal;
+	struct rate_info txrate;
+	struct rate_info rxrate;
+
 	u16 valid_links;
 	struct link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 36e8c45d8750..fa95ce4e78e9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6872,8 +6872,11 @@ static int nl80211_fill_link_station(struct sk_buff *msg,
 }
 
 static int nl80211_fill_mld_station(struct sk_buff *msg,
-				    struct station_info *sinfo)
+				    struct station_info *sinfo,
+				    struct cfg80211_registered_device *rdev)
 {
+	struct nlattr *bss_param;
+
 	PUT_SINFO(RX_PACKETS, rx_packets, u32);
 	PUT_SINFO(TX_PACKETS, tx_packets, u32);
 	PUT_SINFO_U64(RX_BYTES, rx_bytes);
@@ -6884,6 +6887,41 @@ static int nl80211_fill_mld_station(struct sk_buff *msg,
 	PUT_SINFO(BEACON_LOSS, beacon_loss_count, u32);
 	PUT_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
 
+	switch (rdev->wiphy.signal_type) {
+	case CFG80211_SIGNAL_TYPE_MBM:
+		PUT_SINFO(SIGNAL, signal, u8);
+		break;
+	default:
+		break;
+	}
+
+	PUT_SINFO(INACTIVE_TIME, inactive_time, u32);
+
+	if ((sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
+	    (!nl80211_put_sta_rate(msg, &sinfo->txrate,
+				   NL80211_STA_INFO_TX_BITRATE)))
+		goto nla_put_failure;
+
+	if ((sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) &&
+	    (!nl80211_put_sta_rate(msg, &sinfo->rxrate,
+				   NL80211_STA_INFO_RX_BITRATE)))
+		goto nla_put_failure;
+
+	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
+		bss_param = nla_nest_start_noflag(msg,
+						  NL80211_STA_INFO_BSS_PARAM);
+		if (!bss_param)
+			goto nla_put_failure;
+
+		if (nla_put_u8(msg, NL80211_STA_BSS_PARAM_DTIM_PERIOD,
+			       sinfo->bss_param.dtim_period) ||
+		    nla_put_u16(msg, NL80211_STA_BSS_PARAM_BEACON_INTERVAL,
+				sinfo->bss_param.beacon_interval))
+			goto nla_put_failure;
+
+		nla_nest_end(msg, bss_param);
+	}
+
 	return 0;
 
 nla_put_failure:
@@ -6938,7 +6976,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 
 	if ((rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS) &&
 	    sinfo->valid_links) {
-		if (nl80211_fill_mld_station(msg, sinfo))
+		if (nl80211_fill_mld_station(msg, sinfo, rdev))
 			goto nla_put_failure;
 
 		/* Closing nested STA_INFO as MLO links ATTR should not
@@ -7018,10 +7056,29 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 #undef PUT_SINFO
 #undef PUT_SINFO_U64
 
+static void cfg80211_sta_set_mld_rate_info(struct rate_info *sinfo_rate,
+					   struct rate_info *link_sinfo_rate)
+{
+	sinfo_rate->flags = link_sinfo_rate->flags;
+	sinfo_rate->legacy = link_sinfo_rate->legacy;
+	sinfo_rate->mcs = link_sinfo_rate->mcs;
+	sinfo_rate->nss = link_sinfo_rate->nss;
+	sinfo_rate->bw = link_sinfo_rate->bw;
+	sinfo_rate->he_gi = link_sinfo_rate->he_gi;
+	sinfo_rate->he_dcm = link_sinfo_rate->he_dcm;
+	sinfo_rate->he_ru_alloc = link_sinfo_rate->he_ru_alloc;
+	sinfo_rate->n_bonded_ch = link_sinfo_rate->n_bonded_ch;
+	sinfo_rate->eht_gi = link_sinfo_rate->eht_gi;
+	sinfo_rate->eht_ru_alloc = link_sinfo_rate->eht_ru_alloc;
+}
+
 static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
 {
 	struct link_station_info *link_sinfo;
-	int link_id;
+	int link_id, init = 0;
+	u32 link_inactive_time;
+
+	sinfo->signal = -99;
 
 	for_each_valid_link(sinfo, link_id) {
 		link_sinfo = sinfo->links[link_id];
@@ -7074,6 +7131,48 @@ static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
 			sinfo->expected_throughput += link_sinfo->expected_throughput;
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
 		}
+
+		/* Update MLO signal as per best of all link signal */
+		if ((link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) &&
+		    link_sinfo->signal > sinfo->signal) {
+			sinfo->signal = link_sinfo->signal;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+		}
+
+		/* Update MLO inactive_time, bss_param based on least
+		 * value for corresponding field of link.
+		 */
+		if ((link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME)) &&
+		    (!init || link_inactive_time > link_sinfo->inactive_time)) {
+			link_inactive_time = link_sinfo->inactive_time;
+			sinfo->inactive_time = link_sinfo->inactive_time;
+			sinfo->filled |= NL80211_STA_INFO_INACTIVE_TIME;
+		}
+
+		if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM) &&
+		    (!init ||
+		     sinfo->bss_param.dtim_period > link_sinfo->bss_param.dtim_period)) {
+			sinfo->bss_param.dtim_period = link_sinfo->bss_param.dtim_period;
+			sinfo->filled |= NL80211_STA_BSS_PARAM_DTIM_PERIOD;
+			sinfo->bss_param.beacon_interval =
+				link_sinfo->bss_param.beacon_interval;
+			sinfo->filled |= NL80211_STA_BSS_PARAM_BEACON_INTERVAL;
+		}
+
+		/* Update MLO rates as per last updated link rate */
+		if ((link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
+		    (!init || link_inactive_time > link_sinfo->inactive_time)) {
+			cfg80211_sta_set_mld_rate_info(&sinfo->txrate,
+						       &link_sinfo->txrate);
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+		}
+		if ((link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) &&
+		    (!init || link_inactive_time > link_sinfo->inactive_time)) {
+			cfg80211_sta_set_mld_rate_info(&sinfo->rxrate,
+						       &link_sinfo->rxrate);
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+		}
+		init++;
 	}
 }
 
-- 
2.34.1


