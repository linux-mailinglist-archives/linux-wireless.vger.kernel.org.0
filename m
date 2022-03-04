Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580FF4CD347
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 12:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiCDLWa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 06:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbiCDLW3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 06:22:29 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE31B0BC6
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 03:21:42 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nQ60B-000QSW-P4;
        Fri, 04 Mar 2022 13:21:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Mar 2022 13:21:22 +0200
Message-Id: <iwlwifi.20220304131517.0b96b2760503.I08bc741c8c497a2edbe4784cdab6abd8d04c62f3@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304112129.219513-1-luca@coelho.fi>
References: <20220304112129.219513-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 06/13] iwlwifi: mvm: add support for IMR based on platform
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Driver needs to enable IMR which is needed for debug on
certain platforms, so add a device config flag to set it.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c    | 15 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h   |  5 ++++-
 .../intel/iwlwifi/iwl-context-info-gen3.h         |  4 +++-
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c  |  5 ++++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c     |  3 ++-
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index a0c777914e38..8afd5e16e5d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -391,6 +391,21 @@ const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
+const struct iwl_cfg_trans_params iwl_so_long_latency_imr_trans_cfg = {
+	.mq_rx_supported = true,
+	.use_tfh = true,
+	.rf_id = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_AX210,
+	.base_params = &iwl_ax210_base_params,
+	.umac_prph_offset = 0x300000,
+	.integrated = true,
+	.low_latency_xtal = true,
+	.xtal_latency = 12000,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
+	.imr_enabled = true,
+};
+
 /*
  * If the device doesn't support HE, no need to have that many buffers.
  * 22000 devices can split multiple frames into a single RB, so fewer are
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index b7e430ad5e2a..f5b556a103e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -260,6 +260,7 @@ enum iwl_cfg_trans_ltr_delay {
  * @integrated: discrete or integrated
  * @low_latency_xtal: use the low latency xtal if supported
  * @ltr_delay: LTR delay parameter, &enum iwl_cfg_trans_ltr_delay.
+ * @imr_enabled: use the IMR if supported.
  */
 struct iwl_cfg_trans_params {
 	const struct iwl_base_params *base_params;
@@ -274,7 +275,8 @@ struct iwl_cfg_trans_params {
 	    integrated:1,
 	    low_latency_xtal:1,
 	    bisr_workaround:1,
-	    ltr_delay:2;
+	    ltr_delay:2,
+	    imr_enabled:1;
 };
 
 /**
@@ -491,6 +493,7 @@ extern const struct iwl_cfg_trans_params iwl_ax200_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_snj_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_so_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_so_long_latency_imr_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ma_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_bz_trans_cfg;
 extern const char iwl9162_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 5adf485db38e..b84884034c74 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018, 2020-2021 Intel Corporation
+ * Copyright (C) 2018, 2020-2022 Intel Corporation
  */
 #ifndef __iwl_context_info_file_gen3_h__
 #define __iwl_context_info_file_gen3_h__
@@ -34,6 +34,7 @@ enum iwl_prph_scratch_mtr_format {
 
 /**
  * enum iwl_prph_scratch_flags - PRPH scratch control flags
+ * @IWL_PRPH_SCRATCH_IMR_DEBUG_EN: IMR support for debug
  * @IWL_PRPH_SCRATCH_EARLY_DEBUG_EN: enable early debug conf
  * @IWL_PRPH_SCRATCH_EDBG_DEST_DRAM: use DRAM, with size allocated
  *	in hwm config.
@@ -55,6 +56,7 @@ enum iwl_prph_scratch_mtr_format {
  * @IWL_PRPH_SCRATCH_RB_SIZE_EXT_16K: 16kB RB size
  */
 enum iwl_prph_scratch_flags {
+	IWL_PRPH_SCRATCH_IMR_DEBUG_EN		= BIT(1),
 	IWL_PRPH_SCRATCH_EARLY_DEBUG_EN		= BIT(4),
 	IWL_PRPH_SCRATCH_EDBG_DEST_DRAM		= BIT(8),
 	IWL_PRPH_SCRATCH_EDBG_DEST_INTERNAL	= BIT(9),
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 85a6da70ca78..75fd386b048e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-fh.h"
@@ -125,6 +125,9 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	control_flags |= IWL_PRPH_SCRATCH_MTR_MODE;
 	control_flags |= IWL_PRPH_MTR_FORMAT_256B & IWL_PRPH_SCRATCH_MTR_FORMAT;
 
+	if (trans->trans_cfg->imr_enabled)
+		control_flags |= IWL_PRPH_SCRATCH_IMR_DEBUG_EN;
+
 	/* initialize RX default queue */
 	prph_sc_ctrl->rbd_cfg.free_rbd_addr =
 		cpu_to_le64(trans_pcie->rxq->bd_dma);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 58a7111d4f40..b16d4ae182d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -491,9 +491,10 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 /* So devices */
 	{IWL_PCI_DEVICE(0x2725, PCI_ANY_ID, iwl_so_trans_cfg)},
 	{IWL_PCI_DEVICE(0x2726, PCI_ANY_ID, iwl_snj_trans_cfg)},
-	{IWL_PCI_DEVICE(0x7A70, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
+	{IWL_PCI_DEVICE(0x7A70, PCI_ANY_ID, iwl_so_long_latency_imr_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7AF0, PCI_ANY_ID, iwl_so_trans_cfg)},
 	{IWL_PCI_DEVICE(0x51F0, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
+	{IWL_PCI_DEVICE(0x51F1, PCI_ANY_ID, iwl_so_long_latency_imr_trans_cfg)},
 	{IWL_PCI_DEVICE(0x54F0, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7F70, PCI_ANY_ID, iwl_so_trans_cfg)},
 
-- 
2.35.1

