Return-Path: <linux-wireless+bounces-9578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD3D9177B1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 06:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFD1B219DF
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 04:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD2413AD37;
	Wed, 26 Jun 2024 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SXj27d9k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D41474B2
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719377583; cv=none; b=FYdl3Zzkl1RXt+/oUb2ZmnPomjzmVOOLGz03QdaYXj3XxZAx1WxgljhhxB4Ry6eYgGT0KvfLhFA3MRvjFMyUfDaOxsnszhMsAp0CisMa6MlmZ5EcghCelS2i30OGNkCL52+hLTqaxmNLhiBDRkjb1b8hoWv85B0SuUiV/t6Y/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719377583; c=relaxed/simple;
	bh=mMJAWhrhTWbQ/VD79dRVtNkjKrX3G2zSDR7vvNUAXAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDiIAK1l013wB0mQa7/mvlJjuBcthgMlRE27bzBVK0k9//kbCpzn+SpNWS24Pj/EZBmTkWxUAnUrhtlFwWcHXLyKr0/uR7G/AY16O6RhNIcC9QP9mb2VMLVZLv2f39+jeXN3fvu94aJcjoLhO2j6qfNeEcWn0LnTXLbnO3ZfFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SXj27d9k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PNXf40013485;
	Wed, 26 Jun 2024 04:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B20B+iBUys+C4EBExSv12FM7Z+NvGAdxqX43I3d99FI=; b=SXj27d9ksvb/tJBi
	Y4veatkBGyE6N0zfBrMf5Y/UKlwCpvpRp0JwcRdA5iGWrZIOjbEkVIfr1ehTOrEi
	77O/4bt5kX706nr+dRfWoWbc/4W/HNoysJnqX7o+HnF0UjSQhj+pw2L4ncHojlXc
	ZdFNsQ3/LSAq5BrUuXLmcaKDkQjelBeTq9BhQVnH91l6XW5Sov/shQVbDjInn+L0
	SktDjyhXre/5bAO8MFAFf/CF1K/zpoKkCU5ZLYJEZ5RrNxahY5J4vH0XgdxIkJvn
	SbAEajbctHj4HqtaOPE51rRxJfkX7qRBMbiUHTVaS6HtXn1G3qqWsliY4WyXmqYD
	7tC8GQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnxh06wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 04:52:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q4qtO6025082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 04:52:55 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Jun 2024 21:52:54 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 7/9] wifi: mac80211: handle DFS on per link
Date: Wed, 26 Jun 2024 10:22:14 +0530
Message-ID: <20240626045216.3754013-8-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626045216.3754013-1-quic_adisi@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: tPAlmtErzUtID-34jIHfCMBw4oMPp3e-
X-Proofpoint-ORIG-GUID: tPAlmtErzUtID-34jIHfCMBw4oMPp3e-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_02,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260036

In order to support DFS with MLO, handle the link ID now passed from
cfg80211, adjust the code to do everything per link and call the
notifications to cfg80211 correctly.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c  | 26 ++++++++++++++++++--------
 net/mac80211/util.c | 29 +++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f7c9d78f6f7d..fb670aa1b11e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3471,6 +3471,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_chan_req chanreq = { .oper = *chandef };
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_link_data *link_data;
 	int err;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -3478,16 +3479,20 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
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
@@ -3498,16 +3503,21 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
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


