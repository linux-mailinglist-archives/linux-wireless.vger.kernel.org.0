Return-Path: <linux-wireless+bounces-9231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 445D490E23C
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 06:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BD21F23A03
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 04:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442076BFCA;
	Wed, 19 Jun 2024 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FLudy2Vq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCED755882
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770250; cv=none; b=cxPOzVM2r3RLly8dXbgBJiGxmmKkgL+aFvKjgjloUlxZo1MnIqkGtzg+AYdEXcuCp6oMxMT1KCVoQpUzsX4fJQC46RKqqMOAkfnXvomTpMioKrWNetYQmTv4SvbIB0gw5yzyN+ba11tZsQ9qg5BE+gy+zMVZD7r/ET5UnvQRuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770250; c=relaxed/simple;
	bh=YDLHKtCIPLrnk6kh4WzOWYZSpISXjaBgNI8IVrOMqkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulEPOPYnNX8EcLu47mpX1K/W3oVFxwcM975I+bshMDtqR6uqzKi0++G+304uTfFtp2gU10d+qg3ZAHQ3fZOOlWXwqxb1dQaZ5NJgYj4YjKq/SmIP/99VBQuoFM1fos5M0Jd7Lqroyl+XWRSPN4PQXkqG16nxrh4pCTgFfQlna/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FLudy2Vq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILcZGt009524;
	Wed, 19 Jun 2024 04:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y7nNMpzxRtRrWVVJATkbpBxyTIP2qgaf6ch4grZIH+Y=; b=FLudy2Vq9RSISqmK
	uvP3sbtvrEgEa6GN1Sc7yultsyQ2QwcN/U6FhyazzB25LSRQkn1U6yoh9boZQqcj
	9ILKAJFNLcSTAVZtkTNLLjdMpO9vNIGHtstJrOm9mqjc/yx1n9hL6JUBMLDUlBNI
	sOI6AsEvYZSmr+qqGocEqL43mFp01QhOeo9SnjUX4yxsWayzFE3je/xji093tTg/
	HvAU22j3AOFsRHF30KTKgICJMlZsls1+fHqW6z5bDIX/oVp8MDX98wyNMhlACnce
	a/1x1HDI3t1ur2t4OTdU/KLD6jol4maExJlgvbho+8an9AaKY7W8nyNU844I7FXj
	Wqnveg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yujag0k7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J4AhEn013863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:43 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 21:10:42 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 9/9] wifi: mac80211: abort active CAC while freeing the links during MLO
Date: Wed, 19 Jun 2024 09:39:59 +0530
Message-ID: <20240619040959.1457547-10-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619040959.1457547-1-quic_adisi@quicinc.com>
References: <20240619040959.1457547-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: DbgN5xWkqR4X6d-AsGtVj_gCBeyrMUM7
X-Proofpoint-ORIG-GUID: DbgN5xWkqR4X6d-AsGtVj_gCBeyrMUM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=984 impostorscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190029

If CAC is started and the interface is brought down, currently, CAC
started on link 0 is aborted in function ieee80211_do_stop(). Technically,
by the time execution reaches the above function, all links are already
teared down and hence link 0 (or deflink) alone is handled. Also, since
links are teared down, information on other links is also not available.
Hence there is a need to handle this in function ieee80211_free_links().

Add changes in ieee80211_free_links() function which cancels any scheduled
dfs_cac_timer_work on the link and if CAC is started, aborts it.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/link.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 8871cc1a0454..6c68887f051c 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -111,10 +111,32 @@ static void ieee80211_tear_down_links(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_free_links(struct ieee80211_sub_if_data *sdata,
 				 struct link_container **links)
 {
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_data *link_data;
+	struct cfg80211_chan_def chandef;
 	unsigned int link_id;
 
-	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		link_data = &links[link_id]->data;
+		link_conf = &links[link_id]->conf;
+
+		if (!link_data || !link_conf)
+			continue;
+
+		wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+					  &link_data->dfs_cac_timer_work);
+
+		if (sdata->wdev.links[link_id].cac_started) {
+			chandef = link_conf->chanreq.oper;
+			ieee80211_link_release_channel(link_data);
+			cfg80211_cac_event(sdata->dev,
+					   &chandef,
+					   NL80211_RADAR_CAC_ABORTED,
+					   GFP_KERNEL, link_id);
+		}
+
 		kfree(links[link_id]);
+	}
 }
 
 static int ieee80211_check_dup_link_addrs(struct ieee80211_sub_if_data *sdata)
-- 
2.34.1


