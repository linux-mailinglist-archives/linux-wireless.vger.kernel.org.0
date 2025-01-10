Return-Path: <linux-wireless+bounces-17280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D144EA0862D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 05:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86C23A941F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 04:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22E8205AB3;
	Fri, 10 Jan 2025 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gTyTms4q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F3126C10
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 04:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736483171; cv=none; b=KmgkDo2fwufc3BKbuqJzUtGKGMo5xYAHA+R/2Qolw1hl9xREv7XSbXJqSn4SCQfwG3PhptNK+SC1xnqUlzNTbdhX0DjGaMnvi+QUT5cVT41QfFx69213h5ASwpatihkXv3jqFeHoCCZrMcfFVETcBREDv5COxApCom/vbkW8kOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736483171; c=relaxed/simple;
	bh=PRAywbvg2qtPecU+jGpfi6FcxK3jK8whm8R25J6dxjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ub7++RrIenuMLDHTgKVT2MtVpM3PLHChkWMyhcD5NpXoXSNd2R9/VhwoHg4r//fiLKPzh8BonkDVzU39B4LbLN11DUOYUvoKfIoosemwh+n7n0O/CI6rY2W0u2gbumyhwjtzsIfYnl0zyuEe0kQdc8uKdl05cIlquVL9u8SZ30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gTyTms4q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509K1ioQ030498;
	Fri, 10 Jan 2025 04:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L216Zcny7vXCBxEvO3/iRLrPZ1CrDlWfrZTI5JxqV38=; b=gTyTms4qGKs86NNV
	gH6lMpHtGU1BIrd9y0VQEu7dRCINs3Nhg2q+xudrWdJcyZfcoiCrQ30lW5yzqZ1Z
	osnGDvjbRvSxZo7ORS2wc9iR8lV8tnTNINg7RZFjRT+Nj4CCFYcZfVo25pyWPyvQ
	nJmFH2kNhSG0JkyRbJ809cLUboLaGl7LbNEhr1mFUb2Lyv+f8UGk7eebPzXGXe17
	QR2vkPQon31Wj5w97rMZ/68NUXdpvx6zrT6+q/gtJilDF2jCS8ej3mET3WXpKe2h
	7KBinQ/l3+fMMDYTXK3qZw7qfJUMoxX+js42c6jfmt60zq/LQpd/dcWGM98ABd8m
	LGE2CQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442n4r0x8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A4PmbC002301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:48 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 20:25:46 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC 6/7] wifi: cfg80211: add additional MLO statistics
Date: Fri, 10 Jan 2025 09:54:48 +0530
Message-ID: <20250110042449.1158789-7-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: HF-EP4WfADhuEmhJ0maGKbPdkx7P04lq
X-Proofpoint-ORIG-GUID: HF-EP4WfADhuEmhJ0maGKbPdkx7P04lq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=977 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100034

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

NOTE:
 - Currently using one of the link to fill rate and signal. Could add
   the last updated for rate and best of signal for MLO with actual
   patches.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h  |  7 +++++++
 net/mac80211/sta_info.c | 44 +++++++++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c  | 25 +++++++++++++++++++++--
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ac038903d53e..30231855be1f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2180,6 +2180,10 @@ struct link_station_info {
  * @tx_bytes: bytes (size of MPDUs) transmitted to this station
  * @tx_retries: cumulative retry counts (MPDUs)
  * @tx_failed: number of failed transmissions (MPDUs) (retries exceeded, no ACK)
+ * @signal: The signal strength, type depends on the wiphy's signal_type.
+ *	For CFG80211_SIGNAL_TYPE_MBM, value is expressed in _dBm_.
+ * @txrate: last updated unicast bitrate from this station
+ * @rxrate: last updated unicast bitrate to this station
  * @deflink: This holds the default link STA information, for non MLO STA
  *	all link specific STA information is accessed through @deflink.
  * @links: reference to Link sta entries for MLO.
@@ -2218,6 +2222,9 @@ struct station_info {
 	u64 tx_bytes;
 	u32 tx_retries;
 	u32 tx_failed;
+	s8 signal;
+	struct rate_info txrate;
+	struct rate_info rxrate;
 
 	struct link_station_info deflink;
 	/* TODO: Need to check and add protection access to links memory */
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 4b78b03b1047..2cad17cb64d7 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2858,6 +2858,33 @@ static void sta_set_link_sinfo(struct sta_info *sta, struct link_station_info *l
 	}
 }
 
+static void sta_set_mld_rate_info(struct rate_info *sinfo_rate,
+				  struct rate_info *link_sinfo_rate)
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
 static void sta_set_mld_sinfo(struct station_info *sinfo, struct sta_info *sta)
 {
 	struct link_station_info *link_sinfo;
@@ -2913,6 +2940,23 @@ static void sta_set_mld_sinfo(struct station_info *sinfo, struct sta_info *sta)
 	sinfo->rx_bytes += sta->rem_link_stats.rx_bytes;
 	sinfo->tx_retries += sta->rem_link_stats.tx_retries;
 	sinfo->tx_failed += sta->rem_link_stats.tx_failed;
+
+	/*TODO: set mld stats for signal based on best values and signal
+	 * for last updated, currently using one of the link to fill stats
+	 */
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL)) {
+		sinfo->signal = link_sinfo->signal;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	}
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) {
+		sta_set_mld_rate_info(&sinfo->txrate, &link_sinfo->txrate);
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	}
+
+	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) {
+		sta_set_mld_rate_info(&sinfo->rxrate, &link_sinfo->rxrate);
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+	}
 }
 
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 06688aa1780f..99d74f67b1a2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6839,7 +6839,8 @@ static int nl80211_fill_link_station(struct sk_buff *msg,
 }
 
 static int nl80211_fill_mld_station(struct sk_buff *msg,
-				    struct station_info *sinfo)
+				    struct station_info *sinfo,
+				    struct cfg80211_registered_device *rdev)
 {
 #define PUT_SINFO(attr, memb, type) do {				\
 	BUILD_BUG_ON(sizeof(type) == sizeof(u64));			\
@@ -6862,9 +6863,29 @@ static int nl80211_fill_mld_station(struct sk_buff *msg,
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
 #undef PUT_SINFO
 #undef PUT_SINFO_U64
 
+	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) {
+		if (!nl80211_put_sta_rate(msg, &sinfo->txrate,
+					  NL80211_STA_INFO_TX_BITRATE))
+			return -EMSGSIZE;
+	}
+
+	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) {
+		if (!nl80211_put_sta_rate(msg, &sinfo->rxrate,
+					  NL80211_STA_INFO_RX_BITRATE))
+			return -EMSGSIZE;
+	}
+
 	return 0;
 }
 
@@ -6942,7 +6963,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 #undef PUT_SINFO_U64
 
 	if (sinfo->valid_links) {
-		ret = nl80211_fill_mld_station(msg, sinfo);
+		ret = nl80211_fill_mld_station(msg, sinfo, rdev);
 		if (ret)
 			goto nla_put_failure;
 
-- 
2.34.1


