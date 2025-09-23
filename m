Return-Path: <linux-wireless+bounces-27611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50796B95589
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 11:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E81B18A1597
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C86E320A08;
	Tue, 23 Sep 2025 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NnOibgG3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496913AD26
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621414; cv=none; b=ZKshdGe/bTbmtL0bv7z2mzk9LG9GPLC4dPaR5zhVb1tZaVfkwCjESN+8CWhCz1MRtcLKO7WYtG0skTMxLQz3OsmDkGH2514YrzRCuPw73eXW6/WlwBjeRpmjmYMqZeA9OLUqcKl365yRPS4VMFAGEbHVPPziiodmzu1me6Ukp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621414; c=relaxed/simple;
	bh=JOvupwM+5J0RaSrlDIK1IKo3IJ1Qh50pARsE1Lrqyys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAe3qcYqv4nsDuSEENp9VMchIDf/kdoKtNVvwsKAGLqsCBE2IhpTR976V+SVKwPF8h+POQuSS/FUDKpudJuj6XdHYt0LUxRbrsCT+L1fNlX3T6vdknwb+lzlXQqQYKz+pF2SCMiTJvdATOzXg1in0hFkWyBecvxCZP+Yyx9uXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NnOibgG3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8HILY023900;
	Tue, 23 Sep 2025 09:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3rBMTxrWBFONNh/3mSVGN1Xh4xJSh5cyWYTxwAaq/kY=; b=NnOibgG3QvnN3lvK
	8iq2TvSy+VffpLmE6m64IMm4tI6STCM/eluGKeMObusH530wq3uBAhb6pgDAQ6Vn
	zMapehzrNOBpfIYFv9dMWdmson4VH/5RBZ60t5zUp/uOL4Yg+tDf6hnTp2vS+/c1
	0+0lhdBSNru9fycPGvbi66tuzcc8coI1IcoXG1/xkLuZmcNsWfbDYU6iGFPP8s1b
	pqYtZVq1fq/8/pm5P6J9lNr5CQ4n1DZyUe2QxErxsNtIdUruQqe4pijx16LPpU76
	f1vBpueejCXy4kxXrMcQ8zI9aRErP2w7AyU6M8/lZ0mWVEwyq+X5XXzBe1vjDAqy
	G6kqkg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nybv7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 09:56:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58N9unfU027165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 09:56:49 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 23 Sep 2025 02:56:47 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 5/6] wifi: ath12k: Add framework for hardware specific DP interrupt registration
Date: Tue, 23 Sep 2025 15:26:27 +0530
Message-ID: <20250923095628.2438280-6-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923095628.2438280-1-quic_rdeuri@quicinc.com>
References: <20250923095628.2438280-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d26ee2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=boQPsJf0mRWV6-TzE2AA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: LB629wNpGyxyk7-eoipVXmjsxISEu_Tl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX1GBES44HwGoR
 Pxyo9p1DEGav3P3RUVrD1En8Op3yxyR1MMkxp5OoLEt5hGfcy6AAEnJaqcymJA7l+tQXcaSClLO
 pU68qeHkIP2A6u/iPCF4Y5uhJI8w3HeymOUPJEDUJAFhJMsP1HT1sJjbuxySEOqk7ztWhFScJg8
 OkjFPkYtSXS7LafIYEz43TcMo3K92aOl9vzIhQAjNgOpGLdktK+d1zAC77mijxHho3avCG5Dfta
 bmTWwQuNv5Ffa5npwmpffDEIRyRwqjofYYmjXfRrrB1697RCkF4UWmY5ljSKOP/YP9DIPehtSpn
 PVMXC6JebmyEr31n1oeoSBs4Ae1CvuBqJmOQ0bcKYCfiowh1tyNrwltoB9owtiOhXUVP6gSqNr8
 /JsAw2wQ
X-Proofpoint-ORIG-GUID: LB629wNpGyxyk7-eoipVXmjsxISEu_Tl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

Introduce an architecture-specific ops mechanism to handle interrupt
registration for Data Path (DP). While the interrupt trigger originates
from common DP code, the registration process differs across hardware
architectures. This mechanism allows the common module to invoke functions
implemented in architecture-specific modules.

Add a generic dp_device_init() op to perform architecture-specific device
initializations. Currently, this is used to set up interrupts, but it can
be used for other initialization tasks in the future.

Add PCI and AHB hif_ops to handle IRQ setup and cleanup from DP.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c      | 16 +++++++-----
 drivers/net/wireless/ath/ath12k/core.h     |  3 +++
 drivers/net/wireless/ath/ath12k/dp.c       |  5 ++++
 drivers/net/wireless/ath/ath12k/dp.h       | 10 ++++++++
 drivers/net/wireless/ath/ath12k/hif.h      | 30 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/pci.c      | 20 ++++++++-------
 drivers/net/wireless/ath/ath12k/wifi7/dp.c | 29 ++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/wifi7/dp.h |  2 --
 8 files changed, 94 insertions(+), 21 deletions(-)

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
index 5a6f79c19aaa..0a0a600a433d 100644
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
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 39d6bd41b4ef..34ff5736dd25 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1672,6 +1672,7 @@ static int ath12k_dp_setup(struct ath12k_base *ab)
 
 void ath12k_dp_cmn_device_deinit(struct ath12k_dp *dp)
 {
+	dp->ops->dp_device_deinit(dp);
 	ath12k_dp_cleanup(dp->ab);
 }
 
@@ -1679,6 +1680,10 @@ int ath12k_dp_cmn_device_init(struct ath12k_dp *dp)
 {
 	int ret;
 
+	ret = dp->ops->dp_device_init(dp);
+	if (ret)
+		return ret;
+
 	ret = ath12k_dp_setup(dp->ab);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 05f48b461774..57ce5e1e39d0 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -367,6 +367,14 @@ struct ath12k_link_stats {
 	u32 tx_desc_type[HAL_TCL_DESC_TYPE_MAX];
 };
 
+/* DP arch ops to communicate from common module
+ * to arch specific module
+ */
+struct ath12k_dp_arch_ops {
+	int (*dp_device_init)(struct ath12k_dp *dp);
+	void (*dp_device_deinit)(struct ath12k_dp *dp);
+};
+
 struct ath12k_dp {
 	struct ath12k_base *ab;
 	u32 mon_dest_ring_stuck_cnt;
@@ -430,6 +438,8 @@ struct ath12k_dp {
 
 	struct ath12k_hw_group *ag;
 	u8 device_id;
+
+	struct ath12k_dp_arch_ops *ops;
 };
 
 static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
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
index 672cf2899681..c7dc0c976a89 100644
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
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index adc3480b282b..c96c8bf062f4 100644
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
@@ -134,6 +136,25 @@ int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
 	return tot_work_done;
 }
 
+static int ath12k_wifi7_dp_op_device_init(struct ath12k_dp *dp)
+{
+	int ret;
+
+	ret = ath12k_hif_ext_irq_setup(dp->ab, ath12k_wifi7_dp_service_srng, dp);
+
+	return ret;
+}
+
+static void ath12k_wifi7_dp_op_device_deinit(struct ath12k_dp *dp)
+{
+	ath12k_hif_ext_irq_cleanup(dp->ab);
+}
+
+static struct ath12k_dp_arch_ops ath12k_wifi7_dp_arch_ops = {
+	.dp_device_init = ath12k_wifi7_dp_op_device_init,
+	.dp_device_deinit = ath12k_wifi7_dp_op_device_deinit,
+};
+
 /* TODO: remove export once this file is built with wifi7 ko */
 struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab)
 {
@@ -144,6 +165,8 @@ struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab)
 	if (!dp)
 		return NULL;
 
+	dp->ops = &ath12k_wifi7_dp_arch_ops;
+
 	dp->ab = ab;
 	dp->dev = ab->dev;
 	dp->hw_params = ab->hw_params;
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


