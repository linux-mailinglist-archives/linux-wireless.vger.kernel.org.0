Return-Path: <linux-wireless+bounces-2631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0726083FDBE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D381F2367F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 05:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DC24C60E;
	Mon, 29 Jan 2024 05:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IHi8k0si"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7B4C602
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706506145; cv=none; b=ECOljIB7HtJUL0QvukiqwumbfUzhhBiWjVGX28Zr8DytwZS3MU/Brs37ypj6GdfnJf2g3J+ohHoSKaZR56UrhsZ7LNAl9E3VAmFvcNqo97gcXlgJzREzhCYM7ZDdJvB8GsxwNjF7VO9k74iSG5lqCK2ylJutCvKHXOoJkQyjpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706506145; c=relaxed/simple;
	bh=SL5L/tg3WhGiqZsxZXg/dZ15NltDhCVtav5zbKRh6F4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiZT/uy6/hVtkpi/kpnQveFwSCZ1ztPpyfS2OdidjFbS+6bYh0vZkvbOWO6ZBC/E2vRKqt+cvPbkr7QjqGU1QGMWaOzBGjrRSrjZ9TlaRxWBJnyrLMErXHSsE2ecMbn/RROyRcGwzfbwTyi0McCk9/BFfBlhAo9aQ+dFTLmiNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IHi8k0si; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5Hcoa003889;
	Mon, 29 Jan 2024 05:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vtK5enC/ymXkqjp9fBl9IjXWX9xyabiR1gp9BTr2PtE=; b=IH
	i8k0siOrGjJNNG7oUDlFt7XU8rF+xpMG8ahSJKBESu/y8R7gxiPchUQ9aN7dFy1l
	b7rKHSY+0GfIuGalmwZwQ0tHuS6uB+WecQgb4BkKQeOonzw7I0y81SFA0rm5hDi/
	UZiSd+sPYomWWzg8FIYPOhqkoHSoiCN+fGKFHKSTZPN4yMM48bn9x3aaL9LHfLlm
	SbUdtExhgjewN6CXFF90HJLTt0LxSHRIqW2jL0ijBQDeKM6eLi1QFlgPlU1spqHE
	KX/QTW4rYFea5GaGyfjBl2YN5b21DfJH29z2yk5MjOXmthpIgGedQOOOUyOsduFa
	XhHcQ10mgzn470TGfy2g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3t2g6dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:28:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T5SuwK013442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:28:56 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 21:28:54 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v6 4/5] wifi: mac80211: start and finalize channel switch on link basis
Date: Mon, 29 Jan 2024 10:58:31 +0530
Message-ID: <20240129052832.905113-5-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129052832.905113-1-quic_adisi@quicinc.com>
References: <20240129052832.905113-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: R7EXqWnADRNZ2SM4E4VHqxqzWtS_J-Eb
X-Proofpoint-GUID: R7EXqWnADRNZ2SM4E4VHqxqzWtS_J-Eb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=696 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290037

Add changes to start a channel switch as well as finalize it on link basis
in order to support CSA with MLO as well.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c  | 69 ++++++++++++++++++++++++++-------------------
 net/mac80211/link.c |  2 ++
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a5d510932cbe..4427259154e2 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3629,6 +3629,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 {
 	struct ieee80211_sub_if_data *sdata = link_data->sdata;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_bss_conf *link_conf = link_data->conf;
 	u64 changed = 0;
 	int err;
 
@@ -3650,22 +3651,21 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 		if (link_data->reserved_ready)
 			return 0;
 
-		return ieee80211_link_use_reserved_context(&sdata->deflink);
+		return ieee80211_link_use_reserved_context(link_data);
 	}
 
-	if (!cfg80211_chandef_identical(&link_data->conf->chandef,
+	if (!cfg80211_chandef_identical(&link_conf->chandef,
 					&link_data->csa_chandef))
 		return -EINVAL;
 
-	sdata->vif.bss_conf.csa_active = false;
+	link_conf->csa_active = false;
 
-	err = ieee80211_set_after_csa_beacon(&sdata->deflink, &changed);
+	err = ieee80211_set_after_csa_beacon(link_data, &changed);
 	if (err)
 		return err;
 
-	if (sdata->vif.bss_conf.eht_puncturing != sdata->vif.bss_conf.csa_punct_bitmap) {
-		sdata->vif.bss_conf.eht_puncturing =
-					sdata->vif.bss_conf.csa_punct_bitmap;
+	if (link_conf->eht_puncturing != link_conf->csa_punct_bitmap) {
+		link_conf->eht_puncturing = link_conf->csa_punct_bitmap;
 		changed |= BSS_CHANGED_EHT_PUNCTURING;
 	}
 
@@ -3693,7 +3693,8 @@ static void ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 	struct ieee80211_sub_if_data *sdata = link_data->sdata;
 
 	if (__ieee80211_csa_finalize(link_data)) {
-		sdata_info(sdata, "failed to finalize CSA, disconnecting\n");
+		sdata_info(sdata, "failed to finalize CSA on link %d, disconnecting\n",
+			   link_data->link_id);
 		cfg80211_stop_iface(sdata->local->hw.wiphy, &sdata->wdev,
 				    GFP_KERNEL);
 	}
@@ -3869,7 +3870,10 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_channel_switch ch_switch;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *chanctx;
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_data *link_data;
 	u64 changed = 0;
+	u8 link_id = params->link_id;
 	int err;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -3880,16 +3884,23 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->wdev.cac_started)
 		return -EBUSY;
 
-	if (cfg80211_chandef_identical(&params->chandef,
-				       &sdata->vif.bss_conf.chandef))
+	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
+		return -EINVAL;
+
+	link_data = wiphy_dereference(wiphy, sdata->link[link_id]);
+	if (!link_data)
+		return -ENOLINK;
+
+	link_conf = link_data->conf;
+
+	if (cfg80211_chandef_identical(&params->chandef, &link_conf->chandef))
 		return -EINVAL;
 
 	/* don't allow another channel switch if one is already active. */
-	if (sdata->vif.bss_conf.csa_active)
+	if (link_conf->csa_active)
 		return -EBUSY;
 
-	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
-					 lockdep_is_held(&local->hw.wiphy->mtx));
+	conf = wiphy_dereference(wiphy, link_conf->chanctx_conf);
 	if (!conf) {
 		err = -EBUSY;
 		goto out;
@@ -3913,7 +3924,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (err)
 		goto out;
 
-	err = ieee80211_link_reserve_chanctx(&sdata->deflink, &params->chandef,
+	err = ieee80211_link_reserve_chanctx(link_data, &params->chandef,
 					     chanctx->mode,
 					     params->radar_required);
 	if (err)
@@ -3922,44 +3933,44 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	/* if reservation is invalid then this will fail */
 	err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0);
 	if (err) {
-		ieee80211_link_unreserve_chanctx(&sdata->deflink);
+		ieee80211_link_unreserve_chanctx(link_data);
 		goto out;
 	}
 
 	/* if there is a color change in progress, abort it */
-	if (sdata->vif.bss_conf.color_change_active)
+	if (link_conf->color_change_active)
 		ieee80211_color_change_abort(sdata);
 
-	err = ieee80211_set_csa_beacon(&sdata->deflink, params, &changed);
+	err = ieee80211_set_csa_beacon(link_data, params, &changed);
 	if (err) {
-		ieee80211_link_unreserve_chanctx(&sdata->deflink);
+		ieee80211_link_unreserve_chanctx(link_data);
 		goto out;
 	}
 
-	if (params->punct_bitmap && !sdata->vif.bss_conf.eht_support)
+	if (params->punct_bitmap && link_conf->eht_support)
 		goto out;
 
-	sdata->deflink.csa_chandef = params->chandef;
-	sdata->deflink.csa_block_tx = params->block_tx;
-	sdata->vif.bss_conf.csa_active = true;
-	sdata->vif.bss_conf.csa_punct_bitmap = params->punct_bitmap;
+	link_data->csa_chandef = params->chandef;
+	link_data->csa_block_tx = params->block_tx;
+	link_conf->csa_active = true;
+	link_conf->csa_punct_bitmap = params->punct_bitmap;
 
-	if (sdata->deflink.csa_block_tx)
+	if (link_data->csa_block_tx)
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
-					  &sdata->deflink.csa_chandef, 0,
+					  &link_data->csa_chandef, link_id,
 					  params->count, params->block_tx,
-					  sdata->vif.bss_conf.csa_punct_bitmap);
+					  link_conf->csa_punct_bitmap);
 
 	if (changed) {
-		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-						  changed);
+		ieee80211_link_info_change_notify(sdata, link_data, changed);
+		/* link_id to be passed here? */
 		drv_channel_switch_beacon(sdata, &params->chandef);
 	} else {
 		/* if the beacon didn't change, we can finalize immediately */
-		ieee80211_csa_finalize(&sdata->deflink);
+		ieee80211_csa_finalize(link_data);
 	}
 
 out:
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index d4f86955afa6..0a1d0ef09d9f 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -73,6 +73,8 @@ void ieee80211_link_stop(struct ieee80211_link_data *link)
 		ieee80211_mgd_stop_link(link);
 
 	cancel_delayed_work_sync(&link->color_collision_detect_work);
+	wiphy_work_cancel(link->sdata->local->hw.wiphy,
+			  &link->csa_finalize_work);
 	ieee80211_link_release_channel(link);
 }
 
-- 
2.25.1


