Return-Path: <linux-wireless+bounces-30681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E57BCD10E8E
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3150300E7DC
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC67D311587;
	Mon, 12 Jan 2026 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIQUK4Pi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="foYS1aKF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF87334361
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203432; cv=none; b=KDI+SBgIG98xFieTkchabVe2L1IMGMto2dn3GQ4hs6uFO+35I3Pd9Be+ogkXbBhQODBtLLJ1te3mJz34Eo8xchXkU0ZHCOCCtehkFCaerOV8yamiOkl+Wyt5RdAODSqJRDEX5KtVm3iMWChocKHvOsDybtYmcNgwXWybsufB+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203432; c=relaxed/simple;
	bh=OIRB4Ca2bnictDnt8M1UKZ67jvu3HRiqcY10BXAFSCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DdD/caSSrM4/eQzukeoOQ8hT3PjE/+5cyXqYx+0N4qDjMGbZye3cl4dsqQVbT4sXx3AP/Sijzaq3mkgyhr44i7Gp9yLaLDVZ3I1ZbdeMPoHCpZAX2Ma46h6rdDHq9KoXaREfXamxsYZLPY78Ek91SVM6WoDiLN/xT9MH8IRQBF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIQUK4Pi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=foYS1aKF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BLGmiO1080044
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iWrmA6fW3PhjppUon/QPWjAWhbRLPQ3SUpfNWS5hDIU=; b=gIQUK4PiItY765db
	RDOmRFLIbWadCSGR32MiMkhuq+SpikS7mnVkSzPP/gbtNonQ5UbryqS2ZCr811V2
	evYg2WboqeK8cej8sdK/smqvqwaR152kk7KR7RxMyMT1a+RhSe01Ilg3JsFTAA6F
	0MLzgYsXGXsmbY6x7N2yAvhADG5D+ZW2MP0lhdEhmuOsSZLAjdABPz43nWDlUx7y
	ZMFtHaMkt2punvtjvaALQC6tdWXB4eMJXQvdHTqdr6yPFRNAJzX3/qS5V1RgabFL
	WcWLUnNIb42iYdnPZ+BS5KOyQzYh9ygHzWP7KeZ0g3F54nEZUcK7xyxQp+mPq3JU
	qViHDg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkfxfuwqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:07 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630753cc38so1212090a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203427; x=1768808227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWrmA6fW3PhjppUon/QPWjAWhbRLPQ3SUpfNWS5hDIU=;
        b=foYS1aKF+4uGRdU63lFJtXYXv+lJWcJH0W8wvXkVHxq0c+nEXX7xCOIRoR7/e1p5Cy
         dycVvFE10DXu5rFzKVHdyYUJXQgZ9J3H4kJdxnOlO+O/vyRZrvyUjfJZR4EW5Ka/2dSC
         GWEhQ446bmRRfifnCd/A8Lh5egxSd3H6AXfaBCWT/DKiPOpmAEPwMZpgmU6+SVQU0C4F
         uoPyX57BxmFGqqiiBkwBOqHPESzx8e+wTPXrW0nSOjKw7ZY3KA/SLYM+UmlGrqeTtncC
         PZ1FnbUvyR9kKJY4hvF+R/6rAbREk4WF2OaBtSf1XCkYbQNpUX6IrSu2DDR/rb5me3Jn
         VmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203427; x=1768808227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iWrmA6fW3PhjppUon/QPWjAWhbRLPQ3SUpfNWS5hDIU=;
        b=dc+JYrLDzSPpG7JcGK5cA/AfVekKB/dwFsA5HYmYr3qr124Bth660TwYxwR709K/et
         l8mY2lSmoL23lOcvwEAj7ew2Jum36V+qo1fFX0ap8PJA415m/AgMbd6wh6cIww0tHrX/
         hZq6jXnzaIqQcBe3/G7Wpzo2EqsMgmzxTeT2U/nolU6kScRz/W+1Jfm/7MHg8+/IXQmg
         DUtg8NcKqkjZDX15ic5x5rlHL7Nvi5d4bger7cdfx/iesHCaA/AglgfQgVfRDdanQxdD
         6/H1jgA9+myfTG6aSSztT4Dfmy78jEOgbr4iDHqlNTU0VGxTJarb+ajE+cC1OVrKzC10
         3cHw==
X-Gm-Message-State: AOJu0YyaAXLrH/AjoU4OZDTvc+/qTraYKTv7H5dNn/yyVxHFxpkxSd3r
	U7YG6OtpOe5XmSL9JbVTgrqloLVMFIr/AWJUUHxCFlbtFR74l0Ydp1xnJrYfhGU6t5qGQyLTWSo
	izlg2ANCQsq3OSg3KZHZM9tjDe1BC/10GwJeiHM/d5RjHXFw9U7ZT6Jt05/D6Hi77DjL+tolg8d
	kOaVOS
X-Gm-Gg: AY/fxX73y3YLQBX9KLoVBV3x27W7vm/dwjQcomcdCGgitMInNd42MYq14og9Ik/I98v
	AU4kZ7Shy52ReFbnIi5dwnaAxC2KXPLmfvb8aBDsqaPbavo2ymswt+XELkvOzbWVuIIfOtD10Ii
	vvw54BZNSFjZXErxhsyCCdlUeCuoVorx54YbdrtOw+LjfRA1mpYAcgr16aQ7Ggpn/4fRF8l9ki2
	2AvjgFnblL/YjvAo7wPSN3R2wyzavEH13pmuxZ3ugRNQToEceL9KTK/YQEDry4TCoKwdl6sGZ6l
	tkjGdPAb7PCD/gXoAwki7qhqVe6m+vEmMDEo0LnQiMhK4/JEE4hx323rRKuYM9I519lZ41XKGYK
	UHAOXs/wMV+ylAwUKG+HYwtXLKsh5uCu8VbbKiqWMxHwVGl5ShdF5cDTiwkCXiGM=
X-Received: by 2002:a05:6a21:3282:b0:366:14ac:e1f8 with SMTP id adf61e73a8af0-3898f9efa89mr16701612637.74.1768203426648;
        Sun, 11 Jan 2026 23:37:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH70hs6oIvASiNkU0ke4bcuU3PWbmO18Qip9niFVnjZw8dT2DIdRkoUMNEjTi1EuDZtoYGWcA==
X-Received: by 2002:a05:6a21:3282:b0:366:14ac:e1f8 with SMTP id adf61e73a8af0-3898f9efa89mr16701603637.74.1768203426166;
        Sun, 11 Jan 2026 23:37:06 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:05 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:27 +0800
Subject: [PATCH ath-next v2 07/18] wifi: ath12k: add hardware registers for
 QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-7-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: brrjGNc9CsNOqOpFvVJGixL3sAOeS0K_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX/aOWDHgwVS3k
 GAttn9t5hb5H3G1ZLrueH9wX/CeiH3GUUPp8uUzYLflmJmU0PDrZbr1A1+eoESGBybugyZEIBcE
 PEz9+Q+35ifnjXGQJGmTDodn56chhdjqnawK0M7t7KVyyeAI7JW/V464HKFlaORoRoBVXvS+N+R
 TGvJpPErTWYWLaPBtyggYyf5pdrlZhpEg0CERw0w4K3HIsIi5naoETilRVFBnslOvajmgeVLibI
 o81tKlYErf/oI3oIQxwjp1aDioT/u0b14t/nGlDhrDC6StQBYsFXQ4SIRQ+JJPWiiQNWvvxrKJ0
 QyC9Vd5hRbHsyOWzXJoXl1+7Q0dZZr3zfpVTFQnv4Oix0NGuhSH6UZMrj6B8y0yheDqaWw6GL0z
 ZLH65FdJBlTE59X0+3H6t71C/3uY0wksqZAp3FyImHiouTsQgKCgz74vrzjGMZuWEuzBgksaSfl
 nYNLEI25ngIL/T+Tdlw==
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=6964a4a3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fIzkMDVc4DzzmXS1f8kA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: brrjGNc9CsNOqOpFvVJGixL3sAOeS0K_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120058

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


