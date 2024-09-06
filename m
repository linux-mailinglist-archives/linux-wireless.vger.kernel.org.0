Return-Path: <linux-wireless+bounces-12584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B7496EAE0
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 08:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE5D1F250D1
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 06:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F3114B942;
	Fri,  6 Sep 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="osbjis92"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320214883B
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605104; cv=none; b=SONvMnzAvDMnSrP+0mz2+/jwOkxdX8QcjiUB1f2EufgU20XhJCvCKrSwCSKkkEr7bIjXW89P4ynYLjda7saZmXTkClYn2pJIjNFFI8xoQvGwUbZ6kaPa3PL6FKx4mr+IH2xspLcmuP8KwuIEQXgCFuX9GDGqeb1FZF1ojoIb9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605104; c=relaxed/simple;
	bh=OKh3xt9jAlVtZkv1GdT47GbIQBG93OvNVo4f6r7sXIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7H/C61JPayUjLIyNTidZo3ULg6vLqnf+RPoIa6GNNqaSpCaE0JyUkiEq4OR2CSwsvUn1czaN+TZpju5SZ/UU8cM1ikZ61a3U2I0gKCny84PYjBiqM+HF9bbnhhUW81cywvyPiGHXBF3lBMRNAk8yLa4dYoreUJpcdN2476T3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=osbjis92; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IV7nv024609;
	Fri, 6 Sep 2024 06:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6SYMfrgmgLZsgx38hPZh2h7ZmIsC7a7Z7aOKTBZkGiw=; b=osbjis929o+sQg84
	lAdb/zkLFUKxy6WpOKCh/lLd5xcIOl5p+PfBr2xaTZ3qfPS45vBR3Jz6LP2pOyXl
	goZhjwyYCON8pH32HnwfCM94JYE9zRk6HMEQJ/2nx8gy5g5wqPO6qI0rI6JM+d3J
	h5XOwVoiEWIIg0WLZBw+xwnzF9BgylVKhVm+O6As3bfwzG1W01mgwflF6Z3Fz5BV
	23w0MocH+0zYQ1bJEPsduJcSL7p5h9M2Uc0GTOY7M9DI1fA5TEGy9x6gYU6xJHFx
	Ok8GpoPgGgKjN9iEuX0xjhCLaV1zfIyBEP9EANGRH8DsUqhNRzOlcjEi83Dh+5mc
	bzECsw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fj09sbm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 06:44:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4866ivsi001323
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 06:44:57 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Sep 2024 23:44:55 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v6 7/8] wifi: cfg80211/mac80211: use proper link ID for DFS
Date: Fri, 6 Sep 2024 12:14:25 +0530
Message-ID: <20240906064426.2101315-8-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906064426.2101315-1-quic_adisi@quicinc.com>
References: <20240906064426.2101315-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: DFUxcfCsiCGY6Bbj9Kvykj_ZwGIi288C
X-Proofpoint-ORIG-GUID: DFUxcfCsiCGY6Bbj9Kvykj_ZwGIi288C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060048

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
index 57e66c671e2e..847304a3a29a 100644
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
@@ -3968,7 +3968,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (!list_empty(&local->roc_list) || local->scanning)
 		return -EBUSY;
 
-	if (sdata->wdev.links[0].cac_started)
+	if (sdata->wdev.links[link_id].cac_started)
 		return -EBUSY;
 
 	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 715709860fdd..735e78adb0db 100644
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


