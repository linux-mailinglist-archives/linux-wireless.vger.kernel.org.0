Return-Path: <linux-wireless+bounces-12312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C39967FAD
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961111C21B86
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 06:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E6E155CA8;
	Mon,  2 Sep 2024 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UsQg+VzA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26C15688E
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259756; cv=none; b=H958ch/KwnTVw+u2Ae3WK+FbqCvuHSAcqfZQzp718CvrJdHhTHEn9wws/OsQMpy2obhYHRvOM2xQc4CfBzsnP36Ht3rADk9NrAbhnoeOM7XCs7MTO+K/cWMHSENmhAAVrvpctmN5MWy9uKCoBWaNQnw6QBfaMiSkKi4l9xl2sDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259756; c=relaxed/simple;
	bh=ro+rmJp7eF+rhtuChD9dt2guwl1hshmu2MZylceZ7+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VthQI7u1p2BbonCff50iROgdM+7QN5LNl590zvh24fPyCtISqsw3fsRSSKjMdvTnFOWmizvMIHP0OsBwlh77eCQ3JCYz41hN3hKj0B+SXm+RO1y45RO4rjT6a84ikj6o3KgjUVRDQ9qvT1zjbH4pgsAhlLFV7FCcw8aBdNJm00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UsQg+VzA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48200Sxl031827;
	Mon, 2 Sep 2024 06:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8K6Cs7iasS8xugY9HCizwIeISSlLEmtr+HLzCFl0vxE=; b=UsQg+VzAf2NnE7yX
	BNKdw5lRdFk0WXiJNceUJuYJbGxEyad3vLAJ8X6h6TgtLnyNtqzHv9StQO1zj8IN
	A0t9ro56FjwCAti9fil3xhrPEcR+/JRmWRRSlQMEjTRDAiw9e1BjWSwvOOwqpLkQ
	hIES2B3mJ8Vrb3nPhY72a++4XfnI20Befrcrv3EV4c1xPK81xSUZWO6GEQKAqDB1
	6yKIInQ/KurKbyO41R8oZDa6mYXvMlnbdlR599tbt6mtaz1h/RSNV/h8syeqrbVy
	7veNklMydu0/DGTeMLMXS6IQCEYTnlWRzqhcgI/PmP/DReYnJBfsGu5BSqFCm4aX
	zMGxNw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41brveuwuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 06:49:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4826n9OB028198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Sep 2024 06:49:09 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 1 Sep 2024 23:49:07 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v5 2/8] wifi: mac80211: remove label usage in ieee80211_start_radar_detection()
Date: Mon, 2 Sep 2024 12:18:41 +0530
Message-ID: <20240902064847.2506090-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902064847.2506090-1-quic_adisi@quicinc.com>
References: <20240902064847.2506090-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: qg_k5gQf0oHXPm1BHbrWF_ynA3nVE-o7
X-Proofpoint-ORIG-GUID: qg_k5gQf0oHXPm1BHbrWF_ynA3nVE-o7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-01_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409020054

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


