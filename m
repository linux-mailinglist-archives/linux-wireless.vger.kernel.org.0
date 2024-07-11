Return-Path: <linux-wireless+bounces-10174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B592DEEE
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 05:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BA0283EF5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 03:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B055374DD;
	Thu, 11 Jul 2024 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FLmqpWmw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC59C1A28B
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 03:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669941; cv=none; b=NOmDL8rR7Ggf5ZYL3wx3mN8uM+j4iPEplQbwZhl1FtoeVOJrrWvGK3xVYsbKeP4UolVzV7VwVPNJCUM0eaK6C2V2xiYZ2k34nTNAhCzUAkgZX9dG7TtoDzqZsCpjd/cjxEU01x8TDJzYx4SLdA8Rf6prIPhwrDVg5td+58ooFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669941; c=relaxed/simple;
	bh=ro+rmJp7eF+rhtuChD9dt2guwl1hshmu2MZylceZ7+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2x+pG8dFIla0wWPshVOwI4OwB2IeYRIqT6xCE71dFBDYXnO3n2QrUjN+hcQp6tvle4WF0gdKpozGigIFdn8cElD2f3fdGj775gmAXhv1+4vX4rnpXKiLurOA/VDbzkNZZieowbRdtX9JzF5xC6KYqd671099Y8dQ1IX/aNhqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FLmqpWmw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B33cpg001053;
	Thu, 11 Jul 2024 03:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8K6Cs7iasS8xugY9HCizwIeISSlLEmtr+HLzCFl0vxE=; b=FLmqpWmwHbdF6E/5
	e4xpfXZ43KBJMqVe7QxXYArovOBmMHJqZHDF/hPwTx1GphM2x0YRUQgMZW9Ns199
	TpzHrC1MmeYASaJdkS0K1MEDIwf0aFqDF6zX00ZoWax5gDe70ABpp4cnyrtC7vuM
	rLW8JMV3/EvoMIdbpgxDxblWzyJK9Rfg99eowXxn/r3HOqRMZ0i6G8KEvFuoHYFq
	Iskrup0J6YKMiM29tTxmXNlLV0a8aqD4rQ1YAZ/nJtiCJZFSIPNv7lp0D4rQgZYp
	rKS2ZeYgcxQ7t0bTZvPjYN7jcmm+/5TLOPZ632nTuCkdPCVCgEykvBM4OlKkYOdt
	U0ha2Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwu61g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 03:52:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46B3qDXU002356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 03:52:13 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 20:52:12 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v3 2/8] wifi: mac80211: remove label usage in ieee80211_start_radar_detection()
Date: Thu, 11 Jul 2024 09:21:41 +0530
Message-ID: <20240711035147.1896538-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711035147.1896538-1-quic_adisi@quicinc.com>
References: <20240711035147.1896538-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: PkG6nEeIb8RqFpxSkVcVHI2IS2JxOqnG
X-Proofpoint-ORIG-GUID: PkG6nEeIb8RqFpxSkVcVHI2IS2JxOqnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_20,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110024

After locks rework [1], ieee80211_start_radar_detection() function is no
longer acquiring any lock as such explicitly. Hence, it is not unlocking
anything as well. However, label "out_unlock" is still used which creates
confusion. Also, now there is no need of goto label as such.

Get rid of the goto logic and use direct return statements.

[1]: https://lore.kernel.org/all/20230828135928.b1c6efffe9ad.I4aec875e25abc9ef0b5ad1e70b5747fd483fbd3c@changeid/

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8b4f32c01701..363dc33103d6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3468,10 +3468,8 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!list_empty(&local->roc_list) || local->scanning) {
-		err = -EBUSY;
-		goto out_unlock;
-	}
+	if (!list_empty(&local->roc_list) || local->scanning)
+		return -EBUSY;
 
 	/* whatever, but channel contexts should not complain about that one */
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
@@ -3480,13 +3478,12 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	err = ieee80211_link_use_channel(&sdata->deflink, &chanreq,
 					 IEEE80211_CHANCTX_SHARED);
 	if (err)
-		goto out_unlock;
+		return err;
 
 	wiphy_delayed_work_queue(wiphy, &sdata->deflink.dfs_cac_timer_work,
 				 msecs_to_jiffies(cac_time_ms));
 
- out_unlock:
-	return err;
+	return 0;
 }
 
 static void ieee80211_end_cac(struct wiphy *wiphy,
-- 
2.34.1


