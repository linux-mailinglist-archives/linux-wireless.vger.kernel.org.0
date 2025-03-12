Return-Path: <linux-wireless+bounces-20205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA92A5D698
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 07:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4419189C703
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 06:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E475715853B;
	Wed, 12 Mar 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DhJO2lue"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F51DE4C2
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762324; cv=none; b=fc5cRfDO6ue5d7V0rkTqfjB+1fFWaN/J/GDLTNVOK6+VIGnl1dsLKl46gaRukNSA5mDtwLJ+19JMWtwTvlQsiyPU132Bo/czJYYLApZPcIrWgmJVGQ3y/DU9acHZs9EcU1k6dUTXBJIRLnggQ69wosLghKmtPZhnl7X0NYmTxk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762324; c=relaxed/simple;
	bh=J4eHvcY0AovlamBCYEUQ3tjEz/Xsi/gSgLED+zUKvQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdKGYspDasNLjJsCLlBo3yfP9zd7gTkc08xD53IKAQN2ie9Pz4XTadvVf9iAAkmhYyqwcG8s3Uzb24ZtSzBnF8m+JkVIOIRpvxDD/Klj5ANYsXMc185iY3XofrJczPeqF1O2ATQkH5BVGTHqTCDcyQdsPpXLmMmd0ZGj6iGfNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DhJO2lue; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BMHlfp028128;
	Wed, 12 Mar 2025 06:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vcIdGOWIcZx8sX3bC0S4nWutNhzh9jfyVrs0FGeZCMk=; b=DhJO2luezHjhZFK3
	UyTv2/nrRuqlozsbzDBQ3YtqnE8qv3PPUeqFU9lQeB6KFUrUcTim+PS2aBdY8M6a
	Ot0xEzUJe5qJVkVhaWdwjIHYyVz7xFo2WIVBX26+BhIDNHvG09h5PvGFiTRXE0Vu
	XvipWUMO/11LjB6XCMace7ze/7cvJfLvS4TxEBZqEfImJsbuqm8d7bu9j2XxbwyF
	J939q5dUmKXLhsx6I98fsW3X4KAWElsyC4KZ6mVarUODoss9O243P8iESS67uoju
	7aTPwdnIMtMviln5ungy7Ze+Ny3Cp2H9VT7YvA+Qn6hJQPa5pqQJrqS6v3hFGR8F
	PkGB0Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2pscy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 06:51:56 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52C6punw010472
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 06:51:56 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Mar 2025 23:51:54 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v5 03/11] wifi: cfg80211: refactoring nl80211_set_station() for link attributes towards MLO
Date: Wed, 12 Mar 2025 12:21:24 +0530
Message-ID: <20250312065132.3397726-4-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312065132.3397726-1-quic_sarishar@quicinc.com>
References: <20250312065132.3397726-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d12f0c cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=C1NAgCs-1SU8PvDiwQIA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mH8QKgvePrzRsA-QiZNOHdOo-GLVvq-W
X-Proofpoint-ORIG-GUID: mH8QKgvePrzRsA-QiZNOHdOo-GLVvq-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120044

Refactor nl80211_send_station() to fill link level NL attributes for
station statistics. This will allow to add support for MLO station
statistics in ease way in subsequent patches.
No functionality changes added.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/wireless/nl80211.c | 107 ++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 45 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index aee49d43cf86..8199bb00f65c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6699,30 +6699,6 @@ static bool nl80211_put_signal(struct sk_buff *msg, u8 mask, s8 *signal,
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
@@ -6737,9 +6713,13 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
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
@@ -6800,17 +6780,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
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
@@ -6831,11 +6800,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 
 		nla_nest_end(msg, bss_param);
 	}
-	if ((sinfo->filled & BIT_ULL(NL80211_STA_INFO_STA_FLAGS)) &&
-	    nla_put(msg, NL80211_STA_INFO_STA_FLAGS,
-		    sizeof(struct nl80211_sta_flag_update),
-		    &sinfo->sta_flags))
-		goto nla_put_failure;
 
 	PUT_SINFO_U64(RX_DROP_MISC, rx_dropped_misc);
 	PUT_SINFO_U64(BEACON_RX, rx_beacon);
@@ -6848,9 +6812,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		PUT_SINFO(ACK_SIGNAL_AVG, avg_ack_signal, s8);
 	}
 
-#undef PUT_SINFO
-#undef PUT_SINFO_U64
-
 	if (sinfo->pertid) {
 		struct nlattr *tidsattr;
 		int tid;
@@ -6898,6 +6859,59 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
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
@@ -6931,6 +6945,9 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
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


