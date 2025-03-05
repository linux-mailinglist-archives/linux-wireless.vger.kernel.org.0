Return-Path: <linux-wireless+bounces-19820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE65DA50A7C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 19:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C0147A2535
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AB8253B71;
	Wed,  5 Mar 2025 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CEkb77Az"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C12571A5;
	Wed,  5 Mar 2025 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200968; cv=none; b=fzf8zxnaWOOjAgGrRh77LF8Zck5dINhlxwn477NDnQyP2sqcpjaNdzTL4M0IGjNWxGWqAGmqwR8F5pDpy046FX09QZ3EqT9jeZTAs9uusLBIuUluw9xgDme3qCUijXM9ZY2ljtuOsvDGY6QaoUHSpPvygx/rIFmQRmtII5eHxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200968; c=relaxed/simple;
	bh=6ZxvslQ3xh0RyD2WofBEACYGPmn0F+h4UsO/YMu0EBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQczVmuQ5t8fqAcoOsFXrwq1aF6HRZy8QcmsDjEYBIQLqLYWLAA4yfKTKs+Bf22oV8xGosQ3p1ekcVillAP13B7RHULq7nKz5rj1dsFqNaS1uI5Expfct+MEtbVUyy2D4SMjCpJWGleWBftYVYOzQ73YxQLwy2BTTi5YM/0aewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CEkb77Az; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IUZtG030957;
	Wed, 5 Mar 2025 18:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qssppvRZZ1zQXKnI+F0pxwMtG/H5r6zXXUTCF93iCU4=; b=CEkb77AzwAO+FJ+b
	LyitRrDKDNCBlBy9lxyD6317xas3ivh+qaU+VUeBUYWoM9mhTEi1lxaeqwv9oRq6
	4D2xm18MeK9i50+xZk0kfVMWGM17CgMQ+ZwMEHUZZbC9es+GG2fKZmfSNJRZxsEy
	0sZc13WZJt7K5NCYRsqBquKIvwv4yL2YnFLqYUNi/PgJoMLIgN4gTQFvOiVikWkV
	wXCDcPSAYQh8copIE8tBt4v5BNdouvJCSi2WVyudNmWQ3gtT2uOChH5SKVLCun0W
	kgbzCtms7ydTHnLNTCsWKDOW59l6OVFrNu1vJ/1K83VDU5kLoSZxG9vPV35znWv+
	2VM9gQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 456uy082es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 18:55:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 525IttHO002070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 18:55:56 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Mar 2025 10:55:52 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [PATCH ath-next v9 08/13] wifi: ath12k: add AHB driver support for IPQ5332
Date: Thu, 6 Mar 2025 00:24:56 +0530
Message-ID: <20250305185501.2400888-9-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305185501.2400888-1-quic_rajkbhag@quicinc.com>
References: <20250305185501.2400888-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Pq5pbxM3 c=1 sm=1 tr=0 ts=67c89e3c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=piuMfSQ_hNHvUAxF-GQA:9 a=RVmHIydaz68A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 4xiWFy1lX7Hb3BgDr7jfkxfEcJWV9Q7M
X-Proofpoint-GUID: 4xiWFy1lX7Hb3BgDr7jfkxfEcJWV9Q7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050145

From: Balamurugan S <quic_bselvara@quicinc.com>

Add Initial Ath12k AHB driver support for IPQ5332. IPQ5332 is AHB
based IEEE802.11be 2 GHz 2x2 WiFi device.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c  | 781 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/ahb.h  |  37 ++
 drivers/net/wireless/ath/ath12k/core.h |   3 +
 drivers/net/wireless/ath/ath12k/hal.h  |   1 +
 drivers/net/wireless/ath/ath12k/hw.h   |   1 +
 5 files changed, 823 insertions(+)
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.c
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.h

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
new file mode 100644
index 000000000000..597bc522ed01
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -0,0 +1,781 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include "ahb.h"
+#include "debug.h"
+#include "hif.h"
+
+static const struct of_device_id ath12k_ahb_of_match[] = {
+	{ .compatible = "qcom,ipq5332-wifi",
+	  .data = (void *)ATH12K_HW_IPQ5332_HW10,
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, ath12k_ahb_of_match);
+
+#define ATH12K_IRQ_CE0_OFFSET 4
+
+static const char *irq_name[ATH12K_IRQ_NUM_MAX] = {
+	"misc-pulse1",
+	"misc-latch",
+	"sw-exception",
+	"watchdog",
+	"ce0",
+	"ce1",
+	"ce2",
+	"ce3",
+	"ce4",
+	"ce5",
+	"ce6",
+	"ce7",
+	"ce8",
+	"ce9",
+	"ce10",
+	"ce11",
+	"host2wbm-desc-feed",
+	"host2reo-re-injection",
+	"host2reo-command",
+	"host2rxdma-monitor-ring3",
+	"host2rxdma-monitor-ring2",
+	"host2rxdma-monitor-ring1",
+	"reo2ost-exception",
+	"wbm2host-rx-release",
+	"reo2host-status",
+	"reo2host-destination-ring4",
+	"reo2host-destination-ring3",
+	"reo2host-destination-ring2",
+	"reo2host-destination-ring1",
+	"rxdma2host-monitor-destination-mac3",
+	"rxdma2host-monitor-destination-mac2",
+	"rxdma2host-monitor-destination-mac1",
+	"ppdu-end-interrupts-mac3",
+	"ppdu-end-interrupts-mac2",
+	"ppdu-end-interrupts-mac1",
+	"rxdma2host-monitor-status-ring-mac3",
+	"rxdma2host-monitor-status-ring-mac2",
+	"rxdma2host-monitor-status-ring-mac1",
+	"host2rxdma-host-buf-ring-mac3",
+	"host2rxdma-host-buf-ring-mac2",
+	"host2rxdma-host-buf-ring-mac1",
+	"rxdma2host-destination-ring-mac3",
+	"rxdma2host-destination-ring-mac2",
+	"rxdma2host-destination-ring-mac1",
+	"host2tcl-input-ring4",
+	"host2tcl-input-ring3",
+	"host2tcl-input-ring2",
+	"host2tcl-input-ring1",
+	"wbm2host-tx-completions-ring4",
+	"wbm2host-tx-completions-ring3",
+	"wbm2host-tx-completions-ring2",
+	"wbm2host-tx-completions-ring1",
+	"tcl2host-status-ring",
+};
+
+enum ext_irq_num {
+	host2wbm_desc_feed = 16,
+	host2reo_re_injection,
+	host2reo_command,
+	host2rxdma_monitor_ring3,
+	host2rxdma_monitor_ring2,
+	host2rxdma_monitor_ring1,
+	reo2host_exception,
+	wbm2host_rx_release,
+	reo2host_status,
+	reo2host_destination_ring4,
+	reo2host_destination_ring3,
+	reo2host_destination_ring2,
+	reo2host_destination_ring1,
+	rxdma2host_monitor_destination_mac3,
+	rxdma2host_monitor_destination_mac2,
+	rxdma2host_monitor_destination_mac1,
+	ppdu_end_interrupts_mac3,
+	ppdu_end_interrupts_mac2,
+	ppdu_end_interrupts_mac1,
+	rxdma2host_monitor_status_ring_mac3,
+	rxdma2host_monitor_status_ring_mac2,
+	rxdma2host_monitor_status_ring_mac1,
+	host2rxdma_host_buf_ring_mac3,
+	host2rxdma_host_buf_ring_mac2,
+	host2rxdma_host_buf_ring_mac1,
+	rxdma2host_destination_ring_mac3,
+	rxdma2host_destination_ring_mac2,
+	rxdma2host_destination_ring_mac1,
+	host2tcl_input_ring4,
+	host2tcl_input_ring3,
+	host2tcl_input_ring2,
+	host2tcl_input_ring1,
+	wbm2host_tx_completions_ring4,
+	wbm2host_tx_completions_ring3,
+	wbm2host_tx_completions_ring2,
+	wbm2host_tx_completions_ring1,
+	tcl2host_status_ring,
+};
+
+static u32 ath12k_ahb_read32(struct ath12k_base *ab, u32 offset)
+{
+	if (ab->ce_remap && offset < HAL_SEQ_WCSS_CMEM_OFFSET)
+		return ioread32(ab->mem_ce + offset);
+	return ioread32(ab->mem + offset);
+}
+
+static void ath12k_ahb_write32(struct ath12k_base *ab, u32 offset,
+			       u32 value)
+{
+	if (ab->ce_remap && offset < HAL_SEQ_WCSS_CMEM_OFFSET)
+		iowrite32(value, ab->mem_ce + offset);
+	else
+		iowrite32(value, ab->mem + offset);
+}
+
+static void ath12k_ahb_cancel_workqueue(struct ath12k_base *ab)
+{
+	int i;
+
+	for (i = 0; i < ab->hw_params->ce_count; i++) {
+		struct ath12k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
+
+		if (ath12k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+
+		cancel_work_sync(&ce_pipe->intr_wq);
+	}
+}
+
+static void ath12k_ahb_ext_grp_disable(struct ath12k_ext_irq_grp *irq_grp)
+{
+	int i;
+
+	for (i = 0; i < irq_grp->num_irq; i++)
+		disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+}
+
+static void __ath12k_ahb_ext_irq_disable(struct ath12k_base *ab)
+{
+	int i;
+
+	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
+		struct ath12k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
+
+		ath12k_ahb_ext_grp_disable(irq_grp);
+		if (irq_grp->napi_enabled) {
+			napi_synchronize(&irq_grp->napi);
+			napi_disable(&irq_grp->napi);
+			irq_grp->napi_enabled = false;
+		}
+	}
+}
+
+static void ath12k_ahb_ext_grp_enable(struct ath12k_ext_irq_grp *irq_grp)
+{
+	int i;
+
+	for (i = 0; i < irq_grp->num_irq; i++)
+		enable_irq(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
+}
+
+static void ath12k_ahb_setbit32(struct ath12k_base *ab, u8 bit, u32 offset)
+{
+	u32 val;
+
+	val = ath12k_ahb_read32(ab, offset);
+	ath12k_ahb_write32(ab, offset, val | BIT(bit));
+}
+
+static void ath12k_ahb_clearbit32(struct ath12k_base *ab, u8 bit, u32 offset)
+{
+	u32 val;
+
+	val = ath12k_ahb_read32(ab, offset);
+	ath12k_ahb_write32(ab, offset, val & ~BIT(bit));
+}
+
+static void ath12k_ahb_ce_irq_enable(struct ath12k_base *ab, u16 ce_id)
+{
+	const struct ce_attr *ce_attr;
+	const struct ce_ie_addr *ce_ie_addr = ab->hw_params->ce_ie_addr;
+	u32 ie1_reg_addr, ie2_reg_addr, ie3_reg_addr;
+
+	ie1_reg_addr = ce_ie_addr->ie1_reg_addr;
+	ie2_reg_addr = ce_ie_addr->ie2_reg_addr;
+	ie3_reg_addr = ce_ie_addr->ie3_reg_addr;
+
+	ce_attr = &ab->hw_params->host_ce_config[ce_id];
+	if (ce_attr->src_nentries)
+		ath12k_ahb_setbit32(ab, ce_id, ie1_reg_addr);
+
+	if (ce_attr->dest_nentries) {
+		ath12k_ahb_setbit32(ab, ce_id, ie2_reg_addr);
+		ath12k_ahb_setbit32(ab, ce_id + CE_HOST_IE_3_SHIFT,
+				    ie3_reg_addr);
+	}
+}
+
+static void ath12k_ahb_ce_irq_disable(struct ath12k_base *ab, u16 ce_id)
+{
+	const struct ce_attr *ce_attr;
+	const struct ce_ie_addr *ce_ie_addr = ab->hw_params->ce_ie_addr;
+	u32 ie1_reg_addr, ie2_reg_addr, ie3_reg_addr;
+
+	ie1_reg_addr = ce_ie_addr->ie1_reg_addr;
+	ie2_reg_addr = ce_ie_addr->ie2_reg_addr;
+	ie3_reg_addr = ce_ie_addr->ie3_reg_addr;
+
+	ce_attr = &ab->hw_params->host_ce_config[ce_id];
+	if (ce_attr->src_nentries)
+		ath12k_ahb_clearbit32(ab, ce_id, ie1_reg_addr);
+
+	if (ce_attr->dest_nentries) {
+		ath12k_ahb_clearbit32(ab, ce_id, ie2_reg_addr);
+		ath12k_ahb_clearbit32(ab, ce_id + CE_HOST_IE_3_SHIFT,
+				      ie3_reg_addr);
+	}
+}
+
+static void ath12k_ahb_sync_ce_irqs(struct ath12k_base *ab)
+{
+	int i;
+	int irq_idx;
+
+	for (i = 0; i < ab->hw_params->ce_count; i++) {
+		if (ath12k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+
+		irq_idx = ATH12K_IRQ_CE0_OFFSET + i;
+		synchronize_irq(ab->irq_num[irq_idx]);
+	}
+}
+
+static void ath12k_ahb_sync_ext_irqs(struct ath12k_base *ab)
+{
+	int i, j;
+	int irq_idx;
+
+	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
+		struct ath12k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
+
+		for (j = 0; j < irq_grp->num_irq; j++) {
+			irq_idx = irq_grp->irqs[j];
+			synchronize_irq(ab->irq_num[irq_idx]);
+		}
+	}
+}
+
+static void ath12k_ahb_ce_irqs_enable(struct ath12k_base *ab)
+{
+	int i;
+
+	for (i = 0; i < ab->hw_params->ce_count; i++) {
+		if (ath12k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+		ath12k_ahb_ce_irq_enable(ab, i);
+	}
+}
+
+static void ath12k_ahb_ce_irqs_disable(struct ath12k_base *ab)
+{
+	int i;
+
+	for (i = 0; i < ab->hw_params->ce_count; i++) {
+		if (ath12k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+		ath12k_ahb_ce_irq_disable(ab, i);
+	}
+}
+
+static int ath12k_ahb_start(struct ath12k_base *ab)
+{
+	ath12k_ahb_ce_irqs_enable(ab);
+	ath12k_ce_rx_post_buf(ab);
+
+	return 0;
+}
+
+static void ath12k_ahb_ext_irq_enable(struct ath12k_base *ab)
+{
+	struct ath12k_ext_irq_grp *irq_grp;
+	int i;
+
+	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
+		irq_grp = &ab->ext_irq_grp[i];
+		if (!irq_grp->napi_enabled) {
+			napi_enable(&irq_grp->napi);
+			irq_grp->napi_enabled = true;
+		}
+		ath12k_ahb_ext_grp_enable(irq_grp);
+	}
+}
+
+static void ath12k_ahb_ext_irq_disable(struct ath12k_base *ab)
+{
+	__ath12k_ahb_ext_irq_disable(ab);
+	ath12k_ahb_sync_ext_irqs(ab);
+}
+
+static void ath12k_ahb_stop(struct ath12k_base *ab)
+{
+	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
+		ath12k_ahb_ce_irqs_disable(ab);
+	ath12k_ahb_sync_ce_irqs(ab);
+	ath12k_ahb_cancel_workqueue(ab);
+	del_timer_sync(&ab->rx_replenish_retry);
+	ath12k_ce_cleanup_pipes(ab);
+}
+
+static void ath12k_ahb_init_qmi_ce_config(struct ath12k_base *ab)
+{
+	struct ath12k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
+
+	cfg->tgt_ce_len = ab->hw_params->target_ce_count;
+	cfg->tgt_ce = ab->hw_params->target_ce_config;
+	cfg->svc_to_ce_map_len = ab->hw_params->svc_to_ce_map_len;
+	cfg->svc_to_ce_map = ab->hw_params->svc_to_ce_map;
+	ab->qmi.service_ins_id = ab->hw_params->qmi_service_ins_id;
+}
+
+static void ath12k_ahb_ce_workqueue(struct work_struct *work)
+{
+	struct ath12k_ce_pipe *ce_pipe = from_work(ce_pipe, work, intr_wq);
+
+	ath12k_ce_per_engine_service(ce_pipe->ab, ce_pipe->pipe_num);
+
+	ath12k_ahb_ce_irq_enable(ce_pipe->ab, ce_pipe->pipe_num);
+}
+
+static irqreturn_t ath12k_ahb_ce_interrupt_handler(int irq, void *arg)
+{
+	struct ath12k_ce_pipe *ce_pipe = arg;
+
+	/* last interrupt received for this CE */
+	ce_pipe->timestamp = jiffies;
+
+	ath12k_ahb_ce_irq_disable(ce_pipe->ab, ce_pipe->pipe_num);
+
+	queue_work(system_bh_wq, &ce_pipe->intr_wq);
+
+	return IRQ_HANDLED;
+}
+
+static int ath12k_ahb_ext_grp_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct ath12k_ext_irq_grp *irq_grp = container_of(napi,
+						struct ath12k_ext_irq_grp,
+						napi);
+	struct ath12k_base *ab = irq_grp->ab;
+	int work_done;
+
+	work_done = ath12k_dp_service_srng(ab, irq_grp, budget);
+	if (work_done < budget) {
+		napi_complete_done(napi, work_done);
+		ath12k_ahb_ext_grp_enable(irq_grp);
+	}
+
+	if (work_done > budget)
+		work_done = budget;
+
+	return work_done;
+}
+
+static irqreturn_t ath12k_ahb_ext_interrupt_handler(int irq, void *arg)
+{
+	struct ath12k_ext_irq_grp *irq_grp = arg;
+
+	/* last interrupt received for this group */
+	irq_grp->timestamp = jiffies;
+
+	ath12k_ahb_ext_grp_disable(irq_grp);
+
+	napi_schedule(&irq_grp->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int ath12k_ahb_config_ext_irq(struct ath12k_base *ab)
+{
+	const struct ath12k_hw_ring_mask *ring_mask;
+	struct ath12k_ext_irq_grp *irq_grp;
+	const struct hal_ops *hal_ops;
+	int i, j, irq, irq_idx, ret;
+	u32 num_irq;
+
+	ring_mask = ab->hw_params->ring_mask;
+	hal_ops = ab->hw_params->hal_ops;
+	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
+		irq_grp = &ab->ext_irq_grp[i];
+		num_irq = 0;
+
+		irq_grp->ab = ab;
+		irq_grp->grp_id = i;
+
+		irq_grp->napi_ndev = alloc_netdev_dummy(0);
+		if (!irq_grp->napi_ndev)
+			return -ENOMEM;
+
+		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
+			       ath12k_ahb_ext_grp_napi_poll);
+
+		for (j = 0; j < ATH12K_EXT_IRQ_NUM_MAX; j++) {
+			/* For TX ring, ensure that the ring mask and the
+			 * tcl_to_wbm_rbm_map point to the same ring number.
+			 */
+			if (ring_mask->tx[i] &
+			    BIT(hal_ops->tcl_to_wbm_rbm_map[j].wbm_ring_num)) {
+				irq_grp->irqs[num_irq++] =
+					wbm2host_tx_completions_ring1 - j;
+			}
+
+			if (ring_mask->rx[i] & BIT(j)) {
+				irq_grp->irqs[num_irq++] =
+					reo2host_destination_ring1 - j;
+			}
+
+			if (ring_mask->rx_err[i] & BIT(j))
+				irq_grp->irqs[num_irq++] = reo2host_exception;
+
+			if (ring_mask->rx_wbm_rel[i] & BIT(j))
+				irq_grp->irqs[num_irq++] = wbm2host_rx_release;
+
+			if (ring_mask->reo_status[i] & BIT(j))
+				irq_grp->irqs[num_irq++] = reo2host_status;
+
+			if (ring_mask->rx_mon_dest[i] & BIT(j))
+				irq_grp->irqs[num_irq++] =
+					rxdma2host_monitor_destination_mac1;
+		}
+
+		irq_grp->num_irq = num_irq;
+
+		for (j = 0; j < irq_grp->num_irq; j++) {
+			irq_idx = irq_grp->irqs[j];
+
+			irq = platform_get_irq_byname(ab->pdev,
+						      irq_name[irq_idx]);
+			ab->irq_num[irq_idx] = irq;
+			irq_set_status_flags(irq, IRQ_NOAUTOEN | IRQ_DISABLE_UNLAZY);
+			ret = devm_request_irq(ab->dev, irq,
+					       ath12k_ahb_ext_interrupt_handler,
+					       IRQF_TRIGGER_RISING,
+					       irq_name[irq_idx], irq_grp);
+			if (ret)
+				ath12k_warn(ab, "failed request_irq for %d\n", irq);
+		}
+	}
+
+	return 0;
+}
+
+static int ath12k_ahb_config_irq(struct ath12k_base *ab)
+{
+	int irq, irq_idx, i;
+	int ret;
+
+	/* Configure CE irqs */
+	for (i = 0; i < ab->hw_params->ce_count; i++) {
+		struct ath12k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
+
+		if (ath12k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+
+		irq_idx = ATH12K_IRQ_CE0_OFFSET + i;
+
+		INIT_WORK(&ce_pipe->intr_wq, ath12k_ahb_ce_workqueue);
+		irq = platform_get_irq_byname(ab->pdev, irq_name[irq_idx]);
+		ret = devm_request_irq(ab->dev, irq, ath12k_ahb_ce_interrupt_handler,
+				       IRQF_TRIGGER_RISING, irq_name[irq_idx],
+				       ce_pipe);
+		if (ret)
+			return ret;
+
+		ab->irq_num[irq_idx] = irq;
+	}
+
+	/* Configure external interrupts */
+	ret = ath12k_ahb_config_ext_irq(ab);
+
+	return ret;
+}
+
+static int ath12k_ahb_map_service_to_pipe(struct ath12k_base *ab, u16 service_id,
+					  u8 *ul_pipe, u8 *dl_pipe)
+{
+	const struct service_to_pipe *entry;
+	bool ul_set = false, dl_set = false;
+	u32 pipedir;
+	int i;
+
+	for (i = 0; i < ab->hw_params->svc_to_ce_map_len; i++) {
+		entry = &ab->hw_params->svc_to_ce_map[i];
+
+		if (__le32_to_cpu(entry->service_id) != service_id)
+			continue;
+
+		pipedir = __le32_to_cpu(entry->pipedir);
+		if (pipedir == PIPEDIR_IN || pipedir == PIPEDIR_INOUT) {
+			WARN_ON(dl_set);
+			*dl_pipe = __le32_to_cpu(entry->pipenum);
+			dl_set = true;
+		}
+
+		if (pipedir == PIPEDIR_OUT || pipedir == PIPEDIR_INOUT) {
+			WARN_ON(ul_set);
+			*ul_pipe = __le32_to_cpu(entry->pipenum);
+			ul_set = true;
+		}
+	}
+
+	if (WARN_ON(!ul_set || !dl_set))
+		return -ENOENT;
+
+	return 0;
+}
+
+static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
+	.start = ath12k_ahb_start,
+	.stop = ath12k_ahb_stop,
+	.read32 = ath12k_ahb_read32,
+	.write32 = ath12k_ahb_write32,
+	.irq_enable = ath12k_ahb_ext_irq_enable,
+	.irq_disable = ath12k_ahb_ext_irq_disable,
+	.map_service_to_pipe = ath12k_ahb_map_service_to_pipe,
+};
+
+static int ath12k_ahb_resource_init(struct ath12k_base *ab)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+	struct platform_device *pdev = ab->pdev;
+	struct resource *mem_res;
+	int ret;
+
+	ab->mem = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
+	if (IS_ERR(ab->mem)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(ab->mem), "ioremap error\n");
+		goto out;
+	}
+
+	ab->mem_len = resource_size(mem_res);
+
+	if (ab->hw_params->ce_remap) {
+		const struct ce_remap *ce_remap = ab->hw_params->ce_remap;
+		/* CE register space is moved out of WCSS and the space is not
+		 * contiguous, hence remapping the CE registers to a new space
+		 * for accessing them.
+		 */
+		ab->mem_ce = ioremap(ce_remap->base, ce_remap->size);
+		if (IS_ERR(ab->mem_ce)) {
+			dev_err(&pdev->dev, "ce ioremap error\n");
+			ret = -ENOMEM;
+			goto err_mem_unmap;
+		}
+		ab->ce_remap = true;
+		ab->ce_remap_base_addr = HAL_IPQ5332_CE_WFSS_REG_BASE;
+	}
+
+	ab_ahb->xo_clk = devm_clk_get(ab->dev, "xo");
+	if (IS_ERR(ab_ahb->xo_clk)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(ab_ahb->xo_clk),
+				    "failed to get xo clock\n");
+		goto err_mem_ce_unmap;
+	}
+
+	ret = clk_prepare_enable(ab_ahb->xo_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable gcc_xo_clk: %d\n", ret);
+		goto err_clock_deinit;
+	}
+
+	return 0;
+
+err_clock_deinit:
+	devm_clk_put(ab->dev, ab_ahb->xo_clk);
+
+err_mem_ce_unmap:
+	ab_ahb->xo_clk = NULL;
+	if (ab->hw_params->ce_remap)
+		iounmap(ab->mem_ce);
+
+err_mem_unmap:
+	ab->mem_ce = NULL;
+	devm_iounmap(ab->dev, ab->mem);
+
+out:
+	ab->mem = NULL;
+	return ret;
+}
+
+static void ath12k_ahb_resource_deinit(struct ath12k_base *ab)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+
+	if (ab->mem)
+		devm_iounmap(ab->dev, ab->mem);
+
+	if (ab->mem_ce)
+		iounmap(ab->mem_ce);
+
+	ab->mem = NULL;
+	ab->mem_ce = NULL;
+
+	clk_disable_unprepare(ab_ahb->xo_clk);
+	devm_clk_put(ab->dev, ab_ahb->xo_clk);
+	ab_ahb->xo_clk = NULL;
+}
+
+static int ath12k_ahb_probe(struct platform_device *pdev)
+{
+	struct ath12k_base *ab;
+	const struct ath12k_hif_ops *hif_ops;
+	enum ath12k_hw_rev hw_rev;
+	u32 addr;
+	int ret;
+
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set 32-bit coherent dma\n");
+		return ret;
+	}
+
+	ab = ath12k_core_alloc(&pdev->dev, sizeof(struct ath12k_ahb),
+			       ATH12K_BUS_AHB);
+	if (!ab)
+		return -ENOMEM;
+
+	hw_rev = (enum ath12k_hw_rev)of_device_get_match_data(&pdev->dev);
+	switch (hw_rev) {
+	case ATH12K_HW_IPQ5332_HW10:
+		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		goto err_core_free;
+	}
+
+	ab->hif.ops = hif_ops;
+	ab->pdev = pdev;
+	ab->hw_rev = hw_rev;
+	platform_set_drvdata(pdev, ab);
+
+	/* Set fixed_mem_region to true for platforms that support fixed memory
+	 * reservation from DT. If memory is reserved from DT for FW, ath12k driver
+	 * need not to allocate memory.
+	 */
+	if (!of_property_read_u32(ab->dev->of_node, "memory-region", &addr))
+		set_bit(ATH12K_FLAG_FIXED_MEM_REGION, &ab->dev_flags);
+
+	ret = ath12k_core_pre_init(ab);
+	if (ret)
+		goto err_core_free;
+
+	ret = ath12k_ahb_resource_init(ab);
+	if (ret)
+		goto err_core_free;
+
+	ret = ath12k_hal_srng_init(ab);
+	if (ret)
+		goto err_resource_deinit;
+
+	ret = ath12k_ce_alloc_pipes(ab);
+	if (ret) {
+		ath12k_err(ab, "failed to allocate ce pipes: %d\n", ret);
+		goto err_hal_srng_deinit;
+	}
+
+	ath12k_ahb_init_qmi_ce_config(ab);
+
+	ret = ath12k_ahb_config_irq(ab);
+	if (ret) {
+		ath12k_err(ab, "failed to configure irq: %d\n", ret);
+		goto err_ce_free;
+	}
+
+	ret = ath12k_core_init(ab);
+	if (ret) {
+		ath12k_err(ab, "failed to init core: %d\n", ret);
+		goto err_ce_free;
+	}
+
+	return 0;
+
+err_ce_free:
+	ath12k_ce_free_pipes(ab);
+
+err_hal_srng_deinit:
+	ath12k_hal_srng_deinit(ab);
+
+err_resource_deinit:
+	ath12k_ahb_resource_deinit(ab);
+
+err_core_free:
+	ath12k_core_free(ab);
+	platform_set_drvdata(pdev, NULL);
+
+	return ret;
+}
+
+static void ath12k_ahb_remove_prepare(struct ath12k_base *ab)
+{
+	unsigned long left;
+
+	if (test_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags)) {
+		left = wait_for_completion_timeout(&ab->driver_recovery,
+						   ATH12K_AHB_RECOVERY_TIMEOUT);
+		if (!left)
+			ath12k_warn(ab, "failed to receive recovery response completion\n");
+	}
+
+	set_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags);
+	cancel_work_sync(&ab->restart_work);
+	cancel_work_sync(&ab->qmi.event_work);
+}
+
+static void ath12k_ahb_free_resources(struct ath12k_base *ab)
+{
+	struct platform_device *pdev = ab->pdev;
+
+	ath12k_hal_srng_deinit(ab);
+	ath12k_ce_free_pipes(ab);
+	ath12k_ahb_resource_deinit(ab);
+	ath12k_core_free(ab);
+	platform_set_drvdata(pdev, NULL);
+}
+
+static void ath12k_ahb_remove(struct platform_device *pdev)
+{
+	struct ath12k_base *ab = platform_get_drvdata(pdev);
+
+	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
+		ath12k_qmi_deinit_service(ab);
+		goto qmi_fail;
+	}
+
+	ath12k_ahb_remove_prepare(ab);
+	ath12k_core_deinit(ab);
+
+qmi_fail:
+	ath12k_ahb_free_resources(ab);
+}
+
+static struct platform_driver ath12k_ahb_driver = {
+	.driver         = {
+		.name   = "ath12k_ahb",
+		.of_match_table = ath12k_ahb_of_match,
+	},
+	.probe  = ath12k_ahb_probe,
+	.remove = ath12k_ahb_remove,
+};
+
+int ath12k_ahb_init(void)
+{
+	return platform_driver_register(&ath12k_ahb_driver);
+}
+
+void ath12k_ahb_exit(void)
+{
+	platform_driver_unregister(&ath12k_ahb_driver);
+}
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
new file mode 100644
index 000000000000..64f0696588c0
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef ATH12K_AHB_H
+#define ATH12K_AHB_H
+
+#include <linux/clk.h>
+#include "core.h"
+
+#define ATH12K_AHB_RECOVERY_TIMEOUT (3 * HZ)
+
+#define ATH12K_AHB_SMP2P_SMEM_MSG		GENMASK(15, 0)
+#define ATH12K_AHB_SMP2P_SMEM_SEQ_NO		GENMASK(31, 16)
+#define ATH12K_AHB_SMP2P_SMEM_VALUE_MASK	0xFFFFFFFF
+#define ATH12K_PCI_CE_WAKE_IRQ			2
+#define ATH12K_PCI_IRQ_CE0_OFFSET		3
+
+enum ath12k_ahb_smp2p_msg_id {
+	ATH12K_AHB_POWER_SAVE_ENTER = 1,
+	ATH12K_AHB_POWER_SAVE_EXIT,
+};
+
+struct ath12k_base;
+
+struct ath12k_ahb {
+	struct rproc *tgt_rproc;
+	struct clk *xo_clk;
+};
+
+static inline struct ath12k_ahb *ath12k_ab_to_ahb(struct ath12k_base *ab)
+{
+	return (struct ath12k_ahb *)ab->drv_priv;
+}
+
+#endif
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 398f76a9d2e4..28fa0a9f7ed4 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -162,6 +162,7 @@ enum ath12k_firmware_mode {
 
 #define ATH12K_IRQ_NUM_MAX 57
 #define ATH12K_EXT_IRQ_NUM_MAX	16
+#define ATH12K_MAX_TCL_RING_NUM	3
 
 struct ath12k_ext_irq_grp {
 	struct ath12k_base *ab;
@@ -1293,6 +1294,8 @@ static inline const char *ath12k_bus_str(enum ath12k_bus bus)
 	switch (bus) {
 	case ATH12K_BUS_PCI:
 		return "pci";
+	case ATH12K_BUS_AHB:
+		return "ahb";
 	}
 
 	return "unknown";
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 47ff0b1bfdf4..9f12ed84a653 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -42,6 +42,7 @@ struct ath12k_base;
 #define HAL_SHADOW_REG(x) (HAL_SHADOW_BASE_ADDR + (4 * (x)))
 
 /* WCSS Relative address */
+#define HAL_SEQ_WCSS_CMEM_OFFSET		0x00100000
 #define HAL_SEQ_WCSS_UMAC_OFFSET		0x00a00000
 #define HAL_SEQ_WCSS_UMAC_REO_REG		0x00a38000
 #define HAL_SEQ_WCSS_UMAC_TCL_REG		0x00a44000
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 5123d2f51865..a4332588b117 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -121,6 +121,7 @@ enum ath12k_hw_rate_ofdm {
 
 enum ath12k_bus {
 	ATH12K_BUS_PCI,
+	ATH12K_BUS_AHB,
 };
 
 #define ATH12K_EXT_IRQ_GRP_NUM_MAX 11
-- 
2.34.1


