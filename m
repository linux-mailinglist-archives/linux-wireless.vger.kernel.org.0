Return-Path: <linux-wireless+bounces-13350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2921298B2E6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 06:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE13A2822BE
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 04:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EF81B3742;
	Tue,  1 Oct 2024 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C65A70yV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BE1A59
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 04:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727756176; cv=none; b=sfhMdBowKaoYPxVTlAUf1Ud9EI3UEUeXBfAMXbd9o8Is4GQEIZDnVYe15o/X/Yl3rZX4VDU/c6PBNT1fvJ3r7vjEGTObzH88k4wFOJv5SBjgFEJeEHm7fNk9cjTKXu1MMTLKAEJbEL1b6dFe24vXEYM6AKW8n+kxf4KjwvjyNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727756176; c=relaxed/simple;
	bh=Bp26ZtQmoUtjQmkl/QGXBkkmh6iQFXkEDIMbUb+dzjE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Smyc8b2nzwmj6tPm9OZsZwq3lsX/FAysOWu45JawQg0+DTOPFbsXCHXFgGBncVrpLI7SM3TZWGMRPP0cP4TDGEEL3mKxZxS/UmOfH6990E9zWFEHJiNluB0sI4Eb6EWhItcsnWABQjyUJaBzZ0s5TVV6tTLLL3uTsGSb2+5jmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C65A70yV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UMU7jC018290;
	Tue, 1 Oct 2024 04:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pOAg6CghdZ8jVcFP9juOoz
	uVc21VeFryg9IVCz5IDkA=; b=C65A70yVZlrQ3xPUzFXu74pLbnNdrc4vtP3xmc
	CAbpcQhkSnPy1Uovi93vTA2M0yeggHn6RIwBtmbu+QitCPdECwZ21WICRILkdX6c
	oPQaeybY3szX6NQ9yHxeN0EtONbDY5bIkUva9XgbQ2EVHeHwfZNk/hm0CX7+tfFn
	bUNG5/wMtJS3a2GtNtAhhldLwhxiCMD74Da5AlRF1jyHG64JSz5Vwl98KJ1ir8jR
	DIAkkGs49l+KF57DVVls6TCRqDjFGTYvIrQi/l+JdbQVFdYK15SkApklS+yDhwL/
	4KAq9LyfPAGdYG3WvCbYo8nhnggGRbAQRMhB58dZmeX2sYdg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x8t6q017-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 04:16:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4914G3vA008426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 04:16:03 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 30 Sep 2024 21:16:01 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Aditya
 Kumar Singh" <quic_adisi@quicinc.com>
Subject: [PATCH] wifi: mac80211: fix assigning channel in activate links
Date: Tue, 1 Oct 2024 09:45:18 +0530
Message-ID: <20241001041518.2236297-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: aHd-icj-y_ucmgh5IdT1amjxjN8dEUOC
X-Proofpoint-ORIG-GUID: aHd-icj-y_ucmgh5IdT1amjxjN8dEUOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010027

The current flow in _ieee80211_set_active_links() does not align with the
operational requirements of drivers that groups multiple hardware
under a single wiphy. These drivers (e.g ath12k) rely on channel
assignment to determine the appropriate hardware for each link. Without
this, the drivers cannot correctly establish the link interface.

Currently in _ieee80211_set_active_links(), after calling
drv_change_vif_links() on the driver, the state of all connected stations
is updated via drv_change_sta_links(). This is followed by handling keys
in the links, and finally, assigning the channel to the links.
Consequently, drv_change_sta_links() prompts drivers to create the station
entry at their level and within their firmware. However, since channels
have not yet been assigned to links at this stage, drivers have not
created the necessary link interface for establishing link stations,
leading to failures in activating the links.

Therefore, modify the logic so that after drv_change_vif_links(), channels
are assigned to all links. Following this, the flow should proceed to
station handling.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/link.c | 89 ++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 0bbac64d5fa0..38c496cb28fa 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -363,6 +363,53 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_data *link;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+
+		/*
+		 * This call really should not fail. Unfortunately, it appears
+		 * that this may happen occasionally with some drivers. Should
+		 * it happen, we are stuck in a bad place as going backwards is
+		 * not really feasible.
+		 *
+		 * So lets just tell link_use_channel that it must not fail to
+		 * assign the channel context (from mac80211's perspective) and
+		 * assume the driver is going to trigger a recovery flow if it
+		 * had a failure.
+		 * That really is not great nor guaranteed to work. But at least
+		 * the internal mac80211 state remains consistent and there is
+		 * a chance that we can recover.
+		 */
+		ret = _ieee80211_link_use_channel(link,
+						  &link->conf->chanreq,
+						  IEEE80211_CHANCTX_SHARED,
+						  true);
+		WARN_ON_ONCE(ret);
+
+		/*
+		 * inform about the link info changed parameters after all
+		 * stations are also added
+		 */
+		ieee80211_mgd_set_link_qos_params(link);
+		ieee80211_link_info_change_notify(sdata, link,
+						  BSS_CHANGED_ERP_CTS_PROT |
+						  BSS_CHANGED_ERP_PREAMBLE |
+						  BSS_CHANGED_ERP_SLOT |
+						  BSS_CHANGED_HT |
+						  BSS_CHANGED_BASIC_RATES |
+						  BSS_CHANGED_BSSID |
+						  BSS_CHANGED_CQM |
+						  BSS_CHANGED_QOS |
+						  BSS_CHANGED_TXPOWER |
+						  BSS_CHANGED_BANDWIDTH |
+						  BSS_CHANGED_TWT |
+						  BSS_CHANGED_HE_OBSS_PD |
+						  BSS_CHANGED_HE_BSS_COLOR);
+
+	}
+
 	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_link_data *link;
 
@@ -423,48 +470,6 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 		__ieee80211_sta_recalc_aggregates(sta, active_links);
 	}
 
-	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_link_data *link;
-
-		link = sdata_dereference(sdata->link[link_id], sdata);
-
-		/*
-		 * This call really should not fail. Unfortunately, it appears
-		 * that this may happen occasionally with some drivers. Should
-		 * it happen, we are stuck in a bad place as going backwards is
-		 * not really feasible.
-		 *
-		 * So lets just tell link_use_channel that it must not fail to
-		 * assign the channel context (from mac80211's perspective) and
-		 * assume the driver is going to trigger a recovery flow if it
-		 * had a failure.
-		 * That really is not great nor guaranteed to work. But at least
-		 * the internal mac80211 state remains consistent and there is
-		 * a chance that we can recover.
-		 */
-		ret = _ieee80211_link_use_channel(link,
-						  &link->conf->chanreq,
-						  IEEE80211_CHANCTX_SHARED,
-						  true);
-		WARN_ON_ONCE(ret);
-
-		ieee80211_mgd_set_link_qos_params(link);
-		ieee80211_link_info_change_notify(sdata, link,
-						  BSS_CHANGED_ERP_CTS_PROT |
-						  BSS_CHANGED_ERP_PREAMBLE |
-						  BSS_CHANGED_ERP_SLOT |
-						  BSS_CHANGED_HT |
-						  BSS_CHANGED_BASIC_RATES |
-						  BSS_CHANGED_BSSID |
-						  BSS_CHANGED_CQM |
-						  BSS_CHANGED_QOS |
-						  BSS_CHANGED_TXPOWER |
-						  BSS_CHANGED_BANDWIDTH |
-						  BSS_CHANGED_TWT |
-						  BSS_CHANGED_HE_OBSS_PD |
-						  BSS_CHANGED_HE_BSS_COLOR);
-	}
-
 	old_active = sdata->vif.active_links;
 	sdata->vif.active_links = active_links;
 

base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
-- 
2.34.1


