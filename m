Return-Path: <linux-wireless+bounces-12232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F6B965755
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECECF1C22CE9
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 06:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E12145FE5;
	Fri, 30 Aug 2024 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VyuFISjN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E114D6FC
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998184; cv=none; b=L3JNdTQFqjP8W5ugtC/Q7PpZVYHWDJXN6xVggjAttiQ6wryRbz4xCFgnClEV6kbNnavSHtLai36XnEPsdIRztv9Vyw3blwDRvXooEU8z0L9mjsK+bZcXqHf9FtJZD1T1t4Q0Ga/t9LoRlu3QtWpPq4X4vi5oVtUrrvFhu2ZCYuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998184; c=relaxed/simple;
	bh=ro+rmJp7eF+rhtuChD9dt2guwl1hshmu2MZylceZ7+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hti0LV2JOCjhNd4ggI+1KqpfRRDZN7PfX4X8ZSCIWb7SPOGf9s5uEh6KaPFc3UQe7Z+EAn38ZDaNlUdZ1dDLZNHf+UVUgXPmXgR1ZiXTD0yGSMPtiDq03DFlclmxWNJq97vifA3kh2BIYHQtpocnSnrS0M2Jw/ZzYH2rSk4Dldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VyuFISjN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TGtepJ023072;
	Fri, 30 Aug 2024 06:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8K6Cs7iasS8xugY9HCizwIeISSlLEmtr+HLzCFl0vxE=; b=VyuFISjNLbep+0xg
	mkVU4Al7+vG30TXh3kqM4VXOEyqlYgR0NeKo/rgMH3/XYUnvWa4WXWwNcWj3NO0/
	DOyqG3gjFZSmTBYU3hveDGEW2LHaD4PGpuOq7VpSFAUJUdCsIwBs9Q3p6GY4y8fb
	LBkpSpgM5kbyQwQmxV1fqFW5y54Ug9Yvmfot/4AwtIjqf9evfA8NL7Qy7fU9WGEN
	a5DIZH5Aq8iiyx/9QjNv1sG9gdBEZCRl6J+YbVmAi3xhJqTvuvKlfPQMh55nR/zC
	h8xxpxAjeysFIATQH7JBH1oZRDhkKfMHbsljpyOmzadc2647VxUBfxefIrs8pv5b
	6mvnhA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41a612nhs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 06:09:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U69cc8011707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 06:09:38 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 23:09:36 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v4 2/8] wifi: mac80211: remove label usage in ieee80211_start_radar_detection()
Date: Fri, 30 Aug 2024 11:39:12 +0530
Message-ID: <20240830060918.2418701-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830060918.2418701-1-quic_adisi@quicinc.com>
References: <20240830060918.2418701-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: u_uuGsjcCf-bkoKVV6wbwYrRxsOyBKgP
X-Proofpoint-ORIG-GUID: u_uuGsjcCf-bkoKVV6wbwYrRxsOyBKgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300043

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


