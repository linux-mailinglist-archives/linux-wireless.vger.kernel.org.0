Return-Path: <linux-wireless+bounces-12446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BB496AEE3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 05:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725E51F2525F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 03:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9854443ABD;
	Wed,  4 Sep 2024 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iPINhUNd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4E4A15
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725419383; cv=none; b=LGThJHeBVtTCnMEGZVOZ1pREbXKnV3cjeDZdhlAYKKY/GGOsBY2q0mSG/G5KM1AYi6T/GOJ+qys5099veaJACxtOKUlbA2H6H+4UVNRn8SIGnj8kFC5Y9ZpVg1g8qniTvH7v3Mb2LPa8wtT8hierOldlLd48SdqLeVcFMrRc/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725419383; c=relaxed/simple;
	bh=K9M4ES0giNNCjcd0yvlbgVtdPOwDO523CNYhasYP6T8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q9CgoUQ9le3ptd8/ECOKVPRgwuKXJW9HWzVLWFUtVgE5xwubOAQVDi7UeyyaetjiZnFdmo9vQgpRUEWO1szWVfMTz+KT7WRthRjoJmBB6EW1TWER1d+lTuFwsittJXdFNzpAC1nzPOt7caiwdHiUT6U8gxhILah1Jp5mKwoO2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iPINhUNd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483MD4VZ007712;
	Wed, 4 Sep 2024 03:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nFiWcqqXMT1Be8V+B+6BV9
	dpG3BPRoy7E3JdKKnvzVc=; b=iPINhUNdtVyAqoQ4rLlf3rmQdBJiXLzeJxU/4U
	DW+KldRmshR1zKv32By6RgJeWhYku8mVzt4ngX0mDdBj7k6FD/mS79MlSYsmDyE/
	vfaop1ivNmyDKIjpybg9rhwPq8ONLtLbKiRYxomZo/YJsLgF2v6xp7GYgFDSrP26
	oLITOKiuEH9hPA+oMSg1+oDdOoIa65ZC40BUsld/qhg8uwJOTb1fgWPDc/pnD04k
	D40DNr6y4O5ssEi0/Ce4LHbeNpDMdpYlAkyafFcwFaIGyq8/EEZIrJcdSGV7mLn8
	GvNREhmfPUo8AnCRcGZGah4pGWqnVqoeTn8cv5tN1jPLfkNw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bu8usfc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 03:09:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48439Z8q011922
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 03:09:35 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Sep 2024 20:09:34 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 0/3] wifi: cfg80211: fix signal issue with BSS entry generated from per-STA profile
Date: Wed, 4 Sep 2024 08:39:14 +0530
Message-ID: <20240904030917.3602369-1-quic_vjakkam@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wRJe4gFQ7vXKwtQDYlgyqzy3P6autzlf
X-Proofpoint-GUID: wRJe4gFQ7vXKwtQDYlgyqzy3P6autzlf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0 spamscore=0
 mlxlogscore=509 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040021

Don't report the signal to userspace when the BSS entry created from
a per-STA profile and avoid overriding BSS information generated from
direct/MBSSID frame data with per-STA profile BSS information.

Veerendranath Jakkam (3):
  wifi: cfg80211: make BSS source types public
  wifi: cfg80211: skip indicating signal for per-STA profile BSSs
  wifi: cfg80211: avoid overriding direct/MBSSID BSS with per-STA
    profile BSS
---
v2: * No changes in 1-2.
    * Check if BSS information generated from direct frame data
      available in cfg80211_parse_ml_elem_sta_data() itself and skip
      generating per-STA profile BSS entry.
---

 net/wireless/core.h    |  8 ++++++++
 net/wireless/nl80211.c | 26 +++++++++++++++-----------
 net/wireless/scan.c    | 35 ++++++++++++++++++++++++++++++-----
 3 files changed, 53 insertions(+), 16 deletions(-)

-- 
2.34.1


