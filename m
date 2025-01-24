Return-Path: <linux-wireless+bounces-17877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B545A1AF77
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 05:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FE03A86D6
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 04:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8D31D63E1;
	Fri, 24 Jan 2025 04:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SeOBU7nm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161A1A29;
	Fri, 24 Jan 2025 04:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737693715; cv=none; b=tN/fa7TnpbN95dzwsbcPX92oVcRejR0ZiirrjDso3z8OCWzYLJm/qaBrR6A3twoL3sXY4Pj/+YBzvQMIJSHxeOP2zWiMRi7MuJzZSnjE9Toq7/s8T7vLRybqDYq2JJjTS9urzztFaiwa1gWqzysCOP/oC+Eb0uG1POJuWAjfJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737693715; c=relaxed/simple;
	bh=2KG7ROjMTYLz7NM2h0oim6ye3r5B0xPIDITc6RMdu7g=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=lEp30o3DtHk8mSFoZwB5JkI1Jv6Yw+LmTF4a6bhGr90p2MuYGmaXodNXvxnHUUEhaJueaz1P7/jOnxFgyc7EnzPGNk5ZndVydzfuS73IYRqMgx4TTmRmUqakH3OkJEKIQ7lDo3VADesatjA2h4qh2vRWzQzOzAaX1WLCx9qgeNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SeOBU7nm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O2sBD0006513;
	Fri, 24 Jan 2025 04:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lCMm72Yc95C6M7gLauNxyw
	e13Z+FSUIeHwvYuMrsiTA=; b=SeOBU7nmRdNwNMRUMNP9B/D/2bUQZLrCsXQgqR
	2twDawr30IYEEStBJ82ahac+vxH5G2Ig1eVWQBXft9VMOBJ+SwrvjdAQA+xXY50c
	MtDyJCmUR9yhUQy2ykTcEsKq4tUWnMW9gJM0zNfPP2rPrswJ3ayGiw/fduSTSvgY
	OOcpiH7mt9ijxkS31vXbxWhToM0kQG+6f9+pvb1WU6fskJKccfxJznqI4NaCWm5Z
	Wob9X+2n+hR5FV2g112U7xjs8BsxgzZA6/h6a1RqMTDRjSF/47nFTVq6lbwGrp0f
	TIyUALZk09H63oUIezMJDN/ZJcTk6Ij42C06Dv3rHXH+jLbg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c2fu86b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 04:41:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O4fj2Z023479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 04:41:45 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 Jan 2025 20:41:42 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 00/10] wifi: ath12k: fixes for rmmod and recovery issues
 with hardware grouping
Date: Fri, 24 Jan 2025 10:11:23 +0530
Message-ID: <20250124-fix_reboot_issues_with_hw_grouping-v3-0-329030b18d9e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPMZk2cC/43NQQ6CMBCF4auYrq1pp2DRlfcwpqFloLOQaguoI
 dzd4kp3Lt8k8/0zSxgJEztuZhZxokShz0NtN8z5uu+QU5M3AwGFBFnxlp4mog1hMJTSiMk8aPD
 GP0wXw3ijvuPCQaP2ui4rbVmGbhHz1ydyvuTtKQ0hvj7NSa7XlS+FFId/+ElywVurDuiEKkqJp
 /tIjnq3c+HK1sAEXyiIv1DIqNWN0MpaqAF+0WVZ3hpCdTYrAQAA
X-Change-ID: 20241218-fix_reboot_issues_with_hw_grouping-0c2d367a587b
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
X-Proofpoint-ORIG-GUID: Bybaqnl1YQ3SKqWdkgE31mhP83RGKcsL
X-Proofpoint-GUID: Bybaqnl1YQ3SKqWdkgE31mhP83RGKcsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_01,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=790
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240031

With hardware grouping, there is a kernel crash with signature -

$ rmmod ath12k.ko
Unable to handle kernel paging request at virtual address 000000000000d1a8
[...]
Call trace:
 ath12k_reg_free+0x14/0x74 [ath12k] (P)
 ath12k_core_hw_group_destroy+0x7c/0xb4 [ath12k] (L)
 ath12k_core_hw_group_destroy+0x7c/0xb4 [ath12k]
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
 do_el0_svc+0x1c/0x28
 el0_svc+0x30/0xd0
 el0t_64_sync_handler+0x10c/0x138
 el0t_64_sync+0x198/0x19c
Code: a9bd7bfd 910003fd a9025bf5 91402015 (f968d6a1)
---[ end trace 0000000000000000 ]---
Segmentation fault

This series aims to fix this stability issue. With this now, 100+ iteration
of rmmod and insmod works perfectly.

Also, firmware recovery with grouping is not working fine. Randomly, some
NULL pointer crash or another firmware assert is seen. This series aims to
fix that as well.

With this in place now, 100+ iteration of firmware recovery with one 3 link
AP MLD up works fine.

---
Changes in v3:
- Rebased on ToT due to FTM changes conflict.
- Link to v2: https://lore.kernel.org/r/20250120-fix_reboot_issues_with_hw_grouping-v2-0-b7d073bb2a22@quicinc.com

Changes in v2:
- Rebased on ToT.
- No changes in 1-4, 6-10.
- Removed regd_freed flag in 5.
- Link to v1: https://lore.kernel.org/r/20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com

---
Aditya Kumar Singh (10):
      wifi: ath12k: prevent race condition in ath12k_core_hw_group_destroy()
      wifi: ath12k: add reference counting for core attachment to hardware group
      wifi: ath12k: fix failed to set mhi state error during reboot with hardware grouping
      wifi: ath12k: fix firmware assert during reboot with hardware grouping
      wifi: ath12k: fix SLUB BUG - Object already free in ath12k_reg_free()
      wifi: ath12k: fix ath12k_core_pre_reconfigure_recovery() with grouping
      wifi: ath12k: fix ATH12K_FLAG_REGISTERED flag handling
      wifi: ath12k: handle ath12k_core_restart() with hardware grouping
      wifi: ath12k: handle ath12k_core_reset() with hardware grouping
      wifi: ath12k: reset MLO global memory during recovery

 drivers/net/wireless/ath/ath12k/core.c | 115 ++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/core.h |  15 +----
 drivers/net/wireless/ath/ath12k/mac.c  |   6 --
 drivers/net/wireless/ath/ath12k/pci.c  |  26 +++++++-
 drivers/net/wireless/ath/ath12k/qmi.c  |  24 ++++++-
 drivers/net/wireless/ath/ath12k/qmi.h  |   4 +-
 drivers/net/wireless/ath/ath12k/reg.c  |   4 +-
 7 files changed, 162 insertions(+), 32 deletions(-)
---
base-commit: 376673aa393c1c232299be3e910d7f2e6d974b2f
change-id: 20241218-fix_reboot_issues_with_hw_grouping-0c2d367a587b


