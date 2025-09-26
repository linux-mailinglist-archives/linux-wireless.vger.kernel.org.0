Return-Path: <linux-wireless+bounces-27659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC336BA26F3
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 07:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8EBE7B5DDD
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 05:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D605275852;
	Fri, 26 Sep 2025 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Njzt7Mpc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5246426E16A
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 05:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758864162; cv=none; b=OrfZkApj4Dzi0bV2OP9AUKbXvcGfsi2KVrxGdvk9y0ctBgGJ7fbD7k1ZPcII8VESLI0+9IJy4+gQFXBw5vRqTH0kiTwzmIgNSlYqTXU2lg4VgmhrZNllWXwMMnxdr5ZOO3UKQjplXbu+/TPSr3rdkAW11SgX5B9Nf9gh9TPR+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758864162; c=relaxed/simple;
	bh=xPWEL5ZOfTLfHoDKiCQ07Y3eFMkOM72XFUgMox4AoDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CK5e5QWRJnGLRngB3MSIW597o9iN45bUAmrVPX5x0F0xHdIiROQhpssIc4r898yZTMBRnsSeWiTaUwWOGdZr/AdZuo8eYJEO37ZWn3+Y+lPywJZpMs865dmeb7ccyS/71dVnb1FrcVrt5IG920nOROzFMH4qvPS9vC80ivO/NGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Njzt7Mpc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPcDw021544;
	Fri, 26 Sep 2025 05:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6QWS6JUoSVDFejXCac+dH2uQJAhfpp0HIPqRtS64n1M=; b=Njzt7MpcVBmZiIHm
	/n0GiptfUA4PsrbPip3lUlG0DMP/yKSCXzUi62mu3h9XaZo25zXiYSgsRw4uUCPG
	DA9+4PgV0W0eRXgu6Z05hRdG5RYf3BAf6y+MG4zcXw8vECvcPYJN0Q1eljk7pGsU
	RpPaiIFgD9Px4uOuqliWvnSWNQOQh9MEPBJQW7+oqEeXnQpGZ1Bbys2cRzN25j3F
	puMCR1/nvYxrL9tsIx0bzQ/9eesw2QYbzhLyGiXX/m9filWLLziNW2PLKtqfsrc2
	P/Mr1WM1747/VBpaHobn5FUh/4m4KUrslyMzgPzC0ohzEljp03ykJLnhpJLfPSqq
	34dz0A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qsh8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 05:22:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58Q5MaVc027693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 05:22:36 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 25 Sep 2025 22:22:35 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng v2 2/6] wifi: ath12k: Support arch-specific DP device allocation
Date: Fri, 26 Sep 2025 10:52:14 +0530
Message-ID: <20250926052218.893876-3-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: GsEiAOVaOrqTSA2OKzemlrim9ERoDD2g
X-Proofpoint-ORIG-GUID: GsEiAOVaOrqTSA2OKzemlrim9ERoDD2g
X-Authority-Analysis: v=2.4 cv=api/yCZV c=1 sm=1 tr=0 ts=68d6231d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=5rtgWtJVenDuiVS00h8A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX/OmeRbIFzGcu
 yGMsBYiAq9ZuWiK1CifwGI8SFgdK3o2ZfgVkVktT16CfjMt0ldcU/tsW/w0HSCuUOfrw8bNpyVy
 bi9J8qOfKYmh67sBZve5aOXA2b20QTlVAACj3nDJUs2M2DgGGFpbF/d6pQeGTH/KfadA/P5AN7J
 X7rZPzlnoG1eprh7JOE5tbq4quLJeiLq6J9Q9v5PLnBy4Dk+LHB6zXkXsq1qpvzycdO2K9cf9TP
 G2VtG2x62lsRV4+K8metj65KSmXzhR4DE1RB/2ILQjD99VcM/MPGObSAi8BVe1pbtdy1IsuNDu1
 +RQAoSN5GuA/oISbBXJcOupgJgibt7HD8i3PPCQIt5F51MMv2xx9D2Xlr9PiT055xqJSn4t0pAp
 7glTuqVB3SrG+vj4TD8FSHiBvqLjMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

Add arch_init() and arch_deinit() ops to the PCI and AHB family ops to
support allocation and cleanup of architecture-specific fields in
ath12k_base. Define shared ath12k_wifi7_arch_init() and
ath12k_wifi7_arch_deinit() functions to handle DP device allocation and
cleanup for Wi-Fi 7 across both PCI and AHB. Introduce a new header file
wifi7/core.h to declare functions defined in wifi7/core.c.

Currently, DP device allocation and cleanup are handled via arch_init()
and arch_deinit(), which can be extended to support additional
architecture-specific initialization in the future.

Define common ath12k_wifi7_arch_init() and
ath12k_wifi7_arch_deinit() functions to handle allocation and cleanup
for Wi-Fi 7. Add a new header file wifi7/core.h to declare common Wi-Fi 7
functions.

Add ath12k_wifi7_dp_device_alloc() and ath12k_wifi7_dp_device_free() to
handle allocation and deallocation of the DP device object for Wi-Fi 7.

Add ath12k_dp_cmn_device_init() and ath12k_dp_cmn_device_deinit() to
initialize and deinitialize common DP device fields. Introduce a new header
file dp_cmn.h to declare these functions, which can also be used to expose
new common DP functions that need to be invoked from non-DP code.

Rename existing DP allocation and cleanup functions to ath12k_dp_setup()
and ath12k_dp_cleanup() to better reflect their purpose in the updated
design.

Replicate device-related fields such as device and hw_params in the DP
device object to align with the new design, which limits per packet data
path object usage to DP specific objects.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c        | 19 ++++++++--
 drivers/net/wireless/ath/ath12k/ahb.h        |  4 ++-
 drivers/net/wireless/ath/ath12k/core.c       | 13 +++----
 drivers/net/wireless/ath/ath12k/dp.c         | 38 +++++++++++---------
 drivers/net/wireless/ath/ath12k/dp.h         |  4 +--
 drivers/net/wireless/ath/ath12k/dp_cmn.h     | 12 +++++++
 drivers/net/wireless/ath/ath12k/pci.c        | 20 +++++++++--
 drivers/net/wireless/ath/ath12k/pci.h        |  4 ++-
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c  |  4 +++
 drivers/net/wireless/ath/ath12k/wifi7/core.c | 24 +++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/core.h | 11 ++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp.c   | 25 +++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp.h   |  7 ++++
 drivers/net/wireless/ath/ath12k/wifi7/pci.c  |  4 +++
 14 files changed, 159 insertions(+), 30 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_cmn.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/core.h

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 168d588604a1..c545bea18935 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -1088,14 +1088,26 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 		goto err_rproc_deconfigure;
 	}
 
+	/* Invoke arch_init here so that arch-specific init operations
+	 * can utilize already initialized ab fields, such as HAL SRNGs.
+	 */
+	ret = ab_ahb->device_family_ops->arch_init(ab);
+	if (ret) {
+		ath12k_err(ab, "AHB arch_init failed %d\n", ret);
+		goto err_rproc_deconfigure;
+	}
+
 	ret = ath12k_core_init(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to init core: %d\n", ret);
-		goto err_rproc_deconfigure;
+		goto err_deinit_arch;
 	}
 
 	return 0;
 
+err_deinit_arch:
+	ab_ahb->device_family_ops->arch_deinit(ab);
+
 err_rproc_deconfigure:
 	ath12k_ahb_deconfigure_rproc(ab);
 
@@ -1134,11 +1146,13 @@ static void ath12k_ahb_remove_prepare(struct ath12k_base *ab)
 static void ath12k_ahb_free_resources(struct ath12k_base *ab)
 {
 	struct platform_device *pdev = ab->pdev;
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
 
 	ath12k_hal_srng_deinit(ab);
 	ath12k_ce_free_pipes(ab);
 	ath12k_ahb_resource_deinit(ab);
 	ath12k_ahb_deconfigure_rproc(ab);
+	ab_ahb->device_family_ops->arch_deinit(ab);
 	ath12k_core_free(ab);
 	platform_set_drvdata(pdev, NULL);
 }
@@ -1167,7 +1181,8 @@ int ath12k_ahb_register_driver(const enum ath12k_device_family device_id,
 	if (device_id >= ATH12K_DEVICE_FAMILY_MAX)
 		return -EINVAL;
 
-	if (!driver || !driver->ops.probe)
+	if (!driver || !driver->ops.probe ||
+	    !driver->ops.arch_init || !driver->ops.arch_deinit)
 		return -EINVAL;
 
 	if (ath12k_ahb_family_drivers[device_id]) {
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index fce02e3af5fb..8a040d03d27a 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.h
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #ifndef ATH12K_AHB_H
 #define ATH12K_AHB_H
@@ -46,6 +46,8 @@ struct ath12k_base;
 
 struct ath12k_ahb_device_family_ops {
 	int (*probe)(struct platform_device *pdev);
+	int (*arch_init)(struct ath12k_base *ab);
+	void (*arch_deinit)(struct ath12k_base *ab);
 };
 
 struct ath12k_ahb {
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 1534efe35887..e5b358f5e703 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -22,6 +22,7 @@
 #include "hif.h"
 #include "pci.h"
 #include "wow.h"
+#include "dp_cmn.h"
 
 unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
@@ -711,7 +712,7 @@ static void ath12k_core_stop(struct ath12k_base *ab)
 	ath12k_dp_rx_pdev_reo_cleanup(ab);
 	ath12k_hif_stop(ab);
 	ath12k_wmi_detach(ab);
-	ath12k_dp_free(ab);
+	ath12k_dp_cmn_device_deinit(ath12k_ab_to_dp(ab));
 
 	/* De-Init of components as needed */
 }
@@ -1290,7 +1291,7 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 		goto err_firmware_stop;
 	}
 
-	ret = ath12k_dp_alloc(ab);
+	ret = ath12k_dp_cmn_device_init(ath12k_ab_to_dp(ab));
 	if (ret) {
 		ath12k_err(ab, "failed to init DP: %d\n", ret);
 		goto err_firmware_stop;
@@ -1302,7 +1303,7 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 	ret = ath12k_core_start(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to start core: %d\n", ret);
-		goto err_dp_free;
+		goto err_deinit;
 	}
 
 	mutex_unlock(&ab->core_lock);
@@ -1335,8 +1336,8 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 	mutex_unlock(&ag->mutex);
 	goto exit;
 
-err_dp_free:
-	ath12k_dp_free(ab);
+err_deinit:
+	ath12k_dp_cmn_device_deinit(ath12k_ab_to_dp(ab));
 	mutex_unlock(&ab->core_lock);
 	mutex_unlock(&ag->mutex);
 
@@ -1358,7 +1359,7 @@ static int ath12k_core_reconfigure_on_crash(struct ath12k_base *ab)
 	ath12k_dp_rx_pdev_reo_cleanup(ab);
 	mutex_unlock(&ab->core_lock);
 
-	ath12k_dp_free(ab);
+	ath12k_dp_cmn_device_deinit(ath12k_ab_to_dp(ab));
 	ath12k_hal_srng_deinit(ab);
 	total_vdev = ab->num_radios * TARGET_NUM_VDEVS(ab);
 	ab->free_vdev_map = (1LL << total_vdev) - 1;
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 9a97eb868542..f8d38562fc7f 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -13,6 +13,7 @@
 #include "wifi7/dp_rx.h"
 #include "peer.h"
 #include "dp_mon.h"
+#include "dp_cmn.h"
 
 enum ath12k_dp_desc_type {
 	ATH12K_DP_TX_DESC,
@@ -1130,7 +1131,7 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
 	}
 }
 
-void ath12k_dp_free(struct ath12k_base *ab)
+static void ath12k_dp_cleanup(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int i;
@@ -1155,8 +1156,6 @@ void ath12k_dp_free(struct ath12k_base *ab)
 
 	ath12k_dp_rx_free(ab);
 	/* Deinit any SOC level resource */
-	kfree(ab->dp);
-	ab->dp = NULL;
 }
 
 void ath12k_dp_cc_config(struct ath12k_base *ab)
@@ -1564,7 +1563,7 @@ ath12k_dp_get_idle_link_rbm(struct ath12k_base *ab)
 	}
 }
 
-int ath12k_dp_alloc(struct ath12k_base *ab)
+static int ath12k_dp_setup(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp;
 	struct hal_srng *srng = NULL;
@@ -1573,12 +1572,7 @@ int ath12k_dp_alloc(struct ath12k_base *ab)
 	int ret;
 	int i;
 
-	/* TODO: align dp later if cache alignment becomes a bottleneck */
-	dp = kzalloc(sizeof(*dp), GFP_KERNEL);
-	if (!dp)
-		return -ENOMEM;
-
-	ab->dp = dp;
+	dp = ath12k_ab_to_dp(ab);
 	dp->ab = ab;
 
 	INIT_LIST_HEAD(&dp->reo_cmd_list);
@@ -1591,7 +1585,7 @@ int ath12k_dp_alloc(struct ath12k_base *ab)
 	ret = ath12k_wbm_idle_ring_setup(ab, &n_link_desc);
 	if (ret) {
 		ath12k_warn(ab, "failed to setup wbm_idle_ring: %d\n", ret);
-		goto fail_dp_free;
+		return ret;
 	}
 
 	srng = &ab->hal.srng_list[dp->wbm_idle_ring.ring_id];
@@ -1600,7 +1594,7 @@ int ath12k_dp_alloc(struct ath12k_base *ab)
 					HAL_WBM_IDLE_LINK, srng, n_link_desc);
 	if (ret) {
 		ath12k_warn(ab, "failed to setup link desc: %d\n", ret);
-		goto fail_dp_free;
+		return ret;
 	}
 
 	ret = ath12k_dp_cc_init(ab);
@@ -1673,9 +1667,21 @@ int ath12k_dp_alloc(struct ath12k_base *ab)
 	ath12k_dp_link_desc_cleanup(ab, dp->link_desc_banks,
 				    HAL_WBM_IDLE_LINK, &dp->wbm_idle_ring);
 
-fail_dp_free:
-	kfree(ab->dp);
-	ab->dp = NULL;
-
 	return ret;
 }
+
+void ath12k_dp_cmn_device_deinit(struct ath12k_dp *dp)
+{
+	ath12k_dp_cleanup(dp->ab);
+}
+
+int ath12k_dp_cmn_device_init(struct ath12k_dp *dp)
+{
+	int ret;
+
+	ret = ath12k_dp_setup(dp->ab);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 71f7c4858176..8b3973e0e676 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -424,6 +424,8 @@ struct ath12k_dp {
 	struct dp_rxdma_mon_ring rx_mon_status_refill_ring[MAX_RXDMA_PER_PDEV];
 	struct ath12k_reo_q_addr_lut reoq_lut;
 	struct ath12k_reo_q_addr_lut ml_reoq_lut;
+	const struct ath12k_hw_params *hw_params;
+	struct device *dev;
 };
 
 static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
@@ -433,8 +435,6 @@ static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
 }
 
 void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif);
-void ath12k_dp_free(struct ath12k_base *ab);
-int ath12k_dp_alloc(struct ath12k_base *ab);
 void ath12k_dp_cc_config(struct ath12k_base *ab);
 void ath12k_dp_partner_cc_init(struct ath12k_base *ab);
 int ath12k_dp_pdev_alloc(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/dp_cmn.h b/drivers/net/wireless/ath/ath12k/dp_cmn.h
new file mode 100644
index 000000000000..acc0782ad309
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/dp_cmn.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH12K_DP_CMN_H
+#define ATH12K_DP_CMN_H
+
+void ath12k_dp_cmn_device_deinit(struct ath12k_dp *dp);
+int ath12k_dp_cmn_device_init(struct ath12k_dp *dp);
+
+#endif
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 53f564ff5afa..672cf2899681 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1620,13 +1620,25 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		goto err_free_irq;
 	}
 
+	/* Invoke arch_init here so that arch-specific init operations
+	 * can utilize already initialized ab fields, such as HAL SRNGs.
+	 */
+	ret = ab_pci->device_family_ops->arch_init(ab);
+	if (ret) {
+		ath12k_err(ab, "PCI arch_init failed %d\n", ret);
+		goto err_pci_msi_free;
+	}
+
 	ret = ath12k_core_init(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to init core: %d\n", ret);
-		goto err_free_irq;
+		goto err_deinit_arch;
 	}
 	return 0;
 
+err_deinit_arch:
+	ab_pci->device_family_ops->arch_deinit(ab);
+
 err_free_irq:
 	/* __free_irq() expects the caller to have cleared the affinity hint */
 	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
@@ -1685,6 +1697,9 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 
 	ath12k_hal_srng_deinit(ab);
 	ath12k_ce_free_pipes(ab);
+
+	ab_pci->device_family_ops->arch_deinit(ab);
+
 	ath12k_core_free(ab);
 }
 
@@ -1781,7 +1796,8 @@ int ath12k_pci_register_driver(const enum ath12k_device_family device_id,
 	if (device_id >= ATH12K_DEVICE_FAMILY_MAX)
 		return -EINVAL;
 
-	if (!driver || !driver->ops.probe)
+	if (!driver || !driver->ops.probe ||
+	    !driver->ops.arch_init || !driver->ops.arch_deinit)
 		return -EINVAL;
 
 	if (ath12k_pci_family_drivers[device_id]) {
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 5af33e5deacf..2c19bb42f0f7 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #ifndef ATH12K_PCI_H
 #define ATH12K_PCI_H
@@ -97,6 +97,8 @@ struct ath12k_pci_ops {
 
 struct ath12k_pci_device_family_ops {
 	int (*probe)(struct pci_dev *pdev, const struct pci_device_id *pci_dev);
+	int (*arch_init)(struct ath12k_base *ab);
+	void (*arch_deinit)(struct ath12k_base *ab);
 };
 
 struct ath12k_pci_reg_base {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/ahb.c b/drivers/net/wireless/ath/ath12k/wifi7/ahb.c
index 803e13207bc0..a6c5f7689edd 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/ahb.c
@@ -12,6 +12,8 @@
 #include "../debug.h"
 #include "../hif.h"
 #include "hw.h"
+#include "dp.h"
+#include "core.h"
 
 static const struct of_device_id ath12k_wifi7_ahb_of_match[] = {
 	{ .compatible = "qcom,ipq5332-wifi",
@@ -57,6 +59,8 @@ static struct ath12k_ahb_driver ath12k_wifi7_ahb_driver = {
 	.name = "ath12k_wifi7_ahb",
 	.id_table = ath12k_wifi7_ahb_of_match,
 	.ops.probe = ath12k_wifi7_ahb_probe,
+	.ops.arch_init = ath12k_wifi7_arch_init,
+	.ops.arch_deinit = ath12k_wifi7_arch_deinit,
 };
 
 int ath12k_wifi7_ahb_init(void)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/core.c b/drivers/net/wireless/ath/ath12k/wifi7/core.c
index eb882e56e5ec..a02c57acf137 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/core.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/core.c
@@ -9,9 +9,33 @@
 #include "../pci.h"
 #include "pci.h"
 #include "ahb.h"
+#include "core.h"
+#include "dp.h"
+#include "../debug.h"
 
 static int ahb_err, pci_err;
 
+int ath12k_wifi7_arch_init(struct ath12k_base *ab)
+{
+	struct ath12k_dp *dp;
+
+	dp = ath12k_wifi7_dp_device_alloc(ab);
+	if (!dp) {
+		ath12k_err(ab, "dp alloc failed");
+		return -EINVAL;
+	}
+
+	ab->dp = dp;
+
+	return 0;
+}
+
+void ath12k_wifi7_arch_deinit(struct ath12k_base *ab)
+{
+	ath12k_wifi7_dp_device_free(ab->dp);
+	ab->dp = NULL;
+}
+
 static int ath12k_wifi7_init(void)
 {
 	ahb_err = ath12k_wifi7_ahb_init();
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/core.h b/drivers/net/wireless/ath/ath12k/wifi7/core.h
new file mode 100644
index 000000000000..7e9689d2ddd7
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/core.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef ATH12K_CORE_WIFI7_H
+#define ATH12K_CORE_WIFI7_H
+
+int ath12k_wifi7_arch_init(struct ath12k_base *ab);
+void ath12k_wifi7_arch_deinit(struct ath12k_base *ab);
+
+#endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index 4310f06163c9..adc3480b282b 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -8,6 +8,7 @@
 #include "../dp_rx.h"
 #include "../dp_tx.h"
 #include "../dp_mon.h"
+#include "../dp_cmn.h"
 #include "dp_rx.h"
 #include "dp.h"
 #include "dp_tx.h"
@@ -132,3 +133,27 @@ int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
 done:
 	return tot_work_done;
 }
+
+/* TODO: remove export once this file is built with wifi7 ko */
+struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab)
+{
+	struct ath12k_dp *dp;
+
+	/* TODO: align dp later if cache alignment becomes a bottleneck */
+	dp = kzalloc(sizeof(*dp), GFP_KERNEL);
+	if (!dp)
+		return NULL;
+
+	dp->ab = ab;
+	dp->dev = ab->dev;
+	dp->hw_params = ab->hw_params;
+
+	return dp;
+}
+EXPORT_SYMBOL(ath12k_wifi7_dp_device_alloc);
+
+void ath12k_wifi7_dp_device_free(struct ath12k_dp *dp)
+{
+	kfree(dp);
+}
+EXPORT_SYMBOL(ath12k_wifi7_dp_device_free);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.h b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
index 9332b9401bbf..2300fda65786 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
@@ -7,8 +7,15 @@
 #ifndef ATH12K_DP_WIFI7_H
 #define ATH12K_DP_WIFI7_H
 
+#include "../dp_cmn.h"
 #include "hw.h"
 
+struct ath12k_base;
+struct ath12k_dp;
+
 int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
 				 struct ath12k_ext_irq_grp *irq_grp, int budget);
+struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab);
+void ath12k_wifi7_dp_device_free(struct ath12k_dp *dp);
+
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/pci.c b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
index ba8c19c24ae6..f6dfdcf95025 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/pci.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
@@ -13,6 +13,8 @@
 #include "../mhi.h"
 #include "hw.h"
 #include "../hal.h"
+#include "dp.h"
+#include "core.h"
 
 #define QCN9274_DEVICE_ID		0x1109
 #define WCN7850_DEVICE_ID		0x1107
@@ -163,6 +165,8 @@ static struct ath12k_pci_driver ath12k_wifi7_pci_driver = {
 	.id_table = ath12k_wifi7_pci_id_table,
 	.ops.probe = ath12k_wifi7_pci_probe,
 	.reg_base = &ath12k_wifi7_reg_base,
+	.ops.arch_init = ath12k_wifi7_arch_init,
+	.ops.arch_deinit = ath12k_wifi7_arch_deinit,
 };
 
 int ath12k_wifi7_pci_init(void)
-- 
2.34.1


