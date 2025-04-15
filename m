Return-Path: <linux-wireless+bounces-21527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D57A892C5
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 06:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968631890F08
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 04:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E66219313;
	Tue, 15 Apr 2025 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IWdCJt3T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2594214B945
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744690873; cv=none; b=A/dkFXipkIBxKa67/8D7zqvV488MLAxOEB/Z5TRRXDrqm1L8M6aSE8VxjqcRsSZzG6YFa9+t5OXKBILmRHs7FUmmPPPsN2WoJ+cfxDfJDXZGqFAwA7SyS/8hXd1lkdAakSe1BWGIO/+MTe12gbYABIM7JL7qBUSRKnzvHUB8MsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744690873; c=relaxed/simple;
	bh=of3YAlLpoFKsq4X00MiKEX8sTCXI7XpiBziywe0gGow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgNp5x8J+cQZ/cXpOYfDVIU3Zj/faR3brq+pYXWon6Xg0SICPVgIiZ7hk8bw9s5nSpeTHNceXqWE6Q7zZC4LuyE9jMD613zQmvRmzVv1D3/+gf+D4z6cgoDWmitPR7XIE2wjcKzUHc9O0vMLdSvAo3pN7p5sulR+2PEiphcRKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IWdCJt3T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F15LJR022187;
	Tue, 15 Apr 2025 04:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7EQi0wOZll2ssjhrMEexLRXaUiaq6e0O/OmvtWC6UsU=; b=IWdCJt3TyX4c+heC
	XhoAn8yHZOCi/yX9YMcI9cJIJxvOSaEgX+OVqdbK+RdYkTjQvc1xujyx7CvQPGSd
	xI5jtSjGSvW1UsW6CZHxv2LiW8Ptztm3I2/yUWdyos5/USEuOUMpj80MWTz+PDib
	unMD/w6jWd0a3Yqq7vbD55y3W12OhmoS9WEueozJ8pa8SGvWu2PXG47n948YXYcV
	CLI0N1/IQJJplWd43W3ktZjcTsa2JdJAI6h2dgrfqDHJJ+BeyGRFd9Zk58I28qZ1
	kpI1O9i00Ti+us11yHPCYXqbk4NajnBBjAs9F8qp3FmX57zfKBHol8LwttkdOKaI
	mlGVMw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf4veq4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:06 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F4L5E3018868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:05 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Apr 2025 21:21:03 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v6 03/11] wifi: cfg80211: refactoring nl80211_set_station() for link attributes towards MLO
Date: Tue, 15 Apr 2025 09:50:22 +0530
Message-ID: <20250415042030.1246187-4-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: DgOVDAxoZH-KWbpFUEQfKDaL-6hiOcFS
X-Authority-Analysis: v=2.4 cv=IZ6HWXqa c=1 sm=1 tr=0 ts=67fddeb2 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=C1NAgCs-1SU8PvDiwQIA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DgOVDAxoZH-KWbpFUEQfKDaL-6hiOcFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150026

Refactor nl80211_send_station() to fill link level NL attributes for
station statistics. This will allow to add support for MLO station
statistics in ease way in subsequent patches.
No functionality changes added.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/wireless/nl80211.c | 107 ++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 45 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f039a7d0d6f7..415eca6a9f8f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6705,30 +6705,6 @@ static bool nl80211_put_signal(struct sk_buff *msg, u8 mask, s8 *signal,
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
@@ -6743,9 +6719,13 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
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
@@ -6806,17 +6786,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
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
@@ -6837,11 +6806,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 
 		nla_nest_end(msg, bss_param);
 	}
-	if ((sinfo->filled & BIT_ULL(NL80211_STA_INFO_STA_FLAGS)) &&
-	    nla_put(msg, NL80211_STA_INFO_STA_FLAGS,
-		    sizeof(struct nl80211_sta_flag_update),
-		    &sinfo->sta_flags))
-		goto nla_put_failure;
 
 	PUT_SINFO_U64(RX_DROP_MISC, rx_dropped_misc);
 	PUT_SINFO_U64(BEACON_RX, rx_beacon);
@@ -6854,9 +6818,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		PUT_SINFO(ACK_SIGNAL_AVG, avg_ack_signal, s8);
 	}
 
-#undef PUT_SINFO
-#undef PUT_SINFO_U64
-
 	if (sinfo->pertid) {
 		struct nlattr *tidsattr;
 		int tid;
@@ -6904,6 +6865,59 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
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
@@ -6937,6 +6951,9 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
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


