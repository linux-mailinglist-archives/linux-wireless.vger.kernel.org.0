Return-Path: <linux-wireless+bounces-8746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA9E901D4C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 10:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DB21F2193C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549EA6F30D;
	Mon, 10 Jun 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z5UrfQWq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E05227
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009553; cv=none; b=rBdh6brOOjoR5v8nBbysvuD/UZImKQFc6t8ZtsWWlM7nN0kk7o1J//o3lzgcGosrrFCVBDuEocKg1WUpky/3LtxIV0KEHo5POL2chbKcbdtBct5QCtXwjByMe0hsqABs3/ZZwI7IJktG1Px7M0b6bMSl0lS+mT6YaUZG1kVNj5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009553; c=relaxed/simple;
	bh=mG1CTDTAyQhsJvXWvvrYqwqtus+dCZgcLMqQN4/1aw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3c2hrFj5Dpw3gcXdah+r63Mcnrm5YIjRqSwXJjBI2AgAfCgn0Z6av2Wimy7p9o6nb43HiRX+kc2UHxRa3J/xsFtrqXkoI36cWNRVsH1Wj0zKuLotN2hFi+0jLpEQgd7eMTCtHCwB/pSIgp8lc+r878X/rU2VOvpW36eaDouh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z5UrfQWq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459M1NFh009886;
	Mon, 10 Jun 2024 08:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Q+S+SyhZ6ZNOVgG8fnskgmLz
	nhaWY4ge9xkUl+9Wr3Y=; b=Z5UrfQWqmHGnRTjp8DVpRLYRTb2rCA4BwXRAkYHE
	Q1sYUDvelVelXX9nqAhLclKN7McW3FBtBYmgkdrUXj8XUYe0jUvcjFoOKWj1P7CV
	cBpfak/wZMWGuLXfPteKIqXBGdYh6Qy2rzGJ1C62tv0Cz+FB3UN7TfSoKg1FIlGx
	Mwhv3yidecLk4IgLfCNJXuzeRwU5dpczlUe2uO9xM53MBKUquVbh9H226RwaG1E0
	q8PVynX7FE85fqrJWWMTe6DuoNxyBziXbvN9Yv4paJ7uxRjtxAwDD3mdW86I+e0g
	pIvRxFPi52vrSO5aMDha3/II7K8gnDUjXRwaxmdDTnnvLA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymea6k1g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 08:52:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45A8qOWT023692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 08:52:25 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Jun 2024 01:52:23 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH 1/4] wifi: cfg80211: make BSS source types public
Date: Mon, 10 Jun 2024 14:22:01 +0530
Message-ID: <1718009524-5579-2-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mts5n5LZ-PERMc78bAtSgVqxLoeddNPr
X-Proofpoint-ORIG-GUID: mts5n5LZ-PERMc78bAtSgVqxLoeddNPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=675 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406100067

Define public enum with BSS source types in core.h. Upcoming patches
need this to store BSS source type in struct cfg80211_internal_bss.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/core.h | 6 ++++++
 net/wireless/scan.c | 6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index 118f2f6..a48df7cf 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -170,6 +170,12 @@ static inline int for_each_rdev_check_rtnl(void)
 	if (for_each_rdev_check_rtnl()) {} else				\
 		list_for_each_entry(rdev, &cfg80211_rdev_list, list)
 
+enum bss_source_type {
+	BSS_SOURCE_DIRECT = 0,
+	BSS_SOURCE_MBSSID,
+	BSS_SOURCE_STA_PROFILE,
+};
+
 struct cfg80211_internal_bss {
 	struct list_head list;
 	struct list_head hidden_list;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 1278538..1fad019 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2107,11 +2107,7 @@ struct cfg80211_inform_single_bss_data {
 	const u8 *ie;
 	size_t ielen;
 
-	enum {
-		BSS_SOURCE_DIRECT = 0,
-		BSS_SOURCE_MBSSID,
-		BSS_SOURCE_STA_PROFILE,
-	} bss_source;
+	enum bss_source_type bss_source;
 	/* Set if reporting bss_source != BSS_SOURCE_DIRECT */
 	struct cfg80211_bss *source_bss;
 	u8 max_bssid_indicator;
-- 
2.7.4


