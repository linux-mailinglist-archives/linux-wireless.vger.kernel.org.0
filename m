Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180D55AADB3
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiIBLbr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 07:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiIBLbW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 07:31:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE7205FB;
        Fri,  2 Sep 2022 04:28:19 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2828wFZF008776;
        Fri, 2 Sep 2022 11:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=654GjtN907eNiRSiLFyv0PBgJDFQFE8puXG/WxUad0Q=;
 b=lHO+0UTs0HCIrWAmfZCX/y5H2+a3aGdZpGvb12tEgAP3BscxRQZNLWoMN9E0XpUxEdFE
 F96hBEO2SPyOq7Bz0ZZPadO7M8Q8a8bClN56iiAIg8zvg+4B6TUbb8p2x8npWz7KBqVW
 eQfnsThLFarSZdt0KoFZLMT0ekFsAxy4gHQMFoTcl1ZrIDrqPijLmrOdZMoObYoERtar
 4YaYGz9Tm915q0z0HaHPJBeYUtGUSoXGuqvcwkd6hSbyQgQvpRQboD0I5bkHv07pJkY7
 evxxP23SZe3sqDnnxGbzS8zEtPfgz6f0tZ0ewR1vSQIAm1pRBD7aJX7JMOqn6SQTMthr NQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jbafy9738-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 11:28:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 282BS5R4031023
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 11:28:05 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 2 Sep 2022 04:28:03 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Manikanta Pubbisetty" <quic_mpubbise@quicinc.com>
Subject: [PATCH v3 2/2] ath11k: Add WoW support for WCN6750
Date:   Fri, 2 Sep 2022 16:55:20 +0530
Message-ID: <20220902112520.24804-3-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902112520.24804-1-quic_mpubbise@quicinc.com>
References: <20220902112520.24804-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Nesm0PEf1oqqikLKcIqHSVkzq41rdEVX
X-Proofpoint-GUID: Nesm0PEf1oqqikLKcIqHSVkzq41rdEVX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 clxscore=1015 mlxscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020055
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

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

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
index 29c40c6be5df..d131416836d9 100644
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
@@ -686,6 +688,84 @@ static int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id
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
@@ -710,6 +790,10 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops_wcn6750 = {
 	.map_service_to_pipe = ath11k_pcic_map_service_to_pipe,
 	.power_down = ath11k_ahb_power_down,
 	.power_up = ath11k_ahb_power_up,
+	.suspend = ath11k_ahb_hif_suspend,
+	.resume = ath11k_ahb_hif_resume,
+	.ce_irq_enable = ath11k_pci_enable_ce_irqs_except_wake_irq,
+	.ce_irq_disable = ath11k_pci_disable_ce_irqs_except_wake_irq,
 };
 
 static int ath11k_core_get_rproc(struct ath11k_base *ab)
@@ -784,6 +868,35 @@ static int ath11k_ahb_setup_msi_resources(struct ath11k_base *ab)
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
@@ -1039,10 +1152,14 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
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
@@ -1079,6 +1196,9 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 err_hal_srng_deinit:
 	ath11k_hal_srng_deinit(ab);
 
+err_release_smp2p_handle:
+	ath11k_ahb_release_smp2p_handle(ab);
+
 err_fw_deinit:
 	ath11k_ahb_fw_resource_deinit(ab);
 
@@ -1111,6 +1231,7 @@ static void ath11k_ahb_free_resources(struct ath11k_base *ab)
 
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
index 0f5ae370a727..f10d09404925 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -107,6 +107,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -179,6 +180,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -250,6 +252,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -321,6 +324,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -392,6 +396,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -462,6 +467,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.smp2p_wow_exit = false,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -532,6 +538,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = true,
 		.fixed_fw_mem = true,
 		.support_off_channel_tx = false,
+		.smp2p_wow_exit = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 05e93ebd758c..020f86546185 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -201,6 +201,7 @@ struct ath11k_hw_params {
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

