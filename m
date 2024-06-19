Return-Path: <linux-wireless+bounces-9228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5CA90E238
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 06:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6CF1F23288
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 04:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49705466B;
	Wed, 19 Jun 2024 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KuWsrtAC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF6741C69
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770243; cv=none; b=d1mPBkXg07IZeGuF/kk2fNrhsHyc6FvhewYzrAUi+yKF0TEj34Ved1rgkl2lSmHIxLjIX+36l3aNXIRpgF9T/1ofO5gYIj/Yl0HXQdHYZ/6WmBplYyXE8cLXMIOnHNrBKddqf9ZHQb6BYJMp0CnNMjRngTcppqhfRVh1rBYByOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770243; c=relaxed/simple;
	bh=PhmKTGrPCh+Hd2UvmxGPMy4Hf+9muQAX4p1A+sQaufY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P14wlB+idHoOomOodKaeINwoh2J/ce6LL3HiEpCwLMKqGdY+8O0PYQGxQPyg0RWQURGIrp+7PtpAtGJ/phODZoSARr3xC5roM9bZ8E3X2RgP6vRJ4bhYj4b5/KKrWMPpz3xdxr7XHUBFBknmyt1zFYYF9/MPiMWw5gRVA7H0fWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KuWsrtAC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILaB4A006182;
	Wed, 19 Jun 2024 04:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SdqvF7iIvNXlSn2pjemToDlDeU2XCB99QSrBCfu8TW0=; b=KuWsrtACV6LR2rxl
	VmGxzea3qyKM9lgYclnK4p5CEYZhDuzpKhUF4Keg2i/pVFyKZSA8svGkzpiiNHLa
	zCDwzOyn0LwDM3lNHiHFmOXG/gCpvwEGeJNaAjDdQA8hLdNd7W8oc5eEZSoUQJFX
	S1d2tG9paU1ziNXM2kXb2WRNIUvedd3kPfAhKUI+HJBwfk0NmPUs1mWTO400fzHr
	S+6TNTTs4YYU/A2PSZ56Dt7J6xcrf0a1r3o80dIdKdAJJGDpC6sCkZaPTcqTj+o8
	Vl0p8GXkHCzZNhLkre8fiXmmIPVhihEZf/hR//KbKM8sMUg9K+4cK118wBFfaVGZ
	VuxXzQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9u0ksy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J4AbCa025007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:37 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 21:10:36 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 6/9] wifi: mac80211: fix label name in ieee80211_start_radar_detection()
Date: Wed, 19 Jun 2024 09:39:56 +0530
Message-ID: <20240619040959.1457547-7-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: yY_-q92ifx6cxI_W1A0h4weF0rk-jBMm
X-Proofpoint-ORIG-GUID: yY_-q92ifx6cxI_W1A0h4weF0rk-jBMm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_01,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190029

After locks rework [1], ieee80211_start_radar_detection() function is no
longer acquiring any lock as such explicitly. Hence, it is not unlocking
anything as well. However, label "out_unlock" is still used which creates
confusion.

Rename the label to "return_err".

[1]: https://lore.kernel.org/all/20230828135928.b1c6efffe9ad.I4aec875e25abc9ef0b5ad1e70b5747fd483fbd3c@changeid/

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c2af768add96..b2cd43d807ed 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3477,7 +3477,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 
 	if (!list_empty(&local->roc_list) || local->scanning) {
 		err = -EBUSY;
-		goto out_unlock;
+		goto return_err;
 	}
 
 	/* whatever, but channel contexts should not complain about that one */
@@ -3487,12 +3487,12 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	err = ieee80211_link_use_channel(&sdata->deflink, &chanreq,
 					 IEEE80211_CHANCTX_SHARED);
 	if (err)
-		goto out_unlock;
+		goto return_err;
 
 	wiphy_delayed_work_queue(wiphy, &sdata->deflink.dfs_cac_timer_work,
 				 msecs_to_jiffies(cac_time_ms));
 
- out_unlock:
+ return_err:
 	return err;
 }
 
-- 
2.34.1


