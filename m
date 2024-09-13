Return-Path: <linux-wireless+bounces-12835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BEA977AF6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 10:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4527928907B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 08:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E993158DD2;
	Fri, 13 Sep 2024 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T/CEPvsp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B81BD008
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216217; cv=none; b=CgZSjkryy7y6FEX9cdnQTvAfb0iGlduRQPJInRQKNxPAUn097Si6g63l9+OfzomTKbp7fnI6SV3OBckWSSNYa7rCiIO/+q4AdUK4V22SHJoGBz8daiWwUweHj5P5rm+nC/bOSGqfsfU/KG6wzlZpQn/Uat4MjaonaSQYGnPmMqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216217; c=relaxed/simple;
	bh=fI9ZIf2rD+fUqGVXSYF3fozQQD/z0SG/NnUzXb1gfgo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tpNPQqeb/3zdW4k93yYCr3gQz4MR5+lrEjcrlEsfq2Dh595MVQiYiYXHvXI+4FhEGq39twFeUnqjo/Cz7lWGeZ2JNaZ5Egg2m7BapszLTstopJEcs5q4uDoC8l2JW6FyvVH9EgkN59+76obmXSIXR6KecVpmjCPG579NRXXKGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T/CEPvsp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMBugr013065;
	Fri, 13 Sep 2024 08:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=enEnoqkwj/uhXq6KcUYRmv
	o3Ws4fgV1hwcxaFTYTl2g=; b=T/CEPvspYrP4lPnt+MmeJidgWt3juHTf1EWG7a
	d77l5yE7S5X51ge0QliqSIancXQBi9vXgNGTTFHZQtYyJjbRGWqVX3TzLSZ76Tnb
	UvjI+KRSbrwtmApjNCL2QSurk1zUm6C6cnaePf4zmBef61I3ssATFwmwdCn2cRJA
	BeboSfvV96v//UYKMvAJcB87CwntvsGL+JrtnHPm2Q+NpKOGSfftkK6oscj3/rHP
	EljX2dVDdta9FJ/JV3sWVaseXOSt4+fWV+RGfcrL97htUWuQYesVM8wi9w+iiDUT
	xmp39NQ5C8GA3SFIKJeEmTl7MDOdVhX0+FPZe+/cBqH6omyA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy51fxt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:30:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48D8U9Vx004721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:30:09 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Sep 2024 01:30:07 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
Date: Fri, 13 Sep 2024 13:59:45 +0530
Message-ID: <20240913082949.573482-1-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DmFJEIf0VAopO4fSBglLUdoEhsprIvDY
X-Proofpoint-GUID: DmFJEIf0VAopO4fSBglLUdoEhsprIvDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=504 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1011 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409130058

Add support to request HTT stats type 12, 15, 16, 17 and 19 from
firmware. These stats give self-generated transmit stats, ring stats,
SFM stats, transmit multi-user stats and CCA stats, respectively.

Depends-on:
[PATCH] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
Link: https://lore.kernel.org/linux-wireless/20240730035154.3723773-1-quic_rdevanat@quicinc.com/

Dinesh Karthikeyan (4):
  wifi: ath12k: Support Self-Generated Transmit stats
  wifi: ath12k: Support Ring and SFM stats
  wifi: ath12k: Support pdev Transmit Multi-user stats
  wifi: ath12k: Support pdev CCA Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 1042 +++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  346 +++++-
 2 files changed, 1382 insertions(+), 6 deletions(-)


base-commit: b1365224b7bd30454b0a0cfebc65ee7b41ed0a6c
prerequisite-patch-id: 970109034faa25a7630720c0da29c875e821f9ec
-- 
2.25.1


