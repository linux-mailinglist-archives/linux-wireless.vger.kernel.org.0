Return-Path: <linux-wireless+bounces-18929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC56A34B8C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D3D16972A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C39B1547F5;
	Thu, 13 Feb 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K228mEPA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50910204F74
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467048; cv=none; b=n8/Yj8A8vml2skKwoMjdWU6x39Aw2fSsfL2Gc0OAs+SGwYfJ+4/RATeR4puyLio3E0Y4wj21VWLaBoZW/TNl57MnnjuhV63wn/tGXlFbK5gWWikOYcDQZwF7P+gyJq19GbtmIOCCUJlHUHzJj4DlfoRik+8DRX/ugtBNbdNOdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467048; c=relaxed/simple;
	bh=0tJ/Kl30iRNlWfP/67NzeXNmOLushnN5UJs702gdScM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfX0V4kBHb+6xvue3WMkuog4AG7oDKT/d5F10WpOpimN+ZVzifXxG5W5yKlZz4ytCOpzL4q3TUpKgZN38PHYHcIpPo6rWsUp5pPSGyH7U/TY69VI700rKxIfPlqSbT9K6CJA3Qf/3EboBpBfNoaUu5R4K426lbLa47OSj3k0dCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K228mEPA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D9cKmX015820;
	Thu, 13 Feb 2025 17:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A/HJVR0vwu59MjhoS0katbL6bkEtzbp60yqh/spaDes=; b=K228mEPAsfVB/wH0
	V9jHtSuu/X8+2DsRdIpGqCmedREEObWLUBDNCTdXp21miM2lj9A6LgbZjJLmWm5s
	HJJy6tR378Akk+D7sZC8Fg09kvgFUX/QMIMpvdqdspwp8vbaPlTPyBnRyNwx35vP
	KqW7gip1M8Of09SBUhc6TY0qVZgZLN0bolu6mzhCj3QkIejjKNKOSDJ7xqln8/Qc
	w+XTVewmltw8I1kKL6yz0RMzAyzJo3NvjD8HdBtvqpJTUzF084ufLHyBTx80MMTZ
	xCvPjBe1cV77AShZjpPa064Ei0vvWE8oN2dQ4149NhOJY+E9Ez40SQyomc36LLCx
	dsK0vw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rgpgnt3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:22 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DHHLbQ011779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:21 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Feb 2025 09:17:19 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH v3 04/12] wifi: mac80211: introduce sta_set_link_sinfo API to add support towards MLO statistics
Date: Thu, 13 Feb 2025 22:46:24 +0530
Message-ID: <20250213171632.1646538-5-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: CwfazlVood4y00hxVEyXP5dE4gJPsOya
X-Proofpoint-GUID: CwfazlVood4y00hxVEyXP5dE4gJPsOya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130123

Introduce sta_set_link_sinfo() API to fill fields in sinfo structure
for station statistics.
This is done as code cleanup to allow for simplified filling of link
level station statistics in subsequent patch to add support for
multi-link (ML) station statistics.
No functionality changes added.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/mac80211/sta_info.c | 128 ++++++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 58 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 0f280a89b60a..1d4177f9fbf3 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2636,42 +2636,36 @@ static void sta_set_mesh_sinfo(struct sta_info *sta,
 }
 #endif
 
-void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
-		   bool tidstats)
+static void sta_set_link_sinfo(struct sta_info *sta, struct station_info *sinfo,
+			       struct ieee80211_link_data *link_sdata, bool tidstats)
 {
+	struct link_sta_info *link_sta_info = &sta->deflink;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sta_rx_stats *last_rxstats;
 	u32 thr = 0;
 	int i, ac, cpu;
-	struct ieee80211_sta_rx_stats *last_rxstats;
 
 	last_rxstats = sta_get_last_rx_stats(sta, -1);
 
-	sinfo->generation = sdata->local->sta_generation;
-
 	/* do before driver, so beacon filtering drivers have a
 	 * chance to e.g. just add the number of filtered beacons
 	 * (or just modify the value entirely, of course)
 	 */
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		sinfo->rx_beacon = sdata->deflink.u.mgd.count_beacon_signal;
+		sinfo->rx_beacon = link_sdata->u.mgd.count_beacon_signal;
 
 	drv_sta_statistics(local, sdata, &sta->sta, sinfo);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
-			 BIT_ULL(NL80211_STA_INFO_STA_FLAGS) |
 			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
-			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME) |
-			 BIT_ULL(NL80211_STA_INFO_ASSOC_AT_BOOTTIME) |
 			 BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
 
 	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
 		sinfo->beacon_loss_count =
-			sdata->deflink.u.mgd.beacon_loss_count;
+			link_sdata->u.mgd.beacon_loss_count;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_LOSS);
 	}
 
-	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
-	sinfo->assoc_at = sta->assoc_at;
 	sinfo->inactive_time =
 		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, -1));
 
@@ -2679,26 +2673,26 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
 		sinfo->tx_bytes = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			sinfo->tx_bytes += sta->deflink.tx_stats.bytes[ac];
+			sinfo->tx_bytes += link_sta_info->tx_stats.bytes[ac];
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_PACKETS))) {
 		sinfo->tx_packets = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			sinfo->tx_packets += sta->deflink.tx_stats.packets[ac];
+			sinfo->tx_packets += link_sta_info->tx_stats.packets[ac];
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
 	}
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_RX_BYTES)))) {
-		sinfo->rx_bytes += sta_get_stats_bytes(&sta->deflink.rx_stats);
+		sinfo->rx_bytes += sta_get_stats_bytes(&link_sta_info->rx_stats);
 
-		if (sta->deflink.pcpu_rx_stats) {
+		if (link_sta_info->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats,
+				cpurxs = per_cpu_ptr(link_sta_info->pcpu_rx_stats,
 						     cpu);
 				sinfo->rx_bytes += sta_get_stats_bytes(cpurxs);
 			}
@@ -2708,12 +2702,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_PACKETS))) {
-		sinfo->rx_packets = sta->deflink.rx_stats.packets;
-		if (sta->deflink.pcpu_rx_stats) {
+		sinfo->rx_packets = link_sta_info->rx_stats.packets;
+		if (link_sta_info->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats,
+				cpurxs = per_cpu_ptr(link_sta_info->pcpu_rx_stats,
 						     cpu);
 				sinfo->rx_packets += cpurxs->packets;
 			}
@@ -2722,12 +2716,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_RETRIES))) {
-		sinfo->tx_retries = sta->deflink.status_stats.retry_count;
+		sinfo->tx_retries = link_sta_info->status_stats.retry_count;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED))) {
-		sinfo->tx_failed = sta->deflink.status_stats.retry_failed;
+		sinfo->tx_failed = link_sta_info->status_stats.retry_failed;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 	}
 
@@ -2748,12 +2742,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT);
 	}
 
-	sinfo->rx_dropped_misc = sta->deflink.rx_stats.dropped;
-	if (sta->deflink.pcpu_rx_stats) {
+	sinfo->rx_dropped_misc = link_sta_info->rx_stats.dropped;
+	if (link_sta_info->pcpu_rx_stats) {
 		for_each_possible_cpu(cpu) {
 			struct ieee80211_sta_rx_stats *cpurxs;
 
-			cpurxs = per_cpu_ptr(sta->deflink.pcpu_rx_stats, cpu);
+			cpurxs = per_cpu_ptr(link_sta_info->pcpu_rx_stats, cpu);
 			sinfo->rx_dropped_misc += cpurxs->dropped;
 		}
 	}
@@ -2775,7 +2769,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		if (!sta->deflink.pcpu_rx_stats &&
 		    !(sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))) {
 			sinfo->signal_avg =
-				-ewma_signal_read(&sta->deflink.rx_stats_avg.signal);
+				-ewma_signal_read(&link_sta_info->rx_stats_avg.signal);
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 		}
 	}
@@ -2788,7 +2782,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	    !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL) |
 			       BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)))) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
-		if (!sta->deflink.pcpu_rx_stats)
+		if (!link_sta_info->pcpu_rx_stats)
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
 
 		sinfo->chains = last_rxstats->chains;
@@ -2797,14 +2791,14 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			sinfo->chain_signal[i] =
 				last_rxstats->chain_signal_last[i];
 			sinfo->chain_signal_avg[i] =
-				-ewma_signal_read(&sta->deflink.rx_stats_avg.chain_signal[i]);
+				-ewma_signal_read(&link_sta_info->rx_stats_avg.chain_signal[i]);
 		}
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
 	    !sta->sta.valid_links &&
-	    ieee80211_rate_valid(&sta->deflink.tx_stats.last_rate)) {
-		sta_set_rate_info_tx(sta, &sta->deflink.tx_stats.last_rate,
+	    ieee80211_rate_valid(&link_sta_info->tx_stats.last_rate)) {
+		sta_set_rate_info_tx(sta, &link_sta_info->tx_stats.last_rate,
 				     &sinfo->txrate);
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
@@ -2820,11 +2814,6 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			sta_set_tidstats(sta, &sinfo->pertid[i], i, -1);
 	}
 
-#ifdef CONFIG_MAC80211_MESH
-	if (ieee80211_vif_is_mesh(&sdata->vif))
-		sta_set_mesh_sinfo(sta, sinfo);
-#endif
-
 	sinfo->bss_param.flags = 0;
 	if (sdata->vif.bss_conf.use_cts_prot)
 		sinfo->bss_param.flags |= BSS_PARAM_FLAGS_CTS_PROT;
@@ -2832,8 +2821,51 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->bss_param.flags |= BSS_PARAM_FLAGS_SHORT_PREAMBLE;
 	if (sdata->vif.bss_conf.use_short_slot)
 		sinfo->bss_param.flags |= BSS_PARAM_FLAGS_SHORT_SLOT_TIME;
-	sinfo->bss_param.dtim_period = sdata->vif.bss_conf.dtim_period;
-	sinfo->bss_param.beacon_interval = sdata->vif.bss_conf.beacon_int;
+	sinfo->bss_param.dtim_period = link_sdata->conf->dtim_period;
+	sinfo->bss_param.beacon_interval = link_sdata->conf->beacon_int;
+
+	thr = sta_get_expected_throughput(sta);
+
+	if (thr != 0) {
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
+		sinfo->expected_throughput = thr;
+	}
+
+	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL)) &&
+	    link_sta_info->status_stats.ack_signal_filled) {
+		sinfo->ack_signal = link_sta_info->status_stats.last_ack_signal;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
+	}
+
+	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG)) &&
+	    link_sta_info->status_stats.ack_signal_filled) {
+		sinfo->avg_ack_signal =
+			-(s8)ewma_avg_signal_read(
+				&link_sta_info->status_stats.avg_ack_signal);
+		sinfo->filled |=
+			BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
+	}
+}
+
+void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
+		   bool tidstats)
+{
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct ieee80211_link_data *link_sdata = &sdata->deflink;
+
+	sinfo->generation = sdata->local->sta_generation;
+
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_STA_FLAGS) |
+			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME) |
+			 BIT_ULL(NL80211_STA_INFO_ASSOC_AT_BOOTTIME);
+
+	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
+	sinfo->assoc_at = sta->assoc_at;
+
+#ifdef CONFIG_MAC80211_MESH
+	if (ieee80211_vif_is_mesh(&sdata->vif))
+		sta_set_mesh_sinfo(sta, sinfo);
+#endif
 
 	sinfo->sta_flags.set = 0;
 	sinfo->sta_flags.mask = BIT(NL80211_STA_FLAG_AUTHORIZED) |
@@ -2858,27 +2890,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER))
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
 
-	thr = sta_get_expected_throughput(sta);
-
-	if (thr != 0) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
-		sinfo->expected_throughput = thr;
-	}
-
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL)) &&
-	    sta->deflink.status_stats.ack_signal_filled) {
-		sinfo->ack_signal = sta->deflink.status_stats.last_ack_signal;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
-	}
-
-	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG)) &&
-	    sta->deflink.status_stats.ack_signal_filled) {
-		sinfo->avg_ack_signal =
-			-(s8)ewma_avg_signal_read(
-				&sta->deflink.status_stats.avg_ack_signal);
-		sinfo->filled |=
-			BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
-	}
+	sta_set_link_sinfo(sta, sinfo, link_sdata, tidstats);
 }
 
 u32 sta_get_expected_throughput(struct sta_info *sta)
-- 
2.34.1


