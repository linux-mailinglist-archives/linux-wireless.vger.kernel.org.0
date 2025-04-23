Return-Path: <linux-wireless+bounces-21878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0981A97E6D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36CB87A4ED5
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3F2265619;
	Wed, 23 Apr 2025 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fZa8e2ST"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B3B2580CA
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387831; cv=none; b=Wwu2P8D0NgI8wZfpw5OWlEvUnW2RidJeu/PQ5QZi7ufhGBxKGzetXOL0KgU30winfCuk64FOwvQ6rbenS8np23T1XB6/EY2KgNvvctjE4hNUHycLAv+Up/kEy/YYFTsMr2HB6vPiCp29WOmY3GDGxTWb4bSYHQRlpYIEnTLiTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387831; c=relaxed/simple;
	bh=j8wUyRFwdXLWQ9WeVFK85RCiygav3Ov4ldPq5UivpLg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iu3NxuvVU8RtE/OLBcgKi3fUkvvDsZtO8B/cBegl9gpyhQ6tAyUBerX7CNK2QB+NEnC3r91+10v3y4fQK3Un0kxNNNI2GjpFZQinx3UEOneIkeeBWtZzWVY6EzSwyWGmBJiuQZuBSwNKSBvrcVUfkEn+FnDR8snyLDbY62kziGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fZa8e2ST; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0i8kA011379;
	Wed, 23 Apr 2025 05:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZayO2npPrLIKzEJcdh2Sgj
	g7QLhr5K62lf8kubZI4Qc=; b=fZa8e2ST4/e86G817sF2gCIMzoV6ep9W4bdBEt
	TLS2YpT8rZ1SadfF4aVsnG3ZoI3Vk4WNZgpSDPsEpoyJvsQX5fPPhdX9dwVLdN3v
	CkW7kmgBBqfcV0ZJ2vjU6r15UwrWLM4Vd+GSCWzmqO/yeqvPhl6rR9thXjZA2tGy
	+jk10RUdMwVd3m0HiDFMvnKsDILbWmvB9Hac1YbcYZf9g9OA8pzXqUqrVpdcLnEi
	UdV4JaYDSnPtLNORpJfJVZ5AqVqoLoVebvC1/lasYQCaUJcH8/f3WoX0qTGq/7nb
	oUeNGclqiyk9+DEd1TJppxzTvcbbxvh6Sb8cKo7ahoClwwOA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh1h0xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 05:57:06 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53N5v50Q016937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 05:57:06 GMT
Received: from hu-yintang-sha.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Apr 2025 22:57:04 -0700
From: Yingying Tang <quic_yintang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_yintang@quicinc.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: Fix asymmetry between ath12k_core_init() and ath12k_core_deinit() 
Date: Wed, 23 Apr 2025 11:26:48 +0530
Message-ID: <20250423055650.16230-1-quic_yintang@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i13Cv_0alZeD99U_qj1Gs4hLxsNLioXJ
X-Proofpoint-ORIG-GUID: i13Cv_0alZeD99U_qj1Gs4hLxsNLioXJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDAzOCBTYWx0ZWRfX3wf18AXpP8oE wywssE1gT1te/EkBLzoIDB32wGIlMQrbtx94Rwyib0mUp2loLKP1JXJljyZMWIXrYiDTxFSk5mV 0rAOH0dia4rk7V/BQPuOWzBD1wHwVtZwDbIh1YrMLpm6SPm3XzzblUaxJfVBxkJRqjzfMmZL3Zn
 vk22ABm7A5Lq6gk09gX3A5SV5K0zGC6BZTXNDIQlQTxNUTgpEgGJ/JfPzs4/Tw3t9hVNd9P0FR4 S2MY8iZFj8p8AFakCNz+V9WFUvadN0GMwrfa5VJuzzVSQ3zeGpc91TxGX5niE/0XqvhI5MBQR1Q wF8zZSH8jHMTqnPooW/M/JhL/L/JnsOZIP24/f3zDBQ+NSvGSZPlv1N8EfByq/Xbuh7cS1JhVS2
 LrVUyFCD6I2pD+2xfvlOKkPQZ1Dz6P/lk2sdYp9ggX91z1yQ0H7MLD0DmRE7oDz98GX7t9bM
X-Authority-Analysis: v=2.4 cv=ZpjtK87G c=1 sm=1 tr=0 ts=68088132 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=U4ZuKsGhK-j8A0JmtxUA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_03,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 mlxlogscore=293 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230038

There is asymmetry between ath12k_core_init and() ath12k_core_deinit(). 
It will cause page fault in some case. Reorder and relocate the release of
resources in ath12k_core_deinit() to avoid this asymmetry issue.

Yingying Tang (2):
  wifi: ath12k: Reorder and relocate the release of resources in
    ath12k_core_deinit()
  wifi: ath12k: Adjust the process of resource release for ahb bus

 drivers/net/wireless/ath/ath12k/ahb.c  | 5 ++---
 drivers/net/wireless/ath/ath12k/core.c | 5 ++---
 drivers/net/wireless/ath/ath12k/core.h | 1 +
 drivers/net/wireless/ath/ath12k/pci.c  | 5 ++---
 4 files changed, 7 insertions(+), 9 deletions(-)
---
base-commit: 89ac53e96217bd5525ee56eaa1b8ef2b398a9ad6



