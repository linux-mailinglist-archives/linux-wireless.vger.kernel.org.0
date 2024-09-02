Return-Path: <linux-wireless+bounces-12313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635D7967FAE
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D2E1C20410
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 06:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC3015CD74;
	Mon,  2 Sep 2024 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ESv58KgL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227315DBB3
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259757; cv=none; b=a4pc9kApA5dx/iLp7Fw/4c/dW9o9e7Tm6hDuQKaDVkRNJs/DXcfQwpOkAS+D3xrLape3W3S0m1L3hcVSQgugDd0V3oUyELQEoZhed/ZrxQUV4b/bw9yoaR8G1lIRiZLIj+tWjnYQIiIp4fwLGJhFaTz1SJN50Iu1yl/vEky0/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259757; c=relaxed/simple;
	bh=zkLAkb1nTfqNgGdJtc1gUbkky9UrsB/ORpd3FP0TySs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnt+QAajQmK/ur+wIqdHDVZ3V4KZc9yQHO4xSl0jamRyK5VUoV87lVF39JafO6+gv6Z+ZDvSefGnTSnHR8/SQTL0KfZrDiBdXHdG5IRbvGeFPBnvhw359vvH+FE3g0e05o+Nfmr0HCDK/1jmAr6W5ZmshEtnicTLZeDcUW2+MBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ESv58KgL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 481NN6Ox002227;
	Mon, 2 Sep 2024 06:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vyydDZF4diJD/3AJVLQuRvbHf/UWvXyuKC1a0l/Qgus=; b=ESv58KgL9sLZEgDZ
	eF4XlWHHMbTSOLt274QlMDIV63s1m38ZcKxwhrf0k9bYmfqf1WSU7TMhkbOoD5PB
	rEOSOALv8tPODuYvbNPRFFAexpnG7z0457wia/QFN/jwXsOmeJFg9G+Xzu9YnAIL
	IkQyxi3i+vVVHO0LG/ys0IjoJPDclnvzSsQ7RfwKv9JoXB2Rq2clAvmakuDlmqzH
	Hj2C3x0poWiMHyO1sSnyd5VPGc6RMklvDQXgpt/5ijh0oh4EPOLeO+OFjFzBOhu0
	q9pdquG4uDXi0YAWC63s8ZEKsH4WIUk/QAQwhwMbX5rGv3bpwExDawlwXt868gi3
	BpiEIQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt4rbska-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 06:49:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4826nBqP016190
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Sep 2024 06:49:11 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 1 Sep 2024 23:49:09 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v5 3/8] wifi: trace: unlink rdev_end_cac trace event from wiphy_netdev_evt class
Date: Mon, 2 Sep 2024 12:18:42 +0530
Message-ID: <20240902064847.2506090-4-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: 2xbQtRIB9xHZgjXI7mlAR8dSuxEaO-MZ
X-Proofpoint-ORIG-GUID: 2xbQtRIB9xHZgjXI7mlAR8dSuxEaO-MZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-01_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 mlxlogscore=793
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409020055

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


