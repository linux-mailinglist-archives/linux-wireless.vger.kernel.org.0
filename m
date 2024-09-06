Return-Path: <linux-wireless+bounces-12581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA696EADD
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 08:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC2A1C214DC
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 06:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7FE13D243;
	Fri,  6 Sep 2024 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ohC+gFN5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CCB13E3EF
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605097; cv=none; b=dUIJjAsTn9frY3FsoJvQx9eYNuLXLMsUh1ZK9HLdBiRQITcwt4LvhrbAXDAk+oy56WVPjjfJkJENGZbG3egbBlOuFqI0QeKCESWWpfczZc/uXeVtkwLMP3kNsJjPFz7uKV2pMcJWUFES6zZIq3PMiGyH57LcJO/dgb8xXwwvRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605097; c=relaxed/simple;
	bh=zkLAkb1nTfqNgGdJtc1gUbkky9UrsB/ORpd3FP0TySs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6faN3JL/IQHN9u2+E/irw+3riTeACgn6whlbkeOuLqCvR2gggXwftlRo7sWlS41pIUttl9OIXXu4+AhLSMyLwPsB6f5eDO9EU2c7GkceJ95kA78FyysebemepsqfXW8acn3sAKB0kgbiS3wxHdKWTZQle2r2LqxErLD8gF9lW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ohC+gFN5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IR1Gq029920;
	Fri, 6 Sep 2024 06:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vyydDZF4diJD/3AJVLQuRvbHf/UWvXyuKC1a0l/Qgus=; b=ohC+gFN51GY0b43w
	onjPQvK9UEPkyZ657yP/x+wPOJEmEYm6NEzmd4XGAvdhl7ECR1w2OmeRMTRpqjUC
	7K5SmY1eoanMO2kCiRrT0799a3ue7h0EBOBtpoUHtKHgdmxIhd08uNMzN8VNrg4m
	CzIIHeLAY2u6PZVzh9uqi/36/IMp0lCQvWRksY52l/sLt1tZJ2xpcvO/YyY+3Xgb
	kzHOGerU9eItyGL0Zc8C1/A0a7xlDko/Q5/jU5iHBZUxjt+7dueL5Ih839rDbnsP
	xmouhLpvq+kNzqH8P9xeHb9tme0/ZOJDu7OeGc6OMnxnms2quGnhe/TZptfJsHOi
	miBeQw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwu1bm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 06:44:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4866inBP020345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 06:44:49 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Sep 2024 23:44:47 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v6 3/8] wifi: trace: unlink rdev_end_cac trace event from wiphy_netdev_evt class
Date: Fri, 6 Sep 2024 12:14:21 +0530
Message-ID: <20240906064426.2101315-4-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 5YpXlR-09FKNGIOP6kdf8RKheT3XS-lX
X-Proofpoint-GUID: 5YpXlR-09FKNGIOP6kdf8RKheT3XS-lX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=789 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060048

rdev_end_cac trace event is linked with wiphy_netdev_evt event class.
There is no option to pass link ID currently to wiphy_netdev_evt class.
A subsequent change would pass link ID to rdev_end_cac event and hence
it can no longer derive the event class from wiphy_netdev_evt.

Therefore, unlink rdev_end_cac event from wiphy_netdev_evt and define it's
own independent trace event. Link ID would be passed in subsequent change.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/wireless/trace.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 5c26f065bd68..7fc7de9bcc34 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -805,9 +805,18 @@ DEFINE_EVENT(wiphy_netdev_evt, rdev_flush_pmksa,
 	TP_ARGS(wiphy, netdev)
 );
 
-DEFINE_EVENT(wiphy_netdev_evt, rdev_end_cac,
-	     TP_PROTO(struct wiphy *wiphy, struct net_device *netdev),
-	     TP_ARGS(wiphy, netdev)
+TRACE_EVENT(rdev_end_cac,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev),
+	TP_ARGS(wiphy, netdev),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT, WIPHY_PR_ARG, NETDEV_PR_ARG)
 );
 
 DECLARE_EVENT_CLASS(station_add_change,
-- 
2.34.1


