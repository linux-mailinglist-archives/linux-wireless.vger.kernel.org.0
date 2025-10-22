Return-Path: <linux-wireless+bounces-28177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495BEBFCDE1
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 17:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E9D3A445B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65217337B8C;
	Wed, 22 Oct 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TdjNbw/C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F530E83A
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146693; cv=none; b=cIOQNZbWcSfr1BBBVOeXxF8Y2lazbD+0RxqYLIQhZWMJq8XEO1UFLsqBBxhQcpoXCG2FE9yHM4/Uy33FT1BAuJEpnCHryLYv3T1x2eqQV7jhL/5CAYwZX0AKkLqp1pB3Ml9DquVnT1bCfKF3nVAuMrRVj9i+WrQANNyfNE7YNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146693; c=relaxed/simple;
	bh=0ju2kfBl28VgVYEBC0pFLYJqUQZOeS30NtHN9SD5OEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WXWpYCWL1kfb7jZ7f0FU9CsbZH6ydUsUY+F9lLQ9t4etVOzTjFDREMSKpssyv5jdPpVTb9d0vdmb5sLrFmLWIPOTEQhx3YfXYAZU6teZqjtakXKIsuDwSrmsdt1Hxw2AM1Qdb5tXaVZq3VTxRSRF8DJwLogBfCqFMYg+ZTeHA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TdjNbw/C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAQQ3r027450
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 15:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zcXJCbX0nk3TAqJyAuAEyo
	iVOaBfe/OFUUMOBf3y+Fc=; b=TdjNbw/COcFthRpo1v+Wc6gaWNKJxj8eR6adZw
	9TYwjw8UvLNXdEtcnqFa4OyYLHVrl980Armbkkta9WOZSifbarly1eTvT6RihZBS
	lckOCt1mf2OvQjnrUh42iupICegN+tqqiMzrcazi5Fji4hGpkRxDzP7tzJYbCYw+
	JxGJlh1Q6tCq1CwS/pmcRMUejJvELUqaLcXInjOUwMZofV1LV/MSbSeeXZEqQAR4
	1RHOq9OG3bRuxIj3w5T8kIfgghpsEYqkb+rH7cAmZOkcOAPIuXCd0kEl0OlPy832
	LJMlO5drMNz05QFxa9DPv00YMSDSt4oLrPmu+9FgPzMeax7A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j52ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 15:24:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b522037281bso4457397a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 08:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146689; x=1761751489;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcXJCbX0nk3TAqJyAuAEyoiVOaBfe/OFUUMOBf3y+Fc=;
        b=i96qDATU52gko/Lm+LRmIsXJqVnW201t31u1b0jljsxkwmb9TMNWy9R5f0Z0RveWiz
         6UXL/5gjSuHRMoWbGbs3vC9mjZz5ytfGGfTkbZIx74VGRuEKQq/YXAM++eh8DBNLiAFf
         N/L6AsexsonxLSVlkob1NyPbKWqz/Yl8OvJTRDtCzWv6pLBKnGDgwsz159ZgTAT5FsMo
         1CaDkmOX/OsATPNI8QQ/aEO/ATQT3YYl97wFukn/Cj+o3fNffC0acSojofst/e5YAMUh
         ys4bluXhb4/Hx4YdBG/bqCNtTs1UhXJ5nW9BmUYAC13VUbDTMR0hk9vOj1Cmr+2wHNUh
         bvRw==
X-Gm-Message-State: AOJu0Yzq4FWEWiG33XoqmOnZs0wiU30JvrlGX0yAg+YVF3uOO9syNS+1
	TYGw7hBnXCCJJGRbCi4NCRvbneP5R4LaT3+Rd9+d7oDUzCbdRCSyR6/AWibcQ+myQROJAxT74AH
	l3yYni9YxliqrzHRRtAfSd/1ZpoNHMiqEW+XPTNR1YFaFZW9y3ZMIGvCiEg1C3d7nalWnoA==
X-Gm-Gg: ASbGncsrQVMJsF/CBmRgPWS1K05oR2pFsJ/rQ5vLOzX+piRKZsaPTGJJCVfZOPksGmA
	yim1i+JZ2MU/iS3ecH7fLnHjbHPsfHn24tGKAAQUEFcryVSJvorN42Z1ZxcBZfGmO5hlPmO2URo
	uvy0IGCcrwxwErSxLuw28LF3tKym4Mw+kIrhyEXDhqE0wSLHU+4k1ELUjFHA5skSz7F3+EDSJdN
	2H2kz5M9X36T31D2VkGK+a3hENRPzFOxrQjPycjtgaxCo/aqKRvFZwCRWGjR8eNwTyukSwnUG4G
	lHaWcdhBJEyCCHK4IYZK2T52DDuOZHG05hBcL3oWXJnuMuE7yKq1PGNJluGAj1nBCY8ZoahszJh
	MBhqpZPIKNYxH7b+dIUUD4neZEkTF9EmlBYs=
X-Received: by 2002:a17:902:ce12:b0:252:a80c:3cc5 with SMTP id d9443c01a7336-290ca4f9174mr232625735ad.22.1761146688879;
        Wed, 22 Oct 2025 08:24:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgNwSVIEeJz2D2gYMvsvbH6+PAIULhDABgtNFR8EH3i0kHpgbwdzEEzuSJi98AxL1S0Kefzg==
X-Received: by 2002:a17:902:ce12:b0:252:a80c:3cc5 with SMTP id d9443c01a7336-290ca4f9174mr232625445ad.22.1761146688393;
        Wed, 22 Oct 2025 08:24:48 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d55d8sm140982305ad.61.2025.10.22.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:24:48 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 08:24:46 -0700
Subject: [PATCH ath-next] wifi: ath11k: Correctly use "ab" macro parameter
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-ath11k-bad-macro-arg-v1-1-93a8eadb6191@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAD73+GgC/43NTQrCMBAF4KtI1o5kJq1aV95DXEx+aoO20aSWi
 vTuhq5cqLgZeDzeN0+RXPQuid3iKaIbfPKhywGXC2Ea7k4OvM1ZkKQSJSFw3yCeQbOFlk0MwPE
 EVm8KbY1UVVmJPL1GV/txZg8iL6BzYy+OuWl86kN8zP8GnPvf9ICAQBplXZXEa6v2IaXV7c4XE
 9p2lc/sDvSPRdmSBbLcsjFyS18s9W7RF0tla1NbqrUqXOHwgzVN0wvKIQKSYQEAAA==
X-Change-ID: 20251021-ath11k-bad-macro-arg-db74bdc03959
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfXyvbm6W3M6OsQ
 21w5egPWoiSSgd9uUWX5kW3XBezr9nvhWBb0AphYhsx0Vbk6c0lPhNsjCAhgL5JxyaYf/7/7v9y
 XUD6oy9B1KF6OL/z9aYS1gBrY8PMTFzRYn3Ydj2CPCikfpGjwQR0aNXcbRDeAV7Pr32vk/VABaq
 O9gO3hYUM4yr3kRGW3pwcxzVwlfY3ffYit6OTYJ9N42GoepXwhYv0SPKOCjqAcVNux4N+m3Xn6t
 smL6DbVXOw4SDxO2gjinEsayQMoq/i7eY0JWMT4j312Up8KuJRfU2oxciKxCL8ShgMwU5j+X+sH
 myWA6I0vu5QXpOUU847OURodqw0SkTfR7Kn3yzL4eDzXjhzD3tBuMBUezeDQN9uMGL6btsxwWZ1
 BboMBreCjQIWZFT6pfCAlURAYrHnSA==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f8f742 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ga_hMwcDZzHn_-OpqXgA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: wLXZp0re_ICeRCjcM53qSCNcb_uQ4O3i
X-Proofpoint-ORIG-GUID: wLXZp0re_ICeRCjcM53qSCNcb_uQ4O3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

The checkpatch script is reporting multiple instances of:
	Argument 'x' is not used in function-like macro

Fix these by renaming the argument to match the usage. In the process,
also add parenthesis to the usage to avoid MACRO_ARG_PRECEDENCE
issues.

Compile tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
There are other MACRO_ARG_PRECEDENCE issues in hal.h that can be
addressed in the future
---
 drivers/net/wireless/ath/ath11k/hal.h | 38 +++++++++++++++++------------------
 drivers/net/wireless/ath/ath11k/pci.h | 18 ++++++++---------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 839095af9267..82603a389bb9 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_HAL_H
@@ -43,14 +43,14 @@ struct ath11k_base;
 #define HAL_SEQ_WCSS_UMAC_OFFSET		0x00a00000
 #define HAL_SEQ_WCSS_UMAC_REO_REG		0x00a38000
 #define HAL_SEQ_WCSS_UMAC_TCL_REG		0x00a44000
-#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(x) \
-		(ab->hw_params.regs->hal_seq_wcss_umac_ce0_src_reg)
-#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(x) \
-		(ab->hw_params.regs->hal_seq_wcss_umac_ce0_dst_reg)
-#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(x) \
-		(ab->hw_params.regs->hal_seq_wcss_umac_ce1_src_reg)
-#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(x) \
-		(ab->hw_params.regs->hal_seq_wcss_umac_ce1_dst_reg)
+#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) \
+		((ab)->hw_params.regs->hal_seq_wcss_umac_ce0_src_reg)
+#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) \
+		((ab)->hw_params.regs->hal_seq_wcss_umac_ce0_dst_reg)
+#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) \
+		((ab)->hw_params.regs->hal_seq_wcss_umac_ce1_src_reg)
+#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) \
+		((ab)->hw_params.regs->hal_seq_wcss_umac_ce1_dst_reg)
 #define HAL_SEQ_WCSS_UMAC_WBM_REG		0x00a34000
 
 #define HAL_CE_WFSS_CE_REG_BASE			0x01b80000
@@ -209,10 +209,10 @@ struct ath11k_base;
 #define HAL_REO_STATUS_HP(ab)			ab->hw_params.regs->hal_reo_status_hp
 
 /* WBM Idle R0 address */
-#define HAL_WBM_IDLE_LINK_RING_BASE_LSB(x) \
-		(ab->hw_params.regs->hal_wbm_idle_link_ring_base_lsb)
-#define HAL_WBM_IDLE_LINK_RING_MISC_ADDR(x) \
-		(ab->hw_params.regs->hal_wbm_idle_link_ring_misc)
+#define HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab) \
+		((ab)->hw_params.regs->hal_wbm_idle_link_ring_base_lsb)
+#define HAL_WBM_IDLE_LINK_RING_MISC_ADDR(ab) \
+		((ab)->hw_params.regs->hal_wbm_idle_link_ring_misc)
 #define HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR	0x00000048
 #define HAL_WBM_R0_IDLE_LIST_SIZE_ADDR		0x0000004c
 #define HAL_WBM_SCATTERED_RING_BASE_LSB		0x00000058
@@ -227,17 +227,17 @@ struct ath11k_base;
 #define HAL_WBM_IDLE_LINK_RING_HP		0x000030b0
 
 /* SW2WBM R0 release address */
-#define HAL_WBM_RELEASE_RING_BASE_LSB(x) \
-		(ab->hw_params.regs->hal_wbm_release_ring_base_lsb)
+#define HAL_WBM_RELEASE_RING_BASE_LSB(ab) \
+		((ab)->hw_params.regs->hal_wbm_release_ring_base_lsb)
 
 /* SW2WBM R2 release address */
 #define HAL_WBM_RELEASE_RING_HP			0x00003018
 
 /* WBM2SW R0 release address */
-#define HAL_WBM0_RELEASE_RING_BASE_LSB(x) \
-		(ab->hw_params.regs->hal_wbm0_release_ring_base_lsb)
-#define HAL_WBM1_RELEASE_RING_BASE_LSB(x) \
-		(ab->hw_params.regs->hal_wbm1_release_ring_base_lsb)
+#define HAL_WBM0_RELEASE_RING_BASE_LSB(ab) \
+		((ab)->hw_params.regs->hal_wbm0_release_ring_base_lsb)
+#define HAL_WBM1_RELEASE_RING_BASE_LSB(ab) \
+		((ab)->hw_params.regs->hal_wbm1_release_ring_base_lsb)
 
 /* WBM2SW R2 release address */
 #define HAL_WBM0_RELEASE_RING_HP		0x000030c0
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index c33c7865145c..1e3005a4b64c 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022,2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #ifndef _ATH11K_PCI_H
 #define _ATH11K_PCI_H
@@ -35,18 +35,18 @@
 #define PCIE_SMLH_REQ_RST_LINK_DOWN		0x2
 #define PCIE_INT_CLEAR_ALL			0xffffffff
 
-#define PCIE_QSERDES_COM_SYSCLK_EN_SEL_REG(x) \
-		(ab->hw_params.regs->pcie_qserdes_sysclk_en_sel)
+#define PCIE_QSERDES_COM_SYSCLK_EN_SEL_REG(ab) \
+		((ab)->hw_params.regs->pcie_qserdes_sysclk_en_sel)
 #define PCIE_QSERDES_COM_SYSCLK_EN_SEL_VAL	0x10
 #define PCIE_QSERDES_COM_SYSCLK_EN_SEL_MSK	0xffffffff
-#define PCIE_PCS_OSC_DTCT_CONFIG1_REG(x) \
-		(ab->hw_params.regs->pcie_pcs_osc_dtct_config_base)
+#define PCIE_PCS_OSC_DTCT_CONFIG1_REG(ab) \
+		((ab)->hw_params.regs->pcie_pcs_osc_dtct_config_base)
 #define PCIE_PCS_OSC_DTCT_CONFIG1_VAL		0x02
-#define PCIE_PCS_OSC_DTCT_CONFIG2_REG(x) \
-		(ab->hw_params.regs->pcie_pcs_osc_dtct_config_base + 0x4)
+#define PCIE_PCS_OSC_DTCT_CONFIG2_REG(ab) \
+		((ab)->hw_params.regs->pcie_pcs_osc_dtct_config_base + 0x4)
 #define PCIE_PCS_OSC_DTCT_CONFIG2_VAL		0x52
-#define PCIE_PCS_OSC_DTCT_CONFIG4_REG(x) \
-		(ab->hw_params.regs->pcie_pcs_osc_dtct_config_base + 0xc)
+#define PCIE_PCS_OSC_DTCT_CONFIG4_REG(ab) \
+		((ab)->hw_params.regs->pcie_pcs_osc_dtct_config_base + 0xc)
 #define PCIE_PCS_OSC_DTCT_CONFIG4_VAL		0xff
 #define PCIE_PCS_OSC_DTCT_CONFIG_MSK		0x000000ff
 

---
base-commit: 2b306fc6b1d00dfe85b3b80eb257256e2b5ba610
change-id: 20251021-ath11k-bad-macro-arg-db74bdc03959


