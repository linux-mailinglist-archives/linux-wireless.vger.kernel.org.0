Return-Path: <linux-wireless+bounces-15315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CF59CD713
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 07:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960ACB2205A
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 06:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7361A185B5B;
	Fri, 15 Nov 2024 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k+Q+K6D3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68F175D5D
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652159; cv=none; b=UX2pLHat5TtmC6beLekA9Sto951VT7eN32Oqt6HBIr+UiIjsZXWtmVJj/MQpt9QTK5zzSILa25c4CiHN3ia//6SC/agB1pAMu2NllqB+F0P6WPpmO1lBy6b0k64WQzVQ24uPwAws18uBEajdxHPCvlgfVtGGmXkfxC0RlkGEnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652159; c=relaxed/simple;
	bh=+SuLOOmmNGB2NyuMVtosFHbEEYBabPeNbo1D/QF3TQw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RgYzo7k2Zgx/3VFvmq0W5QESgWI/rnBqvnNY7YD0+e8wOyUtxRq+oPZ8xPSiQAhSKT7MwDqgr5clm2AD0uELbNFWyHFr8+vsoZOUFxhQHcDOvbWwsmJ63LDG0Ynwr7FY+vqrMaB2Kgo+SPGlMyukAOu2nnTl1T9YodmaiWbD0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k+Q+K6D3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEHI0LF023810;
	Fri, 15 Nov 2024 06:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SKJoxIxucaaQHQua0dYeGh
	H5ESi0MFNYje7jvzXg6J4=; b=k+Q+K6D36hWYYL8PFGg8vojUEc+tS3IzOchuUf
	IbB7k/QWPo9zBMDeqmUodRxsLINLLJNzQy/3yf1mVpaREo+SK7g6sHpZY/wtS+ye
	kEd+xETbliTICgQXAKweLN1CLk6jAOVUTrdVC1cYBGF6OHuK45Unlu+1gSugQJ46
	jz2VXmXeuO00kBt8R9SQggz0K9s3chgo2z36wzOmrKed0RX+Ann0miUeHaCHDcju
	7KvvfgKzfj9zWVuC9ieK+AbQVXc29b3CpUK5f/fA9CtPTcyeWhR+iQt+lbTtE2Bp
	iY/TtD7weBVFxOl2AwVY6apGvV6mI1s+7uPGH7tK+3WSVavg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w66gwat6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 06:29:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AF6TC07015823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 06:29:12 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 14 Nov 2024 22:29:10 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v6 0/4] wifi: ath12k: Support Pager, Counter, SoC, Transmit Rate Stats
Date: Fri, 15 Nov 2024 11:58:50 +0530
Message-ID: <20241115062854.1919672-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: FYBUEu4F0tjCHEPVDwunZDWkafP54n7k
X-Proofpoint-ORIG-GUID: FYBUEu4F0tjCHEPVDwunZDWkafP54n7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150053

Add support to request HTT stats type 36, 37, 38 and 40 from firmware.
These stat types give downlink pager stats, counter and TPC stats, SoC
common stats and Transmit PER rate stats, respectively.

v6:
 - Removed unused variables.
 - Used le32_get_bits() instead of u32_get_bits().
v5:
 - Addressed Kalle's comments pertaining to variable declaration order.
v4:
 - Addressed Jeff's comments pertaining to data type conversions.
v3:
 - Added macros to fix compilation issues.
v2:
 - Removed dependencies. No change in code.

Dinesh Karthikeyan (4):
  wifi: ath12k: Support Downlink Pager Stats
  wifi: ath12k: Support phy counter and TPC stats
  wifi: ath12k: Support SoC Common Stats
  wifi: ath12k: Support Transmit PER Rate Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 627 +++++++++++++++++-
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 204 +++++-
 2 files changed, 827 insertions(+), 4 deletions(-)


base-commit: 0ea161de5e5afa1323e982adc8f59bf4af99a84b
-- 
2.25.1


