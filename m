Return-Path: <linux-wireless+bounces-26338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70480B22ECA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67975682D9D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DC32FE574;
	Tue, 12 Aug 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JduwOPWG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6B2FD1D9
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018774; cv=none; b=cDnXY5anoNZsHAGb14xuLWDaBPgqAKBXEH0guJakbvP2IFJaxXdk38Cm1b42vXSgJ5VIpbDI1kX1q3HhktJ3YonunV1F07vLbNU+JDwM5LPYB+TJYxUfq3KidhmcHLdWNqyVY24GLgP2FaRNZUNgb14hgHi4po33UxOJgDTL9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018774; c=relaxed/simple;
	bh=FPAD8JgNgEb7dy0EDOLYQmn7hUu2WURgAvPexPIf2KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=g2B2rvouLX5cuIKn7LbbaqvvQ5XU9S7JaxbIrNoq3Z4/MOcvpYN8ty5X6jobyBYRY9g0LywZn8B546YJ33gT67MxkVA2L+/+1Z7NL9nePEJ9Qv5MpQE0oPyubmlx640+Tm3V2vqBEu9cp03Wcf9gGVp5cn0svn/0rhQu4MZ2Tys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JduwOPWG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvh81021060;
	Tue, 12 Aug 2025 17:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pUxwE1f2l6EC7xo8LZfnYQl0cQpeW/Tj1aSh9rtyLq0=; b=JduwOPWG2zfsNJUt
	LFYkZ7NGLvDuILcpGyog2oPZtPE3Shpa3+Wr9HsOBW/PDkVxmWJSE6IftUWMrYUU
	ccN9h3ArFm74THYshZT7iTFZ4q/4H35gUtclunmz7y0aa0/dVF+w+12eNW6HGNN+
	qCbsgQ3+QUkJ3JRLwFAaTJXuP1T5bzBycN7VtuxdMLrtaTiz++iMByxEhVs+9z4+
	UBITzL0y4P64wqxUK7T9D+i2Z6xe/wq2dL/dodcYwA0ttikTz7OwHiTrKi9n0r+T
	Qv0yfEhcaMn7QYT3m51RjDzMlDRwrpLz2Ew87x/09ziVnTXruqkk0ze8aISIHp1n
	72RQhg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6mtvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:47 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CHCllg010588
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:47 GMT
Received: from hu-kiranv-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 10:12:46 -0700
From: Kiran Venkatappa <quic_kiranv@quicinc.com>
Date: Tue, 12 Aug 2025 22:39:36 +0530
Subject: [PATCH ath12k-ng 10/13] wifi: ath12k: Modularize driver into
 common and Wi-Fi 7 specific components
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-ath12k-mod-v1-10-8c9b0eb9335d@quicinc.com>
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
In-Reply-To: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfXwe6svKm/qAuU
 keqnS3tJeGBe25GTc/O5aguxCXbmC6WonLi+U3KP7m/fQbxCJIN+cgoRNQFCsHMbpwpZ3PiBFVK
 Jl+8ksPLnmKLafC+ftSTh2Ta8U8PdzsyD200PfubiatDjk9JGQ7XSIW/EHBJ2WO3pC9A1gmH4+9
 gXVJX9x+QmRoMHnfjy/Gplw+0RHbDrNnegNvbxGZk7NPwGQgYIqDxZxypzu99ewHjP+yp3erzkj
 liuR5XILEgb7vmhF5OMw4xgvqV/sSwOJ/XvCxgAPNK6FTgV6WsmARJsvHP/tLqPr2/+KClIwPB9
 DMXyPEaLH6BkujqqaYzk1kghqaqKEiyFKOc2AxsCrGDS3hAQ04+VioL8b8MPWk8nVZvPIYnr/56
 g0gXP1fL
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689b760f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=R1TGHQWeIs1UwQfBVLAA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: s3sPujlpkeJj81nQ-4q72uccefekSyRM
X-Proofpoint-ORIG-GUID: s3sPujlpkeJj81nQ-4q72uccefekSyRM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

Split the ath12k driver into two kernel modules:

 - ath12k.ko for shared logic across multiple targets
 - ath12k_wifi7.ko for Wi-Fi 7 specific configuration and routines

The common module (ath12k.ko) must be loaded prior to any device-specific
module, as the latter depends on exported symbols from the former.

As part of this restructuring, Wi-Fi 7 specific files are moved into a
dedicated `wifi7/` directory and built as a separate module. Common
symbols are exported accordingly, with further adjustments planned
in upcoming patches to support architecture-dependent separation.

This modularization improves maintainability and scalability by enabling
clean separation of hardware-specific logic from the shared driver core.

                                          +-----------------+
                                          |                 |
                                          |   ath12k.ko     |
                                          |    (common)     |
        +---------------+                 |                 |
        |               |                 +-----------------+
        |   ath12k.ko   | ===========>
        |               |                 +------------------+
        +---------------+                 |                  |
                                          | ath12k_wifi7.ko  |
                                          | (wifi7 family)   |
                                          |                  |
                                          +------------------+

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kiran Venkatappa <quic_kiranv@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile                 | 11 ++++-------
 drivers/net/wireless/ath/ath12k/ahb.c                    |  2 ++
 drivers/net/wireless/ath/ath12k/core.c                   |  5 +++++
 drivers/net/wireless/ath/ath12k/debug.c                  |  4 ++++
 drivers/net/wireless/ath/ath12k/dp_rx.c                  |  3 +++
 drivers/net/wireless/ath/ath12k/hal.c                    |  4 ++++
 drivers/net/wireless/ath/ath12k/htc.c                    |  2 ++
 drivers/net/wireless/ath/ath12k/pci.c                    |  3 +++
 drivers/net/wireless/ath/ath12k/peer.c                   |  2 ++
 drivers/net/wireless/ath/ath12k/wifi7/Makefile           | 10 ++++++++++
 .../net/wireless/ath/ath12k/{ahb_wifi7.c => wifi7/ahb.c} |  8 ++++----
 .../net/wireless/ath/ath12k/{ahb_wifi7.h => wifi7/ahb.h} |  0
 .../net/wireless/ath/ath12k/{ce_wifi7.c => wifi7/ce.c}   |  6 +++---
 .../net/wireless/ath/ath12k/{ce_wifi7.h => wifi7/ce.h}   |  0
 .../wireless/ath/ath12k/{core_wifi7.c => wifi7/core.c}   |  6 +++---
 .../net/wireless/ath/ath12k/{hw_wifi7.c => wifi7/hw.c}   | 16 ++++++++--------
 .../net/wireless/ath/ath12k/{hw_wifi7.h => wifi7/hw.h}   |  0
 .../net/wireless/ath/ath12k/{mhi_wifi7.c => wifi7/mhi.c} |  2 +-
 .../net/wireless/ath/ath12k/{mhi_wifi7.h => wifi7/mhi.h} |  0
 .../net/wireless/ath/ath12k/{pci_wifi7.c => wifi7/pci.c} | 10 +++++-----
 .../net/wireless/ath/ath12k/{pci_wifi7.h => wifi7/pci.h} |  0
 .../net/wireless/ath/ath12k/{wmi_wifi7.c => wifi7/wmi.c} |  4 ++--
 .../net/wireless/ath/ath12k/{wmi_wifi7.h => wifi7/wmi.h} |  0
 23 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 9c7a32930ed60eafc36fa65aa0ac001d9237eaf8..8dd77729f52f5143746a6fa568d200b68f4715d6 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -1,12 +1,10 @@
 # SPDX-License-Identifier: BSD-3-Clause-Clear
 obj-$(CONFIG_ATH12K) += ath12k.o
 ath12k-y += core.o \
-	    core_wifi7.o \
 	    hal.o \
 	    hal_tx.o \
 	    hal_rx.o \
 	    wmi.o \
-	    wmi_wifi7.o \
 	    mac.o \
 	    reg.o \
 	    htc.o \
@@ -16,19 +14,18 @@ ath12k-y += core.o \
 	    dp_rx.o \
 	    debug.o \
 	    ce.o \
-	    ce_wifi7.o \
 	    peer.o \
 	    dbring.o \
-	    hw_wifi7.o \
 	    mhi.o \
-	    mhi_wifi7.o \
 	    pci.o \
-	    pci_wifi7.o \
 	    dp_mon.o \
 	    fw.o \
 	    p2p.o
 
-ath12k-$(CONFIG_ATH12K_AHB) += ahb.o ahb_wifi7.o
+ath12k-$(CONFIG_ATH12K_AHB) += ahb.o
+
+obj-$(CONFIG_ATH12K) += wifi7/
+
 ath12k-$(CONFIG_ATH12K_DEBUGFS) += debugfs.o debugfs_htt_stats.o debugfs_sta.o
 ath12k-$(CONFIG_ACPI) += acpi.o
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index fc986e669bdea85cdf3dcc3d60c1f2cc9216d3e0..41ef5170556e9255337b26ec3565ab25f50adc65 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -1183,6 +1183,7 @@ int ath12k_ahb_register_driver(const enum ath12k_device_family device_id,
 
 	return platform_driver_register(ahb_driver);
 }
+EXPORT_SYMBOL(ath12k_ahb_register_driver);
 
 void ath12k_ahb_unregister_driver(const enum ath12k_device_family device_id)
 {
@@ -1198,3 +1199,4 @@ void ath12k_ahb_unregister_driver(const enum ath12k_device_family device_id)
 	platform_driver_unregister(ahb_driver);
 	ath12k_ahb_family_drivers[device_id] = NULL;
 }
+EXPORT_SYMBOL(ath12k_ahb_unregister_driver);
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 8b6fb6a1593a322ceee86ecbd23c87ab9b72394b..346687d1598238caadc7f9188b485189f94640de 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -632,6 +632,7 @@ u32 ath12k_core_get_max_peers_per_radio(struct ath12k_base *ab)
 {
 	return ath12k_core_get_max_station_per_radio(ab) + TARGET_NUM_VDEVS(ab);
 }
+EXPORT_SYMBOL(ath12k_core_get_max_peers_per_radio);
 
 struct reserved_mem *ath12k_core_get_reserved_mem(struct ath12k_base *ab,
 						  int index)
@@ -1740,6 +1741,7 @@ enum ath12k_qmi_mem_mode ath12k_core_get_memory_mode(struct ath12k_base *ab)
 
 	return ATH12K_QMI_MEMORY_MODE_DEFAULT;
 }
+EXPORT_SYMBOL(ath12k_core_get_memory_mode);
 
 int ath12k_core_pre_init(struct ath12k_base *ab)
 {
@@ -2272,3 +2274,6 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	kfree(ab);
 	return NULL;
 }
+
+MODULE_DESCRIPTION("Driver support for Qualcomm Technologies WLAN devices");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath12k/debug.c b/drivers/net/wireless/ath/ath12k/debug.c
index 5ce100cd9a9d16f7fcc2dc0a5522b341ebbff8a3..9910c60f30ced17370cbe47e4cedc9a41f62d196 100644
--- a/drivers/net/wireless/ath/ath12k/debug.c
+++ b/drivers/net/wireless/ath/ath12k/debug.c
@@ -21,6 +21,7 @@ void ath12k_info(struct ath12k_base *ab, const char *fmt, ...)
 	/* TODO: Trace the log */
 	va_end(args);
 }
+EXPORT_SYMBOL(ath12k_info);
 
 void ath12k_err(struct ath12k_base *ab, const char *fmt, ...)
 {
@@ -35,6 +36,7 @@ void ath12k_err(struct ath12k_base *ab, const char *fmt, ...)
 	/* TODO: Trace the log */
 	va_end(args);
 }
+EXPORT_SYMBOL(ath12k_err);
 
 void __ath12k_warn(struct device *dev, const char *fmt, ...)
 {
@@ -49,6 +51,7 @@ void __ath12k_warn(struct device *dev, const char *fmt, ...)
 	/* TODO: Trace the log */
 	va_end(args);
 }
+EXPORT_SYMBOL(__ath12k_warn);
 
 #ifdef CONFIG_ATH12K_DEBUG
 
@@ -72,6 +75,7 @@ void __ath12k_dbg(struct ath12k_base *ab, enum ath12k_debug_mask mask,
 
 	va_end(args);
 }
+EXPORT_SYMBOL(__ath12k_dbg);
 
 void ath12k_dbg_dump(struct ath12k_base *ab,
 		     enum ath12k_debug_mask mask,
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 8ab91273592c826cdd3c39fb9157dc853b2722e5..1b1ac82871f4152e86e285c7f0002f33ee1dac58 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1901,6 +1901,7 @@ void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
 
 	dev_kfree_skb_any(skb);
 }
+EXPORT_SYMBOL(ath12k_dp_htt_htc_t2h_msg_handler);
 
 static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
 				      struct sk_buff_head *msdu_list,
@@ -4383,6 +4384,7 @@ int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
 
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_dp_rxdma_ring_sel_config_qcn9274);
 
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 {
@@ -4425,6 +4427,7 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_dp_rxdma_ring_sel_config_wcn7850);
 
 int ath12k_dp_rx_htt_setup(struct ath12k_base *ab)
 {
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 6406fcf5d69fd67dd3d5e0e25bb7a1dd860085ac..022eea9515efd9f38ff27b5b9becdf7e451b310f 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -746,6 +746,7 @@ const struct hal_rx_ops hal_rx_qcn9274_ops = {
 	.rx_desc_get_desc_size = ath12k_hw_qcn9274_get_rx_desc_size,
 	.rx_desc_get_msdu_src_link_id = ath12k_hw_qcn9274_rx_desc_get_msdu_src_link,
 };
+EXPORT_SYMBOL(hal_rx_qcn9274_ops);
 
 static bool ath12k_hw_qcn9274_compact_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
 {
@@ -1093,6 +1094,7 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rxdma_ring_wmask_rx_msdu_end = ath12k_hal_qcn9274_rx_msdu_end_wmask_get,
 	.get_hal_rx_compact_ops = ath12k_hal_qcn9274_get_hal_rx_compact_ops,
 };
+EXPORT_SYMBOL(hal_qcn9274_ops);
 
 static bool ath12k_hw_wcn7850_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
 {
@@ -1552,6 +1554,7 @@ const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.rx_desc_get_desc_size = ath12k_hw_wcn7850_get_rx_desc_size,
 	.rx_desc_get_msdu_src_link_id = ath12k_hw_wcn7850_rx_desc_get_msdu_src_link,
 };
+EXPORT_SYMBOL(hal_rx_wcn7850_ops);
 
 const struct hal_ops hal_wcn7850_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
@@ -1560,6 +1563,7 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rxdma_ring_wmask_rx_msdu_end = NULL,
 	.get_hal_rx_compact_ops = NULL,
 };
+EXPORT_SYMBOL(hal_wcn7850_ops);
 
 static int ath12k_hal_alloc_cont_rdp(struct ath12k_base *ab)
 {
diff --git a/drivers/net/wireless/ath/ath12k/htc.c b/drivers/net/wireless/ath/ath12k/htc.c
index d13616bf07f43da4711c6e37628f978d7292f3fe..fe8218a56125b22f585ee8badab976173c4219ce 100644
--- a/drivers/net/wireless/ath/ath12k/htc.c
+++ b/drivers/net/wireless/ath/ath12k/htc.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -376,6 +377,7 @@ void ath12k_htc_rx_completion_handler(struct ath12k_base *ab,
 out:
 	kfree_skb(skb);
 }
+EXPORT_SYMBOL(ath12k_htc_rx_completion_handler);
 
 static void ath12k_htc_control_rx_complete(struct ath12k_base *ab,
 					   struct sk_buff *skb)
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 93e2189ec68704598ce401ed4fe4f5981fc3cece..fbe6359ec74cf121d2d08d94297585eaa423d5ad 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1175,6 +1175,7 @@ u32 ath12k_pci_read32(struct ath12k_base *ab, u32 offset)
 		ab_pci->pci_ops->release(ab);
 	return val;
 }
+EXPORT_SYMBOL(ath12k_pci_read32);
 
 void ath12k_pci_write32(struct ath12k_base *ab, u32 offset, u32 value)
 {
@@ -1795,6 +1796,7 @@ int ath12k_pci_register_driver(const enum ath12k_device_family device_id,
 
 	return pci_register_driver(pci_driver);
 }
+EXPORT_SYMBOL(ath12k_pci_register_driver);
 
 void ath12k_pci_unregister_driver(const enum ath12k_device_family device_id)
 {
@@ -1805,3 +1807,4 @@ void ath12k_pci_unregister_driver(const enum ath12k_device_family device_id)
 	pci_unregister_driver(&ath12k_pci_family_drivers[device_id]->driver);
 	ath12k_pci_family_drivers[device_id] = NULL;
 }
+EXPORT_SYMBOL(ath12k_pci_unregister_driver);
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index f1ae9e5b5af7208e9a547b5c191b0dd3b582b295..af95324f270868c81dd7fc32830ac31ae6cc8056 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -23,6 +23,7 @@ struct ath12k_ml_peer *ath12k_peer_ml_find(struct ath12k_hw *ah, const u8 *addr)
 
 	return NULL;
 }
+EXPORT_SYMBOL(ath12k_peer_ml_find);
 
 struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
 				     const u8 *addr)
@@ -78,6 +79,7 @@ struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
 
 	return NULL;
 }
+EXPORT_SYMBOL(ath12k_peer_find_by_addr);
 
 static struct ath12k_peer *ath12k_peer_find_by_ml_id(struct ath12k_base *ab,
 						     int ml_peer_id)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/Makefile b/drivers/net/wireless/ath/ath12k/wifi7/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..872ca620a5c5031bdf39817f9833faf2d7ce629d
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: BSD-3-Clause-Clear
+obj-$(CONFIG_ATH12K) += ath12k_wifi7.o
+ath12k_wifi7-y += core.o \
+	          pci.o \
+	          wmi.o \
+	          mhi.o \
+	          ce.o \
+	          hw.o
+
+ath12k_wifi7-$(CONFIG_ATH12K_AHB) += ahb.o
diff --git a/drivers/net/wireless/ath/ath12k/ahb_wifi7.c b/drivers/net/wireless/ath/ath12k/wifi7/ahb.c
similarity index 95%
rename from drivers/net/wireless/ath/ath12k/ahb_wifi7.c
rename to drivers/net/wireless/ath/ath12k/wifi7/ahb.c
index ff4f041bafbc452ec9c70c3d9f1ce648b43a26c7..803e13207bc067889fb4c36fff109f78a0ed66bb 100644
--- a/drivers/net/wireless/ath/ath12k/ahb_wifi7.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/ahb.c
@@ -7,11 +7,11 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include "../ahb.h"
 #include "ahb.h"
-#include "ahb_wifi7.h"
-#include "debug.h"
-#include "hif.h"
-#include "hw_wifi7.h"
+#include "../debug.h"
+#include "../hif.h"
+#include "hw.h"
 
 static const struct of_device_id ath12k_wifi7_ahb_of_match[] = {
 	{ .compatible = "qcom,ipq5332-wifi",
diff --git a/drivers/net/wireless/ath/ath12k/ahb_wifi7.h b/drivers/net/wireless/ath/ath12k/wifi7/ahb.h
similarity index 100%
rename from drivers/net/wireless/ath/ath12k/ahb_wifi7.h
rename to drivers/net/wireless/ath/ath12k/wifi7/ahb.h
diff --git a/drivers/net/wireless/ath/ath12k/ce_wifi7.c b/drivers/net/wireless/ath/ath12k/wifi7/ce.c
similarity index 99%
rename from drivers/net/wireless/ath/ath12k/ce_wifi7.c
rename to drivers/net/wireless/ath/ath12k/wifi7/ce.c
index cf27259d15a0e85c30268c12f935ad3b7985a22f..b4bd1136c25650f559d83242543edf571969059c 100644
--- a/drivers/net/wireless/ath/ath12k/ce_wifi7.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/ce.c
@@ -8,10 +8,10 @@
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
 
-#include "core.h"
+#include "../core.h"
+#include "../ce.h"
 #include "ce.h"
-#include "ce_wifi7.h"
-#include "dp_rx.h"
+#include "../dp_rx.h"
 
 /* Copy Engine (CE) configs for QCN9274 */
 /* Target firmware's Copy Engine configuration. */
diff --git a/drivers/net/wireless/ath/ath12k/ce_wifi7.h b/drivers/net/wireless/ath/ath12k/wifi7/ce.h
similarity index 100%
rename from drivers/net/wireless/ath/ath12k/ce_wifi7.h
rename to drivers/net/wireless/ath/ath12k/wifi7/ce.h
diff --git a/drivers/net/wireless/ath/ath12k/core_wifi7.c b/drivers/net/wireless/ath/ath12k/wifi7/core.c
similarity index 95%
rename from drivers/net/wireless/ath/ath12k/core_wifi7.c
rename to drivers/net/wireless/ath/ath12k/wifi7/core.c
index 85ea8904672cbca03a77e8e9a70c5b397b5e08e2..eb882e56e5ec2865a910d8936cb892f71541d2e9 100644
--- a/drivers/net/wireless/ath/ath12k/core_wifi7.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/core.c
@@ -5,10 +5,10 @@
  */
 
 #include <linux/module.h>
-#include "ahb.h"
+#include "../ahb.h"
+#include "../pci.h"
 #include "pci.h"
-#include "pci_wifi7.h"
-#include "ahb_wifi7.h"
+#include "ahb.h"
 
 static int ahb_err, pci_err;
 
diff --git a/drivers/net/wireless/ath/ath12k/hw_wifi7.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
similarity index 99%
rename from drivers/net/wireless/ath/ath12k/hw_wifi7.c
rename to drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 5f5d3c57b288c1ce9023a14e40cd2f12c9adc13f..93f558847baed6e318f64191cb34f84d7f7586eb 100644
--- a/drivers/net/wireless/ath/ath12k/hw_wifi7.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -8,17 +8,17 @@
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
 
-#include "debug.h"
-#include "core.h"
+#include "../debug.h"
+#include "../core.h"
+#include "../ce.h"
 #include "ce.h"
-#include "ce_wifi7.h"
+#include "../hw.h"
 #include "hw.h"
-#include "hw_wifi7.h"
+#include "../mhi.h"
 #include "mhi.h"
-#include "dp_rx.h"
-#include "peer.h"
-#include "wmi_wifi7.h"
-#include "mhi_wifi7.h"
+#include "../dp_rx.h"
+#include "../peer.h"
+#include "wmi.h"
 
 static const guid_t wcn7850_uuid = GUID_INIT(0xf634f534, 0x6147, 0x11ec,
 					     0x90, 0xd6, 0x02, 0x42,
diff --git a/drivers/net/wireless/ath/ath12k/hw_wifi7.h b/drivers/net/wireless/ath/ath12k/wifi7/hw.h
similarity index 100%
rename from drivers/net/wireless/ath/ath12k/hw_wifi7.h
rename to drivers/net/wireless/ath/ath12k/wifi7/hw.h
diff --git a/drivers/net/wireless/ath/ath12k/mhi_wifi7.c b/drivers/net/wireless/ath/ath12k/wifi7/mhi.c
similarity index 99%
rename from drivers/net/wireless/ath/ath12k/mhi_wifi7.c
rename to drivers/net/wireless/ath/ath12k/wifi7/mhi.c
index be74df152f6f88c1c723459a1cdea21f45b0d15b..74d5f096453118a864ec254150b417bdba5a1d64 100644
--- a/drivers/net/wireless/ath/ath12k/mhi_wifi7.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/mhi.c
@@ -4,8 +4,8 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include "../mhi.h"
 #include "mhi.h"
-#include "mhi_wifi7.h"
 
 static const struct mhi_channel_config ath12k_mhi_channels_qcn9274[] = {
 	{
diff --git a/drivers/net/wireless/ath/ath12k/mhi_wifi7.h b/drivers/net/wireless/ath/ath12k/wifi7/mhi.h
similarity index 100%
rename from drivers/net/wireless/ath/ath12k/mhi_wifi7.h
rename to drivers/net/wireless/ath/ath12k/wifi7/mhi.h
diff --git a/drivers/net/wireless/ath/ath12k/pci_wifi7.c b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
similarity index 97%
rename from drivers/net/wireless/ath/ath12k/pci_wifi7.c
rename to drivers/net/wireless/ath/ath12k/wifi7/pci.c
index a680cd9a04e33af1340393429773aea497461412..01a0b42f0e808a7aab656b88816f2f93a8d4da5e 100644
--- a/drivers/net/wireless/ath/ath12k/pci_wifi7.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
@@ -6,12 +6,12 @@
 
 #include <linux/pci.h>
 
+#include "../pci.h"
 #include "pci.h"
-#include "pci_wifi7.h"
-#include "core.h"
-#include "hif.h"
-#include "mhi.h"
-#include "hw_wifi7.h"
+#include "../core.h"
+#include "../hif.h"
+#include "../mhi.h"
+#include "hw.h"
 
 #define QCN9274_DEVICE_ID		0x1109
 #define WCN7850_DEVICE_ID		0x1107
diff --git a/drivers/net/wireless/ath/ath12k/pci_wifi7.h b/drivers/net/wireless/ath/ath12k/wifi7/pci.h
similarity index 100%
rename from drivers/net/wireless/ath/ath12k/pci_wifi7.h
rename to drivers/net/wireless/ath/ath12k/wifi7/pci.h
diff --git a/drivers/net/wireless/ath/ath12k/wmi_wifi7.c b/drivers/net/wireless/ath/ath12k/wifi7/wmi.c
similarity index 99%
rename from drivers/net/wireless/ath/ath12k/wmi_wifi7.c
rename to drivers/net/wireless/ath/ath12k/wifi7/wmi.c
index f27fa56210e8332ca3c309eca9184f6cbe560c91..652c353f9fc586ae05fa276ebbb99b9a65a5a7c1 100644
--- a/drivers/net/wireless/ath/ath12k/wmi_wifi7.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/wmi.c
@@ -4,8 +4,8 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
-#include "core.h"
-#include "wmi_wifi7.h"
+#include "../core.h"
+#include "wmi.h"
 
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config)
diff --git a/drivers/net/wireless/ath/ath12k/wmi_wifi7.h b/drivers/net/wireless/ath/ath12k/wifi7/wmi.h
similarity index 100%
rename from drivers/net/wireless/ath/ath12k/wmi_wifi7.h
rename to drivers/net/wireless/ath/ath12k/wifi7/wmi.h

-- 
2.34.1


