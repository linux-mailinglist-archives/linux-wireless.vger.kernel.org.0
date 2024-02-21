Return-Path: <linux-wireless+bounces-3829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85B885CE49
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 03:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83121285C82
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 02:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482F92574F;
	Wed, 21 Feb 2024 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TwVzVzyP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B046A4
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483669; cv=none; b=UA3i780gzQv+b4SYO3kpUcAR3i+Zwt3Ujc6ujPlzpCP4smEBqXoyHP3EomM8UTxGJrJ9GeTl4eSNhNaGcNaRuM1sHgDbo55OLd03BJY8RI4JnlM3LskVe+d4krGlnJQ34e/iZ6oLfIo439z2hVoFm3Cir/szCttgVCyDji1oGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483669; c=relaxed/simple;
	bh=ITSrci/+fPsHRAeoGPAUsqKJp0R3sFsg4i840JG17KA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMuXcUN+RCHft+mV4F/Axy/SIMjKGlDwGlfAk8A90SvnbuObMl2oJ/L3HfxHziZGQaIdleKrp2j97RYx+n3+7bCU7Mn/mu/Xp6TvUtYyWJ0sTocoP2fC4Vn+UjgZBzzeS8zcAdfyCtv7QXLhPo+DXnP0ti/KUPXE+vzX74DGxfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TwVzVzyP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L1PDY6008305;
	Wed, 21 Feb 2024 02:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=bOo75mXWRxzMckCc4/0xO/N5O9w7e4WRwsbysYrHR6I=; b=Tw
	VzVzyP1iI/PFgrwts058yY5auAoh1XigWdcNg+m3N0aPaC/HVcTcwtkUrVbRTES4
	N3otUgc1oomIJAgq2AuOqxuOzW0uQwI7PtlKEyx3YlnUq16MyalSMYyrhwWP0I5J
	Hlr80VfrGdsuSs3gu/0BOopZLKtwTAwJI6nP+eipqf8L9Djj5cp0UnQK4Wv5h4Gs
	HsRnop1jRy1pGRy8M6LgDcaBhDSc8DmPWGZm7HC/E7hpZolZ5iHJ2BBHDxPszyZe
	zL0La3WhHjXXInj299R+S4sodDbHPO8uQM0gUGwuePu6Wgpx0IFhWgF17R3LdyXa
	xP6nIwNOq5a2Mfc5sdXg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21s8se9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 02:47:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41L2likj000801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 02:47:44 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 18:47:42 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 3/5] wifi: ath11k: do not dump SRNG statistics during resume
Date: Wed, 21 Feb 2024 10:47:23 +0800
Message-ID: <20240221024725.10057-4-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: YnM5OeL98Xkgdpr6kBAK0fzKNpPp0Krn
X-Proofpoint-GUID: YnM5OeL98Xkgdpr6kBAK0fzKNpPp0Krn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=912
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210018

Both the firmware reset feature and the power management
suspend/resume feature share common power-down and power-up
functionality. One aspect of the power-up functionality is
the handling of the ATH11K_QMI_EVENT_FW_INIT_DONE event.
When this event is received, a call is made to
ath11k_hal_dump_srng_stats(), with the purpose to collect
information that may be useful in debugging the cause of a
firmware reset.

Unfortunately, since this functionality is shared between
both the firmware reset path and the power management
resume path, the kernel log is flooded with messages during
resume. Since these messages are not useful during resume,
and in fact can be confusing and can increase the time it
takes to resume, update the logic to only call
ath11k_hal_dump_srng_stats() during firmware reset.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 2c7cab62b9bb..5006f81f779b 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/elf.h>
@@ -3249,7 +3249,8 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 		case ATH11K_QMI_EVENT_FW_INIT_DONE:
 			clear_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
 			if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)) {
-				ath11k_hal_dump_srng_stats(ab);
+				if (ab->is_reset)
+					ath11k_hal_dump_srng_stats(ab);
 				queue_work(ab->workqueue, &ab->restart_work);
 				break;
 			}
-- 
2.25.1


