Return-Path: <linux-wireless+bounces-6368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6A28A62B7
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 07:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5312228263B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 05:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5F539ADD;
	Tue, 16 Apr 2024 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kLnZ2/y5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001E3B293
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243626; cv=none; b=EyvoOxyON44CU2Iot+RE+QeOLs9wsY9uqrS268z08kE/+C3tS2+YLIn38yezuTFDcxf+A+y/4be2h79RPCxsuWbIOY/Ona319FqB92PR0Oqdqilxnxo4vP62whMBbIs27d9723VeCs5HUlljipNK1y5bl53MIYZ5Ux2GIvPWyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243626; c=relaxed/simple;
	bh=K6pw06ngeyDVDDKNhUua2YUq+pcqYC+Mx1IOqlyR8Is=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNSTfjlErrj8qX5XgW0Oerb1LbHaAhSF/27pyGqx8YUHM6+1a9IolIg5W5C6oyE4532E82RPNCxCIVR0+dV8qUx1y8/2d2a6FBEXD16LHhb/YOita3RUIsoXug6nStOs04styKGHxykHnEXWyosN8YzoJzuDt/QWQkLhFaGqaBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kLnZ2/y5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G3v7aP021630;
	Tue, 16 Apr 2024 05:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=cjk/WZ3IP6Scep2akuQhco/LxnmKGQ2WeRzCegkRVIQ=; b=kL
	nZ2/y514qLg4ez8lrI3f1WyWSX/KDrvCmmgNT/h3/Gzi3elI78paUo6AEukzgHmm
	R37LqGt3e8xGtWwgNv65JFbp7vhqKmywjWxwAWSqyf5mMkruwZh1Pco5mVXMjb8J
	J+RHmn35EaD+sRxocus/Mdbe3gtV9pNvw43tA1Bfp1Cw6YJAtNAwrcKzcedenGao
	7nQQgD55nxwShnznI1qh13oaVdSPNV2m9GyULpjSWdIsl4d5kyrQHgRB9NfsRBq5
	SUxY6pY9rQRd3fMn/pn1y4KnIvcbvMjyBZ3o/VOZdtD10UZJt3k6bEe1CDqLf7BJ
	PAOvO2oZ3lhYHZLMvEkA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xha2m8yxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G50BDS000362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:11 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 22:00:09 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 5/7] wifi: mac80211: start and finalize color change on link basis
Date: Tue, 16 Apr 2024 10:29:41 +0530
Message-ID: <20240416045943.576656-6-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416045943.576656-1-quic_adisi@quicinc.com>
References: <20240416045943.576656-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: 44iIqARBw7Vnf6qKK4RXY64z5rcsXhbJ
X-Proofpoint-ORIG-GUID: 44iIqARBw7Vnf6qKK4RXY64z5rcsXhbJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404160028

Add changes to start a color change as well as finalize it on link basis
in order to support switching color with MLO as well.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 55 +++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 13cf4c0f3030..fcba6d28ea36 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4761,26 +4761,27 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_link_data *link,
 	}
 }
 
-static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
+static int ieee80211_color_change_finalize(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	u64 changed = 0;
 	int err;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	sdata->vif.bss_conf.color_change_active = false;
+	link->conf->color_change_active = false;
 
-	err = ieee80211_set_after_color_change_beacon(&sdata->deflink, &changed);
+	err = ieee80211_set_after_color_change_beacon(link, &changed);
 	if (err) {
-		cfg80211_color_change_aborted_notify(sdata->dev, 0);
+		cfg80211_color_change_aborted_notify(sdata->dev, link->link_id);
 		return err;
 	}
 
-	ieee80211_color_change_bss_config_notify(&sdata->deflink,
-						 sdata->vif.bss_conf.color_change_color,
+	ieee80211_color_change_bss_config_notify(link,
+						 link->conf->color_change_color,
 						 1, changed);
-	cfg80211_color_change_notify(sdata->dev, 0);
+	cfg80211_color_change_notify(sdata->dev, link->link_id);
 
 	return 0;
 }
@@ -4788,21 +4789,23 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 void ieee80211_color_change_finalize_work(struct wiphy *wiphy,
 					  struct wiphy_work *work)
 {
-	struct ieee80211_sub_if_data *sdata =
-		container_of(work, struct ieee80211_sub_if_data,
-			     deflink.color_change_finalize_work);
+	struct ieee80211_link_data *link =
+		container_of(work, struct ieee80211_link_data,
+			     color_change_finalize_work);
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct ieee80211_bss_conf *link_conf = link->conf;
 	struct ieee80211_local *local = sdata->local;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* AP might have been stopped while waiting for the lock. */
-	if (!sdata->vif.bss_conf.color_change_active)
+	if (!link_conf->color_change_active)
 		return;
 
 	if (!ieee80211_sdata_running(sdata))
 		return;
 
-	ieee80211_color_change_finalize(sdata);
+	ieee80211_color_change_finalize(link);
 }
 
 void ieee80211_color_collision_detection_work(struct work_struct *work)
@@ -4855,36 +4858,48 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_data *link;
+	u8 link_id = params->link_id;
 	u64 changed = 0;
 	int err;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (sdata->vif.bss_conf.nontransmitted)
+	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
+		return -EINVAL;
+
+	link = wiphy_dereference(wiphy, sdata->link[link_id]);
+	if (!link)
+		return -ENOLINK;
+
+	link_conf = link->conf;
+
+	if (link_conf->nontransmitted)
 		return -EINVAL;
 
 	/* don't allow another color change if one is already active or if csa
 	 * is active
 	 */
-	if (sdata->vif.bss_conf.color_change_active || sdata->vif.bss_conf.csa_active) {
+	if (link_conf->color_change_active || link_conf->csa_active) {
 		err = -EBUSY;
 		goto out;
 	}
 
-	err = ieee80211_set_color_change_beacon(&sdata->deflink, params, &changed);
+	err = ieee80211_set_color_change_beacon(link, params, &changed);
 	if (err)
 		goto out;
 
-	sdata->vif.bss_conf.color_change_active = true;
-	sdata->vif.bss_conf.color_change_color = params->color;
+	link_conf->color_change_active = true;
+	link_conf->color_change_color = params->color;
 
-	cfg80211_color_change_started_notify(sdata->dev, params->count, 0);
+	cfg80211_color_change_started_notify(sdata->dev, params->count, link_id);
 
 	if (changed)
-		ieee80211_color_change_bss_config_notify(&sdata->deflink, 0, 0, changed);
+		ieee80211_color_change_bss_config_notify(link, 0, 0, changed);
 	else
 		/* if the beacon didn't change, we can finalize immediately */
-		ieee80211_color_change_finalize(sdata);
+		ieee80211_color_change_finalize(link);
 
 out:
 
-- 
2.25.1


