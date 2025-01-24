Return-Path: <linux-wireless+bounces-17887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4714A1AF8B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 05:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD6B188F0AD
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 04:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13121DA0E1;
	Fri, 24 Jan 2025 04:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KQUxy+Iv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386F1E7C10;
	Fri, 24 Jan 2025 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737693745; cv=none; b=s/3PMVJFBSlU2dzH1Ax1SYFnCyhctxeDjV6EZ9PlUsgr+ohGFKR03ZkVfeJmwttK++FLBfFDvCtiuImBH6/kDDREsxsQjZC/wgSJZVwIG5cPO61iG6HQ3yfWHkWJ9GibL8VIpMwC2T84mXAjxgZY4tMsqvjtPB29H/EDaGncNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737693745; c=relaxed/simple;
	bh=G9YaX6lg6PUZWKa0/qzVwTwtEzFZiBLGO6wdI0WvVZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QVD65HTIP1b6NKcSNFRoXSpPLGD058OoFsYApf/TFxHDcpCNFXNf0zbSijdZouQ2IG7bsqRoTgKD7H32PVdj4JHHy1GfS3dV78P4FYCMVuSyDPo9KJ7c/jbomuoqHipbU0hLHdkcukC8SdBkyfA/zzRqjWw3P7ZvUOqnFdbejAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KQUxy+Iv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NMmfGO004686;
	Fri, 24 Jan 2025 04:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zP7RrFAOL4PH6zJ33XrCt2576umP96pWh7xLXg8IscY=; b=KQUxy+IvqYFgVE+i
	WAPYTscW4RsmsMiUrVYQBVUJoKAhzIvgmEligN4MXYcpcL4gwcG7PxFxvyLEsAQ3
	G7VdHj3iPGYGvdhrxI/9MAx8GOWRkprhmgbcy3+4BZFuvbJaTVXLEsR+0Kp+EnyO
	Nkv9dKqfJNtBa0u+cmpv9ng+4t8wd+iWHkL5rv3tBYTOSHvd8Nz+vYkM7aywRZNT
	UMddOYS0LGA9CZrs+uoaRxljCMEv6+1LEjRJyU0QaxfCO9PwWF5VPW33wGHxcsuN
	2cjFjihSNTNpkJMIAGMEVW4eny74PabOMXGEQz4lwN7VkolOyi76ADu4vuSkP8K+
	dvonQw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bxvpgjyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 04:42:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O4gKbt023834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 04:42:20 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 Jan 2025 20:42:16 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Fri, 24 Jan 2025 10:11:33 +0530
Subject: [PATCH v3 10/10] wifi: ath12k: reset MLO global memory during
 recovery
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250124-fix_reboot_issues_with_hw_grouping-v3-10-329030b18d9e@quicinc.com>
References: <20250124-fix_reboot_issues_with_hw_grouping-v3-0-329030b18d9e@quicinc.com>
In-Reply-To: <20250124-fix_reboot_issues_with_hw_grouping-v3-0-329030b18d9e@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8Zs4IDL6hrgQSxt69Vl1ZRwF0zE1QDoO
X-Proofpoint-GUID: 8Zs4IDL6hrgQSxt69Vl1ZRwF0zE1QDoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_01,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240032

When operating with multiple devices grouped together, the firmware stores
data related to the state machine of each partner device in the MLO global
memory region. If the firmware crashes, it updates the state to 'crashed'.
During recovery, this memory is shared with the firmware again, and upon
detecting the 'crashed' state, it reasserts. This leads to a loop of
firmware asserts and it never recovers.

Hence to fix this issue,  once all devices in the group have been asserted
and powered down, reset the MLO global memory region.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  3 +++
 drivers/net/wireless/ath/ath12k/qmi.c  | 24 +++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/qmi.h  |  4 +++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 03860f635d0226e6f6c83aed7f316a1011bb46a7..d73543c1b51de41164c511a31e3fb0683b0be2fe 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1508,6 +1508,9 @@ static void ath12k_core_reset(struct work_struct *work)
 		return;
 	}
 
+	/* Prepare MLO global memory region for power up */
+	ath12k_qmi_reset_mlo_mem(ag);
+
 	for (i = 0; i < ag->num_devices; i++) {
 		ab = ag->ab[i];
 		if (!ab)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 5c3563383fabba779b0afd885802637fd5c53656..bc14fa106b27015b35641caac51fcb4b808e094d 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/elf.h>
@@ -2440,6 +2440,28 @@ int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 	return ret;
 }
 
+void ath12k_qmi_reset_mlo_mem(struct ath12k_hw_group *ag)
+{
+	struct target_mem_chunk *mlo_chunk;
+	int i;
+
+	lockdep_assert_held(&ag->mutex);
+
+	if (!ag->mlo_mem.init_done || ag->num_started)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(ag->mlo_mem.chunk); i++) {
+		mlo_chunk = &ag->mlo_mem.chunk[i];
+
+		if (mlo_chunk->v.addr)
+			/* TODO: Mode 0 recovery is the default mode hence resetting the
+			 * whole memory region for now. Once Mode 1 support is added, this
+			 * needs to be handled properly
+			 */
+			memset(mlo_chunk->v.addr, 0, mlo_chunk->size);
+	}
+}
+
 static void ath12k_qmi_free_mlo_mem_chunk(struct ath12k_base *ab,
 					  struct target_mem_chunk *chunk,
 					  int idx)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 45d7c3fcafdd7a0afa3d193cf612d255ca5a5e2e..1406ec372592b076dd0a5caef32044db238e352e 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_QMI_H
@@ -41,6 +41,7 @@
 #define ATH12K_BOARD_ID_DEFAULT	0xFF
 
 struct ath12k_base;
+struct ath12k_hw_group;
 
 enum ath12k_qmi_file_type {
 	ATH12K_QMI_FILE_TYPE_BDF_GOLDEN	= 0,
@@ -621,5 +622,6 @@ void ath12k_qmi_deinit_service(struct ath12k_base *ab);
 int ath12k_qmi_init_service(struct ath12k_base *ab);
 void ath12k_qmi_free_resource(struct ath12k_base *ab);
 void ath12k_qmi_trigger_host_cap(struct ath12k_base *ab);
+void ath12k_qmi_reset_mlo_mem(struct ath12k_hw_group *ag);
 
 #endif

-- 
2.34.1


