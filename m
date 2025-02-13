Return-Path: <linux-wireless+bounces-18930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53592A34B99
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EC6188C563
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A269C203710;
	Thu, 13 Feb 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cNaZQt6t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8B2040BA
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467049; cv=none; b=H85l0znNLpyY3uK/UiahsGTajXKZN1Rwel78g8KN33f2XjgufZoolcztVXFLCcSZmFCsj4eYVKfWPpTb/8PbWE7CcIswjh2EEH48evY/s9YSXB9iP7QnFrZqujbmmM40pqdT4fyc6wY3hlv7XCdzhg2YdvzYUuxmAYAW/CutKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467049; c=relaxed/simple;
	bh=KMWRxbHwKQi6+k4BnHJW1uHJc0uBCFl/sfWT5pWNpqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6QgFGHH06CljZKBWWsvvEC8j/hSsjNaEQgCqZoho8b0PXt0wPh3Pomfs45R+A70z4mGX0oTrg0nuQefbAv1QrdC4sCCqwONaXkz5v+4S7xcJmrYRzS+jtGcZD5yGbnTbqUb5xDVlYqmg6jCM0FvzAWn6kT1Q3f75tt007OJFvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cNaZQt6t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DH5fnu008940;
	Thu, 13 Feb 2025 17:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	af/zd1XoqVsurwy2i3Th1G9HvyigEjgvlnRf4QbFtVE=; b=cNaZQt6tENSuKi5i
	StRIPwbg+lmMN35l45b1L7aqT37raHNpjJgP45EIt8di7Jz2IfZzSuiPJsq9ECBx
	Oumn0mrRUanhXvyamZSYiV1oYfNTa1MPpYJOjLH42n4Ps6pwkSKo5X6eBsCi5UXc
	czAJ3dPIelrLEBBiKO+2p3sOOEfUvVvYsEvfVjGkhig4HpJtnNfXkMBZ6nvta1wN
	TY6tU7Df0yl39ei+/CSua4G55g06akfK7TKLkbh1RPE0qKeXnNrIUNoj9YU07GkT
	IWCHzcoweaOUskKFSqs0cAe1C25v7IRLFNkwOzHzuJZpSgg8Ki5/tqS+yutR12Yr
	W19s7w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rr1qvr1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DHHNBD004965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:23 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Feb 2025 09:17:21 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH v3 05/12] wifi: cfg80211: introduced nl80211_fill_link_station API for link attributes towards MLO
Date: Thu, 13 Feb 2025 22:46:25 +0530
Message-ID: <20250213171632.1646538-6-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: RoZsN2mV0EvOI85EanuIUxBxAYKjPlHK
X-Proofpoint-ORIG-GUID: RoZsN2mV0EvOI85EanuIUxBxAYKjPlHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130122

Introduce nl80211_fill_link_station() API to fill link level NL
attributes for station statistics. This will allow to add support
for MLO station statistics in ease way in subsequent patches.
No functionality changes added.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/wireless/nl80211.c | 107 ++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 45 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 02311d5b0e48..11ea97a98067 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6694,30 +6694,6 @@ static bool nl80211_put_signal(struct sk_buff *msg, u8 mask, s8 *signal,
 	return true;
 }
 
-static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
-				u32 seq, int flags,
-				struct cfg80211_registered_device *rdev,
-				struct net_device *dev,
-				const u8 *mac_addr, struct station_info *sinfo)
-{
-	void *hdr;
-	struct nlattr *sinfoattr, *bss_param;
-
-	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
-	if (!hdr) {
-		cfg80211_sinfo_release_content(sinfo);
-		return -1;
-	}
-
-	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
-	    nla_put_u32(msg, NL80211_ATTR_GENERATION, sinfo->generation))
-		goto nla_put_failure;
-
-	sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
-	if (!sinfoattr)
-		goto nla_put_failure;
-
 #define PUT_SINFO(attr, memb, type) do {				\
 	BUILD_BUG_ON(sizeof(type) == sizeof(u64));			\
 	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
@@ -6732,9 +6708,13 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		goto nla_put_failure;					\
 	} while (0)
 
-	PUT_SINFO(CONNECTED_TIME, connected_time, u32);
+static int nl80211_fill_link_station(struct sk_buff *msg,
+				     struct cfg80211_registered_device *rdev,
+				     struct station_info *sinfo)
+{
+	struct nlattr *bss_param;
+
 	PUT_SINFO(INACTIVE_TIME, inactive_time, u32);
-	PUT_SINFO_U64(ASSOC_AT_BOOTTIME, assoc_at);
 
 	if (sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
 			     BIT_ULL(NL80211_STA_INFO_RX_BYTES64)) &&
@@ -6795,17 +6775,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	PUT_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
 	PUT_SINFO(BEACON_LOSS, beacon_loss_count, u32);
 
-	PUT_SINFO(LLID, llid, u16);
-	PUT_SINFO(PLID, plid, u16);
-	PUT_SINFO(PLINK_STATE, plink_state, u8);
-	PUT_SINFO(AIRTIME_LINK_METRIC, airtime_link_metric, u32);
-	PUT_SINFO(LOCAL_PM, local_pm, u32);
-	PUT_SINFO(PEER_PM, peer_pm, u32);
-	PUT_SINFO(NONPEER_PM, nonpeer_pm, u32);
-	PUT_SINFO(CONNECTED_TO_GATE, connected_to_gate, u8);
-	PUT_SINFO(CONNECTED_TO_AS, connected_to_as, u8);
-	PUT_SINFO_U64(T_OFFSET, t_offset);
-
 	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
 		bss_param = nla_nest_start_noflag(msg,
 						  NL80211_STA_INFO_BSS_PARAM);
@@ -6826,11 +6795,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 
 		nla_nest_end(msg, bss_param);
 	}
-	if ((sinfo->filled & BIT_ULL(NL80211_STA_INFO_STA_FLAGS)) &&
-	    nla_put(msg, NL80211_STA_INFO_STA_FLAGS,
-		    sizeof(struct nl80211_sta_flag_update),
-		    &sinfo->sta_flags))
-		goto nla_put_failure;
 
 	PUT_SINFO_U64(RX_DROP_MISC, rx_dropped_misc);
 	PUT_SINFO_U64(BEACON_RX, rx_beacon);
@@ -6843,9 +6807,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		PUT_SINFO(ACK_SIGNAL_AVG, avg_ack_signal, s8);
 	}
 
-#undef PUT_SINFO
-#undef PUT_SINFO_U64
-
 	if (sinfo->pertid) {
 		struct nlattr *tidsattr;
 		int tid;
@@ -6893,6 +6854,59 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		nla_nest_end(msg, tidsattr);
 	}
 
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
+static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
+				u32 seq, int flags,
+				struct cfg80211_registered_device *rdev,
+				struct net_device *dev,
+				const u8 *mac_addr, struct station_info *sinfo)
+{
+	void *hdr;
+	struct nlattr *sinfoattr;
+
+	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
+	if (!hdr) {
+		cfg80211_sinfo_release_content(sinfo);
+		return -1;
+	}
+
+	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
+	    nla_put_u32(msg, NL80211_ATTR_GENERATION, sinfo->generation))
+		goto nla_put_failure;
+
+	sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
+	if (!sinfoattr)
+		goto nla_put_failure;
+
+	PUT_SINFO(CONNECTED_TIME, connected_time, u32);
+	PUT_SINFO_U64(ASSOC_AT_BOOTTIME, assoc_at);
+
+	PUT_SINFO(LLID, llid, u16);
+	PUT_SINFO(PLID, plid, u16);
+	PUT_SINFO(PLINK_STATE, plink_state, u8);
+	PUT_SINFO(AIRTIME_LINK_METRIC, airtime_link_metric, u32);
+	PUT_SINFO(LOCAL_PM, local_pm, u32);
+	PUT_SINFO(PEER_PM, peer_pm, u32);
+	PUT_SINFO(NONPEER_PM, nonpeer_pm, u32);
+	PUT_SINFO(CONNECTED_TO_GATE, connected_to_gate, u8);
+	PUT_SINFO(CONNECTED_TO_AS, connected_to_as, u8);
+	PUT_SINFO_U64(T_OFFSET, t_offset);
+
+	if ((sinfo->filled & BIT_ULL(NL80211_STA_INFO_STA_FLAGS)) &&
+	    nla_put(msg, NL80211_STA_INFO_STA_FLAGS,
+		    sizeof(struct nl80211_sta_flag_update),
+		    &sinfo->sta_flags))
+		goto nla_put_failure;
+
+	if (nl80211_fill_link_station(msg, rdev, sinfo))
+		goto nla_put_failure;
+
 	nla_nest_end(msg, sinfoattr);
 
 	if (sinfo->assoc_req_ies_len &&
@@ -6926,6 +6940,9 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	return -EMSGSIZE;
 }
 
+#undef PUT_SINFO
+#undef PUT_SINFO_U64
+
 static int nl80211_dump_station(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
-- 
2.34.1


