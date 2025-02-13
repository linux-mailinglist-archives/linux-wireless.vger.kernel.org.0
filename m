Return-Path: <linux-wireless+bounces-18927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A05A34B8B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E9C165E9C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDC8202F61;
	Thu, 13 Feb 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kE7cEv6t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C42045A8
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467044; cv=none; b=qoM0Ikp2mjtrtxzrS8zMQU/NAEUXHrRwLdlXXmGesXjJQCKi50pPviOtQ4W+ItCjnc72L23eVOsS9fMjtAG9Jn2zA+gZeSvqGmskEJJDxbNLE2Z3Tjmt+nluWjkG3LZLqZi88RrtZwU6RvA2qPq+Rsm+cFW9k4Zav+m4afq30Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467044; c=relaxed/simple;
	bh=EXCYWTLcjmGn1pi2ZxE7N0yoL7gufCW91oMg6n62l5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+cf16AgenIxkXrRsdBEPfnTFHLM305lsfMCoH372yxhDWaGb5bpLHeJs4QFXNuvx8YqW1aB5CBQOP8dVtELS6aaBTpRDOOeQk7rJ7ahlGsbJxHQYhr2cOMdCDL5rlnkN4kqLPf4KeZodtMt0n1k6tSfIqAk7fU9QGES+QEDGZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kE7cEv6t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGaipt008261;
	Thu, 13 Feb 2025 17:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iyZl1CCW6MBuRB9RzInk2+F/XyOp3HAc8X9WheGslyM=; b=kE7cEv6t5eQPNEet
	9WasKu1nLt4HKSNswchv2xAKLpORjRImLYW1gjkV1qwBjUxiLbg3RQa5e8wstKUz
	YLr6FBM7+w3XE5+nBgZ6ea/YQ+900m3cMlkvgZT/nGHhrIwH9QeaKYml0tzlY6s/
	N4F4kK1fuqiD+hbC7ABUgr8brGTLT1tfee4M8CCa7xox40kwRm8yy1JBfOV6qoGo
	vpt3KzjMScUNBT/WF9LHzzv8Fv0uYhzMB9TlGFIn8GxPs0FjoxNqfosaD/rZEDcZ
	kBVF7CqbX4N0SGZKKrjssLgaSA9J0HZ6/v0wddSU0gl8Glv3zv6+xzqc68eQNV8d
	m6CdOA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qewhbm88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DHHHJr004899
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:17 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Feb 2025 09:17:16 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH v3 02/12] wifi: mac80211: add API to populated mesh related fields in sinfo
Date: Thu, 13 Feb 2025 22:46:22 +0530
Message-ID: <20250213171632.1646538-3-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: HU6binvb6vsMF-BMeNRWU8uZw3NoKVzY
X-Proofpoint-GUID: HU6binvb6vsMF-BMeNRWU8uZw3NoKVzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130123

Introduce the sta_set_mesh_sinfo() API to populate mesh related
fields in sinfo structure for station statistics.
This will allow for the simplified population of other fields in the
sinfo structure for link level in a subsequent patch to add support
for MLO station statistics.
No functionality changes added.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/mac80211/sta_info.c | 64 ++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f83268fa9f92..a4b4506cd35b 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2584,6 +2584,39 @@ static inline u64 sta_get_stats_bytes(struct ieee80211_sta_rx_stats *rxstats)
 	return value;
 }
 
+#ifdef CONFIG_MAC80211_MESH
+static void sta_set_mesh_sinfo(struct sta_info *sta,
+			       struct station_info *sinfo)
+{
+	struct ieee80211_local *local = sta->sdata->local;
+
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_LLID) |
+			 BIT_ULL(NL80211_STA_INFO_PLID) |
+			 BIT_ULL(NL80211_STA_INFO_PLINK_STATE) |
+			 BIT_ULL(NL80211_STA_INFO_LOCAL_PM) |
+			 BIT_ULL(NL80211_STA_INFO_PEER_PM) |
+			 BIT_ULL(NL80211_STA_INFO_NONPEER_PM) |
+			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TO_GATE) |
+			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TO_AS);
+
+	sinfo->llid = sta->mesh->llid;
+	sinfo->plid = sta->mesh->plid;
+	sinfo->plink_state = sta->mesh->plink_state;
+	if (test_sta_flag(sta, WLAN_STA_TOFFSET_KNOWN)) {
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_T_OFFSET);
+		sinfo->t_offset = sta->mesh->t_offset;
+	}
+	sinfo->local_pm = sta->mesh->local_pm;
+	sinfo->peer_pm = sta->mesh->peer_pm;
+	sinfo->nonpeer_pm = sta->mesh->nonpeer_pm;
+	sinfo->connected_to_gate = sta->mesh->connected_to_gate;
+	sinfo->connected_to_as = sta->mesh->connected_to_as;
+
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_AIRTIME_LINK_METRIC);
+	sinfo->airtime_link_metric = airtime_link_metric_get(local, sta);
+}
+#endif
+
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		   bool tidstats)
 {
@@ -2768,31 +2801,10 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			sta_set_tidstats(sta, &sinfo->pertid[i], i);
 	}
 
-	if (ieee80211_vif_is_mesh(&sdata->vif)) {
 #ifdef CONFIG_MAC80211_MESH
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_LLID) |
-				 BIT_ULL(NL80211_STA_INFO_PLID) |
-				 BIT_ULL(NL80211_STA_INFO_PLINK_STATE) |
-				 BIT_ULL(NL80211_STA_INFO_LOCAL_PM) |
-				 BIT_ULL(NL80211_STA_INFO_PEER_PM) |
-				 BIT_ULL(NL80211_STA_INFO_NONPEER_PM) |
-				 BIT_ULL(NL80211_STA_INFO_CONNECTED_TO_GATE) |
-				 BIT_ULL(NL80211_STA_INFO_CONNECTED_TO_AS);
-
-		sinfo->llid = sta->mesh->llid;
-		sinfo->plid = sta->mesh->plid;
-		sinfo->plink_state = sta->mesh->plink_state;
-		if (test_sta_flag(sta, WLAN_STA_TOFFSET_KNOWN)) {
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_T_OFFSET);
-			sinfo->t_offset = sta->mesh->t_offset;
-		}
-		sinfo->local_pm = sta->mesh->local_pm;
-		sinfo->peer_pm = sta->mesh->peer_pm;
-		sinfo->nonpeer_pm = sta->mesh->nonpeer_pm;
-		sinfo->connected_to_gate = sta->mesh->connected_to_gate;
-		sinfo->connected_to_as = sta->mesh->connected_to_as;
+	if (ieee80211_vif_is_mesh(&sdata->vif))
+		sta_set_mesh_sinfo(sta, sinfo);
 #endif
-	}
 
 	sinfo->bss_param.flags = 0;
 	if (sdata->vif.bss_conf.use_cts_prot)
@@ -2848,12 +2860,6 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->filled |=
 			BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
 	}
-
-	if (ieee80211_vif_is_mesh(&sdata->vif)) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_AIRTIME_LINK_METRIC);
-		sinfo->airtime_link_metric =
-			airtime_link_metric_get(local, sta);
-	}
 }
 
 u32 sta_get_expected_throughput(struct sta_info *sta)
-- 
2.34.1


