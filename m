Return-Path: <linux-wireless+bounces-12582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4396EADE
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 08:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66903B21765
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9134E1428F3;
	Fri,  6 Sep 2024 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GAyJvbz+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C314883B
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605099; cv=none; b=X2hNS+rBK/6AEoeSfIK9h1fp29s1J5TIYoMiyuYd2bcmlFz2CrXw8vwoTl3FQ+Thp8mwu4Rv3xnVHrYq9Xv8uOCu6xstaOJ3hRO+4pZYqjokOSuIFBK6K7AIJAzntBa2xbybbOVlysCskxKp5AutgLM1zOMMfnLL/yC1FfbEWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605099; c=relaxed/simple;
	bh=UsRhyh+1VD6mMn8WwL15Cg+YbLyU97DWJTPOqqg2Uug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QREOPVkuO0MVAieoQLwBsG80BA1N2Hq3k/IfaDxkUcBs5eBpVO6i0oqlBLpsf7KfQ0qPkaVa5NGikGoyCRI7Yww2wWM9dsTqBcyfaiUsOBakPtWCK3jlu3w1TXofSodWAfszbKsFCmVmxTUaYW33qxavlh3Sg9pEZkvMLQede/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GAyJvbz+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQN9D001325;
	Fri, 6 Sep 2024 06:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BhvKq00tcHB1UfhacOUb/WMVNYzPWjwTd4kJAXJNKt4=; b=GAyJvbz+UU5QDUy2
	P5RbiVx59tRpuisDoNAYleajqUGSBpwS0u2686gqAKf9D/QgLoD/bEJX18q5GhmD
	42KJugmyvIH+zbDSB6V3ImIq+wiKBhdIeCv17R+hs93JE+XSWhmYml4FGgCueitT
	V4yYaSSvjaGokJEsjeLusJq9nYFSLu3kAGPoaKwJNPcx8jWkEUsO6M9/LIftW3ry
	PJuVYWAmnfAoy/E2yZ5u+EqgzbHt+vnrnWffVRZbM9UMz3KPV2vszCvLqA63pONn
	CnQwyg+uHZLftbX4xnqwFIHqQ6mmLQV0B4Z1IBYIB4ysQKhqym7e4Hb/fYBY0Mg6
	M8TObg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwt9chw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 06:44:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4866ilxi007254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 06:44:47 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Sep 2024 23:44:46 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v6 2/8] wifi: mac80211: remove label usage in ieee80211_start_radar_detection()
Date: Fri, 6 Sep 2024 12:14:20 +0530
Message-ID: <20240906064426.2101315-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906064426.2101315-1-quic_adisi@quicinc.com>
References: <20240906064426.2101315-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: GKCiLKRB0vO0hnuUha9zvwjOxwS74jk_
X-Proofpoint-ORIG-GUID: GKCiLKRB0vO0hnuUha9zvwjOxwS74jk_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409060048

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
index 184e9d54064b..d3115be54997 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3471,10 +3471,8 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!list_empty(&local->roc_list) || local->scanning) {
-		err = -EBUSY;
-		goto out_unlock;
-	}
+	if (!list_empty(&local->roc_list) || local->scanning)
+		return -EBUSY;
 
 	/* whatever, but channel contexts should not complain about that one */
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
@@ -3483,13 +3481,12 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
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


