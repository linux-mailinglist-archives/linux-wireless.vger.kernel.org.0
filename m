Return-Path: <linux-wireless+bounces-22985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDCBAB7D46
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 07:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74A74E09B8
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD912957C2;
	Thu, 15 May 2025 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pRzWmCsj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9F295529
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288182; cv=none; b=tXDpBbjEZnEV2vGB3XWGwsw3DMxj4/0xp0Vm6VpVc98Y28nyHdpt4MWAeLR7wi53Kavc++eV/5Qwam2gmJCrzKLnVAkDFZnjYMV+FJ6SoTQTZn0AEfZMeXdBFe3fUxwhTcnvljLbnSWdGtBa0OeWNYlbmilPW0RptIANuYcGNV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288182; c=relaxed/simple;
	bh=z4Z0+FAgr5c+rixu6lG6JejowG+WqaddFsCJvWr390o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9+dzP0kkaRW1TVoguFtmZInQD52G+5O6AbojAxPWEObFXwECWnn26TmVF41ZmVokPO5CtYtrthczRP3swGsOtWygsCdosC9TYLUITYDMH66X8xBYxfNXB30Favprfl2QsgjkqmJxH+bxdNtMMcytkXcXCyQSKZqKYgVRahhabo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pRzWmCsj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ELKFMS015135;
	Thu, 15 May 2025 05:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RnKefsPEXYBk3lXEXd/OIh4Gh3yCDqYiFt8blw6di2M=; b=pRzWmCsjTfnw+T9t
	CmRTOm0Q8SwRCiuva+1wYRTtIAaGFj3ZrNZPpbAicqYTMnvv1gSkEvcolM0PnOs2
	TvcvwBhqOc7hFR91ktnwptCM6xvz50SLzabXLkDzbnvJyKp6TIf0sX8Ob6y1iCVL
	BoJvfUM4w905nMcKwV7bcPyNj6bqZ0SIpI9cDWrhnlIHK0vZMuj4T0/W71veDXii
	5Xg2SJHRGC7hS+Hj2s2nb2xeybqr6yYWblgnRlsOODAqjb/Z7wKecRAk/h7ezuVF
	CgsayGzCw+gm3Xiw+Za5C+I3mWaQ5vMOsP8RdiHP8Rfdp1zUClZkXIa+lXybRMAi
	HShmag==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcr4x4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F5nZiO016661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:35 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 22:49:33 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v8 08/10] wifi: mac80211: extend support to fill link level sinfo structure
Date: Thu, 15 May 2025 11:19:02 +0530
Message-ID: <20250515054904.1214096-9-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 7Mm4ruCUTnPXja7HRH0M8bBtcVd4UAH4
X-Authority-Analysis: v=2.4 cv=Auju3P9P c=1 sm=1 tr=0 ts=68258070 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=6JOsVpmC_jHjrB4HvhwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 7Mm4ruCUTnPXja7HRH0M8bBtcVd4UAH4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA1NSBTYWx0ZWRfX8qDy6AmhGzf+
 Kv+3GGwCnGzDkzSlhrDX4jNvK3vOX2vAtoeOb/dVdT/AN/T7GVVLJ3YHX3fqHX2Uq6OLVa7DLlh
 CsnxFvURSi5LLyBYOVc3nCZQZgSo1Io8gPsnyq7VyUbAZWPu74dCtxlTAUkTosGsFlY/QXY2QI9
 rWp/pCdVnkMxq140vtz3QctYrE9HLKBWMC2/8bzOj/w1h1So94sldYViKS0f96S86jXzZ9tSiQ5
 7JtlDBWMoX7W43TKtXr9lmQ+bKPvydbUlMdrafoKyDcqMgj4w2vlZYwbTYzTJP21wHI2fPU1pxp
 VX4LCiRWDW7bu1eS6njSBJBRlvVuXSk2Sd4tQEnO9LAYdJfOxnwiHkCmXoi3HvS78bCT9Q1UwHY
 i40TMOhYOMOoxc6Q9YaJbIuxZ4Xhl9i8HsMPPkMUQRg7wvHziEaoQhZSo751zzU0r6CziQL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150055

Currently, sinfo structure is supported to fill information at
deflink( or one of the links) level for station. This has problems
when applied to fetch multi-link(ML) station information.

Hence, if valid_links are present, support filling link_station
structure for each link.

This will be helpful to check the link related statistics during MLO.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h  |  11 ++
 net/mac80211/sta_info.c | 262 +++++++++++++++++++++++++++++++++++++++-
 net/wireless/util.c     |  12 ++
 3 files changed, 284 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 65a1a6511172..3dfab12dc870 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8569,6 +8569,17 @@ void cfg80211_tx_mgmt_expired(struct wireless_dev *wdev, u64 cookie,
  */
 int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
 
+/**
+ * cfg80211_link_sinfo_alloc_tid_stats - allocate per-tid statistics.
+ *
+ * @link_sinfo: the link station information
+ * @gfp: allocation flags
+ *
+ * Return: 0 on success. Non-zero on error.
+ */
+int cfg80211_link_sinfo_alloc_tid_stats(struct link_station_info *link_sinfo,
+					gfp_t gfp);
+
 /**
  * cfg80211_sinfo_release_content - release contents of station info
  * @sinfo: the station information
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 709250ba37c9..906569651fbd 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2698,17 +2698,257 @@ void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
 	sinfo->rx_dropped_misc += sta->rem_link_stats.rx_dropped_misc;
 }
 
+static void sta_set_link_sinfo(struct sta_info *sta,
+			       struct link_station_info *link_sinfo,
+			       struct ieee80211_link_data *link_sdata,
+			       bool tidstats)
+{
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct ieee80211_sta_rx_stats *last_rxstats;
+	struct link_sta_info *link_sta_info;
+	u32 thr = 0;
+	int i, ac, cpu, link_id;
+
+	link_id = link_sinfo->link_id;
+	last_rxstats = sta_get_last_rx_stats(sta, link_id);
+
+	link_sta_info = wiphy_dereference(sta->local->hw.wiphy,
+					  sta->link[link_id]);
+
+	/* do before driver, so beacon filtering drivers have a
+	 * chance to e.g. just add the number of filtered beacons
+	 * (or just modify the value entirely, of course)
+	 */
+	if (sdata->vif.type == NL80211_IFTYPE_STATION)
+		link_sinfo->rx_beacon = link_sdata->u.mgd.count_beacon_signal;
+
+	ether_addr_copy(link_sinfo->addr, link_sta_info->addr);
+
+	/* TODO: add drv_link_sta_statistics() ops to fill link_station
+	 * statistics of station.
+	 */
+
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
+			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
+			 BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
+
+	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
+		link_sinfo->beacon_loss_count =
+			link_sdata->u.mgd.beacon_loss_count;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_LOSS);
+	}
+
+	link_sinfo->inactive_time =
+		jiffies_to_msecs(jiffies -
+		ieee80211_sta_last_active(sta, link_id));
+
+	if (!(link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
+				    BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
+		link_sinfo->tx_bytes = 0;
+		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
+			link_sinfo->tx_bytes +=
+				link_sta_info->tx_stats.bytes[ac];
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_PACKETS))) {
+		link_sinfo->tx_packets = 0;
+		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
+			link_sinfo->tx_packets +=
+				link_sta_info->tx_stats.packets[ac];
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+	}
+
+	if (!(link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES64) |
+			       BIT_ULL(NL80211_STA_INFO_RX_BYTES)))) {
+		link_sinfo->rx_bytes +=
+			sta_get_stats_bytes(&link_sta_info->rx_stats);
+
+		if (link_sta_info->pcpu_rx_stats) {
+			for_each_possible_cpu(cpu) {
+				struct ieee80211_sta_rx_stats *cpurxs;
+
+				cpurxs = per_cpu_ptr(link_sta_info->pcpu_rx_stats,
+						     cpu);
+				link_sinfo->rx_bytes +=
+					sta_get_stats_bytes(cpurxs);
+			}
+		}
+
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_PACKETS))) {
+		link_sinfo->rx_packets = link_sta_info->rx_stats.packets;
+		if (link_sta_info->pcpu_rx_stats) {
+			for_each_possible_cpu(cpu) {
+				struct ieee80211_sta_rx_stats *cpurxs;
+
+				cpurxs = per_cpu_ptr(link_sta_info->pcpu_rx_stats,
+						     cpu);
+				link_sinfo->rx_packets += cpurxs->packets;
+			}
+		}
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_RETRIES))) {
+		link_sinfo->tx_retries =
+			link_sta_info->status_stats.retry_count;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED))) {
+		link_sinfo->tx_failed =
+			link_sta_info->status_stats.retry_failed;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_DURATION))) {
+		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
+			link_sinfo->rx_duration += sta->airtime[ac].rx_airtime;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_DURATION))) {
+		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
+			link_sinfo->tx_duration += sta->airtime[ac].tx_airtime;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT))) {
+		link_sinfo->airtime_weight = sta->airtime_weight;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT);
+	}
+
+	link_sinfo->rx_dropped_misc = link_sta_info->rx_stats.dropped;
+	if (link_sta_info->pcpu_rx_stats) {
+		for_each_possible_cpu(cpu) {
+			struct ieee80211_sta_rx_stats *cpurxs;
+
+			cpurxs = per_cpu_ptr(link_sta_info->pcpu_rx_stats,
+					     cpu);
+			link_sinfo->rx_dropped_misc += cpurxs->dropped;
+		}
+	}
+
+	if (sdata->vif.type == NL80211_IFTYPE_STATION &&
+	    !(sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)) {
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX) |
+				 BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
+		link_sinfo->rx_beacon_signal_avg =
+			ieee80211_ave_rssi(&sdata->vif, -1);
+	}
+
+	if (ieee80211_hw_check(&sta->local->hw, SIGNAL_DBM) ||
+	    ieee80211_hw_check(&sta->local->hw, SIGNAL_UNSPEC)) {
+		if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL))) {
+			link_sinfo->signal = (s8)last_rxstats->last_signal;
+			link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+		}
+
+		if (!link_sta_info->pcpu_rx_stats &&
+		    !(link_sinfo->filled &
+		       BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))) {
+			link_sinfo->signal_avg =
+				-ewma_signal_read(&link_sta_info->rx_stats_avg.signal);
+			link_sinfo->filled |=
+				BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+		}
+	}
+
+	/* for the average - if pcpu_rx_stats isn't set - rxstats must point to
+	 * the sta->rx_stats struct, so the check here is fine with and without
+	 * pcpu statistics
+	 */
+	if (last_rxstats->chains &&
+	    !(link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL) |
+			       BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)))) {
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
+		if (!link_sta_info->pcpu_rx_stats)
+			link_sinfo->filled |=
+				BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
+
+		link_sinfo->chains = last_rxstats->chains;
+
+		for (i = 0; i < ARRAY_SIZE(link_sinfo->chain_signal); i++) {
+			link_sinfo->chain_signal[i] =
+				last_rxstats->chain_signal_last[i];
+			link_sinfo->chain_signal_avg[i] =
+				-ewma_signal_read(
+					&link_sta_info->rx_stats_avg.chain_signal[i]);
+		}
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
+	    ieee80211_rate_valid(&link_sta_info->tx_stats.last_rate)) {
+		sta_set_rate_info_tx(sta, &link_sta_info->tx_stats.last_rate,
+				     &link_sinfo->txrate);
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE))) {
+		if (sta_set_rate_info_rx(sta, &link_sinfo->rxrate,
+					 link_id) == 0)
+			link_sinfo->filled |=
+				BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+	}
+
+	if (tidstats && !cfg80211_link_sinfo_alloc_tid_stats(link_sinfo,
+							     GFP_KERNEL)) {
+		for (i = 0; i < IEEE80211_NUM_TIDS + 1; i++)
+			sta_set_tidstats(sta, &link_sinfo->pertid[i], i,
+					 link_id);
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TID_STATS);
+	}
+
+	link_sinfo->bss_param.flags = 0;
+	if (sdata->vif.bss_conf.use_cts_prot)
+		link_sinfo->bss_param.flags |= BSS_PARAM_FLAGS_CTS_PROT;
+	if (sdata->vif.bss_conf.use_short_preamble)
+		link_sinfo->bss_param.flags |= BSS_PARAM_FLAGS_SHORT_PREAMBLE;
+	if (sdata->vif.bss_conf.use_short_slot)
+		link_sinfo->bss_param.flags |= BSS_PARAM_FLAGS_SHORT_SLOT_TIME;
+	link_sinfo->bss_param.dtim_period = link_sdata->conf->dtim_period;
+	link_sinfo->bss_param.beacon_interval = link_sdata->conf->beacon_int;
+
+	thr = sta_get_expected_throughput(sta);
+
+	if (thr != 0) {
+		link_sinfo->filled |=
+			BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
+		link_sinfo->expected_throughput = thr;
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL)) &&
+	    link_sta_info->status_stats.ack_signal_filled) {
+		link_sinfo->ack_signal =
+			link_sta_info->status_stats.last_ack_signal;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
+	}
+
+	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG)) &&
+	    link_sta_info->status_stats.ack_signal_filled) {
+		link_sinfo->avg_ack_signal =
+			-(s8)ewma_avg_signal_read(
+				&link_sta_info->status_stats.avg_ack_signal);
+		link_sinfo->filled |=
+			BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
+	}
+}
+
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
 	u32 thr = 0;
-	int i, ac, cpu;
+	int i, ac, cpu, link_id;
 	struct ieee80211_sta_rx_stats *last_rxstats;
 
 	last_rxstats = sta_get_last_rx_stats(sta, -1);
 
+	sinfo->valid_links = sta->sta.valid_links;
 	sinfo->generation = sdata->local->sta_generation;
 
 	/* do before driver, so beacon filtering drivers have a
@@ -2881,6 +3121,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (tidstats && !cfg80211_sinfo_alloc_tid_stats(sinfo, GFP_KERNEL)) {
 		for (i = 0; i < IEEE80211_NUM_TIDS + 1; i++)
 			sta_set_tidstats(sta, &sinfo->pertid[i], i, -1);
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TID_STATS);
 	}
 
 #ifdef CONFIG_MAC80211_MESH
@@ -2942,6 +3183,25 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->filled |=
 			BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
 	}
+
+	if (sinfo->valid_links) {
+		struct ieee80211_link_data *link_sdata;
+		struct link_sta_info *link_sta;
+
+		ether_addr_copy(sinfo->mld_addr, sta->addr);
+		for_each_valid_link(sinfo, link_id) {
+			link_sta = wiphy_dereference(sta->local->hw.wiphy,
+						     sta->link[link_id]);
+			if (!link_sta || !sinfo->links[link_id])
+				continue;
+
+			sinfo->links[link_id]->link_id = link_id;
+			link_sdata = wiphy_dereference(sdata->local->hw.wiphy,
+						       sdata->link[link_id]);
+			sta_set_link_sinfo(sta, sinfo->links[link_id],
+					   link_sdata, tidstats);
+		}
+	}
 }
 
 u32 sta_get_expected_throughput(struct sta_info *sta)
diff --git a/net/wireless/util.c b/net/wireless/util.c
index ed868c0f7ca8..3c8ff0b3b240 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2626,6 +2626,18 @@ bool cfg80211_does_bw_fit_range(const struct ieee80211_freq_range *freq_range,
 	return false;
 }
 
+int cfg80211_link_sinfo_alloc_tid_stats(struct link_station_info *link_sinfo,
+					gfp_t gfp)
+{
+	link_sinfo->pertid = kcalloc(IEEE80211_NUM_TIDS + 1,
+				     sizeof(*link_sinfo->pertid), gfp);
+	if (!link_sinfo->pertid)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL(cfg80211_link_sinfo_alloc_tid_stats);
+
 int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp)
 {
 	sinfo->pertid = kcalloc(IEEE80211_NUM_TIDS + 1,
-- 
2.34.1


