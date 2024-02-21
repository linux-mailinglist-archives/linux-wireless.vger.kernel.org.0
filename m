Return-Path: <linux-wireless+bounces-3830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E74185CE4A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 03:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A991F22341
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 02:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC042B9D2;
	Wed, 21 Feb 2024 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TdnKhN1S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0515828374
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483669; cv=none; b=g3Ur+KIJ3qj0WPv7wSPnEWKadUACGw9whnfOmiOVX3IOs9HSwMnJkM9W4ueXWIzAdSagcZgg5ja7vNiDXEPMIyl6BchP0w1ecvw3CEu65pZ0D4vsKpPbIJy2C/u7pk5JxjGHXdBoOaVZmKjdu3mPdd+ksmt9b/USzxKKpQd9v4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483669; c=relaxed/simple;
	bh=rARB86zLQ/R11pwj86wYvpwUZjGkj8RncVodsytdLug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+6ESZXgJx9npWOGc1Ca0wyOUzhCqGcfFciCTqzJBLvGagvq7QxlaGLcC3H0EYPrKEQCWWY7Yaxyu5O2p+Eyb7ny+D7UCYqyzrsWQa0hZsuxDUYHfvD84d6VxiyBbjUzzTYi+CqYsw0f79oJmRk0maFXzuBtsAX4W0LTGlLidng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TdnKhN1S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L1dZI2018920;
	Wed, 21 Feb 2024 02:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=kJ4x8U2l7qpUZ2dOQIK+M4NHuxsHy1RIwHSQgS/Pn8M=; b=Td
	nKhN1SF9KYIXT+tr7oHlkxm1eGGKGJ76h/hwPT8mg/qx8AkE07bTpcZfbZcI+EKp
	mHLQt1fjUwsudH6B2hB2LyDZxuseSkh///eWLZxxsyX/b2i8Hel1CDUCHELp/IrH
	uexh6N+87fT4Isen7+3sUpIAgNBVuFgCkV4pSJST3rc5akzEps6cVsrF3N3DOVte
	4l0uetl0dJFFezxrokn1xdD3yJK+yyE/xXKiLEGOjVOcDRy1DPTsIJ09j7A6QcPX
	bRGPu6RY+M5KeJVKcXrtbs1YoYAf4MGDDU4vPnjlJ+9ccVIGBvCPBQ+RgngTmyd5
	ZDIPfTpLS2iMTCj3PuWw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21urs4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 02:47:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41L2ljA9006858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 02:47:45 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 18:47:44 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 4/5] wifi: ath11k: fix warning on DMA ring capabilities event
Date: Wed, 21 Feb 2024 10:47:24 +0800
Message-ID: <20240221024725.10057-5-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: nA1mQvHKiIQAKdsRXlUYir0n0FMTFwGS
X-Proofpoint-ORIG-GUID: nA1mQvHKiIQAKdsRXlUYir0n0FMTFwGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=506 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210018

We are seeing below warning in both reset and suspend/resume scenarios:

[69663.691847] ath11k_pci 0000:02:00.0: Already processed, so ignoring dma ring caps

This is because ab->num_db_cap is not cleared in
ath11k_wmi_free_dbring_caps(), so clear it to avoid such
warnings.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index b2911d6f9551..75fae1e01130 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -4858,6 +4858,7 @@ static void ath11k_wmi_free_dbring_caps(struct ath11k_base *ab)
 {
 	kfree(ab->db_caps);
 	ab->db_caps = NULL;
+	ab->num_db_cap = 0;
 }
 
 static int ath11k_wmi_tlv_dma_ring_caps(struct ath11k_base *ab,
-- 
2.25.1


