Return-Path: <linux-wireless+bounces-21083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0BA79219
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE9718956B8
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFAE23BCEE;
	Wed,  2 Apr 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AEWYHVJy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9A2356B5
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607558; cv=none; b=Ow6fLx5M0nVhHnI/iRAZ2JSoTI4gXAuq6rB88cxKWu6VYpXzYCfaRXMwZlSwvDdOUPDtqhaoR+IBwIhuArUIUD0BrmcHPhHFeLTkbRQlG6MWL/ogSIWPanQLACNRbRyo+bowWeHzCzaf2XL2ksEyZFcL254V8PhZLOx5DFZLmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607558; c=relaxed/simple;
	bh=9lfYNTsAD8jBFzy3vuUF7lv5WMgK66DpVm8RAmQFN44=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dX2631w5GuZq2g1/fXIt0WFO2mtxc4U9PzfWibb1nC4AVbInnrL/6TIRTDObubqW/4sftzV68HZyhwgYr0Y/uZRfYF7Qy4Z03AaQPPaFoSujg2kmM4OExVIcs2MMiVf4y5dVyrUPGqDujc0kR/HGvcg77UQROgA9UUiNRY4IU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AEWYHVJy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532CliwK023730;
	Wed, 2 Apr 2025 15:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=x6kVsXnIyMkzVP5VbdFF03LXuYv+K5PQfOJIJXPQuAE=; b=AE
	WYHVJyyh4F46KAbLIpfqnCajNnoYKz7BBl2OgUzYGUV5u8WhuyJ6o5v+0VK+OcPR
	YNAR05Za88wRufyTdQ671s7+b3ZoHJlgbFLDqp2od/i8ILRJHh+y7HXM5Rb2e+td
	tOQaWTIqSYImCdEhHEOBr8bOraNv1m1MlEFVMv7p04D0OXrSGBuem4vfEY4VNfXH
	XYx2DOXAlSucJghyy1u+eN3BVYOZLSUBCIyJogW5V9/dsaDtCeZPI1aU08guBP5w
	LhS+6JtaXudx0KkvyDJ9McqyvPzK42ZHEhXq6byzRpday20wxi/1f/w930Gzc86v
	NZxGn9pbYUWopQ2JKrBA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rxapsta5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 15:25:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 532FPpm1013048
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 15:25:51 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 2 Apr 2025 08:25:50 -0700
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH ath-next v4 0/3] wifi: ath12k: Enable REO queue lookup table on QCN9274
Date: Wed, 2 Apr 2025 20:55:26 +0530
Message-ID: <20250402152529.1649402-1-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Vbj3PEp9 c=1 sm=1 tr=0 ts=67ed5700 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=tnCF6RmjttW7q9gwjsMA:9
X-Proofpoint-ORIG-GUID: 7c6JqRUoFqBtUVOFKYiJ2XpALoS2Znds
X-Proofpoint-GUID: 7c6JqRUoFqBtUVOFKYiJ2XpALoS2Znds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxlogscore=492
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020098

Instead of storing the REO queue address inside peer entries, REO
hardware module prefers them to be stored in SRAM which could be
directly accessed by REO using peer_ID/TID based Lookup table(LUT)
mechanism. This feature is expected to improve stability by reduced
interaction between host and firmware during both MLO and non-MLO
operations.This feature is enabled only for the QCN9274, so it does
not impact the WCN7850.

v4:
- Rebased on TOT

v3:
- Rebased on TOT
- Fixed 32bit compilation warning

v2:
- Removed junk version histories in cover letter

Balamurugan S (1):
  wifi: ath12k: Add support to clear qdesc array in REO cache

Nithyanantham Paramasivam (1):
  wifi: ath12k: Enable REO queue lookup table feature on QCN9274

Sriram R (1):
  wifi: ath12k: Fix the enabling of REO queue lookup table feature

 drivers/net/wireless/ath/ath12k/dp.c     | 77 ++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/dp.h     |  5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 11 +++-
 drivers/net/wireless/ath/ath12k/hal.h    |  7 +++
 drivers/net/wireless/ath/ath12k/hal_rx.c | 19 +++++-
 drivers/net/wireless/ath/ath12k/hw.c     |  4 +-
 drivers/net/wireless/ath/ath12k/hw.h     |  3 +
 drivers/net/wireless/ath/ath12k/wmi.c    |  8 ++-
 drivers/net/wireless/ath/ath12k/wmi.h    |  1 +
 9 files changed, 104 insertions(+), 31 deletions(-)


base-commit: ba613742db305037ca2193b2b552b769c4f2a5f7
-- 
2.17.1


