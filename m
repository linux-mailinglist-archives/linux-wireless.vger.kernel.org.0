Return-Path: <linux-wireless+bounces-27662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32988BA26FC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 07:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C63628428
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 05:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B0E2741A6;
	Fri, 26 Sep 2025 05:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mtbDLt2L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33C326E16A
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758864165; cv=none; b=LMh9AafhuIsjpAuUsYZhmI9N+lVEhr5Q7FX0Skc3Yfjc2yg5JfsHl4+eBKl+N6Ih/A9yz/4u56rtcy+89xK08UH5V02R07OsAz30axWuH8pwL+TL8xByy/01cuoYBg9+Leq77J8/DBfsXwebGU8nCnBVtjRr5Ti3XEkaZ49XiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758864165; c=relaxed/simple;
	bh=zcr0pf+h5/ZFhJ0EoKH91Z9XA91CLdB8erlS/oVc6po=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAKKeBo1+JoicsMle+uLpKG+5HZPe+6tiNJWM61dnadRqlsSUMpoLt22YU2WRJpf/Iuid8i3AZ1bAWUvZGwd+h0wb4khsX/ca+KCjx1S9E5Oy0FXakljGpL5fINsk+tMBnhZuJz3/koRwhQWpNuKNXXzpJwlFxofQQ67mpX65WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mtbDLt2L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPYZp011327;
	Fri, 26 Sep 2025 05:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4McW6R2Kqjr+eYnlijcdZ4zUNQ7CpJK6TQBD54QEFyM=; b=mtbDLt2Ly7gY4JkU
	bvrk5PxttqnxmTBpQ2xVUjoFEJVa9xCP1+lLDCB84kwlxfR2R8FyvC6sQGCtvRuQ
	OQrkDo1bwWsvB+uVKzH9IecYLfiMVEU7AGRIIdrPv4gvgwC1UG95csTm+7hwJMnd
	7uXg9qegc/i9OVD05wkc9wdl9LoIlbr7hbKyQPxBykpZXNboWv1eN4q0/WnyZw3p
	VbApy3ooPWFLC5qZW8Bt35DTibr1q8GYA8tX6pn7gxaqxiGZJROGB/3bNhSEr6Sa
	1t9sBmBcmdHtl00mbbyxCGkwT3d3D4Tny18Mj1uH+Jgxcs6Q9vQLKcJnqJjAzEMT
	LDdS1Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q1hes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 05:22:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58Q5Mfa0027719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 05:22:41 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 25 Sep 2025 22:22:39 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng v2 5/6] wifi: ath12k: Add framework for hardware specific DP interrupt registration
Date: Fri, 26 Sep 2025 10:52:17 +0530
Message-ID: <20250926052218.893876-6-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926052218.893876-1-quic_rdeuri@quicinc.com>
References: <20250926052218.893876-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yjTAlNLx24rH5GZTsUChLpYx5ajYiQ6M
X-Proofpoint-GUID: yjTAlNLx24rH5GZTsUChLpYx5ajYiQ6M
X-Authority-Analysis: v=2.4 cv=aZhsXBot c=1 sm=1 tr=0 ts=68d62321 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=qNzyvx2WuQM3fURhGUEA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX4Zz/a4R31MX4
 fEH/1pd9UHNkrnprArQy4PG5jVJEIpAH4ksQM6h9Pc9RfnCQeloU43uMcqfxH34iNuSC791pY6q
 AbPDvpqxtFiPKA0KRLZFBy/tt/WkI0xkakyL7IiHlXC/rOQQ6S4ZdAlD3d6pfUjujf+EVwq2jJY
 hB0XP7rXt53rfSpHmS3yO8fB0bevaChcaN1pF4p38WCQ/9z7ISfBaa/TYKhugJEdIhBEjcE2DqM
 wFUbgVqTDK6FhC9S+ae0T3i4AnoDkr6Z+KtRGtt1zRGWs8eS5amrk9t1lWoYEiAgvu59ZZhF05T
 42aHCYocavFWMhnAhN1FRWSzikWS6n+u+V/jlmgjHIHUU4TIbGjbDwhGjaMqrAzBVKZq9uZTjPw
 23Owtv7oF+2cZJcWKyGXTNj+J+g6dQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

Currently, the DP service SRNG handler is invoked directly from the NAPI
poll handler, which prevents using different handlers for different
architectures. To fix this, introduce a framework that allows registering
architecture-specific service SRNG handlers.

Also, add PCI and AHB hif_ops to manage IRQ setup and cleanup from DP.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c      | 16 +++++++-----
 drivers/net/wireless/ath/ath12k/core.h     |  3 +++
 drivers/net/wireless/ath/ath12k/hif.h      | 30 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/pci.c      | 23 +++++++++--------
 drivers/net/wireless/ath/ath12k/wifi7/dp.c | 20 ++++++++++++---
 drivers/net/wireless/ath/ath12k/wifi7/dp.h |  2 --
 6 files changed, 71 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index c545bea18935..4bacdaa62f83 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -524,10 +524,9 @@ static int ath12k_ahb_ext_grp_napi_poll(struct napi_struct *napi, int budget)
 	struct ath12k_ext_irq_grp *irq_grp = container_of(napi,
 						struct ath12k_ext_irq_grp,
 						napi);
-	struct ath12k_base *ab = irq_grp->ab;
 	int work_done;
 
-	work_done = ath12k_wifi7_dp_service_srng(ab, irq_grp, budget);
+	work_done = irq_grp->irq_handler(irq_grp->dp, irq_grp, budget);
 	if (work_done < budget) {
 		napi_complete_done(napi, work_done);
 		ath12k_ahb_ext_grp_enable(irq_grp);
@@ -553,7 +552,12 @@ static irqreturn_t ath12k_ahb_ext_interrupt_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int ath12k_ahb_config_ext_irq(struct ath12k_base *ab)
+static int
+ath12k_ahb_config_ext_irq(struct ath12k_base *ab,
+			  int (*irq_handler)(struct ath12k_dp *dp,
+					     struct ath12k_ext_irq_grp *irq_grp,
+					     int budget),
+			  struct ath12k_dp *dp)
 {
 	const struct ath12k_hw_ring_mask *ring_mask;
 	struct ath12k_ext_irq_grp *irq_grp;
@@ -569,6 +573,8 @@ static int ath12k_ahb_config_ext_irq(struct ath12k_base *ab)
 
 		irq_grp->ab = ab;
 		irq_grp->grp_id = i;
+		irq_grp->irq_handler = irq_handler;
+		irq_grp->dp = dp;
 
 		irq_grp->napi_ndev = alloc_netdev_dummy(0);
 		if (!irq_grp->napi_ndev)
@@ -652,9 +658,6 @@ static int ath12k_ahb_config_irq(struct ath12k_base *ab)
 		ab->irq_num[irq_idx] = irq;
 	}
 
-	/* Configure external interrupts */
-	ret = ath12k_ahb_config_ext_irq(ab);
-
 	return ret;
 }
 
@@ -702,6 +705,7 @@ static const struct ath12k_hif_ops ath12k_ahb_hif_ops = {
 	.map_service_to_pipe = ath12k_ahb_map_service_to_pipe,
 	.power_up = ath12k_ahb_power_up,
 	.power_down = ath12k_ahb_power_down,
+	.ext_irq_setup = ath12k_ahb_config_ext_irq,
 };
 
 static irqreturn_t ath12k_userpd_irq_handler(int irq, void *data)
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ff99d5ae6226..6a36dfdf5b17 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -166,6 +166,7 @@ enum ath12k_firmware_mode {
 #define ATH12K_MAX_TCL_RING_NUM	3
 
 struct ath12k_ext_irq_grp {
+	struct ath12k_dp *dp;
 	struct ath12k_base *ab;
 	u32 irqs[ATH12K_EXT_IRQ_NUM_MAX];
 	u32 num_irq;
@@ -174,6 +175,8 @@ struct ath12k_ext_irq_grp {
 	bool napi_enabled;
 	struct napi_struct napi;
 	struct net_device *napi_ndev;
+	int (*irq_handler)(struct ath12k_dp *dp,
+			   struct ath12k_ext_irq_grp *irq_grp, int budget);
 };
 
 enum ath12k_smbios_cc_type {
diff --git a/drivers/net/wireless/ath/ath12k/hif.h b/drivers/net/wireless/ath/ath12k/hif.h
index e8840fab6061..1f9781f6d564 100644
--- a/drivers/net/wireless/ath/ath12k/hif.h
+++ b/drivers/net/wireless/ath/ath12k/hif.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_HIF_H
@@ -32,6 +32,12 @@ struct ath12k_hif_ops {
 	void (*get_ce_msi_idx)(struct ath12k_base *ab, u32 ce_id, u32 *msi_idx);
 	int (*panic_handler)(struct ath12k_base *ab);
 	void (*coredump_download)(struct ath12k_base *ab);
+	int (*ext_irq_setup)(struct ath12k_base *ab,
+			     int (*handler)(struct ath12k_dp *dp,
+					    struct ath12k_ext_irq_grp *irq_grp,
+					    int budget),
+			     struct ath12k_dp *dp);
+	void (*ext_irq_cleanup)(struct ath12k_base *ab);
 };
 
 static inline int ath12k_hif_map_service_to_pipe(struct ath12k_base *ab, u16 service_id,
@@ -162,4 +168,26 @@ static inline void ath12k_hif_coredump_download(struct ath12k_base *ab)
 	if (ab->hif.ops->coredump_download)
 		ab->hif.ops->coredump_download(ab);
 }
+
+static inline
+int ath12k_hif_ext_irq_setup(struct ath12k_base *ab,
+			     int (*irq_handler)(struct ath12k_dp *dp,
+						struct ath12k_ext_irq_grp *irq_grp,
+						int budget),
+			     struct ath12k_dp *dp)
+{
+	if (!ab->hif.ops->ext_irq_setup)
+		return -EOPNOTSUPP;
+
+	return ab->hif.ops->ext_irq_setup(ab, irq_handler, dp);
+}
+
+static inline void ath12k_hif_ext_irq_cleanup(struct ath12k_base *ab)
+{
+	if (!ab->hif.ops->ext_irq_cleanup)
+		return;
+
+	ab->hif.ops->ext_irq_cleanup(ab);
+}
+
 #endif /* ATH12K_HIF_H */
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 672cf2899681..a28bea5c1d40 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -319,8 +319,6 @@ static void ath12k_pci_free_irq(struct ath12k_base *ab)
 		irq_idx = ATH12K_PCI_IRQ_CE0_OFFSET + i;
 		free_irq(ab->irq_num[irq_idx], &ab->ce.ce_pipe[i]);
 	}
-
-	ath12k_pci_free_ext_irq(ab);
 }
 
 static void ath12k_pci_ce_irq_enable(struct ath12k_base *ab, u16 ce_id)
@@ -478,11 +476,10 @@ static int ath12k_pci_ext_grp_napi_poll(struct napi_struct *napi, int budget)
 	struct ath12k_ext_irq_grp *irq_grp = container_of(napi,
 						struct ath12k_ext_irq_grp,
 						napi);
-	struct ath12k_base *ab = irq_grp->ab;
 	int work_done;
 	int i;
 
-	work_done = ath12k_wifi7_dp_service_srng(ab, irq_grp, budget);
+	work_done = irq_grp->irq_handler(irq_grp->dp, irq_grp, budget);
 	if (work_done < budget) {
 		napi_complete_done(napi, work_done);
 		for (i = 0; i < irq_grp->num_irq; i++)
@@ -517,7 +514,12 @@ static irqreturn_t ath12k_pci_ext_interrupt_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
+static
+int ath12k_pci_ext_irq_config(struct ath12k_base *ab,
+			      int (*irq_handler)(struct ath12k_dp *dp,
+						 struct ath12k_ext_irq_grp *irq_grp,
+						 int budget),
+			      struct ath12k_dp *dp)
 {
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 	int i, j, n, ret, num_vectors = 0;
@@ -538,6 +540,8 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 
 		irq_grp->ab = ab;
 		irq_grp->grp_id = i;
+		irq_grp->irq_handler = irq_handler;
+		irq_grp->dp = dp;
 		irq_grp->napi_ndev = alloc_netdev_dummy(0);
 		if (!irq_grp->napi_ndev) {
 			ret = -ENOMEM;
@@ -651,10 +655,6 @@ static int ath12k_pci_config_irq(struct ath12k_base *ab)
 		ath12k_pci_ce_irq_disable(ab, i);
 	}
 
-	ret = ath12k_pci_ext_irq_config(ab);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
@@ -1483,6 +1483,8 @@ static const struct ath12k_hif_ops ath12k_pci_hif_ops = {
 #ifdef CONFIG_ATH12K_COREDUMP
 	.coredump_download = ath12k_pci_coredump_download,
 #endif
+	.ext_irq_setup = ath12k_pci_ext_irq_config,
+	.ext_irq_cleanup = ath12k_pci_free_ext_irq,
 };
 
 static enum ath12k_device_family
@@ -1691,6 +1693,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	ath12k_fw_unmap(ab);
 	ath12k_mhi_unregister(ab_pci);
 
+	ab_pci->device_family_ops->arch_deinit(ab);
 	ath12k_pci_free_irq(ab);
 	ath12k_pci_msi_free(ab_pci);
 	ath12k_pci_free_region(ab_pci);
@@ -1698,8 +1701,6 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	ath12k_hal_srng_deinit(ab);
 	ath12k_ce_free_pipes(ab);
 
-	ab_pci->device_family_ops->arch_deinit(ab);
-
 	ath12k_core_free(ab);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index adc3480b282b..df9696549d06 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -10,13 +10,15 @@
 #include "../dp_mon.h"
 #include "../dp_cmn.h"
 #include "dp_rx.h"
+#include "../hif.h"
 #include "dp.h"
 #include "dp_tx.h"
 
-int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
-				 struct ath12k_ext_irq_grp *irq_grp,
-				 int budget)
+static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
+					struct ath12k_ext_irq_grp *irq_grp,
+					int budget)
 {
+	struct ath12k_base *ab = dp->ab;
 	struct napi_struct *napi = &irq_grp->napi;
 	int grp_id = irq_grp->grp_id;
 	int work_done = 0;
@@ -138,6 +140,7 @@ int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
 struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp;
+	int ret;
 
 	/* TODO: align dp later if cache alignment becomes a bottleneck */
 	dp = kzalloc(sizeof(*dp), GFP_KERNEL);
@@ -148,12 +151,23 @@ struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab)
 	dp->dev = ab->dev;
 	dp->hw_params = ab->hw_params;
 
+	ret = ath12k_hif_ext_irq_setup(dp->ab, ath12k_wifi7_dp_service_srng, dp);
+	if (ret) {
+		ath12k_err(ab, "failed to setup ext irq, ret %d", ret);
+		goto free_dp;
+	}
+
 	return dp;
+
+free_dp:
+	kfree(dp);
+	return NULL;
 }
 EXPORT_SYMBOL(ath12k_wifi7_dp_device_alloc);
 
 void ath12k_wifi7_dp_device_free(struct ath12k_dp *dp)
 {
+	ath12k_hif_ext_irq_cleanup(dp->ab);
 	kfree(dp);
 }
 EXPORT_SYMBOL(ath12k_wifi7_dp_device_free);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.h b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
index 2300fda65786..72fdfb368c99 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
@@ -13,8 +13,6 @@
 struct ath12k_base;
 struct ath12k_dp;
 
-int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
-				 struct ath12k_ext_irq_grp *irq_grp, int budget);
 struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab);
 void ath12k_wifi7_dp_device_free(struct ath12k_dp *dp);
 
-- 
2.34.1


