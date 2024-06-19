Return-Path: <linux-wireless+bounces-9226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F8F90E236
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 06:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB1D285930
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 04:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9D950289;
	Wed, 19 Jun 2024 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lpS61KPv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70142558B6
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770239; cv=none; b=utjOmtpHYRZYZYQ38I7ik65ZlPX8Nd3S9DintibMIk1aAxy7/jGwioGtoNQemyKM59e1YgI24Ym/pEe7LP7vo2UnEeTatuw3ooRNdd4K7aACmW+P9U9QwgZttvtJBXZqFObeXOFGY0HK9XNypp8l7772NqPGa+OXltl6n66BQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770239; c=relaxed/simple;
	bh=zkLAkb1nTfqNgGdJtc1gUbkky9UrsB/ORpd3FP0TySs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV7OmvQpVMflzlDCdrF0GEm2R+0Xhg5rq9YyLj+eMGmgQa+FwycaB3qGLZNwbVb/0FDae9lJWCZlgqYJVA1mDKV2OBa6evzsVUa8TuGAzK3FL8fR/V8B2VeIqbdheg2H7JG4nHbDjmc7wr/bZAYE8UMCetidv7Jls5G9f4T6UJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lpS61KPv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILaNKT001114;
	Wed, 19 Jun 2024 04:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vyydDZF4diJD/3AJVLQuRvbHf/UWvXyuKC1a0l/Qgus=; b=lpS61KPvd2/xbSnp
	t7wYvpXuV1iJ94zeyG59xiFaQgLghg/9/L/qnp4ja005t85Xlka8uBrA9bMZcu8H
	KpqUP9fO6yPr5jVVNJPyDUynGExu+DURd0nQvr1sArJOIRfcdr1qKKkh5dAoG6oc
	snVz4NsrXtEcMqCMhAONzgdyqRnN+Az1dxqZbvcZ0kL4ugt1hUyhwUtTcCKD5Adf
	P4P47OWulbQqF4fB+nqiJpZaTsOaxmpcQjEkKcVb2RS6u29T6yePH1hXBD1UoVT+
	o2TcwCaE837YrPrP3LwDm8nS0gU9pPscE+fIYYPd5uexhlrPKPyNtsRNoENDzA8q
	EomiSA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja28kda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J4AXQL013158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:33 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 21:10:31 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 4/9] wifi: trace: unlink rdev_end_cac trace event from wiphy_netdev_evt class
Date: Wed, 19 Jun 2024 09:39:54 +0530
Message-ID: <20240619040959.1457547-5-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: wzET9Or9YS6TOYlaspcj4UPvslXB1uqE
X-Proofpoint-ORIG-GUID: wzET9Or9YS6TOYlaspcj4UPvslXB1uqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_01,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=799 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190029

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


