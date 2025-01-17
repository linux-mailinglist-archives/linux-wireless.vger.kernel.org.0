Return-Path: <linux-wireless+bounces-17641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F6A14F9B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 13:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCECC1684CB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 12:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D66F1FF1DB;
	Fri, 17 Jan 2025 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T584bNiq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A361FF5F5
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117995; cv=none; b=gCEosYF71yQ5dPcAlpDT1rUUQjyAYYOGwcWYeoGuno1Fe7sJRGcYEl0mLMYXePz2rT9vWkA99VnD4+JO5pfO3J/i5pIddE6DjZwc6LHy/JI0LALsxBZuA9id4UiOmSGTdrCX8pExinKWbw6Lo6MHa7dqDMdPe+pDYIdkbnKPlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117995; c=relaxed/simple;
	bh=PyMX4PbLyJU3IKJ5JmdgMqKYbNlctXDkkkwr055qO50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sj4Rwzd5X/9timywkEhHVlom7AxCucilQM4LuG10IWDJHs1aiHgQrEs+x1BnlnIM+srOtiyCe6RPwYmKB5X9ZiD415DN9wC07eIHU4OwxOcUeE+TMRUGQji8AJIKOrTvOYmTqu6Jam4n3vBni0PkZb5f2z1EiTM4DKZN0DMxTaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T584bNiq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H9nn5T019979;
	Fri, 17 Jan 2025 12:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VZcglt0NTMuWO5/mDeo+N4DHaSNejAkSTEdLNtqcPr4=; b=T584bNiqH3fmvngz
	ZXOt6GdZ1IsUZ5A6t4/RrWnSKlt1z7jfCgfNQJ/ISGkJWZNkhT1QyauN82P8ay13
	TyA1a1U26VTDIbz2ev/TwaVLrDKc2mBnvg1N7svFxEFVvA0pAZeahjF5Bwa+R7lM
	dAZSJ5matJMA4zNJ4p5kefzHlgLBZRvp7mGt+4Tvkg5DcTMFPmWgjjFiSgPuUJhd
	SZ7miHAh+hC8GctM0C+Km43JhkHL8xcJRhhjTyWt3RGriX8SUleLIbanTyvi4IZc
	z3kSNOyl6g9rXta7I4gop5PSBacbl2oHNz879MhBLGXfmr0OEeKoCWk65NEE9ZhH
	e0+NBQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447mwq0fad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:46:29 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50HCkSO2031097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:46:28 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 Jan 2025 04:46:26 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC v2 04/12] wifi: mac80211: introduce sta_set_link_sinfo API to add support towards MLO statistics
Date: Fri, 17 Jan 2025 18:15:46 +0530
Message-ID: <20250117124554.3719808-5-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
References: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: eI7SwbapSOwtU-RGxB76knOUyYcC-EOD
X-Proofpoint-GUID: eI7SwbapSOwtU-RGxB76knOUyYcC-EOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170102

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
index e0465068a97f..1060b6d7c6f9 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2615,42 +2615,36 @@ static void sta_set_mesh_sinfo(struct sta_info *sta,
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
 
@@ -2658,26 +2652,26 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
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
@@ -2687,12 +2681,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
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
@@ -2701,12 +2695,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
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
 
@@ -2727,12 +2721,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
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
@@ -2754,7 +2748,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		if (!sta->deflink.pcpu_rx_stats &&
 		    !(sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))) {
 			sinfo->signal_avg =
-				-ewma_signal_read(&sta->deflink.rx_stats_avg.signal);
+				-ewma_signal_read(&link_sta_info->rx_stats_avg.signal);
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 		}
 	}
@@ -2767,7 +2761,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	    !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL) |
 			       BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)))) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
-		if (!sta->deflink.pcpu_rx_stats)
+		if (!link_sta_info->pcpu_rx_stats)
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
 
 		sinfo->chains = last_rxstats->chains;
@@ -2776,14 +2770,14 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
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
@@ -2799,11 +2793,6 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
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
@@ -2811,8 +2800,51 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
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
@@ -2837,27 +2869,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
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


