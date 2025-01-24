Return-Path: <linux-wireless+bounces-17914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D0BA1BC7B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 19:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681CC1890DEC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 18:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFE01DA2F1;
	Fri, 24 Jan 2025 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="knywJOkZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7984146A9B
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744823; cv=none; b=UniULfMTTh9gZ+3Z2Dz2t4BmTgwvicX0jhCcG6yHKfFCoP2NxRQ7faNjPx/fZXztT6L9XEiwMVNIAEiNDB3OkQ0//dT5U0eWvEdgoxSPoYx23Fft//DoWQB07sZ/5MKsVpyDZbIwSf63P/Rt/OiFPQHCqjjrUawhptCu78F7p2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744823; c=relaxed/simple;
	bh=izH+BlJLtx7QnQlQkdLxDq0MHYSDkGVNqzmzV89fxGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dHvt5VUSgWO+oVc1M+qCnu7E7KNp2g9SikkNLd4RapygQfb7jS7QaDUO6K5DTKjaeCQUSulG719GqZ3DESIRVm2xWMA9zpJe1/vjaufzV9nUqtp2zSQkVR1asuvb8j5Xrfvtisbq8/CKwBTPiAJG4wgcJcxXcOs2TGxZ9JLhbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=knywJOkZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OAh17K015702;
	Fri, 24 Jan 2025 18:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=j99v4ycCMTPt9FwctWp2BIMoa9AN4TefBR7
	8xhGNeRg=; b=knywJOkZsTx/kjT0srArESQcLg2gWACW32HA2sPjGaY/3fsA4P6
	6e87X0sYE+rOlmlmYptTvaXt7vg+a+Ru5nMo+H+sb8BR13gzAdKObXDKrRv1eeRt
	bNfRco1iLqOVOTGVWP51mRqhRIBvC6s8aFXV0HVsJ42j0xXosk+hexJXN+tZdoZ/
	JL8c81uOtTdXgxHwnK7Np7IKTUr2o+RTyGAfuHLDT30mSLxOQbMtezJCH0warhc7
	o8U1bDhVb5tv4byuhiywN5jexvXYOvYXcQdhqnih/o1VB8PlLNIabcH9VXMq0yFz
	A/YhyJzHk+ERi+r5mfejM8uUCiqmOxHdhcw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c9bt164e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 18:53:37 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIrYWn013024;
	Fri, 24 Jan 2025 18:53:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4485cmbfnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 18:53:34 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50OIrXVM013018;
	Fri, 24 Jan 2025 18:53:33 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 50OIrXf1013017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 18:53:33 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id E3A984116F; Sat, 25 Jan 2025 00:23:32 +0530 (+0530)
From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Subject: [PATCH ath-pending 0/3] Support to request pdev, vdev and beacon stats
Date: Sat, 25 Jan 2025 00:23:27 +0530
Message-Id: <20250124185330.1244585-1-ramya.gnanasekar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _6wmV9uQFQV22TFPP4qAcxdmaTmXNHga
X-Proofpoint-GUID: _6wmV9uQFQV22TFPP4qAcxdmaTmXNHga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=867 spamscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240130

PDEV, VDEV and beacon stats will be maintained in firmware by
stats module. These stats can be requested by host through
WMI cmd on demand and can be used for debugging.

This patch creates debugfs file for each stats which sends
request to firmware upon read and print the corresponding information.

ath12k
`-- pci-0000:06:00.0
    |-- mac0
        `-- fw_stats
            |-- beacon_stats
            `-- pdev_stats
            `-- vdev_stats

Ramya Gnanasekar (3):
  wifi: ath12k: Request vdev stats from firmware
  wifi: ath12k: Request beacon stats from firmware
  wifi: ath12k: Request pdev stats from firmware

 drivers/net/wireless/ath/ath12k/core.h    |  89 ++++
 drivers/net/wireless/ath/ath12k/debugfs.c | 380 ++++++++++++++++-
 drivers/net/wireless/ath/ath12k/debugfs.h |  13 +-
 drivers/net/wireless/ath/ath12k/wmi.c     | 482 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     |  77 ++++
 5 files changed, 1039 insertions(+), 2 deletions(-)


base-commit: 74557cbe44f8186f8e97443be258293479eddc8e
-- 
2.34.1


