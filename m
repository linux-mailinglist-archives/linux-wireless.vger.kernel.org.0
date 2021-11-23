Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA3945ABC3
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 19:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhKWSzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 13:55:21 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:15076 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237126AbhKWSzT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 13:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637693531; x=1669229531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=I+4IrKmWrYbEu0wW5m57Q0EuqyUDUHqP8/ckY9GIOG0=;
  b=Ps1Qqr7eLnuz/sfZWbF8r1DX66LXs2azIyYGkBFUI1j5RE5rc6mH7j8I
   oP8Zgv8YIquIYKFGJA6KSKCN3ZJP+P1gbbzm+L74IwJzGqlqLO7P8jzSv
   vZQOWcYMtNPOWBU3gCnawWKiAQHt7SeuzpoboMAuVxQfFmUsPPPZu0kxW
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Nov 2021 10:52:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 10:52:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:43 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:40 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 11/19] ath11k: HAL changes to support WCN6750
Date:   Wed, 24 Nov 2021 00:20:26 +0530
Message-ID: <1637693434-15462-12-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add HAL changes required to support WCN6750. Offsets of some registers
for WCN6750 are different from other supported devices; move such
register offsets to platform specific ath11k_hw_regs.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |   2 +
 drivers/net/wireless/ath/ath11k/hal.c  |  15 ++--
 drivers/net/wireless/ath/ath11k/hal.h  |  15 ++--
 drivers/net/wireless/ath/ath11k/hw.c   | 134 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  11 +++
 5 files changed, 164 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index a65a4f3..63fcbc3 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -310,8 +310,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
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
index 7cf9e23..1269018 100644
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
@@ -1081,10 +1082,10 @@ static void ath11k_hal_srng_update_hp_tp_addr(struct ath11k_base *ab,
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
 
@@ -1119,7 +1120,7 @@ int ath11k_hal_srng_update_shadow_config(struct ath11k_base *ab,
 	ath11k_dbg(ab, ATH11k_DBG_HAL,
 		   "target_reg %x, shadow reg 0x%x shadow_idx 0x%x, ring_type %d, ring num %d",
 		  target_reg,
-		  HAL_SHADOW_REG(shadow_cfg_idx),
+		  HAL_SHADOW_REG(ab, shadow_cfg_idx),
 		  shadow_cfg_idx,
 		  ring_type, ring_num);
 
@@ -1192,12 +1193,12 @@ static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
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
index 0f4f9ce..b5be323 100644
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
index 2f0b526..3cef5e6 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/types.h>
@@ -991,6 +992,13 @@ const struct ath11k_hw_ops wcn6855_ops = {
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
@@ -1885,10 +1893,18 @@ const struct ath11k_hw_regs ipq8074_regs = {
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
@@ -1909,6 +1925,9 @@ const struct ath11k_hw_regs ipq8074_regs = {
 	/* PCIe base address */
 	.pcie_qserdes_sysclk_en_sel = 0x0,
 	.pcie_pcs_osc_dtct_config_base = 0x0,
+
+	/* Shadow register area */
+	.hal_shadow_base_addr = 0x0,
 };
 
 const struct ath11k_hw_regs qca6390_regs = {
@@ -1956,10 +1975,18 @@ const struct ath11k_hw_regs qca6390_regs = {
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
@@ -1980,6 +2007,9 @@ const struct ath11k_hw_regs qca6390_regs = {
 	/* PCIe base address */
 	.pcie_qserdes_sysclk_en_sel = 0x01e0c0ac,
 	.pcie_pcs_osc_dtct_config_base = 0x01e0c628,
+
+	/* Shadow register area */
+	.hal_shadow_base_addr = 0x000008fc,
 };
 
 const struct ath11k_hw_regs qcn9074_regs = {
@@ -2027,10 +2057,18 @@ const struct ath11k_hw_regs qcn9074_regs = {
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
@@ -2051,6 +2089,9 @@ const struct ath11k_hw_regs qcn9074_regs = {
 	/* PCIe base address */
 	.pcie_qserdes_sysclk_en_sel = 0x01e0e0a8,
 	.pcie_pcs_osc_dtct_config_base = 0x01e0f45c,
+
+	/* Shadow register area */
+	.hal_shadow_base_addr = 0x0,
 };
 
 const struct ath11k_hw_regs wcn6855_regs = {
@@ -2098,10 +2139,18 @@ const struct ath11k_hw_regs wcn6855_regs = {
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
@@ -2122,6 +2171,91 @@ const struct ath11k_hw_regs wcn6855_regs = {
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
index dd2202f..a4067e7 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_HW_H
@@ -228,6 +229,7 @@ extern const struct ath11k_hw_ops ipq6018_ops;
 extern const struct ath11k_hw_ops qca6390_ops;
 extern const struct ath11k_hw_ops qcn9074_ops;
 extern const struct ath11k_hw_ops wcn6855_ops;
+extern const struct ath11k_hw_ops wcn6750_ops;
 
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390;
@@ -324,6 +326,12 @@ struct ath11k_hw_regs {
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
@@ -339,11 +347,14 @@ struct ath11k_hw_regs {
 
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
 
 #endif
-- 
2.7.4

