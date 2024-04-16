Return-Path: <linux-wireless+bounces-6363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E5C8A62B2
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 07:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB361C2161B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 05:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5FC381DE;
	Tue, 16 Apr 2024 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GIS0eXG2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3A39ADB
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243622; cv=none; b=d024AgrIM78iBDCDu8gcaVetFWIjEno0u7veDqAIjvy/To1d46S8FttO3Ey+FZF+n+QdkZD2JBtVTnlJDBuZHHGfiXp9fnulEuxtPo3dEOdbPREYQcEfFYDZ20XfwCh+SYlvdEQqYRqxat+R5D7jFKlPXGypVbwF9XAH7ZOvWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243622; c=relaxed/simple;
	bh=uaQ3c8m+/A946TpD0YK6/MczE7fphtvTQIhyYcJg+KE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRN+uWjQedI5FpFWOzGYse5HJJQiAr3c0rVuz2VD8rOeoubWiMhMMuhrB7Hpw5Ppfrg2Mjno41WJexT0xhNNr3whELRVTZVQfHVm6DQ+lCa4dDQ+9uW1zr64coBs1V43PA168kfSWw4bwux+iL5dqJhVfkG/IsLvwBApyGlFVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GIS0eXG2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G01Nsw004728;
	Tue, 16 Apr 2024 05:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jT3Xv5Vc7uQ7izAgX+FvIryOPSI/RZA5PZRWEzBBOXI=; b=GI
	S0eXG2yMy4SEAovvnfkZII2rMcM1obzm4ByTVOTjZorE327chwyoItyeEeEv+TeQ
	0WP47jNDK5XvzdS7jS3ojOh4LviHlvr9YeA7bNKv0Z2Bnl5qzTwuEk6l3hQ80Em2
	t4TjjkjYofuctQckZVRHtdWlnZbNuykHp3REd9PkCht16FexhGNUuRCxK7Xo4wI4
	XPUTp69qo6ImqZ2tDVLCOjOCKAMa+WrAujwhBjRwnsCD2P/zIXWLHVaThbzWZi0E
	t3aFWuWXiRakYld3kNnD19z5/+QsGJm3P2k0amgYie7EuMkTFYoEJnq3IjzSos2P
	WIMWr9QXXoj2GhUI+NRg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhbburtn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G5075l025571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:00:07 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 22:00:05 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 3/7] wifi: mac80211: handle set color_change/after_color_change beacon on per link basis
Date: Tue, 16 Apr 2024 10:29:39 +0530
Message-ID: <20240416045943.576656-4-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qOPNt8TwBiug3pr7yCgIz4HTNVJbIjnr
X-Proofpoint-GUID: qOPNt8TwBiug3pr7yCgIz4HTNVJbIjnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160028

In order to support color change with MLO, there is a need to handle the
functions ieee80211_set_color_change_beacon() and
ieee80211_set_after_color_change_beacon() on a per link basis.

Implement this by making the function argument accept the link data
instead of the sdata.

Currently, deflink would only be passed. Proper link data will be passed in
a subsequent change.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f9374ce04c93..6e64c0740c81 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4662,20 +4662,22 @@ static int ieee80211_set_sar_specs(struct wiphy *wiphy,
 }
 
 static int
-ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
+ieee80211_set_after_color_change_beacon(struct ieee80211_link_data *link,
 					u64 *changed)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP: {
 		int ret;
 
-		if (!sdata->deflink.u.ap.next_beacon)
+		if (!link->u.ap.next_beacon)
 			return -EINVAL;
 
-		ret = ieee80211_assign_beacon(sdata, &sdata->deflink,
-					      sdata->deflink.u.ap.next_beacon,
+		ret = ieee80211_assign_beacon(sdata, link,
+					      link->u.ap.next_beacon,
 					      NULL, NULL, changed);
-		ieee80211_free_next_beacon(&sdata->deflink);
+		ieee80211_free_next_beacon(link);
 
 		if (ret < 0)
 			return ret;
@@ -4691,18 +4693,19 @@ ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 }
 
 static int
-ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
+ieee80211_set_color_change_beacon(struct ieee80211_link_data *link,
 				  struct cfg80211_color_change_settings *params,
 				  u64 *changed)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_color_change_settings color_change = {};
 	int err;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
-		sdata->deflink.u.ap.next_beacon =
+		link->u.ap.next_beacon =
 			cfg80211_beacon_dup(&params->beacon_next);
-		if (!sdata->deflink.u.ap.next_beacon)
+		if (!link->u.ap.next_beacon)
 			return -ENOMEM;
 
 		if (params->count <= 1)
@@ -4714,11 +4717,11 @@ ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 			params->counter_offset_presp;
 		color_change.count = params->count;
 
-		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
+		err = ieee80211_assign_beacon(sdata, link,
 					      &params->beacon_color_change,
 					      NULL, &color_change, changed);
 		if (err < 0) {
-			ieee80211_free_next_beacon(&sdata->deflink);
+			ieee80211_free_next_beacon(link);
 			return err;
 		}
 		break;
@@ -4766,7 +4769,7 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 
 	sdata->vif.bss_conf.color_change_active = false;
 
-	err = ieee80211_set_after_color_change_beacon(sdata, &changed);
+	err = ieee80211_set_after_color_change_beacon(&sdata->deflink, &changed);
 	if (err) {
 		cfg80211_color_change_aborted_notify(sdata->dev, 0);
 		return err;
@@ -4866,7 +4869,7 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
-	err = ieee80211_set_color_change_beacon(sdata, params, &changed);
+	err = ieee80211_set_color_change_beacon(&sdata->deflink, params, &changed);
 	if (err)
 		goto out;
 
-- 
2.25.1


