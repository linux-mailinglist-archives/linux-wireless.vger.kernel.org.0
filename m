Return-Path: <linux-wireless+bounces-20138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F348A5B939
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 07:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E119C1893DB7
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 06:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487D21F4CA8;
	Tue, 11 Mar 2025 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LrTQUxiy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98821E5B6D
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674453; cv=none; b=s54v8h1u5KMHBHfZ+8HAR2yBynobQUTKjeE2tT7ktHOVva4GneyoPDTQOIodB8pdb/kw+qowqHg2+X1HKMLCmaeDj4kDJw4S5qMxRIpTbV5IP96hD+jBNpP5Rk8QofdOhh9Odj45l/xelKiN5l+uqAjI0KU1VucVBkT2AlE2lrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674453; c=relaxed/simple;
	bh=5ympzavJZUKsNvydZUU6XnsMmF0Uo6U5U8Ptb2BknSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKb7Aw/5XP+Y8B2nqvBSYoLEzGXoXG5U6IJaLb3IL1/yC183ue4RhaaE9L883lJu6oVSf9a4WyAw95NVmjWG7hWRIbFniGD+NHYQ+9Zx0bsG6iFloMpbo6r5KosCFWcx5GG8LtENIv+3L/g2ngKIamCqAf7HHH2/DGV+27F7+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LrTQUxiy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJJ6tw021474;
	Tue, 11 Mar 2025 06:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oFeJGgD+mt7ivvopDpmMUFB0ZUFkc99Zz+stGfkvL4Q=; b=LrTQUxiynikzdpxi
	ycCRtlF0Js8Rn49eJNyAdXuLEOprpuEoU9gFXQ6d6WjqWDhTAbbzXzkaiBdC5i/Z
	lDUrQJGUBcB8TMkt/pFpimrIEXp8tMaPVg+uYZ3kl2YDqr3uE/Ac6iHmcHkuJj7l
	vIuIG9wjeN3NxKmWork24Y0SyZOVhxgyiXMc5c+ytV4BFNPWZdjpmPRMoJuGDQVT
	oA7dmfmlnhYAm4FHGBsxo6X01Ib9FIw/pNiX8DhukSSqZMtaDTWTFdLFxRcLhIJq
	Wm8pBEIpHlY+cZz4IOA6RUBQaoDOyQRjY6kzamDfGtJWUz5UvC+lg8RDX6iV0d9i
	rNx0lA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0w7b85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:27:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52B6RIQi025486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:27:18 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Mar 2025 23:27:16 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v4 03/11] wifi: cfg80211: refactoring nl80211_set_station() for link attributes towards MLO
Date: Tue, 11 Mar 2025 11:56:46 +0530
Message-ID: <20250311062654.1407532-4-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311062654.1407532-1-quic_sarishar@quicinc.com>
References: <20250311062654.1407532-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: NBiTaqh-E0JqLCf9YkpAInyKOY8OvRYR
X-Proofpoint-GUID: NBiTaqh-E0JqLCf9YkpAInyKOY8OvRYR
X-Authority-Analysis: v=2.4 cv=MICamNZl c=1 sm=1 tr=0 ts=67cfd7c7 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=CUx-YjeCQ45KwRfDiH4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110042

Refactor nl80211_send_station() to fill link level NL attributes for
station statistics. This will allow to add support for MLO station
statistics in ease way in subsequent patches.
No functionality changes added.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/wireless/nl80211.c | 107 ++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 45 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2c4e06610a79..a970c473a615 100644
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


