Return-Path: <linux-wireless+bounces-6631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D92C8AC3BD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 07:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895CA1F22894
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEA518C38;
	Mon, 22 Apr 2024 05:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="klQ7ElEF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDF18AED
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 05:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764088; cv=none; b=jjYl7d79pAv3VqmTfTHDDIVYXDFxQcJfYA1vzYKR3K/V/9FKnO1+F+O1k0q/QmyZQgABy2lfMfMBKIf970ZvtGX93K4E5puLdzBVF1zM90P68I44cGfzH4eRLBxD+AsmvB34JlVDIOAtybKXDj7QfFoIoDEIDZRviRwpVou2a7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764088; c=relaxed/simple;
	bh=lFl9k+5aUsAVbKFNnEW5+HEPvjHbW551OLeR2904Ja4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsjqF0mVXV9A/GtsQNvUPOonpAYMgMPox0pIQbdecdP1PTcY07ZGlKW/qFa988R6DYLjA+yUjDakFRMbP4QLaAhcaFU7XcTaeg239NidUtUam65tE4NJjL0W3QWiulsiOticCxAs7fPdsDqo9TbrO4KCZgDU31aM2TMTjvTfW9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=klQ7ElEF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M4quxi024387;
	Mon, 22 Apr 2024 05:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jFCcSOQcwxDBXHLAYbZNnCLmLWWilFDa7gVoMb44tck=; b=kl
	Q7ElEF1diahdnStY9FwpBWI6gD+DU5hqhA4gCsndJ7N900IARa3IuHZal8sbcF49
	BnLBbeAK5lNyqYa9tDdOJ6mqagp8rl3En0UF+AcvKIV9qVSEOy4Z2FnVKK29x5dV
	dcTpwRdPeCaPBHHvL5RrvIJ1JtrVu+3avFVI08haeBeK3ah74HFcvBvbjKuCQAhh
	47Tis1x4eeq/D8FxQh14Yht73oWlR2sj3odTc2S+BiPQOKVCk8Rz3jEHmiYrkbQa
	mXSqA1Vzn27XSUImg2D3vkN+C2KzTMYTDxRPuRvY8SVphLt4Fs6u1pgHvlw4cimz
	vO+zJ+nnaPnhq4BjlWzQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xned0gbgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M5YdjL006268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:39 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Apr 2024 22:34:37 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 4/7] wifi: mac80211: handle color_change_abort and bss_config_notify on per link
Date: Mon, 22 Apr 2024 11:04:09 +0530
Message-ID: <20240422053412.2024075-5-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: rVz9hdRrQ4WejhFAHQnfiJZeaubp7Tfg
X-Proofpoint-GUID: rVz9hdRrQ4WejhFAHQnfiJZeaubp7Tfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_02,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404220025

With MLO, there is a requirement to handle functions
ieee80211_color_change_abort() and
ieee80211_color_change_bss_config_notify() on a per link basis.

Currently, deflink would only be passed. Proper link data will be passed in
a subsequent change.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 3ae7c409ac77..5339a8e884ac 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3918,13 +3918,13 @@ static int ieee80211_set_csa_beacon(struct ieee80211_link_data *link_data,
 	return 0;
 }
 
-static void ieee80211_color_change_abort(struct ieee80211_sub_if_data  *sdata)
+static void ieee80211_color_change_abort(struct ieee80211_link_data *link)
 {
-	sdata->vif.bss_conf.color_change_active = false;
+	link->conf->color_change_active = false;
 
-	ieee80211_free_next_beacon(&sdata->deflink);
+	ieee80211_free_next_beacon(link);
 
-	cfg80211_color_change_aborted_notify(sdata->dev, 0);
+	cfg80211_color_change_aborted_notify(link->sdata->dev, link->link_id);
 }
 
 static int
@@ -4008,7 +4008,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	/* if there is a color change in progress, abort it */
 	if (link_conf->color_change_active)
-		ieee80211_color_change_abort(sdata);
+		ieee80211_color_change_abort(link_data);
 
 	err = ieee80211_set_csa_beacon(link_data, params, &changed);
 	if (err) {
@@ -4737,16 +4737,18 @@ ieee80211_set_color_change_beacon(struct ieee80211_link_data *link,
 }
 
 static void
-ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
+ieee80211_color_change_bss_config_notify(struct ieee80211_link_data *link,
 					 u8 color, int enable, u64 changed)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	sdata->vif.bss_conf.he_bss_color.color = color;
-	sdata->vif.bss_conf.he_bss_color.enabled = enable;
+	link->conf->he_bss_color.color = color;
+	link->conf->he_bss_color.enabled = enable;
 	changed |= BSS_CHANGED_HE_BSS_COLOR;
 
-	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
+	ieee80211_link_info_change_notify(sdata, link, changed);
 
 	if (!sdata->vif.bss_conf.nontransmitted && sdata->vif.mbssid_tx_vif) {
 		struct ieee80211_sub_if_data *child;
@@ -4779,7 +4781,7 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 		return err;
 	}
 
-	ieee80211_color_change_bss_config_notify(sdata,
+	ieee80211_color_change_bss_config_notify(&sdata->deflink,
 						 sdata->vif.bss_conf.color_change_color,
 						 1, changed);
 	cfg80211_color_change_notify(sdata->dev, 0);
@@ -4883,7 +4885,7 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	cfg80211_color_change_started_notify(sdata->dev, params->count, 0);
 
 	if (changed)
-		ieee80211_color_change_bss_config_notify(sdata, 0, 0, changed);
+		ieee80211_color_change_bss_config_notify(&sdata->deflink, 0, 0, changed);
 	else
 		/* if the beacon didn't change, we can finalize immediately */
 		ieee80211_color_change_finalize(sdata);
-- 
2.34.1


