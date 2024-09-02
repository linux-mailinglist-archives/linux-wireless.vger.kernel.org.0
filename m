Return-Path: <linux-wireless+bounces-12316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05A967FB3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443911F20F50
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 06:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1F71714C7;
	Mon,  2 Sep 2024 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dSpc7jXg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AFC16EC1B
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259764; cv=none; b=r/QrSOVwQPDeebgTpIUp0ENV4pp5xXJOU6GjlfLSBRaxI5QkhVyzwDHCFEMc2IM3fjnig7n8hGwIBQpXn7o9ylSc3ZoV8cfYpeVeb6iPdS8FJvPDoGBEePQNf2t9Q2bwpEFRoMeR7TruH2eknrqUener7yfm8Lqe9zW/IzQsO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259764; c=relaxed/simple;
	bh=+djmKYVBLQfyzQ0EGsIT6trwcG68c0NCjPMEzPoBzRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhBXciotUbxRagIXd13cE2/EsumQlWSqOOzmhe41w6ORRsmUDlUF7UUBCecfYTQYpaZWYlYizgtktXxcIqaknSLGQ3TgAs8AuDIylLppA/Cm6FaGsBc9XQnkdWH+fMmgLx8uRWdFX/Cf4aH+FprKk7b2bxIGlYUX11oE6KMRLso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dSpc7jXg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4821GU8w016876;
	Mon, 2 Sep 2024 06:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bhbj81qcqZJFr0TWCrSbJ3TUwqJjUtBJhh1XsP3aM+4=; b=dSpc7jXgTSSX6tKK
	FBhEhRjDBvUkdlCN+I0g90Oxu5Egrs5r7Plq0PSZLQDGuR3Mq2egz1GSu7514ZiD
	zljEtPuNTpWOtFnrhlgv1RA7B5P2nBsJblCUHLWMvcLEHlbkAq1bPKhc9E3HECRe
	Cl6K8mHF+guF86RpaHuW3oID7akQsapSjhgChnKCUkHpIzPJ6OiOxJ2GosTOtlOU
	wzyiSpSA4NVBstDChqSXnAB4S1IYPOTypRuPJEZWrTvEcwHA0pMhLKFEZOS0T494
	eT0AmgACWQ/uhOD3NdjOFdU43I71jXY9YrNEpGnxbr3hZqy3VQz1lby2PKSl2dBF
	fRZSfQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41btggut07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 06:49:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4826nHVZ007923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Sep 2024 06:49:17 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 1 Sep 2024 23:49:15 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v5 6/8] wifi: mac80211: handle DFS per link
Date: Mon, 2 Sep 2024 12:18:45 +0530
Message-ID: <20240902064847.2506090-7-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902064847.2506090-1-quic_adisi@quicinc.com>
References: <20240902064847.2506090-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: AACd_ydtNH9_0daVw3QyzdjVf9DWXqCl
X-Proofpoint-ORIG-GUID: AACd_ydtNH9_0daVw3QyzdjVf9DWXqCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-01_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409020055

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


