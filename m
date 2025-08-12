Return-Path: <linux-wireless+bounces-26311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6067EB22611
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 13:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6399E1B60C12
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 11:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5C92E62D8;
	Tue, 12 Aug 2025 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hRSSwSlX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716322ED151
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998879; cv=none; b=S7gYiRIvyfR+14FcWfmU47DFMqr0CVYBOzTAer1ATiaI40KK0gI4MlmKSGgRXf04FMqmgVFxPEjgO/4M5KZ7MwdDfRk+PMjxguZVsq9Ul8euMOv6LqtapSznvMATPsnrG4zZAoMjKpgx/qpqWg0llwlFRW8nLCUPg3RQkJuurI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998879; c=relaxed/simple;
	bh=GCso3pqq3zrrKfcNN+SSYGpEKj7ywFLklsdvRtQQqMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MFMAB/EuQm36Ry//SavrH9noWMJlLjp5j33IVqGM+TKgq5Fcd48GuoeE6ZMD5yn6S7wwAR5YZL6YfnF4x1uUrCzXa9FKPXEbAboG6VLv/1Tf//cdpod40rEHwp+gfCsJ8+hKkLy4rIG/d3tuKbaFlW5ZHNjb9SWijmkaGkDpci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hRSSwSlX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAwc0u025457
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=cs/dwyw6qzCwVJz91wOUo7oS60QQjbxCXsQ4ClhBFR0=; b=hR
	SSwSlXLQbOJwTjdRkAWPiPdPeSmAG+BtDWIMPsuoTeoEYnGW7prO/JdFUc0xL/+G
	sCqkkU0Qwxz5dE/3pr0vHPoRenWYa6FuzU+d3XHlyKQ8ze4eFBthCi4+8vtpHULj
	pivgvzNnrqI4zuo+AKhoC2ELWf7HY4uCGMP/30L0rBpzUws8Afg7lt/RTZwjqaTj
	EiHXclOplYH3gPv6CxReDtKIAA1uWr8QPM4yMuf+sTFzvxBTPCtwTBn9BV8U0FG0
	UxZLMyZgGBfF4MH+CRrbixF6RoVdHhdxOBxqmeMM1z1zR92Vy7JrwQveyOKZU/Wa
	J/jzZeP03K7gvSnvCnUA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sr591-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:41:16 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76bb326ad0bso5446185b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 04:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754998875; x=1755603675;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cs/dwyw6qzCwVJz91wOUo7oS60QQjbxCXsQ4ClhBFR0=;
        b=awdAcgmWSqeymo4u5VOJYiaSZgpEqR+/zrvRBq2QTz+ynwynC0arYCyYxi58GlulJ5
         HsL1nf1u7oJ3R5OxdTEwbry/np1qc/MpDMDbOW6PHtWr1/xjsNHg1zUF9NCt2MBMQxkl
         7EL7lQwpWClCoCG6hXAuBNwHG00tq8KBHrno7PC7fB++Ey/V/9ZMPdbxHVMyJhc7kWX8
         +E5NBhgmUUF+ZUbKus1VMtb3zeXFdBjML72WOFlquY4nKKDpBA5WfZN5yb0U2HxqAGsr
         oBFE99FZiPzkziGdPOARuJH8Pobp9kDI+h2NdQua/yeNSelVjcHzBhnddsq2u9Mq8gch
         jqWA==
X-Gm-Message-State: AOJu0YwQg/xShdo6TFSuPmvOuoMWcnB2yZkgapZXo9WfGJ1rvQwca8mQ
	LS7AjUymeR6gI9o85y9MH83XcB/3fZaa1f2/VLu4rSuOq8tvD6jQ98r/N/8VgOTHg4JhUBxtRLK
	7Vl2YVrt5ZrJevxlfpRm0CVUuXG+6j/4CK44REXpUo2KG24bDjbCVZac30iV7f+4zmLJzOXjiBB
	3xHQ==
X-Gm-Gg: ASbGncvrn2NgbUo6ahQizG0ONxp/du37C+KgD9t2U2vs8FFEWq20oP+B1pYGzJemdkv
	n3GykhXWORTOwU4XUm9lu4eT4+8tGH9I0IcXIfEAdFbhkbjvs29/tuvd6qhArFrraY4Owdp9KIY
	yGHyPSZBIIv5CclHpBlR5MSiNbyMVspBh0nsrpsm+oiECP/S0O+dGi0AeTXTwqKHOOl4mYKjNA1
	k0ieS/xhvrWyBY5LUa9qe86wI2fJZh0/+cGzwNY+s/U+iYJ+tBrBI3o5hCeCFX12iUg20mrUoMg
	64UXdXP5JoTbwKFMPUYucDBcRnR8FLmhnLLT6BMBeOSJIcNHaQ5r9dDB3+xxeshlg2ZGtkkwHqp
	egVV0IE4=
X-Received: by 2002:a05:6a00:1787:b0:758:b81:603a with SMTP id d2e1a72fcca58-76e0ddf1665mr4279739b3a.2.1754998875340;
        Tue, 12 Aug 2025 04:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjDcNcnIN23BJzDZkPZk27ZBxGpIIZ+hh9YxxpoM+WOrk8dLxBhCEkAr/5RCcdH+xc7cHUoA==
X-Received: by 2002:a05:6a00:1787:b0:758:b81:603a with SMTP id d2e1a72fcca58-76e0ddf1665mr4279695b3a.2.1754998874844;
        Tue, 12 Aug 2025 04:41:14 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccead450sm29344061b3a.54.2025.08.12.04.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:41:14 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 2/2] wifi: mac80211: track and report beacon Rx time in station info
Date: Tue, 12 Aug 2025 17:10:29 +0530
Message-Id: <20250812114029.23538-3-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250812114029.23538-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250812114029.23538-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689b285c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Gvc6HY19cE1ofl3R-qoA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 9x6tXqDKuiJeoqmy-JoC3mYA8iV4RYsU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX8FVgKwaCuHfM
 95bjSJe8YC/rnM3ootRAkRSQ4ZTck/iB30LW90UsZpulyLMgK9B0V3h7Pf9UI5CiS3yT7vjTKCY
 QOoLTPjyMqB4iLVyP8VQ7qktibHn/Pj5l35VJJBCR10T0iQVHVlrM0i/pYR655uVfP3N868FFiU
 Ght+pUU2JOFwAVcv8P+Y842KAtydwjdOU0VmGdxgJQ65jRXCO9kY9V3T2k4R0/cu8gyMdQI3Nb1
 lrs1hYNAAs6AXzNE4cbaJR40/QzVdHoojiYBrZih6vzGLZV7d7BAYmtN7oTT93mV/WtDVKtgu0m
 UqQYWw9icbmvxksar1im/+m7NeCGD505c1bn+PnlVUEhozOVJUp50nqd0tSSJbnhYKPkF4pAdKc
 f/8YXpCZ
X-Proofpoint-GUID: 9x6tXqDKuiJeoqmy-JoC3mYA8iV4RYsU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Report the time since the last beacon was received from a peer station in
station info using the NL attribute NL80211_STA_INFO_BEACON_SEEN_MSEC_AGO.
This applies to non-AP STA, mesh and adhoc modes.

In non-AP MLD STA mode, this attribute is reported per link and
additionally, it is reported at the MLD level, the timestamp of the most
recently received beacon across all affiliated AP STA links to give a
unified view of beacon reception status.

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 net/mac80211/mesh.c       |  4 ++++
 net/mac80211/mesh.h       |  4 ++++
 net/mac80211/mesh_plink.c | 18 ++++++++++++++++++
 net/mac80211/mlme.c       |  2 ++
 net/mac80211/sta_info.c   | 31 ++++++++++++++++++++++++++++++-
 net/mac80211/sta_info.h   |  3 +++
 6 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index a4a715f6f1c3..a6b83633ec33 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1508,6 +1508,10 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 		if (ifmsh->csa_role != IEEE80211_MESH_CSA_ROLE_INIT &&
 		    !sdata->vif.bss_conf.csa_active)
 			ieee80211_mesh_process_chnswitch(sdata, elems, true);
+
+		if (stype == IEEE80211_STYPE_BEACON)
+			mesh_last_beacon_seen_msec_ago(sdata, mgmt, elems,
+						       rx_status);
 	}
 
 	if (ifmsh->sync_ops)
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index 3f9664e4e00c..3e13834a5804 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -327,6 +327,10 @@ int mesh_path_send_to_gates(struct mesh_path *mpath);
 int mesh_gate_num(struct ieee80211_sub_if_data *sdata);
 u32 airtime_link_metric_get(struct ieee80211_local *local,
 			    struct sta_info *sta);
+void mesh_last_beacon_seen_msec_ago(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_mgmt *mgmt,
+				    struct ieee802_11_elems *ie,
+				    struct ieee80211_rx_status *rx_status);
 
 /* Mesh plinks */
 void mesh_neighbour_update(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index cb45a5d2009d..d84a49372d20 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -613,6 +613,24 @@ mesh_sta_info_get(struct ieee80211_sub_if_data *sdata,
 	return sta;
 }
 
+void mesh_last_beacon_seen_msec_ago(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_mgmt *mgmt,
+				    struct ieee802_11_elems *elems,
+				    struct ieee80211_rx_status *rx_status)
+{
+	struct sta_info *sta;
+
+	/* mesh_sta_info_get api returns with rcu_read_lock */
+	sta = mesh_sta_info_get(sdata, mgmt->sa, elems, rx_status);
+	if (!sta)
+		goto unlock_rcu;
+
+	sta->deflink.last_beacon_seen_msec_ago = jiffies;
+
+unlock_rcu:
+	rcu_read_unlock();
+}
+
 /*
  * mesh_neighbour_update - update or initialize new mesh neighbor.
  *
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1008eb8e9b13..5194c0f4f887 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7567,6 +7567,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		goto free;
 	}
 
+	link_sta->last_beacon_seen_msec_ago = jiffies;
+
 	if (WARN_ON(!bss_conf->chanreq.oper.chan))
 		goto free;
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 8c550aab9bdc..aa3501ec2096 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2954,6 +2954,15 @@ static void sta_set_link_sinfo(struct sta_info *sta,
 		link_sinfo->filled |=
 			BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
 	}
+
+	if (!(link_sinfo->filled &
+	      BIT_ULL(NL80211_STA_INFO_BEACON_SEEN_MSEC_AGO))) {
+		link_sinfo->last_beacon_seen_msec_ago =
+			jiffies_to_msecs(jiffies -
+					 link_sta_info->last_beacon_seen_msec_ago);
+		link_sinfo->filled |=
+			BIT_ULL(NL80211_STA_INFO_BEACON_SEEN_MSEC_AGO);
+	}
 }
 
 void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
@@ -2961,7 +2970,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
-	u32 thr = 0;
+	u32 thr = 0, last_beacon_seen_msec_ago = 0;
 	int i, ac, cpu, link_id;
 	struct ieee80211_sta_rx_stats *last_rxstats;
 
@@ -3204,6 +3213,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (sta->sta.valid_links) {
 		struct ieee80211_link_data *link;
 		struct link_sta_info *link_sta;
+		bool init = false;
 
 		ether_addr_copy(sinfo->mld_addr, sta->addr);
 		for_each_valid_link(sinfo, link_id) {
@@ -3218,7 +3228,26 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			sinfo->valid_links = sta->sta.valid_links;
 			sta_set_link_sinfo(sta, sinfo->links[link_id],
 					   link, tidstats);
+			if (!init ||
+			    link_sta->last_beacon_seen_msec_ago >
+			     last_beacon_seen_msec_ago)
+				last_beacon_seen_msec_ago =
+					link_sta->last_beacon_seen_msec_ago;
+			init = true;
 		}
+	} else {
+		last_beacon_seen_msec_ago =
+			sta->deflink.last_beacon_seen_msec_ago;
+	}
+
+	if (!(sinfo->filled &
+	      BIT_ULL(NL80211_STA_INFO_BEACON_SEEN_MSEC_AGO)) &&
+	    last_beacon_seen_msec_ago) {
+		sinfo->last_beacon_seen_msec_ago =
+			jiffies_to_msecs(jiffies -
+					 last_beacon_seen_msec_ago);
+		sinfo->filled |=
+			BIT_ULL(NL80211_STA_INFO_BEACON_SEEN_MSEC_AGO);
 	}
 }
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 5288d5286651..a4f976d58a93 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -510,6 +510,7 @@ struct ieee80211_fragment_cache {
  *	during finalize
  * @debugfs_dir: debug filesystem directory dentry
  * @pub: public (driver visible) link STA data
+ * @last_beacon_seen_msec_ago: timestamp of last received beacon in jiffies
  * TODO Move other link params from sta_info as required for MLD operation
  */
 struct link_sta_info {
@@ -565,6 +566,8 @@ struct link_sta_info {
 	struct dentry *debugfs_dir;
 #endif
 
+	unsigned long last_beacon_seen_msec_ago;
+
 	struct ieee80211_link_sta *pub;
 };
 
-- 
2.17.1


