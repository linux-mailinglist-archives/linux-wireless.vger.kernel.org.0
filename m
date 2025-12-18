Return-Path: <linux-wireless+bounces-29868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE02CCA036
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40E54300FA75
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42A26E6F4;
	Thu, 18 Dec 2025 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pmcJrTxX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h2tvy947"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25F26FA77
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022922; cv=none; b=uf/hb2B4rcP9zAXChUY5uRHH8PAxS6HxZx4sOMhP5BtXgF6DnbB8SGHHEqM8nR5xe69qn+u/wtdhIHZaCHicXSWsl9v5NXwatOgvpDzWJ0apPYPDh045y+RwyceH09SywQ2qYCe1B91DYsXbBBtxLxNI67D6+Tn8Adf0TWm558c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022922; c=relaxed/simple;
	bh=OIRB4Ca2bnictDnt8M1UKZ67jvu3HRiqcY10BXAFSCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYx0mQCFZQCtzt+YmBUm2ZuXcszShjW86V6/hGWfB1kzGCG8Rg5mr/GvH1X1jSmK8046jFdzu6V8aJ4M3eVRBE/xFlBSgg9P+mO5gto0FylvFdT9gnmzAeETQmLdaO1+GPNvyEyrLkkyQ0gcPTfmBQtCzQ9NilvZ4HZ3eD0r7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pmcJrTxX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h2tvy947; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Yw7Q681049
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iWrmA6fW3PhjppUon/QPWjAWhbRLPQ3SUpfNWS5hDIU=; b=pmcJrTxX3tHaNE1h
	cg0LcSbjXQ7tmxA3Q5+CFUVDhEcK0UavVSlwveflcwwsau+HTga6mPghsiQ+SKop
	5N2QDdAWVcv9VpUhRPcC1uP9sHp3I5D96/jG4xVv9dPuQCvcT5xeo4IK0YVnAFbH
	ZKOhwfhUB8E0Yclvva4GE1khKgqGZDlNhfchpbXjY/TFdeqEo0ODgc4nid0UPZzO
	SpUh3Ordgw+bvtvUQNC9e8NqUnCG4VvfOfnOTDRtUfNIjQurtI8ZfNZUbBhC6iaI
	uqThL/wGT/W9oL5IXhG3TmVtLe8D4t57/P/kxyV6l4emzoiWjmKKVl5xL95MuOiB
	qdx+mA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b45bhgdj8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0c495fc7aso2017875ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022919; x=1766627719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWrmA6fW3PhjppUon/QPWjAWhbRLPQ3SUpfNWS5hDIU=;
        b=h2tvy947C4gkWtMTcOwSc+KkapskXZJTPFRHlfLL0RjV05AuuOx+dwFFKNtpCe4x/r
         zZBOzpGb0x7LdS5YRh/CR6AD+NpNtLpY1u1c48HcU24S4wSCen46V/JQ5P1slYcXBRuF
         LXh3XZejmdrb3FbWLZDAHe8ADv/119oU/GyZJrhhmNi+wA9tMtksO/z8Ux0oIh6PMjHO
         E9tDzfhetd4Bhgkj3MGU7CgGMG+D2y8vR8jGTMdKaL1JjcIOEy/HEcwq1/so1baM/vaU
         nqG8yLjKjt3mf+4nvKx3E8OSAt/TyqnWXxeWSk0kz0wniCK+Q15zgW34VQpLf0So666i
         NbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022919; x=1766627719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iWrmA6fW3PhjppUon/QPWjAWhbRLPQ3SUpfNWS5hDIU=;
        b=KNZkbxXi0HLrfmrM0M7pJckjsgi1zaW/6ogoywaWRH8AuPaZQ9dD0EuYJCY5PiGtXI
         hYlz4b8itJ84VbswqetAvFvbQwwLBdTddiJALrZnd8meVBj2x/a64CREqkEPz3BudH5t
         uXQIVbshxeGe9AvQXI+37IoGe6cBoc6r8higpNJt7JzwVhiqPLr+auhUXvRq/ltisYN0
         Z2xp/SC5HC+708yt1nQpMO6SsyHEv23EnNRkp+pARQxmtsKNb2szC+YQym8HG2bbJYtR
         xiW97qMXMt1kyNJ4o/0vSu6TNjhj/tRaH5aAVkqa+1ejsPfF6YPZMIAaE1BD1j4hchVC
         MLjg==
X-Gm-Message-State: AOJu0YzOPNpIVYE/xMLl2/oGWqhfHwboV0pkn9FEeX0fb9HoeNqayjtt
	Rr43biy1sJ1dgOWqZc+kHJJ/SgOp6ecqI5DFoGQ2QqJ5F1WOgrZ6FIYS+qjhiEsKsMf0OOwK1vI
	4HeleImAWzMg6g1naEXjxMgt5SNPObjlb6Xz9+MqffGNzLs3HWsT7RwNFcTdedeOg7XiHcA==
X-Gm-Gg: AY/fxX5jaIIWoNtJ+ti0rNJb25/j8TJPuFGIe6YMLyhvV+2quK9pDJsjsHonQUtlsl8
	vHixthIrgLqV8a8yskt6o9qUpKuATGpOj6JzmzPlJrJo7wmdeW03fubPJKGYpahGYVci7NdDSIL
	V+UlYhOpiXNcNwjcMflv4OsQ6a6TMlCDV+QMv5ECFSlc3tsXS+SR4I5nVHdj5AV0zU07uwY1WnJ
	+pbreLHlhOeJSZwOti43ygmNgyf79cZFJB06AGt/00mKiTEA6xNDvHTvJf4QOBrU6CXdW/RfLzV
	tyr4f3WLX1PcHAwl2wxRZnI6FS2yL0+Iuewv0qexs8mWIwA+6lWNnmWboFimtaoVh406i4ck7/j
	rwjMlk/wqY8gfOD9sqPnTxjUwqVEiZbnRzDrs59SL3er5r160CuYNnwV7cU53IjI=
X-Received: by 2002:a17:902:cf09:b0:2a0:8859:3722 with SMTP id d9443c01a7336-2a0885945d5mr188743125ad.25.1766022918721;
        Wed, 17 Dec 2025 17:55:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0mtxlDACbgXnpME8yw76QwYPJ9TxytEBPvEO++DM1XlroiwrjaueJldnvtvv5hPWUdu79zA==
X-Received: by 2002:a17:902:cf09:b0:2a0:8859:3722 with SMTP id d9443c01a7336-2a0885945d5mr188742955ad.25.1766022918182;
        Wed, 17 Dec 2025 17:55:18 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:17 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:21 +0800
Subject: [PATCH ath-next 07/19] wifi: ath12k: add hardware registers for
 QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-7-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: keNUZtekZOq3CVjlgsRcfxNM2mXg-zJv
X-Proofpoint-ORIG-GUID: keNUZtekZOq3CVjlgsRcfxNM2mXg-zJv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfXwxEWISIK3xj3
 1sGZvXrpOotG1q7SyN/ITPq7JjxmRPk94cCFtX581RMcfVZTPWwJbPig1OJpW+FNsGV7YfqmJN6
 yoAILN7Yop6+0+c+HgakCtVRAsoScPmadE7vGz0h93/7scP1imy1dfx5v+85SkIF6RzxCcIHdYz
 ie0R31eZnVfR2PkHGEuna3whu7nwh++DEwIz+EC/CM8AOk9fi/IO2blEmQnUUfvVJDVrVANTdn2
 oO43WTaldZGNjCy1GYeiG2gcqasfX60wlbM+Xsz/Sss621bmnr38a6W/J7JuS739lYQsjpC1a2T
 IM8NdVDI5d8vABbA5/Y5CjJNSbTMN1cLAeh9o5kFxOjjPtw8VWDQnA1yWAqwZKcSIr/s+sC2o0I
 gWpQz21CsIi83dx0UhWx4Ls90xNYFw==
X-Authority-Analysis: v=2.4 cv=SZr6t/Ru c=1 sm=1 tr=0 ts=69435f07 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fIzkMDVc4DzzmXS1f8kA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512180013

Add hardware registers and populate hw_regs field in
ath12k_wifi7_hw_ver_map for QCC2072. Note for some registers not
defined and not used by QCC2072, a magic value is assigned.

Also populate other fields to be the same with WCN7850. Among them,
however, QCC2072 requires different HAL ops and descriptor size, both
will be updated in upcoming patches.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h             |  1 +
 drivers/net/wireless/ath/ath12k/hal.h              |  2 +
 drivers/net/wireless/ath/ath12k/wifi7/Makefile     |  3 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |  8 ++
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    | 94 ++++++++++++++++++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.h    |  8 ++
 6 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 31d5d10beb85..667cf5993cf1 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -155,6 +155,7 @@ enum ath12k_hw_rev {
 	ATH12K_HW_QCN9274_HW20,
 	ATH12K_HW_WCN7850_HW20,
 	ATH12K_HW_IPQ5332_HW10,
+	ATH12K_HW_QCC2072_HW10,
 };
 
 enum ath12k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 81b0cb002b38..94ecc035fc49 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1121,6 +1121,8 @@ struct ath12k_hw_hal_params {
 	u32 wbm2sw_cc_enable;
 };
 
+#define ATH12K_HW_REG_UNDEFINED	0xdeadbeaf
+
 struct ath12k_hw_regs {
 	u32 tcl1_ring_id;
 	u32 tcl1_ring_misc;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/Makefile b/drivers/net/wireless/ath/ath12k/wifi7/Makefile
index dcfa732bb95b..45b561cdba4b 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/Makefile
+++ b/drivers/net/wireless/ath/ath12k/wifi7/Makefile
@@ -14,6 +14,7 @@ ath12k_wifi7-y += core.o \
 		  dp_mon.o \
 		  hal.o \
 		  hal_qcn9274.o \
-		  hal_wcn7850.o
+		  hal_wcn7850.o \
+		  hal_qcc2072.o
 
 ath12k_wifi7-$(CONFIG_ATH12K_AHB) += ahb.o
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index 03a007dd6857..b957ebc9b7c5 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -12,6 +12,7 @@
 #include "../hif.h"
 #include "hal_qcn9274.h"
 #include "hal_wcn7850.h"
+#include "hal_qcc2072.h"
 
 static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
 	[ATH12K_HW_QCN9274_HW10] = {
@@ -42,6 +43,13 @@ static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
 		.hal_params = &ath12k_hw_hal_params_ipq5332,
 		.hw_regs = &ipq5332_regs,
 	},
+	[ATH12K_HW_QCC2072_HW10] = {
+		.hal_ops = &hal_wcn7850_ops,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn7850),
+		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_wcn7850,
+		.hal_params = &ath12k_hw_hal_params_wcn7850,
+		.hw_regs = &qcc2072_regs,
+	},
 };
 
 int ath12k_wifi7_hal_init(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
new file mode 100644
index 000000000000..6c4986050bc6
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "hal_qcc2072.h"
+
+const struct ath12k_hw_regs qcc2072_regs = {
+	/* SW2TCL(x) R0 ring configuration address */
+	.tcl1_ring_id = 0x00000920,
+	.tcl1_ring_misc = 0x00000928,
+	.tcl1_ring_tp_addr_lsb = 0x00000934,
+	.tcl1_ring_tp_addr_msb = 0x00000938,
+	.tcl1_ring_consumer_int_setup_ix0 = 0x00000948,
+	.tcl1_ring_consumer_int_setup_ix1 = 0x0000094c,
+	.tcl1_ring_msi1_base_lsb = 0x00000960,
+	.tcl1_ring_msi1_base_msb = 0x00000964,
+	.tcl1_ring_msi1_data = 0x00000968,
+	.tcl_ring_base_lsb = 0x00000b70,
+	.tcl1_ring_base_lsb = 0x00000918,
+	.tcl1_ring_base_msb = 0x0000091c,
+	.tcl2_ring_base_lsb = 0x00000990,
+
+	/* TCL STATUS ring address */
+	.tcl_status_ring_base_lsb = 0x00000d50,
+
+	.wbm_idle_ring_base_lsb = 0x00000d3c,
+	.wbm_idle_ring_misc_addr = 0x00000d4c,
+	.wbm_r0_idle_list_cntl_addr = 0x00000240,
+	.wbm_r0_idle_list_size_addr = 0x00000244,
+	.wbm_scattered_ring_base_lsb = 0x00000250,
+	.wbm_scattered_ring_base_msb = 0x00000254,
+	.wbm_scattered_desc_head_info_ix0 = 0x00000260,
+	.wbm_scattered_desc_head_info_ix1 = 0x00000264,
+	.wbm_scattered_desc_tail_info_ix0 = 0x00000270,
+	.wbm_scattered_desc_tail_info_ix1 = 0x00000274,
+	.wbm_scattered_desc_ptr_hp_addr = 0x00000027c,
+
+	.wbm_sw_release_ring_base_lsb = 0x0000037c,
+	.wbm_sw1_release_ring_base_lsb = ATH12K_HW_REG_UNDEFINED,
+	.wbm0_release_ring_base_lsb = 0x00000e08,
+	.wbm1_release_ring_base_lsb = 0x00000e80,
+
+	/* PCIe base address */
+	.pcie_qserdes_sysclk_en_sel = 0x01e0c0ac,
+	.pcie_pcs_osc_dtct_config_base = 0x01e0cc58,
+
+	/* PPE release ring address */
+	.ppe_rel_ring_base = 0x0000046c,
+
+	/* REO DEST ring address */
+	.reo2_ring_base = 0x00000578,
+	.reo1_misc_ctrl_addr = 0x00000ba0,
+	.reo1_sw_cookie_cfg0 = 0x0000006c,
+	.reo1_sw_cookie_cfg1 = 0x00000070,
+	.reo1_qdesc_lut_base0 = ATH12K_HW_REG_UNDEFINED,
+	.reo1_qdesc_lut_base1 = ATH12K_HW_REG_UNDEFINED,
+
+	.reo1_ring_base_lsb = 0x00000500,
+	.reo1_ring_base_msb = 0x00000504,
+	.reo1_ring_id = 0x00000508,
+	.reo1_ring_misc = 0x00000510,
+	.reo1_ring_hp_addr_lsb = 0x00000514,
+	.reo1_ring_hp_addr_msb = 0x00000518,
+	.reo1_ring_producer_int_setup = 0x00000524,
+	.reo1_ring_msi1_base_lsb = 0x00000548,
+	.reo1_ring_msi1_base_msb = 0x0000054c,
+	.reo1_ring_msi1_data = 0x00000550,
+	.reo1_aging_thres_ix0 = 0x00000b2c,
+	.reo1_aging_thres_ix1 = 0x00000b30,
+	.reo1_aging_thres_ix2 = 0x00000b34,
+	.reo1_aging_thres_ix3 = 0x00000b38,
+
+	/* REO Exception ring address */
+	.reo2_sw0_ring_base = 0x000008c0,
+
+	/* REO Reinject ring address */
+	.sw2reo_ring_base = 0x00000320,
+	.sw2reo1_ring_base = 0x00000398,
+
+	/* REO cmd ring address */
+	.reo_cmd_ring_base = 0x000002a8,
+
+	/* REO status ring address */
+	.reo_status_ring_base = 0x00000aa0,
+
+	/* CE base address */
+	.umac_ce0_src_reg_base = 0x01b80000,
+	.umac_ce0_dest_reg_base = 0x01b81000,
+	.umac_ce1_src_reg_base = 0x01b82000,
+	.umac_ce1_dest_reg_base = 0x01b83000,
+
+	.gcc_gcc_pcie_hot_rst = 0x1e65304,
+};
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h
new file mode 100644
index 000000000000..744d7e02b46e
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "../hal.h"
+
+extern const struct ath12k_hw_regs qcc2072_regs;

-- 
2.25.1


