Return-Path: <linux-wireless+bounces-6635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957458AC3C2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 07:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26391282B49
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3603F1862F;
	Mon, 22 Apr 2024 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dJNl6q5+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74011804E
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764101; cv=none; b=ZzQ3wKvyLrmaQMWRoMI1Syd4raTzNpVNH1OBjRkXv4NZusWT0f6EBSGkPrZos8IKfuFTPhjExe6iQ6xe3NQXEabvYNlgtsDLOvlyZBtaoUf0RKlqSgJDHxnNu+5VmUejcnxnFcESA/ozes/GsJYgXZekxKidFZPoAu4sr4LxEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764101; c=relaxed/simple;
	bh=8rgn+PbELrgQMzxKrspsvEjUOB0L7PYZPDspRX1GGQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbvqfH8ag6Zrq58icMa1v30iHQvfgBcJqpVJNZKmQZU4mMhPOsTK+0W215uHDZqxTFlMaNOmvO6l7mvyRswYs9KezFYBGQe3gEVEaWC0/8RbexPV7EAdYRfDUGpx2wIPjFhLRWDQIm3yeFyrUANpvAWMMHB0TWwb0w9BXoCkT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dJNl6q5+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M33SZb006809;
	Mon, 22 Apr 2024 05:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=TJ6oG8DGD57x79+PDqCjO0OoTZOKjfsNvv9/yOd3TeM=; b=dJ
	Nl6q5+rYf0JMRNI+P9jAgKjVF+9tQSfd6rP5366Hy9WIXhSAuWa7HWBo1E+WiYIF
	tzxhyUMtb2iAU36+06CfINEkW5ZhUBH9YkCExffCSZONbtO4PLiooDj3UcEu+MUD
	arzf5EHmR19uhbwN/zskzvpg6bA2rhFxwN2cS2LKu14EPUe4XY6hyacSHVaBPCwl
	zGGUgUdeuyANbvGEAYjVk7vjRFOQVLtElv0667yz3NRZULGu8kBuX8DtOTX1mw9N
	p2b43MkyQhJ7a+E8ErU7L1KONKI8QQyF66emjLpksbPHXLSDh5wodVqpTGUf7Kqj
	3dSsDWBPb5aGlBWfSS1A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm6vrb5bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M5YfM4016017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:41 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Apr 2024 22:34:39 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 5/7] wifi: mac80211: start and finalize color change on link basis
Date: Mon, 22 Apr 2024 11:04:10 +0530
Message-ID: <20240422053412.2024075-6-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422053412.2024075-1-quic_adisi@quicinc.com>
References: <20240422053412.2024075-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: awx-r_p8FSEHQJZ1knwu3jgc4fk9i7FB
X-Proofpoint-ORIG-GUID: awx-r_p8FSEHQJZ1knwu3jgc4fk9i7FB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_02,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220025

Add changes to start a color change as well as finalize it on link basis
in order to support switching color with MLO as well.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 55 +++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5339a8e884ac..b30d842e5068 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4765,26 +4765,27 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_link_data *link,
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
@@ -4792,21 +4793,23 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
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
@@ -4859,36 +4862,48 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
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
2.34.1


