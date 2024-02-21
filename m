Return-Path: <linux-wireless+bounces-3831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F8585CE4B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 03:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C569B24E48
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 02:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C1728374;
	Wed, 21 Feb 2024 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Eu3xXQGj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810142B9D6
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483670; cv=none; b=Hwt2ly+jpCfhNYvWW3lb7x41hdljBP5TLQT4K2RBPMoWk08UWj/6upk5Ty1KWSupmHAd9OElrbHnzAST1t2YDJmJAkd3t5p9BdK7SWFFb0Rj6HyjLpzrs4c9hjvVGeok8yGQexrdkTY1S+aBx+V+5ojaRhO9BhVhaYlE0MCm9rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483670; c=relaxed/simple;
	bh=sldRxAWDtkMaXQnr8nOfL2e9UEkOsGOKnKHccx1Mz6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9r5Mfb6D0DHAy2BeDNCMjvaIAGmUr+wI0mppynx7TMP8gRKoDpbGq0YxZ6mHiDXgITsc+65TCSjr2N+EZs1vrAvkgwthV7eUsDnLwo9qPlrWZ3Ffw+BL6NEgzFDLLn5Iwzr0Hce1j/3sI1YUCSm7N70g/fGLyyLWnwPO0Edqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Eu3xXQGj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L2MMi5012011;
	Wed, 21 Feb 2024 02:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=qOMthkJSSuF/rFQcDtP0nI1AWdAT83mtw6UiamFQT1k=; b=Eu
	3xXQGjYwzjCSmeLui+LxgJlt9z0/tD0tbu/IcLboWx1gXAbWOjuzPY+9njq9xwMV
	S8slNkMeK8ZpdEEgbFj3kCg4gsIOWraX3vsUPCWCJK5cWu2MO+XWB/5HEhByaYh7
	G8x84UNClCG0J9wn2fyty3Qj+aq7YbyCg2sGxx9SeoFfcOwh9gdq/PjI3t9gcJwD
	ZUWnpVq19oQc0dgiJY2BBZJfJ5hmbOgVlJp1hd7UyozjvzXoKXo9ZJVhamiveY9o
	GmsD91BFQuqVqadYJQPMaUCDS2nLVuyoq5GQ2T/BmLgiCgFIt/5FSnJ0cWnQUyqX
	8TetOaVNYxP3jhokKPjg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21s8sea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 02:47:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41L2lkkt000814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 02:47:46 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 18:47:45 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 5/5] wifi: ath11k: thermal: don't try to register multiple times
Date: Wed, 21 Feb 2024 10:47:25 +0800
Message-ID: <20240221024725.10057-6-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221024725.10057-1-quic_bqiang@quicinc.com>
References: <20240221024725.10057-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: BaFrx51x8GL4s67XgfFm8L2824hw7w3W
X-Proofpoint-GUID: BaFrx51x8GL4s67XgfFm8L2824hw7w3W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=743
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210018

From: Kalle Valo <quic_kvalo@quicinc.com>

Every time the firmware boots we call ath11k_core_qmi_firmware_ready() which
ends up calling ath11k_thermal_register(). So we try to register thermal
devices multiple times. And when we power off the firmware during
suspend/hibernation (implemented in the next patch) we get a warning in resume:

hwmon hwmon4: PM: parent phy0 should not be sleeping

Workaround this similarly like ath11k_mac_register() does by testing
ATH11K_FLAG_REGISTERED.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/thermal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/thermal.c b/drivers/net/wireless/ath/ath11k/thermal.c
index c29b11ab5bfa..41e7499f075f 100644
--- a/drivers/net/wireless/ath/ath11k/thermal.c
+++ b/drivers/net/wireless/ath/ath11k/thermal.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/device.h>
@@ -163,6 +163,9 @@ int ath11k_thermal_register(struct ath11k_base *ab)
 	struct ath11k_pdev *pdev;
 	int i, ret;
 
+	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
+		return 0;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
-- 
2.25.1


