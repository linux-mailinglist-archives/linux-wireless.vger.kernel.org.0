Return-Path: <linux-wireless+bounces-18936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18068A34BDF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A6D3ADDC9
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BE02063EC;
	Thu, 13 Feb 2025 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pERqWDRq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F1207A11
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467062; cv=none; b=P3NTyUkIACrUb63p5XEjXfjNOOZ1Spx3Y6ATvHAJetdOGE0euWTz1LxPFXETcWcZbHJ6CAwX8i8M6jHfktGJBn9j0LfsYmZmpod9+L339t1LJyo1xt6cTnyTbzzoO4cmRok3Q/XPL7+BwlV5uJAnT6iHf/jfqXvldPpJO3Dm5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467062; c=relaxed/simple;
	bh=bB91Ks1vza2/DUAZrL8iZ5iNWSwWCuX9ZnwP3KHW5LA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDVGZK9BJnQjmjVQqDseUEuxSbIU49Y+nF0bI0V/Nwwf0paCcsBTs9+9bUh5SPc5ySopUglwFimeE+qhk0b59kxQNycAxWflV9VJUyW7FzP4maLY3dNx3q+cww04TTk8pSqBa8+LWYnvkGa9rSppUE+GAeRHi3PyEAiOvlECUog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pERqWDRq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8Nbej007881;
	Thu, 13 Feb 2025 17:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YZurnuYW/VDL4M8vov83Yh85P3WopfyZ6VqepReNFUM=; b=pERqWDRq0A847NWu
	8LH2EB0/WwRJescyzNYyNq50dAbp+UHsLGBzd4Qvx7S7g+iU0MT9t3gclJfrcCOc
	G43DY6PG/v0y8V16AVG7+kjDZIFGmtbUQOmLvsMdbBUDT+dKlooJjqrF5OkaIk1M
	19UzUjD3O7IdqnyeiZysEJfFHzrl7t7dA8sRzMhGiQbnLLAChbDBbbR0Zrjn+hVJ
	c9c5S/9BC58wCdqPIyB4I+0MlIho14sC7EUbTYiJfWWI4opbe+hVw4gIE5DcL+jZ
	FfpAPETfS+DNBfFuaK1acEyTpDKVQAsRR2YpnalKy3MMZ1jvwdEiNOmGjMimLC9K
	k4IEJQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rr1qvr20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:35 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DHHYpt012008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:34 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Feb 2025 09:17:33 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH v3 11/12] wifi: cfg80211: add additional MLO statistics
Date: Thu, 13 Feb 2025 22:46:31 +0530
Message-ID: <20250213171632.1646538-12-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: eNG7i2lQNZ0pYG5suvETZKYtiwxO0--k
X-Proofpoint-ORIG-GUID: eNG7i2lQNZ0pYG5suvETZKYtiwxO0--k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130122

Currently, the accumulable statistics for multi-link operation(MLO)
are handled. Other statistics, such as signal and rates, are managed at
the link level. Therefore, add signal and rates at the MLO level to
provide an comprehensive overview of the station.

The signal could be the best of all links-
e.g. if Link 1 has a signal strength of -70 dBm and Link 2 has -65 dBm,
the signal for MLO will be -65 dBm.

The rate could be determined based on the most recently updated link-
e.g. if link 1 has a rate of 300 Mbps and link 2 has a rate of 450 Mbps,
the MLO rate can be calculated based on the inactivity of each link.
If the inactive time for link 1 is 20 seconds and for link 2 is 10 seconds,
the MLO rate will be the most recently updated rate, which is link 2's
rate of 450 Mbps.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h |  7 ++++
 net/wireless/nl80211.c | 79 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1a6b428b2699..fddbd37c2385 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2180,6 +2180,10 @@ struct link_station_info {
  * @tx_bytes: total bytes (size of MPDUs) transmitted to this station
  * @tx_retries: cumulative retry counts (MPDUs)
  * @tx_failed: number of failed transmissions (MPDUs) (retries exceeded, no ACK)
+ * @signal: The signal strength, type depends on the wiphy's signal_type.
+ *	For CFG80211_SIGNAL_TYPE_MBM, value is expressed in _dBm_.
+ * @txrate: last updated unicast bitrate from this station
+ * @rxrate: last updated unicast bitrate to this station
  * @valid_links: bitmap of valid links, or 0 for non-MLO. Drivers fill this
  *	information in cfg80211_new_sta(), cfg80211_del_sta_sinfo(),
  *	get_station() and dump_station() callbacks.
@@ -2222,6 +2226,9 @@ struct station_info {
 	u64 tx_bytes;
 	u32 tx_retries;
 	u32 tx_failed;
+	s8 signal;
+	struct rate_info txrate;
+	struct rate_info rxrate;
 
 	u16 valid_links;
 	/* TODO: Need to check and add protection access to links memory */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0a0e8ea488a1..34d7efd0f018 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6861,7 +6861,8 @@ static int nl80211_fill_link_station(struct sk_buff *msg,
 }
 
 static int nl80211_fill_mld_station(struct sk_buff *msg,
-				    struct station_info *sinfo)
+				    struct station_info *sinfo,
+				    struct cfg80211_registered_device *rdev)
 {
 	PUT_SINFO(RX_PACKETS, rx_packets, u32);
 	PUT_SINFO(TX_PACKETS, tx_packets, u32);
@@ -6870,6 +6871,26 @@ static int nl80211_fill_mld_station(struct sk_buff *msg,
 	PUT_SINFO(TX_RETRIES, tx_retries, u32);
 	PUT_SINFO(TX_FAILED, tx_failed, u32);
 
+	switch (rdev->wiphy.signal_type) {
+	case CFG80211_SIGNAL_TYPE_MBM:
+		PUT_SINFO(SIGNAL, signal, u8);
+		break;
+	default:
+		break;
+	}
+
+	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) {
+		if (!nl80211_put_sta_rate(msg, &sinfo->txrate,
+					  NL80211_STA_INFO_TX_BITRATE))
+			goto nla_put_failure;
+	}
+
+	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) {
+		if (!nl80211_put_sta_rate(msg, &sinfo->rxrate,
+					  NL80211_STA_INFO_RX_BITRATE))
+			goto nla_put_failure;
+	}
+
 	return 0;
 
 nla_put_failure:
@@ -6923,7 +6944,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		goto nla_put_failure;
 
 	if (sinfo->is_per_link_stats_support && sinfo->valid_links) {
-		if (nl80211_fill_mld_station(msg, sinfo))
+		if (nl80211_fill_mld_station(msg, sinfo, rdev))
 			goto nla_put_failure;
 
 		/* Closing nested STA_INFO as MLO links ATTR should not
@@ -7001,10 +7022,40 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 #undef PUT_SINFO
 #undef PUT_SINFO_U64
 
+static void cfg80211_sta_set_mld_rate_info(struct rate_info *sinfo_rate,
+					   struct rate_info *link_sinfo_rate)
+{
+	if (link_sinfo_rate->flags)
+		sinfo_rate->flags = link_sinfo_rate->flags;
+	if (link_sinfo_rate->legacy)
+		sinfo_rate->legacy = link_sinfo_rate->legacy;
+	if (link_sinfo_rate->mcs)
+		sinfo_rate->mcs = link_sinfo_rate->mcs;
+	if (link_sinfo_rate->nss)
+		sinfo_rate->nss = link_sinfo_rate->nss;
+	if (link_sinfo_rate->bw)
+		sinfo_rate->bw = link_sinfo_rate->bw;
+	if (link_sinfo_rate->he_gi)
+		sinfo_rate->he_gi = link_sinfo_rate->he_gi;
+	if (link_sinfo_rate->he_dcm)
+		sinfo_rate->he_dcm = link_sinfo_rate->he_dcm;
+	if (link_sinfo_rate->he_ru_alloc)
+		sinfo_rate->he_ru_alloc = link_sinfo_rate->he_ru_alloc;
+	if (link_sinfo_rate->n_bonded_ch)
+		sinfo_rate->n_bonded_ch = link_sinfo_rate->n_bonded_ch;
+	if (link_sinfo_rate->eht_gi)
+		sinfo_rate->eht_gi = link_sinfo_rate->eht_gi;
+	if (link_sinfo_rate->eht_ru_alloc)
+		sinfo_rate->eht_ru_alloc = link_sinfo_rate->eht_ru_alloc;
+}
+
 static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
 {
 	struct link_station_info *link_sinfo;
-	int link_id;
+	int link_id, init = 0;;
+	u32 link_inactive_time;
+
+	sinfo->signal = -99;
 
 	for_each_valid_link(sinfo, link_id) {
 		link_sinfo = sinfo->links[link_id];
@@ -7042,6 +7093,28 @@ static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
 			sinfo->tx_failed += link_sinfo->tx_failed;
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 		}
+
+		/* Update MLO signal as per best of all link signal */
+		if ((link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) &&
+		    (link_sinfo->signal > sinfo->signal)) {
+			sinfo->signal = link_sinfo->signal;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+		}
+
+		/* Update MLO rates as per last updated link rate */
+		if ((link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
+		    (!init || link_inactive_time > link_sinfo->inactive_time)) {
+			link_inactive_time = link_sinfo->inactive_time;
+			cfg80211_sta_set_mld_rate_info(&sinfo->txrate, &link_sinfo->txrate);
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+		}
+		if ((link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) &&
+		    (!init || link_inactive_time > link_sinfo->inactive_time)) {
+			link_inactive_time = link_sinfo->inactive_time;
+			cfg80211_sta_set_mld_rate_info(&sinfo->rxrate, &link_sinfo->rxrate);
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+		}
+		init++;
 	}
 }
 
-- 
2.34.1


