Return-Path: <linux-wireless+bounces-12233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C5D965756
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C85C1F24F7A
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C403148827;
	Fri, 30 Aug 2024 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tnw7Ep9I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78914D6FC
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998187; cv=none; b=SgsQxscRKFItT0MCPcqERAVgZbIvpNQLVPCTJ/XMOoeNHKgZHMWR8JVUjqhnfqQKEKv0eceHb/HT3dm9JY6tkJUE2l0IcZFFOmjpUStG0uPc88aZTM0HV62Fb7Os2ZChPytK7H+ROoc9Wo/SRkHqR5tyygLrY08/rTY5suxya0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998187; c=relaxed/simple;
	bh=zkLAkb1nTfqNgGdJtc1gUbkky9UrsB/ORpd3FP0TySs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNmNBpKGRBoGz6vXgWREIGYHOHMqIJNOn41UNqOFM0nG7IMfwoYp4LYqx7T5BANswAeDGLWUFXeh9wxpx9RjgkCkJZ2m0O7XH32kpQhwMab7eDdSOh26Us6mTusyW5zu2VafgOvgjcK4GI7LX/SxuM8BGOWA70D8rqU7xIg084c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tnw7Ep9I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TGkRKY006314;
	Fri, 30 Aug 2024 06:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vyydDZF4diJD/3AJVLQuRvbHf/UWvXyuKC1a0l/Qgus=; b=Tnw7Ep9IErtEt0qo
	8IB3Q7+O8DNFVe/eODoTa395TX6ixgYgb6tUNchC+knIrbRfmhdStnH+owBwA6Qi
	V68mXwZt91zt9PiDkZNvZyxvh8mfrbWuTShriIIexcDvpXkwoa4xK/Pef8LwdCuX
	qIRMDDYReaj3l0gB6VnzKl7HsVH5aadRWLaakaT/912Uv6/qUVchPd7cwqbBHur1
	Me4hsLKCf/2OC+hkEdbp0ZldPvnOzKBnsaujkdURfp7m6kbazxgGHhR07ATITVbW
	rASRpcfFVoWuerqyGoR/v1qHOjjh8B1VvpsPBZJY9MSzXz911sOu/7Gt1JIwhb/E
	RGRQnQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419putypet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 06:09:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U69d1T020065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 06:09:39 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 23:09:38 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v4 3/8] wifi: trace: unlink rdev_end_cac trace event from wiphy_netdev_evt class
Date: Fri, 30 Aug 2024 11:39:13 +0530
Message-ID: <20240830060918.2418701-4-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: uxSZZQk0p4nsbkEgDvl0KNQE2h4f5jUg
X-Proofpoint-GUID: uxSZZQk0p4nsbkEgDvl0KNQE2h4f5jUg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=793 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300043

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


