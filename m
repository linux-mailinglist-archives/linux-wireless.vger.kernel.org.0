Return-Path: <linux-wireless+bounces-4903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5208487FF04
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 14:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036371F21733
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EB58060B;
	Tue, 19 Mar 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N84lw45r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059F98004F
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855934; cv=none; b=nPUpeM8335KIHuDLOOhc+HVmWZAAaAwVIGDeFdJxw2csXxoyqpyJ/7vB12k0tvFC7yvlomj7QPl3idtGSZYqtJ6u6Lyc19FB8MMMYgHPd3lhGMIMpXJpWu/b5MKhlFkk4TCswrgrdXQMG9LYDEbwcpGWDej6xL14N7T/WPp8C/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855934; c=relaxed/simple;
	bh=p4KnGAraHKl04PTaqSJEgPWlGNYYHj4vzVhHD0gycQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UXK40rw+esaGb2zwl0BlXrKm24k6Q4rgFcL/GzMo27tIusSEBuUhii0vlz10ycJNBBvN/pkPNbGyD3t0OX0rL8JbM+e9nmVV7H1nIvJuhJKSYm04IfIZi2HuyG627rGaqcRuFyL892eB4/ApzdoADBbrTioIWzDvplJFsN3naOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N84lw45r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J4sZml025022;
	Tue, 19 Mar 2024 13:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=iMFBeZQ
	TuSPsgqZSPdzjXle+l2WA8LLIZJdlK1WSXaU=; b=N84lw45rZoT7hICvlb1US9Z
	uHJwkjfAX1T2XLfppJu7Vaj3Xq73/YsypaZ9sK3+rlplSjso5zRz/7xlzwjdDd5L
	S1oqby27FsHMcH6Nt5y8GgK2Uf8tCekhKe2FWL8oTEGCimQvPJBQr6RUKQJMgU4g
	cTBqnsUnrvy/mXdyp6OpK1nGZXSfjdBLlbwkhzmajAcwUx7+v1uBwJgVmPiAVPfn
	mBnvJ3g0DaZl8TNIZ8tlOTR00dTlMxuDz54s/tnSCRCD7KJ/ouURPHQyRGtgEvCF
	ORfHk/JD4MwgHGY2yP5qLkX4vsznbQR0aeCEWl0vOL5HaZ/sG4h1Nv5yJ9+CqnQ=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2ea19rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 13:45:28 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42JDjPDY031303;
	Tue, 19 Mar 2024 13:45:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3ww4gkbeyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 13:45:25 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42JDjPtd031286;
	Tue, 19 Mar 2024 13:45:25 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-haric-blr.qualcomm.com [10.131.39.39])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 42JDjPZL031282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 13:45:25 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 3844793)
	id 6D1B341355; Tue, 19 Mar 2024 19:15:24 +0530 (+0530)
From: Hari Chandrakanthan <quic_haric@quicinc.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH v2 1/2] wifi: cfg80211/mac80211: Add support to rx retry stats
Date: Tue, 19 Mar 2024 19:15:21 +0530
Message-Id: <20240319134522.4021062-2-quic_haric@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319134522.4021062-1-quic_haric@quicinc.com>
References: <20240319134522.4021062-1-quic_haric@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oJMTSvl3IaeLMe3OHZm3bkVLuwyRrNZv
X-Proofpoint-GUID: oJMTSvl3IaeLMe3OHZm3bkVLuwyRrNZv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190105

Add support to count station level rx retries.
It denotes the number of data frames(MPDUs) with rx retry bit set.

The rx retry stats helps in understanding the medium
during UL transmission.

The counting logic of rx retry stats in the mac80211 rx path accounts the
data frames for which decap is not offloaded.

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
---
v2:
Added mac80211 support to count the rx retry stats
---
 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 3 +++
 net/mac80211/rx.c            | 6 ++++++
 net/mac80211/sta_info.c      | 5 +++++
 net/mac80211/sta_info.h      | 1 +
 net/wireless/nl80211.c       | 1 +
 6 files changed, 18 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2e2be4fd2bb6..21400bcc0646 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2049,6 +2049,7 @@ struct cfg80211_tid_stats {
  * @rxrate: current unicast bitrate to this station
  * @rx_packets: packets (MSDUs & MMPDUs) received from this station
  * @tx_packets: packets (MSDUs & MMPDUs) transmitted to this station
+ * @rx_retries: number of rx packets(MPDUs) from this station with retry bit set.
  * @tx_retries: cumulative retry counts (MPDUs)
  * @tx_failed: number of failed transmissions (MPDUs) (retries exceeded, no ACK)
  * @rx_dropped_misc:  Dropped for un-specified reason.
@@ -2129,6 +2130,7 @@ struct station_info {
 	struct rate_info rxrate;
 	u32 rx_packets;
 	u32 tx_packets;
+	u32 rx_retries;
 	u32 tx_retries;
 	u32 tx_failed;
 	u32 rx_dropped_misc;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f23ecbdd84a2..2e31909bf8af 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3885,6 +3885,8 @@ enum nl80211_sta_bss_param {
  *	of STA's association
  * @NL80211_STA_INFO_CONNECTED_TO_AS: set to true if STA has a path to a
  *	authentication server (u8, 0 or 1)
+ * @NL80211_STA_INFO_RX_RETRIES: number of rx packets(MPDUs) from this station
+ *	with retry bit set (u32)
  * @__NL80211_STA_INFO_AFTER_LAST: internal
  * @NL80211_STA_INFO_MAX: highest possible station info attribute
  */
@@ -3933,6 +3935,7 @@ enum nl80211_sta_info {
 	NL80211_STA_INFO_AIRTIME_LINK_METRIC,
 	NL80211_STA_INFO_ASSOC_AT_BOOTTIME,
 	NL80211_STA_INFO_CONNECTED_TO_AS,
+	NL80211_STA_INFO_RX_RETRIES,
 
 	/* keep last */
 	__NL80211_STA_INFO_AFTER_LAST,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index c1f850138405..f8d408ac6742 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3191,6 +3191,9 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 	if (!ieee80211_frame_allowed(rx, fc))
 		return RX_DROP_MONITOR;
 
+	if (ieee80211_has_retry(hdr->frame_control) && rx->sta)
+		rx->link_sta->rx_stats.rx_retries++;
+
 	/* directly handle TDLS channel switch requests/responses */
 	if (unlikely(((struct ethhdr *)rx->skb->data)->h_proto ==
 						cpu_to_be16(ETH_P_TDLS))) {
@@ -4976,6 +4979,9 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		goto drop;
 	}
 
+	if (ieee80211_has_retry(hdr->frame_control) && rx->sta)
+		rx->link_sta->rx_stats.rx_retries++;
+
 	ieee80211_rx_8023(rx, fast_rx, orig_len);
 
 	return true;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index da5fdd6f5c85..b04092b6ea64 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2653,6 +2653,11 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 	}
 
+	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_RETRIES))) {
+		sinfo->rx_retries = sta->deflink.rx_stats.rx_retries;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_RETRIES);
+	}
+
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED))) {
 		sinfo->tx_failed = sta->deflink.status_stats.retry_failed;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index a52fb76386d0..a4c47e3f0d5a 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -436,6 +436,7 @@ struct ieee80211_sta_rx_stats {
 	struct u64_stats_sync syncp;
 	u64 bytes;
 	u64 msdu[IEEE80211_NUM_TIDS + 1];
+	u32 rx_retries;
 };
 
 /*
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b4edba6b0b7b..fb643d3061c5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6626,6 +6626,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 
 	PUT_SINFO(RX_PACKETS, rx_packets, u32);
 	PUT_SINFO(TX_PACKETS, tx_packets, u32);
+	PUT_SINFO(RX_RETRIES, rx_retries, u32);
 	PUT_SINFO(TX_RETRIES, tx_retries, u32);
 	PUT_SINFO(TX_FAILED, tx_failed, u32);
 	PUT_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
-- 
2.34.1


