Return-Path: <linux-wireless+bounces-17741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A99A169E5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 10:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29C73A1844
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04181B0435;
	Mon, 20 Jan 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pxKPdV/W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A2318801A;
	Mon, 20 Jan 2025 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366527; cv=none; b=o5SPmZfE7dGkNUQmvux5JAs+ZrrPmt/xTRlGFu2+z27QRjO4/Wf+8LXzcFiQ3tl7ZRHdQpFBYGU6i8S+XWn2tl5LkkDMaSr3gSjZqPwCw+tPerl1FCjUVn8YW8PgH+a+T1R68gfcEIKLhHNjHrk3PSf4KdoO92MPyud8yNwQ9fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366527; c=relaxed/simple;
	bh=6xPj+T1KFSW1a8qAooDwHQRc1rvqDCHi4cLa3zfc1TM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=uKdVQeOEb6wpgXOmHGeMQmELA6oKAv3OiseLYhKndsuA5LyO1i/+cbnLYOgknLFmCPe6DNjMjAQ7nUtjUrj6urCuYF6kzAoFFu5fVHGIt3nUC1R86lYzPkb7rh7XRWTgQCfqsgrRJ3IdPwCy93naTEntd1GWROclL6ai+WKfubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pxKPdV/W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K3C9ZB032297;
	Mon, 20 Jan 2025 09:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ldtHzgg07G3kg+gyMxc0uF
	VXhA2VRkSQbWZSjt/hxiA=; b=pxKPdV/WCP4Fpdu1XLmONyu0AGntNh4nX02vaq
	pjQPkpfziE8ODYdWKEclca06i5rbgyQdPZWLb7bHwEy71xdnmWaEc6cdTj6BjP1r
	grORgSzAV+RYzfw7EreyTlMTDeFoT2lYymeJK2Y7HR/rmnr5TN2ysvDb7PVTFuRp
	dNX22WGCGP6ikB80/gA6ty5r4Eis1ThRCZnZr999usbHDVzCwOoHkZzglNMKOdLu
	7UiK3qA3RlhHw/5SMYm9LcIZcEOzsUegUE+WVQWePfAgw7KVAAyiK6LRNec2D3N0
	8LHGT8Pbz+W/w2L8qi0HsE4I+u4LfkiVeuVI2VGcZn7oX/ew==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 449ecb0wmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:48:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50K9mX4T023197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:48:33 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 20 Jan 2025 01:48:30 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v2 00/10] wifi: ath12k: fixes for rmmod and recovery issues
 with hardware grouping
Date: Mon, 20 Jan 2025 15:18:20 +0530
Message-ID: <20250120-fix_reboot_issues_with_hw_grouping-v2-0-b7d073bb2a22@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOQbjmcC/42NSw6CMBRFt0Le2Jq2gIAj92FIA+VB38AWWz4aw
 t4trMDhuck9Z4OAnjDAPdnA40KBnI0gLwlo09gBGXWRQXKZCSlK1tNHeWydmxSFMGNQK01GmVU
 N3s0j2YFxLbv0VjR5WbQQRaPH+DojzzqyoTA5/z2bizjWQ59zwat/9ItgnPVtWqHmaZYLfLxn0
 mT1VbsX1Pu+/wCX78ks1gAAAA==
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
X-Proofpoint-ORIG-GUID: Dy_R5EqFo9E_pfzJpMbyMnVyGMKhpqKF
X-Proofpoint-GUID: Dy_R5EqFo9E_pfzJpMbyMnVyGMKhpqKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=814
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200081

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
 drivers/net/wireless/ath/ath12k/pci.c  |  28 +++++++-
 drivers/net/wireless/ath/ath12k/qmi.c  |  24 ++++++-
 drivers/net/wireless/ath/ath12k/qmi.h  |   4 +-
 drivers/net/wireless/ath/ath12k/reg.c  |   4 +-
 7 files changed, 163 insertions(+), 33 deletions(-)
---
base-commit: e7ef944b3e2c31b608800925e784f67596375770
change-id: 20241218-fix_reboot_issues_with_hw_grouping-0c2d367a587b


