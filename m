Return-Path: <linux-wireless+bounces-8696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF919006ED
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F6F1C22BDC
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9011991D4;
	Fri,  7 Jun 2024 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RG2gVct8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402EF1990D1;
	Fri,  7 Jun 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771241; cv=none; b=HiAbuWHhyji2EMW8ZwXyB3YSWzan0h006vRO+p7pbdWQkVPPN0evcRMWTxy7go4L5I4XjQHGLV5p6Iv9F3tiwjo6kFwOVBbBiItyVLT5CJmuVgZgbuSbig/vNt6IAvlRFgVbQfCEIEZjU3Foe0nwP6KMnV58iQkB8VlLk4kocK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771241; c=relaxed/simple;
	bh=cu5mOnfZFrcZOMPUbpgrwQxMWxHEp/inFB/edR4A860=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q/vDPHr3isqgqmvs2K7986Ys6EzAjr3bxoo7DDtWbdiqXO92sTzia/ByrDqXN3vrtpuH2iD2jHB8PyaGyd3We62azHyEpMC1PVsBNGau4zP6PGg2T0w0WGIDgCTMMHb6rWNNY5Mo+4QKhIO3tSdeXZ4kAm9UlRDW7H7JavLvstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RG2gVct8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457BQUUd018918;
	Fri, 7 Jun 2024 14:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=Bz/FjNMjcCiEE1mqfQM1lC7pc1DgWlMC7Bs2+7Pc1jw=; b=RG
	2gVct8HyBjYTCO8i/FakNL6iteAiS/dLcykXORlobyVY+WRJixYPkAsJ+gbBfYww
	Y4xuz5tqTxv/BRpco7vV5xx9HNAUbttt6Ps0elC1NDcqQoS9i12Rt7NsHbvMpPIG
	Lqk6TKnPG6QkRaLFNS4HOkZ7Nwe6Xl47YdHPT3DhNVTVRma0OO1aVU/9J2+BuB1l
	hSdFi3ii1PZvNZMR8y/5rA2q/CI92WoEbtJNsGmFEPQTJb+Zf4Zs9+7SRoWL47O/
	IDFGhwymOp/iNSNB8J/ziC1q94JwFXlhNkv+AqmYIw4IzEgeuL6c2yYSUOO94cDK
	5UD75ku6PD34u5OmmuEA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjh3txj3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 14:40:28 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457EeQs7018905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 14:40:26 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 7 Jun 2024 07:40:24 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <emmanuel.grumbach@intel.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v1 0/2] net: rfkill: Fix 2 bugs within rfkill_set_hw_state_reason()
Date: Fri, 7 Jun 2024 22:40:10 +0800
Message-ID: <1717771212-30723-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sR5_EdZxsZVfz7rt70X2yF8vY08Cq9C4
X-Proofpoint-ORIG-GUID: sR5_EdZxsZVfz7rt70X2yF8vY08Cq9C4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1011 mlxlogscore=622
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070108

This patch series are to fix 2 bugs for kernel API within kernel API
rfkill_set_hw_state_reason().

Zijun Hu (2):
  net: rfkill: Fix a wrongly handling error case
  net: rfkill: Fix a logic error within rfkill_set_hw_state_reason()

 net/rfkill/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.7.4


