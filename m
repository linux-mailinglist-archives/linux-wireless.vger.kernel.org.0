Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB751159E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 13:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiD0LWj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 07:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiD0LWi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 07:22:38 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3112F01B;
        Wed, 27 Apr 2022 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651058367; x=1682594367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/jLAc0y5KqpZpIrJWA2S4JW6G9NsR16YypUZs3l3Sk=;
  b=V9bFutmw3SlHJZgcvkuHlzcwms5YT688mLeBFTJNaNrZWmpSwp/BCbNr
   HSLQs1SuZ8qIG03DUTbEgDlZ23Tb1G0/ss13YdyJPUfPlOJMdr9dhGUKX
   JWA6ubASSZThV3km/+ljqS/3HDxR0IOj6e/K0Qz+oXYdbC4z777bKl514
   4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 Apr 2022 04:19:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 04:19:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 04:19:25 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 04:19:23 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <mka@chromium.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v6 7/9] ath11k: HAL changes to support WCN6750
Date:   Wed, 27 Apr 2022 16:48:46 +0530
Message-ID: <20220427111848.9257-8-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427111848.9257-1-quic_mpubbise@quicinc.com>
References: <20220427111848.9257-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add HAL changes required to support WCN6750. Offsets of some registers
for WCN6750 are different from other supported devices; move such
register offsets to platform specific ath11k_hw_regs.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |   2 +
 drivers/net/wireless/ath/ath11k/hal.c  |  15 +--
 drivers/net/wireless/ath/ath11k/hal.h  |  15 +--
 drivers/net/wireless/ath/ath11k/hw.c   | 134 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  10 ++
 5 files changed, 163 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 41f4125d104a..5ee9f1c53a89 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -449,8 +449,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		},
 		.max_radios = 1,
 		.bdf_addr = 0x4B0C0000,
+		.hw_ops = &wcn6750_ops,
 		.ring_mask = &ath11k_hw_ring_mask_qca6390,
 		.internal_sleep_clock = false,
+		.regs = &wcn6750_regs,
 		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_WCN6750,
 		.host_ce_config = ath11k_host_ce_config_qca6390,
 		.ce_count = 9,
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 2ec09ae90080..9a6340d655b7 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/dma-mapping.h>
 #include "hal_tx.h"
@@ -1082,10 +1083,10 @@ static void ath11k_hal_srng_update_hp_tp_addr(struct ath11k_base *ab,
 	srng = &hal->srng_list[ring_id];
 
 	if (srng_config->ring_dir == HAL_SRNG_DIR_DST)
-		srng->u.dst_ring.tp_addr = (u32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
+		srng->u.dst_ring.tp_addr = (u32 *)(HAL_SHADOW_REG(ab, shadow_cfg_idx) +
 						   (unsigned long)ab->mem);
 	else
-		srng->u.src_ring.hp_addr = (u32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
+		srng->u.src_ring.hp_addr = (u32 *)(HAL_SHADOW_REG(ab, shadow_cfg_idx) +
 						   (unsigned long)ab->mem);
 }
 
@@ -1120,7 +1121,7 @@ int ath11k_hal_srng_update_shadow_config(struct ath11k_base *ab,
 	ath11k_dbg(ab, ATH11k_DBG_HAL,
 		   "target_reg %x, shadow reg 0x%x shadow_idx 0x%x, ring_type %d, ring num %d",
 		  target_reg,
-		  HAL_SHADOW_REG(shadow_cfg_idx),
+		  HAL_SHADOW_REG(ab, shadow_cfg_idx),
 		  shadow_cfg_idx,
 		  ring_type, ring_num);
 
@@ -1193,12 +1194,12 @@ static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_TCL_RING_HP(ab);
 
 	s = &hal->srng_config[HAL_REO_REINJECT];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_HP;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_HP(ab);
 
 	s = &hal->srng_config[HAL_REO_CMD];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_HP;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_HP(ab);
 
 	s = &hal->srng_config[HAL_REO_STATUS];
 	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_RING_BASE_LSB(ab);
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index a7d9b4c551ad..6fbda016cd63 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_HAL_H
@@ -31,12 +32,12 @@ struct ath11k_base;
 #define HAL_DSCP_TID_TBL_SIZE			24
 
 /* calculate the register address from bar0 of shadow register x */
-#define HAL_SHADOW_BASE_ADDR			0x000008fc
+#define HAL_SHADOW_BASE_ADDR(ab)		ab->hw_params.regs->hal_shadow_base_addr
 #define HAL_SHADOW_NUM_REGS			36
 #define HAL_HP_OFFSET_IN_REG_START		1
 #define HAL_OFFSET_FROM_HP_TO_TP		4
 
-#define HAL_SHADOW_REG(x) (HAL_SHADOW_BASE_ADDR + (4 * (x)))
+#define HAL_SHADOW_REG(ab, x) (HAL_SHADOW_BASE_ADDR(ab) + (4 * (x)))
 
 /* WCSS Relative address */
 #define HAL_SEQ_WCSS_UMAC_OFFSET		0x00a00000
@@ -180,16 +181,18 @@ struct ath11k_base;
 #define HAL_REO_TCL_RING_HP(ab)			ab->hw_params.regs->hal_reo_tcl_ring_hp
 
 /* REO CMD R0 address */
-#define HAL_REO_CMD_RING_BASE_LSB		0x00000194
+#define HAL_REO_CMD_RING_BASE_LSB(ab) \
+	ab->hw_params.regs->hal_reo_cmd_ring_base_lsb
 
 /* REO CMD R2 address */
-#define HAL_REO_CMD_HP				0x00003020
+#define HAL_REO_CMD_HP(ab)			ab->hw_params.regs->hal_reo_cmd_ring_hp
 
 /* SW2REO R0 address */
-#define HAL_SW2REO_RING_BASE_LSB		0x000001ec
+#define HAL_SW2REO_RING_BASE_LSB(ab) \
+	ab->hw_params.regs->hal_sw2reo_ring_base_lsb
 
 /* SW2REO R2 address */
-#define HAL_SW2REO_RING_HP			0x00003028
+#define HAL_SW2REO_RING_HP(ab)			ab->hw_params.regs->hal_sw2reo_ring_hp
 
 /* CE ring R0 address */
 #define HAL_CE_DST_RING_BASE_LSB		0x00000000
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 46449a18b5cb..fc026969069c 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/types.h>
@@ -1014,6 +1015,13 @@ const struct ath11k_hw_ops wcn6855_ops = {
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_wcn6855_rx_desc_mpdu_start_addr2,
 };
 
+const struct ath11k_hw_ops wcn6750_ops = {
+	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
+	.wmi_init_config = ath11k_init_wmi_config_qca6390,
+	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_qca6390,
+	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_qca6390,
+};
+
 #define ATH11K_TX_RING_MASK_0 0x1
 #define ATH11K_TX_RING_MASK_1 0x2
 #define ATH11K_TX_RING_MASK_2 0x4
@@ -1908,10 +1916,18 @@ const struct ath11k_hw_regs ipq8074_regs = {
 	.hal_reo_tcl_ring_base_lsb = 0x000003fc,
 	.hal_reo_tcl_ring_hp = 0x00003058,
 
+	/* REO CMD ring address */
+	.hal_reo_cmd_ring_base_lsb = 0x00000194,
+	.hal_reo_cmd_ring_hp = 0x00003020,
+
 	/* REO status address */
 	.hal_reo_status_ring_base_lsb = 0x00000504,
 	.hal_reo_status_hp = 0x00003070,
 
+	/* SW2REO ring address */
+	.hal_sw2reo_ring_base_lsb = 0x000001ec,
+	.hal_sw2reo_ring_hp = 0x00003028,
+
 	/* WCSS relative address */
 	.hal_seq_wcss_umac_ce0_src_reg = 0x00a00000,
 	.hal_seq_wcss_umac_ce0_dst_reg = 0x00a01000,
@@ -1932,6 +1948,9 @@ const struct ath11k_hw_regs ipq8074_regs = {
 	/* PCIe base address */
 	.pcie_qserdes_sysclk_en_sel = 0x0,
 	.pcie_pcs_osc_dtct_config_base = 0x0,
+
+	/* Shadow register area */
+	.hal_shadow_base_addr = 0x0,
 };
 
 const struct ath11k_hw_regs qca6390_regs = {
@@ -1979,10 +1998,18 @@ const struct ath11k_hw_regs qca6390_regs = {
 	.hal_reo_tcl_ring_base_lsb = 0x000003a4,
 	.hal_reo_tcl_ring_hp = 0x00003050,
 
+	/* REO CMD ring address */
+	.hal_reo_cmd_ring_base_lsb = 0x00000194,
+	.hal_reo_cmd_ring_hp = 0x00003020,
+
 	/* REO status address */
 	.hal_reo_status_ring_base_lsb = 0x000004ac,
 	.hal_reo_status_hp = 0x00003068,
 
+	/* SW2REO ring address */
+	.hal_sw2reo_ring_base_lsb = 0x000001ec,
+	.hal_sw2reo_ring_hp = 0x00003028,
+
 	/* WCSS relative address */
 	.hal_seq_wcss_umac_ce0_src_reg = 0x00a00000,
 	.hal_seq_wcss_umac_ce0_dst_reg = 0x00a01000,
@@ -2003,6 +2030,9 @@ const struct ath11k_hw_regs qca6390_regs = {
 	/* PCIe base address */
 	.pcie_qserdes_sysclk_en_sel = 0x01e0c0ac,
 	.pcie_pcs_osc_dtct_config_base = 0x01e0c628,
+
+	/* Shadow register area */
+	.hal_shadow_base_addr = 0x000008fc,
 };
 
 const struct ath11k_hw_regs qcn9074_regs = {
@@ -2050,10 +2080,18 @@ const struct ath11k_hw_regs qcn9074_regs = {
 	.hal_reo_tcl_ring_base_lsb = 0x000003fc,
 	.hal_reo_tcl_ring_hp = 0x00003058,
 
+	/* REO CMD ring address */
+	.hal_reo_cmd_ring_base_lsb = 0x00000194,
+	.hal_reo_cmd_ring_hp = 0x00003020,
+
 	/* REO status address */
 	.hal_reo_status_ring_base_lsb = 0x00000504,
 	.hal_reo_status_hp = 0x00003070,
 
+	/* SW2REO ring address */
+	.hal_sw2reo_ring_base_lsb = 0x000001ec,
+	.hal_sw2reo_ring_hp = 0x00003028,
+
 	/* WCSS relative address */
 	.hal_seq_wcss_umac_ce0_src_reg = 0x01b80000,
 	.hal_seq_wcss_umac_ce0_dst_reg = 0x01b81000,
@@ -2074,6 +2112,9 @@ const struct ath11k_hw_regs qcn9074_regs = {
 	/* PCIe base address */
 	.pcie_qserdes_sysclk_en_sel = 0x01e0e0a8,
 	.pcie_pcs_osc_dtct_config_base = 0x01e0f45c,
+
+	/* Shadow register area */
+	.hal_shadow_base_addr = 0x0,
 };
 
 const struct ath11k_hw_regs wcn6855_regs = {
@@ -2121,10 +2162,18 @@ const struct ath11k_hw_regs wcn6855_regs = {
 	.hal_reo_tcl_ring_base_lsb = 0x00000454,
 	.hal_reo_tcl_ring_hp = 0x00003060,
 
+	/* REO CMD ring address */
+	.hal_reo_cmd_ring_base_lsb = 0x00000194,
+	.hal_reo_cmd_ring_hp = 0x00003020,
+
 	/* REO status address */
 	.hal_reo_status_ring_base_lsb = 0x0000055c,
 	.hal_reo_status_hp = 0x00003078,
 
+	/* SW2REO ring address */
+	.hal_sw2reo_ring_base_lsb = 0x000001ec,
+	.hal_sw2reo_ring_hp = 0x00003028,
+
 	/* WCSS relative address */
 	.hal_seq_wcss_umac_ce0_src_reg = 0x1b80000,
 	.hal_seq_wcss_umac_ce0_dst_reg = 0x1b81000,
@@ -2145,6 +2194,91 @@ const struct ath11k_hw_regs wcn6855_regs = {
 	/* PCIe base address */
 	.pcie_qserdes_sysclk_en_sel = 0x01e0c0ac,
 	.pcie_pcs_osc_dtct_config_base = 0x01e0c628,
+
+	/* Shadow register area */
+	.hal_shadow_base_addr = 0x000008fc,
+};
+
+const struct ath11k_hw_regs wcn6750_regs = {
+	/* SW2TCL(x) R0 ring configuration address */
+	.hal_tcl1_ring_base_lsb = 0x00000694,
+	.hal_tcl1_ring_base_msb = 0x00000698,
+	.hal_tcl1_ring_id = 0x0000069c,
+	.hal_tcl1_ring_misc = 0x000006a4,
+	.hal_tcl1_ring_tp_addr_lsb = 0x000006b0,
+	.hal_tcl1_ring_tp_addr_msb = 0x000006b4,
+	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x000006c4,
+	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x000006c8,
+	.hal_tcl1_ring_msi1_base_lsb = 0x000006dc,
+	.hal_tcl1_ring_msi1_base_msb = 0x000006e0,
+	.hal_tcl1_ring_msi1_data = 0x000006e4,
+	.hal_tcl2_ring_base_lsb = 0x000006ec,
+	.hal_tcl_ring_base_lsb = 0x0000079c,
+
+	/* TCL STATUS ring address */
+	.hal_tcl_status_ring_base_lsb = 0x000008a4,
+
+	/* REO2SW(x) R0 ring configuration address */
+	.hal_reo1_ring_base_lsb = 0x000001ec,
+	.hal_reo1_ring_base_msb = 0x000001f0,
+	.hal_reo1_ring_id = 0x000001f4,
+	.hal_reo1_ring_misc = 0x000001fc,
+	.hal_reo1_ring_hp_addr_lsb = 0x00000200,
+	.hal_reo1_ring_hp_addr_msb = 0x00000204,
+	.hal_reo1_ring_producer_int_setup = 0x00000210,
+	.hal_reo1_ring_msi1_base_lsb = 0x00000234,
+	.hal_reo1_ring_msi1_base_msb = 0x00000238,
+	.hal_reo1_ring_msi1_data = 0x0000023c,
+	.hal_reo2_ring_base_lsb = 0x00000244,
+	.hal_reo1_aging_thresh_ix_0 = 0x00000564,
+	.hal_reo1_aging_thresh_ix_1 = 0x00000568,
+	.hal_reo1_aging_thresh_ix_2 = 0x0000056c,
+	.hal_reo1_aging_thresh_ix_3 = 0x00000570,
+
+	/* REO2SW(x) R2 ring pointers (head/tail) address */
+	.hal_reo1_ring_hp = 0x00003028,
+	.hal_reo1_ring_tp = 0x0000302c,
+	.hal_reo2_ring_hp = 0x00003030,
+
+	/* REO2TCL R0 ring configuration address */
+	.hal_reo_tcl_ring_base_lsb = 0x000003fc,
+	.hal_reo_tcl_ring_hp = 0x00003058,
+
+	/* REO CMD ring address */
+	.hal_reo_cmd_ring_base_lsb = 0x000000e4,
+	.hal_reo_cmd_ring_hp = 0x00003010,
+
+	/* REO status address */
+	.hal_reo_status_ring_base_lsb = 0x00000504,
+	.hal_reo_status_hp = 0x00003070,
+
+	/* SW2REO ring address */
+	.hal_sw2reo_ring_base_lsb = 0x0000013c,
+	.hal_sw2reo_ring_hp = 0x00003018,
+
+	/* WCSS relative address */
+	.hal_seq_wcss_umac_ce0_src_reg = 0x01b80000,
+	.hal_seq_wcss_umac_ce0_dst_reg = 0x01b81000,
+	.hal_seq_wcss_umac_ce1_src_reg = 0x01b82000,
+	.hal_seq_wcss_umac_ce1_dst_reg = 0x01b83000,
+
+	/* WBM Idle address */
+	.hal_wbm_idle_link_ring_base_lsb = 0x00000874,
+	.hal_wbm_idle_link_ring_misc = 0x00000884,
+
+	/* SW2WBM release address */
+	.hal_wbm_release_ring_base_lsb = 0x000001ec,
+
+	/* WBM2SW release address */
+	.hal_wbm0_release_ring_base_lsb = 0x00000924,
+	.hal_wbm1_release_ring_base_lsb = 0x0000097c,
+
+	/* PCIe base address */
+	.pcie_qserdes_sysclk_en_sel = 0x0,
+	.pcie_pcs_osc_dtct_config_base = 0x0,
+
+	/* Shadow register area */
+	.hal_shadow_base_addr = 0x00000504,
 };
 
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074 = {
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index c2ee39f977c2..f91009ef60b7 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -246,6 +246,7 @@ extern const struct ath11k_hw_ops ipq6018_ops;
 extern const struct ath11k_hw_ops qca6390_ops;
 extern const struct ath11k_hw_ops qcn9074_ops;
 extern const struct ath11k_hw_ops wcn6855_ops;
+extern const struct ath11k_hw_ops wcn6750_ops;
 
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390;
@@ -348,6 +349,12 @@ struct ath11k_hw_regs {
 	u32 hal_reo_status_ring_base_lsb;
 	u32 hal_reo_status_hp;
 
+	u32 hal_reo_cmd_ring_base_lsb;
+	u32 hal_reo_cmd_ring_hp;
+
+	u32 hal_sw2reo_ring_base_lsb;
+	u32 hal_sw2reo_ring_hp;
+
 	u32 hal_seq_wcss_umac_ce0_src_reg;
 	u32 hal_seq_wcss_umac_ce0_dst_reg;
 	u32 hal_seq_wcss_umac_ce1_src_reg;
@@ -363,12 +370,15 @@ struct ath11k_hw_regs {
 
 	u32 pcie_qserdes_sysclk_en_sel;
 	u32 pcie_pcs_osc_dtct_config_base;
+
+	u32 hal_shadow_base_addr;
 };
 
 extern const struct ath11k_hw_regs ipq8074_regs;
 extern const struct ath11k_hw_regs qca6390_regs;
 extern const struct ath11k_hw_regs qcn9074_regs;
 extern const struct ath11k_hw_regs wcn6855_regs;
+extern const struct ath11k_hw_regs wcn6750_regs;
 
 static inline const char *ath11k_bd_ie_type_str(enum ath11k_bd_ie_type type)
 {
-- 
2.35.1

