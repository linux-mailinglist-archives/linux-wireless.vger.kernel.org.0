Return-Path: <linux-wireless+bounces-17217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532CDA06CF3
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 05:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 251467A34B3
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 04:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC9A1922C4;
	Thu,  9 Jan 2025 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GyF4sRqR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC918FDC9;
	Thu,  9 Jan 2025 04:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736396762; cv=none; b=f0Mstu8t0dR0fT1Emw/DvSQPTeb/MSE0MM9z49GwDlxBBEjYd273h6ETHegiVoN2ZAnRsONAe1/3TdJ4hrUG/dNv9hmYxAWIcNQZvwJPJCvJxeGsVYCnSW4yS6g28oytmJne3XHbJkXhi3rscpdW7E6qHCToWq9634qLiV8nAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736396762; c=relaxed/simple;
	bh=f0ETU/jWMRf5lP4vaMurRdqKUsUbLfLFxBdzSvs+Z98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=F/XBP39rawzWWRBSSBW8yq+STgIQFR1WrurlKBE5MBxZfeG1+BImf05AA3S/8H4CxFd7mKyZ2py4EIxaoT2EAPcmEUW8/z2eeygRzrcID9HTnmKMNMGh4KtY+pZMjhf2BLZVuRoLOY+jgK0AxJvIWNnaBpjpTjkeY1sbkJp5so8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GyF4sRqR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5090FkVT010486;
	Thu, 9 Jan 2025 04:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vxZzJdfPC1g+PoDseLlT41ZOkXs3uhDu6V7zXJodmjk=; b=GyF4sRqReN0DyjjH
	TQ4Y+y6yybdot+WuRCNPPxLTSaTe8oyGMk1qBG6CeUc7MoBx3sbsLPdJ+m+I9UuP
	gJZuEFJZIzVvwQXb+Cplx8NZatgsEHkKUPpNix5PSipH5l1KUJK1ycR1UaA5TUjJ
	OF0GfLrzRryO4GH7h3Vaf5+ZQyzRyAMi0ZbU3F6fcoUcxIlNnmOVEhnAx2k1nfJT
	MmfHxW7AJA/tu9iLcFpUodoon9ANKD7Ag3AGocBvOfISNMeCHNb6b4+gcvcubOlN
	9gf2RPwRycH5PKx3PdnrkBIo2OZQ+eAhNT2geIpfjrv7S4900InNVzczp9+P8iD+
	HWoUXQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4423rqrfv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 04:25:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5094PvgY010373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 04:25:57 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 Jan 2025 20:25:54 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Thu, 9 Jan 2025 09:55:33 +0530
Subject: [PATCH 05/10] wifi: ath12k: fix SLUB BUG - Object already free in
 ath12k_reg_free()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250109-fix_reboot_issues_with_hw_grouping-v1-5-fb39ec03451e@quicinc.com>
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
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
X-Proofpoint-GUID: 5rmsCIumhrFRVvpp4EhH5HdDxD96abg0
X-Proofpoint-ORIG-GUID: 5rmsCIumhrFRVvpp4EhH5HdDxD96abg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=69 phishscore=0 clxscore=1015 mlxlogscore=851 impostorscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=69 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090033

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

To resolve this, a new member regd_freed is introduced in the ath12k_base
object. Once regd is freed, regd_freed is set to true. This ensures that
in the removal context of other devices, regd is not freed again if
regd_freed is already true. And since there could be a race condition to
read this member, guard ath12k_core_soc_destroy() with the mutext lock.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 2 ++
 drivers/net/wireless/ath/ath12k/core.h | 1 +
 drivers/net/wireless/ath/ath12k/reg.c  | 8 +++++++-
 drivers/net/wireless/ath/ath12k/wmi.c  | 4 +++-
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 299d7686616b78752164d9cb064c1805af9a1155..72e6e3a0cf7be03b20b7421866c479dfcb8038ff 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1757,7 +1757,9 @@ static void ath12k_core_hw_group_destroy(struct ath12k_hw_group *ag)
 		if (!ab)
 			continue;
 
+		mutex_lock(&ab->core_lock);
 		ath12k_core_soc_destroy(ab);
+		mutex_unlock(&ab->core_lock);
 	}
 	mutex_unlock(&ag->mutex);
 }
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 58ebc56991af99de08e8ed783e98f742a687eddf..cc1bfcc1e65c87e30d86dad4c0bcd1905e6a2f51 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -961,6 +961,7 @@ struct ath12k_base {
 	 * This may or may not be used during the runtime
 	 */
 	struct ieee80211_regdomain *new_regd[MAX_RADIOS];
+	bool regd_freed;
 
 	/* Current DFS Regulatory */
 	enum ath12k_dfs_region dfs_region;
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 439d61f284d89222e79c05d6cff8e85d0d315aad..b4d7fa1a04ca0e72728e8989c29b82d089171fc2 100644
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
@@ -777,8 +777,14 @@ void ath12k_reg_free(struct ath12k_base *ab)
 {
 	int i;
 
+	if (ab->regd_freed)
+		return;
+
 	for (i = 0; i < ab->hw_params->max_radios; i++) {
 		kfree(ab->default_regd[i]);
 		kfree(ab->new_regd[i]);
+		ab->default_regd[i] = NULL;
+		ab->new_regd[i] = NULL;
+		ab->regd_freed = true;
 	}
 }
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 4dd6cdf84571d3652cd03281ffa6486e3d340c42..1de6ed6cceaee3a22de63a2369358fe53fb0d638 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -5950,6 +5950,8 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 		/* This regd would be applied during mac registration */
 		ab->default_regd[pdev_idx] = regd;
 	}
+
+	ab->regd_freed = false;
 	ab->dfs_region = reg_info->dfs_region;
 	spin_unlock(&ab->base_lock);
 

-- 
2.34.1


