Return-Path: <linux-wireless+bounces-17711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C92A162F6
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 17:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873E51644BD
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880701DF27D;
	Sun, 19 Jan 2025 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="elGowfOj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75253F9D2
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737304958; cv=none; b=cTv6IGE4ltSkziFxNK6hiP36LxXVi3npf4sC2RHkwv22YZonAAF3c+po0FMygnXIIZLVYDpsy/b0EiSUSPTMv9em3itx0ZzvVM7FBXtgFFmwxMMVeZi3NGlOgjz7Asy7ZOhjOgLaUnTnF6OE/NCU1R9PQU9PK/qQMWGZSdtFwXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737304958; c=relaxed/simple;
	bh=aSnGvVqFcsEPi4e9YdR+8RhXojb4on65MZqliq9nC7s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eV9PUf4x9YyEyyXvJsKNlol6KRIftoL7lIFC/VJDyoaHSxCBgfj/1GCJrgMfw5h1mA8mamFjhr+ACDUxMWof/Ge5jK7/v3WeBiFCtko6LbAPMMDyOHJIFVFKZyUvqeA4eAFa/cbDiaCP15UBOk4FtvpuS/Nl1ug5VLiO2/s4a2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=elGowfOj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50JEP1rO000383;
	Sun, 19 Jan 2025 16:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u9ZU1qKH/r297b22EOdKmm
	Cgp0AseUG6J7mQhsdm+r0=; b=elGowfOjk3BwsLAon4QW1i5SwKATBUbVHN9K7z
	cB5pVjolrW3FHyc27rtRsFMNeZ0yppT/uIvg9EP84mckSRWCQyE3MaJUC65iDL+i
	Yqop/V/bXvHYVy7KilKGcJ9orxaI7fWzjCn5HVZlmoMAqXwDnpLN9oNwJbpaTub/
	Z0TYAmF5OZk0jqpFp6fl9fB2BLAtLcyjG0OwLiyK3BWzk5E7T0/SP/b1yMLJ2IuI
	H6xWavxaC1esQ4xxJ+hI8mM0L7a5nQwem3/DM12VvgDAv55NUyPe4PAQVzodE9hY
	sbcgBUUweH8ESTUAOHefo16UQKkEJ3KAJt62vqfbVXs7Gk1g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44852d26vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jan 2025 16:42:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50JGgVSQ015017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jan 2025 16:42:31 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 19 Jan 2025 08:42:29 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <tharvey@gateworks.com>
Subject: [PATCH 0/2] wifi: ath11k: Fix SWIOTLB issues with DMA buffer allocation
Date: Sun, 19 Jan 2025 22:12:17 +0530
Message-ID: <20250119164219.647059-1-quic_ppranees@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2OCS3PcD_oN2AJv3SyNIRolSe7Qa_Qgd
X-Proofpoint-GUID: 2OCS3PcD_oN2AJv3SyNIRolSe7Qa_Qgd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-19_03,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=735
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501190131

This patch series addresses issues related to DMA buffer allocation in
the driver, specifically targeting systems without IOMMU that use
SWIOTLB. The current implementation leads to "swiotlb buffer is full"
errors and driver initialization failures. The patches aim to resolve
these issues by replacing the flawed buffer allocation mechanism with
the appropriate DMA API.

Note: This issue was reported on the ath11k public mailing list
(Re: ath11k swiotlb buffer is full on IMX8M with 4GiB DRAM). Although I
couldn't get a local setup with swiotlb configuration similar to the
reporter's, I have validated the ring setup and peer TID setup where these
changes are present.

P Praneesh (2):
  wifi: ath11k: Fix DMA buffer allocation to resolve SWIOTLB issues
  wifi: ath11k: Use dma_alloc_noncoherent for rx_tid buffer allocation

 drivers/net/wireless/ath/ath11k/dp.c    |  35 +++----
 drivers/net/wireless/ath/ath11k/dp.h    |   6 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 117 +++++++++++-------------
 3 files changed, 69 insertions(+), 89 deletions(-)


base-commit: 6a5fe6aaedcfadf8e32dd703ec20b1460523c22d
-- 
2.34.1


