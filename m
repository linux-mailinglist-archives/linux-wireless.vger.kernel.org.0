Return-Path: <linux-wireless+bounces-12586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CC196EAE2
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 08:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A49284BC9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 06:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B15143C63;
	Fri,  6 Sep 2024 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SJtYrj/Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962661411DE
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605105; cv=none; b=uqdV/+VOJY3DSwA9OwMmMwc5WuTnmydj/v+YDe6+u75qbxI1SfVGmRsTFvl9Ptikglxk6yM2YPOHP9LK4U7poQbaMcFaVNLxDbryoUDYA4J1zdfFS/UP7j40DV3JVfKV4M8PldOnxVHcpD67fuqikh78Tjp2jMBra3cMLYdZyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605105; c=relaxed/simple;
	bh=mi0j3jRCszXuAmTRCu6CA7/gvY+GnkH5Busx87UO5Aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bb4eai69Ov18/JZWX19bc4t1gB8ilgQb8nZHpRiHxP54N66W5WnZdPDVV/whsrDxjXM5+99Dl334PplmXIR4YJHyzPIhNGbpyunDlF0UIFgrgx0++Gxppc7GTTYG9xByEj2KTTg9PxjU3ZqYhJqW+JSoe3k+OIWt5QmnKDgS0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SJtYrj/Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQ4Xg028299;
	Fri, 6 Sep 2024 06:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EyFcu8rSrv7blSej1lK28y93o1qGOwrr9zZxKBk7J1o=; b=SJtYrj/ZIGgvhKQZ
	kf0kPabOe6m9l99ARFGGMRHwy1E+GXW3I73UbrGF6eqBWU8jKNU4o60EE4Kv2sy1
	8IKUpFNAQH2VbnPKJuWno+w9Ms1OIXnkCdiPs6cWGHD1qfss8yOhZnvDtzWftDKg
	kV08YsuP+TMQ3GmTXYUobqTsPWPW0cGbDoE6heSkUZHJFTGS8venf0L+mrCPS1z7
	VTUqN9P77F4X7TsWmZyFR8H0XyxfSppCpaUgfhxppADqfjdoFex4FPnvENgrttAk
	F1BC5aFl5UxnVIwCsfB8DhQNRGzom/qxp5Tbs2a1e4/LbbJoxv2kz0XkwHtZ442H
	Gxwgdw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwu1bm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 06:44:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4866itQF018413
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 06:44:55 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Sep 2024 23:44:53 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v6 6/8] wifi: mac80211: handle DFS per link
Date: Fri, 6 Sep 2024 12:14:24 +0530
Message-ID: <20240906064426.2101315-7-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8Imdrf5X_swjIi_68OprBwKYC1_w6y0U
X-Proofpoint-GUID: 8Imdrf5X_swjIi_68OprBwKYC1_w6y0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060048

In order to support DFS with MLO, handle the link ID now passed from
cfg80211, adjust the code to do everything per link and call the
notifications to cfg80211 correctly.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c  | 26 ++++++++++++++++++--------
 net/mac80211/link.c | 10 ++++++++++
 net/mac80211/util.c | 28 +++++++++++++++++++---------
 3 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 67dd780530fb..57e66c671e2e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3467,6 +3467,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_chan_req chanreq = { .oper = *chandef };
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_link_data *link_data;
 	int err;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -3474,16 +3475,20 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
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
@@ -3494,16 +3499,21 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
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
index c4fd60fbcfd4..2e37d2639074 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3471,20 +3471,30 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct cfg80211_chan_def chandef;
+	struct ieee80211_link_data *link;
+	unsigned int link_id;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
-		wiphy_delayed_work_cancel(local->hw.wiphy,
-					  &sdata->deflink.dfs_cac_timer_work);
-
-		if (sdata->wdev.links[0].cac_started) {
-			chandef = sdata->vif.bss_conf.chanreq.oper;
-			ieee80211_link_release_channel(&sdata->deflink);
-			cfg80211_cac_event(sdata->dev,
-					   &chandef,
+		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+		     link_id++) {
+			link = sdata_dereference(sdata->link[link_id],
+						 sdata);
+			if (!link)
+				continue;
+
+			wiphy_delayed_work_cancel(local->hw.wiphy,
+						  &link->dfs_cac_timer_work);
+
+			if (!sdata->wdev.links[link_id].cac_started)
+				continue;
+
+			chandef = link->conf->chanreq.oper;
+			ieee80211_link_release_channel(link);
+			cfg80211_cac_event(sdata->dev, &chandef,
 					   NL80211_RADAR_CAC_ABORTED,
-					   GFP_KERNEL, 0);
+					   GFP_KERNEL, link_id);
 		}
 	}
 }
-- 
2.34.1


