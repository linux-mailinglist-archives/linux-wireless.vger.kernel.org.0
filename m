Return-Path: <linux-wireless+bounces-17212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D837AA06CE7
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 05:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA953A61D1
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 04:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D078B13AD1C;
	Thu,  9 Jan 2025 04:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cyq+xO/H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCA2D052;
	Thu,  9 Jan 2025 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736396748; cv=none; b=YhoPu8J0LgHYxe3wf/SmG+Yl2Sxj8QqV/VtINbb4RVPfrF3x9HPhhRjP4L2ZzYy3IHSFE+oKDZFKABCGLN+6zItG4PB43KdzWJupAAbI4B3Esi+ZytN+zrRlnIKMZP9Uoa4+CyTa0CBFqU9hxb+zXWbtVRRhwQ4CdmcsMEbLH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736396748; c=relaxed/simple;
	bh=CJGy7dnBuF53o/8y7JvouGjeUW2oeb9qYK3DtiinzwI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Zdr5WKjegVV3Yl8H2iMbsm9MDLp7fwVkPOaIYH+c5LTwtcYTFRnPEKmsjEkwm46JTlWAoXtlPWctSKWfypQyLoVpiugmvx/2FdKG5ahKC5TtfldTdn6DjefyF9gVGHLpQiJ0LfOmDHviNQVjc0ZLoDmh1GvqOhRxInX7nLtdb/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cyq+xO/H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508IglWB007975;
	Thu, 9 Jan 2025 04:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=a2ctkO2yF5cEZldWqDnjtx
	2KBzjZhiPvxUx3EFteP6Q=; b=cyq+xO/HG44vrkoewkD50tlHeoClQ4Zp1YVfHS
	Nr4DM9xuZzSLtieduGEqaJVkbw+KFkhSb4m0GMTS9ESUTy3bu7dQsIXY1srCFBRZ
	ZyxafiWHQJ1CP+R24/NndrNOXn8zjI3tq9s4Gg641vm9wf6Sl2dQivxE+FqIklBy
	FLH4oixCg88G1ViI1sHSBPKKRMPpl1rZZ0Mwi6PchHOIHrGk7BVRYQIxpzbuCe7K
	urDqGp01xHsprwGME8lUtf6hIxI7vQNkcbNycmlX2cJT66lZJQcJKXVziuXPAXOX
	jY51ez1JXj2hffXpib9On5tgzFUKLueVIXsP6Mi1tcAXUupg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441xvns48d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 04:25:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5094Pe68028280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 04:25:40 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 Jan 2025 20:25:37 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 00/10] wifi: ath12k: fixes for rmmod and recovery issues
 with hardware grouping
Date: Thu, 9 Jan 2025 09:55:28 +0530
Message-ID: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALhPf2cC/x3NSw7CMAxF0a1UHhOpCZ9WbAVVUT8m8SSu7JSCq
 uydwPAM3rsHKAqhwr05QPBFSpwq7KmBOY4poKGlGlzrLtbZ3jzp7QUn5uxJdUP1O+Xo4+6D8LZ
 SCqad3XK+deO17yaoR6tgXf0jj6E6kmaWz69ZSvkCl5c0B4MAAAA=
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
X-Proofpoint-GUID: K_eMDHVaQvl5lUKwpZSu547qDkdtz6EC
X-Proofpoint-ORIG-GUID: K_eMDHVaQvl5lUKwpZSu547qDkdtz6EC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=749 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090033

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
 drivers/net/wireless/ath/ath12k/core.h |  18 +-----
 drivers/net/wireless/ath/ath12k/mac.c  |   6 +-
 drivers/net/wireless/ath/ath12k/pci.c  |  28 +++++++-
 drivers/net/wireless/ath/ath12k/qmi.c  |  24 ++++++-
 drivers/net/wireless/ath/ath12k/qmi.h  |   4 +-
 drivers/net/wireless/ath/ath12k/reg.c  |   8 ++-
 drivers/net/wireless/ath/ath12k/wmi.c  |   4 +-
 8 files changed, 173 insertions(+), 34 deletions(-)
---
base-commit: dbe50a7420e22954c747e79e72df2750d795ea77
change-id: 20241218-fix_reboot_issues_with_hw_grouping-0c2d367a587b


