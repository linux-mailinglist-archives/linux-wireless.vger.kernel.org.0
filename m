Return-Path: <linux-wireless+bounces-16517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CD59F5D87
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 04:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F317A2455
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 03:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2013E143C72;
	Wed, 18 Dec 2024 03:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hcSkhDaV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F0126F1E;
	Wed, 18 Dec 2024 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493315; cv=none; b=iHF8Z0gh9PWvQlBF58vhhLnS7OdVRwBinquYpQIgZcRaKwtc1V8vUMVECC7yr51fkHGkjU01ND7ol2Q4L1DcXYYX8IEkDLLM6/QQvGBdN9rL2Xf/2lJ9EKJn3ZNV4Ks2SiOIG4aB6u9cjnqf3Kz6oxCQ/pMtEih8941mVJKjsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493315; c=relaxed/simple;
	bh=05Z2Y88r2Vba8X476YWIpDnaslTfab1e9hZ429Z6HYA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=PLxTZy01+k09SVVhWKJgF1FUQ7nY6gxxXfjvswbuNgY+0FuLpvt7b6ZNV/Oj0XpIW3OLKxqHnafhCcuJw+q9pVPCG47Z2urr53xPxO0+SE6U+LvRRuWjt1MEbpDxApUjJbKnytaJVWIdkClRur7ShoK0T5LCwsAAB0oze95qnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hcSkhDaV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHKre27013674;
	Wed, 18 Dec 2024 03:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=E0YEgSlwMNnP7jmEBlmVwt
	U2ARROQV13scoJq2pDSJU=; b=hcSkhDaV/bMiq+0PC+5fagBPYvDda/Gl+YRaHj
	eIQRAKB2Fl6XMWGKGn7Z6rFxyl0W0sOccrS65uTnP4MqE4kXX/azN7FZdq3tZC50
	KC450uPcXvTG3nYFpY4UmTBKq+mgJNCmBEacGJCQq0A3Tjo1r0wlhcoOoFOF/kZ1
	9mtM13MaS10yDbr5Dju9ZVz7gU+deIQ60JNQ82OcrG4TBAUUQAoNWLknAcnfomYz
	COX8gp04xRfIkcys/CE4sojYNo1Jb/VYJMlij4IZFlybcnMRqDUMrEbl9p62oCbW
	PvmTZamI+xXx6WNYrHAcRz5g9EKYW3pUnkBAyZ7iGIPJHfHw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43kgr10qk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:41:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BI3fj3g031530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:41:45 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 19:41:42 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: add MLO DFS support
Date: Wed, 18 Dec 2024 09:11:31 +0530
Message-ID: <20241218-ath12k_mlo_dfs-v1-0-058e783bcfc7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGtEYmcC/x3MQQqDMBBA0avIrA04aazQq4gEiZNmaGskI1KR3
 N3o8i3+P0AoMQm8qgMSbSwc5wKsK3BhnN+keCoG3WiDGjs1rgH1x/6+0U5eVOu8wa55ONM+oUR
 LIs//e9gPxYFljWm//jnnE5tUwPpvAAAA
X-Change-ID: 20241217-ath12k_mlo_dfs-5cf41703c456
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sHg1Zx0BRCtkg_RXs6F9Wv5ZzAC2-ZKS
X-Proofpoint-ORIG-GUID: sHg1Zx0BRCtkg_RXs6F9Wv5ZzAC2-ZKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=819 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412180026

Patch 1 is fixing naming inconsistency in CAC_RUNNING flag.

Patch 2 is not directly related to MLO but fixing the CAC handling in
non-MLO cases as well.

Patch 3 is adding the MLO DFS support in ath12k.

---
Aditya Kumar Singh (3):
      wifi: ath12k: rename CAC_RUNNING flag
      wifi: ath12k: fix CAC running state during virtual interface start
      wifi: ath12k: handle radar detection with MLO

 drivers/net/wireless/ath/ath12k/core.h  |  2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c |  6 ++---
 drivers/net/wireless/ath/ath12k/mac.c   | 42 ++++++++++++++++++++++-----------
 drivers/net/wireless/ath/ath12k/mac.h   |  8 +++++++
 drivers/net/wireless/ath/ath12k/wmi.c   | 14 +++++++++--
 5 files changed, 52 insertions(+), 20 deletions(-)
---
base-commit: 9a448415ed0c46edeb9170091a03b620986ca0b2
change-id: 20241217-ath12k_mlo_dfs-5cf41703c456


