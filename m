Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D1C34A58F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 11:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhCZKap (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 06:30:45 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43304 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230063AbhCZKam (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 06:30:42 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lPjjh-0003EY-Hh; Fri, 26 Mar 2021 12:30:39 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Mar 2021 12:30:30 +0200
Message-Id: <20210326103035.206088-3-luca@coelho.fi>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326103035.206088-1-luca@coelho.fi>
References: <20210326103035.206088-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH for v5.12 2/7] iwlwifi: pcie: properly set LTR workarounds on 22000 devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

As the context info gen3 code is only called for >=AX210 devices
(from iwl_trans_pcie_gen2_start_fw()) the code there to set LTR
on 22000 devices cannot actually do anything (22000 < AX210).

Fix this by moving the LTR code to iwl_trans_pcie_gen2_start_fw()
where it can handle both devices. This then requires that we kick
the firmware only after that rather than doing it from the context
info code.

Note that this again had a dead branch in gen3 code, which I've
removed here.

Change-Id: Ib61463aba6920645059e366dcdca4c4c77f0ff58
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: ed0022da8bd9 ("iwlwifi: pcie: set LTR on more devices")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 31 +---------------
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  3 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 35 +++++++++++++++++++
 3 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 8fba190e84cf..cecc32e7dbe8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-fh.h"
@@ -75,15 +75,6 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 				 const struct fw_img *fw)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	u32 ltr_val = CSR_LTR_LONG_VAL_AD_NO_SNOOP_REQ |
-		      u32_encode_bits(CSR_LTR_LONG_VAL_AD_SCALE_USEC,
-				      CSR_LTR_LONG_VAL_AD_NO_SNOOP_SCALE) |
-		      u32_encode_bits(250,
-				      CSR_LTR_LONG_VAL_AD_NO_SNOOP_VAL) |
-		      CSR_LTR_LONG_VAL_AD_SNOOP_REQ |
-		      u32_encode_bits(CSR_LTR_LONG_VAL_AD_SCALE_USEC,
-				      CSR_LTR_LONG_VAL_AD_SNOOP_SCALE) |
-		      u32_encode_bits(250, CSR_LTR_LONG_VAL_AD_SNOOP_VAL);
 	struct iwl_context_info_gen3 *ctxt_info_gen3;
 	struct iwl_prph_scratch *prph_scratch;
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl;
@@ -217,26 +208,6 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	iwl_set_bit(trans, CSR_CTXT_INFO_BOOT_CTRL,
 		    CSR_AUTO_FUNC_BOOT_ENA);
 
-	/*
-	 * To workaround hardware latency issues during the boot process,
-	 * initialize the LTR to ~250 usec (see ltr_val above).
-	 * The firmware initializes this again later (to a smaller value).
-	 */
-	if ((trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210 ||
-	     trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000) &&
-	    !trans->trans_cfg->integrated) {
-		iwl_write32(trans, CSR_LTR_LONG_VAL_AD, ltr_val);
-	} else if (trans->trans_cfg->integrated &&
-		   trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000) {
-		iwl_write_prph(trans, HPM_MAC_LTR_CSR, HPM_MAC_LRT_ENABLE_ALL);
-		iwl_write_prph(trans, HPM_UMAC_LTR, ltr_val);
-	}
-
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		iwl_write_umac_prph(trans, UREG_CPU_INIT_RUN, 1);
-	else
-		iwl_set_bit(trans, CSR_GP_CNTRL, CSR_AUTO_FUNC_INIT);
-
 	return 0;
 
 err_free_ctxt_info:
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index d1bb273d6b6d..74ce31fdf45e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-fh.h"
@@ -240,7 +240,6 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 
 	/* kick FW self load */
 	iwl_write64(trans, CSR_CTXT_INFO_BA, trans_pcie->ctxt_info_dma_addr);
-	iwl_write_prph(trans, UREG_CPU_INIT_RUN, 1);
 
 	/* Context info will be released upon alive or failure to get one */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 497ef3405da3..94ffc1ae484d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -266,6 +266,34 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans, u32 scd_addr)
 	mutex_unlock(&trans_pcie->mutex);
 }
 
+static void iwl_pcie_set_ltr(struct iwl_trans *trans)
+{
+	u32 ltr_val = CSR_LTR_LONG_VAL_AD_NO_SNOOP_REQ |
+		      u32_encode_bits(CSR_LTR_LONG_VAL_AD_SCALE_USEC,
+				      CSR_LTR_LONG_VAL_AD_NO_SNOOP_SCALE) |
+		      u32_encode_bits(250,
+				      CSR_LTR_LONG_VAL_AD_NO_SNOOP_VAL) |
+		      CSR_LTR_LONG_VAL_AD_SNOOP_REQ |
+		      u32_encode_bits(CSR_LTR_LONG_VAL_AD_SCALE_USEC,
+				      CSR_LTR_LONG_VAL_AD_SNOOP_SCALE) |
+		      u32_encode_bits(250, CSR_LTR_LONG_VAL_AD_SNOOP_VAL);
+
+	/*
+	 * To workaround hardware latency issues during the boot process,
+	 * initialize the LTR to ~250 usec (see ltr_val above).
+	 * The firmware initializes this again later (to a smaller value).
+	 */
+	if ((trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210 ||
+	     trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000) &&
+	    !trans->trans_cfg->integrated) {
+		iwl_write32(trans, CSR_LTR_LONG_VAL_AD, ltr_val);
+	} else if (trans->trans_cfg->integrated &&
+		   trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000) {
+		iwl_write_prph(trans, HPM_MAC_LTR_CSR, HPM_MAC_LRT_ENABLE_ALL);
+		iwl_write_prph(trans, HPM_UMAC_LTR, ltr_val);
+	}
+}
+
 int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 				 const struct fw_img *fw, bool run_in_rfkill)
 {
@@ -332,6 +360,13 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 	if (ret)
 		goto out;
 
+	iwl_pcie_set_ltr(trans);
+
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		iwl_write_umac_prph(trans, UREG_CPU_INIT_RUN, 1);
+	else
+		iwl_write_prph(trans, UREG_CPU_INIT_RUN, 1);
+
 	/* re-check RF-Kill state since we may have missed the interrupt */
 	hw_rfkill = iwl_pcie_check_hw_rf_kill(trans);
 	if (hw_rfkill && !run_in_rfkill)
-- 
2.31.0

