Return-Path: <linux-wireless+bounces-7722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E52B48C6F67
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 02:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9621F2426E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 00:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC12197;
	Thu, 16 May 2024 00:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bbpQrJkw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0815A4
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715818113; cv=none; b=Jjy5JzJhv9KvtGYMfdDoXjeV6CRPoM29UKJVDsBW85fIdAJ2U7yCEgWw5tFTNLO8dys2O/0JqT7w36KfI5yBBdzJP/2do2zd5MIdr/4MbesgUWY9tRV0yYSCOlq0jPodL0V1JjUiZfmmRuunsUtdpl9wLPszGriJCb4+t8oCwVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715818113; c=relaxed/simple;
	bh=sNkXRKOfbnx/cMCtlQj/YBxoecOv0i7cFk3rlkKALr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XgTpYA2ikAitSGka6jq696uQAKDytn+gLaiqff0VaIX3Pp2hKfOydGcCChIJfPNAChBS6UT29otGElnpQOgnfIv4Cjdzl7iMeax3fVoPAKE5ptpDc4B43NjZMBxNHbMlqX5Np4yWC3HO2RHMQqtQCS9m2CQDGnPgPbNiBulel4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bbpQrJkw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FKFrJY027342;
	Thu, 16 May 2024 00:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=biYqAP8
	dnIMsicL5QWkwCWLjwqsW9s+ULU8BCvd3pDc=; b=bbpQrJkwOc560tx7mDzUTz6
	ucen+vw1Q8k9mDq/kPRvUTSFSiGn7mLGzWZIGU4IGYSSDfBvKZtjaFjFVbDRVhoC
	roL4aJk5KR2Yq/8U2tPZuiYoiGU/iVy4FN3cSNpUt52FFsZj/Qf90xr1zHsblFae
	/5ZDv0LktZNtmOY6zvP7zbJd+tFOnFZKTcwyA4m+lT2fES6C8BECu0IP1xeqtJ7e
	HXO/FCfIwILtUPn9dQnkJCbss9Lij2dJMWQRZvxz6b1JTp/ONkBA0b/pQ3b2y8CA
	RKBGJqmiMeHxuA8TH7Rg6xfG+brrA+7UW7UHgbeYE2UttEpxyTdq6akXk+lyXaQ=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y42kvvvdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 00:08:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44G08Pj8005254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 00:08:25 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 May 2024 17:08:23 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Refactor Rx descriptor buffer CMEM
Date: Thu, 16 May 2024 05:38:05 +0530
Message-ID: <20240516000807.1704913-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 9Q2r5AHiJfV8rs7FAK2EuamuYcaUUvJg
X-Proofpoint-ORIG-GUID: 9Q2r5AHiJfV8rs7FAK2EuamuYcaUUvJg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_14,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=4 suspectscore=0 malwarescore=0
 mlxlogscore=139 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=4 adultscore=0 mlxscore=4 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150171

Refactor Rx descriptor buffer configuration to scalable for inter device
Multi-link operation.

Karthikeyan Periyasamy (2):
  wifi: ath12k: Refactor Rx descriptor CMEM configuration
  wifi: ath12k: improve the rx descriptor error information

 drivers/net/wireless/ath/ath12k/dp.c    | 11 ++++++++---
 drivers/net/wireless/ath/ath12k/dp.h    |  1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c |  7 ++++---
 3 files changed, 13 insertions(+), 6 deletions(-)


base-commit: 5b501f801ab443046d5c31881bba21350396e5c5
-- 
2.34.1


