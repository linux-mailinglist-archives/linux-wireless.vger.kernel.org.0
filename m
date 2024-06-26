Return-Path: <linux-wireless+bounces-9575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C2B9177AE
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 06:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6998B219C4
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 04:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB41E880;
	Wed, 26 Jun 2024 04:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UK+1UVuJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935813D89B
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 04:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719377575; cv=none; b=LhIPONqPHdhvr9aiWh6OBedPmlH2OI6PFMs9QTQ1BFtPJV6m7HJuR9+3tcGBFMZHeKIjxJX3/rdV9jtUb0B+wI/vr6/KBuWR1fE3pzLjNJFaV8PIR0G60fFaKYkCm+SMFck0kjqUXYYApbd5XEKED5ygmyTcOGjpLVgaWSi5TUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719377575; c=relaxed/simple;
	bh=zkLAkb1nTfqNgGdJtc1gUbkky9UrsB/ORpd3FP0TySs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7Da26vLEzrxFHcnE5JvX3J8YEX7DscyL9tbfMA3RnAWI+6uez6gv1edBS2tFptQL89EVar3fj/jjUTzeimVYwk/KnWYz2Zpt48E1rbTCjH9Obyw5/k/lbpCprdqh+VAKhsH4h6JPa40pGK+BhVFADSClTprmcaUoFg2cgIgxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UK+1UVuJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PG9EiF008956;
	Wed, 26 Jun 2024 04:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vyydDZF4diJD/3AJVLQuRvbHf/UWvXyuKC1a0l/Qgus=; b=UK+1UVuJ4BQS8X69
	LxTRAg5MXcb0PVizvqXW9FZD8EG/HtiJKpPjGiwJvwGazEVG0GNkhrjvz5NAUmnO
	W1IH/29bGs/gzHi2beuAkxq3kvYlJamvxc1QhFGkMm/szDWlaZ+/TmXieV5H1kop
	ZZrad76Eil1pj3MOjvVXd0ux5FAm/xTVqGCY9vaAk06MTxb7uVrWkiOsnhEGb1gJ
	mTL6ihMI4XPl/A17y5vWaZOG4DU8EaRC3aYkzOMNAguc5n0bqj1g004/QAXTp43K
	YiJAsFR50A+a1YT9uefnI0ATybZfSSIyXv6WqhfBF6uzKeKGmAcH96poyxxEwak5
	OkYxXg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqcegh9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 04:52:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q4qnlx011214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 04:52:49 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Jun 2024 21:52:48 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 4/9] wifi: trace: unlink rdev_end_cac trace event from wiphy_netdev_evt class
Date: Wed, 26 Jun 2024 10:22:11 +0530
Message-ID: <20240626045216.3754013-5-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: L0gUlq2fF3u3Aunm2qNJe7MgI_32TcL9
X-Proofpoint-ORIG-GUID: L0gUlq2fF3u3Aunm2qNJe7MgI_32TcL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_02,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=798
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260036

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


