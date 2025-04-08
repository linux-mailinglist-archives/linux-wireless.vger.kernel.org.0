Return-Path: <linux-wireless+bounces-21238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7A3A7F493
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4390188A3C9
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1821625F7A9;
	Tue,  8 Apr 2025 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AdrrdRgd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D192222CE
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092407; cv=none; b=bYX/w/A/bklguzdaGwPJQQcPq/wCI0WuwDZsybT8FpMmbA7zlBo7d2ICBumhJe0FZ6qtEDcDiXk1eClt4G7rvtcE9AzjN/5sruMW2OBGYiwUFBmPl3Jhh+vhBG2GlrbwVKGmtloOMuhybNwUJPQvYV3FlPu/NGM70syX2JPcAog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092407; c=relaxed/simple;
	bh=CeVpOA2b62RgSn3idH2D7jjGpJdQDZhB6loS4rC7hUk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HW4+FDDBIP3m+q8UHQlD9krIn69q2aVhFa2J3jQoPiaJHu6VqW+7L5vcxTLtepqKdkNct2k8WD+rWiljBE82EDcLyUkVU99455G9NE8C/+m8yH86RvG92yWLgbprvUY/LYqK/5MTOSYLDLBpgeQamtyt+YxJP8JNVKh+zMiEtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AdrrdRgd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GYA0010566
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rPJvbK708nKLqv7QHHGj//
	BT/jZMd+wf9IwoNFeDmZg=; b=AdrrdRgdaTlk/sJkmnZqf4pX74Rp6uWoz2dahR
	WUDh7bvIPxySJUMZtrcWa/OXD1vvAEemkxsosINC93hkTUPYuYTTHc9wF2v29FFr
	VY7KTtOcDUB0qcj2+HBoB1T07EF82oS7rQ0fHfpgcycNdmJtlvQ9FKfDjDmKHMc5
	N/kWNi8XC1gFG0jQ7+sh1oXMKvUswl8lQHBp/IluJrR1vGoCLMKVMw4ZFjC+RkWu
	jr0etUqOkowc4SwNAp+E2IxkQ0CHrE7ktDL/EQ6dTrIPcCnFV8fDeqXBU5Mt7mOj
	wpXzd9lyCSiu4vAE7iD0j0Cq+N2wgjyf+SIbYVqFqI7Goi6g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1ejs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:06:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-af8e645a1d1so3115931a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092402; x=1744697202;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPJvbK708nKLqv7QHHGj//BT/jZMd+wf9IwoNFeDmZg=;
        b=Y7DtE9Uox9VkLqJWCzGylpeoixsI0DTydPfuBr4uu1daVhM1LrFb6AOYnV//6JJfVG
         8ptciFyJzQegEhtfx6yB8oyxNMYqRsfKb4SnosJRKtLHea+ApdsIzpm7merw7nCNSXZr
         9k5qbhye2OMqVq4n8SjVqz8gCTgsWbdse6tHD/+u22m2xaOmTAJw2Tr2F01q0ElffsW8
         tiHXg/luqsCPHCWxICoDCJS27H21+Emo9YznYvCx9EANuQpGRa473UAKeiJRxqQ0cmJ+
         LG/D6deORmbP2wg67JFcLewzsYddsLdUm3p/4lVqgw8Wc7pSINO9WCheuWhycGhz1n4C
         +x0A==
X-Forwarded-Encrypted: i=1; AJvYcCVSgScHgM9DkKqrKwMufRaLByvVO9ZXXUbg28jq1oc9vKUu2USO29BubHMVd6niJKVQh1zqPNsqTZkYYFIxfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3g0+Ok89M/CcMsnaurIvw7Orfzt48r8HnA5bkw2xpghp4ZB5
	AgWAymSCO07GXM2afKLVMuh4Zxy08qlb1hevZUZ4inHt6dByHwC6agO0UIA1cm9vBbZgVgBwMS/
	qv4enPKaIBYnKiUS5brNYHkdOinRhB9rxsCz08l7/SzcZ0XzdZ1pWRCkXJO7YaR5xZQ==
X-Gm-Gg: ASbGncs6cEj6XjKP8KSxy+EdFabYevVItzr+BQC7KqGZILBIw4wSU9d23FUQNLY8Xj5
	B/+6cX1bH3FYtnALP7pprV/V+RDvHjERoDYaQGjwSm5W078pauMTPXLziEOGeRI7545DAnR8ADO
	nqPBY5HJlcs/qmkSpZ2kTrJdG3NAY6Elt9lmIx09ZVrKV0DQ7OwSz2aBzNxDh+SzQ0vSgusw1CE
	Z8kAtlUQzy/JU83yTXI5Rd5LSYwN+PnvK8sZ9tlKSp7uX7fmiBeh/LaZL4oFE4NiGtamrMeE9hJ
	jLH+5kTROrAG6v/oJsefYoU4Y1Hif3VgT8OQFoW3YGl5mwMRhsutkcOBEtgNe7nxy5ii7bM2PU0
	lnwioKWzPqfWz9KWJtmvhzbtLAGWbZANaAjJzSPdf
X-Received: by 2002:a05:6a20:c78e:b0:1f5:535c:82dc with SMTP id adf61e73a8af0-201047315d9mr18142212637.42.1744092402504;
        Mon, 07 Apr 2025 23:06:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDQGkfHHXHzQnzn2S7sZR/SlqyFD4E76f4ItSX8gh3a16V1yPXO+CG98vBVOmnzhJbyAvBCQ==
X-Received: by 2002:a05:6a20:c78e:b0:1f5:535c:82dc with SMTP id adf61e73a8af0-201047315d9mr18142189637.42.1744092402103;
        Mon, 07 Apr 2025 23:06:42 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc35079fsm6863981a12.41.2025.04.07.23.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:06:41 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH ath-next v4 0/9] wifi: ath12k: fixes for rmmod and recovery
 issues with hardware grouping
Date: Tue, 08 Apr 2025 11:36:28 +0530
Message-Id: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOS89GcC/43OwW7DIAyA4VepOI/JmGRJetp7TBMKxA0+DDoga
 acq7z6UU7VdcrQsf78fIlNiyuJ8eohEK2eOoQ7Ny0k4P4aZJE91FgjYKFS9vPDdJLIxFsM5L5T
 NjYs3/mbmFJcrh1mCw0m/dWPbd1ZU6JqoXu2RDzEWLwPdi/isG8+5xPSz11e172uoBQXDkdCqJ
 MiL1QM50E2r6P17YcfBvbr4tQdWfEIRDqFYUdtN0GlrcUT8j+pntDmE6opqHECDVf00/Pl027Z
 fRrvTnIoBAAA=
X-Change-ID: 20241218-fix_reboot_issues_with_hw_grouping-0c2d367a587b
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Harshitha Prem <quic_hprem@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: _BJvwSA3aeihYjArFKnQO5bWC_f6ZXhd
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f4bcf3 cx=c_pps a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=3fJN4-It2fq8u9xqJHoA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _BJvwSA3aeihYjArFKnQO5bWC_f6ZXhd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=960 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080042

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
Changes in v4:
- Rebased on ToT.
- Fixed potential deadlock warning.
- Moved to oss email from quicinc.
- Link to v3: https://lore.kernel.org/r/20250124-fix_reboot_issues_with_hw_grouping-v3-0-329030b18d9e@quicinc.com

Changes in v3:
- Rebased on ToT due to FTM changes conflict.
- Link to v2: https://lore.kernel.org/r/20250120-fix_reboot_issues_with_hw_grouping-v2-0-b7d073bb2a22@quicinc.com

Changes in v2:
- Rebased on ToT.
- No changes in 1-4, 6-10.
- Removed regd_freed flag in 5.
- Link to v1: https://lore.kernel.org/r/20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com

---
Aditya Kumar Singh (9):
      wifi: ath12k: fix SLUB BUG - Object already free in ath12k_reg_free()
      wifi: ath12k: add reference counting for core attachment to hardware group
      wifi: ath12k: fix failed to set mhi state error during reboot with hardware grouping
      wifi: ath12k: fix ATH12K_FLAG_REGISTERED flag handling
      wifi: ath12k: fix firmware assert during reboot with hardware grouping
      wifi: ath12k: fix ath12k_core_pre_reconfigure_recovery() with grouping
      wifi: ath12k: handle ath12k_core_restart() with hardware grouping
      wifi: ath12k: handle ath12k_core_reset() with hardware grouping
      wifi: ath12k: reset MLO global memory during recovery

 drivers/net/wireless/ath/ath12k/core.c | 110 ++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/core.h |  15 +----
 drivers/net/wireless/ath/ath12k/mac.c  |   6 --
 drivers/net/wireless/ath/ath12k/pci.c  |  26 +++++++-
 drivers/net/wireless/ath/ath12k/qmi.c  |  22 +++++++
 drivers/net/wireless/ath/ath12k/qmi.h  |   2 +
 drivers/net/wireless/ath/ath12k/reg.c  |   4 ++
 7 files changed, 156 insertions(+), 29 deletions(-)
---
base-commit: ac17b1211841c98a9b4c2900ba2a7f457c80cf90
change-id: 20241218-fix_reboot_issues_with_hw_grouping-0c2d367a587b


