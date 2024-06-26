Return-Path: <linux-wireless+bounces-9577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656159177B0
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 06:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1AE281AA8
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 04:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CB313D255;
	Wed, 26 Jun 2024 04:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QL+9jWCH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0078E13CFBC
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 04:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719377580; cv=none; b=QyJCo5iP0+3nj8Hk818fZsRzVo9pessbuuS+rK0TJ5ZyhqJv9PfVHLLwIhK3p2+1CRJcg16i7ascBio+TlsOpXa550rhSVOD71ELcvc4EKuybU1YKMAaYA7LzbZjqu51JfHrhClfR1LXPCod6htMgPIJMLdNRte3lhqBmJxL/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719377580; c=relaxed/simple;
	bh=ec6D2OPAPvm6PtwW7MgUCusSSILtEVaHqNRT/JjmRnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjzGKYfjkVEcjh6WR4hKSKREGTXciUuRq3InHtre/CabzZWclutTLIDJh6FbnHkwDMXdol+1Guczb76Fa2UAKs0iaBVu60Qv3uPgaIZwDjJRizwSC63/RFc7ulfYP+g4MRbHjDQ2PAYm1VHNd8dp82i1tt0HyH4afdHCUtNoZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QL+9jWCH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PHIevV031603;
	Wed, 26 Jun 2024 04:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HIzjl5FUjx7GBqzKGS0eeB1MCamTi4xRWxQZi7C0me8=; b=QL+9jWCHmuU+qOdr
	o2Fs7LCea0z3l+zu85+tN3M7dzF8jojSM2LY96ywdvFX2wqXGc3GNvPL9iwABWZ1
	PALRYr4PwUmRoSwGZKVzFNJIlQs1p0kxPFWqlVugUaVHqD4C3/PhQPsaIBlCJrfv
	363j5XGLA2yeV+Vee+KJVY9nEEzMpwFebPuX/AUkt9IvAnGi+J4EQG/oJySVT4s+
	0Rv+ZKzNteqTVOzynGrAq3ksqPMpMci/y18g4zKaWXvZWwFZa6BHRxozSqpAeO7e
	lUxyJpyQyMieUKye0LfDfDIG9aWqMlE9fKuP5TfHFTEN9FS57ThTYtBfeNGQX8WO
	F2mgjQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywppv87x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 04:52:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q4qrmH014968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 04:52:53 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Jun 2024 21:52:52 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 6/9] wifi: mac80211: remove label usage in ieee80211_start_radar_detection()
Date: Wed, 26 Jun 2024 10:22:13 +0530
Message-ID: <20240626045216.3754013-7-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626045216.3754013-1-quic_adisi@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: gE5zDvpcRgCGPFydLURaqywXssD4q2-L
X-Proofpoint-ORIG-GUID: gE5zDvpcRgCGPFydLURaqywXssD4q2-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_02,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260035

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
index c2af768add96..f7c9d78f6f7d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3475,10 +3475,8 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!list_empty(&local->roc_list) || local->scanning) {
-		err = -EBUSY;
-		goto out_unlock;
-	}
+	if (!list_empty(&local->roc_list) || local->scanning)
+		return -EBUSY;
 
 	/* whatever, but channel contexts should not complain about that one */
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
@@ -3487,13 +3485,12 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
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


