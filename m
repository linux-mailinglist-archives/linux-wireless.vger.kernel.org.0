Return-Path: <linux-wireless+bounces-9229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005BE90E23A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 06:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC602856F7
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 04:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B91D57CB4;
	Wed, 19 Jun 2024 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bIGCmsrf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29B558B6
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770246; cv=none; b=cZmNBH1wwAryXF9wUlzgq4aNuGBvd2sYzt62WO+g9MGbae0Oy5q58+6Ggvyv6xu14gp/9Zc1vzzKD6+WawN/eLSPbdWPIY4mn1sx5K86ZglRnYUyeIB4XAz6XxdwZkuYCppPYKk9oeV2qVnWjH44D2ozhjd2j1MrnXehgNTsm0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770246; c=relaxed/simple;
	bh=402vBh7JvSmcBHcYIk6PdUqQZz5sG0w+0mAhyByM+38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPe0+NUK5QwflpDDMgEbhwayfW1ozOBH6i3o1clE7dPyDY4iiglqc2JDe4AdkLtNl5MPyb5VDRDFisGaB7yip2nnscbxsagLaePVPJz46B7mSSqCLfmVU47yV2GimqhSkgGUtf1o/Sgc2wXkwqBslzBrvyyGwOPFxKsrQS/Y7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bIGCmsrf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILa58h009248;
	Wed, 19 Jun 2024 04:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bz7256KgkfBIx3/pS2xL6J9YBpclKvvKAfFeXpCEeD4=; b=bIGCmsrfH6rF3nkq
	4EsbjBQkIGHCNf3Wcra7cFhvxWSbjfvifrD6mF/YkskI2dqDdLAPLKEhdgmQByAC
	gHNxavJT0dcwrvDqFkP3i0a21wIfxsm2AYbHPys7YW9MVX9odA+t1GugX4LMYVX/
	5tQcP5IjrgnkCc876/Xd2T7bWgw9c4OYKfslgP2WoQj9EPHE8m3E75nMlt9kkM0S
	movks9ZrPHj1hdAAp46JjuwfZ06r2Izfv9IJps/scswEdNhgu0+H1qHi2R1ZZeXL
	zj2+N71wIyB7NLI5jW2z1pVVaCLmghutECD+7upMe3w6KQ0/WAiivpfiK6q0PTmZ
	iG8iJw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9tgkkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J4AdXw013216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:39 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 21:10:38 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 7/9] wifi: mac80211: handle DFS on per link
Date: Wed, 19 Jun 2024 09:39:57 +0530
Message-ID: <20240619040959.1457547-8-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619040959.1457547-1-quic_adisi@quicinc.com>
References: <20240619040959.1457547-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iUilT3Tdbskmh0m543zoAAeYU4F79xj6
X-Proofpoint-ORIG-GUID: iUilT3Tdbskmh0m543zoAAeYU4F79xj6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_01,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406190029

In order to support DFS with MLO, handle the link ID now passed from
cfg80211, adjust the code to do everything per link and call the
notifications to cfg80211 correctly.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c  | 28 ++++++++++++++++++++--------
 net/mac80211/util.c | 29 +++++++++++++++++++++++------
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b2cd43d807ed..091508481f43 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3471,6 +3471,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_chan_req chanreq = { .oper = *chandef };
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_link_data *link_data;
 	int err;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -3480,16 +3481,22 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 		goto return_err;
 	}
 
+	link_data = sdata_dereference(sdata->link[link_id], sdata);
+	if (!link_data) {
+		err = -ENOLINK;
+		goto return_err;
+	}
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
 		goto return_err;
 
-	wiphy_delayed_work_queue(wiphy, &sdata->deflink.dfs_cac_timer_work,
+	wiphy_delayed_work_queue(wiphy, &link_data->dfs_cac_timer_work,
 				 msecs_to_jiffies(cac_time_ms));
 
  return_err:
@@ -3501,16 +3508,21 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
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
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1dfb61082a9c..3d34e07f441b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3453,20 +3453,37 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
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


