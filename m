Return-Path: <linux-wireless+bounces-8745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE791901D4B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C301E1C2113E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBED41C69;
	Mon, 10 Jun 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YACOaQNk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665835227
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009549; cv=none; b=N9JbTHA8C/uPG5AvIxdllYPQqnDIBql+1KpoqYRIlAr2WpMxX6vbo5DEoRmbG7+7+BjpG+yclMzc5M8XzhgsNVsXetsLJlLqHnX5v7OpirXvTpQ7R+wOL0QLjG4YVxAcM6NCJyIUix6S7qHx7aNYJ6kZByRXR3RAkFv7aqAnXKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009549; c=relaxed/simple;
	bh=Z6fTJfNfV1ZcvrPS19hTJ5mkje06tB0+wcd7WxZoX3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VLw0wKaD4FdScwPeSJdPiZ9WRTQE3T8ls23ZD80Yv1natrmAmivRPgEhS1c/OoCM4fgAN8hLK9jYA/zGOWsX33hBDBnJ5tNThNJRElJbMzbnQqaFrtn1dkcWtsL/WJcN/LCVuvsBpbpa44U0I018WhSarKvAzVOtSpV2PoqCINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YACOaQNk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A1SKgV011284;
	Mon, 10 Jun 2024 08:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=nGEpTOop7Fgop0fxZRUlqr5LLq16yVqwyr3y8REq0w4=; b=YA
	COaQNkOuXuDr7oQvlK2bGFAV1t9tlvxl1aKSPejeqHvUsRgKpteT+yrxrP+3vLzt
	Nyq6hkj0xtbHgGuUpkwQj/KexhDMMChx0ysTRfWXceDpIZwRdQcqM5/zkMmm9UXR
	JZQfaw35eefILec0Mu/ZCmdVjCh1Kh3BG3if1SJ7tUzDIdP/VLHvF1o3kKLy6yHz
	SLqTL0BEFdVJsZBosOWdXTIgo6eXsfSkuABTRDkWLdotZiORXFoRk4FfGN3Yq5u0
	4ONn6S4VK6QezXoK0L1mQyugd3RsjFzj2TUDN1xxSbulpe1Zssc9Kz3OzoXRQCvM
	bfQ02WcmGiZE//1p/vzA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymcnmu0k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 08:52:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45A8qN03002587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 08:52:23 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Jun 2024 01:52:21 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH 0/4] wifi: cfg80211: fix per-STA profile BSS entry issues
Date: Mon, 10 Jun 2024 14:22:00 +0530
Message-ID: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
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
X-Proofpoint-GUID: CRNKeNE9CuL1knV661gRO7CL_g1fR2Rt
X-Proofpoint-ORIG-GUID: CRNKeNE9CuL1knV661gRO7CL_g1fR2Rt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1011 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=555 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100067

This patch set contains bugfixes and cleanups related to per-STA
profile BSS entries.

Veerendranath Jakkam (4):
  wifi: cfg80211: make BSS source types public
  wifi: cfg80211: skip indicating signal for per-STA profile BSSs
  wifi: cfg80211: skip overriding direct/MBSSID BSS with per-STA profile
    BSS
  wifi: cfg80211: make sure to process all per-STA profiles

 net/wireless/core.h    |  8 ++++++++
 net/wireless/nl80211.c | 26 +++++++++++++++-----------
 net/wireless/scan.c    | 14 ++++++++------
 3 files changed, 31 insertions(+), 17 deletions(-)

base-commit: a46300b1b09ba260c2c2b00f06f6e34482a8ec01
-- 
2.7.4


