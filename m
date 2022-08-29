Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532B15A4C8F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 14:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiH2MzH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 08:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiH2Myi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 08:54:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D4F21E21;
        Mon, 29 Aug 2022 05:44:06 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TBR6nP023774;
        Mon, 29 Aug 2022 12:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=wYL/xB8Y+hmtliFuhb+6xNK+Ch1VSXZDB6mTfI7uoeg=;
 b=eQD9MVyWzn/Fp0JiN06ny0ySNc0hq/omhJ0fP/UXSH1KgI4deIiHVsxSQwzlJY1yQyyh
 qRLWGNN98++YsozIH6NvHNopCvkZFhH9M6ekfWJvhuhnplb44EMV4/haYaiYr9vXqNiP
 acglbopA9Xb6k/AfK1NL2r4KJ2Ubvee7aEUFTu2SFVTmKHOs6KXyqTr5k2wV+exKRwJn
 ggfziZcI8Wp0t9UiHQLgAIfbCYhfWd3PURyUKN18oszGz1+/lWOZXIReWJdAiUgo/e+7
 QqpHdQcIbZ72y4lpcMZ5Ib6jrM9PoULTsaXPOUUNVbT6vk7qcb/eR41HKpfwPyUrb4a0 fQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j8uj5ra2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 12:43:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27TChmua030904
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 12:43:49 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 29 Aug 2022 05:43:46 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 2/2] ath11k: Add WoW support for WCN6750
Date:   Mon, 29 Aug 2022 18:13:23 +0530
Message-ID: <20220829124323.26874-3-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829124323.26874-1-quic_mpubbise@quicinc.com>
References: <20220829124323.26874-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Rb3AeXnBz0azJHzNOqxcmzmNHG9IM1Sc
X-Proofpoint-ORIG-GUID: Rb3AeXnBz0azJHzNOqxcmzmNHG9IM1Sc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for WoW on WCN6750 chipset.

Unlike other chips where WoW exit happens after sending WoW wakeup
WMI command, exit from WoW suspend in the case of WCN6750 happens
upon sending a WoW exit SMP2P (Shared memory point to point) message
to the firmware.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 123 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/ahb.h  |  16 ++++
 drivers/net/wireless/ath/ath11k/core.c |   7 ++
 drivers/net/wireless/ath/ath11k/hw.h   |   1 +
 drivers/net/wireless/ath/ath11k/pcic.c |  32 +++++++
 drivers/net/wireless/ath/ath11k/pcic.h |   4 +
 drivers/net/wireless/ath/ath11k/wow.c  |   8 ++
 7 files changed, 190 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index c47414710138..3bb65fa9128c 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -16,6 +16,8 @@
 #include "hif.h"
 #include <linux/remoteproc.h>
 #include "pcic.h"
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/smem_state.h>
 
 static const struct of_device_id ath11k_ahb_of_match[] = {
 	/* TODO: Should we change the compatible string to something similar
@@ -685,6 +687,84 @@ static int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id
 	return 0;
 }
 
+static int ath11k_ahb_hif_suspend(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	u32 wake_irq;
+	u32 value = 0;
+	int ret;
+
+	if (!device_may_wakeup(ab->dev))
+		return -EPERM;
+
+	wake_irq = ab->irq_num[ATH11K_PCI_IRQ_CE0_OFFSET + ATH11K_PCI_CE_WAKE_IRQ];
+
+	ret = enable_irq_wake(wake_irq);
+	if (ret) {
+		ath11k_err(ab, "failed to enable wakeup irq :%d\n", ret);
+		return ret;
+	}
+
+	value = u32_encode_bits(ab_ahb->smp2p_info.seq_no++,
+				ATH11K_AHB_SMP2P_SMEM_SEQ_NO);
+	value |= u32_encode_bits(ATH11K_AHB_POWER_SAVE_ENTER,
+				 ATH11K_AHB_SMP2P_SMEM_MSG);
+
+	ret = qcom_smem_state_update_bits(ab_ahb->smp2p_info.smem_state,
+					  ATH11K_AHB_SMP2P_SMEM_VALUE_MASK, value);
+	if (ret) {
+		ath11k_err(ab, "failed to send smp2p power save enter cmd :%d\n", ret);
+		return ret;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_AHB, "ahb device suspended\n");
+
+	return ret;
+}
+
+static int ath11k_ahb_hif_resume(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	u32 wake_irq;
+	u32 value = 0;
+	int ret;
+
+	if (!device_may_wakeup(ab->dev))
+		return -EPERM;
+
+	wake_irq = ab->irq_num[ATH11K_PCI_IRQ_CE0_OFFSET + ATH11K_PCI_CE_WAKE_IRQ];
+
+	ret = disable_irq_wake(wake_irq);
+	if (ret) {
+		ath11k_err(ab, "failed to disable wakeup irq: %d\n", ret);
+		return ret;
+	}
+
+	reinit_completion(&ab->wow.wakeup_completed);
+
+	value = u32_encode_bits(ab_ahb->smp2p_info.seq_no++,
+				ATH11K_AHB_SMP2P_SMEM_SEQ_NO);
+	value |= u32_encode_bits(ATH11K_AHB_POWER_SAVE_EXIT,
+				 ATH11K_AHB_SMP2P_SMEM_MSG);
+
+	ret = qcom_smem_state_update_bits(ab_ahb->smp2p_info.smem_state,
+					  ATH11K_AHB_SMP2P_SMEM_VALUE_MASK, value);
+	if (ret) {
+		ath11k_err(ab, "failed to send smp2p power save enter cmd :%d\n", ret);
+		return ret;
+	}
+
+	ret = wait_for_completion_timeout(&ab->wow.wakeup_completed, 3 * HZ);
+	if (ret == 0) {
+		ath11k_warn(ab, "timed out while waiting for wow wakeup completion\n");
+		return -ETIMEDOUT;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_AHB, "ahb device resumed\n");
+
+	return 0;
+}
+
 static const struct ath11k_hif_ops ath11k_ahb_hif_ops_ipq8074 = {
 	.start = ath11k_ahb_start,
 	.stop = ath11k_ahb_stop,
@@ -709,6 +789,10 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops_wcn6750 = {
 	.map_service_to_pipe = ath11k_pcic_map_service_to_pipe,
 	.power_down = ath11k_ahb_power_down,
 	.power_up = ath11k_ahb_power_up,
+	.suspend = ath11k_ahb_hif_suspend,
+	.resume = ath11k_ahb_hif_resume,
+	.ce_irq_enable = ath11k_pci_enable_ce_irqs_except_wake_irq,
+	.ce_irq_disable = ath11k_pci_disable_ce_irqs_except_wake_irq,
 };
 
 static int ath11k_core_get_rproc(struct ath11k_base *ab)
@@ -783,6 +867,35 @@ static int ath11k_ahb_setup_msi_resources(struct ath11k_base *ab)
 	return 0;
 }
 
+static int ath11k_ahb_setup_smp2p_handle(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+
+	if (!ab->hw_params.smp2p_wow_exit)
+		return 0;
+
+	ab_ahb->smp2p_info.smem_state =
+		qcom_smem_state_get(ab->dev, "wlan-smp2p-out",
+				    &ab_ahb->smp2p_info.smem_bit);
+	if (IS_ERR(ab_ahb->smp2p_info.smem_state)) {
+		ath11k_err(ab, "failed to fetch smem state: %ld\n",
+			   PTR_ERR(ab_ahb->smp2p_info.smem_state));
+		return PTR_ERR(ab_ahb->smp2p_info.smem_state);
+	}
+
+	return 0;
+}
+
+static void ath11k_ahb_release_smp2p_handle(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+
+	if (!ab->hw_params.smp2p_wow_exit)
+		return;
+
+	qcom_smem_state_put(ab_ahb->smp2p_info.smem_state);
+}
+
 static int ath11k_ahb_setup_resources(struct ath11k_base *ab)
 {
 	struct platform_device *pdev = ab->pdev;
@@ -1038,10 +1151,14 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_core_free;
 
-	ret = ath11k_hal_srng_init(ab);
+	ret = ath11k_ahb_setup_smp2p_handle(ab);
 	if (ret)
 		goto err_fw_deinit;
 
+	ret = ath11k_hal_srng_init(ab);
+	if (ret)
+		goto err_release_smp2p_handle;
+
 	ret = ath11k_ce_alloc_pipes(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to allocate ce pipes: %d\n", ret);
@@ -1078,6 +1195,9 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 err_hal_srng_deinit:
 	ath11k_hal_srng_deinit(ab);
 
+err_release_smp2p_handle:
+	ath11k_ahb_release_smp2p_handle(ab);
+
 err_fw_deinit:
 	ath11k_ahb_fw_resource_deinit(ab);
 
@@ -1116,6 +1236,7 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
 qmi_fail:
 	ath11k_ahb_free_irq(ab);
 	ath11k_hal_srng_deinit(ab);
+	ath11k_ahb_release_smp2p_handle(ab);
 	ath11k_ahb_fw_resource_deinit(ab);
 	ath11k_ce_free_pipes(ab);
 	ath11k_core_free(ab);
diff --git a/drivers/net/wireless/ath/ath11k/ahb.h b/drivers/net/wireless/ath/ath11k/ahb.h
index 58a945411c5b..415ddfd26654 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.h
+++ b/drivers/net/wireless/ath/ath11k/ahb.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef ATH11K_AHB_H
 #define ATH11K_AHB_H
@@ -8,6 +9,16 @@
 #include "core.h"
 
 #define ATH11K_AHB_RECOVERY_TIMEOUT (3 * HZ)
+
+#define ATH11K_AHB_SMP2P_SMEM_MSG		GENMASK(15, 0)
+#define ATH11K_AHB_SMP2P_SMEM_SEQ_NO		GENMASK(31, 16)
+#define ATH11K_AHB_SMP2P_SMEM_VALUE_MASK	0xFFFFFFFF
+
+enum ath11k_ahb_smp2p_msg_id {
+	ATH11K_AHB_POWER_SAVE_ENTER = 1,
+	ATH11K_AHB_POWER_SAVE_EXIT,
+};
+
 struct ath11k_base;
 
 struct ath11k_ahb {
@@ -21,6 +32,11 @@ struct ath11k_ahb {
 		u32 ce_size;
 		bool use_tz;
 	} fw;
+	struct {
+		unsigned short seq_no;
+		unsigned int smem_bit;
+		struct qcom_smem_state *smem_state;
+	} smp2p_info;
 };
 
 static inline struct ath11k_ahb *ath11k_ahb_priv(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c3e9e4f7bc24..dddca4e33205 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -106,6 +106,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -177,6 +178,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -247,6 +249,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -317,6 +320,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -387,6 +391,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -456,6 +461,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -525,6 +531,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = true,
 		.fixed_fw_mem = true,
 		.support_off_channel_tx = false,
+		.smp2p_wow_exit = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index bb5ac940e470..45b83f4d4bb9 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -200,6 +200,7 @@ struct ath11k_hw_params {
 	bool hybrid_bus_type;
 	bool fixed_fw_mem;
 	bool support_off_channel_tx;
+	bool smp2p_wow_exit;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index 1adf20ebef27..5a946814734f 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -731,3 +731,35 @@ int ath11k_pcic_register_pci_ops(struct ath11k_base *ab,
 	return 0;
 }
 EXPORT_SYMBOL(ath11k_pcic_register_pci_ops);
+
+void ath11k_pci_enable_ce_irqs_except_wake_irq(struct ath11k_base *ab)
+{
+	int i;
+
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR ||
+		    i == ATH11K_PCI_CE_WAKE_IRQ)
+			continue;
+		ath11k_pcic_ce_irq_enable(ab, i);
+	}
+}
+
+void ath11k_pci_disable_ce_irqs_except_wake_irq(struct ath11k_base *ab)
+{
+	int i;
+	int irq_idx;
+	struct ath11k_ce_pipe *ce_pipe;
+
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
+		ce_pipe = &ab->ce.ce_pipe[i];
+		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
+
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR ||
+		    i == ATH11K_PCI_CE_WAKE_IRQ)
+			continue;
+
+		disable_irq_nosync(ab->irq_num[irq_idx]);
+		synchronize_irq(ab->irq_num[irq_idx]);
+		tasklet_kill(&ce_pipe->intr_tq);
+	}
+}
diff --git a/drivers/net/wireless/ath/ath11k/pcic.h b/drivers/net/wireless/ath/ath11k/pcic.h
index 0afbb34510db..6f5a9cf766cd 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.h
+++ b/drivers/net/wireless/ath/ath11k/pcic.h
@@ -12,6 +12,8 @@
 #define ATH11K_PCI_IRQ_CE0_OFFSET	3
 #define ATH11K_PCI_IRQ_DP_OFFSET	14
 
+#define ATH11K_PCI_CE_WAKE_IRQ	2
+
 #define ATH11K_PCI_WINDOW_ENABLE_BIT		0x40000000
 #define ATH11K_PCI_WINDOW_REG_ADDRESS		0x310c
 #define ATH11K_PCI_WINDOW_VALUE_MASK		GENMASK(24, 19)
@@ -45,4 +47,6 @@ void ath11k_pcic_ce_irq_disable_sync(struct ath11k_base *ab);
 int ath11k_pcic_init_msi_config(struct ath11k_base *ab);
 int ath11k_pcic_register_pci_ops(struct ath11k_base *ab,
 				 const struct ath11k_pci_ops *pci_ops);
+void ath11k_pci_enable_ce_irqs_except_wake_irq(struct ath11k_base *ab);
+void ath11k_pci_disable_ce_irqs_except_wake_irq(struct ath11k_base *ab);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index b3e65cd13d83..0bf716fb0e70 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/delay.h>
@@ -67,6 +68,13 @@ int ath11k_wow_wakeup(struct ath11k_base *ab)
 	struct ath11k *ar = ath11k_ab_to_ar(ab, 0);
 	int ret;
 
+	/* In the case of WCN6750, WoW wakeup is done
+	 * by sending SMP2P power save exit message
+	 * to the target processor.
+	 */
+	if (ab->hw_params.smp2p_wow_exit)
+		return 0;
+
 	reinit_completion(&ab->wow.wakeup_completed);
 
 	ret = ath11k_wmi_wow_host_wakeup_ind(ar);
-- 
2.37.1

