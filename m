Return-Path: <linux-wireless+bounces-17281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1186AA0862E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 05:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07742166A78
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 04:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795EF2063F9;
	Fri, 10 Jan 2025 04:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PyQNkCEf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6671E3762
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 04:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736483172; cv=none; b=Wkpg62coE0pp46t6twer+V3JmVTz5QJ/hvj7oBfTGKVnbluB3g+j8I0qtoNkDLTnCdLrE029pT/MA/glirSYDlD4Y5sXtHcgebGPxzB1bw1ftDSQEXJJ/DiH/xW7ryOvhQIJwjfjiwslx22A0GvG5TJ96T66jkLK6gqQDUpVb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736483172; c=relaxed/simple;
	bh=qSKiMQa1Uoiu+JIfRZexkqTUsDRAEt8KTZVJ+yfJE5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+VgVDl3MFJs6z2+DG1V5vfqIYo7QWNSH7N0TQWpGs/KadZvzkMxPCGOKXX1ve/uX5zGG0G9Vl9vYhv3KaqU+7TQfZSyeDnUQ9WdAea+gdlZlrLQAbFuyUJTco5R9cA9AInKqhtS7vcJal656garizzl/OprrB3HVRuF0rmQnMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PyQNkCEf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A3bXlF002584;
	Fri, 10 Jan 2025 04:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zUxTMGrvGjMqDRFhH9O3tWFiOsTfUpOsT55imAWxmno=; b=PyQNkCEfyLnB1D29
	SVuIEgYDefEkDuzVNHc5cESjpWzOdLo9egji8WvERmK8JAwMuejND/DlH9rtp1v9
	uRQT8FTGQYEjiTD0bnqvA9WbnY4kSgtLJ75SN/KAQ0cS63zf+NoV9a8jYdATSGNr
	+Pa1RVig14dWF7CXsQbSX+7srizkVl6HYDr9adkTseo6fGrZ9SDuxEXBYPjHRIwr
	ocMOvvz/KQH/ZJeTdmX6b7/VqSjDV9VvKee7EQPJbMIMHENmj/zcVTw4uo+AiuXi
	fApYjIpil7TowhyvVnnNWrSNn7QjXbX84Yi/uVDtGUkvEVCNy3vO1GvBMPzvnNrC
	ufboOQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442uteg2ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:47 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A4Pkwd002288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:46 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 20:25:44 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC 5/7] wifi: mac80211: add support to accumulate removed link statistics
Date: Fri, 10 Jan 2025 09:54:47 +0530
Message-ID: <20250110042449.1158789-6-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: wHLh0P_hRF37bjTNsGORHSkxPevZ-hRZ
X-Proofpoint-ORIG-GUID: wHLh0P_hRF37bjTNsGORHSkxPevZ-hRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=993 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100034

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
 net/mac80211/sta_info.c | 30 ++++++++++++++++++++++++++++++
 net/mac80211/sta_info.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f4492174d2c4..4b78b03b1047 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -356,6 +356,24 @@ static void sta_info_free_link(struct link_sta_info *link_sta)
 	free_percpu(link_sta->pcpu_rx_stats);
 }
 
+static void sta_accumulate_removed_link_stats(struct sta_info *sta, int link_id)
+{
+	struct link_sta_info *link_sta =
+		rcu_dereference_protected(sta->link[link_id],
+					  lockdep_is_held(&sta->local->hw.wiphy->mtx));
+	int ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		sta->rem_link_stats.tx_packets += link_sta->tx_stats.packets[ac];
+		sta->rem_link_stats.tx_bytes += link_sta->tx_stats.bytes[ac];
+	}
+
+	sta->rem_link_stats.rx_packets += link_sta->rx_stats.packets;
+	sta->rem_link_stats.rx_bytes += link_sta->rx_stats.bytes;
+	sta->rem_link_stats.tx_retries += link_sta->status_stats.retry_count;
+	sta->rem_link_stats.tx_failed += link_sta->status_stats.retry_failed;
+}
+
 static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 			    bool unhash)
 {
@@ -378,6 +396,10 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 		alloc = container_of(link_sta, typeof(*alloc), info);
 
 	sta->sta.valid_links &= ~BIT(link_id);
+
+	/* store removed link info for accumulated stats consistency */
+	sta_accumulate_removed_link_stats(sta, link_id);
+
 	RCU_INIT_POINTER(sta->link[link_id], NULL);
 	RCU_INIT_POINTER(sta->sta.link[link_id], NULL);
 	if (alloc) {
@@ -2883,6 +2905,14 @@ static void sta_set_mld_sinfo(struct station_info *sinfo, struct sta_info *sta)
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 		}
 	}
+
+	/* Add accumulated removed link data to sinfo data for consistency */
+	sinfo->tx_packets += sta->rem_link_stats.tx_packets;
+	sinfo->rx_packets += sta->rem_link_stats.rx_packets;
+	sinfo->tx_bytes += sta->rem_link_stats.tx_bytes;
+	sinfo->rx_bytes += sta->rem_link_stats.rx_bytes;
+	sinfo->tx_retries += sta->rem_link_stats.tx_retries;
+	sinfo->tx_failed += sta->rem_link_stats.tx_failed;
 }
 
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 1d82519319fe..2ddea966d500 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -569,6 +569,32 @@ struct link_sta_info {
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
+ */
+struct ieee80211_sta_removed_link_stats {
+	u32 rx_packets;
+	u32 tx_packets;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	u32 tx_retries;
+	u32 tx_failed;
+};
+
 /**
  * struct sta_info - STA information
  *
@@ -646,6 +672,7 @@ struct link_sta_info {
  *	@deflink address and remaining would be allocated and the address
  *	would be assigned to link[link_id] where link_id is the id assigned
  *	by the AP.
+ * @rem_link_stats: accumulated removed link stats
  */
 struct sta_info {
 	/* General information, mostly static */
@@ -722,6 +749,7 @@ struct sta_info {
 	struct ieee80211_sta_aggregates cur;
 	struct link_sta_info deflink;
 	struct link_sta_info __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct ieee80211_sta_removed_link_stats rem_link_stats;
 
 	/* keep last! */
 	struct ieee80211_sta sta;
-- 
2.34.1


