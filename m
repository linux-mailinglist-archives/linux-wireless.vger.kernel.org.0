Return-Path: <linux-wireless+bounces-10173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30A992DEED
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 05:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69E81C20CD3
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 03:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E151D2D02E;
	Thu, 11 Jul 2024 03:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X+P5gyOB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCCC2C861
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669940; cv=none; b=KukhDgi2C92WtH4xD8+C0TBZ/+kKS/ZWNyrvCx9N8eNLO3mhCMuGlmgRq77hOsznGmbQffYoFD1lRMi4uU3aqoTk6IMPC19z+/RIJm4Zm/35DHVs3sHQBymLDxbmLxOXHv/UL3Ysy0vRUH4uST4vmUVE4ztS7gTBQRvn596OM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669940; c=relaxed/simple;
	bh=RCQQFJN+6wGK4gHZjLXCqJv//PsrqAgWSBwlnUtWBZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHrwLCvLTU+8J4H5yAcxFLPnem4vzWHVVLySJalbzngypFsTsgbqZCeA+W0GvKEAWd8ik7b+xHG96RS5Em8Mliu5/U94eKlr9nAMONQzWHpXzqCfQtuHcTK8HTZrgJmvx9BAhFKr7Ww8XY30CBJsKdzBn8afCUaCYa+AcD88DxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X+P5gyOB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B33Xg1005350;
	Thu, 11 Jul 2024 03:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	psiFIdEuaWz0N29uqtIhICtvKVL0Agu/ZxUX5EcRMa0=; b=X+P5gyOBwecrfY9J
	VWH6dY5RusmmksziVeCFtCH3hMAS1Hm1pLb6hcRq3623po3iQvlTzzF0VrtkxjSU
	1zCDbBrBYnovxo1mXu139JnNh/uT8jhE+NxQXGDQnfewbp5Tg2tBk8C0ftrdN5jF
	AD6hzWfRm5giUnCDNpAKdcv8kyy3BPsUs29Uj8q6litvletTuevgM6i32u4VyD89
	/a7fLkAerNLUH444oGqY1j07LMQ+gkkTFrN5jx5BXeikSHSy1X93L5QrMC+WF5b4
	ZGQSM5smAi2eje1d4TIY7i1Pktkkij4VLS7SygHWIIpni9pchXtkHqZO+3cV1sdZ
	qDmxaw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 409kdtjyaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 03:52:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46B3qBM0032593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 03:52:11 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 20:52:10 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v3 1/8] Revert "wifi: mac80211: move radar detect work to sdata"
Date: Thu, 11 Jul 2024 09:21:40 +0530
Message-ID: <20240711035147.1896538-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711035147.1896538-1-quic_adisi@quicinc.com>
References: <20240711035147.1896538-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wZ0sf0JMVsXy2q2l0vEBanzFDNMCk3dg
X-Proofpoint-GUID: wZ0sf0JMVsXy2q2l0vEBanzFDNMCk3dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_20,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110024

This reverts commit ce9e660ef32e ("wifi: mac80211: move radar detect work to sdata").

To enable radar detection with MLO, it’s essential to handle it on a
per-link basis. This is because when using MLO, multiple links may already
be active and beaconing. In this scenario, another link should be able to
initiate a radar detection. Also, if underlying links are associated with
different hardware devices but grouped together for MLO, they could
potentially start radar detection simultaneously. Therefore, it makes
sense to manage radar detection settings separately for each link by moving
them back to a per-link data structure.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c         | 6 +++---
 net/mac80211/ieee80211_i.h | 3 +--
 net/mac80211/iface.c       | 4 +---
 net/mac80211/link.c        | 2 ++
 net/mac80211/mlme.c        | 9 +++++----
 net/mac80211/util.c        | 2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 85cb71de370f..8b4f32c01701 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1664,7 +1664,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	if (sdata->wdev.cac_started) {
 		chandef = link_conf->chanreq.oper;
-		wiphy_delayed_work_cancel(wiphy, &sdata->dfs_cac_timer_work);
+		wiphy_delayed_work_cancel(wiphy, &link->dfs_cac_timer_work);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED,
 				   GFP_KERNEL);
@@ -3482,7 +3482,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	if (err)
 		goto out_unlock;
 
-	wiphy_delayed_work_queue(wiphy, &sdata->dfs_cac_timer_work,
+	wiphy_delayed_work_queue(wiphy, &sdata->deflink.dfs_cac_timer_work,
 				 msecs_to_jiffies(cac_time_ms));
 
  out_unlock:
@@ -3499,7 +3499,7 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		wiphy_delayed_work_cancel(wiphy,
-					  &sdata->dfs_cac_timer_work);
+					  &sdata->deflink.dfs_cac_timer_work);
 
 		if (sdata->wdev.cac_started) {
 			ieee80211_link_release_channel(&sdata->deflink);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a3485e4c6132..a2d7c7ee7ce3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1067,6 +1067,7 @@ struct ieee80211_link_data {
 	int ap_power_level; /* in dBm */
 
 	bool radar_required;
+	struct wiphy_delayed_work dfs_cac_timer_work;
 
 	union {
 		struct ieee80211_link_data_managed mgd;
@@ -1165,8 +1166,6 @@ struct ieee80211_sub_if_data {
 	struct ieee80211_link_data deflink;
 	struct ieee80211_link_data __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
-	struct wiphy_delayed_work dfs_cac_timer_work;
-
 	/* for ieee80211_set_active_links_async() */
 	struct wiphy_work activate_links_work;
 	u16 desired_active_links;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b4ad66af3af3..7bb71ac52277 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -550,7 +550,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	wiphy_work_cancel(local->hw.wiphy,
 			  &sdata->deflink.color_change_finalize_work);
 	wiphy_delayed_work_cancel(local->hw.wiphy,
-				  &sdata->dfs_cac_timer_work);
+				  &sdata->deflink.dfs_cac_timer_work);
 
 	if (sdata->wdev.cac_started) {
 		chandef = sdata->vif.bss_conf.chanreq.oper;
@@ -1729,8 +1729,6 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	wiphy_work_init(&sdata->work, ieee80211_iface_work);
 	wiphy_work_init(&sdata->activate_links_work,
 			ieee80211_activate_links_work);
-	wiphy_delayed_work_init(&sdata->dfs_cac_timer_work,
-				ieee80211_dfs_cac_timer_work);
 
 	switch (type) {
 	case NL80211_IFTYPE_P2P_GO:
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 1a211b8d4057..b4378969cbf1 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -45,6 +45,8 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 			  ieee80211_color_collision_detection_work);
 	INIT_LIST_HEAD(&link->assigned_chanctx_list);
 	INIT_LIST_HEAD(&link->reserved_chanctx_list);
+	wiphy_delayed_work_init(&link->dfs_cac_timer_work,
+				ieee80211_dfs_cac_timer_work);
 
 	if (!deflink) {
 		switch (sdata->vif.type) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4779a18ab75d..5b83e7b5d664 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3031,15 +3031,16 @@ void ieee80211_dynamic_ps_timer(struct timer_list *t)
 
 void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
-	struct ieee80211_sub_if_data *sdata =
-		container_of(work, struct ieee80211_sub_if_data,
+	struct ieee80211_link_data *link =
+		container_of(work, struct ieee80211_link_data,
 			     dfs_cac_timer_work.work);
-	struct cfg80211_chan_def chandef = sdata->vif.bss_conf.chanreq.oper;
+	struct cfg80211_chan_def chandef = link->conf->chanreq.oper;
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (sdata->wdev.cac_started) {
-		ieee80211_link_release_channel(&sdata->deflink);
+		ieee80211_link_release_channel(link);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_FINISHED,
 				   GFP_KERNEL);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ced19ce7c51a..77d1e44279d0 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3460,7 +3460,7 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		wiphy_delayed_work_cancel(local->hw.wiphy,
-					  &sdata->dfs_cac_timer_work);
+					  &sdata->deflink.dfs_cac_timer_work);
 
 		if (sdata->wdev.cac_started) {
 			chandef = sdata->vif.bss_conf.chanreq.oper;
-- 
2.34.1


