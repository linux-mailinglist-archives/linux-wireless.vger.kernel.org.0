Return-Path: <linux-wireless+bounces-12236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C819A965759
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F641B2161C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 06:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44E353389;
	Fri, 30 Aug 2024 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Llbnh/j7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF871531D8
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998191; cv=none; b=EG9kHStv0Tr7E+v9rXfLFOrwxpgS0KoP0NTNvXHk8ldCdQqCcNxfOQWCyLyrFa8s8k/fjmNalrGQL9Nc34AZF5tiw0bNugGTGE3yjcFoL/7ZsZ2imA3RN6tvlMJb1c+S//f3btCcoZklIGUaL9d2JNavSoEbLC5XAZ2FrKrr0dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998191; c=relaxed/simple;
	bh=+djmKYVBLQfyzQ0EGsIT6trwcG68c0NCjPMEzPoBzRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4nEDtk1LtoSzJRlR60WMZjYiST63dpsNrGTIDWLJYtmmUAjpHEjDJyfChGpjD24FM5Yza6Qguylch5XkOz80KRijRBzXULTYbg2Sc24tQKk7JHiNWeB/cfpvUwtIWLxdd38Yts6tb3B8ACqPUXFgOdxoFjsuVvcQ41WP0IdnbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Llbnh/j7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TI3juv013553;
	Fri, 30 Aug 2024 06:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bhbj81qcqZJFr0TWCrSbJ3TUwqJjUtBJhh1XsP3aM+4=; b=Llbnh/j7rTac7RAi
	BsWhHbfcgB4OqOJNx0uXp9qrsp46JoJ16oqmKh4CuIE0NhfGsfHncWDiz/OW8ZHD
	ESBZG2bDvODyDEkoTaYvfqdPWyONDepbY2TBuJbiyEKvjKqGCgCktKjuK0Qjhqwa
	Fvu+gQBZWkpedlfdlvh65EMqsJYCVjiSXgDz0gq1F07sBBZBK4UZRR2IajssiAuh
	vAlOB6BxU8oM3uaMDPyOTBI4vOk4J98zArcOEFPP6y8h0oG5SWt9QpHzNelqdhOq
	KKqL34tY3ocplKFiGLDxozYQKBN2XIEw9PVpTQ86WLbwyfetjkfnQyZ+sGeaMEdI
	FcDwLw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419px5qgjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 06:09:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U69jHU017400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 06:09:45 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 23:09:44 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v4 6/8] wifi: mac80211: handle DFS per link
Date: Fri, 30 Aug 2024 11:39:16 +0530
Message-ID: <20240830060918.2418701-7-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830060918.2418701-1-quic_adisi@quicinc.com>
References: <20240830060918.2418701-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W5FlijEe_BunntOcEhdYPiSLSr_w2QGt
X-Proofpoint-GUID: W5FlijEe_BunntOcEhdYPiSLSr_w2QGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408300043

In order to support DFS with MLO, handle the link ID now passed from
cfg80211, adjust the code to do everything per link and call the
notifications to cfg80211 correctly.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c  | 26 ++++++++++++++++++--------
 net/mac80211/link.c | 10 ++++++++++
 net/mac80211/util.c | 29 +++++++++++++++++++++++------
 3 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 57539e03d7d7..726cfb1f9061 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3464,6 +3464,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_chan_req chanreq = { .oper = *chandef };
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_link_data *link_data;
 	int err;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -3471,16 +3472,20 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	if (!list_empty(&local->roc_list) || local->scanning)
 		return -EBUSY;
 
+	link_data = sdata_dereference(sdata->link[link_id], sdata);
+	if (!link_data)
+		return -ENOLINK;
+
 	/* whatever, but channel contexts should not complain about that one */
-	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
-	sdata->deflink.needed_rx_chains = local->rx_chains;
+	link_data->smps_mode = IEEE80211_SMPS_OFF;
+	link_data->needed_rx_chains = local->rx_chains;
 
-	err = ieee80211_link_use_channel(&sdata->deflink, &chanreq,
+	err = ieee80211_link_use_channel(link_data, &chanreq,
 					 IEEE80211_CHANCTX_SHARED);
 	if (err)
 		return err;
 
-	wiphy_delayed_work_queue(wiphy, &sdata->deflink.dfs_cac_timer_work,
+	wiphy_delayed_work_queue(wiphy, &link_data->dfs_cac_timer_work,
 				 msecs_to_jiffies(cac_time_ms));
 
 	return 0;
@@ -3491,16 +3496,21 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_link_data *link_data;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
+		link_data = sdata_dereference(sdata->link[link_id], sdata);
+		if (!link_data)
+			continue;
+
 		wiphy_delayed_work_cancel(wiphy,
-					  &sdata->deflink.dfs_cac_timer_work);
+					  &link_data->dfs_cac_timer_work);
 
-		if (sdata->wdev.links[0].cac_started) {
-			ieee80211_link_release_channel(&sdata->deflink);
-			sdata->wdev.links[0].cac_started = false;
+		if (sdata->wdev.links[link_id].cac_started) {
+			ieee80211_link_release_channel(link_data);
+			sdata->wdev.links[link_id].cac_started = false;
 		}
 	}
 }
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index b4378969cbf1..0bbac64d5fa0 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -77,6 +77,16 @@ void ieee80211_link_stop(struct ieee80211_link_data *link)
 			  &link->color_change_finalize_work);
 	wiphy_work_cancel(link->sdata->local->hw.wiphy,
 			  &link->csa.finalize_work);
+
+	if (link->sdata->wdev.links[link->link_id].cac_started) {
+		wiphy_delayed_work_cancel(link->sdata->local->hw.wiphy,
+					  &link->dfs_cac_timer_work);
+		cfg80211_cac_event(link->sdata->dev,
+				   &link->conf->chanreq.oper,
+				   NL80211_RADAR_CAC_ABORTED,
+				   GFP_KERNEL, link->link_id);
+	}
+
 	ieee80211_link_release_channel(link);
 }
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 88ea6246cc48..d29ea35d8142 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3471,20 +3471,37 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct cfg80211_chan_def chandef;
+	struct ieee80211_link_data *link_data;
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
-		wiphy_delayed_work_cancel(local->hw.wiphy,
-					  &sdata->deflink.dfs_cac_timer_work);
+		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+		     link_id++) {
+			link_data = sdata_dereference(sdata->link[link_id],
+						      sdata);
+			if (!link_data)
+				continue;
+
+			wiphy_delayed_work_cancel(local->hw.wiphy,
+						  &link_data->dfs_cac_timer_work);
+
+			if (!sdata->wdev.links[link_id].cac_started)
+				continue;
+
+			link_conf =
+				rcu_dereference(sdata->vif.link_conf[link_id]);
+			if (!link_conf)
+				continue;
 
-		if (sdata->wdev.links[0].cac_started) {
-			chandef = sdata->vif.bss_conf.chanreq.oper;
-			ieee80211_link_release_channel(&sdata->deflink);
+			chandef = link_conf->chanreq.oper;
+			ieee80211_link_release_channel(link_data);
 			cfg80211_cac_event(sdata->dev,
 					   &chandef,
 					   NL80211_RADAR_CAC_ABORTED,
-					   GFP_KERNEL, 0);
+					   GFP_KERNEL, link_id);
 		}
 	}
 }
-- 
2.34.1


