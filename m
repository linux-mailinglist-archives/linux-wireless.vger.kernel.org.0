Return-Path: <linux-wireless+bounces-4047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCB286882E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 05:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7304D1C21E09
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 04:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483C34D9E3;
	Tue, 27 Feb 2024 04:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CYtTX+ZO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D114134BC
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 04:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007801; cv=none; b=foXV9v7bqvk0rMG5iItAxfYHfG8buKSZKFqEikqip+tzGpyL7BRdA8EurZjpUMrVKXKCZBA2EcZ+NI22PxMku0v8OWx6ES7sZ3Z8ssX7/Vn8kcijJ2WETaosBNSF6mGLcZLEoiMoLedmMDrrIfVgdc9sxlarjiTbo+61aDIxiz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007801; c=relaxed/simple;
	bh=xj+ZAvrSQUrEUtsoWTPtNEvVYS24U/CC/aOVLT50NY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8pdJlnzFNpXyH3fUgF+BFF1BMVv/slrSXx/m/sfIz0mLQkRa0uT+xHVI3HhUM/M5xo73H6uK3nJ8/uMIi9fPaSbxoUtpAA1ZfgvnGTWpYJrPgdiwV9M2DarXnJwPrBmsxb+KWUVGNJG1Vxzq+4GQOwIW8MzlADGoNb3rOCYsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CYtTX+ZO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R3vgYI022382;
	Tue, 27 Feb 2024 04:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=RoQJcaxshTkaSe8rlUNCZet6XqNIosatJpiv1LYeJFc=; b=CY
	tTX+ZOlc3eap3WS3uqY8pQOJwUXPHh47x/6S+Vojk0tczmCQUtfcd1qIkzjImUAl
	6dRKBBg5LPmgsn3Cih5F0Lb0RA0+Ag0eLDbR4MnkKZv5ZViuN3TLQzCveqrI61Wh
	g4C+JPM8794ccE3+UZq7gjlRfGRNVVkzT94Mti3iHgT8+wT6vkuLxBomztTFIza5
	wWR3aZYGP85nkFg/w0Hv8UHbL9/WRK/TRlt4LnX41nnuSqi3h5PPMLtVUAb+bup0
	hcPKaQ+E5wmPM7aQK5+tIJyhGRuUR3H95yefOgmmpDYnSlNxeJMDDXF/7T62xsFY
	pjqRo5FhLdS55QgeJO2w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh89t01th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 04:23:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R4ND1L026014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 04:23:13 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 20:23:11 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 1/2] wifi: mac80211: remove only link keys during stopping link AP
Date: Tue, 27 Feb 2024 09:52:50 +0530
Message-ID: <20240227042251.1511122-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227042251.1511122-1-quic_adisi@quicinc.com>
References: <20240227042251.1511122-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: w_-CpQsFB-4luMnAkYoCr-a3tnKbzjQn
X-Proofpoint-GUID: w_-CpQsFB-4luMnAkYoCr-a3tnKbzjQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270033

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Currently while stopping a link AP, all keys from the interface were
removed. However with MLO there is a requirement to free only the link
keys.

Add changes to remove keys which are associated with the link AP which is
going to be stopped.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0744113f3535..9989f4a6c0ff 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1563,6 +1563,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_link_data *link =
 		sdata_dereference(sdata->link[link_id], sdata);
 	struct ieee80211_bss_conf *link_conf = link->conf;
+	LIST_HEAD(keys);
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1617,7 +1618,12 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	link_conf->bssid_indicator = 0;
 
 	__sta_info_flush(sdata, true, link_id);
-	ieee80211_free_keys(sdata, true);
+
+	ieee80211_remove_link_keys(link, &keys);
+	if (!list_empty(&keys)) {
+		synchronize_net();
+		ieee80211_free_key_list(local, &keys);
+	}
 
 	link_conf->enable_beacon = false;
 	sdata->beacon_rate_set = false;
-- 
2.25.1


