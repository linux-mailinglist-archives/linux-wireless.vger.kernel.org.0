Return-Path: <linux-wireless+bounces-12238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A667496575A
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360B91F24FE6
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 06:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041391514ED;
	Fri, 30 Aug 2024 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AbkMVVGX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4495D15099A
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998196; cv=none; b=U41Wpr6tFO03qIi7DnQkZ4TyuZ6XYM/WXXQUsAkRxDOPu3g3bpNFOLNv06eyD/TvCWq/l6a9LtDgPQsrE1HNTMXzoZRlZF+u9LjhiPsfqtZPKX1MtEZCTKyWsjwf5iQ/lpZEoz7OnJwqQC3ahbvoXuN9JlokezqrjcAlEIw17Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998196; c=relaxed/simple;
	bh=0HFkuvQ+cmPxKSYGsAcCh0Z9+8i0CcQHHuPnFM97gbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auHCiw8senbohxpJKtNH4HvXjpiPjxPo1iImlN/e59IDcg3iKQSMUMSGldjPAQvYr0FdKrR5zQU64H/xJJoDLun7ULmAIWezvH674h2yQdlEzCo0yDltdb34USz+13KcCagKl6Cjh0BP5rAeBVPQcG780TJUypNVEdHQ+pb9mdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AbkMVVGX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TGoaNO009937;
	Fri, 30 Aug 2024 06:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a0I9QA3p+mnWgFyo/It4y4GzYMY4DrUIi3XfAv2PmUc=; b=AbkMVVGXMBpo5/cT
	sTdKpVi9fW8r0lCG8xPB02syJ9iVp5z/wYIAgwhXBQ4Tf8N0b0FHDN6ars+WcSkc
	bsdMxNLhUr9YcwtwJh8m3IHDcA+ynhzS5ukVhDP83dkXA6XPkK8qLOiVdNMBKqIa
	IkfVxAHaI5hzo7wQWOO1gSluSKLhEAiw84wW9uBQ6XqxEmnXoG+ovY5JaXBw4fci
	bvRsA2k7VY2cVh9tjYkmA/UW5aNodLCGJ3MZXkMkbNCibxBh7B6/0orJxxJtljqy
	eYHdRcAgcNcgB+tLGmiKLxtpjqBELanN3BmxWWm5axG78x8QWUkyrL8wxSNTWpN0
	+WQ6eg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419pv0fmh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 06:09:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U69lQs013685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 06:09:47 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 23:09:45 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v4 7/8] wifi: cfg80211/mac80211: use proper link ID for DFS
Date: Fri, 30 Aug 2024 11:39:17 +0530
Message-ID: <20240830060918.2418701-8-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: 4yTG01HTHlmORfuH45qFgB7D3ek3rFIs
X-Proofpoint-ORIG-GUID: 4yTG01HTHlmORfuH45qFgB7D3ek3rFIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300043

Now that all APIs have support to handle DFS per link, use proper link ID
instead of 0.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c     |  6 +++---
 net/mac80211/mlme.c    |  4 ++--
 net/mac80211/scan.c    |  6 ++++--
 net/wireless/mlme.c    | 10 +++++-----
 net/wireless/nl80211.c | 15 ++++++++-------
 5 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 726cfb1f9061..39a99d8e24e7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1662,12 +1662,12 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	ieee80211_link_info_change_notify(sdata, link,
 					  BSS_CHANGED_BEACON_ENABLED);
 
-	if (sdata->wdev.links[0].cac_started) {
+	if (sdata->wdev.links[link_id].cac_started) {
 		chandef = link_conf->chanreq.oper;
 		wiphy_delayed_work_cancel(wiphy, &link->dfs_cac_timer_work);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED,
-				   GFP_KERNEL, 0);
+				   GFP_KERNEL, link_id);
 	}
 
 	drv_stop_ap(sdata->local, sdata, link_conf);
@@ -3965,7 +3965,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (!list_empty(&local->roc_list) || local->scanning)
 		return -EBUSY;
 
-	if (sdata->wdev.links[0].cac_started)
+	if (sdata->wdev.links[link_id].cac_started)
 		return -EBUSY;
 
 	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ac0800645dd5..7833f8862d60 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3039,11 +3039,11 @@ void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (sdata->wdev.links[0].cac_started) {
+	if (sdata->wdev.links[link->link_id].cac_started) {
 		ieee80211_link_release_channel(link);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_FINISHED,
-				   GFP_KERNEL, 0);
+				   GFP_KERNEL, link->link_id);
 	}
 }
 
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 6735620378f4..adb88c06b598 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -575,6 +575,7 @@ static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sub_if_data *sdata_iter;
+	unsigned int link_id;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -585,8 +586,9 @@ static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	list_for_each_entry(sdata_iter, &local->interfaces, list) {
-		if (sdata_iter->wdev.links[0].cac_started)
-			return false;
+		for_each_valid_link(&sdata_iter->wdev, link_id)
+			if (sdata_iter->wdev.links[link_id].cac_started)
+				return false;
 	}
 
 	return true;
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 115c8cd28aaf..4dac81854721 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1124,14 +1124,14 @@ void cfg80211_cac_event(struct net_device *netdev,
 
 	trace_cfg80211_cac_event(netdev, event, link_id);
 
-	if (WARN_ON(!wdev->links[0].cac_started &&
+	if (WARN_ON(!wdev->links[link_id].cac_started &&
 		    event != NL80211_RADAR_CAC_STARTED))
 		return;
 
 	switch (event) {
 	case NL80211_RADAR_CAC_FINISHED:
-		timeout = wdev->links[0].cac_start_time +
-			  msecs_to_jiffies(wdev->links[0].cac_time_ms);
+		timeout = wdev->links[link_id].cac_start_time +
+			  msecs_to_jiffies(wdev->links[link_id].cac_time_ms);
 		WARN_ON(!time_after_eq(jiffies, timeout));
 		cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_AVAILABLE);
 		memcpy(&rdev->cac_done_chandef, chandef,
@@ -1140,10 +1140,10 @@ void cfg80211_cac_event(struct net_device *netdev,
 		cfg80211_sched_dfs_chan_update(rdev);
 		fallthrough;
 	case NL80211_RADAR_CAC_ABORTED:
-		wdev->links[0].cac_started = false;
+		wdev->links[link_id].cac_started = false;
 		break;
 	case NL80211_RADAR_CAC_STARTED:
-		wdev->links[0].cac_started = true;
+		wdev->links[link_id].cac_started = true;
 		break;
 	default:
 		WARN_ON(1);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 46000376c939..8b2c92dfdcbc 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6066,7 +6066,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->start_ap)
 		return -EOPNOTSUPP;
 
-	if (wdev->links[0].cac_started)
+	if (wdev->links[link_id].cac_started)
 		return -EBUSY;
 
 	if (wdev->links[link_id].ap.beacon_interval)
@@ -10072,6 +10072,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	int link_id = nl80211_link_id(info->attrs);
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_chan_def chandef;
 	enum nl80211_dfs_regions dfs_region;
@@ -10126,7 +10127,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		 * can not already beacon
 		 */
 		if (wdev->valid_links &&
-		    !wdev->links[0].ap.beacon_interval) {
+		    !wdev->links[link_id].ap.beacon_interval) {
 			/* nothing */
 		} else {
 			err = -EBUSY;
@@ -10134,7 +10135,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		}
 	}
 
-	if (wdev->links[0].cac_started) {
+	if (wdev->links[link_id].cac_started) {
 		err = -EBUSY;
 		goto unlock;
 	}
@@ -10155,7 +10156,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		cac_time_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 
 	err = rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms,
-					 0);
+					 link_id);
 	if (!err) {
 		switch (wdev->iftype) {
 		case NL80211_IFTYPE_AP:
@@ -10171,9 +10172,9 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		default:
 			break;
 		}
-		wdev->links[0].cac_started = true;
-		wdev->links[0].cac_start_time = jiffies;
-		wdev->links[0].cac_time_ms = cac_time_ms;
+		wdev->links[link_id].cac_started = true;
+		wdev->links[link_id].cac_start_time = jiffies;
+		wdev->links[link_id].cac_time_ms = cac_time_ms;
 	}
 unlock:
 	wiphy_unlock(wiphy);
-- 
2.34.1


