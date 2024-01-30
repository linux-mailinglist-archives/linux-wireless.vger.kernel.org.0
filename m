Return-Path: <linux-wireless+bounces-2770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51868841B03
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 05:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D292B1F271E7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 04:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4D0381CD;
	Tue, 30 Jan 2024 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XoB4zY1W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F9381AC
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706589184; cv=none; b=eRvAchqgZPGocEq8TF0MeHK3pK5v0jjyLpYR7VGLyUqiMjgdohSEtPR/0LYKf8mSZAP0/S3nIhDOcf/eevMK9OWgjOj20eSQwjqgWaR2to6IkgpE+ND5EDUPimj1PAaUXVZOivUhNzNRAxAx8AGkPmpnrbVe/drrjvbJJ5FsFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706589184; c=relaxed/simple;
	bh=E6GvGHnJEngJCiYXVGH09ifRgtdKLFKGwKZPW4gufSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufebrnzBQphSp+kTFC8g+sNZMdoFutyHxqBQ49xpIxjkCIfQZpE+y8DlZ5aV0eqUxiNlZ+ufs994pVjr/FUzW+ftlqSGiwIqF53tkjmkbKkgiKj0LDZs7TtP6qJj6ikxybhgmk0Qz9ez7rLv+4NvODmm2UTQG/pwZnWCI5SzSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XoB4zY1W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40TLCLT6004528;
	Tue, 30 Jan 2024 04:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=BzSUpx/jsHLd0ohKDgfS6TGz3JlqCIIKZPU+KnLAQHQ=; b=Xo
	B4zY1WdGg/gCzlLdQMCLkvUyT1ydAxWfKR5BOEJ5N8oNh+C7oTYqEKWJmQjZGCfe
	ZhTKUucOFET+/yJrYgpDRuZX60o9d4g7B/86kT8KPlwN9dWsqYqpyecykHjzyJVX
	0A2+2krZOaM9mYgEHVLGp3jCNCbN+PwmE6p/6XI6enn5mevkxom9Djbkp8ybLzYs
	C1IGyPq/r9+CSo9fqlHm3gzQr9uEg6SRQjmVaMEsh5RZ8CsZ3vUNez8qggIewZPw
	erPimyGKS68qbgNVd031bwSEmiNc+7fa1YDeSyzNsIVD2YPocZI1ucwxC54dY9Yf
	oa0iY3g9JiSSYwHrp8Cw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx86htmqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:32:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U4Wu87008828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:32:56 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 20:32:55 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v7 3/5] wifi: mac80211: handle set csa/after_csa beacon on per link basis
Date: Tue, 30 Jan 2024 10:02:23 +0530
Message-ID: <20240130043225.942202-4-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130043225.942202-1-quic_adisi@quicinc.com>
References: <20240130043225.942202-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8s90vaTr4fR4tXMbK5NYIM3UunvaSAMZ
X-Proofpoint-GUID: 8s90vaTr4fR4tXMbK5NYIM3UunvaSAMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_01,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300029

In order to support CSA with MLO, there is a need to handle the functions
ieee80211_set_csa_beacon() and ieee80211_set_after_csa_beacon() on per
link basis.

Add changes for the same.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index dd237081dbe3..a5d510932cbe 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3586,20 +3586,21 @@ void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_t
 }
 EXPORT_SYMBOL(ieee80211_channel_switch_disconnect);
 
-static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
+static int ieee80211_set_after_csa_beacon(struct ieee80211_link_data *link_data,
 					  u64 *changed)
 {
+	struct ieee80211_sub_if_data *sdata = link_data->sdata;
 	int err;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
-		if (!sdata->deflink.u.ap.next_beacon)
+		if (!link_data->u.ap.next_beacon)
 			return -EINVAL;
 
-		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
-					      sdata->deflink.u.ap.next_beacon,
+		err = ieee80211_assign_beacon(sdata, link_data,
+					      link_data->u.ap.next_beacon,
 					      NULL, NULL, changed);
-		ieee80211_free_next_beacon(&sdata->deflink);
+		ieee80211_free_next_beacon(link_data);
 
 		if (err < 0)
 			return err;
@@ -3658,7 +3659,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 
 	sdata->vif.bss_conf.csa_active = false;
 
-	err = ieee80211_set_after_csa_beacon(sdata, &changed);
+	err = ieee80211_set_after_csa_beacon(&sdata->deflink, &changed);
 	if (err)
 		return err;
 
@@ -3717,18 +3718,19 @@ void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work)
 	ieee80211_csa_finalize(link);
 }
 
-static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
+static int ieee80211_set_csa_beacon(struct ieee80211_link_data *link_data,
 				    struct cfg80211_csa_settings *params,
 				    u64 *changed)
 {
+	struct ieee80211_sub_if_data *sdata = link_data->sdata;
 	struct ieee80211_csa_settings csa = {};
 	int err;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
-		sdata->deflink.u.ap.next_beacon =
+		link_data->u.ap.next_beacon =
 			cfg80211_beacon_dup(&params->beacon_after);
-		if (!sdata->deflink.u.ap.next_beacon)
+		if (!link_data->u.ap.next_beacon)
 			return -ENOMEM;
 
 		/*
@@ -3754,7 +3756,7 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM) ||
 		    (params->n_counter_offsets_presp >
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM)) {
-			ieee80211_free_next_beacon(&sdata->deflink);
+			ieee80211_free_next_beacon(link_data);
 			return -EINVAL;
 		}
 
@@ -3764,11 +3766,11 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		csa.n_counter_offsets_presp = params->n_counter_offsets_presp;
 		csa.count = params->count;
 
-		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
+		err = ieee80211_assign_beacon(sdata, link_data,
 					      &params->beacon_csa, &csa,
 					      NULL, changed);
 		if (err < 0) {
-			ieee80211_free_next_beacon(&sdata->deflink);
+			ieee80211_free_next_beacon(link_data);
 			return err;
 		}
 
@@ -3928,7 +3930,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->vif.bss_conf.color_change_active)
 		ieee80211_color_change_abort(sdata);
 
-	err = ieee80211_set_csa_beacon(sdata, params, &changed);
+	err = ieee80211_set_csa_beacon(&sdata->deflink, params, &changed);
 	if (err) {
 		ieee80211_link_unreserve_chanctx(&sdata->deflink);
 		goto out;
-- 
2.25.1


