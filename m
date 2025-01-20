Return-Path: <linux-wireless+bounces-17744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A066AA169EC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 10:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBEE1885628
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDCE1B85D6;
	Mon, 20 Jan 2025 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RmlKnaP9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF071B4F1F;
	Mon, 20 Jan 2025 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366537; cv=none; b=jsl7NKwUN5+i/Cz5p810rNr/Gxnx1VhKLriC1AqUSEgYCQodqT4FW/EzfZ00P48eMNxpHF4q2H8bNVt5q9el5tsk++kyaaWOVZIOVujtSrBzYD0grvIOAk+zETWHHo4q5uNqaosoNAnRZpnQF3ol5yLOpRvgyDFC0bF7bS9mtgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366537; c=relaxed/simple;
	bh=m/3973Tx9C7i4ouGiQN0E3F3fIN8ZhbQRAj5rYsHB/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y5bG9j2o//baa7qQ1gnzhLHBAkIXqFabbwcCFnd5ZBy3zc6ceSwAKnHifDOgYV9tgYGTfFNj6UAcyudXB/MWJtQ2sSwCxwtqt0MV0ROfi6jBMPxxZ4KDG1ZHY/EwctBGiLct6wxYmAdU2hrwwKS/9vGsIx9W6fjNVzbiBjxskEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RmlKnaP9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K5aGOr015388;
	Mon, 20 Jan 2025 09:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jr5cQD8gHRF6Z5Zy19s+sogT9VbViJZ64jKtztndFDU=; b=RmlKnaP99es4J83S
	D8Td3y78uW6fJ5SNP5bJNBAIMGXgsbbwNr3iJuKBUyFKeceo0C8+8DjMJFskjDlP
	l6n+1K1mmYzrZg6V2bbyAqclRanHLEGIH4S3GiW16MsWdEWXASoho4keGK/6ThLD
	2KnN6nZv/NXc10ulXq30ZAE+ycTQ1zh/4uLQgvzkg326nDLsjJMaXl7+F6/chejJ
	T1BdVIFu/BiN+m1ntpe8bAsO9UZbayCJyQllK0olhCYZSSwYY8Bq1YnBgActE7Ve
	UA31/yXsoNoMn51GAmLlVy1Wlsvhlkp/XuvdBVhgHVGp6bfm/7LUiVOdr6/ZCqqm
	/iCA5Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 449gfr8pvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:48:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50K9mprX005504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:48:51 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 20 Jan 2025 01:48:48 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Mon, 20 Jan 2025 15:18:25 +0530
Subject: [PATCH v2 05/10] wifi: ath12k: fix SLUB BUG - Object already free
 in ath12k_reg_free()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250120-fix_reboot_issues_with_hw_grouping-v2-5-b7d073bb2a22@quicinc.com>
References: <20250120-fix_reboot_issues_with_hw_grouping-v2-0-b7d073bb2a22@quicinc.com>
In-Reply-To: <20250120-fix_reboot_issues_with_hw_grouping-v2-0-b7d073bb2a22@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem
	<quic_hprem@quicinc.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Kalle Valo
	<quic_kvalo@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Aditya Kumar
 Singh" <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7jTrnDaSOJh7rPFIXXMFQlieZpOMfpQA
X-Proofpoint-GUID: 7jTrnDaSOJh7rPFIXXMFQlieZpOMfpQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=96
 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=96
 mlxlogscore=604 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200081

During rmmod of ath12k module with SLUB debug enabled, following print is
seen -

=============================================================================
BUG kmalloc-1k (Not tainted): Object already free
-----------------------------------------------------------------------------

Allocated in ath12k_reg_build_regd+0x94/0xa20 [ath12k] age=10470 cpu=0 pid=0
 __kmalloc_noprof+0xf4/0x368
 ath12k_reg_build_regd+0x94/0xa20 [ath12k]
 ath12k_wmi_op_rx+0x199c/0x2c14 [ath12k]
 ath12k_htc_rx_completion_handler+0x398/0x554 [ath12k]
 ath12k_ce_per_engine_service+0x248/0x368 [ath12k]
 ath12k_pci_ce_workqueue+0x28/0x50 [ath12k]
 process_one_work+0x14c/0x28c
 bh_worker+0x22c/0x27c
 workqueue_softirq_action+0x80/0x90
 tasklet_action+0x14/0x3c
 handle_softirqs+0x108/0x240
 __do_softirq+0x14/0x20
Freed in ath12k_reg_free+0x40/0x74 [ath12k] age=136 cpu=2 pid=166
 kfree+0x148/0x248
 ath12k_reg_free+0x40/0x74 [ath12k]
 ath12k_core_hw_group_destroy+0x68/0xac [ath12k]
 ath12k_core_deinit+0xd8/0x124 [ath12k]
 ath12k_pci_remove+0x6c/0x130 [ath12k]
 pci_device_remove+0x44/0xe8
 device_remove+0x4c/0x80
 device_release_driver_internal+0x1d0/0x22c
 driver_detach+0x50/0x98
 bus_remove_driver+0x70/0xf4
 driver_unregister+0x30/0x60
 pci_unregister_driver+0x24/0x9c
 ath12k_pci_exit+0x18/0x24 [ath12k]
 __arm64_sys_delete_module+0x1a0/0x2a8
 invoke_syscall+0x48/0x110
 el0_svc_common.constprop.0+0x40/0xe0
Slab 0xfffffdffc0033600 objects=10 used=6 fp=0xffff000000cdcc00 flags=0x3fffe0000000240(workingset|head|node=0|zone=0|lastcpupid=0x1ffff)
Object 0xffff000000cdcc00 @offset=19456 fp=0xffff000000cde400
[...]

This issue arises because in ath12k_core_hw_group_destroy(), each device
calls ath12k_core_soc_destroy() for itself and all its partners within the
same group. Since ath12k_core_hw_group_destroy() is invoked for each
device, this results in a double free condition, eventually causing the
SLUB bug.

To resolve this, set the freed pointers to NULL. And since there could be
a race condition to read these pointers, guard ath12k_core_soc_destroy()
with the mutex lock.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 2 ++
 drivers/net/wireless/ath/ath12k/reg.c  | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 05a914a3f8555236deeab89729d02527e7b4d786..988fb25778b9d3b62544719200ca505eb6bcfd80 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1761,7 +1761,9 @@ static void ath12k_core_hw_group_destroy(struct ath12k_hw_group *ag)
 		if (!ab)
 			continue;
 
+		mutex_lock(&ab->core_lock);
 		ath12k_core_soc_destroy(ab);
+		mutex_unlock(&ab->core_lock);
 	}
 	mutex_unlock(&ag->mutex);
 }
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 439d61f284d89222e79c05d6cff8e85d0d315aad..e34ae29a8a50fcd9452f7d9456b7be7a8ded6f9f 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/rtnetlink.h>
 #include "core.h"
@@ -780,5 +780,7 @@ void ath12k_reg_free(struct ath12k_base *ab)
 	for (i = 0; i < ab->hw_params->max_radios; i++) {
 		kfree(ab->default_regd[i]);
 		kfree(ab->new_regd[i]);
+		ab->default_regd[i] = NULL;
+		ab->new_regd[i] = NULL;
 	}
 }

-- 
2.34.1


