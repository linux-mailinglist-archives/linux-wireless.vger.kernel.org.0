Return-Path: <linux-wireless+bounces-2447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1951583AAEF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 14:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0779B2913C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72A77622;
	Wed, 24 Jan 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SfB7Dsf4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199477F0E
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102930; cv=none; b=iriLxU155lIyyRJtRsXNEZoJlWdvA4lUTWY741/JSkYzSEh/4O3T0m+uJuuhz/SWarKMWxmu35tWSTvWnD5bqF3LLLZfGD5Zip5efGsyxXGBKfVVp0ihbQ8TXfME+SYXL2AN8G1pg7eC3p7J6rLhp3rK97oz5u4cRaoxLLvO9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102930; c=relaxed/simple;
	bh=fveO+5H+lk3A8NyX42BprP3X6Ea6DGTHOvOCQQlrhu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMbN0ByECHaViYRQhpFjfIldkHE4zaSjru+iAlyQ3tSMXyaMdva5U2S+guJmPIP/4IlaBsjTMdEeDCcxtcr8odAEkedWW1lGyAQjAislzCFA4A3kupeGHOfPYqruqIQ2ns7c6QgtepPoGPjNIXtrTalmGb6kHm/9BPgYVSU2cQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SfB7Dsf4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OCaOYu016693;
	Wed, 24 Jan 2024 13:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=zDRhT/J+FtOUydChngJeg+g/jsUa70xFEFEH5O2dOfs=; b=Sf
	B7Dsf4wlbf+iroMBj7gYdIzYvVJuNM6f3LPp+o4neHvZzq8cmVVKyQodIa/wd7jv
	YCElWglqgV7HC5CtDp7QfqUOYQ/Mg14NQLFxRjoZ8ORyEhkNxcIbsKRYrMi2lUKb
	0kmFBctfz1DBmI2vl1kwoNdXaz6HTCRAZMjdJQhmBYou0N9K2C4RJNpylTUSi35m
	VZgDczOkcfnPWmIKuurOdljPAPp4JrgPi8XrZT9N9G7QB6gdaUNSDf26h0FHAbLt
	Wk7MMvjsvsLtEDmagx6Fs4fZ8/e/9MrJEWVCOrsPakLOOKHoNv8RL14HpqA/8DWR
	MmbCy1LACUxycWt7mZMQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtyf78h0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 13:28:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ODSixM010099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 13:28:44 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 05:28:42 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 3/3] wifi: mac80211: remove only own link stations during stop_ap
Date: Wed, 24 Jan 2024 18:58:14 +0530
Message-ID: <20240124132814.802018-4-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124132814.802018-1-quic_adisi@quicinc.com>
References: <20240124132814.802018-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: WnzqrPPuo5BvMk3ArbC-qHZGYrtkFSWs
X-Proofpoint-ORIG-GUID: WnzqrPPuo5BvMk3ArbC-qHZGYrtkFSWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=856
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240097

Currently, whenever AP link is brought down via ieee80211_stop_ap()
function, all stations connected to the sdata are flushed. However, in case
of MLO there is a requirement to flush only stations connected to that link
and not all.

For instance - Consider 2 GHz and 5 GHz are AP MLD. Now due to some reason
5 GHz link of this AP is going down (link removal or any other case). All
stations connected, even legacy stations connected to 2 GHz link AP would
also be flushed. Flushing of other link stations is wrong.

Fix this issue by passing self link ID to sta_flush() function. This would
then only remove the stations which are still using the passed link
ID as their link sta. Other stations will not be affected.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 26a8ea553401..968ceadd88a7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1618,7 +1618,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	link_conf->ema_ap = false;
 	link_conf->bssid_indicator = 0;
 
-	__sta_info_flush(sdata, true, -1);
+	__sta_info_flush(sdata, true, link_id);
 	ieee80211_free_keys(sdata, true);
 
 	link_conf->enable_beacon = false;
-- 
2.25.1


