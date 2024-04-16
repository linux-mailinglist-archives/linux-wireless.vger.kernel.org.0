Return-Path: <linux-wireless+bounces-6367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A238A62B6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 07:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A807282D24
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 05:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8BF3A268;
	Tue, 16 Apr 2024 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gbfITn88"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28AA3A1AC
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 05:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243625; cv=none; b=TRHiLuqJ8YiowuQr6SNF2qTxb7nzNLPzQn8+YZm5v6GcfPBbMwV1W2dICFjIemPh6BgRvoKRuCTxRxVfxuBgaSBUu1Rpaal36cS/teWnGUMZqTAyF7m+vi+CHMrK+OB/MSif2j+UakQqqb7q8VLnQvki3znbd+e/LAJ4D+aVx88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243625; c=relaxed/simple;
	bh=sn0C49qWEPziUiP09q7lhC5Vlg3tMRsyvBG4QlBa8Sk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ee4FnIxZB6A/CNEuvm+2iPFYbax6lrurALa2bhKyGDvgqqlHOxHOC20U1uenCeopCmqYTH3Yy9sG9ucGZPqIgKMWSk+YNGRBG0C0pu0xDjQeNzkrTahn8aV8aSYJGsQHTSOey3ITEp0hBI6ECiJMdZvB1ZXs6CTdnXRWDmrfv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gbfITn88; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G4FNS4030882;
	Tue, 16 Apr 2024 05:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=eDepNZ/gxlFiWL+HFoSAn7znI/oGXpIjU5ZoVtBBpGs=; b=gb
	fITn888rhlq0IzBoIWAnJxTTZoZ2kKkYhUop7CBM0u37SPGbdlX0lf5nTiv/2qHd
	QP53F5JmEEWgx2FyQcLV+8lnmFIHDTRrGl5n3mbgQtuE6yw/ULitxp6T0zojdaox
	u+8/8AbpVTSK5r66z76w43NtNCfITHDzDDZ8j/mZZd1YxQKPsaB8samRwZ4q9DeA
	2/Y5WvPjZ/hnk93y2sFzIqGKDAVCwhfkcuif04wGGdDgUk8DC+HNDTTg0Eg75Wse
	cuQG242IhCVSKB0rv2V2+LQn9a0YAR+/VxcWUHGYQ55zh5h9pnqC/1eINQXmdgbp
	Q4QLunAVGSvn2kFQ7z3g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhj4mr2g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G508Gq011903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:09 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 22:00:07 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 4/7] wifi: mac80211: handle color_change_abort and bss_config_notify on per link
Date: Tue, 16 Apr 2024 10:29:40 +0530
Message-ID: <20240416045943.576656-5-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: rtyQ0KG9kD_NhGwphcNmfklLC0PflPHu
X-Proofpoint-ORIG-GUID: rtyQ0KG9kD_NhGwphcNmfklLC0PflPHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160028

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
index 6e64c0740c81..13cf4c0f3030 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3914,13 +3914,13 @@ static int ieee80211_set_csa_beacon(struct ieee80211_link_data *link_data,
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
@@ -4004,7 +4004,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	/* if there is a color change in progress, abort it */
 	if (link_conf->color_change_active)
-		ieee80211_color_change_abort(sdata);
+		ieee80211_color_change_abort(link_data);
 
 	err = ieee80211_set_csa_beacon(link_data, params, &changed);
 	if (err) {
@@ -4733,16 +4733,18 @@ ieee80211_set_color_change_beacon(struct ieee80211_link_data *link,
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
@@ -4775,7 +4777,7 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 		return err;
 	}
 
-	ieee80211_color_change_bss_config_notify(sdata,
+	ieee80211_color_change_bss_config_notify(&sdata->deflink,
 						 sdata->vif.bss_conf.color_change_color,
 						 1, changed);
 	cfg80211_color_change_notify(sdata->dev, 0);
@@ -4879,7 +4881,7 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	cfg80211_color_change_started_notify(sdata->dev, params->count, 0);
 
 	if (changed)
-		ieee80211_color_change_bss_config_notify(sdata, 0, 0, changed);
+		ieee80211_color_change_bss_config_notify(&sdata->deflink, 0, 0, changed);
 	else
 		/* if the beacon didn't change, we can finalize immediately */
 		ieee80211_color_change_finalize(sdata);
-- 
2.25.1


